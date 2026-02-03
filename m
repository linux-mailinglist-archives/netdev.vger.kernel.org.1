Return-Path: <netdev+bounces-256436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHuhM/ZCgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B46DDD03
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 210A93139987
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB63D6486;
	Tue,  3 Feb 2026 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8lvTtT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10233D647E;
	Tue,  3 Feb 2026 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144175; cv=none; b=UGVWvA95OyVVjUu6h8NUUiWaLzLXt3x95C7DFKyiOph7xOo4jpwoojetNxaj91ACUhDsEjfcfzJaLjFvERtKtpDmS3HtjyBYN/PnIAf/XROprtxObimF3w2WPf6yhTFcUA2JiytMw72jKEHFxGsGrZHzaAm0D1NW0QfooBXmeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144175; c=relaxed/simple;
	bh=ID5JkJLo1WOdhuTA1CwvpZlH7/TidHufOUNg5S4OAPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaITxcfwG07ueesBZoqp6wU1koVRHp+tA7eknXh9bnm0743G/2/Iwng8MssbBpRS42Y96qMOzkFT8WqMF1hyyOmZVWFjdbyGPV7SCPWrrfhh1wYOyWGWvH/Dd1s3medsQsCcHz+9RgG6AszX3GoXEDEEvMCzfKjH3Wq12B3Vx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8lvTtT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A6DC19425;
	Tue,  3 Feb 2026 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144175;
	bh=ID5JkJLo1WOdhuTA1CwvpZlH7/TidHufOUNg5S4OAPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h8lvTtT70oz9mW/8dKMGlbbg8fmz2ktnRG/OmqiElPIcwxo9Ljz5eFZt1W+5B//Z3
	 Dgzqg9bvnD+pIY3Hxp3hkOwvXWUxDDFc4H60q54aqYg3vdG8n5oFskCVphUBLWNTyV
	 XojvEKOZZ4sGt7bnJb3jJbg7RFgDb53nYznOvjfoLgQJb7uqsGGcCcjWl+l8Ljeh3K
	 Be8De0GOLdlamA0j0sH53TqW4e7yaAXotLcx2oRicfbdCZ/KPwd6kqmZuH3xmI+XRB
	 HRsrkIHNZeyEbxgrgzM+q4SNEG9pvC4VFQ3AWtT6JVHYbCbFVcKV+ZzQ9D+BbALdE5
	 3Eyt4xwd5wP1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:27 +0100
Subject: [PATCH net-next 11/15] selftests: mptcp: join: userspace: wait for
 new events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-11-31ec8bfc56d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3083; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ID5JkJLo1WOdhuTA1CwvpZlH7/TidHufOUNg5S4OAPo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHHvrLndE+wf0Xlso6Hr73KlmOwmHCDeflWY/gm+aC
 HTFG9Z1lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOS/GSNDs1fXXvsnDNEBf+xv
 LAvbXfakYnqih+s/xSALpl3h7gvPM/yP+DdVMHq/2ke742FzBfn0nFe9kbtwwdrgdGx4GBvLkQ0
 cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256436-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88B46DDD03
X-Rspamd-Action: no action

Instead of waiting for a random amount of time (1 second), wait for an
event to be received on the other side.

To do that, when an address is announced (userspace_pm_add_addr), the
ANNOUNCED is expected. When a new subflow is created
(userspace_pm_add_sf), the SUB_ESTABLISHED event is expected.

With this, the tests can finish quicker.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6ab568d6b856..4977e6ff17b4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3716,7 +3716,6 @@ userspace_pm_add_addr()
 	tk=$(mptcp_lib_evts_get_info token "$evts")
 
 	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
-	sleep 1
 }
 
 # $1: ns ; $2: id
@@ -3747,7 +3746,6 @@ userspace_pm_add_sf()
 
 	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
 				rip $da rport $dp token $tk
-	sleep 1
 }
 
 # $1: ns ; $2: addr $3: event type
@@ -3999,7 +3997,9 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		userspace_pm_add_addr $ns1 10.0.3.1 20
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
 		chk_mptcp_info subflows 2 subflows 2
@@ -4032,6 +4032,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4062,6 +4063,7 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
 		chk_join_nr 1 1 1
@@ -4081,6 +4083,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -4105,6 +4108,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -4131,6 +4135,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 

-- 
2.51.0


