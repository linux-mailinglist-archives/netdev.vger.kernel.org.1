Return-Path: <netdev+bounces-89018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632038A940E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1D6B22199
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C5274438;
	Thu, 18 Apr 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyfZ4nP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138A53E3F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425575; cv=none; b=ikaP+JWS7UBsalTAjaD+SftYkTxvVKbqyruzy9lKrnWURkBxhtBTPe8b/Dv40o82TStJGcseLcA2vtQUVUlL73J1rvw6OTQeoM4Lu57hM1wlHgx8QTrBCo1Sg9AHinoZDXqywz91vHsevzmKY3XGVHOdycS1QID1FbVL8a4wSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425575; c=relaxed/simple;
	bh=IQuUsn4nMzlTFL3vWlSTMlmnJgl7603HuASUWWjsFdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rl57mWZvWFfdSCRJv6ktXBa5obE3hU0h3YWWn8zpsW6DUnMR/9PMtqHXv12uKGHB3E2VuueP1oODeePU/HVJJ40a5SmE4/hpNNOMZiHj/wuydaD4Tx06urSrKOZwgI+IUIQUTWlE3bENI3fZheK00/D1M5flbZUxaSmnUCglOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyfZ4nP9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-619151db81cso22037957b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425572; x=1714030372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2SaESb7cjcGNnqko6JfoxSkcTvVz1ZvXGocgbM0jGY=;
        b=VyfZ4nP94kw0Zq7ggSbDQluQg2aVixYfMY45pZhUHUSC0DOS8nbFrQ5cDDPeKIFK8Y
         Gv7kpKXmRknTL0q98CknDYy7d+NUKAekWKMYazh8YrNhNJlYFcZ4IRNrOy2WHqdn5rTB
         dc2xaStPK4BdISVHHVuj9ZUqJsoa/cYbEj6Kny2HbDYwNGMWJgrAU/YVSLimxQDSk/l/
         dFDD9QtP4W9Tm30pC1PGl/bEQUCb0pOc4uCopTH2UCMee1NbBOw3y0T/Kg3Z4BMo84g/
         ENBvkP4eBBgZbeG3JBeDsGUYAsVABBAct8SInvojk61kuEQDD+2nfguSWrEiZgmw7xXI
         aVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425572; x=1714030372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2SaESb7cjcGNnqko6JfoxSkcTvVz1ZvXGocgbM0jGY=;
        b=pLR8wmk7vuvlPgVB0PqrO+sKG5HgnRd083gl4nZVWQwUA8MSw8TnIogb3CTcMrZda1
         6MP80Cjs5SwDBjxdQT6Jc+ScCzeDux85eRfArkCBdeDnrn+2nR08CecVIMs6aiyODi9g
         sUUcyPrWwXcB87X19e4LbCtksT/EZuG+4c1sueiK0Y9gCc8nRYXIeEK7+uigsn/LvXQI
         SkxKcPVpAt9fgh0xQYZAvqyguig74t23QmeLTi8ea6V8L3JpMwfd3WtmvlIKAzGbXu8y
         X+2zipd5c2C2rg7UCQTSLLoTNkPdElEI/Ll23LeDf6WCDRhIunhQi9enQ8f5gQQSF5rM
         bKlA==
X-Forwarded-Encrypted: i=1; AJvYcCVN+0MYN0JG1O8tKyL3EfN49KP8woakiw1hXFU3VQYxEpi0cCbUqgiS8zwby5sDFj/ckhMFrJq7f0JBQwa57zD7+d0dbdTs
X-Gm-Message-State: AOJu0YzzX4GtKgYqzTvbbYluM4F4KzkEELsrACNWRygjAobIjqG9/tbH
	sVPu8uODTyfyZv9rLsxRDI2A6D4aWTxox5Qyd9LfF3wRXcqCiA1GeSoI//24u6XvL3ohxTsaaTj
	gZehWeCbR/A==
X-Google-Smtp-Source: AGHT+IELWxuievh3jgzhP6kEuiZhbR/dkXBuKa4rSFjXxMltZa+HbCHuqbnbGIk1Xa64HjtwKhndPXh1tVKI0w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dda:c4ec:7db5 with SMTP
 id w1-20020a056902100100b00ddac4ec7db5mr449085ybt.4.1713425572518; Thu, 18
 Apr 2024 00:32:52 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:35 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/14] net_sched: sch_fq: implement lockless fq_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() in fq_change()

v2: Addressed Simon feedback in V1: https://lore.kernel.org/netdev/20240416181915.GT2320920@kernel.org/

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 108 +++++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 39 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index cdf23ff16f40bf244bb822e76016fde44e0c439b..238974725679327b0a0d483c011e15fc94ab0878 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -106,6 +106,8 @@ struct fq_perband_flows {
 	int		    quantum; /* based on band nr : 576KB, 192KB, 64KB */
 };
 
+#define FQ_PRIO2BAND_CRUMB_SIZE ((TC_PRIO_MAX + 1) >> 2)
+
 struct fq_sched_data {
 /* Read mostly cache line */
 
@@ -122,7 +124,7 @@ struct fq_sched_data {
 	u8		rate_enable;
 	u8		fq_trees_log;
 	u8		horizon_drop;
-	u8		prio2band[(TC_PRIO_MAX + 1) >> 2];
+	u8		prio2band[FQ_PRIO2BAND_CRUMB_SIZE];
 	u32		timer_slack; /* hrtimer slack in ns */
 
 /* Read/Write fields. */
@@ -159,7 +161,7 @@ struct fq_sched_data {
 /* return the i-th 2-bit value ("crumb") */
 static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
 {
-	return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
+	return (READ_ONCE(prio2band[prio / 4]) >> (2 * (prio & 0x3))) & 0x3;
 }
 
 /*
@@ -888,7 +890,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 		fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
 
 	q->fq_root = array;
-	q->fq_trees_log = log;
+	WRITE_ONCE(q->fq_trees_log, log);
 
 	sch_tree_unlock(sch);
 
@@ -927,11 +929,15 @@ static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
 static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
 {
 	const int num_elems = TC_PRIO_MAX + 1;
+	u8 tmp[FQ_PRIO2BAND_CRUMB_SIZE];
 	int i;
 
-	memset(out, 0, num_elems / 4);
+	memset(tmp, 0, sizeof(tmp));
 	for (i = 0; i < num_elems; i++)
-		out[i / 4] |= in[i] << (2 * (i & 0x3));
+		tmp[i / 4] |= in[i] << (2 * (i & 0x3));
+
+	for (i = 0; i < FQ_PRIO2BAND_CRUMB_SIZE; i++)
+		WRITE_ONCE(out[i], tmp[i]);
 }
 
 static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
@@ -958,7 +964,7 @@ static int fq_load_weights(struct fq_sched_data *q,
 		}
 	}
 	for (i = 0; i < FQ_BANDS; i++)
-		q->band_flows[i].quantum = weights[i];
+		WRITE_ONCE(q->band_flows[i].quantum, weights[i]);
 	return 0;
 }
 
@@ -1011,16 +1017,18 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 			err = -EINVAL;
 	}
 	if (tb[TCA_FQ_PLIMIT])
-		sch->limit = nla_get_u32(tb[TCA_FQ_PLIMIT]);
+		WRITE_ONCE(sch->limit,
+			   nla_get_u32(tb[TCA_FQ_PLIMIT]));
 
 	if (tb[TCA_FQ_FLOW_PLIMIT])
-		q->flow_plimit = nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]);
+		WRITE_ONCE(q->flow_plimit,
+			   nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
 
 	if (tb[TCA_FQ_QUANTUM]) {
 		u32 quantum = nla_get_u32(tb[TCA_FQ_QUANTUM]);
 
 		if (quantum > 0 && quantum <= (1 << 20)) {
-			q->quantum = quantum;
+			WRITE_ONCE(q->quantum, quantum);
 		} else {
 			NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 			err = -EINVAL;
@@ -1028,7 +1036,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	if (tb[TCA_FQ_INITIAL_QUANTUM])
-		q->initial_quantum = nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]);
+		WRITE_ONCE(q->initial_quantum,
+			   nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
 
 	if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
 		pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
@@ -1037,17 +1046,19 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_FLOW_MAX_RATE]) {
 		u32 rate = nla_get_u32(tb[TCA_FQ_FLOW_MAX_RATE]);
 
-		q->flow_max_rate = (rate == ~0U) ? ~0UL : rate;
+		WRITE_ONCE(q->flow_max_rate,
+			   (rate == ~0U) ? ~0UL : rate);
 	}
 	if (tb[TCA_FQ_LOW_RATE_THRESHOLD])
-		q->low_rate_threshold =
-			nla_get_u32(tb[TCA_FQ_LOW_RATE_THRESHOLD]);
+		WRITE_ONCE(q->low_rate_threshold,
+			   nla_get_u32(tb[TCA_FQ_LOW_RATE_THRESHOLD]));
 
 	if (tb[TCA_FQ_RATE_ENABLE]) {
 		u32 enable = nla_get_u32(tb[TCA_FQ_RATE_ENABLE]);
 
 		if (enable <= 1)
-			q->rate_enable = enable;
+			WRITE_ONCE(q->rate_enable,
+				   enable);
 		else
 			err = -EINVAL;
 	}
@@ -1055,7 +1066,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_FLOW_REFILL_DELAY]) {
 		u32 usecs_delay = nla_get_u32(tb[TCA_FQ_FLOW_REFILL_DELAY]) ;
 
-		q->flow_refill_delay = usecs_to_jiffies(usecs_delay);
+		WRITE_ONCE(q->flow_refill_delay,
+			   usecs_to_jiffies(usecs_delay));
 	}
 
 	if (!err && tb[TCA_FQ_PRIOMAP])
@@ -1065,21 +1077,26 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 		err = fq_load_weights(q, tb[TCA_FQ_WEIGHTS], extack);
 
 	if (tb[TCA_FQ_ORPHAN_MASK])
-		q->orphan_mask = nla_get_u32(tb[TCA_FQ_ORPHAN_MASK]);
+		WRITE_ONCE(q->orphan_mask,
+			   nla_get_u32(tb[TCA_FQ_ORPHAN_MASK]));
 
 	if (tb[TCA_FQ_CE_THRESHOLD])
-		q->ce_threshold = (u64)NSEC_PER_USEC *
-				  nla_get_u32(tb[TCA_FQ_CE_THRESHOLD]);
+		WRITE_ONCE(q->ce_threshold,
+			   (u64)NSEC_PER_USEC *
+			   nla_get_u32(tb[TCA_FQ_CE_THRESHOLD]));
 
 	if (tb[TCA_FQ_TIMER_SLACK])
-		q->timer_slack = nla_get_u32(tb[TCA_FQ_TIMER_SLACK]);
+		WRITE_ONCE(q->timer_slack,
+			   nla_get_u32(tb[TCA_FQ_TIMER_SLACK]));
 
 	if (tb[TCA_FQ_HORIZON])
-		q->horizon = (u64)NSEC_PER_USEC *
-				  nla_get_u32(tb[TCA_FQ_HORIZON]);
+		WRITE_ONCE(q->horizon,
+			   (u64)NSEC_PER_USEC *
+			   nla_get_u32(tb[TCA_FQ_HORIZON]));
 
 	if (tb[TCA_FQ_HORIZON_DROP])
-		q->horizon_drop = nla_get_u8(tb[TCA_FQ_HORIZON_DROP]);
+		WRITE_ONCE(q->horizon_drop,
+			   nla_get_u8(tb[TCA_FQ_HORIZON_DROP]));
 
 	if (!err) {
 
@@ -1160,13 +1177,13 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct fq_sched_data *q = qdisc_priv(sch);
-	u64 ce_threshold = q->ce_threshold;
 	struct tc_prio_qopt prio = {
 		.bands = FQ_BANDS,
 	};
-	u64 horizon = q->horizon;
 	struct nlattr *opts;
+	u64 ce_threshold;
 	s32 weights[3];
+	u64 horizon;
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (opts == NULL)
@@ -1174,35 +1191,48 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 	/* TCA_FQ_FLOW_DEFAULT_RATE is not used anymore */
 
+	ce_threshold = READ_ONCE(q->ce_threshold);
 	do_div(ce_threshold, NSEC_PER_USEC);
+
+	horizon = READ_ONCE(q->horizon);
 	do_div(horizon, NSEC_PER_USEC);
 
-	if (nla_put_u32(skb, TCA_FQ_PLIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT, q->flow_plimit) ||
-	    nla_put_u32(skb, TCA_FQ_QUANTUM, q->quantum) ||
-	    nla_put_u32(skb, TCA_FQ_INITIAL_QUANTUM, q->initial_quantum) ||
-	    nla_put_u32(skb, TCA_FQ_RATE_ENABLE, q->rate_enable) ||
+	if (nla_put_u32(skb, TCA_FQ_PLIMIT,
+			READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT,
+			READ_ONCE(q->flow_plimit)) ||
+	    nla_put_u32(skb, TCA_FQ_QUANTUM,
+			READ_ONCE(q->quantum)) ||
+	    nla_put_u32(skb, TCA_FQ_INITIAL_QUANTUM,
+			READ_ONCE(q->initial_quantum)) ||
+	    nla_put_u32(skb, TCA_FQ_RATE_ENABLE,
+			READ_ONCE(q->rate_enable)) ||
 	    nla_put_u32(skb, TCA_FQ_FLOW_MAX_RATE,
-			min_t(unsigned long, q->flow_max_rate, ~0U)) ||
+			min_t(unsigned long,
+			      READ_ONCE(q->flow_max_rate), ~0U)) ||
 	    nla_put_u32(skb, TCA_FQ_FLOW_REFILL_DELAY,
-			jiffies_to_usecs(q->flow_refill_delay)) ||
-	    nla_put_u32(skb, TCA_FQ_ORPHAN_MASK, q->orphan_mask) ||
+			jiffies_to_usecs(READ_ONCE(q->flow_refill_delay))) ||
+	    nla_put_u32(skb, TCA_FQ_ORPHAN_MASK,
+			READ_ONCE(q->orphan_mask)) ||
 	    nla_put_u32(skb, TCA_FQ_LOW_RATE_THRESHOLD,
-			q->low_rate_threshold) ||
+			READ_ONCE(q->low_rate_threshold)) ||
 	    nla_put_u32(skb, TCA_FQ_CE_THRESHOLD, (u32)ce_threshold) ||
-	    nla_put_u32(skb, TCA_FQ_BUCKETS_LOG, q->fq_trees_log) ||
-	    nla_put_u32(skb, TCA_FQ_TIMER_SLACK, q->timer_slack) ||
+	    nla_put_u32(skb, TCA_FQ_BUCKETS_LOG,
+			READ_ONCE(q->fq_trees_log)) ||
+	    nla_put_u32(skb, TCA_FQ_TIMER_SLACK,
+			READ_ONCE(q->timer_slack)) ||
 	    nla_put_u32(skb, TCA_FQ_HORIZON, (u32)horizon) ||
-	    nla_put_u8(skb, TCA_FQ_HORIZON_DROP, q->horizon_drop))
+	    nla_put_u8(skb, TCA_FQ_HORIZON_DROP,
+		       READ_ONCE(q->horizon_drop)))
 		goto nla_put_failure;
 
 	fq_prio2band_decompress_crumb(q->prio2band, prio.priomap);
 	if (nla_put(skb, TCA_FQ_PRIOMAP, sizeof(prio), &prio))
 		goto nla_put_failure;
 
-	weights[0] = q->band_flows[0].quantum;
-	weights[1] = q->band_flows[1].quantum;
-	weights[2] = q->band_flows[2].quantum;
+	weights[0] = READ_ONCE(q->band_flows[0].quantum);
+	weights[1] = READ_ONCE(q->band_flows[1].quantum);
+	weights[2] = READ_ONCE(q->band_flows[2].quantum);
 	if (nla_put(skb, TCA_FQ_WEIGHTS, sizeof(weights), &weights))
 		goto nla_put_failure;
 
-- 
2.44.0.683.g7961c838ac-goog


