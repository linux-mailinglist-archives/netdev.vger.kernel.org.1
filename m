Return-Path: <netdev+bounces-46308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04D7E3264
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92321B20BA3
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242D15A4;
	Tue,  7 Nov 2023 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpxC1oKZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99D17C2
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:48:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8DFD57
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 16:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699318131; x=1730854131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2PjTxwEfa4Hn3DppzTbRL9nPJtpnWea8ZFnwgpDZS6s=;
  b=WpxC1oKZrpnbIOqX/1cBTYf7cJn9z/id/CTu2WBNw27lz4PJPu3Wzemf
   yQT6PyvfsdyvjpurNVIbAEQPIKHQyBxqZSF0qQ7n9FhRpVjpBrI2qHSN6
   Gm9C3HlvrqKiUsZqLsUVuJHd49tVVVCIpZCS3FTy8yMLMPnkI+Pc6J6xI
   7aZuW1AWVUBpKEv2v1sxqsg28vxdMz9hcve0ojWU0auw+t0L040Arj8W/
   YVHJId+oxCDCA5BS2KMMLmDE03yt5Ztw2Nz7elW4F46VyXRyd9dnSjQvZ
   Nz4W+S6Sx69PFzYgAIeiBGoF+FqhcE47nPAx/WsMhAfZkSWqFjechG6rF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392270715"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392270715"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 16:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="762489661"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="762489661"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2023 16:48:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aniruddha Paul <aniruddha.paul@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 3/4] ice: Fix VF-VF filter rules in switchdev mode
Date: Mon,  6 Nov 2023 16:48:41 -0800
Message-ID: <20231107004844.655549-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
References: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aniruddha Paul <aniruddha.paul@intel.com>

Any packet leaving VSI i.e VF's VSI is considered as
egress traffic by HW, thus failing to match the added
rule.

Mark the direction for redirect rules as below:
1. VF-VF - Egress
2. Uplink-VF - Ingress
3. VF-Uplink - Egress
4. Link_Partner-Uplink - Ingress
5. Link_Partner-VF - Ingress

Fixes: 0960a27bd479 ("ice: Add direction metadata")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Aniruddha Paul <aniruddha.paul@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 90 ++++++++++++++-------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 37b54db91df2..0e75fc6b3c06 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -630,32 +630,61 @@ bool ice_is_tunnel_supported(struct net_device *dev)
 	return ice_tc_tun_get_type(dev) != TNL_LAST;
 }
 
-static int
-ice_eswitch_tc_parse_action(struct ice_tc_flower_fltr *fltr,
-			    struct flow_action_entry *act)
+static bool ice_tc_is_dev_uplink(struct net_device *dev)
+{
+	return netif_is_ice(dev) || ice_is_tunnel_supported(dev);
+}
+
+static int ice_tc_setup_redirect_action(struct net_device *filter_dev,
+					struct ice_tc_flower_fltr *fltr,
+					struct net_device *target_dev)
 {
 	struct ice_repr *repr;
 
+	fltr->action.fltr_act = ICE_FWD_TO_VSI;
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
+		fltr->dest_vsi = repr->src_vsi->back->switchdev.uplink_vsi;
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
+static int ice_eswitch_tc_parse_action(struct net_device *filter_dev,
+				       struct ice_tc_flower_fltr *fltr,
+				       struct flow_action_entry *act)
+{
+	int err;
+
 	switch (act->id) {
 	case FLOW_ACTION_DROP:
 		fltr->action.fltr_act = ICE_DROP_PACKET;
 		break;
 
 	case FLOW_ACTION_REDIRECT:
-		fltr->action.fltr_act = ICE_FWD_TO_VSI;
-
-		if (ice_is_port_repr_netdev(act->dev)) {
-			repr = ice_netdev_to_repr(act->dev);
-
-			fltr->dest_vsi = repr->src_vsi;
-			fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
-		} else if (netif_is_ice(act->dev) ||
-			   ice_is_tunnel_supported(act->dev)) {
-			fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
-		} else {
-			NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported netdevice in switchdev mode");
-			return -EINVAL;
-		}
+		err = ice_tc_setup_redirect_action(filter_dev, fltr, act->dev);
+		if (err)
+			return err;
 
 		break;
 
@@ -696,10 +725,6 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		goto exit;
 	}
 
-	/* egress traffic is always redirect to uplink */
-	if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
-		fltr->dest_vsi = vsi->back->switchdev.uplink_vsi;
-
 	rule_info.sw_act.fltr_act = fltr->action.fltr_act;
 	if (fltr->action.fltr_act != ICE_DROP_PACKET)
 		rule_info.sw_act.vsi_handle = fltr->dest_vsi->idx;
@@ -713,13 +738,21 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 	rule_info.flags_info.act_valid = true;
 
 	if (fltr->direction == ICE_ESWITCH_FLTR_INGRESS) {
+		/* Uplink to VF */
 		rule_info.sw_act.flag |= ICE_FLTR_RX;
 		rule_info.sw_act.src = hw->pf_id;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
-	} else {
+	} else if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
+		   fltr->dest_vsi == vsi->back->switchdev.uplink_vsi) {
+		/* VF to Uplink */
 		rule_info.sw_act.flag |= ICE_FLTR_TX;
 		rule_info.sw_act.src = vsi->idx;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
+	} else {
+		/* VF to VF */
+		rule_info.sw_act.flag |= ICE_FLTR_TX;
+		rule_info.sw_act.src = vsi->idx;
+		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
 	}
 
 	/* specify the cookie as filter_rule_id */
@@ -1745,16 +1778,17 @@ ice_tc_parse_action(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr,
 
 /**
  * ice_parse_tc_flower_actions - Parse the actions for a TC filter
+ * @filter_dev: Pointer to device on which filter is being added
  * @vsi: Pointer to VSI
  * @cls_flower: Pointer to TC flower offload structure
  * @fltr: Pointer to TC flower filter structure
  *
  * Parse the actions for a TC filter
  */
-static int
-ice_parse_tc_flower_actions(struct ice_vsi *vsi,
-			    struct flow_cls_offload *cls_flower,
-			    struct ice_tc_flower_fltr *fltr)
+static int ice_parse_tc_flower_actions(struct net_device *filter_dev,
+				       struct ice_vsi *vsi,
+				       struct flow_cls_offload *cls_flower,
+				       struct ice_tc_flower_fltr *fltr)
 {
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls_flower);
 	struct flow_action *flow_action = &rule->action;
@@ -1769,7 +1803,7 @@ ice_parse_tc_flower_actions(struct ice_vsi *vsi,
 
 	flow_action_for_each(i, act, flow_action) {
 		if (ice_is_eswitch_mode_switchdev(vsi->back))
-			err = ice_eswitch_tc_parse_action(fltr, act);
+			err = ice_eswitch_tc_parse_action(filter_dev, fltr, act);
 		else
 			err = ice_tc_parse_action(vsi, fltr, act);
 		if (err)
@@ -1856,7 +1890,7 @@ ice_add_tc_fltr(struct net_device *netdev, struct ice_vsi *vsi,
 	if (err < 0)
 		goto err;
 
-	err = ice_parse_tc_flower_actions(vsi, f, fltr);
+	err = ice_parse_tc_flower_actions(netdev, vsi, f, fltr);
 	if (err < 0)
 		goto err;
 
-- 
2.41.0


