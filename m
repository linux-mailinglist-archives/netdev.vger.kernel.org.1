Return-Path: <netdev+bounces-32897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A367479AABC
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 20:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9EE1C209D4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671E15AD8;
	Mon, 11 Sep 2023 18:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA915AD5
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 18:11:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5310D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694455864; x=1725991864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=poKHfIjto8McijNi4Ov/9lI/A53hAFVwlWwQwEKXN5Q=;
  b=aJyI48iTml3RUPExDjX7wS5LENn1Uvajjo5d3yKgzWzP+EuzUwwEdjXS
   TQt7194+2qXKzwjfmfFlA6fBO9Rl/r/K+ExxykOeBfMoI5q/2jCRpRnXk
   3XsFiYq0hE61KMnY54JjCkWBioDhoQ44kgWa775nWXjjtW7X6FzPtevBm
   klFzG7LszHjlSQnbN48xuiiS6qwpGDtDYf5d+mlN7UHdYRf1afsUIEoTm
   dWlCyUzhH1BZHij+9275vOJ5UxVUBpsna5316N99ga686noEIkFDMRTIs
   s1PT1yKa0WKjCyIvH1XDdDsdxxIxOctvy0rjLVmmNkQ4sjARckDFK7oQ7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378075627"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378075627"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 11:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917129932"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917129932"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 11:11:01 -0700
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
Subject: [PATCH net-next 04/13] ice: introduce hw->phy_model for handling PTP PHY differences
Date: Mon, 11 Sep 2023 11:03:05 -0700
Message-Id: <20230911180314.4082659-5-anthony.l.nguyen@intel.com>
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
index 39cf1e734113..9b55897b0682 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -3150,6 +3150,21 @@ void ice_ptp_unlock(struct ice_hw *hw)
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
@@ -3168,10 +3183,17 @@ static int ice_ptp_tmr_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
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
@@ -3213,10 +3235,17 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
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
 
@@ -3248,10 +3277,17 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
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
 
@@ -3307,10 +3343,17 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
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
 
@@ -3330,10 +3373,14 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
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
@@ -3348,10 +3395,14 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
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
@@ -3360,10 +3411,14 @@ int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
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
@@ -3382,10 +3437,14 @@ int ice_ptp_init_phc(struct ice_hw *hw)
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
@@ -3401,10 +3460,15 @@ int ice_ptp_init_phc(struct ice_hw *hw)
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
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index dc1d398da7a8..51e77887aad6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -199,6 +199,8 @@ int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
 
+void ice_ptp_init_phy_model(struct ice_hw *hw);
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 5e353b0cbe6f..86165d388f34 100644
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


