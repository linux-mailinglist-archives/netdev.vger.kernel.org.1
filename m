Return-Path: <netdev+bounces-97625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9D8CC729
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A94281A42
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BB61474A7;
	Wed, 22 May 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nlXCpcva"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B2146D5F
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406097; cv=fail; b=S0utms5N6Q7qGGyOeNayKlwWcYxf9SZg69cmZ87A4NCxhtuEcgHVaalKjIEFfV1M/djkF5FfQM/fdwNdWDbbLAJ/rYaLnlWu2sv1avz6sB1xbPTTTjzow7zZEjLyX2SRwfzVtuGS70gJMJJqVsVD/npH4GAy7F6IMAD7tEaZLx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406097; c=relaxed/simple;
	bh=ojgbIFPmTQiChkLdjdoVD8903VEsPxBhyYTgIGZ8m7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkAuzPFBDwAZrzL0joVOzu4pPv4N2okr498pXse95fPxdmdwGtIXgmVBgl/raku2QLDSWhIZi+EmmA0aQdEge2x3boDUfWgbQRKIFBAI7UOkPasozZY48O//UvG8vN8OdxUZSbL72MeIdabDtJBKOzS4I1yBVsQDKxWHMXIeHoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nlXCpcva; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxirBBTO8UrvtqpJG31OkL4tI1/PnqTIZG14JEzj+vtZZ50LdA+VA1moFnRygdPQIFwKlVQvf5VieP5NEyvU+a+2ISjsjSA40igGhid2SN77YrEc7BSd1KKOvunGvThY8rNxSL+2+DOv1Ot6e2NkbTi2WCbo87UfrGQSFqsbGJ9FYVXzz4KG8yhNBfmbWwyM7+ThYBbOaVGCJWWvn30tRUd6I8nqjBgrVm86dj3YwbWkxH74aocUVYgi0gMfvloiWgmBDRdEo/iOB0cwqSkl42eM0Fjrz57vadMxa78IkC11CAbMs5Jiu5OG3QKLM4YgVLJjqzFGwKrGaNWd3ZGmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoEt5NNt0PkNhyPbAA9Ia4bY6cPmGkxruRdOzAsPiww=;
 b=EKl2o8znOrOASdlqXj6RoHhLbeoBJxKYbtdHx+ZJGUyquMCXYJZYJof23beagUADnQTYMyePQqkrWYkhNhBuTr4KdkWwCgvAW8dVcgLPd6I0ps5X/jTebY5xspF/UrOouuIXdW4O6e0ySW3u8bC+p3w2pkEfalkAHp4Z1Cc9OxvrL7vo6Ea2+QQ9vNMyxoRZ/bnyG7dyG0LWB2r2/RCP47J66wQmWz91/nNk4h2wwunXkbmksVcKjut+YRch5s/s1vb10YjTv6VJu0Y+1JkfV6wxEQ0wQcjVPBtmbtWPhWOscsMx6N7JiJrPovty6VAPCgX2YMsxnRY1DuYTkxJvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoEt5NNt0PkNhyPbAA9Ia4bY6cPmGkxruRdOzAsPiww=;
 b=nlXCpcvar5tbKuGgJvTaiWndku2U0M4ql2kSSwj/M5wquVeifuzzc4aJv5fDxYwq+mPqzFY+WpTcMtm6oO4ZQkrtdlRXEpZ6Gw2/FRDhZuMIAp2C9Ieh7dUW1AIybU3hBGh0PR0Q1ekD1JF9LV4jIaXQnsorF0pNjI8ykqmNF72wvnXTu2B2votrxCLYwu36QgvXdJY1RLrRKOazu4zJiHCPTDrSdoMP0tAp9QRUQ1pYS6qK6KFseHYyTlYaFZOd98HSVEMqUyJ1tF4C0YWrNqHhvhtaQcAbVkt7F87lgZrZbH5uWJoojEIYWul9/tU5jWkyEAdbc6K98/nJvlRTfQ==
Received: from SA9PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:21::19)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:28:10 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::c5) by SA9PR13CA0014.outlook.office365.com
 (2603:10b6:806:21::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 19:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 19:28:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 12:27:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 22 May
 2024 12:27:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Maher Sanalla
	<msanalla@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/8] net/mlx5: Lag, do bond only if slaves agree on roce state
Date: Wed, 22 May 2024 22:26:52 +0300
Message-ID: <20240522192659.840796-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240522192659.840796-1-tariqt@nvidia.com>
References: <20240522192659.840796-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fc4bcf-b952-4afd-7d23-08dc7a954e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmoxYVpGNm5XSWpzanBCdjI0ZHR1a2N3Q0F1MFNEK2hEMXdtczd3OWhZU2FI?=
 =?utf-8?B?MjFqU0FSbzRheFBlY1B6SFRQck1mcTdReWNnaFBqUkFVbkQ2dVdaODNYOUE4?=
 =?utf-8?B?YW1yeUhHRU8yTlMxRWNqdm5XNDFtQzh3Y09Ga05UNnRFeitxL3ZyUWZhMzNi?=
 =?utf-8?B?c0xMNzhXd2JKZG11Q2N2aFRzU0VtYytDdlZpK3ZnQTgvaTVVQWZtcDRFdE9n?=
 =?utf-8?B?d0EyRENZSW81dzhDOFo1TFlTMHpDR3NSN29TckF2ckNEL1o0elFKSXJvQ2Uy?=
 =?utf-8?B?MkRvTWtpUEd6N25CekhlUUJRMVRTd1dMRG5yNFplcXYzd2xRYWphY1VKampF?=
 =?utf-8?B?a1FBenNJeGR2UTdPMG1BcWdjTHNxZHhqV0t3Q1pEdERQUzJUbVZHZitJSW9E?=
 =?utf-8?B?RVRoZHk1ZlgvQVhpbXhtQXJDN1UweTJpUm4ya2xESGdtSEVBWTl4T3lodEts?=
 =?utf-8?B?a1pyNHA5NXBCVlV2RXhEYkdKdkdmQ0lySDNQL2I5TlBEV0Njc0ZZTXhtdDJv?=
 =?utf-8?B?US9GanJ4Q1ZvMXJKNVRnbzlLSGRXaERydlNDVHgyY1AzcFN3allxN045TWZr?=
 =?utf-8?B?eHNFdGxaalVFcCtIVjhoRlZQdTNhRHVQdjZHdXcwc0I5WTV5VlNmZjYwVTNS?=
 =?utf-8?B?U1prcDFOTHUrclphUmdrTDZ6WkdTTlM4VEJUcU5YcUUySXpBcXY3b2s0clY5?=
 =?utf-8?B?bHhHeWtxWkFpcjQydmdNL01JNXpzUlJUYXRhK2hCMHYzdmd1V0tvRlVJNHRt?=
 =?utf-8?B?dlZoemRIUVlqbCt6Z3BCcTl6SGw3U2FkRVdWWmF4b0VXbHVCRnVxSDRkd2Z3?=
 =?utf-8?B?M2RDdUVLdEVWN1pkTmplZkVRVW5xM2hGeHlXaDN1Z1JaR2traWF0Y2J0OGlZ?=
 =?utf-8?B?VGpFUm13WnVsdzNFQlQvOHA3bDQ0U202OGNYcC8yV0trYnVzNEtSMEFNdW9U?=
 =?utf-8?B?ZXdaMkpVQVJRcEVyNkhZT1NWSmZXT2hxOS9vZEx0cUJHeHZsbk1vUzg5dlRG?=
 =?utf-8?B?RXFDSk93alNtNnlJcXFQRm1QdFVkYTZXZGI0UTVTYzdTTVVEZWxKT1hHVU05?=
 =?utf-8?B?V1ZmZ0cwMlFyK1c1QmNoeDhZWFc3MVFCbnZwQ2drS1daZkMvVVB0aE5ndkxX?=
 =?utf-8?B?TTdYRzgvdmhFc2UydGoxYU13YU1EcDZsZ3A5RGVQa05reUZZRlJ5ckZ0MnVq?=
 =?utf-8?B?STF0ZnhXWU1YeTVOZzhaL24za2ZJci9aeUVvRTNPb2pzQnBpWkl0U1FCa21T?=
 =?utf-8?B?MFgxcFF3dFV5bTRUMHFvTDlXUHBMWVpNSkJZNkZlUGF3N1Ftc2x4VlE2L3Zh?=
 =?utf-8?B?UmdUbkNYVU9QRTJYM1hRaGpyWXlXdStXMWlvbGtWem9RRlRVZTZ6YmFjakFQ?=
 =?utf-8?B?MHh0aGtsUDZKWVM1ejMwUXN3enBqTTF3SjUwMFd4UCtSOXBwRElQS3hUdzR3?=
 =?utf-8?B?ekxiVHhpU0lDZVJkK3h3b2pIbjlMa3dJdi8weFVXZVA0Wk1qaVV3UUVBcHpN?=
 =?utf-8?B?dU5yR2tyb1ZKWkJqSURobHFXaTJ6MUxLNkRaSjQxSjZKSHBRVGV2ZE9VL08v?=
 =?utf-8?B?OHRwT2h5aGtQM1JNN2R6WldIWGdHZlJ4dU9SMURIb2NocEhkTkJzNXVuTTVX?=
 =?utf-8?B?VWRQYkRPT1RETk9xdVQ5bjd6eEp4ZGtyT2ZMbFZtZDhMVkdreTQ4eUVJMlla?=
 =?utf-8?B?NWhrWmQzL3ArZjdHbXhXYzRWUldESXBKZHZWM0Q4bythOGYyYkNya3ZJUDln?=
 =?utf-8?B?cGZ1VUFIWkNERmZ6SW9ub2MzODZPcGNOYXFpdThmWlc3S01LNVJjWTZBWmRk?=
 =?utf-8?B?N1lrTlRCYVZtRURLa2o4N0hyczlnQlVPcFY2aTZEYS9lNDltNmhWWisrNndG?=
 =?utf-8?Q?XdNXZPtd7UrBY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:28:05.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fc4bcf-b952-4afd-7d23-08dc7a954e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794

From: Maher Sanalla <msanalla@nvidia.com>

Currently, the driver does not enforce that lag bond slaves must have
matching roce capabilities. Yet, in mlx5_do_bond(), the driver attempts
to enable roce on all vports of the bond slaves, causing the following
syndrome when one slave has no roce fw support:

mlx5_cmd_out_err:809:(pid 25427): MODIFY_NIC_VPORT_CONTEXT(0×755) op_mod(0×0)
failed, status bad parameter(0×3), syndrome (0xc1f678), err(-22)

Thus, create HW lag only if bond's slaves agree on roce state,
either all slaves have roce support resulting in a roce lag bond,
or none do, resulting in a raw eth bond.

Fixes: 7907f23adc18 ("net/mlx5: Implement RoCE LAG feature")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index f7f0476a4a58..d0871c46b8c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -719,6 +719,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	u8 mode;
 #endif
+	bool roce_support;
 	int i;
 
 	for (i = 0; i < ldev->ports; i++)
@@ -743,6 +744,11 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
 			return false;
 #endif
+	roce_support = mlx5_get_roce_state(ldev->pf[MLX5_LAG_P1].dev);
+	for (i = 1; i < ldev->ports; i++)
+		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
+			return false;
+
 	return true;
 }
 
@@ -910,8 +916,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		} else if (roce_lag) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			for (i = 1; i < ldev->ports; i++)
-				mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			for (i = 1; i < ldev->ports; i++) {
+				if (mlx5_get_roce_state(ldev->pf[i].dev))
+					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			}
 		} else if (shared_fdb) {
 			int i;
 
-- 
2.44.0


