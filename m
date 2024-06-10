Return-Path: <netdev+bounces-102387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657C5902C32
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE46AB21752
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B613152186;
	Mon, 10 Jun 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MK+pBVFs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC501514C0
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060855; cv=fail; b=l3SQQbasgNOfJrfC69kPRM0cFr0awN6D9ppgtTzyTs7j6YbmzxWHGiNtmK/SNZiuzcohZ9OSfobsAGnfyShEMP4avJAa5dFQTkJpN1ashzyXu67iJGU6Ef280jJO4Pdj60uECejp+axAxYnWvohdKXEDkAHg7o0/+u3SJaVHNpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060855; c=relaxed/simple;
	bh=lGevOxzgSHDUBrv1WmzTp5XoSm82wZrs0XCPRA1VgW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXSFgtfOKLSlFD8aoSIGbyuMTyljyuZbOpmorBLHWCLi9k2z0NmJA3ZR2s9mxVSPG0ziVSEe1vbxcEVwZR3Z6eY2nEet4mFUZvY2uu3WVRHSJeB7o9n86vcJWw3ckFvdYba0OrdHPP1zEVOKDu6Og7HabV9OuvaCYjqinOsmYP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MK+pBVFs; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU5B+eepK32dS27oVglTyhP0MgAxBKEod660503L8c6d0FnllVVmbpMOciikVdqhaatkm3LBiPpWehCj9iVuBVXUWKmE0gQ+4qBfXH4LW/w/WE+rtzjZrLrfesf4NjgOtbv5Pk06Q8VyZWcwx/wQzf+Mdov/i6TXEiyn63QLfJntspkhVJzcgAN5fyFFoTxW8Sstulqw5218l79zWDxqQDZeoPnSNqVvdnUU/4je+H57iYxqhgPOZMzRaqAqpyPS4pMPegX0JgUAk8oPUGGNIH5QiIVu/KPxOBmJSlxcWNPIJijIQ8EzsNs8aUJZySyLkXxdrjcBMkNMciwHfPZHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNAFByucoup3ugeuW4Km+KzUTLZr9/lGitT7gTetok8=;
 b=ERAn0G+j8KfCfTqPz6LgNQUjxWR1Iu0LI3pQo1B9+k0H1MCGpCACc18rvHgyUDG5jsNpyL0d9vfl3+tZKkXbiuaTY5ZlQicXvumITTtJAOmK8ikWM0u5DGIsFdHSKhmerXguGrMDxhR6kG0EToBdA8XI/kYalwW071ZXMcj5lf6SZQqADIqsTHv2wvzKG+S5QdEVJfPzl9GX4N5w4+17kesuGKOwO8On1lC1xBqGJ94o7A1wC+Tml6kOhnyTal+4XBg3VnsQhKjrW/D6bXj0lM3ytWtqoYmd8gTLnwilARXfXoD8cmzMcS26+9Ee1gOEcMA8NhgKWJE2SPKCJoE8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNAFByucoup3ugeuW4Km+KzUTLZr9/lGitT7gTetok8=;
 b=MK+pBVFsrLLFpBJlyNJ9Uy/YAsYdLTU8v8yYBc3/GNclAlcBqojQLMJ+BNPmZsneFvBzUWGyvGTgIr9dXe55iyMyD9eVI/7ZIZPAhwchUzi2JUz6dfcsqoD/xMuQjo17t+YBXX2r/ukvJtGAX8MzQLOA16DONZm9D6v0FOV+LuI=
Received: from DM6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:5:190::38)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:30 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::9e) by DM6PR11CA0025.outlook.office365.com
 (2603:10b6:5:190::38) with Microsoft SMTP Server (version=TLS1_2,
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
 2024 18:07:29 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 3/8] ionic: add private workqueue per-device
Date: Mon, 10 Jun 2024 16:07:01 -0700
Message-ID: <20240610230706.34883-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: cbec1f68-80b4-469d-792b-08dc89a21ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gPlI68YQ/5OteIfDYhFpgk8QaB9kdR9Cg+XOiPmOYH8zQC0uyLKja4T6yGLE?=
 =?us-ascii?Q?gyrmtO2L4LmDL1heNwgVW2VLyUa8CF6aV/ClD0QX9qKrFdOZw/Ows3SlKFH2?=
 =?us-ascii?Q?qxaw8Zr2wVcTrS+4DMbykhLm+yKehRFE7pIARz7Xp4KsIxbaGpFQBsqvAi0e?=
 =?us-ascii?Q?f1fdr0HBRzyBCJLcRERsTUy7MBHGMwlLUygSL5Bobnfz2XMWWJdby8P0hpbb?=
 =?us-ascii?Q?W88NEZPZk4AlimoPVenqjcsP6r4V1LGwZKU0XTQGExvQYt03o87dy2jm3brQ?=
 =?us-ascii?Q?21TEXE0aoZnLXL3O63XtTXG9tG9CzPrQsa2gJ088P29vmIQlSyjRHFEEq8eK?=
 =?us-ascii?Q?2I5YwU40MvKp/XSxgD46PogGOOPzDn0VmAidYVjqmTonph90x8xkW8kIhHq4?=
 =?us-ascii?Q?KUFB+VPGvarWHsgh+aqaowCzb/RWEGZNqlGl2AkLhMSpE8J3uwr4LT5ymqAF?=
 =?us-ascii?Q?wNak7Gh+h5qFe4QOnG4I2wHdXCUaVnpeffUwFEMB5LG3aZmPBCIYUf8KgWJ1?=
 =?us-ascii?Q?4unuSN5aLRGAqSsItrmcUY064qkTpSM/Mpac5TIUS1aX9OMriAiMqVOPQx3s?=
 =?us-ascii?Q?fxFcEufJ3OEkhQqjO0nIGGPgJCmfL8/aIA3oI83CV23huw0ohuDQZzklDqll?=
 =?us-ascii?Q?7SEYuIqDrlsEzbf0k5IPooA2BPjsVUNi1SpO+3FCvOX9e1wVGGUqaymr6EwC?=
 =?us-ascii?Q?f1FjdfoafZ5Db0Sa56tuffhGU+85vKc24b3ZTHkF+BBoC8PwV/9qDYvhLfhg?=
 =?us-ascii?Q?IrhQJSqmgaLA4Wda6LQyWAnPeihcvU3js0wyeL+hUcYNAiJU39aQBNF6GLME?=
 =?us-ascii?Q?Uro+ve4/A7Hd2PxJkDUhm6K4ZnlZqchmHH0hU1AH7gVYtLWE9Tmyy6vOC+KR?=
 =?us-ascii?Q?ZYAGcpqBbY5p+XL3N2XoOr9wwDcnZLRYJeE5cbU+KDhhw9e7h/eDtq2m+laW?=
 =?us-ascii?Q?5qDqZ/tkqvluev52cgkhX3hSH/ARzUqJt5yXGsiEv4/P25/OEl2/5bVi0cQL?=
 =?us-ascii?Q?Z7uS2jpKH1rhZreVHtMDDQxIWAWV10bnvd5Pyb5t69aHkDzQqWLcsmGvpQXs?=
 =?us-ascii?Q?E+dBA9GsFeSoTra/ZqqX/VN1uzDudzNfF7b+u8VD9UnjaU+QCDAFickkRc7q?=
 =?us-ascii?Q?UAxRb+5PFDs8zknlNeoAgYjo+LZHHLKIgtxl86rjNgB0Y2LJqa9Pt1I7U5Z7?=
 =?us-ascii?Q?+Jd3zhdlLdqERCtVtEZC4XsgUbegtkp+cgCz6pJaRatthzV0+Ys5m31F3WWn?=
 =?us-ascii?Q?lv09vBiWL5ipKyql97rlKvu94Mpr7SyZA+1ItesQL+kj5fwOI8QjoDhWzrA3?=
 =?us-ascii?Q?Jh6S2M66OydHHmh4/vQ5psVd1WZgfcX82CqH48JSGoUqUWDz6zAi+48ANPQW?=
 =?us-ascii?Q?29BPJoAZFg/E7jG67V9UYB5GMYwLV/3SrgugWnXE3WGTrhDRgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:30.7758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbec1f68-80b4-469d-792b-08dc89a21ae7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

Instead of using the system's default workqueue,
add a private workqueue for the device to use for
its little jobs.

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
index ff6a7e86254c..af269a198d5d 100644
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
@@ -1391,7 +1391,7 @@ static void ionic_ndo_set_rx_mode(struct net_device *netdev)
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


