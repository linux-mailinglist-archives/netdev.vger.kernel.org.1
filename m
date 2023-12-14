Return-Path: <netdev+bounces-57212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B988125B2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 04:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F5E2834D8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232CA15C0;
	Thu, 14 Dec 2023 03:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E2EAF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 19:01:37 -0800 (PST)
X-QQ-mid: bizesmtp68t1702522818tkui41e5
Received: from wxdbg.localdomain.com ( [183.129.236.74])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Dec 2023 11:00:17 +0800 (CST)
X-QQ-SSF: 01400000000000L0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJllCFdo79qYvE6jOm/QflHQDPvHq7Nww4I4IUhLk7QXo5ZwiOZrb
	nhv8Vc3xL3J4XenJ9w02p+gobS2un9l5EHXhEmnF+OnQCWBxRnBth1K2nRmz9/YL2Wz/CAO
	XdKAsslp4rDW0piJPb+zNuyXoAt8cuTmngwlGhC1fyt6Ya5aHkCIxu6lDIG7gzkk+2ONQoB
	KOivt2pL3TYaFMLJDb2Dp7UTr+3R5+d7c/m+cy5RMQ1hqILwTlpIBoGqRLTLGGXSlScKgNH
	urYcUMBlZYMUl21EhWzs48ExCN1VL8URildtQ4h/U0YMDop7A66EKlZN3w1s2vSA67Qka1g
	iTVDTPO17zn0miqrO8EPoWIMUMiIglNIc1jipS0yUEPYF4+ixeocpV0q0lwJSsnoi+WzUIw
	4dSIsXwq2QY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13391643833852220165
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
Subject: [PATCH net-next v5 7/8] net: wangxun: add ethtool_ops for channel number
Date: Thu, 14 Dec 2023 10:54:55 +0800
Message-Id: <20231214025456.1387175-8-jiawenwu@trustnetic.com>
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

Add support to get RX/TX queue number with ethtool -l, and set RX/TX
queue number with ethtool -L. Since interrupts need to be rescheduled,
adjust the allocation of msix enties.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 .../net/ethernet/wangxun/libwx/wx_ethtool.c   |  65 +++++++++++
 .../net/ethernet/wangxun/libwx/wx_ethtool.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 103 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  86 ++++++++++-----
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  31 +++++-
 .../net/ethernet/wangxun/ngbe/ngbe_ethtool.c  |  15 +++
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c |  69 +++++++-----
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h |   4 +-
 .../ethernet/wangxun/txgbe/txgbe_ethtool.c    |  15 +++
 .../net/ethernet/wangxun/txgbe/txgbe_main.c   |  46 +++++++-
 .../net/ethernet/wangxun/txgbe/txgbe_phy.c    |  12 +-
 .../net/ethernet/wangxun/txgbe/txgbe_type.h   |   6 +-
 12 files changed, 388 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
index ccc3f1697a76..31d189e8536b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -348,3 +348,68 @@ int wx_set_coalesce(struct net_device *netdev,
 	return 0;
 }
 EXPORT_SYMBOL(wx_set_coalesce);
+
+static unsigned int wx_max_channels(struct wx *wx)
+{
+	unsigned int max_combined;
+
+	if (!(wx->msix_q_entries)) {
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
+	if (wx->msix_q_entries) {
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
+		return -EOPNOTSUPP;
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
index 3cd0495a6fbb..ec4ad84c03b9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.h
@@ -34,4 +34,8 @@ int wx_set_coalesce(struct net_device *netdev,
 		    struct ethtool_coalesce *ec,
 		    struct kernel_ethtool_coalesce *kernel_coal,
 		    struct netlink_ext_ack *extack);
+void wx_get_channels(struct net_device *dev,
+		     struct ethtool_channels *ch);
+int wx_set_channels(struct net_device *dev,
+		    struct ethtool_channels *ch);
 #endif /* _WX_ETHTOOL_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index d11f7d8db194..1db754615cca 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -149,9 +149,9 @@ void wx_irq_disable(struct wx *wx)
 		int vector;
 
 		for (vector = 0; vector < wx->num_q_vectors; vector++)
-			synchronize_irq(wx->msix_entries[vector].vector);
+			synchronize_irq(wx->msix_q_entries[vector].vector);
 
-		synchronize_irq(wx->msix_entries[vector].vector);
+		synchronize_irq(wx->msix_entry->vector);
 	} else {
 		synchronize_irq(pdev->irq);
 	}
@@ -1597,6 +1597,72 @@ static void wx_restore_vlan(struct wx *wx)
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
+	for (i = 0; i < WX_MAX_RETA_ENTRIES; i++) {
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
+	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
+	u32 i, j;
+
+	/* Fill out hash function seeds */
+	for (i = 0; i < random_key_size; i++)
+		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
+
+	/* Fill out redirection table */
+	memset(wx->rss_indir_tbl, 0, sizeof(wx->rss_indir_tbl));
+
+	for (i = 0, j = 0; i < WX_MAX_RETA_ENTRIES; i++, j++) {
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
@@ -1629,6 +1695,8 @@ void wx_configure_rx(struct wx *wx)
 		wr32(wx, WX_PSR_CTL, psrctl);
 	}
 
+	wx_setup_mrqc(wx);
+
 	/* set_rx_buffer_len must be called before ring initialization */
 	wx_set_rx_buffer_len(wx);
 
@@ -1826,6 +1894,28 @@ int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count)
 }
 EXPORT_SYMBOL(wx_get_pcie_msix_counts);
 
+/**
+ * wx_init_rss_key - Initialize wx RSS key
+ * @wx: device handle
+ *
+ * Allocates and initializes the RSS key if it is not allocated.
+ **/
+static int wx_init_rss_key(struct wx *wx)
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
@@ -1853,14 +1943,23 @@ int wx_sw_init(struct wx *wx)
 		wx->subsystem_device_id = swab16((u16)ssid);
 	}
 
+	err = wx_init_rss_key(wx);
+	if (err < 0) {
+		wx_err(wx, "rss key allocation failed\n");
+		return err;
+	}
+
 	wx->mac_table = kcalloc(wx->mac.num_rar_entries,
 				sizeof(struct wx_mac_addr),
 				GFP_KERNEL);
 	if (!wx->mac_table) {
 		wx_err(wx, "mac_table allocation failed\n");
+		kfree(wx->rss_key);
 		return -ENOMEM;
 	}
 
+	wx->msix_in_use = false;
+
 	return 0;
 }
 EXPORT_SYMBOL(wx_sw_init);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 890a5c31a5a8..0a72caca9a56 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1636,8 +1636,14 @@ EXPORT_SYMBOL(wx_napi_disable_all);
  **/
 static void wx_set_rss_queues(struct wx *wx)
 {
-	wx->num_rx_queues = wx->mac.max_rx_queues;
-	wx->num_tx_queues = wx->mac.max_tx_queues;
+	struct wx_ring_feature *f;
+
+	/* set mask for 16 queue limit of RSS */
+	f = &wx->ring_feature[RING_F_RSS];
+	f->indices = f->limit;
+
+	wx->num_rx_queues = f->limit;
+	wx->num_tx_queues = f->limit;
 }
 
 static void wx_set_num_queues(struct wx *wx)
@@ -1663,35 +1669,51 @@ static int wx_acquire_msix_vectors(struct wx *wx)
 	struct irq_affinity affd = {0, };
 	int nvecs, i;
 
-	nvecs = min_t(int, num_online_cpus(), wx->mac.max_msix_vectors);
+	/* We start by asking for one vector per queue pair */
+	nvecs = max(wx->num_rx_queues, wx->num_tx_queues);
+	nvecs = min_t(int, nvecs, num_online_cpus());
+	nvecs = min_t(int, nvecs, wx->mac.max_msix_vectors);
 
-	wx->msix_entries = kcalloc(nvecs,
-				   sizeof(struct msix_entry),
-				   GFP_KERNEL);
-	if (!wx->msix_entries)
+	wx->msix_q_entries = kcalloc(nvecs, sizeof(struct msix_entry),
+				     GFP_KERNEL);
+	if (!wx->msix_q_entries)
 		return -ENOMEM;
 
+	/* One for non-queue interrupts */
+	nvecs += 1;
+
+	if (!wx->msix_in_use) {
+		wx->msix_entry = kcalloc(1, sizeof(struct msix_entry),
+					 GFP_KERNEL);
+		if (!wx->msix_entry) {
+			kfree(wx->msix_q_entries);
+			wx->msix_q_entries = NULL;
+			return -ENOMEM;
+		}
+	}
+
 	nvecs = pci_alloc_irq_vectors_affinity(wx->pdev, nvecs,
 					       nvecs,
 					       PCI_IRQ_MSIX | PCI_IRQ_AFFINITY,
 					       &affd);
 	if (nvecs < 0) {
 		wx_err(wx, "Failed to allocate MSI-X interrupts. Err: %d\n", nvecs);
-		kfree(wx->msix_entries);
-		wx->msix_entries = NULL;
+		kfree(wx->msix_q_entries);
+		wx->msix_q_entries = NULL;
+		kfree(wx->msix_entry);
+		wx->msix_entry = NULL;
 		return nvecs;
 	}
 
+	wx->msix_entry->entry = 0;
+	wx->msix_entry->vector = pci_irq_vector(wx->pdev, 0);
+	nvecs -= 1;
 	for (i = 0; i < nvecs; i++) {
-		wx->msix_entries[i].entry = i;
-		wx->msix_entries[i].vector = pci_irq_vector(wx->pdev, i);
+		wx->msix_q_entries[i].entry = i;
+		wx->msix_q_entries[i].vector = pci_irq_vector(wx->pdev, i + 1);
 	}
 
-	/* one for msix_other */
-	nvecs -= 1;
 	wx->num_q_vectors = nvecs;
-	wx->num_rx_queues = nvecs;
-	wx->num_tx_queues = nvecs;
 
 	return 0;
 }
@@ -1713,9 +1735,11 @@ static int wx_set_interrupt_capability(struct wx *wx)
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
@@ -1973,8 +1997,12 @@ void wx_reset_interrupt_capability(struct wx *wx)
 		return;
 
 	if (pdev->msix_enabled) {
-		kfree(wx->msix_entries);
-		wx->msix_entries = NULL;
+		kfree(wx->msix_q_entries);
+		wx->msix_q_entries = NULL;
+		if (!wx->msix_in_use) {
+			kfree(wx->msix_entry);
+			wx->msix_entry = NULL;
+		}
 	}
 	pci_free_irq_vectors(wx->pdev);
 }
@@ -2046,7 +2074,7 @@ void wx_free_irq(struct wx *wx)
 
 	for (vector = 0; vector < wx->num_q_vectors; vector++) {
 		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_entries[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
 
 		/* free only the irqs that were actually requested */
 		if (!q_vector->rx.ring && !q_vector->tx.ring)
@@ -2056,7 +2084,7 @@ void wx_free_irq(struct wx *wx)
 	}
 
 	if (wx->mac.type == wx_mac_em)
-		free_irq(wx->msix_entries[vector].vector, wx);
+		free_irq(wx->msix_entry->vector, wx);
 }
 EXPORT_SYMBOL(wx_free_irq);
 
@@ -2133,6 +2161,7 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
+		msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2163,7 +2192,7 @@ void wx_write_eitr(struct wx_q_vector *q_vector)
 
 	itr_reg |= WX_PX_ITR_CNT_WDIS;
 
-	wr32(wx, WX_PX_ITR(v_idx), itr_reg);
+	wr32(wx, WX_PX_ITR(v_idx + 1), itr_reg);
 }
 
 /**
@@ -2209,9 +2238,9 @@ void wx_configure_vectors(struct wx *wx)
 		wx_write_eitr(q_vector);
 	}
 
-	wx_set_ivar(wx, -1, 0, v_idx);
+	wx_set_ivar(wx, -1, 0, 0);
 	if (pdev->msix_enabled)
-		wr32(wx, WX_PX_ITR(v_idx), 1950);
+		wr32(wx, WX_PX_ITR(0), 1950);
 }
 EXPORT_SYMBOL(wx_configure_vectors);
 
@@ -2726,11 +2755,14 @@ int wx_set_features(struct net_device *netdev, netdev_features_t features)
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
index 41bd1fb80b93..487832a2a5d5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -147,8 +147,16 @@
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
@@ -922,6 +930,19 @@ struct wx_q_vector {
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
@@ -1025,7 +1046,10 @@ struct wx {
 	struct wx_q_vector *q_vector[64];
 
 	unsigned int queues_per_pool;
-	struct msix_entry *msix_entries;
+	struct msix_entry *msix_q_entries;
+	struct msix_entry *msix_entry;
+	bool msix_in_use;
+	struct wx_ring_feature ring_feature[RING_F_ARRAY_SIZE];
 
 	/* misc interrupt status block */
 	dma_addr_t isb_dma;
@@ -1033,8 +1057,9 @@ struct wx {
 	u32 isb_tag[WX_ISB_MAX];
 
 #define WX_MAX_RETA_ENTRIES 128
+#define WX_RSS_INDIR_TBL_MAX 64
 	u8 rss_indir_tbl[WX_MAX_RETA_ENTRIES];
-
+	bool rss_enabled;
 #define WX_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
 	u32 wol;
@@ -1051,7 +1076,7 @@ struct wx {
 };
 
 #define WX_INTR_ALL (~0ULL)
-#define WX_INTR_Q(i) BIT(i)
+#define WX_INTR_Q(i) BIT((i) + 1)
 
 /* register operations */
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index a1a5edb1d6f8..6d16150f0bbd 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -95,6 +95,19 @@ static int ngbe_set_ringparam(struct net_device *netdev,
 	return 0;
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
@@ -116,6 +129,8 @@ static const struct ethtool_ops ngbe_ethtool_ops = {
 	.set_ringparam		= ngbe_set_ringparam,
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
+	.get_channels		= wx_get_channels,
+	.set_channels		= ngbe_set_channels,
 };
 
 void ngbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 96d80c595cb8..fdd6b4f70b7a 100644
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
@@ -175,7 +154,7 @@ static void ngbe_irq_enable(struct wx *wx, bool queues)
 	if (queues)
 		wx_intr_enable(wx, NGBE_INTR_ALL);
 	else
-		wx_intr_enable(wx, NGBE_INTR_MISC(wx));
+		wx_intr_enable(wx, NGBE_INTR_MISC);
 }
 
 /**
@@ -241,7 +220,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
 
 	for (vector = 0; vector < wx->num_q_vectors; vector++) {
 		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_entries[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
 
 		if (q_vector->tx.ring && q_vector->rx.ring)
 			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
@@ -259,7 +238,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
 		}
 	}
 
-	err = request_irq(wx->msix_entries[vector].vector,
+	err = request_irq(wx->msix_entry->vector,
 			  ngbe_msix_other, 0, netdev->name, wx);
 
 	if (err) {
@@ -272,7 +251,7 @@ static int ngbe_request_msix_irqs(struct wx *wx)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		free_irq(wx->msix_entries[vector].vector,
+		free_irq(wx->msix_q_entries[vector].vector,
 			 wx->q_vector[vector]);
 	}
 	wx_reset_interrupt_capability(wx);
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
@@ -715,6 +727,7 @@ static void ngbe_remove(struct pci_dev *pdev)
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
+	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
index 0a98080a197a..f48ed7fc1805 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_type.h
@@ -80,7 +80,7 @@
 				NGBE_PX_MISC_IEN_GPIO)
 
 #define NGBE_INTR_ALL				0x1FF
-#define NGBE_INTR_MISC(A)			BIT((A)->num_q_vectors)
+#define NGBE_INTR_MISC				BIT(0)
 
 #define NGBE_PHY_CONFIG(reg_offset)		(0x14000 + ((reg_offset) * 4))
 #define NGBE_CFG_LAN_SPEED			0x14440
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
index 8c5bbee163f7..7148ff8333db 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c
@@ -61,6 +61,19 @@ static int txgbe_set_ringparam(struct net_device *netdev,
 	return 0;
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
@@ -80,6 +93,8 @@ static const struct ethtool_ops txgbe_ethtool_ops = {
 	.set_ringparam		= txgbe_set_ringparam,
 	.get_coalesce		= wx_get_coalesce,
 	.set_coalesce		= wx_set_coalesce,
+	.get_channels		= wx_get_channels,
+	.set_channels		= txgbe_set_channels,
 };
 
 void txgbe_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index bcc47bc6264a..3b151c410a5c 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -86,7 +86,7 @@ static void txgbe_irq_enable(struct wx *wx, bool queues)
 	wr32(wx, WX_PX_MISC_IEN, TXGBE_PX_MISC_IEN_MASK);
 
 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
 	if (queues)
 		wx_intr_enable(wx, TXGBE_INTR_QALL(wx));
 }
@@ -145,7 +145,7 @@ static int txgbe_request_msix_irqs(struct wx *wx)
 
 	for (vector = 0; vector < wx->num_q_vectors; vector++) {
 		struct wx_q_vector *q_vector = wx->q_vector[vector];
-		struct msix_entry *entry = &wx->msix_entries[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
 
 		if (q_vector->tx.ring && q_vector->rx.ring)
 			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
@@ -168,7 +168,7 @@ static int txgbe_request_msix_irqs(struct wx *wx)
 free_queue_irqs:
 	while (vector) {
 		vector--;
-		free_irq(wx->msix_entries[vector].vector,
+		free_irq(wx->msix_q_entries[vector].vector,
 			 wx->q_vector[vector]);
 	}
 	wx_reset_interrupt_capability(wx);
@@ -378,6 +378,10 @@ static int txgbe_sw_init(struct wx *wx)
 		wx_err(wx, "Do not support MSI-X\n");
 	wx->mac.max_msix_vectors = msix_count;
 
+	wx->ring_feature[RING_F_RSS].limit = min_t(int, TXGBE_MAX_RSS_INDICES,
+						   num_online_cpus());
+	wx->rss_enabled = true;
+
 	/* enable itr by default in dynamic mode */
 	wx->rx_itr_setting = 1;
 	wx->tx_itr_setting = 1;
@@ -504,6 +508,41 @@ static void txgbe_shutdown(struct pci_dev *pdev)
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
@@ -778,6 +817,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	pci_release_selected_regions(pdev,
 				     pci_select_bars(pdev, IORESOURCE_MEM));
 
+	kfree(wx->rss_key);
 	kfree(wx->mac_table);
 	wx_clear_interrupt_scheme(wx);
 
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index b1b5cdc04a92..1b84d495d14e 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -487,7 +487,7 @@ static void txgbe_irq_handler(struct irq_desc *desc)
 	}
 
 	/* unmask interrupt */
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	wx_intr_enable(wx, TXGBE_INTR_MISC);
 }
 
 static int txgbe_gpio_init(struct txgbe *txgbe)
@@ -531,7 +531,12 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 				     sizeof(*girq->parents), GFP_KERNEL);
 	if (!girq->parents)
 		return -ENOMEM;
-	girq->parents[0] = wx->msix_entries[wx->num_q_vectors].vector;
+
+	/* now only suuported on MSI-X interrupt */
+	if (!wx->msix_entry)
+		return -EPERM;
+
+	girq->parents[0] = wx->msix_entry->vector;
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_bad_irq;
 
@@ -749,6 +754,8 @@ int txgbe_init_phy(struct txgbe *txgbe)
 		goto err_unregister_i2c;
 	}
 
+	wx->msix_in_use = true;
+
 	return 0;
 
 err_unregister_i2c:
@@ -781,4 +788,5 @@ void txgbe_remove_phy(struct txgbe *txgbe)
 	phylink_destroy(txgbe->wx->phylink);
 	xpcs_destroy(txgbe->xpcs);
 	software_node_unregister_node_group(txgbe->nodes.group);
+	txgbe->wx->msix_in_use = false;
 }
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
index 801fd0aed1ff..270a6fd9ad0b 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
@@ -98,6 +98,7 @@
 
 #define TXGBE_MAX_MSIX_VECTORS          64
 #define TXGBE_MAX_FDIR_INDICES          63
+#define TXGBE_MAX_RSS_INDICES           63
 
 #define TXGBE_MAX_RX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
 #define TXGBE_MAX_TX_QUEUES   (TXGBE_MAX_FDIR_INDICES + 1)
@@ -122,8 +123,8 @@
 #define TXGBE_DEFAULT_RX_WORK           128
 #endif
 
-#define TXGBE_INTR_MISC(A)    BIT((A)->num_q_vectors)
-#define TXGBE_INTR_QALL(A)    (TXGBE_INTR_MISC(A) - 1)
+#define TXGBE_INTR_MISC       BIT(0)
+#define TXGBE_INTR_QALL(A)    GENMASK((A)->num_q_vectors, 1)
 
 #define TXGBE_MAX_EITR        GENMASK(11, 3)
 
@@ -131,6 +132,7 @@ extern char txgbe_driver_name[];
 
 void txgbe_down(struct wx *wx);
 void txgbe_up(struct wx *wx);
+int txgbe_setup_tc(struct net_device *dev, u8 tc);
 
 #define NODE_PROP(_NAME, _PROP)			\
 	(const struct software_node) {		\
-- 
2.27.0


