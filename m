Return-Path: <netdev+bounces-61040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26328224B0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F58B22178
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF3B17721;
	Tue,  2 Jan 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCP9KmJP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488E171CC
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704234280; x=1735770280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bd3otA6/tJj5vOtlanZFIiHPCAHqcCmMgnpv/k8ZXaE=;
  b=OCP9KmJPhYLxTgntRFWi5lvnt8Ow/Ao855CaSKVwvKko3YyyQrEn9Mgp
   sRyaCGlkbnAiywmt/mv0qKU64dXFLHyKQffQgXP6EK2FvglXMnqmcUIX5
   2jygBAkyYehy/o1DdBvZAU98Y6ed5G1KiHqUEUwT4Ke7RqD78FgZjvRcv
   +AeC5PsChoTb6zz20u4inXiCgn5I1ZrM8kT+tZQtE1uZyliWtt2s/iagL
   o3wg2MxKRBG+kxox7hOqhhAbZbdoFgrJcWt+H14CezwVYDCNmBujZEVU3
   w9tOB8FR94zNfu0+atGnjzIDwTA1WqnMKZPR4qiYI8LzfYSYn6OOxBn0m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3700409"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3700409"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772965455"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="772965455"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2024 14:24:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net-next 2/5] ixgbe: Refactor overtemp event handling
Date: Tue,  2 Jan 2024 14:24:20 -0800
Message-ID: <20240102222429.699129-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
References: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Currently ixgbe driver is notified of overheating events
via internal IXGBE_ERR_OVERTEMP error code.

Change the approach for handle_lasi() to use freshly introduced
is_overtemp function parameter which set when such event occurs.
Change check_overtemp() to bool and return true if overtemp
event occurs.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 21 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 41 +++++++++++--------
 5 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 227415d61efc..687e2b0bb968 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2756,7 +2756,6 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 eicr = adapter->interrupt_event;
-	s32 rc;
 
 	if (test_bit(__IXGBE_DOWN, &adapter->state))
 		return;
@@ -2790,14 +2789,13 @@ static void ixgbe_check_overtemp_subtask(struct ixgbe_adapter *adapter)
 		}
 
 		/* Check if this is not due to overtemp */
-		if (hw->phy.ops.check_overtemp(hw) != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 
 		break;
 	case IXGBE_DEV_ID_X550EM_A_1G_T:
 	case IXGBE_DEV_ID_X550EM_A_1G_T_L:
-		rc = hw->phy.ops.check_overtemp(hw);
-		if (rc != IXGBE_ERR_OVERTEMP)
+		if (!hw->phy.ops.check_overtemp(hw))
 			return;
 		break;
 	default:
@@ -7938,7 +7936,7 @@ static void ixgbe_service_timer(struct timer_list *t)
 static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 status;
+	bool overtemp;
 
 	if (!(adapter->flags2 & IXGBE_FLAG2_PHY_INTERRUPT))
 		return;
@@ -7948,11 +7946,9 @@ static void ixgbe_phy_interrupt_subtask(struct ixgbe_adapter *adapter)
 	if (!hw->phy.ops.handle_lasi)
 		return;
 
-	status = hw->phy.ops.handle_lasi(&adapter->hw);
-	if (status != IXGBE_ERR_OVERTEMP)
-		return;
-
-	e_crit(drv, "%s\n", ixgbe_overheat_msg);
+	hw->phy.ops.handle_lasi(&adapter->hw, &overtemp);
+	if (overtemp)
+		e_crit(drv, "%s\n", ixgbe_overheat_msg);
 }
 
 static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
index ca31638c6fb8..73b9c35acfd7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
@@ -407,8 +407,7 @@ s32 ixgbe_reset_phy_generic(struct ixgbe_hw *hw)
 		return status;
 
 	/* Don't reset PHY if it's shut down due to overtemp. */
-	if (!hw->phy.reset_if_overtemp &&
-	    (IXGBE_ERR_OVERTEMP == hw->phy.ops.check_overtemp(hw)))
+	if (!hw->phy.reset_if_overtemp && hw->phy.ops.check_overtemp(hw))
 		return 0;
 
 	/* Blocked by MNG FW so bail */
@@ -2746,22 +2745,24 @@ static void ixgbe_i2c_bus_clear(struct ixgbe_hw *hw)
  *  @hw: pointer to hardware structure
  *
  *  Checks if the LASI temp alarm status was triggered due to overtemp
+ *
+ *  Return true when an overtemp event detected, otherwise false.
  **/
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw)
 {
 	u16 phy_data = 0;
+	u32 status;
 
 	if (hw->device_id != IXGBE_DEV_ID_82599_T3_LOM)
-		return 0;
+		return false;
 
 	/* Check that the LASI temp alarm status was triggered */
-	hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
-			     MDIO_MMD_PMAPMD, &phy_data);
-
-	if (!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM))
-		return 0;
+	status = hw->phy.ops.read_reg(hw, IXGBE_TN_LASI_STATUS_REG,
+				      MDIO_MMD_PMAPMD, &phy_data);
+	if (status)
+		return false;
 
-	return IXGBE_ERR_OVERTEMP;
+	return !!(phy_data & IXGBE_TN_LASI_STATUS_TEMP_ALARM);
 }
 
 /** ixgbe_set_copper_phy_power - Control power for copper phy
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 6544c4539c0d..ef72729d7c93 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -155,7 +155,7 @@ s32 ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw);
 s32 ixgbe_get_sfp_init_sequence_offsets(struct ixgbe_hw *hw,
 					u16 *list_offset,
 					u16 *data_offset);
-s32 ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
+bool ixgbe_tn_check_overtemp(struct ixgbe_hw *hw);
 s32 ixgbe_read_i2c_byte_generic(struct ixgbe_hw *hw, u8 byte_offset,
 				u8 dev_addr, u8 *data);
 s32 ixgbe_read_i2c_byte_generic_unlocked(struct ixgbe_hw *hw, u8 byte_offset,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 2b00db92b08f..91c9ecca4cb5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3509,10 +3509,10 @@ struct ixgbe_phy_operations {
 	s32 (*read_i2c_sff8472)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*read_i2c_eeprom)(struct ixgbe_hw *, u8 , u8 *);
 	s32 (*write_i2c_eeprom)(struct ixgbe_hw *, u8, u8);
-	s32 (*check_overtemp)(struct ixgbe_hw *);
+	bool (*check_overtemp)(struct ixgbe_hw *);
 	s32 (*set_phy_power)(struct ixgbe_hw *, bool on);
 	s32 (*enter_lplu)(struct ixgbe_hw *);
-	s32 (*handle_lasi)(struct ixgbe_hw *hw);
+	s32 (*handle_lasi)(struct ixgbe_hw *hw, bool *);
 	s32 (*read_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
 				      u8 *value);
 	s32 (*write_i2c_byte_unlocked)(struct ixgbe_hw *, u8 offset, u8 addr,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index b3509b617a4e..e0cf0722b58c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -600,8 +600,10 @@ static s32 ixgbe_setup_fw_link(struct ixgbe_hw *hw)
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_SETUP_LINK, &setup);
 	if (rc)
 		return rc;
+
 	if (setup[0] == FW_PHY_ACT_SETUP_LINK_RSP_DOWN)
-		return IXGBE_ERR_OVERTEMP;
+		return -EIO;
+
 	return 0;
 }
 
@@ -2367,18 +2369,18 @@ static s32 ixgbe_get_link_capabilities_X550em(struct ixgbe_hw *hw,
  * @hw: pointer to hardware structure
  * @lsc: pointer to boolean flag which indicates whether external Base T
  *	 PHY interrupt is lsc
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Determime if external Base T PHY interrupt cause is high temperature
  * failure alarm or link status change.
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
+static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc,
+				       bool *is_overtemp)
 {
 	u32 status;
 	u16 reg;
 
+	*is_overtemp = false;
 	*lsc = false;
 
 	/* Vendor alarm triggered */
@@ -2410,7 +2412,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_HI_TMP_FAIL) {
 		/* power down the PHY in case the PHY FW didn't already */
 		ixgbe_set_copper_phy_power(hw, false);
-		return IXGBE_ERR_OVERTEMP;
+		*is_overtemp = true;
+		return -EIO;
 	}
 	if (reg & IXGBE_MDIO_GLOBAL_ALM_1_DEV_FAULT) {
 		/*  device fault alarm triggered */
@@ -2424,7 +2427,8 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
 		if (reg == IXGBE_MDIO_GLOBAL_FAULT_MSG_HI_TMP) {
 			/* power down the PHY in case the PHY FW didn't */
 			ixgbe_set_copper_phy_power(hw, false);
-			return IXGBE_ERR_OVERTEMP;
+			*is_overtemp = true;
+			return -EIO;
 		}
 	}
 
@@ -2460,12 +2464,12 @@ static s32 ixgbe_get_lasi_ext_t_x550em(struct ixgbe_hw *hw, bool *lsc)
  **/
 static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 {
+	bool lsc, overtemp;
 	u32 status;
 	u16 reg;
-	bool lsc;
 
 	/* Clear interrupt flags */
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, &overtemp);
 
 	/* Enable link status change alarm */
 
@@ -2544,21 +2548,20 @@ static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
 /**
  * ixgbe_handle_lasi_ext_t_x550em - Handle external Base T PHY interrupt
  * @hw: pointer to hardware structure
+ * @is_overtemp: indicate whether an overtemp event encountered
  *
  * Handle external Base T PHY interrupt. If high temperature
  * failure alarm then return error, else if link status change
  * then setup internal/external PHY link
- *
- * Return IXGBE_ERR_OVERTEMP if interrupt is high temperature
- * failure alarm, else return PHY access status.
  **/
-static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw)
+static s32 ixgbe_handle_lasi_ext_t_x550em(struct ixgbe_hw *hw,
+					  bool *is_overtemp)
 {
 	struct ixgbe_phy_info *phy = &hw->phy;
 	bool lsc;
 	u32 status;
 
-	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc);
+	status = ixgbe_get_lasi_ext_t_x550em(hw, &lsc, is_overtemp);
 	if (status)
 		return status;
 
@@ -3185,21 +3188,23 @@ static s32 ixgbe_reset_phy_fw(struct ixgbe_hw *hw)
 /**
  * ixgbe_check_overtemp_fw - Check firmware-controlled PHYs for overtemp
  * @hw: pointer to hardware structure
+ *
+ * Return true when an overtemp event detected, otherwise false.
  */
-static s32 ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
+static bool ixgbe_check_overtemp_fw(struct ixgbe_hw *hw)
 {
 	u32 store[FW_PHY_ACT_DATA_COUNT] = { 0 };
 	s32 rc;
 
 	rc = ixgbe_fw_phy_activity(hw, FW_PHY_ACT_GET_LINK_INFO, &store);
 	if (rc)
-		return rc;
+		return false;
 
 	if (store[0] & FW_PHY_ACT_GET_LINK_INFO_TEMP) {
 		ixgbe_shutdown_fw_phy(hw);
-		return IXGBE_ERR_OVERTEMP;
+		return true;
 	}
-	return 0;
+	return false;
 }
 
 /**
-- 
2.41.0


