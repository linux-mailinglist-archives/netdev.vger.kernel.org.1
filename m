Return-Path: <netdev+bounces-13496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B073BDDD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20EE281CEF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD52D101F1;
	Fri, 23 Jun 2023 17:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F88100D1;
	Fri, 23 Jun 2023 17:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A20BC433CB;
	Fri, 23 Jun 2023 17:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687541656;
	bh=d6pKZ+SkU7uhwd1msSz2Mj63BV+SnwupQiYWOytGZYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k3aQUTEzMwZfudnhvCiiUiZtHexfLwiEnPTKipz4wFRspO1b5GTzb+nTFXdU8RMiA
	 pLuSAB7cmWJtBnI4GWmHRuZf40TBRSQpI3fFGZ6yhx/vkc7A3esDVWBk/JrOpTuilf
	 XI8LMsCFgKp7ZaskksKr5AxAWnMnNiSXOqXX5vp8jHrvSNSiijky8TrUHOmA0wq0VM
	 oVh5PyqSGMu2NCrHtUfW/I2FZUy9F2skQEIDgaV4GLvHvF+RYceTvYY0xGz9+9j/w7
	 1d9RuUd2zWGlDbO4+rEnDrGVbHLLm/Oh/U0Im5S6vBfTkDo7POEPMV4WnP3Yvp7wjm
	 s6DVWwBQoF+mA==
From: Mat Martineau <martineau@kernel.org>
Date: Fri, 23 Jun 2023 10:34:07 -0700
Subject: [PATCH net-next 1/8] selftests: mptcp: test userspace pm out of
 transfer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230623-send-net-next-20230623-v1-1-a883213c8ba9@kernel.org>
References: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
In-Reply-To: <20230623-send-net-next-20230623-v1-0-a883213c8ba9@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2

From: Geliang Tang <geliang.tang@suse.com>

This patch moves userspace pm tests out of do_transfer(). Move add address
test into a new function userspace_pm_add_addr(), and remove address test
into userspace_pm_rm_sf_addr_ns1(). Move add subflow test into
userspace_pm_add_sf() and remove subflow into
userspace_pm_rm_sf_addr_ns2().

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 145 ++++++++++++++++--------
 1 file changed, 99 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a7973d6a40a0..3baa6ac3b03e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -589,6 +589,26 @@ wait_rm_addr()
 	done
 }
 
+rm_sf_count()
+{
+	get_counter "${1}" "MPTcpExtRmSubflow"
+}
+
+# $1: ns, $2: old rm_sf counter in $ns
+wait_rm_sf()
+{
+	local ns="${1}"
+	local old_cnt="${2}"
+	local cnt
+
+	local i
+	for i in $(seq 10); do
+		cnt=$(rm_sf_count ${ns})
+		[ "$cnt" = "${old_cnt}" ] || break
+		sleep 0.1
+	done
+}
+
 wait_mpj()
 {
 	local ns="${1}"
@@ -813,7 +833,6 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
-	local userspace_pm=0
 
 	:> "$cout"
 	:> "$sout"
@@ -850,11 +869,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns1=${addr_nr_ns1:10}
-	fi
-
 	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
@@ -882,9 +896,6 @@ do_transfer()
 			return 1
 		fi
 		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
-		userspace_pm=1
-		addr_nr_ns2=${addr_nr_ns2:10}
 	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
@@ -938,7 +949,6 @@ do_transfer()
 		local counter=2
 		local add_nr_ns1=${addr_nr_ns1}
 		local id=10
-		local tk
 		while [ $add_nr_ns1 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -946,24 +956,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.1"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns1 $addr flags signal
-			else
-				tk=$(grep "type:1," "$evts_ns1" |
-				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				da=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
-				dp=$(grep "type:10" "$evts_ns1" |
-				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
-							lport $sp rip $da rport $dp token $tk
-			fi
-
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			counter=$((counter + 1))
 			add_nr_ns1=$((add_nr_ns1 - 1))
 			id=$((id + 1))
@@ -1008,7 +1001,6 @@ do_transfer()
 		local add_nr_ns2=${addr_nr_ns2}
 		local counter=3
 		local id=20
-		local tk da dp sp
 		while [ $add_nr_ns2 -gt 0 ]; do
 			local addr
 			if is_v6 "${connect_addr}"; then
@@ -1016,21 +1008,7 @@ do_transfer()
 			else
 				addr="10.0.$counter.2"
 			fi
-			if [ $userspace_pm -eq 0 ]; then
-				pm_nl_add_endpoint $ns2 $addr flags $flags
-			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
-				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
-				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
-									rip $da rport $dp token $tk
-				sleep 1
-				sp=$(grep "type:10" "$evts_ns2" |
-				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
-				ip netns exec ${connector_ns} ./pm_nl_ctl rem token $tk id $id
-				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
-									rip $da rport $dp token $tk
-			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
 			id=$((id + 1))
@@ -3205,6 +3183,71 @@ fail_tests()
 	fi
 }
 
+userspace_pm_add_addr()
+{
+	local addr=$1
+	local id=$2
+	local tk
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl ann $addr token $tk id $id
+	sleep 1
+}
+
+userspace_pm_rm_sf_addr_ns1()
+{
+	local addr=$1
+	local id=$2
+	local tk sp da dp
+
+	tk=$(grep "type:1," "$evts_ns1" |
+	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	sp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	da=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+	dp=$(grep "type:10" "$evts_ns1" |
+	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
+				lport $sp rip $da rport $dp token $tk
+	wait_rm_addr $ns1 1
+	wait_rm_sf $ns1 1
+}
+
+userspace_pm_add_sf()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	ip netns exec $ns2 ./pm_nl_ctl csf lip $addr lid $id \
+				rip $da rport $dp token $tk
+	sleep 1
+}
+
+userspace_pm_rm_sf_addr_ns2()
+{
+	local addr=$1
+	local id=$2
+	local tk da dp sp
+
+	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
+	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
+	sp=$(grep "type:10" "$evts_ns2" |
+	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
+	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
+				rip $da rport $dp token $tk
+	wait_rm_addr $ns2 1
+	wait_rm_sf $ns2 1
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3283,11 +3326,16 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		userspace_pm_rm_sf_addr_ns1 10.0.2.1 10
 		chk_rm_nr 1 1 invert
 		kill_events_pids
+		wait $tests_pid
 	fi
 
 	# userspace pm create destroy subflow
@@ -3295,10 +3343,15 @@ userspace_tests()
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf 10.0.3.2 20
 		chk_join_nr 1 1 1
+		userspace_pm_rm_sf_addr_ns2 10.0.3.2 20
 		chk_rm_nr 1 1
 		kill_events_pids
+		wait $tests_pid
 	fi
 }
 

-- 
2.41.0


