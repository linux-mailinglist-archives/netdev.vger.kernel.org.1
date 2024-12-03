Return-Path: <netdev+bounces-148465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595909E1C76
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F3167515
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C421EC013;
	Tue,  3 Dec 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fA6xKNcP"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545531EB9E0;
	Tue,  3 Dec 2024 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229813; cv=none; b=U3tNVTosdTrM6X1qOMWa8F0L+p32sXfdLzev2HQJ9GYrMbaZrMiDu6r9KPwL9qQJ+3tWqXFBNUzblpGcFjafveunRkxKXeU+OjXU7y/PBQEeR00Z9HGJvdAUv3Y0Cu/LjlttlODVpCMW4xuI2snQohqP8gFkkGv2U65vc+W1YPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229813; c=relaxed/simple;
	bh=OCt6BKuoNA/rLCudPSLWTLu1AYApzwwAUqE/Cpfho7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg5zXUwOd7jIpI/0mqsnwvgp9ujnHPaZlteNlgp0vPpXDKHD37KV8tym9MSzsJ3Bkz5UE0C/jPd7rMK/xIQhOYbGJ0h1W655UlqEptZ1/8fM10wGjLULImjT1HSb2+bNHfBiSuPvQnlo6oIOHTIxGo5jwe7WQLtTObzL+cSaQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fA6xKNcP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1386E0008;
	Tue,  3 Dec 2024 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=okebF77u49Nk3Yt+pJelgSbyckQ2lQla+vsrMDb1T48=;
	b=fA6xKNcPs0Uf7oFjs6joGOolnS2bwHgFodRHR0Ev4an72y0VcUaudgBe7my/NBSmb2zm2H
	TflRuU7L+0R3CVnjUVXkT0awZFOyJcDI6tfGkq9usQkjNIc0aO0UOKGlIq7IRYSbgPteGF
	sgpJ3CPkeW++mU2JgVpsVU7iVCnLB7AQZiTdSnUaYi/N1Wxb82o0XOgjh9iB2qInqVKcxF
	q/NhdeWfmt6ziLg+CTwFP0k3iOryvl4Kweh3x3VDD6Ap6OaOyLu0B3mpaheTKh6paL5T72
	jMk3Zd/xZqcww12dz31RJd9j7U5h8QIDVS3MdStXvLkg6ctMUUV1FAqO+V8HBQ==
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
Subject: [PATCH net-next v3 02/10] net: freescale: ucc_geth: split adjust_link for phylink conversion
Date: Tue,  3 Dec 2024 13:43:13 +0100
Message-ID: <20241203124323.155866-3-maxime.chevallier@bootlin.com>
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

Preparing the phylink conversion, split the adjust_link callbaclk, by
clearly separating the mac configuration, link_up and link_down phases.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.c | 180 +++++++++++-----------
 1 file changed, 93 insertions(+), 87 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index b023a1a1dc5c..bf9f5901b405 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -1548,105 +1548,111 @@ static void ugeth_activate(struct ucc_geth_private *ugeth)
 	__netdev_watchdog_up(ugeth->ndev);
 }
 
-/* Called every time the controller might need to be made
- * aware of new link state.  The PHY code conveys this
- * information through variables in the ugeth structure, and this
- * function converts those variables into the appropriate
- * register values, and can bring down the device if needed.
- */
-
-static void adjust_link(struct net_device *dev)
+static void ugeth_link_up(struct ucc_geth_private *ugeth,
+			  struct phy_device *phy,
+			  phy_interface_t interface, int speed, int duplex)
 {
-	struct ucc_geth_private *ugeth = netdev_priv(dev);
-	struct ucc_geth __iomem *ug_regs;
-	struct ucc_fast __iomem *uf_regs;
-	struct phy_device *phydev = ugeth->phydev;
+	struct ucc_geth __iomem *ug_regs = ugeth->ug_regs;
+	struct ucc_fast __iomem *uf_regs = ugeth->uccf->uf_regs;
+	u32 tempval = in_be32(&ug_regs->maccfg2);
+	u32 upsmr = in_be32(&uf_regs->upsmr);
 	int new_state = 0;
 
-	ug_regs = ugeth->ug_regs;
-	uf_regs = ugeth->uccf->uf_regs;
-
-	if (phydev->link) {
-		u32 tempval = in_be32(&ug_regs->maccfg2);
-		u32 upsmr = in_be32(&uf_regs->upsmr);
-		/* Now we make sure that we can be in full duplex mode.
-		 * If not, we operate in half-duplex mode. */
-		if (phydev->duplex != ugeth->oldduplex) {
-			new_state = 1;
-			if (!(phydev->duplex))
-				tempval &= ~(MACCFG2_FDX);
-			else
-				tempval |= MACCFG2_FDX;
-			ugeth->oldduplex = phydev->duplex;
-		}
+	/* Now we make sure that we can be in full duplex mode.
+	 * If not, we operate in half-duplex mode.
+	 */
+	if (duplex != ugeth->oldduplex) {
+		new_state = 1;
+		if (duplex == DUPLEX_HALF)
+			tempval &= ~(MACCFG2_FDX);
+		else
+			tempval |= MACCFG2_FDX;
+		ugeth->oldduplex = duplex;
+	}
 
-		if (phydev->speed != ugeth->oldspeed) {
-			new_state = 1;
-			switch (phydev->speed) {
-			case SPEED_1000:
-				tempval = ((tempval &
-					    ~(MACCFG2_INTERFACE_MODE_MASK)) |
-					    MACCFG2_INTERFACE_MODE_BYTE);
-				break;
-			case SPEED_100:
-			case SPEED_10:
-				tempval = ((tempval &
-					    ~(MACCFG2_INTERFACE_MODE_MASK)) |
-					    MACCFG2_INTERFACE_MODE_NIBBLE);
-				/* if reduced mode, re-set UPSMR.R10M */
-				if ((ugeth->phy_interface == PHY_INTERFACE_MODE_RMII) ||
-				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII) ||
-				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
-				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) ||
-				    (ugeth->phy_interface == PHY_INTERFACE_MODE_RTBI)) {
-					if (phydev->speed == SPEED_10)
-						upsmr |= UCC_GETH_UPSMR_R10M;
-					else
-						upsmr &= ~UCC_GETH_UPSMR_R10M;
-				}
-				break;
-			default:
-				if (netif_msg_link(ugeth))
-					pr_warn(
-						"%s: Ack!  Speed (%d) is not 10/100/1000!",
-						dev->name, phydev->speed);
-				break;
+	if (speed != ugeth->oldspeed) {
+		new_state = 1;
+		switch (speed) {
+		case SPEED_1000:
+			tempval = ((tempval &
+				    ~(MACCFG2_INTERFACE_MODE_MASK)) |
+				    MACCFG2_INTERFACE_MODE_BYTE);
+			break;
+		case SPEED_100:
+		case SPEED_10:
+			tempval = ((tempval &
+				    ~(MACCFG2_INTERFACE_MODE_MASK)) |
+				    MACCFG2_INTERFACE_MODE_NIBBLE);
+			/* if reduced mode, re-set UPSMR.R10M */
+			if (interface == PHY_INTERFACE_MODE_RMII ||
+			    phy_interface_mode_is_rgmii(interface) ||
+			    interface == PHY_INTERFACE_MODE_RTBI) {
+				if (speed == SPEED_10)
+					upsmr |= UCC_GETH_UPSMR_R10M;
+				else
+					upsmr &= ~UCC_GETH_UPSMR_R10M;
 			}
-			ugeth->oldspeed = phydev->speed;
+			break;
+		default:
+			if (netif_msg_link(ugeth))
+				pr_warn("%s:  Speed (%d) is not 10/100/1000!",
+					netdev_name(ugeth->ndev), speed);
+			break;
 		}
+		ugeth->oldspeed = speed;
+	}
 
-		if (!ugeth->oldlink) {
-			new_state = 1;
-			ugeth->oldlink = 1;
-		}
+	if (!ugeth->oldlink) {
+		new_state = 1;
+		ugeth->oldlink = 1;
+	}
 
-		if (new_state) {
-			/*
-			 * To change the MAC configuration we need to disable
-			 * the controller. To do so, we have to either grab
-			 * ugeth->lock, which is a bad idea since 'graceful
-			 * stop' commands might take quite a while, or we can
-			 * quiesce driver's activity.
-			 */
-			ugeth_quiesce(ugeth);
-			ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
+	if (new_state) {
+		/*
+		 * To change the MAC configuration we need to disable
+		 * the controller. To do so, we have to either grab
+		 * ugeth->lock, which is a bad idea since 'graceful
+		 * stop' commands might take quite a while, or we can
+		 * quiesce driver's activity.
+		 */
+		ugeth_quiesce(ugeth);
+		ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
 
-			out_be32(&ug_regs->maccfg2, tempval);
-			out_be32(&uf_regs->upsmr, upsmr);
+		out_be32(&ug_regs->maccfg2, tempval);
+		out_be32(&uf_regs->upsmr, upsmr);
 
-			ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
-			ugeth_activate(ugeth);
-		}
-	} else if (ugeth->oldlink) {
-			new_state = 1;
-			ugeth->oldlink = 0;
-			ugeth->oldspeed = 0;
-			ugeth->oldduplex = -1;
+		ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
+		ugeth_activate(ugeth);
 	}
 
-	if (new_state && netif_msg_link(ugeth))
-		phy_print_status(phydev);
+	if (netif_msg_link(ugeth))
+		phy_print_status(phy);
+}
+
+static void ugeth_link_down(struct ucc_geth_private *ugeth)
+{
+	ugeth->oldlink = 0;
+	ugeth->oldspeed = 0;
+	ugeth->oldduplex = -1;
+}
+
+/* Called every time the controller might need to be made
+ * aware of new link state.  The PHY code conveys this
+ * information through variables in the ugeth structure, and this
+ * function converts those variables into the appropriate
+ * register values, and can bring down the device if needed.
+ */
+
+static void adjust_link(struct net_device *dev)
+{
+	struct ucc_geth_private *ugeth = netdev_priv(dev);
+	struct phy_device *phydev = ugeth->phydev;
+
+	if (phydev->link)
+		ugeth_link_up(ugeth, phydev, phydev->interface,
+			      phydev->speed, phydev->duplex);
+	else
+		ugeth_link_down(ugeth);
 }
 
 /* Initialize TBI PHY interface for communicating with the
-- 
2.47.0


