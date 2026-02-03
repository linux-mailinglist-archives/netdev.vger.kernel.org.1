Return-Path: <netdev+bounces-256434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEGzD/NCgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D32DDCF5
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED223197E3C
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D73D522B;
	Tue,  3 Feb 2026 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8P7yos0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E23D4125;
	Tue,  3 Feb 2026 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144171; cv=none; b=Ln+QkdkodFrDnZzCqyOLf+30lOxmeC2FDTbvsqyO9nLkkcNKlnXRDU9AJgKuG3Ewae/+vbZnxLk3yC2Hy3re6qN+ddB8gXed/Yr5CX14yKTmva4g173acnZgWe9JtMq09sZ0jtiWmXLtcfevc72Y538MuCU2neHribk2pX8Hwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144171; c=relaxed/simple;
	bh=HbOdXKxLd3ikHw9J38XvsF3R+9nHLf7QVvSnN4x9qaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwtjEGXFUZurqULJK5hhDK5SRzlpqaG4TLVGPJLZTQ98jOf4UUeN9dAJJj1nLa5RGX9HZ/cCMRB87uijmYi+1Zep+WDex+R62iaZt50sJU9zd8230j/SFDbz7f5fEuiNx0Cb/kFjbZHHy8MGOPCOowt90i0NPTQHtuH9X6MvToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8P7yos0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B48EC16AAE;
	Tue,  3 Feb 2026 18:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144170;
	bh=HbOdXKxLd3ikHw9J38XvsF3R+9nHLf7QVvSnN4x9qaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k8P7yos0WSnLCJ/tz/TPSPcjB2AO88kvTzynwo9RwL5sMNo96mfa0dO57pX4V9iiz
	 MbLKoy5WRdUGKUZCpllnvWFKXkaNcQv/nvOzuDrmtw0oy+Tcf6uekixMHgezCKukC2
	 HlWWYydXphskjH4GdEk0ZI93k7/552Re3uiLrdr4a5AKMM/DRoen2azWEwzAomu42r
	 7L0sq7wNVTyqa8hM2Mfisw8SgWI4aTYDggfLyLufxOmetYYa5xG4ftm/N63ibMVlK7
	 WaafO7oE3kCN+6L0tcn3T0bVfesQ6S2Gli6BEzbgWA/YTAMUfklmmjj1yKxIriZfDr
	 7kSJijSne3h3w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:25 +0100
Subject: [PATCH net-next 09/15] selftests: mptcp: join: wait for estab
 event instead of MPJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-9-31ec8bfc56d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4072; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HbOdXKxLd3ikHw9J38XvsF3R+9nHLf7QVvSnN4x9qaM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHHsCr7owcbm15epHntHd8HNjSc0bnYpPf7553Z5S7
 m/BeSixo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCI7yhj+F634/1fUfeq12u7K
 d07d0z0LN4XLNO2RSGQyvX9RsE1Qi+F/VK1NX2N/3PutzKyT7yw4X+S3te/o9wzZ89PN/1+LFvP
 gAAA=
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
	TAGGED_FROM(0.00)[bounces-256434-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 89D32DDCF5
X-Rspamd-Action: no action

'wait_mpj' was used just after having created a background connection,
but before creating new subflows. So no MPJ were sent. The intention was
to wait for the connection to be established, which was the same as
doing a simple sleep with a "random" value.

Instead, wait for an "established" event. With this, the tests can
finish quicker.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e70d3420954f..ff20d86ed399 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3999,7 +3999,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		userspace_pm_add_addr $ns1 10.0.3.1 20
 		chk_join_nr 2 2 2
@@ -4032,7 +4032,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4060,7 +4060,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
@@ -4081,7 +4081,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4105,7 +4105,7 @@ userspace_tests()
 		{ timeout_test=120 test_linkfail=128 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
-		wait_mpj $ns1
+		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
@@ -4158,7 +4158,7 @@ endpoint_tests()
 {
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP" &&
+	if reset_with_events "implicit EP" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
@@ -4167,7 +4167,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns1
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
@@ -4181,6 +4181,7 @@ endpoint_tests()
 		pm_nl_check_endpoint "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
 		mptcp_lib_kill_group_wait $tests_pid
+		kill_events_pids
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
@@ -4194,7 +4195,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete id 2" 2
@@ -4272,7 +4273,7 @@ endpoint_tests()
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
 		local tests_pid=$!
 
-		wait_mpj $ns2
+		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		pm_nl_check_endpoint "creation" \
 			$ns1 10.0.2.1 id 1 flags signal
 		chk_subflow_nr "before delete" 2

-- 
2.51.0


