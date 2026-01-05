Return-Path: <netdev+bounces-247037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D8CF3A87
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C680B31B4640
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2DD72621;
	Mon,  5 Jan 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvDyF4w5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ix8tQzD2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749323A1E9D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617500; cv=none; b=i2jJV2U90K2ICqdM6uS7fpeilvTFHpW46bbGYpBL9pKr4ZKVyHUSDuAxt/a+9P/I4koODt6ggt69Rl3Ue19A8LpXNv3q0vSTfbxGfYuFrU8/TC2Bbw2iyqlehUtcKswopuMiQa5xnwHolD0XgY57H2H/58Q23ThulP9wK/Jb3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617500; c=relaxed/simple;
	bh=v1rnv6t3QRUajzmq3QcUxaCwcERV/JG6v9gtPeVD7N8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2mDeoroWVjPlJqJbBw+TvuJft+S1AY2EIaKE8XG7UE5eGhiBjaIBCOx3mHcOiU6PZO1nhZUhxCvclBuDO39fbGrziHQuwV9nDjHmbPteXffwdPJGFnqW6XXhzAgA3CQ5lcIxruxVxgwFV05wyNL9kdgyfgQTc2jY1aHco48tJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvDyF4w5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ix8tQzD2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
	b=RvDyF4w5tM9rVELcCgClbcaCRIxECGtPFQub07CTvOjK+uq7mial+pwetq/CTBeLa5BnWL
	/r+rE4ssBel/4aCR5muyFU85u11g0tFtHeLWD6kYBubWG2rjNvIjQuy8e5lY7uMaCZiGug
	0Z9EEGG864dqI5liD+7hCS4oy2/LpnY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-jRr9NKfeNg-QcuSV-et63w-1; Mon, 05 Jan 2026 07:51:36 -0500
X-MC-Unique: jRr9NKfeNg-QcuSV-et63w-1
X-Mimecast-MFC-AGG-ID: jRr9NKfeNg-QcuSV-et63w_1767617495
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64d18dbff2aso12698624a12.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617495; x=1768222295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
        b=Ix8tQzD2nluXz5JmiTPrTrSdHwTCjQv5sbVQTL2vTZePSjG751k+VzWt7JLBrW/87n
         1sZy3hF7DxHcMfIwVfEFdUO7vu6ucSHrtyhsmkUzi96F/LlG0XhzCxbhzjitHUrxaAs9
         Dh5iD1BIp3WWXMpc+T4WvDmMGQqcye1TRCm4z6BYQa74jKKJvetdMFdhHvS4Cy6inH0M
         FGkd51jwjpxDBQNKnTy9foFRutbEGJaYioBACILI+ADTOV5P3j3ltHiPfsoMFOrVR9do
         t3W8jFtze6PJylP/f8Xm8vBILG2Qbop2tN7TwOPcjdpmMmC+sdqMVukIERvsifbZEMmq
         79Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617495; x=1768222295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pX3ABv6iI2/B5PgTsExWPgiK6cSF5NREquQbOQIGOr0=;
        b=ZJggHJmxEjuXM+6D+GWV4QI4Jl3erouOIgxm/C6PyzMR7+dQhmZnlLLhIukfsxA9mx
         MIauYtslq4MMH8cRAl4HEO2r5V8QEBkYv5Iuoh710NkaRb09ukeTw9A1ltBK6btrJJPB
         ZB61As8o52sl82bXTodMmmSLnoq+r7J//pDCA9I7tIYL6fATIiih2bpKI5IjKeHujr0w
         q1fpeL/xM3hcnRp2rwloKwujLd+KI4annlDSw0F4Vn/I/mykS9T0Bjf9DGMWDrNMNytC
         9FZQS6wlIpL4N5iZppDP6U2YPaGBbpBeIdg7tAFCqItHEYSSsYOIVNOUIduZnWuJ709V
         Aqwg==
X-Forwarded-Encrypted: i=1; AJvYcCVTX/afIIG/khu+h+VjEiNzzMkni03EeFIbOEGC3LP8ZoxXCnhTiPaxjFzYVQsLA1IwRJQ1Qzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4q74eKhdRcEskhXCvpO6ZRJiFyW0L5qioT8cN76HSkiX+HEF
	No99RkUTzdYxa4vcKDIw7IJnCD+cycrws0j2nN7Ruc0G+m1wyAtOHb3a9pIxcIF2KghzLj1lT6V
	KEpi3cNelV0rHq/cDJRRHrj4ntuEm2MwmPKfXg1hjyZEAsl486Y0iDIfkng==
X-Gm-Gg: AY/fxX7+Uyw4jfvMqTGoLtoZP4jD1uMAd2RdsiSKWSUhWo3jNiRKesad/WxkNoQeqJl
	ICo2tYf/VEuFFwILn4fN6exg1qgWDmijvb9E0uADMCZ59Au0lD2q0FYdEypAJ70i0/sn69a6AkZ
	rnQSnGbY/XoxeNCPIOqHZE8jYS5rFr8xgfZ5KENimrDa0BO6J/NiG+ARnyr+sY6sCzQRdCM/B8z
	1gjhhOs1zq7WAdVM9m+NtgG1TxWgqwVNegqRLjI6XMlpLSnphBYA0/Y+YlM+sy/1H3y9E40Bdv+
	uZ3z7PDFZmnJtm+Xi7efc+A3CrlWCoAnbGXGPAgjqjGcLx8qJQL2++bEucCnrpM39io85lY5mag
	7uZRf+rAbsnJ4X8G8A/rLlRMAw3elhTc9uI8J
X-Received: by 2002:a17:907:1c17:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b8036f637d8mr5198876766b.28.1767617494707;
        Mon, 05 Jan 2026 04:51:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlS7wXEiFtaDcuX+Gy85lp8QI5blBkRIyWKPn1Px6WC2eVbxSqkIeQF77MI8BVzZ689YXnWQ==
X-Received: by 2002:a17:907:1c17:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b8036f637d8mr5198875266b.28.1767617494224;
        Mon, 05 Jan 2026 04:51:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de0b38sm5465863666b.32.2026.01.05.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51070407E95; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jan 2026 13:50:29 +0100
Subject: [PATCH net-next v5 4/6] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-mq-cake-sub-qdisc-v5-4-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
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


