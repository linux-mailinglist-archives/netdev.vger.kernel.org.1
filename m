Return-Path: <netdev+bounces-33265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB679D395
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0A41C203B7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62318B02;
	Tue, 12 Sep 2023 14:28:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F02418B00
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:28:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56859118
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694528935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVYH7+l3ucGvXHJDiPsTtf4nV4RX5RqisdLBLe/uLtQ=;
	b=ayg+u29C3Y0EdeLiM9aD5W7Uwk0qKWj2Bk4r//8PMEdz8dC/GJTiwuOcIUkNtr6VqTYgil
	4i0vF5d3rrHBf3R+Z3nQqbt0ugIZBJUW6Rm6DhRdhhh7+4RtBl4DWie0d328h5HajENCPg
	ipGXpbu7Op852JOMDx8NVfHpuPqaYG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-nfqsWJgROLmVFMG4kVG-uA-1; Tue, 12 Sep 2023 10:28:52 -0400
X-MC-Unique: nfqsWJgROLmVFMG4kVG-uA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75EFE29AB417;
	Tue, 12 Sep 2023 14:28:51 +0000 (UTC)
Received: from dmendes-thinkpadt14sgen2i.remote.csb (unknown [10.22.18.54])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B8C1F7B62;
	Tue, 12 Sep 2023 14:28:50 +0000 (UTC)
From: Daniel Mendes <dmendes@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 1/2] kselftest: rtnetlink.sh: add verbose flag
Date: Tue, 12 Sep 2023 10:28:35 -0400
Message-ID: <4d538efc4efa01ef9b773f522d9b76c3da796e49.1694527251.git.dmendes@redhat.com>
In-Reply-To: <cover.1694527251.git.dmendes@redhat.com>
References: <cover.1694527251.git.dmendes@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

Uses a run_cmd helper function similar to other selftests to add
verbose functionality i.e. print executed commands and their outputs

Many commands silence or redirect output. This can be removed since
the verbose helper function captures output anyway and only outputs it
if VERBOSE is true. Similarly, the helper command for pipes to grep
searches stderr and stdout. This makes output redirection unnecessary
in those cases.

Signed-off-by: Daniel Mendes <dmendes@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 962 +++++++++--------------
 1 file changed, 381 insertions(+), 581 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 488f4964365e..daaf1bcc10ac 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -31,6 +31,7 @@ ALL_TESTS="
 "
 
 devdummy="test-dummy0"
+VERBOSE=0
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
@@ -51,35 +52,91 @@ check_fail()
 	fi
 }
 
+run_cmd_common()
+{
+	local cmd="$*"
+	local out
+	if [ "$VERBOSE" = "1" ]; then
+		echo "COMMAND: ${cmd}"
+	fi
+	out=$($cmd 2>&1)
+	rc=$?
+	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
+		echo "    $out"
+	fi
+	return $rc
+}
+
+run_cmd() {
+	run_cmd_common "$@"
+	rc=$?
+	check_err $rc
+	return $rc
+}
+run_cmd_fail()
+{
+	run_cmd_common "$@"
+	rc=$?
+	check_fail $rc
+	return $rc
+}
+
+run_cmd_grep_common()
+{
+	local find="$1"; shift
+	local cmd="$*"
+	local out
+	if [ "$VERBOSE" = "1" ]; then
+		echo "COMMAND: ${cmd} 2>&1 | grep -q '${find}'"
+	fi
+	out=$($cmd 2>&1 | grep -q "${find}" 2>&1)
+	return $?
+}
+
+run_cmd_grep() {
+	run_cmd_grep_common "$@"
+	rc=$?
+	check_err $rc
+	return $rc
+}
+
+run_cmd_grep_fail()
+{
+	run_cmd_grep_common "$@"
+	rc=$?
+	check_fail $rc
+	return $rc
+}
+
+end_test()
+{
+	echo "$*"
+	[ "${VERBOSE}" = "1" ] && echo
+}
+
+
 kci_add_dummy()
 {
-	ip link add name "$devdummy" type dummy
-	check_err $?
-	ip link set "$devdummy" up
-	check_err $?
+	run_cmd ip link add name "$devdummy" type dummy
+	run_cmd ip link set "$devdummy" up
 }
 
 kci_del_dummy()
 {
-	ip link del dev "$devdummy"
-	check_err $?
+	run_cmd ip link del dev "$devdummy"
 }
 
 kci_test_netconf()
 {
 	dev="$1"
 	r=$ret
-
-	ip netconf show dev "$dev" > /dev/null
-	check_err $?
-
+	run_cmd ip netconf show dev "$dev"
 	for f in 4 6; do
-		ip -$f netconf show dev "$dev" > /dev/null
-		check_err $?
+		run_cmd ip -$f netconf show dev "$dev"
 	done
 
 	if [ $ret -ne 0 ] ;then
-		echo "FAIL: ip netconf show $dev"
+		end_test "FAIL: ip netconf show $dev"
 		test $r -eq 0 && ret=0
 		return 1
 	fi
@@ -92,43 +149,27 @@ kci_test_bridge()
 	vlandev="testbr-vlan1"
 
 	local ret=0
-	ip link add name "$devbr" type bridge
-	check_err $?
-
-	ip link set dev "$devdummy" master "$devbr"
-	check_err $?
-
-	ip link set "$devbr" up
-	check_err $?
-
-	ip link add link "$devbr" name "$vlandev" type vlan id 1
-	check_err $?
-	ip addr add dev "$vlandev" 10.200.7.23/30
-	check_err $?
-	ip -6 addr add dev "$vlandev" dead:42::1234/64
-	check_err $?
-	ip -d link > /dev/null
-	check_err $?
-	ip r s t all > /dev/null
-	check_err $?
+	run_cmd ip link add name "$devbr" type bridge
+	run_cmd ip link set dev "$devdummy" master "$devbr"
+	run_cmd ip link set "$devbr" up
+	run_cmd ip link add link "$devbr" name "$vlandev" type vlan id 1
+	run_cmd ip addr add dev "$vlandev" 10.200.7.23/30
+	run_cmd ip -6 addr add dev "$vlandev" dead:42::1234/64
+	run_cmd ip -d link
+	run_cmd ip r s t all
 
 	for name in "$devbr" "$vlandev" "$devdummy" ; do
 		kci_test_netconf "$name"
 	done
-
-	ip -6 addr del dev "$vlandev" dead:42::1234/64
-	check_err $?
-
-	ip link del dev "$vlandev"
-	check_err $?
-	ip link del dev "$devbr"
-	check_err $?
+	run_cmd ip -6 addr del dev "$vlandev" dead:42::1234/64
+	run_cmd ip link del dev "$vlandev"
+	run_cmd ip link del dev "$devbr"
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: bridge setup"
+		end_test "FAIL: bridge setup"
 		return 1
 	fi
-	echo "PASS: bridge setup"
+	end_test "PASS: bridge setup"
 
 }
 
@@ -139,34 +180,23 @@ kci_test_gre()
 	loc=10.0.0.1
 
 	local ret=0
-	ip tunnel add $gredev mode gre remote $rem local $loc ttl 1
-	check_err $?
-	ip link set $gredev up
-	check_err $?
-	ip addr add 10.23.7.10 dev $gredev
-	check_err $?
-	ip route add 10.23.8.0/30 dev $gredev
-	check_err $?
-	ip addr add dev "$devdummy" 10.23.7.11/24
-	check_err $?
-	ip link > /dev/null
-	check_err $?
-	ip addr > /dev/null
-	check_err $?
+	run_cmd ip tunnel add $gredev mode gre remote $rem local $loc ttl 1
+	run_cmd ip link set $gredev up
+	run_cmd ip addr add 10.23.7.10 dev $gredev
+	run_cmd ip route add 10.23.8.0/30 dev $gredev
+	run_cmd ip addr add dev "$devdummy" 10.23.7.11/24
+	run_cmd ip link
+	run_cmd ip addr
 
 	kci_test_netconf "$gredev"
-
-	ip addr del dev "$devdummy" 10.23.7.11/24
-	check_err $?
-
-	ip link del $gredev
-	check_err $?
+	run_cmd ip addr del dev "$devdummy" 10.23.7.11/24
+	run_cmd ip link del $gredev
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: gre tunnel endpoint"
+		end_test "FAIL: gre tunnel endpoint"
 		return 1
 	fi
-	echo "PASS: gre tunnel endpoint"
+	end_test "PASS: gre tunnel endpoint"
 }
 
 # tc uses rtnetlink too, for full tc testing
@@ -176,56 +206,40 @@ kci_test_tc()
 	dev=lo
 	local ret=0
 
-	tc qdisc add dev "$dev" root handle 1: htb
-	check_err $?
-	tc class add dev "$dev" parent 1: classid 1:10 htb rate 1mbit
-	check_err $?
-	tc filter add dev "$dev" parent 1:0 prio 5 handle ffe: protocol ip u32 divisor 256
-	check_err $?
-	tc filter add dev "$dev" parent 1:0 prio 5 handle ffd: protocol ip u32 divisor 256
-	check_err $?
-	tc filter add dev "$dev" parent 1:0 prio 5 handle ffc: protocol ip u32 divisor 256
-	check_err $?
-	tc filter add dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:3 u32 ht ffe:2: match ip src 10.0.0.3 flowid 1:10
-	check_err $?
-	tc filter add dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:2 u32 ht ffe:2: match ip src 10.0.0.2 flowid 1:10
-	check_err $?
-	tc filter show dev "$dev" parent  1:0 > /dev/null
-	check_err $?
-	tc filter del dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:3 u32
-	check_err $?
-	tc filter show dev "$dev" parent  1:0 > /dev/null
-	check_err $?
-	tc qdisc del dev "$dev" root handle 1: htb
-	check_err $?
+	run_cmd tc qdisc add dev "$dev" root handle 1: htb
+	run_cmd tc class add dev "$dev" parent 1: classid 1:10 htb rate 1mbit
+	run_cmd tc filter add dev "$dev" parent 1:0 prio 5 handle ffe: protocol ip u32 divisor 256
+	run_cmd tc filter add dev "$dev" parent 1:0 prio 5 handle ffd: protocol ip u32 divisor 256
+	run_cmd tc filter add dev "$dev" parent 1:0 prio 5 handle ffc: protocol ip u32 divisor 256
+	run_cmd tc filter add dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:3 u32 ht ffe:2: match ip src 10.0.0.3 flowid 1:10
+	run_cmd tc filter add dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:2 u32 ht ffe:2: match ip src 10.0.0.2 flowid 1:10
+	run_cmd tc filter show dev "$dev" parent  1:0
+	run_cmd tc filter del dev "$dev" protocol ip parent 1: prio 5 handle ffe:2:3 u32
+	run_cmd tc filter show dev "$dev" parent  1:0
+	run_cmd tc qdisc del dev "$dev" root handle 1: htb
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: tc htb hierarchy"
+		end_test "FAIL: tc htb hierarchy"
 		return 1
 	fi
-	echo "PASS: tc htb hierarchy"
+	end_test "PASS: tc htb hierarchy"
 
 }
 
 kci_test_polrouting()
 {
 	local ret=0
-	ip rule add fwmark 1 lookup 100
-	check_err $?
-	ip route add local 0.0.0.0/0 dev lo table 100
-	check_err $?
-	ip r s t all > /dev/null
-	check_err $?
-	ip rule del fwmark 1 lookup 100
-	check_err $?
-	ip route del local 0.0.0.0/0 dev lo table 100
-	check_err $?
+	run_cmd ip rule add fwmark 1 lookup 100
+	run_cmd ip route add local 0.0.0.0/0 dev lo table 100
+	run_cmd ip r s t all
+	run_cmd ip rule del fwmark 1 lookup 100
+	run_cmd ip route del local 0.0.0.0/0 dev lo table 100
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: policy route test"
+		end_test "FAIL: policy route test"
 		return 1
 	fi
-	echo "PASS: policy routing"
+	end_test "PASS: policy routing"
 }
 
 kci_test_route_get()
@@ -233,65 +247,51 @@ kci_test_route_get()
 	local hash_policy=$(sysctl -n net.ipv4.fib_multipath_hash_policy)
 
 	local ret=0
-
-	ip route get 127.0.0.1 > /dev/null
-	check_err $?
-	ip route get 127.0.0.1 dev "$devdummy" > /dev/null
-	check_err $?
-	ip route get ::1 > /dev/null
-	check_err $?
-	ip route get fe80::1 dev "$devdummy" > /dev/null
-	check_err $?
-	ip route get 127.0.0.1 from 127.0.0.1 oif lo tos 0x10 mark 0x1 > /dev/null
-	check_err $?
-	ip route get ::1 from ::1 iif lo oif lo tos 0x10 mark 0x1 > /dev/null
-	check_err $?
-	ip addr add dev "$devdummy" 10.23.7.11/24
-	check_err $?
-	ip route get 10.23.7.11 from 10.23.7.12 iif "$devdummy" > /dev/null
-	check_err $?
-	ip route add 10.23.8.0/24 \
+	run_cmd ip route get 127.0.0.1
+	run_cmd ip route get 127.0.0.1 dev "$devdummy"
+	run_cmd ip route get ::1
+	run_cmd ip route get fe80::1 dev "$devdummy"
+	run_cmd ip route get 127.0.0.1 from 127.0.0.1 oif lo tos 0x10 mark 0x1
+	run_cmd ip route get ::1 from ::1 iif lo oif lo tos 0x10 mark 0x1
+	run_cmd ip addr add dev "$devdummy" 10.23.7.11/24
+	run_cmd ip route get 10.23.7.11 from 10.23.7.12 iif "$devdummy"
+	run_cmd ip route add 10.23.8.0/24 \
 		nexthop via 10.23.7.13 dev "$devdummy" \
 		nexthop via 10.23.7.14 dev "$devdummy"
-	check_err $?
+
 	sysctl -wq net.ipv4.fib_multipath_hash_policy=0
-	ip route get 10.23.8.11 > /dev/null
-	check_err $?
+	run_cmd ip route get 10.23.8.11
 	sysctl -wq net.ipv4.fib_multipath_hash_policy=1
-	ip route get 10.23.8.11 > /dev/null
-	check_err $?
+	run_cmd ip route get 10.23.8.11
 	sysctl -wq net.ipv4.fib_multipath_hash_policy="$hash_policy"
-	ip route del 10.23.8.0/24
-	check_err $?
-	ip addr del dev "$devdummy" 10.23.7.11/24
-	check_err $?
+	run_cmd ip route del 10.23.8.0/24
+	run_cmd ip addr del dev "$devdummy" 10.23.7.11/24
+
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: route get"
+		end_test "FAIL: route get"
 		return 1
 	fi
 
-	echo "PASS: route get"
+	end_test "PASS: route get"
 }
 
 kci_test_addrlft()
 {
 	for i in $(seq 10 100) ;do
 		lft=$(((RANDOM%3) + 1))
-		ip addr add 10.23.11.$i/32 dev "$devdummy" preferred_lft $lft valid_lft $((lft+1))
-		check_err $?
+		run_cmd ip addr add 10.23.11.$i/32 dev "$devdummy" preferred_lft $lft valid_lft $((lft+1))
 	done
 
 	sleep 5
-
-	ip addr show dev "$devdummy" | grep "10.23.11."
+	run_cmd_grep "10.23.11." ip addr show dev "$devdummy"
 	if [ $? -eq 0 ]; then
-		echo "FAIL: preferred_lft addresses remaining"
+		end_test "FAIL: preferred_lft addresses remaining"
 		check_err 1
 		return
 	fi
 
-	echo "PASS: preferred_lft addresses have expired"
+	end_test "PASS: preferred_lft addresses have expired"
 }
 
 kci_test_promote_secondaries()
@@ -310,27 +310,17 @@ kci_test_promote_secondaries()
 
 	[ $promote -eq 0 ] && sysctl -q net.ipv4.conf.$devdummy.promote_secondaries=0
 
-	echo "PASS: promote_secondaries complete"
+	end_test "PASS: promote_secondaries complete"
 }
 
 kci_test_addrlabel()
 {
 	local ret=0
-
-	ip addrlabel add prefix dead::/64 dev lo label 1
-	check_err $?
-
-	ip addrlabel list |grep -q "prefix dead::/64 dev lo label 1"
-	check_err $?
-
-	ip addrlabel del prefix dead::/64 dev lo label 1 2> /dev/null
-	check_err $?
-
-	ip addrlabel add prefix dead::/64 label 1 2> /dev/null
-	check_err $?
-
-	ip addrlabel del prefix dead::/64 label 1 2> /dev/null
-	check_err $?
+	run_cmd ip addrlabel add prefix dead::/64 dev lo label 1
+	run_cmd_grep "prefix dead::/64 dev lo label 1" ip addrlabel list
+	run_cmd ip addrlabel del prefix dead::/64 dev lo label 1
+	run_cmd ip addrlabel add prefix dead::/64 label 1
+	run_cmd ip addrlabel del prefix dead::/64 label 1
 
 	# concurrent add/delete
 	for i in $(seq 1 1000); do
@@ -346,11 +336,11 @@ kci_test_addrlabel()
 	ip addrlabel del prefix 1c3::/64 label 12345 2>/dev/null
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: ipv6 addrlabel"
+		end_test "FAIL: ipv6 addrlabel"
 		return 1
 	fi
 
-	echo "PASS: ipv6 addrlabel"
+	end_test "PASS: ipv6 addrlabel"
 }
 
 kci_test_ifalias()
@@ -358,35 +348,28 @@ kci_test_ifalias()
 	local ret=0
 	namewant=$(uuidgen)
 	syspathname="/sys/class/net/$devdummy/ifalias"
-
-	ip link set dev "$devdummy" alias "$namewant"
-	check_err $?
+	run_cmd ip link set dev "$devdummy" alias "$namewant"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: cannot set interface alias of $devdummy to $namewant"
+		end_test "FAIL: cannot set interface alias of $devdummy to $namewant"
 		return 1
 	fi
-
-	ip link show "$devdummy" | grep -q "alias $namewant"
-	check_err $?
+	run_cmd_grep "alias $namewant" ip link show "$devdummy"
 
 	if [ -r "$syspathname" ] ; then
 		read namehave < "$syspathname"
 		if [ "$namewant" != "$namehave" ]; then
-			echo "FAIL: did set ifalias $namewant but got $namehave"
+			end_test "FAIL: did set ifalias $namewant but got $namehave"
 			return 1
 		fi
 
 		namewant=$(uuidgen)
 		echo "$namewant" > "$syspathname"
-	        ip link show "$devdummy" | grep -q "alias $namewant"
-		check_err $?
+	        run_cmd_grep "alias $namewant" ip link show "$devdummy"
 
 		# sysfs interface allows to delete alias again
 		echo "" > "$syspathname"
-
-	        ip link show "$devdummy" | grep -q "alias $namewant"
-		check_fail $?
+	        run_cmd_grep_fail "alias $namewant" ip link show "$devdummy"
 
 		for i in $(seq 1 100); do
 			uuidgen > "$syspathname" &
@@ -395,57 +378,48 @@ kci_test_ifalias()
 		wait
 
 		# re-add the alias -- kernel should free mem when dummy dev is removed
-		ip link set dev "$devdummy" alias "$namewant"
-		check_err $?
+		run_cmd ip link set dev "$devdummy" alias "$namewant"
+
 	fi
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: set interface alias $devdummy to $namewant"
+		end_test "FAIL: set interface alias $devdummy to $namewant"
 		return 1
 	fi
 
-	echo "PASS: set ifalias $namewant for $devdummy"
+	end_test "PASS: set ifalias $namewant for $devdummy"
 }
 
 kci_test_vrf()
 {
 	vrfname="test-vrf"
 	local ret=0
-
-	ip link show type vrf 2>/dev/null
+	run_cmd ip link show type vrf
 	if [ $? -ne 0 ]; then
-		echo "SKIP: vrf: iproute2 too old"
+		end_test "SKIP: vrf: iproute2 too old"
 		return $ksft_skip
 	fi
-
-	ip link add "$vrfname" type vrf table 10
-	check_err $?
+	run_cmd ip link add "$vrfname" type vrf table 10
 	if [ $ret -ne 0 ];then
-		echo "FAIL: can't add vrf interface, skipping test"
+		end_test "FAIL: can't add vrf interface, skipping test"
 		return 0
 	fi
-
-	ip -br link show type vrf | grep -q "$vrfname"
-	check_err $?
+	run_cmd_grep "$vrfname" ip -br link show type vrf
 	if [ $ret -ne 0 ];then
-		echo "FAIL: created vrf device not found"
+		end_test "FAIL: created vrf device not found"
 		return 1
 	fi
 
-	ip link set dev "$vrfname" up
-	check_err $?
-
-	ip link set dev "$devdummy" master "$vrfname"
-	check_err $?
-	ip link del dev "$vrfname"
-	check_err $?
+	run_cmd ip link set dev "$vrfname" up
+	run_cmd ip link set dev "$devdummy" master "$vrfname"
+	run_cmd ip link del dev "$vrfname"
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: vrf"
+		end_test "FAIL: vrf"
 		return 1
 	fi
 
-	echo "PASS: vrf"
+	end_test "PASS: vrf"
 }
 
 kci_test_encap_vxlan()
@@ -454,84 +428,44 @@ kci_test_encap_vxlan()
 	vxlan="test-vxlan0"
 	vlan="test-vlan0"
 	testns="$1"
-
-	ip -netns "$testns" link add "$vxlan" type vxlan id 42 group 239.1.1.1 \
-		dev "$devdummy" dstport 4789 2>/dev/null
+	run_cmd ip -netns "$testns" link add "$vxlan" type vxlan id 42 group 239.1.1.1 \
+		dev "$devdummy" dstport 4789
 	if [ $? -ne 0 ]; then
-		echo "FAIL: can't add vxlan interface, skipping test"
+		end_test "FAIL: can't add vxlan interface, skipping test"
 		return 0
 	fi
-	check_err $?
-
-	ip -netns "$testns" addr add 10.2.11.49/24 dev "$vxlan"
-	check_err $?
 
-	ip -netns "$testns" link set up dev "$vxlan"
-	check_err $?
-
-	ip -netns "$testns" link add link "$vxlan" name "$vlan" type vlan id 1
-	check_err $?
+	run_cmd ip -netns "$testns" addr add 10.2.11.49/24 dev "$vxlan"
+	run_cmd ip -netns "$testns" link set up dev "$vxlan"
+	run_cmd ip -netns "$testns" link add link "$vxlan" name "$vlan" type vlan id 1
 
 	# changelink testcases
-	ip -netns "$testns" link set dev "$vxlan" type vxlan vni 43 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan group ffe5::5 dev "$devdummy" 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan ttl inherit 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan ttl 64
-	check_err $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan nolearning
-	check_err $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan proxy 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan norsc 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan l2miss 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan l3miss 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan external 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan udpcsum 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan udp6zerocsumtx 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan udp6zerocsumrx 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan remcsumtx 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan remcsumrx 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan gbp 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link set dev "$vxlan" type vxlan gpe 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" link del "$vxlan"
-	check_err $?
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan vni 43
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan group ffe5::5 dev "$devdummy"
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan ttl inherit
+
+	run_cmd ip -netns "$testns" link set dev "$vxlan" type vxlan ttl 64
+	run_cmd ip -netns "$testns" link set dev "$vxlan" type vxlan nolearning
+
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan proxy
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan norsc
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan l2miss
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan l3miss
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan external
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan udpcsum
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan udp6zerocsumtx
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan udp6zerocsumrx
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan remcsumtx
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan remcsumrx
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan gbp
+	run_cmd_fail ip -netns "$testns" link set dev "$vxlan" type vxlan gpe
+	run_cmd ip -netns "$testns" link del "$vxlan"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: vxlan"
+		end_test "FAIL: vxlan"
 		return 1
 	fi
-	echo "PASS: vxlan"
+	end_test "PASS: vxlan"
 }
 
 kci_test_encap_fou()
@@ -539,39 +473,32 @@ kci_test_encap_fou()
 	local ret=0
 	name="test-fou"
 	testns="$1"
-
-	ip fou help 2>&1 |grep -q 'Usage: ip fou'
+	run_cmd_grep 'Usage: ip fou' ip fou help
 	if [ $? -ne 0 ];then
-		echo "SKIP: fou: iproute2 too old"
+		end_test "SKIP: fou: iproute2 too old"
 		return $ksft_skip
 	fi
 
 	if ! /sbin/modprobe -q -n fou; then
-		echo "SKIP: module fou is not found"
+		end_test "SKIP: module fou is not found"
 		return $ksft_skip
 	fi
 	/sbin/modprobe -q fou
-	ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
+
+	run_cmd ip -netns "$testns" fou add port 7777 ipproto 47
 	if [ $? -ne 0 ];then
-		echo "FAIL: can't add fou port 7777, skipping test"
+		end_test "FAIL: can't add fou port 7777, skipping test"
 		return 1
 	fi
-
-	ip -netns "$testns" fou add port 8888 ipproto 4
-	check_err $?
-
-	ip -netns "$testns" fou del port 9999 2>/dev/null
-	check_fail $?
-
-	ip -netns "$testns" fou del port 7777
-	check_err $?
-
+	run_cmd ip -netns "$testns" fou add port 8888 ipproto 4
+	run_cmd_fail ip -netns "$testns" fou del port 9999
+	run_cmd ip -netns "$testns" fou del port 7777
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: fou"
+		end_test "FAIL: fou"s
 		return 1
 	fi
 
-	echo "PASS: fou"
+	end_test "PASS: fou"
 }
 
 # test various encap methods, use netns to avoid unwanted interference
@@ -579,25 +506,16 @@ kci_test_encap()
 {
 	testns="testns"
 	local ret=0
-
-	ip netns add "$testns"
+	run_cmd ip netns add "$testns"
 	if [ $? -ne 0 ]; then
-		echo "SKIP encap tests: cannot add net namespace $testns"
+		end_test "SKIP encap tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
-
-	ip -netns "$testns" link set lo up
-	check_err $?
-
-	ip -netns "$testns" link add name "$devdummy" type dummy
-	check_err $?
-	ip -netns "$testns" link set "$devdummy" up
-	check_err $?
-
-	kci_test_encap_vxlan "$testns"
-	check_err $?
-	kci_test_encap_fou "$testns"
-	check_err $?
+	run_cmd ip -netns "$testns" link set lo up
+	run_cmd ip -netns "$testns" link add name "$devdummy" type dummy
+	run_cmd ip -netns "$testns" link set "$devdummy" up
+	run_cmd kci_test_encap_vxlan "$testns"
+	run_cmd kci_test_encap_fou "$testns"
 
 	ip netns del "$testns"
 	return $ret
@@ -607,41 +525,28 @@ kci_test_macsec()
 {
 	msname="test_macsec0"
 	local ret=0
-
-	ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
+	run_cmd_grep "^Usage: ip macsec" ip macsec help
 	if [ $? -ne 0 ]; then
-		echo "SKIP: macsec: iproute2 too old"
+		end_test "SKIP: macsec: iproute2 too old"
 		return $ksft_skip
 	fi
-
-	ip link add link "$devdummy" "$msname" type macsec port 42 encrypt on
-	check_err $?
+	run_cmd ip link add link "$devdummy" "$msname" type macsec port 42 encrypt on
 	if [ $ret -ne 0 ];then
-		echo "FAIL: can't add macsec interface, skipping test"
+		end_test "FAIL: can't add macsec interface, skipping test"
 		return 1
 	fi
-
-	ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
-	check_err $?
-
-	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
-	check_err $?
-
-	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on key 00 0123456789abcdef0123456789abcdef
-	check_err $?
-
-	ip macsec show > /dev/null
-	check_err $?
-
-	ip link del dev "$msname"
-	check_err $?
+	run_cmd ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
+	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
+	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on key 00 0123456789abcdef0123456789abcdef
+	run_cmd ip macsec show
+	run_cmd ip link del dev "$msname"
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: macsec"
+		end_test "FAIL: macsec"
 		return 1
 	fi
 
-	echo "PASS: macsec"
+	end_test "PASS: macsec"
 }
 
 kci_test_macsec_offload()
@@ -650,19 +555,18 @@ kci_test_macsec_offload()
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
 	local ret=0
-
-	ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
+	run_cmd_grep "^Usage: ip macsec" ip macsec help
 	if [ $? -ne 0 ]; then
-		echo "SKIP: macsec: iproute2 too old"
+		end_test "SKIP: macsec: iproute2 too old"
 		return $ksft_skip
 	fi
 
 	# setup netdevsim since dummydev doesn't have offload support
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
-		modprobe -q netdevsim
-		check_err $?
+		run_cmd modprobe -q netdevsim
+
 		if [ $ret -ne 0 ]; then
-			echo "SKIP: macsec_offload can't load netdevsim"
+			end_test "SKIP: macsec_offload can't load netdevsim"
 			return $ksft_skip
 		fi
 		probed=true
@@ -675,43 +579,25 @@ kci_test_macsec_offload()
 
 	ip link set $dev up
 	if [ ! -d $sysfsd ] ; then
-		echo "FAIL: macsec_offload can't create device $dev"
+		end_test "FAIL: macsec_offload can't create device $dev"
 		return 1
 	fi
-
-	ethtool -k $dev | grep -q 'macsec-hw-offload: on'
+	run_cmd_grep 'macsec-hw-offload: on' ethtool -k $dev
 	if [ $? -eq 1 ] ; then
-		echo "FAIL: macsec_offload netdevsim doesn't support MACsec offload"
+		end_test "FAIL: macsec_offload netdevsim doesn't support MACsec offload"
 		return 1
 	fi
-
-	ip link add link $dev kci_macsec1 type macsec port 4 offload mac
-	check_err $?
-
-	ip link add link $dev kci_macsec2 type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
-	check_err $?
-
-	ip link add link $dev kci_macsec3 type macsec sci abbacdde01020304 offload mac
-	check_err $?
-
-	ip link add link $dev kci_macsec4 type macsec port 8 offload mac 2> /dev/null
-	check_fail $?
+	run_cmd ip link add link $dev kci_macsec1 type macsec port 4 offload mac
+	run_cmd ip link add link $dev kci_macsec2 type macsec address "aa:bb:cc:dd:ee:ff" port 5 offload mac
+	run_cmd ip link add link $dev kci_macsec3 type macsec sci abbacdde01020304 offload mac
+	run_cmd_fail ip link add link $dev kci_macsec4 type macsec port 8 offload mac
 
 	msname=kci_macsec1
-
-	ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
-	check_err $?
-
-	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
-	check_err $?
-
-	ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
+	run_cmd ip macsec add "$msname" tx sa 0 pn 1024 on key 01 12345678901234567890123456789012
+	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
+	run_cmd ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 pn 1 on \
 		key 00 0123456789abcdef0123456789abcdef
-	check_err $?
-
-	ip macsec add "$msname" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /dev/null
-	check_fail $?
-
+	run_cmd_fail ip macsec add "$msname" rx port 1235 address "1c:ed:de:ad:be:ef"
 	# clean up any leftovers
 	for msdev in kci_macsec{1,2,3,4} ; do
 	    ip link del $msdev 2> /dev/null
@@ -720,10 +606,10 @@ kci_test_macsec_offload()
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: macsec_offload"
+		end_test "FAIL: macsec_offload"
 		return 1
 	fi
-	echo "PASS: macsec_offload"
+	end_test "PASS: macsec_offload"
 }
 
 #-------------------------------------------------------------------
@@ -755,8 +641,7 @@ kci_test_ipsec()
 	ip addr add $srcip dev $devdummy
 
 	# flush to be sure there's nothing configured
-	ip x s flush ; ip x p flush
-	check_err $?
+	run_cmd ip x s flush ; ip x p flush
 
 	# start the monitor in the background
 	tmpfile=`mktemp /var/run/ipsectestXXX`
@@ -764,72 +649,57 @@ kci_test_ipsec()
 	sleep 0.2
 
 	ipsecid="proto esp src $srcip dst $dstip spi 0x07"
-	ip x s add $ipsecid \
+	run_cmd ip x s add $ipsecid \
             mode transport reqid 0x07 replay-window 32 \
             $algo sel src $srcip/24 dst $dstip/24
-	check_err $?
 
-	lines=`ip x s list | grep $srcip | grep $dstip | wc -l`
-	test $lines -eq 2
-	check_err $?
 
-	ip x s count | grep -q "SAD count 1"
-	check_err $?
+	lines=`ip x s list | grep $srcip | grep $dstip | wc -l`
+	run_cmd test $lines -eq 2
+	run_cmd_grep "SAD count 1" ip x s count
 
 	lines=`ip x s get $ipsecid | grep $srcip | grep $dstip | wc -l`
-	test $lines -eq 2
-	check_err $?
-
-	ip x s delete $ipsecid
-	check_err $?
+	run_cmd test $lines -eq 2
+	run_cmd ip x s delete $ipsecid
 
 	lines=`ip x s list | wc -l`
-	test $lines -eq 0
-	check_err $?
+	run_cmd test $lines -eq 0
 
 	ipsecsel="dir out src $srcip/24 dst $dstip/24"
-	ip x p add $ipsecsel \
+	run_cmd ip x p add $ipsecsel \
 		    tmpl proto esp src $srcip dst $dstip \
 		    spi 0x07 mode transport reqid 0x07
-	check_err $?
+
 
 	lines=`ip x p list | grep $srcip | grep $dstip | wc -l`
-	test $lines -eq 2
-	check_err $?
+	run_cmd test $lines -eq 2
 
-	ip x p count | grep -q "SPD IN  0 OUT 1 FWD 0"
-	check_err $?
+	run_cmd_grep "SPD IN  0 OUT 1 FWD 0" ip x p count
 
 	lines=`ip x p get $ipsecsel | grep $srcip | grep $dstip | wc -l`
-	test $lines -eq 2
-	check_err $?
+	run_cmd test $lines -eq 2
 
-	ip x p delete $ipsecsel
-	check_err $?
+	run_cmd ip x p delete $ipsecsel
 
 	lines=`ip x p list | wc -l`
-	test $lines -eq 0
-	check_err $?
+	run_cmd test $lines -eq 0
 
 	# check the monitor results
 	kill $mpid
 	lines=`wc -l $tmpfile | cut "-d " -f1`
-	test $lines -eq 20
-	check_err $?
+	run_cmd test $lines -eq 20
 	rm -rf $tmpfile
 
 	# clean up any leftovers
-	ip x s flush
-	check_err $?
-	ip x p flush
-	check_err $?
+	run_cmd ip x s flush
+	run_cmd ip x p flush
 	ip addr del $srcip/32 dev $devdummy
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: ipsec"
+		end_test "FAIL: ipsec"
 		return 1
 	fi
-	echo "PASS: ipsec"
+	end_test "PASS: ipsec"
 }
 
 #-------------------------------------------------------------------
@@ -857,10 +727,9 @@ kci_test_ipsec_offload()
 
 	# setup netdevsim since dummydev doesn't have offload support
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
-		modprobe -q netdevsim
-		check_err $?
+		run_cmd modprobe -q netdevsim
 		if [ $ret -ne 0 ]; then
-			echo "SKIP: ipsec_offload can't load netdevsim"
+			end_test "SKIP: ipsec_offload can't load netdevsim"
 			return $ksft_skip
 		fi
 		probed=true
@@ -874,11 +743,11 @@ kci_test_ipsec_offload()
 	ip addr add $srcip dev $dev
 	ip link set $dev up
 	if [ ! -d $sysfsd ] ; then
-		echo "FAIL: ipsec_offload can't create device $dev"
+		end_test "FAIL: ipsec_offload can't create device $dev"
 		return 1
 	fi
 	if [ ! -f $sysfsf ] ; then
-		echo "FAIL: ipsec_offload netdevsim doesn't support IPsec offload"
+		end_test "FAIL: ipsec_offload netdevsim doesn't support IPsec offload"
 		return 1
 	fi
 
@@ -886,32 +755,31 @@ kci_test_ipsec_offload()
 	ip x s flush ; ip x p flush
 
 	# create offloaded SAs, both in and out
-	ip x p add dir out src $srcip/24 dst $dstip/24 \
+	run_cmd ip x p add dir out src $srcip/24 dst $dstip/24 \
 	    tmpl proto esp src $srcip dst $dstip spi 9 \
 	    mode transport reqid 42
-	check_err $?
-	ip x p add dir in src $dstip/24 dst $srcip/24 \
+
+	run_cmd ip x p add dir in src $dstip/24 dst $srcip/24 \
 	    tmpl proto esp src $dstip dst $srcip spi 9 \
 	    mode transport reqid 42
-	check_err $?
 
-	ip x s add proto esp src $srcip dst $dstip spi 9 \
+	run_cmd ip x s add proto esp src $srcip dst $dstip spi 9 \
 	    mode transport reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
 	    offload dev $dev dir out
-	check_err $?
-	ip x s add proto esp src $dstip dst $srcip spi 9 \
+
+	run_cmd ip x s add proto esp src $dstip dst $srcip spi 9 \
 	    mode transport reqid 42 $algo sel src $dstip/24 dst $srcip/24 \
 	    offload dev $dev dir in
-	check_err $?
+
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: ipsec_offload can't create SA"
+		end_test "FAIL: ipsec_offload can't create SA"
 		return 1
 	fi
 
 	# does offload show up in ip output
 	lines=`ip x s list | grep -c "crypto offload parameters: dev $dev dir"`
 	if [ $lines -ne 2 ] ; then
-		echo "FAIL: ipsec_offload SA offload missing from list output"
+		end_test "FAIL: ipsec_offload SA offload missing from list output"
 		check_err 1
 	fi
 
@@ -919,7 +787,7 @@ kci_test_ipsec_offload()
 	ping -I $dev -c 3 -W 1 -i 0 $dstip >/dev/null
 
 	# does driver have correct offload info
-	diff $sysfsf - << EOF
+	run_cmd diff $sysfsf - << EOF
 SA count=2 tx=3
 sa[0] tx ipaddr=0x00000000 00000000 00000000 00000000
 sa[0]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
@@ -929,7 +797,7 @@ sa[1]    spi=0x00000009 proto=0x32 salt=0x61626364 crypt=1
 sa[1]    key=0x34333231 38373635 32313039 36353433
 EOF
 	if [ $? -ne 0 ] ; then
-		echo "FAIL: ipsec_offload incorrect driver data"
+		end_test "FAIL: ipsec_offload incorrect driver data"
 		check_err 1
 	fi
 
@@ -938,7 +806,7 @@ EOF
 	ip x p flush
 	lines=`grep -c "SA count=0" $sysfsf`
 	if [ $lines -ne 1 ] ; then
-		echo "FAIL: ipsec_offload SA not removed from driver"
+		end_test "FAIL: ipsec_offload SA not removed from driver"
 		check_err 1
 	fi
 
@@ -947,10 +815,10 @@ EOF
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: ipsec_offload"
+		end_test "FAIL: ipsec_offload"
 		return 1
 	fi
-	echo "PASS: ipsec_offload"
+	end_test "PASS: ipsec_offload"
 }
 
 kci_test_gretap()
@@ -959,46 +827,38 @@ kci_test_gretap()
 	DEV_NS=gretap00
 	local ret=0
 
-	ip netns add "$testns"
+	run_cmd ip netns add "$testns"
 	if [ $? -ne 0 ]; then
-		echo "SKIP gretap tests: cannot add net namespace $testns"
+		end_test "SKIP gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
 
-	ip link help gretap 2>&1 | grep -q "^Usage:"
+	run_cmd_grep "^Usage:" ip link help gretap
 	if [ $? -ne 0 ];then
-		echo "SKIP: gretap: iproute2 too old"
+		end_test "SKIP: gretap: iproute2 too old"
 		ip netns del "$testns"
 		return $ksft_skip
 	fi
 
 	# test native tunnel
-	ip -netns "$testns" link add dev "$DEV_NS" type gretap seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type gretap seq \
 		key 102 local 172.16.1.100 remote 172.16.1.200
-	check_err $?
-
-	ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	check_err $?
 
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
 
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
+	run_cmd ip -netns "$testns" link set dev $DEV_NS ups
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test external mode
-	ip -netns "$testns" link add dev "$DEV_NS" type gretap external
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type gretap external
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: gretap"
+		end_test "FAIL: gretap"
 		ip netns del "$testns"
 		return 1
 	fi
-	echo "PASS: gretap"
+	end_test "PASS: gretap"
 
 	ip netns del "$testns"
 }
@@ -1009,46 +869,38 @@ kci_test_ip6gretap()
 	DEV_NS=ip6gretap00
 	local ret=0
 
-	ip netns add "$testns"
+	run_cmd ip netns add "$testns"
 	if [ $? -ne 0 ]; then
-		echo "SKIP ip6gretap tests: cannot add net namespace $testns"
+		end_test "SKIP ip6gretap tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
 
-	ip link help ip6gretap 2>&1 | grep -q "^Usage:"
+	run_cmd_grep "^Usage:" ip link help ip6gretap
 	if [ $? -ne 0 ];then
-		echo "SKIP: ip6gretap: iproute2 too old"
+		end_test "SKIP: ip6gretap: iproute2 too old"
 		ip netns del "$testns"
 		return $ksft_skip
 	fi
 
 	# test native tunnel
-	ip -netns "$testns" link add dev "$DEV_NS" type ip6gretap seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type ip6gretap seq \
 		key 102 local fc00:100::1 remote fc00:100::2
-	check_err $?
 
-	ip -netns "$testns" addr add dev "$DEV_NS" fc00:200::1/96
-	check_err $?
 
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" fc00:200::1/96
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test external mode
-	ip -netns "$testns" link add dev "$DEV_NS" type ip6gretap external
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type ip6gretap external
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: ip6gretap"
+		end_test "FAIL: ip6gretap"
 		ip netns del "$testns"
 		return 1
 	fi
-	echo "PASS: ip6gretap"
+	end_test "PASS: ip6gretap"
 
 	ip netns del "$testns"
 }
@@ -1058,62 +910,47 @@ kci_test_erspan()
 	testns="testns"
 	DEV_NS=erspan00
 	local ret=0
-
-	ip link help erspan 2>&1 | grep -q "^Usage:"
+	run_cmd_grep "^Usage:" ip link help erspan
 	if [ $? -ne 0 ];then
-		echo "SKIP: erspan: iproute2 too old"
+		end_test "SKIP: erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-
-	ip netns add "$testns"
+	run_cmd ip netns add "$testns"
 	if [ $? -ne 0 ]; then
-		echo "SKIP erspan tests: cannot add net namespace $testns"
+		end_test "SKIP erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
 
 	# test native tunnel erspan v1
-	ip -netns "$testns" link add dev "$DEV_NS" type erspan seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type erspan seq \
 		key 102 local 172.16.1.100 remote 172.16.1.200 \
 		erspan_ver 1 erspan 488
-	check_err $?
 
-	ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	check_err $?
 
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test native tunnel erspan v2
-	ip -netns "$testns" link add dev "$DEV_NS" type erspan seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type erspan seq \
 		key 102 local 172.16.1.100 remote 172.16.1.200 \
 		erspan_ver 2 erspan_dir ingress erspan_hwid 7
-	check_err $?
-
-	ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	check_err $?
 
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
 
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test external mode
-	ip -netns "$testns" link add dev "$DEV_NS" type erspan external
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type erspan external
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: erspan"
+		end_test "FAIL: erspan"
 		ip netns del "$testns"
 		return 1
 	fi
-	echo "PASS: erspan"
+	end_test "PASS: erspan"
 
 	ip netns del "$testns"
 }
@@ -1123,63 +960,49 @@ kci_test_ip6erspan()
 	testns="testns"
 	DEV_NS=ip6erspan00
 	local ret=0
-
-	ip link help ip6erspan 2>&1 | grep -q "^Usage:"
+	run_cmd_grep "^Usage:" ip link help ip6erspan
 	if [ $? -ne 0 ];then
-		echo "SKIP: ip6erspan: iproute2 too old"
+		end_test "SKIP: ip6erspan: iproute2 too old"
 		return $ksft_skip
 	fi
-
-	ip netns add "$testns"
+	run_cmd ip netns add "$testns"
 	if [ $? -ne 0 ]; then
-		echo "SKIP ip6erspan tests: cannot add net namespace $testns"
+		end_test "SKIP ip6erspan tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
 
 	# test native tunnel ip6erspan v1
-	ip -netns "$testns" link add dev "$DEV_NS" type ip6erspan seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type ip6erspan seq \
 		key 102 local fc00:100::1 remote fc00:100::2 \
 		erspan_ver 1 erspan 488
-	check_err $?
 
-	ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	check_err $?
 
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
-
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test native tunnel ip6erspan v2
-	ip -netns "$testns" link add dev "$DEV_NS" type ip6erspan seq \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" type ip6erspan seq \
 		key 102 local fc00:100::1 remote fc00:100::2 \
 		erspan_ver 2 erspan_dir ingress erspan_hwid 7
-	check_err $?
 
-	ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	check_err $?
-
-	ip -netns "$testns" link set dev $DEV_NS up
-	check_err $?
 
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test external mode
-	ip -netns "$testns" link add dev "$DEV_NS" \
+	run_cmd ip -netns "$testns" link add dev "$DEV_NS" \
 		type ip6erspan external
-	check_err $?
 
-	ip -netns "$testns" link del "$DEV_NS"
-	check_err $?
+	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: ip6erspan"
+		end_test "FAIL: ip6erspan"
 		ip netns del "$testns"
 		return 1
 	fi
-	echo "PASS: ip6erspan"
+	end_test "PASS: ip6erspan"
 
 	ip netns del "$testns"
 }
@@ -1195,45 +1018,35 @@ kci_test_fdb_get()
 	dstip="10.0.2.3"
 	local ret=0
 
-	bridge fdb help 2>&1 |grep -q 'bridge fdb get'
+	run_cmd_grep 'bridge fdb get' bridge fdb help
 	if [ $? -ne 0 ];then
-		echo "SKIP: fdb get tests: iproute2 too old"
+		end_test "SKIP: fdb get tests: iproute2 too old"
 		return $ksft_skip
 	fi
 
-	ip netns add testns
+	run_cmd ip netns add testns
 	if [ $? -ne 0 ]; then
-		echo "SKIP fdb get tests: cannot add net namespace $testns"
+		end_test "SKIP fdb get tests: cannot add net namespace $testns"
 		return $ksft_skip
 	fi
-
-	$IP link add "$vxlandev" type vxlan id 10 local $localip \
-                dstport 4789 2>/dev/null
-	check_err $?
-	$IP link add name "$brdev" type bridge &>/dev/null
-	check_err $?
-	$IP link set dev "$vxlandev" master "$brdev" &>/dev/null
-	check_err $?
-	$BRIDGE fdb add $test_mac dev "$vxlandev" master &>/dev/null
-	check_err $?
-	$BRIDGE fdb add $test_mac dev "$vxlandev" dst $dstip self &>/dev/null
-	check_err $?
-
-	$BRIDGE fdb get $test_mac brport "$vxlandev" 2>/dev/null | grep -q "dev $vxlandev master $brdev"
-	check_err $?
-	$BRIDGE fdb get $test_mac br "$brdev" 2>/dev/null | grep -q "dev $vxlandev master $brdev"
-	check_err $?
-	$BRIDGE fdb get $test_mac dev "$vxlandev" self 2>/dev/null | grep -q "dev $vxlandev dst $dstip"
-	check_err $?
+	run_cmd $IP link add "$vxlandev" type vxlan id 10 local $localip \
+                dstport 4789
+	run_cmd $IP link add name "$brdev" type bridge
+	run_cmd $IP link set dev "$vxlandev" master "$brdev"
+	run_cmd $BRIDGE fdb add $test_mac dev "$vxlandev" master
+	run_cmd $BRIDGE fdb add $test_mac dev "$vxlandev" dst $dstip self
+	run_cmd_grep "dev $vxlandev master $brdev" $BRIDGE fdb get $test_mac brport "$vxlandev"
+	run_cmd_grep "dev $vxlandev master $brdev" $BRIDGE fdb get $test_mac br "$brdev"
+	run_cmd_grep "dev $vxlandev dst $dstip" $BRIDGE fdb get $test_mac dev "$vxlandev" self
 
 	ip netns del testns &>/dev/null
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: bridge fdb get"
+		end_test "FAIL: bridge fdb get"
 		return 1
 	fi
 
-	echo "PASS: bridge fdb get"
+	end_test "PASS: bridge fdb get"
 }
 
 kci_test_neigh_get()
@@ -1243,50 +1056,38 @@ kci_test_neigh_get()
 	dstip6=dead::2
 	local ret=0
 
-	ip neigh help 2>&1 |grep -q 'ip neigh get'
+	run_cmd_grep 'ip neigh get' ip neigh help
 	if [ $? -ne 0 ];then
-		echo "SKIP: fdb get tests: iproute2 too old"
+		end_test "SKIP: fdb get tests: iproute2 too old"
 		return $ksft_skip
 	fi
 
 	# ipv4
-	ip neigh add $dstip lladdr $dstmac dev "$devdummy"  > /dev/null
-	check_err $?
-	ip neigh get $dstip dev "$devdummy" 2> /dev/null | grep -q "$dstmac"
-	check_err $?
-	ip neigh del $dstip lladdr $dstmac dev "$devdummy"  > /dev/null
-	check_err $?
+	run_cmd ip neigh add $dstip lladdr $dstmac dev "$devdummy"
+	run_cmd_grep "$dstmac" ip neigh get $dstip dev "$devdummy"
+	run_cmd ip neigh del $dstip lladdr $dstmac dev "$devdummy"
 
 	# ipv4 proxy
-	ip neigh add proxy $dstip dev "$devdummy" > /dev/null
-	check_err $?
-	ip neigh get proxy $dstip dev "$devdummy" 2>/dev/null | grep -q "$dstip"
-	check_err $?
-	ip neigh del proxy $dstip dev "$devdummy" > /dev/null
-	check_err $?
+	run_cmd ip neigh add proxy $dstip dev "$devdummy"
+	run_cmd_grep "$dstip" ip neigh get proxy $dstip dev "$devdummy"
+	run_cmd ip neigh del proxy $dstip dev "$devdummy"
 
 	# ipv6
-	ip neigh add $dstip6 lladdr $dstmac dev "$devdummy"  > /dev/null
-	check_err $?
-	ip neigh get $dstip6 dev "$devdummy" 2> /dev/null | grep -q "$dstmac"
-	check_err $?
-	ip neigh del $dstip6 lladdr $dstmac dev "$devdummy"  > /dev/null
-	check_err $?
+	run_cmd ip neigh add $dstip6 lladdr $dstmac dev "$devdummy"
+	run_cmd_grep "$dstmac" ip neigh get $dstip6 dev "$devdummy"
+	run_cmd ip neigh del $dstip6 lladdr $dstmac dev "$devdummy"
 
 	# ipv6 proxy
-	ip neigh add proxy $dstip6 dev "$devdummy" > /dev/null
-	check_err $?
-	ip neigh get proxy $dstip6 dev "$devdummy" 2>/dev/null | grep -q "$dstip6"
-	check_err $?
-	ip neigh del proxy $dstip6 dev "$devdummy" > /dev/null
-	check_err $?
+	run_cmd ip neigh add proxy $dstip6 dev "$devdummy"
+	run_cmd_grep "$dstip6" ip neigh get proxy $dstip6 dev "$devdummy"
+	run_cmd ip neigh del proxy $dstip6 dev "$devdummy"
 
 	if [ $ret -ne 0 ];then
-		echo "FAIL: neigh get"
+		end_test "FAIL: neigh get"
 		return 1
 	fi
 
-	echo "PASS: neigh get"
+	end_test "PASS: neigh get"
 }
 
 kci_test_bridge_parent_id()
@@ -1296,10 +1097,9 @@ kci_test_bridge_parent_id()
 	probed=false
 
 	if [ ! -w /sys/bus/netdevsim/new_device ] ; then
-		modprobe -q netdevsim
-		check_err $?
+		run_cmd modprobe -q netdevsim
 		if [ $ret -ne 0 ]; then
-			echo "SKIP: bridge_parent_id can't load netdevsim"
+			end_test "SKIP: bridge_parent_id can't load netdevsim"
 			return $ksft_skip
 		fi
 		probed=true
@@ -1312,13 +1112,11 @@ kci_test_bridge_parent_id()
 	udevadm settle
 	dev10=`ls ${sysfsnet}10/net/`
 	dev20=`ls ${sysfsnet}20/net/`
-
-	ip link add name test-bond0 type bond mode 802.3ad
-	ip link set dev $dev10 master test-bond0
-	ip link set dev $dev20 master test-bond0
-	ip link add name test-br0 type bridge
-	ip link set dev test-bond0 master test-br0
-	check_err $?
+	run_cmd ip link add name test-bond0 type bond mode 802.3ad
+	run_cmd ip link set dev $dev10 master test-bond0
+	run_cmd ip link set dev $dev20 master test-bond0
+	run_cmd ip link add name test-br0 type bridge
+	run_cmd ip link set dev test-bond0 master test-br0
 
 	# clean up any leftovers
 	ip link del dev test-br0
@@ -1328,10 +1126,10 @@ kci_test_bridge_parent_id()
 	$probed && rmmod netdevsim
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: bridge_parent_id"
+		end_test "FAIL: bridge_parent_id"
 		return 1
 	fi
-	echo "PASS: bridge_parent_id"
+	end_test "PASS: bridge_parent_id"
 }
 
 address_get_proto()
@@ -1409,10 +1207,10 @@ do_test_address_proto()
 	ip address del dev "$devdummy" "$addr3"
 
 	if [ $ret -ne 0 ]; then
-		echo "FAIL: address proto $what"
+		end_test "FAIL: address proto $what"
 		return 1
 	fi
-	echo "PASS: address proto $what"
+	end_test "PASS: address proto $what"
 }
 
 kci_test_address_proto()
@@ -1435,7 +1233,7 @@ kci_test_rtnl()
 
 	kci_add_dummy
 	if [ $ret -ne 0 ];then
-		echo "FAIL: cannot add dummy interface"
+		end_test "FAIL: cannot add dummy interface"
 		return 1
 	fi
 
@@ -1455,26 +1253,28 @@ usage: ${0##*/} OPTS
 
         -t <test>   Test(s) to run (default: all)
                     (options: $(echo $ALL_TESTS))
+        -v          Verbose mode (show commands and output)
 EOF
 }
 
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
-	echo "SKIP: Need root privileges"
+	end_test "SKIP: Need root privileges"
 	exit $ksft_skip
 fi
 
 for x in ip tc;do
 	$x -Version 2>/dev/null >/dev/null
 	if [ $? -ne 0 ];then
-		echo "SKIP: Could not run test without the $x tool"
+		end_test "SKIP: Could not run test without the $x tool"
 		exit $ksft_skip
 	fi
 done
 
-while getopts t:h o; do
+while getopts t:hv o; do
 	case $o in
 		t) TESTS=$OPTARG;;
+		v) VERBOSE=1;;
 		h) usage; exit 0;;
 		*) usage; exit 1;;
 	esac
-- 
2.41.0


