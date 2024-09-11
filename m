Return-Path: <netdev+bounces-127577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72C975C68
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF911C21694
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616C1BC08D;
	Wed, 11 Sep 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="STJeG49S"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4661B532D;
	Wed, 11 Sep 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090050; cv=none; b=ZFGE0qXDh+9ox5Ez5vvWY5rOdsYvqJBs0KSsYUHhBJ2/5AzmokvEv+fw+Ge/M7XcW1OuHzUpOP69s2k3IiXD8uVpGVnw7mo7cgaoxDAjrZ9xO+goZgFGVYl+8NfmfkbZCKprS1dd5sYBd1TfU9K7DUUlpqj3BztyLcdda6ALTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090050; c=relaxed/simple;
	bh=AGeYrtRHeX5v4s4i46Ax+5MkFG9TJXzm9Vs49DsFi5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a62rb+cP0xsYaqBMWON3yJ+QCk/VFt5FwhY1Td4Gv10mCG/6xMXVosJy/kSng3dspN+7Cf3hybwXfr4zbETwZcgsFdyR+EfG6K/90/GY7I98c9zM8rjuV6hXx1C9ingb+PztxTtit6Igl1Zv+T4X32HuKb51NUwuIVhyrUvbPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=STJeG49S; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40A321C0006;
	Wed, 11 Sep 2024 21:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpnVXCGpzg8hKqd/cYNHTq4PwBhP9+SSj5neYt5kd/M=;
	b=STJeG49ScfgmHR/SVqSBb4CbUMUsN9gDTA7yrzwfVGz9f8mnlIkqxkDWLLdngWBStaUMca
	Cy3nwPKET+P8w/V4d3nTDwDlbQJ88XKea6pOO/54KJqRw/890q9A22/3UGOGUoFl10RAvI
	CROGkPBaRgUBTmrDzKZWVhL+ubYZvBNc7lj1S4s5BsKUEEhRGD4X83OyKjY8oS2FwVYX9U
	gKweNOnmUQuTNH+OWmv0SVsaZaPZCuZHmybCKyZ96sNZuEbfCiQ6FKyxUmOjVm3iP9L66U
	UlGhSnYPSCks6hXq5pervRRW/6YkhA0/TQ9s85TcJQp7wjub5pK+srlYBNR7yQ==
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
Subject: [PATCH net-next 3/7] net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
Date: Wed, 11 Sep 2024 23:27:07 +0200
Message-ID: <20240911212713.2178943-4-maxime.chevallier@bootlin.com>
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

Testing showed that PHYs from the LXT973 family have a non-working
isolate mode, where the MII lines aren't set in high-impedance as would
be expected. Prevent isolating these PHYs.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/lxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index e3bf827b7959..55cf67391533 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -334,6 +334,7 @@ static struct phy_driver lxt97x_driver[] = {
 	.read_status	= lxt973a2_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	.flags		= PHY_NO_ISOLATE,
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973",
@@ -344,6 +345,7 @@ static struct phy_driver lxt97x_driver[] = {
 	.config_aneg	= lxt973_config_aneg,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	.flags		= PHY_NO_ISOLATE,
 } };
 
 module_phy_driver(lxt97x_driver);
-- 
2.46.0


