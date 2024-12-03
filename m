Return-Path: <netdev+bounces-148684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACBF9E2D91
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A2283DEC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04D207A01;
	Tue,  3 Dec 2024 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ym3yVMwt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C4C208990
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259040; cv=fail; b=Kmz+ACUWnZYKWaH/ByzMLV6xQAs/ZMqOVliYWw8vi+lQv1JhbzTT2m3UCF83E9QrTZ11vUEd+tTlViGGj70Y1Yov5KFb6HCsJ+KRKEBveWKrUlSQInMlgNEVojWm5lE9ncJcAf7hR9M0S+efX0QNjGC759KPCubEHEPih96VkYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259040; c=relaxed/simple;
	bh=Y7JEzGR6bYD0aIDyEgkpAGrh+SbgH3Jn3Q+HVBEC18o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pA9nfSuIX8vEbHs83JIR1bECo6RylOTjof12y5xS7fZyhpXV/hG//F2b2ydT9CwxRB8th7ZvhhffXsUjF7hgXeqp+rLF9t51GGwR1ZWdZtr4DFI22lxKUS5R/P8R3WsvQXFcgnWUdHPLcGoUdP5vRthxYtGClL40j9DtjtGfmJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ym3yVMwt; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d49WHBmHhUSsmUcHwOj+U2QxjbVsyxA9cAXasJzUON5T50S7uG/3rtOZaVR17DgY1f4sxECJ3WkgRKIWuPH5mRsuiaJk23kuASYQ8G9/oopFzzVIGqxyHoVqKNFWiTppWDAN5+xg0sNlBLt6VyzZhwEk8yLq7GCQhFwPeNlxhA1w8XUezFSl7VSB02bYqGvTZjs1LkIaBeuTKBhbJMeckWSUnUTeew69+qmvvkI8yvcqP2rNeSBMctvs+rbWs4gP7Yl9qo2P8NtD6oN2I5PQlrg45bld0GfBZpMnU24dVMlXRbeRPKXTzjepC22Rx/g60XGsP9jbNTfH7GTVuQZdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2hYZE3XR4sWs2wUxj5+HkyYOc0Lq8aSFErOBfB6C20=;
 b=VwU6pRm7/K0/nPHT8ipqHoL4Qyrs4oNQkwfbssVaZDttZs525PDHgFMLHJGgmy0dZVv6i4/3o6Pi/NTcwalSm8XsuFQ39Z2nna8ddEWvSWj220OQqq6dX8wh6o7taRXKja91/2GsCpV+dkZczI9XIzxNooGOPXAdqvZ1YEOtK4iInq+to5RlnHK/swOquEAndeB/+06kKH/TRG4xN5403mCBWhgCuIOHZSdHw2Vu2gX1NMAawjLpIXflO1mYELPyGu+yV8jWGizQQdkL5PQiaP+ymz1yBdCPkB/8/9TfnZL8RA+zkhD4A+zsMldioyZOjxYPgudn0F3K4deQGkXCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2hYZE3XR4sWs2wUxj5+HkyYOc0Lq8aSFErOBfB6C20=;
 b=Ym3yVMwtLZmH9F5JNgQGioKwjxjDubftKnEuu2KumdU/R9SKo/vCdaPVbFQpNrS9iDIbDwaHljou7U81F8CrtoNelIpWdJCUlZBFbuSrpap8q4qgKyI0g/nYd1K+iTZkqU6ZmVHEKI22tieIvV2xA9347M7THp3M1bydbDa699KLswI5+FMUAriP2cu15t2xCCS23+/0c8C6W6CiBsY2SoLzcIimvkYODjauIHTupvmGEKV5bKQXdgDbOxGiPPoDajkHHFUi1ttsUU2Q7mtXyQi29qYGya50SvpAWf23yciKfEtdLDzT9ojaIEXvkqlXUmOHTpEqm/W+AFCmjetWwg==
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:50:34 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::a9) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:50:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Frode Nordahl <frode.nordahl@canonical.com>, Chris Mi
	<cmi@nvidia.com>, Ariel Levkovich <lariel@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 6/6] net/mlx5e: Remove workaround to avoid syndrome for internal port
Date: Tue, 3 Dec 2024 22:49:20 +0200
Message-ID: <20241203204920.232744-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 4860085e-8109-4ebe-fc02-08dd13dc2192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Kqj9PvuvxcnF5oWwntdfC/gfv8OM7BNXSY1aEsYJZ5Nd80Eh8kfDwxLIGsc?=
 =?us-ascii?Q?D2ud+BmbNdiFa4LFxwXns8avE/nmeZd/RLYpnZVoZfE8ihWR+zHuLWlCsB2+?=
 =?us-ascii?Q?0KyBS4wbgZwOXuCXwmr7IIXmrWZIJIMkd+zjOkLE/4p5U2dv0kBN2XPCAZME?=
 =?us-ascii?Q?BAz6WJ7JNnLX6JPzNzOi7w6cUzr0uDEd/LoZyVs3aTPfDAxqoGfdZQA+iMlU?=
 =?us-ascii?Q?Oq3yvhnwZoa8SQvLy1l7iVQJixAhRc0TeMsJ6nKy/LDE+Nzm9pczBodsz5lN?=
 =?us-ascii?Q?/lvamPSvdyphN+/7bx6HvLKdmBb4PmhTHw76SKZLfmoMo5OHjRf4Y/qjvtj6?=
 =?us-ascii?Q?eyzfcn0jTvJT9RbxeezWn9D/AUP/UVbbUA64Odx8HpdEZB58EU/vFksUY+7f?=
 =?us-ascii?Q?pzLStnT3yN9TGxeDxYCPW5eKGBJz2DtMYtWInluB7QPuHdilBT/ObUvfokwj?=
 =?us-ascii?Q?knbtaYSpDLdlEJH8Tg2ojuySQEjA9ACKzJfPu0NbtLWl/twiZrwqqKP6lje4?=
 =?us-ascii?Q?QgABL++CngYPP4Dh/jjPvKTKpcuyF/OVYlkuMeOnOcFW9fW/Qf7x/m8s4upS?=
 =?us-ascii?Q?YNZoRmHUbTQQ4pPYUCVY84XvC0GJL7pFlSReT4TZfEeoMZx/Hcn84z3lKSDg?=
 =?us-ascii?Q?Y4T4R1Cc0gYEIQgPG1dY/GlEIZ/8oIWNeaO/aUps2xB6yH6Yaq+d4qcAsnwa?=
 =?us-ascii?Q?l7yZwAsZ/f7xsVjQSAZktPVIz8FBtdTzSKxtRG+0RkWfe59lpduettJat+7+?=
 =?us-ascii?Q?tXh/y/u7MJC6iYyS/Ssl2XFukNwLBhZUff5SwcBAn+qaRJiXEF8bkQxF6iRj?=
 =?us-ascii?Q?LHW0gPyxmYR2iH/yEaeQKXDx9d8dTYhYVutyICghiBmTSLut8y5RV/6IgKcj?=
 =?us-ascii?Q?MZJ+EItHAseKNL9fikxi46mixBz1EbzLyWQRx0DMs/EtS3m1XAkOUFbD+TC9?=
 =?us-ascii?Q?qDg4fdFCCGavW1jSN9VtoP6O05n/hHw+hZhxXtvgZ3IaE2CWyTJ6M8RjSI/c?=
 =?us-ascii?Q?M97UkFPX190+eceD4DD7HXm4s4VOXn0OUJHHflWne2usQWR16Rhs0KdkLHx2?=
 =?us-ascii?Q?UZnj/Y1wneYX2ZMYcAKpTk2xDfyu7iyMgRtvOkk+Z2c6PVixDFgIyxqw62cv?=
 =?us-ascii?Q?XDxcawKC/fETSKokquXlIs+49FsW0xAQNIV6BVL4dMuSJMBOQ+vroRETNcFn?=
 =?us-ascii?Q?ueiF54f8cholnf3QdmnoxnAQYVv7DZ76tMki4JLxoM/Abceim1bGo4wbQ1M+?=
 =?us-ascii?Q?gJ9hfm3t0WU75E4G2dyZecDGNEYEXf2WkZRE0ibRGYnsZIkhRT320iusz4kf?=
 =?us-ascii?Q?aED327LXi79cuBzKmceEU14TzKQYjyQRWX2htU0BxL0yG81bJ+h/xO1qcYeN?=
 =?us-ascii?Q?dwAnTce/azIQ/AaSfi6BaTpEWfgw+ZcBkd6ub2zVlHWdwozCMvCTwkRQ0iTi?=
 =?us-ascii?Q?oy/rMmgel9Rogvtg4o7QRN8C504LnJxV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:33.1157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4860085e-8109-4ebe-fc02-08dd13dc2192
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

From: Jianbo Liu <jianbol@nvidia.com>

Previously a workaround was added to avoid syndrome 0xcdb051. It is
triggered when offload a rule with tunnel encapsulation, and
forwarding to another table, but not matching on the internal port in
firmware steering mode. The original workaround skips internal tunnel
port logic, which is not correct as not all cases are considered. As
an example, if vlan is configured on the uplink port, traffic can't
pass because vlan header is not added with this workaround. Besides,
there is no such issue for software steering. So, this patch removes
that, and returns error directly if trying to offload such rule for
firmware steering.

Fixes: 06b4eac9c4be ("net/mlx5e: Don't offload internal port if filter device is out device")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Tested-by: Frode Nordahl <frode.nordahl@canonical.com>
Reviewed-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Ariel Levkovich <lariel@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c   | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 878cbdbf5ec8..e7e01f3298ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -5,6 +5,7 @@
 #include <net/nexthop.h>
 #include <net/ip_tunnels.h>
 #include "tc_tun_encap.h"
+#include "fs_core.h"
 #include "en_tc.h"
 #include "tc_tun.h"
 #include "rep/tc.h"
@@ -24,10 +25,18 @@ static int mlx5e_set_int_port_tunnel(struct mlx5e_priv *priv,
 
 	route_dev = dev_get_by_index(dev_net(e->out_dev), e->route_dev_ifindex);
 
-	if (!route_dev || !netif_is_ovs_master(route_dev) ||
-	    attr->parse_attr->filter_dev == e->out_dev)
+	if (!route_dev || !netif_is_ovs_master(route_dev))
 		goto out;
 
+	if (priv->mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS &&
+	    mlx5e_eswitch_uplink_rep(attr->parse_attr->filter_dev) &&
+	    (attr->esw_attr->dests[out_index].flags & MLX5_ESW_DEST_ENCAP)) {
+		mlx5_core_warn(priv->mdev,
+			       "Matching on external port with encap + fwd to table actions is not allowed for firmware steering\n");
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = mlx5e_set_fwd_to_int_port_actions(priv, attr, e->route_dev_ifindex,
 						MLX5E_TC_INT_PORT_EGRESS,
 						&attr->action, out_index);
-- 
2.44.0


