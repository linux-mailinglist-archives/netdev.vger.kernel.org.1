Return-Path: <netdev+bounces-156890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4120A08385
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D55C1690F7
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DAE205E2E;
	Thu,  9 Jan 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFJQDxOy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B15205AB4
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465501; cv=none; b=Pt8KhWTR30qG70I2O0ttc7X/SVi1gDReLkZS4Ab7eyghNMJCRXpIbVqvVxiVbHvxEMsR+gngpLGrl4nRJKl7EjJtfLqlm4jPEdgAtXNKLlYw1lSYPMKYZFr4ere86ZdFNjEY4fQ2HC3m+VkqxuEd+3rum8DKwBUQlbKdHsbFwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465501; c=relaxed/simple;
	bh=lGWvyvRbAveSQqXajzK4A4PR3DPtMw+ZclWSl6vjKQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzmthfodW+8JJ7Wz3cXH8S1EQNhAWe5c/Gs2jadm3CiOJc7EM3xvJOLjZzUExorgHm8jklQEJKPKQVMVKbHMO9dkPNymG8COmUrc42pQ2IeocAGDq5iveROe5kyzo2GSwwUorRR1jybqfWSzd+8PoOfRt9+pYQb8efdnMyTGq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFJQDxOy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736465500; x=1768001500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lGWvyvRbAveSQqXajzK4A4PR3DPtMw+ZclWSl6vjKQQ=;
  b=QFJQDxOyNF+0+8t6kvCfQgcg5Gv+/YMVkf4jg/Befss2A+oEUQEm2Km4
   8IYVTXZ8pDHcw+QUjuyEkyIKLX5JQlz9JsB9AD6zkcYbsPf+78lgwH87t
   3qT6mK+xziILgdsQgcuXcIt6tNgjUPNFFvq/35CPJ62XDXsdqVrd85A/N
   yV+sgDQZUNNahCRKSTh+0gxRZk/H3Pn3UmhsiuOslY7mOI6BN2QnpmRCI
   w/AKGlW9/QHxAcbhIXtNX5FNaPjhFTtKWuZ3vm7+ZbkI62/YEbM+x4DgY
   pawBkdgK8dk2elUbkozCRXdYuWyKlKFEpQeW+ZxQ2b2P6KUq/ZCHIUF4c
   w==;
X-CSE-ConnectionGUID: jfjqg0IVTJCwSbpRM1cclw==
X-CSE-MsgGUID: n2YwTwyFT8GZgsyRjSE/8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47245155"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47245155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:40 -0800
X-CSE-ConnectionGUID: S4+KUSGsQ4i808Gl9SmfJw==
X-CSE-MsgGUID: sYYqohP8R6G0MRz5dJPeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134399052"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:34 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v4 3/6] net: napi: add CPU affinity to napi_config
Date: Thu,  9 Jan 2025 16:31:04 -0700
Message-ID: <20250109233107.17519-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250109233107.17519-1-ahmed.zaki@intel.com>
References: <20250109233107.17519-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common task for most drivers is to remember the user-set CPU affinity
to its IRQs. On each netdev reset, the driver should re-assign the
user's settings to the IRQs.

Add CPU affinity mask to napi_config. To delegate the CPU affinity
management to the core, drivers must:
 1 - set the new netdev flag "irq_affinity_auto":
                                       netif_enable_irq_affinity(netdev)
 2 - create the napi with persistent config:
                                       netif_napi_add_config()
 3 - bind an IRQ to the napi instance: netif_napi_set_irq()

the core will then make sure to use re-assign affinity to the napi's
IRQ.

The default IRQ mask is set to one cpu starting from the closest NUMA.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 include/linux/netdevice.h |  9 +++++++-
 net/core/dev.c            | 44 ++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c789218cca5d..82da827b5ec6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -351,6 +351,7 @@ struct napi_config {
 	u64 gro_flush_timeout;
 	u64 irq_suspend_timeout;
 	u32 defer_hard_irqs;
+	cpumask_t affinity_mask;
 	unsigned int napi_id;
 };
 
@@ -392,8 +393,8 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
-#ifdef CONFIG_RFS_ACCEL
 	struct irq_affinity_notify notify;
+#ifdef CONFIG_RFS_ACCEL
 	int			napi_rmap_idx;
 #endif
 	int			index;
@@ -2402,6 +2403,7 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	bool			threaded;
+	bool			irq_affinity_auto;
 #ifdef CONFIG_RFS_ACCEL
 	bool			rx_cpu_rmap_auto;
 #endif
@@ -2637,6 +2639,11 @@ static inline void netdev_set_ml_priv(struct net_device *dev,
 	dev->ml_priv_type = type;
 }
 
+static inline void netif_enable_irq_affinity(struct net_device *dev)
+{
+	dev->irq_affinity_auto = true;
+}
+
 /*
  * Net namespace inlines
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d4378962857..72b3caf0e79f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6761,22 +6761,30 @@ int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
 	return 0;
 }
 EXPORT_SYMBOL(netif_enable_cpu_rmap);
+#endif
 
 static void
-netif_irq_cpu_rmap_notify(struct irq_affinity_notify *notify,
-			  const cpumask_t *mask)
+netif_napi_irq_notify(struct irq_affinity_notify *notify,
+		      const cpumask_t *mask)
 {
 	struct napi_struct *napi =
 		container_of(notify, struct napi_struct, notify);
+#ifdef CONFIG_RFS_ACCEL
 	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
 	int err;
+#endif
 
+	if (napi->config && napi->dev->irq_affinity_auto)
+		cpumask_copy(&napi->config->affinity_mask, mask);
+
+#ifdef CONFIG_RFS_ACCEL
 	if (rmap && napi->dev->rx_cpu_rmap_auto) {
 		err = cpu_rmap_update(rmap, napi->napi_rmap_idx, mask);
 		if (err)
 			pr_warn("%s: RMAP update failed (%d)\n",
 				__func__, err);
 	}
+#endif
 }
 
 static void
@@ -6790,6 +6798,7 @@ netif_napi_affinity_release(struct kref *ref)
 	cpu_rmap_put(rmap);
 }
 
+#ifdef CONFIG_RFS_ACCEL
 static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 {
 	struct cpu_rmap *rmap = napi->dev->rx_cpu_rmap;
@@ -6797,7 +6806,7 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 
 	if (!napi || !rmap)
 		return -EINVAL;
-	napi->notify.notify = netif_irq_cpu_rmap_notify;
+	napi->notify.notify = netif_napi_irq_notify;
 	napi->notify.release = netif_napi_affinity_release;
 	cpu_rmap_get(rmap);
 	rc = cpu_rmap_add(rmap, napi);
@@ -6821,9 +6830,8 @@ static int napi_irq_cpu_rmap_add(struct napi_struct *napi, int irq)
 
 void netif_napi_set_irq(struct napi_struct *napi, int irq)
 {
-#ifdef CONFIG_RFS_ACCEL
 	int rc;
-#endif
+
 	napi->irq = irq;
 
 #ifdef CONFIG_RFS_ACCEL
@@ -6834,8 +6842,18 @@ void netif_napi_set_irq(struct napi_struct *napi, int irq)
 				    rc);
 			netif_disable_cpu_rmap(napi->dev);
 		}
-	}
+	} else if (irq > 0 && napi->config && napi->dev->irq_affinity_auto) {
+#else
+	if (irq > 0 && napi->config && napi->dev->irq_affinity_auto) {
 #endif
+		napi->notify.notify = netif_napi_irq_notify;
+		napi->notify.release = netif_napi_affinity_release;
+
+		rc = irq_set_affinity_notifier(irq, &napi->notify);
+		if (rc)
+			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
+				    rc);
+	}
 }
 EXPORT_SYMBOL(netif_napi_set_irq);
 
@@ -6844,6 +6862,10 @@ static void napi_restore_config(struct napi_struct *n)
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
 	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
+
+	if (n->irq > 0 && n->dev->irq_affinity_auto)
+		irq_set_affinity(n->irq, &n->config->affinity_mask);
+
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
 	 * napi_hash_add to generate one for us.
 	 */
@@ -6860,6 +6882,10 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->defer_hard_irqs = n->defer_hard_irqs;
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
+
+	if (n->irq > 0 && n->dev->irq_affinity_auto)
+		irq_set_affinity_notifier(n->irq, NULL);
+
 	napi_hash_del(n);
 }
 
@@ -11358,7 +11384,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	size_t napi_config_sz;
-	unsigned int maxqs;
+	unsigned int maxqs, i, numa;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -11454,6 +11480,10 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->napi_config = kvzalloc(napi_config_sz, GFP_KERNEL_ACCOUNT);
 	if (!dev->napi_config)
 		goto free_all;
+	numa = dev_to_node(&dev->dev);
+	for (i = 0; i < maxqs; i++)
+		cpumask_set_cpu(cpumask_local_spread(i, numa),
+				&dev->napi_config[i].affinity_mask);
 
 	strscpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
-- 
2.43.0


