Return-Path: <netdev+bounces-169886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E121A46416
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941003A526F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF72222CA;
	Wed, 26 Feb 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ioi4uOEl"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F22222AC
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582440; cv=fail; b=lahIWM8o1dgKhqgMmiiWo1mRwbolJUB28G216XYGXh3GGhnpDZkkdc5Sg0XLI4A9wcIz1pPVM2kAgRzUUrvYhT4ZJVTyXY6KA+pGJjk0H5f+saL9MlfSmReZ2jc5RjfBuOOOK8K8/nKdUobBcsR4ARaGFCBUZRG6xMe+Px2nDzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582440; c=relaxed/simple;
	bh=9eZDn0WxAFpIHi5/QgEGNosk65PMK2QjFGXhXsq4nB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XIMK901v+3LCnSGY/P5V1KRUmLZV+ss34Ovsv+NQrZ+orVXVhvFJgwnU1DERBdsw2/iJo1y1du6cPNxnqqHdfuUO0UASXy5buV6hBroxqvkO2Ha0lfJRBxPOkrJWfvC1dBBO5nISlB4elTkqyrDGaFdKRsRlpnyt9CKB4cdY8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ioi4uOEl; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvebmZrArXXrH8bkZXHxZSJJbp63FjccdUrrTGwkqCDqzyGhEUSQ6emHq3m0XKGpnpnPnShB9BQDMZFvuuxwEaN5F9qXT7OwOGxQzoFx/cCIAM6rV8Aisw3sNFClUHwJXoSHooLT2NHjEK4lk4+KB9+cIu7xBKaxOr6wU+7YC8LoRWeSJY+RNZXTayqIGAEe7eXuZ9XX9nXNny5YX7TfRwbClReQdPok2AW5PwrSGy8NCejAsa/go7hrfzr+m0k3WWx3ZGYVK+pk8CJ5IF02mK8bJpnnNbT29WCV6MQKCoInGJAUIni6jjUYD6eKRWPTbIFigL98mvTIhVpjFBh5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hHHSHCoqAVELe0ADOMb05dmvw+fRjr8imFDuG7d3Ms=;
 b=LaYPvTTAOuC6QYVBQeTiTiP2vCmzoSQjCmjmCdAeTxN400X9KtHAJNlt17puHI8fF7der7bjmTSioGwiJyHyiAXAllINX6scu1KXuGD8EnC3P+LbC0eQnBocEFe70qremYOToJvaIGbovzt0WYVNxI67zpS+anma/pp6+WjIInC6M8rTTg+l+SfLeAKiyN4AMAK7Y766B+FOrS4RSE1QwPINGgeAeDxb9zHdNzoEt5XcaEepD+2NqNOit3kB9ux8Z6JyHu1uf71PuVnAm9IN490YCJNgWI7e9F2PHbD/od+ATyClK6Do4JfynjNVHDsWcpaPN1+dbhBHmM/fCdyvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hHHSHCoqAVELe0ADOMb05dmvw+fRjr8imFDuG7d3Ms=;
 b=ioi4uOEl80SFh4+qoEIz2Q6b6tQLJbAphXJ8q6oM+sOFkZvIGwGQgP3xCL4T6dBI+E+uEGdVer7Sp3W3qEUMhWAGDSEyLtRUJQ7Xsw0fMLzzz5j/lUfKFK5ecaNEYUZbbtXmKmpxGZXRpFfmYuXEAPamde72I66gOy/B/1jDyHCdJMcgXncrVrewXzFBTLcscBoLLZFiNEIqRjWHwGtTTX8swxF9mM26+HeJcgL1WPmLoKJbAc5FBE1CkajpqUB0n3jUg2PBgp38t/h3qkzugt+ry7oRerYJ7qIJuuDBXu9/UVSLj8OD4WZqyyKV1M0UaNh6DGFAvtywmIWobU+nGQ==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7938.eurprd04.prod.outlook.com (2603:10a6:20b:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 15:07:15 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:07:15 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Topic: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Index: AQHbiGAefyqrOsoxP0ODsjWbqTN29w==
Date: Wed, 26 Feb 2025 15:07:15 +0000
Message-ID:
 <PAXPR04MB91856660FC7E8BF3A8356D7889C22@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <b85b14c1-611c-4002-8fc9-cf23bc849799@lunn.ch>
In-Reply-To: <b85b14c1-611c-4002-8fc9-cf23bc849799@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7938:EE_
x-ms-office365-filtering-correlation-id: a7427ed2-025c-418a-74b8-08dd56774149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3nHbbiMv4IaiTbZicBmMYLLwRdexb80rDbbsIzCmqFU0Xo42wp4hUJF+11r7?=
 =?us-ascii?Q?94Gdd61WAKwyfw6/N+MjT+1VTKyt3GU/bC0PM9k5E0x9V8FIfHmij6KGGOHp?=
 =?us-ascii?Q?4oT4g7zDbuhy3k6XYAqejHyp5KSOhH3wTpI8LRo9fI32cSPjOabZsA8QUzVI?=
 =?us-ascii?Q?EQqT5ZsNF6XwZRnDWaf+9rsWah9ULUyoxbMLDfS5zxoF/U5MgZWQbFbcfCSy?=
 =?us-ascii?Q?C5D0BsBuvbCvHprjHLG/T37x1xjLpER49YzunpMthvVA+b7MYqMkwEwfgwk1?=
 =?us-ascii?Q?iQY2eoJgC8HcBaxNV8h6Vp6cIUBzJtCrjouuAvS37lN257/KmXqZRg2yWFq7?=
 =?us-ascii?Q?HpeDt0PEsNbgYr7Y7d4u0VidUJfj9wvzoHITU1fC11hVAijL5EerebzoGhCJ?=
 =?us-ascii?Q?avX6Z7tUwKxbpV64JIsy/90yw1TkBU8FcnwDHAWH1S7FGANSu9SLnKAAT8HD?=
 =?us-ascii?Q?IP9hB864aKpUBb7tOXqhom4suZKQPp234H4D3Mf/IwBWcOmqv+HhzHGhwrvO?=
 =?us-ascii?Q?+YZN0Jxm1KGcKl9RxJr0f11Ug0gG06HAuxu1gMval5jkZZGWk4pd0rjw6iLT?=
 =?us-ascii?Q?tv/trcYX1+rIaYgl/7E48AmM+B+YSAW1IKMVwuFarnPWXyn0DCT9l+InoHFl?=
 =?us-ascii?Q?h0LvbdIwv15wMoDfOil9RUKJPVl8T7X2qgcqcwwS/vEQvnGJqgRhqqLjZwRS?=
 =?us-ascii?Q?k2T4cGH8l9gXjYx3+Nuq46KAFxqxm4rW0iQZEzF18g4FXUwihrOFnN7+dGSA?=
 =?us-ascii?Q?XIRdVEnZ2A+B9IrbSLTJeWrBXFJjyNSd9sLZKB9ZzPOZ+/aVYxdRypavaEJ4?=
 =?us-ascii?Q?padDXI6EER0KNpBPg35iOwH5NlX88dgMgNJJpAESnkRfY3GFTRG7EqD7vg9E?=
 =?us-ascii?Q?qh7UtYYCqYtC+dYN/dhXvO/oOsV1YyD6NlBzA4f97wfIywI8BdNgQpms66SQ?=
 =?us-ascii?Q?GUPSi+q7cIBPH9bcJwkJmRNiZp0A7J/paOOwDxRLrgh0Y0uSAuSC1VxFhLtj?=
 =?us-ascii?Q?O6jAyYXdGkB6srtiuvkJGXpxSsmsvBe7BrPJS4zlCNMb/680QrnOSFG9GAX4?=
 =?us-ascii?Q?i0wa+8ZzDViQJoT4U+I197HwNV8m4TJoGNlTpSVIepdFChP55+v9WNkdN9RN?=
 =?us-ascii?Q?bHGMxdBA5RvUDh8BNFmAxlqiGP925ISeaEn0ct58zzF2a0Pwdd5isnoZakWh?=
 =?us-ascii?Q?pg/IRWGnphd6sBO5NaNLzaYtQU93PgvXM+fcPiSsR+Fg/cyIVjUXcKshm1AE?=
 =?us-ascii?Q?5b1y2BJ7xpr4axsBgQneC6Ym8He4rH20qoDXSiTlFyQN5JoxGKtuiyUq00x1?=
 =?us-ascii?Q?cAGgBiiEnQngFVJuXKOJYdZFLnVoLNBjtX56JIT6UmJlOwKHOyHsALSoJsSl?=
 =?us-ascii?Q?pYFD+lvGXnOpPntaLMC/nG4LPwWDlRxMjEP85JAyfQkyOLs+szLp6yjHcl6M?=
 =?us-ascii?Q?hwDc5SIU5otlwPeQMeDYFmNH9CzElVge?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/+qd71C1gqNyoO5XfGnU+K5HICcr6owQdfExHxhIt5B+zse8sCUhvL6vz0gM?=
 =?us-ascii?Q?Z8cm1lXksCVVqLE/jmaaoxug4poLvVLcDkD/zSEgw8O8NxDG5NSqtoYXyjBF?=
 =?us-ascii?Q?rtQ4rM36qwbsx9dD7ZCGnXMJEwANvY/17karU+dnhVPi4VQ+s8+pcO5Mut4/?=
 =?us-ascii?Q?I2CoV2Iz3CPrjUsvxPH7u0m7v7Jj/I41YLsX0Px6Mnf1Ndn1coK9kqYMiBhk?=
 =?us-ascii?Q?MR8gckcL6pxL9xkEMlpMp88U5hKS/6RdrrG/y3eXBoM3E5K327jsHI3SBf7b?=
 =?us-ascii?Q?eBOy3CB0vTMx9a4zFyI9GivO/NrMfv98Cmi5fwjVv7VyRAuDq8Bq6mdS0U9X?=
 =?us-ascii?Q?RZ2iJpRPNPu9U5no8cvy9XLzRr+n5oyPoAG9BbAbikuYkFk2xdw/2YvugwJm?=
 =?us-ascii?Q?n9xNQbvW6b+mi9Ph5/xuoIPaBwC0oRL5PfH6IYq49FvJ2A9fqhlSEwTpV4oD?=
 =?us-ascii?Q?28G6AalzYkhuOF8RAnRUnwZh6i8WCNy0jKo2XQ2jget+SAR85XFAD5jp24Sl?=
 =?us-ascii?Q?KTKHquIdAPG7LrQg1l9ZcABaJKskgPm1TsqxrHs2QxETm/BlH1ff1VIAmIgA?=
 =?us-ascii?Q?Nl5kCcjxTwGHUodW5uMYBJxVWwfoRx4V7Qsdc9KXUmH0vBWsR+4CMQScJl6i?=
 =?us-ascii?Q?DTnkelhg5D07ZbCBxkowM0ZCW4brmYJ7vb0hpb+Fh92xchfNxcc9F+yh+6Jr?=
 =?us-ascii?Q?MS28VZuxq0OPzhMN6dGWzfj102OjXyNhQsStoK0KUwfndvSpe8xVtatwF32v?=
 =?us-ascii?Q?atK57X/sOkt9iOpusbiqvWlI3taaBLTt/sTom5hGjrLIJuKRC9aHzHGpysQt?=
 =?us-ascii?Q?K3nYzt+8gWqRoPiKqVRTNRxSupzzEgll6gblgLv233IGrdSdkI1CZ2YnqP0j?=
 =?us-ascii?Q?DKlZuDCkJFkJM2CavvPKkzo+dSChOaY+LLtIR6r1jTHcnMgk8VWXBCFR4XFq?=
 =?us-ascii?Q?ytrxSiqlpB0KO4CFkdG0gwDw113Is4p5ih0UktoY8MRVmwSyz4MiH3MEWom7?=
 =?us-ascii?Q?aNFNKOpXw7+A1QSq25Raj7IAV1di/WGsaHYOYaLD/LxiDGUkueMYN2dmmLx+?=
 =?us-ascii?Q?zLb2pEJGoP/tFhCqxe6Sf/bJDA4MYLup6M/hbGQOiVHkePKgkPtFhMm/LpGI?=
 =?us-ascii?Q?roi6Zm4lSe1NmXQcCHIh1u0x6GD/lwQI50mhUISGFIW1zHc5gWP1PFyrhVp0?=
 =?us-ascii?Q?vgea9YMKgb98L2I8T4etAksGv48az4yMDBwfYTroiut8KPRYFGMmJwQ9F65o?=
 =?us-ascii?Q?9CB3w4QIBd84IubziprxX6KbSWc4XOG0aUvppeo/IhbLo5A/lWiHpIkGJHHs?=
 =?us-ascii?Q?8Ro9VuNKPLKYBm6DYIo7gEd2R1eVcL8vDl+MsjD6I1SfsEy4I89si7OXV547?=
 =?us-ascii?Q?APlsjWFcbBOtEM1IQCd9n0+yVMYh/tgXzzHk5fHUVdRfp7IBk7Dp+xaOEggF?=
 =?us-ascii?Q?Q8rJuz2rwHgl8Or78f/sMsIFcveLvHmAIJLcboyB1JlxdZoLS84nQPuA9YOd?=
 =?us-ascii?Q?hVezbEd71lqe9Pm2b3pr8LXLx1tUUd1G91hfRrlq3QZMVIi3FBTn0mkU2ecP?=
 =?us-ascii?Q?Y9n0BZTGBd8T0VWhwzjLver6hISodJ+mucROJ83z?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7427ed2-025c-418a-74b8-08dd56774149
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 15:07:15.2786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7GT/LAmE7VdEVDJFUYyNZ5nbddknnZxgDj0W+VfEusWQIaGSGKJ0rBFGkuczWjVoACJ9TM0Wzwfwy5bDvmCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7938



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, February 26, 2025 8:58 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Vladimir Oltean
> <vladimir.oltean@nxp.com>; Wei Fang <wei.fang@nxp.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> imx@lists.linux.dev; netdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.=
com>
> Subject: [EXT] Re: [PATCH net-next] net: enetc: Support ethernet aliases =
in dts.
> On Tue, Feb 25, 2025 at 03:44:58PM -0600, Shenwei Wang wrote:
> > Retrieve the "ethernet" alias ID from the DTS and assign it as the
> > interface name (e.g., "eth0", "eth1"). This ensures predictable naming
> > aligned with the DTS's configuration.
> >
> > If no alias is defined, fall back to the kernel's default enumeration
> > to maintain backward compatibility.
>=20
> GregKH and others will tell you this is a user space problem. Ethernet na=
mes have
> never been stable, user space has always had to deal with this problem. P=
lease
> use a udev rule, systemd naming, etc.

Thanks Andrew.
Does it mean the ethernet aliases defined in the dts are no longer recommen=
ded or supported?

Thanks,
Shenwei

>=20
>         Andrew

