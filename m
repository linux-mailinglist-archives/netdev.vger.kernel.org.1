Return-Path: <netdev+bounces-293550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGGBCaMYHWrtVgkAu9opvQ
	(envelope-from <netdev+bounces-293550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:29:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2050B619AE3
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C4E3301CEF9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBDF3438BE;
	Mon,  1 Jun 2026 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW98Z4Ud"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E132ABCD;
	Mon,  1 Jun 2026 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291517; cv=none; b=LfrBINuN4raXkDw5QTyIIC1h1hsKLlxZSbXycjr/R+a5vGs73aOXGCk8bpdMyu+cMwlgkaliUgHjMhcl8W+5lycs5s6g+tJ6W7OAyPGYi7lKH8dU+c2krfSiy/OY8QQriJoracK7+xDK4gjTCl3RIEhpSdTocm9q5MxoN11RYeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291517; c=relaxed/simple;
	bh=WLPbSxNSwAQ75U4UM2Y93ThF8oJ4ma91cFKygVPjCms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FIgrqwp7VOW6HZsCCP44PtKFCzW49/Gqomdo1sKCqwkocgwcJXhc0tI+Sqlg/fFQQjOSr58iZEiFj0z1QfAWSeawTm1tnw9LpFtdnn2Qjl8nyzheLybknq8YApl1KSxYsNOWw87O5JAbGJwdvFdpHodMcog5KaFpo/7j69wxCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW98Z4Ud; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD3F1F00898;
	Mon,  1 Jun 2026 05:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291516;
	bh=ezgvrrE/uqRjTKG6UcSAh/tvSyQhNRinEFhENt6sS2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZW98Z4Udn+0cZL/AaAj2TDEmYo8CnmJgz5jgGXqPDFybhMgP1akE9UtTd8vXN9wtQ
	 VP4bZm+VIUlRReinipjS3h9Cawu9prfCJp35P4n0shiExEgWDMYiHcbwfKO9Sz+pwP
	 Xhd6FmHmOs9BagGRVsqThw9R2PxwksfRRj+pfRlB1SKcA13oyxTOW5jVEn9R8mHSP8
	 z4gvvwH8mtNsKoVv5W99hz0ioHhSqQPvYfuN96CJDblnw13HsGJ+8CbkseA0ymZRb9
	 5WiFFTbZvAvAdADuFyTVKl8+F/k7Dc1iUr0NwRrUFQMB3PkM8xffGbEfZHjDyr7QyW
	 XDeDvt0FIQUtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:15 +1000
Subject: [PATCH net-next 08/11] selftests: mptcp: always check sent/dropped
 ADD_ADDRs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-8-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4991; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WLPbSxNSwAQ75U4UM2Y93ThF8oJ4ma91cFKygVPjCms=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReSC7L5cKrZug7suUL5bZCvg5d621Qp2yfoA
 hja1abOijiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 cwMoEACfzed7vOJKzasI3kylodIpogMLjca+oAmfciZ0YdIbUifq7AnnJszz3i/MbOT1dEyZXr8
 IUBK/v5OpZzRvXDZuyypVC7SucWlASkfuus8f2DyxNat08uzSK5RGQeBlCeZKEsqhmqbZdCfs+z
 WNmxFwkd/AOQqV2FNAGCuE8DhsO4YlQcIlpzUqpuJHy/aZL6zSpxfXDTyM374Kp3dMKkF4F0QSl
 suaChqCbCBuomgeO2QxfQarW1e9taaPU4DUyrWhU2i83FRURzP6xtZgas6I8xmsLCqQSSHY0Dyr
 6fQTQ6qEZyG3ANYbqSXPEPo+a84r5H552yo6OKIfxL7Na+WM6Anb7zLOTHUMEzmDCPC7D6daPuH
 xeL5ma+mAHA/rK7+uiZRGrIoTg8tw8jHQa4VTbet2jsWGMvwOzTMmUqYEU78iIeyscqR9H1mjNH
 3Ia0eQS2m6qviUXAryzv4ecdPzzFUfSWTehnwNqZkOt7nP7Y2KAMdb1b+AQ0toGrhuxm67v3tfU
 HM0b3mh0C+18iW0mUQo5KGntWZ4irn2rfFTytT8ulb0yL7NaNmwzOtr5jk3oN1bUbzJ3MFgHeBV
 myINp6H/OWV/PKMvINI5pGUQu/DVjZopS3+JGyjvqXAeob+d4Q763lksltKcUE0uILxIfWVdqSe
 HPn6VjeiZlTt19A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293550-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2050B619AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index d491c3e964d6..82c0f7df3be2 100755
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


