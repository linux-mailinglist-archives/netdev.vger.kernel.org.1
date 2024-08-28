Return-Path: <netdev+bounces-122702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED129623F8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53173281F7A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7526916C6A0;
	Wed, 28 Aug 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6RG9tFR"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5016A924;
	Wed, 28 Aug 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838676; cv=none; b=NUxJ927BWbciv3Lb97tdGpssHaSLcWEAMouqQYYrC3nOBW6uFl/b6TzX+sN79qnhglRQExWyOkxcaqPCQIQUX9htYuSY5yPuSINhAxBhnQm+/quZ2rWE2oyundVR+wTCu6Nfce116Y0LPJCPmiOjzujqbrBAOfFYs3FFyIOGyJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838676; c=relaxed/simple;
	bh=N6DsjCzfey2xM65hnz0gGl9pd5uYV8XNkd6yE/JpIEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCYIK7jwNpee1WzIjHOSYOMNXWX8cZ3SvAg4/iaCznC0q/fZBdTH1lZb0Ixbv3vT3KtMQow54alldT7p58FFhQT1h1DbRx/ZWUJOfQ9VP4u3vUS/CErJnMrhVGFkJfB3EeHNjBk04ueaXQEZe17cI1ohIXBvcoOxqA0TcEjQQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6RG9tFR; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E65F21C0005;
	Wed, 28 Aug 2024 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724838672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDXRMrWeQ8aU4zb8s3kfP4GpGlT2hUzH6QoOjKPcTqE=;
	b=D6RG9tFR5E0M9i0cqIRI1ADlaOQ3aobCwSQcYws9WO1z71VuMAfc/yzeGKlz/AJgNw+7D+
	606JZ6tojLqecjEQPxX6bl/UqEJSy9r2qKgMy6l2OkcmVwyFiGlmPOJgOAbv1Y/3FVuZx3
	Kdyx9vzvwJI5S5gGHRphEyUojFUgrJsnkG/D5oKljJ2+APrINXdhtrqIvUlKfi7y4HNtxm
	DG0J4gSyFJnycRlhy/AcHmuSvc7t8ZnaIJ4JD+uaskDNxXqVCuC8z6lswqP6zfVRz1V7gw
	vVYLlxNmiqqUxY62+POHZMlCnwmc31j2oivFl7+mOp3BOi7bnl08CUHha0RZGQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next 5/6] net: ethernet: fs_enet: fcc: use macros for speed and duplex values
Date: Wed, 28 Aug 2024 11:51:01 +0200
Message-ID: <20240828095103.132625-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
References: <20240828095103.132625-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The PHY speed and duplex should be manipulated using the SPEED_XXX and
DUPLEX_XXX macros available. Use it in the fcc, fec and scc MAC for fs_enet.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c | 4 ++--
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 2 +-
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
index add062928d99..056909156b4f 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fcc.c
@@ -361,7 +361,7 @@ static void restart(struct net_device *dev)
 
 	/* adjust to speed (for RMII mode) */
 	if (fpi->use_rmii) {
-		if (dev->phydev->speed == 100)
+		if (dev->phydev->speed == SPEED_100)
 			C8(fcccp, fcc_gfemr, 0x20);
 		else
 			S8(fcccp, fcc_gfemr, 0x20);
@@ -387,7 +387,7 @@ static void restart(struct net_device *dev)
 		S32(fccp, fcc_fpsmr, FCC_PSMR_RMII);
 
 	/* adjust to duplex mode */
-	if (dev->phydev->duplex)
+	if (dev->phydev->duplex == DUPLEX_FULL)
 		S32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
 	else
 		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index f75acb3b358f..855ee9e3f042 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -309,7 +309,7 @@ static void restart(struct net_device *dev)
 	/*
 	 * adjust to duplex mode
 	 */
-	if (dev->phydev->duplex) {
+	if (dev->phydev->duplex == DUPLEX_FULL) {
 		FC(fecp, r_cntrl, FEC_RCNTRL_DRT);
 		FS(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD enable */
 	} else {
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 29ba0048396b..9e5e29312c27 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -338,7 +338,7 @@ static void restart(struct net_device *dev)
 	W16(sccp, scc_psmr, SCC_PSMR_ENCRC | SCC_PSMR_NIB22);
 
 	/* Set full duplex mode if needed */
-	if (dev->phydev->duplex)
+	if (dev->phydev->duplex == DUPLEX_FULL)
 		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
 
 	/* Restore multicast and promiscuous settings */
-- 
2.45.2


