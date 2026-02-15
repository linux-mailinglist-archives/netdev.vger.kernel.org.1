Return-Path: <netdev+bounces-258797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMx4J5wwkmk8rwEAu9opvQ
	(envelope-from <netdev+bounces-258797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:46:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0779013FB0F
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 21:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2C853058BA3
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C830596F;
	Sun, 15 Feb 2026 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3OyKBcM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5007305047
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771188245; cv=none; b=s00NbSf0Ovazm6RUs+uSr5eH77Fnj95p9dNunlLMSJ1YTxPBc5x+M1E5Ep9mUEb/2G0AEfRgsjSxoWwUzgtInL1VswvAf8usXdFDgf5h2ZcggeezWY/lRQG76clDTjtO8h26xyd+j3c5KqysZzNsxHsZ0YvD2tw2Uvvn9daokzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771188245; c=relaxed/simple;
	bh=Thk0Mum8d8vn9lW6/LzcfKJ+foIbKDbzFOzTvdvZ3oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p0HQL1YqzX6OnxG2vrjP6qPU/PgVyOrX4aF18dCaufNT6BG9KadaxbmtjcmCGJGOJ3h27A4jA5xUuyrasAoLP4x05IgNQr23zH8Fuz/ZqQRXcJK1IMWtkWmuVDmvVl2P1ULiExsZJKUaIUKZ2EBQ1fNI7ha255vzEGa5GelOJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3OyKBcM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so2307226a91.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 12:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771188244; x=1771793044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=InS+cCHll9daAAfmNnVqFKLPwE8YodUooYzqt/CFRF8=;
        b=S3OyKBcMP7NSpGjSm2eZIf3kYmQTKrAZ/Ng3qDGql1FPRoke5stW7LXTfq2DGpEcHi
         mIeFMPFHE5kLPF2tlMph2m/Sr/OfqR8G006uu2ZxowID3mQA0yJku5sxkD9shCyQB5kK
         DvaCAMbsB8ipWC17CqpGKLqe0oR2iDXPWaIBi7lZxnTrkzHrjZ6QdU8WTOcNtWI+I9Pn
         dPxDdBxSTNMuUGbu6d1smlhOMcqsIgZgfcRsyUwj8pkzQ4Z1tUxsYzfVdZg/Llfo7o9s
         IfLEJSl82O0xGQQcCt42D6PPBwDF7+dm4gRnFe+otJLhx/HAzUNwowoJrVq9HCnCqMeY
         hQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771188244; x=1771793044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InS+cCHll9daAAfmNnVqFKLPwE8YodUooYzqt/CFRF8=;
        b=WAurvA8Z7KeJAqsgLIfwuaNuPb8WgrahN7yZvhm/4gicYoumdJebKNDkQcUKYMcJew
         sqT0WwLI0a/cNvqRPODYtojx6r+ffmEshmww4iMdkBdRdET1aFLE1F+CL7KIi+7MOIbt
         evtTlb89cLx+COBPtlOnugReyhTrfaXIa/cDQ1mqAQd4LiqeCLYduCgri1fHbV2oWpuE
         L47BtOIQCPGgY6Zf6m2bheSJKQm/dZWt/rhQm3fd/FRHA8iEHpeV2Yiui7MN7x/QqCd+
         MUWBwNLtHXh5SQWjaRJXlo//d8ShWIuvwWEnuhW6T31OwEsmYBO1nboDdMaUCzfmdOOU
         O00g==
X-Forwarded-Encrypted: i=1; AJvYcCUhsyCBo6oRZkzKAVXAc8xeVPKD4JR/oPrw40EIIodEuFej+P0f8cdGODjAOu9U1e8+ZJHdiU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnxd1ej9S8W8WHXaNrhRuWM0fOR2hMK36SjoCTHPAOwOlB9kRb
	07CphPMnTQMgAf61FGyO05nc1l3TZrPcTfQNGbvazcfWb9dNOuC6FMlobHQ57de+MJRBDtCTRYs
	aVjzswg==
X-Received: from pjje12.prod.google.com ([2002:a17:90a:630c:b0:34c:2797:7072])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60c:b0:343:d70e:bef0
 with SMTP id 98e67ed59e1d1-356aad6cf5dmr7565573a91.21.1771188243990; Sun, 15
 Feb 2026 12:44:03 -0800 (PST)
Date: Sun, 15 Feb 2026 20:41:40 +0000
In-Reply-To: <20260215204353.3645744-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215204353.3645744-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215204353.3645744-6-kuniyu@google.com>
Subject: [PATCH v1 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Cong Wang <cong.wang@bytedance.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258797-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,bytedance.com,google.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0779013FB0F
X-Rspamd-Action: no action

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 54 +++++++++---------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 57845b0d8a71..28df767f3ac4 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,24 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
-
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len, gfp_t gfp_flags)
+				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
 	int err = -EAGAIN;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
-	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-
 	msg = alloc_sk_msg(gfp_flags);
 	if (!msg)
 		goto out;
 
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		goto free;
+	if (skb->sk != sk) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+			goto free;
 
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		goto free;
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto free;
+	}
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +598,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +608,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	goto out;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
- */
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
-{
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
-	struct sock *sk = psock->sk;
-	int err;
-
-	if (unlikely(!msg))
-		return -EAGAIN;
-	skb_set_owner_r(skb, sk);
-
-	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
-	 * data originates from the socket's own protocol stack. No need to
-	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
-	 */
-	msg->sk = sk;
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
-	if (err < 0)
-		kfree(msg);
-	return err;
-}
-
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
@@ -651,7 +617,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1024,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, GFP_ATOMIC, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.310.g728cabbaf7-goog


