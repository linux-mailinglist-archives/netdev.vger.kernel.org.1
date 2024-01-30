Return-Path: <netdev+bounces-67029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C5841E4E
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B61F21123
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F756B98;
	Tue, 30 Jan 2024 08:48:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A811E56745
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604518; cv=none; b=MWaVhnz3OMupEubEZfsrO+SwrU4S5J13WKNQtaf5tJbl04rGpUHNLzgBDgM2QpLOY1TMBUMckqeXp7RWo24zmEipHwrCNg+QoKjx8CnJS3SCnWvpe6a7dvr69hXig9BCO/LjHLyVS5SLyla++XJhGEI1b9kVgJeW9pE/5AZUw+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604518; c=relaxed/simple;
	bh=f/+sgN/0kWTw/omdssRSkWTxNF/vP3eGAfhujUTKEKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOSKsBB3WycPAHPiJ4lObNr1IjPTzNczgbU7+FII12SMgbrLPDFcMNU0gIF2hR9YTb+41brJhJlfsfG/XjWW0Q3HZeFtbhze9egXFW3/SgDAQGoXj/5m4NZ8I8XUqpZ8Jg1Wat4dozb8JWavLTEn5gFln3X61Z35yQt+FLoQ3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8BxSOjjt7hlVEUIAA--.6017S3;
	Tue, 30 Jan 2024 16:48:35 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrhPet7hl0bAnAA--.34545S5;
	Tue, 30 Jan 2024 16:48:34 +0800 (CST)
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
Subject: [PATCH net-next v8 08/11] net: stmmac: dwmac-loongson: Fix MAC speed for GNET
Date: Tue, 30 Jan 2024 16:48:20 +0800
Message-Id: <e3c83d1e62cd67d5f3b50b30f46c232a307504ab.1706601050.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8CxrhPet7hl0bAnAA--.34545S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fGF45JrWfGrW7Zr4UKFX_yoW5ur4rpa
	17Aa4UuryUtr17Gan5Aw4UZFy5K3y7Krs7Wa9Fyw4a9FZFy3saqryYgFWUAFy7urZ8uFWa
	qr4qkr1UuFn8C3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r4j6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Wrv_ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
	wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07URyIUUUUUU=

Current GNET on LS7A only supports ANE when speed is
set to 1000M.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 19 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  6 ++++++
 include/linux/stmmac.h                        |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 60d0a122d7c9..264c4c198d5a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -344,6 +344,21 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
 	.config = loongson_gmac_config,
 };
 
+static void loongson_gnet_fix_speed(void *priv, unsigned int speed, unsigned int mode)
+{
+	struct loongson_data *ld = (struct loongson_data *)priv;
+	struct net_device *ndev = dev_get_drvdata(ld->dev);
+	struct stmmac_priv *ptr = netdev_priv(ndev);
+
+	/* The controller and PHY don't work well together.
+	 * We need to use the PS bit to check if the controller's status
+	 * is correct and reset PHY if necessary.
+	 */
+	if (speed == SPEED_1000)
+		if (readl(ptr->ioaddr + MAC_CTRL_REG) & (1 << 15) /* PS */)
+			phy_restart_aneg(ndev->phydev);
+}
+
 static struct mac_device_info *loongson_setup(void *apriv)
 {
 	struct stmmac_priv *priv = apriv;
@@ -401,6 +416,7 @@ static int loongson_gnet_data(struct pci_dev *pdev,
 	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
 
 	plat->bsp_priv = &pdev->dev;
+	plat->fix_mac_speed = loongson_gnet_fix_speed;
 
 	plat->dma_cfg->pbl = 32;
 	plat->dma_cfg->pblx8 = true;
@@ -416,6 +432,9 @@ static int loongson_gnet_config(struct pci_dev *pdev,
 				struct stmmac_resources *res,
 				struct device_node *np)
 {
+	if (pdev->revision == 0x00 || pdev->revision == 0x01)
+		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 42d27b97dd1d..31068fbc23c9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 		return 0;
 	}
 
+	if (FIELD_GET(STMMAC_FLAG_DISABLE_FORCE_1000, priv->plat->flags)) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg != AUTONEG_ENABLE)
+			return -EOPNOTSUPP;
+	}
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index dee5ad6e48c5..2810361e4048 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -221,6 +221,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
+#define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


