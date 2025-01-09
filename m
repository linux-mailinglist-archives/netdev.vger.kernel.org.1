Return-Path: <netdev+bounces-156888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BBA08383
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 00:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B73A8495
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 23:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECFD205E31;
	Thu,  9 Jan 2025 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqlYOTSc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64342204F67
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 23:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465490; cv=none; b=AcmlcBqmDxFoK4pG/R/HvGRB+mAOMaYpikCUeGoftLOU31gosHTEfS9/xABNLTy0QvhDEYClqQGG/F+517ricSO3QSvnDHbl1MjdLHgAFHIs+yTMH1SEPmhKbyeTjqV5NhS/3yYjJiMbcPOMZgYBLOtnAY9WSbtV7o6KlYmvulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465490; c=relaxed/simple;
	bh=HUIY42m5q+KCXfrwiEnxCTkCP8wFzbx1YreFvGltKx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRIfrTaIcrJWyFxtwfz/FRAnSqqtxLtWKTwNPC1cZZnkUFD9enV6T+1M2fQAadEPAG0PkIoX5MFWrRkl30zngWrSogwSSqQu7Xxov0XGE3slHonr65zAZwisvsESzmj74190K+wAnfCH9XdjmoSjfIzYJaiDymeTTV61iiG5ZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqlYOTSc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736465489; x=1768001489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUIY42m5q+KCXfrwiEnxCTkCP8wFzbx1YreFvGltKx4=;
  b=MqlYOTScemLP/DMA80033zkBcBbwwK+S/66SZtsbDyVDPhROADSfmWC9
   M4S47GRC0IZj/abPc4qcYJs7hMz/uvbFmJro83CUR+jtV42e8QD6EmxX2
   DCy+Lu+U0/N18OM5YkYpuvMWz6ylbu+mdE5UtfYZHcaOCAPdABw50P7WG
   +30CxhJ7S3+1/GlXNX5En+wnbtbbxg++ZHebdUk40EZwZ2lMcp2fJcyEG
   y+ShdjN1NETYLnHR6K2xARzvlqLEUyzbfmtU/Le7GmSVqZrp6Ef8MuTJU
   1puS3IQeeSk90CILhr47kdLEdFqgdpjg3tUWuGAkMQ3CnFEjaoexl2TuO
   w==;
X-CSE-ConnectionGUID: FB8+EAbBQSGGp+lwXEuxCw==
X-CSE-MsgGUID: eRBIK9wpRTG4GUM7eA+aZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="47245108"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="47245108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:29 -0800
X-CSE-ConnectionGUID: N/d5o82TTh+0CHiP1KMmNA==
X-CSE-MsgGUID: 3Vz8E4HKTvarnTfYKhAz8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="134398965"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.128])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 15:31:22 -0800
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
Subject: [PATCH net-next v4 1/6] net: move ARFS rmap management to core
Date: Thu,  9 Jan 2025 16:31:02 -0700
Message-ID: <20250109233107.17519-2-ahmed.zaki@intel.com>
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

Add a new netdev flag "rx_cpu_rmap_auto". Drivers supporting ARFS should
set the flag via netif_enable_cpu_rmap() and core will allocate and manage
the ARFS rmap. Freeing the rmap is also done by core when the netdev is
freed.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 38 ++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    | 27 ++----------
 drivers/net/ethernet/intel/ice/ice_arfs.c    | 17 +-------
 include/linux/netdevice.h                    | 12 ++++--
 net/core/dev.c                               | 44 ++++++++++++++++++++
 5 files changed, 60 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index c1295dfad0d0..a3fceaa83cd5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -5,9 +5,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#ifdef CONFIG_RFS_ACCEL
-#include <linux/cpu_rmap.h>
-#endif /* CONFIG_RFS_ACCEL */
 #include <linux/ethtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -165,25 +162,10 @@ int ena_xmit_common(struct ena_adapter *adapter,
 static int ena_init_rx_cpu_rmap(struct ena_adapter *adapter)
 {
 #ifdef CONFIG_RFS_ACCEL
-	u32 i;
-	int rc;
-
-	adapter->netdev->rx_cpu_rmap = alloc_irq_cpu_rmap(adapter->num_io_queues);
-	if (!adapter->netdev->rx_cpu_rmap)
-		return -ENOMEM;
-	for (i = 0; i < adapter->num_io_queues; i++) {
-		int irq_idx = ENA_IO_IRQ_IDX(i);
-
-		rc = irq_cpu_rmap_add(adapter->netdev->rx_cpu_rmap,
-				      pci_irq_vector(adapter->pdev, irq_idx));
-		if (rc) {
-			free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
-			adapter->netdev->rx_cpu_rmap = NULL;
-			return rc;
-		}
-	}
-#endif /* CONFIG_RFS_ACCEL */
+	return netif_enable_cpu_rmap(adapter->netdev, adapter->num_io_queues);
+#else
 	return 0;
+#endif /* CONFIG_RFS_ACCEL */
 }
 
 static void ena_init_io_rings_common(struct ena_adapter *adapter,
@@ -1742,13 +1724,6 @@ static void ena_free_io_irq(struct ena_adapter *adapter)
 	struct ena_irq *irq;
 	int i;
 
-#ifdef CONFIG_RFS_ACCEL
-	if (adapter->msix_vecs >= 1) {
-		free_irq_cpu_rmap(adapter->netdev->rx_cpu_rmap);
-		adapter->netdev->rx_cpu_rmap = NULL;
-	}
-#endif /* CONFIG_RFS_ACCEL */
-
 	for (i = ENA_IO_IRQ_FIRST_IDX; i < ENA_MAX_MSIX_VEC(io_queue_count); i++) {
 		irq = &adapter->irq_tbl[i];
 		irq_set_affinity_hint(irq->vector, NULL);
@@ -4131,13 +4106,6 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	ena_dev = adapter->ena_dev;
 	netdev = adapter->netdev;
 
-#ifdef CONFIG_RFS_ACCEL
-	if ((adapter->msix_vecs >= 1) && (netdev->rx_cpu_rmap)) {
-		free_irq_cpu_rmap(netdev->rx_cpu_rmap);
-		netdev->rx_cpu_rmap = NULL;
-	}
-
-#endif /* CONFIG_RFS_ACCEL */
 	/* Make sure timer and reset routine won't be called after
 	 * freeing device resources.
 	 */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 46edea75e062..cc3ca3440b0a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -49,7 +49,6 @@
 #include <linux/cache.h>
 #include <linux/log2.h>
 #include <linux/bitmap.h>
-#include <linux/cpu_rmap.h>
 #include <linux/cpumask.h>
 #include <net/pkt_cls.h>
 #include <net/page_pool/helpers.h>
@@ -10833,7 +10832,7 @@ static int bnxt_set_real_num_queues(struct bnxt *bp)
 
 #ifdef CONFIG_RFS_ACCEL
 	if (bp->flags & BNXT_FLAG_RFS)
-		dev->rx_cpu_rmap = alloc_irq_cpu_rmap(bp->rx_nr_rings);
+		return netif_enable_cpu_rmap(dev, bp->rx_nr_rings);
 #endif
 
 	return rc;
@@ -11187,10 +11186,6 @@ static void bnxt_free_irq(struct bnxt *bp)
 	struct bnxt_irq *irq;
 	int i;
 
-#ifdef CONFIG_RFS_ACCEL
-	free_irq_cpu_rmap(bp->dev->rx_cpu_rmap);
-	bp->dev->rx_cpu_rmap = NULL;
-#endif
 	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
@@ -11213,11 +11208,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
-	int i, j, rc = 0;
+	int i, rc = 0;
 	unsigned long flags = 0;
-#ifdef CONFIG_RFS_ACCEL
-	struct cpu_rmap *rmap;
-#endif
 
 	rc = bnxt_setup_int_mode(bp);
 	if (rc) {
@@ -11225,22 +11217,11 @@ static int bnxt_request_irq(struct bnxt *bp)
 			   rc);
 		return rc;
 	}
-#ifdef CONFIG_RFS_ACCEL
-	rmap = bp->dev->rx_cpu_rmap;
-#endif
-	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
+
+	for (i = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
 
-#ifdef CONFIG_RFS_ACCEL
-		if (rmap && bp->bnapi[i]->rx_ring) {
-			rc = irq_cpu_rmap_add(rmap, irq->vector);
-			if (rc)
-				netdev_warn(bp->dev, "failed adding irq rmap for ring %d\n",
-					    j);
-			j++;
-		}
-#endif
 		rc = request_irq(irq->vector, irq->handler, flags, irq->name,
 				 bp->bnapi[i]);
 		if (rc)
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 7cee365cc7d1..3b1b892e6958 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -584,9 +584,6 @@ void ice_free_cpu_rx_rmap(struct ice_vsi *vsi)
 	netdev = vsi->netdev;
 	if (!netdev || !netdev->rx_cpu_rmap)
 		return;
-
-	free_irq_cpu_rmap(netdev->rx_cpu_rmap);
-	netdev->rx_cpu_rmap = NULL;
 }
 
 /**
@@ -597,7 +594,6 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 {
 	struct net_device *netdev;
 	struct ice_pf *pf;
-	int i;
 
 	if (!vsi || vsi->type != ICE_VSI_PF)
 		return 0;
@@ -610,18 +606,7 @@ int ice_set_cpu_rx_rmap(struct ice_vsi *vsi)
 	netdev_dbg(netdev, "Setup CPU RMAP: vsi type 0x%x, ifname %s, q_vectors %d\n",
 		   vsi->type, netdev->name, vsi->num_q_vectors);
 
-	netdev->rx_cpu_rmap = alloc_irq_cpu_rmap(vsi->num_q_vectors);
-	if (unlikely(!netdev->rx_cpu_rmap))
-		return -EINVAL;
-
-	ice_for_each_q_vector(vsi, i)
-		if (irq_cpu_rmap_add(netdev->rx_cpu_rmap,
-				     vsi->q_vectors[i]->irq.virq)) {
-			ice_free_cpu_rx_rmap(vsi);
-			return -EINVAL;
-		}
-
-	return 0;
+	return netif_enable_cpu_rmap(netdev, vsi->num_q_vectors);
 }
 
 /**
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1812564b5204..acf20191e114 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2398,6 +2398,9 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	bool			threaded;
+#ifdef CONFIG_RFS_ACCEL
+	bool			rx_cpu_rmap_auto;
+#endif
 
 	/* priv_flags_slow, ungrouped to save space */
 	unsigned long		see_all_hwtstamp_requests:1;
@@ -2671,10 +2674,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 			  enum netdev_queue_type type,
 			  struct napi_struct *napi);
 
-static inline void netif_napi_set_irq(struct napi_struct *napi, int irq)
-{
-	napi->irq = irq;
-}
+void netif_napi_set_irq(struct napi_struct *napi, int irq);
 
 /* Default NAPI poll() weight
  * Device drivers are strongly advised to not use bigger value
@@ -2765,6 +2765,10 @@ static inline void netif_napi_del(struct napi_struct *napi)
 	synchronize_net();
 }
 
+#ifdef CONFIG_RFS_ACCEL
+int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs);
+
+#endif
 struct packet_type {
 	__be16			type;	/* This is really htons(ether_type). */
 	bool			ignore_outgoing;
diff --git a/net/core/dev.c b/net/core/dev.c
index 26f0c2fbb8aa..8373e4cf56d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6730,6 +6730,46 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 }
 EXPORT_SYMBOL(netif_queue_set_napi);
 
+#ifdef CONFIG_RFS_ACCEL
+static void netif_disable_cpu_rmap(struct net_device *dev)
+{
+	free_irq_cpu_rmap(dev->rx_cpu_rmap);
+	dev->rx_cpu_rmap = NULL;
+	dev->rx_cpu_rmap_auto = false;
+}
+
+int netif_enable_cpu_rmap(struct net_device *dev, unsigned int num_irqs)
+{
+	dev->rx_cpu_rmap = alloc_irq_cpu_rmap(num_irqs);
+	if (!dev->rx_cpu_rmap)
+		return -ENOMEM;
+
+	dev->rx_cpu_rmap_auto = true;
+	return 0;
+}
+EXPORT_SYMBOL(netif_enable_cpu_rmap);
+#endif
+
+void netif_napi_set_irq(struct napi_struct *napi, int irq)
+{
+#ifdef CONFIG_RFS_ACCEL
+	int rc;
+#endif
+	napi->irq = irq;
+
+#ifdef CONFIG_RFS_ACCEL
+	if (napi->dev->rx_cpu_rmap && napi->dev->rx_cpu_rmap_auto) {
+		rc = irq_cpu_rmap_add(napi->dev->rx_cpu_rmap, irq);
+		if (rc) {
+			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
+				    rc);
+			netif_disable_cpu_rmap(napi->dev);
+		}
+	}
+#endif
+}
+EXPORT_SYMBOL(netif_napi_set_irq);
+
 static void napi_restore_config(struct napi_struct *n)
 {
 	n->defer_hard_irqs = n->config->defer_hard_irqs;
@@ -11406,6 +11446,10 @@ void free_netdev(struct net_device *dev)
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
+#ifdef CONFIG_RFS_ACCEL
+	if (dev->rx_cpu_rmap && dev->rx_cpu_rmap_auto)
+		netif_disable_cpu_rmap(dev);
+#endif
 	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
 		netif_napi_del(p);
 
-- 
2.43.0


