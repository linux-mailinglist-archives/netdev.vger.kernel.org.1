Return-Path: <netdev+bounces-259535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IES/GIVKl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F11614B7
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C68F3006148
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963634FF5D;
	Thu, 19 Feb 2026 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEf5v9u2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6629934FF79
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522687; cv=none; b=o6utAoXjTzoJ7zSL0vSAWMTKW529Gz7dh4gOReqT4+IEyVseaWLVjzTNEkapYlsdhWB/Pgti1dZfQl4ArtEqZyi0pU5Cp8pamModwaq0/0VmizprTquke48s0bUa548LBpIupZROszT94VssWuM05LcUCbKF3TWjMa8aoGG9yjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522687; c=relaxed/simple;
	bh=YrNSu/qk2Q0MBb/9sHDUNtgXzdLzHD/vjDuNbxue3cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MpenROgJFIxCAdfMxYg9ImAQeRS74cR82i1qa+9mlnQ2ScnUOopF1iyMv8pqvJSVlg6VxcKyiD2IhW6jn5mDMuKahYmAECZ1lLjDZRAzBJqsbubaIAE7fF65GUwkShoymJ/o7F78BfsrQkvWA+VL3lJpetaNDfh5u64HvxRrehM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEf5v9u2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7a98ba326so21616865ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771522686; x=1772127486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOxsXg7G9eurQWLN7+TFPprvlYX5DCWquut4adI+7LM=;
        b=iEf5v9u2h9KZugr33QMWzFyG4CCzza4BJ7/20HF7z5uLcOgaZjf7yXB+B671zjzmyU
         MvEwxTKRSZJg4mR2uxkx2Oy/sNH56NRnUlSNQAvBdjK0OGycP86TTRAGJCb/7ANGlZ2q
         p4mSYnOtc1WT0reDJGB0zPb1KOURD4SijI6+3LcTDKSTtMTPW1/yubwGOorildnXWYIC
         W+L3SKhkcT02a5h+bOYJnyMr/2bv8vouKy9/ttZN5TxBGiIW9khz85RdBA5VEBJC3Us5
         PERgUjKyh9h3JS8hVSJKQBcyNw1oB+l6h4HNJbwK7MsLTmhFbFU2EEdb9fcvPSQqDXfL
         qjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522686; x=1772127486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOxsXg7G9eurQWLN7+TFPprvlYX5DCWquut4adI+7LM=;
        b=rfuHFCRehHWLHnrqlgSH0DyY5I0iQpgMI9VxCE13pMCILVgBCVY/Wk9vv5KfIQfAAJ
         IDx9IqgKh3yHov5jnCAHs+cy7cHAmm0GST9M5CNuhbDDNMwwgGLQr36iNChFweKoBE3z
         KD1FwAJi9tG+Qn4381QPH40bSuiNHQQKLDbghVuBPZP/BrPvxQ0mVtnQIndM0WP7MMgX
         AVoRAbLxg4mD0iykl0eXcJlW+YfK0IBu5hi08dQPUiOtGHH2jlP28wEqFOQj4bLUXy85
         pCL66r7j7ACWl6fqDO5EUPN07NxP34+9XWYexPQgpKpn4C5rpXnbAwYXUdmYs5EsdVNs
         E5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZYGDqG8YMkN5Dyh8h76VLFphEbXemyY2uHikiRgHKwzv49UKiU7NzvOErnVR/0gXx/9doido=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dLt9YFJr0FJP8DUAHhlreeuHIOg+VT5KFK1nfAFEYicYhdMA
	xEGb0tQEIW6Zs+ov5166dcUMu57tt3TGmer5J1/1IRj7j5LMBFiCY/ySCnvZOltb5xW9UKYoOLS
	XOogKSg==
X-Received: from plef4.prod.google.com ([2002:a17:902:f384:b0:298:1151:5f6d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:2aa:e817:1bda
 with SMTP id d9443c01a7336-2ad5f94011fmr24398745ad.12.1771522685547; Thu, 19
 Feb 2026 09:38:05 -0800 (PST)
Date: Thu, 19 Feb 2026 17:37:27 +0000
In-Reply-To: <20260219173756.315077-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219173756.315077-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260219173756.315077-5-kuniyu@google.com>
Subject: [PATCH v3 bpf/net 4/6] sockmap: Pass gfp_t flag to sk_psock_skb_ingress().
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259535-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F3F11614B7
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
2.53.0.345.g96ddfc5eaa-goog


