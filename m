Return-Path: <netdev+bounces-242214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC0C8D8F7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4B774E573B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9C32A3C6;
	Thu, 27 Nov 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYBPDW+U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFr8mVZq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52B32939C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 09:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764235868; cv=none; b=j5fsm+a58oMqI3oocxIGcoJDQs9ZQZhDhrD3qObg05opSkDu4d4G30qIItq60IYllJHEjNbrJ2ABvKvqTq3AV039GJDLpfm/cHWADjPE78xK3oMZxP8CSWORSMnlp0cjnxftUwwF8CnTTWBzX2n2JBi+6u9bVd/x4bZsLMgmtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764235868; c=relaxed/simple;
	bh=iYHs8iD6rdPB3xZDF6GXYpQSreMQ5D29aPOTbaWkmdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYIbZ9hrusK51moiCCMtTPz4Rr1QxesyaL5vvv/8XvvAQ9YaYhJ72tjy4i7+JZoch6MzlukOabxwZkrTfoGKDLz5HSaJ60C9GWbp0q1GEAJWBwYz04zTL6vrUhFLHRFx5QbAhIpQx6xI5xG+7ozd27CSZV9myY7VmgY6pP8F0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BYBPDW+U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFr8mVZq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764235865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/ztE5Gh+6OFo2w7ay2rtaaLYUUO8CXQN8E9A7T+pz4=;
	b=BYBPDW+UIfiK0OjevnYdrKL7ayHNxg/bKXE8/IqTlNZGGQIid8QJRqgu70QmwpfRg197Ob
	gaZrckdiRglYL6zXDIWogxXIsGhIPn5SwG88tIFl0zdORLOrie3KdlYtmqs2dVNL14WN9+
	FxrUqvHRqy4TB4Rg3VFRd+V97Y1sSOc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-1L37Tz3oPX2b4Fq6Nkea0g-1; Thu, 27 Nov 2025 04:31:04 -0500
X-MC-Unique: 1L37Tz3oPX2b4Fq6Nkea0g-1
X-Mimecast-MFC-AGG-ID: 1L37Tz3oPX2b4Fq6Nkea0g_1764235863
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b73586b1195so66055266b.3
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764235863; x=1764840663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/ztE5Gh+6OFo2w7ay2rtaaLYUUO8CXQN8E9A7T+pz4=;
        b=eFr8mVZqfbNJyfa+AUhZKWBLGoNkZNslPg76GugG8kJuhg2b5Jf4qqrGNt0Qca1e1K
         b/FQkMM3a2Apwu9e0lyWiPoMxJIIWTcBWnYX4HK+g3XXe6Zp6a6u9qdSH/lmFbiqGpwq
         ef7J9GfOgEn3RtI0KhKa85AE0j1O/IPHtnd2MHsuh2iPR2345UmhRVlD44WzrSHGYVFb
         wOUN4lrcrC1B5hRB+WQuDkLpeefUKv5Ux8VmLh+j3izSn4e5D0ITFAgyCNOgrmd3Lbn/
         NXi+ymm/BD7nY01kNn2y4NTtxS5OBxQn7jraqReFGm3MzE69Xhvn07dzWc8NxAnTIdum
         X+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764235863; x=1764840663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/ztE5Gh+6OFo2w7ay2rtaaLYUUO8CXQN8E9A7T+pz4=;
        b=EBUkeCQEGLCOg7+9mbtN/duWUoB8dgJ284E56rCu+hS8Qmjjn74Z+aJS4CMMnGj4sf
         N6wzSiofc21oVHPCmW39KEW5YkC6KF28Bp4nGeSJ/ng+QwZTRAYfggWpNSCcDjRHost9
         UOnpJYaiE++No5j00YZJcg3l5TKjIanGQ+/+3HHDVs//2IbaIRsqcf0BlUHJwID4zW4O
         dcnpXX+DBkxyE+w6FrVnoAPPylQ3bQLuSRIwaZ0IyqOgyQprwMCtDB/19wPWRZSNPkA2
         GEk43QcD9PP7hcanX7xn57W+4TjV5KFocbvvztKqdhNRGeuNVGPY4aBh4/+BVRb6uPi5
         tinA==
X-Forwarded-Encrypted: i=1; AJvYcCVbS5giqKMFgf6SEW5sRXdPs8EsjNViyUbCgKHWTCXX0D8Njn7OFKAA/MVX4Gv97kdZGUcVt3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsm0NcpqzDMZlbuvaYDXSgdGadzJZSbw/nhSbiTVh0Xu8ZRxEz
	RJsxRvIJZztB3XHtc1b2gmduYMzeptzGE2u/l3Gblu32PgViC8V6ufzFK+BMkImNrK6a2APSxpZ
	VNVpbkn41OEkS36Yi5arYBaCgxsCefswlqSLzuwyM59w/3zjEEItwBIf8pQ==
X-Gm-Gg: ASbGncsdubJrD5mVreIKCO5iFkjPKXLZC0shDRmI/oSCHzRs+8/ky5OdzpNowOlxKrO
	j3XKO/Q0ymqnNsS/lN4+2j/z6T0DwrbHzZKQW9E+xrWQXgtI03CG1R5VFq0gZHkVFPFKkVc4iM2
	PWtPiRFNXW6Zt69lOhdq9ExNrTUrz7hMYnYiJAaWXdILAefrXzt2vR8K9sbLd3WYrEFeRD051Dm
	uE9VDk613g0BbLyVTACuHHNUEVAEQTzvzPp1Co5YQdf/zLaxfmSeOI9jSI4uW94eqEnpFDC/tJ3
	nc87a7EObmvkORbSpiUZlBi8qIWpcaP/U9h2hLxvKeMm97vUOsBoBeFhiOq34+3Wle+OT3PzeWX
	MSl2I868rOkStsbj3HdSB79MmfCPNKH4nzQ==
X-Received: by 2002:a17:906:fe49:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b76719d0982mr2604963266b.58.1764235863181;
        Thu, 27 Nov 2025 01:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTvpYrWvjZRWZbXWU1IdICEem7flrk0JrYuSA5u+Dm05BmpoTfDxTwST+W16TgW9IsqUe9TA==
X-Received: by 2002:a17:906:fe49:b0:b72:b289:6de3 with SMTP id a640c23a62f3a-b76719d0982mr2604958666b.58.1764235862737;
        Thu, 27 Nov 2025 01:31:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aea6bsm107741566b.35.2025.11.27.01.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:30:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 455F3395703; Thu, 27 Nov 2025 10:30:57 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 27 Nov 2025 10:30:52 +0100
Subject: [PATCH net-next v2 2/4] net/sched: sch_cake: Add cake_mq qdisc for
 using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251127-mq-cake-sub-qdisc-v2-2-24d9ead047b9@redhat.com>
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
index 545b9b830cce..2e4b7706c57c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -3151,14 +3151,226 @@ static struct Qdisc_ops cake_qdisc_ops __read_mostly = {
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
2.52.0


