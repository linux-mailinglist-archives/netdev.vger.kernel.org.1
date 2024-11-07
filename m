Return-Path: <netdev+bounces-142956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109D9C0C58
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433871C226F7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35DC21949F;
	Thu,  7 Nov 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ao6//r6v"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EA218581;
	Thu,  7 Nov 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998991; cv=none; b=dkd94iHA4RN0GVv8aFyhAR3/eFdnF/TnbERcHHHZCYNK0/bm8/vz4vPK22XXOAviJM33GHdFqJZlPN8edVvqT9ENeCF8xOgz5mZchmc68j7C4lKs2/PeirZnkETq6594YWxnboxse+y+6lVcDffXJdBYYJuMycFktNCeBNIC99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998991; c=relaxed/simple;
	bh=zdKU3IxnkMSUDAgT9PBj2/cSj2ZLWy3M0VSGjOsz5mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6YyPOdVDHmveCUP0yH4yj0makKmpMu5YNEApgtqnTea7yoqgLABPWhID8Lg6l4/7V1V3mcQ1370ZWdQ4k6ac8N0FTynmwkKz+wXX6dwxYfqdqqV/fmrAs/V757yQ6yBOJ6Qzxg3oMimRHmRVQSWTQXk1TEKnOX5KYkyriVXCxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ao6//r6v; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1CF86240004;
	Thu,  7 Nov 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730998987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXjeOGEfwlZxyQoPcMkiNsCpu7ZxRvk/qfDkU5pXhUU=;
	b=ao6//r6v97GKdpzLtdyw8Zbvh+05CE/S7S5u+jnoF7tbqoCmSKw4K5XP7a/Ax5Z88NNXRp
	SBzNk3p4U1gpuAdz5q8/IaSDREbaL0ocKxJHtZvcQEyDb42R1L3av/Ch2E+UAIlxsAELMW
	K4WE6T5yxgtB/Z+9ToZeLrlQwYmeJy61td/WzOM/3fFE2FZlLuKxzyOc8IAxTC5SIxV+1I
	pOZQ65S40Ac0Bj+DkDJKvWxI+eOhlTnKCSLMKNwahfskwJX3EN8+k4T1ejQraPyvptzy8a
	boZWSIPfQ/2F57N6rzvrLgA6Yjyl7YX6l6KxDJVi5+vchMp2SqqlkUX3XHa8yw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next 4/7] net: freescale: ucc_geth: Fix WOL configuration
Date: Thu,  7 Nov 2024 18:02:51 +0100
Message-ID: <20241107170255.1058124-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
References: <20241107170255.1058124-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The get/set_wol ethtool ops rely on querying the PHY for its WoL
capabilities, checking for the presence of a PHY and a PHY interrupts
isn't enough. Address that by cleaning up the WoL configuration
sequence.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/freescale/ucc_geth_ethtool.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index fb5254d7d1ba..2a085f8f34b2 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -346,26 +346,37 @@ static void uec_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
 
-	if (phydev && phydev->irq)
-		wol->supported |= WAKE_PHY;
+	wol->supported = 0;
+	wol->wolopts = 0;
+
+	if (phydev)
+		phy_ethtool_get_wol(phydev, wol);
+
 	if (qe_alive_during_sleep())
 		wol->supported |= WAKE_MAGIC;
 
-	wol->wolopts = ugeth->wol_en;
+	wol->wolopts |= ugeth->wol_en;
 }
 
 static int uec_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct ucc_geth_private *ugeth = netdev_priv(netdev);
 	struct phy_device *phydev = netdev->phydev;
+	int ret = 0;
 
 	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
 		return -EINVAL;
-	else if (wol->wolopts & WAKE_PHY && (!phydev || !phydev->irq))
+	else if ((wol->wolopts & WAKE_PHY) && !phydev)
 		return -EINVAL;
 	else if (wol->wolopts & WAKE_MAGIC && !qe_alive_during_sleep())
 		return -EINVAL;
 
+	if (wol->wolopts & WAKE_PHY)
+		ret = phy_ethtool_set_wol(phydev, wol);
+
+	if (ret)
+		return ret;
+
 	ugeth->wol_en = wol->wolopts;
 	device_set_wakeup_enable(&netdev->dev, ugeth->wol_en);
 
-- 
2.47.0


