Return-Path: <netdev+bounces-199322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9800ADFD0E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B553A2A8D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA72417FA;
	Thu, 19 Jun 2025 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ene7OnXN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17931D555
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311503; cv=fail; b=h/4uwy35hK4Bj5OctCiWc0Kr/JXCaoD3bTc+ctf4mLuU26QETBlfkBkZEGusfOFtteNzkDet7f6R6PXBn2VfiFVQpaYg0o8QvpHV8/CgtCNzCAxWhcablslV8BRpSJa+QMbb1n/CHUq/f455h/qOIF5Vqyb495VjfkJsf42IS7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311503; c=relaxed/simple;
	bh=WhgddMO2SiAODE/MXrESxc4f+JYBFfktl3eT3AJWdXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=reCeVZnL6gTVccvdjZY1fpIWaCvdYgwepFo3zUbdlJLoP0oM/6GNZ/WqKy1zZbVR3YMBaP82at7Dokp8lZ7K4UTHYls9OP3iOiOH+9cZrWFLvnuwSqTWbL2xy/5oRJD5c86M2o9LxeIadt/mPAnANQqSO94+E3VuZpbsStzc9c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ene7OnXN; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyHEbny8dSII/eNlnI9bcat3j/QVDgoXioCtL/nr/hTCtkh+8HINPU3NUJOAk/1TcacAQFjWKaIbBdHRuLj7sKHX2iklVjCyfovrx8L0BfzMqoOKbs/z3+vCtIzV5GJf7Vwh8zcwLZktjhZcqnScfc3WCqaYePeUu3KBsPGPRcZAidmQ+bFo9u0dYIVo9jnhnR2lDfdU8fz82kAtDc5ojxY0igsRc5sN/M/3Wg3/LKO/G0DGIzbGWoiwXoebsuz5ITKf4hoV5XD//IiCC6FpQk8Xk3s8xl1WQtdLMVA6Kxj+61cat2w/XpwBx87FOxase1VYR7K6jshS+qfcOTNVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw6V6lddbPyRTUC1zjqcA0eY83ObcemKYatfILxUtHk=;
 b=BEpFRJFkqm7PDUF2Hm7q4DkW6UXT+1zPmxwPP72NAHWH7GzKUp/UV1m3NEOlwOveekOoA7lKP2Ow+7tk0CLTWQR0CN/uCDDyJQWWiKROvk32j55X9+vtseZdjBZN1QuBiL5yQgKRBN2ZjO2iLzPWTYUgkTpCPliYPb0WBGOUybvaLSa+Olyf0ZEYjdQYNYI6DKc4yN9Uvhck1VfWxmap8kat+PYZ3kWuAoMz/X2+/HZse4XrTt/8G1i5/q4R68bZQEveQ+JBU9lhIPHwHSn5f+AdTE3TeE03ZvctY018q01LMAx1xOodJYilHuKpNWHbn8tNnXBJiqcttzWKaSdeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw6V6lddbPyRTUC1zjqcA0eY83ObcemKYatfILxUtHk=;
 b=Ene7OnXNFyPHXcRL1gPD0VRifjboqwbfFj6ycldzLDX5BGc7tdw6Lj1aquJ/BaXRBs5qc9HsP1rbcauLAaO+LtCMGPliuSDyXVsMEGUDpKpdCSt203WALfaVqhEmC8zRG2U1ubtrT26iTK/bqpvCBVm+zk/QOWGCaiIlB1Ju9NASTR8r4n9esS/QO86J5G/IJoTgugoyfx+xjSOr1mSfiuoJ+ta6JKKiKSsIH8x6ZWamN6Nw8imgDMA0o7Uv3PTUyfqHia2I9PX5X0kAhrlEXBjltiWJKC6D0Qccr2CIBXowzB3lqTwe+FGmifMr2rmoDS4pZJ/0TVAJUTa1IpPp5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 05:38:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 05:38:18 +0000
Date: Thu, 19 Jun 2025 08:38:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ip: VXLAN: Add support for
 IFLA_VXLAN_MC_ROUTE
Message-ID: <aFOiO86Y7GcUl5OM@shredder>
References: <14b0000cd0f10a03841ce62c40501a2dc1df2bc4.1750259118.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b0000cd0f10a03841ce62c40501a2dc1df2bc4.1750259118.git.petrm@nvidia.com>
X-ClientProxiedBy: TL2P290CA0020.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: cbd8c171-16f6-4107-b62c-08ddaef37ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a9XXcEpFSjVPE47GKfkEA2UN9ty3ZDn7ZYlzG9/QRrMfj1tdcdlUtRRaTpXN?=
 =?us-ascii?Q?jHgzAI/2JsOMgBhBA2NtteuD9Ygie+BWGF2Gm8ZxntmgBzMCJye6R8I+ai7D?=
 =?us-ascii?Q?P6o9eM5XlB3ImF9VxcBq9CQzSzXZLxKTFpeIzGf5O7XARBk0M0/8KIHOJ60T?=
 =?us-ascii?Q?JgxvcHiIb193zmEIhISdlMqAog8TBQ45MRq5ooJOmh/uDusrzuDkMOqdVnQe?=
 =?us-ascii?Q?uJoSJFptDkOwzVH3Tz/tGKGR6ij8jQhabi8XT/9YinnqIk+kjwj2vrj37nEx?=
 =?us-ascii?Q?PT+JLtW2su845JQm+OCayrVk7H7kWaK7i9YfLP2Azc3gbfsNZLvxV48so90T?=
 =?us-ascii?Q?Y5ELwd7Kv0f9m9V3Dx1O+omHR2UrTUYpbJ+05YOKUlTKv0Dku6DIDwkeGusZ?=
 =?us-ascii?Q?B0CS/pG35sLTuNm/fO9AGzwRZI0NnnUolbi02NK3bXHCRCueqhPdx+Fq18a1?=
 =?us-ascii?Q?JfNtIOWYCZui+J9D7ijrD2QfEsM8I0WAnLTmhIbBg4ckkCYfTPcPFXjT353c?=
 =?us-ascii?Q?S4+vvQP25iwiZcV074fLQBPcY0dcMxyk7w/OgHEuEOQBeN4FGamxIOa4rqh/?=
 =?us-ascii?Q?yJx86k1j/YSHr3rLDNDWMlV5ysSGFOGFcfJGtgziDH1rwMMDxljJmF54ImJG?=
 =?us-ascii?Q?AviV4M6z1dYxkE5gYN7tyjytrSv4GpkaW4xPCxVvM8KIwFNyNhQ4GpdWyD8e?=
 =?us-ascii?Q?FvBdbL2WtK/LrSqzkRhPHNYUYYC5mZT1otzwuCNb+noUdrkjULOlWa98ExOJ?=
 =?us-ascii?Q?YIl984m+SvdyEhFFGsYsTdGjZN3Ro/rcR6Nu1eAK/SjMadM+5shg+6RE7kjA?=
 =?us-ascii?Q?VUnfWzdaj6jQMwtwPcVB1UplvUzpV172/JeulwGe2ISc1i4a+kMY56Erdcq8?=
 =?us-ascii?Q?N7rvA/dc63V9+e8LY/E8JT7jYuasoWkOgTmzQgo9SRfEfZ6WXC1C8vpcnKeg?=
 =?us-ascii?Q?0lSy9YTQNUtQxfH+n5bi90zoOMmmQDyWNTCgzoNqOW49aKtCr9slRk7tCff6?=
 =?us-ascii?Q?IMgOSv/KfyYzj0InmM8FNW2eAHCy4zTSlNtqj+PNIVPn3LyJAnmswCyZV+Gh?=
 =?us-ascii?Q?gt1fzgVDQqkANuQ9RGiPnYPcOvEeNTNb797aFVxXhzEi67yjU3Z11oLe4HQ0?=
 =?us-ascii?Q?4ijdd5yItAha2xckQ+GxHlbyv/LlizTQvNjjCIDu81UE+HxcZk/hkaxat+5A?=
 =?us-ascii?Q?FQUKCxkSo70vaY1BT6owo6x+rTsOGW6Jjk1eoQKNexsbbF4tzuREJs27jwKe?=
 =?us-ascii?Q?R71boZWdGXo4HMZMaRMu5MGa+Vg1Zsa9R/7NC3fr0MqvO6CCexLdjvVBv6sv?=
 =?us-ascii?Q?p1BodEORBFPWKqqRBv0MMaqyqJT6itr2hj+IMu2LWXsfIT0q/bzcB/pQMvCt?=
 =?us-ascii?Q?KSqWpmiKXOmx07Gq4b27dyb2LY9u9d7ADu1rUnXZYGtrOOTYFLm2dBtseDWw?=
 =?us-ascii?Q?iSqs/kPZmDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAEKII+fikBpWteDBPm0iF3zRMFEJU3LTacxDTkQarOq8xc3RC4Ma7hmJPCM?=
 =?us-ascii?Q?UF32wike9IDWrM8YG9wFcpesDjKQh/gEGpx97MnQG3vWY6tQ9K0hNqlg0X9C?=
 =?us-ascii?Q?wLMS5xKDN8o78VpinCUgNHgQDBD4i/x7Myr+wPOSZ39V7Q2I+oJ+6cyP3jGe?=
 =?us-ascii?Q?pSNprZ0zpPKOs7HmsSPXhRO5gUd05XT4h10KuqNn0Vlb75+mSZQqdHJThHER?=
 =?us-ascii?Q?tLxYipfcyjcbtfOukRuN3jSZKq32P247SzTgwUqIEPOymqevKHOXr+hNSbRo?=
 =?us-ascii?Q?ZBb1/iVZNfU2GOX8N407GApVz6v8wuJZSrBz9FiixLosK5n5DC8oi+JySfK3?=
 =?us-ascii?Q?XbZcjZViOba/Uq+sDof0R/PfTHwU4X/4n1vQi0N/gUVRX0APvDnKgW0Zq7vT?=
 =?us-ascii?Q?+pYv2KynEzqckFWXr6HcuD8LCZZo+TGvspkOw39CNlUc6IVrQb2Zue5znNJW?=
 =?us-ascii?Q?3ZtIgXvx1KWH9fb/3snovIxPgd3kH5CGuT19xfu9nraSFOu/Ciq65UK6H6Ot?=
 =?us-ascii?Q?C3682DYPQXghxF9VQ+XDE4+kDaC5wkgKy4F+NdvVY5Nj1VaJfEP63u35Vkrg?=
 =?us-ascii?Q?uxad0vD87BC/9dYGc9FXjPzF/bNBbNuBbr8pgmqlLVrArDPqd/7Y9i1Liykh?=
 =?us-ascii?Q?VYLUW0xRXpG1roDKesA5L9gQrcVcwfSWUSGCN4QYIzyC4ZNaE5gmEvIH/Naz?=
 =?us-ascii?Q?f79cIGZAf+O1rlSGW5gFiq8Ong12q3L5K0lyzodCC8h63tZZZW5dMvRncuQG?=
 =?us-ascii?Q?DSo+WgBi/mvkAhZDJm2U972a5xEsWfCyqR7GJ43Ydl5mN8dpwYVTRUqW1NNm?=
 =?us-ascii?Q?0DRPbT8zwZvEcMhFtGkuvvbpx340aaNm4zB34hpAe28KU9MO6A0aJNwBvpUM?=
 =?us-ascii?Q?VPw8rzWfHNeLgO0mXSjlK33CWowk1nGd0So3ISlxPCFSJ89PCD259WnqcXx3?=
 =?us-ascii?Q?RY0Ctrz/1ljH9FNd9xpzmI578s4ISzfISXCiFx7N1rM6nbXXgRQR2fvZDYCl?=
 =?us-ascii?Q?GAYfj56QQttCV7j2fLSmP/26WVI9ZszKEFGrTWnxWrc+4DFKNGEQ8DHx7wIH?=
 =?us-ascii?Q?QdLTX213h6hpsscSeeHssOxAZIQ4kDkddmxE5scLU9AEnyYfbWXlBHttMTAU?=
 =?us-ascii?Q?h023vYnQsAFonNeEZ6WhauDfhO8T8DLN5/PxmOUwHvpb9JaeKZR7L6eTgAdd?=
 =?us-ascii?Q?FPvGIx/464zDA08lV+vR64s5X2HDj7YTfBWcZk15ficKgtrW6YY16GoDfdFT?=
 =?us-ascii?Q?PRM4POekC0VqICtbMv+9/CQNnMr2dhGtKD/ZqrA5CoQTEJHav1YDmnbt8LKD?=
 =?us-ascii?Q?ZFK6rkL/2Jn9oaifUrogRL2onydga2hmf4Kfjb4smCv87yd3imnSWO4D92g7?=
 =?us-ascii?Q?diZzP3Tz41uYZva0aYbxkryTeF8cFqug47d3MJ6nNhq5Xbd32KQR62RF3DWL?=
 =?us-ascii?Q?/1Hx2rMKyiWWWyc2qZLxCKhqnVyMUMges02QlJKYxvD40biAWk/4IZmCmXoD?=
 =?us-ascii?Q?OoZJN6p+n9iEZ3eZDIbF4M781/mtoK1wrWn7L9g3YB/sMyNOsPYpveQcynC8?=
 =?us-ascii?Q?M+VhydVVmyPJqCuAE8vDm4kpXE3+6vBf4RqV86CG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd8c171-16f6-4107-b62c-08ddaef37ee5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:38:18.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ysjxm5Q59f8aojZPr/cybL86VKLO+kxGAuII9/RrPua4YLa58WeekJFXTNOfELkmBAx5CGpM8OpZVXPbbRrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585

On Wed, Jun 18, 2025 at 05:44:43PM +0200, Petr Machata wrote:
> The flag controls whether underlay packets should be MC-routed or (default)
> sent to the indicated physical netdevice.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

