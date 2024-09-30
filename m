Return-Path: <netdev+bounces-130441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F998A864
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82911F2436B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEF1925A4;
	Mon, 30 Sep 2024 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hdf83YUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF111925AE
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709792; cv=none; b=HNhC1PuZbRSqRPtH3jsHzNgfiJY6iETUeAKksdcVi1aw5+iGYAIHbzbaRlZ9YqRBnzqvo2dMRUmAxkeFgwOLmsdO8gYbNwbGLzONbZ/XU+OOgBFhHKl0P8JV4X5SIT3yAZ9oIDeM+9vvzp4yhWTsyP2mcDoasssr+i7hrdLaCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709792; c=relaxed/simple;
	bh=mzEfKQmt6notCn3epd2JKCPphT7acczRFu8GSBLPEPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iclZHKbx6ViY/JcsxpEm+7kHWblIPejzWgYdH6YFE0ViFoOCGlRwLLPSScszwh2KeYNwdncq0Kw5e0ORr3HUYOM0MOcd9SqSIbAMG4FlZFdgurxnldN9cRd/lBhMvi21dlpLNlOgRMF606w1Lj8+1nupcMl5p5QX3dTiBD7HwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hdf83YUN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2317d1cb7so73439627b3.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727709790; x=1728314590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VadFNHGIKgjBU74RWi+NnOK/5x4U2WIpi7bz2W5MLjA=;
        b=Hdf83YUNDAm1r5E1qRsGsNVvDi9ghIyje0pENDDNC/DKAogdgoTEFxSWGKtFogJt5P
         y+N5y+b8tUhrmvYiG/nnGeN5aq79h6F7aCaEcQDtESD1o2dwywiKMD1nBDqfRlZEGz7E
         48zRvsPHleZH3wKZ6yXxOFEySXQe7aSEVl+ak3ZMsy+68wMzQ9eDTMF14/2Dj1P5MzxO
         ju9jiSU7R2Z9zWTJO4Q9/3MApcPpcCgissPieqG7fprkwTHiTY3teNftbbB0U8VcM4dH
         hDm1u+Q+E0UnApToJNQO2SnHZ0SAp4CmFOhU2eMmDWFsdX5YZpjfVYID7vq3fIZPqWdl
         qhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727709790; x=1728314590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VadFNHGIKgjBU74RWi+NnOK/5x4U2WIpi7bz2W5MLjA=;
        b=oONd824p1vnNexOfF/rFn0WUUOs16rQXd5CuZr98kHrZUNQSmxulaBaiTbrFKM4QtD
         usOMyMtM4vBdg+wGtOd8r07NrHKjID48cy/PYxMtMI0foltTiDNUZJGsFke13T72Teir
         7YNFS9q5WE4vg2k57prLHZnhm67obZJV4Xak4kZoPOvZizRfCgi4HnpFBQnz0fPrjC3Y
         j8ToeWlHEYxGgHkHoNYN6h7rpz2/YViUs+FSoZn1zBLG2dn1NCAmxehzlbxGYS7/0gn9
         oCCflu8ihF4AKuNTKkLBz7OqB4lFWrEfuc+QgUaa0b9tFnIXnmPK7b6QWuUZz9w161/h
         B4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV04S/foNVOBYkipock711ohyVAGwV6ETSfm1SsVNW2gCQUSmoU4QoDH0WqirE1Jvl5HqpJnJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGiBltHtbV/Ni2bHJEt5w75hRnccrlP9UIYtQT99eYMMixqEm/
	8NOpdn6Pothle1kmSfEopGuEVKO6WPre9TaX5GMlxx1ttOiBLhnucd5Iyj3COmwy/8qli9SOyu1
	OiBEuBINX4g==
X-Google-Smtp-Source: AGHT+IExtZkpHTjYJaA02ecdd8sEOPqncKpmn6DDNrVEzf09vvYxdBwlb8Y1PY3BTc9lT7biIzGHnH/4F7fo4g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:6303:b0:6e2:1b8c:39bf with SMTP
 id 00721157ae682-6e2474ca383mr623757b3.2.1727709789480; Mon, 30 Sep 2024
 08:23:09 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:23:04 +0000
In-Reply-To: <20240930152304.472767-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240930152304.472767-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240930152304.472767-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] net_sched: sch_fq: add the ability to offload pacing
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jeffrey Ji <jeffreyji@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jeffrey Ji <jeffreyji@google.com>

Some network devices have the ability to offload EDT (Earliest
Departure Time) which is the model used for TCP pacing and FQ packet
scheduler.

Some of them implement the timing wheel mechanism described in
https://saeed.github.io/files/carousel-sigcomm17.pdf
with an associated 'timing wheel horizon'.

This patchs adds to FQ packet scheduler TCA_FQ_OFFLOAD_HORIZON
attribute.

Its value is capped by the device max_pacing_offload_horizon,
added in the prior patch.

It allows FQ to let packets within pacing offload horizon
to be delivered to the device, which will handle the needed
delay without host involvement.

Signed-off-by: Jeffrey Ji <jeffreyji@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/pkt_sched.h |  2 ++
 net/sched/sch_fq.c             | 33 +++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index a3cd0c2dc9956f8c873f35c7b33b2bcf93feb2f1..25a9a47001cdde59cf052ea658ba1ac26f4c34e8 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -836,6 +836,8 @@ enum {
 
 	TCA_FQ_WEIGHTS,		/* Weights for each band */
 
+	TCA_FQ_OFFLOAD_HORIZON, /* dequeue paced packets within this horizon immediately (us units) */
+
 	__TCA_FQ_MAX
 };
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 19a49af5a9e527ed0371a3bb96e0113755375eac..aeabf45c9200c4aea75fb6c63986e37eddfea5f9 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -111,6 +111,7 @@ struct fq_perband_flows {
 struct fq_sched_data {
 /* Read mostly cache line */
 
+	u64		offload_horizon;
 	u32		quantum;
 	u32		initial_quantum;
 	u32		flow_refill_delay;
@@ -299,7 +300,7 @@ static void fq_gc(struct fq_sched_data *q,
 }
 
 /* Fast path can be used if :
- * 1) Packet tstamp is in the past.
+ * 1) Packet tstamp is in the past, or within the pacing offload horizon.
  * 2) FQ qlen == 0   OR
  *   (no flow is currently eligible for transmit,
  *    AND fast path queue has less than 8 packets)
@@ -314,7 +315,7 @@ static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
 	const struct fq_sched_data *q = qdisc_priv(sch);
 	const struct sock *sk;
 
-	if (fq_skb_cb(skb)->time_to_send > now)
+	if (fq_skb_cb(skb)->time_to_send > now + q->offload_horizon)
 		return false;
 
 	if (sch->q.qlen != 0) {
@@ -595,15 +596,18 @@ static void fq_check_throttled(struct fq_sched_data *q, u64 now)
 	unsigned long sample;
 	struct rb_node *p;
 
-	if (q->time_next_delayed_flow > now)
+	if (q->time_next_delayed_flow > now + q->offload_horizon)
 		return;
 
 	/* Update unthrottle latency EWMA.
 	 * This is cheap and can help diagnosing timer/latency problems.
 	 */
 	sample = (unsigned long)(now - q->time_next_delayed_flow);
-	q->unthrottle_latency_ns -= q->unthrottle_latency_ns >> 3;
-	q->unthrottle_latency_ns += sample >> 3;
+	if ((long)sample > 0) {
+		q->unthrottle_latency_ns -= q->unthrottle_latency_ns >> 3;
+		q->unthrottle_latency_ns += sample >> 3;
+	}
+	now += q->offload_horizon;
 
 	q->time_next_delayed_flow = ~0ULL;
 	while ((p = rb_first(&q->delayed)) != NULL) {
@@ -687,7 +691,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
 					     f->time_next_packet);
 
-		if (now < time_next_packet) {
+		if (now + q->offload_horizon < time_next_packet) {
 			head->first = f->next;
 			f->time_next_packet = time_next_packet;
 			fq_flow_set_throttled(q, f);
@@ -925,6 +929,7 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 	[TCA_FQ_HORIZON_DROP]		= { .type = NLA_U8 },
 	[TCA_FQ_PRIOMAP]		= NLA_POLICY_EXACT_LEN(sizeof(struct tc_prio_qopt)),
 	[TCA_FQ_WEIGHTS]		= NLA_POLICY_EXACT_LEN(FQ_BANDS * sizeof(s32)),
+	[TCA_FQ_OFFLOAD_HORIZON]	= { .type = NLA_U32 },
 };
 
 /* compress a u8 array with all elems <= 3 to an array of 2-bit fields */
@@ -1100,6 +1105,17 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->horizon_drop,
 			   nla_get_u8(tb[TCA_FQ_HORIZON_DROP]));
 
+	if (tb[TCA_FQ_OFFLOAD_HORIZON]) {
+		u64 offload_horizon = (u64)NSEC_PER_USEC *
+				      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
+
+		if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+			WRITE_ONCE(q->offload_horizon, offload_horizon);
+		} else {
+			NL_SET_ERR_MSG_MOD(extack, "invalid offload_horizon");
+			err = -EINVAL;
+		}
+	}
 	if (!err) {
 
 		sch_tree_unlock(sch);
@@ -1183,6 +1199,7 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 		.bands = FQ_BANDS,
 	};
 	struct nlattr *opts;
+	u64 offload_horizon;
 	u64 ce_threshold;
 	s32 weights[3];
 	u64 horizon;
@@ -1199,6 +1216,9 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	horizon = READ_ONCE(q->horizon);
 	do_div(horizon, NSEC_PER_USEC);
 
+	offload_horizon = READ_ONCE(q->offload_horizon);
+	do_div(offload_horizon, NSEC_PER_USEC);
+
 	if (nla_put_u32(skb, TCA_FQ_PLIMIT,
 			READ_ONCE(sch->limit)) ||
 	    nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT,
@@ -1224,6 +1244,7 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 	    nla_put_u32(skb, TCA_FQ_TIMER_SLACK,
 			READ_ONCE(q->timer_slack)) ||
 	    nla_put_u32(skb, TCA_FQ_HORIZON, (u32)horizon) ||
+	    nla_put_u32(skb, TCA_FQ_OFFLOAD_HORIZON, (u32)offload_horizon) ||
 	    nla_put_u8(skb, TCA_FQ_HORIZON_DROP,
 		       READ_ONCE(q->horizon_drop)))
 		goto nla_put_failure;
-- 
2.46.1.824.gd892dcdcdd-goog


