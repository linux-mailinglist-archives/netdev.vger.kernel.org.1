Return-Path: <netdev+bounces-295746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jzp1NPaaImpQawEAu9opvQ
	(envelope-from <netdev+bounces-295746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4527E64700A
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:46:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZvUqLoAI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295746-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50BE930D29A6
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700924183CF;
	Fri,  5 Jun 2026 09:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D924C6F10;
	Fri,  5 Jun 2026 09:22:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651350; cv=none; b=puFH/gg+rZM48CxfyYO6/w5LdlzCbqIvc8VPhRP2lxfZtY2AJoF1q3OOd0pANDbxqBIbsBif8cFhaP/CZ6UvK0y8mMAvBRdDOaL9cdJhQ1/Yqgiz7gOJtOVWrc6BxLEwO6NAjUiMckmQojbry+AUcV1zP0bNS/0ZeF2LNg/pDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651350; c=relaxed/simple;
	bh=NPGw4X4fLrlXq/IXuaSruunQE9lHk+haQqHodKLaRR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OVA9UobUgEOdvX8/0+g05PMjZ6sFNohl4V6HTtN0urUOK6d7iQmgqSndfBs5h3vbxgu+GTlxI4K71GCu0D2nJ7KJN5jr/+2pCIcM4QDKogNQ99W20Sa+KSU8vaO8XJDBzp2BCqX7nB7bG+me5a1xEC83hT6qMWZt/7VjSNeu8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvUqLoAI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE6A1F00898;
	Fri,  5 Jun 2026 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780651348;
	bh=LNzX65lRzjXqN9lAi3wGCZ2iibtzhSOt0UHLMsdmBLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZvUqLoAILNa4C1cN8OPLmXkDqvdsLK189c17BRPWbM3RggQ3A3/46xwdTJ+PFs+Mx
	 9IQCthGxncDSn6D5HSHYSWkVWldyihs7v8iyRkJkOEArGqaxBqIohHUUEDKNeXow02
	 XfoU4M9pIP5JSF3b2nMu9zzaCc9uKpzFu24Hoe6/jGLrJkmbdpz+wy4dkbRaG+MFaO
	 AVtEGthTgKr8HHJWLqFztUcmsQluFNuStG5c1CA7eCUOwwu4ZGTL1wN7OgWVSVDkCL
	 Cgxf6Gr1JlIpUUazXLgYDgiA8zaCsuBxZHfNlWvyxeH+tFAFa6xNABx+mv3cIIS9Gd
	 3Y0TfdLbxATCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Jun 2026 19:21:52 +1000
Subject: [PATCH net-next v2 08/15] selftests: mptcp: always check
 sent/dropped ADD_ADDRs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-net-next-mptcp-add-addr6-port-ts-v2-8-758e7ca73f4d@kernel.org>
References: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4991; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NPGw4X4fLrlXq/IXuaSruunQE9lHk+haQqHodKLaRR8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqIpUx057J4XT78k2Rdvqx81dB8e0+n95DMFEln
 voRanuhbIyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCaiKVMQAKCRD2t4JPQmmg
 c2QjD/9lAmZRdGddMRA0ucOeKK3uIWl8bGmVnhVzWHNBxgHoPi1FqEJ9UHTQlUZjTBXslFiJYdG
 iwOwlVAPo9FkxQo/yGYYK4YThkc7eBfMQhs/Wk01VwYCnQuUNDAEC1pF1UAW928VNTpPc07XseD
 gzPLIPlF4JXqu3DMgIdNGyjs8KI0mOMWJScJwXqQqGDzHp27fz1PGYzgKHNXrZMN5fAvY9Wx5ef
 dVWJEiuCYeK3nbRT7Ad+rqzJttbcw5chMIZYuB0WX5rp3BP4aZ/ZWD9bZX6jtusa+yCbTe3Gd6o
 Bn608RpuS13OGdGfK4IHFwVl4S1GDUoHMYnG8a/hJHUdh8KJus2mnS0BD5Fy/5bNbVBbHy0xVMU
 lsq3GGnMd3cEDe9p+TEE+7QyyAwSd6wqoilyffmyZ22p+cS/BXmIG3Vs5x3fKHslGMW18GgK9HD
 JniKeqSLGnPS9eHiD9F96Lpvexyhcb5ADv6kG6AMVghHUjmUU+LOz0mN+vUFNJIAWiQ+QCpL3/U
 H2hcfKcYaaxSlrNpe+4KSgXLqEJmdqJGogXQs8doA7//F6odKINe+ETAJBgKrfPWyKJWnys2bo4
 HBbbnZgaHrfomfzwEM22JPnDFGBb7cEqLPCNijCeanU1H2ywy1cjzjPcJoTTDBm19WqkjI3wN6A
 AMVlroCzs27ixzQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295746-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4527E64700A

Before, they were only checked on demand, but it seems better to check
them each time received ADD_ADDRs are checked.

Errors are only reported when the counter exists, and the value is not
the expected one. This is similar to what is done in chk_join_nr: it
reduces the output, and avoids a lot of 'skip' when validating older
kernels. Also here, some tests need to adapt the default expected
counters, e.g. when ADD_ADDR echo are dropped on the reception side, or
it is not possible to send an ADD_ADDR due to the limited option space.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 71 ++++++++++---------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6aba8f97275a..c0aeffd5cb71 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -87,6 +87,10 @@ unset fb_mpc_data
 unset fb_md5_sig
 unset fb_dss
 
+unset add_addr_tx_nr
+unset add_addr_echo_tx_nr
+unset add_addr_drop_tx_nr
+
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
 CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
@@ -1710,6 +1714,9 @@ chk_add_nr()
 	local ack_nr=$port_nr
 	local mis_syn_nr=0
 	local mis_ack_nr=0
+	local add_tx_nr=${add_addr_tx_nr:-${add_nr}}
+	local echo_tx_nr=${add_addr_echo_tx_nr:-${echo_nr}}
+	local drop_tx_nr=${add_addr_drop_tx_nr:-0}
 	local ns_tx=$ns1
 	local ns_rx=$ns2
 	local tx=""
@@ -1811,50 +1818,25 @@ chk_add_nr()
 			print_ok
 		fi
 	fi
-}
 
-chk_add_tx_nr()
-{
-	local add_tx_nr=$1
-	local echo_tx_nr=$2
-	local count
-
-	print_check "add addr tx"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTx")
-	if [ -z "$count" ]; then
-		print_skip
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtAddAddrTx")
 	# Tolerate more ADD_ADDR then expected (if any), due to retransmissions
-	elif [ "$count" != "$add_tx_nr" ] &&
-	     { [ "$add_tx_nr" -eq 0 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+	if [ -n "$count" ] && [ "$count" != "$add_tx_nr" ] &&
+	   { [ "$add_tx_nr" -eq 0 ] || [ "$count" -lt "$add_tx_nr" ]; }; then
+		print_check "add addr tx"
 		fail_test "got $count ADD_ADDR[s] TX, expected $add_tx_nr"
-	else
-		print_ok
 	fi
 
-	print_check "add addr echo tx"
-	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtEchoAddTx")
-	if [ -z "$count" ]; then
-		print_skip
-	elif [ "$count" != "$echo_tx_nr" ]; then
+	count=$(mptcp_lib_get_counter ${ns_rx} "MPTcpExtEchoAddTx")
+	if [ -n "$count" ] && [ "$count" != "$echo_tx_nr" ]; then
+		print_check "add addr echo tx"
 		fail_test "got $count ADD_ADDR echo[s] TX, expected $echo_tx_nr"
-	else
-		print_ok
 	fi
-}
 
-chk_add_drop_tx_nr()
-{
-	local drop_tx_nr=$1
-	local count
-
-	print_check "add addr tx drop"
-	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
-	if [ -z "$count" ]; then
-		print_skip
-	elif [ "$count" != "$drop_tx_nr" ]; then
+	count=$(mptcp_lib_get_counter ${ns_tx} "MPTcpExtAddAddrTxDrop")
+	if [ -n "$count" ] && [ "$count" != "$drop_tx_nr" ]; then
+		print_check "add addr tx drop"
 		fail_test "got $count ADD_ADDR drop[s] TX, expected $drop_tx_nr"
-	else
-		print_ok
 	fi
 }
 
@@ -2267,7 +2249,6 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_add_tx_nr 1 1
 		chk_add_nr 1 1
 	fi
 
@@ -2545,8 +2526,8 @@ add_addr_timeout_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
-		chk_add_tx_nr 4 4
-		chk_add_nr 4 0
+		add_addr_echo_tx_nr=4 \
+			chk_add_nr 4 0
 	fi
 
 	# add_addr timeout IPv6
@@ -2557,7 +2538,8 @@ add_addr_timeout_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 1 1 1
-		chk_add_nr 4 0
+		add_addr_echo_tx_nr=4 \
+			chk_add_nr 4 0
 	fi
 
 	# signal addresses timeout
@@ -2569,7 +2551,8 @@ add_addr_timeout_tests()
 		speed=10 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_add_nr 8 0
+		add_addr_echo_tx_nr=8 \
+			chk_add_nr 8 0
 	fi
 
 	# signal invalid addresses timeout
@@ -2582,7 +2565,8 @@ add_addr_timeout_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		join_syn_tx=2 \
 			chk_join_nr 1 1 1
-		chk_add_nr 8 0
+		add_addr_echo_tx_nr=7 \
+			chk_add_nr 8 0
 	fi
 }
 
@@ -3331,9 +3315,8 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
 		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
 		run_tests $ns1 $ns2 dead:beef:1::1
-		chk_add_drop_tx_nr 1
-		chk_add_tx_nr 1 1
-		chk_add_nr 1 1 0
+		add_addr_drop_tx_nr=1 \
+			chk_add_nr 1 1 0
 	fi
 }
 

-- 
2.53.0


