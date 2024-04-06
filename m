Return-Path: <netdev+bounces-85411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9131189AB10
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB11F211F3
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBD7364A5;
	Sat,  6 Apr 2024 13:24:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8722C1A3
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409898; cv=none; b=R6hr5r4z9OXc9IZF6eIP+WZKoMhM0iAqyyR95zJBHu3Tcmt5aEu9/hgyU03lqreKLlqlChqwOSb+F/4jr1p/H5Vl/8jjcaBPFL3yBHwAnEx3itFRk54dgAYrLpQC22hjT6WHtJZXBA3Gk4hD9JADiftDbBiYGEgNKFgHTmI+x6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409898; c=relaxed/simple;
	bh=hfUAZGBIUSem7UEHdUFHfV18tVjvVOz5jhIjnSxh+K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyImX8M2ppOkSfoKtD+YGAEsY/X+m03zGkU8mKY00Hc0QTo+9Uhfnrd5RvZGbNfGpRyAw2HgFfR36hWE5zopt+IsZlPv6bZstnj3FFLjEvQSpxbI83NguyuwcmtJ14Wz17m9RZnFZp4IG1oGXP7ipbJ8YBtRiZrpwhNQhOL4KKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8AxjrskTRFmktgjAA--.2908S3;
	Sat, 06 Apr 2024 21:24:52 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXRMiTRFmjDp0AA--.28122S2;
	Sat, 06 Apr 2024 21:24:51 +0800 (CST)
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
	chris.chenfeiyang@gmail.com,
	siyanteng01@gmail.com
Subject: [PATCH net-next v9 4/6] net: stmmac: dwmac-loongson: Introduce gmac setup
Date: Sat,  6 Apr 2024 21:24:38 +0800
Message-Id: <fe244bae9522d543b94c0e6e347c77a5c809a981.1712407009.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1712407009.git.siyanteng@loongson.cn>
References: <cover.1712407009.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXRMiTRFmjDp0AA--.28122S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr43AFWxtrW8KF4rAry7Arc_yoW5Xr4Dpr
	ZxCasFg34ftF12kan8Jw4DZF15AayYyryxuF42k34fGFWqkw4qq34rKFWjvws7JFWkX3W3
	ZF4jyr4xWF4DAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
	6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==

Based on IP core classification, loongson has two devices,
0x37 is gmac, 0x10 is gnet, and the current device is gmac.

Difference:
device    type    pci_id    ip_core
ls7a1000  gmac    7a03      0x35/0x37
ls2k1000  gmac    7a03      0x37
ls7a2000  gnet    7a13      0x37
ls2k2000  gnet    7a13      0x10

The ref/ptp clock of gmac is 125000000. gmac device only
has a MAC chip inside and needs an external PHY chip;

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ca475baae73d..20ddbf0dc6ab 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -9,7 +9,8 @@
 #include <linux/of_irq.h>
 #include "stmmac.h"
 
-static int loongson_default_data(struct plat_stmmacenet_data *plat)
+static void loongson_default_data(struct pci_dev *pdev,
+				  struct plat_stmmacenet_data *plat)
 {
 	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
 	plat->has_gmac = 1;
@@ -24,16 +25,18 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 	/* Set the maxmtu to a default of JUMBO_LEN */
 	plat->maxmtu = JUMBO_LEN;
 
-	/* Set default number of RX and TX queues to use */
-	plat->tx_queues_to_use = 1;
-	plat->rx_queues_to_use = 1;
-
 	/* Disable Priority config by default */
 	plat->tx_queues_cfg[0].use_prio = false;
 	plat->rx_queues_cfg[0].use_prio = false;
 
 	/* Disable RX queues routing by default */
 	plat->rx_queues_cfg[0].pkt_route = 0x0;
+}
+
+static int loongson_gmac_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(pdev, plat);
 
 	/* Default to phy auto-detection */
 	plat->phy_addr = -1;
@@ -42,6 +45,12 @@ static int loongson_default_data(struct plat_stmmacenet_data *plat)
 	plat->dma_cfg->pblx8 = true;
 
 	plat->multicast_filter_bins = 256;
+	plat->clk_ref_rate = 125000000;
+	plat->clk_ptp_rate = 125000000;
+
+	plat->tx_queues_to_use = 1;
+	plat->rx_queues_to_use = 1;
+
 	return 0;
 }
 
@@ -113,7 +122,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 
 	pci_set_master(pdev);
 
-	loongson_default_data(plat);
+	loongson_gmac_data(pdev, plat);
 	pci_enable_msi(pdev);
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
-- 
2.31.4


