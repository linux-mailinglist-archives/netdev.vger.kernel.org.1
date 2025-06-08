Return-Path: <netdev+bounces-195561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7EAD12B6
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 16:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F8D7A4203
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA1B24DFE4;
	Sun,  8 Jun 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3Idq74e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF6313C8FF
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749393893; cv=fail; b=p4Qg7FIZ8txyQoqTWaaqEH8dzW/1DzSdjfYjWwVj//+RnNvr4Qzv9MwLrYb8Q+dxPk2TQVH8sdbcVYNqsNZRdDjg69fxNiY3exn0QrLrBgs96SGL+mhWByS+Lmma3HGa+QlCHsfxKAoEMpekFVmAV3alst0sgSwH2uqcNQMUy5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749393893; c=relaxed/simple;
	bh=ftPJ/30ewXhIkk8stl1eIiXSzJdvexbFqTvJHWMYqFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oLUWOmGo9j+U1DlItu3myV0ZkvN9NFGTEKPFP4WzdgPV0RE0Pj8egjCwcqZm2i7hnzVte4IeWFEWptLfM1JqBzgzzaEnC24DDHCWq1kd6Y5MY1szlt0qTjp7YDzCglBdbHlRgr8fFQAS+Y1rOYmIb0RIULsjhreZMibPSkxmkG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3Idq74e; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhR46BRlNXBF6KcCqNe6xztJbiK0PoO2XrPFEXo7gZyztSRbtH+eKTvxKmGQZ+VAkCsLZbsds72XgjFlzjt2t63ban6IYkueetvBVrntanEFHxr2JagHomgN2j1ZGsRh/XXuHb4VRycc4E+eiuyf8PJ3udWjYe7rhgieFfC3NfkXg8hT16xKKvq+0pjFTek6bOCUOpNyqLH8VJLttAflG1luNp72c/B6gEmSba9tPckDX/KmeJ9bWVciNzfXHczWHTjDZ/Zy9lrOHvZKoBjaE5ezmbGGCLFV5NVOz9m1k1tdgUckMih3ki/7lbXxUP/b3ipBB/mIry0nH8uPSLa+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6BHDDKcmF4zWLG84XUkk/GEeZJn2l3nQM09irF9h50=;
 b=AJtsGz9DeCBO8Irp67gO9cPZvSfDC+zWNwiequGD08jWmE88+dHs04AgHt9J3bd4T9xPC/lcc2KBE8rG09mqXPITK5fGt4EdDHV3urUOncnkrNJt8Xly41p2wCmB7ack7x3SQCY03F3QYfFgRGw8zlDaxjCpkGijLRcrcoYbOMynR9ni3+8FLQIbYyaczqPmyKLFJ4W6Ngc78JL1tTuVTC3c+zvtA4BR4DNdJtt5t+6ZhJOX1RnkHZQzjJqhgJ9/ztz5SxeXUSMHztudCyBRegKjKtiohzvvyTbjwupTGLiF+Y0B6WmiCAT115TLD+2/GKrGTxguey2O3VBVgk/AAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6BHDDKcmF4zWLG84XUkk/GEeZJn2l3nQM09irF9h50=;
 b=r3Idq74eo6/ZBRZvlgJKOtOZRblNsMB3eKsQ4ZED3CD7eFsNg0qmojzc7NNZJzQRdrOQJfHJnGdqhaUn8cxP46j4ig54qTMmpevfhKvp/tUE5R6bvhiOlWjXUAHg+fPWvqdhVJY+YPIQSje2FQnvrTRadjE9UUl+wy0gs751D4Qzy/PkftSzSdpZcE3HedlavK7RROVHCjVWU1BvdkW8/uTAlY+qLjVblzxOegTLR/+GRx/kzgmgKpRt9YApruzwFlpMNMIvNfPQUkiED6d12i0tk2BrL6WXHZuI9yXiPHpGrimVIKKNeEiBRt/Boj6GhnTOwj2lOUPAbSqF9bqO7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Sun, 8 Jun
 2025 14:44:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8792.034; Sun, 8 Jun 2025
 14:44:38 +0000
Date: Sun, 8 Jun 2025 17:44:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH iproute2-next 4/4] ip: iplink_bridge: Support bridge VLAN
 stats in `ip stats'
Message-ID: <aEWhzO9WUiwZsaGl@shredder>
References: <cover.1749220201.git.petrm@nvidia.com>
 <997a47a1dcd139a0e50ea4a448b45612b58eac69.1749220201.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997a47a1dcd139a0e50ea4a448b45612b58eac69.1749220201.git.petrm@nvidia.com>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f622b61-07af-4eef-711f-08dda69afec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KaAj6G20PwZbw/VPXTArZnglg49NBf2NDjIYAHiNaT0yeLtC671RG42VqoBA?=
 =?us-ascii?Q?jcVvPY8HZr5DPoT76Hll09iXcQ1G+7dUGe8iyLNlrqIwaCvWA/6XPlrBs34P?=
 =?us-ascii?Q?74ZSQGOsXE8bvm03OUQb8rsG0ljXOpKk8UFmWVhmxK9KYR/403wXnRkQMKWJ?=
 =?us-ascii?Q?wkG5kKwJ2GqONoRdgoeNoRnuRV6SsD+JPlYzdLYFGS3oiiBDMPrWL07FXMii?=
 =?us-ascii?Q?GrDxz56SYNtbOd2/ajW3YAsjWszjh5EvWUsluZngwXKb2hkDz5HoqNz1TT/P?=
 =?us-ascii?Q?6ccicVFu+tgVU38NLhTsvqA01yQQXUHExQmZFfGYJRE8wpmxEUdrOUqk0l9J?=
 =?us-ascii?Q?heK84RWdGmXc4mZ55uT88hxIvMdPp+IvbeYbxmcepuTClyAmydttpoM/3/DL?=
 =?us-ascii?Q?Jbehn112XzCydslSeeeGyqqh/4vFBr9lXsy8f//YNhl6OZI9rcA5oTnvAKz1?=
 =?us-ascii?Q?NVdxvXPQutnUurgFoVvV2dowLER1CPMRZ2I0pErpDx4+JWmSpNyYI8OzexpP?=
 =?us-ascii?Q?InGSIO/aWB6taPKUxzBU+iqbzyAsJ6mHdoIRxvX1NNzhbj65up9v2xLEvJ2V?=
 =?us-ascii?Q?bmmOZWPTqPW8IvkQi/OsQXDytav6JuyuvAQWVcspOPYwCIEEKRdidA9sHHnS?=
 =?us-ascii?Q?NZ6hjlkVhcvfHuDf7EZIuNvhl+EBdcOmy47OwBbhfWxDInF611uH6NAFBaSB?=
 =?us-ascii?Q?WU/xCYMgYWNzR5PUXGlB2ltbK2u1hFPMMYr4lUCoaUTpDQqMsIbnB/jqOn7D?=
 =?us-ascii?Q?gbi16vVpJ2jC6ffLv3XqlRVOkQFrVR0jsuTEAqE70Qz9DbUFLOGlBhSxr6p0?=
 =?us-ascii?Q?4TYxc6yigEOWBTHm4K7VG6yE3NZMsdPb1Ok0PvrgyJlD0Ox8M6cVAtBZ50TZ?=
 =?us-ascii?Q?W54cY1nYEvmcnAdP6iFktKZvfI105BWNpBZQ8dE99JrnpyUBm+jq00NdmWQM?=
 =?us-ascii?Q?/F6VJhkvnHoKgqZSt8wKX428A9pdDfH18RcRJcglVXcSKO9tf8NHGUQEePqo?=
 =?us-ascii?Q?CpZHPdDO1WTX66Grr8NIrrqmeD8e1B3Yt+CGFLOlNW9p6CoqHvFYWZpfqtSk?=
 =?us-ascii?Q?1BF/H82Mw/7ea5EhZSzAWZclPF2Xlrouq9yf+1Ano+6a3ogs7XGjNEkBZzjU?=
 =?us-ascii?Q?iS4A1vCVIiXYIFpt1EhkJwiGXx2DcU4OKKnK5eGr2NzCnCBybtGrDldnmgCY?=
 =?us-ascii?Q?cEFWHA2xRv+byWGH2MB4NaPPWv17LxoVs/v6adrioP7AN3uZbdzPSoFHp44U?=
 =?us-ascii?Q?QXwkqYkKj51AnkcsagRaMjt9/b4KyfOkPcrNupWDcuSaijjOyHp+Qdvg4bzc?=
 =?us-ascii?Q?lIHRtFtiklxrrO11KHu3nuAnEirfaf+lhlrzMAinjrIaWnLTqwk5YJZxNaFU?=
 =?us-ascii?Q?eMtpIXFv1W1Y9ecM99A/GO/qdJAw8wmEbb95NbBsZSZtPX1QZkjKfW3HWm8E?=
 =?us-ascii?Q?1BDf0vx876U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2vxp2fBl8wZLUm7JD+Ijkmu8CfKrURZZAX6kTuX+feKiY84hE59hoMMvl01?=
 =?us-ascii?Q?zZbGD6xxXqAfPwod3hwhv8v/UySpOqCfZZ6UKYs5XxRddRqPCib8HLUm2QXq?=
 =?us-ascii?Q?kEKC+58/FzMEvuc/QBHliIOD0rkrqUeF0Jn+Le3csyrPG/AcTlTPGU/pFoi4?=
 =?us-ascii?Q?ZE97q62G7KIQmnRzHWTX24mYjY4jwBcuua/s040VXNqtzpR9/i/BZDJJvQFU?=
 =?us-ascii?Q?XSKEx+43NvVXnypYwCvIavYxrzKJ4qobjZfs6mg5w6LUJAqpbKdPPS3LNLHj?=
 =?us-ascii?Q?Vg1y+8ApAiQ1+XatollosvEPnfw+u+c1zbMzQxX3piJNViFO/MBO4hyNt69J?=
 =?us-ascii?Q?pA2KLhcU2ZAi9VYmkFUCF5+Qk4CyZdyEeXG9ZLWCzer8hlz7EDExy7Dcg1ye?=
 =?us-ascii?Q?hThdl1T4zcz+CRHthn7rH3NB/LJzYNSQdqGwz17erBcDPsGtkABY3okK+JPn?=
 =?us-ascii?Q?7nRxQsD1Ls5ev4v08Zh0XRAq2x7AXGWbXSpJBeQJZnx9aSo9IVlttvBEP6Dj?=
 =?us-ascii?Q?lqFAhyvzlLJRbOWuD4EAkLcE6id7iveyl0dZHi/CjKqgzWV/LrkPFNbImdQn?=
 =?us-ascii?Q?JGiIPcPyhgBBurKgzodV10/+ugjImlMCf2Rb+/9vT/+og3ptM9wOgZ65+89n?=
 =?us-ascii?Q?NiTzcPYYSGE0Rr0WH/HBdWzX+Br6jnDwH8nE802Jd0RzS5DLMqGa2cv7gbX6?=
 =?us-ascii?Q?Z94IxbzKfY8So4jt8fuVBwTPjpXZZ5v3QNKeSZKth+HeRz0SlTQJLqLptsWj?=
 =?us-ascii?Q?Ghc8oiBznJCtokX4X2ChjwO5ZuK/XPH1RiPN7khgRnkzBtheNeMer6K+Yuwx?=
 =?us-ascii?Q?x+0fVj7Dd4Ir14A454Qe4MKH/lWBw4PrVY7puqNgxm3oBFp8e4QAlmOnWkEZ?=
 =?us-ascii?Q?FhxiCpYlxMOONe1RhfoOK3VzjRYJG2Qeog198dgQ+V/G9HIYlGLgTWIj8r1Z?=
 =?us-ascii?Q?pHmvOCj0PwwSlISFNqUoz/g1CMAfOn9NB66AT3RPsAa32w4WHnEsC2t93EvA?=
 =?us-ascii?Q?cKS6J+gUygDhGWsW3+R34CEKS9SpV5F8t1XyO+pgJXxA+laaxuz077lWtvHt?=
 =?us-ascii?Q?DK8K3GZNzie0jj3G3+X/SQ6EdUqSE8ZkaYoo/j7pCdghyjFATqykam14PNYj?=
 =?us-ascii?Q?YS+qB+kNkQ+FuXguFXy5UWp5CW0pCZMRgfoNPeR0nKT6g+Ehl+FqZVHm5F+T?=
 =?us-ascii?Q?xh9GxH9YtGsFCYU+6XPi66rQAgh489xeJ+TXLM5DUCUkeHmmVxR4rHmPvL3a?=
 =?us-ascii?Q?aUKfs02JwtGzWFkxXDnnaxiwF0vp7TDAnfozTnDpEaETZ8mykP9I5Z+q/bEx?=
 =?us-ascii?Q?CIjVTXfGJcriJmv6ouQNdGkStLB5SjRQR185EqPbtuAQ10TKCBXQYlppYtl2?=
 =?us-ascii?Q?2tAfcC7HlKtUl5XuqtG2S3rD6N9IFTfOl6Cern6GmGsT0C3hM9byo3MyN7pQ?=
 =?us-ascii?Q?p2VvuWOdpGZw5ERtXEsTdXSZXxlpAhuPgU+n7lCU8TI7rn/kUBV8CY5kZd51?=
 =?us-ascii?Q?qayBYwdVmxCtPlBtU5Jpwq2hWdUaLPsLJtNiU/iRSwoS8Ff1b+Z94ZY8KjNo?=
 =?us-ascii?Q?VH2w0DuUGi5InQNyeVKr07AH+yHs8UwNeAzkyQQS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f622b61-07af-4eef-711f-08dda69afec2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 14:44:38.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg0y1atmNb1as/ObnTKf79HePt0u7DvWbBB0pHyF0KMLsadzttFy+xWJ2+vreQ66GGyf4mDXGwyRf6tU8HhCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871

On Fri, Jun 06, 2025 at 05:04:53PM +0200, Petr Machata wrote:
> +static const struct ipstats_stat_desc_xstats
> +ipstats_stat_desc_xstats_slave_bridge_vlan = {
> +	.desc = {
> +		.name = "vlan",
> +		.kind = IPSTATS_STAT_DESC_KIND_LEAF,
> +		.show = &bridge_stat_desc_show_xstats,
> +		.pack = &ipstats_stat_desc_pack_xstats,
> +	},
> +	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,

This will only show VLAN stats for bridge ports, but they also exist for
the bridge itself inside the IFLA_STATS_LINK_XSTATS nest

> +	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
> +	.inner_at = BRIDGE_XSTATS_VLAN,
> +	.show_cb = &bridge_print_stats_vlan,
> +};

