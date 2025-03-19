Return-Path: <netdev+bounces-176040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4EAA6873A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F5917E911
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964E2528EA;
	Wed, 19 Mar 2025 08:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C0251791
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374206; cv=none; b=LO2MQi36c17QHuWEPj0wfXyU5TC4OyhHRJNzoVWFZvZ1rB3eXNBpeJzGyjbU0KJxH1Aq3BadW2ZFVykwl4pZCLlJgm3Qb7Xyz1AhNE3LMMXQ+sYSK+fiC20E9goGar4w1PX/9pfH+gZKhf4kT1GsFcoPUSw+I44cDX4MlySvAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374206; c=relaxed/simple;
	bh=u6KOH7D2HZj1gxx/RvBa0JFQOXSStUcT6rpl8XrQpck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wjd2LnDjDnLyHV3cN8cQXgADuvnQKXp4MA+RR4K8CWGG8RQ62bprCqAebBqv1YOtaId7z1z20gbaiJU7Z1FgP51tr0vNtiZYrAjbECip/RrXbh/pYeRX+AKcilv95bQuwFjZlBjL2+7pkAdtkZVN+TFhEJHsPKlfdS7OxnWEugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7b-0008Ot-VX; Wed, 19 Mar 2025 09:49:55 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-000Z4P-0h;
	Wed, 19 Mar 2025 09:49:53 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tup7Z-001l1s-1o;
	Wed, 19 Mar 2025 09:49:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 3/6] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
Date: Wed, 19 Mar 2025 09:49:49 +0100
Message-Id: <20250319084952.419051-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319084952.419051-1-o.rempel@pengutronix.de>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
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

Replace the custom lan78xx_get_link implementation with the standard
ethtool_op_get_link helper, which uses netif_carrier_ok to reflect
the current link status accurately.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/usb/lan78xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index fd6e80f9c35f..6a6e965ec27f 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1835,18 +1835,6 @@ static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
 	return ret;
 }
 
-static u32 lan78xx_get_link(struct net_device *net)
-{
-	u32 link;
-
-	mutex_lock(&net->phydev->lock);
-	phy_read_status(net->phydev);
-	link = net->phydev->link;
-	mutex_unlock(&net->phydev->lock);
-
-	return link;
-}
-
 static void lan78xx_get_drvinfo(struct net_device *net,
 				struct ethtool_drvinfo *info)
 {
@@ -1966,7 +1954,7 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-	.get_link	= lan78xx_get_link,
+	.get_link	= ethtool_op_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
 	.get_drvinfo	= lan78xx_get_drvinfo,
 	.get_msglevel	= lan78xx_get_msglevel,
-- 
2.39.5


