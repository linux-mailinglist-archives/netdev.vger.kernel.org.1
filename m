Return-Path: <netdev+bounces-28214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2AB77EB13
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7E31C211EA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF21AA60;
	Wed, 16 Aug 2023 20:54:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF219890
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDDF2716
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219273; x=1723755273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LxVL8r8Q2Uw4ewyy6QFXh9rc69ewU742zI2hT7ml1Xo=;
  b=bjzCeIiSpo9hrOMHLSN8miQ3IUr9wi0TgnQZjQAjPu1JXVxN0JVHRxGY
   bgIcZ+o1D7NWB0G+U++8wEYht43SrmUboglf+LiJyvrWPdiWxDSxMsrs2
   DuCQ3Yc93GsKYNo8/yQ32Cb0srelP4G2XKD32uJ/DCoVV6RogES3gixDp
   Sg5PqKo5z+tz9836i/xhyf3ecFeT0TePeWHsfk5CgnNm4Ly4cPhNnfggP
   KXc/PgE88LgFu1OduVE/c72/sO7xmTjmk4XE+5uS8mylKMrqiEnfikl9N
   fqoCNacUegoPcSbVgcH9dCFch7BSx6/PIl+FeUHNRzkcHCdiCKz8T8Vtn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604766"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604766"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626381"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626381"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 03/14] ice: refactor ice_lib to make functions static
Date: Wed, 16 Aug 2023 13:47:25 -0700
Message-Id: <20230816204736.1325132-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As following methods are not used outside of ice_lib,
they can be made static:
ice_vsi_is_vlan_pruning_ena
ice_vsi_cfg_frame_size

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 70 ++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_lib.h |  3 -
 2 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 54aa01d2a474..d3fb2b7535e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1227,6 +1227,20 @@ ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 	ctxt->info.q_mapping[1] = cpu_to_le16(qcount);
 }
 
+/**
+ * ice_vsi_is_vlan_pruning_ena - check if VLAN pruning is enabled or not
+ * @vsi: VSI to check whether or not VLAN pruning is enabled.
+ *
+ * returns true if Rx VLAN pruning is enabled and false otherwise.
+ */
+static bool ice_vsi_is_vlan_pruning_ena(struct ice_vsi *vsi)
+{
+	if (!vsi)
+		return false;
+
+	return (vsi->info.sw_flags2 & ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA);
+}
+
 /**
  * ice_vsi_init - Create and initialize a VSI
  * @vsi: the VSI being configured
@@ -1684,6 +1698,27 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 			vsi_num, status);
 }
 
+/**
+ * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
+ * @vsi: VSI
+ */
+static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
+{
+	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		vsi->rx_buf_len = ICE_RXBUF_1664;
+#if (PAGE_SIZE < 8192)
+	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
+		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
+		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+#endif
+	} else {
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
+		vsi->rx_buf_len = ICE_RXBUF_3072;
+	}
+}
+
 /**
  * ice_pf_state_is_nominal - checks the PF for nominal state
  * @pf: pointer to PF to check
@@ -1758,27 +1793,6 @@ void ice_update_eth_stats(struct ice_vsi *vsi)
 	vsi->stat_offsets_loaded = true;
 }
 
-/**
- * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
- * @vsi: VSI
- */
-void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
-{
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		vsi->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
-	} else {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_3072;
-	}
-}
-
 /**
  * ice_write_qrxflxp_cntxt - write/configure QRXFLXP_CNTXT register
  * @hw: HW pointer
@@ -2185,20 +2199,6 @@ bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi)
 	return false;
 }
 
-/**
- * ice_vsi_is_vlan_pruning_ena - check if VLAN pruning is enabled or not
- * @vsi: VSI to check whether or not VLAN pruning is enabled.
- *
- * returns true if Rx VLAN pruning is enabled and false otherwise.
- */
-bool ice_vsi_is_vlan_pruning_ena(struct ice_vsi *vsi)
-{
-	if (!vsi)
-		return false;
-
-	return (vsi->info.sw_flags2 & ICE_AQ_VSI_SW_FLAG_RX_VLAN_PRUNE_ENA);
-}
-
 static void ice_vsi_set_tc_cfg(struct ice_vsi *vsi)
 {
 	if (!test_bit(ICE_FLAG_DCB_ENA, vsi->back->flags)) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index cb6599cb8be6..f24f5d1e6f9c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -76,8 +76,6 @@ int ice_vsi_cfg_xdp_txqs(struct ice_vsi *vsi);
 
 int ice_vsi_stop_xdp_tx_rings(struct ice_vsi *vsi);
 
-bool ice_vsi_is_vlan_pruning_ena(struct ice_vsi *vsi);
-
 void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create);
 
 int ice_set_link(struct ice_vsi *vsi, bool ena);
@@ -128,7 +126,6 @@ void ice_update_tx_ring_stats(struct ice_tx_ring *ring, u64 pkts, u64 bytes);
 
 void ice_update_rx_ring_stats(struct ice_rx_ring *ring, u64 pkts, u64 bytes);
 
-void ice_vsi_cfg_frame_size(struct ice_vsi *vsi);
 void ice_write_intrl(struct ice_q_vector *q_vector, u8 intrl);
 void ice_write_itr(struct ice_ring_container *rc, u16 itr);
 void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
-- 
2.38.1


