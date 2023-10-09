Return-Path: <netdev+bounces-39214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4927BE56A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6341C20C25
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212237C81;
	Mon,  9 Oct 2023 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EBVAcZGQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F23374DE
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:51:54 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9989F;
	Mon,  9 Oct 2023 08:51:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EDE01C0013;
	Mon,  9 Oct 2023 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696866711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d10ol8bgQXRCQ3CN2K11usb0w6nOmBYdHJPNNd1RZzA=;
	b=EBVAcZGQOgfR3e24L5o1/MyUk//goW/HWM+hPvBZNWpBxJrgTtvw8dqQf54U1i4BPYp4BA
	t9ciHAM6nos42a6p9r29lyAz1GqSzzLenWVcLPQRxqQDpTwzaO94vaz6BA82IFYjDUztzc
	sbyvOKm/7aRL+DbRCIu9dOaNMcy9Y9GZkZDDJN0xEMJh4OR/oSTLonFHf/Kr3pTotx6AvZ
	Mv4C6jiLy3zJM6tyCknjOEgCykzkmgO8hUto1tyYh/BR1gB2Q3AKYo3xkBjXSItyf61CWw
	gbjRPYf+drzJRNIlH6QUX7KcJC0Md1AVSB95rTbePn+rENLQUl1J00c1b8jvbA==
From: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <michael@walle.cc>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 02/16] net: phy: Remove the call to phy_mii_ioctl in phy_hwstamp_get/set
Date: Mon,  9 Oct 2023 17:51:24 +0200
Message-Id: <20231009155138.86458-3-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231009155138.86458-1-kory.maincent@bootlin.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kory Maincent <kory.maincent@bootlin.com>

__phy_hwtstamp_set function were calling the phy_mii_ioctl function
which will then use the ifreq pointer to call the hwtstamp callback.
Now that ifreq has been removed from the hwstamp callback parameters
it seems more logical to not go through the phy_mii_ioctl function and pass
directly kernel_hwtstamp_config parameter to the hwtstamp callback.

Lets do the same for __phy_hwtstamp_get function and return directly
EOPNOTSUPP as SIOCGHWTSTAMP is not supported for now for the PHYs.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
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


