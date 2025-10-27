Return-Path: <netdev+bounces-233095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D2C0C28C
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17D73B72EC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331192E0401;
	Mon, 27 Oct 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2XEAQTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE92DF3E7
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550697; cv=none; b=sAYKXhbgJNOJS7QhzLnCZFh8tAHA8DPuuIOZcK0l03OuFu8jj8XZTcA0PMuYx3qw18+WP0/LhrlBGGo49yZBDkoxL/DxubbIXa5BwG7f88PdJNNb0lPzez0Bwb3djcp2t1iSFiHr65Pn5ae9WnIAWx84qHeY+gwVaSCSRIUx3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550697; c=relaxed/simple;
	bh=K3USAVCKOuLHjXUETXE/ZswpCV3X7G9HJITMFfdkt6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KW12nYqE9Ucj8fxWjY50QmdCcMWfmK1nlMAD6CjfNNIvRoGPLjr5eM1ifYT2vmasrBRn5kpM7UTvq1ExyRBurdssbLfj4Lrl7O7qHms0LqS4GBwqD82CGBi0jYe8k8si2R3FrmVndbX9mLy5CTm3iCNdTAt9bwd4G9pDhJx8DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2XEAQTb; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-89090e340bfso896107385a.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 00:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761550694; x=1762155494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+n4UpZAKdLW1drIancA9Rr34Ri76O6X2kEE/8ReP30Q=;
        b=k2XEAQTbVwkjQN+7OgbDl0mNp86lYGfNhBzzGBsxSWQpiQmXUNSR2agcBHq36RiGXY
         igJZL4yIl6j/YGvuNVIq8dPE86QybxOi1LBm89im2HdPSxzzXMu0dfq9kTTzQSx2FuXo
         yAbfT99a/0jGS5CDghtgSAn+JLS5QlLu8E6luoNWVDE0ZRBuDknz2IZZc0vUJl+vdHFv
         LLgZjgNGzuLpFbict8lJDv7lAOeUMzF42CECv+/G5xbLteWPETUxUEgNxIhMfUHyleA7
         +02rgJGTEAR6TZ83lgkyJw6QcbHphA0kYPuMJzifEqkpteY6rBIRS/4Yffx+Mh8mXFDN
         F34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550694; x=1762155494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+n4UpZAKdLW1drIancA9Rr34Ri76O6X2kEE/8ReP30Q=;
        b=Kswxnb8oCHlxgspAsN9TknVPAfaIlTMUTvEkbpiSY/finzmDcXPnrd65qFccTela/B
         N+q9/hhJALtRcBFNIdKuZcTU3c15Vckan04v/o5CK7soCt7HsTolVbqWaYt5QsZhXfLI
         Y9sjwe/yh3Mlo4EsOidhQHaHyWe4mkWJWw9vxZ97Rh4z2K65htCaajvj2z6TvONzPQNY
         /kC5lRF1xj9uz/1oj0zqYTlo49D1O+qW4CEpWLlvAH2m7WLO97Sb8Q1+C8hMJdDi/nEt
         cIvKWaXG6xfTBbBI9n61J2uxSN9DAdDsCOp58CAF6CzjzDLW9MdTiSw2cIyggEBhwFPH
         /73A==
X-Forwarded-Encrypted: i=1; AJvYcCXn85bh0EjeOVTFLUyOFOiOjtc1Ui3+s4EJx2GiHgr+1Al9DOlS77z7RANiZgJk7nFJCkYYWfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzXLqiZp/gLx+YV84dFP52J9VQfAi0mzpCXKonj+Cth1l8ot/
	DJOcZ+/pOfvlKJ5Rg8dJGwaP/jvp+TKtLxzPsbQNSipbcX5BZalMtlFA9W8jLcx5ycmB8APE7D2
	w9ynAj+v5ydv5Bw==
X-Google-Smtp-Source: AGHT+IErd7Pz6NDrsn0iJ095KnYxlHeahxfGni0fbYsncp/sfXh2v41jiAL9oXxlPpAW9JG+vbA/az/Mx2Jqtg==
X-Received: from qkau1.prod.google.com ([2002:a05:620a:a1c1:b0:89f:7a0e:734f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3184:b0:8a1:fe2b:d4a7 with SMTP id af79cd13be357-8a1fe2bd848mr430979885a.57.1761550694306;
 Mon, 27 Oct 2025 00:38:14 -0700 (PDT)
Date: Mon, 27 Oct 2025 07:38:08 +0000
In-Reply-To: <20251027073809.2112498-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027073809.2112498-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251027073809.2112498-3-edumazet@google.com>
Subject: [PATCH v2 net 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch has no functional change, and prepares the following one.

tcp_rcvbuf_grow() will need to have access to tp->rcvq_space.space
old and new values.

Change mptcp_rcvbuf_grow() in a similar way.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  2 +-
 net/ipv4/tcp_input.c | 15 ++++++++-------
 net/mptcp/protocol.c | 16 ++++++++--------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5ca230ed526ae02711e8d2a409b91664b73390f2..ab20f549b8f9143671b75ed0a3f87d64b9e73583 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -370,7 +370,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
-void tcp_rcvbuf_grow(struct sock *sk);
+void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2dc8a6f95f3f8c24065369765b8987..600b733e7fb554c36178e432996ecc7d4439268a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -891,18 +891,21 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 	}
 }
 
-void tcp_rcvbuf_grow(struct sock *sk)
+void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap, oldval;
+
+	oldval = tp->rcvq_space.space;
+	tp->rcvq_space.space = newval;
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return;
 
 	/* slow start: allow the sender to double its rate. */
-	rcvwin = tp->rcvq_space.space << 1;
+	rcvwin = newval << 1;
 
 	if (!RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		rcvwin += TCP_SKB_CB(tp->ooo_last_skb)->end_seq - tp->rcv_nxt;
@@ -943,9 +946,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	trace_tcp_rcvbuf_grow(sk, time);
 
-	tp->rcvq_space.space = copied;
-
-	tcp_rcvbuf_grow(sk);
+	tcp_rcvbuf_grow(sk, copied);
 
 new_measure:
 	tp->rcvq_space.seq = tp->copied_seq;
@@ -5270,7 +5271,7 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	}
 	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
 	if (sk->sk_socket)
-		tcp_rcvbuf_grow(sk);
+		tcp_rcvbuf_grow(sk, tp->rcvq_space.space);
 }
 
 static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14eedffde166cc2a2d4eaa7c3aa6760d..f12c5806f1c861ca74d2375914073abc37c940d6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -194,17 +194,19 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
  * - mptcp does not maintain a msk-level window clamp
  * - returns true when  the receive buffer is actually updated
  */
-static bool mptcp_rcvbuf_grow(struct sock *sk)
+static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct net *net = sock_net(sk);
-	int rcvwin, rcvbuf, cap;
+	u32 rcvwin, rcvbuf, cap, oldval;
 
+	oldval = msk->rcvq_space.space;
+	msk->rcvq_space.space = newval;
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_moderate_rcvbuf) ||
 	    (sk->sk_userlocks & SOCK_RCVBUF_LOCK))
 		return false;
 
-	rcvwin = msk->rcvq_space.space << 1;
+	rcvwin = newval << 1;
 
 	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
 		rcvwin += MPTCP_SKB_CB(msk->ooo_last_skb)->end_seq - msk->ack_seq;
@@ -334,7 +336,7 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
 	skb_set_owner_r(skb, sk);
 	/* do not grow rcvbuf for not-yet-accepted or orphaned sockets. */
 	if (sk->sk_socket)
-		mptcp_rcvbuf_grow(sk);
+		mptcp_rcvbuf_grow(sk, msk->rcvq_space.space);
 }
 
 static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb, int offset,
@@ -2049,8 +2051,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	msk->rcvq_space.space = msk->rcvq_space.copied;
-	if (mptcp_rcvbuf_grow(sk)) {
+	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
@@ -2063,8 +2064,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			slow = lock_sock_fast(ssk);
-			tcp_sk(ssk)->rcvq_space.space = msk->rcvq_space.copied;
-			tcp_rcvbuf_grow(ssk);
+			tcp_rcvbuf_grow(ssk, msk->rcvq_space.copied);
 			unlock_sock_fast(ssk, slow);
 		}
 	}
-- 
2.51.1.821.gb6fe4d2222-goog


