Return-Path: <netdev+bounces-204688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D2AFBC04
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DC5177D03
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A151F4192;
	Mon,  7 Jul 2025 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ufujgqru"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BA120ED
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918310; cv=none; b=tggs5tPRqdNW8PmLdtzMrkJKFcqGDvLK8YPm+bAl4Jo3ND4i7yL5p747ZD246my+LVRWsIG7ewzECSh7K8U2sAGWxjJ0XvU+D7bp7IchuCPW8c91POmC65Mf9x+IYzJmJYfoMjhZ5UNeST5asjsBeb/Swl0J6dYeqOX2d1iT1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918310; c=relaxed/simple;
	bh=wznz3Z05KE3+tZK0Ya4RD2mYFhA5mOms+wEdmOwiNZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URTNN6X1dABssAk2dkHGL9moe8yKdbHDnijgIRIrOE07wXKyNQaXqGZAk5N4+LA1GjnR8yca5HkMmggZ8ONgrlnsTbA67ojo3sOE6CAuFhzYK2dGS3mvM/7vgq4YVSp8EPvxkZYg7XXe1rgsYyl0Ald3+3YY2+sGdUsI/qClsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ufujgqru; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751918300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65BJl8ocG1KQAiuDzNGpuZkOHdbRIob/5tkT9VskyOU=;
	b=ufujgqruNCdnVsqsIAmE7PUddGAsWLhDKkjAB9eeMyUQzRuY4wslgRKnzb/ka+bfBal9Aw
	HonzuD2F2PGzqhA3np/ZTnpFGazLrljjC1SQkF4Ey6J+VWLaRPOa6Ddv8RkE+40ueeT1Bw
	WDv8pv28rRvBTrG98gQ/ha3Qlvjllig=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: phy: Don't register LEDs for genphy
Date: Mon,  7 Jul 2025 15:58:03 -0400
Message-Id: <20250707195803.666097-1-sean.anderson@linux.dev>
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
one is deterministic.

Generic PHYs do not support LEDs anyway, so don't bother registering
them.

Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/phy/phy_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..f76ee8489504 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3416,7 +3416,8 @@ static int phy_probe(struct device *dev)
 	/* Get the LEDs from the device tree, and instantiate standard
 	 * LEDs for them.
 	 */
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		err = of_phy_leds(phydev);
 
 out:
@@ -3433,7 +3434,8 @@ static int phy_remove(struct device *dev)
 
 	cancel_delayed_work_sync(&phydev->state_queue);
 
-	if (IS_ENABLED(CONFIG_PHYLIB_LEDS))
+	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev) &&
+	    !phy_driver_is_genphy_10g(phydev))
 		phy_leds_unregister(phydev);
 
 	phydev->state = PHY_DOWN;
-- 
2.35.1.1320.gc452695387.dirty


