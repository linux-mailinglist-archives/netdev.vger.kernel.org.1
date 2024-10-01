Return-Path: <netdev+bounces-130934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC11198C1F0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C472860CA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36A1CB300;
	Tue,  1 Oct 2024 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kF6hTxRT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5EC1C9EC9
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797536; cv=fail; b=Y29FKtVjapP+2C2Gco8MOQClteTpSnyxN9YrFvZFWIXah6UkoMMZGXUzxX31rkqTQCHqn9bOs+Fg4md/xenF3SXaEuFVui3ackvtxIHoVxb+Qmmnq0QxKizXyNBh1ekdBGsYc6GdDkZhrwUbFWafKwBKYZlmR4jNMORQ6YejRsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797536; c=relaxed/simple;
	bh=fF4vd546r8gh0YVAZGHcnDZlgR5uzggDnavEtIuYmK4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TxnE9y4Br7l/3RH447TDDz0XzW1a+TfwwebiPUUQZhfmlvEztKPp4aO3bmAUuA6AVaS0GsFk56fyVd33Zufokw/A+vELbmy6Legq+D/cNCSvrr72OYSKIPjDGQrUXgo/dV/j1eT7DZVGirf0rU3VA7pUR7CZ00Qc8+9n0Rk2ds8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kF6hTxRT; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH4mmyclhVepNdn8K4WuxylzWTUPYCONqddShePFQ15VVDMlgES018W548S6i4Hztu1/m1A3VwAdHrAoCZf5mcp+44vPXScw69Sjx1YNy/D0lAHe0t4Zw0OQD/JEF9jnJZNdwjSLMw169iDW+8QHu5ZzD5qpxg+6zBr3mRI4Ozgem2VEZnNevNMitID7e6vtUypRR0MrM3Z5ZAEMMCcoztby8FDLca8eNxbsSN3L8aJoGGOR3DEYjFHAM4u7zNrdyNIuqQ5+kVMqt62TH91LbQm2aQ8P7kf5dR2yJ/v4JALcDra3qXhXHLHlKp/H1myT90vmI+VF8ekQOyvhXwleJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1au5Rqy5YWx1zQ8XLSYsc8RQ6Fvf9fdON6FhKpT6a8k=;
 b=leTsBL/NN+a7hca6+LKkz9VGLfM5KhvXEMlsW+pmuubdg7Db+qKrR89fwU4AOrk1RFbm1tw0FYLxW4VzvSJ7zH78rZyGK7SOrLP7n+ghuzcGgj9OSOb61h0Vi0vcxZN1W5bqQnxEa4XPIjJ/cCOGsy6TjnpM17SpgwZJR7xg6Z4HKkfOwh4JUwakKjvx87rGJ8Bi1J3vC4fsrufXSWAC0DjiTgvp5+V4Vzdfm6ptO3pyXoKFiSA09WkaTUxe+UBnYUl5JknO7tTgyyRSzasNX9jFMfEQ8EZt4gAzNU6gGKo6ojGZ/mPmgJ0iGTPtp2GrpgraZZsyNYd/hOq7blNO7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1au5Rqy5YWx1zQ8XLSYsc8RQ6Fvf9fdON6FhKpT6a8k=;
 b=kF6hTxRTgep34yPM+cqDWz5cf7sRe0Cp9q4TGYWZeEaOQYJyrwRHqoG2jJ2xh1D3v0aaEvuqOP8WynF962T56GFLkzSg7amJ/ko2iEI6PWx5q7owqJRpTAAH4nGyRLW0NBbt1HvHEliFY0mBt/nY3E1cHpnwUqkS8kji6sLTcSue9NMENckTSDP3yxYg01CS0nBwTs7M9Ed95QNhfvBeTBFBHu0G7hSO6DNw4LXOvCjWiEBO5Ebd3+Tx06/MlxXGOGTOrR1CtU6jqMEfWVzIXWVxIeCWJa1JttXCEgvwVQcPMwPgY+2/505w4zMkXNZqrV4d36KhX1m9xQAoPGKWag==
Received: from SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) by DM4PR12MB5795.namprd12.prod.outlook.com
 (2603:10b6:8:62::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 15:45:31 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:803:40:cafe::c) by SN4PR0501CA0019.outlook.office365.com
 (2603:10b6:803:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14 via Frontend
 Transport; Tue, 1 Oct 2024 15:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 15:45:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 08:45:13 -0700
Received: from tetra-01.mvlab.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 08:45:12 -0700
From: Andy Roulin <aroulin@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <pablo@netfilter.org>, <kadlec@netfilter.org>, <roopa@nvidia.com>,
	<razor@blackwall.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, Andy Roulin <aroulin@nvidia.com>
Subject: [PATCH net 0/2] netfilter: br_netfilter: fix panic with metadata_dst skb
Date: Tue, 1 Oct 2024 08:43:58 -0700
Message-ID: <20241001154400.22787-1-aroulin@nvidia.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 02de1b77-221c-43d5-017c-08dce23014cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCcwCPfwI/SMkMx5NJ7JW0J86nB5K2hSx8VNkU28Lv7npeziHtvehR7PIQZ1?=
 =?us-ascii?Q?LsDas0BnXW5gEViOKs5gHIrj0QM11+ED221oB5IB2kqN8lUXLszSHL3OHsvn?=
 =?us-ascii?Q?iRauBeH5/7yTadCyVg4dMQ6QiuD2psI1N1zIwyobODs/hRjBpybj0lpFA4bB?=
 =?us-ascii?Q?9yvWThmKH99bq3oQvJfES5ywBNf8FBgScqSkLICCWkFLvJKbmMV+3MwZOpKm?=
 =?us-ascii?Q?5LCo12peALdveBIG6IZ266+jyQLfVKF9kBfui4gDZ56xOkITbt9XYVj86nd5?=
 =?us-ascii?Q?/o9gU2yukc9q3LG3H/8WPcFWkfFQOijiGAZd/nhUC0txi0mf33Yof/ff7MJL?=
 =?us-ascii?Q?ZGwOOyFzS58/N/1k1fO62/JAHCSABSK+60KHyf9FDgDDOfBzOnaz56l7DOgP?=
 =?us-ascii?Q?91SVlT0Up/TU3FQP96Kyw7HcFYKETC7on/3vu0aO6lB/NY15EFYdqnL21G/Y?=
 =?us-ascii?Q?l0qPjU3YnYzQWKO6Dto56yP4L6q1E+HeMixOp3OBDnyIB1vXFze+I6cotfG/?=
 =?us-ascii?Q?frgMZ8ZFaNYKyDdSSRuAVc7pKcSkovtS5dNfDmVDa99gm0Sa9GP2P3QvFelI?=
 =?us-ascii?Q?yfm1ilGr/nWbmaFgPeOTMh86xeirf/khIB4FlKEam9o4lMV4KISg1Xmi17Sm?=
 =?us-ascii?Q?LkV8Hf45645ZLpzurww6kKMdyb6vS8zt4rgv/OZEzos9fZtl+Kk98mFVp70p?=
 =?us-ascii?Q?ffvFbf/gXmxd5zc+7UZWV+NyWX9q6d68UltUo14GqdQ3X9hymTIEqdxpbgyh?=
 =?us-ascii?Q?57ppfEKEpooVpxvFTWQTo6seD4bbP0CLpbJ6Dl27eQFVg3jQF7b2Pf7PjSh4?=
 =?us-ascii?Q?kTbFxlJVPByYwrD2xiCrUEum67hSR3UXm1pkplNXFDac1lctFjaVzKW+Al0Z?=
 =?us-ascii?Q?wbb5NlqFqqbpS8yfM2BGkA8g/1ANUDsl95h5Xufx/boKzGD+kQZPMglC2K5J?=
 =?us-ascii?Q?0NCjDceHufdqcToc/zCMo8XNr7EwZFxFxH5Sb7CNKJ48egcH22j0TIF8Xnb9?=
 =?us-ascii?Q?7y2XvSpoNtvcu6mrUC/S2/LQGrihJVSlBip69AiMHQc3QGNgZ5LwwOdB7zfQ?=
 =?us-ascii?Q?zUGO+tKKQxkEKclb5DKMe00qr3FNGj1APJEy7eQp7I0UbtQksJb7TlBG5Gnt?=
 =?us-ascii?Q?BXsufmPoADrFEulzjiu7tEH4yj5ElMehqMhV8UY1EqThc3YQPhxzFb1GcSlt?=
 =?us-ascii?Q?LIbS8Tvmtu3ATtiHXhTboTzQb4Zv+hNfIVP24pDkidp7ivc2rarZjE+Zufj2?=
 =?us-ascii?Q?3JtHgxxEKrubIvBpBtFyDvBMIjqmLhmTsOw7lQu1HZjBDYkDJh5N3SDcSKgt?=
 =?us-ascii?Q?S0jU7dXRF7pzDYSvRlKxN+AMAEDx9INd3yEfdna9+AKFH9bNr/6TrRqz7MBY?=
 =?us-ascii?Q?Vc0JiSfGndBS83u+z5t3DleuYe3J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 15:45:31.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02de1b77-221c-43d5-017c-08dce23014cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

There's a kernel panic possible in the br_netfilter module when sending
untagged traffic via a VxLAN device. Traceback is included below.
This happens during the check for fragmentation in br_nf_dev_queue_xmit
if the MTU on the VxLAN device is not big enough.

It is dependent on:
1) the br_netfilter module being loaded;
2) net.bridge.bridge-nf-call-iptables set to 1;
3) a bridge with a VxLAN (single-vxlan-device) netdevice as a bridge port;
4) untagged frames with size higher than the VxLAN MTU forwarded/flooded

This case was never supported in the first place, so the first patch drops
such packets.

A regression selftest is added as part of the second patch.

PING 10.0.0.2 (10.0.0.2) from 0.0.0.0 h1-eth0: 2000(2028) bytes of data.
[  176.291791] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000110
[  176.292101] Mem abort info:
[  176.292184]   ESR = 0x0000000096000004
[  176.292322]   EC = 0x25: DABT (current EL), IL = 32 bits
[  176.292530]   SET = 0, FnV = 0
[  176.292709]   EA = 0, S1PTW = 0
[  176.292862]   FSC = 0x04: level 0 translation fault
[  176.293013] Data abort info:
[  176.293104]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  176.293488]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  176.293787]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  176.293995] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000043ef5000
[  176.294166] [0000000000000110] pgd=0000000000000000,
p4d=0000000000000000
[  176.294827] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  176.295252] Modules linked in: vxlan ip6_udp_tunnel udp_tunnel veth
br_netfilter bridge stp llc ipv6 crct10dif_ce
[  176.295923] CPU: 0 PID: 188 Comm: ping Not tainted
6.8.0-rc3-g5b3fbd61b9d1 #2
[  176.296314] Hardware name: linux,dummy-virt (DT)
[  176.296535] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[  176.296808] pc : br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
[  176.297382] lr : br_nf_dev_queue_xmit+0x2ac/0x4ec [br_netfilter]
[  176.297636] sp : ffff800080003630
[  176.297743] x29: ffff800080003630 x28: 0000000000000008 x27:
ffff6828c49ad9f8
[  176.298093] x26: ffff6828c49ad000 x25: 0000000000000000 x24:
00000000000003e8
[  176.298430] x23: 0000000000000000 x22: ffff6828c4960b40 x21:
ffff6828c3b16d28
[  176.298652] x20: ffff6828c3167048 x19: ffff6828c3b16d00 x18:
0000000000000014
[  176.298926] x17: ffffb0476322f000 x16: ffffb7e164023730 x15:
0000000095744632
[  176.299296] x14: ffff6828c3f1c880 x13: 0000000000000002 x12:
ffffb7e137926a70
[  176.299574] x11: 0000000000000001 x10: ffff6828c3f1c898 x9 :
0000000000000000
[  176.300049] x8 : ffff6828c49bf070 x7 : 0008460f18d5f20e x6 :
f20e0100bebafeca
[  176.300302] x5 : ffff6828c7f918fe x4 : ffff6828c49bf070 x3 :
0000000000000000
[  176.300586] x2 : 0000000000000000 x1 : ffff6828c3c7ad00 x0 :
ffff6828c7f918f0
[  176.300889] Call trace:
[  176.301123]  br_nf_dev_queue_xmit+0x390/0x4ec [br_netfilter]
[  176.301411]  br_nf_post_routing+0x2a8/0x3e4 [br_netfilter]
[  176.301703]  nf_hook_slow+0x48/0x124
[  176.302060]  br_forward_finish+0xc8/0xe8 [bridge]
[  176.302371]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
[  176.302605]  br_nf_forward_finish+0x118/0x22c [br_netfilter]
[  176.302824]  br_nf_forward_ip.part.0+0x264/0x290 [br_netfilter]
[  176.303136]  br_nf_forward+0x2b8/0x4e0 [br_netfilter]
[  176.303359]  nf_hook_slow+0x48/0x124
[  176.303803]  __br_forward+0xc4/0x194 [bridge]
[  176.304013]  br_flood+0xd4/0x168 [bridge]
[  176.304300]  br_handle_frame_finish+0x1d4/0x5c4 [bridge]
[  176.304536]  br_nf_hook_thresh+0x124/0x134 [br_netfilter]
[  176.304978]  br_nf_pre_routing_finish+0x29c/0x494 [br_netfilter]
[  176.305188]  br_nf_pre_routing+0x250/0x524 [br_netfilter]
[  176.305428]  br_handle_frame+0x244/0x3cc [bridge]
[  176.305695]  __netif_receive_skb_core.constprop.0+0x33c/0xecc
[  176.306080]  __netif_receive_skb_one_core+0x40/0x8c
[  176.306197]  __netif_receive_skb+0x18/0x64
[  176.306369]  process_backlog+0x80/0x124
[  176.306540]  __napi_poll+0x38/0x17c
[  176.306636]  net_rx_action+0x124/0x26c
[  176.306758]  __do_softirq+0x100/0x26c
[  176.307051]  ____do_softirq+0x10/0x1c
[  176.307162]  call_on_irq_stack+0x24/0x4c
[  176.307289]  do_softirq_own_stack+0x1c/0x2c
[  176.307396]  do_softirq+0x54/0x6c
[  176.307485]  __local_bh_enable_ip+0x8c/0x98
[  176.307637]  __dev_queue_xmit+0x22c/0xd28
[  176.307775]  neigh_resolve_output+0xf4/0x1a0
[  176.308018]  ip_finish_output2+0x1c8/0x628
[  176.308137]  ip_do_fragment+0x5b4/0x658
[  176.308279]  ip_fragment.constprop.0+0x48/0xec
[  176.308420]  __ip_finish_output+0xa4/0x254
[  176.308593]  ip_finish_output+0x34/0x130
[  176.308814]  ip_output+0x6c/0x108
[  176.308929]  ip_send_skb+0x50/0xf0
[  176.309095]  ip_push_pending_frames+0x30/0x54
[  176.309254]  raw_sendmsg+0x758/0xaec
[  176.309568]  inet_sendmsg+0x44/0x70
[  176.309667]  __sys_sendto+0x110/0x178
[  176.309758]  __arm64_sys_sendto+0x28/0x38
[  176.309918]  invoke_syscall+0x48/0x110
[  176.310211]  el0_svc_common.constprop.0+0x40/0xe0
[  176.310353]  do_el0_svc+0x1c/0x28
[  176.310434]  el0_svc+0x34/0xb4
[  176.310551]  el0t_64_sync_handler+0x120/0x12c
[  176.310690]  el0t_64_sync+0x190/0x194
[  176.311066] Code: f9402e61 79402aa2 927ff821 f9400023 (f9408860)
[  176.315743] ---[ end trace 0000000000000000 ]---
[  176.316060] Kernel panic - not syncing: Oops: Fatal exception in
interrupt
[  176.316371] Kernel Offset: 0x37e0e3000000 from 0xffff800080000000
[  176.316564] PHYS_OFFSET: 0xffff97d780000000
[  176.316782] CPU features: 0x0,88000203,3c020000,0100421b
[  176.317210] Memory Limit: none
[  176.317527] ---[ end Kernel panic - not syncing: Oops: Fatal
Exception in interrupt ]---\

Andy Roulin (2):
  netfilter: br_netfilter: fix panic with metadata_dst skb
  selftests: add regression test for br_netfilter panic

 net/bridge/br_netfilter_hooks.c               |   5 +
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 tools/testing/selftests/net/netfilter/config  |   2 +
 .../selftests/net/netfilter/vxlan_mtu_frag.sh | 121 ++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100755 tools/testing/selftests/net/netfilter/vxlan_mtu_frag.sh

-- 
2.39.2


