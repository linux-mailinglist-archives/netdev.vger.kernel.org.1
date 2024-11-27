Return-Path: <netdev+bounces-147569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053599DA43C
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8345168D36
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218A18E373;
	Wed, 27 Nov 2024 08:56:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA0189919;
	Wed, 27 Nov 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.187.100.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697807; cv=none; b=R5K5SqLJgE2izY7Ka81b1sdpO5kuvEyPtTrJ/9joImVKpauCuWsbzPyD97BG1/Lx9ep0oUcZ/gUv1Shf94hpqrmxU5BBRrQsfTcccqw+q1GUNN+e/EzMW2mISjZVGEJyUADeT9bOcWfvt2Mqk6QAjBG1i5GsgAnmGZBqvqrFnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697807; c=relaxed/simple;
	bh=VIcHmDDOxRDLoUecxyIPqKRaoRticSvdvMburslHBy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdNLJbOgPGrd33h5yXCrpgSE6V46O1MVw+OEWKM3fqpUK/kt2O9DQ/D3LzRTpoOJm9QSdTskOLHmDdsP5xOT9IHoqMh6C92O111tMWYrFfsPLM/THoW6tjFa1i7KtsHv6QM3DQ9EYzGP7rRU/qxaOrOlmpcc1hkHRpo8jpvpQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl; spf=pass smtp.mailfrom=piap.pl; arc=none smtp.client-ip=195.187.100.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=piap.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piap.pl
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
	by ni.piap.pl (Postfix) with ESMTPS id C95FDC3EEACB;
	Wed, 27 Nov 2024 09:56:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl C95FDC3EEACB
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: netdev <netdev@vger.kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jose Ignacio Tornos Martinez
 <jtornosm@redhat.com>, Ming Lei <ming.lei@redhat.com> 
Subject: [PATCH] PHY: Fix no autoneg corner case
Sender: khalasa@piap.pl
Date: Wed, 27 Nov 2024 09:56:42 +0100
Message-ID: <m3plmhhx6d.fsf@t19.piap.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

phydev->autoneg appears to indicate if autonegotiation is enabled or
not. Unfortunately it's initially set based on the supported capability
rather than the actual hw setting. While in most cases there is no
difference (i.e., autoneg is supported and on by default), certain
adapters (e.g. fiber optics) use fixed settings, configured in hardware.

Now autoneg flag is set only when it's supported and actually used.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 366cf3b2cbb0..6858f512558b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3453,7 +3453,7 @@ static int phy_probe(struct device *dev)
 	struct phy_device *phydev =3D to_phy_device(dev);
 	struct device_driver *drv =3D phydev->mdio.dev.driver;
 	struct phy_driver *phydrv =3D to_phy_driver(drv);
-	int err =3D 0;
+	int err =3D 0, bmcr;
=20
 	phydev->drv =3D phydrv;
=20
@@ -3495,8 +3495,12 @@ static int phy_probe(struct device *dev)
 	if (err)
 		goto out;
=20
+	err =3D bmcr =3D phy_read(phydev, MII_BMCR);
+	if (err < 0)
+		goto out;
+
 	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-			       phydev->supported))
+			       phydev->supported) || !(bmcr & BMCR_ANENABLE))
 		phydev->autoneg =3D 0;
=20
 	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa

