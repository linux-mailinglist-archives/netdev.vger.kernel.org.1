Return-Path: <netdev+bounces-54346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941B806B30
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 11:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DEE281993
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FE123761;
	Wed,  6 Dec 2023 10:01:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F5DFA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 02:00:57 -0800 (PST)
X-QQ-mid: bizesmtp87t1701856762tu3aaj5p
Received: from wxdbg.localdomain.com ( [115.204.154.156])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 Dec 2023 17:59:21 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: RrZlkntZBfnFrr4yXYoPg8WQGoomSJ4qtLeLUc6pOxuGKVD4A5PNgOy5wc1tV
	+znh5Zr1lhWF5xIkxumS1/haUtjYj2HLLlTgiuIb8Qjb4EDyV2/9MSdQc2k5FM3D/ZAqsWe
	b4qaK4WirFvpiZ6DbOhT73I3rE/RecMn1GE0sEdPsPd4UzaPBPXtVoJx92xHpx40qRkGfb8
	by23WuTUFzRmUiI5GOVBBlVEJl9wBP0HGJyXy+AG0dzxjhvZRxeNVANaXWOBjW5x/nS3KJU
	upB+IYEiiEdg1h3fokyFAbK7+0fV+34rEIKCx7evkTC5/w2tvHHEGGVkGRM1XGshCstfh6o
	ekshnnKPjS+vUV8t42Kpgw+RUmS+eDV/ewtnpBURZ/68I4F0oDhSmAtZ8OXE85EIfYLe5jK
	fLA4Gjwv6iiby6TsoSzZNQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8024650953681781428
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 4/7] net: wangxun: add ethtool_ops for ring parameters
Date: Wed,  6 Dec 2023 17:53:52 +0800
Message-Id: <20231206095355.1220086-5-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
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
index 8f3088ba6477..136a2d59fa5a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -230,3 +230,21 @@ int wx_set_pauseparam(struct net_device *netdev,
 	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
 }
 EXPORT_SYMBOL(wx_set_pauseparam);
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
index 7d3d85f212eb..7651ec4b7dd9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -22,4 +22,8 @@ void wx_get_pauseparam(struct net_device *netdev,
 		       struct ethtool_pauseparam *pause);
 int wx_set_pauseparam(struct net_device *netdev,
 		      struct ethtool_pauseparam *pause);
+void wx_get_ringparam(struct net_device *netdev,
+		      struct ethtool_ringparam *ring,
+		      struct kernel_ethtool_ringparam *kernel_ring,
+		      struct netlink_ext_ack *extack);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index a5a50b5a8816..50c5034c3253 100644
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
index 7f2bdc2b966d..f63d4f9279e0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -412,6 +412,12 @@ enum WX_MSCA_CMD_value {
 
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
index 9a89f9576180..9e4a17554fa0 100644
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
@@ -41,6 +44,49 @@ static int ngbe_set_wol(struct net_device *netdev,
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
+		return -EOPNOTSUPP;
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
@@ -56,6 +102,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= wx_get_pauseparam,
 	.set_pauseparam		= wx_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= ngbe_set_ringparam,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index c61f4b9d79fa..497c9b51f822 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -335,7 +335,7 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
-static void ngbe_down(struct wx *wx)
+void ngbe_down(struct wx *wx)
 {
 	phylink_stop(wx->phylink);
 	phylink_disconnect_phy(wx->phylink);
@@ -344,7 +344,7 @@ static void ngbe_down(struct wx *wx)
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
index cdaa19528248..f907695f0976 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -7,9 +7,52 @@
 
 #include "../libwx/wx_ethtool.h"
 #include "../libwx/wx_type.h"
+#include "../libwx/wx_lib.h"
 #include "txgbe_type.h"
 #include "txgbe_ethtool.h"
 
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
+		return -EOPNOTSUPP;
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
 	.nway_reset		= wx_nway_reset,
@@ -23,6 +66,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= wx_get_pauseparam,
 	.set_pauseparam		= wx_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= txgbe_set_ringparam,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ffb7a182baf3..748480589fb8 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -288,7 +288,7 @@ static void txgbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
-static void txgbe_down(struct wx *wx)
+void txgbe_down(struct wx *wx)
 {
 	txgbe_disable_device(wx);
 	txgbe_reset(wx);
@@ -298,6 +298,12 @@ static void txgbe_down(struct wx *wx)
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
index 5494ea88df0a..801fd0aed1ff 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -129,6 +129,9 @@
 
 extern char txgbe_driver_name[];
 
+void txgbe_down(struct wx *wx);
+void txgbe_up(struct wx *wx);
+
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
 		.name = _NAME,			\
-- 
2.27.0


