Return-Path: <netdev+bounces-173057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53479A57074
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87251898B83
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119F24BC07;
	Fri,  7 Mar 2025 18:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2B245031
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371888; cv=none; b=YxTWbi9U4jA5LLvNQ2YLH0XsIgHd/7AmLyFouCGH7rPP76bImYLhoxtc+v/W7CLp6IaDBoujkHFVDUgfy7Jn+cpr4TZvffZ0pDHn7B/ke5JtOI1d3WSurAU4ZuF95VEttT6BmMZr15eA0O7eVqTCh5jeR2yzW0kcveJy412Q2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371888; c=relaxed/simple;
	bh=OvVuyTfOggPfv1Lciq6OTJtzG4/Xy2eNFt5iXQmEVyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klUryMqmLETEhyG/Yv9wgKPuKq7ovX51vfTK1yBsgg9+fj6zfCr6QDNij4MrfV2eFtCb0lZA1I+yAFHV0JYvCY7w04rmkgXNsQcCjZGTSEE3FV2ITKsVX37+RhHywQ0HKxRgaS5ojCZ7ejjDpEAv//AACTl2Nu78AvYvPd/3/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005md-4x; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2W-1r;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I8m-1a;
	Fri, 07 Mar 2025 19:24:33 +0100
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 4/7] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
Date: Fri,  7 Mar 2025 19:24:29 +0100
Message-Id: <20250307182432.1976273-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307182432.1976273-1-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
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
---
 drivers/net/usb/lan78xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 68ca507b6412..224932d8134c 100644
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
@@ -2013,7 +2001,7 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-	.get_link	= lan78xx_get_link,
+	.get_link	= ethtool_op_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
 	.get_drvinfo	= lan78xx_get_drvinfo,
 	.get_msglevel	= lan78xx_get_msglevel,
-- 
2.39.5


