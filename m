Return-Path: <netdev+bounces-61475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBC8823F8A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A486281CF0
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACD820313;
	Thu,  4 Jan 2024 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ak1i0mOo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E92720DCD
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qLPZ/UEJu+oa4eFKvb/KQ3lJnSrlG/VuW97qxRQS6VY=; b=Ak1i0mOoZaybzV2N6DUc+N9Vu+
	pWWY/orjJVCmSDjX9rrXOfLLvDrzd/SEjwNyHEzUYuuOOGEsMYmaWolNdx7rO3Sclk/2keHdPLXeg
	b3y3J4MtjuwRyHHGf/9bcNL/mrkeodL7nm0J0F5r8GhktPUfvmdTM98ERUx41QfnZ/mvdwgu/LOpC
	UloLZ7AApe7/3BRThOtqeCf4hTr0Hka8D9Nihtx3FoXJCG2tUgn1FIlSy4QANVV0O2A3QbU32AF5u
	mk3/FPCdHsd6tYR+/B+yWG1OeI4pgYwMu8coR7dnVv15FTXUbztXfZJCwyNHINWEU6CMa0gOTjBvX
	S9sP8Qkw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54566 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rLL6m-0008NF-2P;
	Thu, 04 Jan 2024 10:37:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rLL6p-00EvAd-Ej; Thu, 04 Jan 2024 10:37:55 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: mdio_bus: add refcounting for fwnodes to
 mdiobus
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rLL6p-00EvAd-Ej@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Jan 2024 10:37:55 +0000

Luiz Angelo Daros de Luca reports that the MDIO bus code maintains a
reference to the DT node, but does not hold a refcount on the node.

The simple solution to this is to add the necessary refcounting into
the MDIO bus code for all users, ensuring that on registration, the
refcount is incremented, and only dropped when the MDIO bus is
released.

Do this for fwnodes, so we not only fix this for DT, but also other
types of firmware nodes as well.

Reported-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/mdio_bus.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 6cf73c15635b..afbad1ad8683 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -193,6 +193,10 @@ static void mdiobus_release(struct device *d)
 	     bus->state != MDIOBUS_ALLOCATED,
 	     "%s: not in RELEASED or ALLOCATED state\n",
 	     bus->id);
+
+	if (bus->state == MDIOBUS_RELEASED)
+		fwnode_handle_put(dev_fwnode(d));
+
 	kfree(bus);
 }
 
@@ -684,6 +688,15 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	bus->dev.groups = NULL;
 	dev_set_name(&bus->dev, "%s", bus->id);
 
+	/* If the bus state is allocated, we're registering a fresh bus
+	 * that may have a fwnode associated with it. Grab a reference
+	 * to the fwnode. This will be dropped when the bus is released.
+	 * If the bus was set to unregistered, it means that the bus was
+	 * previously registered, and we've already grabbed a reference.
+	 */
+	if (bus->state == MDIOBUS_ALLOCATED)
+		fwnode_handle_get(dev_fwnode(&bus->dev));
+
 	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
 	 * the device in mdiobus_free()
 	 *
-- 
2.30.2


