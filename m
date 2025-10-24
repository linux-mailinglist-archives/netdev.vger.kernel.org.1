Return-Path: <netdev+bounces-232377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBB1C04D87
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 402DE4FD13C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7C2F3630;
	Fri, 24 Oct 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMJbU6DH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C421A2F28EA
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292236; cv=none; b=kP3x7EAugSngqp11OwYg5iJ+E/NeJmAXV4gR+UdH49x+Jaxdq0a2Q91cRx6J1Kv1vKXe8QVm/zT5l+ci5JLlZOTyE1Bc8QeRhz2JEGQHJ88cblce13TSVmmmObw7izXWiDqvUTIV/K86hQQ662fzGmKxkKwj6rsysbheUmHYjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292236; c=relaxed/simple;
	bh=8lQqcZH+24Ff0AzM6bCxbLDlpDc8jgtC8AyHdyp8uus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O+YPi+iSXiEzR6re4qE3bBivy8a9NBqIkxoAQfP4jXr0lr6dhSCN6iLBXGMDH8hN08MupNRGZh1h/OrjPzWaIotdFmC/CGfGrzHb25LDZOTqo5qRw7HIOk0MMMfXVJm3OUov80tT9+soAyApQ2Rif6MCi1++y+C1dUClv8fwyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMJbU6DH; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-891d8184bebso347561085a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761292234; x=1761897034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5phnh+WnhKjkny5+MUu8AW3ruju9NK9PzPLQMBCiGZY=;
        b=mMJbU6DHn5J+0qkFFOcDbBU6AP8t/086Da5c/cz8+VZJpdfBpyG5krnK9RgebwEYcl
         2WwJLtX7X4i808AXMlJisI33yoPMuvF3xUxjU0+BKjAvSq2+9s9Mm88cMUI5fQtabmss
         xmovGFGPqqi0w4bWa2/75ghyZJCJ2mTe962hrsTpVC5FITORtKq9VN8XGXimWqN+13sw
         OD7HCxgxygptUmEUkiI1xiCZA6PTbHv1yoAaElCfviYnE8ukxS3oNp7ib065YWoS1WV+
         zOZ8B7Svxj90dm+z6AuV57r07ctPfulbjgwMEJV6OE5i0CHmfpvzu9g0xOq95dIDi6n+
         WRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292234; x=1761897034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5phnh+WnhKjkny5+MUu8AW3ruju9NK9PzPLQMBCiGZY=;
        b=Uc+kmKhYO8rZ1bgxVPA59eq8KIbp40Y4fgx3RrLu5csglAFixqEfafNnFmW/D0i1X7
         wxUjOL2nMwgfY2SqOyNrHyuBlXD75Wsmpd+1uXv8mfGg7rDs3uPF76YHM52RF1d/+/tC
         xY8xlfEoKnBgbHibM1X/CmvMYBtZuJcb3HIm6e5LTmA4ysUIXkzBdVGFxq2kDVpnOmpj
         ThKZMIz6okNf87g7ZPdVwDRe3epOAmJQY/V3A4ocq6q/Jh+28BEuB0hZ8B7JDqYFfA9N
         zZNqLLKPRa0UES/jvFcXl8q3Np9dHzxaRdoA3Spw5FfV6bahv0X5JJ6jxXqPJlJe6K0+
         apPA==
X-Forwarded-Encrypted: i=1; AJvYcCXEl/8tfmOHGikinE6c2XU9tDn7APvvQjqzTeI2t4HH9Hrh1kOS2Bj6GoYueE7652lYJiFt84A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7Ri9WcanG2Y0AcbaMMSReBVO9jHRjLUq2TXt9Ud2nIrlusMN
	lJUJQyCJStFBSUOAsGBZqLIowiarZektLPFc1hjnRelIKlfLuHSkV/1BHh9Mo+3j40DiF4HjMld
	u2YXo9WWb3iD8jg==
X-Google-Smtp-Source: AGHT+IE01DjVIkbwiaZhoPimlupp+AQ0oUSxWnL6RVUtuL8AtAANvsnspP336DF3tthjsxCB6F6GNZLhIqrVHg==
X-Received: from qkdd14.prod.google.com ([2002:a05:620a:a50e:b0:891:6285:7833])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:170c:b0:892:5c9d:edd1 with SMTP id af79cd13be357-8925cad32bbmr2475621785a.76.1761292233707;
 Fri, 24 Oct 2025 00:50:33 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:50:26 +0000
In-Reply-To: <20251024075027.3178786-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024075027.3178786-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024075027.3178786-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] tcp: add newval parameter to tcp_rcvbuf_grow()
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
index 190b3714e93b323a93db05cf8889c81a2ff6b242..4fd6d8d1230d0ce9f40b28a2cad10a5c8a1f9716 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -373,7 +373,7 @@ void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
-void tcp_rcvbuf_grow(struct sock *sk);
+void tcp_rcvbuf_grow(struct sock *sk, u32 newval);
 void tcp_rcv_space_adjust(struct sock *sk);
 int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp);
 void tcp_twsk_destructor(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8fc97f4d8a6b2f8e39cabf6c9b3e6cdae294a5f5..c8cfd700990f28a8bc64e4353a2c78a82bb6bcb2 100644
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
index 94a5f6dcc5775e1265bb9f3c925fa80ae8c42924..2795acc96341765a3ec65657ec179cfd52ede483 100644
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
 
+	oldval = msk->rcvq_space.copied;
+	msk->rcvq_space.copied = newval;
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
@@ -2050,8 +2052,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 	if (msk->rcvq_space.copied <= msk->rcvq_space.space)
 		goto new_measure;
 
-	msk->rcvq_space.space = msk->rcvq_space.copied;
-	if (mptcp_rcvbuf_grow(sk)) {
+	if (mptcp_rcvbuf_grow(sk, msk->rcvq_space.copied)) {
 
 		/* Make subflows follow along.  If we do not do this, we
 		 * get drops at subflow level if skbs can't be moved to
@@ -2064,8 +2065,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
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


