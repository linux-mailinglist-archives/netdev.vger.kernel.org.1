Return-Path: <netdev+bounces-110250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4992B9A4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC481F257D7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D78158D85;
	Tue,  9 Jul 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nmN3fpVc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29511159209
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528608; cv=none; b=Xa6ESWYLwDZTzn/W7IJclDjUjA9Bh/m/KKUH+1se9Mf7jgluV6CtlmNyLShHXf1r0u/otzyeHuzHurD+EoXy7XC8uMErLr5I/+YGN5HNkkaGAzMEhLJv2hQNM+Da7BXWZ8REpE26nkJljWzZgP7NoYWUr6GirFp5rd7EdWp8glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528608; c=relaxed/simple;
	bh=MrHwnNJiFY4MdXu6WW9z6ICkyEy+PU8H+8yWM+QontU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxeoxG0g+0WSxt18MrnJOA7KkV8lrTg2Jnp2iuWWTVK1bbB/X+963z+VOYtSqKY1NmhlEFkYhJZxu4I5mxCDnTlhC2Smcsxnc4TXMOl3Stc0/UyG103WK0vu4cVYmDK06o1nfwGWYBPpTdXCJt6MqHY7tW6lkYvFYIS/pMYF9mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nmN3fpVc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720528606; x=1752064606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MrHwnNJiFY4MdXu6WW9z6ICkyEy+PU8H+8yWM+QontU=;
  b=nmN3fpVc25ngsJ+c8GvabgEO4f0668F10NDZmVv8FP3CoGN1q23E5Y8e
   76dHLF3HS2mOrmA5FdNDSbIeDhg4YydM4L09gXACQhwl78DXcvxXUSWPG
   u+QZ4xxRBAchgoAh7C3KqDy8M+GuMks9el8xT772hbJydsh0QLL4l62e3
   fp4ZUMKOm+nl71TCSuYiZKBoyvr62BrMnTOvU3k4jgDvbQEQeVX4XPf08
   ClCwNUYxhfLLIsFE29KYwE9/LB0xKWAMkBDci6Nrme0oMsFNRqnuaeQc1
   iKGjGzElNTx0HVtTTZuj4//q3m7RkyeGhIpyxoW5ie5ctm165+2eg2phS
   Q==;
X-CSE-ConnectionGUID: M8T23GA+Sv+to7oVCjb56Q==
X-CSE-MsgGUID: av3hZRJdRx+JwQdoESZ/Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17598167"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17598167"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:36:46 -0700
X-CSE-ConnectionGUID: +3nr3LlDSBaHJisBOLi0tA==
X-CSE-MsgGUID: W1U9/Z3uQlmw6YftOzacqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47776105"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 05:36:44 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 2/4] ice: Process TSYN IRQ in a separate function
Date: Tue,  9 Jul 2024 14:34:56 +0200
Message-ID: <20240709123629.666151-8-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709123629.666151-6-karol.kolacinski@intel.com>
References: <20240709123629.666151-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify TSYN IRQ processing by moving it to a separate function and
having appropriate behavior per PHY model, instead of multiple
conditions not related to HW, but to specific timestamping modes.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +------
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 60 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  6 +++
 3 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 59c4264d8f9b..7866e8dc4a21 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3274,22 +3274,8 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (ice_pf_state_is_nominal(pf) &&
-		    pf->hw.dev_caps.ts_dev_info.ts_ll_int_read) {
-			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
-			unsigned long flags;
-			u8 idx;
-
-			spin_lock_irqsave(&tx->lock, flags);
-			idx = find_next_bit_wrap(tx->in_use, tx->len,
-						 tx->last_ll_ts_idx_read + 1);
-			if (idx != tx->len)
-				ice_ptp_req_tx_single_tstamp(tx, idx);
-			spin_unlock_irqrestore(&tx->lock, flags);
-		} else if (ice_ptp_pf_handles_tx_interrupt(pf)) {
-			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
-			ret = IRQ_WAKE_THREAD;
-		}
+
+		ret = ice_ptp_ts_irq(pf);
 	}
 
 	if (oicr & PFINT_OICR_TSYN_EVNT_M) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b1a8ec549f6a..ada2ede217b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2603,6 +2603,66 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
+/**
+ * ice_ptp_ts_irq - Process the PTP Tx timestamps in IRQ context
+ * @pf: Board private structure
+ *
+ * Returns: IRQ_WAKE_THREAD if Tx timestamp read has to be handled in the bottom
+ * half of the interrupt and IRQ_HANDLED otherwise.
+ */
+irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+
+	switch (hw->ptp.phy_model) {
+	case ICE_PHY_E810:
+		/* E810 capable of low latency timestamping with interrupt can
+		 * request a single timestamp in the top half and wait for
+		 * a second LL TS interrupt from the FW when it's ready.
+		 */
+		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
+			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
+			unsigned long flags;
+			u8 idx;
+
+			if (!ice_pf_state_is_nominal(pf))
+				return IRQ_HANDLED;
+
+			spin_lock_irqsave(&tx->lock, flags);
+			idx = find_next_bit_wrap(tx->in_use, tx->len,
+						 tx->last_ll_ts_idx_read + 1);
+			if (idx != tx->len)
+				ice_ptp_req_tx_single_tstamp(tx, idx);
+			spin_unlock_irqrestore(&tx->lock, flags);
+
+			return IRQ_HANDLED;
+		}
+		fallthrough; /* non-LL_TS E810 */
+	case ICE_PHY_E82X:
+	case ICE_PHY_ETH56G:
+		/* All other devices process timestamps in the bottom half due
+		 * to sleeping or polling.
+		 */
+		if (!ice_ptp_pf_handles_tx_interrupt(pf))
+			return IRQ_HANDLED;
+
+		set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
+		return IRQ_WAKE_THREAD;
+	case ICE_PHY_E830:
+		/* E830 can read timestamps in the top half using rd32() */
+		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
+			/* Process outstanding Tx timestamps. If there
+			 * is more work, re-arm the interrupt to trigger again.
+			 */
+			wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+			ice_flush(hw);
+		}
+		return IRQ_HANDLED;
+	default:
+		return IRQ_HANDLED;
+	}
+}
+
 /**
  * ice_ptp_maybe_trigger_tx_interrupt - Trigger Tx timstamp interrupt
  * @pf: Board private structure
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 5e6dceebb0a4..e495af509642 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -301,6 +301,7 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
+irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -339,6 +340,11 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
 	return true;
 }
 
+static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
+{
+	return IRQ_HANDLED;
+}
+
 static inline u64
 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 		    const struct ice_pkt_ctx *pkt_ctx)
-- 
2.45.2


