Return-Path: <netdev+bounces-87948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB88A5144
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFCA1C221C5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4EF82885;
	Mon, 15 Apr 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+Jbm2U5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E37602F
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187260; cv=none; b=TmhZ97fKGo7ScXTMCKytgQGjwTfT1TmPPnJiMh4fm78npQHqlDYtGU2HqZA/8DUJRg3CpmbQDUdbKAAr/76laWaHiNFGCgQ5fXWdbHzCK88i/HqgxSnEj+Cq9AlfpaoWBtLtm9FQ4iBuQFfTCXCaujKkd4tnLZkcGxr8KnodRsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187260; c=relaxed/simple;
	bh=1LrVvpHwl5Q0OP6teAGVGyCBH2+nTLW0svqDJN2z3ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kel8zXniZbl6UgioIPF/tGmtumkkt86+oyMoqepPuqEVLTgQPyNTYctNEPN6IvwGjh0Kt/vvFxvHbej/9fnfCT8c/mFkShufiMl2XZTsWZJvz1tu2oImo2r65Mf+AzGUraQz9+cdt+zNZT0kScbUEqSN/apsBZ9pXiPB2iNsVio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+Jbm2U5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso4561281276.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187257; x=1713792057; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY8WWl883t9Zpst/1rwsXwHEeahEKmKW1hgRm0oxIEg=;
        b=K+Jbm2U59lkLiU2xlBZDSkrt9iqvK1NBIRoEm/lSF4znhvvMKXwUdAeaY77iAv7rOQ
         yoKgWWtc8F1MbInM9M6PxaBjDspiNXd+moQr5WKaunRgXvm0gpzw8q8XSVjU9tUTKx+v
         LZb3fXjSqCdVkbFzK5HvkSsQBDfCOQ3f+oVxgrvdHMnkXrur9FX49GsgZpbUB6WPCCCo
         Dce2aVTmNaCnA5EzYu8WeUG7AYTYDVzjoaA+d8zxofm1rSJjqTBYTfVz1hOORrH6YWsw
         RDuLkfocQUWdOhpL63KG9TKwvDu27LZhKOi7DMA0RCgD/UbqOzY1C9k2GZwEdJzLFAil
         /eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187257; x=1713792057;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY8WWl883t9Zpst/1rwsXwHEeahEKmKW1hgRm0oxIEg=;
        b=HldmFpfN0QTt3MgD6mn6fLdL6K9wfPNn425SjkkFjTUmw7Gp+UTt+Q/86eOSN9r5K2
         sOag5gGuzxY0sxRS6P5E5k1IoF2PgTH4Ij+qhecEfF1s517RiziiBCt41QJ3eDs0FMSr
         G7NBn7YtjqPA44Dk109F5SZyfx4ZRjrOSuu3oSEm5bNSNiCAu0NE2J88uz6h1bDFxAhz
         9tADKHwHb+EacnMTe+5/gVIx0HahkQq941DGIHYKo3f3tnF1O9t1peRtMWPdJpl0Kypg
         U1KNeRtdLnJuoH6cYjboHV+sam87JTTVszGk18MFMJkWwJ584dVqrAjB5lgp5isJzhob
         00CA==
X-Forwarded-Encrypted: i=1; AJvYcCXuk1L558Vgmw3arUDtOg6dzwi+n1LRRXiRU/EaQYr99zWNmqj4DCYRoJGn8wLb7+0O0dHNKxjUfwGzYT5Nhqr2mCHMkl+R
X-Gm-Message-State: AOJu0YyEHpBKAae8wK/v+fQn3PUxa/UL8tDIFT7n1846Nc5xdFWVmshn
	3qx3uASEHb9Ut6IDHETgmr4IrFY7S7bqh+0GRPcKy56JEIkfiHiVpLZqYeCDMHULzmO24r/+zX3
	R6JFFyS3QKQ==
X-Google-Smtp-Source: AGHT+IG/7selW0iwrDbacMDjCw53546axoiRed8maGMXnhKDe1WA/x3C/hkTu52vHtUpR2uUGtDDR1npB/c/uQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:114c:b0:dcc:8be2:7cb0 with SMTP
 id p12-20020a056902114c00b00dcc8be27cb0mr1174214ybu.0.1713187257451; Mon, 15
 Apr 2024 06:20:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:41 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-2-edumazet@google.com>
Subject: [PATCH net-next 01/14] net_sched: sch_fq: implement lockless fq_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() in fq_change()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 96 +++++++++++++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 36 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index cdf23ff16f40bf244bb822e76016fde44e0c439b..934c220b3f4336dc2f70af74d7758218492b675d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -888,7 +888,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 		fq_rehash(q, old_fq_root, q->fq_trees_log, array, log);
 
 	q->fq_root = array;
-	q->fq_trees_log = log;
+	WRITE_ONCE(q->fq_trees_log, log);
 
 	sch_tree_unlock(sch);
 
@@ -931,7 +931,7 @@ static void fq_prio2band_compress_crumb(const u8 *in, u8 *out)
 
 	memset(out, 0, num_elems / 4);
 	for (i = 0; i < num_elems; i++)
-		out[i / 4] |= in[i] << (2 * (i & 0x3));
+		out[i / 4] |= READ_ONCE(in[i]) << (2 * (i & 0x3));
 }
 
 static void fq_prio2band_decompress_crumb(const u8 *in, u8 *out)
@@ -958,7 +958,7 @@ static int fq_load_weights(struct fq_sched_data *q,
 		}
 	}
 	for (i = 0; i < FQ_BANDS; i++)
-		q->band_flows[i].quantum = weights[i];
+		WRITE_ONCE(q->band_flows[i].quantum, weights[i]);
 	return 0;
 }
 
@@ -1011,16 +1011,18 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1028,7 +1030,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	if (tb[TCA_FQ_INITIAL_QUANTUM])
-		q->initial_quantum = nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]);
+		WRITE_ONCE(q->initial_quantum,
+			   nla_get_u32(tb[TCA_FQ_INITIAL_QUANTUM]));
 
 	if (tb[TCA_FQ_FLOW_DEFAULT_RATE])
 		pr_warn_ratelimited("sch_fq: defrate %u ignored.\n",
@@ -1037,17 +1040,19 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1055,7 +1060,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_FLOW_REFILL_DELAY]) {
 		u32 usecs_delay = nla_get_u32(tb[TCA_FQ_FLOW_REFILL_DELAY]) ;
 
-		q->flow_refill_delay = usecs_to_jiffies(usecs_delay);
+		WRITE_ONCE(q->flow_refill_delay,
+			   usecs_to_jiffies(usecs_delay));
 	}
 
 	if (!err && tb[TCA_FQ_PRIOMAP])
@@ -1065,21 +1071,26 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
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
 
@@ -1160,13 +1171,13 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -1174,35 +1185,48 @@ static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
 
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


