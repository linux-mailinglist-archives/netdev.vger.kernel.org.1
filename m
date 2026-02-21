Return-Path: <netdev+bounces-259841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FQIF7BAmmlXaAMAu9opvQ
	(envelope-from <netdev+bounces-259841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2816E3DA
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B183300E186
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399F130ACF2;
	Sat, 21 Feb 2026 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh9szXvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3D30AAD0
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716769; cv=none; b=KaibNqe3DS4mU5edB6r7/0R5TcGtiha70xiDF07qo8uunptSS+Yi8ZumkcOzIE76h3Qsiol3K9lIyWmwOg6O0LGRJx4hywb7J7vehw6p5FX3KIEWyNpiE1TMQjUiV/9M0DXKeuVkZIyZs/Q7L0XbYGz2EooFMEQ+TA1pEMwx3/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716769; c=relaxed/simple;
	bh=lbr0oz9VB2Qec0V22a2KHympkfWK71OquJ5rBqmDKTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LCjyTefmrpRGavL1bbZhEkqIUkm8esIj6tEHgK1HGUy7yRHC2vJkI0qB2LNkKmOFi0e0onJiGYPxLky7uAzwtOCt93AkeL3eFvnyODwi5jjU3fFhbkx4EsL6vGb04MwZk1ujdK6EAy5P1CzDKm7kgcsaHXYUws1aZJGnweFJXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kh9szXvb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562171b56dso3621931a91.2
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716764; x=1772321564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJLW7oIznD/TEG27ZVpx0y0TCWyIGsFNIEuzZagdUw8=;
        b=Kh9szXvbKAS2yM9KDJNVWiG+OVubkmt7AAFUR9uqPrD05PqpvSUIIqMoFvhXvl5fno
         0W/iWff+TYHwclLPx5Th8JfMYnYT9cu++1nam3SQ8PBP/AH/fX2MrjoA2KkQPjBHSFxV
         rpHddM8k0DIQrYIQZF8NzYtbpvcCK+w+RUeuzRADQ75RycXILG8IDjXVEMjTWfJE/vbr
         FRIQ02cWntH2yCZFrKju7/uyrz9yDvPi6RZkQ0h4xtS6USP+XFEU3vn+PnamJitXPZfv
         FCWWWdKSWux8L3bbONyiOz60IExwGKD7FwHygjOpnJLkLY7iitH1f43U7dihX6LCBFJ7
         +0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716764; x=1772321564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJLW7oIznD/TEG27ZVpx0y0TCWyIGsFNIEuzZagdUw8=;
        b=Sak+TlPKcbBDKdkvle/XHZCfbuj2wxUuyZjtMmwM2D51DsDtQKoObqKmWPVZhSpwWa
         vvN86hRINLJZC4rgwlVB5Chd1dd2cwBfYPwe2F8h5LZ+qKNBfSd09cNMu7dQJENfZ5ve
         jQiuZXmYf8MS8zAJz7B2V0u1ufOyosElDAC8MGe6itUB/6wfdipkJ7j68GKODPWgeg9v
         rroMN9xgCy/N4Oz6JReI9zBGN9lOecDfz1goDvUizds+WKxfmjOejKNmOw0a3vsSXotK
         vp3gm/DoN/uQKf7hjbdThzgDtPSI1Hi9MUAlHGmCRYgpFboRLLVXRHQ6CAjtmH14m4yL
         +nLg==
X-Forwarded-Encrypted: i=1; AJvYcCXNdHeWd3wNKYfiSRc/+Gz20t5TSVqolERq61la+BsWyCnePm86QXjN6t0x11l4IVzosKHs9o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDDIbvXu2Dlf6pbb0jgitSXeGgAAdDEAqb/YcUFjVSrztL7CZL
	xWcw7T0z3oH5CdjsdYOlB5BVrYRMt4bZ4I/YuLQffR6eOBPtdKA1h3fEiSczWAqxjnmDiSv8BzD
	f0ZVKMA==
X-Received: from pjqc8.prod.google.com ([2002:a17:90a:a608:b0:34c:cc12:1613])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c:b0:354:aee0:cab7
 with SMTP id 98e67ed59e1d1-358ae6b1096mr3229006a91.0.1771716763762; Sat, 21
 Feb 2026 15:32:43 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:51 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-5-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 4/6] sockmap: Inline sk_psock_create_ingress_msg().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259841-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C9A2816E3DA
X-Rspamd-Action: no action

SOCKMAP memory accounting for UDP is broken for two reasons:

  1. sk->sk_forward_alloc must be changed under
     spin_lock_bh(&sk->sk_receive_queue.lock)

  2. sk_psock_skb_ingress_self() should not be used for UDP
     since UDP may reclaim sk->sk_forward_alloc partially
     before passing skb to sockmap, resulting in a negative
     sk->sk_forward_alloc

This is a prep commit to consolidate sk_psock_skb_ingress_self()
and centralise the fix to sk_psock_skb_ingress().

Let's inline sk_psock_create_ingress_msg().

Note that now alloc_sk_msg() is called first.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Don't pass gfp_flags and instead change it based on
    take_ref in the next patch
---
 net/core/skmsg.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 3d7eb2f4ac98..6b1fef6ef85b 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -529,18 +529,6 @@ static struct sk_msg *alloc_sk_msg(gfp_t gfp)
 	return msg;
 }
 
-static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
-						  struct sk_buff *skb)
-{
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		return NULL;
-
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		return NULL;
-
-	return alloc_sk_msg(GFP_KERNEL);
-}
-
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
@@ -592,7 +580,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
-	int err;
+	int err = -EAGAIN;
 
 	/* If we are receiving on the same sock skb->sk is already assigned,
 	 * skip memory accounting and owner transition seeing it already set
@@ -600,9 +588,16 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 */
 	if (unlikely(skb->sk == sk))
 		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-	msg = sk_psock_create_ingress_msg(sk, skb);
+
+	msg = alloc_sk_msg(GFP_KERNEL);
 	if (!msg)
-		return -EAGAIN;
+		goto out;
+
+	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+		goto free;
+
+	if (!sk_rmem_schedule(sk, skb, skb->truesize))
+		goto free;
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -613,8 +608,12 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
-		kfree(msg);
+		goto free;
+out:
 	return err;
+free:
+	kfree(msg);
+	goto out;
 }
 
 /* Puts an skb on the ingress queue of the socket already assigned to the
-- 
2.53.0.371.g1d285c8824-goog


