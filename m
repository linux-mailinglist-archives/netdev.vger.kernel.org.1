Return-Path: <netdev+bounces-179497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C10A7D1E1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7483AAD82
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 02:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DD1917FB;
	Mon,  7 Apr 2025 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="doDws/Od"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1929A5
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991323; cv=fail; b=CAvSlE2yyhQ5o4FSLfCJ/BYFHEzuwn/+g26dHwz8PiLVsmaTAzEx37L+p2C3DL+s4AH8lstVvwUp78/51gvJyuzW9dY4QOMaxrcbmlmfSoFa0PLpMEBp/eydLoH/WrNwy81fgOqw4JT7cuk+J63zdxFsMNsqLb7uUX9wl9ZZAcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991323; c=relaxed/simple;
	bh=erbXHm1CxQZ7bha0LKxyH/jg3kAvup2GFF4cL5jc7HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HXYhwFu/zDCi7sAFHhKwh2I38afP7JtsVA/KhE8TAotClBEAstSuG+QQ1C4FzYT8Ab1JxZunJknbutNf5ONuuX90SrIeODKaPSyq3e1Mby7mIn5ZVm3CgicNEI00N5AauocZSgHGCelaVEktirpXOCHLMo3+7xP46G/K3bs4ins=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=doDws/Od; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2cia2YiKjToBVG/78oDaMU+zVC9qeW1TUfpAUqllPOiCrbO0ofwddKSL02xcW4vA9WBQhFVUi972D9R01+vH9tVjNnVi84BjfrkZ4Lc3kg5Q4CYljImjkcwb2Y/v/hu2r0xCUOgJUlkaJVj+nk1icWTLw9FiGZgpGsrUqexcUdlBkKe1UOaxbfDwqvOZSb4HFGkZ7PPqbSx2MVqwSuRgA31fCS1VQl9irlNe/eRM/8SiwLeubnLT7ruRpp0qB0c2VqJc6eJqn/6DTMb5tnsHoULfTlyyN5zKcP/KhuwnnjsoAbN+MwYLVdATqiYo/pFf6nFLeM06d2AewKzzFcIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV7rWaPGwiE9vDTm+vCqK6PpbSbX9X+2RSB/FAEbHkk=;
 b=dtUtpYc+yzOSflIaK9vKXK+tNB3Y5bofwz+Kwpq9Xz9kJOkWZgB2KCkwfsvGlMC5EUpivCMYmaDvV4neO/jx63vtWTxbfAi7VhBDbAQtzG0c+yW8Jg7gYzcqYYSMWdXrrIqYLVpvbyB/Z69FPfRyuyRqVVd3ZvyXeBVFX/tXQ7cOvgnsKbdR1Rai+JWqwqh7jjvUoru13csPw5KIIhT2riv8orDX6Wg6R9ORYyuljGyLDJgSbUle6nZKlEHkSnt/GWL/OWB+tuCCsaQarrCBKUqhYBDpq/hP7GGjF2uXy3LYskYX2OrhTrR/qGAG9HTh/+3NTIsW/3CjqrDiB2FGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV7rWaPGwiE9vDTm+vCqK6PpbSbX9X+2RSB/FAEbHkk=;
 b=doDws/OdOwaymnp51uXXkrWaLF1MPzl4hhZmXsjacQ57vJDKBIuOtG05uyf2VitG4dNGINJhkxUKoCm+bVJuo/pkrwcPfgzN5cMTCmlKc9PuqIV8Lp++qfPlvAkJXqCcF0XAxrbXgrbLWzBlrtDkwSBwjk6dDCHWNjiNCH5CuzYqrnjxhi0K8mUe9w4XABlmu05lQrgkphnHwanG/v/FtL3/c3KLLcwrEwLlqg1sKRznYcYQ/1s3S1MRKwJSVQy0dnvqlkB+TXO9FJVEFfxC7KFHbYcerqonZI1dJOMhvD2a6Ix6kU0LXLxd0/1nwv2CIC3vIivD0zu82GJktPSA3Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7810.eurprd04.prod.outlook.com (2603:10a6:20b:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 02:01:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 02:01:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>
Subject: RE: [PATCH v2 net 2/2] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
Thread-Topic: [PATCH v2 net 2/2] net: phy: allow MDIO bus PM ops to start/stop
 state machine for phylink-controlled PHY
Thread-Index: AQHbo+E58IQm+ImJGEeC9V/MoT+/E7OXeCYw
Date: Mon, 7 Apr 2025 02:01:57 +0000
Message-ID:
 <PAXPR04MB85101286E60F53B01B2D2DD988AA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
 <20250402150859.1365568-2-vladimir.oltean@nxp.com>
In-Reply-To: <20250402150859.1365568-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7810:EE_
x-ms-office365-filtering-correlation-id: 891b8685-26c4-4ea6-527a-08dd75782d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cjbC1PNetkOQBas5q1Wigbq0L5Tjkqs4P7r+3pBU81+txmoXxovslr9kGxZM?=
 =?us-ascii?Q?MwXwYiOWO2QDp8W1fU6amfUbe2xdd5XshmYLKVOeqK41SpQXYHjmAr8y7yY+?=
 =?us-ascii?Q?hJZXGH0pCTbqkNukqGGTImk9AjEH1nCE4dzxHlcJOH88HeAeAVJamaERJgDa?=
 =?us-ascii?Q?uyHpYTut3rtM9XyOC3O4w2rPRxGd270kSK1j/tq83bdZm59yDzUCXqJiDVA3?=
 =?us-ascii?Q?XnuU/ouddPGoR43GY5pFLNtw2KgPPnk1tjgsGiDdQPXJfoAKTkvQ7u1vYipH?=
 =?us-ascii?Q?PzQ3u0WOQvDAsGADbIuT9RhJOmVKMNrMplRgyk/5bPswTMnvImiloXWzO8zI?=
 =?us-ascii?Q?t0Cr6z8hkq+bssic5uJ33zd7LVh9qk5nV3XOHASynmhh2Phnnf7mqOmkDK9K?=
 =?us-ascii?Q?I71nN1EvEP76BnfaUHd+d63Vwd0JdSQT//741Xjbbmf2ve++QXxNJVIUasch?=
 =?us-ascii?Q?gSsQops9MO4ZTuSGOL6NaQmSZPRxD9sQRuLG/q+YZS4QdfcfbBvh9F4xPFlK?=
 =?us-ascii?Q?oRthuP7+3b0G/uLZgYdu9yao3pfJNvGBVmjFq7xQanmPcQzWAYV55a38M/A9?=
 =?us-ascii?Q?UXE0ob0fL5vd4BNYHr9FkGgs+hViZWlqg/tcyaPJYuiqKR1s/yAGvqNMdNkQ?=
 =?us-ascii?Q?z+K/g9LJGUJOxPmKHnyoH+bWD3ixahTReXRFAk5eKl1alRylSbre/T2dlxlT?=
 =?us-ascii?Q?jDGfQRQL6j+XEGuJDuDIukfbfpB531a6fUd+51K6lHa9Fp1sofroVhwDOvMl?=
 =?us-ascii?Q?UIBR8H/RuXVYbKDYd64WnfKUphhYe8Rter9Nb7lRX1lGLqblLdvq+o9gkeLu?=
 =?us-ascii?Q?P3LaRcm3UETA2qFx+4GE4fpl7fhFWKr99MZy08MvglizjGkoeJJky5HI0tR3?=
 =?us-ascii?Q?qWFZO3out8q8NMTxvBjygLwN0wtkNjg1g4FSkWjZcp45GytXUhLF63+6XT3m?=
 =?us-ascii?Q?bLQlrUYfnxm5iYe7W4NW96XloHGfVhypVNtcN6gG1ngJC2TexbgxHy6xQwHS?=
 =?us-ascii?Q?7hRuZXAtfZo+ZvM8mzJsoC+WrV3Zfph4eZwgTKe6FIAkb6l7wwMdeDQsmzHY?=
 =?us-ascii?Q?MSup36pRFWzP/XfHc1dvoEexoV6NV9QbU+6KI0HfQ/VKOkWI46HUg7wOfF8W?=
 =?us-ascii?Q?qYB0YDKbCSevbxu+wqtDAM0KIt06ALlBIdNL4orSuGkKhLfaJRuzN4QEkE4e?=
 =?us-ascii?Q?iGWats2SLLhZI6daSpgVFk95rapoCPqIaoqXObIp6LdkOI/RAIfgHx3e9vt5?=
 =?us-ascii?Q?ACS/aPpWEF3CjZKRGi0SAnAYCxIHzxQNn8Nt6iV46Ko02nrBNrDR/DtlMIa/?=
 =?us-ascii?Q?AqRTQJtDsDUqPhc69en4X+wYPr55smT1hmXdaMrtmEN+UVdhg79kT2BJugWC?=
 =?us-ascii?Q?4M+n3GGqSU3HV1JjAQ/2UlcjyDbP18xfbPDEpImmnPWDfyC4Aceo32q8t6sJ?=
 =?us-ascii?Q?yNfBP7Etq5mUDAQmHZ2AGeazPPQg2Hgi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WNly+kvt5aC9rIYJW2IZurqsuxuvPysw18VjNz6jtujM+ABD+xR9EviUBndW?=
 =?us-ascii?Q?zZsS7Mk80FhE+7s+kW5OteeVSg9P+3HlZreX2/36WpqX4SG2p9yGfCUJFL0/?=
 =?us-ascii?Q?x81yPXwu5xxyHe3jVDDt1eVyfSyCSInsvs/8yaZGEDqc8rliyuqYGlCHK/oA?=
 =?us-ascii?Q?fVAs13xWNo2urbRFlqEw7m49wPYqyXHPjqs1X+hNGES6QXRf0Dmh0w3P2ivK?=
 =?us-ascii?Q?ER+D1ypQYQ0wQO59a8d0eBRXh8fV2k4oyBItXFGzgR+S8Q3rJqp7ftsiCCFw?=
 =?us-ascii?Q?5jRAZ6GamBIfPvrTLg2RabHfrjiwhbb2Ax1+8rDOowQ1cpBt2OW3wOzLcbRU?=
 =?us-ascii?Q?NndotYTglV6P6XSvr5Q9dymiFE4DMDsSjq2XC7Nk29moYJ2/heqcBqMPvNNK?=
 =?us-ascii?Q?7JeUSpo1N97p4ljslEEizjfuuKhu9J9dX4khq5Qf2qtk0VIRqzvmqIEp9o9F?=
 =?us-ascii?Q?9w07RzXkepbY2F0hkB/AYuRB0aodjk7FTMUzjogmno9XBnf2WyP79u+8E4cH?=
 =?us-ascii?Q?SJeOil8XI8fgg+pLfCKLHWSXLnmVnasFUP6TDMRzFryqV1GrPy4L+PSJWwok?=
 =?us-ascii?Q?JQxzp3gW35Gvh1v9MZ1XqieRyZlSLraDB3+8ZN67pDTY8VBKKJkipyo+1w/k?=
 =?us-ascii?Q?mNmbZnXi2A3TSGxG6NTdL4mLNCTxJ4FU1x7zKUojCyW/y0BO2aKaVGPg2FWn?=
 =?us-ascii?Q?7i9vtmlDnjUVdaJ0iskTI7040r6wP0ogJ8itviVy1i5eGT/qY9MCHa9brzDv?=
 =?us-ascii?Q?5ci65uw0kVMdcoktHV00Y9OJoXzz0ncjrclMzLxxrrKaP4LRJIFvl56UT4DG?=
 =?us-ascii?Q?WW/2kO3M9QVagTbMXi2UPOyn6o11BUsNvZc8oDoTHMhSmiHu4CFyrCtmXSsw?=
 =?us-ascii?Q?sEw+uS1BpbKx1QQz7hH2434lHYM17BMUg2jK63zTI+dlx8l3Ao4vG883Qgoq?=
 =?us-ascii?Q?kor+96oOi7zzgtt0o8Lh1VYsWwJ7RJHzF7N4Q1mvW6g4dN5ax3SKkt8ch+Xb?=
 =?us-ascii?Q?WNuqqAO+fD3CMytXjSruw6nihWt+dMn+voxt6IndXdhOHwzxZvQT8+s72GGz?=
 =?us-ascii?Q?okuAdI7V6+r21DOIw7/hx08Tn79Yq4MF73DO364YbVUiUsL0PFltXZGnmfHF?=
 =?us-ascii?Q?nN4g2SzaJ6yVSXg4KFh04AcOmU8KnDBOt54SKIBVv1gh8Pq8PFzXSmhT16aY?=
 =?us-ascii?Q?t0gGGmcS0eY2IEsX07P/n00uXQDxgwie076530cQwrBbR0K7lqcALXyAQl1x?=
 =?us-ascii?Q?7oVeJAFQs5KTypRkBvtWyezmDN4JK2PWtI+Y4QW3wSl/Lyn33bOLOsxq7ur3?=
 =?us-ascii?Q?QxIDAeXzAgMXwrYRyPJoUosGM0W3p+lM6Unh7F08VknIsaNM1CRyvfeN+En9?=
 =?us-ascii?Q?KH9Z+P9CIinRbek3OIBh60JhOrtkATYZyP+RkM5g3AVIw+LYt8gi+esO080i?=
 =?us-ascii?Q?sUuPR4h680O4ECl33f3BD7tS30YLg4xg+i4MMQvU+NWfseZtRQ+zW5MSgN+9?=
 =?us-ascii?Q?K0KOlpINJEk6dL2M8OKjzC5IIPX3v1G6Bcsd8xUgBFIfW3RyoPTQCz2Ycuz7?=
 =?us-ascii?Q?1p/SSb0c8fU1nFKHcE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891b8685-26c4-4ea6-527a-08dd75782d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 02:01:57.5935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytf8yXe8i1W+YhHFiU+xCuSL8ZUNJCx+V+5qUSoN2lAomnEHvgfoZXiCb9kf2tgKLk3d1nKs757F6Yyu0q04vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7810

> DSA has 2 kinds of drivers:
>=20
> 1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
>    their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
> 2. Those who don't: all others. The above methods should be optional.
>=20
> For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop=
(),
> and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
> These seem good candidates for setting mac_managed_pm =3D true because
> that is essentially its definition, but that does not seem to be the
> biggest problem for now, and is not what this change focuses on.
>=20
> Talking strictly about the 2nd category of drivers here, I have noticed
> that these also trigger the
>=20
> 	WARN_ON(phydev->state !=3D PHY_HALTED && phydev->state !=3D
> PHY_READY &&
> 		phydev->state !=3D PHY_UP);
>=20
> from mdio_bus_phy_resume(), because the PHY state machine is running.
>=20
> It's running as a result of a previous dsa_user_open() -> ... ->
> phylink_start() -> phy_start(), and AFAICS, mdio_bus_phy_suspend() was
> supposed to have called phy_stop_machine(), but it didn't. So this is
> why the PHY is in state PHY_NOLINK by the time mdio_bus_phy_resume()
> runs.
>=20
> mdio_bus_phy_suspend() did not call phy_stop_machine() because for
> phylink, the phydev->adjust_link function pointer is NULL. This seems a
> technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
> machine restart on resume"). That commit was written before phylink
> existed, and was intended to avoid crashing with consumer drivers which
> don't use the PHY state machine - phylink does.
>=20
> Make the conditions dependent on the PHY device having a
> phydev->phy_link_change() implementation equal to the default
> phy_link_change() provided by phylib. Otherwise, just check that the
> custom phydev->phy_link_change() has been provided and is non-NULL.
> Phylink provides phylink_phy_change().
>=20
> Thus, we will stop the state machine even for phylink-controlled PHYs
> when using the MDIO bus PM ops.
>=20
> Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume(=
)
> state")
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2:
> - code movement split out
> - rename phy_has_attached_dev() to phy_uses_state_machine(), provide
>   kernel-doc
>=20
> v1 at:
> https://lore.kernel.org/netdev/20250225153156.3589072-1-vladimir.oltean@
> nxp.com/
>=20
>  drivers/net/phy/phy_device.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index bd1aa58720a5..b01123a24283 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -256,6 +256,32 @@ static void phy_link_change(struct phy_device
> *phydev, bool up)
>  		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
>  }
>=20
> +/**
> + * phy_uses_state_machine - test whether consumer driver uses PAL state
> machine
> + * @phydev: the target PHY device structure
> + *
> + * Ultimately, this aims to indirectly determine whether the PHY is atta=
ched
> + * to a consumer which uses the state machine by calling phy_start() and
> + * phy_stop().
> + *
> + * When the PHY driver consumer uses phylib, it must have previously cal=
led
> + * phy_connect_direct() or one of its derivatives, so that phy_prepare_l=
ink()
> + * has set up a hook for monitoring state changes.
> + *
> + * When the PHY driver is used by the MAC driver consumer through phylin=
k
> (the
> + * only other provider of a phy_link_change() method), using the PHY sta=
te
> + * machine is not optional.
> + *
> + * Return: true if consumer calls phy_start() and phy_stop(), false othe=
rwise.
> + */
> +static bool phy_uses_state_machine(struct phy_device *phydev)
> +{
> +	if (phydev->phy_link_change =3D=3D phy_link_change)
> +		return phydev->attached_dev && phydev->adjust_link;
> +
> +	return phydev->phy_link_change;
> +}
> +
>  static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
>  {
>  	struct device_driver *drv =3D phydev->mdio.dev.driver;
> @@ -322,7 +348,7 @@ static __maybe_unused int
> mdio_bus_phy_suspend(struct device *dev)
>  	 * may call phy routines that try to grab the same lock, and that may
>  	 * lead to a deadlock.
>  	 */
> -	if (phydev->attached_dev && phydev->adjust_link)
> +	if (phy_uses_state_machine(phydev))
>  		phy_stop_machine(phydev);
>=20
>  	if (!mdio_bus_phy_may_suspend(phydev))
> @@ -376,7 +402,7 @@ static __maybe_unused int
> mdio_bus_phy_resume(struct device *dev)
>  		}
>  	}
>=20
> -	if (phydev->attached_dev && phydev->adjust_link)
> +	if (phy_uses_state_machine(phydev))
>  		phy_start_machine(phydev);
>=20
>  	return 0;
> --
> 2.43.0

Tested this patch on NETC switch, and the PHY resumed without
any warnings. Looks good, thanks.

Tested-by: Wei Fang <wei.fang@nxp.com>


