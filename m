Return-Path: <netdev+bounces-104696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652E90E0EE
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032221F230ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D30046BF;
	Wed, 19 Jun 2024 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TydnOyY4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CC6112
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757233; cv=fail; b=ipTGeJh/fFVHttRjUDWxSuoq44LMtWnQ7s1woyEVgwFAhgFsidz4QeFfjgWVsFUgs2nYu1zxt8oamUgNTtTmEONEx/XWiMWbfjiKGFbnhZ2Yyxi/S0ex5g3P3Ofd90AhcFJ8ALGpiG+F/9F5lxzzWl6IyWC+34pP3P+qh1OtFlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757233; c=relaxed/simple;
	bh=7IqtFTmFTUpqvwNZkWvfb1NGykkvuiTh1P8w1Kop328=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kW8R0f6qezuOhVHWnMaRnnJ4SdWJvM6UuzWUcJmjD781XJ+yRgEoqNyZ2p30ooBatdvo7bnQYJBwMDfSQg+bp/Ai/3DZYnhK42/kGcMa0drTRmnkG6K1SLZoG6caSLUfrwhfcP8jvZ2H8y9qQiQtPeG1y4+wi4ULNTUrpxu4tz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TydnOyY4; arc=fail smtp.client-ip=40.107.96.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYW+tQ3prTTg8ulXpm144pKD+sXeIQ7CdlLR35GqDQhkMqiM7vZ2BlCFv3FeSLT1Jz0sJhE2kvpCis3mUG38n/Vt0RHdFucBSl9O6yzk9ZvNH4lWpnD4uIEwKrS7l7HXj1QOVaEoh9Xkk4XzHkHJwJY0+C4hGrXnyIPkGCYfpvAtJZ7EO/FReufe+e3rT5n/DcGU5os2KzCFy+/erpO69jLlaTqRtIkKzeuvfvFNFQ3C9xfBJfya6M8D19b0BwjlrMIyNyuwF/Tc+rlW2optXNlrsVfp2Ser0jB6TsOKgg8jMbThkbJF0ad0kzVxlxOi4prfsAsEzMGSWh/ej8/xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkXPci90f9gUI8GIm5oSooMxWEVWBEzxbpWePUS2GK0=;
 b=Q0F9tMb81wUBGqxTXj37xswVxq4uP0VzXjxsd8eorhS41t82EL8ZWLQO+Bf29ZSKWI5w3jqYzIRPVo4URw5PA/dVcfh4rAq0RnT3ipHNOBGEcoau9z6TO0fiFw9jO6mMhim9xmL1mVlu7LJfHL/wT8iBY3ew4oNz+BNQQ1VCXoj/+p1yy+qNNhyAHlZzIIfe8l1md/WdzH5FlUmgPfIZMV1juTG6BtTvI9enpVBlpocnno2aT2TO0zgEMhuoT7M/dsC+iruUh2Er8bqZotvy2/+A5cK1ZHb/1SOCxe24udYiXGmcFoi127twLKzw0qjttLrBToJv/TCmFZpidZYPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkXPci90f9gUI8GIm5oSooMxWEVWBEzxbpWePUS2GK0=;
 b=TydnOyY4Fwsu4I633wDVNC1eLomXx+cqG1FQ44iMMVs5YyI5pQe9pzOmtiT8aXOSsuiKFCu9oHC6B6oiv66cczfxylpsRPPasHyOklYXNbXgXwGl5sPVXxykHDsm+BjDIxM4/CoKfjf4ALVF7JuQ7EowjEyoJY+Z9RQHEONGGGk=
Received: from PH7PR17CA0045.namprd17.prod.outlook.com (2603:10b6:510:323::10)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 00:33:49 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::ab) by PH7PR17CA0045.outlook.office365.com
 (2603:10b6:510:323::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:46 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 4/8] ionic: add work item for missed-doorbell check
Date: Tue, 18 Jun 2024 17:32:53 -0700
Message-ID: <20240619003257.6138-5-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: de98d07e-fb5b-4915-70f6-08dc8ff77cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?buyihoEVtFjE+cU7lMpisuCu6skBCxDB9H71FDegddJEXIMVBarbILmfNmdX?=
 =?us-ascii?Q?lrEsrgU0oV1hEp34PmbZ8wyKmi5Meap9BJEoN3b9hhKeUB3YYgYw+4IiWGfD?=
 =?us-ascii?Q?y/U5auiZCVYUbMcPO4heKZeibZk76EJ9+Wk1IjvKkO0W8Qx5JRBBYsha6P6p?=
 =?us-ascii?Q?eubAvT2gKXqFtNcQ7H5T9F79THUWSMhbJ3MO1fDwTJNUoGb+/yb2CWGaMDnT?=
 =?us-ascii?Q?Pv1ghnpSBKz4y/OnLMzreZynSUgBqTpZE/ww549r2cdDu7Iy2PIl1b0NuTsH?=
 =?us-ascii?Q?cq26sYvmtBz6u42n8PBw1KFYTY1SD0jP6Vk8ATIGLGIM6AE82k0VjX5kSxYY?=
 =?us-ascii?Q?MtJvNbfki8Wh+hkoPGW1hL8iz0ka2MVl3aWldFfAI0brozHQKBE1D2dsLUuB?=
 =?us-ascii?Q?P3kubxPJiitc0uEsgridRJ5gfr226apIljWUqnIgkmSeahGn8DFLCwBVezxO?=
 =?us-ascii?Q?HYWs7Ia+MXchvqdXq4gA7XyGBf2Lwytv7zAY+n8VHVjndw7z0a1ahwHJYS//?=
 =?us-ascii?Q?nig16+hoafeId5iJ1qGkO+yI/N9GqkxqxE9sysirkb/o5QYqUbmDHXceHd7K?=
 =?us-ascii?Q?C5bA5yCPCkOvkeVxp9aKgiHAVC0R2EVoA7ovNq5jgorP004J61TzfVwmKziK?=
 =?us-ascii?Q?allqXibyAhUabzaC+xwlJH4fz3LKcgTeaIanaJFCqakjeNAvBlQKj5IUh2sk?=
 =?us-ascii?Q?yfEvkMYUuWchVoklZtfORVZj1vlVTpzoGvzot0wnOimmol2T2AyLbYnAKwQ+?=
 =?us-ascii?Q?owt9N31yZ5zERFJcS2AVHOLjqnQ9qSsN+4v4r8lYkkpncA0VkfLrLiYoLOfh?=
 =?us-ascii?Q?ygcaKAprIQdpTx65W2bkfv7sEsjpHxc131MjjXKk2M2FJxS5lZUkKN/RFhfb?=
 =?us-ascii?Q?Gfp/1gbBA8/a02YmrsSYj5mJREGJMkgODlPkHn+KjFGBewjmjN2inXYDQHN7?=
 =?us-ascii?Q?ojDem2kZKac0urbo2s1ikkPugQwKiHzBuJ6r0WPVf1vzHNPu3Jk9GuZxVyqk?=
 =?us-ascii?Q?ttILaeWXTgBoSJbNEaFC52lLPovvYC0lHVxqifmCTC4uW5oTLVZFLXWUEuN7?=
 =?us-ascii?Q?qvBelZnnscweKO9PyLxh6ruZZ29zPUjqSWUU7B+LBBmYB0sfpc8Gn/4LCpev?=
 =?us-ascii?Q?RDPJ7H4j0SfBD3i/KxxrQDrVsbjpJf7hbylgDftg93xZ9XUqZ29EN7pEwAbM?=
 =?us-ascii?Q?oG5lNNA/KMwbFuu869zdTsRuMYsTKeTlh2Yn4Betvc2eexIZvQcaJXiIIa0U?=
 =?us-ascii?Q?4fhdGewn94kAU5MznfYQdR7i5gIkPSN/ti71ESruRbxD75KSoS+E+Wo/CGqE?=
 =?us-ascii?Q?eBRqi/FuY/edWnYCRgCICnsj81yW54Y0w5/zlKP7DPjrQ6B8hzAIKOQuChtn?=
 =?us-ascii?Q?LtCoBTcw1zUenkBc7ALSxNQTxDCNMUegRR244zwIf6I5mo13UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:49.1329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de98d07e-fb5b-4915-70f6-08dc8ff77cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

Add the first queued work for checking on the missed doorbell.
This is a delayed work item that reschedules itself every cycle
starting at probe.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  1 +
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  2 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 66 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 +
 5 files changed, 73 insertions(+), 1 deletion(-)

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
index a7146d50f814..f362e76756df 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -377,6 +377,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	mod_timer(&ionic->watchdog_timer,
 		  round_jiffies(jiffies + ionic->watchdog_period));
+	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 
 	return 0;
 
@@ -411,6 +412,7 @@ static void ionic_remove(struct pci_dev *pdev)
 		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
 			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);
 
+		cancel_delayed_work_sync(&ionic->doorbell_check_dwork);
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 342863fd0b16..5d5990e7376e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -47,6 +47,61 @@ static void ionic_watchdog_cb(struct timer_list *t)
 	}
 }
 
+static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
+{
+	local_bh_disable();
+	napi_schedule(napi);
+	local_bh_enable();
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
+	mutex_lock(&lif->queue_lock);
+
+	if (test_bit(IONIC_LIF_F_FW_STOPPING, lif->state) ||
+	    test_bit(IONIC_LIF_F_FW_RESET, lif->state)) {
+		mutex_unlock(&lif->queue_lock);
+		return;
+	}
+
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
@@ -70,10 +125,21 @@ static int ionic_watchdog_init(struct ionic *ionic)
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
index cd12107f66d7..42a587d14d01 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1191,6 +1191,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 	if (lif->adminqcq && lif->adminqcq->flags & IONIC_QCQ_F_INITED)
 		a_work = ionic_cq_service(&lif->adminqcq->cq, budget,
 					  ionic_adminq_service, NULL, NULL);
+
 	spin_unlock_irqrestore(&lif->adminq_lock, irqflags);
 
 	if (lif->hwstamp_rxq)
@@ -3406,6 +3407,7 @@ int ionic_restart_lif(struct ionic_lif *lif)
 	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	ionic_link_status_check_request(lif, CAN_SLEEP);
 	netif_device_attach(lif->netdev);
+	ionic_queue_doorbell_check(ionic, IONIC_NAPI_DEADLINE);
 
 	return 0;
 
-- 
2.17.1


