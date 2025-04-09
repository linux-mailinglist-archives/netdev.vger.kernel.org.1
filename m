Return-Path: <netdev+bounces-180733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493ECA824E3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250893BA840
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3235263898;
	Wed,  9 Apr 2025 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSQAYygS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E82641E8
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 12:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201730; cv=none; b=T82MY2DSXeAevVpF17F1x3M80rnF1vLfcPSV0lui+qHzZHmP6buxXnJd05aVwtvy4gWGsyr9AvsF483TmeHrIUIhOH5A4tdNApqWTVuc7ciiKsuml+ghv8EMlo3ZvJdRh+k75k/nFHhbe5oFAEEYi8zNN/tZXIWFCK2ekIjy3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201730; c=relaxed/simple;
	bh=h9ngu/pgs2FQA0icCDpCrpOPPW337tz2Jm6rHZOLIAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPMkE1SGXt/+VBNLnC7ITRLJqoRJudjOTza10vWK392kRTClf2WORaQ3f6cnPdQHe/Z7tzhSlf+NfxRJUaj+rBvaPjQLmmbXi0QCggioslSi75FD7NIg68D+wgmDEjjAZTcJRmhuAvihId7wjnpWFQ0b3/eEu1FN3gMYHG2UnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSQAYygS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744201729; x=1775737729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9ngu/pgs2FQA0icCDpCrpOPPW337tz2Jm6rHZOLIAs=;
  b=TSQAYygSJ/tUacUX75wUO7uu/C0u2Ut1KyKqBOnkOSWyXacgNWTjJq+k
   TCXyyF6utb/cYVl9iikRe+W1k/hzuEGBQMxhTg/KOHylDc5U5xfWVYUDz
   3YBpacn4rgOH7ZqiL2tCUi1Gly5GvVfu8KkzFfYAvo7XJsfvfyzUXoY1s
   SiO5Ce6anuVDen49bPEorsYcUy/xyZsL3UHxuD5lc/0IOha/9h05xXIlr
   NzaLiWwkSqD/REBiUCUaqoC/Oz3HJNMRqUV27OsTilblFIIZNajGnHAJp
   Q81DR/TjNcNAFuvSr4wA62mQ5n7/wQCwNycuqEEqabePdMLn89p0xZLi1
   g==;
X-CSE-ConnectionGUID: cfI0Liq3QIqFujSZ1FzoAQ==
X-CSE-MsgGUID: yZdciIiFS+6r5HCbQQ3gDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56655685"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56655685"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 05:28:48 -0700
X-CSE-ConnectionGUID: vaYpTT1SSv+rARbUZLSgXg==
X-CSE-MsgGUID: kTPb5kAqSdyIvMwLKllKnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133557200"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2025 05:28:47 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v2 iwl-next 04/10] ice: add TSPLL log config helper
Date: Wed,  9 Apr 2025 14:25:01 +0200
Message-ID: <20250409122830.1977644-16-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409122830.1977644-12-karol.kolacinski@intel.com>
References: <20250409122830.1977644-12-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to print new/current TSPLL config. This helps
avoid unnecessary casts from u8 to enums.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 54 ++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index d98bde911887..70ed0fc61892 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -86,6 +86,26 @@ static const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
 	}
 }
 
+/**
+ * ice_tspll_log_cfg - Log current/new TSPLL configuration
+ * @hw: Pointer to the HW struct
+ * @enable: CGU enabled/disabled
+ * @clk_src: Current clock source
+ * @tspll_freq: Current clock frequency
+ * @lock: CGU lock status
+ * @new_cfg: true if this is a new config
+ */
+static void ice_tspll_log_cfg(struct ice_hw *hw, bool enable, u8 clk_src,
+			      u8 tspll_freq, bool lock, bool new_cfg)
+{
+	dev_dbg(ice_hw_to_dev(hw),
+		"%s TSPLL configuration -- %s, src %s, freq %s, PLL %s\n",
+		new_cfg ? "New" : "Current", enable ? "enabled" : "disabled",
+		ice_tspll_clk_src_str((enum ice_clk_src)clk_src),
+		ice_tspll_clk_freq_str((enum ice_tspll_freq)tspll_freq),
+		lock ? "locked" : "unlocked");
+}
+
 /**
  * ice_tspll_cfg_e82x - Configure the Clock Generation Unit TSPLL
  * @hw: Pointer to the HW struct
@@ -141,12 +161,9 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
-		  ice_tspll_clk_src_str(dw24.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, bwm_lf.plllock_true_lock_cri,
+			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw24.ts_pll_enable) {
@@ -219,12 +236,8 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
-		  ice_tspll_clk_src_str(dw24.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
+			  true);
 
 	return 0;
 }
@@ -318,12 +331,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
-		  ice_tspll_clk_src_str(dw23.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel,
+			  ro_lock.plllock_true_lock_cri, false);
 
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw23.ts_pll_enable) {
@@ -417,12 +427,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  dw24.ts_pll_enable ? "enabled" : "disabled",
-		  ice_tspll_clk_src_str(dw23.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
+			  true);
 
 	return 0;
 }
-- 
2.49.0


