Return-Path: <netdev+bounces-230537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 857BEBEABBA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAEE55A6880
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3128725F;
	Fri, 17 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="om70ofu3"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95E2777E0;
	Fri, 17 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717425; cv=none; b=mHrkT5ZYyWE3N79erz2PaiXhsf5T2eMcd+k6BRbNtor/DmIcXFGCYjMDu4yalwc/1UIrsAIrDlGgb8WbJq/l+JTrHEJ/1g42sNhR8YKEhwwOu/rtJ40kfUChs5LVG9qnwDfUre5ZWCkVikMzlp8NL8yFx4TJo0LBQ3D45i7Iaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717425; c=relaxed/simple;
	bh=g413N2EtaCoE+cYgVBHxXA81wiQqN+EXKGi0nWOzH4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzFNNcgxN/1NCRI87fpbLbGg/Ta21086BINRlCzBFgf0H9vzD3jLfhfw/seCOq7/LyTPviVyeJR4h0p+xuZaD/C5sZv/mymdz9jm1plPZ0iGkyEZ7xLkn4o4q05a4d6afpJrkzPgXrV0QRrjKWjgmbJJMLDDQ/gJF1jp7PkgV20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=om70ofu3; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ED31AA0A26;
	Fri, 17 Oct 2025 18:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=mIQwReTUSM4NJP0VNgJN
	29BzTbzQt8jrZ9Cb25wJHqw=; b=om70ofu3asdgwp07pI8ZHK3fnEnGCc/4dhu8
	k1/PIuGbctoZ2lfMU7v+7YrzMdrceUA6cnRaAuzULsb8bQVvqtpkU6yzbvFDmv+I
	b1qCWFVENgAUMWFguRQq7y6JyDDAaAQ4tXmzqjdLF7URY8wlVroXEV17APUQXuTj
	nUtweVfNHqiQbPg/KM0+Xz8sa7+k8JRiwaHEOP5fEWgC4D+WTlDUNIiGiwP8NE10
	Zbxiy8XYxg3OQMEFn4qgbBVkiWNhL8gd5Zu0cIGF9b+9r5vRVHDt9rZmCgTj8zQm
	km8UuTOr1LXnBlCmQ2mNeGih6+ZysGN2+NPntDYjIsIBYnayUxL5l3rK4VBiieB2
	UuWEGbbDoqfyRRJZVZO+Q/Vd2wTJmJQiJpydw8pmvY4y/3Tn4NQOfbfAvNj9JCZN
	7kWeIP9fIbdFyWR8WEnjlGd/NAtQJBcUBAz6L80hfJdV3mk8fkFY+fhw4dWf+fxp
	/r0zN1Ui21n0CJlOP4J3ZTpzjNETvDc4lnGJtrpJgbMwsvtKZrxu8uqivCB+Wd05
	Plf8dgLRev2OjlU/GV0ztrgQsVh81B7J+glLjE9NV7jvJ6/dXF+uakA2S6Ay2F/j
	BzQaA+X52yoV/yBg4CXiHq1FQR/q5M0+pUW3vgCMWYdcdNvbIrFk1qdXNpUqDL+0
	QJt21mM=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Florian
 Fainelli" <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v3 4/4] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Fri, 17 Oct 2025 18:10:11 +0200
Message-ID: <cb6640fa11e4b148f51d4c8553fe177d5bdb4d37.1760620093.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1760620093.git.buday.csaba@prolan.hu>
References: <cover.1760620093.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760717419;VERSION=8000;MC=3822495923;ID=62086;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F647660

Implement support for the `phy-id-read-needs-reset` device tree
property.

When the ID of an ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

This patch performs the hard-reset before attempting to read the ID,
when the mentioned device tree property is present.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V2 -> V3: kernel-doc replaced with a comment (fixed warning)
V1 -> V2:
 - renamed DT property `reset-phy-before-probe` to
  `phy-id-read-needs-reset`
 - renamed fwnode_reset_phy_before_probe() to
   fwnode_reset_phy()
 - added kernel-doc for fwnode_reset_phy()
 - improved error handling in fwnode_reset_phy()
---
 drivers/net/mdio/fwnode_mdio.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..8e8f9182a 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -114,6 +114,36 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_phy_device_register);
 
+/* Hard-reset a PHY before registration */
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
@@ -129,8 +159,11 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
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



