Return-Path: <netdev+bounces-47500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571547EA6B1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCE92820F1
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC03D983;
	Mon, 13 Nov 2023 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHOMk//O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D073D3A0
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:06:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D4D1B5
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916762; x=1731452762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qVqDwiu8cH8BOg6GKFfKu3/NNMxALbXwLSIbXE0K+WA=;
  b=cHOMk//Oiq5XfnfzNr7xeuUfsvRI8oBTqe/PFtEqSYEhzzyD2ueRg+/3
   Io/r4vAwNos7N/2LyWfSwW1UcXnwlJhkaqmh0Wr0O4DRRSJCWO7m/JTwq
   vUzl+vM72sJhGfN9DA1kCeBISsnkABRIwjaR3bf5m1w+aMdIcBdXt+4A5
   Oiw54JKL3W2cp2sYuLX/0Q2v9u/S4kxEgiJ1LujjQxPLIPBxPJsuIaKu3
   Ppy4MMQrHfg2520C/D3+27upWeIpItu2vVPmdUmhwbi0VrSRZD06D1jDf
   OOQXK9g+TGs9OBC59O6/dmgW/WNntaCH6ggvLPi6mn/bGsEz4oGn5L4TL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421633172"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421633172"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12598052"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 15:06:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Andrii Staikov <andrii.staikov@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 3/4] ice: dpll: fix output pin capabilities
Date: Mon, 13 Nov 2023 15:05:48 -0800
Message-ID: <20231113230551.548489-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
References: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The dpll output pins which are used to feed clock signal of PHY and MAC
circuits cannot be disconnected, those integrated circuits require clock
signal for operation.
By stopping assignment of DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE pin
capability, prevent the user from invoking the state set callback on
those pins, setting the state on those pins already returns error, as
firmware doesn't allow the change of their state.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Fixes: 8a3a565ff210 ("ice: add admin commands to access cgu configuration")
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c   | 12 +++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 54 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 831ba6683962..86b180cb32a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -1823,6 +1823,7 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	int num_pins, i, ret = -EINVAL;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_dpll_pin *pins;
+	unsigned long caps;
 	u8 freq_supp_num;
 	bool input;
 
@@ -1842,6 +1843,7 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	}
 
 	for (i = 0; i < num_pins; i++) {
+		caps = 0;
 		pins[i].idx = i;
 		pins[i].prop.board_label = ice_cgu_get_pin_name(hw, i, input);
 		pins[i].prop.type = ice_cgu_get_pin_type(hw, i, input);
@@ -1854,8 +1856,8 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 						      &dp->input_prio[i]);
 			if (ret)
 				return ret;
-			pins[i].prop.capabilities |=
-				DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE;
+			caps |= (DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
+				 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE);
 			pins[i].prop.phase_range.min =
 				pf->dplls.input_phase_adj_max;
 			pins[i].prop.phase_range.max =
@@ -1865,9 +1867,11 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 				pf->dplls.output_phase_adj_max;
 			pins[i].prop.phase_range.max =
 				-pf->dplls.output_phase_adj_max;
+			ret = ice_cgu_get_output_pin_state_caps(hw, i, &caps);
+			if (ret)
+				return ret;
 		}
-		pins[i].prop.capabilities |=
-			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		pins[i].prop.capabilities = caps;
 		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
 		if (ret)
 			return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 6d573908de7a..a00b55e14aac 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3961,3 +3961,57 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num)
 
 	return ret;
 }
+
+/**
+ * ice_cgu_get_output_pin_state_caps - get output pin state capabilities
+ * @hw: pointer to the hw struct
+ * @pin_id: id of a pin
+ * @caps: capabilities to modify
+ *
+ * Return:
+ * * 0 - success, state capabilities were modified
+ * * negative - failure, capabilities were not modified
+ */
+int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
+				      unsigned long *caps)
+{
+	bool can_change = true;
+
+	switch (hw->device_id) {
+	case ICE_DEV_ID_E810C_SFP:
+		if (pin_id == ZL_OUT2 || pin_id == ZL_OUT3)
+			can_change = false;
+		break;
+	case ICE_DEV_ID_E810C_QSFP:
+		if (pin_id == ZL_OUT2 || pin_id == ZL_OUT3 || pin_id == ZL_OUT4)
+			can_change = false;
+		break;
+	case ICE_DEV_ID_E823L_10G_BASE_T:
+	case ICE_DEV_ID_E823L_1GBE:
+	case ICE_DEV_ID_E823L_BACKPLANE:
+	case ICE_DEV_ID_E823L_QSFP:
+	case ICE_DEV_ID_E823L_SFP:
+	case ICE_DEV_ID_E823C_10G_BASE_T:
+	case ICE_DEV_ID_E823C_BACKPLANE:
+	case ICE_DEV_ID_E823C_QSFP:
+	case ICE_DEV_ID_E823C_SFP:
+	case ICE_DEV_ID_E823C_SGMII:
+		if (hw->cgu_part_number ==
+		    ICE_AQC_GET_LINK_TOPO_NODE_NR_ZL30632_80032 &&
+		    pin_id == ZL_OUT2)
+			can_change = false;
+		else if (hw->cgu_part_number ==
+			 ICE_AQC_GET_LINK_TOPO_NODE_NR_SI5383_5384 &&
+			 pin_id == SI_OUT1)
+			can_change = false;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (can_change)
+		*caps |= DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+	else
+		*caps &= ~DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 36aeeef99ec0..cf76701566c7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -282,6 +282,8 @@ int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
 int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num);
 
 void ice_ptp_init_phy_model(struct ice_hw *hw);
+int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
+				      unsigned long *caps);
 
 #define PFTSYN_SEM_BYTES	4
 
-- 
2.41.0


