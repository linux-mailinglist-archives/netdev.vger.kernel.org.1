Return-Path: <netdev+bounces-42667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC67CFC8B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E85282160
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED902FE14;
	Thu, 19 Oct 2023 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ij3j/CTi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C22AB5B;
	Thu, 19 Oct 2023 14:29:45 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3AA119;
	Thu, 19 Oct 2023 07:29:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7527A60004;
	Thu, 19 Oct 2023 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1697725782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLcv2U5/tJBWHcDOVIYyQDAJQb5WKSZvw4UjIoMJnco=;
	b=Ij3j/CTi+ULBqRLsOa3XYt71BVUJlYUwYm01CUtgNBboUfUX4Jc+GiMLIqYoQzklhsFR47
	daVnAx59wx+o4YsMICB6sSTMwp94gkGEwzvxUI5nkgNgF4GloaI56kg8nJxfZop5a4hudu
	o915NnGDC1iMHXLMBlfAVVI66T0hNGzLkaM1l+8hANBkEL6/OQowSHwyjqTAk1jDxRrSvX
	EHqIrNIuVvklbCioJ2BBRwSzwEel7Tsh8fR3yMxSN512QPaw7ndMFMhvUCX8ybtn3AvBwr
	5t6ZHHW5N5fR9oW2Sceop8lKr3fF+ld+u3VqOIjwwzaNYzAjH9MWHySWm7QEbg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 19 Oct 2023 16:29:17 +0200
Subject: [PATCH net-next v6 02/16] net: phy: Remove the call to
 phy_mii_ioctl in phy_hwstamp_get/set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-feature_ptp_netnext-v6-2-71affc27b0e5@bootlin.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
In-Reply-To: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: kory.maincent@bootlin.com

__phy_hwtstamp_set function were calling the phy_mii_ioctl function
which will then use the ifreq pointer to call the hwtstamp callback.
Now that ifreq has been removed from the hwstamp callback parameters
it seems more logical to not go through the phy_mii_ioctl function and pass
directly kernel_hwtstamp_config parameter to the hwtstamp callback.

Lets do the same for __phy_hwtstamp_get function and return directly
EOPNOTSUPP as SIOCGHWTSTAMP is not supported for now for the PHYs.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d058316666ba..3376e58e2b88 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -486,7 +486,7 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
-	return phy_mii_ioctl(phydev, config->ifr, SIOCGHWTSTAMP);
+	return -EOPNOTSUPP;
 }
 
 /**
@@ -503,7 +503,10 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 	if (!phydev)
 		return -ENODEV;
 
-	return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
+	if (phydev->mii_ts && phydev->mii_ts->hwtstamp)
+		return phydev->mii_ts->hwtstamp(phydev->mii_ts, config, extack);
+
+	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.25.1


