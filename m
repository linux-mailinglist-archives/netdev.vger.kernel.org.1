Return-Path: <netdev+bounces-200462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053FAAE5895
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD95A4A7232
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F63192598;
	Tue, 24 Jun 2025 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lx5N4v8m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FE1714C6
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750725011; cv=none; b=iZgolfKMGTvXyf1+xl1q0NAd+kxaFu7tIZ8VCYtzgHFbXo5Jc6gH+yyASEuaOZ4fXolwxrN1rEQiBz3XRBnJbuCqEmKMKNxWI+BvLShM1gMdUVK8SeNeMMFvUT9RIv6uxRWOmw7QJupWujaaFxgaV1b5sh9z2A18p/0ZD+qg2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750725011; c=relaxed/simple;
	bh=Q2LTKXyU/2AHsmVL5L2k3vVmUySp3C68zPt1J8YYFf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlwjI9AOPcX0Lvv96JsOK5j+1F2GKy64IzfhKP3QyxOqZRiJDr94wE1azlXX950HoxFmDYtJaG4S7c7tm5I85ak9f1TuL0nLrmS09h6xulR9s/Fgdff5s8IR0soZrgEnTyqU+ZYcjfaY2mRu4tpTvDntMXu1+OVFqD1PGCuGwdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lx5N4v8m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750725010; x=1782261010;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Q2LTKXyU/2AHsmVL5L2k3vVmUySp3C68zPt1J8YYFf0=;
  b=lx5N4v8m7U5f3vpdKanY2DgifW15KXygzzllcTVv5muJQhVOLMVJKpx0
   M7MEDJ76oMJWSRVdBykG0ynqXCk3+SQXyN7CPh83ImzAiIsL/VtsA6bwD
   6GwQ4wwRepodv0K7KhbI5PJ7fbBYvIMUma6pRlFWpfHyMytYXBRpXB2Q8
   jEzufQAA04FN2NORpWEAMdsxpP1GxAZnUaoUK3Awvd6/hnacvTbedLTL1
   Oqm30ANeYlQzNVm3OMZfA74UZiTf4HbtnVOoT8AtdDE0cd/1276Y7+94z
   lDzvVkjOjv7lFmQl4m3vGeNTEtquTW7bJhasVXWCd4PloNLD7hKCq1w79
   g==;
X-CSE-ConnectionGUID: c+OPP3TpTzu0MosUbyLe5A==
X-CSE-MsgGUID: 4aKyYcznSnSnbEKTCqL9yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52067915"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="52067915"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:07 -0700
X-CSE-ConnectionGUID: SYOJQsjRSyS5a38jjWQh/A==
X-CSE-MsgGUID: lpe4s5D4RQ+QGMC8rQOyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="157534045"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:30:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 23 Jun 2025 17:30:00 -0700
Subject: [PATCH 4/8] ice: add multiple TSPLL helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-kk-tspll-improvements-alignment-v1-4-fe9a50620700@intel.com>
References: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
In-Reply-To: <20250623-kk-tspll-improvements-alignment-v1-0-fe9a50620700@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Milena Olech <milena.olech@intel.com>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

Add helpers for checking TSPLL params, disabling sticky bits,
configuring TSPLL and getting default clock frequency to simplify
the code flows.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 156 ++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 8e1f522c579b7e4d440424fd8af4c7b7e198d067..e7b44e703d7c0966414e119f861ee1ab165d9293 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -71,6 +71,58 @@ static const char *ice_tspll_clk_freq_str(enum ice_tspll_freq clk_freq)
 	}
 }
 
+/**
+ * ice_tspll_default_freq - Return default frequency for a MAC type
+ * @mac_type: MAC type
+ *
+ * Return: default TSPLL frequency for a correct MAC type, -ERANGE otherwise.
+ */
+static enum ice_tspll_freq ice_tspll_default_freq(enum ice_mac_type mac_type)
+{
+	switch (mac_type) {
+	case ICE_MAC_GENERIC:
+		return ICE_TSPLL_FREQ_25_000;
+	case ICE_MAC_GENERIC_3K_E825:
+		return ICE_TSPLL_FREQ_156_250;
+	default:
+		return -ERANGE;
+	}
+}
+
+/**
+ * ice_tspll_check_params - Check if TSPLL params are correct
+ * @hw: Pointer to the HW struct
+ * @clk_freq: Clock frequency to program
+ * @clk_src: Clock source to select (TIME_REF or TCXO)
+ *
+ * Return: true if TSPLL params are correct, false otherwise.
+ */
+static bool ice_tspll_check_params(struct ice_hw *hw,
+				   enum ice_tspll_freq clk_freq,
+				   enum ice_clk_src clk_src)
+{
+	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid TSPLL frequency %u\n",
+			 clk_freq);
+		return false;
+	}
+
+	if (clk_src >= NUM_ICE_CLK_SRC) {
+		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
+			 clk_src);
+		return false;
+	}
+
+	if ((hw->mac_type == ICE_MAC_GENERIC_3K_E825 ||
+	     clk_src == ICE_CLK_SRC_TCXO) &&
+	    clk_freq != ice_tspll_default_freq(hw->mac_type)) {
+		dev_warn(ice_hw_to_dev(hw), "Unsupported frequency for this clock source\n");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * ice_tspll_clk_src_str - Convert time_ref_src to string
  * @clk_src: Clock source
@@ -130,24 +182,6 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	u32 val, r9, r24;
 	int err;
 
-	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
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
-	if (clk_src == ICE_CLK_SRC_TCXO && clk_freq != ICE_TSPLL_FREQ_25_000) {
-		dev_warn(ice_hw_to_dev(hw),
-			 "TCXO only supports 25 MHz frequency\n");
-		return -EINVAL;
-	}
-
 	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
@@ -306,23 +340,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	u32 val, r9, r23;
 	int err;
 
-	if (clk_freq >= NUM_ICE_TSPLL_FREQ) {
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
-	if (clk_freq != ICE_TSPLL_FREQ_156_250) {
-		dev_warn(ice_hw_to_dev(hw), "Adapter only supports 156.25 MHz frequency\n");
-		return -EINVAL;
-	}
-
 	err = ice_read_cgu_reg(hw, ICE_CGU_R9, &r9);
 	if (err)
 		return err;
@@ -508,6 +525,52 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 	return ice_write_cgu_reg(hw, ICE_CGU_R9, val);
 }
 
+/**
+ * ice_tspll_cfg - Configure the Clock Generation Unit TSPLL
+ * @hw: Pointer to the HW struct
+ * @clk_freq: Clock frequency to program
+ * @clk_src: Clock source to select (TIME_REF, or TCXO)
+ *
+ * Configure the Clock Generation Unit with the desired clock frequency and
+ * time reference, enabling the TSPLL which drives the PTP hardware clock.
+ *
+ * Return: 0 on success, -ERANGE on unsupported MAC type, other negative error
+ *         codes when failed to configure CGU.
+ */
+static int ice_tspll_cfg(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
+			 enum ice_clk_src clk_src)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
+		return ice_tspll_cfg_e82x(hw, clk_freq, clk_src);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_tspll_cfg_e825c(hw, clk_freq, clk_src);
+	default:
+		return -ERANGE;
+	}
+}
+
+/**
+ * ice_tspll_dis_sticky_bits - disable TSPLL sticky bits
+ * @hw: Pointer to the HW struct
+ *
+ * Configure the Clock Generation Unit TSPLL sticky bits so they don't latch on
+ * losing TSPLL lock, but always show current state.
+ *
+ * Return: 0 on success, -ERANGE on unsupported MAC type.
+ */
+static int ice_tspll_dis_sticky_bits(struct ice_hw *hw)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC:
+		return ice_tspll_dis_sticky_bits_e82x(hw);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_tspll_dis_sticky_bits_e825c(hw);
+	default:
+		return -ERANGE;
+	}
+}
+
 /**
  * ice_tspll_init - Initialize TSPLL with settings from firmware
  * @hw: Pointer to the HW structure
@@ -519,25 +582,22 @@ int ice_tspll_cfg_pps_out_e825c(struct ice_hw *hw, bool enable)
 int ice_tspll_init(struct ice_hw *hw)
 {
 	struct ice_ts_func_info *ts_info = &hw->func_caps.ts_func_info;
+	enum ice_tspll_freq tspll_freq;
+	enum ice_clk_src clk_src;
 	int err;
 
-	/* Disable sticky lock detection so lock err reported is accurate. */
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
-		err = ice_tspll_dis_sticky_bits_e825c(hw);
-	else
-		err = ice_tspll_dis_sticky_bits_e82x(hw);
+	tspll_freq = (enum ice_tspll_freq)ts_info->time_ref;
+	clk_src = (enum ice_clk_src)ts_info->clk_src;
+	if (!ice_tspll_check_params(hw, tspll_freq, clk_src))
+		return -EINVAL;
+
+	/* Disable sticky lock detection so lock status reported is accurate */
+	err = ice_tspll_dis_sticky_bits(hw);
 	if (err)
 		return err;
 
 	/* Configure the TSPLL using the parameters from the function
 	 * capabilities.
 	 */
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825)
-		err = ice_tspll_cfg_e825c(hw, ts_info->time_ref,
-					  (enum ice_clk_src)ts_info->clk_src);
-	else
-		err = ice_tspll_cfg_e82x(hw, ts_info->time_ref,
-					 (enum ice_clk_src)ts_info->clk_src);
-
-	return err;
+	return ice_tspll_cfg(hw, tspll_freq, clk_src);
 }

-- 
2.48.1.397.gec9d649cc640


