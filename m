Return-Path: <netdev+bounces-211540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B4B1A003
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954A516523B
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73024242D6F;
	Mon,  4 Aug 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="THsMGnPS"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8D111BF
	for <netdev@vger.kernel.org>; Mon,  4 Aug 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304654; cv=none; b=GInzwd2ovdkOsWVE7TsKQXgXYetdjIyZwbuODXwbPTqbfoBruyJQx9CPwho/eUvJU9fq9XUFqwbeR6LcxYPVHIHHAK8nQwVd0RFPeJnumP1sq6QJCVfzD7g1+0emZtWZAgRXRWu5fklo0i9D1tthwJaJClF4JpDhGJ2lGt6zKHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304654; c=relaxed/simple;
	bh=USgnjCFiHsmBQoeSp2QxQ9nx5t91Pr/sfOlTo7pn7KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wxb4jYUV8puJJ6Boyi01aExRNldTPmO+gU2uKbCTGIQ0fiFtm5LqdvlB4wucUlhi0GxC9v5okBEfVWPFHqJBgZk+qqEi10X0CwBV00qAd36sdxhjPX+o6KsG7oTApkLzx2rlJXTpR/QyS8cCLHi/aBAYy5zoKL5Ck+oaGQfgiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=THsMGnPS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754304649; x=1754909449;
	i=markus.stockhausen@gmx.de;
	bh=WaQbYuIZrk+Ir3qPWJqBJQXWTQMNr+/rOCwH0M18Qwk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=THsMGnPSRGeG/HIKH+uFUachIswkbG5MPA54sge3fmC88ilkylZdUFBgXTPGKi2c
	 rlhLy9dTcvMtIxrCzD4oBKRnEsBAviwae/Fy5nLWnqRNL3DdjajsLZaEf8kEuokVR
	 9elgX9aFQ6MBr3N7Au1roZTP1P4DRLVdx8QSnslrlgFdVOyuooUiy//r22ys4VgjI
	 fkgkC904D6jzZa63eQnbkr85klidUd5gY1HtvDBSxrSZNkWmEdj4Bd2LFwB2q3KaZ
	 Q1SsBQ5VWHb0m7zn7FoByVX7c7h+hOTmOtn1vurNwySpVz/NLIys2AydXkzjbunak
	 Wsvsk20L55F5hnDkNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1ugfr70kp6-0091HC; Mon, 04
 Aug 2025 12:50:49 +0200
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
Subject: [PATCH v3] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Mon,  4 Aug 2025 06:50:37 -0400
Message-ID: <20250804105037.2609906-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qxg7pJZuMKfRdklhLCbyxnjm4VFKwTA0eGQet4exj+nLxA4Mf6W
 3Jg4Hyia6Ozyqv5x5fB2EzwdlHrvA8Qo8D7uoKTs8xhDC1VTMRB9u8GjZAZHKdFTR08OpfN
 tugZPFl3KTwPUckEZUR4rt5t+ShsRQkB7oIZHB2e574O8eVedqVbIo48Io1/OlsfP/F4nIv
 pW8sEHraM4DtO+O4fGj9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nLt/8eVVOI0=;KwpnCAiHP0waDFDzS5FRp4NlVAa
 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
 jA==

Short: Convert the RTL8226-CG to c45 so it can be used in its
Realtek based ecosystems.

Long: The RTL8226-CG mostly can be found on devices of the
Realtek Otto switch platform. Devices like the Zyxel XGS1210-12
are based on it. These implement a hardware based phy polling
in the background to update SoC status registers.

The hardware provides 4 smi busses where phys are attached to.
For each bus one can decide if it is polled in c45 or c22 mode.
See https://svanheule.net/realtek/longan/register/smi_glb_ctrl

With this setting the register access will be limited by the
hardware. This is very complex (including caching and special
c45-over-c22 handling). But basically it boils down to "enable
protocol x and SoC will disable register access via protocol y".

Mainline already gained support with the rtl9300 mdio driver
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree
/drivers/net/mdio/mdio-realtek-rtl9300.c?h=3Dv6.16

It covers the basic features, but a lot effort is still needed
to understand hardware in detail. So it runs a simple setup by
selecting the proper bus mode during startup.

	/* Put the interfaces into C45 mode if required */
	glb_ctrl_mask =3D GENMASK(19, 16);
	for (i =3D 0; i < MAX_SMI_BUSSES; i++)
		if (priv->smi_bus_is_c45[i])
			glb_ctrl_val |=3D GLB_CTRL_INTF_SEL(i);
	...
	err =3D regmap_update_bits(regmap, SMI_GLB_CTRL,
				 glb_ctrl_mask, glb_ctrl_val);

To avoid complex coding later on, it limits access by only
providing either c22 or c45:

	bus->name =3D "Realtek Switch MDIO Bus";
	if (priv->smi_bus_is_c45[mdio_bus]) {
		bus->read_c45 =3D rtl9300_mdio_read_c45;
		bus->write_c45 =3D  rtl9300_mdio_write_c45;
	} else {
		bus->read =3D rtl9300_mdio_read_c22;
		bus->write =3D rtl9300_mdio_write_c22;
	}

Because of the described limitations the RTL8226 phys must be
driven by c45 and the existing c22 RTL8226 phy driver does not=20
work on Realtek switches. Convert it to c45-only.

Luckily the RTL8226 seems to support proper MDIO_PMA_EXTABLE
flags. So standard function genphy_c45_pma_read_abilities() can
call genphy_c45_pma_read_ext_abilities() and 10/100/1000 is
populated right. Thus conversion is straight forward.

Outputs before - REMARK: For this a "hacked" bus was used that
toggles the mode for each c22/c45 access. But that is slow and
produces unstable data in the SoC status registers).

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

Changes in v3:
- Describe hardware restrictions in commit message
- Drop read_page/write_page functions

Changes in v2:
- Added before/after status in commit message

=2D--
 drivers/net/phy/realtek/realtek_main.c | 28 +++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/real=
tek/realtek_main.c
index dd0d675149ad..a7541899e327 100644
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
@@ -1675,13 +1690,12 @@ static struct phy_driver realtek_drvs[] =3D {
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           =3D "RTL8226-CG 2.5Gbps PHY",
-		.get_features   =3D rtl822x_get_features,
-		.config_aneg    =3D rtl822x_config_aneg,
-		.read_status    =3D rtl822x_read_status,
-		.suspend        =3D genphy_suspend,
-		.resume         =3D rtlgen_resume,
-		.read_page      =3D rtl821x_read_page,
-		.write_page     =3D rtl821x_write_page,
+		.soft_reset     =3D rtl822x_c45_soft_reset,
+		.get_features   =3D rtl822x_c45_get_features,
+		.config_aneg    =3D rtl822x_c45_config_aneg,
+		.read_status    =3D rtl822x_c45_read_status,
+		.suspend        =3D genphy_c45_pma_suspend,
+		.resume         =3D rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc848),
 		.name           =3D "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
=2D-=20
2.47.0


