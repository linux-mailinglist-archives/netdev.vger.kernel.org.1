Return-Path: <netdev+bounces-50007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAA7F43DE
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBDB20F98
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FCD54BEB;
	Wed, 22 Nov 2023 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EAED66
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:28:39 -0800 (PST)
X-QQ-mid: bizesmtp82t1700648829t1ydxs85
Received: from wxdbg.localdomain.com ( [183.128.129.197])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Nov 2023 18:27:08 +0800 (CST)
X-QQ-SSF: 01400000000000K0Z000000A0000000
X-QQ-FEAT: 5q30pvLz2idzug3X1dWWAZdRsY5zBHhYu2kVxzg8C0vCOcgNh2pGEkyN1MDqL
	hNPAWmxR0hsokXpWPP0ZFkkJr5duJPiibbAgGPJC9hcSdFTvfnVdD9L4QAY3RitkqpEoDqS
	RpfLLirlX1NM+L8jANOjBhkiA+X0gHy09YtDhTzaKLtpmInqAVnPC1q16dpYHXW8SoahXBL
	NSTkqoayFOImrEzT3HT7Ry0aTPFT1TaMNpL9BYYLNPYpRAOcphkHb5koVsSKW38VvF6ZLel
	GJLX1tkGuQSnOaHlf5DB901QH1EfyZn+yMQ/gISZj9eklq6P74U5fB4oMFvxCgAvJvAGDRO
	ssCK3v61mRZk9qZKYrf60rbWHQ/aTrekrnWY6epsXaZu6I0zeOXgtA8hHOi4/AxU+JAw9ov
	G2O+b4S+2cs=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16158200262778785831
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
Subject: [PATCH net-next 4/5] net: wangxun: add ethtool_ops for channel number
Date: Wed, 22 Nov 2023 18:22:25 +0800
Message-Id: <20231122102226.986265-5-jiawenwu@trustnetic.com>
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

Add support to get RX/TX queue number with ethtool -l, and set RX/TX
queue number with ethtool -L.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 65 +++++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 94 +++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 21 ++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  | 25 ++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  | 15 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c | 60 +++++++-----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |  2 +
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    | 15 +++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   | 39 ++++++++
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |  2 +
 11 files changed, 312 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index abd2f4c92654..4e467aa1cc19 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -304,3 +304,68 @@ int wx_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_coalesce);
+
+static unsigned int wx_max_channels(struct wx *wx)
+{
+	unsigned int max_combined;
+
+	if (!(wx->msix_entries)) {
+		/* We only support one q_vector without MSI-X */
+		max_combined = 1;
+	} else {
+		/* support up to max allowed queues with RSS */
+		if (wx->mac.type == wx_mac_sp)
+			max_combined = 63;
+		else
+			max_combined = 8;
+	}
+
+	return max_combined;
+}
+
+void wx_get_channels(struct net_device *dev,
+		     struct ethtool_channels *ch)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	/* report maximum channels */
+	ch->max_combined = wx_max_channels(wx);
+
+	/* report info for other vector */
+	if (wx->msix_entries) {
+		ch->max_other = 1;
+		ch->other_count = 1;
+	}
+
+	/* record RSS queues */
+	ch->combined_count = wx->ring_feature[RING_F_RSS].indices;
+
+	/* nothing else to report if RSS is disabled */
+	if (ch->combined_count == 1)
+		return;
+}
+EXPORT_SYMBOL(wx_get_channels);
+
+int wx_set_channels(struct net_device *dev,
+		    struct ethtool_channels *ch)
+{
+	unsigned int count = ch->combined_count;
+	struct wx *wx = netdev_priv(dev);
+
+	/* verify they are not requesting separate vectors */
+	if (!count || ch->rx_count || ch->tx_count)
+		return -EINVAL;
+
+	/* verify other_count has not changed */
+	if (ch->other_count != 1)
+		return -EINVAL;
+
+	/* verify the number of channels does not exceed hardware limits */
+	if (count > wx_max_channels(wx))
+		return -EINVAL;
+
+	wx->ring_feature[RING_F_RSS].limit = count;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_channels);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
index 3a80f8e63719..5b5af3689c04 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -25,4 +25,8 @@ int wx_set_coalesce(struct net_device *netdev,
 		    struct ethtool_coalesce *ec,
 		    struct kernel_ethtool_coalesce *kernel_coal,
 		    struct netlink_ext_ack *extack);
+void wx_get_channels(struct net_device *dev,
+		     struct ethtool_channels *ch);
+int wx_set_channels(struct net_device *dev,
+		    struct ethtool_channels *ch);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 40897419a970..bad56bba26fc 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1597,6 +1597,71 @@ static void wx_restore_vlan(struct wx *wx)
 		wx_vlan_rx_add_vid(wx->netdev, htons(ETH_P_8021Q), vid);
 }
 
+static void wx_store_reta(struct wx *wx)
+{
+	u8 *indir_tbl = wx->rss_indir_tbl;
+	u32 reta = 0;
+	u32 i;
+
+	/* Fill out the redirection table as follows:
+	 *  - 8 bit wide entries containing 4 bit RSS index
+	 */
+	for (i = 0; i < 128; i++) {
+		reta |= indir_tbl[i] << (i & 0x3) * 8;
+		if ((i & 3) == 3) {
+			wr32(wx, WX_RDB_RSSTBL(i >> 2), reta);
+			reta = 0;
+		}
+	}
+}
+
+static void wx_setup_reta(struct wx *wx)
+{
+	u16 rss_i = wx->ring_feature[RING_F_RSS].indices;
+	u32 i, j;
+
+	/* Fill out hash function seeds */
+	for (i = 0; i < 10; i++)
+		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
+
+	/* Fill out redirection table */
+	memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
+
+	for (i = 0, j = 0; i < 128; i++, j++) {
+		if (j == rss_i)
+			j = 0;
+
+		wx->rss_indir_tbl[i] = j;
+	}
+
+	wx_store_reta(wx);
+}
+
+static void wx_setup_mrqc(struct wx *wx)
+{
+	u32 rss_field = 0;
+
+	/* Disable indicating checksum in descriptor, enables RSS hash */
+	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
+
+	/* Perform hash on these packet types */
+	rss_field = WX_RDB_RA_CTL_RSS_IPV4 |
+		    WX_RDB_RA_CTL_RSS_IPV4_TCP |
+		    WX_RDB_RA_CTL_RSS_IPV4_UDP |
+		    WX_RDB_RA_CTL_RSS_IPV6 |
+		    WX_RDB_RA_CTL_RSS_IPV6_TCP |
+		    WX_RDB_RA_CTL_RSS_IPV6_UDP;
+
+	netdev_rss_key_fill(wx->rss_key, sizeof(wx->rss_key));
+
+	wx_setup_reta(wx);
+
+	if (wx->rss_enabled)
+		rss_field |= WX_RDB_RA_CTL_RSS_EN;
+
+	wr32(wx, WX_RDB_RA_CTL, rss_field);
+}
+
 /**
  * wx_configure_rx - Configure Receive Unit after Reset
  * @wx: pointer to private structure
@@ -1629,6 +1694,8 @@ void wx_configure_rx(struct wx *wx)
 		wr32(wx, WX_PSR_CTL, psrctl);
 	}
 
+	wx_setup_mrqc(wx);
+
 	/* set_rx_buffer_len must be called before ring initialization */
 	wx_set_rx_buffer_len(wx);
 
@@ -1826,6 +1893,28 @@ int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count)
 }
 EXPORT_SYMBOL(wx_get_pcie_msix_counts);
 
+/**
+ * wx_init_rss_key - Initialize wx RSS key
+ * @wx: device handle
+ *
+ * Allocates and initializes the RSS key if it is not allocated.
+ **/
+static inline int wx_init_rss_key(struct wx *wx)
+{
+	u32 *rss_key;
+
+	if (!wx->rss_key) {
+		rss_key = kzalloc(WX_RSS_KEY_SIZE, GFP_KERNEL);
+		if (unlikely(!rss_key))
+			return -ENOMEM;
+
+		netdev_rss_key_fill(rss_key, WX_RSS_KEY_SIZE);
+		wx->rss_key = rss_key;
+	}
+
+	return 0;
+}
+
 int wx_sw_init(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
@@ -1861,6 +1950,11 @@ int wx_sw_init(struct wx *wx)
 		return -ENOMEM;
 	}
 
+	if (wx_init_rss_key(wx)) {
+		wx_err(wx, "rss key allocation failed\n");
+		return -ENOMEM;
+	}
+
 	wx->fc.pause_time = WX_DEFAULT_FCPAUSE;
 	wx->fc.disable_fc_autoneg = false;
 	wx->fc.rx_pause = true;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 9eb9ab8fe581..b97162fc9550 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1636,6 +1636,12 @@ EXPORT_SYMBOL(wx_napi_disable_all);
  **/
 static void wx_set_rss_queues(struct wx *wx)
 {
+	struct wx_ring_feature *f;
+
+	/* set mask for 16 queue limit of RSS */
+	f = &wx->ring_feature[RING_F_RSS];
+	f->indices = f->limit;
+
 	wx->num_rx_queues = wx->mac.max_rx_queues;
 	wx->num_tx_queues = wx->mac.max_tx_queues;
 }
@@ -1713,9 +1719,11 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	if (ret == 0 || (ret == -ENOMEM))
 		return ret;
 
-	wx->num_rx_queues = 1;
-	wx->num_tx_queues = 1;
-	wx->num_q_vectors = 1;
+	/* Disable RSS */
+	dev_warn(&wx->pdev->dev, "Disabling RSS support\n");
+	wx->ring_feature[RING_F_RSS].limit = 1;
+
+	wx_set_num_queues(wx);
 
 	/* minmum one for queue, one for misc*/
 	nvecs = 1;
@@ -2726,11 +2734,14 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
 	netdev_features_t changed = netdev->features ^ features;
 	struct wx *wx = netdev_priv(netdev);
 
-	if (changed & NETIF_F_RXHASH)
+	if (features & NETIF_F_RXHASH) {
 		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN,
 		      WX_RDB_RA_CTL_RSS_EN);
-	else
+		wx->rss_enabled = true;
+	} else {
 		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
+		wx->rss_enabled = false;
+	}
 
 	if (changed &
 	    (NETIF_F_HW_VLAN_CTAG_RX |
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 8c795f908d1e..45a98e23591d 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -146,8 +146,16 @@
 #define WX_RDB_PL_CFG_L2HDR          BIT(3)
 #define WX_RDB_PL_CFG_TUN_TUNHDR     BIT(4)
 #define WX_RDB_PL_CFG_TUN_OUTL2HDR   BIT(5)
+#define WX_RDB_RSSTBL(_i)            (0x19400 + ((_i) * 4))
+#define WX_RDB_RSSRK(_i)             (0x19480 + ((_i) * 4))
 #define WX_RDB_RA_CTL                0x194F4
 #define WX_RDB_RA_CTL_RSS_EN         BIT(2) /* RSS Enable */
+#define WX_RDB_RA_CTL_RSS_IPV4_TCP   BIT(16)
+#define WX_RDB_RA_CTL_RSS_IPV4       BIT(17)
+#define WX_RDB_RA_CTL_RSS_IPV6       BIT(20)
+#define WX_RDB_RA_CTL_RSS_IPV6_TCP   BIT(21)
+#define WX_RDB_RA_CTL_RSS_IPV4_UDP   BIT(22)
+#define WX_RDB_RA_CTL_RSS_IPV6_UDP   BIT(23)
 
 /******************************* PSR Registers *******************************/
 /* psr control */
@@ -912,6 +920,19 @@ struct wx_q_vector {
 	struct wx_ring ring[] ____cacheline_internodealigned_in_smp;
 };
 
+struct wx_ring_feature {
+	u16 limit;      /* upper limit on feature indices */
+	u16 indices;    /* current value of indices */
+	u16 mask;       /* Mask used for feature to ring mapping */
+	u16 offset;     /* offset to start of feature */
+};
+
+enum wx_ring_f_enum {
+	RING_F_NONE = 0,
+	RING_F_RSS,
+	RING_F_ARRAY_SIZE  /* must be last in enum set */
+};
+
 enum wx_isb_idx {
 	WX_ISB_HEADER,
 	WX_ISB_MISC,
@@ -1018,6 +1039,7 @@ struct wx {
 
 	unsigned int queues_per_pool;
 	struct msix_entry *msix_entries;
+	struct wx_ring_feature ring_feature[RING_F_ARRAY_SIZE];
 
 	/* misc interrupt status block */
 	dma_addr_t isb_dma;
@@ -1025,8 +1047,9 @@ struct wx {
 	u32 isb_tag[WX_ISB_MAX];
 
 #define WX_MAX_RETA_ENTRIES 128
+#define WX_RSS_INDIR_TBL_MAX 64
 	u8 rss_indir_tbl[WX_MAX_RETA_ENTRIES];
-
+	bool rss_enabled;
 #define WX_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
 	u32 wol;
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 712e0308c397..e4ac46242965 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -117,6 +117,19 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
+static int ngbe_set_channels(struct net_device *dev,
+			     struct ethtool_channels *ch)
+{
+	int err;
+
+	err = wx_set_channels(dev, ch);
+	if (err < 0)
+		return err;
+
+	/* use setup TC to update any traffic class queue mapping */
+	return ngbe_setup_tc(dev, netdev_get_num_tc(dev));
+}
+
 static const struct ethtool_ops ngbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
@@ -138,6 +151,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_ringparam		= ngbe_set_ringparam,
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
+	.get_channels		= wx_get_channels,
+	.set_channels		= ngbe_set_channels,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 0c0b2f7bdf74..c9dc885f8527 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -79,28 +79,6 @@ static void ngbe_init_type_code(struct wx *wx)
 	}
 }
 
-/**
- * ngbe_init_rss_key - Initialize wx RSS key
- * @wx: device handle
- *
- * Allocates and initializes the RSS key if it is not allocated.
- **/
-static inline int ngbe_init_rss_key(struct wx *wx)
-{
-	u32 *rss_key;
-
-	if (!wx->rss_key) {
-		rss_key = kzalloc(WX_RSS_KEY_SIZE, GFP_KERNEL);
-		if (unlikely(!rss_key))
-			return -ENOMEM;
-
-		netdev_rss_key_fill(rss_key, WX_RSS_KEY_SIZE);
-		wx->rss_key = rss_key;
-	}
-
-	return 0;
-}
-
 /**
  * ngbe_sw_init - Initialize general software structures
  * @wx: board private structure to initialize
@@ -134,8 +112,9 @@ static int ngbe_sw_init(struct wx *wx)
 		dev_err(&pdev->dev, "Do not support MSI-X\n");
 	wx->mac.max_msix_vectors = msix_count;
 
-	if (ngbe_init_rss_key(wx))
-		return -ENOMEM;
+	wx->ring_feature[RING_F_RSS].limit = min_t(int, NGBE_MAX_RSS_INDICES,
+						   num_online_cpus());
+	wx->rss_enabled = true;
 
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
@@ -480,6 +459,39 @@ static void ngbe_shutdown(struct pci_dev *pdev)
 	}
 }
 
+/**
+ * ngbe_setup_tc - routine to configure net_device for multiple traffic
+ * classes.
+ *
+ * @dev: net device to configure
+ * @tc: number of traffic classes to enable
+ */
+int ngbe_setup_tc(struct net_device *dev, u8 tc)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	/* Hardware has to reinitialize queues and interrupts to
+	 * match packet buffer alignment. Unfortunately, the
+	 * hardware is not flexible enough to do this dynamically.
+	 */
+	if (netif_running(dev))
+		ngbe_close(dev);
+
+	wx_clear_interrupt_scheme(wx);
+
+	if (tc)
+		netdev_set_num_tc(dev, tc);
+	else
+		netdev_reset_tc(dev);
+
+	wx_init_interrupt_scheme(wx);
+
+	if (netif_running(dev))
+		ngbe_open(dev);
+
+	return 0;
+}
+
 static const struct net_device_ops ngbe_netdev_ops = {
 	.ndo_open               = ngbe_open,
 	.ndo_stop               = ngbe_close,
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 0a98080a197a..f4dc4acbedae 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -105,6 +105,7 @@
 #define NGBE_FW_CMD_ST_FAIL			0x70657376
 
 #define NGBE_MAX_FDIR_INDICES			7
+#define NGBE_MAX_RSS_INDICES			8
 
 #define NGBE_MAX_RX_QUEUES			(NGBE_MAX_FDIR_INDICES + 1)
 #define NGBE_MAX_TX_QUEUES			(NGBE_MAX_FDIR_INDICES + 1)
@@ -132,5 +133,6 @@ extern char ngbe_driver_name[];
 
 void ngbe_down(struct wx *wx);
 void ngbe_up(struct wx *wx);
+int ngbe_setup_tc(struct net_device *dev, u8 tc);
 
 #endif /* _NGBE_TYPE_H_ */
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
index fe055b006a4e..36cbc4e799b3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -92,6 +92,19 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	return err;
 }
 
+static int txgbe_set_channels(struct net_device *dev,
+			      struct ethtool_channels *ch)
+{
+	int err;
+
+	err = wx_set_channels(dev, ch);
+	if (err < 0)
+		return err;
+
+	/* use setup TC to update any traffic class queue mapping */
+	return txgbe_setup_tc(dev, netdev_get_num_tc(dev));
+}
+
 static const struct ethtool_ops txgbe_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
@@ -111,6 +124,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_ringparam		= txgbe_set_ringparam,
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
+	.get_channels		= wx_get_channels,
+	.set_channels		= txgbe_set_channels,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 9b1b92fa318f..b2e9feb88aac 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -382,6 +382,10 @@ static int txgbe_sw_init(struct wx *wx)
 		wx_err(wx, "Do not support MSI-X\n");
 	wx->mac.max_msix_vectors = msix_count;
 
+	wx->ring_feature[RING_F_RSS].limit = min_t(int, TXGBE_MAX_RSS_INDICES,
+						   num_online_cpus());
+	wx->rss_enabled = true;
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
@@ -508,6 +512,41 @@ static void txgbe_shutdown(struct pci_dev *pdev)
 	}
 }
 
+/**
+ * txgbe_setup_tc - routine to configure net_device for multiple traffic
+ * classes.
+ *
+ * @dev: net device to configure
+ * @tc: number of traffic classes to enable
+ */
+int txgbe_setup_tc(struct net_device *dev, u8 tc)
+{
+	struct wx *wx = netdev_priv(dev);
+
+	/* Hardware has to reinitialize queues and interrupts to
+	 * match packet buffer alignment. Unfortunately, the
+	 * hardware is not flexible enough to do this dynamically.
+	 */
+	if (netif_running(dev))
+		txgbe_close(dev);
+	else
+		txgbe_reset(wx);
+
+	wx_clear_interrupt_scheme(wx);
+
+	if (tc)
+		netdev_set_num_tc(dev, tc);
+	else
+		netdev_reset_tc(dev);
+
+	wx_init_interrupt_scheme(wx);
+
+	if (netif_running(dev))
+		txgbe_open(dev);
+
+	return 0;
+}
+
 static const struct net_device_ops txgbe_netdev_ops = {
 	.ndo_open               = txgbe_open,
 	.ndo_stop               = txgbe_close,
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 13a2f3f53c39..e99f927c8b77 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -98,6 +98,7 @@
 
 #define TXGBE_MAX_MSIX_VECTORS          64
 #define TXGBE_MAX_FDIR_INDICES          63
+#define TXGBE_MAX_RSS_INDICES           63
 
 #define TXGBE_MAX_RX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
 #define TXGBE_MAX_TX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
@@ -131,6 +132,7 @@ extern char txgbe_driver_name[];
 
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
+int txgbe_setup_tc(struct net_device *dev, u8 tc);
 
 static inline struct txgbe *netdev_to_txgbe(struct net_device *netdev)
 {
-- 
2.27.0


