Return-Path: <netdev+bounces-154824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7529FFDA9
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4473A2180
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50E1AF4C1;
	Thu,  2 Jan 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Inasqh+R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F516F0E8
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841788; cv=fail; b=B+UDIsElt2fyfemu02wBVaoZvzRtXS4Fs+fqfFjgcRcA3ApsRpvYBEiTXndfZDTWwyHy0CBnhsNKYt9HTsd7oQnkKKpM/nzhZecEShO1SufETiQXZMG6/3B9Wwq4wu+EFFBP8dcDhn8r3B0Zn7vEstnHcjG+vTc7mlBiqypN7iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841788; c=relaxed/simple;
	bh=lkfL9xtQmz/g87Ic3ni/CgbGkM0Nlh7j18mIOqXLQv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrYc2xSqiSz03TKtcwHh+HIRuhNU1LHKOtPgtVrPMlkeJWwXCjn051B3RFWn2j2M0990VtNR44a2rhvbtzw9qwIWmkaKZ18pHIjPs7J63OnplCE4emvq5fqmsDQxIF1IaPK+dBJH45ob8igSpiIA/v5MpFc2E4lQ7bpDE3jMtoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Inasqh+R; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOa0qFUjx8I8mEn1zmUZULaW/lHtFzGGiTUiacL1DnYTTuUxnF0oewpzOperKtB5GHzoW7x5M8o4/JO9+64/HNY24QO9NY2jynpPrJhXMDImNUYvG++DG8JDh4LxgYsWaYDHfYO3KWxYNo+0h41j5ht+DGSzSABO5gCevABM73YRJyYl56qmT3Lw5kYqsz6HqwfrtfcjbXntsjxLiiiD7Pj8NojoPWPwgsCKV8diqOm4subXlYE9l+bI09nWgmAs+/dX/ou/r2ZD93MCTERMA4Q7JQndSBE2kRqKNQrjhfDFfqWaumpMTzim/KN1YjTnHOk6BJo622W3MfPqhjxHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cws0b+H8dIhrzP6274WWcO4PfD/CpkflTUQysodwnuU=;
 b=jm3PFGyEizpC97XpK+VFFP7Yuglcr0uv+aReipYN0sr82IW1i+V51QYph1gHz2dwBLSsOtoxAFoHoiKGZzY6vkShcXs1Dy73Sd1LLqmuFDckDt8m+gkwUZuRaOEG0F94sUmXm7CDspUW0usCx/YL8jZoTFZwRYHqEixqAy0Pxrz41G8BikokHJFHFKFnI+fax6xczzdrIr5h3yab+ifLxrnnSAGGTksgf4Bn//0TnOYmcOluY87rm7jNlgl9QTFdXLdiJChxQ0NA2jHKbG0lj6iUzUG8zKxuo2IPyU7on4jw5v27EJqPgIqJgKxlvwr3lfRGvKK+4IGDY4hQokn2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cws0b+H8dIhrzP6274WWcO4PfD/CpkflTUQysodwnuU=;
 b=Inasqh+R18oWwzXJqJuzRnv0T/d49SqtqHGq9DUwBmYtih7EesHYJT534Y/GCllQnDTlSZo7LaDkhpzBCEnutGe+NFxjMjdRkK/lLcxiciaQnCJJDkm/OLUuBD8Ut/u2wb9IRQGE0PBxW8h2rfUaqxbrxTk3jgw/+zs5eJ2JKJScTMWE2dR+IIeKp17JCxQp0dyEfzBrA6bWtqQv5TmHOJ8/7d0LxuIvRc/4DQ6vvPFmTzvg8x/VjOywugzQOX66j3uxe+FHAmP9XhttDfUbPKoz4DFHc8Art0/9zOUVuvu5i5VFhKCo9pSHeABZk1IyOuNRrNigTu+OCCDEYpYQoQ==
Received: from MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:16:16 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::43) by MN2PR22CA0019.outlook.office365.com
 (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:16:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5: HWS, set timeout on polling for completion
Date: Thu, 2 Jan 2025 20:14:14 +0200
Message-ID: <20250102181415.1477316-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dd2745-ed5f-4d03-b57e-08dd2b598be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jd8NzyK0sVEbPFEf7xttCTiSJE6043QLnu+WV8C4PTXRe9JkksW2Ev+e3QIz?=
 =?us-ascii?Q?zbB7UVECAEQPTCsXtcAkNt5sLBXdPvVNQfKSNmHZo43jUfA46Ls/kzufE3+S?=
 =?us-ascii?Q?bYU7gX4/OczepN4YhT2K31xf2+TtIWW5t1JqGkZzRV7KxzjGG/f6XedGL8HM?=
 =?us-ascii?Q?ZAHlJCj6jf8e3SpOfDp/T5reefnKhnYpz1jGKnPJq9BxzcUDCjCPSx6Bfqbb?=
 =?us-ascii?Q?EmWlzQfL9UBkCOpEexniGqjsmjJsVVw6ExTuNKZAZgJlb6iTIdevN+tsVKAg?=
 =?us-ascii?Q?b4GuBJqurydoBpM+h7v2Ni5FzhQ1jJsmE6woJVb8LSzvbBTpWh2iFSBqywu6?=
 =?us-ascii?Q?cs25JmBKts9VOk8yBkXO74py0WqLnfEuLOt2pdquhwoSppHGKg0kyr5lH/nK?=
 =?us-ascii?Q?PlXLlAoZvwLev044Vcg572EZRpn4cNk4sBU5Uj5KD41Q6F88tfaPcer6AB1c?=
 =?us-ascii?Q?p7eReirEyTws7dj42PJ8KQGAhLmLcGXIZpvLQb+wzb3TuhZQuhjrvbW3gnwO?=
 =?us-ascii?Q?IZXGGZihDh6sr8s6BrsljuDats+zNU/4njxUU7U6izOhRKqzBNj7rwik5Gs1?=
 =?us-ascii?Q?SBj4Wn6LOWOs6SXS0Rd2qpNqERd3227k0K5KdjiGBM/76edbjwuohtjlP5Oq?=
 =?us-ascii?Q?M5E5eHseSvxVdtNONk08tC/ry8032mEdM0zsiW0eSv2O7AgyKymJbiyfep92?=
 =?us-ascii?Q?yPG0cCvpCk7UQUbdRLuxB4m0pGE/jzuyNE8vZ5No5sQ1TdGGOoPogyLUvikt?=
 =?us-ascii?Q?zFor1fNdMUMbK47TW+9/fTVcxrx0pW11qo0ZBensNR7Zh8M2tcvWAgOC7dGQ?=
 =?us-ascii?Q?EPq/DyfWo++N+CLGDR0WmgnL/RCfrJHIyaCJLln/KcsvqMTK7QMlrmZHA6uO?=
 =?us-ascii?Q?CO5jzsxRmBBhdnIMcrKJ/q99kHryLrzCRHmRFRzI87HSVgWkRvy7uGaTesjk?=
 =?us-ascii?Q?pO/lNM5C4QIvUMfXTlwxF+0x1JaT2KgaWcd9y/ijMO84KfCgZozdGoe6KUIu?=
 =?us-ascii?Q?kCJQClQs1ck0JKC9L89I7WgS2AZIb3ObZe0FUcWBZHyJPRsw/jqztayfxBfa?=
 =?us-ascii?Q?ecY+3Qb5+64l/rGhGNFlZklIZf8R7cZ37aL41xnih3s2aEezdkv913TQUvAQ?=
 =?us-ascii?Q?1mDhuSGc2LTtW/1mmWvE7g2zVclL5JfdBFCMjR6boyj6Bbthn7Qhya7ZAt/E?=
 =?us-ascii?Q?rJPMY3LwCdh97MxNozxP1Sr/p8nSdTGWhtHz4w8xbmOaYUkqFBHH23DBq0MW?=
 =?us-ascii?Q?mJev6LhvbJSukyBpHdL2Mj+HT7mUcia55MZ/EaMXXy1KI2pIH9tX1EeYZEdZ?=
 =?us-ascii?Q?O0RTxB6sRXnxmVuVVIRvpMzLYgSLD0Bus/9/Md/3rkntckjjxoxnDeyAa3hD?=
 =?us-ascii?Q?77FNaDKt/UsN8NJZSYmpv6bJ0RF+gZTnPd+0um7uo3wTJsrkywCSwaj8Bhlk?=
 =?us-ascii?Q?KcODom1KgQxFmh8OAhguEq6WlCNmFZDkmYtgyw1c09DaTBYfLyNKWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:16:15.3814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dd2745-ed5f-4d03-b57e-08dd2b598be8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Consolidate BWC polling for completion into one function
and set a time limit on the loop that polls for completion.
This can happen only if there is some issue with FW/PCI/HW,
such as FW being stuck, PCI issue, etc.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 26 ++++++++++++-------
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  2 ++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 40d688ed6153..a8d886e92144 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -219,6 +219,8 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 			      u32 *pending_rules,
 			      bool drain)
 {
+	unsigned long timeout = jiffies +
+				msecs_to_jiffies(MLX5HWS_BWC_POLLING_TIMEOUT * MSEC_PER_SEC);
 	struct mlx5hws_flow_op_result comp[MLX5HWS_BWC_MATCHER_REHASH_BURST_TH];
 	u16 burst_th = hws_bwc_get_burst_th(ctx, queue_id);
 	bool got_comp = *pending_rules >= burst_th;
@@ -254,6 +256,11 @@ static int hws_bwc_queue_poll(struct mlx5hws_context *ctx,
 		}
 
 		got_comp = !!ret;
+
+		if (unlikely(!got_comp && time_after(jiffies, timeout))) {
+			mlx5hws_err(ctx, "BWC poll error: polling queue %d - TIMEOUT\n", queue_id);
+			return -ETIMEDOUT;
+		}
 	}
 
 	return err;
@@ -338,22 +345,21 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
 			      struct mlx5hws_rule_attr *rule_attr)
 {
 	struct mlx5hws_context *ctx = bwc_rule->bwc_matcher->matcher->tbl->ctx;
-	struct mlx5hws_flow_op_result completion;
+	u32 expected_completions = 1;
 	int ret;
 
 	ret = hws_bwc_rule_destroy_hws_async(bwc_rule, rule_attr);
 	if (unlikely(ret))
 		return ret;
 
-	do {
-		ret = mlx5hws_send_queue_poll(ctx, rule_attr->queue_id, &completion, 1);
-	} while (ret != 1);
-
-	if (unlikely(completion.status != MLX5HWS_FLOW_OP_SUCCESS ||
-		     (bwc_rule->rule->status != MLX5HWS_RULE_STATUS_DELETED &&
-		      bwc_rule->rule->status != MLX5HWS_RULE_STATUS_DELETING))) {
-		mlx5hws_err(ctx, "Failed destroying BWC rule: completion %d, rule status %d\n",
-			    completion.status, bwc_rule->rule->status);
+	ret = hws_bwc_queue_poll(ctx, rule_attr->queue_id, &expected_completions, true);
+	if (unlikely(ret))
+		return ret;
+
+	if (unlikely(bwc_rule->rule->status != MLX5HWS_RULE_STATUS_DELETED &&
+		     bwc_rule->rule->status != MLX5HWS_RULE_STATUS_DELETING)) {
+		mlx5hws_err(ctx, "Failed destroying BWC rule: rule status %d\n",
+			    bwc_rule->rule->status);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 06c2a30c0d4e..f9f569131dde 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -18,6 +18,8 @@
 
 #define MLX5HWS_BWC_MAX_ACTS 16
 
+#define MLX5HWS_BWC_POLLING_TIMEOUT 60
+
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
-- 
2.45.0


