Return-Path: <netdev+bounces-62401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC92826EE7
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246AA1F22EB9
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 12:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C445BE8;
	Mon,  8 Jan 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRpCuNm7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E8E40C1C
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704718055; x=1736254055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7NJs1dqOd3uXBhv8xn+FVY7s9i0s30QNJ8L/LVK3So=;
  b=cRpCuNm7E76FAyg6HgHJ6JjWkcWgLzD/jW5aJSOPiPvdpNIai1YsJJpW
   RVAQAq1CQe5hI/5cySYCQsLc++OEa23E55umHbRvSjFx3S5owc4IkQVVH
   TFdmHr2VKJNBZG1paAMdh5lJruWEdz1Pgx8oJkvbRZlyPOeqAlze86b/M
   q6hzTZiHhyfNfGZTYZHMYIj3/PzYBmgvuYjzpfCAyU1LO0NhiXyTxuGUs
   YlKbvYqXTE4fCxKp8iH+pw1cFRPYoxwXeLs8jlHDaAb0xy02zTgl1fgST
   5THgQAm9sdZd5zYEPP4p7BpOlFtmZcQY5DDFrUJOrYu/N6GItxGxXPSpe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="11359592"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="11359592"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 04:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="904791340"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="904791340"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2024 04:47:32 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 5/6] ice: factor out ice_ptp_rebuild_owner()
Date: Mon,  8 Jan 2024 13:47:16 +0100
Message-Id: <20240108124717.1845481-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108124717.1845481-1-karol.kolacinski@intel.com>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_reset() function uses a goto to skip past clock owner
operations if performing a PF reset or if the device is not the clock
owner. This is a bit confusing. Factor this out into
ice_ptp_rebuild_owner() instead.

The ice_ptp_reset() function is called by ice_rebuild() to restore PTP
functionality after a device reset. Follow the convention set by the
ice_main.c file and rename this function to ice_ptp_rebuild(), in the
same way that we have ice_prepare_for_reset() and
ice_ptp_prepare_for_reset().

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 66 ++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  6 +--
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a14e8734cc27..1fa3f40743f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7554,7 +7554,7 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	 * fail.
 	 */
 	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
-		ice_ptp_reset(pf, reset_type);
+		ice_ptp_rebuild(pf, reset_type);
 
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index fe2d8389627b..8a589f853e96 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2665,11 +2665,13 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 }
 
 /**
- * ice_ptp_reset - Initialize PTP hardware clock support after reset
+ * ice_ptp_rebuild_owner - Initialize PTP clock owner after reset
  * @pf: Board private structure
- * @reset_type: the reset type being performed
+ *
+ * Companion function for ice_ptp_rebuild() which handles tasks that only the
+ * PTP clock owner instance should perform.
  */
-void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
+static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 {
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
@@ -2677,34 +2679,21 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	u64 time_diff;
 	int err;
 
-	if (ptp->state != ICE_PTP_RESETTING) {
-		if (ptp->state == ICE_PTP_READY) {
-			ice_ptp_prepare_for_reset(pf, reset_type);
-		} else {
-			err = -EINVAL;
-			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
-			goto err;
-		}
-	}
-
-	if (reset_type == ICE_RESET_PFR || !ice_pf_src_tmr_owned(pf))
-		goto pfr;
-
 	err = ice_ptp_init_phc(hw);
 	if (err)
-		goto err;
+		return err;
 
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
-		goto err;
+		return err;
 	}
 
 	/* Write the increment time value to PHY and LAN */
 	err = ice_ptp_write_incval(hw, ice_base_incval(pf));
 	if (err) {
 		ice_ptp_unlock(hw);
-		goto err;
+		return err;
 	}
 
 	/* Write the initial Time value to PHY and LAN using the cached PHC
@@ -2720,7 +2709,7 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	err = ice_ptp_write_init(pf, &ts);
 	if (err) {
 		ice_ptp_unlock(hw);
-		goto err;
+		return err;
 	}
 
 	/* Release the global hardware lock */
@@ -2729,11 +2718,41 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
 		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
+		if (err)
+			return err;
+
+		ice_ptp_restart_all_phy(pf);
+	}
+
+	return 0;
+}
+
+/**
+ * ice_ptp_rebuild - Initialize PTP hardware clock support after reset
+ * @pf: Board private structure
+ * @reset_type: the reset type being performed
+ */
+void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+	int err;
+
+	if (ptp->state != ICE_PTP_RESETTING) {
+		if (ptp->state == ICE_PTP_READY) {
+			ice_ptp_prepare_for_reset(pf, reset_type);
+		} else {
+			err = -EINVAL;
+			dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
+			goto err;
+		}
+	}
+
+	if (ice_pf_src_tmr_owned(pf) && reset_type != ICE_RESET_PFR) {
+		err = ice_ptp_rebuild_owner(pf);
 		if (err)
 			goto err;
 	}
 
-pfr:
 	/* Init Tx structures */
 	if (ice_is_e810(&pf->hw)) {
 		err = ice_ptp_init_tx_e810(pf, &ptp->port.tx);
@@ -2748,11 +2767,6 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ptp->state = ICE_PTP_READY;
 
-	/* Restart the PHY timestamping block */
-	if (!test_bit(ICE_PFR_REQ, pf->state) &&
-	    ice_pf_src_tmr_owned(pf))
-		ice_ptp_restart_all_phy(pf);
-
 	/* Start periodic work going */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index aa7a5588d11d..3af20025043a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -316,7 +316,7 @@ enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
-void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type);
+void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type);
 void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 			       enum ice_reset_req reset_type);
 void ice_ptp_init(struct ice_pf *pf);
@@ -358,8 +358,8 @@ ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	return 0;
 }
 
-static inline void ice_ptp_reset(struct ice_pf *pf,
-				 enum ice_reset_req reset_type)
+static inline void ice_ptp_rebuild(struct ice_pf *pf,
+				   enum ice_reset_req reset_type)
 {
 }
 
-- 
2.40.1


