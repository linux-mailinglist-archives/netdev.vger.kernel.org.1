Return-Path: <netdev+bounces-256435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBrhA89DgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:51:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0291DDDCF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7627131A0386
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8845B3D6467;
	Tue,  3 Feb 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ehLycx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482D2F7ACA;
	Tue,  3 Feb 2026 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144173; cv=none; b=p2UR8FAr4XcjVmIyJrwPvYYjLgYcX7pBFNXU06Q/9hzlEtCNpsz1yWzxDiBZA4WiPwzC3VaRfi/PvehlCBOdNuh6pY0o2ulqbAMEUve542vA5ZY8POEAtDiaubIBqui9OEM6pHpVHrdSV7XarsAfn1W6i9mNEhaUxqPckg7lnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144173; c=relaxed/simple;
	bh=wNs70d+EDs+FA7tE+Ft/vNwuMNkXdPc9YBDChO+Ywqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MgI+DCHhnFb8KEryXI56C2EsWf2qemrTic3AzmkGXgyCzDYw7EFwgJWF/nEoeaOlfWTiaRD6q79gJoss7bIQAvTS32nCopBsNogTvGIvH8eCNv4b2rYGk7yUD5oykWdc0fcwOlr6yF7qJ432ZG6Ztj8M9drs5PixchfqVOryEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+ehLycx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB782C19421;
	Tue,  3 Feb 2026 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144173;
	bh=wNs70d+EDs+FA7tE+Ft/vNwuMNkXdPc9YBDChO+Ywqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K+ehLycxGiQgKe8DSseH6+sNi2n73CbYbjlI3BbxiIhvBHP4ff2E90K+WZ/rrjPb8
	 MBuwQ9hKhGpdSwjEoZWOTaUMrvRymGOp0U0p89sCX4xJKKPor12NaUKlRvJGj7BIX+
	 bDZv3NWXq9+IU9Jzpa3H41cwuqyDaGKb0cWkNg9U9UAIf8zUpwbtKcCjqS2vYiGAmt
	 tITfQKsheogc8z4xZ1cv8Bsy+u1BLcPmsVRbo7UqsZ7wUh2qF0ZeqpvOIUD6NMdjRj
	 /wa2TWnyta6gL6kuq8lks3FqnmO5LQjnNQJ76Nq6HJYI6hP3/EirsuSRxSDxL/zVXX
	 83zbIHvFy7RrA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:26 +0100
Subject: [PATCH net-next 10/15] selftests: mptcp: join: fix wait_mpj helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-10-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wNs70d+EDs+FA7tE+Ft/vNwuMNkXdPc9YBDChO+Ywqo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHHvMhW//qVh1syuSnX0fd5X1oWsbzd7zbTv0Wa5jp
 V2EitfcjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInMXMTI8LXvnNHMpMN1Acaq
 GfztV8LLPxjd6lPNef3w5ZOd2Yd9khkZdqkfdOK6kKyV5XFE6gBPh534wZaghFn5t47aPzSbK3m
 WHQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0291DDDCF
X-Rspamd-Action: no action

It looks like most of the time, this helper was simply waiting a bit
more than one second: the previous MPJoin counter was often already at
the expected value. So at the end, it was just checking 10 times for
the MPJoin counter to change, but it was not happening. For the tests,
that was time, it was just waiting longer for nothing.

Instead, use 'wait_mpj' with the expected counter: in the tests, the MPJ
counter can easily be predicted. While at it, stop passing the netns as
argument: here the received MPJoin ACK is checked, which happens on the
server side. If later on, this needs to be checked on the client side,
the helper can be adapted for this case, but better avoid confusions now
if it is not needed.

While at it, stop using 'i' for the variable if it is not used.

With this, the tests can finish quicker.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ff20d86ed399..6ab568d6b856 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -631,17 +631,15 @@ wait_rm_sf()
 	done
 }
 
+# $1: expected MPJ ACK Rx counter in $ns1
 wait_mpj()
 {
-	local ns="${1}"
-	local cnt old_cnt
+	local exp_cnt="${1}"
+	local cnt
 
-	old_cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
-
-	local i
-	for i in $(seq 10); do
-		cnt=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPJoinAckRx")
-		[ "$cnt" = "${old_cnt}" ] || break
+	for _ in $(seq 10); do
+		cnt=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+		[ "${cnt}" = "${exp_cnt}" ] && break
 		sleep 0.1
 	done
 }
@@ -4207,7 +4205,7 @@ endpoint_tests()
 		chk_mptcp_info subflows 0 subflows 0
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		wait_mpj $ns2
+		wait_mpj 2
 		chk_subflow_nr "after re-add id 2" 2
 		chk_mptcp_info subflows 1 subflows 1
 
@@ -4219,7 +4217,7 @@ endpoint_tests()
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_del_endpoint $ns2 3 10.0.3.2
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
+		wait_mpj 3
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
@@ -4231,7 +4229,7 @@ endpoint_tests()
 			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
 			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-			wait_mpj $ns2
+			wait_mpj $((3 + i))
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
 		done
@@ -4289,7 +4287,7 @@ endpoint_tests()
 
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
+		wait_mpj 3
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
@@ -4301,7 +4299,7 @@ endpoint_tests()
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
-		wait_mpj $ns2
+		wait_mpj 4
 		chk_subflow_nr "after re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
@@ -4313,7 +4311,7 @@ endpoint_tests()
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
 
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
-		wait_mpj $ns2
+		wait_mpj 5
 		chk_subflow_nr "after re-re-add ID 0" 3
 		chk_mptcp_info subflows 3 subflows 3
 		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
@@ -4362,9 +4360,9 @@ endpoint_tests()
 		wait_rm_addr $ns2 0
 		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
+		wait_mpj 1
 		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
+		wait_mpj 2
 		mptcp_lib_kill_group_wait $tests_pid
 
 		join_syn_tx=3 join_connect_err=1 \

-- 
2.51.0


