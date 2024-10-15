Return-Path: <netdev+bounces-135521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85699E2E3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A46BAB22440
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922241DF25F;
	Tue, 15 Oct 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLzoyOnT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBB1E1A35
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984814; cv=fail; b=u1ABQkKlDAQLV7Hyeome9r/7isK5zileyv7u9uLSaykOvt+ys1sZHNTbeWDnWWwICu7fBX/XJvlsj65SkIN6jenYxsCfxeJmTjxIyIgOiFvRNHvWy17715rc0ITC1+2fwX6Melb6gNDEJn9jewzSvV/DY/kygr/VWWbBddYrtWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984814; c=relaxed/simple;
	bh=ESkEyyNo9zedSr0d0hCc13wdLkt8K6EOw/20NqbT3dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3758BloLAls8fRdxA0GjfO2yYkJfVkanmlBLtYlH8BTsBrZz4d2in2dEHwDG1ePtpzRtA7cE/9r4o6LzJP/oWondIoN05+tYh6QfdiRhjZWzRzPePoTT2RP/aBy1KJbC/tG0oCYQGC9AFQquojxS6tXRN88mVl/SVBUXTgSklA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lLzoyOnT; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vuzh4U8gQ6LYPMpgsByM1FKMdBYbAGfocnlN2aJMAqtvglP8+0YFQ8i+S7YUbsjMfVRceEORdq+T5oii+vzhwf+/u0ONqSqgnbRhO7QaeKyDnKd0HgOEe1vYc298iFcmxM8tICKrg19nR3ylqJGcZYwO59YwZIdB9QJhU/9vQIr2jS4P8IfWZy6X66avV5Cl+Bh1rwUmPLXnofIpiWya8t4FTvK0CXsgTHnuizqBzpyNV492iEE85ZhQ7Tl5BX9NhLIC2iB0+7uJEuAGh8d1prX6B2BdecksBjL0Fib6Eiz/fIEhtvr5kOVFDB8LaWb3VZJypTe8+M6lIUiwGtRI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFv33Li/caZiaRCEoJIQ36lKcIABBNFkKo9pP490l7Y=;
 b=AEOXw0Fc1ODI0AMJHhPp7dOV4Q/R78DQKbBBVTmvnaapmlIpp5c00DJ5uNOHq0OEV6zhkard0Z90l/ZeB5cb2XM4LmFJI8XN/6ATFOYTV40Fb5FfAjLvnBiDCgrdobaihjox2Cr5RatpMfWR6iinSmykbZ4SA/7JEnQQ+AKLjVU0bPAZw3QGGSrImzWbRLhJUUIrMGkfu3MYo+/qQy8XwVwfdM5sWQUUOc/QVsyOA9v+PdxCmIfFL7C8I/nXWrtMFXcqpNCJmHCR83zrF0NF4vlvGCcMiYy0Mjpt56b4NOb8KuJdYCRRNyqraukz1UYFSmkkQMXgztN8a7yp4IRmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFv33Li/caZiaRCEoJIQ36lKcIABBNFkKo9pP490l7Y=;
 b=lLzoyOnT4iQet3mgPs+W7yb8zEerW4JN40Psog11xcmAgPBDF+5Mq2npRUE6Cofn9VUh6AumoImidqoGrXTxlrzpj13Wgc+rxMp841MtiHQFR1yOTOKfgWuI5bFZVtzVamYW5lE/mnFUTObML5dURPpwKLRFSH8mzZFOJlzS+OJJu6AjkKcRod21ZUgbW3PboZLN5ldMr+H2+478Dv1Vtqo5svjTtih6AbTlcN8sbImEmY73CRulflifmGDpglgbyyZeAFaPZ74nEEqvPzome551l5yOFm11Y/O51GCQ4XNdNcNAX6up/4UgtiiSgV7EojQlFn7Ni3WvtUnuwhh8Zw==
Received: from BYAPR11CA0045.namprd11.prod.outlook.com (2603:10b6:a03:80::22)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 09:33:29 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::3e) by BYAPR11CA0045.outlook.office365.com
 (2603:10b6:a03:80::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:33:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:33:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 7/8] net/mlx5: Unregister notifier on eswitch init failure
Date: Tue, 15 Oct 2024 12:32:07 +0300
Message-ID: <20241015093208.197603-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f62af6b-3a91-4ea1-463c-08dcecfc6c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O9Op9Ni2rbpYk3Db8ng/76FwBHKoxt7AI2XDC05PKfYrjJYWmGHa2ySvcfuT?=
 =?us-ascii?Q?Rsq1BdrfLkcpp2HBE132jmsVge4BWh//brmVmw0OqXYRAPOQv7wEhnmq+m4x?=
 =?us-ascii?Q?ecRCmlAbaRIzlNsvgIV68X52aX4sK2LZf4ox6Pf+tqafO04G56OueDHofxyQ?=
 =?us-ascii?Q?tCZNGVpZDM0VFzRbvRFZE5SKq/R8OBMo/A7x7+rxvxpP0o6yFueZow1MIEne?=
 =?us-ascii?Q?iW8qpr/Srdm6FR8UyT6pqQpOmfdclpiK2+QaJ2oW+1GzQEvnPkspJVn/jCHN?=
 =?us-ascii?Q?UX0eCwsW3KqlWqycbeYS1+if9YaKnrMJu42Zs0Hn5kCvEQ9O+uz+4rx8Li/D?=
 =?us-ascii?Q?8jTGQvdFkEMPaO8BrJKox7TRbI97mRQXck7jjQ/0otVFr4P2fsZR7s+pVpU+?=
 =?us-ascii?Q?mZCL6ZOLIuyQ05lESkErVQWp+nZ6Ml8YgbvERinHVE3E1riu6kfcXPf3dxUs?=
 =?us-ascii?Q?T0/FRmbNtH9T+YOdc5Ot0eiD3oiQh7Nv90dL14w0mqu+Mz1ceCtZfA8zWAmB?=
 =?us-ascii?Q?ZfTEYGeLYBZelhnIKxGSAoxBa36J+JFWI3ADA9R9HsTwBBn2/dFbCZ7YhTW/?=
 =?us-ascii?Q?jdv5ISurQh5lqu0BCFlBkBChNB9dSvRsDBdZ2WJ38G2ECbbuMjjVjM5UwTKL?=
 =?us-ascii?Q?FxXPmmOhibgSLbzoJBWXbrsubYP7tEzDG4VDVhqg9tqaspNSlp8gSDgOpZu7?=
 =?us-ascii?Q?nqHbzof6vW6RPfVD7pmqT8GzuCWcZRMrtpbxRecgR9tIG0MzQsDcfzfSW799?=
 =?us-ascii?Q?XyoYrV5WXKiAowfP6aXLKjSND9UfOuxpsISNVm4WAz+bXsl6QvFtOnMZTUwp?=
 =?us-ascii?Q?FFBD/acKoOn9Rm6gPT9lyX2/7TY8USdE/2Zl7/TelMwsDAvPmpPozYKj96hp?=
 =?us-ascii?Q?CODdKDSOt3d/NwB64Ljz2APhNBDWjNkQENSwrhz6b9+fnLYfraxkAaJIGPRW?=
 =?us-ascii?Q?0gGXonpMe2A0zkvSWm/Qd/Mk3fcJt1z7MQCMh9aHaOhseH4JNDJw0O6PKszt?=
 =?us-ascii?Q?7wZKOZX+atAKF9dLilICMDNC9wQ4FfZONLt+aZCghttNBkzOv5gBTLcPTCKX?=
 =?us-ascii?Q?7sLABa45gsD3tssb5rUTRKwNFfYWKpOb7Q1q3eE0awpsrCDk5rIDHN/tYczU?=
 =?us-ascii?Q?7klJLrLmts4wtCMIvbXOz62eBPB3ukPuoyB2XYmORwNkPqZse+aeBFuWbWe1?=
 =?us-ascii?Q?avLI0o3dB7JnOhq4mgJpzHxWGMs3DJMHCcdrVucu8R8N6X1V6MLe/MRL+TAs?=
 =?us-ascii?Q?gFRWBz5gnKMnGUZPoNwFF5fGicdsjUCeenJW8aWx7u9/IrJbIpZLIBci/0p0?=
 =?us-ascii?Q?CwoRuC/fxyMqG6HSE+S7rV2am6H68AdnLSJhKUITgd5jXx3inIhXNQbykUXk?=
 =?us-ascii?Q?Ee4FkKc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:27.5296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f62af6b-3a91-4ea1-463c-08dcecfc6c9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980

From: Cosmin Ratiu <cratiu@nvidia.com>

It otherwise remains registered and a subsequent attempt at eswitch
enabling might trigger warnings of the sort:

[  682.589148] ------------[ cut here ]------------
[  682.590204] notifier callback eswitch_vport_event [mlx5_core] already registered
[  682.590256] WARNING: CPU: 13 PID: 2660 at kernel/notifier.c:31 notifier_chain_register+0x3e/0x90
[...snipped]
[  682.610052] Call Trace:
[  682.610369]  <TASK>
[  682.610663]  ? __warn+0x7c/0x110
[  682.611050]  ? notifier_chain_register+0x3e/0x90
[  682.611556]  ? report_bug+0x148/0x170
[  682.611977]  ? handle_bug+0x36/0x70
[  682.612384]  ? exc_invalid_op+0x13/0x60
[  682.612817]  ? asm_exc_invalid_op+0x16/0x20
[  682.613284]  ? notifier_chain_register+0x3e/0x90
[  682.613789]  atomic_notifier_chain_register+0x25/0x40
[  682.614322]  mlx5_eswitch_enable_locked+0x1d4/0x3b0 [mlx5_core]
[  682.614965]  mlx5_eswitch_enable+0xc9/0x100 [mlx5_core]
[  682.615551]  mlx5_device_enable_sriov+0x25/0x340 [mlx5_core]
[  682.616170]  mlx5_core_sriov_configure+0x50/0x170 [mlx5_core]
[  682.616789]  sriov_numvfs_store+0xb0/0x1b0
[  682.617248]  kernfs_fop_write_iter+0x117/0x1a0
[  682.617734]  vfs_write+0x231/0x3f0
[  682.618138]  ksys_write+0x63/0xe0
[  682.618536]  do_syscall_64+0x4c/0x100
[  682.618958]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 7624e58a8b3a ("net/mlx5: E-switch, register event handler before arming the event")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Hi,
Patch is expected to conflict with net-next.
Resolution is trivial, by taking the net-next version.

Thanks,
Tariq

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 17f78091ad30..7aef30dbd82d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1489,7 +1489,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	}
 
 	if (err)
-		goto abort;
+		goto err_esw_enable;
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
@@ -1503,7 +1503,8 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	return 0;
 
-abort:
+err_esw_enable:
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_esw_acls_ns_cleanup(esw);
 	return err;
 }
-- 
2.44.0


