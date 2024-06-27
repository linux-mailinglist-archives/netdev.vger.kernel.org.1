Return-Path: <netdev+bounces-107120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE2919EB1
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3481C2463F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70BD208CB;
	Thu, 27 Jun 2024 05:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DB5200CB
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719466455; cv=none; b=iQXvcGnzgRazppzaX2I0iPEiq2j+ZNKOyLQSMVN0LTRaoXmcUKGoBf927AbGY6YMGEJl4zEIYDONcc9w94IT6MgHXmpPqgaFIcANvdrw5zeSOT8ySBIN7CdXlYGZhaY3JZe+4v/Eudrs0Z7h0wRIQjtz1PWnHzmuc+odenXA6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719466455; c=relaxed/simple;
	bh=LYJA4gHG3laUJKh3RirWz+ba19Ae9E87C/vzol79nZI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E02TyGMOBJOkpMORrhvM9nc73tzsWuVci/Xm3HDpSdwzI2BhnfmmuSQECSXNztmJz+Wba7vOei556qrvmvV0aIkdyw8Ol3fGFoxRbs8Fa6Z8NFMkwoi43dy8VydjaNbOSRD2W4VFfztacJ0eHFKd/YO8snO/VyS3iNk4lLjsgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhlc-0004LN-AL; Thu, 27 Jun 2024 07:33:56 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhla-005IHZ-CJ; Thu, 27 Jun 2024 07:33:54 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMhla-005wRX-12;
	Thu, 27 Jun 2024 07:33:54 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net v1 1/1] net: phy: micrel: ksz8081: disable broadcast only if PHY address is not 0
Date: Thu, 27 Jun 2024 07:33:53 +0200
Message-Id: <20240627053353.1416261-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Do not disable broadcast if we are using address 0 (broadcast) to
communicate with this device. Otherwise we will use proper driver but no
communication will be possible and no link changes will be detected.
There are two scenarios where we can run in to this situation:
- PHY is bootstrapped for address 0
- no PHY address is known and linux is scanning the MDIO bus, so first
  respond and attached device will be on address 0.

The fixes tag points to the latest refactoring, not to the initial point
where kszphy_broadcast_disable() was introduced.

Fixes: 79e498a9c7da0 ("net: phy: micrel: Restore led_mode and clk_sel on resume")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 81c20eb4b54b9..67c2e611150d2 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -590,7 +590,7 @@ static int kszphy_config_init(struct phy_device *phydev)
 
 	type = priv->type;
 
-	if (type && type->has_broadcast_disable)
+	if (type && type->has_broadcast_disable && phydev->mdio.addr != 0)
 		kszphy_broadcast_disable(phydev);
 
 	if (type && type->has_nand_tree_disable)
-- 
2.39.2


