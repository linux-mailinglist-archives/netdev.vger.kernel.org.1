Return-Path: <netdev+bounces-124772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF996ADBF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E511C20EF6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11028F1;
	Wed,  4 Sep 2024 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gksduCcs"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20D63C;
	Wed,  4 Sep 2024 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412813; cv=fail; b=ISFBMO9hr+jXPjAiUafVbQVkFbWyrMdyPRRMXkkuYkXVpBMFAKlWod1aUjCPoETJvWvmBlMKpMtZGXhyFYA/px2zrNOz3tpYMYpKjqpNxs8PUnAUBrMFxy2hfPqV0PGaYq044KDnN1TkZlGCiwhyaWmCLlqYX57pDBXpQI8yOxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412813; c=relaxed/simple;
	bh=qKHM5wG3m+NFmaWe0997+y6d3Mx+LCtESt584/5zv+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sLEm+sBf1oPu/SN+YW7kJqIq8sH7ejBmSZ479Et7H+yoJVEkTnHGHadXqsrtgz2tZB6x3Wd1RDUCUh0bZuflNShWKQnNmjIucFaCuU/6SFdiCaZC7oc7lv8Ksc75A6BC912dT5G2Hzjc+2cMnFkiUcjz1K+rdroJuWbtRmJjijs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gksduCcs; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4IGs6p1GEobzibWdNwZTDb/GoNTJIoN00ceyl9mUJWEoJ/X9AX6ZL4mWMdLEsgcxKv23ksqP4BbQmu9Oc56GkS0j2U5Er6BPueExfRwY7QGItyddGordErcM7TtCTauDfnYaLqM3F5JC+olP93WPV6YfdU/AVaMk5Bdwlsw3riuO/ipSMZsf9FxAKmkUSK2zkqTEddNVCHUCQDRTgXLwXxh1qQrYubHPdSKRe1pgkwSn1KZm0szkHtJ6xkDnWDwgPAk5uUj9eoKdzKYNxn9bdkAwbJHXrRGyn1CaW9a5FOsp4iSidgSgrVhvTYnUg9NvrSF4Mz/ltb8PAxJVXyyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6iCso8Lk3sTeN9i3DXL2NpDCN+USFQvyHGuL9gEc48=;
 b=Hv7raoqNL4cQ80F+jNobZK0jZL843ZU01+xD3XbyZmjFqLnjBozczudzesIapX+q12Gg0OfkAVPLik8VhicIT0kLVvMJeaji0eg8cTBzIRDqRqmpp8sCNAzFcbSnYjMvNCPk8wup9Dyas+Mnid0lksOnK/S4ZdN9YYjp6B/cRFwXCpd7/N7RaNm3vu7EFFuMsUGmBqakr1nn3aXfAreYV/SYCOvB+K+D+el5cQuYpvYqmoyfy3N6rE+UQIE3+nKMFP/7sthXI603uDN8TyDV9j7pZaxVKZxlic+HjRje62nJbcZnYicBhGVsVTHA3YyoDm3kUfCU50CFqZ6nCH9T4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6iCso8Lk3sTeN9i3DXL2NpDCN+USFQvyHGuL9gEc48=;
 b=gksduCcschUL4mQ8uZ5GKW6CI5M4RwnUjEZJz7z33k18sxV5hM4OaNSpbn++L3t4L1n185NDXMQTFZkJKrhMQ4V7+dD8dOoT5E/wMYeH7KC1OLPeRXTr+g83eZGQ2dil5n91m5LraZQykLzwouIG1goIv3jf07U3m+tdzHDbvassi0/5P4WMvRqZVxIblK8AFkzYxjRtIx9RhX4VplO41z5XZEr4W68vYhtIbUId+/Nj2JQ0e6a6NSmJ9Hy7ljposNzv/ocIoqNa5h6pNuoUPwVD4w3Jjia/KMqW3uJ9mFwoYcEMFo7LvzCiafACdldOicIymEq/0XIleUYmFV9X7Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8399.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 01:20:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 01:20:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Topic: [PATCH net] dt-bindings: net: tja11xx: fix the broken binding
Thread-Index: AQHa/QQeMkPALeROtkyb2f+TdmVf0rJErgKAgACb3sCAAMHjAIAAyV/w
Date: Wed, 4 Sep 2024 01:20:08 +0000
Message-ID:
 <PAXPR04MB8510155101205EAF77C233C7889C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240902063352.400251-1-wei.fang@nxp.com>
 <8bd356c9-1cf4-4e79-81ba-582c270982e8@lunn.ch>
 <PAXPR04MB85100D0AEC1F73214B2087CB88932@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <bc68a8c5-b3d7-4b87-a192-ba825bfafb50@lunn.ch>
In-Reply-To: <bc68a8c5-b3d7-4b87-a192-ba825bfafb50@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8399:EE_
x-ms-office365-filtering-correlation-id: c02e7bcd-ecfb-4a31-d37a-08dccc7fb705
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ezPaIXRLK96nuvyT84fWCRYFkWvuCqsyco1GR8QlOAZK0f9Wpgcqfu7/XIzI?=
 =?us-ascii?Q?pVgOcaEmw+3lsHKt2nFCS7ngS3lQTQBtcEQqkHJyOvHARYMJVWVfqn0zfJFv?=
 =?us-ascii?Q?WRe7LFlNy0qwvD2GuUYE5cbpCwcPTAAysRD9jwqksmzjXGOCUVniI5GJGd5n?=
 =?us-ascii?Q?qEPGkW7PpuTlk0KCZoXWP+/uCHnbuV1PAxaujrUHJ3M31s+utQLwEKtoJZpz?=
 =?us-ascii?Q?O09gsefGDdaMmbYFWQBBLg2h2jzKaFe05j+IU5DuE6EreAyWrBY2WORSKR6B?=
 =?us-ascii?Q?MbyPuygLmQHeGTHQsqXou3mTZAqVYsMs4EwhPaYZ73+TJETBH0tTQNF5sDUz?=
 =?us-ascii?Q?+CnH3lTmC8SQvI6G33r8UnYTGA9oF0XpnrShltEddWSwV/BxWkWTtPuIoFq2?=
 =?us-ascii?Q?zK1nT7x7NGup93KD41/EdLwLHnaeB8ezg7fb/BarcmhTpXduL6jx4b+yX9s/?=
 =?us-ascii?Q?KO6B4W8mUaH2hGoT2ge+2UNrL9EZR15y62wf96c1jaB6JZmALpU6CQ11fOx7?=
 =?us-ascii?Q?fm3oiGG+63sZX+5c8U0/zvmBA4paIGVc0hJedC9IEJ+O9dI446iqWndjAyUf?=
 =?us-ascii?Q?78zzf1Cgkx2oA1MjAeC45qjpfxhTa61On3cuQE9DpVZSBYk6LFVcvGQXjmRP?=
 =?us-ascii?Q?uOryGt+lmZj/T00iQ00v75InpMrwFh3AMgyKWpuKNG+NAtEPac0PZJyBIBTD?=
 =?us-ascii?Q?497TC/Xa3vejFr5zdAClgij4SQTCPSTSOF8KNOmsT0P/B+gDSV/XfvebkpFS?=
 =?us-ascii?Q?7uAjsd0vOSaCi+p8P6y+hVVYwjFqSBqzTZjon2XbSLFnFi1K60JtFAXqXpv3?=
 =?us-ascii?Q?a/LWxoTtXFoOonsQ8ApWGbNJ4oNMMJZp6jj47v9WQFchi0nezIpqA4CbyT0P?=
 =?us-ascii?Q?de/iCKFvxQphXbalPCBFr1xT0zcGhhTU/zbfJzIAz9gs0zpFHzkhvsw5kzDZ?=
 =?us-ascii?Q?f/qjZa0MUVGkUScgw24sitnLb45dEE8oLu/Ghm+tbxbmmMkbc6Px9bbc2WlS?=
 =?us-ascii?Q?GVcIW7FXyQc6Lx3KcnqBYSlXUPUBxqGMxQCf86PLr11rNxwQgAof5tGDT/ko?=
 =?us-ascii?Q?hpRqql0QTafB6e2wx9CBcDrIFZFKYqUGBc59A49pMxWR3JRU537+7+pTqr4z?=
 =?us-ascii?Q?es84y/6terJjmlkSO7kO9N3HAQgR3KIsmCXRT2/O4YHWOVev8JtGd0Kep16j?=
 =?us-ascii?Q?yH+lEEN+1UbzNY1WHV+2wOemLzd9apIeo6hw4qzTgdrR7Xe/O8Q10krKtkAs?=
 =?us-ascii?Q?SL7qal0SLf3WbnezRjp0yEc06qM9kfTEWrMk7wajfmPBiaPaHZvCvb/KGlhn?=
 =?us-ascii?Q?6bmB16fFO59GABY9EyA2LQxctl8PHkLcSt1J8N7/2D68OIIfbz/vNDeq97nU?=
 =?us-ascii?Q?DvUUNBtj0R24XeC76ALpvJwBMf68WPBCVCCtu7qpwDkPqkGvhA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ke3U5CWL1GxdtofYHSE+yYtzpOI5HYk5xGuF7wuEkPoY4Wjs/myQl+QeY6XX?=
 =?us-ascii?Q?dP1gxRWiTzIcR20TD5cbizXodvIQZRZ8J1APwifaUCv7MH130fdKvtzDyz56?=
 =?us-ascii?Q?KCzfjP0A5KivL7y+VSQKBGXa14XxGvoFOk7GDxMzB+LN59U/bQt5RIj8zCWh?=
 =?us-ascii?Q?YdlODoDSUhtfNrdufzJKVE77lvdbfQc/O3Xjts832OMY/zkiJ5lvR/MQE4yV?=
 =?us-ascii?Q?ROPQmc3g+pl5AyA/a0jler7484nn1XDLw7rr9HmidqiPrQGfWgBfYjEmXaKx?=
 =?us-ascii?Q?uS/QQAze78Kbv1vp6uGySvWmMPz3oQFjPtyz52LUKeSI5qmjxi6ws23QR9pz?=
 =?us-ascii?Q?9Vaff0l0lrPjVJjUuJl6YX0Qik/w/SjVBThhw8qdFCukC7CW1f8T9BHl3kKz?=
 =?us-ascii?Q?GH9NG/RuBqIUmyjxTmXzn2YaQ+qzSLfvFaQKT29fyoSm6m7h+tSqZpi03HnF?=
 =?us-ascii?Q?P4CoCI8sBDI6TbAmvhnRybdnyUFFPwBYC+V1VaGmeq6Bgh8147VCeZ75dvTD?=
 =?us-ascii?Q?lcbunMnTJaLhuE+Vr+zewdlwgJ6mG8TLMF/nc+GNPBq2TaYxpYYA3pnZdvqz?=
 =?us-ascii?Q?vd56K+VKgvwf3BMya0gTqE+TwbnYPbkWNhXwVzK3q/iGXqhyBYu6Ecmq5Ufk?=
 =?us-ascii?Q?KgxrfAj8Of0+/+tbNDB4xLrgOcV44g2l2PfyOuRrA2d6bN1ztprdE+C28OLn?=
 =?us-ascii?Q?CxNPyYoZDcBvEPjFDwSaXwwpHvsUyd+BrdSLQodk+SHE6GapyCRXwrGiU9eY?=
 =?us-ascii?Q?jJf+HUQT4PjRzb8Ow/v0eUx+6PqzQ/qfcWXRKbzXixWRKe5FwZPkgLv0dR3+?=
 =?us-ascii?Q?RzN7gqPo7wi/2Q5O8CnX0Yrks96fjW33x3VFsaTZk2k3mcZik+e475Thlnhi?=
 =?us-ascii?Q?faYIwI8SCh2bbq5s7rU/1WV1dCmpPLRyh2vc24x5Hmu+yfoJbi2sWTgtC1Vp?=
 =?us-ascii?Q?lkmZA5qmnLofpI36PNeL9xOe/uv9iJCK/06TOKnvlP1XLiLRMLBbGKBO+VxV?=
 =?us-ascii?Q?K60OlhXKTcIXds/OROEIyQA442pfzrLfi5OPMa+TVwmrNySp/Vomq05REjDf?=
 =?us-ascii?Q?GCEvKxjue/KoMfXken6riH5EwQ1L4HncUiQDTOBoCEUur68MJprlOQQsj6Hy?=
 =?us-ascii?Q?7BRIfjKbj6/6ALwvBxZGb39pkw9fpg2Ey3HN0Hjhnjvdv5dyCsKhPobQrzDy?=
 =?us-ascii?Q?n9cSTkqLy1whKpIbQHJR7buqriLFIrgiQQbwOGeZOxovmJxk88kh4FBev42G?=
 =?us-ascii?Q?ICitDgGzClilyaQwG0vnx/88dTMeIDRzkVfucf9JHvkr+fG6rky/oTS1SjgV?=
 =?us-ascii?Q?JqfXDeoW8xVAG/UTBXU2NSbtIdZDQJARoAiV6XWgfPEzBC7JQt9nKXv687mJ?=
 =?us-ascii?Q?s9eb3vNdHAajvgZKifxi9DNgROJNgMdxr1Bt/KaaKe8ozjTH7UUR5O4AMZ8B?=
 =?us-ascii?Q?Dpio19dfSwvcaim/xayPIVYWXuzXsHfw0pdcdsqTvKgmbDf1cDKydMrJdHsL?=
 =?us-ascii?Q?f0RBVuU7n0woQpWi9TD7CJBWatcOq+vRXnP/oIk1ygR6IPG2rtuWXXH76O52?=
 =?us-ascii?Q?d0zejHG3KialtQSzf1I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c02e7bcd-ecfb-4a31-d37a-08dccc7fb705
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 01:20:08.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6f0mfGRouJN1OP3VKfjd3dmsjvM30Ny9rw6CEeNuxM843T6Kwh+sJ820zIZm9If+ZessRbb3UIbfzMkAgRwnLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8399

> On Tue, Sep 03, 2024 at 02:17:04AM +0000, Wei Fang wrote:
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - ethernet-phy-id0180.dc40
> > > > +      - ethernet-phy-id0180.dd00
> > > > +      - ethernet-phy-id0180.dc80
> > > > +      - ethernet-phy-id001b.b010
> > > > +      - ethernet-phy-id001b.b031
> > >
> > > This shows the issues with using a compatible. The driver has:
> > >
> > > #define PHY_ID_TJA_1120                 0x001BB031
> > >
> > >                 PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
> > >
> > > which means the lowest nibble is ignored. The driver will quite
> > > happy also probe for hardware using 001b.b030, 001b.b032, 001b.b033,
> > > ... 001b.b03f
> > >
> > > Given you are inside NXP, do any of these exist? Was 001b.b030 too
> > > broken it never left the QA lab? Are there any hardware issues which
> > > might result in a new silicon stepping?
> >
> > Yes, some of the revisions do exist, but the driver should be
> > compatible with these different revisions.
> >
> > For 001b.b030, I don't think it is broken, based on the latest data
> > sheet of
> > TJA1120 (Rev 0.6 26 January 2023), the PHY ID is 001b.b030. I don't
> > know why it is defined as 001b.b031 in the driver, it may be a typo.
>=20
> More likely, the board Radu Pirea has does have a device with this ID.
>=20
> > >
> > > Does ethernet-phy-id0180.dc41 exist? etc.
> > I think other TJA PHYs should also have different revisions.
> >
> > Because the driver ignores the lowest nibble of the PHY ID, I think it
> > is fine to define the lowest nibble of the PHY ID in these compatible
> > strings as 0, and there is no need to list all revisions. And I don't
> > know which revisions exist, because I haven't found or have no
> > permission to download some PHY data sheets. I think what I can do is
> > to modify "ethernet-phy-id001b.b031" to "ethernet-phy-id001b.b030".
>=20
> You have to be careful here. Stating a compatible forces the PHY ID. So i=
f the
> compatible is "ethernet-phy-id001b.b031", but the board actually has a
> "ethernet-phy-id001b.b030". phydev->phy_id is going to be set to 0x001bb0=
31.
> Any behaviour in the driver which look at that revision nibble is then go=
ing to be
> wrong.
>=20
> Maybe, now, today, that does not matter, because the driver never looks a=
t the
> revision. But it does mean developers might put the wrong compatible in D=
T.
> And then when you do need to add code looking at the revision, it does no=
t
> always work, because there are some boards with the wrong compatible in D=
T.
>=20
> Listing all possible compatibles suggests to developers they need to be c=
areful
> and use the correct value. Or add a comment in the DT bindings that not u=
sing a
> compatible is probably safer.
>=20
Thanks for the suggestion, I will try my best to check more data sheets and=
 list all
the PHY IDs I know. I can't guarantee that I can list all the PHY IDs, but =
I will update
it in the future when I get more information.

