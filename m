Return-Path: <netdev+bounces-100358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D786C8DAF1E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382BEB257B1
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415B13C681;
	Mon,  3 Jun 2024 21:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AciXWqpJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E019131E2D
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449827; cv=fail; b=IHNqIJzxrI5TmBr0/v+0rXh7CONEsDWA8g8xtf2AzaHEyJ+NPPC8Cfn5h6ZZIjmOZY2FeJhgInL9lbgtEBIxNCkyw+1ITuvj9ECyKU4kk+1IHhx1tpz9OGbFCtdJie2FOMaEQcPuEyFqqNzQxbAe3/wMRBFx0mfTDZhmXEcCCg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449827; c=relaxed/simple;
	bh=f6qaWl9uqXnDua+hheNzGbWRJXbHOEk3c/6udhR5iQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ik3+zLuADu/ocmyycauYoHHBcmrNxTH9ldUcfCoesMqUOkAtBzK/1QDW4/5HL7i0yiot3J+Xw32vKMnYo4MoxaMuqamlJPxv6AVGM+2yFNTUcvs/VvWphFO9F+tYm/nYjgAjmvGjlGmgzLiweDoIJPU/E1YbW5cWIc0Xe+cuu24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AciXWqpJ; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIn9qQwTNuVaUg13TQWBRqthgr+uoIMt2GC8VygSY7OXXffSPIeBRn08NCiDVj8Ix4W3eV2bYzT+gLyyhYxzzhlkJ5qPJmWPynYSDQgIgftzYre2JNymixhbC9XIhBzAzrFGOa8fw9s46RTZH7KIZg0YmQDEKNWRO9QrYGk1sFGuTlX24d7kvWSMQu44QjoZd0zHqem6YbnlF6nn88W/vO6xZcYURyMGKJGY7Kg9w0x4UAuEya3nB+khW0CbkD4FVVThUNlCzup+9DIgYHZs3h0FBgTFYbwLzyzT6FAi2o9C87BIITtRByfLmCF2ANSIlxItBq6p9kG0beTgcMgFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xegAKYaLoRJxVG9Qo94I8txaHZ8DaIEuX8Xi0A6QQeA=;
 b=b7ibklpmNJ/l28NMykyWvor7vohl7WW0AtW5QIEFj7BESlkCvQEbODRDH4yjvhy/qsRHJprN5oqH0fUQ3eh8W14dTV4bmxjz8R8IhcaEbpJVHlzBdu5K+ZAiUIX1LJbdEwh7eZxmDyIg6qk2V+XiBgaJPwZ8jFnepkNeQzcPNDD9jl1agF8/yzEmm2O3hIduBBugQ90UHTFPoQUhoDo+f4Lg265JK44ojXzgAxAG4IhoPe551sop1agO5LwxKRdkPR4ELXfNVldaR/c+um2EGiNo/L7TlGGG76Ci6lxMX8HuQs58nk3gri7N0DvqboLpBNKQ/EoyDPMJsi+AK86Rrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xegAKYaLoRJxVG9Qo94I8txaHZ8DaIEuX8Xi0A6QQeA=;
 b=AciXWqpJXm8TFAt3oE0bUbsXOU7gbTdW2DrMuS0R+eohBL352Kv9DiSgDHr+uNe+zz9csOsKIGiieelZzguyfnFkfLmgcP9YRb/VY68BVvnvelJL/ld4seyw9wjZlAZ+RFGl8yBzLav8wPskFXlzpw1heK0E05A99Ps2JXs40RUPh2kzNVWNnvQeDB2ibPYBcEgxyYt0PIGnyJW9hkwcNjkJAIaBxCfDNW+iXFJFWUu0kDXEDELv87ipXn+eDIDU4qbOm+CrauEO8bYhvnG/sysT2ALBy9KPv/bBgTPChreKCbe3gpFpi5S6u+RI+bmnhiy6rKGjVWQk1hyChhd7qg==
Received: from SJ0PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:33b::35)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 3 Jun
 2024 21:23:42 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::9c) by SJ0PR05CA0030.outlook.office365.com
 (2603:10b6:a03:33b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 06/14] net/mlx5e: SHAMPO, Simplify header page release in teardown
Date: Tue, 4 Jun 2024 00:22:11 +0300
Message-ID: <20240603212219.1037656-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fad25cd-76b1-44b1-2ec1-08dc8413713f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8QWX43U1TK9EiSZzR9JJsgPBIxavRP0w7hFGifu73rFAYm05cmg/57QJcQa6?=
 =?us-ascii?Q?zFLdSpdKsnNuagx6I3zMyQ6/xULBVwmv9Mx1mqzoJjAR47mySIoKqQOxRMFD?=
 =?us-ascii?Q?kJoRjwO/PL3bJGY5P1m+1QZdBi+vCPUEmOqxH6X/ks/wABK+mgh1GlWKACOR?=
 =?us-ascii?Q?3pr6XSelpmtSUZhXZ7O6GfcTFWQp+nrL/uwWveTGCJv7IC0Upu/HjPWNHJpA?=
 =?us-ascii?Q?z4QeEsiXjdSe+AhzRSHqWfwSJ5/u3rBzX5mYy+5nMQIxZjjvmYBb36VejUas?=
 =?us-ascii?Q?ArEDIn23mTKhnk//fA57aGeohPFJzksaWfiFY1GWc1Svc1kqS9IVSNVDl4wF?=
 =?us-ascii?Q?6sg7PWRhDMcHtHfATkH+h40EexcmU00F5tLqsJLuDpv7XhRLNQ7Tzzen7dwL?=
 =?us-ascii?Q?m/4RlGK+CrC2N8puIoEn/15n921SJ/IlGkZDAhSvOlvwhwWrJV7Nkf28cI4w?=
 =?us-ascii?Q?wBiONDxMNvRB6af7JOX+KxYX+f7X8CyKlhE5ZKPEwCiLq2XiGTkIZE1Tqx4Q?=
 =?us-ascii?Q?XXoxgUiz7NJFVrgQtqyx4kOAALwaUfooG0QiooSuRkMmh9Gzzb/Kpbn0WihG?=
 =?us-ascii?Q?T05rmZDvmDZQCaiRTVqy9laBagTJtdR3Db9VG43vQHrdJDCsf92Hy6pm2jcL?=
 =?us-ascii?Q?nj/vlg5jIJoVyN0z5suwUr7bsVNde8ZjcGLUyq7ne16ed7bLMjmF4hUCTa/s?=
 =?us-ascii?Q?LyTWqvp5bkFJrYLWJXFU71PEQe7gDDPhsuBtw7FBj+z9xy0lY3pouPRTrRB4?=
 =?us-ascii?Q?EEux2JzncQZnQLWB8WQju/1dNYcsp4DGjxgaKVBkPP0Y/+hXxEVYuMshAfp7?=
 =?us-ascii?Q?x2zMjG5i35UeOzEdVeWcmcg9lxTBZaKkPZq+tSwlfSHZO6wPMeXMGvQo55KV?=
 =?us-ascii?Q?a3RiYXGPr1p8Gz2K7belyEIXvNTwZ5vePbNc4h/FtpxIZfyYwNfpPaCDec13?=
 =?us-ascii?Q?N2C/bT/YlaP2BpRhtO3SD8wrpF1MxOzjzuZ50CmNpt1RLHcS6brRC8mXUg/f?=
 =?us-ascii?Q?Kzfm7cku1a56uEgIyBUulHUQd4iDmjMYWhn/Mh1qSBFSaV4ryBb8jrprmkij?=
 =?us-ascii?Q?rfugysMOwJGdcnoa7k5ElxAYY2xSGjX3JMtbyOLf6cEdry0TjdgAtfMMryMo?=
 =?us-ascii?Q?4hbcnBBcw+7SaK0AnrozfED+XMXQBptmEPd0CkjtaiI03D0qYW2aCTEzyP7/?=
 =?us-ascii?Q?re7DscjjSB0urwj2SSwymHgBjWw37btSWYivIcCposBI2+cxUsrVEt1CtOzA?=
 =?us-ascii?Q?WeQPFP8FhUtdNzctqDilUG5kdNbW5z2YGtzzboAwSyI1Lq1Jf6oIW8jlvSf4?=
 =?us-ascii?Q?BzUEco4eTM1ryvXvxoAYn+fQbSeTFMpo8zuDtym7no4Qk9U8nJ+2EyAju7gL?=
 =?us-ascii?Q?9/fgTwk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:41.8822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fad25cd-76b1-44b1-2ec1-08dc8413713f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976

From: Dragos Tatulea <dtatulea@nvidia.com>

The function that releases SHAMPO header pages (mlx5e_shampo_dealloc_hd)
has some complicated logic that comes from the fact that it is called
twice during teardown:
1) To release the posted header pages that didn't get any completions.
2) To release all remaining header pages.

This flow is not necessary: all header pages can be released from the
driver side in one go. Furthermore, the above flow is buggy. Taking the
8 headers per page example:
1) Release fragments 5-7. Page will be released.
2) Release remaining fragments 0-4. The bits in the header will indicate
   that the page needs releasing. But this is incorrect: page was
   released in step 1.

This patch releases all header pages in one go. This simplifies the
header page cleanup function. For consistency, the datapath header
page release API (mlx5e_free_rx_shampo_hd_entry()) is used.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 12 +---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 61 +++++--------------
 3 files changed, 17 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index e85fb71bf0b4..ff326601d4a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1014,7 +1014,7 @@ void mlx5e_build_ptys2ethtool_map(void);
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode);
 
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq, u16 len, u16 start, bool close);
+void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
 void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d0808dbe69d3..d21a87ddc934 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1208,15 +1208,6 @@ void mlx5e_free_rx_missing_descs(struct mlx5e_rq *rq)
 		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
 	}
 
-	if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state)) {
-		u16 len;
-
-		len = (rq->mpwqe.shampo->pi - rq->mpwqe.shampo->ci) &
-		      (rq->mpwqe.shampo->hd_per_wq - 1);
-		mlx5e_shampo_dealloc_hd(rq, len, rq->mpwqe.shampo->ci, false);
-		rq->mpwqe.shampo->pi = rq->mpwqe.shampo->ci;
-	}
-
 	rq->mpwqe.actual_wq_head = wq->head;
 	rq->mpwqe.umr_in_progress = 0;
 	rq->mpwqe.umr_completed = 0;
@@ -1244,8 +1235,7 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 		}
 
 		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
-			mlx5e_shampo_dealloc_hd(rq, rq->mpwqe.shampo->hd_per_wq,
-						0, true);
+			mlx5e_shampo_dealloc_hd(rq);
 	} else {
 		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
 		u16 missing = mlx5_wq_cyc_missing(wq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index a13fa760f948..bb59ee0b1567 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -839,44 +839,28 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	return err;
 }
 
-/* This function is responsible to dealloc SHAMPO header buffer.
- * close == true specifies that we are in the middle of closing RQ operation so
- * we go over all the entries and if they are not in use we free them,
- * otherwise we only go over a specific range inside the header buffer that are
- * not in use.
- */
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq, u16 len, u16 start, bool close)
+static void
+mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	struct mlx5e_frag_page *deleted_page = NULL;
-	int hd_per_wq = shampo->hd_per_wq;
-	struct mlx5e_dma_info *hd_info;
-	int i, index = start;
-
-	for (i = 0; i < len; i++, index++) {
-		if (index == hd_per_wq)
-			index = 0;
-
-		if (close && !test_bit(index, shampo->bitmap))
-			continue;
+	u64 addr = shampo->info[header_index].addr;
 
-		hd_info = &shampo->info[index];
-		hd_info->addr = ALIGN_DOWN(hd_info->addr, PAGE_SIZE);
-		if (hd_info->frag_page && hd_info->frag_page != deleted_page) {
-			deleted_page = hd_info->frag_page;
-			mlx5e_page_release_fragmented(rq, hd_info->frag_page);
-		}
+	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
+		struct mlx5e_dma_info *dma_info = &shampo->info[header_index];
 
-		hd_info->frag_page = NULL;
+		dma_info->addr = ALIGN_DOWN(addr, PAGE_SIZE);
+		mlx5e_page_release_fragmented(rq, dma_info->frag_page);
 	}
+	clear_bit(header_index, shampo->bitmap);
+}
 
-	if (start + len > hd_per_wq) {
-		len -= hd_per_wq - start;
-		bitmap_clear(shampo->bitmap, start, hd_per_wq - start);
-		start = 0;
-	}
+void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq)
+{
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	int i;
 
-	bitmap_clear(shampo->bitmap, start, len);
+	for_each_set_bit(i, shampo->bitmap, rq->mpwqe.shampo->hd_per_wq)
+		mlx5e_free_rx_shampo_hd_entry(rq, i);
 }
 
 static void mlx5e_dealloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
@@ -2281,21 +2265,6 @@ mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
 	return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
-static void
-mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
-{
-	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
-	u64 addr = shampo->info[header_index].addr;
-
-	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
-		struct mlx5e_dma_info *dma_info = &shampo->info[header_index];
-
-		dma_info->addr = ALIGN_DOWN(addr, PAGE_SIZE);
-		mlx5e_page_release_fragmented(rq, dma_info->frag_page);
-	}
-	bitmap_clear(shampo->bitmap, header_index, 1);
-}
-
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	u16 data_bcnt		= mpwrq_get_cqe_byte_cnt(cqe) - cqe->shampo.header_size;
-- 
2.44.0


