Return-Path: <netdev+bounces-156007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C7A049CC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 20:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FE4166A40
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5381F471C;
	Tue,  7 Jan 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHsD3vMd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DE49652
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276524; cv=none; b=gDCj/SwouBjpMDV1ldIxkltNN7hlxFap3mxiuOR5R1sCSAZnFJK0G/lkFbaIznI8AXLiA9kQOCbL5bi1m13MhoIgQHa682le39sm7NtLtEcAzZ72X9tF87PSqi2t18oaZeKtRkue34+bN1P3cgOE/LnMihPZKCxEXChKKQRcOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276524; c=relaxed/simple;
	bh=gLJjfDJhgjGiRzBD6sMmBWL5HV3eZ3ZJC2albBVhRYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqE1kpOsuapj0PN5TXjPkthn1LA4d1/MxNJo+jKf7ZXsvzCUlsAM5SJTR8AEw+Xa/OCjqf+4f0skyp+IDFb1fIPUvloZtOUSmicAk3QqzLPRnwwMURSZyemgKdmPu8zG4NQUZ/8xgVPNXv1Zt60OpXgTPljFR0d/Q2RvhRPo8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHsD3vMd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736276521; x=1767812521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gLJjfDJhgjGiRzBD6sMmBWL5HV3eZ3ZJC2albBVhRYg=;
  b=oHsD3vMd7wjKbbwC9pzaJzxjjP8M3hWwDEqh+xwgVvOSuXK3/b5u6GPq
   oNfly3igfaf+Emct+8Xn/3CL0ZB0txXbFdy4TZSB6CroPFFKEEJc1Pk2X
   xUpbBOYFlhKuLhEuA3TNb8e8h8DdBLNEsYyfT69z3gLgqAMNFdffwGfUJ
   YTg60NfQJ4u8B8tJmn+/Ys2BWvcUtMx0ssWOmo3nO1ElUsNmiAHMp56yc
   LdrRu1l68TodPAldn/5d+0dmfyUQpN05n764XgawMtR0NM8Rf4lp3AARk
   /bTFm/yNtuQz4lckQ37KKeZjwHZsRFU4ej8xYVlVvZ5h8/yPk+ATcECrf
   Q==;
X-CSE-ConnectionGUID: RvE/PYUdQLuUudhN40dTUg==
X-CSE-MsgGUID: rKIo8pevR3Wiulxxlfs3jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="24083634"
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="24083634"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 11:02:00 -0800
X-CSE-ConnectionGUID: OgR/z+5+QEWHLN7P0TC/7A==
X-CSE-MsgGUID: 4ziZ1456Q/i4iBOOubyd+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,296,1728975600"; 
   d="scan'208";a="133709285"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2025 11:02:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net 1/3] ice: fix max values for dpll pin phase adjust
Date: Tue,  7 Jan 2025 11:01:45 -0800
Message-ID: <20250107190150.1758577-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
References: <20250107190150.1758577-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Mask admin command returned max phase adjust value for both input and
output pins. Only 31 bits are relevant, last released data sheet wrongly
points that 32 bits are valid - see [1] 3.2.6.4.1 Get CCU Capabilities
Command for reference. Fix of the datasheet itself is in progress.

Fix the min/max assignment logic, previously the value was wrongly
considered as negative value due to most significant bit being set.

Example of previous broken behavior:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-get --json '{"id":1}'| grep phase-adjust
 'phase-adjust': 0,
 'phase-adjust-max': 16723,
 'phase-adjust-min': -16723,

Correct behavior with the fix:
$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml \
--do pin-get --json '{"id":1}'| grep phase-adjust
 'phase-adjust': 0,
 'phase-adjust-max': 2147466925,
 'phase-adjust-min': -2147466925,

[1] https://cdrdv2.intel.com/v1/dl/getContent/613875?explicitVersion=true

Fixes: 90e1c90750d7 ("ice: dpll: implement phase related callbacks")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 35 ++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1489a8ceec51..ef14cff9a333 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2264,6 +2264,8 @@ struct ice_aqc_get_pkg_info_resp {
 	struct ice_aqc_get_pkg_info pkg_info[];
 };
 
+#define ICE_AQC_GET_CGU_MAX_PHASE_ADJ	GENMASK(30, 0)
+
 /* Get CGU abilities command response data structure (indirect 0x0C61) */
 struct ice_aqc_get_cgu_abilities {
 	u8 num_inputs;
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index d5ad6d84007c..38e151c7ea23 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2064,6 +2064,18 @@ static int ice_dpll_init_worker(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_dpll_phase_range_set - initialize phase adjust range helper
+ * @range: pointer to phase adjust range struct to be initialized
+ * @phase_adj: a value to be used as min(-)/max(+) boundary
+ */
+static void ice_dpll_phase_range_set(struct dpll_pin_phase_adjust_range *range,
+				     u32 phase_adj)
+{
+	range->min = -phase_adj;
+	range->max = phase_adj;
+}
+
 /**
  * ice_dpll_init_info_pins_generic - initializes generic pins info
  * @pf: board private structure
@@ -2105,8 +2117,8 @@ static int ice_dpll_init_info_pins_generic(struct ice_pf *pf, bool input)
 	for (i = 0; i < pin_num; i++) {
 		pins[i].idx = i;
 		pins[i].prop.board_label = labels[i];
-		pins[i].prop.phase_range.min = phase_adj_max;
-		pins[i].prop.phase_range.max = -phase_adj_max;
+		ice_dpll_phase_range_set(&pins[i].prop.phase_range,
+					 phase_adj_max);
 		pins[i].prop.capabilities = cap;
 		pins[i].pf = pf;
 		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
@@ -2152,6 +2164,7 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	struct ice_hw *hw = &pf->hw;
 	struct ice_dpll_pin *pins;
 	unsigned long caps;
+	u32 phase_adj_max;
 	u8 freq_supp_num;
 	bool input;
 
@@ -2159,11 +2172,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 	case ICE_DPLL_PIN_TYPE_INPUT:
 		pins = pf->dplls.inputs;
 		num_pins = pf->dplls.num_inputs;
+		phase_adj_max = pf->dplls.input_phase_adj_max;
 		input = true;
 		break;
 	case ICE_DPLL_PIN_TYPE_OUTPUT:
 		pins = pf->dplls.outputs;
 		num_pins = pf->dplls.num_outputs;
+		phase_adj_max = pf->dplls.output_phase_adj_max;
 		input = false;
 		break;
 	default:
@@ -2188,19 +2203,13 @@ ice_dpll_init_info_direct_pins(struct ice_pf *pf,
 				return ret;
 			caps |= (DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 				 DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE);
-			pins[i].prop.phase_range.min =
-				pf->dplls.input_phase_adj_max;
-			pins[i].prop.phase_range.max =
-				-pf->dplls.input_phase_adj_max;
 		} else {
-			pins[i].prop.phase_range.min =
-				pf->dplls.output_phase_adj_max;
-			pins[i].prop.phase_range.max =
-				-pf->dplls.output_phase_adj_max;
 			ret = ice_cgu_get_output_pin_state_caps(hw, i, &caps);
 			if (ret)
 				return ret;
 		}
+		ice_dpll_phase_range_set(&pins[i].prop.phase_range,
+					 phase_adj_max);
 		pins[i].prop.capabilities = caps;
 		ret = ice_dpll_pin_state_update(pf, &pins[i], pin_type, NULL);
 		if (ret)
@@ -2308,8 +2317,10 @@ static int ice_dpll_init_info(struct ice_pf *pf, bool cgu)
 	dp->dpll_idx = abilities.pps_dpll_idx;
 	d->num_inputs = abilities.num_inputs;
 	d->num_outputs = abilities.num_outputs;
-	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj);
-	d->output_phase_adj_max = le32_to_cpu(abilities.max_out_phase_adj);
+	d->input_phase_adj_max = le32_to_cpu(abilities.max_in_phase_adj) &
+		ICE_AQC_GET_CGU_MAX_PHASE_ADJ;
+	d->output_phase_adj_max = le32_to_cpu(abilities.max_out_phase_adj) &
+		ICE_AQC_GET_CGU_MAX_PHASE_ADJ;
 
 	alloc_size = sizeof(*d->inputs) * d->num_inputs;
 	d->inputs = kzalloc(alloc_size, GFP_KERNEL);
-- 
2.47.1


