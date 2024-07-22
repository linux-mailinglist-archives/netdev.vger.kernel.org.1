Return-Path: <netdev+bounces-112394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C8938DC6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBFB21206
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A216CD06;
	Mon, 22 Jul 2024 10:59:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496816C87A
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645972; cv=none; b=J+AohlBZGBqOb17t0B2KXYOrvsgkpoykGZMYJIjFXkHmoDVLi5U2IGmaL53lGIHg40F0ysmbu8jpTGG/7jZteckRagNPQVo3o7A1yXNLa7wZc+0BUllIIRpOYkERJDhdCv/izFW4O3oAC3CG8C7JyJM1VdTvcPSYBnQFg9IjCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645972; c=relaxed/simple;
	bh=jaHl6EYp6re8SjqNZtjTlMacuNIgrZqaXHfrDEdXHmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OmkvQH3UxMmkpeVaDXyufstNlGG0zawhiWec0jBcfqf6yuaYg3kGu8GYrl1pHfllHMYWegPAZ3iMK+MelzTVzxam849L6aYixKeprXPVTIqTbLtb6ubKK0fDn9EmrTXZ6FW4odTesW/MyZi+2WHo82C8+a+C4gYXuXy6yP06h2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlsWEO55mGxtUAA--.44776S2;
	Mon, 22 Jul 2024 18:59:17 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net-next RFC v15 01/14] net: stmmac: Move the atds flag to the stmmac_dma_cfg structure
Date: Mon, 22 Jul 2024 18:59:14 +0800
Message-Id: <39b18ad7c588c0f762f8b79035124dfb0d90a364.1721645682.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1721645682.git.siyanteng@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxlsWEO55mGxtUAA--.44776S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4UZw4kXF1fWF43Xr4Dtwb_yoWxKFW5pF
	W7Aa4j9r9rtr1xXa1kAw4UZFy5Ga43tFW7uw4xGw4S9FZ2kryYqrnIgFWYyFnrJF4rWa4a
	qF4qkw13CF1kArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

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
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
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
index adccdd816ea9..984b809105af 100644
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
index b402fb54f613..82957db47c99 100644
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
index 97934ccba5b1..dc6dbb6ce50a 100644
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
index 4b6a359e5a94..5aa0c776757d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3003,7 +3003,6 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	struct stmmac_rx_queue *rx_q;
 	struct stmmac_tx_queue *tx_q;
 	u32 chan = 0;
-	int atds = 0;
 	int ret = 0;
 
 	if (!priv->plat->dma_cfg || !priv->plat->dma_cfg->pbl) {
@@ -3012,7 +3011,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	if (priv->extend_desc && (priv->mode == STMMAC_RING_MODE))
-		atds = 1;
+		priv->plat->dma_cfg->atds = 1;
 
 	ret = stmmac_reset(priv, priv->ioaddr);
 	if (ret) {
@@ -3021,7 +3020,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	}
 
 	/* DMA Configuration */
-	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg, atds);
+	stmmac_dma_init(priv, priv->ioaddr, priv->plat->dma_cfg);
 
 	if (priv->plat->axi)
 		stmmac_axi(priv, priv->ioaddr, priv->plat->axi);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 84e13bd5df28..338991c08f00 100644
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


