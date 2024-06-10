Return-Path: <netdev+bounces-102286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F271690237C
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663A02891A1
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1A13D532;
	Mon, 10 Jun 2024 14:03:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB878563F;
	Mon, 10 Jun 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028185; cv=none; b=f+yyhp4BwYzNS69lJwvJZc51Jhryju5Npg2IB/JmHADsIdnbT8vpN0R0lxPXZMCNJMI+5w7zinsA3mtEUH04kandqGSFvzhl/1gXAUUrhMOsQ2WSdT1BLFeAep3k1d618q1V8WA3Ar126LdTJz82Qj93GBg9ngpaxxXBxVWa3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028185; c=relaxed/simple;
	bh=7DssHY8Rf/yi7kgJRtq3EL0+CgAbp7BhDVSVE7se7lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtYobyvTXPOUtVliU6zTnvRLH8kTlQQoTHJj2zwiBt1iVkZC1/mJOUfkdbwrqomMt2lu0gQ7LUf4KhIjF1jJDPXudqxc1Zil1zsgAmZyyaJnNnObrrM3lab6i8OoVwJEJ3yTuKeSJdCbXTtCo62zh4kdLWt02piCC1dqAZkFS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=9905c7c8d6=ms@dev.tdt.de>)
	id 1sGfby-00BfNb-7G; Mon, 10 Jun 2024 16:03:02 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sGfbx-00CSF8-La; Mon, 10 Jun 2024 16:03:01 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 6007E240053;
	Mon, 10 Jun 2024 16:03:01 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id EA697240050;
	Mon, 10 Jun 2024 16:03:00 +0200 (CEST)
Received: from mschiller1.dev.tdt.de (unknown [10.2.3.20])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id B880136F2E;
	Mon, 10 Jun 2024 16:03:00 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: martin.blumenstingl@googlemail.com,
	hauke@hauke-m.de,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ms@dev.tdt.de
Subject: [PATCH net-next v3 06/12] net: dsa: lantiq_gswip: do also enable or disable cpu port
Date: Mon, 10 Jun 2024 16:02:13 +0200
Message-ID: <20240610140219.2795167-7-ms@dev.tdt.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610140219.2795167-1-ms@dev.tdt.de>
References: <20240610140219.2795167-1-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1718028182-C0C438CF-494F020B/0/0

Before commit 74be4babe72f ("net: dsa: do not enable or disable non user
ports"), gswip_port_enable/disable() were also executed for the cpu port
in gswip_setup() which disabled the cpu port during initialization.

Let's restore this by removing the dsa_is_user_port checks. Also, let's
clean up the gswip_port_enable() function so that we only have to check
for the cpu port once. The operation reordering done here is safe.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/dsa/lantiq_gswip.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswi=
p.c
index c1f9419af35f..8ec329d0c136 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -695,13 +695,18 @@ static int gswip_port_enable(struct dsa_switch *ds,=
 int port,
 	struct gswip_priv *priv =3D ds->priv;
 	int err;
=20
-	if (!dsa_is_user_port(ds, port))
-		return 0;
-
 	if (!dsa_is_cpu_port(ds, port)) {
+		u32 mdio_phy =3D 0;
+
 		err =3D gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
+
+		if (phydev)
+			mdio_phy =3D phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
+
+		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
+				GSWIP_MDIO_PHYp(port));
 	}
=20
 	/* RMON Counter Enable for port */
@@ -714,16 +719,6 @@ static int gswip_port_enable(struct dsa_switch *ds, =
int port,
 	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
 			  GSWIP_SDMA_PCTRLp(port));
=20
-	if (!dsa_is_cpu_port(ds, port)) {
-		u32 mdio_phy =3D 0;
-
-		if (phydev)
-			mdio_phy =3D phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
-
-		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
-				GSWIP_MDIO_PHYp(port));
-	}
-
 	return 0;
 }
=20
@@ -731,9 +726,6 @@ static void gswip_port_disable(struct dsa_switch *ds,=
 int port)
 {
 	struct gswip_priv *priv =3D ds->priv;
=20
-	if (!dsa_is_user_port(ds, port))
-		return;
-
 	gswip_switch_mask(priv, GSWIP_FDMA_PCTRL_EN, 0,
 			  GSWIP_FDMA_PCTRLp(port));
 	gswip_switch_mask(priv, GSWIP_SDMA_PCTRL_EN, 0,
--=20
2.39.2


