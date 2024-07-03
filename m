Return-Path: <netdev+bounces-108899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776909262EE
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1541F214C2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C0F17DA23;
	Wed,  3 Jul 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="geTFG3V6"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E86139D16;
	Wed,  3 Jul 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015697; cv=none; b=T/NAM4B0Rxq1ZEbr709yOMwZ1ZrLNXD1gAsO+924wBsm3LgWl84vHrYoG280JbZUoSFzYXaU4rJdfh5vgNZEGbLfe0W0g49bu5+E0ieBf63eW3Le/gEN8Q8ymv0Kb2peD4uwCACeundGC4JDlYnhKGLOG4Ze5RvJhluTjEob1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015697; c=relaxed/simple;
	bh=5BdBXIXEzFrbHYhpcVl6eMdnlDRUioudERWqgerSkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olY+2KuO43i+6DGNVQaLi+J1dJWOWEkGdcOWZZ0JmaxK/Nn+QVC1bipsN+cLZ1cqg3h5UBNAsOLjFA6NHcjLyiUAnsAXxATn41rn5TFkryT+fas4Tu9o9sGH0Y2JozuxCFX1U8ObmC/pyBZA/r+9b0wghn0HH8rXRcQ0y9EwJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=geTFG3V6; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA85BE000A;
	Wed,  3 Jul 2024 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720015693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExlAtdZOJ3MJY+x/PWgU0kHD6RtR8Zc2j85IcnrS0W4=;
	b=geTFG3V6iLzY9vNq4pLZSPW05g3yDjv9odm1ooD+OftRcdON8XHbtsZmJzoz/6eBhZOVIy
	Ad7CQxp79HPjcmMnJ50Neo4so8eVwdhQmjGbdej7sI4uYlhTd9xr6+HXj8RiWf9/eNmXPp
	4FDeelU0ChOWkNEpNFclQaB9vwXDYVP3WHXKvvvsTWxi5mOVoPV/VEcyPZ8aUDiAjQDlRE
	JNXb9rJThwp/zTuOl+EFMaVXgRGEFdFbohpn+loTaqHEyYR848IrZ46kc2WNcjZjAZoY+e
	BsjvBjzURKuTXLJ5QxwWcCbAh2WY+cpQ/3yXlcOPrM7daPeP21mG76XDspYxtQ==
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
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v15 02/14] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
Date: Wed,  3 Jul 2024 16:07:52 +0200
Message-ID: <20240703140806.271938-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
References: <20240703140806.271938-1-maxime.chevallier@bootlin.com>
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


