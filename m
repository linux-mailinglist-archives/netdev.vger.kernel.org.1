Return-Path: <netdev+bounces-241245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D8C81FA7
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 263EB349540
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7B3168E3;
	Mon, 24 Nov 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFg2mloT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D82C21EC
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006623; cv=none; b=YbB/a76Ek6ogM/8frwtDTw1UWh/OOaBXfhDLRjBAEx+e1vG3Yf8zR6/lW1b3qGj02eEzw+DlPzvs9Fki8MtKa4DL4wPyRCsz8jqoEnC3nshsEyfVwnjTAWRU4ynfgr2YWxNUlFiYklg4eKb+J9BfpJgDnIhPsrTRiTr+XUUUego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006623; c=relaxed/simple;
	bh=ohtYdkJ+gKJsAuTX8BaAaXAgnBxLDYC1Qc+qCPF9ZWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z27q1PXVYfEDIobttZuSbAl3UzYMnsGsefzxAGxwm4kw+/y9/P6L2JUJ2DKLcdc5SQ+OqCn+l1G4+cL2WWpRT03gcjQLcFvlGuZLR79LwFTXMNGcaDMWXfBBNkkCuxDDNqsH8jk+1NgTsa7T2eSJtTNXwVNjnojcjm/3Q6m0cR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFg2mloT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-78817da4711so61198477b3.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764006620; x=1764611420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EM3kvY16Q0zEJREGaxQiR6OVAPxjEO9bnVyCW3skAwA=;
        b=KFg2mloTIrLmWewFdu+vcxmELS7n7qohOVx7LRDB1SoDtQwoAT2xMPwitnUuyiOttS
         r7f9Hm1TFl0EXJeStl9MWs1wCHCDyo4LSmJuJyqjcc73JfrvOuSE79psIszvTnV0KgXW
         fqsXY//fI4xXmVZSIH4TySfe5lKd24woigK+ZNlNwPnasvF23lIKV64Inktb/RI4z83W
         FHxY1DTG+JYL12Y4Sz29eWjU/1z0Qg01Mtb9VU1O+8tkjIIjs7/rxqPsUGHvQgPoyIjt
         0v5QvnTJyTms4snTLdNVZYMvN5xxhJ7KVpf6PxirLxQlNu9cel3C2jVOMVksMQ4bHAEx
         PFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006620; x=1764611420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM3kvY16Q0zEJREGaxQiR6OVAPxjEO9bnVyCW3skAwA=;
        b=gIWrf3CqRc6N7z9wrYeO8LB8OYJT2YHK24iNkyuFDLIZkqxyz98Y1XEtI2yncWuYYN
         Wi3ZpoM6HZz1FcAUMfb4koHQDrBwUuDyqCUcZZp2WHJCycyODSlMaUaLSP3GjZAV+Hre
         Ph8B1vqG9uaD8k2indZj9RikRqTDqigudJn+8P+pn6FlP1ycz6A1mIXre+mX1p/tGlge
         g9gGaHGO5InKJbkQ/CCGCTspGJkzWKWyw8WVxfDDlbrIuYbuUS3jVsJbbfDfCuq4M5jc
         E5ALPW4GfoZeNkjJWFfLJ/HjreSlB+Hd1FULsG+da7WOIaQaFXSKB47w1b3zuKC4DCq4
         /Ecw==
X-Forwarded-Encrypted: i=1; AJvYcCXTyzJwYstrQpmUYtRxJ+TTrupFL01eDMoEnuAB7Kp6EfCCaXqL6tJhHv90LkWMxSigBDdVu2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQaHqPN2ghW27d2V5R7fvWTHunCWlrVlUWMgjjiPQMKIsv1pT
	sJRvt1mnecoHKRqTuJUNPL4udnrxGmXQ/o2FeDS8rI5SvOMM8cIoNpTVhnaHI/PSBufzuz7mnQE
	sCTcp3omSjYG/xg==
X-Google-Smtp-Source: AGHT+IFUgCvKVPG1l+RQ7TWV5VyIerusrV0Njn7kbMxdQz0K7RS0Sx7U84WXCHEtue+jTQ+OatytO4EceJak9w==
X-Received: from ybit3.prod.google.com ([2002:a25:aa83:0:b0:ec0:b121:8eca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:2459:b0:63f:ba88:e8e9 with SMTP id 956f58d0204a3-64302abc5aamr6895144d50.43.1764006619413;
 Mon, 24 Nov 2025 09:50:19 -0800 (PST)
Date: Mon, 24 Nov 2025 17:50:13 +0000
In-Reply-To: <20251124175013.1473655-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124175013.1473655-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] tcp: remove icsk->icsk_retransmit_timer
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now sk->sk_timer is no longer used by TCP keepalive, we can use
its storage for TCP and MPTCP retransmit timers for better
cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net_cachelines/inet_connection_sock.rst       |  1 -
 include/net/inet_connection_sock.h                |  8 +++-----
 include/net/sock.h                                |  9 +++++++--
 net/ipv4/inet_connection_sock.c                   |  6 +++---
 net/ipv4/tcp_timer.c                              |  8 +++-----
 net/mptcp/protocol.c                              | 15 +++++----------
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c |  4 ++--
 8 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 4f65de2def8c9ccef1108f8f3a3de1d8c12b8497..cc2000f55c29879a12c0e4d238242b01cee18091 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -12,7 +12,6 @@ struct inet_sock                    icsk_inet              read_mostly         r
 struct request_sock_queue           icsk_accept_queue
 struct inet_bind_bucket             icsk_bind_hash         read_mostly                             tcp_set_state
 struct inet_bind2_bucket            icsk_bind2_hash        read_mostly                             tcp_set_state,inet_put_port
-struct timer_list                   icsk_retransmit_timer  read_write                              inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_delack_timer      read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_keepalive_timer
 u32                                 icsk_rto               read_write                              tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index e0d90b996348d895256191a5f10275d8f3f3a69a..ecb362025c4e5183ec78aef4b45c249da87c19ea 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -56,7 +56,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_accept_queue:	   FIFO of established children
  * @icsk_bind_hash:	   Bind node
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
- * @icsk_retransmit_timer: Resend (no ack)
  * @icsk_delack_timer:     Delayed ACK timer
  * @icsk_keepalive_timer:  Keepalive timer
  * @mptcp_tout_timer: mptcp timer
@@ -84,7 +83,6 @@ struct inet_connection_sock {
 	struct request_sock_queue icsk_accept_queue;
 	struct inet_bind_bucket	  *icsk_bind_hash;
 	struct inet_bind2_bucket  *icsk_bind2_hash;
-	struct timer_list	  icsk_retransmit_timer;
 	struct timer_list	  icsk_delack_timer;
 	union {
 		struct timer_list icsk_keepalive_timer;
@@ -193,7 +191,7 @@ static inline void inet_csk_delack_init(struct sock *sk)
 
 static inline unsigned long tcp_timeout_expires(const struct sock *sk)
 {
-	return READ_ONCE(inet_csk(sk)->icsk_retransmit_timer.expires);
+	return READ_ONCE(sk->tcp_retransmit_timer.expires);
 }
 
 static inline unsigned long
@@ -209,7 +207,7 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0) {
 		smp_store_release(&icsk->icsk_pending, 0);
 #ifdef INET_CSK_CLEAR_TIMERS
-		sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+		sk_stop_timer(sk, &sk->tcp_retransmit_timer);
 #endif
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending, 0);
@@ -241,7 +239,7 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0 ||
 	    what == ICSK_TIME_LOSS_PROBE || what == ICSK_TIME_REO_TIMEOUT) {
 		smp_store_release(&icsk->icsk_pending, what);
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, when);
+		sk_reset_timer(sk, &sk->tcp_retransmit_timer, when);
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending,
 				  icsk->icsk_ack.pending | ICSK_ACK_TIMER);
diff --git a/include/net/sock.h b/include/net/sock.h
index 7c372a9d9b10c97f9d0c4d6faab267a04bd68e0b..ebe3897eb02a74d8cda337b8ebea4f920c826858 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -305,6 +305,8 @@ struct sk_filter;
   *	@sk_txrehash: enable TX hash rethink
   *	@sk_filter: socket filtering instructions
   *	@sk_timer: sock cleanup timer
+  *	@tcp_retransmit_timer: tcp retransmit timer
+  *	@mptcp_retransmit_timer: mptcp retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
   *	@sk_tsflags: SO_TIMESTAMPING flags
@@ -482,8 +484,11 @@ struct sock {
 	};
 	struct sk_buff_head	sk_write_queue;
 	struct page_frag	sk_frag;
-	struct timer_list	sk_timer;
-
+	union {
+		struct timer_list	sk_timer;
+		struct timer_list	tcp_retransmit_timer;
+		struct timer_list	mptcp_retransmit_timer;
+	};
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
 	atomic_t		sk_tskey;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4fc09f9bf25d59e8155107eba391f5c566f290a0..97d57c52b9ad953d7ec1ad679237b5d122f47470 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -737,7 +737,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
-	timer_setup(&icsk->icsk_retransmit_timer, retransmit_handler, 0);
+	timer_setup(&sk->tcp_retransmit_timer, retransmit_handler, 0);
 	timer_setup(&icsk->icsk_delack_timer, delack_handler, 0);
 	timer_setup(&icsk->icsk_keepalive_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
@@ -750,7 +750,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 	smp_store_release(&icsk->icsk_pending, 0);
 	smp_store_release(&icsk->icsk_ack.pending, 0);
 
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->tcp_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
 	sk_stop_timer(sk, &icsk->icsk_keepalive_timer);
 }
@@ -765,7 +765,7 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 	smp_store_release(&icsk->icsk_pending, 0);
 	smp_store_release(&icsk->icsk_ack.pending, 0);
 
-	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer_sync(sk, &sk->tcp_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_keepalive_timer);
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d2678dfd811806840cb332d47750dd771b20d6af..160080c9021d0717605520af3f1a47d071e7bf4d 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -698,7 +698,7 @@ void tcp_write_timer_handler(struct sock *sk)
 		return;
 
 	if (time_after(tcp_timeout_expires(sk), jiffies)) {
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
+		sk_reset_timer(sk, &sk->tcp_retransmit_timer,
 			       tcp_timeout_expires(sk));
 		return;
 	}
@@ -725,12 +725,10 @@ void tcp_write_timer_handler(struct sock *sk)
 
 static void tcp_write_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk =
-			timer_container_of(icsk, t, icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = timer_container_of(sk, t, tcp_retransmit_timer);
 
 	/* Avoid locking the socket when there is no pending event. */
-	if (!smp_load_acquire(&icsk->icsk_pending))
+	if (!smp_load_acquire(&inet_csk(sk)->icsk_pending))
 		goto out;
 
 	bh_lock_sock(sk);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a3175c922add6d47f3268cc4cc3c663d9509cee..d48c7947df6ef267ae770c63eeb70085a311a4df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -416,9 +416,7 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
-
-	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
+	sk_stop_timer(sk, &sk->mptcp_retransmit_timer);
 	mptcp_sk(sk)->timer_ival = 0;
 }
 
@@ -926,12 +924,11 @@ static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list
 
 static bool mptcp_rtx_timer_pending(struct sock *sk)
 {
-	return timer_pending(&inet_csk(sk)->icsk_retransmit_timer);
+	return timer_pending(&sk->mptcp_retransmit_timer);
 }
 
 static void mptcp_reset_rtx_timer(struct sock *sk)
 {
-	struct inet_connection_sock *icsk = inet_csk(sk);
 	unsigned long tout;
 
 	/* prevent rescheduling on close */
@@ -939,7 +936,7 @@ static void mptcp_reset_rtx_timer(struct sock *sk)
 		return;
 
 	tout = mptcp_sk(sk)->timer_ival;
-	sk_reset_timer(sk, &icsk->icsk_retransmit_timer, jiffies + tout);
+	sk_reset_timer(sk, &sk->mptcp_retransmit_timer, jiffies + tout);
 }
 
 bool mptcp_schedule_work(struct sock *sk)
@@ -2306,9 +2303,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 static void mptcp_retransmit_timer(struct timer_list *t)
 {
-	struct inet_connection_sock *icsk = timer_container_of(icsk, t,
-							       icsk_retransmit_timer);
-	struct sock *sk = &icsk->icsk_inet.sk;
+	struct sock *sk = timer_container_of(sk, t, mptcp_retransmit_timer);
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	bh_lock_sock(sk);
@@ -2876,7 +2871,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
-	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
+	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 685811326a04126f411da2199cbb5dba576cdde7..b1e509b231cd97dcc863db84ffa9bfa5897ca4ce 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -99,10 +99,10 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
 		timer_expires = icsk->icsk_keepalive_timer.expires;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 0f4a927127517ce3d156c718c3ddece0407c3137..dbc7166aee91f5403d3e275522cb652f104ac9c5 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -99,10 +99,10 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_retransmit_timer.expires;
+		timer_expires = sp->tcp_retransmit_timer.expires;
 	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
 		timer_expires = icsk->icsk_keepalive_timer.expires;
-- 
2.52.0.460.gd25c4c69ec-goog


