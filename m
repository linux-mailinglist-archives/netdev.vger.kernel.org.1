Return-Path: <netdev+bounces-250345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990DAD294B6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3FA302A445
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453C3242AD;
	Thu, 15 Jan 2026 23:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719C2BFC70;
	Thu, 15 Jan 2026 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520462; cv=none; b=p7mJhQHDQfvp8onJ6XibTHJqcuk/fJgZDY/jhbUTcYdND0+U+CRgTDXNtd/YQI1KdKk4i5YR74hfBJZfqmL46cATZ/07KtlMHDWsg5XSnWhb26fDw/jSKHpcOx2JMdeC0xejLGrofuiJySAJAfOynmbaNyqgNTVtl9xtGGby3xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520462; c=relaxed/simple;
	bh=wEb5f+AzzsZFSKAmHOZoXb5phzxvR13dr0Z9GnIgw9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9f2ffXLnJzmOBLvg9FM7jmtEpYxdOB955E9Ty3dmyaNpIfWHET5wyu+EdZ07wYKgMbg1EkL3qx9KmqCmiYvQi9a1xzhSEH8tIRDzpc88u0QRIXRuQLUBbr0NPaZkSfTNgXxdhlIQP/VzSGI8WVzC4ftTOSASA0GeDikHBaGqAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgWxL-000000007RA-44pc;
	Thu, 15 Jan 2026 23:40:48 +0000
Date: Thu, 15 Jan 2026 23:40:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next] net: phy: intel-xway: workaround stale LEDs before
 link-up
Message-ID: <d70a1fa9b92c7b3e7ea09b5c3216d77a8fd35265.1768432653.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Due to a bug in some PHY internal firmware, manual control as well as
polarity configuration of the PHY LEDs has no effect until a link has
been detected at least once after reset. Apparently the LED control
thread is not started until then.

As a workaround, clear the BMCR_ANENABLE bit for 100ms to force the
firmware to start the LED thread, allowing manual LED control and
respecting LED polarity before the first link comes up.

In case the legacy default LED configuration is used the bug isn't
visible, so only apply the workaround in case LED configuration is
present in the device tree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/intel-xway.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 9766dd99afaa0..37150115c8edb 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016 Hauke Mehrtens <hauke@hauke-m.de>
  */
 
+#include <linux/delay.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -286,8 +287,33 @@ static int xway_gphy_config_init(struct phy_device *phydev)
 		return err;
 
 	/* Use default LED configuration if 'leds' node isn't defined */
-	if (!of_get_child_by_name(np, "leds"))
+	if (!of_get_child_by_name(np, "leds")) {
 		xway_gphy_init_leds(phydev);
+	} else {
+		/* Due to a bug in some PHY internal firmware, manual control
+		 * as well as polarity configuration of the PHY LEDs has no
+		 * effect until a link has been detected at least once after
+		 * reset. Apparently the LED control thread is not started
+		 * until then.
+		 *
+		 * Workaround: clear the BMCR_ANENABLE bit to force the firmware
+		 * to start the LED thread, allowing manual LED control and
+		 * respecting LED polarity before the first link comes up.
+		 *
+		 * In case the default LED configuration is used the bug isn't
+		 * visible, so only apply the workaround in case LED
+		 * configuration is present in the device tree.
+		 */
+		phy_clear_bits(phydev, MII_BMCR, BMCR_ANENABLE);
+		/* 100ms was found to be required by experimentation.
+		 * A shorter delay causes other (serious) bugs...
+		 */
+		msleep(100);
+		/* It turns out BMCR_ANENABLE *has* to be set when removing
+		 * BMCR_PDOWN for not facing yet different bugs
+		 */
+		phy_set_bits(phydev, MII_BMCR, BMCR_ANENABLE);
+	}
 
 	/* Clear all pending interrupts */
 	phy_read(phydev, XWAY_MDIO_ISTAT);
-- 
2.52.0

