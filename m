Return-Path: <netdev+bounces-225339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3DB9262E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35815445CCB
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985731353C;
	Mon, 22 Sep 2025 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1iFALR/"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DEB2EA72C;
	Mon, 22 Sep 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561504; cv=fail; b=cjPpRJy2s+jrfgNtARyNzaeIvLpd4wozB3oUTAm6+hHRdQRr5R5rYw/8V4opumXBfbmbN2uIJLJlUmAvJG9pyObZBfwAB/49JXw1YCYxhqLVHOR2Jcku4XlXbZTQZhQS4GP5qqEwqqPcdwtZ74sewfpRgZPYJ+de1qDRWLdqYo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561504; c=relaxed/simple;
	bh=qGIkCS1E5g7j0SYevmM89Z9BT4y2lGjnSvlBvvVOl40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nskD9FctLsAcNV+QY0mC68nRFcyQLZjeq6pUtKH7PXkfD32PRkq9UVOLDE0ymKqjbzndl89kHY3UZRQMD5XAo9n9Y9Y7iC6cLHnoPCvD1c62xharapneGbilWEX+gJcGLe/JvdVo1N+hGLxZbiiTSdBILTrnv5L0yUhhAvvfinQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1iFALR/; arc=fail smtp.client-ip=52.101.48.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2nuI7UYWM+t1xvuGg77CxxswlGpzICmRH5aSgZg8Vba+byTkze66XnQSswv3RXp7zwg/Lub2/nG8olABvu2krzQ6X/Fh8XRixvGYNGzt3GO6T9T5bj8+3DUdSibMhnq2l67ckEIV0mAuBq8GTn54czeCCQH6Bau9vs+rbWGa9Y2cLWS3beCPq+AQ+WXeUBCMXf5YTgWP/MXWMI2v3U1o6KjWzuNEdeYi9zRp7lseLbuonbuLrsY05q7V1k+JkZo/WY2LfAagnzyujnwIx0jcmXgMIJT6yQ89VNWEqDbA76VeJsa+a1qS9X/5fAgsE+xBGHNHuUsSwHHcRx5a9VOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atwTVX5OkmqVVhhzh8oC0lkVf+nLXugUS1aGkn+yBC0=;
 b=mLRabvly+kTC7bB/CPwhCFz4H1EpKyOyVE6ie86Q5f67wGarKWK+bT+/EbsDHfE0W3M6/HMQo07n9aC4j6tkHb19Af1sbwrDwaAkr5SYGz7BIJMw+s5Ro5QwsZ1VspSSPhpZ2+F33vPon/sscXscigKD1x1cO8OPG2pR29jyV/rfZPEUSEoDxGxnCkk6Iv/8YRaFywrLxe0XL3xeFRsaSNVoCm3OsLkiMO7IU+pfUEM/pJ98YglRdDeRLfmnV7VITc2M4Ib1Zkvi1ovDZziaiWoumU+rgY4K/VvjWQ9wtDw9OFPtqC9hMaxByLvJSSYZoGUNRX/meEbf6mU0/Zx4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atwTVX5OkmqVVhhzh8oC0lkVf+nLXugUS1aGkn+yBC0=;
 b=g1iFALR/yKBRg6pyglKFToAZQUYia1dUQhWLr37OpUN7d9HTjcP+0lUWm7ooqGaDbVDOmESeFSuKASJdmYQE7afaEDLUnX8Zz/SabNFbgXSsn+YiqxWU8rWOJ3PApdxY4PAeO69RauTqPZ/JJ6DhdM8D5rdHmv/52vtGxG+rA5dsMkf61pRDfWnT1VkhJHFS66yVodMQ9spcBs9BviZ/LlXR6hGEY01729UNNGlDtOJwZ3n811hb8zExDt2bHwyLbQCnNg7kmBUBD4ThlBh7CK7LOc4/91RixMOn7D9F9VOCwKNDGvFqHm9tN5ntpFE8ZyEw24/gqQhPk2+SC7ZkeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 17:18:18 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 17:18:18 +0000
Date: Mon, 22 Sep 2025 17:18:14 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <n4umixor7ph2gnmc5osxaenksd6eybeuntljeywudi5h7ctamy@qfqlucvdcihq>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
 <182ceffb-b038-4c4f-9c3b-383351a043d5@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182ceffb-b038-4c4f-9c3b-383351a043d5@kernel.org>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: 470a4726-d0a4-4a0f-7edd-08ddf9fc058d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iUCOESd7ri9xvds0SdiECfJ5ba1/+sZYcv8a4ohjTHtRCctyKtWPFxq25DIP?=
 =?us-ascii?Q?fx02c2Gs+Bc4WNWTL5mfC6L6i6/wvUiEdEKMLJheScvaaDed4v+E+CmJ9JUr?=
 =?us-ascii?Q?J+H3IIWATcahEGSwe/BDTohNmvUKQ4jnNPO/hvRrJ2LYQ01kZNquRH/AORoS?=
 =?us-ascii?Q?zZvI3n2QG9YSclHwq2R9nEwoethyrUQViuSwwDWz1xF8KITBG8oy+2JpkfJu?=
 =?us-ascii?Q?Lf+S8yqDlQ0ZY4aN0kldpGFgbDdlPVJEiNVAFGq8oQIckGXxRlW22LaunDiu?=
 =?us-ascii?Q?PDZ9rS/vG3BK2l7XjHsnFZjLmlxCWRZFq958TdcBYg2oHIgy4sf6j+Y1dO3u?=
 =?us-ascii?Q?EJytaOgCEUYFni1kRZmp806XxnC+C4B9MPbgcqkbZmdcBcxvAj3HdANzXJSJ?=
 =?us-ascii?Q?s79BRTo7pMezyOvHr245hkeraipS6zvUaLKkrsWHaGgdDa+YJeHMGQhga+kA?=
 =?us-ascii?Q?IZqxeM9ZYiUiabVX1UlUYqh8dtJfDpsCOppNNqrRoReelX+qrvFHtZmC1uSi?=
 =?us-ascii?Q?iwaZprhg3FiM7fmQ51kMI8XbSZRM4xbeS5WZNV9HMq5L2Q/X/KY/YbEFl8X9?=
 =?us-ascii?Q?tn3P1guwY06z/vy9/7z6lgrHKbgGuTsR6+QaSFvSJXxe5T6z48Sr7FPC28JP?=
 =?us-ascii?Q?5FFvbFfoUN8qBie6tUFJEiuZQ7jiLG7fbeQKnOfE/UhGOxU3j+8qPEMieo1f?=
 =?us-ascii?Q?+IF+1u2xuLM3c8glQfdIgg8Fc/beyVoX37l68qwAYrkzpCELtBKAC5pbNhxM?=
 =?us-ascii?Q?/dPr0DAxe5tAP6rrSK2NRipkD++CGAZ2LzT8iIyUWWdqU4Y1YKvA7xy+tNuk?=
 =?us-ascii?Q?w0AyJWacgZuQ5V0KOLinlPqcX5YZyvU0mZJMO511WX4IE2ZdmhjjGZfnKBCK?=
 =?us-ascii?Q?eoGg6dCt5vdyqQYlkptB2eabgtUqgOYOsX6ks8+VzZpW8fLdYlavbWKQGy3S?=
 =?us-ascii?Q?bVaTmIABQlwyVP/0lEHIlkBqqCqUXS+05YzauOD0LeEfIXKavd3MirnwFtDM?=
 =?us-ascii?Q?M5Dxo1GmJbIk/PX2tmlg0+0FMwVUekt15WxuLsUiXxz1hE7Kx3ytjDzoO5Ap?=
 =?us-ascii?Q?zNewthv8bTE5FRqFQim8q2u/w/cZuuzMigiX/ezgh18qpq3DeChnY9+XFvkY?=
 =?us-ascii?Q?dYxCrLsQrTcBEtXxx7kOqSP057/wv5keRD3/jTrtbDv7QI85tgIih0VEMaIP?=
 =?us-ascii?Q?RKm+O8FlRaunENDRnjhfS26H2pFpD/5LjiDizWIVsoHIcQP/fOj690HzJAft?=
 =?us-ascii?Q?Vr9NrUE1VjbufBe5Af+OOR01Bbd0Agg5lJ5WEyGKt0zh/fTE/CdWiyAjFkS+?=
 =?us-ascii?Q?DlmkryVHr+4xjQngd3k7KB/YX4jqo/KFJ6cWC4EDiwmW0TUTKz3gtQsG85FH?=
 =?us-ascii?Q?3qUZV0pKMi+l0euDV3tiRx04eyPk7sLcPaW72AKSFztkyBP88jsQov/Dq/OB?=
 =?us-ascii?Q?Cv6eciaGDMkdEFPAzQCX80xcv2+6tPDJ4Kw6Pt2n39MpzF5/rh6hiATsCOQ6?=
 =?us-ascii?Q?oAaDeGGcgQjuQdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNAmVCqhaB0onPcK5QER86+P61NkbNXBIfWNiKbjLUQKvn8QZW8xoEHwkg1a?=
 =?us-ascii?Q?r/CWP4zpsZ4PCowWHli0xKOqzfe7AOVHELhuLUHRPeb3CcOUKqGErfqA38jF?=
 =?us-ascii?Q?dfDMv6Dhyh633NWfk0FFuDwE2pEtdHWN5vf86GmAkIo7KJQwtoFs+BZSD6Bq?=
 =?us-ascii?Q?Do/t0cTIPcGHA2tqq/Za5NlENq2owBhBE30KT49CxV5wkauUYdfLAJ1xBtp6?=
 =?us-ascii?Q?ugXnGLVwTDEmYp2DPrxCnI6u/hrk6iJyqbd+ulEu6f6Zjjbdo8SBO9ekOvhI?=
 =?us-ascii?Q?BnFwtnKAYrz2g3nAZ2Cws9feQgy2YAo0mYSrhEh291ATbJwqkfsxqbyzpm+d?=
 =?us-ascii?Q?E536ISZJ9QqH/cVTLQ54jVGL1Yd168yJ/eiSa1cH7Eqm5raTalz+bz7oLvMQ?=
 =?us-ascii?Q?pxuB75pn28BAoQPqn0xYZtbZCYLeY3pIDDojWnYaPmMI11stLqCdVFqNh2WG?=
 =?us-ascii?Q?NVS/DdRS3WYA6UJpe+tIsBRiQovfxNzKlwG5Q4J/XY1DC1AtYztPR5eu8wV3?=
 =?us-ascii?Q?bELNBU/RNeAA6uTirr2Jof9WkuRJIue+CqYFttpxjhDBSW6X2Vtyph+fymtA?=
 =?us-ascii?Q?kjVqrnPeJGjAGmB7lWVhoIzTWV7aDH032uzQGAs+KXxDBXzqrZ2TcAAzYHQ3?=
 =?us-ascii?Q?Zdf39AB+/+xmZgrRfJKIMMr+vfi7hA/OeDz+aLKX/PMCywdcThmWUvar1Icm?=
 =?us-ascii?Q?m2M6tABSJ+wCd09gPXVuKK4KUy58QsV1ugLrqnkPJjdlw87wb34fTNB55qfW?=
 =?us-ascii?Q?EF54qP4YuUZp9H2xoUTU4m271eYHSsW0//ulCvjeSCClWqosLtg3gcl/rPji?=
 =?us-ascii?Q?/xUDxjnJhAOhgxHYx+2StdQEwqV2z7KodDr6mCy/E83JppM1RflmUhQS4GsQ?=
 =?us-ascii?Q?1mNUPIkgMwPiml6zYpgcx3aA0V86OVkNfw417ftNB0ZzhQbs6zYJ1+D0XMYJ?=
 =?us-ascii?Q?Rqzc3MlMd7SpG1uKIAF71uK4eXHzkLVdYXAmAdEMd3g7FLO6PhuHfbuhtRxK?=
 =?us-ascii?Q?EqiUO/72Rq3s9vAHUoY47KZ1JcuSHv6oy5ztyOBygMrm1hc6SWuXevjdxpmY?=
 =?us-ascii?Q?Lii1NoT2izSM7GHqt5X1SaS0bbkfUnN+sNc6EkD7g7RCfRkPTvG0M5wOmwHe?=
 =?us-ascii?Q?t9gkHL+/zudWgqwIwlJVHdCtOROZpWNXa+zkCvQpTUv4b/zOIfQhzeRgIrq4?=
 =?us-ascii?Q?LRZqOecCaRxE/GrEGbrFevdn5JDu/HdF1XsyMSWwICdcgPSrIVaJ+zlPP9of?=
 =?us-ascii?Q?R8jdDgM5iZyuhnZKzX1vewHOTEXfdV6qz65VphmaOu2U6PXrw5QH84dCjJzN?=
 =?us-ascii?Q?J6Qh4ZKiivZRJxE1XRik7SogwkauxZ9T+aBM8/y+euB7jsfPofA+mo8GNsVU?=
 =?us-ascii?Q?GxnH70LbSraUtk+mp9PtewlVv4mHcVPzMnHV8B144jVdNLoV+flHJ1OAlsVs?=
 =?us-ascii?Q?7tAmLM7KryF2oS4P0oDwbnhHt2yCV6ir6wuRiUMX58zoXGwUBEM3OZkWiipP?=
 =?us-ascii?Q?Yv08fa4/Pl3ObCvKj1ldNgjtwFRL5q85akg+H8nCIWL+5A25UbDSY43DI0zH?=
 =?us-ascii?Q?Bu7sCmMX+LxXfs+n4e5HhXo4K/3nviw7pSGJMazh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a4726-d0a4-4a0f-7edd-08ddf9fc058d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 17:18:18.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQSa1TgP019uyCon0MKO9CF1i+m2CDV2ALNdj7jxCnnJATeDDqlcrkKgopj86rfUUWR2Oqktw0bqG4dVtN6MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460

On Sat, Sep 20, 2025 at 07:36:49PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 18/09/2025 10.48, Dragos Tatulea wrote:
> > Direct page releases to cache must be done on the same CPU as where NAPI
> > is running. Not doing so results in races that are quite difficult to
> > debug.
> > 
> > This change adds a debug configuration which issues a warning when
> > such buggy behaviour is encountered.
> > 
> > Signed-off-by: Dragos Tatulea<dtatulea@nvidia.com>
> > Reviewed-by: Tariq Toukan<tariqt@nvidia.com>
> > ---
> >   net/Kconfig.debug    | 10 +++++++
> >   net/core/page_pool.c | 66 ++++++++++++++++++++++++++------------------
> >   2 files changed, 49 insertions(+), 27 deletions(-)
> > 
> [...]
> 
> > @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
> >   		return false;
> >   	}
> > +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
> > +	if (unlikely(!page_pool_napi_local(pool))) {
> > +		u32 pp_cpuid = READ_ONCE(pool->cpuid);
> > +		u32 cpuid = smp_processor_id();
> > +
> > +		WARN_RATELIMIT(1, "page_pool %d: direct page release from wrong CPU %d, expected CPU %d",
> > +			       pool->user.id, cpuid, pp_cpuid);
> > +
> > +		return false;
> > +	}
> > +#endif
> 
> The page_pool_recycle_in_cache() is an extreme fast-path for page_pool.
> I know this is a debugging patch, but I would like to know the overhead
> this adds (when enabled, compared to not enabled).
> 
> We (Mina) recently added a benchmark module for page_pool
> under tools/testing/selftests/net/bench/page_pool/ that you can use.
>
Is there a way to trigger the fast-path? It doesn't seem to run
in_softirq() ...

I will also have to do some additional configuration so that
page_pool_napi_local() doesn't return false. I assume that we want to
test the perf of the non-erroneous case. Right?

> Adding a WARN in fast-path code need extra careful review (maybe is it
> okay here), this is because it adds an asm instruction (on Intel CPUs
> ud2) what influence instruction cache prefetching.  Looks like this only
> gets inlined two places (page_pool_put_unrefed_netmem and
> page_pool_put_page_bulk), and it might be okay... I think it is.
> See how I worked around this in commit 34cc0b338a61 ("xdp: Xdp_frame add
> member frame_sz and handle in convert_to_xdp_frame").
>
Thanks for the explanation and the pointer. Will do this in the next
version.

Thanks,
Dragos

