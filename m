Return-Path: <netdev+bounces-233710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2466C177EB
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B57406BA6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB041FDE39;
	Wed, 29 Oct 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFtQkGyk"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3F6A8D2;
	Wed, 29 Oct 2025 00:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696900; cv=fail; b=RknYgOcrvxT345Jl1DDzGnMkazHAHwB9X4PSBButHue5uL0OveR5Ia+RkMVPDsxPecSLpXmBlGG/ZLudEstH8swvRCq2hk0uoKyoqo1g1KHYsFON+QO8BnpzERGvIRtS9DjrWYrNj5alXmWJtodcq1YdchDVsYXFuqeCYsZHGMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696900; c=relaxed/simple;
	bh=7qrn0Jh72M6pocfRy7vsPaBGfbEPP9ua6fuHVfG4jJU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qH/d6CVFG4ZtAOciLqJ3D0hYFdT0Focu5XqoPxni6DoHHsNMCETTGOuxjx6Aq7uYAshOw38+FhAAJL0la7CZFJ3c2IZF0Xph5c4SGBu6K2xHcpscBJ+mWgaqgsviRKA8qC3DQn/dRKUvqmKBDuiwo/ENOtcyxo15ZhbIHGZ0RXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFtQkGyk; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNCkRMPPN95WXM9Sg7JhvQPKgBD16WeYPvMYxOEW9WPW+vVXlcsPdgsW20JMGhKjoZJnRFnkMuFODaIC9hx73Yr2lGhV9uybUffhrN6c46jkOkP919EvwAxT90R9xbTAtHdulF+2IVg3VutUmqxRxFdGhEb4nsDjTfWK874wZGR05Xtm326GhwSP1eoo/BHeVUu5rihpq2jtpld61Ztq1To3TyHy0BERJP3bbcfhcCC1a3qfbFu7e5D1NOSitjz8yvpjFmkhA33Hy5SN5PBxT7LV0E7wqTXKKKQ7JoegNqthU6OaO0e9JRfUiMQ3kIi2DSm6K/b6TBZPiYNN7OgRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoIt8DekyvzFVzT2XIhDpZugd1sSAIj4pNWRm16FVOQ=;
 b=nM8IwK1c+ifWHzPQ0D9gp2huQukNSbAD4guwmJ+0RB9Zasw3LijQ7sGw2XkyB/shPG/pskdKruMnPG0tsidIt2fDje+ZiMddtZRqgpVMEKtZ1KQH/D3YrUZ+WqCGReWb/fRNdORjU6zrhPCubaz8XL1q8GUnRITvq6PuiR1I+AzuPebFCkQqBPJQR/L9x5oNK13WbWZoek1zsuWS3wcEHDa8oKhz8ty7YSeiWy/ImTMZ2c6agEJFPxEMOr8v1x09+/z8Cd4fOtRQ5XDIjKEjqENayWL1nFOMeiFkmcm+9j65J7yE6j3rQcplxnckxsp3Hs6ANqISpnSVVtGodoroDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoIt8DekyvzFVzT2XIhDpZugd1sSAIj4pNWRm16FVOQ=;
 b=MFtQkGyk0tNPyvs6RI0gtvTADiol4F6VvqK/VznFkee5XjtebqHjSMUcerA0dnAcZdgNxWkkxleYVR63mgi+xOUB+dHzU21tiPozSsOLeFrriNQh9hw8W5YkQhbCI0diEwDoTL3Dzqah6mczQs4o/+ZNhUHDRrDTInSDc8GJYXXo6kYXZMnA2i4m7UVCJDQTTf/P1XDHOuFURgVuS5kh6B9X3eFpDV/7PnDhv1uoWsBwTnxlDinp0Von7EAmmhEYj7TmcmpbVwTJSDENrwM8TMprZYe8CWMZLkp4/EztVcY1erlGlxPw483vykToHHxNF2Oms86FU1xwxPAOnmbR3g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 00:14:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 00:14:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 4/6] net: enetc: add ptp timer binding support
 for i.MX94
Thread-Topic: [PATCH v3 net-next 4/6] net: enetc: add ptp timer binding
 support for i.MX94
Thread-Index: AQHcRuaAff04YxrdH0ijyGQt+K0eMrTYPziAgAAE5VA=
Date: Wed, 29 Oct 2025 00:14:54 +0000
Message-ID:
 <PAXPR04MB8510AFAAFFF2161F1552EF7688FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
	<20251027014503.176237-5-wei.fang@nxp.com>
 <20251028165643.7ae07efd@kernel.org>
In-Reply-To: <20251028165643.7ae07efd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9962:EE_
x-ms-office365-filtering-correlation-id: 75dc2837-d2b8-421b-9f54-08de16802f85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MRcVomNJmFkl/OUyqw63Yh4f7CkBCeRDoAMlZzI2T6rfSM+zMu4OPU4hNcM+?=
 =?us-ascii?Q?GHJKrgRts2cmkdIAv8WfSeNzAdSjn8AlKflg632FLmuXAnD9ttaGGIdGnUJI?=
 =?us-ascii?Q?Kmd+rux8hSJ1Qtu33Wn93NYajQfKOhkl2ubVUK5vgvNBYTmPd8UD4VHmSiWA?=
 =?us-ascii?Q?zLNGreKDWVb4FEYw6basolsydLqYb8F094wuTMGDnHCGk1yee3gonlptQA/F?=
 =?us-ascii?Q?oZL3UZN9GfCZyMdcfoSrSlyvl1ZOcZ6QgoNdPNhsjR+Ah0pajY9I9nTM6E03?=
 =?us-ascii?Q?dB5ck/ZQ8cJCiZyWLYYtr+7UvNzGBtKpYxke2P3V9ygMdrUmdpLbu8EbRqi6?=
 =?us-ascii?Q?3pHxTqj2k+4VdZZrRTBWWAKG2KbicOjGikpUMz71751jtl4D9n16H311q1yt?=
 =?us-ascii?Q?y1ERY99rD88RP4wRlL0pbCzAHxQ1vbmkzN2pOZD1Qt+meM4fCBHPUAyh6ihW?=
 =?us-ascii?Q?l8cEODICmZW7HxtPyfM35T/ZEyPbnVGgX68DyDnyvw29t2zn9spXnw0PRUBE?=
 =?us-ascii?Q?+TSo7UVF/TXZSujA15yLRFtQFOO3Vss//pr/PvaxOWtpRGXGtSR0qkMBTD2l?=
 =?us-ascii?Q?xjw6qQYfrRL3EbXkACumQQtHz+h1eb7uVpl85xWuFsSRUn0girgktOa+GDiR?=
 =?us-ascii?Q?S9NVZFsuokKNc+pYOazXvrCO5xHlSaBqepH/QdGDwx14teop84RbpVLW0KHq?=
 =?us-ascii?Q?qM7XNya2goREBOm0qiiN9yuTacVLv2K7ykQd1AnoD0jtBJNhEHCzVOL4G0wa?=
 =?us-ascii?Q?xflRvaBOWSUChxXb+H5WtxeECQB4f7t5DCjTB22iBLKNUZguFE5mfDWjwxa+?=
 =?us-ascii?Q?a3GAg+VlMVIxZpukYNg/RZ4rpvrcSp02v5b7yzvKJ6y0FTKF++KgcclaSLqr?=
 =?us-ascii?Q?efYhq0/2hk79RUzzRBzssJzm4UF4MdN8nKdpGj8yLbmK5VEC3MgvEx5KpUbJ?=
 =?us-ascii?Q?x3ssWasZRILSKE9UYWhVu1vCS14V+e2/qmfn49uUU2L+bkqpg7QZf3jG5CIA?=
 =?us-ascii?Q?cxxAcrP3FZaPrP6lpC+h9xqr1ATWghW1wRXU5nVsukYMw/mN3UYmWzicmxop?=
 =?us-ascii?Q?/0aLyBYviDVRpZI1hr4M5X9mtkFwOaJjvDTtw/jlKz/TnIvjsb6sbKOZdW56?=
 =?us-ascii?Q?+WdeTrQkXoWf3FO8SBO0NSAlgBWwrgxV5/rrLKowgm+Tz6XCNtGfCwjErx2J?=
 =?us-ascii?Q?x1kqXEXCsmde/89JekmJF/czBEWbBY41zt5n1ko6/lWe2lmK4HPx3/CrXv9j?=
 =?us-ascii?Q?W27KfYCaHvYMCAkCZsRaV2DtdDoy8eCz0d+rywx/zMtHvOzAq3LvNQFmj3Im?=
 =?us-ascii?Q?zpIS5hItbo0Q3uHyVEuPhd2iU9IDcLf4iZPKqA5xjF6wIARpOOD6jX7Hu17i?=
 =?us-ascii?Q?dpBAghjlf6JA3MrnJiurA5LxH9Vse8ydhdVK/LUc/3R59jKreQ87ZPdCaK7B?=
 =?us-ascii?Q?Ag+p8Pylttm7NbA4aalklNc5KTAaxM8/O1Wd1iP1PW/gWRWJZXITra1czRCb?=
 =?us-ascii?Q?ShV+U5Adelyt1kqmPr1dUR6Bha+cYic97bpY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dstmktIh9kL3PJ2moBhc3jNb2nY7SHld/zgvNrDBrXX4ourNF4wGtJlNvC0W?=
 =?us-ascii?Q?oSap4bhdtW3pLoWsRMXIkvvIPXOETpp84d/DL5rlAq46xV+JxsjSpexElj4S?=
 =?us-ascii?Q?IuhSrifTurFVY6WD9472+oUeEzHCW2wMB3azj7mpi8mVXdGnfIqcQout1I4N?=
 =?us-ascii?Q?k6g1GzFlU6HFJMnaJ/tl2ALB5kIt/V+o9SeyWPMWBsB3i3YPZPdVaZMOj1jN?=
 =?us-ascii?Q?gT6i02OjKexyqgfGZkkq/qReXSdYUEAiNBI4B71i/QIo7pp49IbZE44dLUJg?=
 =?us-ascii?Q?eFyL4psjrBmfhAvi7xuS49WffhY76aFf6hKqf1FP9DOBDxnunmV1tZVFBsXR?=
 =?us-ascii?Q?bfwAYlUpGB8HrKF+55NgPXwCw4QCdkbSlfbcVhXeiHVSTtQpsBcmDhkpvNn6?=
 =?us-ascii?Q?1FPOPMYUatzLLqaTG+Tj18e5oiSK63DLDBsrmzBDwgdN1bhJeXlwSQMw34rI?=
 =?us-ascii?Q?f2FBGwWPe0sg6DO6Qn2YcPCAt7qv3FUS1E6QRkSy6nTdmYf1yQbK7rfUy61n?=
 =?us-ascii?Q?X/JQ/mHnePbO9cT26Vn2kByJonb63oJadErAbZ4PXm74pISGxCDHkvhftlro?=
 =?us-ascii?Q?jOAO3jt+33NB6CZQbmV4k+5vSv+vcE1muaBl6uAVavsyxutKtflBRie3YVqk?=
 =?us-ascii?Q?V7oBFC+4aVzCbFMW2W3APdyr6d8IuX7nAyR0MxjGS2kXTOKBldVTfFIKtqeQ?=
 =?us-ascii?Q?pnOejAlGxt3sz3+hXiJIytgyyZJx18zRQAhtrC/S4sidav4GdO/hHj9l6daY?=
 =?us-ascii?Q?2N7hMS25K77iCVs5pxNOyP2mUclgN3eJ10j5DCFORrnV4qLX45pXCC3c36tU?=
 =?us-ascii?Q?0KTB1yKNzB08seD0zEbOL6EFzNEqDejdBd1D2dQWSJ6Bp6CRdHVjJqqu15f0?=
 =?us-ascii?Q?5+9S9lo4Z3ltuP5H8QoeEZzAs2r2BRnIN9ZQey0HYsj9zRqYvNsYriGFwPh6?=
 =?us-ascii?Q?snojZOMIIzi+Rf2IFOww3FWmj8aNi95P4fyhDg4laBWh69rKpvTumetsBhhE?=
 =?us-ascii?Q?WixW6C9xYf/iJ1HWg88ZLZUiiYl9cSWY2qdewwwuM84An36srbwytQSfhRSd?=
 =?us-ascii?Q?BMEdBAnmveYylGODb5GpWIm3uPUY0q5k947VQMcIsXmNOcLAo7SloirdbfgR?=
 =?us-ascii?Q?TxBxauyyTKXi8qIASA8tgcjJsekHmqLlGp6oIkI7eeEL3RfBeKWIRPHuYZjh?=
 =?us-ascii?Q?wk27Vq082g/ivBNmipibLbFitR9Pu6EKXMKnqpPcuwru7iA+7ffajN8jLIHg?=
 =?us-ascii?Q?h0L96xhVnr2kVp3XK0OedGkiU4w08IEFFU+AIWA4q0hli9WmN7a+7FSHiVkU?=
 =?us-ascii?Q?o9AolWzR7Yc9H+PM1xkiwXKTsLX1+RgwW4KkII5H0awiMxFw+YE348glyA12?=
 =?us-ascii?Q?DwyHLMIa5k9n0bW+k9yVBrBIfqGC+jtbraubsuMTwJ/BPxXxzwNNaJL2j6/W?=
 =?us-ascii?Q?t2uIztQX942lup4Vc35ajQaShFfSJJUT5DPOkX+2Wiof9oM7dUuL0efGWO7/?=
 =?us-ascii?Q?ZKzoTQnn0IgAjuEsKiBAb5KDVQ7eDMrW0kbol3jnLqapdhiYTWJados/GUSQ?=
 =?us-ascii?Q?4sphFUWe9VqpU4JTQo4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc2837-d2b8-421b-9f54-08de16802f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 00:14:54.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/ZZ+cV1fvyYkOCHVzLgVQNcFlUBxUprEKlq3N4unSMJ4kIEAvh5w/KMrXK+nhDM+FTWe7k6l1ud1NfA5QXbbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962

> On Mon, 27 Oct 2025 09:45:01 +0800 Wei Fang wrote:
> > +	struct device_node *timer_np __free(device_node) =3D NULL;
>=20
> Please go back to the code from v2.

Okay, thanks.


