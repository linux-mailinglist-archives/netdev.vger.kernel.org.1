Return-Path: <netdev+bounces-187322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC0AA667E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05531BC6FBF
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F422578C;
	Thu,  1 May 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISV2UX8h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81C2609F6
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140077; cv=none; b=pqu1mGqqlKrlylOv/fUbSyclstQtwx1ze1GzG3HB8/V9yqyuDSlOMk5olzCsmq49PNM/AidCnWvnDKGAERfu6T9hXERNC5TniWMAXIOHIWX3a/G3BIulD/hZkWw9oatGgnGPf6weULEwGLYQ0qkg0wGc09PSIUZQdzeDOO9t23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140077; c=relaxed/simple;
	bh=u27aG9WP2879sIJKErW2HeGyGC/8UZKwaMiv/IZXwRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOT+Zv/OewPCCY5AfVcI9e+47gIAQm7H7fv7bZ1AyUQmP1VygzGevk1gjUH0YAmlPZHR1nQsOhSfXvlKh74wbNpjJZaSd5xqvyZ4RqU/7PeVhDMP3mry4qPw+Ac2sebCMFkk3rNLLwS4dGB455FnscSRmQopRIm3E7At/EXpnUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISV2UX8h; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140076; x=1777676076;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u27aG9WP2879sIJKErW2HeGyGC/8UZKwaMiv/IZXwRs=;
  b=ISV2UX8hUHlWNokPT5cxEdmVbzdscEqqme2zfx6zEQ6nFG+5UnYdJPxj
   AvNKNnQQYTGzE5ufs5Sw1EMu2P0v5adl1rFClNizZtCH06afhIJowCA6q
   tOjGzhgFe5ZgewyVSjwK/C8YS3wIwoQsRYiWltnc88zp0OIwKQ+RrUTtK
   9CO59svAU0SCaiXR1XJarIOZJuzXSmc0rflrZJmQGguib3szxyJYSC7SI
   oWI9UyoiOiHIFMtpUWecA7buXdP77BEZ8Vpx28PZNAPNF81CSmBAYtkUW
   5LQh/Que9g32jzYJ4uiw0GtBykFOPG5m+TFFaRfPlgVha9P+Yby4KRCom
   g==;
X-CSE-ConnectionGUID: j3DSLH1MQ4emPYRmrNTvkQ==
X-CSE-MsgGUID: xaU1zKIwTdul4MpdpkPNGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811714"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811714"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:33 -0700
X-CSE-ConnectionGUID: 61d41h9pRROMhCUOJIU9vQ==
X-CSE-MsgGUID: AMiMHRufRTqmkOL4FsF07g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514281"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:15 -0700
Subject: [PATCH v4 04/15] ice: remove ice_tspll_params_e825 definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-4-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

Remove ice_tspll_params_e825 definitions as according to EDS (Electrical
Design Specification) doc, E825 devices support only 156.25 MHz TSPLL
frequency for both TCXO and TIME_REF clock source.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.h |  21 +-----
 drivers/net/ethernet/intel/ice/ice_tspll.c | 107 +++--------------------------
 2 files changed, 11 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 3dcc525bb8292b635b58fe8107af47b895d3c201..7aef430258e23e8e65cfc37ef8436ac158fa7ee5 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -21,24 +21,9 @@ struct ice_tspll_params_e82x {
 	u32 post_pll_div;
 };
 
-/**
- * struct ice_tspll_params_e825c - E825-C TSPLL parameters
- * @ck_refclkfreq: ck_refclkfreq selection
- * @ndivratio: ndiv ratio that goes directly to the PLL
- * @fbdiv_intgr: TSPLL integer feedback divisor
- * @fbdiv_frac: TSPLL fractional feedback divisor
- * @ref1588_ck_div: clock divisor for tspll ref
- *
- * Clock Generation Unit parameters used to program the PLL based on the
- * selected TIME_REF/TCXO frequency.
- */
-struct ice_tspll_params_e825c {
-	u32 ck_refclkfreq;
-	u32 ndivratio;
-	u32 fbdiv_intgr;
-	u32 fbdiv_frac;
-	u32 ref1588_ck_div;
-};
+#define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
+#define ICE_TSPLL_NDIVRATIO_E825		5
+#define ICE_TSPLL_FBDIV_INTGR_E825		256
 
 int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable);
 int ice_tspll_init(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 74a9fc35fb1a6bc1011fe8142566a14673e867d9..eb7fbae719843e8b446f78943a2edcc4d5a9de6c 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -80,93 +80,6 @@ ice_tspll_params_e82x e82x_tspll_params[NUM_ICE_TSPLL_FREQ] = {
 	},
 };
 
-static const struct
-ice_tspll_params_e825c e825c_tspll_params[NUM_ICE_TSPLL_FREQ] = {
-	/* ICE_TSPLL_FREQ_25_000 -> 25 MHz */
-	{
-		/* ck_refclkfreq */
-		0x19,
-		/* ndivratio */
-		1,
-		/* fbdiv_intgr */
-		320,
-		/* fbdiv_frac */
-		0,
-		/* ref1588_ck_div */
-		0,
-	},
-
-	/* ICE_TSPLL_FREQ_122_880 -> 122.88 MHz */
-	{
-		/* ck_refclkfreq */
-		0x29,
-		/* ndivratio */
-		3,
-		/* fbdiv_intgr */
-		195,
-		/* fbdiv_frac */
-		1342177280UL,
-		/* ref1588_ck_div */
-		0,
-	},
-
-	/* ICE_TSPLL_FREQ_125_000 -> 125 MHz */
-	{
-		/* ck_refclkfreq */
-		0x3E,
-		/* ndivratio */
-		2,
-		/* fbdiv_intgr */
-		128,
-		/* fbdiv_frac */
-		0,
-		/* ref1588_ck_div */
-		0,
-	},
-
-	/* ICE_TSPLL_FREQ_153_600 -> 153.6 MHz */
-	{
-		/* ck_refclkfreq */
-		0x33,
-		/* ndivratio */
-		3,
-		/* fbdiv_intgr */
-		156,
-		/* fbdiv_frac */
-		1073741824UL,
-		/* ref1588_ck_div */
-		0,
-	},
-
-	/* ICE_TSPLL_FREQ_156_250 -> 156.25 MHz */
-	{
-		/* ck_refclkfreq */
-		0x1F,
-		/* ndivratio */
-		5,
-		/* fbdiv_intgr */
-		256,
-		/* fbdiv_frac */
-		0,
-		/* ref1588_ck_div */
-		0,
-	},
-
-	/* ICE_TSPLL_FREQ_245_760 -> 245.76 MHz */
-	{
-		/* ck_refclkfreq */
-		0x52,
-		/* ndivratio */
-		3,
-		/* fbdiv_intgr */
-		97,
-		/* fbdiv_frac */
-		2818572288UL,
-		/* ref1588_ck_div */
-		0,
-	},
-};
-
 /**
  * ice_tspll_clk_freq_str - Convert time_ref_freq to string
  * @clk_freq: Clock frequency
@@ -402,7 +315,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	union ice_cgu_r16 dw16;
 	union ice_cgu_r23 dw23;
 	union ice_cgu_r22 dw22;
-	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
 	int err;
 
@@ -418,9 +330,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	if (clk_src == ICE_CLK_SRC_TCXO && clk_freq != ICE_TSPLL_FREQ_156_250) {
-		dev_warn(ice_hw_to_dev(hw),
-			 "TCXO only supports 156.25 MHz frequency\n");
+	if (clk_freq != ICE_TSPLL_FREQ_156_250) {
+		dev_warn(ice_hw_to_dev(hw), "Adapter only supports 156.25 MHz frequency\n");
 		return -EINVAL;
 	}
 
@@ -472,7 +383,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return err;
 
 	/* Choose the referenced frequency */
-	dw16.ck_refclkfreq = e825c_tspll_params[clk_freq].ck_refclkfreq;
+	dw16.ck_refclkfreq = ICE_TSPLL_CK_REFCLKFREQ_E825;
 	err = ice_write_cgu_reg(hw, ICE_CGU_R16, dw16.val);
 	if (err)
 		return err;
@@ -482,8 +393,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw19.tspll_fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
-	dw19.tspll_ndivratio = e825c_tspll_params[clk_freq].ndivratio;
+	dw19.tspll_fbdiv_intgr = ICE_TSPLL_FBDIV_INTGR_E825;
+	dw19.tspll_ndivratio = ICE_TSPLL_NDIVRATIO_E825;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
 	if (err)
@@ -507,17 +418,15 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw23.ref1588_ck_div = e825c_tspll_params[clk_freq].ref1588_ck_div;
+	dw23.ref1588_ck_div = 0;
 	dw23.time_ref_sel = clk_src;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
 	if (err)
 		return err;
 
-	dw24.val = 0;
-	dw24.fbdiv_frac = e825c_tspll_params[clk_freq].fbdiv_frac;
-
-	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
+	/* Clear the R24 register. */
+	err = ice_write_cgu_reg(hw, ICE_CGU_R24, 0);
 	if (err)
 		return err;
 

-- 
2.48.1.397.gec9d649cc640


