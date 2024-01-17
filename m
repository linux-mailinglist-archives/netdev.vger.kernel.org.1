Return-Path: <netdev+bounces-63970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A1C830918
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADEA1F25D23
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109B0200D8;
	Wed, 17 Jan 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XN2Mk4TA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D618210F4
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503921; cv=fail; b=esZOt5Sm/3k5p5xFz0RhpcoRsh6t5TMDgY4vdyu5N/6nFa+ECdULEg+fXhh0yvgznD2njdv+TwDti7lk4M0ZOpju2Q0nI4pf6Ls3LvBOaKSkjwTgoPMctCnqMN016E/B3ZBL816KWHq3of/KNcgR+i85LP4Tl0AXvx7l6AzAOOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503921; c=relaxed/simple;
	bh=zUINnICJ4j3Qs+jgoTrvTfAFBmNd7ZgJdAFmcjTP4/E=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Lmw9SFS1x++FGNaX/ixIrsWUoj4DnS5Ii/Uv/V2ll46RwYQ+ZKV07ULtgeWP6Cy4R5/GN0wGcoDYjh/2haG86UyDK+y0N5MHPes7NfhmogrIX04iU3KYYdD2NoHzh8jXpibVzs6dT/xc+pIN2YCQWnD/0wU7tP+sXWH7ee/LKRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XN2Mk4TA; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP2hmWqnd5sjD3XPmZFXw/MUa6etwWnTg8f4m8HEcU9ZYswtQpA6jFVhn3kbTvUjFcXwFf8WYU22mCoILe7Fad+hr5wzmm+zEszvMtB7TH5gWiTqWc3Ydd6B8fWEcySpRkAIzJ//nwP+//YHM9rgVKL2MB+QK8tcCzi8tTJy/6oec8vKTRfJvCYWwnpXCbKNVBX30LcHl7ZyGRbSc3up4vkmSrDj0wafinAu8ThhhIGPRilvHnFfEixaCH+WaRumlhlpfziWTrS+haYB1Zb/oswUaxvmYcVGIlbkQmQS86BGfSKSnrR/QqfsDlh5CiYkUrG6ty/d8Rkuo6CjRduajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grp1A9s6Y34isnI3jlrgSFrlWxDA7/UeP7Y/+O14xUA=;
 b=fTwLxjysrUpJ8FRv8oyw9QM481SjkzG5KPNo1mYNrqLfSFKcaJtv1apNvgeYzKla85aDVsiiOJ8R6mlDMplsq09dEosoe1GDi3C8inwI00biJ1PZ0P7Jiu4TfvqzCRC3Y3zy0muiTxsnj6q1uvTcgzF7OH0RMT3dE6+YoL9SmwhcG6hIioB9vx4yysT79+LsqC9TDJRep5LycEKK/g0pbJQt84FMlDifEtbXeImWqF/JgYBUULwoyyRKps/M/V0kX3Vyrw9PZfpFPgogC7Sh60Oyo6ZEnrAB3EsuYhhKIFSBJ3cmQIXtU7UDUR1mu6kxumtK3SdSudwN2AgnzmHdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grp1A9s6Y34isnI3jlrgSFrlWxDA7/UeP7Y/+O14xUA=;
 b=XN2Mk4TAvWzCN/d6xEnHeSG9TdaSd61wDx6d17MZOWMjSiAF6tKSBt8awI1u06XgWb2yFHPl/RrOBRxpJi6aVUBheJcDq81Acc/9ImN2+y5M0iO6q7yfN8RTApxbvfAclWbHhS2oed1gDv0qjIK8COXOUUIasp0kess0Vbl4mNSPKAh35CgUaQbzovwy5qnvfazA1RQT/30ZQIAiL7Dsu9nzf22cGg3hoEf7i0EeLGcRqFJRNNuqXqODSNj5DyTkYx5jy/NKSCvry0Dw39r9908M7tiS8NVKH7pc5woIhwpSkkGYMFlGB7zZHaQ6LyTDYSrwvm47zbKTDlAe6pdjVQ==
Received: from CY5PR10CA0017.namprd10.prod.outlook.com (2603:10b6:930:1c::20)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 15:05:17 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::b3) by CY5PR10CA0017.outlook.office365.com
 (2603:10b6:930:1c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 15:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 15:05:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 17 Jan
 2024 07:04:59 -0800
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 17 Jan 2024 07:04:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	"Jiri Pirko" <jiri@resnulli.us>, <mlxsw@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net 2/6] mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
Date: Wed, 17 Jan 2024 16:04:17 +0100
Message-ID: <fb6a4542bbc9fcab5a523802d97059bffbca7126.1705502064.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705502064.git.petrm@nvidia.com>
References: <cover.1705502064.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 663249f9-5759-4044-7e45-08dc176db6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5CqykDZ8b09pK2oc2h0mVtFr07eLqD4ON4HQR7jM7gy/Kupf+oCF1N+G3dLTWne3EM6srZZlKKQsdasIABNmL1UFyiEKDnh7hBsUQGAJ8b2P3DTEL6g04OCSzql1jBtqwOGhnk+dRaTNInqS/0gmQnMi4lh9QrsLgZbQFoNu4Xu+oHUUQuctPGTNe8p+XuE4aQ+zBEm4s+dZi72NmOrXhtLiFnQsXvbhPT9QDzCLHBeza5lqksSaCYMmTRcfM9qFfcwaUDeodip4GH3epwttwuLYra73L1gltHA6AZw8shEi31/zCmH/yrvevhLafwoUWZrI6dPKeEE30icUzsRV3uIwdtAGDWDtO6Ty3zIxP/15nJBKN0mL9VVQh7M8GqgOf+yuyLAO702LX70pLaS5Uh99JFJZNn60Dpd/298wF8mVktMVWjl8xb8nO3GINtTHu8xv6W888Nq9jwpg8TYyE1QIHdk1U7D8h109/4lFLKq8/czC8lNmFSmKUc6D/7YQizfHym+nMdOJUMbvIocjcu0nEpsaU25XkCZ0Ny5GI+9umuLwgOQmyfDvPuABD5W1TKeQSPUjxzkKDtg42ccponw5fg6n6ZTLd7GFEU6QYXb7NecD27Pf2jCOrHfqTQ2KbXtNcrgbAHoqVCnZmxcmeFT41W9++RB0luXOndBus+FpVmaxbmB5IbI4hBW8e85RpcZiaVskooDYge3tzDqWYJNBF3jI0erOf4jUz49Zr+erO/Zixsy7yF/B8YeO1WL2
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(16526019)(356005)(36756003)(26005)(86362001)(478600001)(40460700003)(40480700001)(7636003)(2616005)(316002)(41300700001)(336012)(426003)(2906002)(107886003)(6666004)(7696005)(70586007)(70206006)(5660300002)(54906003)(83380400001)(110136005)(82740400003)(47076005)(4326008)(8676002)(8936002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:05:16.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663249f9-5759-4044-7e45-08dc176db6e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

From: Ido Schimmel <idosch@nvidia.com>

When calling mlxsw_sp_acl_tcam_region_destroy() from an error path after
failing to attach the region to an ACL group, we hit a NULL pointer
dereference upon 'region->group->tcam' [1].

Fix by retrieving the 'tcam' pointer using mlxsw_sp_acl_to_tcam().

[1]
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
RIP: 0010:mlxsw_sp_acl_tcam_region_destroy+0xa0/0xd0
[...]
Call Trace:
 mlxsw_sp_acl_tcam_vchunk_get+0x88b/0xa20
 mlxsw_sp_acl_tcam_ventry_add+0x25/0xe0
 mlxsw_sp_acl_rule_add+0x47/0x240
 mlxsw_sp_flower_replace+0x1a9/0x1d0
 tc_setup_cb_add+0xdc/0x1c0
 fl_hw_replace_filter+0x146/0x1f0
 fl_change+0xc17/0x1360
 tc_new_tfilter+0x472/0xb90
 rtnetlink_rcv_msg+0x313/0x3b0
 netlink_rcv_skb+0x58/0x100
 netlink_unicast+0x244/0x390
 netlink_sendmsg+0x1e4/0x440
 ____sys_sendmsg+0x164/0x260
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xc0
 do_syscall_64+0x40/0xe0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 22a677661f56 ("mlxsw: spectrum: Introduce ACL core with simple TCAM implementation")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index d50786b0a6ce..7d1e91196e94 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -681,13 +681,13 @@ static void
 mlxsw_sp_acl_tcam_region_destroy(struct mlxsw_sp *mlxsw_sp,
 				 struct mlxsw_sp_acl_tcam_region *region)
 {
+	struct mlxsw_sp_acl_tcam *tcam = mlxsw_sp_acl_to_tcam(mlxsw_sp->acl);
 	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
 
 	ops->region_fini(mlxsw_sp, region->priv);
 	mlxsw_sp_acl_tcam_region_disable(mlxsw_sp, region);
 	mlxsw_sp_acl_tcam_region_free(mlxsw_sp, region);
-	mlxsw_sp_acl_tcam_region_id_put(region->group->tcam,
-					region->id);
+	mlxsw_sp_acl_tcam_region_id_put(tcam, region->id);
 	kfree(region);
 }
 
-- 
2.42.0


