https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
# Your name:
# Your student id:
# Your email address:

.data
# output messages
initMsgA: .asciiz "Please enter integers in array A[] one by one, use [Enter] to split:\n"
EnterNumberMsgA1: 	.asciiz "A["
EnterNumberMsgA2: 	.asciiz "]: "

OutputMsgB: .asciiz "Here is the 3-Cumulative Sum result:\n"
space: .asciiz" "
newLine: .asciiz"\n"

# array A[] has 10 elements, array B[] has 10 elements, each element is of the size of one word, 32 bits.
# we could change the size of A[] and B[] when we mark. The size values will be in b_size, a_size below
A: .word 0:10
B: .word 0:10


# size: the number of elements in arrays A[] and B[]
# we could change the size of A[] and B[] when we mark. The size values will be in b_size, a_size below
a_size: .word 10
b_size: .word 10


.text
.globl main
main:
	# $s0,$s1 : base address,size of A
	# $s4,$s5 : base address,size of B
	la $s0,A        #$s0 base address of array A[]
	la $s1,a_size
	lw $s1,0($s1)   #$s1 size of array A[]

   	la $s4,B        #$s4 base address of array B[]
	la $s5,b_size
	lw $s5,0($s5)   #$s5 size of array B[]
	
    	# cout << "Please enter integers in array A[] one by one, use [Enter] to split:"<<endl;
	la $a0, initMsgA
	addi $v0, $zero, 4
	syscall
	
	li $t9,0  # iterator i for printing A
	
	input_arrayA:
	beq $t9,$s1,exit_inputA
	
	# cout << "A["
	la $a0, EnterNumberMsgA1
	addi $v0, $zero, 4
	syscall
	
	# print index
	move $a0,$t9
	addi $v0, $zero, 1
	syscall
	
	# cout << "]: "
	la $a0, EnterNumberMsgA2
	addi $v0, $zero, 4
	syscall
	
	# read user input in $v0
	li $v0, 5
	syscall
	
	sll $t1,$t9,2
	add $t1,$t1,$s0 # $t1 = i*4 + base of A in $s0, addr of A[i]
	sw $v0, 0($t1)  # A[i] = $v0
	addi $t9,$t9,1
	j input_arrayA
	
	exit_inputA:
	add $a0,$s5,$zero #copy B_size to $a0 to be passed to CumulativeSum function.
	#Different than the CumulativeSum function in the C++ program
	#The CumulativeSum function here assumes the following:
	# 1. base addr of A[] is in $s0
	# 2. base addr of B[] is in $s4
	# so the base address of A[] and B[] are not passed
	
	jal CumulativeSum

    	# cout << "Here is the 3-Cumulative Sum result:" << endl;
	la $a0, OutputMsgB
	addi $v0, $zero, 4
	syscall

	li $t9,0  # iterator i for printing Result

	print_result:
	beq $t9,$s5,exit_print

	# print B[i]
	sll $t1,$t9,2
	add $t1,$t1,$s4 # $t1 = i*4 + base of Result in $s4, addr of B[i]
	lw $a0, 0($t1)  # $v0 = B[i]
	addi $v0, $zero, 1
	syscall
	la $a0, space
	addi $v0, $zero, 4
	syscall				# cout << B[i] << ' ';

	addi $t9,$t9,1  # i++
	j print_result
	
	exit_print:
	
	li $v0, 10 
	syscall	
	
#CumulativeSum() procedure
# This function does the same thing as the function CumulativeSum() in the C++ program
# This function assumes the following:
# 1. base addr of A[] is in $s0
# 2. base addr of B[] is in $s4
# so different than the C++ program, base addresses of A[] and B[] are not passed
#
# Only one argument is passed: 
# B_SIZE: $a0
#<Preserve registers according to the MIPS register convention on slide 76 of the ISA note set>
CumulativeSum:
	#TODO Below



	#TODO Above
	jr $ra
