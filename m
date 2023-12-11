Return-Path: <netdev+bounces-55884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A76380CB0C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CBD280C2D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5CE3E49C;
	Mon, 11 Dec 2023 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4t8cXih"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BE99A;
	Mon, 11 Dec 2023 05:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702301424; x=1733837424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3d0ZqW0s9NY7VE8U/j6KTSmrdZ+E7YFFIPmXG9j0Wks=;
  b=R4t8cXihOV3DFJq3QqXgr2axdIdkprHB4wkNr0AT5t16oxKsNnh7v8vI
   /QRsBFpu+PPOln0b1UIHz4L8a9VDjm5UcqxN5Nv9FhJmekkepPJX6kO2s
   G1wIM10YQHJKXbU74J0w5j633heXR8I0hF4w/CpB/SN33NjWjJ5RuaqdC
   252Db675opQm5NohBENPPw2JmRh8JYCd3Fvq2zpU8oJkSDHF/27OJZ3WL
   jCIYJe+dFWD15cjmEryWT2rFiO1y9lqOV/xJg8Phbz2yGXNqmU2jParc0
   Kn0VGnVxQbkzB770s+KUt07CvpD3D/Qy2869F+IQvT+y1/2QXmnREh754
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="8009216"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="8009216"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:30:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776674844"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="776674844"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2023 05:30:21 -0800
From: Andrii Staikov <andrii.staikov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Marcin Szycik <marcin.szycik@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next  v5] ice: Add support for packet mirroring using hardware in switchdev mode
Date: Mon, 11 Dec 2023 14:30:17 +0100
Message-Id: <20231211133017.815891-1-andrii.staikov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switchdev mode allows to add mirroring rules to mirror incoming and
outgoing packets to the interface's port representor. Previously, this was
available only using software functionality. Add possibility to offload
this functionality to the NIC hardware.

Introduce ICE_MIRROR_PACKET filter action to the ice_sw_fwd_act_type enum
to identify the desired action and pass it to the hardware as well as the
VSI to mirror.

Example of tc mirror command using hardware:
  tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower src_mac
  b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth1

ens1f0np0 - PF
b4:96:91:a5:c7:a7 - source MAC address
eth1 - PR of a VF to mirror to

Co-developed-by: Marcin Szycik <marcin.szycik@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
---
v1 -> v2: no need for changes in ice_add_tc_flower_adv_fltr()
v2 -> v3: add another if branch for netif_is_ice(act->dev) || 
ice_is_tunnel_supported(act->dev) for FLOW_ACTION_MIRRED action and 
add direction rules for filters
v3 -> v4: move setting mirroring into dedicated function
ice_tc_setup_mirror_action()
v4 -> v5: Fix packets not mirroring from VF to VF by changing
ICE_ESWITCH_FLTR_INGRESS to ICE_ESWITCH_FLTR_EGRESS where needed
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++----
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 41 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index ee19f3aa3d19..4af1ce2657ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6065,6 +6065,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_QGRP ||
 	      rinfo->sw_act.fltr_act == ICE_DROP_PACKET ||
+	      rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
 	      rinfo->sw_act.fltr_act == ICE_NOP)) {
 		status = -EIO;
 		goto free_pkt_profile;
@@ -6077,9 +6078,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	}
 
 	if (rinfo->sw_act.fltr_act == ICE_FWD_TO_VSI ||
-	    rinfo->sw_act.fltr_act == ICE_NOP)
+	    rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
+	    rinfo->sw_act.fltr_act == ICE_NOP) {
 		rinfo->sw_act.fwd_id.hw_vsi_id =
 			ice_get_hw_vsi_num(hw, vsi_handle);
+	}
 
 	if (rinfo->src_vsi)
 		rinfo->sw_act.src = ice_get_hw_vsi_num(hw, rinfo->src_vsi);
@@ -6115,12 +6118,15 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		status = -ENOMEM;
 		goto free_pkt_profile;
 	}
-	if (!rinfo->flags_info.act_valid) {
-		act |= ICE_SINGLE_ACT_LAN_ENABLE;
-		act |= ICE_SINGLE_ACT_LB_ENABLE;
-	} else {
-		act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
-						ICE_SINGLE_ACT_LB_ENABLE);
+
+	if (rinfo->sw_act.fltr_act != ICE_MIRROR_PACKET) {
+		if (!rinfo->flags_info.act_valid) {
+			act |= ICE_SINGLE_ACT_LAN_ENABLE;
+			act |= ICE_SINGLE_ACT_LB_ENABLE;
+		} else {
+			act |= rinfo->flags_info.act & (ICE_SINGLE_ACT_LAN_ENABLE |
+							ICE_SINGLE_ACT_LB_ENABLE);
+		}
 	}
 
 	switch (rinfo->sw_act.fltr_act) {
@@ -6147,6 +6153,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
 		       ICE_SINGLE_ACT_VALID_BIT;
 		break;
+	case ICE_MIRROR_PACKET:
+		act |= ICE_SINGLE_ACT_OTHER_ACTS;
+		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
+				  rinfo->sw_act.fwd_id.hw_vsi_id);
+		break;
 	case ICE_NOP:
 		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
 				  rinfo->sw_act.fwd_id.hw_vsi_id);
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 08d3bbf4b44c..b890410a2bc0 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -689,6 +689,41 @@ ice_tc_setup_drop_action(struct net_device *filter_dev,
 	return 0;
 }
 
+static int ice_tc_setup_mirror_action(struct net_device *filter_dev,
+				      struct ice_tc_flower_fltr *fltr,
+				      struct net_device *target_dev)
+{
+	struct ice_repr *repr;
+
+	fltr->action.fltr_act = ICE_MIRROR_PACKET;
+
+	if (ice_is_port_repr_netdev(filter_dev) &&
+	    ice_is_port_repr_netdev(target_dev)) {
+		repr = ice_netdev_to_repr(target_dev);
+
+		fltr->dest_vsi = repr->src_vsi;
+		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
+	} else if (ice_is_port_repr_netdev(filter_dev) &&
+		   ice_tc_is_dev_uplink(target_dev)) {
+		repr = ice_netdev_to_repr(filter_dev);
+
+		fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;
+		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
+	} else if (ice_tc_is_dev_uplink(filter_dev) &&
+		   ice_is_port_repr_netdev(target_dev)) {
+		repr = ice_netdev_to_repr(target_dev);
+
+		fltr->dest_vsi = repr->src_vsi;
+		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
+	} else {
+		NL_SET_ERR_MSG_MOD(fltr->extack,
+				   "Unsupported netdevice in switchdev mode");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 				       struct ice_tc_flower_fltr *fltr,
 				       struct flow_action_entry *act)
@@ -710,6 +745,12 @@ static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
 
 		break;
 
+	case FLOW_ACTION_MIRRED:
+		err = ice_tc_setup_mirror_action(filter_dev, fltr, act->dev);
+		if (err)
+			return err;
+		break;
+
 	default:
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in switchdev mode");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 5a80158e49ed..20c014e9b6c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1055,6 +1055,7 @@ enum ice_sw_fwd_act_type {
 	ICE_FWD_TO_Q,
 	ICE_FWD_TO_QGRP,
 	ICE_DROP_PACKET,
+	ICE_MIRROR_PACKET,
 	ICE_NOP,
 	ICE_INVAL_ACT
 };
-- 
2.25.1


