Return-Path: <netdev+bounces-242927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28053C9687B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9D5A4E1878
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C756302CC6;
	Mon,  1 Dec 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7FUu8pC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQqpI41j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50519302754
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583236; cv=none; b=DzqCm2hgPK7lqwybH1DOZXYXGZK7mP/CEQHRmq1zwTu2JmNqAP6zLCmbOBok3x0K5cPKj52WDv41oSKiwYJhnsaPUQii0/pyUZyh13PUY/khrsUxNqhOVRG/S8acLX5xxW75OKl3thdobEkN2oO2OZNxtluDgdPzECnICnHogwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583236; c=relaxed/simple;
	bh=T+HuXpkVGkt6IOnP2E84wTEldx0mMIWs5fysjgmICTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Td+4Q/NMDwwcHpX6GvhzjFtU6J3qP3sc59w4zBxnGoDAvdSnQypiRsQI8hpXLFTxgc6VUjUaktM96XCzB/8haTMFVmD5UkyBTkhBm+yQ+LHthcrKS/NT3XqY3tvIKkd/y0KtN3xF9lpktgwl5w4RgAkmPBNxphANkU/tFTbQ5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7FUu8pC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQqpI41j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764583233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
	b=b7FUu8pC3/2GQspxwkjZrB8Wuw/S42gyn3/ukt5scQcwVC3yvpN4+lo5lDOeBOdFWKzmfN
	u9tzHWEU8id+GDFQemVTBMUgQO744A9h/auLX/Ftz5ryDHbAT4lPxP5LUpPtcXmPe5E+/E
	pmfTXTCh2GmLXjkirVSakGpUKSE5c3w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-g7frSA3kO2i-3u3dZzTYWA-1; Mon, 01 Dec 2025 05:00:31 -0500
X-MC-Unique: g7frSA3kO2i-3u3dZzTYWA-1
X-Mimecast-MFC-AGG-ID: g7frSA3kO2i-3u3dZzTYWA_1764583231
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6407e61783fso3809337a12.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764583230; x=1765188030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
        b=UQqpI41jvylgUXJOW7tdS0/spCCJSclx4BDb+8hs8zDDOi3X+LETvp+v3kn2t3qUo+
         CG9FlRNVxJe9KdTZ5bQLw3Cq+vGIs2yNHQ/jY/H9FrmoVla5N9K55xORWcNhUUJ1lMHt
         8Zjhjy+Ong1ouE/Jo8waIT3RWXDqr8cboJ9g1IAC+YMnrke7gLv/GAPIHdv4emC3t7Vt
         QwsINOFqgVloVvAHjlH232XT0zf8tgTr1lT9Tk9kEzDMTst/tBlFkf/ZbrijrN4vctd4
         JPxhmcN9MVSn6NaPQfEGfiNr98wzyuwwZVaTziqBNBvxk5BaJ7JpSiq38UHPEhYiy712
         h2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583230; x=1765188030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
        b=FTd1HtHxIEJWHtyIjaQXj1jMfJrrzF1eqgGp0M3aVi1rdZR2gyVFcSPW/Q/BovjKKs
         Aa786HRj1MIjm+EJTvTbgs6HBL2jgdh/hqa/lJECO843X0VH9RMJ94A4Tm7+ye3NyEDX
         4sM+EboFwCy9q6TmY+/8UpBmM36KEq1aTqEPxHuIsAAxhGJRHKkRTzocwlfWmWVL9zHV
         8VSxl2usdseEVHivNRHmUBp3qOQn8PYQlBXdjdP8XQIfoyprfC2nkPmgcdckwKoC3a0F
         XJOpY0sP30eEvDDq/LlfjxhYEnPERpB0/m5xXuyr3F0PBRQ/ZvownQIxDRd/H+NTLdM5
         NPEg==
X-Forwarded-Encrypted: i=1; AJvYcCULPNcpJ54FA5y2ByXPfOaBQzOy18JFjr5fM/7pw2CW0XvN/UE0RWR6zppGYqe+1nQDzutszRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaE9BslyvqGEnjCItnSw0E9eT/ZZ5o/FHO6zVb/S0udv6BA6h
	1s8eHoNxIhNEDylLMNdvVU/F8H56tLrixN1OsXoP6mEYLU018skMW65z8Ppz/0Lh19gVDFjy2H8
	7Rab0HGVl0xO1P9xV77PpeEvIiOwwnx7mWGB+hTpmVTYhCQo2P+3gB10kfA==
X-Gm-Gg: ASbGncvU0r23YctWqznL0bdMd+FU0AJHDC8gYUwFRysQbKNFW/AGHBOYgwzi0qWn0p1
	Yfrhd8qjInn8Dp2I8+KnCHCYy1XHDHiDBxaK/12GggDX3dHiGnb0YWx9bcfA0Udl98lYFa5KKxX
	UM9Jz9+IhoJI+Qi6HgImyjiZEMOu6cjG1Iegw4ydPornaXO5TT5J8uBDqcS2UKSDZMUilc2c8t3
	nV3kmLcC10BYXtNHl01BSo1dj5UodjqhHz5Ls8rY2EMeyo54mhm8Fmznh6fiEsg/C1V8Kjf8X32
	lsSRpeT190gpiNVJ2DERzg/T02FacGHwTa+CiY2zDovYx4C/Hk6a73qGtc5KLSC4RhZ+tnNjKU5
	JFchwCRg8WJ9Vd88w96LMMOJytts8yK/Wfg==
X-Received: by 2002:a05:6402:534d:20b0:63e:405d:579c with SMTP id 4fb4d7f45d1cf-645eb793c7dmr16538833a12.29.1764583230476;
        Mon, 01 Dec 2025 02:00:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEZFO/DTo/b1fdjFPSlVw3QzKbOQxT9q26rUTTA71L9rHt/ZDnXlnQOXGxxhNxrrsar3RKTA==
X-Received: by 2002:a05:6402:534d:20b0:63e:405d:579c with SMTP id 4fb4d7f45d1cf-645eb793c7dmr16538803a12.29.1764583230042;
        Mon, 01 Dec 2025 02:00:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90e44sm11919273a12.14.2025.12.01.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9C71A395D53; Mon, 01 Dec 2025 11:00:28 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 01 Dec 2025 11:00:19 +0100
Subject: [PATCH net-next v4 1/5] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-mq-cake-sub-qdisc-v4-1-50dd3211a1c6@redhat.com>
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

To enable the cake_mq qdisc to reuse code from the mq qdisc, export a
bunch of functions from sch_mq. Split common functionality out from some
functions so it can be composed with other code, and export other
functions wholesale.

No functional change intended.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/sch_generic.h | 19 +++++++++++++
 net/sched/sch_mq.c        | 69 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..f2281914d962 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1419,7 +1419,26 @@ void mini_qdisc_pair_init(struct mini_Qdisc_pair *miniqp, struct Qdisc *qdisc,
 void mini_qdisc_pair_block_init(struct mini_Qdisc_pair *miniqp,
 				struct tcf_block *block);
 
+struct mq_sched {
+	struct Qdisc		**qdiscs;
+};
+
+int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
+		   struct netlink_ext_ack *extack,
+		   const struct Qdisc_ops *qdisc_ops);
+void mq_destroy_common(struct Qdisc *sch);
+void mq_attach(struct Qdisc *sch);
 void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx);
+void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb);
+struct netdev_queue *mq_select_queue(struct Qdisc *sch,
+				     struct tcmsg *tcm);
+struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl);
+unsigned long mq_find(struct Qdisc *sch, u32 classid);
+int mq_dump_class(struct Qdisc *sch, unsigned long cl,
+		  struct sk_buff *skb, struct tcmsg *tcm);
+int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+			struct gnet_dump *d);
+void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg);
 
 int sch_frag_xmit_hook(struct sk_buff *skb, int (*xmit)(struct sk_buff *skb));
 
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index c860119a8f09..0bcabdcd1f44 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -17,10 +17,6 @@
 #include <net/pkt_sched.h>
 #include <net/sch_generic.h>
 
-struct mq_sched {
-	struct Qdisc		**qdiscs;
-};
-
 static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 {
 	struct net_device *dev = qdisc_dev(sch);
@@ -49,23 +45,29 @@ static int mq_offload_stats(struct Qdisc *sch)
 	return qdisc_offload_dump_helper(sch, TC_SETUP_QDISC_MQ, &opt);
 }
 
-static void mq_destroy(struct Qdisc *sch)
+void mq_destroy_common(struct Qdisc *sch)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	struct mq_sched *priv = qdisc_priv(sch);
 	unsigned int ntx;
 
-	mq_offload(sch, TC_MQ_DESTROY);
-
 	if (!priv->qdiscs)
 		return;
 	for (ntx = 0; ntx < dev->num_tx_queues && priv->qdiscs[ntx]; ntx++)
 		qdisc_put(priv->qdiscs[ntx]);
 	kfree(priv->qdiscs);
 }
+EXPORT_SYMBOL(mq_destroy_common);
 
-static int mq_init(struct Qdisc *sch, struct nlattr *opt,
-		   struct netlink_ext_ack *extack)
+static void mq_destroy(struct Qdisc *sch)
+{
+	mq_offload(sch, TC_MQ_DESTROY);
+	mq_destroy_common(sch);
+}
+
+int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
+		   struct netlink_ext_ack *extack,
+		   const struct Qdisc_ops *qdisc_ops)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	struct mq_sched *priv = qdisc_priv(sch);
@@ -87,7 +89,8 @@ static int mq_init(struct Qdisc *sch, struct nlattr *opt,
 
 	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
 		dev_queue = netdev_get_tx_queue(dev, ntx);
-		qdisc = qdisc_create_dflt(dev_queue, get_default_qdisc_ops(dev, ntx),
+		qdisc = qdisc_create_dflt(dev_queue,
+					  qdisc_ops ?: get_default_qdisc_ops(dev, ntx),
 					  TC_H_MAKE(TC_H_MAJ(sch->handle),
 						    TC_H_MIN(ntx + 1)),
 					  extack);
@@ -98,12 +101,24 @@ static int mq_init(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	sch->flags |= TCQ_F_MQROOT;
+	return 0;
+}
+EXPORT_SYMBOL(mq_init_common);
+
+static int mq_init(struct Qdisc *sch, struct nlattr *opt,
+		   struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = mq_init_common(sch, opt, extack, NULL);
+	if (ret)
+		return ret;
 
 	mq_offload(sch, TC_MQ_CREATE);
 	return 0;
 }
 
-static void mq_attach(struct Qdisc *sch)
+void mq_attach(struct Qdisc *sch)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	struct mq_sched *priv = qdisc_priv(sch);
@@ -124,8 +139,9 @@ static void mq_attach(struct Qdisc *sch)
 	kfree(priv->qdiscs);
 	priv->qdiscs = NULL;
 }
+EXPORT_SYMBOL(mq_attach);
 
-static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
+void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *qdisc;
@@ -152,7 +168,12 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
+}
+EXPORT_SYMBOL(mq_dump_common);
 
+static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	mq_dump_common(sch, skb);
 	return mq_offload_stats(sch);
 }
 
@@ -166,11 +187,12 @@ static struct netdev_queue *mq_queue_get(struct Qdisc *sch, unsigned long cl)
 	return netdev_get_tx_queue(dev, ntx);
 }
 
-static struct netdev_queue *mq_select_queue(struct Qdisc *sch,
-					    struct tcmsg *tcm)
+struct netdev_queue *mq_select_queue(struct Qdisc *sch,
+				     struct tcmsg *tcm)
 {
 	return mq_queue_get(sch, TC_H_MIN(tcm->tcm_parent));
 }
+EXPORT_SYMBOL(mq_select_queue);
 
 static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 		    struct Qdisc **old, struct netlink_ext_ack *extack)
@@ -198,14 +220,15 @@ static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 	return 0;
 }
 
-static struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
+struct Qdisc *mq_leaf(struct Qdisc *sch, unsigned long cl)
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
 	return rtnl_dereference(dev_queue->qdisc_sleeping);
 }
+EXPORT_SYMBOL(mq_leaf);
 
-static unsigned long mq_find(struct Qdisc *sch, u32 classid)
+unsigned long mq_find(struct Qdisc *sch, u32 classid)
 {
 	unsigned int ntx = TC_H_MIN(classid);
 
@@ -213,9 +236,10 @@ static unsigned long mq_find(struct Qdisc *sch, u32 classid)
 		return 0;
 	return ntx;
 }
+EXPORT_SYMBOL(mq_find);
 
-static int mq_dump_class(struct Qdisc *sch, unsigned long cl,
-			 struct sk_buff *skb, struct tcmsg *tcm)
+int mq_dump_class(struct Qdisc *sch, unsigned long cl,
+		  struct sk_buff *skb, struct tcmsg *tcm)
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
@@ -224,9 +248,10 @@ static int mq_dump_class(struct Qdisc *sch, unsigned long cl,
 	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
 	return 0;
 }
+EXPORT_SYMBOL(mq_dump_class);
 
-static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
-			       struct gnet_dump *d)
+int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+			struct gnet_dump *d)
 {
 	struct netdev_queue *dev_queue = mq_queue_get(sch, cl);
 
@@ -236,8 +261,9 @@ static int mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		return -1;
 	return 0;
 }
+EXPORT_SYMBOL(mq_dump_class_stats);
 
-static void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	unsigned int ntx;
@@ -251,6 +277,7 @@ static void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 			break;
 	}
 }
+EXPORT_SYMBOL(mq_walk);
 
 static const struct Qdisc_class_ops mq_class_ops = {
 	.select_queue	= mq_select_queue,

-- 
2.52.0


