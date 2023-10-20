Return-Path: <netdev+bounces-43022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCD67D1005
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29C12823AC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9B1A71E;
	Fri, 20 Oct 2023 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHUoTFr1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005121B29C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:05 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00D4D5F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a81a80097fso10130157b3.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806684; x=1698411484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksUeEywK/bpvjP7ZVaoHGPKQBLrGKqJL+2b6PPJOsIM=;
        b=rHUoTFr1bD92yLtcrMOW2nM/he3N2hmvkK7bv7RMRWahceU6BDbcbp6Ak/Cn+Za0yY
         g3tCkucFp3Ebui4kkYjjFJHNQ4C+8aKfJFvCELGQooiNiSYbaZPuoXNZo0nLNpj9UBNn
         NXek1eGfh3qBXGrcUjjit2vASjUhH+bzNu5y8QfkeS0utJc0hy9FyjcazCYpapPchcdp
         rxaZl6IVazRk2hErF5Fw5dq2aY4nbn5oXZ7i0InGTiKE8t2XmoWqK8+cCPySkP/G4j/O
         9HpFRZ6o2LDqD1IRFt3ybx/Zr42J0HJRDsf6lyihI8xW+EQDUWkkXYEv3X+sKJP9SN/a
         QWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806684; x=1698411484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksUeEywK/bpvjP7ZVaoHGPKQBLrGKqJL+2b6PPJOsIM=;
        b=Lv6QB5jowekJefnOFn8BRSWUoBA2wIYyqcw9I1tiyHeFTZa330ee6ejoj1lpON9ZsO
         cthtRBLblQAwpLb9XNeuXMxJwjTgIE3V0ktR+YHPZdr5Y8OXMheVraz6BXCBxsnq2JhX
         TVebnER4EBh7GnwA6pdYvtEXfLYOSkfJSYzQPYFVwNJi1xcjSBUmhoeCJqflKSf5/+6g
         sZ7eY/QOJc0errgV4oZeWeQTAzGVTI8T4gT/9z4k4rxXvTfO7wL/O90XbCbymF8Hl6ex
         S5ydKOHOVT5MXxfUm1eWX0GbW8nBM2/Id6iop5SeITSacNXdqhBDacux+nxl+6jk2eYn
         yaTw==
X-Gm-Message-State: AOJu0YyZgKfHsViUbEJl+4xsOV44X+ZCq9wrfmaeOyGo0/APiLEat5wE
	93QmverMDyHbqXfhIZjIZmTZul4SyBvaVQ==
X-Google-Smtp-Source: AGHT+IEBR+HhQSfthMjm1WvsedRsJ5TFDPWx5K9ERRhe/PSNdIZWUl1x107UxcMU0/s9LLEJU2U/iQmmM15nuw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2584:0:b0:d9a:ca58:b32c with SMTP id
 l126-20020a252584000000b00d9aca58b32cmr36064ybl.1.1697806683876; Fri, 20 Oct
 2023 05:58:03 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:43 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-9-edumazet@google.com>
Subject: [PATCH net-next 08/13] tcp: rename tcp_time_stamp() to tcp_time_stamp_ts()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This helper returns a TSval from a TCP socket.

It currently calls tcp_time_stamp_ms() but will soon
be able to return a usec based TSval, depending
on an upcoming tp->tcp_usec_ts field.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  9 ++++-----
 net/ipv4/tcp_input.c  |  6 +++---
 net/ipv4/tcp_lp.c     |  2 +-
 net/ipv4/tcp_output.c |  2 +-
 net/ipv4/tcp_timer.c  | 10 +++++-----
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index b86abf1fbe46061a00dbd202323792f01a307969..af72c1dc37f3dd4cd6858e9c8f6aa7ef31541652 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -813,15 +813,14 @@ static inline u32 tcp_clock_ts(bool usec_ts)
 	return usec_ts ? tcp_clock_us() : tcp_clock_ms();
 }
 
-/* This should only be used in contexts where tp->tcp_mstamp is up to date */
-static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
+static inline u32 tcp_time_stamp_ms(const struct tcp_sock *tp)
 {
-	return div_u64(tp->tcp_mstamp, USEC_PER_SEC / TCP_TS_HZ);
+	return div_u64(tp->tcp_mstamp, USEC_PER_MSEC);
 }
 
-static inline u32 tcp_time_stamp_ms(const struct tcp_sock *tp)
+static inline u32 tcp_time_stamp_ts(const struct tcp_sock *tp)
 {
-	return div_u64(tp->tcp_mstamp, USEC_PER_MSEC);
+	return tcp_time_stamp_ms(tp);
 }
 
 void tcp_mstamp_refresh(struct tcp_sock *tp);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index de68cad82d19e37171deadc45c5acc0cfd90c315..e7e38fc1d62ff16d7afd7f2ba58a1990f01e17b6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -704,7 +704,7 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 
 	if (TCP_SKB_CB(skb)->end_seq -
 	    TCP_SKB_CB(skb)->seq >= inet_csk(sk)->icsk_ack.rcv_mss) {
-		u32 delta = tcp_time_stamp(tp) - tp->rx_opt.rcv_tsecr;
+		u32 delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
 		u32 delta_us;
 
 		if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
@@ -3148,7 +3148,7 @@ static bool tcp_ack_update_rtt(struct sock *sk, const int flag,
 	 */
 	if (seq_rtt_us < 0 && tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
 	    flag & FLAG_ACKED) {
-		u32 delta = tcp_time_stamp(tp) - tp->rx_opt.rcv_tsecr;
+		u32 delta = tcp_time_stamp_ts(tp) - tp->rx_opt.rcv_tsecr;
 
 		if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
 			if (!delta)
@@ -6293,7 +6293,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 		if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr &&
 		    !between(tp->rx_opt.rcv_tsecr, tp->retrans_stamp,
-			     tcp_time_stamp(tp))) {
+			     tcp_time_stamp_ts(tp))) {
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_PAWSACTIVEREJECTED);
 			goto reset_and_undo;
diff --git a/net/ipv4/tcp_lp.c b/net/ipv4/tcp_lp.c
index ae36780977d2762066cdd59e40116d1240492b90..52fe17167460fc433ec84434795f7cbef8144767 100644
--- a/net/ipv4/tcp_lp.c
+++ b/net/ipv4/tcp_lp.c
@@ -272,7 +272,7 @@ static void tcp_lp_pkts_acked(struct sock *sk, const struct ack_sample *sample)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct lp *lp = inet_csk_ca(sk);
-	u32 now = tcp_time_stamp(tp);
+	u32 now = tcp_time_stamp_ts(tp);
 	u32 delta;
 
 	if (sample->rtt_us > 0)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 03a2a9fc0dc191d7066d679913d41bd2ef2d685a..a1fec8be9ac36c67022c90b08b0a5faa935725f0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3961,7 +3961,7 @@ int tcp_connect(struct sock *sk)
 
 	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
-	tp->retrans_stamp = tcp_time_stamp(tp);
+	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
 	tcp_ecn_send_syn(sk, buff);
 	tcp_rbtree_insert(&sk->tcp_rtx_queue, buff);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 8764a9a2dc213f648ffc64f79950037b1f44ee99..bfcf3fe44c72427eccb37376bec15fb71b594c56 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -33,7 +33,7 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	if (!user_timeout)
 		return icsk->icsk_rto;
-	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
+	elapsed = tcp_time_stamp_ts(tcp_sk(sk)) - start_ts;
 	remaining = user_timeout - elapsed;
 	if (remaining <= 0)
 		return 1; /* user timeout has passed; fire ASAP */
@@ -226,7 +226,7 @@ static bool retransmits_timed_out(struct sock *sk,
 		timeout = tcp_model_timeout(sk, boundary, rto_base);
 	}
 
-	return (s32)(tcp_time_stamp(tcp_sk(sk)) - start_ts - timeout) >= 0;
+	return (s32)(tcp_time_stamp_ts(tcp_sk(sk)) - start_ts - timeout) >= 0;
 }
 
 /* A write timeout has occurred. Process the after effects. */
@@ -462,7 +462,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	req->num_timeout++;
 	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
-		tp->retrans_stamp = tcp_time_stamp(tp);
+		tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
 			  req->timeout << req->num_timeout, TCP_RTO_MAX);
 }
@@ -478,7 +478,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 	if (rcv_delta <= timeout)
 		return false;
 
-	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
+	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp_ts(tp) -
 			(tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb)));
 
 	return rtx_delta > timeout;
@@ -534,7 +534,7 @@ void tcp_retransmit_timer(struct sock *sk)
 		struct inet_sock *inet = inet_sk(sk);
 		u32 rtx_delta;
 
-		rtx_delta = tcp_time_stamp(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb));
+		rtx_delta = tcp_time_stamp_ts(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb));
 		if (sk->sk_family == AF_INET) {
 			net_dbg_ratelimited("Probing zero-window on %pI4:%u/%u, seq=%u:%u, recv %ums ago, lasting %ums\n",
 				&inet->inet_daddr, ntohs(inet->inet_dport),
-- 
2.42.0.655.g421f12c284-goog


