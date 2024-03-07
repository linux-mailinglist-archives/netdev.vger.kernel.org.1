Return-Path: <netdev+bounces-78462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0518753A3
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35A628947E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45EC12AAE3;
	Thu,  7 Mar 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cC1EWMx2"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9B12B147
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826366; cv=fail; b=tpVf3Bw3LwQTT7McVw2os7Fd3f1Y3oR021cK6qGqCdErdgDX0ILa6z81G2yHUF7ovnH08EkrXaaDqdAumizxNlemm6D23tr7tEdaSC+iPgdvWB+dE5VPdZi7nvVb5fiQyEzAd6SvqAMCTVyomDwS9u9ojylwA9b9y+R3nfW5k3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826366; c=relaxed/simple;
	bh=jFTj/EVp93OVg45vGw0V+hgUkQeI7GoGYKRqIP0gY+k=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nRdbJ+S4+dKRoNzcMvnUDhE9dhVyGRLKwzjR0ZnQjr8ubOQESZEnSYBQUvjxsw23G4e2CgJ2y2R+fwgI6AKD/63M/Zzvj/J1lgewTwqnEP9VE8mJuoIeUpNLp+jn6Ifn3ZeSIdG+2rlES/rxAKP5kuBEJaajiakyeMMictfCBQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cC1EWMx2; arc=fail smtp.client-ip=40.107.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTEaHby8WaIdNQXdCo6TktzHub5XdeqhYaGpXHY65HDdZWFwVJxsizRZgbO0p9plS7ixKZwL0y1YBg/ChniV203b3DI61Ekqw15KUxJr99PsaVRTayjISwDYWPFkni4Tho620wg66yjPRpLYIZpe2QCdpLxUzEuN+eQxIWG4AW/fEIq2KwB6c6kEqNpqm4+CkHN5Lxy7v8IQJrnEA036k5gJMUKEDdRjTYPDy1ejbA4HlM9ltbpWNG8aqsRfL2jGLG91aPlunDzV8FtXmgmlt4WDzn4f9LJ5cyittu0//c3XpGBKRku2Du7pfRVsoBfEhuQdh7Xgk1UX61W/w+2pLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tE3+nEbbMT2EH/r49pFxKfQhyxb42jAh3p3ezMOQjtQ=;
 b=E//9OCut69IhOEcVXopgFye2Y0rE2Cr+qmvR/Wd/3ihwbLR81jcRE5C4vkWqYQX6rlu3U00+RVwQ5AElIeUpFfEL7pLcD1jO0imG0comWeuTyY3fCA9KjxeZVVegJwa62fyJgXdMcB0fEqUvCz5DU/wcY4ts/LJrqQrcHn0GSVEgSK5fvFq+WIsluCvMSlJXCaqoqqMLTQbaYHz7axx0d1LnPEqYMcVaMJfgeUVCh3bwkE19YmtwMeAKnOyFRyVdIm7TeGNSUdlfmZR8GvyZor9CcZqEkWHWtS3dMcgRaxu5sGKRFjADVUi/t59zmhN+8S4PikxUIX1XU6PpZUBpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tE3+nEbbMT2EH/r49pFxKfQhyxb42jAh3p3ezMOQjtQ=;
 b=cC1EWMx2Sv6AIMf2Ap7DWznSSnbEUEdzJY3PuhJAL89X0JtfbFtswbW25xhU5ZlqXNrYSwRUcZYc2rdiSbIElqV7LQi9vFy5vQB5baOgfVhhsWl2H1USzon/6ZSsTbnk4mMePf9Bs7ZqfihCsoWkeUqC020Xw3wD0h4+mzAgtNA=
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 15:45:58 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:45:58 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [RFC PATCH net-next] net: phy: Don't suspend/resume device not in use
Thread-Topic: [RFC PATCH net-next] net: phy: Don't suspend/resume device not
 in use
Thread-Index: AdpwpO6oyjLCya8IQ/aUYHLqJLKzwQ==
Date: Thu, 7 Mar 2024 15:45:58 +0000
Message-ID:
 <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AS8PR04MB8466:EE_
x-ms-office365-filtering-correlation-id: 15f36e6a-c0a5-496d-253e-08dc3ebdaefc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CYTzMxnf5zpUR0uky2NfsPSY1j6k0mA6xBz7kmhxa8Lnlj6L0nuzJWCZJebTKm5cwbWJXQwi3JEELhUWBAqWFaVTgK3MO8Bno5PrZ4afDYshZg/YnZxGpbxVYcmyzagB0lm0iZ4oAeBZd3kFFRrKx9iaqf3kzV8gJevOnGliGRjRh/UeXCc+6a3tQY2aYdvthCfUWxP7rdfeaDt7r72a80zhg0Obeo9H6WRJPFFVyq+uvF0+Ih84/RT1nnRzolqF/ZnfVlMcMKLP74oneRsru993h23nJCGhsgRSbEmu7rt/SKPXWnRHmm+uHaefTo3pu9aMvDrXjOQc8Rn/S9wUVhUCLpLchEP78jGmKvxlGWec82SebPHY9VsbLGtAhL4PmcGDbYJ4Q2nq+mUYNWizBRHVRSZqaJZcPUnESNykjxy0//v2eoX1F6uobx+sTR1HJY0RoGEc5izCHmJf7RbHAYr4YV5Ae0pKn44YtEhf05dpfpvT7gfzgYmgYcnRXu7mg3L9cOv8MQgldgjaKjXCEfdZ5DCtk/AKISLeHxFqefyBcb3R2H+Pc2E28FL2tH3dzHgluPbXWuH/5typIl0xBxg71Jr5TblG1KV6noVrGv53TmsawMMXJ8Tz6sSH5zV+yB+9WjxZCw+RtlpU8Wzp7jyslzjpbTKU6ORztA87AwbAHG1wLVHKXzvQmMvSE/bOz8B7WIGC9zn8EWgzyHg7t5eBeYM04EGXRp9v+Er9JCs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cupJQvx3BoA8mpTOR+PK1d9Ub1y3Ec3b4XhOw93+PK089jxZZX7njcysJ2W5?=
 =?us-ascii?Q?l5hQJymKik3KEE8uGkCDfVQX3b9hX+HGEayaCEvP1KsyMoGM3M6FvKje7lHl?=
 =?us-ascii?Q?4FUXsE/Htl2XdUs5xV7WxGlPuXpW+u4xUJSAteBiHy+EetVy84g2M8jLIQPd?=
 =?us-ascii?Q?Fi5mL6wVjG+0Ecmjo0MHILll0zkG6blQk4S6ojeHwl6VrXLzYXQk3YfpV51/?=
 =?us-ascii?Q?Z7cBFRZOZyhCOYNWVGpTvEKllq9OhCBS3LS1VYgZSBgUx/Kkp3lirht+WkKF?=
 =?us-ascii?Q?2kZSyM5pHLzGP2k9IRCKxSUx5DiVTjAw5kQ0HqQdjEhZd9LtPeeunqgWD2R7?=
 =?us-ascii?Q?iDfpDeb/qXo681VXWwgMrj3scVdsiMijXBTmohfAKNAmZFP/SDWF+tO2MvAF?=
 =?us-ascii?Q?8nTyY3NRu3j6GrbxOmNJtUQ//4f4H8/P34FATkColldBI3jprLX9StVGDfHr?=
 =?us-ascii?Q?yn7v6TC4U+cKeRsiAWPnBZoJGoXDeRua3z5WCVKMI9eIFBnhM99UVbH+hQcS?=
 =?us-ascii?Q?5mpwsVNzmof2Fbskj9TdFcjzJXHH4zL0QlT+QOQSlaBfpdqo7lIBu/c1Ifv9?=
 =?us-ascii?Q?p90XRNkheen3IztD1gYTqU/u2q8XccsnzfGgUFEpLciPWLxtqEPJAAq8pjvU?=
 =?us-ascii?Q?lcouEYUAaJ/CbxFuhd10IwKyoxF3wXFvKZcEXopVgZIe9Tiwf51nzER/CaSX?=
 =?us-ascii?Q?t/Mc9+Mw8BvkqF8c513I/NgYF/CuTH3Ljw9Z6WkQp/VdfiH/yAiRx9Jd5RKe?=
 =?us-ascii?Q?piUJKetPjvPLbpsia4QypaGAGbvfnU1uqG2J6Vh/gTNQ+YAFUmf8sx31uI7x?=
 =?us-ascii?Q?tcUJgpP1dNOYezL3hMeSP8f5bsQCaLecBOXi3dPChxFul6neRheFE2VsATL7?=
 =?us-ascii?Q?Za0r6iU6u13cXh+whMmpD9YOgq65rT5L9JCJ8K0zGKCwB525s70q/nfiM6Sc?=
 =?us-ascii?Q?zGiw9aXbkhwoJxh24eWu+POyWspfew4lztTne+UIZ0v294fra8BoiH7ITVCP?=
 =?us-ascii?Q?F+DvucjJw+5Ts+8zJ73ILCBJ8GMGmE+2wWjH5r3o1GLIRjNepyakhz1cc/+S?=
 =?us-ascii?Q?2MdbuENv19RKlvQ/l/sj+7S6axqCT5GVwEtYv9F0XgkP9WbxCsL7KDK2KilK?=
 =?us-ascii?Q?+KG0DIODMk4DTdQerAfoTG/q6NGyV43Guz7R90vSadTZ2ajZuV4K9fMdUaqE?=
 =?us-ascii?Q?Eh6sKYtvpS0IY5xb469/lQdEdEW5GBb4wQJ7s1gkT7KPjugLnQUYRzrCpe5O?=
 =?us-ascii?Q?XOpsHwLBGU6waNXctcZcheAy3hufS46mDysrDWGe3p8veJm9j98rmts8+Ml1?=
 =?us-ascii?Q?yeG1poDaHy28bS+F5RwURvllAi8RTHF+r5Um7P3k7fE/ip0WYPNd6RVq50wp?=
 =?us-ascii?Q?obd60sEFjSnx4wsMEbsqKmg8jk9+a5o+h+h7hFCv6iLA9roazHYcP63n0KHE?=
 =?us-ascii?Q?VZbnF6dUzDrQtFWR6o3DhgF3oDZUsKm9AXkHFEmT6/Cn0UbiH32TSVT9slLO?=
 =?us-ascii?Q?5NDVUS+sGaqdYRCym2ES3yjqr6x3Ky1bU6K7GYDsFrcCuRtM+5l021e4WIfS?=
 =?us-ascii?Q?p+fmhsrgQbY/bE+zZbQ9RQvhh9LTHpbOpFrjI7xO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f36e6a-c0a5-496d-253e-08dc3ebdaefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 15:45:58.4852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yPucOS7wAPR3ieJW3R6mEPPzUn2e0G3FYMZjNjErLSVeV9r/R/ENMjHIDlqXcp0ppHSzBv6WVoXsurkiHznfHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466


In the case when an MDIO bus contains PHY device not attached to
the any netdev or is attached to the external netdev, controlled
by another driver and the driver is disabled, the bus, when PM suspend
occurs, is trying to suspend/resume also the unattached phydev.

/* Synopsys DWMAC built-in driver (stmmac) */
gmac0: ethernet@4033c000 {
        compatible =3D "snps,dwc-qos-ethernet", "nxp,s32cc-dwmac";

        phy-handle =3D <&gmac0_mdio_c_phy4>;
        phy-mode =3D "rgmii-id";

        gmac0_mdio: mdio@0 {
                compatible =3D "snps,dwmac-mdio";

                /* AQR107 attached to pfe_netif1 */
                gmac0_mdio_c_phy1: ethernet-phy@1 {
                        compatible =3D "ethernet-phy-ieee802.3-c45";
                        reg =3D <1>;
                };

                /* KSZ9031RNX attached to gmac0 */
                gmac0_mdio_c_phy4: ethernet-phy@4 {
                        reg =3D <4>;
                };
        };
};

/* PFE controller, loadable driver pfeng.ko */
pfe: pfe@46000000 {
        compatible =3D "nxp,s32g-pfe";

        /* Network interface 'pfe1' */
        pfe_netif1: ethernet@11 {
                compatible =3D "nxp,s32g-pfe-netif";

                phy-mode =3D "sgmii";
                phy-handle =3D <&gmac0_mdio_c_phy1>;
        };
};

Because such device didn't go through attach process, internal
parameters like phy_dev->interface is set to the default value, which
is not correct for some drivers. Ie. Aquantia PHY AQR107 doesn't
support PHY_INTERFACE_MODE_GMII and trying to use phy_init_hw()
in mdio_bus_phy_resume() ends up with the following error caused
by initial check of supported interfaces in aqr107_config_init():

[   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: error -1=
9']

Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>
---
 drivers/net/phy/phy_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3611ea64875e..30c03ac6b84c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -311,6 +311,10 @@ static __maybe_unused int mdio_bus_phy_suspend(struct =
device *dev)
 {
        struct phy_device *phydev =3D to_phy_device(dev);

+       /* Don't suspend device if not in use state */
+       if (phydev->state <=3D PHY_READY)
+               return 0;
+
        if (phydev->mac_managed_pm)
                return 0;

@@ -344,6 +348,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct d=
evice *dev)
        struct phy_device *phydev =3D to_phy_device(dev);
        int ret;

+       /* Don't resume device which wasn't previously in use state */
+       if (phydev->state <=3D PHY_READY)
+               return 0;
+
        if (phydev->mac_managed_pm)
                return 0;

--
2.43.0


