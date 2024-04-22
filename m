Return-Path: <netdev+bounces-90196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21268AD0CC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93C728BB03
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED2153BC5;
	Mon, 22 Apr 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvIJgnpi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190915383B
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799793; cv=fail; b=YPRAAp9eGI3iY8LRXawSUHCrKfY8MkK/opyhj9/msJRv8lDkf4UkYgcMMAZwPvNlqFhIMeSmJfV9kFQalK/PibIewv1wY7LB4H2JoGgEHeqxqBlxgYuAWT2i57XQbr2Z2zLwr2B1q6e7W/JfFC4TSElu3v+xMny4AXu3AY/v8DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799793; c=relaxed/simple;
	bh=kycO3wzgPKr79zKnJOsnx0tq5Ho10tnjOFmYIXX18WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOv5sX4iCUJedDvAscblr7EqOksaiwzlgjSiEgxExvKhJmVuUfZBKGd05D7SJ1hfZlQlX+POD1w6qPfodGocQikVBWigluc6YVGAXhbcat3vjrDZRNYE/rcXc2nehTOgZ243Se3FXV1KPtEMk3ZsyEMv+6AbMyw5TXQjwjlDaWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvIJgnpi; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WliDZmC1Ua+IG+rof3NI3DttEEQWbJJjMUiAGRhK1EPqiWVcm4wy4RDGzu3m66eKp7tNFLbIrYD9cXZ7Gp3pBD/15Y9/Ai7S2ubGZ5E1OworUGTDpz7vzcRuadPRak+hudNg20UtTA2KJEwKUTwuzKN0OfDBeSnZR91kJAMAl4P/7oYIy1Ns20EQ8hrRYTiso3Tah7thickXdh5D1dT4MvCkJdpG9EkPWhLfXJvp1p82b1KCC7MrVlYd9pfS4ET9I/KHoA1E7WJ88NL30SrJEjqxL7qFWcC1N7xVtZyBIdbi7JCwkd7yIALGwRLjsOBirKLHsDC8+UyIlXR4pH0pGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hN8e89IfU0aP/ig1Le0jAO6LS7szZchFvutIdoVRBg=;
 b=Qjepa2PLwBtcLIsM4yJlxH2yZ40vetigIojWjCcT1vMZzXDsGabhB/J9DV/KMIYj5LOfqEGzrF5LBlcsInoYNXTvf4yCCZNwIIYTxphHWCg/b4nndnTn/AlSpKp+5rnn5MDViAuJLRdiUikUOqTnfiyPSKUBRf6jgIUDqXICWVWyjWTmK424+Vz9pwTsaAZh891B7s9OvhTmrgeHIwnWakGL73nDNUzLdAyIyYrN47ne9slnp7JTV8kZQseFQ9CQ6CZ4yRsgnv0jXEfroiTUH1AWzwAJNNeLFAmHI4RrhmgvAwjyoq9cGMshjsV2R3B1KCWQ/7MPfTY2MOBQy62zHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hN8e89IfU0aP/ig1Le0jAO6LS7szZchFvutIdoVRBg=;
 b=YvIJgnpiHnt0N6z8ttxVEAX1gbLbc3l+JpbogTZdq8JNNAENycoLHTEbeeIm96YQNBsIIPSS35er8O40VND5Ux+7IamFLupLnwWXHUQR1yf3PZFpD6VH+XinxL3KWqR2VX2N6kUk8tYxKrjQke604fh9ZlE/zztxo3vhYCOp2VTfKE71qWhO6+eaCRA/dSvDlyIVwUfWG4ktoRdjRM8XaXWgSFBZ5oaB2YB4GTHmKZ4pu8alPJrU3r8WL2wNtLhLYvVoUwO1YHic9nhvCvCkcTXNUPnd/4YOqHd6px5uf3oDCCkatxag2re7wwIk2ASUSTB1h1/eX3FOrp4gUFP1vw==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:44 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::14) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:27 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 9/9] mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work
Date: Mon, 22 Apr 2024 17:26:02 +0200
Message-ID: <0cc12ebb07c4d4c41a1265ee2c28b392ff997a86.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 33015e04-2ea1-41df-15a0-08dc62e10950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DSB3dPyrkVUBowYPHv2s964T5Efo0VtqwGJ5wmagg8blJqEkvsLLX1gD64bi?=
 =?us-ascii?Q?9AbX+7RnpZa+7tY8mCUV7UVWA8WXO4Mzlhf3ORKPNPZqQ/FXljIXAScRJvmW?=
 =?us-ascii?Q?i6OYzXZ2ofFwOZ99yjbSdYGzM8MeFDEAMlx2y8ufWp7pROwzyK4wAnX4z1B9?=
 =?us-ascii?Q?eAs06su6jF97mlZK9hrkRQagFshfwFST3xcpwgmNZZXnaUpt6nJL9PSlmYQ4?=
 =?us-ascii?Q?e3YwVomMd/MNtPnp8p9HbgoepzH3BVAS+vDKLWI41/EtqDi7T+GplFPJY25y?=
 =?us-ascii?Q?JwZ8FLUCxMLt1Sc4g4PoNSnkPtIcF4kE0FuXdsrLjsw/wYCN5utN7fQs3bL2?=
 =?us-ascii?Q?Bgmnbj1/6X6MqlYJcN3bA+9l0ee3auihJSzWVj+ZN7jRNW+sM7jsB0R20Oym?=
 =?us-ascii?Q?ScLED4bChVXtq58MIznP5gR7Z+8y3TN7yzwTUfNAxWMUBhcAdnk6/P4rHtEl?=
 =?us-ascii?Q?y0g4nhVJnpaJcQ9u18Tm6k/5qucys82uG/ZmtWHpdJ5zJN/5Bt+rMkGWGdd2?=
 =?us-ascii?Q?GgeaDYDXhG4pnm4k3w3g0MtGoO6DSHmeBufJNnFFknIA2Ukk98ZoqIY8bDqD?=
 =?us-ascii?Q?TuLpSwx4/Agzd7Ox4xt/xRDyBch8Mh3nxNPK/alAYu6XpXaWm5NWayevs1b8?=
 =?us-ascii?Q?Vr8xdNnxW0TyrJGIQnjcyO8Wh1JiSokJIUC5JzbPejVFPbk5InZL0oKwVwpM?=
 =?us-ascii?Q?EIhDy6Z7AHZe9eRpz6aZZbaOUolkTrzuoWnmONa/gh2CyKTxUO/Im83o7yh7?=
 =?us-ascii?Q?xoOqDaFd0ERUHJ6e+6KAEdQ8rd3DJDO/HWElsw4AruUkxmfwZoY+qxV8GC4V?=
 =?us-ascii?Q?sZPtt/eRgNjbgDQvYrkUH6LrmO507UewxiGNeRHUwx9b78zRMdCZH7qNPo8V?=
 =?us-ascii?Q?Xb9mqZKtQIYubOy1lCehEmk1AIR1qXXfzsdyce910p3bhwZsma4XVnU54mHW?=
 =?us-ascii?Q?egudrozkOPBfoYvSd0f7FolJ/X0zzmX7V+ht9Le4ZZnyv5CXFUiegt36WbQb?=
 =?us-ascii?Q?4YLbc+oAe4AFf3mUPb0BR19zCiVeHPCLuP+orp2Yc2cDt9+cnkls3ctB5Egz?=
 =?us-ascii?Q?JcZ4msXsyFjRblg5IXEYo0hLpaMKzHqKgHITy7FHU9FwM8sfZ2Xh8+YGlyhd?=
 =?us-ascii?Q?sEoWk8ltnf1lLfI4yY/0spVK2FlGNhC3azMjFZ4x9GPX3GXqUJAG9RsyXtFz?=
 =?us-ascii?Q?rdcxtA/aesCwNcr7YURL+UlPbzg5d2cpJ4JkmQ346PbmAlTxflts4frjQe4e?=
 =?us-ascii?Q?hLffm1eUrFJiuwy/ALp2RmgKeUoaXd5dwfK6WuPPZnknbfjOMTfiEc6AkTl+?=
 =?us-ascii?Q?ZeasWxAejA7RC+/kjvnbTKliAC+uLTirsUnZb8W3DOog3rIJFOXb+x4NeMuL?=
 =?us-ascii?Q?5Ujj4tepT0WoPUHkHNnUgkWk9CS/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:44.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33015e04-2ea1-41df-15a0-08dc62e10950
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

From: Ido Schimmel <idosch@nvidia.com>

The rehash delayed work is rescheduled with a delay if the number of
credits at end of the work is not negative as supposedly it means that
the migration ended. Otherwise, it is rescheduled immediately.

After "mlxsw: spectrum_acl_tcam: Fix possible use-after-free during
rehash" the above is no longer accurate as a non-negative number of
credits is no longer indicative of the migration being done. It can also
happen if the work encountered an error in which case the migration will
resume the next time the work is scheduled.

The significance of the above is that it is possible for the work to be
pending and associated with hints that were allocated when the migration
started. This leads to the hints being leaked [1] when the work is
canceled while pending as part of ACL region dismantle.

Fix by freeing the hints if hints are associated with a work that was
canceled while pending.

Blame the original commit since the reliance on not having a pending
work associated with hints is fragile.

[1]
unreferenced object 0xffff88810e7c3000 (size 256):
  comm "kworker/0:16", pid 176, jiffies 4295460353
  hex dump (first 32 bytes):
    00 30 95 11 81 88 ff ff 61 00 00 00 00 00 00 80  .0......a.......
    00 00 61 00 40 00 00 00 00 00 00 00 04 00 00 00  ..a.@...........
  backtrace (crc 2544ddb9):
    [<00000000cf8cfab3>] kmalloc_trace+0x23f/0x2a0
    [<000000004d9a1ad9>] objagg_hints_get+0x42/0x390
    [<000000000b143cf3>] mlxsw_sp_acl_erp_rehash_hints_get+0xca/0x400
    [<0000000059bdb60a>] mlxsw_sp_acl_tcam_vregion_rehash_work+0x868/0x1160
    [<00000000e81fd734>] process_one_work+0x59c/0xf20
    [<00000000ceee9e81>] worker_thread+0x799/0x12c0
    [<00000000bda6fe39>] kthread+0x246/0x300
    [<0000000070056d23>] ret_from_fork+0x34/0x70
    [<00000000dea2b93e>] ret_from_fork_asm+0x1a/0x30

Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 89a5ebc3463f..92a406f02eae 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -836,10 +836,14 @@ mlxsw_sp_acl_tcam_vregion_destroy(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam *tcam = vregion->tcam;
 
 	if (vgroup->vregion_rehash_enabled && ops->region_rehash_hints_get) {
+		struct mlxsw_sp_acl_tcam_rehash_ctx *ctx = &vregion->rehash.ctx;
+
 		mutex_lock(&tcam->lock);
 		list_del(&vregion->tlist);
 		mutex_unlock(&tcam->lock);
-		cancel_delayed_work_sync(&vregion->rehash.dw);
+		if (cancel_delayed_work_sync(&vregion->rehash.dw) &&
+		    ctx->hints_priv)
+			ops->region_rehash_hints_put(ctx->hints_priv);
 	}
 	mlxsw_sp_acl_tcam_vgroup_vregion_detach(mlxsw_sp, vregion);
 	if (vregion->region2)
-- 
2.43.0


