Return-Path: <netdev+bounces-248499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B3AD0A63C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBCC30F4DB2
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B7D35C1BB;
	Fri,  9 Jan 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLdMTPjI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+bwheaJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6F35C197
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964547; cv=none; b=b9d//IJCWSsqRSCZibp2h8vlhAjCpPxFbs1SEVhdgJvlFsXTRxyoriMk9MpsCcT7yfBH3jQeCS/MOw5HxaLoZ5h/Uf1IMAtgEc0WaEl2r3BBYcOOHkPWwNPFaUorxCya/yaR6rU6r/gK5qN9CkTDHuEmTVJr34dPJnjsJHIUQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964547; c=relaxed/simple;
	bh=JGP95E3TjmF4GjubqHvHbm7KrN+f3ek9eWCCwEuahPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTyc8qN/EViUDRKxV7i0IYENNMhqla3GXMrS30NBvQMMnA5G/158Pe0yLFTn3NwVMtpvEdXKWV1tlbApA/ejno3SR/rXXQeP0b+lV1wYXZrFUXzEyG8oxoaZEF4j9Kuu7tnz68zRtdOmkZW3xNPi3wIcrGGrnhiIbOdiBSYtfTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLdMTPjI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+bwheaJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tr0WGN0zy6cKRf07jeKX0mmzSJkOk9qiqkO4BE1uf/w=;
	b=iLdMTPjIGia8d5/gvRfGAOz/QnhXOsToGz3EPiYw/wA0H4GQ0eGW/tGzQ2GbOajv52d9Ku
	2hTzMM1PvQO7TXspjq2P+a7ZGaMPq+gZP6i9RzKCsgLflO1Y23J8cy711ugdGwxUtYKG5n
	dyqF8KDcI3LoNI+ygvvcxOfvrsfv+CU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-zgKiBSplMI6dKkrhiW0qtg-1; Fri, 09 Jan 2026 08:15:41 -0500
X-MC-Unique: zgKiBSplMI6dKkrhiW0qtg-1
X-Mimecast-MFC-AGG-ID: zgKiBSplMI6dKkrhiW0qtg_1767964541
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8395caeb26so681075066b.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964540; x=1768569340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tr0WGN0zy6cKRf07jeKX0mmzSJkOk9qiqkO4BE1uf/w=;
        b=L+bwheaJfVhblenyxmiOf4tSJ/FzoJc+P3nDRcYwUzLsfueIl2LCJI145QZhwwsh/e
         3OwwQ/iNvZCt/02+CIgbfR9yKaMPG3CwcNJ0gz7353tzuV4F3GrPwyrjwzY87bbHSX8S
         cqhIrTlyqqAtGiwRjRjKPFNZ9/glJkfhGARJtSWOmW7COjnDtii913QSzQxkhAFYKxI8
         Om/qnG3UScNf29uTIn/M9Sg59UlcOu/Clm5T6YMhpKvaQbp164SP/Tu+zAbVxDHAs4XQ
         uD7TpMuZk1OBscPVue9+5eL6EoypSu4drS4Sho2GGhO07Hpi0EfAiepzb3oz3MpotDof
         E34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964540; x=1768569340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tr0WGN0zy6cKRf07jeKX0mmzSJkOk9qiqkO4BE1uf/w=;
        b=AWtleOFsLhGqN3LUX1P6RCQmTZ2h7ouwUEjEnk+hnQ1T58FXx+d2hHeD5QE29/oDph
         U+qxp9AZ2fgvtA86srjEBG8YnkL8LbAS+tyilfMG4YfhMZmiMsKmJ5dxncVwsvLmIkv8
         usIhzECShxnEeWFDku12nA36ezKGqzYUCB5EilovAMzoq2psSUqrb/dZOe5xe/oLaf9D
         kl9Qs/lgCxq09UkDtUcsoQKXqdm+G7Wo/QxWoVggCrGHUZoojrva/cuV84hXDNNTwUio
         h4txcNJ060bX8UVsEoiEVmx22lD8ZBeNXxEzwowWkBKHbF2PbYc4xH3Rx4id8CyWtT8u
         rtLg==
X-Forwarded-Encrypted: i=1; AJvYcCWVvK2frLl4mHSyFhBjZbAHi0xxAYLIMYnb1oHbvE5fB6ERxL4WaAsx+j0L+/tHh46o5kgqpsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0cC7dZeculaCBn4FAScPIGSUUlgc+ruD5LA/eQW1CMTZ8Nxa
	UUTLawcpH1bUqJwyMOwobpSgJ1CwKn2qrb79ZNVgd3LSHBRyMZy0S8/AcKXmmzvD/BPKtasOOsS
	yLx1fbim/FOMPxo2YkyqfeJTSPvJ5igmM3aevk0wnWSSiNLnxnubj321uww==
X-Gm-Gg: AY/fxX5ONenehuxyHSIEaYlnu0eAyJD7t/M5MYsGg7DzPVsn97NQkc/2aeRLMDFY9zA
	XHFLOBRYokf3/JK5x6dtSvOhopOuoIfeakpmygTiKik2kH3L/BUkbqHQPXm/jR54hEDMjKERJDc
	uvwgFo8sSjkF66y05IIty4XtEfw/ShSvSv1ywcsLBKfkAcoYJA4h6jL/OGSc+2ylOujsYyhLUJk
	ZAcMP2NI64Vxl8F2ThcKx4qAq5PnMft8zZInLLoM+IQpGJh1c885lrQPv8VYEpsSIe9dlvkJilr
	beJ6EpCfsR/j1xlbvc3SF8xbBbrF7dz+/smFyCPBixZYbg8vNfQpb9b0XKNtWfpFMbHn6Isa3f0
	bWBrZxCw4i7ET1loNCgJOqv0WCuf4W+dZhQ==
X-Received: by 2002:a17:907:1c09:b0:b73:3028:93a1 with SMTP id a640c23a62f3a-b8445179a2emr978940366b.9.1767964540425;
        Fri, 09 Jan 2026 05:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGf3A8n1xM2L9yd7GkXZafpD2TmxZM80WA0Ot7EhJiU7e64UlvTxcLCLjzgRlIjMAhs0STNNw==
X-Received: by 2002:a17:907:1c09:b0:b73:3028:93a1 with SMTP id a640c23a62f3a-b8445179a2emr978937166b.9.1767964539985;
        Fri, 09 Jan 2026 05:15:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm1131238466b.2.2026.01.09.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2C161408633; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:33 +0100
Subject: [PATCH net-next v8 4/6] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-4-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
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
index 2671481d8e01..2e60e7980558 100644
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
+				NL_SET_ERR_MSG_ATTR(extack, tb[TCA_CAKE_AUTORATE],
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


