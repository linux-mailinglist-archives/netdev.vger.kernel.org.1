Return-Path: <netdev+bounces-43826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309657D4EE8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97A4281994
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60259266AB;
	Tue, 24 Oct 2023 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsQqXVUT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34884262BF
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:34:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0812D7B
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147296; x=1729683296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8Uxdqm7LCe9w0pzTpg2S+dVJ+WoFhyJhxi4rgKgiew=;
  b=WsQqXVUTgP6+At1fSGo/wHqeYI6qexu8nRUBHdY5a0zuJCmzt86ZCU02
   6mch5GPnIsxYUFlD/wFhs3nrVbHH/IWkCT3Fv4Bi8i7gZqJcFDKaeN+2i
   w+NprL90u0TMI4c7eQJyTHOdWUiWXtK/t5928//RGuXIkLlgT5EtVJs91
   uYyo84qhXz6Wn88lZoZDl1OOU0orCGjL0y/WHBtGjbgLqL2BlL7ZtROKw
   hKgVQYVI2BoNd/XmcDT4ee/tuIuiBj6naOVzL5SZF36LpqVrjQJuayWX7
   bwh5iGjKQCCQdzpJ5o/3tBsZCqqE7X2M4e5NIEXVcSJmIh48rvzLoxisR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660546"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660546"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146087"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:37 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 07/15] ice: remove VF pointer reference in eswitch code
Date: Tue, 24 Oct 2023 13:09:21 +0200
Message-ID: <20231024110929.19423-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make eswitch code generic by removing VF pointer reference in functions.
It is needed to support eswitch mode for other type of devices.

Previously queue id used for Rx was based on VF number. Use ::q_id saved
in port representor instead.

After adding or removing port representor ::q_id value can change. It
isn't good idea to iterate over representors list using this value.
Use xa_find starting from the first one instead to get next port
representor to remap.

The number of port representors has to be equal to ::num_rx/tx_q. Warn if
it isn't true.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 39 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  5 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c    |  1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a6b528bc2023..66cbe2c80fea 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -47,7 +47,8 @@ ice_eswitch_add_sp_rule(struct ice_pf *pf, struct ice_repr *repr)
 	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info,
 			       &repr->sp_rule);
 	if (err)
-		dev_err(ice_pf_to_dev(pf), "Unable to add slow-path rule in switchdev mode");
+		dev_err(ice_pf_to_dev(pf), "Unable to add slow-path rule for eswitch for PR %d",
+			repr->id);
 
 	kfree(list);
 	return err;
@@ -142,6 +143,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 {
 	struct ice_vsi *vsi = pf->eswitch.control_vsi;
+	unsigned long repr_id = 0;
 	int q_id;
 
 	ice_for_each_txq(vsi, q_id) {
@@ -149,13 +151,14 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 		struct ice_tx_ring *tx_ring;
 		struct ice_rx_ring *rx_ring;
 		struct ice_repr *repr;
-		struct ice_vf *vf;
 
-		vf = ice_get_vf_by_id(pf, q_id);
-		if (WARN_ON(!vf))
-			continue;
+		repr = xa_find(&pf->eswitch.reprs, &repr_id, U32_MAX,
+			       XA_PRESENT);
+		if (WARN_ON(!repr))
+			break;
 
-		repr = vf->repr;
+		repr_id += 1;
+		repr->q_id = q_id;
 		q_vector = repr->q_vector;
 		tx_ring = vsi->tx_rings[q_id];
 		rx_ring = vsi->rx_rings[q_id];
@@ -178,8 +181,6 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 		rx_ring->q_vector = q_vector;
 		rx_ring->next = NULL;
 		rx_ring->netdev = repr->netdev;
-
-		ice_put_vf(vf);
 	}
 }
 
@@ -284,20 +285,17 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 
 /**
  * ice_eswitch_update_repr - reconfigure port representor
- * @vsi: VF VSI for which port representor is configured
+ * @repr: pointer to repr struct
+ * @vsi: VSI for which port representor is configured
  */
-void ice_eswitch_update_repr(struct ice_vsi *vsi)
+void ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
-	struct ice_repr *repr;
-	struct ice_vf *vf;
 	int ret;
 
 	if (!ice_is_switchdev_running(pf))
 		return;
 
-	vf = vsi->vf;
-	repr = vf->repr;
 	repr->src_vsi = vsi;
 	repr->dst->u.port_info.port_id = vsi->vsi_num;
 
@@ -306,9 +304,10 @@ void ice_eswitch_update_repr(struct ice_vsi *vsi)
 
 	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
 	if (ret) {
-		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr, ICE_FWD_TO_VSI);
-		dev_err(ice_pf_to_dev(pf), "Failed to update VF %d port representor",
-			vsi->vf->vf_id);
+		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
+					       ICE_FWD_TO_VSI);
+		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
+			repr->id);
 	}
 }
 
@@ -340,7 +339,7 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	skb_dst_drop(skb);
 	dst_hold((struct dst_entry *)repr->dst);
 	skb_dst_set(skb, (struct dst_entry *)repr->dst);
-	skb->queue_mapping = repr->vf->vf_id;
+	skb->queue_mapping = repr->q_id;
 
 	return ice_start_xmit(skb, netdev);
 }
@@ -486,7 +485,7 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	ice_eswitch_remap_rings_to_vectors(pf);
 
 	if (ice_vsi_open(ctrl_vsi))
-		goto err_setup_reprs;
+		goto err_vsi_open;
 
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
@@ -497,6 +496,8 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 
 err_br_offloads:
 	ice_vsi_close(ctrl_vsi);
+err_vsi_open:
+	ice_eswitch_release_reprs(pf);
 err_setup_reprs:
 	ice_repr_rem_from_all_vfs(pf);
 err_repr_add:
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index b18bf83a2f5b..f43db1cce3ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -17,7 +17,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack);
 bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
 
-void ice_eswitch_update_repr(struct ice_vsi *vsi);
+void ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi);
 
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf);
 
@@ -34,7 +34,8 @@ static inline void
 ice_eswitch_set_target_vsi(struct sk_buff *skb,
 			   struct ice_tx_offload_params *off) { }
 
-static inline void ice_eswitch_update_repr(struct ice_vsi *vsi) { }
+static inline void
+ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index e56c59a304ef..77cc77ab826a 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -336,6 +336,7 @@ static int ice_repr_add(struct ice_vf *vf)
 	if (err)
 		goto err_netdev;
 
+	ether_addr_copy(repr->parent_mac, vf->hw_lan_addr);
 	ice_virtchnl_set_repr_ops(vf);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index aca1f2ea5034..462ee9fdf815 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -928,7 +928,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		goto out_unlock;
 	}
 
-	ice_eswitch_update_repr(vsi);
+	ice_eswitch_update_repr(vf->repr, vsi);
 
 	/* if the VF has been reset allow it to come up again */
 	ice_mbx_clear_malvf(&vf->mbx_info);
-- 
2.41.0


