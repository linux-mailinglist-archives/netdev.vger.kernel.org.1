Return-Path: <netdev+bounces-148467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D079E1C82
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE39167256
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB571EF081;
	Tue,  3 Dec 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DjgLOXrJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124F1EBA1F;
	Tue,  3 Dec 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229814; cv=none; b=qlj0DATvUoJ7Phqin2f9HChyE0puLqiHXoNM4/Fm0+7y/IOVyLAVofmJuIsXNdGlJCsw/1JGbc9/4NxD6YXpxSniQuPOiR51in7SnOOIlKV0MIN8tCSXsqSorZCboSDAwAvzHDMQfmNJ/pjwr4aiVqlAS1RtviWPCSBCsXh4ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229814; c=relaxed/simple;
	bh=PXWKVwl62xApWqTGPi1niBW1XUPtWCc2rqOsNeVxZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/aLzA4HIthNi8xxkjfX9A6x4xDkzKw9rRaYD3slV5+HUfuCfQDbgTrPRmX/BRpYp1zdbLpQoY1xFn7rp0l6vcLcKeKZGxwn8xCUkkWGg3pV79wdBKOCvrf1L12lUvu65+wMyzGhZRQTSlrSEknfeog0JBT3ndG7Gj9GttUJzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DjgLOXrJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB54EE0011;
	Tue,  3 Dec 2024 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ByxFDbRGglRmvQoEikPNit9LKqTEE83lZSIDoiB4oYY=;
	b=DjgLOXrJNz8TUFxlQiPVdRxGD+WygJSlZGH7UmOjJ4sBiBJlMAstTFRzK6ZbrHo1kmzHRy
	w68BD114HEYgmHuhxlmHddMvWRI/6qOfvjvCdlz7feOqNBuPo6xDM2zsFUsB9iX1MQLTOf
	IpIRRgmVV9zs3LeNJvdIjVYemQztcDfFhmODq+9fJE74gwksm/bWjgDS175i2SDUQ+GJaq
	320OPVfUqAvS1YxRqa4Zj6d4PvOZH5gP2+BMVle4JO8lKoKu3j4T8Nzw5t72mTMZGKETpX
	VpDp81I1ayXDcZ8bNhNUx9N4/Tng6ZwoEorw+afPNnOWBpShrd/wQB2qe26NxQ==
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
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 04/10] net: freescale: ucc_geth: Fix WOL configuration
Date: Tue,  3 Dec 2024 13:43:15 +0100
Message-ID: <20241203124323.155866-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
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
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c     |  4 +--
 drivers/net/ethernet/freescale/ucc_geth.h     |  1 +
 .../net/ethernet/freescale/ucc_geth_ethtool.c | 36 +++++++++++++++----
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index cc5f9ca42a78..587bcbc079da 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3413,11 +3413,11 @@ static int ucc_geth_suspend(struct platform_device *ofdev, pm_message_t state)
 	 */
 	ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
 
-	if (ugeth->wol_en & WAKE_MAGIC) {
+	if (ugeth->wol_en & WAKE_MAGIC && !ugeth->phy_wol_en) {
 		setbits32(ugeth->uccf->p_uccm, UCC_GETH_UCCE_MPD);
 		setbits32(&ugeth->ug_regs->maccfg2, MACCFG2_MPE);
 		ucc_fast_enable(ugeth->uccf, COMM_DIR_RX_AND_TX);
-	} else if (!(ugeth->wol_en & WAKE_PHY)) {
+	} else if (!ugeth->phy_wol_en) {
 		phy_stop(ndev->phydev);
 	}
 
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index c08a56b7c9fe..e08cfc8d8904 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -1217,6 +1217,7 @@ struct ucc_geth_private {
 	int oldduplex;
 	int oldlink;
 	int wol_en;
+	u32 phy_wol_en;
 
 	struct device_node *node;
 };
diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index fb5254d7d1ba..89b323ef8145 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -346,26 +346,48 @@ static void uec_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
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
 
-	if (wol->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
-		return -EINVAL;
-	else if (wol->wolopts & WAKE_PHY && (!phydev || !phydev->irq))
+	if (phydev) {
+		ret = phy_ethtool_set_wol(phydev, wol);
+		if (ret == -EOPNOTSUPP) {
+			ugeth->phy_wol_en = 0;
+		} else if (ret) {
+			return ret;
+		} else {
+			ugeth->phy_wol_en = wol->wolopts;
+			goto out;
+		}
+	}
+
+	/* If the PHY isn't handling the WoL and the MAC is asked to more than
+	 * WAKE_MAGIC, error-out
+	 */
+	if (!ugeth->phy_wol_en &&
+	    wol->wolopts & ~WAKE_MAGIC)
 		return -EINVAL;
-	else if (wol->wolopts & WAKE_MAGIC && !qe_alive_during_sleep())
+
+	if (wol->wolopts & WAKE_MAGIC &&
+	    !qe_alive_during_sleep())
 		return -EINVAL;
 
+out:
 	ugeth->wol_en = wol->wolopts;
 	device_set_wakeup_enable(&netdev->dev, ugeth->wol_en);
 
-- 
2.47.0


