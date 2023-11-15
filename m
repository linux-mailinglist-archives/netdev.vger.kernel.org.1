Return-Path: <netdev+bounces-47785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29507EB634
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B7E281307
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917CD26ADD;
	Tue, 14 Nov 2023 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QglZpugB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21E3D3B4
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE58121
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985720; x=1731521720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SNV4RFUkpzkgePnMwMGZ6L7EaS2//wTXYJBxiZfvnaw=;
  b=QglZpugBsEVrBgBTcsaRmS0YDkebx38rBvsZ93LudagCTvqDu9g3uAhh
   pNlbnxaMUrCnkzFKw1Uvtb51VMcQvWU0uig2svO7mk4xI1Xf/Ww2lsS7H
   uRYSfpWa/ctfUG8Ne6WXM51eNgtS0sdluXDQh6An9j8ssA2SiM1/xA1F3
   VqIfmoeDFu5pwN/h8djVGbpVPeyC7rR8VvYrH9PMeHbq6glrELo+97kd5
   EV7DGDCyteyZ/sE2RGmac3LQN72pQ663iM71gWDHA6ZBs93gtbHC94+wj
   pE4U94guqW1gWyf1CpfNQw+ORbjAuabZ3n1d19Ebi/aj5JXjZDzr3gcpm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514441"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514441"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160924"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160924"
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
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 01/15] ice: rename switchdev to eswitch
Date: Tue, 14 Nov 2023 10:14:21 -0800
Message-ID: <20231114181449.1290117-2-anthony.l.nguyen@intel.com>
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

Eswitch is used as a prefix for related functions. Main structure
storing all data related to eswitch should also be named as eswitch
instead of ice_switchdev_info. Rename it.

Also rename switchdev to eswitch where the context is not about eswitch
mode.

::uplink_netdev was changed to netdev for simplicity. There is no other
netdev in function scope so it is obvious.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  6 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 63 ++++++++++---------
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 12 ++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  4 +-
 4 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 351e0d36df44..6c59ca86d959 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -522,7 +522,7 @@ enum ice_misc_thread_tasks {
 	ICE_MISC_THREAD_NBITS		/* must be last */
 };
 
-struct ice_switchdev_info {
+struct ice_eswitch {
 	struct ice_vsi *control_vsi;
 	struct ice_vsi *uplink_vsi;
 	struct ice_esw_br_offloads *br_offloads;
@@ -637,7 +637,7 @@ struct ice_pf {
 	struct ice_link_default_override_tlv link_dflt_override;
 	struct ice_lag *lag; /* Link Aggregation information */
 
-	struct ice_switchdev_info switchdev;
+	struct ice_eswitch eswitch;
 	struct ice_esw_br_port *br_port;
 
 #define ICE_INVALID_AGG_NODE_ID		0
@@ -846,7 +846,7 @@ static inline struct ice_vsi *ice_find_vsi(struct ice_pf *pf, u16 vsi_num)
  */
 static inline bool ice_is_switchdev_running(struct ice_pf *pf)
 {
-	return pf->switchdev.is_running;
+	return pf->eswitch.is_running;
 }
 
 #define ICE_FD_STAT_CTR_BLOCK_COUNT	256
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a655d499abfa..e7f1e53314d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -16,12 +16,12 @@
  * @vf: pointer to VF struct
  *
  * This function adds advanced rule that forwards packets with
- * VF's VSI index to the corresponding switchdev ctrl VSI queue.
+ * VF's VSI index to the corresponding eswitch ctrl VSI queue.
  */
 static int
 ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
 {
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	struct ice_adv_rule_info rule_info = { 0 };
 	struct ice_adv_lkup_elem *list;
 	struct ice_hw *hw = &pf->hw;
@@ -59,7 +59,7 @@ ice_eswitch_add_vf_sp_rule(struct ice_pf *pf, struct ice_vf *vf)
  * @vf: pointer to the VF struct
  *
  * Delete the advanced rule that was used to forward packets with the VF's VSI
- * index to the corresponding switchdev ctrl VSI queue.
+ * index to the corresponding eswitch ctrl VSI queue.
  */
 static void ice_eswitch_del_vf_sp_rule(struct ice_vf *vf)
 {
@@ -70,7 +70,7 @@ static void ice_eswitch_del_vf_sp_rule(struct ice_vf *vf)
 }
 
 /**
- * ice_eswitch_setup_env - configure switchdev HW filters
+ * ice_eswitch_setup_env - configure eswitch HW filters
  * @pf: pointer to PF struct
  *
  * This function adds HW filters configuration specific for switchdev
@@ -78,18 +78,18 @@ static void ice_eswitch_del_vf_sp_rule(struct ice_vf *vf)
  */
 static int ice_eswitch_setup_env(struct ice_pf *pf)
 {
-	struct ice_vsi *uplink_vsi = pf->switchdev.uplink_vsi;
-	struct net_device *uplink_netdev = uplink_vsi->netdev;
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
+	struct net_device *netdev = uplink_vsi->netdev;
 	struct ice_vsi_vlan_ops *vlan_ops;
 	bool rule_added = false;
 
 	ice_remove_vsi_fltr(&pf->hw, uplink_vsi->idx);
 
-	netif_addr_lock_bh(uplink_netdev);
-	__dev_uc_unsync(uplink_netdev, NULL);
-	__dev_mc_unsync(uplink_netdev, NULL);
-	netif_addr_unlock_bh(uplink_netdev);
+	netif_addr_lock_bh(netdev);
+	__dev_uc_unsync(netdev, NULL);
+	__dev_mc_unsync(netdev, NULL);
+	netif_addr_unlock_bh(netdev);
 
 	if (ice_vsi_add_vlan_zero(uplink_vsi))
 		goto err_def_rx;
@@ -132,10 +132,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 }
 
 /**
- * ice_eswitch_remap_rings_to_vectors - reconfigure rings of switchdev ctrl VSI
+ * ice_eswitch_remap_rings_to_vectors - reconfigure rings of eswitch ctrl VSI
  * @pf: pointer to PF struct
  *
- * In switchdev number of allocated Tx/Rx rings is equal.
+ * In eswitch number of allocated Tx/Rx rings is equal.
  *
  * This function fills q_vectors structures associated with representor and
  * move each ring pairs to port representor netdevs. Each port representor
@@ -144,7 +144,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
  */
 static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 {
-	struct ice_vsi *vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *vsi = pf->eswitch.control_vsi;
 	int q_id;
 
 	ice_for_each_txq(vsi, q_id) {
@@ -189,7 +189,7 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 /**
  * ice_eswitch_release_reprs - clear PR VSIs configuration
  * @pf: poiner to PF struct
- * @ctrl_vsi: pointer to switchdev control VSI
+ * @ctrl_vsi: pointer to eswitch control VSI
  */
 static void
 ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
@@ -223,7 +223,7 @@ ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
  */
 static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 {
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	int max_vsi_num = 0;
 	struct ice_vf *vf;
 	unsigned int bkt;
@@ -359,7 +359,7 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 }
 
 /**
- * ice_eswitch_set_target_vsi - set switchdev context in Tx context descriptor
+ * ice_eswitch_set_target_vsi - set eswitch context in Tx context descriptor
  * @skb: pointer to send buffer
  * @off: pointer to offload struct
  */
@@ -382,7 +382,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 }
 
 /**
- * ice_eswitch_release_env - clear switchdev HW filters
+ * ice_eswitch_release_env - clear eswitch HW filters
  * @pf: pointer to PF struct
  *
  * This function removes HW filters configuration specific for switchdev
@@ -390,8 +390,8 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
  */
 static void ice_eswitch_release_env(struct ice_pf *pf)
 {
-	struct ice_vsi *uplink_vsi = pf->switchdev.uplink_vsi;
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	struct ice_vsi_vlan_ops *vlan_ops;
 
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
@@ -407,7 +407,7 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 }
 
 /**
- * ice_eswitch_vsi_setup - configure switchdev control VSI
+ * ice_eswitch_vsi_setup - configure eswitch control VSI
  * @pf: pointer to PF structure
  * @pi: pointer to port_info structure
  */
@@ -486,12 +486,12 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 		return -EINVAL;
 	}
 
-	pf->switchdev.control_vsi = ice_eswitch_vsi_setup(pf, pf->hw.port_info);
-	if (!pf->switchdev.control_vsi)
+	pf->eswitch.control_vsi = ice_eswitch_vsi_setup(pf, pf->hw.port_info);
+	if (!pf->eswitch.control_vsi)
 		return -ENODEV;
 
-	ctrl_vsi = pf->switchdev.control_vsi;
-	pf->switchdev.uplink_vsi = uplink_vsi;
+	ctrl_vsi = pf->eswitch.control_vsi;
+	pf->eswitch.uplink_vsi = uplink_vsi;
 
 	if (ice_eswitch_setup_env(pf))
 		goto err_vsi;
@@ -526,12 +526,12 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 }
 
 /**
- * ice_eswitch_disable_switchdev - disable switchdev resources
+ * ice_eswitch_disable_switchdev - disable eswitch resources
  * @pf: pointer to PF structure
  */
 static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 {
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 
 	ice_eswitch_napi_disable(pf);
 	ice_eswitch_br_offloads_deinit(pf);
@@ -625,7 +625,7 @@ void ice_eswitch_release(struct ice_pf *pf)
 		return;
 
 	ice_eswitch_disable_switchdev(pf);
-	pf->switchdev.is_running = false;
+	pf->eswitch.is_running = false;
 }
 
 /**
@@ -636,14 +636,15 @@ int ice_eswitch_configure(struct ice_pf *pf)
 {
 	int status;
 
-	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_LEGACY || pf->switchdev.is_running)
+	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_LEGACY ||
+	    pf->eswitch.is_running)
 		return 0;
 
 	status = ice_eswitch_enable_switchdev(pf);
 	if (status)
 		return status;
 
-	pf->switchdev.is_running = true;
+	pf->eswitch.is_running = true;
 	return 0;
 }
 
@@ -693,7 +694,7 @@ void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf)
  */
 int ice_eswitch_rebuild(struct ice_pf *pf)
 {
-	struct ice_vsi *ctrl_vsi = pf->switchdev.control_vsi;
+	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
 	int status;
 
 	ice_eswitch_napi_disable(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 6ae0269bdf73..16bbcaca8fda 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -947,7 +947,7 @@ ice_eswitch_br_vf_repr_port_init(struct ice_esw_br *bridge,
 static int
 ice_eswitch_br_uplink_port_init(struct ice_esw_br *bridge, struct ice_pf *pf)
 {
-	struct ice_vsi *vsi = pf->switchdev.uplink_vsi;
+	struct ice_vsi *vsi = pf->eswitch.uplink_vsi;
 	struct ice_esw_br_port *br_port;
 	int err;
 
@@ -1185,7 +1185,7 @@ ice_eswitch_br_port_event(struct notifier_block *nb,
 static void
 ice_eswitch_br_offloads_dealloc(struct ice_pf *pf)
 {
-	struct ice_esw_br_offloads *br_offloads = pf->switchdev.br_offloads;
+	struct ice_esw_br_offloads *br_offloads = pf->eswitch.br_offloads;
 
 	ASSERT_RTNL();
 
@@ -1194,7 +1194,7 @@ ice_eswitch_br_offloads_dealloc(struct ice_pf *pf)
 
 	ice_eswitch_br_deinit(br_offloads, br_offloads->bridge);
 
-	pf->switchdev.br_offloads = NULL;
+	pf->eswitch.br_offloads = NULL;
 	kfree(br_offloads);
 }
 
@@ -1205,14 +1205,14 @@ ice_eswitch_br_offloads_alloc(struct ice_pf *pf)
 
 	ASSERT_RTNL();
 
-	if (pf->switchdev.br_offloads)
+	if (pf->eswitch.br_offloads)
 		return ERR_PTR(-EEXIST);
 
 	br_offloads = kzalloc(sizeof(*br_offloads), GFP_KERNEL);
 	if (!br_offloads)
 		return ERR_PTR(-ENOMEM);
 
-	pf->switchdev.br_offloads = br_offloads;
+	pf->eswitch.br_offloads = br_offloads;
 	br_offloads->pf = pf;
 
 	return br_offloads;
@@ -1223,7 +1223,7 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
 {
 	struct ice_esw_br_offloads *br_offloads;
 
-	br_offloads = pf->switchdev.br_offloads;
+	br_offloads = pf->eswitch.br_offloads;
 	if (!br_offloads)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index dd03cb69ad26..08d3bbf4b44c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -653,7 +653,7 @@ static int ice_tc_setup_redirect_action(struct net_device *filter_dev,
 		   ice_tc_is_dev_uplink(target_dev)) {
 		repr = ice_netdev_to_repr(filter_dev);
 
-		fltr->dest_vsi = repr->src_vsi->back->switchdev.uplink_vsi;
+		fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;
 		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
 	} else if (ice_tc_is_dev_uplink(filter_dev) &&
 		   ice_is_port_repr_netdev(target_dev)) {
@@ -765,7 +765,7 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		rule_info.sw_act.src = hw->pf_id;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
 	} else if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
-		   fltr->dest_vsi == vsi->back->switchdev.uplink_vsi) {
+		   fltr->dest_vsi == vsi->back->eswitch.uplink_vsi) {
 		/* VF to Uplink */
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
-- 
2.41.0


