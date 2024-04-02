Return-Path: <netdev+bounces-84057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F68955EF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150011C2248E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987B91272C9;
	Tue,  2 Apr 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4JHFppB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79A126F16
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066288; cv=fail; b=igBWZ72PsVXG0R9MJuBMvqj+ZFQGWxRTh11ceaj4c3XIgljfuVfTDC1Jz7z7XGJforNOYInIVPlXa1tWdZrA9/gLoArNWGWsPP8UWOppkL1LzerSMKYdHA9fU/4yhPasERZjcc57pL9mxdFnLK0YTbSMYBkKFbbvk+krmxvzLqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066288; c=relaxed/simple;
	bh=dM2/jVmO2YWIixFnEhbWHZzLUGp0pJVVV36LMsAJhAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJeEm+5uR+H3Ms7uAipR3EA+Il28p1KTem0s7P7gCHpjnnfByFAH1VnpjvJeCLddpy0SjlTaD71cny8kzs1XLXhWAJ2lXIm3Ih5Xh9ojUraYnZCsq8FBTIf2Nv47j8LTd2HOdFEbpNvULF0Js9BAZ1IrUULlS3yCj3M8iqpTFgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4JHFppB; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEe1Zhkp1ibPOyasgFnYgeiOQq+IWHL7v9zY7V7UFpcLgQ9QQFi8c1G6JEesSKfBzdnH8CGSm4fxso5JlSoBF0OWwmX/QL9eipu2yZz3ykBxY45/0acPrAUjbfWqJZIx/kCKLit8XNNgwkghzSdOb3dp5pANChLopwTxDbH6DhatyhmG2Q5S4vIaUIWEHp/mbmC0kenZnlrLG2W6pAggTDlWqL4LnaV3praBx7vBMPbyCTgpkr31e5u2JhTPJHjD4Z077K3NA4jcmg2Ra/HevYG5eeptXBY4hb47+JD4xTxFRGDrNQx4MP6KKLWR3UbX/fEV452LiDMLfyAEjL09CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+/OLYVfnqL2m/UACJm22PvVYxFCOF4ziByRv5T9pG8=;
 b=eyiY3b7fvWdHtPVtsRpSWWnM/3rVJ2mfPDr6+3iogAB7XtlWNZdQ3XwWUTfiMawJRU/fprRFFF/QmEzEFQCw0iqQ/fRaDKQjHexWNl1yumYigjdo9aNG5fZofEfXG7au3Q15OFKQ5TtVkbNsbddmR1d/W5XqdKQLt2AnWB6bpx2mIlK+cD9RXgpm00zIYK7RGs2Lt++Gqb4xj84XYnpiDmOldSeO8GYvT0a1osNmpTlYRxz/IthiDXkwAAT77Dvnos5knFy02Yg6OwsQzLZDK7M4SuQ5ndzafqlVWoqPf3FTCSTSczowG3ZqgAHhIakSCyWPw6pD6JJzt20LT4WKRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+/OLYVfnqL2m/UACJm22PvVYxFCOF4ziByRv5T9pG8=;
 b=f4JHFppBOJkXVrU+Sq5L+WyC6xSCa+mDQZ19NzER7Q6Lbk2goTjmZy4fWgWwrmKYFIRU6HZOkPHAzPXIXJISBt6PpNm0kmgDy5pSDbCZtWgKyhL44SkMX6pmHrNhKYmBU37HgqQ82rK4FYa22F+3Edjh84MbfbT+jHwGIfXA9bNFXS/wwaK7nBE82MqvYW/0QekNnYiFLQ0TkUDr+LDOT/HIFx3Xr9zxQVfbmaBrRfeBJNTEBcAHH+4XfOqekyTRfCcFUDMGOQ2rFV+aMrudliKgIGffBqtHuzNVenBHftPq0tQf1QzrNYf1h1cnPQKI+rSDiGNq1m7OkYRBP0CGKQ==
Received: from CH0P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::16)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:58:00 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::52) by CH0P221CA0033.outlook.office365.com
 (2603:10b6:610:11d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:58:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:57:43 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:57:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 12/15] mlxsw: pci: Break mlxsw_pci_cq_tasklet() into tasklets per queue type
Date: Tue, 2 Apr 2024 15:54:25 +0200
Message-ID: <50fbc366f8de54cb5dc72a7c4f394333ef71f1d0.1712062203.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: ca614a58-f2a6-4227-d683-08dc531ce889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GRBvoWJUC+/Ae6unauATa7LxplwWSCwwVwjteLS5hgsPP3N93+mk1snKxFq647MbgFj/F/x6/1cdzcBo4LMf8z6r9QMvOO1I6eMElkpTrWG1/zLxnSKj2fLf+MekDV2tgmBEHE3xOdExYdVdmb6wjtWeUIAHw36hXdZC2eON4qDBxaFLlP5icoATH5in7xtM0UjfnVOcKB7tNpVLyUql2daJsB2/RLnLtYojkxnb0dS1qZhBK1Rl8FMvl/3DqXsgIsAEoLpdz0zfRLtqEz2glXnM8ekPEwGE2JAO2uJsrhj/oanskVhpw9jSG2gAVDv0eA1yckMNfJ2RZlAYUBBjBJz0CB/9WoFvp6mUTCNc6kP/a1VqB5SwoBEcwWroAvVSZ1mcc1WeUxjVvfXKAsnMN4y4YBHCSeWO0VdfgP6xzhPdGjd1NEC05mpUt3R8nze40bGK8Ij7j8vjDUALJ5t4UCXogPjCuWw3T2mDThjsovs/KcjIJDrluHfjTQaVg9uQpdkGUEaQag8eUe9/4mcDYuo2Ra0p5a2zrBVzVdvzBpZmxIK+oRx0XhBhqPLIpbMU37URxk58xzdj3hThmWKz1DZK7ymzCh0Pv5xBlNR0LKD3jJrvyFXQYL25HaET2xq4wns64FXIaSItzTcbPhyEijV/JaFRxjHXmY3RUq/dnTfCq7yqae8gy5FrzWv15ysunCRipGM/tIogQ2lmjDItmp70m80RDgJcxVbLFATdNDrwTuvA720hA0HvddxfJMG1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:58:00.3742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca614a58-f2a6-4227-d683-08dc531ce889
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713

From: Amit Cohen <amcohen@nvidia.com>

Completion queues are used for completions of RDQ or SDQ. Each
completion queue is used for one DQ. The first CQs are used for SDQs and
the rest are used for RDQs.

Currently, for each CQE (completion queue element), we check 'sr' value
(send/receive) to know if it is completion of RDQ or SDQ. Actually, we
do not really have to check it, as according to the queue number we know
if it handles completions of Rx or Tx.

Break the tasklet into two - one for Rx (RDQ) and one for Tx (SDQ). Then,
setup the appropriate tasklet for each queue as part of queue
initialization. Use 'sr' value for unlikely case that we get completion
with type that we do not expect. Call WARN_ON_ONCE() only after checking
the value, to avoid calling this method for each completion.

A next patch set will use NAPI to handle events, then we will have a
separate poll method for Rx and Tx. This change is a preparation for
NAPI usage.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 86 +++++++++++++++++++----
 1 file changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 7c4b6e66f1fb..1839ab840b35 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -35,6 +35,11 @@ enum mlxsw_pci_queue_type {
 
 #define MLXSW_PCI_QUEUE_TYPE_COUNT	4
 
+enum mlxsw_pci_cq_type {
+	MLXSW_PCI_CQ_SDQ,
+	MLXSW_PCI_CQ_RDQ,
+};
+
 static const u16 mlxsw_pci_doorbell_type_offset[] = {
 	MLXSW_PCI_DOORBELL_SDQ_OFFSET,	/* for type MLXSW_PCI_QUEUE_TYPE_SDQ */
 	MLXSW_PCI_DOORBELL_RDQ_OFFSET,	/* for type MLXSW_PCI_QUEUE_TYPE_RDQ */
@@ -658,7 +663,7 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 	return elem;
 }
 
-static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
+static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 {
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
 	struct mlxsw_pci *mlxsw_pci = q->pci;
@@ -671,23 +676,54 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
 		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
 		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
+		struct mlxsw_pci_queue *rdq;
+
+		if (unlikely(sendq)) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
 
 		memcpy(ncqe, cqe, q->elem_size);
 		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
-		if (sendq) {
-			struct mlxsw_pci_queue *sdq;
+		rdq = mlxsw_pci_rdq_get(mlxsw_pci, dqn);
+		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
+					 wqe_counter, q->cq.v, ncqe);
+
+		if (++items == credits)
+			break;
+	}
+
+	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
+}
 
-			sdq = mlxsw_pci_sdq_get(mlxsw_pci, dqn);
-			mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
-						 wqe_counter, q->cq.v, ncqe);
-		} else {
-			struct mlxsw_pci_queue *rdq;
+static void mlxsw_pci_cq_tx_tasklet(struct tasklet_struct *t)
+{
+	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
+	struct mlxsw_pci *mlxsw_pci = q->pci;
+	int credits = q->count >> 1;
+	int items = 0;
+	char *cqe;
 
-			rdq = mlxsw_pci_rdq_get(mlxsw_pci, dqn);
-			mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
-						 wqe_counter, q->cq.v, ncqe);
+	while ((cqe = mlxsw_pci_cq_sw_cqe_get(q))) {
+		u16 wqe_counter = mlxsw_pci_cqe_wqe_counter_get(cqe);
+		u8 sendq = mlxsw_pci_cqe_sr_get(q->cq.v, cqe);
+		u8 dqn = mlxsw_pci_cqe_dqn_get(q->cq.v, cqe);
+		char ncqe[MLXSW_PCI_CQE_SIZE_MAX];
+		struct mlxsw_pci_queue *sdq;
+
+		if (unlikely(!sendq)) {
+			WARN_ON_ONCE(1);
+			continue;
 		}
+
+		memcpy(ncqe, cqe, q->elem_size);
+		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
+
+		sdq = mlxsw_pci_sdq_get(mlxsw_pci, dqn);
+		mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
+					 wqe_counter, q->cq.v, ncqe);
+
 		if (++items == credits)
 			break;
 	}
@@ -695,6 +731,32 @@ static void mlxsw_pci_cq_tasklet(struct tasklet_struct *t)
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 }
 
+static enum mlxsw_pci_cq_type
+mlxsw_pci_cq_type(const struct mlxsw_pci *mlxsw_pci,
+		  const struct mlxsw_pci_queue *q)
+{
+	/* Each CQ is mapped to one DQ. The first 'num_sdq_cqs' queues are used
+	 * for SDQs and the rest are used for RDQs.
+	 */
+	if (q->num < mlxsw_pci->num_sdq_cqs)
+		return MLXSW_PCI_CQ_SDQ;
+
+	return MLXSW_PCI_CQ_RDQ;
+}
+
+static void mlxsw_pci_cq_tasklet_setup(struct mlxsw_pci_queue *q,
+				       enum mlxsw_pci_cq_type cq_type)
+{
+	switch (cq_type) {
+	case MLXSW_PCI_CQ_SDQ:
+		tasklet_setup(&q->tasklet, mlxsw_pci_cq_tx_tasklet);
+		break;
+	case MLXSW_PCI_CQ_RDQ:
+		tasklet_setup(&q->tasklet, mlxsw_pci_cq_rx_tasklet);
+		break;
+	}
+}
+
 static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			     struct mlxsw_pci_queue *q)
 {
@@ -727,7 +789,7 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
-	tasklet_setup(&q->tasklet, mlxsw_pci_cq_tasklet);
+	mlxsw_pci_cq_tasklet_setup(q, mlxsw_pci_cq_type(mlxsw_pci, q));
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
-- 
2.43.0


