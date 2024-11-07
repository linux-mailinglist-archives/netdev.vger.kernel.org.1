Return-Path: <netdev+bounces-143002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26189C0DE4
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E13B22ED5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D6216A2F;
	Thu,  7 Nov 2024 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RglF0pEb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31120188A3B
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004597; cv=fail; b=LhGFmRW8SCpJ91BWVopNm9fO9yPO+0PLMsgzuxuoOOhGpl4WpVW2NNrIjJ5Hzic3MHJIaR1U8soetmuGOceo/vF2ifD82f/14oICrW+ZHmjYIxbtJ8YXfdO+A/ZoHvYH654F9FI5yQhgl5zwdDTGYLOjK0ArZ08H0mbyx+VfBB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004597; c=relaxed/simple;
	bh=pk0s11eT0/pLESgQhnkN2fZqTMVQa7RkjhZnTSJ2NjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3EWHtNqU2OEX5rBtkin+EQRBRDvU1TN2EByvwHyDtKzg73xKGnf5J1V1Yxzle5PMHvGyhI2A/x/FD7u5N4QfJggp48wRI4nIwSXbMBlaB7rsOOrM+h5tQaGCzhV6+uzAhz20w7mXshyFrp9RA/RoJlsmdQaGYe6vyHlKjbpBmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RglF0pEb; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQAlmDQCsL2lYSePTiIy//suWu1oqJdzrOvR37XtSGcFu5WHIDEAydH31OOoYioMQaFsRP9CG4H1/wLEM7za99/huqVXqpCMlZcRcs31qN1/0j0SuWbvhuyeYGPwEeeUtL7XNXas4w70MzKAtPXpK35NWJWNjXXhAmTjeiWwaDviIN0o3dSxP4zApDCVFOg5Uwuk9OwygqvA0v6W6OPGuoouXlz7jB5jnCPu/l9XeOhdZCkrotQQPvdMtHWXELKd/cxJ6QPV+ulFJDP/h0Lh4gLtiUejV8UA6ZNNRAHlK4ubKuHbPevNGDP40NVYOLLnUX6SIbP2wSdSloFjMEPxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1W7ADr2v/KLilPwRO7k+SKrvVTXBndgy8KIsXqI4GOQ=;
 b=UwzTkv7iDRgmlXezbv/aZW79BkkjJC2VDk6jtaeHdx7ogOmt3juOe9soi8k0XhMRiD5E3QPQCequW8cXhCmjzs4N8Sm7vonXAIIDekkT1ykW72cgq4f6hEfCCHVgkx8EgBqcRVDCk7TlucK3bg9giTmHy/2WosA7eI8VJreavVzjJmOwF85qID5hX4He27iLXkWSSqoFyjXLBYDvZMGx5tp7di/L5MFahfDMSCjK291/J2wnXoXJxvQthGsnW5iHqMGXje5cyd0mM5Jnvd9hQ7jxDycMinKbmlAhBAJOcuUKijS71iNsJ0uZhcMUkiVQTE2JFtnN5KuM6MKSH1xiUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1W7ADr2v/KLilPwRO7k+SKrvVTXBndgy8KIsXqI4GOQ=;
 b=RglF0pEb5vGQIqZcgNiaG7nE32Jk9yO+uFhXp5vPigReYaiIsauwPdqtETBjOAY0ViGnxMeYCsBSrmug+1OAw6BS0568NakWuCpUvPNZn94RkdCCbTqLNwLeolvQhNoP7oqMoHpYoLTMKJSWpaHzAXIiryNwF/6DlKFaWPz/xmMOCWx8FbarxFjTz+RCw2cy4xttoB942lOl62jOM5B8oK5HgjvSDMbNaTQTN1Jgg78oZaa0j2pRQRgzrc6wNbynO9D29W79ZLqmYzykMzERB40te6LiuPbNfZ+n88xBOhPhXKifLTqSeveFU7LA1SpNg241hl/2SG9Qe3OfzGzbwQ==
Received: from PH7P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::8)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 18:36:29 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::1e) by PH7P221CA0014.outlook.office365.com
 (2603:10b6:510:32a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:13 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chiara Meiohas
	<cmeiohas@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/7] net/mlx5: E-switch, unload IB representors when unloading ETH representors
Date: Thu, 7 Nov 2024 20:35:21 +0200
Message-ID: <20241107183527.676877-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3544c244-4955-4bd8-0bdf-08dcff5b17be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+Lncn8pXmINL9t4KPiznPY124g30ert5V/WT/SdsBaNvSG8cFJgDEPM5TQ/?=
 =?us-ascii?Q?Q6UDQNJtor1/yjzfZtwwvlTU2xPFcAT9s0DX3Q66VT1hCOWBEl4J5GfoJQ6L?=
 =?us-ascii?Q?MUBnVQ3Z1gBkVxdBJC5rCxBOarPkAxJeDL6XyL1odhpqH41Sakrjib9tI7jQ?=
 =?us-ascii?Q?45SJfJIDpnTloOhpRFtzsQfu1nSjnSNHjceC/JSrIs/7WjpjmLCjpRKXkYOS?=
 =?us-ascii?Q?Lwz/9Vd5JORekegQytC2321T9fgu66K28uoHmuW4VV52KGHahNKfoTW4AcLK?=
 =?us-ascii?Q?oy/mJW5OUFYvxMReunkLBSHjl9flyxHNBil6RGrHWSmahgxqrlharisgvD0j?=
 =?us-ascii?Q?FccBq8cDkmHtSaTdmJ12vVUDnWJX4akvf7R8hFllLNAjtVDCoC21HSoaOwFH?=
 =?us-ascii?Q?yrA2K38l/h1IiWweNUNrXJL6krp2Vm53xfnGj1x11stqkL6ZRUNU5rKlEe4U?=
 =?us-ascii?Q?xttiSEthrvKddbLiiOHiAnT5vtXoJ+wgBdOD5uzUu6pE53mCvqvPzTnJqpOU?=
 =?us-ascii?Q?/GnFAHYSWDrhl1dkwsYUikWHTOrMhDfmn7W0LBGBmn5twltMgjIFsfmKqVxQ?=
 =?us-ascii?Q?BurCWyYn80wPkWYQNtNBqV2oc5YX0ORVw4l25CmVUPW+0Nrd51XL7m6r13JV?=
 =?us-ascii?Q?xcxVNzknAwi+butJaJRJmhF9Shq0NaRJOsJ8WzMbti8WfupFMC/jlHwI90H0?=
 =?us-ascii?Q?KfPO2sbO1DM+R2eLOsU9sxTqX97tgpT/1aJ9wl5CiUVTmgJurIPaPIwvVOGm?=
 =?us-ascii?Q?XX22L2qyoHn/5GSM3KYGtwsUCbWawHXsp/sqrJ4+vJlz45EQilgndgVQuIg/?=
 =?us-ascii?Q?KdVR3DSsvtlW2Fex3CTPRp5/ABRo6SltyGzAoF9gP0M8YGmRwO9iA/WRh9li?=
 =?us-ascii?Q?eFjqKTy2wx3lMuq12nkldcs0rOIHoAUIBW736MK4DMQtDJT8ieyYR/Q13irx?=
 =?us-ascii?Q?rnVkQJPBcWmom/8hdpla9kSyPnP8GzlLp8NMHoXFKhUAN34i3CmrlMdUP/KJ?=
 =?us-ascii?Q?eZIJCiglP3sDx4lxxPAi9sqEOGdKZ0Lk2WyEJZM1yit2whw/jl0iv0BDenFz?=
 =?us-ascii?Q?PYsNoPmqDTHFYPYWtH4uAp9+njkxFyFkbOR87/A8vhm/u5ENeNLBoGkUtMM4?=
 =?us-ascii?Q?pzJ35sC/6oinuYu7l9v+mO6vZv0GQQyKn6xx0mMoffljH5P53rlbFAULWIqm?=
 =?us-ascii?Q?0SPBuBgItsjuNarKBuzsWg9QS3xLI6oPyzB8XnjUafeh5+agLUkCy+lPLzsC?=
 =?us-ascii?Q?6dRnj9+5CQLgu9FFB79FCM9zpEr0YK4oUjHF9yarGqS5wI58uugfJkUNZpnO?=
 =?us-ascii?Q?05VTj7p8ucjApAkpK2WthYFq415MxpN9quPBDfc4pRhEqUV2K5J3fSmrW5DD?=
 =?us-ascii?Q?ZK9oWcdMgGqAxMy0UNEA+Sug0T5oJjzgm5XvCrn3Om3K1rM42w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:28.4267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3544c244-4955-4bd8-0bdf-08dcff5b17be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813

From: Chiara Meiohas <cmeiohas@nvidia.com>

IB representors depend on ETH representors, so the IB representors
should not exist without the ETH ones. When unloading the ETH
representors, the corresponding IB representors should be also
unloaded.

The commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
introduced the use of the ib_device_set_netdev API in IB
repsresentors. ib_device_set_netdev() increments the refcount of
the representor's netdev when loading an IB representor and
decrements it when unloading.
Without the unloading of the IB representor, the refcount of the
representor's netdev remains greater than 0, preventing it from
being unregistered.
The patch uncovered an underlying bug where the eth representor is
unloaded, without unloading the IB representor.

This issue happened when using multiport E-switch and rebooting,
causing the shutdown to hang when unloading the ETH representor
because the refcount of the representor's netdevice was greater than 0.

Call trace:
unregister_netdevice: waiting for eth3 to become free. Usage count = 2
ref_tracker: eth%d@00000000661d60f7 has 1/1 users at
	ib_device_set_netdev+0x160/0x2d0 [ib_core]
	mlx5_ib_vport_rep_load+0x104/0x3f0 [mlx5_ib]
	mlx5_eswitch_reload_ib_reps+0xfc/0x110 [mlx5_core]
	mlx5_mpesw_work+0x236/0x330 [mlx5_core]
	process_one_work+0x169/0x320
	worker_thread+0x288/0x3a0
	kthread+0xb8/0xe0
	ret_from_fork+0x2d/0x50
	ret_from_fork_asm+0x11/0x20

Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index f24f91d213f2..8cf61ae8b89d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2527,8 +2527,11 @@ static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
-			   REP_LOADED, REP_REGISTERED) == REP_LOADED)
+			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
+		if (rep_type == REP_ETH)
+			__esw_offloads_unload_rep(esw, rep, REP_IB);
 		esw->offloads.rep_ops[rep_type]->unload(rep);
+	}
 }
 
 static void __unload_reps_all_vport(struct mlx5_eswitch *esw, u8 rep_type)
-- 
2.44.0


