Return-Path: <netdev+bounces-32898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1179AABD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE136281301
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9852D15AE4;
	Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB615AE1
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C69010F
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455864; x=1725991864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dy22tw+DGlNM0tGwVeLyYgSUJphdRX/sX2u+BzBwPhk=;
  b=elipEW5U5cc5kn/RUPRWxyhtMuuMfxvbc1XShg8oWZnwORNSASSk4WuX
   hc6xjvyaJF/Hx1/oMxCKLT7Cfm7Swz/hdU2GrUXvMPXeOKJJuIZ7IlPiK
   almpE6ne+KnFI0Fi9U7bBoRlAsLb/4/PwDk1yeY6DnuC7IY/mT4SaploB
   Ro3Sgl72kAjSklsHsqU3lWRpeXfAN47KrjsHcM0HuMHEX51IyT+JuO77K
   9VUnnxPPzGMGBcb9Wi8blAHL5kwpxcufpUaZ1lZFs/0CEt+AfN4H56CSJ
   6U80ULCn4dVUVXVtWRBJwiQqAS3cAnRohzyWP2rw2yHr64TBWzZ2G2eSm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075633"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075633"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129936"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129936"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:01 -0700
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
Subject: [PATCH net-next 05/13] ice: PTP: Clean up timestamp registers correctly
Date: Mon, 11 Sep 2023 11:03:06 -0700
Message-Id: <20230911180314.4082659-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
References: <20230911180314.4082659-1-anthony.l.nguyen@intel.com>
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
index 9b55897b0682..8d1961dc06e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -628,29 +628,32 @@ ice_read_phy_tstamp_e822(struct ice_hw *hw, u8 quad, u8 idx, u64 *tstamp)
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
 
@@ -2686,28 +2689,39 @@ ice_read_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx, u64 *tstamp)
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
 
@@ -3389,9 +3403,15 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
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


