Return-Path: <netdev+bounces-144051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFC39C572C
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D81EB2FCF2
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910502259D6;
	Tue, 12 Nov 2024 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="IRdPVpSC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ifEJK3xL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71D2259C2;
	Tue, 12 Nov 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408959; cv=none; b=ou/SSe1ykNGzA3RkDYvD5pTu0NKRF5Nb2wWosLKVPWgbuRKIoSAYrSDK5mOfLnA6415+4YHwlfKCya4YRa9MF6u+NzLzPd8EsQ8oL0lFXhy1ocWeIo1hIL2OhzCKCyZodK+SC2LD4viCkVNCsWi1bnosXkC/3m7aRCI9BWD7+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408959; c=relaxed/simple;
	bh=dYUTeNmtAQ8X8gMz0q9BALSEM0DhK8omLem364dEbWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqOIVAObSLglswjyoILj4YRRpeCcRmPSNFL2t/rn+frt8BgUYrCw9WBBBoTaiEvt12a2hUz8Fiqlzr8/TEj8l5pco3jr6uF6OlXcSwTXmHKil6rp0Awhv9CrwFtueWSUASrYNH6bZvetEXImNBvCGA+Y/vQtb0KMdLHISgWSxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=IRdPVpSC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ifEJK3xL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9916D25401D0;
	Tue, 12 Nov 2024 05:55:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 05:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731408956; x=
	1731495356; bh=7RBDUfleD6Ixf368mtQOm0zVnbqIdDQIGho2QbrKN5A=; b=I
	RdPVpSCWvOc2+LNyPsl1BKtw7avQj+Okw5pUIIuyhv448UVd2Yqxu4sUcQHhUatO
	V9PynE2GQKkIpC28SlkKroTN21tazmjv+JlR4iOFz5UX59VJXclFNrb39pNgBijp
	acYWHUXZqIIzzusQ+JPKE7CPEmDANWsP9zTMd5q8EIvCfriR81OJCnm/h7iBWbJB
	dTbAsVknu7zN3zVHTDxU9qxmu6rehARccrXT12gHJW9aha1evNxx/X9YIKjbr+92
	hH0IxBlGie4weOxKYhoCgCUBaKULjID5sqZD2tZZVDOiynNLPg+s42jp91R3f4MT
	7c4LPjCj81RYujXqT0sbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731408956; x=1731495356; bh=7
	RBDUfleD6Ixf368mtQOm0zVnbqIdDQIGho2QbrKN5A=; b=ifEJK3xLRkDAIbXqy
	VsJixwXvY75DzN02ptdxaZml8Wfss7KO0SxBOzDpH36aPQs+z8p5A0YqGhADl+In
	enViNYpMrBr40jgFOhrcKdAl9RjmwUmJSSiZGk11N+1ISzDMpEy0Zg7+OPPfP9jq
	SXpRmkrUoihNrciZOu5NJr0EwkDZImB18DDAAOhQbBCerql++5vNvkPIHh8TMpxN
	5HQ/MVXNloyIlXSG1+YwmBfoPpbVx1azQH7BsXTFmxwx3fbN8k/C6C1DWxyxn11+
	qPqzLi8depLgpmyym4tZ9oGTQc6FkyryW1V1ZgVJhg5LoLBINBKQy+J2j54pEPvb
	g3lOg==
X-ME-Sender: <xms:PDQzZ5uz17B_fRDuJ4bG7QEbk1Mcp466nhzMdYec3KZkOYJ_KjPaAA>
    <xme:PDQzZyfXDlzn3GdVAeWPpo9ugBNWEGTySoXVgQqIL4eACUa9vg90y-uGGvK2odPWV
    xptXQ5lhUH2upJfavI>
X-ME-Received: <xmr:PDQzZ8z98qiDzVkacve5BMEMWDiCf-yeAbcDC27oOV7-8dide6PC2UGxedFE2rWms2LIoe8-U3dT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthho
    pegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrlhhishhtrghirhdvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigu
    tgdrtghomh
X-ME-Proxy: <xmx:PDQzZwPEbmRfjjrkyIhHTQH5CJQ9LXhOy4_5-ynRo97SjSc4NdIwDQ>
    <xmx:PDQzZ5_rS9DlvktTkm9hiog5MUc6Fx8LMewHN9KAhC8HMur8A_qeiQ>
    <xmx:PDQzZwXJfn-AtTWlvNy8GPjbHVSnXN4nJ18LaMiZj1X7qhkC2g2E-A>
    <xmx:PDQzZ6emz0r7saIODLwUy7gY5a81VmZvcz0V1_6o8qSctYGrXBeIfA>
    <xmx:PDQzZyN5iI1YzfgW7re2jfUUqLqeWRLMsxSAaXaUDbE9oYYJgxPKxGQH>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:55:53 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	hkallweit1@gmail.com,
	andrew@lunn.ch,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] mdio: Remove mdio45_ethtool_gset_npage()
Date: Tue, 12 Nov 2024 20:54:30 +1000
Message-ID: <20241112105430.438491-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112105430.438491-1-alistair@alistair23.me>
References: <20241112105430.438491-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The mdio45_ethtool_gset_npage() function isn't called, so let's remove
it.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/net/mdio.c   | 172 -------------------------------------------
 include/linux/mdio.h |   3 -
 2 files changed, 175 deletions(-)

diff --git a/drivers/net/mdio.c b/drivers/net/mdio.c
index e08c90ac0c6e..f67a4d4005e7 100644
--- a/drivers/net/mdio.c
+++ b/drivers/net/mdio.c
@@ -166,178 +166,6 @@ static u32 mdio45_get_an(const struct mdio_if_info *mdio, u16 addr)
 	return result;
 }
 
-/**
- * mdio45_ethtool_gset_npage - get settings for ETHTOOL_GSET
- * @mdio: MDIO interface
- * @ecmd: Ethtool request structure
- * @npage_adv: Modes currently advertised on next pages
- * @npage_lpa: Modes advertised by link partner on next pages
- *
- * The @ecmd parameter is expected to have been cleared before calling
- * mdio45_ethtool_gset_npage().
- *
- * Since the CSRs for auto-negotiation using next pages are not fully
- * standardised, this function does not attempt to decode them.  The
- * caller must pass them in.
- */
-void mdio45_ethtool_gset_npage(const struct mdio_if_info *mdio,
-			       struct ethtool_cmd *ecmd,
-			       u32 npage_adv, u32 npage_lpa)
-{
-	int reg;
-	u32 speed;
-
-	BUILD_BUG_ON(MDIO_SUPPORTS_C22 != ETH_MDIO_SUPPORTS_C22);
-	BUILD_BUG_ON(MDIO_SUPPORTS_C45 != ETH_MDIO_SUPPORTS_C45);
-
-	ecmd->transceiver = XCVR_INTERNAL;
-	ecmd->phy_address = mdio->prtad;
-	ecmd->mdio_support =
-		mdio->mode_support & (MDIO_SUPPORTS_C45 | MDIO_SUPPORTS_C22);
-
-	reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-			      MDIO_CTRL2);
-	switch (reg & MDIO_PMA_CTRL2_TYPE) {
-	case MDIO_PMA_CTRL2_10GBT:
-	case MDIO_PMA_CTRL2_1000BT:
-	case MDIO_PMA_CTRL2_100BTX:
-	case MDIO_PMA_CTRL2_10BT:
-		ecmd->port = PORT_TP;
-		ecmd->supported = SUPPORTED_TP;
-		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-				      MDIO_SPEED);
-		if (reg & MDIO_SPEED_10G)
-			ecmd->supported |= SUPPORTED_10000baseT_Full;
-		if (reg & MDIO_PMA_SPEED_1000)
-			ecmd->supported |= (SUPPORTED_1000baseT_Full |
-					    SUPPORTED_1000baseT_Half);
-		if (reg & MDIO_PMA_SPEED_100)
-			ecmd->supported |= (SUPPORTED_100baseT_Full |
-					    SUPPORTED_100baseT_Half);
-		if (reg & MDIO_PMA_SPEED_10)
-			ecmd->supported |= (SUPPORTED_10baseT_Full |
-					    SUPPORTED_10baseT_Half);
-		ecmd->advertising = ADVERTISED_TP;
-		break;
-
-	case MDIO_PMA_CTRL2_10GBCX4:
-		ecmd->port = PORT_OTHER;
-		ecmd->supported = 0;
-		ecmd->advertising = 0;
-		break;
-
-	case MDIO_PMA_CTRL2_10GBKX4:
-	case MDIO_PMA_CTRL2_10GBKR:
-	case MDIO_PMA_CTRL2_1000BKX:
-		ecmd->port = PORT_OTHER;
-		ecmd->supported = SUPPORTED_Backplane;
-		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-				      MDIO_PMA_EXTABLE);
-		if (reg & MDIO_PMA_EXTABLE_10GBKX4)
-			ecmd->supported |= SUPPORTED_10000baseKX4_Full;
-		if (reg & MDIO_PMA_EXTABLE_10GBKR)
-			ecmd->supported |= SUPPORTED_10000baseKR_Full;
-		if (reg & MDIO_PMA_EXTABLE_1000BKX)
-			ecmd->supported |= SUPPORTED_1000baseKX_Full;
-		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-				      MDIO_PMA_10GBR_FECABLE);
-		if (reg & MDIO_PMA_10GBR_FECABLE_ABLE)
-			ecmd->supported |= SUPPORTED_10000baseR_FEC;
-		ecmd->advertising = ADVERTISED_Backplane;
-		break;
-
-	/* All the other defined modes are flavours of optical */
-	default:
-		ecmd->port = PORT_FIBRE;
-		ecmd->supported = SUPPORTED_FIBRE;
-		ecmd->advertising = ADVERTISED_FIBRE;
-		break;
-	}
-
-	if (mdio->mmds & MDIO_DEVS_AN) {
-		ecmd->supported |= SUPPORTED_Autoneg;
-		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_AN,
-				      MDIO_CTRL1);
-		if (reg & MDIO_AN_CTRL1_ENABLE) {
-			ecmd->autoneg = AUTONEG_ENABLE;
-			ecmd->advertising |=
-				ADVERTISED_Autoneg |
-				mdio45_get_an(mdio, MDIO_AN_ADVERTISE) |
-				npage_adv;
-		} else {
-			ecmd->autoneg = AUTONEG_DISABLE;
-		}
-	} else {
-		ecmd->autoneg = AUTONEG_DISABLE;
-	}
-
-	if (ecmd->autoneg) {
-		u32 modes = 0;
-		int an_stat = mdio->mdio_read(mdio->dev, mdio->prtad,
-					      MDIO_MMD_AN, MDIO_STAT1);
-
-		/* If AN is complete and successful, report best common
-		 * mode, otherwise report best advertised mode. */
-		if (an_stat & MDIO_AN_STAT1_COMPLETE) {
-			ecmd->lp_advertising =
-				mdio45_get_an(mdio, MDIO_AN_LPA) | npage_lpa;
-			if (an_stat & MDIO_AN_STAT1_LPABLE)
-				ecmd->lp_advertising |= ADVERTISED_Autoneg;
-			modes = ecmd->advertising & ecmd->lp_advertising;
-		}
-		if ((modes & ~ADVERTISED_Autoneg) == 0)
-			modes = ecmd->advertising;
-
-		if (modes & (ADVERTISED_10000baseT_Full |
-			     ADVERTISED_10000baseKX4_Full |
-			     ADVERTISED_10000baseKR_Full)) {
-			speed = SPEED_10000;
-			ecmd->duplex = DUPLEX_FULL;
-		} else if (modes & (ADVERTISED_1000baseT_Full |
-				    ADVERTISED_1000baseT_Half |
-				    ADVERTISED_1000baseKX_Full)) {
-			speed = SPEED_1000;
-			ecmd->duplex = !(modes & ADVERTISED_1000baseT_Half);
-		} else if (modes & (ADVERTISED_100baseT_Full |
-				    ADVERTISED_100baseT_Half)) {
-			speed = SPEED_100;
-			ecmd->duplex = !!(modes & ADVERTISED_100baseT_Full);
-		} else {
-			speed = SPEED_10;
-			ecmd->duplex = !!(modes & ADVERTISED_10baseT_Full);
-		}
-	} else {
-		/* Report forced settings */
-		reg = mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-				      MDIO_CTRL1);
-		speed = (((reg & MDIO_PMA_CTRL1_SPEED1000) ? 100 : 1)
-			 * ((reg & MDIO_PMA_CTRL1_SPEED100) ? 100 : 10));
-		ecmd->duplex = (reg & MDIO_CTRL1_FULLDPLX ||
-				speed == SPEED_10000);
-	}
-
-	ethtool_cmd_speed_set(ecmd, speed);
-
-	/* 10GBASE-T MDI/MDI-X */
-	if (ecmd->port == PORT_TP
-	    && (ethtool_cmd_speed(ecmd) == SPEED_10000)) {
-		switch (mdio->mdio_read(mdio->dev, mdio->prtad, MDIO_MMD_PMAPMD,
-					MDIO_PMA_10GBT_SWAPPOL)) {
-		case MDIO_PMA_10GBT_SWAPPOL_ABNX | MDIO_PMA_10GBT_SWAPPOL_CDNX:
-			ecmd->eth_tp_mdix = ETH_TP_MDI;
-			break;
-		case 0:
-			ecmd->eth_tp_mdix = ETH_TP_MDI_X;
-			break;
-		default:
-			/* It's complicated... */
-			ecmd->eth_tp_mdix = ETH_TP_MDI_INVALID;
-			break;
-		}
-	}
-}
-EXPORT_SYMBOL(mdio45_ethtool_gset_npage);
-
 /**
  * mdio45_ethtool_ksettings_get_npage - get settings for ETHTOOL_GLINKSETTINGS
  * @mdio: MDIO interface
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index c63f43645d50..3c3deac57894 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -165,9 +165,6 @@ extern int mdio_set_flag(const struct mdio_if_info *mdio,
 			 bool sense);
 extern int mdio45_links_ok(const struct mdio_if_info *mdio, u32 mmds);
 extern int mdio45_nway_restart(const struct mdio_if_info *mdio);
-extern void mdio45_ethtool_gset_npage(const struct mdio_if_info *mdio,
-				      struct ethtool_cmd *ecmd,
-				      u32 npage_adv, u32 npage_lpa);
 extern void
 mdio45_ethtool_ksettings_get_npage(const struct mdio_if_info *mdio,
 				   struct ethtool_link_ksettings *cmd,
-- 
2.47.0


