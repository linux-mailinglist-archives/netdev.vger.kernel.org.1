Return-Path: <netdev+bounces-20482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D975FB4C
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF0281455
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B49DF58;
	Mon, 24 Jul 2023 15:57:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A85DF45
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 15:57:21 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C978E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IYSzyGmBrfiGGMow3++58l5TTqHaRzZEjmSfvQs7+Yw=; b=lM8WSRPpX8JseMvuNeFUm1zBRZ
	t31tHz29vAa+F9bud3leEek4nNFud5lHwC9LrYz4BxV3rDTwOjSPGGbiGguX29iXsG0S3Ed12GOu7
	aG8W8vfBe/6g1jR147POJbWbfg8SHU3QdOmq3TZvtgyr9RYXHd3DFqQT3c64WVWP2hiAYWviUVpno
	lCOnq9/JwtI+RWgkpKrq10spnCCasI8Ou3cd+CKm7c9jw7CVBgWm3oxKz/l4oCk3JvUP9jX6WEysn
	j4CiE0yV5RWAnoYaHQ1a6OBBV+feWsfBFQL49ga+5DYzUkaD5BYxrg/nMEzBtafbFAfiYl2l2LTOa
	sSsv3CIg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55292 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qNxvu-0000LK-02;
	Mon, 24 Jul 2023 16:57:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qNxvu-00111m-1V; Mon, 24 Jul 2023 16:57:14 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: mdio_bus: validate "addr" for
 mdiobus_is_registered_device()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qNxvu-00111m-1V@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 24 Jul 2023 16:57:14 +0100
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

mdiobus_is_registered_device() doesn't checking that "addr" was valid
before dereferencing bus->mdio_map[]. Extract the code that checks
this from mdiobus_get_phy(), and use it here as well.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
I've had this patch kicking about for a while - probably a good idea?
It shouldn't cause a regression, but if it does it means we're already
dereferencing the arrray outside its bounds in
mdiobus_is_registered_device().

 drivers/net/phy/mdio_bus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index bc04048de2fa..25dcaa49ab8b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -107,16 +107,21 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdiobus_unregister_device);
 
-struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
+static struct mdio_device *mdiobus_find_device(struct mii_bus *bus, int addr)
 {
 	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
-	struct mdio_device *mdiodev;
 
 	if (WARN_ONCE(!addr_valid, "addr %d out of range\n", addr))
 		return NULL;
 
-	mdiodev = bus->mdio_map[addr];
+	return bus->mdio_map[addr];
+}
 
+struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr)
+{
+	struct mdio_device *mdiodev;
+
+	mdiodev = mdiobus_find_device(bus, addr);
 	if (!mdiodev)
 		return NULL;
 
@@ -129,7 +134,7 @@ EXPORT_SYMBOL(mdiobus_get_phy);
 
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 {
-	return bus->mdio_map[addr];
+	return mdiobus_find_device(bus, addr) != NULL;
 }
 EXPORT_SYMBOL(mdiobus_is_registered_device);
 
-- 
2.30.2


