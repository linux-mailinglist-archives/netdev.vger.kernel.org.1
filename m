Return-Path: <netdev+bounces-136365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DE9A1825
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 03:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B011C24227
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604E182B4;
	Thu, 17 Oct 2024 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KINz60jt"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C77A2D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130055; cv=none; b=KjisvBpK4Xq6WUdGDuZqJP797SFF0Bw86ZSOdhCYN5eNnt7KZjXC5WTQdFQtLtEKdvYNIbPq00dUhlBoth8/rDYLE0QeR7tvPI8nOZOowucU/gi+8P36DdpI4pGsze1LRaeNGNG93w4h1Vq+wLpWUEgd6m5+Z2NlY7ip1ZlqwYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130055; c=relaxed/simple;
	bh=DRMcYas5jTkuHE6fDhiJFW3CS1t85QDN3n3Ll859YmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b586bDGeCUD+awIixHgRdC4DDqCQF+fQiwZSQzBP3vOaFKdNssXh7pAQET1RPHyJ2u61jMd3j/5yeOijXcrJnEM8E0QN/HubBMnREOlOw149bLdg1542YA02VHJYg6caDcCtocyOCsJxgXsRfd5DPhsYGjm+WTausDzJuhmQjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=KINz60jt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 966AC2C0372;
	Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729130049;
	bh=J87wGS51xjrITb3DT9w7rSdBrnVW7k2HNOqiCdPmMNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KINz60jt0RzNpOvqWEsX5Esvzl3W4y00Jc3CrbmXDvnGoh1aWGQFUI+IzFZkPmmhG
	 cwwyB4a1+DklXZwqmmsN+YA1OEEB4gNN3w1jxVzMY/fzK0bXOXqxfccfQ6hG6IbOv9
	 uzohqvhkvETswweqsSM2rtR+QNvjUuN/kXnEP/280FkYXCcp/eZL+TzhXWUUPrSS1h
	 Y+ZqZ+pAxUkVvHevQ72zzs9ElGcVane7Rjo4dQuInT3hNUsIBslt8NtQJ3+WWkor7R
	 wUQ1Ztm9mDnBzdqQxAfU767LNrqCz1Jndgc/+sdZ7B6qGyqDipiKfNmnv/ZbgQWeOy
	 KT6HR4rmA5RRg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67106e410000>; Thu, 17 Oct 2024 14:54:09 +1300
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6DA7613EE32;
	Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id 6584A40A11; Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net-next] net: phy: aquantia: Add mdix config and reporting
Date: Thu, 17 Oct 2024 14:54:07 +1300
Message-ID: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67106e41 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=uGgpi8APxHEu2YRnv34A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for configuring MDI-X state of PHY.
Add reporting of resolved MDI-X state in status information.

Tested on AQR113C.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
 drivers/net/phy/aquantia/aquantia_main.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index 38d0dd5c80a4..8fe63a13b9f0 100644
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
+static int aqr_set_polarity(struct phy_device *phydev, int polarity)
+{
+	u16 val =3D 0;
+
+	switch (polarity) {
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
+	ret =3D aqr_set_polarity(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed =3D true;
+
 	if (phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return genphy_c45_pma_setup_forced(phydev);
=20
@@ -278,6 +315,14 @@ static int aqr_read_status(struct phy_device *phydev=
)
 				 val & MDIO_AN_RX_LP_STAT1_1000BASET_HALF);
 	}
=20
+	val =3D phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_STATUS1);
+	if (val < 0)
+		return val;
+	if (val & MDIO_AN_RESVD_VEND_STATUS1_MDIX)
+		phydev->mdix =3D ETH_TP_MDI_X;
+	else
+		phydev->mdix =3D ETH_TP_MDI;
+
 	return genphy_c45_read_status(phydev);
 }
=20
--=20
2.47.0


