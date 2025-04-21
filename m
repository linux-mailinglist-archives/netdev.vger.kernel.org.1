Return-Path: <netdev+bounces-184460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7526A95967
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE67175F49
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF1227EAB;
	Mon, 21 Apr 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olo8Z48h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC1227E9B
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274521; cv=none; b=mEtfaITgCcXXtlGkxIIVJuzkrr7fNY+F50PpSF5b6cLIKcIrFTWCKcAiUbiDkvwWkcgX2JjbPOet+7XMuGn+ckQv+NPYTtFSBrwgf296V1PUBV91zHdK6l7NSQgU5VxoiZF4qs/xiETDvvuccwYb8RDLtQqG5qCJS3A/dT+gi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274521; c=relaxed/simple;
	bh=8FzayXl/EY4PYAb12QUycB727WLUvqS31iEOtW+hgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFZ0OkgKZw+vA1OfSDPiNq387f6GkNIbJaN3tt+uttE60ffs6PwlNo3tvDR+1qmGaMUwWgqE9Yf3zhHnnaLrh0hFq5WcSlkMYvIvpm4o4C3Trh6Gg54IA7yQC+qNVLRSJ3NerAX4L2pTRjVKqwzsUfaIiXe5TmYGOSHYkB0lCGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olo8Z48h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C170BC4CEED;
	Mon, 21 Apr 2025 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274521;
	bh=8FzayXl/EY4PYAb12QUycB727WLUvqS31iEOtW+hgO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Olo8Z48hebm8NISP6LTfMBF4njAGJmBoLmQm5MuonPKnCN1TtUpp6ktyQc25JGPBv
	 ciHxp/Mf97Jn00xrA96UXuP+iAeJKFms6LA6p0L+QCZXUeYi4SVQaQOm1b87aP6DK1
	 IZqyHDuYF/EcOMszhcTPDOdoGXaKkHXUYJ+Z+PihRVEOrdV5cE9DA7DaZGfWvbb4Xo
	 EAa7OYtWQvowsfHH/mv4yqFsy4+8kHCAunlR+HN8vINIYAswb9N+lq5fX07xiqBPcz
	 o8DFwitrzjodww2F/pph78eXERAhEc/xiF0MI/slHUK/TCECtgc2c7c6bm6/Gv0wFk
	 uuy/jAtTfKUfg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 11/22] net: allocate per-queue config structs and pass them thru the queue API
Date: Mon, 21 Apr 2025 15:28:16 -0700
Message-ID: <20250421222827.283737-12-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an array of config structs to store per-queue config.
Pass these structs in the queue API. Drivers can also retrieve
the config for a single queue calling netdev_queue_config()
directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h                | 19 +++++++
 net/core/dev.h                             |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c  |  8 ++-
 drivers/net/ethernet/google/gve/gve_main.c |  9 ++--
 drivers/net/netdevsim/netdev.c             |  6 ++-
 net/core/netdev_config.c                   | 58 ++++++++++++++++++++++
 net/core/netdev_rx_queue.c                 | 11 ++--
 7 files changed, 104 insertions(+), 10 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index c50de8db72ce..1fb621a00962 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -31,6 +31,13 @@ struct netdev_config {
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
+
+	/** @qcfg: per-queue configuration */
+	struct netdev_queue_config *qcfg;
+};
+
+/* Same semantics as fields in struct netdev_config */
+struct netdev_queue_config {
 };
 
 /* See the netdev.yaml spec for definition of each statistic */
@@ -129,6 +136,10 @@ struct netdev_stat_ops {
  *
  * @ndo_queue_mem_size: Size of the struct that describes a queue's memory.
  *
+ * @ndo_queue_cfg_defaults: (Optional) Populate queue config struct with
+ *			defaults. Queue config structs are passed to this
+ *			helper before the user-requested settings are applied.
+ *
  * @ndo_queue_mem_alloc: Allocate memory for an RX queue at the specified index.
  *			 The new memory is written at the specified address.
  *
@@ -146,12 +157,17 @@ struct netdev_stat_ops {
  */
 struct netdev_queue_mgmt_ops {
 	size_t	ndo_queue_mem_size;
+	void	(*ndo_queue_cfg_defaults)(struct net_device *dev,
+					  int idx,
+					  struct netdev_queue_config *qcfg);
 	int	(*ndo_queue_mem_alloc)(struct net_device *dev,
+				       struct netdev_queue_config *qcfg,
 				       void *per_queue_mem,
 				       int idx);
 	void	(*ndo_queue_mem_free)(struct net_device *dev,
 				      void *per_queue_mem);
 	int	(*ndo_queue_start)(struct net_device *dev,
+				   struct netdev_queue_config *qcfg,
 				   void *per_queue_mem,
 				   int idx);
 	int	(*ndo_queue_stop)(struct net_device *dev,
@@ -159,6 +175,9 @@ struct netdev_queue_mgmt_ops {
 				  int idx);
 };
 
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg);
+
 /**
  * DOC: Lockless queue stopping / waking helpers.
  *
diff --git a/net/core/dev.h b/net/core/dev.h
index c8971c6f1fcd..6d7f5e920018 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -9,6 +9,7 @@
 #include <net/netdev_lock.h>
 
 struct net;
+struct netdev_queue_config;
 struct netlink_ext_ack;
 struct cpumask;
 
@@ -96,6 +97,8 @@ int netdev_alloc_config(struct net_device *dev);
 void __netdev_free_config(struct netdev_config *cfg);
 void netdev_free_config(struct net_device *dev);
 int netdev_reconfig_start(struct net_device *dev);
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending);
 
 /* netdev management, shared between various uAPI entry points */
 struct netdev_name_node {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a86bb2ba5adb..fbbe02cefdf1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15728,7 +15728,9 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
-static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_mem_alloc(struct net_device *dev,
+				struct netdev_queue_config *qcfg,
+				void *qmem, int idx)
 {
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt *bp = netdev_priv(dev);
@@ -15896,7 +15898,9 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	dst->rx_agg_bmap = src->rx_agg_bmap;
 }
 
-static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
+static int bnxt_queue_start(struct net_device *dev,
+			    struct netdev_queue_config *qcfg,
+			    void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8aaac9101377..088ae19ddb24 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2428,8 +2428,9 @@ static void gve_rx_queue_mem_free(struct net_device *dev, void *per_q_mem)
 		gve_rx_free_ring_dqo(priv, gve_per_q_mem, &cfg);
 }
 
-static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
-				  int idx)
+static int gve_rx_queue_mem_alloc(struct net_device *dev,
+				  struct netdev_queue_config *qcfg,
+				  void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_alloc_rings_cfg cfg = {0};
@@ -2450,7 +2451,9 @@ static int gve_rx_queue_mem_alloc(struct net_device *dev, void *per_q_mem,
 	return err;
 }
 
-static int gve_rx_queue_start(struct net_device *dev, void *per_q_mem, int idx)
+static int gve_rx_queue_start(struct net_device *dev,
+			      struct netdev_queue_config *qcfg,
+			      void *per_q_mem, int idx)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_rx_ring *gve_per_q_mem;
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0e0321a7ddd7..a2aa85a85e0f 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -661,7 +661,8 @@ struct nsim_queue_mem {
 };
 
 static int
-nsim_queue_mem_alloc(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_mem_alloc(struct net_device *dev, struct netdev_queue_config *qcfg,
+		     void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
@@ -710,7 +711,8 @@ static void nsim_queue_mem_free(struct net_device *dev, void *per_queue_mem)
 }
 
 static int
-nsim_queue_start(struct net_device *dev, void *per_queue_mem, int idx)
+nsim_queue_start(struct net_device *dev, struct netdev_queue_config *qcfg,
+		 void *per_queue_mem, int idx)
 {
 	struct nsim_queue_mem *qmem = per_queue_mem;
 	struct netdevsim *ns = netdev_priv(dev);
diff --git a/net/core/netdev_config.c b/net/core/netdev_config.c
index 270b7f10a192..bad2d53522f0 100644
--- a/net/core/netdev_config.c
+++ b/net/core/netdev_config.c
@@ -8,18 +8,29 @@
 int netdev_alloc_config(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	cfg = kzalloc(sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kcalloc(maxqs, sizeof(*cfg->qcfg), GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg = cfg;
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
 }
 
 void __netdev_free_config(struct netdev_config *cfg)
 {
+	kfree(cfg->qcfg);
 	kfree(cfg);
 }
 
@@ -32,12 +43,59 @@ void netdev_free_config(struct net_device *dev)
 int netdev_reconfig_start(struct net_device *dev)
 {
 	struct netdev_config *cfg;
+	unsigned int maxqs;
 
 	WARN_ON(dev->cfg != dev->cfg_pending);
 	cfg = kmemdup(dev->cfg, sizeof(*dev->cfg), GFP_KERNEL_ACCOUNT);
 	if (!cfg)
 		return -ENOMEM;
 
+	maxqs = max(dev->num_rx_queues, dev->num_tx_queues);
+	cfg->qcfg = kmemdup_array(dev->cfg->qcfg, maxqs, sizeof(*cfg->qcfg),
+				  GFP_KERNEL_ACCOUNT);
+	if (!cfg->qcfg)
+		goto err_free_cfg;
+
 	dev->cfg_pending = cfg;
 	return 0;
+
+err_free_cfg:
+	kfree(cfg);
+	return -ENOMEM;
 }
+
+void __netdev_queue_config(struct net_device *dev, int rxq,
+			   struct netdev_queue_config *qcfg, bool pending)
+{
+	memset(qcfg, 0, sizeof(*qcfg));
+
+	/* Get defaults from the driver, in case user config not set */
+	if (dev->queue_mgmt_ops->ndo_queue_cfg_defaults)
+		dev->queue_mgmt_ops->ndo_queue_cfg_defaults(dev, rxq, qcfg);
+}
+
+/**
+ * netdev_queue_config() - get configuration for a given queue
+ * @dev:  net_device instance
+ * @rxq:  index of the queue of interest
+ * @qcfg: queue configuration struct (output)
+ *
+ * Render the configuration for a given queue. This helper should be used
+ * by drivers which support queue configuration to retrieve config for
+ * a particular queue.
+ *
+ * @qcfg is an output parameter and is always fully initialized by this
+ * function. Some values may not be set by the user, drivers may either
+ * deal with the "unset" values in @qcfg, or provide the callback
+ * to populate defaults in queue_management_ops.
+ *
+ * Note that this helper returns pending config, as it is expected that
+ * "old" queues are retained until config is successful so they can
+ * be restored directly without asking for the config.
+ */
+void netdev_queue_config(struct net_device *dev, int rxq,
+			 struct netdev_queue_config *qcfg)
+{
+	__netdev_queue_config(dev, rxq, qcfg, true);
+}
+EXPORT_SYMBOL(netdev_queue_config);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index d126f10197bf..d8a710db21cd 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -7,12 +7,14 @@
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/memory_provider.h>
 
+#include "dev.h"
 #include "page_pool_priv.h"
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 {
 	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);
 	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
+	struct netdev_queue_config qcfg;
 	void *new_mem, *old_mem;
 	int err;
 
@@ -32,7 +34,9 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		goto err_free_new_mem;
 	}
 
-	err = qops->ndo_queue_mem_alloc(dev, new_mem, rxq_idx);
+	netdev_queue_config(dev, rxq_idx, &qcfg);
+
+	err = qops->ndo_queue_mem_alloc(dev, &qcfg, new_mem, rxq_idx);
 	if (err)
 		goto err_free_old_mem;
 
@@ -45,7 +49,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 		if (err)
 			goto err_free_new_queue_mem;
 
-		err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
+		err = qops->ndo_queue_start(dev, &qcfg, new_mem, rxq_idx);
 		if (err)
 			goto err_start_queue;
 	} else {
@@ -60,6 +64,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	return 0;
 
 err_start_queue:
+	__netdev_queue_config(dev, rxq_idx, &qcfg, false);
 	/* Restarting the queue with old_mem should be successful as we haven't
 	 * changed any of the queue configuration, and there is not much we can
 	 * do to recover from a failure here.
@@ -67,7 +72,7 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	 * WARN if we fail to recover the old rx queue, and at least free
 	 * old_mem so we don't also leak that.
 	 */
-	if (qops->ndo_queue_start(dev, old_mem, rxq_idx)) {
+	if (qops->ndo_queue_start(dev, &qcfg, old_mem, rxq_idx)) {
 		WARN(1,
 		     "Failed to restart old queue in error path. RX queue %d may be unhealthy.",
 		     rxq_idx);
-- 
2.49.0


