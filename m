Return-Path: <netdev+bounces-247346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940DECF8208
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BF283062CC4
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E131C33343B;
	Tue,  6 Jan 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfPSPsTE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcFVq6cu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A28332ECD
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699665; cv=none; b=T0EWk/lAkAyVYGDaoMAfMeN5jwBb+k5aDJQhRtblB3P1AxM9siEhKFqlSr+Ywf+ZJ/2emTgUks/QtWhm/wSlx79X/LmP0ZXjvDzn0S0YZcSeLHGgtp285+1z7yQchcueiruamu/ys4sUVtjWEVsRGCjyFbWW5qfj/2AEiQisoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699665; c=relaxed/simple;
	bh=v1rnv6t3QRUajzmq3QcUxaCwcERV/JG6v9gtPeVD7N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TshHuQdFe8XHB5iDP0PPGVF8WnKMMcV1hqcjkhHdE/hsOHn3GMZYnBaW9Ff4jo9I+GzQ6ndfaUbvBqk1KjLMRqO6cI7yPvryKEeYBxyFWLz2Xc94AKSGaHtwravtBOgPdcxiAXCZDBGn5KxJ6Yg4m8g6UbwKo+gvqrFumImwLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfPSPsTE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcFVq6cu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
	b=UfPSPsTEiLthDojp+QWahWJVxjoI8IzbJ+0y0dC8zCWC14VoywgCqgLw6GDjqDIDkkMEOO
	lwP66FhqhfA1SRjyFPUWnl9YY1w7QNzYl1KfAsalrWUbkzfx8iFh/zq7Qz0iLwxwFy0AiV
	rBovMyQ0VR7Xd5LswZHYPHFdHfIzeXE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-R__TT_NdPBWN2msS-mTb4A-1; Tue, 06 Jan 2026 06:41:01 -0500
X-MC-Unique: R__TT_NdPBWN2msS-mTb4A-1
X-Mimecast-MFC-AGG-ID: R__TT_NdPBWN2msS-mTb4A_1767699661
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7fe37056e1so82332866b.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699660; x=1768304460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
        b=GcFVq6cud1toxIKs1RttnQn43qIYyqxpu8WR79zskbfsIJiaikAAzM7UyzmMcoCBLp
         zJN7sRM0ubFC9VyvoGVZTcW6E/S0sN+DDYKo6yhrN+sH7F9hkNRjBt1jO8HX9qvqTG/X
         PdUGeui85DEjCYSIBZjq3K4qn1bK+6na4wh9QeWWHwhRvhRUq/IgGzWNgeElf3kocbvi
         TY8pgAhXDvTf3UrS5QTSJ+NxnSHOh9z9aglpPXgg/oYDwAwYnMXJF8e5/EnAdXAnd6mG
         zuTHAouMwAzhvG6UZfnnFLu29UzuTObJ9HzjVG+AHj8c7YDiQSQMD8UOE4mo9+BW87xK
         wGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699660; x=1768304460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
        b=qUI0WksyItitCPbcPg/r637M62cRiDG9bpSJVNvSM5vWpRY+sQvPxKukGGqrNkBIC4
         BztTbXBEjNxF6k1uHgvx9yc7vqG8KI1LTmw8cJNkEwdgxbZ+VM+xXM2Jfkof/7Dnyh4W
         s5w0Rzxrp05HY9xTczSMUG7lCuqkOlc6NVJLqkcmUjAlQCI/I+ETjJd7ASp1O2Muw1vt
         UjNMuiBw8hxj85KkdVNKZIkGzpfUN1Atv3Xz/tZjWqKAEu1ZK6Uy/zsqeSIKyDMxJgUH
         QVHkijscfhDIB9CH3RYHVLd9AOCPwhLoF3ekWO2G2qbFqzY4dqb5XbQfOTMZwFl125Ou
         OcSg==
X-Forwarded-Encrypted: i=1; AJvYcCUapJizOAlX4A786ZCZcsvMx/FFbGG3mVnq4OQknJcfqm3kd/S5Kb0eabuDKkJOaw89MhlakRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0P7YWJ5uIGmuDpRuvGnNBIOVFWmy/xJ8+jrRk78/+y7ayg7E
	w0riEwbq2veR84WmhPFUA5JpzGioxUbS5gLGEdI0PCn/bm9G8MbQaW8kldlJ8s3BbOTVx2RjNhG
	dGAWlR825y07jcRY262NjRX9OpVGgiJcEi/K97GSWN1g5x+91ZtVecpM42w==
X-Gm-Gg: AY/fxX4LHREWU0Nr2G4ZiZz9ZLGNYFJ2JDdpmvA4CvpcvuuMtqES6YnR246asxxMtSc
	Evdd3Uh/HIIdwHZ7gFd3stbFqwCEq74h+AbF144slRcgotxxaifGwbaMhLuSUUVWsqwLVf7dQIo
	zTNOo7V7jLZFcb1Y0Odh4jUXP/4d2DYaikB/ZA/IDc96Pwi/wOm0xk33T+NQiMGlNSauO3PmaaB
	Lbx3nIvu1C6UMdLWakWpx6pR2szgVTXUQqOo3wHuj5sSXPC4NwDWSQBhbdl0Swf/uxRfPT41nfD
	7C3M0/ZRX1b0TPSM5wx3ZUMgq2omn65rEzgx3aewu3hzE7/d5Tz7RZoq5AKWVBV2Zg9i+Y5i96T
	9o/4rjJtzUxnCoz7XYM7q5dwgcOOC6/o6tw==
X-Received: by 2002:a17:907:3c88:b0:b7d:1a23:81a0 with SMTP id a640c23a62f3a-b8426c5e0cbmr281626266b.63.1767699660426;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqc2ZUA7ffnIas7sIbpAVh0QpbdglplTiA6dBGe5XgEBebCQVTV+RC2PutuhS7FLnrRRryCA==
X-Received: by 2002:a17:907:3c88:b0:b7d:1a23:81a0 with SMTP id a640c23a62f3a-b8426c5e0cbmr281622766b.63.1767699659960;
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a233ef3sm209941666b.1.2026.01.06.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B4B52407FD4; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 06 Jan 2026 12:40:55 +0100
Subject: [PATCH net-next v6 4/6] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-mq-cake-sub-qdisc-v6-4-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

This adds support for configuring the cake_mq instance directly, sharing
the config across the cake sub-qdiscs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 173 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 133 insertions(+), 40 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index fa01c352f5a5..f9dafa687950 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -212,6 +212,7 @@ struct cake_sched_config {
 	u8		flow_mode;
 	u8		atm_mode;
 	u8		ack_filter;
+	u8		is_shared;
 };
 
 struct cake_sched_data {
@@ -2587,14 +2588,12 @@ static void cake_reconfigure(struct Qdisc *sch)
 				   q->buffer_config_limit));
 }
 
-static int cake_change(struct Qdisc *sch, struct nlattr *opt,
-		       struct netlink_ext_ack *extack)
+static int cake_config_change(struct cake_sched_config *q, struct nlattr *opt,
+			      struct netlink_ext_ack *extack, bool *overhead_changed)
 {
-	struct cake_sched_data *qd = qdisc_priv(sch);
-	struct cake_sched_config *q = qd->config;
 	struct nlattr *tb[TCA_CAKE_MAX + 1];
-	u16 rate_flags;
-	u8 flow_mode;
+	u16 rate_flags = q->rate_flags;
+	u8 flow_mode = q->flow_mode;
 	int err;
 
 	err = nla_parse_nested_deprecated(tb, TCA_CAKE_MAX, opt, cake_policy,
@@ -2602,7 +2601,6 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 	if (err < 0)
 		return err;
 
-	flow_mode = q->flow_mode;
 	if (tb[TCA_CAKE_NAT]) {
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 		flow_mode &= ~CAKE_FLOW_NAT_FLAG;
@@ -2615,6 +2613,19 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 #endif
 	}
 
+	if (tb[TCA_CAKE_AUTORATE]) {
+		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE])) {
+			if (q->is_shared) {
+				NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_NAT],
+						    "Can't use autorate-ingress with cake_mq");
+				return -EOPNOTSUPP;
+			}
+			rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
+		} else {
+			rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
+		}
+	}
+
 	if (tb[TCA_CAKE_BASE_RATE64])
 		WRITE_ONCE(q->rate_bps,
 			   nla_get_u64(tb[TCA_CAKE_BASE_RATE64]));
@@ -2623,7 +2634,6 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->tin_mode,
 			   nla_get_u32(tb[TCA_CAKE_DIFFSERV_MODE]));
 
-	rate_flags = q->rate_flags;
 	if (tb[TCA_CAKE_WASH]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_WASH]))
 			rate_flags |= CAKE_FLAG_WASH;
@@ -2644,20 +2654,12 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->rate_overhead,
 			   nla_get_s32(tb[TCA_CAKE_OVERHEAD]));
 		rate_flags |= CAKE_FLAG_OVERHEAD;
-
-		qd->max_netlen = 0;
-		qd->max_adjlen = 0;
-		qd->min_netlen = ~0;
-		qd->min_adjlen = ~0;
+		*overhead_changed = true;
 	}
 
 	if (tb[TCA_CAKE_RAW]) {
 		rate_flags &= ~CAKE_FLAG_OVERHEAD;
-
-		qd->max_netlen = 0;
-		qd->max_adjlen = 0;
-		qd->min_netlen = ~0;
-		qd->min_adjlen = ~0;
+		*overhead_changed = true;
 	}
 
 	if (tb[TCA_CAKE_MPU])
@@ -2676,13 +2678,6 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->target, max(target, 1U));
 	}
 
-	if (tb[TCA_CAKE_AUTORATE]) {
-		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE]))
-			rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
-		else
-			rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
-	}
-
 	if (tb[TCA_CAKE_INGRESS]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_INGRESS]))
 			rate_flags |= CAKE_FLAG_INGRESS;
@@ -2713,6 +2708,34 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 
 	WRITE_ONCE(q->rate_flags, rate_flags);
 	WRITE_ONCE(q->flow_mode, flow_mode);
+
+	return 0;
+}
+
+static int cake_change(struct Qdisc *sch, struct nlattr *opt,
+		       struct netlink_ext_ack *extack)
+{
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
+	bool overhead_changed = false;
+	int ret;
+
+	if (q->is_shared) {
+		NL_SET_ERR_MSG(extack, "can't reconfigure cake_mq sub-qdiscs");
+		return -EOPNOTSUPP;
+	}
+
+	ret = cake_config_change(q, opt, extack, &overhead_changed);
+	if (ret)
+		return ret;
+
+	if (overhead_changed) {
+		qd->max_netlen = 0;
+		qd->max_adjlen = 0;
+		qd->min_netlen = ~0;
+		qd->min_adjlen = ~0;
+	}
+
 	if (qd->tins) {
 		sch_tree_lock(sch);
 		cake_reconfigure(sch);
@@ -2729,7 +2752,23 @@ static void cake_destroy(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 	tcf_block_put(q->block);
 	kvfree(q->tins);
-	kvfree(q->config);
+	if (q->config && !q->config->is_shared)
+		kvfree(q->config);
+}
+
+static void cake_config_init(struct cake_sched_config *q, bool is_shared)
+{
+	q->tin_mode = CAKE_DIFFSERV_DIFFSERV3;
+	q->flow_mode  = CAKE_FLOW_TRIPLE;
+
+	q->rate_bps = 0; /* unlimited by default */
+
+	q->interval = 100000; /* 100ms default */
+	q->target   =   5000; /* 5ms: codel RFC argues
+			       * for 5 to 10% of interval
+			       */
+	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
+	q->is_shared = is_shared;
 }
 
 static int cake_init(struct Qdisc *sch, struct nlattr *opt,
@@ -2743,19 +2782,11 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	if (!q)
 		return -ENOMEM;
 
+	cake_config_init(q, false);
+
 	sch->limit = 10240;
 	sch->flags |= TCQ_F_DEQUEUE_DROPS;
 
-	q->tin_mode = CAKE_DIFFSERV_DIFFSERV3;
-	q->flow_mode  = CAKE_FLOW_TRIPLE;
-
-	q->rate_bps = 0; /* unlimited by default */
-
-	q->interval = 100000; /* 100ms default */
-	q->target   =   5000; /* 5ms: codel RFC argues
-			       * for 5 to 10% of interval
-			       */
-	q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
 	qd->cur_tin = 0;
 	qd->cur_flow  = 0;
 	qd->config = q;
@@ -2818,10 +2849,21 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	return err;
 }
 
-static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
+static void cake_config_replace(struct Qdisc *sch, struct cake_sched_config *cfg)
 {
 	struct cake_sched_data *qd = qdisc_priv(sch);
 	struct cake_sched_config *q = qd->config;
+
+	qd->config = cfg;
+
+	if (!q->is_shared)
+		kvfree(q);
+
+	cake_reconfigure(sch);
+}
+
+static int cake_config_dump(struct cake_sched_config *q, struct sk_buff *skb)
+{
 	struct nlattr *opts;
 	u16 rate_flags;
 	u8 flow_mode;
@@ -2897,6 +2939,13 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
 	return -1;
 }
 
+static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct cake_sched_data *qd = qdisc_priv(sch);
+
+	return cake_config_dump(qd->config, skb);
+}
+
 static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct nlattr *stats = nla_nest_start_noflag(d->skb, TCA_STATS_APP);
@@ -3160,6 +3209,7 @@ MODULE_ALIAS_NET_SCH("cake");
 
 struct cake_mq_sched {
 	struct mq_sched mq_priv; /* must be first */
+	struct cake_sched_config cake_config;
 };
 
 static void cake_mq_destroy(struct Qdisc *sch)
@@ -3170,25 +3220,68 @@ static void cake_mq_destroy(struct Qdisc *sch)
 static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
 {
-	int ret;
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	int ret, ntx;
+	bool _unused;
+
+	cake_config_init(&priv->cake_config, true);
+	if (opt) {
+		ret = cake_config_change(&priv->cake_config, opt, extack, &_unused);
+		if (ret)
+			return ret;
+	}
 
 	ret = mq_init_common(sch, opt, extack, &cake_qdisc_ops);
 	if (ret)
 		return ret;
 
+	for (ntx = 0; ntx < dev->num_tx_queues; ntx++)
+		cake_config_replace(priv->mq_priv.qdiscs[ntx], &priv->cake_config);
+
 	return 0;
 }
 
 static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+
 	mq_dump_common(sch, skb);
-	return 0;
+	return cake_config_dump(&priv->cake_config, skb);
 }
 
 static int cake_mq_change(struct Qdisc *sch, struct nlattr *opt,
 			  struct netlink_ext_ack *extack)
 {
-	return -EOPNOTSUPP;
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	bool overhead_changed = false;
+	unsigned int ntx;
+	int ret;
+
+	ret = cake_config_change(&priv->cake_config, opt, extack, &overhead_changed);
+	if (ret)
+		return ret;
+
+	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+		struct Qdisc *chld = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
+		struct cake_sched_data *qd = qdisc_priv(chld);
+
+		if (overhead_changed) {
+			qd->max_netlen = 0;
+			qd->max_adjlen = 0;
+			qd->min_netlen = ~0;
+			qd->min_adjlen = ~0;
+		}
+
+		if (qd->tins) {
+			sch_tree_lock(chld);
+			cake_reconfigure(chld);
+			sch_tree_unlock(chld);
+		}
+	}
+
+	return 0;
 }
 
 static int cake_mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,

-- 
2.52.0


