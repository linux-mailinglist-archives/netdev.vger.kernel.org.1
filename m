Return-Path: <netdev+bounces-80029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058AE87C97F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2925F1C216E9
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E614280;
	Fri, 15 Mar 2024 07:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mIywDInu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6B1426E
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489354; cv=fail; b=UHsXJWFEC78ncRQ77oHgI4TAEWt/QHVaYIHtkjrTzu+tLglAwZ1PUIfrxa/Dc6Pr6DFf9O31ZI+FZOaIIQuwBcp8WrgzEH3UrTj9+rbS84biO20/3ZOPoaflKiR5vSisRBS0zDpGmKjJJhHzLpK7iFmv3QsLd6ap+K0MJnAWl3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489354; c=relaxed/simple;
	bh=Lh7vQifcW0DOApwQF6mp0rJYf81j5xyPis6k2FrtUMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsedwkIHujoWdF5pi9uaEnXwKa2GH+i5TunKy4w4wqu6NtkF5pCF31RhetBeJtbSM7AIDgCuK9CzLs7aLFV1XLEaSyvhrGfT1oJBrco6kbCMkmA/qFruQGEengiGKgyczVX70211ycOx/AFgB49Ge0VEeOb05Bmt87jHmFyOyYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mIywDInu; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b36NNhU6PS1fPadR9EsD/+wv534N9GJlyPzGOwI2Jup18u/1HwDBSQb5xPGAi19zLiPOzAyDa0V21Ml6mms0ssWdWMWj2Ri3IMljk1Lnur8XvSE6yej5vAzn3FtxY4HNYDzkKoRdn/SKjby9VOTyiipc8LVM5skAASAg1bE1GlEXEWHo/erZeBF3eOTWJ1LV3QE/iJu/IJPdQjQ+bXGSHkrFUkMi5nCmcj5Yai5too3LZ1/IQjIu6dv+PnLWzrnnPIzkQK/1dEHTpREXSiC9z+FCzQWl0RVmpO8oHVzq7iXTMQZ13yUTjRmPqAiUb1YekVNhtT+wSRtric79wEVAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXcufTdUASEWYl70KqjlxBq+DIWueLuPsn4PdGFmky8=;
 b=AEcOF9CxaToT6ZqaWDyWBmGeLHegfLsftGVJvdjt92I3TyH/bHZzSvHE6rY7rQ+MvvqSZ5pisadd0B+H/LMPvffv8KnLMoPuananp3bBy35N0fO/1iljR0U+6vV+jia/VjS3Wp1Kr5HkNkSgV0Rk80QVVRJ5GC1MYMXktZGAO1fwyB8Ifl1gVGbfJvBr1QfTZwrNchsoH56Ljxb0Vz7sO8irZBCqeFqkW/uiIX4o1UibSC+PxA5O+grfQb72/w+caw0XCKAnRjcifoaM2YzCZxywAb1m82APZgEnnNULZOGM9SDAWuMnBVkAWwEzdwPHj0HTPQnqk1DWqx2RVnDIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXcufTdUASEWYl70KqjlxBq+DIWueLuPsn4PdGFmky8=;
 b=mIywDInuZK8POsSvcFevWt6MEjkjV//w4AKC+EcUobU3fvC01/EMFCluV5it7cuRBnPNigAyghzdM1FQhxShQjda3md1LgmHWupXZuax0vNyFpGjliDQa6/Ax3CMpiMMCg5z3Wdo3WQR1hw5E7gS9HsbIn+SPjkZK08gte+jrZg=
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by VE1PR04MB7293.eurprd04.prod.outlook.com (2603:10a6:800:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 07:55:48 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::b6dd:f421:80e4:8436%7]) with mapi id 15.20.7362.031; Fri, 15 Mar 2024
 07:55:48 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: [PATCH net-next v2] net: phy: don't resume device not in use
Thread-Topic: [PATCH net-next v2] net: phy: don't resume device not in use
Thread-Index: AQHadq4xhzwXjOEGWEKleB9yW341+Q==
Date: Fri, 15 Mar 2024 07:55:48 +0000
Message-ID:
 <AM9PR04MB8506791F9A2A1EF4B33AAAF4E2282@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB8506772CFCC05CE71C383A6AE2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <c5238a4e-b4b1-484a-87f3-ea942b6aa04a@lunn.ch>
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8506A1FC6679E96B34F21E94E2202@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|VE1PR04MB7293:EE_
x-ms-office365-filtering-correlation-id: ceac31fe-8ed5-4f6a-fad1-08dc44c553c9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 klvw6d3ZdJafBGsizwmKCh/mRTm/TQo3ObkLKhM8xyetBvx62PZxL39/YC3SM0B+Q7sI2sfIxv9F35DEhJHS+zmmloaM2FDbXOM265+Dc0uzSS6tX0LrRZJwGLPOt6P1BtDDl1wq++MYwaFNZnufDeBet98Lqw0QaFpomBjaYpM+XOo85drM31b+tGguxjA4mZ6MaywO++iEn4ua1PuFQ7xb9mtMEXjetjbCdWEeLI5NrnZktdHH8lf20uh00QS3hJF9Wis1mK5F1ZWD1+Rh7+CuLbi1J3QPTR3L4h2ihgCoI+/nHZPFD28RU6ls/9tUC9/9jzNuDvU7kgnmViS/6uHWpFAChKqdBzl6FnSs5H0LwBDicC4Vh7P79IAcawirKeiCXHzqWwumbmfQYXay3sdpPQATIHwN3wbGISst5pxFz5K81BDW7bUR3aOJ5y/vhGpQJzvfzyJI4T7tESs0rGI8Xalf2a8MvtASQD0Ijax1vB3Z8ZqzOL6mBcht76qEVudfk5/51ULnti+ynFI7uv2Z8YC/Sd/qHm+Eb4JvoX6aEm4F+XPs/++44d68VpIBiHgRbvZE8tPqNL0hKd21WN84w7LOF2uT2+iqEiSzRUDc4bhw3zMOqP6ZXRfLDd7jb72YzCROT00XyuWSd5OD4acov7CNQgBQZRDOmO4dUgKVeapRE17WAg/PAIXfT5R/27dCE0WGIHYF/G4GP68Xhdbno1JQzjPikN+0VYiVgS4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9SWr5jfOBnjsAJHf+3Ce2be/0aJ60efGAsPDfMbz1S2SpjbAlhoYUa/ipd1E?=
 =?us-ascii?Q?80wPOWaCK5KDIa1mS/5V1nYNpJS71+V7tNhpljlB90MSEx+aVlJdXXiHyRVx?=
 =?us-ascii?Q?pQU7G/UKwCA5/3nTZ9vcO4zjB8XcxbviCdTQDoT3aV8uERL3lyvekooDxAos?=
 =?us-ascii?Q?IFuknJayDb14mN7BK8R7mx8/hIXmp+KXxrwKhaUtWv6KKzXX5Ekgo45B//WA?=
 =?us-ascii?Q?WjXZ3yZ18mPvZWnetfzc49YKWq5J372TKKjCZNyqSNonOtf82HhePnaO+gkA?=
 =?us-ascii?Q?8UmWIvEtWaFtqnPcxCQtiWpxuuwBFZmRA4/6WVONQ93dcsw4lLerS/GKVngC?=
 =?us-ascii?Q?vSMvt9rJgbVssPquDSg4pEqagmOqQxyabyDQyTQa4rDqcJ5+SgMAT/5Te89t?=
 =?us-ascii?Q?CvQR0Od7cTDdo7N1xwPV0V1aw74BpTcwMgimBzs2MxZp1tHKEM7w6MohWAux?=
 =?us-ascii?Q?iioTT4Gn1I5RB+hwWEIyfZIiA4TRKzsqZWOhcGJafbTDYXrzo9Hpa756S1dw?=
 =?us-ascii?Q?Hqx/JBWX9D3zcwrEiYkp7H5LJb7wpMdW3Xlb+SpRsIDfYf+0WNqMg1gKeK7R?=
 =?us-ascii?Q?I7RJ3l4MhgBK8qKy4lA/EKqwLfmK5B5y+D+WLd4gw0Iilk+VpkqaScx6PSMi?=
 =?us-ascii?Q?QIIJJ6tkwlUB9rtLOFvRejhv2wBYRYNGWT/fRoxVAUsz1gehVbHZmyi2ksQD?=
 =?us-ascii?Q?Qe8wGWibc+Ht/CvF61ayi/bkCzEeXSM2fFYWmwLXpWNyoBfNmJqvtdQdgYem?=
 =?us-ascii?Q?49d1mk/60GFQFrexXVCGMf5/yKjj7kbglN47lS6Anz+jihgj8sBbBQWdyuLv?=
 =?us-ascii?Q?hQm3GXCg4qbCHTcM5Ao6Pqz9CrQs85A2FZzRTDBMtFLoLhaQfGbe8oBW075K?=
 =?us-ascii?Q?1MUTsw4IdeHpy8am+RB8qoBAq+Fw9fyuNAmeWlG2+4qmQJ++gZky4sphheUn?=
 =?us-ascii?Q?SdOadq3cPoSMhljV6GFfLKjGNbBh88ggwlRUk6PvibqNjVv80C2zV7LWBjzu?=
 =?us-ascii?Q?9a7D8lCtRLZj6xDSo3IDGvhAt4+sOorI2KnpsGGPPh+II4X+ycW03MyaUlZp?=
 =?us-ascii?Q?2SMf1wQejXkclEi/PVDcHeUs/v1sbyjZLRRLkTAzoKgugY5Ar1lP1orVuX8W?=
 =?us-ascii?Q?uXGOQEZCdvEzv6FbxPhYjpY5WbX0otDHvqYmNvs35LfjfcMscldYqTwfH8/9?=
 =?us-ascii?Q?/hLJOF2SNZmWGn14WphKBS+Zx3t5bayfy9jcxZCjJJqxpfgyOHMRWGy50Ery?=
 =?us-ascii?Q?wvc/lviwyX3UCRlSXnvo91s1euyzXzzRspoq59NFaQqDUmOfE3Gh+EPrmX5n?=
 =?us-ascii?Q?Bb8zpyt2XlWR11bRycx5p2RC782spQWm776HRTkt4B7nAZd3Ib7iyrEjXCn9?=
 =?us-ascii?Q?rWQ348e2zIEbxkDwknfQ75bWqZOHEuXAV8XB9FSBQP83HeqbzAeTk3aLdAA0?=
 =?us-ascii?Q?591aV7fMSh6aVaFWeb9CeUVJcp5Y6f2EjzZ4bedmzzr5gZeo+UnBQS6FxJMQ?=
 =?us-ascii?Q?K7uC84yqkCb5p/x1yM/zhV8iVdM35oyvdoQa5d4MCU5vnP2IjPZLaNSmgGlD?=
 =?us-ascii?Q?4XFCQzG0fY2yCvMgy5ZYChQtq08ypJnYdKD9+4f8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ceac31fe-8ed5-4f6a-fad1-08dc44c553c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 07:55:48.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFDZa02VdQIRiXnuXdveeyClbwAUV52Oty/bzVfh8Kp6YgG998k7MRqLTDnQXzk2AmYEsJMP2pBEg5jJzpn7NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7293

In the case when an MDIO bus contains PHY device not attached to
any netdev or is attached to the external netdev, controlled
by another driver and the driver is disabled, the bus, when PM resume
occurs, is trying to resume also the unattached phydev.

/* Synopsys DWMAC built-in driver (stmmac) */
gmac0: ethernet@4033c000 {
	compatible =3D "snps,dwc-qos-ethernet", "nxp,s32cc-dwmac";

	phy-handle =3D <&gmac0_mdio_c_phy4>;
	phy-mode =3D "rgmii-id";

	gmac0_mdio: mdio@0 {
		compatible =3D "snps,dwmac-mdio";

		/* AQR107 */
		gmac0_mdio_c_phy1: ethernet-phy@1 {
			compatible =3D "ethernet-phy-ieee802.3-c45";
			reg =3D <1>;
		};

		/* KSZ9031RNX */
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
parameters like phy_dev->interface are set to default values, which
can be incorrect for some drivers. Ie. Aquantia PHY AQR107 doesn't
support PHY_INTERFACE_MODE_GMII and trying to use phy_init()
in mdio_bus_phy_resume ends up with the following error caused
by initial check of supported interfaces in aqr107_config_init():

[   63.927708] Aquantia AQR113C stmmac-0:08: PM: failed to resume: error -1=
9']

The fix is intentionally assymetric to support PM suspend of the device.

Signed-off-by: Jan Petrous <jan.petrous@oss.nxp.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8297ef681bf5..507eb0570e0e 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -355,6 +355,10 @@ static __maybe_unused int mdio_bus_phy_resume(struct d=
evice *dev)
 	struct phy_device *phydev =3D to_phy_device(dev);
 	int ret;
=20
+	/* Don't resume device which wasn't previously in use state */
+	if (phydev->state <=3D PHY_READY)
+		return 0;
+
 	if (phydev->mac_managed_pm)
 		return 0;
=20
--=20
2.43.0


