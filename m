Return-Path: <netdev+bounces-178872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0DA793E8
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F2F18950D7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF11D8DEE;
	Wed,  2 Apr 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cu2/+OWP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E451C5F13
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615554; cv=none; b=K2FYI7/SC/aITeXWHIBCW5AmAbgFFjVAHPHVOlQtfKbIpQgc+5EhXTgibdFfWd40pj2LYNi3j4D3tbJjQOKrRqaNge6Z9GuMgwZuhfhEUCrqZvbnwTy+SavKS8irEZwWLWS24qUd62blLTsJgKzSSRyBwngKm3+f5usfZ8KffkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615554; c=relaxed/simple;
	bh=jjngyqRtEr/JTfkD7I0DvtHrLvxx71wGmfxirc7C2W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAZLoij6LyMz5fvO3hOAFr9YQHmkFc7Wx7WHVMUMQrUEu+FeJCDJwyWT3rzDymnjKvOqDwgvMKNtwgstdnoRSXLx8tkXSeNfJpS+7kv+4fyYgbfJzXhNZ1e13FaCEQ9rXtzKJDfz4+6GJiCUBCpYds/MTCoqvfB8s2cRzy9RFxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cu2/+OWP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743615553; x=1775151553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjngyqRtEr/JTfkD7I0DvtHrLvxx71wGmfxirc7C2W4=;
  b=Cu2/+OWPnDQMygYMRCWgfcV4/q3YHzimVOS9yclqorHRBqHxjwJ/mht5
   Yy9jSMm+hQAW0rm1bA5UdXiSUKHRD1YAtAytNsmCELiomYT+V0Dqn48Rh
   KQGdLZrJAvRa8vLhHKenLiCl4M+eNNxCLH7cFiuK+aSvfqQD3cekn2SRy
   8mqo/Nwo3IH6uv5f9uUcDAFxoVKB9e2b2P8SOSFuKNMNVj1i08Wxj388k
   jk8252rQ9fPMo30oejuEciuoJ28xEBmixfn+iuQhg9O/LFNXmm9y4C7ch
   WbJUk0Qqg0EOCBTrV17cka2P80OODWuUn3XMpGmwCARRRqYXpXZqQ0qiy
   A==;
X-CSE-ConnectionGUID: iAp66rYpQaCi6nOpT2LZKQ==
X-CSE-MsgGUID: IRQiRHbiR567tyzGSZEuzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44257278"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44257278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:39:11 -0700
X-CSE-ConnectionGUID: 6Sin+6TvT22vACbEW9WZQA==
X-CSE-MsgGUID: 6PuYY58hTW6undrhoXro3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="149968789"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 02 Apr 2025 10:39:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 3/5] e1000e: change k1 configuration on MTP and later platforms
Date: Wed,  2 Apr 2025 10:38:55 -0700
Message-ID: <20250402173900.1957261-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
References: <20250402173900.1957261-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Starting from Meteor Lake, the Kumeran interface between the integrated
MAC and the I219 PHY works at a different frequency. This causes sporadic
MDI errors when accessing the PHY, and in rare circumstances could lead
to packet corruption.

To overcome this, introduce minor changes to the Kumeran idle
state (K1) parameters during device initialization. Hardware reset
reverts this configuration, therefore it needs to be applied in a few
places.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h |  3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 80 +++++++++++++++++++--
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  4 ++
 3 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 5e2cfa73f889..8294a7c4f122 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -803,4 +803,7 @@
 /* SerDes Control */
 #define E1000_GEN_POLL_TIMEOUT          640
 
+#define E1000_FEXTNVM12_PHYPD_CTRL_MASK	0x00C00000
+#define E1000_FEXTNVM12_PHYPD_CTRL_P1	0x00800000
+
 #endif /* _E1000_DEFINES_H_ */
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 2f9655cf5dd9..364378133526 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -285,6 +285,45 @@ static void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
 	}
 }
 
+/**
+ * e1000_reconfigure_k1_exit_timeout - reconfigure K1 exit timeout to
+ * align to MTP and later platform requirements.
+ * @hw: pointer to the HW structure
+ *
+ * Context: PHY semaphore must be held by caller.
+ * Return: 0 on success, negative on failure
+ */
+static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
+{
+	u16 phy_timeout;
+	u32 fextnvm12;
+	s32 ret_val;
+
+	if (hw->mac.type < e1000_pch_mtp)
+		return 0;
+
+	/* Change Kumeran K1 power down state from P0s to P1 */
+	fextnvm12 = er32(FEXTNVM12);
+	fextnvm12 &= ~E1000_FEXTNVM12_PHYPD_CTRL_MASK;
+	fextnvm12 |= E1000_FEXTNVM12_PHYPD_CTRL_P1;
+	ew32(FEXTNVM12, fextnvm12);
+
+	/* Wait for the interface the settle */
+	usleep_range(1000, 1100);
+
+	/* Change K1 exit timeout */
+	ret_val = e1e_rphy_locked(hw, I217_PHY_TIMEOUTS_REG,
+				  &phy_timeout);
+	if (ret_val)
+		return ret_val;
+
+	phy_timeout &= ~I217_PHY_TIMEOUTS_K1_EXIT_TO_MASK;
+	phy_timeout |= 0xF00;
+
+	return e1e_wphy_locked(hw, I217_PHY_TIMEOUTS_REG,
+				  phy_timeout);
+}
+
 /**
  *  e1000_init_phy_workarounds_pchlan - PHY initialization workarounds
  *  @hw: pointer to the HW structure
@@ -327,15 +366,22 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
 	 */
 	switch (hw->mac.type) {
+	case e1000_pch_mtp:
+	case e1000_pch_lnp:
+	case e1000_pch_ptp:
+	case e1000_pch_nvp:
+		/* At this point the PHY might be inaccessible so don't
+		 * propagate the failure
+		 */
+		if (e1000_reconfigure_k1_exit_timeout(hw))
+			e_dbg("Failed to reconfigure K1 exit timeout\n");
+
+		fallthrough;
 	case e1000_pch_lpt:
 	case e1000_pch_spt:
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
-	case e1000_pch_mtp:
-	case e1000_pch_lnp:
-	case e1000_pch_ptp:
-	case e1000_pch_nvp:
 		if (e1000_phy_is_accessible_pchlan(hw))
 			break;
 
@@ -419,8 +465,20 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		 *  the PHY is in.
 		 */
 		ret_val = hw->phy.ops.check_reset_block(hw);
-		if (ret_val)
+		if (ret_val) {
 			e_err("ME blocked access to PHY after reset\n");
+			goto out;
+		}
+
+		if (hw->mac.type >= e1000_pch_mtp) {
+			ret_val = hw->phy.ops.acquire(hw);
+			if (ret_val) {
+				e_err("Failed to reconfigure K1 exit timeout\n");
+				goto out;
+			}
+			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+			hw->phy.ops.release(hw);
+		}
 	}
 
 out:
@@ -4888,6 +4946,18 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 	u16 i;
 
 	e1000_initialize_hw_bits_ich8lan(hw);
+	if (hw->mac.type >= e1000_pch_mtp) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+
+		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+		hw->phy.ops.release(hw);
+		if (ret_val) {
+			e_dbg("Error failed to reconfigure K1 exit timeout\n");
+			return ret_val;
+		}
+	}
 
 	/* Initialize identification LED */
 	ret_val = mac->ops.id_led_init(hw);
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 2504b11c3169..5feb589a9b5f 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -219,6 +219,10 @@
 #define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
 #define I217_PLL_CLOCK_GATE_MASK	0x07FF
 
+/* PHY Timeouts */
+#define I217_PHY_TIMEOUTS_REG                   PHY_REG(770, 21)
+#define I217_PHY_TIMEOUTS_K1_EXIT_TO_MASK       0x0FC0
+
 #define SW_FLAG_TIMEOUT		1000	/* SW Semaphore flag timeout in ms */
 
 /* Inband Control */
-- 
2.47.1


