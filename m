Return-Path: <netdev+bounces-276684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ICMF7ej1ml9GwgAu9opvQ
	(envelope-from <netdev+bounces-276684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:51:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FA73C1C5C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E6230BC8C9
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B3361DB5;
	Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OssxygxP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF438911C
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674052; cv=none; b=T19N4xX70AItDpWNbc1dKwZJlp28K81ESELQO0Woc2EQN6bB9IDGM16vixHwxLsAyU7q+/Vr0QOjCNoo5gHXFNDAwE4unX9p0XGIgfL3hJ2B6EqNJnHLyqBefk1gp+WoV3lVsw9UFl//PP5gLarK/3OO3CnYa0IWw9AMjUHh/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674052; c=relaxed/simple;
	bh=bDCHo9Qd8tPyja99fRKRg8JbbMO0vb09ovr28Mx4LQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBX4m8KMNrs68GQ5NF0nfGGn/+gQoZ7AfVmENFq81H0/0KdyW0vw7YzbLvkfPN3iERWW0TMLcY3nhCuNd3r4XtZx8kSodi1+XZ6Vl4z/nYS6D4b49BKapMgQJwfgJ+f2GC2rUISWg4Orb6VB3WpogBcBbCcBW09eOhze4B+Orb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OssxygxP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775674050; x=1807210050;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bDCHo9Qd8tPyja99fRKRg8JbbMO0vb09ovr28Mx4LQ8=;
  b=OssxygxPsx62SgLE8hnWZLck3pfsL5oHLF73S7qqikJBJaQCd6a1gp2B
   MFwB19MboxFDUzcFsD3YU2CGSUA6oEmDLSsbNInlh/JLqMrdN1L9XW1Kf
   pTrqlS2gsyGLBTSDzJB+XYeGxnrlDuwhZ/It84u7hdiJTCGry+FrqpmBi
   wvKwX7k9m88ZQSwt++brT5o526j6u59ATfgPOSUOnoYFkV1xItyCXvFOC
   I5Wp2PF2vHmlrHEaL4/YqcCv13DaOBi1UPGV7+V0DEYJ5RNcv6O7C/1kw
   a4y5TxrfGmdY0m4KUTbYp/8T87y9UChZF0H/aosp655/KRZidf+hx8k4Z
   Q==;
X-CSE-ConnectionGUID: cXK8xVjaSZ+saks8rIItPA==
X-CSE-MsgGUID: tJRoqMcXTqWMMlscYNndbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841383"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75841383"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: DyEUa8soQ0+0iM4pM1JWRA==
X-CSE-MsgGUID: B3JqnITyReC2GILJSHbryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230217566"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:27 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 08 Apr 2026 11:46:33 -0700
Subject: [PATCH iwl-net 3/4] ice: fix ready bitmap check for non-E822
 devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-3-b959da91a81f@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=12152;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bDCHo9Qd8tPyja99fRKRg8JbbMO0vb09ovr28Mx4LQ8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri/a+NPTzr/vwVbahPO6p/ab/K+64pBTOmvEt8mbWl
 9W3lp092VHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBEzq5iZLgTzcJy6Y4z+8uJ
 64Tm3juV/Mit4xhLVXOQtGF74E9NxVJGhns+rJIWYS+vHHaf++OYuSPD/RzjY5GT/ae3b9dNav/
 fzg8A
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276684-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 00FA73C1C5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The E800 hardware (apart from E810) has a ready bitmap for the PHY
indicating which timestamp slots currently have an outstanding timestamp
waiting to be read by software.

This bitmap is checked in multiple places using the
ice_get_phy_tx_tstamp_ready():

 * ice_ptp_process_tx_tstamp() calls it to determine which timestamps to
   attempt reading from the PHY
 * ice_ptp_tx_tstamps_pending() calls it in a loop at the end of the
   miscellaneous IRQ to check if new timestamps came in while the interrupt
   handler was executing.
 * ice_ptp_maybe_trigger_tx_interrupt() calls it in the auxiliary work task
   to trigger a software interrupt in the event that the hardware logic
   gets stuck.

For E82X devices, multiple PHYs share the same block, and the parameter
passed to the ready bitmap is a block number associated with the given
port. For E825-C devices, the PHYs have their own independent blocks and do
not share, so the parameter passed needs to be the port number. For E810
devices, the ice_get_phy_tx_tstamp_ready() always returns all 1s regardless
of what port, since this hardware does not have a ready bitmap. Finally,
for E830 devices, each PF has its own ready bitmap accessible via register,
and the block parameter is unused.

The first call correctly uses the Tx timestamp tracker block parameter to
check the appropriate timestamp block. This works because the tracker is
setup correctly for each timestamp device type.

The second two callers behave incorrectly for all device types other than
the older E822 devices. They both iterate in a loop using
ICE_GET_QUAD_NUM() which is a macro only used by E822 devices. This logic
is incorrect for devices other than the E822 devices.

For E810 the calls would always return true, causing E810 devices to always
attempt to trigger a software interrupt even when they have no reason to.
For E830, this results in duplicate work as the ready bitmap is checked
once per number of quads. Finally, for E825-C, this results in the pending
checks failing to detect timestamps on ports other than the first two.

Fix this by introducing a new hardware API function to ice_ptp_hw.c,
ice_check_phy_tx_tstamp_ready(). This function will check if any timestamps
are available and returns a positive value if any timestamps are pending.
For E810, the function always returns false, so that the re-trigger checks
never happen. For E830, check the ready bitmap just once. For E82x
hardware, check each quad. Finally, for E825-C, check every port.

The interface function returns an integer to enable reporting of error code
if the driver is unable read the ready bitmap. This enables callers to
handle this case properly. The previous implementation assumed that
timestamps are available if they failed to read the bitmap. This is
problematic as it could lead to continuous software IRQ triggering if the
PHY timestamp registers somehow become inaccessible.

This change is especially important for E825-C devices, as the missing
checks could leave a window open where a new timestamp could arrive while
the existing timestamps aren't completed. As a result, the hardware
threshold logic would not trigger a new interrupt. Without the check, the
timestamp is left unhandled, and new timestamps will not cause an interrupt
again until the timestamp is handled. Since both the interrupt check and
the backup check in the auxiliary task do not function properly, the device
may have Tx timestamps permanently stuck failing on a given port.

The faulty checks originate from commit d938a8cca88a ("ice: Auxbus devices
& driver for E822 TS") and commit 712e876371f8 ("ice: periodically kick Tx
timestamp interrupt"), however at the time of the original coding, both
functions only operated on E822 hardware. This is no longer the case, and
hasn't been since the introduction of the ETH56G PHY model in commit
7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  40 ++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 117 ++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 9d7acc7eb2ce..1b58b054f4a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -300,6 +300,7 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw);
 int ice_ptp_init_phc(struct ice_hw *hw);
 void ice_ptp_init_hw(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
+int ice_check_phy_tx_tstamp_ready(struct ice_hw *hw);
 int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 			 enum ice_ptp_tmr_cmd configured_cmd);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ada42bcc4d0b..34906f972d17 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2718,7 +2718,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
-	unsigned int i;
+	int ret;
 
 	/* Check software indicator */
 	switch (pf->ptp.tx_interrupt_mode) {
@@ -2739,16 +2739,15 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 	}
 
 	/* Check hardware indicator */
-	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
-		u64 tstamp_ready = 0;
-		int err;
-
-		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
-		if (err || tstamp_ready)
-			return true;
+	ret = ice_check_phy_tx_tstamp_ready(hw);
+	if (ret < 0) {
+		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
+			ret);
+		/* Stop triggering IRQs if we're unable to read PHY */
+		return false;
 	}
 
-	return false;
+	return ret;
 }
 
 /**
@@ -2832,8 +2831,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	bool trigger_oicr = false;
-	unsigned int i;
+	int ret;
 
 	if (!pf->ptp.port.tx.has_ready_bitmap)
 		return;
@@ -2841,21 +2839,11 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	if (!ice_pf_src_tmr_owned(pf))
 		return;
 
-	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
-		u64 tstamp_ready;
-		int err;
-
-		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
-		if (!err && tstamp_ready) {
-			trigger_oicr = true;
-			break;
-		}
-	}
-
-	if (trigger_oicr) {
-		/* Trigger a software interrupt, to ensure this data
-		 * gets processed.
-		 */
+	ret = ice_check_phy_tx_tstamp_ready(hw);
+	if (ret < 0) {
+		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
+			ret);
+	} else if (ret) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 441b5f10e4bb..64ad5ed5c688 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2168,6 +2168,35 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
+/**
+ * ice_check_phy_tx_tstamp_ready_eth56g - Check Tx memory status for all ports
+ * @hw: pointer to the HW struct
+ *
+ * Check the PHY_REG_TX_MEMORY_STATUS for all ports. A set bit indicates
+ * a waiting timestamp.
+ *
+ * Return: 1 if any port has at least one timestamp ready bit set,
+ * 0 otherwise, and a negative error code if unable to read the bitmap.
+ */
+static int ice_check_phy_tx_tstamp_ready_eth56g(struct ice_hw *hw)
+{
+	int port;
+
+	for (port = 0; port < hw->ptp.num_lports; port++) {
+		u64 tstamp_ready;
+		int err;
+
+		err = ice_get_phy_tx_tstamp_ready(hw, port, &tstamp_ready);
+		if (err)
+			return err;
+
+		if (tstamp_ready)
+			return 1;
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_read_tx_hwtstamp_status_eth56g - Get TX timestamp status
  * @hw: pointer to the HW struct
@@ -4318,6 +4347,35 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
 	return 0;
 }
 
+/**
+ * ice_check_phy_tx_tstamp_ready_e82x - Check Tx memory status for all quads
+ * @hw: pointer to the HW struct
+ *
+ * Check the Q_REG_TX_MEMORY_STATUS for all quads. A set bit indicates
+ * a waiting timestamp.
+ *
+ * Return: 1 if any quad has at least one timestamp ready bit set,
+ * 0 otherwise, and a negative error value if unable to read the bitmap.
+ */
+static int ice_check_phy_tx_tstamp_ready_e82x(struct ice_hw *hw)
+{
+	int quad;
+
+	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++) {
+		u64 tstamp_ready;
+		int err;
+
+		err = ice_get_phy_tx_tstamp_ready(hw, quad, &tstamp_ready);
+		if (err)
+			return err;
+
+		if (tstamp_ready)
+			return 1;
+	}
+
+	return 0;
+}
+
 /**
  * ice_phy_cfg_intr_e82x - Configure TX timestamp interrupt
  * @hw: pointer to the HW struct
@@ -4870,6 +4928,23 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
 	return 0;
 }
 
+/**
+ * ice_check_phy_tx_tstamp_ready_e810 - Check Tx memory status register
+ * @hw: pointer to the HW struct
+ *
+ * The E810 devices do not have a Tx memory status register. Note this is
+ * intentionally different behavior from ice_get_phy_tx_tstamp_ready_e810
+ * which always says that all bits are ready. This function is called in cases
+ * where code will trigger interrupts if timestamps are waiting, and should
+ * not be called for E810 hardware.
+ *
+ * Return: 0.
+ */
+static int ice_check_phy_tx_tstamp_ready_e810(struct ice_hw *hw)
+{
+	return 0;
+}
+
 /* E810 SMA functions
  *
  * The following functions operate specifically on E810 hardware and are used
@@ -5124,6 +5199,21 @@ static void ice_get_phy_tx_tstamp_ready_e830(const struct ice_hw *hw, u8 port,
 	*tstamp_ready |= rd32(hw, E830_PRTMAC_TS_TX_MEM_VALID_L);
 }
 
+/**
+ * ice_check_phy_tx_tstamp_ready_e830 - Check Tx memory status register
+ * @hw: pointer to the HW struct
+ *
+ * Return: 1 if the device has waiting timestamps, 0 otherwise.
+ */
+static int ice_check_phy_tx_tstamp_ready_e830(struct ice_hw *hw)
+{
+	u64 tstamp_ready;
+
+	ice_get_phy_tx_tstamp_ready_e830(hw, 0, &tstamp_ready);
+
+	return !!tstamp_ready;
+}
+
 /**
  * ice_ptp_init_phy_e830 - initialize PHY parameters
  * @ptp: pointer to the PTP HW struct
@@ -5716,6 +5806,33 @@ int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 	}
 }
 
+/**
+ * ice_check_phy_tx_tstamp_ready - Check PHY Tx timestamp memory status
+ * @hw: pointer to the HW struct
+ *
+ * Check the PHY for Tx timestamp memory status on all ports. If you need to
+ * see individual timestamp status for each index, use
+ * ice_get_phy_tx_tstamp_ready() instead.
+ *
+ * Return: 1 if any port has timestamps available, 0 if there are no timestamps
+ * available, and a negative error code on failure.
+ */
+int ice_check_phy_tx_tstamp_ready(struct ice_hw *hw)
+{
+	switch (hw->mac_type) {
+	case ICE_MAC_E810:
+		return ice_check_phy_tx_tstamp_ready_e810(hw);
+	case ICE_MAC_E830:
+		return ice_check_phy_tx_tstamp_ready_e830(hw);
+	case ICE_MAC_GENERIC:
+		return ice_check_phy_tx_tstamp_ready_e82x(hw);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_check_phy_tx_tstamp_ready_eth56g(hw);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 /**
  * ice_cgu_get_pin_desc_e823 - get pin description array
  * @hw: pointer to the hw struct

-- 
2.53.0.1066.g1eceb487f285


