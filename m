Return-Path: <netdev+bounces-152717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FEE9F5876
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4DC188311A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65741FBC91;
	Tue, 17 Dec 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWPFSSi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD81FA8ED
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469659; cv=none; b=T6jaL+Y/0AG9HzNvIoBtOYE/n+unzzo4HL3IB+JW5tXXmP0miyKhcLj8AeHP9X9upd6+c4reOOIzOovu9Lg50DbBxFOFcD3ZD2BfMO7MzO31aPfGqi+kOISc9OE3TQjt0IU5623fXQeoWO4xQC7btGGcyNp/Hk1CD0HGWiVwes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469659; c=relaxed/simple;
	bh=42JKCHWtedKZlqoaUUebXcvrkGtOYC5SOgvvlMD/lEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMB2Xx8fJ6BsQ0Op3J/V1Oi8/+Ef7bMbu4nZ3QsrbUb/SPm+78D1Ewifk5ahQZr10QuHnAalcWEouWlYD3lUOdAagOz0QIb9CsuisD1QwZzsYfelBKNXfiGly3vyKvhRmJF847GjKNf/4bnpHE8Fy+3wNB7x6S5ekSIY0otUOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWPFSSi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18E94C4CEE4;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469659;
	bh=42JKCHWtedKZlqoaUUebXcvrkGtOYC5SOgvvlMD/lEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZWPFSSi2gHJcShkOJk5Bs8DpYWRUqPZcDb/JxymDwHlUH6P3cHbT/tH033qh5d89Z
	 rm7KgHRY7lBfYV/Cj/Omav3S6DNJl84RdOzrFJIyAutSf8FJUNCFlMp4XB6grEA/hf
	 pl1HqRNoQySf4Zuw0OU6PtsbqUf9ahZCTfKJmDnkYZWkww9H5JXxHTv04TB4XNxtuZ
	 wsPv5r+tcNrEPVMmvAg2Ea/Iboe8TagfooRtX7zJxf0mnqQv44PPXu+GsBARD1iApc
	 FgdxXGKELVmlpDq7BZXsu+QPl6ggvfyB9Dxf3MYEJOs74SoVRLCwZp5MCDk3uTq/GS
	 eXueLYC9zIH/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE1E77187;
	Tue, 17 Dec 2024 21:07:39 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 17 Dec 2024 22:07:36 +0100
Subject: [PATCH net-next v3 5/7] net: tn40xx: create software node for mdio
 and phy and add to mdiobus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
In-Reply-To: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734469657; l=6540;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=4/i6FVXGucUwDy2wgJmhDqtqKtov9plpSkkW58Fze9g=;
 b=qn3exb0jZcNvSWhlvYozCRMmqJVVvh+BNFccMYoK8MeOuRuwWQiqdTxC/ejAE45BB36zGlaJI
 KiDqynHhR8IAS5xZfl+6yGU54+u3tR1UuZZxQG/AFaQtMcY9Gb1qTVh
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Create a software node for the mdio function, with a child node for the
Aquantia AQR105 PHY, providing a firmware-name (and a bit more, which may
be used for future checks) to allow the PHY to load a MAC specific
firmware from the file system.

The name of the PHY software node follows the naming convention suggested
in the patch for the mdiobus_scan function (in the same patch series).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/tn40.c      | 10 ++++-
 drivers/net/ethernet/tehuti/tn40.h      | 30 +++++++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c | 65 ++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 259bdac24cf211113b8f80934feb093d61e46f2d..5f73eb1f7d9f74294cd5546c2ef4797ebc24c052 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1778,7 +1778,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = tn40_phy_register(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set up PHY.\n");
-		goto err_free_irq;
+		goto err_unregister_swnodes;
 	}
 
 	ret = tn40_priv_init(priv);
@@ -1795,6 +1795,10 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 err_unregister_phydev:
 	tn40_phy_unregister(priv);
+err_unregister_swnodes:
+	fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1816,6 +1820,10 @@ static void tn40_remove(struct pci_dev *pdev)
 	unregister_netdev(ndev);
 
 	tn40_phy_unregister(priv);
+	/* cleanup software nodes */
+	fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+	device_remove_software_node(&priv->mdio->dev);
+	software_node_unregister_node_group(priv->nodes.group);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 490781fe512053d0d2cf0d6e819fc11d078a6733..e083f34f29849186a5ea68ed710a96ba9def116e 100644
--- a/drivers/net/ethernet/tehuti/tn40.h
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -4,6 +4,7 @@
 #ifndef _TN40_H_
 #define _TN40_H_
 
+#include <linux/property.h>
 #include "tn40_regs.h"
 
 #define TN40_DRV_NAME "tn40xx"
@@ -102,10 +103,39 @@ struct tn40_txdb {
 	int size; /* Number of elements in the db */
 };
 
+#define NODE_PROP(_NAME, _PROP)	(		\
+	(const struct software_node) {		\
+		.name = _NAME,			\
+		.properties = _PROP,		\
+	})
+
+#define NODE_PAR_PROP(_NAME, _PAR, _PROP)	(	\
+	(const struct software_node) {		\
+		.name = _NAME,			\
+		.parent = _PAR,			\
+		.properties = _PROP,		\
+	})
+
+enum tn40_swnodes {
+	SWNODE_MDIO,
+	SWNODE_PHY,
+	SWNODE_MAX
+};
+
+struct tn40_nodes {
+	char phy_name[32];
+	char mdio_name[32];
+	struct property_entry phy_props[3];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct tn40_priv {
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 
+	struct tn40_nodes nodes;
+
 	struct napi_struct napi;
 	/* RX FIFOs: 1 for data (full) descs, and 2 for free descs */
 	struct tn40_rxd_fifo rxd_fifo0;
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index af18615d64a8a290c7f79e56260b9aacf82c0386..b8ee553f60d1beadeda828584adfea670f0d4ca8 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -14,6 +14,8 @@
 	 (FIELD_PREP(TN40_MDIO_PRTAD_MASK, (port))))
 #define TN40_MDIO_CMD_READ BIT(15)
 
+#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
+
 static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
 {
 	void __iomem *regs = priv->regs;
@@ -111,6 +113,46 @@ static int tn40_mdio_write_c45(struct mii_bus *mii_bus, int addr, int devnum,
 	return  tn40_mdio_write(mii_bus->priv, addr, devnum, regnum, val);
 }
 
+/* registers an mdio node and an aqr105 PHY at address 1
+ * tn40_mdio-%id {
+ *	ethernet-phy@1 {
+ *		compatible = "ethernet-phy-id03a1.b4a3";
+ *		reg = <1>;
+ *		firmware-name = AQR105_FIRMWARE;
+ *	};
+ * };
+ */
+static int tn40_swnodes_register(struct tn40_priv *priv)
+{
+	struct tn40_nodes *nodes = &priv->nodes;
+	struct pci_dev *pdev = priv->pdev;
+	struct software_node *swnodes;
+	u32 id;
+
+	id = pci_dev_id(pdev);
+
+	snprintf(nodes->phy_name, sizeof(nodes->phy_name), "ethernet-phy@1");
+	snprintf(nodes->mdio_name, sizeof(nodes->mdio_name), "tn40_mdio-%x",
+		 id);
+
+	swnodes = nodes->swnodes;
+
+	swnodes[SWNODE_MDIO] = NODE_PROP(nodes->mdio_name, NULL);
+
+	nodes->phy_props[0] = PROPERTY_ENTRY_STRING("compatible",
+						    "ethernet-phy-id03a1.b4a3");
+	nodes->phy_props[1] = PROPERTY_ENTRY_U32("reg", 1);
+	nodes->phy_props[2] = PROPERTY_ENTRY_STRING("firmware-name",
+						    AQR105_FIRMWARE);
+	swnodes[SWNODE_PHY] = NODE_PAR_PROP(nodes->phy_name,
+					    &swnodes[SWNODE_MDIO],
+					    nodes->phy_props);
+
+	nodes->group[SWNODE_PHY] = &swnodes[SWNODE_PHY];
+	nodes->group[SWNODE_MDIO] = &swnodes[SWNODE_MDIO];
+	return software_node_register_node_group(nodes->group);
+}
+
 int tn40_mdiobus_init(struct tn40_priv *priv)
 {
 	struct pci_dev *pdev = priv->pdev;
@@ -130,13 +172,34 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 	bus->read_c45 = tn40_mdio_read_c45;
 	bus->write_c45 = tn40_mdio_write_c45;
 
+	ret = tn40_swnodes_register(priv);
+	if (ret) {
+		pr_err("swnodes failed\n");
+		return ret;
+	}
+
+	ret = device_add_software_node(&bus->dev,
+				       priv->nodes.group[SWNODE_MDIO]);
+	if (ret) {
+		dev_err(&pdev->dev, "device_add_software_node failed: %d\n",
+			ret);
+	}
+
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
-		return ret;
+		goto err_swnodes_unregister;
 	}
 	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	priv->mdio = bus;
 	return 0;
+
+err_swnodes_unregister:
+	fwnode_handle_put(dev_fwnode(&bus->dev));
+	device_remove_software_node(&bus->dev);
+	software_node_unregister_node_group(priv->nodes.group);
+	return ret;
 }
+
+MODULE_FIRMWARE(AQR105_FIRMWARE);

-- 
2.45.2



