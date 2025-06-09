Return-Path: <netdev+bounces-195877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B5BAD28C0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8745A3B38B8
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB683223DF9;
	Mon,  9 Jun 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfAQNvAn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2B022539C
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504430; cv=none; b=O7GCA/qqUCydpIA4jCx+aXqf/NkKRoPfbtUBeAd9ZjqOQvLeQEmOAK1YgXVpK2DBeP5IMswlBQ6GQFFt+GpSonLQWBKHuTfTu9+kKwnZtNio7YdhDHJm9SVz054NKIOt5TROkqWtFgfgtxB9Ex0+QpPYrNHomRJWpt4PSVzEl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504430; c=relaxed/simple;
	bh=bpsDvbg3IlPaR1yGNilsU3Z5SvEyb6oPP99+yYRE8vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiAmeRP6rQB86TPfoVpE8yF55rz2ho093ajWru/ayMlNMnT7DkYy1BnBpz5+CxHqO5tlvRrR06vzSOIf/5ZSRw6ssce8KCk7Cg1n+ajUatiA53bmYeO7DOQLbdKEmnCToLAGnSZOA8Iu7FJMhI35XCVq6SBJTev5oa6xq2J0lCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfAQNvAn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504429; x=1781040429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpsDvbg3IlPaR1yGNilsU3Z5SvEyb6oPP99+yYRE8vA=;
  b=FfAQNvAn8WuHX907hjniviLh7MP3hq78WCWcPPIqr3GaEw35SHYC1LyF
   29Ff24TZJv1SfJYv4W8OKA9xyItWSwq4Xq7DbU+tZg82Wb+4eBV17qO+S
   LrLKXh42mmXQzn81S5qMcGwCzTQRbszna1Sg3Djbc4HvCpYhmA1O2slki
   QQkMneOBx13ONB/enylqnMDvfopQU7iOPl3nRmTIy4qlegXECWbdK/E+e
   Xtt3YGoqyMEpmd540cRXfHv9CCFrkEs2rPVfdfrjY5oUqndXrAXSSUvFQ
   VJIGhJ8RfZOb+KQaK6Swdol0Roy7TBhfdkXR9gc6/v2idoHI7/ifV1FLI
   Q==;
X-CSE-ConnectionGUID: BtedmViqSO6IJYcyPyW+vA==
X-CSE-MsgGUID: jsn7AAk2QJ2ox9Ird09aDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864234"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864234"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:05 -0700
X-CSE-ConnectionGUID: AjA1DmBnS3qZEPUvT4MHBA==
X-CSE-MsgGUID: kr50FyTRTZ+rqJVpFn+NtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469054"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Kubiak <michal.kubiak@intel.com>,
	anthony.l.nguyen@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 09/11] ice: add a separate Rx handler for flow director commands
Date: Mon,  9 Jun 2025 14:26:48 -0700
Message-ID: <20250609212652.1138933-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Kubiak <michal.kubiak@intel.com>

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c |  5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  |  3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c | 87 +++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_txrx.h |  3 +-
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 6db4ad8fc70b..270f936ce807 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -623,7 +623,10 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
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
index 2cc050db509f..2f1782e9357f 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -484,8 +484,7 @@ static irqreturn_t ice_msix_clean_ctrl_vsi(int __always_unused irq, void *data)
 	if (!q_vector->tx.tx_ring)
 		return IRQ_HANDLED;
 
-#define FDIR_RX_DESC_CLEAN_BUDGET 64
-	ice_clean_rx_irq(q_vector->rx.rx_ring, FDIR_RX_DESC_CLEAN_BUDGET);
+	ice_clean_ctrl_rx_irq(q_vector->rx.rx_ring);
 	ice_clean_ctrl_tx_irq(q_vector->tx.tx_ring);
 
 	return IRQ_HANDLED;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 0e5107fe62ad..29e0088ab6b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -20,7 +20,6 @@
 
 #define ICE_RX_HDR_SIZE		256
 
-#define FDIR_DESC_RXDID 0x40
 #define ICE_FDIR_CLEAN_DELAY 10
 
 /**
@@ -706,6 +705,37 @@ ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
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
@@ -726,8 +756,7 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 	struct ice_rx_buf *bi;
 
 	/* do nothing if no valid netdev defined */
-	if ((!rx_ring->netdev && rx_ring->vsi->type != ICE_VSI_CTRL) ||
-	    !cleaned_count)
+	if (!rx_ring->netdev || !cleaned_count)
 		return false;
 
 	/* get the Rx descriptor and buffer based on next_to_use */
@@ -1183,6 +1212,45 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
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
@@ -1195,7 +1263,7 @@ static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
  *
  * Returns amount of work completed
  */
-int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
+static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
 	unsigned int offset = rx_ring->rx_offset;
@@ -1242,17 +1310,6 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
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
index a4b1e9514632..fef750c5f288 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -491,6 +491,7 @@ static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 
 union ice_32b_rx_flex_desc;
 
+void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
 bool ice_alloc_rx_bufs(struct ice_rx_ring *rxr, unsigned int cleaned_count);
 netdev_tx_t ice_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 u16
@@ -506,6 +507,6 @@ int ice_napi_poll(struct napi_struct *napi, int budget);
 int
 ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 		   u8 *raw_packet);
-int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget);
 void ice_clean_ctrl_tx_irq(struct ice_tx_ring *tx_ring);
+void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring);
 #endif /* _ICE_TXRX_H_ */
-- 
2.47.1


