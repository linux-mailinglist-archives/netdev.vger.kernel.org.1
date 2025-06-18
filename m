Return-Path: <netdev+bounces-199174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B33ADF4E3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AA77A6A47
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE592FCFC0;
	Wed, 18 Jun 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0AI+59f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3752FCE39
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268571; cv=none; b=T+Vc2iQ35Xsvi5oesExzIB8hijB4eTTD1RMTWCPIDhRztJ5w0WarDCz6E8UOUPbCOBgWHpfFGyraN9YuMvUcGvOHaLD6Jc/mMjpQWl6MRGb22KBv1+kUiUOYiO1joimYJY75XTHuzhKbhUDy7FH34xwdOVTuenAr+YCZ3xOVbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268571; c=relaxed/simple;
	bh=4d4XH/+HK9R8KUKGQznmA7c3eJShoMSNXblqL9FkGmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkkctZbLEp2dhOKrrNCVKjLP4bZYCRrUVju5bwdS9hnrHSpG+q+0NxqBSI+ZaKiD5Djj0mj/RG8SVj+7d9Q4LIC1aER62Dfa1I5VqjyJu5RKJ6Jmm1cv/ToheYh4EdP/7qr5IUMteTZQBtTGjFHmFrPfRDIsjVJhTEQD6QDXbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0AI+59f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268570; x=1781804570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4d4XH/+HK9R8KUKGQznmA7c3eJShoMSNXblqL9FkGmw=;
  b=C0AI+59fHC74LYJwDb9pA6oehlushtOPM2gQx5RSKEVeBhPLBUWWhrs/
   0ImByM9GYd3D9p2wBRVzS3pM2PvqIn74KJ953c28ruz9+r6WfyBGtS4x2
   NrJa9/ef0N0WfXhMfC55VX3oqNO3oBAXiWUjD3TWMBqBh+vk6C4XvT2KI
   scq367BCOU8en8zoNImLRDIV99i5O0VK27WY3ga3ewknWTT6GdFjCmAJy
   LTydSLzhlB5Lo/brAIQwdxR+DRnWxDL0Ca1X6VoopCMm3Ui+ec4pZTB5+
   wiNv9YuWaWoIefRc0s5THyOAodnBAH2hpGrkpzGy0In6RlWN5RqwXK2uY
   Q==;
X-CSE-ConnectionGUID: ggQKlPn+Rv2OpXhkk8cfWA==
X-CSE-MsgGUID: WMJtUZdmSqmTYXvxR4tyGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183685"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183685"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:47 -0700
X-CSE-ConnectionGUID: I+wQOvgpS4+k3jSh45vLOg==
X-CSE-MsgGUID: Cf+Vm9ikScqYI9XZaMECYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695859"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	karol.kolacinski@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 03/15] ice: fix E825-C TSPLL register definitions
Date: Wed, 18 Jun 2025 10:42:15 -0700
Message-ID: <20250618174231.3100231-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The E825-C hardware has a slightly different register layout for register
19 of the Clock Generation Unit and TSPLL. The fbdiv_intgr value can be 10
bits wide.

Additionally, most of the fields that were in register 24 are made
available in register 23 instead. The programming logic already has a
corrected definition for register 23, but it incorrectly still used the
8-bit definition of fbdiv_intgr. This results in truncating some of the
values of fbdiv_intgr, including the value used for the 156.25MHz signal.

The driver only used register 24 to obtain the enable status, which we
should read from register 23. This results in an incorrect output for the
log messages, but does not change any functionality besides
disabled-by-default dynamic debug messages.

Fix the register definitions, and adjust the code to properly reflect the
enable/disable status in the log messages.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h | 17 ++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_tspll.c  | 17 +++++++----------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 8aa370e6c0f1..ed375babcde3 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -74,7 +74,7 @@ union ice_cgu_r16 {
 };
 
 #define ICE_CGU_R19 0x4c
-union ice_cgu_r19 {
+union ice_cgu_r19_e82x {
 	struct {
 		u32 fbdiv_intgr : 8;
 		u32 fdpll_ulck_thr : 5;
@@ -89,6 +89,21 @@ union ice_cgu_r19 {
 	u32 val;
 };
 
+union ice_cgu_r19_e825 {
+	struct {
+		u32 tspll_fbdiv_intgr : 10;
+		u32 fdpll_ulck_thr : 5;
+		u32 misc15 : 1;
+		u32 tspll_ndivratio : 4;
+		u32 tspll_iref_ndivratio : 3;
+		u32 misc19 : 1;
+		u32 japll_ndivratio : 4;
+		u32 japll_postdiv_pdivratio : 3;
+		u32 misc27 : 1;
+	};
+	u32 val;
+};
+
 #define ICE_CGU_R22 0x58
 union ice_cgu_r22 {
 	struct {
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 2fe619214a1a..74a9fc35fb1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -230,7 +230,7 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			      enum ice_clk_src clk_src)
 {
 	union tspll_ro_bwm_lf bwm_lf;
-	union ice_cgu_r19 dw19;
+	union ice_cgu_r19_e82x dw19;
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
@@ -398,9 +398,9 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 			       enum ice_clk_src clk_src)
 {
 	union tspll_ro_lock_e825c ro_lock;
+	union ice_cgu_r19_e825 dw19;
 	union ice_cgu_r16 dw16;
 	union ice_cgu_r23 dw23;
-	union ice_cgu_r19 dw19;
 	union ice_cgu_r22 dw22;
 	union ice_cgu_r24 dw24;
 	union ice_cgu_r9 dw9;
@@ -428,10 +428,6 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	err = ice_read_cgu_reg(hw, ICE_CGU_R24, &dw24.val);
-	if (err)
-		return err;
-
 	err = ice_read_cgu_reg(hw, ICE_CGU_R16, &dw16.val);
 	if (err)
 		return err;
@@ -446,7 +442,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "Current TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
+		  str_enabled_disabled(dw23.ts_pll_enable),
 		  ice_tspll_clk_src_str(dw23.time_ref_sel),
 		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
@@ -486,8 +482,8 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
-	dw19.fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
-	dw19.ndivratio = e825c_tspll_params[clk_freq].ndivratio;
+	dw19.tspll_fbdiv_intgr = e825c_tspll_params[clk_freq].fbdiv_intgr;
+	dw19.tspll_ndivratio = e825c_tspll_params[clk_freq].ndivratio;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R19, dw19.val);
 	if (err)
@@ -518,6 +514,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	if (err)
 		return err;
 
+	dw24.val = 0;
 	dw24.fbdiv_frac = e825c_tspll_params[clk_freq].fbdiv_frac;
 
 	err = ice_write_cgu_reg(hw, ICE_CGU_R24, dw24.val);
@@ -545,7 +542,7 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 
 	/* Log the current clock configuration */
 	ice_debug(hw, ICE_DBG_PTP, "New TSPLL configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
-		  str_enabled_disabled(dw24.ts_pll_enable),
+		  str_enabled_disabled(dw23.ts_pll_enable),
 		  ice_tspll_clk_src_str(dw23.time_ref_sel),
 		  ice_tspll_clk_freq_str(dw9.time_ref_freq_sel),
 		  ro_lock.plllock_true_lock_cri ? "locked" : "unlocked");
-- 
2.47.1


