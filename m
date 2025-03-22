Return-Path: <netdev+bounces-176858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF21A6C9BE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BFC16CDB0
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290991F9ED2;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlVONfNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141C73451;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=sa4PZIfHAHzBUq1FAadrYB26wRVqCN6I7SSu2mz+jK+Rv0pKnta2lgqrSvVILLVI7U6xR1A8r8D7G5FqY61gJFS93HaceNsaoOU//I68hnW4oualby/jGEQoMdXHYwI5VAdgQODHRL8OULNLehoQJfD/hcSsMfpijp6C7/YSBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVpR1irj+a0twimq9ymACsGB6MyCHh/1xmpOjXT2B8E/UZXnEMh3rmKghKHhn0qx02PkywALer3MhJjEevUp7h1j/0zth0kwcegDegf4zJxTHfjMRjk+Cm+01BJmjfip20hLP4zn5bf0e38uYq8xN8N0cIGYZIC3QAgexk+lPI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlVONfNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 851B2C4CEEC;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=z15Ls+N2f4qhQa8zHLA/8pAS/OD9DivM6Ks6EyIuxMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mlVONfNv7v6lOm0FHNJ2Wy9ud/b7QpZH6RKeU0xASISajt7AE5QVFwO3io5Zkw3T5
	 4453uH0a91K0cGvcyYh/6ul1PTOvF5K78ob1KC8Z3YMqF0n5FWSUZzF/Nmb6bc+bKk
	 tlvM3+ySlW4Vrz+sP6NqxPWht1EFvNLSakl8x7KrTsOBht8vADCM8pTGiAZx1tnDNC
	 Y6LqjOWzsd11W9IXOkpNv1+8sUEC6A89xo1tsAMfiOsXRzzs3pIBLDRN6OZAQCQZjU
	 wV6LR4hWhoOjv6+bntSbhEr7r9gl2dkBv2Ac6Wggyy4ajzhcu/hq0T7t3OV0UTRT+k
	 dh+O48YmRbFOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA4EC36002;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Mar 2025 11:45:52 +0100
Subject: [PATCH net-next v7 1/7] net: phy: Add swnode support to
 mdiobus_scan
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-tn9510-v3a-v7-1-672a9a3d8628@gmx.net>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
In-Reply-To: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=1936;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=eboV90jxD+Bku0BOXjDGCNU60DTUE9kSyEbR0D3C8dU=;
 b=yODUcpSruP6Prn/8AAbwj8cpTWqNAPLgfym6lscc+Rxx9ioXqQomJgtb+WBzveF7mQb8VCzNo
 Ki8EAabHm94CIXeA/62fgaLZKx0u5WUZqZRl58mmfcZGEhcM1tox9ll
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



