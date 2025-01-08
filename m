Return-Path: <netdev+bounces-156488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF4BA0681F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1417A2B01
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB55C204F91;
	Wed,  8 Jan 2025 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A26hujDC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57D0204F66
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374691; cv=none; b=QZMe6Jg3B5Sqg9Emnj6X4TMJl19H8HFJ41M0uDjiCeNG+u52GobbtnV35gYaSUTMY1JXp3YacYkLIdpQIkxXIKxxHIcnt3IvHvheiBr8wKsv1mkyagGn13WjXF+HQSWNXyZli4ChnbV0SeDacCOpShUMT1YA1IxfHqKBaYoBWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374691; c=relaxed/simple;
	bh=Wu2wrlKQQrS+L5sWbaLa9DV8bii/bFVXQb0PPn9mYso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dd9BYzQbfCfeWuom+cbJoU4fGbVV9CabQwlq0bfamHKWALtJ5TJZHf3Bj57tbpY2BNMKCaY3PhlY6coVAg+igsR4ARkXXotWOAfLtsSQ/PrLyr5OGEf8tjJ14laAEuQVjw+CcjAOxOTDoFthwGMCW1Bd0Jg5MMRAUdGAZO0BR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A26hujDC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374690; x=1767910690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wu2wrlKQQrS+L5sWbaLa9DV8bii/bFVXQb0PPn9mYso=;
  b=A26hujDCPAukqM+R6sUXmYWjDY9s0gj1TJ03GbTM8YNkyf/6at1ORUdT
   Ou3wbdb67PIS2/0jk1Bzmq1yKME/UtUnC6p7j8jhyUWSEuze6zbWjAWZ0
   OJrafGcNl8l1bpDz6VUaNvr7wlQrWQ3RuweWhS76WJwEZETUbVLFxI2ej
   wVE8Lt8t5/Uy5oARKFqoHP5bMRvfWDn4kspEflYMMMFckltfmfwxB/3N7
   rudYBg3vzB85vH6t2kzhejHQ+UDhKrDFaTmwvsjiT10ijCVGcSbHUN9wI
   EmH5u5V2XnCjJ4tRxrJg4XYBsD0RJrLRr1cdJLZ9RsFon7r7RfDdjE/RM
   Q==;
X-CSE-ConnectionGUID: TZEHdrJ6SbqmmUr17cUz+A==
X-CSE-MsgGUID: GUiySjZVTQqVMrwgWtaiiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384699"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384699"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:04 -0800
X-CSE-ConnectionGUID: mRzTcNqfQf2X/1M7+rxuNQ==
X-CSE-MsgGUID: APR0n/HpSp6BEZEp3onnyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545137"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
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
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 10/13] ice: add lock to protect low latency interface
Date: Wed,  8 Jan 2025 14:17:47 -0800
Message-ID: <20250108221753.2055987-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Newer firmware for the E810 devices support a 'low latency' interface to
interact with the PHY without using the Admin Queue. This is interacted
with via the REG_LL_PROXY_L and REG_LL_PROXY_H registers.

Currently, this interface is only used for Tx timestamps. There are two
different mechanisms, including one which uses an interrupt for firmware to
signal completion. However, these two methods are mutually exclusive, so no
synchronization between them was necessary.

This low latency interface is being extended in future firmware to support
also programming the PHY timers. Use of the interface for PHY timers will
need synchronization to ensure there is no overlap with a Tx timestamp.

The interrupt-based response complicates the locking somewhat. We can't use
a simple spinlock. This would require being acquired in
ice_ptp_req_tx_single_tstamp, and released in
ice_ptp_complete_tx_single_tstamp. The ice_ptp_req_tx_single_tstamp
function is called from the threaded IRQ, and the
ice_ptp_complete_tx_single_stamp is called from the low latency IRQ, so we
would need to acquire the lock with IRQs disabled.

To handle this, we'll use a wait queue along with
wait_event_interruptible_locked_irq in the update flows which don't use the
interrupt.

The interrupt flow will acquire the wait queue lock, set the
ATQBAL_FLAGS_INTR_IN_PROGRESS, and then initiate the firmware low latency
request, and unlock the wait queue lock.

Upon receipt of the low latency interrupt, the lock will be acquired, the
ATQBAL_FLAGS_INTR_IN_PROGRESS bit will be cleared, and the firmware
response will be captured, and wake_up_locked() will be called on the wait
queue.

The other flows will use wait_event_interruptible_locked_irq() to wait
until the ATQBAL_FLAGS_INTR_IN_PROGRESS is clear. This function checks the
condition under lock, but does not hold the lock while waiting. On return,
the lock is held, and a return of zero indicates we hold the lock and the
in-progress flag is not set.

This will ensure that threads which need to use the low latency interface
will sleep until they can acquire the lock without any pending low latency
interrupt flow interfering.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 42 +++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 18 +++++++++
 drivers/net/ethernet/intel/ice/ice_type.h   | 10 +++++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 980d3fe9f36b..c03db3d26c3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -464,7 +464,9 @@ ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
  */
 void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 {
+	struct ice_e810_params *params;
 	struct ice_ptp_port *ptp_port;
+	unsigned long flags;
 	struct sk_buff *skb;
 	struct ice_pf *pf;
 
@@ -473,6 +475,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 
 	ptp_port = container_of(tx, struct ice_ptp_port, tx);
 	pf = ptp_port_to_pf(ptp_port);
+	params = &pf->hw.ptp.phy.e810;
 
 	/* Drop packets which have waited for more than 2 seconds */
 	if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
@@ -489,11 +492,17 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 
 	ice_trace(tx_tstamp_fw_req, tx->tstamps[idx].skb, idx);
 
+	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+
+	params->atqbal_flags |= ATQBAL_FLAGS_INTR_IN_PROGRESS;
+
 	/* Write TS index to read to the PF register so the FW can read it */
 	wr32(&pf->hw, REG_LL_PROXY_H,
 	     REG_LL_PROXY_H_TS_INTR_ENA | FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) |
 	     REG_LL_PROXY_H_EXEC);
 	tx->last_ll_ts_idx_read = idx;
+
+	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
 }
 
 /**
@@ -504,35 +513,52 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 {
 	struct skb_shared_hwtstamps shhwtstamps = {};
 	u8 idx = tx->last_ll_ts_idx_read;
+	struct ice_e810_params *params;
 	struct ice_ptp_port *ptp_port;
 	u64 raw_tstamp, tstamp;
 	bool drop_ts = false;
 	struct sk_buff *skb;
+	unsigned long flags;
+	struct device *dev;
 	struct ice_pf *pf;
-	u32 val;
+	u32 reg_ll_high;
 
 	if (!tx->init || tx->last_ll_ts_idx_read < 0)
 		return;
 
 	ptp_port = container_of(tx, struct ice_ptp_port, tx);
 	pf = ptp_port_to_pf(ptp_port);
+	dev = ice_pf_to_dev(pf);
+	params = &pf->hw.ptp.phy.e810;
 
 	ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
-	val = rd32(&pf->hw, REG_LL_PROXY_H);
+	spin_lock_irqsave(&params->atqbal_wq.lock, flags);
+
+	if (!(params->atqbal_flags & ATQBAL_FLAGS_INTR_IN_PROGRESS))
+		dev_dbg(dev, "%s: low latency interrupt request not in progress?\n",
+			__func__);
+
+	/* Read the low 32 bit value */
+	raw_tstamp = rd32(&pf->hw, REG_LL_PROXY_L);
+	/* Read the status together with high TS part */
+	reg_ll_high = rd32(&pf->hw, REG_LL_PROXY_H);
+
+	/* Wake up threads waiting on low latency interface */
+	params->atqbal_flags &= ~ATQBAL_FLAGS_INTR_IN_PROGRESS;
+
+	wake_up_locked(&params->atqbal_wq);
+
+	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
 
 	/* When the bit is cleared, the TS is ready in the register */
-	if (val & REG_LL_PROXY_H_EXEC) {
+	if (reg_ll_high & REG_LL_PROXY_H_EXEC) {
 		dev_err(ice_pf_to_dev(pf), "Failed to get the Tx tstamp - FW not ready");
 		return;
 	}
 
 	/* High 8 bit value of the TS is on the bits 16:23 */
-	raw_tstamp = FIELD_GET(REG_LL_PROXY_H_TS_HIGH, val);
-	raw_tstamp <<= 32;
-
-	/* Read the low 32 bit value */
-	raw_tstamp |= (u64)rd32(&pf->hw, REG_LL_PROXY_L);
+	raw_tstamp |= ((u64)FIELD_GET(REG_LL_PROXY_H_TS_HIGH, reg_ll_high)) << 32;
 
 	/* Devices using this interface always verify the timestamp differs
 	 * relative to the last cached timestamp value.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 47b784acf07f..b3a232a975ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4857,9 +4857,22 @@ static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
+	struct ice_e810_params *params = &hw->ptp.phy.e810;
+	unsigned long flags;
 	u32 val;
 	int err;
 
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
 	/* Write TS index to read to the PF register so the FW can read it */
 	val = FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) | REG_LL_PROXY_H_EXEC;
 	wr32(hw, REG_LL_PROXY_H, val);
@@ -4870,6 +4883,7 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 				       10, REG_LL_PROXY_H_TIMEOUT_US);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
+		spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
 		return err;
 	}
 
@@ -4879,6 +4893,8 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	/* Read the low 32 bit value and set the TS valid bit */
 	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
+	spin_unlock_irqrestore(&params->atqbal_wq.lock, flags);
+
 	return 0;
 }
 
@@ -5400,6 +5416,8 @@ static void ice_ptp_init_phy_e810(struct ice_ptp_hw *ptp)
 	ptp->phy_model = ICE_PHY_E810;
 	ptp->num_lports = 8;
 	ptp->ports_per_phy = 4;
+
+	init_waitqueue_head(&ptp->phy.e810.atqbal_wq);
 }
 
 /* Device agnostic functions
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index ae5a26ea0d03..d01a9e798678 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -18,6 +18,7 @@
 #include "ice_sbq_cmd.h"
 #include "ice_vlan_mode.h"
 #include "ice_fwlog.h"
+#include <linux/wait.h>
 
 static inline bool ice_is_tc_ena(unsigned long bitmap, u8 tc)
 {
@@ -848,6 +849,14 @@ struct ice_mbx_data {
 #define ICE_PORTS_PER_QUAD	4
 #define ICE_GET_QUAD_NUM(port) ((port) / ICE_PORTS_PER_QUAD)
 
+#define ATQBAL_FLAGS_INTR_IN_PROGRESS	BIT(0)
+
+struct ice_e810_params {
+	/* The wait queue lock also protects the low latency interface */
+	wait_queue_head_t atqbal_wq;
+	unsigned int atqbal_flags;
+};
+
 struct ice_eth56g_params {
 	u8 num_phys;
 	u8 phy_addr[2];
@@ -857,6 +866,7 @@ struct ice_eth56g_params {
 };
 
 union ice_phy_params {
+	struct ice_e810_params e810;
 	struct ice_eth56g_params eth56g;
 };
 
-- 
2.47.1


