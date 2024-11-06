Return-Path: <netdev+bounces-142539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6B9BF92B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29578281E90
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9463C20CCE7;
	Wed,  6 Nov 2024 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="nY4hwt+D"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F3824A3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931673; cv=none; b=nup7sPruel2svNSTFizMGloqhMxAcGUwVuFWO2PSY8d/cx6JuudOaZ916fNBKylhPk80PXbmTauxsIT1AjmgEnYy/MC/0mjFbGDH2iGeqbks1xoXycJ36DiFxMQ3ahPgbtVVMdUz8xonRZnOeHctq0aP4mYkWNIzaOY8JG+07fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931673; c=relaxed/simple;
	bh=/ltJRxxeRqhazNb+BzXmlDc1/j1rX/Q0zzTl/znvvaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLI9IUO88KHdEtzQNOo3GG2iLxacj7LoNOqtnXSgMp7YFtcxQMe/bQ9QBb/L+uOn+hGlFyFwPnkjLx6tfZqwgwzznvn2WaxIFp9L8uvZwSx9QfZrtiEYy/RLZaJ0ZW8UOixgvP5kfmsCV15iTj23UynAmC3wq7Rgxsz8NyYNslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=nY4hwt+D; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9590C2C01F6;
	Thu,  7 Nov 2024 11:21:00 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730931660;
	bh=c36n9aUbpZTu085KuVii6yBbMfoXLQ3MCyUi3chLmZ0=;
	h=From:To:Cc:Subject:Date:From;
	b=nY4hwt+DijYY1bHY/1DJBt/z9rX5lkQzEjUGtmwjju7V4ErhjGzZYDnRCvdmSeIZ1
	 KHVsp00A1hnpknygyQSoUcT/2zEs61kJ9M1c9gebOC7LafP2Uo10KeugCYeMHrqccu
	 C/zN7maQjKs489xTvhGlnH6W7bkzBDMiWonrASfEYPJYyaEOn8l59kr5tqhHpXwb28
	 0HQx00aOMex8GWZoR3IJLFEf4RtkVH7B/+KaDip1eUcIEAI2Q2cBumELHW3kw13OXr
	 TRoNnYcnkaXao3GDweKXmSmN5paTmuq5f/Cs766VtCW+sVWQQAXSI/4/x1Lw0eYWpT
	 zIF0ttTjYuf0Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672bebcc0000>; Thu, 07 Nov 2024 11:21:00 +1300
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 7C6E913ED6B;
	Thu,  7 Nov 2024 11:21:00 +1300 (NZDT)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id 7886540758; Thu,  7 Nov 2024 11:21:00 +1300 (NZDT)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net-next v2] net: phy: aquantia: Add mdix config and reporting
Date: Thu,  7 Nov 2024 11:20:57 +1300
Message-ID: <20241106222057.3965379-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672bebcc a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=ZB1B0HUU6VUEMc52-JgA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for configuring MDI-X state of PHY.
Add reporting of resolved MDI-X state in status information.

Tested on AQR113C.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
v2:
 - Renamed aqr_set_polarity to aqr_set_mdix
 - Guard MDI-X state reporting on genphy_c45_aneg_done
 - Link to v1: https://lore.kernel.org/netdev/20241017015407.256737-1-pau=
l.davey@alliedtelesis.co.nz/
---
 drivers/net/phy/aquantia/aquantia_main.c | 52 ++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index 38d0dd5c80a4..bb56a66d2a48 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -54,6 +54,12 @@
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
=20
+#define MDIO_AN_RESVD_VEND_PROV			0xc410
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_AUTO	0
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MDI	1
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MDIX	2
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MASK	GENMASK(1, 0)
+
 #define MDIO_AN_TX_VEND_STATUS1			0xc800
 #define MDIO_AN_TX_VEND_STATUS1_RATE_MASK	GENMASK(3, 1)
 #define MDIO_AN_TX_VEND_STATUS1_10BASET		0
@@ -64,6 +70,9 @@
 #define MDIO_AN_TX_VEND_STATUS1_5000BASET	5
 #define MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX	BIT(0)
=20
+#define MDIO_AN_RESVD_VEND_STATUS1		0xc810
+#define MDIO_AN_RESVD_VEND_STATUS1_MDIX		BIT(8)
+
 #define MDIO_AN_TX_VEND_INT_STATUS1		0xcc00
 #define MDIO_AN_TX_VEND_INT_STATUS1_DOWNSHIFT	BIT(1)
=20
@@ -155,12 +164,40 @@ static void aqr107_get_stats(struct phy_device *phy=
dev,
 	}
 }
=20
+static int aqr_set_mdix(struct phy_device *phydev, int mdix)
+{
+	u16 val =3D 0;
+
+	switch (mdix) {
+	case ETH_TP_MDI:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_MDIX;
+		break;
+	case ETH_TP_MDI_AUTO:
+	case ETH_TP_MDI_INVALID:
+	default:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_AUTO;
+		break;
+	}
+
+	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_P=
ROV,
+				      MDIO_AN_RESVD_VEND_PROV_MDIX_MASK, val);
+}
+
 static int aqr_config_aneg(struct phy_device *phydev)
 {
 	bool changed =3D false;
 	u16 reg;
 	int ret;
=20
+	ret =3D aqr_set_mdix(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed =3D true;
+
 	if (phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return genphy_c45_pma_setup_forced(phydev);
=20
@@ -278,6 +315,21 @@ static int aqr_read_status(struct phy_device *phydev=
)
 				 val & MDIO_AN_RX_LP_STAT1_1000BASET_HALF);
 	}
=20
+	val =3D genphy_c45_aneg_done(phydev);
+	if (val < 0)
+		return val;
+	if (val) {
+		val =3D phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_STATUS1);
+		if (val < 0)
+			return val;
+		if (val & MDIO_AN_RESVD_VEND_STATUS1_MDIX)
+			phydev->mdix =3D ETH_TP_MDI_X;
+		else
+			phydev->mdix =3D ETH_TP_MDI;
+	} else {
+		phydev->mdix =3D ETH_TP_MDI_INVALID;
+	}
+
 	return genphy_c45_read_status(phydev);
 }
=20
--=20
2.47.0


