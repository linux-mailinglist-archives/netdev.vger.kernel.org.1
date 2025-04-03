Return-Path: <netdev+bounces-179098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8668FA7A932
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB086189A493
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13F25485B;
	Thu,  3 Apr 2025 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQV6/69t"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB218254841
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704382; cv=none; b=rLGzVLMxPxTEIYXHLPwJZLHT1ajflBaY/XRGLMu0ueaBNpcZRVshBr7d1lIMUixC+meFI/8wo1vZSancmYTjKbMIK6nm454FSjYjZBqly1z8Y6SgzlpWiey+WF93uuCSojycTGQHL+5adb2Bjm5lDUPWIuX1HoUFVQpM7fInCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704382; c=relaxed/simple;
	bh=U67U8HPLo62MVGxYgaD/aTKiiPgCvvXIRaEjZTmBSOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkZGih2w9EjGRlKYm18l/GCnyy3xJmjfEMiga5/Jpc3KNulf365zaCl127qB3v+8vvmE4CbNg3Juj1S1s1E9+JEK+k5T1JNkGpxZDGBi7hoGcsjCbj2clEaEfJXzDBHtw7zoq3Q85R7zr8X6bsY122lhzK0FFulOsa9Y7aJSUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQV6/69t; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743704378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4p274Rlun2RWD3I4z8ORjPfs+OSbTpCA+MHaDmXDevU=;
	b=uQV6/69tk5gxeueujrMbwzRIo8PKLFIXyYUPiPG4QmmJm5Hr0cJKqz4tTVwmIqKfW8xZ9f
	ov2ZYufWTKG/Qb3T1bYObFhcLfUQ9Dw3109258kRjTph/3i5CmLhjxD2CPfT2B6ukG6YRt
	jKHYZpxYp8C3batpodQ9T6Jav88a8ok=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	upstream@airoha.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC net-next PATCH 06/13] net: phy: Export some functions
Date: Thu,  3 Apr 2025 14:19:00 -0400
Message-Id: <20250403181907.1947517-7-sean.anderson@linux.dev>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
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

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

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


