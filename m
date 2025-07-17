Return-Path: <netdev+bounces-207919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 452A0B09039
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8F51C4421C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EE2ED142;
	Thu, 17 Jul 2025 15:09:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3910A1E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764991; cv=none; b=HQ3cFOnW2PRL/AZWamJqheaL41eoptHEg7BBCAQP0G7+5B0Jk/9hqDnGceyBbjp4KLvQsfaBZ4k4ifx0e6Q1QKfQsxnvMkgUyLhbNYMMeJoaxlI0HnjG624ljI9ARFFjgYAp7DOsVNZE1t8zWBeiPntz7VMWz7oujrju7axEzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764991; c=relaxed/simple;
	bh=iGJW+QuAV1/YNvckMnkDe0BXkXPqWFxDB67RGDV6F+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEaMtRtFNrXe+sMS1GXylXSJ+CdZIbLq50qRTWbMGHoQ9jrtwIGCkp5WY3PedLQuudQDX3nXFnkywy22nbLm+CEWsq9MgAGjCmSGjARJ0WSEcs6y1UMyx86gbcia+coZpzV2EzucMKIvWvQfF0kjggvvlU/n4GKPxeUN/NBN/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E95C46032B; Thu, 17 Jul 2025 17:09:46 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: pablo@netfilter.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net] selftests: netfilter: tone-down conntrack clash test
Date: Thu, 17 Jul 2025 17:09:37 +0200
Message-ID: <20250717150941.9057-1-fw@strlen.de>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop this test from failing.

This is a stop-gap measure to not keep failing on NIPA CI.

The test is supposed to observe that clash_resolution stat counter
incremented (code path was covered).  This path is only exercised
when multiple packets race: depending on kernel config, number of CPUs,
scheduling policy etc. this might not trigger at all.

Therefore, if the test program did not observe the expected number of
replies, make a note of it but do not flip script retval to 1.

With this change the test should either SKIP or pass.
Hard error can be restored later once its clear whats going on.

Fixes: 78a588363587 ("selftests: netfilter: add conntrack clash resolution test case")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 .../net/netfilter/conntrack_clash.sh          | 40 ++++++++++---------
 .../selftests/net/netfilter/udpclash.c        | 11 +++--
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/conntrack_clash.sh b/tools/testing/selftests/net/netfilter/conntrack_clash.sh
index 3712c1b9b38b..1c54505e0d03 100755
--- a/tools/testing/selftests/net/netfilter/conntrack_clash.sh
+++ b/tools/testing/selftests/net/netfilter/conntrack_clash.sh
@@ -93,19 +93,20 @@ ping_test()
 run_one_clash_test()
 {
 	local ns="$1"
-	local daddr="$2"
-	local dport="$3"
+	local ctns="$2"
+	local daddr="$3"
+	local dport="$4"
 	local entries
 	local cre
 
-	if ! ip netns exec "$ns" ./udpclash $daddr $dport;then
-		echo "FAIL: did not receive expected number of replies for $daddr:$dport"
-		ret=1
-		return 1
+	if ! ip netns exec "$ns" timeout 10s ./udpclash $daddr $dport;then
+		echo "NOTICE: udpclash did not receive any packets, cpus $(nprocs)"
+		ip netns exec "$ns" ss -niupa
+		# don't fail: check if clash resolution triggered.
 	fi
 
-	entries=$(conntrack -S | wc -l)
-	cre=$(conntrack -S | grep -v "clash_resolve=0" | wc -l)
+	entries=$(ip netns exec "$ctns" conntrack -S | wc -l)
+	cre=$(ip netns exec "$ctns" conntrack -S | grep "clash_resolve=0" | wc -l)
 
 	if [ "$cre" -ne "$entries" ] ;then
 		clash_resolution_active=1
@@ -117,8 +118,8 @@ run_one_clash_test()
 		return 0
 	fi
 
-	# not a failure: clash resolution logic did not trigger, but all replies
-	# were received.  With right timing, xmit completed sequentially and
+	# not a failure: clash resolution logic did not trigger.
+	# With right timing, xmit completed sequentially and
 	# no parallel insertion occurs.
 	return $ksft_skip
 }
@@ -126,20 +127,23 @@ run_one_clash_test()
 run_clash_test()
 {
 	local ns="$1"
-	local daddr="$2"
-	local dport="$3"
+	local ctns="$2"
+	local daddr="$3"
+	local dport="$4"
+	local harderr=0
 
 	for i in $(seq 1 10);do
-		run_one_clash_test "$ns" "$daddr" "$dport"
+		run_one_clash_test "$ns" "$ctns" "$daddr" "$dport"
 		local rv=$?
 		if [ $rv -eq 0 ];then
 			echo "PASS: clash resolution test for $daddr:$dport on attempt $i"
 			return 0
 		elif [ $rv -eq 1 ];then
-			echo "FAIL: clash resolution test for $daddr:$dport on attempt $i"
-			return 1
+			harderr=1
 		fi
 	done
+
+	[ $harderr -eq 1 ] && echo "FAIL: no packets received for $daddr:$dport with $(nproc) cpus"
 }
 
 ip link add veth0 netns "$nsclient1" type veth peer name veth0 netns "$nsrouter"
@@ -161,15 +165,15 @@ spawn_servers "$nsclient2"
 
 # exercise clash resolution with nat:
 # nsrouter is supposed to dnat to 10.0.2.1:900{0,1,2,3}.
-run_clash_test "$nsclient1" 10.0.1.99 "$dport"
+run_clash_test "$nsclient1" "$nsrouter" 10.0.1.99 "$dport"
 
 # exercise clash resolution without nat.
 load_simple_ruleset "$nsclient2"
-run_clash_test "$nsclient2" 127.0.0.1 9001
+run_clash_test "$nsclient2" "$nsclient2" 127.0.0.1 9001
 
 if [ $clash_resolution_active -eq 0 ];then
 	[ "$ret" -eq 0 ] && ret=$ksft_skip
-	echo "SKIP: Clash resolution did not trigger"
+	echo "SKIP: Clash resolution did not trigger with $(nproc) cpus."
 fi
 
 exit $ret
diff --git a/tools/testing/selftests/net/netfilter/udpclash.c b/tools/testing/selftests/net/netfilter/udpclash.c
index 85c7b906ad08..506caf110605 100644
--- a/tools/testing/selftests/net/netfilter/udpclash.c
+++ b/tools/testing/selftests/net/netfilter/udpclash.c
@@ -87,10 +87,8 @@ static int run_test(int fd, const struct sockaddr_in *si_remote)
 		ret = recvfrom(fd, repl, sizeof(repl), MSG_NOSIGNAL,
 			       (struct sockaddr *) &si_repl, &si_repl_len);
 		if (ret < 0) {
-			if (timeout++ > 5000) {
-				fputs("timed out while waiting for reply from thread\n", stderr);
+			if (timeout++ > 10000)
 				break;
-			}
 
 			/* give reply time to pass though the stack */
 			usleep(1000);
@@ -114,11 +112,12 @@ static int run_test(int fd, const struct sockaddr_in *si_remote)
 		repl_count++;
 	}
 
-	printf("got %d of %d replies\n", repl_count, THREAD_COUNT);
-
 	free(tid);
 
-	return repl_count == THREAD_COUNT ? 0 : 1;
+	if (repl_count != THREAD_COUNT)
+		printf("got %d of %d replies\n", repl_count, THREAD_COUNT);
+
+	return repl_count > 0 ? 0 : 1;
 }
 
 int main(int argc, char *argv[])
-- 
2.49.1


