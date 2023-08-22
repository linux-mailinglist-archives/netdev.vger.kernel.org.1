Return-Path: <netdev+bounces-29617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A856D784100
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0861C208DE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC841C2A8;
	Tue, 22 Aug 2023 12:41:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119F7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:41:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1CB196
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692708064; x=1724244064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1UqkuZA6XJC0gPh98eoYGZXb9QqQPdNdE+riNUfakQ4=;
  b=CIZ2gAC0vNjxHGWWWPTXmbMJI7mUwLtCUyrZHI9BT5fU4P70wR1OGcuw
   JGkgdl0v8/YfeDXjDyNWQYgSD3KJnA8G9MuXnsWFXSJPQ2DLAwBC7ar8n
   lI9+poL47ZKz3qzaOLWMQuJE18g4drYHgZtksRelG95+P99xgLtSS3Trp
   WWxPBqHvdEkYN5I0be/WZSHuQgXu2AOiFA/DYBlinbgtsLrZsugzIk1+z
   X7705QDU12turdpuS+t7gvH0SaTqLVaPUT2krFg3Woy997em0rAFgCvVW
   54WGlzt02qbLWHBC12E3TNO7LEhjVg2ovRl2C2BRZpFsRNF62kwJxY6ky
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376604610"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376604610"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771342899"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="771342899"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 05:40:59 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 iwl-next 2/9] ice: introduce PTP state machine
Date: Tue, 22 Aug 2023 14:40:37 +0200
Message-Id: <20230822124044.301654-3-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822124044.301654-1-karol.kolacinski@intel.com>
References: <20230822124044.301654-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add PTP state machine so that the driver can correctly identify PTP
state around resets.
When the driver got information about ungraceful reset, PTP was not
prepared for reset and it returned error. When this situation occurs,
prepare PTP before rebuilding its structures.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 131 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  10 ++
 4 files changed, 99 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index cf6c961e8d9b..4c4b17ef99fa 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -489,7 +489,6 @@ enum ice_pf_flags {
 	ICE_FLAG_DCB_ENA,
 	ICE_FLAG_FD_ENA,
 	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
-	ICE_FLAG_PTP,			/* PTP is enabled by software */
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_TC_MQPRIO,		/* support for Multi queue TC */
 	ICE_FLAG_CLS_FLOWER,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index d3cb08e66dcb..7d57ecf48da0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3275,7 +3275,7 @@ ice_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 
 	/* only report timestamping if PTP is enabled */
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (!test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 2e3f0aaacddd..b138a895d0c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -255,6 +255,31 @@ ice_verify_pin_e810t(struct ptp_clock_info *info, unsigned int pin,
 	return ice_ptp_set_sma_e810t(info, pin, func);
 }
 
+/**
+ * ice_ptp_state_str - Convert PTP state to readable string
+ * @state: PTP state to convert
+ *
+ * Returns: the human readable string representation of the provided PTP
+ * state, used for printing error messages.
+ */
+static const char *ice_ptp_state_str(enum ice_ptp_state state)
+{
+	switch (state) {
+	case ICE_PTP_UNINIT:
+		return "UNINITIALIZED";
+	case ICE_PTP_INITIALIZING:
+		return "INITIALIZING";
+	case ICE_PTP_READY:
+		return "READY";
+	case ICE_PTP_RESETTING:
+		return "RESETTING";
+	case ICE_PTP_ERROR:
+		return "ERROR";
+	}
+
+	return "UNKNOWN";
+}
+
 /**
  * ice_ptp_configure_tx_tstamp - Enable or disable Tx timestamp interrupt
  * @pf: The PF pointer to search in
@@ -1285,7 +1310,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	if (WARN_ON_ONCE(port >= ICE_NUM_EXTERNAL_PORTS))
@@ -2020,7 +2045,7 @@ int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
 	struct hwtstamp_config *config;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
 
 	config = &pf->ptp.tstamp_config;
@@ -2087,7 +2112,7 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 	struct hwtstamp_config config;
 	int err;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return -EAGAIN;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
@@ -2424,7 +2449,7 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
 	int err;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	err = ice_ptp_update_cached_phctime(pf);
@@ -2434,6 +2459,42 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_prepare_for_reset - Prepare PTP for reset
+ * @pf: Board private structure
+ */
+void ice_ptp_prepare_for_reset(struct ice_pf *pf)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+	u8 src_tmr;
+
+	if (ptp->state == ICE_PTP_RESETTING)
+		return;
+
+	ptp->state = ICE_PTP_RESETTING;
+
+	/* Disable timestamping for both Tx and Rx */
+	ice_ptp_cfg_timestamp(pf, false);
+
+	kthread_cancel_delayed_work_sync(&ptp->work);
+
+	if (test_bit(ICE_PFR_REQ, pf->state))
+		return;
+
+	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
+
+	/* Disable periodic outputs */
+	ice_ptp_disable_all_clkout(pf);
+
+	src_tmr = ice_get_ptp_src_clock_index(&pf->hw);
+
+	/* Disable source clock */
+	wr32(&pf->hw, GLTSYN_ENA(src_tmr), (u32)~GLTSYN_ENA_TSYN_ENA_M);
+
+	/* Acquire PHC and system timer to restore after reset */
+	ptp->reset_time = ktime_get_real_ns();
+}
+
 /**
  * ice_ptp_reset - Initialize PTP hardware clock support after reset
  * @pf: Board private structure
@@ -2446,6 +2507,16 @@ void ice_ptp_reset(struct ice_pf *pf)
 	int err, itr = 1;
 	u64 time_diff;
 
+	if (ptp->state != ICE_PTP_RESETTING) {
+		if (ptp->state == ICE_PTP_READY) {
+			ice_ptp_prepare_for_reset(pf);
+		} else {
+			err = -EINVAL;
+			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
+			goto err;
+		}
+	}
+
 	if (test_bit(ICE_PFR_REQ, pf->state))
 		goto pfr;
 
@@ -2512,7 +2583,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (err)
 		goto err;
 
-	set_bit(ICE_FLAG_PTP, pf->flags);
+	ptp->state = ICE_PTP_READY;
 
 	/* Start periodic work going */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
@@ -2521,6 +2592,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	return;
 
 err:
+	ptp->state = ICE_PTP_ERROR;
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
@@ -2727,39 +2799,6 @@ int ice_ptp_clock_index(struct ice_pf *pf)
 	return clock ? ptp_clock_index(clock) : -1;
 }
 
-/**
- * ice_ptp_prepare_for_reset - Prepare PTP for reset
- * @pf: Board private structure
- */
-void ice_ptp_prepare_for_reset(struct ice_pf *pf)
-{
-	struct ice_ptp *ptp = &pf->ptp;
-	u8 src_tmr;
-
-	clear_bit(ICE_FLAG_PTP, pf->flags);
-
-	/* Disable timestamping for both Tx and Rx */
-	ice_ptp_cfg_timestamp(pf, false);
-
-	kthread_cancel_delayed_work_sync(&ptp->work);
-
-	if (test_bit(ICE_PFR_REQ, pf->state))
-		return;
-
-	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
-
-	/* Disable periodic outputs */
-	ice_ptp_disable_all_clkout(pf);
-
-	src_tmr = ice_get_ptp_src_clock_index(&pf->hw);
-
-	/* Disable source clock */
-	wr32(&pf->hw, GLTSYN_ENA(src_tmr), (u32)~GLTSYN_ENA_TSYN_ENA_M);
-
-	/* Acquire PHC and system timer to restore after reset */
-	ptp->reset_time = ktime_get_real_ns();
-}
-
 /**
  * ice_ptp_init_owner - Initialize PTP_1588_CLOCK device
  * @pf: Board private structure
@@ -3013,6 +3052,8 @@ void ice_ptp_init(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
+	ptp->state = ICE_PTP_INITIALIZING;
+
 	ice_ptp_init_phy_model(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
@@ -3034,7 +3075,6 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
 
-	set_bit(ICE_FLAG_PTP, pf->flags);
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
 		goto err;
@@ -3043,6 +3083,7 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err;
 
+	ptp->state = ICE_PTP_READY;
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
@@ -3052,7 +3093,7 @@ void ice_ptp_init(struct ice_pf *pf)
 		ptp_clock_unregister(ptp->clock);
 		pf->ptp.clock = NULL;
 	}
-	clear_bit(ICE_FLAG_PTP, pf->flags);
+	ptp->state = ICE_PTP_ERROR;
 	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
 }
 
@@ -3065,9 +3106,15 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state == ICE_PTP_UNINIT)
 		return;
 
+	if (pf->ptp.state != ICE_PTP_READY)
+		dev_warn(ice_pf_to_dev(pf), "PTP state machine is %s, tearing down PTP anyways\n",
+			 ice_ptp_state_str(pf->ptp.state));
+
+	pf->ptp.state = ICE_PTP_UNINIT;
+
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_cfg_timestamp(pf, false);
 
@@ -3075,8 +3122,6 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
-	clear_bit(ICE_FLAG_PTP, pf->flags);
-
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
 	ice_ptp_port_phy_stop(&pf->ptp.port);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8f6f94392756..674a0abe3cdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -201,8 +201,17 @@ struct ice_ptp_port_owner {
 
 #define GLTSYN_TGT_H_IDX_MAX		4
 
+enum ice_ptp_state {
+	ICE_PTP_UNINIT = 0,
+	ICE_PTP_INITIALIZING,
+	ICE_PTP_READY,
+	ICE_PTP_RESETTING,
+	ICE_PTP_ERROR,
+};
+
 /**
  * struct ice_ptp - data used for integrating with CONFIG_PTP_1588_CLOCK
+ * @state: current state of PTP state machine
  * @tx_interrupt_mode: the TX interrupt mode for the PTP clock
  * @port: data for the PHY port initialization procedure
  * @ports_owner: data for the auxiliary driver owner
@@ -225,6 +234,7 @@ struct ice_ptp_port_owner {
  * @late_cached_phc_updates: number of times cached PHC update is late
  */
 struct ice_ptp {
+	enum ice_ptp_state state;
 	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
 	struct ice_ptp_port_owner ports_owner;
-- 
2.39.2


