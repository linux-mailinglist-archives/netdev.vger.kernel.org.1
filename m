Return-Path: <netdev+bounces-66011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB583CF09
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7451F23D9C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016913AA57;
	Thu, 25 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTu/bThz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FD13AA37
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219887; cv=none; b=skqGInp1zJ3GM3tSg44TLD1iFZE4KHmK78x/Yq4W/38FQb5MtLIZiTiDOcSXL1rxFcEXJMX1KFXaoQeWnClxMEip2sk8XPx5IfhM0Fi1U3up5TtRoVlYihMDHYdVMcQBOQfoKHbKx6BEeOQC0wgC6lp+lj7x+fH+YpnX6aJJQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219887; c=relaxed/simple;
	bh=uojV2KiCBnkYPI891rhfZ8f9gLJL+0wnybgPXFpJI3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUlS0eNKFdu60nKDkF1+TWK7hibmwVoPcoQhYtfxRZApOFkWinYzDB4geK91E+DGhMZvWSR4HQa2HI4rXKELFCdJJe6YZ6DYHKJaZpHKJuio+p9RHuKuTCawudsj1/w1XNpCnnY1yR8EC2f1ZXZUXlIcZyio1rkv5fbbp2FvIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTu/bThz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219885; x=1737755885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uojV2KiCBnkYPI891rhfZ8f9gLJL+0wnybgPXFpJI3I=;
  b=iTu/bThzgbR6AqLLMS3aZZgU+3wVj8qYVS8cilVyTNxBQygs6kIS6QZo
   GAnhz23j91hRF2yF7qdDMYS0/dIVRY7CfsP28tUqLEQSsw6oL13zV2s/d
   A3ffd/ASG5Z9IUi2WvEZIf2QvguXFiP1TBBhHfy3j7bhr1etCdDpjIBOy
   ASx1HUkSEoxuHSt+juIkmw90AQz1Keh1+9matMmMCGPust00AsMRFb8yo
   bcm9Vr8Xk3daixGNit9HoYgKR4axbOeJXoX0jKdKQItTGwOmA45000F21
   4KLim+KwD9g5IbENHZVyBoVYtINCKQYKXaeYV/do82ELQQTVaQObLQLZ7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9069080"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9069080"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:58:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35239921"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 25 Jan 2024 13:58:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/7] ice: introduce PTP state machine
Date: Thu, 25 Jan 2024 13:57:49 -0800
Message-ID: <20240125215757.2601799-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
References: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add PTP state machine so that the driver can correctly identify PTP
state around resets.
When the driver got information about ungraceful reset, PTP was not
prepared for reset and it returned error. When this situation occurs,
prepare PTP before rebuilding its structures.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 110 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  10 ++
 4 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 367b613d92c0..97c2a5fb5dbf 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -493,7 +493,6 @@ enum ice_pf_flags {
 	ICE_FLAG_DCB_ENA,
 	ICE_FLAG_FD_ENA,
 	ICE_FLAG_PTP_SUPPORTED,		/* PTP is supported by NVM */
-	ICE_FLAG_PTP,			/* PTP is enabled by software */
 	ICE_FLAG_ADV_FEATURES,
 	ICE_FLAG_TC_MQPRIO,		/* support for Multi queue TC */
 	ICE_FLAG_CLS_FLOWER,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a19b06f18e40..55fcf17d503e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3360,7 +3360,7 @@ ice_get_ts_info(struct net_device *dev, struct ethtool_ts_info *info)
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 
 	/* only report timestamping if PTP is enabled */
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return ethtool_op_get_ts_info(dev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3b6605c8585e..8ed4af219f9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1430,7 +1430,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	struct ice_ptp_port *ptp_port;
 	struct ice_hw *hw = &pf->hw;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	if (WARN_ON_ONCE(port >= ICE_NUM_EXTERNAL_PORTS))
@@ -2162,7 +2162,7 @@ int ice_ptp_get_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 {
 	struct hwtstamp_config *config;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
 
 	config = &pf->ptp.tstamp_config;
@@ -2232,7 +2232,7 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 	struct hwtstamp_config config;
 	int err;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return -EAGAIN;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
@@ -2616,7 +2616,7 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
 	int err;
 
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	err = ice_ptp_update_cached_phctime(pf);
@@ -2628,6 +2628,42 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
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
+	if (ptp->state != ICE_PTP_READY)
+		return;
+
+	ptp->state = ICE_PTP_RESETTING;
+
+	/* Disable timestamping for both Tx and Rx */
+	ice_ptp_disable_timestamp_mode(pf);
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
@@ -2640,6 +2676,14 @@ void ice_ptp_reset(struct ice_pf *pf)
 	int err, itr = 1;
 	u64 time_diff;
 
+	if (ptp->state == ICE_PTP_READY) {
+		ice_ptp_prepare_for_reset(pf);
+	} else if (ptp->state != ICE_PTP_RESETTING) {
+		err = -EINVAL;
+		dev_err(ice_pf_to_dev(pf), "PTP was not initialized\n");
+		goto err;
+	}
+
 	if (test_bit(ICE_PFR_REQ, pf->state) ||
 	    !ice_pf_src_tmr_owned(pf))
 		goto pfr;
@@ -2700,7 +2744,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	if (err)
 		goto err;
 
-	set_bit(ICE_FLAG_PTP, pf->flags);
+	ptp->state = ICE_PTP_READY;
 
 	/* Restart the PHY timestamping block */
 	if (!test_bit(ICE_PFR_REQ, pf->state) &&
@@ -2714,6 +2758,7 @@ void ice_ptp_reset(struct ice_pf *pf)
 	return;
 
 err:
+	ptp->state = ICE_PTP_ERROR;
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
@@ -2922,39 +2967,6 @@ int ice_ptp_clock_index(struct ice_pf *pf)
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
-	ice_ptp_disable_timestamp_mode(pf);
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
@@ -3195,6 +3207,8 @@ void ice_ptp_init(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
+	ptp->state = ICE_PTP_INITIALIZING;
+
 	ice_ptp_init_phy_model(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
@@ -3219,12 +3233,13 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
-	set_bit(ICE_FLAG_PTP, pf->flags);
-	err = ice_ptp_init_work(pf, ptp);
+	err = ice_ptp_create_auxbus_device(pf);
 	if (err)
 		goto err;
 
-	err = ice_ptp_create_auxbus_device(pf);
+	ptp->state = ICE_PTP_READY;
+
+	err = ice_ptp_init_work(pf, ptp);
 	if (err)
 		goto err;
 
@@ -3237,7 +3252,7 @@ void ice_ptp_init(struct ice_pf *pf)
 		ptp_clock_unregister(ptp->clock);
 		pf->ptp.clock = NULL;
 	}
-	clear_bit(ICE_FLAG_PTP, pf->flags);
+	ptp->state = ICE_PTP_ERROR;
 	dev_err(ice_pf_to_dev(pf), "PTP failed %d\n", err);
 }
 
@@ -3250,9 +3265,11 @@ void ice_ptp_init(struct ice_pf *pf)
  */
 void ice_ptp_release(struct ice_pf *pf)
 {
-	if (!test_bit(ICE_FLAG_PTP, pf->flags))
+	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
+	pf->ptp.state = ICE_PTP_UNINIT;
+
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_disable_timestamp_mode(pf);
 
@@ -3260,8 +3277,6 @@ void ice_ptp_release(struct ice_pf *pf)
 
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
-	clear_bit(ICE_FLAG_PTP, pf->flags);
-
 	kthread_cancel_delayed_work_sync(&pf->ptp.work);
 
 	ice_ptp_port_phy_stop(&pf->ptp.port);
@@ -3271,6 +3286,9 @@ void ice_ptp_release(struct ice_pf *pf)
 		pf->ptp.kworker = NULL;
 	}
 
+	if (ice_pf_src_tmr_owned(pf))
+		ice_ptp_unregister_auxbus_driver(pf);
+
 	if (!pf->ptp.clock)
 		return;
 
@@ -3280,7 +3298,5 @@ void ice_ptp_release(struct ice_pf *pf)
 	ptp_clock_unregister(pf->ptp.clock);
 	pf->ptp.clock = NULL;
 
-	ice_ptp_unregister_auxbus_driver(pf);
-
 	dev_info(ice_pf_to_dev(pf), "Removed PTP clock\n");
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 087dd32d8762..2457380142e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -203,8 +203,17 @@ struct ice_ptp_port_owner {
 
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
@@ -227,6 +236,7 @@ struct ice_ptp_port_owner {
  * @late_cached_phc_updates: number of times cached PHC update is late
  */
 struct ice_ptp {
+	enum ice_ptp_state state;
 	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
 	struct ice_ptp_port_owner ports_owner;
-- 
2.41.0


