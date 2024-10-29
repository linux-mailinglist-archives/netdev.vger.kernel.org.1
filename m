Return-Path: <netdev+bounces-139875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A89B47DC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBEE1C251E4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7A205E04;
	Tue, 29 Oct 2024 11:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F687205122
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200077; cv=none; b=DFPTLK0ece4MKcpGmBmnYArLqSdqRUMJ4tYze2XVa9NVCP+K6fN8vQ2tpTgo8eMDZ6n4xnFmCI0+ztLOTLsd6ZFptKE5uqQktygzdHsz/uI9+/UugnR0RAhCJXnH+BFI0VORQrQizje/ao3RIzWqbK6AyGdJMMwQX251zl49F5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200077; c=relaxed/simple;
	bh=qNTRoQF5G+AVxjUEitU9u/c7zu7hVdJSZwMOoY40uU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LrEhMMWG2+TNRS1PQXxE9hmvPOv1GSpcWiiimjT+TYfBfGHnIsyvDA+eCv5FBOr4c7wzfcsk824Huw2IVOjHL4wPCVva1rmhJ6LEU8n79jDlOd4V7h8LytklJHgigWe+0n9XeWSUseF0icNb7LT+7hNKjTpQsDMZBVU13b+gjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t5k4V-0008Eu-BW; Tue, 29 Oct 2024 12:07:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5k4T-0010yt-2U;
	Tue, 29 Oct 2024 12:07:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t5k4T-008ILK-2A;
	Tue, 29 Oct 2024 12:07:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH net-next v2 4/5] net: dsa: microchip: cleanup error handling in ksz_mdio_register
Date: Tue, 29 Oct 2024 12:07:31 +0100
Message-Id: <20241029110732.1977064-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029110732.1977064-1-o.rempel@pengutronix.de>
References: <20241029110732.1977064-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Replace repeated cleanup code with a single error path using a label.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/microchip/ksz_common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89134e7fde93b..f9e45bba2d293 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2411,8 +2411,8 @@ static int ksz_mdio_register(struct ksz_device *dev)
 
 	bus = devm_mdiobus_alloc(ds->dev);
 	if (!bus) {
-		of_node_put(mdio_np);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto put_mdio_node;
 	}
 
 	if (dev->dev_ops->mdio_bus_preinit) {
@@ -2457,10 +2457,8 @@ static int ksz_mdio_register(struct ksz_device *dev)
 
 	if (dev->irq > 0) {
 		ret = ksz_irq_phy_setup(dev);
-		if (ret) {
-			of_node_put(mdio_np);
-			return ret;
-		}
+		if (ret)
+			goto put_mdio_node;
 	}
 
 	ret = devm_of_mdiobus_register(ds->dev, bus, mdio_np);
-- 
2.39.5


