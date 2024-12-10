Return-Path: <netdev+bounces-150565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4436C9EAA92
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F4166855
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F822F3BC;
	Tue, 10 Dec 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpWk/zqk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B018230D25
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819116; cv=none; b=H0SZRAv+MnjwRui0O53IlA3wxhHs+DCmtKy48rOfDZxpyRJK6EGRkGDFh4aRk/kNILWrE/VVjMrPdYv5Ws2ynByHwupvgJQJccBllVk5bGPL1vSVn0OKIjeVBso0hRtUu6OgfZ9g88I9s7I6cmfzdH+GceWEp+mdvIwopWd7eYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819116; c=relaxed/simple;
	bh=lLCurn+9VPbUyg8NhLSE6E/x1f4Ma6NA6uL5oiVMSds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzk+NCbUaAwbsuSbKuYn1dEgyPJSVMJLuQd0drCMp2qiBVXlP3RQAH/W5OiWrRB2L/mKc/R/fabyQXUHydo3sI+kUMpROR0da7GYmsqkCyk3gmjYp4Awpp5pjLjDfg/PYCQhwcnrqT0dDPooyVLJmcYjZOBuzdYdXjsT0Yp96A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpWk/zqk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733819114; x=1765355114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lLCurn+9VPbUyg8NhLSE6E/x1f4Ma6NA6uL5oiVMSds=;
  b=GpWk/zqkG+S7Ob2j6iiOF0y6dgXovHYu+Ne+e/skbZ8cmy7OeDROQxsB
   q39fYl26pYf2f5l5I2x33iYvf7YjS8u+Yb0fplITOwVnhG7NClN2pYU0G
   XodLDF8dX7g8M7sxKrBc69YjeD5PqJ5XglUNyhBLS2sNMg+8T+JR13/mm
   gfLeJkpJ9QUTArbdS0dvvp3+La+8n6CVYUeV+cAj3a9Cs5GTJz1m3c7Rl
   manAcrv6WndgtUmLXt97pGHjNZsu6pWAmxfO7K/CuYvnyxgRSEBsOPtyZ
   udeg4wI6IHwJDRPlrLGl8umWhhtof+C+bmjoT8hl18Qt2mqWmOzkkVAUF
   A==;
X-CSE-ConnectionGUID: QxMEtV4rTGyI17f69nTSYg==
X-CSE-MsgGUID: NuTg31unTR2qBZPKhbYDBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34398267"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="34398267"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 00:25:14 -0800
X-CSE-ConnectionGUID: /MKxZtWqQU2FulXHBluw3g==
X-CSE-MsgGUID: PmCEjWdfQE6VKWRY5Eu+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; 
   d="scan'208";a="99398156"
Received: from host61.igk.intel.com ([10.123.220.61])
  by fmviesa003.fm.intel.com with ESMTP; 10 Dec 2024 00:25:12 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 5/5] ice: implement low latency PHY timer updates
Date: Tue, 10 Dec 2024 09:22:09 -0500
Message-ID: <20241210142333.320515-6-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241210142333.320515-1-anton.nadezhdin@intel.com>
References: <20241210142333.320515-1-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Programming the PHY registers in preparation for an increment value change
or a timer adjustment on E810 requires issuing Admin Queue commands for
each PHY register. It has been found that the firmware Admin Queue
processing occasionally has delays of tens or rarely up to hundreds of
milliseconds. This delay cascades to failures in the PTP applications which
depend on these updates being low latency.

Consider a standard PTP profile with a sync rate of 16 times per second.
This means there is ~62 milliseconds between sync messages. A complete
cycle of the PTP algorithm

1) Sync message (with Tx timestamp) from source
2) Follow-up message from source
3) Delay request (with Tx timestamp) from sink
4) Delay response (with Rx timestamp of request) from source
5) measure instantaneous clock offset
6) request time adjustment via CLOCK_ADJTIME systemcall

The Tx timestamps have a default maximum timeout of 10 milliseconds. If we
assume that the maximum possible time is used, this leaves us with ~42
milliseconds of processing time for a complete cycle.

The CLOCK_ADJTIME system call is synchronous and will block until the
driver completes its timer adjustment or frequency change.

If the writes to prepare the PHY timers get hit by a latency spike of 50
milliseconds, then the PTP application will be delayed past the point where
the next cycle should start. Packets from the next cycle may have already
arrived and are waiting on the socket.

In particular, LinuxPTP ptp4l may start complaining about missing an
announce message from the source, triggering a fault. In addition, the
clockcheck logic it uses may trigger. This clockcheck failure occurs
because the timestamp captured by hardware is compared against a reading of
CLOCK_MONOTONIC. It is assumed that the time when the Rx timestamp is
captured and the read from CLOCK_MONOTONIC are relatively close together.
This is not the case if there is a significant delay to processing the Rx
packet.

Newer firmware supports programming the PHY registers over a low latency
interface which bypasses the Admin Queue. Instead, software writes to the
REG_LL_PROXY_L and REG_LL_PROXY_H registers. Firmware reads these registers
and then programs the PHY timers.

Implement functions to use this interface when available to program the PHY
timers instead of using the Admin Queue. This avoids the Admin Queue
latency and ensures that adjustments happen within acceptable latency
bounds.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 105 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   4 +
 2 files changed, 109 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index b068a2409b82..85395866b74e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5087,6 +5087,55 @@ static int ice_ptp_prep_phy_time_e810(struct ice_hw *hw, u32 time)
 	return 0;
 }
 
+/**
+ * ice_ptp_prep_phy_adj_ll_e810 - Prep PHY ports for a time adjustment
+ * @hw: pointer to HW struct
+ * @adj: adjustment value to program
+ *
+ * Use the low latency firmware interface to program PHY time adjustment to
+ * all PHY ports.
+ *
+ * Return: 0 on success, -EBUSY on timeout
+ */
+static int ice_ptp_prep_phy_adj_ll_e810(struct ice_hw *hw, s32 adj)
+{
+	const u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
+	struct ice_e810_params *params = &hw->ptp.phy.e810;
+	unsigned long flags;
+	u32 val;
+	int err;
+
+	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+
+	/* Wait for any pending in-progress low latency interrupt */
+	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
+						  !(params->atqbal_flags &
+						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
+	if (err) {
+		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		return err;
+	}
+
+	wr32(hw, PF_SB_ATQBAH, adj);
+	val = FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_CMD_M, REG_LL_PROXY_H_PHY_TMR_CMD_ADJ) |
+	      FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_IDX_M, tmr_idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, PF_SB_ATQBAL, val);
+
+	/* Read the register repeatedly until the FW indicates completion */
+	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
+		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		return err;
+	}
+
+	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+
+	return 0;
+}
+
 /**
  * ice_ptp_prep_phy_adj_e810 - Prep PHY port for a time adjustment
  * @hw: pointer to HW struct
@@ -5105,6 +5154,9 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
+		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* Adjustments are represented as signed 2's complement values in
@@ -5127,6 +5179,56 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	return 0;
 }
 
+/**
+ * ice_ptp_prep_phy_incval_ll_e810 - Prep PHY ports increment value change
+ * @hw: pointer to HW struct
+ * @incval: The new 40bit increment value to prepare
+ *
+ * Use the low latency firmware interface to program PHY time increment value
+ * for all PHY ports.
+ *
+ * Return: 0 on success, -EBUSY on timeout
+ */
+static int ice_ptp_prep_phy_incval_ll_e810(struct ice_hw *hw, u64 incval)
+{
+	const u8 tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
+	struct ice_e810_params *params = &hw->ptp.phy.e810;
+	unsigned long flags;
+	u32 val;
+	int err;
+
+	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+
+	/* Wait for any pending in-progress low latency interrupt */
+	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
+						  !(params->atqbal_flags &
+						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
+	if (err) {
+		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		return err;
+	}
+
+	wr32(hw, PF_SB_ATQBAH, lower_32_bits(incval));
+	val = FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_CMD_M, REG_LL_PROXY_H_PHY_TMR_CMD_FREQ) |
+	      FIELD_PREP(REG_LL_PROXY_H_TS_HIGH, (u8)upper_32_bits(incval)) |
+	      FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_IDX_M, tmr_idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, PF_SB_ATQBAL, val);
+
+	/* Read the register repeatedly until the FW indicates completion */
+	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
+		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+		return err;
+	}
+
+	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+
+	return 0;
+}
+
 /**
  * ice_ptp_prep_phy_incval_e810 - Prep PHY port increment value change
  * @hw: pointer to HW struct
@@ -5142,6 +5244,9 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
+		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);
 	high = upper_32_bits(incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 71097eb67d54..ba722cbcf694 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -695,7 +695,11 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 
 /* Tx timestamp low latency read definitions */
 #define REG_LL_PROXY_H_TIMEOUT_US	2000
+#define REG_LL_PROXY_H_PHY_TMR_CMD_M	GENMASK(7, 6)
+#define REG_LL_PROXY_H_PHY_TMR_CMD_ADJ	0x1
+#define REG_LL_PROXY_H_PHY_TMR_CMD_FREQ	0x2
 #define REG_LL_PROXY_H_TS_HIGH		GENMASK(23, 16)
+#define REG_LL_PROXY_H_PHY_TMR_IDX_M	BIT(24)
 #define REG_LL_PROXY_H_TS_IDX		GENMASK(29, 24)
 #define REG_LL_PROXY_H_TS_INTR_ENA	BIT(30)
 #define REG_LL_PROXY_H_EXEC		BIT(31)
-- 
2.42.0


