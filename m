Return-Path: <netdev+bounces-201650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D834AEA37A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AD45641D6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3E2EB5A6;
	Thu, 26 Jun 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDI33rPv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55C213253
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750955374; cv=none; b=o4T0pgfZgWsywdJYjhaPT7aa6aqCeMdcUHMAE/Gq8gK1mCkRNK52OgpeggcIIPelgRfTvVtntb0/PaPB7TRm388prwOoM/SRrnfzzuZxtaHUe5XSbG0iDAAbm1e3AOH2wH0osTuJMJyp+ZF6KNPADVG5FfecRLGkGFtaPJHT8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750955374; c=relaxed/simple;
	bh=SnX3ro/jZGZ35dvVBfIi4VeA95krBsJ/dvSK3Bzt35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jzb4n69b0SDh8rRCsHX1pGx5UwgXyh5HbwHxLWxYvlKXnHrLzWic4OFVOkCVoS+YbXc/uwAoYYC8SJJTn0DNfYWs8shNidwBTG95nJBxlYkTMGLO0KGGULkhsj7H6XEhEutJ7iZa3wYpn3/MALR8QNWfkLHGYRbV/XtZt3vpfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDI33rPv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750955373; x=1782491373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SnX3ro/jZGZ35dvVBfIi4VeA95krBsJ/dvSK3Bzt35w=;
  b=kDI33rPvYPSYl4GHI0DbJ0yx68qnJMinMYcHmnvCHPUtm+pGwc6IkFL9
   e8r6C1im58WxD3du9xDfw43qiRRVlfa4c/BLR+Si5Kew/M6FH8rkKTlqi
   +o6zIQ5ogk0aOGi6MAz8wbrC+x3JvZ695KAWVKyBLK2wfvhlomunVToTL
   XD773GKhQ3ooj5AgqQ+YY4ZWhnat/lanoUY0olzw4Ub1wkCaxRPn7ICaN
   8VPW2gdCSrmQY5y1xnWrx7rmYjyDuL1tD+oYrlCUbMWaO4f3hSnWZP4ZZ
   2wns2gJ6jKu0+LzXWWT8MXF/SPNpD4NKDFTzZy/KFnydLp8LKJW9MuLPP
   Q==;
X-CSE-ConnectionGUID: yL3Ozq6dRwG1h8zV8xFuNA==
X-CSE-MsgGUID: ofhONw4mSk2o4RVCaGfZkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="70830020"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="70830020"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 09:29:30 -0700
X-CSE-ConnectionGUID: PERaMylvSiCR1l7yLwa/Pw==
X-CSE-MsgGUID: krmVJg17Td+ByEB87O1uQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="156852479"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jun 2025 09:29:30 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH net-next 3/8] ice: use bitfields instead of unions for CGU regs
Date: Thu, 26 Jun 2025 09:29:14 -0700
Message-ID: <20250626162921.1173068-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
References: <20250626162921.1173068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Switch from unions with bitfield structs to definitions with bitfield
masks. This is necessary, because some registers have different
field definitions or even use a different register for the same fields
based on HW type.

Remove unused register fields.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h | 212 +++--------------
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 239 ++++++++++----------
 2 files changed, 156 insertions(+), 295 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index ed375babcde3..e8979b80c2f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -39,194 +39,46 @@
 #define FEC_RECEIVER_ID_PCS0 (0x33 << FEC_RECV_ID_SHIFT)
 #define FEC_RECEIVER_ID_PCS1 (0x34 << FEC_RECV_ID_SHIFT)
 
-#define ICE_CGU_R9 0x24
-union ice_cgu_r9 {
-	struct {
-		u32 time_ref_freq_sel : 3;
-		u32 clk_eref1_en : 1;
-		u32 clk_eref0_en : 1;
-		u32 time_ref_en : 1;
-		u32 time_sync_en : 1;
-		u32 one_pps_out_en : 1;
-		u32 clk_ref_synce_en : 1;
-		u32 clk_synce1_en : 1;
-		u32 clk_synce0_en : 1;
-		u32 net_clk_ref1_en : 1;
-		u32 net_clk_ref0_en : 1;
-		u32 clk_synce1_amp : 2;
-		u32 misc6 : 1;
-		u32 clk_synce0_amp : 2;
-		u32 one_pps_out_amp : 2;
-		u32 misc24 : 12;
-	};
-	u32 val;
-};
+#define ICE_CGU_R9			0x24
+#define ICE_CGU_R9_TIME_REF_FREQ_SEL	GENMASK(2, 0)
+#define ICE_CGU_R9_CLK_EREF0_EN		BIT(4)
+#define ICE_CGU_R9_TIME_REF_EN		BIT(5)
+#define ICE_CGU_R9_TIME_SYNC_EN		BIT(6)
+#define ICE_CGU_R9_ONE_PPS_OUT_EN	BIT(7)
+#define ICE_CGU_R9_ONE_PPS_OUT_AMP	GENMASK(19, 18)
 
-#define ICE_CGU_R16 0x40
-union ice_cgu_r16 {
-	struct {
-		u32 synce_remndr : 6;
-		u32 synce_phlmt_en : 1;
-		u32 misc13 : 17;
-		u32 ck_refclkfreq : 8;
-	};
-	u32 val;
-};
+#define ICE_CGU_R16			0x40
+#define ICE_CGU_R16_TSPLL_CK_REFCLKFREQ	GENMASK(31, 24)
 
-#define ICE_CGU_R19 0x4c
-union ice_cgu_r19_e82x {
-	struct {
-		u32 fbdiv_intgr : 8;
-		u32 fdpll_ulck_thr : 5;
-		u32 misc15 : 3;
-		u32 ndivratio : 4;
-		u32 tspll_iref_ndivratio : 3;
-		u32 misc19 : 1;
-		u32 japll_ndivratio : 4;
-		u32 japll_iref_ndivratio : 3;
-		u32 misc27 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R19			0x4C
+#define ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X	GENMASK(7, 0)
+#define ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825	GENMASK(9, 0)
+#define ICE_CGU_R19_TSPLL_NDIVRATIO	GENMASK(19, 16)
 
-union ice_cgu_r19_e825 {
-	struct {
-		u32 tspll_fbdiv_intgr : 10;
-		u32 fdpll_ulck_thr : 5;
-		u32 misc15 : 1;
-		u32 tspll_ndivratio : 4;
-		u32 tspll_iref_ndivratio : 3;
-		u32 misc19 : 1;
-		u32 japll_ndivratio : 4;
-		u32 japll_postdiv_pdivratio : 3;
-		u32 misc27 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R22			0x58
+#define ICE_CGU_R22_TIME1588CLK_DIV	GENMASK(23, 20)
+#define ICE_CGU_R22_TIME1588CLK_DIV2	BIT(30)
 
-#define ICE_CGU_R22 0x58
-union ice_cgu_r22 {
-	struct {
-		u32 fdpll_frac_div_out_nc : 2;
-		u32 fdpll_lock_int_for : 1;
-		u32 synce_hdov_int_for : 1;
-		u32 synce_lock_int_for : 1;
-		u32 fdpll_phlead_slip_nc : 1;
-		u32 fdpll_acc1_ovfl_nc : 1;
-		u32 fdpll_acc2_ovfl_nc : 1;
-		u32 synce_status_nc : 6;
-		u32 fdpll_acc1f_ovfl : 1;
-		u32 misc18 : 1;
-		u32 fdpllclk_div : 4;
-		u32 time1588clk_div : 4;
-		u32 synceclk_div : 4;
-		u32 synceclk_sel_div2 : 1;
-		u32 fdpllclk_sel_div2 : 1;
-		u32 time1588clk_sel_div2 : 1;
-		u32 misc3 : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_R23			0x5C
+#define ICE_CGU_R24			0x60
+#define ICE_CGU_R24_FBDIV_FRAC		GENMASK(21, 0)
+#define ICE_CGU_R23_R24_TSPLL_ENABLE	BIT(24)
+#define ICE_CGU_R23_R24_REF1588_CK_DIV	GENMASK(30, 27)
+#define ICE_CGU_R23_R24_TIME_REF_SEL	BIT(31)
 
-#define ICE_CGU_R23 0x5C
-union ice_cgu_r23 {
-	struct {
-		u32 cgupll_fbdiv_intgr : 10;
-		u32 ux56pll_fbdiv_intgr : 10;
-		u32 misc20 : 4;
-		u32 ts_pll_enable : 1;
-		u32 time_sync_tspll_align_sel : 1;
-		u32 ext_synce_sel : 1;
-		u32 ref1588_ck_div : 4;
-		u32 time_ref_sel : 1;
+#define ICE_CGU_BW_TDC			0x31C
+#define ICE_CGU_BW_TDC_PLLLOCK_SEL	GENMASK(30, 29)
 
-	};
-	u32 val;
-};
+#define ICE_CGU_RO_LOCK			0x3F0
+#define ICE_CGU_RO_LOCK_TRUE_LOCK	BIT(12)
+#define ICE_CGU_RO_LOCK_UNLOCK		BIT(13)
 
-#define ICE_CGU_R24 0x60
-union ice_cgu_r24 {
-	struct {
-		u32 fbdiv_frac : 22;
-		u32 misc20 : 2;
-		u32 ts_pll_enable : 1;
-		u32 time_sync_tspll_align_sel : 1;
-		u32 ext_synce_sel : 1;
-		u32 ref1588_ck_div : 4;
-		u32 time_ref_sel : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_CNTR_BIST		0x344
+#define ICE_CGU_CNTR_BIST_PLLLOCK_SEL_0	BIT(15)
+#define ICE_CGU_CNTR_BIST_PLLLOCK_SEL_1	BIT(16)
 
-#define TSPLL_CNTR_BIST_SETTINGS 0x344
-union tspll_cntr_bist_settings {
-	struct {
-		u32 i_irefgen_settling_time_cntr_7_0 : 8;
-		u32 i_irefgen_settling_time_ro_standby_1_0 : 2;
-		u32 reserved195 : 5;
-		u32 i_plllock_sel_0 : 1;
-		u32 i_plllock_sel_1 : 1;
-		u32 i_plllock_cnt_6_0 : 7;
-		u32 i_plllock_cnt_10_7 : 4;
-		u32 reserved200 : 4;
-	};
-	u32 val;
-};
-
-#define TSPLL_RO_BWM_LF 0x370
-union tspll_ro_bwm_lf {
-	struct {
-		u32 bw_freqov_high_cri_7_0 : 8;
-		u32 bw_freqov_high_cri_9_8 : 2;
-		u32 biascaldone_cri : 1;
-		u32 plllock_gain_tran_cri : 1;
-		u32 plllock_true_lock_cri : 1;
-		u32 pllunlock_flag_cri : 1;
-		u32 afcerr_cri : 1;
-		u32 afcdone_cri : 1;
-		u32 feedfwrdgain_cal_cri_7_0 : 8;
-		u32 m2fbdivmod_cri_7_0 : 8;
-	};
-	u32 val;
-};
-
-#define TSPLL_RO_LOCK_E825C 0x3f0
-union tspll_ro_lock_e825c {
-	struct {
-		u32 bw_freqov_high_cri_7_0 : 8;
-		u32 bw_freqov_high_cri_9_8 : 2;
-		u32 reserved455 : 1;
-		u32 plllock_gain_tran_cri : 1;
-		u32 plllock_true_lock_cri : 1;
-		u32 pllunlock_flag_cri : 1;
-		u32 afcerr_cri : 1;
-		u32 afcdone_cri : 1;
-		u32 feedfwrdgain_cal_cri_7_0 : 8;
-		u32 reserved462 : 8;
-	};
-	u32 val;
-};
-
-#define TSPLL_BW_TDC_E825C 0x31c
-union tspll_bw_tdc_e825c {
-	struct {
-		u32 i_tdc_offset_lock_1_0 : 2;
-		u32 i_bbthresh1_2_0 : 3;
-		u32 i_bbthresh2_2_0 : 3;
-		u32 i_tdcsel_1_0 : 2;
-		u32 i_tdcovccorr_en_h : 1;
-		u32 i_divretimeren : 1;
-		u32 i_bw_ampmeas_window : 1;
-		u32 i_bw_lowerbound_2_0 : 3;
-		u32 i_bw_upperbound_2_0 : 3;
-		u32 i_bw_mode_1_0 : 2;
-		u32 i_ft_mode_sel_2_0 : 3;
-		u32 i_bwphase_4_0 : 5;
-		u32 i_plllock_sel_1_0 : 2;
-		u32 i_afc_divratio : 1;
-	};
-	u32 val;
-};
+#define ICE_CGU_RO_BWM_LF		0x370
+#define ICE_CGU_RO_BWM_LF_TRUE_LOCK	BIT(12)
 
 int ice_init_hw(struct ice_hw *hw);
 void ice_deinit_hw(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 440aba817b9c..8e1f522c579b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -127,11 +127,7 @@ static void ice_tspll_log_cfg(struct ice_hw *hw, bool enable, u8 clk_src,
 static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			      enum ice_clk_src clk_src)
 {
-	union tspll_ro_bwm_lf bwm_lf;
-	union ice_cgu_r19_e82x dw19;
-	union ice_cgu_r22 dw22;
-	union ice_cgu_r24 dw24;
-	union ice_cgu_r9 dw9;
+	u32 val, r9, r24;
 	int err;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
@@ -152,102 +148,115 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &r24);
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_BWM_LF, &val);
 	if (err)
 		return err;
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
-			  dw9.time_ref_freq_sel, bwm_lf.plllock_true_lock_cri,
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r24),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  !!FIELD_GET(ICE_CGU_RO_BWM_LF_TRUE_LOCK, val),
 			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
-	if (dw24.ts_pll_enable) {
-		dw24.ts_pll_enable = 0;
+	if (FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24)) {
+		r24 &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
 
-		err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R24, r24);
 		if (err)
 			return err;
 	}
 
 	/* Set the frequency */
-	dw9.time_ref_freq_sel = clk_freq;
-	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
+	r9 &= ~ICE_CGU_R9_TIME_REF_FREQ_SEL;
+	r9 |= FIELD_PREP(ICE_CGU_R9_TIME_REF_FREQ_SEL, clk_freq);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R9, r9);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL feedback divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &dw19.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &val);
 	if (err)
 		return err;
 
-	dw19.fbdiv_intgr = e82x_tspll_params[clk_freq].feedback_div;
-	dw19.ndivratio = 1;
+	val &= ~(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X | ICE_CGU_R19_TSPLL_NDIVRATIO);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E82X,
+			  e82x_tspll_params[clk_freq].feedback_div);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_NDIVRATIO, 1);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R19, val);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL post divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &dw22.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &val);
 	if (err)
 		return err;
 
-	dw22.time1588clk_div = e82x_tspll_params[clk_freq].post_pll_div;
-	dw22.time1588clk_sel_div2 = 0;
+	val &= ~(ICE_CGU_R22_TIME1588CLK_DIV |
+		 ICE_CGU_R22_TIME1588CLK_DIV2);
+	val |= FIELD_PREP(ICE_CGU_R22_TIME1588CLK_DIV,
+			  e82x_tspll_params[clk_freq].post_pll_div);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R22, dw22.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R22, val);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL pre divisor and clock source */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &r24);
 	if (err)
 		return err;
 
-	dw24.ref1588_ck_div = e82x_tspll_params[clk_freq].refclk_pre_div;
-	dw24.fbdiv_frac = e82x_tspll_params[clk_freq].frac_n_div;
-	dw24.time_ref_sel = clk_src;
+	r24 &= ~(ICE_CGU_R23_R24_REF1588_CK_DIV | ICE_CGU_R24_FBDIV_FRAC |
+		 ICE_CGU_R23_R24_TIME_REF_SEL);
+	r24 |= FIELD_PREP(ICE_CGU_R23_R24_REF1588_CK_DIV,
+			  e82x_tspll_params[clk_freq].refclk_pre_div);
+	r24 |= FIELD_PREP(ICE_CGU_R24_FBDIV_FRAC,
+			  e82x_tspll_params[clk_freq].frac_n_div);
+	r24 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R24, r24);
 	if (err)
 		return err;
 
 	/* Finally, enable the PLL */
-	dw24.ts_pll_enable = 1;
+	r24 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R24, r24);
 	if (err)
 		return err;
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_BWM_LF, &val);
 	if (err)
 		return err;
 
-	if (!bwm_lf.plllock_true_lock_cri) {
-		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
+	if (!(val & ICE_CGU_RO_BWM_LF_TRUE_LOCK)) {
+		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
 		return -EBUSY;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &r24);
 	if (err)
 		return err;
 
-	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
-			  dw9.time_ref_freq_sel, true, false);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r24),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r24),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  true, true);
 
 	return 0;
 }
@@ -263,18 +272,17 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
  */
 static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
 {
-	union tspll_cntr_bist_settings cntr_bist;
+	u32 val;
 	int err;
 
-	err = ice_read_cgu_reg(hw, TSPLL_CNTR_BIST_SETTINGS, &cntr_bist.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_CNTR_BIST, &val);
 	if (err)
 		return err;
 
-	/* Disable sticky lock detection so lock err reported is accurate */
-	cntr_bist.i_plllock_sel_0 = 0;
-	cntr_bist.i_plllock_sel_1 = 0;
+	val &= ~(ICE_CGU_CNTR_BIST_PLLLOCK_SEL_0 |
+		 ICE_CGU_CNTR_BIST_PLLLOCK_SEL_1);
 
-	return ice_write_cgu_reg(hw, TSPLL_CNTR_BIST_SETTINGS, cntr_bist.val);
+	return ice_write_cgu_reg(hw, ICE_CGU_CNTR_BIST, val);
 }
 
 /**
@@ -295,12 +303,7 @@ static int ice_tspll_dis_sticky_bits_e82x(struct ice_hw *hw)
 static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			       enum ice_clk_src clk_src)
 {
-	union tspll_ro_lock_e825c ro_lock;
-	union ice_cgu_r19_e825 dw19;
-	union ice_cgu_r16 dw16;
-	union ice_cgu_r23 dw23;
-	union ice_cgu_r22 dw22;
-	union ice_cgu_r9 dw9;
+	u32 val, r9, r23;
 	int err;
 
 	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
@@ -320,99 +323,103 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R16, &dw16.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &r23);
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_LOCK, &val);
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
-	if (err)
-		return err;
-
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
-			  dw9.time_ref_freq_sel,
-			  ro_lock.plllock_true_lock_cri, false);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r23),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  !!FIELD_GET(ICE_CGU_RO_LOCK_TRUE_LOCK, val),
+			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
-	if (dw23.ts_pll_enable) {
-		dw23.ts_pll_enable = 0;
+	if (FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23)) {
+		r23 &= ~ICE_CGU_R23_R24_TSPLL_ENABLE;
 
-		err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R23, r23);
 		if (err)
 			return err;
 	}
 
-	if (dw9.time_sync_en) {
-		dw9.time_sync_en = 0;
+	if (FIELD_GET(ICE_CGU_R9_TIME_SYNC_EN, r9)) {
+		r9 &= ~ICE_CGU_R9_TIME_SYNC_EN;
 
-		err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
+		err = ice_write_cgu_reg(hw, ICE_CGU_R9, r9);
 		if (err)
 			return err;
 	}
 
-	/* Set the frequency */
-	dw9.time_ref_freq_sel = clk_freq;
-
-	/* Enable the correct receiver */
-	if (clk_src == ICE_CLK_SRC_TCXO) {
-		dw9.time_ref_en = 0;
-		dw9.clk_eref0_en = 1;
-	} else {
-		dw9.time_ref_en = 1;
-		dw9.clk_eref0_en = 0;
-	}
-	dw9.time_sync_en = 1;
-	err = ice_write_cgu_reg(hw, ICE_CGU_R9, dw9.val);
+	/* Set the frequency and enable the correct receiver */
+	r9 &= ~(ICE_CGU_R9_TIME_REF_FREQ_SEL | ICE_CGU_R9_CLK_EREF0_EN |
+		ICE_CGU_R9_TIME_REF_EN);
+	r9 |= FIELD_PREP(ICE_CGU_R9_TIME_REF_FREQ_SEL, clk_freq);
+	if (clk_src == ICE_CLK_SRC_TCXO)
+		r9 |= ICE_CGU_R9_CLK_EREF0_EN;
+	else
+		r9 |= ICE_CGU_R9_TIME_REF_EN;
+	r9 |= ICE_CGU_R9_TIME_SYNC_EN;
+	err = ice_write_cgu_reg(hw, ICE_CGU_R9, r9);
 	if (err)
 		return err;
 
 	/* Choose the referenced frequency */
-	dw16.ck_refclkfreq = ICE_TSPLL_CK_REFCLKFREQ_E825;
-	err = ice_write_cgu_reg(hw, ICE_CGU_R16, dw16.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R16, &val);
+	if (err)
+		return err;
+	val &= ~ICE_CGU_R16_TSPLL_CK_REFCLKFREQ;
+	val |= FIELD_PREP(ICE_CGU_R16_TSPLL_CK_REFCLKFREQ,
+			  ICE_TSPLL_CK_REFCLKFREQ_E825);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R16, val);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL feedback divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &dw19.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R19, &val);
 	if (err)
 		return err;
 
-	dw19.tspll_fbdiv_intgr = ICE_TSPLL_FBDIV_INTGR_E825;
-	dw19.tspll_ndivratio = ICE_TSPLL_NDIVRATIO_E825;
+	val &= ~(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825 |
+		 ICE_CGU_R19_TSPLL_NDIVRATIO);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_FBDIV_INTGR_E825,
+			  ICE_TSPLL_FBDIV_INTGR_E825);
+	val |= FIELD_PREP(ICE_CGU_R19_TSPLL_NDIVRATIO,
+			  ICE_TSPLL_NDIVRATIO_E825);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R19, val);
 	if (err)
 		return err;
 
-	/* Configure the TSPLL post divisor */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &dw22.val);
+	/* Configure the TSPLL post divisor, these two are constant */
+	err = ice_read_cgu_reg(hw, ICE_CGU_R22, &val);
 	if (err)
 		return err;
 
-	/* These two are constant for E825C */
-	dw22.time1588clk_div = 5;
-	dw22.time1588clk_sel_div2 = 0;
+	val &= ~(ICE_CGU_R22_TIME1588CLK_DIV |
+		 ICE_CGU_R22_TIME1588CLK_DIV2);
+	val |= FIELD_PREP(ICE_CGU_R22_TIME1588CLK_DIV, 5);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R22, dw22.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R22, val);
 	if (err)
 		return err;
 
-	/* Configure the TSPLL pre divisor and clock source */
-	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
+	/* Configure the TSPLL pre divisor (constant) and clock source */
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &r23);
 	if (err)
 		return err;
 
-	dw23.ref1588_ck_div = 0;
-	dw23.time_ref_sel = clk_src;
+	r23 &= ~(ICE_CGU_R23_R24_REF1588_CK_DIV | ICE_CGU_R23_R24_TIME_REF_SEL);
+	r23 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, r23);
 	if (err)
 		return err;
 
@@ -422,33 +429,35 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return err;
 
 	/* Finally, enable the PLL */
-	dw23.ts_pll_enable = 1;
+	r23 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 
-	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
+	err = ice_write_cgu_reg(hw, ICE_CGU_R23, r23);
 	if (err)
 		return err;
 
 	/* Wait to verify if the PLL locks */
 	usleep_range(1000, 5000);
 
-	err = ice_read_cgu_reg(hw, TSPLL_RO_LOCK_E825C, &ro_lock.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_RO_LOCK, &val);
 	if (err)
 		return err;
 
-	if (!ro_lock.plllock_true_lock_cri) {
-		dev_warn(ice_hw_to_dev(hw), "TSPLL failed to lock\n");
+	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
+		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
 		return -EBUSY;
 	}
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &dw9.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
-	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &dw23.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R23, &r23);
 	if (err)
 		return err;
 
-	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
-			  dw9.time_ref_freq_sel, true, true);
+	ice_tspll_log_cfg(hw, !!FIELD_GET(ICE_CGU_R23_R24_TSPLL_ENABLE, r23),
+			  FIELD_GET(ICE_CGU_R23_R24_TIME_REF_SEL, r23),
+			  FIELD_GET(ICE_CGU_R9_TIME_REF_FREQ_SEL, r9),
+			  true, true);
 
 	return 0;
 }
@@ -464,20 +473,18 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
  */
 static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
 {
-	union tspll_bw_tdc_e825c bw_tdc;
+	u32 val;
 	int err;
 
-	err = ice_read_cgu_reg(hw, TSPLL_BW_TDC_E825C, &bw_tdc.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_BW_TDC, &val);
 	if (err)
 		return err;
 
-	bw_tdc.i_plllock_sel_1_0 = 0;
+	val &= ~ICE_CGU_BW_TDC_PLLLOCK_SEL;
 
-	return ice_write_cgu_reg(hw, TSPLL_BW_TDC_E825C, bw_tdc.val);
+	return ice_write_cgu_reg(hw, ICE_CGU_BW_TDC, val);
 }
 
-#define ICE_ONE_PPS_OUT_AMP_MAX 3
-
 /**
  * ice_tspll_cfg_pps_out_e825c - Enable/disable 1PPS output and set amplitude
  * @hw: pointer to the HW struct
@@ -487,16 +494,18 @@ static int ice_tspll_dis_sticky_bits_e825c(struct ice_hw *hw)
  */
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 {
-	union ice_cgu_r9 r9;
+	u32 val;
 	int err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9.val);
+	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &val);
 	if (err)
 		return err;
 
-	r9.one_pps_out_en = enable;
-	r9.one_pps_out_amp = enable * ICE_ONE_PPS_OUT_AMP_MAX;
-	return ice_write_cgu_reg(hw, ICE_CGU_R9, r9.val);
+	val &= ~(ICE_CGU_R9_ONE_PPS_OUT_EN | ICE_CGU_R9_ONE_PPS_OUT_AMP);
+	val |= FIELD_PREP(ICE_CGU_R9_ONE_PPS_OUT_EN, enable) |
+	       ICE_CGU_R9_ONE_PPS_OUT_AMP;
+
+	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
 /**
-- 
2.47.1


