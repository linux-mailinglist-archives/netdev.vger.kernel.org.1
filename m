Return-Path: <netdev+bounces-242213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03103C8D8EE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BD34B356
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9E329E55;
	Thu, 27 Nov 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRCaNMzp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGjc9LA8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5E329373
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235867; cv=none; b=Xk764BCc+IvJoVZxbk9HMid2Kj/n1aWCyFQROMgMAZEvp1m7C6v/drFSc1LiWGEKYrKh2HJYo5ZQh0MXfb1Gm4e9dMIqToOnlp6Pm7h50cB7xnciwIQeY3S1cYKtMzqW6965OGlsdOFt5tbzvqR6eCqR/oci3VMmCOL1oUpNhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235867; c=relaxed/simple;
	bh=SrQ2iixei+iuono1FQwWaiTdzSsTefdsS/3lVwI/tx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJWmAKaPSEIuC0Ue2xJZSDNFkzTBv1QblX+AoQzlpQ7cEkeVXdFGyhKHPJHYH/gUJFL2rcBibTMu7rDCxjSZ+xFlynwDfvK/9SU3BHSRgcfi3+RuXIm9lBNwVicpRtA0kbCigbJy+cvB7fxjlNnAnghddc3hZIZAb62x9jOIHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRCaNMzp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGjc9LA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764235864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj33bTqXMSC7ywulh8bZ1bZ3T/x3a3YwpFGz0M4L04M=;
	b=fRCaNMzpifqiy5w/plhBDqu0uKFSapmYUh4WxIgfjrc0xZ9/MyC7M9mcTPvPksq9auFrgG
	fmevx+CkyQaxDavWHusL+RqjDjxA3USJ4VY0iB39kfIKEaksuLJv4DVb8Xc5zncWB/TCZW
	oopLft7QPEtK37HP/apY5J1bf5Ja49Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-NWJv-L4iP4-GMwPihSV1JA-1; Thu, 27 Nov 2025 04:31:02 -0500
X-MC-Unique: NWJv-L4iP4-GMwPihSV1JA-1
X-Mimecast-MFC-AGG-ID: NWJv-L4iP4-GMwPihSV1JA_1764235861
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7178ad1a7dso59854566b.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764235861; x=1764840661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj33bTqXMSC7ywulh8bZ1bZ3T/x3a3YwpFGz0M4L04M=;
        b=QGjc9LA8cX4CLQDoXzFasyGqVsIa20CXbIdpHFxp2azWFvCBFv3w631OosOjLkz183
         zqSKtUUnEfETZ0glxClIo6Rk+kOzKGNiGc7XbCumU8YHdCKZm6zWn0rzvcGNf6qas2di
         6ejwdqKnXuRg7QCDreXYIZra4lOcefAhmZqI9yNjcnXZO45aB3jakgqIdvuiC9kBvw20
         B2xKHV/e0V8BNVSLR/7YmY38SXCyUqDfb72DouqJsBxhkKrZaKmil+/6Iu59F6aM2Eev
         GavqssaXAt9+dEgjxggcawUMZDZAAM9ONb24tGXyhZ/tIw1JwqC7juJQHPeOhPSevpoH
         xXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235861; x=1764840661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pj33bTqXMSC7ywulh8bZ1bZ3T/x3a3YwpFGz0M4L04M=;
        b=A1q8aOOfPLgCR2jYz0NB/OeTSAkcg6cnWSRH0PU0R09eS3H+g9rzp3VTDYx1tgKvgx
         TRe7v06q80OXfbSpA8PG+JN7n2wDWcSgRon3mis6l5h4SceI6FrP70XYYNVwqDEvfKDY
         jkNj/CPg/wyva5t9e9GE9D8ufW/yI8yZL/srixJOtyhUR6tOmyRU5mzcdtRcaObBWLg6
         y+Lw+GSb7mk/7v+stsYnAr6LOebQxo7kgPYazrA/JslWffyhJDID22XfPo39ERYizpyh
         1KKQZGKCmOrbWAXyP7W1jctAU7s+NSco3lSTz0wBp45N5/plRZS8xinfnvIuS7EjOMrE
         wM1A==
X-Forwarded-Encrypted: i=1; AJvYcCUY5TYgkdieioftXfjXLpdzw3zZFW3F+6xnsjXu9NBMP180YFv7xct6pJd9Gh/xEGuNjZmGkcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mdu0mkspw/2lmiRWOeXIG61eCb/e2n/IS64dVETY2ssnGXCf
	8OL1LIm6n13GKSE5x6/H9ri+rrcGM17OndkI8XiusOVgTgQGUti1tGYEWCYas1bHXzJaWAoLwhs
	tuN0w1wQMzJj0BAw08BMBdUdDL2tmgL6oaZcKXIV1XUarp4Bu3D7JZ6qFSA==
X-Gm-Gg: ASbGncvTCClhY45NfDEtQNjMJTge1AmOmJRnz43vGIk5uITfj4rlo6UceVbK+4NhLWU
	Ibt7UjgximUqHRsacOCAGH/LZ9/bcQf1ysZ50HSQIIGx9HB1LehloP6OFRry4EY20B9T+lfUKNg
	d3yEoT+4ZNG45irUKHl23SyYYTIswnc6Y60VC0Pu3uB2JRp12Kfrb0FwCKlIYiO4meTtS+9ow4t
	cl0u8E/oIWl2i+znO3529vDNYeEGWYrvIVzHZwFjW2PIU4jTkH6+zpIFicBDcjpWZJrSQS+2fZh
	y7ZNsMod7dn0KmbvcHcPRwvNJdDyw5ZRJ+V12LjXdpNb+anCBLCUT011a8y6iYgNzovh4ucq5X7
	jWGVI2sVHXKlDSjFUG/nsvaOXg0ALusTORA==
X-Received: by 2002:a17:907:94c5:b0:b73:7ac4:a5f with SMTP id a640c23a62f3a-b7671565517mr2339121066b.21.1764235860877;
        Thu, 27 Nov 2025 01:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvU90swQslTLLvC2voemumWXJDCQQ+KgSSrQZpF/UMrek6Uk3TGdcOA0AVROnhjd2fFtBwXQ==
X-Received: by 2002:a17:907:94c5:b0:b73:7ac4:a5f with SMTP id a640c23a62f3a-b7671565517mr2339118266b.21.1764235860436;
        Thu, 27 Nov 2025 01:31:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a5csm111077866b.41.2025.11.27.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:30:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 493FC395705; Thu, 27 Nov 2025 10:30:57 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 27 Nov 2025 10:30:53 +0100
Subject: [PATCH net-next v2 3/4] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251127-mq-cake-sub-qdisc-v2-3-24d9ead047b9@redhat.com>
References: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
In-Reply-To: <20251127-mq-cake-sub-qdisc-v2-0-24d9ead047b9@redhat.com>
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
index 2e4b7706c57c..066aa03f3fa5 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -211,6 +211,7 @@ struct cake_sched_config {
 	u8		flow_mode;
 	u8		atm_mode;
 	u8		ack_filter;
+	u8		is_shared;
 };
 
 struct cake_sched_data {
@@ -2580,11 +2581,9 @@ static void cake_reconfigure(struct Qdisc *sch)
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
@@ -2637,20 +2636,12 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2706,6 +2697,34 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 
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
@@ -2722,7 +2741,23 @@ static void cake_destroy(struct Qdisc *sch)
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
@@ -2736,19 +2771,11 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2811,10 +2838,21 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -2890,6 +2928,14 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -3152,7 +3198,8 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 MODULE_ALIAS_NET_SCH("cake");
 
 struct cake_mq_sched {
-	struct Qdisc		**qdiscs;
+	struct Qdisc **qdiscs;
+	struct cake_sched_config cake_config;
 };
 
 static void cake_mq_destroy(struct Qdisc *sch)
@@ -3176,6 +3223,8 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 	struct netdev_queue *dev_queue;
 	struct Qdisc *qdisc;
 	unsigned int ntx;
+	bool _unused;
+	int ret;
 
 	if (sch->parent != TC_H_ROOT)
 		return -EOPNOTSUPP;
@@ -3183,6 +3232,11 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -3201,6 +3255,7 @@ static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
 		}
 		priv->qdiscs[ntx] = qdisc;
 		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
+		cake_config_replace(qdisc, &priv->cake_config);
 	}
 
 	sch->flags |= TCQ_F_MQROOT;
@@ -3229,8 +3284,42 @@ static void cake_mq_attach(struct Qdisc *sch)
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
@@ -3257,7 +3346,7 @@ static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
 
-	return 0;
+	return cake_config_dump(&qd->cake_config, skb);
 }
 
 static struct netdev_queue *cake_mq_queue_get(struct Qdisc *sch, unsigned long cl)
@@ -3354,7 +3443,7 @@ static struct Qdisc_ops cake_mq_qdisc_ops __read_mostly = {
 	.init		=	cake_mq_init,
 	.destroy	=	cake_mq_destroy,
 	.attach		= cake_mq_attach,
-	//	.change		=	cake_mq_change,
+	.change		=	cake_mq_change,
 	.change_real_num_tx = mq_change_real_num_tx,
 	.dump		=	cake_mq_dump,
 	.owner		=	THIS_MODULE,

-- 
2.52.0


