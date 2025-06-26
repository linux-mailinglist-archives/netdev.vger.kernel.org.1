Return-Path: <netdev+bounces-201480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA4CAE98AD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A94B6A51B1
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3492609DC;
	Thu, 26 Jun 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JAkNEr45"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C67019D07A;
	Thu, 26 Jun 2025 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927243; cv=fail; b=U7f42gz8GKf7NH+bLYLStdOgoyhCJxGW7zU+a16QRfu5oq/6GMm+MFKnZDn8Ij9TE95xEGwXwc1a3j3lvRKGN1evpr/VTuPnWlBi/OfTWfIonpN52BXxB1qfBnIJOhTnwhUcDdAtsAzX5hgRJw81aHzxih0Lsx1CbhSYVbnhtwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927243; c=relaxed/simple;
	bh=lJlZA9DimKEYpddZCZxOaviFqLuqTiNsvFqYMA2FnOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OwIDVwfBJ6k5W4Zk/aoxFxmesNJZKoCH2j5mOnmK+0J+eB5gycfZvrubi5Ka84V0rI62HoOW7dr//QpNx9etl2QmtOfwKa1uLc/4MvDv474+Jci41RKF/csinbHdhG9nsHyJZ0tpsfv2m1SSHG9WQcr0212r0obANdcDBofYTj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JAkNEr45; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIt5xmn8vvAyEMcGcQ9J0kJpWJz4j/bT0pkKEJnTQfwa4e5m3vR4rty/lZsX04+G+FpOxFy3uPEpBG4hr9qrY2nP6x+Qm6965486ZuEsj4dtvU/X1xrceh4ftYWB0ria1A4IWNSojX2VhiNwGIao6EPER1C63UQ1jWIMpMTy+e/EcJ0xMT7KWcaqfd9KQ2SAhCI1RQFxTM4aIMKPS6mV/jEMj52jv+4JJGPaCZt8VnTPgB3/9BXWQzsLa2j4BFlrmezm2ASxt/NgF9oD3Wd1CdQVUD8KorNRJdU3wW6HFG3nBES4DSgX5wcNMAcvKoEp2vCqZuLk4hgohWn2lTS/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtLqqnptyC3oWZAAzvBWIKCA3utYT4OwzRRg7n8+7QE=;
 b=qofa7NbkMcILvdbqA+0225IkoFlQ1JiXepqR4r/BhzJq8G1ExoYpE6s4RETawVqmMsS0Y5nZxUzw25jwoa1wkWyzJrHdiyAMoqKhyqM0a+OJpdoowKwqET8SohJy/GC5B79F7EGLBlG64SCxYwZpn5836jqpzrFmO/7zQxfdeUEcPqDP+69QjdCnlBVOHGBpd8fIs05l8Uoak+kpoMH599kE8n8NHGAlA2r9Mp3o0bm0CR5omFoGjX6+uB/DGGAoUk2EwZ9d9Cm5qfcOUHJNdW5Stctf+QTmj0E/tCq5SM9C6MMWhVvkY79tEjBhqwNfsAq6FuUzm7UhB/7f+01PFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtLqqnptyC3oWZAAzvBWIKCA3utYT4OwzRRg7n8+7QE=;
 b=JAkNEr4549SOxQU8Vwj2ZQ692djs7n7eBssHBnpaHG+uXlbfpWvlMwFV8vrHHrJtszrnDmTcdnHegzuOOvaqaN0nofn1atZ48COqgzl76WV4EQWG+4Qz1g4Xv6g1igORZhdlNoBLtBCpEA0o+B5L69PRG2V7/Sc/J1Au6WEw/cz7a4edZPsY3SnMz3Ren8OxU45jtyqHg0RhY1Cmm/0yw+PWo4pLdQ6uUxHbLy4Okt3NrKY/VfWdJQKqv5cQYGyBi+wn9XB3qlvZJDBPHjKyJSQ1l5i7cZFvPafEhuC8LT7cc0YNmAinMvFKHRBMe0KZdTRVBlv+6G8ukTNFOrN5BQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 08:40:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:40:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: allow disable coalescing
Thread-Topic: [PATCH] net: fec: allow disable coalescing
Thread-Index: AQHb5dxtqoQxXCJYzUKpoDrfk2u4yLQUtvEwgABhWYCAAAYTgIAAANpQ
Date: Thu, 26 Jun 2025 08:40:36 +0000
Message-ID:
 <PAXPR04MB8510411D7846F1028CDE9C2D887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
 <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <d60808b3-eb20-40ab-b952-d9cd8d8d68a7@lunn.ch>
 <f2647407-3de0-4afd-bc79-5b58e13f10aa@pengutronix.de>
In-Reply-To: <f2647407-3de0-4afd-bc79-5b58e13f10aa@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9838:EE_
x-ms-office365-filtering-correlation-id: 4fb11055-8d84-49dd-aea3-08ddb48d1f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?g41s526TsjBK6nYwt3dTUUCazoS1fLBtCK+1fX5GtpRK9QzZHy8VarTOZWlD?=
 =?us-ascii?Q?hXXQU6QwMClvIa9NjG1DfBvMh80q0vOKf9UCIzDIngI3lOtouYTSlzwyM9J+?=
 =?us-ascii?Q?FZky71E5iDet86Yvsj8ADTq1d9dUS5cx9mZhuASZR9gI0Uz/DFtWx1sI+SsM?=
 =?us-ascii?Q?2YbVTKGid88ufgmObc3q1rqvR5jN1dP2WcU5uQjR1l4ogVCFnWF0CeZesdTS?=
 =?us-ascii?Q?UUhBhE8WzYD2GZN9V2qLE1Fm1IrNENgWccDPeM+xH0LFynBn6s2kC5DW1PsG?=
 =?us-ascii?Q?aC9O+nPSxgk3qkJA8mYzW6sArYj86m+ZcFYMXwhbjfiBcVXDG4odWh3d4Ft7?=
 =?us-ascii?Q?v6CHgArFm1QFqAIupCHG7Iz0WjowfdHz4NvJNJwV6J7bfSdmDG1ba+p7dK8v?=
 =?us-ascii?Q?oWG7k+cPNfKuRl8W5qKYzUwBEpag2S287cT1wA5Sp4/JqyF2Xxaq0H3emoRk?=
 =?us-ascii?Q?ybg4LbQ+lJ/yIguSPd5ntKHIFNVnlV1rqtBFT8A0HJPeS+z46Mk5zYm/ObDR?=
 =?us-ascii?Q?4pZRZXRG6zechz/BCtoarn1cZF+jl5gK4Q36T/Ot/txRKs8hn+uDM0r6Yfcv?=
 =?us-ascii?Q?QUi3XCDys+3QVbw72yyQs/Dtk9yGgy4AQnDFDGwFoIljI2s/1JtWrWGX30CF?=
 =?us-ascii?Q?1hlxe1cNiIn8MBj5XhFE5RbEQ13uOAJoG6FTp6YX6VDVKyRzaTv5AtDTHDXH?=
 =?us-ascii?Q?lXWylgZQ0nTMPJ+nC/rQ5USvsDrReUetY/O0ALeWEaR4nQj0LfXgLsmKLid8?=
 =?us-ascii?Q?PYt3r6ixUHqZmoQQtJjwTKWKKISgsq7EP0HMTyemkTYbHEbI/bC3NNI/UZMp?=
 =?us-ascii?Q?OUPAfzQp9CB6InEpTKMF3ZmLXHkTc+F6bagRX6bjDlTI1VjBBcMlGHNzuKoM?=
 =?us-ascii?Q?DY6JNfcOveVINlPGr7fHvZFA4l5q4096CH7MwVeoJCzZQkyiz+DSdm9ELZoS?=
 =?us-ascii?Q?CIgAAjcP4OoPo+0pEor8gI5p0BOwMDQtT48Z8/tPN5PdrlVrvy3A7YpELwrG?=
 =?us-ascii?Q?Q5BXPedN/sBGqwj2mrWVrs1DhG9mn3OccbhuP4DXJ8jQDucW39AGM3bZjXMv?=
 =?us-ascii?Q?rcPmZcsSzx4q2LlN4+zhg1NNWynfesls2dEq2sTXcAwvoWJLqP8T07C8ylvt?=
 =?us-ascii?Q?j0VG1KySYFLe/07rLWkPb9ydu8nbCTUznqLARVBPmiG27yXF4Q194T18C9d7?=
 =?us-ascii?Q?jDfc8MBRN4M3U5MUqlmMHUvUaP/0RS0w36lqFbXIGA4HFeRi5i4Su2nV3bO2?=
 =?us-ascii?Q?7gxH+/p3Y1izq6ViDHagA7rQ+G9NfOp1YEoMPXyRKPRYW8WNPDf9xT9NOcqs?=
 =?us-ascii?Q?UhL3TbvPk2kK+HcF5V7oSfBvSz2eLez1VMGGL+4faHsSMDAqFHzTPur+f7mG?=
 =?us-ascii?Q?gamin/bm0WykeOhSD4PBMMbJyLGO7aC6QUZIkYewFBMu04M5mwVsdtAhjvK3?=
 =?us-ascii?Q?JB8wRN5VFqSh9EZGhnP7Nfc1CWX/to8bkg00N+r/8dBbfcZYdkWWAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3a6an+r+S0UqQK3VeNPIOcn+j7rWcOKdeUeujvPJNYUOwcV1mC9IPJCUnwQY?=
 =?us-ascii?Q?YnAnxsHklROYfT/KSZu0fD/kwUysFdMfH7sxBM2dhiqTZSlBA+TnnLotz0Dd?=
 =?us-ascii?Q?J53B3ESSKdeButgzw3Y4mbM7GghBUyrfmHdEvUVZC0WvW1RkBN2xTwHDeYmD?=
 =?us-ascii?Q?ysOjsRaWUtOUy4aU5LlU30Fu38aTJYZOCXGjbmgtltfGZM+WIEudzYcPhZyo?=
 =?us-ascii?Q?mVfQlpy/CdOPKSTSzTUP1Jrqy8Nd7mFAYoQrJ6CKwgPChxe98xQIHGP18mIY?=
 =?us-ascii?Q?iVUoYMKj3qmP8pOwnuK7wv51hhpMt+wXK6R5qe2Sa5ok4JkOETaj5lNEDBNn?=
 =?us-ascii?Q?QOOkF6n6RnxFxyzBXuWql7cIeEUgSxPx3DtkDmwhPqAv3FQmzsNZwii11dT1?=
 =?us-ascii?Q?EevFF962Jwrqe9TXa0uRP5q/R4v8WALRJ4xXGC1VB+mlBkQJdNmVZedaFBQi?=
 =?us-ascii?Q?HLcFbf/iq9utguyN3lwOgTPTtPY+kIpwr1QDjeC4XoNjk2BgLnWTQbwFzk1x?=
 =?us-ascii?Q?2EoIFdpHWuttGEz3c5GdR0ENJiPtJCfH0+1YmpQb0naGeaJJBMjrT5R2iU6e?=
 =?us-ascii?Q?8F+qaa8iazxpjHvjVBS3rA9nQv14S3AIsMKrp7Ghb21OJKUHw3JmxyN9XT1D?=
 =?us-ascii?Q?txMYHdQYwcRIrh/yrlT1nDH3KqWapcnPLpTs+jN6AebwqALZwOQTCiB/qm3j?=
 =?us-ascii?Q?JQ/r0NFjadkKEoGKZPU0a612/Z6avcJy0CCOZH/NyrKBIc5mdOsKt5zzO5Sw?=
 =?us-ascii?Q?2/L/Mn1FJb9YpPmwDk72TJ1spr2/54k3O9lgp9R84nbyUHrkDynp9VbEkdJN?=
 =?us-ascii?Q?+ZSfa4XmCdBYmgfl6kqIEphjRWhHOTF0N6PPhbQ7iYjHX7Jgqcz3O1ucURR3?=
 =?us-ascii?Q?lgFszPG7YYEE/Ms+tiXcaNive3GdPciOoMKjUuwB/PwNA+LmEup5wVjBeGFE?=
 =?us-ascii?Q?QwTGNVCa90UuVkeEYPhruZivivVrfbQxI77BkIcmjhJ+QC5bnscm9XfSS/aZ?=
 =?us-ascii?Q?dcyUVNyVLQM+Jpm2fLy3vEHJS4o0/ukgIeE6TBVwCp97OJvcZP+lPqgNZuhE?=
 =?us-ascii?Q?QwEPSh3jDcjyIGL8StnXzAWf4h/kMWbQSLmFxaeMrM0QvBHynBu5lvHJoPRU?=
 =?us-ascii?Q?ZfkjSTkrbPi9oLOU+z2JhIqNoNwzpRNBbA2WsSdQ0o8YXs4ueItKlNHNBk+Y?=
 =?us-ascii?Q?WpYqt4ZYtMd2Coy8zMNMlOw5GEut8Ru6ShntdERtzj29fNGwFC5FXhzqLFVj?=
 =?us-ascii?Q?IjXSdMHeS+7i7cyF327W8DxEv7lN33uhqcUEPkxdvUYm0UuFJcY2dW+ZPpAE?=
 =?us-ascii?Q?xSS+T2CKDPBd7M3Aj5MNGm0HGcu1SkDw1QHOUYQ8oo/yJFQRxo637ObDyPG+?=
 =?us-ascii?Q?LG4B/l1Ot0oFUCfPlX6XHkiqk0bopXHWDGEcsLN4K8dui/cYdIZi4WYUI75m?=
 =?us-ascii?Q?wHhuAMRLniOf/6kFbRtnj2g+cHV70WT9VvatkRDWbHleOb0Y6RgTG0Bh7KaA?=
 =?us-ascii?Q?GCQZ0U09A3ZDBn7yQvX4869eBMpH9LHG33rNQe/3NP40p7uPnBwApXDrpBS8?=
 =?us-ascii?Q?UyyDJZlfOFKJLLxzB/g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb11055-8d84-49dd-aea3-08ddb48d1f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:40:36.3943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CeoDlKleREv/VsqHPPztt8Ty/jWZC2L/oLC9XoGpnBkBDEMkay8cTck/udZOK/jlAwcTgjLoLMrWYkG8jqycJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

> On 2025-06-26 10:12, Andrew Lunn wrote:
> > On Thu, Jun 26, 2025 at 02:36:37AM +0000, Wei Fang wrote:
> >>>
> >>> -       /* Must be greater than zero to avoid unpredictable behavior =
*/
> >>> -       if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
> >>> -           !fep->tx_time_itr || !fep->tx_pkts_itr)
> >>> -               return;
> >
> > Hi Wei
> >
> > When i see a comment like this being removed, i wounder if there is
> > any danger of side effects? Do you know what is being done here is
> > actually safe, for all the different versions of the FEC which support
> > coalescence?
>=20
> For reference, this comment is taken in plain from section 11.6.4.1.16.3
> in the i.MX 8M Plus Applications Processor Reference Manual (and is the
> same for the 6UL).
>=20
> I was also worried about this so I made sure that in any case where
> either of those is zero, the coalescing enable bit (FEC_ITR_EN) is
> explicitly disabled.
>=20
> fec_enet_itr_coal_set is only ever called if FEC_QUIRK_HAS_COALESCE is
> set and for those models, we expect disabling coalescing via FEC_ITR_EN
> -- and consequently also setting the parameters to zero -- to be
> unproblematic. This is also the reset default.
>=20

Yes, ICFT and ICTT cannot be set to zero when FEC_ITR_EN is set. But it is
safe to 0 when FEC_ITR_EN is not set.


