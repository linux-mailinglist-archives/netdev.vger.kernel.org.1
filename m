Return-Path: <netdev+bounces-231595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D6BFB174
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4165867BF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E22313298;
	Wed, 22 Oct 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oVF/FJ+0"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601903112C0;
	Wed, 22 Oct 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124148; cv=none; b=W5wRv2BSCI2tMouY/ZAqzTt/AMN7pwbBASpVIADYluzzoMLJLsfUhRNuZubtb4e8jVDAxcc0NrB+r0YiAglMMenDSoJf7Fgggloa4sAvrb3fBm1PYOJBoMpuymyDbgZ1Tdswi2TjXPFmOMS1PQP1PNnt6K7S2Ww6BuaPZOcLTgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124148; c=relaxed/simple;
	bh=VcimyJ7/xW4JvjwglzTdwuqymBPHtHsRiVfiRusJ0k8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNFiK9MwYOpwasBwYfzHUgdwhm37K+Q3khyoriFZhupgV3JLuhdjSI0NN2yeBtpukoqxNGHRc2WKZ4MYkX9b3ASgruXTwJ22Heuwys2kwqakU9H99vKupaTz5v2rGrVPCgt2LpkL/kby69id8CIC9QEKUlCNLKvfKEg1C1HCPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oVF/FJ+0; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id BFD64A09F6;
	Wed, 22 Oct 2025 11:08:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=FV1+GYfuG3fm+jLpLTMq
	GoEYBia/ZfjgZeZsgAOghk4=; b=oVF/FJ+0ifnSbSJ6y/KbYUdP6IJ00LOLrwsQ
	T/rP3bY6+d7ey9TQ1u7JYa7z465XXFvc16sWaZKst7mR/URgq3pTdAjwBBk9sLx1
	KL8yrICF8LiiFLB0OsZyPHc9VgvmaOs32WIU45m7F3dGShDrwkDY83c5x3K1ixxY
	56Ma8AHO32oChIGo3RZwSAZReTI6wgEzxKwio0fVOHD/Dqha62aTwNnSKufB+M8b
	lHTUFejXGngtJ7oSjcSjsJuJL3wD1taB6a/LVGG734W3n8FsfQDByC0cIGzsklEq
	HHDpJzCvba75RRiQQ5MQE/WpcpjjrSl+bUhe3ut7DQtqe2HtQDKchAdJyPQFiLEG
	bqH8BTozS+1Lxb9RA1yN20Q9+djdWqc2CxUVN+BZScwe6FosI1SiyxDa2YxG0mMg
	C92Z6l5qrIEFoCPN66VA4TlKXNsumtAyho+NGa0s/ws/elX53XCX9UntrSnDnYlU
	NwmjR0tLGAl34AXmeylL4WdPEE9wytNGHtBEIpPoa8z1aaWEFDFdQf0W5PnT0XhO
	WVMyLIx1E21N44I5Au4f5ZGvKZvbtA9RZ2E59PtQEQjg7yqFGrXD6bCZjYIKoxmC
	f0AkPQNpnaHQfT+R0A3ayKsmdJRKuX98SCUNmAYlRlbmQnnpt1Vll6aWYITMtbfU
	JuOwPPM=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next v4 4/4] net: mdio: reset PHY before attempting to access registers in fwnode_mdiobus_register_phy
Date: Wed, 22 Oct 2025 11:08:53 +0200
Message-ID: <bebbaef2c6801f6973ea00500a594ed934e40e47.1761124022.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761124022.git.buday.csaba@prolan.hu>
References: <cover.1761124022.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761124136;VERSION=8000;MC=2911013999;ID=130161;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F647D62

When the ID of an Ethernet PHY is not provided by the 'compatible'
string in the device tree, its actual ID is read via the MDIO bus.
For some PHYs this could be unsafe, since a hard reset may be
necessary to safely access the MDIO registers.

This patch adds a fallback mechanism for these devices:
when reading the ID fails, the reset will be asserted, and the
ID read is retried.
When the reset is asserted, an info level message is printed.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
V3 -> V4: dropped DT property `phy-id-read-needs-reset` to control
	  the reset behaviour, asserting reset as a fallback
	  mechanism instead. Added info level message for resetting.
V2 -> V3: kernel-doc replaced with a comment (fixed warning)
V1 -> V2:
 - renamed fwnode_reset_phy_before_probe() to
   fwnode_reset_phy()
 - added kernel-doc for fwnode_reset_phy()
 - improved error handling in fwnode_reset_phy()
---
 drivers/net/mdio/fwnode_mdio.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index ba7091518..623120e3b 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -114,6 +114,40 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
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
+	if (mdio_device_has_reset(tmpdev)) {
+		dev_info(&bus->dev,
+			 "PHY device at address %d not detected, resetting PHY.",
+			 addr);
+		mdio_device_reset(tmpdev, 1);
+		mdio_device_reset(tmpdev, 0);
+	}
+
+	mdio_device_unregister_reset(tmpdev);
+	mdio_device_free(tmpdev);
+	fwnode_handle_put(phy_node);
+
+	return 0;
+}
+
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr)
 {
@@ -129,8 +163,13 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(mii_ts);
 
 	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
-	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
+	if (is_c45 || fwnode_get_phy_id(child, &phy_id)) {
 		phy = get_phy_device(bus, addr, is_c45);
+		if (IS_ERR(phy)) {
+			fwnode_reset_phy(bus, addr, child);
+			phy = get_phy_device(bus, addr, is_c45);
+		}
+	}
 	else
 		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
 	if (IS_ERR(phy)) {
-- 
2.39.5



