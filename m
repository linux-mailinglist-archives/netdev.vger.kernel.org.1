Return-Path: <netdev+bounces-158316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075CA115E6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80955168D92
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5A29A5;
	Wed, 15 Jan 2025 00:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxIzbswW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2082AE66
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899742; cv=none; b=mH9l2UgaAuymmna/DXOhJm4/XP9bMkUiD01j3v3IZxiiRgKuu6wyBQd4fe38sUqVzXoPcYZfcUh3JFABoC13mHnroRJVXhMvzmPNLQTZlpxvhxx776eUjGoiMUfa1Ax5h994f6KifLk9NlMpq/WkCBwObtK2AG2tw8VFqhZP/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899742; c=relaxed/simple;
	bh=rFfi023SDwpGClUuPSm7n2YTtCDe4IBaBYK1Fn6l3q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxiyBa1XDzqZSt6HSYobJJ6PI6MjRbBDjN8GzDd/7dfFJELHJ+Bgpy6zDn4bYCQ3DK5WVIMd/K+7edTsrzAXYYpt9rHoHyRpav8xUNCSkPJJeXgdZy8Pryv2LL2iX/sGA6V87g7YsQq/UCMVLz2ZkxoavjzVLopBgkVsavsuhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxIzbswW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899740; x=1768435740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFfi023SDwpGClUuPSm7n2YTtCDe4IBaBYK1Fn6l3q8=;
  b=cxIzbswWUwtJFHNlm7ekaEa0IZC7UluoxrN/mhVtBA84uCmrsAWXrokm
   dcIB3aax0cXuQ7bpsanEqE2uCAj+X3v2RPsmS1KGKgbAyqL2dd+VTPv/b
   YuA2bPMidm0pK5dU2BVnc9tPkTcdzKyk4y38kr9BudO7ASvbXb/ZMVF19
   OWa7u/iYdrLpodiPRJ0Yv+fbpnzLN5Pt1sPvXmzO54L64ou+gosZDi6Hu
   0mb8KxTq7kHRTvf2JxHuDsC9etfJlIwo65Y2Af/AdO8eUJuQzSGomRqoi
   rJDJKLNfzN3l92UmO3meGN/odFGzn5Lvror3SVAB1eDjOc6Pf5ev78vqY
   A==;
X-CSE-ConnectionGUID: Xg64fQ/9SQmP8xtYkkik0w==
X-CSE-MsgGUID: VV3OLhEQT0uvp6/c3tb0zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897530"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:56 -0800
X-CSE-ConnectionGUID: vmkz3ktATBucZDXtRzaNvw==
X-CSE-MsgGUID: fKMMtohfTgG8QuroJysEyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211456"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	przemyslaw.kitszel@intel.com,
	milena.olech@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	mschmidt@redhat.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v2 12/13] ice: implement low latency PHY timer updates
Date: Tue, 14 Jan 2025 16:08:38 -0800
Message-ID: <20250115000844.714530-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 105 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   4 +
 2 files changed, 109 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d7dd18de64ef..da7cd04778e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5078,6 +5078,55 @@ static int ice_ptp_prep_phy_time_e810(struct ice_hw *hw, u32 time)
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
+	u32 val;
+	int err;
+
+	spin_lock_irq(&params->atqbal_wq.lock);
+
+	/* Wait for any pending in-progress low latency interrupt */
+	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
+						  !(params->atqbal_flags &
+						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
+	if (err) {
+		spin_unlock_irq(&params->atqbal_wq.lock);
+		return err;
+	}
+
+	wr32(hw, REG_LL_PROXY_L, adj);
+	val = FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_CMD_M, REG_LL_PROXY_H_PHY_TMR_CMD_ADJ) |
+	      FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_IDX_M, tmr_idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, REG_LL_PROXY_H, val);
+
+	/* Read the register repeatedly until the FW indicates completion */
+	err = read_poll_timeout_atomic(rd32, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
+				       REG_LL_PROXY_H);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer adjustment using low latency interface\n");
+		spin_unlock_irq(&params->atqbal_wq.lock);
+		return err;
+	}
+
+	spin_unlock_irq(&params->atqbal_wq.lock);
+
+	return 0;
+}
+
 /**
  * ice_ptp_prep_phy_adj_e810 - Prep PHY port for a time adjustment
  * @hw: pointer to HW struct
@@ -5096,6 +5145,9 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
 	u8 tmr_idx;
 	int err;
 
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
+		return ice_ptp_prep_phy_adj_ll_e810(hw, adj);
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
 	/* Adjustments are represented as signed 2's complement values in
@@ -5118,6 +5170,56 @@ static int ice_ptp_prep_phy_adj_e810(struct ice_hw *hw, s32 adj)
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
+	u32 val;
+	int err;
+
+	spin_lock_irq(&params->atqbal_wq.lock);
+
+	/* Wait for any pending in-progress low latency interrupt */
+	err = wait_event_interruptible_locked_irq(params->atqbal_wq,
+						  !(params->atqbal_flags &
+						    ATQBAL_FLAGS_INTR_IN_PROGRESS));
+	if (err) {
+		spin_unlock_irq(&params->atqbal_wq.lock);
+		return err;
+	}
+
+	wr32(hw, REG_LL_PROXY_L, lower_32_bits(incval));
+	val = FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_CMD_M, REG_LL_PROXY_H_PHY_TMR_CMD_FREQ) |
+	      FIELD_PREP(REG_LL_PROXY_H_TS_HIGH, (u8)upper_32_bits(incval)) |
+	      FIELD_PREP(REG_LL_PROXY_H_PHY_TMR_IDX_M, tmr_idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, REG_LL_PROXY_H, val);
+
+	/* Read the register repeatedly until the FW indicates completion */
+	err = read_poll_timeout_atomic(rd32, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US, false, hw,
+				       REG_LL_PROXY_H);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY timer increment using low latency interface\n");
+		spin_unlock_irq(&params->atqbal_wq.lock);
+		return err;
+	}
+
+	spin_unlock_irq(&params->atqbal_wq.lock);
+
+	return 0;
+}
+
 /**
  * ice_ptp_prep_phy_incval_e810 - Prep PHY port increment value change
  * @hw: pointer to HW struct
@@ -5133,6 +5235,9 @@ static int ice_ptp_prep_phy_incval_e810(struct ice_hw *hw, u64 incval)
 	u8 tmr_idx;
 	int err;
 
+	if (hw->dev_caps.ts_dev_info.ll_phy_tmr_update)
+		return ice_ptp_prep_phy_incval_ll_e810(hw, incval);
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	low = lower_32_bits(incval);
 	high = upper_32_bits(incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5a3b1b15c746..231dd00cf38c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -690,7 +690,11 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 
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
2.47.1


