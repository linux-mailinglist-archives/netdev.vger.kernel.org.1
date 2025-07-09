Return-Path: <netdev+bounces-205427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD60AFEA45
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04351885C98
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925152E0B7C;
	Wed,  9 Jul 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="APPpH7Ol"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E95292B33;
	Wed,  9 Jul 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067954; cv=none; b=W2TMnlroT9P2UTHmu7tOG23wuFdlU7nbGTha1sZnhd7tdyjfijX4e4/q3Uvo+TA9BBdjJLEGRB0i+Jomsin3uCx1uqJWHGvCrxVdjWABPXhhajgZ4aDQ6Kq/88THR2fKgd4/XpCoQcZMeAjqcEXGFQQ1l2ONxnELOCvymd2/zxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067954; c=relaxed/simple;
	bh=cS9JZKHcrI1sOejvhyf5hV9Kn+94xTLFQpFgL+EZPHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpqEdlkMVp2FKftBfPi4Mvm8/PO7+mlpe6ag8BVs60iQYqJK/PXLk5z/LBMdKHmwB/tj0P6v0YRDXDx+DX/8NkBfH9Bi0iqsnpnf4fM0S7mkbVu7FVcRkZ3KyGuJS0XdJfdamcz3viYo1D0VbZdqGBy0petVTlQHWhrBvPYGwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=APPpH7Ol; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E301AA0D5B;
	Wed,  9 Jul 2025 15:32:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=kj4tqlPIiJTOpTKcSV71
	gR7052GhCknmNk9Oj29uoqc=; b=APPpH7OlQv5dviBKiUK6cuJUN6ehOoXM9fuC
	1db5kt0aSiE8LTij6to1XDXNPsZFmqBQa+uYkE8HXO9A7xDvHzOUhJ1MDebBmr9z
	yGLhUqGhTeqB5ekakG9YnzW/BOxDKBqhSsCUuXXSAYhYKpc/F9wZW0dOkJknMw0L
	ujsh3vaZXA3CkPEIL1YpjXzpTdmMCWMOFd2g4qFxe83QDQKemFmRU0V0mGUZz3V8
	HzO0PIyu2h2tBd8kacSAYUtP4WKtcZ9k/qLGATJ8/BFpAW68cVnA3Hxp+pZjEXmj
	+Tu7KxVmzSg9ij/uo0FTYgVK9HNcDYzSC7B4STELwqpl7U/MvRmFp6IQHwlCdCWi
	dbP1Cr3U9DFRR0gvMHWDUsbkLFTsVss1kHjiHJ2e1knjQaIqeUq6yiC65JVSawmQ
	uLnYMxIKx3AaROCTD+skSmQyj4zQHNSuarmtcPnAC1/PDNrt/j4PGi0h7IwZLwnu
	jJ8zlYfWY8BUp9//kmZFLeYQK6Z24jz1gK1+9DFtE0DiNBsngOI5owR0BVAp0XMI
	664/Yd0ZxwjukuFeCB5mqGYm1YuodasiWkkXmE85OuGqz4D4X1cCWyFAzfFe8O0h
	D3iPQVRs3EdzYAQ7V2PLi3SPXNBAVxUdCjTThbhFFaZOlCV3iTF5teTbyfpfYHL3
	r05Nvoo=
From: Buday Csaba <buday.csaba@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
	<csokas.bence@prolan.hu>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 3/3] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Wed, 9 Jul 2025 15:32:22 +0200
Message-ID: <20250709133222.48802-4-buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709133222.48802-1-buday.csaba@prolan.hu>
References: <20250709133222.48802-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1752067950;VERSION=7994;MC=3182953916;ID=104609;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E657164

Some PHYs (e.g. LAN8710A) require a reset after power-on,even for
MDIO register access.
The current implementation of fwnode_mdiobus_register_phy() and
get_phy_device() attempt to read the id registers without ensuring
that the PHY had a reset before, which can fail on these devices.

This patch addresses that shortcoming, by always resetting the PHY
(when such property is given in the device tree). To keep the code
impact minimal, a change was also needed in phy_device_remove() to
prevent asserting the reset on device removal.

According to the documentation of phy_device_remove(), it should
reverse the effect of phy_device_register(). Since the reset GPIO
is in undefined state before that, it should be acceptable to leave
it unchanged during removal.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
Cc: Csókás Bence <csokas.bence@prolan.hu>
---
 drivers/net/mdio/fwnode_mdio.c | 20 ++++++++++++++++++--
 drivers/net/phy/phy_device.c   |  3 ---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index aea0f03575689..36b60544327b6 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -139,8 +139,24 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	}
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
-		phy = get_phy_device(bus, addr, is_c45);
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
+		/* get_phy_device is NOT SAFE HERE, since the PHY may need a HW RESET.
+		 * First create a dummy PHY device, reset the PHY, then call
+		 * get_phy_device.
+		 */
+		phy = phy_device_create(bus, addr, 0, 0, NULL);
+		if (!IS_ERR(phy)) {
+			if (is_of_node(child)) {
+				/* fwnode_mdiobus_phy_device_register performs the reset */
+				rc = fwnode_mdiobus_phy_device_register(bus, phy, child, addr);
+				if (!rc)
+					phy_device_remove(phy);
+				/* PHY has been reset at this point. */
+			}
+			phy_device_free(phy);
+			phy = get_phy_device(bus, addr, is_c45);
+		}
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 13dea33d86ffa..da4ddce04e5fb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1102,9 +1102,6 @@ void phy_device_remove(struct phy_device *phydev)
 
 	device_del(&phydev->mdio.dev);
 
-	/* Assert the reset signal */
-	phy_device_reset(phydev, 1);
-
 	mdiobus_unregister_device(&phydev->mdio);
 }
 EXPORT_SYMBOL(phy_device_remove);
-- 
2.39.5



