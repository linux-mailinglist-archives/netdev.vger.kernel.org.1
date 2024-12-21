Return-Path: <netdev+bounces-153919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C839FA105
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 15:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94247166B79
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458471F4E4B;
	Sat, 21 Dec 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju2eQEDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E11F2C5D
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792253; cv=none; b=gDG4Jlf46i9Ngr0EUBQrxNRxoO5ts8CjLYRn0iOBrL2Y9d3DXTbpDRiUdy/JoNV0yOviLbpBtKejCUjUurmCtb3GW+F3Ja7TB+1Qm1y9wBwoiyfAcqini3sOQevISpgtN+FyPO+7qYnetCK0TXQokIAQtKkimLyyciCu4pjq9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792253; c=relaxed/simple;
	bh=f5j//xxzj5NG7f1I5TsQwnahRvJvaAhnjd/z+1rYzzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+Fvpert1YDf+muLlg7dhIb43hFHj0y/rT5sTzOVZnI4d+l/jaUZsTdKT79QccGQkE5KCmJCbuF/pf2SrLSpG5nElfXt0VKoz2OXl8YVRq3K7LaXAxdXLL9+Favjn9wb3Hwb3viHe4x4IWKbBtt+upRe4u6DFyiCoGJ5GC4sVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju2eQEDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5E27C4CED7;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734792252;
	bh=f5j//xxzj5NG7f1I5TsQwnahRvJvaAhnjd/z+1rYzzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ju2eQEDXRjRJs3N8jxLplizVXlHVPu8I4YsAsGjCs6kiwck6+EtXLyo8tThx8dhqd
	 KltAGMTsMvUTZLRg3ZX/teroLQ4150wEdATiqHitlfD7Lu05RqssJjR6+zLfTxOEd3
	 YKlJsiqmd7vZGnJaDwOyGxcifnxGnLGB/9r7ecxJf0XHm+/eKIveN5OE0c+ifgaB+J
	 413kKlZmIBkMfp0jnuKZtoSHucuWCSHpcH+YBq1LliJzBrbivU9VH6BU3fTNO8GvWt
	 fk7tfW8RlqXZfMXHRo3xQfwSz6tv30Q5eYAiNPi4jsMF4nyv0uD+/ExHcAj11mQO5j
	 I5gaSEw8E1qJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1CDE7718C;
	Sat, 21 Dec 2024 14:44:12 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 21 Dec 2024 15:43:36 +0100
Subject: [PATCH net-next v4 1/7] net: phy: Add swnode support to
 mdiobus_scan
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-tn9510-v3a-v4-1-dafff89ba7a7@gmx.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792250; l=1936;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=tjXgAqiIJ9J3+v8YrXDfNqVpQpUv8M+JKJWk7sw4eKE=;
 b=Nxy3yiP28V2iDTVXrY0w873bGEaZFUeM2NF7qs+ajuZeViAyywTj6jW8VQRUc679abIs/WUv5
 lHsSS9huVMoCPI0Di0iYZ41WVSpJ0ejT/Cydm+RUDSYsZ/2lpyOuv5h
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

This patch will allow to use a swnode/fwnode defined for a phy_device. The
MDIO bus (mii_bus) needs to contain nodes for the PHY devices, named
"ethernet-phy@i", with i being the MDIO address (0 .. PHY_MAX_ADDR - 1).

The fwnode is only attached to the phy_device if there isn't already an
fwnode attached.

fwnode_get_named_child_node will increase the usage counter of the fwnode.
However, no new code is needed to decrease the counter again, since this is
already implemented in the phy_device_release function.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
---
 drivers/net/phy/mdio_bus.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 7e2f10182c0cf37bef4cea1820863f047b5cb466..ede596c1a69d1b2b986e9eef51c3beb4a5fbc805 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -551,6 +551,8 @@ static int mdiobus_create_device(struct mii_bus *bus,
 static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
+	struct fwnode_handle *fwnode;
+	char node_name[16];
 	int err;
 
 	phydev = get_phy_device(bus, addr, c45);
@@ -562,6 +564,18 @@ static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 	 */
 	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
 
+	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
+	 * If there is no swnode for the phy provided, just ignore it.
+	 */
+	if (dev_fwnode(&bus->dev) && !dev_fwnode(&phydev->mdio.dev)) {
+		snprintf(node_name, sizeof(node_name), "ethernet-phy@%d",
+			 addr);
+		fwnode = fwnode_get_named_child_node(dev_fwnode(&bus->dev),
+						     node_name);
+		if (fwnode)
+			device_set_node(&phydev->mdio.dev, fwnode);
+	}
+
 	err = phy_device_register(phydev);
 	if (err) {
 		phy_device_free(phydev);

-- 
2.45.2



