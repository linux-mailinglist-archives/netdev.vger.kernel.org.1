Return-Path: <netdev+bounces-237892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA6C51477
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFBC3B2A04
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0F2FD7B9;
	Wed, 12 Nov 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K9txQafL"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085C2FDC5B
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938015; cv=fail; b=HctWQYD7ycW0Jlb8xljPlm6AfMxOCJGawku9+2sVSSnntxFgHw5QVu6UrXiAd74ZvQE7OhzO7rgUdjDCX8+FI3MSHRs25o1EIK8SgRYWVr9Lojl1J3HM718NjxGifze7YzyhaxHInVfuswPjIcFAH7ghLY9dmP0Maze4+MjpJi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938015; c=relaxed/simple;
	bh=EQT/AG2FLsXmVQRPd+hxeTmawviHjSOeZD3nxmgQxBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KjilR9rHUcopuKnNthE+/Ox5P/VVH786vA4EWblnRSQs3cOfDskr+M4U6hhU22M/XYWsuAZSpKhkpneuASls7AfAjb5Carl3yNwFFzubjmeEXn/p95JDdFr4vH/8Vx+b0bNM7d0AZMjMOiEVMON7JrnxobVVdO05ll4nkpPmmJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K9txQafL; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkh4zXIg1lAuZCAvaiHJggpU5p1ppzy9sX8lTJSuK6URmxV8xRYDEPHMwWswURJ0IqoSH8OZM1UQs3epK6ztqFihikOHU8ke7kcrCbEC0WgGdanMg8QSL01Ru6cyDasUJkr2lyNVU7OKSQtFP2mXGFrpfPMYNVQr3Ya6Yerk7dIug0t0O0JQUhs910u0i1Zt036H+1xNPhdBNV2ls5JNc81CPnvDCv8ynYgxqzTLklcQQmJlq2/eXBJ7Z6eChu75hi9dkMS7Lqk8NVQGytTBZ90SKUZb5ZR18eXIJPnacH9v5h58/hHxGjdX+Y19KqidIJi7JmVF64KXN/0CJCDFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usUmp4d6GFBw6i++7AIVCwn3lFud5LRv+OV1m4DJhSU=;
 b=qUuzOSwnOpi2XlfKF2vWCwNA5+tqnyoG6CiBOqqN18EYR1tfHe3hy4cUA3WP9N+eIkzfuPnLwgzB6Bz6aJEE5T9jLDIRvNj3Rx8p6KhJNxqe4PTxoyHSb8YDXp27gmHJx92kCmI813F7R6FoOW+Yzq01L8rgkvJLBEyTbAHk+bPhFpL9kSeQ5FvlGtfMQx1rx2ZEt6yo+chKf38MPyt/ArhpPL+HIV/ZcbLGZJyiNLh1M2qihHEs/7ZOx7gNQ4CgohE1NZ4PFphhMrMz9HlLUlMFD/lGOZOJJ7+RHo70HnLm3pb0ZNl3iFZbLaT97xp1dCY4OTteRgVprbXPe2CXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usUmp4d6GFBw6i++7AIVCwn3lFud5LRv+OV1m4DJhSU=;
 b=K9txQafLtqv42Z1sdoXwWaTFgzKiYp4S9sxxg3OPSYwDfsdGzyvFThZGXl4UjmWmKz/rEcmjggo6frGD1D9xK7gLhj6/a5FoZ5rarUksx1bTeZfPkvrPbMMD+WM9MDK5q19i/qYcxw1JCdok/opwpvaBhEPPQvodvjnnGTs+elBkGHd5OhNzvzJDfhEbNLp3cpYqJJq3pkTivwcPlayY3gzcnLoRw4ekFvI3ZuY86L2dfvjggO+mwzFDuMB2xOFLtotzfF5cYdBvqT5HNlt+pztRdziJyoN4JuObpBc7nZX6You3pMSVgxX0yj1RKM+xVidkWsEX9WHOI+SvMaieYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 09:00:07 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 09:00:07 +0000
Date: Wed, 12 Nov 2025 10:59:52 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH net-next] ipv6: clean up routes when manually removing
 address with a lifetime
Message-ID: <aRRMiGVBSoQhLnDF@shredder>
References: <20251111221033.3049292-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111221033.3049292-1-kuba@kernel.org>
X-ClientProxiedBy: TL0P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::16) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 3720ed6f-9c2a-4cd9-4082-08de21c9e02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LZgG2ufBNLolOKEppe3PSKXOXAVJeZui6dd4KyJrJSUTSDtfRpGzaKf9fzc0?=
 =?us-ascii?Q?NthdrAYkrmeYZKbFzLSmbBRuLqmTIjygdmSO38/fy/rtgLtOwH7m+DJ/h1hM?=
 =?us-ascii?Q?S5I8fKFHq3yb8gAc9o5hDbO7zcaalqV5kbX6HYgULMd/eL+KiPivGkItj1ju?=
 =?us-ascii?Q?1usxhDTpR+ZSEXd5m/x1mu8hPhrN0OvsIPXp2WQ+nwYRjCqJw76ncD+XykS6?=
 =?us-ascii?Q?eT2XCJfNOP+/8zC1elsYqJBEfrNofKPfFKjpP9Pmg2nRHHmLpEQiDM9bTywj?=
 =?us-ascii?Q?JSNmO+L/Lk1x9FHDa7Ir+gmukFXkXJQEnfhDITl7/2Yjr9VXL10Yd35GJOIS?=
 =?us-ascii?Q?NGaOkP3W7m5QD/3xBDqspdTD++3H0Vxrbqu58iVng8fwcschYVAlegunbRT5?=
 =?us-ascii?Q?E+GJl6wvef3/dDYp5hS2DnpnFIoyMHKeqWekHQRmHKi4sQpw77c9/G+hjljT?=
 =?us-ascii?Q?XRyYsk9ACP6ZdJ4xoL/cLzoHPv6thQVT2qY1SruHedZwT3uKelvWc8jqmWhG?=
 =?us-ascii?Q?zTbvPvCEp4ymK0YO7dEXFyNpTXp2v87Uh8vHI11HRU85Kbk/PdyNItisx9KN?=
 =?us-ascii?Q?Q/45396r0IMfykGjuqVkYG9Wsf4CnPgO6Pl24GHY1jiX9BgqGzreTDybNfSA?=
 =?us-ascii?Q?m4G5xdenxH4xfxCTzVp+Mp8nAJru2JWaagpjpEsla9Z13Ir5s8YZFiBrgmtR?=
 =?us-ascii?Q?in91efQw2oSxrwut4qxeZMquGkPHeEX+yBIXATXFCwBnir2DKWT3JxRheOiN?=
 =?us-ascii?Q?cEHbMjVj2z5zyTZCfvMir95WtaQGkfLUZvCQdULAf7Bt/2Fp/vN+4LFOVqN+?=
 =?us-ascii?Q?ziyxHwRYYX0OxWLZjcweOsT7/h37dXWYa3R4QxWjdaAdEt47FrYPdfJkXJuw?=
 =?us-ascii?Q?E/kzP4SWRufZFwafxRoYDbgmxwyiWUBZhMLKDw5UGigf0XceYthdcX+R8jG2?=
 =?us-ascii?Q?+JQaXNQCLgVzsc4eABo2U41/iNDbHPGubh2lznXx6lYrCEEc5IPyqF2SFOjb?=
 =?us-ascii?Q?OOXi70csj7KpD+YEDnqor4JZuINMu1Ve0a9SEFvvjQqYYISAx4GDX9XBnp6H?=
 =?us-ascii?Q?AHMppqoNJwB0XM8pgiAcUokR2L+Anore1ZsCu9T7FI2wVuRZRHNwN70WQ2Te?=
 =?us-ascii?Q?vKGC5dxXEb6GhZBSRZj/GrxyddhUEBWcnyKjcAxcXDACkIrSZIvoLiWEr4Si?=
 =?us-ascii?Q?EsBxHvcae3uQlYjNHJ+B8OgAZMAzzmldswi2+b7OAhmSmVfLcm28H8IIg6sO?=
 =?us-ascii?Q?VBtxlZ/6g22aYPvIkbEurcaH7W1SBG8zXJJwPpMaGG3MVjCmmBvB9xgDnG6M?=
 =?us-ascii?Q?PfJ2TKp+LdmKi/YLB2o5nh0xe/HiPMiBw3QdVg6C0WrSw4SVBw9iGzZ2cK/Q?=
 =?us-ascii?Q?idCORguW8mxvdtl1jZe8jhqmEuDRXptO3h2jN3hIYwst74AQ9VUPt9ElSgRs?=
 =?us-ascii?Q?zC4UKIvja39EZZzHOlJG/50OdWhn33HN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ptJfjzIQz7H8gbVG3+pWdC6qUe6oFemPw5UyDPFh8p5aPx0OzAWRTFYpyAJ?=
 =?us-ascii?Q?4dehfYPpX8W+xNCcxqk7Mv64Vd1C4lLKrPsfjzxnUHWZ+QWa2zure/pTwCem?=
 =?us-ascii?Q?/FtC0NnBnomWIsTggttIAGczJ6+ZNudbDq5I38I5/ZPV7Ul5YEA3aFGg+QJD?=
 =?us-ascii?Q?o/lfUEUvbg6uLMC88PgEmHEkOoGzG2yJQozSB9LewDkGJWbO9cin9YUNGLPu?=
 =?us-ascii?Q?8F5Zb2sGAD4PoUpm/XGzrQAuiDmev20F4O2TqSjJiO10H44h9xtYd2nVeOXV?=
 =?us-ascii?Q?akO1XyA4gczN+PheeSMWn9ohUAUILxc3r3EXpkkJ6Wa/PmGZc5KwvQGqDSkf?=
 =?us-ascii?Q?dgqaqpXSq5vSMMdoKI3HPv7DQsBE+bf4VAT3aq1d0kAv5m7kTXN11SPoCfSx?=
 =?us-ascii?Q?klnZGZi0A3lSKs5mCavgdinp8oMia5ia8LGq8NCeAkLaGAaHSIYt/4mtfevN?=
 =?us-ascii?Q?pM8b7NSw3v/jhlNSd/qXeBeGMr3MW9WCZWKY4R0xol+jx069W+7rNb0DWGnR?=
 =?us-ascii?Q?rzMG8M6HVAALXXg5JSAuKJpITu9yDFS4hrhSCFqiT6vVObsOhF/KJ+kRINU0?=
 =?us-ascii?Q?1Im8I14xQFWUurIhw/8s0VHDJJCGzBvIqExjbDqyal/3VdArmIllkpNPC4oz?=
 =?us-ascii?Q?ERqoQFN+qTKk6SiX8otvM7/8HTOGTHwR/cSN6kHxWMVZFuhAU0RjR/I2AzOw?=
 =?us-ascii?Q?6wCrPnJ3XtjAHuUDzGK5tNIaUIRfiLHS614GamtMdmrP+7G+WdRUjR+JGdtu?=
 =?us-ascii?Q?E4XHYaDKFUIWpaf37Pg2JrltproSLSYMUX+fY5OauFQulcIdBQ+QyPfL2f00?=
 =?us-ascii?Q?iGl58qSKr7hAlPtRQoKSYmpZupzs+2BdQlCRbm7n+2yne2pxNXUHPleGIAWH?=
 =?us-ascii?Q?+C9cDO9VRdxMsaFvUANx+YBxa3rqboUFzLBlM97mCGdyeHqp4oHxNpQ+ttBK?=
 =?us-ascii?Q?SVpfBBUf5QXI+0nhHKMtZh5sNSBNxyE12uoRdw/TMGmZb0Oq6auUxJRxbz3h?=
 =?us-ascii?Q?xLRptRXeGmgDpRoxJpN2IwkGZsJcjtk/px8CGAqsMy040km0ln4Up4L/AMt2?=
 =?us-ascii?Q?izzWBtufk2FfxS+nt5Zyovni8Ax56dt54eDbDuRNk9YHZGZiuGIUqjlnt86e?=
 =?us-ascii?Q?TleIlfF/UponhVOBIexQYod3QXWr4jBdSsM4RwBuej2w3FU7R9O5QQByujbu?=
 =?us-ascii?Q?XJc4UEIHxBCyizsIesx25FSBRcmfyT5/L55r7TsXo5KXH1LgrmH8rarClXlw?=
 =?us-ascii?Q?hl3OkL7+JbNUMpWt5t8dHgdXTEb6uR4fYzRWhCvikuWaWC3374C//viQvG3+?=
 =?us-ascii?Q?QVYXXKR4SlUOwE4e23Q1WJRGIxvukFyrljkv1aITAyrxyOPOXqTGQAH0KVPZ?=
 =?us-ascii?Q?L5YGyYKFC+jFozCR8dmOvKbg2RFbOR5G7I8D2oDqxOa/0EyL8tS2SkwkxKoY?=
 =?us-ascii?Q?MxemqLVWNo2GHCD2SWDczM1A4B+nu4qjNyocs4kA0oJ15Zhhzw3Sozz5cUzy?=
 =?us-ascii?Q?8e308LPUWUSxqzbzjRH5L6wEKUAay3AOKaejNwLm+cNCUm7qxu1CFSpjC76h?=
 =?us-ascii?Q?ielaI9h6zHHNJkvxXyxSiqWgZ7KO9reykmvlAjvB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3720ed6f-9c2a-4cd9-4082-08de21c9e02d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:00:07.0256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XJzIii0MablEYq1vzceZbikrn8GEHEnNWS1NWFbunq8ygGzkEV+PJmcZFwSca9MrnrCRhcBYzrfTiet0Qq+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

On Tue, Nov 11, 2025 at 02:10:33PM -0800, Jakub Kicinski wrote:
> When an IPv6 address with a finite lifetime (configured with valid_lft
> and preferred_lft) is manually deleted, the kernel does not clean up the
> associated prefix route. This results in orphaned routes (marked "proto
> kernel") remaining in the routing table even after their corresponding
> address has been deleted.
> 
> This is particularly problematic on networks using combination of SLAAC
> and bridges.
> 
> 1. Machine comes up and performs RA on eth0.
> 2. User creates a bridge
>    - does an ip -6 addr flush dev eth0;
>    - adds the eth0 under the bridge.
> 3. SLAAC happens on br0.
> 
> Even tho the address has "moved" to br0 there will still be a route
> pointing to eth0, but eth0 is not usable for IP any more.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Bit of a risky change.. Is there a reason why we're not flushing
> the expiring routes or this is just "historic"?

Couldn't find a reason. Makes sense to delete the prefix route if it's
not required by any address on the interface.

See one comment below regarding the test.

> 
> CC: idosch@nvidia.com
> CC: dsahern@kernel.org
> ---
>  net/ipv6/addrconf.c                      |  2 +-
>  tools/testing/selftests/net/rtnetlink.sh | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..b66217d1b2f8 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1324,7 +1324,7 @@ static void ipv6_del_addr(struct inet6_ifaddr *ifp)
>  		__in6_ifa_put(ifp);
>  	}
>  
> -	if (ifp->flags & IFA_F_PERMANENT && !(ifp->flags & IFA_F_NOPREFIXROUTE))
> +	if (!(ifp->flags & IFA_F_NOPREFIXROUTE))
>  		action = check_cleanup_prefix_route(ifp, &expires);
>  
>  	list_del_rcu(&ifp->if_list);
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 163a084d525d..a915da19a715 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -8,6 +8,7 @@ ALL_TESTS="
>  	kci_test_polrouting
>  	kci_test_route_get
>  	kci_test_addrlft
> +	kci_test_addrlft_route_cleanup
>  	kci_test_promote_secondaries
>  	kci_test_tc
>  	kci_test_gre
> @@ -323,6 +324,25 @@ kci_test_addrlft()
>  	end_test "PASS: preferred_lft addresses have expired"
>  }
>  
> +kci_test_addrlft_route_cleanup()
> +{
> +	local ret=0
> +	local test_addr="2001:db8:99::1/64"
> +	local test_prefix="2001:db8:99::/64"
> +
> +	run_cmd ip -6 addr add $test_addr dev "$devdummy" valid_lft 300 preferred_lft 300
> +	run_cmd_grep "$test_prefix dev $devdummy proto kernel" ip -6 route show dev "$devdummy"

I believe you meant:

run_cmd_grep "$test_prefix proto kernel" ip -6 route show dev "$devdummy"

(iproute2 does not print "dev" if you filtered on "dev")

> +	run_cmd ip -6 addr del $test_addr dev "$devdummy"
> +	run_cmd_grep_fail "$test_prefix" ip -6 route show dev "$devdummy"
> +
> +	if [ $ret -ne 0 ]; then
> +		end_test "FAIL: route not cleaned up when address with valid_lft deleted"
> +		return 1
> +	fi
> +
> +	end_test "PASS: route cleaned up when address with valid_lft deleted"
> +}
> +
>  kci_test_promote_secondaries()
>  {
>  	run_cmd ifconfig "$devdummy"
> -- 
> 2.51.1
> 

