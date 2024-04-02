Return-Path: <netdev+bounces-84059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9C8955F1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F80C1F236A1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22385639;
	Tue,  2 Apr 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GANWJJYj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F683CB3
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066293; cv=fail; b=TdAR/U+XjuSz+p5GEPWj9B7Ir0lNHgHzF3tMwLUeZFFWlfPLthqOacoJOjKXjAFUK2QSxeaasUI+aoLD5WjQxm8LidXxKT4pVcboHQ6TA7flBKD1sYVUgwCGHihJzI8VlZwNTAFm02Mt6abZ9PHsjvapOYsybjlIVxEgeP+rcOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066293; c=relaxed/simple;
	bh=aE2Zi2nynHVJOTvjWCSCsMqpVPEpcX42AK1mx0eVtoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fu4YvtrUDtHTxRXyWPzLlY2Hd41kNvxI0dqgYWSvCzk9+kDdX2goxlNF7XUWqeKoBLRvjV2vN1R4BttOCUF12Hjelk99OqkUNpTTKcSsP7kDD3/1Tt6xX+NFMaATz0KYTsHUnDXxSk+FdwosE/QqvHQLhY3jq/768NaGu8Iqr9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GANWJJYj; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAegM9cjeNSma4+5LDoOTTGOnhwM//VhAyDbyOC8l3bwFnTbXPA99IRpe0GkxYLXHyTeM/ExvbdVAGgUHChSGd2/j1X5ucPdlROZuQXuHIzS0sCYfhgDIkS69ZVls4Qj/caqkxoLp9O6a5mfz5gCwcl+/E7oFWYbHeEb4I9RSx6uK4sSHKMJTQmAF57lAvrsclS5XpNYpnZWl9YeBqBVkonPjHirQkibSlf6uTTEbedooiGCfurWU3NJt/jt8xt+7rwlQ6PAadyndOo4R9hAh9iNb6wyYClnqfH70VrKo3XuGHDxhYbyCPbsIHsdR9xSjmOps5YsDCguBr7AMwzYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX5DNML9M90EuMnQUzfoHnRNp6/E/MRMbBajyscajnQ=;
 b=V6bQraaWULMHt4wP3t4Hi9f+KI4Puj+NC9yQsxXzVCLeG3fmKmWN3Z1cLBSc+XhBX9DexXZx3Nkx1FhibuCoaOWjBXUoUCLUkujNJcC+hG50A6TGfwO2wd9PJmNz/xDObsS8RlYwq8U9E9TB6JVs2Y65Anbp0fd59TAtFxvApAzQH0EjJeSk4D261P/956/tANEAwtIIyiZw5pdtlaP9ZeHZbAepN1X6dv7mXlRiaGysprKnGXtbtHy9TGtncIOud3gDnB0IvjT4yPkB6AgtnJUmC2kyFwJCj6x9E97pbdDJ2thwoSYbIFLA2u7eHLDxC8Yej3wUAj89K8+bZvNaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX5DNML9M90EuMnQUzfoHnRNp6/E/MRMbBajyscajnQ=;
 b=GANWJJYjRDpYKuRXh0V/wqvg010PseuuSA1SYYKwNTSEprTP6BuHh1QcR8B5QH9ZOzTxqxgJsBcAUn5kkD5Nt5qk8pm4oLmzUGgdn1i9cyZMQtxRqo3P7WkUeU0c19JsWboQm/EjuWC4MOt8cIlsNLRNbENuw0aw+vfMqtYyK/BpE+G0HNs6Hqd7rndwJ2kKraxhezFbZZgyWhAWnvyceW9SZUIKeNo1U1eSAEB5FPDA9MUP8sLcsOSRWEdYgraG3x7p1jFaxyt3RTuWdX675IF+Yw73YraLyti/3aBq8Od9JKmNVW+D3NqLbj+5fCU8DETnQzaBwOkWoQpd7+Gajw==
Received: from BYAPR08CA0047.namprd08.prod.outlook.com (2603:10b6:a03:117::24)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:58:07 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::50) by BYAPR08CA0047.outlook.office365.com
 (2603:10b6:a03:117::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:58:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:56 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 15/15] mlxsw: pci: Store DQ pointer as part of CQ structure
Date: Tue, 2 Apr 2024 15:54:28 +0200
Message-ID: <a5b2559cd6d532c120f3194f89a1e257110318f1.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dcc270-4641-4b18-d3fd-08dc531cec2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	60NB/xsHilWbDRb/lOZ2LHpEBrqsqleQPL/cyz3UpBmfg56sereKP6BdsftfW1Gx+4zvMK8nCWxzi47QGbTOmYAgVN3DArJcTJfN5S25iCckF1hyHakl9qae2YOPOfrnTHoCTZAlHLUkuU3MgGaDRUlQyNVjQJJF5T5TxR6PUlrzw4vIO9Pn/1Wx5oRZMtPqdDmr5bbyINve4KH72qNmlcFN54gsHxc7lIj6C70ajsVsFoZQPtQoVpkGFGBVlfpZIxwy6U/3GvvU4JCyahtmsncZ8/wtkIIfiFBijNlFvNHIOisesj0mwDBehiC70MwsDir/ajT2O3AN1CvY4K1aI6+xzxn96+sQp2S1I4ojH9exr+4GBO2VY6aKh17rw4PEZqCdG0BudWCPJ0TJyKtBDBleKYoD77TipUb0hYBqYPaJKMIcnVfJIUhjvmre9bQ/Go/RUwrBeVZniDX8RoBVKYnFnQMbC5oTsGXPeDB7SX2VUmQoPtUn3/8HiCibnV14l+AlVr54RCJcEM7fREV26rvMFC/Y4o7aRyc65XRN+BC6RxbV9j6ps49HLMUrMRTJ/QINItze/U1uXyQso2lhvw11RHNO0GcFiPm+Uz2jN3wYrk7euIzKm7BsmZ7ug4Dg+VvoirjLN1DR9ji+AsKPMiflLi/in9cvAyTdQP5tE16i2TRpmW9QEipgVmD+HlruabbeVinL4WQPYaG72GwZdCwX4+CJt0Mb1K2lfeO4x+XeE5yxUSeoLH+u8jmC3CKS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:58:06.6162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dcc270-4641-4b18-d3fd-08dc531cec2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103

From: Amit Cohen <amcohen@nvidia.com>

Currently, for each completion, we check the number of descriptor queue
and take it via mlxsw_pci_{sdq,rdq}_get(). This is inefficient, the
DQ should be the same for all the completions in CQ, as each CQ handles
only one DQ - SDQ or RDQ. This mapping is handled as part of DQ
initialization via mlxsw_cmd_mbox_sw2hw_dq_cq_set().

Instead, as part of DQ initialization, set DQ pointer in the appropriate
CQ structure. When we handle completions, warn in case that the DQ number
that we expect is different from the number we get in the CQE. Call
WARN_ON_ONCE() only after checking the value, to avoid calling this method
for each completion.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 41 ++++++++++++++++-------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 2148110542cb..13fd067c39ed 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -86,6 +86,7 @@ struct mlxsw_pci_queue {
 	struct mlxsw_pci *pci;
 	struct {
 		enum mlxsw_pci_cqe_v v;
+		struct mlxsw_pci_queue *dq;
 	} cq;
 };
 
@@ -194,13 +195,6 @@ static struct mlxsw_pci_queue *mlxsw_pci_sdq_get(struct mlxsw_pci *mlxsw_pci,
 				     MLXSW_PCI_QUEUE_TYPE_SDQ, q_num);
 }
 
-static struct mlxsw_pci_queue *mlxsw_pci_rdq_get(struct mlxsw_pci *mlxsw_pci,
-						 u8 q_num)
-{
-	return __mlxsw_pci_queue_get(mlxsw_pci,
-				     MLXSW_PCI_QUEUE_TYPE_RDQ, q_num);
-}
-
 static struct mlxsw_pci_queue *mlxsw_pci_cq_get(struct mlxsw_pci *mlxsw_pci,
 						u8 q_num)
 {
@@ -265,7 +259,9 @@ static dma_addr_t __mlxsw_pci_queue_page_get(struct mlxsw_pci_queue *q,
 static int mlxsw_pci_sdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			      struct mlxsw_pci_queue *q)
 {
+	struct mlxsw_pci_queue *cq;
 	int tclass;
+	u8 cq_num;
 	int lp;
 	int i;
 	int err;
@@ -278,7 +274,8 @@ static int mlxsw_pci_sdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 						  MLXSW_CMD_MBOX_SW2HW_DQ_SDQ_LP_WQE;
 
 	/* Set CQ of same number of this SDQ. */
-	mlxsw_cmd_mbox_sw2hw_dq_cq_set(mbox, q->num);
+	cq_num = q->num;
+	mlxsw_cmd_mbox_sw2hw_dq_cq_set(mbox, cq_num);
 	mlxsw_cmd_mbox_sw2hw_dq_sdq_lp_set(mbox, lp);
 	mlxsw_cmd_mbox_sw2hw_dq_sdq_tclass_set(mbox, tclass);
 	mlxsw_cmd_mbox_sw2hw_dq_log2_dq_sz_set(mbox, 3); /* 8 pages */
@@ -291,6 +288,9 @@ static int mlxsw_pci_sdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_sdq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
+
+	cq = mlxsw_pci_cq_get(mlxsw_pci, cq_num);
+	cq->cq.dq = q;
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 	return 0;
 }
@@ -374,6 +374,8 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 {
 	struct mlxsw_pci_queue_elem_info *elem_info;
 	u8 sdq_count = mlxsw_pci->num_sdqs;
+	struct mlxsw_pci_queue *cq;
+	u8 cq_num;
 	int i;
 	int err;
 
@@ -383,7 +385,8 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	/* Set CQ of same number of this RDQ with base
 	 * above SDQ count as the lower ones are assigned to SDQs.
 	 */
-	mlxsw_cmd_mbox_sw2hw_dq_cq_set(mbox, sdq_count + q->num);
+	cq_num = sdq_count + q->num;
+	mlxsw_cmd_mbox_sw2hw_dq_cq_set(mbox, cq_num);
 	mlxsw_cmd_mbox_sw2hw_dq_log2_dq_sz_set(mbox, 3); /* 8 pages */
 	for (i = 0; i < MLXSW_PCI_AQ_PAGES; i++) {
 		dma_addr_t mapaddr = __mlxsw_pci_queue_page_get(q, i);
@@ -395,6 +398,9 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	if (err)
 		return err;
 
+	cq = mlxsw_pci_cq_get(mlxsw_pci, cq_num);
+	cq->cq.dq = q;
+
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 
 	for (i = 0; i < q->count; i++) {
@@ -415,6 +421,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
 		mlxsw_pci_rdq_skb_free(mlxsw_pci, elem_info);
 	}
+	cq->cq.dq = NULL;
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
 
 	return err;
@@ -648,6 +655,7 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 {
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
+	struct mlxsw_pci_queue *rdq = q->cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int credits = q->count >> 1;
 	int items = 0;
@@ -658,17 +666,20 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
 		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
 		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
-		struct mlxsw_pci_queue *rdq;
 
 		if (unlikely(sendq)) {
 			WARN_ON_ONCE(1);
 			continue;
 		}
 
+		if (unlikely(dqn != rdq->num)) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
 		memcpy(ncqe, cqe, q->elem_size);
 		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
-		rdq = mlxsw_pci_rdq_get(mlxsw_pci, dqn);
 		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
 					 wqe_counter, q->cq.v, ncqe);
 
@@ -682,6 +693,7 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 {
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
+	struct mlxsw_pci_queue *sdq = q->cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	int credits = q->count >> 1;
 	int items = 0;
@@ -692,17 +704,20 @@ static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
 		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
 		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
-		struct mlxsw_pci_queue *sdq;
 
 		if (unlikely(!sendq)) {
 			WARN_ON_ONCE(1);
 			continue;
 		}
 
+		if (unlikely(dqn != sdq->num)) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
 		memcpy(ncqe, cqe, q->elem_size);
 		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
-		sdq = mlxsw_pci_sdq_get(mlxsw_pci, dqn);
 		mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
 					 wqe_counter, q->cq.v, ncqe);
 
-- 
2.43.0


