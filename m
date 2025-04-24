Return-Path: <netdev+bounces-185412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14BA9A43C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF2318898AD
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1E2405EC;
	Thu, 24 Apr 2025 07:22:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A291F153C;
	Thu, 24 Apr 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479373; cv=none; b=KrlizAGu5oZ82p+N+twfNxFnTNuVK1ePG0laOP1hOEshkiMMmhnXKMprsTaeCCuCrmcPkT8I9vJSnHMry+s0/i7csYQG6Tv7XBrQii7/LzgGdvC1B5vGZh4q09PEdzwFb7pGtVDtxlxr5hAx3a/vUcmAQmkTKA61aYWeBr8dTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479373; c=relaxed/simple;
	bh=tcfZgMzg+sfw+anoWE/w1Xw3B5rpWogqZI+nYaVVg3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6oxL8NyIJCmNZxwHDYWLSUHBH4dxTXT46Oi9DCbCsfxAqEuX2vDCW9FCDYQXtE6IbW7+jQBKI406XQikWSmW7ypV88YirABqC1WRbfsSBG1htsXp+rZZqtQRp8at1Qx/PTWHUImGVEHZcKKhbvor2lDwwGZdSS5zoQAt63tQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8Bx12nH5glo4CXFAA--.64587S3;
	Thu, 24 Apr 2025 15:22:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMDxfRur5glo5CaTAA--.5456S3;
	Thu, 24 Apr 2025 15:22:44 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Feiyang Chen <chris.chenfeiyang@gmail.com>,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Henry Chen <chenx97@aosc.io>,
	Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH net-next V3 1/3] net: stmmac: dwmac-loongson: Move queue number init to common function
Date: Thu, 24 Apr 2025 15:22:07 +0800
Message-ID: <20250424072209.3134762-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424072209.3134762-1-chenhuacai@loongson.cn>
References: <20250424072209.3134762-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxfRur5glo5CaTAA--.5456S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw4fZFy5GFW3Gry3Kw45Arc_yoW5urWDp3
	y3A3y7XrWfJr9xKws5t3yUCry5ArZYqr9FqF47Ka4rGryqkw1qv34rKFWvkFZ7AFZ8ua17
	ZF4jkr47WF1qkrbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

Currently, the tx and rx queue number initialization is duplicated in
loongson_gmac_data() and loongson_gnet_data(), so move it to the common
function loongson_default_data().

This is a preparation for later patches.

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
Tested-by: Henry Chen <chenx97@aosc.io>
Tested-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 54 ++++++-------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 1a93787056a7..2fb7a137b312 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -83,6 +83,8 @@ struct stmmac_pci_info {
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
+	struct loongson_data *ld = plat->bsp_priv;
+
 	/* Get bus_id, this can be overwritten later */
 	plat->bus_id = pci_dev_id(pdev);
 
@@ -116,32 +118,27 @@ static void loongson_default_data(struct pci_dev *pdev,
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
+
+	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
+		plat->rx_queues_to_use = CHANNEL_NUM;
+		plat->tx_queues_to_use = CHANNEL_NUM;
+
+		/* Only channel 0 supports checksum,
+		 * so turn off checksum to enable multiple channels.
+		 */
+		for (int i = 1; i < CHANNEL_NUM; i++)
+			plat->tx_queues_cfg[i].coe_unsupported = 1;
+	} else {
+		plat->tx_queues_to_use = 1;
+		plat->rx_queues_to_use = 1;
+	}
 }
 
 static int loongson_gmac_data(struct pci_dev *pdev,
 			      struct plat_stmmacenet_data *plat)
 {
-	struct loongson_data *ld;
-	int i;
-
-	ld = plat->bsp_priv;
-
 	loongson_default_data(pdev, plat);
 
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
-		plat->rx_queues_to_use = CHANNEL_NUM;
-		plat->tx_queues_to_use = CHANNEL_NUM;
-
-		/* Only channel 0 supports checksum,
-		 * so turn off checksum to enable multiple channels.
-		 */
-		for (i = 1; i < CHANNEL_NUM; i++)
-			plat->tx_queues_cfg[i].coe_unsupported = 1;
-	} else {
-		plat->tx_queues_to_use = 1;
-		plat->rx_queues_to_use = 1;
-	}
-
 	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
 	return 0;
@@ -172,27 +169,8 @@ static void loongson_gnet_fix_speed(void *priv, int speed, unsigned int mode)
 static int loongson_gnet_data(struct pci_dev *pdev,
 			      struct plat_stmmacenet_data *plat)
 {
-	struct loongson_data *ld;
-	int i;
-
-	ld = plat->bsp_priv;
-
 	loongson_default_data(pdev, plat);
 
-	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
-		plat->rx_queues_to_use = CHANNEL_NUM;
-		plat->tx_queues_to_use = CHANNEL_NUM;
-
-		/* Only channel 0 supports checksum,
-		 * so turn off checksum to enable multiple channels.
-		 */
-		for (i = 1; i < CHANNEL_NUM; i++)
-			plat->tx_queues_cfg[i].coe_unsupported = 1;
-	} else {
-		plat->tx_queues_to_use = 1;
-		plat->rx_queues_to_use = 1;
-	}
-
 	plat->phy_interface = PHY_INTERFACE_MODE_GMII;
 	plat->mdio_bus_data->phy_mask = ~(u32)BIT(2);
 	plat->fix_mac_speed = loongson_gnet_fix_speed;
-- 
2.47.1


