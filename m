Return-Path: <netdev+bounces-77391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A098A871857
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2748D1F21979
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FE4C63A;
	Tue,  5 Mar 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gss+WfSa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03602E40B
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627997; cv=fail; b=vFcF6q1aiusu7pKG+wOFRDIjUPqoayc0JoRlzqdjpgLjCFE4JSqhB5RVprdZAN9nBBjvcd27oLuGzpu2IC27SEWyno5C9Op5+M5+Y4rwn2YwMeRCfIsnWYB3kclWLv1ykXkit6GzGaQCebPqNanqnykLioJyW07dafdW6wKh+gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627997; c=relaxed/simple;
	bh=52fKUB/EWP7Wua9ylL7R4oA1/VFhzQJDexQFLliEhuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YjCxXCB0d9K3kfjgmbQ1aXMjDQoxe0H6xKpYGyKkRI2PYFr2RLq9IUx7zIeRXxgxr/TBIUgujStHPTYuaEzllUoonbKJFVd4pNzhwyw7qUYmzobLdluAazdNP6UGw8eyQhKnOUeysltCMNh6KcMlCZjIgBtv0vbjIbPgxMfHRYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gss+WfSa; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv6CwgUifD0wXvPncehR1fYf+UER797jDzkU9FoN9fJsiZV0StH/y0wDJIhGcei0vxh7wHD+z60/3lGMn2B9v1U1WNqTTOK40v9pRWqK//pn2PDdK+K+u2Yh5+yxwcuIQZrVKFeai/1F/xBRI9sqrBzLwkerOQRjEW/AqPhXgT1FKpmw919+176eNdjhYumZW45mKgk8znL4J/c8tHNi52jTsE6Y6hJURrz6fFSVgjnTjgtpSM8ezKDc6zk/iIl86+939gIxcmMl1WwzMG5YIkM4k7paXOJsF2fjBkZyZXjwPh2EnGv6da8LSd5kleU3NYqB4OZEGUWBbx6ZPj/t8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn98hNWsTR9IAMjFGAfWZD9n0NN22ygP600sFCusvfc=;
 b=Xs5rurXq4Ljv3EIkC65UQMsopRA66s8eJfoZXX+ZKbAmRoYOWyqXW+IiGyAWcLDtF0abCpY5IP5I73DfECZdLiQE09V/bthSLywP1IHNgjFrQci/txN5RJ8TQNABKqdnPf2qSWgsJUmEKGkq9zQtm8bE1Lpx+ZMr3gDdcSgM/ODcj5uQ6TcaCiEvtH9jhWNdrxjJnw2f451EVXy3f3Xb9JWVQODSSh3GfP77b4olxsCfJxWgRKgTosRBdFioGbjnpp3P0RWcNmTcHgWRveYSBpXNya7A2i7sbVUlNoZkj3bmmh7BahVQXHtoBCL8Rd4vJd76kuJ/IW/X0PlUSEfAlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn98hNWsTR9IAMjFGAfWZD9n0NN22ygP600sFCusvfc=;
 b=Gss+WfSaYrVKdxmKFSlGFGzLyup5oVOB7girPhHTLTjyrFmmbrRtxAa51nw4aIa14U7iOnQLjF65QyzEOo4yYTBl/amlHmJQgG2HjU9i/a2v3MGI/5PiFKvRc4yilPJCPZvGScoTKRwq+RY04YxdCWmNmu+tt/f2YEK+hOkOGYhSIpSSiD66nSlLOq3igqU53asMUWyopA86rqe7FM0Si62T5xOz+iwkBk9aXBoXhUr1up4DoPa1GhnCgG9PBuYocZpJ78PBEGqGdukQzmXMpaCVWCDic40A+y4+Zpjmb+Jx1Fw+a7DR3ecYTMl5KbbzXjW9FNuQD8eRHUqJ33qelg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MW6PR12MB8708.namprd12.prod.outlook.com (2603:10b6:303:242::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 08:39:52 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 08:39:52 +0000
Date: Tue, 5 Mar 2024 10:39:47 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v3 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <ZebaUyYfghHnwG8C@shredder>
References: <cover.1709560395.git.petrm@nvidia.com>
 <46fd3a32ea411c65a66193b7e25833ecf8141326.1709560395.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fd3a32ea411c65a66193b7e25833ecf8141326.1709560395.git.petrm@nvidia.com>
X-ClientProxiedBy: LO4P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::8) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MW6PR12MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: f075c3e5-c103-46e8-0bd8-08dc3cefd367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eb1ZHK6OmDUOcKmrVFv9VUWe3eWWb9eC+kMPLi7fUCBxfW/wTKkq3ySAk7OJwYYx0qNUy7cwURdZo9g267r7soxzscRbcjqT7z7yVhYBQudSafy5qwCBO/77AcQJ0yTT+bkqmSrTV7B5kdk4ywWc4HG7JMXcpZWWSFBedcbyVix0VMQ4QKRAV0gM+CRMJL7MdRZVfuRzE/Wo9yzuEqmD3RnO9IzEGXvXy+tlxkmXA2ZGjlM3UHLBIA1+DNI45LIQVG6sGzWRE/mGpaSYOKlDaRZkdcgsQdk5SI0WKhyiL7TauubpLRWMogmnZYBYnRte8KTSvJfxtKWv4tMTyEE58MH+Ix8wW8elzQP/oHtf4Sv6dGzN5JIvnEF2CyGioc/s3dPjbqJqY+Du3dd05jU/+eQjbB7UbHeeW5/WWCbh6y/+b36ZLW0duntoFDKntNvM4xFbMwbjoGGXcrL3Wc1Qza8n/KPsuAb7ZLMHwebE+26cy+1yYZIhss5aZEW/Cu7bwF8Er0DI69/BMARiqjfF/D9zLmypk+0N7M5iDuPWkrn6GaSEc8gvk8uBcKizLQfNiwW9DkxG1NRqzXEJ0lAnurNqoWXP00tnEHkIDSrCFvzjXn0IiBp9kPCXX31ehUbKeVwHXlPcj3L7GXUTn/ah2OkHLmjPpxSJpb3qjwVKfao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLvoZGNCxT9ipMxAomG+XcY8d3G+ThC+LJTEaFGkLCuXPUumcoAW4fjAeQ+m?=
 =?us-ascii?Q?tppQzUaBNCUyRK7OjmN4DgoeMcOP1tlYTmdAF+xJEqTXGCb61TIHrpnFxNdi?=
 =?us-ascii?Q?WK5uzOSTBVPD+/rEwW6cdQI6Tp7y/1HwqeXQm4Er5IZbDimS7zDQcl2ltljC?=
 =?us-ascii?Q?la2a9mbvN86F7mdng/07qaNZY1Qy8rjJ9y0w5Dopdf1EmThpfwscXR//V4eD?=
 =?us-ascii?Q?KINn/vZoLELtaijkAhtyullwEMMJOwk1887XoEkhzMit5W1mMlJRFiLQSX8j?=
 =?us-ascii?Q?c7+3AAVVPpy0rNoPfLwgysCQnzf1Zgi1u8+pagKnY/K3jVOcVejhRhWSVec4?=
 =?us-ascii?Q?YLiil7wZHGevYhbi/p7qnDPe6/vlFdzvmhwxuSSALhoKtnTCDcdJNpT09b/V?=
 =?us-ascii?Q?/grUOt3mpdZE1Sv0eHvn55j2/D1ddkUhyolQfU6ksChhOwiqzK2l350vCM3Y?=
 =?us-ascii?Q?eUTDw4QcDSbAWTKObmARhz/uVkN7qZWqbO6Vs1jctj+cRB1Op2UiNsWiqGY7?=
 =?us-ascii?Q?8P4PuGAKKZXYUrYQj72FOEjFrBgT4yfIdd9FmP1KCZ7G1JPeL3dEgSvI/9Sc?=
 =?us-ascii?Q?z25bgWO2+lJ5PNiJlA1/ubPNzzZ3hjY+7GtLbKF1spYIfe9PdeMBHgq+rtaF?=
 =?us-ascii?Q?KcgFkYG05qx7kr5kSGAZCxNPJ6hH6fGmj0KpJzTTd8lVay6KayKlwCDms0ID?=
 =?us-ascii?Q?o1ubSu7UyluGh5jjM7c1tXiUjH5d/er3JeK7Trb1Ycwy1AIc5C4LqfsTKZOn?=
 =?us-ascii?Q?tFLIOudH7he8otmchy9vQHcgDudqmI8IpiEUTLFZE+13LC/h7X/sZjcn2FLe?=
 =?us-ascii?Q?V+TZZd/boXOTKgJM+u5ChBx7SMj6WMWuH8ND3T6tJLABYrl9Fj/bWBdtYhlG?=
 =?us-ascii?Q?incJbZo1wMlFg4/Zq2YpkoEqel+aD2fJaP6DoCH9P1AGqcQz6dvtkyTtEiTV?=
 =?us-ascii?Q?KrgJCiv1IyULdSGJ6KKR/1YJZflDKplJ90necgwdyxDNolLdAHYRf1xe8uCX?=
 =?us-ascii?Q?uyFSps9arfqzOU3gzUmD4HvmgWBl+wKqIE0SnqlGvvMw6qg+sDsexdub+Iue?=
 =?us-ascii?Q?H3Bt6PZZ2CsjC3tk4uWZlsrBM+jMqeNuBHmkDw4fVtbX1hUNd2RY2r22lDsi?=
 =?us-ascii?Q?34dcUBqVRsLu0U9yuigD/J0ti4rHTJfoytEtupSCCOZe9GT4xxjq8JIMmzi+?=
 =?us-ascii?Q?LIylNfk1plUYb3W06+jyFa+Uiy+3kW2rDC9e2BE8SY2LuDeYGvJ1uVo0HoKR?=
 =?us-ascii?Q?TlpOnItK98sppnKthwqurb2w/xG/60Q165CvIEATlwJV4LHXeRfJbJxGw2c4?=
 =?us-ascii?Q?2X8/rdac9izvF9nZU9iqd7oYnumgqxS2GiumpuiqEmNWX2/CS03p2bnS3F04?=
 =?us-ascii?Q?mFprgeBJ9q6Ufk1Jv8pU9tsz9XlXdxro6Bk4WRK9KYYkCtDSXTaumiPuud77?=
 =?us-ascii?Q?Wl+zgw2VBCg8Mit3EBtMxdi8soYqxWLxJQnc3JIVelXtXkoZZ0XbmcTBC/Gj?=
 =?us-ascii?Q?7eI+9a5XYsxCW+ILMy2hmh7+5xxhKGDbw8duSEQHqalXbpMIaVqTj7pTgV3i?=
 =?us-ascii?Q?z68R8Ew08zFmQxgvyY/+Nj4HdTL58sH3X7/LjNtE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f075c3e5-c103-46e8-0bd8-08dc3cefd367
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 08:39:52.2183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E13uOJwrq027A+nAPa8Ygr77fJpzdjg5SJzQV58wvjh0A6ePlRiQhf1S2NppivmdpjnuIE54XrRn6p6QuN/T8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8708

On Mon, Mar 04, 2024 at 09:51:15PM +0100, Petr Machata wrote:
> @@ -2992,6 +2994,11 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
>  		return -EINVAL;
>  	}
>  
> +	if (tb[NHA_OP_FLAGS])
> +		*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
> +	else
> +		*op_flags = 0;
> +
>  	return 0;
>  }

[...]

> @@ -3151,6 +3161,11 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
>  		return -EINVAL;
>  	}
>  
> +	if (tb[NHA_OP_FLAGS])
> +		filter->op_flags = nla_get_bitfield32(tb[NHA_OP_FLAGS]).value;

Shouldn't this be:

filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);

?

> +	else
> +		filter->op_flags = 0;
> +
>  	return 0;
>  }

