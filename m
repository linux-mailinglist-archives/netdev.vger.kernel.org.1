Return-Path: <netdev+bounces-98969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B718D345A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF501C231DD
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB517B424;
	Wed, 29 May 2024 10:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEB167DAB
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977919; cv=none; b=lDNFq+/gxkTH+m11Fmq4jQfkmfcTrWUlZLGkwvguWBGnxfspbvbh8Hx6Zek6M5Iwf4+has1cmUJlzm4wbe+WseWEd8W2/DGdp7+7Sapx6Z7sAadwaw2cFczBWlcphKYMwdi8+cQ1+SZrEPChYHGYvc7Fs/b9MBlwq81fFoMryx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977919; c=relaxed/simple;
	bh=c/jFtgS8gh4hkV7x82eyvee14Sc3okr3oI4yUmE+TZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlHgAwBl83A7M1GJdWWdKV/q2m5Q9hTAOg3gyspn43emtTmmvR729q1yICA29zLlxBRCvUVLs57bsMcYuX7dwqC/kEP3Bf6sm9y6zZSKqbm9RiPVR3d8ccIndlOMXsfV/tcAGpBG92xQAHXIAQ7hUTOqkxP5OoYuFHapYQvk0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8Cxe+r6AFdmsxgBAA--.4642S3;
	Wed, 29 May 2024 18:18:34 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMX1AFdmaN4MAA--.23140S2;
	Wed, 29 May 2024 18:18:30 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v13 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
Date: Wed, 29 May 2024 18:18:17 +0800
Message-Id: <08734b4fe834e1b75a81f00b6b4c105e0aee52ce.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMX1AFdmaN4MAA--.23140S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4UZw4kXFWxtFWfAw1fGrX_yoWxKrWDpa
	y7Aa409r9rtr1xXa1kAw4UZFy5Ga43trW7uw4xGw4S9FZ29ryYqrnIgFWYyFnrJF4rWa4a
	qF4qkw13CF1kArbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Q18PUUUUU==

ATDS (Alternate Descriptor Size) is a part of the DMA Bus Mode configs
(together with PBL, ALL, EME, etc) of the DW GMAC controllers. Seeing
it's not changed at runtime but is activated as long as the IP-core
has it supported (at least due to the Type 2 Full Checksum Offload
Engine feature), move the respective parameter from the
stmmac_dma_ops::init() callback argument to the stmmac_dma_cfg
structure, which already have the rest of the DMA-related configs
defined.

Besides the being added in the next commit DW GMAC multi-channels
support will require to add the stmmac_dma_ops::init_chan() callback
and have the ATDS flag set/cleared for each channel in there. Having
the atds-flag in the stmmac_dma_cfg structure will make the parameter
accessible from stmmac_dma_ops::init_chan() callback too.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h          | 3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 5 ++---
 include/linux/stmmac.h                              | 1 +
 8 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index e1b761dcfa1d..d87079016952 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -299,7 +299,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
  * Called from stmmac via stmmac_dma_ops->init
  */
 static void sun8i_dwmac_dma_init(void __iomem *ioaddr,
-				 struct stmmac_dma_cfg *dma_cfg, int atds)
+				 struct stmmac_dma_cfg *dma_cfg)
 {
 	writel(EMAC_RX_INT | EMAC_TX_INT, ioaddr + EMAC_INT_EN);
 	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index daf79cdbd3ec..bb82ee9b855f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -71,7 +71,7 @@ static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 }
 
 static void dwmac1000_dma_init(void __iomem *ioaddr,
-			       struct stmmac_dma_cfg *dma_cfg, int atds)
+			       struct stmmac_dma_cfg *dma_cfg)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 	int txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
@@ -98,7 +98,7 @@ static void dwmac1000_dma_init(void __iomem *ioaddr,
 	if (dma_cfg->mixed_burst)
 		value |= DMA_BUS_MODE_MB;
 
-	if (atds)
+	if (dma_cfg->atds)
 		value |= DMA_BUS_MODE_ATDS;
 
 	if (dma_cfg->aal)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index dea270f60cc3..f861babc06f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -19,7 +19,7 @@
 #include "dwmac_dma.h"
 
 static void dwmac100_dma_init(void __iomem *ioaddr,
-			      struct stmmac_dma_cfg *dma_cfg, int atds)
+			      struct stmmac_dma_cfg *dma_cfg)
 {
 	/* Enable Application Access by writing to DMA CSR0 */
 	writel(DMA_BUS_MODE_DEFAULT | (dma_cfg->pbl << DMA_BUS_MODE_PBL_SHIFT),
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 84d3a8551b03..e0165358c4ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -153,7 +153,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 }
 
 static void dwmac4_dma_init(void __iomem *ioaddr,
-			    struct stmmac_dma_cfg *dma_cfg, int atds)
+			    struct stmmac_dma_cfg *dma_cfg)
 {
 	u32 value = readl(ioaddr + DMA_SYS_BUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dd2ab6185c40..7840bc403788 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -20,7 +20,7 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 }
 
 static void dwxgmac2_dma_init(void __iomem *ioaddr,
-			      struct stmmac_dma_cfg *dma_cfg, int atds)
+			      struct stmmac_dma_cfg *dma_cfg)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 90384db228b5..413441eb6ea0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -175,8 +175,7 @@ struct dma_features;
 struct stmmac_dma_ops {
 	/* DMA core initialization */
 	int (*reset)(void __iomem *ioaddr);
-	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg,
-		     int atds);
+	void (*init)(void __iomem *ioaddr, struct stmmac_dma_cfg *dma_cfg);
 	void (*init_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  struct stmmac_dma_cfg *dma_cfg, u32 chan);
 	void (*init_rx_chan)(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..99da314508c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3006,7 +3006,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
 	u32 chan = 0;
-	int atds = 0;
 	int ret = 0;
 
 	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
@@ -3015,7 +3014,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
-		atds = 1;
+		priv->plat->dma_cfg->atds = 1;
 
 	ret = stmmac_reset(priv, priv->ioaddr);
 	if (ret) {
@@ -3024,7 +3023,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	/* DMA Configuration */
-	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg, atds);
+	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
 
 	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f92c195c76ed..1536455f9052 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -100,6 +100,7 @@ struct stmmac_dma_cfg {
 	bool eame;
 	bool multi_msi_en;
 	bool dche;
+	bool atds;
 };
 
 #define AXI_BLEN	7
-- 
2.31.4


