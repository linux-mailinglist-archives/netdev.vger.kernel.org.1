Return-Path: <netdev+bounces-160678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53123A1AD1F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2363AE21F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C61D54C2;
	Thu, 23 Jan 2025 23:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCgnEYLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D71CDFD3
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 23:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673961; cv=none; b=RZvcUNTSthbIKMlPQisa3C43cUJwOaEL7KV6f+wr5Kq2lbDxobC87aLnfhNAgNDRui7gb4Ehzq5YC28MncIzVFjx1yPq2iJeatoD1Wd2bcbEOLDEVw2BkSZovezDEz3GvtW9r7BxNtGJWpnYL9fTlNE0PCsEiZ4UDiLz/TcrSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673961; c=relaxed/simple;
	bh=U1CUqeVeq1RCiemc7JFaF3fNONtCk7ot7Y8fwT12dZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHnSBrdAgudpW6y3ygabfgvrL7k1OEwiJprUxDoedd+wBhthflJ5SvSxJ1RguoUdLzF7tphuvBB10rLjGI3W0CNirTQPoShTtX6jUkq4y2e3SQTLGGcu7RRFlsuuw5UVuFeTnzBjsvONdyl9OP8PozD1H8J4W0MnI2duhd77PrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LCgnEYLn; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so4213848a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737673959; x=1738278759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBxbfT81fwwX1zSvujFdf84ewj4LqCM86p7iXIivu70=;
        b=LCgnEYLn0647ymee9694Mj2/Mc839Hoi8HirxA8vm9zTJLmZafS6xfSwFYkmEzgYgN
         58GlOAf1DhVeCTwgJdOXE05tK2LevhHzBKEy1GpQYP+hb4zQTPrP8f9P3mu9JKgpGKye
         ik56Kk6h765qK9Zv505Hmc12eGBE7xsvpi/Bx9MSRnAfti7k4FHtp6Ebv9cn6As3euND
         ndSYaaG/NxqhA6dXpV/OdXbQumU8MkKlRMelWkPrN0owLgeKs0gJrY4CRUZpglL9fUcO
         g+bRg2qIAWV8wR3Fl8t7L5D3NxNCIRwV+pR+BNuX1IOqdrM6Ef6fCZHjl6BwnfKLsqGm
         kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673959; x=1738278759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBxbfT81fwwX1zSvujFdf84ewj4LqCM86p7iXIivu70=;
        b=Fya4A9xtnAgPSI+HBsfttXmtLKRsaGgz9I50mGBVJpLnnSeKQZXas/IL7ZubdvFL5F
         ygRwFWD8GxCLc70LofmauAKdJG4zS2HOqYW0qn7ws3uyev/5LLwPwesiq47slO07Xpv6
         +buavaK9ruQH1BnXwpcaO5TYY1oiGouyFETUxBpsBivOLLHgcSVRuVihS8WsIY0+Iypv
         gjW0HPdBUHbvEBMrytqFNpewbJc5Ai2Ln85FXNfOzobSbeVamovM8x/OhKATKVsaqAd2
         m/7qL2fQK1sES/NDqozrWXaDtLeIcyaeG5UfrnUEcf0cQL7lxLJG53CqworXsWuYHS9P
         IgTQ==
X-Gm-Message-State: AOJu0YxVnrJEXXgjrISrNomJulN2a8dlYIJhFNUvHIUWz1oswGeOZAI+
	jq8+DzPvUeioa4E2ifMgkR2uJR0En10nu6xZXW6ZLWnOpRQDMInbxTdcg/Fqi9K02CK5YRoWKYQ
	fvAdhgky08Q==
X-Google-Smtp-Source: AGHT+IH/Aveic4cCN6YaWe9eD9AGkJG/5MKUt68DE/okhYijiIb1a+uTiAww16KrG+n8663022AS7D88DzYbBQ==
X-Received: from pfbch15.prod.google.com ([2002:a05:6a00:288f:b0:725:ec78:5008])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9991:b0:1e1:f281:8d36 with SMTP id adf61e73a8af0-1eb21486389mr42231833637.10.1737673958865;
 Thu, 23 Jan 2025 15:12:38 -0800 (PST)
Date: Thu, 23 Jan 2025 23:12:33 +0000
In-Reply-To: <20250123231236.2657321-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250123231236.2657321-1-skhawaja@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250123231236.2657321-2-skhawaja@google.com>
Subject: [PATCH net-next v2 1/4] Add support to set napi threaded for
 individual napi
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

A net device has a threaded sysctl that can be used to enable threaded
napi polling on all of the NAPI contexts under that device. Allow
enabling threaded napi polling at individual napi level using netlink.

Extend the netlink operation `napi-set` and allow setting the threaded
attribute of a NAPI. This will enable the threaded polling on a napi
context.

Tested using following command in qemu/virtio-net:
./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
  --do napi-set       --json '{"id": 66, "threaded": 1}'

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 10 ++++++++
 Documentation/networking/napi.rst       | 13 ++++++++++-
 include/linux/netdevice.h               | 10 ++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          | 31 +++++++++++++++++++++++++
 net/core/netdev-genl-gen.c              |  5 ++--
 net/core/netdev-genl.c                  |  9 +++++++
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c84..785240d60df6 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -268,6 +268,14 @@ attribute-sets:
         doc: The timeout, in nanoseconds, of how long to suspend irq
              processing, if event polling finds events
         type: uint
+      -
+        name: threaded
+        doc: Whether the napi is configured to operate in threaded polling
+             mode. If this is set to `1` then the NAPI context operates
+             in threaded polling mode.
+        type: u32
+        checks:
+          max: 1
   -
     name: queue
     attributes:
@@ -659,6 +667,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
       dump:
         request:
           attributes:
@@ -711,6 +720,7 @@ operations:
             - defer-hard-irqs
             - gro-flush-timeout
             - irq-suspend-timeout
+            - threaded
 
 kernel-family:
   headers: [ "linux/list.h"]
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 6083210ab2a4..41926e7a3dd4 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -413,7 +413,18 @@ dependent). The NAPI instance IDs will be assigned in the opposite
 order than the process IDs of the kernel threads.
 
 Threaded NAPI is controlled by writing 0/1 to the ``threaded`` file in
-netdev's sysfs directory.
+netdev's sysfs directory. It can also be enabled for a specific napi using
+netlink interface.
+
+For example, using the script:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-set \
+            --json='{"id": 66,
+                     "threaded": 1}'
 
 .. rubric:: Footnotes
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8da4c61f97b9..6afba24b18d1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -352,6 +352,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	bool threaded;
 	unsigned int napi_id;
 };
 
@@ -572,6 +573,15 @@ static inline bool napi_complete(struct napi_struct *n)
 
 int dev_set_threaded(struct net_device *dev, bool threaded);
 
+/*
+ * napi_set_threaded - set napi threaded state
+ * @napi: NAPI context
+ * @threaded: whether this napi does threaded polling
+ *
+ * Return 0 on success and negative errno on failure.
+ */
+int napi_set_threaded(struct napi_struct *napi, bool threaded);
+
 void napi_disable(struct napi_struct *n);
 void napi_disable_locked(struct napi_struct *n);
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad6..829648b2ef65 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..3885f3095873 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6787,6 +6787,30 @@ static void init_gro_hash(struct napi_struct *napi)
 	napi->gro_bitmask = 0;
 }
 
+int napi_set_threaded(struct napi_struct *napi, bool threaded)
+{
+	if (napi->dev->threaded)
+		return -EINVAL;
+
+	if (threaded) {
+		if (!napi->thread) {
+			int err = napi_kthread_create(napi);
+
+			if (err)
+				return err;
+		}
+	}
+
+	if (napi->config)
+		napi->config->threaded = threaded;
+
+	/* Make sure kthread is created before THREADED bit is set. */
+	smp_mb__before_atomic();
+	assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+
+	return 0;
+}
+
 int dev_set_threaded(struct net_device *dev, bool threaded)
 {
 	struct napi_struct *napi;
@@ -6798,6 +6822,11 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 		return 0;
 
 	if (threaded) {
+		/* Check if threaded is set at napi level already */
+		list_for_each_entry(napi, &dev->napi_list, dev_list)
+			if (test_bit(NAPI_STATE_THREADED, &napi->state))
+				return -EINVAL;
+
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
 				err = napi_kthread_create(napi);
@@ -6880,6 +6909,8 @@ static void napi_restore_config(struct napi_struct *n)
 		napi_hash_add(n);
 		n->config->napi_id = n->napi_id;
 	}
+
+	napi_set_threaded(n, n->config->threaded);
 }
 
 static void napi_save_config(struct napi_struct *n)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 996ac6a449eb..a1f80e687f53 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -92,11 +92,12 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
-static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT + 1] = {
+static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED + 1] = {
 	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* Ops table for netdev */
@@ -187,7 +188,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_NAPI_SET,
 		.doit		= netdev_nl_napi_set_doit,
 		.policy		= netdev_napi_set_nl_policy,
-		.maxattr	= NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+		.maxattr	= NETDEV_A_NAPI_THREADED,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62e..208c3dd768ec 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -183,6 +183,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
+	if (nla_put_u32(rsp, NETDEV_A_NAPI_THREADED, !!napi->thread))
+		goto nla_put_failure;
+
 	if (napi->thread) {
 		pid = task_pid_nr(napi->thread);
 		if (nla_put_u32(rsp, NETDEV_A_NAPI_PID, pid))
@@ -321,8 +324,14 @@ netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *info)
 {
 	u64 irq_suspend_timeout = 0;
 	u64 gro_flush_timeout = 0;
+	u32 threaded = 0;
 	u32 defer = 0;
 
+	if (info->attrs[NETDEV_A_NAPI_THREADED]) {
+		threaded = nla_get_u32(info->attrs[NETDEV_A_NAPI_THREADED]);
+		napi_set_threaded(napi, !!threaded);
+	}
+
 	if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
 		defer = nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]);
 		napi_set_defer_hard_irqs(napi, defer);
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad6..829648b2ef65 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -125,6 +125,7 @@ enum {
 	NETDEV_A_NAPI_DEFER_HARD_IRQS,
 	NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
 	NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT,
+	NETDEV_A_NAPI_THREADED,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
-- 
2.48.1.262.g85cc9f2d1e-goog


