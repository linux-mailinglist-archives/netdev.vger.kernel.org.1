Return-Path: <netdev+bounces-157213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DDA096E6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7C13A10EA
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E191212B35;
	Fri, 10 Jan 2025 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XbNJepfY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094021127A
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525623; cv=fail; b=IyGZkWcEY5uBeA2b2yvHocpMoJ3bWVe496aW7vBYl0e9O67v9v5QYTx5vOBZlhokdMsfwccq8VMrhttgwR2GYncA0Hb3bVLqRcZlkDDYbEENkieXaPDlvFXpm+rAhPfzpdiu+qzuTRULzLEKyns+Nj2DnouiGqFO0me9Skeskas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525623; c=relaxed/simple;
	bh=W+9MfG5cC2wY+qt+LSJuzESST/8nnhtg3ghvJ0191ew=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b9Ifv1e9A+gQ6Mfx6jq2clX7ou31JJVkHK+Erj+gKDiIU6ZQi5QBC/n4FVQcbVGiLYgWaUL+qjFc4ldxgFl4TYFUcVXCpn/vZ0WdZ9iIsp2B8IPctzZ0Ml7YdxuDzVR6ThqQmxdQ3tov0uv3BL8kBUUU1Z3j8wvVvkAp3BwS2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XbNJepfY; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvQislua5YpX6lz4WFDRalkk5rNAJOeC53s0zqw7e0osMASBl9/3jWJb8Lw4i0A1c7R88uezS1nyyuIe/Mcrd4mj6G7kSiGO1Tw5B+7Dr4vVKyy3z4OgE6i7V5pjHewnJObyFzTxK3ukFwUmNXE79oxYRjixQ/TZ1VbblhgBav2cAa8ts+oGYH5hBMPboEUpXHye4d1QX+hATyFW4MbSuTlAtx8DbJiIAQV0wEJOX1H8m+KnRz9CFl7mct4fCrxxAyEGqONb91hOX1veZFGaX2oX9EcQlGPv3+wG+BWo5UCE9WsRxL5+jyWnqGgN7aNnnZYULbXrRVwJGPcj56hTfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GaLvt6dUJ5pPpfRgbshimmOlZfL9XMmEg6GC6bw1Jw=;
 b=MC2W8a3P9eLP2cA3/WVtl8gDq1+c3Eae+FJgZHTrX17vwMbTKhl4z25kPX3YNj9/hxfkL2/pnDTUUQL1mxXYV6EaQf+XGQ/VVSX5nfmPlZRXoVGzFV8Nl6xTuIj2/+JBLZSeC0uCEB1OwCyp46OIPcZN6T6B7RZvgz9mY7IlTuEdItoLr5h3M7rxAV7mQbGGUB6GQaB7VEMTfTBiDZsogltg7U3SEjF3RlbiZ9aTLJX58D1MGOYheMLIHv4xUu6tZm39jeMiiSj2DgYUfOMSO3jdKxY3PQb/RKs8Q5M5PnFGMZpL5IuIK+YGIqYgo0xAysZaSpYADpipR8CjKRS12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GaLvt6dUJ5pPpfRgbshimmOlZfL9XMmEg6GC6bw1Jw=;
 b=XbNJepfYZXlDKQKk0/HhZ62SXLh/lVNKHcNud+mgKglDs0Yfj7fTH6j6wlr9EX1pf6qfFiR1WhgrFSE/sf1XwYuMwBNp3kVpz6QrA6rI5ZiUiXOd7LEWF8zFf4xI+KtEgDNXIoqAcEnd31DUK6ug4xK/E3/3I3PZAcMcXkimT6ONe7sjyVjnlNz4gb+t8T48i3fjVv355UPt6WTuBi5n6rnrvGfaafOqwGkMMfFc9vb2+2DpkBwzesp640iYRRNEUEjZaqFUouUILFR98ynaAtbEv7IIr9fIfS72xR5MgNlFXXdc75zltNpvtzXXKJHz8SU7QeEbGq1chbjhTEfbWg==
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 16:13:36 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:b4:cafe::1b) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Fri,
 10 Jan 2025 16:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 16:13:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 08:13:21 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 08:13:17 -0800
References: <20250110153546.41344-1-jhs@mojatatu.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
CC: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <xiyou.wangcong@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<petrm@mellanox.com>, <security@kernel.org>
Subject: Re: [PATCH net 1/1] net: sched: fix ets qdisc OOB Indexing
Date: Fri, 10 Jan 2025 16:48:28 +0100
In-Reply-To: <20250110153546.41344-1-jhs@mojatatu.com>
Message-ID: <87ikqmprza.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: 5543498a-c370-4c1a-354e-08dd3191bc9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KX0lK5Dyei/kjKk53lJjABhuP6KEMXmzTELHb7+yqhZ6S9O769mF2rKXvTPP?=
 =?us-ascii?Q?0rmqtmr189gs0h1r3DGFQIo7sJzOLoDtkiYGcuixEaP8f3kh+H6FieXJPILv?=
 =?us-ascii?Q?sQpe0kr/8xZ3IvTaSNjMh7kAoxsFq4ywaFUFNSzHIQuF/lKv5qRZ96ycsXUm?=
 =?us-ascii?Q?dTuc2davBO5gGsdMbGc6mRM5BnnMq8KNco11yZlQAURl/GkpYurP1R9+8bcR?=
 =?us-ascii?Q?a12zom8Vq0ArgET+p4bIOO33GuIBh0xIGztnRyL1bb7GQ5RdpZ+mk3SbuopI?=
 =?us-ascii?Q?ydQCfkYUghI8XoeFz/1Sp76pUWnIO8iK1wnKI7Ol22bQVQd90pEH8W4A5kJq?=
 =?us-ascii?Q?pD62HdSjRYOBUExTPMsMwqmAnVr7mxvZlcD2Go7RJdNTb3ehoHZshoSB2Q+h?=
 =?us-ascii?Q?gIGn9j6Jc7FAhs8EqICi8MVw5ZQ0q1pPYQleEIFJj1W/po8aOwVWivJelW/i?=
 =?us-ascii?Q?BmFOUp96Cf41AN7WAohe0KOn/bCaysnTdbDJvy6M78D6CEfYrWrikzDra+aI?=
 =?us-ascii?Q?jordWxWBsESSyTjHvJoxHNxzNb3o/J3TumxkfSaS/8Pny5bGaPKzu5/t9L22?=
 =?us-ascii?Q?w2kaGXXAl6xwBxF2WnNTec1P/iMQoSRDV5+8sZY2zW4RLhtkhAaHN+KLd/Ma?=
 =?us-ascii?Q?Jt+Y+QI0PEY9RVb6BKtF7K/DX64igvqQPQ6DSo10gtzHR5REJwwpWCVnpCyE?=
 =?us-ascii?Q?wJ/455tY1INEPdqwksmFuhw4mC4tvVbC/GA/FCFpHRFjfCbO5YWjNPsMXYe0?=
 =?us-ascii?Q?TD8FxOtj/ts8jVOAGD3zc0IFL2MxJ13158wsv2ctmg6uft1l1sueP/xMSFJJ?=
 =?us-ascii?Q?ic93XF2HD0s67WIcVbhPXZ2pgGclF7UjA1vW6Qdk35JznA7KoUHhIy+gJDCW?=
 =?us-ascii?Q?H48Jxf0BowjezgBniKS4c7jps3iYtPsM5nfOdKUYpkG9CFQymlSwAvqTLD4a?=
 =?us-ascii?Q?W96lyktUspn9Hp5yhvxgJt7UvXSo07tuYqKc12GAGAkTmavRBw8Zopbqo5yT?=
 =?us-ascii?Q?x+oUnDTyuKKM+DrqgVXPqtOzxugdY0Go99gTxjDFULqb+m+COI61wdXA77Fn?=
 =?us-ascii?Q?IhUFEBlU3ZAUw2SVBrTfjQI+sWoRzSM5h0eR33LrX1qPOq+uFPR8W4ORY6Vj?=
 =?us-ascii?Q?q2mIrZc8UodTZyuQVb3se3k91lY1cJCgxp/o4Pi8l0nYUZe9tnBpUnyOkLDy?=
 =?us-ascii?Q?kU7tFOMAWd2W2yxAB/n/FxmM+fVK3RLNEBfcxU7F1hlMnlcYxT5HMnP8VqGG?=
 =?us-ascii?Q?dofiyoKIDzhpP21imEtk7U7Sry70Qs7U4FFeVK+vlzHv63ybYkyk8XVKdn9r?=
 =?us-ascii?Q?ofUuss2zH6ffQfUDgwHg6cVIH7Hy3nsUsPG4pHw6A2TsPN5IKNHFv5Zs5Q1Y?=
 =?us-ascii?Q?vD9v918oHRSeORW3wGYD3nFL38dsY3k4f+3TJc/cgOtSAaLBkgqj97Y/Stoq?=
 =?us-ascii?Q?HzzYP96jX7g5OaRNJa78hIXduKqDFQA3ygJtyZMbqk9tvlpqiDYUqOtqNPvM?=
 =?us-ascii?Q?UIxV0cZwywrSelw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:13:35.9641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5543498a-c370-4c1a-354e-08dd3191bc9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070


Jamal Hadi Salim <jhs@mojatatu.com> writes:

> Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> 0. The overflow may cause local privilege escalation.
>
>  [   18.852298] ------------[ cut here ]------------
>  [   18.853271] UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:93:20
>  [   18.853743] index 18446744073709551615 is out of range for type 'ets_class [16]'
>  [   18.854254] CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirty #17
>  [   18.854821] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
>  [   18.856532] Call Trace:
>  [   18.857441]  <TASK>
>  [   18.858227]  dump_stack_lvl+0xc2/0xf0
>  [   18.859607]  dump_stack+0x10/0x20
>  [   18.860908]  __ubsan_handle_out_of_bounds+0xa7/0xf0
>  [   18.864022]  ets_class_change+0x3d6/0x3f0
>  [   18.864322]  tc_ctl_tclass+0x251/0x910
>  [   18.864587]  ? lock_acquire+0x5e/0x140
>  [   18.865113]  ? __mutex_lock+0x9c/0xe70
>  [   18.866009]  ? __mutex_lock+0xa34/0xe70
>  [   18.866401]  rtnetlink_rcv_msg+0x170/0x6f0
>  [   18.866806]  ? __lock_acquire+0x578/0xc10
>  [   18.867184]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
>  [   18.867503]  netlink_rcv_skb+0x59/0x110
>  [   18.867776]  rtnetlink_rcv+0x15/0x30
>  [   18.868159]  netlink_unicast+0x1c3/0x2b0
>  [   18.868440]  netlink_sendmsg+0x239/0x4b0
>  [   18.868721]  ____sys_sendmsg+0x3e2/0x410
>  [   18.869012]  ___sys_sendmsg+0x88/0xe0
>  [   18.869276]  ? rseq_ip_fixup+0x198/0x260
>  [   18.869563]  ? rseq_update_cpu_node_id+0x10a/0x190
>  [   18.869900]  ? trace_hardirqs_off+0x5a/0xd0
>  [   18.870196]  ? syscall_exit_to_user_mode+0xcc/0x220
>  [   18.870547]  ? do_syscall_64+0x93/0x150
>  [   18.870821]  ? __memcg_slab_free_hook+0x69/0x290
>  [   18.871157]  __sys_sendmsg+0x69/0xd0
>  [   18.871416]  __x64_sys_sendmsg+0x1d/0x30
>  [   18.871699]  x64_sys_call+0x9e2/0x2670
>  [   18.871979]  do_syscall_64+0x87/0x150
>  [   18.873280]  ? do_syscall_64+0x93/0x150
>  [   18.874742]  ? lock_release+0x7b/0x160
>  [   18.876157]  ? do_user_addr_fault+0x5ce/0x8f0
>  [   18.877833]  ? irqentry_exit_to_user_mode+0xc2/0x210
>  [   18.879608]  ? irqentry_exit+0x77/0xb0
>  [   18.879808]  ? clear_bhb_loop+0x15/0x70
>  [   18.880023]  ? clear_bhb_loop+0x15/0x70
>  [   18.880223]  ? clear_bhb_loop+0x15/0x70
>  [   18.880426]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  [   18.880683] RIP: 0033:0x44a957
>  [   18.880851] Code: ff ff e8 fc 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 8974 24 10
>  [   18.881766] RSP: 002b:00007ffcdd00fad8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>  [   18.882149] RAX: ffffffffffffffda RBX: 00007ffcdd010db8 RCX: 000000000044a957
>  [   18.882507] RDX: 0000000000000000 RSI: 00007ffcdd00fb70 RDI: 0000000000000003
>  [   18.885037] RBP: 00007ffcdd010bc0 R08: 000000000703c770 R09: 000000000703c7c0
>  [   18.887203] R10: 0000000000000080 R11: 0000000000000246 R12: 0000000000000001
>  [   18.888026] R13: 00007ffcdd010da8 R14: 00000000004ca7d0 R15: 0000000000000001
>  [   18.888395]  </TASK>
>  [   18.888610] ---[ end trace ]---
>
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Reported-by: Haowei Yan <g1042620637@gmail.com>
> Suggested-by: Haowei Yan <g1042620637@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_ets.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index f80bc05d4c5a..f27b50daae58 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
>  {
>  	struct ets_sched *q = qdisc_priv(sch);
>  
> +	if (arg == 0 || arg >= q->nbands)
> +		return NULL;
>  	return &q->classes[arg - 1];
>  }

OK, It looks like RTM_NEWTCLASS with NLM_F_CREATE and a not-found clid
would go to ets_class_change(), where there is code that seemingly would
bounce not-found classes (if (!cl) ...), but that never triggers because
ets_class_from_arg just always returns a pointer.

I'm looking around and it looks like in the other call chains that end
with ets_class_from_arg(), cl comes from the find callback and therefore
should be safe.

Patch looks good, thanks!

Reviewed-by: Petr Machata <petrm@nvidia.com>

