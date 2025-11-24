Return-Path: <netdev+bounces-241194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD24C81370
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84AD3A2CBB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A83128A1;
	Mon, 24 Nov 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLCuoYya";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVc56XEU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0D258CE9
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763996452; cv=none; b=rJ8U+NSOSbda4RwtjdJJTdEBlrf1bF01JjjMdeU6tx5ICwz8AiHy2vPiUwBmdcNlLnbFSeLN8TpCW4SC7NwuE53EZzSZOVA9CmtX6Cw+KvtKo83k+y0TXMQ4VXZWuzhBg2iR8jwgeQFtXOAaOsJs57+eG5DGQQHPPDMNhpSl4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763996452; c=relaxed/simple;
	bh=aFd8NvdBztwdkoVCp8XqB9Eu37IVDOW678Nwmow3nnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCUF7Gf6TiftzBh3E3ApbQmzniFKni6f+F/04qeSkpZcAW3qAC7iJJSpT2cylQLwc091Pweccf4LFoP4U+qaj3arS1S1zhfw3LV5GXux6msnwi7d3+s7qUWEXJ5FilTUdILPWIslsH2XgS5tkQgMoyOZ4ao8HcFogM3h0z3nsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLCuoYya; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVc56XEU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763996449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=biZAxt+cLYjE8fS+1mke514UvkZeQufW3fPNpa5azjM=;
	b=SLCuoYyaSAaWerBh2NgDIVsNWxZfMXkbDyUwRGyDSXnjxjEdB3MYqllO3i/VQmvde8MBqW
	2aLM90kmRC/BpaO5xDLDZxXXBUKn3Pdn2egU6ewxHocE+tMfF7oGhUjjc9Wh2TOupFWgSN
	yOVdmxLB1RzeaBs6k0VqGx3rRlLg238=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-nbSLXGbhP0uQcIvEfctw2A-1; Mon, 24 Nov 2025 10:00:47 -0500
X-MC-Unique: nbSLXGbhP0uQcIvEfctw2A-1
X-Mimecast-MFC-AGG-ID: nbSLXGbhP0uQcIvEfctw2A_1763996446
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7689ad588fso244085366b.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763996446; x=1764601246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biZAxt+cLYjE8fS+1mke514UvkZeQufW3fPNpa5azjM=;
        b=CVc56XEUSaQQMDaU6p273zh5NghVDjAuZC5qVSbidLhcDMVGwb/GEvAy6uQdkAJEhf
         sGtBAU3iU8HoRE264ECyUebqfEWdYO6MLw+kKMqj46R9iMnutp43cXDGpSgIk1/5dsNO
         QCtnMgwKqlSjoHiD9klEbU6ra1twpwlErIEz7OyWigvxC2JG8Hi8z58NlZpgYsF4phNn
         b7+w9HrGrY93AFZGuPiOe2q5X/LBPWARxmpwiKxKeTv6/QN6d9lVZgzC2DqvNuy9pUko
         3xq/C3yUZ359D8apj5Q827AIbF5sCvs5RIqHr24foItJYaMkbQjxnvSfj3xCobrQ9jT3
         IAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763996446; x=1764601246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=biZAxt+cLYjE8fS+1mke514UvkZeQufW3fPNpa5azjM=;
        b=PzvzX/4BGLayVoG8ZxIMH9oqbaUd/EcHMIvERRh7Sv3+cw0HAHXI8sgo7vIim9nZkT
         qgBhffKeCtvvaITunL67vpMRuJuIvrWsGxy745OQ1LxPOgcrarll63Qf5o6Ox83cMp7U
         NBeAw5869u4BilKh6KJooG2qqsckmzaNnzqC/hIJR74W9xq7N7wg1DXMD920MhHM3+g8
         GlI3RK59NXKNUC/zepqTsxUWJqQjGTK2zW2ToEDZr3LHImIjdvChi9MBSSIAo3tJmvcK
         vNlK7hoZw+fnIezIiZJbLe6GevTt3/vh3cB+if/BD80LUwkVs219xJEla1pn0CLx8J+V
         U3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWMwxHMXyjg6o5WYUpU7ZsPCNEAtWFtb/Uw/O8jmFZ6LeHVjgVJ9TJwEUl9E1QZU1VF79kDUJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkc+WYu0inemo6oJhcoHe6n1/x0nXnVAVMZS08DzmkF1XiZT9V
	l62Vg+mwTS1jcoESS2RljNLbCuOV0uq/zd2onqsZg5X/RCBsl3aEJ9u41FR1gWm5kvy78fJWBrD
	iV8XVyO8ocbCl3Z20xVK80tXXBtXn3N/AyAKu9tIqwdx7alzaJ9vNM56Q2w==
X-Gm-Gg: ASbGncsvT+rzyrjLgjppNrZQlXzaqC4C2oOA+No9+dLfTG99gygt6eLX3bvQb8HfUsL
	7jmYJjBRCMcNWT8O7UpjpynfT7fJmlMarLxJqok4Eo5ReUm6iMoAniakf/WPWS6ORSEWUfPkh7I
	UkjnUX+Bo9HpuXObbFCkMnqKSYcqNMQBa2cvnGBxL5ILsM0OAxDPSNICZPGdMdxlhOXaPYjd77L
	saZ1K8fF/bUg/VaVYaMPjlpdKgAR8/wvKNnztx7rXRExEYaMkhdDUVV7p0KAMAR8/xU4uBm5Wdf
	TdhbeKF/gQdXCshbCtEvaP4Ol9Pc6YGQtHZJdm18GMKA9Whvevytu2Am+IH6i2CxTqRx6pgYDHf
	8yxEQaokvdzg7MePIE/5szz0rB/UVqA7FBqeg
X-Received: by 2002:a17:907:9610:b0:b73:870f:fa2b with SMTP id a640c23a62f3a-b7671596300mr1302498266b.27.1763996445459;
        Mon, 24 Nov 2025 07:00:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoYq9xqVHY5KzVfQ6WLT5je0HRshq2n4TABgNVTF+tEgpP4rQfi0K+lg3Z+vZJHA9WDuYFXw==
X-Received: by 2002:a17:907:9610:b0:b73:870f:fa2b with SMTP id a640c23a62f3a-b7671596300mr1302461466b.27.1763996440381;
        Mon, 24 Nov 2025 07:00:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d50328sm1335323866b.20.2025.11.24.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:00:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4D30332A801; Mon, 24 Nov 2025 16:00:37 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 24 Nov 2025 15:59:33 +0100
Subject: [PATCH net-next 2/4] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251124-mq-cake-sub-qdisc-v1-2-a2ff1dab488f@redhat.com>
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

Add a cake_mq qdisc which installs cake instances on each hardware
queue on a multi-queue device.

This is just a copy of sch_mq that installs cake instead of the default
qdisc on each queue. Subsequent commits will add sharing of the config
between cake instances, as well as a multi-queue aware shaper algorithm.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a02f3cfcb09b..d17d7669de38 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3154,14 +3154,226 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
 };
 MODULE_ALIAS_NET_SCH("cake");
 
+struct cake_mq_sched {
+	struct Qdisc		**qdiscs;
+};
+
+static void cake_mq_destroy(struct Qdisc *sch)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	unsigned int ntx;
+
+	if (!priv->qdiscs)
+		return;
+	for (ntx = 0; ntx < dev->num_tx_queues && priv->qdiscs[ntx]; ntx++)
+		qdisc_put(priv->qdiscs[ntx]);
+	kfree(priv->qdiscs);
+}
+
+static int cake_mq_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	struct netdev_queue *dev_queue;
+	struct Qdisc *qdisc;
+	unsigned int ntx;
+
+	if (sch->parent != TC_H_ROOT)
+		return -EOPNOTSUPP;
+
+	if (!netif_is_multiqueue(dev))
+		return -EOPNOTSUPP;
+
+	/* pre-allocate qdiscs, attachment can't fail */
+	priv->qdiscs = kcalloc(dev->num_tx_queues, sizeof(priv->qdiscs[0]),
+			       GFP_KERNEL);
+	if (!priv->qdiscs)
+		return -ENOMEM;
+
+	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+		dev_queue = netdev_get_tx_queue(dev, ntx);
+		qdisc = qdisc_create_dflt(dev_queue, &cake_qdisc_ops,
+					  TC_H_MAKE(TC_H_MAJ(sch->handle),
+						    TC_H_MIN(ntx + 1)),
+					  extack);
+		if (!qdisc) {
+			kfree(priv->qdiscs);
+			return -ENOMEM;
+		}
+		priv->qdiscs[ntx] = qdisc;
+		qdisc->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
+	}
+
+	sch->flags |= TCQ_F_MQROOT;
+
+	return 0;
+}
+
+static void cake_mq_attach(struct Qdisc *sch)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct cake_mq_sched *priv = qdisc_priv(sch);
+	struct Qdisc *qdisc, *old;
+	unsigned int ntx;
+
+	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+		qdisc = priv->qdiscs[ntx];
+		old = dev_graft_qdisc(qdisc->dev_queue, qdisc);
+		if (old)
+			qdisc_put(old);
+#ifdef CONFIG_NET_SCHED
+		if (ntx < dev->real_num_tx_queues)
+			qdisc_hash_add(qdisc, false);
+#endif
+	}
+	kfree(priv->qdiscs);
+	priv->qdiscs = NULL;
+}
+
+static int cake_mq_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *qdisc;
+	unsigned int ntx;
+
+	sch->q.qlen = 0;
+	gnet_stats_basic_sync_init(&sch->bstats);
+	memset(&sch->qstats, 0, sizeof(sch->qstats));
+
+	/* MQ supports lockless qdiscs. However, statistics accounting needs
+	 * to account for all, none, or a mix of locked and unlocked child
+	 * qdiscs. Percpu stats are added to counters in-band and locking
+	 * qdisc totals are added at end.
+	 */
+	for (ntx = 0; ntx < dev->num_tx_queues; ntx++) {
+		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, ntx)->qdisc_sleeping);
+		spin_lock_bh(qdisc_lock(qdisc));
+
+		gnet_stats_add_basic(&sch->bstats, qdisc->cpu_bstats,
+				     &qdisc->bstats, false);
+		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
+				     &qdisc->qstats);
+		sch->q.qlen += qdisc_qlen(qdisc);
+
+		spin_unlock_bh(qdisc_lock(qdisc));
+	}
+
+	return 0;
+}
+
+static struct netdev_queue *cake_mq_queue_get(struct Qdisc *sch, unsigned long cl)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	unsigned long ntx = cl - 1;
+
+	if (ntx >= dev->num_tx_queues)
+		return NULL;
+	return netdev_get_tx_queue(dev, ntx);
+}
+
+static struct netdev_queue *cake_mq_select_queue(struct Qdisc *sch,
+						 struct tcmsg *tcm)
+{
+	return cake_mq_queue_get(sch, TC_H_MIN(tcm->tcm_parent));
+}
+
+static int cake_mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
+			 struct Qdisc **old, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG(extack, "can't replace cake_mq sub-qdiscs");
+	return -EOPNOTSUPP;
+}
+
+static struct Qdisc *cake_mq_leaf(struct Qdisc *sch, unsigned long cl)
+{
+	struct netdev_queue *dev_queue = cake_mq_queue_get(sch, cl);
+
+	return rtnl_dereference(dev_queue->qdisc_sleeping);
+}
+
+static unsigned long cake_mq_find(struct Qdisc *sch, u32 classid)
+{
+	unsigned int ntx = TC_H_MIN(classid);
+
+	if (!cake_mq_queue_get(sch, ntx))
+		return 0;
+	return ntx;
+}
+
+static int cake_mq_dump_class(struct Qdisc *sch, unsigned long cl,
+			      struct sk_buff *skb, struct tcmsg *tcm)
+{
+	struct netdev_queue *dev_queue = cake_mq_queue_get(sch, cl);
+
+	tcm->tcm_parent = TC_H_ROOT;
+	tcm->tcm_handle |= TC_H_MIN(cl);
+	tcm->tcm_info = rtnl_dereference(dev_queue->qdisc_sleeping)->handle;
+	return 0;
+}
+
+static int cake_mq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+				    struct gnet_dump *d)
+{
+	struct netdev_queue *dev_queue = cake_mq_queue_get(sch, cl);
+
+	sch = rtnl_dereference(dev_queue->qdisc_sleeping);
+	if (gnet_stats_copy_basic(d, sch->cpu_bstats, &sch->bstats, true) < 0 ||
+	    qdisc_qstats_copy(d, sch) < 0)
+		return -1;
+	return 0;
+}
+
+static void cake_mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	unsigned int ntx;
+
+	if (arg->stop)
+		return;
+
+	arg->count = arg->skip;
+	for (ntx = arg->skip; ntx < dev->num_tx_queues; ntx++) {
+		if (!tc_qdisc_stats_dump(sch, ntx + 1, arg))
+			break;
+	}
+}
+
+static const struct Qdisc_class_ops cake_mq_class_ops = {
+	.select_queue	= cake_mq_select_queue,
+	.graft		= cake_mq_graft,
+	.leaf		= cake_mq_leaf,
+	.find		= cake_mq_find,
+	.walk		= cake_mq_walk,
+	.dump		= cake_mq_dump_class,
+	.dump_stats	= cake_mq_dump_class_stats,
+};
+
+static struct Qdisc_ops cake_mq_qdisc_ops __read_mostly = {
+	.cl_ops		=	&cake_mq_class_ops,
+	.id		=	"cake_mq",
+	.priv_size	=	sizeof(struct cake_mq_sched),
+	.init		=	cake_mq_init,
+	.destroy	=	cake_mq_destroy,
+	.attach		= cake_mq_attach,
+	//	.change		=	cake_mq_change,
+	.change_real_num_tx = mq_change_real_num_tx,
+	.dump		=	cake_mq_dump,
+	.owner		=	THIS_MODULE,
+};
+MODULE_ALIAS_NET_SCH("cake_mq");
+
 static int __init cake_module_init(void)
 {
-	return register_qdisc(&cake_qdisc_ops);
+	return register_qdisc(&cake_qdisc_ops) ?:
+		register_qdisc(&cake_mq_qdisc_ops);
 }
 
 static void __exit cake_module_exit(void)
 {
 	unregister_qdisc(&cake_qdisc_ops);
+	unregister_qdisc(&cake_mq_qdisc_ops);
 }
 
 module_init(cake_module_init)

-- 
2.51.2


