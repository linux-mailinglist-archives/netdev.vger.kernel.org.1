Return-Path: <netdev+bounces-242930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B323C9688A
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 581044E172F
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9ED302CC9;
	Mon,  1 Dec 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1QazWyp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9M6JfEi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529C3019D2
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583239; cv=none; b=sZQSnXYVMyifDAGXhRuNw50HS3Ozad5TeymEdiExD6BK768haeEdAIA0Bg849Ljxg+W5lcNPJs9OTItCuYxOQs1iJiqEXXAx4LM5P8Vog4jzqCpklZzUV2W3BN3zTZ3cp2QzkhCoHmzJcbEzaTY+lXxEpx15GUWmdiW5TF1sk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583239; c=relaxed/simple;
	bh=fwXgmMG8p24SPPwnC44Ud//fKEGA7wIDEiYMnvppBb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSJrEQQPHXM3qJZLPgj7jDNmRkLyCdMGP1Sc4UYk8xI7ibocBhIY+zHNWUXe+45pttq/2i6Ass2ziW+FbKE7tmzhHgqp/Ou9mtB8SdRdxgLbxi8ypawORosz4UmbJmv4sbG08emZMsJZtif+uXcaVWcj/+NdMLGXBZiNyLSFDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1QazWyp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9M6JfEi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEXfPRM2Oi+1WDmOQNkOvpBTjB69nAtE03kVdLQjnqA=;
	b=J1QazWypF4cnt7IF6ZsbbSVVtNoSb7UxXj6MCpJRCUsRoY8WIiOhUvCs30+D7llNIQhfq3
	GxeywgJyYjAscUDQyVBSuhNz41IjnolSSteBQFoIUXRQFHX7D6t4Q2gQzndbpQwZCzU7kS
	SGWpIXGf0fXeSPaG8+5swCxzHBwVxEE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-6AUy3VBfMWKN-iNUjqyojw-1; Mon, 01 Dec 2025 05:00:34 -0500
X-MC-Unique: 6AUy3VBfMWKN-iNUjqyojw-1
X-Mimecast-MFC-AGG-ID: 6AUy3VBfMWKN-iNUjqyojw_1764583233
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640c4609713so4680798a12.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583233; x=1765188033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEXfPRM2Oi+1WDmOQNkOvpBTjB69nAtE03kVdLQjnqA=;
        b=W9M6JfEiK57wkh8SF8pG3qxYY9XiUR5B9emXbBl8kIg7NrvJw4SjWxlWgvNNNtmrRG
         g1EZsCQRx9FExMWKkzCfLbg7uXIdQ4HDRxu4IhHTJV7RFyQOCUVbFpfTmszSbYEecrd/
         pQwLVguFsi6QcNmjFNpY2mIAMDddSBJVgYS6xD4hqlyG0nGQwg0X6UH1Er4BuDEgz0AD
         5Z8mB6WIM5kHlPS0rizTHtqIRrVHy4PVM9bFTvvYwbj7uvCuYr7s3AiPG6jXq3r6OQLq
         PhnLchOm7bV0DWuLYE2z0yBo0haFUF/7JmMntkcIn5npkBz0tpYDGmOPNripILBP4LXG
         yxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583233; x=1765188033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wEXfPRM2Oi+1WDmOQNkOvpBTjB69nAtE03kVdLQjnqA=;
        b=Qbt8ccx6mPFJn+T9vZjqf9n4hMjPq7GZpqJCzinha7v8GzpG3va+vUuH4ovLd6FaLb
         tWFhriXNYdVLGJPDYZulGANxg9AFWRr1RAithms2qJyHzqepAF3sZSgoDwJm5RBsmwba
         kNqtuSLbtXrRXR4+qFjhoiANIcdvg/F/tVlhWKM2Ui0GamoJmPLK9SBY/NWchPgHpZBP
         SQXGqwl/Wbdu2A/0xmaRfLOINUSgNYQMpSj4AQxN5i0N6eoCZoTrK3nF9xNp81sm9fB2
         rm/diysbUKil74U1+RVHppd/togwW6z97A/IX9RWemghOkQK2IqrB7MgSjZZuc4noH6r
         WN5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuMMo1ZAiOTNODdtcTFxnMbKR0XF/rgx2hy8UNOsBOA8VKx69WUXsYZZo5P8A88N9As1xt1Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy353JXMN3VkCOkk+e+7yYCqyF+FdMbzyZkWaa9tRENXNiNqTHR
	L3veyOMk3Van1I9D9wJZWgzSewMypH7QKp9FiJUYSOp2ragECZciS3y9tywCZdj2YHLzmRJKf5U
	rGu2ofIji9mhWZt2XTSvmcCi752DtEqm2EHsLpKsvmB9iJ65iZc7q5dageQ==
X-Gm-Gg: ASbGnctMY3Js0M0O/oo2a1JX3DwmaQhhh07nNnGpGOlDtJGoL/RdGB5R7mPCJeH6GGT
	Ptf2XBFuB5vnoheqMBNwW4VA1uROjnyLF5pi5Xv7SC4MTvLiffHi6Cz8wc0No8kpnX+vmyyQe0b
	/GZMq9+Rn5oQI0YcGKTGs0mv5Qa+h3wYzJnhHdhXVNyKPOBkWj2Iaz5Q5b893WE1c5KSNlsv/Ow
	f2wq/kQZlILiMUAdm92O9/+KWwjxv2HKNnBaVGJjX1NM2AWZxmS26wyibK1nggtF68w7hpiY5vH
	Q51y4mNezyK+VDyU4v68bB6ZEhUTFB2vfxngBMqLDwdtH1NsysszImjpHQDvesuUsdBiRMvH+/q
	J6I5rr6HZWvpyu6lo/GgdOmbkGfjmaqCHPdUo
X-Received: by 2002:a17:907:7ba1:b0:b76:b7fe:3198 with SMTP id a640c23a62f3a-b76c5514685mr2934713166b.26.1764583231624;
        Mon, 01 Dec 2025 02:00:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSqpeYXDxpiMr8CXg1SpqFNLLBdepCUbdCIRvrDF1afm1wJwCwPlI+jIapAgIed7ZaK/JnOw==
X-Received: by 2002:a17:907:7ba1:b0:b76:b7fe:3198 with SMTP id a640c23a62f3a-b76c5514685mr2934707466b.26.1764583230910;
        Mon, 01 Dec 2025 02:00:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f51c68d0sm1197933666b.28.2025.12.01.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A6210395D59; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 01 Dec 2025 11:00:22 +0100
Subject: [PATCH net-next v4 4/5] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-mq-cake-sub-qdisc-v4-4-50dd3211a1c6@redhat.com>
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

This adds support for configuring the cake_mq instance directly, sharing
the config across the cake sub-qdiscs.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 146 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 117 insertions(+), 29 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 48830e3ee8a4..9c3eaf5c9107 100644
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
@@ -2890,6 +2928,13 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -3153,6 +3198,7 @@ MODULE_ALIAS_NET_SCH("cake");
 
 struct cake_mq_sched {
 	struct mq_sched mq_priv; /* must be first */
+	struct cake_sched_config cake_config;
 };
 
 static void cake_mq_destroy(struct Qdisc *sch)
@@ -3163,25 +3209,67 @@ static void cake_mq_destroy(struct Qdisc *sch)
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
 }
 
 static int cake_mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,

-- 
2.52.0


