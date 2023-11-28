Return-Path: <netdev+bounces-51892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38EB7FCAAB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7045C28313C
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A15733C;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+KA4Co0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858957330;
	Tue, 28 Nov 2023 23:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0389C433CD;
	Tue, 28 Nov 2023 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213563;
	bh=VICeTQMvfwsJ1A3zm3oULuQjpMdGkLilRb1+eN2aGKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s+KA4Co05wJgFZV5LfvK/zY6dajD8wUY+dgUQqU20BVX0relLLleLGkBK27K1pbYm
	 myywQNaQ/qKjuDZEhH2NNSNWDyZlkph61yQ5P663/lnSeorrg0Z1Gm2qOOt0B8vZcE
	 vybwGjt44l5eudiU3TX9U7tBRXVC9dDUqfH10B4TevZyb//4jodjkweVZwiP3J8KMH
	 eIja5ydTNlaExN1ehYcgjuFY56QJ3S8spujJLJJD9qNmxYsKAr5w1tOuPM5GSMYzsv
	 fSYq7eWg6lZLZvBjrbMEpOuoDpCQiHxPtPC4WQhfAdwtR7CBGbxSJKTGs/iAoT9xLf
	 fQcOuhgTRIogg==
From: Mat Martineau <martineau@kernel.org>
Date: Tue, 28 Nov 2023 15:18:46 -0800
Subject: [PATCH net-next v4 02/15] selftests: mptcp: add evts_get_info
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-send-net-next-2023107-v4-2-8d6b94150f6b@kernel.org>
References: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
In-Reply-To: <20231128-send-net-next-2023107-v4-0-8d6b94150f6b@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

From: Geliang Tang <geliang.tang@suse.com>

This patch adds a new helper get_info_value(), using 'sed' command to
parse the value of the given item name in the line with the given keyword,
to make chk_mptcp_info() and pedit_action_pkts() more readable.

Also add another helper evts_get_info() to use get_info_value() to parse
the output of 'pm_nl_ctl events' command, to make all the userspace pm
selftests more readable, both in mptcp_join.sh and userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 19 +++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 10 +++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 86 ++++++++++-------------
 3 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3c94f2f194d6..d24b0e5e73ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1869,10 +1869,8 @@ chk_mptcp_info()
 
 	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
 
-	cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
-	       sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
-	cnt2=$(ss -N $ns2 -inmHM | grep "$info2:" |
-	       sed -n 's/.*\('"$info2"':\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
+	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -2848,13 +2846,13 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
+	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
+	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
 	else
-		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
@@ -3249,8 +3247,7 @@ fastclose_tests()
 pedit_action_pkts()
 {
 	tc -n $ns2 -j -s action show action pedit index 100 | \
-		grep "packets" | \
-		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
+		mptcp_lib_get_info_value \"packets\" packets
 }
 
 fail_tests()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 92a5befe8039..56cbd57abbae 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -207,3 +207,13 @@ mptcp_lib_result_print_all_tap() {
 		printf "%s\n" "${subtest}"
 	done
 }
+
+# get the value of keyword $1 in the line marked by keyword $2
+mptcp_lib_get_info_value() {
+	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+}
+
+# $1: info name ; $2: evts_ns ; $3: event type
+mptcp_lib_evts_get_info() {
+	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b25a3e33eb25..2413059a42e5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -247,14 +247,11 @@ make_connection()
 	local server_token
 	local server_serverside
 
-	client_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
-	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$client_evts")
-	server_token=$(grep "type:1," "$server_evts" |
-		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
-	server_serverside=$(grep "type:1," "$server_evts" |
-			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
+	client_token=$(mptcp_lib_evts_get_info token "$client_evts")
+	client_port=$(mptcp_lib_evts_get_info sport "$client_evts")
+	client_serverside=$(mptcp_lib_evts_get_info server_side "$client_evts")
+	server_token=$(mptcp_lib_evts_get_info token "$server_evts")
+	server_serverside=$(mptcp_lib_evts_get_info server_side "$server_evts")
 
 	print_test "Established IP${is_v6} MPTCP Connection ns2 => ns1"
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
@@ -340,16 +337,16 @@ verify_announce_event()
 	local dport
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
 	if [ "$e_af" = "v6" ]
 	then
-		addr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		addr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		addr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "addr" "dport" "id"
 }
@@ -367,7 +364,7 @@ test_announce()
 	   $client_addr_id dev ns2eth1 > /dev/null 2>&1
 
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	print_test "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token"
 	if [ "$type" = "" ]
 	then
@@ -446,9 +443,9 @@ verify_remove_event()
 	local token
 	local id
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	id=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	id=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 
 	check_expected "type" "token" "id"
 }
@@ -466,7 +463,7 @@ test_remove()
 	   $client_addr_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${client_addr_id} ns2 => ns1, invalid token"
 	local type
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -479,7 +476,7 @@ test_remove()
 	ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id\
 	   $invalid_id > /dev/null 2>&1
 	print_test "RM_ADDR id:${invalid_id} ns2 => ns1, invalid id"
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	type=$(mptcp_lib_evts_get_info type "$server_evts")
 	if [ "$type" = "" ]
 	then
 		test_pass
@@ -583,19 +580,19 @@ verify_subflow_events()
 		fi
 	fi
 
-	type=$(sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	family=$(sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	dport=$(sed --unbuffered -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	locid=$(sed --unbuffered -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
-	remid=$(sed --unbuffered -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
+	type=$(mptcp_lib_evts_get_info type "$evt" $e_type)
+	token=$(mptcp_lib_evts_get_info token "$evt" $e_type)
+	family=$(mptcp_lib_evts_get_info family "$evt" $e_type)
+	dport=$(mptcp_lib_evts_get_info dport "$evt" $e_type)
+	locid=$(mptcp_lib_evts_get_info loc_id "$evt" $e_type)
+	remid=$(mptcp_lib_evts_get_info rem_id "$evt" $e_type)
 	if [ "$family" = "$AF_INET6" ]
 	then
-		saddr=$(sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr6 "$evt" $e_type)
 	else
-		saddr=$(sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
-		daddr=$(sed --unbuffered -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
+		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" $e_type)
+		daddr=$(mptcp_lib_evts_get_info daddr4 "$evt" $e_type)
 	fi
 
 	check_expected "type" "token" "daddr" "dport" "family" "saddr" "locid" "remid"
@@ -630,7 +627,7 @@ test_subflows()
 	kill_wait $listener_pid
 
 	local sport
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -668,7 +665,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from server to client machine
 	:>"$server_evts"
@@ -707,7 +704,7 @@ test_subflows()
 	# Delete the listener from the client ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$server_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from server to client machine
 	:>"$server_evts"
@@ -745,7 +742,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -784,7 +781,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW6 from client to server machine
 	:>"$client_evts"
@@ -821,7 +818,7 @@ test_subflows()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -867,7 +864,7 @@ test_subflows_v4_v6_mix()
 	# Delete the listener from the server ns, if one was created
 	kill_wait $listener_pid
 
-	sport=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
+	sport=$(mptcp_lib_evts_get_info sport "$client_evts" $SUB_ESTABLISHED)
 
 	# DESTROY_SUBFLOW from client to server machine
 	:>"$client_evts"
@@ -933,18 +930,13 @@ verify_listener_events()
 		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(mptcp_lib_evts_get_info type $evt $e_type)
+	family=$(mptcp_lib_evts_get_info family $evt $e_type)
+	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
 	fi
 
 	check_expected "type" "family" "saddr" "sport"

-- 
2.43.0


