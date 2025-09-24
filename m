Return-Path: <netdev+bounces-225950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F7B99CB9
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8C16EDEC
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5794301473;
	Wed, 24 Sep 2025 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doj3xhPI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFE1922F6
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716200; cv=none; b=TKGzBbKx65J0fdemVPqUSki4SjJT1Z1lEPaWwqtWTSsz6q5PDkaS8wlwTvs0zZLZ6j2Ye9+4zPnN/Ak3s2Mp8u+PO4eRnjdFpRrt11TXMRtM3FxcdmTryx9tbimoaxfgFhUJLofzQZwmSRbVYQ5ZWDaQuj0vAKc6EmPSineA3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716200; c=relaxed/simple;
	bh=HqoSoO51suZwRw/E2XzR8oCXOlM9hnrnupT6tAleAE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HjHUaingZth5Zc9k3FBR/eywvIUbsPLGi3bT4JwmVG8R7SpWxb1slvmt2dkmSMklehzM/tH3x9QRPYTsPd2mCzmUNyiCPeulcO96StE783d7RyBlORPBB3UGDaLJUEmEg14d0ETEtcI3tuEbE8jk1BIfmg0UUtp7aRMFJu9+EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doj3xhPI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgWVKiJLAS4Ud8Kqxubu98+7O+J1fnq9V+swJWFGqRc=;
	b=doj3xhPICnfUK78wyWMNkLoOZoqYPbpXOh0NiIav+p1N3CTK2HaEgCI1ss2xc+1jH6sOwt
	rD62E6T017z4AMPEGlyTJ4k8/+nhJ1RkFA/j0ad5N9UFixBs97pTTMeMbikhd9QsKPhzr+
	/arsiRgVsWEYe/PPhqUrroGFmA3HI4o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-LuvIjBkLOc2PCR6AIQzWlw-1; Wed, 24 Sep 2025 08:16:30 -0400
X-MC-Unique: LuvIjBkLOc2PCR6AIQzWlw-1
X-Mimecast-MFC-AGG-ID: LuvIjBkLOc2PCR6AIQzWlw_1758716190
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b311b7aa78fso153556266b.3
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716190; x=1759320990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgWVKiJLAS4Ud8Kqxubu98+7O+J1fnq9V+swJWFGqRc=;
        b=kSXSpR5GZSw1k0PkBMF5FQrgIrIgUe8r/QDcpkz4GDxPjtAd1SNM0lbRmt+ut2zeGt
         OhZbyeoL9d0tamoy+AE/Vs0o2P+YIXkDWpe2cOYYt78+ENIrK9IvFEVQemiXpEfxAmRg
         Xn38hGm5doO1ZWpnPHYxaxycmDo6YrZ8/Tu//UxQgnUZRvLaFYWNICkf9S4HbQJeWQn4
         FCaIfin/2cxbEzz678Pbj3kndNRH5pTHkfRwwI7LmQQLp3Nov4PCPFXdokTj7zR/Cl/N
         UpFlXUnVInP532ft5JK0oA38W5ZijvabV5jsCq+/Ze6RgLokgg9GOfnFZuMrnN6N0yQx
         0dSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+PyP6ZZtImqc32hIPTYLcAlivjOJbNe5p3hgq6sElYlJrwux0peb1HjR5WCfP2MK1GKzpk5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66uV54ozakXjIIkxvhYxmoiX/tTqJhwmItjN4PYEEgfmSI9VA
	l5bddx7f6veNpaxXKEMUy1gSInMSd2v61e5dUvUeU61IkBWXht5+0rvxA7XwAlDWsrxc5bauDyq
	+oPgfFEWPbonNkBUEkRHvOqYVUrL0dY2OMDWmC1q+ZL2aGohTwXvYeyMg8A==
X-Gm-Gg: ASbGncuHwW4dwZ4am2zN3sRjLnOkhV4WnzcEhbmYcvUiKDTTI2WsKkp7Wgty96FGKSf
	c7Evli0b+S3MffgRw2gdfCPMivaQi5K7ljjwDQI65Jh7ltq7A63uzvsYVn1q72PZYJ8rUQbfbSZ
	LCdqVq4kVmSiG9s28//9rsf2k6+BI5l706+5UHZTuYvgdeUGM/qFa4ed0ftAdX90rlwlamjHnWC
	K8qAVLaaBUPgcrFhOXHiCNNJRFdvfl5nINULfiEDkr7z0v9nyRheMLB4DArYyek2/u0lx+LZm75
	vy4OM5xCs1qhLHRQQSEks0aRBG095cZoQS0cUeRGGvbty353/lpIBHWTY6DgsOCNvFk=
X-Received: by 2002:a17:906:2744:b0:b1f:ecda:b79f with SMTP id a640c23a62f3a-b302b5104demr526178466b.38.1758716189527;
        Wed, 24 Sep 2025 05:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuAQ0k3fBcWzUtcZXpArqmNntsZnb7CpupxIROF8pMEVGdT9vqC7HBn4B7HQnqoGWmqQjs9g==
X-Received: by 2002:a17:906:2744:b0:b1f:ecda:b79f with SMTP id a640c23a62f3a-b302b5104demr526175866b.38.1758716189073;
        Wed, 24 Sep 2025 05:16:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b297f3f426csm948308166b.7.2025.09.24.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:16:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 560B6276E2C; Wed, 24 Sep 2025 14:16:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 24 Sep 2025 14:16:05 +0200
Subject: [PATCH RFC net-next 3/4] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-mq-cake-sub-qdisc-v1-3-43a060d1112a@redhat.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

This adds support for configuring the cake_mq instance directly, sharing
the config across the cake sub-qdiscs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 147 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 118 insertions(+), 29 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d17d7669de389bb21ca6ce3b209e0272cfaa5112..7ceccbfaa9b6b4cdeaf17b416c2b65709c22a60a 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -211,6 +211,7 @@ struct cake_sched_config {
 	u8		flow_mode;
 	u8		atm_mode;
 	u8		ack_filter;
+	u8		is_shared;
 };
 
 struct cake_sched_data {
@@ -2585,11 +2586,9 @@ static void cake_reconfigure(struct Qdisc *sch)
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
 	u16 rate_flags;
 	u8 flow_mode;
@@ -2642,20 +2641,12 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2711,6 +2702,34 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 
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
@@ -2727,7 +2746,23 @@ static void cake_destroy(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 	tcf_block_put(q->block);
 	kvfree(q->tins);
-	kvfree(q->config);
+	if (!q->config->is_shared)
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
@@ -2741,17 +2776,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	if (!q)
 		return -ENOMEM;
 
+	cake_config_init(q, false);
+
 	sch->limit = 10240;
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
@@ -2814,10 +2841,21 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2893,6 +2931,14 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
 	return -1;
 }
 
+static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct cake_sched_data *qd = qdisc_priv(sch);
+	struct cake_sched_config *q = qd->config;
+
+	return cake_config_dump(q, skb);
+}
+
 static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct nlattr *stats = nla_nest_start_noflag(d->skb, TCA_STATS_APP);
@@ -3155,7 +3201,8 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 MODULE_ALIAS_NET_SCH("cake");
 
 struct cake_mq_sched {
-	struct Qdisc		**qdiscs;
+	struct Qdisc **qdiscs;
+	struct cake_sched_config cake_config;
 };
 
 static void cake_mq_destroy(struct Qdisc *sch)
@@ -3179,6 +3226,8 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 	struct netdev_queue *dev_queue;
 	struct Qdisc *qdisc;
 	unsigned int ntx;
+	bool _unused;
+	int ret;
 
 	if (sch->parent != TC_H_ROOT)
 		return -EOPNOTSUPP;
@@ -3186,6 +3235,11 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 	if (!netif_is_multiqueue(dev))
 		return -EOPNOTSUPP;
 
+	cake_config_init(&priv->cake_config, true);
+	ret = cake_config_change(&priv->cake_config, opt, extack, &_unused);
+	if (ret)
+		return ret;
+
 	/* pre-allocate qdiscs, attachment can't fail */
 	priv->qdiscs = kcalloc(dev->num_tx_queues, sizeof(priv->qdiscs[0]),
 			       GFP_KERNEL);
@@ -3204,6 +3258,7 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 		}
 		priv->qdiscs[ntx] = qdisc;
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
+		cake_config_replace(qdisc, &priv->cake_config);
 	}
 
 	sch->flags |= TCQ_F_MQROOT;
@@ -3232,8 +3287,42 @@ static void cake_mq_attach(struct Qdisc *sch)
 	priv->qdiscs = NULL;
 }
 
+static int cake_mq_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	bool overhead_changed = false;
+	unsigned int ntx;
+	int ret;
+
+	ret = cake_config_change(&priv->cake_config, opt, extack, &overhead_changed);
+	if (ret)
+		return ret;
+
+	sch_tree_lock(sch);
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
+		if (qd->tins)
+			cake_reconfigure(chld);
+	}
+	sch_tree_unlock(sch);
+
+	return 0;
+}
+
 static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
+	struct cake_mq_sched *qd = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *qdisc;
 	unsigned int ntx;
@@ -3260,7 +3349,7 @@ static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
 
-	return 0;
+	return cake_config_dump(&qd->cake_config, skb);
 }
 
 static struct netdev_queue *cake_mq_queue_get(struct Qdisc *sch, unsigned long cl)
@@ -3357,7 +3446,7 @@ static struct Qdisc_ops cake_mq_qdisc_ops __read_mostly = {
 	.init		=	cake_mq_init,
 	.destroy	=	cake_mq_destroy,
 	.attach		= cake_mq_attach,
-	//	.change		=	cake_mq_change,
+	.change		=	cake_mq_change,
 	.change_real_num_tx = mq_change_real_num_tx,
 	.dump		=	cake_mq_dump,
 	.owner		=	THIS_MODULE,

-- 
2.51.0


