Return-Path: <netdev+bounces-117731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9494EF3D
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C061F226EC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8018A17DE10;
	Mon, 12 Aug 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieRbve6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565CD33C5;
	Mon, 12 Aug 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472012; cv=none; b=rY/zvISpoYB2Kpstj7YVgcyDPcmVhLBwupjhjwkh9vZX9U/652szBdrrbJrL4q8XvFcu+TF6yIWx7I+1JbHzCoTcRS8eZBczWgM9/9p0J0DP652OSFbBAi/Nj1vhW5e+qgKHVFJh3RTJlL2fUPY1S1KbmRrHq4Nv/PL+8U6Y72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472012; c=relaxed/simple;
	bh=TC/QMOkYIMtEI0vpiVXPXJAu6ENEaOjWl87P5kFwUvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBbzJFb+33xvKJc0mxtSrG7JT/nSoNBEonAKxCOrLp/RXcznkPeEdBkBBReeEibPH385t2Rh3mb7SOZPlEJXJgb/fubQkiua5VqzKCMDKw2F3QeOPm0989toCXFIKcKJLoKIDAkxauPveK6wYt9A6rr5jQRDp4jgM/cFOtNxK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieRbve6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5F1C4AF09;
	Mon, 12 Aug 2024 14:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723472011;
	bh=TC/QMOkYIMtEI0vpiVXPXJAu6ENEaOjWl87P5kFwUvE=;
	h=From:To:Cc:Subject:Date:From;
	b=ieRbve6gGbPfvJArfpSKs1Vx00YBFsMuODaQWTRIVvInmuyZ0ULOtXt3eG1GtVArh
	 A7l77oEztGSzFI7vQQIX+5Y3il1EeVDnPI4yVsEb0QBQ80QULCa6tsDWce46XVSyYr
	 v3bid7zD5EKbTo2Gg9EMsdObJXsgDBIz8+ZSZ2h5E+qGUL2Ixjoy656s3q5Rx+e2fT
	 0BT58b8uP8QTk+Tsy0LlZxdKpiKsaL0fKzZk9shjfa9N4MLLZ2AQtpWTKDLKPA94st
	 xurEDyuHPRQBJWfmXFhSHOb0DIfWOCCAkHas+zQbmjZ3JULQXZKWPb/uKt/X2fZJei
	 yoV3ghAroVVCA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sdVnd-0032l0-9D;
	Mon, 12 Aug 2024 15:13:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: thunder_bgx: Fix netdev structure allocation
Date: Mon, 12 Aug 2024 15:13:22 +0100
Message-Id: <20240812141322.1742918-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, leitao@debian.org, sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Commit 94833addfaba ("net: thunderx: Unembed netdev structure") had
a go at dynamically allocating the netdev structures for the thunderx_bgx
driver.  This change results in my ThunderX box catching fire (to be fair,
it is what it does best).

The issues with this change are that:

- bgx_lmac_enable() is called *after* bgx_acpi_register_phy() and
  bgx_init_of_phy(), both expecting netdev to be a valid pointer.

- bgx_init_of_phy() populates the MAC addresses for *all* LMACs
  attached to a given BGX instance, and thus needs netdev for each of
  them to have been allocated.

There is a few things to be said about how the driver mixes LMAC and
BGX states which leads to this sorry state, but that's beside the point.

To address this, go back to a situation where all netdev structures
are allocated before the driver starts relying on them, and move the
freeing of these structures to driver removal. Someone brave enough
can always go and restructure the driver if they want.

Fixes: 94833addfaba ("net: thunderx: Unembed netdev structure")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 .../net/ethernet/cavium/thunder/thunder_bgx.c | 30 +++++++++++++------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index a40c266c37f2..608cc6af5af1 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1054,18 +1054,12 @@ static int phy_interface_mode(u8 lmac_type)
 
 static int bgx_lmac_enable(struct bgx *bgx, u8 lmacid)
 {
-	struct lmac *lmac, **priv;
+	struct lmac *lmac;
 	u64 cfg;
 
 	lmac = &bgx->lmac[lmacid];
 	lmac->bgx = bgx;
 
-	lmac->netdev = alloc_netdev_dummy(sizeof(struct lmac *));
-	if (!lmac->netdev)
-		return -ENOMEM;
-	priv = netdev_priv(lmac->netdev);
-	*priv = lmac;
-
 	if ((lmac->lmac_type == BGX_MODE_SGMII) ||
 	    (lmac->lmac_type == BGX_MODE_QSGMII) ||
 	    (lmac->lmac_type == BGX_MODE_RGMII)) {
@@ -1191,7 +1185,6 @@ static void bgx_lmac_disable(struct bgx *bgx, u8 lmacid)
 	    (lmac->lmac_type != BGX_MODE_10G_KR) && lmac->phydev)
 		phy_disconnect(lmac->phydev);
 
-	free_netdev(lmac->netdev);
 	lmac->phydev = NULL;
 }
 
@@ -1653,6 +1646,23 @@ static int bgx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bgx_get_qlm_mode(bgx);
 
+	for (lmac = 0; lmac < bgx->lmac_count; lmac++) {
+		struct lmac *lmacp, **priv;
+
+		lmacp = &bgx->lmac[lmac];
+		lmacp->netdev = alloc_netdev_dummy(sizeof(struct lmac *));
+
+		if (!lmacp->netdev) {
+			for (int i = 0; i < lmac; i++)
+				free_netdev(bgx->lmac[i].netdev);
+			err = -ENOMEM;
+			goto err_enable;
+		}
+
+		priv = netdev_priv(lmacp->netdev);
+		*priv = lmacp;
+	}
+
 	err = bgx_init_phy(bgx);
 	if (err)
 		goto err_enable;
@@ -1692,8 +1702,10 @@ static void bgx_remove(struct pci_dev *pdev)
 	u8 lmac;
 
 	/* Disable all LMACs */
-	for (lmac = 0; lmac < bgx->lmac_count; lmac++)
+	for (lmac = 0; lmac < bgx->lmac_count; lmac++) {
 		bgx_lmac_disable(bgx, lmac);
+		free_netdev(bgx->lmac[lmac].netdev);
+	}
 
 	pci_free_irq(pdev, GMPX_GMI_TX_INT, bgx);
 
-- 
2.39.2


