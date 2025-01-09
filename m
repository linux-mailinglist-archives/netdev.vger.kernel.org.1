Return-Path: <netdev+bounces-156772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4D0A07CEF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379D4188CD54
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB33222256C;
	Thu,  9 Jan 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/f0ZVTn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A322069F
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438886; cv=fail; b=H3ta75Cy2HGOqnt0qcEy/5CwpV89vADskqFkb8lxlXph/saE3/zHQSUkASOygz8Ahdcw2ONCf97lfxtIVWBdLTTCgt2uI3FHOBcWsx1uRayw9Uf2NKdGZ6k3rs/UTS87bs7U6wsqW+p3zeSgo+5Qfu+4Pe4ik5WQW/4XahFCYf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438886; c=relaxed/simple;
	bh=qndlnd4Rr86f+YhvixDxC+DdlauK9bcKh97qYMbpl/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyktW7awODQP8lWXqnY0Df76XyPqmxrUMX7ziTY4k5DjNK5IQszyIvGGRMmYjHih8gpwmV7PCHU4osXLmmLPb8OG56MaHRN97Xc80j0ed/Hj9Jx+E8Mz+vectwUY7eJCwHE54ZkKemBLt3sHqxPhJspF+iJR5MA8gK/GIfFv1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/f0ZVTn; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz/qfZZ9t2AjzYxB+sH/ozlj81Z/AiN1j6U6KPbPeFEN5shDybFHzW7hgWWiq8q+FHLDCoY7hIgurfE9lBAm22ynZMzW6XD/rA4vTZ4XJxnFdtTo0WFl9J0ZTrrbvoGmFnFr3DtHUHv6cZFc8iyGgy0zCz5KsXU4LWmGQXsVj+XVV8fLVPid8/efhDBinQi/tY/x0NQRuju8FoCWIti006XAuE3Hkg80e/ngnDGeHpO1hTLoJLMpmbEB+OvxfUh7vEgjY1C6cOX6/RwtTtEHMH2FLojjybzcbhw2qWi6ylvJ2g8NR+3hBm5B4IGwWozI/9psZ9MtCO6h3R2H11XozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFup79IpciqzqQD6IUaufWAUmDav2NuCJIeEr5y+Mh4=;
 b=kI6BHjqBvwR/F3TWqQCj+QQeGRUDwic5uuzKJuY68BW6ru+uxQmAubWVSiCvz3yQDfj7++A6CErhRIQJ+Dd4Z8T641not8AUVUCXDlsaYIQFOjJ4ZRbxzcvPtqyTVzDPCPdF/IKgxxBlZgEFfNPzc9eyZAJfVDtpPl9uf9hCntyrGZ/eTlq2IsGE2Pk5/VmxuI4yh7svI44EEm9DfIuBMFih26WjGb+2PuimCCLdr8u9CQWnwuZnVHaH/SXKd3Oh5bUq0jRI77yXLpYgjUXYdd7Mi6kVGJ8St1VqFCFWrtllr2nWyLZHUudIFGdEhQIeQZ+OWh3qC4uSWRfh3MMUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFup79IpciqzqQD6IUaufWAUmDav2NuCJIeEr5y+Mh4=;
 b=E/f0ZVTnGH9WVPYAEymkZpNVwfjz9EuMBsXxYwttg/shF1CSdJRCzjXG1wde0JQlfH1lKm00sRqos6/xqCbUh5R8otEJp0r0JBn4ZipKEc0pRD9fp2oqxeW+kjm11SBTIa1HRzdagdCL9fxGmUo326eXywaBhBu+X0lWWwNaqTEFrKn/4ehEo8NilwabtZhSkJ7PDqSU+hz2W+RPiU8zhvlfo2sFKKzLPTKAtrrb9KpW7IOj0IjKRe6vK4GHLLwMjbOI6K45blp5MzsVnF0t5uyqmEvxiKcUKg1a7IbtN3RxjsMer9kNI7kpnJGwcfTEnzObpsD0nrvNoUNBNeib1w==
Received: from DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:08:00 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::1e) by DM6PR11CA0031.outlook.office365.com
 (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:48 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:44 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 15/15] net/mlx5: HWS, update flow - support through bigger action RTC
Date: Thu, 9 Jan 2025 18:05:46 +0200
Message-ID: <20250109160546.1733647-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c12ca6f-0e9c-47c8-d09d-08dd30c7c9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BWablo7MgHtCSUKtqYFFJXsJ/JqrQnyKs9g5TTd1xwg6xpAMhTh0Xhi1cS5h?=
 =?us-ascii?Q?DKhV+DVMZs9WSfV0OppvkB2egkkqs3IWZvWG4UVdL7Xke+e7q1MrNfyr2H/E?=
 =?us-ascii?Q?uWgA5FVmMB6IWXZFRyGvdfLevEnUdSpbCa3EdJOMtXPMMLv9shkYlLgMP6+H?=
 =?us-ascii?Q?LsYqqKSyOu2CZRWJJGY4zOf2Tkk8Mp7PFvqt3We1m8jk4kEyqE+7QRjCubtL?=
 =?us-ascii?Q?Y9HFxhnspWlzHWCCVhKXOgDX5FsNADhUwzPkmT1lawF2KcAcEcnj5yWqUguW?=
 =?us-ascii?Q?ui4ZCxYM0qDM8eL2VLmeNNENYfDroL7ktSrIHRXmqhXCpR7wfkfM1loLYOyl?=
 =?us-ascii?Q?eHXthjwP3+557nz64zVe3Y/eyo6PljDjQGV7vFCwgmKU2Jxuts02UFCFRFRN?=
 =?us-ascii?Q?QALT1KDxWrZv3GqrDpO8OgW5eVsmuhf8e8lZRt0pRZ8XjJ26RqIaefKr7nOv?=
 =?us-ascii?Q?cayqtFaEAeygq1rgGCOCRQ7jd02bmPfyBbDyLNKsJ2pDNgJ+LOcVWCA0nezS?=
 =?us-ascii?Q?bWTz68ixsX0zOgCtXpjQUMv7TQ1KL3gs2GIlkJpN0gZdmOKzc2+qdtLWPY1H?=
 =?us-ascii?Q?Dc7o4lsE+A/nAM810925k3FkvQ5VhcXWHGkG8Qx5thV7mZRlyAdu9JaSlolb?=
 =?us-ascii?Q?OGsiSzBBENPl8qSYf+0pYxQ7xSZ6F/BXAh7CnAvZDHZxsltFgNceEcDKEri2?=
 =?us-ascii?Q?K5A0SHR7S+NOjd/u4hBvsesz+QJ6dvGxtiF52oVyyGqyu9bqIOFNJgfB45F7?=
 =?us-ascii?Q?zpt46U8V/QRahOmdNu51Sw5LMX2EY9EcJOv6qgzzCXkjq90dtGbzCIweYu6/?=
 =?us-ascii?Q?YYpz57kWQMuGWdOp1coBeGn6KUfscJ2XCjN1buuCBpAbyxB13d9fFYJlR2/k?=
 =?us-ascii?Q?Q1iUZOSSUuiRnXSOrrVmGrs4XawpnFasTKsJjLmoHiOPMOpV3SEKaGFgswbh?=
 =?us-ascii?Q?2hXox84RJ7LkSawcmMrjzXvYoS8UffGWX9Y6pl8aeDyYQN5Tw31CEgrtX66n?=
 =?us-ascii?Q?VyMl95cqdkmuW33KQiBPWADSCPJT96vMyaeT0xI3baiozeptByulDMv36jQX?=
 =?us-ascii?Q?kN4/R9dxTUIYULfeNCMXNHox8aTFoYvJqto9KsmwJtY8xDJJVwgAbcBeczaL?=
 =?us-ascii?Q?fKALBl9a8u9ga7ganbVVgBNy96CEa6r2Bgt/Hbjld9VPbLh/nfZbeNX+w5+0?=
 =?us-ascii?Q?KKZqtJMleDvQ5uNsXhYkzfxhopx1ayExGkXD7mX+jXm32aag1pOj/lsxZ7KY?=
 =?us-ascii?Q?k1SbGvrF6MrcJvkACi9wouASZWGgnVKWMI9Tv7+Obnh/zCA25XOpq6CnrV6g?=
 =?us-ascii?Q?D4bb/7gupPlrJ/5DaojJ4HzuywqCu6IKcdnRJNYlhHOhGeOLYWP2P/F1J0Hv?=
 =?us-ascii?Q?oRpiqLuO5EmFjYvyuJ8+DG093tLbLyYtHBM+2fbvCNYQHBWPRiM1Ha7j3FAN?=
 =?us-ascii?Q?x2zTSoqbZWZBUCdymXmkr44jhxks32XJZEecMZx0xxkaoqgZEb1ULCDBUtMn?=
 =?us-ascii?Q?mrclAg+0CflQcCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:59.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12ca6f-0e9c-47c8-d09d-08dd30c7c9bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

This patch is the second part of update flow implementation.

Instead of using two action RTCs, we use the same RTC which is twice
the size of what was required before the update flow support.
This way we always allocate STEs from the same RTC (same pool),
which means that update is done similar to how create is done.
The bigger size allows us to allocate and write new STEs, and
later free the old (pre-update) STEs.

Similar to rule creation, STEs are written in reverse order:
 - write action STEs, while match STE is still pointing to
   the old action STEs
 - overwrite the match STE with the new one, which now
   is pointing to the new action STEs

Old action STEs can be freed only once we got completion on the
writing of the new match STE. To implement this we added new rule
states: UPDATING/UPDATED. Rule is moved to UPDATING state in the
beginning of the update flow. Once all completions are received,
rule is moved to UPDATED state. At this point old action STEs are
freed and rule goes back to CREATED state.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/matcher.c | 10 ++-
 .../mellanox/mlx5/core/steering/hws/rule.c    | 88 ++++++++++---------
 .../mellanox/mlx5/core/steering/hws/rule.h    | 15 +++-
 .../mellanox/mlx5/core/steering/hws/send.c    | 20 +++--
 4 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 74a03fbabcf7..80157a29a076 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -283,8 +283,13 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_1_id = &action_ste->rtc_1_id;
 		ste_pool = action_ste->pool;
 		ste = &action_ste->ste;
+		/* Action RTC size calculation:
+		 * log((max number of rules in matcher) *
+		 *     (max number of action STEs per rule) *
+		 *     (2 to support writing new STEs for update rule))
+		 */
 		ste->order = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-			     attr->table.sz_row_log;
+			     attr->table.sz_row_log + 1;
 		rtc_attr.log_size = ste->order;
 		rtc_attr.log_depth = 0;
 		rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
@@ -554,8 +559,9 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 	pool_attr.table_type = tbl->type;
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
 	pool_attr.flags = MLX5HWS_POOL_FLAGS_FOR_STE_ACTION_POOL;
+	/* Pool size is similar to action RTC size */
 	pool_attr.alloc_log_sz = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-				 matcher->attr.table.sz_row_log;
+				 matcher->attr.table.sz_row_log + 1;
 	hws_matcher_set_pool_attr(&pool_attr, matcher);
 	action_ste->pool = mlx5hws_pool_create(ctx, &pool_attr);
 	if (!action_ste->pool) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 699a73ed2fd7..a27a2d5ffc7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -129,22 +129,18 @@ static void hws_rule_gen_comp(struct mlx5hws_send_engine *queue,
 
 static void
 hws_rule_save_resize_info(struct mlx5hws_rule *rule,
-			  struct mlx5hws_send_ste_attr *ste_attr,
-			  bool is_update)
+			  struct mlx5hws_send_ste_attr *ste_attr)
 {
 	if (!mlx5hws_matcher_is_resizable(rule->matcher))
 		return;
 
-	if (likely(!is_update)) {
+	/* resize_info might already exist (if we're in update flow) */
+	if (likely(!rule->resize_info)) {
 		rule->resize_info = kzalloc(sizeof(*rule->resize_info), GFP_KERNEL);
 		if (unlikely(!rule->resize_info)) {
 			pr_warn("HWS: resize info isn't allocated for rule\n");
 			return;
 		}
-
-		rule->resize_info->max_stes = rule->matcher->action_ste.max_stes;
-		rule->resize_info->action_ste_pool = rule->matcher->action_ste.max_stes ?
-						     rule->matcher->action_ste.pool : NULL;
 	}
 
 	memcpy(rule->resize_info->ctrl_seg, ste_attr->wqe_ctrl,
@@ -199,8 +195,7 @@ hws_rule_load_delete_info(struct mlx5hws_rule *rule,
 	}
 }
 
-static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
-				     struct mlx5hws_rule_attr *attr)
+static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule)
 {
 	struct mlx5hws_matcher *matcher = rule->matcher;
 	struct mlx5hws_matcher_action_ste *action_ste;
@@ -215,32 +210,29 @@ static int hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
 			    "Failed to allocate STE for rule actions");
 		return ret;
 	}
-	rule->action_ste_idx = ste.offset;
+
+	rule->action_ste.pool = matcher->action_ste.pool;
+	rule->action_ste.num_stes = matcher->action_ste.max_stes;
+	rule->action_ste.index = ste.offset;
 
 	return 0;
 }
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule *rule)
+void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste)
 {
-	struct mlx5hws_matcher *matcher = rule->matcher;
 	struct mlx5hws_pool_chunk ste = {0};
-	struct mlx5hws_pool *pool;
-	u8 max_stes;
 
-	if (mlx5hws_matcher_is_resizable(matcher)) {
-		/* Free the original action pool if rule was resized */
-		max_stes = rule->resize_info->max_stes;
-		pool = rule->resize_info->action_ste_pool;
-	} else {
-		max_stes = matcher->action_ste.max_stes;
-		pool = matcher->action_ste.pool;
-	}
+	if (!action_ste->num_stes)
+		return;
 
-	/* This release is safe only when the rule match part was deleted */
-	ste.order = ilog2(roundup_pow_of_two(max_stes));
-	ste.offset = rule->action_ste_idx;
+	ste.order = ilog2(roundup_pow_of_two(action_ste->num_stes));
+	ste.offset = action_ste->index;
 
-	mlx5hws_pool_chunk_free(pool, &ste);
+	/* This release is safe only when the rule match STE was deleted
+	 * (when the rule is being deleted) or replaced with the new STE that
+	 * isn't pointing to old action STEs (when the rule is being updated).
+	 */
+	mlx5hws_pool_chunk_free(action_ste->pool, &ste);
 }
 
 static void hws_rule_create_init(struct mlx5hws_rule *rule,
@@ -257,11 +249,24 @@ static void hws_rule_create_init(struct mlx5hws_rule *rule,
 		/* In update we use these rtc's */
 		rule->rtc_0 = 0;
 		rule->rtc_1 = 0;
+
+		rule->action_ste.pool = NULL;
+		rule->action_ste.num_stes = 0;
+		rule->action_ste.index = -1;
+
+		rule->status = MLX5HWS_RULE_STATUS_CREATING;
+	} else {
+		rule->status = MLX5HWS_RULE_STATUS_UPDATING;
 	}
 
+	/* Initialize the old action STE info - shallow-copy action_ste.
+	 * In create flow this will set old_action_ste fields to initial values.
+	 * In update flow this will save the existing action STE info,
+	 * so that we will later use it to free old STEs.
+	 */
+	rule->old_action_ste = rule->action_ste;
+
 	rule->pending_wqes = 0;
-	rule->action_ste_idx = -1;
-	rule->status = MLX5HWS_RULE_STATUS_CREATING;
 
 	/* Init default send STE attributes */
 	ste_attr->gta_opcode = MLX5HWS_WQE_GTA_OP_ACTIVATE;
@@ -288,7 +293,6 @@ static void hws_rule_move_init(struct mlx5hws_rule *rule,
 	rule->rtc_1 = 0;
 
 	rule->pending_wqes = 0;
-	rule->action_ste_idx = -1;
 	rule->status = MLX5HWS_RULE_STATUS_CREATING;
 	rule->resize_info->state = MLX5HWS_RULE_RESIZE_STATE_WRITING;
 }
@@ -349,19 +353,17 @@ static int hws_rule_create_hws(struct mlx5hws_rule *rule,
 
 	if (action_stes) {
 		/* Allocate action STEs for rules that need more than match STE */
-		if (!is_update) {
-			ret = hws_rule_alloc_action_ste(rule, attr);
-			if (ret) {
-				mlx5hws_err(ctx, "Failed to allocate action memory %d", ret);
-				mlx5hws_send_abort_new_dep_wqe(queue);
-				return ret;
-			}
+		ret = hws_rule_alloc_action_ste(rule);
+		if (ret) {
+			mlx5hws_err(ctx, "Failed to allocate action memory %d", ret);
+			mlx5hws_send_abort_new_dep_wqe(queue);
+			return ret;
 		}
 		/* Skip RX/TX based on the dep_wqe init */
 		ste_attr.rtc_0 = dep_wqe->rtc_0 ? matcher->action_ste.rtc_0_id : 0;
 		ste_attr.rtc_1 = dep_wqe->rtc_1 ? matcher->action_ste.rtc_1_id : 0;
 		/* Action STEs are written to a specific index last to first */
-		ste_attr.direct_index = rule->action_ste_idx + action_stes;
+		ste_attr.direct_index = rule->action_ste.index + action_stes;
 		apply.next_direct_idx = ste_attr.direct_index;
 	} else {
 		apply.next_direct_idx = 0;
@@ -412,7 +414,7 @@ static int hws_rule_create_hws(struct mlx5hws_rule *rule,
 	if (!is_update)
 		hws_rule_save_delete_info(rule, &ste_attr);
 
-	hws_rule_save_resize_info(rule, &ste_attr, is_update);
+	hws_rule_save_resize_info(rule, &ste_attr);
 	mlx5hws_send_engine_inc_rule(queue);
 
 	if (!attr->burst)
@@ -433,7 +435,10 @@ static void hws_rule_destroy_failed_hws(struct mlx5hws_rule *rule,
 			  attr->user_data, MLX5HWS_RULE_STATUS_DELETED);
 
 	/* Rule failed now we can safely release action STEs */
-	mlx5hws_rule_free_action_ste(rule);
+	mlx5hws_rule_free_action_ste(&rule->action_ste);
+
+	/* Perhaps the rule failed updating - release old action STEs as well */
+	mlx5hws_rule_free_action_ste(&rule->old_action_ste);
 
 	/* Clear complex tag */
 	hws_rule_clear_delete_info(rule);
@@ -470,7 +475,8 @@ static int hws_rule_destroy_hws(struct mlx5hws_rule *rule,
 	}
 
 	/* Rule is not completed yet */
-	if (rule->status == MLX5HWS_RULE_STATUS_CREATING)
+	if (rule->status == MLX5HWS_RULE_STATUS_CREATING ||
+	    rule->status == MLX5HWS_RULE_STATUS_UPDATING)
 		return -EBUSY;
 
 	/* Rule failed and doesn't require cleanup */
@@ -487,7 +493,7 @@ static int hws_rule_destroy_hws(struct mlx5hws_rule *rule,
 		hws_rule_gen_comp(queue, rule, false,
 				  attr->user_data, MLX5HWS_RULE_STATUS_DELETED);
 
-		mlx5hws_rule_free_action_ste(rule);
+		mlx5hws_rule_free_action_ste(&rule->action_ste);
 		mlx5hws_rule_clear_resize_info(rule);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
index fd2bef87116b..b5ee94ac449b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
@@ -15,6 +15,8 @@ enum mlx5hws_rule_status {
 	MLX5HWS_RULE_STATUS_UNKNOWN,
 	MLX5HWS_RULE_STATUS_CREATING,
 	MLX5HWS_RULE_STATUS_CREATED,
+	MLX5HWS_RULE_STATUS_UPDATING,
+	MLX5HWS_RULE_STATUS_UPDATED,
 	MLX5HWS_RULE_STATUS_DELETING,
 	MLX5HWS_RULE_STATUS_DELETED,
 	MLX5HWS_RULE_STATUS_FAILING,
@@ -41,13 +43,17 @@ struct mlx5hws_rule_match_tag {
 	};
 };
 
+struct mlx5hws_rule_action_ste_info {
+	struct mlx5hws_pool *pool;
+	int index; /* STE array index */
+	u8 num_stes;
+};
+
 struct mlx5hws_rule_resize_info {
-	struct mlx5hws_pool *action_ste_pool;
 	u32 rtc_0;
 	u32 rtc_1;
 	u32 rule_idx;
 	u8 state;
-	u8 max_stes;
 	u8 ctrl_seg[MLX5HWS_WQE_SZ_GTA_CTRL]; /* Ctrl segment of STE: 48 bytes */
 	u8 data_seg[MLX5HWS_WQE_SZ_GTA_DATA]; /* Data segment of STE: 64 bytes */
 };
@@ -58,9 +64,10 @@ struct mlx5hws_rule {
 		struct mlx5hws_rule_match_tag tag;
 		struct mlx5hws_rule_resize_info *resize_info;
 	};
+	struct mlx5hws_rule_action_ste_info action_ste;
+	struct mlx5hws_rule_action_ste_info old_action_ste;
 	u32 rtc_0; /* The RTC into which the STE was inserted */
 	u32 rtc_1; /* The RTC into which the STE was inserted */
-	int action_ste_idx; /* STE array index */
 	u8 status; /* enum mlx5hws_rule_status */
 	u8 pending_wqes;
 	bool skip_delete; /* For complex rules - another rule with same tag
@@ -68,7 +75,7 @@ struct mlx5hws_rule {
 			   */
 };
 
-void mlx5hws_rule_free_action_ste(struct mlx5hws_rule *rule);
+void mlx5hws_rule_free_action_ste(struct mlx5hws_rule_action_ste_info *action_ste);
 
 int mlx5hws_rule_move_hws_remove(struct mlx5hws_rule *rule,
 				 void *queue, void *user_data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index c680b7f984e1..cb6abc4ab7df 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -377,17 +377,25 @@ static void hws_send_engine_update_rule(struct mlx5hws_send_engine *queue,
 
 			*status = MLX5HWS_FLOW_OP_ERROR;
 		} else {
-			/* Increase the status, this only works on good flow as the enum
-			 * is arrange it away creating -> created -> deleting -> deleted
+			/* Increase the status, this only works on good flow as
+			 * the enum is arranged this way:
+			 *  - creating -> created
+			 *  - updating -> updated
+			 *  - deleting -> deleted
 			 */
 			priv->rule->status++;
 			*status = MLX5HWS_FLOW_OP_SUCCESS;
-			/* Rule was deleted now we can safely release action STEs
-			 * and clear resize info
-			 */
 			if (priv->rule->status == MLX5HWS_RULE_STATUS_DELETED) {
-				mlx5hws_rule_free_action_ste(priv->rule);
+				/* Rule was deleted, now we can safely release
+				 * action STEs and clear resize info
+				 */
+				mlx5hws_rule_free_action_ste(&priv->rule->action_ste);
 				mlx5hws_rule_clear_resize_info(priv->rule);
+			} else if (priv->rule->status == MLX5HWS_RULE_STATUS_UPDATED) {
+				/* Rule was updated, free the old action STEs */
+				mlx5hws_rule_free_action_ste(&priv->rule->old_action_ste);
+				/* Update completed - move the rule back to "created" */
+				priv->rule->status = MLX5HWS_RULE_STATUS_CREATED;
 			}
 		}
 	}
-- 
2.45.0


