Return-Path: <netdev+bounces-77387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3078D871845
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201BA1C2116E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75B1EEFD;
	Tue,  5 Mar 2024 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TeHXwBb4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28802DDD9
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709627702; cv=fail; b=V8XA8Ht0bpK8TQYbuWYjhQQjrOYpZl2XupzTkb9VbJ7u93zL1gyEPJP5KZ8xoKHVsUmmyn4TVejSvW3s+crn25U6hd3Fedil5b0JSXIp/abx+ddZfPpp5XwdQcFGGfibTXCXfLO31iGBOi9LgKoWM46IhhBGqGOyO7rXfnStR38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709627702; c=relaxed/simple;
	bh=dSmfkn9gmocZ8sWELYLZ1vufem/Mg3e4zuuFKQtwAuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fwv+HHOwb5HsELpVmmzdqAhRy3Fi1u8bbI/FKS8ZYMd0vTJPlvl/UbYQtvU0IOnw4JMPgQJHAfWTipLXPeOiPV42GvX+dgCBVbVHSRXopiXC/0fMgCvaoUIez8LyV7+LnNxlyDrWuOJpr3zPHJOgxKNpPlWpXw8l25bjYqipqw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TeHXwBb4; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFD3diPx7oFtN5KG+Wui6RdaKKmFE5t/5/9KnUd1a2vuZaJh0D2DykkC5X7q2A3xrfJk4YTX7HuwLZOnEFN82NWIqzCV4cqpH0JKhWwd291HP4Ps9k9rXuD/jtvza7zoM35eEheLOMTIWC389ZDRHSh7CYUW4gPypxBopAwLB8rwu0842BKDLHJyvbwT5jisU9d0xIR1QIb/cswbzLFvwxhxN+/GH4PGQT8uhYKqCa9amfEFjfYkn2nuvmqYCd/3gpTjLXTwl7VxiLmlh2gFtveTOeLWJyJxFgxRBUVTtIulNNhDdXFDBzTGozvfAYs3anAgy9XZ1q8LKwMFQrrSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PTZnNfomC6rsnmSi7VEghXSwTdtluehC5NIjcIj4NQ=;
 b=h3HB/UZup9xdVxwY989Lg2MGP1qOBSaL1mTrY+/HHCX6j7Q2E6alm/gASCctcYtC0ZxQygw+4JjIez+Hj/KcAYuv0Xfc3J1WVWvvZkA0L4bD6coHPQemruY8aiSB4bObmh3wTu9YrphsvEONqaD4d2GV7Ij+6LqXgKF8V8QUkJFGl4DS4N6yhWFA9byQ+VamvRX49UTgPhFCMchWJPrxdHoEKAh+ktMVqTzo54qJw+rKjf42ELn3gzecTZyHo7e6U782gA7T/ZWRS9nf+PW60JV2Hjflb/s2d1mJ6bVhAyRViY21btWul3JeLzZ6cRd40LBiBYQ21ytWWgXjX8ofxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PTZnNfomC6rsnmSi7VEghXSwTdtluehC5NIjcIj4NQ=;
 b=TeHXwBb4P9kV3xHVIeFs4av+GypjtJdhcPDwPK8rv7jB4DuoHrU/ktMctT8PwIc2T5D8DghKaKebHpp1Y7VqvVuHQsKYKxHSHFSFSM4gSqDa6Yo3A+YoY7yaZIflTn8D/td4dzvQ9lo+UCme5ulojn8C5oTiu6M4fbEIN1kgwBPNR9FNXscSgyHxvn4MSRPmiESVhFZIWbtSu8ziN3CrLh54FjdikiEb8TIOB76zlSm3NbvyCSnMDu7eOOyN6MKF9Fp6hMTz7Pk2dtnPIR3ormG3Jgb/ezh6O06C803zbpLjtWG7os8wZhpmfc7RxUVRJ6TSBuiNTdIiFOt0tn4AjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 08:34:58 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 08:34:58 +0000
Date: Tue, 5 Mar 2024 10:34:53 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v3 1/7] net: nexthop: Adjust netlink policy
 parsing for a new attribute
Message-ID: <ZebZLQs8XAfCrpul@shredder>
References: <cover.1709560395.git.petrm@nvidia.com>
 <ef1506fef5b38f92fe0aad82e6dd76084167392b.1709560395.git.petrm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1506fef5b38f92fe0aad82e6dd76084167392b.1709560395.git.petrm@nvidia.com>
X-ClientProxiedBy: LO2P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::27) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2c7253-9341-4a59-92a7-08dc3cef2468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLhD3gSLMHMljJJ2JYcFiAo3xFEh2C7IchHdJINVkGrPkb5PoCs5e/kjkKSaWgH4RzX2U8ekTOl22/jLqnbv+Rl0QMedWuX+qb7AqoZ20o5Cx5VFx/B/53DTQcVJjfhHT6XFbHL9BD7uOSwyN8G6MBwFF6+CmXlRN+2MtP1VTRwmKpal8Da2u5pVwnPXCmkhGoUw8Z7GLp8MzDEqO4ygb59wEyKNFBLNWmLQ62P6Ldfs5IJBMhD6vQi1g9vVDUbmwoBr7ebret2ORQVZ1HMyXi1IOUTz5BfLMu95DigMTt1JqKc0g1Z+o1o5qK+uLYTTtqOowsKsboyHCxqoHOc6yMgsui8iU3HWmxHwafrx/iW4dwTVNPYigo11ls6onXTHIyuKM9xNLVVJZzOQlntJLo4BSiTzo8tIG9VcKkIZdRGIe49lsZZgrs6Htm3w837fN4HiAVni7Qvnzt28RiM05AuybG19irF6BcHNZC8U+Kp0RJGf5Z+Mz4MnThmy+jUZqMC08+bz7xWWgsJpHqxxXvc8eojI6//40yiNs4KUD19DCmyo5KEM3PPFLiTRYYl17MIzEVS36gCtLs+ZcsCAJ4VmKBm2C8+JAxo6BUykRmH/lNBG3/DlOPbF8t4sqFVCflVxyvDrNLOgJq6sJCeP2iqAaiqqdw0m/t7gifH3sc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ooz4H7LFu9OpkJSkFkc9z1Ynqjm/NCEz0CnIH5JIFgxDOJqmnfllJpjB32ct?=
 =?us-ascii?Q?/jcINQYKpEkWiCVtfQOnuTTR3XQMDg3K+WPqw22khD+hKWGJ7JyD4XnWgLMx?=
 =?us-ascii?Q?96R7Qu+rwJlXsH4BCEnKiJ8H1rJnOA7Fp0jQ4KUKuj00/RdW9xm3UF8oH7ml?=
 =?us-ascii?Q?vjBp8BOQjSyBuEJAfUPJTAayWDFSbv9mZQX34j4WAKgyXYzJ/rSV7+Y0uZMm?=
 =?us-ascii?Q?RuWCx8PlFGxrbd2fJKmgkEpN8E+fxfrOd8qEItQgSYIjCFyn99SVUCWlNe/1?=
 =?us-ascii?Q?QL2PgmxRCgjH3n9tK6ugzPiLSrTm6I2261o+UffWSzTiMUd2hYCcwSRdkqem?=
 =?us-ascii?Q?4s4hlpJnEdfZrzr5LchN9VYOAPKJizQ+cqEW+im+utCv98l6/mKCluKmukbP?=
 =?us-ascii?Q?oCHiAAdKbnb5BUzh5EzFTQcry0n+v7GmpZjYJEkrsVAv12EAeEDI/UliEREg?=
 =?us-ascii?Q?/F0FxcQ00C3cOkzJeWVmm0rlV2/gwDGs0h1/W8GstPzj/RYk/xV+EzWR9hh6?=
 =?us-ascii?Q?arxsSRhJ3cVEsWtfl039LajPF95xDkVZCsIxmFMKBhM9eFkDmK9wGdHCPp8F?=
 =?us-ascii?Q?sLlN1Ea2pT1ZEA7TocGWmfQavqpFAT/4SfIWlr/V+Ev9T2AD9LxedfrhAyIy?=
 =?us-ascii?Q?SECkObvkwxymHXhDs2Mt/ywQgiGspS9a6+60p/jzePqwmQ4UEV47ic2S96UD?=
 =?us-ascii?Q?3NdacLbqN6+GyPl/Z4iZ+kIn1QfzFMLcPVbKxmitfdebJVFXvG14DIeQzTvm?=
 =?us-ascii?Q?tLONtP8ynZE+05u8vbdqWErg9abc0A3R1NvyzNfB/hscLuyNLdF/IhXG+MsJ?=
 =?us-ascii?Q?mQM9VZ3lMNV/HIBBpv2UFAKBHYWL0I7dm3Nva+0c1R0XgcpRNJsfraIZBghE?=
 =?us-ascii?Q?VhC0wkLn8M5F/eifGMa2k4370yaXiXgIRhBreIk2V/FDK2TFd/q5NYTzc1ls?=
 =?us-ascii?Q?zQnjRByTN2slKitTZpYBM07uGizZcZJ12qYwk7mFqa6tlZ8QMq84O6wLaEfD?=
 =?us-ascii?Q?beGmLK78WceI4KenvyFStU9h56T/jn4MdZd1QgQIjsHn0YTubSHw7BStKf4o?=
 =?us-ascii?Q?+E1OPBRnO7yDuWhOALYsGGxe1yIfZeaWH5Z/jzTXfGmx1pXvn07aP9JQZdKM?=
 =?us-ascii?Q?WfIiVAKwud020LX7lpF8mZ6R976OoVqEOAXSn3u+s21YfgUmVKg8DV67fOa0?=
 =?us-ascii?Q?RBZOBn1Qms04u0V/ZXWUe4DbaZFi8UqJRmTzYQi1ECdTukf3UHpIzsd7y7ji?=
 =?us-ascii?Q?VWut9Y+OXayVQL/yz71GBXtQqKrSgeopNF70una4VmYGbg+4TqkNoqR7Orp1?=
 =?us-ascii?Q?wDMgsAWl/0CL4SwgVqNhzXLXwWubxT+aQnQ1YpuC5gTYuL1Fa7Ruod+NbtaS?=
 =?us-ascii?Q?NwwgLcuGOTQKkVouzoSSFrSA1QpMCvnIUnGX1nG/fre4W7K+xgHrzj4oolEp?=
 =?us-ascii?Q?FtpLJogqggDtilnSf4P4pyK0B0pgvVJuQ2L2FnFHN91bY6LmtdXhgK3IOrG/?=
 =?us-ascii?Q?uSwy9y7Urrc6G7ZVJLohElRCzXZulFYzzC3qo5v5oqIoe/iqTfvbjLn288m+?=
 =?us-ascii?Q?UkzoYm+P//aY75ToaprH0CRcaDHim3+vDURtQ3SP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2c7253-9341-4a59-92a7-08dc3cef2468
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 08:34:58.6592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2tILmVfFlImOWtgvKaFNA8BRM6kad1TjEcEyDjO7MGSyPErzGKhJqFcMTplL9Zd4xN753tGS+EGD1bXP30yrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562

On Mon, Mar 04, 2024 at 09:51:14PM +0100, Petr Machata wrote:
> A following patch will introduce a new attribute, op-specific flags to
> adjust the behavior of an operation. Different operations will recognize
> different flags.
> 
> - To make the differentiation possible, stop sharing the policies for get
>   and del operations.
> 
> - To allow querying for presence of the attribute, have all the attribute
>   arrays sized to NHA_MAX, regardless of what is permitted by policy, and
>   pass the corresponding value to nlmsg_parse() as well.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

