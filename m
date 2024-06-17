Return-Path: <netdev+bounces-104183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CAB90B72C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0C01C23732
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FFD166306;
	Mon, 17 Jun 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d1GNOxxv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC816849D
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643438; cv=fail; b=d2BhQwDPd4rrCarP8RED2ARpLiTBbu6mDVsZca+WkQrCbROrvRmJ3GPZjXboZifIyGA4Q3EFMYZ9qC4iwuNK74yTxVjwwxal6cS082j4IEn/U/Wmc2veXXLXgdPWz1Dnhtce+TSwE+uwYv9p5AImDw9erHwkvQTULu7oyU2TkdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643438; c=relaxed/simple;
	bh=gnP5De53z5NbYJp3+0NQ0s2+4ccCBgs/brSelbGks2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgVTFIpl3r6Jcrc6XJyDEMM7UuLzDanF17Dm59zxDl8HxZG3BmisySlXiSz0dqkOOjlED99UjYXYys1nAQNXtp5zWTy79vYOg+qGP+3iKEZmbO5HCZL1qEajB2WJUDR9ml/sVlyWlfwPKtxLyjRWkmeWQTiwH+Iz8iycXlKm4bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d1GNOxxv; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVfq5J9KF6vlmd9j5dlNcK4YFeLot9gEp2cIfzLOLcXIbHBYozzDaqs3ifDHoBgYgidduGExqGbSQuDx+IKoHKqLoSDm62YcZ44zgng23qgAyRCZ4buxSwVsC1zrSbZQ19T+v2O31ehN7o8SdN6zW3I3AWB6IvzXvyn2VSbtr7qLWq5URMY8T+rzOormcCzn/NDi9iQ+fdqwRXU84Fwq52kvOk6ApdcUMI3tZw58Dqwpq4GuL8lUdV2J2Ph2fnfi8I+tiPwb7Dq/ApFwpSmJ+5rcco+TWgSnZhWJoPIbJpLkxV5obXplebtoPvv3uNVywG5qKlaunRgn3fQgHpD9qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOqlK/ILJV5Vig/F/104Gdns3eKOE6tH+3Y1V78+afs=;
 b=kOJi3WsFeKOAwmPDDmPJwgA1vVxHKr849InrNqNJnpvVa+gcY2QSV173cs5mHJyUdXWW6VDeOOiVpFzZoHoC6x63UU6QW9b0yoS6lOdDbG6orXCylbR8NlMNrmGt5Nasndyurn+lXUYbKNPHLAT4ic/jz5z9/w3Vi2dOxZ5UBdzun7YOWJREmgQd04vWMY0u1gFFOTp2A84h6d9pkNMcfK3oob/QBEWke/sc6JFAV7jobi4HJDm8At4StXJG5ERgp6Z84pVuT2oyCFjPjjy/tSLrveTr0U9Fs0AIj0PnqMr/S/A7V5Dc2pgTOij9F85c1AJrMMnb+e34QODsZvDx6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOqlK/ILJV5Vig/F/104Gdns3eKOE6tH+3Y1V78+afs=;
 b=d1GNOxxvMDbecO9Rr119LBrTYwt9QdN+E0VYAs3mmQdikq3bnqXtBs/NVRRm2tkOoOGV1ADdLP4KlY7JcX/vcVSUVrDyOwkJ87BjZ78wrWiNWdNmLoY2Q1x3gbwfmOwU582D7Md4EZlgCMDGM+VbeimNlqvPZpHSl1tYTDKf3tuWrBODmCEoAlJ9nEtCL0INGk+O6o7T3j6FmzByUo+3MFEe95bYYjfKUh8ovqizOtv1nnf46k7NJbDdCd3TviNGpl3Nqrrw9vXXF9p75pW8ktlv1UiaFYd1aNpPiGFL6O2ig0ljscuhk1SexfP2tl3aJngpx+Bmin2vDs4kA6TZEg==
Received: from CH0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:610:e5::27)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:57:10 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::f8) by CH0PR03CA0262.outlook.office365.com
 (2603:10b6:610:e5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 16:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 16:57:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:52 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 09:56:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net 3/3] mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems
Date: Mon, 17 Jun 2024 18:56:02 +0200
Message-ID: <fefa63964bccd39495490d6974df1cc25e68ce21.1718641468.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718641468.git.petrm@nvidia.com>
References: <cover.1718641468.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: d74f74e8-6a7b-48d9-3bdf-08dc8eee8699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9e2nEHFBxIFo1w+mtVfJohzWIaeh0XaOwH6n38rTGoOw8hcl7f7TYkvVP3Wm?=
 =?us-ascii?Q?DaB41r45ptUfeYf76+9NQz+r24KOeJdtapIrK4YxmX+kBigyjTXu8n5+PHbs?=
 =?us-ascii?Q?rBz9367kzaL+2JBzWVsc66SeDbo2XeMLVDWQLSDBVtZrWQiHUANCKIRulRxS?=
 =?us-ascii?Q?RYrJjPYxHgBsoCSsaJECewcmTs9Tm9nWxd4WeT0VzLQPBWhc/MTFJyxgpjIs?=
 =?us-ascii?Q?zXRKtniqbfTXPG3rGlFPtdJVbGpVKlBpd1VT2gNubvpi/Ognse4XJk+L5cqm?=
 =?us-ascii?Q?IXMWz7SJow98E1KvS1xLmqGzC5j96/9NHMywHDYeVrn2YEWB3SNF6uyNBmFy?=
 =?us-ascii?Q?QvJ5f5lc1y6hBoXFNZGUV6/LzcVk1uka8Q/x8lG7s1MA2eeNMzFaSa19c8Yn?=
 =?us-ascii?Q?X78D41qTvKygcDbAy5451psqioy/JIZ2l5Ji2d/ddD0Pyf+25Ka4fH+GDq2e?=
 =?us-ascii?Q?PtlT+LBew28SpQgC+gHutY0ENRX0G3d6Rm/D+F2gA1XLccxPtVa/CtzhQp90?=
 =?us-ascii?Q?V6x+GRPeCnxWCRYq8wr+NVlPccLT4kCm3jFSatEMFLpmUCKwzPSQ0INpsiBg?=
 =?us-ascii?Q?Hsluaf+CpxBIm80zjIy3uJSwMwS+OjCEXO/SySV3/i/dj+2SkBnTtiIp8Ubr?=
 =?us-ascii?Q?JIPZulFOCI3INfdAxKNGmLGLvjiP/aVE84VfWLKSmonkzschrZKfgvKGuxMp?=
 =?us-ascii?Q?ZMcSSKPuToqXMCv4BHA7T0Xe5bo7JM85iGa+MFVLaXduWxIrwpyAJ+kTUfJC?=
 =?us-ascii?Q?uLeB4xLf/2bRsd+xvW8gFumVm9s3CP8X6AORCiiJW4V6HN2tYuqzRNH/L6sb?=
 =?us-ascii?Q?WTvWeegpsiDB1KdkBOmt/piZdV5RMF4AcvdVBO1dRu3tzSlyTnNUEumcnfKS?=
 =?us-ascii?Q?3r65mpEDQ9/ylZl+aY7p5kjn9TLexGuwdv1/ht6qkS7HiYWFgWJHMzXTij6h?=
 =?us-ascii?Q?HisuHGtn8hPJzBXqFR72KdBTnRDxXTZ+EKqScUiK0x/86QrIGZILt8lCsbKk?=
 =?us-ascii?Q?juyk9aTa1n54fLus57HvU6SvVh/ZkF7glkxPmoh8miS2ms0y1emHS1s9e2Jt?=
 =?us-ascii?Q?Juxn+siQ3eyj5MjWr1I9X9Yj7GOe3Yea8hIfL7OcxnKwkizZL7aBfvw8ptkG?=
 =?us-ascii?Q?5lYHPfDHxupOAefTn3XodmThOYbs+wy3V0YlsPe4v5s1jDrTU9ThXf00WwGw?=
 =?us-ascii?Q?fQ7QOxunPq71R73oCjtuQC0SukxV2Lfmd2iNMBXzVMcLoyfo3YjZ7mDj9/7i?=
 =?us-ascii?Q?kt0GDjixFZ7LubruFlTyehVyGmAhBGOLME+E7xfPyxAnJ2BfCDXOBu6wDnIz?=
 =?us-ascii?Q?AZnrcLh9BQCPJkydqcz+g5steud2yBwTE55PoQgieu8wXn3WbK49zOuGPhI3?=
 =?us-ascii?Q?Q/lUzIcJkQ1XXDQ6CwQMjTQcgayuJA1wXal3SBK81680YONHkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:57:08.9755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74f74e8-6a7b-48d9-3bdf-08dc8eee8699
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143

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
Cc: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
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


