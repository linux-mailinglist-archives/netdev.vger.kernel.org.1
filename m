Return-Path: <netdev+bounces-35605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29907A9FF2
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C8E2816EA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B74918C1E;
	Thu, 21 Sep 2023 20:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D218C17
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:15 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D017714803
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-597f461adc5so20640987b3.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328108; x=1695932908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=INsYlipqFiVc5s+MCiX08R2IwXopMJsxSAfewICLmTw=;
        b=sFb3DhQkYlJH2KwdzhP8HWKbV2Ko/4ZiyyrYZpx1lNOxCz4/iwmT4AlXs7XR/xehyB
         jcBfDEPctvrhjQH6WVCKs47eqvScyppOiPim14jeRc0ZC8bbWY+Aln2/JeA6NXqHtC6H
         uy78fiwq0MFh2nfRJdb42uTzLaCE/4PJvMIFZaQs7Tj6F93c1BVJOGEQubnpnIilh9Aq
         RnhFG4nIhpRCS767G/MAdEyIZwOKMSI88eZl2vxz0oanMdZr6necHAO0MGfFlJuXNekq
         zPOQM8VvkGCzRlw+Yo7KDVoi/eQlETRKe7RS4nHi07cUuuaiFPzp7h5YW0aCuUIvbbSM
         Oj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328108; x=1695932908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INsYlipqFiVc5s+MCiX08R2IwXopMJsxSAfewICLmTw=;
        b=R1OLdxX5Zx/4m/iwniWK0Z/KZ+j5pptedIO8Ef6al0Np1QT1agN646gcXQ2dQjbtJ+
         jsdiHGP6z4/mBqQRzFlwzyWrMCayx7CIGLkQksdVLNC7OPGx01I092TCppKrCRyjrHkm
         g64rSM9Y/iDyliPe4xmDbJwNHVHxsdEzQmVTA9LK6du1zGFC/6xBbxqZew/zC4466bhA
         PDfqs0RTs0A6vwVjoi8QQpJWLHzX24rbFTkpAbIzKiGAq1Ro5cGk7cQ27upXmvw8I4gZ
         xdGRZtMzPTY+m1DFEh1vl1eCzbxiirOZimuaQow7fqRa5L/zkHO3atV0/m+HYbpBJRhm
         rQOQ==
X-Gm-Message-State: AOJu0Yx6Q2JJv0mkcTZwCrtuynYPEovsn9ajd4VD+AabIPMVj8Pcqb8/
	G4aOw5Rbm0+/0T3Ly7hZtiYi7hNGCobarQ==
X-Google-Smtp-Source: AGHT+IGoDdvQ6jc5QaywiuCl4A4dtkXP7sixf6rzqZbD5Ghs08uQ7C5lIT+dcgqsIuBw+kBmhEJirzqC9+L3HQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1604:b0:d81:908f:6f99 with SMTP
 id bw4-20020a056902160400b00d81908f6f99mr98594ybb.5.1695328108159; Thu, 21
 Sep 2023 13:28:28 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:15 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] net: implement lockless SO_MAX_PACING_RATE
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SO_MAX_PACING_RATE setsockopt() does not need to hold
the socket lock, because sk->sk_pacing_rate readers
can run fine if the value is changed by other threads,
after adding READ_ONCE() accessors.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/trace/events/mptcp.h |  2 +-
 net/core/sock.c              | 40 +++++++++++++++++++-----------------
 net/ipv4/tcp_bbr.c           | 13 ++++++------
 net/ipv4/tcp_input.c         |  4 ++--
 net/ipv4/tcp_output.c        |  9 ++++----
 net/sched/sch_fq.c           |  2 +-
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 563e48617374d3f68dd86b78c13fe6bc28bf6947..09e72215b9f9bb53ec363d7690e9b87a09d172cb 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -44,7 +44,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (ssk && sk_fullsock(ssk)) {
 			__entry->snd_wnd = tcp_sk(ssk)->snd_wnd;
-			__entry->pace = ssk->sk_pacing_rate;
+			__entry->pace = READ_ONCE(ssk->sk_pacing_rate);
 		} else {
 			__entry->snd_wnd = 0;
 			__entry->pace = 0;
diff --git a/net/core/sock.c b/net/core/sock.c
index 408081549bd777811058d5de3e9df0f459e6e999..4254ed0e4817d60cb2bf9d8e62ffcd98a90f7ec6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1160,6 +1160,27 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		WRITE_ONCE(sk->sk_busy_poll_budget, val);
 		return 0;
 #endif
+	case SO_MAX_PACING_RATE:
+		{
+		unsigned long ulval = (val == ~0U) ? ~0UL : (unsigned int)val;
+		unsigned long pacing_rate;
+
+		if (sizeof(ulval) != sizeof(val) &&
+		    optlen >= sizeof(ulval) &&
+		    copy_from_sockptr(&ulval, optval, sizeof(ulval))) {
+			return -EFAULT;
+		}
+		if (ulval != ~0UL)
+			cmpxchg(&sk->sk_pacing_status,
+				SK_PACING_NONE,
+				SK_PACING_NEEDED);
+		/* Pairs with READ_ONCE() from sk_getsockopt() */
+		WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
+		pacing_rate = READ_ONCE(sk->sk_pacing_rate);
+		if (ulval < pacing_rate)
+			WRITE_ONCE(sk->sk_pacing_rate, ulval);
+		return 0;
+		}
 	}
 
 	sockopt_lock_sock(sk);
@@ -1423,25 +1444,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 
-	case SO_MAX_PACING_RATE:
-		{
-		unsigned long ulval = (val == ~0U) ? ~0UL : (unsigned int)val;
-
-		if (sizeof(ulval) != sizeof(val) &&
-		    optlen >= sizeof(ulval) &&
-		    copy_from_sockptr(&ulval, optval, sizeof(ulval))) {
-			ret = -EFAULT;
-			break;
-		}
-		if (ulval != ~0UL)
-			cmpxchg(&sk->sk_pacing_status,
-				SK_PACING_NONE,
-				SK_PACING_NEEDED);
-		/* Pairs with READ_ONCE() from sk_getsockopt() */
-		WRITE_ONCE(sk->sk_max_pacing_rate, ulval);
-		sk->sk_pacing_rate = min(sk->sk_pacing_rate, ulval);
-		break;
-		}
 	case SO_INCOMING_CPU:
 		reuseport_update_incoming_cpu(sk, val);
 		break;
diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 146792cd26fed4e61cd72a5d85263b2c7c7b2636..22358032dd484b081d30686fbd03b01fbb9c4214 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -258,7 +258,7 @@ static unsigned long bbr_bw_to_pacing_rate(struct sock *sk, u32 bw, int gain)
 	u64 rate = bw;
 
 	rate = bbr_rate_bytes_per_sec(sk, rate, gain);
-	rate = min_t(u64, rate, sk->sk_max_pacing_rate);
+	rate = min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate));
 	return rate;
 }
 
@@ -278,7 +278,8 @@ static void bbr_init_pacing_rate_from_rtt(struct sock *sk)
 	}
 	bw = (u64)tcp_snd_cwnd(tp) * BW_UNIT;
 	do_div(bw, rtt_us);
-	sk->sk_pacing_rate = bbr_bw_to_pacing_rate(sk, bw, bbr_high_gain);
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   bbr_bw_to_pacing_rate(sk, bw, bbr_high_gain));
 }
 
 /* Pace using current bw estimate and a gain factor. */
@@ -290,14 +291,14 @@ static void bbr_set_pacing_rate(struct sock *sk, u32 bw, int gain)
 
 	if (unlikely(!bbr->has_seen_rtt && tp->srtt_us))
 		bbr_init_pacing_rate_from_rtt(sk);
-	if (bbr_full_bw_reached(sk) || rate > sk->sk_pacing_rate)
-		sk->sk_pacing_rate = rate;
+	if (bbr_full_bw_reached(sk) || rate > READ_ONCE(sk->sk_pacing_rate))
+		WRITE_ONCE(sk->sk_pacing_rate, rate);
 }
 
 /* override sysctl_tcp_min_tso_segs */
 __bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
 {
-	return sk->sk_pacing_rate < (bbr_min_tso_rate >> 3) ? 1 : 2;
+	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
 }
 
 static u32 bbr_tso_segs_goal(struct sock *sk)
@@ -309,7 +310,7 @@ static u32 bbr_tso_segs_goal(struct sock *sk)
 	 * driver provided sk_gso_max_size.
 	 */
 	bytes = min_t(unsigned long,
-		      sk->sk_pacing_rate >> READ_ONCE(sk->sk_pacing_shift),
+		      READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift),
 		      GSO_LEGACY_MAX_SIZE - 1 - MAX_TCP_HEADER);
 	segs = max_t(u32, bytes / tp->mss_cache, bbr_min_tso_segs(sk));
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 584825ddd0a09a2037aea7869b137c3ac64a1534..22c2a7c2e65ee749a61b5dc74459e0c7db9f4628 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -927,8 +927,8 @@ static void tcp_update_pacing_rate(struct sock *sk)
 	 * without any lock. We want to make sure compiler wont store
 	 * intermediate values in this location.
 	 */
-	WRITE_ONCE(sk->sk_pacing_rate, min_t(u64, rate,
-					     sk->sk_max_pacing_rate));
+	WRITE_ONCE(sk->sk_pacing_rate,
+		   min_t(u64, rate, READ_ONCE(sk->sk_max_pacing_rate)));
 }
 
 /* Calculate rto without backoff.  This is the second half of Van Jacobson's
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc..696dfd64c8c5ffaef43f0f33c9402df2f673dcd3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1201,7 +1201,7 @@ static void tcp_update_skb_after_send(struct sock *sk, struct sk_buff *skb,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (sk->sk_pacing_status != SK_PACING_NONE) {
-		unsigned long rate = sk->sk_pacing_rate;
+		unsigned long rate = READ_ONCE(sk->sk_pacing_rate);
 
 		/* Original sch_fq does not pace first 10 MSS
 		 * Note that tp->data_segs_out overflows after 2^32 packets,
@@ -1973,7 +1973,7 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 	unsigned long bytes;
 	u32 r;
 
-	bytes = sk->sk_pacing_rate >> READ_ONCE(sk->sk_pacing_shift);
+	bytes = READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift);
 
 	r = tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);
 	if (r < BITS_PER_TYPE(sk->sk_gso_max_size))
@@ -2553,7 +2553,7 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 
 	limit = max_t(unsigned long,
 		      2 * skb->truesize,
-		      sk->sk_pacing_rate >> READ_ONCE(sk->sk_pacing_shift));
+		      READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_shift));
 	if (sk->sk_pacing_status == SK_PACING_NONE)
 		limit = min_t(unsigned long, limit,
 			      READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_limit_output_bytes));
@@ -2561,7 +2561,8 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 
 	if (static_branch_unlikely(&tcp_tx_delay_enabled) &&
 	    tcp_sk(sk)->tcp_tx_delay) {
-		u64 extra_bytes = (u64)sk->sk_pacing_rate * tcp_sk(sk)->tcp_tx_delay;
+		u64 extra_bytes = (u64)READ_ONCE(sk->sk_pacing_rate) *
+				  tcp_sk(sk)->tcp_tx_delay;
 
 		/* TSQ is based on skb truesize sum (sk_wmem_alloc), so we
 		 * approximate our needs assuming an ~100% skb->truesize overhead.
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f59a2cb2c803d79bd1f0eb1806464a0220824f9e..1a616bdeaf9ba8ba6413aaae8e6c642174a7196a 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -607,7 +607,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	 */
 	if (!skb->tstamp) {
 		if (skb->sk)
-			rate = min(skb->sk->sk_pacing_rate, rate);
+			rate = min(READ_ONCE(skb->sk->sk_pacing_rate), rate);
 
 		if (rate <= q->low_rate_threshold) {
 			f->credit = 0;
-- 
2.42.0.515.g380fc7ccd1-goog


