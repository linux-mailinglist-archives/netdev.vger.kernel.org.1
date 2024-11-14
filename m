Return-Path: <netdev+bounces-145081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D029C9510
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195A91F21801
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470341AF0D5;
	Thu, 14 Nov 2024 22:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDop4gFu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBF1B0F05
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622264; cv=fail; b=SD914aErmZ+/7bVVWBPMhhBkegYAVcNgHg8W+RIdcxa12Txw2gptC/bnUxrKeMumLCCNC+CBKFLceKBip4+sMP2jeb4HVI9i6bjD9MD8+Pj4ucsAsRJRZrYiS53MDpxjKw1leRAg1vkHMwRQCYfDQtOrR3YdCXCCHOQNTa3iGF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622264; c=relaxed/simple;
	bh=u5gboAqmZ4cg9fUrTFwfulOROlP3FOFOXHwTi4TXjT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKWwX1ZbA41PtaapMFtZRTRE5mmLrFq1+UcrkXzPi7lJtoxsLhJJlvwe8l4n9K9Nmn/5SnT33VL8H4mGKae86Tm51eLfVcCO4N+pSD0QkePhpw7v5Ujufb1URLTskG0n3AJ8Vv5xWuPPtBG1Xz28/IDJ7O6wT8jf4OpLpl3gVrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDop4gFu; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=breR4ekb+QPY9cdeElO1fPV1tundgR6Uj8dinhBWCeF61aoaAl2lHmRlBcYXDdoaVh06DkV2pVPmmgZtMxddENbPgXqryW/PZauG2exzGgCjm8gWL/PvO8fn+RlJY+hXQ8YmYtiRbKDACmUPlaSfzVUdW3jqm7p57lk4Zhj1UURTsBwg4tEfGHIdaFH5kzPhghSjfBB7fCz6iUraHut+mKAycRthcgSubq0sC9wtWDXEl3+n4Uso1ozKZW6t5zxQcMmycGxIIckeFuOQbjE5zRZ0zfOU8w5Ug4IyTaF0dEvSgyjEwFQWO8bwz4e5QpQPpBLoJRkNqbud37d1wuQlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=CmHv3rIWFaH7DGp1BEnntkHX8hlVtxwfWecfrI6fbypEcOhMOvU0Jzc2OtoZX5+VZt+Iw1Raj73+URCZWGT1hqEY+BhPZaKi+skz2TyC9jm5h0jrlDnwd5RqTszT7Fc1jQP1PFzxKqo03A4yKuS615N1mGWfOQbocBCNU/yKpKuCz/LBbxQxkw95nRG0Fl/14lcsXiAtr5mKn86VyctIaYPKSlP7BoXihfncctB5HGBY9LyO6Qp+at622y9rsVJ8+KEGpZt3OxnC7tXSMCh1td0GF53r0zjyeIZxWqVQlsE8NZNzb0bdp5tAxx9o4tbg9HLIWFRXspHYt9gMCK7t6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=RDop4gFu8djNJzGIWTHohbGmvNSlT/Yu6TdxLf2VtReWYXQDODJeuFZmnTZ0cq8PKpFa3EgCXEAp29hAKJoq/bxOM7Ml+Q6oDnwHmN63lpcfagObfDjGuq6r0i0LsKX/Wo7GonshoD/NE2+vXpMTtW/macpQRHS2RDCmUIjfcb2dbHXBDb4AzifjpSCItC1hkZP2LvQs4X+f52nC5ow6NV3hy4qIWtLrIUKo9w8v5Y4L6ZYZmLqR5JYInlRGW/O3af3T8B8PqikzpQfyxCVz1iw8QopgBeV2KemLewrfE1g+Wjp0Mnzg7eK+Z2ABDQVC8SIBToQ8ZyfWwvfLWT0x6w==
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:10:55 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::4d) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 22:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:10:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:37 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Itamar Gozlan <igozlan@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 1/8] net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
Date: Fri, 15 Nov 2024 00:09:30 +0200
Message-ID: <20241114220937.719507-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114220937.719507-1-tariqt@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: e7eed5dd-abb7-4f4e-e0f8-08dd04f935c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EKYMxLmgG1rtNxO8uWxnRYURKQ/ExhlRm9l9VOrv7mWO4ZMhy3ORlAmjE8OJ?=
 =?us-ascii?Q?q8VP2tjNxGvVPKuY++QI5aWSG+tGg7ezQ+z5ijmNgT37k692NQgOXGs9JVr5?=
 =?us-ascii?Q?7ETAXQSB0ulNPw1skJISqPn2euQTGLN0et0jDhLnp5+NzkUd0hopOjOwTnH5?=
 =?us-ascii?Q?I6Wl9nSstGmwRQsbe3vstFq0HWpvCoJzCcatTZtHFGDZNu+UR1vg3dkpIrjP?=
 =?us-ascii?Q?94C1+vUQUk74lALe+iX7JEsFoEMsswbZnhH5Uufy1e8cBG4rfvNueAQJanW3?=
 =?us-ascii?Q?tagjxXjKr0yiQxpsgbp83Y6qJQxJdsQTUT0bRtp8B4w3tdouXKVR2mqUt2cb?=
 =?us-ascii?Q?MimR5hfQ4YAknPEHYOb3B0QvOrdU2SHxQndvySyvA2M2lDeOgSrwvzcfrcnT?=
 =?us-ascii?Q?8rWXFgsh+SoT7dlKekSBkhkR/3UV5nABJqQaZW+/jCduDVWaZJPVA3Mu0hkD?=
 =?us-ascii?Q?IbEagiBzwr1bQuOYfz1PqTOZPyBMvxNukHGv0dFso/wTtOrbVdHG3qBBRcQA?=
 =?us-ascii?Q?9mxqZdIkkK/uw5Idd6FmCvfU1ywNAbcPYqKPUuhEpDTQZ0GHFDH05lHQXaCZ?=
 =?us-ascii?Q?MQnWuI04mzFBNB6uIzQLbtRbGTZFNhltiJLGWq64CQnUlUTyQ9AlNlKHJgUr?=
 =?us-ascii?Q?4TwjW5m2+wiJHNrtDZhp4/LnTyCQCwCSbpUDqh+6EtpBpBvt58u9V/JsiBP0?=
 =?us-ascii?Q?0l09ssumyv+1DCoAweKT0DVeqINCi6WH8Pk/VUURl4Ae2w6DVxB1iEkGpTNQ?=
 =?us-ascii?Q?D4aC9f7U6qLTNCPmBsj/wMqqW10dvIgD8MyuYZhq6cd7WDNFPiq7DBo3qBv/?=
 =?us-ascii?Q?Y3OWXX49WLy0fgxSFPTD9y/CBUJqNCjKoPOnFfUXKOw9FRxWYf+/3fALJaqa?=
 =?us-ascii?Q?NI57h8kT/iE2zc3DOra9xUQn8aTLt8juKC/LLJkVDDE59r9T4Yn3qqWGW1A3?=
 =?us-ascii?Q?UbClfNjHAYFr6abBkSKv6I2ilIMaGvPK2xdkiIgLFRSd8kYw/6aAkZ6GTSH5?=
 =?us-ascii?Q?gVaXJ+nkIhnincGAPrMpJYfl3jmCLDwbqrtKmmVBswjKfCpQqQb0oH5QxVHo?=
 =?us-ascii?Q?VvmvIATFbdOErZEkf43CXbUN5wOSBWOJ6mw7QCLBIJ07MyvbbVBN/QAQu5Hh?=
 =?us-ascii?Q?s45fVvbqJq5ROOZd+nsmyE9ocqUERjRxJ5Xcy15czfciOvWy0lkSYLab8MiD?=
 =?us-ascii?Q?3zn9BaQ7qPGFPS33phin+Z2IM0Ndkp5YlRwDuCXMF6lUUoXgXBy3hV8bnE7h?=
 =?us-ascii?Q?JpC3oIVApr2IPoxH3c/9PZJ+rmT0cMjULfrJ11YgdtA+Z95Z3kL8XVCEzrkC?=
 =?us-ascii?Q?MRUY5at39AB7ABx/Jl8HLlJsEXGkraZRZAJ5y2HY0RRpz5EeASP6MqZnFKyx?=
 =?us-ascii?Q?/QH69FpvX8XCKLJK/gfoZkzgoAJ3uabjePPBYRAM70uFSGep8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:10:55.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eed5dd-abb7-4f4e-e0f8-08dd04f935c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

From: Itamar Gozlan <igozlan@nvidia.com>

Expand SWS STE callbacks to support ConnectX-8 hardware.
Move common enums and structures to a shared header file.

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   4 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  18 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 ++++--------------
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 ++++++++++++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +-------------
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++++++++++++
 7 files changed, 377 insertions(+), 342 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
index e94fbb015efa..01ba8eae2983 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
@@ -555,7 +555,7 @@ void mlx5dr_ste_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes)
 {
-	ste_ctx->set_actions_tx(dmn, action_type_set, ste_ctx->actions_caps,
+	ste_ctx->set_actions_tx(ste_ctx, dmn, action_type_set, ste_ctx->actions_caps,
 				hw_ste_arr, attr, added_stes);
 }
 
@@ -566,7 +566,7 @@ void mlx5dr_ste_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes)
 {
-	ste_ctx->set_actions_rx(dmn, action_type_set, ste_ctx->actions_caps,
+	ste_ctx->set_actions_rx(ste_ctx, dmn, action_type_set, ste_ctx->actions_caps,
 				hw_ste_arr, attr, added_stes);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
index 54a6619c3ecb..b6ec8d30d990 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
@@ -160,13 +160,15 @@ struct mlx5dr_ste_ctx {
 
 	/* Actions */
 	u32 actions_caps;
-	void (*set_actions_rx)(struct mlx5dr_domain *dmn,
+	void (*set_actions_rx)(struct mlx5dr_ste_ctx *ste_ctx,
+			       struct mlx5dr_domain *dmn,
 			       u8 *action_type_set,
 			       u32 actions_caps,
 			       u8 *hw_ste_arr,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes);
-	void (*set_actions_tx)(struct mlx5dr_domain *dmn,
+	void (*set_actions_tx)(struct mlx5dr_ste_ctx *ste_ctx,
+			       struct mlx5dr_domain *dmn,
 			       u8 *action_type_set,
 			       u32 actions_caps,
 			       u8 *hw_ste_arr,
@@ -197,7 +199,17 @@ struct mlx5dr_ste_ctx {
 					u16 *used_hw_action_num);
 	int (*alloc_modify_hdr_chunk)(struct mlx5dr_action *action);
 	void (*dealloc_modify_hdr_chunk)(struct mlx5dr_action *action);
-
+	/* Actions bit set */
+	void (*set_encap)(u8 *hw_ste_p, u8 *d_action,
+			  u32 reformat_id, int size);
+	void (*set_push_vlan)(u8 *ste, u8 *d_action,
+			      u32 vlan_hdr);
+	void (*set_pop_vlan)(u8 *hw_ste_p, u8 *s_action,
+			     u8 vlans_num);
+	void (*set_rx_decap)(u8 *hw_ste_p, u8 *s_action);
+	void (*set_encap_l3)(u8 *hw_ste_p, u8 *frst_s_action,
+			     u8 *scnd_d_action, u32 reformat_id,
+			     int size);
 	/* Send */
 	void (*prepare_for_postsend)(u8 *hw_ste_p, u32 ste_size);
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
index e9f6c7ed7a7b..42536bee55e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
@@ -406,7 +406,8 @@ static void dr_ste_v0_arr_init_next(u8 **last_ste,
 }
 
 static void
-dr_ste_v0_set_actions_tx(struct mlx5dr_domain *dmn,
+dr_ste_v0_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
+			 struct mlx5dr_domain *dmn,
 			 u8 *action_type_set,
 			 u32 actions_caps,
 			 u8 *last_ste,
@@ -476,7 +477,8 @@ dr_ste_v0_set_actions_tx(struct mlx5dr_domain *dmn,
 }
 
 static void
-dr_ste_v0_set_actions_rx(struct mlx5dr_domain *dmn,
+dr_ste_v0_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
+			 struct mlx5dr_domain *dmn,
 			 u8 *action_type_set,
 			 u32 actions_caps,
 			 u8 *last_ste,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
index 1d49704b9542..7f83d77c43ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
@@ -5,136 +5,6 @@
 #include "mlx5_ifc_dr_ste_v1.h"
 #include "dr_ste_v1.h"
 
-#define DR_STE_CALC_DFNR_TYPE(lookup_type, inner) \
-	((inner) ? DR_STE_V1_LU_TYPE_##lookup_type##_I : \
-		   DR_STE_V1_LU_TYPE_##lookup_type##_O)
-
-enum dr_ste_v1_entry_format {
-	DR_STE_V1_TYPE_BWC_BYTE	= 0x0,
-	DR_STE_V1_TYPE_BWC_DW	= 0x1,
-	DR_STE_V1_TYPE_MATCH	= 0x2,
-	DR_STE_V1_TYPE_MATCH_RANGES = 0x7,
-};
-
-/* Lookup type is built from 2B: [ Definer mode 1B ][ Definer index 1B ] */
-enum {
-	DR_STE_V1_LU_TYPE_NOP				= 0x0000,
-	DR_STE_V1_LU_TYPE_ETHL2_TNL			= 0x0002,
-	DR_STE_V1_LU_TYPE_IBL3_EXT			= 0x0102,
-	DR_STE_V1_LU_TYPE_ETHL2_O			= 0x0003,
-	DR_STE_V1_LU_TYPE_IBL4				= 0x0103,
-	DR_STE_V1_LU_TYPE_ETHL2_I			= 0x0004,
-	DR_STE_V1_LU_TYPE_SRC_QP_GVMI			= 0x0104,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_O			= 0x0005,
-	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_O		= 0x0105,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_I			= 0x0006,
-	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_I		= 0x0106,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_O		= 0x0007,
-	DR_STE_V1_LU_TYPE_IPV6_DES_O			= 0x0107,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_I		= 0x0008,
-	DR_STE_V1_LU_TYPE_IPV6_DES_I			= 0x0108,
-	DR_STE_V1_LU_TYPE_ETHL4_O			= 0x0009,
-	DR_STE_V1_LU_TYPE_IPV6_SRC_O			= 0x0109,
-	DR_STE_V1_LU_TYPE_ETHL4_I			= 0x000a,
-	DR_STE_V1_LU_TYPE_IPV6_SRC_I			= 0x010a,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_O		= 0x000b,
-	DR_STE_V1_LU_TYPE_MPLS_O			= 0x010b,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_I		= 0x000c,
-	DR_STE_V1_LU_TYPE_MPLS_I			= 0x010c,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_O		= 0x000d,
-	DR_STE_V1_LU_TYPE_GRE				= 0x010d,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_TNL_HEADER	= 0x000e,
-	DR_STE_V1_LU_TYPE_GENERAL_PURPOSE		= 0x010e,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_I		= 0x000f,
-	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_0		= 0x010f,
-	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_1		= 0x0110,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_OK		= 0x0011,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_0			= 0x0111,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_1			= 0x0112,
-	DR_STE_V1_LU_TYPE_ETHL4_MISC_O			= 0x0113,
-	DR_STE_V1_LU_TYPE_ETHL4_MISC_I			= 0x0114,
-	DR_STE_V1_LU_TYPE_INVALID			= 0x00ff,
-	DR_STE_V1_LU_TYPE_DONT_CARE			= MLX5DR_STE_LU_TYPE_DONT_CARE,
-};
-
-enum dr_ste_v1_header_anchors {
-	DR_STE_HEADER_ANCHOR_START_OUTER		= 0x00,
-	DR_STE_HEADER_ANCHOR_1ST_VLAN			= 0x02,
-	DR_STE_HEADER_ANCHOR_IPV6_IPV4			= 0x07,
-	DR_STE_HEADER_ANCHOR_INNER_MAC			= 0x13,
-	DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4		= 0x19,
-};
-
-enum dr_ste_v1_action_size {
-	DR_STE_ACTION_SINGLE_SZ = 4,
-	DR_STE_ACTION_DOUBLE_SZ = 8,
-	DR_STE_ACTION_TRIPLE_SZ = 12,
-};
-
-enum dr_ste_v1_action_insert_ptr_attr {
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_NONE = 0,  /* Regular push header (e.g. push vlan) */
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP = 1, /* Encapsulation / Tunneling */
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ESP = 2,   /* IPsec */
-};
-
-enum dr_ste_v1_action_id {
-	DR_STE_V1_ACTION_ID_NOP				= 0x00,
-	DR_STE_V1_ACTION_ID_COPY			= 0x05,
-	DR_STE_V1_ACTION_ID_SET				= 0x06,
-	DR_STE_V1_ACTION_ID_ADD				= 0x07,
-	DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE		= 0x08,
-	DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER	= 0x09,
-	DR_STE_V1_ACTION_ID_INSERT_INLINE		= 0x0a,
-	DR_STE_V1_ACTION_ID_INSERT_POINTER		= 0x0b,
-	DR_STE_V1_ACTION_ID_FLOW_TAG			= 0x0c,
-	DR_STE_V1_ACTION_ID_QUEUE_ID_SEL		= 0x0d,
-	DR_STE_V1_ACTION_ID_ACCELERATED_LIST		= 0x0e,
-	DR_STE_V1_ACTION_ID_MODIFY_LIST			= 0x0f,
-	DR_STE_V1_ACTION_ID_ASO				= 0x12,
-	DR_STE_V1_ACTION_ID_TRAILER			= 0x13,
-	DR_STE_V1_ACTION_ID_COUNTER_ID			= 0x14,
-	DR_STE_V1_ACTION_ID_MAX				= 0x21,
-	/* use for special cases */
-	DR_STE_V1_ACTION_ID_SPECIAL_ENCAP_L3		= 0x22,
-};
-
-enum {
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
-	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
-	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
-	DR_STE_V1_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
-	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
-	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
-	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
-	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
-	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
-	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
-	DR_STE_V1_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
-	DR_STE_V1_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_0		= 0x8c,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_1		= 0x8d,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_0		= 0x8e,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_1		= 0x8f,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_0		= 0x90,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_1		= 0x91,
-};
-
-enum dr_ste_v1_aso_ctx_type {
-	DR_STE_V1_ASO_CTX_TYPE_POLICERS = 0x2,
-};
-
 static const struct mlx5dr_ste_action_modify_field dr_ste_v1_action_modify_field_arr[] = {
 	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
 		.hw_field = DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
@@ -379,13 +249,12 @@ static void dr_ste_v1_set_counter_id(u8 *hw_ste_p, u32 ctr_id)
 	MLX5_SET(ste_match_bwc_v1, hw_ste_p, counter_id, ctr_id);
 }
 
-static void dr_ste_v1_set_reparse(u8 *hw_ste_p)
+void dr_ste_v1_set_reparse(u8 *hw_ste_p)
 {
 	MLX5_SET(ste_match_bwc_v1, hw_ste_p, reparse, 1);
 }
 
-static void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action,
-				u32 reformat_id, int size)
+void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action, u32 reformat_id, int size)
 {
 	MLX5_SET(ste_double_action_insert_with_ptr_v1, d_action, action_id,
 		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
@@ -432,8 +301,7 @@ static void dr_ste_v1_set_remove_hdr(u8 *hw_ste_p, u8 *s_action,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action,
-				    u32 vlan_hdr)
+void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action, u32 vlan_hdr)
 {
 	MLX5_SET(ste_double_action_insert_with_inline_v1, d_action,
 		 action_id, DR_STE_V1_ACTION_ID_INSERT_INLINE);
@@ -446,7 +314,7 @@ static void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
+void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
 {
 	MLX5_SET(ste_single_action_remove_header_size_v1, s_action,
 		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
@@ -459,11 +327,8 @@ static void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_encap_l3(u8 *hw_ste_p,
-				   u8 *frst_s_action,
-				   u8 *scnd_d_action,
-				   u32 reformat_id,
-				   int size)
+void dr_ste_v1_set_encap_l3(u8 *hw_ste_p, u8 *frst_s_action, u8 *scnd_d_action,
+			    u32 reformat_id, int size)
 {
 	/* Remove L2 headers */
 	MLX5_SET(ste_single_action_remove_header_v1, frst_s_action, action_id,
@@ -483,7 +348,7 @@ static void dr_ste_v1_set_encap_l3(u8 *hw_ste_p,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
+void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
 {
 	MLX5_SET(ste_single_action_remove_header_v1, s_action, action_id,
 		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
@@ -620,7 +485,8 @@ static void dr_ste_v1_arr_init_next_match_range(u8 **last_ste,
 	dr_ste_v1_set_entry_type(*last_ste, DR_STE_V1_TYPE_MATCH_RANGES);
 }
 
-void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
+void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
+			      struct mlx5dr_domain *dmn,
 			      u8 *action_type_set,
 			      u32 actions_caps,
 			      u8 *last_ste,
@@ -640,7 +506,7 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 					      last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_pop_vlan(last_ste, action, attr->vlans.count);
+		ste_ctx->set_pop_vlan(last_ste, action, attr->vlans.count);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 
@@ -677,8 +543,8 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 				action_sz = DR_STE_ACTION_TRIPLE_SZ;
 				allow_encap = true;
 			}
-			dr_ste_v1_set_push_vlan(last_ste, action,
-						attr->vlans.headers[i]);
+			ste_ctx->set_push_vlan(last_ste, action,
+					       attr->vlans.headers[i]);
 			action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 			action += DR_STE_ACTION_DOUBLE_SZ;
 		}
@@ -691,9 +557,9 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 			allow_encap = true;
 		}
-		dr_ste_v1_set_encap(last_ste, action,
-				    attr->reformat.id,
-				    attr->reformat.size);
+		ste_ctx->set_encap(last_ste, action,
+				   attr->reformat.id,
+				   attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 	} else if (action_type_set[DR_ACTION_TYP_L2_TO_TNL_L3]) {
@@ -706,10 +572,10 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 		}
 		d_action = action + DR_STE_ACTION_SINGLE_SZ;
 
-		dr_ste_v1_set_encap_l3(last_ste,
-				       action, d_action,
-				       attr->reformat.id,
-				       attr->reformat.size);
+		ste_ctx->set_encap_l3(last_ste,
+				      action, d_action,
+				      attr->reformat.id,
+				      attr->reformat.size);
 		action_sz -= DR_STE_ACTION_TRIPLE_SZ;
 		action += DR_STE_ACTION_TRIPLE_SZ;
 	} else if (action_type_set[DR_ACTION_TYP_INSERT_HDR]) {
@@ -776,7 +642,8 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 	dr_ste_v1_set_hit_addr(last_ste, attr->final_icm_addr, 1);
 }
 
-void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
+void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
+			      struct mlx5dr_domain *dmn,
 			      u8 *action_type_set,
 			      u32 actions_caps,
 			      u8 *last_ste,
@@ -799,7 +666,7 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 		allow_modify_hdr = false;
 		allow_ctr = false;
 	} else if (action_type_set[DR_ACTION_TYP_TNL_L2_TO_L2]) {
-		dr_ste_v1_set_rx_decap(last_ste, action);
+		ste_ctx->set_rx_decap(last_ste, action);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 		allow_modify_hdr = false;
@@ -827,7 +694,7 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
 
-		dr_ste_v1_set_pop_vlan(last_ste, action, attr->vlans.count);
+		ste_ctx->set_pop_vlan(last_ste, action, attr->vlans.count);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 		allow_ctr = false;
@@ -868,8 +735,8 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 						      last_ste, action);
 				action_sz = DR_STE_ACTION_TRIPLE_SZ;
 			}
-			dr_ste_v1_set_push_vlan(last_ste, action,
-						attr->vlans.headers[i]);
+			ste_ctx->set_push_vlan(last_ste, action,
+					       attr->vlans.headers[i]);
 			action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 			action += DR_STE_ACTION_DOUBLE_SZ;
 		}
@@ -895,9 +762,9 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 			action = MLX5_ADDR_OF(ste_mask_and_match_v1, last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_encap(last_ste, action,
-				    attr->reformat.id,
-				    attr->reformat.size);
+		ste_ctx->set_encap(last_ste, action,
+				   attr->reformat.id,
+				   attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 		allow_modify_hdr = false;
@@ -912,10 +779,10 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 
 		d_action = action + DR_STE_ACTION_SINGLE_SZ;
 
-		dr_ste_v1_set_encap_l3(last_ste,
-				       action, d_action,
-				       attr->reformat.id,
-				       attr->reformat.size);
+		ste_ctx->set_encap_l3(last_ste,
+				      action, d_action,
+				      attr->reformat.id,
+				      attr->reformat.size);
 		action_sz -= DR_STE_ACTION_TRIPLE_SZ;
 		allow_modify_hdr = false;
 	} else if (action_type_set[DR_ACTION_TYP_INSERT_HDR]) {
@@ -1027,9 +894,6 @@ void dr_ste_v1_set_action_copy(u8 *d_action,
 	MLX5_SET(ste_double_action_copy_v1, d_action, source_right_shifter, src_shifter);
 }
 
-#define DR_STE_DECAP_L3_ACTION_NUM	8
-#define DR_STE_L2_HDR_MAX_SZ		20
-
 int dr_ste_v1_set_action_decap_l3_list(void *data,
 				       u32 data_sz,
 				       u8 *hw_action,
@@ -2330,7 +2194,12 @@ static struct mlx5dr_ste_ctx ste_ctx_v1 = {
 	.set_action_decap_l3_list	= &dr_ste_v1_set_action_decap_l3_list,
 	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
 	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
-
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v1_set_encap,
+	.set_push_vlan			= &dr_ste_v1_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
index e2fc69867088..a8d9e308d339 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
@@ -7,6 +7,138 @@
 #include "dr_types.h"
 #include "dr_ste.h"
 
+#define DR_STE_DECAP_L3_ACTION_NUM	8
+#define DR_STE_L2_HDR_MAX_SZ		20
+#define DR_STE_CALC_DFNR_TYPE(lookup_type, inner) \
+	((inner) ? DR_STE_V1_LU_TYPE_##lookup_type##_I : \
+		   DR_STE_V1_LU_TYPE_##lookup_type##_O)
+
+enum dr_ste_v1_entry_format {
+	DR_STE_V1_TYPE_BWC_BYTE	= 0x0,
+	DR_STE_V1_TYPE_BWC_DW	= 0x1,
+	DR_STE_V1_TYPE_MATCH	= 0x2,
+	DR_STE_V1_TYPE_MATCH_RANGES = 0x7,
+};
+
+/* Lookup type is built from 2B: [ Definer mode 1B ][ Definer index 1B ] */
+enum {
+	DR_STE_V1_LU_TYPE_NOP				= 0x0000,
+	DR_STE_V1_LU_TYPE_ETHL2_TNL			= 0x0002,
+	DR_STE_V1_LU_TYPE_IBL3_EXT			= 0x0102,
+	DR_STE_V1_LU_TYPE_ETHL2_O			= 0x0003,
+	DR_STE_V1_LU_TYPE_IBL4				= 0x0103,
+	DR_STE_V1_LU_TYPE_ETHL2_I			= 0x0004,
+	DR_STE_V1_LU_TYPE_SRC_QP_GVMI			= 0x0104,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_O			= 0x0005,
+	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_O		= 0x0105,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_I			= 0x0006,
+	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_I		= 0x0106,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_O		= 0x0007,
+	DR_STE_V1_LU_TYPE_IPV6_DES_O			= 0x0107,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_I		= 0x0008,
+	DR_STE_V1_LU_TYPE_IPV6_DES_I			= 0x0108,
+	DR_STE_V1_LU_TYPE_ETHL4_O			= 0x0009,
+	DR_STE_V1_LU_TYPE_IPV6_SRC_O			= 0x0109,
+	DR_STE_V1_LU_TYPE_ETHL4_I			= 0x000a,
+	DR_STE_V1_LU_TYPE_IPV6_SRC_I			= 0x010a,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_O		= 0x000b,
+	DR_STE_V1_LU_TYPE_MPLS_O			= 0x010b,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_I		= 0x000c,
+	DR_STE_V1_LU_TYPE_MPLS_I			= 0x010c,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_O		= 0x000d,
+	DR_STE_V1_LU_TYPE_GRE				= 0x010d,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_TNL_HEADER	= 0x000e,
+	DR_STE_V1_LU_TYPE_GENERAL_PURPOSE		= 0x010e,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_I		= 0x000f,
+	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_0		= 0x010f,
+	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_1		= 0x0110,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_OK		= 0x0011,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_0			= 0x0111,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_1			= 0x0112,
+	DR_STE_V1_LU_TYPE_ETHL4_MISC_O			= 0x0113,
+	DR_STE_V1_LU_TYPE_ETHL4_MISC_I			= 0x0114,
+	DR_STE_V1_LU_TYPE_INVALID			= 0x00ff,
+	DR_STE_V1_LU_TYPE_DONT_CARE			= MLX5DR_STE_LU_TYPE_DONT_CARE,
+};
+
+enum dr_ste_v1_header_anchors {
+	DR_STE_HEADER_ANCHOR_START_OUTER		= 0x00,
+	DR_STE_HEADER_ANCHOR_1ST_VLAN			= 0x02,
+	DR_STE_HEADER_ANCHOR_IPV6_IPV4			= 0x07,
+	DR_STE_HEADER_ANCHOR_INNER_MAC			= 0x13,
+	DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4		= 0x19,
+};
+
+enum dr_ste_v1_action_size {
+	DR_STE_ACTION_SINGLE_SZ = 4,
+	DR_STE_ACTION_DOUBLE_SZ = 8,
+	DR_STE_ACTION_TRIPLE_SZ = 12,
+};
+
+enum dr_ste_v1_action_insert_ptr_attr {
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_NONE = 0,  /* Regular push header (e.g. push vlan) */
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP = 1, /* Encapsulation / Tunneling */
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ESP = 2,   /* IPsec */
+};
+
+enum dr_ste_v1_action_id {
+	DR_STE_V1_ACTION_ID_NOP				= 0x00,
+	DR_STE_V1_ACTION_ID_COPY			= 0x05,
+	DR_STE_V1_ACTION_ID_SET				= 0x06,
+	DR_STE_V1_ACTION_ID_ADD				= 0x07,
+	DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE		= 0x08,
+	DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER	= 0x09,
+	DR_STE_V1_ACTION_ID_INSERT_INLINE		= 0x0a,
+	DR_STE_V1_ACTION_ID_INSERT_POINTER		= 0x0b,
+	DR_STE_V1_ACTION_ID_FLOW_TAG			= 0x0c,
+	DR_STE_V1_ACTION_ID_QUEUE_ID_SEL		= 0x0d,
+	DR_STE_V1_ACTION_ID_ACCELERATED_LIST		= 0x0e,
+	DR_STE_V1_ACTION_ID_MODIFY_LIST			= 0x0f,
+	DR_STE_V1_ACTION_ID_ASO				= 0x12,
+	DR_STE_V1_ACTION_ID_TRAILER			= 0x13,
+	DR_STE_V1_ACTION_ID_COUNTER_ID			= 0x14,
+	DR_STE_V1_ACTION_ID_MAX				= 0x21,
+	/* use for special cases */
+	DR_STE_V1_ACTION_ID_SPECIAL_ENCAP_L3		= 0x22,
+};
+
+enum {
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
+	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
+	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
+	DR_STE_V1_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
+	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
+	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
+	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
+	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
+	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
+	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
+	DR_STE_V1_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
+	DR_STE_V1_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_0		= 0x8c,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_1		= 0x8d,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_0		= 0x8e,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_1		= 0x8f,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_0		= 0x90,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_1		= 0x91,
+};
+
+enum dr_ste_v1_aso_ctx_type {
+	DR_STE_V1_ASO_CTX_TYPE_POLICERS = 0x2,
+};
+
 bool dr_ste_v1_is_miss_addr_set(u8 *hw_ste_p);
 void dr_ste_v1_set_miss_addr(u8 *hw_ste_p, u64 miss_addr);
 u64 dr_ste_v1_get_miss_addr(u8 *hw_ste_p);
@@ -17,11 +149,18 @@ u16 dr_ste_v1_get_next_lu_type(u8 *hw_ste_p);
 void dr_ste_v1_set_hit_addr(u8 *hw_ste_p, u64 icm_addr, u32 ht_size);
 void dr_ste_v1_init(u8 *hw_ste_p, u16 lu_type, bool is_rx, u16 gvmi);
 void dr_ste_v1_prepare_for_postsend(u8 *hw_ste_p, u32 ste_size);
-void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn, u8 *action_type_set,
-			      u32 actions_caps, u8 *last_ste,
+void dr_ste_v1_set_reparse(u8 *hw_ste_p);
+void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action, u32 reformat_id, int size);
+void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action, u32 vlan_hdr);
+void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num);
+void dr_ste_v1_set_encap_l3(u8 *hw_ste_p, u8 *frst_s_action, u8 *scnd_d_action,
+			    u32 reformat_id, int size);
+void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action);
+void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx, struct mlx5dr_domain *dmn,
+			      u8 *action_type_set, u32 actions_caps, u8 *last_ste,
 			      struct mlx5dr_ste_actions_attr *attr, u32 *added_stes);
-void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn, u8 *action_type_set,
-			      u32 actions_caps, u8 *last_ste,
+void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx, struct mlx5dr_domain *dmn,
+			      u8 *action_type_set, u32 actions_caps, u8 *last_ste,
 			      struct mlx5dr_ste_actions_attr *attr, u32 *added_stes);
 void dr_ste_v1_set_action_set(u8 *d_action, u8 hw_field, u8 shifter,
 			      u8 length, u32 data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
index 808b013cf48c..0882dba0f64b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
@@ -2,167 +2,7 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include "dr_ste_v1.h"
-
-enum {
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
-	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
-	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
-	DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
-	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
-	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
-	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
-	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
-	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
-	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
-	DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
-	DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0		= 0x90,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1		= 0x91,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0		= 0x92,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1		= 0x93,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0		= 0x94,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1		= 0x95,
-};
-
-static const struct mlx5dr_ste_action_modify_field dr_ste_v2_action_modify_field_arr[] = {
-	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SMAC_15_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1, .start = 16, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_ETHERTYPE] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 0, .end = 15,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DMAC_47_16] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DMAC_15_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 16, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IP_DSCP] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 18, .end = 23,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_FLAGS] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1, .start = 16, .end = 24,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_SPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_DPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IP_TTL] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IPV6_HOPLIMIT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_UDP_SPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_UDP_DPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_127_96] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_95_64] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_63_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_127_96] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_95_64] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_63_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_A] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_B] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_1] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_2] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_3] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_5] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_SEQ_NUM] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_ACK_NUM] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_FIRST_VID] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2, .start = 0, .end = 15,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_EMD_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_EMD_47_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0, .start = 0, .end = 15,
-	},
-};
+#include "dr_ste_v2.h"
 
 static struct mlx5dr_ste_ctx ste_ctx_v2 = {
 	/* Builders */
@@ -223,7 +63,12 @@ static struct mlx5dr_ste_ctx ste_ctx_v2 = {
 	.set_action_decap_l3_list	= &dr_ste_v1_set_action_decap_l3_list,
 	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
 	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
-
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v1_set_encap,
+	.set_push_vlan			= &dr_ste_v1_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
new file mode 100644
index 000000000000..d853fde49cfc
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef	_DR_STE_V2_
+#define	_DR_STE_V2_
+
+enum {
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
+	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
+	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
+	DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
+	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
+	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
+	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
+	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
+	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
+	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
+	DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
+	DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0		= 0x90,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1		= 0x91,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0		= 0x92,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1		= 0x93,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0		= 0x94,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1		= 0x95,
+};
+
+static const struct mlx5dr_ste_action_modify_field dr_ste_v2_action_modify_field_arr[] = {
+	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SMAC_15_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1, .start = 16, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_ETHERTYPE] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 0, .end = 15,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DMAC_47_16] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DMAC_15_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 16, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IP_DSCP] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 18, .end = 23,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_FLAGS] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1, .start = 16, .end = 24,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_SPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_DPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IP_TTL] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IPV6_HOPLIMIT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_UDP_SPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_UDP_DPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_127_96] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_95_64] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_63_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_127_96] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_95_64] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_63_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_A] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_B] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_1] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_2] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_3] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_5] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_SEQ_NUM] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_ACK_NUM] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_FIRST_VID] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2, .start = 0, .end = 15,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_EMD_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_EMD_47_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0, .start = 0, .end = 15,
+	},
+};
+
+#endif  /* _DR_STE_V2_ */
-- 
2.44.0


