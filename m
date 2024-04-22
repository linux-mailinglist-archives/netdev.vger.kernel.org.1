Return-Path: <netdev+bounces-90194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58E8AD0C3
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5441028B67A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3A153579;
	Mon, 22 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rNwk/Kl+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260A153509
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799780; cv=fail; b=HtDDwyc/z+REFnLzBwOyvTDgbCgc40dJYF+6Q1MpMvX4248+G8SSShiwb3RJREjg2DT4bGfDnKqkvgN+Imopyr0jIiR9c0yFCpqEBHWo2aJt+i+2TJbJcxsp5xLHlc8UsIcQ5uXiWaVI1Rr3FNlFODT8WOHZf+oTnF0UkDgB4MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799780; c=relaxed/simple;
	bh=JvMkbAnssz3dpC8ZYOIh0aqoFB9Zq+UeSo1pYZTFONc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9GPsvB4nvg9eTsAZM1FICQTJTebiirwUjg+9WhcACTHIM546wTeXJaU2ZCPk15S8vwg9d3IuQolTO0lJwbEI0BC6z5nID5lCvPEeXC71mh9QJSkndvPRJT/8CdqE/wtn5mIWFUhKc+MwWq7hvJ5QG0KIH1lQJRCQEsTL6o3QqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rNwk/Kl+; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V41dZq0rBm880waRPvLD41xxuahQlvrxYl7+lTXV9DLL1Zb7sG4cctr+L+tkOeRXhZfGnF6sJ8qRE+H87xe01syVFd9CocUPm2Z+N77eIdhLWPzGiNvdZXCwhioC7cQ5Mw3aCMKs32m9rfh1/Wyq8LGzwqYh9whQFkleI6rPMCXjgbT5o1exLozuPe2nSuG7kyOjkjMUDsZnqUDsYX/8d7iRR93g5N/lPpgqrS/qrH326JH/tbn/7OMEL4KR9DOBBT0rqJPe4B3U0KlfWIB118UCwg6vc10+kyctaxQCAKMJgKoBOZnZBoJpvZ9rD29daBehixQBxYj6OH00X5n8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKvk8bsSXpMlMC26dyda5yn3mBdLJJBTHbIKxZ+AZJY=;
 b=LseeEHx1mTl9HQ0rcrEE1JDm/E6DNTDcF8hY968p/t3O6nmRx9VJPvW5mQZt0W/MgUA8Ap3it7lditGN6dpQB0f1MFZ9xCSfNwu0+WUj0RP/H4TA1LRtN1GJvBr38f7ljRMSMzuGi4A/j6xf16QRIRfypMl5EBYEpe6dvlPRDfdHm9CNe1OYKUGqGK18pxc7mwBeHN/V3v7I2eAr6sJqfKINphZHjpTTvAsEQgnMWOgP7/3PLyFxsXot0VPEd+SfFSIxczPUm9nBl8ttaCIpfqUeB1KgdI3Wc+OTkTTc9vR8gctcwNQ8J8Xpko7qSkEPwaAq3rIKI7vFtlmwyovLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKvk8bsSXpMlMC26dyda5yn3mBdLJJBTHbIKxZ+AZJY=;
 b=rNwk/Kl+HtPz1mxhpQztE4r1UxelbEUeAhHoVjzzU7v1njZADdR5e+lJh+nptd20sLZL+5GKEAv6t00ilcW1Jb0DGXwgF8K0jfDJuISlx7y81c49tH6eq9NPzgEbxw8ry7ex4QI05ZTArPOp1RBYc6tr5qaNpdA6ZsXbHRQ6rdBrJ1Bq7mZXM02jsfWVDg/Zae1bztNV3SHuPbVT4VEWHRPWGwPQfDz+MEvodfZWmTfgLOnxf5v7+G2aCX3LunnO1q0+YZt9Q8I1x9S4B1QROg5YZAdoMkiaFqebd/f9xvhBqCim8heeVJ/QneLHV5/ACXHFh7xft51qujlEJ89LUQ==
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:35 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::4b) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:18 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 7/9] mlxsw: spectrum_acl_tcam: Fix warning during rehash
Date: Mon, 22 Apr 2024 17:26:00 +0200
Message-ID: <cc17eed86b41dd829d39b07906fec074a9ce580e.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: afca5b89-ead3-4950-277a-08dc62e103ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DnddqTMoSA2WxJ/Fg88Rnmr3ZOXVNy+1Gh6T2RhmiZix9fxpWt5Oa4KFF++l?=
 =?us-ascii?Q?oIRJ1LIn5iZ/65+TubxTQPEZVejP3n5VVN7rWKUL6/l8f0U6IePODMYx/kbK?=
 =?us-ascii?Q?M6+s7jTTOQR0LKu5NzZeApBrSw+3jQ12yhYxg7lQ1p+yRkxT7BNpjCdT3Hbd?=
 =?us-ascii?Q?LSlU8f7LcE4ZD2J/eTAiZ15e31VdCNxOLOzSzkwqyLcmOj1XYPBGhnA8FSWC?=
 =?us-ascii?Q?fvrZ05GBSBApg+LPmQ7uYK3PSLXnDne/lGAeWX8KTa9akfGhZ6OHZfbg4awv?=
 =?us-ascii?Q?YaCenGRimmx6d5ISmPyUu+8gG9KPR1zlCahjWYjN04r9w9FTypBU+5bWc/1T?=
 =?us-ascii?Q?6rCU4LW6NRdM2qmgcl1ajnF5OvsMS03wDlMADcqOPPqDbCHJGB/UjEKYETWF?=
 =?us-ascii?Q?sZVhsn0dTh3BzrG/TFibIMZuh7ZsHeEiRZ4kD4srSifjhn6fXrRW6LdMp2ti?=
 =?us-ascii?Q?RoYUHCz/5twl3lmHx8dFpvxQzupuwHeKYatVmmteRZjTRWZOY303CTlKNxsI?=
 =?us-ascii?Q?u2eQksnTmTq3DxeMgQqKmTg/tfd1uBO45POvanOiYpi4GkLQzvepSE5cgz5r?=
 =?us-ascii?Q?EMSRHBpRK7TlHXSNt/8cuEC9vPy+TApWv0hKq8KFG+61Sar9ysDZ0kquPCwl?=
 =?us-ascii?Q?9kUVjSEO9bT8lc7JmeAvQNjF2TY71PoHPJEu7saEN9PXKDRv5GWTgmlmGKw5?=
 =?us-ascii?Q?RoEX8I1ori29oUbdA4R6GuFIBQdqgNZ3olfD3RmoU0ENlXS38B5wtOaoyviV?=
 =?us-ascii?Q?g+j5vr86DjXp+DZAp0QMGqLtY8LhaEIMmpnTrH8aFsV3wy5T45Kh0mlUPfkz?=
 =?us-ascii?Q?lcHvH1YzRej/9efMq02tF/FEKuUHSGhdqpbQ7s3I+w9YKWZR0roGut018Z8V?=
 =?us-ascii?Q?Z/EFdNe+LTrvrlSAPzxfpDPMmQgYwPGKjI7K/GzL1CDLw6M9JUftRu1rYqUJ?=
 =?us-ascii?Q?7jwykzuMUs8ExljiYZ7CUChZkYt769X+KlQLM6UXVLt9ffasw+7GEv5uCGQF?=
 =?us-ascii?Q?MCZt428wGeEkG9+4SBt4FI7uDkdKN8B0F63bzSbtALw50zLaC40uX7wviR6f?=
 =?us-ascii?Q?Pf8USf+GrNwLC8EJ+94XN/M6/p6hCbIvT9V8ev6qClHH+2h5dKJT8hxrS3t+?=
 =?us-ascii?Q?SGTbUYU4h2M1oeYLJ6rCT+tL3oUA2AmxBzer8Z/QPoO4ComGTI6Mx1WgYZWm?=
 =?us-ascii?Q?9bOtNrUj+6RNX024tvOk2vb3Sv3lqmPIoKRVlFJclI9F/jozwbIowPW69mya?=
 =?us-ascii?Q?zXyRzfCKABP3WHzPVmOyWPAifiod2RjRtlLn90iCUP3JZLVroythOOdyJVCw?=
 =?us-ascii?Q?7arWV9U4PbyEwpkyM8wzvoD8XLfOUXxRegrVc8Me0INS5Omg3psYn6CS9pJs?=
 =?us-ascii?Q?mL80WL4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:35.1242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afca5b89-ead3-4950-277a-08dc62e103ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856

From: Ido Schimmel <idosch@nvidia.com>

As previously explained, the rehash delayed work migrates filters from
one region to another. This is done by iterating over all chunks (all
the filters with the same priority) in the region and in each chunk
iterating over all the filters.

When the work runs out of credits it stores the current chunk and entry
as markers in the per-work context so that it would know where to resume
the migration from the next time the work is scheduled.

Upon error, the chunk marker is reset to NULL, but without resetting the
entry markers despite being relative to it. This can result in migration
being resumed from an entry that does not belong to the chunk being
migrated. In turn, this will eventually lead to a chunk being iterated
over as if it is an entry. Because of how the two structures happen to
be defined, this does not lead to KASAN splats, but to warnings such as
[1].

Fix by creating a helper that resets all the markers and call it from
all the places the currently only reset the chunk marker. For good
measures also call it when starting a completely new rehash. Add a
warning to avoid future cases.

[1]
WARNING: CPU: 7 PID: 1076 at drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c:407 mlxsw_afk_encode+0x242/0x2f0
Modules linked in:
CPU: 7 PID: 1076 Comm: kworker/7:24 Tainted: G        W          6.9.0-rc3-custom-00880-g29e61d91b77b #29
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:mlxsw_afk_encode+0x242/0x2f0
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_entry_add+0xd9/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x109/0x290
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x6c/0x470
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 </TASK>

Fixes: 6f9579d4e302 ("mlxsw: spectrum_acl: Remember where to continue rehash migration")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 0902eb7651e1..e8c607886621 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -730,6 +730,17 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 		mlxsw_sp_acl_tcam_vregion_rehash_work_schedule(vregion);
 }
 
+static void
+mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(struct mlxsw_sp_acl_tcam_rehash_ctx *ctx)
+{
+	/* The entry markers are relative to the current chunk and therefore
+	 * needs to be reset together with the chunk marker.
+	 */
+	ctx->current_vchunk = NULL;
+	ctx->start_ventry = NULL;
+	ctx->stop_ventry = NULL;
+}
+
 static void
 mlxsw_sp_acl_tcam_rehash_ctx_vchunk_changed(struct mlxsw_sp_acl_tcam_vchunk *vchunk)
 {
@@ -752,7 +763,7 @@ mlxsw_sp_acl_tcam_rehash_ctx_vregion_changed(struct mlxsw_sp_acl_tcam_vregion *v
 	 * the current chunk pointer to make sure all chunks
 	 * are properly migrated.
 	 */
-	vregion->rehash.ctx.current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(&vregion->rehash.ctx);
 }
 
 static struct mlxsw_sp_acl_tcam_vregion *
@@ -1220,7 +1231,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_end(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_acl_tcam_chunk_destroy(mlxsw_sp, vchunk->chunk2);
 	vchunk->chunk2 = NULL;
-	ctx->current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 }
 
 static int
@@ -1252,6 +1263,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		ventry = list_first_entry(&vchunk->ventry_list,
 					  typeof(*ventry), list);
 
+	WARN_ON(ventry->vchunk != vchunk);
+
 	list_for_each_entry_from(ventry, &vchunk->ventry_list, list) {
 		/* During rollback, once we reach the ventry that failed
 		 * to migrate, we are done.
@@ -1343,7 +1356,7 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 		 * to vregion->region.
 		 */
 		swap(vregion->region, vregion->region2);
-		ctx->current_vchunk = NULL;
+		mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 		ctx->this_is_rollback = true;
 		err2 = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 							    ctx, credits);
@@ -1402,6 +1415,7 @@ mlxsw_sp_acl_tcam_vregion_rehash_start(struct mlxsw_sp *mlxsw_sp,
 
 	ctx->hints_priv = hints_priv;
 	ctx->this_is_rollback = false;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 
 	return 0;
 
-- 
2.43.0


