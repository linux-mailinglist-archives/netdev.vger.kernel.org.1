Return-Path: <netdev+bounces-153925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551D9FA10A
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E588166D39
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45811FCCEB;
	Sat, 21 Dec 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVi4NrO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAC1F8ACC
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=hTmITQYOIFNCreklDlSkrRhwFbEzzlWLB6CtP7itxisAIK80H7xBDK1Cql1Xoplfaw+AyZjZAAHFR9E4WY/lY1kwND6MdrQpuzL7eh4vf0bk0S55zk05UiKTOJ7emP0DeHMAGF3VCHhS6Da/a3r08gM9LoTfgVjoQJJLIAQ8usA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=tdld23lvZrbx5W6t9sDae8Spa9X9I3Jmr3eAm//J50I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDltnz1MPVonMookWXp2Lr2DF9s2aH4+JhhM1VJeL/8Q/3Cv+QYtmnJvU8vf30Xw27znN/nRIjzJlomWh4JUGcRS6znhU5jMj7IWkSi1mJekCPIwSLgIq7ffS/VyKz6/pCbwUXvQZKJT1tmiFfCiHtVssnIpNENjmYvaMoaD4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVi4NrO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7B06C4CEE3;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792252;
	bh=tdld23lvZrbx5W6t9sDae8Spa9X9I3Jmr3eAm//J50I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZVi4NrO4096hb8t9LMQ+NQAh+Abtwm2pKDyEwQmujcyy4upMCik82anFelJJ/FWQp
	 7JrH9EytgIsQX3v02m8q11XVhYxgk1czRnNCP9RnOqO46OkM4yevOinJ6M/TBj97+m
	 m1kRKT0Uf0L5mvTHDP/hBk5V07OlPuduJI4UXGIzu6BVlJEPmxuAgajrfDONSUk9pP
	 PV4SIMbVPdHBDZdd3dX3u9rUKlgJleHLFjDJp0q1zlQiPF4sSOpexNrWdpZ9HTJXAr
	 9fEULHnPqvT8KvjEFu9Fm4P1mEcRta/bfWMq14zY7cUoG+TU+BLnyoQoLa7ZmVDNwT
	 HU0g9pXzRHtxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF482E7718B;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 21 Dec 2024 15:43:40 +0100
Subject: [PATCH net-next v4 5/7] net: tn40xx: create swnode for mdio and
 aqr105 phy and add to mdiobus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-tn9510-v3a-v4-5-dafff89ba7a7@gmx.net>
References: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
In-Reply-To: <20241221-tn9510-v3a-v4-0-dafff89ba7a7@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=6934;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=dHfEHVd8crq3Lw2PNmXJetwJqM2qaxgF4hfA/5naVOc=;
 b=Dy8X/Wwpzq65zZwk16ZajqwwYUZdImV1pnQ1rUBRCQNwz2wW1wuBzfpSk2FtB/M6EeZWG354u
 t8lZK6RtZ8kBxdqOBDAd9z1iySE+i4+jMft65AG9cBKliCnoEMmgpit
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

In case of an AQR105-based device, create a software node for the mdio
function, with a child node for the Aquantia AQR105 PHY, providing a
firmware-name (and a bit more, which may be used for future checks) to
allow the PHY to load a MAC specific firmware from the file system.

The name of the PHY software node follows the naming convention suggested
in the patch for the mdiobus_scan function (in the same patch series).

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/ethernet/tehuti/tn40.c      |  5 ++-
 drivers/net/ethernet/tehuti/tn40.h      | 31 +++++++++++++
 drivers/net/ethernet/tehuti/tn40_mdio.c | 78 ++++++++++++++++++++++++++++++++-
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 259bdac24cf211113b8f80934feb093d61e46f2d..a4dd04fc6d89e7f7efd77145a5dd883884b30c4b 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1778,7 +1778,7 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ret = tn40_phy_register(priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set up PHY.\n");
-		goto err_free_irq;
+		goto err_cleanup_swnodes;
 	}
 
 	ret = tn40_priv_init(priv);
@@ -1795,6 +1795,8 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 err_unregister_phydev:
 	tn40_phy_unregister(priv);
+err_cleanup_swnodes:
+	tn40_swnodes_cleanup(priv);
 err_free_irq:
 	pci_free_irq_vectors(pdev);
 err_unset_drvdata:
@@ -1816,6 +1818,7 @@ static void tn40_remove(struct pci_dev *pdev)
 	unregister_netdev(ndev);
 
 	tn40_phy_unregister(priv);
+	tn40_swnodes_cleanup(priv);
 	pci_free_irq_vectors(priv->pdev);
 	pci_set_drvdata(pdev, NULL);
 	iounmap(priv->regs);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
index 490781fe512053d0d2cf0d6e819fc11d078a6733..ac48c1dc555480ccea41b6815bcfafb150b0a47c 100644
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
@@ -225,6 +255,7 @@ static inline void tn40_write_reg(struct tn40_priv *priv, u32 reg, u32 val)
 
 int tn40_set_link_speed(struct tn40_priv *priv, u32 speed);
 
+void tn40_swnodes_cleanup(struct tn40_priv *priv);
 int tn40_mdiobus_init(struct tn40_priv *priv);
 
 int tn40_phy_register(struct tn40_priv *priv);
diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index af18615d64a8a290c7f79e56260b9aacf82c0386..3607ffcb2ee54e70009fdde0d59d27a9b8a88b6a 100644
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
@@ -111,6 +113,56 @@ static int tn40_mdio_write_c45(struct mii_bus *mii_bus, int addr, int devnum,
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
+void tn40_swnodes_cleanup(struct tn40_priv *priv)
+{
+	/* cleanup of swnodes is only needed for AQR105-based cards */
+	if (priv->pdev->device == 0x4025) {
+		fwnode_handle_put(dev_fwnode(&priv->mdio->dev));
+		device_remove_software_node(&priv->mdio->dev);
+		software_node_unregister_node_group(priv->nodes.group);
+	}
+}
+
 int tn40_mdiobus_init(struct tn40_priv *priv)
 {
 	struct pci_dev *pdev = priv->pdev;
@@ -129,14 +181,36 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 
 	bus->read_c45 = tn40_mdio_read_c45;
 	bus->write_c45 = tn40_mdio_write_c45;
+	priv->mdio = bus;
+
+	/* provide swnodes for AQR105-based cards only */
+	if (pdev->device == 0x4025) {
+		ret = tn40_swnodes_register(priv);
+		if (ret) {
+			pr_err("swnodes failed\n");
+			return ret;
+		}
+
+		ret = device_add_software_node(&bus->dev,
+					       priv->nodes.group[SWNODE_MDIO]);
+		if (ret) {
+			dev_err(&pdev->dev, "device_add_software_node failed:"
+				" %d\n", ret);
+		}
+	}
 
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
-		return ret;
+		goto err_swnodes_cleanup;
 	}
 	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
-	priv->mdio = bus;
 	return 0;
+
+err_swnodes_cleanup:
+	tn40_swnodes_cleanup(priv);
+	return ret;
 }
+
+MODULE_FIRMWARE(AQR105_FIRMWARE);

-- 
2.45.2



