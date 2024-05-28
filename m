Return-Path: <netdev+bounces-98805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00C8D287E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA93B26F73
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4213EFFB;
	Tue, 28 May 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7FpaQmC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AA13CABA
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937453; cv=none; b=kGrQCVKVtp5aK+s2aUGRqLDiAAQuuxMC9q3rUDHJv3cmgBXJavRbPaSXeAIqHp79kwvYbBfpX5E28eoqosUDs3aRmQ0pphHrytsLR5z+lwXtK8eeY8f+oTSpktvmif4/UXCE7rEgh2FgScukgrK/OrnYGfzjjioRviPXfZDH66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937453; c=relaxed/simple;
	bh=ly9cvo04lbBU7aTHNKHNVXIYpasAvG4rkb5BiKKWxfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aOWUQNUiBUuG/svK+Mb2mA6GMdZUR1S0qoAu51ZocwtBplGEpOo268HirPPJk7MGx+s6/bzHW7ZdrtlZMhdSzdYYfu/C0QArsWYSSvkuNrXrq8NFYZojF1qr7OveHFtqV5li4rD61+pJjYyCTQ8hNbNnLVI2mU3SKbfA4fh33hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7FpaQmC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937452; x=1748473452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ly9cvo04lbBU7aTHNKHNVXIYpasAvG4rkb5BiKKWxfM=;
  b=f7FpaQmCRnZyzcYzSRW4s9yHc8zvbwo4zNIz8QP2QOXN1IP4JmhhIR5O
   DPv0tZ7eo7mDircS15+eNqP7Zj+knYtDIhd0KBI3fEw50MFlJxoc3YXE2
   cBKCAlGuRfTEkNMQ8a1vT2dxUQBJja37VTzt7Tk1JOZJGtZMEz8NGvleo
   55t2TTkrXqtdPpWMsu+5PSenv9rQlPlCoBxG7tcjP+bJgyLYdrnQqtvsN
   7n0tOpNsYxqyWfOkFbUggJDFnTJR1Ko6omrV1qjV3pnEt1ojbzvIQBdaX
   hW0hXnWBUfwGajAJliTAtu8EkJon3QnFBAnXA5zQPNzrXc0L1jUhlhDpX
   w==;
X-CSE-ConnectionGUID: Zfcp848iQL6gQnyoSvvI+Q==
X-CSE-MsgGUID: LuoPWVZPRViqhsbg94GhDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13444865"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13444865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:11 -0700
X-CSE-ConnectionGUID: ts+71CbGR5GYQtVzYwaGHQ==
X-CSE-MsgGUID: JnWg72IGRK6r1ixhCCzUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39672280"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:10 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 16:03:52 -0700
Subject: [PATCH next 02/11] ice: Introduce helper to get tmr_cmd_reg values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-next-2024-05-28-ptp-refactors-v1-2-c082739bb6f6@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

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

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 166 +++++++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +-
 2 files changed, 102 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 22fca17a5a3c..43aa83bc54c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -226,6 +226,104 @@ static u64 ice_ptp_read_src_incval(struct ice_hw *hw)
 	return ((u64)(hi & INCVAL_HIGH_M) << 32) | lo;
 }
 
+/**
+ * ice_ptp_tmr_cmd_to_src_reg - Convert to source timer command value
+ * @hw: pointer to HW struct
+ * @cmd: Timer command
+ *
+ * Return: the source timer command register value for the given PTP timer
+ * command.
+ */
+static u32 ice_ptp_tmr_cmd_to_src_reg(struct ice_hw *hw,
+				      enum ice_ptp_tmr_cmd cmd)
+{
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
+
+	tmr_idx = ice_get_ptp_src_clock_index(hw);
+
+	return tmr_idx << SEL_CPK_SRC | cmd_val;
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
+ * Return: the PHY port timer command register value for the given PTP timer
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
+
+	switch (cmd) {
+	case ICE_PTP_INIT_TIME:
+		cmd_val = PHY_CMD_INIT_TIME;
+		break;
+	case ICE_PTP_INIT_INCVAL:
+		cmd_val = PHY_CMD_INIT_INCVAL;
+		break;
+	case ICE_PTP_ADJ_TIME:
+		cmd_val = PHY_CMD_ADJ_TIME;
+		break;
+	case ICE_PTP_ADJ_TIME_AT_TIME:
+		cmd_val = PHY_CMD_ADJ_TIME_AT_TIME;
+		break;
+	case ICE_PTP_READ_TIME:
+		cmd_val = PHY_CMD_READ_TIME;
+		break;
+	case ICE_PTP_NOP:
+		cmd_val = 0;
+		break;
+	default:
+		dev_warn(ice_hw_to_dev(hw),
+			 "Ignoring unrecognized timer command %u\n", cmd);
+		cmd_val = 0;
+	}
+
+	tmr_idx = ice_get_ptp_src_clock_index(hw);
+
+	return tmr_idx << SEL_PHY_SRC | cmd_val;
+}
+
 /**
  * ice_ptp_src_cmd - Prepare source timer for a timer command
  * @hw: pointer to HW structure
@@ -235,31 +333,7 @@ static u64 ice_ptp_read_src_incval(struct ice_hw *hw)
  */
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
-	u32 cmd_val;
-	u8 tmr_idx;
-
-	tmr_idx = ice_get_ptp_src_clock_index(hw);
-	cmd_val = tmr_idx << SEL_CPK_SRC;
-
-	switch (cmd) {
-	case ICE_PTP_INIT_TIME:
-		cmd_val |= GLTSYN_CMD_INIT_TIME;
-		break;
-	case ICE_PTP_INIT_INCVAL:
-		cmd_val |= GLTSYN_CMD_INIT_INCVAL;
-		break;
-	case ICE_PTP_ADJ_TIME:
-		cmd_val |= GLTSYN_CMD_ADJ_TIME;
-		break;
-	case ICE_PTP_ADJ_TIME_AT_TIME:
-		cmd_val |= GLTSYN_CMD_ADJ_INIT_TIME;
-		break;
-	case ICE_PTP_READ_TIME:
-		cmd_val |= GLTSYN_CMD_READ_TIME;
-		break;
-	case ICE_PTP_NOP:
-		break;
-	}
+	u32 cmd_val = ice_ptp_tmr_cmd_to_src_reg(hw, cmd);
 
 	wr32(hw, GLTSYN_CMD, cmd_val);
 }
@@ -3029,47 +3103,9 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
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
2.44.0.53.g0f9d4d28b7e6


