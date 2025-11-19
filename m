Return-Path: <netdev+bounces-239915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD308C6DFEC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB7D4F5D2C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBC349B12;
	Wed, 19 Nov 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pyTY/U6A"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199D3254B4
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547817; cv=none; b=bQipbhWho8Qsf9Y7OMmeI+2+olYvZkPqQhioA0MMi/S4eHeyHGsSaGd4XIQiQX8nGffjxnfMR0vKM2fURJcVcA35yjazjvYtd53Iz3SSkXQsXKzAWOYHwdk1FtNUzdaloY7s6A9WC1KQN49ki6o2NRzVqEijGaIhM2p6Qtio9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547817; c=relaxed/simple;
	bh=1cfZSVItd5vbYzLCueUMYA116KpDYkZihVnmiVRzy2A=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TaRsDtwfBusp5RWJcAX1VQ2RhITGiODGvAbYPM1Rz9LRXqBr81LhjrDW4GpbvfqXt0czKbPGCL3tfbpzU8+9YMp11k3E/gpTxuNyiBawqlTsDGS2+kpP1ED6VnA+ugBr1USlK17Zke34SQVm8HFMaNWMup9s87kddpaRv0tyt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pyTY/U6A; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ue531+69m2++9UHg5j0eMS12QGgIfsxMud4bkC68LCw=; b=pyTY/U6AyrfS/AluqPy8foWN4Y
	qdxURlFcKhXWISPsiwvPk5fzMXtmg9d89/XyHel+n9uY++wazyDMBPZzwdTY6rWFHRjwKSuV+U+ZJ
	ux12Nw6cdnT+bA2tH5h8f4n7xmvCfpX4spmenNeAS1DlfAF7Yqyq8OVo8wTn9RvmYp88lSXeUIDoG
	h5bEDInSfVo4zM5nvql2rFCDHsp7U9mVmmnGAWYAqZxNZU+bVjsCqEE6/VSXIq+egqRd5FSc2ex8o
	y6OO+kR/cZN3+IA3WzgX9WSA7aHx1ALqsrf17cbkYoqBt0OQMvso0/ZcTUUgc6WULsXk6U/8WET8G
	6b+N1c+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48934 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vLfLS-000000004V9-0HvL;
	Wed, 19 Nov 2025 10:23:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vLfLR-0000000FMav-0VL6;
	Wed, 19 Nov 2025 10:23:25 +0000
In-Reply-To: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
References: <aR2aaDs6rqfu32B-@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 3/6] net: stmmac: provide common
 stmmac_axi_blen_to_mask()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vLfLR-0000000FMav-0VL6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 19 Nov 2025 10:23:25 +0000

Provide a common stmmac_axi_blen_to_mask() function to translate the
burst length array to the value for the AXI bus mode register, and use
it for dwmac, dwmac4 and dwxgmac2. Remove the now unnecessary
XGMAC_BLEN* definitions.

Note that stmmac_axi_blen_to_dma_mask() is coded to be more efficient
than the original three implementations, and verifies the contents of
the burst length array.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  3 ++
 .../ethernet/stmicro/stmmac/dwmac1000_dma.c   | 31 ++--------------
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  | 31 ++--------------
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  2 -
 .../net/ethernet/stmicro/stmmac/dwmac_dma.h   |  2 -
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  9 +----
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 34 ++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
 8 files changed, 56 insertions(+), 93 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 3c6e7fe7b999..49df46be3669 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -557,6 +557,9 @@ struct dma_features {
 #define DMA_AXI_BLEN16		BIT(3)
 #define DMA_AXI_BLEN8		BIT(2)
 #define DMA_AXI_BLEN4		BIT(1)
+#define DMA_AXI_BLEN_MASK	GENMASK(7, 1)
+
+void stmmac_axi_blen_to_mask(u32 *regval, const u32 *blen, size_t len);
 
 #define STMMAC_CHAIN_MODE	0x1
 #define STMMAC_RING_MODE	0x2
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 118a22406a2e..b6476a1bfeab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -19,7 +19,6 @@
 static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + DMA_AXI_BUS_MODE);
-	int i;
 
 	pr_info("dwmac1000: Master AXI performs %s burst length\n",
 		!(value & DMA_AXI_UNDEF) ? "fixed" : "any");
@@ -39,33 +38,11 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 
 	/* Depending on the UNDEF bit the Master AXI will perform any burst
 	 * length according to the BLEN programmed (by default all BLEN are
-	 * set).
+	 * set). Note that the UNDEF bit is readonly, and is the inverse of
+	 * Bus Mode bit 16.
 	 */
-	for (i = 0; i < AXI_BLEN; i++) {
-		switch (axi->axi_blen[i]) {
-		case 256:
-			value |= DMA_AXI_BLEN256;
-			break;
-		case 128:
-			value |= DMA_AXI_BLEN128;
-			break;
-		case 64:
-			value |= DMA_AXI_BLEN64;
-			break;
-		case 32:
-			value |= DMA_AXI_BLEN32;
-			break;
-		case 16:
-			value |= DMA_AXI_BLEN16;
-			break;
-		case 8:
-			value |= DMA_AXI_BLEN8;
-			break;
-		case 4:
-			value |= DMA_AXI_BLEN4;
-			break;
-		}
-	}
+	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
+				ARRAY_SIZE(axi->axi_blen));
 
 	writel(value, ioaddr + DMA_AXI_BUS_MODE);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index d87a8b595e6a..90d03c7b29f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -18,7 +18,6 @@
 static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
-	int i;
 
 	pr_info("dwmac4: Master AXI performs %s burst length\n",
 		(value & DMA_SYS_BUS_FB) ? "fixed" : "any");
@@ -38,33 +37,11 @@ static void dwmac4_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 
 	/* Depending on the UNDEF bit the Master AXI will perform any burst
 	 * length according to the BLEN programmed (by default all BLEN are
-	 * set).
+	 * set). Note that the UNDEF bit is readonly, and is the inverse of
+	 * Bus Mode bit 16.
 	 */
-	for (i = 0; i < AXI_BLEN; i++) {
-		switch (axi->axi_blen[i]) {
-		case 256:
-			value |= DMA_AXI_BLEN256;
-			break;
-		case 128:
-			value |= DMA_AXI_BLEN128;
-			break;
-		case 64:
-			value |= DMA_AXI_BLEN64;
-			break;
-		case 32:
-			value |= DMA_AXI_BLEN32;
-			break;
-		case 16:
-			value |= DMA_AXI_BLEN16;
-			break;
-		case 8:
-			value |= DMA_AXI_BLEN8;
-			break;
-		case 4:
-			value |= DMA_AXI_BLEN4;
-			break;
-		}
-	}
+	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
+				ARRAY_SIZE(axi->axi_blen));
 
 	writel(value, ioaddr + DMA_SYS_BUS_MODE);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index dfcb7ce79e76..f27126f05551 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -78,8 +78,6 @@
 					DMA_AXI_BLEN16 | DMA_AXI_BLEN8 | \
 					DMA_AXI_BLEN4)
 
-#define DMA_AXI_BURST_LEN_MASK		0x000000FE
-
 /* DMA TBS Control */
 #define DMA_TBS_FTOS			GENMASK(31, 8)
 #define DMA_TBS_FTOV			BIT(0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
index 967a735e9a0b..d1c149f7a3dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h
@@ -77,8 +77,6 @@ static inline u32 dma_chan_base_addr(u32 base, u32 chan)
 
 #define DMA_AXI_UNDEF		BIT(0)
 
-#define DMA_AXI_BURST_LEN_MASK	0x000000FE
-
 #define DMA_CUR_TX_BUF_ADDR	0x00001050	/* Current Host Tx Buffer */
 #define DMA_CUR_RX_BUF_ADDR	0x00001054	/* Current Host Rx Buffer */
 #define DMA_HW_FEATURE		0x00001058	/* HW Feature Register */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 16c6d03fc929..fecda3034d36 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -340,14 +340,7 @@
 #define XGMAC_LPI_XIT_PKT		BIT(14)
 #define XGMAC_AAL			DMA_AXI_AAL
 #define XGMAC_EAME			BIT(11)
-#define XGMAC_BLEN			GENMASK(7, 1)
-#define XGMAC_BLEN256			DMA_AXI_BLEN256
-#define XGMAC_BLEN128			DMA_AXI_BLEN128
-#define XGMAC_BLEN64			DMA_AXI_BLEN64
-#define XGMAC_BLEN32			DMA_AXI_BLEN32
-#define XGMAC_BLEN16			DMA_AXI_BLEN16
-#define XGMAC_BLEN8			DMA_AXI_BLEN8
-#define XGMAC_BLEN4			DMA_AXI_BLEN4
+/* XGMAC_BLEN* are now defined as DMA_AXI_BLEN* in common.h */
 #define XGMAC_UNDEF			BIT(0)
 #define XGMAC_TX_EDMA_CTRL		0x00003040
 #define XGMAC_TDPS			GENMASK(29, 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 4d6bb995d8d8..8a2cb6ca9588 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -84,7 +84,6 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
-	int i;
 
 	if (axi->axi_lpi_en)
 		value |= XGMAC_EN_LPI;
@@ -102,32 +101,13 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	if (!axi->axi_fb)
 		value |= XGMAC_UNDEF;
 
-	value &= ~XGMAC_BLEN;
-	for (i = 0; i < AXI_BLEN; i++) {
-		switch (axi->axi_blen[i]) {
-		case 256:
-			value |= XGMAC_BLEN256;
-			break;
-		case 128:
-			value |= XGMAC_BLEN128;
-			break;
-		case 64:
-			value |= XGMAC_BLEN64;
-			break;
-		case 32:
-			value |= XGMAC_BLEN32;
-			break;
-		case 16:
-			value |= XGMAC_BLEN16;
-			break;
-		case 8:
-			value |= XGMAC_BLEN8;
-			break;
-		case 4:
-			value |= XGMAC_BLEN4;
-			break;
-		}
-	}
+	/* Depending on the UNDEF bit the Master AXI will perform any burst
+	 * length according to the BLEN programmed (by default all BLEN are
+	 * set). Note that the UNDEF bit is readonly, and is the inverse of
+	 * Bus Mode bit 16.
+	 */
+	stmmac_axi_blen_to_mask(&value, axi->axi_blen,
+				ARRAY_SIZE(axi->axi_blen));
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
 	writel(XGMAC_TDPS, ioaddr + XGMAC_TX_EDMA_CTRL);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index aac8188248ff..e5ed61154557 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -189,6 +189,43 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 }
 EXPORT_SYMBOL_GPL(stmmac_set_clk_tx_rate);
 
+/**
+ * stmmac_axi_blen_to_mask() - convert a burst length array to reg value
+ * @regval: pointer to a u32 for the resulting register value
+ * @blen: pointer to an array of u32 containing the burst length values in bytes
+ * @len: the number of entries in the @blen array
+ */
+void stmmac_axi_blen_to_mask(u32 *regval, const u32 *blen, size_t len)
+{
+	size_t i;
+	u32 val;
+
+	for (val = i = 0; i < len; i++) {
+		u32 burst = blen[i];
+
+		/* Burst values of zero must be skipped. */
+		if (!burst)
+			continue;
+
+		/* The valid range for the burst length is 4 to 256 inclusive,
+		 * and it must be a power of two.
+		 */
+		if (burst < 4 || burst > 256 || !is_power_of_2(burst)) {
+			pr_err("stmmac: invalid burst length %u at index %zu\n",
+			       burst, i);
+			continue;
+		}
+
+		/* Since burst is a power of two, and the register field starts
+		 * with burst = 4, shift right by two bits so bit 0 of the field
+		 * corresponds with the minimum value.
+		 */
+		val |= burst >> 2;
+	}
+
+	u32p_replace_bits(regval, val, DMA_AXI_BLEN_MASK);
+}
+
 /**
  * stmmac_verify_args - verify the driver parameters.
  * Description: it checks the driver parameters and set a default in case of
-- 
2.47.3


