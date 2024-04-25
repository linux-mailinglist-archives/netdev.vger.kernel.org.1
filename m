Return-Path: <netdev+bounces-91312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A018B222D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF58283358
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55D149C56;
	Thu, 25 Apr 2024 13:04:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3E149C44
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050290; cv=none; b=tWDAWjNqj2DB/AXbNqby0vfOoeT6DyJ5BXkqvLgK2MoEQIbGHGhh+L0sd9ZtLmY6G5nvfUkq0DU7W9Adb4fEtPTPw8QQfKelPeQk2raFYK6pKz8Rn/HSkSRQPDGw+Al8Ez81+/THLS4//hgCNRGFDKc65KmKAI8Ei3BcWkZBT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050290; c=relaxed/simple;
	bh=tPBtVGOZHJa3U8LFiamezlcE1rMEWtE7AxQrFXk24SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clHOHyd8M1NRA4aF0hXUShHqp5jDetutN3bJHj/9c4O1YzuJOa8waeOkuMGZpIj82FYufkA60yyVlvzTAZN7e87H/ktdOVmV9Fu7CJBeHWGcMXIwEVU1hyQ4jMgfScOizKy/znuggBDdgjUSgx0SmR+gieu3YUy3+sXBXCuOfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8DxFuntVCpmD9ACAA--.651S3;
	Thu, 25 Apr 2024 21:04:45 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxtFbmVCpmnhkFAA--.1298S4;
	Thu, 25 Apr 2024 21:04:43 +0800 (CST)
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
Subject: [PATCH net-next v12 06/15] net: stmmac: dwmac-loongson: Split up the platform data initialization
Date: Thu, 25 Apr 2024 21:04:37 +0800
Message-Id: <e0ea692698171f9c69b80a70607a55805d249c4a.1714046812.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8DxtFbmVCpmnhkFAA--.1298S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF1DXF1rKF1kZF4ftF18Zwc_yoW5Cry7pr
	ZxCa9Fg34SqF1Skan8Jw4DZry5Aay3Kr929F42k34fGFyqk3s0vayrKFWjv397AFWDZF13
	ZF4jkrW8WF4DKwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUI0eHUUUUU

Based on IP core classification, loongson has two types of network
devices: GMAC and GNET. GMAC's ip_core id is 0x35/0x37, while GNET's
ip_core id is 0x37/0x10.

Device tables:

device    type    pci_id    snps_id    channel
ls2k1000  gmac    7a03      0x35/0x37   1
ls7a1000  gmac    7a03      0x35/0x37   1
ls2k2000  gnet    7a13      0x10        8
ls7a2000  gnet    7a13      0x37        1

The GMAC device only has a MAC chip inside and needs an
external PHY chip;

To later distinguish 8-channel gnet devices from single-channel
gnet/gmac devices, move rx_queues_to_use loongson_default_data
to loongson_dwmac_probe(). Also move mac_interface to
loongson_default_data().

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4e0838db4259..904e288d0be0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,22 +11,20 @@
 
 #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
 
-static int loongson_default_data(struct plat_stmmacenet_data *plat)
+static void loongson_default_data(struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
 	plat->force_sf_dma_mode = 1;
 
+	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
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
@@ -41,6 +39,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 	plat->dma_cfg->pblx8 = true;
 
 	plat->multicast_filter_bins = 256;
+}
+
+static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(plat);
+
 	return 0;
 }
 
@@ -109,11 +113,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	plat->phy_interface = phy_mode;
-	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
 
 	pci_set_master(pdev);
 
-	loongson_default_data(plat);
+	loongson_gmac_data(plat);
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
@@ -138,6 +141,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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


