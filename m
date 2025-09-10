Return-Path: <netdev+bounces-221539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B794B50C33
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF0216377A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3163235061;
	Wed, 10 Sep 2025 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I8ch8uGy"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01211F3BAE;
	Wed, 10 Sep 2025 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473705; cv=fail; b=PcZlITurwRdzPlfitHkNjTQG7d7UMVdCfxuk/aY0BNGFTrCjP2q3bFCMYl5VTYbjdQOFb4CAZRQ/B6JaouWwa8d+07cHj6s6S/fcT+v5FWFVbBoc5ZGmOv+6Fc44q6l9q9YGYNHmgBkwIAcDQGJ4OyBCGI61rLtFzasUvQHsBRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473705; c=relaxed/simple;
	bh=WWVEVPMbkf/En4adI31Q/+t4LSM103cUte6DcF9QLn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGX2H2FQRPM2YdqG3lTBwsNooldipGQOs2noHTxvUbkP+IX/azBFyIOSLDpZ7kS9ZgPGruvaegpmMeNLLS38Q8I+JDVwwzDF6aqG5vZX5dkP1RlDooV8te6FPMJ35TX9JJZz954ICmeiK/8LLqo6rPEZ75X00SPMwI4G62PUbro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I8ch8uGy; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6Fzl80K5CoevCTTMZimQ6K87XSjop9EfEhWJwtq1WJdjlP8Comd05DVl7MXLKoZgZD5q8xM7NAqsJbqXEiCDIYrS2KuNY7mNr5pJfBQQ4lgeCCBF/guJXxUFZDs36JR6NpDGI+0SUad00m8mqPObgEz6hI0kQzCopOIm+Ip/LVj+bkGTY1F6ei+uMUpKXxDhRUKZOB1yUep3KYdlKHA0o4eU7TxtmwkfOG3B0vvyULo8JPfQuZILJSWAHXceNJsSSaSaH2A+Fhow9sgUPBbmKOf3ufNdfjnfq18yKFhtXN3NIxtnC/E/wyjbbajNcebsDpeJ2d5ZDmCdId6xCVeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWVEVPMbkf/En4adI31Q/+t4LSM103cUte6DcF9QLn8=;
 b=fysY4pKdjZjfX3ij0kiGtVOMsD2Wo3dkoaosAMd+1HhU12HNMy40KoBVM/WvWj8tpKyV8LDdZWC8r+DBGYzF76oK6tsjCbkF82M0P6Nt8PBw/MemHRf4KkXmFfCuuGgDHJb/XvBev6AdoCl2grbtG36uP16tYAin+js++BInhHZNYHGPx4TVkK+8P1NnLvP4UY215KAubB6atapiCwpDHfez3gfgeSqdV9hVbnSUYkkqAZHieR/qBWL7bx3Q2lNNrSmyE3j8ePeV0iAfkdrzFWGIW54sXNg1m0LiXoRH2Jj/2UReez+5S2OTcKRgPx2/1xx2bwWxk0+y6iOojdu4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWVEVPMbkf/En4adI31Q/+t4LSM103cUte6DcF9QLn8=;
 b=I8ch8uGyHsDSxW4MRh8V1Uu5Cqkwre3Wu0mthc+tU3RbQp6O587KGE0frN64fEoqfPUv0PgMYWTZLNWJF0dpqMTcvUk17zCYiSrZ+TffnMzqerbEms8a+k24J4gHYpGgGCYVHKWcWBGzHhJ6duklRqBltHJhDAuT7DdlrGNRBCeMirlEOA4lKQ7Ej40MBxy/PWisBUFXRvEyXoB+3Fkyx4fUp+hpgvOKVeMwZGou+65y++/2JPJDPaLG3o04MWs0PM6KmltePYWhmTH9nN4Tm2w31JJEsKymu0ki6O5TYvKHBg9BraCJWOHtpRTQexsTavODP0L/MWsCq7hG87CocQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8528.eurprd04.prod.outlook.com (2603:10a6:102:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 03:08:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 03:08:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Frank Li <frank.li@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcINw8WFVpNWz3XkGFt7EQK+FfVrSKGSmwgADTkoCAANF28A==
Date: Wed, 10 Sep 2025 03:08:18 +0000
Message-ID:
 <PAXPR04MB85102F65E17869C13D45F708880EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-2-shenwei.wang@nxp.com>
 <PAXPR04MB851097411AD8CF1B4250517B880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB9185336929DC3D5E5B858ED0890FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185336929DC3D5E5B858ED0890FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8528:EE_
x-ms-office365-filtering-correlation-id: 6d9ea807-031e-4a06-e7b8-08ddf0174b06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?of6mKNxz6x64YAD1FGF+HCJJimlVAhlqWsmxyx1r18asl9pv+2cRtRAJBeCF?=
 =?us-ascii?Q?Mo4ZxFlPNH3TcctdpXybAcPj11Ng4BV+s6wYSvwYNSBGU/nKwr8XTEtUHaM+?=
 =?us-ascii?Q?t5Dy7AJd55HarIFFwLArP0RCse94ABrj2erxzU/ak74nGGxNMMhFYbDeMjib?=
 =?us-ascii?Q?9qxnAFDTYKiDCpLCLPP6QJvfANWcf+XnwKt/vVWBowI+PXoT95xLOl37ymCo?=
 =?us-ascii?Q?mkYObC2iHrqrJ4TdG8CUMt3qIWGuAqf9JOFbubODSXld7EZxPHHPn471LF+v?=
 =?us-ascii?Q?59UlI3+PkvGukSf24q93JdUwFeEukqFNK9A+Ji7mkbvR6IXF2EE8SyKXTxhz?=
 =?us-ascii?Q?a2weUgWGrLA2zIieRwWYCxjT2afohv0txfi8CvAr20BbAQd0lO47hbpGnZsU?=
 =?us-ascii?Q?2oXZpw7IsrRaU+EUH6KZm4ZdOZ8g97ey4qd7W0IyLIaI+UJW/ySNabjOcC/P?=
 =?us-ascii?Q?nNgxqtZh9A1JMDRWTohSn94ZkyZ09GoXkjOZwuj12h5ORBBMAJ3GVDBWo7PR?=
 =?us-ascii?Q?4xXHvvatoY6zUmHtUJwrnNKnbb0w0sm+zwOszOmKW0xaUFB6vDDY+fuISEGd?=
 =?us-ascii?Q?1/NjSloK77cvHGC9EDv7ESLExfYiU9iaIvxTruCMdKbD56eslSiFYnVu4UZQ?=
 =?us-ascii?Q?/93uezujBMEA+1Bx2GTyHYJan/E6J6Gbj6PrtLXjStsSrveQ9+Bt+6AeYg+A?=
 =?us-ascii?Q?jFH6Wu7xVpCNV51bh/sbwRgGKsONj5i5O6955dHrPZb2srEBePtmwxGahzyS?=
 =?us-ascii?Q?HQMUX8vjIdgOEFcvc14BVzq3fYcs9nxNeVWnonr18vVN8uuHWQpW9sQ2XOnN?=
 =?us-ascii?Q?8VWZwGcoW6rvLiM9kE428MBv0PqEpmRcbZDjSYZrx9yVFasxhdZ4f7iSpRCR?=
 =?us-ascii?Q?KwAZv9iAOzn3gddfbo9lWa465aQMXcIq0UhAvzhmXlXPK4BVcvobOpf2IVAf?=
 =?us-ascii?Q?62SJt3Hm3IbYNomkJRFZPjXBn5cT47f3BT/P193eqhnWWXmhumjqDdr7et7i?=
 =?us-ascii?Q?ydn3hVWUq6zOQsgBx5Wyq+LYukIVPp24Uoxi0tXcvXVWJfCQvpjt5FvZVRTU?=
 =?us-ascii?Q?Iz51owOGzttDNekVL2IiUCdHvVEjQAz5QvhRyqJrJsh3Uy96gxtuDxnrCAbY?=
 =?us-ascii?Q?ca020RvD8+MZQDyTMnlrXjj5lKFopjHObmHVz6c37toqo+Y2FmuWbFiKGIs4?=
 =?us-ascii?Q?Tgp8VC4AlSbHPba+Scquh6XLgXumFG2c920w7tMJuzADWfApAKY/GBgTuqtH?=
 =?us-ascii?Q?pZq5zdgKs7HXcN/2cji1rVFER94ECMzk3ex+aWmdmcnY3geY7DbejIYNL30V?=
 =?us-ascii?Q?QJkFEgBPsxh1mY3CoGqHRr69jfTNZdPHkLyPhAF0H3cmhS+zJdQ/MYVh9I9k?=
 =?us-ascii?Q?XMvQ6RZ+aVJbywxKxIYkLc+NcY27OqH747o3oWqP1GdSWanRBQvlxz+xiGPT?=
 =?us-ascii?Q?Oj/LZj0wwS3vQq7sUjHNcWytb3xZsCO3c5B7zqu84L4tekeLKuEr7Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?B/YlDgd09D1MmIwUw4E7VW7yuD36t6xyYW9itD+Cv9m8P7appYcC1eB1DmrT?=
 =?us-ascii?Q?XFskaqGFO7vHdvrSOlnDIkIEeBwb822XQXzIPVqxwWVdh/3tU8V4YeUruCD3?=
 =?us-ascii?Q?BSuRr3yV9915/0q3YtwqfJ/IOSzo6GxGk07ujhzAjOmbKkFqqqxP4XwrSxM+?=
 =?us-ascii?Q?pWqDnTeEdO64Syg+cYU7EvhNzUksF+JIPrA8UtUr6+e7SgW6ua0PYI+rikpc?=
 =?us-ascii?Q?6hgMN98EEdMnLTuGrDnyW2wlaief0Xi0d0LISYdrQBJtNlbilH+N2d/grPms?=
 =?us-ascii?Q?if6SM3mT6ezoK0NUIODa72bA4t8nDZ1PbZkYzetXbnaIxhdUhIhSRW0+orEY?=
 =?us-ascii?Q?1gkxAhCy8x+0mAZG3Z6ePfSKVDhCNyrGPFEKQrMjS6pbgzx8kar4JbN0dGtF?=
 =?us-ascii?Q?o81+bCg/WNc+b6YCADSHmKf7l6uR5f5nkQz19ElK5+gC0bWbAztOcrflDXe/?=
 =?us-ascii?Q?8P1F4HKJWw8Di1QzKJKuyxFS4UVrCTKXRQS8X5fNXBiuWZhx/TeS7ta+0x/m?=
 =?us-ascii?Q?ZncRFaKS8T7MNeA5y5HiySDgkeGJmMzrZ5dzg+XIVLpwN1RnYzwO4vIjD2Vj?=
 =?us-ascii?Q?WH6f7Xoeuc2/dvZrssjsfLfZYQJjzj2t1neZObM7xELaWr+97ieZW32Sb59K?=
 =?us-ascii?Q?OyMGDBhHc5Rn5OE4Mdx5vEtCrMnKqIaDhqE5NF4FYHwRa+lDM7VjlOpaybBL?=
 =?us-ascii?Q?pGBG76iB3Q9DvVcbbSfXpF3GSyBuOx0qBqhwFl0gfoAU0qu83qJYJ3ZZP+R3?=
 =?us-ascii?Q?HzlYdFGrQ15g7VbJIEiBYYYY1oooXTARLCOQXPe2zBgWtTISePm1QninU7OF?=
 =?us-ascii?Q?mF3/O+zk3DPdIPLCSuaVZG9ZiMH+SsdVU0A7Vfew3EVX4E9Nb5qEbKcg3tph?=
 =?us-ascii?Q?yaewQuNZahxNMlngptLiVaexJcoKh5J/axJhmWGtLQlpb6gxWnabFo876HD1?=
 =?us-ascii?Q?owFEFrgJGEYtJMEY5eaxOQMjK/b6gfMQcKkYLgBHvX8vyrSRKl33LWjwVxde?=
 =?us-ascii?Q?kuA03olhlHpcdZ/gVznlQw/zyHdTTABEC4tdxuQ6KNRGxzBHUYdFiyNM9yqY?=
 =?us-ascii?Q?6a6cFD62ZDASVJ+IZ9NOIkbqvyJGfL1vCh7rcCHOE0jv1B7ejp4GeAJVokBX?=
 =?us-ascii?Q?Be5k0EsM2pa83QkduXoD0WnyR/48o6UYyy686tnGlSp5imDLv63Ta/AQtDHJ?=
 =?us-ascii?Q?Epgo0lyOLbg86SczV9YOrWTZDMGYvmVBIEZERwCappXMz/v35SmUCHNSLj5R?=
 =?us-ascii?Q?PgprtUsAVqx+np9Pv8yXCidu58s1mog0RhQ4WgxCnNKY8EHlAh2QqaXzGzwh?=
 =?us-ascii?Q?QB2LdCzYF4c7tAx1sYiKLO0Z1E+o7TQQMrt0gebi7Qj8SAZnF5TCJKy/YS/u?=
 =?us-ascii?Q?Q1c5ex1Ep9NmvOQCwWUCPYsmabun93hGv9mZ2I6Z39zxTZB+O8OpbXPae5B9?=
 =?us-ascii?Q?PcaJHXSUsF70qES1YoD/f3xXALXg/V/VWbuWf2cvJZBOtlFq7yIRnzs6KZ2K?=
 =?us-ascii?Q?HZhRSRmktxiBMD3h9mSZqKDd3FV29yq7lHF39H1vmXiHuz6KmFGPKepRC3Ly?=
 =?us-ascii?Q?QwJVnuW2SIrYPsmF/Zg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9ea807-031e-4a06-e7b8-08ddf0174b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 03:08:18.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Yb8QmaAYB5DC6pj5VmmPoTfbn5WgBT7lgN/ZMqKPX0AZiTBU1AYNVkfEKHCVsFH4SUGOLpTlG3gJctdDYUHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8528

> > In the fec driver, I noticed that the expression "#if defined
> > (CONFIG_M523x) ||
> > defined(CONFIG_M527x) || ..." is used in four different places. I
> > think we could add a separate patch to define a new macro to replace
> > these occurrences. This new macro should be more generic than
> OPT_ARCH_HAS_MAX_FL.
> >
>=20
> That is outside the scope of this patch and should be addressed in a foll=
ow-up
> cleanup patch later.
>=20

Okay, make sense.


