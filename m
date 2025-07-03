Return-Path: <netdev+bounces-203910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEDAAF80D2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 20:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A2B1CA37CA
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E2298990;
	Thu,  3 Jul 2025 18:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6SPdhzw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F760291C10;
	Thu,  3 Jul 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568716; cv=fail; b=WlQ8yDuiP9+43+/w6Axti6Rn0KVtP2s74VJ3q3KgzwNdUZGoFbDbrmoxGUNYE/Zrh6pcaOIhquSsexj9TXqaQMsj12uJBZn9vLIh7a/zaE5xifY54FuCrqcbBN6PLNKA3JabEjF3vVxYxur9k+X42yvGwir/LK1AwH5gXBEi/gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568716; c=relaxed/simple;
	bh=dSVGEh0PO/A8kEfrRLkiEMau5tW1+Zf8WKKpvXlRFpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peX5SHtX8ow9azAZhhfuKunPFA/M8fN3CV4OVGo9LnH4XId34NAAR3+t6HnjGYNX6D97GUS72W1LfQS/eQrjsDRkzHNBBxwxl4R55uMk5qJoDmq7YbvsitILZnbNaP0YhmNhdR1If3B2nB+r0SPBIP6AsR0iPprq/SRM6afhXgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6SPdhzw; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3Gf5hfNOfMtmy50UrY052J1weMEPF7DIH7e9A3SrAUFZdmtcv4WyZsra+ztGsHyl33qFsiTM6o82qrpmsTByaU3NHjYHm7mMYOBATyqKsNkQFYAmgi+Anb5JpEAN1p20geQ/SpabwtQiQj50ON0DYk5yGcNz6IZrdEMqvqyd/YVyoKqpZJAJ7ywr9+ipsfZD6+M57S+wmAxuT6aXC6yYhYDAZyHJ30iQTuKwx8yan47e2JwMFhFGeP6MLU7/FZvbq6QHuuG1rxRxIo6cFDISB6wgZ0ZKfX3Pe8Y7uChd90epIhDIrbHIXp9T6L3dp/v4lUTvqLWeg+rViO0fYIfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xep81FPZrtAYp1UnFrMB4jZ5qzLldxdwCp8+rnQ8xJk=;
 b=KndeJOzAMPb5fWcXoH7nBe9U/VBGEvyUALmAwYEuQ2Tp+kg0XgjweUi4nJZ5NXczUQ365uJ7pu0u+FDPcelPafu9xyEkLKtqprK3luXmB4ePYk49HfETtjp+Wd7zZ+q8oGebQHPoYOI7zoyrk2QvGCBcKE4Ufab3iysHIxgxCiVIT/jrOceEpwLerOsJ44tbHv2ey3YmkWPonhX4lzAY7ppzWeHH1FqsxfrVxkXjDpLAghIjhbw0bdz0zXMFuuF6gL3tA1N14x155reV7aGmueLTpwqFuNJZFQQUp/ZkJ9LJ2yqwEFl1zy73KYQgUsdS8jn9klSMnrx6dsknxR1QuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xep81FPZrtAYp1UnFrMB4jZ5qzLldxdwCp8+rnQ8xJk=;
 b=h6SPdhzwxQx3oet5MgQwjbpOOOr7+rjRc9WQMLAE7nZeHcVoP9d0SLtIDDaAR7THaB5STRRZh4xx2tGQvyXOPCFc9bm8nsV+BVO/BUYZsyEFoJMGYEsf00FizTa2rJQYaRP3CRd74Zf7ovUMCPH6m3XlEWJA5rSLKnAsfefToOE99tM923Mk3vnFRAJ0iBUQ/cDgKWBEv6SE3YPEzrhdSmKT1qQSjbPo3wGpQWkouXOCSaPl2oVlBJeAsx/0b4UImfO5p4P64x7ELfWTqP9IMUyJXv0SBgmF9Cg+R+Cim+H8xqrP67fuF+pAsaGQTbuJdxoxlZrcyjv3aDEQA4Lk5w==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Thu, 3 Jul
 2025 18:51:52 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%3]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 18:51:52 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Topic: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Index:
 AQHbPTCwkw/5mDAiDkuucKlF479Xq7LJ1/+AgP/0uKCAAAhugIAAAetQgE7YCVCAAOb/AIAG7chAgAAxwACAAQV7kA==
Date: Thu, 3 Jul 2025 18:51:52 +0000
Message-ID:
 <CH3PR12MB7738A206A5EFCD81318DC463D743A@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <CH3PR12MB773870BA2AA47223FF9A72D7D745A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <668cd20c-3863-4d16-ab05-30399e4449f6@lunn.ch>
 <CH3PR12MB7738E1776CD326A2566254D5D740A@CH3PR12MB7738.namprd12.prod.outlook.com>
 <c6f5da79-df83-4fad-9bfc-6fd45940d10f@lunn.ch>
In-Reply-To: <c6f5da79-df83-4fad-9bfc-6fd45940d10f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|MN2PR12MB4080:EE_
x-ms-office365-filtering-correlation-id: 703d7681-323c-4f40-3762-08ddba62ac8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jk+6Mr0ziE3RKxFhOkKiFWzoE07hOFloesb5YTOOkUjbGnka/XWRK0f/mUkt?=
 =?us-ascii?Q?hRHQhgZ2o6AAqCYvGjCcZB7Q2CN28qtY1Axa2Gf/3VjFKDmayWsiR9tyZAy4?=
 =?us-ascii?Q?0lim4Ks9wedmNzaULGkc83pUPZC3ZbGhOtoukJ4uAGbrE55OzUaKsyBMR4T/?=
 =?us-ascii?Q?KSZtSv2SbeX8noCgcr/dnFrcLvXp/JF7VPYMVkYUbd3Z+OAalLbKor+EFNF4?=
 =?us-ascii?Q?guuRzW5/TAV1i6sNeSKRw2YMP2cxYq0lMX4n1gtbwSbmCP8aaw6wbmgSZBzP?=
 =?us-ascii?Q?sr/uXA8IlkZiJGgoShACdJOm2hyzChxIyCkfEt7YcwXKNXttoNl4k3dv4QEZ?=
 =?us-ascii?Q?Hh+ZBue8+O5kA2dmZDXuWNXBeXCMU7LDif6VKUDNyqI1gKbA8lJnN/ytbcCr?=
 =?us-ascii?Q?zJHw/F1aeGZdN9vZNKzSjJ9ZmqdOM8UTnMshCNi/eepePEeyFdtfGlA91jN1?=
 =?us-ascii?Q?23eEu4ggvzBPZM4MlBy9jz4iG3zk+dmae8Mpy7U411p+wavN82aBWialtxu6?=
 =?us-ascii?Q?cakQoskkdDiZHU+lywF6vIQqgFnlI9pR3k2uW2pxpxf46RU6KqTIpxWH1Ksd?=
 =?us-ascii?Q?EO/Ro7YPiq9Eckwsc5bIarJsYq7F6VNUA0OCB1Y8RLydWLgKv6c3ObalTKsD?=
 =?us-ascii?Q?96LylsdWtk5ZCUgCpIt+MoSGnlduwmgv7IgQGaMBm+cA64DuIhZuF40oi2B7?=
 =?us-ascii?Q?zqI14f8VmQeHiZFv7khw5waf1R9tigFJx3P2BDpgkPi22lM7+pdxLIum/Vnz?=
 =?us-ascii?Q?kvNsQWph2xQ9XfPiYI0rav+9IoZoM9kB9+5bo4qIvHAxRsvhbBAzwQzl8Bhi?=
 =?us-ascii?Q?oNw3VgfMRnebMhN2LGxzSybbM4EZSa4Il9zH0yWHngv06g5/gH6Y+otLirSh?=
 =?us-ascii?Q?j2OqYx4GK6+7tvff0igt1tnGy8RUPSTMQExpikEfyCuvMA7V6HWBsYdA8uh1?=
 =?us-ascii?Q?QTjdB3LIG1E8VYkGER6BmuxWqzREy+kEJpBmijk4z053pCYgZd/OkuE8FeIK?=
 =?us-ascii?Q?SA+DAOUdMPURlfwl+AKdzole6xQyzKd3uEj+EEscayDT4v8GSyOWZ8GN0KjN?=
 =?us-ascii?Q?Dta4XQnmLNU3GfUxbhuNLWGge1OpR6Qirxqi0QB3k4tJzpBoI8U04qHZP4L/?=
 =?us-ascii?Q?km88Z0aRZcSVrLG0jxxCEwswYvm+pX/1MPSC3RVxq0JeCLLmOguEiG2/wQtm?=
 =?us-ascii?Q?uX2eMNRf/Z9MY+tNa2KqN8XeRUT6hnwZYrM2KZSGho009Zy8PUB0CO6rrhT0?=
 =?us-ascii?Q?7NNikSojx6JUnPmUNChchS/sXvReDQraySdzOarOEwPxyhbB1nbvCKaGwBxI?=
 =?us-ascii?Q?RLJWhVfWDpBgbJOXP2rJDvXdiqltLaZzE+1300WulebS4VPVNh3lGDxnnZ61?=
 =?us-ascii?Q?SCV1x69qU7tDTBGrOhnGLuOZsUTrvJrvOrXMgHFsqt9vedbK9Vwjs13WmT59?=
 =?us-ascii?Q?zFznVBvGCEdCgkKjy079dDRZUF3StYrwH0wGrBSGtUwkxwSCeo9fm5q7tGRZ?=
 =?us-ascii?Q?ZWIznM5tlMPm8oE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WZRfqEdhmqTry9PFEym6bPDuvULUw7CBlOdXaHxjBaIHvMQxPJwO4AwoXlQf?=
 =?us-ascii?Q?qyydkHDNgWWtlbvwWbdf3X8pT3E2ejB5PRIVtAj8jKRyPdOY1hCpFrM6AGt8?=
 =?us-ascii?Q?Xvw/9uHarOk6BvNejV6Vki1QtBuwVGkBMGXhkhatXfP29aMmssivmVRX9ZB/?=
 =?us-ascii?Q?+nn+iO0mfarRmMosQWdNlQHHJftah+W9hisqIhkA3FFqUZo41JyIKLmDuFUz?=
 =?us-ascii?Q?aZebmCHShGQGtP07INRzO48dA2xfGwXH9ZJUJ4eq7m0+utWPkrujPPXVkWzq?=
 =?us-ascii?Q?//o8Rj+Is14pqHZ3bukLSjM5vDRYiKp8DVTmMbEGow5hOMdr9EXJOg+9rSNu?=
 =?us-ascii?Q?EtVgl/UINVqMWz7qnZANUDsOslgCwoe4t9JQNGsD9fqEsMch8+rRTGC34xE2?=
 =?us-ascii?Q?G5oiTiLC1RNX2AZns8ZfXiGQegpu6URcpPDNkpm1uq+rnuzDK0y9WmkfXYyb?=
 =?us-ascii?Q?2tS/H78btr8UXW/L5dqLpfoubLBJ0XtZbT4zv+qV8iRz+0eyEVSzITszHx6f?=
 =?us-ascii?Q?+mlps93AJJGF/TxW2H+5SEiISEGGSVw4lWmdV/aayg0KBt1irHVEq2sAOLzH?=
 =?us-ascii?Q?GWh9STTDD9oYF+CZl820fGVbSjd3cVaWdrtiIQjcwuOC2+u4YzM1ZxlknfN5?=
 =?us-ascii?Q?keWAnJ4iuZYImFdEpBmpXYOHZYJfpUzQUBTc6AZpRjcpbZCrDQGLDILuOY1F?=
 =?us-ascii?Q?pPcDEfMvq8+KQKFtIhYkJALRmR3rzo5F8w5RbS6SXzvBLP+vdCFM9LIzHc+L?=
 =?us-ascii?Q?w3ia7PJIbwV1q90V6298973ip6P2lBO5HQYRuEJKehsB3rq6nTYK7sG4wdEK?=
 =?us-ascii?Q?EFxC8GMI2Ib+rM03XVHXoB7iP6XPaVPNPJ246oIg7ZEyMCLhhbJ1t+RlbXpo?=
 =?us-ascii?Q?ZqlsQ9+4iYTSU/WKIe1LswMJndeEOKDuN2zSPnset/RbVtJdKsnLwvA2i5uQ?=
 =?us-ascii?Q?T6MI8yvYsyPdkmHoBBhQtFrVeLx+5eTG2Jthp50qe6iVMjNPLWjzovHiY71W?=
 =?us-ascii?Q?a9aNEzGBY+oQhiS3uwanU22yLmtvmiCs7rSbhli72ziMqQVQgJLgUq3PjJNE?=
 =?us-ascii?Q?xyIsMeXOw8IKGjz3PQJuuAD3AvLla8W/Jl/2NCe2nfr0VmYYNQ7+m5R3vAek?=
 =?us-ascii?Q?vBQMjjeq/gKEPM/1SMHTf5Fmkd5+6RZe3VZ9bbXvY056OjXNfoRqTrB+mYFh?=
 =?us-ascii?Q?rMtBbnlfgsEbHaZ0gwN+oAw8wOiOTwBm1zZXhsrehT7z3Iz6PklLQWYFTWKI?=
 =?us-ascii?Q?O0AQha/qK0bzn66E4+Gj2NwZvJnW0QwZx/EbLJNL0xiCWG+1dw7yTwAjRv9H?=
 =?us-ascii?Q?nmKLRUDQfMGHlLpbZpIC4UyUGcpmC5wvfVBRVZZ4JQmDvCO/C5Fvy6OKwS/u?=
 =?us-ascii?Q?BXri+OrjZOyngInkb3Wl3gdtkHoeKFVYvReWDpaIRcwHw39mKN8V/+B1rMTg?=
 =?us-ascii?Q?vRO1kOdZnW9Dm9VI86FWTpsezX5xu87BoV3Z2faWkFN9tWB2ad/vRL9fqKjr?=
 =?us-ascii?Q?69kYyDyb5qlhqXFCtpBVKs1sHr5iVAERfnoJcArYoPSHVWP8s0RgXp7+w4Vc?=
 =?us-ascii?Q?TaPHrHiow9bTxrbdEjU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703d7681-323c-4f40-3762-08ddba62ac8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 18:51:52.0392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTt0FdOxZ+aWsiyY8rGihHdlQdSW3m3bdwOxC8BTcRIsl+XstNXZLDG6pwCbz6B7U0ENS/xeAs0LeqQSMBJLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

 > > > You need to put the MDIO bus device into its own pm_domain. Try
> > > calling dev_pm_domain_set() to separate the MDIO bus from the MAC
> > > driver in terms of power domains. ethtool will then power on/off the
> > > MAC but leave the MDIO bus alone.
> > >
>=20
> > Using dev_pm_domain_set() has the same effect as
> SET_RUNTIME_PM_OPS. The dev struct is shared so ethtool is still calling =
the
> suspend/resume.
> >
> > int mlxbf_gige_mdio_probe(struct platform_device *pdev, struct
> > mlxbf_gige *priv)  {
> >         struct device *dev =3D &pdev->dev; @@ -390,14 +418,27 @@ int
> > mlxbf_gige_mdio_probe(struct platform_device *pdev, struct mlxbf_gige
> *priv)
> >         snprintf(priv->mdiobus->id, MII_BUS_ID_SIZE, "%s",
> >                  dev_name(dev));
> >
> > +       pm_runtime_set_autosuspend_delay(priv->mdiobus->parent, 100);
> > +       pm_runtime_use_autosuspend(priv->mdiobus->parent);
>=20
> Why parent?

That was just an experiment. I tried priv->dev, same result but I guess tha=
t is expected because it is the MAC dev. priv->mdiobus->dev is only set in =
mdiobus_register which:
- sets dev struct and calls device_register
- device_register calls device_pm_init and device_add
- device_add calls device_pm_add
- device_pm_check_callbacks sets dev->power.no_pm_callbacks based on if pm_=
domain/pm_ops were defined or not.

So I have to call dev_pm_domain_set before mdiobus_register for it to be re=
gistered properly. But then, priv->mdiobus->dev is not set up yet so we can=
not call dev_pm_domain_set.

Thank you.
Asmaa


