Return-Path: <netdev+bounces-237588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF07C4D7A5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E8E189C0E8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F5357739;
	Tue, 11 Nov 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QqCXAgxk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAD3596E7
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861134; cv=none; b=X5MNP/Tm9Ky46Wumxht96YpM3GSZbO7eTC5sYP1m8Y9qmBickWVJHv4yem2XusrYpB5J5GdJSSDOTsoelDFqOoFMpcDBf5tNyC9OTZV6TcnStsId3zxm+X0h7VX+YoJQAm1aKG4Ad3pb0THI563wkuCQ7znYRcPSjDpV7tdWTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861134; c=relaxed/simple;
	bh=xQtCxnBpva1cRVN7739zOiOlQsRNQlgYmbo9Jp/ApF4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jHztYMZGx0F5DyeBfL7mjuNSQk6t2K0gY+8s2WRlJFUfYWzAQKdCl7QNn6P/Ym8p7sw3UlUz5LBHuetiiKaMSKsQWYX+gYpbQWVBwYgeIW+cV+cf17hW8Q9m0Xt+ddhJ4kubKIZt7ZN0gEiTyIu0xFErAYyeBgy/5RMWupoCj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QqCXAgxk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LzZTRHGFeZQDzRWNR9GBT8BOarftkiD6LvxUlj+Thsk=; b=QqCXAgxk3Ez2OODXm99IywT2e6
	bRIY0OwIvJtvYp3St6HvkDaQ5KRsb9+vTw2oFurANdsmnsejn2YJfBlDosNrp+E7ATThrrrWCFXRZ
	D8kZD0KBqS+iriTD0JgBaqmLqiafnJCLj8EKIV2XvA9rByaF7xfCq7UK4/X4OMnBksNhOErlXOqhM
	u8dWwmwKgnLL0eh5Q2ZV66SkrbThY51XDGJ6U6QIpeCECrwKa2b/q6+SnE0b5pTYvwrCLwSHtfA3D
	5ilrCjeRkPj0aJqgHrGVFQhKXKvPw55mS2s1NWl/ytHzroDUhia1G1+6FAl5s3HzF5TaVpq+uVFgf
	pAWOxAEw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50876 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vImhx-000000002W7-1NqJ;
	Tue, 11 Nov 2025 11:38:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vImhv-0000000DrQi-49UR;
	Tue, 11 Nov 2025 11:38:44 +0000
In-Reply-To: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
References: <aRMgLmIU1XqLZq4i@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/2] net: phy: TI PHYs use phy_get_features_no_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vImhv-0000000DrQi-49UR@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 11 Nov 2025 11:38:43 +0000

As TI Gigabit PHYs do not support EEE, use the newly introduced
phy_get_features_no_eee() to read the features but mark EEE as
disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/dp83822.c   | 3 +++
 drivers/net/phy/dp83867.c   | 1 +
 drivers/net/phy/dp83869.c   | 1 +
 drivers/net/phy/dp83tc811.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 33db21251f2e..20caf9a5faa7 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -1160,6 +1160,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp83822_probe,		\
+		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83822_config_init,		\
 		.read_status	= dp83822_read_status,		\
@@ -1180,6 +1181,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp8382x_probe,		\
+		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83825_config_init,		\
 		.get_wol = dp83822_get_wol,			\
@@ -1196,6 +1198,7 @@ static int dp83822_led_hw_control_get(struct phy_device *phydev, u8 index,
 		.name		= (_name),			\
 		/* PHY_BASIC_FEATURES */			\
 		.probe          = dp83826_probe,		\
+		.get_features	= phy_get_features_no_eee,	\
 		.soft_reset	= dp83822_phy_reset,		\
 		.config_init	= dp83826_config_init,		\
 		.get_wol = dp83822_get_wol,			\
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 36a0c1b7f59c..da055ff861be 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1124,6 +1124,7 @@ static struct phy_driver dp83867_driver[] = {
 		/* PHY_GBIT_FEATURES */
 
 		.probe          = dp83867_probe,
+		.get_features	= phy_get_features_no_eee,
 		.config_init	= dp83867_config_init,
 		.soft_reset	= dp83867_phy_reset,
 
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..4400654b0f72 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -906,6 +906,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	PHY_ID_MATCH_MODEL(_id),				\
 	.name		= (_name),				\
 	.probe          = dp83869_probe,			\
+	.get_features	= phy_get_features_no_eee,		\
 	.config_init	= dp83869_config_init,			\
 	.soft_reset	= dp83869_phy_reset,			\
 	.config_intr	= dp83869_config_intr,			\
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index e480c2a07450..92c5f3cfee9e 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -390,6 +390,7 @@ static struct phy_driver dp83811_driver[] = {
 		.phy_id_mask = 0xfffffff0,
 		.name = "TI DP83TC811",
 		/* PHY_BASIC_FEATURES */
+		.get_features = phy_get_features_no_eee,
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
 		.soft_reset = dp83811_phy_reset,
-- 
2.47.3


