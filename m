Return-Path: <netdev+bounces-33112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69579CBCA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65F791C20AB7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279F16428;
	Tue, 12 Sep 2023 09:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433514F84
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:30:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14553AA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694511026; x=1726047026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=az/P5VcS7y6RnLURzuxIdD/CGde1PcjrEtLTetl36xE=;
  b=cvIKWARDDHcxwuWVhPl3/bzTMF1EG3MAYCOqjwbWm08fgYxsN8PIwH27
   EvpMMYJGQrvAb6jLrvPlTWG3n/kItA7/aiqqsgsH5AT2DNcC9fhJU3jNd
   H1AevEUTGICa1CgSPj/judANbG7KQIk/Lc361+mJEQDU+oi4QSn/mJuzR
   vZrTIqNZ+7T/VVZsfMJ559LfMeHjV5W4x0draQy7W1Vsveba+tytpLSxT
   naj9Sllxvw2CNUgOcc+esoEhIGWDKncGUseU0vjR01j4fgDoNZb7JAGql
   qcEGghjfy8BJq8Sp1mo7mnbJ0C3sn3AXFQHRCGdDlHNn9o1tw5lL1snc5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375655200"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="375655200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="809170420"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="809170420"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2023 02:29:55 -0700
From: Andrii Staikov <andrii.staikov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>
Subject: [PATCH iwl-next  v2] ice: Add support for packet mirroring using hardware in switchdev mode
Date: Tue, 12 Sep 2023 11:29:52 +0200
Message-Id: <20230912092952.2814966-1-andrii.staikov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switchdev mode allows to add mirroring rules to mirror
incoming and outgoing packets to the interface's port
representor. Previously, this was available only using
software functionality. Add possibility to offload this
functionality to the NIC hardware.

Introduce ICE_MIRROR_PACKET filter action to the
ice_sw_fwd_act_type enum to identify the desired action
and pass it to the hardware as well as the VSI to mirror.

Example of tc mirror command using hardware:
tc filter add dev ens1f0np0 ingress protocol ip prio 1 flower
src_mac b4:96:91:a5:c7:a7 skip_sw action mirred egress mirror dev eth1

ens1f0np0 - PF
b4:96:91:a5:c7:a7 - source MAC address
eth1 - PR of a VF to mirror to

Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
---
v1 -> v2: no need for changes in ice_add_tc_flower_adv_fltr()
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 25 +++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 13 +++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2f77b684ff76..d915b72e8dbb 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -6100,6 +6100,7 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_Q ||
 	      rinfo->sw_act.fltr_act == ICE_FWD_TO_QGRP ||
 	      rinfo->sw_act.fltr_act == ICE_DROP_PACKET ||
+	      rinfo->sw_act.fltr_act == ICE_MIRROR_PACKET ||
 	      rinfo->sw_act.fltr_act == ICE_NOP)) {
 		status = -EIO;
 		goto free_pkt_profile;
@@ -6112,9 +6113,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
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
@@ -6150,12 +6153,15 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
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
@@ -6182,6 +6188,11 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		act |= ICE_SINGLE_ACT_VSI_FORWARDING | ICE_SINGLE_ACT_DROP |
 		       ICE_SINGLE_ACT_VALID_BIT;
 		break;
+	case ICE_MIRROR_PACKET:
+		act |= ICE_SINGLE_ACT_OTHER_ACTS;
+		act |= (rinfo->sw_act.fwd_id.hw_vsi_id << ICE_SINGLE_ACT_MIRROR_VSI_ID_S) &
+		       ICE_SINGLE_ACT_MIRROR_VSI_ID_M;
+		break;
 	case ICE_NOP:
 		act |= FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M,
 				  rinfo->sw_act.fwd_id.hw_vsi_id);
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 37b54db91df2..db34df1890f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -659,6 +659,19 @@ ice_eswitch_tc_parse_action(struct ice_tc_flower_fltr *fltr,
 
 		break;
 
+	case FLOW_ACTION_MIRRED:
+		fltr->action.fltr_act = ICE_MIRROR_PACKET;
+
+		if (ice_is_port_repr_netdev(act->dev)) {
+			repr = ice_netdev_to_repr(act->dev);
+
+			fltr->dest_vsi = repr->src_vsi;
+		} else {
+			NL_SET_ERR_MSG_MOD(fltr->extack, "Provided netdevice doesn't support mirroring");
+			return -EINVAL;
+		}
+		break;
+
 	default:
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in switchdev mode");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 02db9e5810e6..f5c35dc8766f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1047,6 +1047,7 @@ enum ice_sw_fwd_act_type {
 	ICE_FWD_TO_Q,
 	ICE_FWD_TO_QGRP,
 	ICE_DROP_PACKET,
+	ICE_MIRROR_PACKET,
 	ICE_NOP,
 	ICE_INVAL_ACT
 };
-- 
2.25.1


