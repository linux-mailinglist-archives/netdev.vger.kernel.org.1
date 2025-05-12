Return-Path: <netdev+bounces-189806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D684BAB3D1A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04123B299E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCB251790;
	Mon, 12 May 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AgHQ4xR/"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB63248F65
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066248; cv=none; b=Q2GqnmAjfy8Z1s0X68M5bAtL3M8GyPpkmygrTeIRPnJ62663TI4LDAxNJqBCFDg3Ds8Qh15BcgU8GtdWpIyyko69PJCIHf4jLrDWawXG5NV+nm1/LioAhjeLNLGD1o2B+w3E3Ry1RbGvDfM9PmZrpFJr3TOiph5S0KRvdtzDX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066248; c=relaxed/simple;
	bh=0a8Tm8F4nw7ll3Te78QmIIlXcu31CarzokCN38n04JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRTArhsDCF062idaRNB2qHJBxCsgucRfiIhKs/rvc1sjGl5N9DV5zTs46zupzMCBI1mzEoBrSoeBZLfXWPJNPQhbsjIHnInWF3ThrLKTbuvOeyXF5o3GkOiTEPvB0IFXmGlgy/QbQqsdXguJWuUGS4W7KoFl+BRU2IjlYcLr/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AgHQ4xR/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747066244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y59pT+OH1+71fA//RkwprkuSIou3iot0H18g9s9hw/o=;
	b=AgHQ4xR/krIteuiQVNMyzSublIc4iNwUJYwRyZZmYJmJ55SeBPyqS0YtREquWs5xgwuquQ
	lFRJpHHsYPBJ2WKd1/4GFkkUV9cJG9T00R9GcLQWK588Yvb1m7juIbarDYiuoEPgcJa9cC
	PsnKuQ+ozh3Z7zt6C/34jVX1hBq8+Ag=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	UNGLinuxDriver@microchip.com
Subject: [net-next PATCH v4 04/11] net: dsa: ocelot: suppress PHY device scanning on the internal MDIO bus
Date: Mon, 12 May 2025 12:10:06 -0400
Message-Id: <20250512161013.731955-5-sean.anderson@linux.dev>
In-Reply-To: <20250512161013.731955-1-sean.anderson@linux.dev>
References: <20250512161013.731955-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This bus contains Lynx PCS devices, and if the lynx-pcs driver ever
decided to call mdio_device_register(), it would fail due to
mdiobus_scan() having created a dummy phydev for the same address
(the PCS responds to standard clause 22 PHY ID registers and can
therefore by autodetected by phylib which thinks it's a PHY).

On the Seville driver, things are a bit more complicated, since bus
creation is handled by mscc_miim_setup() and that is shared with the
dedicated mscc-miim driver. Suppress PHY scanning only for the Seville
internal MDIO bus rather than for the whole mscc-miim driver, since we
know that on NXP T1040, this bus only contains Lynx PCS devices.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/dsa/ocelot/felix_vsc9959.c   | 4 ++++
 drivers/net/dsa/ocelot/seville_vsc9953.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 940f1b71226d..2de12611ab57 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1001,6 +1001,10 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
 	bus->read_c45 = enetc_mdio_read_c45;
 	bus->write_c45 = enetc_mdio_write_c45;
 	bus->parent = dev;
+	/* Suppress PHY device creation in mdiobus_scan(),
+	 * we have Lynx PCSs
+	 */
+	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = hw;
 	/* This gets added to imdio_regs, which already maps addresses
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index eb3944ba2a72..28bcdef34a6c 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -901,6 +901,11 @@ static int vsc9953_mdio_bus_alloc(struct ocelot *ocelot)
 		return rc;
 	}
 
+	/* Suppress PHY device creation in mdiobus_scan(),
+	 * we have Lynx PCSs
+	 */
+	bus->phy_mask = ~0;
+
 	/* Needed in order to initialize the bus mutex lock */
 	rc = devm_of_mdiobus_register(dev, bus, NULL);
 	if (rc < 0) {
-- 
2.35.1.1320.gc452695387.dirty


