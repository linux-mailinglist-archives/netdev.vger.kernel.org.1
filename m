Return-Path: <netdev+bounces-203541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1648AF655D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 00:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B0D3A3B8E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7FE2F7CF3;
	Wed,  2 Jul 2025 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdAIZZFv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F12F6FB9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495775; cv=none; b=kq3kPvSfgizzSG4EZ1dcsoS+VlKW60gOaTUx4SCoQYkbWOT23BauMPHxCYZkUpB/UDeTi3OKeKbF1YqNC8zwDaak4KZieEoti1hPNEg56pO9H0rUolKdMBB8Y72OpzC9q+KRvzY3TPZ14MlUv+u1J7Gg5eiCmb5ohG3BrQKMAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495775; c=relaxed/simple;
	bh=fPOQQ//XOK77txQoH80se7mKLqEE1RruW/e17p1rals=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YceHXbX3pxt+ZujZvtNKO4u5wMxRj+aIGGIbjnZJ7yz7Fsfdapxa6GArH/0RODzF5O5jnW61kDMe214w84DMwfZGwfxDn7X2gUSxJzir3j2hqig8NLEu/91374Pbn0iZNN1Zp/nK7T/uqtlFK5vjhBz3H5YkPD7mtT4Rp4j8hT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdAIZZFv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3216490a11so5834875a12.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751495773; x=1752100573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8MpJwKG/RIkdMdlaX4kIBz9V49VAtxAwli2Us54oeE=;
        b=pdAIZZFvMhOaBtOQt+iuLN9T1uOD1/Vj3bbHCJdu3rKhmnxTCWl3DUegoYZBorUZDG
         2vDrnO0atoIVKer9Z0dOW40Qxojx35Tbhbpnv/gOCANfIPXXvkWeC8lOzSGXYpTrkvXq
         +LpuB87NoJ15UB6Gp9dcqEbjkozaoGKGeDXz4padsX+S8V3k2FMAfE3Dw5dnPYeb10oB
         1PUMRoOYBwX4UaGDXXOiaaROLlKFv4XRtTWrvnBXxV6cM11fUiUwTkmgfD5x5kjBMDVY
         feITZjMEMTQrTHYKVoV8mh0Es9qF7oLcBoS690xucFMhMwLfaP4h5At6Eb1FyRK8dvgq
         KP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495773; x=1752100573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8MpJwKG/RIkdMdlaX4kIBz9V49VAtxAwli2Us54oeE=;
        b=vO/SJBeSs6Oe3C++xDbRYmsGXaecvNr4EFSqZTo98Kyrkqt84YZpIz8mH/4ReFmcIb
         I6ZJyWrNzSVmxWGFxIKp+tgnHmpKq/Y/M7Y03vBwrRBXTJ4+y31T2ufZYbBrKJx3YK5y
         cuzuIPFs+Vo6rbGi8LtJwJPB7W1UEUEUsqVEYgyo9uDr1NSljVb8E/a1An+ImoEAlcaZ
         CRtH2+9aAG47RiDw48mgGXdlUCWxOKlXHZ3XnUDrcxmYr+2dPcLFwx+afzFGuMsbA7NZ
         yFRYRIPh+jD52MIexg/qiFbDnsLJyHbR+hXNiyT7krG1w8qwmpyxo7O9csOXMTPLFSHU
         eWpA==
X-Forwarded-Encrypted: i=1; AJvYcCVwibzGiTp9mqPDFlV+QG78PFN+2fK+qIawvAxIL6YYGGP88a+BqOX6WT/+vXVpz6dtV8QfjwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytw0LlrGgLbMNeHcr+G0E48TtD18nUCnfYFfIubS9Lz3gOh4O0
	dwxb7VtmA7liPMhHkj8odwnCEC0BayzQ/fPPUNw5Cv6T/oHBAvZBXXdWGeBwTg/wRZKmLMbaJ5g
	muA4+Zg==
X-Google-Smtp-Source: AGHT+IGNsRiw7oGy8DNqoy5j0GOpyhqvI6IrKIM/KZ3F8F7WtuVUnXvpCrlL7vEVYVY3B/KHQot9ypV9YsE=
X-Received: from pjbqj16.prod.google.com ([2002:a17:90b:28d0:b0:30e:6bb2:6855])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5823:b0:311:c970:c9c0
 with SMTP id 98e67ed59e1d1-31a9d68bd32mr995195a91.22.1751495773090; Wed, 02
 Jul 2025 15:36:13 -0700 (PDT)
Date: Wed,  2 Jul 2025 22:35:15 +0000
In-Reply-To: <20250702223606.1054680-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702223606.1054680-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702223606.1054680-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/7] af_unix: Don't use skb_recv_datagram() in unix_stream_read_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_stream_read_skb() calls skb_recv_datagram() with MSG_DONTWAIT,
which is mostly equivalent to sock_error(sk) + skb_dequeue().

In the following patch, we will add a new field to cache the number
of bytes in the receive queue.  Then, we want to avoid introducing
atomic ops in the fast path, so we will reuse the receive queue lock.

As a preparation for the change, let's not use skb_recv_datagram()
in unix_stream_read_skb().

Note that sock_error() is now moved out of the u->iolock mutex as
the mutex does not synchronise the peer's close() at all.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index be4c68876740..fa2081713dad 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2787,6 +2787,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
+	struct sk_buff_head *queue = &sk->sk_receive_queue;
 	struct unix_sock *u = unix_sk(sk);
 	struct sk_buff *skb;
 	int err;
@@ -2794,30 +2795,34 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	if (unlikely(READ_ONCE(sk->sk_state) != TCP_ESTABLISHED))
 		return -ENOTCONN;
 
-	mutex_lock(&u->iolock);
-	skb = skb_recv_datagram(sk, MSG_DONTWAIT, &err);
-	mutex_unlock(&u->iolock);
-	if (!skb)
+	err = sock_error(sk);
+	if (err)
 		return err;
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (unlikely(skb == READ_ONCE(u->oob_skb))) {
-		bool drop = false;
+	mutex_lock(&u->iolock);
+	spin_lock(&queue->lock);
 
-		spin_lock(&sk->sk_receive_queue.lock);
-		if (likely(skb == u->oob_skb)) {
-			WRITE_ONCE(u->oob_skb, NULL);
-			drop = true;
-		}
-		spin_unlock(&sk->sk_receive_queue.lock);
+	skb = __skb_dequeue(queue);
+	if (!skb) {
+		spin_unlock(&queue->lock);
+		mutex_unlock(&u->iolock);
+		return -EAGAIN;
+	}
 
-		if (drop) {
-			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
-			return -EAGAIN;
-		}
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (skb == u->oob_skb) {
+		WRITE_ONCE(u->oob_skb, NULL);
+		spin_unlock(&queue->lock);
+		mutex_unlock(&u->iolock);
+
+		kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
+		return -EAGAIN;
 	}
 #endif
 
+	spin_unlock(&queue->lock);
+	mutex_unlock(&u->iolock);
+
 	return recv_actor(sk, skb);
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


