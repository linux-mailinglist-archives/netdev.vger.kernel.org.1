Return-Path: <netdev+bounces-241191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9BC8135E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD5154E59DF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE108287511;
	Mon, 24 Nov 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw27JX0A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+ZT3738"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039923D3B3
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996448; cv=none; b=uEYLlaUD/ymUf3VoXXM7GIix0gNvLriqWQUXwB8BOLpRB9t4VBTQYLPGoslS/xnLj3VTBOBpnBzlEoCmVyZn67GFDQ8Ac2hZC469SBFxUhDZ47sGc2x9eNemVuJd8+D4TIwymaK6ohHg3+rWEbSpeXAtMXKF+fVWAA9k2v/T1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996448; c=relaxed/simple;
	bh=rx3bO+rEYOxtKU1sIE8/p3F3ds1QtB8rwKYzo7f72LE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHWGEMhnjnOhVzezcuwHqv7hmy/yJZoL8zlGDrBax4t6sNvyUpfuXLI0sIyDijbY+CCXpGeW/CAVLdbTpReO7i/lCY2bRxKwr53bMv5tQ6t7+gX9ANexOg36lgkHY473F2m6Hig6otmwipMTcpUu5LPP60rEnMJGWzIMxMXxFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uw27JX0A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+ZT3738; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763996445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/C77CtGkln0p0ejGhGSFgg4OCqbQ0r3XkPxjPCS+Bxo=;
	b=Uw27JX0A7+SYZRXcAU9YiM3cas3WO8LK29iJLZEPHNs6/+l69U8n/a721E8ubLEah3mC0l
	ZxZTmQ7OqYQIUynSJmyOY5ywmTcjFScFbb8wsK4Mj9WpBgHQ3CRMUlLCSfBzT4ZGsg9zx6
	ZVpNS6VzOsDl9mV/FhGW15bMQDXWDS4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-yb2kQj-CNS2KaX7ltjApJQ-1; Mon, 24 Nov 2025 10:00:44 -0500
X-MC-Unique: yb2kQj-CNS2KaX7ltjApJQ-1
X-Mimecast-MFC-AGG-ID: yb2kQj-CNS2KaX7ltjApJQ_1763996443
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b764b80358bso345182566b.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763996443; x=1764601243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C77CtGkln0p0ejGhGSFgg4OCqbQ0r3XkPxjPCS+Bxo=;
        b=P+ZT3738FuWtVVT6tr2zk5ho3/M6ykAoxQKZHp/WdS/ObRGGQ46arHzlj3uIizDxdf
         8TSn9EQpnndNG5Ik2gPtGsnvNWgFEYUrQbl6Ce5hctYEwhJ8+W7+lBZilqlASK4YlhGg
         uHAzQd/MBXdap9UDDVjKF7ewxGn6c1BaRccp2Sl/Ey2p4HIQbsUoXVpTkAXz1vHqdSNP
         4u1fO34G4CNWCDJoo3470zzxEyASO9TZGQ5RbypAlW66T/1D/f6zd/OJtkegSNN3kynX
         ed7FNP88WnrsWXBP9T8alfAnww8ZfTTSlY8+jZkbKA6ZFE/Sy5MThb/cyy3HyZIXp+a8
         7r6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996443; x=1764601243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/C77CtGkln0p0ejGhGSFgg4OCqbQ0r3XkPxjPCS+Bxo=;
        b=aw4B6+e+jNAUAXBwnpr/VtU6GbMdMkOk19YnVRIahovnQ1hYMEf1me6fs3p7MPdZkm
         TDRfA28t6r3QngvIf/qfmO7c/lVZXNYxOUtkj+jfC4zszqEx6inl4nwbKa3QedwqlkpO
         LkwJFaLDECAFNzcRqZ4MzIKbciRlyE5jdbZ0/W/G7QCuuPDsepka86dr3pTPQtpQAVUt
         i51Kk6uO3Rh32OsSGDXuOGuOekncXHTXAtoOFS8WiTat6PpfnJ0Z05HoHYfQh3P9oYPC
         wn4UZH/LtAFyUnd7h6hKNBtz5Eu7TBAM67ZjbMyCVpF9P0vTzDSHun+j0nLUaKw3o73M
         FQlA==
X-Forwarded-Encrypted: i=1; AJvYcCWUs2PKI/29NfP4o44bwqxaiNP+Bd64vowPruyiIj4aVEkzVqIjDrNJ4bJWHsInQGOUoL/TVUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgo6wVGtczqUR8a924F+COh6OxC6otP1o2YkFqUaTuXncqIyY
	MAHlrqVgnDBud4/cnI00K/WpAowLU6xLgoUyTos6fALqCXlQwOFjJwPdDTQhPuyN9Ai7Z4Ns4BU
	4JDMekJRMU5pp7ZmRCGpMyiflv5Ajj6z3liOHbp2IKetA53ZkRz0meXSf+w==
X-Gm-Gg: ASbGncuJ9gWP3S6+OQGABlST8JT2SMphrnknhSOs0i8tCD06ns+tlj+NjfToAJ37vGM
	BRovGe7hZ8SeLMLoG3VhbUHzuIAPTGpaThddWAatdEMasGBEwMEfCVD+yAoR3sjyJfWZ0NVw1Ia
	99909mdtS/sPLe4HtqyJquJ9YEIgZA7PWIIhZkTSCCcSTfcCqT8c12n0VFp942hVOBX1htZIoNG
	TpS+gLu61POMdXu8PTmL5SWXJ0LFTgMDm6OYII9G+Vc82OPhtxC/OX+2M1QG4rxIuYpwsB9kGRd
	R3kKPqUuXSokRQKX5Ga9+WCxhx+IjwBMwP6yygWljGe0ADmi0F+0gkvsbsSTPWNXP31jV3ARBTU
	itOX6evDOXqKHz1Mqyhrhs6cDtUXRSuF27w==
X-Received: by 2002:a17:907:724f:b0:b73:2a77:3128 with SMTP id a640c23a62f3a-b76715dcddfmr1444309666b.27.1763996442797;
        Mon, 24 Nov 2025 07:00:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECJ6prQFTRVQS1ulwR2dy6vT72bOQiTEUiq4Z/H/bjo+sYNL+oQq8IOJl1wmse3BBHGtwnvw==
X-Received: by 2002:a17:907:724f:b0:b73:2a77:3128 with SMTP id a640c23a62f3a-b76715dcddfmr1444305166b.27.1763996442122;
        Mon, 24 Nov 2025 07:00:42 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cdac18sm1294543766b.11.2025.11.24.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:00:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 5080E32A803; Mon, 24 Nov 2025 16:00:37 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 24 Nov 2025 15:59:34 +0100
Subject: [PATCH net-next 3/4] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251124-mq-cake-sub-qdisc-v1-3-a2ff1dab488f@redhat.com>
References: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
In-Reply-To: <20251124-mq-cake-sub-qdisc-v1-0-a2ff1dab488f@redhat.com>
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

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 147 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 118 insertions(+), 29 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d17d7669de38..7ceccbfaa9b6 100644
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
2.51.2


