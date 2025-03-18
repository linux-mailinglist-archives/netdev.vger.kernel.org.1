Return-Path: <netdev+bounces-175907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81329A67F44
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91434242E6
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844BF2066D9;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYuyM7eY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE022063DB;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335638; cv=none; b=XaNG/ULv8K8wipYfHHtyh7P74QMT/piRM+SRKmOdUhH4ahrf3elx3QfhOVh8kvje/fQpwyA/lG8sdIJw755fL3vXzxUaB24crlyxHGSblAu0SNVjnGvtsVlrDQgDVvF2tFbLKVovLNyL2xBe+CjNPXHwgLDinFeRN6Tu7kd6EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335638; c=relaxed/simple;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p21br/o2xW5EuTPhHS/5bT2gNPn5dYu6lF8Qs4NoT+Qp6QUkAk3nhCjuX7taS/TioUdf7vV5Nooezem7O6bc3Rqe2pqQf6nmUQxugF4lt7TWHFlDgQC3eNHeY8vTNgVwYhwqu/P98hgeWRsEoWLoM8Aa29sL1joEqDMi4yYGAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYuyM7eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E51FC4CEF0;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335638;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sYuyM7eYgOIg1TUayAEGE3wv1u1h98toEAI7iwnVwnC9TFfSX1i5gSYsrbN9/W/Dm
	 bQg+ZapJ6tAlhRHXBTXtIWjdERy6Jn2RfgBdq3fdkcHS+B1MPqGcy5F3LDl3HRVnun
	 z6xk31XrJYvBnW5UNGV0CixMrPgVC3RAHRR4wrcdagoQTf2QV9f5lim9leemNc9Gsg
	 XACQd4Au/fM+TcQyavWzgVoNrHRvjjz/nz/8kYRwobOCy4WkF5JXx042fKGt5p8Jy/
	 NUtFr25cjz6gSkaulUHc5m24ib9jmE7MmUlkLWJRTS1WXqn0mDs4q7M+0dcB0yReQZ
	 m4hiBrNYs3FWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19869C35FF8;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 18 Mar 2025 23:06:52 +0100
Subject: [PATCH net-next v6 1/7] net: phy: Add swnode support to
 mdiobus_scan
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-tn9510-v3a-v6-1-808a9089d24b@gmx.net>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
In-Reply-To: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742335636; l=1936;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=eboV90jxD+Bku0BOXjDGCNU60DTUE9kSyEbR0D3C8dU=;
 b=BBFK0D+bzMirEJuwUbn+Gj2hKJBmo7eC8cXE3v2eeiURfLhONRulpN0Zsg/XF5SwGa3ClvjAX
 ow9ecsbYkWTBOEDip/IHJx67lDAa1ndFEGvYNzuaHiJHMvBG7qnFu2c
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



