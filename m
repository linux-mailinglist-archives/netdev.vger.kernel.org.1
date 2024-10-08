Return-Path: <netdev+bounces-133362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A9995BBD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856B61F2239C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64B21859C;
	Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF2LeKry"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051CA216458
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430493; cv=none; b=N3MPc5AL1W0qfdMtRzYsOsFrtLREbkdWWYXtITTwI7/Cj47G1W6wNx66aZ/twYOUERovuaUCg4meUg7xj4Qq45C6HDzjsf/VLPlGeI9Vui+rVdid7NWpHbXwjfKYiuRzZPTc4bZKuvCuXHaMz3WYzYgV/WXgSeHpvwJipkKpj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430493; c=relaxed/simple;
	bh=5lW7JCGtpXA86hoIQaDzYexqubKZv3GlILnkx3IF4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPiQXgn4js9RGOMnYtDrbt0UDX1QVFNeLCBUcFd8Upq6fbllxCCNYWgFDGT8Ijj/xG+/FNre0zWuGNYT7S0DI6UIP6HTHV/6NGMNxb/myitfgMvEGX434MUywE1er0TG3VYUXMb4u6yfusxdLGKGFwdk++k4Ee5Y365hLJevcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LF2LeKry; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430492; x=1759966492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lW7JCGtpXA86hoIQaDzYexqubKZv3GlILnkx3IF4JE=;
  b=LF2LeKrybVzPce5lismetPOE2qKT+rZoKGmu1W9NH2KHyuhHSIQfy5Gd
   YmP41oVPcCWTu5pQXLYTwG1ixEi3sLi5zXaq/z/LyfsKsqyK+uMTQgkkD
   nnb0Ph1sk3vTCXy9h514pT9xSj8L2bsNc8NLVaZzRB3pT9dZ+dOfHlUID
   2HBRUjP8vyzVgPdBOMIT/j8t/E11RkwidKPnsHLkH3S/c01uZ7oNp+ZAQ
   5/UYNinXS+oalEZXH0UEjOrFRVUCWKRTLwUq1UUa7fljA4KMIFyyzcSyl
   aKMjkYG+xxonrbZthEZiccTi9WzjFkmbAyE5P5DpwhmtVR/vA5fyvBQzs
   A==;
X-CSE-ConnectionGUID: q/biUFi8S02ac+CFqgk6sg==
X-CSE-MsgGUID: YZz9KYu4Tme57269ATni0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779877"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779877"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:48 -0700
X-CSE-ConnectionGUID: JJbEViejTCewVR5/QJl5Rg==
X-CSE-MsgGUID: tKhn6z5STH6DuN/xAeOdig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794187"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 04/12] ice: store max_frame and rx_buf_len only in ice_rx_ring
Date: Tue,  8 Oct 2024 16:34:30 -0700
Message-ID: <20241008233441.928802-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The max_frame and rx_buf_len fields of the VSI set the maximum frame size
for packets on the wire, and configure the size of the Rx buffer. In the
hardware, these are per-queue configuration. Most VSI types use a simple
method to determine the size of the buffers for all queues.

However, VFs may potentially configure different values for each queue.
While the Linux iAVF driver does not do this, it is allowed by the virtchnl
interface.

The current virtchnl code simply sets the per-VSI fields inbetween calls to
ice_vsi_cfg_single_rxq(). This technically works, as these fields are only
ever used when programming the Rx ring, and otherwise not checked again.
However, it is confusing to maintain.

The Rx ring also already has an rx_buf_len field in order to access the
buffer length in the hotpath. It also has extra unused bytes in the ring
structure which we can make use of to store the maximum frame size.

Drop the VSI max_frame and rx_buf_len fields. Add max_frame to the Rx ring,
and slightly re-order rx_buf_len to better fit into the gaps in the
structure layout.

Change the ice_vsi_cfg_frame_size function so that it writes to the ring
fields. Call this function once per ring in ice_vsi_cfg_rxqs(). This is
done over calling it inside the ice_vsi_cfg_rxq(), because
ice_vsi_cfg_rxq() is called in the virtchnl flow where the max_frame and
rx_buf_len have already been configured.

Change the accesses for rx_buf_len and max_frame to all point to the ring
structure. This has the added benefit that ice_vsi_cfg_rxq() no longer has
the surprise side effect of updating ring->rx_buf_len based on the VSI
field.

Update the virtchnl ice_vc_cfg_qs_msg() function to set the ring values
directly, and drop references to the removed VSI fields.

This now makes the VF logic clear, as the ring fields are obviously
per-queue. This reduces the required cognitive load when reasoning about
this logic.

Note that removing the VSI fields does leave a 4 byte gap, but the ice_vsi
structure has many gaps, and its layout is not as critical in the hot path.
The structure may benefit from a more thorough repacking, but no attempt
was made in this change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  3 --
 drivers/net/ethernet/intel/ice/ice_base.c     | 34 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  3 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  7 ++--
 4 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2960709f6b62..0e699a0432c5 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -372,9 +372,6 @@ struct ice_vsi {
 	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
 	atomic_t *arfs_last_fltr_id;
 
-	u16 max_frame;
-	u16 rx_buf_len;
-
 	struct ice_aqc_vsi_props info;	 /* VSI properties */
 	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
 
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 4a9a6899fc45..98c3764fed39 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -445,7 +445,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Max packet size for this queue - must not be set to a larger value
 	 * than 5 x DBUF
 	 */
-	rlan_ctx.rxmax = min_t(u32, vsi->max_frame,
+	rlan_ctx.rxmax = min_t(u32, ring->max_frame,
 			       ICE_MAX_CHAINED_RX_BUFS * ring->rx_buf_len);
 
 	/* Rx queue threshold in units of 64 */
@@ -541,8 +541,6 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
 	int err;
 
-	ring->rx_buf_len = ring->vsi->rx_buf_len;
-
 	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
@@ -641,21 +639,25 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
 /**
  * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
  * @vsi: VSI
+ * @ring: Rx ring to configure
+ *
+ * Determine the maximum frame size and Rx buffer length to use for a PF VSI.
+ * Set these in the associated Rx ring structure.
  */
-static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
+static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ice_rx_ring *ring)
 {
 	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		vsi->rx_buf_len = ICE_RXBUF_1664;
+		ring->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		ring->rx_buf_len = ICE_RXBUF_1664;
 #if (PAGE_SIZE < 8192)
 	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
 		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		ring->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		ring->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
 #endif
 	} else {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_3072;
+		ring->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
+		ring->rx_buf_len = ICE_RXBUF_3072;
 	}
 }
 
@@ -670,15 +672,15 @@ int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
 {
 	u16 i;
 
-	if (vsi->type == ICE_VSI_VF)
-		goto setup_rings;
-
-	ice_vsi_cfg_frame_size(vsi);
-setup_rings:
 	/* set up individual rings */
 	ice_for_each_rxq(vsi, i) {
-		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
+		struct ice_rx_ring *ring = vsi->rx_rings[i];
+		int err;
+
+		if (vsi->type != ICE_VSI_VF)
+			ice_vsi_cfg_frame_size(vsi, ring);
 
+		err = ice_vsi_cfg_rxq(ring);
 		if (err)
 			return err;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index feba314a3fe4..67153f5b6891 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -359,8 +359,9 @@ struct ice_rx_ring {
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
 	u32 nr_frags;
-	dma_addr_t dma;			/* physical address of ring */
+	u16 max_frame;
 	u16 rx_buf_len;
+	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 ptp_rx;
 #define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index c8c1d48ff793..a230859584c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1748,19 +1748,18 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
 				goto error_param;
-			vsi->rx_buf_len = qpi->rxq.databuffer_size;
-			ring->rx_buf_len = vsi->rx_buf_len;
+			ring->rx_buf_len = qpi->rxq.databuffer_size;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
 
-			vsi->max_frame = qpi->rxq.max_pkt_size;
+			ring->max_frame = qpi->rxq.max_pkt_size;
 			/* add space for the port VLAN since the VF driver is
 			 * not expected to account for it in the MTU
 			 * calculation
 			 */
 			if (ice_vf_is_port_vlan_ena(vf))
-				vsi->max_frame += VLAN_HLEN;
+				ring->max_frame += VLAN_HLEN;
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure RX queue %d\n",
-- 
2.42.0


