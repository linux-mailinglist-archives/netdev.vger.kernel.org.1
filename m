Return-Path: <netdev+bounces-92087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874428B5554
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147F41F22F00
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A792374E3;
	Mon, 29 Apr 2024 10:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D95382
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386491; cv=none; b=s5ACrX1JffPZRX5RhczLdTXDVNkLkOBjVqwQS+ZA7F3H+auUjeyg4pwebYbKiOMZ0FMDV8TNhG4PD/Q6qax0X/x04d/1oyWcv6qw1xBDBFAbyFYVGIEPAXKbWJ7uT6efb8p3tcv2s0yu0t6psaLkU7vfvx2tBn7zzArRd4Gc7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386491; c=relaxed/simple;
	bh=g5k1mtr4FpZegZxwdBiZSCn6C6/gBNdWHTtrsb2KyYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5Lz/8MLuzzB8zNqTjvB6JvNHe/69HCib1F703PwgVvpsKjNo3bhsxoOb6j096l43Ys1GdJJUq4Y7IUImZ15x1qIz/LSKWElZQC56GccAGMfvT6Mc9VxeDcSKXDIkDennnI0ezc8Wnt1MNtm4l0hFEmLqBGjpR6J4Djphba3fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz15t1714386351tqqhj5
X-QQ-Originating-IP: r5RiSFULgCTb5lvuVsPNXKmU3UWZBoLKeU6aGFrr2rw=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.150.70])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2024 18:25:50 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: p4uWNzKzFj88ZDIAM7IFIf8s84wTf1ycI/bDc+Ttpy9QMbO+QCuvQidgEz1UR
	2wXJIlB0Fjfe7a9mEeYOQ7ZzcVovX/36qoSDYD+fZFS+6ZRireGX5YEMQQxP4ItNvBxMUZ5
	ZorqRrWYEjWbzjp2NVwk358Z3ypTgSz/teLGsD6DAxm2DSXwiAgs7DHUfOR1lv77llL1Vg/
	fIAdInL8AFxzouUTDDxAY/ZVj1OXrtC8brAixLoHFQv+LeqMfevuMqvqnXYzm3c8BKoIpAx
	s1fgaSgq3b6qhs8sz4lG7PxV2ACtBUP7G9n1r34m13mKxncCt156fkYrzY1dZvv9dXIVD7S
	RZuK6q5SltpSBzU+V1v/GpxWO+A4vmyClshtRMq/rtaT+GuqQK+PK1FFCB0FutcYtn3Anxc
	G6I134m9uZ0=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16345983470524713311
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
Subject: [PATCH net v2 4/4] net: txgbe: fix to control VLAN strip
Date: Mon, 29 Apr 2024 18:25:19 +0800
Message-Id: <20240429102519.25096-5-jiawenwu@trustnetic.com>
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

When VLAN tag strip is changed to enable or disable, the hardware requires
the Rx ring to be in a disabled state, otherwise the feature cannot be
changed.

Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  2 ++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  6 ++--
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 22 ++++++++++++++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 18 +++++++----
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 18 +++++++----
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 30 +++++++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  1 +
 7 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 945c13d1a982..c09a6f744575 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1958,6 +1958,8 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
+	bitmap_zero(wx->state, WX_STATE_NBITS);
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_sw_init);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index aefd78455468..ed6a168ff136 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2692,9 +2692,9 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 
 	netdev->features = features;
 
-	if (changed &
-	    (NETIF_F_HW_VLAN_CTAG_RX |
-	     NETIF_F_HW_VLAN_STAG_RX))
+	if (wx->mac.type == wx_mac_sp && changed & NETIF_F_HW_VLAN_CTAG_RX)
+		wx->do_reset(netdev);
+	else if (changed & (NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_CTAG_FILTER))
 		wx_set_rx_mode(netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 1fdeb464d5f4..5aaf7b1fa2db 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -982,8 +982,13 @@ struct wx_hw_stats {
 	u64 qmprc;
 };
 
+enum wx_state {
+	WX_STATE_RESETTING,
+	WX_STATE_NBITS,		/* must be last */
+};
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+	DECLARE_BITMAP(state, WX_STATE_NBITS);
 
 	void *priv;
 	u8 __iomem *hw_addr;
@@ -1071,6 +1076,8 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+
+	void (*do_reset)(struct net_device *netdev);
 };
 
 #define WX_INTR_ALL (~0ULL)
@@ -1131,4 +1138,19 @@ static inline struct wx *phylink_to_wx(struct phylink_config *config)
 	return container_of(config, struct wx, phylink_config);
 }
 
+static inline int wx_set_state_reset(struct wx *wx)
+{
+	u8 timeout = 50;
+
+	while (test_and_set_bit(WX_STATE_RESETTING, wx->state)) {
+		timeout--;
+		if (!timeout)
+			return -EBUSY;
+
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
 #endif /* _WX_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 786a652ae64f..46a5a3e95202 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -52,7 +52,7 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -64,6 +64,10 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -72,14 +76,16 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	ngbe_down(wx);
 
@@ -89,7 +95,9 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	wx_configure(wx);
 	ngbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int ngbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index db675512ce4d..31fde3fa7c6b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -19,7 +19,7 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	struct wx *wx = netdev_priv(netdev);
 	u32 new_rx_count, new_tx_count;
 	struct wx_ring *temp_ring;
-	int i;
+	int i, err = 0;
 
 	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
 	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
@@ -31,6 +31,10 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	    new_rx_count == wx->rx_ring_count)
 		return 0;
 
+	err = wx_set_state_reset(wx);
+	if (err)
+		return err;
+
 	if (!netif_running(wx->netdev)) {
 		for (i = 0; i < wx->num_tx_queues; i++)
 			wx->tx_ring[i]->count = new_tx_count;
@@ -39,14 +43,16 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 		wx->tx_ring_count = new_tx_count;
 		wx->rx_ring_count = new_rx_count;
 
-		return 0;
+		goto clear_reset;
 	}
 
 	/* allocate temporary buffer to store rings in */
 	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
 	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
-	if (!temp_ring)
-		return -ENOMEM;
+	if (!temp_ring) {
+		err = -ENOMEM;
+		goto clear_reset;
+	}
 
 	txgbe_down(wx);
 
@@ -55,7 +61,9 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 
 	txgbe_up(wx);
 
-	return 0;
+clear_reset:
+	clear_bit(WX_STATE_RESETTING, wx->state);
+	return err;
 }
 
 static int txgbe_set_channels(struct net_device *dev,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index b3c0058b045d..8c7a74981b90 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -269,6 +269,8 @@ static int txgbe_sw_init(struct wx *wx)
 	wx->tx_work_limit = TXGBE_DEFAULT_TX_WORK;
 	wx->rx_work_limit = TXGBE_DEFAULT_RX_WORK;
 
+	wx->do_reset = txgbe_do_reset;
+
 	return 0;
 }
 
@@ -421,6 +423,34 @@ int txgbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
+static void txgbe_reinit_locked(struct wx *wx)
+{
+	int err = 0;
+
+	netif_trans_update(wx->netdev);
+
+	err = wx_set_state_reset(wx);
+	if (err) {
+		wx_err(wx, "wait device reset timeout\n");
+		return;
+	}
+
+	txgbe_down(wx);
+	txgbe_up(wx);
+
+	clear_bit(WX_STATE_RESETTING, wx->state);
+}
+
+void txgbe_do_reset(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (netif_running(netdev))
+		txgbe_reinit_locked(wx);
+	else
+		txgbe_reset(wx);
+}
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 1b4ff50d5857..f434a7865cb7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -134,6 +134,7 @@ extern char txgbe_driver_name[];
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
 int txgbe_setup_tc(struct net_device *dev, u8 tc);
+void txgbe_do_reset(struct net_device *netdev);
 
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
-- 
2.27.0


