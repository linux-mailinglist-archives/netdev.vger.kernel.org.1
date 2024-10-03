Return-Path: <netdev+bounces-131552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6414F98ED3F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E921C216B6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBB14D44D;
	Thu,  3 Oct 2024 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4V9hIx4j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DF13B586;
	Thu,  3 Oct 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952338; cv=fail; b=TDqWbMcuzbvPhHZV3D9jjx0VtZr9DNm9TfC5G6oNV4vbwTMaEMK3HsNqtRuqyY7Y32/L7VRTRrQCtfR9kxpLAEjxgqQwxWrv+5+xWR9s+dpRD+vcfxCuFJhhYBSWVrZXLZrgycm6XP+uK20IgtmRC5C7P7JbmNe2mc7hNt7ZCms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952338; c=relaxed/simple;
	bh=4ZsCKnJ4bdirs/XCNwMwqD1GzpU2mpWBoJfFJ0elJ2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkSFI9aK0aWYOARTiycU6Es6/CfE7DWJsjzwDPLL1plmqlkzx7ot9Nc1EmEWpTpuon8pj9rNmB34oyzm41FOkKpkWmLYwRm/2Td3R2sw1leP8Qi/dbdD1IxPvl9FlgFWr2biTZHdYRv7oms3kCVS5esFfFKHDg/Qzj3caFUWctA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4V9hIx4j; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMKtifs+XU2hQUXYXt1qDffso12jrHgTHhRiK5/ZS+IGS+pK3QnVZWoAnAeevM104hmz/37V7G0FV3KAa8YlT+4eOvEvXqEBemkcizcYTjqrl8TwCQupcnhxTEgCg2IEGRxOAwUF7NxxiUxeTIMiYBUXUSUfLDqQxbs8mdr3qehvn2NdQG5BXrlGWDI0PJnLLKFEUB56tHFWrtDXrwaI396yUDRh+dnl1JAmZtLx98ftRM0wZwiDKl8tI3h6m2V/yLdmJcssC+OTOXgwByILzlJsTtgtCEDwt1o/05ULV3f9Vxvdl8nDwOV23jzakvXoCtLF3cgEWmRefKYG/grI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rdfmWh31ZoxQ7wieTJjk+bV4kfW2pC/+C2Qn/QQ/jY=;
 b=n6KLeWULbFwwpn83DlwAusf7W7dgrEhzV7GntlVsSmXXJ+cawWGfMrdSbfkFo2pnyWY3d2uxQ0eavFvBjdhFhO+0M9ZLeTBoK4K3O1GF+X4izNGsd9FjGS4Co/EQj5AO6LfAZecfV2w8CxuQcf+nEgST6RRVk7QcjkUgMQGgl2qT1pC0SLWlToMMe7fCRnRIsYk7dgoxnQZEkc+Ukd4AyV3Tqpn7VZy8fKwdz6WZUY4UZzKYIkV8AgKxPPBtxOJs8bhJn373Z/BLWM2U81+ax3K+vF5xCac85faHnowqVoWU60I1zMifaL62JV1IgsEGKAR4qjZYQGUQx2gGx+mgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rdfmWh31ZoxQ7wieTJjk+bV4kfW2pC/+C2Qn/QQ/jY=;
 b=4V9hIx4jIm5EYHrhbgcmo134mURZieJRBlODIvQcF184mwSVZqLMVQJJDitqrzBdXDOPQxYVAf4d8x785DlBqTQGrmpgLFy25NupJFlJsF+fbZ4A8+waLPIQ/w9jkjNPsVXKxCJMAgRauS7acp7InlSyRoVZpTtUlXBqBx9Mpc+yFNhGXU57n6t9KoOTZNjIAYNs78cs6cPJtqVBqRwBzXFLZc3A0tJDIYqfLG6kfQqqA/iBGq7WcokcDkGw+HXrH99s9NqpP3DTZVjPP0eEwxf874QAqccnrehWqBnNgBeiM9nDiRkBTRMdvguLtyYtinh1MNwLUe317jT4g+kyQg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by MW5PR11MB5884.namprd11.prod.outlook.com (2603:10b6:303:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 10:45:33 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 10:45:33 +0000
From: <Divya.Koppera@microchip.com>
To: <o.rempel@pengutronix.de>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>
CC: <rmk+kernel@armlinux.org.uk>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux@armlinux.org.uk>, <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next v4 2/2] net: phy: Add support for PHY timing-role
 configuration via device tree
Thread-Topic: [PATCH net-next v4 2/2] net: phy: Add support for PHY
 timing-role configuration via device tree
Thread-Index: AQHbE9T4y7pra0XwQ0iEI8qLzFg6qbJ02gBw
Date: Thu, 3 Oct 2024 10:45:33 +0000
Message-ID:
 <CO1PR11MB4771369283470D35EB5634A7E2712@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241001073704.1389952-1-o.rempel@pengutronix.de>
 <20241001073704.1389952-3-o.rempel@pengutronix.de>
In-Reply-To: <20241001073704.1389952-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: o.rempel@pengutronix.de
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|MW5PR11MB5884:EE_
x-ms-office365-filtering-correlation-id: f7c20a0f-2b93-4560-cffd-08dce3988200
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RnaDcCHXNc8WGVCmfLwm2jkSEJufWAatSipmiYnIENSIdRGIvSrlgHGUeNqz?=
 =?us-ascii?Q?NMig6ntRj5NAlErrmziKCMcvL418YdjBQ7SOcoyqLZpG1SgYCnbRq2G1QDBp?=
 =?us-ascii?Q?BN3adCs71FQN+YgPZ2NeVEakP0QNTYZHMysx/gGOLIqfjOWOrxtomqHg9w9j?=
 =?us-ascii?Q?53Zw9/GkyPWoIGXVC68azIK33WKQZPmoPoLX3pI5yiNQqAVMrdyUIPzq+f8/?=
 =?us-ascii?Q?h6yIeQpv7d5D/rS2RIUOufVvnxzEBDOlejsq/cesu7T2vMZapc8+/b6JF5Nx?=
 =?us-ascii?Q?jc3WFSAjGjiCqjgXx0/UzH5HBSxLlMUI79HABuZ2+IbjQ5veANgX2ywAj3q8?=
 =?us-ascii?Q?gytDCawScM3HYfSGY5pKNjwZMnR32HtFokppH7ktEG7nFJH5wpXsEF/X/tLU?=
 =?us-ascii?Q?cKuFVwiVjxGhDAIZv9YfNqiDZ2+bh9RgFkwUS4vafgcc1SDxfAbJtFGrzaZw?=
 =?us-ascii?Q?gKzLrZPvBvfIjLnh3VDQS9/Nztq7JkKfcQRyNrjCwmTtLurW0Kxv6oNgca7J?=
 =?us-ascii?Q?5wGd03EjkgNHxTGf4X8TZhN9jjx3dyfs8oLsXfY1dWh09AG/u8amBwoAZBMt?=
 =?us-ascii?Q?n2xryTrYtBlA8l3X77Wmpw6UhU+MT1zwOChaB7O+J1ZRlWHc6bFI1d1bEdwh?=
 =?us-ascii?Q?dEugks04jJbEsljIWulmID199WOFBYeqjaHpyI053xUlXkz1kBtXx0yl3saR?=
 =?us-ascii?Q?WxEjnEerztoa3GzUxVlxeushlOZiV1/DrxjKRDISbcu+uXY9KwakCAxGwBx0?=
 =?us-ascii?Q?YiOXLieCI+97Z/6O6M5hc3/TOHNytGQm0aD1YDI/MWmG/+O6xK6rUaUBz55+?=
 =?us-ascii?Q?vof9eyRNFAsdWC/ctDiF4GrpeoWi0rZEoXN7R7telh6ZQf+7m9SP2oReamHW?=
 =?us-ascii?Q?Mi2ILtJIcuV5cFNwSHqnZv1RxoHfbLkcihxrqreOebpn/9F8g8lnrO9wZvy+?=
 =?us-ascii?Q?B2O7G9B5ZniFNNf8jcCYbemQOXAMOT1g61zdqWyJZQw69FWgRhYdROcPQkxD?=
 =?us-ascii?Q?JZIWCCjR5TCsP76l35zrf2hvC1naky4AkIbKaZOPkb+rpZmXFtKl2jiol7H3?=
 =?us-ascii?Q?IopWuogcTSyFFr97UiKR9lk0viAhdwX4zvwczv7VA03Br05c7PkUBFSg//pF?=
 =?us-ascii?Q?kuNAT3afvclQQ2NZFsuWB8VFCRw1qMVoRGFTqB0HVcgY+7m+1Bo6UO+jXZv9?=
 =?us-ascii?Q?9yGNppdywRdESln1YcZjwLXkiWeyYiumxIux4tr8L+EF6luInjwJu6ICFmWZ?=
 =?us-ascii?Q?zTHnaB3mWcayhZMtdA3Ir6FTwwihIXowvwjbBuDDPs3Os3IHEe9xIt/9IsiH?=
 =?us-ascii?Q?psp9CFHJMVAidNjRBAz9YDZRQRFEwMR2dJ+dcgYV+x93K1LNmjwFT+iGOW9j?=
 =?us-ascii?Q?mFLUb8I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vGxpSAQQFUiiSDgNPAdFb3Q7uBUC8MnMDG9f/dpiAoCIzyCqBS15W8YuF8kP?=
 =?us-ascii?Q?IG2xXxZhiBXLu6c/2Om+XaTMLWrUKLqsxdYwIPeuYfYnevwZhVO9kRG0TrU8?=
 =?us-ascii?Q?Ed8+XOb3Gib9gLz6SDGQhoYWqXjnKFffjj7lsfi/aCxN7VGdCsuc2HJf/iog?=
 =?us-ascii?Q?7ByRm54g4cLsclE+qEcbdRH3R4UitWL+BV44M9mksNsq8SNwMQMWojzPR76M?=
 =?us-ascii?Q?u4H1ZlL2W8fezTES9oJfBMu7Lp37cEaOXKgNQMzlDAMTTytuFUpz3ohMQBjh?=
 =?us-ascii?Q?2Y4lzMjI8Rnq7nHnT/HuKXOBgAI0oEDPJvlV/oVnUz7DLrJUFYnMVBK9F5tF?=
 =?us-ascii?Q?4B4GrV4aftYtQOxjtvuztSpyqpsI+8KlINZBlIEcOZt0gbDoT37+hIDiihpw?=
 =?us-ascii?Q?akupndiXyjgkoKkq21hsUSJlLd7K93IjGCSYJscSur0U7xGPsmqnofLompoi?=
 =?us-ascii?Q?MH0mTcibjGSkfXMrcw2qAcovSQuviLQTPv8Nv+XqBfzk2r7nTl6bDdMh2T+6?=
 =?us-ascii?Q?PXpuMknKM386hUrCmuRQ0kkzGr2p8xAnyyk1jQFvTdxigcg4y+q4qpGTg3bw?=
 =?us-ascii?Q?f0+l4jgsKRBhOl2oaqRsukwnGQrU8XL2Wj5OZWKMJxZM6lfptXAnvK3Atcfz?=
 =?us-ascii?Q?e1QXIkzVdIyYPrEAU7dV6zUsjciNKL7WRzGKy3zTyAo+udK0KX0RBzXsgi+T?=
 =?us-ascii?Q?1lXH4HrjdmAzJV2kIbhbxKr9X3EReruZvXnXiI49JnGFNnSEqE/ced5/8ldu?=
 =?us-ascii?Q?1AnTUSnN1AaKWcSNWeeKnN1Mqo0Is7nJ9+nktrP2ct35ffu8IGhLCJPu5u/e?=
 =?us-ascii?Q?IMlJJF5rdHOtvsmUR50O4PXwcuKUnWdTBbTvmVxnB1cF9sP7gUJYuJ94xm8l?=
 =?us-ascii?Q?nitETxEOo1UHQ/tElVa40MI/lgs4QmD/TGDT/kinC39bfAHSwmx0ODQT9mnX?=
 =?us-ascii?Q?k7iIisegVfx7PnC+e5n4iHxmNcvjgZLlf9STjTghoIw6tASxTA9Bv4gOYZ/D?=
 =?us-ascii?Q?jG+rm9ey4hcawq9ik34nAr9aqld5auTFopwafxO/b4dHfJPqvrQRBhTsYtnT?=
 =?us-ascii?Q?g6FzPrDVtnPxpY7b/5RHp2uO03UAkB5rF8XM08DbkVHtsxlIXPKD45drENl0?=
 =?us-ascii?Q?MWVuhCoXJGk4e1t97weSaA96XDUuZhRu+UiAywq7yeV+y2pBQ80Kzb/1sX6l?=
 =?us-ascii?Q?yP8LRUHHYONcXg3LH8auS5xc0wfUooNinqTak/MCGbBglQQzcjuxDp3VYAbz?=
 =?us-ascii?Q?v7w6yQGmMNcXmoV61iXEuIYS6iscgCO6VGkn6GGdGcPuUVNwZ6fVuWf8paYY?=
 =?us-ascii?Q?PTIJQuZzcu3z9rhQEytruDFCABCCii68x1OSUwtHGUTJKZPduZMh2zl1CMrC?=
 =?us-ascii?Q?TIWuMr9sUg3vTJqwviDx5MCsuACT1DxBOcMmH6rVvwAJwJ2gL0VldSrEaokG?=
 =?us-ascii?Q?34HGohC50vZE0pbnlVeUl0jPkXKQVPKI2aLKmb87WJeGV9teyFc/LvAbdTt/?=
 =?us-ascii?Q?F8pvlHo6rbPLW++IXHJKmOaJNjuWYycKmQQv0Nf+HRqTpsin7iYXrjZT0YXM?=
 =?us-ascii?Q?Qh4t3FKCQtTKe53no+nnKosISfG3bs6t9i6G7QzBt/pdtS0ZpS/3sZfb6Gki?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c20a0f-2b93-4560-cffd-08dce3988200
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 10:45:33.5197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfaFd6ZmIDEi7trhY6PE01Y0tu7TOROrvXC0G0g//PAhP4nn7mwY/grc3hQVetHpil96j2KQGiyJfco/sAdiEhlYsLdNdepK5ODcHwuMTeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5884

Hi @Oleksij Rempel

> -----Original Message-----
> From: Oleksij Rempel <o.rempel@pengutronix.de>
> Sent: Tuesday, October 1, 2024 1:07 PM
> To: Andrew Lunn <andrew@lunn.ch>; Heiner Kallweit
> <hkallweit1@gmail.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Florian Fainelli <f.fainelli@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; Russell King
> <rmk+kernel@armlinux.org.uk>; kernel@pengutronix.de; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Russell King
> <linux@armlinux.org.uk>; devicetree@vger.kernel.org
> Subject: [PATCH net-next v4 2/2] net: phy: Add support for PHY timing-rol=
e
> configuration via device tree
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Introduce support for configuring the master/slave role of PHYs based on =
the
> `timing-role` property in the device tree. While this functionality is ne=
cessary
> for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1) where hardware
> strap pins may be unavailable or incorrectly set, it works for any PHY ty=
pe.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> changes v4:
> - add "Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>"
> changes v3:
> - rename master-slave to timing-role
> ---
>  drivers/net/phy/phy-core.c   | 33 +++++++++++++++++++++++++++++++++
>  drivers/net/phy/phy_device.c |  3 +++
>  include/linux/phy.h          |  1 +
>  3 files changed, 37 insertions(+)
>=20
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c inde=
x
> 1f98b6a96c153..97ff10e226180 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -412,6 +412,39 @@ void of_set_phy_eee_broken(struct phy_device
> *phydev)
>         phydev->eee_broken_modes =3D broken;  }
>=20
> +/**
> + * of_set_phy_timing_role - Set the master/slave mode of the PHY
> + *
> + * @phydev: The phy_device struct
> + *
> + * Set master/slave configuration of the PHY based on the device tree.
> + */
> +void of_set_phy_timing_role(struct phy_device *phydev) {
> +       struct device_node *node =3D phydev->mdio.dev.of_node;
> +       const char *master;
> +
> +       if (!IS_ENABLED(CONFIG_OF_MDIO))
> +               return;
> +
> +       if (!node)
> +               return;
> +
> +       if (of_property_read_string(node, "timing-role", &master))
> +               return;
> +
> +       if (strcmp(master, "force-master") =3D=3D 0)
> +               phydev->master_slave_set =3D MASTER_SLAVE_CFG_MASTER_FORC=
E;
> +       else if (strcmp(master, "force-slave") =3D=3D 0)
> +               phydev->master_slave_set =3D MASTER_SLAVE_CFG_SLAVE_FORCE=
;
> +       else if (strcmp(master, "prefer-master") =3D=3D 0)
> +               phydev->master_slave_set =3D
> MASTER_SLAVE_CFG_MASTER_PREFERRED;
> +       else if (strcmp(master, "prefer-slave") =3D=3D 0)

I would suggest to use "preferred" instead of "prefer" to be in sync with e=
xisting macros.

> +               phydev->master_slave_set =3D
> MASTER_SLAVE_CFG_SLAVE_PREFERRED;
> +       else
> +               phydev_warn(phydev, "Unknown master-slave mode %s\n",
> +master); }
> +
>  /**
>   * phy_resolve_aneg_pause - Determine pause autoneg results
>   *
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 560e338b307a4..4ccf504a8b2c2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3608,6 +3608,9 @@ static int phy_probe(struct device *dev)
>          */
>         of_set_phy_eee_broken(phydev);
>=20
> +       /* Get master/slave strap overrides */
> +       of_set_phy_timing_role(phydev);
> +
>         /* The Pause Frame bits indicate that the PHY can support passing
>          * pause frames. During autonegotiation, the PHYs will determine =
if
>          * they should allow pause frames to pass.  The MAC driver should=
 then
> diff --git a/include/linux/phy.h b/include/linux/phy.h index
> a98bc91a0cde9..ff762a3d8270a 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1260,6 +1260,7 @@ size_t phy_speeds(unsigned int *speeds, size_t size=
,
>                   unsigned long *mask);
>  void of_set_phy_supported(struct phy_device *phydev);  void
> of_set_phy_eee_broken(struct phy_device *phydev);
> +void of_set_phy_timing_role(struct phy_device *phydev);
>  int phy_speed_down_core(struct phy_device *phydev);
>=20
>  /**
> --
> 2.39.5
>=20

LGTM.

Reviewed-by: Divya Koppera <divya.koppera@microchip.com>


