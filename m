Return-Path: <netdev+bounces-148472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C4A9E1D51
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B923B47A77
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A01F473A;
	Tue,  3 Dec 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xhnea8KK"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD181F4286;
	Tue,  3 Dec 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229820; cv=none; b=pgLM0t+1m9qmFKAALEL2Sq+/xTHZhCuk8DyMkCXzZQj6Khnef1LMqHw8FpPDhS3dOpi7r3w/4Ya0T9C7NW6Fy3MpAhJlphvWaHM6XaEA1O9ZDV+9UeHt77mMBi0xz2dUKB9j2ALUcr7SrGAwkpE75O+Y1GPyrMC9x5z8juYBrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229820; c=relaxed/simple;
	bh=fOuju07Dr2ECyKzUnp3Nxa80qrfiCTrYTU7omb5m2ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8W74OE2mQYz9MeskK3uikoudLVfs3fTXehraKUdEGfQB4awl9VmvpxgY5G03wSyRnWokdSxh2Lg9XKDcYNnhlWS6+aijWrR/0ewjF4OGebBqj7EbH8Vzn9rzSjf/rY+lX0Nw294ELYh4f/0HtgcDc0/Es5DAopPOI6s5eUKm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xhnea8KK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FCB4E0015;
	Tue,  3 Dec 2024 12:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=youLhIgqVVWm97WdCjhC+2nlqSD1XPFSr1JMUVJC8KQ=;
	b=Xhnea8KKsAYC9LqskJbsGK9P5/cBO/Sx3DuSFKSJvSbUVrZ3raABIqPBmfg6tvXeVlkgeN
	db33qTDcapDqez8YWMuCBOiU8gPr8Pw+b/AX1HCGlHN4yay/SkFCU9evAgWme1UC7H0Mk5
	y0v+iQgO7aZwHgjUEaAWhSQi9sVccRQgwAPUivaHGQ7EQZRM+V52LZ4zEuPZna5JlDIbQL
	yK0+K51mAMHJb1rLzEfn7s/DPygEGqQGNfsD66G6xJ3ZPPbGecdHXt2QI3DSdUTPm5ERwb
	GGwoVWDHF2xleX4TXx7nZvhULg6RdHKulWAEvDBTJzFlQebKf/EZa72KklVu2A==
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
Subject: [PATCH net-next v3 09/10] net: freescale: ucc_geth: Introduce a helper to check Reduced modes
Date: Tue,  3 Dec 2024 13:43:20 +0100
Message-ID: <20241203124323.155866-10-maxime.chevallier@bootlin.com>
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

A number of parallel MII interfaces also exist in a "Reduced" mode,
usually with higher clock rates and fewer data lines, to ease the
hardware design. This is what the 'R' stands for in RGMII, RMII, RTBI,
RXAUI, etc.

The UCC Geth controller has a special configuration bit that needs to be
set when the MII mode is one of the supported reduced modes.

Add a local helper for that.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f6dd36dc03fe..57debcba124c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1258,6 +1258,13 @@ static int init_min_frame_len(u16 min_frame_length,
 	return 0;
 }
 
+static bool phy_interface_mode_is_reduced(phy_interface_t interface)
+{
+	return phy_interface_mode_is_rgmii(interface) ||
+	       interface == PHY_INTERFACE_MODE_RMII ||
+	       interface == PHY_INTERFACE_MODE_RTBI;
+}
+
 static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 {
 	struct ucc_geth_info *ug_info;
@@ -1290,12 +1297,7 @@ static int adjust_enet_interface(struct ucc_geth_private *ugeth)
 	upsmr = in_be32(&uf_regs->upsmr);
 	upsmr &= ~(UCC_GETH_UPSMR_RPM | UCC_GETH_UPSMR_R10M |
 		   UCC_GETH_UPSMR_TBIM | UCC_GETH_UPSMR_RMM);
-	if ((ugeth->phy_interface == PHY_INTERFACE_MODE_RMII) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
-	    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
+	if (phy_interface_mode_is_reduced(ugeth->phy_interface)) {
 		if (ugeth->phy_interface != PHY_INTERFACE_MODE_RMII)
 			upsmr |= UCC_GETH_UPSMR_RPM;
 		switch (ugeth->max_speed) {
@@ -1594,9 +1596,7 @@ static void ugeth_link_up(struct ucc_geth_private *ugeth,
 				    ~(MACCFG2_INTERFACE_MODE_MASK)) |
 				    MACCFG2_INTERFACE_MODE_NIBBLE);
 			/* if reduced mode, re-set UPSMR.R10M */
-			if (interface == PHY_INTERFACE_MODE_RMII ||
-			    phy_interface_mode_is_rgmii(interface) ||
-			    interface == PHY_INTERFACE_MODE_RTBI) {
+			if (phy_interface_mode_is_reduced(interface)) {
 				if (speed == SPEED_10)
 					upsmr |= UCC_GETH_UPSMR_R10M;
 				else
-- 
2.47.0


