Return-Path: <netdev+bounces-96282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47528C4CF9
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1FE283B0F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C124F39FCF;
	Tue, 14 May 2024 07:25:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9639FE4
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671546; cv=none; b=ruMqbQW1BL4uAK+SQWUm6ZDAa8DDVhG6FxFisIq7mNJbJSAbNJQieMOi2KGy6Ra1OJ2qwtxoKW2NJsLy0Mb8HVonSCJfJ2AjlHcuJ3E3PbKfHKxA4sZTIFxYP7YkrPxNVl104qN0zvtYaqn3/4fFPHd5ilVHmzstLEhiOM2F00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671546; c=relaxed/simple;
	bh=RvIFluOWOpslUUQ73tC3zO9f94/GU+UEEXOwzEwNx+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YwoChQfa5alnldgRm9F06coeOdb32lD/pbLVrr72UxiRUhgDkbOOYiJLv8LidJy1Ae19jqKiw+DxX+O2gxqP3qLAoFMKCSks7ZeYDdH7w2mgYM7zv5l4CgI2AifZ/9NAhPnMs2ZYuEuM0e0sjs3dwOQfD1ot+Bf+/NHZG1+Ap4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: bizesmtpsz14t1715671429tqq91j
X-QQ-Originating-IP: Z1o6SpNAGc9jK3Far5g/wf4/y+1DSotEI0pst0znT/c=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.144.133])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 May 2024 15:23:48 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: KdphKkgTc+R8imp9R5FHPoXD9Tnwx/PWD4Ila7r1b0AkVHmigcZuKjVnW9oSs
	S0QYYFkXNFLntzrIuj6LR3j/1zlwcp6mSx2+22o30c/Y5DZaSYURLVaq/U1ZbnNkWKhAOpq
	Eq188mEfVC8/sbSI3GgGme2ySoDyD7cXbAOniHQXAb5u87YIGZBBHXeOEvWzBCeh/hiVbHC
	VCLkyHA6UMY/9hcKYr4dI2dcr/BPQGEjvUI4d5MmMfqt/IN6H8yhdkILz4XByx+ZEX05p6s
	be134si+cllPz0+6EO2x/kBtZMY/wsuy+WOBTeH5mSg7OyXMi0nqL3psXNn4kyBWjkekjnc
	9huxBO85XH8PZ0TVAzrtXCo60ia6L0UiDSAsaJnHnZTZSIZD4ESkq3XoF0sohCx95VgUPHd
	Aal2ViZ99F4=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14303428013247071284
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
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 3/3] net: txgbe: fix to control VLAN strip
Date: Tue, 14 May 2024 15:23:30 +0800
Message-Id: <20240514072330.14340-4-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240514072330.14340-1-jiawenwu@trustnetic.com>
References: <20240514072330.14340-1-jiawenwu@trustnetic.com>
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
index 28599e03cf4e..0d913ee7bcd7 100644
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


