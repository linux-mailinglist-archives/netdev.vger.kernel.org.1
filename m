Return-Path: <netdev+bounces-34817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796E7A550D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAB6281BA7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D022AB2D;
	Mon, 18 Sep 2023 21:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874228DD9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 21:28:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15E111
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695072526; x=1726608526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDkAgXxyHCNfU3o7xnEDxwoC8/pGt/wwRdhhBYo1VXI=;
  b=YxT/X/4OLYPEUk3992QP1JPTfo7tiK12BITGrvIQ4IGHh4ggMm43f4S7
   /N3DIMmaLXJFfoslu8R7L6ZF3sqN2AyOwqb4c1t+uj50I9zV4V938BVsp
   xFi8m+OFWN7kok+WJYoHOW9rwpNOe1bPs5ao6Zr7M/BSxEhH/drhwySRF
   Si5ehNFtj9R6IdCr9pi/gOtsB3t5B5Hc2/WB72fPg1emYC9/VshUJdBtv
   9bUTiVx26HninS6yYnvdOcGXVhnDOU2yjGweaM219ffDj9Te+ofI0SHP5
   SFK2kv3vvZMsvbdTuQ5jE58mI6bh6lO/l3EVHl2wCwDjM+NBpFn8LrN3I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359187249"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="359187249"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 14:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="749186208"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; 
   d="scan'208";a="749186208"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga007.fm.intel.com with ESMTP; 18 Sep 2023 14:28:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 04/11] ice: introduce hw->phy_model for handling PTP PHY differences
Date: Mon, 18 Sep 2023 14:28:07 -0700
Message-Id: <20230918212814.435688-5-anthony.l.nguyen@intel.com>
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

From: Jacob Keller <jacob.e.keller@intel.com>

The ice driver has PTP support which works across a couple of different
device families. The device families each have different PHY hardware which
have unique requirements for programming.

Today, there is E810-based hardware, and E822-based hardware. To handle
this, the driver checks the ice_is_e810() function to separate between the
two existing families of hardware.

Future development is going to add new hardware designs which have further
unique requirements. To make this easier, introduce a phy_model field to
the HW structure. This field represents what PHY model the current device
has, and is used to allow distinguishing which logic a particular device
needs.

This will make supporting future upcoming hardware easier, by providing an
obvious place to initialize the PHY model, and by already using switch/case
statements instead of the previous if statements.

Astute reviewers may notice that there are a handful of remaining checks
for ice_is_e810() left in ice_ptp.c  These conflict with some other
cleanup patches in development, and will be fixed in the near future.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  32 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 102 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   2 +
 drivers/net/ethernet/intel/ice/ice_type.h   |   8 ++
 4 files changed, 117 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index cda674645a7b..a91acba0606f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1366,6 +1366,7 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 {
 	struct ice_ptp_port *ptp_port;
+	struct ice_hw *hw = &pf->hw;
 
 	if (!test_bit(ICE_FLAG_PTP, pf->flags))
 		return;
@@ -1380,11 +1381,16 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
-	/* E810 devices do not need to reconfigure the PHY */
-	if (ice_is_e810(&pf->hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
+		/* Do not reconfigure E810 PHY */
 		return;
-
-	ice_ptp_port_phy_restart(ptp_port);
+	case ICE_PHY_E822:
+		ice_ptp_port_phy_restart(ptp_port);
+		return;
+	default:
+		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
+	}
 }
 
 /**
@@ -2702,14 +2708,22 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
  */
 static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
+	struct ice_hw *hw = &pf->hw;
+
 	mutex_init(&ptp_port->ps_lock);
 
-	if (ice_is_e810(&pf->hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
+	case ICE_PHY_E822:
+		kthread_init_delayed_work(&ptp_port->ov_work,
+					  ice_ptp_wait_for_offsets);
 
-	kthread_init_delayed_work(&ptp_port->ov_work,
-				  ice_ptp_wait_for_offsets);
-	return ice_ptp_init_tx_e822(pf, &ptp_port->tx, ptp_port->port_num);
+		return ice_ptp_init_tx_e822(pf, &ptp_port->tx,
+					    ptp_port->port_num);
+	default:
+		return -ENODEV;
+	}
 }
 
 /**
@@ -2730,6 +2744,8 @@ void ice_ptp_init(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
+	ice_ptp_init_phy_model(hw);
+
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 779c51ec0a26..eb98f2781627 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3276,6 +3276,21 @@ void ice_ptp_unlock(struct ice_hw *hw)
 	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
 }
 
+/**
+ * ice_ptp_init_phy_model - Initialize hw->phy_model based on device type
+ * @hw: pointer to the HW structure
+ *
+ * Determine the PHY model for the device, and initialize hw->phy_model
+ * for use by other functions.
+ */
+void ice_ptp_init_phy_model(struct ice_hw *hw)
+{
+	if (ice_is_e810(hw))
+		hw->phy_model = ICE_PHY_E810;
+	else
+		hw->phy_model = ICE_PHY_E822;
+}
+
 /**
  * ice_ptp_tmr_cmd - Prepare and trigger a timer sync command
  * @hw: pointer to HW struct
@@ -3294,10 +3309,17 @@ static int ice_ptp_tmr_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	ice_ptp_src_cmd(hw, cmd);
 
 	/* Next, prepare the ports */
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		err = ice_ptp_port_cmd_e810(hw, cmd);
-	else
+		break;
+	case ICE_PHY_E822:
 		err = ice_ptp_port_cmd_e822(hw, cmd);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to prepare PHY ports for timer command %u, err %d\n",
 			  cmd, err);
@@ -3339,10 +3361,17 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
 	/* PHY timers */
 	/* Fill Rx and Tx ports and send msg to PHY */
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_time_e810(hw, time & 0xFFFFFFFF);
-	else
+		break;
+	case ICE_PHY_E822:
 		err = ice_ptp_prep_phy_time_e822(hw, time & 0xFFFFFFFF);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
 	if (err)
 		return err;
 
@@ -3374,10 +3403,17 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
 
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_incval_e810(hw, incval);
-	else
+		break;
+	case ICE_PHY_E822:
 		err = ice_ptp_prep_phy_incval_e822(hw, incval);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
 	if (err)
 		return err;
 
@@ -3433,10 +3469,17 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
 
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
-	else
+		break;
+	case ICE_PHY_E822:
 		err = ice_ptp_prep_phy_adj_e822(hw, adj);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
 	if (err)
 		return err;
 
@@ -3456,10 +3499,14 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
  */
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 {
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		return ice_read_phy_tstamp_e810(hw, block, idx, tstamp);
-	else
+	case ICE_PHY_E822:
 		return ice_read_phy_tstamp_e822(hw, block, idx, tstamp);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 /**
@@ -3474,10 +3521,14 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		return ice_clear_phy_tstamp_e810(hw, block, idx);
-	else
+	case ICE_PHY_E822:
 		return ice_clear_phy_tstamp_e822(hw, block, idx);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 /**
@@ -3570,10 +3621,14 @@ int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E822:
+		ice_ptp_reset_ts_memory_e822(hw);
+		break;
+	case ICE_PHY_E810:
+	default:
 		return;
-
-	ice_ptp_reset_ts_memory_e822(hw);
+	}
 }
 
 /**
@@ -3592,10 +3647,14 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	/* Clear event err indications for auxiliary pins */
 	(void)rd32(hw, GLTSYN_STAT(src_idx));
 
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		return ice_ptp_init_phc_e810(hw);
-	else
+	case ICE_PHY_E822:
 		return ice_ptp_init_phc_e822(hw);
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 /**
@@ -3611,12 +3670,17 @@ int ice_ptp_init_phc(struct ice_hw *hw)
  */
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 {
-	if (ice_is_e810(hw))
+	switch (hw->phy_model) {
+	case ICE_PHY_E810:
 		return ice_get_phy_tx_tstamp_ready_e810(hw, block,
 							tstamp_ready);
-	else
+	case ICE_PHY_E822:
 		return ice_get_phy_tx_tstamp_ready_e822(hw, block,
 							tstamp_ready);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 95f55a6627fb..6f277e7b06b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -285,6 +285,8 @@ int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
 		      enum dpll_lock_status *dpll_state);
 int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num);
 
+void ice_ptp_init_phy_model(struct ice_hw *hw);
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 5eb778d9ae64..4cd131546aa9 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -822,6 +822,13 @@ struct ice_mbx_data {
 	u16 async_watermark_val;
 };
 
+/* PHY model */
+enum ice_phy_model {
+	ICE_PHY_UNSUP = -1,
+	ICE_PHY_E810  = 1,
+	ICE_PHY_E822,
+};
+
 /* Port hardware description */
 struct ice_hw {
 	u8 __iomem *hw_addr;
@@ -843,6 +850,7 @@ struct ice_hw {
 	u8 revision_id;
 
 	u8 pf_id;		/* device profile info */
+	enum ice_phy_model phy_model;
 
 	u16 max_burst_size;	/* driver sets this value */
 
-- 
2.38.1


