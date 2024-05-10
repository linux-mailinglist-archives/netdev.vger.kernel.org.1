Return-Path: <netdev+bounces-95322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8D8C1DF9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E711C21268
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954F15E800;
	Fri, 10 May 2024 06:20:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E03150994
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322002; cv=none; b=eqfGcrdh65hsizH3K85ydkr7Eo6L+z9GNySydWTbY5U6KeL0PD4S4OwAkYjmj2Lcn/GpHtBlGKnml7yixdkVGhlzHM8NyFGEwpUFQyF9ImI97OAuWxd4Z3K8sVmJxTANQEDDivJQkLHouyHUuTkZBKLyFLfmHSum1XTlg+HNXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322002; c=relaxed/simple;
	bh=VniVs3EM8zvw1S7ckS7pZoaP3gP2SwOCFd7y/E9JZ8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PB/N5rZ4goBecmGXFnzgeCvjn3IYHPtjyoNDlHyLKvasCHEvLbS6aUtPp1kt2bBDFgy6IT0ZNY145v+T6oZ3o/bCXIh8Kco9W9nu5mv6MlJ7H9SXzpHM7uKp42mViRNS1I9+KVDDo2uyU8VkS9R8xhtv4lb2GYLlMtuu5QjDKNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1715321892t262xw6e
X-QQ-Originating-IP: RV2zsxxoKCbjKH3hA4APJ7ZjTI0VdzzrtIaJYjc71bM=
Received: from lap-jiawenwu.trustnetic.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 May 2024 14:18:10 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: 2w1wQVt6itRA20tIcxrJ7zBij80JYqx3BpDDGU1UlId9EPTjRPqaJ6S6chV/G
	EGBhXEK21tETv4ej/hJkNF9AHLmMzvvaV5BiqoSVym1z0bqTxNULleB9v2r1odNZxll4zfJ
	E9UbjgCuQdy6vBAENkUrFf1WfOGgNDFo2X9BDt2szIzIXFt7VUFq6oMArDOllYh2pWh5iMW
	IRzxTRkK6QHPFhBgCS+hXz9WMkulQ9K/2VjjDu4TBy/h6VjRVN9qra+7sZaxpVEcRxxP5B8
	0G8MfpFOkdo3/3fDZ6Xn/dmG1BM2WvXwT9btpHQgA6G9WXM9Cl6j8a1H8y6GQCVyp2tZwKB
	PEUCzdc7n/Dg2E6bkBVtte07mFK68zaKZnMn6Oz+YzDBJpI9xiu/Ny6btA8nJrQIz60EVRV
	RrIf+4P4lgxnte+FSvM1rQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12687787165644850172
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Sai Krishna <saikrishnag@marvell.com>
Subject: [PATCH net v3 2/3] net: wangxun: match VLAN CTAG and STAG features
Date: Fri, 10 May 2024 14:17:50 +0800
Message-Id: <20240510061751.2240-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240510061751.2240-1-jiawenwu@trustnetic.com>
References: <20240510061751.2240-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Hardware requires VLAN CTAG and STAG configuration always matches. And
whether VLAN CTAG or STAG changes, the configuration needs to be changed
as well.

Fixes: 6670f1ece2c8 ("net: txgbe: Add netdev features support")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


