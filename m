Return-Path: <netdev+bounces-98972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85278D345F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20B3AB22BB9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CE178387;
	Wed, 29 May 2024 10:19:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D03178CE8
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977967; cv=none; b=nUJWmlSlDIQCuHLkBaeWnGbN2a79+/dUasbniiJPnJo+9Ka+jA02RvFSR4+Xe4zaYkbeHeHhiShnnyNnRE4wQHBnVN9UP9xORx2OaGUgaoQxPfyZdrM72Pw0Jey8ll+6w1A3c70/9R09sMmvlh8oV5Vwnl6ut4Wamwg8Jayj51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977967; c=relaxed/simple;
	bh=PIrebmViJOSe/5DBIZXaYYdpU3JgWlxAxOsHoTfhvng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+Egno/T8UDjJYfsAqICnocPrOdtqLr5DrKCw0NvFrgdxr8N42AVEPRUeMhzcXq2dWfDjxD0qS57lr1/yczqaXxcKxADutkdMsDh/KrHYZAOkmqBRWV8O7rYpNu3xV7UnJlQWpbrmChwv3ixsNZGRgG99k839WQqwqRtrIFVQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8CxL_AqAVdm4RgBAA--.4832S3;
	Wed, 29 May 2024 18:19:22 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxacYhAVdmet4MAA--.33713S4;
	Wed, 29 May 2024 18:19:17 +0800 (CST)
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
Subject: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach GMAC-specific platform data init
Date: Wed, 29 May 2024 18:19:03 +0800
Message-Id: <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8CxacYhAVdmet4MAA--.33713S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1fur15Wr48tr1xXw4UJrc_yoW5uF4Upr
	W3CasFg34aqr1Iyws8Jw4DZry5Aay5try29F42k34fC3yDCwn0qa43KFW0yrZ7AFWkZ3W3
	ZF4jkr4xWFs8KwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=

Loongson delivers two types of the network devices: Loongson GMAC and
Loongson GNET in the framework of four CPU/Chipsets revisions:

   Chip             Network  PCI Dev ID   Synopys Version   DMA-channel
LS2K1000 CPU         GMAC      0x7a03       v3.50a/v3.73a        1
LS7A1000 Chipset     GMAC      0x7a03       v3.50a/v3.73a        1
LS2K2000 CPU         GNET      0x7a13          v3.73a            8
LS7A2000 Chipset     GNET      0x7a13          v3.73a            1

The driver currently supports the chips with the Loongson GMAC network
device. As a preparation before adding the Loongson GNET support
detach the Loongson GMAC-specific platform data initializations to the
loongson_gmac_data() method and preserve the common settings in the
loongson_default_data().

While at it drop the return value statement from the
loongson_default_data() method as redundant.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 739b73f4fc35..ad3f44440963 100644
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
@@ -42,6 +40,11 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
+}
+
+static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(plat);
 
 	return 0;
 }
@@ -111,11 +114,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	plat->phy_interface = phy_mode;
-	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
 
 	pci_set_master(pdev);
 
-	loongson_default_data(plat);
+	loongson_gmac_data(plat);
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
@@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 		goto err_disable_msi;
 	}
 
+	plat->tx_queues_to_use = 1;
+	plat->rx_queues_to_use = 1;
+
 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (ret)
 		goto err_disable_msi;
-- 
2.31.4


