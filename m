Return-Path: <netdev+bounces-254176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ks6EhPbeWkg0QEAu9opvQ
	(envelope-from <netdev+bounces-254176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:46:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D4F9EFE3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6F2B3002331
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7C434D4EC;
	Wed, 28 Jan 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="e+WUT4Lj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FFC34D391
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593614; cv=none; b=LEc9IoEYA6A8hAUyd9P3+mRO2vEWbigpQqYFvLWUvxDG9T0WNNfOHi/Jto95yMQdwjthTV13SGeA9p8/6zcHtDk8BI1CWpTr3jJuiO95/J+0HbQ+59OhIXWvP3BglfHvicaJI2JVJXDOs1VC2zcL7NxB6RJFQKNZYGlFUBNXQfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593614; c=relaxed/simple;
	bh=TC15+6dILqv3V4br20k0HKU4BMDLCWRE3mXpBKGswAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRRjw+IQPPMgMmsFEaXhkTGAwXkp5WobkHh8NGDbOAxA8xBn9jKUcGNzqK4Mo0O10HvF2aJ5Y2lUFsk1vvlcibTigFLTLzWAF1u2QM74y0Rn7DV+pGQnb4FNFIdaJpjxMSaqfNQ6s1RokiEe2LO2Jt4jxod74wgkRzONSrmPmUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=e+WUT4Lj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so74888115e9.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1769593611; x=1770198411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbeoicRBBkRysu8QvYpatvGi1IIIWH8ilPA26WAsQkU=;
        b=e+WUT4LjjJDpmAktI8jsxiNQypqkQI2/0M8kNi+2TCuAJsmT44/mgwnm2bWORk5ALA
         SgW+lw/SyXZ1bpsltBRIZOYzEv+CRuF9t883oylmBeAmrbowGaPwVd2joI0UirtzLvnp
         d+wLds5EvzC6mzlfLXhzbWILLoOTKTjLwKFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593611; x=1770198411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbeoicRBBkRysu8QvYpatvGi1IIIWH8ilPA26WAsQkU=;
        b=VODtZVpTGaSSGSHXGYJ9hI6XpL3oraMHpvvMCgt6W3TO+ZK6me39HgsPooRTsfclUt
         tQJcfBjHi+8/mQNfy4bFYNSuxQTwpGglZZkVtqykjrHb4EQjmZsGwEq4L9Y1zBGka3QO
         V9gE90iXGrawkukBfuaa0Ido5Cg1G74rpQaO4A/oEZ9j/T2tOd0wzOzCfgJZB1vYOH+q
         BgrEaDtlXEW8ezODWMaOPXSLBW38P3CDmq0aH72In5alwr2yUznJArLPbxPifA9taPJU
         1uBqWz87T2y0+DIg2aMdHO707s7/9VSEsxIjq8TmNxB4EQIJSVr73e7R8hVkOGSEXxjf
         gOIw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1OCcKAKKZkniWyRDUEFBHP9CzLwTBJqQxrDknUa8PvBOSK4kGg03k8XVG6gTk8DEozudu/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKTXog3nosbDud6ix+pLpvkdm8T42QgsixEAzqTyB/XFX2bME
	u83nNvjkZ5l+h+iFRf2INxbIAWgfnoJqca4XwufbYwaWtbw13U4/OHkRJ/0nYMSU7hQ=
X-Gm-Gg: AZuq6aL+ka/W1En4H0bnreWTHFSzMmcShkZJyJLvuhP4Jx5ZiISH2hbIS3UK26XSocd
	7dbl9cazYTC801k/aTIQY01xL/zB3Tl+2+rvJz3lRA1d29rOxcgH4t+06ePwTDwppUdEb+ncopD
	zj8RcfDAqtupRC86Rb2CFGiOi2SnYTnhllUkAoGEH71b3tgMOpizmyYoBixiNa0pX+dJPj0RZqa
	d2X8v+Uxy10uamIaYtREWct864fb93Yytd1ufLD6NlcHCRASs4ZEkdn/oM4A7ANUmwFBoDJzU3d
	KnZavawOWY9bANGQ5bc+pk/83FrdCLrfK6DEdjDw2WgdWvwk/f2aXZU0lqV1UbL2kX6o1ey0Mh5
	SUHMFGVTNiHxsFsiuhv2k7Q7qKvshybB2UVZwKwjaX2kw/j88hSLQHqvy1ZECxqR/NNFmgvGLGS
	VwSNzxBarUoihj0Y0sMs5/jsCRWwv4/RoJJI8FsGPwECHU+8IYGwsWur9NXCwoYbJrNysWOtIPP
	XW0XdZHJqbCcxTW
X-Received: by 2002:a05:600c:1554:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48069c1c2f4mr58353885e9.12.1769593610912;
        Wed, 28 Jan 2026 01:46:50 -0800 (PST)
Received: from panicking.amarulasolutions.com ([46.18.137.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d2585c6sm5821715e9.0.2026.01.28.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:46:50 -0800 (PST)
From: Michael Trimarchi <michael@amarulasolutions.com>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	imx@lists.linux.dev (open list:FREESCALE IMX / MXC FEC DRIVER),
	netdev@vger.kernel.org (open list:FREESCALE IMX / MXC FEC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Michael Trimarchi <michael@amarulasolutions.com>,
	imx@lists.linux.dev (open list:FREESCALE IMX / MXC FEC DRIVER),
	netdev@vger.kernel.org (open list:FREESCALE IMX / MXC FEC DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] net: phy: integrate reset-after-clock quirk into phy_init_hw
Date: Wed, 28 Jan 2026 10:46:41 +0100
Message-ID: <20260128094644.302313-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amarulasolutions.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amarulasolutions.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254176-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael@amarulasolutions.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amarulasolutions.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6D4F9EFE3
X-Rspamd-Action: no action

The current implementation of phy_reset_after_clk_enable requires MAC drivers
(like fec_main.c) to manually track PHY probing states and trigger resets
at specific points in their clock management flow and was created just for a SoC
vendor. This leads to fragile code in the Ethernet driver, involving complex
checks to see if the PHY device is bound.

This patch proposes moving the handling of the PHY_RST_AFTER_CLK_EN flag directly
into the generic phy_init_hw() function.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---

I need to test better some boards that need this reset, but
I need to confirm if the general approach is ok

---
 drivers/net/ethernet/freescale/fec_main.c | 41 -----------------------
 drivers/net/phy/phy_device.c              | 27 ++-------------
 include/linux/phy.h                       |  1 -
 3 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e2b75d1970ae..ea112385e77e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2364,28 +2364,6 @@ static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
 	return ret;
 }
 
-static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct phy_device *phy_dev = ndev->phydev;
-
-	if (phy_dev) {
-		phy_reset_after_clk_enable(phy_dev);
-	} else if (fep->phy_node) {
-		/*
-		 * If the PHY still is not bound to the MAC, but there is
-		 * OF PHY node and a matching PHY device instance already,
-		 * use the OF PHY node to obtain the PHY device instance,
-		 * and then use that PHY device instance when triggering
-		 * the PHY reset.
-		 */
-		phy_dev = of_phy_find_device(fep->phy_node);
-		phy_reset_after_clk_enable(phy_dev);
-		if (phy_dev)
-			put_device(&phy_dev->mdio.dev);
-	}
-}
-
 static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -2416,7 +2394,6 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 		if (ret)
 			goto failed_clk_2x_txclk;
 
-		fec_enet_phy_reset_after_clk_enable(ndev);
 	} else {
 		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
@@ -3554,7 +3531,6 @@ fec_enet_open(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int ret;
-	bool reset_again;
 
 	ret = pm_runtime_resume_and_get(&fep->pdev->dev);
 	if (ret < 0)
@@ -3565,17 +3541,6 @@ fec_enet_open(struct net_device *ndev)
 	if (ret)
 		goto clk_enable;
 
-	/* During the first fec_enet_open call the PHY isn't probed at this
-	 * point. Therefore the phy_reset_after_clk_enable() call within
-	 * fec_enet_clk_enable() fails. As we need this reset in order to be
-	 * sure the PHY is working correctly we check if we need to reset again
-	 * later when the PHY is probed
-	 */
-	if (ndev->phydev && ndev->phydev->drv)
-		reset_again = false;
-	else
-		reset_again = true;
-
 	/* I should reset the ring buffers here, but I don't yet know
 	 * a simple way to do that.
 	 */
@@ -3587,12 +3552,6 @@ fec_enet_open(struct net_device *ndev)
 	/* Init MAC prior to mii bus probe */
 	fec_restart(ndev);
 
-	/* Call phy_reset_after_clk_enable() again if it failed during
-	 * phy_reset_after_clk_enable() before because the PHY wasn't probed.
-	 */
-	if (reset_again)
-		fec_enet_phy_reset_after_clk_enable(ndev);
-
 	/* Probe and connect to PHY when open the interface */
 	ret = fec_enet_mii_probe(ndev);
 	if (ret)
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7a67c900e79a..3af652cbd7d2 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1376,6 +1376,9 @@ int phy_init_hw(struct phy_device *phydev)
 {
 	int ret = 0;
 
+	if (phydev->drv->flags & PHY_RST_AFTER_CLK_EN)
+		phy_device_reset(phydev, 1);
+
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
@@ -1956,30 +1959,6 @@ int phy_resume(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_resume);
 
-/**
- * phy_reset_after_clk_enable - perform a PHY reset if needed
- * @phydev: target phy_device struct
- *
- * Description: Some PHYs are known to need a reset after their refclk was
- *   enabled. This function evaluates the flags and perform the reset if it's
- *   needed. Returns < 0 on error, 0 if the phy wasn't reset and 1 if the phy
- *   was reset.
- */
-int phy_reset_after_clk_enable(struct phy_device *phydev)
-{
-	if (!phydev || !phydev->drv)
-		return -ENODEV;
-
-	if (phydev->drv->flags & PHY_RST_AFTER_CLK_EN) {
-		phy_device_reset(phydev, 1);
-		phy_device_reset(phydev, 0);
-		return 1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(phy_reset_after_clk_enable);
-
 /* Generic PHY support and helper functions */
 
 /**
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 0bc00a4cceb2..d843415e65a6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1876,7 +1876,6 @@ int phy_speed_up(struct phy_device *phydev);
 bool phy_check_valid(int speed, int duplex, unsigned long *features);
 
 int phy_restart_aneg(struct phy_device *phydev);
-int phy_reset_after_clk_enable(struct phy_device *phydev);
 
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_start_cable_test(struct phy_device *phydev,
-- 
2.51.0


