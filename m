Return-Path: <netdev+bounces-183750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEF1A91D56
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A72A188C188
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0541F463D;
	Thu, 17 Apr 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="26hCsLIL"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B017A2E3
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895326; cv=none; b=RVv5m+VBhEp3SkdkJAJID9XFAQb8stLlyHQBMvmEW+ak2CT5nZX6jVQR7Gybt+8ABPWiLQrv/lT/LX81ORGH1Yw0oeiOJd3HprQVKYeFdig2JNZ2K9dyfd1yHCYB1e3snctBR0go953amKfPOTcqCnpjZQkCcuRy+Vyj4wgGdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895326; c=relaxed/simple;
	bh=GFKKlrWih1Tt2S/ck7/sLJ1MXBfFEngFYLt50JUpjf0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A2nTVsC+yg0FsLgrjM97VEQpu+wG1w0P6FiW0X6hgOOPcHeLip/gCOBF1lctRIUrNX3FhSNpH3KmJQlqRwx/tQKjz+xCyjbr5xu726y9KbmAMw26JuTfGOF99wgXhB85DFiFPRbECtSCM3+dKqD6a4frfLquQZN1GnOCy8CBErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=26hCsLIL; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 5CEC3200BFF2;
	Thu, 17 Apr 2025 15:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 5CEC3200BFF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1744895321;
	bh=XT/iUE5vP1z0gkdwe5exXFJ8T6boMd4j1DBP1kulJaE=;
	h=From:To:Cc:Subject:Date:From;
	b=26hCsLILynSC1OVDsJTmAuC7socJdJ1Vmb5kh84/ddgWbcLR0Xig3CqiQsJxbeCSc
	 Rl3J7vgaTKDIzXUlM0AekIn7dbepCnsUdPOb+N0pFmJvuQAInWWx6WRa4i7MyDsvD0
	 6kDRUqo/mDs5r0GLdiUx2LCkKy9VzpAX0yTFz1TGu9pL30SWGXIUvz53RtSXEs5g/t
	 QA4fHInmpVeUf3NgNC05SLy/K/tAwRkdqQpcIV8oKjpel7cNysrImwoONyuBa1I8sy
	 63kqAXx07JTWFZfnnXVfP73KNyoi/8c4EKETeqAANUhzvw9TbKT/Gd1o8gJtf+6k5o
	 mnrKpoyS4H5Ow==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next] selftests: net: kmemleak for lwt dst cache tests
Date: Thu, 17 Apr 2025 15:08:30 +0200
Message-Id: <20250417130830.19630-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Force the use of kmemleak to check everything's OK and report results
for each test case. Also, useless sleeps were removed, and the bash
script was renamed to something that makes more sense. Due to kmemleak,
some tests may be false negatives. To mitigate that (i.e., to have more
stable results), the solution of a kmemleak scan at the end (vs. for
each test) was preferred.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 tools/testing/selftests/net/Makefile          |   2 +-
 tools/testing/selftests/net/config            |   2 +
 ..._ref_loop.sh => kmemleak_lwt_dst_cache.sh} | 146 +++++++++++++-----
 3 files changed, 107 insertions(+), 43 deletions(-)
 rename tools/testing/selftests/net/{lwt_dst_cache_ref_loop.sh => kmemleak_lwt_dst_cache.sh} (66%)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6d718b478ed8..eba9dbb5387d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -105,7 +105,7 @@ TEST_PROGS += bpf_offload.py
 TEST_PROGS += ipv6_route_update_soft_lockup.sh
 TEST_PROGS += busy_poll_test.sh
 TEST_GEN_PROGS += proc_net_pktgen
-TEST_PROGS += lwt_dst_cache_ref_loop.sh
+TEST_PROGS += kmemleak_lwt_dst_cache.sh
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3cfef5153823..8c162da21ac8 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -116,3 +116,5 @@ CONFIG_NETKIT=y
 CONFIG_NET_PKTGEN=m
 CONFIG_IPV6_ILA=m
 CONFIG_IPV6_RPL_LWTUNNEL=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KMEMLEAK=y
diff --git a/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh b/tools/testing/selftests/net/kmemleak_lwt_dst_cache.sh
similarity index 66%
rename from tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
rename to tools/testing/selftests/net/kmemleak_lwt_dst_cache.sh
index 881eb399798f..30333f2c83c8 100755
--- a/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
+++ b/tools/testing/selftests/net/kmemleak_lwt_dst_cache.sh
@@ -5,14 +5,12 @@
 #
 # WARNING
 # -------
-# This is just a dummy script that triggers encap cases with possible dst cache
-# reference loops in affected lwt users (see list below). Some cases are
-# pathological configurations for simplicity, others are valid. Overall, we
-# don't want this issue to happen, no matter what. In order to catch any
-# reference loops, kmemleak MUST be used. The results alone are always blindly
-# successful, don't rely on them. Note that the following tests may crash the
-# kernel if the fix to prevent lwtunnel_{input|output|xmit}() reentry loops is
-# not present.
+# This script triggers lwt encap use cases, and checks for any dst cache
+# reference loops in affected lwt users (see list below) thanks to kmemleak.
+# Some configurations are pathological and some others are valid. Overall, we
+# don't want this issue to happen, no matter what, so that's why this selftest
+# exists. Note that this script will probably crash the kernel if commit
+# 986ffb3a57c5 ("net: lwtunnel: fix recursion loops") is not included.
 #
 # Affected lwt users so far (please update accordingly if needed):
 #  - ila_lwt (output only)
@@ -21,6 +19,7 @@
 #  - seg6_iptunnel (both input and output)
 
 source lib.sh
+KMEMLEAK_PATH="/sys/kernel/debug/kmemleak"
 
 check_compatibility()
 {
@@ -106,8 +105,8 @@ setup()
 	ip -netns $beta link set veth0 up &>/dev/null
 	ip -netns $beta link set veth1 up &>/dev/null
 	ip -netns $beta link set lo up &>/dev/null
-	ip -netns $beta route del 2001:db8:2::/64
-	ip -netns $beta route add 2001:db8:2::/64 dev veth1
+	ip -netns $beta route del 2001:db8:2::/64 &>/dev/null
+	ip -netns $beta route add 2001:db8:2::/64 dev veth1 &>/dev/null
 	ip netns exec $beta \
 		sysctl -wq net.ipv6.conf.all.forwarding=1 &>/dev/null
 
@@ -117,115 +116,169 @@ setup()
 	ip -netns $gamma route add 2001:db8:1::/64 \
 		via 2001:db8:2::1 dev veth0 &>/dev/null
 
-	sleep 1
-
 	ip netns exec $alpha ping6 -c 5 -W 1 2001:db8:2::2 &>/dev/null
 	if [ $? != 0 ]; then
 		echo "SKIP: Setup failed."
 		exit $ksft_skip
 	fi
-
-	sleep 1
 }
 
 cleanup()
 {
 	cleanup_ns $alpha $beta $gamma
 	[ $ila_lsmod != 0 ] && modprobe -r ila &>/dev/null
+	kmemleak_clear
+}
+
+name2descr()
+{
+	if [ "$1" == "ila" ] || [ "$1" == "ioam6" ]; then
+		echo "output"
+	elif [ "$1" == "rpl" ] || [ "$1" == "seg6" ]; then
+		echo "input + output"
+	else
+		echo ""
+	fi
+}
+
+log_test_passed()
+{
+	printf "TEST: %-57s  [ OK ]\n" "$1"
+	npassed=$((npassed+1))
+}
+
+log_test_skipped()
+{
+	printf "TEST: %-57s  [SKIP]\n" "$1"
+	nskipped=$((nskipped+1))
+}
+
+log_test_failed()
+{
+	printf "TEST: %-57s  [FAIL]\n" "$1"
+	nfailed=$((nfailed+1))
+}
+
+check_result()
+{
+	if grep -q "$1" <<< "$2"; then
+		log_test_failed "$1 ($(name2descr $1))"
+	else
+		log_test_passed "$1 ($(name2descr $1))"
+	fi
+}
+
+kmemleak_clear()
+{
+	echo clear > "$KMEMLEAK_PATH"
+}
+
+kmemleak_scan()
+{
+	for i in {1..5}; do
+		echo scan > "$KMEMLEAK_PATH"
+	done
+}
+
+kmemleak_result()
+{
+	local output=$(cat "$KMEMLEAK_PATH")
+
+	[ $skip_ila != 0 ] && log_test_skipped "ila ($(name2descr ila))" \
+			   || check_result "ila" "$output"
+
+	[ $skip_ioam6 != 0 ] && log_test_skipped "ioam6 ($(name2descr ioam6))" \
+			   || check_result "ioam6" "$output"
+
+	[ $skip_rpl != 0 ] && log_test_skipped "rpl ($(name2descr rpl))" \
+			   || check_result "rpl" "$output"
+
+	[ $skip_seg6 != 0 ] && log_test_skipped "seg6 ($(name2descr seg6))" \
+			   || check_result "seg6" "$output"
 }
 
 run_ila()
 {
 	if [ $skip_ila != 0 ]; then
-		echo "SKIP: ila (output)"
 		return
 	fi
 
-	ip -netns $beta route del 2001:db8:2::/64
+	ip -netns $beta route del 2001:db8:2::/64 &>/dev/null
 	ip -netns $beta route add 2001:db8:2:0:0:0:0:2/128 \
 		encap ila 2001:db8:2:0 csum-mode no-action ident-type luid \
 			hook-type output \
 		dev veth1 &>/dev/null
-	sleep 1
 
-	echo "TEST: ila (output)"
 	ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
 
-	ip -netns $beta route del 2001:db8:2:0:0:0:0:2/128
-	ip -netns $beta route add 2001:db8:2::/64 dev veth1
-	sleep 1
+	ip -netns $beta route del 2001:db8:2:0:0:0:0:2/128 &>/dev/null
+	ip -netns $beta route add 2001:db8:2::/64 dev veth1 &>/dev/null
 }
 
 run_ioam6()
 {
 	if [ $skip_ioam6 != 0 ]; then
-		echo "SKIP: ioam6 (output)"
 		return
 	fi
 
 	ip -netns $beta route change 2001:db8:2::/64 \
 		encap ioam6 trace prealloc type 0x800000 ns 1 size 4 \
 		dev veth1 &>/dev/null
-	sleep 1
 
-	echo "TEST: ioam6 (output)"
 	ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
+
+	ip -netns $beta route change 2001:db8:2::/64 dev veth1 &>/dev/null
 }
 
 run_rpl()
 {
 	if [ $skip_rpl != 0 ]; then
-		echo "SKIP: rpl (input)"
-		echo "SKIP: rpl (output)"
 		return
 	fi
 
 	ip -netns $beta route change 2001:db8:2::/64 \
 		encap rpl segs 2001:db8:2::2 \
 		dev veth1 &>/dev/null
-	sleep 1
 
-	echo "TEST: rpl (input)"
 	ip netns exec $alpha ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
-
-	echo "TEST: rpl (output)"
 	ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
+
+	ip -netns $beta route change 2001:db8:2::/64 dev veth1 &>/dev/null
 }
 
 run_seg6()
 {
 	if [ $skip_seg6 != 0 ]; then
-		echo "SKIP: seg6 (input)"
-		echo "SKIP: seg6 (output)"
 		return
 	fi
 
 	ip -netns $beta route change 2001:db8:2::/64 \
 		encap seg6 mode inline segs 2001:db8:2::2 \
 		dev veth1 &>/dev/null
-	sleep 1
 
-	echo "TEST: seg6 (input)"
 	ip netns exec $alpha ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
-
-	echo "TEST: seg6 (output)"
 	ip netns exec $beta ping6 -c 2 -W 1 2001:db8:2::2 &>/dev/null
-	sleep 1
+
+	ip -netns $beta route change 2001:db8:2::/64 dev veth1 &>/dev/null
 }
 
 run()
 {
+	kmemleak_clear
+
 	run_ila
 	run_ioam6
 	run_rpl
 	run_seg6
+
+	kmemleak_scan
+	kmemleak_result
 }
 
+npassed=0
+nskipped=0
+nfailed=0
+
 if [ "$(id -u)" -ne 0 ]; then
 	echo "SKIP: Need root privileges."
 	exit $ksft_skip
@@ -236,6 +289,11 @@ if [ ! -x "$(command -v ip)" ]; then
 	exit $ksft_skip
 fi
 
+if [ ! -e $KMEMLEAK_PATH ]; then
+	echo "SKIP: Kmemleak not available."
+	exit $ksft_skip
+fi
+
 check_compatibility
 
 trap cleanup EXIT
@@ -243,4 +301,8 @@ trap cleanup EXIT
 setup
 run
 
+if [ $nfailed != 0 ]; then
+	exit $ksft_fail
+fi
+
 exit $ksft_pass
-- 
2.34.1


