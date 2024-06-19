Return-Path: <netdev+bounces-104693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9290E0EA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6E61F23312
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5D6112;
	Wed, 19 Jun 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41pfK9wm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E654A19
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757213; cv=fail; b=u4xyE5FpzO0zcEbPw/jyuwRWKr9anbVQpgNx1P4L7GkWr37EQmi1kAkqW5PdUtQ0cJaeqksQoG/eFvlZ0UunRZSDH1LYg3yXKFFEFnN5My0dI4irvaOtFHP4WWkmD/Zgwr2X35wcU3r4VWP7ub+cbdSpH/fyk/aHgl+aoB/07YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757213; c=relaxed/simple;
	bh=xL4Fc744fo0X3e+7jiezkTy/0zoIbuo5QEpImCz9LoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3N45JAAiQlElzNPrlShUj6K3k3qYVa44nvdnkHWx7cDUb3w3dQAaKbVZjrhnOt25Lye4ybLQD7SQaqJbFj9tNCB8riq2hHCiWtbfxATXEY1pnrwLBky97hLtQq0kzspURTHpbKV+i2aok2F4hvhwV5M1/F4JlvEuWJNI+SIdng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41pfK9wm; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ6W2cKdhAsYchnB7g5PSPdbc27kTrwaKSbFzllvIgDb7tXF4m1kGkv/fCzlJpohYxLqd/SB4YG7PuOzZRR6cMz6uXonCm2TYZW0f58h4HSJyZF3iEd3XNQJAK2mTd8CkXdgsoDlJdviws/QYqzSNJC4zg3F9ZIgRXudeUIiemweQ58oekQBArjaF6WOMr+nHC8cvVTbUUCwoorFcRTlaYFmRIupl7zE6W4p98dpQxR26bQSpBsVFI/Jl4rZo7pfH7fZMQq+JZldwqw3ERcOgSTSMy4U06v4kE+niD5xyCKnxfASA4Q9jxi2U3E2tODSHZWy6F1NfqJNoEn5aPs7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZiNq6BZGxeglM5cmmyMwikbZbZv0l3qgGHPTuNQw+Y=;
 b=mZ1bElFg6b/b0oDg5Ddi3fTClS97DdYJ5HzB23MTJYM5g4SUQK/ZTx80MVG9UG3NIzyD3VWIiJSHnbN9ChrdQFkdV8Fj6reBtPWhf3wGrGS71nj8i2t78F292jVS95NMITT2rR5oaPz6vfvEEoQ9dJz1izhJp7d2t+P6sI+tPvrxhAHVE9EvlSL1Y5aVYOMI+fyCsdScgGZzc8xwtEoNVDvdGIwujhtzepaCJqfBqGDw7Vt1foRCiVgOrXcjPNhMHhlhoVOU5KragJVLj4qUHCrxkCu0kjoiHJOUyp7wAbKfM89cq2bTQCytpjZ6NnKg/qgS4lMzdTFb3CRnus5AAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZiNq6BZGxeglM5cmmyMwikbZbZv0l3qgGHPTuNQw+Y=;
 b=41pfK9wm6R47yonZkMdwg4Kh8QhNEnw/7v9mPHvD86Z8tsiuJv7C2cugBCRV36ZcWxftYz0LGrT6VAMTKKKYB+UIDtlwOG1PT0D0uh5SWlcPmyAyCSap72sT1VfjkmyGbP3SsAIU0x0LFRxZ4LMp5Dx31z+uSsqVSP/VJmV0TfQ=
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 00:33:26 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::d2) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:25 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 2/8] ionic: Keep interrupt affinity up to date
Date: Tue, 18 Jun 2024 17:32:51 -0700
Message-ID: <20240619003257.6138-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240619003257.6138-1-shannon.nelson@amd.com>
References: <20240619003257.6138-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc030e8-a0da-4cca-dc6a-08dc8ff76f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?owUZ6yA/MThocxC3n4Hq7Tjn/PxM5SNzGkqHHetXudBo71zZR6RMjHfaL7Fo?=
 =?us-ascii?Q?kKlaqOE1vWzNpZT37WMDP5PE3Pi2IoSx3+3R8p+f2WQKZzLlwY0rh2KikPpG?=
 =?us-ascii?Q?jFTfj+cRbPeZfX+VOcK0oBQnv+EHWdO/VHIfoiXJjSliuXEjVehFhCVphuB7?=
 =?us-ascii?Q?DeNaW+1ZFv/Nn5hr4f726mkBCqFKi4vm3hVFDC47b8HYXh1AZeRRBE/AKlzW?=
 =?us-ascii?Q?bJKcX1FIBSZuT/RW/DvI0A4ogz5z6RcHzCvEpokTNcBKheRm0UbEArab0+zs?=
 =?us-ascii?Q?XwsmMrNxzPfeuhLHLcpi/x3wGf0yfQRqqwJW7z+stRjs6Vu+uFZe3Yi27EyT?=
 =?us-ascii?Q?xyDAUxh++ZVB+t8LaS6FRNVMmJSltsZrfpgJH0nRIytO9YtEymRXf1rJUmXx?=
 =?us-ascii?Q?oJt5K4R61sEIhabpal/KRCJXreQc/UyEMzHuR1XhvIkdadTeDwqu+RnOn/RZ?=
 =?us-ascii?Q?pbjUFY0OLKDPdy5N/jDsjYitjseglezMUz44YKNZ30DhEY3PKxEuXOxVSjgd?=
 =?us-ascii?Q?njMU/G8AfYhnvaLGrGB9ySh2mOZm2szJHY7fai+roLr5klda4Rk83M470aWr?=
 =?us-ascii?Q?2Wt59OAgOcxeIsjJzMIpvqwLgaz4yBORPfL436mWRR+aSU7q+aHKnXBNpHPU?=
 =?us-ascii?Q?EI50yj1k4M/8YbmpaZrPH6hDIcvw97n9P38lF5B/liYkcpHKSJlI85p87OaH?=
 =?us-ascii?Q?kFR7H30tnIofxcZ4yr9ajJDB9QGHuX9vzq2Uo6R4xIb31wTxG8p1GWjCprjv?=
 =?us-ascii?Q?eGPF34tZHA6VlICapQcIGBrKMS0sGZGznlEPuoeZrAVhTdN8WIRnZ875kj0t?=
 =?us-ascii?Q?fo2pvXK1fZxMhBIvZMLVL1730rAiD7o7ukChtyk9ZHKKW82sQclyFi8TXcsz?=
 =?us-ascii?Q?EaejGkXUaNcTBhBcgCormHknVJfzR4A3J98Wpd1K3tk4AMs/IngTAz6pcnsH?=
 =?us-ascii?Q?mGkWzbBHEUeSluZBQGcS0+neWTdPwj15Ylk09xtkEWPVafQPlklI0tHG91AE?=
 =?us-ascii?Q?HuHVCHTg8AOhO8gIx51zPE/etO0yG8eyjkzJI8bHsvft2zaL7MlllaJNNJ4A?=
 =?us-ascii?Q?yFenXuYyC0myIFwv82JvJvo4jdjRzQmX6TkYP0C6Z8CSkFqDerHIPA+2E3UM?=
 =?us-ascii?Q?TgqAY6NGhRlqVZDQ3HOwu8lvAOzA/y3sDfSdp5FK52YETSN2eEeiWEBdm2RL?=
 =?us-ascii?Q?vdh1JOVl6WZUoeqq4Wwge+KsbGq88aeBwEJ4KkMfdiv/OHjnuY4S20xINeXm?=
 =?us-ascii?Q?f0E+cQiC0x5lCOpsVA+kLH+VVtC2Bnvn6zPb2ZZ+9212XZOlZg66/tOKIucw?=
 =?us-ascii?Q?CyjX6eGqhyaSNsMEmvZdEhNPLAeLnc57yp1Wkaaxhqei5BzIJMtNKlckxf+8?=
 =?us-ascii?Q?CYkJFD7+DC4eS6Lanc7lsZZnRGRppA5XxYaT/W0IlbFv0HO3Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:26.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc030e8-a0da-4cca-dc6a-08dc8ff76f5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982

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
index 1f02b32755fc..e53375e61e20 100644
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
@@ -299,8 +311,10 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		napi_enable(&qcq->napi);
+		irq_set_affinity_notifier(qcq->intr.vector,
+					  &qcq->intr.aff_notify);
 		irq_set_affinity_hint(qcq->intr.vector,
-				      &qcq->intr.affinity_mask);
+				      *qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
 	}
@@ -334,6 +348,7 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
 		synchronize_irq(qcq->intr.vector);
+		irq_set_affinity_notifier(qcq->intr.vector, NULL);
 		irq_set_affinity_hint(qcq->intr.vector, NULL);
 		napi_disable(&qcq->napi);
 	}
@@ -474,6 +489,7 @@ static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 
 static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qcq)
 {
+	cpumask_var_t *affinity_mask;
 	int err;
 
 	if (!(qcq->flags & IONIC_QCQ_F_INTR)) {
@@ -505,10 +521,19 @@ static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qc
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
@@ -3120,6 +3145,44 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
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
@@ -3211,11 +3274,15 @@ int ionic_lif_alloc(struct ionic *ionic)
 
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
@@ -3237,6 +3304,8 @@ int ionic_lif_alloc(struct ionic *ionic)
 
 err_out_free_qcqs:
 	ionic_qcqs_free(lif);
+err_out_free_affinity_masks:
+	ionic_affinity_masks_free(lif->ionic);
 err_out_free_lif_info:
 	dma_free_coherent(dev, lif->info_sz, lif->info, lif->info_pa);
 	lif->info = NULL;
@@ -3410,6 +3479,8 @@ void ionic_lif_free(struct ionic_lif *lif)
 	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		ionic_lif_reset(lif);
 
+	ionic_affinity_masks_free(lif->ionic);
+
 	/* free lif info */
 	kfree(lif->identity);
 	dma_free_coherent(dev, lif->info_sz, lif->info, lif->info_pa);
@@ -3487,7 +3558,7 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		irq_set_affinity_hint(qcq->intr.vector,
-				      &qcq->intr.affinity_mask);
+				      *qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_CLEAR);
 	}
-- 
2.17.1


