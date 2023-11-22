Return-Path: <netdev+bounces-50010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2617F43E6
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3536028164B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7112D618;
	Wed, 22 Nov 2023 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E983
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:30:14 -0800 (PST)
X-QQ-mid: bizesmtp82t1700648820thirpb0a
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 18:26:59 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJmYm/MasAAUBdpb5jz569s8/hBR+zFaid3tqVdoUu22qj4RjX9jt
	KUJNU9NvgW1RNaG2A5/9UoW7pYouxd3r7tCS8KeczuvUnYO2H8fMrj4E6YfHXLXq8Jr2xLh
	OiZicOUxMoRxEpOkcjeHkr/6eneiVxtCfj+lm8iYCF5bMcVfwYSsZ1Vfolk5sxl/YnJZ4b6
	uU/eleyB57pPZWEIex8CGZ5QShS3S4jrRJx8pQLnfDvBag36kibnHzhm5l/FbGpU3m8R6rE
	usaOUkvoZssEggeqcbO916fXCIWc8LGDvXQyz3wv/j3kbpfo3MOOnX6003p58RnqLT4B5TH
	XL3+CSWuSju0Bl/jXmHHNkmRQYXHvVGG3sDF8PA+gQDBWbmAOXa2cJppkz/DwW2iwdnyvil
	c0RKQ9MLN/SIGcmteFrM5g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4996602249448214998
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	horms@kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next 2/5] net: wangxun: add ethtool_ops for ring parameters
Date: Wed, 22 Nov 2023 18:22:23 +0800
Message-Id: <20231122102226.986265-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231122102226.986265-1-jiawenwu@trustnetic.com>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1

Support to query RX/TX depth with ethtool -g, and change RX/TX depth
with ethtool -G.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 18 +++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 76 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 48 ++++++++++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  3 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 45 +++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +
 11 files changed, 213 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ddc5f6d20b9c..2a09d1df3b0f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -185,3 +185,21 @@ void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
 	}
 }
 EXPORT_SYMBOL(wx_get_drvinfo);
+
+void wx_get_ringparam(struct net_device *netdev,
+		      struct ethtool_ringparam *ring,
+		      struct kernel_ethtool_ringparam *kernel_ring,
+		      struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	ring->rx_max_pending = WX_MAX_RXD;
+	ring->tx_max_pending = WX_MAX_TXD;
+	ring->rx_mini_max_pending = 0;
+	ring->rx_jumbo_max_pending = 0;
+	ring->rx_pending = wx->rx_ring_count;
+	ring->tx_pending = wx->tx_ring_count;
+	ring->rx_mini_pending = 0;
+	ring->rx_jumbo_pending = 0;
+}
+EXPORT_SYMBOL(wx_get_ringparam);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 16d1a09369a6..77545d0eec56 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -13,4 +13,8 @@ void wx_get_mac_stats(struct net_device *netdev,
 void wx_get_pause_stats(struct net_device *netdev,
 			struct ethtool_pause_stats *stats);
 void wx_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info);
+void wx_get_ringparam(struct net_device *netdev,
+		      struct ethtool_ringparam *ring,
+		      struct kernel_ethtool_ringparam *kernel_ring,
+		      struct netlink_ext_ack *extack);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 2823861e5a92..6645aff415f8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2741,4 +2741,80 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+int wx_set_ring(struct wx *wx, u32 new_tx_count, u32 new_rx_count)
+{
+	struct wx_ring *temp_ring;
+	int i, err = 0;
+
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = vmalloc(i * sizeof(struct wx_ring));
+
+	if (!temp_ring)
+		return -ENOMEM;
+
+	/* Setup new Tx resources and free the old Tx resources in that order.
+	 * We can then assign the new resources to the rings via a memcpy.
+	 * The advantage to this approach is that we are guaranteed to still
+	 * have resources even in the case of an allocation failure.
+	 */
+	if (new_tx_count != wx->tx_ring_count) {
+		for (i = 0; i < wx->num_tx_queues; i++) {
+			memcpy(&temp_ring[i], wx->tx_ring[i],
+			       sizeof(struct wx_ring));
+
+			temp_ring[i].count = new_tx_count;
+			err = wx_setup_tx_resources(&temp_ring[i]);
+			if (err) {
+				while (i) {
+					i--;
+					wx_free_tx_resources(&temp_ring[i]);
+				}
+				goto err_setup;
+			}
+		}
+
+		for (i = 0; i < wx->num_tx_queues; i++) {
+			wx_free_tx_resources(wx->tx_ring[i]);
+
+			memcpy(wx->tx_ring[i], &temp_ring[i],
+			       sizeof(struct wx_ring));
+		}
+
+		wx->tx_ring_count = new_tx_count;
+	}
+
+	/* Repeat the process for the Rx rings if needed */
+	if (new_rx_count != wx->rx_ring_count) {
+		for (i = 0; i < wx->num_rx_queues; i++) {
+			memcpy(&temp_ring[i], wx->rx_ring[i],
+			       sizeof(struct wx_ring));
+
+			temp_ring[i].count = new_rx_count;
+			err = wx_setup_rx_resources(&temp_ring[i]);
+			if (err) {
+				while (i) {
+					i--;
+					wx_free_rx_resources(&temp_ring[i]);
+				}
+				goto err_setup;
+			}
+		}
+
+		for (i = 0; i < wx->num_rx_queues; i++) {
+			wx_free_rx_resources(wx->rx_ring[i]);
+			memcpy(wx->rx_ring[i], &temp_ring[i],
+			       sizeof(struct wx_ring));
+		}
+
+		wx->rx_ring_count = new_rx_count;
+	}
+
+err_setup:
+	vfree(temp_ring);
+
+	return err;
+}
+EXPORT_SYMBOL(wx_set_ring);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index df1f4a5951f0..b4bf11684a1d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -29,5 +29,6 @@ int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
+int wx_set_ring(struct wx *wx, u32 new_tx_count, u32 new_rx_count);
 
 #endif /* _NGBE_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index dc217437ec56..bdb2c3d33197 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -402,6 +402,12 @@ enum WX_MSCA_CMD_value {
 
 #define WX_MAX_RXD                   8192
 #define WX_MAX_TXD                   8192
+#define WX_MIN_RXD                   128
+#define WX_MIN_TXD                   128
+
+/* Number of Transmit and Receive Descriptors must be a multiple of 8 */
+#define WX_REQ_RX_DESCRIPTOR_MULTIPLE   8
+#define WX_REQ_TX_DESCRIPTOR_MULTIPLE   8
 
 #define WX_MAX_JUMBO_FRAME_SIZE      9432 /* max payload 9414 */
 #define VMDQ_P(p)                    p
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 5baa89118600..42bd82b03488 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -7,7 +7,10 @@
 
 #include "../libwx/wx_ethtool.h"
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
+#include "../libwx/wx_hw.h"
 #include "ngbe_ethtool.h"
+#include "ngbe_type.h"
 
 static void ngbe_get_wol(struct net_device *netdev,
 			 struct ethtool_wolinfo *wol)
@@ -71,6 +74,49 @@ static int ngbe_set_pauseparam(struct net_device *netdev,
 	return 0;
 }
 
+static int ngbe_set_ringparam(struct net_device *netdev,
+			      struct ethtool_ringparam *ring,
+			      struct kernel_ethtool_ringparam *kernel_ring,
+			      struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	int i, err = 0;
+
+	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
+		return -EINVAL;
+
+	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
+
+	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
+
+	if (new_tx_count == wx->tx_ring_count &&
+	    new_rx_count == wx->rx_ring_count)
+		return 0;
+
+	if (!netif_running(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			wx->tx_ring[i]->count = new_tx_count;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx->rx_ring[i]->count = new_rx_count;
+		wx->tx_ring_count = new_tx_count;
+		wx->rx_ring_count = new_rx_count;
+
+		return 0;
+	}
+
+	ngbe_down(wx);
+
+	err = wx_set_ring(wx, new_tx_count, new_rx_count);
+
+	wx_configure(wx);
+	ngbe_up(wx);
+
+	return err;
+}
+
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -86,6 +132,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= ngbe_get_pauseparam,
 	.set_pauseparam		= ngbe_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= ngbe_set_ringparam,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 8db804543e66..0c0b2f7bdf74 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -334,7 +334,7 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
-static void ngbe_down(struct wx *wx)
+void ngbe_down(struct wx *wx)
 {
 	phy_stop(wx->phydev);
 	ngbe_disable_device(wx);
@@ -342,7 +342,7 @@ static void ngbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
-static void ngbe_up(struct wx *wx)
+void ngbe_up(struct wx *wx)
 {
 	wx_configure_vectors(wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index ff754d69bdf6..0a98080a197a 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -130,4 +130,7 @@
 
 extern char ngbe_driver_name[];
 
+void ngbe_down(struct wx *wx);
+void ngbe_up(struct wx *wx);
+
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index 8812d92d8b58..abbccef81557 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -7,6 +7,7 @@
 
 #include "../libwx/wx_ethtool.h"
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
 #include "txgbe_type.h"
 #include "txgbe_ethtool.h"
 
@@ -49,6 +50,48 @@ static int txgbe_set_pauseparam(struct net_device *netdev,
 	return phylink_ethtool_set_pauseparam(txgbe->phylink, pause);
 }
 
+static int txgbe_set_ringparam(struct net_device *netdev,
+			       struct ethtool_ringparam *ring,
+			       struct kernel_ethtool_ringparam *kernel_ring,
+			       struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	int i, err = 0;
+
+	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
+		return -EINVAL;
+
+	new_tx_count = clamp_t(u32, ring->tx_pending, WX_MIN_TXD, WX_MAX_TXD);
+	new_tx_count = ALIGN(new_tx_count, WX_REQ_TX_DESCRIPTOR_MULTIPLE);
+
+	new_rx_count = clamp_t(u32, ring->rx_pending, WX_MIN_RXD, WX_MAX_RXD);
+	new_rx_count = ALIGN(new_rx_count, WX_REQ_RX_DESCRIPTOR_MULTIPLE);
+
+	if (new_tx_count == wx->tx_ring_count &&
+	    new_rx_count == wx->rx_ring_count)
+		return 0;
+
+	if (!netif_running(wx->netdev)) {
+		for (i = 0; i < wx->num_tx_queues; i++)
+			wx->tx_ring[i]->count = new_tx_count;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			wx->rx_ring[i]->count = new_rx_count;
+		wx->tx_ring_count = new_tx_count;
+		wx->rx_ring_count = new_rx_count;
+
+		return 0;
+	}
+
+	txgbe_down(wx);
+
+	err = wx_set_ring(wx, new_tx_count, new_rx_count);
+
+	txgbe_up(wx);
+
+	return err;
+}
+
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= txgbe_nway_reset,
@@ -62,6 +105,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= txgbe_get_pauseparam,
 	.set_pauseparam		= txgbe_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= txgbe_set_ringparam,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 526250102db2..9b1b92fa318f 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -290,7 +290,7 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
-static void txgbe_down(struct wx *wx)
+void txgbe_down(struct wx *wx)
 {
 	struct txgbe *txgbe = netdev_to_txgbe(wx->netdev);
 
@@ -302,6 +302,12 @@ static void txgbe_down(struct wx *wx)
 	wx_clean_all_rx_rings(wx);
 }
 
+void txgbe_up(struct wx *wx)
+{
+	wx_configure(wx);
+	txgbe_up_complete(wx);
+}
+
 /**
  *  txgbe_init_type_code - Initialize the shared code
  *  @wx: pointer to hardware structure
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 3ba9ce43f394..13a2f3f53c39 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -129,6 +129,9 @@
 
 extern char txgbe_driver_name[];
 
+void txgbe_down(struct wx *wx);
+void txgbe_up(struct wx *wx);
+
 static inline struct txgbe *netdev_to_txgbe(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
-- 
2.27.0


