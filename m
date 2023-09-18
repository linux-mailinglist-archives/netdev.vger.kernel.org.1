Return-Path: <netdev+bounces-34815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F336F7A5509
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7CB1C20B1C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8022869D;
	Mon, 18 Sep 2023 21:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A97428DBE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05E8112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072526; x=1726608526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlyQgMOL7H3UmwdkPkFq8hATahmU5Or4WEHVj5htWl0=;
  b=C/H4apvzKnu9Uck0Z0PpJ4Vnafi29jBPUKShEM97VuvEzxp2pGGe2GLx
   zuPy1S/R86saxGJgvwsNgZGF4CTi4Fgg1hfFHsVPyoMx/jp5xok6cj3h0
   s9ZFfqW8LkNYML6QtLkcHllNYEZR34Ck5rMcE9cF93BGmgSXHML7u2pCQ
   TzMaBemrKZGsfpD0sCY83ccGtGz7C79yXPgS9Fk8726JpInMhCKthLG/h
   4UfLN/uVINQxPY7qejlb384tfr025dfC8/wlDUQKzcr0qO+1jUd60yByp
   j1cRJ5oPa4WXdRuOfZrikkbSmobH8uK4HDihyOBCHvjxG2AgoAHR0UOXT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187255"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187255"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186211"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186211"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 05/11] ice: PTP: Clean up timestamp registers correctly
Date: Mon, 18 Sep 2023 14:28:08 -0700
Message-Id: <20230918212814.435688-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
References: <20230918212814.435688-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Karol Kolacinski <karol.kolacinski@intel.com>

E822 PHY TS registers should not be written and the only way to clean up
them is to reset QUAD memory.

To ensure that the status bit for the timestamp index is cleared, ensure
that ice_clear_phy_tstamp implementations first read the timestamp out.
Implementations which can write the register continue to do so.

Add a note to indicate this function should only be called on timestamps
which have their valid bit set. Update the dynamic debug messages to
reflect the actual action taken.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 70 +++++++++++++--------
 1 file changed, 45 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index eb98f2781627..10445bba6539 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -754,29 +754,32 @@ ice_read_phy_tstamp_e822(struct ice_hw *hw, u8 quad, u8 idx, u64 *tstamp)
  * @quad: the quad to read from
  * @idx: the timestamp index to reset
  *
- * Clear a timestamp, resetting its valid bit, from the PHY quad block that is
- * shared between the internal PHYs on the E822 devices.
+ * Read the timestamp out of the quad to clear its timestamp status bit from
+ * the PHY quad block that is shared between the internal PHYs of the E822
+ * devices.
+ *
+ * Note that unlike E810, software cannot directly write to the quad memory
+ * bank registers. E822 relies on the ice_get_phy_tx_tstamp_ready() function
+ * to determine which timestamps are valid. Reading a timestamp auto-clears
+ * the valid bit.
+ *
+ * To directly clear the contents of the timestamp block entirely, discarding
+ * all timestamp data at once, software should instead use
+ * ice_ptp_reset_ts_memory_quad_e822().
+ *
+ * This function should only be called on an idx whose bit is set according to
+ * ice_get_phy_tx_tstamp_ready().
  */
 static int
 ice_clear_phy_tstamp_e822(struct ice_hw *hw, u8 quad, u8 idx)
 {
-	u16 lo_addr, hi_addr;
+	u64 unused_tstamp;
 	int err;
 
-	lo_addr = (u16)TS_L(Q_REG_TX_MEMORY_BANK_START, idx);
-	hi_addr = (u16)TS_H(Q_REG_TX_MEMORY_BANK_START, idx);
-
-	err = ice_write_quad_reg_e822(hw, quad, lo_addr, 0);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register, err %d\n",
-			  err);
-		return err;
-	}
-
-	err = ice_write_quad_reg_e822(hw, quad, hi_addr, 0);
+	err = ice_read_phy_tstamp_e822(hw, quad, idx, &unused_tstamp);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear high PTP timestamp register, err %d\n",
-			  err);
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read the timestamp register for quad %u, idx %u, err %d\n",
+			  quad, idx, err);
 		return err;
 	}
 
@@ -2812,28 +2815,39 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
  * @lport: the lport to read from
  * @idx: the timestamp index to reset
  *
- * Clear a timestamp, resetting its valid bit, from the timestamp block of the
- * external PHY on the E810 device.
+ * Read the timestamp and then forcibly overwrite its value to clear the valid
+ * bit from the timestamp block of the external PHY on the E810 device.
+ *
+ * This function should only be called on an idx whose bit is set according to
+ * ice_get_phy_tx_tstamp_ready().
  */
 static int ice_clear_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx)
 {
 	u32 lo_addr, hi_addr;
+	u64 unused_tstamp;
 	int err;
 
+	err = ice_read_phy_tstamp_e810(hw, lport, idx, &unused_tstamp);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read the timestamp register for lport %u, idx %u, err %d\n",
+			  lport, idx, err);
+		return err;
+	}
+
 	lo_addr = TS_EXT(LOW_TX_MEMORY_BANK_START, lport, idx);
 	hi_addr = TS_EXT(HIGH_TX_MEMORY_BANK_START, lport, idx);
 
 	err = ice_write_phy_reg_e810(hw, lo_addr, 0);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register, err %d\n",
-			  err);
+		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for lport %u, idx %u, err %d\n",
+			  lport, idx, err);
 		return err;
 	}
 
 	err = ice_write_phy_reg_e810(hw, hi_addr, 0);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear high PTP timestamp register, err %d\n",
-			  err);
+		ice_debug(hw, ICE_DBG_PTP, "Failed to clear high PTP timestamp register for lport %u, idx %u, err %d\n",
+			  lport, idx, err);
 		return err;
 	}
 
@@ -3515,9 +3529,15 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  * @block: the block to read from
  * @idx: the timestamp index to reset
  *
- * Clear a timestamp, resetting its valid bit, from the timestamp block. For
- * E822 devices, the block is the quad to clear from. For E810 devices, the
- * block is the logical port to clear from.
+ * Clear a timestamp from the timestamp block, discarding its value without
+ * returning it. This resets the memory status bit for the timestamp index
+ * allowing it to be reused for another timestamp in the future.
+ *
+ * For E822 devices, the block number is the PHY quad to clear from. For E810
+ * devices, the block number is the logical port to clear from.
+ *
+ * This function must only be called on a timestamp index whose valid bit is
+ * set according to ice_get_phy_tx_tstamp_ready().
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-- 
2.38.1


