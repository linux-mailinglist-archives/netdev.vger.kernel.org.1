Return-Path: <netdev+bounces-154818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C0B9FFDA0
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E20161038
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7331B414B;
	Thu,  2 Jan 2025 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J0cgwRAE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C41AD418
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841761; cv=fail; b=osinqMOBBD/Oo/7q9dHCI7nDiySwqaFN/tcbU5lBPxPqSnKP3XOeq+v4qH4HNuOF4mcIpoY51+/dJsyf/FzXmvywPJ9uDvWodC4s2SK0/TPJj7S30gxx9CjlIMfLFa82RQewCYlzT4CmNizCuFQ/BUiVbV1bqF0roa5r+j6B12w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841761; c=relaxed/simple;
	bh=x1/WGqa2vNgg3fYmke2NeLD5XVsW2WgBHh5G869//OM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKHfAQ0by/PgSAC0DGLtH8iTJTy6MI7fotaoCGKCFZm1SKwDbv787BHKIATeMCvWwPuuDC/XX+UGoSyDUl8MK5Pm6g6Ima2tbwjVkpqVG6QOJWQducj2iJye9PGAMzF414kS/PsmXfAD46d/Rg7kc90a0ZIGfjH78AxYE8DgUys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J0cgwRAE; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liMF+FOZ1W0zp2HT9P5Dh+DFrgm99wSh28D6BqKpjHtNTvOkhs61DdoDrqGlmGCadRX9SFpqsHYrbc5iaa7giAL743SOrA+w4VfGamchEsCRSfXaY9Y3NFbVlf0sMSgUfMjQEjB11MeF8UYtxOvk7t2Jorr2ADH5yWFGNHLcU/1ue8iWdUJxgDZ9IVsi7Hd7SIAEZbUHpsXGZRC+eit6TG9rls/vhtzr3K79OSX+FQHsaIiVTSd+mye02Oo/XPffGdKDhIDIvbp/Bpv9fR5yGuhki9Een3Jts9lZhiduwvURJRrwG/lzkykBPzCxyhbtrvgFX5lcziU0vFfy6WyuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVWwj2heTQhGtbWGzWWqKcD9E30tJeGNUUoGFeZBu6c=;
 b=mJBURhN8722PphIgVXRKRGpaV2iW8NgzdNYP1Pc4wHnz4WRcx3pLMOF4SgiqpgpV3CBmyD4s+wCY9b0ILexO9ukloFqY0zf/SiSpUWQcRcFxizJW8ZO71iaaVH6mOo8aZ7ypJwS1y/AtsIFmm+7MhkCFmbZTE8Dg3MPQqjD+f/+g84lKu2HZ8m6mDYtN2m+XsKSyXMaZ0ZLXmVqFJLea7ZPX6L9RcfNylhfatdlxzCo2G4kExrCSRLp9D+LN/cSgPBdEYS23ZonJCii5jdbxl282jCj40TtK7vsewVwPPeLHtV7fLaO+8LMJs95RjD+bKpa2CDaPBWZ0uxAKv6a93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVWwj2heTQhGtbWGzWWqKcD9E30tJeGNUUoGFeZBu6c=;
 b=J0cgwRAEHgnH5AZ5jsIzr67cMDuf32+Sj0SuHmw1nMDBs5OX9NTFaPjhLo8Gr3WoQZuyYX7purGqz6nR3IQIObd+S3Own0HOVCCATBTc2J5VBenmNaiiT7l0smejopkHdbAXbUCmFCPaxYJT5qSwzMAL5bbG8CnoiJ6lso2e9djQpmsn+7XKZasJgOUK9XjTeohOyVJCpZ50CjrVq1KV0h/cE/qjD6ohbGK1Zdq2mGiBcDvq6Wb0qa3IyLUCnHf2M/bbte5edQDa2fkVYWvsLnY8O9p6tubyApDC6PAFVKBkOc/ZXNtPEBdnpOqcmjexo+00hfz0n5KFFB6NuEL1FQ==
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by CY8PR12MB8265.namprd12.prod.outlook.com (2603:10b6:930:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.20; Thu, 2 Jan
 2025 18:15:51 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::31) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:34 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:31 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/15] net/mlx5: HWS, num_of_rules counter on matcher should be atomic
Date: Thu, 2 Jan 2025 20:14:08 +0200
Message-ID: <20250102181415.1477316-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY8PR12MB8265:EE_
X-MS-Office365-Filtering-Correlation-Id: b98f7e72-1947-41a6-109a-08dd2b597d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVYB4jnkdcbVQKyGFVa3QhMMJYNPB5079iH2J1OZeHsjbACpEzJ1g1kaJJML?=
 =?us-ascii?Q?NWqk0iUB1JC9FMpC0SH/Np3fPZ7Nabfc27udC1xYepUWxnxyxFz4JYtIBT9O?=
 =?us-ascii?Q?T8GasqN8Suwsvee8mdBKCyOOcwVNIn1T25yMN4TzAesQ5tkigpEsHthllGrJ?=
 =?us-ascii?Q?xUFI1+NyOVMhAKqtzAGJxmsi54gtCg04fHtGGzshmtOfmOczWc04XdaYJXqW?=
 =?us-ascii?Q?bdqcBUc3rOANj6nhgzqAIABgeIOCK55FsgmD1t+uhdlizhKYebu18l46Sp9s?=
 =?us-ascii?Q?N2rxNWj6b5IGEOrtzDCQY7v2jHoY+esXjRrEgC4rNXHHX8fOwxodXIso/o5t?=
 =?us-ascii?Q?4NZQ9pnaG0jUDt6NHZCb5I+oP9Ku2eO6ftJqILeUDV8pQLpmszNbmR/uyMfm?=
 =?us-ascii?Q?N1ISwDOBYRvYTqnI0j6yJaomHW6ozZe/Gt2RWqTANctfFwPM3UfK5f+/eZDF?=
 =?us-ascii?Q?bMZovbOnuHtu/XcgBDw8+a+wsIs394l5hpoBxdo/PIlqsGbdbWvIrRJI9XYc?=
 =?us-ascii?Q?j6wBwaxw6gn5o/maTx697aUA+V54X8h76V5cukq7PM3e67KPDJxwN1DpSdYm?=
 =?us-ascii?Q?mUYsUSAND7AiXcHxi1Ct1cCvhLUSQ/+gcUSNlJz2GPi6gbgxNmlU6Cj5eBRw?=
 =?us-ascii?Q?dLSrIJpxneVv3tyO1w/pHvAKJow2FzIpZQ46GrAKCDpnFU6K1EYGhIwspHaJ?=
 =?us-ascii?Q?PSgfZnmp/c8foJQxASgLt9R42Ap0kzRe3MAA/PgK6WBDlp4Rlk2wDmvZxwSe?=
 =?us-ascii?Q?VQSjIbSHSxe/jWp/70qYqsNixGOlluPH30MOqBrGdyg9hfxGNvOvLet8jVif?=
 =?us-ascii?Q?SlFJSxagkO27yNKN6bqG93Mxuy1OCW4MBO1ycYRzN1l+1U0FJ3WyhSqY9RYp?=
 =?us-ascii?Q?uK5SRell9q0qZVJgSUcQKaYb3+AWRL76G5bPrFNKqlIjrc+XeolYN5oLaf8Z?=
 =?us-ascii?Q?kElht/N9UEJxFnBIG74wqAUudEkmbr2x5hT5dKXDa8mdquKcxxOlGk4ne43r?=
 =?us-ascii?Q?jil9n4uTPMnfBhepbG7kCHxC9vXItkYFXgcxMR5+1TD7yhpIgG2osZqAgCjq?=
 =?us-ascii?Q?BYEM8IIL6gHfz9yIFQwPcUyUumgecekcb4aQbmBIJB30aez3+7L/2bGB1fRt?=
 =?us-ascii?Q?Ndcym5H32XLGvUwviMwOyYq7KR/9zYDrvqmtwLXP/Wv329sWYcx1lr8ipCwq?=
 =?us-ascii?Q?viVwJO+EY+6sO3qXdfQtKbJ3IyUbPsK7+JbrUn/t38uirrHyg45hkTONvZvH?=
 =?us-ascii?Q?GO8fUS7nUu5mubTUdJCXCdr8zZd2/6fiXaqa2KOKU2fIcK/wCiMonl/JNmdo?=
 =?us-ascii?Q?TU8ZEQpHmzjVZUme4/CR/otLivl7faDLTyRwYKK5qa5/tZqPn3GbbnkDui7E?=
 =?us-ascii?Q?85C/yFk9ZNzwrsarAYFRAA4I2vFZn6ik23rmzDRDpBSY5/FQqEcdAwEq4BzG?=
 =?us-ascii?Q?vzflr/+icinqH268/QoV6vOJ4+FD2cdsoqy6So9o+Wv/SYUZFJNVVZdpa6os?=
 =?us-ascii?Q?3li8Lwse5Y5gu1w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:51.4157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98f7e72-1947-41a6-109a-08dd2b597d9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8265

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Rule counter in matcher's struct is used in two places:

1. As heuristics to decide when the number of rules have crossed a
certain percentage threshold and the matcher should be resized.
We don't mind here if the number will be off by 1-2 due to concurrency.

2. When destroying matcher, the counter value is checked and the
user is warned if it is not 0. Here we lock all the queues, so the
counter will be correct.

We don't need to always have *exact* number, but we do need this
number to not be corrupted, which is what is happening when the
counter isn't atomic, due to update by different threads.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c       | 17 +++++++++++------
 .../mellanox/mlx5/core/steering/hws/bwc.h       |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index af8ab8750c70..40d688ed6153 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -152,6 +152,8 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 	if (!bwc_matcher)
 		return NULL;
 
+	atomic_set(&bwc_matcher->num_of_rules, 0);
+
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
 	 */
@@ -199,10 +201,12 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	if (bwc_matcher->num_of_rules)
+	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+
+	if (num_of_rules)
 		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
 			    "BWC matcher destroy: matcher still has %d rules\n",
-			    bwc_matcher->num_of_rules);
+			    num_of_rules);
 
 	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
 
@@ -309,7 +313,7 @@ static void hws_bwc_rule_list_add(struct mlx5hws_bwc_rule *bwc_rule, u16 idx)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 
-	bwc_matcher->num_of_rules++;
+	atomic_inc(&bwc_matcher->num_of_rules);
 	bwc_rule->bwc_queue_idx = idx;
 	list_add(&bwc_rule->list_node, &bwc_matcher->rules[idx]);
 }
@@ -318,7 +322,7 @@ static void hws_bwc_rule_list_remove(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 
-	bwc_matcher->num_of_rules--;
+	atomic_dec(&bwc_matcher->num_of_rules);
 	list_del_init(&bwc_rule->list_node);
 }
 
@@ -711,7 +715,8 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 * Need to check again if we really need rehash.
 	 * If the reason for rehash was size, but not any more - skip rehash.
 	 */
-	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher, bwc_matcher->num_of_rules))
+	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher,
+						atomic_read(&bwc_matcher->num_of_rules)))
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
@@ -804,7 +809,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	}
 
 	/* check if number of rules require rehash */
-	num_of_rules = bwc_matcher->num_of_rules;
+	num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
 
 	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
 		mutex_unlock(queue_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 1d27638fa171..06c2a30c0d4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -25,7 +25,7 @@ struct mlx5hws_bwc_matcher {
 	u8 num_of_at;
 	u16 priority;
 	u8 size_log;
-	u32 num_of_rules; /* atomically accessed */
+	atomic_t num_of_rules;
 	struct list_head *rules;
 };
 
-- 
2.45.0


