Return-Path: <netdev+bounces-46000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838107E0C6B
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032B9B21562
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F78266AC;
	Fri,  3 Nov 2023 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZQBM6oz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7857E262B4
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 23:47:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA436CA
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699055226; x=1730591226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I6miPb4f5Ejvw4Kxn9y8pqM+f1RWCJWfcYeJOpjGU24=;
  b=SZQBM6ozqc0DVgZX7rT2o+km/DFc8fgvY27Jv+T4YbBjijJgc2HIzGip
   5rhGhEBu8wAq8jGaLTelQ+PdHth5rCFXtb6fIX9dXIi/tjokcQUqZlrCk
   6l3+MhVJ/qqofwr+iBaviHGARtI61onODt+nljO9S+WMd4jjYib0d5spw
   IJ6z2vP3bC5hM2T0AysTkC53eM6rjtD4yEKp7DP6PB85Bf0bb9xHYL7z6
   oqoPpFRmPTrwyv7Ajk8bbhbRfQ4p0fbd5YzL76fDP1+hBmzkrh8Mc7Y81
   iv6Zp9fNDbKil5NMKgzZ4tC5kt4CRcRLdex26FOB40inmtwwn6ke/hxVW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="374076060"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="374076060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 16:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="905504344"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="905504344"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 16:47:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net 3/3] ice: restore timestamp configuration after device reset
Date: Fri,  3 Nov 2023 16:46:58 -0700
Message-ID: <20231103234658.511859-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103234658.511859-1-jacob.e.keller@intel.com>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver calls ice_ptp_cfg_timestamp() during ice_ptp_prepare_for_reset()
to disable timestamping while the device is resetting. This operation
destroys the user requested configuration. While the driver does call
ice_ptp_cfg_timestamp in ice_rebuild() to restore some hardware settings
after a reset, it unconditionally passes true or false, resulting in
failure to restore previous user space configuration.

This results in a device reset forcibly disabling timestamp configuration
regardless of current user settings.

This was not detected previously due to a quirk of the LinuxPTP ptp4l
application. If ptp4l detects a missing timestamp, it enters a fault state
and performs recovery logic which includes executing SIOCSHWTSTAMP again,
restoring the now accidentally cleared configuration.

Not every application does this, and for these applications, timestamps
will mysteriously stop after a PF reset, without being restored until an
application restart.

Fix this by replacing ice_ptp_cfg_timestamp() with two new functions:

1) ice_ptp_disable_timestamp_mode() which unconditionally disables the
   timestamping logic in ice_ptp_prepare_for_reset() and ice_ptp_release()

2) ice_ptp_restore_timestamp_mode() which calls
   ice_ptp_restore_tx_interrupt() to restore Tx timestamping configuration,
   calls ice_set_rx_tstamp() to restore Rx timestamping configuration, and
   issues an immediate TSYN_TX interrupt to ensure that timestamps which
   may have occurred during the device reset get processed.

Modify the ice_ptp_set_timestamp_mode to directly save the user
configuration and then call ice_ptp_restore_timestamp_mode. This way, reset
no longer destroys the saved user configuration.

This obsoletes the ice_set_tx_tstamp() function which can now be safely
removed.

With this change, all devices should now restore Tx and Rx timestamping
functionality correctly after a PF reset without application intervention.

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 12 +---
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 76 ++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +-
 3 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6607fa6fe556..fb9c93f37e84 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7401,15 +7401,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		goto err_vsi_rebuild;
 	}
 
-	/* configure PTP timestamping after VSI rebuild */
-	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
-		if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
-			ice_ptp_cfg_timestamp(pf, false);
-		else if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_ALL)
-			/* for E82x PHC owner always need to have interrupts */
-			ice_ptp_cfg_timestamp(pf, true);
-	}
-
 	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_SWITCHDEV_CTRL);
 	if (err) {
 		dev_err(dev, "Switchdev CTRL VSI rebuild failed: %d\n", err);
@@ -7461,6 +7452,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	ice_plug_aux_dev(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
+
+	/* Restore timestamp mode settings after VSI rebuild */
+	ice_ptp_restore_timestamp_mode(pf);
 	return;
 
 err_vsi_rebuild:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 624d05b4bbd9..71f405f8a6fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -294,18 +294,6 @@ static void ice_ptp_cfg_tx_interrupt(struct ice_pf *pf)
 	wr32(hw, PFINT_OICR_ENA, val);
 }
 
-/**
- * ice_set_tx_tstamp - Enable or disable Tx timestamping
- * @pf: The PF pointer to search in
- * @on: bool value for whether timestamps are enabled or disabled
- */
-static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
-{
-	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-
-	ice_ptp_cfg_tx_interrupt(pf);
-}
-
 /**
  * ice_set_rx_tstamp - Enable or disable Rx timestamping
  * @pf: The PF pointer to search in
@@ -317,7 +305,7 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 	u16 i;
 
 	vsi = ice_get_main_vsi(pf);
-	if (!vsi)
+	if (!vsi || !vsi->rx_rings)
 		return;
 
 	/* Set the timestamp flag for all the Rx rings */
@@ -326,23 +314,50 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 			continue;
 		vsi->rx_rings[i]->ptp_rx = on;
 	}
-
-	pf->ptp.tstamp_config.rx_filter = on ? HWTSTAMP_FILTER_ALL :
-					       HWTSTAMP_FILTER_NONE;
 }
 
 /**
- * ice_ptp_cfg_timestamp - Configure timestamp for init/deinit
+ * ice_ptp_disable_timestamp_mode - Disable current timestamp mode
  * @pf: Board private structure
- * @ena: bool value to enable or disable time stamp
  *
- * This function will configure timestamping during PTP initialization
- * and deinitialization
+ * Called during preparation for reset to temporarily disable timestamping on
+ * the device. Called during remove to disable timestamping while cleaning up
+ * driver resources.
  */
-void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
+static void ice_ptp_disable_timestamp_mode(struct ice_pf *pf)
 {
-	ice_set_tx_tstamp(pf, ena);
-	ice_set_rx_tstamp(pf, ena);
+	struct ice_hw *hw = &pf->hw;
+	u32 val;
+
+	val = rd32(hw, PFINT_OICR_ENA);
+	val &= ~PFINT_OICR_TSYN_TX_M;
+	wr32(hw, PFINT_OICR_ENA, val);
+
+	ice_set_rx_tstamp(pf, false);
+}
+
+/**
+ * ice_ptp_restore_timestamp_mode - Restore timestamp configuration
+ * @pf: Board private structure
+ *
+ * Called at the end of rebuild to restore timestamp configuration after
+ * a device reset.
+ */
+void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+	bool enable_rx;
+
+	ice_ptp_cfg_tx_interrupt(pf);
+
+	enable_rx = pf->ptp.tstamp_config.rx_filter == HWTSTAMP_FILTER_ALL;
+	ice_set_rx_tstamp(pf, enable_rx);
+
+	/* Trigger an immediate software interrupt to ensure that timestamps
+	 * which occurred during reset are handled now.
+	 */
+	wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
+	ice_flush(hw);
 }
 
 /**
@@ -2043,10 +2058,10 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 {
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
-		ice_set_tx_tstamp(pf, false);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 		break;
 	case HWTSTAMP_TX_ON:
-		ice_set_tx_tstamp(pf, true);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_ON;
 		break;
 	default:
 		return -ERANGE;
@@ -2054,7 +2069,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		ice_set_rx_tstamp(pf, false);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -2070,12 +2085,15 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
-		ice_set_rx_tstamp(pf, true);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
 	}
 
+	/* Immediately update the device timestamping mode */
+	ice_ptp_restore_timestamp_mode(pf);
+
 	return 0;
 }
 
@@ -2743,7 +2761,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf)
 	clear_bit(ICE_FLAG_PTP, pf->flags);
 
 	/* Disable timestamping for both Tx and Rx */
-	ice_ptp_cfg_timestamp(pf, false);
+	ice_ptp_disable_timestamp_mode(pf);
 
 	kthread_cancel_delayed_work_sync(&ptp->work);
 
@@ -3061,7 +3079,7 @@ void ice_ptp_release(struct ice_pf *pf)
 		return;
 
 	/* Disable timestamping for both Tx and Rx */
-	ice_ptp_cfg_timestamp(pf, false);
+	ice_ptp_disable_timestamp_mode(pf);
 
 	ice_ptp_remove_auxbus_device(pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 8f6f94392756..06a330867fc9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -292,7 +292,7 @@ int ice_ptp_clock_index(struct ice_pf *pf);
 struct ice_pf;
 int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr);
 int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr);
-void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena);
+void ice_ptp_restore_timestamp_mode(struct ice_pf *pf);
 
 void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
@@ -317,8 +317,7 @@ static inline int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 	return -EOPNOTSUPP;
 }
 
-static inline void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena) { }
-
+static inline void ice_ptp_restore_timestamp_mode(struct ice_pf *pf) { }
 static inline void ice_ptp_extts_event(struct ice_pf *pf) { }
 static inline s8
 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
-- 
2.41.0


