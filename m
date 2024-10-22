Return-Path: <netdev+bounces-137794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84DA9A9D89
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ADF281381
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2FE198A01;
	Tue, 22 Oct 2024 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KRnJrVL7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C679196C7B
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587314; cv=fail; b=fA8USvhRGLpY/2MEPUiIpLhjuPs0f8GR0NXTW0OncSGRL7ucU61i397zQUdbXmU9jWVkbMcLIHAH5AaqL4oLO3SKiHiX0jNDp8kKqitPl0YJ2sEaaeND79qEOwaRZp999MjSTqGkBq0uMIjI8n5nNU5kVE79yJYmlgELIelbZQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587314; c=relaxed/simple;
	bh=QrycUlHH18/WB6Om7z2GHAJnYr6M96lrOUSAGHKlgZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0F5aaFfggJt69egGHtz1C5e1NRGtHMGtu3aCyansED4LFKyyJliYay+54fHXnojj1gqF5L+p1MLnwU45N76AUFpKKl6ULdGGidjjNNyNk1kzaIOLNV+WnSiumfpFMKf7a9twC5OZz+RFhXP/v/DusHkZAIZGGFUDdYJfoAOFv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KRnJrVL7; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljldac9odi3flYZ1YRezrPnn1Ranm+Zgcnahr6oOSe3a2IOlQGjw+0btQ9da+x1/B1hz1qI1FO9G6drV9+V00r85k7RjpM8GSB+0jG1iDEPsUJrYjyZ1qJQDJ7z4chefQjP79hl4r8C2KfyQtFauiMxMWCUokfhFo0H4htr9UdcI3wHbqLd3u5na4BdeRaSEzpbzyZiIITnYXN545HRTV8fSlIyFbAyaYkRine7nw8RcbdkPzRazdouKwSdJ4roQfsEsO6ijMa1v2iK4kyGePfHQxJWmfXCNdD5Xie10oq2+rGDNR9QYDcO+b8iGs5ojK4QNkB/M04oye7S4IqshzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnL0twzfkSA6JNcHBsFjNNkArCibP8TNpw041IamBxQ=;
 b=AbChxaTpZMDQgOKCNG6kLDLcZcoKjfs/ekcWlrE1sa1Pj7m5dc67enpLLXIn9kkckUCtXeS+KRqAlmqOefmlj4A6Qr7tcD5KUGpSoeYisTVecyh+2X/AOh0/hWO9U/vbJC4mfLzgIalSd1E5g9ERHzUWb7YXovc35LYIjp1/wtJnEA+08MKyb7h9q0zIHt7SWjKUPo7KXLGpbblgCeRR7xE3Vj7pu1SVHkpjxn6s9XqcCg2O0jse6F9Gqplcl6IUEmJ9q/h68wUIGDeMHp+u3B+zVaEMbraZZi18yXbjiQUCqi9gCroZVMeFgRBXln3k8u4JSQZCruk4rdT4E9vg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnL0twzfkSA6JNcHBsFjNNkArCibP8TNpw041IamBxQ=;
 b=KRnJrVL7HYkPbOCR9mACAlC8HUcDUVW/GYLS0dhD/sniu/B9fTNWWb+g1+CydSXeXj1Ipjvdynjk6R7DZbmWGr6ywrZWUdiY10UQ/zEr15IbyQOOAd+k+0L/3NdTeRr5TsN5gzObwf5HeMxoBgw9pSa7yv+czDUYtOlWfpnwwDjOfQkWE8sD4z6tuTmvJYYCMpgqn9Ar2gUi6BtToZMJgxKSWds8B9XBYV45ULZyqR6Odkp3az7+VSPFhCZ+noqBlYq3yRCJYCN4zoLMa/9XnCgz3XbJdzwKxaXdX42TSnO2L6TV2CK4snFu9XTcv3CKurQCiimTUeYsh8GlAemUmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 08:55:09 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:55:09 +0000
Date: Tue, 22 Oct 2024 11:54:59 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
	pshelar@nicira.com
Subject: Re: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in
 ip_tunnel_find()
Message-ID: <ZxdoY8Uehc3qs89P@shredder.mtl.com>
References: <20241022070921.468895-1-idosch@nvidia.com>
 <CANn89iLHV5NqHPjRp6W77c1DFtOBDmBs1sWR5+W_405NvOBs7g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLHV5NqHPjRp6W77c1DFtOBDmBs1sWR5+W_405NvOBs7g@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0377.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::13) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0a3163-74ef-4a43-34cd-08dcf2773b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5LfGPN2PU+VHDwSkDAaqh2Z9C+Xx8mcc11M59X7gDutDz+CL3B5y0+nx5ra?=
 =?us-ascii?Q?E6vdF4BQNARz6B3DJyNCD9Hth5Z/f4Aw06P7zzEsMeredIGKoYr4sl/StIP0?=
 =?us-ascii?Q?SdR9jIepz4hHHndarBeRo5AOE09P1ZJtn6j5lju5vyMfDj/HAP/bnaRy2Vrb?=
 =?us-ascii?Q?hbQhpif2Z7uyXuK/rpSXhYFsQK0fyan+YKjNieZ7EFycNt2ESVbGTS6VyTsD?=
 =?us-ascii?Q?sce5m0/ZWZNvhd4up2wEi7pekX8NGe/Wy0IjaBki2pX1U3pRudpr8lmhq7dp?=
 =?us-ascii?Q?1WivGL/md0zXWIIVle0pjV5IFMfWKNxhd2++sojPDvwKZmToecScsW2smHrT?=
 =?us-ascii?Q?7lWM80AH39QflK80lWr9Ct2HTqvPnQ9veD11yoDP8/9dZzp8D42lgcATLmdU?=
 =?us-ascii?Q?5ZUCUOERBkupiabMSFu6PbLUUAPSAQ3U5mZ5W8UzAhdrsWJUTNmPfmKKwbRX?=
 =?us-ascii?Q?GuiThboH8q30sIve9NKTal+7B1GbuLeZWBXuLP4TMt1stzEdMEqdbSQXCjdV?=
 =?us-ascii?Q?/kTOF7R0d/R2BDl1WYTc4hfP7q/zc/XFYQroQKJOuX3DThCD1C2bNHkp7KzQ?=
 =?us-ascii?Q?3dwHcwGHjM5ZcULrA1RNj9pO/hGhXaryYWKFRmUG8ToWUKO4iryr+XuJN12/?=
 =?us-ascii?Q?z3SAhldM+Xz2dA5nEOy99OQVXn/SnXybT6ZWGrcEtMx5us4k6fyOnXATEfR9?=
 =?us-ascii?Q?FnsbL+jo3JIV0DjbKdDfD3jj8FC7HJ947ZxquiteJ6X1ju/68NnE3KIxa1sN?=
 =?us-ascii?Q?hJrE1EuFgnddEhyXhGsiNj7Mb4axkW7L+OWK++HRho/yjK1hX4GaHHOIQnns?=
 =?us-ascii?Q?q20i+IPLyDDflXrjL5WUbKOIsf7aCXfIUT6qUWEVcIpObbu+Hk+bC7S0S5OD?=
 =?us-ascii?Q?jN1U/dnAIH/bQcC7BkVCsMVtd/XMcKDCd7eX53sT23G8wVpeH567BVUjoF/i?=
 =?us-ascii?Q?CbIFeOzovEFFnghvzO1LW/v580YtjbiTvFP/0QIZjm6FN8fX75v7K8EMqWmM?=
 =?us-ascii?Q?l6AQEUwGbERGx08DYfSOh35+Us3alfJk8qkzuu9Uw0lUGZbgHrk7uoTeNoKD?=
 =?us-ascii?Q?f3e7rD4DSd9sEJA0IraYbsHd++LVZbg7tXeQI8hxCNh1WjjSdvARfX+S4sbN?=
 =?us-ascii?Q?bGr397Z3yVGqVGcMd3tAyhSG/SC0UJ6JDqTETA60vOOaYON04rbW0veEupaP?=
 =?us-ascii?Q?UKWOsK1B3pP78egYk9DZJ3FVZNcWC6aTkMl0Bgl24OO2zCjCzGfz1IV8aCoj?=
 =?us-ascii?Q?w/Z/ETrTZDPkqCd9Pwa4RLajfoytoGrF2Ozhh03w+fI+C0JFeRCfC3yZdevL?=
 =?us-ascii?Q?m3Qq2KUmTQZ3cVSXW+zK5e3E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DctxP6vwV7f7mUalC5MPEgXIfzXxrjcJVDWammXDJJHxtfiMXi3Zq3m92s40?=
 =?us-ascii?Q?Fj6KvuHkIm19GDI1UDPYGlUMiy1ZIIVSRftlOoQT0O3/u4qwPtmzPjY2OSa1?=
 =?us-ascii?Q?qO1epWNyRPiP+7ENbh35M3l1xCG1/OXBy5Wq7BUGiRTYl6/+uHPEEUNK6eQd?=
 =?us-ascii?Q?mQ1dBK+WFa8iPuA7ubiRbTxYOHTajF7znHwLTsbJ7J/CXNAJ0Fgmozr/yYO7?=
 =?us-ascii?Q?Ljn3Q2BO++zijF1odF6CRE19HZW/HJq14xXDTWbhyDkpDpsydN3+pCxppkTs?=
 =?us-ascii?Q?10fxqZJUGtbj92aiUgKKqsyE8ZGCq38ToLaL+2q/xHChfP+ltW5kkTUtSTNu?=
 =?us-ascii?Q?Nu0Teg2TXXLXK5IGbVT9qwEoXnabGwo5YYLlcJ9DixG+B3b+rFb0ciKc650L?=
 =?us-ascii?Q?10/nAq90oe/fXtBptFZWrx/HE4RTYVm4IBXnGtc3ztHv9/DI+8QRMIEYHzv6?=
 =?us-ascii?Q?zpoM7bqaOOHufwlfiMwEsoQAFoAXUcAYQkkZxgyERGjKgGmktAK/dq92HGHh?=
 =?us-ascii?Q?yTuOZenok1QpnZqrQSSzb9KtRCeAo79cmU2aoLDzFvRrBhzKQ/6Te7nCmxx8?=
 =?us-ascii?Q?gX698XWbCwWEwtTvaunzFgQU4VF4RzPIe6gJqjDQDZReWXJA3TdQATYO8O+c?=
 =?us-ascii?Q?e8ynXtBtOU8nIu5JTzB1Sr+RC0jTNuHawF9p2KNTCi/ay7lYshrW/P4t09ML?=
 =?us-ascii?Q?pTSYNpmzNbSggct+vfzicFHLWuU5v3GRvGEotEJm+d9FHbtZN9z5AO/CJsee?=
 =?us-ascii?Q?y4/QkuDhi0Op7Z80oD3qlOqHwy83ohO0gvncDHtYVG+GAE/H1yXpTauRBN9Q?=
 =?us-ascii?Q?9Hikq9w6oiZ9QiPQu7RuvFA4j79VVQLBGJE0ohj/KCEh+JPwubz01ZzCS0e6?=
 =?us-ascii?Q?Gzkd9HfaIs4SX6WqPSf9Pl/XCReo+jqKYLzg6TRZn8AmSJI6OkSONEObLi50?=
 =?us-ascii?Q?VoJhubyPDQ613U75zGMrGAh7aQ0j/eBU3txcn9IhHTQ8AVysgk3eZgUuf2VM?=
 =?us-ascii?Q?ArzrowWRfvgT5q1obc/+t0YMyeVvB4CEwaXIETNOGhFdq7pDIkWlPyZMqb4/?=
 =?us-ascii?Q?DgfFYBriePtxZneTup/7ZmM8YmXgE5uxPknKClP4wkYGSP+hCp+UYKHaP4A5?=
 =?us-ascii?Q?dQV6JVpBKFv9TmSswkkC/97QnporsrhO6lautADX8c7YnUe2PASnLqjzLBe+?=
 =?us-ascii?Q?sNwCjy4yMot2Z38jb915yxIeHWp5ggmjVSnETFLUQPVGcGbp5mpQbkCrhuhs?=
 =?us-ascii?Q?us8pA5XkCfuUkjTJqmk9Df4zGW9b1/YQGHOM5bFT5z92OjI3b6mX8hQxzgWX?=
 =?us-ascii?Q?CIBHKiIl9k4OG07ykOLvHvevKUBRVJdSno4XNdsoD3MUtvvZL2jNfd/X84rS?=
 =?us-ascii?Q?utliItyWtsj9lqgKcAylZ2vdWGi4ebLjPWwzvIGuNYWfOHS1PmAlcYhaAgNZ?=
 =?us-ascii?Q?q6x8ZvCugb79h/tCawA0PsAlc+7FKK4ZjV+3kpKROzSMZ2WNxDIzuBDjnLEH?=
 =?us-ascii?Q?OAjA1eNK78RyRQXDiINzvM9grIs3mmdabYYUT9b6FereT4PuIdHvLjQv0GNf?=
 =?us-ascii?Q?ir34oZUmdXdu+cIt4o3mh/9JKMpvRFNXyPqpnoub?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0a3163-74ef-4a43-34cd-08dcf2773b5c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:55:09.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbTSBBb9IUASt5DJC9auWvZokRVlROXPN6uHHsF/QYixuup89G5MK9JIijdp6ha0yjFqEJGj39mlhvZWKdzOcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

On Tue, Oct 22, 2024 at 09:26:11AM +0200, Eric Dumazet wrote:
> I was looking at this recently, and my thinking is the following :
> 
> 1) ASSERT_RTNL() is adding code even on non debug kernels.
> 
> 2) It does not check if the current thread is owning the RTNL mutex,
> only that _some_ thread is owning it.
> 
> I would think that using lockdep_rtnl_is_held() would be better ?

Yes, agree. I see I did the same thing in 7f6f32bb7d335. Will post v2
tomorrow unless you prefer to submit it yourself (I don't mind).

Thanks

> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index d591c73e2c0e53efefb8fb9262610cbbd1dd71ea..25505f9b724c33d2c3ec2fca5355d7fdd4e01c14
> 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -218,7 +218,7 @@ static struct ip_tunnel *ip_tunnel_find(struct
> ip_tunnel_net *itn,
> 
>         ip_tunnel_flags_copy(flags, parms->i_flags);
> 
> -       hlist_for_each_entry_rcu(t, head, hash_node) {
> +       hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
>                 if (local == t->parms.iph.saddr &&
>                     remote == t->parms.iph.daddr &&
>                     link == READ_ONCE(t->parms.link) &&

