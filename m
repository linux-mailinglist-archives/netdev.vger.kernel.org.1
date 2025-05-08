Return-Path: <netdev+bounces-189076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6233AB04C6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68953A933E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D228A1D7;
	Thu,  8 May 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSq+JWXe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F421B9FF;
	Thu,  8 May 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736871; cv=fail; b=aa1m11VNoBqE55qu0xpHM63+IjeDC1ZjEuffApvmuzdJcEvQgC+CuxRAR4NSEuF0se6Y0wMU9bdVlqz7rwBvfWheltt1J0S2CGsQl+Vl8WhSveyjegcAM+Bjcu7HwBE5bSdu2h2Mn196lUQ8uH9TMApBA0L0yyDryk3TY5upcRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736871; c=relaxed/simple;
	bh=ohB/tLfjpzcVJX6YYUAr8KsJtKl3lFey2yxVxKqXups=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XMzkgnguR6XlQfSzUp4EBGCLILnL5Wy6Pdh74ayxCB3xv+5oqzpmDzxl8I//8TCI4pTTwriIqF5YJcVWsIFhRDFzylb6bUgNup0nBILouSNhsGegR3u5HOq7N/9eXgxEUEpKYjedDo5SJs9UAdPOhdJRUsiPFP10FLg2YcrE+j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MSq+JWXe; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwh2XZM2IpX2hKEuC0Y8oxQtObEdwfNLFS4y6G7fWGCPfkb7n/Wv16bKMxsSIYDYQS8gdak/KI90DO+7Mlsd/JbYgpp5GvEv8jiOXTMXDg8PXk47yZkmIn9FWj0SsFQ1E9+BxAELHta7A4M/JD7My2z6nO/eRw5Oy6GDJZIGpx05rWqukBNnrwuqAuupZtiZ8dckzpvvnw+9DnayqQfalH9SakI01NYl7WxgsuIGcOkFqHui4LgeNsIafU8mK5jpbDVGixesUk6sZPeQ50zE/XoviYXhoQvXPXUZxOVrzR9j4OW2Jv9ebV/Ywr1W42EF0EZEzKgXOgXn/oz2w/+Usw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohB/tLfjpzcVJX6YYUAr8KsJtKl3lFey2yxVxKqXups=;
 b=UA0EcGj1PysPKCnGNN3+sUtO3WjEZgK6a7IpKGZfCEEwW/gOYz/3nHcjmYeRelA/DoBZKvgHiBLAv1ktgyyro9dXFNoC+tvbw2RW30tExSv2hRo4ZDyaIcrXGuAQWLtJwklRCErEH7ykgAhubJys57Gtc8xLi/fkyNUJXRWkYgOwoI921EXroZGrxBFdeAtAMd6rseTcdtf0TmNf4BLRJ1/7TT7y4a6jgpT8tdPM7k2wNuMjYfdNtOw9Ws4geQNysCMEfISaUodfXJPIv6uppoj+szkVchYotU12cVv6dKZ8JoN3EErR4ngNs+M5znD9beo2TN/xTVb00+RFC/ClpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohB/tLfjpzcVJX6YYUAr8KsJtKl3lFey2yxVxKqXups=;
 b=MSq+JWXeiJQiRecrhh4zjJICFw+vxM1P/otWSEQpUY1O/+H5MTToUdRv3w/g9HIz8OFzP7dYzc4UUaF6mqUxekZBiZLNPe5+D8OVXWJGG0Rclu+E4ai4G9XNsbsZQotTYWuzg799+pCKAlhKdUeiOd+Ql8jYOoBfw0xKtqKlIQ1SvGjH87b7qaGW0EU24cyXQk4a7i/UxfwHt3hDAZbOfElJr9oK1YCrZiidFPmr1OYy3rnxrxDOSJJUy+F+83uUupmGmiWMS4IbSdMJO0tGoZDrgKWul7teUWfBd1ATrTsEuhzoNe7VTG/MiUKz+Eo6zIOHlcgGkS9IAI8xu4Ucng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB6833.eurprd04.prod.outlook.com (2603:10a6:208:17d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 20:41:03 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 20:41:03 +0000
Date: Thu, 8 May 2025 23:40:59 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	=?utf-8?B?S8ODwrZyeQ==?= Maincent <kory.maincent@bootlin.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250508204059.msdda5kll4s7coti@skbuf>
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
 <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
X-ClientProxiedBy: BE1P281CA0254.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::7) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ada6c2-d9f8-485f-0e08-08dd8e70a604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnTdsunAaUmpPw0j4vIQ2hgvscIqdbmxDfowsZ6gYvynQvcMB7PSf3S5fxw1?=
 =?us-ascii?Q?ealXYjVC9Qx59fGyiAxRIOCA0Nx6RqpBX6wKgoyX7ce1lsTHLRsQHTkzhGvc?=
 =?us-ascii?Q?wC2WroOZMZfg3bHaU/t1GfIQNjH0sotYa8oo0cCJM4wa1kEWHP7d/K+RKCMX?=
 =?us-ascii?Q?BnP7/wvlbA2RS0OkzGJTV/X+tltiwXhnS7rjS/HUcvJRh/bRQUMGYuRr8P5Q?=
 =?us-ascii?Q?jrAcVuQ0rGs/9iUVn7SZX94YA0JX71Ck+/EcltTE6lRV/E7/45rW44L8J2Oe?=
 =?us-ascii?Q?RGj0KFePzzrO/WIm5xig6SRnMc1zWuJ63KTtKHTCQrQc25tASv3IFnWPzpaE?=
 =?us-ascii?Q?eOPHlxi+WtDWHMgkWQhL1S14jFr4M/t0Z8OFxjJVNGLzB7+O6BucC7zkF1sT?=
 =?us-ascii?Q?yGbYBDToqmh+DZn49nc8P49Dbm6bEL3Z2kBUBT1sUtRgwQxn+tAL01sq+sYS?=
 =?us-ascii?Q?8tfwRU5bUQsmqqrCiyCUg7vJL8n8pUaTqGq8GyHdzk4/40nqB5fmRv2eq3NP?=
 =?us-ascii?Q?G7H32erUo4bOdZWW9YPePe7HO7iZIhPMEP3W4gPfKSc9p5cy5QNi9xB0HfgS?=
 =?us-ascii?Q?QmSsUrs4DsAaSl3PeKaAChy9oPxyHSHABfH60q3aeHqTaaSfAmzvAaPAB4Wm?=
 =?us-ascii?Q?l36TK7Bxslgy8pcWWDVznaZ4wUpA4W6FmXrlD5JC7Z88Th9SF0PMqbTobxbR?=
 =?us-ascii?Q?om5GtIuBxFwKCFCcRaZs8PzybxhA46n5GvYegR4i9gVru74oAnh/gA1Db7eX?=
 =?us-ascii?Q?1zbqDynBpvVclyEBsmiy53TiW9+wd61wo5wc6FeeYKD0eA4j7iH78nUrp+AJ?=
 =?us-ascii?Q?p6c6taGs2O0BNyZIOtjKxAHJhj90W+6vryDIGKjpLs/Zc5gEsyVUhZMXSmIJ?=
 =?us-ascii?Q?vQ/uQpLsdpTpt5Br7YoMhJ0iPYfpsIqlQFIVj4QLvx2VvzubqniecIOzy1xa?=
 =?us-ascii?Q?s2PNP3dxVDdbtIEsp7Cq8/aRD+VlPljPEKypTHz/+LWMjcIuHNhLcVkn2AeU?=
 =?us-ascii?Q?8DXwaqRqjOksC4NKw1MODKw/lWiXul20vLZFlaCNHF1OUGG2X1ZnQYjYdYLi?=
 =?us-ascii?Q?iYgo8MujI2QuHwtXCfmOiapr2dIjh4KaefvU03qqWRZy2NBR39PiuO7pkdJU?=
 =?us-ascii?Q?mLg12uy5UKk7SflwpRX4qFFOLBM1jzUMEK6Y398Uo61sps77/438tT2KMMev?=
 =?us-ascii?Q?iPcsaHvfUvsnniZft2Ohi2QBqsZblUE7f6FNoBX80pOUlX5xlyyJAeC1Kle2?=
 =?us-ascii?Q?pYbuIrI6J133BkTIFggAzyHOGbSU7Q68SU1OKcMMmAh/hP23ze4NogCnlpJ+?=
 =?us-ascii?Q?W8BwZ6C5bmL9OlUWsfinv7PotXaZNMmYiT16Z+woNFQJM4Ep65Xas0adBrOx?=
 =?us-ascii?Q?VdS6FGKM7f9H+GRyK6HLnZqC5kMiDskcd5Cx77lnF7Oi2b5pn4OgpLth3Hlb?=
 =?us-ascii?Q?TiQZoEc1Yno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B+t78Lo6NJpzXKpLZM2KxTQlBshsqn1v2sbJqA0R3Q3g/f3W5x5qsj0DCFD5?=
 =?us-ascii?Q?RpBFfr9MEVi8c9FWCLPktheEXOW+QJhaHDRlxzwYFBS9N4N/wMkkZXqJoxaR?=
 =?us-ascii?Q?4juOkRA1B9UjeOxI49/JHHFjclpEHwjCeDytUZsQgpnXlMD7cZZLuWqrmr+k?=
 =?us-ascii?Q?RQcPyW1SMBPyIL1xFTmvQMImkxmlzh8iNKCxJRy+RjwX7+RLHOUDqzrUS6bT?=
 =?us-ascii?Q?nFtNIjWjJRd7U8FjoLYMKM5O9Z7tZxc1tiEG6Qok9ZypRFEAGd310n32/+BR?=
 =?us-ascii?Q?s9DNHawtBSuWZo4yJwAN7DIU6WWk+b92QX/YK5ZfKoo6tg2FvynW3lAorGOX?=
 =?us-ascii?Q?U16kIGiU/sy5gEjQ78BDPy41Q+ep/B6HTPzRuzRzfDgb60zJrGgiZqN71HCi?=
 =?us-ascii?Q?mu5CaN7vYLVxGGqi2cU7fdE66cO1YTjjVeH42nj4asnu//3Uwxin7Frup3pJ?=
 =?us-ascii?Q?HsPl0+esmxcEhSHmprWdlfGtYIlVBFwV7oUOxhDrNCFh40PtgYOkQj21Eg38?=
 =?us-ascii?Q?+5BxHzU25gkZlC0TK12mpGwt3vuLFQyCGFdEMYluppBVDDJEd4jZ0K7991R4?=
 =?us-ascii?Q?lhgy2iCACy1fsdXgOqRBeGzECnRDRhQYmRFQYXV/SUJkkkldoiSNVgpPK6ch?=
 =?us-ascii?Q?gt2OZzJ55pOqPG2B8P4+HMDq7VEShogBYKqhkiFUAlBLJVCXHejDnNc0Gw00?=
 =?us-ascii?Q?nFbLLs877ZPlyqcgquhYxTdyc+E2KcgTo2ayj5zgdvy8vz3bqAmIQod56pqa?=
 =?us-ascii?Q?hiYUEQJakfrWGE5UJYTLM0ERltxa7qbUxtAC7WUPLdMZf7w4ppt1SlzRg7iG?=
 =?us-ascii?Q?NeoHPe8c+gAeZxX6dG1qIX5ygBDN39e/2I4VdZZjZMPHUoVQOFzg3IaOEtDD?=
 =?us-ascii?Q?AvDRwz2xxM+AKKKfSGVDD9vCDNoA2MP2GTHFiwoSVV1HiDTl644ZsujfX8X8?=
 =?us-ascii?Q?hU4EfmcOpFqjSHnyNEKWs23zEqtjj4hC/94sxGEw3HYKMl8zVJ7JqjEOKE+S?=
 =?us-ascii?Q?MLwP9VnPJ5rh2ZRZXfWAM+Fbo93bKFlSBVTZg+64RQjvADuDDTGbOT5VSM46?=
 =?us-ascii?Q?jvS0b9N8dusEo4Bb/aGsKt6jFkBBstCc3T1L41ap87qtcWlQ/cqmr1HJFALT?=
 =?us-ascii?Q?ysAp0/ld8vi2Jc/GmusRtCfTFajob36MSMyEkKn5fJjTfvohn1BUVKmNwZi/?=
 =?us-ascii?Q?4tHU2n/3QQ8qMVfDHjGpY0LawSdcjNlhT/B7GS5JjcCwtJixwUnqE9G4tj1B?=
 =?us-ascii?Q?hRKLmbu7QZaVwomevaJebOu7KRttcdO5+D3715/oEgxSPrZu5vYJZ1vHFRW5?=
 =?us-ascii?Q?t1CEnvlVwe5PD0FCu76Mj3ovnwCDorm99u8nYktdvPbEtk8pEXu45gj+aOsd?=
 =?us-ascii?Q?3uZMsLQDqVEsMD0Kvi+QXvnKrrdGFRkp2NSceNdsHhSdNHuT3vLsuUAU/RS9?=
 =?us-ascii?Q?6s16BeKuvV2vbFEvWCSqlgVFZyWZ0NCfgG3QN80e5H0JrfqK6YNu3AB7x7Nk?=
 =?us-ascii?Q?o1L3XIfqDMDEp1SukZ8uWBh7f4Xg0uLXnB3CCIcu/JgMW1JFdRYAWdNnv7xV?=
 =?us-ascii?Q?1EDQrSYpLZsg6JCXcElbD5ED/N0eTtqD/xNJure8WspfFbeOMeuROEwPdevw?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ada6c2-d9f8-485f-0e08-08dd8e70a604
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 20:41:03.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKFceBCvPtZ09haZSA3903+rGx3zDyc9u1R00b80TjP8JNf5y65lA33572z4qS3JZLDgZqEeL8uG6I9bLcEAgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6833

On Thu, May 08, 2025 at 09:25:14PM +0100, Vadim Fedorenko wrote:
> The new interface also supports providing error explanation via extack,
> it would be great to add some error messages in case when setter fails.
> For example, HIRSCHMANN HellCreek switch doesn't support disabling
> of timestamps, it's not obvious from general -ERANGE error code, but can
> be explained by the text in extack message.

I wanted to keep the patches spartan and not lose track of the conversion
subtleties in embelishments like extack messages which can be added later
and do not require nearly as much attention to the flow before and after.
I'm afraid if I say "yes" here to the request to add extack to hellcreek
I'm opening the door to further requests to do that for other DSA drivers,
and sadly I do not have infinite time to fulfill them. Plus, I would
like to finalize the conversion tree-wide by the end of this development
cycle.

Even if I were to follow through with your request, I would do so in a
separate patch. I've self-reviewed this patch prior to posting it, and I
was already of the impression that it is pretty busy as it is.

