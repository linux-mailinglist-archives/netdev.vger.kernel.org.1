Return-Path: <netdev+bounces-197016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA7AD756D
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D532188809A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60D288C18;
	Thu, 12 Jun 2025 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNy2pULT"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B6C27FB10;
	Thu, 12 Jun 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741053; cv=fail; b=Oc4Xnc5Q4ik7BvG3aP4hsx3rDZHHo6m+/ZVWXyWcdAXCfH3sn84JSSj/RinmzfkefUfFA3YrVlsMbeQLAY02S4PD1qhGMI95vN/TEO1A3/O9YTAwV6Ohp9/wfQb25yQc3Y2eG8nVY4gegKZBsHCBJC3QjPC9AI9tSMTll5NjUb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741053; c=relaxed/simple;
	bh=oUAjNowzSd7S98GqbH2tjg/8aXHYzj+znlDMRh5tcFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JJjHf6AT3AqyB2xyZ5IEaqittFx9f+z6OuymVI85UulQd45qq4oAmc5HN5lEQUaPHAgXjW+TsSXu9wWrdT8wqwU9y04wykYXPlN58s0CFReA00tQ6KijZMmlOvRSz/0PixBN5I0aUueyRghoNJ2rBOnaAWLLlFHW0uy3PqmW3yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lNy2pULT; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcAdqMi52uWUYvlfUiIr+6IT27vca1Lv8ho1DgG87KnKhq9rD3QGW9+KOoNzCUHFxvlcDkArYdRiz3t4xmESWZvgFvcCfBi1sN7AaCXAN96e7TpfcRPHBHrhavYGj+33JNOzEJ1QpYUzJ09Eq8YpOdB/d+rw+3+XMDdxyls0AQlKYSHKjh/9I7aHf2dgU0Oj8vFnKfOgmr+X2MME6c3qsr9pYgwRHqm8C9vpaNbzW/NW77lkp63bxxkVwk7I7xkK/k/7lLNCLfSi95GQIxyeR49Q4xPTecxapdtVXssJRtJHvU6XWWgLLYP0a/nWoLUvt5UlwdJOEToLZaa0c84hWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcXDaj5sP1wY3+N4DUcuoE1+HMIllZGxws1DZfIqXsg=;
 b=BpKBucI3tccYpvKtGG9HjidXsDhcvq2TZRhYCULDqYip3I2dZ9WqsQJG8xbQzejq7fMed+YzAidgNvWonQNFx1drAZJG6Ipk68D00b7DIqIUlV86g4vsP7+jcPdbfHSoypzzMXL2DAtn0Qoj9A9/wbGluSLeZoV6thM87sCYzrxcUFzqPeWKX1AM6ky8US+KpRRlI+8hCuanfgs23NNL8ynmjzolnpw0Wx1uOVGAcmvfFqo3Frk9g1ulFo2ZdZPIh+Wl/JsrDnSRrkmDSP4YpzhrHkN49gEvbpDrbQv1ASwOQ+3M/iLas/nltHdqNX/c40mztj/HYN8plGc6vdzH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcXDaj5sP1wY3+N4DUcuoE1+HMIllZGxws1DZfIqXsg=;
 b=lNy2pULTrhhyQW9WgtAQSn4kqrPvqevxOF8Ggsr1GzHfxJZskduxe8xgXEgbtuS9Q/szRIF8zc8M+zi2PnlQbKae3Y3gfBjrzMUFmGmoakC2guGPRhApVQpWixJ25mAlCe0QAdU8bQSOVj+quMsUDESo4BecxZ/NcvMzQIEd8rD76JT7+jNHIRfUWcNIEmWauA7+tM+6sRefqDZ1MPYvmQhPrlhWFTPmU/Fmcd4kF++jpRHfInpqBv5GcChDp4UkbOrrd88l4pNd4sSDMZgiirs77syBIsXQcwbktKycFtLSpNp1Yq51gpeJ6PlXf/0H46rpNjPd1x8h7A9TgSupiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10642.eurprd04.prod.outlook.com (2603:10a6:800:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Thu, 12 Jun
 2025 15:10:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 15:10:46 +0000
Date: Thu, 12 Jun 2025 18:10:43 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Meghana Malladi <m-malladi@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Simon Horman <horms@kernel.org>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload
 support
Message-ID: <20250612151043.6wfefe42pzeeazvg@skbuf>
References: <20250502104235.492896-1-danishanwar@ti.com>
 <20250506154631.gvzt75gl2saqdpqj@skbuf>
 <5e928ff0-e75b-4618-b84c-609138598801@ti.com>
 <b05cc264-44f1-42e9-ba38-d2ef587763f5@ti.com>
 <20250610085001.3upkj2wbmoasdcel@skbuf>
 <1cee4cab-c88f-4bd8-bd71-62cd06901b3b@ti.com>
 <20250610150254.w4gvmbsw6nrhb6k4@skbuf>
 <10d1c003-fcac-4463-8bce-f40bda3047f0@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d1c003-fcac-4463-8bce-f40bda3047f0@ti.com>
X-ClientProxiedBy: VI1PR03CA0062.eurprd03.prod.outlook.com
 (2603:10a6:803:50::33) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10642:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e40cea-c708-437b-8a14-08dda9c34ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3r9WY+KBFAxWUiW4O0FXzuM1aIneYZG7LapHnLu2ONZWnzWrzsmpZYhSfy0r?=
 =?us-ascii?Q?8EAFK/UMYZ8qDEnU46MPWif5zdesIzcrHdG5OxulVCWCHvozEQ7EJ5bhv6qw?=
 =?us-ascii?Q?kBhEqSlZToaqCkkAelraxiUgnJPq5XOYvPvmibKdt2GUYi9oRcA+sfud706z?=
 =?us-ascii?Q?OCGrZGXcBrN7xQEFLoaO++wAQ2cU00eq+4yk9G0zVD9fcH0DtXY+zD/KKMYa?=
 =?us-ascii?Q?QKkFk1v5t4J4yfSmF3qRJonzCvB1TcrYyWGZG0bk5GwiuhS7KrqNkckPpr8P?=
 =?us-ascii?Q?gfX3qH6AvGCIjKMRC345jZA7CBWFujlVeL5zEppZ78RklFxeQLf911jLWbK/?=
 =?us-ascii?Q?NfqHuHuMw2Y8cviKjLSIQ8y3jFsy28uDBY40UUAbf10JiGHV762NGok6KDXN?=
 =?us-ascii?Q?NYKaexwq1iOLqOEzl1ZWKzRN3caka5iMUMgs+PrZEzGG10UG3DmVESmo9Aj9?=
 =?us-ascii?Q?/9HA9lz26oUsMQpi22yjX/XtgZ6ulR5XpocB5Syhstl+hEE5bWkWBUALhkBH?=
 =?us-ascii?Q?5WrehNaVB3gbWJ00Po+oWIIqghVg7/KTTF+7IiKvAwHumpoQ/96WojBhmKYs?=
 =?us-ascii?Q?zi17VaMe1Zurk7LooWnH/LjAbWiTPpdux94CN2sQxtFrAs+46kLXM/oRDi7b?=
 =?us-ascii?Q?IBFOWshXu0Vfh60nK8BvKYyk+k3EG7Cprw9sk26aMhXDUMljRWWmE7DpWzAn?=
 =?us-ascii?Q?J5tlqK4x6QATmXaxGjx5L/71jODUXbOFviD78hIvz7n3/natNmPMsWUgokSm?=
 =?us-ascii?Q?6F2snDB+aAQBarFHaJ2JGyMrBTSHOMekgZGvkk6yKYnRF+Yk9+53iFw+nZVF?=
 =?us-ascii?Q?OdlHvDcMVV8UuG0cvXoG2y3bLrhwR5c95nwz6wa6pihn9FP3IvQc8kQR0CH6?=
 =?us-ascii?Q?o0DD82kpQk/UWyk5wj1CIz/k9TvD/VhDVrpDRlB66R7Ng6u4/EAmh6cA/+8F?=
 =?us-ascii?Q?CGG9R77LUYx7tXJn/fXmj9ESGkfkiS60yvamucMaOcynOHFv61PZHBWNPS17?=
 =?us-ascii?Q?FiaY6wtoZxbVNjnJWUyMJJtAHIQTRNCBWFsXB9vd96U5isuPQCNQ/6hSTeIt?=
 =?us-ascii?Q?4NFPp0vlk9Wiw3pW1U3+wqEMH4iHJoIUg4l6u9E52Tw1WbE4WvE4hRF1nFLY?=
 =?us-ascii?Q?AdQR+wokFjk0bhMW/v4I2fLfr/a0pAdeATrWO9Qd2aPZlpGvcP8Mf/nnFxz7?=
 =?us-ascii?Q?6lOLWKDcKi26DgD3SrjtsWbhPBBdLqx5FXSi2mEPLgEN+MwzMF4znFNq/jos?=
 =?us-ascii?Q?6m1p2xG2SoHetNX0YP3pGcWuHb2K38gAFIUAnvXGl2DLpTTEdAo2ckTMfUOJ?=
 =?us-ascii?Q?M+cEBMiDfJWzkTsoZE2AVWQmNDUHIRxc4wkZjiHuEMayB4A3IEAavUW5kE17?=
 =?us-ascii?Q?PAGJd5unfSU6h5oqiaDvzffyBGH5Tmb3OFu0WtuBSjYx/hMxg5gE1ppSiRBt?=
 =?us-ascii?Q?qNC1+kkx5/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ah7XzGhi6hxzn6FMZeEA44MN7iOTpFqPJEe1+FtL2Hx3/89vmGFBdEbECJk?=
 =?us-ascii?Q?3GqLWYzWEdWfFB0rWcMRKlo2MI9OydmmKm8NI2XRe9E1CwSYhMF9K48IehKC?=
 =?us-ascii?Q?YY9WQ5poY+sbu/VQxqunIiKIH3NHmBvj8bbDltSKGsGRdearj07tok0FzvFy?=
 =?us-ascii?Q?b40twOrrxh8N/5Ap21PPBSYRlT6ZOZF9NUMeO/O9B5t6JVgTFLljAsnisRl7?=
 =?us-ascii?Q?YTnKqeDkCwsqI0G2Iq+51LKNtM5R/8wkQKIq1AHpVnxvRwBKJDbojqsk4wE+?=
 =?us-ascii?Q?xmB0a1NgMSwEc1HiGTDnuAv8Z+ZIUnKjNfmb0RVfp4MjUCZyZA6pgDlSRkai?=
 =?us-ascii?Q?wQVfdw/0tFx87LmEleiN43014pMEOAr2hIpVKePPpqEQiM5P/i9V01zZA3H3?=
 =?us-ascii?Q?109FTZTiF47UjhIAA3TdTlLC5lUvQ29s5IpH1DSoqYm+ISEcPNDdRwRvTm8M?=
 =?us-ascii?Q?5pxsECZxxaoLlESxfHiwslmSqFA/CKl7mHYm0eBRYAfkBTCiJ7sz2DjaF8Aq?=
 =?us-ascii?Q?6wmnyKuZ1jlg2XfghbZY3jgjCN4/KUguZThHWJtLbvdPzcFUQZbPvO0Pv0hh?=
 =?us-ascii?Q?RI1vi1ePPWWGBxZCLU7Cl5nOxmuXPdI4FKaB+scgr1Cc/yh9GWGK2CWd3Ui9?=
 =?us-ascii?Q?st++GsEra4xBjdFOny3Jr33cM8lEoHrRGU3GfICExbcNHXBUWVwujc6V0/s9?=
 =?us-ascii?Q?/RSchyvS9IsIxMxDQA4o0AeN6PQsShSjaDwJs4/IuInlZh2N9ZaRkikGuc8f?=
 =?us-ascii?Q?X5Me10IP2546MS17x/OdWp9lX5hNOehEIJYCE41rMVXMMY5PpvZviQYzZX2s?=
 =?us-ascii?Q?2y29Y7fKDBc+hW/q/g5xe8SYqFUfL85TGiZW4EUirgVZnpdVCXIyzUsinFUv?=
 =?us-ascii?Q?A9yyCBEuQG3iyQ5TnbLWMh6RLHbETqxR3Wmq1zoWghaQl12QBaogU0ODml1+?=
 =?us-ascii?Q?dlKmEQYmP3kIWmSXaAmFx978VlSXM7vCororuE5dEfKtrTDumynGG3JDSUYP?=
 =?us-ascii?Q?DTfwfLkzuOQ3YdZUHF6IogRp7Km1Z+q9y4M4VNy3ff/qO9p339upjpa99UW5?=
 =?us-ascii?Q?4XDP6EoFqIVEMLNLXeUZs/gdxp80kQbbYhD5NzYH94qrWpmIpaEVLs5sp7uG?=
 =?us-ascii?Q?/v3GVOfMzmKog8wOuX9f55VSo6weQ5eT8L1ag+w4mWZm7AxPS91xulF/nX8m?=
 =?us-ascii?Q?vBLw5pwUKCfL0pOdGfVySwgKKyK0DKnd+7++r0xN+l4yDSCSA5jXP8f9sE/m?=
 =?us-ascii?Q?VxIE0RhWoDRGfgqpc+MAR96vCY6NEwnINcViKfpRBi2PCeGHdEHCWl/6rCs2?=
 =?us-ascii?Q?Djg7Fr2vkf8g3aW/MhZxHLiNEAd0FbsNx/n0/L8Owgp88EfLTdCq1/Hvjn6x?=
 =?us-ascii?Q?8yBxgkMKCgARmrbxPiymEszYbygFlyxQp7go4zcxk028vX8y4SW8a4sgSjF/?=
 =?us-ascii?Q?m3vc8u/vSUrm/F1nXJRldqnG0qq9LuhbT/3Gqcr8NvoK4DvVx7pGYwoBESLl?=
 =?us-ascii?Q?uyieEyCY2eFffsnlYCdcTgT09iJ48+kuMcbvMhecxa5OOGT20lj0pC8nEedi?=
 =?us-ascii?Q?WIgM0N9Qk6GSPgUGTsEmjH9Ekagzx9Vhwf1hOBlmnB3KELH0Eeosh8zvMxMm?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e40cea-c708-437b-8a14-08dda9c34ef4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:10:46.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKwz8yhcdNFInHGyUzEWAipU9mUDmqgG1Ny3lKS4uM+QcoNhhbI5wM5T8MRArsgMqK2NrF7GPxi6FRTaRI+O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10642

On Wed, Jun 11, 2025 at 03:10:35PM +0530, MD Danish Anwar wrote:
> > I am not very positive that even if adding the extra restrictions
> > discovered here (cycle-time cannot be != IEP_DEFAULT_CYCLE_TIME_NS),
> > the implementation will work as expected. I am not sure that our image
> > of "as expected" is the same.
> > 
> > Given that these don't seem to be hardware limitations, but constraints
> > imposed by the ICSSG firmware, I guess my suggestion would be to start
> > with the selftest I mentioned earlier (which may need to be adapted),
> 
> Yes I am working on running the selftest on ICSSG driver however there
> are some setup issues that I am encountering. I will try to test this
> using the selftest.
> 
> > and use it to get a better picture of the gaps. Then make a plan to fix
> > them in the firmware, and see what it takes. If it isn't going to be
> > sufficient to fix the bugs unless major API changes are introduced, then
> > maybe it doesn't make sense for Linux to support taprio offload on the
> > buggy firmware versions.
> > 
> > Or maybe it does (with the appropriate restrictions), but it would still
> > inspire more trust to see that the developer at least got some version
> > of the firmware to pass a selftest, and has a valid reference to follow.
> 
> Sure. I think we can go back to v9 implementation (no extend feature)
> and add two additional restrictions in the driver.
> 
> 1. Cycle-time needs to be 1ms
> 2. Base-time needs to be Multiple of 1ms
> 
> With these two restrictions we can have the basic taprio support. Once
> the firmware is fixed and has support for both the above cases, I will
> modify the driver as needed.
> 
> I know firmware is very buggy as of now. But we can still start the
> driver integration and fix these bugs with time.
> 
> I will try to test the implementation with these two limitations using
> the selftest and share the logs if it's okay with you to go ahead with
> these limitations.
> 
> > Not going to lie, it doesn't look great that we discover during v10 that
> > taprio offload only works with a cycle time of 1 ms. The schedule is
> 
> I understand that. Even I got to know about this limitation after my
> last response to v10
> (https://lore.kernel.org/all/5e928ff0-e75b-4618-b84c-609138598801@ti.com/)
> 
> > network-dependent and user-customizable, and maybe the users didn't get
> > the memo that only 1 ms was tested :-/
> 
> Let me know if it'll be okay to go ahead with the two limitations
> mentioned above for now (with selftest done).
> 
> If it's okay, I will try to send v11 with testing with selftest done as
> well. Thanks for the continuous feedback.

I don't want to gate your upstreaming efforts, but a new version with
just these extra restrictions, and no concrete plan to lift them, will
be seen with scepticism from reviewers. You can alleviate some of that
by showing results from a selftest.

The existing selftest uses a 2 ms schedule and a 10 ms schedule. Neither
of those is supported by your current proposal. You can modify the
schedules to be compatible with your current firmware, and the selftest
may pass that way, but I will not be in favor of accepting that change
upstream, because the cycle time is something that needs to be highly
adaptive to the network requirements.

So to summarize, you can try to move forward with a restricted version
of this feature, but you will have to be very transparent as to what
works and what are the next steps, as well as give assurance that you
intend to keep supporting the current firmware and its API when an
improved firmware will become available that lifts these restrictions.

