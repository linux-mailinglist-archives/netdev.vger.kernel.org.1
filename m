Return-Path: <netdev+bounces-28616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C077FFED
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BF7281F25
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944F1BF19;
	Thu, 17 Aug 2023 21:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A801BF07
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1FAE6B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307777; x=1723843777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+NTmOQG7rquNR3BaGtEGPJgab9hPValTgOOse1yWhE=;
  b=SqajIuV9BrGOK5s8a574VPGtEkHG4wLq6l6sVkxZtmScb5m1379eJEhc
   LbwG1615n1x5vwzMVH0lrUZlbfzc3/gEuM9LIsCYoCOUt4hD8c54x9J8g
   5CJqJcQV2723WLYAqlZXnDXfEwOy5IUY852YDIntkoc0wB7FMn/szD31M
   en0jlIbkz0AH84hoydAIR1IIvM0Ob/HIHf6J+jFHo7ykH3rlWeIP7L/Fc
   qpCoTFgqy+M6hOolCBOHtckm4jgtKg+z3Dh36H2y0KoU7RszZEnVf9n8+
   UIMqOP8WhkFL6SX5tkpcV955sX6jCXT0qemBdW5pn8IhkpB8BwF8NPl+g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095057"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095057"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813704"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813704"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	leonro@nvidia.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 04/15] ice: refactor ice_vf_lib to make functions static
Date: Thu, 17 Aug 2023 14:22:28 -0700
Message-Id: <20230817212239.2601543-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As following methods are not used outside ice_vf_lib,
they can be made static:
ice_vf_rebuild_host_vlan_cfg
ice_vf_rebuild_host_tx_rate_cfg
ice_vf_set_host_trust_cfg
ice_vf_rebuild_host_mac_cfg
ice_vf_rebuild_aggregator_node_cfg
ice_vf_rebuild_host_cfg
ice_set_vf_state_qs_dis
ice_vf_set_initialized

In order to achieve that, the order in which these
were defined was reorganized.

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 468 +++++++++---------
 .../ethernet/intel/ice/ice_vf_lib_private.h   |   2 -
 2 files changed, 234 insertions(+), 236 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index b26ce4425f45..20c4beaa05d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -322,6 +322,240 @@ static int ice_vf_rebuild_vsi(struct ice_vf *vf)
 	return 0;
 }
 
+/**
+ * ice_vf_rebuild_host_vlan_cfg - add VLAN 0 filter or rebuild the Port VLAN
+ * @vf: VF to add MAC filters for
+ * @vsi: Pointer to VSI
+ *
+ * Called after a VF VSI has been re-added/rebuilt during reset. The PF driver
+ * always re-adds either a VLAN 0 or port VLAN based filter after reset.
+ */
+static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
+{
+	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
+	struct device *dev = ice_pf_to_dev(vf->pf);
+	int err;
+
+	if (ice_vf_is_port_vlan_ena(vf)) {
+		err = vlan_ops->set_port_vlan(vsi, &vf->port_vlan_info);
+		if (err) {
+			dev_err(dev, "failed to configure port VLAN via VSI parameters for VF %u, error %d\n",
+				vf->vf_id, err);
+			return err;
+		}
+
+		err = vlan_ops->add_vlan(vsi, &vf->port_vlan_info);
+	} else {
+		err = ice_vsi_add_vlan_zero(vsi);
+	}
+
+	if (err) {
+		dev_err(dev, "failed to add VLAN %u filter for VF %u during VF rebuild, error %d\n",
+			ice_vf_is_port_vlan_ena(vf) ?
+			ice_vf_get_port_vlan_id(vf) : 0, vf->vf_id, err);
+		return err;
+	}
+
+	err = vlan_ops->ena_rx_filtering(vsi);
+	if (err)
+		dev_warn(dev, "failed to enable Rx VLAN filtering for VF %d VSI %d during VF rebuild, error %d\n",
+			 vf->vf_id, vsi->idx, err);
+
+	return 0;
+}
+
+/**
+ * ice_vf_rebuild_host_tx_rate_cfg - re-apply the Tx rate limiting configuration
+ * @vf: VF to re-apply the configuration for
+ *
+ * Called after a VF VSI has been re-added/rebuild during reset. The PF driver
+ * needs to re-apply the host configured Tx rate limiting configuration.
+ */
+static int ice_vf_rebuild_host_tx_rate_cfg(struct ice_vf *vf)
+{
+	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+	int err;
+
+	if (WARN_ON(!vsi))
+		return -EINVAL;
+
+	if (vf->min_tx_rate) {
+		err = ice_set_min_bw_limit(vsi, (u64)vf->min_tx_rate * 1000);
+		if (err) {
+			dev_err(dev, "failed to set min Tx rate to %d Mbps for VF %u, error %d\n",
+				vf->min_tx_rate, vf->vf_id, err);
+			return err;
+		}
+	}
+
+	if (vf->max_tx_rate) {
+		err = ice_set_max_bw_limit(vsi, (u64)vf->max_tx_rate * 1000);
+		if (err) {
+			dev_err(dev, "failed to set max Tx rate to %d Mbps for VF %u, error %d\n",
+				vf->max_tx_rate, vf->vf_id, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vf_set_host_trust_cfg - set trust setting based on pre-reset value
+ * @vf: VF to configure trust setting for
+ */
+static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
+{
+	if (vf->trusted)
+		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+	else
+		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
+}
+
+/**
+ * ice_vf_rebuild_host_mac_cfg - add broadcast and the VF's perm_addr/LAA
+ * @vf: VF to add MAC filters for
+ *
+ * Called after a VF VSI has been re-added/rebuilt during reset. The PF driver
+ * always re-adds a broadcast filter and the VF's perm_addr/LAA after reset.
+ */
+static int ice_vf_rebuild_host_mac_cfg(struct ice_vf *vf)
+{
+	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+	u8 broadcast[ETH_ALEN];
+	int status;
+
+	if (WARN_ON(!vsi))
+		return -EINVAL;
+
+	if (ice_is_eswitch_mode_switchdev(vf->pf))
+		return 0;
+
+	eth_broadcast_addr(broadcast);
+	status = ice_fltr_add_mac(vsi, broadcast, ICE_FWD_TO_VSI);
+	if (status) {
+		dev_err(dev, "failed to add broadcast MAC filter for VF %u, error %d\n",
+			vf->vf_id, status);
+		return status;
+	}
+
+	vf->num_mac++;
+
+	if (is_valid_ether_addr(vf->hw_lan_addr)) {
+		status = ice_fltr_add_mac(vsi, vf->hw_lan_addr,
+					  ICE_FWD_TO_VSI);
+		if (status) {
+			dev_err(dev, "failed to add default unicast MAC filter %pM for VF %u, error %d\n",
+				&vf->hw_lan_addr[0], vf->vf_id,
+				status);
+			return status;
+		}
+		vf->num_mac++;
+
+		ether_addr_copy(vf->dev_lan_addr, vf->hw_lan_addr);
+	}
+
+	return 0;
+}
+
+/**
+ * ice_vf_rebuild_aggregator_node_cfg - rebuild aggregator node config
+ * @vsi: Pointer to VSI
+ *
+ * This function moves VSI into corresponding scheduler aggregator node
+ * based on cached value of "aggregator node info" per VSI
+ */
+static void ice_vf_rebuild_aggregator_node_cfg(struct ice_vsi *vsi)
+{
+	struct ice_pf *pf = vsi->back;
+	struct device *dev;
+	int status;
+
+	if (!vsi->agg_node)
+		return;
+
+	dev = ice_pf_to_dev(pf);
+	if (vsi->agg_node->num_vsis == ICE_MAX_VSIS_IN_AGG_NODE) {
+		dev_dbg(dev,
+			"agg_id %u already has reached max_num_vsis %u\n",
+			vsi->agg_node->agg_id, vsi->agg_node->num_vsis);
+		return;
+	}
+
+	status = ice_move_vsi_to_agg(pf->hw.port_info, vsi->agg_node->agg_id,
+				     vsi->idx, vsi->tc_cfg.ena_tc);
+	if (status)
+		dev_dbg(dev, "unable to move VSI idx %u into aggregator %u node",
+			vsi->idx, vsi->agg_node->agg_id);
+	else
+		vsi->agg_node->num_vsis++;
+}
+
+/**
+ * ice_vf_rebuild_host_cfg - host admin configuration is persistent across reset
+ * @vf: VF to rebuild host configuration on
+ */
+static void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
+{
+	struct device *dev = ice_pf_to_dev(vf->pf);
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+
+	if (WARN_ON(!vsi))
+		return;
+
+	ice_vf_set_host_trust_cfg(vf);
+
+	if (ice_vf_rebuild_host_mac_cfg(vf))
+		dev_err(dev, "failed to rebuild default MAC configuration for VF %d\n",
+			vf->vf_id);
+
+	if (ice_vf_rebuild_host_vlan_cfg(vf, vsi))
+		dev_err(dev, "failed to rebuild VLAN configuration for VF %u\n",
+			vf->vf_id);
+
+	if (ice_vf_rebuild_host_tx_rate_cfg(vf))
+		dev_err(dev, "failed to rebuild Tx rate limiting configuration for VF %u\n",
+			vf->vf_id);
+
+	if (ice_vsi_apply_spoofchk(vsi, vf->spoofchk))
+		dev_err(dev, "failed to rebuild spoofchk configuration for VF %d\n",
+			vf->vf_id);
+
+	/* rebuild aggregator node config for main VF VSI */
+	ice_vf_rebuild_aggregator_node_cfg(vsi);
+}
+
+/**
+ * ice_set_vf_state_qs_dis - Set VF queues state to disabled
+ * @vf: pointer to the VF structure
+ */
+static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
+{
+	/* Clear Rx/Tx enabled queues flag */
+	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
+	bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
+	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
+}
+
+/**
+ * ice_vf_set_initialized - VF is ready for VIRTCHNL communication
+ * @vf: VF to set in initialized state
+ *
+ * After this function the VF will be ready to receive/handle the
+ * VIRTCHNL_OP_GET_VF_RESOURCES message
+ */
+static void ice_vf_set_initialized(struct ice_vf *vf)
+{
+	ice_set_vf_state_qs_dis(vf);
+	clear_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states);
+	clear_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states);
+	clear_bit(ICE_VF_STATE_DIS, vf->vf_states);
+	set_bit(ICE_VF_STATE_INIT, vf->vf_states);
+	memset(&vf->vlan_v2_caps, 0, sizeof(vf->vlan_v2_caps));
+}
+
 /**
  * ice_vf_post_vsi_rebuild - Reset tasks that occur after VSI rebuild
  * @vf: the VF being reset
@@ -725,18 +959,6 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	return err;
 }
 
-/**
- * ice_set_vf_state_qs_dis - Set VF queues state to disabled
- * @vf: pointer to the VF structure
- */
-static void ice_set_vf_state_qs_dis(struct ice_vf *vf)
-{
-	/* Clear Rx/Tx enabled queues flag */
-	bitmap_zero(vf->txq_ena, ICE_MAX_RSS_QS_PER_VF);
-	bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
-	clear_bit(ICE_VF_STATE_QS_ENA, vf->vf_states);
-}
-
 /**
  * ice_set_vf_state_dis - Set VF state to disabled
  * @vf: pointer to the VF structure
@@ -977,211 +1199,6 @@ bool ice_is_vf_link_up(struct ice_vf *vf)
 			ICE_AQ_LINK_UP;
 }
 
-/**
- * ice_vf_set_host_trust_cfg - set trust setting based on pre-reset value
- * @vf: VF to configure trust setting for
- */
-static void ice_vf_set_host_trust_cfg(struct ice_vf *vf)
-{
-	if (vf->trusted)
-		set_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
-	else
-		clear_bit(ICE_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
-}
-
-/**
- * ice_vf_rebuild_host_mac_cfg - add broadcast and the VF's perm_addr/LAA
- * @vf: VF to add MAC filters for
- *
- * Called after a VF VSI has been re-added/rebuilt during reset. The PF driver
- * always re-adds a broadcast filter and the VF's perm_addr/LAA after reset.
- */
-static int ice_vf_rebuild_host_mac_cfg(struct ice_vf *vf)
-{
-	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
-	u8 broadcast[ETH_ALEN];
-	int status;
-
-	if (WARN_ON(!vsi))
-		return -EINVAL;
-
-	if (ice_is_eswitch_mode_switchdev(vf->pf))
-		return 0;
-
-	eth_broadcast_addr(broadcast);
-	status = ice_fltr_add_mac(vsi, broadcast, ICE_FWD_TO_VSI);
-	if (status) {
-		dev_err(dev, "failed to add broadcast MAC filter for VF %u, error %d\n",
-			vf->vf_id, status);
-		return status;
-	}
-
-	vf->num_mac++;
-
-	if (is_valid_ether_addr(vf->hw_lan_addr)) {
-		status = ice_fltr_add_mac(vsi, vf->hw_lan_addr,
-					  ICE_FWD_TO_VSI);
-		if (status) {
-			dev_err(dev, "failed to add default unicast MAC filter %pM for VF %u, error %d\n",
-				&vf->hw_lan_addr[0], vf->vf_id,
-				status);
-			return status;
-		}
-		vf->num_mac++;
-
-		ether_addr_copy(vf->dev_lan_addr, vf->hw_lan_addr);
-	}
-
-	return 0;
-}
-
-/**
- * ice_vf_rebuild_host_vlan_cfg - add VLAN 0 filter or rebuild the Port VLAN
- * @vf: VF to add MAC filters for
- * @vsi: Pointer to VSI
- *
- * Called after a VF VSI has been re-added/rebuilt during reset. The PF driver
- * always re-adds either a VLAN 0 or port VLAN based filter after reset.
- */
-static int ice_vf_rebuild_host_vlan_cfg(struct ice_vf *vf, struct ice_vsi *vsi)
-{
-	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
-	struct device *dev = ice_pf_to_dev(vf->pf);
-	int err;
-
-	if (ice_vf_is_port_vlan_ena(vf)) {
-		err = vlan_ops->set_port_vlan(vsi, &vf->port_vlan_info);
-		if (err) {
-			dev_err(dev, "failed to configure port VLAN via VSI parameters for VF %u, error %d\n",
-				vf->vf_id, err);
-			return err;
-		}
-
-		err = vlan_ops->add_vlan(vsi, &vf->port_vlan_info);
-	} else {
-		err = ice_vsi_add_vlan_zero(vsi);
-	}
-
-	if (err) {
-		dev_err(dev, "failed to add VLAN %u filter for VF %u during VF rebuild, error %d\n",
-			ice_vf_is_port_vlan_ena(vf) ?
-			ice_vf_get_port_vlan_id(vf) : 0, vf->vf_id, err);
-		return err;
-	}
-
-	err = vlan_ops->ena_rx_filtering(vsi);
-	if (err)
-		dev_warn(dev, "failed to enable Rx VLAN filtering for VF %d VSI %d during VF rebuild, error %d\n",
-			 vf->vf_id, vsi->idx, err);
-
-	return 0;
-}
-
-/**
- * ice_vf_rebuild_host_tx_rate_cfg - re-apply the Tx rate limiting configuration
- * @vf: VF to re-apply the configuration for
- *
- * Called after a VF VSI has been re-added/rebuild during reset. The PF driver
- * needs to re-apply the host configured Tx rate limiting configuration.
- */
-static int ice_vf_rebuild_host_tx_rate_cfg(struct ice_vf *vf)
-{
-	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
-	int err;
-
-	if (WARN_ON(!vsi))
-		return -EINVAL;
-
-	if (vf->min_tx_rate) {
-		err = ice_set_min_bw_limit(vsi, (u64)vf->min_tx_rate * 1000);
-		if (err) {
-			dev_err(dev, "failed to set min Tx rate to %d Mbps for VF %u, error %d\n",
-				vf->min_tx_rate, vf->vf_id, err);
-			return err;
-		}
-	}
-
-	if (vf->max_tx_rate) {
-		err = ice_set_max_bw_limit(vsi, (u64)vf->max_tx_rate * 1000);
-		if (err) {
-			dev_err(dev, "failed to set max Tx rate to %d Mbps for VF %u, error %d\n",
-				vf->max_tx_rate, vf->vf_id, err);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * ice_vf_rebuild_aggregator_node_cfg - rebuild aggregator node config
- * @vsi: Pointer to VSI
- *
- * This function moves VSI into corresponding scheduler aggregator node
- * based on cached value of "aggregator node info" per VSI
- */
-static void ice_vf_rebuild_aggregator_node_cfg(struct ice_vsi *vsi)
-{
-	struct ice_pf *pf = vsi->back;
-	struct device *dev;
-	int status;
-
-	if (!vsi->agg_node)
-		return;
-
-	dev = ice_pf_to_dev(pf);
-	if (vsi->agg_node->num_vsis == ICE_MAX_VSIS_IN_AGG_NODE) {
-		dev_dbg(dev,
-			"agg_id %u already has reached max_num_vsis %u\n",
-			vsi->agg_node->agg_id, vsi->agg_node->num_vsis);
-		return;
-	}
-
-	status = ice_move_vsi_to_agg(pf->hw.port_info, vsi->agg_node->agg_id,
-				     vsi->idx, vsi->tc_cfg.ena_tc);
-	if (status)
-		dev_dbg(dev, "unable to move VSI idx %u into aggregator %u node",
-			vsi->idx, vsi->agg_node->agg_id);
-	else
-		vsi->agg_node->num_vsis++;
-}
-
-/**
- * ice_vf_rebuild_host_cfg - host admin configuration is persistent across reset
- * @vf: VF to rebuild host configuration on
- */
-void ice_vf_rebuild_host_cfg(struct ice_vf *vf)
-{
-	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
-
-	if (WARN_ON(!vsi))
-		return;
-
-	ice_vf_set_host_trust_cfg(vf);
-
-	if (ice_vf_rebuild_host_mac_cfg(vf))
-		dev_err(dev, "failed to rebuild default MAC configuration for VF %d\n",
-			vf->vf_id);
-
-	if (ice_vf_rebuild_host_vlan_cfg(vf, vsi))
-		dev_err(dev, "failed to rebuild VLAN configuration for VF %u\n",
-			vf->vf_id);
-
-	if (ice_vf_rebuild_host_tx_rate_cfg(vf))
-		dev_err(dev, "failed to rebuild Tx rate limiting configuration for VF %u\n",
-			vf->vf_id);
-
-	if (ice_vsi_apply_spoofchk(vsi, vf->spoofchk))
-		dev_err(dev, "failed to rebuild spoofchk configuration for VF %d\n",
-			vf->vf_id);
-
-	/* rebuild aggregator node config for main VF VSI */
-	ice_vf_rebuild_aggregator_node_cfg(vsi);
-}
-
 /**
  * ice_vf_ctrl_invalidate_vsi - invalidate ctrl_vsi_idx to remove VSI access
  * @vf: VF that control VSI is being invalidated on
@@ -1310,23 +1327,6 @@ void ice_vf_vsi_release(struct ice_vf *vf)
 	ice_vf_invalidate_vsi(vf);
 }
 
-/**
- * ice_vf_set_initialized - VF is ready for VIRTCHNL communication
- * @vf: VF to set in initialized state
- *
- * After this function the VF will be ready to receive/handle the
- * VIRTCHNL_OP_GET_VF_RESOURCES message
- */
-void ice_vf_set_initialized(struct ice_vf *vf)
-{
-	ice_set_vf_state_qs_dis(vf);
-	clear_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states);
-	clear_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states);
-	clear_bit(ICE_VF_STATE_DIS, vf->vf_states);
-	set_bit(ICE_VF_STATE_INIT, vf->vf_states);
-	memset(&vf->vlan_v2_caps, 0, sizeof(vf->vlan_v2_caps));
-}
-
 /**
  * ice_get_vf_ctrl_vsi - Get first VF control VSI pointer
  * @pf: the PF private structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 6f3293b793b5..0c7e77c0a09f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -32,13 +32,11 @@ int ice_vsi_apply_spoofchk(struct ice_vsi *vsi, bool enable);
 bool ice_is_vf_trusted(struct ice_vf *vf);
 bool ice_vf_has_no_qs_ena(struct ice_vf *vf);
 bool ice_is_vf_link_up(struct ice_vf *vf);
-void ice_vf_rebuild_host_cfg(struct ice_vf *vf);
 void ice_vf_ctrl_invalidate_vsi(struct ice_vf *vf);
 void ice_vf_ctrl_vsi_release(struct ice_vf *vf);
 struct ice_vsi *ice_vf_ctrl_vsi_setup(struct ice_vf *vf);
 int ice_vf_init_host_cfg(struct ice_vf *vf, struct ice_vsi *vsi);
 void ice_vf_invalidate_vsi(struct ice_vf *vf);
 void ice_vf_vsi_release(struct ice_vf *vf);
-void ice_vf_set_initialized(struct ice_vf *vf);
 
 #endif /* _ICE_VF_LIB_PRIVATE_H_ */
-- 
2.38.1


