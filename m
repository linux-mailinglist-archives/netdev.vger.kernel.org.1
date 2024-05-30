Return-Path: <netdev+bounces-99358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B08D49B5
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B40282489
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEB17C7BC;
	Thu, 30 May 2024 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="bjtP1dUN"
X-Original-To: netdev@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED261761B1
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065099; cv=none; b=hacRv8JjYIpC/jAyX5AZyRnbW9oYmBpU0S+N7cGfLydUvxaXa9Nn9EAjrQLVAF8RVzJIu6yL4U4GbEo3D7bwYX94stY1vFz6+RwBC85w10NoPZb7VIch8g1f+tMY1G/O1adLReeQfckIwXiiu6e13CyAZ+orM9T4BzhTkW/FrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065099; c=relaxed/simple;
	bh=rLioc4IXEvqTemHi7lRZSVNRa2Q2nkZVJuSWw3lrp+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlAjYcBCGX+kPdvxM+mWZ9qRAv/tZMZVAFvM3PVFkzW+9Xp1MVeiXpUzfLmIbGrnPCOVkRMgWRAhj+VtjJzWdIUAJMGfjyMFszAnIYVhFcqpwdpW9d+l+N5xZq2SVJwo/F2VyKyyu9CjluqGfjJwHFSqZCvyiT5EIiQ5TBe+NqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=bjtP1dUN; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B0BE29C5A25;
	Thu, 30 May 2024 06:25:09 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5G9ZAmsJRaP8; Thu, 30 May 2024 06:25:08 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A2F859C5A15;
	Thu, 30 May 2024 06:25:08 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A2F859C5A15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1717064708; bh=yve/1q3P+SWraA1Z3gh6daavfsFifTh+55Sw/l4aOCE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=bjtP1dUNIjMX9Z8mUOFKBhoxpH2J/kbCwMo55FbPLrdFM6Pb1RQohK7XhwtlRlPYP
	 qxA/K2hA6fDt4wew8hzI+qZfZgZYNBobzC2zmAbDwfr62bK23+j24LP1HwoqngvvJm
	 MIPDqye06P96DU82s8ltt256UR6BaoeUs6GZFFVLasDcMFAbTHkghpSc0iXHHp22MR
	 r+4/xnRa2UCPOaYu/zu5qjGDgmgIRlv7I08NPRxLzcHpaCDpTlWhH09RyLECWMYZxB
	 /hh8691AXp/D0Q7Jqq1uubOTcRspZst6xKtc/B6jDIAC1sz0r3z2hXPFe8chYx2XEl
	 n9II1wgXLnjQw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id noKKc1kjr7G5; Thu, 30 May 2024 06:25:08 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (lmontsouris-657-1-69-118.w80-15.abo.wanadoo.fr [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B709B9C5A16;
	Thu, 30 May 2024 06:25:07 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	woojung.huh@microchip.com,
	embedded-discuss@lists.savoirfairelinux.net,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 1/5] net: phy: micrel: add Microchip KSZ 9897 Switch PHY support
Date: Thu, 30 May 2024 10:24:32 +0000
Message-Id: <20240530102436.226189-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240530102436.226189-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a DSA driver for microchip,ksz9897 which can be controlled
through SPI or I2C. This patch adds support for it's CPU ports PHYs to
also allow network access to the switch's CPU port.

The CPU ports PHYs of the KSZ9897 are not documented in the datasheet.
They weirdly use the same PHY ID as the KSZ8081, which is a different
PHY and that driver isn't compatible with KSZ9897. Before this patch,
the KSZ8081 driver was used for the CPU ports of the KSZ9897 but the
link would never come up.

A new driver for the KSZ9897 is added, based on the compatible KSZ87XX.
I could not test if Gigabit Ethernet works, but the link comes up and
can successfully allow packets to be sent and received with DSA tags.

To resolve the KSZ8081/KSZ9897 phy_id conflicts, I could not find any
stable register to distinguish them. The crude solution is to check if a
KSZ9897 DSA switch is present in the devicetree. A discussion to find
better alternatives had been opened with the Microchip team, with no
response yet.

See https://lore.kernel.org/all/20220207174532.362781-1-enguerrand.de-rib=
aucourt@savoirfairelinux.com/

Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 drivers/net/phy/micrel.c | 46 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 13e30ea7eec5..99322a3c3869 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -16,7 +16,7 @@
  *			   ksz8081, ksz8091,
  *			   ksz8061,
  *		Switch : ksz8873, ksz886x
- *			 ksz9477, lan8804
+ *			 ksz9477, ksz9897, lan8804
  */
=20
 #include <linux/bitfield.h>
@@ -769,6 +769,38 @@ static int ksz8051_match_phy_device(struct phy_devic=
e *phydev)
 	return ksz8051_ksz8795_match_phy_device(phydev, true);
 }
=20
+static int ksz8081_ksz9897_match_phy_device(struct phy_device *phydev,
+					    const bool ksz_8081)
+{
+	/* KSZ8081 and KSZ9897 CPU port share the same exact PHY ID. Despite dr=
iver
+	 * differences. None of the PHY registers allow to distinguish them
+	 * accurately. The driver initialization order may also start with the =
PHY
+	 * matching before the DSA switch node is attached to the CPU port. We =
fall
+	 * back to looking up if any KSZ9897 is present in the devicetree.
+	 */
+	struct device_node *node;
+
+	if (!phy_id_compare(phydev->phy_id, PHY_ID_KSZ8081, MICREL_PHY_ID_MASK)=
)
+		return 0;
+
+	node =3D of_find_compatible_node(NULL, NULL, "microchip,ksz9897");
+
+	if (ksz_8081)
+		return node =3D=3D NULL;
+	else
+		return node !=3D NULL;
+}
+
+static int ksz8081_match_phy_device(struct phy_device *phydev)
+{
+	return ksz8081_ksz9897_match_phy_device(phydev, true);
+}
+
+static int ksz9897_match_phy_device(struct phy_device *phydev)
+{
+	return ksz8081_ksz9897_match_phy_device(phydev, false);
+}
+
 static int ksz8081_config_init(struct phy_device *phydev)
 {
 	/* KSZPHY_OMSO_FACTORY_TEST is set at de-assertion of the reset line
@@ -5300,9 +5332,7 @@ static struct phy_driver ksphy_driver[] =3D {
 	.suspend	=3D kszphy_suspend,
 	.resume		=3D kszphy_resume,
 }, {
-	.phy_id		=3D PHY_ID_KSZ8081,
 	.name		=3D "Micrel KSZ8081 or KSZ8091",
-	.phy_id_mask	=3D MICREL_PHY_ID_MASK,
 	.flags		=3D PHY_POLL_CABLE_TEST,
 	/* PHY_BASIC_FEATURES */
 	.driver_data	=3D &ksz8081_type,
@@ -5316,6 +5346,7 @@ static struct phy_driver ksphy_driver[] =3D {
 	.get_sset_count =3D kszphy_get_sset_count,
 	.get_strings	=3D kszphy_get_strings,
 	.get_stats	=3D kszphy_get_stats,
+	.match_phy_device =3D ksz8081_match_phy_device,
 	.suspend	=3D kszphy_suspend,
 	.resume		=3D kszphy_resume,
 	.cable_test_start	=3D ksz886x_cable_test_start,
@@ -5486,6 +5517,15 @@ static struct phy_driver ksphy_driver[] =3D {
 	.suspend	=3D genphy_suspend,
 	.resume		=3D genphy_resume,
 	.get_features	=3D ksz9477_get_features,
+}, {
+	.name		=3D "Microchip KSZ9897 Switch",
+	/* PHY_BASIC_FEATURES */
+	.config_init	=3D kszphy_config_init,
+	.config_aneg	=3D ksz8873mll_config_aneg,
+	.read_status	=3D ksz8873mll_read_status,
+	.match_phy_device =3D ksz9897_match_phy_device,
+	.suspend	=3D genphy_suspend,
+	.resume		=3D genphy_resume,
 } };
=20
 module_phy_driver(ksphy_driver);
--=20
2.34.1


