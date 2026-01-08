Return-Path: <netdev+bounces-248185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D363D05337
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8BF63366413
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787332EA482;
	Thu,  8 Jan 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXW0fWxN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i98sKKfP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563E2E5B1B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891485; cv=none; b=BOw5D+y4yomLfX+JQiyFZR0BUmYBMLLp3eqfMDzb6BsjhtqyToV6lr34Dc2Vaa0/hUp7iwnYK7FvCB5SCbozWCZfekRfLwoYfJTMe0vvxJyy541sdfw+7qrIe6oRq13IVyu3OfPZGpaTI26EL+Nz5P0IQpQnusTkVuEa76PxB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891485; c=relaxed/simple;
	bh=xUB/Qzk0/VYxwSgie2efcM7qzZ1DvxkMUxe3z4226ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jedOHC84IAd6UG3vFti+OLIf7gowB/UKm0DqeZJCDC7wAoSQxeLBuPs4c81GicmgeLmsNnU9HM7DnSAuBTB7wQ9XFoOa0uQC+WWB+vTyVT7t4tx9njIgm4S3Qj5HwY/MWMVIsljQCy182naq9sxyUuYKfuxX8YNAXla6kIO7Eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXW0fWxN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i98sKKfP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hp1tArh+uDAX6Wdr9wVLP30w9rVFusjhjfS+uxlqvk0=;
	b=VXW0fWxNr9p0z5kEnv+iv5ww+f8Lg2ST1gHMRwa5l0jpkvtgWX6PIOrFoQa2ieApnFomN3
	EAIn2enFnJHQRJyfUrm2mKtA1Lqz8iJ8akyF4TbYRrwUQ42L+zNziSV7ZP4ET0vgYXuf9E
	Ldu7Xu2I8katHSvNfE7SrzKHM4jwoco=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-0SSkn9lzNOCe_PjfbqXPgQ-1; Thu, 08 Jan 2026 11:57:56 -0500
X-MC-Unique: 0SSkn9lzNOCe_PjfbqXPgQ-1
X-Mimecast-MFC-AGG-ID: 0SSkn9lzNOCe_PjfbqXPgQ_1767891476
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64b8a632dc7so4630810a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891475; x=1768496275; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hp1tArh+uDAX6Wdr9wVLP30w9rVFusjhjfS+uxlqvk0=;
        b=i98sKKfPlkB/y3zRm+FtuYdY3w0QmA3L6r1vsBL+NtXj8VfgKN6TSj5FRVxv6dBkxf
         YcMeYJXlnfZCLLTb96mebPuggNFVuv1TysqTIceP97IkUbiri0fKj6jiyixk+32RADgA
         fHEhfKJ9nBjIqw52GrjRHzNQ03QoXet4E18HUX2EBfObbZuJlee0lh+RS5333M0jg6fX
         HrgYp0F16O2S/tLWpAJrHFaRc0U+1m8uvx0hwebN5Tj9aJmXgUlLkLmjkcMpkePnF4Qo
         reYSDW0oHnEhIGTa+0PmrJ5lOR707YodMp1t+YXU8m/CO5vIkIM/L8N69IYvS6ZCOmJo
         +qEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891475; x=1768496275;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hp1tArh+uDAX6Wdr9wVLP30w9rVFusjhjfS+uxlqvk0=;
        b=I+FvzSekoC3BIGwxzQFumaN2Ydq0n50FD5wlZafZmQ8lItKBt7Cpo5zKZQDPPAXZvp
         i+OVa8aXh4FfF4dUBzhRh23dBpGvRfgAijRMK6EsAfCqEN9KbkUxPXBn8+c7DDNlM/28
         W+4cnccNhN+CIf+0V7Cw8xBa30nnNCA0vtS+duy963v8OVfKaT0yHhYAoQt3eaur+dQh
         uDnitUeYZ6u564hEykxDads84O4iuBWXWOqHSYYyklbElo6356pMmuksKTiUotfTfym+
         7VQpMyLPwJhF/RbIQB1NgS0JxomI2sQkEx4zLB6ddsWVah2sH+iGVZrGkNNOwuQ+cjd/
         j0hA==
X-Forwarded-Encrypted: i=1; AJvYcCVwijX8MCf1o+HaSkSr8kjH+igxDrPkJkOU29cm0yz3Qv0siOW/e+ofEes/zS9Nljhwa98U4tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+y0KXop8ZEc6JSz99DCHYjtt1IYkEReBozHs8Ftzz6y+MaaQ
	+gfWDyBfyBAVU2tqCCTZ1ynqjSFro6/uZj5wz5RQQgwhCSQ+V9uRGpVQCiUrZgTcF3fzyqkbOCu
	inSWffv1ag+BgFy7NLQ0aro5h/p7J8oXzbpgebzBO/RS7FA/ZID7TKYgLVw==
X-Gm-Gg: AY/fxX7Q39/ZuTB5FLu5AfBkSn7WMbH4MWhmO+JSDke2rz41E/+k3XZhGUx3l9yJvEr
	gIT6S12Y2LQ7O/zpajzEqoxds0DXsxhdAb6Cqg+e9Mn3yEe0dTcYXSATaOx5FsocQwnkaBoGybI
	NfGbXiyuk/5vAZASFO+oNrA8GNh7f4WkY+M5xuZWsuH9LtTqep24qce23kCwUVx9hCeaPsaCjmj
	+8/qlbLP4Fjlv4iK62sI0tBMwE68GczULBq63KKOuIAgazlOJCubhj/GwSrNyvLGgh7M0ihUzl7
	hfmUAt5t5BdIslp6RzLushDwT7taOkEBvIxAbaIX+pgIGrtEaO07TRISaa/+wEeUQ+lDyvfDVGB
	Nxtj9FqhLCxhDQY6luizWlDCtMsZPDJnk8hIM
X-Received: by 2002:a17:906:ef0c:b0:b84:2023:8fb2 with SMTP id a640c23a62f3a-b844516a72bmr646521366b.5.1767891475284;
        Thu, 08 Jan 2026 08:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXewPdxaf2nEPitIqUKporANTXK8SOiFXufApku4QFKzAtMTIwZwc43/nfEMBc9tkJsnJZ2Q==
X-Received: by 2002:a17:906:ef0c:b0:b84:2023:8fb2 with SMTP id a640c23a62f3a-b844516a72bmr646518266b.5.1767891474847;
        Thu, 08 Jan 2026 08:57:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51543fsm830777966b.55.2026.01.08.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CFD074083C1; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 08 Jan 2026 17:56:06 +0100
Subject: [PATCH net-next v7 4/6] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-mq-cake-sub-qdisc-v7-4-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
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
index deb9f411db98..4dbfee3e6207 100644
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


