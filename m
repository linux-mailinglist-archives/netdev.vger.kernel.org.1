Return-Path: <netdev+bounces-248497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E85ADD0A64B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA6BA30322F7
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598B35BDDC;
	Fri,  9 Jan 2026 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhJKb0Jk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiuWr0Hg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839E2E8B78
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964545; cv=none; b=UVM0/ZeAlvWijjyn96HCiemrKdm/15D/mLj4gO1BcMjaFGl+mBGrvFsALNsw0XjhWgW4dUwXhjXS4XqSdyQOl+Of6jCxL/Z0wUDWXqoxiahbNVHfksjoyu1i2u+Zf1jrTn1ZUbd1+e3Y4tpRS53+Ynf0iZK9T+S+SiTTbnlUEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964545; c=relaxed/simple;
	bh=JmuDeJxLItLOh/bZtOxtFm1LStfkTnXSGkMQRcDG4Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvYAs8El51J0q3uKo4O/gjopkyl37lvhO11M/oplyWUu7lX861G/bprAX2oR9tJmeA60m/4LYhHebd/pRX6QVdpv2Xt/d3oSr2/b8zMG8MYDd2UtGfylK04HRU3IuNO+YVremdNTFEAAkQG4bZmQmZMCimpeqiyP0gGgCMPvyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhJKb0Jk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiuWr0Hg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767964542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
	b=fhJKb0JkiLgxTDq6YHCV69pHjZz3mYzvPrvW7+fKyANw6GbajlQHT8bXXo9rqLlEXHApOq
	f1uEuKVto8Z5r9KFMvdQicUI2d4IZKlsf3MIOcKj+T+qgsOeynHKLKPJcUuPYV5vp4QUXq
	vVv6tnRAvbNOMfVxqXipnGSD6mNS7Js=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-mivcOCjpNLi2lWM7LIpTHQ-1; Fri, 09 Jan 2026 08:15:41 -0500
X-MC-Unique: mivcOCjpNLi2lWM7LIpTHQ-1
X-Mimecast-MFC-AGG-ID: mivcOCjpNLi2lWM7LIpTHQ_1767964540
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b844098867cso575857566b.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767964540; x=1768569340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
        b=XiuWr0HgDK1fGMD0vcFpyab+l9gUmBg99Z2CtxObABphnHlMoD+Kzk5mKE3avO5a77
         pvD7qqS+bE9YNvwvURODsRvQb0g/t3LZdjBXNzXRYVR+s1JxlF+v+/plsMYnUfxBF477
         CdofTPqJ3VSMOXbP+VZHhChSGgqwuMnKXSC4bCTsnkYLVqZIX03zlh1n7i9S9DHHJScZ
         VUGYdlugJDHz3nC+yxZkBdk6RhURaZUhyiqu4H3fR20Ss+pPPMScuV39sUkN51v4G9oI
         T+G+E70QKZZHn/ekSVJwsVf0/HXny+9QsSzG3kx8ynkdSBEJ+hPCYt0xv2hYAMm9bDEO
         +csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964540; x=1768569340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w0VRQtyWtlpjzCobkhPA/bxrDXQwuOX3Zf3Yncleem0=;
        b=buosVmhIPtBqlE3Iom86xymcdGMmiubXbR0JWt+Q5KPWtgcpfaSQjinGcz7cPvSuqp
         g8e5038+78SVSs3yIGUn94ROXmBathFUNSNah3f9hbY7REG154TUgpkYt//0lnDEh4+P
         f21GPxGugyxWxvx3a/SmLFoysAUNA48o7ZRTn+3VZIrB3tl+CCAQ1CCYqsHKD+qadSkA
         fKi2W+BUFzhNUuH3gtw3errlobyHBD59UECnabnHYOxCaeWuUsRqI+MsaIi2GA7er76g
         78J429nJPAZHdj5GetegtIEQW1ZDE0lo/3NXdT7sh+klNl41TR0pgtqDSLpHFqRzz4fN
         tMYA==
X-Forwarded-Encrypted: i=1; AJvYcCXBtJqAh9wctApSt93kzI+/btqqJB4JJ4zPWX9mP9igYL44kUPmYVYk4fkTXCBBjeuedVQAqQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77/1bN9eKI71frzD0laC+aQV7qkQjZmYtr1E9gQAb9xUgQYo6
	IX6S835K0fwohw5Q1sYLO78R1+bnNhkrZNK9B3n04Xp3DlEHgBGAbWvELN6h4mTS8eBh9B143Jw
	VssswYYvPQBW+c5fcQuvRwHhfda+5kR9jvPHZ72zQafgg6iVU/wgHG4NpvCkABVnANg==
X-Gm-Gg: AY/fxX4C9fcKGWPYNxECCuKgIZBoEVDZT03ef3hWTjxO2PQQI8yQ0Vsm0FEP3kfyMeY
	5uC+HoU3YCvXHASvVtrZbZgURrSiYKvLmYVtp/A7c8nCGrzLJpEYBtnH4RyT+R2fSibMdrVW+zw
	OaFZ3pDZzxQ6fvRKdMp2808C6V0CdNkmN8okAqVCsi+5HzdQ00I8o4fjGnQPqoUcFgJMIlcMVMC
	UEbttHYaGNDN4Y/w8/xIE+AfJKrnyH45Cri8ymX7RfRHDajw22Cio+/DPinp+xpIVu+4oMwnwv7
	v5P1PzMECbLTa8ACRiwoVxnSZdjV0vKXNqtNlRuhWoxyfiBECgqluWZxFZGH0G6VCy//8lmTd01
	Ym+XxrbYju/Hstw1lvLTq+TNQSmxeEBR+zw==
X-Received: by 2002:a17:906:308b:b0:b84:5818:6130 with SMTP id a640c23a62f3a-b8458186688mr560322066b.43.1767964539816;
        Fri, 09 Jan 2026 05:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH45xvXr+lcQGLbKnMK5yBtPFXk/FS9cYJ0UFOTrHw+lBHOvqC3FjXhRg4jcYDezUMT+23iCQ==
X-Received: by 2002:a17:906:308b:b0:b84:5818:6130 with SMTP id a640c23a62f3a-b8458186688mr560319366b.43.1767964539334;
        Fri, 09 Jan 2026 05:15:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5118eesm1098642466b.52.2026.01.09.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:15:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2253240862D; Fri, 09 Jan 2026 14:15:38 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Fri, 09 Jan 2026 14:15:30 +0100
Subject: [PATCH net-next v8 1/6] net/sched: Export mq functions for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260109-mq-cake-sub-qdisc-v8-1-8d613fece5d8@redhat.com>
References: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
In-Reply-To: <20260109-mq-cake-sub-qdisc-v8-0-8d613fece5d8@redhat.com>
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


