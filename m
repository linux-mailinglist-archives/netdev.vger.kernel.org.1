Return-Path: <netdev+bounces-181786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 760C3A8678C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5771A7AE40C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834629DB7B;
	Fri, 11 Apr 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkMqwtmC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AD29CB34
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404258; cv=none; b=NQpK7cfUj7AET7qiyZBLMkV6w/30hWCQWaS4EsEAb2gMPuJtS+gQTCnILhvofyb4EVvGkG/txNHFQst7NgeyZWP5nWFq3Nrvt7Q/9V+4W0SuvmVzgD8NevpJuxc25TbdvSqvxV4uITmJ9YrNRRx7gfNcHLHWQySeurdyjY+nWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404258; c=relaxed/simple;
	bh=Ro0CpcYqahPXWL+uBApzqLjjB6QlyaDCvpBfv9jq7lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW4o5a7r3OSKzTLen0sHN6oQgGKX6OIWH9pMRlg5Ayb+E8+9TpzF2nsfLDLoZgNiYe1yG/WzN2xsCsnSUrzwmnrQ3CJp/PDbgOieKBqdoNYMeJzmtBAoHsRD+i+Kc4wOQWzFKa9vAh/zi0FzKWJvn1l3Vk5oUblesn9ARaoNdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkMqwtmC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404257; x=1775940257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ro0CpcYqahPXWL+uBApzqLjjB6QlyaDCvpBfv9jq7lc=;
  b=jkMqwtmCO5aeEuAv5VF87yUi2T82B0SCecTc1SrZJL8fqOi/dS0Eq2n6
   6Wtv8tKJYPEs5CQmlg5SZwKxqm3+0U1I2Xmb4jJwMqUuBQEKDDIx3V69M
   fIWZWCcIvushIZ4ppMytaSLpB3aQeV0S83Q4F1mKc94ScEoA2fX/90ojX
   yN2FSTzsMAQfHCyO8BMM9jN3e4u1SufYcIKGjS6VuazG5Y9akqa6HtW31
   H1WbzHeaOmiitQ8NryG5Enls+ql5mGea+mI7nJjIc5WIsvk6qlRBtY+QQ
   cBmp5Q4b/KyLYcUN1Q4Xr6hvzShe1ZkirJHUZKTqSXRuKbwd9b2fy2kYo
   g==;
X-CSE-ConnectionGUID: d25WlApLSuyh54yg2/7t0g==
X-CSE-MsgGUID: xmEogVuaSPa8jwQHqipotA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103939"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103939"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:08 -0700
X-CSE-ConnectionGUID: TFSU7r8YQsGg3z/MpO8sxw==
X-CSE-MsgGUID: ZFXCrzfpRIqDt28IoVpW4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241838"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Piotr Wejman <wejmanpm@gmail.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	richardcochran@gmail.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 15/15] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Fri, 11 Apr 2025 13:43:56 -0700
Message-ID: <20250411204401.3271306-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Wejman <wejmanpm@gmail.com>

Update the driver to use the new hardware timestamping API added in commit
66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
Use Netlink extack for error reporting in e1000e_config_hwtstamp.
Align the indentation of net_device_ops.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 75 +++++++++++-----------
 2 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index ba9c19e6994c..952898151565 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -319,7 +319,7 @@ struct e1000_adapter {
 	u16 tx_ring_count;
 	u16 rx_ring_count;
 
-	struct hwtstamp_config hwtstamp_config;
+	struct kernel_hwtstamp_config hwtstamp_config;
 	struct delayed_work systim_overflow_work;
 	struct sk_buff *tx_hwtstamp_skb;
 	unsigned long tx_hwtstamp_start;
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 8ebcb6a7d608..e0f492a6723f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3574,6 +3574,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
  * e1000e_config_hwtstamp - configure the hwtstamp registers and enable/disable
  * @adapter: board private structure
  * @config: timestamp configuration
+ * @extack: netlink extended ACK for error report
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
@@ -3587,7 +3588,8 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
  * exception of "all V2 events regardless of level 2 or 4".
  **/
 static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
-				  struct hwtstamp_config *config)
+				  struct kernel_hwtstamp_config *config,
+				  struct netlink_ext_ack *extack)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsync_tx_ctl = E1000_TSYNCTXCTL_ENABLED;
@@ -3598,8 +3600,10 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	bool is_l2 = false;
 	u32 regval;
 
-	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
+	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP)) {
+		NL_SET_ERR_MSG(extack, "No HW timestamp support");
 		return -EINVAL;
+	}
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -3608,6 +3612,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	case HWTSTAMP_TX_ON:
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported TX HW timestamp type");
 		return -ERANGE;
 	}
 
@@ -3681,6 +3686,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported RX HW timestamp filter");
 		return -ERANGE;
 	}
 
@@ -3693,7 +3699,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	ew32(TSYNCTXCTL, regval);
 	if ((er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_ENABLED) !=
 	    (regval & E1000_TSYNCTXCTL_ENABLED)) {
-		e_err("Timesync Tx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack,
+			       "Timesync Tx Control register not set as expected");
 		return -EAGAIN;
 	}
 
@@ -3706,7 +3713,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 				 E1000_TSYNCRXCTL_TYPE_MASK)) !=
 	    (regval & (E1000_TSYNCRXCTL_ENABLED |
 		       E1000_TSYNCRXCTL_TYPE_MASK))) {
-		e_err("Timesync Rx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack,
+			       "Timesync Rx Control register not set as expected");
 		return -EAGAIN;
 	}
 
@@ -3901,6 +3909,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 {
 	struct ptp_clock_info *info = &adapter->ptp_clock_info;
 	struct e1000_hw *hw = &adapter->hw;
+	struct netlink_ext_ack extack = {};
 	unsigned long flags;
 	u32 timinca;
 	s32 ret_val;
@@ -3932,7 +3941,12 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
-	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
+	ret_val = e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config,
+					 &extack);
+	if (ret_val) {
+		if (extack._msg)
+			e_err("%s\n", extack._msg);
+	}
 }
 
 /**
@@ -6079,8 +6093,7 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
-			   int cmd)
+static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct mii_ioctl_data *data = if_mii(ifr);
@@ -6140,7 +6153,8 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 /**
  * e1000e_hwtstamp_set - control hardware time stamping
  * @netdev: network interface device structure
- * @ifr: interface request
+ * @config: timestamp configuration
+ * @extack: netlink extended ACK report
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
@@ -6153,20 +6167,18 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
  * specified. Matching the kind of event packet is not supported, with the
  * exception of "all V2 events regardless of level 2 or 4".
  **/
-static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
+static int e1000e_hwtstamp_set(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
-	struct hwtstamp_config config;
 	int ret_val;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	ret_val = e1000e_config_hwtstamp(adapter, &config);
+	ret_val = e1000e_config_hwtstamp(adapter, config, extack);
 	if (ret_val)
 		return ret_val;
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
@@ -6178,38 +6190,23 @@ static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
 		 * by hardware so notify the caller the requested packets plus
 		 * some others are time stamped.
 		 */
-		config.rx_filter = HWTSTAMP_FILTER_SOME;
+		config->rx_filter = HWTSTAMP_FILTER_SOME;
 		break;
 	default:
 		break;
 	}
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
 }
 
-static int e1000e_hwtstamp_get(struct net_device *netdev, struct ifreq *ifr)
+static int e1000e_hwtstamp_get(struct net_device *netdev,
+			       struct kernel_hwtstamp_config *kernel_config)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
-	return copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
-			    sizeof(adapter->hwtstamp_config)) ? -EFAULT : 0;
-}
+	*kernel_config = adapter->hwtstamp_config;
 
-static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	switch (cmd) {
-	case SIOCGMIIPHY:
-	case SIOCGMIIREG:
-	case SIOCSMIIREG:
-		return e1000_mii_ioctl(netdev, ifr, cmd);
-	case SIOCSHWTSTAMP:
-		return e1000e_hwtstamp_set(netdev, ifr);
-	case SIOCGHWTSTAMP:
-		return e1000e_hwtstamp_get(netdev, ifr);
-	default:
-		return -EOPNOTSUPP;
-	}
+	return 0;
 }
 
 static int e1000_init_phy_wakeup(struct e1000_adapter *adapter, u32 wufc)
@@ -7346,9 +7343,11 @@ static const struct net_device_ops e1000e_netdev_ops = {
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= e1000_netpoll,
 #endif
-	.ndo_set_features = e1000_set_features,
-	.ndo_fix_features = e1000_fix_features,
+	.ndo_set_features	= e1000_set_features,
+	.ndo_fix_features	= e1000_fix_features,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
+	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
 };
 
 /**
-- 
2.47.1


