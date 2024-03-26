Return-Path: <netdev+bounces-82176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7C88C911
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7518F1F64EC3
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9613CABB;
	Tue, 26 Mar 2024 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW8TsFfc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE1C13CA9F
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470260; cv=none; b=u++eOAPtS9NMgl1gEWjLp3IPqNh8QZo/jjazB7B0XfV0Tb4+/RDaqYV6Tu5z00c10L2QLuuEjfG/yo2Jyb51aDlnN5xYA9VzqaXWH4xl8aoBsCKX+i97zFTZCRLzR0OqGGPMZxpkPLGtXbYHgqkDJuxK3y0JpHgbFVBj64yXHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470260; c=relaxed/simple;
	bh=rezNxpxRVkHIThRxy4KO/mLVpc8HQy9QSfOEpWI7KBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRjJFzdUBG/9tuyCS8nckrRHrRiq7xJ7z20wBDThGn14PiBzoP2ICPsLq1nWJA+gWn8e/S8xCimnlMc55uAVNxKl+OBEQXvfnIMo4VcwRjrfV4UQVBRJ79gZp6yzjki9SmS6cgBpfMGZRGSXAcTA1dxs5yF9iKecjXnSrszgky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW8TsFfc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470259; x=1743006259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rezNxpxRVkHIThRxy4KO/mLVpc8HQy9QSfOEpWI7KBg=;
  b=MW8TsFfcMnh9G3dYzVmulp6LKQV/ReD/+VZ9nB0kPnMjELh3GVtgimzz
   XvQlvZV0Zyh2lJ5F9HQXmMm2o1Sm7Va/6ZA2FCscaEICr3kPcEgGXHJZS
   2TAIyxIK79cKYmNpKgfUixE22yPT4nK4z6KvzRFp7NxLuKyF1ISAx3X0L
   6IZpsUxlw52VpWNPMqR0/IfDbYlgmIe19415zusarqvgxeJlhXqPOyykE
   jllPu3MavpXdCM0ipYU13GuT1ex7/VgQHlAf4jP7tkBHKmKGbAAwXAHie
   /Ok62v/jmHSEhbp+W1XyKOUhse6L0Yl0X2sFq5srJgJgRw+IJdPzm44YQ
   A==;
X-CSE-ConnectionGUID: GwW0RMEcRlKHafAgkL109A==
X-CSE-MsgGUID: SYMn4FyzRA+uhpYzTaPOWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6725043"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6725043"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20729293"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 09:24:17 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next 08/12] ice: Change CGU regs struct to anonymous
Date: Tue, 26 Mar 2024 17:22:29 +0100
Message-ID: <20240326162339.146053-22-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162339.146053-14-karol.kolacinski@intel.com>
References: <20240326162339.146053-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the code by using anonymous struct in CGU registers instead of
naming each structure 'field'.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h | 12 ++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 44 +++++++++----------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_cgu_regs.h b/drivers/net/ethernet/intel/ice/ice_cgu_regs.h
index 57abd52386d0..36aeb10eefb7 100644
--- a/drivers/net/ethernet/intel/ice/ice_cgu_regs.h
+++ b/drivers/net/ethernet/intel/ice/ice_cgu_regs.h
@@ -23,7 +23,7 @@ union nac_cgu_dword9 {
 		u32 clk_synce0_amp : 2;
 		u32 one_pps_out_amp : 2;
 		u32 misc24 : 12;
-	} field;
+	};
 	u32 val;
 };
 
@@ -39,7 +39,7 @@ union nac_cgu_dword19 {
 		u32 japll_ndivratio : 4;
 		u32 japll_iref_ndivratio : 3;
 		u32 misc27 : 1;
-	} field;
+	};
 	u32 val;
 };
 
@@ -63,7 +63,7 @@ union nac_cgu_dword22 {
 		u32 fdpllclk_sel_div2 : 1;
 		u32 time1588clk_sel_div2 : 1;
 		u32 misc3 : 1;
-	} field;
+	};
 	u32 val;
 };
 
@@ -77,7 +77,7 @@ union nac_cgu_dword24 {
 		u32 ext_synce_sel : 1;
 		u32 ref1588_ck_div : 4;
 		u32 time_ref_sel : 1;
-	} field;
+	};
 	u32 val;
 };
 
@@ -92,7 +92,7 @@ union tspll_cntr_bist_settings {
 		u32 i_plllock_cnt_6_0 : 7;
 		u32 i_plllock_cnt_10_7 : 4;
 		u32 reserved200 : 4;
-	} field;
+	};
 	u32 val;
 };
 
@@ -109,7 +109,7 @@ union tspll_ro_bwm_lf {
 		u32 afcdone_cri : 1;
 		u32 feedfwrdgain_cal_cri_7_0 : 8;
 		u32 m2fbdivmod_cri_7_0 : 8;
-	} field;
+	};
 	u32 val;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 1ff3103d03c3..aaa888fe55d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -385,14 +385,14 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
-		  ice_clk_src_str(dw24.field.time_ref_sel),
-		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
-		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
+		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  ice_clk_src_str(dw24.time_ref_sel),
+		  ice_clk_freq_str(dw9.time_ref_freq_sel),
+		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
 
 	/* Disable the PLL before changing the clock source or frequency */
-	if (dw24.field.ts_pll_enable) {
-		dw24.field.ts_pll_enable = 0;
+	if (dw24.ts_pll_enable) {
+		dw24.ts_pll_enable = 0;
 
 		err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
 		if (err)
@@ -400,7 +400,7 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 	}
 
 	/* Set the frequency */
-	dw9.field.time_ref_freq_sel = clk_freq;
+	dw9.time_ref_freq_sel = clk_freq;
 	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
 	if (err)
 		return err;
@@ -410,8 +410,8 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 	if (err)
 		return err;
 
-	dw19.field.tspll_fbdiv_intgr = e822_cgu_params[clk_freq].feedback_div;
-	dw19.field.tspll_ndivratio = 1;
+	dw19.tspll_fbdiv_intgr = e822_cgu_params[clk_freq].feedback_div;
+	dw19.tspll_ndivratio = 1;
 
 	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD19, dw19.val);
 	if (err)
@@ -422,8 +422,8 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 	if (err)
 		return err;
 
-	dw22.field.time1588clk_div = e822_cgu_params[clk_freq].post_pll_div;
-	dw22.field.time1588clk_sel_div2 = 0;
+	dw22.time1588clk_div = e822_cgu_params[clk_freq].post_pll_div;
+	dw22.time1588clk_sel_div2 = 0;
 
 	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD22, dw22.val);
 	if (err)
@@ -434,16 +434,16 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 	if (err)
 		return err;
 
-	dw24.field.ref1588_ck_div = e822_cgu_params[clk_freq].refclk_pre_div;
-	dw24.field.tspll_fbdiv_frac = e822_cgu_params[clk_freq].frac_n_div;
-	dw24.field.time_ref_sel = clk_src;
+	dw24.ref1588_ck_div = e822_cgu_params[clk_freq].refclk_pre_div;
+	dw24.tspll_fbdiv_frac = e822_cgu_params[clk_freq].frac_n_div;
+	dw24.time_ref_sel = clk_src;
 
 	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
 	if (err)
 		return err;
 
 	/* Finally, enable the PLL */
-	dw24.field.ts_pll_enable = 1;
+	dw24.ts_pll_enable = 1;
 
 	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
 	if (err)
@@ -456,17 +456,17 @@ static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
 	if (err)
 		return err;
 
-	if (!bwm_lf.field.plllock_true_lock_cri) {
+	if (!bwm_lf.plllock_true_lock_cri) {
 		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
 		return -EBUSY;
 	}
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
-		  ice_clk_src_str(dw24.field.time_ref_sel),
-		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
-		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
+		  dw24.ts_pll_enable ? "enabled" : "disabled",
+		  ice_clk_src_str(dw24.time_ref_sel),
+		  ice_clk_freq_str(dw9.time_ref_freq_sel),
+		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
 
 	return 0;
 }
@@ -489,8 +489,8 @@ static int ice_init_cgu_e82x(struct ice_hw *hw)
 		return err;
 
 	/* Disable sticky lock detection so lock err reported is accurate */
-	cntr_bist.field.i_plllock_sel_0 = 0;
-	cntr_bist.field.i_plllock_sel_1 = 0;
+	cntr_bist.i_plllock_sel_0 = 0;
+	cntr_bist.i_plllock_sel_1 = 0;
 
 	err = ice_write_cgu_reg_e82x(hw, TSPLL_CNTR_BIST_SETTINGS,
 				     cntr_bist.val);
-- 
2.43.0


