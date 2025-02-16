Return-Path: <netdev+bounces-166792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C86A3755B
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 17:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F7E1891A21
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E28199947;
	Sun, 16 Feb 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCGfLaHX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967531991A4;
	Sun, 16 Feb 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739721723; cv=none; b=Fs9yqGpSXZ5Jqjy7CciPs3XdFfTAZDeQSCOZ7ZsVfYhVkwJD+tO60Dv8KXnWmqyJEBfaGjwqrqIjJn4I8mJRKVaJiqwu8IWDxxZ94aXx2XwLPv8uTHNlfddXUM19B2ECNN2ZX2KKL3B/1bmuYR33aoYP1ZMGVTOHrxyeZ7IXc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739721723; c=relaxed/simple;
	bh=9LVn7hy38egnDqA67dnq8vGM8l7L+X/42a9EoAxr9To=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnM8Lx+eNdIa+88yckHHA+BYIvn68QPRg38jeU8tg46PUbjJHs976BGxKBrT4O0+k9px+wC1wsN48SWQQPh8peGZQFmHZdzBZy74YDZcwhR6RgGmM2qrdBvhzLvI0256mf9V4nVUzOwL5peKTLBPOvCGeeEG2mucXgM2YZAzp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCGfLaHX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f24fc466aso2534825f8f.2;
        Sun, 16 Feb 2025 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739721720; x=1740326520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BbUw1c1JOQIlxC4TeNRgzkU2NKaHh/NvpIvOxIRfJY0=;
        b=CCGfLaHXrO7zBDVjYlGovH2wACbAEVzlVbDQNT3sOBaS0bN7BpcHz3LWQ2KiQcomNQ
         PraHIPWIJESHOUJl3nOS2WVX2IGgEDIiopucI65LFl07Y+uqdrji/yUIe6oYCL0g5zGO
         LPX4K/cLTB1BjSoEFAC9DZv6je9H3kh+OTrYsXCeT9j6fpVFALTAGbA2Uyqvo+3Lz8v9
         g2uFKW8ZyJgJ/8OxfjHB9+sk3d38hy909AFwvaQJueppf7ZacnRcGItCCqvcoSqRD1qP
         I3v/O0ce7yMnBp3nwK6Vv/OH5dGMIK6P+n22BeiIIc8Fqvjw98JoRGByiVTjX5ITGeUg
         fhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739721720; x=1740326520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbUw1c1JOQIlxC4TeNRgzkU2NKaHh/NvpIvOxIRfJY0=;
        b=DdNJ+q+b0dbpcXP9FZvAALWYiY18qL9+GrHO6lkw7LSyCXFHBn7ES1LahGRHBmLB+i
         soyY+0nx17n+etlUc0rI9NMTV4wG7fILxOaBJp0OrzzH5b4lnVZ7gqRr+jNt7oIN7Eq6
         eC4cOlJvJ0uRTIPCXIlQbC0iHGhATGbfcvz3O/ywg4fBfJp6+vfBrdZV1WfZYlq0QAWW
         WwG8m1dX5GUZD1/jOJq9wN4veOrcieqEA4s76C9Bhqjjd55UX6GpRXfwBreBrIfe1rEz
         LajLkkRYTRE/Haeh2FIBIMclGS5U+/aBDjAUpIFz8973WAyy/nZWpM+ZH9bzK1iiO4CR
         Xhdw==
X-Forwarded-Encrypted: i=1; AJvYcCV22ucLw4d9curq3IZZNqHDQYMOq4hD0tDW/RSq/Ubw0KmLjdUekjSfOASsBpVTRy6VX8kkNIkIUC98iY4=@vger.kernel.org, AJvYcCVrUdOCXjRSgGmTeZ4hFu7WvHXJMeWC9pTcrQ+g5QFhdllG4WSU3XhXHE7SWIur4L/NF0I2v8j1@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0sGE72ihoNxBpnNjUpUn56Uwio9gyabB2FyPOSHQ0I3yan92
	5s8PkPfQf8WYvmfxO28j17VwvmSHKAtZoK+DUemWENQANaQTclkf
X-Gm-Gg: ASbGncsTL0ilMDlo1CJmF7wW3oCDPDPgo7tMXwFc+ggbS5IUvZB/FSOYnQLp99kX7mT
	Oews8aTy2FweX0+EUUDc9q8thq7Xd1DpHLoi45nZJtdzIj1qNjGb8nGA1+004MV5rutQL6/uO9T
	OrkRWZbEaZF0+ej11Ufvk4j7dMTLcX3gk77AuTIbkVL4u5L1PY0YS0xRRerV/iGDm9JIM2zmCaS
	7H2hN23tSr/BM1mpdHKfvpB7xOZF7rFqIgEgnnQ0CA4X/VUmmKni3MZf6w7X4zPvtgsifj27Vl7
	jCxe90qfUZ/NQjoMVHPxwKGHzo6p
X-Google-Smtp-Source: AGHT+IG773EBbxr/8BmHY+hEC2ivt+Y27B2ALPOEMnFLMRnN7wzGv18SFHpN8LvmF4i9DV5DjKkx6w==
X-Received: by 2002:a05:6000:1f87:b0:38f:2c10:da07 with SMTP id ffacd0b85a97d-38f340735d8mr6657944f8f.45.1739721719467;
        Sun, 16 Feb 2025 08:01:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:d870:1798:194c:aafb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm9962334f8f.72.2025.02.16.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:01:58 -0800 (PST)
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH iwl-next v3] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Sun, 16 Feb 2025 16:57:28 +0100
Message-Id: <20250216155729.63862-1-wejmanpm@gmail.com>
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
Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
---
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
 drivers/net/ethernet/intel/e1000e/netdev.c | 73 +++++++++++-----------
 2 files changed, 36 insertions(+), 39 deletions(-)

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
index 286155efcedf..1485c46ecb88 100644
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
 
@@ -3693,7 +3699,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	ew32(TSYNCTXCTL, regval);
 	if ((er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_ENABLED) !=
 	    (regval & E1000_TSYNCTXCTL_ENABLED)) {
-		e_err("Timesync Tx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack, "Timesync Tx Control register not set as expected");
 		return -EAGAIN;
 	}
 
@@ -3706,7 +3712,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 				 E1000_TSYNCRXCTL_TYPE_MASK)) !=
 	    (regval & (E1000_TSYNCRXCTL_ENABLED |
 		       E1000_TSYNCRXCTL_TYPE_MASK))) {
-		e_err("Timesync Rx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack, "Timesync Rx Control register not set as expected");
 		return -EAGAIN;
 	}
 
@@ -3901,6 +3907,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 {
 	struct ptp_clock_info *info = &adapter->ptp_clock_info;
 	struct e1000_hw *hw = &adapter->hw;
+	struct netlink_ext_ack extack = {};
 	unsigned long flags;
 	u32 timinca;
 	s32 ret_val;
@@ -3932,7 +3939,11 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
-	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
+	ret_val = e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config, &extack);
+	if (ret_val) {
+		if (extack._msg)
+			e_err("%s\n", extack._msg);
+	}
 }
 
 /**
@@ -6079,8 +6090,8 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
-			   int cmd)
+static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr,
+		       int cmd)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct mii_ioctl_data *data = if_mii(ifr);
@@ -6140,7 +6151,8 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 /**
  * e1000e_hwtstamp_set - control hardware time stamping
  * @netdev: network interface device structure
- * @ifr: interface request
+ * @config: timestamp configuration
+ * @extack: netlink extended ACK report
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
@@ -6153,20 +6165,18 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
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
@@ -6178,38 +6188,23 @@ static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
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
@@ -7346,9 +7341,11 @@ static const struct net_device_ops e1000e_netdev_ops = {
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


