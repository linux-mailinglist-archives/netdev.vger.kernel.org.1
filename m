Return-Path: <netdev+bounces-259843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIzrKvtAmmlXaAMAu9opvQ
	(envelope-from <netdev+bounces-259843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:34:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AC16E40F
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA0B3028378
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 23:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC2318BA6;
	Sat, 21 Feb 2026 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdyrYand"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6F3093C3
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771716769; cv=none; b=J89snzG4WFxstL3doP/jR6SsXVXG+bvHCtmyQIJxuBHxJLiJxYTRYw4MHRyWeQmsZH7bYAM8stScSh4oAMWsxD5Kv17pVS6jpWmYln/n++qe+dwZMoZaBZJA9yK0QFH6I63b35AnDtWe/xdGF8yUv4BJ6XhCWYnY9ZTM/L7H2W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771716769; c=relaxed/simple;
	bh=5qIeLn0udmUQ0lAH7ymvh4bwzedo3+XdQggsGBEBQeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqRu8km+oX43hoYlyhtH/1G0aHB8Qf7IRVnHTeGGR/QG/+T836LUxnTFdiM7BfagRHCvxp5doNfU9uyFwJPNzepwJ2P3tJyiebw27PfEIXabnvZl+6zf+4b2lK5G/ntid1Ak2BHJ84g4rC2D79Tzpn3bleEj/mb1e14n4CfVQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdyrYand; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35621cea097so2017418a91.1
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 15:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771716766; x=1772321566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZJLtlywpr8r14Jsy3Lpf4GPuEEfot66fEIP/mfghw=;
        b=NdyrYandaoDBcBdreAM+tl+s+0egVZ+FNp7LW3OF6u0Y2cQBsLBgdjyaPIU+4YLBOw
         SW5t+11osgGcopFPuB8YsPZe0e8JCVO08Fen8AMTPtciLtw4YWwqC/qcFyhJQyzBUDFq
         Gz5/6aQtdSwwEutPF/HUpWwggJCyVWq/V5UT6yuEgkG679BvLahUFPQ9H7vxzthTMCZG
         fBOe7W8oT43RFjTXBzfyadxPtD+2QWh9fld2+OmMkTrgkFc1yoiCBetqJI+YL214IIEr
         hlGjum+yHQKJG91mti6Kg1cF3M11ESliI8Tlx8hHgZnkzR+ZR+yqjSMM7qV+diBE1u2v
         cB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771716766; x=1772321566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SRZJLtlywpr8r14Jsy3Lpf4GPuEEfot66fEIP/mfghw=;
        b=Fz7avI7J8m4tAJ7QzabCSsNXmbdoPUsiPDH/8hDKO8DNLk01PCwgSzH5OzceAVNSxy
         94Gt2Qj5Qa53oOtoGvCX3fH6KExE5ZDe9ZzJlnIB44OCpYHmYnUHfkAKanB+5c/0DEof
         QECMmkBSlgJpb17q0U5dyv2X6NP6Ln4bu+Pv6P9vBt3HaK4W4rVpeNhoU1WE1MoMdJTJ
         HiIEjsHrgmlZ5AgIYSVxsKRBZGwDMeOeZvGo62CZUEmfWhbgUuI0NFbmanipkBjs7o9v
         cKKleJEgNi/X2OaQ3VrYvKW0X5bZ+4gH02NS4jlfydREKB9J7fzMImaxSk2BFlp8qxUU
         1/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs4ASldsbtDuWF5pAqHZ1VfF5rL8SC/nF+klx7TRkYjUdPlODIig1xt0FnzC5taoY/ohlMtuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVoeN4jHDIJtAoEo5DC6rU0ANTZb6O3oSuEfU/CBaJmo+n7eEU
	x29IADBkbmGh1FaIv9RkgNv8qAf2rchc5fZ6XHK3MyN7g3tkBOebskRci6NGqsJ99YQm74+yx5Y
	fYXDZhg==
X-Received: from pjm13.prod.google.com ([2002:a17:90b:2fcd:b0:354:bde2:b529])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5112:b0:356:2eac:b649
 with SMTP id 98e67ed59e1d1-358ae7bc5efmr3691684a91.7.1771716765435; Sat, 21
 Feb 2026 15:32:45 -0800 (PST)
Date: Sat, 21 Feb 2026 23:30:52 +0000
In-Reply-To: <20260221233234.3814768-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260221233234.3814768-6-kuniyu@google.com>
Subject: [PATCH v4 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259843-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D2AC16E40F
X-Rspamd-Action: no action

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Note that now sk_psock_skb_ingress() always use GFP_KERNEL
if called from sk_psock_backlog().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Fix memory accounting condition from (skb->sk != sk) to
    (skb->sk != sk && take_ref), the cause of selftest failure
v2: Keep msg->sk assignment
---
 net/core/skmsg.c | 62 +++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6b1fef6ef85b..96f43e0dbb17 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,30 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
-
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len)
+				u32 off, u32 len, bool take_ref)
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
-	msg = alloc_sk_msg(GFP_KERNEL);
+	msg = alloc_sk_msg(take_ref ? GFP_KERNEL : GFP_ATOMIC);
 	if (!msg)
 		goto out;
 
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		goto free;
+	if (skb->sk != sk && take_ref) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+			goto free;
 
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		goto free;
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto free;
+	} else {
+		/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+		 * data originates from the socket's own protocol stack. No need to
+		 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+		 */
+		msg->sk = sk;
+	}
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +604,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +614,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
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
@@ -651,7 +623,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	return sk_psock_skb_ingress(psock, skb, off, len, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1030,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.371.g1d285c8824-goog


