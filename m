Return-Path: <netdev+bounces-211125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA11B16BA8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 07:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551AD58225F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 05:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896F4241689;
	Thu, 31 Jul 2025 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rkCC40tH"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028991DE881
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940712; cv=none; b=VaEMLbD+bYkEZ68Hgc4iRK7fwHjmw0y8K0KpwVJtD1CDBCv98IcosLJwhv+DmjM5a8hZ5C8fifkcPfQDHpOuuk9DUKEBKV8EeCFJj2iWJxa9y3Q2RsW9tzeWMRHzASYuXDhkfZR9KgIEeZpiyFSnT7aoq8JELbrI7Adg/D7aGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940712; c=relaxed/simple;
	bh=rCqJQlJTFHDehaxYQM/bLWheTwkzmkTHvBA7R3YQuPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XyR7YiuyZH1aGAKNrquk2oPQ8/an/SqsUAieApjM3lXyWGqqlA7/YUCF3p/3W897ItKfdd0r4CT0bLbuzRi0y07v9rz85gdGNhchkDe9sdIS6UboRdQNjl1yKeke68BgYECOP83FXZKq33GOyT1C6+HSB6Uy52EyoRXOp/R3Y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rkCC40tH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753940697; x=1754545497;
	i=markus.stockhausen@gmx.de;
	bh=hx59p3QboF5j0gXEyHKilqo8R7GUEq2oaQqQoX4Klwg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rkCC40tH3s0BakDeu7dl8DtlgrXgHcVp8RW5jXcLNdH5kZMQ+hBRLA59rnSyXgq7
	 38Bd1rMqtJnV/QC8El/RSoHHuP/zE1mZlY8mpUm6TZTFMtcLk/ZOY0v4PB8w6fgT3
	 3EHIJGGhj1N0edMl0WDxwiFgtcb/KvyCEOs2e9pIkuUgpq957+iksLE8CMVm9G89n
	 rpOH/ND3qoZpjPoJ++1AVa+xGVVwryIlAHMZ+XKl7wyja3aZ2bpF5c+N+8JAxUGOb
	 0BCvUubI3D9HU9s1AJp2q90aIk8Ec10thU9vKiuvxOU+YDWELZKFlySN5I45pURlQ
	 2h8SXZQI8kODkQ3N1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9nxn-1umbQD3S7B-00CaSj; Thu, 31
 Jul 2025 07:44:56 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	daniel@makrotopia.org,
	netdev@vger.kernel.org,
	jan@3e8.eu
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH v2] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Thu, 31 Jul 2025 01:44:45 -0400
Message-ID: <20250731054445.580474-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMcQCcjbikXz2kfk/B1K4We9bWxJekoZnhAolEahhaGjRLF2ctl
 5wPXZxuR9OgJ+qhRaTrJ3tfTQOG/Eqm1pdg5dryrIqKCbAsttNrf9w023KkVQ/5BSuok36d
 BCqIw/MnLQ1fExSm7JzafLtPkybT7oaBjSonKpHyWZYaUkzOztOfFXuGxBrJSCgnBYKA3P+
 EmRODWGp6rRwf6yzLynkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8Wf+BPLrpE8=;gT9yWXkHK9dUI6Q3jx/EiF/DgfM
 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
 Yg==

The RTL8226-CG can be found on devices like the Zyxel XGS1210-12. These
are driven by a Realtek RTL9302B SoC that has phy hardware polling
in the background. One must decide if a port is polled via c22 or c45.
Additionally the hardware disables MMD access in c22 mode. For reference
see mdio-realtek-rtl9300 driver. As this PHY is mostly used in Realtek
switches Convert the phy to a c45-only function set.

Because of these limitations the RTL8226 is not working at all in the
current switches. A "hacked" bus that toggles the mode for each c22/c45
access was used to get a "before status". But that is slow and producec
wrong results in the MAC polling status registers.

The RTL8226 seems to support proper MDIO_PMA_EXTABLE flags. So
genphy_c45_pma_read_abilities() can conveniently call
genphy_c45_pma_read_ext_abilities() and 10/100/1000 is populated right.

Outputs before:

Settings for lan9:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Twisted Pair
        PHYAD: 24
        Transceiver: external
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

Outputs with this commit:

Settings for lan9:
        Supported ports: [ TP ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Supported pause frame use: Symmetric Receive-only
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                2500baseT/Full
        Advertised pause frame use: Symmetric Receive-only
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Unknown! (255)
        Port: Twisted Pair
        PHYAD: 24
        Transceiver: external
        Auto-negotiation: on
        MDI-X: Unknown
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
Changes in v2:
- Added before/after status in commit message

=2D--
 drivers/net/phy/realtek/realtek_main.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/real=
tek/realtek_main.c
index dd0d675149ad..8bc68b31cd31 100644
=2D-- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1280,6 +1280,21 @@ static int rtl822x_c45_read_status(struct phy_devic=
e *phydev)
 	return 0;
 }
=20
+static int rtl822x_c45_soft_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret =3D phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
+			     MDIO_CTRL1_RESET, MDIO_CTRL1_RESET);
+	if (ret < 0)
+		return ret;
+
+	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PMAPMD,
+					 MDIO_CTRL1, val,
+					 !(val & MDIO_CTRL1_RESET),
+					 5000, 100000, true);
+}
+
 static int rtl822xb_c45_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -1675,11 +1690,12 @@ static struct phy_driver realtek_drvs[] =3D {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           =3D "RTL8226-CG 2.5Gbps PHY",
-		.get_features   =3D rtl822x_get_features,
-		.config_aneg    =3D rtl822x_config_aneg,
-		.read_status    =3D rtl822x_read_status,
-		.suspend        =3D genphy_suspend,
-		.resume         =3D rtlgen_resume,
+		.soft_reset     =3D rtl822x_c45_soft_reset,
+		.get_features   =3D rtl822x_c45_get_features,
+		.config_aneg    =3D rtl822x_c45_config_aneg,
+		.read_status    =3D rtl822x_c45_read_status,
+		.suspend        =3D genphy_c45_pma_suspend,
+		.resume         =3D rtlgen_c45_resume,
 		.read_page      =3D rtl821x_read_page,
 		.write_page     =3D rtl821x_write_page,
 	}, {
=2D-=20
2.47.0


