Return-Path: <netdev+bounces-258962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPACGYqxk2kK7wEAu9opvQ
	(envelope-from <netdev+bounces-258962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:08:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D40148328
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDF6303BB26
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B596913DDAA;
	Tue, 17 Feb 2026 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xob2DPoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFF31A9F86
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286832; cv=none; b=HVmIRZ3zZH1HxhXUWFvJc8FskONM8tbcmqzm1jDbi7zHQy7RsmgF/xEqt8wYGhl3ov0gKtk9lsnVT3R0VVbMa1GOF/mZuKoyf9wlaXap6VR859RnYxze1XMzIpMKqY0kXYgj2WX47zA43699VPj5vOjy2KJ2mHbrWNmYj4unuHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286832; c=relaxed/simple;
	bh=MkAF6NrOoDIjmjTurHR5Pb6sxyEpSSoVIdDhEBK0kcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWtLJXDqExeZHdA2SIyoftL4EnY1x/2SwqOwRL2Xng+fYyHXJ2Cz9KVtZzZYGDP4IsStTaPNCE/96MsGdaB4qw8P8vd+pw9rR9+kKhNxxHixnxZ9q+oWcyyQsmRuf8FupD2iSzZCGEulqyBfqaQzIPEegz6D0WO7fHGtnYjqTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xob2DPoZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aadeb3dee4so203322385ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286831; x=1771891631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=xob2DPoZiBWVkC+DDxR/lAPrjKmE54iJfOw/P5IXkTuQx2mIJU4o5MrZfaL1xCfXza
         08NCc9CFRQlIFD94ODD3eKHYLE2D1NUtduR05JwGNlVadlCrTxDTep765godKs4I1YQ3
         DRaVPVxRICfQ6YOOjWd24tGyZ64aSRgJYJkTCy0+SG0HNdEMvAtMeUlyIi8gVB4ir9aQ
         rX4I7FXtQAK+CxC6IVsFh11i5hLE2j1puBD4PFlvg839WKv8+/zby/3nmrPYANjR/DzI
         0SdEwrBilYsOGKINH1khqF6On20cfRco5gMSiThQNfWywnspKLvbvnKPSlVgC1Y8yPx/
         zFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286831; x=1771891631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BT5YOjf9XtzKKAlrK8bU47/cOZRZChjPVpJTvbg7E4=;
        b=eqmFmX/Mm5DHTQ0SdPdZTZzk7ymLc7u+FaZjXtSj+QDEsIfbe1wIeib2fW2wFv9jzb
         682aftKTaqSzu8ulGrVyr4d+/EA0gkosiB1lwIIh737uWpg9mUBsAqCv+PD5BlDLp62I
         uDXUq+PJkOrMuWKZAG3w7jveI11091FRx2A2IeaeNQt76t1ZeD9vVJdvlPlTP8MO3OBl
         A6jvm2ksyguTFJzsLbjhvrH8L37ljGK/m7BqmEUkID7+gISv+Xp4GII6M9L/iEywy4BS
         0OJCdGR/Nm1V/doTOgQ/VKjSgUzTxsXqEpIGJSEopKULiKgunBaaQC8O3iWzIsDvaoNU
         gX8g==
X-Forwarded-Encrypted: i=1; AJvYcCWM/g9r0XB7Jbdpba67K8ZJVJd9/hkojiGsyAPVc3GhxHpSfMOzi4X9OsBQxEkHa6MtD5GtVdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwAU5w3SSiuweJy0Ycv70gcyv9J00/d03ZwEx9hCqg/fVHOi1
	Luk0OELq4Dqc1y56CFj5ammHPzCJzWH6IEwub0ALoREKqYVF/iQbGm3CuSAp0lppQ66IHVo7cAf
	aMwG7mw==
X-Received: from pllt10.prod.google.com ([2002:a17:902:dcca:b0:2a9:48e5:ca1b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:124d:b0:2aa:d0ff:c3a3
 with SMTP id d9443c01a7336-2ab4d06d4e7mr124408385ad.47.1771286830552; Mon, 16
 Feb 2026 16:07:10 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:16 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-5-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 4/6] sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258962-lists,netdev=lfdr.de];
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
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D40148328
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

Let's pass gfp_t flag to sk_psock_skb_ingress() and inline
sk_psock_create_ingress_msg().

Note that now alloc_sk_msg() is called first.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/skmsg.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 3d7eb2f4ac98..57845b0d8a71 100644
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
@@ -588,11 +576,11 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len)
+				u32 off, u32 len, gfp_t gfp_flags)
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
+	msg = alloc_sk_msg(gfp_flags);
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
@@ -652,7 +651,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
-- 
2.53.0.310.g728cabbaf7-goog


