Return-Path: <netdev+bounces-91307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085868B2227
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A131F246D0
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5466149C4B;
	Thu, 25 Apr 2024 13:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6501494D8
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050153; cv=none; b=oNVJyqpDQLqk63kcvMQ+4Vg5i1O6ZcAxigh3AFtbgGLePVnVHF7GTkS7pxNCnHxZVhjPOSzKJlickuhS0tcDGX6cxstf3fvMJFKYon0KXQWvFLVfhcSUqUefDYso148vIQMSDzjk6ZvEJKH/cA0vtw3TrqBs4qcmvGqvsfDMzBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050153; c=relaxed/simple;
	bh=cnPlOgBvXGmG/PEmNET2kKgdzzjgReq2zoIP7ekv6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+OCMGvedHRkOUaDR498sdvmvbOCOpLO4gTH0g5ntJ4b5ga9Sd69pfkjwEyt1gd5+PYx+8pReXk6J51Ho4+8swNib5mFS54+3zZ3VnwI6nqGWnqFDETnPNjlD2U7oF5H4DyBuUX0uiB3LMxkRZlivNdhmVaUcQCgf/xGNkCtu4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8Dx_+tiVCpmvM8CAA--.13286S3;
	Thu, 25 Apr 2024 21:02:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQ1ZbVCpmChkFAA--.1253S3;
	Thu, 25 Apr 2024 21:02:24 +0800 (CST)
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
	siyanteng01@gmail.com
Subject: [PATCH net-next v12 01/15] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
Date: Thu, 25 Apr 2024 21:01:54 +0800
Message-Id: <3f9089bae8391d1263ef9c2b7a7c09de56308387.1714046812.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1714046812.git.siyanteng@loongson.cn>
References: <cover.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxQ1ZbVCpmChkFAA--.1253S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15Cw18Cry7ZryUXFyUtwc_yoWxWrW3pa
	y7Aa409r9rtr1xXa1kAw4UZFy5Ga43trW7ua1xGw4S9FZ2kryYqrnIgFWjyrnrJF4rWa4a
	qF4qkw13CF1kArbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Alternate Descriptor Size (ATDS) is a part of the DMA-configs together
with the PBL, ALL, AEME, etc so the structure is the most suitable
place for it.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
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
index 59bf83904b62..188514ca6c47 100644
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
index dfa1828cd756..1b54b84a6785 100644
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


