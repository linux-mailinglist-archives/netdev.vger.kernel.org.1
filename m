Return-Path: <netdev+bounces-242929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DEC96884
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0377F4E1BB2
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E9303A33;
	Mon,  1 Dec 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeD2whX+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRqlYou+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3030215C
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583239; cv=none; b=QkUEVOY2/SeeaPnrOvCiGkcnAAYbfAnx5xU/xDwfrMe4Zlk5VfQfmU03AzDamOBlrM9IyNbBCoBOx+tUXDmSwGrWV0VjRi8c5/W/xpl/dNVfQVYz521V0Kt+LUuZuXtoaBnKzz5aCjPRbH88CZ0bwHFIw42MhZToikCP3rGYSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583239; c=relaxed/simple;
	bh=TLV5VucvMYih+sZw0+hLm4SBAhHw/z1ZBO/bGeK01Z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNKEz0Sm2ZNU1LNsRXqa18mT8CdgoWy14nuyLZKNodN/5K/gnnltdFTkp9cucSSlmokm6C9/7RYuub2hhzsl8Jf5JjMSRCVuM4YPlPQiiAOkQwNezMeGWCg2Hy5HJdLK5sVAYVNKQXe2+KRYAYiY7cPtbhRz2nrslVxcb71t49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeD2whX+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRqlYou+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYsNtpO1R5U2YmXQRCyrPnN4Zbs126tMuztWKlbGgA0=;
	b=TeD2whX+MyGBpZAmWbDCW7k+GDdpiG5oahT5nbH2v+R4m59hZFvKCRNZ/ke+ZNOqjd6e+e
	8WxMlzHwmG/RrerWYBB3ORA/7a/pa3VDFiXHyJ+c03skk3IxORbUSB6Lyi7Y6Y4D0c9aBI
	+AzBhtiDZM58dARZtd3zqW6G85bMlds=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Med8qsSPPsaIY9CibZkOOw-1; Mon, 01 Dec 2025 05:00:34 -0500
X-MC-Unique: Med8qsSPPsaIY9CibZkOOw-1
X-Mimecast-MFC-AGG-ID: Med8qsSPPsaIY9CibZkOOw_1764583233
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6418122dd7bso1012298a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583233; x=1765188033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYsNtpO1R5U2YmXQRCyrPnN4Zbs126tMuztWKlbGgA0=;
        b=RRqlYou+txWTBvCbSZHF2MiqeG3mSlA11j8DuzUHwuAbEG5oZq0Dyf0euLUOFi+PD8
         9ZEHkMaUnra85kjjFKTPN16j2CQY/2Ie97Lxbf5pHdroGE/Al4voilAFckIgFd3Q1+IB
         YsnJCYKEemLNcZ+nomzKikiVyvXNGWZjSAd2rEzG/2CL7evl8x4ht5rTTp0d5G2+enZt
         i2uzA54BFeNbYk52sNE6XNECxcagwW9kOxhMFOA7WsTufFAlJoBfi/JvmQB3S8pJA/Xm
         A3SPqYI0OPGkphuWUKVlyp43X3/o8GU3AcwnJgxl3itLH7MrA0hkYrbkBMsC22iXEBe6
         cQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583233; x=1765188033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYsNtpO1R5U2YmXQRCyrPnN4Zbs126tMuztWKlbGgA0=;
        b=xRvakwmAyUh79iU+NH/4zfT6j+/bXFd6WsHv5918wSkGNUZkLmLWBvqfcVl4GhbhoS
         hNDa6Rm9wv5Uvxg6oHZuV/HU1k8W52pDySLixuFokYOtYvNteX9Xn1IwaxxwHxlM0y9U
         10Lgw+aMfWnsq7PbM5v8ebE2yCBGfSwQ0TqvJ+KT9V/Hl0xoJOMilfoaPAq72CYKmlw3
         qXz0/LVe1gtS083ikrw/Y9+mHoq0WAAImKStUWLcG/XckfdCfiNbGiyfrFEHOjE2f3bd
         Qp+FG/JVa6fDJxh37MNN2OoKpsRpMh62nAnH2shLvsm+DfsYpnbFnIih21TJdBHpO35E
         vlWg==
X-Forwarded-Encrypted: i=1; AJvYcCWqbqnIvs2Sd9l4b4+G3nQ1csAARwpqHijtTKeRUUcK2jYW54gGzGlIN+KE29ePLPdzDA5IqcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIt6fbrqYha+hVwAutVR4R1noOntvnkl569ghVtLt4UWGkeDuB
	oo8+CcYm5fTIOHeKOfGuI3goUZs5rypTXT//B9Pj4GDmQgYGkT/keCgS/nDuZ83sPU3XmHVZ7WA
	LDXw6evVKxfdRvoKPkGxAcpMjPKISamkBU2Icer2fOyH9uUsVfBvqZ9poWA==
X-Gm-Gg: ASbGnct5NGVTL+KIYEjyTOgcLCiPB1G+hwI8upYYBYO8ibDj/qoYiqDUBEuKiLxe2LO
	8VZzxLldv4L0kOiJfdeS2LYFr0DW+dH5uGYXUNqpVsxOkr38pIl5KfPszTphUiTR9XNsqch/jD/
	ASMSzTZuMzbxlGXaH6/ZP/bxr0W9oGuf2qFHk/NtqmUosAamy4kqRcB9y9+SqyE6b00PzBajNzV
	zYfsnSeQNwGww0EwTv5hB/2ZX5MGk7zUN9LR0bzK5yGIo22QVabvebAx8jPCSxL+4CZCLrmbZC6
	LDm8NISVZBxn1IpFc62J3h6CpegYGCRtbLyxy/+6WJrgiJNaN82E0AGvxM3w417oRQDYUySQ3w4
	IpG2h2HA4nOCjV7/mGEXY2DvivhqvFaGHccaZ
X-Received: by 2002:a05:6402:34d0:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-645eb223e11mr21212970a12.6.1764583232601;
        Mon, 01 Dec 2025 02:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+diuim9FpdXgcA2NOzeensG9fIbBPvu//WcrDYGhdAXZ9kC5kqGy4ibigTg9NkwrjHYzSwQ==
X-Received: by 2002:a05:6402:34d0:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-645eb223e11mr21212950a12.6.1764583232111;
        Mon, 01 Dec 2025 02:00:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035af1sm12319995a12.16.2025.12.01.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9F278395D55; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 01 Dec 2025 11:00:20 +0100
Subject: [PATCH net-next v4 2/5] net/sched: sch_cake: Factor out config
 variables into separate struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-mq-cake-sub-qdisc-v4-2-50dd3211a1c6@redhat.com>
References: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
In-Reply-To: <20251201-mq-cake-sub-qdisc-v4-0-50dd3211a1c6@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

Factor out all the user-configurable variables into a separate struct
and embed it into struct cake_sched_data. This is done in preparation
for sharing the configuration across multiple instances of cake in an mq
setup.

No functional change is intended with this patch.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 245 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 112 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 0ea9440f68c6..545b9b830cce 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -197,40 +197,42 @@ struct cake_tin_data {
 	u32	way_collisions;
 }; /* number of tins is small, so size of this struct doesn't matter much */
 
+struct cake_sched_config {
+	u64		rate_bps;
+	u64		interval;
+	u64		target;
+	u32		buffer_config_limit;
+	u32		fwmark_mask;
+	u16		fwmark_shft;
+	s16		rate_overhead;
+	u16		rate_mpu;
+	u16		rate_flags;
+	u8		tin_mode;
+	u8		flow_mode;
+	u8		atm_mode;
+	u8		ack_filter;
+};
+
 struct cake_sched_data {
 	struct tcf_proto __rcu *filter_list; /* optional external classifier */
 	struct tcf_block *block;
 	struct cake_tin_data *tins;
+	struct cake_sched_config *config;
 
 	struct cake_heap_entry overflow_heap[CAKE_QUEUES * CAKE_MAX_TINS];
-	u16		overflow_timeout;
-
-	u16		tin_cnt;
-	u8		tin_mode;
-	u8		flow_mode;
-	u8		ack_filter;
-	u8		atm_mode;
-
-	u32		fwmark_mask;
-	u16		fwmark_shft;
 
 	/* time_next = time_this + ((len * rate_ns) >> rate_shft) */
-	u16		rate_shft;
 	ktime_t		time_next_packet;
 	ktime_t		failsafe_next_packet;
 	u64		rate_ns;
-	u64		rate_bps;
-	u16		rate_flags;
-	s16		rate_overhead;
-	u16		rate_mpu;
-	u64		interval;
-	u64		target;
+	u16		rate_shft;
+	u16		overflow_timeout;
+	u16		tin_cnt;
 
 	/* resource tracking */
 	u32		buffer_used;
 	u32		buffer_max_used;
 	u32		buffer_limit;
-	u32		buffer_config_limit;
 
 	/* indices for dequeue */
 	u16		cur_tin;
@@ -1198,7 +1200,7 @@ static bool cake_tcph_may_drop(const struct tcphdr *tcph,
 static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 				       struct cake_flow *flow)
 {
-	bool aggressive = q->ack_filter == CAKE_ACK_AGGRESSIVE;
+	bool aggressive = q->config->ack_filter == CAKE_ACK_AGGRESSIVE;
 	struct sk_buff *elig_ack = NULL, *elig_ack_prev = NULL;
 	struct sk_buff *skb_check, *skb_prev = NULL;
 	const struct ipv6hdr *ipv6h, *ipv6h_check;
@@ -1358,15 +1360,17 @@ static u64 cake_ewma(u64 avg, u64 sample, u32 shift)
 	return avg;
 }
 
-static u32 cake_calc_overhead(struct cake_sched_data *q, u32 len, u32 off)
+static u32 cake_calc_overhead(struct cake_sched_data *qd, u32 len, u32 off)
 {
+	struct cake_sched_config *q = qd->config;
+
 	if (q->rate_flags & CAKE_FLAG_OVERHEAD)
 		len -= off;
 
-	if (q->max_netlen < len)
-		q->max_netlen = len;
-	if (q->min_netlen > len)
-		q->min_netlen = len;
+	if (qd->max_netlen < len)
+		qd->max_netlen = len;
+	if (qd->min_netlen > len)
+		qd->min_netlen = len;
 
 	len += q->rate_overhead;
 
@@ -1385,10 +1389,10 @@ static u32 cake_calc_overhead(struct cake_sched_data *q, u32 len, u32 off)
 		len += (len + 63) / 64;
 	}
 
-	if (q->max_adjlen < len)
-		q->max_adjlen = len;
-	if (q->min_adjlen > len)
-		q->min_adjlen = len;
+	if (qd->max_adjlen < len)
+		qd->max_adjlen = len;
+	if (qd->min_adjlen > len)
+		qd->min_adjlen = len;
 
 	return len;
 }
@@ -1586,7 +1590,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	flow->dropped++;
 	b->tin_dropped++;
 
-	if (q->rate_flags & CAKE_FLAG_INGRESS)
+	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
 
 	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
@@ -1657,7 +1661,8 @@ static u8 cake_handle_diffserv(struct sk_buff *skb, bool wash)
 static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 					     struct sk_buff *skb)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	u32 tin, mark;
 	bool wash;
 	u8 dscp;
@@ -1674,24 +1679,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	if (q->tin_mode == CAKE_DIFFSERV_BESTEFFORT)
 		tin = 0;
 
-	else if (mark && mark <= q->tin_cnt)
-		tin = q->tin_order[mark - 1];
+	else if (mark && mark <= qd->tin_cnt)
+		tin = qd->tin_order[mark - 1];
 
 	else if (TC_H_MAJ(skb->priority) == sch->handle &&
 		 TC_H_MIN(skb->priority) > 0 &&
-		 TC_H_MIN(skb->priority) <= q->tin_cnt)
-		tin = q->tin_order[TC_H_MIN(skb->priority) - 1];
+		 TC_H_MIN(skb->priority) <= qd->tin_cnt)
+		tin = qd->tin_order[TC_H_MIN(skb->priority) - 1];
 
 	else {
 		if (!wash)
 			dscp = cake_handle_diffserv(skb, wash);
-		tin = q->tin_index[dscp];
+		tin = qd->tin_index[dscp];
 
-		if (unlikely(tin >= q->tin_cnt))
+		if (unlikely(tin >= qd->tin_cnt))
 			tin = 0;
 	}
 
-	return &q->tins[tin];
+	return &qd->tins[tin];
 }
 
 static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
@@ -1747,7 +1752,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u32 idx, tin;
 
 	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
+	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
 	if (idx == 0) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
@@ -1782,7 +1787,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		b->max_skblen = len;
 
-	if (qdisc_pkt_segs(skb) > 1 && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
 		struct sk_buff *segs, *nskb;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
@@ -1822,7 +1827,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
 		flow_queue_add(flow, skb);
 
-		if (q->ack_filter)
+		if (q->config->ack_filter)
 			ack = cake_ack_filter(q, flow);
 
 		if (ack) {
@@ -1831,7 +1836,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			b->bytes += qdisc_pkt_len(ack);
 			len -= qdisc_pkt_len(ack);
 			q->buffer_used += skb->truesize - ack->truesize;
-			if (q->rate_flags & CAKE_FLAG_INGRESS)
+			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
 			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(ack));
@@ -1854,7 +1859,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		cake_heapify_up(q, b->overflow_idx[idx]);
 
 	/* incoming bandwidth capacity estimate */
-	if (q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
+	if (q->config->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
 		u64 packet_interval = \
 			ktime_to_ns(ktime_sub(now, q->last_packet_time));
 
@@ -1886,7 +1891,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			if (ktime_after(now,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
-				q->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
 				cake_reconfigure(sch);
 			}
 		}
@@ -1906,7 +1911,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
+		flow->deficit = cake_get_flow_quantum(b, flow, q->config->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
@@ -1915,8 +1920,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
-		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -2098,8 +2103,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
-				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2111,7 +2116,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
+		flow->deficit += cake_get_flow_quantum(b, flow, q->config->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2135,8 +2140,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2154,8 +2159,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
@@ -2166,14 +2171,14 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
 		reason = cobalt_should_drop(&flow->cvars, &b->cparams, now, skb,
 					    (b->bulk_flow_count *
-					     !!(q->rate_flags &
+					     !!(q->config->rate_flags &
 						CAKE_FLAG_INGRESS)));
 		/* Last packet in queue may be marked, shouldn't be dropped */
 		if (reason == SKB_NOT_DROPPED_YET || !flow->head)
 			break;
 
 		/* drop this packet, get another one */
-		if (q->rate_flags & CAKE_FLAG_INGRESS) {
+		if (q->config->rate_flags & CAKE_FLAG_INGRESS) {
 			len = cake_advance_shaper(q, b, skb,
 						  now, true);
 			flow->deficit -= len;
@@ -2184,7 +2189,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
 		qdisc_dequeue_drop(sch, skb, reason);
-		if (q->rate_flags & CAKE_FLAG_INGRESS)
+		if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 			goto retry;
 	}
 
@@ -2306,7 +2311,7 @@ static int cake_config_besteffort(struct Qdisc *sch)
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[0];
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 
 	q->tin_cnt = 1;
 
@@ -2314,7 +2319,7 @@ static int cake_config_besteffort(struct Qdisc *sch)
 	q->tin_order = normal_order;
 
 	cake_set_rate(b, rate, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	b->tin_quantum = 65535;
 
 	return 0;
@@ -2325,7 +2330,7 @@ static int cake_config_precedence(struct Qdisc *sch)
 	/* convert high-level (user visible) parameters into internal format */
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2336,8 +2341,8 @@ static int cake_config_precedence(struct Qdisc *sch)
 	for (i = 0; i < q->tin_cnt; i++) {
 		struct cake_tin_data *b = &q->tins[i];
 
-		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
-			      us_to_ns(q->interval));
+		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
+			      us_to_ns(q->config->interval));
 
 		b->tin_quantum = max_t(u16, 1U, quantum);
 
@@ -2414,7 +2419,7 @@ static int cake_config_diffserv8(struct Qdisc *sch)
 
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2428,8 +2433,8 @@ static int cake_config_diffserv8(struct Qdisc *sch)
 	for (i = 0; i < q->tin_cnt; i++) {
 		struct cake_tin_data *b = &q->tins[i];
 
-		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
-			      us_to_ns(q->interval));
+		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
+			      us_to_ns(q->config->interval));
 
 		b->tin_quantum = max_t(u16, 1U, quantum);
 
@@ -2458,7 +2463,7 @@ static int cake_config_diffserv4(struct Qdisc *sch)
 
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 4;
@@ -2469,13 +2474,13 @@ static int cake_config_diffserv4(struct Qdisc *sch)
 
 	/* class characteristics */
 	cake_set_rate(&q->tins[0], rate, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	cake_set_rate(&q->tins[1], rate >> 4, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	cake_set_rate(&q->tins[2], rate >> 1, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	cake_set_rate(&q->tins[3], rate >> 2, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 
 	/* bandwidth-sharing weights */
 	q->tins[0].tin_quantum = quantum;
@@ -2495,7 +2500,7 @@ static int cake_config_diffserv3(struct Qdisc *sch)
  */
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 3;
@@ -2506,11 +2511,11 @@ static int cake_config_diffserv3(struct Qdisc *sch)
 
 	/* class characteristics */
 	cake_set_rate(&q->tins[0], rate, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	cake_set_rate(&q->tins[1], rate >> 4, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	cake_set_rate(&q->tins[2], rate >> 2, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 
 	/* bandwidth-sharing weights */
 	q->tins[0].tin_quantum = quantum;
@@ -2522,7 +2527,8 @@ static int cake_config_diffserv3(struct Qdisc *sch)
 
 static void cake_reconfigure(struct Qdisc *sch)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	int c, ft;
 
 	switch (q->tin_mode) {
@@ -2548,36 +2554,37 @@ static void cake_reconfigure(struct Qdisc *sch)
 		break;
 	}
 
-	for (c = q->tin_cnt; c < CAKE_MAX_TINS; c++) {
+	for (c = qd->tin_cnt; c < CAKE_MAX_TINS; c++) {
 		cake_clear_tin(sch, c);
-		q->tins[c].cparams.mtu_time = q->tins[ft].cparams.mtu_time;
+		qd->tins[c].cparams.mtu_time = qd->tins[ft].cparams.mtu_time;
 	}
 
-	q->rate_ns   = q->tins[ft].tin_rate_ns;
-	q->rate_shft = q->tins[ft].tin_rate_shft;
+	qd->rate_ns   = qd->tins[ft].tin_rate_ns;
+	qd->rate_shft = qd->tins[ft].tin_rate_shft;
 
 	if (q->buffer_config_limit) {
-		q->buffer_limit = q->buffer_config_limit;
+		qd->buffer_limit = q->buffer_config_limit;
 	} else if (q->rate_bps) {
 		u64 t = q->rate_bps * q->interval;
 
 		do_div(t, USEC_PER_SEC / 4);
-		q->buffer_limit = max_t(u32, t, 4U << 20);
+		qd->buffer_limit = max_t(u32, t, 4U << 20);
 	} else {
-		q->buffer_limit = ~0;
+		qd->buffer_limit = ~0;
 	}
 
 	sch->flags &= ~TCQ_F_CAN_BYPASS;
 
-	q->buffer_limit = min(q->buffer_limit,
-			      max(sch->limit * psched_mtu(qdisc_dev(sch)),
-				  q->buffer_config_limit));
+	qd->buffer_limit = min(qd->buffer_limit,
+			       max(sch->limit * psched_mtu(qdisc_dev(sch)),
+				   q->buffer_config_limit));
 }
 
 static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		       struct netlink_ext_ack *extack)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	struct nlattr *tb[TCA_CAKE_MAX + 1];
 	u16 rate_flags;
 	u8 flow_mode;
@@ -2631,19 +2638,19 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_s32(tb[TCA_CAKE_OVERHEAD]));
 		rate_flags |= CAKE_FLAG_OVERHEAD;
 
-		q->max_netlen = 0;
-		q->max_adjlen = 0;
-		q->min_netlen = ~0;
-		q->min_adjlen = ~0;
+		qd->max_netlen = 0;
+		qd->max_adjlen = 0;
+		qd->min_netlen = ~0;
+		qd->min_adjlen = ~0;
 	}
 
 	if (tb[TCA_CAKE_RAW]) {
 		rate_flags &= ~CAKE_FLAG_OVERHEAD;
 
-		q->max_netlen = 0;
-		q->max_adjlen = 0;
-		q->min_netlen = ~0;
-		q->min_adjlen = ~0;
+		qd->max_netlen = 0;
+		qd->max_adjlen = 0;
+		qd->min_netlen = ~0;
+		qd->min_adjlen = ~0;
 	}
 
 	if (tb[TCA_CAKE_MPU])
@@ -2699,7 +2706,7 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 
 	WRITE_ONCE(q->rate_flags, rate_flags);
 	WRITE_ONCE(q->flow_mode, flow_mode);
-	if (q->tins) {
+	if (qd->tins) {
 		sch_tree_lock(sch);
 		cake_reconfigure(sch);
 		sch_tree_unlock(sch);
@@ -2715,14 +2722,20 @@ static void cake_destroy(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 	tcf_block_put(q->block);
 	kvfree(q->tins);
+	kvfree(q->config);
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 		     struct netlink_ext_ack *extack)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q;
 	int i, j, err;
 
+	q = kvcalloc(1, sizeof(struct cake_sched_config), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+
 	sch->limit = 10240;
 	sch->flags |= TCQ_F_DEQUEUE_DROPS;
 
@@ -2736,33 +2749,36 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 			       * for 5 to 10% of interval
 			       */
 	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
-	q->cur_tin = 0;
-	q->cur_flow  = 0;
+	qd->cur_tin = 0;
+	qd->cur_flow  = 0;
+	qd->config = q;
 
-	qdisc_watchdog_init(&q->watchdog, sch);
+	qdisc_watchdog_init(&qd->watchdog, sch);
 
 	if (opt) {
 		err = cake_change(sch, opt, extack);
 
 		if (err)
-			return err;
+			goto err;
 	}
 
-	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
+	err = tcf_block_get(&qd->block, &qd->filter_list, sch, extack);
 	if (err)
-		return err;
+		goto err;
 
 	quantum_div[0] = ~0;
 	for (i = 1; i <= CAKE_QUEUES; i++)
 		quantum_div[i] = 65535 / i;
 
-	q->tins = kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
-			   GFP_KERNEL);
-	if (!q->tins)
-		return -ENOMEM;
+	qd->tins = kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
+			    GFP_KERNEL);
+	if (!qd->tins) {
+		err = -ENOMEM;
+		goto err;
+	}
 
 	for (i = 0; i < CAKE_MAX_TINS; i++) {
-		struct cake_tin_data *b = q->tins + i;
+		struct cake_tin_data *b = qd->tins + i;
 
 		INIT_LIST_HEAD(&b->new_flows);
 		INIT_LIST_HEAD(&b->old_flows);
@@ -2778,22 +2794,27 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 			INIT_LIST_HEAD(&flow->flowchain);
 			cobalt_vars_init(&flow->cvars);
 
-			q->overflow_heap[k].t = i;
-			q->overflow_heap[k].b = j;
+			qd->overflow_heap[k].t = i;
+			qd->overflow_heap[k].b = j;
 			b->overflow_idx[j] = k;
 		}
 	}
 
 	cake_reconfigure(sch);
-	q->avg_peak_bandwidth = q->rate_bps;
-	q->min_netlen = ~0;
-	q->min_adjlen = ~0;
+	qd->avg_peak_bandwidth = q->rate_bps;
+	qd->min_netlen = ~0;
+	qd->min_adjlen = ~0;
 	return 0;
+err:
+	kvfree(qd->config);
+	qd->config = NULL;
+	return err;
 }
 
 static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	struct nlattr *opts;
 	u16 rate_flags;
 	u8 flow_mode;

-- 
2.52.0


