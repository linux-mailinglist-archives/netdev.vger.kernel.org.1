Return-Path: <netdev+bounces-242840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAD2C954B3
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757CF3A2837
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3CA2C3251;
	Sun, 30 Nov 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6Xd9W6g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUkCyZ3b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005A24111D
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535055; cv=none; b=JJNflHKG6GUWh86rhPg5UFsLPZx4UF/J1RrsXcCqyJE1OEI8u6pXI2PouzTsm8qwtUZb+YASQtYQnfjEJcfZl6ipK3/AaiNB/QLOWSWbKI00+EPntd4WnHRzdvY69seclst7JgKQU/tAXhrhtCJ3+LA6RToVERy+cPkTNu6CUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535055; c=relaxed/simple;
	bh=HZnBGwgy8b8M3QqmOpgyGnPuUUUm3FBK+taSKQgV6D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWkwbV899WFKBucS97tVe+EqDBsw7U3DmTdFLg7Xr8KBWM03AUCW5moO9RIEl+6frIYKm3pOV5+MD5h8+zQWpBSFhWSNTmknIw3D4oBOHRdGqOF9lfdk518iXer+8eUJRN78Cpm7hzFf1i/HyLflvlobn7Exf2BXXN3my6z2vAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6Xd9W6g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUkCyZ3b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764535051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KWWuvh2Kcc902JFLrEx84h6cHSDVUruMvV85WP5XzY=;
	b=X6Xd9W6gBKcTzS5G81UtrczaCFVk4JSoXdZoC2lzFRvTV8vKJN/2fSoWTk/erRd55iTOG3
	p6CxJ5kyWzU7nDyK0TlfFzTQzzr11lvlq1gJvP6NmDTbnUAdg59SyF/QVv3CeWnBn6Bj6T
	XXMMwMJS+d4eDN46GoawiLIeKnAhobM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ukMpptIbMIixiXkkjqinTw-1; Sun, 30 Nov 2025 15:37:29 -0500
X-MC-Unique: ukMpptIbMIixiXkkjqinTw-1
X-Mimecast-MFC-AGG-ID: ukMpptIbMIixiXkkjqinTw_1764535049
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640789adcd2so3253945a12.2
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 12:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764535048; x=1765139848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2KWWuvh2Kcc902JFLrEx84h6cHSDVUruMvV85WP5XzY=;
        b=NUkCyZ3bZ1uHswuPuqoO+wYxjFXkN0Xpw2l4pOw5nMUfjH9UrzVZX/srpPVL6A0mBN
         PhgGkV++6HWsEHLsyaID2ntThPZPPIK1KwEJCyWC2sfRdqfTIaALqhKSz+FkTzvszau9
         IkiYBOzuRRp9xSFA6BkAXTzffkaR5TvZgUiX+2TGVAqWHvWji8gMgaDMwkfMSNapnS1z
         iegi79fdU/ipXix1DcLDTzu/5KaQR8aX6IaXGSNNlYEEtTzxHyvtdEgBVltCoPU1v5ce
         ++C6dPFTDfq6JiHICymjCnww8g7goHjTbMALkBFn/FDCyAPs4gdPSDTpyBcc2brf/XNk
         ZfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764535048; x=1765139848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2KWWuvh2Kcc902JFLrEx84h6cHSDVUruMvV85WP5XzY=;
        b=tffqxfUkC+gINnh1bTf5GmQraLBo6fJ7bvhNUsvsv1lzAOPBFCxCfN9O4Zeb3h25o+
         FrEfrPyJQrB1FCdW1SZwDhA44ycst7NfbuBUZR6T5M/7CU9QHR5E2Q12zf8Hzts4319O
         CELPFWGNZuRVav40Y1Y5fJHSbLTXEOvDGtrIHR5RcdYVH1T6iGhQ6JQO0yTpFMWnQt53
         StC2+bewSDkLwf3HKFuEIUR1pTNpx/czTYZ33vLKgTJ5ypar3oVAukxWs04jKmEEVbnY
         MhOZBiPdDOXoFONFKtNn1DeBrYS9jd5DmavK2fkiiCasMeopN8Miq2yFKKMBfK94Snlr
         rXoA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2Cgb7nDNCw+l2wr/FOYmSUiW14L4vS6H7agDfTEJg1Tclmw+WVV7SpKA/RjojN4kB+QHoqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjzwyak/R90iAMsHY+3RKEK5WziJaiyZU4bCJu7QT9oAm9Gl0
	Z9YfxVODtPR150XV66WOVWwkKW9OKwNnYEo211OnHjgkySllA2ZZC123x+GhXhi2CfvH262yLx+
	6RM8lb3Khv97K4JKzANFeePGCy7cCQSa1hkJisbK9N5Q7rAWq3iOkZuh9/Q==
X-Gm-Gg: ASbGncs+6toBfsUpfLxIpR7aaDuTTuFbp1tXw6GMdjYt87VMtukH9hI0OdrXsN+vJE+
	TA4lQSV6nTpThMX87ZJKrh6bw0gsW41Es09yZEZ2BsnHxtD0mOif9P6lY3Ag4pwcEvMhlJTyerG
	D0WRm/uwNpaHxHN2Sx4oon5tt9SxPb8FZIuWKt9ktA2Czh77RyYUQi4RUAD97NwMm2ilVjvnsdM
	S9ZWlAwYx6g+xDqzgtTrcDAv4Lyt6srKhW8Y4h3Fjf7N9tGBwdVb96R7RqlStCoIYOnN4QXRAPW
	zyRjufDQneGoeBovPp8W8ovMs8qq6D1s7F3wn8t3Y0hdnPoadgcnaPhiz15pL0bqjPOo8G/sQU8
	yCmS5x/vEbL/NbKxVlVrp1WuS2Pv6PkOGRkJq
X-Received: by 2002:a17:907:724c:b0:b73:4b22:19c5 with SMTP id a640c23a62f3a-b76c555c547mr2364472366b.44.1764535048500;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDoKKRPf2wt1e5hoYL84omQMD2BhEjoV+Q6oYJONQBpang3M6Sf4GSjB8AC82gJLSMLcMR0g==
X-Received: by 2002:a17:907:724c:b0:b73:4b22:19c5 with SMTP id a640c23a62f3a-b76c555c547mr2364471066b.44.1764535048022;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5199852sm1027929966b.15.2025.11.30.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 12:37:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4535C395C29; Sun, 30 Nov 2025 21:37:26 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 30 Nov 2025 21:37:21 +0100
Subject: [PATCH net-next v3 4/5] net/sched: sch_cake: Share config across
 cake_mq sub-qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251130-mq-cake-sub-qdisc-v3-4-5f66c548ecdc@redhat.com>
References: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
In-Reply-To: <20251130-mq-cake-sub-qdisc-v3-0-5f66c548ecdc@redhat.com>
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
index d360ade6ca26..51184f308387 100644
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


