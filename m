Return-Path: <netdev+bounces-213281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E5B2456A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033C0581A15
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7D72D3EF9;
	Wed, 13 Aug 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8KtmNPf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5562DC326;
	Wed, 13 Aug 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077204; cv=fail; b=UFnHyKaMpBjJbwUSeRurhjwjd2QlBfcIo5kfam2ctuL7Eh8FCqFyh2VswBofF+fP6WbPF0V8nQh6loIcS7d1ru83mOfA76kX1Nx+S0zPqGE3u+4S10AkAFqCt514nw19DmtPy5AhfsLo8v0DLdWsgtqz1bwWqeY8qENANUBTTws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077204; c=relaxed/simple;
	bh=J5GLG1Yf/27Y6yz3wDv5Sy4XrAZStAQlH4MCtN4lysM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PG+j2wQo1R/fHYLl+PU9zW+WZ3Dko6Xjiz6KuNIT1pmQZg9rDUTGKMOpiVjR/IT9seRptl5GMX2hO0fcOkSf/NMcNiQ6EctjJCghhVOE3HtJK73kGf7JA2BhWtzPkuEgO4f5erXLAPxHgR4cXOTo5ZD+7cFTs1uylT04vUK0dzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p8KtmNPf; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7HHdWP+qr6dRtF5IyZdaqYebUjHjCB8mk0K7bu1p9GWsP9sU4tw5pI/4NmW9mL/dzpS7+eGZAkE67BDR+uvsLvYgtXe71/YOEWrP00fDhG2yNA5yW+VukUe19v5ei/2HwrZNQ2Mm8SMDAncFMm/KHV/Tm7A4oPYqhsipJg/tuwk7cyHORfYoX1yPcJl4ODK6wPoAIPdnUvHHJHMwqT0qKebSgvv4wu3hAQWeogNN8V0ScqFP6yNQzXt52VIoGjHjdhmFE8Ub1iLMfJPOhaNzRbvn2TXRlYidE9kvdStWINNZsA76CVJ6fKksY1slgj+nB8dFZB1bdAEDElvyXKIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbOtup1f9PkZJ4n4lsUm9u1LO5z/6Wo0dPl2FcqSs1A=;
 b=MA4cOJ2EudsrgEA0qJYV2+25AwtSOEmPvcdhPjpkQtYM86gL/EZMt6BQ6ZzWv4+E4oK85u5R8DsplOktH47QUVTfHoUc9p3fksjflV7cmOJPbctVYvRkUm9Nmqq8tQYwNz6n2JhWgm/Z+NuwtDwvyhd9x8mZ7ZlJxqm4O+1Qo5yorcCkW6HSrbz74y+ChM/pdNvsWpM9shmLytlJ8UQDdrH10rnjR2n5j0pZukQa1CSLP4GTYK+MYaT04Duf6nRY1AoDS1L+e5UawYkClVh7DhkeFMylDb0pJIcZeha1s+yhikj8iLTJSE8LqKW9sdsxs1z0vpQuOX5oH8xD4dk3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbOtup1f9PkZJ4n4lsUm9u1LO5z/6Wo0dPl2FcqSs1A=;
 b=p8KtmNPftWrCmXhmvs4jHDyqrpg2D9OrIfeeflqHbwlcGeWZkod/ON0lq1MynUc1340c1I3/kPdiCi6WM4rn737100sUe//3AIJxpuNTF68+7V9bqMRcfAQ8euKPhRWpEfkVcr91WD8v1UT+qOV+wP/rTR6TFbMeM2gaQkxSs/sv3Rz8KwlWYzyfte9trmZJqAmH0ELZVQHM5RBTLfeESy/M4toADh91q0FyMFM8or33tYl69/dwN0ajqcnt+pog1L9/3xdpYpWDL8USWMW//LSEcsK/JUpYAEU521KiFIuQk6XVwWoPPfELvxt0n3s7jqYcWQ6rOSQCW8VStK+TNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 09:26:39 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 09:26:39 +0000
Date: Wed, 13 Aug 2025 12:26:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
	shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
	razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
	martin.lau@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] net: vxlan: add netlink option to bind
 vxlan sockets to local addresses
Message-ID: <aJxaR0W9v--dr45i@shredder>
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-3-richardbgobert@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812125155.3808-3-richardbgobert@gmail.com>
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a5e431-ada3-4960-a788-08ddda4b822c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVifncdGEjbJJVohI0iwQoFA6E7lVOdgJ77RMVRk+1hNd8fjQucmfdo1GNTV?=
 =?us-ascii?Q?+YFV9m82Q18x26JMD1Qt5ZuessJLxNVJaxdfpqeqpM+9ueGvQEP43GJYGeiJ?=
 =?us-ascii?Q?cN1WvyRfnoZWu7UjxcYnLCrTF8TMbXbNz8jPYddSY0d/r+Gxw1J5mo9nKfSw?=
 =?us-ascii?Q?8G64n9/0xgp5f6d6NNadrw1DAy/pIYpJipPJuqe27PINDUYZ5qoTu2nZ0/K3?=
 =?us-ascii?Q?/Ta+NncHy7JbdkNU3qOWbl8lhSFXCQZkCAx54uOtZTJCAIEWIH9GqCj0A9jp?=
 =?us-ascii?Q?LCIr/vcIr+zUzArG+w589SFgU0rQSVjyjPBLPnY+4HkD/WEmKVeKw/eK+iOL?=
 =?us-ascii?Q?//aaFd9KX7yAEob2TukQy8EymQyXSMszOOnvLdshh7WPt5igpTAV+N0JWqJj?=
 =?us-ascii?Q?6mES5WGsq0QSa9Web0xNTq8L9q6HUuC4Bzo6nUbT4x/c1iU07rurcWj+ME0I?=
 =?us-ascii?Q?6MIq126UyijEXf9g7en3bKh3OqBFd999b6u09K+thtq1cdzukjZl1RaklIbB?=
 =?us-ascii?Q?6uXl+IePPa5+7v49FQ3NAGDhYB+Kp0olOSK5U4heYRJo8fzVa9snBD0+El8i?=
 =?us-ascii?Q?/JZy7va+3hGaoT5+7Pw503HwIJm5uONtEcgcLVXGT+9KVwmhygfr8VNG4phq?=
 =?us-ascii?Q?eTFNPChTEMuugaNM/ghdWE558re15220j3mcKYSLFxCuMi2GvKnLPOjEO+ao?=
 =?us-ascii?Q?LY6ZPOY1QqrNzxTSsvHHeGPnbq2za8NbwjCfv5OZXCtbGeasDOKxaWFKHd5B?=
 =?us-ascii?Q?RBstiHgmjpV11XRk030bepaeSL0QIw+IxKEzy4PHgqBnR+ZkNC2HNx2zntlH?=
 =?us-ascii?Q?31/WQ0Uu1Wmb2cvEi+bTvr6ivYRKkIT13mT5YN3sjMX35rbD+EHmZGAlcCyc?=
 =?us-ascii?Q?ZMKFGp9N13v9xr9yWIdl/9bDApLb9MI8eAeRJsYVeFszzh1VkuOGMxxqeJbA?=
 =?us-ascii?Q?idF6hW5t1wEa5ueRnzWUWG9UuuVq5EpQQ8PJydVEgaLZVGFywHDbMi9351+z?=
 =?us-ascii?Q?qJB0d+1Oj4PZmFy/9bniCMGMPoEsciwFeKuiit+JRQleVQytMztTrJetl4kh?=
 =?us-ascii?Q?darPODZs9uLlC4iJZwuesrz/MIlE1/yfwi64oICkKzaDeJdB6vR0IfRZuuoB?=
 =?us-ascii?Q?x9EfLoxoNAMMo1TvAfDF4eQfDR637waYERheZvq3N80OJAliqZ2+TKgFY2Vk?=
 =?us-ascii?Q?zeA1Ve96H/F5TIWj0S+S2lZB0fL7bK83ZUAiTwydfX0dNG8R5SDf0+ogfb/f?=
 =?us-ascii?Q?GidmmdSwIqh8oWRu0A+KMUqlGVOvMAWy/W36IL0v6w3Mb0MF0EDMW9aHZQIV?=
 =?us-ascii?Q?B/vSJOHMDueZ1lHVWHVzLzOQdr8wUs3nLmAk4ZuzUAST9dI2dwwj6BQRVY+L?=
 =?us-ascii?Q?xoGfK64LOH2ZVlFhrx4KJKX4neK+UpXGSumGNDpCUfVM8ZaY8rzl1xR/NP3k?=
 =?us-ascii?Q?/P7fTrwscBA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/7pxQ5Rc8GFdQlUxU34XSswhKX5P61fIoWClrsXqvKRsBV832Wzb/8YC335?=
 =?us-ascii?Q?zitSotCGJpRRKsNa9vL+uPfcVxhGP58dgE9Dozhfe7SoOoJY6nrpDGhG7maL?=
 =?us-ascii?Q?gjrAtArnLKUU0sesIKbILsRX66jPxWV4uyFOLISY0LhlGbIsIUe6a7gYaOPv?=
 =?us-ascii?Q?PdaQbD/0+hNBdwlT/TArP6hhHVoNa3TnSjykkvm81G1I1swW/wq4NJC7tiDl?=
 =?us-ascii?Q?SPfjO4GNXki6VofWQJSjE6Ixl0WyZ63ZvoINiqFFeLXENDcFdWq4lYQ/fh47?=
 =?us-ascii?Q?tpws7FVeE6ndMS2kqnWivD7+HzmD2uqta/lLyXb1cRiZ/jbANt+SIsaHy2LS?=
 =?us-ascii?Q?CDzU+5M1oDw+U9el7GEZEa3Za7/qjYlG+0mtWgwayIT9n7wRsyBpVZdtX4GA?=
 =?us-ascii?Q?u549TVZyIBU7nSvfDHfTrPhwB7RE27OeSL+elePeIACxkSv9JZg/L/p2ehD/?=
 =?us-ascii?Q?N7gsyO/G/V1OXIwoQkfY8r6UEeTEJltnSm0YoGeOCdRAyOZ/AdW26ofqHdj/?=
 =?us-ascii?Q?Y961kPA2FdtpnVHKEnF5ndXZedtIHlurmTmtDxNPTJXA9qJ6dAtDA2dvXccD?=
 =?us-ascii?Q?vKJL5UyFi73farjosQWo3EgiGEj9VSPdi45gTAiDFD5ml0cmHJlTiCqzG5Yv?=
 =?us-ascii?Q?XsNDJyMNMJL3rDycYyWMqnsek684sE7rjmg4+DYLRzemT6F7D+OpY70WOJVw?=
 =?us-ascii?Q?H3bmMkg9fjrMmn62RjuluwIwI9CYiseFAvWn44pn/npeXEUh8OtlEC/vxVie?=
 =?us-ascii?Q?0V2g+MREqUregRM7/viXlY1v8mFVOzxNArllPw8HEMYVA2Cre+l4VLx0WoX2?=
 =?us-ascii?Q?qeUUn1ZMATVkgaFB0Ud/V6PB0qShBVllQAwUtyVAt6eyaw10E7WYUu7oIESg?=
 =?us-ascii?Q?6TkNTnqwZe7zSoQ6yYTDyMGkOfBfgdMB18ugxYlCyJSPwp34Q7N4CfYgno9f?=
 =?us-ascii?Q?AICiv3xj8eLwo5FirtN6HVzgZ3j7ZyRpBTOFBM53L2bqFgP603nxG5XJdDPy?=
 =?us-ascii?Q?fTjaO1/WCXLNCujYpBhioUaCDu8TuvyiJI6oqP0PAjVOoK2gSfkNniU52BoC?=
 =?us-ascii?Q?MMxIfDkKD/gmsfj3YdIXlNVdFBG/gxy0HsXB1Nhov+cH2lM03LcL8hcQpFtA?=
 =?us-ascii?Q?rZUJs5m//GCqF6gjJHGrFn8m2bLYT0jVeQSvmeEIyUxsaz+JFsekasQhA2vH?=
 =?us-ascii?Q?hnSP3loxtGpvFS3BLrZPX3CBP2HegwFDiLhC3AZgtBXKXHxXjwoRnTYu7zzw?=
 =?us-ascii?Q?E/YffsoiYXtw9Hd4DZclQThHfFiljyYsbeEtQw4RLrGWlPNhYUkJSj21TyZx?=
 =?us-ascii?Q?rnKzIUT9TD3S++U2JzVC8VMuYJTS4SMqc5FWmvxXFJqt0cYVK8AJMssa5gUo?=
 =?us-ascii?Q?heW9UsPqtS7Nk7jaBafxu5GtwPrl6Pvb11vagSwZIxmWwCQE9rQoFl/BrU2H?=
 =?us-ascii?Q?xdYWeopmFEp98hHNz3yXqW2igPgYAtVjyLXP6soF8rxSg16c/FQgug/zSMP5?=
 =?us-ascii?Q?SBkv7Sy7u5IaR7xMFXpdmlaGMCs169Jewrs8/SyeOhaEBXxmr0NrOukyqoUE?=
 =?us-ascii?Q?7Nfsl3X3nZUXIenpMam4y+0hAZPUAYpYzipwtoIR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a5e431-ada3-4960-a788-08ddda4b822c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:26:39.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbdIO+WHo0f17WCPxxR7vYu5bMWCYsFgnXcx8JuAtrkIWLgA7ICxNJKkq7zH8eA/61MWFbFatThyPVQ+2C5T9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

On Tue, Aug 12, 2025 at 02:51:52PM +0200, Richard Gobert wrote:
> Currently, VXLAN sockets always bind to 0.0.0.0, even when a local
> address is defined. This commit adds a netlink option to change
> this behavior.
> 
> If two VXLAN endpoints are connected through two separate subnets,
> they are each able to receive traffic through both subnets, regardless
> of the local address. The new option will break this behavior.
> 
> Disable the option by default.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c     | 43 +++++++++++++++++++++++++++---
>  include/net/vxlan.h                |  1 +
>  include/uapi/linux/if_link.h       |  1 +
>  tools/include/uapi/linux/if_link.h |  1 +
>  4 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index f32be2e301f2..15fe9d83c724 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -3406,6 +3406,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
>  	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
>  	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
>  	[IFLA_VXLAN_MC_ROUTE]		= NLA_POLICY_MAX(NLA_U8, 1),
> +	[IFLA_VXLAN_LOCALBIND]	= NLA_POLICY_MAX(NLA_U8, 1),

You should only expose the option to user space when it's fully
supported by the kernel, which is not the case here.

>  };

[...]

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 784ace3a519c..7350129b1444 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1399,6 +1399,7 @@ enum {
>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
>  	IFLA_VXLAN_RESERVED_BITS,
>  	IFLA_VXLAN_MC_ROUTE,
> +	IFLA_VXLAN_LOCALBIND,
>  	__IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
> diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> index 7e46ca4cd31b..eee934cc2cf4 100644
> --- a/tools/include/uapi/linux/if_link.h
> +++ b/tools/include/uapi/linux/if_link.h
> @@ -1396,6 +1396,7 @@ enum {
>  	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
>  	IFLA_VXLAN_LOCALBYPASS,
>  	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
> +	IFLA_VXLAN_LOCALBIND,

As you can see, the file was not updated in a while and will result in
different values for IFLA_VXLAN_LOCALBIND. I would just drop this hunk
unless you need it for some reason, in which case you can sync the file
in a separate commit.

>  	__IFLA_VXLAN_MAX
>  };
>  #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
> -- 
> 2.36.1
> 

