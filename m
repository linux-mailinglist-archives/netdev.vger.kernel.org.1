Return-Path: <netdev+bounces-247350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77943CF821D
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 12:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7CE6310D160
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 11:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A633439D;
	Tue,  6 Jan 2026 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLg4azyR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vee1X9+d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB133344B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699668; cv=none; b=L5UJsjfnlHELMiAHdEBKx1EK2pKZ1h1Y4sZ1vdUA0DvDXCmKZ0sjRR0jMllSk31lXdMNn1owQ6DyMoe+XWgAAudiZFviyslcQUqiHD4oL+KKy2AGQUvSQ8G5aCUSF2QyaOIaV2YdA+3MDBKmVUEOcLCaKVWRZ47uvDbypIVCTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699668; c=relaxed/simple;
	bh=DDQ8mgIFNxt/vLn+lO0X5uk0KlwAqPXTmwsN7nJGRzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGoKMBLyFnuOwCjOXJsKgtEGlj9yXQvsDzKhvwd+AhyN5f3AvM8T/d3J/yeuzV+W8pVLZx10uBiwGBJ+S8hmXCXHoTes6HtvgZ+ZkdhzDKnHZw/jwGCq46ADd81dGHOheg2Nfm5VpajDXyZZ8jBK9wFzFCTfzzLotk0x5QnwiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLg4azyR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vee1X9+d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767699665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
	b=hLg4azyR3C2LcRsGg/mJP469zmoCWL9LIeOpwxG829rte4vULN+WNyE+hiTHJTFBEvhXv7
	Ux//KDZspQwLo4AKBP071nxqF8oMaAayU6rK67spfjlDaGpX3ScSaTkQ/bgpBXzrpRvM50
	UxBW3GR6MlZZQVc38TpgsYEngdgnEaM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-8MBPED0pNrysdGR1hmN5fQ-1; Tue, 06 Jan 2026 06:41:02 -0500
X-MC-Unique: 8MBPED0pNrysdGR1hmN5fQ-1
X-Mimecast-MFC-AGG-ID: 8MBPED0pNrysdGR1hmN5fQ_1767699661
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7ce2f26824so84903766b.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767699661; x=1768304461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
        b=Vee1X9+dtTvOXWxQ7jNj7QPmFbL7KuCnAp+ESe6cpDvCSaGDEhJM/SYtaKVPSgAm23
         zjHL8L+MujmIR3ONIDihw/aUnxSXvyLLj6+xaroq5JXGmav1PACnakFGRRSC4kHyaRSI
         HEiATTLKcWe2F28f8i99vNUSBjdLikmuASgsxd1RShb6BxepCQhPVUghJ6AfvjHSEKru
         wujrvksErcVAS7cwN9Nxbo0LC60pkJ7fOWv9G28DKsnHLmyCqSFR2vTuHU053Y9iS567
         qhzM5hMPixlYrHwD1FfLwOFFAHnaOe3BlV16qEgijhC4c46bXZMyWLrTSwqCLa3Dob3V
         PNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699661; x=1768304461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
        b=ksgZgGiY0edAI1blrkRYyqk8nUpRlYHDt3FdVSYQXZA1f17A+OFaz8QXnYh2Qxx4mB
         GbfPnpYGAizGyJl4nSe973XeFJejQ3CqaQPDa+qYZjzH28jiXmDRfnCWlELGYM39UDKr
         6PKZWbUFHO1HuZFBVCWAvoe+qdw8i13lWdp0B2/Rvm6AM2nJyboZqK9jAqkTVob5CNS4
         mUajVjuwS1K8CB2ue8xsj+bFcoWBT2DieKjob9hme2+oIOZumHZWrjQzUaWxFuwmbLAK
         SA/3qUd7vJoDyClXVW5qSaYt3MrIxLOsXNY+MzSqgAlV2NSkvBruWQwly/3Yh+hmk7XD
         +BBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHrkuq6aLQn4Q6KmW3WUM1PuOSS8KENSQ4a1UU4XuLkY0tFakA/MszWNPjFZnlqEtOHOBHR/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztbMJldSZfa27JKihkkZ3UPsjX569rGSjYDKNVsvMA6OdO2nU7
	QtoqfEBkEEYDbMVaSPs4PViqYXJVUDzxBNue+baOASvOaj7AKOwtwtH5Szyt2S6kQ3FB2OU4Nkh
	PZu9qSX7BV4qaSZHRPD5lv1zblCB1zzl4D3lHolTmH6LzZpwSYwDWHo+5Xw==
X-Gm-Gg: AY/fxX7+WJ7GU581ifKSqaR9k1gZ0IGDVenQRKYO0I6cf85qDeuxfRxbAudQRzhkv/p
	jRmy5pno6+bKQChoqAB4fe+fkXeZflNFUf3WjTNTaSt1Qo6PFWXAmQHQOHaOmVu9SwE7fX1VIKI
	0lPFpkqRRFz54mCd+EJ/eBUKOAAtKidG2I7VDtA7EANBV7wVrFwKtsgSF+NhyWesg52mO+blbZ/
	xv+HXJ1uTArnx78JbUuiTeUUvohbfthxW4Km4KZbgZkjpyQsC8+s5FminuWOXsoF9GXdQAdHUol
	M5+YHHSG0sPCrqHoQG17Dv3KtnpNN18hYO9GszZWRh9ZWNbT/v1Y+7gm36rlVfPwtVNp7zWXYTO
	dD1I+y47/brqztWCfoIp0Zrca7D4njtAO37nN
X-Received: by 2002:a17:907:1b0a:b0:b83:6e2b:890d with SMTP id a640c23a62f3a-b8426ac78fbmr306073266b.25.1767699660993;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0wx7ZkrHr0gAW2RumB5kgKuMENbMiLC7gkypJN0uY+O0GJfBpH/v5uInZIUKRlusXcJqFCw==
X-Received: by 2002:a17:907:1b0a:b0:b83:6e2b:890d with SMTP id a640c23a62f3a-b8426ac78fbmr306069666b.25.1767699660504;
        Tue, 06 Jan 2026 03:41:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d3229sm200692966b.37.2026.01.06.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:40:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AA275407FCE; Tue, 06 Jan 2026 12:40:58 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Tue, 06 Jan 2026 12:40:52 +0100
Subject: [PATCH net-next v6 1/6] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-mq-cake-sub-qdisc-v6-1-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
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
functions wholesale. To discourage wanton reuse, put the symbols into a
new NET_SCHED_INTERNAL namespace, and a sch_priv.h header file.

No functional change intended.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/sch_priv.h | 27 +++++++++++++++++++
 net/sched/sch_mq.c     | 71 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 76 insertions(+), 22 deletions(-)

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


