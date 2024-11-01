Return-Path: <netdev+bounces-140849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4579B87D5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE78EB22141
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E138FA3;
	Fri,  1 Nov 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="kBPdms8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F831BDC3
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422158; cv=none; b=efPDE8Voe4ZY09zTfRK1EfHJqdpm1MAc2eZopQO5qcuYTqX4fHaWtDIl4kIX6vsMvvMC0iw1TCiRafnqy1YGBk5IJQw5l6wkHN7MZ2W+vxU3UzKGZF5MWh5HMWhCUva7CkLD0EkrxgC37XqDtyjenvFS+jgy/y4fqtMwz2WtiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422158; c=relaxed/simple;
	bh=BbiMmQ9lhHSZwz2GE4uUBK215d1RjaKUDOHmpZeB798=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oT4IpAbyZoXvo+MxVncDF/GPXp2B7KpQHZvEt+dxOyyqKg2Q3JTmwTj3s1TgTBZjWm9Wc6H0CMiUjhkn5e95ZVoiKdkdZS+kQJVy9uKbNdWzwpeTlp2GVNGU24ViApainvEgEexIbgbI4eKUnUtiETIIsYJF8+VinSYvyw5ltQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=kBPdms8z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so1147592a12.3
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422151; x=1731026951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQwJosGQqGKWCzWvyn5N2YN0Mkzhky7gbPUGL1mnPGo=;
        b=kBPdms8zwj2G72EaH8cF79A7VlhIWhIuKrVkkV/rVayIQLJj8/pYBrMDP9DzHFzO0E
         QOm153ostn3ugy0WYCgEogiymkE4gbYPrP+e11MutWpZhFnwraA/cNV/nAuC32JxKtto
         kedpCU4bWsJYZI0hG47+UlUNOiHpC9DCDESGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422151; x=1731026951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQwJosGQqGKWCzWvyn5N2YN0Mkzhky7gbPUGL1mnPGo=;
        b=rnzCW/5rTHn6K5b2wneHbIxGNhNDHIOXYNg8EJZborkia9tvCPzhinOaT3PV3awiMQ
         y4hKpscrV3Rvc32DGze8fVdU/IclPWjkOhxr7h+ju/SYjGJu7TWAzHYMz6fX2HbP1qFy
         K2f0RvPik8aUmbRsePN9ioRsYCzTYIZpkXipxGZB3dZPJR/EhDsoGbcz/jGZY20zAv21
         W7hWBDXEbwZlagyO0P0X09J1iE0l0paRDom3eP0/rGG/VMjxDX/b9hXBug3MSFfL4srh
         p2sBuEjrs0ySIfVl3wXZnXoQmxCgqbg+Niin6x27xg9O6FRqt8bI0RTGvQ6AndliH1da
         n8nw==
X-Gm-Message-State: AOJu0YzsdB18m3oIWU8hKSq8tNWrmXJawAZO1EOB+k09Wy5wtndwjMwQ
	86jQWz6D624odj6TqlF5yhLHa731twTzvYrWZTkauJvC062CwtdFSxpdXFcBsTxD0+ELdLtQdMe
	OCpR8OTNaPn2PR6g0V6HwPzlBAGqOWoV1Cxhx6b63g/ToFAeAhYttiBfKaztXR0a1TWYXQ+Z9xq
	Bedjx6Auz3npGJRlNIdHm7Gx/yHgHIAAs9XMI=
X-Google-Smtp-Source: AGHT+IFH+MwGe53WeQGFbHYKRVHLNYqcQbbMSoQAF3kRqudHNgLybQBOPxcygcY5dwLE43cd+o04sQ==
X-Received: by 2002:a17:90b:4a01:b0:2e2:bd7a:71ea with SMTP id 98e67ed59e1d1-2e93c12931bmr6132260a91.8.1730422151031;
        Thu, 31 Oct 2024 17:49:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:10 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/7] net: Add napi_struct parameter irq_suspend_timeout
Date: Fri,  1 Nov 2024 00:48:28 +0000
Message-Id: <20241101004846.32532-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Add a per-NAPI IRQ suspension parameter, which can be get/set with
netdev-genl.

This patch doesn't change any behavior but prepares the code for other
changes in the following commits which use irq_suspend_timeout as a
timeout for IRQ suspension.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 v1 -> v2:
   - rewrote this patch to make irq_suspend_timeout per-napi via
     netdev-genl.

 rfc -> v1:
   - removed napi.rst documentation from this patch; added to patch 6.

 Documentation/netlink/specs/netdev.yaml |  7 +++++++
 include/linux/netdevice.h               |  2 ++
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          |  2 ++
 net/core/dev.h                          | 25 +++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |  5 +++--
 net/core/netdev-genl.c                  | 12 ++++++++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f9cb97d6106c..cbb544bd6c84 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -263,6 +263,11 @@ attribute-sets:
              the end of a NAPI cycle. This may add receive latency in exchange
              for reducing the number of frames processed by the network stack.
         type: uint
+      -
+        name: irq-suspend-timeout
+        doc: The timeout, in nanoseconds, of how long to suspend irq
+             processing, if event polling finds events
+        type: uint
   -
     name: queue
     attributes:
@@ -653,6 +658,7 @@ operations:
             - pid
             - defer-hard-irqs
             - gro-flush-timeout
+            - irq-suspend-timeout
       dump:
         request:
           attributes:
@@ -704,6 +710,7 @@ operations:
             - id
             - defer-hard-irqs
             - gro-flush-timeout
+            - irq-suspend-timeout
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c552b648b27..c8ab5f08092b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -347,6 +347,7 @@ struct gro_list {
  */
 struct napi_config {
 	u64 gro_flush_timeout;
+	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
 	unsigned int napi_id;
 };
@@ -383,6 +384,7 @@ struct napi_struct {
 	struct hrtimer		timer;
 	struct task_struct	*thread;
 	unsigned long		gro_flush_timeout;
+	unsigned long		irq_suspend_timeout;
 	u32			defer_hard_irqs;
 	/* control-path-only fields follow */
 	struct list_head	dev_list;
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e3ebb49f60d2..e4be227d3ad6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -124,6 +124,7 @@ enum {
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index c682173a7642..68d0b16c2f2c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6662,6 +6662,7 @@ static void napi_restore_config(struct napi_struct *n)
 {
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
+	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us. It will be saved to the config
 	 * in napi_disable.
@@ -6676,6 +6677,7 @@ static void napi_save_config(struct napi_struct *n)
 {
 	n->config->defer_hard_irqs = n->defer_hard_irqs;
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
+	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
 	n->config->napi_id = n->napi_id;
 	napi_hash_del(n);
 }
diff --git a/net/core/dev.h b/net/core/dev.h
index 7881bced70a9..d043dee25a68 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -236,6 +236,31 @@ static inline void netdev_set_gro_flush_timeout(struct net_device *netdev,
 		netdev->napi_config[i].gro_flush_timeout = timeout;
 }
 
+/**
+ * napi_get_irq_suspend_timeout - get the irq_suspend_timeout
+ * @n: napi struct to get the irq_suspend_timeout from
+ *
+ * Return: the per-NAPI value of the irq_suspend_timeout field.
+ */
+static inline unsigned long
+napi_get_irq_suspend_timeout(const struct napi_struct *n)
+{
+	return READ_ONCE(n->irq_suspend_timeout);
+}
+
+/**
+ * napi_set_irq_suspend_timeout - set the irq_suspend_timeout for a napi
+ * @n: napi struct to set the irq_suspend_timeout
+ * @timeout: timeout value to set
+ *
+ * napi_set_irq_suspend_timeout sets the per-NAPI irq_suspend_timeout
+ */
+static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
+						unsigned long timeout)
+{
+	WRITE_ONCE(n->irq_suspend_timeout, timeout);
+}
+
 int rps_cpumask_housekeeping(struct cpumask *mask);
 
 #if defined(CONFIG_DEBUG_NET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 21de7e10be16..a89cbd8d87c3 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -92,10 +92,11 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
-static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
+	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
 };
 
 /* Ops table for netdev */
@@ -186,7 +187,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_NAPI_SET,
 		.doit		= netdev_nl_napi_set_doit,
 		.policy		= netdev_napi_set_nl_policy,
-		.maxattr	= NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index b49c3b4e5fbe..765ce7c9d73b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -161,6 +161,7 @@ static int
 netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			const struct genl_info *info)
 {
+	unsigned long irq_suspend_timeout;
 	unsigned long gro_flush_timeout;
 	u32 napi_defer_hard_irqs;
 	void *hdr;
@@ -196,6 +197,11 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 			napi_defer_hard_irqs))
 		goto nla_put_failure;
 
+	irq_suspend_timeout = napi_get_irq_suspend_timeout(napi);
+	if (nla_put_uint(rsp, NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+			 irq_suspend_timeout))
+		goto nla_put_failure;
+
 	gro_flush_timeout = napi_get_gro_flush_timeout(napi);
 	if (nla_put_uint(rsp, NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 			 gro_flush_timeout))
@@ -306,6 +312,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 static int
 netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
+	u64 irq_suspend_timeout = 0;
 	u64 gro_flush_timeout = 0;
 	u32 defer = 0;
 
@@ -314,6 +321,11 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 		napi_set_defer_hard_irqs(napi, defer);
 	}
 
+	if (info->attrs[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT]) {
+		irq_suspend_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT]);
+		napi_set_irq_suspend_timeout(napi, irq_suspend_timeout);
+	}
+
 	if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
 		gro_flush_timeout = nla_get_uint(info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]);
 		napi_set_gro_flush_timeout(napi, gro_flush_timeout);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e3ebb49f60d2..e4be227d3ad6 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -124,6 +124,7 @@ enum {
 	NETDEV_A_NAPI_PID,
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
+	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.25.1


