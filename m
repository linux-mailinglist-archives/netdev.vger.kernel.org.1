Return-Path: <netdev+bounces-102388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50B902C33
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F482853C2
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B66E15252E;
	Mon, 10 Jun 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o0Aq86Y7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA621514F3
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060856; cv=fail; b=eT1hakLPK2JEbopW/xiC//lTW3OO/M7JrMSrh3c+Yird57yep3mvZKPrqNUx5HunC+q6UMjxOx032yjeXoyPHPt5682SCRuHHzjfRt5gpxxC2eLVNyRrHzUWeWzOzvj1tKg/SaYoLzhlXYRrxOpBezEkCFvtNp7r7lVHGMaWPpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060856; c=relaxed/simple;
	bh=C3vb9qP8XoqKqsZ4RJhcGKRW/jWM6CtDVd17hWpbheQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwTzaXPgyYydQTINoUJO3b0cF5caRrzYj/DacyK91U0q7Bci08xVddkxVUhHp3Xrz46UgSUB3BH1++Ggk2AD6pv90mok8HIFU0aK3rRhv5c0sTk+bF762zLLT7YXZsR3/LTrW3ff/4udj/ex1RIceI1AZP6aRqNCuQMZLwRLTAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o0Aq86Y7; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEBP9x1kecLkSEiGod3mqqhwn8v1ioijvEe0b+f6dYkyF8GT7E+bPeAq8WFU9wXynbYloI8FKNoBGmI6pjfGZ8f/9zQagiQGsbrBPcBzOWD+PQ+Zw1bSmhsI0SYMI97M3GpQ/bZ25oHFb/MjVj40ybCGxUoH/vAllMmFPd7y9ioSVkPLWvAgvJNlvrcBmMy7uvmq3VvPUJbD/Ik3pcLEYDbcAFqPM2Y5BdefrQSWxA9JKQk6e5BZw2nDJwABUrfYpqhDOOxklo4zr7aH0dz6OajPjmasXCON0ppwkuYZlvsqJ94JHwjCrazv7TyPStfcGbp7VBdu1APxzFPIc3eoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOIn3sn61pPxzNwZS6rZ19Cd6wuDn07swvzwibtitok=;
 b=YRy3tG41oGJAvx+pFK5V2Nsr4o9O16tAgPwWheo8rIT3Z90gPUjcAbeCMBE1sG8meyy6L12foSN2nUMVhLbDEcCHG1f1tOj8lEWjMkOd0Aajk0CpGvkAmZyu1i6Y0NlexDgOKtWRLysT5RaJXK8GzOfayZmDzVjDV/6YJ+AaAdROPUK8Krc43tFMhG05ajMO4LR0tPduADXzpUClQlzydAubVR9Fd4QsQ1RSlE37wEd+drC8ufCXYtYKdYZ4zen+2QdjIIW/FPEc4JiWIn/P5LQngeq/2N16XUJUItP4FwETBjH8cA2PjI/8J+2h1Co3Mg8INhzAzGCWeqwn3ZEEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOIn3sn61pPxzNwZS6rZ19Cd6wuDn07swvzwibtitok=;
 b=o0Aq86Y7P0yqt020MEt2M6ZhHmvmzw09oQFMrdwOqZXA5Eii0kT1AZGnRzNgRBqCZsRrufzdwGC/JcgWr1LvpQTNFolUB9EBB4tPz6PTVe0ZIzFLW9hAs97C59g/Xf7omgkIq8izKIinP0JSQcWFlpEmGJ3BdLTwhYr7HGpV9fc=
Received: from DS7PR03CA0284.namprd03.prod.outlook.com (2603:10b6:5:3ad::19)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:32 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::ba) by DS7PR03CA0284.outlook.office365.com
 (2603:10b6:5:3ad::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:31 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:30 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 4/8] ionic: add work item for missed-doorbell check
Date: Mon, 10 Jun 2024 16:07:02 -0700
Message-ID: <20240610230706.34883-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: a782c336-37bf-42a0-880c-08dc89a21b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JwmTK9901lRXaKad71XTxTPo2ufdakT/3tKU0LmlOAJzhl3g52SpgJYwfx9m?=
 =?us-ascii?Q?dF0YqYitiNNIV0SkBzoSnJGgjPFCx8vypBQmEqjnX5u9GNrQhoYB3NeVD5ql?=
 =?us-ascii?Q?BUpTE+nJcY/dZ88zxWk6lG6I5VyD5L1BCEVYXUVQIbr2tKqR2Be7ypxcbWe2?=
 =?us-ascii?Q?kQtN3thvAYjDDAMIQ2OBFaf5GDOpWG1z5CdGXRN3NFK1dbWeowXJy3vWjAR/?=
 =?us-ascii?Q?swUbZHKse/1UPkYqhpZUfZxhM8+J/qsQcGga0z9Gy3X9I9Dij5qHFC4v8KMS?=
 =?us-ascii?Q?ZJRQAFs0ssRA9niAS1XeGXou6LMqSJWLhFA29gol4xvDxcidXbnG3Y6h3jcE?=
 =?us-ascii?Q?LmPGry8caY27KS926THCm6d8i6X9T4rwFEFYc6wx1jypgmB2Vc9p7t3M3eTc?=
 =?us-ascii?Q?eyxP8IMHPVaNDc5S7Ieoq+kXcGPCwKWKeABQIWh9IBIZW028tHb9r9OcbnFy?=
 =?us-ascii?Q?e161v2a7wm5i0kg157KcTwp6euPD3BqErsqeMu64vMhgxV0ziS6ZGatGR/Ac?=
 =?us-ascii?Q?Na0uzMx8De2UgMtlhKOObwGXwdZP2HGaOPjQavcIRFsJvhtbeJfWa1lr8gFO?=
 =?us-ascii?Q?BN/78ufd0vj/2vTGAnnnifbqD5QyMYmlby/gugBXf0zTL/osthcOnp6r13bS?=
 =?us-ascii?Q?JR+0Ti3yUPDt/hIQBp/OjiEA2zYEDyLwxoIcSlIVqf79p9n/awmdFisjKvMG?=
 =?us-ascii?Q?wfVPASy9/Pd7dfyS7MQWBymr/DEbcUMbM3eAAfvDfWXmrrUUzF6Ni4XNfmeu?=
 =?us-ascii?Q?8PQvXXvFS/Vt9yza0tMcMpD0MnJBkTFvtPyqJGnfdz+fNhCUIxevk2v8R5MP?=
 =?us-ascii?Q?e6ggcsl5fyV6xLe4ZuH3C4gabVHlMyM0mIyrzmTT7sVy29UGJdBjZOQX/8OJ?=
 =?us-ascii?Q?6GBFI0eeyTKI5O/enpOlF8qWF36U5Cu3JoVAyTwmrlAaFKIoetftX3Pqh+Gk?=
 =?us-ascii?Q?wDEvL7U2D7C6NGOB17pq/SoQSOqdFYhTvIzb9a8MvB2aUeMJK4zWUJGU4F3c?=
 =?us-ascii?Q?bfmSno+10wT0IqgZur0+l2rj2XfbuCqOrBGJRAAHfs+q5tdlQ0wM85AjMqoD?=
 =?us-ascii?Q?j7pd51WLzPzcubr4YiCiDTD3u+VKWGlD5Fj/psSonAcdjyX/lzyzHDc5Vqs4?=
 =?us-ascii?Q?FbDtVOl2Kc6XixcB9d0xw5x0bPRb0rwr6X+SUmkBZByW6AbKOoBLaxM1ZZSM?=
 =?us-ascii?Q?3DIZtq615jrUeVZQTA3MiPLq7xg0bRkVaLRnB2fMjFfxAsKG6zccCJW+AwCM?=
 =?us-ascii?Q?D7Z/1dC71PD3BoMMKacCFISdHADupiO4+dlumvdXDbFtoUbz0Kaj1tpM5haS?=
 =?us-ascii?Q?Q5F8nD8TtIq7S+MdcZ5ehbhlWSj1HqewiyR17fLMrchuqCIisgPUOUAIK2X+?=
 =?us-ascii?Q?PAhBWEjWIAu07GacsyKhs6RwfMv270H7y9h5y4y4LXqqn7awLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:31.7134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a782c336-37bf-42a0-880c-08dc89a21b76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

Add the first queued work for checking on the missed doorbell.
This is a delayed work item that reschedules itself every cycle
starting at probe.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  1 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  1 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 65 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index df29c977a702..106ee5b2ceff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -56,6 +56,7 @@ struct ionic {
 	unsigned int nintrs;
 	DECLARE_BITMAP(intrs, IONIC_INTR_CTRL_REGS_MAX);
 	cpumask_var_t *affinity_masks;
+	struct delayed_work doorbell_check_dwork;
 	struct work_struct nb_work;
 	struct notifier_block nb;
 	struct rw_semaphore vf_op_lock;	/* lock for VF operations */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 6ba8d4aca0a0..a6a6df6b7304 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -372,6 +372,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	mod_timer(&ionic->watchdog_timer,
 		  round_jiffies(jiffies + ionic->watchdog_period));
+	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 342863fd0b16..30185ac324ff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -47,6 +47,60 @@ static void ionic_watchdog_cb(struct timer_list *t)
 	}
 }
 
+static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
+{
+	if (napi_schedule_prep(napi)) {
+		local_bh_disable();
+		__napi_schedule(napi);
+		local_bh_enable();
+	}
+}
+
+static int ionic_get_preferred_cpu(struct ionic *ionic,
+				   struct ionic_intr_info *intr)
+{
+	int cpu;
+
+	cpu = cpumask_first_and(*intr->affinity_mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_local_spread(0, dev_to_node(ionic->dev));
+
+	return cpu;
+}
+
+static void ionic_doorbell_check_dwork(struct work_struct *work)
+{
+	struct ionic *ionic = container_of(work, struct ionic,
+					   doorbell_check_dwork.work);
+	struct ionic_lif *lif = ionic->lif;
+
+	if (test_bit(IONIC_LIF_F_FW_STOPPING, lif->state) ||
+	    test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		return;
+
+	mutex_lock(&lif->queue_lock);
+	ionic_napi_schedule_do_softirq(&lif->adminqcq->napi);
+
+	if (test_bit(IONIC_LIF_F_UP, lif->state)) {
+		int i;
+
+		for (i = 0; i < lif->nxqs; i++) {
+			ionic_napi_schedule_do_softirq(&lif->txqcqs[i]->napi);
+			ionic_napi_schedule_do_softirq(&lif->rxqcqs[i]->napi);
+		}
+
+		if (lif->hwstamp_txq &&
+		    lif->hwstamp_txq->flags & IONIC_QCQ_F_INTR)
+			ionic_napi_schedule_do_softirq(&lif->hwstamp_txq->napi);
+		if (lif->hwstamp_rxq &&
+		    lif->hwstamp_rxq->flags & IONIC_QCQ_F_INTR)
+			ionic_napi_schedule_do_softirq(&lif->hwstamp_rxq->napi);
+	}
+	mutex_unlock(&lif->queue_lock);
+
+	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
+}
+
 static int ionic_watchdog_init(struct ionic *ionic)
 {
 	struct ionic_dev *idev = &ionic->idev;
@@ -70,10 +124,21 @@ static int ionic_watchdog_init(struct ionic *ionic)
 		dev_err(ionic->dev, "alloc_workqueue failed");
 		return -ENOMEM;
 	}
+	INIT_DELAYED_WORK(&ionic->doorbell_check_dwork,
+			  ionic_doorbell_check_dwork);
 
 	return 0;
 }
 
+void ionic_queue_doorbell_check(struct ionic *ionic, int delay)
+{
+	int cpu;
+
+	cpu = ionic_get_preferred_cpu(ionic, &ionic->lif->adminqcq->intr);
+	queue_delayed_work_on(cpu, ionic->wq, &ionic->doorbell_check_dwork,
+			      delay);
+}
+
 void ionic_init_devinfo(struct ionic *ionic)
 {
 	struct ionic_dev *idev = &ionic->idev;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 7dbd3b8b0e36..d87e6020cfb1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -28,7 +28,7 @@
 #define IONIC_DEV_INFO_REG_COUNT	32
 #define IONIC_DEV_CMD_REG_COUNT		32
 
-#define IONIC_NAPI_DEADLINE		(HZ / 200)	/* 5ms */
+#define IONIC_NAPI_DEADLINE		(HZ)		/* 1 sec */
 #define IONIC_ADMIN_DOORBELL_DEADLINE	(HZ / 2)	/* 500ms */
 #define IONIC_TX_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
 #define IONIC_RX_MIN_DOORBELL_DEADLINE	(HZ / 100)	/* 10ms */
@@ -386,6 +386,7 @@ bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos);
 
 int ionic_heartbeat_check(struct ionic *ionic);
 bool ionic_is_fw_running(struct ionic_dev *idev);
+void ionic_queue_doorbell_check(struct ionic *ionic, int delay);
 
 bool ionic_adminq_poke_doorbell(struct ionic_queue *q);
 bool ionic_txq_poke_doorbell(struct ionic_queue *q);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index af269a198d5d..a04d09b8189f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1193,6 +1193,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 	if (lif->adminqcq && lif->adminqcq->flags & IONIC_QCQ_F_INITED)
 		a_work = ionic_cq_service(&lif->adminqcq->cq, budget,
 					  ionic_adminq_service, NULL, NULL);
+
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
 
 	if (lif->hwstamp_rxq)
@@ -3408,6 +3409,7 @@ int ionic_restart_lif(struct ionic_lif *lif)
 	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	ionic_link_status_check_request(lif, CAN_SLEEP);
 	netif_device_attach(lif->netdev);
+	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 
 	return 0;
 
@@ -3506,6 +3508,7 @@ void ionic_lif_deinit(struct ionic_lif *lif)
 	if (!test_and_clear_bit(IONIC_LIF_F_INITED, lif->state))
 		return;
 
+	cancel_delayed_work_sync(&lif->ionic->doorbell_check_dwork);
 	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state)) {
 		cancel_work_sync(&lif->deferred.work);
 		cancel_work_sync(&lif->tx_timeout_work);
-- 
2.17.1


