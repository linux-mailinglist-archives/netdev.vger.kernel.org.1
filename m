Return-Path: <netdev+bounces-161984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1FAA24F30
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE433A50F3
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDB91F9F47;
	Sun,  2 Feb 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYiwf9pS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9451BDC3;
	Sun,  2 Feb 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516568; cv=none; b=IyvOHoeFZZbztfFsJbC8hE07ORtkygLmHgChET2VvrajXQ5JXMXQ1th0ba0hE/o0zZTR9j2lRax0fw1JQZ6x2zPoFkT8WJHWInD3PwgBGLw8WSbwciWJmJbopsywocAC73hKb2Uy4Eq68LL8dbePq7jCgpSReSlY9h65yWj+T+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516568; c=relaxed/simple;
	bh=Ph4sQIycokOTGg0OBXUVKkkBulVLDkdswhqF+FLZnUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P3d/he4jFi3Z9tsHHJhh5/uZa3GD2/XefcO6XAVuBGhoHCcTQDFKn8LbPo61GGhobumcCE+zUAAF72RwymX4q6brJi4nGtsW979fKK3qE0ann2e+V1nmTirLVEIQeNqUgmzwVG/CDhBeV8CrEskx0iiP01vRAStkXxKyD5lAUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYiwf9pS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2033920f8f.3;
        Sun, 02 Feb 2025 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738516565; x=1739121365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc62Mcb8WfUfiQxYaCnCZ+JSusxB/1LQagA0LnXU69I=;
        b=hYiwf9pSiomlFkfjFd8zFl+sEIUmMbJDtaqpQkAiBvqYy2rZlPOTwzXm0nPsTKQ4je
         pId6r1nfIE7/YbqTDB7DkMcqAhyLKoAYw1X4LOmyhxBs2sk1+9+a7prjallLU3vThZT3
         sRUHfrQ+NJ8C3TcV/jBTDRFkk6qFe0eBN1D4FK5oSrTzoJYlVk9T7lIin2D492YOW2YX
         WjfreONetTZHyz6F7jZTChvmm/gPamPZoSgbXFhFci1RjnTYkpQF6gfP6hmtMnNUMn7O
         AX39ZpFToGT0LtbsGJk0pCoSBtRET7bdMSViuGOYkTy5hjf77fDQrZF+cQRVrmFSLMgo
         l34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738516565; x=1739121365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gc62Mcb8WfUfiQxYaCnCZ+JSusxB/1LQagA0LnXU69I=;
        b=xM5yAu1WO9pKnJY8ChRQXovpKBzO6ceyWIUFsqruOtQE770E/otUlfqStUS6XmLfi3
         zNJb8ibayw4rECPyGEbtUbvqkCgaOYaC+LSbz43SCtAZPc6Y82jxKognnqTl/u2N3nZW
         ItBvxLHEmh2dLu5df+kH4cpDv/T6+igAlbZ9H5zcPt8lMa930SEO89qsOXl8VnYOZ32F
         tccC3hlu1v6ToVvyQ9s3E3g6e0nUoVe/3dJ47l+IEhfXj4t15qUB9/vkRliue04PKO2c
         tYqr8mT6loTMrXUoPHOZRnRTuuvWWf+DvAgvEMXnDYBODFFpKMzt0SHIYHSrXCKravLd
         XC0g==
X-Forwarded-Encrypted: i=1; AJvYcCXQboqF3aDJkK8hPyHhJ7FjtQqzY6V1PfZNA0sGH/S7rBurT0NNOomtZ5RKXFO4SbCyU1jj5dQkWJfMyaA=@vger.kernel.org, AJvYcCXexmeouCuggZVmFoFSuhuNHNEs+oc9sNk1xD6AjmvikIBGqxXZrZl1EEMfvBr1BlVKhf52bCUW@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2o2hvVIA8WovEoCb0V8Wio/LO5XePJFtuHfSq6xyuh2AmTjg
	oiXwre7IFWp6DXpDdAF1dNa+9Pum9BM27Tn3TSfde6oUBNgzw7Cw
X-Gm-Gg: ASbGncszhw8i+ShDR0S+CZHs+QltVX0PwoLg6mx3NJdfB9xf96p/NDmetJpGDb3oTel
	QWp5b/iPh8zFoxUjAwokG8qBeQZExGK1pQ4BMAMLtvAqxHLjIXZhJm1snsYcpXFtYEIQ6EniJS8
	QZIz2YGl+II91OS/68eTu0x5+0v338Fm8VWzKZ64Aykf2WY6BXfD4r20loF3HzCCSrTsjbrkSp2
	2M8xVfyWXmucc9vsYPJ4OWGmid7XZwwm1QXMSDUJaJ3y068TypXJTnap24ehkE++4eiFJNfdxuU
	L3JUkbVnyg/KikJjvnvmXdXcqnAJu7IYi7E=
X-Google-Smtp-Source: AGHT+IFEnfGxR95PvmrGvDdLZOWBVlGXHXzgm+XtnTVAW0zPWH1dengr7T0wghbeV0+bel4vM7OtZQ==
X-Received: by 2002:a5d:58f3:0:b0:38c:3f12:64a7 with SMTP id ffacd0b85a97d-38c520ba30bmr10852219f8f.50.1738516564796;
        Sun, 02 Feb 2025 09:16:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:a92:c660:cf11:24fb:f4d7:3dfa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc81d74sm161064105e9.37.2025.02.02.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 09:16:04 -0800 (PST)
From: Piotr Wejman <piotrwejman90@gmail.com>
To: 
Cc: Piotr Wejman <piotrwejman90@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Sun,  2 Feb 2025 18:08:39 +0100
Message-Id: <20250202170839.47375-1-piotrwejman90@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the driver to the new hw timestamping API.

Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 52 ++++++++--------------
 2 files changed, 20 insertions(+), 34 deletions(-)

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
index 286155efcedf..15f0794afddd 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3587,7 +3587,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca)
  * exception of "all V2 events regardless of level 2 or 4".
  **/
 static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
-				  struct hwtstamp_config *config)
+				  struct kernel_hwtstamp_config *config)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsync_tx_ctl = E1000_TSYNCTXCTL_ENABLED;
@@ -6140,7 +6140,8 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
 /**
  * e1000e_hwtstamp_set - control hardware time stamping
  * @netdev: network interface device structure
- * @ifr: interface request
+ * @config: timestamp configuration
+ * @extack: netlink extended ACK report
  *
  * Outgoing time stamping can be enabled and disabled. Play nice and
  * disable it when requested, although it shouldn't cause any overhead
@@ -6153,20 +6154,18 @@ static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr,
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
+	ret_val = e1000e_config_hwtstamp(adapter, config);
 	if (ret_val)
 		return ret_val;
 
-	switch (config.rx_filter) {
+	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
@@ -6178,38 +6177,23 @@ static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq *ifr)
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
@@ -7337,7 +7321,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_set_rx_mode	= e1000e_set_rx_mode,
 	.ndo_set_mac_address	= e1000_set_mac,
 	.ndo_change_mtu		= e1000_change_mtu,
-	.ndo_eth_ioctl		= e1000_ioctl,
+	.ndo_eth_ioctl		= e1000_mii_ioctl,
 	.ndo_tx_timeout		= e1000_tx_timeout,
 	.ndo_validate_addr	= eth_validate_addr,
 
@@ -7346,9 +7330,11 @@ static const struct net_device_ops e1000e_netdev_ops = {
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


