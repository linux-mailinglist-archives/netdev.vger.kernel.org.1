Return-Path: <netdev+bounces-244742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84040CBDF07
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC8D30034AA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179C2248A5;
	Mon, 15 Dec 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pRGCylMc"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB1C22126D;
	Mon, 15 Dec 2025 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803596; cv=none; b=ELM/IOtLQ0aHoS04/Gt4gKryWxKHT3QbNalIwwXHT9iTXCS829fiAfm5gsA0iF54rGdxKOX2rkkerRtDWtZlKl9lDUaalXqf8ZUC8Vyuku7hAFCCVjIDjL48V7f6ILSI1YQGzMUhoH1ddM4MiIXRhIEFG+Y8m6Ar+PUvPofmf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803596; c=relaxed/simple;
	bh=1oKKlliL80ez6J+gp81xQm3XIykbctCbR2t5Qs7tyIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rERlzoYX1jeHLzmmTs1SoBcc7Bm566bCHeiAxK48H/c6qjqyfNaAlMDwL3nU011t6URFuz92JzDfnQQ7jj3gDhIDU+Vm/ChGAKm9uvCwONNn6G1IrX0cL8dhAx5WWzUkmJ472zv6HGs5WnFJKwaOK5gFgEqsv0B8hRz7s+9zDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pRGCylMc; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=mVkdXmykPJNKJDJHkZAT5FNe3kKnBzb91qGf7nsJFis=;
	b=pRGCylMc7RWcziuCdeoKBR0VlAcxK8XHhECzmKU2N+pS4r6krle1Sb35PVKVWqt6vDliAsUvp
	7OvfOdrS9mwHgc2sa868mgDMJYs/6q3rK1MAL8JScTCFRRYCu/3t9tZhyqwdRdLEg1DhvEqQxZ+
	51R8RqpAM9IX0Dkr3OWYDeg=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dVKq44r2Zz1K968;
	Mon, 15 Dec 2025 20:57:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E60A1402C6;
	Mon, 15 Dec 2025 20:59:50 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 4/6] net: hibmcge: support get phy_leds_reg from spec register
Date: Mon, 15 Dec 2025 20:57:03 +0800
Message-ID: <20251215125705.1567527-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

support get phy_leds_reg from spec register,
and init the software node according to the value.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 12 ++++++++++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index edd8ccefbb62..fb6ece3935e7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -289,9 +289,11 @@ static int hbg_register_phy_leds_software_node(struct hbg_priv *priv,
 					       struct phy_device *phydev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
+	u32 phy_reg_num = hbg_reg_read(priv, HBG_REG_PHY_LEDS_REG);
 	struct device *dev = &priv->pdev->dev;
 	struct hbg_mac *mac = &priv->mac;
-	u32 node_index = 0, i;
+	u32 node_index = 0, i, reg;
+	unsigned long rules;
 	const char *label;
 	int ret;
 
@@ -310,12 +312,18 @@ static int hbg_register_phy_leds_software_node(struct hbg_priv *priv,
 	mac->nodes[node_index++] = &mac->leds_node;
 
 	for (i = 0; i < HBG_LED_MAX_NUM; i++) {
+		reg = (phy_reg_num >> (8 * i)) & 0xFF;
+
 		mac->leds_props[i][0] = PROPERTY_ENTRY_U32("reg", i);
 		label = devm_kasprintf(dev, GFP_KERNEL, "%u", i);
 		mac->leds_props[i][1] = PROPERTY_ENTRY_STRING("label", label);
 
+		rules = hbg_reg_read(priv,
+				     HBG_REG_PHY_LED0_RULES_ADDR + i * 4);
+		mac->leds_props[i][2] = PROPERTY_ENTRY_U32("rules", rules);
+
 		mac->led_nodes[i].name = devm_kasprintf(dev, GFP_KERNEL,
-							"led@%u", i);
+							"led@%u", reg);
 		mac->led_nodes[i].properties = mac->leds_props[i];
 		mac->led_nodes[i].parent = &mac->leds_node;
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 30b3903c8f2d..2ad7b60874c7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -12,12 +12,17 @@
 #define HBG_REG_MAC_ADDR_ADDR			0x0010
 #define HBG_REG_MAC_ADDR_HIGH_ADDR		0x0014
 #define HBG_REG_UC_MAC_NUM_ADDR			0x0018
+#define HBG_REG_PHY_LEDS_REG			0x0020
 #define HBG_REG_MDIO_FREQ_ADDR			0x0024
 #define HBG_REG_MAX_MTU_ADDR			0x0028
 #define HBG_REG_MIN_MTU_ADDR			0x002C
 #define HBG_REG_TX_FIFO_NUM_ADDR		0x0030
 #define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
 #define HBG_REG_VLAN_LAYERS_ADDR		0x0038
+#define HBG_REG_PHY_LED0_RULES_ADDR		0x003C
+#define HBG_REG_PHY_LED1_RULES_ADDR		0x0040
+#define HBG_REG_PHY_LED2_RULES_ADDR		0x0044
+#define HBG_REG_PHY_LED3_RULES_ADDR		0x0048
 #define HBG_REG_PUSH_REQ_ADDR			0x00F0
 #define HBG_REG_MSG_HEADER_ADDR			0x00F4
 #define HBG_REG_MSG_HEADER_OPCODE_M		GENMASK(7, 0)
-- 
2.33.0


