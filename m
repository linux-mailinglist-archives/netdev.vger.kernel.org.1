Return-Path: <netdev+bounces-146417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323A9D34E2
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B5B26CDA
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12816CD1D;
	Wed, 20 Nov 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cz3UMYCc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D2169AE4
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089361; cv=none; b=DdpbiQriWQ7ENW4EuefF2kPFfG08hoHn0wQG1et2aJBc0G4dH6ETPyk0B225wFAIQOoj+F+fGD6vIKRNOF4Myclt/vfEDE7/ZYLgeOl1nPJJG3m2xtBbHu7E/fD/pnkB6ihas2efOL6wYQdjY9t/TUfVIi9mMl37pNOKzVUI/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089361; c=relaxed/simple;
	bh=ymgRt1r8OSosi9epgbbUpFLxfOaNFCyEGnN/25izfP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D62Ya4mU0scDIZqXp0OKq537ojyjsRRO2xkKkEwRo/fvOrV8U2FDUb6JGn9uwSAiR9DlnCuDUn8/B4uzhke6y2nMmRA7m5z0iqqlkOWvERVaRTKBRShxs+sOT0a7jcFCCNMoakB5bIHDMtymdnVZR0ZX3Jwyigg1gX3HxvlK0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cz3UMYCc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732089360; x=1763625360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ymgRt1r8OSosi9epgbbUpFLxfOaNFCyEGnN/25izfP0=;
  b=Cz3UMYCcikXA2eH7WqIPKUnT9UgJ9/I76HXW5vQf7g3ovDGcdLk2uu8+
   FmjNIWoUQ3BJTmzuyh3VhCBEZjSio8gYFlltafaFjKQoYxVxm3wYq0Dn6
   oLGXFiX4PN8mbZDy624qs6fgpwAFve1Y15oKygydj2WuawaiYFgL4G4Gq
   yJDe1H34SptAIYh2cufIG5TD/t6gWl7TGYK1QUivde6wYiQFP14N6ekaj
   obyO5ftwZ/fD2s7HEvFpRUD+ARSIIzm0I0eO5waF7iUdF2agCVbG3AG1m
   N8XqSJ44g3qN1tOsbW/WuuRzc6MZ0ARp+zXAyJR5L2ymqReak4pk5dKJL
   A==;
X-CSE-ConnectionGUID: HVGrM6jqT4+0EVnadExrgg==
X-CSE-MsgGUID: pG5ydbywRjCVNDSJHbq28g==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32381947"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="32381947"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 23:55:58 -0800
X-CSE-ConnectionGUID: eEAgKmNRQNi3xKI2j+nOJg==
X-CSE-MsgGUID: mF/peicRQhSY8tRkTvZLGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89984155"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa008.fm.intel.com with ESMTP; 19 Nov 2024 23:55:57 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix max values for dpll pin phase adjust
Date: Wed, 20 Nov 2024 08:51:12 +0100
Message-Id: <20241120075112.1662138-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  2 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 35 ++++++++++++-------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 547c96b9c1d5..80f3dfd27124 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2239,6 +2239,8 @@ struct ice_aqc_get_pkg_info_resp {
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

base-commit: a76d2631397d9331132688105313d8e3da8f4010
-- 
2.38.1


