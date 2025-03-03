Return-Path: <netdev+bounces-171656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F322AA4E0A4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BA6176675
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10033204874;
	Tue,  4 Mar 2025 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VG2XsZ7u"
X-Original-To: netdev@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A774249E5
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097980; cv=fail; b=o8F1jloiiZ0XuQ27wXaUeHXb7Tzrf3S98ISGVHjN8zdncNIumRwFhBuGshOYevMyNdLmnseHXgeNDwFz69thP4/7I7ilowYU+Hcp1Ul5RUoSw4pKHhSWsaYy1aeO64A1SErcKv64UZ2lrIvRdcbWjtKA5hJgxWqCwhfW+0As2HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097980; c=relaxed/simple;
	bh=EjwgMwBJl2fnigMFPNcLMyqu4I+t+bjTT8Y2E0i8A2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWoHbXd1HN8jT8INIdg1Pxr6h6lLRTB7ET9TDftkCEffUNjYpMWN5lhuKDBHzDNiwo/dRqfneCKaS/249HPVxaZpaq7jPdPiOVKYRNGg8iWwO3Y13g4TqxJJ1yZi8DVAuLbqApz0f0xNVtfwFxclmoJuRaMHVMdBX7Xv2KH6cBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VG2XsZ7u reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.196; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 4D70A40B267F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:19:37 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6d6w45PNzFwBZ
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:17:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id BB4B942720; Tue,  4 Mar 2025 17:17:05 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VG2XsZ7u
X-Envelope-From: <linux-kernel+bounces-541225-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VG2XsZ7u
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 0337F42000
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:06:42 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 8EC683064C08
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:06:42 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264FD3B1E59
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DF71F1524;
	Mon,  3 Mar 2025 09:03:44 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6301F03EE;
	Mon,  3 Mar 2025 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992620; cv=none; b=qpYwmMYWEWNxlCkI7kAiWy7H2+AKGA7+xzhNmzTCxTF4pSyG0abHlkqAC+m6AOJF1T5aJT15aaRZVp7EIWMxbHMeVo8AxhVc+sExPG7mx7zX8Nezp5xIzy7IWTXfQtpZkKl2rFlZWP92Z5Rccjpc9PBcig89m+BRuzY/jPLB1MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992620; c=relaxed/simple;
	bh=hUPYjdytdcjvDyS2DBpJBLgpc5YMrxtXIn0PgXQ7wXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/M23FHtwKwHpKbc6MWdYeZ5dfgZlXS4YDBMnFj4ZCbBnXllPwHDOIamtvjot6dfKJDslc6tbfZi8eyrmFDisdmm3sH7yu6niOatKwGLsicp6Lg5Mn/NBEBWCSMkghNcRq2g0K/KDHa625vM5FNn3OYUAyx/XN01vVdqv/BXGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VG2XsZ7u; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25520443D8;
	Mon,  3 Mar 2025 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou+5TKwlXnemGojT+v6CPhGH/dwrcUa5RZQyuD4EgBM=;
	b=VG2XsZ7uHc74dz3vR5TyQvBlAqFmf0LnBXIFI99yc/Bkurl1vBhINFgxUamG6+cYZTN6a4
	FMM5J76ZaVtmqn+/67sh+otyntgqSbJ52vY2LLYrPpdbwRwIznnJm+yksUJhImBMnghWnu
	s6AJDdFG27mblFlTJiP7Umn2hgAQwulCU4wc99Sv6CJ7kOlOn6677QO3QYhzB3zU0kE/9L
	cylpaweSIkmubcXoh6cfN70LvFdnoqk2ODLRByyqKrhU2VlWJo6uV5VbpcTFcKqAPgIajC
	6dezxmNnkxiHVygPLxrSPhZ+jhGga766Nw0WSt9NAwLllcduDmAiEC2Vm/o2zA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 08/13] net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
Date: Mon,  3 Mar 2025 10:03:14 +0100
Message-ID: <20250303090321.805785-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6d6w45PNzFwBZ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741702720.86573@ZhSSIoE3Qu3y5zYhs6PI0Q
X-ITU-MailScanner-SpamCheck: not spam

When configuring PHY advertising with autoneg disabled, we lookd for an
exact linkmode to advertise and configure for the requested Speed and
Duplex, specially at or over 1G.

Using phy_caps_lookup allows us to build a list of the supported
linkmodes at that speed that we can advertise instead of the first mode
that matches.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: No changes

 drivers/net/phy/phy_device.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 9c573555ac49..57b90ec6477e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2357,7 +2357,7 @@ EXPORT_SYMBOL(genphy_check_and_restart_aneg);
 int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
-	const struct phy_setting *set;
+	const struct link_capabilities *c;
 	unsigned long *advert;
 	int err;
=20
@@ -2383,10 +2383,11 @@ int __genphy_config_aneg(struct phy_device *phyde=
v, bool changed)
 	} else {
 		linkmode_zero(fixed_advert);
=20
-		set =3D phy_lookup_setting(phydev->speed, phydev->duplex,
-					 phydev->supported, true);
-		if (set)
-			linkmode_set_bit(set->bit, fixed_advert);
+		c =3D phy_caps_lookup(phydev->speed, phydev->duplex,
+				    phydev->supported, true);
+		if (c)
+			linkmode_and(fixed_advert, phydev->supported,
+				     c->linkmodes);
=20
 		advert =3D fixed_advert;
 	}
--=20
2.48.1



