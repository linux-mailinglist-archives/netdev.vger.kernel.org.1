Return-Path: <netdev+bounces-173478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D9CA59270
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528BB3AA6D9
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF8227EA8;
	Mon, 10 Mar 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fhfuwli0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA265227E94
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605259; cv=none; b=PNH2k+ZmHIC6kk5Bj9J7X7DOFWg06vzc/fyntDD2NsgXaQZ+pKoknanUmToQxHBMsVv2Jh0xTcMhtSzD3CeB+GESarNWt36HXH8Pa1kG8hNNfQgnyPYrpriIZ+QGOwDWATjMFRT+F+380589wOXCgknJ6ENyo/iXF7/eVassssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605259; c=relaxed/simple;
	bh=QutvssNGdGIqCmHbWPPiEz+j/hyn4ii7O/CGQPF3OKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l24ZBZYMUqkQSr/ZTTDoV8/kUniPrq1E1E2Ca4X7BF24FtCkxauZt4sp95wYC5rGppQf+8DbP1MTCcOUa8G+TekJ0ZWIy+7DXsODI2gAuO6xQsRgBSaah7ENlF8yQjFq9M0ZNkPXP+XHYNyzwxIokPe6qlM2x2x6ecERcJKFHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fhfuwli0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605258; x=1773141258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QutvssNGdGIqCmHbWPPiEz+j/hyn4ii7O/CGQPF3OKo=;
  b=Fhfuwli0FmYzFDtCHrO9w5YHDkP3ephzqdcyHlB/QoJrR7Mzd8U4MCSg
   TxKOfNviXg9fW60Y6H646K1xNNKGD7k9NzXNcBHzr4GIBzMLAXbnKA9t2
   dalqNCCr7WlI4Yg7Uc+JKA25mAK1PKZuRVyTR0OhqnCWpOwbgrwReMQTD
   iPmJUQ7ylwpeJu2lOo+Oi9p3rmKi+jMB2Z5u4RQGS6kifyPJwL482uY/z
   RW0ck3xhAnsAKt3kG8QCE2WQr8jYkuQTxqAtLwAXuXXH1vIz5gode4AnF
   l8PhVVzyIkt/bu94rfKTTmetiSPKvblEY9ISMvHROY8Ozz1MYVVRFiwJk
   g==;
X-CSE-ConnectionGUID: aLsMSzvwRwaEsx9q57KjnA==
X-CSE-MsgGUID: nXHqgaC1Tn2nt3s3EehsXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048671"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048671"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:17 -0700
X-CSE-ConnectionGUID: JfpFVMvkQayS+0foudnGdw==
X-CSE-MsgGUID: Rr1i4T5PSMyHeYyPRrkQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968314"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:15 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena-olech@intel.com>
Subject: [PATCH iwl-next 03/10] ice: use designated initializers for TSPLL consts
Date: Mon, 10 Mar 2025 12:12:47 +0100
Message-ID: <20250310111357.1238454-15-karol.kolacinski@intel.com>
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

Instead of multiple comments, use designated initializers for TSPLL
consts.

Adjust ice_tspll_params_e82x fields sizes.

Remove ice_tspll_params_e825 definitions as according to EDS (Electrical
Design Specification) doc, E825 devices support only 156.25 MHz TSPLL
frequency for both TCXO and TIME_REF clock source.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena-olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 199 ++++-----------------
 drivers/net/ethernet/intel/ice/ice_tspll.h |  29 +--
 2 files changed, 45 insertions(+), 183 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 210be7861313..992c22a34ca9 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -4,164 +4,42 @@
 
 static const struct
 ice_tspll_params_e82x e82x_tspll_params[NUM_ICE_TSPLL_FREQ] = {
-	/* ICE_TSPLL_FREQ_25_000 -> 25 MHz */
-	{
-		/* refclk_pre_div */
-		1,
-		/* feedback_div */
-		197,
-		/* frac_n_div */
-		2621440,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_25_000] = {
+		.refclk_pre_div = 1,
+		.post_pll_div = 6,
+		.feedback_div = 197,
+		.frac_n_div = 2621440,
 	},
-
-	/* ICE_TSPLL_FREQ_122_880 -> 122.88 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
-	},
-
-	/* ICE_TSPLL_FREQ_125_000 -> 125 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
-	},
-
-	/* ICE_TSPLL_FREQ_153_600 -> 153.6 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
-	},
-
-	/* ICE_TSPLL_FREQ_156_250 -> 156.25 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
-	},
-
-	/* ICE_TSPLL_FREQ_245_760 -> 245.76 MHz */
-	{
-		/* refclk_pre_div */
-		10,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
-	},
-};
-
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
+	[ICE_TSPLL_FREQ_122_880] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
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
+	[ICE_TSPLL_FREQ_125_000] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
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
+	[ICE_TSPLL_FREQ_153_600] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
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
+	[ICE_TSPLL_FREQ_156_250] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
+	[ICE_TSPLL_FREQ_245_760] = {
+		.refclk_pre_div = 10,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
+	}
 };
 
 /**
@@ -415,9 +293,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EINVAL;
 	}
 
-	if (clk_src == ICE_CLK_SRC_TCXO && clk_freq != ICE_TSPLL_FREQ_156_250) {
-		dev_warn(ice_hw_to_dev(hw),
-			 "TCXO only supports 156.25 MHz frequency\n");
+	if (clk_freq != ICE_TSPLL_FREQ_156_250) {
+		dev_warn(ice_hw_to_dev(hw), "Adapter only supports 156.25 MHz frequency\n");
 		return -EINVAL;
 	}
 
@@ -473,7 +350,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return err;
 
 	/* Choose the referenced frequency */
-	dw16.ck_refclkfreq = e825c_tspll_params[clk_freq].ck_refclkfreq;
+	dw16.ck_refclkfreq = ICE_TSPLL_CK_REFCLKFREQ_E825;
 	err = ice_write_cgu_reg(hw, ICE_CGU_R16, dw16.val);
 	if (err)
 		return err;
@@ -483,8 +360,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw19.fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
-	dw19.ndivratio = e825c_tspll_params[clk_freq].ndivratio;
+	dw19.fbdiv_intgr = ICE_TSPLL_FBDIV_INTGR_E825;
+	dw19.ndivratio = ICE_TSPLL_NDIVRATIO_E825;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
 	if (err)
@@ -508,14 +385,14 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw23.ref1588_ck_div = e825c_tspll_params[clk_freq].ref1588_ck_div;
+	dw23.ref1588_ck_div = 0;
 	dw23.time_ref_sel = clk_src;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R23, dw23.val);
 	if (err)
 		return err;
 
-	dw24.fbdiv_frac = e825c_tspll_params[clk_freq].fbdiv_frac;
+	dw24.fbdiv_frac = 0;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 0e28e97e09be..609bbbc04d2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -4,38 +4,23 @@
 /**
  * struct ice_tspll_params_e82x
  * @refclk_pre_div: Reference clock pre-divisor
+ * @post_pll_div: Post PLL divisor
  * @feedback_div: Feedback divisor
  * @frac_n_div: Fractional divisor
- * @post_pll_div: Post PLL divisor
  *
  * Clock Generation Unit parameters used to program the PLL based on the
  * selected TIME_REF/TCXO frequency.
  */
 struct ice_tspll_params_e82x {
-	u32 refclk_pre_div;
-	u32 feedback_div;
+	u8 refclk_pre_div;
+	u8 post_pll_div;
+	u8 feedback_div;
 	u32 frac_n_div;
-	u32 post_pll_div;
 };
 
-/**
- * struct ice_tspll_params_e825c
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
-- 
2.48.1


