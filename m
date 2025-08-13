Return-Path: <netdev+bounces-213184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5FB24080
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B849167C2D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 05:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF1E3D994;
	Wed, 13 Aug 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="PSbANEE+"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566028EA72
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 05:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063889; cv=none; b=tCBXBz3Bd/Rq6HBXo/fW5TmfvnSQ2xDR9gUsSm7qwcIMNuZ5tCWDHIRyDqIDnur5UMdNJ6PytLfHT5lKW36IbkQ9KXxCTDlo8rhtRwS9BY+wmq4BkU2rUu6QYwQFWxQZYvzy85XHMuWEUs8ErlV2eTa/gK+tcOz+SfgSO+s2n9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063889; c=relaxed/simple;
	bh=82RFg0jJHoubmQI2dHx5u1l9pQoruXvGzsinlTDrsVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQ92run6ePMfn7r26dICqFN+p4z9zuZeps/QcExQbr4y04TDwv2a1xzpXI9Ju3UwqSdYhIs1EmGrBaccfOy1h4kFS5D7tExTTxoUWf4/ITafej+61uMV2JEGae8ziEOf0ScbWg9RW4B3xBQDzP+FXsijmL0B/bVnfiHBdC2GfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=PSbANEE+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755063859; x=1755668659;
	i=markus.stockhausen@gmx.de;
	bh=dcktMb15zUtfz1L95wwZjzclzQe1r8QmSZ/8IbIHu1s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PSbANEE+I5UMr6U5aFnOJOfZ5My87d/9iIDcjBTlrujEl3BHnrdHwrw58cGFo1aa
	 Bekq0uuD6A/4S2em1tdoX8pn/bimNpZ8pny6zXDdXioXa895F1xygmsNhm8PKl9ey
	 HZSkN0Cj9awzhOXS/nrDYDpJZCNnoJ5KYOLbu5pSH2l0W7AH28qr/bX25xAudAuZC
	 4mvZwQBTCRJCUO4Aae4j4e90LrRgg5xVWY5pBoQMR5TZ1xXwTyNM6c39uS5t+DXvD
	 fwvNRfNJU61YDgRdkGZ6Nf6O62+CKloCmB21VhC5dB12lsfb5DjyLNWATBpekZcQh
	 +x4aJnLH5y/WIKcfkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUqL-1usMTE0xPr-00BGWk; Wed, 13
 Aug 2025 07:44:19 +0200
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
Subject: [PATCH net-next v4] net: phy: realtek: convert RTL8226-CG to c45 only
Date: Wed, 13 Aug 2025 01:44:07 -0400
Message-ID: <20250813054407.1108285-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I1gOoq9HRaAGNsiYOekgAI4XBsb7zIIOzmhUHV3ccTRp1zzSJ/g
 y+2UUiDoDACcwONs0dKKBKBzSgYbo9XWO9yjD12N737QsNIrycQHSTrle0RRyfZa61s5Pvt
 4GFd+I5dMXR9mv0AMXr8bJkn5EbcjqToK+354W1pFnTsVe5N+0LfVpyQXeCrSmS+eSgZ+kM
 CQOK3FwLdCxHsfcJ01MFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0D9HAkxd1/4=;3t1wqIC1Hcr+lFOs1GLQQnoMAUf
 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

Short: Convert the RTL8226-CG to c45 so it can be used in its
Realtek based ecosystems.

Long: The RTL8226-CG can be mainly found on devices of the
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

Mainline already gained support for the rtl9300 mdio driver
in commit 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver").

It covers the basic features, but a lot effort is still needed
to understand hardware properly. So it runs a simple setup by
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

Because of these limitations the existing RTL8226 phy driver
is not working at all on Realtek switches. Convert the driver
to c45-only.

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

Changes in v4:
- use net-next tag
- replace mdio driver reference with commit id

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


