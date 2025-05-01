Return-Path: <netdev+bounces-187324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAFAA667F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C51417435E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C12676C4;
	Thu,  1 May 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2fhs63J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF7264F91
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140078; cv=none; b=bIi4pPltDajL2saT9oZy51ObdgkeISwM9vj8LBNHi1v2phkNKta2M4ftgH4ZzDrnE16tBaJBVto987fpr6EOw8030cLXBHmx0zmK2OL0hhEGmdoWN1WwLhZryyRCP7v29btVLeT71jpxrtDc8xdPFAKhyy+UUWpC3I8Un633j0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140078; c=relaxed/simple;
	bh=UrKKInting1us4tXjzoiD31K1N75PAD497MNonaoC6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfYJtwdIRbkw1apGDfcLgSkZpdUMdTXJ5dbvHprI1gZrUzjO/hfzRhcUGez5Qjl/oGmbbuWgnpx1KKRPicgE8x8w0GxgxoxprJjP0Fq3xqTYIj2OLH+kkKlbeGfQS0f3zf4I681KylH2gZQrUmxs+kWvyn99pz4yQ317I5k7s4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2fhs63J; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140077; x=1777676077;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UrKKInting1us4tXjzoiD31K1N75PAD497MNonaoC6k=;
  b=R2fhs63Jl2YYPUJMf8Je0onN6BytD5fGg9mQn8Ma/Pmvq01IF5aFvizs
   SRAx4ICe/ZpZ+QOtjJ8q5hdgTcIBt1fjcT7B8KReL2UjldHmwga4gblUz
   lO2xIFemsgBWmvsQ1HTA/DGPx5Xv2B9euUbnMe77NXoN2vRHkXgDDbxFd
   DRPZdKXZEfcpA8oDQP9osu/NvhJ4HQDhwFYRiOQkAADkFRxNQQ+AJDl1Y
   K3jdfvl3SRYA7mqfnpzRFdyayiyv3rX0Awym6xle8NTEFrHPvrVvCTHul
   3exjpoy2o+lzlaPIaDd+skg7GzgQQvl9M1Z4vovdEjX1W78NtcK3YJ6Mq
   A==;
X-CSE-ConnectionGUID: 0zFEcVHGT7y3AdM2nC1Ybg==
X-CSE-MsgGUID: 23cTQHQvSvOCAFTHN7rsiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811722"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811722"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:34 -0700
X-CSE-ConnectionGUID: jeTR6PGeTsqmAeYIeaCbKw==
X-CSE-MsgGUID: F3vUQKlaSu2dk8ruvKR55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514287"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:33 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:17 -0700
Subject: [PATCH v4 06/15] ice: add TSPLL log config helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-6-24c83d0ce7a8@intel.com>
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

Add a helper function to print new/current TSPLL config. This helps
avoid unnecessary casts from u8 to enums.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 54 +++++++++++++++++-------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index cf0e37296796c5bbda011d027dc8ef007b0e2021..08af4ced50eb877dce5944d87a90d0dcdb49ff2e 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -89,6 +89,26 @@ static const char *ice_tspll_clk_src_str(enum ice_clk_src clk_src)
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
+		new_cfg ? "New" : "Current", str_enabled_disabled(enable),
+		ice_tspll_clk_src_str((enum ice_clk_src)clk_src),
+		ice_tspll_clk_freq_str((enum ice_tspll_freq)tspll_freq),
+		lock ? "locked" : "unlocked");
+}
+
 /**
  * ice_tspll_cfg_e82x - Configure the Clock Generation Unit TSPLL
  * @hw: Pointer to the HW struct
@@ -144,12 +164,9 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
-		  ice_tspll_clk_src_str(dw24.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, dw24.time_ref_sel,
+			  dw9.time_ref_freq_sel, bwm_lf.plllock_true_lock_cri,
+			  false);
 
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw24.ts_pll_enable) {
@@ -222,12 +239,8 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
-		  ice_tspll_clk_src_str(dw24.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw24.ts_pll_enable, clk_src, clk_freq, true,
+			  true);
 
 	return 0;
 }
@@ -316,12 +329,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw23.ts_pll_enable),
-		  ice_tspll_clk_src_str(dw23.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, dw23.time_ref_sel,
+			  dw9.time_ref_freq_sel,
+			  ro_lock.plllock_true_lock_cri, false);
 
 	/* Disable the PLL before changing the clock source or frequency */
 	if (dw23.ts_pll_enable) {
@@ -414,12 +424,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 		return -EBUSY;
 	}
 
-	/* Log the current clock configuration */
-	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw23.ts_pll_enable),
-		  ice_tspll_clk_src_str(dw23.time_ref_sel),
-		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
-		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
+	ice_tspll_log_cfg(hw, dw23.ts_pll_enable, clk_src, clk_freq, true,
+			  true);
 
 	return 0;
 }

-- 
2.48.1.397.gec9d649cc640


