Return-Path: <netdev+bounces-244746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38616CBDF1F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F9913072AFA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667112C2363;
	Mon, 15 Dec 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DxZVX2jl"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB728D850;
	Mon, 15 Dec 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803600; cv=none; b=ISowDzhamX00a8iLtqjSGSszPXsJsfQmcuer+cFkrx4O4kGkYabZ2nluaCI7AOe744aOQwl1vPSILvJ2/aFgLu1HBfwDkrtrqZQW1QgNcL8Yir+mFs/Q7gmbL98d1cx1gHTaYEJtDtcO73CpLPrlkFFKA9/VwSgymUFsjBTcnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803600; c=relaxed/simple;
	bh=8sIdV1vSPUwp0OuguQeVcd+qoz7KzJoL8HsTzLVh7EI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyVlhO98pVS+hQWG1TyqON5NSIPos4x66e3z8cvvIzhXs41YM9WQkuPwpHJl8kLubuxtSUlVsXL66O3iIx/S3n9EDEzg80rbZ0jjbUpi1aC6jzGAmfiYdrPABNdlGX1RaegVvCQo/MCzHfaOpe+qfQJwGSntPj1N53GFi4KlkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DxZVX2jl; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5U6BHLA8ULqFPpbl15/Pen372oWN+BOp1QgNe1s7QOQ=;
	b=DxZVX2jlI92jmiO9UDFckb4GThu0dO3LrPm+6lMGvvbPvUwKBZvDTzY57h+sZ5lN75BZXPF34
	zj4f/HD1fw20eS1gTMm5aJXHARvbuv2ydcq4F60/P5B27HqC3rX0mUvYThTXfKtAUiapPIqZ+BF
	nHz4e1FlstWjlZXeHI+Pp8U=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dVKpl1j5cz12LDf;
	Mon, 15 Dec 2025 20:57:35 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 08D6E140133;
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
Subject: [PATCH RFC net-next 3/6] net: hibmcge: create a software node for phy_led
Date: Mon, 15 Dec 2025 20:57:02 +0800
Message-ID: <20251215125705.1567527-4-shaojijie@huawei.com>
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

Currently, phy_led supports of node, acpi node, and software node.
The hibmcge hardware(including leds) is on the BMC side, while
the driver runs on the host side.

An apic or of node needs to be created on the host side to
support phy_led; otherwise, phy_led will not be supported.

Therefore, in order to support phy_led, this patch will create
a software node when it detects that the phy device is not
bound to any fwnode.

Closes: https://lore.kernel.org/all/023a85e4-87e2-4bd3-9727-69a2bfdc4145@lunn.ch/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  11 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 120 +++++++++++++++++-
 2 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 8e134da3e217..d20dd324e129 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -5,8 +5,10 @@
 #define __HBG_COMMON_H
 
 #include <linux/ethtool.h>
+#include <linux/fwnode.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/property.h>
 #include <net/page_pool/helpers.h>
 #include "hbg_reg.h"
 
@@ -130,6 +132,9 @@ struct hbg_vector {
 	u32 info_array_len;
 };
 
+#define HBG_LED_MAX_NUM			(sizeof(u32) / sizeof(u8))
+#define HBG_LED_SOFTWARE_NODE_MAX_NUM	(HBG_LED_MAX_NUM + 2)
+
 struct hbg_mac {
 	struct mii_bus *mdio_bus;
 	struct phy_device *phydev;
@@ -140,6 +145,12 @@ struct hbg_mac {
 	u32 autoneg;
 	u32 link_status;
 	u32 pause_autoneg;
+
+	struct software_node phy_node;
+	struct software_node leds_node;
+	struct software_node led_nodes[HBG_LED_MAX_NUM];
+	struct property_entry leds_props[HBG_LED_MAX_NUM][4];
+	const struct software_node *nodes[HBG_LED_SOFTWARE_NODE_MAX_NUM + 1];
 };
 
 struct hbg_mac_table_entry {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index b6f0a2780ea8..edd8ccefbb62 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -263,11 +263,119 @@ static int hbg_fixed_phy_init(struct hbg_priv *priv)
 	return hbg_phy_connect(priv);
 }
 
-int hbg_mdio_init(struct hbg_priv *priv)
+static void hbg_phy_device_free(void *data)
+{
+	phy_device_free((struct phy_device *)data);
+}
+
+static void hbg_phy_device_remove(void *data)
+{
+	phy_device_remove((struct phy_device *)data);
+}
+
+static void hbg_software_node_unregister_group(void *data)
+{
+	const struct software_node **node = data;
+
+	software_node_unregister_node_group(node);
+}
+
+static void hbg_device_remove_software_node(void *data)
+{
+	device_remove_software_node((struct device *)data);
+}
+
+static int hbg_register_phy_leds_software_node(struct hbg_priv *priv,
+					       struct phy_device *phydev)
 {
+	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
 	struct device *dev = &priv->pdev->dev;
 	struct hbg_mac *mac = &priv->mac;
+	u32 node_index = 0, i;
+	const char *label;
+	int ret;
+
+	if (fwnode) {
+		dev_dbg(dev, "phy fwnode is already exists\n");
+		return 0;
+	}
+
+	mac->phy_node.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s-%u",
+					    "mii", dev_name(dev),
+					    mac->phy_addr);
+	mac->nodes[node_index++] = &mac->phy_node;
+
+	mac->leds_node.name = devm_kasprintf(dev, GFP_KERNEL, "leds");
+	mac->leds_node.parent = &mac->phy_node;
+	mac->nodes[node_index++] = &mac->leds_node;
+
+	for (i = 0; i < HBG_LED_MAX_NUM; i++) {
+		mac->leds_props[i][0] = PROPERTY_ENTRY_U32("reg", i);
+		label = devm_kasprintf(dev, GFP_KERNEL, "%u", i);
+		mac->leds_props[i][1] = PROPERTY_ENTRY_STRING("label", label);
+
+		mac->led_nodes[i].name = devm_kasprintf(dev, GFP_KERNEL,
+							"led@%u", i);
+		mac->led_nodes[i].properties = mac->leds_props[i];
+		mac->led_nodes[i].parent = &mac->leds_node;
+
+		mac->nodes[node_index++] = &mac->led_nodes[i];
+	}
+
+	ret = software_node_register_node_group(mac->nodes);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register software node\n");
+
+	ret = devm_add_action_or_reset(dev, hbg_software_node_unregister_group,
+				       mac->nodes);
+	if (ret)
+		return ret;
+
+	ret = device_add_software_node(&phydev->mdio.dev, &mac->phy_node);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add software node\n");
+
+	return devm_add_action_or_reset(dev, hbg_device_remove_software_node,
+					&phydev->mdio.dev);
+}
+
+static int hbg_find_phy_device(struct hbg_priv *priv, struct mii_bus *mdio_bus)
+{
+	struct device *dev = &priv->pdev->dev;
 	struct phy_device *phydev;
+	int ret;
+
+	phydev = get_phy_device(mdio_bus, priv->mac.phy_addr, false);
+	if (IS_ERR(phydev))
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get phy device\n");
+
+	ret = devm_add_action_or_reset(dev, hbg_phy_device_free, phydev);
+	if (ret)
+		return ret;
+
+	ret = hbg_register_phy_leds_software_node(priv, phydev);
+	if (ret)
+		return ret;
+
+	ret = phy_device_register(phydev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register phy device\n");
+
+	ret = devm_add_action_or_reset(dev, hbg_phy_device_remove, phydev);
+	if (ret)
+		return ret;
+
+	priv->mac.phydev = phydev;
+	return 0;
+}
+
+int hbg_mdio_init(struct hbg_priv *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct hbg_mac *mac = &priv->mac;
 	struct mii_bus *mdio_bus;
 	int ret;
 
@@ -281,7 +389,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
 
 	mdio_bus->parent = dev;
 	mdio_bus->priv = priv;
-	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
+	mdio_bus->phy_mask = 0xFFFFFFFF; /* not scan phy device */
 	mdio_bus->name = "hibmcge mii bus";
 	mac->mdio_bus = mdio_bus;
 
@@ -293,12 +401,10 @@ int hbg_mdio_init(struct hbg_priv *priv)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
 
-	phydev = mdiobus_get_phy(mdio_bus, mac->phy_addr);
-	if (!phydev)
-		return dev_err_probe(dev, -ENODEV,
-				     "failed to get phy device\n");
+	ret = hbg_find_phy_device(priv, mdio_bus);
+	if (ret)
+		return ret;
 
-	mac->phydev = phydev;
 	hbg_mdio_init_hw(priv);
 	return hbg_phy_connect(priv);
 }
-- 
2.33.0


