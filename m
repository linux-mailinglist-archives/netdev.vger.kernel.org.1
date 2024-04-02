Return-Path: <netdev+bounces-84056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B425F8955EE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D261C2238F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0532D85651;
	Tue,  2 Apr 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DhMWmZam"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F5126F33
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066287; cv=fail; b=geXTM/MCLgFoI6mkt9DJqNZwt2aZfXFs+WK3SzdKJ26xNntVGiNa/ZVsevYqv88ITVFcSWtg9ZiJetl2LozVdh1ytfhJsfINRStlvKxbN5HZusInNg/ss7SEsNYOCHc6orr0m0C2cJtjo+w2HeUwQvM6ePYVu5LAWUeSmCnZ8/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066287; c=relaxed/simple;
	bh=Mi+DmfUSWiDH/o/GDggIrLjCvHkisO5U0fpYgRwM8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFhzKk2hTCk/hQttNht1oj9RBwg+dC2ApRVQDB6Xu4djEEis/j95iyabfJRIHdCINXJJau3iSs5+hP2KW8u97RHHCRkWEN8Wh05B5G+ptCmGcSNzfo+T8fd/SN1PLbBOTkUioqGzLxqJS/SmIjB3akakr3Fq9qqcqik9wd3CVuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DhMWmZam; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Znqg2rCb2e0UtCYHQbUSH1KSgwuj7PCkCFrQutKfLL1o6KBuYlzIkYGSdCvimYnAK8FaXhJwTNu65AQ+21+v6czfinbVHJAsazY62h3UyDQzm/FxhXgPXkHi5cE2HoudGHGN9YdMYOLbQXOsb8M8Ok9d2+Uszrvw3tQOWKyKv3/hIqmq9zaNDuiG9Rl/n37NbiouQzgUtDhogSMQdcBIFmXPGRmRo30VbqZgJ9EoccDRxcuXfGfbMyvEtMCT3i5Xr7RdPJ4HyHlZYFw4StX7qzDGzjzwe0QX+5czC/tubbq7j0jLhvD2zdQOxlAkZ5nE2s0Piz4o5rjTHWHf6ZS8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaMgLSRjyr81vuKfjA3CbCdNQ5kb+Own/3JHz5tvW00=;
 b=VUDpV13H+HIyLJhoPxM8iJLU0O4UYddGh/mjE7ueFJv7as2x4zeuy6hS/aiJ4g7Abt3lwv4khinPaqp3J0XTxh6ruVGLOlyrTDiWPbt5nTMX17gS0Ssw533vlwdvefak0uJvrmRTXBnwjHA+ECOUgylsMeOTasUnGbz6ec7b6wfEHgkBEl3kQO6JxsX8dmHlz02caoLvmQ9HxDVpcCtB+ywmP496MDtnC85VVy8RNi5ZkAmbnOZu+rLUlF+elcXg9TgZNeXc9W/55NF1a31HKS5MC9bHOGTCJ5nimT3EO0iM6tBjJc3IKpvl/eGKABFY2b/zVBo2PLwlf6CW7nE0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaMgLSRjyr81vuKfjA3CbCdNQ5kb+Own/3JHz5tvW00=;
 b=DhMWmZam+1ljCkgdHrfSvfxZCOsJAVc1HHCsskS3mJxUymWTzMQuIrtpfvug8VZO+dO4mAEMiLCupeZQpBg2tho5g7IMqp+iDU1gij9i3xw48bq6MXDgiRNCAPNG3ipWuYrp8jOI5D6wFYeYEo7G0AqRbaHxzZFEDni/pDAwPqtXuFmbkjBP9mwx1/hzd7AZMuZcVu/eFSRs17PVSYiS65LnrDM16mRIdAKyWYfs5XJ751rDHsoZOCkYkGLuX6ChPcwyGjdHVG00MKMDvGtl2Y6EFeePFER86VrAqO9h8ryqMe2esKqHs9uiBdEBKepfIZBxKOsRwqaHR7YcsOnzoA==
Received: from BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:57:58 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::86) by BYAPR21CA0005.outlook.office365.com
 (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.7 via Frontend
 Transport; Tue, 2 Apr 2024 13:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:57:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 13/15] mlxsw: pci: Remove mlxsw_pci_sdq_count()
Date: Tue, 2 Apr 2024 15:54:26 +0200
Message-ID: <0c8788506d9af35d589dbf64be35a508fd63d681.1712062203.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712062203.git.petrm@nvidia.com>
References: <cover.1712062203.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ac3950-1e13-4afa-2d1c-08dc531ce730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QUU1Q9hMhsTrDZ3nPMAbq7VJejiTK0WID/sM3GHWK3V69P7SsB4Pr1jXjbZz4lbYLqxt1k00uae9iFDR2AsNxXEtHqhPNqU1R9uJ0JjZjvMTt0POd6bxIDF5TQdmaTKHLSgt3ysPcC2H5vRV6dQbuFALqH3+hkLYFYceopB7z2iIQ888W/M5370oslHFSjQQ2t89syzshvX8aWrwefGpVY6sUezfU4PLNonZejE/CT8c3JtQV9hQvl0MvjVwiStAkieShtz2ZSF4M4K4uTIhWyJwYF0fU9OmLOlj8/g9NISmd9vnbjxMF+BIkGX1SxcJTFPnEt6gSm2RSVcmyRk06H4nasZf1vsAlhaufpsAIDIsdjom4sCy9Xg50KH2+KoaJW2Zm2rQTAlKEDCe57f/ciatGoq1vTSScQq/jLK4abFOW8xLw42Q9Vx6C5ng4jOCERU1hy3m/vAf3oswf0eMLeiNQUjfp7wF/IJIp2kUYsdoZbKbef9KPwTwj3kKCxxW3XFHuSJ7C3ZjMPqearx3ex7moAXD1zKdwC7hWyb1jxwdIfe1D8GlQ80f5Oy00bSCbb3bkK6lgUXvM0LUsFgcPYIExB4/J6V7Tb9Gf9cZXt5j7dk3XZexvUFjhajMwFBVphf+uvGF+agSTE14k346eXNJqrCVKYXTxepH44YOSJmK6k8SdMMVN3Zw3HRML4oR6gtnYkKpbOrZg6TFNpjYD6JApx8s1xqEyUi2SCjdsnGRX123Ki7wChk64pHYDSVQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:57:58.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac3950-1e13-4afa-2d1c-08dc531ce730
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

From: Amit Cohen <amcohen@nvidia.com>

The number of SDQs is stored as part of 'mlxsw_pci' structure. In some
cases, the driver uses this value and in some cases it calls
mlxsw_pci_sdq_count() to get the value. Align the code to use the
stored value. This simplifies the code and makes it clearer that the
value is always the same. Rename 'mlxsw_pci->num_sdq_cqs' to
'mlxsw_pci->num_sdqs' as now it is used not only in CQ context.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 1839ab840b35..a7ede97a3bcc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -123,7 +123,7 @@ struct mlxsw_pci {
 	struct mlxsw_bus_info bus_info;
 	const struct pci_device_id *id;
 	enum mlxsw_pci_cqe_v max_cqe_ver; /* Maximal supported CQE version */
-	u8 num_sdq_cqs; /* Number of CQs used for SDQs */
+	u8 num_sdqs; /* Number of SDQs */
 	bool skip_reset;
 };
 
@@ -188,11 +188,6 @@ static u8 __mlxsw_pci_queue_count(struct mlxsw_pci *mlxsw_pci,
 	return queue_group->count;
 }
 
-static u8 mlxsw_pci_sdq_count(struct mlxsw_pci *mlxsw_pci)
-{
-	return __mlxsw_pci_queue_count(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_SDQ);
-}
-
 static u8 mlxsw_pci_cq_count(struct mlxsw_pci *mlxsw_pci)
 {
 	return __mlxsw_pci_queue_count(mlxsw_pci, MLXSW_PCI_QUEUE_TYPE_CQ);
@@ -391,7 +386,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			      struct mlxsw_pci_queue *q)
 {
 	struct mlxsw_pci_queue_elem_info *elem_info;
-	u8 sdq_count = mlxsw_pci_sdq_count(mlxsw_pci);
+	u8 sdq_count = mlxsw_pci->num_sdqs;
 	int i;
 	int err;
 
@@ -457,7 +452,7 @@ static void mlxsw_pci_cq_pre_init(struct mlxsw_pci *mlxsw_pci,
 	q->cq.v = mlxsw_pci->max_cqe_ver;
 
 	if (q->cq.v == MLXSW_PCI_CQE_V2 &&
-	    q->num < mlxsw_pci->num_sdq_cqs &&
+	    q->num < mlxsw_pci->num_sdqs &&
 	    !mlxsw_core_sdq_supports_cqe_v2(mlxsw_pci->core))
 		q->cq.v = MLXSW_PCI_CQE_V1;
 }
@@ -735,10 +730,10 @@ static enum mlxsw_pci_cq_type
 mlxsw_pci_cq_type(const struct mlxsw_pci *mlxsw_pci,
 		  const struct mlxsw_pci_queue *q)
 {
-	/* Each CQ is mapped to one DQ. The first 'num_sdq_cqs' queues are used
+	/* Each CQ is mapped to one DQ. The first 'num_sdqs' queues are used
 	 * for SDQs and the rest are used for RDQs.
 	 */
-	if (q->num < mlxsw_pci->num_sdq_cqs)
+	if (q->num < mlxsw_pci->num_sdqs)
 		return MLXSW_PCI_CQ_SDQ;
 
 	return MLXSW_PCI_CQ_RDQ;
@@ -1112,7 +1107,7 @@ static int mlxsw_pci_aqs_init(struct mlxsw_pci *mlxsw_pci, char *mbox)
 		return -EINVAL;
 	}
 
-	mlxsw_pci->num_sdq_cqs = num_sdqs;
+	mlxsw_pci->num_sdqs = num_sdqs;
 
 	err = mlxsw_pci_queue_group_init(mlxsw_pci, mbox, &mlxsw_pci_eq_ops,
 					 MLXSW_PCI_EQS_COUNT);
@@ -1778,7 +1773,7 @@ static struct mlxsw_pci_queue *
 mlxsw_pci_sdq_pick(struct mlxsw_pci *mlxsw_pci,
 		   const struct mlxsw_tx_info *tx_info)
 {
-	u8 ctl_sdq_count = mlxsw_pci_sdq_count(mlxsw_pci) - 1;
+	u8 ctl_sdq_count = mlxsw_pci->num_sdqs - 1;
 	u8 sdqn;
 
 	if (tx_info->is_emad) {
-- 
2.43.0


