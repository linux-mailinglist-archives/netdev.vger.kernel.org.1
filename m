Return-Path: <netdev+bounces-175640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE26A66FDE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48A3B4F67
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAE12080F5;
	Tue, 18 Mar 2025 09:34:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E5207A35
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290463; cv=none; b=cbRL9knv5RtFmR9yAM2QqirPT/3OInt+c8ICwytfK4o93pRCc2iFgyiFOOscWpqUpzI2lqGbhgvbAXhU2niOhb8Y3P4wz6zxPI4fOKk3PcspnaVMeMG8NwR9I5MQW5tgydgJepaNm7hew7waaP/fENrcHFfu4ZlYWSbQbzl0xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290463; c=relaxed/simple;
	bh=upPek+ONT3s86n15tgnyqx28qIYrkYbImSWyYSzWRa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aPE52Oim/odJec2OVd7B6Ut6NaG2pcwGSWNsCMFFv2bEx92D2ktxPEQoAq7elilX20rvMHwA6/FxHMoXTPGQ2MfUY4k29wTdgjTEXCPTqNDET/BBOLKwn0petSlYL3ELZtSOIRQ4eNVyPimhTE/mD/xx7szQiRkXvCwpRKLFp8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yF-LW; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKs-000OyQ-39;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00Cmuk-0w;
	Tue, 18 Mar 2025 10:34:11 +0100
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
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 04/10] net: usb: lan78xx: improve error reporting on PHY attach failure
Date: Tue, 18 Mar 2025 10:34:04 +0100
Message-Id: <20250318093410.3047828-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318093410.3047828-1-o.rempel@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
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

Include error code in the log message when PHY attachment fails,
providing better debugging information.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- update commit message
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e54b1ac2c4fc..d2bc6cbdbb66 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2693,8 +2693,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
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


