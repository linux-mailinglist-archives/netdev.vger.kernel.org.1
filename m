Return-Path: <netdev+bounces-193157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111AFAC2AF8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825A81B67475
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 20:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1C20E6ED;
	Fri, 23 May 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VniOmcwR"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0D20CCE5
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748032480; cv=none; b=Qw1aMFEAGSOs8SQxq2IPvykZp85+odDfq2grq7W0lq07ab/pN5bS+FI+ZhAWdqzA25kGeJsu25Jrrod0fNTUSrdm0AFJNF4Skh4/ZcX/IQHlI5MjkyZCxVOmj++g+/YpC5guF5byz5GJ+89yPkB1W1seT7iVW+rMMasywINcjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748032480; c=relaxed/simple;
	bh=BpOPhhUmAooZYi+vtPLF6RqGxViWB1xQigFxs2AIdyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLZ/d4pwdu2tiw6ZgBnSx/PsmlV7ULSGFKSmBeB3PHsH8cIeA9IZd0SfW0spN8nDR1kO9Z9sT7OGVAw/fjiG/TNy9uIeeK0NJixTiazXHvsr3RajjYD1dlaAgbL/2YQFEiQ+CRa1nJRZnOm0dSDz38wJ5bbd72fL9g2OpAiIHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VniOmcwR; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748032476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9huAoqeTCtycjuquWPGnK4R6jNSfK5c2rVHkBsZ7MU=;
	b=VniOmcwRZ0iaMZxZKjsL6x+F0lRYzj5NhCcx/7tKQD+WJt82pRZdO7VLY2XqNECkSIDl8P
	1kzFEfvTtbOdEUv8ZM6hPlRuZXsPTZu7T6xWEmOgfEal/tryPp5zHTfv26qIEk7BZa9waA
	D70KXP8j923XSGmLLEYbKugTfhtP6aQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Lei Wei <quic_leiwei@quicinc.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	UNGLinuxDriver@microchip.com
Subject: [net-next PATCH v5 04/10] net: dsa: ocelot: suppress PHY device scanning on the internal MDIO bus
Date: Fri, 23 May 2025 16:33:33 -0400
Message-Id: <20250523203339.1993685-5-sean.anderson@linux.dev>
In-Reply-To: <20250523203339.1993685-1-sean.anderson@linux.dev>
References: <20250523203339.1993685-1-sean.anderson@linux.dev>
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
index 7b35d24c38d7..087d368a59e0 100644
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


