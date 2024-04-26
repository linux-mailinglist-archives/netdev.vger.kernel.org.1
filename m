Return-Path: <netdev+bounces-91692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AAE8B3769
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBBA28329A
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD01474A5;
	Fri, 26 Apr 2024 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YM/3lndi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE2146D56
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135528; cv=fail; b=XEVDRCEjhGtQ3tiNdS6pFkWDB9clqmSkDPcfZmwgyrTmceX8NKIEnbdLO9XGuMrU+C+pcvtYiHmN5oXAryCQkhOHGS8yPGMtRE4DlO0S3jLZViujkfoK4t2LhY29DvKIwbm5wsAqtSOzhW6vQJAdCdw4haI/SBBqjRtCsL3ulkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135528; c=relaxed/simple;
	bh=0yNNiBz6xLcjkxQn1YB0G6KQ2U0V1Uimu+d5ZOD59Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrMrdtIjkOEFY7F+RHnKrAc7rM6fW3gU6CjT3vkpF1nVRWyxVoPvwUTWBZeKPpCdGBKeNXgJA8X2I58C8mJK4B0eK/I/4eKRv3YrCrImDrVTCal0OUsHgttXYo/moAaJOEuTBeEWQVcjpL7BCBwUM0OY9aQ763NBZreTUYCexsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YM/3lndi; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKWYDDLhrKasFEj1G5nRr53sdggFzx/dqccnHn3w8jxh2aRAVHBQi9AtWqltLc3Y0+XwvjwLXWPTfCE23ydIzhbr3VtQ3tSIMW4TTxTspSO3Pdz+CkNVGgMOVJTIcD+VAtAiNj26w9zy3omfgUI9LXSXYnxECn1iU/Zop6yUlibo35qTGKaszk8pXYHjZV5E84EqNhJW9H9lkw0cGVBtOExR3vJun/2bwJLxoCRa1M1Ns46ktxAdvl7RTiCHEesRJTpkn1YsZuxKuJquN5WM75POchzRRxyfhIQVAIr1pDqNIcTYGFFahYgnQhoy1Sou1HRrz+rX2NseM495MIQtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziKXYr6xWxeHSGFh7kZvwT7sSJL7jrsnVBM83uPjdZY=;
 b=IC02urM09w8O2I3GcNCqDES+KdDd7nztDwgZWah50gZcaMY45m98yqVoDO7ucFmWtwQz7w5LnIeUbUAaazBkxntkSdeKuRP8dzbWk95+77zSOhmz00Y3AE2uFQmDqzCzU892JXGPZXwfDxRHz+Q8+nhTxLZsLfznNLslgwMR1HhteOqfYfdc/gi9FWUTGVL3YEjNyzWu8ZhcWZqnCScdruNknCYfH3dsVVCtGo/5mQdLZTKiJuTy6o+I7+KgJplTXXuxdPQXuSJeaDVLk8I+GG3em4Np/H5s2vWPDfsBx/QoxHNqCMLXW81cNKVYYcSfAtQYoQKcGCYK/VjJw8rhPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziKXYr6xWxeHSGFh7kZvwT7sSJL7jrsnVBM83uPjdZY=;
 b=YM/3lndifk6PtOH6RsoLXQzOs+95QY1Fx7n+3wp/yJa+CbAmlkNDbnoQqBKeI2JhovCdDCLshjruiv2bWtcolGGmQuhRSVVBGSRENiJpbA/CqIoX/2rxIDAor6jklmZrzUjpACY4sBcUNjG/pUE/fq3iCOWy2TQvMpIf+Z8Wg6Fvygc4zD/rEDLyPf93tbl5t6Kg0Bv4Jp6mE/I+cDdk1F9UPsoydxJij0jJZLIAdafesLIjwMhTcvjdFCiubLtePDHJM2uD4f+ZK0ylpM0FoVQyXdeMl5FXaahdBOgXUQ68LDUgFIs6U1WPTBFqh9EWJVjHDR+49+awYzbyj3Y9mg==
Received: from PH8PR20CA0001.namprd20.prod.outlook.com (2603:10b6:510:23c::15)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 12:45:23 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::38) by PH8PR20CA0001.outlook.office365.com
 (2603:10b6:510:23c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:45:09 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:45:05 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/5] mlxsw: pci: Use NAPI for event processing
Date: Fri, 26 Apr 2024 14:42:26 +0200
Message-ID: <2a2eeac12c4d70b366f4e4afdfabdf133359acd2.1714134205.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e8bf69-4d4a-4c41-d5ed-08dc65eebd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7UYs3me7su+m5lBvju6Su2VXqeo+2PSEPH6kRHrhTeqPW/EY3RyICNxcoAM?=
 =?us-ascii?Q?2H1CjTSPJ7Bxnz7SwU2O2A9hh4KUV9pvHiyO1yOFzOA9FEvz3Vxj8E3YTauI?=
 =?us-ascii?Q?PMOlWfwXVLSzmJCNX7gvVeMP9Pb3C1+qQySwAVyugayV5o6G195qadAaOlS8?=
 =?us-ascii?Q?MNKHMLPShR7pxoCA/jNwlZbRYebxQd2Tkb7aiRQsJJb2FD+iPFIkfxG0rgfh?=
 =?us-ascii?Q?sFXMCyrYdsHwuitO7KpID+0CWoxK2xczI7eoTBGVQlfgH3KkDb6ybuD8Oq3X?=
 =?us-ascii?Q?r+cXHrMBSV892mQx4ohXnHsJoSmHcD4UWyuBZzXZsUnxfk0HOTNSI+CHnvBH?=
 =?us-ascii?Q?5Cop+uhpWH1sVzdovHNc6hRbP4nJnAw2dhpVtC/h7Rk7VerL97qnU3xvJVX+?=
 =?us-ascii?Q?/25JiVWwphg35vzQY8geB8vi895ksA28xWa2Ets7jDlHyWn/gEvTjtEU6azN?=
 =?us-ascii?Q?LeVDcVqanANBSSjea7wWlQVjNrqAUCRXRfKgNfCCg8E3BmR6uLviNHWNdZZW?=
 =?us-ascii?Q?4G14g1dBuB9sUozo3MAKcc0TL+DpU4CBX5cDRH/A3rqp2YQuKREkiktDJ76T?=
 =?us-ascii?Q?f1TM6zOSlVqyM98uJ292Lk4Kv1R46V/zSi2CZ4Y26Jd2h22R6CC4DZPhgbdE?=
 =?us-ascii?Q?SJ6vK0b1IC6AyRQZ4R7cG9M5AsLG3dkpClwYrUN+QowmT4N++xYeDWJe5jOu?=
 =?us-ascii?Q?pfR4HRGNIbLVNeMMNfdaU1JEoYhIKEiieZlm0YXF16fv9aUJMkp4YV1bEekV?=
 =?us-ascii?Q?bvhPOEIjDPpchrQwZ2hjPRFUn1dXv+xlggTW/eaRJVyMGIQuuBPC329ZGm7U?=
 =?us-ascii?Q?a3Lo3yi1f4z5xth148FBWGIaBfjCCkwNs1VIOC5wZZlFwf3xqFbC1lm+GtF6?=
 =?us-ascii?Q?zgC1FD665+DtLon+W41QztOEWwekV9B8QBsV4lE9gkr45YTr0iGU1vh1VoeC?=
 =?us-ascii?Q?L53KpPzpbmjBVgz6j9+dd7zHYdo1pNgUv8SX0xFpxrL9ao3koNJTLWEJzpWJ?=
 =?us-ascii?Q?qRs2hCFPMVRujY0CJQoX7soS17j5Vk7wWk7XDQv1lgcjw7uZvBdoxTbQvDJY?=
 =?us-ascii?Q?1cz+kEhuGXu5CRolNZbSBLuHO9fNCb1ltSQRxIqYnkpy4gcjS06o+XkmUBM2?=
 =?us-ascii?Q?OtYuOLPdu9tBD1bjTY4d4EIKiKTg3LLfB/qrq0K3z/sQjfDJ/+zxnxrtm87a?=
 =?us-ascii?Q?i6Rlpw8O5YR/mCw8YLaWR7MOZz6mJM7Uupcf7WSZzeztWTpwFLY3pLQDzmt5?=
 =?us-ascii?Q?x7dr0FHtveWsFepAi8SRX1w2lYJO9TcNSKwRfRxI8x9bDSQ9DkmVDcn3oMXD?=
 =?us-ascii?Q?IvspiSE5Yd3MEmY5R3ap5Hw67NuaNgBn0y/FjbkL+Gk2mqug5tJwEDpfFO3v?=
 =?us-ascii?Q?27MRs4vkLvegsLLmY+PLXUaG0+FV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:22.6703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e8bf69-4d4a-4c41-d5ed-08dc65eebd07
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

From: Amit Cohen <amcohen@nvidia.com>

Spectrum ASICs only support a single interrupt, that means that all the
events are handled by one IRQ (interrupt request) handler. Once an
interrupt is received, we schedule tasklet to handle events from EQ and
then schedule tasklets to handle completions from CQs. Tasklet runs in
softIRQ (software IRQ) context, and will be run on the same CPU which
scheduled it. That means that today we use only one CPU to handle all the
packets (both network packets and EMADs) from hardware.

This can be improved using NAPI. The idea is to use NAPI instance per
CQ, which is mapped 1:1 to DQ (RDQ or SDQ). NAPI poll method can be run
in kernel thread, so then the driver will be able to handle WQEs in several
CPUs. Convert the existing code to use NAPI APIs.

Add NAPI instance as part of 'struct mlxsw_pci_queue' and initialize it
as part of CQs initialization. Set the appropriate poll method and dummy
net device, according to queue number, similar to tasklet setup. For CQs
which are used for completions of RDQ, use Rx poll method and
'napi_dev_rx', which is set as 'threaded'. It means that Rx poll method
will run in kernel context, so several RDQs will be handled in parallel.
For CQs which are used for completions of SDQ, use Tx poll method and
'napi_dev_tx', this method will run in softIRQ context, as it is
recommended in NAPI documentation, as Tx packets' processing is short task.

Convert mlxsw_pci_cq_{rx,tx}_tasklet() to poll methods. Handle 'budget'
argument - ignore it in Tx poll method, as it is recommended to not limit
Tx processing. For Rx processing, handle up to 'budget' completions.
Return 'work_done' which is the amount of completions that were handled.

Handle the following cases:
1. After processing 'budget' completions, the driver still has work to do:
   Return work-done = budget. In that case, the NAPI instance will be
   polled again (without the need to be rescheduled). Do not re-arm the
   queue, as NAPI will handle the reschedule, so we do not have to involve
   hardware to send an additional interrupt for the completions that should
   be processed.

2. Event processing has been completed:
   Call napi_complete_done() to mark NAPI processing as completed, which
   means that the poll method will not be rescheduled. Re-arm the queue,
   as all completions were handled.

   In case that poll method handled exactly 'budget' completions, return
   work-done = budget -1, to distinguish from the case that driver still
   has completions to handle. Otherwise, return the amount of completions
   that were handled.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 96 ++++++++++++++++++-----
 1 file changed, 77 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7724f9a61479..bf66d996e32e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -87,7 +87,7 @@ struct mlxsw_pci_queue {
 		struct {
 			enum mlxsw_pci_cqe_v v;
 			struct mlxsw_pci_queue *dq;
-			struct tasklet_struct tasklet;
+			struct napi_struct napi;
 		} cq;
 		struct {
 			struct tasklet_struct tasklet;
@@ -684,16 +684,29 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 	return elem;
 }
 
-#define MLXSW_PCI_CQ_MAX_HANDLE 64
+static bool mlxsw_pci_cq_cqe_to_handle(struct mlxsw_pci_queue *q)
+{
+	struct mlxsw_pci_queue_elem_info *elem_info;
+	bool owner_bit;
+
+	elem_info = mlxsw_pci_queue_elem_info_consumer_get(q);
+	owner_bit = mlxsw_pci_cqe_owner_get(q->u.cq.v, elem_info->elem);
+	return !mlxsw_pci_elem_hw_owned(q, owner_bit);
+}
 
-static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
+static int mlxsw_pci_napi_poll_cq_rx(struct napi_struct *napi, int budget)
 {
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, u.cq.tasklet);
+	struct mlxsw_pci_queue *q = container_of(napi, struct mlxsw_pci_queue,
+						 u.cq.napi);
 	struct mlxsw_pci_queue *rdq = q->u.cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
-	int items = 0;
+	int work_done = 0;
 	char *cqe;
 
+	/* If the budget is 0, Rx processing should be skipped. */
+	if (unlikely(!budget))
+		return 0;
+
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
 		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->u.cq.v, cqe);
@@ -712,22 +725,44 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
 					 wqe_counter, q->u.cq.v, cqe);
 
-		if (++items == MLXSW_PCI_CQ_MAX_HANDLE)
+		if (++work_done == budget)
 			break;
 	}
 
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, rdq);
-	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+
+	if (work_done < budget)
+		goto processing_completed;
+
+	/* The driver still has outstanding work to do, budget was exhausted.
+	 * Return exactly budget. In that case, the NAPI instance will be polled
+	 * again.
+	 */
+	if (mlxsw_pci_cq_cqe_to_handle(q))
+		goto out;
+
+	/* The driver processed all the completions and handled exactly
+	 * 'budget'. Return 'budget - 1' to distinguish from the case that
+	 * driver still has completions to handle.
+	 */
+	if (work_done == budget)
+		work_done--;
+
+processing_completed:
+	if (napi_complete_done(napi, work_done))
+		mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+out:
+	return work_done;
 }
 
-static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
+static int mlxsw_pci_napi_poll_cq_tx(struct napi_struct *napi, int budget)
 {
-	struct mlxsw_pci_queue *q = from_tasklet(q, t, u.cq.tasklet);
+	struct mlxsw_pci_queue *q = container_of(napi, struct mlxsw_pci_queue,
+						 u.cq.napi);
 	struct mlxsw_pci_queue *sdq = q->u.cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
-	int credits = q->count >> 1;
-	int items = 0;
+	int work_done = 0;
 	char *cqe;
 
 	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
@@ -752,11 +787,21 @@ static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
 		mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
 					 wqe_counter, q->u.cq.v, ncqe);
 
-		if (++items == credits)
-			break;
+		work_done++;
 	}
 
+	/* If the budget is 0 napi_complete_done() should never be called. */
+	if (unlikely(!budget))
+		goto processing_completed;
+
+	work_done = min(work_done, budget - 1);
+	if (unlikely(!napi_complete_done(napi, work_done)))
+		goto out;
+
+processing_completed:
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+out:
+	return work_done;
 }
 
 static enum mlxsw_pci_cq_type
@@ -772,17 +817,29 @@ mlxsw_pci_cq_type(const struct mlxsw_pci *mlxsw_pci,
 	return MLXSW_PCI_CQ_RDQ;
 }
 
-static void mlxsw_pci_cq_tasklet_setup(struct mlxsw_pci_queue *q,
-				       enum mlxsw_pci_cq_type cq_type)
+static void mlxsw_pci_cq_napi_setup(struct mlxsw_pci_queue *q,
+				    enum mlxsw_pci_cq_type cq_type)
 {
+	struct mlxsw_pci *mlxsw_pci = q->pci;
+
 	switch (cq_type) {
 	case MLXSW_PCI_CQ_SDQ:
-		tasklet_setup(&q->u.cq.tasklet, mlxsw_pci_cq_tx_tasklet);
+		netif_napi_add(mlxsw_pci->napi_dev_tx, &q->u.cq.napi,
+			       mlxsw_pci_napi_poll_cq_tx);
 		break;
 	case MLXSW_PCI_CQ_RDQ:
-		tasklet_setup(&q->u.cq.tasklet, mlxsw_pci_cq_rx_tasklet);
+		netif_napi_add(mlxsw_pci->napi_dev_rx, &q->u.cq.napi,
+			       mlxsw_pci_napi_poll_cq_rx);
 		break;
 	}
+
+	napi_enable(&q->u.cq.napi);
+}
+
+static void mlxsw_pci_cq_napi_teardown(struct mlxsw_pci_queue *q)
+{
+	napi_disable(&q->u.cq.napi);
+	netif_napi_del(&q->u.cq.napi);
 }
 
 static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
@@ -817,7 +874,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
-	mlxsw_pci_cq_tasklet_setup(q, mlxsw_pci_cq_type(mlxsw_pci, q));
+	mlxsw_pci_cq_napi_setup(q, mlxsw_pci_cq_type(mlxsw_pci, q));
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
@@ -826,6 +883,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 			      struct mlxsw_pci_queue *q)
 {
+	mlxsw_pci_cq_napi_teardown(q);
 	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
 }
 
@@ -886,7 +944,7 @@ static void mlxsw_pci_eq_tasklet(struct tasklet_struct *t)
 	cq_count = mlxsw_pci->num_cqs;
 	for_each_set_bit(cqn, active_cqns, cq_count) {
 		q = mlxsw_pci_cq_get(mlxsw_pci, cqn);
-		tasklet_schedule(&q->u.cq.tasklet);
+		napi_schedule(&q->u.cq.napi);
 	}
 }
 
-- 
2.43.0


