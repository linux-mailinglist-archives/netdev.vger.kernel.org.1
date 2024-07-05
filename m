Return-Path: <netdev+bounces-109476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62D92898A
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0410E284377
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E2714F126;
	Fri,  5 Jul 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UJyhyfg9"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4414AD2B;
	Fri,  5 Jul 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186036; cv=none; b=B2ibQDXVfOLOMU1eDcy9YPEQdXKjQCXd8fqpL+577tRoMdpAfXYKe+ZGMVuHDeoYHcXcWa4ayqmUziZQrNBMaiWuWimGoqkAeYSMSXglh4KtNVp/qIH+BmnT1+tMv5fFlq1l7mAaQDnX0w6sXFFo4FmK2uR/IFoV7JiWXMZD1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186036; c=relaxed/simple;
	bh=5BdBXIXEzFrbHYhpcVl6eMdnlDRUioudERWqgerSkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMmEEiXrXFNrM87532HuXzZcWcvZdoIrNulp6xav21K975XlX+Y7nJ4wochJZwnuwZmYHgMX4HEur/nX0HcQh4Vrtq83ZaXeezCiESC3qsqAqVOnGOGFJU8Yv6z8oKV0JXUUavDdHaTpnt9mA4IFoIQCje8LyylHF48sA+ugycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UJyhyfg9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 09CED1C0007;
	Fri,  5 Jul 2024 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720186032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExlAtdZOJ3MJY+x/PWgU0kHD6RtR8Zc2j85IcnrS0W4=;
	b=UJyhyfg9jWQ8tSSYq12F16UXKlRRD2sISjORcEE6kBfbuwqbpG6PXrMA0BTTKkBooLokbb
	MbM3W/q+ZJ0kzQA+o7GOiuUCVg3sDdgXpyxgEERmIIQbDQduHR5yNIlzzVSzqUxGzlZqIa
	A3iYTnPsQ4I5FdK8u0FAhoRfQpi6x+PBx38hsCqdK2roskIDzQ40BzB3qdapOLsAAbhUgt
	uRmgmy9J0ucyUYyNF81zVQfplHeIqUWCMkowaPIvlOp0lX1/qlW878qjcCuIPNEizkPLaa
	2uXAjZrMlr7YlQkCF3+imogctjPE7kzvhgQ8HpOIgjprmhzH7vsjEX2tiB0Ozg==
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v16 02/14] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
Date: Fri,  5 Jul 2024 15:26:53 +0200
Message-ID: <20240705132706.13588-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
References: <20240705132706.13588-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Pass the phy_device as a parameter to the sfp upstream .disconnect_phy
operation. This is preparatory work to help track phy devices across
a net_device's link.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phylink.c | 3 ++-
 drivers/net/phy/sfp-bus.c | 4 ++--
 include/linux/sfp.h       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 51c526d227fa..ab4e9fc03017 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3423,7 +3423,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	return ret;
 }
 
-static void phylink_sfp_disconnect_phy(void *upstream)
+static void phylink_sfp_disconnect_phy(void *upstream,
+				       struct phy_device *phydev)
 {
 	phylink_disconnect_phy(upstream);
 }
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 2f44fc51848f..56953e66bb7b 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -487,7 +487,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 			bus->socket_ops->stop(bus->sfp);
 		bus->socket_ops->detach(bus->sfp);
 		if (bus->phydev && ops && ops->disconnect_phy)
-			ops->disconnect_phy(bus->upstream);
+			ops->disconnect_phy(bus->upstream, bus->phydev);
 	}
 	bus->registered = false;
 }
@@ -743,7 +743,7 @@ void sfp_remove_phy(struct sfp_bus *bus)
 	const struct sfp_upstream_ops *ops = sfp_get_upstream_ops(bus);
 
 	if (ops && ops->disconnect_phy)
-		ops->disconnect_phy(bus->upstream);
+		ops->disconnect_phy(bus->upstream, bus->phydev);
 	bus->phydev = NULL;
 }
 EXPORT_SYMBOL_GPL(sfp_remove_phy);
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index b14be59550e3..54abb4d22b2e 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -550,7 +550,7 @@ struct sfp_upstream_ops {
 	void (*link_down)(void *priv);
 	void (*link_up)(void *priv);
 	int (*connect_phy)(void *priv, struct phy_device *);
-	void (*disconnect_phy)(void *priv);
+	void (*disconnect_phy)(void *priv, struct phy_device *);
 };
 
 #if IS_ENABLED(CONFIG_SFP)
-- 
2.45.1


