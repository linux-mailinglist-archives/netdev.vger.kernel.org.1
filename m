Return-Path: <netdev+bounces-208077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA1FB099A6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB450A46A66
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D8191F89;
	Fri, 18 Jul 2025 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fpR1hdKW"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF27433AD;
	Fri, 18 Jul 2025 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804513; cv=fail; b=YAzs4T36VP7l3oIge2AyvTerPXjjFFH7Cl3TSxyIKbTr/jeqElT2FDzZdQNscY+83Fqx0b0gtPIpWqcyW6lZwlm0lplyns6Hiv9nzjcEfN//dq34YMPr/I8u0mBxx7iVCZXGBEUWseDBTmt7iKHabgsPXlSyChJuWdHR8p7lN5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804513; c=relaxed/simple;
	bh=Edm9bI1whk3oz5OOtGDlHd98W/ibPAYr//D7T6fk40A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTZfNsbagF4G8rOsbBCkXSTcanXafGqLE+9ZPRkWoBGDqCefIYp7pHql9D0IuNuqW0kt4HrA7qmBAnupqSVmx7rapKySoOOm/WA+kcEqy0XkiksUvPXsYJLEwwN4YpOXeDRyD/YR/Y74q7BSpw1uoZKZxVhq24z77Hge7JMKBcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fpR1hdKW; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPGr/clbEHLb/Z7Ne6H0uXaWG3taO/+jq6fytuKXHukNfQaoCfDKXIWJcFtp+S/ik2+0/UV851nzySCUDQYHRVeP7UTvKjORHl5cDr4rZvr5Uytgf4sOfQctUc4UxNnQISfxCpLpdg0myQxqoDp25nN69d3wsNE5D0MCwWek3yx3avGWT8FdSWhYe7+mr7UYJ7+7TsUJi6XX54MO/ME62zkmd5XmSj8lYYlMFXn/gvDk8iTGP91DWDL8avSOyzJxR67RNNrA0ckS0xWkWIB1qS+4RQZ+ysralSwbrQOquEy7SkrMoOTREA43+lSu4eYb2cvKC8e8jsTq15JlyjwekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdpsP6DZA9PxNngcPrt9s9/o9ORw8ZsTw3hnoQ43BW8=;
 b=fddDWlfCD3wxXXf+FnYofzkUta6n7x+64/6q6j2PSiA7TM/z4M2pGBnPngXekTxrqDclKRDEx+g/oz7GPMOSY9Yp7CtbXQViqu9AMqSyeMO2CnVkUw4vFaMT+CQe+A0SgFjatA6+9Ik0qLw+WfZcVNLezxVGkcZzm0AkvnJLiBSHChX9eJFY3LgzpYJ1zFXXvdsdbh6MJ5d1xmI5CB6yBYpxtFnbUCfzg82jBbDznTv845VMBzIu8laobBdSREulvNxf6xd6iEnSFxR+7rX4XlOyar3vNq1wIFHwbnRDS6NyJ92geqFinK9b4NfQX6Z+68PR4L35JenAQctC3xtWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdpsP6DZA9PxNngcPrt9s9/o9ORw8ZsTw3hnoQ43BW8=;
 b=fpR1hdKWbMiDSZNsd/71/LvWzfP3OAv2khNiL5xkSOhuBixBkM4486BbB40hWl0qF9K74R75R/C1URoiY32T3o9d9WKl8JSDT+1q2PMcX/smBUuk/oGxyRfTVsBUvEbZHH5sNl+oCnqe65OvbJxmZpWSslal4VIWHCGNhFRcY9ZzxkJMpgyEZk4Dxj4yfXEsSyG2NQjDym/khCmk3F5ka+7mudCb+fUT+Kt3S/bbv+pprHE78PtKl01Pu8VGWvZ3ecQErQE5FzEAX+yBoj1GFOTwe77xpHjUpEdi5yU5smgRLkodkfoE0Xqqar+Yvu3i+CcykGPlkukhWoTN2WaiVA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 02:08:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Fri, 18 Jul 2025
 02:08:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Topic: [PATCH v2 net-next 04/14] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Index: AQHb9iZuKYxtnoJNJkq/rP1bHUAsm7Q1LcuAgAEJczCAADe3gIAAtl2A
Date: Fri, 18 Jul 2025 02:08:28 +0000
Message-ID:
 <PAXPR04MB85104B281581D95FDAFE59D98850A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-5-wei.fang@nxp.com>
 <aHgGJ6sia5Xe7AA9@lizhi-Precision-Tower-5810>
 <PAXPR04MB85101A40D9D866083BA88E6B8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aHkTkdFaYd8IOkpG@lizhi-Precision-Tower-5810>
In-Reply-To: <aHkTkdFaYd8IOkpG@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9742:EE_
x-ms-office365-filtering-correlation-id: b1d2402b-3503-4699-6aeb-08ddc59ffca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hW6G4ilFK61HyKO4+0H+RvuHG/FEwmRTkI2cmHVF3TCYwaOPz7KljPIVzCmg?=
 =?us-ascii?Q?ymije7S6jaeF9S363glzmfRsgxmdLj2+vJIAg8TQ3TmzLRPvwt/c9dWNv2RC?=
 =?us-ascii?Q?Fdd9hm6fWma054tU2CpRyJr9p31S8h5KJPd7VOP40J80rgTRoCit+PVu1uNK?=
 =?us-ascii?Q?9LdRFQkPAI9U0/w1WT4Ax3AdYoo9Iqb8RU3mUp62rtLjF0x1zCGYd2eqvD6T?=
 =?us-ascii?Q?hrHcy8Yc9vNnMrDwLX3pcTUhOfibvbKBipLxBkqas1tV8y2JyzTchFcjr5r+?=
 =?us-ascii?Q?l3sVhTRPoZfprLyfD7zsiBCXJgPSjI9eTzP+zFTAGbG845m7k/EUxC9G86U3?=
 =?us-ascii?Q?LnMYy6r3qmKzOON4tXTRRJGNis9IhUYcOkPQWzWBR7kj+E9p98M6Z9qY0qm3?=
 =?us-ascii?Q?9qVPbB2xPNo+KxRHoUtOKnAkbnIyTBRSEJTSjcsOaf3uRrYhTU/FF7n4HJCJ?=
 =?us-ascii?Q?MS+7owvRvyK/fbJgHycsVM4gwHB8g7OmrljNgqZHgE5lakp0B22MCy/9lt6h?=
 =?us-ascii?Q?Xfa6T0CRSCerrct+FiwwCAsGJux1K5/UoP9LhrvzNiMxRyHKCX9nZt8sCsX8?=
 =?us-ascii?Q?K+yXmhY3w3CQTZYeEvdIppey9d1N6igiuWRYVEZBcL0y+/9kfCAUGVLFoP7J?=
 =?us-ascii?Q?MVWczYS7SEreoM3RVt3WPaeofJ0SbavPJLJuoRj7D3rYxKgnCoOQr1tU3PTJ?=
 =?us-ascii?Q?teHP5PriEUXUh9zFJpPkyHIKXcWZeySFIrt3Y00Q5sQPpMI4ZnOP8r3zWS2Z?=
 =?us-ascii?Q?ef5FFvTJGxGnGUpy87M+4ZQJ+x88U7iL8whEuN8xebP7YDUv5zMEjIGJjVPu?=
 =?us-ascii?Q?Xn9cEjFSPufYdeQ+ZAsA/4SK5d/YyEFcsWT0ZN7iIyz3Ib8tVIEMUqYzh0xi?=
 =?us-ascii?Q?tNPfPpvo6rBJfLD8oG3ebGuoXqMRZxGdaVdMFX7F2NUMsAo2xalJuo7Uxuy3?=
 =?us-ascii?Q?n5SBRUmi3w0+S6dSeVNY9+KnxRVE/V+Hxo+BgZyTkr8TIpLEN8P6g3npTr6W?=
 =?us-ascii?Q?5H+jD4JsNBkj6i4CUFzcYNlR29OEjKJxQgMCtHtAxYGslcXSt7BP521cnzXS?=
 =?us-ascii?Q?+D5RUA9Y1nZX7gQwA6bIVH7tIFTj3uxQmB22xUjSD2AhRW1eVPX5BvQoIGeV?=
 =?us-ascii?Q?xS7rjGGlzgZ7KiNPwABhsY9EXXF81NwGSFwQO7att33UbLGqONSLk7/I3OoU?=
 =?us-ascii?Q?zsoUX2W1jOjNwRbc7z7wBd05URpuDv0+N0Zl3B4k+EsX3dlDDJ8Nbg1Un9Mn?=
 =?us-ascii?Q?d/8AKmPwPbvIv39kmyEX3Yu0DrCNYq3Y49HEOZW/hvNWYfJ1heHZwYGJaaAz?=
 =?us-ascii?Q?go1tdv9ziwicEYP0NmuH9W6gyBAVke8GHzTmFJ0n0/9M+7xqIkafPBs2ytt+?=
 =?us-ascii?Q?OJjUJE8bA8tn+9vfgJSJnZLxUQt01uIHZUsbbb6ypzyKDZaEclifn5/CyFZK?=
 =?us-ascii?Q?k0WmJ2xslgGT/1zeVkfiC1W1RibqgyC6bZUAkBMqLX+F+uNdmELR2g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xmcQCbRCDNoqIVQ2bK0az4om/mDrAa8qDrC+Ol8vPrs55TbZfRXG2Sbq7pC1?=
 =?us-ascii?Q?mSiAMYu+Hvzlj+5Xe9D5GYhmkBXP4PXtKhT/HmsJIlRXbu0a0zqMbpLHQF5G?=
 =?us-ascii?Q?tkqx0sy51xGGP6RTZ/QwbXSRoKkhOCn/grPTjPa7ZGnkrWqlyB3gfQofWgHI?=
 =?us-ascii?Q?McPaVBzPfCtmgJMxkiKNZP57A9Mrow1t2anZgP7BJtBYiNfgoATZVpQC7VWj?=
 =?us-ascii?Q?rRgMzWJ1Mu34dUFQ/yw6qr+nRRHXtndDn2DX3tPvNoWz8kB+/ew9FJr4CPtF?=
 =?us-ascii?Q?qt8xzJcMp4mw5V+lTKFEv+MVDbzEgP7Bwdd2MOiAjqQbtSXC2K5B4IAu0yxS?=
 =?us-ascii?Q?Sf7qDyopB8XRuv06f+WtLSK0lzcgYxZJhKMk80wq5Q+aK+Xx7efyYjXdG3P+?=
 =?us-ascii?Q?/dl5UUaGCbSvuw0WrAXZckb/M4+JNNZJYPsky1TldLbwEDaLEOXX0E1tWUb8?=
 =?us-ascii?Q?cQQ9Y3XPhHqL/TE803rW+qXUkQd8l6NILrgFP7538HEeSsc79q/rH3Tb7LrE?=
 =?us-ascii?Q?Q0DfS22OIWpo8+Q4PZ37sshFnIgEkfGs6Y2eojLg4gTkiD7xpci94XC6ptxi?=
 =?us-ascii?Q?VP3YZJSxV5qZ+/SW+VUhcrqdUdyod1ktTdKC/E1JQMZ8EbMU4Us49RgYN2BK?=
 =?us-ascii?Q?xXZjVdjKTsbzDqCtiyYjDBb8sfCJltgbMXLc6oCWkWKzD9KSWbNcDDIGD8v/?=
 =?us-ascii?Q?u3zF2/VFtUkTvlbNFM9knsISeQ5pX6ii0vEbEFjHx6PhexTcvFK4EouLrOpv?=
 =?us-ascii?Q?OrpHYRGF8D/qN3/ivjdOV4HVQxCx4kEVFoNlJgtje4DvxJnv+AhMEog0Orl+?=
 =?us-ascii?Q?Humx01BEZkuEvHoEYHnB1TIW4x/qVrI6qsSJRk4a1Jt7YzWPtP0HzQMY8VlH?=
 =?us-ascii?Q?hhHSPXvNTbkXEsAHImRLN0nJQSQ6f44VYwSoMXLMUHHOcu9CGeAq2lsTl9P8?=
 =?us-ascii?Q?K3G1SfR3c4Sfhw5HtKCn8E+C5iFVpIWHPI3qje4O9CMyRSu9lV6FB3RUj6+/?=
 =?us-ascii?Q?Q/drpXAloEESnBoyFbLDUrnZEKng2uKSUtm0E92/Ms54MtRFikOWKzst8clN?=
 =?us-ascii?Q?z1OYPkjtcP7NQ5y/Csp4DYX1HucY07Pd8EMm1/pltkv/gjGQcLiBCktK652k?=
 =?us-ascii?Q?83EArFBtUi8sIB3B6oxwxX6As7ukXr+a8bs7IC+TQhwjhQW3bzDVyGU65o+a?=
 =?us-ascii?Q?52jISJaMzLT7X6gLDY5SDPd+PibhiSe08pAgn+M4OoHUwgFo2dZzkzd4cM37?=
 =?us-ascii?Q?k14+45CBLcWsLMgqzJfKBPZ9FvLCnkKQUjqorlmnYoocSfawixlVR2ynVQm8?=
 =?us-ascii?Q?PWWuiGKaAFTWuA97WtsR8xpjYUB54qiCcyQQFULMe3g8NQYM1vcnYqUoQVsk?=
 =?us-ascii?Q?w/3Lx5o+BHOcEydDFIJcRML079+KYbrnSZlq4t3qbqq3oiR6IS5tg+rh2/LK?=
 =?us-ascii?Q?FlVGXlVwB9lqwZWo0fKPsKQBDPdQxZxhgR3hBCsyBXMKEXiTBN7CDHjiYCkG?=
 =?us-ascii?Q?x4IRWyRzMsXxjSaeiGpQZ8QZS1Zw/ln/7/XfCrbxCQguWaKomkmUUlHnQoQs?=
 =?us-ascii?Q?COTOzoINueDmzdKVcNY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d2402b-3503-4699-6aeb-08ddc59ffca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 02:08:28.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RenkYtEagz/G/R+e4LuM5J7aTXqzkN5CVWa0ZjKXbNByG0ES34z8LUQx3M5i71q0a7iRFubxK50QK4AX3RufXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742

> On Thu, Jul 17, 2025 at 11:59:30AM +0000, Wei Fang wrote:
> > > > +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> > > > +					 u32 fiper)
> > > > +{
> > > > +	u64 divisor, pulse_width;
> > > > +
> > > > +	/* Set the FIPER pulse width to half FIPER interval by default.
> > > > +	 * pulse_width =3D (fiper / 2) / TMR_GCLK_period,
> > > > +	 * TMR_GCLK_period =3D NSEC_PER_SEC / TMR_GCLK_freq,
> > > > +	 * TMR_GCLK_freq =3D (clk_freq / oclk_prsc) Hz,
> > > > +	 * so pulse_width =3D fiper * clk_freq / (2 * NSEC_PER_SEC * oclk=
_prsc).
> > > > +	 */
> > > > +	divisor =3D mul_u32_u32(2000000000U, priv->oclk_prsc);
> > >
> > > is it 2*PSEC_PER_SEC ?
> > >
> >
> > No, it is 2 * NSEC_PER_SEC, NSEC_PER_SEC is 1000000000.
>=20
> Use 2 * NSEC_PER_SEC, instead of hardcode number.
>=20
Sure, thanks.


