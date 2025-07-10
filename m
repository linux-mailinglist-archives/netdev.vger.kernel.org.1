Return-Path: <netdev+bounces-205762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD366B0009B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31FC15679BF
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CF71E9B2D;
	Thu, 10 Jul 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8KaVLFg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB42C8EB
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752147214; cv=fail; b=Di1Z8LjDRSFEwC0jPLK/ElshpFsMoVFH5RSMtv4x+iKC45xf5O1sy2ys7gwHQXo44FLU9MN2G5FJpfcU01mNQzq8Cq6pB4j5qFou5fCi+q9fbsY0cQu9n4n4PJ/guaGU5LxzBM10Y/P33UU1Ge/Sc9/S78vE/bOshYJNfVBXkhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752147214; c=relaxed/simple;
	bh=tdjHh7EAvy+Rx/cP5Qkdt1JOZVM0pN7epr+3bkijxhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CkVcQbYG0lDZhfozadi5IGxrpHqp7UxhTFLpieXGPcCkbSp02bIkS/4tGRaBwbW86D3eG3GMNq+095cYVZlx9jxkYRljzJXpdNyrUNXtA38CceINSA3vz6SqQrk0218oZt7wwhUmCsKus/aJGnbDHMka5/ZNMk7FBCZLRa40zrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8KaVLFg; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSTRpdw3YpF2+D3MVNbj3ga0fUhknzsgW7MT5bBRJCRl1fwDllkwUcwatZSA/MxOCoDh53NsPQjdXAAksvkXJwrb8NXUYzXxP/u9HOi+C4r0p8/xy6egKLPLYqJuhVar8xhGM/kV955Z2YTho2/6ev66nyV5z2YF/3XijcDkTbQydxqxyC2DCSrRpUKd5Y45v1dDD9e7ugd+P9OxH37mZLthhgBFDtqu+/stiW9xvv/hkR/RtYNgUIDFzo0chNfsdVMmDbRJc4BS5U95TMilqxnmuOfLdvn7S4q4/w6auqKSGzH81Hku+yfScl7GOvY+QRsdpz5NyUe0PN+26y26Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JI1BM2nV6nR6Y8bb762PGz0xa/soKbEDHbI90F2xi7c=;
 b=KLO/6MOaLqkqp1l32Xu11B9EQ9byCRTwEHm6yC7r+TnJ+3GhClIK5k0aUOMAzEJeWHqrtiV3FR2LeoZapofwJF/uxezH4eWeROEh70H7QsA3Orlbt8Ug3ayHlHq/F1vHNy/V2y+nWFI3xUJZ73IOZXCbwI/+pw3YCCkbaAFZTl4LB4SP+XmJJ+pXKSSInkf2L2+z9pIFYeHvaCUR7+InQ3LZC757MdI5rEDiWRs8dZnfj8bYZnYX20niFW1qoeO6Nn7XNcBveqLgXT+BIRA7621xyDDrvPAQLcMHCnJbzTMv4FyZKtPMZ2BWiPs2XwNaraeLsJxE3GGhKUPnzCTsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI1BM2nV6nR6Y8bb762PGz0xa/soKbEDHbI90F2xi7c=;
 b=r8KaVLFgzKJaVRwZcv5/ToXb1xfHPd2CZJq+GG0Oo0sM4kXFmuxaZ9U0+zH+hY0vRFi3ZwJWC3+OAeVzUBtXePFQRxvLIo286WgoaWfEVrGID0QBeNFM5bldvfz6qYM7iF9WXAFxuUtUDB14B/J6G1lclFX6Ecwev0q8PBKmVUvZfpOV6ttRDdDiWwwwFTjb2ku16MbOzwm26GtD7QJ5mprdn7rF9BKMc+ZOYMyrfb7mSGMM92aUJ9sgHJhTK1i5J7tHNZjDZxFKdu4+NF0FvzwmehF63D3kCiGqGtKxgeGVFUedwh6sdT2iIhZTiVldin590dvgyDwIpZSORoxTzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 11:33:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 11:33:30 +0000
Date: Thu, 10 Jul 2025 14:33:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Aiden Yang <ling@moedove.com>,
	Gary Guo <gary@kernel.org>
Subject: Re: [PATCH net 2/2] selftests: Add IPv6 multicast route generation
 tests for GRE devices.
Message-ID: <aG-lAN-qXs94BgWl@shredder>
References: <cover.1752070620.git.gnault@redhat.com>
 <65a89583bde3bf866a1922c2e5158e4d72c520e2.1752070620.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a89583bde3bf866a1922c2e5158e4d72c520e2.1752070620.git.gnault@redhat.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: c00906a6-9c26-4d0b-9741-08ddbfa598a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iDu/oaQSXF/vEAJyytcCQolGSqx5Xj43uoY1WTLL00SRdlqx7Eqf5paU1w3l?=
 =?us-ascii?Q?xJXL5nuxKnaSQDXESU9QEdRtPebleOyexKYkourzvDrrRque0sfCrqxE0mcR?=
 =?us-ascii?Q?3JerqxP31blLneLbkXqOutdIcxn8YGcebJoGBTth4rUJzxLjN2/QeyUa2Jfq?=
 =?us-ascii?Q?GPriF5zGghYCkMyNuHwRBrFB9z9iRpXeiRxCeSzU909FkfGHbZUn5zFY3NCv?=
 =?us-ascii?Q?dNQt/pXc8jai576RJthrkKTQBQXCmwVz+ikkPcugs/c6KsKH0idKp+jf5MTC?=
 =?us-ascii?Q?fns+zZ6zXgAIkbFfLMULR1kza852ZGuulVsR3Uk+zDw+ifk+hmpzH1Aw77gJ?=
 =?us-ascii?Q?cgMe5dNlXDuW/Tav6dMumcLTdnL7eWgvn2tSTesfPMsQsBnTDSCICQzSaDgz?=
 =?us-ascii?Q?1BviygQKJQvJ34cSu0yx99SP1w0938izshkp9lhTW+43ebaroHfkQgZ8o4Ut?=
 =?us-ascii?Q?yCOIP9zqN+O5WG9LHd/e7YbNE5kJKtlhLvfRi0EOzojueQH2i2X8ltwLtoJN?=
 =?us-ascii?Q?iRiXLCRx3j2d6KXfgTdkiqZS5U3ccY563pyV+aGvNwzXE+VGdgi9LxCruany?=
 =?us-ascii?Q?qaMYB/LmjyDKD7D61+3wX91hl65vq9TTyybdVwgd+qxAhEGyp6GvmRKMBpLx?=
 =?us-ascii?Q?ED/hNUaAzhRvuR0XR/MneXrGaeaoO7bOR74cC5ta9biQZGUk/+Lr3sA+OSXU?=
 =?us-ascii?Q?CEHI0kW3dkfljKvJQ4DpPPzjPXUh6UNFIfWY1vE5FqfzZMKlkyb2rg0VY+Al?=
 =?us-ascii?Q?0VGI9XiiNnAmIeusnk6fLV4GzfGQI+YFdAbowegZvm3AbiKGQhNcLpYVCGLX?=
 =?us-ascii?Q?KXWJR3/HtglhxbMFgJsTKKS6cFxbIwm+BnZrBnruYk2yL7bSLJzZYDD/3A0s?=
 =?us-ascii?Q?+GJHEANkoJZ+5u/bG3LQo2gFIPS6pRdDJMn/SD66mPZ0qp1P9F15uwI4F7NR?=
 =?us-ascii?Q?PB7sHs0nWu5p0Ic688pwzwvGN2C5xAYPf9Cj7+5WgryTi1QE6TettzuLqz4S?=
 =?us-ascii?Q?Flaa0LT+PcIeMpAS7+0I68+/IHe/zVuIBcPmjau8L+8NsJcP2ajfJqtuZBDX?=
 =?us-ascii?Q?UpXyKJM9TKiyS5DqyBFS07OSNPzJyXwhRZq3dIT3nmBWvvh68xOvTsHu+yIe?=
 =?us-ascii?Q?ifW9NFP0YRY7JKLAxpJBae2opfhGkA6yI18ZQ0cShA+UcF3uM30uqdJMU7oL?=
 =?us-ascii?Q?/EL7FVdg2JARE9XiQG/kuu/uXdVXCD1mE2eWRKrPiZytc1jzCGN7CbE2jDWN?=
 =?us-ascii?Q?+ylC98FhFw9rIgaNg+YOkTxPrtRj0/2MULqjdoiG9gGKDONswMawJNj8QCp2?=
 =?us-ascii?Q?FRZieieA33u4iqaKbv01ym36SEwd7wDekrRerQz0b3isIiQa7iJ/3I5Qf1VL?=
 =?us-ascii?Q?0Axtz4/G0EKMQmn+vO/qyoLvJhIPQO+cY1DxmnKXsFdzeSVdIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3pnXWkf22RQeybjJbM3A0moCY/exGcOhUMsL4whJGB1ahwVKUdcsPxs77b8?=
 =?us-ascii?Q?DKGyQdFmRnjC9OxrdkfzT5AFl3mseEzibYXeTCNAeMGalbOZ5PPllWLXRPpg?=
 =?us-ascii?Q?8V0U9nNlU/bD/r2/w2ayTEKG1HR+ZQSyr/3GqRPt5Mu6Te4dzN++e3UePo/7?=
 =?us-ascii?Q?+PhY/SdoYysrP1ECg6lJiz8qzvZjW3c/HNFil801eUuls6H7V/wPQxVQ/JVs?=
 =?us-ascii?Q?2Ypv3rMmN/wnA3ouQRViKkao+Thq9KQh/FQX688Moyj6qXj4dMaNcNP5rvpV?=
 =?us-ascii?Q?gy/TkimwiwczSajOqweHRdGlxm2jUX68EaUqgXZMEx8RvLrMwaekUlz6Cpgv?=
 =?us-ascii?Q?bro1bhOUACQEpgmjk4zt4LqdJYfyFudn68fpUKoUAZCcSaO0QMe4bWAYZ4w4?=
 =?us-ascii?Q?BQ5r/4bFopjmm2g8kDJ0eHTJBo7C9j8geGL75gM/ilfBL0QjT/25aB4WtF7V?=
 =?us-ascii?Q?B92BWTQm+zaD3H6MUnYo3EOQORhxl+MAGbxEvm6PNK/+qxkbw48qb8k1h3rd?=
 =?us-ascii?Q?wEpExR5a1TQlXqipYEcyyy8tx/EWzw9C631hJK/NyMPfENy+iZKED337X1/U?=
 =?us-ascii?Q?v8kmO2yb14Og3SoCAAFXOD8rE3fDnDvKaNChXYqteG1V0lKMgfisht9i6BYB?=
 =?us-ascii?Q?AfLBpSfvLrVGnwbxCP4UIcy3Vrt69m+gVGMs/5EnMhwpSrZdwzWM4kef1ztK?=
 =?us-ascii?Q?WnKCG1SbXeXxlAjCiZjVeXvMtFOEfDS4mspJYBoBbXpHCqTu4UyCvcbrVcBH?=
 =?us-ascii?Q?w/yS+tHlBQjJB7fp1fwrwxnFGP2EkITvPiMcFVzfInBDEPB1LPM/VoLXTP30?=
 =?us-ascii?Q?5kUNFRY+rKywlp/MucUaYUTwqacDcGazvc7kpoh7gKL8xAL5ThI4d6hW53eX?=
 =?us-ascii?Q?0joBAv+5x+5b6fsoXv+2dtwK1XZROvf4mMH4+g0ozVe6XkxM1Ogsb9aTOFN/?=
 =?us-ascii?Q?kOJpVKhTp7Kwszt8CNGaypPqGgNmD+C4PPiiu/B+gAGgX/BiHs4QVQc5BFSp?=
 =?us-ascii?Q?CvUy8ErlCk67Pr1jIYYTUlYZSdd1LQSpz2GqncH1Tvy6rvIi045U9uPxymIS?=
 =?us-ascii?Q?OnRbOIkwTMUycyIV8h5NZkP+B+OKHWMXOUN1uP8DdJVJN8OWlDzukMbFOpLV?=
 =?us-ascii?Q?WD9Ob+FgeXm5dmxaF6CrYJMVZNOI5xZv1kLBZSmwnJ0G66pKcPyBGyxyJOZS?=
 =?us-ascii?Q?v1JH+Z/0hyA2as+p1AjuAQVfGUkaFVXvp0IMZYMHomMC7V64whY7XFJh0l6a?=
 =?us-ascii?Q?rFMG3e9/UDnlLs7OYGgj+KehwdmatbjEotARk4t8V7nMjZg9Tyec2koSPmgA?=
 =?us-ascii?Q?lsgi5MFSWzj9lOd0pyfUQENC6V3Qsbg/XoD8R7g6USZaMfjI+blLTHapFvLd?=
 =?us-ascii?Q?YtVSOZ0LMI0gRuUorPm/Qw64mT0WY6GGz32674rd9DFy4RtvgRFoh7SPC+U9?=
 =?us-ascii?Q?fQ08l4Wz1/d10oV3vI6OVcMx9Hm0UWo5YHcAo2ztgnhT2lcHQOkHGCjjb/Eb?=
 =?us-ascii?Q?Q/Lscn+R7eZKfs4cqDPc1dC3yi7MHqEOGeeA5e8O+917snhd+huC3GpFgtud?=
 =?us-ascii?Q?tjFS8dPh4wTERfCJWH16/nqVBP4RCT5j3DgyXKj0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00906a6-9c26-4d0b-9741-08ddbfa598a5
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 11:33:30.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbNu0p+7rbo69BjNsOaLqRlYLX1Bdm/UM3TJa7ztkY16h4qora5pUKbvwcH5Z1cX44jIlbm7a3fUmLOV4cGV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872

On Wed, Jul 09, 2025 at 04:30:17PM +0200, Guillaume Nault wrote:
> The previous patch fixes a bug that prevented the creation of the
> default IPv6 multicast route (ff00::/8) for some GRE devices. Now let's
> extend the GRE IPv6 selftests to cover this case.
> 
> Also, rename check_ipv6_ll_addr() to check_ipv6_device_config() and
> adapt comments and script output to take into account the fact that
> we're not limitted to link-local address generation.

In case you have v2: s/limitted/limited/

> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

