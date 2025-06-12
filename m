Return-Path: <netdev+bounces-197109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7BAD7831
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C913A0561
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67C29AAEF;
	Thu, 12 Jun 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrraZOCI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1A299A82
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745551; cv=fail; b=C8iAoJVU1vXuyy891G5VBRCT0nbr6dSzNwDxxSSE1On8R4kfI8fGO1nOO+TKv/CzbthsSZEyw0IBXpH46pyKof91FGZl/jBOudypVLqXlnH2EmMKoyzeMFKNmE6uFlqvR4NPDYuxpWwuWRuk8OFTjChu+++kCOTPLe5X9VzJpS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745551; c=relaxed/simple;
	bh=d0EU/AlCF64VGUgORTb2SwFJ6TXgsicWj7A3FVw1upM=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WUHhAaacya2ChiZIClZdrdu5Sq7aHNmnwOevj1fzIQeRATMjAnlvSRe+jaCUXiA9tDm8wog0QgFiH0K3Ab4Afl1D/TuI6CJwLOuNKltEu7ydps+0wzQQlvO0ef8ueTPOHBhAMgSBLAEoLvTOullBSvdUQqleiqePfI08aNI8efE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrraZOCI; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAXcjRD0oOlf2UO5xtXWhlqGgroE72iixq4NwgTcjGAvVbcjogtwuSi5oUsUZT1w6OJB3ICpXBWTG6wwTVUfAbsbw2ymayIStxEaQacqEkWND/RzbqUq83mXLTFRlbZDyjCbbszUHf4BheW8dkGpDgWdwjjQFoZpsQqN4KmQAAzVbADHX7iRlv3Fn//s8Xrf8xH5F46506mROoql8BKJeBzZCyA7Z/2dmj5ht9uxcfJeM5bV62kCMSdYxpjAvdrifPx84kxyztP6BU9M8mNPMjmToqR4dEbE4wFLFLNIg0PcCrTY/htNd7W6eYRsLhk0AlpTfp2wuOEpTQv8LEDonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwivV10qq5lK+dlmQgjNTyes1HIxhk9v5tBhGmkwfoM=;
 b=Or3e813i9K4Du8jefE8f1WtTnP8HPuCcrUewUwCkBwBiJ2KvDD2eo5TSrN9YR2Nno6djZAQA12C+Noj8HqZKxpYYiGebJSiur+pNasxEjfYcujRTarJsUW6lHHDBqAqndWIBnq3o5IxRZkvXMFgFKZUbSmMZkIwtRb3y1k2r/xBliAXAGHBor0thfDOnZ84Z4TnwprDwhm/1zRM6LnGlZyJnSKBktiMKBI+i9MG7Bgzx/DZdPEFjZ26S5r6xIAwT1/A6nHX6rVx6CuPhiGJtwbVA9uvAvuFd3xu+KGWfWUC34CvJJ+Z12JbY9VDKuVdm34DCvTVKNKYrMhNKG65low==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwivV10qq5lK+dlmQgjNTyes1HIxhk9v5tBhGmkwfoM=;
 b=PrraZOCIR22R8AEqPNF2dnc0gU32EbBfcs3GCVPkGp2SxoCDnGxLZOJeorzJTecL+nFj+xRBio02qyM7y4rKoRDWy+JRIP4Qxxt+8wBpg+SS77Q9TGUi8qBNl6ZqD8QU8P15Fu+UoXNlWWPIAPWglHXOT9ICAAAqVA0Ffid7+qr1i93Pvmq+JW5UDetYQLFuagxzEIE948bmkt8Hn4rnm9AcA9RGnQCVrg8MwCNftqjfu9X17pAMAg4KLV9ebOvcNbStx8FVvnZj+dXQC+afMiugq8VIrvHorzDfZXePjb8xlBLKfGm4CDAQ7WqZ4KH0+pENHIfFTPI0L29ul3VTjw==
Received: from BL1P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::19)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 16:25:47 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::35) by BL1P223CA0014.outlook.office365.com
 (2603:10b6:208:2c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Thu,
 12 Jun 2025 16:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Thu, 12 Jun 2025 16:25:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Jun
 2025 09:25:28 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 12 Jun
 2025 09:25:23 -0700
References: <cover.1749499963.git.petrm@nvidia.com>
 <20250610055856.5ca1558a@kernel.org> <87wm9jeo3n.fsf@nvidia.com>
 <87o6uui6f7.fsf@nvidia.com> <20250611132320.53c5bebc@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>, Kuniyuki Iwashima
	<kuniyu@google.com>
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Date: Thu, 12 Jun 2025 14:02:47 +0200
In-Reply-To: <20250611132320.53c5bebc@kernel.org>
Message-ID: <87jz5hhqqe.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: ceaa7b7c-3a78-4a51-16a4-08dda9cdc97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hK1vnhdumzS89xvWOdVwtWIxiEXZiAF0GkMEIeDegjPhnx5PN9KXuQRTr35p?=
 =?us-ascii?Q?pZP+PGPgzddlIIchw50Hzggndfa3fgEv3fYQRkGGGGzwuQmrVbi7hmImPn8l?=
 =?us-ascii?Q?6HpqIRJI1cJrhN1CTKc+yFUSHk/D6YXZDM1UKUuJ5IfLDsvSvGObxTGdmIpQ?=
 =?us-ascii?Q?suafE5AXjoTLbRg91O9dxObwEpfFWz68Hi/U3tQenfToREM5lU1truPPqiH/?=
 =?us-ascii?Q?DudaHNGi017a81wUMeH1NWSu3B1UEK75+48KAZFrNAuBb24/j6kmFYKlXY1T?=
 =?us-ascii?Q?kZT/rrxylnYzoHdcusicLUPf7riK9upgGU/RxdAjMuULm1LCdozPFsDdAfHM?=
 =?us-ascii?Q?cU6gMevsdBbRKgDu7FqjplFDN2WoodXjPVzyQUGpEcp91hdkdTZTemW6BMru?=
 =?us-ascii?Q?RpCnO70f96DVwl68iO4+L3cZWCGEiwsSVYcMwEssbcmiU/n/bGMwUDdOogfO?=
 =?us-ascii?Q?azZiF7YEqAWDegHnnmdFcrbin9YYIPRUNXOe4q/BtBdW0zYeCkn6bWUYEdYL?=
 =?us-ascii?Q?9nIuBymrYhEaNvoRe9PsLdk4JlxPuSO8kDUURu5Wp4h8+ZCSff4yEz5GMsjt?=
 =?us-ascii?Q?ptL+RpzZQuIfWYMvEpXk4mqF7vYB3qCUDfytYHCrJbVKAmolR/2gG0zhW1u3?=
 =?us-ascii?Q?6vMxJlT1ukLjbk29I0jRxveqNSrNa/50Ppi5MdLgf6BrOhEna0mtigrGWYzg?=
 =?us-ascii?Q?KjiJj7jKoROzzBqNKXwyISRkDne/6L6/F9s0spXlasFLxA4WGKtSKVQJtlvE?=
 =?us-ascii?Q?YSicG47r4eFAf24pNB0TBVRCnBY3F5Ccn0xUPc+JTJS1kN17nNv9XJKnAFou?=
 =?us-ascii?Q?g/eln0lHalC/kGceGSCEYf0RLL5WkuNAq9wDbtyPSV/DTdMUA4/B02b/al2f?=
 =?us-ascii?Q?CxpFxrd9oPeJK6EYUVhcGtmdXyc3nTmOukVnYwsIpbXHbSgk07rIUhVDFsyb?=
 =?us-ascii?Q?iyytEx19ggYgpYvGErafiLRctrLPae38YRL6e98OHbX37Xh6GHpr8sGz605R?=
 =?us-ascii?Q?BDMedvUDWe+F4fAgFhGhpuaL/ZYC7eqb+MddxHqrBDgY6okeM2nyQyq7BAY8?=
 =?us-ascii?Q?AZXuIzGIp3Li1CALRA4qIAXFnTSMl7+dRvNNpc8rBibR9FEZWoMjghQTZ218?=
 =?us-ascii?Q?tDhqoTxe57cQOseO0fFDFfbWUMMLAfLe3Rt3LVNTwtkO0Pht43QyJY7srat+?=
 =?us-ascii?Q?3q88kAGNreWB1zWztQ+Rv7lLPnhGb1ZevRQsAem+SzlSDTc9QxQEoReHxt5M?=
 =?us-ascii?Q?4ZMBUJExek480oV/gFzXbws3EIn/ULXiwTrzbuIXHwX+SxBSaSp1E/GmMIOq?=
 =?us-ascii?Q?EN1VBUr277yzg712/FrlOlaAol9/jwHqOOTyhMsfLEJE4/USd8fQKtUiG2YE?=
 =?us-ascii?Q?Ihb2RJCnBoz5/pnmUG52x/fP2gIlP53F9SDAsIliFX6AzPjqCZLlTpPC2KXj?=
 =?us-ascii?Q?HDCtRhoWu3efvdMqWmVTWDyT4xmTKUpW8QkOVviZjMnUdW+4tgJfEKHKoZYb?=
 =?us-ascii?Q?Y5PqWJsrKzOgWNMZ7VUdAmd3MYKIAdT5x3xc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:25:46.8267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceaa7b7c-3a78-4a51-16a4-08dda9cdc97d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103


Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Jun 2025 17:30:15 +0200 Petr Machata wrote:
>> Could it actually have been caused by another test? The howto page
>> mentions that the CI is running the tests one at a time, so I don't
>> suppose that's a possibility.
>> 
>> I'll try to run a more fuller suite tomorrow and star at the code a bit
>> to see if I might be missing an error branch or something.
>
> We also hit a crash in ipv6 fcnal.sh, too. Looks like this is either a
> kmemleak false positive or possibly related to the rtnl changes in ipv6.
> Either way I it's not related to you changes, sorry about that! :(

No problem.

> [ 2900.792890] BUG: kernel NULL pointer dereference, address: 0000000000000108
> [ 2900.792961] #PF: supervisor read access in kernel mode
> [ 2900.793017] #PF: error_code(0x0000) - not-present page
> [ 2900.793053] PGD 8fd6067 P4D 8fd6067 PUD 6402067 PMD 0 
> [ 2900.793097] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 2900.793127] CPU: 0 UID: 0 PID: 15652 Comm: nettest Not tainted 6.15.0-virtme #1 PREEMPT(voluntary) 
> [ 2900.793200] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [ 2900.793245] RIP: 0010:ip6_pol_route+0x286/0x4a0
> [ 2900.793290] Code: 0c 24 0f 85 fb 01 00 00 09 ca 0f 88 2f 01 00 00 e8 cf 11 43 ff 83 cb 08 48 8d 7c 24 18 e8 32 7b ff ff 0f b7 cb ba ff ff ff ff <4c> 8b 80 08 01 00 00 48 89 c6 49 89 c7 49 8d b8 80 06 00 00 4c 89
> [ 2900.793422] RSP: 0018:ffffc08a0932f480 EFLAGS: 00010246
> [ 2900.793460] RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000008
> [ 2900.793521] RDX: 00000000ffffffff RSI: ffffc08a0932f740 RDI: ffff9adac8c8f1a8
> [ 2900.793580] RBP: ffff9adac87458c0 R08: 0000000000000000 R09: 0000000000000000
> [ 2900.793635] R10: 0000000000000000 R11: 0000000000000040 R12: ffff9adac82e362c
> [ 2900.793692] R13: ffff9adac82e3600 R14: 0000000000000080 R15: 0000000000000000
> [ 2900.793752] FS:  00007f3418913740(0000) GS:ffff9adb7373a000(0000) knlGS:0000000000000000
> [ 2900.793816] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2900.793864] CR2: 0000000000000108 CR3: 0000000008007004 CR4: 0000000000772ef0
> [ 2900.793920] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2900.793977] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2900.794031] PKRU: 55555554
> [ 2900.794050] Call Trace:
> [ 2900.794070]  <TASK>
> [ 2900.794090]  ? __pfx_ip6_pol_route_output+0x10/0x10
> [ 2900.794131]  fib6_rule_action+0xe3/0x310
> [ 2900.794166]  fib_rules_lookup+0x1b2/0x2b0
> [ 2900.794200]  ? __pfx_ip6_pol_route_output+0x10/0x10
> [ 2900.794241]  fib6_rule_lookup+0xa9/0x270
> [ 2900.794271]  ? __pfx_ip6_pol_route_output+0x10/0x10
> [ 2900.794310]  ip6_route_output_flags+0xab/0x180
> [ 2900.794353]  ip6_dst_lookup_tail.constprop.0+0x282/0x340
> [ 2900.794394]  ip6_dst_lookup_flow+0x46/0xc0
> [ 2900.794422]  vrf_xmit+0x100/0x4a0
> [ 2900.794459]  dev_hard_start_xmit+0x8d/0x1c0
>
> https://netdev-3.bots.linux.dev/vmksft-net/results/160541/vm-crash-thr0-0

Didn't see this issue either FWIW.

