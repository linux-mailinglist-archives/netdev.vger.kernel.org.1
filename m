Return-Path: <netdev+bounces-199056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F6ADEC4C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CADB3B0B47
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE382E974A;
	Wed, 18 Jun 2025 12:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588652E54D2
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249577; cv=none; b=Ju8vaCUL6/RmznSyxJMBnmuT4Lq/dHKJbqPxg9Ee1BTZ+UsGKeBi99O6VlZmkWiZU+3FV/H00MEbDJPtLTobEXfuYftkTJn/tH+KGyKG97ClWFp+WXIXaN9egjCU7S0RtODLOUtjenreRamy7JJa/KFlz7Z2JYpTFpWWKayNAtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249577; c=relaxed/simple;
	bh=pq0r+fx7fW+75RtNymzq+3FY8EA8Ax2oxTXhGJHBHYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l67hPwMoZhNyJxtLLjMciwIORmpk2aacclW/itpvKueI/vM952Fom3O2TfbYh3ft8rG4UyLlXL9ztSY5SvLrEXRaeKWMCrcZ2o4VKn3xsQ1a2l9eUWXPQP2frg1PuCmH1CCPSLSub0cJFXzjNyOqCYnMBIgBqNVDtN2sDCDz5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrg-00007j-UW; Wed, 18 Jun 2025 14:26:04 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-0048Us-1t;
	Wed, 18 Jun 2025 14:26:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uRrrf-00DFD8-1X;
	Wed, 18 Jun 2025 14:26:03 +0200
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
Subject: [PATCH net-next v8 3/6] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
Date: Wed, 18 Jun 2025 14:25:59 +0200
Message-Id: <20250618122602.3156678-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618122602.3156678-1-o.rempel@pengutronix.de>
References: <20250618122602.3156678-1-o.rempel@pengutronix.de>
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
index 18402a3922a6..9bb1d2527d0c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1839,18 +1839,6 @@ static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
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
@@ -1970,7 +1958,7 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-	.get_link	= lan78xx_get_link,
+	.get_link	= ethtool_op_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
 	.get_drvinfo	= lan78xx_get_drvinfo,
 	.get_msglevel	= lan78xx_get_msglevel,
-- 
2.39.5


