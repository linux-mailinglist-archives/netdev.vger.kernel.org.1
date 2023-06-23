Return-Path: <netdev+bounces-13495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B359073BDDC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AEB1C21286
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87676101D8;
	Fri, 23 Jun 2023 17:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E50100D2;
	Fri, 23 Jun 2023 17:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF1AC433CA;
	Fri, 23 Jun 2023 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541657;
	bh=xnhNQTbdaLg0oa0Bye/Mc1559cQpu4SInzxc6ZKQltA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g/bdkIedtPkInWs6XJrjUPs+KsRKgIlQmgZBpWb9Q111gBNx6/S3pcgUHeK6uNIOr
	 /fKXCVN/aaB7oHBe1Kvi0bIJERyrAJw0MTsPyLSDYaWeaNDgDvL0MOJdTxQ/zZObh9
	 +2nDE0JbgZdgUR/SOQR/IV8kVp5jx3CffpW85L4w8yiUORDcAQIecJesfRgsKRYcig
	 IDop+eOQi7wZTQs/DO38cBULM0V2CEmjd7yC42YE4eOlFDuGi3J1KekDOmlqNXbqzy
	 xZBdp1BznKUE7yng+CrF4HFPDzjGIhAsitHwKO/2Iz6gOO9bJEsc8z2DwtWC3vx/r1
	 cuRGqXBI/VlrQ==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 23 Jun 2023 10:34:08 -0700
Subject: [PATCH net-next 2/8] selftests: mptcp: check subflow and addr
 infos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-send-net-next-20230623-v1-2-a883213c8ba9@kernel.org>
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2

From: Geliang Tang <geliang.tang@suse.com>

New MPTCP info are being checked in multiple places to improve the code
coverage when using the userspace PM.

This patch makes chk_mptcp_info() more generic to be able to check
subflows, add_addr_signal and add_addr_accepted info (and even more
later). New arguments are now required to get different infos from the
two namespaces because some counters are specific to the client or the
server.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3baa6ac3b03e..95a56384294f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1832,31 +1832,26 @@ chk_subflow_nr()
 
 chk_mptcp_info()
 {
-	local nr_info=$1
-	local info
+	local info1=$1
+	local exp1=$2
+	local info2=$3
+	local exp2=$4
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	if [[ $nr_info = "subflows_"* ]]; then
-		info="subflows"
-		nr_info=${nr_info:9}
-	else
-		echo "[fail] unsupported argument: $nr_info"
-		fail_test
-		return 1
-	fi
-
-	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
+	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
+	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
+	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info:" |
-		sed -n 's/.*\('"$info"':\)\([[:digit:]]*\).*$/\2/p;q')
 	[ -z "$cnt2" ] && cnt2=0
-	if [ "$cnt1" != "$nr_info" ] || [ "$cnt2" != "$nr_info" ]; then
-		echo "[fail] got $cnt1:$cnt2 $info expected $nr_info"
+
+	if [ "$cnt1" != "$exp1" ] || [ "$cnt2" != "$exp2" ]; then
+		echo "[fail] got $cnt1:$cnt2 $info1:$info2 expected $exp1:$exp2"
 		fail_test
 		dump_stats=1
 	else
@@ -3332,8 +3327,11 @@ userspace_tests()
 		userspace_pm_add_addr 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3348,8 +3346,10 @@ userspace_tests()
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
 		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
+		chk_mptcp_info subflows 0 subflows 0
 		kill_events_pids
 		wait $tests_pid
 	fi
@@ -3369,6 +3369,8 @@ endpoint_tests()
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
+		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
@@ -3389,17 +3391,17 @@ endpoint_tests()
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
 		sleep 0.5
 		chk_subflow_nr "" "after delete" 1
-		chk_mptcp_info subflows_0
+		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		wait_mpj $ns2
 		chk_subflow_nr "" "after re-add" 2
-		chk_mptcp_info subflows_1
+		chk_mptcp_info subflows 1 subflows 1
 		kill_tests_wait
 	fi
 }

-- 
2.41.0


