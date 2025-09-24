Return-Path: <netdev+bounces-225947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6D5B99CA1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79CB19C6BC8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26582FD7AC;
	Wed, 24 Sep 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSsEr5t1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0114C6C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758716194; cv=none; b=FoviZjymNI9sNgzKUKWvs19/OaVtSs9gwX5BWLG7yN3nUkF3o1PoyMm9YA3myXjiSoi5Eh82FtqiXsio7uHOuc4LUWk3/qU/9+zXPsyDjcjb5lz6OlWYmro5xu0H4f4bURYef/sEYxUOZ+wQNNKuSNsnFGfNqBFePhDMfpyIHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758716194; c=relaxed/simple;
	bh=VmjV9xif2fzo9yh+dOBaCvTXIibybTvenBP3bq9AoaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tH1qpENurENI3/IH9CtQyMC1EU6BrCeisiu/0D3+da1BUc4EW/46SUBSVm8aybpDTaj8VexXako+8iCnMljxdy0LZ4xk3WrF1uBX0/UDfw1wuQeFjCzfu886sv5s/b3wiLzgsBmQeM5X1E1uLHpOvVaaaD3obPlJO+hFitMZnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSsEr5t1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758716191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/wm7IctLC63LygWnrGMD/q6S2hZqhAXdl680aIcoqc=;
	b=XSsEr5t1M7b7rP1B/mqxvKP0IhwUgoiF26cfgkF/si6138qIosqQiUyIxSFAE2bcFMJ8sS
	98+zzjoGgZEo4lZTGSzK5roqjjBduwXivmxpr0MqpwG7cJUk+6eVrPqZh8p/m/WM5ypPin
	9qpzo9t99/4AAWQsphvaweARfxggeB4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-gD08YCQJMuqaUAZ3vz8g-A-1; Wed, 24 Sep 2025 08:16:30 -0400
X-MC-Unique: gD08YCQJMuqaUAZ3vz8g-A-1
X-Mimecast-MFC-AGG-ID: gD08YCQJMuqaUAZ3vz8g-A_1758716189
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6341958f08fso2956495a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758716188; x=1759320988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/wm7IctLC63LygWnrGMD/q6S2hZqhAXdl680aIcoqc=;
        b=SGnHs/s14nTBNTl4v4V5lyDcTtehtYpCZMzZh/BgzqSMj3l8o2ve3av2J+mi9+KDD3
         U4r+Tm5yyoOwXPJFrMThPO6DjvPLm5xnRhzekc6TrJdWOGm2YIGPrTLxdFrWXHcXTkjl
         RykwndZlI5VdXYW0n8azA0t1VCaosl3PkH5dEANR/FkH2IAX6E7Zc7r+rZsiJ34Ro2pa
         ujyOFnh42+uyG7sr9KYgKELa7hxVfICASiqBZ5PBBF8VI9OIgiXn0zzY9y4JsyW3isBG
         0+3gU/IdHwNwQ65NFB59OPIHS42O+tuAIviCpOTjuSrhQd6LmuIlBqWHb7m0jWZohjnP
         fKdg==
X-Forwarded-Encrypted: i=1; AJvYcCV468oQeaDB0fMH6Cp4sRA6dGfGw+uWW9/65Cu1O9rauEQcERrInGUcw2fKHCxsCOmex9BezUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE9T3GpGtwrWoRx9ExHvPt1hDDXB0qLbLl6DKa5oriefRBnNF
	19Z6OwwmaTFy2k9+K+hPgwm4GzMBoTmxwNftZsAy1Mfsfqt52IY+YT20m7u0ZsRXCtHatPajhnO
	hIVTk/I4+KDozaIoKygeYNHJlTSvbezu86jp12iexFlg0izWP0B7QPrDUgvem5HTYQw==
X-Gm-Gg: ASbGncs2zhCRIq4H47kxSd6gBwmaKQmzAXfEYC2585OBcEhhUgnK7C/0plAe6TguDs/
	pMUJq9OJntA5IJoR5RtvzR1OGKeB2HKxK3U+1d6dBlg+X9/TxDfP/lLmUm3kwd7hrKXGa6wTIiA
	BZEjdRtjHvCTBSIfAgp8mgimc9ZU6nVkkhsikhFRpDeipaSYoaM92yq7kKtECdQskzzqDt3d2VI
	b7b6pgzF0YoT1dhT3WX3+UtXTkh/c4IeV3uszuLHsiFXdjUb0C+jvkCh+/AlSTDgc7cn0KamjpL
	t1HWeabURQQA9qYczDi72s1MBJKVxj6xH5It+cjIeHJYNU6EUtE4UJzL4OUtgvKI
X-Received: by 2002:a50:9fa9:0:b0:632:342c:2b5a with SMTP id 4fb4d7f45d1cf-6346778e5a5mr4382072a12.13.1758716188522;
        Wed, 24 Sep 2025 05:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQPjbj28TOGPqizLArFiXLuBHfCOPtCCHCZg2mE47OYSUN4AjV8CdFX5XB0xRuazf3mBW1kg==
X-Received: by 2002:a50:9fa9:0:b0:632:342c:2b5a with SMTP id 4fb4d7f45d1cf-6346778e5a5mr4382053a12.13.1758716188074;
        Wed, 24 Sep 2025 05:16:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6344e493329sm5035472a12.14.2025.09.24.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:16:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 51C1A276E2A; Wed, 24 Sep 2025 14:16:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 24 Sep 2025 14:16:04 +0200
Subject: [PATCH RFC net-next 2/4] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-mq-cake-sub-qdisc-v1-2-43a060d1112a@redhat.com>
References: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
In-Reply-To: <20250924-mq-cake-sub-qdisc-v1-0-43a060d1112a@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add a cake_mq qdisc which installs cake instances on each hardware
queue on a multi-queue device.

This is just a copy of sch_mq that installs cake instead of the default
qdisc on each queue. Subsequent commits will add sharing of the ckae
cake config between cake instances, as well as a multi-queue aware
shaper algorithm.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 214 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a02f3cfcb09b50bda6ee66dfc8a8df584ae6a365..d17d7669de389bb21ca6ce3b209e0272cfaa5112 100644
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
2.51.0


