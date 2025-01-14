Return-Path: <netdev+bounces-158106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70024A10773
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896493A19A2
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A3236EDE;
	Tue, 14 Jan 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="enlTUEPy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3D236EB3
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860259; cv=fail; b=j8/+0n9JD3ZTB3Ot0R5AwYwpQgLkMjqzlpdPxjcTlCK93rRtGQVtlPscoCmw4NZ+QBA4BskVR8iwnzeQRO70DlWAlGxhvfkB7dvmmzio1NppvofkgoatT1R+5rDnszezREXW2PvRNxbtSaUc1rRZoiAojKo61vPAQYRitDU1SRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860259; c=relaxed/simple;
	bh=d1ivaxWT6ql2fIKOEfB4RQuwGL2cqURIaxvfW0a58fE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZEI1ySFLtHWceOAjvPKOdiBABcH9N/CMAajUSgEUgPG5emTjKnR223uGNcmyijsQF4XDJW5wQNXt1amDJdAsQFoGBicqN404BXSobIskL3ebrw2L+WMyLJaN49DOnnCLTeZlMcj8Ci71RFQQ/6hG5XMxU27P72ecZTCnVF7ifk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=enlTUEPy; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmPgl0VySAmiXQ2oghM2g3db6LokSCsvDFU3v+v3Dtzc9bNz+mw1yins35A0hvAzHbvXon7T5f+fnsFm40/nJ+458RSL+tDCFYSoD1QdL+JIu7ivLq8XAJ4djWiKI0lem9Bcy7d6/i/7+HFiwX+lEstL3aOhoG42e1A1QDjhiAkmqo8vYcOviLtcuWzsE7RED3QUMSzmiuupFqM7uI7o+63zgsuUscBGR5tCOjQTMnTNAbfR1dyUYRUGdNhJYeRC9SGndDlFpjdZnFith7+OGpliBvurOS9BjOMlQQCI7L29rVECoJL6r5jl/uu2hg31pRJevvivD1WckYbvyiLnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Cvi4zi+3bZt8HCbuua0awiw/mkPbsRY64wapDhKyQ=;
 b=vGnj619uTzE/CiqX/ctpf8t28mb6AQpcRZvPnS4yduG8Il+tIc+MGLpQN4r/s3nuVhTDPHuXVzDnuhKDxZfqi0LKnLKZEkNPcPzbRIJW6eWLFRmtz/JTGHItDu2H9jtc+BeLahT4CXtSvhTk1LytEXT+z0oah5FttruMqVq3rUlxwGLQjbmB4ugJJDPi0Pf76meA+kY6cngoRNbhARBpHfQgyIKwk+HoKWMIxQLu+cCh8GLF1muLoTMsCbjskFjSB/VFgDk3qOmPzsmKMEsu2ACjF9j1ZLenXjkRlFYRcpVamQcMTDi6n6iACNQn3Vu04l6nuVwQCOjbBK438AkIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Cvi4zi+3bZt8HCbuua0awiw/mkPbsRY64wapDhKyQ=;
 b=enlTUEPy2Az7X+unwwx3uvleOvW9G/s+/nf7q3mybectXeGUoW2os7r+DPCGSZqcWqjOlXWcZweH4fbCVMC8GfCUpvXhOe8nrFvC5k2lxUkQ2UpeG23uiJ0/sBtkvFRYXWpfaOYE+ig5YQD5984eB/rCPWIla4+3cf9nvia7cwCCXy6DPlGiaBDw2WiuF1i110Td+wJ/9H75ky2bLgtWwNO/rQeH45LSplAP4oXJc7mVm/oHUnqg3BvyY/nYws6SOoWdwo/2H/Nt0WapLrz1XR0xpOfkka9IHXSDuWtvuoi1b3acevnba2SKaiKZWdxPhGUn5qIGJECyJNgcZQFmMw==
Received: from MW2PR2101CA0032.namprd21.prod.outlook.com (2603:10b6:302:1::45)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 13:10:53 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::fb) by MW2PR2101CA0032.outlook.office365.com
 (2603:10b6:302:1::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.5 via Frontend Transport; Tue,
 14 Jan 2025 13:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 13:10:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:41 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 05:10:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 14 Jan
 2025 05:10:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 4/4] net/mlx5e: CT: Offload connections with hardware steering rules
Date: Tue, 14 Jan 2025 15:06:46 +0200
Message-ID: <20250114130646.1937192-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250114130646.1937192-1-tariqt@nvidia.com>
References: <20250114130646.1937192-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee93616-db3e-4340-07ad-08dd349cdf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?II1dOp4hWlBiQvFHacnzvE6lYo7OTGNcpjvX2XjI+pm0Jb9dznRYE2cYZ6Sy?=
 =?us-ascii?Q?8el8fLSScKxGsnsiHA9H0JgW0JB+5FOr+IHy0kulnpU0GCEnewcYMimpCWgl?=
 =?us-ascii?Q?tO1m6nnPuH14nS7DFIiIXKHbu+H5WKB2L6UqAYh338c5tIDZzk6ONa9mUSEB?=
 =?us-ascii?Q?o/wDaYC0n2ne6dNDaTo+RJTB+ouqamWuoj08s00yshPbs1dxYIhb1xef4XTG?=
 =?us-ascii?Q?2PkUXT3ioDpSsF3cGyVDufTkjEgQvtBLocjd+sFY8AqM+aYe3KyZKbDw8ydE?=
 =?us-ascii?Q?JVBuzQpB6V2IHw0G2Vy4iiJCXU/wXjFX0kw0x3y6sR9WjFoWtUjStZvrsrWR?=
 =?us-ascii?Q?GX/zHr4y3COL7E+O5eZLwInRR7z6LR/WilcwpMWn/jMawJ5uT+rMC+bsHjhg?=
 =?us-ascii?Q?sYB4fxZNVyaD+NYsh/ShN6k06yS/UEoAmYZVRE8X+Pv7+N1yBgvlKu9Hb1Pz?=
 =?us-ascii?Q?1lnWxLgGk+esfNptzvjoa+Z/vJ/xH5PjqYWJ80qcTwC9W8JCZAGwpLzDxMCn?=
 =?us-ascii?Q?KE8zAno4CLLWTpkgim3EXGFxJU+lxS0g1eOy0Tzfe0yArATCIHfC8cXIlFGB?=
 =?us-ascii?Q?TdUi6Pa3C0ix83dJRsKpIXt/jpz2JTTudcw7pddqpuSCyCFoqfEfZa9eP3dA?=
 =?us-ascii?Q?yhauKnwAsfvR6tTlzy1+k7vf2jp6ybx/Lvaxhag/u2igCYECHoYdn13gnpL2?=
 =?us-ascii?Q?/XQV9JK4Rh+A8pg4RfcjskiEKIhlBadLfqq69HuHVxvXwM/Gvs3LAOtD9vgs?=
 =?us-ascii?Q?JxPWhrnoE49/C4aQtjMby5f5nlSPaNF4o/tQ1X6VbMofYWrWN7zRrh9y+otK?=
 =?us-ascii?Q?2oHMwU7MQlGRk9SSia9PR3Oem/CKkMX06bBEjUnvzSx6oZLLVK4XNgsreA8f?=
 =?us-ascii?Q?K9gjtUAsuadxq5ObxqptYx0GROHBEshlxywhPq9VHIanZqwu9Fkw0TvxkkRA?=
 =?us-ascii?Q?aE2mYYXrYgcUwZqLf+POIUmP5a9A9KFhWb3rPUQu15aELmPZ4Z30jQ/kPRnz?=
 =?us-ascii?Q?JTiBB+wFE48TvxvQMWXDt64bJfgSd4xr8fJpJlSVC2hbAXmPO9401ccPsXzV?=
 =?us-ascii?Q?EW+5dDOob0eutDz71SJsYBFgccK2LI45aQ2GvDgfceNKIVl6h6LWt7EorTCK?=
 =?us-ascii?Q?9yPw8vRjrDaE2ruxUp2BAUE/K8A/jGwQojttiHKk59a4AdlT36/IKfcSU6X5?=
 =?us-ascii?Q?Tr1zSLS6+ejGt5I2r5/h7oh6CAAGIvg5knatKRTUrgDxPzddsUF7ED9Mzia/?=
 =?us-ascii?Q?O/Q7rAYUY1v+q125zT481D7+o07WBuNqQI6ukE/Gxq3WzoewOC7D4WcU0BrW?=
 =?us-ascii?Q?KXbY8Q/BImuZp6NNexStJFDBkfxPvXE1YQ8uBUQp6sIO+eemaEeLKAz3gVAw?=
 =?us-ascii?Q?0otK63xB31patl2Bp0VW+WFXrU2Etqom5z+txYIduMr2DCVoU3PbsVFE9xom?=
 =?us-ascii?Q?xmSKKfUf/0fE3ygG/FSNQq4edqXzVenvX4czgKWAzYxICsoXNZo9M73OMbok?=
 =?us-ascii?Q?n4FUWKkowQZxQCg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:10:52.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee93616-db3e-4340-07ad-08dd349cdf9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

From: Cosmin Ratiu <cratiu@nvidia.com>

This is modeled similar to how software steering works:
- a reference-counted matcher is maintained for each
  combination of nat/no_nat x ipv4/ipv6 x tcp/udp/gre.
- adding a rule involves finding+referencing or creating a corresponding
  matcher, then actually adding a rule.
- updating rules is implemented using the bwc_rule update API, which can
  change a rule's actions without touching the match value.

By using a T-Rex traffic generator to initiate multi-million UDP flows
per second, a kernel running with these patches on the RX side was able
to offload ~600K flows per second, which is about ~7x larger than what
software steering could do on the same hardware (256-thread AMD EPYC,
512 GB RAM, ConnectX-7 b2b).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     | 249 +++++++++++++++++-
 1 file changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
index be1a36d1d778..a4263137fef5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
@@ -3,33 +3,276 @@
 
 #include "en_tc.h"
 #include "en/tc_ct.h"
+#include "en/tc_priv.h"
 #include "en/tc/ct_fs.h"
+#include "fs_core.h"
+#include "steering/hws/fs_hws_pools.h"
+#include "steering/hws/mlx5hws.h"
+#include "steering/hws/table.h"
+
+struct mlx5_ct_fs_hmfs_matcher {
+	struct mlx5hws_bwc_matcher *hws_bwc_matcher;
+	refcount_t ref;
+};
+
+/* We need {ipv4, ipv6} x {tcp, udp, gre}  matchers. */
+#define NUM_MATCHERS (2 * 3)
+
+struct mlx5_ct_fs_hmfs {
+	struct mlx5hws_table *ct_tbl;
+	struct mlx5hws_table *ct_nat_tbl;
+	struct mlx5_flow_table *ct_nat;
+	struct mlx5hws_action *fwd_action;
+	struct mlx5hws_action *last_action;
+	struct mlx5hws_context *ctx;
+	struct mutex lock;   /* Guards matchers */
+	struct mlx5_ct_fs_hmfs_matcher matchers[NUM_MATCHERS];
+	struct mlx5_ct_fs_hmfs_matcher matchers_nat[NUM_MATCHERS];
+};
+
+struct mlx5_ct_fs_hmfs_rule {
+	struct mlx5_ct_fs_rule fs_rule;
+	struct mlx5hws_bwc_rule *hws_bwc_rule;
+	struct mlx5_ct_fs_hmfs_matcher *hmfs_matcher;
+	struct mlx5_fc *counter;
+};
+
+static u32 get_matcher_idx(bool ipv4, bool tcp, bool gre)
+{
+	return ipv4 * 3 + tcp * 2 + gre;
+}
 
 static int mlx5_ct_fs_hmfs_init(struct mlx5_ct_fs *fs, struct mlx5_flow_table *ct,
 				struct mlx5_flow_table *ct_nat, struct mlx5_flow_table *post_ct)
 {
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5hws_table *ct_tbl, *ct_nat_tbl, *post_ct_tbl;
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+
+	ct_tbl = ct->fs_hws_table.hws_table;
+	ct_nat_tbl = ct_nat->fs_hws_table.hws_table;
+	post_ct_tbl = post_ct->fs_hws_table.hws_table;
+	fs_hmfs->ct_nat = ct_nat;
+
+	if (!ct_tbl || !ct_nat_tbl || !post_ct_tbl) {
+		netdev_warn(fs->netdev, "ct_fs_hmfs: failed to init, missing backing hws tables");
+		return -EOPNOTSUPP;
+	}
+
+	netdev_dbg(fs->netdev, "using hmfs steering");
+
+	fs_hmfs->ct_tbl = ct_tbl;
+	fs_hmfs->ct_nat_tbl = ct_nat_tbl;
+	fs_hmfs->ctx = ct_tbl->ctx;
+	mutex_init(&fs_hmfs->lock);
+
+	fs_hmfs->fwd_action = mlx5hws_action_create_dest_table(ct_tbl->ctx, post_ct_tbl, flags);
+	if (!fs_hmfs->fwd_action) {
+		netdev_warn(fs->netdev, "ct_fs_hmfs: failed to create fwd action\n");
+		return -EINVAL;
+	}
+	fs_hmfs->last_action = mlx5hws_action_create_last(ct_tbl->ctx, flags);
+	if (!fs_hmfs->last_action) {
+		netdev_warn(fs->netdev, "ct_fs_hmfs: failed to create last action\n");
+		mlx5hws_action_destroy(fs_hmfs->fwd_action);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
 static void mlx5_ct_fs_hmfs_destroy(struct mlx5_ct_fs *fs)
 {
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+
+	mlx5hws_action_destroy(fs_hmfs->last_action);
+	mlx5hws_action_destroy(fs_hmfs->fwd_action);
+}
+
+static struct mlx5hws_bwc_matcher *
+mlx5_ct_fs_hmfs_matcher_create(struct mlx5_ct_fs *fs, struct mlx5hws_table *tbl,
+			       struct mlx5_flow_spec *spec, bool ipv4, bool tcp, bool gre)
+{
+	u8 match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2 | MLX5_MATCH_OUTER_HEADERS;
+	struct mlx5hws_match_parameters mask = {
+		.match_buf = spec->match_criteria,
+		.match_sz = sizeof(spec->match_criteria),
+	};
+	u32 priority = get_matcher_idx(ipv4, tcp, gre);  /* Static priority based on params. */
+	struct mlx5hws_bwc_matcher *hws_bwc_matcher;
+
+	hws_bwc_matcher = mlx5hws_bwc_matcher_create(tbl, priority, match_criteria_enable, &mask);
+	if (!hws_bwc_matcher)
+		return ERR_PTR(-EINVAL);
+
+	return hws_bwc_matcher;
+}
+
+static struct mlx5_ct_fs_hmfs_matcher *
+mlx5_ct_fs_hmfs_matcher_get(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
+			    bool nat, bool ipv4, bool tcp, bool gre)
+{
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+	u32 matcher_idx = get_matcher_idx(ipv4, tcp, gre);
+	struct mlx5_ct_fs_hmfs_matcher *hmfs_matcher;
+	struct mlx5hws_bwc_matcher *hws_bwc_matcher;
+	struct mlx5hws_table *tbl;
+
+	hmfs_matcher = nat ?
+		(fs_hmfs->matchers_nat + matcher_idx) :
+		(fs_hmfs->matchers + matcher_idx);
+
+	if (refcount_inc_not_zero(&hmfs_matcher->ref))
+		return hmfs_matcher;
+
+	mutex_lock(&fs_hmfs->lock);
+
+	/* Retry with lock, as the matcher might be already created by another cpu. */
+	if (refcount_inc_not_zero(&hmfs_matcher->ref))
+		goto out_unlock;
+
+	tbl = nat ? fs_hmfs->ct_nat_tbl : fs_hmfs->ct_tbl;
+
+	hws_bwc_matcher = mlx5_ct_fs_hmfs_matcher_create(fs, tbl, spec, ipv4, tcp, gre);
+	if (IS_ERR(hws_bwc_matcher)) {
+		netdev_warn(fs->netdev,
+			    "ct_fs_hmfs: failed to create bwc matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %ld\n",
+			    nat, ipv4, tcp, gre, PTR_ERR(hws_bwc_matcher));
+
+		hmfs_matcher = ERR_CAST(hws_bwc_matcher);
+		goto out_unlock;
+	}
+
+	hmfs_matcher->hws_bwc_matcher = hws_bwc_matcher;
+	refcount_set(&hmfs_matcher->ref, 1);
+
+out_unlock:
+	mutex_unlock(&fs_hmfs->lock);
+	return hmfs_matcher;
+}
+
+static void
+mlx5_ct_fs_hmfs_matcher_put(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_hmfs_matcher *hmfs_matcher)
+{
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+
+	if (!refcount_dec_and_mutex_lock(&hmfs_matcher->ref, &fs_hmfs->lock))
+		return;
+
+	mlx5hws_bwc_matcher_destroy(hmfs_matcher->hws_bwc_matcher);
+	mutex_unlock(&fs_hmfs->lock);
+}
+
+#define NUM_CT_HMFS_RULES 4
+
+static void mlx5_ct_fs_hmfs_fill_rule_actions(struct mlx5_ct_fs_hmfs *fs_hmfs,
+					      struct mlx5_flow_attr *attr,
+					      struct mlx5hws_rule_action *rule_actions)
+{
+	struct mlx5_fs_hws_action *mh_action = &attr->modify_hdr->fs_hws_action;
+
+	memset(rule_actions, 0, NUM_CT_HMFS_RULES * sizeof(*rule_actions));
+	rule_actions[0].action = mlx5_fc_get_hws_action(fs_hmfs->ctx, attr->counter);
+	/* Modify header is special, it may require extra arguments outside the action itself. */
+	if (mh_action->mh_data) {
+		rule_actions[1].modify_header.offset = mh_action->mh_data->offset;
+		rule_actions[1].modify_header.data = mh_action->mh_data->data;
+	}
+	rule_actions[1].action = mh_action->hws_action;
+	rule_actions[2].action = fs_hmfs->fwd_action;
+	rule_actions[3].action = fs_hmfs->last_action;
 }
 
 static struct mlx5_ct_fs_rule *
 mlx5_ct_fs_hmfs_ct_rule_add(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 			    struct mlx5_flow_attr *attr, struct flow_rule *flow_rule)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	struct mlx5hws_rule_action rule_actions[NUM_CT_HMFS_RULES];
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+	struct mlx5hws_match_parameters match_params = {
+		.match_buf = spec->match_value,
+		.match_sz = ARRAY_SIZE(spec->match_value),
+	};
+	struct mlx5_ct_fs_hmfs_matcher *hmfs_matcher;
+	struct mlx5_ct_fs_hmfs_rule *hmfs_rule;
+	bool nat, tcp, ipv4, gre;
+	int err;
+
+	if (!mlx5e_tc_ct_is_valid_flow_rule(fs->netdev, flow_rule))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	hmfs_rule = kzalloc(sizeof(*hmfs_rule), GFP_KERNEL);
+	if (!hmfs_rule)
+		return ERR_PTR(-ENOMEM);
+
+	nat = (attr->ft == fs_hmfs->ct_nat);
+	ipv4 = mlx5e_tc_get_ip_version(spec, true) == 4;
+	tcp = MLX5_GET(fte_match_param, spec->match_value,
+		       outer_headers.ip_protocol) == IPPROTO_TCP;
+	gre = MLX5_GET(fte_match_param, spec->match_value,
+		       outer_headers.ip_protocol) == IPPROTO_GRE;
+
+	hmfs_matcher = mlx5_ct_fs_hmfs_matcher_get(fs, spec, nat, ipv4, tcp, gre);
+	if (IS_ERR(hmfs_matcher)) {
+		err = PTR_ERR(hmfs_matcher);
+		goto err_free_rule;
+	}
+	hmfs_rule->hmfs_matcher = hmfs_matcher;
+
+	mlx5_ct_fs_hmfs_fill_rule_actions(fs_hmfs, attr, rule_actions);
+	hmfs_rule->counter = attr->counter;
+
+	hmfs_rule->hws_bwc_rule =
+		mlx5hws_bwc_rule_create(hmfs_matcher->hws_bwc_matcher, &match_params,
+					spec->flow_context.flow_source, rule_actions);
+	if (!hmfs_rule->hws_bwc_rule) {
+		err = -EINVAL;
+		goto err_put_matcher;
+	}
+
+	return &hmfs_rule->fs_rule;
+
+err_put_matcher:
+	mlx5_fc_put_hws_action(hmfs_rule->counter);
+	mlx5_ct_fs_hmfs_matcher_put(fs, hmfs_matcher);
+err_free_rule:
+	kfree(hmfs_rule);
+	return ERR_PTR(err);
 }
 
 static void mlx5_ct_fs_hmfs_ct_rule_del(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule)
 {
+	struct mlx5_ct_fs_hmfs_rule *hmfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_hmfs_rule,
+							      fs_rule);
+	mlx5hws_bwc_rule_destroy(hmfs_rule->hws_bwc_rule);
+	mlx5_fc_put_hws_action(hmfs_rule->counter);
+	mlx5_ct_fs_hmfs_matcher_put(fs, hmfs_rule->hmfs_matcher);
+	kfree(hmfs_rule);
 }
 
 static int mlx5_ct_fs_hmfs_ct_rule_update(struct mlx5_ct_fs *fs, struct mlx5_ct_fs_rule *fs_rule,
 					  struct mlx5_flow_spec *spec, struct mlx5_flow_attr *attr)
 {
-	return -EOPNOTSUPP;
+	struct mlx5_ct_fs_hmfs_rule *hmfs_rule = container_of(fs_rule,
+							      struct mlx5_ct_fs_hmfs_rule,
+							      fs_rule);
+	struct mlx5hws_rule_action rule_actions[NUM_CT_HMFS_RULES];
+	struct mlx5_ct_fs_hmfs *fs_hmfs = mlx5_ct_fs_priv(fs);
+	int err;
+
+	mlx5_ct_fs_hmfs_fill_rule_actions(fs_hmfs, attr, rule_actions);
+
+	err = mlx5hws_bwc_rule_action_update(hmfs_rule->hws_bwc_rule, rule_actions);
+	if (err) {
+		mlx5_fc_put_hws_action(attr->counter);
+		return err;
+	}
+
+	mlx5_fc_put_hws_action(hmfs_rule->counter);
+	hmfs_rule->counter = attr->counter;
+
+	return 0;
 }
 
 static struct mlx5_ct_fs_ops hmfs_ops = {
@@ -39,6 +282,8 @@ static struct mlx5_ct_fs_ops hmfs_ops = {
 
 	.init = mlx5_ct_fs_hmfs_init,
 	.destroy = mlx5_ct_fs_hmfs_destroy,
+
+	.priv_size = sizeof(struct mlx5_ct_fs_hmfs),
 };
 
 struct mlx5_ct_fs_ops *mlx5_ct_fs_hmfs_ops_get(void)
-- 
2.45.0


