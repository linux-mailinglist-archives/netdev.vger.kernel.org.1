Return-Path: <netdev+bounces-243282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA038C9C739
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B5E3AA437
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FD2C3258;
	Tue,  2 Dec 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RZZAn/Hv"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBB2D0615
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697522; cv=fail; b=YNSZQuobKWpqdhHQzL+P654MyK5/X9HD2XXrjQri/6zjkMqrettmA7K+ME+asA0xpfDns9pveU4mPHfBCKzSJNgdVlhXy+w87HneNs/HHJSUVKuCiVqZfsgbSqds/CA1l0CsldmGlYo+HhGWSAPgbgsfZEf/q2wg3dGACZlbKU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697522; c=relaxed/simple;
	bh=DOKU26vAhCTv4JiTrz8cIR7cFG7Z0KulkvPu/LqhA2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9gsnHwtTmrwBKYsNeRQg3A42VHiqK5Ggj8BgEpdg5DLpvcQvDZkvy951VlBsBxWY4mUUApOikbXp5N8m6N/qAB51tOU0TZyULNIhUfiAKHqU/0unEpvQnXJ6UyNgtya0Kzwpyb1PE0ngaSTt1c+DYVoX2LmWE9A/BWjVOtyqM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RZZAn/Hv; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuOAcRYPpAgKhTAwlBo8j4REW7nozyZWH1ztdjwwWQCkG+9uwM6MpyeiTR4vAHeWy61sv6Ff4xc+Gp3E/MDj72uMQ5sY4i+UgRv8Q7TUMV/RBGDT1skFdlDt8SPh6MsiTApHxjdPKm6OJD17tcZBrWRFPf4erAi3U1WgNFV7NU5zFrjcrodCXGa3oQ8EysWclOnSDDQLQQBqcfhBuav6CuR2NxXwHvNmpyrT7RdjKnkWb6ImjdnJ/kzFv+i7tbm5/GFkwNHO+KYHDtgKPfEkhZWjtPtHAMiOpapGlIcGuReYqg/r2aVqt5vs+UfONkRCSqPfUGPA3xy1bP56iQM6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaYDom6uYMh9UqRHW43E48HA4V596/4BxhZwynV+PAo=;
 b=a8oCIj6E2b+acfuaiuPw73Xg2p4TpTdIsqD49j2+OB3nwd69jiLdL3F1ns4EfwYRuIbk7VUzUNue/79c9sYSSo4wPwU0t2K7jJ0MvOHc6OVf17yDNdg1fYXpw143j1gnw7WMcfw6B6WxC0nRnLoO5Rb+K/1BxzTzLdajF+2dRFl5nLrt2t07lQ8w5VhpTH0KP6NCBC2LobuJg4fXXZ9ficrPMr6KwY2c5VqG6mSceeTwvMi7KuRZDKfVCCxu+lkhPD2z/k+20CbpcU6fQ1AfFU8qq3UKiyFr1a/7jQ7+HvmeaziraUCDwK/Ky5nInA6XBCF74rdUDaMOo3uXdLQrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaYDom6uYMh9UqRHW43E48HA4V596/4BxhZwynV+PAo=;
 b=RZZAn/HvlCpLhZP3IGud4BpEyCnTaKOUAH+RiwMVgLWg2VLaOSpMDXco6c9pM8/b9RVIBS0QeJiKmzJSUPz7VtkFlALbeYBnD+9ML2Piu8YHdhsItr+iSWxUsXzknFlqeuvQ6FYFRLV03VmXabXe/SVZosJ2hzRu7zkoXro/8Ar+R+6++ervkS8UHo3w+rmpATn+lNbo4+zAAgGXvYHOvU9prL95YdEJVNiih6c7ZJPCPvJMT+b2kMUC1IFAjGzXRsqTfD040AuW3cIcn7lAHuSSrwJY0PJ3Hz60LyVYO4SH3w6hrFkttf26m6CN7AjwuoOPgl5gmKdhuMvcw0LzOg==
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 17:45:09 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::4d) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 17:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 17:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:44 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 09:44:39 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 2/3] mlxsw: spectrum_router: Fix neighbour use-after-free
Date: Tue, 2 Dec 2025 18:44:12 +0100
Message-ID: <92d75e21d95d163a41b5cea67a15cd33f547cba6.1764695650.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764695650.git.petrm@nvidia.com>
References: <cover.1764695650.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 551bfbc8-82cd-4041-7861-08de31ca891a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2g3isxw0McFaHWwwIrwQifi9ttzbGypXUi4/L6IuHYRE0JdecAWy8g3jIeXq?=
 =?us-ascii?Q?rLcfYDSoxHvItjCeTtFjYAUmY+hYofXZFpi/+s+yTKNOy/D4P+Ue13PXTI9Z?=
 =?us-ascii?Q?biT3znX+4/uwccjgGwJ++Oel2QP8OR+zmK8MPRYqQVXzR2kfeiRtSfCzR9BL?=
 =?us-ascii?Q?dCy3RbpBgstaWyN++ukhqwncZ4gji7Icaj5rBdA0/OdoAHBB8XG/BjpBdpjz?=
 =?us-ascii?Q?nBo4SIKGrlu0eCXfSJ7qe9lKuKamFsmCbjLAnIYkCyKqgfFUd6BWC0js5laT?=
 =?us-ascii?Q?oI26gr+MnYFrNBU+in3EQiqgWgty320eBHsojviin08Xv9s4ZfnY3aPt5+Ro?=
 =?us-ascii?Q?CiVY69fQTAkGF1oR4OSovR+zgXr7M4/hc/JAdOpyZyR977jsFPZjkzXyunh2?=
 =?us-ascii?Q?Y0U3iQogthar01rZcfDtTqSydGSkFl6cXLFbacltenl/s9qTebTxiqUdJ24Z?=
 =?us-ascii?Q?zO5hCzH/FLsFDBpzfKefzDa5WZ3I+a98W792Aj/NH/OMcer+LI76N4AVkaXa?=
 =?us-ascii?Q?mD70l/weFtJgo/X3Lxg8Fq3zCursJMv9yUqzf1JE3czoPnODVvvUqJLlv69C?=
 =?us-ascii?Q?eSWtHLVFRMXS0p2+ryC2RFDphBIsbNfpxuJYz2ueG/MExFasoZUQQalKhtUv?=
 =?us-ascii?Q?KrMd0S73xXKYMs+NLuV3Equ5uo9rgZ0Oe/JGSTmKQ8IlwLl73v5Eb6Rw83NZ?=
 =?us-ascii?Q?hcUd+pG9ASuGZPMAGelV8tv9KjSVLLeqlixcN3Md/rm3z4Xq6LU5Cp+0wn1D?=
 =?us-ascii?Q?27cK9ZRB8WewHyD4rHfWzaUF4VJWoPC2VjC81HiocxFJ+KbCnTbt7yqSV7/o?=
 =?us-ascii?Q?1Cgkn/GXq2v+oQsZD5ZYip+4Rf+IPAil/6mOZMxU5UmQ3QZ6Rc70NfNOojP3?=
 =?us-ascii?Q?hdVEFNF4Htkl44+yFOO5i/+QaoYfMump8n1Hd4IUQGyNgIbtAPAN6aXUGxCQ?=
 =?us-ascii?Q?SvyATEniZ5oN1Y6qX/2IAz8qXfYhI2T5li+LylPyMZG4u9Qyp/T9RSUaZHVF?=
 =?us-ascii?Q?QB+Zu6RVCszbK2HAuAPRyVV7CHMFlxqSPGteinMMp+TjMsIFJrlmV4B75RcE?=
 =?us-ascii?Q?qONCE733PKjGYyuk4ABhzIjCUaD3Uv77oc8gMWz9L4Eh2KJzPawXuvH46nxm?=
 =?us-ascii?Q?1JO6CCHpYYA4PHf15sz7s3RG5lsuSZr0UQq7ruPKuWkoLTd7pPME4UVK0pM/?=
 =?us-ascii?Q?TQr4B14Ni9Ir7F/g4fhlahNOWa7jFnJM2a290JbPr2QdGsdz6/jNhWAxpDJK?=
 =?us-ascii?Q?mnBOoGeNXiXsnNDhGFpxRJV9INAlINs19nl7fSYEpLWZtwmDrhjtnRMFTVR1?=
 =?us-ascii?Q?LzGX1TL7myJWRk02CgiiczJlrkZN3tzFbuaVHph7B5QEtDnlvzpOt0GuP7MY?=
 =?us-ascii?Q?Awtrzvn5XFN+wo6DGvDdp5Kr9SDjgvge4u//tOYXOcuWzYDw9Wtdy3IQCo/u?=
 =?us-ascii?Q?4paXZHt2OWnizCtsUL+XTCeXBgK3zjwdjMYGu3yWJS1Pjui2iXkECPJxVioI?=
 =?us-ascii?Q?g1+BLe13ixdx5tQVUpNNT6s3C/MIUK+w/5Tuz4sOmJTHlEfpTS/QJZaUdrq2?=
 =?us-ascii?Q?vh0g6Uy/Ggl9czvBRDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 17:45:08.5262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551bfbc8-82cd-4041-7861-08de31ca891a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826

From: Ido Schimmel <idosch@nvidia.com>

We sometimes observe use-after-free when dereferencing a neighbour [1].
The problem seems to be that the driver stores a pointer to the
neighbour, but without holding a reference on it. A reference is only
taken when the neighbour is used by a nexthop.

Fix by simplifying the reference counting scheme. Always take a
reference when storing a neighbour pointer in a neighbour entry. Avoid
taking a referencing when the neighbour is used by a nexthop as the
neighbour entry associated with the nexthop already holds a reference.

Tested by running the test that uncovered the problem over 300 times.
Without this patch the problem was reproduced after a handful of
iterations.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_neigh_entry_update+0x2d4/0x310
Read of size 8 at addr ffff88817f8e3420 by task ip/3929

CPU: 3 UID: 0 PID: 3929 Comm: ip Not tainted 6.18.0-rc4-virtme-g36b21a067510 #3 PREEMPT(full)
Hardware name: Nvidia SN5600/VMOD0013, BIOS 5.13 05/31/2023
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6e/0x300
 print_report+0xfc/0x1fb
 kasan_report+0xe4/0x110
 mlxsw_sp_neigh_entry_update+0x2d4/0x310
 mlxsw_sp_router_rif_gone_sync+0x35f/0x510
 mlxsw_sp_rif_destroy+0x1ea/0x730
 mlxsw_sp_inetaddr_port_vlan_event+0xa1/0x1b0
 __mlxsw_sp_inetaddr_lag_event+0xcc/0x130
 __mlxsw_sp_inetaddr_event+0xf5/0x3c0
 mlxsw_sp_router_netdevice_event+0x1015/0x1580
 notifier_call_chain+0xcc/0x150
 call_netdevice_notifiers_info+0x7e/0x100
 __netdev_upper_dev_unlink+0x10b/0x210
 netdev_upper_dev_unlink+0x79/0xa0
 vrf_del_slave+0x18/0x50
 do_set_master+0x146/0x7d0
 do_setlink.isra.0+0x9a0/0x2880
 rtnl_newlink+0x637/0xb20
 rtnetlink_rcv_msg+0x6fe/0xb90
 netlink_rcv_skb+0x123/0x380
 netlink_unicast+0x4a3/0x770
 netlink_sendmsg+0x75b/0xc90
 __sock_sendmsg+0xbe/0x160
 ____sys_sendmsg+0x5b2/0x7d0
 ___sys_sendmsg+0xfd/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0xfd0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
[...]

Allocated by task 109:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x7b/0x90
 __kmalloc_noprof+0x2c1/0x790
 neigh_alloc+0x6af/0x8f0
 ___neigh_create+0x63/0xe90
 mlxsw_sp_nexthop_neigh_init+0x430/0x7e0
 mlxsw_sp_nexthop_type_init+0x212/0x960
 mlxsw_sp_nexthop6_group_info_init.constprop.0+0x81f/0x1280
 mlxsw_sp_nexthop6_group_get+0x392/0x6a0
 mlxsw_sp_fib6_entry_create+0x46a/0xfd0
 mlxsw_sp_router_fib6_replace+0x1ed/0x5f0
 mlxsw_sp_router_fib6_event_work+0x10a/0x2a0
 process_one_work+0xd57/0x1390
 worker_thread+0x4d6/0xd40
 kthread+0x355/0x5b0
 ret_from_fork+0x1d4/0x270
 ret_from_fork_asm+0x11/0x20

Freed by task 154:
 kasan_save_stack+0x30/0x50
 kasan_save_track+0x14/0x30
 __kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x43/0x70
 kmem_cache_free_bulk.part.0+0x1eb/0x5e0
 kvfree_rcu_bulk+0x1f2/0x260
 kfree_rcu_work+0x130/0x1b0
 process_one_work+0xd57/0x1390
 worker_thread+0x4d6/0xd40
 kthread+0x355/0x5b0
 ret_from_fork+0x1d4/0x270
 ret_from_fork_asm+0x11/0x20

Last potentially related work creation:
 kasan_save_stack+0x30/0x50
 kasan_record_aux_stack+0x8c/0xa0
 kvfree_call_rcu+0x93/0x5b0
 mlxsw_sp_router_neigh_event_work+0x67d/0x860
 process_one_work+0xd57/0x1390
 worker_thread+0x4d6/0xd40
 kthread+0x355/0x5b0
 ret_from_fork+0x1d4/0x270
 ret_from_fork_asm+0x11/0x20

Fixes: 6cf3c971dc84 ("mlxsw: spectrum_router: Add private neigh table")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

CC: Jiri Pirko <jiri@resnulli.us>

---
 .../ethernet/mellanox/mlxsw/spectrum_router.c   | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index f4e9ecaeb104..2d0e89bd2fb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2265,6 +2265,7 @@ mlxsw_sp_neigh_entry_alloc(struct mlxsw_sp *mlxsw_sp, struct neighbour *n,
 	if (!neigh_entry)
 		return NULL;
 
+	neigh_hold(n);
 	neigh_entry->key.n = n;
 	neigh_entry->rif = rif;
 	INIT_LIST_HEAD(&neigh_entry->nexthop_list);
@@ -2274,6 +2275,7 @@ mlxsw_sp_neigh_entry_alloc(struct mlxsw_sp *mlxsw_sp, struct neighbour *n,
 
 static void mlxsw_sp_neigh_entry_free(struct mlxsw_sp_neigh_entry *neigh_entry)
 {
+	neigh_release(neigh_entry->key.n);
 	kfree(neigh_entry);
 }
 
@@ -4320,6 +4322,8 @@ mlxsw_sp_nexthop_dead_neigh_replace(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		goto err_neigh_entry_insert;
 
+	neigh_release(old_n);
+
 	read_lock_bh(&n->lock);
 	nud_state = n->nud_state;
 	dead = n->dead;
@@ -4328,14 +4332,10 @@ mlxsw_sp_nexthop_dead_neigh_replace(struct mlxsw_sp *mlxsw_sp,
 
 	list_for_each_entry(nh, &neigh_entry->nexthop_list,
 			    neigh_list_node) {
-		neigh_release(old_n);
-		neigh_clone(n);
 		__mlxsw_sp_nexthop_neigh_update(nh, !entry_connected);
 		mlxsw_sp_nexthop_group_refresh(mlxsw_sp, nh->nhgi->nh_grp);
 	}
 
-	neigh_release(n);
-
 	return 0;
 
 err_neigh_entry_insert:
@@ -4428,6 +4428,11 @@ static int mlxsw_sp_nexthop_neigh_init(struct mlxsw_sp *mlxsw_sp,
 		}
 	}
 
+	/* Release the reference taken by neigh_lookup() / neigh_create() since
+	 * neigh_entry already holds one.
+	 */
+	neigh_release(n);
+
 	/* If that is the first nexthop connected to that neigh, add to
 	 * nexthop_neighs_list
 	 */
@@ -4454,11 +4459,9 @@ static void mlxsw_sp_nexthop_neigh_fini(struct mlxsw_sp *mlxsw_sp,
 					struct mlxsw_sp_nexthop *nh)
 {
 	struct mlxsw_sp_neigh_entry *neigh_entry = nh->neigh_entry;
-	struct neighbour *n;
 
 	if (!neigh_entry)
 		return;
-	n = neigh_entry->key.n;
 
 	__mlxsw_sp_nexthop_neigh_update(nh, true);
 	list_del(&nh->neigh_list_node);
@@ -4472,8 +4475,6 @@ static void mlxsw_sp_nexthop_neigh_fini(struct mlxsw_sp *mlxsw_sp,
 
 	if (!neigh_entry->connected && list_empty(&neigh_entry->nexthop_list))
 		mlxsw_sp_neigh_entry_destroy(mlxsw_sp, neigh_entry);
-
-	neigh_release(n);
 }
 
 static bool mlxsw_sp_ipip_netdev_ul_up(struct net_device *ol_dev)
-- 
2.51.1


