Return-Path: <netdev+bounces-92741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0C8B8853
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 12:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F1280DD8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1C51C4C;
	Wed,  1 May 2024 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cAjEDd5d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907F21105
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714557784; cv=fail; b=g4I5r4OPT2AoHx3vecj5A7Z47FMDqluVeH4crwb6DJEM+9hdLz38fgHYhL7gBN3iRUqkTYzHDRngwFq0OEED3t+buZ763ai1dtRwAmciBlQbiEFPOZNy4o2/IkV5KiD0VHuL3ObEAzqyUWCUMsqGIMJPI8G6gK01ynZ5Hm5GfPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714557784; c=relaxed/simple;
	bh=xIYrGziL+qyOTqaBLAO2yctC17v55taX/a3YDliIOIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Di6DXLEOrjHLGZ03Tw06jJL7yQbYp6NUcSy2KGFyEcYqBchVqxJj4uGBwnt9h38FcCFs9Xq2E//bMiJ5sv0qpJBugU7Dltk+8YE9Xsy+Hh6BN+jAW3EI+GPZnw6rNvHnxa6wtsJzTCLd6mNQQtgUyv6WxPR8URDn33PT59CSUbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cAjEDd5d; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfxAu2toNnqfvuyH+JLcyfdMyl+ts8g42vmsXaV9lFHCT0wXkII9Gi5rd+0AaQNX0CkOus5quvE963C6XRs5fWi2Fgmm6w57Vep1YvRK29mmRj0/P72THU3qVQTGXb4+WUIi+yxd7nDYiSQt/8MIfwzJMeD3NYU+M/fdS2DZSOUtF/mk9Qmf+Bl78jK0uUxVgwdj28J0/uyf5IwQ01Yb6KwpILoqe4MtwNvJT7sGG6gKWHoZWBFBmR/q8rbWiJJJ2gopy6YR0T1e84pOtu2nGwVWy2K0fiGYbmnhXARyxMBQJcX3I1EKmGMJduTQnqQj74Q6xXEA61cSO7tTPRIa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDNP2WCPFDMHbsvO61Et9sZbhNfdTWTCPilFG+UWFH4=;
 b=O3Pgc84zqyOW8QnwGP+WJ5puNwVs+ZV0Ewa9mJdaALqWs0w0su5Yh4FDnzKure64GO94Yo7yUlgGFwAXF4MgmLnxd/z7tRiRbQ5qKE5nLRiuOx1zOpFHumv/tablraGGeFCwSCwDexvaOiuOiJ2d87/hALhY4mrG/fH5NpAcPjy33P1V5tquZBreQGxRhJpkTMmycNAff7DRvysvqoDtEDJecC8zp94RBz/IjqSQuv2Cf0DfEwhnEh1r8HcjHer/AxY78id5btNQ4dMPTb/DKaYcbMtJFZbeo9fOTv8JCzW92+vs39Hsy2yu/mUK+mpj4fr8GA/OMS4GlFbbh8RmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDNP2WCPFDMHbsvO61Et9sZbhNfdTWTCPilFG+UWFH4=;
 b=cAjEDd5dhjiCVeBbAJn0/iU9jaaUxvS8nDZC32gx+cIqWu5pyIWxKKYI0hIN42Mdqv/oTM8vitgq0/mM1mU5mf3BA8VdX1gKSGCax0w8zpBIXLCj0vZBajvEcZQl2xfv9urn67aKv2Y770WqGu/gWLA0WuxkZ2v+EeBYfo8HG4ojeTAg+qBJeKQOVqBdOaY7brNZmVzzlyrU3dOfi7yFuTRGMrMOWnA/RMKm7nuUavvFYIs0x8RNITdZBTm2yFq+KiakGesw9sJF2BBO2PMP7pF2gDLlABxhD/ZCghOcdJ8xo2vb3kQwqQN6gkjsfA8qgP921smX1ojSkVk0mrUcZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 10:02:59 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 10:02:59 +0000
Date: Wed, 1 May 2024 13:02:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Amit Cohen <amcohen@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Benc <jbenc@redhat.com>, Breno Leitao <leitao@debian.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
Message-ID: <ZjITTeK_BhGbGGjp@shredder>
References: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To IA1PR12MB6163.namprd12.prod.outlook.com
 (2603:10b6:208:3e9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 135bc16e-2aeb-4dcf-0aa5-08dc69c5e0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxynaZiWx5s6oFhLU3IYaKjdQrFp6HcU+7MQjCO1pNhQYWUlgSWPHvHglQZe?=
 =?us-ascii?Q?v0D9Z/R3OFAQgb6smMKPM+yF/KKyjpc6uENJyCcUA553zNvJVEej3JR/jN7M?=
 =?us-ascii?Q?lWJlxrYvoly6weK79iWyclIFP/KEGCGyaIRLe/J0Lk9W3Q8fWi7v1aydEsq7?=
 =?us-ascii?Q?8HM3VUA4uLbXCZMhQYEj6V/g70KA/EmgKN+GLOkCtIIn27ncJESo7eR5lAoM?=
 =?us-ascii?Q?9kbnq+PLP34LjQCE/kBD9VdGKX0PxV3yrjthchb/FNhTn4422fEWqnGY3a3O?=
 =?us-ascii?Q?0VLapJVxYgBuxIm/cTzzFfcHVCDGIjMUIso2sI+gVvt4XQcxIupYgdkN5qyl?=
 =?us-ascii?Q?+D2Yd/IxXLJZpC9jwrZUVVZUaeFTCfurTXGfRJRng7d1IQv6Iw1/YFpb+6nr?=
 =?us-ascii?Q?Kv9+8XrzsZgFrZ+qb1qZX4PzbZSfoofNqXq1UXwIhNfkFRfb/lrnnMzOetkD?=
 =?us-ascii?Q?yvJiafqToOr8usgtkkkVaNFeLrjP4oE/dTyAsvG5a4ljTPSny4ZsSJKNcvh+?=
 =?us-ascii?Q?CZkhZF70n9GhozhqhpIgHr0JR8fv7orvYqIjQI7jaqtXPBNggr5sauiamxMZ?=
 =?us-ascii?Q?jPeCZFHttblhQr9S9+bOP2chjkAp2ECEfu5Jaw6K5zUYYiwwSPAFnnPEpIv/?=
 =?us-ascii?Q?WmaDZXtEj6qsK+DpKYAPD3LIJEw/DFnJWHUz7vn3kSfKSlLAXvG0wsaSts/A?=
 =?us-ascii?Q?cDbc7KrTeUQXrRtN4/ZLMQWVF9Hrs5XjAUIZCOB18fwcZ7hrdw77I4URJ+Cz?=
 =?us-ascii?Q?rgqYznTN98uDCiKLPIs1op6e8NVzgJ+Ms1TW6lIER3Qkk74ipsuahCXksVnJ?=
 =?us-ascii?Q?03BUPBDMIOFBG+ypSmrqCXnLY60dR6249qfKjQV/AZb0fC4HMkl9A/PgvqPO?=
 =?us-ascii?Q?U/AqGm87pj0JM56auUiJp4tdHcVvd36vTyOsXP8sd0DQeM06jygrNgXWuhxO?=
 =?us-ascii?Q?9gJpxlvA8UH7a202Q3eUpU2a4RJUwo5ZXMgffPlk6eSrTFPT4xaPV+mwBfI7?=
 =?us-ascii?Q?LdXTECtPbN/ih1fcuo+CwcDkE0dq8OGjp/lGHyuKq+TrO986jqTNdDOSlPJz?=
 =?us-ascii?Q?eJ+e0gxePviocRm+3QBTmOlaHxXhAQj/1q16EXHT0UJhTxbz8QMoXYTpItzd?=
 =?us-ascii?Q?fypzngggYGTRkn/npkrw8ErKJC7SlNUxMglSoDjkx8oSResKGFTqR6kkqY58?=
 =?us-ascii?Q?UqiWK+hHKUU/P33m97AvmqWJxVIsm9YSEaCzhiJVLFYHa+ErmFA/O5qmWg+z?=
 =?us-ascii?Q?+g0Jvdfy6ru4bN6iCet79FqldBJQ3N0EtbzOZe7s0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o9Twpg9Z85Gi/wgWw4TkNSb9Oof/oR3NxVApd6xyyD2SVuwRbIyf2JCI+7Li?=
 =?us-ascii?Q?7PlX1Ialh7AcwyGKVhp6Kqmt8umu0oI3T7u4lle8Z1Q/M4UzUrSOqzmMsdLl?=
 =?us-ascii?Q?vekM/iCT7sJflw83wQl0XSgZUkjgxjMLVp6fbV4MtjtcIlo19qwPosq4aIk0?=
 =?us-ascii?Q?x2S4gL/yVwrK5OEiab6fEQnz4dwL30D7gn5LlQzLEo6gzne7nEuL6iBYjUgy?=
 =?us-ascii?Q?57YPctNwTqoSUsif3V3NlVLVLsBhoba3n2E7+G9enRpT+B489JnJ0jrw9sHv?=
 =?us-ascii?Q?TMSpbtDHQZnkKkoAA5RJBLQ/Ts5xyR4A5GyPQEw9LixWQXJIhG1puC7D1Bdo?=
 =?us-ascii?Q?1lsP1OS8pFPKkg9zAuDIobjSAB9/nN9ZKr2GM7pvubACMcPF7ygLKFNuSZDC?=
 =?us-ascii?Q?2453mJnaPt4zLy21j8wBjw+GH/vZ3U/0vgtxvhsM/5TBNEnwuWjwlTOh1T1P?=
 =?us-ascii?Q?p7oNugZFdJH73bW9zEaTpp5W9E82+kssr3rp6pGZ3OoAiNIhA4LcIH+kuMp1?=
 =?us-ascii?Q?fo+OokmQYXU6e1b8ygTTzBdnIjcboCY9nMGGh0aicw/1+B16C8fZAoRKR8AV?=
 =?us-ascii?Q?xtawxRoThHtyP8eagKHjNyZ5tCBZT3/UZX6UOLnxuZuCxCDCOeRM6EOR2i/a?=
 =?us-ascii?Q?vF7UdNoPbqNODLLETxV3Mdwcl2dVhzz8fbQo1GDfX19IXGnXVt4mR/WrZU8g?=
 =?us-ascii?Q?Ne/89DPFXcSYfYoNKUF3iv+IuY72HhL/sbGIbUH+yS84Xh+oCFloDeEnN92E?=
 =?us-ascii?Q?cIXXj2zXm2WBPPuKPU2vArf2GQVWj8DkhQjYgck8xEfY2ej8CLUkZYz71ZbO?=
 =?us-ascii?Q?Wdvno7DnazvcQZ+C++cXvKEJqs9N+Fs8tpr9Zea5YyXEgMOpe54m7IMyhv7O?=
 =?us-ascii?Q?/mhdtmj0Z8MPzVP/zXbKtPKBJ9mTAT4o3u4+IfwNsy8fKiljbNXFjONDgNJA?=
 =?us-ascii?Q?FOL5j18qdEHHxZf+LJaGyMph+z/pxGBzLQMQBNZQqtYT0UjGcZ2QdTOJbz/p?=
 =?us-ascii?Q?N2+LOZWxfkk9nwskswwoNVvTMHQH36dQHBi7ToVMXIQUth1/XPOuXX6YFC2O?=
 =?us-ascii?Q?V0slpVhEjAyD+sZwyjZjjia9EUUU5439seSsG7PANf5ESuBOxD30HIapBjHQ?=
 =?us-ascii?Q?qduCyhioa4yQnS/UzGEEzf+tKeic7VVS6ErdIJxrDXcbOVgze9GnpieuKM70?=
 =?us-ascii?Q?jICUECRT7AlLRAP+xJ2AdKIGoI9Y+dJyGBqajPLHcHMo4RySLWwFlz8tnjTm?=
 =?us-ascii?Q?1Kl5IMlcPLk5flmDtIp35wEcgEGFJBXz5NS9PW7vBq0WY4lH6YblexKFZuze?=
 =?us-ascii?Q?R/NMPZ4RemOLUigBikWSiGf1+DnmQb7bYgLzpJF06Aprvj9ubr2Zu07DMPfN?=
 =?us-ascii?Q?9cMzp7o3dCOPKSDIaMdcmKUV8toHFgrUAcDsQ2W5yzhqra4RzpM2Wv/ku8E6?=
 =?us-ascii?Q?3kIEDokkGqr9jT3jiyAbTx0WdWqW52RwDroJhzDBYGj7fZWZoWByONhzaZt3?=
 =?us-ascii?Q?NHC4Dwzu3SJpIVyuyvdahoVz9BoTkzvm4ua3e9HgR9CkwYla/32+ItOIzIKy?=
 =?us-ascii?Q?Bh07sIjMsraMBjagb4AD491c+uM/1UI8aa4hEfDr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135bc16e-2aeb-4dcf-0aa5-08dc69c5e0ba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 10:02:59.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2jW1O47c/sSNq8Pl/XnWMyN/1aXdAlWKxn9UsasVZc+IRJPrGJUr+hpMr1qPTskWsyDndPF/cOIl0foK35ikQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

On Tue, Apr 30, 2024 at 06:50:13PM +0200, Guillaume Nault wrote:
> Ensure the inner IP header is part of skb's linear data before reading
> its ECN bits. Otherwise we might read garbage.
> One symptom is the system erroneously logging errors like
> "vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=xxxx".
> 
> Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
> commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
> geneve_rx()") for example). So let's reuse the same code structure for
> consistency. Maybe we'll can add a common helper in the future.
> 
> Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

