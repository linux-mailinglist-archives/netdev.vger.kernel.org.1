Return-Path: <netdev+bounces-102385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1C7902C30
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044501F2349B
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37F91514FD;
	Mon, 10 Jun 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rCC7zLAh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23161514C1
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060854; cv=fail; b=HhTDOl3xWgPBTYhfs+rOvAIOHCmxWx2RZObMQI4wowF+YZoiYFZiXO5WsHKPGJ2VqPaAyxz8iZynrlW9z2rD6HhrqtLPka1QCyojL0xPEYgqD2fHZPJ1w3IiRrR1wnJgAPksT+ZH0M2NzoWdjh1CHBU6/Btd9KyrySc0XEMD/mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060854; c=relaxed/simple;
	bh=k3JXNLpsL3VjhJh6PEdaUo2wqY6Ng/RhyNLcUrPvFt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9DSOkdjrgNb+148PnPr+2Er5B5FsT5ScVUTdOcE2RWNoNK4Q+XPUEsJj3upCDKr4YWK1pCDJqyynyv5vPxB1adgzGB7BoacdR8EV1egT7eIN28Md1uqoFrzrR1J43f7gD1D8QREVW4CgF57Ch6k+mYWs1/6LTi4gJTm8nCNA8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rCC7zLAh; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfQzD3t1tFZ9P2vyA8vgtg6MxcXFLc6g79s+CloGfpu8ohNB8yTK2BOOfmcHLy69S+0CKyEaUhCj14eF8TBijWoTHDIE7WXowXFbox1xPstGsAD1ESlgSym3db8+cmxMxAQHrkwLr/EwqzhqAT5vmHKEx1xknmQYqRhswZ9KRbQLbnPLwDnjggzXkNbyYhvZ8HkfkJVwKlfsIW1vt2l3MvxbLhyBLsWTZ/MSjKgfjUhmCKNPfiSo2QiLHxSRfZfYy6hDVb71plN38dcuOdzkqa21ZJs1V4xJLZ1baDOsTw9G0TEZrkblTn4sRgG6zxj9ZrMMOlzHxTRjruTLSiexEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgNyzCvUN5vvcMoEtMlZWFeiAdZfRPpKm1zVNnSTrf8=;
 b=eVptxEmki9OLtaKGR9+hqeUEWYxgx/LhX+mCXyrmOWltwLJla+GyxwtPlTxhaeUS86HEyzkvmHPofo5ptrLwXZMngPNEPCx4BgtrQdMdhB1rW8MWEOA7eAZJyffmM49ub+u7+BmFCeYeaDTTBTtjPcsqRDURE0rYv3TLh5cKrWRa87ZGuZPA0sa+H1Cu8UWs7x3OxCnKwnT+uLe31ZkA4YlNZML8rReYIcbTjFEwxVuyo+IhI8vEBAsfe/z6CPu6+3nc5aGmuqWNIORO2J9BjEiOXVa/VdwEeh65SFOeRB+Tb1Z2AK1nCXIj/M090pSgAjiD75CMSdGz3a14gv5uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgNyzCvUN5vvcMoEtMlZWFeiAdZfRPpKm1zVNnSTrf8=;
 b=rCC7zLAhEbuZzSRBk0nxyIIfh8fG/K4r+CaDOEvJa54rSngTG5ms4vffs9dOQpwVT1AoT60+cAaqzfeNBkxtIDGbGPbLIjT6ECt+VJwG5djZevvdxjA7/3sPPouC6soryDdbKhB/87Zsw0MBOSbp+aGQm0L0fwXtSYYFaF8tx1w=
Received: from DM6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:5:190::33)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:30 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::ac) by DM6PR11CA0020.outlook.office365.com
 (2603:10b6:5:190::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:30 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/8] ionic: Keep interrupt affinity up to date
Date: Mon, 10 Jun 2024 16:07:00 -0700
Message-ID: <20240610230706.34883-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240610230706.34883-1-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 218c342c-a0c9-40d5-19d7-08dc89a21aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKunluBQk/+uv3eek2PDSrZIT3rcUcnycLaPhD+bo3FZqXHgv3L6MKfZ8odI?=
 =?us-ascii?Q?RjeDabGb7JEK4a21jjmU1sASG+AFILafaDx9VqSM6MBFKW/DWhcv+y0XlDvT?=
 =?us-ascii?Q?cEDwXrdikbyDTgPnRZUOId6Zkiq65qOB9FFZ4q+vM7GdBNW2wD1xzjZxGPCg?=
 =?us-ascii?Q?FgZUneu4+pUEsz+W6DRpxogFIKMmOtAnIJlNQTGFDwryE12BIvhick/yZkdO?=
 =?us-ascii?Q?MH9NH2eH7KZKov8g4ehI51nqpLgDp0iHZkgJG+ZQ0o5cXZrPzOsBEwmo6miX?=
 =?us-ascii?Q?XLe9R7t4txISgvrHFDWvwRYBxrw5H/lKaNG0w05/c6qsXuHKnWoXcWYmidxB?=
 =?us-ascii?Q?dTXHhVGnzc+r/qg0x9Sx2UJJiw5KIHV2SMIQidzTo/f9LQF18OftXvzy7VXA?=
 =?us-ascii?Q?jBMjHj6+WYZmRjyau7KDvt70K0vDNa7L5ANZHJjmUHfhl5n56eMFFFM7dvVj?=
 =?us-ascii?Q?BbxSOPl8gmlNtlPVEyBlyXAB8TAPY6XodwVs+ILPjMjrkMqiAhJjt2pPeUJP?=
 =?us-ascii?Q?yw8xUqmvsQ7doGR5+Ra7zevA/RpUVEdQo6S7gvog0v/1tuvtmvbUni0bfGZ+?=
 =?us-ascii?Q?mHvbzAwOedzyOtGyOC1UUYpaTEvB2PmqGDSZFRGqK4QH3kXmGrhBsp97Sb2/?=
 =?us-ascii?Q?8LG+rK4s45Bc7xIESb+eCBL/20RBWiHiPtU+LyJGJCI4yLuNd8+bGl2C/qO5?=
 =?us-ascii?Q?zsRYXmANuBTYEzoGUzbA6s8oX5gLaJe1vDyVlnY4jw2zLk3xT/9yhP6F4iyq?=
 =?us-ascii?Q?DyaFcGY4JeXZtvgBOlrxyFgQKr1Zt75zagUKWFRBkdRoKAaDyyz2up83lzCB?=
 =?us-ascii?Q?rcXWSADIYTeLYoykCcVMo7aIOWYtRbrcYnI6slBY8VdSPcdLP75iCvn628ze?=
 =?us-ascii?Q?oetx0w63R3OOl6kxrvDE2GdBjg1g70abChphmC7xRzFpUl71oVw2g/hXtzVX?=
 =?us-ascii?Q?3WXBAilJYZpAjnX9nIh8MFrl0sAfybV0gkPOmElHmmkWblpP8KJ9MIaqtLgX?=
 =?us-ascii?Q?0AaEFAC7d5tpz5k+ijt8Z31mEeoPe8kU3yPtkM6cNtF7AJ16WS43FAlsU6Au?=
 =?us-ascii?Q?UhfT5vZTPQxBs+a64KVoqPS9wgMRUJBYdXXtyQEX6QCjz5CCwtTnAAD12L7W?=
 =?us-ascii?Q?hdQMQ9CG9m+9vLwwXbVM7ybBmLQ9nf5MfYUybCbo7DkBm8ccMiCDO9aDb8qU?=
 =?us-ascii?Q?tLOHwaGYeRiMcFUOclrjpv7zwULtLdDXFfA2fyf7zWJV3fThlB5Th/opc4+2?=
 =?us-ascii?Q?JD46wXUf05nfDXwiTwRMwPEL9PRl/3AOlckhqU1229TzGhTQy1tqiWDnxIaJ?=
 =?us-ascii?Q?33wr/IL3Ljj9Xu21agNL9Gm6XjpjwM3IMEnsBqYkM7VHccTB2xgQ6DkrGqOt?=
 =?us-ascii?Q?zCzsocjYf72qiAudITq0ZQ0uGSz29auOsrIQdlbWdph0K6V+sA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:30.3540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 218c342c-a0c9-40d5-19d7-08dc89a21aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

From: Brett Creeley <brett.creeley@amd.com>

Currently the driver either sets the initial interrupt affinity for its
adminq and tx/rx queues on probe or resets it on various
down/up/reconfigure flows. If any user and/or user process
(i.e. irqbalance) changes IRQ affinity for any of the driver's interrupts
that will be reset to driver defaults whenever any down/up/reconfigure
operation happens. This is incorrect and is fixed by making 2 changes:

1. Allocate an array of cpumasks that's only allocated on probe and
   destroyed on remove.
2. Update the cpumask(s) for interrupts that are in use by registering
   for affinity notifiers.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 85 +++++++++++++++++--
 3 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 2ccc2c2a06e3..438172cfb170 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -54,6 +54,7 @@ struct ionic {
 	unsigned int nrxqs_per_lif;
 	unsigned int nintrs;
 	DECLARE_BITMAP(intrs, IONIC_INTR_CTRL_REGS_MAX);
+	cpumask_var_t *affinity_masks;
 	struct work_struct nb_work;
 	struct notifier_block nb;
 	struct rw_semaphore vf_op_lock;	/* lock for VF operations */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index f30eee4a5a80..7dbd3b8b0e36 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -280,9 +280,9 @@ struct ionic_intr_info {
 	u64 rearm_count;
 	unsigned int index;
 	unsigned int vector;
-	unsigned int cpu;
 	u32 dim_coal_hw;
-	cpumask_t affinity_mask;
+	cpumask_var_t *affinity_mask;
+	struct irq_affinity_notify aff_notify;
 };
 
 struct ionic_cq {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 48b2b150fbcc..ff6a7e86254c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -265,6 +265,18 @@ static void ionic_intr_free(struct ionic *ionic, int index)
 		clear_bit(index, ionic->intrs);
 }
 
+static void ionic_irq_aff_notify(struct irq_affinity_notify *notify,
+				 const cpumask_t *mask)
+{
+	struct ionic_intr_info *intr = container_of(notify, struct ionic_intr_info, aff_notify);
+
+	cpumask_copy(*intr->affinity_mask, mask);
+}
+
+static void ionic_irq_aff_release(struct kref __always_unused *ref)
+{
+}
+
 static int ionic_qcq_enable(struct ionic_qcq *qcq)
 {
 	struct ionic_queue *q = &qcq->q;
@@ -301,8 +313,10 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 		napi_enable(&qcq->napi);
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		irq_set_affinity_notifier(qcq->intr.vector,
+					  &qcq->intr.aff_notify);
 		irq_set_affinity_hint(qcq->intr.vector,
-				      &qcq->intr.affinity_mask);
+				      *qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
 	}
@@ -336,6 +350,7 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
 		synchronize_irq(qcq->intr.vector);
+		irq_set_affinity_notifier(qcq->intr.vector, NULL);
 		irq_set_affinity_hint(qcq->intr.vector, NULL);
 		napi_disable(&qcq->napi);
 	}
@@ -476,6 +491,7 @@ static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 
 static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qcq)
 {
+	cpumask_var_t *affinity_mask;
 	int err;
 
 	if (!(qcq->flags & IONIC_QCQ_F_INTR)) {
@@ -507,10 +523,19 @@ static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qc
 	}
 
 	/* try to get the irq on the local numa node first */
-	qcq->intr.cpu = cpumask_local_spread(qcq->intr.index,
-					     dev_to_node(lif->ionic->dev));
-	if (qcq->intr.cpu != -1)
-		cpumask_set_cpu(qcq->intr.cpu, &qcq->intr.affinity_mask);
+	affinity_mask = &lif->ionic->affinity_masks[qcq->intr.index];
+	if (cpumask_empty(*affinity_mask)) {
+		unsigned int cpu;
+
+		cpu = cpumask_local_spread(qcq->intr.index,
+					   dev_to_node(lif->ionic->dev));
+		if (cpu != -1)
+			cpumask_set_cpu(cpu, *affinity_mask);
+	}
+
+	qcq->intr.affinity_mask = affinity_mask;
+	qcq->intr.aff_notify.notify = ionic_irq_aff_notify;
+	qcq->intr.aff_notify.release = ionic_irq_aff_release;
 
 	netdev_dbg(lif->netdev, "%s: Interrupt index %d\n", qcq->q.name, qcq->intr.index);
 	return 0;
@@ -3122,6 +3147,44 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 	return err;
 }
 
+static int ionic_affinity_masks_alloc(struct ionic *ionic)
+{
+	cpumask_var_t *affinity_masks;
+	int nintrs = ionic->nintrs;
+	int i;
+
+	affinity_masks = kcalloc(nintrs, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!affinity_masks)
+		return	-ENOMEM;
+
+	for (i = 0; i < nintrs; i++) {
+		if (!zalloc_cpumask_var_node(&affinity_masks[i], GFP_KERNEL,
+					     dev_to_node(ionic->dev)))
+			goto err_out;
+	}
+
+	ionic->affinity_masks = affinity_masks;
+
+	return 0;
+
+err_out:
+	for (--i; i >= 0; i--)
+		free_cpumask_var(affinity_masks[i]);
+	kfree(affinity_masks);
+
+	return -ENOMEM;
+}
+
+static void ionic_affinity_masks_free(struct ionic *ionic)
+{
+	int i;
+
+	for (i = 0; i < ionic->nintrs; i++)
+		free_cpumask_var(ionic->affinity_masks[i]);
+	kfree(ionic->affinity_masks);
+	ionic->affinity_masks = NULL;
+}
+
 int ionic_lif_alloc(struct ionic *ionic)
 {
 	struct device *dev = ionic->dev;
@@ -3213,11 +3276,15 @@ int ionic_lif_alloc(struct ionic *ionic)
 
 	ionic_debugfs_add_lif(lif);
 
+	err = ionic_affinity_masks_alloc(ionic);
+	if (err)
+		goto err_out_free_lif_info;
+
 	/* allocate control queues and txrx queue arrays */
 	ionic_lif_queue_identify(lif);
 	err = ionic_qcqs_alloc(lif);
 	if (err)
-		goto err_out_free_lif_info;
+		goto err_out_free_affinity_masks;
 
 	/* allocate rss indirection table */
 	tbl_sz = le16_to_cpu(lif->ionic->ident.lif.eth.rss_ind_tbl_sz);
@@ -3239,6 +3306,8 @@ int ionic_lif_alloc(struct ionic *ionic)
 
 err_out_free_qcqs:
 	ionic_qcqs_free(lif);
+err_out_free_affinity_masks:
+	ionic_affinity_masks_free(lif->ionic);
 err_out_free_lif_info:
 	dma_free_coherent(dev, lif->info_sz, lif->info, lif->info_pa);
 	lif->info = NULL;
@@ -3412,6 +3481,8 @@ void ionic_lif_free(struct ionic_lif *lif)
 	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		ionic_lif_reset(lif);
 
+	ionic_affinity_masks_free(lif->ionic);
+
 	/* free lif info */
 	kfree(lif->identity);
 	dma_free_coherent(dev, lif->info_sz, lif->info, lif->info_pa);
@@ -3489,7 +3560,7 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		irq_set_affinity_hint(qcq->intr.vector,
-				      &qcq->intr.affinity_mask);
+				      *qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
 	}
-- 
2.17.1


