Return-Path: <netdev+bounces-205916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98605B00CDD
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F0A1C405E0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37232FE333;
	Thu, 10 Jul 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IBx96KRj"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C512FE312
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178549; cv=none; b=ImkEJbao0e6sdSUfb9Slr7/BhfHZHwPgP9BOG84eMb0qaFeUkVz9broBOV5Wg2vAAchC9c+GpV3MgzfqjW/3RqBlQP8yE9IK8pYOUc2kAgu4TJrF+UuQFVSISAqhKDdO1stPxmCOIjvBG7IHoDWMvnwNtg4ZQ6Ql7c2iQV7ryL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178549; c=relaxed/simple;
	bh=pfe/7s10BsQmts8MeZ5f65BQ/K+/v5iUx605QuYnDMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9lTPLx7dA7J8pCkhU3/ziHBuzPCzcDWQuOxIiqIyKZO3sYIqKknOOHtlBOgIdJZvTckPoXEjQQQ3hZ8i79Wq5oemhLr+WIG2SKrYCJAj3MOBVevSCrWWDqeVX9cCP92dKS+eUZ2Qc9zpugs3LeeWsGJF7e0wjB7lfKII910Iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IBx96KRj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752178535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yAuCnPQSLyFLNreeu/Buda/8jiz6ig4zQPSQrFDrimo=;
	b=IBx96KRj+vEptmNKsr29p7eIRXX5Bu9J/qhVEWckrssdhLqhd9ZbTtkUsDFVUPu5uMGwdX
	2iVnXSCxE2rjxtQxEeFhPL4LQYFlZmUCTJ+bQk6XRlen/gvHOWmCTE5ghjEDXZh+VHABan
	d845hdCJH5tG6Na4TCVd/5ec1bfaUa4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next] net: phy: Don't register LEDs for genphy
Date: Thu, 10 Jul 2025 16:14:53 -0400
Message-Id: <20250710201454.1280277-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If a PHY has no driver, the genphy driver is probed/removed directly in
phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
LEDs will be (un)registered when probing/removing the genphy driver.
This could occur if the leds are for a non-generic driver that isn't
loaded for whatever reason. Synchronously removing the PHY device in
phy_detach leads to the following deadlock:

rtnl_lock()
ndo_close()
    ...
    phy_detach()
        phy_remove()
            phy_leds_unregister()
                led_classdev_unregister()
                    led_trigger_set()
                        netdev_trigger_deactivate()
                            unregister_netdevice_notifier()
                                rtnl_lock()

There is a corresponding deadlock on the open/register side of things
(and that one is reported by lockdep), but it requires a race while this
one is deterministic. Regular drivers do not have this problem since
they are probed asynchronously (without RTNL held).

Generic PHYs do not support LEDs anyway, so don't bother registering
them.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
This is the net-next version of [1] that fixes the conflict with commit
42ed7f7e94da ("net: phy: remove phy_driver_is_genphy_10g").

[1] https://lore.kernel.org/netdev/20250707195803.666097-1-sean.anderson@linux.dev

 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 90951681523c..7556aa3dd7ee 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3502,7 +3502,7 @@ static int phy_probe(struct device *dev)
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
 		err = of_phy_leds(phydev);
 
 out:
@@ -3519,7 +3519,7 @@ static int phy_remove(struct device *dev)
 
 	cancel_delayed_work_sync(&phydev->state_queue);
 
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
 		phy_leds_unregister(phydev);
 
 	phydev->state = PHY_DOWN;
-- 
2.35.1.1320.gc452695387.dirty


