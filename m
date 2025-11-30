Return-Path: <netdev+bounces-242841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC370C954B4
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 21:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9EC2342ACB
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 20:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3382D0602;
	Sun, 30 Nov 2025 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSV1Jr4X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCiUmrzA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21EF2C2369
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535056; cv=none; b=HgG1wJudFkHuTNcbCdq9K28dwTlGFuoOEWfQdYESpmawpDigoTu/2DF+HXJj7ne+hvg8cyFJBdZ10nsDea1fX6wnAD9+zp6sTCvpoSU9rH4iSin+8oyQT4Tdc2iZeMxnaAz8WznNhuSpv+5S4hPJbXljCSduZDx3IJFPbrZRJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535056; c=relaxed/simple;
	bh=T+HuXpkVGkt6IOnP2E84wTEldx0mMIWs5fysjgmICTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Soh+nCHV5BULN7IHIL6lFdVbn/8QWuT5T1LgN3usJggbaBA4vRwl6bSOrM1Dt6bQ9tNy18zwFonqSCj3XwyV2yZpYAJYYDI93lpuBsH11wFfX9JzzyDUCKUCueInRxPCXmSaJxxb/jnW9ZfSZJUlRk8NSHAe8O3IJ8WNwNA+YlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSV1Jr4X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCiUmrzA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764535052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
	b=LSV1Jr4XxcPaBN1mgachIiSX2l1HCArdOa56r88TcFVZyyUtw1f47MKB/whYYB6P3X6mWZ
	cE4CaNlg9nDIsPqwGdlV5Pbsn11N0/sFRAzek3L0Ta3Ibsaiyiaj0vfJ6xu3t6MNcgaBft
	w69e7KzIEFbvX/v8T2eCMVq58SWhkt8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-4WX6UWviOuGbVddbs5xOTQ-1; Sun, 30 Nov 2025 15:37:30 -0500
X-MC-Unique: 4WX6UWviOuGbVddbs5xOTQ-1
X-Mimecast-MFC-AGG-ID: 4WX6UWviOuGbVddbs5xOTQ_1764535049
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6407bd092b6so4450522a12.1
        for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 12:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764535049; x=1765139849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
        b=aCiUmrzA30vpZppkt2TF9gO57Ag9u1fBZF6mZyW/LJywQdb7q1wc+YHkEVhmB5+teS
         Vqvfr6Fm9Dc1rZie66+Ba8dPaSBA9dNIibAgRosvx2RSTUQreLDiDWMSwG3uz75PAXSa
         6b72NYXcJegpUWECIe0aT9DIwTKQ6JCWzCwpGnR57Ixx99axs75cRzoaRdb/Dnb3631i
         OqbWuvW1LOAwBZgJ8HWM9DuwLqF1SmkHotg542ObGO9c8Wvd2H5Zo/gtsa2KiDwZu2m+
         Vd9xdaleRRF9kARVTu+B67HXTS7QnJwBBfuhBV95QTgp7HB/vB9y/PZLoD3TB+izMnlb
         JOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764535049; x=1765139849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XuaBOxVGfv3i0x8OoHvnBN3obdERZLRjIu9QG7xhJvM=;
        b=RjdgSt5EaIzku9eFnU5JAQfuXV4OvGQbsAnt4/U4K5EbR5AMZHB6vwdQGGi36v672k
         NQuUt4xRXg6pGCEMa7rb8xO1ROulYKmnljZFseMP9jubF52FLX7GhwI4P3augwolWz9x
         cM1PqojpL04oVRmfxNKTf9AwlalogD0Nmv8YSCrWB9ZeJrv1eh31U77nEqaq9HFNyOdF
         BQ2AZmD75+EP+W4UYdWFgDSLW2TfcorYoa0IxqC/9YiUC3lCLli1uBIsmm0BVORvt6yh
         PUY7qCfNnT75wN//V07yHZ+8+E/gD1guXd6PS1oOF/VTqjk5Iscw4McyKIWM7edoda3R
         c/pw==
X-Forwarded-Encrypted: i=1; AJvYcCWXPfL1MX3YXeRRjuKJWSdAyNlcVi0sGfxKJ/PWS6B3FVzCQvYIG3RVUQaNodQ1+xfs4qrHn+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdShimOnEp3UtORiFxgCvAJaYO1hkJnGQWC8eFjDWDQDGQcQw
	3IXHle8srdk6yND+P1YR/H+IaHfrW1SkY9uYTfB/U/nJf9eXWycQlUkREHzul0oZFYJHuFnzKra
	2ynITRTfyy79ry8xEsVuY9UpIpJMslBZOiLDnkx7elYVgkc+5BFOxN5XncQ==
X-Gm-Gg: ASbGncvR0pbAKOQz5fdqYka/Q3AysunyxKGb+WC6YId3twSMqqtswj31X+1RCkubnxh
	0UbrQ36B5EyibSL410z6O3qedwM+JWAQq0msH+6p7WgDVpPd03AZ69ZWhixquHm5QamccHStK27
	Hm8mB7MsNasBP1Oj4arLZWY+Ib927wT2tmOKMJS5rtodZLhWCzW1ivn2zk9S6bSY5BrmD3vvuWv
	lUs+x8lHnHiDBjFY+T+njO6dg6EB5hENsSbbV5T97NgHJ/6N2O7gOeXRd6lZgIRF9MAB+95SWoY
	eUB8GGzF5SFenD4UaFd0sdgVNG8hoLxacmQPCE5sp69JqVt+idQnP2XDeZR0C6D1DTnTGkaaQpJ
	ECg41QdEYZy6292zMxylOgCofncJMH03usw==
X-Received: by 2002:a05:6402:1d54:b0:647:57d5:6af6 with SMTP id 4fb4d7f45d1cf-64757d56b0amr9589871a12.6.1764535049166;
        Sun, 30 Nov 2025 12:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkDApVv3/OcM+GvAVWyG75ZHChEZkM3/EWGsMTy10NmN4iMuN+sJGSVZjWBaMvmIsd7NWGwA==
X-Received: by 2002:a05:6402:1d54:b0:647:57d5:6af6 with SMTP id 4fb4d7f45d1cf-64757d56b0amr9589856a12.6.1764535048791;
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90c93sm10255087a12.9.2025.11.30.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 12:37:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3B44F395C23; Sun, 30 Nov 2025 21:37:26 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 30 Nov 2025 21:37:18 +0100
Subject: [PATCH net-next v3 1/5] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251130-mq-cake-sub-qdisc-v3-1-5f66c548ecdc@redhat.com>
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


