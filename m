Return-Path: <netdev+bounces-131583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1604298EEE0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B660B2845EC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE116F8E7;
	Thu,  3 Oct 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wfg/eFbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAE15E5D3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957646; cv=none; b=iAYnNJWvMUWDqpV+0nlVydn3GBD+0J8g/cPYlx2gy5q9rNZLol4KsoKj1uhd3o4eh6qkcpk1mxOHbOapY43/qrkNz8q1oHn+BsAJ82wa4Znf5Fb1RQD96uPPEgvQTT/1J38alHXFtbrV4zJtjbprmCiqEYWEWbwn50QcZ3dl0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957646; c=relaxed/simple;
	bh=AncprWEof2hwq0HnK++6ip6NNJf3Aj1gDghvwLKxX5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJ7tSZVG2N5axRraZw9NJcHlU/p+wM83h5rSSxSTHhv7vujjgPWKmwDmJ9QzFHC9XcWi86A+tKNqxUnLXDyA8QUxNiWaAEshmsstPIrwbcia+u385IwLIAKFVziRKylJySgDy+2e0VeIqvuEEi/JyLINTOg2Efo52W7MnUgXgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wfg/eFbq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso1237150276.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727957644; x=1728562444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Z8fOSuteP0PDTcznKk1Sa/tDIYCoJPSpvvEtRHIPk=;
        b=Wfg/eFbqXMZt+NNN+JTUvHcSxH2Hq3iLE7SwD2qb+NamJqx4bcBRCTLdvywoYvbetW
         xtskhYAfcRLOHUI9NnjSbYlMwbPkvYTD1CUUHWdVAgvrnuHQNaFDbox5++q+/663XkxN
         Knu0Dzdb8CE8IEMhu6j2OTv1NSEqhQUMg82ogsiK/pK+PEJNteffiBKmiNXNmFdhVjkt
         en8QA9o1wiQtDT+naAk7dgdZnK6HctFhEIOJ+QP8ir/Hyy1vsVv0ezivhBDBmu66lIWh
         C9WueEvDz1f5FZOa1DPdi3chyz/OvA0OlI4omFlelvBIRHRBViFHdfPwXL+6MEOUggrG
         04Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957644; x=1728562444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Z8fOSuteP0PDTcznKk1Sa/tDIYCoJPSpvvEtRHIPk=;
        b=p7SxERmktcd6BEClnAVv642x1mql+DzP0UlPpg+eEOgu0sUoONK/g0cDP0qRkdjcq4
         z+mxq/FhgWCUUuuvj0cyD11Xb+BqmcATTCHKKfBqFytugqNBYLM9z+bJ9VSX47DPoH1G
         OoNZvZ5T3MeC281Nb5F+yEQZj8Fz3IjN3LZLUZxxStAtqHjGl2ccSxEjQz8sPE7/lsL9
         z53dNpon4i4XoIQnwMK5nFx4vD9y2mrpQnBl9ZPmMxfmjgN/B8z/nKUpk0jXRhh3e9S4
         /6xPkY+E9Sn/Uc4wsvPfkaqOEbwNXcTvwWl4/lASGl0SpbBmJgpnFySKrzQganAeNq5o
         3pNw==
X-Gm-Message-State: AOJu0YxckDE4exMbTJDCRFw0B/gzPt/lJzZeVsAoEWe/EIdAtSR6flBD
	W68jExlQTsIo65jxLMpFVOAum6kZ/mGjZgYAm2NwEEyVSSlkxHOkjL0yP3voE10nb+5lehMaB7h
	xd0y7FRPzoQ==
X-Google-Smtp-Source: AGHT+IHAhoo09IPNETB2+lUkIkNCDgNnVfT94BJlDHNWOuZTEGcBV7wxteeoIlGLjDln9ddU2/c5quAH/ytSQw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:8502:0:b0:e24:9584:52d3 with SMTP id
 3f1490d57ef6-e26383805a5mr21326276.2.1727957644075; Thu, 03 Oct 2024 05:14:04
 -0700 (PDT)
Date: Thu,  3 Oct 2024 12:12:19 +0000
In-Reply-To: <20241003121219.2396589-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003121219.2396589-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003121219.2396589-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/2] net_sched: sch_fq: add the ability to offload pacing
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jeffrey Ji <jeffreyji@google.com>, 
	Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog


