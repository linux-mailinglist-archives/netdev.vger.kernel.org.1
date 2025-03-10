Return-Path: <netdev+bounces-173479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E9A59274
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E8A1695C4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3928EA;
	Mon, 10 Mar 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8OA+9hq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614D227E82
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741605262; cv=none; b=io130WUE//vKbADLmuidQKCyesu69o1BSVsM85VcaLXCxUZe3wlxNW1oday3gs/cg9WuFuZ2PtfL8hlvP9s+7k0vPAueJ0Im6p7MPDwx8diD1PbH7B3oWZdSVRb8dqnU0d5KYvUQstndjJSFEvL2B1e4Yakykct0/VQE/jdM6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741605262; c=relaxed/simple;
	bh=ddK1LLhKA3F40r922FPivfCVqmd6R1TxlTxVSBEGZPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Outfw9nW7cM3tTWOYQCv/+9ORFaCMD7OA6ptzXLQUUH9417BgLfNct4byoHNPwCMRbesU3GNr4mPgI8zDsc9ON2zNopdIR0nWtiETqGQR5aGtH5TsxiP/+AxYWaqs1NlOSDIynXUdvf84VIbtyDC556B1Bfel6Ob5nZ2aKpe6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8OA+9hq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741605261; x=1773141261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddK1LLhKA3F40r922FPivfCVqmd6R1TxlTxVSBEGZPc=;
  b=m8OA+9hqQieD9z1fuESO2bFbLW1lsrHTajnAYKzla6u6zDVJhs5y9jGD
   nYPQXKgnuCYLDJheCAxakv1YH7KqsHe1TaUnX4qpb+dPc0FCoswT5oiuK
   Vys9GfGONsWVRFWOgxOfxZZtia7156FxzgN+v2JSlg5FbqR7hnenA+OKh
   cZZ0ZwGkqpR1El5VuYmiIJkAHBLqBce8go/OmSBejWHeykiLtIOFshWvH
   t4y9DXLkfwuQimyO1eZEzxPjZKnODyRYhkD6QgthBHk0LEQHHhX5eKhlD
   UnoeuC6THzt8VT72CcLjSf2f5xlm92WqAYiW818+cirW62qRubR5wC2rE
   g==;
X-CSE-ConnectionGUID: BR0c555NSQKD5tQ5ArDy2g==
X-CSE-MsgGUID: aStqJcyFRsWSl4CtKIrvnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="65048679"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="65048679"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 04:14:19 -0700
X-CSE-ConnectionGUID: HuQJ61ShTIirO7F7hymT6A==
X-CSE-MsgGUID: mQoS/s7gSeCmuHrlor5UUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119968317"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2025 04:14:17 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena-olech@intel.com>
Subject: [PATCH iwl-next 04/10] ice: add TSPLL log config helper
Date: Mon, 10 Mar 2025 12:12:48 +0100
Message-ID: <20250310111357.1238454-16-karol.kolacinski@intel.com>
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

Add a helper function to print new/current TSPLL config. This helps
avoid unnecessary casts from u8 to enums.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena-olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 54 ++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 992c22a34ca9..4c929fca510e 100644
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
2.48.1


