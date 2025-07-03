Return-Path: <netdev+bounces-203894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC09FAF7F45
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE8A1CA1F79
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719102F2703;
	Thu,  3 Jul 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViHceeIZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AD2F235C
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564572; cv=none; b=GjjBqMl2tbvO8tjWWadtoIJDUH3Od9firZ6rjG8Am+HC+2OMEYCT3VVhILK/a+AIw3eplG71Hm+5SrdsufZ9FRNYZsSk6P90HunITGQ9KbkINqvM4Tr/8yink4/XKU1N5B/vp2WeQDciJMRVZ+iCP4kj39UZkmurAnWQB0k1kH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564572; c=relaxed/simple;
	bh=Ijs4tGWCXvta4vTZ5VR+auTktvYAZxnnGT393R7ZZGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edcu8xXk6Xb8b1RP3dXLQaiswKgBwFWi1PaMqHMy1Igl4ApBIzY8D+NerDIQS1AHW8jeZ9AXJiKMB/AzzKtbDyv3iAGfVSK8aKI/sli/SLgmZFS3HH4DfMhrZEIYy2B8Bhlu5ruaTdrBfb7vEbslVUt110kic1YuQBRjx/qUxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViHceeIZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564571; x=1783100571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ijs4tGWCXvta4vTZ5VR+auTktvYAZxnnGT393R7ZZGE=;
  b=ViHceeIZm+d6eysRxsRyegsdKBSSCq+CD1dztdf9UprR6hl3buPHhJ50
   XNCOeBsFb/GnqM7DjAJSTRSvmZ+QHG8KH3QqcjBumdhnqu1Lf+oQA3HiJ
   mD0V/RxFx1Niqj8a+ThRcNHURcQQZxj1CuZDkfq4j14su/h+nzBzCMyJ+
   E3AKNJxcpoSZVb5dAmBI5n7fnXvMrQ15JUKV7b0V5JQS7188lkH+cJoR3
   geEhF5GrQM5A+5kdZOkDmzOSma5yxLFvrqMRTzxMPk4r0Y0mM4dR/i2Le
   dFcoU6vz/sSUG0uFoatou1MkL+HG4GBndMmFuSFjAPdIx4MZoVStsCar4
   w==;
X-CSE-ConnectionGUID: DYK5D1i6RuKVff1uHAuyEQ==
X-CSE-MsgGUID: UdCmgzkzTL+4M/ck5TYCDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767919"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767919"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:49 -0700
X-CSE-ConnectionGUID: XKDRx6iRQG+GlmJ8KOcCrg==
X-CSE-MsgGUID: d9AVainbSs2+YPO8upLRfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997891"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 04/12] ixgbe: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  3 Jul 2025 10:42:31 -0700
Message-ID: <20250703174242.3829277-5-anthony.l.nguyen@intel.com>
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

It is time to convert the Intel ixgbe driver to the new API, so that
timestamping configuration can be removed from the ndo_eth_ioctl() path
completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  9 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 42 +++++++++----------
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index c6772cd2d802..39ae17d4a727 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -785,7 +785,7 @@ struct ixgbe_adapter {
 	struct ptp_clock_info ptp_caps;
 	struct work_struct ptp_tx_work;
 	struct sk_buff *ptp_tx_skb;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long ptp_tx_start;
 	unsigned long last_overflow_check;
 	unsigned long last_rx_ptp_check;
@@ -1080,8 +1080,11 @@ static inline void ixgbe_ptp_rx_hwtstamp(struct ixgbe_ring *rx_ring,
 	rx_ring->last_rx_timestamp = jiffies;
 }
 
-int ixgbe_ptp_set_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr);
-int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr);
+int ixgbe_ptp_hwtstamp_get(struct net_device *netdev,
+			   struct kernel_hwtstamp_config *config);
+int ixgbe_ptp_hwtstamp_set(struct net_device *netdev,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
 void ixgbe_ptp_start_cyclecounter(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_reset(struct ixgbe_adapter *adapter);
 void ixgbe_ptp_check_pps_event(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6eccfba51fac..991cf24f3b9b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9441,10 +9441,6 @@ static int ixgbe_ioctl(struct net_device *netdev, struct ifreq *req, int cmd)
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
 	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		return ixgbe_ptp_set_ts_config(adapter, req);
-	case SIOCGHWTSTAMP:
-		return ixgbe_ptp_get_ts_config(adapter, req);
 	case SIOCGMIIPHY:
 		if (!adapter->hw.phy.ops.read_reg)
 			return -EOPNOTSUPP;
@@ -10908,6 +10904,8 @@ static const struct net_device_ops ixgbe_netdev_ops = {
 	.ndo_bpf		= ixgbe_xdp,
 	.ndo_xdp_xmit		= ixgbe_xdp_xmit,
 	.ndo_xsk_wakeup         = ixgbe_xsk_wakeup,
+	.ndo_hwtstamp_get	= ixgbe_ptp_hwtstamp_get,
+	.ndo_hwtstamp_set	= ixgbe_ptp_hwtstamp_set,
 };
 
 static void ixgbe_disable_txr_hw(struct ixgbe_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index eef25e11d938..40be99def2ee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -936,20 +936,22 @@ void ixgbe_ptp_rx_rgtstamp(struct ixgbe_q_vector *q_vector,
 }
 
 /**
- * ixgbe_ptp_get_ts_config - get current hardware timestamping configuration
- * @adapter: pointer to adapter structure
- * @ifr: ioctl data
+ * ixgbe_ptp_hwtstamp_get - get current hardware timestamping configuration
+ * @netdev: pointer to net device structure
+ * @config: timestamping configuration structure
  *
  * This function returns the current timestamping settings. Rather than
  * attempt to deconstruct registers to fill in the values, simply keep a copy
  * of the old settings around, and return a copy when requested.
  */
-int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr)
+int ixgbe_ptp_hwtstamp_get(struct net_device *netdev,
+			   struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config *config = &adapter->tstamp_config;
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 
-	return copy_to_user(ifr->ifr_data, config,
-			    sizeof(*config)) ? -EFAULT : 0;
+	*config = adapter->tstamp_config;
+
+	return 0;
 }
 
 /**
@@ -978,7 +980,7 @@ int ixgbe_ptp_get_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr)
  * mode, if required to support the specifically requested mode.
  */
 static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
-				 struct hwtstamp_config *config)
+					struct kernel_hwtstamp_config *config)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 tsync_tx_ctl = IXGBE_TSYNCTXCTL_ENABLED;
@@ -1129,31 +1131,29 @@ static int ixgbe_ptp_set_timestamp_mode(struct ixgbe_adapter *adapter,
 }
 
 /**
- * ixgbe_ptp_set_ts_config - user entry point for timestamp mode
- * @adapter: pointer to adapter struct
- * @ifr: ioctl data
+ * ixgbe_ptp_hwtstamp_set - user entry point for timestamp mode
+ * @netdev: pointer to net device structure
+ * @config: timestamping configuration structure
+ * @extack: netlink extended ack structure for error reporting
  *
  * Set hardware to requested mode. If unsupported, return an error with no
  * changes. Otherwise, store the mode for future reference.
  */
-int ixgbe_ptp_set_ts_config(struct ixgbe_adapter *adapter, struct ifreq *ifr)
+int ixgbe_ptp_hwtstamp_set(struct net_device *netdev,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
 	int err;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	err = ixgbe_ptp_set_timestamp_mode(adapter, &config);
+	err = ixgbe_ptp_set_timestamp_mode(adapter, config);
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
 
 static void ixgbe_ptp_link_speed_adjust(struct ixgbe_adapter *adapter,
-- 
2.47.1


