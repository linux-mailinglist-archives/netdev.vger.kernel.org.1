Return-Path: <netdev+bounces-92085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79E8B5552
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FBA285100
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86433A8EF;
	Mon, 29 Apr 2024 10:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C1374E3
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386478; cv=none; b=Aln72nIPEPnRNDFyNHGtxLXkrjyNzDb0LIwHn/cRc62wTfG1vO3dgP26kRLZMgt7IIsN8XOW2RsuU2qYzLoa/2gHx8eilFvObUnlAYZuVJbKTJS4XcxWBI+SxRtEKCNAjZoclgfCzdTjV05nrlsD5ZAYM4+QpCjACWajs3Maeok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386478; c=relaxed/simple;
	bh=puKM/F/ejiCdcBF0UKxXGBl0TZKGmVfO+iS4STG5KnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELwPH6xU4grXEYtzsOY3tLHdWvIN/biXv5atUdy2r3o/4jOYdgVjwzBhfI4K7HJ7dxMYXz2ZMHR/sNcHLEg/CmNAdVN1kPrwHShGpI8cXI9YCnWU6XWsdAXIAK321ilGqbY19fz+iJCMBtEkwHoNAA9MqxZDQyLsavwIN1tdugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1714386347tqml09
X-QQ-Originating-IP: WMfuFipb9zkSkV9gxcO+uNdSTKCnjlTzDN07ww5t3ho=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.150.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2024 18:25:46 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: bQsUcYFpAAa3gskZs1tMbYWt1FaSIm+OPeZTtTenf2AUHplxG3PwRb+3wRoVD
	fa2l0b4gYcJJnH5M0PkFpdH4jak67zTfCf9d73bsMxtmUCRYKOQ1CqUjz/dlGst3G9c2fno
	OvWLAfMU9ztzFEMpUJTdMqsG9r3lNzSwyY6zw6KJ5NMZPh8dSSVP6WyAbEfVB8B68zpxb7/
	YZO+Szsd3wRpCONJHWhCs6QI7UGT0fZjD3u7aAB7r6J5Grp7052dzCoj7bCEG3nMXG3/NC8
	v956F57UboIgl2REwmH9rsqjZXz8u3lZqRZ9foEEBcsD864rUsvB+TEwzX3vLl5QrqNhJjF
	M0e0UxjUKLiOtE8Dx8vEAPTi8hwxMODi/F7JzHDfvgIhPytLQP5+jDPJhxkSUes9DqFtVom
	KlAcRbH6rBU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 15531716025499074061
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v2 3/4] net: wangxun: match VLAN CTAG and STAG features
Date: Mon, 29 Apr 2024 18:25:18 +0800
Message-Id: <20240429102519.25096-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240429102519.25096-1-jiawenwu@trustnetic.com>
References: <20240429102519.25096-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hardware requires VLAN CTAG and STAG configuration always matches. And
whether VLAN CTAG or STAG changes, the configuration needs to be changed
as well.

Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 46 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 667a5675998c..aefd78455468 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2701,6 +2701,52 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features)
+{
+	netdev_features_t changed = netdev->features ^ features;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_FILTER) {
+		if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+			features |= NETIF_F_HW_VLAN_STAG_FILTER;
+		else
+			features &= ~NETIF_F_HW_VLAN_STAG_FILTER;
+	}
+	if (changed & NETIF_F_HW_VLAN_STAG_FILTER) {
+		if (features & NETIF_F_HW_VLAN_STAG_FILTER)
+			features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+		else
+			features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		if (features & NETIF_F_HW_VLAN_CTAG_RX)
+			features |= NETIF_F_HW_VLAN_STAG_RX;
+		else
+			features &= ~NETIF_F_HW_VLAN_STAG_RX;
+	}
+	if (changed & NETIF_F_HW_VLAN_STAG_RX) {
+		if (features & NETIF_F_HW_VLAN_STAG_RX)
+			features |= NETIF_F_HW_VLAN_CTAG_RX;
+		else
+			features &= ~NETIF_F_HW_VLAN_CTAG_RX;
+	}
+	if (changed & NETIF_F_HW_VLAN_CTAG_TX) {
+		if (features & NETIF_F_HW_VLAN_CTAG_TX)
+			features |= NETIF_F_HW_VLAN_STAG_TX;
+		else
+			features &= ~NETIF_F_HW_VLAN_STAG_TX;
+	}
+	if (changed & NETIF_F_HW_VLAN_STAG_TX) {
+		if (features & NETIF_F_HW_VLAN_STAG_TX)
+			features |= NETIF_F_HW_VLAN_CTAG_TX;
+		else
+			features &= ~NETIF_F_HW_VLAN_CTAG_TX;
+	}
+
+	return features;
+}
+EXPORT_SYMBOL(wx_fix_features);
+
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index ec909e876720..c41b29ea812f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -30,6 +30,8 @@ int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features);
 void wx_set_ring(struct wx *wx, u32 new_tx_count,
 		 u32 new_rx_count, struct wx_ring *temp_ring);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index fdd6b4f70b7a..e894e01d030d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -499,6 +499,7 @@ static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bd4624d14ca0..b3c0058b045d 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -428,6 +428,7 @@ static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_start_xmit         = wx_xmit_frame,
 	.ndo_set_rx_mode        = wx_set_rx_mode,
 	.ndo_set_features       = wx_set_features,
+	.ndo_fix_features       = wx_fix_features,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_set_mac_address    = wx_set_mac,
 	.ndo_get_stats64        = wx_get_stats64,
-- 
2.27.0


