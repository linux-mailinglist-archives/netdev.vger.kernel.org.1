Return-Path: <netdev+bounces-95323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85CC8C1DFA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311D71F2192A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F241527BE;
	Fri, 10 May 2024 06:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B557160793
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322005; cv=none; b=TAbZksQGc/7HMbcyBjDVpyW58sgLG5F7ky+eGpZz9FwGHloVydsOR8oJgNNkjArQ6AXuJpxI3w9tJ7ryzQYyQkP2y6WochUf24A/vv1Y4/g9rRPIf7jp1vlL3unH18raKz1ijJmpUkskVqsUXBwRtDk4nXd1pclnv/fD9YoK77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322005; c=relaxed/simple;
	bh=vtAVilsiZSbnB4ZFVwporyX6i7CM61izaiA6/BpOLDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ox8VXtxTfY9BxiNoscDvGVnVyRlL6RElFC5Uq3QbcJDNM0D6baJBDWOxPgxCYJh4A7v5MBg/QLg/xReRnYyyhB4OrgRQw768nrBLv1EBTKHkL2K2Xhw4wFbwhjbt7Mq1MJJfa6SC9hr1xurFWmuNyGFwsFzXrM9XBp7uo8bW6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtp88t1715321895tx1guwsw
X-QQ-Originating-IP: +5y98LSP46g17EhEqFXuqWQSrLuBp10OtBHWiDCCkNA=
Received: from lap-jiawenwu.trustnetic.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 May 2024 14:18:14 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: CaRLl5kt3FEK+Wrv7fm28zYo1HcpvP6iuLto5g97aBIvMqiP0ZyQufoUE4Po8
	HGmQ49RchUMqkh/aAzBhovGnJfN8hTMOSFQLfzkPGwelvbqZgKhZTJ0UTABkk3fhkI0Lw4a
	A0Qd1CqnRqExJaLJ/k84XhNstTKEE3D4PbSIkTF4IyEvNJDtWKj2IkyWmyan4mLScd6cJgy
	ta0tsbyw9UUYlqZHHnPtT7bTNB51jr/bY3rf2Bfn0600vShujdl1lTwXgHcUhMoN2oii8KR
	AQqgqxbFWeMfGdUxc/Tfdr1aYGY44HloRgDfbyHVVLXlAe9XWcHdAaqk7Mm9uzxCe0as7rw
	Jwc+DqFdJZU49oqdkywAPX9y8RCmtsDTAbi6kJoFmeeeDXDn2hbBG3iH9lL0qjiA6XYaE+J
	oy6q9ExN6H4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11531294132219828683
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
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net v3 3/3] net: txgbe: fix to control VLAN strip
Date: Fri, 10 May 2024 14:17:51 +0800
Message-Id: <20240510061751.2240-4-jiawenwu@trustnetic.com>
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

When VLAN tag strip is changed to enable or disable, the hardware requires
the Rx ring to be in a disabled state, otherwise the feature cannot be
changed.

Fixes: f3b03c655f67 ("net: wangxun: Implement vlan add and kill functions")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


