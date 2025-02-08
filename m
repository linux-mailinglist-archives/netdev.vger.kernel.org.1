Return-Path: <netdev+bounces-164343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11475A2D6FC
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 16:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172751886153
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785A1B4F02;
	Sat,  8 Feb 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNjElbO7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9B14A4F9;
	Sat,  8 Feb 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739029524; cv=none; b=sjUKANRHBqD7/I0Iu130kKC67hm5N9b1dDq4rJ1WTkxCoZ73PP9FkhFfquC9hZO5V24DipFELxQtAob+9LFml7riqz7v6gRtxKtrRlGSNsX3ox3c0BLcA7XHIh2SLbaz1QgCpx4RoBRB0cuHvauCMZgnIv4wxMzUGAwNh06f3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739029524; c=relaxed/simple;
	bh=V8tUT4Osd4SAdzShJCz+NHhB7qHovicI4fmYOvwXu/g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HWDMsqbRkYtLptE98xvFqpsNWQMSKmmz5kJhD4Xurf3PPcMZtLUkqUGhOtMI+5PRy4SY7gquicw9K8ngCqwsMpwxyyAEN4GZZJMy7m/xhKyeOfkv6raVSetfgyo9xn/EmMGu4th0gMnpLAv2GRd10O+dklr519o4qFPVKmB/W7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNjElbO7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43934d41730so3753455e9.2;
        Sat, 08 Feb 2025 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739029521; x=1739634321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+uT+U1EtT2Wpz/dMctFha4plI+Mxk76y4F5kqaxtpiI=;
        b=hNjElbO78x9xTfkdBbOJmA97CcVWD223k6RBnGTkE2CLPJV6CDIYY75arlZ1x46t3y
         uE22UmOSBBQY5xA3vKVnd2Iz/7SlUIzltHSuXQj2aj2NFb1o3aUW2VWVTNlVg54EfhR+
         vuqVhGlPKBoAmqRI/9qfHdE1KnZowGLO3SltDj2YoX5DULK0Ve4PmPL8ALJcB+0qFUqn
         VGtiV1EbWGEESGi9NQtjk9qJU6qIw3vJe5/nqZCDqfUEMCQSeEWvd1EGXGSB3UOGEKdr
         k1FdM/8AqYuFqD86IHR/ig0gFW4Vwl6R3CVDthk1DRkhQ8Piiw/vVt3o7nYHyKpfdID5
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739029521; x=1739634321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uT+U1EtT2Wpz/dMctFha4plI+Mxk76y4F5kqaxtpiI=;
        b=G2x6k7TI4fyTfQ3rE6Z9au6IerIsg3c9CF+tzrjykzHpiPX42eqvWNtTBQwuFpMvN/
         Nf1FGnKOyvqla4897l0Yc/un13Ur5AB44GkZu871BMAZyMLRZTRd/JSkTVZG20iQtg67
         uwXNh7ZZyYjBvUVM20zA+IlEU2hTVkCAjzSDKTWp4N00d8DbKjwp3lJELB/sctcU52EI
         sbvME9aDbwhMQJ84WiFyVgxgiiMURDLqvV+f/GN2HkqhPfQ+gEt+C1zwjdzZLCu+MIXZ
         DqtX2ft5d55jk23F2fPJy5yywk+w+BInOMslu6+Sb5rA0wJvyCkbi7zFpmEhHUE1lwV8
         Jkdg==
X-Forwarded-Encrypted: i=1; AJvYcCVUi3rDQilWbRhhIX3m/3bMxplYi5g+Yo3ULBpx2M2bMKALgFl6yPrMX0VA+SkS2+kRHsnrsEC9tZAoXnY=@vger.kernel.org, AJvYcCWKPzHx4Etv0SPspWidOZLc0FmWuvSOhFLSvb+Zaq3H3aNcbuopUI9Z4cGiObz1GLCpwRdfyO44@vger.kernel.org
X-Gm-Message-State: AOJu0YwLE5odhVo7x3Lq1FI0/Xa0hY3jMjQXIfwZbn01CBxAKx68e5gF
	W+cqsP8eFQoDSy7TfzyUSxMhRC+LAfPptlWQVL/Q/SI46WkFWa8R
X-Gm-Gg: ASbGncsbPzJk3C+GFfO7eQzmsjSZB5MUd6PSC7ofS8129kRy+gN3ui6+7pJHF1qMzmq
	3OYUpyF6mVdWv43jnlnNvHuNXZsfbCIa0ww0BVyzTuxNFUX/j/yLJ0C6u4VgNAxlp3Zw9+V2Oku
	OiLluQ1TdkhHqha6b/b34zjWwh6j1ojij+uEQ7jd9bbY8VeDZrPzRHYUeyQGrHBl6WyPfQ0Qhgq
	aUnA2+IWg8xHtek50wbolbtcP9WnoNbFBni84Yow9pLBuwDnsoqya4GRtcMfGdny8OSbbfXFpI0
	1F+iorsBGwugZP4OL1xKjmf9jDLp
X-Google-Smtp-Source: AGHT+IHluwwAjXf04y50yLIxgiLJ0wsSQFnUUuleCSt1AYy/xobTI7OcnQVqA4ezyViuGT7gP7cUEw==
X-Received: by 2002:a5d:47a7:0:b0:38d:d8b2:ceef with SMTP id ffacd0b85a97d-38dd8b2d243mr212402f8f.13.1739029520538;
        Sat, 08 Feb 2025 07:45:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:4e6d:9fdf:c6ef:8c92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da96502sm91571575e9.1.2025.02.08.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:45:19 -0800 (PST)
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
Cc: Piotr Wejman <wejmanpm@gmail.com>
Subject: [PATCH v2] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Sat,  8 Feb 2025 16:43:49 +0100
Message-Id: <20250208154350.75316-1-wejmanpm@gmail.com>
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
Use Netlink extack for error reporting in e1000e_hwtstamp_set.
Align the indentation of net_device_ops.

Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
---
Changes in v2:
  - amend commit message
  - use extack for error reporting
  - rename e1000_mii_ioctl to e1000_ioctl
  - Link to v1: https://lore.kernel.org/netdev/20250202170839.47375-1-piotrwejman90@gmail.com/

 drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 68 ++++++++++------------
 2 files changed, 31 insertions(+), 39 deletions(-)

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
index 286155efcedf..43933e64819b 100644
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
+		NL_SET_ERR_MSG(extack, "No HW timestamp support\n");
 		return -EINVAL;
+	}
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
@@ -3608,6 +3612,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	case HWTSTAMP_TX_ON:
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported TX HW timestamp type\n");
 		return -ERANGE;
 	}
 
@@ -3681,6 +3686,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported RX HW timestamp filter\n");
 		return -ERANGE;
 	}
 
@@ -3693,7 +3699,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	ew32(TSYNCTXCTL, regval);
 	if ((er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_ENABLED) !=
 	    (regval & E1000_TSYNCTXCTL_ENABLED)) {
-		e_err("Timesync Tx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack, "Timesync Tx Control register not set as expected\n");
 		return -EAGAIN;
 	}
 
@@ -3706,7 +3712,7 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 				 E1000_TSYNCRXCTL_TYPE_MASK)) !=
 	    (regval & (E1000_TSYNCRXCTL_ENABLED |
 		       E1000_TSYNCRXCTL_TYPE_MASK))) {
-		e_err("Timesync Rx Control register not set as expected\n");
+		NL_SET_ERR_MSG(extack, "Timesync Rx Control register not set as expected\n");
 		return -EAGAIN;
 	}
 
@@ -3932,7 +3938,7 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
 	spin_unlock_irqrestore(&adapter->systim_lock, flags);
 
 	/* restore the previous hwtstamp configuration settings */
-	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
+	e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config, NULL);
 }
 
 /**
@@ -6079,8 +6085,8 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
-			   int cmd)
+static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr,
+		       int cmd)
 {
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct mii_ioctl_data *data = if_mii(ifr);
@@ -6140,7 +6146,8 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 /**
  * e1000e_hwtstamp_set - control hardware time stamping
  * @netdev: network interface device structure
- * @ifr: interface request
+ * @config: timestamp configuration
+ * @extack: netlink extended ACK report
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
@@ -6153,20 +6160,18 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
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
@@ -6178,38 +6183,23 @@ static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
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
@@ -7346,9 +7336,11 @@ static const struct net_device_ops e1000e_netdev_ops = {
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


