Return-Path: <netdev+bounces-130331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294CC98A1F0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5301F27CD3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD6191F67;
	Mon, 30 Sep 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lviu25iC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C118E759
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698237; cv=none; b=Tq7yvlmtZzuVL9fM33R8RGWB3AOn35NnwYuOyh1jAxGRXLcm5dI9A36R0EwLp+yTrBrXnUudJVv1MfPmwlgpbSk6HK9LFBwfw+/4bd7yYqnL2wLvbVBv+fCzZFU7MfS+EpK1347hkum4n3xERQ1Lhcgpo6krTiz/quhSeVDLCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698237; c=relaxed/simple;
	bh=z/etYQUZg2F93fRx7yUIfZDt095XfyXuo3OcHlr/h+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bq0lJAqJr4hPnRWuJ21Q0QSG44JUOxjU33iSZBjUtfimWwZBFhAf31+GS1mCgLVYuwWD3DD7eluP/UCMs3XmD0OQguv2WvLUxsl+x7g9E6tUpTJKQatFs/2rsf3m+VJdAVq3qXCeBPq3LfvJNv/KY9eLdXotDZrWej7jtx9QVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lviu25iC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698236; x=1759234236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/etYQUZg2F93fRx7yUIfZDt095XfyXuo3OcHlr/h+E=;
  b=Lviu25iCofTVLIFUU8XC8GzESEr/EBv2xAegWZyu1p0gVx6YIyzSmSI3
   zpKM5aDfSy4a6rIWOxkdiIqjUiVWpnoFZy5GQsBEf1eqZ6HCMnlPFdtrs
   nsviZDQoU7YABW3tlx/G0sCyr28LB5MZP+LUfrWupA/+CIzGGE7ypN6JL
   cZDdJMe0MOK0eyy8DD2atWkMt78jyERhM0gz+DrMmSv+2cKWsz1waifqF
   8yPhxq33TeglHWxwHgnqnXcafahfBDNEzuGm8J+sO38Fx/rdKF8JCCnst
   V5EQKGTim394tqg3kzSMfJ6oj3JI0efGYTE9ypjjvzMNIc2ZbuelQgkLg
   w==;
X-CSE-ConnectionGUID: A6P/l/l0Q7mCUR/3RiPM+Q==
X-CSE-MsgGUID: 4sneKSKWQE+D/VwBOwfQEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26736083"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26736083"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:10:35 -0700
X-CSE-ConnectionGUID: qOmwsekMT5SqXZqwOmGiQw==
X-CSE-MsgGUID: oQZNo0BkTBW3o9GDdHSafQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78037012"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 05:10:33 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net 1/5] ice: Fix E825 initialization
Date: Mon, 30 Sep 2024 14:08:39 +0200
Message-ID: <20240930121022.671217-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121022.671217-1-karol.kolacinski@intel.com>
References: <20240930121022.671217-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation checks revision of all PHYs on all PFs, which is
incorrect and may result in initialization failure. Check only the
revision of the current PHY.

E825 does not need to modify sideband queue access, because those values
are properly set by the firmware on init.
Remove PF_SB_REM_DEV_CTL modification.

Configure synchronization delay for E825 product to ensure proper PHY
timers initialization on SYNC command.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 88 +++++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 2 files changed, 38 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a33e6b9b313..58323a7ff394 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -874,11 +874,38 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 	ice_flush(hw);
 }
 
+/**
+ * ice_ptp_cfg_sync_delay - Configure PHC to PHY synchronization delay
+ * @hw: pointer to HW struct
+ * @delay: delay between PHC and PHY SYNC command execution in nanoseconds
+ */
+static void ice_ptp_cfg_sync_delay(struct ice_hw *hw, u32 delay)
+{
+	wr32(hw, GLTSYN_SYNC_DLAY, delay);
+	ice_flush(hw);
+}
+
 /* 56G PHY device functions
  *
  * The following functions operate on devices with the ETH 56G PHY.
  */
 
+/**
+ * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
+ * @hw: pointer to HW struct
+ *
+ * Perform E825-specific PTP hardware clock initialization steps.
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int ice_ptp_init_phc_e825(struct ice_hw *hw)
+{
+	ice_ptp_cfg_sync_delay(hw, ICE_E825_SYNC_DELAY);
+
+	/* Initialize the Clock Generation Unit */
+	return ice_init_cgu_e82x(hw);
+}
+
 /**
  * ice_write_phy_eth56g - Write a PHY port register
  * @hw: pointer to the HW struct
@@ -2542,42 +2569,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_sb_access_ena_eth56g - Enable SB devices (PHY and others) access
- * @hw: pointer to HW struct
- * @enable: Enable or disable access
- *
- * Enable sideband devices (PHY and others) access.
- */
-static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
-{
-	u32 val = rd32(hw, PF_SB_REM_DEV_CTL);
-
-	if (enable)
-		val |= BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1);
-	else
-		val &= ~(BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1));
-
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-}
-
-/**
- * ice_ptp_init_phc_eth56g - Perform E82X specific PHC initialization
- * @hw: pointer to HW struct
- *
- * Perform PHC initialization steps specific to E82X devices.
- *
- * Return:
- * * %0     - success
- * * %other - failed to initialize CGU
- */
-static int ice_ptp_init_phc_eth56g(struct ice_hw *hw)
-{
-	ice_sb_access_ena_eth56g(hw, true);
-	/* Initialize the Clock Generation Unit */
-	return ice_init_cgu_e82x(hw);
-}
-
 /**
  * ice_ptp_read_tx_hwtstamp_status_eth56g - Get TX timestamp status
  * @hw: pointer to the HW struct
@@ -2665,14 +2656,15 @@ static bool ice_is_muxed_topo(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_init_phy_e825c - initialize PHY parameters
+ * ice_ptp_init_phy_e825 - initialize PHY parameters
  * @hw: pointer to the HW struct
  */
-static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
+static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 {
 	struct ice_ptp_hw *ptp = &hw->ptp;
 	struct ice_eth56g_params *params;
-	u8 phy;
+	u32 phy_rev;
+	int err;
 
 	ptp->phy_model = ICE_PHY_ETH56G;
 	params = &ptp->phy.eth56g;
@@ -2685,17 +2677,9 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
 
-	ice_sb_access_ena_eth56g(hw, true);
-	for (phy = 0; phy < params->num_phys; phy++) {
-		u32 phy_rev;
-		int err;
-
-		err = ice_read_phy_eth56g(hw, phy, PHY_REG_REVISION, &phy_rev);
-		if (err || phy_rev != PHY_REVISION_ETH56G) {
-			ptp->phy_model = ICE_PHY_UNSUP;
-			return;
-		}
-	}
+	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
+	if (err || phy_rev != PHY_REVISION_ETH56G)
+		ptp->phy_model = ICE_PHY_UNSUP;
 
 	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
@@ -5396,7 +5380,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	else if (ice_is_e810(hw))
 		ice_ptp_init_phy_e810(ptp);
 	else if (ice_is_e825c(hw))
-		ice_ptp_init_phy_e825c(hw);
+		ice_ptp_init_phy_e825(hw);
 	else
 		ptp->phy_model = ICE_PHY_UNSUP;
 }
@@ -5835,7 +5819,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 
 	switch (hw->ptp.phy_model) {
 	case ICE_PHY_ETH56G:
-		return ice_ptp_init_phc_eth56g(hw);
+		return ice_ptp_init_phc_e825(hw);
 	case ICE_PHY_E810:
 		return ice_ptp_init_phc_e810(hw);
 	case ICE_PHY_E82X:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..35141198f261 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -326,7 +326,8 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
-#define E810_OUT_PROP_DELAY_NS 1
+#define ICE_E810_OUT_PROP_DELAY_NS	1
+#define ICE_E825_SYNC_DELAY		6
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
-- 
2.46.1


