Return-Path: <netdev+bounces-259536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFahDO9Kl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:39:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDE3161505
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B1D0307670D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343B034FF73;
	Thu, 19 Feb 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqqL7uTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF8350A28
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522689; cv=none; b=tbSiPTPx2Po36hc0WyU+jtd4MMby6Tvn0alaL4n7TfbdG79KEuZJJ9OYxm2IYoo1GMHUavVNEcTkJqpw/J/qiKe3p9x52iBVI8ghd7xxXMwG3pBmbDVibaOlYNc1fxFtIYgPWyqIY01YFejchqAF9FJur7zyHCEsEJPKgL4L3gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522689; c=relaxed/simple;
	bh=hTOswAMXHTuN2JzLlryVh5QhkbQMDEvZecaju/nabc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4L6/FKJtUHLhE2/uYgVGTEAHfom6YLpnCiy7Zyjb3IBrceC/F05xtlwU4Pp2FEdSPvI3WgkLpjjEXeXYIhxhLtGBFP78ssLdlTOUrT3SOx5lQF9oi5tTtX5avbPiLKxxLk4OKqFKWiTLnLAkGin7WAXBQv/chWjIY+yDjRS75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqqL7uTC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f2381ea85so91867245ad.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522687; x=1772127487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkxeSRNozphRkvDz8e4X2zTXkvoc+MBpE+qTf+2BUww=;
        b=kqqL7uTC6Z+7+DEj4mu1m0zgbAQw37/7e2zq+U3yTilhy69BUTy4xjeo1NgyeffP7u
         z4Qr+I/ccELdMCthKvhpVlHYPW3FpuY+m1y9OVR4rU6BHpA9gbT04dhFA6jCdx+o/5pk
         BBFdQknyo293GVdy/XMgsMWuU0pGhFsCR5g7bCpuQE+pLSUi3l8ApkaanrdPnCHAvWil
         2uofaui+/6jt73zSAeymyhzVH9xhlEN6Sz3imVVTlbtMdRx/M2MLsn2G8j+cJ5ekBMs9
         DW1U+vmtels/EJQAK7z6qQIyhPvAaX4GALgKJzvx43frJJ/rcda2l1/wOASVG7xdYxVK
         YpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522687; x=1772127487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkxeSRNozphRkvDz8e4X2zTXkvoc+MBpE+qTf+2BUww=;
        b=i0s0WaLVa5USCy5Ezl1yINX9WAXfLsl8R/orYjf9I7HVRRhoSoXHZOzLnklfPUn5wL
         xAIBmvlE5Ve3NxlfGmQuiDXPFUyEynJg6MJbCw3y1NdWzM5W71/GmgKkrnTWfkpHc4t/
         lWboAYZgLoswepavR2L8xK6pqwvIPH5pcpyQ/IycfbQFuINyizHWuzHAUqaZPKCYnSmL
         kW5CmTcwQVy+WdNF8ZAB5fBEXAElv2eY0olQ4mDPn74Fn2aP2SbOpEqv/wam5LHxHxcw
         Os01G9bvOI2Szx/lUJjLlTtSBhqT/hyzp9WWLLxUcmKNBWENVNs6gbIsx69lfABWx6N/
         qoyA==
X-Forwarded-Encrypted: i=1; AJvYcCX3tbwHroDK2IaqGkc807DonCQllYhReiX4MH7M2+w9TL1GHS7yG2pwfysElYVZP6Z9BSSTnAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9vjYLf2n+znoE64G1T7InqbnpIVWFjQo+PkhMHBO2DjEsG5x
	sKS7jN2gi4dWeLIePJsILCjBU9rZhWOvKLaLu6YmELuLxSTFb8LlS9rR361Z9oqlF4dzu51Bk2K
	ceagVYg==
X-Received: from plev10.prod.google.com ([2002:a17:903:31ca:b0:2aa:d604:fb13])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f46:b0:2a9:6414:719c
 with SMTP id d9443c01a7336-2ad1746a592mr174430595ad.16.1771522687223; Thu, 19
 Feb 2026 09:38:07 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:28 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-6-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
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
	TAGGED_FROM(0.00)[bounces-259536-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ABDE3161505
X-Rspamd-Action: no action

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Keep msg->sk assignment
---
 net/core/skmsg.c | 62 ++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 57845b0d8a71..6bf3c517dbd2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,31 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
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
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	if (skb->sk == sk || !take_ref)
+		msg->sk = sk;
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +605,8 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +616,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
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
@@ -651,7 +625,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1032,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, GFP_ATOMIC, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.345.g96ddfc5eaa-goog


