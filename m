Return-Path: <netdev+bounces-250934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83642D39BA7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 058BD30012EB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 00:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54841C7012;
	Mon, 19 Jan 2026 00:42:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363918859B;
	Mon, 19 Jan 2026 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783326; cv=none; b=oR1RwDfjRdeOIziH5QPt5pvu4j4zT8U9GARHVzoV0Ww5J7pLjl2XHeTL1EdcCN6qZCAG2EJw+FNJuDOfBs401Q/rz9g6asLyRUIwRHlYmU9RobPrTGZmu3AK5QNKZLpvlUWXR+8qbYAUhmbE2K/ZQK/IfAfUCsPV6bYInng7eG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783326; c=relaxed/simple;
	bh=21RNlzu4qppa/XXRwjk7JgFT+C3CbPytF00/Mdp7szU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DqHreWkr75IdUR2WnQjFCOFTkJqpvpmtnITeq24FxYPWPv/Y1+TD+fbm7mPpj9P6BpUn0J4jlMpgHNfZ/XicsgwTOeX6K4OEIuKzxtQA08WCn+tOGCYVO4Dn95WXa0axlnKuHwVjNWi85toBC38zCjYLeyDlXtofpNWStooMNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhdLB-000000003aw-0DMx;
	Mon, 19 Jan 2026 00:41:57 +0000
Date: Mon, 19 Jan 2026 00:41:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: phy: intel-xway: fix OF node refcount leakage
Message-ID: <e3275e1c1cdca7e6426bb9c11f33bd84b8d900c8.1768783208.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Automated review spotted am OF node reference count leakage when
checking if the 'leds' child node exists.

Call of_put_node() to correctly maintain the refcount.

Link: https://netdev-ai.bots.linux.dev/ai-review.html?id=20f173ba-0c64-422b-a663-fea4b4ad01d0
Fixes: 1758af47b98c1 ("net: phy: intel-xway: add support for PHY LEDs")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: fix Fixes:-tag

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

