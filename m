Return-Path: <netdev+bounces-153074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E18D9F6BB0
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4896A16890B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80A1F890F;
	Wed, 18 Dec 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoaM53pG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C711F2396
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541154; cv=none; b=Chc6HfKBsZn+S4+X2CaFzewWAzUrMbF/sSH98p8FkAL8xY2o5fKXXyV0LvhofS42k+D+ICqPl8ekI3z11gvPErcqm1ZYJeQLVzZbkNbNQ4X1uVQjVppRJ98lkB1j7aZUz/Ct4P3lat1syrQjdT8C/0TTOW+XkArDpeRGDW1F58s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541154; c=relaxed/simple;
	bh=ywmYtI0lcrXxPUxnpZCoN+vSygyrLvEeQCaTxsopkqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1DwEvKNpaIyrswLlCiJLBjtr+q0LilfXOh1JyuaHQzD/MlB37WGP6Itx5gOVfMOPjNuirGeFut87uU7gP/TQIbWw98bJbW3XERjj6hecVEgDRY4TEoUHunrhrSGFzU+S3hX6XR4gcznHmcaPrBMliGot8v8uZi5huyi/I2tdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoaM53pG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734541152; x=1766077152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywmYtI0lcrXxPUxnpZCoN+vSygyrLvEeQCaTxsopkqE=;
  b=NoaM53pGCJ/d7u2fMNxoDE5sNFELud8NUEHOzZZ6qPDqTPYiVcjSPjCC
   +f2AAn4xaN2oF2ReVkH1Bje6DRdFw5T05HqHArf06bDOw9UpfPqVZdUaY
   K8/pdEk9NcqNaGkn+GTPagCZWPtO5V1RSuoWNPAG4d7U+uMh3kfdJPnQF
   SDw72KFbvj36QYQVMggIPWrdqfoPH3jVlUJUud/iqrEYXoGIN8LgswTBM
   YL1K3LvvQbIetx0X0RCIFBSQ9pJCeLSFHdS8JLyDrSgu6bOoQZOblcgpy
   Ynkdce5u5iaZfNqEStb0/wYmgC4ofNVetbruOWHqKWharyqsAk36GGCJf
   g==;
X-CSE-ConnectionGUID: eKHSyTVySDi4LdIsqeF+IA==
X-CSE-MsgGUID: NAAadlgeSxmOjJ5PTrjeRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46415484"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="46415484"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:12 -0800
X-CSE-ConnectionGUID: sdJdS6ojQMaByIasp0GI5A==
X-CSE-MsgGUID: 3imJic9fTxWYh4kJl4ju+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102531608"
Received: from ldmartin-desk2.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.224])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 08:59:06 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v2 1/8] net: napi: add irq_flags to napi struct
Date: Wed, 18 Dec 2024 09:58:36 -0700
Message-ID: <20241218165843.744647-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218165843.744647-1-ahmed.zaki@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add irq_flags to the napi struct. This will allow the drivers to choose
how the core handles the IRQ assigned to the napi via
netif_napi_set_irq().

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c      | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 2 +-
 drivers/net/ethernet/broadcom/tg3.c               | 2 +-
 drivers/net/ethernet/google/gve/gve_utils.c       | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c     | 2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c        | 2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c          | 2 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c        | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c      | 3 ++-
 include/linux/netdevice.h                         | 6 ++----
 net/core/dev.c                                    | 9 ++++++++-
 12 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c1295dfad0d0..4898c8be78ad 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1712,7 +1712,7 @@ static int ena_request_io_irq(struct ena_adapter *adapter)
 	for (i = 0; i < io_queue_count; i++) {
 		irq_idx = ENA_IO_IRQ_IDX(i);
 		irq = &adapter->irq_tbl[irq_idx];
-		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector);
+		netif_napi_set_irq(&adapter->ena_napi[i].napi, irq->vector, 0);
 	}
 
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b86f980fa7ea..4763c6300bd3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11225,7 +11225,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
-		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector, 0);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 9cc8db10a8d6..0d6383804270 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7447,7 +7447,7 @@ static void tg3_napi_init(struct tg3 *tp)
 	for (i = 0; i < tp->irq_cnt; i++) {
 		netif_napi_add(tp->dev, &tp->napi[i].napi,
 			       i ? tg3_poll_msix : tg3_poll);
-		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec, 0);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 30fef100257e..2657e583f5c6 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -111,7 +111,7 @@ void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
 	struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
 	netif_napi_add(priv->dev, &block->napi, gve_poll);
-	netif_napi_set_irq(&block->napi, block->irq);
+	netif_napi_set_irq(&block->napi, block->irq, 0);
 }
 
 void gve_remove_napi(struct gve_priv *priv, int ntfy_idx)
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3f089c3d47b2..a83af159837a 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1394,7 +1394,7 @@ int e1000_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000_up() */
 	clear_bit(__E1000_DOWN, &adapter->flags);
 
-	netif_napi_set_irq(&adapter->napi, adapter->pdev->irq);
+	netif_napi_set_irq(&adapter->napi, adapter->pdev->irq, 0);
 	napi_enable(&adapter->napi);
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 286155efcedf..8fc5603ed962 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4676,7 +4676,7 @@ int e1000e_open(struct net_device *netdev)
 	else
 		irq = adapter->pdev->irq;
 
-	netif_napi_set_irq(&adapter->napi, irq);
+	netif_napi_set_irq(&adapter->napi, irq, 0);
 	napi_enable(&adapter->napi);
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
 	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index a7d45a8ce7ac..ff91e70f596f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2735,7 +2735,7 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, v_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
 
-		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq);
+		netif_napi_set_irq(&q_vector->napi, q_vector->irq.virq, 0);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 0e92956e84cf..b8531283e3ac 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -150,7 +150,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
-		netif_napi_set_irq(&cq->napi, irq);
+		netif_napi_set_irq(&cq->napi, irq, 0);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
@@ -158,7 +158,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add_config(cq->dev, &cq->napi, mlx4_en_poll_rx_cq,
 				      cq_idx);
-		netif_napi_set_irq(&cq->napi, irq);
+		netif_napi_set_irq(&cq->napi, irq, 0);
 		napi_enable(&cq->napi);
 		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index dd16d73000c3..58b8313f4c5a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2733,7 +2733,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
 	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
-	netif_napi_set_irq(&c->napi, irq);
+	netif_napi_set_irq(&c->napi, irq, 0);
 
 	err = mlx5e_open_queues(c, params, cparam);
 	if (unlikely(err))
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index b5050fabe8fe..6ca91ce85d48 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1227,7 +1227,8 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	/* Record IRQ to NAPI struct */
 	netif_napi_set_irq(&nv->napi,
-			   pci_irq_vector(to_pci_dev(fbd->dev), nv->v_idx));
+			   pci_irq_vector(to_pci_dev(fbd->dev), nv->v_idx),
+			   0);
 
 	/* Tie nv back to PCIe dev */
 	nv->dev = fbd->dev;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2593019ad5b1..ca91b6662bde 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -392,6 +392,7 @@ struct napi_struct {
 	struct list_head	dev_list;
 	struct hlist_node	napi_hash_node;
 	int			irq;
+	unsigned long		irq_flags;
 	int			index;
 	struct napi_config	*config;
 };
@@ -2671,10 +2672,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
 
-static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
-{
-	napi->irq = irq;
-}
+void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags);
 
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
diff --git a/net/core/dev.c b/net/core/dev.c
index c7f3dea3e0eb..88a7d4b6e71b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6705,6 +6705,13 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+void netif_napi_set_irq(struct napi_struct *napi, int irq, unsigned long flags)
+{
+	napi->irq = irq;
+	napi->irq_flags = flags;
+}
+EXPORT_SYMBOL(netif_napi_set_irq);
+
 static void napi_restore_config(struct napi_struct *n)
 {
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
@@ -6770,7 +6777,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
 		dev->threaded = false;
-	netif_napi_set_irq(napi, -1);
+	netif_napi_set_irq(napi, -1, 0);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
 
-- 
2.43.0


