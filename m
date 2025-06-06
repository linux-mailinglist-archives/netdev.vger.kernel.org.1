Return-Path: <netdev+bounces-195504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31719AD09FD
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A518985F4
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384471EB5E3;
	Fri,  6 Jun 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="rYyJhhtz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2072.outbound.protection.outlook.com [40.92.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7F36D
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249172; cv=fail; b=AWKo3Rhgih2R8dqqkCfjpvQz0Dttd4NtE1mymJX4Nu654okRB6CPCEHN/cssVPcwcGu1Nfm542X6rmKzbqy0+myjQRdx81CKJjB4HIcHpKlV+19mSQTByQnUGlsHtcq9ZoYCdVoVd1qavwpXawiN8gze1YEdxVkhaMMz3PFkNvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249172; c=relaxed/simple;
	bh=lUNlwDhsltBr6HSRosbzKppZmSsKJ0CTLvSGysNYnIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/YTKgNsnhxujChdgUi9J7UBdwV+PKITMuT+25syn5HCk7jbIr6xQG9GS2xWVPOVlkayCoL+aw3t4jfVK1xZV4Hgk1FiisbYjRKym/LQMcu1WXuP/wvoc9HAdl30srLfE2wuwa8VetZaHVo4ziUYvxZY1R27BTnIBaTNX7+rmzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=rYyJhhtz; arc=fail smtp.client-ip=40.92.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2FlhxHddikHs4IHMsh+g/3L3iXXiaF/PSqeQZeCv6me8teWyvQR6eXntlZs9vNxh0t44acVPssBjZ6K2G8caVqR+eB+LiJ+6DhOKEfqaFQv0KDQdiY8QcY1ZZEStP0q473bMkyosR0qCmPjWa+7xYnLAaFYJV6IfJ4+YgXq6gtXVwCJX85mWNqFgEUbeoqMFT2C2UrBGFaKsCDwtHPayEcSCOwtBggWyWDbP2Q2hPpSkBQwehfbedy8WqWPciImBX2tLt3LlfrDewCiTvwcx+YSKSTLKFBWOC6qRLQcqM6D1JrSB+ctnqMkgk5ojuI4BwgB5soM5xEVkS9PjNebtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0deI9bE6MSI2vzz68ZlAXh2sIeW6GAC/W1/al87bgk=;
 b=WGCVqJ1a2EgVDKqvzc4YDHOjmPbpCTWcX1r0ckFoOOdX70P78UaIjr5ad/oMUzP97V2LtoYuqa0E7bBtg6QHFl4aTGKKOMJW/GWK/LLw5qig4kS7X+lhkhiAGtMr27bE9L9e4C+Ie8PGa3XDssxRRybhxZxYCxCju1JwSZSSAruJRu9Pn8PC0qoeEkvQqY5xUli4TADKS2wgkNMFQonwGfvj9K+hlPoobtiIpHEfJpEVHrHezKGVQdLV7+wxrnqwdszVY/J1KnMR/PuGJg65CV/4D6/sYeTGP12TEcxqwZDf5MBgiTzkuC5aMVa0bEzTOqQpPuDYyKPnmlE6qx34bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0deI9bE6MSI2vzz68ZlAXh2sIeW6GAC/W1/al87bgk=;
 b=rYyJhhtzPJVc3ewFtxC3AKAzAilQhcpxK140ZQVEWy6pjJ3l282pEICDUStGYI4+ccyYnUVeEDaDJx2V2lwAkJUgSqkO9fx60YzXR7nowrEhnyv+zTFWA3DfXhhntdD3H0F8RnBlJGa4egNEoL2xQj5SMXKNJWiiyJwzN2tuPXzTWQDt7osh832ZRRZowpVlOX/HfGkgVsq+o7QSFXRO67w/NXFlTW9nWqZWIkw5z9u/rQSjzGBonmPfeXHEjliiuzDPpnqamGFog/P0NxdXph2h08dDGcr/Gg/2cP0GyJQFPK5OayA2oceGFhSICMzv175kPCA+0J/6kTNeu4BJIQ==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by SJ0PR19MB4794.namprd19.prod.outlook.com (2603:10b6:a03:2e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 22:32:47 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 22:32:47 +0000
Date: Fri, 6 Jun 2025 17:32:43 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Chris Morgan <macroalpha82@gmail.com>,
	netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID:
 <SN6PR1901MB46545250D870E79670E43E06A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
 <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
 <SN6PR1901MB46541BA6488F73EB49EBCDDFA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <eb99e702-5766-4af6-b527-660988ad9b54@lunn.ch>
 <SN6PR1901MB465464D2B7D905F6CD076F3FA56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
 <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aENb4YX4mkAUgfi2@shell.armlinux.org.uk>
X-ClientProxiedBy: SA9PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:806:20::7) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aENsiwYRYP87At_O@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|SJ0PR19MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: d869ff4c-bf67-4939-6a9d-08dda54a0f35
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReE80aSahDQaeTJXw7QggA5KACUF/U+ExDgbirZM/oXkzn8IqNDK5GOKxMihBSBQDXIls8+Xru10XKgOZz+LKgpVrQGDoc3l7h9Oi0du6NT1OYO5SWqQHntCyT7vD9kjVo/gU5zHmmAW7ReDOchBWN4FK394UXz65gKA8pWFEQAAfUBxv/Ym7aPjZ7JD7lsdkIa3i8xxaIRDr9GkXoK/D4ZtpdGy0+O+vP/4TSE3WmV7W3RdTrKk2o9VQ4dMLhMC27XjxPrUdhYWPHeGtTb322bIeGs9DXv5HLmExcEFhvV2xEWpyklAH0eOcF1M7Mz2TMgelneVPRVQ+JkkwtfvoKhF98UEYklK47qLmcFFS/RiB1uonyh3e07E5HZgde90VQS5QvoSV+wLwUiO8o8hKOf5hAPMo1KGqDbxYpKQdiXVtwdktatStMJGTn0WDKO4Xvryk86OrTbclmypXMghb9m2yU/+whNdjJj7D3KnW0M1F3MYbJkCtSiKVAtps/ae6GU0y4mE/gCtVu0ckv/JSP+lqgJb/64Imh2q8e3GdNa310EkRSpASRRjcTHTc4E11WoKGFMyfzG6tzrDnps6ViCmHd9Z3p67rrvy/Z3tEii/t9rcHDnCls4lyVcdGqSmhb3uHETWqkZyx0yBzQ0KAyVMe+zsoZBvkLSU0Pi9r8izjeBrPM0/4P3XfePKWkWKs3wfxd3Wx5++OZIWKCqSP5BwqM/xwK7CmuMOad+XGyFiv6Y0jX0/WyQF4eO2JssutaojoPp4/aT4g7ca0wLYZl6JSvDMiAXQhVBqDMG7SCsUtA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|6090799003|7092599006|8060799009|4302099013|440099028|3412199025|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yIBe4hgARtKD6u7hlJJ3s3khEqkdLvqvM/3VhBVr6n+kYwYiEpoGj3AyjVFJ?=
 =?us-ascii?Q?x8mxcJRqvC5DECKyfoLOUWvIpKoOPqawmvxfeyW8rLJkYIvwLHybf8doaqH3?=
 =?us-ascii?Q?sPw0gPBk/GGqvU4yBbSy4RtmqGfeqdBftLWyiytJuxbB/GTXpZ0iyRh+duOf?=
 =?us-ascii?Q?YqQA3ZCkKVGCh3Ub1Ewz2l8qZiA3rR0NciwquP8yZ8V41tjZx294IYibz2iv?=
 =?us-ascii?Q?fvRv2z4k9SgvejWU12iG09/IpGn/6rzXri/sCCicaTwTG/8blMKwBrMX9gMC?=
 =?us-ascii?Q?Ocj6SA1iJslLg1xYow50ZY1VJ6JGzONdt97YnV/Lo6/UFJLLMl+D6h4vkHKq?=
 =?us-ascii?Q?MdXc4bG63Qb3hDOy78QbLQAMvKTJCbNl030v+DbZpgyrpIcKw1f61Aatk+O0?=
 =?us-ascii?Q?rC0CopV092MOWhaSn8hG7ZyXXp5QkDrRYWYP2JcKC3x1tmp7nDB0PQUUtaFR?=
 =?us-ascii?Q?44tIZNZu9RrgaFmuYrQnIrOQLKYi8CW43sMa47Gy3RBf0sM5eBXoSVA7iADK?=
 =?us-ascii?Q?+wUx4w6Jz5rUjK1KTrEOI9b3TEs8ahQ4fP6TiAbs6QFceNNmuDfChWiwjUt2?=
 =?us-ascii?Q?dQov1hXMEBX9ZvwurW+6fLPY7SmC+FOZn4B91uhC6csBjuVt2/qsFf/1GP/H?=
 =?us-ascii?Q?jxB0YPe6jvpIW3b9DfjH+2YdQp7cd8pnToSd2qDax4r05pPoLrPHQS2UIZpv?=
 =?us-ascii?Q?xXYeUM2HlcHyu44ye9GVIk/7WbcxRO3YkUzyOByzVlAvyOw3Zn6U6p3wqgjl?=
 =?us-ascii?Q?rKqUBL4OS/3WmP9ye0cwy/kXK2/5RyuXvwawEVa491I3rr0sSZLVOHC7ZO/m?=
 =?us-ascii?Q?BAzBCSeDHvbpRidlYOghHpwyq0VuIZumegSVnElX5iR9XvbBjN99Y/cgni+B?=
 =?us-ascii?Q?StOM/fYJUTghBe3NHAA5WGMzDLWt1tncNUF9HMBCbIM+pXnI83Jg/T8m7UOe?=
 =?us-ascii?Q?szNr2WvfwfegOUAt7JjyytauizCTm/3trW4XPbU7eOLulBDJf0RPysBIj38l?=
 =?us-ascii?Q?jnoynNu37AorlXdZC/gleREuhiFMFUdQHYj3/El3DIYJjZthADnLaFdoNGBe?=
 =?us-ascii?Q?phCCQeNfBjYtcBYBzh8lJD2S1YWluV8Ok3Ju23TGv9vOmESNGi8I361ctaUU?=
 =?us-ascii?Q?T4H8PV9q5uVJjuLg3YBm/LoykMiIIYjai0NMCzcWWMLV+TLNWayEZQateQmY?=
 =?us-ascii?Q?tvfbf1flUuQfCBA04SGRB3khi8gVUy0mRxnnRz5mtutl+my81XT2Dp/h29qn?=
 =?us-ascii?Q?hvizFQlwNCQF79yRuFhW6eNyTEOn5ve1xw28nCJhEOhQv3QZdUURjlVeVFqc?=
 =?us-ascii?Q?E/4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICMIzePobxu++R/Hl4MuI+bBjp2f+uHwl8FvCkDAyf5ggcIZHO5vU+cB3TFQ?=
 =?us-ascii?Q?1wM41YCSvpgP5hYW6y3IVevZA/dCR5znFEhVx/JkE4WnAYyHFh8dWDp0/eZV?=
 =?us-ascii?Q?bZiKXbvV9cz1O/s1BcGDkkDT18+ZM0ukSJRS+5Apx+FwYgXaovtZySwGbgI4?=
 =?us-ascii?Q?eN/Px/cOnKyBq2thJ/cyPvn28fWgYZhguz/S1tgOuxb7BVe90cRYzBF7wsHS?=
 =?us-ascii?Q?D0V8cmWy0A3E4jYVVmYTyM0U80k3cRS6tvk1gU6VzoDTiSY3KI0C344TpZLA?=
 =?us-ascii?Q?o0/gWCARjR3ZoxT8eZJEf3qsjXgOiOdxb9XgEoYypK92TukGbmio7cU0eWLJ?=
 =?us-ascii?Q?uLNeAn8iGsHl+Q1UN8M+OpzDkw+/Qa5TSpkthqQdLIpwUlH1BXWADGGj44iP?=
 =?us-ascii?Q?arC1JWVvY+ppLlmisRlkyYAyWVNOsLdiWi5t1h+H7r4ii3HdUVmNrhTisB4m?=
 =?us-ascii?Q?HkB5+v6dQb3Q8lqJaaDgwrk8n4zWatT3yBWhLr1yA1H5VMcBKyhRfntpXvwO?=
 =?us-ascii?Q?EDtF09uifOMwHRe2iwbtd8Jt2tRdW6lmSGGk6tznHaE1IdvjqUcq5daB2ZXU?=
 =?us-ascii?Q?6Q9b28L0dAv/REo3ZkA/r6bFxijPSBPwIhkLLGmf33Zi5UrJLQRnJf8UG/6J?=
 =?us-ascii?Q?WqblNcuKR1B7FmDYusXlUANX3skYtmrxzezNzo7/yTNQoWS98iZ3+Z/vY4a+?=
 =?us-ascii?Q?YpZjYt5tsHPoUPqh8yc7G/g2icnLhA5n+dUzO2laxXa50AqcG1EMrKy/nO4P?=
 =?us-ascii?Q?cmndF+TrfDMk48nc0Y/6umuQDq7AZ4yvATNesVX8oeg5EjuXT2S3MCA0Lvu/?=
 =?us-ascii?Q?HC+3zBgfX96p/2iJdto+PWkJFpqrifig9Vk96SaMNezxO8YlHlMo94FVwmVO?=
 =?us-ascii?Q?Dou2aQsUeeHK5jua9ZOQHKGsd9aBXQfAuHoYoq81+3Y0sZ8rCx02UQGp7eMl?=
 =?us-ascii?Q?k0dcRRfIXXvAVjzZbb28iBz9+9/IOQ+9G4qRoUyPH9vLiTLqsmLHGOKvkkZD?=
 =?us-ascii?Q?dL/6zBfVj28WqzyKbi/JWx507wmGOMj53j7RBfliAM3w/xRFhULZBv7zPNvL?=
 =?us-ascii?Q?/y//zI30u2XHEsb8gYONJzy83PVk+ZgrJ2SI+fFKX3mFILR5jUaZSWMG9fYd?=
 =?us-ascii?Q?/dtKG9fBlCh4KDhcxG57O4XLZbx3J8QDzkTg8+bKlQXtIXQcJK+8x9Rtia5L?=
 =?us-ascii?Q?zQoPZfs+jzaiBfFZlgNxlbrTN78bCdrDTiQxtfaXkguHVYXME+Cy6ZpV5Mnf?=
 =?us-ascii?Q?CDf4ayr/21Cwrq+wEJdDauaRIuHjLLlL/016XUONM5I/wmS4ZxvLJK8q3JAQ?=
 =?us-ascii?Q?BR3pSbLU7PbVJBmEp38QeFN4?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d869ff4c-bf67-4939-6a9d-08dda54a0f35
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:32:47.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4794

On Fri, Jun 06, 2025 at 10:21:37PM +0100, Russell King (Oracle) wrote:
> On Fri, Jun 06, 2025 at 01:54:27PM -0500, Chris Morgan wrote:
> > 	Option values					: 0x00 0x00
> 
> This suggests that LOS is not supported, nor any of the other hardware
> signals. However, because early revisions of the SFP MSA didn't have
> an option byte, and thus was zero, but did have the hardware signals,
> we can't simply take this to mean the signals aren't implemented,
> except for RX_LOS.
> 
> > I'll send the bin dump in another message (privately). Since the OUI
> > is 00:00:00 and the serial number appears to be a datestamp, I'm not
> > seeing anything on here that's sensitive.
> 
> I have augmented tools which can parse the binary dump, so I get a
> bit more decode:
> 
>         Enhanced Options                          : soft TX_DISABLE
>         Enhanced Options                          : soft TX_FAULT
>         Enhanced Options                          : soft RX_LOS
> 
> So, this tells sfp.c that the status bits in the diagnostics address
> offset 110 (SFP_STATUS) are supported.
> 
> Digging into your binary dump, SFP_STATUS has the value 0x02, which
> indicates RX_LOS is set (signal lost), but TX_FAULT is clear (no
> transmit fault.)
> 
> I'm guessing the SFP didn't have link at the time you took this
> dump given that SFP_STATUS indicates RX_LOS was set?
> 

That is correct.

> Now, the problem with clearing bits in ->state_hw_mask is that
> leads the SFP code to think "this hardware signal isn't implemented,
> so I'll use the software specified signal instead where the module
> indicates support via the enhanced options."
> 
> Setting bits in ->state_ignore_mask means that *both* the hardware
> and software signals will be ignored, and if RX_LOS is ignored,
> then the "Options" word needs to be updated to ensure that neither
> inverted or normal LOS is reported there to avoid the state machines
> waiting indefinitely for LOS to change. That is handled by
> sfp_fixup_ignore_los().
> 
> If the soft bits in SFP_STATUS is reliable, then clearing the
> appropriate flags in ->state_hw_mask for the hardware signals is
> fine.

I'll test this out more and resubmit once I confirm that simply setting
state_hw_mask (which means we don't do it in hardware) works just the
same on my device as state_ignore_mask. So if I understand correctly
that means we're doing the following:

sfp_fixup_long_startup(sfp);
sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);

The long startup solves for the problem that the SFP+ device has to
boot up; and the state_hw_mask solves for the TX and LOS hardware
pins being used for UART but software TX fault and LOS still working.

> 
> However, we have seen modules where this is not the case, and the
> software bits seem to follow the wiggling of the hardware lines.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thank you for all your help,
Chris

