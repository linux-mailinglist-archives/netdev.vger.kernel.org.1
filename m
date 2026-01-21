Return-Path: <netdev+bounces-251838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKTmA3OqcGnwYwAAu9opvQ
	(envelope-from <netdev+bounces-251838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:29:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F55534E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 165856ABB8B
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE748164E;
	Wed, 21 Jan 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQ8c8DoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC1359F9F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989569; cv=none; b=qnvvucEbozO42WBdIyzewFyBM/4gWmNTUxgFmOz3OZuVWZPeIyUUK5udYu90+bVgya9tqyT/lchs+YvTAis0Ohy0ySEx5ESPrbEp8tZcUnSr2IRXJ0a3OJBBfUFynh/uphIq8kWsMYfE3u+tIAH1i+eTsHO6z+pVRChyHyp/a68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989569; c=relaxed/simple;
	bh=zbTe524g9zYTSGRKDiccVX/qi/QUmxMlZQKS1fVvyLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POTVto9w2af9ksyXrKDbSRXnych82Qfoa5OuKbQ0mGv6uXIjOdQgSIFqSZHs7jfAsp2UhJE4wwI9GZn1EyLXE3Vbjk9D9f9gti/fG2iGJnR2rFqYAMmuRXIsa7iNJVLxi+njgcbJ0X+/hice0l0riQZvKfs+S9pBueMo1+0QU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQ8c8DoD; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c6a5bc8c43so1427143785a.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768989566; x=1769594366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPeOzg3dujJ0PBOaH+S7icmQSdjGpBndSYk5HBjNLf0=;
        b=mQ8c8DoDGPvjpt/fzVy/ygQJ/8qc/vCHu+gjrIxlG2fTFUIkS9jsshjNcSXGPnXhA8
         SurnTGejlDjORj5Tmq7vMjGvNEO0dfHB8SRJzkfxAlLiRJruvYRDGqnsHUJC1dYJ8Rdf
         JKfwa8mCGCGGrhkExPzgUSzMPUu2wmevCfWo8WLUUB09XklliELfsWlmb4Wfa2wTlJei
         k219by6H2aFC77QDmh/AdBO+InVJSD8SSiWyDG0vK5mN1cVuerBlJ4BVC3jyhWNmgUGS
         IzHangOzbtzXLEun12lITLvMUndriOkeazFvWfpkK+9hQrfGsfkRshIYvj4CMAzSBv5v
         nboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989566; x=1769594366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPeOzg3dujJ0PBOaH+S7icmQSdjGpBndSYk5HBjNLf0=;
        b=jP+3gjBkz+1ROpBQ8ECtqqWTDmm2ScP6x1CSm3ZYkN+j0/5ykvGzWfbkb8W/i6eUk1
         9MGkR+42vsjgwOUXFXfKAo/vJNpAIDbBDc81gscC6sB9FSEfyGqMkAubxGftAkPL3U+c
         bPCRwOCT37aK4tmlQWp3YPnuJCnjMrc/4auxVno3yrm+Y72zW3MvhUOHGFnKpzx8nyYN
         Zb8T6Vuvl03zVZnn7D46SlZNjm/byPNcJSy1bNZ8xsY4J25hshQ6bMQzqsBmPcirK4ba
         L2Jizp6Ybr5f8H3/ysoY6j67yALQ8ORcIaWXRh2UcuW8cjNIOEa4hFkJmvFLoMACQaxc
         lV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXuyztkNukCPEvm7cqbbvNCVFN0aV/6VRKt2V7jAD+FpotK+VkYzwvW3zVk7ANXdeAdG4PgzOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRO+teTwuWB5ipDVbzoN0742qbqGP6PkDQF3400LyvZarEY2E7
	qP5bysWeM1qiGmCqEJoEiPA0OeW8SrC1rsYEOpRS7iufTDH0cxa3xSG8kxn4zPvtve5lVgQBSeq
	TXHOJZCb+vLZYFw==
X-Received: from qkka14.prod.google.com ([2002:a05:620a:102e:b0:8c1:9c5c:a6a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a0b:b0:8b2:989b:efe6 with SMTP id af79cd13be357-8c6a66f68afmr2360686285a.26.1768989566626;
 Wed, 21 Jan 2026 01:59:26 -0800 (PST)
Date: Wed, 21 Jan 2026 09:59:22 +0000
In-Reply-To: <20260121095923.3134639-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121095923.3134639-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121095923.3134639-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: move tcp_rate_gen to tcp_input.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251838-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 809F55534E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This function is called from one caller only, in TCP fast path.

Move it to tcp_input.c so that compiler can inline it.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 226/-300 (-74)
Function                                     old     new   delta
tcp_ack                                     5405    5631    +226
__pfx_tcp_rate_gen                            16       -     -16
tcp_rate_gen                                 284       -    -284
Total: Before=22566536, After=22566462, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |   2 -
 net/ipv4/tcp_input.c | 110 +++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_rate.c  | 110 -------------------------------------------
 3 files changed, 110 insertions(+), 112 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 25143f156957288f5b8674d4d27b805e92c592c8..d6a77b59dddeb065d3a2df12543878ccc4704a3f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1356,8 +1356,6 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
 
 /* From tcp_rate.c */
-void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
-		  bool is_sack_reneg, struct rate_sample *rs);
 void tcp_rate_check_app_limited(struct sock *sk);
 
 static inline bool tcp_skb_sent_after(u64 t1, u64 t2, u32 seq1, u32 seq2)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dc8e256321b03da0ef97b4512d2cb5f202501dfa..9e91ddbc6253ae4615e0b03ebf53d7da09c46940 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1637,6 +1637,116 @@ static u8 tcp_sacktag_one(struct sock *sk,
 	return sacked;
 }
 
+/* The bandwidth estimator estimates the rate at which the network
+ * can currently deliver outbound data packets for this flow. At a high
+ * level, it operates by taking a delivery rate sample for each ACK.
+ *
+ * A rate sample records the rate at which the network delivered packets
+ * for this flow, calculated over the time interval between the transmission
+ * of a data packet and the acknowledgment of that packet.
+ *
+ * Specifically, over the interval between each transmit and corresponding ACK,
+ * the estimator generates a delivery rate sample. Typically it uses the rate
+ * at which packets were acknowledged. However, the approach of using only the
+ * acknowledgment rate faces a challenge under the prevalent ACK decimation or
+ * compression: packets can temporarily appear to be delivered much quicker
+ * than the bottleneck rate. Since it is physically impossible to do that in a
+ * sustained fashion, when the estimator notices that the ACK rate is faster
+ * than the transmit rate, it uses the latter:
+ *
+ *    send_rate = #pkts_delivered/(last_snd_time - first_snd_time)
+ *    ack_rate  = #pkts_delivered/(last_ack_time - first_ack_time)
+ *    bw = min(send_rate, ack_rate)
+ *
+ * Notice the estimator essentially estimates the goodput, not always the
+ * network bottleneck link rate when the sending or receiving is limited by
+ * other factors like applications or receiver window limits.  The estimator
+ * deliberately avoids using the inter-packet spacing approach because that
+ * approach requires a large number of samples and sophisticated filtering.
+ *
+ * TCP flows can often be application-limited in request/response workloads.
+ * The estimator marks a bandwidth sample as application-limited if there
+ * was some moment during the sampled window of packets when there was no data
+ * ready to send in the write queue.
+ */
+
+/* Update the connection delivery information and generate a rate sample. */
+static void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
+			 bool is_sack_reneg, struct rate_sample *rs)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 snd_us, ack_us;
+
+	/* Clear app limited if bubble is acked and gone. */
+	if (tp->app_limited && after(tp->delivered, tp->app_limited))
+		tp->app_limited = 0;
+
+	/* TODO: there are multiple places throughout tcp_ack() to get
+	 * current time. Refactor the code using a new "tcp_acktag_state"
+	 * to carry current time, flags, stats like "tcp_sacktag_state".
+	 */
+	if (delivered)
+		tp->delivered_mstamp = tp->tcp_mstamp;
+
+	rs->acked_sacked = delivered;	/* freshly ACKed or SACKed */
+	rs->losses = lost;		/* freshly marked lost */
+	/* Return an invalid sample if no timing information is available or
+	 * in recovery from loss with SACK reneging. Rate samples taken during
+	 * a SACK reneging event may overestimate bw by including packets that
+	 * were SACKed before the reneg.
+	 */
+	if (!rs->prior_mstamp || is_sack_reneg) {
+		rs->delivered = -1;
+		rs->interval_us = -1;
+		return;
+	}
+	rs->delivered   = tp->delivered - rs->prior_delivered;
+
+	rs->delivered_ce = tp->delivered_ce - rs->prior_delivered_ce;
+	/* delivered_ce occupies less than 32 bits in the skb control block */
+	rs->delivered_ce &= TCPCB_DELIVERED_CE_MASK;
+
+	/* Model sending data and receiving ACKs as separate pipeline phases
+	 * for a window. Usually the ACK phase is longer, but with ACK
+	 * compression the send phase can be longer. To be safe we use the
+	 * longer phase.
+	 */
+	snd_us = rs->interval_us;				/* send phase */
+	ack_us = tcp_stamp_us_delta(tp->tcp_mstamp,
+				    rs->prior_mstamp); /* ack phase */
+	rs->interval_us = max(snd_us, ack_us);
+
+	/* Record both segment send and ack receive intervals */
+	rs->snd_interval_us = snd_us;
+	rs->rcv_interval_us = ack_us;
+
+	/* Normally we expect interval_us >= min-rtt.
+	 * Note that rate may still be over-estimated when a spuriously
+	 * retransmistted skb was first (s)acked because "interval_us"
+	 * is under-estimated (up to an RTT). However continuously
+	 * measuring the delivery rate during loss recovery is crucial
+	 * for connections suffer heavy or prolonged losses.
+	 */
+	if (unlikely(rs->interval_us < tcp_min_rtt(tp))) {
+		if (!rs->is_retrans)
+			pr_debug("tcp rate: %ld %d %u %u %u\n",
+				 rs->interval_us, rs->delivered,
+				 inet_csk(sk)->icsk_ca_state,
+				 tp->rx_opt.sack_ok, tcp_min_rtt(tp));
+		rs->interval_us = -1;
+		return;
+	}
+
+	/* Record the last non-app-limited or the highest app-limited bw */
+	if (!rs->is_app_limited ||
+	    ((u64)rs->delivered * tp->rate_interval_us >=
+	     (u64)tp->rate_delivered * rs->interval_us)) {
+		tp->rate_delivered = rs->delivered;
+		tp->rate_interval_us = rs->interval_us;
+		tp->rate_app_limited = rs->is_app_limited;
+	}
+}
+
 /* When an skb is sacked or acked, we fill in the rate sample with the (prior)
  * delivery information when the skb was last transmitted.
  *
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
index f0f2ef377043d797eb0270be1f54e65b21673f02..272806ba3b4e451362af1a9ede01f7ad378865cb 100644
--- a/net/ipv4/tcp_rate.c
+++ b/net/ipv4/tcp_rate.c
@@ -1,116 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <net/tcp.h>
 
-/* The bandwidth estimator estimates the rate at which the network
- * can currently deliver outbound data packets for this flow. At a high
- * level, it operates by taking a delivery rate sample for each ACK.
- *
- * A rate sample records the rate at which the network delivered packets
- * for this flow, calculated over the time interval between the transmission
- * of a data packet and the acknowledgment of that packet.
- *
- * Specifically, over the interval between each transmit and corresponding ACK,
- * the estimator generates a delivery rate sample. Typically it uses the rate
- * at which packets were acknowledged. However, the approach of using only the
- * acknowledgment rate faces a challenge under the prevalent ACK decimation or
- * compression: packets can temporarily appear to be delivered much quicker
- * than the bottleneck rate. Since it is physically impossible to do that in a
- * sustained fashion, when the estimator notices that the ACK rate is faster
- * than the transmit rate, it uses the latter:
- *
- *    send_rate = #pkts_delivered/(last_snd_time - first_snd_time)
- *    ack_rate  = #pkts_delivered/(last_ack_time - first_ack_time)
- *    bw = min(send_rate, ack_rate)
- *
- * Notice the estimator essentially estimates the goodput, not always the
- * network bottleneck link rate when the sending or receiving is limited by
- * other factors like applications or receiver window limits.  The estimator
- * deliberately avoids using the inter-packet spacing approach because that
- * approach requires a large number of samples and sophisticated filtering.
- *
- * TCP flows can often be application-limited in request/response workloads.
- * The estimator marks a bandwidth sample as application-limited if there
- * was some moment during the sampled window of packets when there was no data
- * ready to send in the write queue.
- */
-
-/* Update the connection delivery information and generate a rate sample. */
-void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
-		  bool is_sack_reneg, struct rate_sample *rs)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-	u32 snd_us, ack_us;
-
-	/* Clear app limited if bubble is acked and gone. */
-	if (tp->app_limited && after(tp->delivered, tp->app_limited))
-		tp->app_limited = 0;
-
-	/* TODO: there are multiple places throughout tcp_ack() to get
-	 * current time. Refactor the code using a new "tcp_acktag_state"
-	 * to carry current time, flags, stats like "tcp_sacktag_state".
-	 */
-	if (delivered)
-		tp->delivered_mstamp = tp->tcp_mstamp;
-
-	rs->acked_sacked = delivered;	/* freshly ACKed or SACKed */
-	rs->losses = lost;		/* freshly marked lost */
-	/* Return an invalid sample if no timing information is available or
-	 * in recovery from loss with SACK reneging. Rate samples taken during
-	 * a SACK reneging event may overestimate bw by including packets that
-	 * were SACKed before the reneg.
-	 */
-	if (!rs->prior_mstamp || is_sack_reneg) {
-		rs->delivered = -1;
-		rs->interval_us = -1;
-		return;
-	}
-	rs->delivered   = tp->delivered - rs->prior_delivered;
-
-	rs->delivered_ce = tp->delivered_ce - rs->prior_delivered_ce;
-	/* delivered_ce occupies less than 32 bits in the skb control block */
-	rs->delivered_ce &= TCPCB_DELIVERED_CE_MASK;
-
-	/* Model sending data and receiving ACKs as separate pipeline phases
-	 * for a window. Usually the ACK phase is longer, but with ACK
-	 * compression the send phase can be longer. To be safe we use the
-	 * longer phase.
-	 */
-	snd_us = rs->interval_us;				/* send phase */
-	ack_us = tcp_stamp_us_delta(tp->tcp_mstamp,
-				    rs->prior_mstamp); /* ack phase */
-	rs->interval_us = max(snd_us, ack_us);
-
-	/* Record both segment send and ack receive intervals */
-	rs->snd_interval_us = snd_us;
-	rs->rcv_interval_us = ack_us;
-
-	/* Normally we expect interval_us >= min-rtt.
-	 * Note that rate may still be over-estimated when a spuriously
-	 * retransmistted skb was first (s)acked because "interval_us"
-	 * is under-estimated (up to an RTT). However continuously
-	 * measuring the delivery rate during loss recovery is crucial
-	 * for connections suffer heavy or prolonged losses.
-	 */
-	if (unlikely(rs->interval_us < tcp_min_rtt(tp))) {
-		if (!rs->is_retrans)
-			pr_debug("tcp rate: %ld %d %u %u %u\n",
-				 rs->interval_us, rs->delivered,
-				 inet_csk(sk)->icsk_ca_state,
-				 tp->rx_opt.sack_ok, tcp_min_rtt(tp));
-		rs->interval_us = -1;
-		return;
-	}
-
-	/* Record the last non-app-limited or the highest app-limited bw */
-	if (!rs->is_app_limited ||
-	    ((u64)rs->delivered * tp->rate_interval_us >=
-	     (u64)tp->rate_delivered * rs->interval_us)) {
-		tp->rate_delivered = rs->delivered;
-		tp->rate_interval_us = rs->interval_us;
-		tp->rate_app_limited = rs->is_app_limited;
-	}
-}
-
 /* If a gap is detected between sends, mark the socket application-limited. */
 void tcp_rate_check_app_limited(struct sock *sk)
 {
-- 
2.52.0.457.g6b5491de43-goog


