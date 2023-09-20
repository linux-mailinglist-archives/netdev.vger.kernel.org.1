Return-Path: <netdev+bounces-35288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31F7A8A73
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540A4281F50
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37CF1A5B5;
	Wed, 20 Sep 2023 17:20:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCB1A5A8
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:20:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737EFCC
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695230404; x=1726766404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APxyc9LGozUWtO+H6Wh2XpvZGi5zXnpvvk56IXQVMb8=;
  b=TJ+WTvBFbzMd8QSsU0xRy5u/kWXUP8XrXLHfLZxpepKUMCi39mYNlcOl
   z11EwARSWu0KscDocBFtL7X7EcZkn58f72JQPTjb7S7SfXxnmpBj1UrQ+
   5/LnmWYi094vMdRh49uNgXeAp+oHj9YXDX6z8yavFBXGCUfN93VekbnNu
   h9RXvikjiKa8VYm53jgjXQVExHWF+uqMXG7FYxuz547WygFUFYDDp9iVE
   K1Jgzk/+vq+WlmDk8M91YhO9SWZXwld2dzjadcfbuQlJyeoFmEUEGhmlI
   lUJjcybI9GaKHDVz6ABQUnmEPAsLHcNaTYT0uD4BUFnIIkOs4abELm4oD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411234476"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411234476"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:20:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077543760"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077543760"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 10:20:01 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Michalik <michal.michalik@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/4] ice: PTP: add clock domain number to auxiliary interface
Date: Wed, 20 Sep 2023 10:19:28 -0700
Message-Id: <20230920171929.2198273-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
References: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Michalik <michal.michalik@intel.com>

The PHC clock id used to be moved between PFs using FW admin queue
shared parameters - move the implementation to auxiliary bus.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 163 +++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  11 +-
 4 files changed, 34 insertions(+), 147 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 24293f52f2d1..6e49a6198f02 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -2359,11 +2359,6 @@ struct ice_aqc_driver_shared_params {
 };
 
 enum ice_aqc_driver_params {
-	/* OS clock index for PTP timer Domain 0 */
-	ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR0 = 0,
-	/* OS clock index for PTP timer Domain 1 */
-	ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR1,
-
 	/* Add new parameters above */
 	ICE_AQC_DRIVER_PARAM_MAX = 16,
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ad4d4702129f..d3cb08e66dcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3285,7 +3285,7 @@ ice_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 				SOF_TIMESTAMPING_RX_HARDWARE |
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->phc_index = ice_get_ptp_clock_index(pf);
+	info->phc_index = ice_ptp_clock_index(pf);
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 503cf351f5f5..5293df2d57a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -339,131 +339,6 @@ void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
 	ice_set_rx_tstamp(pf, ena);
 }
 
-/**
- * ice_get_ptp_clock_index - Get the PTP clock index
- * @pf: the PF pointer
- *
- * Determine the clock index of the PTP clock associated with this device. If
- * this is the PF controlling the clock, just use the local access to the
- * clock device pointer.
- *
- * Otherwise, read from the driver shared parameters to determine the clock
- * index value.
- *
- * Returns: the index of the PTP clock associated with this device, or -1 if
- * there is no associated clock.
- */
-int ice_get_ptp_clock_index(struct ice_pf *pf)
-{
-	struct device *dev = ice_pf_to_dev(pf);
-	enum ice_aqc_driver_params param_idx;
-	struct ice_hw *hw = &pf->hw;
-	u8 tmr_idx;
-	u32 value;
-	int err;
-
-	/* Use the ptp_clock structure if we're the main PF */
-	if (pf->ptp.clock)
-		return ptp_clock_index(pf->ptp.clock);
-
-	tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
-	if (!tmr_idx)
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR0;
-	else
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR1;
-
-	err = ice_aq_get_driver_param(hw, param_idx, &value, NULL);
-	if (err) {
-		dev_err(dev, "Failed to read PTP clock index parameter, err %d aq_err %s\n",
-			err, ice_aq_str(hw->adminq.sq_last_status));
-		return -1;
-	}
-
-	/* The PTP clock index is an integer, and will be between 0 and
-	 * INT_MAX. The highest bit of the driver shared parameter is used to
-	 * indicate whether or not the currently stored clock index is valid.
-	 */
-	if (!(value & PTP_SHARED_CLK_IDX_VALID))
-		return -1;
-
-	return value & ~PTP_SHARED_CLK_IDX_VALID;
-}
-
-/**
- * ice_set_ptp_clock_index - Set the PTP clock index
- * @pf: the PF pointer
- *
- * Set the PTP clock index for this device into the shared driver parameters,
- * so that other PFs associated with this device can read it.
- *
- * If the PF is unable to store the clock index, it will log an error, but
- * will continue operating PTP.
- */
-static void ice_set_ptp_clock_index(struct ice_pf *pf)
-{
-	struct device *dev = ice_pf_to_dev(pf);
-	enum ice_aqc_driver_params param_idx;
-	struct ice_hw *hw = &pf->hw;
-	u8 tmr_idx;
-	u32 value;
-	int err;
-
-	if (!pf->ptp.clock)
-		return;
-
-	tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
-	if (!tmr_idx)
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR0;
-	else
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR1;
-
-	value = (u32)ptp_clock_index(pf->ptp.clock);
-	if (value > INT_MAX) {
-		dev_err(dev, "PTP Clock index is too large to store\n");
-		return;
-	}
-	value |= PTP_SHARED_CLK_IDX_VALID;
-
-	err = ice_aq_set_driver_param(hw, param_idx, value, NULL);
-	if (err) {
-		dev_err(dev, "Failed to set PTP clock index parameter, err %d aq_err %s\n",
-			err, ice_aq_str(hw->adminq.sq_last_status));
-	}
-}
-
-/**
- * ice_clear_ptp_clock_index - Clear the PTP clock index
- * @pf: the PF pointer
- *
- * Clear the PTP clock index for this device. Must be called when
- * unregistering the PTP clock, in order to ensure other PFs stop reporting
- * a clock object that no longer exists.
- */
-static void ice_clear_ptp_clock_index(struct ice_pf *pf)
-{
-	struct device *dev = ice_pf_to_dev(pf);
-	enum ice_aqc_driver_params param_idx;
-	struct ice_hw *hw = &pf->hw;
-	u8 tmr_idx;
-	int err;
-
-	/* Do not clear the index if we don't own the timer */
-	if (!ice_pf_src_tmr_owned(pf))
-		return;
-
-	tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
-	if (!tmr_idx)
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR0;
-	else
-		param_idx = ICE_AQC_DRIVER_PARAM_CLK_IDX_TMR1;
-
-	err = ice_aq_set_driver_param(hw, param_idx, 0, NULL);
-	if (err) {
-		dev_dbg(dev, "Failed to clear PTP clock index parameter, err %d aq_err %s\n",
-			err, ice_aq_str(hw->adminq.sq_last_status));
-	}
-}
-
 /**
  * ice_ptp_read_src_clk_reg - Read the source clock register
  * @pf: Board private structure
@@ -2451,7 +2326,6 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 static long ice_ptp_create_clock(struct ice_pf *pf)
 {
 	struct ptp_clock_info *info;
-	struct ptp_clock *clock;
 	struct device *dev;
 
 	/* No need to create a clock device if we already have one */
@@ -2464,11 +2338,11 @@ static long ice_ptp_create_clock(struct ice_pf *pf)
 	dev = ice_pf_to_dev(pf);
 
 	/* Attempt to register the clock before enabling the hardware. */
-	clock = ptp_clock_register(info, dev);
-	if (IS_ERR(clock))
-		return PTR_ERR(clock);
-
-	pf->ptp.clock = clock;
+	pf->ptp.clock = ptp_clock_register(info, dev);
+	if (IS_ERR(pf->ptp.clock)) {
+		dev_err(ice_pf_to_dev(pf), "Failed to register PTP clock device");
+		return PTR_ERR(pf->ptp.clock);
+	}
 
 	return 0;
 }
@@ -2829,6 +2703,28 @@ static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
 	mutex_destroy(&pf->ptp.ports_owner.lock);
 }
 
+/**
+ * ice_ptp_clock_index - Get the PTP clock index for this device
+ * @pf: Board private structure
+ *
+ * Returns: the PTP clock index associated with this PF, or -1 if no PTP clock
+ * is associated.
+ */
+int ice_ptp_clock_index(struct ice_pf *pf)
+{
+	struct auxiliary_device *aux_dev;
+	struct ice_pf *owner_pf;
+	struct ptp_clock *clock;
+
+	aux_dev = &pf->ptp.port.aux_dev;
+	owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
+	if (!owner_pf)
+		return -1;
+	clock = owner_pf->ptp.clock;
+
+	return clock ? ptp_clock_index(clock) : -1;
+}
+
 /**
  * ice_ptp_prepare_for_reset - Prepare PTP for reset
  * @pf: Board private structure
@@ -2927,9 +2823,6 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_clk;
 
-	/* Store the PTP clock index for other PFs */
-	ice_set_ptp_clock_index(pf);
-
 	err = ice_ptp_register_auxbus_driver(pf);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf), "Failed to register PTP auxbus driver");
@@ -2938,7 +2831,6 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 
 	return 0;
 err_aux:
-	ice_clear_ptp_clock_index(pf);
 	ptp_clock_unregister(pf->ptp.clock);
 err_clk:
 	pf->ptp.clock = NULL;
@@ -3198,7 +3090,6 @@ void ice_ptp_release(struct ice_pf *pf)
 	/* Disable periodic outputs */
 	ice_ptp_disable_all_clkout(pf);
 
-	ice_clear_ptp_clock_index(pf);
 	ptp_clock_unregister(pf->ptp.clock);
 	pf->ptp.clock = NULL;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index d94c22329df0..8f6f94392756 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -288,11 +288,11 @@ struct ice_ptp {
 #define ETH_GLTSYN_ENA(_i)		(0x03000348 + ((_i) * 4))
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
+int ice_ptp_clock_index(struct ice_pf *pf);
 struct ice_pf;
 int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr);
 int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
 void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena);
-int ice_get_ptp_clock_index(struct ice_pf *pf);
 
 void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
@@ -318,10 +318,6 @@ static inline int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 }
 
 static inline void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena) { }
-static inline int ice_get_ptp_clock_index(struct ice_pf *pf)
-{
-	return -1;
-}
 
 static inline void ice_ptp_extts_event(struct ice_pf *pf) { }
 static inline s8
@@ -344,5 +340,10 @@ static inline void ice_ptp_release(struct ice_pf *pf) { }
 static inline void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 {
 }
+
+static inline int ice_ptp_clock_index(struct ice_pf *pf)
+{
+	return -1;
+}
 #endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 #endif /* _ICE_PTP_H_ */
-- 
2.38.1


