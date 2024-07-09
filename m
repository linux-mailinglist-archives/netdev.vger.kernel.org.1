Return-Path: <netdev+bounces-110112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431992B023
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C423A1C221A5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324BD145324;
	Tue,  9 Jul 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kbclu93g"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708D12D1ED;
	Tue,  9 Jul 2024 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506658; cv=none; b=B+qrB5YK+4521rqKE/bMnTDQNikUEuj0NMUsjTSb6Im4VEbfLyylbwULhjFawaxb6KBG9B7/kIJNxlZgwwGMvsKhsvugvosNXCyawfAiDPanK7Z9xRVLVH+coz5MrGLT7szi1afOKAVRRfm5IAsU9W1WRq73Tl+3Qc4gmFp6TTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506658; c=relaxed/simple;
	bh=5BdBXIXEzFrbHYhpcVl6eMdnlDRUioudERWqgerSkr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/7eLBDP0IZFtxE7wC5KP4Y27n/mtLlSKY43lENk4IjZrdhfsmLga6k40R8tPBu4ylCUab+qeq0akt5kb7oDhQWIc01aM0ii6VLudyFrpODdiwFfvMalpDs3mTNNKEgna6FuUoNZH9xIxWDFyOnjQBAaxk7hGVc3hLlDYvE+ZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kbclu93g; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 768841BF20A;
	Tue,  9 Jul 2024 06:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720506647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExlAtdZOJ3MJY+x/PWgU0kHD6RtR8Zc2j85IcnrS0W4=;
	b=kbclu93gY33+AOLqRfT4GtwQifZwUTs183r0Y8lbOUq6gF3tp7b8m7wnuMGIIKlHRR/68p
	guQldf52i1xWBf086FEjARGeBMRFpewoNnopQAtxpWtJYr+d9BrBa1Vj+sEBH0tUilHwt0
	qBmTUG4RIdyWysmSDB2DmSMSQDAIAQwhm+POP165ajgbLbSS/+cwGBeGcJEjo9OOuIDK94
	PBX+vivSYaFgwRqkYK8F3VhOA6VI+AmRSY2YXb2gwC4R27af+Aa4PjUVFpBgtFVsLipkNH
	KXMdPkZrbTPYb1uH3WUiJQsGQiXEaUuVVVx4hRjLKvICY6jdAyImjFTlJhKnWw==
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
Subject: [PATCH net-next v17 02/14] net: sfp: pass the phy_device when disconnecting an sfp module's PHY
Date: Tue,  9 Jul 2024 08:30:25 +0200
Message-ID: <20240709063039.2909536-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
References: <20240709063039.2909536-1-maxime.chevallier@bootlin.com>
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


