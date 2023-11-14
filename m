Return-Path: <netdev+bounces-47789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0487EB638
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA551C20B03
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76EED2E8;
	Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwaRgUPd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586626AC8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B0131
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985722; x=1731521722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpVWuQINGP8i5dSuQdASDjHp0Aj5A6/ZCvok7Vs6dCM=;
  b=TwaRgUPdmRBRxPQq24imr8G3brC9c42AieDYsZ6he+fy2Cde86r0EX2R
   Qcn6XoyV8EFEO+L3wvZPMapVAgRahzyzYv1J3EEzFcrMbrInbaonvM6xi
   cAPAFbRang+yJyIKwxm1azn9wSY1Ho4EzFqJ4/uZ+17a4A5IAnpVQXFov
   C8J1dvpxrsq+KUNU5Cs5G21ZOaS/8WRtSFQeNh5IsCvRHupYQvPOv7B5w
   HVB1CSTrloeZKsmu9zZqq2LsVbHLa4Ivieg8BpqZREGA0Fl1CAfg45NvW
   wvJWJWChhVLnyPASm2UIXyqVSOwO0IBVROaXTn3Ne52DQvMFHZb+LR6UQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514483"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514483"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160943"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160943"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 06/15] ice: track port representors in xarray
Date: Tue, 14 Nov 2023 10:14:26 -0800
Message-ID: <20231114181449.1290117-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Instead of assuming that each VF has pointer to port representor save it
in xarray. It will allow adding port representor for other device types.

Drop reference to VF where it is use only to get port representor. Get
it from xarray instead.

The functions will no longer by specific for VF, rename them.

Track id assigned by xarray in port representor structure. The id can't
be used as ::q_id, because it is fixed during port representor lifetime.
::q_id can change after adding / removing other port representors.

Side effect of removing VF pointer is that we are losing VF MAC
information used in unrolling. Store it in port representor as parent
MAC.

Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 182 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_main.c    |   2 +
 drivers/net/ethernet/intel/ice/ice_repr.c    |   8 +
 drivers/net/ethernet/intel/ice/ice_repr.h    |   2 +
 5 files changed, 94 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6c59ca86d959..597bdb6945c6 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -526,6 +526,7 @@ struct ice_eswitch {
 	struct ice_vsi *control_vsi;
 	struct ice_vsi *uplink_vsi;
 	struct ice_esw_br_offloads *br_offloads;
+	struct xarray reprs;
 	bool is_running;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 119185564450..a6b528bc2023 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -11,15 +11,15 @@
 #include "ice_tc_lib.h"
 
 /**
- * ice_eswitch_add_vf_sp_rule - add adv rule with VF's VSI index
+ * ice_eswitch_add_sp_rule - add adv rule with device's VSI index
  * @pf: pointer to PF struct
- * @vf: pointer to VF struct
+ * @repr: pointer to the repr struct
  *
  * This function adds advanced rule that forwards packets with
- * VF's VSI index to the corresponding eswitch ctrl VSI queue.
+ * device's VSI index to the corresponding eswitch ctrl VSI queue.
  */
 static int
-ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
+ice_eswitch_add_sp_rule(struct ice_pf *pf, struct ice_repr *repr)
 {
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	struct ice_adv_rule_info rule_info = { 0 };
@@ -38,35 +38,32 @@ ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
 	rule_info.sw_act.vsi_handle = ctrl_vsi->idx;
 	rule_info.sw_act.fltr_act = ICE_FWD_TO_Q;
 	rule_info.sw_act.fwd_id.q_id = hw->func_caps.common_cap.rxq_first_id +
-				       ctrl_vsi->rxq_map[vf->repr->q_id];
+				       ctrl_vsi->rxq_map[repr->q_id];
 	rule_info.flags_info.act |= ICE_SINGLE_ACT_LB_ENABLE;
 	rule_info.flags_info.act_valid = true;
 	rule_info.tun_type = ICE_SW_TUN_AND_NON_TUN;
-	rule_info.src_vsi = vf->lan_vsi_idx;
+	rule_info.src_vsi = repr->src_vsi->idx;
 
 	err = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info,
-			       &vf->repr->sp_rule);
+			       &repr->sp_rule);
 	if (err)
-		dev_err(ice_pf_to_dev(pf), "Unable to add VF slow-path rule in switchdev mode for VF %d",
-			vf->vf_id);
+		dev_err(ice_pf_to_dev(pf), "Unable to add slow-path rule in switchdev mode");
 
 	kfree(list);
 	return err;
 }
 
 /**
- * ice_eswitch_del_vf_sp_rule - delete adv rule with VF's VSI index
- * @vf: pointer to the VF struct
+ * ice_eswitch_del_sp_rule - delete adv rule with device's VSI index
+ * @pf: pointer to the PF struct
+ * @repr: pointer to the repr struct
  *
- * Delete the advanced rule that was used to forward packets with the VF's VSI
- * index to the corresponding eswitch ctrl VSI queue.
+ * Delete the advanced rule that was used to forward packets with the device's
+ * VSI index to the corresponding eswitch ctrl VSI queue.
  */
-static void ice_eswitch_del_vf_sp_rule(struct ice_vf *vf)
+static void ice_eswitch_del_sp_rule(struct ice_pf *pf, struct ice_repr *repr)
 {
-	if (!vf->repr)
-		return;
-
-	ice_rem_adv_rule_by_id(&vf->pf->hw, &vf->repr->sp_rule);
+	ice_rem_adv_rule_by_id(&pf->hw, &repr->sp_rule);
 }
 
 /**
@@ -193,26 +190,24 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 static void
 ice_eswitch_release_reprs(struct ice_pf *pf)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
-	ice_for_each_vf(pf, bkt, vf) {
-		struct ice_vsi *vsi = vf->repr->src_vsi;
+	xa_for_each(&pf->eswitch.reprs, id, repr) {
+		struct ice_vsi *vsi = repr->src_vsi;
 
-		/* Skip VFs that aren't configured */
-		if (!vf->repr->dst)
+		/* Skip representors that aren't configured */
+		if (!repr->dst)
 			continue;
 
 		ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
-		metadata_dst_free(vf->repr->dst);
-		vf->repr->dst = NULL;
-		ice_eswitch_del_vf_sp_rule(vf);
-		ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
+		metadata_dst_free(repr->dst);
+		repr->dst = NULL;
+		ice_eswitch_del_sp_rule(pf, repr);
+		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 					       ICE_FWD_TO_VSI);
 
-		netif_napi_del(&vf->repr->q_vector->napi);
+		netif_napi_del(&repr->q_vector->napi);
 	}
 }
 
@@ -223,56 +218,53 @@ ice_eswitch_release_reprs(struct ice_pf *pf)
 static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 {
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
-	ice_for_each_vf(pf, bkt, vf) {
-		struct ice_vsi *vsi = vf->repr->src_vsi;
+	xa_for_each(&pf->eswitch.reprs, id, repr) {
+		struct ice_vsi *vsi = repr->src_vsi;
 
 		ice_remove_vsi_fltr(&pf->hw, vsi->idx);
-		vf->repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
-						   GFP_KERNEL);
-		if (!vf->repr->dst) {
-			ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
+		repr->dst = metadata_dst_alloc(0, METADATA_HW_PORT_MUX,
+					       GFP_KERNEL);
+		if (!repr->dst) {
+			ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 						       ICE_FWD_TO_VSI);
 			goto err;
 		}
 
-		if (ice_eswitch_add_vf_sp_rule(pf, vf)) {
-			ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
+		if (ice_eswitch_add_sp_rule(pf, repr)) {
+			ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 						       ICE_FWD_TO_VSI);
 			goto err;
 		}
 
 		if (ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof)) {
-			ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
+			ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 						       ICE_FWD_TO_VSI);
-			ice_eswitch_del_vf_sp_rule(vf);
-			metadata_dst_free(vf->repr->dst);
-			vf->repr->dst = NULL;
+			ice_eswitch_del_sp_rule(pf, repr);
+			metadata_dst_free(repr->dst);
+			repr->dst = NULL;
 			goto err;
 		}
 
 		if (ice_vsi_add_vlan_zero(vsi)) {
-			ice_fltr_add_mac_and_broadcast(vsi, vf->hw_lan_addr,
+			ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
 						       ICE_FWD_TO_VSI);
-			ice_eswitch_del_vf_sp_rule(vf);
-			metadata_dst_free(vf->repr->dst);
-			vf->repr->dst = NULL;
+			ice_eswitch_del_sp_rule(pf, repr);
+			metadata_dst_free(repr->dst);
+			repr->dst = NULL;
 			ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
 			goto err;
 		}
 
-		netif_napi_add(vf->repr->netdev, &vf->repr->q_vector->napi,
+		netif_napi_add(repr->netdev, &repr->q_vector->napi,
 			       ice_napi_poll);
 
-		netif_keep_dst(vf->repr->netdev);
+		netif_keep_dst(repr->netdev);
 	}
 
-	ice_for_each_vf(pf, bkt, vf) {
-		struct ice_repr *repr = vf->repr;
+	xa_for_each(&pf->eswitch.reprs, id, repr) {
 		struct ice_vsi *vsi = repr->src_vsi;
 		struct metadata_dst *dst;
 
@@ -291,7 +283,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 }
 
 /**
- * ice_eswitch_update_repr - reconfigure VF port representor
+ * ice_eswitch_update_repr - reconfigure port representor
  * @vsi: VF VSI for which port representor is configured
  */
 void ice_eswitch_update_repr(struct ice_vsi *vsi)
@@ -420,47 +412,41 @@ ice_eswitch_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi)
 
 /**
  * ice_eswitch_napi_del - remove NAPI handle for all port representors
- * @pf: pointer to PF structure
+ * @reprs: xarray of reprs
  */
-static void ice_eswitch_napi_del(struct ice_pf *pf)
+static void ice_eswitch_napi_del(struct xarray *reprs)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
-	ice_for_each_vf(pf, bkt, vf)
-		netif_napi_del(&vf->repr->q_vector->napi);
+	xa_for_each(reprs, id, repr)
+		netif_napi_del(&repr->q_vector->napi);
 }
 
 /**
  * ice_eswitch_napi_enable - enable NAPI for all port representors
- * @pf: pointer to PF structure
+ * @reprs: xarray of reprs
  */
-static void ice_eswitch_napi_enable(struct ice_pf *pf)
+static void ice_eswitch_napi_enable(struct xarray *reprs)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
-	ice_for_each_vf(pf, bkt, vf)
-		napi_enable(&vf->repr->q_vector->napi);
+	xa_for_each(reprs, id, repr)
+		napi_enable(&repr->q_vector->napi);
 }
 
 /**
  * ice_eswitch_napi_disable - disable NAPI for all port representors
- * @pf: pointer to PF structure
+ * @reprs: xarray of reprs
  */
-static void ice_eswitch_napi_disable(struct ice_pf *pf)
+static void ice_eswitch_napi_disable(struct xarray *reprs)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
-	ice_for_each_vf(pf, bkt, vf)
-		napi_disable(&vf->repr->q_vector->napi);
+	xa_for_each(reprs, id, repr)
+		napi_disable(&repr->q_vector->napi);
 }
 
 /**
@@ -505,7 +491,7 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 	if (ice_eswitch_br_offloads_init(pf))
 		goto err_br_offloads;
 
-	ice_eswitch_napi_enable(pf);
+	ice_eswitch_napi_enable(&pf->eswitch.reprs);
 
 	return 0;
 
@@ -528,7 +514,7 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 {
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 
-	ice_eswitch_napi_disable(pf);
+	ice_eswitch_napi_disable(&pf->eswitch.reprs);
 	ice_eswitch_br_offloads_deinit(pf);
 	ice_eswitch_release_env(pf);
 	ice_eswitch_release_reprs(pf);
@@ -561,6 +547,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	case DEVLINK_ESWITCH_MODE_LEGACY:
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy",
 			 pf->hw.pf_id);
+		xa_destroy(&pf->eswitch.reprs);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
 		break;
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
@@ -573,6 +560,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 
 		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
 			 pf->hw.pf_id);
+		xa_init_flags(&pf->eswitch.reprs, XA_FLAGS_ALLOC);
 		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
 		break;
 	}
@@ -649,18 +637,14 @@ int ice_eswitch_configure(struct ice_pf *pf)
  */
 static void ice_eswitch_start_all_tx_queues(struct ice_pf *pf)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
 	if (test_bit(ICE_DOWN, pf->state))
 		return;
 
-	ice_for_each_vf(pf, bkt, vf) {
-		if (vf->repr)
-			ice_repr_start_tx_queues(vf->repr);
-	}
+	xa_for_each(&pf->eswitch.reprs, id, repr)
+		ice_repr_start_tx_queues(repr);
 }
 
 /**
@@ -669,18 +653,14 @@ static void ice_eswitch_start_all_tx_queues(struct ice_pf *pf)
  */
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf)
 {
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
+	struct ice_repr *repr;
+	unsigned long id;
 
 	if (test_bit(ICE_DOWN, pf->state))
 		return;
 
-	ice_for_each_vf(pf, bkt, vf) {
-		if (vf->repr)
-			ice_repr_stop_tx_queues(vf->repr);
-	}
+	xa_for_each(&pf->eswitch.reprs, id, repr)
+		ice_repr_stop_tx_queues(repr);
 }
 
 /**
@@ -692,8 +672,8 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	int status;
 
-	ice_eswitch_napi_disable(pf);
-	ice_eswitch_napi_del(pf);
+	ice_eswitch_napi_disable(&pf->eswitch.reprs);
+	ice_eswitch_napi_del(&pf->eswitch.reprs);
 
 	status = ice_eswitch_setup_env(pf);
 	if (status)
@@ -711,7 +691,7 @@ int ice_eswitch_rebuild(struct ice_pf *pf)
 	if (status)
 		return status;
 
-	ice_eswitch_napi_enable(pf);
+	ice_eswitch_napi_enable(&pf->eswitch.reprs);
 	ice_eswitch_start_all_tx_queues(pf);
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6607fa6fe556..7ea6e2ad3272 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4702,6 +4702,8 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_ptp_release(pf);
 	if (test_bit(ICE_FLAG_DPLL, pf->flags))
 		ice_dpll_deinit(pf);
+	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
+		xa_destroy(&pf->eswitch.reprs);
 }
 
 static void ice_init_wakeup(struct ice_pf *pf)
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 903a3385eacb..e56c59a304ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -318,6 +318,11 @@ static int ice_repr_add(struct ice_vf *vf)
 	}
 	repr->q_vector = q_vector;
 
+	err = xa_alloc(&vf->pf->eswitch.reprs, &repr->id, repr,
+		       xa_limit_32b, GFP_KERNEL);
+	if (err)
+		goto err_xa_alloc;
+
 	err = ice_devlink_create_vf_port(vf);
 	if (err)
 		goto err_devlink;
@@ -338,6 +343,8 @@ static int ice_repr_add(struct ice_vf *vf)
 err_netdev:
 	ice_devlink_destroy_vf_port(vf);
 err_devlink:
+	xa_erase(&vf->pf->eswitch.reprs, repr->id);
+err_xa_alloc:
 	kfree(repr->q_vector);
 	vf->repr->q_vector = NULL;
 err_alloc_q_vector:
@@ -363,6 +370,7 @@ static void ice_repr_rem(struct ice_vf *vf)
 	kfree(repr->q_vector);
 	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(vf);
+	xa_erase(&vf->pf->eswitch.reprs, repr->id);
 	free_netdev(repr->netdev);
 	kfree(repr);
 	vf->repr = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index f350273b8874..735cb556c620 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -14,6 +14,8 @@ struct ice_repr {
 	struct metadata_dst *dst;
 	struct ice_esw_br_port *br_port;
 	int q_id;
+	u32 id;
+	u8 parent_mac[ETH_ALEN];
 #ifdef CONFIG_ICE_SWITCHDEV
 	/* info about slow path rule */
 	struct ice_rule_query_data sp_rule;
-- 
2.41.0


