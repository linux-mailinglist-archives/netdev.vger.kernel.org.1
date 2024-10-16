Return-Path: <netdev+bounces-136212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226CA9A10C8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D4E1C22026
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480A212EEF;
	Wed, 16 Oct 2024 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KJFOmmFJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F5212F02
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100262; cv=fail; b=YUaeTY9IU8JMdrcM4suswqkUg8+k4JPtCJGQxf1yN0jsm7QOfXKR6etCxX7Zq13fTkOXTC5vqiVzOpYIjC4HcnFnRFKgA1v8OGdPgTypbg2y72Hr9N3IK1uGSpKVpc+O3iUHKmSWQed1XUIrNEMv3M8BUXLJTDFXIXIOtEtuK6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100262; c=relaxed/simple;
	bh=yi/WAt4FKeVEnwXWY1D8NLSIx9Oan8PLGgZu5Fa+NCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMqCX9r/MRZYjIkrbU8fewLbdM1rwuv5GTN/sIZgr8lmrBVX36dovyJK8/fUSYXMgopJNxobUkzyiU6dMAFrxbPt3DwPVpwFPwXKoFBqOzuTcUSxqrHBnucvN+sdcJAhIsLylvnkCmYENIpdK9l+DRzOxlUm9cC0IeP9AAuQabI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KJFOmmFJ; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URYSNiRJ8+KE+XS+04u15oXEUAz9xp+qiALCUkyjdkf9nI+Ap79SLwnhuZK04D81wmSCs/9JIr0uI1o53TJ7gPRcsRihm7GTtZZkJaDqXX9xq8KpJPoVaCSHCBPQKOqvVHtycT7B7nfeLkfcyivooyowW6Zyv8h9Z3As0kVDp9EWKupRACL/Npkgznt1KwvtDJSYuDgYuw707hj6Er/pdt0x/gHC3FryGAPIwj8g590bDs29uzUJVpsd2vzi01g9Meh6xbraPfh8aa87hnqLg2EbnNIRSTFezaJocekI0BA+BjVV/t2dNlaUbT4t0xTxU8nEid8wZpvp4bUZNHJ6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVui3GmxpBP9JDLQnPyA7x/QTjiKuC95ERIXJuNgd78=;
 b=l5MiTfSZoC78r2Of5tPQ465m7cbzQEFFRsZ3Dm0h9GAT/NaAgXSvvFnxCGOkNHxPCTjWgLj3jxba0RC+lEeHHAEwc+iYHbIUKdMdmmhvzWeosv1hBHZghfqxfk8TYm0BKi8t4Skxvyvnen57SocWPCXm23AMLS9sgkQ07mc9i17Sp9v/pjCRDMnPnuHZkI6EXShsxVHGOIOUhwBgCmCk5SUnxDQGoEqYhpTSGSLFjkaQIUqnA+gKjl5rK5X3VXSAOF09CW3taOg921n83GkTGB4d82RTVB6B9k8eOeZUJ9Z1B99lxzYl0PgAF8QWEMnJYaEMStVE7Gr5QfKwNxn+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVui3GmxpBP9JDLQnPyA7x/QTjiKuC95ERIXJuNgd78=;
 b=KJFOmmFJgW++IwMrFhIsKlyh1jFKKloT1s9rAGN86iGp9ub2o4ZBL+i/9MuN+Tn0D6SSmBp1TKwzqsu9lAo0u6VkuMJ3q45IAH6DpIvB7Y9F9GubBQwJENvvz/1yU4aHxxRmx9Fa8ucj1AZhJ3Nintg5JZc2Mh4czUaXjr/jmTmeAk90JhP3w7F5BiIS28c7YXS09H88nvEZPYSG/SsqxTgy23p1oaIVslSzfOBwWLM6P80vutzJ5Vdt+B/klt+j7oJqSgsUF/Qrv2Bv2+PydVklRtV/mA7vY9vAgUiyttya0gv1XKB3xbKdSyFTMNrC2I5rFG1Mjl+964IwQbYP/g==
Received: from BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::25)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:37:36 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::6e) by BN9P221CA0003.outlook.office365.com
 (2603:10b6:408:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 04/15] net/mlx5: Restrict domain list insertion to root TSAR ancestors
Date: Wed, 16 Oct 2024 20:36:06 +0300
Message-ID: <20241016173617.217736-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: e770b8d4-5beb-44ee-0df2-08dcee09393a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mOHxDtiTsyHBrNGtzfBW5dGg79P8naW+jfyV0ZVxQpWTkO2t6StvfK8XVmn1?=
 =?us-ascii?Q?ZlCNijmg0Nc2N9PrJelXTuH49k6+4WG7scZXLdBvt3RdTr9xzzPG/Lp93Odg?=
 =?us-ascii?Q?GHtRq5GxfKdG6GFT6SEWfcpBhJSuWQwZbqTr8V2fQ/5LmRjRHbKRD1wMBuds?=
 =?us-ascii?Q?Wq3XJc3qBED8k+JtR5VUAFs1WlSEoRnk9TPiYkAWeEDu6DTkVRAiqy9t2nNB?=
 =?us-ascii?Q?YNMU3ol5AOrxePBjiDjRc5ArxHkTwTRqzAbrawGq4j9TatuK/HIXTuakdnm6?=
 =?us-ascii?Q?aJlJ8dOZzlgaik2ZmKoj7o6TKbH0Yml/olphmvQyDTj04owGXB2tqkl7DYUO?=
 =?us-ascii?Q?IJ7/QLRYDhBDGZPmO5t/qV9iKbvCQNWzNXANgmc736ioVqIroYuiV1/1n8di?=
 =?us-ascii?Q?J5J7mCbncTmrcEJBPeYfTCnDYeWnnkmV4Mx6MpTJ4ujR2QD0FCs3oDAoeG6p?=
 =?us-ascii?Q?8D5rJUYGQGW5uaxBzFhBvHHH4IN5PjsYyehgQ8beqdf2uB/GyegOff0En6OY?=
 =?us-ascii?Q?Z2THvzEGAuUKWFECMM9uSvDXOJMoVDY0VIld6WIqdMQ1vFbC+UYXWHcZP04w?=
 =?us-ascii?Q?JxeEhhWkSz1wVDJLuLk+/+OHFuww0YWzk+rlAUNI9aiEpDHDGrIUw54pa+Tp?=
 =?us-ascii?Q?1Czz0fVl+nV5S6lSvD3TtlZwZhFe3/PEfWPAPh/p5TKITqN2UDHaytV0zh+p?=
 =?us-ascii?Q?yRITvpNI7DMMoQFKXzXA9YhWmWQRqvbkR7L8a7vPcCaXvcvyP+sRgbOM1OcB?=
 =?us-ascii?Q?NxFvAxLQrA/Iv+Ffx62Glffko1VzCG5iNKMuQmv75nqnltiMc1FzAXEA/PPS?=
 =?us-ascii?Q?XfgUtSuqQYZ7clZ453fcm7ojJCGqSHiZYyw3KriFIIST3VN3bKc6zzKF9RjC?=
 =?us-ascii?Q?Hs6d7QEfoMz6PC1L2wrehvNnXJ6lwEOu/SgwDElWMBxzDuBSE4p/s99q4vb4?=
 =?us-ascii?Q?Ahi0ZsYk+NukfXqmDmZuKG1fqjRG/8j/qny8yOaid6g+2e5nSSFclTsE0b00?=
 =?us-ascii?Q?/QturH3Z3RFaFp2OvaOR+LP90dPIYROScfgh2Z8YZrM6LwWfHZ/LvWhA/LL5?=
 =?us-ascii?Q?yLKomzF1ORwgwm7eFPcfcxUOtAe33lIH7eQnMrdlbM3/167UGnOLlZehzWgA?=
 =?us-ascii?Q?U7e9XNfadD85bRKR1WQBH27W1rGu6zsTYXY9vZH9BRIKSqAF4DcOPA6RmfHL?=
 =?us-ascii?Q?5GSEvAY5LMY0l9ChbVIIWXiLB2mozGd68zC2J1P8VfahYIDtGdb0DpMGFOBs?=
 =?us-ascii?Q?kEohi/0ITOKxeDy+bErhfacH5BboOGAPJOYV1afPVGpYffSDvzQDVhYrQPnX?=
 =?us-ascii?Q?ARMvY1vJhV35Iqs4aaY1N+KgqTk+NCjirrTVHoNOb1jJHF1CzCJ6ru3Egb4m?=
 =?us-ascii?Q?Jy4SU4I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:35.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e770b8d4-5beb-44ee-0df2-08dcee09393a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Carolina Jubran <cjubran@nvidia.com>

Update the logic for adding rate groups to the E-Switch domain list,
ensuring only groups with the root Transmit Scheduling Arbiter as their
parent are included.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index f2a0d59fa5bb..dd6fe729f456 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -511,6 +511,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_nod
 			   struct mlx5_esw_rate_group *parent)
 {
 	struct mlx5_esw_rate_group *group;
+	struct list_head *parent_list;
 
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	if (!group)
@@ -521,7 +522,9 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_nod
 	group->type = type;
 	group->parent = parent;
 	INIT_LIST_HEAD(&group->members);
-	list_add_tail(&group->parent_entry, &esw->qos.domain->groups);
+	parent_list = parent ? &parent->members : &esw->qos.domain->groups;
+	list_add_tail(&group->parent_entry, parent_list);
+
 	return group;
 }
 
-- 
2.44.0


