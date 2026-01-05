Return-Path: <netdev+bounces-247040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB6CF3AA5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E982030A131E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72224466D;
	Mon,  5 Jan 2026 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1nLD4F/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL2adxNr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1C8140E5F
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617503; cv=none; b=r3O4jXdgYETN7zEvpVmZbV3I6wJM6R4dnGQIIQMEdKtqAFgd46QuLLlMLJGFJTqJjouV0F1qPvv27sJmPvlEWkGgP9F1cw5F19PN25RNJiOK67I2qwMx18xHVJwgV0avyRoxknoziJZy28ZgHXmLcSSI/EQTtnRfdL3ff8SH5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617503; c=relaxed/simple;
	bh=DDQ8mgIFNxt/vLn+lO0X5uk0KlwAqPXTmwsN7nJGRzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=freCPeiCendavT9RJNJO1FDvHjldRLRLRSDTjiZbwtOjCi6CNJ3bR5S94HmkiRT3TtX/w2QQHTeTPMz0HK989a5rrDfctI8u3WYDgTqi4hCwYEnS/n6OIXZbY4RcWq1IFPtR5rFx8I8frwDztMO7Y4zzDrQUHx5UJfBNf6jeG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1nLD4F/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL2adxNr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767617500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
	b=E1nLD4F/ctx1oRZGvSC/+EOKO7R/e+6KE+XXekJ5CXXLq7hOr5isHFALNPEPB8vtWIw7YY
	/eLzmYa5y70jagO4cWZwq56Aoa8B0MLMaEPPj4QKK0NXUfBE6XImdQvCHLDKmu4sqe+4fO
	wYmGOr2N4tZY1+fDYgPE3bbKCQp+P8g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-71z6BQ4vPsWrqPCfNpOMmw-1; Mon, 05 Jan 2026 07:51:38 -0500
X-MC-Unique: 71z6BQ4vPsWrqPCfNpOMmw-1
X-Mimecast-MFC-AGG-ID: 71z6BQ4vPsWrqPCfNpOMmw_1767617497
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8395caeab6so56158066b.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767617497; x=1768222297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
        b=CL2adxNrysVVBVGsP6GOxBZQNzO8cTGzcKQJVO+D6grNKW8ocTW5lDFD8C1Tu1gmcZ
         diD6gQGYoUZW/iKH9AgSrpBVHns9UA2dhswWYqVR615LWUAKH09Rn2PYAruG372/s06N
         BYcLOg2ymCNEOxmjVsSH90VExwmHrZX5VaNuK9NSMGBBbgTNlRh2B8IDew1KUQnTVPgK
         ZrI3hJAFDVupA5z+hDYznvQsM2FYwRPrgRcVl5MalTaXZA3n8VHVXqpePhg/cxHqNEtX
         niT6WdiuTnlm8YRTqiz7PwiDkB+RKh8fWrU8ov2wf+Ow1XS/PUZ9s+wNO9SyyUdH+qo6
         g/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617497; x=1768222297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YvsPs1ICShVhzZot0GV9I6SUy38v96hmCBSsHXFLVSw=;
        b=iTyuGKEk0mF+HHYTMnyYUrz59QjNf5VoJzS0Ubdy1uWakaEotleNG2Foi3aaEjGt4H
         jf1tJJ7asw+gvWEMoOxKglzGG+vCEeje+GV0/cCTrQB8BehMtB6NSyPfrooQEad9moXU
         tchzlFzfcQ4UwRiGmiwgjkS9wxFM5CxQIagcr7naF80TjkdawBkZihUvywevtrWZ9ehm
         OpoBALOmJTbIyTuCnan4xHBqGYmdbNuAvVpLmGrrlchkUV09Dzr0A5QCfhUy3OSkfYcY
         1IRtQBiGLqKVyQq7y8JbTMjPcWnGgRJwhC6CyvZsA3seRxjFHj9v8IP2KgU8wtg3by1P
         ll6w==
X-Forwarded-Encrypted: i=1; AJvYcCXXXl4XAsPaZHsJZDp1A0GAqPh54C5P5Pf4YYtgadxgg5d9EjnwE0G9l0L5k9QIctLDVDJOma8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+mUZUK5+Q+mg/NkqGczs6WcWXJCJpR647MBWugo1d4ZFi3wo
	TFm7tijRia7yIxcxx4nRDYxMnA0kUllLaKM8IcXwN5nnqtXT+XpOMA1J9n+9zEt2VZZoxv7WsI1
	w3vvEJXl1FdFvGSCcHsHrjagvj2PTWkr/sPgez+ZsUm+4Q+5CUvtoxE3kSw==
X-Gm-Gg: AY/fxX5sMxwQVJqrAY8btT6U2C7+4PNJGYlxQVzn5r3URoHNVCU+N+Cy2thkRAeZu2Q
	rR0FQb1gc2b/HCo+vPef0wgQmLI0XtjmWEq3688g9rxQiMpOoQhtT2VKd4uI8GbrelPSBo6jsi7
	+Z8FWdGrwZNRsslTlCbvR1d+DjmDtp8m3ODPDBvcSnwIoHFc+OT+LX4qPBJfO+2gETqvD44LSgR
	uvGp5+X+S+Fliw29xFfCaRFL3okP5rl+IoARDBXOpYaRdPzBdVX4yY1CWTMBEiLuxfBUhUwPTdt
	AHsqibOpGbG7/AyfY6iJpVFEpIDfLNrmcZT+mbBBjftlcIhbtZMlZ0pDu/hMTmQohtWSVfBfVnM
	T2GXxlNliNGtoNmWR6+sRSksr6xcgYRG4RNLP
X-Received: by 2002:a17:907:a4d:b0:b83:3715:11c3 with SMTP id a640c23a62f3a-b8337152c91mr3342312466b.30.1767617496777;
        Mon, 05 Jan 2026 04:51:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzpjSgeoVXOFbfld1yAW9nKVHTmH+geLqyP36nPMNVUMQZ0wyM6mjYBC6z/jONFF174DMp9Q==
X-Received: by 2002:a17:907:a4d:b0:b83:3715:11c3 with SMTP id a640c23a62f3a-b8337152c91mr3342309866b.30.1767617496348;
        Mon, 05 Jan 2026 04:51:36 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f512e3sm5521928566b.67.2026.01.05.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:51:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4685D407E8F; Mon, 05 Jan 2026 13:51:32 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 05 Jan 2026 13:50:26 +0100
Subject: [PATCH net-next v5 1/6] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260105-mq-cake-sub-qdisc-v5-1-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
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


