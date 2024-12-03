Return-Path: <netdev+bounces-148688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C579E2DD6
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C56165A7B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F521FF7CF;
	Tue,  3 Dec 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqK5uH+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E01FCFD9
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260174; cv=none; b=ZcAShfgsnK3do8/8qiljrAkew608rX7hd8yO1+mpah1LR2Jd95n860Oqu+Jz2sShvkhu9siKkjSVtsI8QKjAb64K0hNqyQeoJeQ6woEUa2WU08gq0P7CHTfxKjDBpEwR1o6vhDAHFh+924QHS8Fcmo6Q+z1zciv/l/o1ZBwn0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260174; c=relaxed/simple;
	bh=1Ds94AcozE3f38sb7CuSCG0LhT+JPwIueYtUg9QOCIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uyzIQaInLsSO1rrGsUYj+CxFNcYwhInPPlODdEZas+90zf75vFouhDSoRSbA1CDVu4XbcBKSNMWMNAckTjyT3yo6Qd6BMGVk41Qgb1jdYe5v27QVxKNJit30uYipv4P0Mm6WP8zU4IbQgCM9Gpb5V2fl1rDtuK3SRKVX4o5sNYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqK5uH+s; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b35758d690so1014589885a.1
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 13:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733260172; x=1733864972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e/HP5PLaNL9jCvhmPN1UQGOlAGoXFCU75pUewFa+Stg=;
        b=CqK5uH+sC6kZHNPcM3TglJ0n4mqGR7ch0Pdjq9pEGDhoiCb0rxrkuTcj6uSkqkOAPj
         XjAMBda+hOOpzTBkkzFhGkI0C0FtpbyLYtAjDcy8EcVkJIKH7ia1no2POiqjEi40U7Ia
         5UMYx9pk5Np3KzEYBtXYkjyZsnz7XzRoRXKoujSp21IKw+sXKHveCSGRyUYm7XKd822Z
         Bf4hl4608KMROrXpJKrKvYB0Wghtaa3GGWXDIVtm82Xrnib0oFeM2+3CXCcy3y37EKtP
         GPwgHjLuFDe7Db7LPHYe3FFUKTlLBT7MNoYrPVpi0jNMNArqPlWUo38H7FZWKNOYJgUq
         K0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260172; x=1733864972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/HP5PLaNL9jCvhmPN1UQGOlAGoXFCU75pUewFa+Stg=;
        b=OcYIkremcpPb1232xAdWUB7XbTDrbRFRTxQbAvWFb2u+A3+COj8SEUCroFend3rgzo
         P+omyIQ9SKdEZK7SW4k1e+VHyDmxuVtdGVuASeDHSmV0ovWIngvzGTLOV55I44X0bxdN
         f8xU+UWK3Qyl/rfWUyabGFRACyXR/9gWD8yXoGwsrRBnnIX61rht77JAkFiHoL1k6SWx
         Gogv/QWCglWswXCDY5cJMIOqmalZ0+SBNsRkYKQYjkLO49TJe1+JBHhybBmrZmXFInf0
         A9H2sJo+T0IhBYPQhV3ojjaOa1x2W4UtLaqY/Z1jamolaOq00a9EqEJClf11MwMzfefS
         jjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJnn5dEg6oWj3DffcixLMVqndZlPXGD4beFg0R67p0stvOKr2UR9UIOYQ6+5xCgCAWaMhiq7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxX5hQhXNjJ6vO85LXnA2ImFJGarObFX+xVGECiBdXmGw4fxJA
	K8loL3CS3CUFFne+QT3yn41QppQONY8El0wuysa0pc/hNd1WMVHkjVwUSsOdlYvfyWLgOgbr7Tk
	UCAur/WQkzw==
X-Google-Smtp-Source: AGHT+IG+yXPlZmZBuzv1BqOOMVtfHl+6kerX4SE5OK9wsg5inqpVntbkEIN+3pKPCGCxtL6OskW0IUyVFNfBlA==
X-Received: from qkbbp18.prod.google.com ([2002:a05:620a:4592:b0:7b1:6421:b302])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1996:b0:7b1:1d91:5cf1 with SMTP id af79cd13be357-7b6ababfdfbmr269869385a.1.1733260172055;
 Tue, 03 Dec 2024 13:09:32 -0800 (PST)
Date: Tue,  3 Dec 2024 21:09:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203210929.3281461-1-edumazet@google.com>
Subject: [PATCH net-next] net_sched: sch_fq: add three drop_reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add three new drop_reason, more precise than generic QDISC_DROP:

"tc -s qd" show aggregate counters, it might be more useful
to use drop_reason infrastructure for bug hunting.

1) SKB_DROP_REASON_FQ_DROP_BAND_LIMIT
   Whenever a packet is added while its band limit is hit.
   Corresponding value in "tc -s qd" is bandX_drops XXXX

2) SKB_DROP_REASON_FQ_DROP_HORIZON_LIMIT
   Whenever a packet has a timestamp too far in the future.
   Corresponding value in "tc -s qd" is horizon_drops XXXX

3) SKB_DROP_REASON_FQ_DROP_FLOW_LIMIT
   Whenever a flow has reached its limit.
   Corresponding value in "tc -s qd" is flows_plimit XXXX

Tested:
tc qd replace dev eth0 root fq flow_limit 10 limit 100000
perf record -a -e skb:kfree_skb sleep 1; perf script

      udp_stream   12329 [004]   216.929492: skb:kfree_skb: skbaddr=0xffff888eabe17e00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_FLOW_LIMIT
      udp_stream   12385 [006]   216.929593: skb:kfree_skb: skbaddr=0xffff888ef8827f00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_FLOW_LIMIT
      udp_stream   12389 [005]   216.929871: skb:kfree_skb: skbaddr=0xffff888ecb9ba500 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_FLOW_LIMIT
      udp_stream   12316 [009]   216.930398: skb:kfree_skb: skbaddr=0xffff888eca286b00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_FLOW_LIMIT
      udp_stream   12400 [008]   216.930490: skb:kfree_skb: skbaddr=0xffff888eabf93d00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_FLOW_LIMIT

tc qd replace dev eth1 root fq flow_limit 100 limit 10000
perf record -a -e skb:kfree_skb sleep 1; perf script

      udp_stream   18074 [001]  1058.318040: skb:kfree_skb: skbaddr=0xffffa23c881fc000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_BAND_LIMIT
      udp_stream   18126 [005]  1058.320651: skb:kfree_skb: skbaddr=0xffffa23c6aad4000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_BAND_LIMIT
      udp_stream   18118 [006]  1058.321065: skb:kfree_skb: skbaddr=0xffffa23df0d48a00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_BAND_LIMIT
      udp_stream   18074 [001]  1058.321126: skb:kfree_skb: skbaddr=0xffffa23c881ffa00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_BAND_LIMIT
      udp_stream   15815 [003]  1058.321224: skb:kfree_skb: skbaddr=0xffffa23c9835db00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_DROP_BAND_LIMIT

tc -s -d qd sh dev eth1
qdisc fq 8023: root refcnt 257 limit 10000p flow_limit 100p buckets 1024 orphan_mask 1023
 bands 3 priomap 1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1 weights 589824 196608 65536 quantum 18Kb
 initial_quantum 92120b low_rate_threshold 550Kbit refill_delay 40ms
 timer_slack 10us horizon 10s horizon_drop
 Sent 492439603330 bytes 336953991 pkt (dropped 61724094, overlimits 0 requeues 4463)
 backlog 14611228b 9995p requeues 4463
  flows 2965 (inactive 1151 throttled 0) band0_pkts 0 band1_pkts 9993 band2_pkts 0
  gc 6347 highprio 0 fastpath 30 throttled 5 latency 2.32us flows_plimit 7403693
 band1_drops 54320401

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 include/net/sch_generic.h     |  9 +++++++++
 net/sched/sch_fq.c            | 14 ++++++++++----
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6c5a1ea209a22d8702f8c982762ca5f69791b8eb..570605152a2a2d36a698aa062104d59d3aba000b 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -58,6 +58,9 @@
 	FN(TC_EGRESS)			\
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
+	FN(FQ_DROP_BAND_LIMIT)		\
+	FN(FQ_DROP_HORIZON_LIMIT)	\
+	FN(FQ_DROP_FLOW_LIMIT)		\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
@@ -311,6 +314,21 @@ enum skb_drop_reason {
 	 * failed to enqueue to current qdisc)
 	 */
 	SKB_DROP_REASON_QDISC_DROP,
+	/**
+	 * @SKB_DROP_REASON_FQ_DROP_BAND_LIMIT: dropped by fq qdisc when per band
+	 * limit is reached.
+	 */
+	SKB_DROP_REASON_FQ_DROP_BAND_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_FQ_DROP_HORIZON_LIMIT: dropped by fq qdisc when packet
+	 * timestamp is too far in the future.
+	 */
+	SKB_DROP_REASON_FQ_DROP_HORIZON_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_FQ_DROP_FLOW_LIMIT: dropped by fq qdisc when a flow
+	 * exceeds its limits.
+	 */
+	SKB_DROP_REASON_FQ_DROP_FLOW_LIMIT,
 	/**
 	 * @SKB_DROP_REASON_CPU_BACKLOG: failed to enqueue the skb to the per CPU
 	 * backlog queue. This can be caused by backlog queue full (see
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 5d74fa7e694cc85be91dbf01f0876b9feaa29115..c7a33c2c69830a6cbff8f6359de7cc468c2e845e 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1245,6 +1245,15 @@ static inline int qdisc_drop(struct sk_buff *skb, struct Qdisc *sch,
 	return NET_XMIT_DROP;
 }
 
+static inline int qdisc_drop_reason(struct sk_buff *skb, struct Qdisc *sch,
+				    struct sk_buff **to_free,
+				    enum skb_drop_reason reason)
+{
+	tcf_set_drop_reason(skb, reason);
+	return qdisc_drop(skb, sch, to_free);
+}
+
+
 static inline int qdisc_drop_all(struct sk_buff *skb, struct Qdisc *sch,
 				 struct sk_buff **to_free)
 {
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index a5e87f9ea9861cbedb7ce858fbbcabb5d67cf821..9180810e39fa230ee2c4b6b94bcb87df388f4df8 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -537,6 +537,8 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
+#define FQDR(reason) SKB_DROP_REASON_FQ_DROP_##reason
+
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
 {
@@ -548,7 +550,8 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	band = fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
 	if (unlikely(q->band_pkt_count[band] >= sch->limit)) {
 		q->stat_band_drops[band]++;
-		return qdisc_drop(skb, sch, to_free);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 FQDR(BAND_LIMIT));
 	}
 
 	now = ktime_get_ns();
@@ -558,8 +561,9 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* Check if packet timestamp is too far in the future. */
 		if (fq_packet_beyond_horizon(skb, q, now)) {
 			if (q->horizon_drop) {
-					q->stat_horizon_drops++;
-					return qdisc_drop(skb, sch, to_free);
+				q->stat_horizon_drops++;
+				return qdisc_drop_reason(skb, sch, to_free,
+							 FQDR(HORIZON_LIMIT));
 			}
 			q->stat_horizon_caps++;
 			skb->tstamp = now + q->horizon;
@@ -572,7 +576,8 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (f != &q->internal) {
 		if (unlikely(f->qlen >= q->flow_plimit)) {
 			q->stat_flows_plimit++;
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 FQDR(FLOW_LIMIT));
 		}
 
 		if (fq_flow_is_detached(f)) {
@@ -597,6 +602,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	return NET_XMIT_SUCCESS;
 }
+#undef FQDR
 
 static void fq_check_throttled(struct fq_sched_data *q, u64 now)
 {
-- 
2.47.0.338.g60cca15819-goog


