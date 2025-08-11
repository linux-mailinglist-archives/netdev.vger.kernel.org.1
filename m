Return-Path: <netdev+bounces-212410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B4B2006C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975B87AAE28
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFF2DAFC6;
	Mon, 11 Aug 2025 07:35:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04BC2D9EC7;
	Mon, 11 Aug 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897734; cv=none; b=iN2YrYsLdec7/VmKrIuScVo/EWBzbkuvOZbtij7BQTkKNNm9F0gOXVo6fSpwzR/sww6klkspGQ0sDOq3KbBF+qa52/wF5TZw2sce3TIDPloUzmYRTlBS6LleAwYnSGbO1/KdA0RHQSUOsgYMU8du3QaqRPGXLoHbnlwMuyCKwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897734; c=relaxed/simple;
	bh=9acX92L9C+8DrWyx0+RWywSPvOducwWYPw9SAAVNwos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8d8SYzkajM8gOn+iY1mo6tPKlNLgQ8l4jFJ1D3dM/4e+Jk+QQpeA2EsqMS+ymxPMqWgMZc96M6m76fQzAMtyWNjMHhhw0Ti6BQ/vuzpN+wz2oQs/rvlDYf3yM6L/gkw6Bq45FD9Dd/L9gS0sJNx7+VitIkkUHDbFiH30hZTdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxlnA9nZloJ1Q+AQ--.51947S3;
	Mon, 11 Aug 2025 15:35:25 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxdOQqnZloCJ9CAA--.53284S4;
	Mon, 11 Aug 2025 15:35:19 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/3] net: stmmac: Change first parameter of fix_soc_reset()
Date: Mon, 11 Aug 2025 15:35:05 +0800
Message-ID: <20250811073506.27513-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250811073506.27513-1-yangtiezhu@loongson.cn>
References: <20250811073506.27513-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxdOQqnZloCJ9CAA--.53284S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw4DJFy8Cr1DKrW3tw17XFc_yoWrGF15pF
	WUZa429r97trySqan5Jr4UZFyYva4fKFW0gF4xJwsa9a1akr90qrn0gFWYyr12kF45WF1a
	yr4UCw1UuF1qyrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jr6p9UUUUU=

In order to use netdev_err() to print message in the callback function of
fix_soc_reset(), change fix_soc_reset() to have "struct stmmac_priv *" as
its first parameter.

This is preparation for later patch, no functionality change.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c      | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c           | 2 +-
 include/linux/stmmac.h                               | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 889e2bb6f7f5..c2d9e89f0063 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -49,7 +49,7 @@ struct imx_dwmac_ops {
 	u32 flags;
 	bool mac_rgmii_txclk_auto_adj;
 
-	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
+	int (*fix_soc_reset)(struct stmmac_priv *priv, void __iomem *ioaddr);
 	int (*set_intf_mode)(struct plat_stmmacenet_data *plat_dat);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
 };
@@ -265,9 +265,9 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
 }
 
-static int imx_dwmac_mx93_reset(void *priv, void __iomem *ioaddr)
+static int imx_dwmac_mx93_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 {
-	struct plat_stmmacenet_data *plat_dat = priv;
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 
 	/* DMA SW reset */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index e1591e6217d4..bb376c69016d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -509,7 +509,7 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 }
 
 /* Loongson's DWMAC device may take nearly two seconds to complete DMA reset */
-static int loongson_dwmac_fix_reset(void *priv, void __iomem *ioaddr)
+static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 {
 	u32 value = readl(ioaddr + DMA_BUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 99635b37044a..3f7c765dcb79 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -100,7 +100,7 @@ int stmmac_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
 		return -EINVAL;
 
 	if (plat && plat->fix_soc_reset)
-		return plat->fix_soc_reset(plat, ioaddr);
+		return plat->fix_soc_reset(priv, ioaddr);
 
 	return stmmac_do_callback(priv, dma, reset, ioaddr);
 }
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 26ddf95d23f9..330694641a95 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -238,7 +238,7 @@ struct plat_stmmacenet_data {
 	int (*set_clk_tx_rate)(void *priv, struct clk *clk_tx_i,
 			       phy_interface_t interface, int speed);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
-	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
+	int (*fix_soc_reset)(struct stmmac_priv *priv, void __iomem *ioaddr);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	int (*mac_finish)(struct net_device *ndev,
-- 
2.42.0


