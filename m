Return-Path: <netdev+bounces-96862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A16E8C8114
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0E6B21556
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AE14A99;
	Fri, 17 May 2024 06:54:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9D14A83
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928846; cv=none; b=dxh85X2YpwlbfsI/aOYY2cd2/HToa4MkJdrimzE8FsaDLNb8ajqK9rzJx0nqcEx4Bq9I24M3Rt3aT2Z2UH2r8mxyj0Fnl4nKXFFMo27VbFueixlHudZYpl7srs+jIQfNRHO//0Csytvqy3TfYYRipYvJsdtBcCETl+Tp6GLmSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928846; c=relaxed/simple;
	bh=SghmxwaN3InCmTiES4IbCJMa/blNS9oTQ9RmIYDLvdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmU0JN4DRbPEGSVo6z6yFXKjoN94CJ4s1tjd667uaHfKgE7k5m07gWPO/ga/ohPdkEQEBmmjJnWEVko5BKPxbYYgGmkA17KB4RH8sttRryrmw3aELXqK891dixukR9fpgZW4xFDYnPmKWQFb1KLJ6AW/GeZPKIEHblZq99HNSvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz11t1715928723t0kri0
X-QQ-Originating-IP: FgP+Bul1XMA/AEHrtZdcspUI6IlYBI+NmZYMNQo5hp0=
Received: from lap-jiawenwu.trustnetic.com ( [115.206.162.36])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 May 2024 14:52:02 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: zMjFVoZKJLJmDRkwYmjsyzNdVWoYEqzzH7JEhQEtZfZJzfAxuFuvrXN7jXcTh
	z7XRMWh2Pwhdw3xOp78ZrEwinoHbWf0/VFWon330ma4FtOJIq639LcBr9KYYTYx7CM/qEkD
	RDayIEb8/2q9Za/NTcr/Iz2o8zp+BysyTw7chWxk4Pezar6qt0PrZ2kXX/sdLcSUa5L0WHW
	Ds+dgrM6R3BFqunOSBKjorsaGuOq41b7SaPa5G8w9NSL+smkUGCq31djlBiRKOrBJzsbDSm
	lljU17cgat9gqOGPUc/MeM9DZMwu4XQlm0t38klzVYPS81WOGpghyKOWzJ3izwbdVO0L0QK
	MYU20lfPESe1xEdYWbtrJFl01LBPoe8EhhsQg9liFfnVXX03Ot1neNdo0/6CJOSJ3Z//uk4
	DjcajniRyGuKiNCA9529Ng==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8709234239134961024
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
	duanqiangwen@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Sai Krishna <saikrishnag@marvell.com>
Subject: [PATCH net v5 2/3] net: wangxun: match VLAN CTAG and STAG features
Date: Fri, 17 May 2024 14:51:39 +0800
Message-Id: <20240517065140.7148-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240517065140.7148-1-jiawenwu@trustnetic.com>
References: <20240517065140.7148-1-jiawenwu@trustnetic.com>
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
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 46 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  1 +
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  1 +
 4 files changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 667a5675998c..d0cb09a4bd3d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2701,6 +2701,52 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+#define NETIF_VLAN_STRIPPING_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
+					 NETIF_F_HW_VLAN_STAG_RX)
+
+#define NETIF_VLAN_INSERTION_FEATURES	(NETIF_F_HW_VLAN_CTAG_TX | \
+					 NETIF_F_HW_VLAN_STAG_TX)
+
+#define NETIF_VLAN_FILTERING_FEATURES	(NETIF_F_HW_VLAN_CTAG_FILTER | \
+					 NETIF_F_HW_VLAN_STAG_FILTER)
+
+netdev_features_t wx_fix_features(struct net_device *netdev,
+				  netdev_features_t features)
+{
+	netdev_features_t changed = netdev->features ^ features;
+	struct wx *wx = netdev_priv(netdev);
+
+	if (changed & NETIF_VLAN_STRIPPING_FEATURES) {
+		if ((features & NETIF_VLAN_STRIPPING_FEATURES) != NETIF_VLAN_STRIPPING_FEATURES &&
+		    (features & NETIF_VLAN_STRIPPING_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_STRIPPING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN stripping must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_INSERTION_FEATURES) {
+		if ((features & NETIF_VLAN_INSERTION_FEATURES) != NETIF_VLAN_INSERTION_FEATURES &&
+		    (features & NETIF_VLAN_INSERTION_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_INSERTION_FEATURES;
+			features |= netdev->features & NETIF_VLAN_INSERTION_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN insertion must be either both on or both off.");
+		}
+	}
+
+	if (changed & NETIF_VLAN_FILTERING_FEATURES) {
+		if ((features & NETIF_VLAN_FILTERING_FEATURES) != NETIF_VLAN_FILTERING_FEATURES &&
+		    (features & NETIF_VLAN_FILTERING_FEATURES) != 0) {
+			features &= ~NETIF_VLAN_FILTERING_FEATURES;
+			features |= netdev->features & NETIF_VLAN_FILTERING_FEATURES;
+			wx_err(wx, "802.1Q and 802.1ad VLAN filtering must be either both on or both off.");
+		}
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


