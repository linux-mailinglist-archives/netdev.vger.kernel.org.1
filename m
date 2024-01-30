Return-Path: <netdev+bounces-67035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C3841E56
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C3A289762
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791EA5823E;
	Tue, 30 Jan 2024 08:49:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8843ABC
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604574; cv=none; b=m/6+cUeLSISlAHLl/cvrvUGFTGb2NdK++2jODAZMuuGyUEOWhMR/1gq4miYDoak9Yrn4tK6nbj+MZB09JJr408BesuTw0Y/SoVV74v4S8sIMBPKHIQtJz7LcMr5vErECmItWorUPLR5fCqiv5PMVQwOmDyPzwgOc1UEnmalMnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604574; c=relaxed/simple;
	bh=YgSMRN4Qj0z2oOYMupaSQkezAi/j1I70lf8ENB4f+Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfbTSdJDdLNoc+3vC5jzTpZHXF++lJLuwOf36Cyw3WC4W5vBYUQu/rcNcEWMfcJanW96qEUrvesPm4L2VMgGGnSQICQzd6RITBwFBEJ1qlo1BgiEup9GYr7I11hznMTD/R8VSdA22piesSoWTCRwcp5Wy8arMBvxb9fRh8X3Dmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8AxOOgauLhlfEUIAA--.5890S3;
	Tue, 30 Jan 2024 16:49:30 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OQWuLhlRLEnAA--.24196S4;
	Tue, 30 Jan 2024 16:49:28 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@loongson.cn,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: [PATCH net-next v8 11/11] net: stmmac: dwmac-loongson: Disable coe for some Loongson GNET
Date: Tue, 30 Jan 2024 16:49:16 +0800
Message-Id: <151e688e8977376c3c97548540f8e15d272685cb.1706601050.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1706601050.git.siyanteng@loongson.cn>
References: <cover.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx8OQWuLhlRLEnAA--.24196S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fGF45JrWfGr18XF48Zrc_yoW5uF1xpr
	y7Ja4qkFyDKFn7Zan3trZ5XrW5WFWF9rWxWFW2k3yxCF4q9Fy5Xr1aya4UAas7Za4kXr12
	vF48Crn8WFyqqrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4PfQUUUUU=

Some chips of Loongson GNET does not support coe, so disable them.

Set dma_cap->tx_coe to 0 and overwrite get_hw_feature.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index b78a73ea748b..8018d7d5f31b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -196,6 +196,51 @@ static int dwlgmac_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 	return ret;
 }
 
+static int dwlgmac_get_hw_feature(void __iomem *ioaddr,
+				  struct dma_features *dma_cap)
+{
+	u32 hw_cap = readl(ioaddr + DMA_HW_FEATURE);
+
+	if (!hw_cap) {
+		/* 0x00000000 is the value read on old hardware that does not
+		 * implement this register
+		 */
+		return -EOPNOTSUPP;
+	}
+
+	dma_cap->mbps_10_100 = (hw_cap & DMA_HW_FEAT_MIISEL);
+	dma_cap->mbps_1000 = (hw_cap & DMA_HW_FEAT_GMIISEL) >> 1;
+	dma_cap->half_duplex = (hw_cap & DMA_HW_FEAT_HDSEL) >> 2;
+	dma_cap->hash_filter = (hw_cap & DMA_HW_FEAT_HASHSEL) >> 4;
+	dma_cap->multi_addr = (hw_cap & DMA_HW_FEAT_ADDMAC) >> 5;
+	dma_cap->pcs = (hw_cap & DMA_HW_FEAT_PCSSEL) >> 6;
+	dma_cap->sma_mdio = (hw_cap & DMA_HW_FEAT_SMASEL) >> 8;
+	dma_cap->pmt_remote_wake_up = (hw_cap & DMA_HW_FEAT_RWKSEL) >> 9;
+	dma_cap->pmt_magic_frame = (hw_cap & DMA_HW_FEAT_MGKSEL) >> 10;
+	/* MMC */
+	dma_cap->rmon = (hw_cap & DMA_HW_FEAT_MMCSEL) >> 11;
+	/* IEEE 1588-2002 */
+	dma_cap->time_stamp =
+	    (hw_cap & DMA_HW_FEAT_TSVER1SEL) >> 12;
+	/* IEEE 1588-2008 */
+	dma_cap->atime_stamp = (hw_cap & DMA_HW_FEAT_TSVER2SEL) >> 13;
+	/* 802.3az - Energy-Efficient Ethernet (EEE) */
+	dma_cap->eee = (hw_cap & DMA_HW_FEAT_EEESEL) >> 14;
+	dma_cap->av = (hw_cap & DMA_HW_FEAT_AVSEL) >> 15;
+	/* TX and RX csum */
+	dma_cap->tx_coe = 0;
+	dma_cap->rx_coe_type1 = (hw_cap & DMA_HW_FEAT_RXTYP1COE) >> 17;
+	dma_cap->rx_coe_type2 = (hw_cap & DMA_HW_FEAT_RXTYP2COE) >> 18;
+	dma_cap->rxfifo_over_2048 = (hw_cap & DMA_HW_FEAT_RXFIFOSIZE) >> 19;
+	/* TX and RX number of channels */
+	dma_cap->number_rx_channel = (hw_cap & DMA_HW_FEAT_RXCHCNT) >> 20;
+	dma_cap->number_tx_channel = (hw_cap & DMA_HW_FEAT_TXCHCNT) >> 22;
+	/* Alternate (enhanced) DESC mode */
+	dma_cap->enh_desc = (hw_cap & DMA_HW_FEAT_ENHDESSEL) >> 24;
+
+	return 0;
+}
+
 struct stmmac_pci_info {
 	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
 	int (*config)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat,
@@ -542,6 +587,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
 		ld->dwlgmac_dma_ops = dwmac1000_dma_ops;
 		ld->dwlgmac_dma_ops.init_chan = dwlgmac_dma_init_channel;
 		ld->dwlgmac_dma_ops.dma_interrupt = dwlgmac_dma_interrupt;
+		ld->dwlgmac_dma_ops.get_hw_feature = dwlgmac_get_hw_feature;
 
 		plat->setup = loongson_setup;
 		ret = loongson_dwmac_config_multi_msi(pdev, plat, &res, np, 8);
-- 
2.31.4


