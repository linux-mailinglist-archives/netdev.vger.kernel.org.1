Return-Path: <netdev+bounces-116482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5594A8DD
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B328233E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B181E2122;
	Wed,  7 Aug 2024 13:47:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2211EA0BB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038448; cv=none; b=Q0fk3dss1uTC7d7P3VXVEZDGF6HhivTbLBgM0vpRrsNGysP35L0DT+9/s8bX1Fkj727HPffPISXQxA+YyGd/h63dT7Zshswy7ZFpZodUkFkUW83PeH4gZWRpLiAuhWeKC7H156gQ31Zxg6hE6y8Z1xHXpyq8HTBawJGA62lZzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038448; c=relaxed/simple;
	bh=tn1m7ywuGBLcfHyVIWcaZB1RolZiYVpZZgJucerEBD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoHpTf4+MtXdc7ZYV+XYzAa9Fv1Cj+IAFz7x2WKDQ/0IlngdLiK8boPc+pavQgMAm9EkmeKcLno7Ad+/oVlDy5cB6nXcdlmddE7B41Zx+RWBrX/vOhVgQY6Qb5xPjtHc6ZzhPxRFSHMmWPeS1tHARLXXqpf0w3FrXynma9GZtEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.71])
	by gateway (Coremail) with SMTP id _____8CxruvserNmqXYKAA--.32260S3;
	Wed, 07 Aug 2024 21:47:24 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.71])
	by front1 (Coremail) with SMTP id qMiowMAxVODferNm9B0IAA--.41070S5;
	Wed, 07 Aug 2024 21:47:22 +0800 (CST)
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
Subject: [PATCH net-next v17 07/14] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
Date: Wed,  7 Aug 2024 21:47:10 +0800
Message-Id: <45e176b8a33c35e809a890677c9169d0520a76c8.1723014611.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1723014611.git.siyanteng@loongson.cn>
References: <cover.1723014611.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVODferNm9B0IAA--.41070S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1kXF1rArW8tw18JrWUGFX_yoW5tw1Upr
	W3u3srW3sIqF1Iywn8J3yDZF15Aayrtry29F4jk34xC34DCwn0q347KF40yrZ7AFZ5ua17
	ZF4jkr4xuFZ8KwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42
	IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUx2Q6DUUUU

Loongson delivers two types of the network devices: Loongson GMAC and
Loongson GNET in the framework of four SOC/Chipsets revisions:

   Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
LS2K1000 SOC         GMAC      0x7a03       v3.50a/v3.73a        1
LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
LS2K2000 SOC         GMAC      0x7a03          v3.73a            8
LS2K2000 SOC         GNET      0x7a13          v3.73a            8
LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

The driver currently supports the chips with the Loongson GMAC network
device synthesized with a single DMA-channel available. As a
preparation before adding the Loongson GNET support detach the
Loongson GMAC-specific platform data initializations to the
loongson_gmac_data() method and preserve the common settings in the
loongson_default_data().

While at it drop the return value statement from the
loongson_default_data() method as redundant.

Note there is no intermediate vendor-specific PCS in between the MAC
and PHY on Loongson GMAC and GNET. So the plat->mac_interface field
can be freely initialized with the PHY_INTERFACE_MODE_NA value.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f39c13a74bb5..9b2e4bdf7cc7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,7 +11,7 @@
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 
-static int loongson_default_data(struct plat_stmmacenet_data *plat)
+static void loongson_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
@@ -20,16 +20,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 	/* Set default value for multicast hash bins */
 	plat->multicast_filter_bins = 256;
 
+	plat->mac_interface = PHY_INTERFACE_MODE_NA;
+
 	/* Set default value for unicast filter entries */
 	plat->unicast_filter_entries = 1;
 
 	/* Set the maxmtu to a default of JUMBO_LEN */
 	plat->maxmtu = JUMBO_LEN;
 
-	/* Set default number of RX and TX queues to use */
-	plat->tx_queues_to_use = 1;
-	plat->rx_queues_to_use = 1;
-
 	/* Disable Priority config by default */
 	plat->tx_queues_cfg[0].use_prio = false;
 	plat->rx_queues_cfg[0].use_prio = false;
@@ -42,6 +40,14 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
+}
+
+static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(plat);
+
+	plat->tx_queues_to_use = 1;
+	plat->rx_queues_to_use = 1;
 
 	return 0;
 }
@@ -111,11 +117,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	plat->phy_interface = phy_mode;
-	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
 
 	pci_set_master(pdev);
 
-	loongson_default_data(plat);
+	loongson_gmac_data(plat);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
 
-- 
2.31.4


