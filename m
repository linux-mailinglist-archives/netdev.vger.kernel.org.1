Return-Path: <netdev+bounces-260397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id d4inD5pfnWkDPAQAu9opvQ
	(envelope-from <netdev+bounces-260397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95593183906
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B78F3052898
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E4366811;
	Tue, 24 Feb 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r74EtFWR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D072C21EC;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921225; cv=none; b=gFPy5/ywOftjwl09Yq0t9lliF9NGWiwqDvyk9zvMh4g9jLbpK1a901HLPeAWil4gniaQ83gIyqO0z6AXD+1Qcciz3kKbbe3z+cG1Dwn2Y27YwjbjIsyPTLIwiIjoRCVYHp288UTbOi8zidP7e8umR+8j10dYZgvkMxAeuOderR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921225; c=relaxed/simple;
	bh=GY4T7YOF1wGjPvsU2gCiSTseuH4IU1M7ZVYcttKfaY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lMRv5avG6GJfZd445Z7XRcDLVvfZJ4luZ8P7N2D+kCzsv5aXT4sB0cu8PvLyU6XORKXjA36n0Lt1zx+uAb3sKuC8ePfxZJwEQwrqvfDIaIKYN3RCj0dMbXDP63KoczyVM9h53M5LaYdKMJKh3exwDNH2+97ecHR4vWkDScLcOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r74EtFWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93C8FC116D0;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921225;
	bh=GY4T7YOF1wGjPvsU2gCiSTseuH4IU1M7ZVYcttKfaY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r74EtFWRUuz///QTfXqDOUJFA3y1YuVt6nI3lRHxm4Mp1O4FG2Bo9KZTHJiqA65/X
	 4kSDS0i3Xpow7nFzKuIFta/3hkO2FdnQ61+zb/ws6UHBGwqNgEh9P7EQfdJalorzw5
	 zfWv/rNFuvhObf65tCmJwhUxvw0UTQQmzaCGjYRzFNvTroP5SFSoKqfG9fa9U3+BTW
	 d0x4Ta4yMB8kx59fZnCdid1P4y2TY8OjN6xM5nDOoITkvp+xPcbS7H27j58i7qaLPd
	 7w0BA9M5a+4Aoygh/LREqOt0NMnExJTFlVe8/0WyL6y660xDEqxMfColPDg9Bhmk8i
	 fDXy/F+MxrZbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82974EFB811;
	Tue, 24 Feb 2026 08:20:25 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Tue, 24 Feb 2026 09:20:12 +0100
Subject: [PATCH net v2 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-fix_zero_wnd_fin-v2-1-a16677ea7cea@gmail.com>
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771921224; l=2768;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=HHIXStnLVKh9nRSiL0fqF20SR1yAgQfpvvEWrJlCWHg=;
 b=nyp516r2MWrT4RExFJWSkDMLTTh4TPV2g5Mnfe8RVOVlfBOSy2QdPDlGednpb1bS8K67vybjd
 BjPhAsuIhG7BV/ZjzPUp56ThuXrbvOx8bgWZ/P2oxSKWd+lOoEC7Zwx
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260397-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95593183906
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
 net/ipv4/tcp_input.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..1c6b8ca67918f0601b9b3e8ef884c5fef0a7ab65 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4858,15 +4858,24 @@ static enum skb_drop_reason tcp_disordered_ack_check(const struct sock *sk,
  */
 
 static enum skb_drop_reason tcp_sequence(const struct sock *sk,
-					 u32 seq, u32 end_seq)
+					 u32 seq, u32 end_seq,
+					 const struct tcphdr *th)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
+	u32 seq_limit;
 
 	if (before(end_seq, tp->rcv_wup))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
-	if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
-		if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
+	seq_limit = tp->rcv_nxt + tcp_receive_window(tp);
+	if (unlikely(after(end_seq, seq_limit))) {
+		/* Some stacks are known to handle FIN incorrectly; allow the
+		 * FIN to extend beyond the window and check it in detail later.
+		 */
+		if (!after(end_seq - th->fin, seq_limit))
+			return SKB_NOT_DROPPED_YET;
+
+		if (after(seq, seq_limit))
 			return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
 
 		/* Only accept this packet if receive queue is empty. */
@@ -6379,7 +6388,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 
 step1:
 	/* Step 1: check sequence number */
-	reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
+	reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
+			      TCP_SKB_CB(skb)->end_seq, th);
 	if (reason) {
 		/* RFC793, page 37: "In all states except SYN-SENT, all reset
 		 * (RST) segments are validated by checking their SEQ-fields."

-- 
2.53.0



