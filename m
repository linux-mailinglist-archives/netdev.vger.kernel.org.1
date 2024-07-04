Return-Path: <netdev+bounces-109103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E8926EDD
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 07:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AE7282582
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 05:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB93145FE3;
	Thu,  4 Jul 2024 05:31:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B11A01C6
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720071108; cv=none; b=Q2lvjdyE0jncP6vo9tM2EniSDoeoLSZkwvhiTol7QrvJtdLVG5+4JscoL6p0eSbAJyVazywmkP98HN0ToEEUoqtjPq4F3PfDDVcvEklBnHGcMugK+k9bq6LxsFpA4116QZBq+q5oQc6dsQqEhUZgSt2wAIGob8BNXpKMJ5ck1OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720071108; c=relaxed/simple;
	bh=rlGldafzlFQWpbGFHgU8CcT+HW2mEfWYczTGITohZZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOE40N+aeEEHqkKDIV+GzqMgXZMA9UosWYxTU4Gmfs/9U1NBDFI0HidIoZnn3QnvBrtlUpTzCsavE80aUO+BrlucOlgNITwcfYcIwAhX8UmYg/EW4VGm16BLkc20W0iXKl/8pv2Js2ODS2S/gfB8XdaXCZRm2MWOf9akyN1pM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPF43-0002CQ-Vi; Thu, 04 Jul 2024 07:31:27 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPF41-00714q-4V; Thu, 04 Jul 2024 07:31:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPF41-0043o5-0E;
	Thu, 04 Jul 2024 07:31:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v2 1/1] net: phy: microchip: lan87xx: reinit PHY after cable test
Date: Thu,  4 Jul 2024 07:31:23 +0200
Message-Id: <20240704053123.967930-1-o.rempel@pengutronix.de>
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

Reinit PHY after cable test, otherwise link can't be established on
tested port. This issue is reproducible on LAN9372 switches with
integrated 100BaseT1 PHYs.

Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
changes v2:
- add Reviewed-by: Andrew Lunn <andrew@lunn.ch>
- drop microchip specific SQI fix

 drivers/net/phy/microchip_t1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a838b61cd844b..a35528497a576 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -748,7 +748,7 @@ static int lan87xx_cable_test_report(struct phy_device *phydev)
 	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
 				lan87xx_cable_test_report_trans(detect));
 
-	return 0;
+	return phy_init_hw(phydev);
 }
 
 static int lan87xx_cable_test_get_status(struct phy_device *phydev,
-- 
2.39.2


