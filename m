Return-Path: <netdev+bounces-168742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B46A40719
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76299189F884
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4F207A23;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt3uUksU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D929207657;
	Sat, 22 Feb 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217802; cv=none; b=Bejjj3hVswxetxT2SJ8//HC16TbxuXRgTZM9nGOnCSEl4tEcv+xVRqKDgvWg0fOcZQEgENN14+rDIuoSC6mkjUmWmq6oZM/GL1AGha4rEE31W5UKUD962tDgER/EbbfmpFr+h+SOgyHdFdc+grJ4Z/VsbDydtfiqDMLZFDqSHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217802; c=relaxed/simple;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soAhIqua6brDJliGz0yD0xcYQ73NypY8UV/kJxLfYUOkghpPiW2GXZBjF1IPd7+il/TFiNr11f71JtehP3JrgdQTRq5VQAhFz2yRdALO9ECYPAsa9IPjeO92cY4eakqINMALr8ThkDKC61lCavZtJCfvFBNXZYzIY9ev7uJU45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt3uUksU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E59B1C4CEE6;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217802;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mt3uUksUeKBOfSIAGNS91FWyk0j08UZfqLigUC/CWp7aPF31ZrQ9TBrMby68LvQYC
	 r6SKl5PvHqF/QJHHP4A4ZsANE8Ys4ZkJB8JrYspN7z8Qao4ks3phtNnN8UXtWbnsbI
	 oS+uGMV1K2coZ+oW+rY6EmD3UafxLKSKB/DJRB5AwaT4KwDP/7lRP4koHJBlxpUJ/w
	 SnwasQ8wUMvjsLUnQ+tsKmqM3UBjfzo1Qd3U5m60P4PgbYPrDfJEIQbGVfc4dHnl5+
	 fXkc0dtivZ0PNzFy2Z8uNS8Sfb2Atc7nSkS9HQg7t/jLpMuL04aixBGa2FMdNvSdsx
	 Esz6pR5PPf6rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF037C021B5;
	Sat, 22 Feb 2025 09:50:01 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Feb 2025 10:49:28 +0100
Subject: [PATCH net-next v5 1/7] net: phy: Add swnode support to
 mdiobus_scan
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-tn9510-v3a-v5-1-99365047e309@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
In-Reply-To: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740217800; l=1936;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=eboV90jxD+Bku0BOXjDGCNU60DTUE9kSyEbR0D3C8dU=;
 b=Nogcd+1D21291CGyGc6d46o9MFdESh6MrwVLG7OWMOqvmTxM2yIuQjEeOOQ7TJhfP9xBJ1QqX
 Segj+wdlu7qCwB+ZKnvurPEYNx1a7R4RW95HAzlPqxpbuVNENZp3F46
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
2.47.2



