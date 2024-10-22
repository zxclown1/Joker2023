#!/bin/bash

declare -a arr=(
	"java -jar build/libs/fuzzer-parse-step3.jar -c com.alibaba.fastjson2.JSON -m \"parse(java.lang.String)\" -cp lib/fastjson2-2.0.38.jar"
	"java -jar build/libs/fuzzer-timsort.jar -c me.markoutte.examples.TimSort -m \"timSort(int[])\""
	"java -jar build/libs/fuzzer-rotate.jar -c com.google.common.primitives.Ints -m \"rotate(int[],int,int,int)\" -cp lib/guava-32.1.1-jre.jar"
);

let j=0;
for command in "${arr[@]}"
do
	echo "Starting random search for $j";
	for i in $(seq 1 100)
	do
		seed="$RANDOM";
		cmd="$command -s $seed -d stress/$j/$seed -t 1";
		echo "=======Seed $seed======="  & (bash -c "$cmd" | grep "Errors found");
	done
	let j++;
done

