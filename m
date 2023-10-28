Return-Path: <netdev+bounces-44946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0A7DA453
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 02:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F403A282699
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10C64F;
	Sat, 28 Oct 2023 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lgjB8jYc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987D385
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 00:23:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4751BB
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698452613; x=1729988613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+vfzmkqpvIcEJ6pjPlIFbOd2RCVNtQTeXnAysdpc+Q=;
  b=lgjB8jYcq8c3KF+VqGwomT2QaLWvwNSCLiod1YjHfLYkwgls7RvZITVO
   2k3PLWFm+r/uHEncV2eHs1aARoA5K2Kd5/QYIKKL3yRm+d9OfXNCnS5dA
   Df65yAgtTA0vSyjVVBjL/Dx8nZCa7RK5g5Yo0OSofcdajgbGujbZBq/Sq
   bfUwLU0SukKhuhQLeIZS4OumodH/YxbsAMj52AfmkJM0X+zkDU02E2fxs
   Ia6IVcMA2D7CAUHeOIg6skccfno54Hjfv9aYe10OrBiAbzBVREExZ4Hx3
   Mu6OJCriaK9ta7F+UbjGWP03LzF9J+d5ExEdDPLD1IF0z4mcxujLRD2Ds
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="454337187"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="454337187"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="997999"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 17:23:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 2/3] ice: unify logic for programming PFINT_TSYN_MSK
Date: Fri, 27 Oct 2023 17:23:21 -0700
Message-ID: <20231028002322.2224777-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231028002322.2224777-1-jacob.e.keller@intel.com>
References: <20231028002322.2224777-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d938a8cca88a ("ice: Auxbus devices & driver for E822 TS") modified
how Tx timestamps are handled for E822 devices. On these devices, only the
clock owner handles reading the Tx timestamp data from firmware. To do
this, the PFINT_TSYN_MSK register is modified from the default value to one
which enables reacting to a Tx timestamp on all PHY ports.

The driver currently programs PFINT_TSYN_MSK in different places depending
on whether the port is the clock owner or not. For the clock owner, the
PFINT_TSYN_MSK value is programmed during ice_ptp_init_owner just before
calling ice_ptp_tx_ena_intr to program the PHY ports.

For the non-clock owner ports, the PFINT_TSYN_MSK is programmed during
ice_ptp_init_port.

If a large enough device reset occurs, the PFINT_TSYN_MSK register will be
reset to the default value in which only the PHY associated directly with
the PF will cause the Tx timestamp interrupt to trigger.

The driver lacks logic to reprogram the PFINT_TSYN_MSK register after a
device reset. For the E822 device, this results in the PF no longer
responding to interrupts for other ports. This results in failure to
deliver Tx timestamps to user space applications.

Rename ice_ptp_configure_tx_tstamp to ice_ptp_cfg_tx_interrupt, and unify
the logic for programming PFINT_TSYN_MSK and PFINT_OICR_ENA into one place.
This function will program both registers according to the combination of
user configuration and device requirements.

This ensures that PFINT_TSYN_MSK is always restored when we configure the
Tx timestamp interrupt.

Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 60 ++++++++++++++----------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index affd90622a68..624d05b4bbd9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -256,21 +256,42 @@ ice_verify_pin_e810t(struct ptp_clock_info *info, unsigned int pin,
 }
 
 /**
- * ice_ptp_configure_tx_tstamp - Enable or disable Tx timestamp interrupt
- * @pf: The PF pointer to search in
- * @on: bool value for whether timestamp interrupt is enabled or disabled
+ * ice_ptp_cfg_tx_interrupt - Configure Tx timestamp interrupt for the device
+ * @pf: Board private structure
+ *
+ * Program the device to respond appropriately to the Tx timestamp interrupt
+ * cause.
  */
-static void ice_ptp_configure_tx_tstamp(struct ice_pf *pf, bool on)
+static void ice_ptp_cfg_tx_interrupt(struct ice_pf *pf)
 {
+	struct ice_hw *hw = &pf->hw;
+	bool enable;
 	u32 val;
 
+	switch (pf->ptp.tx_interrupt_mode) {
+	case ICE_PTP_TX_INTERRUPT_ALL:
+		/* React to interrupts across all quads. */
+		wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x1f);
+		enable = true;
+		break;
+	case ICE_PTP_TX_INTERRUPT_NONE:
+		/* Do not react to interrupts on any quad. */
+		wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x0);
+		enable = false;
+		break;
+	case ICE_PTP_TX_INTERRUPT_SELF:
+	default:
+		enable = pf->ptp.tstamp_config.tx_type == HWTSTAMP_TX_ON;
+		break;
+	}
+
 	/* Configure the Tx timestamp interrupt */
-	val = rd32(&pf->hw, PFINT_OICR_ENA);
-	if (on)
+	val = rd32(hw, PFINT_OICR_ENA);
+	if (enable)
 		val |= PFINT_OICR_TSYN_TX_M;
 	else
 		val &= ~PFINT_OICR_TSYN_TX_M;
-	wr32(&pf->hw, PFINT_OICR_ENA, val);
+	wr32(hw, PFINT_OICR_ENA, val);
 }
 
 /**
@@ -280,10 +301,9 @@ static void ice_ptp_configure_tx_tstamp(struct ice_pf *pf, bool on)
  */
 static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
-	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
-		ice_ptp_configure_tx_tstamp(pf, on);
-
 	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
+
+	ice_ptp_cfg_tx_interrupt(pf);
 }
 
 /**
@@ -2789,15 +2809,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
 
-	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_ALL) {
-		/* The clock owner for this device type handles the timestamp
-		 * interrupt for all ports.
-		 */
-		ice_ptp_configure_tx_tstamp(pf, true);
-
-		/* React on all quads interrupts for E82x */
-		wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x1f);
-
+	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
 		err = ice_ptp_tx_ena_intr(pf, true, itr);
 		if (err)
@@ -2867,13 +2879,6 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	case ICE_PHY_E810:
 		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
 	case ICE_PHY_E822:
-		/* Non-owner PFs don't react to any interrupts on E82x,
-		 * neither on own quad nor on others
-		 */
-		if (!ice_ptp_pf_handles_tx_interrupt(pf)) {
-			ice_ptp_configure_tx_tstamp(pf, false);
-			wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x0);
-		}
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
 
@@ -3018,6 +3023,9 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
 
+	/* Configure initial Tx interrupt settings */
+	ice_ptp_cfg_tx_interrupt(pf);
+
 	set_bit(ICE_FLAG_PTP, pf->flags);
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-- 
2.41.0


