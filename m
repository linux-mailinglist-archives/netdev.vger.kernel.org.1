Return-Path: <netdev+bounces-48219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015967ED88D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 01:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9155B20A52
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32DA6FC2;
	Thu, 16 Nov 2023 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2vdHSv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7763C2;
	Thu, 16 Nov 2023 00:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0859C433C8;
	Thu, 16 Nov 2023 00:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700094712;
	bh=G71lLpDxX6kFXjhdOVS0qXeBjx9Toz63+e21f7hLf7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W2vdHSv4Rr3Qozj5e/RjfERFxcX2BHvrvmR0dbwagRVdPqjuzSloGSEK8tbDATep6
	 dJhr9lNcSVCd3LFwQVs2h+OrkkKz4B5gA8n4eLHTU3+KMt/16OLg+vmB9Ne1tWAoQG
	 2Po0kIrHpq5ksazU6dx6hSKXuqUGHyxfhaYVZ4RANay+mUxLu6L6+xlsTZIT4Exx/F
	 RiZgpXhoS+fO4wBnhyfE7D2Ooi6rEzY9jYkuPiWlh/eHpslINexkP9OnovV71uV7U/
	 bd4R7dYx56lkWtTPoq+bqaeSNuG6D8ErKN8Gt6JvMz648GYs88s16pOku6tM6sEbAl
	 YXXAQPF/eE3hw==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 15 Nov 2023 16:31:37 -0800
Subject: [PATCH net-next v3 09/15] selftests: mptcp: add
 mptcp_lib_kill_wait
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231115-send-net-next-2023107-v3-9-1ef58145a882@kernel.org>
References: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
In-Reply-To: <20231115-send-net-next-2023107-v3-0-1ef58145a882@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

To avoid duplicated code in different MPTCP selftests, we can add
and use helpers defined in mptcp_lib.sh.

Export kill_wait() helper in userspace_pm.sh into mptcp_lib.sh and
rename it as mptcp_lib_kill_wait(). It can be used to instead of
kill_wait() in mptcp_join.sh. Use the new helper in both scripts.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 10 ++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    |  9 +++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 31 ++++++++---------------
 3 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a2b58cf71bef..c6ebe2143ef0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -682,16 +682,10 @@ wait_mpj()
 	done
 }
 
-kill_wait()
-{
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 kill_events_pids()
 {
-	kill_wait $evts_ns1_pid
-	kill_wait $evts_ns2_pid
+	mptcp_lib_kill_wait $evts_ns1_pid
+	mptcp_lib_kill_wait $evts_ns2_pid
 }
 
 kill_tests_wait()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 56cbd57abbae..e421b658d748 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -217,3 +217,12 @@ mptcp_lib_get_info_value() {
 mptcp_lib_evts_get_info() {
 	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
 }
+
+# $1: PID
+mptcp_lib_kill_wait() {
+	[ "${1}" -eq 0 ] && return 0
+
+	kill -SIGUSR1 "${1}" > /dev/null 2>&1
+	kill "${1}" > /dev/null 2>&1
+	wait "${1}" 2>/dev/null
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 2413059a42e5..f4e352494f05 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -108,15 +108,6 @@ test_fail()
 	mptcp_lib_result_fail "${test_name}"
 }
 
-kill_wait()
-{
-	[ $1 -eq 0 ] && return 0
-
-	kill -SIGUSR1 $1 > /dev/null 2>&1
-	kill $1 > /dev/null 2>&1
-	wait $1 2>/dev/null
-}
-
 # This function is used in the cleanup trap
 #shellcheck disable=SC2317
 cleanup()
@@ -128,7 +119,7 @@ cleanup()
 	for pid in $client4_pid $server4_pid $client6_pid $server6_pid\
 		   $server_evts_pid $client_evts_pid
 	do
-		kill_wait $pid
+		mptcp_lib_kill_wait $pid
 	done
 
 	local netns
@@ -210,7 +201,7 @@ make_connection()
 	fi
 	:>"$client_evts"
 	if [ $client_evts_pid -ne 0 ]; then
-		kill_wait $client_evts_pid
+		mptcp_lib_kill_wait $client_evts_pid
 	fi
 	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
 	client_evts_pid=$!
@@ -219,7 +210,7 @@ make_connection()
 	fi
 	:>"$server_evts"
 	if [ $server_evts_pid -ne 0 ]; then
-		kill_wait $server_evts_pid
+		mptcp_lib_kill_wait $server_evts_pid
 	fi
 	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
 	server_evts_pid=$!
@@ -624,7 +615,7 @@ test_subflows()
 			      "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	local sport
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
@@ -663,7 +654,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -702,7 +693,7 @@ test_subflows()
 			      "$client_addr_id" "ns1" "ns2"
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
@@ -740,7 +731,7 @@ test_subflows()
 			      "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -779,7 +770,7 @@ test_subflows()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -816,7 +807,7 @@ test_subflows()
 			      "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -862,7 +853,7 @@ test_subflows_v4_v6_mix()
 			      "$server_addr_id" "ns2" "ns1"
 
 	# Delete the listener from the server ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
@@ -974,7 +965,7 @@ test_listener()
 	sleep 0.5
 
 	# Delete the listener from the client ns, if one was created
-	kill_wait $listener_pid
+	mptcp_lib_kill_wait $listener_pid
 
 	sleep 0.5
 	verify_listener_events $client_evts $LISTENER_CLOSED $AF_INET 10.0.2.2 $client4_port

-- 
2.41.0


