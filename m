Return-Path: <netdev+bounces-206618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F647B03BA8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4001757FB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49988243369;
	Mon, 14 Jul 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nAPT1002"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011032.outbound.protection.outlook.com [40.107.130.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE10823B624;
	Mon, 14 Jul 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487917; cv=fail; b=doT9Bn6XdroNi9mRjQ6tTgkCmVuUZNr2SwMdJoJK9lo+jo0fGCzkfr8l8HgK29pizTz8Umoz3BNtGWnuQrwf2LExf3TDOjAy8TkqmbdfqdBk1iW3jIxRgu6xPxJt4/fNG3jRzUZDTRLrCbqUtzT3wPmfj5WHyAW212++1UszLEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487917; c=relaxed/simple;
	bh=zWCBTxYyUBF3Y6G8umV/9zMJqHMV5IvPliNISQsniA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHT90eF5IVEyz2uObVSSDZ4zURiF9TINFgSOh73tzbWDg8rZwFMift0eltOOYntDeB+YvuzJ5Ra+AZcVmii/n2o5HSPDeRGzK7H0/IlrkwRLsLY6tanRMDujBSVfSR4vkCGXYnAu2vh63hSzJuunEZDPsu7UAPnRLnSkarb/n1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nAPT1002; arc=fail smtp.client-ip=40.107.130.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yT5lQj44zEPjT/8yqhr7ZWHYbyd4mHiaBuo+kz6+MATqjVqfCopRDHK9Gy65xmEYqW8oDwETuvHRba9t+JxMavpMAzCy/464JliTw5Rm8didi/+4ID/kYoWMwrzuQI5Ewbyc0yPPrGqSRCDAmATWQsOsXg3btfEcytpR7x8yTNuH8gZw/PE1dJorx617KnUmXbPWDTXJiPuS73v9nEVd8jZnrLJEWQnWGGbQkufjDvp17804PemgFjqkTlZxlEWW1u81Sclsh51VucO6+acdGEAf1C1u7m1PkKl3TtIkbIVa8Xg0WYLmcCXWHtZeg5Li8xrkRSjLt/aXgimey7AAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T32X5cliw6jQ0k2uqIl9sEfZmuMcoOXOEbc5QnC9GqQ=;
 b=N1QRnxCH6pfQjSh759R8j7qL3aDYKM/M3xnGub9A2kKtWX6bqPb2xv+AcVOjHJLs0ZNILLorSVTEKYBK4M9/4gvP9mCz6GV7VSTe13N9oCmTUDkjNhhB84EmNVU9rfRlPUoTGOFqrN3zTFeiShHoaOp8NN9KaECc1H0K8fByalrr3dDmbJZT4+m7CNzZlFb62cZ4xPcjgbe0h47/imEcsUbwe1jVcEMOjDdTbHocxlE5BriV1x3S04aWa4yEp6z0Rgh9NPMlKOQfvGj7msd5zDmd+WT8Opb3ACh2HXZ6LlvRrs9r7Cl/SI+lISDvMF4UqvMTucAVuou4QPvV0KnFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T32X5cliw6jQ0k2uqIl9sEfZmuMcoOXOEbc5QnC9GqQ=;
 b=nAPT1002sUPp4UL4P7T/y1Qcea0hhAyzixxNKReT1gG+T/zcjOgpOITE4DlXcUMjXttHZSjXi+p73UYUz6o5I0X4ZEwQcsLv6HBuh3ClMlLyJHVudWBdX4ipFntWdahJU/SQJAQ13+TDLgsyYARcuCSBnYYF5qmdLmnOqF4/kES0oYQg+QbBDdVyVHegggvfz0x4IyeYjWLohRNG0VfHcZScGWT7Fzl4PxbxZuEM/ttbnvXXn/WNBBR5NQE96f/2OrfZiRwbxUwNBq6WyGYSldGIfm5HVeQV8uxW2802jSLMuuFDQu2D8AESaAldKEPWfbq8TJcSGsbZgCsjR/LOCA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8576.eurprd04.prod.outlook.com (2603:10a6:102:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:11:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:11:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Topic: [PATCH net-next 02/12] ptp: netc: add NETC Timer PTP driver
 support
Thread-Index: AQHb8jPan87Rdn8VMEKOXtXyIvr3+bQxI2qAgABGSfA=
Date: Mon, 14 Jul 2025 10:11:51 +0000
Message-ID:
 <PAXPR04MB85100AE0EE386F30F8AA39FB8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-3-wei.fang@nxp.com>
 <6df95250-f28a-4b33-9744-de8fcb0ea339@kernel.org>
In-Reply-To: <6df95250-f28a-4b33-9744-de8fcb0ea339@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8576:EE_
x-ms-office365-filtering-correlation-id: 3322de09-3938-484d-b0d9-08ddc2bed9fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T9BIgB6PRlAPLPB5Qb8hKMcJ69QBz/l2brOUFntOXNvhvThOEyrI9AnP+crp?=
 =?us-ascii?Q?VlbxxVH+v45wocojEuo98nTsFyc531D7UXqJ3oXQtVJpqewb8vZNLWydBPVQ?=
 =?us-ascii?Q?UBMmyQfipSul/268qja0IEsW47njm1uSHarLqAHp5DvsSYbaVGecwwIIsjPH?=
 =?us-ascii?Q?DMpWZo/4hr38d//88ppSeePZtKg6NOetvY1Hsw3nfwVdAn8UWPf/x7Dupi00?=
 =?us-ascii?Q?+B9QQPzpa3/khxbGl8yh3xxxGP7zCWgP/uWlD+ohlj++HQ2oPKcCmJcZcPS3?=
 =?us-ascii?Q?S9ap1X04W8AWZdEXQNc9KTbXrO4t8IIMW6Mfv+zulEFS5gZVtbu/qlI9Cane?=
 =?us-ascii?Q?PLh9IQiMdlC6rix8dDo2ryJ9ZQfglpbZjH+EnXxTZeEow7y534SYYumMHGar?=
 =?us-ascii?Q?b2luHgmVUJKGpOuITYJ2bedETTAy/1Nx1G6oDKG7vqW4Qd9Qs5zAGTscXDin?=
 =?us-ascii?Q?WGiIQ2fuhN3sWtlNjsoMVdLte1GcX4A1M3Wu5WUCXVC5tGNr/k3TG1VWD0Cw?=
 =?us-ascii?Q?4Osf0AvmaxllBMfxuhv2mknUPXPifxmUxAAQpU/mQWMjkeNN6DjweofXkMYB?=
 =?us-ascii?Q?63PiuU+deBsRxoC3mppGGo2rmGtl8m9GsSCqC1+viA5+Mu9yh1OtrWrQ4yls?=
 =?us-ascii?Q?jlbS7lyHyCEjb8qUJWm94OugzkZDV3FDofrStYNB06YQ0T4x0qo0TVBOqzmt?=
 =?us-ascii?Q?hAr6fXau8HDi0fyejfsTwbIBuhowhe1NHr5gn6GK0NZxkGUp5dxkZGut9ezY?=
 =?us-ascii?Q?XXXsfCJ50NB0PfFHKah3mSHAllleMbtkcXUpBaN3QHi3wNC/sBOwb0u+g+I/?=
 =?us-ascii?Q?kFR/pOT+3vSf1yvKz3QtnfgAYqyGnZMYHt/Gdc3SHp2RWZJ5Vec5NwFLkI5L?=
 =?us-ascii?Q?SceCGazk77ZTy+14+3bX8ZEMqJ9hSo4TgS4EfACrEs3xhctLonio3yyZsasB?=
 =?us-ascii?Q?TaGn2uOO9n8JDJ+DGcckmU6Ay5AQt573QcPhRwGhE/0BkDoNsn6kAY56ljwn?=
 =?us-ascii?Q?HrS5Mwy+yv5QBZsOO/KgaKWqVP3ok4f+xscHyEKjMQq/zG/THWowiVQsdZvJ?=
 =?us-ascii?Q?dCIzkFsg6fVYLDTys7CnCFsmCc/td5SZnDisQ9rU0+94dwWPV98fX3XOiA0E?=
 =?us-ascii?Q?8aqp6/xuyNsdEQkAX1l97z9l2HabF80Ns6mShRa9wYT+dXCrt7+Y6oJSsZtv?=
 =?us-ascii?Q?mfWIPKxjuNKip6ug3SnFvdvleNCSvDg3YBP0W0yHOB0uSAAcG3lz2KytzhQX?=
 =?us-ascii?Q?0qBtHUKPlkcnXE//SAL3t3gTo7ofH/fU7ViwD+Y5dTDPTFUorgTn8M/8zPOe?=
 =?us-ascii?Q?Qie7cH/YB70ULGZng3kEeBMHhr4nrF9UfQekh3EsNT/Z4QjD5v3BR91SzTd8?=
 =?us-ascii?Q?vivwoiv+pHe6yMGdyoYiUxf9liwAmJqt6rXNo1qkUO8DysXmE6aOvC7XSTs1?=
 =?us-ascii?Q?ygPcz2KX9lCKx9Oe2E5poKk8ODth59IQOn5sSjxcg3Wpp8GtZesESA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PxztMfaeQ49Klme8aabIhdKITDWMv4ukdc8Q77RWNjkDebYHNE/861egJlfx?=
 =?us-ascii?Q?Zb50YBGjY5BYgJpMQuz2NvggR5aVuERYz1D1eimlDXyo3OfSyTjvwqLgbwZw?=
 =?us-ascii?Q?uv4XcicotkxmHjJ4AIw2o0y6+QEZNZpQtzyHMreznmtHsL7WlJh1/1BMFE37?=
 =?us-ascii?Q?Vo8rDMfiFHGgIc+kUfCRvrodSER0QrXhnh2X2LFcHBBUnqwhsZJS8UeDHSN/?=
 =?us-ascii?Q?N/4RYJ0529zztvaaMMMADQYQCmAYKPpi8Mfhm6jFAwBQifDB+w4F8ZUHNym7?=
 =?us-ascii?Q?q92vFoNOXGuFNU+8qiHUw2y2s/LzN4ObsSNmz2+MioPzM7nT79bmxrK4mM95?=
 =?us-ascii?Q?OUDM0vTZN97a7Om1tWkey1HX84DL8Xdj5U3y18NFiUKZj09/49uL/+RYqTup?=
 =?us-ascii?Q?lkqnMDrZpGZ6g5J9dKlP6fdwTgnDPRfo1zBIKWqzCyfXcWk1ijTAnyABc33S?=
 =?us-ascii?Q?L4dBvP2+V/ZTwkQYbJGTNT5/heoJ/EPcwY/TiXXsbIWW/kqegZfEUoQvDtkL?=
 =?us-ascii?Q?n/CN854BAg+DXMeIgTFleL0zGXeYQ74ycUV9m/K8vooRYQwLoINhP1Zttdtk?=
 =?us-ascii?Q?Xj4MB9eSNp8todrz5nlqbo8pDloV+knbZ2JHJzCDlhFYcyyLp576g8OW4geE?=
 =?us-ascii?Q?CvW83reR26wB29CoiqYPefhOFFVZCavivvkBO+QVfeTXS1r9YOHs84TVfoSC?=
 =?us-ascii?Q?eFJrASRGdD0JnSpQcaAs1Ne9m8txNT5SvPGLRyYtAixQ30938CdpBOAhvb1C?=
 =?us-ascii?Q?+LamlufWrs2OZeBfP+bVeSTNGXoJ/eRp+7ADwR4B/HrABjCNgwPER6SnwLT/?=
 =?us-ascii?Q?CGNqoE0GsjHgFE5Wn3egKzI12Zr4MJ8sbuqGXEa5T/DMjoFLlOt5iK6UG8Wy?=
 =?us-ascii?Q?1CJVReuDSvF2B9Aobh9eakq2VJqZ8M2oI9CuOughSzeEuPt5kO3rge2PNEBe?=
 =?us-ascii?Q?UEYsUMc77PJhHXUAi2Orr/L5rV+kxZhIkiRR3bC/ymBcCue1dwm1cBFO8MWj?=
 =?us-ascii?Q?jttuhG/lJVTtc3jcGv3BNjggkFIScMwIEGq/UbJZ2RVqNz79Bj03ffoKAfyF?=
 =?us-ascii?Q?WnihSCZp6aR9vvU33BySBgQq6kBJ/Ka76Nfs/zXVSxpoPNmV4jdlE3XJJNCn?=
 =?us-ascii?Q?oeGtMZxaGiZk41FhOiqcdMPx6/9kkVxIbUQvydBdzItu52166Z4l3+HYQsh5?=
 =?us-ascii?Q?3IAGEbbfn5Y+SahiZP9H/0NftVMqwCy/kvv028+dx7VyfaFVpNEyrIY7mkcK?=
 =?us-ascii?Q?1VZ1Gkz0w3SajFdcpjOfMXd+d8geugqcnBgtngdCfCcb4RL4ebgwYx/+PO8I?=
 =?us-ascii?Q?FUFO62vAw63aFaETdmxWR2pe5WqDixYdLXKwWKDqBVfiA+z/4mi7Pp0kxv1k?=
 =?us-ascii?Q?gsElHjAWQJeVUhw06mHBsSuooCCR90SJDIw8A1bjvZyCHUZag19mgjndzyHZ?=
 =?us-ascii?Q?g7unwh1g7OktXbqHJHLbjlX451I1ltBtdmaFuYvuxda46kLJDrpPbn30xCbu?=
 =?us-ascii?Q?fUanMUU91JjrE8WQhQIeKYhHdEkDXTE6ya9ZWS1D1YkwVCJHDqS2IKRvWv6S?=
 =?us-ascii?Q?TmO/3ZRCOosRMT6OJoQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3322de09-3938-484d-b0d9-08ddc2bed9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:11:51.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yGHJ+qGyK1MO1iWuvt5K8ipWpizALoPhShSmpwXVm2CAbAIlZXZsHY6JjNSHjsfHQUFKUfQjKFlxymaxpnoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8576

> On 11/07/2025 08:57, Wei Fang wrote:
> > +
> > +static void netc_timer_get_source_clk(struct netc_timer *priv) {
> > +	struct device *dev =3D &priv->pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	const char *clk_name =3D NULL;
> > +	u64 ns =3D NSEC_PER_SEC;
> > +
> > +	if (!np)
> > +		goto select_system_clk;
> > +
> > +	of_property_read_string(np, "clock-names", &clk_name);
> > +	if (clk_name) {
> > +		priv->src_clk =3D devm_clk_get_optional(dev, clk_name);
> > +		if (IS_ERR_OR_NULL(priv->src_clk)) {
> > +			dev_warn(dev, "Failed to get source clock\n");
>=20
> No, look how deferred probe is handled.
>=20
> This is really poor style of coding clk_get.
>=20
>=20
> > +			priv->src_clk =3D NULL;
> > +			goto select_system_clk;
> > +		}
> > +
> > +		priv->clk_freq =3D clk_get_rate(priv->src_clk);
> > +		if (!strcmp(clk_name, "system")) {
> > +			/* There is a 1/2 divider */
> > +			priv->clk_freq /=3D 2;
> > +			priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +		} else if (!strcmp(clk_name, "ccm_timer")) {
> > +			priv->clk_select =3D NETC_TMR_CCM_TIMER1;
> > +		} else if (!strcmp(clk_name, "ext_1588")) {
> > +			priv->clk_select =3D NETC_TMR_EXT_OSC;
> > +		} else {
> > +			dev_warn(dev, "Unknown clock source\n");
> > +			priv->src_clk =3D NULL;
> > +			goto select_system_clk;
> > +		}
> > +
> > +		goto cal_clk_period;
>=20
>=20
> Why are you duplicating nxp,pps-channel logic?

I did not add "nxp,pps-channel" logic in this patch, did you misread
the patch?


