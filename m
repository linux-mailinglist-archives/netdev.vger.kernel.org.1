Return-Path: <netdev+bounces-162147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F22EA25DE9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9315B164257
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9B205E32;
	Mon,  3 Feb 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gwcky2N4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB52080E2;
	Mon,  3 Feb 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594923; cv=fail; b=I1fEyLh/BIG4q0xJmht47DtVzGLe1ONNcZSpvyL/hvGgLYeykeecLRpYcX7omz+fb9aE+eckz6UQqxt3TdW5DDBdNrLgT2uA+/PkmMwZHDQYwAzgUYvpyKEmgO0Fq2js/yUC+gHy2TZDDFAqApyqBEZAEYZFX1oWNbbf79i930w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594923; c=relaxed/simple;
	bh=fM/Ynk+nja5vyIfipDE5uP6dPQuISD1Oh14diRA2qbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfkGwzG4WRcTnk6xgnSM1SNcLUdoF8VOS0HYMvrj8VIaCLGXHV9DZmApW8e+noPRLud29zgwL7jmvcRZXOJ17MSzjoa6c7tWhlLDOqdo7PegEHkjX0Yjwep7uqpSbzfZ9Nl5ir6+vZMBl1QkXdHa8G6kf5sd9nAevzhIybKyz40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gwcky2N4; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL6Lr/CHByBTHlZ5zkwSBgCwdCtUH46JUgfD6wcEufDGr+II5fhgN8wgjCWrScmgrZFqA12wZAtKflJNcZwaHADu/bZkZwtwfpOKcmzx3ibPhE7r4KyUzLE2BkPPja3IelaP2PPZgYH4JIpviT/UrBAyvQE8CjVYChLRiCBoaw7MUxpV0k1LpEbjxtuZ3YTPYXRkHieqKn0NQ/0zSzwlYEmKS/I3CNcgxftQN3lCVdLOq1lQHZMOyCGJiDdWyPi/p57hyO9DW1Fs2v8qPw7Xo9TN0aJlpnwevgPF55PPpeJ5nuTCO541p8MufiShyXDC9EyxqSuBsv3m8WJ05zYXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=o48cGzK1uR8Vflhz2N4VgoDkODSiH94G42BFJPxJexFnE4hi10vM+ArXmzV6LGBoMAOQNzzU1qFJB8mzcY9wc7yKgrhV97wn+6oVr6ln8Mg4N/vgA1CXX0uw4uvksQw6OyTeXEO/3z6SXpPbo1HUmamqk8GdPR3MXkjcj1GO2f31UMIAjQNJu8p4UNf3UwK/4fD132PzKayJWe3O6uLR0HMhaM8sfHaiFzjd3jerP8y6x23Imm1tsf/q5T98dR0EThel31WsmSgwFuw7GB+wMP4igJ0oifpdabzXcnrxEMWiS5wyYnRNFHMMAZqwVXL+4fW+Dhrtrc/eDYWPR7IapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ca58S5zLvWbM81+SBYQ3l91t4WubQWIJWGfAy4cAPv0=;
 b=Gwcky2N4/nuK87t052CXypAX7jndXM8eV2zOfm0rUH8QA+F+H7PzLL9d2pa+VlTo2zobY+dbotZB7C3jcf1STCd8fhB0H3ZIyPEHmDo3LaXyT/Ppvozfwc2oVhnXnTriLS+Dlj9BDPZ/rVAr6yMIpU4Sb3jmBeJweTUPWw4QsjF1ZAl85GwvPVjK9rUyQrwHRexlIAgISCwPScOWIIX2f/IQ5IIPTz2WhH2z5rQdsTlcQDIQ/SpFNvkWopjX2CAO//M5utXcO3UQTz0P8PYXBLPj7YEQv/dm/+aw966AigwRx44yV/k2/uDrrV5wANf7TAXdNNRjiY/DMRAp9+VTcw==
Received: from DS7PR03CA0316.namprd03.prod.outlook.com (2603:10b6:8:2b::17) by
 DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.26; Mon, 3 Feb 2025 15:01:57 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::4a) by DS7PR03CA0316.outlook.office365.com
 (2603:10b6:8:2b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 15:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 15:01:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 07:01:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 07:01:33 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 07:01:29 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed Zaki
	<ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5e: Symmetric OR-XOR RSS hash control
Date: Mon, 3 Feb 2025 17:00:39 +0200
Message-ID: <20250203150039.519301-3-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250203150039.519301-1-gal@nvidia.com>
References: <20250203150039.519301-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 17067e97-07b2-4aea-3e15-08dd4463b3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhRfltjQpFDSEtCDbhZWmhdQb9UEWUSGc47Y8+YMj9qv1znfslFyO9kH9sZf?=
 =?us-ascii?Q?P2SDzUMj+EEOWi90gnvUEKR6r0aSfQnX7uEPntNAoeqUEXs5GYinlbePGwad?=
 =?us-ascii?Q?8Yun/dCxlMYi2nHPn1IGnr8KwTxxq7cueDfZkL2bUAZK8MfyPHOoqqCakuUS?=
 =?us-ascii?Q?QAZ4ESkWBZvULJSgEIzBTgvM2r2XYC2bRb0P8Z0BHuJ5x/5KjobTgrVlWMdV?=
 =?us-ascii?Q?DQ8Mnge8LVrXW6mSP3hMiw0SO6rEHNEcHE8vBqYkDrUkHaXhLU8HD2Cz5REe?=
 =?us-ascii?Q?Liq6aUipjD2lWTsdcvqGlayGSEH3iB9dT8/3AAOHlGvu7GwqUQdrVuI/SZo2?=
 =?us-ascii?Q?V5ZJpo5p3p1PyhoiSsj1I4r+zJWa9vkagQqd4O6AO99fzFV0jV0Zk02ABoyp?=
 =?us-ascii?Q?VmmOLmn5UO172//Z3vnzkdvvwuE2RUZsENmV1u8K9ah8HfBUJ72rtapvC4Ct?=
 =?us-ascii?Q?jDWvBL9DT5Snz7Jd5jUH4hnqy6LZO2zBC0q+AAvL3pnkVFTkukj6HtZS6F9m?=
 =?us-ascii?Q?gyH9SCHdoV7e3LVDe35ux2lNvrDRIh2PwodWksetu+zL8bLrZNmoahXjfTxk?=
 =?us-ascii?Q?0P/Bgy1mww7z+T1HnB+fPgJpdilOiLC/I4yH+HxLN0DxlMXhRm6EusOs39/R?=
 =?us-ascii?Q?hSXbZWBhNirI4dscPk1JCxr08HMCj7cJekGE0QYcVTA/vQ9pLKwuHcwFgcXi?=
 =?us-ascii?Q?No1pp16+QUHVVf70KFmwduI9949+NAWmnCuXa0qE9PNPCzyMwkZFrOgvo00Z?=
 =?us-ascii?Q?wm1jRcXc3flJ2Hi57Q88ZxKru109viUj/vgF/xqPcPdFsc2IaAgfZGfm5zKN?=
 =?us-ascii?Q?z5KE6Bh+DQHlOzs67F3wwqhhsySDTl/VEDBTAteEIQAoD8DLBOtaAWq3kFfk?=
 =?us-ascii?Q?bnWKmKHo1TFAuPPlu/zCGvuIg0X1lF6ua567kR+3a5vwtmIK3aQ0meKjA7az?=
 =?us-ascii?Q?Zi8qOIxJKMFgO4JdetmT5HdJr9Skkn7jYvWPsXcXsdm2RoKgf36koKqZrV4e?=
 =?us-ascii?Q?Nz/MVySRMc1jhpmDOZxoVCk1lIGShMT8ExA8qg6UaJga2QUPaqneJbWV3bjk?=
 =?us-ascii?Q?Inr1GgR8tbGAvkxySF+jdEA4znAbPT3WqF/4bcfL7i1NQVwpsMCgK1KCgFWT?=
 =?us-ascii?Q?HoQcul1e31OAKhMw5f36tPKx49AdHvFRD/eXDl9oc26iREi/DA6+igQSHkY3?=
 =?us-ascii?Q?uPKQ+w16be/zXFmYnm4AJ4lqN/+jW35ju8nEVTIHZy2AuerMxDBLNqlvVaB9?=
 =?us-ascii?Q?h5eRtYcFnd0DI0QJjhp/LZp5O5JBujfCTf7efEwGfQqMlrWgNVH3tZ5Mfup0?=
 =?us-ascii?Q?NtT9PSIdaovScg5hX3EXORYKGD4G94GeGDU/KQ/qbHMmkqZ9Acxzg7GfUQV1?=
 =?us-ascii?Q?l9SJDaEHErqDaszsywYGseaZV6UiVRLvqa3tEsTudebVkK6+m4V27gk3/w80?=
 =?us-ascii?Q?fdglOr/M+zeOsZY/bI1kjK+LqQkHbSRAl4YasbnU6ctnAhZcWVsYzpoOX4Bq?=
 =?us-ascii?Q?Zlhz3clYvB/s81I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:01:55.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17067e97-07b2-4aea-3e15-08dd4463b3e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

Allow control over the symmetric RSS hash, which was previously set to
enabled by default by the driver.

Symmetric OR-XOR RSS can now be queried and controlled using the
'ethtool -x/X' command.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c    | 13 +++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/rss.h    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c | 11 ++++++-----
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.c    |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/tir.h    |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 ++++++++++++++---
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 5f742f896600..71a2d0835974 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -156,6 +156,7 @@ static void mlx5e_rss_params_init(struct mlx5e_rss *rss)
 {
 	enum mlx5_traffic_types tt;
 
+	rss->hash.symmetric = true;
 	rss->hash.hfunc = ETH_RSS_HASH_TOP;
 	netdev_rss_key_fill(rss->hash.toeplitz_hash_key,
 			    sizeof(rss->hash.toeplitz_hash_key));
@@ -551,7 +552,7 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 	return final_err;
 }
 
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	if (indir)
 		memcpy(indir, rss->indir.table,
@@ -564,11 +565,14 @@ int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 	if (hfunc)
 		*hfunc = rss->hash.hfunc;
 
+	if (symmetric)
+		*symmetric = rss->hash.symmetric;
+
 	return 0;
 }
 
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns)
 {
 	bool changed_indir = false;
@@ -608,6 +612,11 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 		       rss->indir.actual_table_size * sizeof(*rss->indir.table));
 	}
 
+	if (symmetric) {
+		rss->hash.symmetric = *symmetric;
+		changed_hash = true;
+	}
+
 	if (changed_indir && rss->enabled) {
 		err = mlx5e_rss_apply(rss, rqns, vhca_ids, num_rqns);
 		if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index d0df98963c8d..9e4f50f194db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -44,9 +44,9 @@ void mlx5e_rss_disable(struct mlx5e_rss *rss);
 
 int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 				     struct mlx5e_packet_merge_param *pkt_merge_param);
-int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc);
+int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
-		       const u8 *key, const u8 *hfunc,
+		       const u8 *key, const u8 *hfunc, const bool *symmetric,
 		       u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 struct mlx5e_rss_params_hash mlx5e_rss_get_hash(struct mlx5e_rss *rss);
 u8 mlx5e_rss_get_hash_fields(struct mlx5e_rss *rss, enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index a86eade9a9e0..b64b814ee25c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -196,7 +196,7 @@ void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int n
 }
 
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc)
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric)
 {
 	struct mlx5e_rss *rss;
 
@@ -207,11 +207,12 @@ int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc);
+	return mlx5e_rss_get_rxfh(rss, indir, key, hfunc, symmetric);
 }
 
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc)
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric)
 {
 	u32 *vhca_ids = get_vhca_ids(res, 0);
 	struct mlx5e_rss *rss;
@@ -223,8 +224,8 @@ int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
 	if (!rss)
 		return -ENOENT;
 
-	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, res->rss_rqns, vhca_ids,
-				  res->rss_nch);
+	return mlx5e_rss_set_rxfh(rss, indir, key, hfunc, symmetric,
+				  res->rss_rqns, vhca_ids, res->rss_nch);
 }
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 7b1a9f0f1874..c2f510a2282b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -44,9 +44,10 @@ void mlx5e_rx_res_xsk_update(struct mlx5e_rx_res *res, struct mlx5e_channels *ch
 /* Configuration API */
 void mlx5e_rx_res_rss_set_indir_uniform(struct mlx5e_rx_res *res, unsigned int nch);
 int mlx5e_rx_res_rss_get_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      u32 *indir, u8 *key, u8 *hfunc);
+			      u32 *indir, u8 *key, u8 *hfunc, bool *symmetric);
 int mlx5e_rx_res_rss_set_rxfh(struct mlx5e_rx_res *res, u32 rss_idx,
-			      const u32 *indir, const u8 *key, const u8 *hfunc);
+			      const u32 *indir, const u8 *key, const u8 *hfunc,
+			      const bool *symmetric);
 
 int mlx5e_rx_res_rss_get_hash_fields(struct mlx5e_rx_res *res, u32 rss_idx,
 				     enum mlx5_traffic_types tt);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index 11f724ad90db..19499072f67f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -124,7 +124,7 @@ void mlx5e_tir_builder_build_rss(struct mlx5e_tir_builder *builder,
 		const size_t len = MLX5_FLD_SZ_BYTES(tirc, rx_hash_toeplitz_key);
 		void *rss_key = MLX5_ADDR_OF(tirc, tirc, rx_hash_toeplitz_key);
 
-		MLX5_SET(tirc, tirc, rx_hash_symmetric, 1);
+		MLX5_SET(tirc, tirc, rx_hash_symmetric, rss_hash->symmetric);
 		memcpy(rss_key, rss_hash->toeplitz_hash_key, len);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
index 857a84bcd53a..e8df3aaf6562 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
@@ -9,6 +9,7 @@
 struct mlx5e_rss_params_hash {
 	u8 hfunc;
 	u8 toeplitz_hash_key[40];
+	bool symmetric;
 };
 
 struct mlx5e_rss_params_traffic_type {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cae39198b4db..2c88b65853f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1458,18 +1458,27 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	u32 rss_context = rxfh->rss_context;
+	bool symmetric;
 	int err;
 
 	mutex_lock(&priv->state_lock);
 	err = mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rss_context,
-					rxfh->indir, rxfh->key, &rxfh->hfunc);
+					rxfh->indir, rxfh->key, &rxfh->hfunc, &symmetric);
 	mutex_unlock(&priv->state_lock);
-	return err;
+
+	if (err)
+		return err;
+
+	if (symmetric)
+		rxfh->input_xfrm = RXH_XFRM_SYM_OR_XOR;
+
+	return 0;
 }
 
 static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
 			  struct netlink_ext_ack *extack)
 {
+	bool symmetric = rxfh->input_xfrm == RXH_XFRM_SYM_OR_XOR;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
@@ -1504,7 +1513,8 @@ static int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxf
 
 	err = mlx5e_rx_res_rss_set_rxfh(priv->rx_res, *rss_context,
 					rxfh->indir, rxfh->key,
-					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc);
+					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
+					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
 
 unlock:
 	mutex_unlock(&priv->state_lock);
@@ -2613,6 +2623,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
-- 
2.40.1


