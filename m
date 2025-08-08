Return-Path: <netdev+bounces-212163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4220B1E802
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A616E9AB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F1264A7C;
	Fri,  8 Aug 2025 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bjp55Jcp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AE1A2872
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654927; cv=fail; b=dMrsx0BH7pXAgiXbcd03QqIsfEeTa3wUpTPLIW+43rnMROWkJgrlJPWMj0PhfwVS7NAd8tpq0UFCzO8d+skcpFSUwQvguDrpXQw73U8IE6DWufEL1eDre85LqkxXU/sJmxQX9x3QMLzdnrGx4351FjMNr2PLHw/kp8+8nF5bCmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654927; c=relaxed/simple;
	bh=Vfpx+uKt+i4DVcdgLLK+BNBIuCQTg4gYZ1bHQY7stJE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lcJN14L4l8bYW9KIiklHz5JBEVKOKbTX672FT4fEbKsMi8nmdAIgo2EdHRpqBJ430v7nVIuuVgYXtste+ohtS51xe7jI2QImaKSVlAB7Rfu1prn4I14az1swBNzw5tjecA+kH5qKFEkR3gY9tIrFKuzSWYac1k662l5/lZNKbr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bjp55Jcp; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf08jYX5RFfiMwzJXUWmWnYsO6aqpNxHdoYn48drbPXrV/heV023j4urFcpk90U1C9XeNq4P+A3xZD+gI8iSLmt+JO6Pkh9KUVmiz4Z2Je9c9KUZfrWmMTXB0nN6HjQjzr8tttWkepnX3T3nBE0Rz4XaUP7OGwOzDdsoWAqw56RPMyV2we5Lz8fKH3MPv1R7TGs/HXRgDh/orSr4/9bxMxG92yrDYyLI+y0JruuvZyFm3ZeMDiXnQJZJ+6tFf0r3aMb6qWHR/jLUIi9X6zqNogogUWqrUMNoxVoR2Z+Zb+rEgp27+gvgy16oLDY/lqnesVVROcTKVqvMFCIkh/qGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jnd57Vx9n90eobiahzsw/gDoog3PddgTI4o3UUUarY=;
 b=wC3Lwoy2A9DA5HRl0giLw1t3cIgG8Pb/CzVzpN3MNaCJ+MCBAcJlXJ45SeD3OKkuY7psKvLugceEXgvE9HclJWZe8AfHBt3BtkpJxzmfIr+Li8BxvN1A+pL2xGKrkF7Ofn+teHUSMsczT/Oy5gb98/c1hJhwg8iXmdPuuqNGqwdOxbE2MgJ6AEDYdeda22YCfp/MUYj7zUXJQm7VYRLYtGv9J4ccczyLVL3lnk/mvnpQyyPUXssgPW3vB5qZuPkNTGk4+uLY6mR5KMcU+8WMDC9GFXdvCq9+gNh1l/HBq8HOgkY+uuxHJsBaAWgBMV0GQ3yi+yHnOtn3RIvG+MPSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jnd57Vx9n90eobiahzsw/gDoog3PddgTI4o3UUUarY=;
 b=Bjp55JcpOPZL6B5rj0cPOTp1UlrFFhhiVnPtdaReZY+rOLPiTrnSJghygfepHg2dx3598+BKf2YQ8B2SpRKW3o5T1P+MgQCqVeIEWZK5YOz6tEg4OMldZS2TDnYah6gUCP9EWUKB2CaJaq/d5sJOZPPQ/duNRdEoqiCtULztK4BhDkyzMd/IQ52MpZ/UeIX2nO5EpEkpf6nYZi+2kc6zwN+fqxzYSbSZRAYx6cRRdokAmD49PUET3Lcv+z3wimNwnlCXlEaiG0spR7ub8zHxGQiDsqXImyfsIkOduBcdNiZUvToY5QrLDCPpIvIhL0cOAtl+bO3Nwa1hUNhos3z+yg==
Received: from MW2PR16CA0062.namprd16.prod.outlook.com (2603:10b6:907:1::39)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 12:08:40 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::77) by MW2PR16CA0062.outlook.office365.com
 (2603:10b6:907:1::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Fri,
 8 Aug 2025 12:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 12:08:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 05:08:30 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 8 Aug
 2025 05:08:24 -0700
References: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
User-agent: mu4e 1.8.14; emacs 30.1
From: Petr Machata <petrm@nvidia.com>
To: Davide Caratti <dcaratti@redhat.com>
CC: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Lion Ackermann
	<nnamrec@gmail.com>, Petr Machata <petrm@mellanox.com>,
	<netdev@vger.kernel.org>, Ivan Vecera <ivecera@redhat.com>, Li Shuang
	<shuali@redhat.com>
Subject: Re: [PATCH net] net/sched: ets: use old 'nbands' while purging
 unused classes
Date: Fri, 8 Aug 2025 13:44:59 +0200
In-Reply-To: <f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com>
Message-ID: <87ms8a9fuv.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: e96e088a-332f-408d-3388-08ddd6745027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9k4L+Xrki+s6Btn7S2PMTq5ot3lUOEOVRowFdqpbw7gnvYumrcjpoiHUpEcb?=
 =?us-ascii?Q?3VwqGCxJcYNtcqBnUjoayY0OUVUy9fp/Er0nxn0juQIiRpTF+iKMtB+oco69?=
 =?us-ascii?Q?WafHE80bNlcUqGQQNXwuG1pq9c21fP9/qZUOgiAmP3qpRFu/A+cipOQGtFp/?=
 =?us-ascii?Q?oi6/aKjItIEzRiukFZDl1CheFVUp1gwb7pXLxbSbYSOYE+ZBX4WPF12cfSaW?=
 =?us-ascii?Q?X5I4IF7tlwWZPy7tEzsW/zlXB/bhZHL2aMdcF1MT4YVVISERiieqxM5gFidc?=
 =?us-ascii?Q?3UxMP5irAwpzpP/Aq6eUlTnVNO7+5PQmB/wT/0mtL2o9j1kgcVdeIWBp9Oo+?=
 =?us-ascii?Q?JGxiY6dxtRUcdZW5blUJo/W1689EHm04deRCUYUbrL0tP9QzI1pwmx6HXYKq?=
 =?us-ascii?Q?GSq3zQKSjcNJtECqHNhtp9uVnEQI2fYwIZC8AD5rZRYQ5mMgeyE990Tvu20K?=
 =?us-ascii?Q?IGf6qAmzYLL2RSHYaRfFrqPaXGljgJtjLlJW410W3Vfpm+O9gx12v8IJ4+E2?=
 =?us-ascii?Q?ErOitvNHel3mwpGok97ich418eSmkq7Q/+/5c/0+N93YI2btrFW2nM95V/lZ?=
 =?us-ascii?Q?dumNDxjMWcW2ZfR2CcP+hWDpjhgkZgIm3SARU/bh2/slClXy2r+gNJvkReEK?=
 =?us-ascii?Q?0rTZKx5zI6ZuAxcov7XpsoyGU0Z3tiCZh5tqkdwrKIK0qkWpy+V84Vnztd8r?=
 =?us-ascii?Q?2fn60gL/a3qMlxBt1r5vk0J5nLBvncpk2uBE9BsxEo5hTY33NSvGZWkGIYlN?=
 =?us-ascii?Q?OE+9z1F+u6DU9ZY2NsXAKdaxid8LV6F8n2Mr7+jB+u59Agqnho3/8FynOT9E?=
 =?us-ascii?Q?nLtpmcs2JqQenkesoUPRdzp5Xa/5SoYemIVIFY7h5IzodaRm7ywD5yXbLX9J?=
 =?us-ascii?Q?DZv+NZYHvHDdgYX7R4P/EUcgoFyw3PMy97AZzG4kB12grC3pYGpriYFaYLlf?=
 =?us-ascii?Q?cNVTnmo+azdN1V95JlbQtZ/Xe5+0zQ1xzXoO+dL1TxAeDDDt5g4/RqBwqrH7?=
 =?us-ascii?Q?Ybi9BcDJQ95aFXHXmEsh+hQTcTe/ZC6NYwWTiUuCZDrK2GC3m0WWmthsi8gH?=
 =?us-ascii?Q?7uSDvpgeSQJ/pdNNGeXobL+LW7sT1VlR5KnFISbkDEVJqyqZT2G87O9rRajN?=
 =?us-ascii?Q?phSzBp+8Rpy/PyTbYHr68XaHW2qq4tSG40F6I6DnMq3uarV7KEtqEyfk/6yI?=
 =?us-ascii?Q?1CSRQBOuHhiiEWcC8+VJeaxQ+nnERy/ld9XiT3VZAkPuPOC9P8rECiKYsY7d?=
 =?us-ascii?Q?PKTPOe++ZMQHHI3IesOSCjnwtsSWuvk9hiFLZc2QsENWEPbdWdvVba+9dcGK?=
 =?us-ascii?Q?5mEMmyFFrqj3tdkWNwacHI6AgIUS9ykXkxMfkoHTEgozj65FZOo/XGruRPaz?=
 =?us-ascii?Q?QHMHh7BDPGaTYR5GnjDvKoeFdpeuLD+mARKN1vQtK+3RO1tkhurCiikzwwQh?=
 =?us-ascii?Q?Y884F5UEkOU7PGPXfsmz5Hfw7oP9F7h3VSHq/HSjIod4cCP/NeGxH+oDyUh9?=
 =?us-ascii?Q?E/lfTkQWYoM723BHytZxMD4yWJJO8t6ww/GweR/Z1yKm5gx3CoUewqR0ZQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 12:08:40.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e96e088a-332f-408d-3388-08ddd6745027
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880


Davide Caratti <dcaratti@redhat.com> writes:

> Shuang reported sch_ets test-case [1] crashing in ets_class_qlen_notify()
> after recent changes from Lion [2]. The problem is: in ets_qdisc_change()
> we purge unused DWRR queues; the value of 'q->nbands' is the new one, and
> the cleanup should be done with the old one. The problem is here since my
> first attempts to fix ets_qdisc_change(), but it surfaced again after the
> recent qdisc len accounting fixes. Fix it purging idle DWRR queues before
> assigning a new value of 'q->nbands', so that all purge operations find a
> consistent configuration:

First let me just note: that is one sharp paragraph edge!

>  - old 'q->nbands' because it's needed by ets_class_find()

Comes from qdisc_purge_queue() calls qdisc_tree_reduce_backlog() calls
Qdisc_class_ops.find, which is ets_class_find().

>  - old 'q->nstrict' because it's needed by ets_class_is_strict()

From qdisc_purge_queue() calls qdisc_tree_reduce_backlog() calls
Qdisc_class_ops.qlen_notify, which is ets_class_qlen_notify() calls
ets_class_is_strict().

Also qdisc_purge_queue() calls qdisc_reset() calls Qdisc_ops.reset which
is ets_qdisc_reset(), and that accesses both fields.

>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 62 UID: 0 PID: 39457 Comm: tc Kdump: loaded Not tainted 6.12.0-116.el10.x86_64 #1 PREEMPT(voluntary)
>  Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS 2.12.2 07/09/2021
>  RIP: 0010:__list_del_entry_valid_or_report+0x4/0x80
>  Code: ff 4c 39 c7 0f 84 39 19 8e ff b8 01 00 00 00 c3 cc cc cc cc 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b 17 48 8b 4f 08 48 85 d2 0f 84 56 19 8e ff 48 85 c9 0f 84 ab
>  RSP: 0018:ffffba186009f400 EFLAGS: 00010202
>  RAX: 00000000000000d6 RBX: 0000000000000000 RCX: 0000000000000004
>  RDX: ffff9f0fa29b69c0 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: ffffffffc12c2400 R08: 0000000000000008 R09: 0000000000000004
>  R10: ffffffffffffffff R11: 0000000000000004 R12: 0000000000000000
>  R13: ffff9f0f8cfe0000 R14: 0000000000100005 R15: 0000000000000000
>  FS:  00007f2154f37480(0000) GS:ffff9f269c1c0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000000 CR3: 00000001530be001 CR4: 00000000007726f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ets_class_qlen_notify+0x65/0x90 [sch_ets]
>   qdisc_tree_reduce_backlog+0x74/0x110
>   ets_qdisc_change+0x630/0xa40 [sch_ets]
>   __tc_modify_qdisc.constprop.0+0x216/0x7f0
>   tc_modify_qdisc+0x7c/0x120
>   rtnetlink_rcv_msg+0x145/0x3f0
>   netlink_rcv_skb+0x53/0x100
>   netlink_unicast+0x245/0x390
>   netlink_sendmsg+0x21b/0x470
>   ____sys_sendmsg+0x39d/0x3d0
>   ___sys_sendmsg+0x9a/0xe0
>   __sys_sendmsg+0x7a/0xd0
>   do_syscall_64+0x7d/0x160
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f2155114084
>  Code: 89 02 b8 ff ff ff ff eb bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 80 3d 25 f0 0c 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 89 54 24 1c 48 89
>  RSP: 002b:00007fff1fd7a988 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>  RAX: ffffffffffffffda RBX: 0000560ec063e5e0 RCX: 00007f2155114084
>  RDX: 0000000000000000 RSI: 00007fff1fd7a9f0 RDI: 0000000000000003
>  RBP: 00007fff1fd7aa60 R08: 0000000000000010 R09: 000000000000003f
>  R10: 0000560ee9b3a010 R11: 0000000000000202 R12: 00007fff1fd7aae0
>  R13: 000000006891ccde R14: 0000560ec063e5e0 R15: 00007fff1fd7aad0
>   </TASK>
>
>  [1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
>  [2] https://lore.kernel.org/netdev/d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com/
>
> Fixes: 103406b38c60 ("net/sched: Always pass notifications when child class becomes empty")
> Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")
> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Reported-by: Li Shuang <shuali@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-108026
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> ---
>  net/sched/sch_ets.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 037f764822b9..82635dd2cfa5 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -651,6 +651,12 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  
>  	sch_tree_lock(sch);
>  
> +	for (i = nbands; i < oldbands; i++) {
> +		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
> +			list_del_init(&q->classes[i].alist);
> +		qdisc_purge_queue(q->classes[i].qdisc);
> +	}
> +
>  	WRITE_ONCE(q->nbands, nbands);
>  	for (i = nstrict; i < q->nstrict; i++) {
>  		if (q->classes[i].qdisc->q.qlen) {
> @@ -658,11 +664,6 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  			q->classes[i].deficit = quanta[i];
>  		}
>  	}
> -	for (i = q->nbands; i < oldbands; i++) {
> -		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
> -			list_del_init(&q->classes[i].alist);
> -		qdisc_purge_queue(q->classes[i].qdisc);
> -	}
>  	WRITE_ONCE(q->nstrict, nstrict);
>  	memcpy(q->prio2band, priomap, sizeof(priomap));


