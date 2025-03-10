Return-Path: <netdev+bounces-173480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D75A59275
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C3418891CD
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D82288E3;
	Mon, 10 Mar 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YK5oa4eT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7B227E83
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605263; cv=none; b=p2UrR83twQsIv8NWG5+g3/hLzp7AF2cxfsc+T4LmzPUAUXZ4cPzJ0Neod5RBDE0375lG7AcTOAvNUsLMHlRmh+hcROnaN0JwfPtV2TGASYe4NVf4eXAbc6iQ2cCHeAwAv3JOjS1k/GjFLHGgosoFhhQDE1guxbsWofxRPwnBSas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605263; c=relaxed/simple;
	bh=GZ+JUsAiVyt07WlPEbHrRaQCAVxc7PoDWQmI2X4G6yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlhcxR3EbqKSdNUPr5hZpd0qH7nNPB8tN+hVWfASDuj1224xZWZ26EfPYxmgYz143qlvpL2S0dGHqItpN6DrYRJ8FWtSmRuhZ0uJwjFtWeTQ6G4h7P8tkBQrwktAa0x2qNyAr7c99Bsf83/Xf5NDAb2NdnOnVCREh3XuOm0h8bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YK5oa4eT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605262; x=1773141262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZ+JUsAiVyt07WlPEbHrRaQCAVxc7PoDWQmI2X4G6yw=;
  b=YK5oa4eT61bn3lijTV5wI+MdqfXjGAJwm8Oi+jYsF3hgGeL3SxJYIIlm
   xOvOTeO19vYbyPALJ02RimDGoS+pm9oboIWkYZBJKghCK1CdGMoOE3rRr
   fJ4qCK2QQmiKUuOz41VE55uvm0DT0BwVqjqOkWalQKmKrUki0I2WM2OUs
   51DV2yR3knetXXPvRcbos2WPop0ZYpDxd6MaOMF9EUxc2h5OP/Nhh/GRT
   P4crU698N7FwFGRbOZ+OAFgYyrCYSIdZS+2jUu/IqxTaESnKyAwTwdiEC
   C88Diretq1GZP7bR1YcB/rBKSvyWu9PlG4S2qhaHJuzkv3PrW5En+pU5c
   Q==;
X-CSE-ConnectionGUID: lkQ79Uf3QCG/MosZoLGzqg==
X-CSE-MsgGUID: 3K9waem6Qmmxm+x4zOMVGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048683"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:21 -0700
X-CSE-ConnectionGUID: 1M86oyLbR+q0GRWd+Em5Zg==
X-CSE-MsgGUID: YFAT1UjkRoK8e3aJAdlpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968320"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:19 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena-olech@intel.com>
Subject: [PATCH iwl-next 05/10] ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
Date: Mon, 10 Mar 2025 12:12:49 +0100
Message-ID: <20250310111357.1238454-17-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310111357.1238454-12-karol.kolacinski@intel.com>
References: <20250310111357.1238454-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ICE_READ_CGU_REG_OR_DIE() and ICE_WRITE_CGU_REG_OR_DIE() helpers to
avoid multiple error checks after calling read/write functions.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena-olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h |  15 ++
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 167 ++++----------------
 2 files changed, 49 insertions(+), 133 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index fee5b373af8c..f7952ff3e798 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -478,5 +478,20 @@ int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle);
 int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
 int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val);
+#define ICE_READ_CGU_REG_OR_DIE(hw, addr, val)                     \
+	do {                                                       \
+		int __err = ice_read_cgu_reg((hw), (addr), (val)); \
+								   \
+		if (__err)                                         \
+			return __err;                              \
+	} while (0)
 int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val);
+#define ICE_WRITE_CGU_REG_OR_DIE(hw, addr, val)                     \
+	do {                                                        \
+		int __err = ice_write_cgu_reg((hw), (addr), (val)); \
+								    \
+		if (__err)                                          \
+			return __err;                               \
+	} while (0)
+
 #endif /* _ICE_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 4c929fca510e..7a785b19ae28 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -129,7 +129,6 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
-	int err;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
 		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
@@ -149,17 +148,9 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
-	if (err)
-		return err;
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
 
 	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
 			  dw9.time_ref_freq_sel, bwm_lf.plllock_true_lock_cri,
@@ -168,69 +159,40 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw24.ts_pll_enable) {
 		dw24.ts_pll_enable = 0;
-
-		err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
-		if (err)
-			return err;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
 	}
 
 	/* Set the frequency */
 	dw9.time_ref_freq_sel = clk_freq;
-	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
 
 	/* Configure the TSPLL feedback divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &dw19.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &dw19.val);
 	dw19.fbdiv_intgr = e82x_tspll_params[clk_freq].feedback_div;
 	dw19.ndivratio = 1;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, dw19.val);
 
 	/* Configure the TSPLL post divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &dw22.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &dw22.val);
 	dw22.time1588clk_div = e82x_tspll_params[clk_freq].post_pll_div;
 	dw22.time1588clk_sel_div2 = 0;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R22, dw22.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, dw22.val);
 
 	/* Configure the TSPLL pre divisor and clock source */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
 	dw24.ref1588_ck_div = e82x_tspll_params[clk_freq].refclk_pre_div;
 	dw24.fbdiv_frac = e82x_tspll_params[clk_freq].frac_n_div;
 	dw24.time_ref_sel = clk_src;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
 
 	/* Finally, enable the PLL */
 	dw24.ts_pll_enable = 1;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
 	if (!bwm_lf.plllock_true_lock_cri) {
 		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
 		return -EBUSY;
@@ -254,12 +216,8 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
 {
 	union tspll_cntr_bist_settings cntr_bist;
-	int err;
-
-	err = ice_read_cgu_reg(hw, TSPLL_CNTR_BIST_SETTINGS, &cntr_bist.val);
-	if (err)
-		return err;
 
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_CNTR_BIST_SETTINGS, &cntr_bist.val);
 	/* Disable sticky lock detection so lock err reported is accurate */
 	cntr_bist.i_plllock_sel_0 = 0;
 	cntr_bist.i_plllock_sel_1 = 0;
@@ -292,7 +250,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
-	int err;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
 		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
@@ -311,25 +268,11 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, ICE_CGU_R16, &dw16.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
-	if (err)
-		return err;
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &dw9.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R24, &dw24.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R16, &dw16.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
 
 	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw23.time_ref_sel,
 			  dw9.time_ref_freq_sel,
@@ -338,10 +281,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw23.ts_pll_enable) {
 		dw23.ts_pll_enable = 0;
-
-		err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
-		if (err)
-			return err;
+		ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 	}
 
 	/* Set the frequency */
@@ -355,73 +295,42 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		dw9.time_ref_en = 1;
 		dw9.clk_eref0_en = 0;
 	}
-	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R9, dw9.val);
 
 	/* Choose the referenced frequency */
 	dw16.ck_refclkfreq = ICE_TSPLL_CK_REFCLKFREQ_E825;
-	err = ice_write_cgu_reg(hw, ICE_CGU_R16, dw16.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R16, dw16.val);
 
 	/* Configure the TSPLL feedback divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &dw19.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R19, &dw19.val);
 	dw19.fbdiv_intgr = ICE_TSPLL_FBDIV_INTGR_E825;
 	dw19.ndivratio = ICE_TSPLL_NDIVRATIO_E825;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R19, dw19.val);
 
 	/* Configure the TSPLL post divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &dw22.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R22, &dw22.val);
 	/* These two are constant for E825C */
 	dw22.time1588clk_div = 5;
 	dw22.time1588clk_sel_div2 = 0;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R22, dw22.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R22, dw22.val);
 
 	/* Configure the TSPLL pre divisor and clock source */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R23, &dw23.val);
 	dw23.ref1588_ck_div = 0;
 	dw23.time_ref_sel = clk_src;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 
 	dw24.fbdiv_frac = 0;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, dw24.val);
 
 	/* Finally, enable the PLL */
 	dw23.ts_pll_enable = 1;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
-	if (err)
-		return err;
+	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, dw23.val);
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
-	if (err)
-		return err;
-
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
 	if (!ro_lock.plllock_true_lock_cri) {
 		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
 		return -EBUSY;
@@ -445,14 +354,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
 {
 	union tspll_bw_tdc_e825c bw_tdc;
-	int err;
-
-	err = ice_read_cgu_reg(hw, TSPLL_BW_TDC_E825C, &bw_tdc.val);
-	if (err)
-		return err;
 
+	ICE_READ_CGU_REG_OR_DIE(hw, TSPLL_BW_TDC_E825C, &bw_tdc.val);
 	bw_tdc.i_plllock_sel_1_0 = 0;
-
 	return ice_write_cgu_reg(hw, TSPLL_BW_TDC_E825C, bw_tdc.val);
 }
 
@@ -468,15 +372,12 @@ static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 {
 	union ice_cgu_r9 r9;
-	int err;
 
-	err = ice_read_cgu_reg_e82x(hw, ICE_CGU_R9, &r9.val);
-	if (err)
-		return err;
+	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_R9, &r9.val);
 
 	r9.one_pps_out_en = enable;
 	r9.one_pps_out_amp = enable * ICE_ONE_PPS_OUT_AMP_MAX;
-	return ice_write_cgu_reg_e82x(hw, ICE_CGU_R9, r9.val);
+	return ice_write_cgu_reg(hw, ICE_CGU_R9, r9.val);
 }
 
 /**
-- 
2.48.1


