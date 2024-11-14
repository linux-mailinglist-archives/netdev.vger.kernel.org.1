Return-Path: <netdev+bounces-144967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A609C8E92
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A401F28368
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54BB1AC88B;
	Thu, 14 Nov 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FhIZd88T"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E651A3A95;
	Thu, 14 Nov 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598578; cv=none; b=hInaDjQ1pTq83XLSAQN60EC0MyXmjuJ5/twkxrsdTrSjFQgV2G20mKz59fj58fMJVnclbTnAn998oz/NbBSdpd5TQ3jQmSyegXzlGN/aUuTMJXfAtK1NijXlEseMeJYi8pG6aUcbfhYLrxYNdLC0Fcl+7JsK5h+7GaS9AJQnjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598578; c=relaxed/simple;
	bh=B+PCAI540XD3fd4y0ya7YSHILUH9X/B2UA1J0r2jkKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUyiF//yzP3/Ef0JKGWnzJ4VODODxDRgIbaIbMh8Lnz7AnkFzp1qMmCboahI2daAMjS1UICh7AvSNcaImDuolqU3m6UKU5TeNzUdB7eb7pH9ACY8QjpgiNJhLe0oQqBnFqH+E0nHhErwIutWtljgCBLa6DJzE4eOSLkEHWw3a9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FhIZd88T; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8F971BF210;
	Thu, 14 Nov 2024 15:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOe5I5RV009/ewvKsTnVJ8v2QKmxpVyy8K9Vn3nWYhQ=;
	b=FhIZd88TTOZcqjc0guKQCBJMu2N4P6TeOLSV0DXGYcjgtbVGT7jfK3B49OveA0CQdnbVlF
	Btjvo5r+wgNRn45asVSf8II6FMlqDNNcsGiEqCen5vYvXLUhbGUMimV+ZOSe5Rdw5r+wdB
	lG3x66GXT373VkmtNgU7O//RjSYHxaHoJjckcLtnyQzwovz5UVEQFj4aGRNIjjrHoP0PWb
	+BMe6H44oXDl4r8nfQ6ky4YzSRTfq0wXH96DmfqqxyGokLEQmldFhirtMUrW9GX61XCtmj
	Q7qKbJDiWwDfxz4NXId9R7+aR5Yxcy3Fo5ozQaDIxzodB7yOlZjUZ2CWyL2x+A==
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
Subject: [PATCH net-next v2 04/10] net: freescale: ucc_geth: Fix WOL configuration
Date: Thu, 14 Nov 2024 16:35:55 +0100
Message-ID: <20241114153603.307872-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
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
V2: Reworked the whole configuration sequence, and introduced an
internal attribute to store the PHY wol capabilities

 drivers/net/ethernet/freescale/ucc_geth.c     |  4 +--
 drivers/net/ethernet/freescale/ucc_geth.h     |  1 +
 .../net/ethernet/freescale/ucc_geth_ethtool.c | 36 +++++++++++++++----
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 13b8f8401c81..42254ee64a35 100644
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


