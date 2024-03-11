Return-Path: <netdev+bounces-79123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A4877E65
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 11:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EF8B20802
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13272EB08;
	Mon, 11 Mar 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HNYZoQVy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D51B599
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154363; cv=fail; b=ujh12mmlRHgWObO3LZ+FwmrLw4knc1zJPjnU2RRLQlMoCQM8XdaD5Aun6FtHMP0sA5HEJnKjf5rYpGZ+7FKGY6X0WDslHNclN6PfF577di7GybIXtQeGAsnQKR5jhz5N6JVbNaPTJ+o/00IfgMWHNTVyTnpo2bteQYaVBgV9IQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154363; c=relaxed/simple;
	bh=6ivPePTUkZgwMTkZGYLBJ01e9uSYM9h62u7EupVqbRY=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Xq6bGEKpSHu5By5pncgAH1OZ53NFRA95LL+Y9q3aR2+4Oa2bNT3z/hyG140VJMD20nbbdjkHS2qr5l9qZeMrMxWfPZCC4sUOtFbjviM5VPlzNPA3gMYkQuqHYCmIjmNi8hyg8mIj0cF0WovnPV6ZwbgQ7ASyIJOVklIyJg2s6eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HNYZoQVy; arc=fail smtp.client-ip=40.107.244.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/hLWLMpVzfb22vrNhzzNWFu19nOXRDPORUIWZeDTEum3uE3iNjVzCxO8oGB3YZKNQKcqpmd1rx7v+sITTuvhJUgTBzc1emxlnMvAWJhwzfUpuBsx8C9izymDLOwZlvocRBsuzWWgtLcGvUUoXzf2c4Fvh4vqX5vWEsiLLWhFSgJ2BplKIUNfb7MHwCy/I/dENludP90MSvkOhkrgFjOdkMHP9xf6JSahOS/S/KrqOA3Q/vICjK9RU2iorB/qLkIY3B+37yJtu+3SolM9E78hGkHs8oJc73ombXZRlWXks3L9BNbjGPNFQYpBvRbW69gWwnkKci7L6RxaLHiTA8EZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NCAzFn/r99dOv1XEqMUnrFuHm1F1TWNz61+DKTeq00=;
 b=ATU2li8ozeuHIqcJyzpRUxm2PRIUHruGL/5mhG7Ppc4r6L1duYwYqzbhScwHy8TEoqiQrL4eqGJl6i0W3k5gfaQ4PpTfnf5vd0oY+EIRJ6Pm7maStPyn+eIdT9gYLCJRVDxh/W/kSUkiDwE8pcHSvdBbtLXGlwk3HHaAvDQluhU0QLWJAFephAA1ugY/JB1CmPEUMJLJaElsvEddpZXy0xYs5YHlNeJrr8M3piCLdz1sWySSdqm62J0ZSOYm7uKaHfCHBr70+qr3uE4M+tF2QbdxhvJTTOT6Louo3Kd9qIC5Fmx4QKkIYY37u9e0VWeSy9siFtCvI+tIbnq7tOBfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NCAzFn/r99dOv1XEqMUnrFuHm1F1TWNz61+DKTeq00=;
 b=HNYZoQVyGAhGTyGp5GwwXNyVqWk/9KF9VVJwEQF41tBMjeloHdOiNeJc5tRrp777LKtIputnt9jOEiapIVFS4idmxcHlKx3iRLvtkcWUYfvPzTbsDiW5j+9agHpm/geBLAmODz/JT8yMDi47xPnZqzTcKwHc/LcNej+1f8RIT/Mc9tw/8/hclmb42kBzVL3RxhxzbGsWtHnGXQsWcu2Chk1qFRXIq3PtRNaBso3YKRSGcUJ7twJqHeChbStY27msFHGYWt5yGPl3o/NGs8UZ7kOdV1HC0sIap4lj2OPUJLZuDwMGxSQE4fqyIEu0TcQpjx033otbDINQcmZoYa2qQw==
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 11 Mar
 2024 10:52:38 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::48) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33 via Frontend
 Transport; Mon, 11 Mar 2024 10:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 10:52:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Mar
 2024 03:52:24 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 11 Mar
 2024 03:52:20 -0700
References: <20240310173215.200791-1-idosch@nvidia.com>
 <20240310173215.200791-2-idosch@nvidia.com>
 <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
 <Ze4pIe_E4BgkCP6w@shredder>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: David Ahern <dsahern@kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Date: Mon, 11 Mar 2024 11:27:23 +0100
In-Reply-To: <Ze4pIe_E4BgkCP6w@shredder>
Message-ID: <87o7blkplr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 628b4475-feb8-4edb-4c5d-08dc41b95e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	97A7ULQfi80jh8hLovmATgpTsGvT6dIlXmnNb/AgxpVu7lzZJgP9lFPEdtMkFpiBUWPXWVEw67IP9tfQWrhK4oOQY2Hy5BKuXFM8SrjyQ4DS4tM2ue0r79mFa2lkPlkrwSC9kfEm1aXgrYw+mxtOFQgOg043s2s66TGRAgpHhIOPbs8/oo76xAynBJUsT7aT5vWeSZA9PTY/Z9/CTqaPNp9atq6X6VCuxulzF9Bl5790mY7SYMCAv+4FdRgKaHoVcb4tyTWQSE6MmJ/WUJnThATkaxVR5fCgonhvG7L2YxnmHQJS1BAWCTidHsuIES9qjNaIhbmP6Swu9AJfyV179Tc3dB30NBQJg+H4cWZ6LzlBKsC79lIeg/UJSXEUetvRSp6bHVM+qNMKYx/93Ln8wLZHPitkyaOaD7zFzbPva13j/A6ZmBTBpjF/L+i6o5TL21Rf8b1B4xGJrxF+sC8/PjaRy0EfiJ2I8rIxv7YAq/JCnTvhmxWo16iKurm5DqLKuVfuvRvogZA5o18XgCxjEwSUPUFUYpH4Ev0xnAInzh2tjE7VG4pVYuwwvq1/dE80s9XqV2BsKh3pXN+ky5ChnQHO5Utx6sjMDeesrfR4y0WUX/35IeOtjRkyFsITFlC4YDqI2lW4jXf5lQfaXwb0TQZ6LZ5k3RMh9yWagISkIgQNri4DA3fqCUqNxPHPCtg1E0LfUpo5HQKRi9MyurH0+LMpghqYyPTMtNltJ4viEbbqIzxAyoyYk4Yzme7KAbdR
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 10:52:38.1177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628b4475-feb8-4edb-4c5d-08dc41b95e0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066


Ido Schimmel <idosch@nvidia.com> writes:

> On Sun, Mar 10, 2024 at 11:54:59AM -0600, David Ahern wrote:
>> On 3/10/24 11:32 AM, Ido Schimmel wrote:
>> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
>> > index 5eb3ba568f4e..f3df80d2b980 100644
>> > --- a/net/ipv4/nexthop.c
>> > +++ b/net/ipv4/nexthop.c
>> > @@ -3253,8 +3253,9 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>> >  	int err;
>> >  	u32 id;
>> >  
>> > -	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
>> > -			  rtm_nh_policy_del, extack);
>> > +	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
>> > +			  ARRAY_SIZE(rtm_nh_policy_del) - 1, rtm_nh_policy_del,
>> 
>> 'tb' on the stack only needs to be ARRAY_SIZE as well; that's the
>> benefit of the approach - only declare what you need.
>
> The reasoning for that is explained in Petr's commit message:
>
> "
>     - To allow querying for presence of the attribute, have all the attribute
>       arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>       pass the corresponding value to nlmsg_parse() as well.
> "
>
> IOW, with resizing 'tb' to ARRAY_SIZE:
>
> rtm_del_nexthop
>     nh_valid_get_del_req
>         if (tb[NHA_OP_FLAGS]) -> BOOM

Yep. I passed NHA_MAX to nlmsg_parse to get the tb array properly
initialized, but missed the obvious fact that it will then expect the
policy arrays to be this long as well. Oops.

One way would be to just initialize the arrays:

modified   net/ipv4/nexthop.c
@@ -3243,7 +3243,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
-	struct nlattr *tb[NHA_MAX + 1];
+	struct nlattr *tb[NHA_MAX + 1] = {};
 	struct nl_info nlinfo = {
 		.nlh = nlh,
 		.nl_net = net,

But what you propose below looks OK to me as well, and conserves the
stack space. (Until the policies grow again anyway.)

> However, I can add [1] and [2] as patches #1 and #2 and then squash [3]
> into the current patch.
>
> [1]
> commit bf5184cc9a3596d3185c91f2f7986e7c6f2dba9c
> Author: Ido Schimmel <idosch@nvidia.com>
> Date:   Sun Mar 10 21:56:21 2024 +0200
>
>     nexthop: Only parse NHA_OP_FLAGS for get messages that require it
>     
>     The attribute is parsed into 'op_flags' in nh_valid_get_del_req() which
>     is called from the handlers of three message types: RTM_DELNEXTHOP,
>     RTM_GETNEXTHOPBUCKET and RTM_GETNEXTHOP. The attribute is only used by
>     the latter and rejected by the policies of the other two.
>     
>     Pass 'op_flags' as NULL from the handlers of the other two and only
>     parse the attribute when the argument is not NULL.
>     
>     This is a preparation for a subsequent patch.
>     
>     Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 5eb3ba568f4e..03bacf9c0502 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3229,10 +3229,12 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
>                 return -EINVAL;
>         }
>  
> -       if (tb[NHA_OP_FLAGS])
> -               *op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
> -       else
> -               *op_flags = 0;
> +       if (op_flags) {
> +               if (tb[NHA_OP_FLAGS])
> +                       *op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
> +               else
> +                       *op_flags = 0;
> +       }
>  
>         return 0;
>  }
> @@ -3249,7 +3251,6 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>                 .portid = NETLINK_CB(skb).portid,
>         };
>         struct nexthop *nh;
> -       u32 op_flags;
>         int err;
>         u32 id;
>  
> @@ -3258,7 +3259,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>         if (err < 0)
>                 return err;
>  
> -       err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
> +       err = nh_valid_get_del_req(nlh, tb, &id, NULL, extack);
>         if (err)
>                 return err;
>  
> @@ -3715,7 +3716,6 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
>                                    struct netlink_ext_ack *extack)
>  {
>         struct nlattr *tb[NHA_MAX + 1];
> -       u32 op_flags;
>         int err;
>  
>         err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
> @@ -3723,7 +3723,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
>         if (err < 0)
>                 return err;
>  
> -       err = nh_valid_get_del_req(nlh, tb, id, &op_flags, extack);
> +       err = nh_valid_get_del_req(nlh, tb, id, NULL, extack);
>         if (err)
>                 return err;
>
> [2]
> commit 585183403a6b692d71746527938b037f50feed65
> Author: Ido Schimmel <idosch@nvidia.com>
> Date:   Sun Mar 10 22:54:53 2024 +0200
>
>     nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
>     
>     The attribute is parsed in __nh_valid_dump_req() which is called by the
>     dump handlers of RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET although it is
>     only used by the former and rejected by the policy of the latter.
>     
>     Move the parsing to nh_valid_dump_req() which is only called by the dump
>     handler of RTM_GETNEXTHOP.
>     
>     This is a preparation for a subsequent patch.
>     
>     Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 03bacf9c0502..573da3660cb3 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3397,11 +3397,6 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
>                 return -EINVAL;
>         }
>  
> -       if (tb[NHA_OP_FLAGS])
> -               filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
> -       else
> -               filter->op_flags = 0;
> -
>         return 0;
>  }
>  
> @@ -3417,6 +3412,11 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
>         if (err < 0)
>                 return err;
>  
> +       if (tb[NHA_OP_FLAGS])
> +               filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
> +       else
> +               filter->op_flags = 0;
> +
>         return __nh_valid_dump_req(nlh, tb, filter, cb->extack);
>  }
>
> [3]
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index f6c9d834b989..0011b0076c5b 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -3243,8 +3243,8 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
>  static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>                            struct netlink_ext_ack *extack)
>  {
> +       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_del)];
>         struct net *net = sock_net(skb->sk);
> -       struct nlattr *tb[NHA_MAX + 1];
>         struct nl_info nlinfo = {
>                 .nlh = nlh,
>                 .nl_net = net,
> @@ -3277,8 +3277,8 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
>  static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
>                            struct netlink_ext_ack *extack)
>  {
> +       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get)];
>         struct net *net = sock_net(in_skb->sk);
> -       struct nlattr *tb[NHA_MAX + 1];
>         struct sk_buff *skb = NULL;
>         struct nexthop *nh;
>         u32 op_flags;
> @@ -3406,7 +3406,7 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
>                              struct nh_dump_filter *filter,
>                              struct netlink_callback *cb)
>  {
> -       struct nlattr *tb[NHA_MAX + 1];
> +       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump)];
>         int err;
>  
>         err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
> @@ -3550,7 +3550,7 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
>                                     struct netlink_callback *cb)
>  {
>         struct nlattr *res_tb[ARRAY_SIZE(rtm_nh_res_bucket_policy_dump)];
> -       struct nlattr *tb[NHA_MAX + 1];
> +       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump_bucket)];
>         int err;
>  
>         err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
> @@ -3719,7 +3719,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
>                                    u32 *id, u16 *bucket_index,
>                                    struct netlink_ext_ack *extack)
>  {
> -       struct nlattr *tb[NHA_MAX + 1];
> +       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get_bucket)];
>         int err;
>  
>         err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,

