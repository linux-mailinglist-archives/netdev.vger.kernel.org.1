Return-Path: <netdev+bounces-83251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFCB891795
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2391C22A7F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540306A346;
	Fri, 29 Mar 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FO+1ulVy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A97913AF2
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711431; cv=none; b=rarnNrVCKsF9+oY8v/jiBzyGFC2Oz4aSjSJ6jWtO6V445ADMFRsnAncYjSDYz2fuInS4nDqkUq9/JngS2A5I9F2VG8rn4TeUc5GI5tRDHIoGAFpkEJddGM/qhUj+9L1DGwgY/taigcIml/L2BLVPD/DY9KIgQ6lCdUd68OXPKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711431; c=relaxed/simple;
	bh=+FNXSIdp4PgvGGhy6YrPwX+eUbvzDZcSoeepn2O5ZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk+4swS4VUTk0p7vaxwGBeNpLY+9XeETCSI7R0pYaEmw4fSv6DbCndQb/qvH8Kl0v2zGW7iESr9m7Nznu/1VIsjX3hb7scrKCZHpPXD0qQzG9vW3nvmosC5mqJdCeORikDnFZcYMvbDQCUqdgrTpv8KXKPwkcmkhBaMTX2rVn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FO+1ulVy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711429; x=1743247429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+FNXSIdp4PgvGGhy6YrPwX+eUbvzDZcSoeepn2O5ZOk=;
  b=FO+1ulVy0f7ETD7IjLYz+TcTv2TEaYtfTQcodTCAwV1XwY9rkeF0jKbd
   iUOM2Ll8BM06ZDUJyvvaY0fNLYJeWEnKZjNhANcT8za4W4wuPUa0bXg2d
   LKZN92me5AHR0WlaLUUhaDGCsImUwUFmqSn4/MUFXwQad1N7aeuLzJ3e8
   m4qv+oiBBHCOOT6t9BT+j6J3+lKgknHpj6zIXq96Amvsxtsjx5YEVlgvc
   0irv31kguuGK7vOtv45S0/TnmFIXvv7K83sw6NXQee79G3PkjmjZmm7pc
   W0Sq7oG4r89YWGqNKI/R0r2yKte1QETOSgR3A4Xo/112CQdiXyxT/V+ed
   A==;
X-CSE-ConnectionGUID: aX7RxVoRRXWuvhf6mscWeQ==
X-CSE-MsgGUID: LfNV3LgrTIGONKARfDtNLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755179"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6755179"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:23:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16836693"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2024 04:23:47 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 02/12] ice: Introduce helper to get tmr_cmd_reg values
Date: Fri, 29 Mar 2024 12:21:46 +0100
Message-ID: <20240329112339.29642-16-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329112339.29642-14-karol.kolacinski@intel.com>
References: <20240329112339.29642-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Multiple places in the driver code need to convert enum ice_ptp_tmr_cmd
values into register bits for both the main timer and the PHY port
timers. The main MAC register has one bit scheme for timer commands,
while the PHY commands use a different scheme.

The E810 and E830 devices use the same scheme for port commands as used
for the main timer. However, E822 and ETH56G hardware has a separate
scheme used by the PHY.

Introduce helper functions to convert the timer command enumeration into
the register values, reducing some code duplication, and making it
easier to later refactor the individual port write commands.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 140 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +-
 2 files changed, 89 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e86ca6cada79..c892b966c3b8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -227,40 +227,114 @@ static u64 ice_ptp_read_src_incval(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_src_cmd - Prepare source timer for a timer command
- * @hw: pointer to HW structure
+ * ice_ptp_tmr_cmd_to_src_reg - Convert to source timer command value
+ * @hw: pointer to HW struct
  * @cmd: Timer command
  *
- * Prepare the source timer for an upcoming timer sync command.
+ * Returns: the source timer command register value for the given PTP timer
+ * command.
  */
-void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
+static u32 ice_ptp_tmr_cmd_to_src_reg(struct ice_hw *hw,
+				      enum ice_ptp_tmr_cmd cmd)
 {
-	u32 cmd_val;
-	u8 tmr_idx;
+	u32 cmd_val, tmr_idx;
+
+	switch (cmd) {
+	case ICE_PTP_INIT_TIME:
+		cmd_val = GLTSYN_CMD_INIT_TIME;
+		break;
+	case ICE_PTP_INIT_INCVAL:
+		cmd_val = GLTSYN_CMD_INIT_INCVAL;
+		break;
+	case ICE_PTP_ADJ_TIME:
+		cmd_val = GLTSYN_CMD_ADJ_TIME;
+		break;
+	case ICE_PTP_ADJ_TIME_AT_TIME:
+		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
+		break;
+	case ICE_PTP_NOP:
+	case ICE_PTP_READ_TIME:
+		cmd_val = GLTSYN_CMD_READ_TIME;
+		break;
+	default:
+		dev_warn(ice_hw_to_dev(hw),
+			 "Ignoring unrecognized timer command %u\n", cmd);
+		cmd_val = 0;
+	}
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	cmd_val = tmr_idx << SEL_CPK_SRC;
+
+	return tmr_idx | cmd_val << SEL_CPK_SRC;
+}
+
+/**
+ * ice_ptp_tmr_cmd_to_port_reg- Convert to port timer command value
+ * @hw: pointer to HW struct
+ * @cmd: Timer command
+ *
+ * Note that some hardware families use a different command register value for
+ * the PHY ports, while other hardware families use the same register values
+ * as the source timer.
+ *
+ * Returns: the PHY port timer command register value for the given PTP timer
+ * command.
+ */
+static u32 ice_ptp_tmr_cmd_to_port_reg(struct ice_hw *hw,
+				       enum ice_ptp_tmr_cmd cmd)
+{
+	u32 cmd_val, tmr_idx;
+
+	/* Certain hardware families share the same register values for the
+	 * port register and source timer register.
+	 */
+	switch (hw->ptp.phy_model) {
+	case ICE_PHY_E810:
+		return ice_ptp_tmr_cmd_to_src_reg(hw, cmd) & TS_CMD_MASK_E810;
+	default:
+		break;
+	}
 
 	switch (cmd) {
 	case ICE_PTP_INIT_TIME:
-		cmd_val |= GLTSYN_CMD_INIT_TIME;
+		cmd_val = PHY_CMD_INIT_TIME;
 		break;
 	case ICE_PTP_INIT_INCVAL:
-		cmd_val |= GLTSYN_CMD_INIT_INCVAL;
+		cmd_val = PHY_CMD_INIT_INCVAL;
 		break;
 	case ICE_PTP_ADJ_TIME:
-		cmd_val |= GLTSYN_CMD_ADJ_TIME;
+		cmd_val = PHY_CMD_ADJ_TIME;
 		break;
 	case ICE_PTP_ADJ_TIME_AT_TIME:
-		cmd_val |= GLTSYN_CMD_ADJ_INIT_TIME;
+		cmd_val = PHY_CMD_ADJ_TIME_AT_TIME;
 		break;
 	case ICE_PTP_READ_TIME:
-		cmd_val |= GLTSYN_CMD_READ_TIME;
+		cmd_val = PHY_CMD_READ_TIME;
 		break;
 	case ICE_PTP_NOP:
+		cmd_val = 0;
 		break;
+	default:
+		dev_warn(ice_hw_to_dev(hw),
+			 "Ignoring unrecognized timer command %u\n", cmd);
+		cmd_val = 0;
 	}
 
+	tmr_idx = ice_get_ptp_src_clock_index(hw);
+
+	return tmr_idx | cmd_val << SEL_PHY_SRC;
+}
+
+/**
+ * ice_ptp_src_cmd - Prepare source timer for a timer command
+ * @hw: pointer to HW structure
+ * @cmd: Timer command
+ *
+ * Prepare the source timer for an upcoming timer sync command.
+ */
+void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
+{
+	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
+
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
 
@@ -3023,47 +3097,9 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
  */
 static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
-	u32 cmd_val, val;
-	int err;
+	u32 val = ice_ptp_tmr_cmd_to_port_reg(hw, cmd);
 
-	switch (cmd) {
-	case ICE_PTP_INIT_TIME:
-		cmd_val = GLTSYN_CMD_INIT_TIME;
-		break;
-	case ICE_PTP_INIT_INCVAL:
-		cmd_val = GLTSYN_CMD_INIT_INCVAL;
-		break;
-	case ICE_PTP_ADJ_TIME:
-		cmd_val = GLTSYN_CMD_ADJ_TIME;
-		break;
-	case ICE_PTP_READ_TIME:
-		cmd_val = GLTSYN_CMD_READ_TIME;
-		break;
-	case ICE_PTP_ADJ_TIME_AT_TIME:
-		cmd_val = GLTSYN_CMD_ADJ_INIT_TIME;
-		break;
-	case ICE_PTP_NOP:
-		return 0;
-	}
-
-	/* Read, modify, write */
-	err = ice_read_phy_reg_e810(hw, ETH_GLTSYN_CMD, &val);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read GLTSYN_CMD, err %d\n", err);
-		return err;
-	}
-
-	/* Modify necessary bits only and perform write */
-	val &= ~TS_CMD_MASK_E810;
-	val |= cmd_val;
-
-	err = ice_write_phy_reg_e810(hw, ETH_GLTSYN_CMD, val);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to write back GLTSYN_CMD, err %d\n", err);
-		return err;
-	}
-
-	return 0;
+	return ice_write_phy_reg_e810(hw, E810_ETH_GLTSYN_CMD, val);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 3dce09af0d78..6246de3bacf3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -485,7 +485,7 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 #define ETH_GLTSYN_SHADJ_H(_i)		(0x0300037C + ((_i) * 32))
 
 /* E810 timer command register */
-#define ETH_GLTSYN_CMD			0x03000344
+#define E810_ETH_GLTSYN_CMD		0x03000344
 
 /* Source timer incval macros */
 #define INCVAL_HIGH_M			0xFF
-- 
2.43.0


