Return-Path: <netdev+bounces-245667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33973CD4883
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F4B33008054
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410731D74C;
	Mon, 22 Dec 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wbj85sc0"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE8A3C0C;
	Mon, 22 Dec 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766368423; cv=fail; b=Fo9S/FdOHUoqrRVdlE9Y4djbR3+f8jz5Mo6zQEbIKeQiEhSrN7HpAJnM+178N0b1CsU5josylRPrG7Cau8s6eVHr2cViOsnBWSaGe47ZgRCNYYiiXX2Eqb1Z/oh4/T2rKffc1W4dv3SxOPHpBzRo/dlnYeTinQGXQ7yWIoNLUCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766368423; c=relaxed/simple;
	bh=khYmYsQ3OSnAaG3UE342T/uvRe/sYI09KbT6VCIhyeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iuvuPWRb6XC75Nj6qWBB0qVotQWJOdkf6yf0nT7NESiB42sFOM8bL8mu5R18MqT7dPz4sY9Rfyhn8a6CSMIjbiLzNInA3Py9FjULs8mfYVv2Gy7Sm+0n1//sfSknNd84/aTtWlXHl6LyPCNPM1eEUkNglQlKNxepAuot32l97+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wbj85sc0; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9sYd4rgbQXrJrhccNohRnC0xADd/64SqBjRu31ydapGszMsiWSmNQoXlkFCFKAng0M6OuVS52GdjCILElFweFxauKOFw+rubN9uht3KQ43MXlYb6h4+2UyrkWEHLq6pWLWDgedfW2KJqG3ZpWYApQnMJjWBd96MX1XxQVx9VmUI05phLFVkFvrOYOrMyC5MVuEJLsPANhryngwckRlTe1hpN8t9zCdTg3fNJuNtD3vVUAhxZK+RwdYFw7SPa8QI5zs5/QcQk6MVHHEYzPpdbQpWNTkIX1N+XrScLd7thLooK09SS84Q07ZJN+7zbMPanK39oqlQWm0KehKTpY46rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkAQzukaIvfIMp044t3NTucy9WdQ4I96yz6iq2epCUA=;
 b=Jud3xU1baqykWkmUGag7AfX7VtpuwPMyIMwAFTZRxmjW7PbH2mgQitq30rCgFqTI0B8VG5+d2O3HZ4zfx9staZc7JDmztuMdYxBjWByUIDmH4MhPsoKXwQOcAv82M5diih4BZc9oNYVcvEhyrgBmwyMG2KF1nbBWZdblYvd0GGre+WucZ2R4Zt6Q2cUPKgttfcL6Lv5jPTDp34QGazWdDa+LjlwK7P33Hbp8BBqgE0hpVxiuWivDHdh+bxrbz9rsOX5E+babZf4CmzzLRLIPtcnQGIHGvIbZ7c0bJDBQ7pYP2a4wCx+Y9cF2XTFLwpqADl6Eyayl2Kuttu15Qh8Gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkAQzukaIvfIMp044t3NTucy9WdQ4I96yz6iq2epCUA=;
 b=Wbj85sc0/8sF7faJRSa59jrhSJ6j8ovwb9fZBEAHJHvkVOguInd03E/KIdqSXrC2y3Ia+DEg9TF+8nyXy9ior01Htk3y7TZoTiF3Q1xkkwGHcsLXfPcgopQtvsiFDDFgKdxMOdgh5yYQXkG129zDTtr49lQFpNYlS0EQF54mjocUOW1OugCfemwuoiQqh6PyKA30/A9/bHsm5ZuZNvrUxlUpv8lBRd33r++6R7hsI2xsUvMYed/d6ZmUB/c2pWwj/hW4Af6LqRD2jYNw+M75EtKMnr4sFX00pZK6oWOq4oow2esw1KMJ1VqbyqC+07EG3ib55ykannB9psLuTf6ZOg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11749.eurprd04.prod.outlook.com (2603:10a6:150:2df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 01:53:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 01:53:36 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: do not print error log if addr is 0
Thread-Topic: [PATCH net] net: enetc: do not print error log if addr is 0
Thread-Index: AQHccMGDY6APgIKt3kWPjMG6vFtoF7Uq+h+AgAHvxWA=
Date: Mon, 22 Dec 2025 01:53:36 +0000
Message-ID:
 <PAXPR04MB8510C5F4EFC86B442216A34B88B4A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251219082922.3883800-1-wei.fang@nxp.com>
 <20251220201835.p56yu6birhfv7we3@skbuf>
In-Reply-To: <20251220201835.p56yu6birhfv7we3@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV4PR04MB11749:EE_
x-ms-office365-filtering-correlation-id: 81b2d154-ab6e-4f0a-1fd7-08de40fceb96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QU3nVu2oU5+Wi8jB72c4FUOp4oBDu4axrX2smncxUrEAONWT9yLvRembF3aj?=
 =?us-ascii?Q?5yExttxIwUFjs4eJKEzqbc8UbylLLBCxbOrBZeEakF00n2xuG4woYZnqfqlh?=
 =?us-ascii?Q?ZA87bdFpp+IS9G6lrHISP9v64K9sdLVE3dIBO344+9IMsMSkHR8wrD24QJrQ?=
 =?us-ascii?Q?1qChTcv0w8qDl/D4nhPRdbExe6XhJWp3pls5vv3emQzBaOdO1r6i8WyLioys?=
 =?us-ascii?Q?vLNXj3cRQmDH7GEuY7qVRjhfJSd4iTLNwKN2mmltErs7S7CF8qlQayJzDlQb?=
 =?us-ascii?Q?PqMj0mhLJ8ULe4jhDrhRzLh/KozsxR2j87JTUYd5gPw1DhhoOGLYk39aw77z?=
 =?us-ascii?Q?DB4FoZ402YMo5kz+58Wjd0DA/vdJlnK73dUbHy7TMvVMHVKWwczo23uI/bte?=
 =?us-ascii?Q?bezdXJ5YgkbdvoC8/mk95RFgAyRS4LoKE7IIpcu7bkiiF93EVOpzblCRc6/x?=
 =?us-ascii?Q?jwuQt6zCRXJvwS5ydA2bax7CIRUkgwgwEtkPmNnv2w/D6CGD37w+klF3t0+X?=
 =?us-ascii?Q?Yc2WCLHmpSpynCIlF6aBq20xHFFbOid8zCAyPI3jCDRO+TSazsSYR8Yv1fU2?=
 =?us-ascii?Q?6n3bwS1+Q2zXVWNn0b0hnWpvy3tcd5L5B6SkgAOJr6QYwYQFd60XmugxO4oc?=
 =?us-ascii?Q?pt12Y0TV91JTHWIAf8JS8L4+0CJKMAdN0hBkL2WR6XV+B5KLA9y5W6Q6qmt/?=
 =?us-ascii?Q?wLXXU9LkuMC2Wtb0H5XwP7AszmG1yR5tIA6xq/xdgS0mEWqWuuvpWU278Lsu?=
 =?us-ascii?Q?kNDzU8Nvhgq9JVGo1lw8/uPDwdo72lJpRilaycD/2eI5Bkla5PVEeV2L3qn2?=
 =?us-ascii?Q?1hCLOLvXDu1163XzgFUNNr8UwoQGFQw+uWOceyQUsYeTMT16jhYA9f9yfkYZ?=
 =?us-ascii?Q?/hrT7k08TYP2RAD6E/hzU/tD7jvKYeV5guUDOoJD+9jVO399aLMbiOtowemC?=
 =?us-ascii?Q?WWzDWQ80Nay8ax6a7zORKn1Uf5o3ZpsJ8TeaSR8JmoeMIGxjpILcMExWqYpt?=
 =?us-ascii?Q?sXmvQlC597d3/lN15QYsn2jYRgei/AClWN+04kwN9CncIGtx16QUP0WrIAvI?=
 =?us-ascii?Q?wxvX4eonfxXxMCV0OunyEynIFKTXSbH8Iu/lL4aKuec0IkPuixSfF7LIlHaj?=
 =?us-ascii?Q?9ISIXRiUar71Oe4apDzy8dpF90IS36kGo33KMADpnMY1WIQXoQYls54Zt5Um?=
 =?us-ascii?Q?EIn19cidLREt6I3eH0eO45R2bh5Hc5F2tEdCKyF/oS2JWzRTTjysushq6vfN?=
 =?us-ascii?Q?RDXWdcLCYtrpeJN4FqvQusCA8flfe4qa2Gm+l/Ea3XfN+Os/XAMrQxIv9Fap?=
 =?us-ascii?Q?9b6OTX9o0oyyaCtE8r3Ldoxfw90j+H5DRLJTShUauvDQXCqRrtmX31Hi9X/g?=
 =?us-ascii?Q?Lt3xkwCLLoAklb8R+X4vLS0+aT5iwrWeZ5RzJGXh+zAXWkhTI5/JRLEtZCFt?=
 =?us-ascii?Q?RZ1OnR/hLXRvtScjKjq8yDcjSm7FLWc4wawGIUB4kfZx3WhMIkAiA/BmuQPI?=
 =?us-ascii?Q?MwAS+GR2qezbx+kafV0lzCwWXTOo2AR92VbP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BvqdwN5SukMFgBsy7rhL/TJcDX54Xw+C4ufbeYYIzbZiPihiYNr+AMOig+74?=
 =?us-ascii?Q?kQy/WC1D+V3prwEFBdUMHThEAnSfSFEc50l4NblX1gai4wgX4nBChCZo7+rr?=
 =?us-ascii?Q?M1KJYB+ylqEMzB7L7WEMk5O1gdXpPi8q8P3pGxirti9FuyiybQYsIwpy9B0h?=
 =?us-ascii?Q?oMpO5OptKw3OFPKr0rZEpdkKhQM8ZXjzutL9SM6vROA8dORJOdBDyu2TWSyz?=
 =?us-ascii?Q?kVOtrPpnujVDU7pXzEhqw8vRCXBRUzZxTSUc/IhAM7buewGQ3lfJ41cMUsFp?=
 =?us-ascii?Q?tLtu98FEqv40nGFKuu/Chui/gQasdR/ptWIRcWSFM3DDRExD/yXjACELQyUn?=
 =?us-ascii?Q?VXaGcir4+OCS2y8qxqA0HkYiwoNfvlh3LyYYVFLlRiY1YeQWwZdCpjMEfYuR?=
 =?us-ascii?Q?rmgm3HB23M9m2sAi3usunNSevfy79e0wS+uS1w2WXv3qFC78esnJFRqb8Nfi?=
 =?us-ascii?Q?AiW079P0yXSPF7FCj/jozcQW1YsxBO70sGNFtbxFRpMil7F9BEMCl6o2/J9j?=
 =?us-ascii?Q?ShVKGD/eupUQmeqXsjtvIbE7N9qorO2kAZ3wNo2ayl8yFLxYxSZ3hCpFEA6t?=
 =?us-ascii?Q?McOsDwRo0Woqg7ECQLuP++injP+jBIF56LYFDs1oC+YDX/Mj5fldkxcC4HxQ?=
 =?us-ascii?Q?Y0H3ii5scFv4tVP/VCqfFfe4YXHsg7a+4Vi3s1gBUnipXy/F5YNyoHcnmPYb?=
 =?us-ascii?Q?Hr1bB9QZQ2yJ8tPtQuFMCWRu4zHiITKJIcpFira1Ogcgq1hA4AD7VoBtkNiS?=
 =?us-ascii?Q?bqgn9ViWs2RC/dh/sTGl87EeQQr1/s7btkf8j0PSFPf8HJ2cHKR5s9p/XfXk?=
 =?us-ascii?Q?sV6kF1IRWYsveySoSeWM7Ijr9+5GYXO915eAbCkAaOjfh20TzZZeXoIVoz4A?=
 =?us-ascii?Q?Je6th//wZcQNvcSzYcFs9KYTUNPRR9T7rrgiXJwf+Xd7UHGiDsn8Esit/XFn?=
 =?us-ascii?Q?ScL18K5EV2RO2NiDwiQONNzh6KJ9zEvwhN9cMYu0n4sIyW4Dp9+PT/vOBFC7?=
 =?us-ascii?Q?TzEtD0ENS2s6ABc1fAqFscJbfVLKsx7WdaEgoebse9CjvE/3gX6D2YuEf0IG?=
 =?us-ascii?Q?/WqAiWqP8y/DRd29aKQR9uHaPtRiBIluzVciK6AkxRxuCVEtFNoOR+bMM48A?=
 =?us-ascii?Q?AhLsvY/1ZUI8UVEVkk9c3tuOVwsVJ83283h5J+SNt2Z4bTG+W+cY2t1A70ZV?=
 =?us-ascii?Q?txcnwuGiJ8subrqP9NQLSJvvQBknd/8hUJO7vT40Sf+q31S/wx9Na1cw0Ml8?=
 =?us-ascii?Q?YPq3wODD4bvHKnQGgm3Vvwy4hbChlbvbLao/96x6qVr7xn2kP4UGecNII3xm?=
 =?us-ascii?Q?3A5+EvopaheiaNiUhaB8T8hg+hySIZ7uRlvojyteldgM7kxKiHLQutraKmlr?=
 =?us-ascii?Q?p7bHVr71Su7VqUIt6v/oHFKAJAn91ekPrtHQoHUzAkTF4pxW03PGB5rXRIqG?=
 =?us-ascii?Q?C7ftiKsT1YRLa1c6O/0/Ct7S99eIOdAEg6jaLXVn20zHaRgIZyYp0qH+hUvW?=
 =?us-ascii?Q?bjnrGt6C4pVlj7RjNChbHcPnylqFoNtWLYQqkX8e+mi6Mj7Wz0nl0xg8DHFm?=
 =?us-ascii?Q?VGSznArC49k6VQ5FZY36HJ3zshzdJeoQvj/OPS41eKXP83E1dW5E5fR0juQ4?=
 =?us-ascii?Q?ngWya59Ilxqgdq37nyMc/4f6sfV4q4gHKlpkA6c1VwdtIeTI7/sqJPKIM+hI?=
 =?us-ascii?Q?ZE8O1e4qi3z3q+3M0Vs/K6KW3PkmPRSweW3xLpfo9L8gETZR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b2d154-ab6e-4f0a-1fd7-08de40fceb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2025 01:53:36.1577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2Kx6bdgOevEIYNJZW8q3jNxX/TqVje3W558/JcO6OgaTiPDnenCkIZk2bZJCaTYmoVBsHjB4+ll7WUbESQ/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11749

> On Fri, Dec 19, 2025 at 04:29:22PM +0800, Wei Fang wrote:
> > A value of 0 for addr indicates that the IEB_LBCR register does not
> > need to be configured, as its default value is 0. However, the driver
> > will print an error log if addr is 0, so this issue needs to be fixed.
> >
> > Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for =
i.MX94
> ENETC")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > index 443983fdecd9..b2d7e0573d32 100644
> > --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> > @@ -578,7 +578,9 @@ static int imx94_enetc_mdio_phyaddr_config(struct
> netc_blk_ctrl *priv,
> >
> >  	addr =3D netc_get_phy_addr(np);
> >  	if (addr <=3D 0) {
> > -		dev_err(dev, "Failed to get PHY address\n");
> > +		if (addr)
> > +			dev_err(dev, "Failed to get PHY address\n");
> > +
> >  		return addr;
> >  	}
>=20
> Can we please handle this the same way as the other netc_get_phy_addr()
> call path (from imx95_enetc_mdio_phyaddr_config())? Separate tests for
> "if (addr < 0)" and a later "if (!addr)".
>=20

Okay, thanks.


