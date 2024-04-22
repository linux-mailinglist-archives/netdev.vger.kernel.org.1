Return-Path: <netdev+bounces-90190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 728488AD0BC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867B28B4E6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3121534F4;
	Mon, 22 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c0jGhb3r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063E1534FB
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799762; cv=fail; b=JvMLcWmp+Tt4yv/6ACssN4evZDOB3/B7EIQYacxVlFhtv7RVjQm8ZQqHEYB3o/0CKheKgSfV2NTMHHsh74u0cHHuquFDlxKUZ6QPMr3/V54RvnytAMxNkRjnRAfuDKNoOwHp1prupwc6SEFeecT7gPc5eh/fbtQ8jPbFEeifuag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799762; c=relaxed/simple;
	bh=/VxFjK9w+ruUocLIAZJ0Q1IQYugd6ZhtIGo+EahE5Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfXBPGq9l6tsk8N0TR5AJfJb2oDndpjQf2tt8lNhNhVyjaKSN5PbMfAj7KkaWN6waVQXvXKatnDiDGYiS9bo2tt8sg0XgSE+QPPcnKi4T8ZaKBE765oJixGFXWIoygEFETjnrakQEvOg3xIYIPU7MjPtfoyEZJsxjw6qcZxR/9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c0jGhb3r; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtMUwdxTnzezOm5jJiB0GWMEwR84gZcFQM7wdOi4L+DtVgnQZP3HIRFI6AVwO59BvjiUpDVHenGtUibUTfKPRbBaZZEZ1QSZt09QqApWazVJAAwaH963edkI847tvrUEFRkER3sXkYisx8Q1kG5eWJ9JiDS2cwtH+u0aQOTCxYdcLFPWI+SF2s7geSaKotaYxMEBsOyqzBeiD51+6vIYt6f83cjFiRYXFOewhiV0nKCNYfdpD8wxrRliZ6Xptac3tQ7bCquImpyncbRBFtf5xfnohR6/7VkMfGvgrt8iUjnY+C+ZJgftABqRQIiIlU/UEz9MCzOl+FgwwkUHdeCCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L348D1DeLf8l/s+PxSCqI2gXu5nZa2JhK0B6AA2zVxU=;
 b=YrJMgHwr3KwTZ8dhdGecUziAe/86dGwwJd5aZGUm/xl/t8okwlTKb/VCbei2KSa9B2ps7HOuQQ5+ET0PZ4wN+UbxYv7Jz4yJzc/Dw12HljLt3NhOIjgL9Defm/3Of3oUEOtQg0K15hcp21g5xv/Lcwza+Wc09gVb5411iL4D3lvoyRwWXs8nZiAMn+XpsgH/r57ZTm3i11a5USQ6Tto/zQqccPy+rlFYq4d0gPHv7B28G312xZetXIgG3kOMg+Tex/vU1PGY4DVqeCkSAPpHf7lff2hil4CSo8vN6Lr4BH+rqUBPNeIisT/xhvmVW6Xbs63hL9HVrKoTmyen6+/ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L348D1DeLf8l/s+PxSCqI2gXu5nZa2JhK0B6AA2zVxU=;
 b=c0jGhb3rBr1FB/xbRI3iIziHRpMEB8IUu55HEpSwSLwN0dkQfXMHn67EaRQ/lXcHH9etGJM2sTPR0C9ukElCvADmSDphhWHb0GpE5ndeEvkCTZcoT2peI7zpFdQDjBtYquy0A9yFSYNuH3yREbwaWUXeWlCrFnzGuggdd3bd2BTImk5pBZwScTcNuSR4hFJP2t18ZrdGEQD+WclR2bfdaH00S024dkkLwUWyYEX97Db4DrXIJa54iEiC7R62Fin6fVQRyrqHLTGVsWNCuSzTjYvpxtg6P1NHbL4jQ+MwhpFY/PdPVY9EmmcKt7f7axFQ1TCfl9aURn/RMAdzes475Q==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:18 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::36) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:59 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 3/9] mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update
Date: Mon, 22 Apr 2024 17:25:56 +0200
Message-ID: <1fcce0a60b231ebeb2515d91022284ba7b4ffe7a.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
References: <cover.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 220909bf-e5dc-489f-4b05-08dc62e0f9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4Cst9Nh7HTlNxs5/RCI9ALxaWtNUhQcAXVQtu/g21BanYlI5oCEPt+uxuoa?=
 =?us-ascii?Q?HdcG2CWSV18M8jk5ROMDGih3yPBHcxC3eWCf4rh4rqIvNmeTYJe7KKwNviw3?=
 =?us-ascii?Q?wU8rnM8+PUdxtTUF1f+CouE5DaKF1zUVDXZLRwNCEPf9cTmxYTwTFAlCfPeP?=
 =?us-ascii?Q?x/V4jF4BgjStZaSI5VODKAOqi9sfBPJ/IP9isrvuv2MQVcj7Y7k9lndhHmyv?=
 =?us-ascii?Q?ke6ua9wQlIBC0sM+X5yfrPjGeXVwvYxUZujABJ4dl6rHAMYy1QeE7oSoOTCl?=
 =?us-ascii?Q?YmFkM68TGUce/e+VzFTR6RW7Wq5iZ7QQI5XOX/JEjwY6pYivxH0xK69Cle4Q?=
 =?us-ascii?Q?dIjabgbfwDunUn/mYCrqMWI9dQcjhlTA3eeHsninokV0Nx1/CKf511YioI39?=
 =?us-ascii?Q?BbFmC+w5Z3EUC7Z35oIBL33rnw59R1h6e7ztzBpMkh0rC9TCsuvDUtB6fD3u?=
 =?us-ascii?Q?5nklQcGYDyiL+kAdhThBKF1zDQTEuSp/ACRKb4+Qgfk7N13mvzSfeh3j41cP?=
 =?us-ascii?Q?RItXAgtN2Hw6zd3GhLePcTzjf4QkMRhniWViBgrsbuNAX9fRs9/tWKKcRclG?=
 =?us-ascii?Q?q1RATZ3y3S7XEDQJwrq8cnFQyGLb97LG5818jemeRMGxSBoD8dmIZkMRu8X+?=
 =?us-ascii?Q?tbo2g6aFRzRK5mnlihQavb8A0mKjm5k5yCRh7ntJgnQb6DwFIokEsHVCbdNJ?=
 =?us-ascii?Q?t+0QpaaXdk8+u5s8YDqPcG2NzBl1GTKAphzz5IX1j+06vrGPCUYxf/CCyS5q?=
 =?us-ascii?Q?CCmcwzHtYYGMEg4QOYi0s/9dLiS2wpDTsKGVtCMhnt13dbiGsE8zZzWDpNKF?=
 =?us-ascii?Q?2Gk5moY4y6pMDdDkyDAZZy9aJV9KePvaxBOUVjXLxVbY8Tvrm+5sxrAi+IBx?=
 =?us-ascii?Q?WHAbsSjn4ClrowbqCYnMcBYnwQeMfyOx6RNvVM1CWy7B2gIwYNdwehm3+fUP?=
 =?us-ascii?Q?TAaGlsXX7UgZwxGC5VmYb+FYRHgIKDttXycryk5IZPOe1I3fBwlRon4eRzlE?=
 =?us-ascii?Q?apQ2QNUXenOWnvmOvPE9Ep8ZTBSnD0CdZZ53w8vo0KsMEX5t3JWfVm6BDUtq?=
 =?us-ascii?Q?wzXigAw5x+c49ANKSm3Ufz9X4gIoMf5y1u9DZ5fX17tccolX0ZWavCUka4Hj?=
 =?us-ascii?Q?79RFwtshhA1a4zNzI8wpA0/SpiRDUwjZtH09WVeaYgP0s4p5xHXptevo0nOo?=
 =?us-ascii?Q?j+Al3PIlbKurbD+UGoO4z/ScFhOiFHaDgVCdTv6N2+G8a8xpFvjkHiYIG9bQ?=
 =?us-ascii?Q?75qxcc2otB1VqWwcJoHDDKhlE5/3L0ZxFLjCPlKCup9ERg4oKy+IxPscb+s9?=
 =?us-ascii?Q?I/yY6msv+EOKab+8KCXPLgU10HxKaVrOJTtRHK9o3+mjXo/LI51vzFPNmUfi?=
 =?us-ascii?Q?RThizPLyNI+eSrl2Bi/Jq85V/f7Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:18.0520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220909bf-e5dc-489f-4b05-08dc62e0f9c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476

From: Ido Schimmel <idosch@nvidia.com>

The rule activity update delayed work periodically traverses the list of
configured rules and queries their activity from the device.

As part of this task it accesses the entry pointed by 'ventry->entry',
but this entry can be changed concurrently by the rehash delayed work,
leading to a use-after-free [1].

Fix by closing the race and perform the activity query under the
'vregion->lock' mutex.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_acl_tcam_flower_rule_activity_get+0x121/0x140
Read of size 8 at addr ffff8881054ed808 by task kworker/0:18/181

CPU: 0 PID: 181 Comm: kworker/0:18 Not tainted 6.9.0-rc2-custom-00781-gd5ab772d32f7 #2
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_rule_activity_update_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x670
 kasan_report+0xd7/0x110
 mlxsw_sp_acl_tcam_flower_rule_activity_get+0x121/0x140
 mlxsw_sp_acl_rule_activity_update_work+0x219/0x400
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1039:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc+0x19c/0x360
 mlxsw_sp_acl_tcam_entry_create+0x7b/0x1f0
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x30d/0xb50
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x157/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Freed by task 1039:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 poison_slab_object+0x102/0x170
 __kasan_slab_free+0x14/0x30
 kfree+0xc1/0x290
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x3d7/0xb50
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x157/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 9c0c728bb42d..7e69225c057d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1159,8 +1159,14 @@ mlxsw_sp_acl_tcam_ventry_activity_get(struct mlxsw_sp *mlxsw_sp,
 				      struct mlxsw_sp_acl_tcam_ventry *ventry,
 				      bool *activity)
 {
-	return mlxsw_sp_acl_tcam_entry_activity_get(mlxsw_sp,
-						    ventry->entry, activity);
+	struct mlxsw_sp_acl_tcam_vregion *vregion = ventry->vchunk->vregion;
+	int err;
+
+	mutex_lock(&vregion->lock);
+	err = mlxsw_sp_acl_tcam_entry_activity_get(mlxsw_sp, ventry->entry,
+						   activity);
+	mutex_unlock(&vregion->lock);
+	return err;
 }
 
 static int
-- 
2.43.0


