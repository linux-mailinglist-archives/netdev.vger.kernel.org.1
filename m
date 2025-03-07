Return-Path: <netdev+bounces-173060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59513A57077
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8263B888F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424C24EAAE;
	Fri,  7 Mar 2025 18:24:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53B24DFF3
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371890; cv=none; b=qkBsB3UHEjs+2DJAoxKWFG2x8AbfnkzSpO5PI3tnKhBRQUX3axRpwAnuDmZzfh6CMv5T5smMpKTsotHr/VuIudeCa1ioXSY0TnOFJmcUWtXM8+J2cq8yBfWGQpzClbgocN7/6WMHidu4dBANP3Ru3/aE+Tijg9DUAFvDOwOUft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371890; c=relaxed/simple;
	bh=vGDSlh9ZY+40JvXkJEt8xx3jlYVo3VcvOYyL7OPzKVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WK5mc8u0oWrRMeYIL7g4Hjg228yznYLn1/Bbt1HYxj8iG3AOt7Mf0JtzCBitf0O/uuC/PyW869pekqTtetXFalq5Blq6ca4ssI14pOsmMonGmUCl8kNze07Qqo56y8p2Flg/9vgKRREWRhvotanOm/a9WfewZSaEj5Qq0vpke7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005mb-4w; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2T-1g;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I8S-1R;
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
Subject: [PATCH net-next v2 2/7] net: usb: lan78xx: Move fixed PHY cleanup to lan78xx_unbind()
Date: Fri,  7 Mar 2025 19:24:27 +0100
Message-Id: <20250307182432.1976273-3-o.rempel@pengutronix.de>
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

Move the cleanup of the fixed PHY to the lan78xx_unbind() function,
which is invoked during both the probe and disconnect paths.  This
change eliminates duplicate cleanup code in the disconnect routine and
ensures that the fixed PHY is properly freed during other probe steps.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 01967138bc8c..4efe7a956667 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2688,8 +2688,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	ret = phylink_connect_phy(dev->phylink, phydev);
 	if (ret) {
-		netdev_err(dev->net, "can't attach PHY to %s\n",
-			   dev->mdiobus->id);
+		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
+			   dev->mdiobus->id, ERR_PTR(ret));
 		return -EIO;
 	}
 
-- 
2.39.5


