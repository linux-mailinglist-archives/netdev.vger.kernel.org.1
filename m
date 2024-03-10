Return-Path: <netdev+bounces-79043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D85087789F
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 22:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A2E1F2144D
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 21:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB639846;
	Sun, 10 Mar 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XaKO7U+C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640991E511
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710106922; cv=fail; b=UIqkNcWYA52d/NLxrkAzG6Wh58qe1PvwryJgNd9FPzNhJXz14d+cm7zHU4oHtIN4n4i8mHT+0gh5DyaLaiOI/2YQTZyFttMDA3FAM5UC96jAYQHQvvJYbUH8CpfZxWHGqPAzC6XJwDlDpPLX0fbjtjt9tyVbFlPs7KKGN5BO2Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710106922; c=relaxed/simple;
	bh=iTmtd73LdRb3a2hCRFret2q30yzeOS+ncg9AYDGNx0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2XUvkhQ+1OGK03Ld7hMgusPJMoBVz9o/1LIxppNwWAig6gDIHaDXeJs8AyovYCzEd/kmZ7NJ1laXgFQ5ymmkv0whkyzgdqzxiktfwBErc+HUbXo0bSadH2L+9PwIigzUlPIv6alfH853C+YZnz9jKqustx8Q4f3Jhb+pDQBnSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XaKO7U+C; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpmO5tbO8I1/iBgJ9cTpfI+zohvMTgGVVejNxzz5MbShc4uvAlNEA5daMcGJAMi5BlMGCR9eQhShj323fMrC6ljUqIoRSv5ltVmTlQ+LSzHpDgh7+8yCbIecWmtL8FVJWQuYCjL/W63EayZ9coVuhanZdqkg4NDTi81TK/HQ6ZW2iqn+ZB9HuZdpTsbbZPBZA4tG/Sf4zKX1eU3Q6e3PEFObB4I3xwam8Y8a0vYME7Jp5Heqxq8uXIM032pOzhqiaCV+DH4svSrpnh3ukLPa8BwHA5+lrWgfUoEOBT72OSYE2joviiHglKKGSfhXIviO5vD4nz3E9MJG81VTCKG8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxx6xN3Pi+9q+rBnwNVe/OiOlUfDAvhpEIr3jh6xdrU=;
 b=brIZnJSh1qv4S2GBEnwq5oUFVClgRQMmCPQ8mgUZl423FplSG2SgwVIWi5/+TSRswQWVNAnzEhE1fylSU0WOy761R9ezo3h5qrt8+8HE4Fi0L3sCiwqPj84iiZAqKHKE8w83KvaHk3SXR6EseSlxFzsA/Ei2gpoWB2Cn5gu+oOhmJhPj/lGMMBCU2FbaPRBXQlgspIWpVeVr2K+7r2TbVFq2sPYv38WtcvwqK6J7HQcU/2mWsuvf5iotOPsaG4OSVw8B4XabhlUn8QwVH1ICLx4NOCeR4/+tfa8tfHNE85uZLYVQvPjBfx2UOTPSsPjGLGL6xCr2Sy/z4Y4Mi/nb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxx6xN3Pi+9q+rBnwNVe/OiOlUfDAvhpEIr3jh6xdrU=;
 b=XaKO7U+CKYlCoVm30qhMh53HfC1/uV8j+UAI5GqK7sBt5QXmbKNJGmCzlWU+EUxH91PJHnV+dOWjmGQYpD72SEEz0NxMaKRvFkW1aVdDyL7O9zM+YUh6RoW6t/FKLW8EJm36xoh8OSAW5LrW7QSut3e66DQPXZH32o5xuDOrSsBpSrjvOfhGF9tK+8fuQ7Qs8lIcO2hQ4iUAlddQJOPVTjHKbsMgW52tl04GtKZb27ZQ8y1JYruqf1FzjTtxnw0milVslfdLLdDd+nD7nefeKTxI+BJqurUfnpCCzk084AIqzrjkHgeLZ6qfC+lhQ01dyc0INdvNK5Lp03ygjhWfPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Sun, 10 Mar
 2024 21:41:57 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 21:41:57 +0000
Date: Sun, 10 Mar 2024 23:41:53 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next 1/2] nexthop: Fix out-of-bounds access during
 attribute validation
Message-ID: <Ze4pIe_E4BgkCP6w@shredder>
References: <20240310173215.200791-1-idosch@nvidia.com>
 <20240310173215.200791-2-idosch@nvidia.com>
 <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92e609b-f5c4-4e9a-8eb8-7e2c54f75215@kernel.org>
X-ClientProxiedBy: LNXP265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::18) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7166168a-c7ab-43a9-39c1-08dc414ae907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZY/y/F0IsNppo8swwfvWIPLqm1SInb1lX4Rwz6mBkCaR8PIW5d4BU7vgkhOynfEIoAqWtP+XKge9K6iIsJz1/NwBJdUMNvxD+2SiVsn389Ad0BmThWG6vBY30lfthJtpHrvZWgBL41wfc6M5zfDdQ32f3fo/Ur/q4Pn79nU4EVyZIJNVEjaBDHeBQOmAQ4o/6tDBhXamyeXKsJ73wi86+NieNwQtAeUaGhNUh0I/ouHIAJPQZWoqRDFITPZ7S0vMCB1G5dSvvg8DUNHR1M5M28d/b6rbbHe63t5ghvry+voDYabUUWdla+DBcocmkoGhG8tm2HIotUwiJyRJPDFN0dsLymy8r+Tx5JrDo2LAFVxL9gEg4RxEiWSQzv4XVG1LBnjeQI3X91pfvSeg9XYYitFbO+Lz9dR5/c7dhwtf/gkolIRO8fhk0ou7erUuxsYCyjgW1WsV3VlhMRhC5xVCHNRxf+wMlqxGmPiwWA9nNjWa2hASakoYjzYooYHzIybJyPK3nCAWuYtqUfYdmkVwXivXF3Pt8Fk58bmBAPP0z0r6fQpm10FnuKAg40lceyZkNfv3QYDe0pxN1mAcrt4kRZbIAdwufNONNMHk8ovDg119MqHujMc8dELLIFZDthNqi6AmgwGXydgQGHEK1cui5YQdq/Z5OVRp+rQBIwlEdko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBHCf06roERmc5Z1IfjtNL7iCbQu8IDoYWni+tIaH+WT7JN0whKTnhWPQFsS?=
 =?us-ascii?Q?Tp1LJCboSudNW5ZESdmyMG53GURb40t/JQkkHkltFhTd8lHUIjwtQCqCRwUa?=
 =?us-ascii?Q?nMGLBjAnAdurxWTqB9UJOS1pt2nNuFZm2mGE5pEgPHM1XJXT2MngCQndgThF?=
 =?us-ascii?Q?TuRnqSLAJTDA25zuL+VrrzjCPNNNIwlEzIwwHtxdDkFhP0bHuvpbNn4VN7L0?=
 =?us-ascii?Q?HVF3wEgFs3Xz4sMjm+R0AEfWkGIaPFh7yZe70RkupgJu/wtPseD2DAHcveLE?=
 =?us-ascii?Q?8zLlu4kMeq70vBAJCsybb8bLHFnYOPzFlTNtnX2zIghzfVplZIM9KlYdQCYN?=
 =?us-ascii?Q?4MjceaB8P++68Q1XH23sJjVpNIHJq13/fsY7irveu79KeMI/KknfSwrMutRc?=
 =?us-ascii?Q?2Pa9ggL3pnnamEVvc27sQm5iFSoR5tR4pZ+buFle7UpifLr5zrm+nuTTKIcH?=
 =?us-ascii?Q?1x5xASJ4Ez6KtfA9Fv2SoKsMVlEvLN8E8UWZS5m1smsOJrjKzm0gCj72Mvya?=
 =?us-ascii?Q?SNm1nRTMYouW94mu9VDn57V28ZW1i9gO78h9jVTMnLptUhf9cmsIDqmVUGbq?=
 =?us-ascii?Q?4ap2hmeqJ9OlBN+l2gzUA+19WhSU7eTFfqnFrU0oZW9UCLhfA90+KNgKjmsV?=
 =?us-ascii?Q?3xJ59pCuT9nAKZ4p9qFKbexk4ZgBwz97BnoW9GhCUbmaboR80IoBVaRuOWIk?=
 =?us-ascii?Q?oUHbKjHGOaxZl/bxIEp/WjiZKE2deADZ9iEyW12RZFsc8E27a1ivczTPjchQ?=
 =?us-ascii?Q?KAYNWHTMihBGw2G4YsmQaOY7PC4mgej8wFURMYk+IJheB5W+A29KzmWdfwQ+?=
 =?us-ascii?Q?aRkN+25WQi+4l4u8v/2CLfj9Pb3F/F1fCergn1bp4i+EV1hIa6KauWo2zrIB?=
 =?us-ascii?Q?wZFkQkNyw8kh3DSIu2nk4C/fZAGf38qyUf3d14obdK2qjrNP2vl30xMjxFGL?=
 =?us-ascii?Q?w7nsA7KMm/YCB/ZJT+z5X6hZpmqpbV84Dw665rl89GXhHY0y+W3qPUermfAR?=
 =?us-ascii?Q?orwbLftLCZaAivEUKW34/1XKwJgliTq3BKPZIJegtG7RreN5cnAUmsxGl/2n?=
 =?us-ascii?Q?kDF8XC+WfFUbghBFfsZw3ErlakL0KkWFkRmZHlofEQ7mj+FAQy3tBXpe7dqM?=
 =?us-ascii?Q?Rkj00Vswujo6xaPaLw4YmV/YgUtCuonwrYdq9kQtJggRX4aJTrccOAlY3raS?=
 =?us-ascii?Q?bqXS3VKteAISUU+jMHWjBjuRI7+brDe9tb273TeJeSruI8ORUuAmTlzqGfwV?=
 =?us-ascii?Q?iYbSP42hHCLHppw9Mpkefu2zEJqJg3lZhxZw/QhTZYbSlu5Jv/OWxo7qggTy?=
 =?us-ascii?Q?1yZOPTcdD739W0VMMs/k2ed9CR8qgFXmLfLGUAj9MIgIS2Q4nkAh279qMn7H?=
 =?us-ascii?Q?AXBT54e8AI+9Hdj1UoC0vSZ8ST2gLkC+/L4NP665epxyEjzm0MxkdUvTlrHI?=
 =?us-ascii?Q?y9paB+035LQrIhLYWJnQDVGT265GqSCgy0375SJ2nta9+xUy7ZgZmX3YZiV2?=
 =?us-ascii?Q?LnbwT3Faq50DNLX/Qd6vpenIYP1hmfxlhOsZ4a5Y6YH9arRWQLONMMiVzi4G?=
 =?us-ascii?Q?9bkrnRtKvuLjcssUxuQ8/7jYJWkmlGlkOP5GGoBo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166168a-c7ab-43a9-39c1-08dc414ae907
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 21:41:57.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDkTQAs00Buq2dTE2A935DxmJxf4qu91Dh89D3skW0laeReEyLD1gQFymWAHjNf7+CIbwixvw92y7ab8owAPTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

On Sun, Mar 10, 2024 at 11:54:59AM -0600, David Ahern wrote:
> On 3/10/24 11:32 AM, Ido Schimmel wrote:
> > diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> > index 5eb3ba568f4e..f3df80d2b980 100644
> > --- a/net/ipv4/nexthop.c
> > +++ b/net/ipv4/nexthop.c
> > @@ -3253,8 +3253,9 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  	int err;
> >  	u32 id;
> >  
> > -	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
> > -			  rtm_nh_policy_del, extack);
> > +	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
> > +			  ARRAY_SIZE(rtm_nh_policy_del) - 1, rtm_nh_policy_del,
> 
> 'tb' on the stack only needs to be ARRAY_SIZE as well; that's the
> benefit of the approach - only declare what you need.

The reasoning for that is explained in Petr's commit message:

"
    - To allow querying for presence of the attribute, have all the attribute
      arrays sized to NHA_MAX, regardless of what is permitted by policy, and
      pass the corresponding value to nlmsg_parse() as well.
"

IOW, with resizing 'tb' to ARRAY_SIZE:

rtm_del_nexthop
    nh_valid_get_del_req
        if (tb[NHA_OP_FLAGS]) -> BOOM

However, I can add [1] and [2] as patches #1 and #2 and then squash [3]
into the current patch.

[1]
commit bf5184cc9a3596d3185c91f2f7986e7c6f2dba9c
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Sun Mar 10 21:56:21 2024 +0200

    nexthop: Only parse NHA_OP_FLAGS for get messages that require it
    
    The attribute is parsed into 'op_flags' in nh_valid_get_del_req() which
    is called from the handlers of three message types: RTM_DELNEXTHOP,
    RTM_GETNEXTHOPBUCKET and RTM_GETNEXTHOP. The attribute is only used by
    the latter and rejected by the policies of the other two.
    
    Pass 'op_flags' as NULL from the handlers of the other two and only
    parse the attribute when the argument is not NULL.
    
    This is a preparation for a subsequent patch.
    
    Signed-off-by: Ido Schimmel <idosch@nvidia.com>

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 5eb3ba568f4e..03bacf9c0502 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3229,10 +3229,12 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
                return -EINVAL;
        }
 
-       if (tb[NHA_OP_FLAGS])
-               *op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-       else
-               *op_flags = 0;
+       if (op_flags) {
+               if (tb[NHA_OP_FLAGS])
+                       *op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+               else
+                       *op_flags = 0;
+       }
 
        return 0;
 }
@@ -3249,7 +3251,6 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
                .portid = NETLINK_CB(skb).portid,
        };
        struct nexthop *nh;
-       u32 op_flags;
        int err;
        u32 id;
 
@@ -3258,7 +3259,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
        if (err < 0)
                return err;
 
-       err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
+       err = nh_valid_get_del_req(nlh, tb, &id, NULL, extack);
        if (err)
                return err;
 
@@ -3715,7 +3716,6 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
                                   struct netlink_ext_ack *extack)
 {
        struct nlattr *tb[NHA_MAX + 1];
-       u32 op_flags;
        int err;
 
        err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
@@ -3723,7 +3723,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
        if (err < 0)
                return err;
 
-       err = nh_valid_get_del_req(nlh, tb, id, &op_flags, extack);
+       err = nh_valid_get_del_req(nlh, tb, id, NULL, extack);
        if (err)
                return err;

[2]
commit 585183403a6b692d71746527938b037f50feed65
Author: Ido Schimmel <idosch@nvidia.com>
Date:   Sun Mar 10 22:54:53 2024 +0200

    nexthop: Only parse NHA_OP_FLAGS for dump messages that require it
    
    The attribute is parsed in __nh_valid_dump_req() which is called by the
    dump handlers of RTM_GETNEXTHOP and RTM_GETNEXTHOPBUCKET although it is
    only used by the former and rejected by the policy of the latter.
    
    Move the parsing to nh_valid_dump_req() which is only called by the dump
    handler of RTM_GETNEXTHOP.
    
    This is a preparation for a subsequent patch.
    
    Signed-off-by: Ido Schimmel <idosch@nvidia.com>

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 03bacf9c0502..573da3660cb3 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3397,11 +3397,6 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
                return -EINVAL;
        }
 
-       if (tb[NHA_OP_FLAGS])
-               filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
-       else
-               filter->op_flags = 0;
-
        return 0;
 }
 
@@ -3417,6 +3412,11 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
        if (err < 0)
                return err;
 
+       if (tb[NHA_OP_FLAGS])
+               filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+       else
+               filter->op_flags = 0;
+
        return __nh_valid_dump_req(nlh, tb, filter, cb->extack);
 }

[3]
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f6c9d834b989..0011b0076c5b 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3243,8 +3243,8 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
                           struct netlink_ext_ack *extack)
 {
+       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_del)];
        struct net *net = sock_net(skb->sk);
-       struct nlattr *tb[NHA_MAX + 1];
        struct nl_info nlinfo = {
                .nlh = nlh,
                .nl_net = net,
@@ -3277,8 +3277,8 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
                           struct netlink_ext_ack *extack)
 {
+       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get)];
        struct net *net = sock_net(in_skb->sk);
-       struct nlattr *tb[NHA_MAX + 1];
        struct sk_buff *skb = NULL;
        struct nexthop *nh;
        u32 op_flags;
@@ -3406,7 +3406,7 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
                             struct nh_dump_filter *filter,
                             struct netlink_callback *cb)
 {
-       struct nlattr *tb[NHA_MAX + 1];
+       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump)];
        int err;
 
        err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
@@ -3550,7 +3550,7 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
                                    struct netlink_callback *cb)
 {
        struct nlattr *res_tb[ARRAY_SIZE(rtm_nh_res_bucket_policy_dump)];
-       struct nlattr *tb[NHA_MAX + 1];
+       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump_bucket)];
        int err;
 
        err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
@@ -3719,7 +3719,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
                                   u32 *id, u16 *bucket_index,
                                   struct netlink_ext_ack *extack)
 {
-       struct nlattr *tb[NHA_MAX + 1];
+       struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get_bucket)];
        int err;
 
        err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,

