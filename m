Return-Path: <netdev+bounces-24000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64D76E6E7
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE231C21537
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BCD1ED37;
	Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D71ED59
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:29:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66A1E1981
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:29:38 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.245])
	by gateway (Coremail) with SMTP id _____8AxqOigj8tkA60PAA--.489S3;
	Thu, 03 Aug 2023 19:29:36 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.245])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM6dj8tkKx5HAA--.52441S5;
	Thu, 03 Aug 2023 19:29:36 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [PATCH v3 07/16] net: stmmac: dwmac1000: Add multiple retries for DMA reset
Date: Thu,  3 Aug 2023 19:29:27 +0800
Message-Id: <10952d824f3236758bcef3e5a3224e9ab87eac0f.1691047285.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1691047285.git.chenfeiyang@loongson.cn>
References: <cover.1691047285.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxzM6dj8tkKx5HAA--.52441S5
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFy3ZrWktw4UWw45Gr48GrX_yoW5Jw4xp3
	9rCa45XrW0qr18ta1DAw4DZFyrX3y5Kr4UurWIkwsa9a1IvrZ0qrn0qFWFy3W7XFWqgFya
	gF1Y9ry7uF1DX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0wqXPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DMA reset on some platforms may fail, so add the dma_reset_times
variable to control the number of retries.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c    |  3 +++
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c | 17 +++++++++++------
 include/linux/stmmac.h                          |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index abcce58e9c29..ad712e337a50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -541,6 +541,9 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	else
 		priv->plat->dwmac_regs = &dwmac_default_dma_regs;
 
+	if (!priv->plat->dma_reset_times)
+		priv->plat->dma_reset_times = 1;
+
 	priv->dev->priv_flags |= IFF_UNICAST_FLT;
 	mac->pcsr = priv->ioaddr;
 	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index fc0da4336e4e..de1b1844bb8a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -176,15 +176,20 @@ const struct dwmac_regs dwmac_loongson64_dma_regs = {
 
 int dwmac_dma_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 {
+	int err;
+	int cnt = priv->plat->dma_reset_times;
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 
-	/* DMA SW reset */
-	value |= DMA_BUS_MODE_SFT_RESET;
-	writel(value, ioaddr + DMA_BUS_MODE);
+	do {
+		value |= DMA_BUS_MODE_SFT_RESET;
+		writel(value, ioaddr + DMA_BUS_MODE);
 
-	return readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
-				 !(value & DMA_BUS_MODE_SFT_RESET),
-				 10000, 200000);
+		err = readl_poll_timeout(ioaddr + DMA_BUS_MODE, value,
+					 !(value & DMA_BUS_MODE_SFT_RESET),
+					 10000, 200000);
+	} while (cnt-- && err);
+
+	return err;
 }
 
 /* CSR1 enables the transmit DMA to check for new descriptor */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index e1b9ddf83fe5..ad2905cd226c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -357,5 +357,6 @@ struct plat_stmmacenet_data {
 	bool has_integrated_pcs;
 	const struct dwmac_regs *dwmac_regs;
 	bool fix_channel_num;
+	bool dma_reset_times;
 };
 #endif
-- 
2.39.3


