Return-Path: <netdev+bounces-276686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKhgLCWj1mlUGwgAu9opvQ
	(envelope-from <netdev+bounces-276686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:49:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DC3C1A56
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24F963035363
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C793D9048;
	Wed,  8 Apr 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpPexoCG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAD3D8125
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674054; cv=none; b=XQm4EqXZO/lP2OjGHo65Eal4JmW4eOxwBe46+NlR3Tpo4aeE6kgiMkVlCiPmrI0s8dySu8CuDN5CP2t53Hs9JnzRDFhFLI8oSdtIpFbUB6CcGszwFhCyk0dxfjuejaedX6D+I+VE41EdEJig/SeIvcCN9pGoN8I1PLIQZa6SnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674054; c=relaxed/simple;
	bh=b9RwiRxpk38kPQPs+FH1DQizAozd96iPnz/ykGFJxI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKZyV7/KZT7DL5ifu4yq2+tFD/t9jaGbl1ZnXnjlEkM33URbc6yY6kFpCkf8/zmQk3hrjQtMR3erRcNhElg9TSWXJi2pXprNqkSlaupIC6NUFtLTojnXtuMwsVSolIxueap1xxgTx0UNKHAShxDFhbdynsowc+H8NR1QaWTCCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpPexoCG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775674053; x=1807210053;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=b9RwiRxpk38kPQPs+FH1DQizAozd96iPnz/ykGFJxI8=;
  b=VpPexoCGQ4EJUMDMElS2OxwXhxbQl+jAW4sYv+bo4FCBB/c11LIgLrFn
   L7H0FbvJNUmT4b+QoEci2YUEMfhB6yS6luimnP7iyqpI1WjeQMOW619C0
   LLNh0AIaVbYYhdRcdeVA/UxO35IZYfMY4NMZQDvW6wKGx6QUAnJhzBxup
   PArS843/FMrUBxX0B/a3Bk1h0eVMjVt4dmEHsi1SoJJcbtwUs40Pkz4Ga
   MnsYgk64T9S6Mu9w6WJvspXU+I7TNwmjnPmuNPjjU497rClzcvX4Jzs4j
   VA0KyiPeyEySuBuM1BESa3LT9lOnXaCVGLighrE/4A9bkdyzZMo1WRrB9
   w==;
X-CSE-ConnectionGUID: 6Nrb3ZwcRcedYlbxY+jVvA==
X-CSE-MsgGUID: z0dgkumYQVyvP5sCqo2SWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75841387"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="75841387"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:28 -0700
X-CSE-ConnectionGUID: FRoW3OlKTziqQuFi5B+DPQ==
X-CSE-MsgGUID: IGPAORRwQqyMVvyFrnfV7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="230217563"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 11:47:27 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 08 Apr 2026 11:46:32 -0700
Subject: [PATCH iwl-net 2/4] ice: perform PHY soft reset for E825C ports at
 initialization
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-jk-even-more-e825c-fixes-v1-2-b959da91a81f@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Timothy Miskell <timothy.miskell@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-306a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7639;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=tvvenahFztgo1FeA+D0zmawzjSttw0Lv5ZsSN3NC/+o=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsxri/aEeG/kuXRq0lIeWc57atOaIx/NOmCkdIAjbvql3
 tmx32ynd5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRyesY/vuvUlssafVr18Mv
 ChOXLZyjzMVe+kS9bPfK4O3Zh05f0vrG8D+1I/T224XTZ+ect/zP0WfTuvgbO4fdJmmRc/Vafee
 MEzgA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276686-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 909DC3C1A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

In some cases the PHY timestamp block of the E825C can become stuck. This
is known to occur if the software writes 0 to the Tx timestamp threshold,
and with older versions of the ice driver the threshold configuration is
buggy and can race in such that hardware briefly operates with a zero
threshold enabled. There are no other known ways to trigger this behavior,
but once it occurs, the hardware is not recovered by normal reset, a driver
reload, or even a warm power cycle of the system. A cold power cycle is
sufficient to recover hardware, but this is extremely invasive and can
result in significant downtime on customer deployments.

The PHY for each port has a timestamping block which has its own reset
functionality accessible by programming the PHY_REG_GLOBAL register.
Writing to the PHY_REG_GLOBAL_SOFT_RESET_BIT triggers the hardware to
perform a complete reset of the timestamping block of the PHY. This
includes clearing the timestamp status for the port, clearing all
outstanding timestamps in the memory bank, and resetting the PHY timer.

The new ice_ptp_phy_soft_reset_eth56g() function toggles the
PHY_REG_GLOBAL soft reset bit with the required delays, ensuring the
PHY is properly reinitialized without requiring a full device reset.
The sequence clears the reset bit, asserts it, then clears it again,
with short waits between transitions to allow hardware stabilization.

Call this function in the new ice_ptp_init_phc_e825c(), implementing the
E825C device specific variant of the ice_ptp_init_phc(). Note that if
ice_ptp_init_phc() fails, PTP functionality may be disabled, but the driver
will still load to allow basic functionality to continue.

This causes the clock owning PF driver to perform a PHY soft reset for
every port during initialization. This ensures the driver begins life in a
known functional state regardless of how it was previously programmed.

This ensures that we properly reconfigure the hardware after a device reset
or when loading the driver, even if it was previously misconfigured with an
out-of-date or modified driver.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  4 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 90 ++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5896b346e579..9d7acc7eb2ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -374,6 +374,7 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
+int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port);
 
 #define ICE_ETH56G_NOMINAL_INCVAL	0x140000000ULL
 #define ICE_ETH56G_NOMINAL_PCS_REF_TUS	0x100000000ULL
@@ -676,6 +677,9 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 #define ICE_P0_GNSS_PRSNT_N	BIT(4)
 
 /* ETH56G PHY register addresses */
+#define PHY_REG_GLOBAL			0x0
+#define PHY_REG_GLOBAL_SOFT_RESET_M	BIT(11)
+
 /* Timestamp PHY incval registers */
 #define PHY_REG_TIMETUS_L		0x8
 #define PHY_REG_TIMETUS_U		0xC
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 67775beb9449..441b5f10e4bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -377,6 +377,31 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
  * The following functions operate on devices with the ETH 56G PHY.
  */
 
+/**
+ * ice_ptp_init_phc_e825c - Perform E825C specific PHC initialization
+ * @hw: pointer to HW struct
+ *
+ * Perform E825C-specific PTP hardware clock initialization steps.
+ *
+ * Return: 0 on success, or a negative error value on failure.
+ */
+static int ice_ptp_init_phc_e825c(struct ice_hw *hw)
+{
+	int err;
+
+	/* Soft reset all ports, to ensure everything is at a clean state */
+	for (int port = 0; port < hw->ptp.num_lports; port++) {
+		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
+		if (err) {
+			ice_debug(hw, ICE_DBG_PTP, "Failed to soft reset port %d, err %d\n",
+				  port, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_ptp_get_dest_dev_e825 - get destination PHY for given port number
  * @hw: pointer to the HW struct
@@ -2179,6 +2204,69 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
 	return 0;
 }
 
+/**
+ * ice_ptp_phy_soft_reset_eth56g - Perform a PHY soft reset on ETH56G
+ * @hw: pointer to the HW structure
+ * @port: PHY port number
+ *
+ * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
+ * bit in the PHY global register. The reset sequence consists of:
+ *   1. Clearing the soft reset bit
+ *   2. Asserting the soft reset bit
+ *   3. Clearing the soft reset bit again
+ *
+ * Short delays are inserted between each step to allow the hardware
+ * to settle. This provides a controlled way to reinitialize the PHY
+ * without requiring a full device reset.
+ *
+ * Return: 0 on success, or a negative error code on failure when
+ *         reading or writing the PHY register.
+ */
+int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
+{
+	u32 global_val;
+	int err;
+
+	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+
+	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Clearing soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+
+	usleep_range(5000, 6000);
+
+	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Set soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+		return err;
+	}
+	usleep_range(5000, 6000);
+
+	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
+	ice_debug(hw, ICE_DBG_PTP, "Clear soft reset bit for port %d, val: 0x%x\n",
+		  port, global_val);
+	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
+			  port, err);
+	return err;
+}
+
 /**
  * ice_get_phy_tx_tstamp_ready_eth56g - Read the Tx memory status register
  * @hw: pointer to the HW struct
@@ -5591,7 +5679,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return 0;
+		return ice_ptp_init_phc_e825c(hw);
 	default:
 		return -EOPNOTSUPP;
 	}

-- 
2.53.0.1066.g1eceb487f285


