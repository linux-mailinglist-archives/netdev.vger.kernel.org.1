Return-Path: <netdev+bounces-179997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B4A7F0D8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA907A3FC7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241E22FAF8;
	Mon,  7 Apr 2025 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wjp478hD"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39C421E098
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067904; cv=none; b=Rh9GgBrrt60NEwiMIOEB/BOwVsQNRhhFR5Uz9W9IcSqpzBNH5HwUje7MDlyZLR8Op4uierZfgh5QS+oxl3lEcX32WqEUwUP+ISjZD/FnOt9E3+xwefwUjbVK0LSnv0ob3L0XiRD3uTSZXDMGFZg+pFvwz2IbBn3Hs04A4WZUKbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067904; c=relaxed/simple;
	bh=BN7ETIuyFW9TxYw/bXTebH8Kve4WGN9jXWRpOJLAPjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miZvG8oDJE4EvjUrzwdzVXoAC2m9usjDWkCHyHqfuo9VdRTYYlvtSe1XpEFghrPFGR+otzRBL1muahEWezZUwXQV+Qppjug9lg0NjJb/8phSTSgVvrEqKy6L5htsPxq60yR2RAlzgQ9zbe/r4rcx5edGovd6rnHMX91xe5rCdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wjp478hD; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744067900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9d9MEz78MbAyqvcEvu82dzn1jpTo29otBZUD+O9lRa0=;
	b=Wjp478hDrndZGY4zi7HHu7bst0vUKWi0097MYT/L10jDUVgTGtuKC1xEqxAvZe90vNf+YO
	4fhCW5mGOxIBhX9FkUjx1LaBzqn/gNJpQjU6inexCGW2KILKe98FHSGgIzMqC3h7sMynTy
	Yl9ArGdp83rmAH0KY6YD3hw/dtaw5IQ=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [net-next PATCH v2 09/14] net: phy: Export some functions
Date: Mon,  7 Apr 2025 19:17:40 -0400
Message-Id: <20250407231746.2316518-10-sean.anderson@linux.dev>
In-Reply-To: <20250407231746.2316518-1-sean.anderson@linux.dev>
References: <20250407231746.2316518-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Export a few functions so they can be used outside the phy subsystem:

get_phy_c22_id is useful when probing MDIO devices which present a
phy-like interface despite not using the Linux ethernet phy subsystem.

mdio_device_bus_match is useful when creating MDIO devices manually
(e.g. on non-devicetree platforms).

At the moment the only (future) user of these functions selects PHYLIB,
so we do not need fallbacks for when CONFIG_PHYLIB=n.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/phy/mdio_device.c | 1 +
 drivers/net/phy/phy_device.c  | 3 ++-
 include/linux/phy.h           | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index e747ee63c665..cce3f405d1a4 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -45,6 +45,7 @@ int mdio_device_bus_match(struct device *dev, const struct device_driver *drv)
 
 	return strcmp(mdiodev->modalias, drv->name) == 0;
 }
+EXPORT_SYMBOL_GPL(mdio_device_bus_match);
 
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
 {
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225378..45d8bc13eb64 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -859,7 +859,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
  * valid, %-EIO on bus access error, or %-ENODEV if no device responds
  * or invalid ID.
  */
-static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
+int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 {
 	int phy_reg;
 
@@ -887,6 +887,7 @@ static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_phy_c22_id);
 
 /* Extract the phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..c648f1699c5c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1754,6 +1754,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 				     bool is_c45,
 				     struct phy_c45_device_ids *c45_ids);
 #if IS_ENABLED(CONFIG_PHYLIB)
+int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id);
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
 struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
-- 
2.35.1.1320.gc452695387.dirty


