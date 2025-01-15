Return-Path: <netdev+bounces-158499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFAA122E1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B116C454
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32542241685;
	Wed, 15 Jan 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIXv9nB4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E441E98F3
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941298; cv=fail; b=rfzVhpNgsrWXIj2Q294B+lHJzDdr1EvV/6F7N83YSR+mEXr5AjyDbG4nYGtFMcV0341kAnP1wi2jGLsPieRamUD6IGa3WICRMreepp3iVtTX1ib9YRo58Et16c7J+gNqBdwUQRBsnvg0VnoUOEaihhW8KM5FrIBIz9slBciYFzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941298; c=relaxed/simple;
	bh=AJkm6932DIj0PVqQkxSSKxRErn0+Zc6DzxY8ZNUYPik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViUoMNEmehpCBYImvl8sq8M5DVdVlm5OVcrPll9oO+Qm+hmgxCZXMkHr3xQy/gr42l32bHIS+oRaTWyI1yaRxEUlsPB/DleuA7L3BzmnOCMICPPmN9YHQ8RI9V0zMPvTCiEx4ycs75hD9x+62XjreOICR4een2WYEy+NeZaXqGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JIXv9nB4; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we/ydHNSLEOWyaWuKPvzLkdoD1fMdFFuLkQq7v6CTFG5K57afX6YGO1ecILEFjzER/SEJ9bltSnyFBCM+vR7Kj9Vj2DwJSawCGV7JbfOFfKx9/ZdlMEw6AT2o9ZHwOlyQEXUBIzJzCK/ziXCGzJn6oinAegLENIO1I0ws4Q07HAQE+kd+2+VAE6d1aCT3t40fRGx1VrIhvFN3cghVSvrpDIUTXEaeKCpp94Id1lR6Cp5JIGC1NibcNvgkcsOTIfR6zi8qRy6NW2ndnx/pjOx5WV1WEIinmF2CTUCfNnCZwi4ahdfqO+FD+1YHqlcBKAoaLmTQtFVVyaRiKVYAVcJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPxklz9E2649FOXgV9Hzmg+XJDKa+D3JCGZaFufNZT0=;
 b=wtPzqpuGpeId1mBrfDN/EnPk9ovgedcYF8UPCTON+HKhiTpk1LeW+oqlCgYSr4IJraOHF1sHgMxPVQLiKZ9k1Q839yLTwzxSlBVxWHv8NpSSiznYWVnaOm8UvEi4J2IMQqL8a/FEkTdVFuB+OKrdu6rD9WCmr3eFCy+1hiCg2CGQc7sm4QuahvZXeG5xuweBNR+mPJo2OliHsHR7ihp7PA77dmukyF01NeAKaHX3VHH1l934NvJUFPr4N1BZ5rwnMRQG6FSXiyufOeMgkSoDRv7ndEuJ9D2+qnsbfogRS3GOzCBMvvWTMLHwDb5cSaD2JdKLzN/NoksiS1P+Ym68iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPxklz9E2649FOXgV9Hzmg+XJDKa+D3JCGZaFufNZT0=;
 b=JIXv9nB4kUAbGab1Y83/W7CnQGuM6YIGq5sy6KZv4I+SECELIjcqxuWBSr2Py/3voQJlFVaqu0UoO190nE/R14kz40CEGa/Ow9IljwN7qf5OY5w6PXgfipIWMwekDF6stB+W8xb9eFdXbnnW4I8EU0tq8ZyqeMVQAc8G0mqTX8eI+d8WY4lqd3WKJYWbirL/93Oh2Qwjqm1QGfz1OdJwNeNHRcuhmEPNCVnU/+U+nLeTQIgm7Bwejwke1rgVseyMfsPxWzgmo1hUOuwsIqanDak0y6AfhnnAcI+Jcy+zVjLmu7kCnneFdd1bYJ+l6/GcqR/XtCc2nb+0CxqLSywfWw==
Received: from MW4PR03CA0263.namprd03.prod.outlook.com (2603:10b6:303:b4::28)
 by PH0PR12MB7908.namprd12.prod.outlook.com (2603:10b6:510:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 11:41:31 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::67) by MW4PR03CA0263.outlook.office365.com
 (2603:10b6:303:b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 11:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:41:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 7/7] net/mlx5e: Always start IPsec sequence number from 1
Date: Wed, 15 Jan 2025 13:39:10 +0200
Message-ID: <20250115113910.1990174-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b60490f-f38c-465b-6ed3-08dd35598dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TTYnZHKUTnteBhUaJWM26fcOvPtzjrdCuc3yejZzZvjBsxUe9CV8/ly0Sz6T?=
 =?us-ascii?Q?bbz/3xIOUJIh4QU9qjXH6jhtlTkD6Wn3voSv9gQ2gkL+y3butsoiTth+6PhI?=
 =?us-ascii?Q?UMdzCScOlBvSquxJCqcz0FLVJiLRSRoi6DxnBTDoju/OouuWCGHvRm3XBVrE?=
 =?us-ascii?Q?dlfeWh8oDWfZa93UlkJsknIX+bo1YnmSK3C8Tl/stx8s4btROXJJrbj1H0iH?=
 =?us-ascii?Q?7QE/VKuCYTgiEmo0mWaaJiQE4ae4haP0/X4+szXtoD6kFaTkuIakSP0MW0cC?=
 =?us-ascii?Q?1yTuZJ0i76Mf2pfKxhcWbu1UBg7Nmy1l3pBLJlW9fIu111btGeInxB9jD6hk?=
 =?us-ascii?Q?qiLIqrKL53KKnsewaNz4rYJg2CWXpWgmXfFTVS1ETXre6qyq0qkTdE56gtdL?=
 =?us-ascii?Q?Dz3vqBnXTcO9NqKoJ8+bN3HC/fB9drbRuhc0lNl536CJA48o90oRIBpzTQ7b?=
 =?us-ascii?Q?pBPghaiiB7ro3gE8fUQUwG8Nl4PViX0UYVy7o3A/iPK2e244gE5leUi5H8PA?=
 =?us-ascii?Q?bwtGwaTrdJUpb//Vum2NMnoBqLXQ9pcn4HFnIrWKFAEf/3UwHLYgLTuCsG7x?=
 =?us-ascii?Q?vOVlZig7JwNn+EbjPRjSs5UeyrgFtTbuRxEPUKz5FMp/HsOO8LgkmnyP9P8v?=
 =?us-ascii?Q?6ttplkF07DSxrkyzo3YYfYTSMpFZxGiZV+27HSHJR2gMaYRC/knD9oLb/Afd?=
 =?us-ascii?Q?aqNq2zB/v5Nuac52eDJRgFim+boLJZkJi2Xf2tURPHsCCjWHp2IX+MVXuLh7?=
 =?us-ascii?Q?wOeTrmiXTMcZLDvtOuXWZso6yf5oJ+wNRGte+CJVYC1GBLbHg6XfzvfOVfNc?=
 =?us-ascii?Q?BlUhqeDT0f+tbEmTdt0Jf4VeHpBa6QfhCP6CYgpgosHN5Ie6wCM58woB6+MV?=
 =?us-ascii?Q?dgZ+SX2IOW+AZsVnBLm5Bawr1NkYijR1z6SGQ+E64Y5otVe4JSLkvn/nTIPF?=
 =?us-ascii?Q?BhTdE/a2CHjHg8D7rKM7RACMWn3xsB5xOvclwZooJOkT65mOgrrDrDzAOn7n?=
 =?us-ascii?Q?4Ht4AUBG8+8cyMfCeknh7QEj2kdAJmS2EGaJKsat5/egiqJ90VUY+GT/aMfa?=
 =?us-ascii?Q?5VYvR0hYeMOvajJlxytEQloWAcjhl86WtvuE5AtpNvMFG2KVAJtANqX81bPw?=
 =?us-ascii?Q?tBTpNdRgCU3oHLJcWPTquu/N7pCpyolr29md/SVoE1jNXxXCRIjJtSydSwsb?=
 =?us-ascii?Q?Qk+wWu5rkDY/4lIrE4dfvEKKUE38xt43FhvFFy6IEwP6SzQ1KiQAXjZo4TL3?=
 =?us-ascii?Q?BzZjlPbH/spgCsxOuUtxmTbGnKOtyu+CtPA01jFaigdqXSqF0CCtFVXeyKys?=
 =?us-ascii?Q?6o/Vspy935/WNMBh3700CjbrawsMJ5cFqSIjeN0CF6vyTXCc8YxBA+DIR9yb?=
 =?us-ascii?Q?9NJ4zyC+wQenHcbPWxwJaIBZ/crI52Mh7SP860pk91A1U1gmzKg9J/FlwMDI?=
 =?us-ascii?Q?efgxHBkIabd02tx7Gr4lcaM7nDR4fz1gjZ5S6zEldDIcILsVnjgsHAo7j8uC?=
 =?us-ascii?Q?B7d79McEYCOQitY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:30.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b60490f-f38c-465b-6ed3-08dd35598dd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908

From: Leon Romanovsky <leonro@nvidia.com>

According to RFC4303, section "3.3.3. Sequence Number Generation",
the first packet sent using a given SA will contain a sequence
number of 1.

This is applicable to both ESN and non-ESN mode, which was not covered
in commit mentioned in Fixes line.

Fixes: 3d42c8cc67a8 ("net/mlx5e: Ensure that IPsec sequence packet number starts from 1")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  |  6 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c       | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 21857474ad83..1baf8933a07c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -724,6 +724,12 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	/* check esn */
 	if (x->props.flags & XFRM_STATE_ESN)
 		mlx5e_ipsec_update_esn_state(sa_entry);
+	else
+		/* According to RFC4303, section "3.3.3. Sequence Number Generation",
+		 * the first packet sent using a given SA will contain a sequence
+		 * number of 1.
+		 */
+		sa_entry->esn_state.esn = 1;
 
 	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &sa_entry->attrs);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 53cfa39188cb..820debf3fbbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -91,8 +91,9 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 EXPORT_SYMBOL_GPL(mlx5_ipsec_device_caps);
 
 static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
-				     struct mlx5_accel_esp_xfrm_attrs *attrs)
+				     struct mlx5e_ipsec_sa_entry *sa_entry)
 {
+	struct mlx5_accel_esp_xfrm_attrs *attrs = &sa_entry->attrs;
 	void *aso_ctx;
 
 	aso_ctx = MLX5_ADDR_OF(ipsec_obj, obj, ipsec_aso);
@@ -120,8 +121,12 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 	 * active.
 	 */
 	MLX5_SET(ipsec_obj, obj, aso_return_reg, MLX5_IPSEC_ASO_REG_C_4_5);
-	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT) {
 		MLX5_SET(ipsec_aso, aso_ctx, mode, MLX5_IPSEC_ASO_INC_SN);
+		if (!attrs->replay_esn.trigger)
+			MLX5_SET(ipsec_aso, aso_ctx, mode_parameter,
+				 sa_entry->esn_state.esn);
+	}
 
 	if (attrs->lft.hard_packet_limit != XFRM_INF) {
 		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_pkt_cnt,
@@ -175,7 +180,7 @@ static int mlx5_create_ipsec_obj(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	res = &mdev->mlx5e_res.hw_objs;
 	if (attrs->type == XFRM_DEV_OFFLOAD_PACKET)
-		mlx5e_ipsec_packet_setup(obj, res->pdn, attrs);
+		mlx5e_ipsec_packet_setup(obj, res->pdn, sa_entry);
 
 	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 	if (!err)
-- 
2.45.0


