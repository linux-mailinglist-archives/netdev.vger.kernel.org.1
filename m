Return-Path: <netdev+bounces-194982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B118ACD5CC
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 04:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC4017A080
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 02:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067D1482F2;
	Wed,  4 Jun 2025 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYQM4nub"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681EE8528E;
	Wed,  4 Jun 2025 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005077; cv=fail; b=idf7mx9hZOEz3Pt13cmwBi4SBseFIKxp/otWy+W8xVDeojKFH/mBxv9H+9PZ+ZOTVckQihu2siSFveu8pefVv1t1vakPKPIHdFu6oZ+rpW5Nc1X7aHdjqro2H0amnKgWHKe5UE1EqSWpGw4OkWpXZK/jU72s525neqBOhmajqY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005077; c=relaxed/simple;
	bh=4WZkdJRcyldDoTFLIbTTgGAcLWL8fm74SDZoGgHjKOk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzavtPbfzbcQngkGtMT9aXVvk2h/x7VQRO+hOt9ZTt25GbKtgLLgK0+4HikukVPMCoRTODBj/8au/U2z8UiDSgcnxw84ZdpQ0XXqoFbVtbCNExt9wVSUL9CMgGwYeNtJwxt6TLpbROQzu/uip6W/2+u0BKV9DchpxeVorP4o5g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HYQM4nub; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaWlxNDvLRuUi6Y4JfGMOU8s2JbFDBTpeD8/Z7wDXm6JNDi/8OWuxYD26aKDg2/H2Aav3jo300zebxvPfuJsRGY9Mwybmv9U4xO19dPqXY3YASYrfZO0p0wMKnYeQ2Rr05GX5K029loTy9BZ3nlmQ195APZ6T34xISyCJo5o4p0QgT9cjIsMRST5OP1cabMJCcCO7VnAbgn9IIh8/nq5cz+aJqEl+Qe6upKus4Aw20hrhFhB1yrmuV8AHSdCHb5OpgDqmjMlc7wokG19GAXKZgTsh3qT6hGHm6vVj/hLIXwzhBOcR7F56hBwz6Fhldzr2HebZedeG9L8I+3LH0YI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB6LuS96OHorsNjp3zPvHGyZ0hWN/X84d38B/LyCi7Q=;
 b=k0C8qmbQi6CLjMM0kvAIZNZTMlYvk2CeXvGFPlQnAhVupByZk1HZUAylaUTSu2ehnORq/hyaAjb/IZjTGMkt72KLMmaFSyHeiFXTv4UowdVfy2MunvZu7vnawY//JPpfaEXyuZcLH0Pe0u5kxKrnWX8cm/E+OuduaxHvCOvLK0lFxvxHDWeftGZu7lv56tbwiZCAjemAIA6lhDYYk4zIFt/emBnKQVFKWgbHldDkmAItU8g1JQwUVJhoFf0JlWyQFZiGVq5UOZanuXSe8w98kZlAgyDF+Mo6weVYyWPUDpirJ5+QmaWmTboRai2QLf8y3rXNp5rC9ry4io9+yf6DKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB6LuS96OHorsNjp3zPvHGyZ0hWN/X84d38B/LyCi7Q=;
 b=HYQM4nub7uZmxFXssOLkUkYR3R+p+zkanEjzd8aNXqg1mgrQzAw8neg8ynM6/UxHfscMbprLb9T28H57lvvscSnsg68R116o9tDefL2tL7GiUQ/9O/KJJqkq8dRfc6KL2uLuLUn69wFVPf5JCWv55l21dy61NyNe7pkT3tXUs1OvwJrKx2lYFr+IAuc7rZ9Y6ZXEx6xdNO8m9DF4XPIrEIU62fu3H5QTys7OZiNUlH9y0snemXFtCOG7mzIM9pdLmAfopR7iLPDyr5OS2VJuwtPCuSkoyQ/skPUvJSN2gH0u/hcXRIIhhGpyZ7EuDui/M68XBZBfdrYbmrYNuNULMw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 02:44:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 02:44:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"arnd@kernel.org" <arnd@kernel.org>
Subject: RE: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Thread-Topic: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Thread-Index: AQHb1Hg4llIxzk9mvU6olT1BgH8nCbPx58+AgABhlvA=
Date: Wed, 4 Jun 2025 02:44:30 +0000
Message-ID:
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
 <20250603204501.2lcszfoiy5svbw6s@skbuf>
In-Reply-To: <20250603204501.2lcszfoiy5svbw6s@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7659:EE_
x-ms-office365-filtering-correlation-id: 0c9a8ab4-31b6-432d-91be-08dda311bb2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TP/UZaWXBS57oSmVYZF3PiYSoWZoaj6pvm5dMv1fwR6h54otReG1I1luPjaP?=
 =?us-ascii?Q?nDwCOLU7zL0H6hZ2NvfaD0CVkgwZ0XGjgUdTGqOdL6tEsj5U6G2RKZONZ45w?=
 =?us-ascii?Q?tXzIzej7NprISwccI90fkemg7sa7mGL/IMfLvU0asHepVAdJb5OKqy7sbSla?=
 =?us-ascii?Q?gbKBDTNAEMuDcJ1qA/OZdxDUBq5UlGbOGugbasDFUQ7Sl8mGQXKpWIILQH9S?=
 =?us-ascii?Q?u2ZroI7nBkxMgQIhiePOpeQEoyJ6U8ozrmoexiAl5pLrunlKbQdr11UIqs7W?=
 =?us-ascii?Q?X3cbidHSnHeDBYyqmJQByflXc5iZWwJCKFETYuc7zsGsOMD5mdtUIN+Yn3UZ?=
 =?us-ascii?Q?ACf94VjQ0R2AJyQNxV4JhbYJTZ1TR0bPVobuaQDrF25oXQ0PGgrOFPaGC0Fe?=
 =?us-ascii?Q?/dl2VfigW78Qj23QnpUYJKjUa/qQKmY/fgbtIkdNCAX7fLhzKDs8e3yp0WQq?=
 =?us-ascii?Q?XyoyJmfIGDhXt8YGPq+m+HXh8qT5j+6cvR1CqK4le5c+8ASbu2NeHCfNu4fD?=
 =?us-ascii?Q?bFGxlp6lNlOmFfMTbxYV5mfFvbbfqv99w81bHGRGK92GKAMcXN22IokBm399?=
 =?us-ascii?Q?T6NWgnwWJU/xJbrPF26LcvCyvGbuDZ/ge99BsSjEzwJbtbgJxf7tFLJIIS3W?=
 =?us-ascii?Q?hLx9cufW9K1SfKSrokxybmOJjt09GsS4mRpUh/h/kXQixUQJTgiaQahevLUi?=
 =?us-ascii?Q?uIOxgyz1jnzDCuWeca3mKkLmX9C+2mhnwwLHC+Hfi3cWcnkX4yuY2wPy52A7?=
 =?us-ascii?Q?WA9Vu5oqhCxpIbnVzOhKLWfl8Ec89GWkJWPmUUcvXziAVpPRwmtkdn0XudAP?=
 =?us-ascii?Q?xo7kBiPcEnol7tIkbDXiFrDrc1WHw2iA3uKBEoLnN6qXnCcLSb0kvlwMs5h/?=
 =?us-ascii?Q?Jl96WztvjThqcRg2V/IRCs4g2v80fVKfe0A6MDs/fpmuqKKapi6nC5lh/nsr?=
 =?us-ascii?Q?AxUkj1uIcDWjyQl7ikMvxdSoHR+qvV6+SiRTld+sz908mvg0LaxD/JjRTldo?=
 =?us-ascii?Q?FGygPCqAN1sPhNKeJxvZj1fQfy48wL530MSRn6iwAHI3358ySsH11RY0lOIi?=
 =?us-ascii?Q?iOI8RaDY1Yd6s6G4VfVVSTQniU6zIXpAR01FlSDPGnP9jVprG6TTwa4BJq0F?=
 =?us-ascii?Q?qPJslZWi7CXYRLO+pWO1QRve4lkDmj/anhi2/pGRYRiJOqz212AY/l9EyG2G?=
 =?us-ascii?Q?AUDjvrzUiHDGXWfIFCdantTkjEyYKWV+lgwyUyNh8Sj4UFXg1TDSVuCEeQUU?=
 =?us-ascii?Q?PTlx7prrXRg5HjxOlFpkHw8Yf5YckQuz9q+h13GZJD+i5Ut3R93MBaLSuh2b?=
 =?us-ascii?Q?8UaBWlZEVLIBIifhqWOeHDISVihE+yKOVEXNsn6PmPV9V0/0eu4ztdC/JWFn?=
 =?us-ascii?Q?1dLg6MYLN/BIf9BIleG9PehmAf8myuShcr7pmvBTuBXaoNZ6AKi474BeMJfr?=
 =?us-ascii?Q?1ys5IiS0WP8yVzuUILZMQIkIIJdqpDng4A9x+3oSD+AWrD+IpWZC5g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uyU0sWNpMqYo1QrylerV2YfuEDGtL5g+vNoA61LG9rqCWOt6X/U/BSL33Sx4?=
 =?us-ascii?Q?bbbuTSag1AxSEJc/1rpa20n1nCjjBJzt818hYKQZGZ+26cHSelYGrmwKm+HI?=
 =?us-ascii?Q?l/WDIV/V+FxrnqE1KPzcOae9OfghcP/HKctU/ptQVjOwctp1wjUwTAbJpG6n?=
 =?us-ascii?Q?GFZ9JxsRCcC6PsVKAlpbd+ol7LFm6+L/qrjAKewVyq2Rv2UhTl8aHBzwCUgp?=
 =?us-ascii?Q?otN6l8eUNkObmMl0DFQWzd5M83Rt2WOzOHOChL8euaeFThHbHITfbMOUddPF?=
 =?us-ascii?Q?QA0lnNiNdkkL+l2Si2VjOSaU6UTjXv+qGgr2P/dWDUz4cR1f6yXuas8q41ol?=
 =?us-ascii?Q?kxtg84w2YOzjYpF4rqjxgW2mh0yftbwuEWqOWKM7ndUp+sV/o2iAo9k39kRB?=
 =?us-ascii?Q?/do2UVwB/0KO0+3Depz7x+sAgaRDD5mIsxG6WREmCbqJAFgqTMVB0qUnl6Um?=
 =?us-ascii?Q?FAE/zQ1lqeuZmGvyXe7IZTQ/5OdfUVCOSwBd2aWETdNM9rk4Ac5umBH4dOmg?=
 =?us-ascii?Q?ZEVoPzMOlWfaPtV7RC5HWcl59fwQ+i8FgDvk0m5+evpvWsWyE/kXUuj+15Gs?=
 =?us-ascii?Q?NRJ4Biv3O07LNDZFpcqmw+6O69GgSHLgn+bq0rvjHaws5+WXgNceRg1BVLQk?=
 =?us-ascii?Q?U0gYxMShtQJXopSCrYamQr2wunwL2vbgrL9QbfGpJkSZwUHNz4QGYtoObLkG?=
 =?us-ascii?Q?U1c5rSX5L8rkQBJuOc6dXZAwlaX2x1Vw6VG+LMBWHEk76/FyEGT/8l9WDTV/?=
 =?us-ascii?Q?yY3r0JWkM30XvwG+Z+w3A/BafivL/9CE8FtBXbmdGuJY8+sCNwBwPnPV0f3j?=
 =?us-ascii?Q?wSfD59T5ZwJHXb0UY9A2INMU01OhrpA3H7FSNz0MLFBQUjwJqd0v8zQn46bb?=
 =?us-ascii?Q?3UrPS3J+j93vEvGUEJkk/LZ8F+Om6jTwFZK6Rhav2FX9lRDbwBfzdKdMJQg1?=
 =?us-ascii?Q?7VytKg4tJVTieLcMn1PKK0N37+FX41XlBI06Sa903n+EXejBFIUgC1+EO8mM?=
 =?us-ascii?Q?sAfBJ6sYz/XeGG2XdHro97UP9xx0sTeoZjr1rXa5XphpBB49Jg3iPF6gx/cm?=
 =?us-ascii?Q?vILj8BLQoR9vt7F0YsddpJw82Wp0WUleCpqI7w6Rgdqg1+6PLzRFlE8ybJlP?=
 =?us-ascii?Q?bOk3wAXizFWC9ZjX+8EKkxbN7NNFYPS9PrhZDbf/z9zLAauRrSAOJift1nfj?=
 =?us-ascii?Q?iXrqkklxSkqAANmsc5xFgNpxQx9vQsQjJA1aD437DjpFTUAlTB45qDeXBlay?=
 =?us-ascii?Q?xPXXil2a8kIUlX5a0ObD5duBSRJTktXflhXfO2+fBHPfAda6gLCvuvtOy+2l?=
 =?us-ascii?Q?EAdFaFqpUaxi2Vp84yLlBcjwC7WLsXu9TURwlkmYKG8BekOSsy3Evh55XPJ2?=
 =?us-ascii?Q?IhPHyTYXw49sbTxqvexXE5QswSBfC1jGe1i3ovzUb5n4PD4smlppl3FSzI7i?=
 =?us-ascii?Q?8A41qUGFGWbd0xe4QRZHwGs3BI7d7CtuqSKeZPfwM6Gnc+VMLy6JAItApM/0?=
 =?us-ascii?Q?uQ4bEK37pOwGPu59HTd8sTf38TvdgR4/aJGxv8obSshHyrf8MlPAWoPUhbB6?=
 =?us-ascii?Q?hRETdNVNHzoRXsyVoVE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9a8ab4-31b6-432d-91be-08dda311bb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 02:44:30.6535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j7h8nR8AkwbsrgxRGK1mh2Xb1z2bRBWhXg+rEz70vQfLUAuYLF0aRCOzZIwfIkvvr2IyDysy4gVPnzOJfy2jWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

> Ok, so to summarize, you want nxp-netc-lib.ko to be separate from
> fsl-enetc-core.ko, because when you upstream the switch driver (also a
> consumer of ntmp.o), you want it to depend just on nxp-netc-lib.ko but
> not on the full fsl-enetc-core.ko.
> If the only reverse dependency of NXP_NETC_LIB, NXP_ENETC4, becomes m,
> then NXP_NETC_LIB also becomes m, but in reality, FSL_ENETC_CORE, via
> cbdr.o, still depends on symbols from NXP_NETC_LIB.
>=20
> So you influence NXP_NETC_LIB to not become m when its only selecter is m=
,
> instead stay y.
>=20
> Won't this need to change, and become even more complicated when
> NXP_NETC_LIB gains another selecter, the switch driver?

The dependency needs to be updated as follows when switch driver is
added, to avoid the compilation errors.

default y if FSL_ENETC_CORE=3Dy && (NXP_ENETC4=3Dm || NET_DSA_NETC_SWITCH=
=3Dm)

>=20
> >  	help
> >  	  This module provides common functionalities for both ENETC and NETC
> >  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common t=
c
> > --
> > 2.34.1
> >
>=20
> What about this interpretation? cbdr.o uses symbols from NXP_NETC_LIB,
> so the Kconfig option controlling cbdr.o, aka FSL_ENETC_CORE, should
> select NXP_NETC_LIB. This solves the problem in a way which is more
> logical to me, and doesn't need to change when the switch is later added.
>=20

Yes, this is also a solution. I thought that LS1028A does not need the netc=
-lib
driver at all. Doing so will result in netc-lib being compiled on the LS102=
8A
platform, which may be unacceptable, so I did not do this. Since you think
this is better, I will apply this solution next. Thanks.

> Then you can drop "select NXP_NETC_LIB" from NXP_ENETC4, because the
> dependency will transfer transitively via FSL_ENETC_CORE.
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig
> b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 616ea22ceabc..ef31eea0fc50 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config FSL_ENETC_CORE
>  	tristate
> +	select NXP_NETC_LIB
>  	help
>  	  This module supports common functionality between the PF and VF
>  	  drivers for the NXP ENETC controller.
> @@ -47,7 +48,6 @@ config NXP_ENETC4
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_MDIO
>  	select NXP_ENETC_PF_COMMON
> -	select NXP_NETC_LIB
>  	select PHYLINK
>  	select DIMLIB
>  	help

