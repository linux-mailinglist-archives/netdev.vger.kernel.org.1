Return-Path: <netdev+bounces-143040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2F9C0F3D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D911C2193D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F197217F43;
	Thu,  7 Nov 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XAN6gF77"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036542178E3
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008754; cv=fail; b=pzD0OJvHw3Oisc0lMvFOv+xEAZinRTKpbmqPCWTGN8PzjA6XBkOdPhG5RMIQzzuMaRLz1J6gmzevhURUJsEACJpenU1cTlmkYb0n3C3Y/6nONmR9xXLGQ4Aau/BFQ56135LfisdE0NSm+ai6rRkeJf/MkT5R790c6hpISJn+lA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008754; c=relaxed/simple;
	bh=xXf3pOgv20Q7EWdQWzHCNmjtpcu/urQo5vpGuisj0HU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsK5MPIYTIIVFyp4HFoeFwzDUUNc0mMqrJF6e9GykDZ4Ryc/Swc+FJxFQImOy6Pk6fuoTo7WbHw92wlrkw7E19DW7vHczeCzYuTcfmHd8D8dVsyEyr1hA0uPWxqYubS9L6zgy4PF79RTOAfAfYQ7X83dDxhazn4bAutsNRKRXwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XAN6gF77; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7fxFxb40VdgXr7QGn6xuseu5lkRQE0jxXyyr1j68+tXYZb8ModX+SJqA4uzPiXa/hOl0J944BSaMkBRcwmgzWL4OEpz8BoZukGkyXrYR7jPLy7aXFfa0+DUtlM9FNbfJA/gZV1yc6BBcbgPnon9u+gXYjSD23rGJ0E89ViTmfiYgj91iYQ7yYjbE/XQCQnaMgW9PN0nfkHNv3Mer1WLmrDYzOKGU9+cFBtIsae4SKrYqpvjmUzyfBOb1LQ/NY1aWr9cXOGGQWQ210RSHJUdCRqqDSRcK8ssGi92XP5FRZ7Zrv9wGqBE6yIFoMVqqpl9gZcZk5Sr4VlqaMIYntI1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRAJOHiorIYcWl1WCU/qGD4wnzlzIrCyIMw1u/IiifA=;
 b=xnOr6aO7dr1/ek5wRrZrwHnMbt8FByRLU/0djBIPAuRT6L2weSvGmZQlnOTSk6mgLqQE8tNkPEOTHdYVW3+4QMJJiEDH6Fqqvz1qnxECCbjDMoAL3RENGIdmPF2tYN9UYpOWlaMON7pibqgu5wJaMzi2TH0+ck7FDc8XUXyeyvvpqC33XJgpD9yObtoWFhTBcXsRqQyZ1IvP12sd2elmSV0xvyFNAgTMM/+zPw68047/cXbe36ZCpdM04tYZQu3/vDX771P/mToe6G5LGm97VHKCXcRXCvDG8DvsQgphx+rYfc3+MUYNykb1zd5XKdXMwlySn/tMfaKFs4xu0iCSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRAJOHiorIYcWl1WCU/qGD4wnzlzIrCyIMw1u/IiifA=;
 b=XAN6gF774dALknxRIW2lYt3B5V/Bi0AyjkgxqBLgSPpI0lOuL4QhdFy12Uk87rK5lnZS4ogTdASpXKeUG+hkGwzWfzUiD9yg04BG4+he4/IBTh2MATm3EsfrH0wHTKMlCgDK18lHLAQaz9TEmvc6GO2V0cdSlY5XXFrv4mTmpfMZ8Z0L7NjxYWBVJycTkcuajRSrlw/pvwpuqbyrONdjS/h85taRHOY3RXrVnVu7FFaasNzZ6w4lMoFdUoCYtfeGTYiKPSPaMbELF3ACsVzbaL9CRPvRcgFxHaYiGyfCueF95rorQDXSMS0mueykqte6Zf/uRWZ/+UkKL4OcM4VTsg==
Received: from SJ0PR05CA0188.namprd05.prod.outlook.com (2603:10b6:a03:330::13)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:45:49 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::b5) by SJ0PR05CA0188.outlook.office365.com
 (2603:10b6:a03:330::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.16 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:25 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/12] net/mlx5e: SHAMPO, Fix page_index calculation inconsistency
Date: Thu, 7 Nov 2024 21:43:54 +0200
Message-ID: <20241107194357.683732-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: bafeac22-b435-4b06-683a-08dcff64c769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1M/AHMwU79L7ROrGtc6rIiju+aW8yT8eWAWaXuI2UaNCCyFod3Yk93s3gSHw?=
 =?us-ascii?Q?mCVH9VG6p910N/kwKKv/g529LusYtH/v6XunD1aT+RGemXRxi5RFMQXKXCYx?=
 =?us-ascii?Q?yLIuyXUuM69KyXTQ5MIUzesCPJ7/m9JFv/XMMcbEJPvTpx6sp5lfOa+IcMSO?=
 =?us-ascii?Q?CiKHyStEA+w8e5M/Sy8T/+3ampJMRBbXgHhPAty3bd8yWRsmguIN+6d0OynG?=
 =?us-ascii?Q?kxY4Rvgz0jRKIWSWFV/roX5Ga4hDRZXR4LBW/oCJDeQqzixYABYk8prX75vc?=
 =?us-ascii?Q?DW0YyIW/rhTrp4imLIwL3LzIMYKQ1vSkQmvzRRb220iI57gccfgjSIe50EjG?=
 =?us-ascii?Q?ei+thZ/hferFulqp2LfRBcbUhKEbhOHhT/m4cMcectqgGCv2jb/aktvG4unF?=
 =?us-ascii?Q?KbvzTrepLAbPEfoSQJKaDXXaf/IdSBUvcmx+so6b1GWROTQCvD/Y3e9RLEFo?=
 =?us-ascii?Q?hLO//yRVE1z/iFH4GOOIyUQDCYuLucGt6ChEShNeft3vPloZUhzW0oj1YXC+?=
 =?us-ascii?Q?4F71a75prgppo5+G/kSVyHPd+yAQ5M7i9eSZ1sc8SvDwPkWcekxSwpflOLV7?=
 =?us-ascii?Q?/Paulg/7x3vnoZgnO7CQvAAu1Krdo/PkoDpyA3yfvm1rD29Rtwq5tLKgCJPw?=
 =?us-ascii?Q?g0RLAdoK5PEE5A0A9E0ZNxp70O4Zk5FAkAsFVt1Hz+jJ9SbkwxH9SLHmIGyZ?=
 =?us-ascii?Q?BYevZucOnbZJZ5NKeIrLhxraLR3V73yxk4jG+RQ6aE6Xf4s9uh3I90L1+fTX?=
 =?us-ascii?Q?8uVK/YzFU9g4FptYGWrgEjURBaAFpoTUAWAlCFENyTG9o6mqAzODqPLde4K3?=
 =?us-ascii?Q?/+oAkpgbHwzAfw+hbhz5h5l0RkXnIyPh62VH3qp1EF4ZGyAghGcNfswLFIOE?=
 =?us-ascii?Q?M0/mMFcIQ2lEN8PiC5BW372xh7jYTaXhmFOChSF6mlMy2pq8PeMtx/XbATAe?=
 =?us-ascii?Q?wQBeo1Sxn1qqenT9SRrtU9zQkMGD2WUII33es0WFe4AxEqSBdbx5ypP7zq2/?=
 =?us-ascii?Q?Rl9IOOMAIi9F8iPFrQ2N+HPetqeCPiEpa4ggqj9hM9X45TGaNHx3Ti7F+78I?=
 =?us-ascii?Q?iQDxHZj4jP53drkVB6MXVQ2tVN9ZTyh09JLvWsVHG+mFf9Nx302SK0dVYg3f?=
 =?us-ascii?Q?014A7bxvATxErdUhPKiUlW5pMT3RhL9x1MBOq5e7NvacLOqjzvHmUFLJgtMk?=
 =?us-ascii?Q?1U9Z2c3lvDt+F7pIEyczEkdTHbw0f11TBmwaD0Zvr/YEXrSxRlV0rwHyPMzp?=
 =?us-ascii?Q?6cxyaZValQR9fpkdog92xNclPFEso/Ad65lms92nykb7ckeINWkXta0gNLUT?=
 =?us-ascii?Q?OR9n7g3DoAnrSfOxrBeyeHTwdM2que+P9+ZWNxzW/LhBCbGCd5GCHaTN6e7K?=
 =?us-ascii?Q?qcl+Axyk0w0tefe/7zRDI1i59M/jspVRac9hR+stW5+3Cq0KOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:48.6216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafeac22-b435-4b06-683a-08dcff64c769
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

From: Dragos Tatulea <dtatulea@nvidia.com>

When calculating the index for the next frag page slot, the divisor is
incorrect: it should be the number of pages per queue not the number of
headers per queue. This is currently harmless because frag pages are not
used directly, but they are intermediated through the info array. But it
needs to be fixed as an upcoming patch will get rid of the info array.

This patch introduces a new pages per queue variable and plugs it in the
formula.

Now that this variable exists, additional code can be simplified in the
SHAMPO initialization code.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 +++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 4449a57ba5b2..b4abb094f01a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -629,6 +629,7 @@ struct mlx5e_shampo_hd {
 	u16 curr_page_index;
 	u32 hd_per_wq;
 	u16 hd_per_wqe;
+	u16 pages_per_wq;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 59d7a0e28f24..3ca1ef1f39a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -767,8 +767,6 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				u32 *pool_size,
 				int node)
 {
-	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
-	int wq_size;
 	int err;
 
 	if (!test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
@@ -793,9 +791,9 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 		cpu_to_be32(rq->mpwqe.shampo->mkey);
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
-	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+	rq->mpwqe.shampo->pages_per_wq =
+		rq->mpwqe.shampo->hd_per_wq / MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+	*pool_size += rq->mpwqe.shampo->pages_per_wq;
 	return 0;
 
 err_hw_gro_data:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e044e5d11f05..76a975667c77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -671,7 +671,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		header_offset = (index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
 			MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
 		if (!(header_offset & (PAGE_SIZE - 1))) {
-			page_index = (page_index + 1) & (shampo->hd_per_wq - 1);
+			page_index = (page_index + 1) & (shampo->pages_per_wq - 1);
 			frag_page = &shampo->pages[page_index];
 
 			err = mlx5e_page_alloc_fragmented(rq, frag_page);
-- 
2.44.0


