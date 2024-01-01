Return-Path: <netdev+bounces-60758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D7821578
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 22:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B105E1C20CAD
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 21:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC77DF6E;
	Mon,  1 Jan 2024 21:47:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1079E544
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=husqvarnagroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=husqvarnagroup.com
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T3q102NMczMq1St;
	Mon,  1 Jan 2024 21:31:16 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T3q0y3VmLzMpnPd;
	Mon,  1 Jan 2024 22:31:14 +0100 (CET)
From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>
Cc: Michael Walle <michael@walle.cc>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: mdio: Prevent Clause 45 scan on SMSC PHYs
Date: Mon,  1 Jan 2024 22:31:13 +0100
Message-Id: <20240101213113.626670-1-ezra.buehler@husqvarnagroup.com>
X-Mailer: git-send-email 2.39.2
Reply-To: ezra@synergy-village.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Since commit 1a136ca2e089 ("net: mdio: scan bus based on bus
capabilities for C22 and C45") our AT91SAM9G25-based GARDENA smart
Gateway will no longer boot.

Prior to the mentioned change, probe_capabilities would be set to
MDIOBUS_NO_CAP (0) and therefore, no Clause 45 scan was performed.
Running a Clause 45 scan on an SMSC/Microchip LAN8720A PHY will (at
least with our setup) considerably slow down kernel startup and
ultimately result in a board reset.

AFAICT all SMSC/Microchip PHYs are Clause 22 devices. Some have a
"Clause 45 protection" feature (e.g. LAN8830) and others like the
LAN8804 will explicitly state the following in the datasheet:

    This device may respond to Clause 45 accesses and so must not be
    mixed with Clause 45 devices on the same MDIO bus.

Fixes: 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities for C22 and C45")
Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---

This change is modeled after commit 348659337485 ("net: mdio: Add
workaround for Micrel PHYs which are not C45 compatible"). However,
I find the name SMSC_OUI somewhat misleading as the value is not the
full OUI (0x00800f) but, just the OUI part of phy_id, which is quite
different.

 drivers/net/phy/mdio_bus.c | 3 ++-
 include/linux/smscphy.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..63f1c42fbc8d 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -31,6 +31,7 @@
 #include <linux/reset.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <linux/smscphy.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -632,7 +633,7 @@ static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 			continue;
 		oui = phydev->phy_id >> 10;
 
-		if (oui == MICREL_OUI)
+		if (oui == MICREL_OUI || oui == SMSC_OUI)
 			return true;
 	}
 	return false;
diff --git a/include/linux/smscphy.h b/include/linux/smscphy.h
index 1a6a851d2cf8..069d6d226abd 100644
--- a/include/linux/smscphy.h
+++ b/include/linux/smscphy.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_SMSCPHY_H__
 #define __LINUX_SMSCPHY_H__
 
+#define SMSC_OUI 0x01f0
+
 #define MII_LAN83C185_ISF 29 /* Interrupt Source Flags */
 #define MII_LAN83C185_IM  30 /* Interrupt Mask */
 #define MII_LAN83C185_CTRL_STATUS 17 /* Mode/Status Register */
-- 
2.39.2


