Return-Path: <netdev+bounces-67033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3227B841E54
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55471F23412
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1C56B9E;
	Tue, 30 Jan 2024 08:49:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D75647A
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604573; cv=none; b=olg99dubFAlyUi+ZglqwFwxcT2XtRBcfcbSorXoIggxPjhDeyKbeOEi7DrCv5C28s5ZhPVA3ytZFC9XbKNNue9Mbis6Ss27EG5ZdIQcmnXwANg3cojY6z0OvwNyE7gwbKCUYmlezfaOxCCKxCLLvwk3zaZPB9fG+p/QrFA+3/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604573; c=relaxed/simple;
	bh=8FesrihCJKd9Vt49xxsvmiQ37tGwV+IsZsA8YnOnRiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVTv1gETrVqaGDHrUcVkm7VZNCWaM465ooMJBeHW/uZSVSmS8vU25A566hVBN1Go3w+5LtFpYxAeYOMkWxyfgoIasjbwlPgI+/+duvaqk98YrNaC5pY9yCyxT5WrOyOtonsWZ5seLxtflxZjcgwsCWDV/q4NH6nY796uWm/WCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.150])
	by gateway (Coremail) with SMTP id _____8CxG+kYuLhlbUUIAA--.6858S3;
	Tue, 30 Jan 2024 16:49:28 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.150])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx8OQWuLhlRLEnAA--.24196S2;
	Tue, 30 Jan 2024 16:49:26 +0800 (CST)
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
Subject: [PATCH net-next v8 09/11] net: stmmac: dwmac-loongson: Fix half duplex
Date: Tue, 30 Jan 2024 16:49:14 +0800
Message-Id: <3382be108772ce56fe3e9bb99c9c53b7e9cd6bad.1706601050.git.siyanteng@loongson.cn>
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
X-CM-TRANSID:AQAAf8Bx8OQWuLhlRLEnAA--.24196S2
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFW8Wr15WFyfWF4ktrWkuFX_yoW5JF43pw
	srAa4j934Utr1xJa1kCw4DZFy5Wa4UKrWUuF4Iy3ySga92k3s0qryqqFWUAr9rurZ5WFya
	qr4qkr1UCFn8GwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNeODUUUU

Current GNET does not support half duplex mode.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 ++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |  3 ++-
 include/linux/stmmac.h                               |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 264c4c198d5a..1753a3c46b77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -432,8 +432,17 @@ static int loongson_gnet_config(struct pci_dev *pdev,
 				struct stmmac_resources *res,
 				struct device_node *np)
 {
-	if (pdev->revision == 0x00 || pdev->revision == 0x01)
+	switch (pdev->revision) {
+	case 0x00:
+		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000 |
+			       STMMAC_FLAG_DISABLE_HALF_DUPLEX;
+		break;
+	case 0x01:
 		plat->flags |= STMMAC_FLAG_DISABLE_FORCE_1000;
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5617b40abbe4..3aa862269eb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1201,7 +1201,8 @@ static int stmmac_init_phy(struct net_device *dev)
 static void stmmac_set_half_duplex(struct stmmac_priv *priv)
 {
 	/* Half-Duplex can only work with single tx queue */
-	if (priv->plat->tx_queues_to_use > 1)
+	if (priv->plat->tx_queues_to_use > 1 ||
+	    (STMMAC_FLAG_DISABLE_HALF_DUPLEX & priv->plat->flags))
 		priv->phylink_config.mac_capabilities &=
 			~(MAC_10HD | MAC_100HD | MAC_1000HD);
 	else
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 2810361e4048..197f6f914104 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -222,6 +222,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
 #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
+#define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


