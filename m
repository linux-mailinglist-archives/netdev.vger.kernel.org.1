Return-Path: <netdev+bounces-168760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC1A40870
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D30317EBB0
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FEE20767E;
	Sat, 22 Feb 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6ekktay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0C1FCD03;
	Sat, 22 Feb 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228672; cv=none; b=gaBXMwQ23nof9OgYYpdcSMh7rI6b7akdTKLsXneuwsQ4kBfukI6buggs3wmU7xZvZ+pbIksP3hyOvE48MpqMxoNHSEPtHfJk8272ob4C6N7ME/9QbHn0sQIvf9oXlWdVOXr20mU1buXSXrvyCGYN8bG+0U3V+LrdH5lwYhGsIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228672; c=relaxed/simple;
	bh=vCciVTX7FshF5d2vzf725uz4inIClu1X8tLtCopCPaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glx0pZUOAG7onKvP1Rlekw8IqNthZg6ls5nzeWbEPdKKD9bgZvxpKT8/vi3L3qhcD6ghhlL7t89puURKmv8PP1WnGSCWaccU5x9cdSYgr4NndhaaXbnR2poYml8aDyUceOwaFVVh+QMBlCl0VB29boWDYn3xWlUpVIPL9hykfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6ekktay; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so2199831f8f.0;
        Sat, 22 Feb 2025 04:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740228669; x=1740833469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIB85NX55cr0Sxu2JumigyhMRgow9LLzALrybUQOOEw=;
        b=a6ekktaydpflcSSZLSPfignvTr675IxIiqKdZ9O6HVQbbFpuIjvApJ/XCHGZ5tseSe
         c4gujAcL5VI7nGSDDps9DIIjsZ++ZU1ZOe+6zAy6OVqda0zX8aq/pgNix5cZZk1CFlls
         J5iU4Mn59uJexPDBNnLA6S19iRHb30+26VNJZnLdAmqTcRwJ/19NllJ/QjyXPy4Se1x1
         7GDbkkxL3p9e+CyuA6X7/i2zRFO9I16/dAT1clmpNK7TtxyFRHXmMsAoFqCyFT438HH4
         E4BcwT7pmn66MxJ3130wf1rMSqkAhIsBJN2jTmCUWF7562WMQhCvpmtQPxgzBeKHHEjt
         8JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740228669; x=1740833469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIB85NX55cr0Sxu2JumigyhMRgow9LLzALrybUQOOEw=;
        b=jjXTvJOXg4l2xnLnPkvhobl7rdjnSFX/+Slaabm1L6h29OayJzICDUMErGiOJRpLQt
         H9i1KLmrW55Qt6x7vNh1cKChASh8YLuIhNSU5FdxztPxD/m26nGvBLVyV4Hkin5H/Hen
         wW6ey3Jbgamq6C8L/HQS5EEfemytZRkgfQC7/auXZu/rAwwuo+5mamTc/zOeCeFT+HDT
         Mq9XuQ5OwaNP+B7OdqQ/G5DanjHwpk72sUybBSbNBP2qytSPAIXk618RKQ4BgqzMeeDA
         HImIBfMMk0SYZ53tKftCElhT54extV8mc3uo4FCenpdn6r0OxM3JSlLT0SeqakycBz7a
         aJHw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZCqJCSTu3YT60YWxYhvtkAGPwOU3SBuSnr/UhkrOBkllbSm8imOOHp6wnNdJpV11UyNTmqjY@vger.kernel.org, AJvYcCUjoL8kF4uBaElKRrRZ/QnhNIv0+5ijhMy6d7wtti4lfuzpft5T+rXAYDSzbxZi6q8TGMnXjdkTB2uvTlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADzEDFOQHDsjshfwGUpEbNrN1nhwRJTGd7sN1O7ffD442hlLR
	YYq0rLiwUqF1erpkxBhuagplqrYU+fMNRqFaNNEj8F9S8J6WI8Vm
X-Gm-Gg: ASbGnctKhsOSZGHOFVDWvHqK17y2zkKe3++fQq/riuO3crXAZX8ICXMce9jfbX6lL8a
	tOMK/TGLLi0UXxflDt4TTAUiSQ0ZRnxFLNYOKC7mMAvjj4DUY2/fPoSAmuacl06w0TM+uRRyI/x
	JBH5SEAE3XiDe3RX+TcFAzks1sZGmVmP8iTPf0jos0shBUUugcdZwcjFW/qejtY0i4ASc8FtX7R
	hUIldu0c78eBwjaBZcRoHQR4urVydwtX32jbHcrnXCvnm/hh6lUTIeb/ZtlpSPgveEn3fO2mi9F
	H2FImbziaAqzbvt+10DBo7yvH5Bum4ZMqxQsv3g=
X-Google-Smtp-Source: AGHT+IFIj+StWfoqjrtFysljTebHXH3AcvVHZLMeJi3pe/2IE8kYMkcE6K3cgL7B8b7Fxb+tHFrIWA==
X-Received: by 2002:a05:6000:154a:b0:38f:50fd:55a8 with SMTP id ffacd0b85a97d-38f70783eeamr5033329f8f.6.1740228668610;
        Sat, 22 Feb 2025 04:51:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:b3a6:504f:bfca:6782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915719sm26416065f8f.60.2025.02.22.04.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 04:51:08 -0800 (PST)
From: Piotr Wejman <wejmanpm@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Piotr Wejman <wejmanpm@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [PATCH iwl-next v4] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Sat, 22 Feb 2025 13:46:29 +0100
Message-Id: <20250222124629.35797-1-wejmanpm@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the driver to use the new hardware timestamping API added in commit
66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
Use Netlink extack for error reporting in e1000e_config_hwtstamp.
Align the indentation of net_device_ops.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
---
Changes in v4:
  - fix line wrappnig
  - Linke to v3: https://lore.kernel.org/netdev/20250216155729.63862-1-wejmanpm@gmail.com/

Changes in v3:
  - remove new lines at the end of the extack
  - add error print in e1000e_systim_reset
  - Link to v2: https://lore.kernel.org/netdev/20250208154350.75316-1-wejmanpm@gmail.com/

Changes in v2:
  - amend commit message
  - use extack for error reporting
  - rename e1000_mii_ioctl to e1000_ioctl
  - Link to v1: https://lore.kernel.org/netdev/20250202170839.47375-1-piotrwejman90@gmail.com/

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
index 286155efcedf..e3887a5c7601 100644
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
2.25.1


