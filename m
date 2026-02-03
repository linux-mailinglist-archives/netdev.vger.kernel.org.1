Return-Path: <netdev+bounces-256438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNm4ESpDgmnsRQMAu9opvQ
	(envelope-from <netdev+bounces-256438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:49:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3EDDD3A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D12130DE265
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DEE3D6686;
	Tue,  3 Feb 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMAWmyWK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715E13D6683;
	Tue,  3 Feb 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144180; cv=none; b=aMfcYiuByRGxAYOPgnwO9/M86usj+zQRU+1rUbJ7aHMJMDrheGawa8acAiZV7MAMnlOjXEYz4W8nV6A2dwy0HqBbqxVU08r3+imfiWAbp01hSfKrBp5Jfav/rDjGsr+o39bJ7K2/ytkfBpqi2hnbjkvJeIYfKRgaNij0ce/5Rts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144180; c=relaxed/simple;
	bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5FcxLLRkPHc9YoShIqmh5+nbh0QR+kdI/CfFHgJGqc6FjHM9Vt/LZhWDFvgqn5WYZzNpKNFr81x3ftBsnQ8i7M8shEJGoB6wdKd6EhBgc/WvfAILi7wg6MJmxHHRRqsg+gIlWBySVBftbjPoH7Pz++oVnBt12V2gE+lbBLKhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMAWmyWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A39BC19421;
	Tue,  3 Feb 2026 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144180;
	bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eMAWmyWKvkRtf2QYLJE0hxPAk0PWHJXZXIu7WH3fRKySRBKcV0kkPwZ8nnPgSQ1S9
	 V2HUfdvkKLGYHPcT7q+xoPIvAGHtkqtpiEG0cRIXopKLlPcYtfAz4lt99Pn7OqrBR0
	 hDEloBg/AWYH1KhJStCZp2yMWV3SljqPX+Bi+etokmCq9aZODZO3Bdr8/BmcMUuqnq
	 6nLDKEnST3z+er2P8pxW51N6kMHhrl3Gh+PD0sInWPhFnqgodaSYm88HFVjDwh62BE
	 jXwmV83OZCAGLULASoiC7Ts+KbDdARz1EbzPNwwyhlBQ9lpkf8eESLRgmK/ph2B5Oc
	 8pXzIrWcSwcwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:29 +0100
Subject: [PATCH net-next 13/15] selftests: mptcp: join: avoid declaring i
 if not used
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-13-31ec8bfc56d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmCQY+i3LH7weLKEw2CJP5V6KMl8lXMvjGRa/k0K128hN4Yd
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmCQY8ACgkQfCLwwvNHCpdmbAEArHXF
 PWpvqzLVcX1fZk6ERdS4zar/OrRTgoiy4/e73S8A/A7rQlkNSRTUlMHNBr1h+57+UP4NV6R/I+8
 RkIJXtagI
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
	TAGGED_FROM(0.00)[bounces-256438-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65B3EDDD3A
X-Rspamd-Action: no action

A few loops were declaring 'i', but this variable was not used.

To avoid confusions, use '_' instead: it is more explicit to mark that
this variable is not needed.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8b9782a85df..0f9253d607c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -603,8 +603,7 @@ wait_rm_addr()
 	local old_cnt="${2}"
 	local cnt
 
-	local i
-	for i in $(seq 10); do
+	for _ in $(seq 10); do
 		cnt=$(rm_addr_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
@@ -623,8 +622,7 @@ wait_rm_sf()
 	local old_cnt="${2}"
 	local cnt
 
-	local i
-	for i in $(seq 10); do
+	for _ in $(seq 10); do
 		cnt=$(rm_sf_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
@@ -648,8 +646,7 @@ wait_ll_ready()
 {
 	local ns="${1}"
 
-	local i
-	for i in $(seq 50); do
+	for _ in $(seq 50); do
 		ip -n "${ns}" -6 addr show scope link | grep "inet6 fe80" |
 			grep -qw "tentative" || break
 		sleep 0.1

-- 
2.51.0


