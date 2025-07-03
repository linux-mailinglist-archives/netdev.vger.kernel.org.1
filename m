Return-Path: <netdev+bounces-203892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D47AF7F44
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F26584017
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518122F2364;
	Thu,  3 Jul 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q57apsvP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AF2BEC5C
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564571; cv=none; b=Bv6sQkqtcVtU/92ps7TSSXWF3RwEOnxYRxkQkMntjI4GDZBUfoZEVDPJPAXWFCymk9AaUoiTpXgzxWjrKJgDm5yA4K4LW6qsD5S5aZpkvyaCiCp/j0PKvVvyFEmos7WU3r22Eq867a8enoGrbszwD3ZbT14veY6wdKdKNJw48gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564571; c=relaxed/simple;
	bh=j2D9tHaqinp9UrU9W4KBfh+QPZ4vsD9GkMRBGop7als=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyWPd15zw3t503yrhC/eqIUvGedE1jmOkIWfQHk/h/13CLZpXwzEWXJrfnDeidXwEl+Xk7OogCiXZ3mljqyC+MfijZqt2WMe/aqCLp4kO0IS/fPc13XKYwJtoZUjt7XnZ86CBXpIXvYkDS+4zYiazvcI1ScuSvIZnkZ2b6L64Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q57apsvP; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564570; x=1783100570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2D9tHaqinp9UrU9W4KBfh+QPZ4vsD9GkMRBGop7als=;
  b=Q57apsvPm1Z2ftJsxkdilBo834LSto6e5HZ7NgpFNFxaogegDtrucv7K
   Zsvq3fNkuom5w6CZducYeZwkG7XHSdkgJ0WABRwKtBvxoX6GkaEk2v0l1
   Gl6h0I07bxWCUELk2ouVPjjypP85/OfwN+OsKU0wT9IWd84mZbNwdYpuW
   2BSOKwIoESnR3HkrKHuUjIpkSIjmPfDA1bN82Aj0YWHuHuO9v8OnV2Hir
   mu7VujOEQEluz6aOlcXpbFsjAQIZTVLULYyoFF6bar4ciyTQO5/K4+a3i
   JfovCjlpA61f4b9NDDw/SPJo1rG8o4FPZSVJhEVNH3rufcsDO3c4TdD/y
   w==;
X-CSE-ConnectionGUID: DTpY4BzhTyuMb2iqm25qwg==
X-CSE-MsgGUID: 6PSE/PwMTsqKz5vxTmxdIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767896"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767896"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:48 -0700
X-CSE-ConnectionGUID: VV+FzxBVToyhkBTKhRPfRg==
X-CSE-MsgGUID: w+nCwDHVRPahtrCbn29EPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997882"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	richardcochran@gmail.com,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net-next 02/12] igc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  3 Jul 2025 10:42:29 -0700
Message-ID: <20250703174242.3829277-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6.

It is time to convert the Intel igc driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  9 ++++--
 drivers/net/ethernet/intel/igc/igc_main.c | 21 ++-----------
 drivers/net/ethernet/intel/igc/igc_ptp.c  | 36 +++++++++++------------
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 1525ae25fd3e..97b1a2c820ee 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -315,7 +315,7 @@ struct igc_adapter {
 	 */
 	spinlock_t ptp_tx_lock;
 	struct igc_tx_timestamp_request tx_tstamp[IGC_MAX_TX_TSTAMP_REGS];
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	unsigned int ptp_flags;
 	/* System time value lock */
 	spinlock_t tmreg_lock;
@@ -773,8 +773,11 @@ void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
 void igc_ptp_stop(struct igc_adapter *adapter);
 ktime_t igc_ptp_rx_pktstamp(struct igc_adapter *adapter, __le32 *buf);
-int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr);
-int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr);
+int igc_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config);
+int igc_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack);
 void igc_ptp_tx_hang(struct igc_adapter *adapter);
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts);
 void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2e12915b42a9..3d6de62b78a2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6303,24 +6303,6 @@ int igc_close(struct net_device *netdev)
 	return 0;
 }
 
-/**
- * igc_ioctl - Access the hwtstamp interface
- * @netdev: network interface device structure
- * @ifr: interface request data
- * @cmd: ioctl command
- **/
-static int igc_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	switch (cmd) {
-	case SIOCGHWTSTAMP:
-		return igc_ptp_get_ts_config(netdev, ifr);
-	case SIOCSHWTSTAMP:
-		return igc_ptp_set_ts_config(netdev, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
 				      bool enable)
 {
@@ -6971,12 +6953,13 @@ static const struct net_device_ops igc_netdev_ops = {
 	.ndo_fix_features	= igc_fix_features,
 	.ndo_set_features	= igc_set_features,
 	.ndo_features_check	= igc_features_check,
-	.ndo_eth_ioctl		= igc_ioctl,
 	.ndo_setup_tc		= igc_setup_tc,
 	.ndo_bpf		= igc_bpf,
 	.ndo_xdp_xmit		= igc_xdp_xmit,
 	.ndo_xsk_wakeup		= igc_xsk_wakeup,
 	.ndo_get_tstamp		= igc_get_tstamp,
+	.ndo_hwtstamp_get	= igc_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set	= igc_ptp_hwtstamp_set,
 };
 
 u32 igc_rd32(struct igc_hw *hw, u32 reg)
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index f4f5c28615d3..b7b46d863bee 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -626,7 +626,7 @@ static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
  * Return: 0 in case of success, negative errno code otherwise.
  */
 static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
-				      struct hwtstamp_config *config)
+				      struct kernel_hwtstamp_config *config)
 {
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -853,48 +853,46 @@ void igc_ptp_tx_tstamp_event(struct igc_adapter *adapter)
 }
 
 /**
- * igc_ptp_set_ts_config - set hardware time stamping config
+ * igc_ptp_hwtstamp_set - set hardware time stamping config
  * @netdev: network interface device structure
- * @ifr: interface request data
+ * @config: timestamping configuration structure
+ * @extack: netlink extended ack structure for error reporting
  *
  **/
-int igc_ptp_set_ts_config(struct net_device *netdev, struct ifreq *ifr)
+int igc_ptp_hwtstamp_set(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config,
+			 struct netlink_ext_ack *extack)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
 	int err;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = igc_ptp_set_timestamp_mode(adapter, &config);
+	err = igc_ptp_set_timestamp_mode(adapter, config);
 	if (err)
 		return err;
 
 	/* save these settings for future reference */
-	memcpy(&adapter->tstamp_config, &config,
-	       sizeof(adapter->tstamp_config));
+	adapter->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
-		-EFAULT : 0;
+	return 0;
 }
 
 /**
- * igc_ptp_get_ts_config - get hardware time stamping config
+ * igc_ptp_hwtstamp_get - get hardware time stamping config
  * @netdev: network interface device structure
- * @ifr: interface request data
+ * @config: timestamping configuration structure
  *
  * Get the hwtstamp_config settings to return to the user. Rather than attempt
  * to deconstruct the settings from the registers, just return a shadow copy
  * of the last known settings.
  **/
-int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
+int igc_ptp_hwtstamp_get(struct net_device *netdev,
+			 struct kernel_hwtstamp_config *config)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config *config = &adapter->tstamp_config;
 
-	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
-		-EFAULT : 0;
+	*config = adapter->tstamp_config;
+
+	return 0;
 }
 
 /* The two conditions below must be met for cross timestamping via
-- 
2.47.1


