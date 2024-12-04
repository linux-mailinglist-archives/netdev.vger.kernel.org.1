Return-Path: <netdev+bounces-149088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE399E4629
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA3BC8048
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47F20E71B;
	Wed,  4 Dec 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFLUr/4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655320DD5B
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332794; cv=none; b=uP56ds7d8eCiWHwaE2HQkzbCKFEaAWrS16ZGj0IOhuULEUYZqd6SqFPisCW0qlGmjZb89IPAW3LilKaB99JiKaTuTRiOI+GYdAcRZvpI8nwZ70kqiDTCfEflCVcaeHNKzrbZiPb/FjXN7Y6osBvihLwKmUZq5pem78DN/IfjTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332794; c=relaxed/simple;
	bh=vTr1igLhIDtfKINzt7pPA2LIHaCiS9UDZmVN/VLa30g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sifLvxnbxODMlT1WYzCI1WuLpehY02c1P0BbVrC/q/Hz5T+tunq/gpTSFYl7SZLvWNIYeVYspFBLOD3xOkQ6I35/+ZhIvYuvjuXqA0XjFgnzBj4+Y65NdoeTT5sZS2DYC4rcUVUI7dFM05ftRXKv4xQyyKjlvs7uKCowK/n+f0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFLUr/4f; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef590f5321so90143577b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733332791; x=1733937591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ThCuNupMzkORQUCZ2snpPbXOuVyinHnt+ntQhdrZzRI=;
        b=HFLUr/4fMqXoCxzb5JaIUlM1I6LIXSAoJQEclaf2Fx5FP54SJ7l0Wrs1jpZZ4voRIZ
         JZfYsnUJdhmO2B0Us0hvzLryAGJaoiL9C8TIhZ9qa7H4XUjql99oftLDwaRfNvDiFnNp
         vZ27Eq0a+kEYc+XPeUsVsQl3K+1GGPNph8sfGpu8BF3PuQ2h0rLqHP4EbutG5VViQoZ9
         LTbojwAidVBfRDDEqqKktnJa/KNaa2Y/ygUBKb+6E0KAIa36FyIcwl3ntaMoZsT+CMZu
         K9j1lFc1K4ogd5l5E3uMXj2HYlgYQGA8OzYS6M97/p5rRp9dactz/nfori/5nrFIFhQt
         gWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332791; x=1733937591;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThCuNupMzkORQUCZ2snpPbXOuVyinHnt+ntQhdrZzRI=;
        b=eENr10++WGGp/9viJ6S1bAlyLUbVOBs7eli4iznJDsinJCDZDsfydDFjTLXHWRQs3A
         aMyftNqOQciAJZf63PrvPS8tR5wY34hQBmDe17QvWzWzzfKZpVfmOqgE9pl6bCoTNx/i
         dKa+QHNFhELPd/yKzGYUkLhHxe61tGEtGgMMFiaXLiH5kx7ZLdqAuXE9udzw9HMF5liV
         PE+5n6A83A+VkrowQdh4WtcJx/vUMoc9mKFN8vx2/letF25n1CP/poJvfl7hF1/5uVEs
         5SwJOAtmoGKP5N9kY0meEzqW6n8Xaar7B7yt0F4nS/lLQPeW8/8JXys8OSyvqjh7a4/+
         tdqw==
X-Forwarded-Encrypted: i=1; AJvYcCWcO/0Or9QSIV9UAbZbbAYzJPHyD74nsTiN50XT+FtHBhR8iJCVgeCj9cgH6Kx8CJhtBHqE1ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFGnka1DZvKwvm4GpKsW+ibLHfjHCcaAbg+MBY5wzQv1Vv9r6
	05U9adFtl3Kj2gEzISVwDhtzd1osNX+vSUY3gmr/a4O4c9HOQaQ0AuuM5tW030QBEFmUqy1Ydkf
	oWM94/wlOpg==
X-Google-Smtp-Source: AGHT+IHBiI2gaV4W2E+oryz9BtbnOw193W9PcT0tZj12W3CSDbuknqFkNbetMpz5VER2OQw8oQ0HYLpQWHjD+g==
X-Received: from ywbet19.prod.google.com ([2002:a05:690c:2e13:b0:6ef:60b5:32b0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6382:b0:6ef:5ab8:2c53 with SMTP id 00721157ae682-6efad1be626mr75865177b3.19.1733332791302;
 Wed, 04 Dec 2024 09:19:51 -0800 (PST)
Date: Wed,  4 Dec 2024 17:19:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204171950.89829-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net_sched: sch_fq: add three drop_reason
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

1) SKB_DROP_REASON_FQ_BAND_LIMIT
   Whenever a packet is added while its band limit is hit.
   Corresponding value in "tc -s qd" is bandX_drops XXXX

2) SKB_DROP_REASON_FQ_HORIZON_LIMIT
   Whenever a packet has a timestamp too far in the future.
   Corresponding value in "tc -s qd" is horizon_drops XXXX

3) SKB_DROP_REASON_FQ_FLOW_LIMIT
   Whenever a flow has reached its limit.
   Corresponding value in "tc -s qd" is flows_plimit XXXX

Tested:
tc qd replace dev eth1 root fq flow_limit 10 limit 100000
perf record -a -e skb:kfree_skb sleep 1; perf script

      udp_stream   12329 [004]   216.929492: skb:kfree_skb: skbaddr=0xffff888eabe17e00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
      udp_stream   12385 [006]   216.929593: skb:kfree_skb: skbaddr=0xffff888ef8827f00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
      udp_stream   12389 [005]   216.929871: skb:kfree_skb: skbaddr=0xffff888ecb9ba500 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
      udp_stream   12316 [009]   216.930398: skb:kfree_skb: skbaddr=0xffff888eca286b00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT
      udp_stream   12400 [008]   216.930490: skb:kfree_skb: skbaddr=0xffff888eabf93d00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_FLOW_LIMIT

tc qd replace dev eth1 root fq flow_limit 100 limit 10000
perf record -a -e skb:kfree_skb sleep 1; perf script

      udp_stream   18074 [001]  1058.318040: skb:kfree_skb: skbaddr=0xffffa23c881fc000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
      udp_stream   18126 [005]  1058.320651: skb:kfree_skb: skbaddr=0xffffa23c6aad4000 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
      udp_stream   18118 [006]  1058.321065: skb:kfree_skb: skbaddr=0xffffa23df0d48a00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
      udp_stream   18074 [001]  1058.321126: skb:kfree_skb: skbaddr=0xffffa23c881ffa00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT
      udp_stream   15815 [003]  1058.321224: skb:kfree_skb: skbaddr=0xffffa23c9835db00 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x9d9 reason: FQ_BAND_LIMIT

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
v2: Addressed Cong feedback from v1
    v1: https://lore.kernel.org/netdev/CANn89iLofU1dnwAf-4ezn08h=o82ZPCHc3QJSMUdC+5aUhRsgA@mail.gmail.com/T/#t
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 include/net/sch_generic.h     |  9 +++++++++
 net/sched/sch_fq.c            | 14 ++++++++++----
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6c5a1ea209a22d8702f8c982762ca5f69791b8eb..c29282fabae6cdf9dd79f698b92b4b8f57156b1e 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -58,6 +58,9 @@
 	FN(TC_EGRESS)			\
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
+	FN(FQ_BAND_LIMIT)		\
+	FN(FQ_HORIZON_LIMIT)		\
+	FN(FQ_FLOW_LIMIT)		\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
@@ -311,6 +314,21 @@ enum skb_drop_reason {
 	 * failed to enqueue to current qdisc)
 	 */
 	SKB_DROP_REASON_QDISC_DROP,
+	/**
+	 * @SKB_DROP_REASON_FQ_BAND_LIMIT: dropped by fq qdisc when per band
+	 * limit is reached.
+	 */
+	SKB_DROP_REASON_FQ_BAND_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_FQ_HORIZON_LIMIT: dropped by fq qdisc when packet
+	 * timestamp is too far in the future.
+	 */
+	SKB_DROP_REASON_FQ_HORIZON_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_FQ_FLOW_LIMIT: dropped by fq qdisc when a flow
+	 * exceeds its limits.
+	 */
+	SKB_DROP_REASON_FQ_FLOW_LIMIT,
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
index a5e87f9ea9861cbedb7ce858fbbcabb5d67cf821..2ca5332cfcc5c52bf30e6f8337814a656b919b17 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -537,6 +537,8 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
+#define FQDR(reason) SKB_DROP_REASON_FQ_##reason
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


