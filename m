Return-Path: <netdev+bounces-176745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48498A6BE0D
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2462172D19
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6061CEEBE;
	Fri, 21 Mar 2025 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/o91P4F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC321CEACB
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570054; cv=none; b=TXxuDzPen98qgOsr/Q1U93XJPJs3F2fWvUtO/bxWJxU7DimP+joYSDeprfcIKPMHHXr13Xm46zaR8DdmyregOs0xdlkW9qEedbZRlNcuA6FEfOXIYY8g64rG2NcxqmZdUI8zFG/40dRLOo8fmar0hoZ+5S/ggXp5XLwBaL8e0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570054; c=relaxed/simple;
	bh=Lp68kh7cSiXp8XiOx98wqfz59mQcCa1aTJcAHVClIjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mR6dOWEcds/oQ8BxB6lX837MZuogFHoiCUsgV4FFL3PX1w4mN8e7Sd9BW2ZFN71c8v994fa5w3BsSnqnWgmEL68cUvU4x06oZ6k6CESUohksco7aAxeT8rz7U9bSVvRXrge+2VvomXIj7jmouwb2EBuDgo9DNbBybh8ubYfG4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/o91P4F; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742570052; x=1774106052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lp68kh7cSiXp8XiOx98wqfz59mQcCa1aTJcAHVClIjM=;
  b=M/o91P4F+ebeuAZwjpGWO9RHhh3zFZfb8fROiGqczE29OCM5hFnGblT7
   7MVwb67ZXBM+kBIx1JAzPDXolhPBwIWfkOXjG38YVOMMSrVobnYk+Ha9z
   IcHWFLawIVq/5RPsFswrdF74wo8xmF4IcOu7sOuedtFlK0NHtaU9WAyc0
   KY0+NNQ93QkS072YEMK5vcl+IR3LOVHnk4Ifcq39ArSKIrAGHCbbKnw9B
   9rzMHWRwQ0+4oZBaT6VP23ajFKx50Bu4yNC9z7NEJX+aoqePVjuvU+n7k
   If1Y81qSZwc4ErCDeLDBQurTkFwNvY4dtNWkeAAOCaAZw3azxpyn3iiya
   Q==;
X-CSE-ConnectionGUID: ftn0lwlURMi7/emG9m7RGQ==
X-CSE-MsgGUID: 5CdL06dXR6O4xJPAU58Tzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="44028837"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="44028837"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:14:12 -0700
X-CSE-ConnectionGUID: M/h8JtarQbKBApoGkZTCLQ==
X-CSE-MsgGUID: lXNltst2QjCvMZjoAtc8BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; 
   d="scan'208";a="146646971"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 08:14:10 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@intel.com>
Subject: [PATCH iwl-next] ice: add a separate Rx handler for flow director commands
Date: Fri, 21 Mar 2025 16:13:57 +0100
Message-Id: <20250321151357.28540-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "ice" driver implementation uses the control VSI to handle
the flow director configuration for PFs and VFs.

Unfortunately, although a separate VSI type was created to handle flow
director queues, the Rx queue handler was shared between the flow
director and a standard NAPI Rx handler.

Such a design approach was not very flexible. First, it mixed hotpath
and slowpath code, blocking their further optimization. It also created
a huge overkill for the flow director command processing, which is
descriptor-based only, so there is no need to allocate Rx data buffers.

For the above reasons, implement a separate Rx handler for the control
VSI. Also, remove from the NAPI handler the code dedicated to
configuring the flow director rules on VFs.
Do not allocate Rx data buffers to the flow director queues because
their processing is descriptor-based only.
Finally, allow Rx data queues to be allocated only for VSIs that have
netdev assigned to them.

This handler splitting approach is the first step in converting the
driver to use the Page Pool (which can only be used for data queues).

Test hints:
  1. Create a VF for any PF managed by the ice driver.
  2. In a loop, add and delete flow director rules for the VF, e.g.:

       for i in {1..128}; do
           q=$(( i % 16 ))
           ethtool -N ens802f0v0 flow-type tcp4 dst-port "$i" action "$q"
       done

       for i in {0..127}; do
           ethtool -N ens802f0v0 delete "$i"
       done

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Suggested-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c |  5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  |  3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 85 +++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_txrx.h |  2 +
 4 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b94c56a82cc5..8bc333b794eb 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -717,7 +717,10 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		return 0;
 	}
 
-	ice_alloc_rx_bufs(ring, num_bufs);
+	if (ring->vsi->type == ICE_VSI_CTRL)
+		ice_init_ctrl_rx_descs(ring, num_bufs);
+	else
+		ice_alloc_rx_bufs(ring, num_bufs);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6392d27861e5..b857717441c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -497,8 +497,7 @@ static irqreturn_t ice_msix_clean_ctrl_vsi(int __always_unused irq, void *data)
 	if (!q_vector->tx.tx_ring)
 		return IRQ_HANDLED;
 
-#define FDIR_RX_DESC_CLEAN_BUDGET 64
-	ice_clean_rx_irq(q_vector->rx.rx_ring, FDIR_RX_DESC_CLEAN_BUDGET);
+	ice_clean_ctrl_rx_irq(q_vector->rx.rx_ring);
 	ice_clean_ctrl_tx_irq(q_vector->tx.tx_ring);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 69cdbd2eda07..72980c504a92 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -20,7 +20,6 @@
 
 #define ICE_RX_HDR_SIZE		256
 
-#define FDIR_DESC_RXDID 0x40
 #define ICE_FDIR_CLEAN_DELAY 10
 
 /**
@@ -775,6 +774,37 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
 	return true;
 }
 
+/**
+ * ice_init_ctrl_rx_descs - Initialize Rx descriptors for control vsi.
+ * @rx_ring: ring to init descriptors on
+ * @count: number of descriptors to initialize
+ */
+void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 count)
+{
+	union ice_32b_rx_flex_desc *rx_desc;
+	u32 ntu = rx_ring->next_to_use;
+
+	if (!count)
+		return;
+
+	rx_desc = ICE_RX_DESC(rx_ring, ntu);
+
+	do {
+		rx_desc++;
+		ntu++;
+		if (unlikely(ntu == rx_ring->count)) {
+			rx_desc = ICE_RX_DESC(rx_ring, 0);
+			ntu = 0;
+		}
+
+		rx_desc->wb.status_error0 = 0;
+		count--;
+	} while (count);
+
+	if (rx_ring->next_to_use != ntu)
+		ice_release_rx_desc(rx_ring, ntu);
+}
+
 /**
  * ice_alloc_rx_bufs - Replace used receive buffers
  * @rx_ring: ring to place buffers on
@@ -795,8 +825,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 	struct ice_rx_buf *bi;
 
 	/* do nothing if no valid netdev defined */
-	if ((!rx_ring->netdev && rx_ring->vsi->type != ICE_VSI_CTRL) ||
-	    !cleaned_count)
+	if (!rx_ring->netdev || !cleaned_count)
 		return false;
 
 	/* get the Rx descriptor and buffer based on next_to_use */
@@ -1252,6 +1281,45 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	rx_ring->nr_frags = 0;
 }
 
+/**
+ * ice_clean_ctrl_rx_irq - Clean descriptors from flow director Rx ring
+ * @rx_ring: Rx descriptor ring for ctrl_vsi to transact packets on
+ *
+ * This function cleans Rx descriptors from the ctrl_vsi Rx ring used
+ * to set flow director rules on VFs.
+ */
+void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
+{
+	u32 ntc = rx_ring->next_to_clean;
+	unsigned int total_rx_pkts = 0;
+	u32 cnt = rx_ring->count;
+
+	while (likely(total_rx_pkts < ICE_DFLT_IRQ_WORK)) {
+		struct ice_vsi *ctrl_vsi = rx_ring->vsi;
+		union ice_32b_rx_flex_desc *rx_desc;
+		u16 stat_err_bits;
+
+		rx_desc = ICE_RX_DESC(rx_ring, ntc);
+
+		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_DD_S);
+		if (!ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
+			break;
+
+		dma_rmb();
+
+		if (ctrl_vsi->vf)
+			ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
+
+		if (++ntc == cnt)
+			ntc = 0;
+		total_rx_pkts++;
+	}
+
+	rx_ring->first_desc = ntc;
+	rx_ring->next_to_clean = ntc;
+	ice_init_ctrl_rx_descs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
+}
+
 /**
  * ice_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1311,17 +1379,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		dma_rmb();
 
 		ice_trace(clean_rx_irq, rx_ring, rx_desc);
-		if (rx_desc->wb.rxdid == FDIR_DESC_RXDID || !rx_ring->netdev) {
-			struct ice_vsi *ctrl_vsi = rx_ring->vsi;
-
-			if (rx_desc->wb.rxdid == FDIR_DESC_RXDID &&
-			    ctrl_vsi->vf)
-				ice_vc_fdir_irq_handler(ctrl_vsi, rx_desc);
-			if (++ntc == cnt)
-				ntc = 0;
-			rx_ring->first_desc = ntc;
-			continue;
-		}
 
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 			ICE_RX_FLX_DESC_PKT_LEN_M;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 4b63081629d0..041768df0b23 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -492,6 +492,7 @@ static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 
 union ice_32b_rx_flex_desc;
 
+void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
 bool ice_alloc_rx_bufs(struct ice_rx_ring *rxr, unsigned int cleaned_count);
 netdev_tx_t ice_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 u16
@@ -512,4 +513,5 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 		   u8 *raw_packet);
 int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget);
 void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring);
+void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring);
 #endif /* _ICE_TXRX_H_ */
-- 
2.45.2


