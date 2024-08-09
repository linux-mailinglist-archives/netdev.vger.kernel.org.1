Return-Path: <netdev+bounces-117150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865C994CE15
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF61C2101C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B1C197549;
	Fri,  9 Aug 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dh+vIwwY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114C19412D
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197482; cv=fail; b=lAhTAyz0BNwh0b1Q0dWXSMaDS7xwVfy9sLn5zEg/gKltgWruZ5M2Tgx47nVzGtB7/GNNvs0L82VhhIdCS6h9BDwPxh5JzOwB1lC8cxjO3JIH6oP9eEwOAiD7XdjBqG/1PIUzoKCN5jChZDK7i6pEfREQAnBAtzuxOl9Nc4FtpcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197482; c=relaxed/simple;
	bh=i6Ky/yQWFTgiPIztDIJ3lsS1EJIi5gDoedsvI9WoI1E=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oF0+gi/9ZaENEMcAaehoL5e3aDHcp7DMOI2tXVkjFiAL9CtiaNPpqvkABSPlneLSYdyH2f9Pcx9BHPWXkjaBgltbpDYM1a6L+Yej5PKrIbwKpL4TqQi4nH9iNejc9a88xedmXX+pbbFdCKWXvMlEwvtOtixpr7nxavd28+osj/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dh+vIwwY; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjWnSm1rtfiwRk85rtLVbMO5YxFS0cWT+NlEJx00SsEg6lBL/73E0cpg2P8XFsuu2/m46/q+m+vdtLmuyhVIQi+75diTS8+dR6IPjG9kfew/qbznHrsRr7JZ3CYng26wVQfMgZjpEla6MN8R5S34OayLZl/MeZzF0rl67pWEKhWcM+o6XYhPah02YfXv5RVQlNtAZWwIlYaHqhUuBW4c5fOXkXQdWdoxiSBWoZCLcAonesJkEOD3VV2lCZObZgeIRfUG4cttlj8hyu9K3WL5Mbz/TW70onBFocflMQ3JgRywld+CUDjIfeV2N0huOVNoO4/TMH2Lki5ej0nJzI4YKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC17Ak4BSWWejNabj5YkrxHZiBhrNcIv+t9BRCIZhFk=;
 b=n6gGSlKZXh0qCeY0wpHr71HIhcuIexa7T3VWEJi1Z0NDbRI5uMnPEVWWyYs8+SV2DwyBLjkFJcIeuCXjZgvBg8pqkpA63iVnTmsYCaM/N2XdoyXdG64Jz/faTHLi4GANxZgakP34vCX/MvJ0J1bZNvcH6/jk5h9rFx4io5swwn8HbTzyaLQA5K0krj6t8NFUAZF/uV4+So+4vMAHB7LqlMKul93thtvN49rhGXXpe5EZZWY7cV7IdwDQD4LeQDZZj00D1hcMi0Ynw73FqT1IkOjp29o3UbITWMhUdX+QYhBDwgRm8mibOhY+GC5LKQNlHmpUi/PJQYiRckDkszzZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC17Ak4BSWWejNabj5YkrxHZiBhrNcIv+t9BRCIZhFk=;
 b=Dh+vIwwYLARV9EQeFUxIfxLViQL7IqHJ+60vyPzLb/1HjH+P20Y0ya+x6rVHD68zKOyDGY8FJ7XuLjuSkVQzMGbfuwv6QGK9IOF/JVJXjQx8GwU6neWuvCh2PYDDDO1j8xUFinQvbzBeht/O/MYfw9lZWYma1GYxs96pwNA1FxgR5OcNTMamA9rL1JtkjHP6+4oP6L3ZVxkka/JxZANUlPjgjqjNA+BcTfxDS70wrLwX/6eJ/gz6w+e60VvKyuWT0X5ZkiFFFX9Vzu+/jaGkC3hxE51SsqRhm8Zc7IW2Dfvmo9vDVQCFskCS6wvPcmHGlIJpD7zuEZNgaATDjuPIog==
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 09:57:56 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::f6) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Fri, 9 Aug 2024 09:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 09:57:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:57:42 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 02:57:37 -0700
References: <cover.1723036486.git.petrm@nvidia.com>
 <20240808062847.4eb13f28@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
	<dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 0/6] net: nexthop: Increase weight to u16
Date: Fri, 9 Aug 2024 11:48:09 +0200
In-Reply-To: <20240808062847.4eb13f28@kernel.org>
Message-ID: <87o762m31v.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW6PR12MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0947a93c-ba33-4319-0ece-08dcb859bdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SEmR6V29JWiKTtja/Rp4LwEEwF/bU3denKttVgKNy304O6PAe8vdSdEWMzEL?=
 =?us-ascii?Q?YkBGHf6a8WEjA36lh1PyzCnaRKNx53A665JB6AuBod7MRRSAIBUuguHuHLjD?=
 =?us-ascii?Q?qOX0OKOc8mVKQrbnwXjmmcJJ5ZC5lUNsOZW5Y1T/LsrBkp5jSl7d+RanLGY6?=
 =?us-ascii?Q?ZRzUsNytxe4Y/qVdtEliFAGJpKR+uFkUjUHkAhBGkUusRM5t0FwpP8zyejRR?=
 =?us-ascii?Q?7Cq+iPK6SxQ+FJmgCeWiq9h31FvLcCMhF4+xXLVOhZ3Lh5AZbn4qlDjHI9wU?=
 =?us-ascii?Q?6RTnQVg3U0YM636FApHm8m4Y6GBqVDmWVZxoYFeccCcEzrLvisfM2BxvP8ME?=
 =?us-ascii?Q?lpAFmK9OVYFSoit62QVX4UrE2vFQu/fdlVEc7PmoovwGNZuR9PBafQbIBMUm?=
 =?us-ascii?Q?xWmEnC0o640sK7Vpk/NDd6K5enJLvWxFlYiVk6NnyUdxEetvS3cO2Ax0+Mpy?=
 =?us-ascii?Q?SE1mxZtsppm3/oEHAosTNzxV/1xPDHDZBj+l5yHOeC3cCJA3YpFraziS70tx?=
 =?us-ascii?Q?OqmSlZ68RI8FpCrtKwS9DSFDM/Mpc0u1f0tR3AmJwpweLYrT7Lp5B8t4/Pv3?=
 =?us-ascii?Q?iS1AGbzVIa9+BT7H/8WkMGj4vDZXsxnVsWhc3duPCnWX8xvCZsESx1PfRfSO?=
 =?us-ascii?Q?JSXWT/z+83qnzY1lqogvQ+AFjlhRKGwfD66hxMm4dnbNeQbW1ihqunJZGUJK?=
 =?us-ascii?Q?xtZiN60snWEuggks7DjAU7Sc5clnXKJTJvpLpzzT0LaQ2ft2SWOsm3PTbTOW?=
 =?us-ascii?Q?xz1zA6gcqdVgm2U3QJQC65IdDqiX4QFPELGXonRMOmmV/rFhS1z6VUyjh4qY?=
 =?us-ascii?Q?7Jai8y515j9+ImYt4mo/iRuSPX5b8xghPzL+g2kmPaXYCRbcuaLzFm1Qo36A?=
 =?us-ascii?Q?KHS+9O3BXFBvq5KQGtrV6sLu7LrqDXyRJC3IZGNQUYRN1NK5qeDY1fAzKTpT?=
 =?us-ascii?Q?bhIJr+K5J5YpAQC6a4z0kaddXeYl0ivqtfjKEmkdsLSvVysjNcT/zzUGB6ye?=
 =?us-ascii?Q?GH6AhYrkqldXAVQG3gRPyFGmQ5U/3juo9HgPSoc/yyCtgQFSbtsV59vF3NYh?=
 =?us-ascii?Q?JO/TDRAv0UHM7t1sAmChOj+kAzDbzQ9TGPUtAemjry/I1ry1Dfbr+NXhJ7NC?=
 =?us-ascii?Q?PTqoNsFbIA3QR/qoBiUpI+0cmjXkvihL1g4bFe+N9Ru4F0tsTHYOxoZ9wwYQ?=
 =?us-ascii?Q?VqoQgbOK7FcauAif7iJzJ3YOdzbyM+SjStgL52E5tEjT7zTRGIV69gBdyhTX?=
 =?us-ascii?Q?4rVVURV9TbSON3U2gB5nKIUvnTfVSJTKySfgHwv0w7T6Bkxe9GVNUZKvFf8g?=
 =?us-ascii?Q?ryv8FL86nUpLhMkNh8s7tUzdrl9pq56k2Q8Vm+BhN0Pwj50W8Cruc9K4LZf3?=
 =?us-ascii?Q?J5zB0KsiE606FoaiXyoE1wQ+DMj7/XN6h2PwE29VJ/OyIR3DE6LrHLHKXGTR?=
 =?us-ascii?Q?4OM9TFHdkTEStGaSggNsuaH5J5sBAzzP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:57:55.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0947a93c-ba33-4319-0ece-08dcb859bdff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 7 Aug 2024 16:13:45 +0200 Petr Machata wrote:
>> In CLOS networks, as link failures occur at various points in the network,
>> ECMP weights of the involved nodes are adjusted to compensate. With high
>> fan-out of the involved nodes, and overall high number of nodes,
>> a (non-)ECMP weight ratio that we would like to configure does not fit into
>> 8 bits. Instead of, say, 255:254, we might like to configure something like
>> 1000:999. For these deployments, the 8-bit weight may not be enough.
>> 
>> To that end, in this patchset increase the next hop weight from u8 to u16.
>> 
>> Patch #1 adds a flag that indicates whether the reserved fields are zeroed.
>> This is a follow-up to a new fix merged in commit 6d745cd0e972 ("net:
>> nexthop: Initialize all fields in dumped nexthops"). The theory behind this
>> patch is that there is a strict ordering between the fields actually being
>> zeroed, the kernel declaring that they are, and the kernel repurposing the
>> fields. Thus clients can use the flag to tell if it is safe to interpret
>> the reserved fields in any way.
>> 
>> Patch #2 contains the substantial code and the commit message covers the
>> details of the changes.
>> 
>> Patches #3 to #6 add selftests.
>
> I did update iproute2 to the branch you sent me last time, but tests
> are not happy:
>
> # IPv6 groups functional
> # ----------------------
> # TEST: Create nexthop group with single nexthop                      [ OK ]
> # TEST: Get nexthop group by id                                       [ OK ]
> # TEST: Delete nexthop group by id                                    [ OK ]
> # TEST: Nexthop group with multiple nexthops                          [ OK ]
> # TEST: Nexthop group updated when entry is deleted                   [ OK ]
> # TEST: Nexthop group with weighted nexthops                          [ OK ]
> # TEST: Weighted nexthop group updated when entry is deleted          [ OK ]
> # TEST: Nexthops in groups removed on admin down                      [ OK ]
> # TEST: Multiple groups with same nexthop                             [ OK ]
> # TEST: Nexthops in group removed on admin down - mixed group         [ OK ]
> # TEST: Nexthop group can not have a group as an entry                [ OK ]
> # TEST: Nexthop group with a blackhole entry                          [ OK ]
> # TEST: Nexthop group can not have a blackhole and another nexthop    [ OK ]
> # TEST: Nexthop group replace refcounts                               [ OK ]
> #       WARNING: Unexpected route entry
> # TEST: 16-bit weights                                                [FAIL]
> # 
> # IPv6 resilient groups functional
> # --------------------------------
> # TEST: Nexthop group updated when entry is deleted                   [ OK ]
> # TEST: Nexthop buckets updated when entry is deleted                 [ OK ]
> # TEST: Nexthop group updated after replace                           [ OK ]
> # TEST: Nexthop buckets updated after replace                         [ OK ]
> # TEST: Nexthop group updated when entry is deleted - nECMP           [ OK ]
> # TEST: Nexthop buckets updated when entry is deleted - nECMP         [ OK ]
> # TEST: Nexthop group updated after replace - nECMP                   [ OK ]
> # TEST: Nexthop buckets updated after replace - nECMP                 [ OK ]
> #       WARNING: Unexpected route entry
> # TEST: 16-bit weights                                                [FAIL]
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/718641/2-fib-nexthops-sh/stdout

This failure mode is consistent with non-updated iproute2. I only pushed
to the iproute2 repository after having sent the kernel patches, so I
think you or your automation have picked up the old version. Can you try
again, please? I retested on my end and it still works.

