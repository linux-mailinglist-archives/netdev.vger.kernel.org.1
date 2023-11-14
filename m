Return-Path: <netdev+bounces-47661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51727EAEED
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F40281139
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347402D624;
	Tue, 14 Nov 2023 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UeNHFzoc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14723744;
	Tue, 14 Nov 2023 11:29:00 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160131BC3;
	Tue, 14 Nov 2023 03:28:53 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855CE60003;
	Tue, 14 Nov 2023 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1699961332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLcv2U5/tJBWHcDOVIYyQDAJQb5WKSZvw4UjIoMJnco=;
	b=UeNHFzoca1jxUrPL+28Ae9JWb/zm78O+AOPDkYg+wTysnLLAkXJGFc59Xt3o88b3hWU32c
	s7RQrOWZLOlDKjHYXRzrvp2IB5c1nkB1ue567XbrjXplnMqzyyuC2ctGi5FVDdBR2dxi6Z
	RP72IKdPjeWixKv6iE4CZeAWLHErtyIFZ1pqQceRFlQ5mP0i20Tyx6mqF9VqiHPpnYx27a
	pcALGz3SQ7ppzvCrmvVUIqZza7EUw1RJH3RZtXBLX0ZOkKjYI4Zwo0hqgvKZGSHBJOsZlR
	j6t0dcecd570rhwx/Sp6f8Pf6vHXUJUNhgtCn8CJEzbXIz+QbvVw6RCwS+BuDg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 14 Nov 2023 12:28:30 +0100
Subject: [PATCH net-next v7 02/16] net: phy: Remove the call to
 phy_mii_ioctl in phy_hwstamp_get/set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-feature_ptp_netnext-v7-2-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
In-Reply-To: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
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
X-Mailer: b4 0.12.4
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


