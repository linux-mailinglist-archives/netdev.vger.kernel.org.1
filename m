Return-Path: <netdev+bounces-224969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4BB8C464
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3328F1BC6078
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED6429A31D;
	Sat, 20 Sep 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EJGZahwB"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130C1FE471;
	Sat, 20 Sep 2025 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360353; cv=fail; b=ZUkfv22DO2XOumahnfiMEhz9y5FgRCGFvEtRakjPDSvuyUcEbmQObETcT6yjnNVJUkWcdKkqwau3IvwjWwjZqgrkuAjLviPeMiDOlioXesUhgdDI9WxayQh4G0KkBYvwS/GQEpdZvJdezs95F+7wuMTN6+wjjFMHcrhFnRaulOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360353; c=relaxed/simple;
	bh=yypQr4ixEyDz8D2b2+oQFVVa9ikJhW7w+qo/4a9lRkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=THDRfgtZm8yQd+bI5EGJJ+rtdsmelwYQ30QQIXLShL5VT0okN/LdSwMMf1wB5tQqgi/pzd4oxZ50X6lkxsgqFI3NKCinOh0m9l5XHoZ0kZ41/UVSXJzkQIpohjMVKdM3XrMZQaRxWvRNuvE02Up9LJT2YXiZkGpwinQS2GsDd10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EJGZahwB; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBMG+bXY6EzrZ4mwYi4+4LM5awZ41NNC93Rkk+fwHYmMTs6nZsR9MKxwOGL3cTZJbgMM+AetwFcBKFwu8RP+dwYwkIv64CsasumlOxPvwoZf1R4gmhLyJ7ca+UolyxS6mHbmVluWD5D6cdEkQ//ObEhGHxNPvCEP+3b8CETsrHtrE1/+MWlJqz6S9qDEDBJQo111Z2ygQ+jtBfVfFWoIQG0cllTW7S9nIBd/sHifryEZ9axM65mjdD5chxrMCyOHT4MCMJ6K2BWimQW51Zl5u0Zx17QMuuhJCESzU5SsXTEeGGN9C8AM1GNeiPQBkaGO80AZ+MlDd0l8LUJPluHfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuDzVQSYy5LRABAblDuZMPXJ+scFXV/UfcXtKtjMmEI=;
 b=L+8+lzKPEias4Rq9kA/SdjkT9guLCXvGfQsic2b6/rEUC5CCyUY9M/6ilw4VH/Z1y49129XF3E3A645E6NlY57C6pYbr1s6Yd6k3YiQwE3oU7j6Ld5IoQb6AHspem0qW+2Y540kc0SqNyNa+Gj/1cU5kyXwqpBx6wSh0PLupGJaCviAkWP41s3I7zJ4rluV6Z93N9YT0Rqqoz9lHEPHfeGOBKZoFM/YhIhTT7rpqHISL4+vJrIcRkGbI9fN4n8oImCYaixnYy4E6a1vYOtzpzPVQ7f/GdwfxlE0/u2a8yB6ErscXzbt2JkGAQzs2V3+fS2oVV5jqA9rUSxwVYcCq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuDzVQSYy5LRABAblDuZMPXJ+scFXV/UfcXtKtjMmEI=;
 b=EJGZahwBmxbFXtl8saF3pLrkALHV8JiyW358HRhocj/EI6Opw9ff5gB/ewaIa9qKexdlzRn1lIUWFBbACKynZYYIbHJZrGio1ozi5SXOqQrcVar/eNtI99doY83UP9o33nhKKZxUmdISH4uBe1McFvigTvCCs8L21ek3mw4p0x5teJvHG6PLnqdj/Huv+xuEh2Br+ZqNYuBRg+BF44rX33hZSHLnn5pcijhHTxwgJvJEk0nk7vAJMKKMIVnvRwOZduRfQDl2ZDFdiRR3yC2rSDlzSTrK0z+Ch0BYaLR6Y/ePMdAsud4gcuUH3jK42iym0diQwiR9Oh6Oh/FISZ8OaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sat, 20 Sep
 2025 09:25:47 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9137.017; Sat, 20 Sep 2025
 09:25:47 +0000
Date: Sat, 20 Sep 2025 09:25:31 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
 <20250919165746.5004bb8c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919165746.5004bb8c@kernel.org>
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba80677-a63f-4029-3714-08ddf827ae55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?729jvPGZwjndV6Nc2MgEUzqXCmNkVSQMKQ/XWhPaDHtW0tIUe0l7z/JnidbL?=
 =?us-ascii?Q?/Ku5E90uiJCsAGXnEYSBmyzQZlOKNzpeCMzpdS+hPxxyHkZTSlBenEL/6oB7?=
 =?us-ascii?Q?JQgKnKKvfKUEuZo0BY5e/JHqon/0lNGbCF83Hi4xRELScSA5f8/3EjF7g26J?=
 =?us-ascii?Q?T7WiPtfLv3qdsSvTGtEFd6HvW2/9QKxzhAnLXBMNqo674lEcEgjTpEH7wgq9?=
 =?us-ascii?Q?ACdrcDhLlu6uw9LxjjJd6SH872VRG0ZpoX6Y+7cuow590J4wYmqpCnkB8OS/?=
 =?us-ascii?Q?IgR9KZE8ML7bVedPQBuYEBw+nKdQRfdtbmnG2ddllp3tYNuHtAlyeEjnq+zF?=
 =?us-ascii?Q?JhTXudAwQKyrhoxx6i9wOMuK2k2wYjz9t9DT692OC5OreSDfo6IZjpTR/KYj?=
 =?us-ascii?Q?ITIGtS2woQAMaUFB+Mhiu5n/PX7RblXm5m6Mtd76HqaZaDhSuGO0tEbW2Kg+?=
 =?us-ascii?Q?PJMCJ4+elyXH2ig1sn43oAD3aheTgk1vDfmpynwahxJx7/j3g388jG0p8+0O?=
 =?us-ascii?Q?7yfBqYpddVZ8SLByl4+nFeaTOFCvQobpB9L01almBIRAXn+9+9cunO64gW4t?=
 =?us-ascii?Q?wZ9AUFI3BWefXIVl1TDgCoUJzzF/G1S4/uAJ6xUl3xZYvU0fw+yM/1rWFl+z?=
 =?us-ascii?Q?M3k9Kd5yoUbO6cfM5ycu82dSM5dCMetMwTrdDribUept+CvMDah0S8QtXgv+?=
 =?us-ascii?Q?tVDlB2uM7IATlBPuy78QBU3OFVRC2eS8VqFO7HGcNn6jYpzQHz5LWxdn5qXk?=
 =?us-ascii?Q?UUP1wDQIrvems/VE2C6Ww7U58PUtYxyi3VZGplsb/d+0Icw4zUuvnACFk6ac?=
 =?us-ascii?Q?FgHyjOQEzLJ97yFJakqJdl+Bs0yV5OU+VUVvtL5Vyfgae3cQwY3xCXb5bfJZ?=
 =?us-ascii?Q?I2ApvwSzCQZegseHsg97Bx8PLH20bmEnn1zsk1ZosYRYevTCdDStNWXhdzt6?=
 =?us-ascii?Q?ZHp5p7lfoi7lxp4aIXqLsrhHsWYYW0bAEV6V5fLocA+o9edeo3gj6USGiAqD?=
 =?us-ascii?Q?umzv8Q5NEjqLml1k0klWgBV5zN2/FqzKmtVhn9CR5EugL7VCY9XYuaX7r+pr?=
 =?us-ascii?Q?sR8FGzyG3EtiUK3PcNov6li5+QsVOcAG3ANJ1akEYLI9lzWsxq4JYWmDm/AE?=
 =?us-ascii?Q?jS+7dpjPcMi2mVDr3aDEG2eNzQNXYX7Hl3iyMDhCDQYzfaXZrWy77WK58gWi?=
 =?us-ascii?Q?HVfnTQF/N80Wgc5jxL34bnK4P3vC6/JMNrIXd93Ga2Ko8jjiJPALOFqWfGl8?=
 =?us-ascii?Q?9BzpV9odDvvflRmdtDHs91KJEfOzZtLh6i8DzhGw/THnXW0WHRBTIOnzf7L9?=
 =?us-ascii?Q?j3cRLhzl/13j1B3FReayaTcBFstxLXVViSeFTwTRKZTUFsaoUzoa13YZfsen?=
 =?us-ascii?Q?Jlh4hbEJlCVN9b0l4dFJLZ2/nfQweEOIDE+Ebdqx0/elE2LkK6Y2xcpib0RW?=
 =?us-ascii?Q?14kBU8Yk0wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgSwb6id+yVqG6GXf2KmSAsRVstpjmhXM8F23cZpviFM/qawybcAEBUrA6nq?=
 =?us-ascii?Q?xIF0ZtRgYI6i4zCrrWTxG78kcsrIIbPNF9/fBVTDP5apY8SDu72vQunShv1l?=
 =?us-ascii?Q?cUIlJ36fH/pigTUyGwFMl/bxjYLojr3TiuWJIBmpdSpsQxUBP2K/d2XNOFN2?=
 =?us-ascii?Q?FaY/5yYVgBpxGVPazmCUNwqA9Chq6815ac1R7go2NS1QzITpys/uVy42LIsM?=
 =?us-ascii?Q?YaadlmIxEl7/3O/9ysx64r1wABCNRAmkHe9HkmxxkA6jew3Skl6t/VlebDd9?=
 =?us-ascii?Q?L1SwkIuvhmLjDtKEFnwtb1WYvB/dQqgTX3B+0Px5lDlUP6xdybVYj/wmBaNF?=
 =?us-ascii?Q?+pJM9F4Ja8UpXvXs46hUSTHtXnhVGLbUFoRmlZtO7GsRcKQ+WX/S/R7DZJBF?=
 =?us-ascii?Q?uPqlsvUJ5ZclCJay/GFZEyQO17mksaSfYNqCJtOJ5MKltJ0gS15FH2hpXL1W?=
 =?us-ascii?Q?NjC8efdOX9TI3zZC4SZBsQRq/yUIG2F1u24YWcN/VntPCkQJYpzGUiVfyW8d?=
 =?us-ascii?Q?+n7w6lVMWqB+CMSyezEkqFjSrWa6S2j68540fY4IqJ8kMhMnyt5r8FxCHiCO?=
 =?us-ascii?Q?A8Mw05qyYqGgU6Px8rxHfoWc4w4i3P5sN0VizRYRgCP4mk+wqTxUPoetcuTw?=
 =?us-ascii?Q?iYSuX+g3AZqU6VZujYqAy5f5ICelmxorZ6JFpcANtH40OSWUPzm28foiNEbK?=
 =?us-ascii?Q?2OMnZ5S/IhYoGIID2MIvgwXDIyPRTkJaIm0jVXeiMc+l4llKDESk3tMKo5Ut?=
 =?us-ascii?Q?s67D/RyV8lUj3zyPftJ4R6CKCrMKFphMSLjN96rWK+deg3bzD/SY/D21lSHA?=
 =?us-ascii?Q?B3i/t+EaTsBfj5LqcryD6P3v69IsArg7mqN8ufnsrlSBda06+LhEG84XceV9?=
 =?us-ascii?Q?eScA/9ToHfIyg5xblZ9U8lFlk9KppD1vgKDaDmPccMfzOg9kg3FxULkQHtIy?=
 =?us-ascii?Q?/vFvs7HvPfKqVtjneGdW39iocixfGDO7jEQLNMMtHUnwAyyfUJ1VXtdt7KeO?=
 =?us-ascii?Q?1hSsoJGJoUEiZmHMCr1tZ0SJi0DBM1hBiKl4oSNBtILJynUSVZAj+NmR17M4?=
 =?us-ascii?Q?cweJUAQuwnMf9NU1+7NR+OjcoXjirnKguwD7pFcOpKxbOoVa0kERQ5qV1skq?=
 =?us-ascii?Q?eTOJkRgp4BqCC4d6sXHS6LCTHQm+BY8v5Mhol65pPsMVJCgmel2zyIydP3EJ?=
 =?us-ascii?Q?WyPVE9TrNwr6ImKYEhv/rUZN/IJFkUyLZjtaOuRh/EoDYU91C302VpLgmsiO?=
 =?us-ascii?Q?EOvBqRvyAcLgkP89kMEqFfrFptWyU6VpmSV5owho8zaA7adkiKicQaErPRCS?=
 =?us-ascii?Q?owGQbNeR5W4aFvsve+WWRMStN3161/sGJxpzpX/1Vu2c0IA7TvIdbToClLAk?=
 =?us-ascii?Q?PNFDXvlQHPxWz0sXyIuir/IURWKbJdVnkYX0L501q0BuOoxN9q9E/sBrw4bG?=
 =?us-ascii?Q?csLJIJzgMsw+eDW/Jw1YIiM40Xx8WXMBdIWAP0LVk3ImoSBhj+AqkyuIKaAP?=
 =?us-ascii?Q?nrUGWwNnSr+YPlgREweGDa573SOSVnWhwY7KrSA+GZMM4zB/KPYYAVWKAAuZ?=
 =?us-ascii?Q?lT2+bPsNSnlQEvrviTDDfkwfEiWB3OVZT4v8AODb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba80677-a63f-4029-3714-08ddf827ae55
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 09:25:47.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03pvT1FNflYHZ7uh4wZCKtZrv+vKIzRNjp53ORv+OsZ099N6yR7s/Z8kBj+6qtHg6pv2OJhtG0a48FuLFp4HNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

On Fri, Sep 19, 2025 at 04:57:46PM -0700, Jakub Kicinski wrote:
> On Thu, 18 Sep 2025 11:48:21 +0300 Dragos Tatulea wrote:
> > Direct page releases to cache must be done on the same CPU as where NAPI
> > is running.
> 
> You talk about NAPI..
> 
> >  /* Only allow direct recycling in special circumstances, into the
> >   * alloc side cache.  E.g. during RX-NAPI processing for XDP_DROP use-case.
> >   *
> > @@ -768,6 +795,18 @@ static bool page_pool_recycle_in_cache(netmem_ref netmem,
> >  		return false;
> >  	}
> >  
> > +#ifdef CONFIG_DEBUG_PAGE_POOL_CACHE_RELEASE
> > +	if (unlikely(!page_pool_napi_local(pool))) {
> > +		u32 pp_cpuid = READ_ONCE(pool->cpuid);
> 
> but then you print pp->cpuid?
>
Point taken. I didn't want to replicate half of page_pool_napi_local()
in the error path. Printing information about the CPU id is also not
really important. The value comes from the stack trace which points to
the code that recycles to the cache from the wrong CPU.

> The patch seems half-baked. If the NAPI local recycling is incorrect
> the pp will leak a reference and live forever. Which hopefully people
> would notice. Are you adding this check just to double confirm that
> any leaks you're chasing are in the driver, and not in the core?
The point is not to chase leaks but races from doing a recycle to cache
from the wrong CPU. This is how XDP issue was caught where
xdp_set_return_frame_no_direct() was not set appropriately for cpumap [1].

My first approach was to __page_pool_put_page() but then I figured that
the warning should live closer to where the actual assignment happens.

[1] https://lore.kernel.org/all/e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org/

Thanks,
Dragos

