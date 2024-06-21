Return-Path: <netdev+bounces-105565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD788911CB0
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73684282FBA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78970169AF7;
	Fri, 21 Jun 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M7hLhzhM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120483C2F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954498; cv=fail; b=ej/diyOOBr1o7hptxt67eFO82MCYm8TfWGTgTrEsOpAeBWK348EIA7x0YzMDfxnlnCd/KZnjqw+TT1fC2zYvA8qBIBUQGQnX5OoBFQ3cdV/7lKPrkwroGtv/7w2HGr9Gnwd5JQvLinkjLD2gTYKKK/CZfSraf21TpN0Fr/I4lqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954498; c=relaxed/simple;
	bh=sIVCunZM7ezZafn26lxIwE55WBmHyN0o3Jq3GvHSLCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3MIENNmSuLruOdcExYIjoXUINbwoYScY+WpvWPlA/tEVLsFcis0VtTyS0i49nxUD6bYteL+xkdQZFjfdpZjMLb0WX5VSJUB3bOfINhk01SqpHpGPd64itTx/2ewwiw/oGD71f1xU/uGTqD3jQZN9QCgKTOI8PsudKv83CElkI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M7hLhzhM; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbh8JWnH3pFgDCuxYH72u/wRQuBVeDaNyTDCzw2sQwDACWylTA3EBnIrEwiF4+YYkTcMEAXZ9+Ezj/80QRUvhWoKs5s4yk7WJVPrhFH50sY3ud5aYeJBaO438szbro62TCXk/quYtq6T79yF3sJGRHQ+4pcRwluzezlHGHNb6pZ0/J1Ivc6HPlzZWBBUjC0gSD9Hhwdr10MjXVx5aAbMOWGwxJjihXVsh8aU5Yj+ZL06fzG9iOKSnaReozvgkU3vtZVwirO+h+vxl3FfyKq5YTqQSPsSGUNlCJ43D3eIJWEHX3Ma3ikRcrb9AGtkyl2H32Iz7dfzfNjuJfQG7ledQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkpNpvAFchb2KZh1e7kuTukO9rbEXO+xowb2qVwTmz0=;
 b=DjSGp4sKJrS+iDAhogllklOfHir5t4Y5fTpBrIo+djRO5bz1FMpdzax1b//sgtZ/8lr4R07/o7kcVKlmCnkblbD/QeidGrzj2kk1MnCFayNr4coe5as9Pl/XtbpkbpK6Qd9+W5CJ3I8j5DCNSxaukK02Blbx/YOOWAPQeEzDxJZk3NFUXAGgJkHoiFky+wBxrb1XbvbMBBLRcqJT6fv1v1nE7/+7r5atL1fQpnODoGVtcKH1lVfeUuctpJiB6fHnx9S5iwPZp7m+r4eo+FhGpFQmVks1Jgae8TZYcbXMG41ielGOhR3HAC02QJx9Dk1UoO6hMgR6NszF1K+XOlI2GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkpNpvAFchb2KZh1e7kuTukO9rbEXO+xowb2qVwTmz0=;
 b=M7hLhzhM47xvk+QqAY35UbeQEnaa4bBIYFigzz10J0sbudLdSmdT+GFfOpMAHRnE9l8GX+/lQa7giVUpPoxDZwNn+VbT6WCnsoKEsYyqCzXwZyN4q5JJdWG7iQd4j+W2zHoGZnskxBWvh4FnxhF6FfYvcTSqduI7QRykS6dKfKu9rO/S0C3Z5Fj2U0jjt7CCXkeUeat1ydE1/W5wlvV9u/ezusDwO15hdHUv8/e4+nElRjx5hhnLKUgNdvglJGUsLSN83DfTc0BCOEDgccUnH7xTqoLA9kNO2KhtbMXZKeiXPNjZ3WYZI/IeoM75CVuEjF1rRZVWgzawMto9Qoe3cg==
Received: from SA9PR10CA0012.namprd10.prod.outlook.com (2603:10b6:806:a7::17)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 07:21:31 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::e3) by SA9PR10CA0012.outlook.office365.com
 (2603:10b6:806:a7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Fri, 21 Jun 2024 07:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 07:21:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:24 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Jun
 2024 00:21:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 2/2] mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems
Date: Fri, 21 Jun 2024 09:19:14 +0200
Message-ID: <fdaa3ade0f9478b3004311112624f782d3e8c44d.1718954012.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718954012.git.petrm@nvidia.com>
References: <cover.1718954012.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa37d2c-5e87-45fe-9904-08dc91c2c59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqaHoX1U1vxdHwaFIt07I/kuhw8OnH7iZ1ey6IC33ymtmC0TS+s1AjKdQYF5?=
 =?us-ascii?Q?9ewa4YWAeQE5gSUnabeHvTaqf2vZ9W6xT9p2HarfJh8IBQSoWCTMf9dUNX9p?=
 =?us-ascii?Q?wnwXPIRNV7703q2WupxTHzJF9+cuFANapCGa/CB4ftfWdHuE6iN7oIXrfYWy?=
 =?us-ascii?Q?nI90vcGOwDJy4qlyAzF+rljJtj5BZvoY57ZFoO3VRJZ+r8AqlNHgEEiWriwY?=
 =?us-ascii?Q?hNRyC2w/v0Jl45OhFK0HHT+gDyjquWq9psUPO/XSj1on8jtt91QCqZbRLvOC?=
 =?us-ascii?Q?VAEo5xun9nELSWaJmnabE2t5aRzmM5+KdtWcoi5iEGnPqChyLmeUkVaTA/y2?=
 =?us-ascii?Q?jipaZxNfy/40iWspu5YWEN6+bP2QFW9wN+rDJsamvY1UI6+A7Xli09ry0wY0?=
 =?us-ascii?Q?EQUK1rWxwaQJ+X29qWXb8UPj2AaFAgmx4Oil/NNxGywlxw878i8N1wTqdYUc?=
 =?us-ascii?Q?L7i7PPqD4Tjh4xhKI4d/Gibp+vRmT0imAqq7xOHZNb4MJiXwKT9UPm1ZqaEM?=
 =?us-ascii?Q?NmIdhUwpHjkSi2yj7rn14DUu2PQKHSftz0veTKRPT5C+/iJ3Gr/oIfE+mWRF?=
 =?us-ascii?Q?YhXfUcktfI2gUP7dDeLnSwhOGQpDc9XCaULFSIkVekNLUe35eVLvYk+TnMAc?=
 =?us-ascii?Q?jdogTuhphkOx2qEmrCV3PGwL4wlNOKAoTEfQqWoKEfasusZROELXdzoQEKeR?=
 =?us-ascii?Q?P0eIBX1fvVQnJP5aLaeEZzO9qcFS+CIe1JCp/fLSuIcOY8SGnCcoHJbCUTUe?=
 =?us-ascii?Q?9u7x/kGwPRt/MlDdLvvlOl8NfwI2P4YS+RWX/Hcx5TKjprp1NWSQ1DDQx91a?=
 =?us-ascii?Q?2Fwrzm6WQbJeGw4amu88p+lq8t24eUu6oF/GdANDcQwkrHWd0JrvL4AjYiWg?=
 =?us-ascii?Q?FDEhBw1Q28oSfTXAF3ddID/pdqyRrf6mbcR44YcCQC2uLLXY2+tjqo4Bc+54?=
 =?us-ascii?Q?6cu09uatlRnagXzxcwrkNh353i42GWZNJQ9GLnoPODFgKsbypaQqwjBhepEC?=
 =?us-ascii?Q?7dUzGTdsKlAw605jrV5B/EJ8WN2UT2WeeGOwMd9iLgvZ9fDoLsU9wcb4ZS59?=
 =?us-ascii?Q?yAi5jvNU/dsoeo4KgjfU06jRyX+Envoc5zyIVICcYoeQct0EJzDo1wkyB4Pb?=
 =?us-ascii?Q?2QFtcsFpxhKsddZxh/P4E9m3M2M2/ekTPQK90qoDMOPfdd3sZLfSE1mNKQoK?=
 =?us-ascii?Q?i1hzfS6wtkfDBZphvfsze1vjzO4NfQ7Q0RI+Do7KqaRZ3pWndC1sKvYLq3IZ?=
 =?us-ascii?Q?NVEImeYiJ2+A2PUeU64g0Gesp5CIjS2kxZjO0CiJ7yZ7BR7s+uyiIpa4IhQM?=
 =?us-ascii?Q?6K8CV01K/59pnqZJ0t4d5Ne5xYmuhAdQw7WZCyQOrX819LWHbcr0gPo9Fskq?=
 =?us-ascii?Q?eMlz2L1nq1Mp28FqNq5IpwrsL2pby5dQNWyVzp2nIUxQIO+pIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:21:30.3756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa37d2c-5e87-45fe-9904-08dc91c2c59a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

From: Ido Schimmel <idosch@nvidia.com>

The following two shared buffer operations make use of the Shared Buffer
Status Register (SBSR):

 # devlink sb occupancy snapshot pci/0000:01:00.0
 # devlink sb occupancy clearmax pci/0000:01:00.0

The register has two masks of 256 bits to denote on which ingress /
egress ports the register should operate on. Spectrum-4 has more than
256 ports, so the register was extended by cited commit with a new
'port_page' field.

However, when filling the register's payload, the driver specifies the
ports as absolute numbers and not relative to the first port of the port
page, resulting in memory corruptions [1].

Fix by specifying the ports relative to the first port of the port page.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
Read of size 1 at addr ffff8881068cb00f by task devlink/1566
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x670
 kasan_report+0xd7/0x110
 mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
 mlxsw_devlink_sb_occ_snapshot+0x75/0xb0
 devlink_nl_sb_occ_snapshot_doit+0x1f9/0x2a0
 genl_family_rcv_msg_doit+0x20c/0x300
 genl_rcv_msg+0x567/0x800
 netlink_rcv_skb+0x170/0x450
 genl_rcv+0x2d/0x40
 netlink_unicast+0x547/0x830
 netlink_sendmsg+0x8d4/0xdb0
 __sys_sendto+0x49b/0x510
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[...]
Allocated by task 1:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 copy_verifier_state+0xbc2/0xfb0
 do_check_common+0x2c51/0xc7e0
 bpf_check+0x5107/0x9960
 bpf_prog_load+0xf0e/0x2690
 __sys_bpf+0x1a61/0x49d0
 __x64_sys_bpf+0x7d/0xc0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 poison_slab_object+0x109/0x170
 __kasan_slab_free+0x14/0x30
 kfree+0xca/0x2b0
 free_verifier_state+0xce/0x270
 do_check_common+0x4828/0xc7e0
 bpf_check+0x5107/0x9960
 bpf_prog_load+0xf0e/0x2690
 __sys_bpf+0x1a61/0x49d0
 __x64_sys_bpf+0x7d/0xc0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: f8538aec88b4 ("mlxsw: Add support for more than 256 ports in SBSR register")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_buffers.c         | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
index 1b9ed393fbd4..2c0cfa79d138 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -1611,8 +1611,8 @@ static void mlxsw_sp_sb_sr_occ_query_cb(struct mlxsw_core *mlxsw_core,
 int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 			     unsigned int sb_index)
 {
+	u16 local_port, local_port_1, first_local_port, last_local_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, local_port_1, last_local_port;
 	struct mlxsw_sp_sb_sr_occ_query_cb_ctx cb_ctx;
 	u8 masked_count, current_page = 0;
 	unsigned long cb_priv = 0;
@@ -1632,6 +1632,7 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, false);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1649,9 +1650,12 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_query(mlxsw_sp, local_port, i,
 						       &bulk_list);
@@ -1688,7 +1692,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 			      unsigned int sb_index)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, last_local_port;
+	u16 local_port, first_local_port, last_local_port;
 	LIST_HEAD(bulk_list);
 	unsigned int masked_count;
 	u8 current_page = 0;
@@ -1706,6 +1710,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, true);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1723,9 +1728,12 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_clear(mlxsw_sp, local_port, i,
 						       &bulk_list);
-- 
2.45.0


