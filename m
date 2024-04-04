Return-Path: <netdev+bounces-84764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE7389844C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86287B258FA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B5762F7;
	Thu,  4 Apr 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxqRCIML"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBD77F11
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223330; cv=none; b=qCsqJrhg9xKTMTr9zHwoldcNduhynmssaFTpBMeM/H2CpMlAsKIrkrFhGu/hOqcmVRb5I/6a7AuOwXaY7H+Y9pGvpUh7U0uS2QIEsnbQrHSPMDDRyBJ3NLmOvGc8UB8hUcofiew8CJwJ6UiMvtYu6sj5jIWRywZ4S+jJytfaq2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223330; c=relaxed/simple;
	bh=TSggJXuPnKluEpGPJMYCs+cX/vGmbIBocb9n5bG+XjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1RxQ5x3cKPe8qg7WixVw/lkysB7Do9MWxWR7dsFScXg8X1Pe4u/RCr64dg+9aruI+VVSuS8wnKqlQnr7stuI6fA2WGiQ4emXTR2lsIa9LRLRubmg6zFLjlcQeKxxSkD2+nth/CGYk3WGZeOJi6WmyE1eO9y049vEXd3A8MG95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxqRCIML; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712223328; x=1743759328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSggJXuPnKluEpGPJMYCs+cX/vGmbIBocb9n5bG+XjI=;
  b=RxqRCIMLlKtPjb7D6biiMGMD3ZLEDgSDm9W4H1UugnE40K0HjjUZjCIC
   WFU+u0bSKM6tYa5xM8sMIdqpp0vSTFPgBnJ+vkmkYPG8al83TZPDnakSb
   AGH+gjrj2eTD2/cd40OlJ89wqZuBxVmYdZQ5NmH98DJj+8e6bcysprMdG
   KwxMzvPye3ylEfyUIA6aaKZE5aMdhelIx/6RsJaRBvKufKTLEQGkQtYGf
   9lTjwRTZaO93FUFK7WQWUnjPyQaT6PfiZeV+qTIABKvPI1XKVuvViT418
   7ALPjABkv95JgSzgigPyUjFESJIcq7OvqeOCeSk8xAEgttGfQreTIBWlo
   w==;
X-CSE-ConnectionGUID: wo4i7vvZRledOmS9+14dnA==
X-CSE-MsgGUID: eYueek42Qbe5AEI9bXXoUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="29966601"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="29966601"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:23:04 -0700
X-CSE-ConnectionGUID: bMSABYPTTYWOtIpdlDOdKQ==
X-CSE-MsgGUID: E8ocL4YLQe2QWrx/0GzD4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="56180768"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2024 02:23:01 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v5 iwl-next 08/12] ice: Change CGU regs struct to anonymous
Date: Thu,  4 Apr 2024 11:09:56 +0200
Message-ID: <20240404092238.26975-22-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404092238.26975-14-karol.kolacinski@intel.com>
References: <20240404092238.26975-14-karol.kolacinski@intel.com>
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
index 7e347ff16381..38510ca1679a 100644
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


