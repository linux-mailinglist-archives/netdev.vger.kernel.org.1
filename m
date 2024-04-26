Return-Path: <netdev+bounces-91691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096B58B3767
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B610E28327C
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A2146A94;
	Fri, 26 Apr 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O4Lz8uh9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80F13E88A
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135526; cv=fail; b=iI6TmoamIAU+yJW3o9E7Unykxd5D1M1+L8ZqsgQCD7tHyu54fnmBXZ/dfswr/7doBvPDpqRCE+IaLjB5d0Za9k7LS+keeUQrDSd0jejVPbxg62HwPvaahE6Kz5xg07FXQO7tMYCIummvsiNARk3GOJX5YO+3DAcLQwORmS5JtbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135526; c=relaxed/simple;
	bh=s5xWj13mSXJoRBkP+HWjgyPE1pUqb7nBa5rhi3g6U1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=po/5iHQSopzEuFWElYbooEH4E3CXCpv7LBdxbQV5o9hRhUZVqSTXf4UEJDaM0UhZxZ2FJ914KEuy466c7FGR5dOr2iqpEuYvC+ilB7wRWmwA3X8r/6PD37aKvX/lBbdWVEMTR+fVfbmERVIBvPSrDJcj345sM74hXatkWjeeg0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O4Lz8uh9; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrUD2rGoISwtRfloJIpeMut8+EUEaVtvC2jyZbz4pNzSi0D7wRHtk6SM6QkUlrcS+5YKVy5b+qcrUkfSzHp24HxnYpdcRG6rtLEnloehoTuJU7EqW86jKLBKerF0gPKDojqYR0U8Y1VgnZr69TRJx81p/8LfhOIcxzS/OzDD1sXrhOP0XeWXa/5IhkBeWkLSZXTxHgVKk8w5WHzCPMIENV41HnJ/YE/kS7/O+SwhD19B6DpgNA+1Wo+QLXDlaxVcCvfRGYgWXsDTM4JwXOzZicdOWNzW8cJdbkmhP0UxQTIG2pxzKwiXMWl/7+f51PXYQct+AquSkOAyOm8wKF63Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgby1dwSiXEqNYHnXUnGxlLMpmPgfLHf4F20unMxBbg=;
 b=MwKWBRTyZo5ew/Td+gtkMvlkpMsw9qz/LXka+IEihceC2uICiqWJwGjnGngTmsIveS4yu/Zp1xDQhw4bv1ZJTzpVVmEaVNCEQ5DAHi/4SLOBNHo9kmdvYZW0H0SCc14k+9SQAcDgq7LhIlkI3pSH3cmRW2GDtGjoX8hLW1DzyqBWa6v6YA9BoEB5SPDpuOB7yjUQ6pkj3G4LTm+XtmljSVSPxPAei/Mjt/wN1RxwY2cc+LK7EYnfmrUeQYRO4TTRAZfQ0q+2PiwrbacZiBbeNrBO3RfmudL4YuUjiCC20MBidiBZ7QfCwJjcyhX6M3/AOL0AOgDvqesGN7wA5l1CKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgby1dwSiXEqNYHnXUnGxlLMpmPgfLHf4F20unMxBbg=;
 b=O4Lz8uh9fMe3uAPolYn6Ni5885fq5EixRSv+RtEX2Rn6lYDk1AtLnesup82stVjf9iR3vhdoHaZTFfGp13pHG0yahZ4b86DMRiiJhvmcgNAQQjcP5MrA1p9qzBw7zHKRcap13FkhE8PaX1c9QbkD1Se+4YeBdgiELSudBTcUpAmWf6CkL8nfXvhazBS2+UQlByN5yZtLJmV/5Guztesjs/FzvjFsKJdoDHwiQvGQndzn2gy5RBXYnM+BuufieY0l+lQlNMPJnZ8nXFB/aEALA5HX17mHnrBlNetdcvRJzyw/5by4WAbioENKthuFVGhJ20v+9XUy4Gr1HdDpvIGCpg==
Received: from SA9PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:21::20)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 12:45:20 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::a) by SA9PR13CA0015.outlook.office365.com
 (2603:10b6:806:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.13 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:45:05 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:45:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/5] mlxsw: pci: Reorganize 'mlxsw_pci_queue' structure
Date: Fri, 26 Apr 2024 14:42:25 +0200
Message-ID: <467009f0dfdbd1885522ef0c51711b89b7b46b74.1714134205.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714134205.git.petrm@nvidia.com>
References: <cover.1714134205.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: cf44b712-5e83-4e59-8296-08dc65eebabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E7i9KbOjYoSb631SBUgmYmZbutnOrsJmIHVFkug5gjtIq/uwbxNV5ltYu6+C?=
 =?us-ascii?Q?bJWkKkERHw+W0OBEb+GAQtUfP84sDt8xdxqgL1JpJDApwrIGTXp0T8dXlHII?=
 =?us-ascii?Q?+6LSGzfVTi9ZxQoivDmUCQ9O/NKkLtyD+IovIXaYVT+dShtmpCImYfOOHGNc?=
 =?us-ascii?Q?e6E8qSiUspcHZ9Hrf6685/P93EeCq1/Dc9kuVznvBoilwMg3nQnZhO5GIRJE?=
 =?us-ascii?Q?hmvMfZe2H5sundoHdP7lP8q5XBgHtNDWOyVbl3JWEHeDcdC8E2Ou6WHS0k/b?=
 =?us-ascii?Q?5Pa9yI4jU1A4iGLB7N5ynR4+2/W5wDgld6B9FDp5lS0dqWjOZGpeG7n7dtrb?=
 =?us-ascii?Q?kSJc8Q4/hDxvugcWWe7ZQ56u0QRWbOOYakVH279SawOFZkVg5do4zYlbyTXb?=
 =?us-ascii?Q?UsjeOsLC5nQ9EtuYz91Uz/i+b6/Z/a+Erq9pPXpZsOZPGqHJcB6o2fnkx4u4?=
 =?us-ascii?Q?DHH38Dye/oQ5hXZOM4qG2YtOKmGrGNblK5+oGNlFc25fzhmfvuThcbCbQszp?=
 =?us-ascii?Q?TUBXTDtu6pa046Ped7nTK6Sg/9Q6Xbr+tAAqYrhpyFS1ny/TdXB9chuoVLOE?=
 =?us-ascii?Q?rOd2M+dgdrh9Gs03nNeXTz2H73FzwfMR2yCEl0eFTX0MqVHFN2NJNBclhvBl?=
 =?us-ascii?Q?dV/kvtEdLcEjJ08wBZSwgYJ6JSlXAPQpkFLptjyx8GHXuYrONOJ5PqGXxyzx?=
 =?us-ascii?Q?M1TPHn8Jnyv7T7Hxm1HTdzxQPOFXMaTB7fT2KMErhJGOEswOA8ZuJNOESarF?=
 =?us-ascii?Q?nwwzHVtXmw4CxjrwpC/W9LXTdZ6lEEPaLxKR5mPheikYxZPFgspzchDgSq3R?=
 =?us-ascii?Q?kVnajHBuvzphqPXQyPgb7lDpnPJsY9ucgi7qgggSE+YlG5hd18avWlx7bLHH?=
 =?us-ascii?Q?6lS8rjYczO0fpciwuG665cuDd1ptBOmpivHmIiKZDAV/SgLMYKU+fEQ7dPDA?=
 =?us-ascii?Q?Jl1rlhk7c6L6gj8/CfiAPnrI9uhoXjM1fRlOjCDQi1u5ttdTdRucT3RlGHE3?=
 =?us-ascii?Q?lIZuC9VE0IgQ9hwad1i3fLfQmGIndn3GCiIKIHr/MhXqvQ/IWk5Pxjerq6cE?=
 =?us-ascii?Q?R18XAROPSNWvADeWsQZMZc2W3+wZr59v7aWUpj4vWSq4IX9XRaQTTbPo19Lp?=
 =?us-ascii?Q?FDldHR+Aen4qlbzfJVuwEat0umD44Ws53pw159hrtTioitjV99/WF7pepRF7?=
 =?us-ascii?Q?Xm/QPv4qtqPhOIJLzGLmRDJHylwyNk+GvXaAv8Mp2xY4pl2uG84mF4rjjwsu?=
 =?us-ascii?Q?MOvXvoEJ3OUnU2BCUqHZ+b7NlAManpfQvlr0OPjCTmiqTK3Fp4yJSp6InMJ0?=
 =?us-ascii?Q?XVENGeQ3vrV+YeCCI8HpLT04shczoTQNwN65LAtTip4S2PxZVeQ+JaQYLlf0?=
 =?us-ascii?Q?88yiPQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:18.7834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44b712-5e83-4e59-8296-08dc65eebabb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

From: Amit Cohen <amcohen@nvidia.com>

The next patch will set the driver to use NAPI for event processing. Then
tasklet mechanism will be used only for EQ. Reorganize 'mlxsw_pci_queue'
to hold EQ and CQ attributes in a union. For now, add tasklet for both EQ
and CQ. This will be changed in the next patch, as 'tasklet_struct' will be
replaced with NAPI instance.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 76 +++++++++++------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index ec54b876dfd9..7724f9a61479 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -82,12 +82,17 @@ struct mlxsw_pci_queue {
 	u8 num; /* queue number */
 	u8 elem_size; /* size of one element */
 	enum mlxsw_pci_queue_type type;
-	struct tasklet_struct tasklet; /* queue processing tasklet */
 	struct mlxsw_pci *pci;
-	struct {
-		enum mlxsw_pci_cqe_v v;
-		struct mlxsw_pci_queue *dq;
-	} cq;
+	union {
+		struct {
+			enum mlxsw_pci_cqe_v v;
+			struct mlxsw_pci_queue *dq;
+			struct tasklet_struct tasklet;
+		} cq;
+		struct {
+			struct tasklet_struct tasklet;
+		} eq;
+	} u;
 };
 
 struct mlxsw_pci_queue_type_group {
@@ -163,11 +168,6 @@ static void mlxsw_pci_napi_devs_fini(struct mlxsw_pci *mlxsw_pci)
 	free_netdev(mlxsw_pci->napi_dev_tx);
 }
 
-static void mlxsw_pci_queue_tasklet_schedule(struct mlxsw_pci_queue *q)
-{
-	tasklet_schedule(&q->tasklet);
-}
-
 static char *__mlxsw_pci_queue_elem_get(struct mlxsw_pci_queue *q,
 					size_t elem_size, int elem_index)
 {
@@ -324,7 +324,7 @@ static int mlxsw_pci_sdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		return err;
 
 	cq = mlxsw_pci_cq_get(mlxsw_pci, cq_num);
-	cq->cq.dq = q;
+	cq->u.cq.dq = q;
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 	return 0;
 }
@@ -433,7 +433,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		return err;
 
 	cq = mlxsw_pci_cq_get(mlxsw_pci, cq_num);
-	cq->cq.dq = q;
+	cq->u.cq.dq = q;
 
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 
@@ -455,7 +455,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
 		mlxsw_pci_rdq_skb_free(mlxsw_pci, elem_info);
 	}
-	cq->cq.dq = NULL;
+	cq->u.cq.dq = NULL;
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
 
 	return err;
@@ -477,12 +477,12 @@ static void mlxsw_pci_rdq_fini(struct mlxsw_pci *mlxsw_pci,
 static void mlxsw_pci_cq_pre_init(struct mlxsw_pci *mlxsw_pci,
 				  struct mlxsw_pci_queue *q)
 {
-	q->cq.v = mlxsw_pci->max_cqe_ver;
+	q->u.cq.v = mlxsw_pci->max_cqe_ver;
 
-	if (q->cq.v == MLXSW_PCI_CQE_V2 &&
+	if (q->u.cq.v == MLXSW_PCI_CQE_V2 &&
 	    q->num < mlxsw_pci->num_sdqs &&
 	    !mlxsw_core_sdq_supports_cqe_v2(mlxsw_pci->core))
-		q->cq.v = MLXSW_PCI_CQE_V1;
+		q->u.cq.v = MLXSW_PCI_CQE_V1;
 }
 
 static unsigned int mlxsw_pci_read32_off(struct mlxsw_pci *mlxsw_pci,
@@ -676,7 +676,7 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 
 	elem_info = mlxsw_pci_queue_elem_info_consumer_get(q);
 	elem = elem_info->elem;
-	owner_bit = mlxsw_pci_cqe_owner_get(q->cq.v, elem);
+	owner_bit = mlxsw_pci_cqe_owner_get(q->u.cq.v, elem);
 	if (mlxsw_pci_elem_hw_owned(q, owner_bit))
 		return NULL;
 	q->consumer_counter++;
@@ -688,16 +688,16 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 
 static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 {
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
-	struct mlxsw_pci_queue *rdq = q->cq.dq;
+	struct mlxsw_pci_queue *q = from_tasklet(q, t, u.cq.tasklet);
+	struct mlxsw_pci_queue *rdq = q->u.cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int items = 0;
 	char *cqe;
 
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
-		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
-		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
+		u8 sendq = mlxsw_pci_cqe_sr_get(q->u.cq.v, cqe);
+		u8 dqn = mlxsw_pci_cqe_dqn_get(q->u.cq.v, cqe);
 
 		if (unlikely(sendq)) {
 			WARN_ON_ONCE(1);
@@ -710,7 +710,7 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 		}
 
 		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
-					 wqe_counter, q->cq.v, cqe);
+					 wqe_counter, q->u.cq.v, cqe);
 
 		if (++items == MLXSW_PCI_CQ_MAX_HANDLE)
 			break;
@@ -723,8 +723,8 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 
 static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 {
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
-	struct mlxsw_pci_queue *sdq = q->cq.dq;
+	struct mlxsw_pci_queue *q = from_tasklet(q, t, u.cq.tasklet);
+	struct mlxsw_pci_queue *sdq = q->u.cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int credits = q->count >> 1;
 	int items = 0;
@@ -732,8 +732,8 @@ static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
-		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
-		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
+		u8 sendq = mlxsw_pci_cqe_sr_get(q->u.cq.v, cqe);
+		u8 dqn = mlxsw_pci_cqe_dqn_get(q->u.cq.v, cqe);
 		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
 
 		if (unlikely(!sendq)) {
@@ -750,7 +750,7 @@ static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
 		mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
-					 wqe_counter, q->cq.v, ncqe);
+					 wqe_counter, q->u.cq.v, ncqe);
 
 		if (++items == credits)
 			break;
@@ -777,10 +777,10 @@ static void mlxsw_pci_cq_tasklet_setup(struct mlxsw_pci_queue *q,
 {
 	switch (cq_type) {
 	case MLXSW_PCI_CQ_SDQ:
-		tasklet_setup(&q->tasklet, mlxsw_pci_cq_tx_tasklet);
+		tasklet_setup(&q->u.cq.tasklet, mlxsw_pci_cq_tx_tasklet);
 		break;
 	case MLXSW_PCI_CQ_RDQ:
-		tasklet_setup(&q->tasklet, mlxsw_pci_cq_rx_tasklet);
+		tasklet_setup(&q->u.cq.tasklet, mlxsw_pci_cq_rx_tasklet);
 		break;
 	}
 }
@@ -796,13 +796,13 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	for (i = 0; i < q->count; i++) {
 		char *elem = mlxsw_pci_queue_elem_get(q, i);
 
-		mlxsw_pci_cqe_owner_set(q->cq.v, elem, 1);
+		mlxsw_pci_cqe_owner_set(q->u.cq.v, elem, 1);
 	}
 
-	if (q->cq.v == MLXSW_PCI_CQE_V1)
+	if (q->u.cq.v == MLXSW_PCI_CQE_V1)
 		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
 				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_1);
-	else if (q->cq.v == MLXSW_PCI_CQE_V2)
+	else if (q->u.cq.v == MLXSW_PCI_CQE_V2)
 		mlxsw_cmd_mbox_sw2hw_cq_cqe_ver_set(mbox,
 				MLXSW_CMD_MBOX_SW2HW_CQ_CQE_VER_2);
 
@@ -831,13 +831,13 @@ static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 
 static u16 mlxsw_pci_cq_elem_count(const struct mlxsw_pci_queue *q)
 {
-	return q->cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
+	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_COUNT :
 					     MLXSW_PCI_CQE01_COUNT;
 }
 
 static u8 mlxsw_pci_cq_elem_size(const struct mlxsw_pci_queue *q)
 {
-	return q->cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_SIZE :
+	return q->u.cq.v == MLXSW_PCI_CQE_V2 ? MLXSW_PCI_CQE2_SIZE :
 					       MLXSW_PCI_CQE01_SIZE;
 }
 
@@ -860,7 +860,7 @@ static char *mlxsw_pci_eq_sw_eqe_get(struct mlxsw_pci_queue *q)
 static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 {
 	unsigned long active_cqns[BITS_TO_LONGS(MLXSW_PCI_CQS_MAX)];
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
+	struct mlxsw_pci_queue *q = from_tasklet(q, t, u.eq.tasklet);
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int credits = q->count >> 1;
 	u8 cqn, cq_count;
@@ -886,7 +886,7 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	cq_count = mlxsw_pci->num_cqs;
 	for_each_set_bit(cqn, active_cqns, cq_count) {
 		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
-		mlxsw_pci_queue_tasklet_schedule(q);
+		tasklet_schedule(&q->u.cq.tasklet);
 	}
 }
 
@@ -922,7 +922,7 @@ static int mlxsw_pci_eq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_eq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
-	tasklet_setup(&q->tasklet, mlxsw_pci_eq_tasklet);
+	tasklet_setup(&q->u.eq.tasklet, mlxsw_pci_eq_tasklet);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -1483,7 +1483,7 @@ static irqreturn_t mlxsw_pci_eq_irq_handler(int irq, void *dev_id)
 	struct mlxsw_pci_queue *q;
 
 	q = mlxsw_pci_eq_get(mlxsw_pci);
-	mlxsw_pci_queue_tasklet_schedule(q);
+	tasklet_schedule(&q->u.eq.tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


