Return-Path: <netdev+bounces-207366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB1B06DE3
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F355B16A44B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 06:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0E2874FF;
	Wed, 16 Jul 2025 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WDa3yy+i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE611D5CED;
	Wed, 16 Jul 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647183; cv=fail; b=IhScw1xjBA0jowLBwlNfZeAqLe88m95Qu9iSCy3CCxUvIfV+O89d9uiBsesNTElyMH9Ills0YNo/buMJ0C0XozQYRFy3SFrt9oP253DQHRhD1cmQ7351d1bP5n9neVbs5aBU98ZBEEQNWzMF5yWuRreC7JanjIedfior12ajPUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647183; c=relaxed/simple;
	bh=MimLqvLEbspia1xgq1sSnHvbSmIJATOcuMk5xGlpAvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pBRTkrkACDIJ3LhEdw8d4z4TmfB/1hv2GQsYDVIDC1s68pD+oHg5Rp/iZF7mD2cxtVHH9PERSdzP8BklskzHssCuzQ9n2rcngoCG94P6yxh7AR6DsNyGpjbaDIj9mHYxxWXMb92/NOitzc4hAzwaKAb/nxAs6kWcBTE3xh1ynMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WDa3yy+i; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4tuii3DbRL11Q6iU1RmN+ZpJBlk9VA8mPhys1G5mO3dWSAmfICAT0nDNGd4KEm7DhhwcnA6xYuRqx/w5IRHfeP9yuFAZNWBh85lCtFOugL9eJSZpk7W98TENeM+535jxN7U+UMFMvHXJjqTXT7Y/Ta1lXFkqFJZflxSEJYc6E4iv5LWs0IIMoSOc1/Bf842LH7ZG0Gf6HJMLjFKJDBOwWsDlUj1KlNIatZa0V+oR3wxzdsKW3jisnbOU+nQo2OtaBkReanhH/bLaXnntWLoKb6NJBdVX52sDhX2JkK2mGU9++DPLyJHQ9TWk5N+F9WZJvtpC//d03QvY87Uc8eZ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgCKjrEQHoMWDZpiYXJGr+SRHXnj9FZgOx4+OtiFXRI=;
 b=sEue+T5NSJzdpgrmteslzLoDhTR++Y0KDPgANTrs9CyRv1W1Di830TBLhwN396QLA/PX7HvaQbU9uUCggzYRfGqpHrx7OXoOKxK+m21txCAk/aA1ow69xHKWGD/1tKy/PoNV/M3GRrDMErgQjzEW7cSOQxF61NS+xErc0HRucBo0RhfOMJ89hqId0OJ3RNoDwJWsmVGvFu7sNqEmLnwAndwzj+9EP9uA2IdSoQ0miKLDL1+QSU2+ZJrCPsyXEoAwkAnoyA7ZhK6kINxN7Seh9W6BBG8dJf/i2uhzytrPIJru7EhE9hDyNz/pewJ3CgLvhBUJcaZFsk2dTdq3ECeTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgCKjrEQHoMWDZpiYXJGr+SRHXnj9FZgOx4+OtiFXRI=;
 b=WDa3yy+intIf1XSmwliUR0QocsocTXh/W6SwciN9IsL8dyI2KNIu6u2CnyWASrmvEbZ3UyLGTWIoXZcN51H23uK6SKyaPGRavDwO5IcHxZXArJQ4VMdwvsHXIWwQAK06zy5CtvzXtMQeWj/7jZUxkD+czG4eUgD7kA58uVcTzFGGr6qMA0N/zyO7shmbAEJVKh5S5fQ0VQrTeT6qdH90FvE1YFrEs/NvU7+bQk5mKXsMQhtzYW39QI2IZsgfOYfQnm0wQBA0JVqxhputCEg6/qVmEY+oyCkUUh3EVBdsnzAl5FN/jeZrLJmDv1BAbd5keVkf5klJMX8Sneurkk5EHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 06:26:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 06:26:17 +0000
Date: Wed, 16 Jul 2025 09:26:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Joseph Huang <joseph.huang.2024@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: bridge: Do not offload IGMP/MLD messages
Message-ID: <aHdF-1uIp75pqfSG@shredder>
References: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714150101.1168368-1-Joseph.Huang@garmin.com>
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9681c0-11b0-40aa-e969-08ddc431ac29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KsHIpVrV1N8SX2FkEXHKFIJ5VZzQG4Nwx0VvlVPnqdlaH++RIdoz8mg/T4nm?=
 =?us-ascii?Q?UWpWR8b77K8txIp9BMFR+PDkJrmLZNvUq7lkThmN0bOA+VlxeVGT92hdS69s?=
 =?us-ascii?Q?3Z9Pj58Y62RgshVExpygMi/Fq7cTf6hT/XbQSkkze36Dn0QlPmgV8/Nu1ISb?=
 =?us-ascii?Q?v0aAez8mdCj/w4Jp3jsf9qtGozgcsQ/8iSB9jtrXzyrw+k6tR7O0rBRjNnu5?=
 =?us-ascii?Q?pkYA+idjywKXNqlLmhXsvyjiElvOk8kvjmpU8pLVL6NeG3U4v5QBliS3aw84?=
 =?us-ascii?Q?PqsEVguR2a282BuSkx1h9CCQcmGIKp4i0lyk2xAymZlTxeylQcVFWSIOjMyY?=
 =?us-ascii?Q?cmVl8481WobeGgkPg5pQRCu0HdQrVrQeJDfNy8SEScpCcIw6qdduvvBXeDhz?=
 =?us-ascii?Q?0PKqfD3xSLBdAlPAWythWHojjz6FkJ3tp7PrizHC50ihc549tFaUbuFterad?=
 =?us-ascii?Q?fPuFdtTqyhwW3rnk1VSPeAJVPkqnylCpvoNnLvP5jLayI93pyHTySVxc4qqN?=
 =?us-ascii?Q?ogM/HI03B8JlvbxeFal4JMngDo1H14lVZiiGDVq2gtpLn3kGTHSUkXSfs7FC?=
 =?us-ascii?Q?7Xybklq5CwaUhERQ3DpvnVC1tkZ36khZ135/+ha2vI5u0mVQ/u3uqX2syFEX?=
 =?us-ascii?Q?KEmyTVk+oijYewgGGRQpkhDJEOtJ0AgveVoWr3o0ocamGP4fOnZqhlTHcdX2?=
 =?us-ascii?Q?D709iaz2xjBe43njcrPmDo+UMI9OEQoswdQWE8tGOi46HmYi2xdGpvSqq3T4?=
 =?us-ascii?Q?Mm0yWawtQvDmEVL10iAZjPG/lvsqKQpBF7IneKr4vaXddpR1EDjZmHyYuEVP?=
 =?us-ascii?Q?CgMkaJEgkD6vc65MhwYGH+ua+LTDSxZW6u4M1mvEJdlcWeyZGxZMBc2vM9uF?=
 =?us-ascii?Q?BbtcRpRcA+2Y6sP5dQMqroBvAoLhHcjOiu3vXafYs5WES+6X3JP07/VpvEkE?=
 =?us-ascii?Q?cShS4xRMBIySRYgapZf1Gn7+JzuVOob2gTDJVuoRmKn4REnJ8Dzftan7sew1?=
 =?us-ascii?Q?DtdUxBYttR/RiE15i5cv4r3aerCX8DMEOpj2bcRxS9Dl12lsJtoOwXohshCZ?=
 =?us-ascii?Q?d54IPkG0l8NkG16Ycu1bSy+CgOR7HqO8kVhRp9NpJRn2ouKGBdSwwddSvywV?=
 =?us-ascii?Q?ga0SjAMhaxFOG5itLkyCiLTwgrj+fmskhb+gFFbg5JutjKDZ05HP76umRfc/?=
 =?us-ascii?Q?SuqaNtC8ElomXA7zgW3Guh8QdPmYEZ1iJtx82FOvtfnvvuDqvkbWAXQX0fNw?=
 =?us-ascii?Q?lM0HamdMoiuuY3HJEiPowTCVT/vozJVDIO09E165NdeFYUTeYmSlHnY6yyLf?=
 =?us-ascii?Q?JCBgIaYG4LTfWRDP9KQo/FNuZk/tDgixZYRdZ4ZCUpeYLgiVTUKTn5SFaLzH?=
 =?us-ascii?Q?NSEAJUEhEM/cXOujYRc/Dq03VY5on2ePpyjhzo+9fiYO9Xyzs8tBVe5nvzkJ?=
 =?us-ascii?Q?h6pBj4UE3V4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nUHcKqkQ48/K8tYboPco0epUn7MhlA92nzs/nlwlbw37AtjNHS46AsEVzHpe?=
 =?us-ascii?Q?BOKmUZI+7S1/ve+cY8ji7D9mQAI7VP0pIrRX9NUImi6e6Kg40dsuEoPv/UOl?=
 =?us-ascii?Q?ZfFY1DzWUjAhmtBQsA5ZGiBv3QI/MDSc4wCfrM1eg1mXNJY24ofWK9g1acZc?=
 =?us-ascii?Q?y8c6pzrpV0pSMaAN46U8ckocXBSvZUfZMXlb5W220Ex1gN0La7X/0Oiv0SC3?=
 =?us-ascii?Q?89iW/q4F403Gdhn/9W/fDpA3Jl3N013mIflzWV8/P2UCPBp9k0rSOWQR9Fxh?=
 =?us-ascii?Q?iWPtnIXQk6xtJ5QKk380ReWBZmY2V8Mo+nj1MOBM1Rhl9xz3PsJKXlv0RLJI?=
 =?us-ascii?Q?Co07oKEtZonMYWF+QlJC4fvzbUbPSX+nwYDujvyvOPD2+2XlIsIdHfv2EWnQ?=
 =?us-ascii?Q?Y/0vwPRpxVNnbV8fbpkmyRoq+oA6KSxBMNJj+9D6hYzz77rh1CcVIEqvpQVW?=
 =?us-ascii?Q?FongPPfoW8+B+Pxcl5v3LTPKcq3ldrdwbz7zkKJEBfl0c2OpOL8EgiL2almH?=
 =?us-ascii?Q?QUncPA3Vh+LEjs3PZ4AjhRew8KKRo4RUYx/cw0j6qYqQx2e8vy+QrLE4SKFd?=
 =?us-ascii?Q?wXhooL5ONCV81ekzE11yx7gydAplXuqVcB8a6X5CcwkU2k+/qSKTzyP+vTB9?=
 =?us-ascii?Q?U8s6CWCJX2CIMhjjCNNrvho/aNWsbgd9aUIhYI6iMAxqPAU3+MUazAyB22DU?=
 =?us-ascii?Q?WpgJ21T0phpeCSnWZsWpbwFhFpwdfziqJJp0IMZz1fnGnBlN3ySMgpuspQ+S?=
 =?us-ascii?Q?C/gUNSG5XokqwOtysCbq8DCsuLRp9rhru20G7+i0/DrZONf7Bns0TdKVTLVO?=
 =?us-ascii?Q?56XP097WtanKrDJTQMb51hyraJ/0eyIf5mAjOwr3nQG5oHK1Daw88IRCwUMP?=
 =?us-ascii?Q?iAxboDsbqOKNqEwShbryt8oDCV7L1yP+uFzefeIU0TegrLXyGqwQqoLsg74k?=
 =?us-ascii?Q?rSFueo3mYGW5W9G7Ixk3P52POdpNHcZPhc+Mz6uuIUy2BfWVVFfF2brUXZFQ?=
 =?us-ascii?Q?6WUsuYwtpzt883cvXtl7Hna6Z6moC6Pdpre5+Mzvoe+/qcq9gpXV/rMZbSMl?=
 =?us-ascii?Q?4B5t/PNeEZZ9JbJcYIJOKSgDOcG0MJNfH2e8YPwuAKzq6Co/UlAPqhloBu8o?=
 =?us-ascii?Q?4b8KEJAoH8/24TDfvXZYqvpkGL2PcunH5SyH14FP5ifjnxnnPUv4Y39qUrEq?=
 =?us-ascii?Q?oRKmEObboP/VW2w9stvYu0tc/dmf5A8djDU5e1LpnjCDJL5ZPyRaIbkoAZ2L?=
 =?us-ascii?Q?srf2XTqRFgPnSTd5d478xy5iB6x5ZIyPyGBKhUxM5TjhQZtmRGqaLNTFRxnb?=
 =?us-ascii?Q?TmA7c1c4U3DyuGUldkGwqEU8RL+Sh5Q5WoZKu1dJclsO76Hozd/j1sVISNJK?=
 =?us-ascii?Q?BCJND1x/983g9iDlA0Yn89jxR0gicLXYhgOIKR5Ur4/vgytkJIZuwq6VtCaP?=
 =?us-ascii?Q?leehaXXL7EO48uF2AGHdq0aK9tPbLUh0oyCGLZbe5pQjFj2w57UAFvIboVtI?=
 =?us-ascii?Q?YfKO4DEhJOt+n8SmWLP+8zDyMiR8WiGdh5DhiVT72Pz6T7ZOXYqXO6hnIYUP?=
 =?us-ascii?Q?iJxvUduM1MZ0MmN+HkaA8OOoMkq2DqAbmPidtKkc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9681c0-11b0-40aa-e969-08ddc431ac29
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 06:26:17.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NDoYQOY1jytDb8uSasmgFtJDvm5UkRnFkuCa184pLKN/g1C+mklNKEI8tF4TUQc1UfEv35deu0igCnRzfmgrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819

On Mon, Jul 14, 2025 at 11:01:00AM -0400, Joseph Huang wrote:
> Do not offload IGMP/MLD messages as it could lead to IGMP/MLD Reports
> being unintentionally flooded to Hosts. Instead, let the bridge decide
> where to send these IGMP/MLD messages.
> 
> Consider the case where the local host is sending out reports in response
> to a remote querier like the following:
> 
>        mcast-listener-process (IP_ADD_MEMBERSHIP)
>           \
>           br0
>          /   \
>       swp1   swp2
>         |     |
>   QUERIER     SOME-OTHER-HOST
> 
> In the above setup, br0 will want to br_forward() reports for
> mcast-listener-process's group(s) via swp1 to QUERIER; but since the
> source hwdom is 0, the report is eligible for tx offloading, and is
> flooded by hardware to both swp1 and swp2, reaching SOME-OTHER-HOST as
> well. (Example and illustration provided by Tobias.)
> 
> Fixes: 472111920f1c ("net: bridge: switchdev: allow the TX data plane forwarding to be offloaded")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>

I don't have personal experience with this offload, but it makes sense
to not offload the replication of control packets to the underlying
device and instead let the CPU handle it. These shouldn't be sent at an
high rate anyway.

> ---
> v1: https://lore.kernel.org/netdev/20250701193639.836027-1-Joseph.Huang@garmin.com/
> v2: Updated commit message.
> ---
>  net/bridge/br_switchdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 95d7355a0407..757c34bf5931 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -18,7 +18,8 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
>  		return false;
>  
>  	return (p->flags & BR_TX_FWD_OFFLOAD) &&
> -	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
> +	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom) &&
> +	       !br_multicast_igmp_type(skb);

I think you can just early return if the packet is IGMP/MLD. Something
like:

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..9a910cf0256e 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -17,6 +17,9 @@ static bool nbp_switchdev_can_offload_tx_fwd(const struct net_bridge_port *p,
 	if (!static_branch_unlikely(&br_switchdev_tx_fwd_offload))
 		return false;
 
+	if (br_multicast_igmp_type(skb))
+		return false;
+
 	return (p->flags & BR_TX_FWD_OFFLOAD) &&
 	       (p->hwdom != BR_INPUT_SKB_CB(skb)->src_hwdom);
 }

