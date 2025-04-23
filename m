Return-Path: <netdev+bounces-185043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A69A9851F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45133B8C9B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B61EC014;
	Wed, 23 Apr 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X0QwC9CF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC95242D73
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399629; cv=fail; b=ZQTrcIjoUqJkGjP0/RE0wgMYXJgta1abfKeQcO+Seea2YZbVUDYi4M0Z9cjck3WNF9GZYgkLUVpm8JyPsqtwXk5dnp8grASFme3mjoX2ic2WkCmIoedNJ3fdhfEG9Wl6g9MaT08BVcTle/aMvKGVz7TtQyXh6UBtIR5GOYPn3zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399629; c=relaxed/simple;
	bh=AuzoaMZwt3VOK3VL04D2QR/jiAR+hUNFVwb9bos5piQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlzrGNZlH9DS4Rgu/AhVlQ8gpQXlTdpnTbmlNeO+JzoE9x6x0MnvCmVEiupwS+4R6aZdUHqLwyyr86DpLuqGNRMnGCJdlC8abDxWU9HZuwA6YapBT7Tp5sPTz/u/JU+y9bJquZT64Pes5NfekGEmqhyld4KdAaUs6F5US22uHTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X0QwC9CF; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYT14JdbCcA15kPiJQe51FUnnx3GpV2WvM/fy+GxguX3axZPHZbw8X0nghca2lVsfaDDdqF8GML3qUO0PCBiC6B4nBR9IskrQ7zOVIFYpM0H7koMDzD4Kf3CwgVoXrzdsnzwFGQkElVrpDn/gw2ivI4sQva4eJsvPCgmdmIMHXb6o7E58EhDTn+sypfKlB/UFdVSTqCpsZVy2haLcP4PmJnE6m7VhxO9H/EVZWaBggKepwiQH0uCVjl8pFsQewTFMnx1gh3n9E4zI1c2BPjIapbD6tSQGHpTEYHNeahK/aLVJbui2xQjRp1JILWvUXbSYEkr2XY62QoIlj+6WhuOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqlG6AZkKZ26fyZV8vhju/hcSErs6Me1F390IYBhGOA=;
 b=o74B1NQQoxx698T257z02Gh8sDelqhl55Yj2fFXdS0U46Yi5N5NDMnAW9jFJIq6Jt++uKohWGJJdnZbqmpTGiy7HDTsxaJt+Y4cDyTmRJni1ZxsAPUS78T7CDkX2r60L1DRUW/re5WdGmQ2qF/U3Yxes22Of1M1iP4I7PpH77KRh7iRrotRXmAGbah4Eek/+eL1h3VGMp3GCNTjI6DyEyltdpJ52mQ5DYWlWHgPSVNytZqpVZJLNzpU+NBTPizMZJ9HEAEGaE+IFQLVHzCPcC4HKGGZfcSxwqZyNMwcOj3vedcjUXzSxXxyr6CXLdspgTW2eBsZRtWaKl8sx14PU5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqlG6AZkKZ26fyZV8vhju/hcSErs6Me1F390IYBhGOA=;
 b=X0QwC9CFY6IhvMOcfOm/7jh61z4owcQerOUzOwC/Ck9HbR7cpux22Q6jUMzOZMggCBUFujpwmRcdsaMT3PF/HKa3KgeVgQSXhw+3qaBK48eSaNabORj5BccFCb+hZK4hV2kRYUwotV9jlEXi6rUNBNjDIJYRrGVy/IxL4RMi3V3N/yV2rrEtZBhiTtyf4lM6AQRE0I3g837hVl/th4TVqfLN46t2RnSehIGLQTKqOO1x6/S4DDHl40iJ8/qf1DueN1F2D5XzywNQkY+PFpU3jWfcVZfFAQuGv58lrtublOElU5qQvqgO2QaF/enfpTUAlIdaYopNJsL7Og07bA7fOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 09:13:40 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%3]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 09:13:40 +0000
Date: Wed, 23 Apr 2025 11:13:34 +0200
From: Thierry Reding <treding@nvidia.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio
 bus idle
Message-ID: <afcvvloverjh5nadfbdkdel2dklw3yo24uh2hkmc6mufgiub6a@6esbora2xwgi>
X-NVConfidentiality: public
References: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
 <20250422164230.5ffb90d3@fedora.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bojl5qceuzyvinks"
Content-Disposition: inline
In-Reply-To: <20250422164230.5ffb90d3@fedora.home>
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: b67cdc1f-e99e-48c6-27ce-08dd82472350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GaggEY/YnugWMU7Q/SyTafKT8JC3EHwwNvu/ZyipVyGptlFCBFh+rkHWWfs+?=
 =?us-ascii?Q?cxTC57Y9KYZ3Yydv8FFA1spuCseh3JWw2FDOAOiPOEL+VCpXCaECPViRNgnc?=
 =?us-ascii?Q?K3UD8yIc82QBitOGgC4yFqm3e7LTjg0khuLEb2FU8HUBw0q5rmd3KX85OvBM?=
 =?us-ascii?Q?N0pb8OVjfbekdqQLbpuce4tIVM5KgjhVyI0dq0oPZar0ig1DRHu5XstYOwlE?=
 =?us-ascii?Q?TxUDxzZ6z8GOYAuoEukx/ipJhm6GuWBhRJnTw1tc0UMtviZI/z5x0kPc9dJY?=
 =?us-ascii?Q?AXMcBOBwFtb1fREFegab1ViX4yCPRzYjF+mQMx1T5iAjOtp0N34hETwLHMdP?=
 =?us-ascii?Q?MnP6lwWdR92F5g6H7YRvA6IhLSvMQLic88p7R/mfm/u5esxO5WKZmi/FQkpn?=
 =?us-ascii?Q?IRUvw+/be8za6R++rxIv8VMHa9C8a7y+tpwEOqLRge+NKvILthOo+vn3Gwga?=
 =?us-ascii?Q?MjP030JgjPxkHkJH6pEgVScmiGrxjjZYm6KsKEDbZge4815v7B6dI7z6L6ji?=
 =?us-ascii?Q?cDQc4FfQwvQnippFa7g2DWRdbUnfuE6V2RfwSQCkU3xYr3TmNCpwfTAH2rZX?=
 =?us-ascii?Q?G/rDdXRhf92bu8hHP0HDspD0bGUweDnKseZlp9bFpyk0edPzM0nfxOmZiymS?=
 =?us-ascii?Q?nFP0qnXSwybOApNRalSCgoLNm3jVJhyv1VIxTyVksM3WPGFYK67D0f/qxhlU?=
 =?us-ascii?Q?+CkmtoexlD8/ePRhG/Sm/IQ1x1GjfgDNlM7mdN1blzIXFkQHDCvCqViVUvij?=
 =?us-ascii?Q?Yi79ZhF/s3h9dslpvYLrTRFQMG/iaKOcAiiDI+VKt8hxh4c6aspTAhv779We?=
 =?us-ascii?Q?qp6dZapk0wVVpmgtbzFZz/mnd5ChA8eBf+byjMIYCBPGGUIA0Vya4m5vRTMv?=
 =?us-ascii?Q?XCPIJgbw0c271RFQnXQTIwkmj3Igy7QiZr2xzb2H6D52zCbBcQFiyljKY3i3?=
 =?us-ascii?Q?SLYt/DbYaVDjNw3RpG3z+XeMyWS16L3R4qxBlzsBruhUp59pxp/6TcUfVXqr?=
 =?us-ascii?Q?MfbTqWAbd3MvZRp6QPXvhs0fosKoXm4mXnok7ZZgJWyBd2s4ODYdbUoUWXw0?=
 =?us-ascii?Q?yrvyanY+Be33Tih6suDcQTjyfbmc/publaInqzTrOgQLMkr7Elq0EtSyICAk?=
 =?us-ascii?Q?NGvOpSpc41HjSlskofkdN2hO8NVudnHZGw3suDENa2M/9tVUp/pvrhGCNFc4?=
 =?us-ascii?Q?mFzBRhVpdBueNE5GbOPlU6V5Qk/lR+UOkuzgExyYwtk+vv/RgrTWe1yHin1G?=
 =?us-ascii?Q?Z6qsuoGN/zl/ca8qSRuB7/SSFeI6JNvOOvzNifpTQ6GfSx1Z9ROSMfzGpjJr?=
 =?us-ascii?Q?PtGCRICLnXHQIZCq3veN9ty54O/mNFO5XKoE0ce3cxTXX5O8qrzm7kZI6LlQ?=
 =?us-ascii?Q?aBKflRARA2QNZl7xF1ubGQFynb2vy7uZdAgFAEdVCCKTovNk6RXSaxDp3laM?=
 =?us-ascii?Q?B0kswZgJimg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDDXfxPvt/YxWpw07WqwLhHNlNFUv5LUnsq/h5Fv6mSnSEVoWrYpRDLNdEy0?=
 =?us-ascii?Q?5S+fweO/jCj836w6GmzVXV5JaArYL7rNTaAX1plvzrbsZL7WD3ZQ5rD0MCi3?=
 =?us-ascii?Q?FifkaX0PWnmD2ua3Gi3qLAdz3OYo3h12+EMDzqys7Ed5QghdAdvFUAbKZM0T?=
 =?us-ascii?Q?b/ph5sRGDhMrO5XBjs1RN7w+ehVXlULjHM5FYcatbILji5mQ502lPBe98XFN?=
 =?us-ascii?Q?nsahXaBKqy/9leC7ymFyYdVYkyKHbkk1BF5P45VhoU0Pfv1/xchhJ4U0N5uP?=
 =?us-ascii?Q?bQmf52KqmIFONKesDYTXgDKk+a9ffKWWR5H15FYYW8ppuVueFMIpgBoXzwbv?=
 =?us-ascii?Q?oj7f22rlF4Sqb2zDUFKdsaB62Bz+2YHwvXLwL+xfWy499yegFdiiHq3wGDue?=
 =?us-ascii?Q?3G3mtt4/EcAgSf33JGHEH+j5OxZS0I73cg+QtsHwwSUlw6vZ8fffCMZ3FR3u?=
 =?us-ascii?Q?bOpSmKHqBvR8RV64b1Q2EdBR1zeChRYbsbwLDPju9z49Jn//SbOk1JNmYRiV?=
 =?us-ascii?Q?11SNJ6/tUrGt0Fk3KBbiFBzfDdhF55DEfj/wwjMLyU3KqWc5mce9RcN2xjWs?=
 =?us-ascii?Q?xwtnokD679Q3k/H3IzssfgDQR+Uvrauc38Ph1obssJIkqdPrRAGV9D1qamWk?=
 =?us-ascii?Q?NjmeGVhHET35DRjiNr0HCBu7IJijbTLML9/J5h7ftUtQwSYRK/Vsr/9J5oKY?=
 =?us-ascii?Q?WkUFz4beSg8J2feogURaYpNg1ZiW5BHeYJ65iNFWUUgj3Y4ze1H35K85Insc?=
 =?us-ascii?Q?DQfdljgTo8VkKu6BmZgi5TQG9T0UQyCgdMsMc+3VMkq9SjtHB927BhJ6Th91?=
 =?us-ascii?Q?JafzdEv1AWv+Cwdz1trr6gobxvSQ++WsNp3P7M6ebzD7PXcVgJLh+rxVwciM?=
 =?us-ascii?Q?wkoX3mH/4rYdhS15Zp3ljUAJsxgYbT8tg529tM8h0h8FjO2b6GxSd2++aBAp?=
 =?us-ascii?Q?3o2i6/mGW1PICKbSDFfaok633k/APEDWOGSYzQP0zy9PsxZjDF0bj5TUWN1y?=
 =?us-ascii?Q?U4vFZwzK0lpyhnqa3XBUuHObETQePmTSxQ0J46fM1gX13ZKoLay48OMPC/wp?=
 =?us-ascii?Q?xPLyCDWuD8LvWYO4NTSEyX+yJgYrzmy/K7n/G8WnWxUlgmh5Xtfo9Ef8cCot?=
 =?us-ascii?Q?3YqOCl/65Gql7fy3vnsyWyqQLQLm5mUowJiE/tYPycdnro5Fyay4l5AiUzYn?=
 =?us-ascii?Q?Zahws7LUrL5m97cEzb9Qh0ozf12/QbtsMBW/+brrSyh5B54X9UsE6dd2Nffv?=
 =?us-ascii?Q?QIbSXF0Lb1xqrMmZlyjK9dcLVjVHnsL7Rq8aZ5NhJB08GjmwxKh9dyIwPFtA?=
 =?us-ascii?Q?Z0GVj5mxXGldhB8sJMlworwXdQeyEnsmE4lZaTIKerey+2OftJZ6+NPNK3Ub?=
 =?us-ascii?Q?sqw9ZJ0AZ/wtn5Tys2rkMqC9Y0FS/O5YrspEIdZjb7w248mhU/OIo/HmpwTT?=
 =?us-ascii?Q?+eHnRmM3/Woi6Ku1zl2WMUJtI+wwP871QPvxrTT8hIj4vxxFEhBJeAWkemW0?=
 =?us-ascii?Q?Wo++ctq3rtnym9iyYgawxlG3PjmIT80V7gE0Z7a02FRFPgmEBIo2+hmzuO0r?=
 =?us-ascii?Q?amOlhNT+R+Le8nsNmbHaHU1uHwfFRMEwlUH1oYddHAmZJ9JkjywGQn5bX066?=
 =?us-ascii?Q?oxcy8jCWEibtpIdkImQIGZSu3fF2vAw+3ZAlQriJTuxx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67cdc1f-e99e-48c6-27ce-08dd82472350
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:13:40.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IAFH4DvIS4byUB4SblC4lCJpz2zju345GI3Zco+cLAV5EAkK1zPj0op+jYWUxABe7H1YVzCEs+LMFM+RN9p6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182

--bojl5qceuzyvinks
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio
 bus idle
MIME-Version: 1.0

On Tue, Apr 22, 2025 at 04:42:30PM +0200, Maxime Chevallier wrote:
> Hello Russell,
>=20
> On Tue, 22 Apr 2025 15:24:55 +0100
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
>=20
> > Thierry states that there are prerequists for Tegra's calibration
> > that should be met before starting calibration - both the RGMII and
> > MDIO interfaces should be idle.
> >=20
> > This commit adds the necessary MII bus locking to ensure that the MDIO
> > interface is idle during calibration.
> >=20
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>=20
> [...]
> =09
> > -static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int m=
ode)
> > +static void tegra_eqos_fix_speed(void *bsp_priv, int speed, unsigned i=
nt mode)
> >  {
> > -	struct tegra_eqos *eqos =3D priv;
> > +	struct tegra_eqos *eqos =3D bsp_priv;
> >  	bool needs_calibration =3D false;
> > +	struct stmmac_priv *priv;
> >  	u32 value;
> >  	int err;
> > =20
> > @@ -158,6 +159,11 @@ static void tegra_eqos_fix_speed(void *priv, int s=
peed, unsigned int mode)
> >  	}
> > =20
> >  	if (needs_calibration) {
> > +		priv =3D netdev_priv(dev_get_drvdata(eqos->dev));
> > +
> > +		/* Calibration should be done with the MDIO bus idle */
> > +		mutex_lock(&priv->mii->mdio_lock);
>=20
> Can't priv->mii be NULL, if the PHY for that MAC is connected to
> another MDIO bus for instance ?

Looking at the code, priv->mii will either be valid when mdio_bus_data
is non-NULL, or the driver probe will fail. mdio_bus_data depends on the
presence of the "mdio" child node in DT (via plat->mdio_node).

As far as I can tell this is always the case on Tegra devices, so I
don't think we need to worry about this case. If it ever wasn't valid,
I'd probably consider that a bug.

Thierry

--bojl5qceuzyvinks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgIrzsACgkQ3SOs138+
s6ECig/5AR+d1rriQ+x5NAT52DiKibV/vTOKstAo10Z6rhSnIjoxvyw0kbXur+Au
YNTv9GGl3tkjr52wUqmP+FVqUUWkDVkicMbzzYOaT2HR1RhhjhoaikyCU4QfKGVW
x2wMDNz79ebfvAwhH9zQ1QWQxLU0YhMUo3HWg9302r8/29WgxzwOYf3oX+YhWuN3
sFoZEOP1LD2nKsE6OrD5HommypehqBVVfrbxwJP1gsrDg4uGTZFHjTVwfcCadvWq
Xo4/bJHju8DhjHsERsWlVDTmF2SGkD4qmajkwxiCHUAJ+xtQEshtepugtXKbQUO0
ZkZ8NpSXVdHo7Gvx1uLGsVIRglN5cH7zOm1qrYMGndm3+gpFKhKY9ai/3eg/ZJ9Z
tImcZQJxBnpETCRJqGJDS2YKitDyVbxDHFIMRapgUjK0XanYxsIQhHnM+Stfq3GR
GM//L8Ig0JJmJkLO5bK/poJsRMEH1/RWmmF+Rn5d+K2LOwzDU1jdbXhFQTs9tBov
zZpabeQLKoZNfp2imE2C73yhNnx/MZUDO3X/ebg6iHLwo16Fhit5xT6m2E+tX9ki
TJa2QgTiUoKMhvAmGKkKAmwLKtxgVe3lWFCIA4awbwur8Czvwvq6eMdP0H+Vt1LJ
+mWbvY/KE7WXkh9SGIIANFQedvOGAE5+FUcQrasMX+B781MyOws=
=1IIF
-----END PGP SIGNATURE-----

--bojl5qceuzyvinks--

