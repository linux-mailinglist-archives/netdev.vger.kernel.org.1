Return-Path: <netdev+bounces-175246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4FA6489A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E3E3B002E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766A233726;
	Mon, 17 Mar 2025 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kq0Ifo9H"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D252221F33;
	Mon, 17 Mar 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205661; cv=fail; b=LSdfzjg8hmlc+H4pnbcw+8twBeCoXsVLEfhPl9MCPOb2didskVfB4fJYF4Pg05+DdAe+iNhzf+lKlOGE1Eg5kd1yNYcJY875jGa+tJCRYK0LLIcO8E5i5iHc4vHiAVtNyxlnjdNhApWG2avotiIxe5ToyQMORATKqGDQvBiLAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205661; c=relaxed/simple;
	bh=+mNHCjfb/DtDw4J4SakbzoCjCysgITVRQ/YBjTaifNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E96WXVehcxIx4XAXL/9O/GjI31SlabQ+jhOQ0uU5zEiOWqbQJTZARHWCkPZW7WfKoWNQaSZMFGSeq+vwrhq5Jach53g6497+5Vc/QuEMGLqlcDFYB/jsMzi/rllD3ZwJk0/zA3sXB/MS63FBI2Ib5G1Iehb1lhBkY34kJ3q3npc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kq0Ifo9H; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS5stbffiZy/5onXF2Ot205YgTNJtVXeE71qPqQUIR2zT1DwRuQCdBhI+qU8qGkSyLeLg2DmO16Vl/EVW97+N198Zg4twjMpi4i2mHKfM0L45TyRU7rtrv97uVFqm0qGi5uCjd/ySbd+0NMvMa8JMPFZBYoXF74S2KgTnEW7aSdMQIkMUMurmM2YV5IyjA8jGtVeAnRrTllXl+zDf2P8wvBV/255tA5zNEhqQOWLcy+RO8FO7nafY2MT6Rpf1BNr7dRY+dIoQGt1o2IBTtFrZiNvaKD/5laulWtsbrlXvugkEg5M5hopGpBNqGYBxVMlZ5HUrF+jpJSM3LzQesmHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mNHCjfb/DtDw4J4SakbzoCjCysgITVRQ/YBjTaifNk=;
 b=h9UpVyPvfyypV2AN/mg+TwqC9jzrLHPdUjxcnfcIo6x0Myf2AURvMWSaZ7b2NEcRb9GyfP9fjKZ/cXYZeZnTCg/urLEe7/U3fyz2+v1yXc5BztxVMYm6jTb40Lx+qF5PPN6aSZm/6FEKtCsf36jQdC0SiESGBUhU4PYN6D2mxU9zuU20RjCXCYWvbuv+Hp9qmBV33eL5gHoA7ZTC1/C2La8YoU7Ji9U1Vj4WSbW2iEfPL+mnAmyBoAkgWhoEl0YFZAJz00WyqEsauFcx4TbkCP6JLlDimUHRGFO7y3IcbBlcuZA/ptdJgAOzOwhlOzzIT6uyqqvXQz10+AjM274jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mNHCjfb/DtDw4J4SakbzoCjCysgITVRQ/YBjTaifNk=;
 b=kq0Ifo9Hqcc9q0h/2dE+3jkOJ5aKxCtYhwhm0bDLzcPCPv9zMnlwxOfzXfYqQj16iZhnNzMhKHDOVz7KWMvhCYATztF4yX+96Gz+Fi5aaS+Iq2/4d29+E5BVnhG72gDyccttPV+6QSfPvZ45DK3YdWj7zttfp2OliNgfHSWkQe2x2yixO4pSS57gIQG8iMskwhaiLx78crjyazh1mJJ9Q6GDO38NtnyCbynIufCHdZvs5X+2CfsWQX/tkxBbqTS2/SdAsTH5lDmxA62YsXPBU8wGuGHZNsLE0fJ27CqVsmIS242M3XUuOxZ4WCJxa8sKUHwxQJoIDHvc8uBin1bldw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7760.eurprd04.prod.outlook.com (2603:10a6:102:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:00:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:00:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 03/14] net: enetc: move generic MAC filterng
 interfaces to enetc-core
Thread-Topic: [PATCH v4 net-next 03/14] net: enetc: move generic MAC filterng
 interfaces to enetc-core
Thread-Index: AQHbkkpOrze484r8D0W5Y5Kfclxt2rN3HWEQgAAD5vA=
Date: Mon, 17 Mar 2025 10:00:56 +0000
Message-ID:
 <PAXPR04MB85106C0A4AB17B67A5A4982F88DF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-4-wei.fang@nxp.com>
 <20250311053830.1516523-4-wei.fang@nxp.com>
 <20250317094259.b6mwygvr75lxgkwh@skbuf>
In-Reply-To: <20250317094259.b6mwygvr75lxgkwh@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7760:EE_
x-ms-office365-filtering-correlation-id: fefc91fb-ee1d-4bc5-1e20-08dd653a9c83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lhPl9hBgydR9JJJHA6Nxzk/U0BsqHRoM6Cb/IibbySEvdbbJJPB6/uhrk9v+?=
 =?us-ascii?Q?l4Nc9DHI/BV4+LzXEzOTWiu8n1JMVXA+X4NwF4A1NApnwZUue6sgO+DZqr7N?=
 =?us-ascii?Q?Zlv00HKYqHi1O5jrsFjaB/8+kGZr26lBIUDshMC2EsMlWM/yqSgesr+BL/rS?=
 =?us-ascii?Q?T6F2iBlIGuqxB/MY1td+lkTktL9rINUUASWQq6claEAvzKlr92z0uv1A5fRK?=
 =?us-ascii?Q?tdLOmQNZLe15yl4k1dCpkBSd2fUIfwXJDFju/Ah1C0TbOVxAo3j6F71ViMHv?=
 =?us-ascii?Q?gJSOL2RCtHA35N9DAt0HnZ+H/m4j17cJqGREINQnI9GCpsUHI4mHx+0N+zGj?=
 =?us-ascii?Q?Wt7UKNWlP0ZrMAdYb5IFnuYALMpuavqPq4yKPivuhhQCH9loNtnfMJaCakOl?=
 =?us-ascii?Q?3yZ6ef8g4BDuhrIpHZIR/Go8a67uvugK9zX8SQFtDRayDGVcBcVWeGw+FLl3?=
 =?us-ascii?Q?e5wtOp/fzIymRSNOgLLYNFSxs+7Ihwt2YhxCYZbv4Bh7tTc8cbk0F9frgBha?=
 =?us-ascii?Q?ygsOnWxooTOhTVfKwD2GNPKnAnhk4DJTX/QZFDGbuLUY1B901p/gI2qsFZyH?=
 =?us-ascii?Q?N8XirvTIjMdVpuxq32a+qLSbClHFVL/1PWhfco8ri1xRw4yvY1/YQpqXwfiY?=
 =?us-ascii?Q?ts4PSXCZW4TDAU0R2JaPnkDFCij+uotvIZrMHSF2CZgrFyXNfEMKkm3BJZZ8?=
 =?us-ascii?Q?IizPm2p7WdGez1tkjEPWXLyXLqbVCfmspAPF84DSJSNeFV+/aWgSQO8JF4K6?=
 =?us-ascii?Q?92/AlNLZoW8NcdAXAdFchTsnvnTXTcpDvpiq7kSPUOc1mJl6lbrp1dk7b8jx?=
 =?us-ascii?Q?fxEy/yFw6PrVJdrJA9JlnOIH726Y3YMjldGOES2crLtpT0GakhxdGffC+n1y?=
 =?us-ascii?Q?F7UxxBKEg3dx7WZRPXum/t3n525usgvHG3ebKD4oMap44RlNnIEWgiOk9+lX?=
 =?us-ascii?Q?fupwS3PfI9gKlpwJFZr2Pj0nBjVyvxrjqw0z3vgwrVNwQO9zabupkvEjEuts?=
 =?us-ascii?Q?k3Ahb6zis5lhq+AaGltpxgHrmkJ8jrkbm2iaDHIhE+GSzchh2DpQMFoZ1GBt?=
 =?us-ascii?Q?VhB0oP/0quo4IATVyMMqORtesWDNgQfEO9YIcRpXwr9v49hU90YiH0X48HDm?=
 =?us-ascii?Q?ewHhLAFOvjcL61N+uoQKJG6ugdZAhT7V7m4QjqJmZPKHqV5JnWE/kRhwWAAl?=
 =?us-ascii?Q?XrVR7z1J4QuSa1r1xiVKn06fVVfyH5Dg4pAtsMY6yfXcZyty5UFbyycvP3oS?=
 =?us-ascii?Q?A04mOqlT1Bgyn63927oybRP0SeIw+IAOqnug4YaSP6LNk6OjYQ1I09LKDdZj?=
 =?us-ascii?Q?aW2A1Z5Qjyijy0oE0N7pLWXvemGvAuQ+rW454EOvSt0fAA72E+oCmz7aydII?=
 =?us-ascii?Q?TOqXEJWyAp/1nw+HPOS2Uv28nRyCglRW1t1djS+ION1Xri6KzsmCtIhmAZ5W?=
 =?us-ascii?Q?4oyfu9F2du3Z2R3GLapYzhXmxSsjUuDP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KVK4V5/pnIO2dqxQFwYbpu7AdmMy1+3ni+cgcpGLR/ASmF7G8qQZqPeEqckv?=
 =?us-ascii?Q?hY0U6iQ4fXbf7WyNyhJlwSVzu/ATOXi/Ne77xp0lSne0B46qlC10jqTJLIxX?=
 =?us-ascii?Q?zmgJ3X4LwtrIibpiKfknSxgMR0Idt7sTEgDyH7vJe5hbhCWkOBfeam5XzqG8?=
 =?us-ascii?Q?Qq5vTiZr4JSJ/RR04xZxT7ct6uOZv/VhWEdQOusqDG4YqK6XxDKjF4bVle8+?=
 =?us-ascii?Q?OrJajVDfOnmw47AZDDY1Zi8J6B0fm16MGIw25i/l15cfKx04q+Io2aKtIwAl?=
 =?us-ascii?Q?hgwTrjRvA7rgZBELSGlc0z3Zgxwtq3/b54z+9UYGSHrobUXEphIWOyPXYv5J?=
 =?us-ascii?Q?mUyNuuhy8qUNtZszFwV82vr0DO6tS95d7apln1lww3gXAvJk8/6Eo2GB1LJW?=
 =?us-ascii?Q?tNxdvUIqMoeGSAqgXhrJpfJfT2HFDk3NULrts8T3Pq7UxmOgH0jNB9v1Olrq?=
 =?us-ascii?Q?IyYknXOEOlUu2QQI+emEI+2GN5c0OjqgAqrwzbpMxycc1evjXy0s/9xMrtdY?=
 =?us-ascii?Q?SuohftfOvVQYl319O7xzb5F4rDbehr0wVyPDGBZ7OwE63F4xoSlXEC+hGawK?=
 =?us-ascii?Q?Kqp8b4kARxcfrg/Bjw6Jd1nkEGbHrthFyZFBXUmME9xSo34k0sB9M0bYaahb?=
 =?us-ascii?Q?awW5QUOK1pEmGkBLjlsSuMlWVnz9XM8iEvWTUgs11iMgPbfWffwuatSglLW0?=
 =?us-ascii?Q?N4ytH3dhLfCWTwH294vFV4hqqlpFjuh7HM88emWygn4pY1QpHH748Y+qjNMw?=
 =?us-ascii?Q?LuU97uu5GrvON1KEnaRYhnG+3yss3ZFO/OQE4qBsgm/pj1BNyZS2g8t2MVEE?=
 =?us-ascii?Q?w4ugu1hq4WPToqDPhRsxRciJtSSPcjroAAACdz3Pr4FoyxshJ46RLUI1qdbz?=
 =?us-ascii?Q?0fdZydZdkxzi3fHlW0N/YWYoo4Bba2e9NFqZaPXri6tOT4XMy+C2yhB9RBHV?=
 =?us-ascii?Q?QQQJf6+hQs18x045uoN0+uL9Z/CZgu6r31XPvahVE3Rs2j86HwsfrvJmGoAO?=
 =?us-ascii?Q?r5UVRRGW/KUGjL1qB6mfwRyF5VOL6ldC8LZw/Fq0XjY9uD5xSCu5K2odGF8G?=
 =?us-ascii?Q?/e400Y8z0OcTPLBhc34pQNp+jKiIQ3saOuC0BoBz8PaBNLzeMGMgtj+LIAlP?=
 =?us-ascii?Q?VxMzRy/9X0y/wApWpDg/ql0PCmtMJOsfnzXRxKJOGw1k3YMoISApBXY4v8pi?=
 =?us-ascii?Q?d0B80ta5rOoFcTf43oEGAZpHCPDOhZ7jh2Vl3CkNoHTUALzWIZFH9UNUUB66?=
 =?us-ascii?Q?VGvJKXBiLwzfjGLkrnY3J/ut26yH1rq9gipSVHOv+6sGansMi9z1ZkuFIwh6?=
 =?us-ascii?Q?qxt4MeqJmzt8D+zvpO6k/yawxXkfKBVIzhtQw9rfvXq45rNZu3huJW0JFr6T?=
 =?us-ascii?Q?aQRPr6uhgF1i+TZBA9X2EzynpeG1ikv4GSX8a0sAUScKGz7K48tA1yu8Hunn?=
 =?us-ascii?Q?9Hw9z7TIanwn1j06JPCUAhzzxt9ET8ss7KxXDQtyWGgC3+Q4yHyssY1pKAZk?=
 =?us-ascii?Q?8JeUx5G2dxcaZeRgbqoqN7r/4+gwpFDbmshtvcwksyJRF6iRAHJbXJQC1fpu?=
 =?us-ascii?Q?1IKKbECGBQEnnKSa+FQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fefc91fb-ee1d-4bc5-1e20-08dd653a9c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 10:00:56.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h500DtXXxvmRJXrlaTbMUyaNJgQS2P4xJZ0j/AL9GFbix/WXbgPW92wok7FL/MFYl+1FW7ZqWHlwgTAWaKm5+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7760

> title: s/filterng/filtering/
>=20
> On Tue, Mar 11, 2025 at 01:38:19PM +0800, Wei Fang wrote:
> > Although only ENETC PF can access the MAC address filter table, the tab=
le
> > entries can specify MAC address filtering for one or more SIs based on
> > SI_BITMAP, which means that the table also supports MAC address filteri=
ng
> > for VFs.
> >
> > Currently, only the ENETC v1 PF driver supports MAC address filtering. =
In
> > order to add the MAC address filtering support for the ENETC v4 PF driv=
er
> > and VF driver in the future, the relevant generic interfaces are moved =
to
> > the enetc-core driver. At the same time, the struct enetc_mac_filter is
> > moved from enetc_pf to enetc_si, because enetc_si is a structure shared=
 by
> > PF and VFs. This lays the basis for i.MX95 ENETC PF and VFs to support
> > MAC address filtering.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
>=20
> For this series I don't see any VF implementation of ndo_set_rx_mode().
> I don't think you have to move struct enetc_mac_filter from struct enetc_=
pf
> to struct enetc_si, so please don't do that until there is a justificatio=
n
> for it that is contained in the same patch set, and the two can be
> evaluated together.

Okay, I will keep them in "struct enetc_pf". :)
>=20
> Moving enetc_add_mac_addr_ht_filter() and enetc_reset_mac_addr_filter()
> to enetc.c seems fine.


