Return-Path: <netdev+bounces-127578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94828975C69
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101D0B2032A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6EA1BC09F;
	Wed, 11 Sep 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WtvCvv6/"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804091B9B45;
	Wed, 11 Sep 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090050; cv=none; b=cEfVahnCyEEOGXxQBQlm+tJ0d+Oank0ATl/1IeCgMhqUyiK+10Y5LgU7z56xJgAVqQV5HoVHzssTqHlPH1H8dC+6FhnxpqIsKc1sM/Gql1XVGoyehyfgFCeI5acG0fPgbbic9ml+t2oo9wgE2sUy9eMpVjaRT8mS0rOnH9niw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090050; c=relaxed/simple;
	bh=bX/7NEMB0erTJQ79eCExyrbTzgdjq2kQ7ang6pv/QWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/CdfOguEM+dsBysi303VDvBEw5A6LiBVZ3AFkGPJs7cRQMab6ZCOXD7kot25y+J8ehZXXzxq01sy4H/h3ph5oxvzIMvdtjbwEdGySN18CDq1QJm3rxvFiOoMUMsy32ob4ixHnqy+ZKdxXyKLaK39lLdywDFaW36A92DVzShFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WtvCvv6/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47F801C0008;
	Wed, 11 Sep 2024 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SokwzpJA0fMoxrnJj1s5WvcG+HbBKr5cR2wqdex0NKs=;
	b=WtvCvv6/l1+JEs6vC9UHmtj0nd4SGsyoR1RJEqAlLH86Ok2zgas/39ckL9zUynbOY/0gsk
	orboBpQUlfTcTKcB9w8NvbbAGHBl14y7nJneAmO6j6iRnt3sS7xDnf8IUU3K8SkechwWa0
	jXks+bFZewYzzTeae1FxtOhPy6YAVJAB0+307mMJJTabBNVio+wDcgY0S1udlujUI60onL
	W0iA9GlboolOYqpnzhXVU5Oy5BiFF9FMRX8tQXeI7KaW/6/DWci6eFjoC0vWJ1f/kP3ZCf
	pomr+HCSsGLwL64if3uC4y424kwA4qULlEaU6lrCSgZkLK77LOMJI3FSr0Z+Sg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 4/7] net: phy: marvell10g: 88x3310 and 88x3340 don't support isolate mode
Date: Wed, 11 Sep 2024 23:27:08 +0200
Message-ID: <20240911212713.2178943-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The 88x3310 and 88x3340 PHYs don't support the isolation mode,
regardless of the MII mode being used
(SGMII/1000BaseX/2500BaseX/5GBaseR/10GBaseR). Flag this in the driver.

This was confirmed on the 88x3310 on a MacchiatoBin.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 6642eb642d4b..867fd1451b3f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -1422,6 +1422,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_loopback	= genphy_c45_loopback,
 		.get_wol	= mv3110_get_wol,
 		.set_wol	= mv3110_set_wol,
+		.flags		= PHY_NO_ISOLATE,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88X3310,
@@ -1441,6 +1442,7 @@ static struct phy_driver mv3310_drivers[] = {
 		.set_tunable	= mv3310_set_tunable,
 		.remove		= mv3310_remove,
 		.set_loopback	= genphy_c45_loopback,
+		.flags		= PHY_NO_ISOLATE,
 	},
 	{
 		.phy_id		= MARVELL_PHY_ID_88E2110,
-- 
2.46.0


