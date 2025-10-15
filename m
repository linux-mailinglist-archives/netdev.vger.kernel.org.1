Return-Path: <netdev+bounces-229599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0ABDECFF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7018935743E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1B244692;
	Wed, 15 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="PDWA6BI6"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62F1FE45D;
	Wed, 15 Oct 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535913; cv=none; b=J47HZOEe1+7n0utdHOhAeDCrDBD5huuzRyRAuWngiIvvlPJ34DElfcyp1Z8RvRRbYVAi31/y54g46Sp5dCQxvHEptnbDtFM2nwvZLY5ikGio14vTXiTbf5uRD4V+pcNHKHJtKL9226FTLj6FYzvCWDDxIc337ABUbOS0HDvYs1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535913; c=relaxed/simple;
	bh=GvvKUdp4sEXuEH++q3fpXXySA7jx1qLFta8O2dpXdyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxmIEaeOvJ49Lnl/wwn3sAJSWgwgyLxDa88hxC7wTtbD1L+Gu2Yz1bXpM4nBKI4hxQPY3iOgnr4ctNvhNNioui4zQ+uh6f0CQGVsAho275txQ5/99wpvrZTAN2vYT2C0zjGj/8zst6ftkBqbJaHhksszejRC9W2I+xQt2tzymYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=PDWA6BI6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 85584A02C1;
	Wed, 15 Oct 2025 15:45:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=gbavS7FFbPM9PTK441+x
	de2SNpZOxalPToFpGWp2E0M=; b=PDWA6BI6qWoxGxvUH4gNtBtBS54Ux1ulaL3L
	rQsaiQQp5M4fPmwilu4MrZZWc5oCZllxB8sgpqp2ZYN3j8afkQf/aMPyVcue20o9
	7tf39BgyFH1iXc+SfhwdIx5RjiHbQ2siy0C1gMap0IrqRi83CgIhZoCWUFAm4KNI
	jDC+bfUVcUECrAzuaJ386dCza7RUAm9YsN1Urt14svJ5xZ8lzBxTCLijlhgyvZYX
	LrIp5/QfcnrAxpTx9lYZ1iFF5qJawlQa6GHpHE/VmYp9vWB66sY1Ap0NRBx3iTwo
	0lai5KCiWc3TO0+djj80CqTR1x0BKO5PUMvXgk4taGzusSBDwikegGXEZczQ8gcq
	yCba6IqpiVbNrg0JCUCopqw1K5Zbj9V5l18B6UO4QXoBvTJ6lOLxS4noNKWRFt7v
	a31H9GBteWxeaF2FepxIylFqosGhky5vXv7VjMjGRQvQTdrQJ9ReTOniLUlBbnZv
	Nxy9fi5A084ptjui5/loVdFzFNoU4lptzJePqgL968H/gO04Er0kmD89TkYavYcE
	CjiBhB+f8wn4qavjAxXFiCRR229ghEsiA81c3t8rO3M9GO2lEOjl8AJbgMMV9M2s
	c7B951gXJVnoKGRltymRA0uA6V7KluFmRVqPSUJvO+i2rZ3LnlafV71Exy2kt0a/
	3Sa2f8s=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH v2 4/4] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Wed, 15 Oct 2025 15:45:03 +0200
Message-ID: <20251015134503.107925-4-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015134503.107925-1-buday.csaba@prolan.hu>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760535907;VERSION=8000;MC=3270925293;ID=558035;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F64756A

Implement support for the `phy-id-read-needs-reset` device tree
property.

When the ID of an ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

This patch performs the hard-reset before attempting to read the ID,
when the mentioned device tree property is present.

There were previous attempts to implement such functionality, I
tried to collect a few of these (see links).

Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V1 -> V2:
 - renamed DT property `reset-phy-before-probe` to
  `phy-id-read-needs-reset`
 - renamed fwnode_reset_phy_before_probe() to
   fwnode_reset_phy()
 - added kernel-doc for fwnode_reset_phy()
 - improved error handling in fwnode_reset_phy()
---
 drivers/net/mdio/fwnode_mdio.c | 37 +++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..6987b1a51 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -114,6 +114,38 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
 
+/**
+ * fwnode_reset_phy() - Hard-reset a PHY before registration
+ */
+static int fwnode_reset_phy(struct mii_bus *bus, u32 addr,
+			    struct fwnode_handle *phy_node)
+{
+	struct mdio_device *tmpdev;
+	int err;
+
+	tmpdev = mdio_device_create(bus, addr);
+	if (IS_ERR(tmpdev))
+		return PTR_ERR(tmpdev);
+
+	fwnode_handle_get(phy_node);
+	device_set_node(&tmpdev->dev, phy_node);
+	err = mdio_device_register_reset(tmpdev);
+	if (err) {
+		mdio_device_free(tmpdev);
+		return err;
+	}
+
+	mdio_device_reset(tmpdev, 1);
+	mdio_device_reset(tmpdev, 0);
+
+	mdio_device_unregister_reset(tmpdev);
+
+	mdio_device_free(tmpdev);
+	fwnode_handle_put(phy_node);
+
+	return 0;
+}
+
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
@@ -129,8 +161,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
+		if (fwnode_property_present(child, "reset-phy-before-probe"))
+			fwnode_reset_phy(bus, addr, child);
 		phy = get_phy_device(bus, addr, is_c45);
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
-- 
2.39.5



