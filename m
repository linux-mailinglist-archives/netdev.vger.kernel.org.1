Return-Path: <netdev+bounces-248501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B5D0A524
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 262AD3022F2C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65035CB6C;
	Fri,  9 Jan 2026 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHLeeLpk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O47KqSrA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BAF35C1AF
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964549; cv=none; b=MngVrSRWFKCLoSnPWEsGThuvQF8Xyl3dodoYZUQbBhkXpT3lAxMkJnY2IrlAGmNcWs9JhSegNheYysGiOEnCknw8CuJvJlYfpqDQprESyHM6EV9G+zGnubjbfib3dXgvUw7foHqv8Kvwfvd+pafn8h2aCt1HPVta1CUQG8nAw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964549; c=relaxed/simple;
	bh=oZSmkD9wnhhh/PAeEdhV1UOPLt4Q9OerBzqJm4k3+sQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axE+O9ts2Jtt7SHqM/prCpIDkXL5icJVoMbH7dpb69kdncAduRM2jvfE2gFh9vOWRs56NFYC4vP01WpGUBNQCXO92NRyd7XhRiqLHBAot7Wea9245EI3xWv8LzJFRaoDY+PL6JcqlMY8GoMnsRp10bF7mF8N3ezeZJP5vh+hgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHLeeLpk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O47KqSrA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHOXD3gRytM9tmM6ObKGPsUiZVLAOfwdEmtk1pMBU5o=;
	b=IHLeeLpkqBK9jIkJoF5o5DqB7tHhQi71HGLeIX/zJMC/RpcEZrBHHKCUe22pBV67l6BSUV
	zxxYRva5GOnlPk7b7q6f/4eBfm3mCRswYrcXy7JjVPf/baMz9Hoq8xCwLDQvYbFC/l08ZU
	C48rI/AHO0vMohdJkjN0Gbxh1Klux3g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-JPcGIiypMBK5-mG4B-xV4g-1; Fri, 09 Jan 2026 08:15:43 -0500
X-MC-Unique: JPcGIiypMBK5-mG4B-xV4g-1
X-Mimecast-MFC-AGG-ID: JPcGIiypMBK5-mG4B-xV4g_1767964542
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b831e10ba03so643262066b.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964542; x=1768569342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHOXD3gRytM9tmM6ObKGPsUiZVLAOfwdEmtk1pMBU5o=;
        b=O47KqSrAX5m1G2Shv+X27nHlRqtV4VNqLFlSuLKayjUWY1yYgpNlAJV+lzOLOxO7Ap
         6QI3Q7yCxwirTqhRhvswVmuNd1/H/nVKTNXJXSjVCmzy4GvIqSeNBaFo9ADWxxgIM2mL
         Q6WSprZmU+bW1b08EHSCp/o16Y6g8Zh6pPyv2J6rirLKquNNSxyCReS34zGP9CBP/R5I
         PkMcDhLkyj70VWvAZg+o/KrZlmyKeSn5fSbjWoF2xC1uoHiExu/o20UHe2O9hyYGoGtg
         M8xN3isov+NWckyz4qAHIi9VV2fUvSCw9hAPzHHQu/+Rsl1cAUrwBiHe/2ssX+nx2LDn
         pG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964542; x=1768569342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MHOXD3gRytM9tmM6ObKGPsUiZVLAOfwdEmtk1pMBU5o=;
        b=vptToBMO+oBVej7ONtp8s/tScPPMwnZxLwJjl6ITKvDUUW4v/74QoulLlvMfDKFLNS
         F1VTqfcKOPgNepkgKk4hth3pQydzFZbUBGPwuEQl6oAF+6jTBrTJm6a2X3IlHw82/+go
         tEeGd7tc7SI65Bkng8rJhuTMuPNt5jSfzyrIAVk7yX5S07YyAWHnqWXXMmUNpSaoqUXl
         oJjyNuxmu+/8+z2U3DPUL4//ilkxL+hmfEZNZBbYFgdqSp0BHRQ/JqMtPnaSSmir98t/
         oRn84YvUM3lPpC7oe8lTZjpU0jmAV4pBavQ7cgfhU0ozgQLqkyxRcn/8OPlMSUBDE9Pf
         R+EA==
X-Forwarded-Encrypted: i=1; AJvYcCVbeSjV18zB3KX/FBoONh1+mYzUcEiYEr7PBRRfct9qb2DVrlb+Lk41OX8yss5L0W59UewenDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzv3HrVVcjnLecuQVZTzs0M2MP+u8XiMp0W7dLXGOTKfVb3FHo
	7lidiVMWxwOyh0JN88GGtxCP5hygjoMIQub2wS1Ch8LjJgy9MOORjKPqFtyVB/KTK9X/d2i+Cgj
	5lHzn9wIFfd8Mu0P1wacDY3v4aRLVtAvtzuzBDPRYaT5y6xn2A4OI6tAZZQ==
X-Gm-Gg: AY/fxX4fiJI5ZZk+aTOIk9XsOqAELLLwjIncFyZNA+FTA7ZI39VtMHL3sQaAiR2wyuQ
	ku4uL1vSfCvxZpKf9tsK/RCNkAM1YUjxrhpgPuo3qLD2xPjg9SBAUAJpEveqYwiWrSgmLl4GHhG
	878NPgl4i+zErHOtpXMkJaBHifghuDhA+o0LcQRnRfZGcvLo+i4M0kCaIgMz54Z6dNG5K/k3Mn9
	1yBh9hJLmhUe4xD0BDoFgReq4jZGt3sBy/jIJsgivJhLldrmBt1i8HpHdY+We7Gsw7SXqghmmIm
	gS0200jiNo/bgpfPqIO9pX1Z71SZo92aafVvoB0uPQTLsy+eu8cqoG9d4Y2f+Ix1xaO2SHVn1qu
	Tff5yQgauJ+XxYgY+2XxJOhCFohgLwGD/BCWG
X-Received: by 2002:a17:907:705:b0:b83:73ee:9dc0 with SMTP id a640c23a62f3a-b8445177102mr902392866b.65.1767964542113;
        Fri, 09 Jan 2026 05:15:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJXUkxBxkMZ4/8aoILHslRiHSa4SLX5kTmbANi9CxEWhEiarYvLoGrymwSkpKQDKvjcEtr5w==
X-Received: by 2002:a17:907:705:b0:b83:73ee:9dc0 with SMTP id a640c23a62f3a-b8445177102mr902388566b.65.1767964541534;
        Fri, 09 Jan 2026 05:15:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27bfcasm1138435866b.21.2026.01.09.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 24E2C40862F; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:31 +0100
Subject: [PATCH net-next v8 2/6] net/sched: sch_cake: Factor out config
 variables into separate struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-2-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

Factor out all the user-configurable variables into a separate struct
and embed it into struct cake_sched_data. This is done in preparation
for sharing the configuration across multiple instances of cake in an mq
setup.

No functional change is intended with this patch.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 245 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 133 insertions(+), 112 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 4a64d6397b6f..8171674b160d 100644
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
@@ -1656,7 +1660,8 @@ static u8 cake_handle_diffserv(struct sk_buff *skb, bool wash)
 static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 					     struct sk_buff *skb)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	u32 tin, mark;
 	bool wash;
 	u8 dscp;
@@ -1673,24 +1678,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
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
@@ -1746,7 +1751,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	bool same_flow = false;
 
 	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
+	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
 	if (idx == 0) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
@@ -1781,7 +1786,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		b->max_skblen = len;
 
-	if (qdisc_pkt_segs(skb) > 1 && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
 		struct sk_buff *segs, *nskb;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
@@ -1823,7 +1828,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
 		flow_queue_add(flow, skb);
 
-		if (q->ack_filter)
+		if (q->config->ack_filter)
 			ack = cake_ack_filter(q, flow);
 
 		if (ack) {
@@ -1832,7 +1837,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			ack_pkt_len = qdisc_pkt_len(ack);
 			b->bytes += ack_pkt_len;
 			q->buffer_used += skb->truesize - ack->truesize;
-			if (q->rate_flags & CAKE_FLAG_INGRESS)
+			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 				cake_advance_shaper(q, b, ack, now, true);
 
 			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
@@ -1855,7 +1860,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		cake_heapify_up(q, b->overflow_idx[idx]);
 
 	/* incoming bandwidth capacity estimate */
-	if (q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
+	if (q->config->rate_flags & CAKE_FLAG_AUTORATE_INGRESS) {
 		u64 packet_interval = \
 			ktime_to_ns(ktime_sub(now, q->last_packet_time));
 
@@ -1887,7 +1892,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			if (ktime_after(now,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
-				q->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
 				cake_reconfigure(sch);
 			}
 		}
@@ -1907,7 +1912,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		b->sparse_flow_count++;
 
-		flow->deficit = cake_get_flow_quantum(b, flow, q->flow_mode);
+		flow->deficit = cake_get_flow_quantum(b, flow, q->config->flow_mode);
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
@@ -1916,8 +1921,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		b->sparse_flow_count--;
 		b->bulk_flow_count++;
 
-		cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
-		cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 	}
 
 	if (q->buffer_used > q->buffer_max_used)
@@ -2104,8 +2109,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				b->sparse_flow_count--;
 				b->bulk_flow_count++;
 
-				cake_inc_srchost_bulk_flow_count(b, flow, q->flow_mode);
-				cake_inc_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 
 				flow->set = CAKE_SET_BULK;
 			} else {
@@ -2117,7 +2122,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		flow->deficit += cake_get_flow_quantum(b, flow, q->flow_mode);
+		flow->deficit += cake_get_flow_quantum(b, flow, q->config->flow_mode);
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2141,8 +2146,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 
 					b->decaying_flow_count++;
 				} else if (flow->set == CAKE_SET_SPARSE ||
@@ -2160,8 +2165,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 				else if (flow->set == CAKE_SET_BULK) {
 					b->bulk_flow_count--;
 
-					cake_dec_srchost_bulk_flow_count(b, flow, q->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->flow_mode);
+					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 				} else
 					b->decaying_flow_count--;
 
@@ -2172,14 +2177,14 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 
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
@@ -2190,7 +2195,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
 		qdisc_dequeue_drop(sch, skb, reason);
-		if (q->rate_flags & CAKE_FLAG_INGRESS)
+		if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 			goto retry;
 	}
 
@@ -2312,7 +2317,7 @@ static int cake_config_besteffort(struct Qdisc *sch)
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[0];
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 
 	q->tin_cnt = 1;
 
@@ -2320,7 +2325,7 @@ static int cake_config_besteffort(struct Qdisc *sch)
 	q->tin_order = normal_order;
 
 	cake_set_rate(b, rate, mtu,
-		      us_to_ns(q->target), us_to_ns(q->interval));
+		      us_to_ns(q->config->target), us_to_ns(q->config->interval));
 	b->tin_quantum = 65535;
 
 	return 0;
@@ -2331,7 +2336,7 @@ static int cake_config_precedence(struct Qdisc *sch)
 	/* convert high-level (user visible) parameters into internal format */
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2342,8 +2347,8 @@ static int cake_config_precedence(struct Qdisc *sch)
 	for (i = 0; i < q->tin_cnt; i++) {
 		struct cake_tin_data *b = &q->tins[i];
 
-		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
-			      us_to_ns(q->interval));
+		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
+			      us_to_ns(q->config->interval));
 
 		b->tin_quantum = max_t(u16, 1U, quantum);
 
@@ -2420,7 +2425,7 @@ static int cake_config_diffserv8(struct Qdisc *sch)
 
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 256;
 	u32 i;
 
@@ -2434,8 +2439,8 @@ static int cake_config_diffserv8(struct Qdisc *sch)
 	for (i = 0; i < q->tin_cnt; i++) {
 		struct cake_tin_data *b = &q->tins[i];
 
-		cake_set_rate(b, rate, mtu, us_to_ns(q->target),
-			      us_to_ns(q->interval));
+		cake_set_rate(b, rate, mtu, us_to_ns(q->config->target),
+			      us_to_ns(q->config->interval));
 
 		b->tin_quantum = max_t(u16, 1U, quantum);
 
@@ -2464,7 +2469,7 @@ static int cake_config_diffserv4(struct Qdisc *sch)
 
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 4;
@@ -2475,13 +2480,13 @@ static int cake_config_diffserv4(struct Qdisc *sch)
 
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
@@ -2501,7 +2506,7 @@ static int cake_config_diffserv3(struct Qdisc *sch)
  */
 	struct cake_sched_data *q = qdisc_priv(sch);
 	u32 mtu = psched_mtu(qdisc_dev(sch));
-	u64 rate = q->rate_bps;
+	u64 rate = q->config->rate_bps;
 	u32 quantum = 1024;
 
 	q->tin_cnt = 3;
@@ -2512,11 +2517,11 @@ static int cake_config_diffserv3(struct Qdisc *sch)
 
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
@@ -2528,7 +2533,8 @@ static int cake_config_diffserv3(struct Qdisc *sch)
 
 static void cake_reconfigure(struct Qdisc *sch)
 {
-	struct cake_sched_data *q = qdisc_priv(sch);
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
 	int c, ft;
 
 	switch (q->tin_mode) {
@@ -2554,36 +2560,37 @@ static void cake_reconfigure(struct Qdisc *sch)
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
@@ -2637,19 +2644,19 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2705,7 +2712,7 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 
 	WRITE_ONCE(q->rate_flags, rate_flags);
 	WRITE_ONCE(q->flow_mode, flow_mode);
-	if (q->tins) {
+	if (qd->tins) {
 		sch_tree_lock(sch);
 		cake_reconfigure(sch);
 		sch_tree_unlock(sch);
@@ -2721,14 +2728,20 @@ static void cake_destroy(struct Qdisc *sch)
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
 
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		return -ENOMEM;
+
 	sch->limit = 10240;
 	sch->flags |= TCQ_F_DEQUEUE_DROPS;
 
@@ -2742,33 +2755,36 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2784,22 +2800,27 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
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


