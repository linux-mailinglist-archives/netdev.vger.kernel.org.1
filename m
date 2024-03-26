Return-Path: <netdev+bounces-82169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F7A88C919
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D32B2989E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A5F13C9DE;
	Tue, 26 Mar 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTmyCDDX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57013CC6E
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470248; cv=none; b=Rmc2ic6CFZ3ansOt/ccAR1HibkaJO2TMOvIedn0rPv59kKTgxTy6wBmmtuM1lqsoBLzO1218V+EOaj1nQiPbRX0ML6iDGri7NUCYU4U0sZLl6iqUhYrV+46rk/iuBL3GcTvZnqPZj9OLt6e3ofzea7qHPFHgX1kA8Bgq/Foy+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470248; c=relaxed/simple;
	bh=cTtSOWGEMGlZwvpydwUYqxLutxkfBtFX6VXUgtc1ed8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxqWqYHCEW8S7PZN6NC0/3SIBm/5qCWmoqtGoC6LnMsAnYZE8eU6Z2Q5OyDyEvrkUhviRRm4etQ/S7sMulxXA/neF5XlWqLiiz7G/fjLZpglv0AY8UAGrOT5zjk8C7n+6wA154u0QUZNCjnLxNqDC/wGJOwVxC53f/VS9uvy/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTmyCDDX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470246; x=1743006246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTtSOWGEMGlZwvpydwUYqxLutxkfBtFX6VXUgtc1ed8=;
  b=PTmyCDDXkkWsAyjXJCyc4ravslC5WbC8H36VN/BcoobKqhzT2SNLad6Z
   d2ywAJAH11FAqVD3zDxyJ8DaPAkQeCPZ4eaI82pAgl1rmzLuxHmNJ87TZ
   kC/rG+fqmv06O0rBairfW+wVLXJMtCPcrxw4DhR6+JHbMOHrvQ5nH0a8/
   GBTVX9nSLASXJ0ftoY3+M9a18ADS/0VsJtEN05mT3kA6QCmX10XV65Duw
   Qu/CDGKq0jaglwweyq7r3iqQgCgQdDyVXT7pXJUcPISZCOG8TzAx3ZSp1
   Fl8db0ARAPPKchoXaI2TpH73ToBQbrRYuxSuVzlhrVuv0lN/QYZyrIfMq
   Q==;
X-CSE-ConnectionGUID: QIomG4yMTRmW9Wy3vyofIg==
X-CSE-MsgGUID: KL58MOi4SL+FpoyC1Hw5vA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6725022"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6725022"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20729272"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 09:24:03 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 03/12] ice: Implement Tx interrupt enablement functions
Date: Tue, 26 Mar 2024 17:22:24 +0100
Message-ID: <20240326162339.146053-17-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326162339.146053-14-karol.kolacinski@intel.com>
References: <20240326162339.146053-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Introduce functions enabling/disabling Tx TS interrupts
for the E822 and ETH56G PHYs

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 63 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  4 +-
 3 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1df86ee899cd..871f13763633 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1476,42 +1476,43 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
  * @ena: bool value to enable or disable interrupt
  * @threshold: Minimum number of packets at which intr is triggered
  *
- * Utility function to enable or disable Tx timestamp interrupt and threshold
+ * Utility function to configure all the PHY interrupt settings, including
+ * whether the PHY interrupt is enabled, and what threshold to use. Also
+ * configures The E82X timestamp owner to react to interrupts from all PHYs.
  */
 static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 {
+	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int err = 0;
-	int quad;
-	u32 val;
 
 	ice_ptp_reset_ts_memory(hw);
 
-	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++) {
-		err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG,
-					     &val);
-		if (err)
-			break;
-
-		if (ena) {
-			val |= Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
-			val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_THR_M;
-			val |= FIELD_PREP(Q_REG_TX_MEM_GBL_CFG_INTR_THR_M,
-					  threshold);
-		} else {
-			val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
+	switch (hw->ptp.phy_model) {
+	case ICE_PHY_E82X: {
+		int quad;
+
+		for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports);
+		     quad++) {
+			int err;
+
+			err = ice_phy_cfg_intr_e82x(hw, quad, ena, threshold);
+			if (err) {
+				dev_err(dev, "Failed to configure PHY interrupt for quad %d, err %d\n",
+					quad, err);
+				return err;
+			}
 		}
 
-		err = ice_write_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG,
-					      val);
-		if (err)
-			break;
+		return 0;
+	}
+	case ICE_PHY_E810:
+		return 0;
+	case ICE_PHY_UNSUP:
+	default:
+		dev_warn(dev, "%s: Unexpected PHY model %d\n", __func__,
+			 hw->ptp.phy_model);
+		return -EOPNOTSUPP;
 	}
-
-	if (err)
-		dev_err(ice_pf_to_dev(pf), "PTP failed in intr ena, err %d\n",
-			err);
-	return err;
 }
 
 /**
@@ -3035,12 +3036,10 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
 
-	if (!ice_is_e810(hw)) {
-		/* Enable quad interrupts */
-		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
-		if (err)
-			goto err_exit;
-	}
+	/* Configure PHY interrupt settings */
+	err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
+	if (err)
+		goto err_exit;
 
 	/* Ensure we have a clock device */
 	err = ice_ptp_create_clock(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 8f9828831893..d68453347789 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2712,6 +2712,37 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
 	return 0;
 }
 
+/**
+ * ice_phy_cfg_intr_e82x - Configure TX timestamp interrupt
+ * @hw: pointer to the HW struct
+ * @quad: the timestamp quad
+ * @ena: enable or disable interrupt
+ * @threshold: interrupt threshold
+ *
+ * Configure TX timestamp interrupt for the specified quad
+ */
+
+int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold)
+{
+	int err;
+	u32 val;
+
+	err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, &val);
+	if (err)
+		return err;
+
+	val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
+	if (ena) {
+		val |= Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M;
+		val &= ~Q_REG_TX_MEM_GBL_CFG_INTR_THR_M;
+		val |= FIELD_PREP(Q_REG_TX_MEM_GBL_CFG_INTR_THR_M, threshold);
+	}
+
+	err = ice_write_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, val);
+
+	return err;
+}
+
 /**
  * ice_ptp_init_phy_e82x - initialize PHY parameters
  * @ptp: pointer to the PTP HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 6246de3bacf3..5645b20a9f87 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -265,6 +265,7 @@ int ice_stop_phy_timer_e82x(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_e82x(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_tx_offset_e82x(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port);
+int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
 
 /* E810 family functions */
 int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
@@ -342,11 +343,8 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 #define Q_REG_TX_MEM_GBL_CFG		0xC08
 #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_S	0
 #define Q_REG_TX_MEM_GBL_CFG_LANE_TYPE_M	BIT(0)
-#define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_S	1
 #define Q_REG_TX_MEM_GBL_CFG_TX_TYPE_M	ICE_M(0xFF, 1)
-#define Q_REG_TX_MEM_GBL_CFG_INTR_THR_S	9
 #define Q_REG_TX_MEM_GBL_CFG_INTR_THR_M ICE_M(0x3F, 9)
-#define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_S	15
 #define Q_REG_TX_MEM_GBL_CFG_INTR_ENA_M	BIT(15)
 
 /* Tx Timestamp data registers */
-- 
2.43.0


