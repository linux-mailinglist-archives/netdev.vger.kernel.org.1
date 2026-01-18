Return-Path: <netdev+bounces-250801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27018D392A3
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861583011FA4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAC30E0D6;
	Sun, 18 Jan 2026 03:57:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E821CC7B;
	Sun, 18 Jan 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768708637; cv=none; b=ZVfL+vuOOnMOWm+XGSeNe/ILSonE1dfYhqg1M9oZp2OqDrSksV3hGW1EsbDMEkj+Zjysp4P1YytGavVie4s2fe8MW1A/jJQyguZNk6Mw6X+exqwJr6/MOxhm+x36L/q9X71DUj7HPLMn0eMhztFjUiBZJl/xqyACg07GKzklBls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768708637; c=relaxed/simple;
	bh=r0S7jX1gozHvuNuoD33erDY+Yg/fpqHsxPIbPzpL62w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0YlaeuMZleRBOFvLQ4NLgTtTC3HmHMGvkPKoPdFVu2+CuBR3LR1vfsaXDg8pryUOsGGU9aknN0X/1GCF2I+FI4SHGDQfMgRTaVN3Sc2h4GEztu3G3oTSFHb52WC9Vy4Pkc7IAtTc0+g0t6qG9+gAzcDnTqUvMGAQhilUOe9isg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJua-000000000mu-2UeQ;
	Sun, 18 Jan 2026 03:57:12 +0000
Date: Sun, 18 Jan 2026 03:57:04 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: intel-xway: fix OF node refcount leakage
Message-ID: <b6fe8f6a1c7cf190b899d99e0e3a1e1370f50496.1768708538.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Automated review spotted an OF node reference count when checking if the
'leds' child node exists. Call of_put_node() to maintain the refcount.

Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
Fixes: ("1758af47b98c1 net: phy: intel-xway: add support for PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/intel-xway.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 9766dd99afaa0..12ff4c1f285d2 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -277,7 +277,7 @@ static int xway_gphy_init_leds(struct phy_device *phydev)
 
 static int xway_gphy_config_init(struct phy_device *phydev)
 {
-	struct device_node *np = phydev->mdio.dev.of_node;
+	struct device_node *np;
 	int err;
 
 	/* Mask all interrupts */
@@ -286,7 +286,10 @@ static int xway_gphy_config_init(struct phy_device *phydev)
 		return err;
 
 	/* Use default LED configuration if 'leds' node isn't defined */
-	if (!of_get_child_by_name(np, "leds"))
+	np = of_get_child_by_name(phydev->mdio.dev.of_node, "leds");
+	if (np)
+		of_node_put(np);
+	else
 		xway_gphy_init_leds(phydev);
 
 	/* Clear all pending interrupts */
-- 
2.52.0

