Return-Path: <netdev+bounces-182605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CFA8948D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD967A9669
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5952798F0;
	Tue, 15 Apr 2025 07:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF61A5BAC;
	Tue, 15 Apr 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701129; cv=none; b=jnzjMCuCU/PMBdmIQqv3a9ovg0V5LX5ZmCzxD39o6vi2BTprbnwvoSMWKnO+FGYao5yepydJEQS6O5oEM9Zx+eATM/KYJAs2mat5F3bs+GyhXje52i9FiddUKBTf1Z7reR71xLlREFQSv0/+W36P+j67btTcDsO4DTiqt3Fck0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701129; c=relaxed/simple;
	bh=KjRBHpnhNx2L2f4e+8bxxLFlyH6oMQahHuhznMztzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4l61t4Qq6AnUrMT2i0xM3RySpmr3K5VOsEHPWn2MStFWZr43enZJT2TQgwE/SGuv3rsBnyzkeNFSImwCVE2+/H82phU3Yi4nIkWJUbaaqA5ojl3Bs5Pi9mFL9l6r8kJsvM74wBvf/WbCnPOcbkzaIikInGVjD/OWyFBUnFUt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.238])
	by gateway (Coremail) with SMTP id _____8Bx32vEBv5n9Im9AA--.52625S3;
	Tue, 15 Apr 2025 15:12:04 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.238])
	by front1 (Coremail) with SMTP id qMiowMBxGcS1Bv5ni3SCAA--.35528S3;
	Tue, 15 Apr 2025 15:12:01 +0800 (CST)
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
	Biao Dong <dongbiao@loongson.cn>,
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Subject: [PATCH net-next 1/3] net: stmmac: dwmac-loongson: Move queue number init to common function
Date: Tue, 15 Apr 2025 15:11:26 +0800
Message-ID: <20250415071128.3774235-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415071128.3774235-1-chenhuacai@loongson.cn>
References: <20250415071128.3774235-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxGcS1Bv5ni3SCAA--.35528S3
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw4UCw4DtrW8WrWfZw1xCrX_yoW5Wr4xp3
	y3Aay7WrWftr9rKan8J3yUZry5ArWFqrZ2gFW2kw1fCFyqkw1qq34rKFWvkFZ7AFWDu3W3
	ZF4jkr4UWF1qkwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Currently, the tx and rx queue number initialization is duplicated in
loongson_gmac_data() and loongson_gnet_data(), so move it to the common
function loongson_default_data().

This is a preparation for later patches.

Tested-by: Biao Dong <dongbiao@loongson.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 39 +++++--------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 1a93787056a7..f5fdef56da2c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -83,6 +83,9 @@ struct stmmac_pci_info {
 static void loongson_default_data(struct pci_dev *pdev,
 				  struct plat_stmmacenet_data *plat)
 {
+	int i;
+	struct loongson_data *ld = plat->bsp_priv;
+
 	/* Get bus_id, this can be overwritten later */
 	plat->bus_id = pci_dev_id(pdev);
 
@@ -116,17 +119,6 @@ static void loongson_default_data(struct pci_dev *pdev,
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
-}
-
-static int loongson_gmac_data(struct pci_dev *pdev,
-			      struct plat_stmmacenet_data *plat)
-{
-	struct loongson_data *ld;
-	int i;
-
-	ld = plat->bsp_priv;
-
-	loongson_default_data(pdev, plat);
 
 	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN) {
 		plat->rx_queues_to_use = CHANNEL_NUM;
@@ -141,6 +133,12 @@ static int loongson_gmac_data(struct pci_dev *pdev,
 		plat->tx_queues_to_use = 1;
 		plat->rx_queues_to_use = 1;
 	}
+}
+
+static int loongson_gmac_data(struct pci_dev *pdev,
+			      struct plat_stmmacenet_data *plat)
+{
+	loongson_default_data(pdev, plat);
 
 	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
 
@@ -172,27 +170,8 @@ static void loongson_gnet_fix_speed(void *priv, int speed, unsigned int mode)
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


