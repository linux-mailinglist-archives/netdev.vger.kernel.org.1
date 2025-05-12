Return-Path: <netdev+bounces-189808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14590AB3D1C
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD671898746
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F712522AE;
	Mon, 12 May 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w2Kv6phL"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A729524A06F
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066254; cv=none; b=JtC6qpqFeKLZGypemn27zd3XQE+5L8QApLxW2iojqDISsoQN7ms5L6dyhrgAIA6FuDK7eA6nzX7y6oAq1NmaYHXfcX0sUZD82MDDNomAOKnQnNiVops7U1thZ6UW8tP4DXEngb22wPVcEZkI8m4ij03pwJTZoQMF4iUqxGOVrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066254; c=relaxed/simple;
	bh=AYs9sb2jpRkrqVSUaYHZtZtG17g+crrhBSqnGzQ0jiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G6EXMIneYRrc4tkIeam5Q+lToPxu2owdBDWp4icHXISGkHOlsjXH74eFaWhr6FBpK7m/d7WbpZORIgHi+cbRqBvjMFnAdW13so5l8aFBhvj4hXHgDVpgMUZu09FcuGF/exgYo7H/TnAJQjPxtsH74wPKHuYG/qQGCUIkGIfAuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w2Kv6phL; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747066250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxMwV7M7yCVNxDE74IL+lkfkBhZWomk4wxk+8wLGLZE=;
	b=w2Kv6phLbCvCMrFTYJUS9bR0mh+nLox94d2u8qzdF9LUMKzfaisSgiFOqhwcFA7ndPqUSk
	LtzSAkp1UewBi3z2sHmubR2/1CBi7OeJqO55u+JWRd4afidQ9eEIxGB0ClP2mGYur4XnlT
	bC3E1F0VI8kiOKhJFNFE4Nn+ZCuBd/8=
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
	Sean Anderson <sean.anderson@linux.dev>
Subject: [net-next PATCH v4 06/11] net: phy: Export some functions
Date: Mon, 12 May 2025 12:10:08 -0400
Message-Id: <20250512161013.731955-7-sean.anderson@linux.dev>
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
index cc6c209fe702..7548a274bcdb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -899,7 +899,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
  * valid, %-EIO on bus access error, or %-ENODEV if no device responds
  * or invalid ID.
  */
-static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
+int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 {
 	int phy_reg;
 
@@ -927,6 +927,7 @@ static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(get_phy_c22_id);
 
 /* Extract the phy ID from the compatible string of the form
  * ethernet-phy-idAAAA.BBBB.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fb755358d965..512ed1be4ec1 100644
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


