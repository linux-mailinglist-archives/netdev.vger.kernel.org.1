Return-Path: <netdev+bounces-142752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635E9C03A2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC0D1F218E3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523521F7073;
	Thu,  7 Nov 2024 11:15:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C11F668E;
	Thu,  7 Nov 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978119; cv=none; b=mHEaXXsr8Wlj2Evrs8g3iVUjPiWCXV3ALxXrg8i2GfCWoAIM5S4Bg9Y/C++A7TOZTqNm42BIfOjbBOFjVIp2j0w2Ri/YFpBFuyNsvusVGD0henvw0gDwAybNtd4jOfcNZofhbMIxLywb9dVmo/NBBAsRhGi/pVI2RMlItbNLZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978119; c=relaxed/simple;
	bh=ouXVzZQh7DqUjSaVgY9AgYWW7Wh0B6mj6XjR3ouPsJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpW3FRkjPDU4VoSpKl5uptYUZX08xVmGPL41WzaTCcZnKBEgfeIklOCH3x/kUxuQPeMOV7xj0J7TeVjCDSoUzE0lTBtHOsQK2DWPXPudQOFr5RsMV2FPC2aTC/txDfilFlsJX3CCqEJdc90FIxylNqkKc0LGcZ+7VQBcbzFTwOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 7 Nov
 2024 19:15:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 7 Nov 2024 19:15:01 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<ratbert@faraday-tech.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next 3/3] net: ftgmac100: Support for AST2700
Date: Thu, 7 Nov 2024 19:15:00 +0800
Message-ID: <20241107111500.4066517-4-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
References: <20241107111500.4066517-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 is the 7th generation SoC from Aspeed, featuring three GPIO
controllers that are support 64-bit DMA capability.
Adding features is shown in the following list.
1.Support 64-bit DMA
  Add the high address (63:32) registers for description address and the
  description field for packet buffer with high address part.
  These registers and fields in legacy Aspeed SoC are reserved.
  This 64-bit DMA changing has verified on legacy Aspeed Soc, like
  AST2600.
2.Set RMII pin strap in AST2700 compitable
  Use bit 20 of MAC 0x50 to represent the pin strap of AST2700 RMII and
  RGMII. Set to 1 is RMII pin, otherwise is RGMII.
  This bis is also reserved in legacy Aspeed SoC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 62 +++++++++++++++++-------
 drivers/net/ethernet/faraday/ftgmac100.h | 10 ++++
 2 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 17ec35e75a65..0f4f161d0a90 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
@@ -19,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/crc32.h>
@@ -98,6 +100,7 @@ struct ftgmac100 {
 	struct work_struct reset_task;
 	struct mii_bus *mii_bus;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	/* AST2500/AST2600 RMII ref clock gate */
 	struct clk *rclk;
@@ -265,10 +268,12 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
 	iowrite32(reg, priv->base + FTGMAC100_OFFSET_ISR);
 
 	/* Setup RX ring buffer base */
-	iowrite32(priv->rxdes_dma, priv->base + FTGMAC100_OFFSET_RXR_BADR);
+	iowrite32(lower_32_bits(priv->rxdes_dma), priv->base + FTGMAC100_OFFSET_RXR_BADR);
+	iowrite32(upper_32_bits(priv->rxdes_dma), priv->base + FTGMAC100_OFFSET_RXR_BADDR_HIGH);
 
 	/* Setup TX ring buffer base */
-	iowrite32(priv->txdes_dma, priv->base + FTGMAC100_OFFSET_NPTXR_BADR);
+	iowrite32(lower_32_bits(priv->txdes_dma), priv->base + FTGMAC100_OFFSET_NPTXR_BADR);
+	iowrite32(upper_32_bits(priv->txdes_dma), priv->base + FTGMAC100_OFFSET_TXR_BADDR_HIGH);
 
 	/* Configure RX buffer size */
 	iowrite32(FTGMAC100_RBSR_SIZE(RX_BUF_SIZE),
@@ -349,6 +354,10 @@ static void ftgmac100_start_hw(struct ftgmac100 *priv)
 	if (priv->netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
 		maccr |= FTGMAC100_MACCR_RM_VLAN;
 
+	if (of_device_is_compatible(priv->dev->of_node, "aspeed,ast2700-mac") &&
+	    priv->netdev->phydev->interface == PHY_INTERFACE_MODE_RMII)
+		maccr |= FTGMAC100_MACCR_RMII_ENABLE;
+
 	/* Hit the HW */
 	iowrite32(maccr, priv->base + FTGMAC100_OFFSET_MACCR);
 }
@@ -425,7 +434,8 @@ static int ftgmac100_alloc_rx_buf(struct ftgmac100 *priv, unsigned int entry,
 	priv->rx_skbs[entry] = skb;
 
 	/* Store DMA address into RX desc */
-	rxdes->rxdes3 = cpu_to_le32(map);
+	rxdes->rxdes2 = FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI, upper_32_bits(map));
+	rxdes->rxdes3 = lower_32_bits(map);
 
 	/* Ensure the above is ordered vs clearing the OWN bit */
 	dma_wmb();
@@ -551,7 +561,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 				       csum_vlan & 0xffff);
 
 	/* Tear down DMA mapping, do necessary cache management */
-	map = le32_to_cpu(rxdes->rxdes3);
+	map = le32_to_cpu(rxdes->rxdes3) | ((rxdes->rxdes2 & FTGMAC100_RXDES2_RXBUF_BADR_HI) << 16);
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_ARM_DMA_USE_IOMMU)
 	/* When we don't have an iommu, we can save cycles by not
@@ -563,7 +573,6 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	dma_unmap_single(priv->dev, map, RX_BUF_SIZE, DMA_FROM_DEVICE);
 #endif
 
-
 	/* Resplenish rx ring */
 	ftgmac100_alloc_rx_buf(priv, pointer, rxdes, GFP_ATOMIC);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -628,7 +637,9 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
 				     struct ftgmac100_txdes *txdes,
 				     u32 ctl_stat)
 {
-	dma_addr_t map = le32_to_cpu(txdes->txdes3);
+	dma_addr_t map = le32_to_cpu(txdes->txdes3) |
+			 ((txdes->txdes2 & FTGMAC100_TXDES2_TXBUF_BADR_HI) << 16);
+
 	size_t len;
 
 	if (ctl_stat & FTGMAC100_TXDES0_FTS) {
@@ -784,7 +795,8 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	f_ctl_stat |= FTGMAC100_TXDES0_FTS;
 	if (nfrags == 0)
 		f_ctl_stat |= FTGMAC100_TXDES0_LTS;
-	txdes->txdes3 = cpu_to_le32(map);
+	txdes->txdes2 = FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI, upper_32_bits((ulong)map));
+	txdes->txdes3 = lower_32_bits(map);
 	txdes->txdes1 = cpu_to_le32(csum_vlan);
 
 	/* Next descriptor */
@@ -812,7 +824,9 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 			ctl_stat |= FTGMAC100_TXDES0_LTS;
 		txdes->txdes0 = cpu_to_le32(ctl_stat);
 		txdes->txdes1 = 0;
-		txdes->txdes3 = cpu_to_le32(map);
+		txdes->txdes2 =
+			FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI, upper_32_bits((ulong)map));
+		txdes->txdes3 = lower_32_bits(map);
 
 		/* Next one */
 		pointer = ftgmac100_next_tx_pointer(priv, pointer);
@@ -887,7 +901,8 @@ static void ftgmac100_free_buffers(struct ftgmac100 *priv)
 	for (i = 0; i < priv->rx_q_entries; i++) {
 		struct ftgmac100_rxdes *rxdes = &priv->rxdes[i];
 		struct sk_buff *skb = priv->rx_skbs[i];
-		dma_addr_t map = le32_to_cpu(rxdes->rxdes3);
+		dma_addr_t map = le32_to_cpu(rxdes->rxdes3) |
+				 ((rxdes->rxdes2 & FTGMAC100_RXDES2_RXBUF_BADR_HI) << 16);
 
 		if (!skb)
 			continue;
@@ -986,7 +1001,9 @@ static void ftgmac100_init_rings(struct ftgmac100 *priv)
 	for (i = 0; i < priv->rx_q_entries; i++) {
 		rxdes = &priv->rxdes[i];
 		rxdes->rxdes0 = 0;
-		rxdes->rxdes3 = cpu_to_le32(priv->rx_scratch_dma);
+		rxdes->rxdes2 = FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+					   upper_32_bits(priv->rx_scratch_dma));
+		rxdes->rxdes3 = lower_32_bits(priv->rx_scratch_dma);
 	}
 	/* Mark the end of the ring */
 	rxdes->rxdes0 |= cpu_to_le32(priv->rxdes0_edorr_mask);
@@ -1249,7 +1266,6 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
 		more = ftgmac100_rx_packet(priv, &work_done);
 	} while (more && work_done < budget);
 
-
 	/* The interrupt is telling us to kick the MAC back to life
 	 * after an RX overflow
 	 */
@@ -1339,7 +1355,6 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	if (priv->mii_bus)
 		mutex_lock(&priv->mii_bus->mdio_lock);
 
-
 	/* Check if the interface is still up */
 	if (!netif_running(netdev))
 		goto bail;
@@ -1438,7 +1453,6 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
 
 	if (netdev->phydev)
 		mutex_lock(&netdev->phydev->lock);
-
 }
 
 static int ftgmac100_mii_probe(struct net_device *netdev)
@@ -1882,7 +1896,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
 		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
+		   of_device_is_compatible(np, "aspeed,ast2600-mac") ||
+		   of_device_is_compatible(np, "aspeed,ast2700-mac"))) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1965,16 +1980,27 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			dev_err(priv->dev, "MII probe failed!\n");
 			goto err_ncsi_dev;
 		}
-
 	}
 
 	if (priv->is_aspeed) {
+		struct reset_control *rst;
+
 		err = ftgmac100_setup_clk(priv);
 		if (err)
 			goto err_phy_connect;
 
-		/* Disable ast2600 problematic HW arbitration */
-		if (of_device_is_compatible(np, "aspeed,ast2600-mac"))
+		rst = devm_reset_control_get_optional(priv->dev, NULL);
+		if (IS_ERR(rst))
+			goto err_register_netdev;
+
+		priv->rst = rst;
+		err = reset_control_assert(priv->rst);
+		mdelay(10);
+		err = reset_control_deassert(priv->rst);
+
+		/* Disable some aspeed platform problematic HW arbitration */
+		if (of_device_is_compatible(np, "aspeed,ast2600-mac") ||
+		    of_device_is_compatible(np, "aspeed,ast2700-mac"))
 			iowrite32(FTGMAC100_TM_DEFAULT,
 				  priv->base + FTGMAC100_OFFSET_TM);
 	}
@@ -2010,6 +2036,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		goto err_register_netdev;
 	}
 
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	netdev_info(netdev, "irq %d, mapped at %p\n", netdev->irq, priv->base);
 
 	return 0;
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 4968f6f0bdbc..ac39b864a80c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -57,6 +57,13 @@
 #define FTGMAC100_OFFSET_RX_RUNT	0xc0
 #define FTGMAC100_OFFSET_RX_CRCER_FTL	0xc4
 #define FTGMAC100_OFFSET_RX_COL_LOST	0xc8
+/* reserved 0xcc - 0x174 */
+#define FTGMAC100_OFFSET_TXR_BADDR_LOW		0x178	/* ast2700 */
+#define FTGMAC100_OFFSET_TXR_BADDR_HIGH		0x17c	/* ast2700 */
+#define FTGMAC100_OFFSET_HPTXR_BADDR_LOW	0x180	/* ast2700 */
+#define FTGMAC100_OFFSET_HPTXR_BADDR_HIGH	0x184	/* ast2700 */
+#define FTGMAC100_OFFSET_RXR_BADDR_LOW		0x188	/* ast2700 */
+#define FTGMAC100_OFFSET_RXR_BADDR_HIGH		0x18C	/* ast2700 */
 
 /*
  * Interrupt status register & interrupt enable register
@@ -166,6 +173,7 @@
 #define FTGMAC100_MACCR_RX_MULTIPKT	(1 << 16)
 #define FTGMAC100_MACCR_RX_BROADPKT	(1 << 17)
 #define FTGMAC100_MACCR_DISCARD_CRCERR	(1 << 18)
+#define FTGMAC100_MACCR_RMII_ENABLE	(1 << 20) /* defined in ast2700 */
 #define FTGMAC100_MACCR_FAST_MODE	(1 << 19)
 #define FTGMAC100_MACCR_SW_RST		(1 << 31)
 
@@ -225,6 +233,7 @@ struct ftgmac100_txdes {
 #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
 #define FTGMAC100_TXDES1_TXIC		(1 << 31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)
 /*
  * Receive descriptor, aligned to 16 bytes
  */
@@ -271,4 +280,5 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
 #endif /* __FTGMAC100_H */
-- 
2.25.1


