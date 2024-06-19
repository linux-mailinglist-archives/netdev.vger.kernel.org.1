Return-Path: <netdev+bounces-104695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFE90E0ED
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC99B21745
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395131878;
	Wed, 19 Jun 2024 00:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OwcWy2Fz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94D4C9F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757233; cv=fail; b=ICN93O+/qAQ4eEqMOs4JZgeGlO4Xdu5NVZdYWet+EVjQMoVItSLyuJidMArE8FPd6RxbhRP+C1Vkda/WN9+DIyV0sVwO93mrE4eIZ4NN6KBrqeUlEuzV+dReZOHXZQMJpSI3sGhtU10SlIxjpOGJ6/jT2iDDdN1nE4OCC8/tiNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757233; c=relaxed/simple;
	bh=Wikd18BAnS7WjA25uNUk9utIr307krUGH+I2/UpLDXk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWnG0ho6hrYxCuMSEkXFHO7OzPXasoNZfK7mg3gGzXoffQonwyO93SvQgoa7qazJUkbivx0q7I8qNcohY8Je4BXLU/gs4N9mudZr2uFTpjraw2rNJIfCOFZZvU4T7EFrloG+3kyAt1sCzYt6/5n8eFSsWm5ywBql5lb/ch3Eu+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OwcWy2Fz; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF9lb06okuBGl0g1absWyTtem7o1GZKh4leJplJ20yalfILps0MthS2Tlc5GEZ5zuwxUHgx5+uumm/ALx5dVhnkGNXaNlZVivxjx/xYj9qrREeRa4U7mUyzZZvYEfmKCFnR7pnt+UIxoI1AymI6gX3u7KULniYPS+9MQsxEEjSnQgGcojVocfcJ4enYq1OrzTX41yoiP2WiYiMlJU7Zo0BCii8hwk1ngRLq5X/JsolE9nlFzwdKFtVqcQw2OQIywsDnoyxBVtlKe0KVkMHAy69N9aGcpoJtmEBwVfczDnGqplWP0XkK1wTT2BFaoy3MKk7AIqVtdS3M6mZiDrkRQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjCWxZ3XVi7UGdMfDZTICWVfrbpT/FOMSPFdGHmgZqI=;
 b=WzWBpwOy4cX11G4vUGawYNorr6veNFuNKeMT7RaTa8X+ePTK2J9ty4yygCPweB872LhvviHckAmKv3Yf8vs5K9whBfBPtGB/DLf1BGDen6MiZcNMZ0B1YpI3Qerb+m/X90c7UcgPk52WcJ4MaEOSAPF2iuizhhf4STP1OXj+Mq7wICt1hRWttr7rN9Z9hYuq2+kaVdaeCHlEG0fAUb7j3+gUYJU2t1ku4GncL+Rc99yYQEOFAvRqp6hZ3IFFleexnG3yxVkkK0c0wMY53wUA2/LFpN7gtpWdPsXVNzxfBv+yFac1QnoZ0eu+RqQZ+c0Qyip9qi8KgOeB2sniY5hyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjCWxZ3XVi7UGdMfDZTICWVfrbpT/FOMSPFdGHmgZqI=;
 b=OwcWy2FzPfeDsgltpUZBlJgPig0o4k1hVoBHAv1v31Tmon2fkE32LTv/hKz5nyh1/dW/BgKvx6/L1sDASWPyqMA7apCdvcX9D/viMINqDQQM69Zkvlz8BAFmsixEyPDNJzGqRIPtZYWJI9PF44jWFcRxiHPHKNTlFZT6pCIkVb8=
Received: from PH7PR17CA0037.namprd17.prod.outlook.com (2603:10b6:510:323::28)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 00:33:48 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::9) by PH7PR17CA0037.outlook.office365.com
 (2603:10b6:510:323::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:26 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 3/8] ionic: add private workqueue per-device
Date: Tue, 18 Jun 2024 17:32:52 -0700
Message-ID: <20240619003257.6138-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: c7422ef5-c3c7-43e7-8be9-08dc8ff77c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ItVVjE281YWIFHl8h0Ul+U8s17ZvDMWTvvRgTwrNcB8Yqh7a1RSWcLoiRrqy?=
 =?us-ascii?Q?DyzoaZZ9YtQijxuHXYeWRzQie7Yn6ElTsU+495HMLzAvHGqvD3tdan1Pb+iF?=
 =?us-ascii?Q?k2xj1mu8P3A0nGFoLF9ik9oe8MtowQqF0hLAhhCYrYuLvCAEeZDlGjUpK21b?=
 =?us-ascii?Q?6XsXClfkUgmOpHrxrKtXEU7H9Mi772Q/wPyMzDDSYmVV/NJl2/K3Ivz9YDmk?=
 =?us-ascii?Q?vEa2KaLuzh0EcvUU1iy4AMvW1/F0sk/YKd6XreG9RXSU6rzM+IyPNiKlOPGc?=
 =?us-ascii?Q?6hUBwYXd70s6BI32lx23XrKk9oLF/h5JH8rOtwNID8y825Y7qn6LVbHY6NT/?=
 =?us-ascii?Q?WU8JVzFdtXgTE/NmdWcUCbFL7d0peetxI460aIDRXC1zOjtmVS7sXzDJvrIf?=
 =?us-ascii?Q?HcQfenJNqtypkQ34WTiexVMluxq2bkncKYpMKgMdTEK6ZX3jPkW7IQw4i82f?=
 =?us-ascii?Q?nZnnNVEGgCOxx7+EBYEOVW7UGaIV4T+umEVTm/Lo75LApkXpFX8lmIzTsGUM?=
 =?us-ascii?Q?U5hmybG0X38PmFH7o9DG0gAvByyz8fAGgZpJ2nIYzfp9RQCCMQzq/o2H3s/h?=
 =?us-ascii?Q?DMVmMXueI5kF5zdgSYWooNjEWcr6Zpr7Xskv1bYA+F4r4pXdAR8WTbMvqVYP?=
 =?us-ascii?Q?LT/3fXqkiwnMG+n3IqiK0ypjuH2suvTkn86xIrGxBzQi2/dAg+CC8lWC9xbp?=
 =?us-ascii?Q?/tjvJJ5i7pKXQQAKJ8trHrYCxoyDSGEFJacq0Ss35rjYPWBBuvRLlZWT0FJu?=
 =?us-ascii?Q?nooG6XYwy7xJFYx/okOnS/45z3RCdeuVmMh75TlXRWWIU9rCdvQQy6KfVjMY?=
 =?us-ascii?Q?muZLuV6858arld0JG1yZd3C/59lb3POoKMowiuGIvRpYd7Xck4+OgpAu5MJS?=
 =?us-ascii?Q?viTGhua/AR70t5aH4EPbAyoycOrjzYGCKsWxmKLWQq3Qgdl4zXfd1sZmZ008?=
 =?us-ascii?Q?wjVLLB70n9ZQGfNTm8Hc5F/jgvQ18SBPEcZsWwH62TxCWR8pMAcC701gVV7R?=
 =?us-ascii?Q?FprcVEzWxYVpPAjw0UfyPPCBLwaoescNm+4KAnj+8x6xLZqWEw0mfvOqfdwA?=
 =?us-ascii?Q?DUv1hcdbDCGs38U5dUpkX115Cc9/oeICj7DarbdKuNfRe3v9zfZ9iII/bmzQ?=
 =?us-ascii?Q?eDSM0SDx5T47M65wyeQYUaxNTJlRqytpqiTFx8yLODb2o4Ny2nNtf+/MPSF8?=
 =?us-ascii?Q?pMRaaKYpDT7YZUEj8IcZpdlQqLzrqgGOMvik+opMeluWjaGxN1wjuDTWvhpt?=
 =?us-ascii?Q?V2cbJEqukrwsuHMdTUsk9JVUmE1MTqQ95RZdDVCP/YqSDLAE8haSyydKntkQ?=
 =?us-ascii?Q?7qX2TlQ9B+Xn6SPY9qcEBh3Xn1Disx1P2JNzNPhgwb0v+pqWL3U1RbnYGwAF?=
 =?us-ascii?Q?XDvLq8vFtny3vsVh5S6TI9tF3KOs1waQSKHqada3v4IutkEuvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:48.0391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7422ef5-c3c7-43e7-8be9-08dc8ff77c1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044

Instead of using the system's default workqueue, add a private
workqueue for the device to use for its little jobs.  This is
to better support the new work items we will be adding in the
next patches for PF and VF specific jobs, without inundating
the system workqueue in a couple of customer cases where our
devices get scaled out to 100-200 VFs.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 21 +++++++++++++++----
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 14 ++++++-------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_main.c  |  2 +-
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 438172cfb170..df29c977a702 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -47,6 +47,7 @@ struct ionic {
 	struct ionic_dev_bar bars[IONIC_BARS_MAX];
 	unsigned int num_bars;
 	struct ionic_identity ident;
+	struct workqueue_struct *wq;
 	struct ionic_lif *lif;
 	unsigned int nnqs_per_lif;
 	unsigned int neqs_per_lif;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 89b4310f244c..342863fd0b16 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -43,11 +43,11 @@ static void ionic_watchdog_cb(struct timer_list *t)
 
 		work->type = IONIC_DW_TYPE_RX_MODE;
 		netdev_dbg(lif->netdev, "deferred: rx_mode\n");
-		ionic_lif_deferred_enqueue(&lif->deferred, work);
+		ionic_lif_deferred_enqueue(lif, work);
 	}
 }
 
-static void ionic_watchdog_init(struct ionic *ionic)
+static int ionic_watchdog_init(struct ionic *ionic)
 {
 	struct ionic_dev *idev = &ionic->idev;
 
@@ -63,6 +63,15 @@ static void ionic_watchdog_init(struct ionic *ionic)
 	idev->fw_status_ready = true;
 	idev->fw_generation = IONIC_FW_STS_F_GENERATION &
 			      ioread8(&idev->dev_info_regs->fw_status);
+
+	ionic->wq = alloc_workqueue("%s-wq", WQ_UNBOUND, 0,
+				    dev_name(ionic->dev));
+	if (!ionic->wq) {
+		dev_err(ionic->dev, "alloc_workqueue failed");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 void ionic_init_devinfo(struct ionic *ionic)
@@ -94,6 +103,7 @@ int ionic_dev_setup(struct ionic *ionic)
 	struct device *dev = ionic->dev;
 	int size;
 	u32 sig;
+	int err;
 
 	/* BAR0: dev_cmd and interrupts */
 	if (num_bars < 1) {
@@ -129,7 +139,9 @@ int ionic_dev_setup(struct ionic *ionic)
 		return -EFAULT;
 	}
 
-	ionic_watchdog_init(ionic);
+	err = ionic_watchdog_init(ionic);
+	if (err)
+		return err;
 
 	idev->db_pages = bar->vaddr;
 	idev->phy_db_pages = bar->bus_addr;
@@ -161,6 +173,7 @@ void ionic_dev_teardown(struct ionic *ionic)
 	idev->phy_cmb_pages = 0;
 	idev->cmb_npages = 0;
 
+	destroy_workqueue(ionic->wq);
 	mutex_destroy(&idev->cmb_inuse_lock);
 }
 
@@ -273,7 +286,7 @@ int ionic_heartbeat_check(struct ionic *ionic)
 			if (work) {
 				work->type = IONIC_DW_TYPE_LIF_RESET;
 				work->fw_status = fw_status_ready;
-				ionic_lif_deferred_enqueue(&lif->deferred, work);
+				ionic_lif_deferred_enqueue(lif, work);
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index e53375e61e20..cd12107f66d7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -126,13 +126,13 @@ static void ionic_lif_deferred_work(struct work_struct *work)
 	} while (true);
 }
 
-void ionic_lif_deferred_enqueue(struct ionic_deferred *def,
+void ionic_lif_deferred_enqueue(struct ionic_lif *lif,
 				struct ionic_deferred_work *work)
 {
-	spin_lock_bh(&def->lock);
-	list_add_tail(&work->list, &def->list);
-	spin_unlock_bh(&def->lock);
-	schedule_work(&def->work);
+	spin_lock_bh(&lif->deferred.lock);
+	list_add_tail(&work->list, &lif->deferred.list);
+	spin_unlock_bh(&lif->deferred.lock);
+	queue_work(lif->ionic->wq, &lif->deferred.work);
 }
 
 static void ionic_link_status_check(struct ionic_lif *lif)
@@ -207,7 +207,7 @@ void ionic_link_status_check_request(struct ionic_lif *lif, bool can_sleep)
 		}
 
 		work->type = IONIC_DW_TYPE_LINK_STATUS;
-		ionic_lif_deferred_enqueue(&lif->deferred, work);
+		ionic_lif_deferred_enqueue(lif, work);
 	} else {
 		ionic_link_status_check(lif);
 	}
@@ -1389,7 +1389,7 @@ static void ionic_ndo_set_rx_mode(struct net_device *netdev)
 	}
 	work->type = IONIC_DW_TYPE_RX_MODE;
 	netdev_dbg(lif->netdev, "deferred: rx_mode\n");
-	ionic_lif_deferred_enqueue(&lif->deferred, work);
+	ionic_lif_deferred_enqueue(lif, work);
 }
 
 static __le64 ionic_netdev_features_to_nic(netdev_features_t features)
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index a029206c0bc8..e4a5ae70793e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -331,7 +331,7 @@ static inline bool ionic_txq_hwstamp_enabled(struct ionic_queue *q)
 void ionic_link_status_check_request(struct ionic_lif *lif, bool can_sleep);
 void ionic_get_stats64(struct net_device *netdev,
 		       struct rtnl_link_stats64 *ns);
-void ionic_lif_deferred_enqueue(struct ionic_deferred *def,
+void ionic_lif_deferred_enqueue(struct ionic_lif *lif,
 				struct ionic_deferred_work *work);
 int ionic_lif_alloc(struct ionic *ionic);
 int ionic_lif_init(struct ionic_lif *lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index c1259324b0be..0f817c3f92d8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -287,7 +287,7 @@ bool ionic_notifyq_service(struct ionic_cq *cq)
 				clear_bit(IONIC_LIF_F_FW_STOPPING, lif->state);
 			} else {
 				work->type = IONIC_DW_TYPE_LIF_RESET;
-				ionic_lif_deferred_enqueue(&lif->deferred, work);
+				ionic_lif_deferred_enqueue(lif, work);
 			}
 		}
 		break;
-- 
2.17.1


