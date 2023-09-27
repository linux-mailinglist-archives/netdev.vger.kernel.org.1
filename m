Return-Path: <netdev+bounces-36514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D67B0218
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9B75B1C2089C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902F14288;
	Wed, 27 Sep 2023 10:43:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21286AA4
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:43:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7229139
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695811407; x=1727347407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dw23sqyuUWOc7PdWJTvKQS/VTXp5Khnn+koeSLqD4l4=;
  b=W/cayy26e0YE71XEwTC37Hlea6OZZiVaYRz9cCYbhYhFFSbktVkLvCA4
   H2/SblUlDsRMDjb5Ftl3FpdJSkNT68Eg9DMhtli8A6iwgn5RGsBKkfgCE
   0tbkRrAvUK0ZEQlqodjI935Vbj4KzwPuss9mL04cpGu+cKITqXQXmwQFH
   wY1KwEp46E821G+h8DRIihBZdHMRx0rcse/OU2dwcmDMGBB53tpiP/hHJ
   WXswXBu0/mMrZ3+EWx703kekhZYa1ujHDFAQB5dWw/85EAUC43CHhvdqR
   jY8ZqJgD4VWJZW78J9tXWHwoo0lYuYDtnfGAH7cacSnggzmWPTuRJUfla
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412704676"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412704676"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 03:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="922729569"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="922729569"
Received: from unknown (HELO fedora.iind.intel.com) ([10.138.157.125])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2023 03:43:24 -0700
From: Aniruddha Paul <aniruddha.paul@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: marcin.szycik@intel.com,
	netdev@vger.kernel.org,
	Aniruddha Paul <aniruddha.paul@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-next,v1] ice: Fix VF-VF filter rules in switchdev mode
Date: Wed, 27 Sep 2023 16:12:53 +0530
Message-Id: <20230927104253.1729049-1-aniruddha.paul@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
2.40.1


