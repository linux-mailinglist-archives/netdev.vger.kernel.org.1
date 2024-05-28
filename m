Return-Path: <netdev+bounces-98810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171268D2883
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF87287AD3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A61B13FD9D;
	Tue, 28 May 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B83N5HGf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB6113F445
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937457; cv=none; b=ilo8ctQJMpnGAlhzX4ul2wVb81FId4Sgmzyw5ur0r5qMvPSneAHKMhSSpiqKHIpA70BnD9o4VD2f+YXB/6svq5O36jMod/3huLfLH4aBsjmSWPO2of6vSui+HGZumpU3EF3MBWeyDxEgvK9Gvj+QovM+xWWjmybtt3bONN90Z14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937457; c=relaxed/simple;
	bh=mOb3SVk2DNtPqeOd1NGiwIshe1Lt0eY8S6ZFmh5+8lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kpj7fVJ2JuBAHnBrBVtfi+FiuSEazFjSkNDTev6RwyBYIBLMipH7zF40LkYSi2Oywqa9SG8DXA1arvlEl1X+hGNuTtm8QsMe+AIH7z1fm66Vcy631CHf4z1MUPbD9nJKuUnSZ4XkGQbkggwJuDL4Qgfu21RnRwmCebpfGL6xFBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B83N5HGf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937456; x=1748473456;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mOb3SVk2DNtPqeOd1NGiwIshe1Lt0eY8S6ZFmh5+8lA=;
  b=B83N5HGfKHRuSCZHXrxecEu8QsqVs7SVxkrFd211k+2C8H7MhS35cT8I
   2isZVO1DK6xVw6DsYIdYzxPhEPX+sRHEn1CTxjf9hfwMZBFeuUL9Gn/mZ
   LvhDlwpFS/8p1hAHcnBjd017MaoWnr9kSaKuytdB1Vs9gKmgc3R8gmW8a
   WRbilSRopdSFmTeG4CeCjoqAbdUZPmM0vDNj+MTQ8EvE3xDexOIRPn9NK
   gMDUg1ziLiwx/rKn0irTujeiHqY2DLYySgKGRXD9xtumBBrW0W/ljA9xi
   /Bd1FKbdPi4XJC+2GBfdkM1QMS6V/RLX7QXpaShht3N5dx8VFljW2irZP
   w==;
X-CSE-ConnectionGUID: kAwbPYjGTFilGgzQSXsL5w==
X-CSE-MsgGUID: slQANJ9eTmWNcFLG3R+cYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13444879"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13444879"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:12 -0700
X-CSE-ConnectionGUID: pGMhhNSGRIG8XZuaUOkXjQ==
X-CSE-MsgGUID: bSSIFqJjRly+WHgvskkQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39672290"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:11 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 16:03:55 -0700
Subject: [PATCH next 05/11] ice: Move CGU block
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-next-2024-05-28-ptp-refactors-v1-5-c082739bb6f6@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Move CGU block to the beginning of ice_ptp_hw.c

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 575 ++++++++++++++--------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +-
 2 files changed, 290 insertions(+), 287 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 25b3544c4862..7224bce7aa28 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -226,6 +226,293 @@ static u64 ice_ptp_read_src_incval(struct ice_hw *hw)
 	return ((u64)(hi & INCVAL_HIGH_M) << 32) | lo;
 }
 
+/**
+ * ice_read_cgu_reg_e82x - Read a CGU register
+ * @hw: pointer to the HW struct
+ * @addr: Register address to read
+ * @val: storage for register value read
+ *
+ * Read the contents of a register of the Clock Generation Unit. Only
+ * applicable to E822 devices.
+ *
+ * Return: 0 on success, other error codes when failed to read from CGU
+ */
+static int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
+{
+	struct ice_sbq_msg_input cgu_msg = {
+		.opcode = ice_sbq_msg_rd,
+		.dest_dev = cgu,
+		.msg_addr_low = addr
+	};
+	int err;
+
+	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read CGU register 0x%04x, err %d\n",
+			  addr, err);
+		return err;
+	}
+
+	*val = cgu_msg.data;
+
+	return 0;
+}
+
+/**
+ * ice_write_cgu_reg_e82x - Write a CGU register
+ * @hw: pointer to the HW struct
+ * @addr: Register address to write
+ * @val: value to write into the register
+ *
+ * Write the specified value to a register of the Clock Generation Unit. Only
+ * applicable to E822 devices.
+ *
+ * Return: 0 on success, other error codes when failed to write to CGU
+ */
+static int ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
+{
+	struct ice_sbq_msg_input cgu_msg = {
+		.opcode = ice_sbq_msg_wr,
+		.dest_dev = cgu,
+		.msg_addr_low = addr,
+		.data = val
+	};
+	int err;
+
+	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write CGU register 0x%04x, err %d\n",
+			  addr, err);
+		return err;
+	}
+
+	return err;
+}
+
+/**
+ * ice_clk_freq_str - Convert time_ref_freq to string
+ * @clk_freq: Clock frequency
+ *
+ * Return: specified TIME_REF clock frequency converted to a string
+ */
+static const char *ice_clk_freq_str(enum ice_time_ref_freq clk_freq)
+{
+	switch (clk_freq) {
+	case ICE_TIME_REF_FREQ_25_000:
+		return "25 MHz";
+	case ICE_TIME_REF_FREQ_122_880:
+		return "122.88 MHz";
+	case ICE_TIME_REF_FREQ_125_000:
+		return "125 MHz";
+	case ICE_TIME_REF_FREQ_153_600:
+		return "153.6 MHz";
+	case ICE_TIME_REF_FREQ_156_250:
+		return "156.25 MHz";
+	case ICE_TIME_REF_FREQ_245_760:
+		return "245.76 MHz";
+	default:
+		return "Unknown";
+	}
+}
+
+/**
+ * ice_clk_src_str - Convert time_ref_src to string
+ * @clk_src: Clock source
+ *
+ * Return: specified clock source converted to its string name
+ */
+static const char *ice_clk_src_str(enum ice_clk_src clk_src)
+{
+	switch (clk_src) {
+	case ICE_CLK_SRC_TCX0:
+		return "TCX0";
+	case ICE_CLK_SRC_TIME_REF:
+		return "TIME_REF";
+	default:
+		return "Unknown";
+	}
+}
+
+/**
+ * ice_cfg_cgu_pll_e82x - Configure the Clock Generation Unit
+ * @hw: pointer to the HW struct
+ * @clk_freq: Clock frequency to program
+ * @clk_src: Clock source to select (TIME_REF, or TCX0)
+ *
+ * Configure the Clock Generation Unit with the desired clock frequency and
+ * time reference, enabling the PLL which drives the PTP hardware clock.
+ *
+ * Return:
+ * * %0       - success
+ * * %-EINVAL - input parameters are incorrect
+ * * %-EBUSY  - failed to lock TS PLL
+ * * %other   - CGU read/write failure
+ */
+static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
+				enum ice_time_ref_freq clk_freq,
+				enum ice_clk_src clk_src)
+{
+	union tspll_ro_bwm_lf bwm_lf;
+	union nac_cgu_dword19 dw19;
+	union nac_cgu_dword22 dw22;
+	union nac_cgu_dword24 dw24;
+	union nac_cgu_dword9 dw9;
+	int err;
+
+	if (clk_freq >= NUM_ICE_TIME_REF_FREQ) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
+			 clk_freq);
+		return -EINVAL;
+	}
+
+	if (clk_src >= NUM_ICE_CLK_SRC) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
+			 clk_src);
+		return -EINVAL;
+	}
+
+	if (clk_src == ICE_CLK_SRC_TCX0 &&
+	    clk_freq != ICE_TIME_REF_FREQ_25_000) {
+		dev_warn(ice_hw_to_dev(hw),
+			 "TCX0 only supports 25 MHz frequency\n");
+		return -EINVAL;
+	}
+
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
+	if (err)
+		return err;
+
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
+	if (err)
+		return err;
+
+	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
+	if (err)
+		return err;
+
+	/* Log the current clock configuration */
+	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
+		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
+		  ice_clk_src_str(dw24.field.time_ref_sel),
+		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
+		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
+
+	/* Disable the PLL before changing the clock source or frequency */
+	if (dw24.field.ts_pll_enable) {
+		dw24.field.ts_pll_enable = 0;
+
+		err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
+		if (err)
+			return err;
+	}
+
+	/* Set the frequency */
+	dw9.field.time_ref_freq_sel = clk_freq;
+	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
+	if (err)
+		return err;
+
+	/* Configure the TS PLL feedback divisor */
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD19, &dw19.val);
+	if (err)
+		return err;
+
+	dw19.field.tspll_fbdiv_intgr = e822_cgu_params[clk_freq].feedback_div;
+	dw19.field.tspll_ndivratio = 1;
+
+	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD19, dw19.val);
+	if (err)
+		return err;
+
+	/* Configure the TS PLL post divisor */
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD22, &dw22.val);
+	if (err)
+		return err;
+
+	dw22.field.time1588clk_div = e822_cgu_params[clk_freq].post_pll_div;
+	dw22.field.time1588clk_sel_div2 = 0;
+
+	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD22, dw22.val);
+	if (err)
+		return err;
+
+	/* Configure the TS PLL pre divisor and clock source */
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
+	if (err)
+		return err;
+
+	dw24.field.ref1588_ck_div = e822_cgu_params[clk_freq].refclk_pre_div;
+	dw24.field.tspll_fbdiv_frac = e822_cgu_params[clk_freq].frac_n_div;
+	dw24.field.time_ref_sel = clk_src;
+
+	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
+	if (err)
+		return err;
+
+	/* Finally, enable the PLL */
+	dw24.field.ts_pll_enable = 1;
+
+	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
+	if (err)
+		return err;
+
+	/* Wait to verify if the PLL locks */
+	usleep_range(1000, 5000);
+
+	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
+	if (err)
+		return err;
+
+	if (!bwm_lf.field.plllock_true_lock_cri) {
+		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
+		return -EBUSY;
+	}
+
+	/* Log the current clock configuration */
+	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
+		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
+		  ice_clk_src_str(dw24.field.time_ref_sel),
+		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
+		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
+
+	return 0;
+}
+
+/**
+ * ice_init_cgu_e82x - Initialize CGU with settings from firmware
+ * @hw: pointer to the HW structure
+ *
+ * Initialize the Clock Generation Unit of the E822 device.
+ *
+ * Return: 0 on success, other error codes when failed to read/write/cfg CGU
+ */
+static int ice_init_cgu_e82x(struct ice_hw *hw)
+{
+	struct ice_ts_func_info *ts_info = &hw->func_caps.ts_func_info;
+	union tspll_cntr_bist_settings cntr_bist;
+	int err;
+
+	err = ice_read_cgu_reg_e82x(hw, TSPLL_CNTR_BIST_SETTINGS,
+				    &cntr_bist.val);
+	if (err)
+		return err;
+
+	/* Disable sticky lock detection so lock err reported is accurate */
+	cntr_bist.field.i_plllock_sel_0 = 0;
+	cntr_bist.field.i_plllock_sel_1 = 0;
+
+	err = ice_write_cgu_reg_e82x(hw, TSPLL_CNTR_BIST_SETTINGS,
+				     cntr_bist.val);
+	if (err)
+		return err;
+
+	/* Configure the CGU PLL using the parameters from the function
+	 * capabilities.
+	 */
+	return ice_cfg_cgu_pll_e82x(hw, ts_info->time_ref,
+				   (enum ice_clk_src)ts_info->clk_src);
+}
+
 /**
  * ice_ptp_tmr_cmd_to_src_reg - Convert to source timer command value
  * @hw: pointer to HW struct
@@ -623,8 +910,7 @@ ice_write_40b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
 			  low_addr);
 		return -EINVAL;
 	}
-
-	low = (u32)(val & P_REG_40B_LOW_M);
+	low = FIELD_GET(P_REG_40B_LOW_M, val);
 	high = (u32)(val >> P_REG_40B_HIGH_S);
 
 	err = ice_write_phy_reg_e82x(hw, port, low_addr, low);
@@ -834,7 +1120,7 @@ ice_read_phy_tstamp_e82x(struct ice_hw *hw, u8 quad, u8 idx, u64 *tstamp)
 	 * lower 8 bits in the low register, and the upper 32 bits in the high
 	 * register.
 	 */
-	*tstamp = ((u64)hi) << TS_PHY_HIGH_S | ((u64)lo & TS_PHY_LOW_M);
+	*tstamp = FIELD_PREP(TS_PHY_HIGH_M, hi) | FIELD_PREP(TS_PHY_LOW_M, lo);
 
 	return 0;
 }
@@ -903,289 +1189,6 @@ static void ice_ptp_reset_ts_memory_e82x(struct ice_hw *hw)
 		ice_ptp_reset_ts_memory_quad_e82x(hw, quad);
 }
 
-/**
- * ice_read_cgu_reg_e82x - Read a CGU register
- * @hw: pointer to the HW struct
- * @addr: Register address to read
- * @val: storage for register value read
- *
- * Read the contents of a register of the Clock Generation Unit. Only
- * applicable to E822 devices.
- */
-static int
-ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
-{
-	struct ice_sbq_msg_input cgu_msg;
-	int err;
-
-	cgu_msg.opcode = ice_sbq_msg_rd;
-	cgu_msg.dest_dev = cgu;
-	cgu_msg.msg_addr_low = addr;
-	cgu_msg.msg_addr_high = 0x0;
-
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read CGU register 0x%04x, err %d\n",
-			  addr, err);
-		return err;
-	}
-
-	*val = cgu_msg.data;
-
-	return err;
-}
-
-/**
- * ice_write_cgu_reg_e82x - Write a CGU register
- * @hw: pointer to the HW struct
- * @addr: Register address to write
- * @val: value to write into the register
- *
- * Write the specified value to a register of the Clock Generation Unit. Only
- * applicable to E822 devices.
- */
-static int
-ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
-{
-	struct ice_sbq_msg_input cgu_msg;
-	int err;
-
-	cgu_msg.opcode = ice_sbq_msg_wr;
-	cgu_msg.dest_dev = cgu;
-	cgu_msg.msg_addr_low = addr;
-	cgu_msg.msg_addr_high = 0x0;
-	cgu_msg.data = val;
-
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to write CGU register 0x%04x, err %d\n",
-			  addr, err);
-		return err;
-	}
-
-	return err;
-}
-
-/**
- * ice_clk_freq_str - Convert time_ref_freq to string
- * @clk_freq: Clock frequency
- *
- * Convert the specified TIME_REF clock frequency to a string.
- */
-static const char *ice_clk_freq_str(u8 clk_freq)
-{
-	switch ((enum ice_time_ref_freq)clk_freq) {
-	case ICE_TIME_REF_FREQ_25_000:
-		return "25 MHz";
-	case ICE_TIME_REF_FREQ_122_880:
-		return "122.88 MHz";
-	case ICE_TIME_REF_FREQ_125_000:
-		return "125 MHz";
-	case ICE_TIME_REF_FREQ_153_600:
-		return "153.6 MHz";
-	case ICE_TIME_REF_FREQ_156_250:
-		return "156.25 MHz";
-	case ICE_TIME_REF_FREQ_245_760:
-		return "245.76 MHz";
-	default:
-		return "Unknown";
-	}
-}
-
-/**
- * ice_clk_src_str - Convert time_ref_src to string
- * @clk_src: Clock source
- *
- * Convert the specified clock source to its string name.
- */
-static const char *ice_clk_src_str(u8 clk_src)
-{
-	switch ((enum ice_clk_src)clk_src) {
-	case ICE_CLK_SRC_TCX0:
-		return "TCX0";
-	case ICE_CLK_SRC_TIME_REF:
-		return "TIME_REF";
-	default:
-		return "Unknown";
-	}
-}
-
-/**
- * ice_cfg_cgu_pll_e82x - Configure the Clock Generation Unit
- * @hw: pointer to the HW struct
- * @clk_freq: Clock frequency to program
- * @clk_src: Clock source to select (TIME_REF, or TCX0)
- *
- * Configure the Clock Generation Unit with the desired clock frequency and
- * time reference, enabling the PLL which drives the PTP hardware clock.
- */
-static int
-ice_cfg_cgu_pll_e82x(struct ice_hw *hw, enum ice_time_ref_freq clk_freq,
-		     enum ice_clk_src clk_src)
-{
-	union tspll_ro_bwm_lf bwm_lf;
-	union nac_cgu_dword19 dw19;
-	union nac_cgu_dword22 dw22;
-	union nac_cgu_dword24 dw24;
-	union nac_cgu_dword9 dw9;
-	int err;
-
-	if (clk_freq >= NUM_ICE_TIME_REF_FREQ) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
-			 clk_freq);
-		return -EINVAL;
-	}
-
-	if (clk_src >= NUM_ICE_CLK_SRC) {
-		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
-			 clk_src);
-		return -EINVAL;
-	}
-
-	if (clk_src == ICE_CLK_SRC_TCX0 &&
-	    clk_freq != ICE_TIME_REF_FREQ_25_000) {
-		dev_warn(ice_hw_to_dev(hw),
-			 "TCX0 only supports 25 MHz frequency\n");
-		return -EINVAL;
-	}
-
-	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
-	if (err)
-		return err;
-
-	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
-	if (err)
-		return err;
-
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
-		  ice_clk_src_str(dw24.field.time_ref_sel),
-		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
-		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
-
-	/* Disable the PLL before changing the clock source or frequency */
-	if (dw24.field.ts_pll_enable) {
-		dw24.field.ts_pll_enable = 0;
-
-		err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
-		if (err)
-			return err;
-	}
-
-	/* Set the frequency */
-	dw9.field.time_ref_freq_sel = clk_freq;
-	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
-	if (err)
-		return err;
-
-	/* Configure the TS PLL feedback divisor */
-	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD19, &dw19.val);
-	if (err)
-		return err;
-
-	dw19.field.tspll_fbdiv_intgr = e822_cgu_params[clk_freq].feedback_div;
-	dw19.field.tspll_ndivratio = 1;
-
-	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD19, dw19.val);
-	if (err)
-		return err;
-
-	/* Configure the TS PLL post divisor */
-	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD22, &dw22.val);
-	if (err)
-		return err;
-
-	dw22.field.time1588clk_div = e822_cgu_params[clk_freq].post_pll_div;
-	dw22.field.time1588clk_sel_div2 = 0;
-
-	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD22, dw22.val);
-	if (err)
-		return err;
-
-	/* Configure the TS PLL pre divisor and clock source */
-	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
-	if (err)
-		return err;
-
-	dw24.field.ref1588_ck_div = e822_cgu_params[clk_freq].refclk_pre_div;
-	dw24.field.tspll_fbdiv_frac = e822_cgu_params[clk_freq].frac_n_div;
-	dw24.field.time_ref_sel = clk_src;
-
-	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
-	if (err)
-		return err;
-
-	/* Finally, enable the PLL */
-	dw24.field.ts_pll_enable = 1;
-
-	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
-	if (err)
-		return err;
-
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
-
-	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
-	if (err)
-		return err;
-
-	if (!bwm_lf.field.plllock_true_lock_cri) {
-		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
-		return -EBUSY;
-	}
-
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.field.ts_pll_enable ? "enabled" : "disabled",
-		  ice_clk_src_str(dw24.field.time_ref_sel),
-		  ice_clk_freq_str(dw9.field.time_ref_freq_sel),
-		  bwm_lf.field.plllock_true_lock_cri ? "locked" : "unlocked");
-
-	return 0;
-}
-
-/**
- * ice_init_cgu_e82x - Initialize CGU with settings from firmware
- * @hw: pointer to the HW structure
- *
- * Initialize the Clock Generation Unit of the E822 device.
- */
-static int ice_init_cgu_e82x(struct ice_hw *hw)
-{
-	struct ice_ts_func_info *ts_info = &hw->func_caps.ts_func_info;
-	union tspll_cntr_bist_settings cntr_bist;
-	int err;
-
-	err = ice_read_cgu_reg_e82x(hw, TSPLL_CNTR_BIST_SETTINGS,
-				    &cntr_bist.val);
-	if (err)
-		return err;
-
-	/* Disable sticky lock detection so lock err reported is accurate */
-	cntr_bist.field.i_plllock_sel_0 = 0;
-	cntr_bist.field.i_plllock_sel_1 = 0;
-
-	err = ice_write_cgu_reg_e82x(hw, TSPLL_CNTR_BIST_SETTINGS,
-				     cntr_bist.val);
-	if (err)
-		return err;
-
-	/* Configure the CGU PLL using the parameters from the function
-	 * capabilities.
-	 */
-	err = ice_cfg_cgu_pll_e82x(hw, ts_info->time_ref,
-				   (enum ice_clk_src)ts_info->clk_src);
-	if (err)
-		return err;
-
-	return 0;
-}
-
 /**
  * ice_ptp_set_vernier_wl - Set the window length for vernier calibration
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5223e17d2806..2d8ba9c2251d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -377,7 +377,7 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 #define P_REG_TIMETUS_L			0x410
 #define P_REG_TIMETUS_U			0x414
 
-#define P_REG_40B_LOW_M			0xFF
+#define P_REG_40B_LOW_M			GENMASK(7, 0)
 #define P_REG_40B_HIGH_S		8
 
 /* PHY window length registers */

-- 
2.44.0.53.g0f9d4d28b7e6


