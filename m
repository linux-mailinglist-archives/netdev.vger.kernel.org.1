Return-Path: <netdev+bounces-248184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4ECD0535E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7543932948D0
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334F2DB795;
	Thu,  8 Jan 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIqoaaaj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kl//2PfF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0700296BBD
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891485; cv=none; b=ILt1R8z7CYLyiQC1F//UODsV+TR7t2FfLw9roLAm2ELHQAe2ezdG0jJ1zF91CWELdV7n+NL2FfOnO16dVORmMOif9aAYoI0JRYPnMnArwrOKRNDS1DpXcpTP48vCMjj85kVY30wRVAXruYDAQhGRX15Iy9kXHseN0AAPgTymWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891485; c=relaxed/simple;
	bh=JmuDeJxLItLOh/bZtOxtFm1LStfkTnXSGkMQRcDG4Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UuM8NRgxcE4IYGtoUBLZPIIYB2bF3ZC7ti3atmWX3mbZK9RrMJLKYcow9HA5HhBoZp6Jn2X63pd1QxC1XnxBYUGC8MDTsMT54GFnqQbROCdx03jRT6wxyxhqkDOhW4nz9heqra1qkoL7QeiNTJpZyUxWTGdoDpF6ZMTi2pFbOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIqoaaaj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kl//2PfF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767891478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
	b=TIqoaaajEzCZymlo2QBFtQoRUGyhrs8zaKJ7D0pvDt05G4kOk0sTO43bMDuo/1ZQQ9beL2
	RcWOvxuJgsLqQ4/CrndS2zk+G4qHzasTl5SyFafk+j4osddWhgBcDT16tfqjUrZTDK7LjF
	HbP0b5wp9z/IBmRHTHrTorPIo075I54=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-rCr31u-pOqCsrbI0O8VE3g-1; Thu, 08 Jan 2026 11:57:57 -0500
X-MC-Unique: rCr31u-pOqCsrbI0O8VE3g-1
X-Mimecast-MFC-AGG-ID: rCr31u-pOqCsrbI0O8VE3g_1767891476
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b763b24f223so526584966b.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767891476; x=1768496276; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
        b=kl//2PfFwFajP39WoGAIJ+mkKiVyaFHjrgcXbriaWut9cLF9pAxRRNnOL38KcnxfPL
         zENOx19rmghJm2cGk/OELIv/5uSF9M6Ebu7m/meJxmJdLkRvgScBs5/xdnRb4KvD555t
         kPd9LEyI/5XLM8bedMTCuuB0hL9HZL5hGBSUUk96C7US4IUufv3FhCRZxDnEXOq9dYeK
         SmygQVDAehezLJD6HQLpSduzIEGzUOP6PYAKdckg10ihDf3+GWTMSb/c8yDK/D++otDj
         pGiECJr3kgDeiSvezwu865iJYwf3bwTxe5E20DabvMoM2XllepXRsn+xQ3OzgWIqdktM
         O1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767891476; x=1768496276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
        b=ndyvTBFOft3aqqp/TbqK3ip3NY/fy0ylivS0vOhqXj7h0n6Y7eeYApYPCR482EvVKP
         hTtpj7JX4I0gB6g3RCSGRJPmvpA4wUgyI7ER9gZGzmqfSpHd0sxrBMBNlM9ZDWVJhucU
         S9KxjJjNYSH8DbAUxRGATKyDBCrQZ7tvFzu/Bgh7kmW27kgIwxVeN/KkyrMcUV9TnRH7
         LTc/g/pZ3oH163rxnlDzY5Ot3yMFjD1nlgvCOmtVaIbaIjs4Ls8WtWZqF/zpZFxunAqA
         jg18eHKzxl43je9QWoqXPRw/ZjM9SlosiWIPoa74aBSM+a7+3XNqUVqj84pm9NUBLQD5
         T3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3zRoSeKqmy1uazNEkOzfEOcf/j82AC1OIP6Me8eUBcovl/xyOPaVU3Rw8ATI5ppRuWQf6juM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2+eycrLwpEJhcOGG9LC0QAXpTlPB4/98TGOUnfIhoC583ktKH
	mVTOwXCsdQww2RtF0EhxbcAPci+k0h/eLb8cM4zNXKUYgsIdkAi78L/vSvDPciqS/4rUOtubQDC
	sULJYzVSKh1kLyxdZ/mhObeK4yEp5mS5Dw6HhPiBNceRV/dhtyTvhPxP/sQ==
X-Gm-Gg: AY/fxX6jYUU1c2+tR31C4N8oLzOKwdDz9FmsiX4zVzc3meFQsSq4S8wPrINwnBCXWqu
	YouYcgdni0F0ZNv+QGufC1q/pxQTD1s8fBNCclyPo+ZqSY4GBB66aWzgNA5vF1DTwTiEuOrt8EH
	hfs5iCnQUTQmjun4XNzoWGveI6UMiYuXr0HpyA2V+tB6uUS0g+mmSlSaBiyF2MYp+8rLN2Z8qz4
	u/xfc+jnU49AT6J7piLVBpLwVCVxU/4WTCJTTEnkZ3PVPF7qiczVsBc1biBoBjMujvkGg+AvJJ5
	Ku0P9MaZREO5plnaAddvgzJg3237+2XAr2WpkNbJiLfjAXbaMw3qvLWBV8w5ClpgTtCtKjLYwyW
	cSsyM7Ys7ZSXxmg09ztniuOy4qKaVmE2OlvW1
X-Received: by 2002:a17:907:7b8d:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b844518d800mr681809066b.9.1767891475820;
        Thu, 08 Jan 2026 08:57:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn3ywfuyYSJK5cn2ap/TME+/wbKHSEFmv4WE+49MUqOtr8ydi99dI6kFTLg3kVp6uHsoNGZg==
X-Received: by 2002:a17:907:7b8d:b0:b76:791d:1c5c with SMTP id a640c23a62f3a-b844518d800mr681807466b.9.1767891475386;
        Thu, 08 Jan 2026 08:57:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d0290sm855178166b.32.2026.01.08.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:57:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C5C3B4083BB; Thu, 08 Jan 2026 17:57:52 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 08 Jan 2026 17:56:03 +0100
Subject: [PATCH net-next v7 1/6] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260108-mq-cake-sub-qdisc-v7-1-4eb645f0419c@redhat.com>
References: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
In-Reply-To: <20260108-mq-cake-sub-qdisc-v7-0-4eb645f0419c@redhat.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?utf-8?q?Jonas_K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.3

To enable the cake_mq qdisc to reuse code from the mq qdisc, export a
bunch of functions from sch_mq. Split common functionality out from some
functions so it can be composed with other code, and export other
functions wholesale. To discourage wanton reuse, put the symbols into a
new NET_SCHED_INTERNAL namespace, and a sch_priv.h header file.

No functional change intended.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 MAINTAINERS            |  1 +
 include/net/sch_priv.h | 27 +++++++++++++++++++
 net/sched/sch_mq.c     | 71 ++++++++++++++++++++++++++++++++++----------------
 3 files changed, 77 insertions(+), 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..01b691cb00d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25446,6 +25446,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	include/net/pkt_cls.h
 F:	include/net/pkt_sched.h
+F:	include/net/sch_priv.h
 F:	include/net/tc_act/
 F:	include/uapi/linux/pkt_cls.h
 F:	include/uapi/linux/pkt_sched.h
diff --git a/include/net/sch_priv.h b/include/net/sch_priv.h
new file mode 100644
index 000000000000..4789f668ae87
--- /dev/null
+++ b/include/net/sch_priv.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_SCHED_PRIV_H
+#define __NET_SCHED_PRIV_H
+
+#include <net/sch_generic.h>
+
+struct mq_sched {
+	struct Qdisc		**qdiscs;
+};
+
+int mq_init_common(struct Qdisc *sch, struct nlattr *opt,
+		   struct netlink_ext_ack *extack,
+		   const struct Qdisc_ops *qdisc_ops);
+void mq_destroy_common(struct Qdisc *sch);
+void mq_attach(struct Qdisc *sch);
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
+
+#endif
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index c860119a8f09..bb94cd577943 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -15,11 +15,7 @@
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
-#include <net/sch_generic.h>
-
-struct mq_sched {
-	struct Qdisc		**qdiscs;
-};
+#include <net/sch_priv.h>
 
 static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 {
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
+EXPORT_SYMBOL_NS_GPL(mq_destroy_common, "NET_SCHED_INTERNAL");
 
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
+EXPORT_SYMBOL_NS_GPL(mq_init_common, "NET_SCHED_INTERNAL");
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
+EXPORT_SYMBOL_NS_GPL(mq_attach, "NET_SCHED_INTERNAL");
 
-static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
+void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *qdisc;
@@ -152,7 +168,12 @@ static int mq_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
+}
+EXPORT_SYMBOL_NS_GPL(mq_dump_common, "NET_SCHED_INTERNAL");
 
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
+EXPORT_SYMBOL_NS_GPL(mq_select_queue, "NET_SCHED_INTERNAL");
 
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
+EXPORT_SYMBOL_NS_GPL(mq_leaf, "NET_SCHED_INTERNAL");
 
-static unsigned long mq_find(struct Qdisc *sch, u32 classid)
+unsigned long mq_find(struct Qdisc *sch, u32 classid)
 {
 	unsigned int ntx = TC_H_MIN(classid);
 
@@ -213,9 +236,10 @@ static unsigned long mq_find(struct Qdisc *sch, u32 classid)
 		return 0;
 	return ntx;
 }
+EXPORT_SYMBOL_NS_GPL(mq_find, "NET_SCHED_INTERNAL");
 
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
+EXPORT_SYMBOL_NS_GPL(mq_dump_class, "NET_SCHED_INTERNAL");
 
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
+EXPORT_SYMBOL_NS_GPL(mq_dump_class_stats, "NET_SCHED_INTERNAL");
 
-static void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 {
 	struct net_device *dev = qdisc_dev(sch);
 	unsigned int ntx;
@@ -251,6 +277,7 @@ static void mq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 			break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(mq_walk, "NET_SCHED_INTERNAL");
 
 static const struct Qdisc_class_ops mq_class_ops = {
 	.select_queue	= mq_select_queue,

-- 
2.52.0


