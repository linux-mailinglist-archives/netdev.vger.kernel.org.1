Return-Path: <netdev+bounces-236989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C21C42EDE
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62198188ABD1
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235181F428C;
	Sat,  8 Nov 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iNJ0ECGT"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B27C133
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762616378; cv=fail; b=iww8D1fslGBppZa/gpf5UQjl20z6Low0wMeHLUxz60dluHvqRasLIn6wHVhRUeQ+N0MAoqJC4T7Yh9LZHTXQEmAO45ujZ7L8FZO/MRJE+ASZzYbSI2X6bJ05U0BBY+oHTlv30a406Gg6kBzR52+OIEVwkDD5AoGiSjvyHrzSaPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762616378; c=relaxed/simple;
	bh=4DShXniEv45Q3BLjvF6UkR+yphPeeHeZVJTvEA8mFIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F0CDTAgY3E99WhriHJhl7V8PY4l0tILnzJVJaStoqXM2kjD6da11oPYp871nAIYNcpAGk+4Iaq27kkMaFqqmeC5MPa28BgJOIeitrrXKJQiAV2bUr8+tFWU4NVv7Q6PDg8DZ7iykQzizPt/XM0eZSp8bRyjZet3w9riHzhTHFgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iNJ0ECGT; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PD9eDN/r6Ki1tj72l32iHFxFVu6Iw2gOX2CR0Gl3BUC6Zvzn5UASCp9+TaTc1+D8bDuqRpd80M4YqeAqGu7ZezewpmquRkIBbnVpDHoGKOjkiKc3B7bhh29YTCjsPq4pM02b+pCiix7TQ3CekLu45jNIYIrFFI2+sAAUYuQqbUd3B7jfDt4Ve8flOtpVaYtOB65yKo15icli7d6EcJUoJyOI7D7Kf+2n5IfeYoRU8hii3I/t3tGL3b4MNsVDdwWn+aJKO87qE4lln74m8ySzt853WZhJ1McLZD1WB2u5q6AxpbOqyIyUD41kq5JlF92EoEmjatzPVVG3JVru13RM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Faf462IPjGJZytOyj0LhZx7HoBQ52WYLk58lGU3MEzw=;
 b=HgMgOrnAA6z9ZiUzFYDbP7xj5fZp3IsBbU/6/vSh9hfbxibXbpx57eTu/ulIux6CjWc3lHZ7nkQCmDWPi7MIafJ25tNO/cxaENd0m577ahl96AaPSoTN+4uCvvgF4apI6EVtj0jZrs6omCf465V1nfyHS1vgX5a8JdaqZ8RTl24RftMA7ho9NqF4mZyLAfUdUClh9MWtIByA23U6qPdSxRc5jJWR2w6X9+uXlDR7V/MlaKtOmWwfgn0gybFma1Rxc/e8ndqlX4g9Pu+FHCYVgsa4V6Sa5Kl4alemo1HqxESGebKuBiXXvEGYrZTQzIY3BVDxqmQ0yFpvq9msICA16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Faf462IPjGJZytOyj0LhZx7HoBQ52WYLk58lGU3MEzw=;
 b=iNJ0ECGT8PW+05c8d+dm+I2Gk5nvgNsyNrKdZHww0ggwYihJRdCYhq3dBGuOh/hJ4URfv//oimziJB6xKson6Gvb0n/RkA6i9/TRXOoQkKvLu2RydYpKw4PE82SVlh8nikby5ODDCR7v3wPHjgq6lURX/A5Fvad1VqewSy3CpRmtJCiCOfY8axJv56ipvMAWokIZsqxmoExkhwxHsI6rufXMSSANTR8s6yjE635fllfgEZJzxQXj3nuNLAKZouvovh4zeZr4QP+uOxvP7M20V4MATF1haHVRvBNkC2R33Y60A7DxAwsCTBrxJtOMgpJHqdIlbYTsvmjU2QSCDY12JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 15:39:32 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 15:39:32 +0000
Date: Sat, 8 Nov 2025 17:39:21 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: David 'equinox' Lamparter <equinox@diac24.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, dsahern@kernel.org, petrm@nvidia.com,
	willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
	ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com,
	Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
Message-ID: <aQ9kKf42lNRpaaDt@shredder>
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251028180432.7f73ef56@kernel.org>
 <aQHkY6TsBcNL79rO@shredder>
 <20251029183143.09afd245@kernel.org>
 <aQ4qefp51ucf8CAR@eidolon.nox.tf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ4qefp51ucf8CAR@eidolon.nox.tf>
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a20d49-a51f-4cb5-439f-08de1edd02a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WTU8Mb8NJbSywuSChFLjpmybO3seRR6oBbsdKS6AjMRMPWGn97RCO9eiGyNC?=
 =?us-ascii?Q?EBgM3JfBQ1prnvfICe/Hh2LsQjFZ13ZgzsovhKbOsUaCut5Xm5pQWo14yAcW?=
 =?us-ascii?Q?K86S79pZ+recQ6V6fZfKvrT4+Orvt/NpuEydbYZ6+sJizO4bVjh/dmoJs4Rv?=
 =?us-ascii?Q?gzPMSH1tcHaRSF7jsjoUii90w+V5OrbevXAWjYxhNEq4qTSJNDYq0pJEa2Ln?=
 =?us-ascii?Q?XF0eWS6AYjQqhxOoXNx+BUcFjB7O97AVjaGbEQUGOusjzpLP53AMwSyFrgoO?=
 =?us-ascii?Q?oqkiOt4jEcWO4RkhuQuOZWaL7vVrigx4Ucp3Cro/iOBXLfAvoNFUQ95BgNGu?=
 =?us-ascii?Q?gc/gpcoYYhHbRKaiw40jdRBtqPWM0l40OQ+7tqu6f/5iwINaVMfgO/rqOg4a?=
 =?us-ascii?Q?nLpgAro/AhraVhnuiiRXhlGe4VjNvptoM49WJsFINnwXk36321OgxAxoMb6G?=
 =?us-ascii?Q?E7Q3yVoBB590K1ZmMVhgoa4+uxG/X8fr5VjlMGrYv5H73/5XQUXibNqdUSzk?=
 =?us-ascii?Q?QysO1W6ftownb+oOyWcmDc7F4pNsnYeawvMqdHDYyIUH7MN9rzMuLfrUKmDr?=
 =?us-ascii?Q?WJk+AX/apDvgOTwleQv78TqZGT5Q0Ge4RUa//e/asBlFzs1QEUCSGbmO1irZ?=
 =?us-ascii?Q?PA3dHlvo2HIN+cXb3CQVdsfPe4l+6j1wLUvlrezEH8sOINdn7xK4iksuGce0?=
 =?us-ascii?Q?PxvZYka3JhprLikOQ2LXlDuiWEYYpRxEL6QzCFgMJSj60wzSlLcNXSSt16S0?=
 =?us-ascii?Q?wV5tVThxYQ70j7fAI12BBWZe08tA7+rccLADb3bOOWx1/iNeva2z9mLh+lCT?=
 =?us-ascii?Q?xKRDLtdH8BuXdJ4NQOaJ478t4DqFfUjLKzBGeB60YeQKswAYH5TDO8Z2fgR8?=
 =?us-ascii?Q?u68twWun17Ss47VoR5ehCeJrM0nEjVwUTAn7eHCj/FroQjxFbMFAfPM13wNq?=
 =?us-ascii?Q?pH93gmH6D8nQfWxz36KeDNn+YAFwGmik1cJhf+QQpEiP2b/7UWG0luzPyaeq?=
 =?us-ascii?Q?Y6yAV5HbsalHOF5Ws/OTgJI9eGn8QQMK30D3I6yLKIGjfo5IeKpvSnOYIzx/?=
 =?us-ascii?Q?xG+xyb18XGIC+RIqZnMve0jO3/LFePfSIffJKBEnnwBLcdpPQQYnPY9lM3cj?=
 =?us-ascii?Q?Kk4za8AgV2Aedjjs+XjKZx1pIv5Wkyox9stpWeZNMyNWYPsKVHa+Wpu2i8oA?=
 =?us-ascii?Q?itl/YNWTZ/ejsv/jhMD6MdHGtm3kEjW/hnRB1MgpO475tlLMgwApC4reiPJO?=
 =?us-ascii?Q?r1oOv/a00oDZN5KTXpiE3p40NGpEkjARpslJjeGRrPF6bXUw48RJa1ZHA/uF?=
 =?us-ascii?Q?vhdLzijljYr00uncADgGKe8v2mRWLshpzLYahm3MMhxZrmtNpaOABMUjXy07?=
 =?us-ascii?Q?yyAE+88sSdqyol2Udn2N9/bT14r1IfKdxlgEX6rXIwDKWdHco59hpTw0fu08?=
 =?us-ascii?Q?taVfT4JzQEuAG7aJQCvrQFGNE8zLWQOPfdg3E76Ragkcl7pDY1l1bA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fo6g1Z8LSItYCh89vQi1I/Pl/5T++St3sQqjKqQbagDs2o9S8kYTsmQiGvSK?=
 =?us-ascii?Q?MXBQnYtVRWwWgsGVFhdEiHCfaQSAiEdNdze5i3XQ9ESFu8BnBQlpPY0SxHGL?=
 =?us-ascii?Q?zy118OsEKRk5pIIBuPHQyvN9cj64go6vRDIUhwPbFLl6LhOxnet6JHKVy/Yd?=
 =?us-ascii?Q?A/9CfVY2zBVim2SlKGOgmz172rP0oxPhkeGXTuKUVN500m7nWYhJ84M6yyBf?=
 =?us-ascii?Q?1Vv2SLr7DVFK6Og9XwhiLswzsbkJPBMh1ns+RyFVMKl98fl0PvU5y6T8GpiQ?=
 =?us-ascii?Q?wEF6fsQhRsMwND2omzsZ6CQ0pxfomXAZp1HFb0y7desryP9YRjVD5Y+aK61z?=
 =?us-ascii?Q?DpoVc91mtOpg+X8NcEuSPqwJUp8x4IGiQw+nkfpB/anz8gTB47PDjJTqHhjh?=
 =?us-ascii?Q?OK0x2UMibh0nQrqwIBLTHAjiupjzAJ6DZ1qovp81HPXpNqjD5xJRtJI8Q7Un?=
 =?us-ascii?Q?vc8iHNVkez8jIYX3EyBNCTM/Akt0oVs8mlGXN2pqQVw69+8YtZJfIqehwXnR?=
 =?us-ascii?Q?Hlz1vZo8W084WQxYNrhLEAD1BtS9VlAht05bZKIKiHOuwqbYiZq2ObW665ew?=
 =?us-ascii?Q?PGmyL8V1ePLvIuziObhpKRWrxvYgnctnrYvoluRii1jenEaupX0IPN6CXrnr?=
 =?us-ascii?Q?2fOuWCXRhASXzNSxYAxbU/SAS25JcdZ78qHASHr83UOxQG3wPtkL6NybIgro?=
 =?us-ascii?Q?Z3cb6Lq4enM+ose/1jw05GlOZj6tbgftHeYGj49LgUcxSaiIKRgtZ3Tq8rm/?=
 =?us-ascii?Q?SF41HFFYvorb9KJWzbhXWAosxCHwPCWfNu5x/ueW20BWzcRorxgLKttjQBUY?=
 =?us-ascii?Q?VcJiR6LLIqJlTVW2Inqf0joef/zNGh8qXk2CI74kFeOcQUcYo/p4nkBf2wQS?=
 =?us-ascii?Q?1ZG1FrPkZSkKJPMZK/pcAyTw3aVBHbPPT/xVi29I47XRWKIbOzai/KFq6LRj?=
 =?us-ascii?Q?IWad3AxtpX2d4wsovpEwBL+ugGpG+adXfFz8X2JG+08DjWWjJk3/Odm22khI?=
 =?us-ascii?Q?m+ZT82yoqe6PEUWv4RJabCZJ13mlhAorp2m3dWd9+EXeRKHh3UlFOaZ+DzCd?=
 =?us-ascii?Q?d97Jv9l5nE6/8DE+Z07Ddna1lwJXSwXh1XmxPXS2qMqgq4ekHKIbScQiYict?=
 =?us-ascii?Q?VYiPgNIT3oQeeK8TvQs9iFMgtlwAD7fBNn85mwT+zCMnvWukGYiAPDxJ3XNh?=
 =?us-ascii?Q?NRRPFnCgZCJELy3DGoL7kIsPBwpj3OwY4dgnuV1sSxaMQlznJ+0BcNwzKFuh?=
 =?us-ascii?Q?v6JDLJetcMeBibKWNjyeTJ88sW+1ECtuiIP65xohYbXLPhTtkRLpIdSudVH0?=
 =?us-ascii?Q?NpB2GHsghjaoFLz3y6aPLKOae02uMwMcOoPVBNJUnRqyWxB2nWE0Xpiwg9bE?=
 =?us-ascii?Q?rwIApuMtTF0Z+aA5mbJKdoJc+nu0w+cSSJr5CL7WZf1Sw+KmdlWsZAMDqwu2?=
 =?us-ascii?Q?3RA7Kbfx5rWIOhQ6JG80rbdeYEH/twR62ToW2feOJ24nrq6ZYT52txo/EQ5/?=
 =?us-ascii?Q?U7LK59uo1FX85grmGclQtueMNVIdftJQg2wb53wgYBWtJ3Dec4MwMliFfEn2?=
 =?us-ascii?Q?YmRIbgsGOj7sT4EOsFJYn3fn+uVN6uZ6jLpjrmKB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a20d49-a51f-4cb5-439f-08de1edd02a3
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 15:39:31.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuUk2y/Rj4M1c/78sIVoPUVoJJ1ouU8nyGFXCu3uIKNAPVw92hPuSlS+JA14VbFovBTlCezcNRLio7IySCJiUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134

On Fri, Nov 07, 2025 at 06:20:57PM +0100, David 'equinox' Lamparter wrote:
> The IETF is in fact doing draft-ietf-intarea-extended-icmp-nodeid, which
> is past last call.  The good news is that it's extremely similar,
> different class value but same C-Type bitmask, the main distinction is
> that 5837 had forbidden the use of "cross-address-family" addresses.

I mentioned the node ID extension in both the cover letter and in my
reply to Willem:

https://lore.kernel.org/netdev/20251027082232.232571-1-idosch@nvidia.com/
https://lore.kernel.org/netdev/aPnw2PkF3ZMP9EJr@shredder/

> Note that for unnumbered networks, 5837 is wrong - it's
> interface/nexthop information.  But the interface has no address, the
> node does.  draft-ietf-intarea-extended-icmp-nodeid is about node
> information and the correct thing to use for that case.

RFC 5837 and draft-ietf-intarea-extended-icmp-nodeid solve different
problems.

The motivating use case for this work is a deployment where router /
infrastructure interfaces are only assigned IPv6 link-local addresses
and the loopback devices are assigned global IPv4 and IPv6 addresses. As
such, each node will generate ICMPv4 error messages with a source IP
that uniquely identifies the node.

draft-ietf-intarea-extended-icmp-nodeid is needed in cases where nodes
completely lack IPv4 addresses. In these cases all the nodes will
generate ICMPv4 error messages with the same source IP of 192.0.0.8
("IPv4 dummy address").

While this patchset does not add support for the node ID extension (as I
don't currently have a use case for it), the implementation does not
preclude it. After it is implemented, an administrator can then choose
to include both the incoming interface information and the node
identification in ICMP error messages.

