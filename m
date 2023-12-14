Return-Path: <netdev+bounces-57214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3488125B4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C607E28356D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D522ECF;
	Thu, 14 Dec 2023 03:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FC7AF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:01:54 -0800 (PST)
X-QQ-mid: bizesmtp68t1702522810tfur37yi
Received: from wxdbg.localdomain.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Dec 2023 11:00:10 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: mRz6/7wsmIjk9AFEUVIxAoI/DtLkoPLa1ZzMsmK1qgNDFUY105QugHBDYv4aO
	DAhIQRl8f55sC2xLQBU9qys4N8RVO73DR4JpA+766U/TNjlENHPvwPLyNPhTu5PRukIjIo4
	HSwm0JVhGqmsV03XXtbnjytCRafJBx1mVnp5vM/MJh0sJqveAJ5U5heXb6x1U94+KFUQI0P
	peCsa9iZr0lCPrSJ6CUnjw1UDRTbitOR4L4IWpBagd0jr1NwawND63dQCubbvYxzari/wsz
	06OhUMdB6v0VORPfavXdonLykGU7qyDI5zosCxPSON4j8HvIm1/aplh463sgW7Nk50+Un3n
	CLLtwBaCeYe/nnIm/phtsAcxzxo0QyIIU1dXNtrfxwNrH+zdLQGlHjYazZGAi8qSDgmrXMH
	XQg7SkrZakA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17783319847953058482
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
Subject: [PATCH net-next v5 5/8] net: wangxun: add ethtool_ops for ring parameters
Date: Thu, 14 Dec 2023 10:54:53 +0800
Message-Id: <20231214025456.1387175-6-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
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
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 ++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 66 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.h   |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  6 ++
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 56 ++++++++++++++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  4 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  3 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 53 +++++++++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  8 ++-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  3 +
 11 files changed, 220 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index e4d2bbf7dad6..77da6111fbce 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -229,3 +229,21 @@ int wx_set_pauseparam(struct net_device *netdev,
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
index a5a50b5a8816..f721096f4450 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -2741,4 +2741,70 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 }
 EXPORT_SYMBOL(wx_set_features);
 
+void wx_set_ring(struct wx *wx, u32 new_tx_count,
+		 u32 new_rx_count, struct wx_ring *temp_ring)
+{
+	int i, err = 0;
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
+				wx_err(wx, "setup new tx resources failed, keep using the old config\n");
+				while (i) {
+					i--;
+					wx_free_tx_resources(&temp_ring[i]);
+				}
+				return;
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
+				wx_err(wx, "setup new rx resources failed, keep using the old config\n");
+				while (i) {
+					i--;
+					wx_free_rx_resources(&temp_ring[i]);
+				}
+				return;
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
+}
+EXPORT_SYMBOL(wx_set_ring);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
index df1f4a5951f0..af1381c13d9e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.h
@@ -29,5 +29,7 @@ int wx_setup_resources(struct wx *wx);
 void wx_get_stats64(struct net_device *netdev,
 		    struct rtnl_link_stats64 *stats);
 int wx_set_features(struct net_device *netdev, netdev_features_t features);
+void wx_set_ring(struct wx *wx, u32 new_tx_count,
+		 u32 new_rx_count, struct wx_ring *temp_ring);
 
 #endif /* _NGBE_LIB_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 09befcda0cf0..d3a17e404111 100644
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
index 9a89f9576180..12d114597c28 100644
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
@@ -41,6 +44,57 @@ static int ngbe_set_wol(struct net_device *netdev,
 	return 0;
 }
 
+static int ngbe_set_ringparam(struct net_device *netdev,
+			      struct ethtool_ringparam *ring,
+			      struct kernel_ethtool_ringparam *kernel_ring,
+			      struct netlink_ext_ack *extack)
+{
+	struct wx *wx = netdev_priv(netdev);
+	u32 new_rx_count, new_tx_count;
+	struct wx_ring *temp_ring;
+	int i;
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
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
+	if (!temp_ring)
+		return -ENOMEM;
+
+	ngbe_down(wx);
+
+	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
+	kvfree(temp_ring);
+
+	wx_configure(wx);
+	ngbe_up(wx);
+
+	return 0;
+}
+
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -56,6 +110,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= wx_get_pauseparam,
 	.set_pauseparam		= wx_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= ngbe_set_ringparam,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index db5cae8384e5..96d80c595cb8 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -334,7 +334,7 @@ static void ngbe_disable_device(struct wx *wx)
 	wx_update_stats(wx);
 }
 
-static void ngbe_down(struct wx *wx)
+void ngbe_down(struct wx *wx)
 {
 	phylink_stop(wx->phylink);
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
index cdaa19528248..d60d3aba9311 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -7,9 +7,60 @@
 
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
+	struct wx_ring *temp_ring;
+	int i;
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
+	/* allocate temporary buffer to store rings in */
+	i = max_t(int, wx->num_tx_queues, wx->num_rx_queues);
+	temp_ring = kvmalloc_array(i, sizeof(struct wx_ring), GFP_KERNEL);
+	if (!temp_ring)
+		return -ENOMEM;
+
+	txgbe_down(wx);
+
+	wx_set_ring(wx, new_tx_count, new_rx_count, temp_ring);
+	kvfree(temp_ring);
+
+	txgbe_up(wx);
+
+	return 0;
+}
+
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_drvinfo		= wx_get_drvinfo,
 	.nway_reset		= wx_nway_reset,
@@ -23,6 +74,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.get_pause_stats	= wx_get_pause_stats,
 	.get_pauseparam		= wx_get_pauseparam,
 	.set_pauseparam		= wx_set_pauseparam,
+	.get_ringparam		= wx_get_ringparam,
+	.set_ringparam		= txgbe_set_ringparam,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 1007ae2541ce..bcc47bc6264a 100644
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


