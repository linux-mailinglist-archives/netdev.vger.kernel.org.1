Return-Path: <netdev+bounces-259872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF2aFQ/4mmmqogMAu9opvQ
	(envelope-from <netdev+bounces-259872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 13:35:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C13B716F0B5
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 13:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D254D300D904
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10016213E9C;
	Sun, 22 Feb 2026 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9SlU2zK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45918AE3;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763719; cv=none; b=HgEFs+f4UMGODnEKlceYCUgUQPEONai5nt3UhT1sD7UHhky0DvX/jluxxUTaGrTEOliHW2wGSPnlEviQTnb4dwksHmbgooRrZ8xVI1W1y4UFOugMeIQaIY0XXT/WBmVJjQ2XNZG9u8viK1FpD0pstzlfPYliyqMVQH5U6q4apwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763719; c=relaxed/simple;
	bh=fOTXusaZK56AmcS2R8m8YPN9h42bESspa46XGl1Ik3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9C3T/HB40nO9gVQmuhzAGkTf+sdwFJ7Qf4qP5+leCwuyCQSE6ZIo+D4vqrHikQbkkIUii35BSe1xbyb1lcQio6NDjaf8qUXcL/ACnqsKR4mQFdrSluM1/6ewe7eFUaVrq47E9LeYyrhl7AWF3AEbRXg1VGPcP9HNEBYu+WH/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9SlU2zK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C563C19425;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771763719;
	bh=fOTXusaZK56AmcS2R8m8YPN9h42bESspa46XGl1Ik3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t9SlU2zKGHFQAV9YRY1KwEiq4WSp8eLek3In79jkbQIVp++prEj9+L4aNNzbuitU6
	 vrv927J9O3+zOZ5HBzv6u8qxKDJApWTRWLW43B8aMLFjyIVi1eOLMO6aLmQnhmtgG1
	 ZxfOAozuRP/5ZDWJnzvvza+bKP1r9dq8TjJqEJA4PmCJyFNB+RE/PpV3vC9tvGMEdv
	 CK3tTTnyKtXXx+Y/NyRkVptSA/CXBDkjAsjlNcgfl+17rOcprLtzuS5Ekncyi8se4s
	 ZcK3WDFvuB6ndNKV8eAvEhCgx9ZZjLHyH7VkfimrQSGDkIkbsTuTrsX7BI+3PKw9fg
	 5BKPfy0wPyM4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFA1C624D8;
	Sun, 22 Feb 2026 12:35:19 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Sun, 22 Feb 2026 13:35:08 +0100
Subject: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when RWIN
 is 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
In-Reply-To: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771763718; l=1892;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=2+1eVacnxOmDaohxIY6qSWPXriJ79AYLQ+Cp0PfC4TQ=;
 b=FMKB20bLolhb6Ew2dUc7wN+ml4Zx0IowwF58ximgA7YMljwawroVdSvf7uKR48Oaj7Ils8STb
 AWJH4jK6KHCApogu6LqmYbpU3AlqPD5t8qn/Krg3HBpdGG1qgaNVayk
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259872-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C13B716F0B5
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

Commit 2bd99aef1b19 ("tcp: accept bare FIN packets under memory
pressure") allowed accepting FIN packets in tcp_data_queue() even when
the receive window was closed, to prevent ACK/FIN loops with broken
clients.

Such a FIN packet is in sequence, but because the FIN consumes a
sequence number, it extends beyond the window. Before commit
9ca48d616ed7 ("tcp: do not accept packets beyond window"),
tcp_sequence() only required the seq to be within the window. After
that change, the entire packet (including the FIN) must fit within the
window. As a result, such FIN packets are now dropped and the handling
path is no longer reached.

Be more lenient by not counting the sequence number consumed by the
FIN when calling tcp_sequence(), restoring the previous behavior for
cases where only the FIN extends beyond the window.

Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp_input.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..fde612f12d3625000081958d13cec8779684a642 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6379,7 +6379,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 
 step1:
 	/* Step 1: check sequence number */
-	reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
+
+	/* Some stacks are known to handle FIN incorrectly; allow the FIN
+	 * to extend beyond the window and check it in detail later.
+	 */
+	reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
+			      TCP_SKB_CB(skb)->end_seq - th->fin);
 	if (reason) {
 		/* RFC793, page 37: "In all states except SYN-SENT, all reset
 		 * (RST) segments are validated by checking their SEQ-fields."

-- 
2.53.0



