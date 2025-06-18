Return-Path: <netdev+bounces-198848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C76ADE0A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940FC177326
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70128371;
	Wed, 18 Jun 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G+pFsJV8"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B73323E;
	Wed, 18 Jun 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750210307; cv=fail; b=rVuaPSMsHl1K7gCg/bJHvKXBzNo15tKFkCyw7C6j4yaFmG0VnZVECjNcT0uPIOsfxHbzLRMQ8qqfGJFqbVKggmSoM9RUY2p16yaG+CMGnuiqYbToTN9Ye2JSFi7/QgBPS5GUc7ipZhwjOVd5NoHPRqY8JSnDMS3j6EYWpSJapmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750210307; c=relaxed/simple;
	bh=S8NSTU2T76Onm2Pti4IVZh32oTkabMu+qoxqWUpxydE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lj4qTOO9AfRB+W13HwgLs6x33CbdaTEdEozjuFFwUEflrzha5yFG1i7HPjmcR+/Ep9xq8Dk+wu5yl607u231/4BMAinMEbxEkWdO4/R2EYfC+GlMB7/fbPKwr9hQN0xvh/3DA/usqNZpneFqmnG2BQQeYAyRqHNftxz+N6JCdOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G+pFsJV8; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeCGDyy//jpEyHTxyXd1xmGthOWJGcsc3gsXegsi2AnKzBgtrXK7L5+eEMYfZ/ZNWB3mqP5j4pKcRJHQz3VXXUNKruElmVh9LH3Ogzp/uFA31gs5aYtQYZTKbC4lV4LQi2ywm7rSFLkFS9CY6A4N6mrvhcMAKAltazsH3ABlvmBaG84dsrQb3OaAUW6zblTe6TfDaiz9OxA6L5bNCYGjmWAeZpYae9zbgaqHIOfeIG4TAPJ7tDfLyqNmfOF4/dk0+h8qNMljLzpnWwOWqKgqmo+RG92i7p5cS8Ggjh72/kGn+xquG07Ho0GiTj/RGF19CyiXAlAxJXQ8+JOZpCa2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulgO4PDFBK/Cwm+KqSiA7eqO/VOWo2S41N4Sy9pA9tk=;
 b=ceRRm4/ZFJYpsrIQciY2u2cXbQn3YYLJZ+pvrWlTHlBsmR+zknT/cWqjhwfRFfNyN6V58ZDRvtZRPx0vRklTAIh7lsITI0MFNeu2Pn+unkCXdVSOt+8hbSzPjUjuSI3QVOmehlxpb/THAACi0ZVFWmrGgM+Aa+2uXcwPKCATK9EnJliltM0IaZ6dSJI9ELsxjzXgBVb8SIUBr3d0fGfkpk2d+Uubux1s2rdPUbxj0DizYpWHg2/kN9+JhP+gpMOPd2w6DFTZpRp59RnivCVYSC6P2Z6e5p61grISIiXfeGg5XRacrD6RsIuoAsojuP+Nuwat7NAkbtjFgpQndIeEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulgO4PDFBK/Cwm+KqSiA7eqO/VOWo2S41N4Sy9pA9tk=;
 b=G+pFsJV81Xapaua1Ql+Rksf5KRlCAOIe/8sqMA0WopUB2c3FPMYszdPqJRmqoJbao6JUNA6zFob+Vpu1uP4L7VdhHCJuG77uuHeAXbPC979vq5vn6EIKbXOrCrI7tb55Skk8o1vHV6ir49KGXBJNy2TQNE2mcQQ83qkBnX0QjUanZ2dtyJT1FeZ/k8qsPWFHn3ZAc5tmATMyqu27/K3WqHHmVDt/yQk2eKNStZWt5xr/VQ2fA6T3A2aN12jkyooKE63Bwobov6Zr+ZnRwoBDrQq5Tc2Axsof4KZY+zCGbF1/XQJ1W9AfZLbSDd8/N2CyBFrNDNB4Xwi/OTAzCoOBxQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10539.eurprd04.prod.outlook.com (2603:10a6:150:21f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 01:31:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 01:31:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>
Subject: RE: [PATCH net-next v3 03/10] net: fec: add missing header files
Thread-Topic: [PATCH net-next v3 03/10] net: fec: add missing header files
Thread-Index: AQHb34wAmdI7zMiPGE65s7uynpamWbQHcJeAgAADcwCAAKyvcA==
Date: Wed, 18 Jun 2025 01:31:38 +0000
Message-ID:
 <PAXPR04MB851036B2BE8D3BD2DD5CE5108872A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
 <20250617-fec-cleanups-v3-3-a57bfb38993f@pengutronix.de>
 <b6687ad2-1fd9-4cb5-8f5d-8c203599f002@intel.com>
 <20250617-funky-auspicious-stallion-25f396-mkl@pengutronix.de>
In-Reply-To: <20250617-funky-auspicious-stallion-25f396-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10539:EE_
x-ms-office365-filtering-correlation-id: 0c5978c4-c0a3-4c1b-8119-08ddae07df46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UaS3TX8Pz5cf5mNRqMEtUtmaHfxY5jt3XfYquNbhZYH2jShPAvPwuFPpRGcF?=
 =?us-ascii?Q?IEIPv2isdCaRSur3hfE7aMxxxB0p0AT0ju+gPkNPRSewfOzhg/ZBLCVwXaDD?=
 =?us-ascii?Q?jUhvtAuIXpM34YD0suoFTAJoG2O1l3s54vRQlS1UY0m6BGDLiLKqJvQ063Cn?=
 =?us-ascii?Q?dt3qIhxwBtnUAVr8L6jBfhf1pJ56OyCXe+7cuDOid7w92rcICZ6Q3C3Car4T?=
 =?us-ascii?Q?bt8UviumuZZpDTGVvOXqCutkhWYMsX44ScT6kewoupy5VoQsqYucesUQcc0Z?=
 =?us-ascii?Q?W2tMCzOsU2/nNU3thl7Pue2Zbfa4PTES6uMgZDKgqU8/oJjuX9rGSkDGJPBK?=
 =?us-ascii?Q?raRTzn61Z5oYTQpeMPR+M8DLZvs0k4cKp0Y1LqWX93xJ8J0kT2CgZO3oC7Iz?=
 =?us-ascii?Q?OlG9oL6Ay6N//uBOrrl5n+9BXTNB2SMmWF3n0VOJd7Adm47ATsJxd5kNUJLH?=
 =?us-ascii?Q?9uBKGaqrzfD3TL6DCO0bX/zqloN9zIT1lBt3q6wBgtd1/fDGEbf8qIJY5Ai+?=
 =?us-ascii?Q?YAFQ5M1QzerOXU4Fe/fR5TGO0VrE5zyRmOXwkk07JkC5wj/jLn5g1DzntToN?=
 =?us-ascii?Q?xoLhGa6y9ZCnOiukfVZ3lzO8UfpgE8FhACwjR1ONhWbrHZK86aStd1pbJCUE?=
 =?us-ascii?Q?YKKXnP3zRh+7Z50HYiHxfEAqIDceJ+uRhm3JAToFoTDFF4mO4Vdkl4edR+Sm?=
 =?us-ascii?Q?vwRJsvyOzUKdOnwvYp9QVcjdWDT6RJfuCw4Zpz31cvqB34t0VZr1w29LbaWF?=
 =?us-ascii?Q?gjfaBBBR4NQdLMWRWdacbFunD6/JUAnM/uN9wUDbbq7agezEw+Q1ODfvkL4v?=
 =?us-ascii?Q?jfE2JtGkaonjNRGYz2gODQm52dG1EJxKJ4eyZZ2EZvD7gPutnG5UjV0dQhA6?=
 =?us-ascii?Q?AW/WUdfyQBW/WZN8mmIXoX/K4BommBtngqRUXBdtZ/Y+uL4o4TsduH3ONt83?=
 =?us-ascii?Q?FNMg4ORLcN57DU8OXUKwKuoSY4Ssfwock5DPfGIPNj/8m8SWcN9k3PdkX8/t?=
 =?us-ascii?Q?yPeO/QAyJlN6F6ZsXqCYY+JV3dfevXahOR+xWFTY7KtxNJDvf9rS99SMtQxP?=
 =?us-ascii?Q?wqNBOislonlbDjWdBgujdikv5vXQolRqyF6FRcMSRSzAuDrP96C6ftdUGqLy?=
 =?us-ascii?Q?alEqcja+iT/Dl0M6HV6z94Hd0I7dIlamkZEkRMCMh6wnLvtsZm/Z934XgyOn?=
 =?us-ascii?Q?Fv6344fzL/bR3Dl5tF5SpSfEkjgVH5XPaRmhdHtrKMvWHB1nIYuyW0G03u0j?=
 =?us-ascii?Q?hkFtHOYIbrkCESRgAzPaGiuQqeqfPrDdeQd4aO1JPsqC9b6xJXuiOTDIRa9N?=
 =?us-ascii?Q?CIUCoFS6U4Qy/EXjco0e8q38R5UexRn/oaVXo1p5z3nA2LeEojpJyYXQVHTi?=
 =?us-ascii?Q?ZS1PO05D4RfdC+dDuam9KDCy3j05xiUpfMD12tljBeCK/Uegi6uAy1dgpawE?=
 =?us-ascii?Q?83y68DjZlQrwT7zcBOUZZ+Gyfj1ugtIBJQBdFArPdmGTgVxIiU0osH+93i9y?=
 =?us-ascii?Q?UEhe7UEgg64bJ/0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aGaaZSgz2cHBOqJB/dH03rnwnHxDvNbJjgaOmk0axtagYLojk12yjH1aLVpF?=
 =?us-ascii?Q?d5UtBcDdJqIYh8ZtIk6Sq8d7jHJRR515YFzZbGnOXcmPjbE48jJB2tyVgHn7?=
 =?us-ascii?Q?Zmn3eA9I9u0njgq/3B5y4cMH5U4xGOVGLBUR0/akF+nCG3Tl7QcAc2RiwKQp?=
 =?us-ascii?Q?yb7YdkcULugXgyDS+ZuM32p8y7ZeZE5sfLFdFXDVafYr5zGsSBIUM4zNYaA0?=
 =?us-ascii?Q?s4b5ZRBkSLrkHce5LT5cLqwjEOrhadly2qVqupjCGZWMljMXpQtUxwd9HF8v?=
 =?us-ascii?Q?lW2lEtOeINvPi23W0DfIfX76z5axRWvFBIOYJrTMLO642HVFBAFGdYxelFGd?=
 =?us-ascii?Q?2XBJWYpfzF2FyBMnYvLMODbqqIvwCLIszDeEwzeBdPj9TTlwtxgWXtQJ8j9B?=
 =?us-ascii?Q?wqj9ukGNMP96wTbowu0uo7DfWWJsIkmois8gYTKGw+TEa9h6KbtJaU0pLH5h?=
 =?us-ascii?Q?StqBWgMa/JWOK1r43iO8n3O5P7+66mx6mTm5QbNlyxsxTQfQFFK0/4qVNCt5?=
 =?us-ascii?Q?QY4f3xJzE0EqHAqDO0xoXDI7IIeegLWfsjGJK/38f+ILazDuSMMAXwQxw6UY?=
 =?us-ascii?Q?gEJOY92PtG+cANmpqMU9b3RC++mln3X0Ds1NARtQZrYU/0WvsEYeWbhH1Quj?=
 =?us-ascii?Q?btYGnJDqyThcDdT90is6kXcXR5CZeXh67ROLVJIcVXCIFpkPPAOKeISd82lW?=
 =?us-ascii?Q?/QDc6nfakn/ktbcT3+RAXjxo/gq4YCx0rmPmvrqO5R7q2rNMCodsOhwslyVO?=
 =?us-ascii?Q?E8BqZ3TN6+2AKLpTHjqjsEljXWoozHRqXkmPnvJYBrsK7/bWQop/u67FVjV3?=
 =?us-ascii?Q?VT08aXaANw7we5lj68Q26dHO6RZazkbk3JSzugF2PNGJSBpzp3yPf+M43eUS?=
 =?us-ascii?Q?rSPbaOX7yfr9xXWzifTzc3MLgxktakZMi/RiWcv92e9mU9EbF44TginnrxMJ?=
 =?us-ascii?Q?T/l1d5oiMg1vgf0tGlHDTd7gCeXRGASkE79yBqGn2bjMokCiqdKBypQXZXPK?=
 =?us-ascii?Q?3ZAdAa3tgoFrYkCtt2Cg8RUEjPZkBj7xS7BADYGwf3FQMgJXJopUMKjKoBkd?=
 =?us-ascii?Q?UNoRQ2Y1Ox12Gq0+alLXOX7u7DdH4vz9P6+qbEwxdgIVI31eK9vjVSuxoEqt?=
 =?us-ascii?Q?UkHSQSoYG4yD44cZ4JDtzgk7fhJawcUGrQKuL+AySzBRjUJ0eF1PfAyVe/Z6?=
 =?us-ascii?Q?kyLAj1LxT3OuxX3CENM4eDIhodb/dxmSRBva5EM5bydJLfrMWtWKii022cFe?=
 =?us-ascii?Q?oEvi+5KgAf6HLGEJFyJfp3+qKtdyPB6LGXIoSwil+FyISLetE+UOG6DDCVql?=
 =?us-ascii?Q?Hl8tl4u2Qb+L4M8Sl29Aqbggno7HpDPg3vK6zhIXdw6TFA7s0pef7iCciYva?=
 =?us-ascii?Q?sUVKOXnxWNbL/EvYeh7/hY/48JsbQSTi/ll3e1oOajhc/RMlzVejiNprjCfu?=
 =?us-ascii?Q?gFHvZhTIAgfcG9yfZZj4GyFMHpjKeGLFTo6aJ4VXvOCeRtcCaEZfEYiUfwLi?=
 =?us-ascii?Q?jHgUxkfNc4r1fEAHP6FNJqpa8Loe+mzf1HbhwcRk7UVjevIZ1iOz/rrcL2BC?=
 =?us-ascii?Q?Z/AQFF9k7c/jdlcfa48=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5978c4-c0a3-4c1b-8119-08ddae07df46
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 01:31:38.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: moxtHoltHgy1JnEijim3QodwN1PkHdLlcZAdhjDiVGA1RSo1V17kCIbkBQ3gdfiyfwjtTDunVZdvmxZkKvjjtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10539

> On 17.06.2025 16:55:19, Alexander Lobakin wrote:
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> > Date: Tue, 17 Jun 2025 15:24:53 +0200
> >
> > > The fec.h isn't self contained. Add missing header files, so that it =
can be
> > > parsed by language servers without errors.
> > >
> > > Reviewed-by: Wei Fang <wei.fang@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > >  drivers/net/ethernet/freescale/fec.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> > > index ce1e4fe4d492..4098d439a6ff 100644
> > > --- a/drivers/net/ethernet/freescale/fec.h
> > > +++ b/drivers/net/ethernet/freescale/fec.h
> > > @@ -15,7 +15,9 @@
> > >
> /*********************************************************************
> *******/
> > >
> > >  #include <linux/clocksource.h>
> > > +#include <linux/ethtool.h>
> > >  #include <linux/net_tstamp.h>
> > > +#include <linux/phy.h>
> > >  #include <linux/pm_qos.h>
> > >  #include <linux/bpf.h>
> > >  #include <linux/ptp_clock_kernel.h>
> >
> > Sort alphabetically while at it? You'd only need to move bpf.h AFAICS.
>=20
> After sorting, the incremental diff will look like this:
>=20
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 15334a5cce0f..1fe5e92afeb3 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -14,16 +14,16 @@
>  #define FEC_H
>=20
> /*********************************************************************
> *******/
>=20
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +#include <linux/bpf.h>
>  #include <linux/clocksource.h>
>  #include <linux/ethtool.h>
> +#include <linux/firmware/imx/sci.h>
>  #include <linux/net_tstamp.h>
>  #include <linux/phy.h>
>  #include <linux/pm_qos.h>
> -#include <linux/bpf.h>
>  #include <linux/ptp_clock_kernel.h>
>  #include <linux/timecounter.h>
> -#include <dt-bindings/firmware/imx/rsrc.h>
> -#include <linux/firmware/imx/sci.h>
>  #include <net/xdp.h>
>=20
>  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> defined(CONFIG_M528x) || \
>=20
> Is that okay? If so, I'll squash it.
>=20

If you want alphabetical sorting, I think it's better to use another separa=
te
patch, otherwise you will need to re-edit the title and commit message.


