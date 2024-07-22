Return-Path: <netdev+bounces-112400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C466D938DCC
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD3D1F218D4
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0616C6B8;
	Mon, 22 Jul 2024 11:00:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B524B2F
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646049; cv=none; b=lq3BypU1+Tn83nl+gGJjBpmhpA7PS+79zMCBJO+2IzlYZq7hVYGC/vVF2s1SiI3ilKB01u3oZxhcpB2oK8gGPkOah5wf7JIHuHl48vJweLIEeE2e932I9y3jWkigx7bWUyvZEwSFg/nMuRWW3dNf9ymykjvTJcci53fo320fZ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646049; c=relaxed/simple;
	bh=BcvSI1otAaqSDQxiGdBCU4Ld+cpOme1W2LO5yM2zuB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJ/LuLh+bj/aB1mBnn6PzbzrXFtnEzdf1wLftm7NKzRZ2RJzUCymX97QNZX4d8N0eEHq9YrLr69+5w0rKVldpwKb2UB/4slInaNTxr9I803AJGJPeWq06WTuD58lnUNVEVK/JmS+Hwg1exkDJf7KzkUbCLUyYXGPKrBAs4psckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMfUO55mcBtUAA--.55713S2;
	Mon, 22 Jul 2024 19:00:37 +0800 (CST)
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
Subject: [PATCH net-next RFC v15 07/14] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
Date: Mon, 22 Jul 2024 19:00:29 +0800
Message-Id: <bc92d2f0dc225dea4d8f03332b315994fe636ad9.1721645682.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8AxDMfUO55mcBtUAA--.55713S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kXF1rAr4fAF45ZryrWFg_yoW5tFW8pr
	W3C3sFg3sFqF1Iywn8Jw4DZr15Aayrtry29F4jk34xC34DG34qq347KF40yrZ7AFZ5u3W7
	ZF4jkr4xWFs8KwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6r4kMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbw0ePUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

Loongson delivers two types of the network devices: Loongson GMAC and
Loongson GNET in the framework of four CPU/Chipsets revisions:

   Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
LS2K2000 CPU         GMAC      0x7a03          v3.73a            8
LS2K2000 CPU         GNET      0x7a13          v3.73a            8
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


