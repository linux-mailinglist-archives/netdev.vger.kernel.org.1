Return-Path: <netdev+bounces-102389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C52902C34
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D53D11F22CF7
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736CA152532;
	Mon, 10 Jun 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LOdqKnKC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951C15216E
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060856; cv=fail; b=SEiz5SEI1e9ZQwllb9kb5xgOAA/QoyM/8MxLf5MI7DlGLy/oiaFbn17dEuJ4aEz75ZEnzME4hdD5hGR4eCCVaG3DeVdZOiGNkeVoqokihPfp11i08jcGIMSU+HN/mKs/BczdadsJfsyC08WTEOuNbyFdWphLQNhgvqOGkryDjcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060856; c=relaxed/simple;
	bh=/cTdyX4v7mu7R4joFmb77I3eoMXOk8K2wTK+H9SL7IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h23KnSHFvxWSB6az0UBXanO8VE8ENpBLcTz+ZQfaAtnsWVaQIiyfBuEKQUkUGKxG6hgijkDmpIDpLBLrkkxxwi1+3k//mrMWZ61R0xv0LuHs5aGNh+6eQiVoORwpn8AqcbTETQDa4AncRaPv4m4YpZNXwVU17HRzLBvdPkT8nY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LOdqKnKC; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noGzP2NFUrTpo8KFW7shP4e+eJEtXEDTlYpOpJKX5zBihbEc9H0QWtiPGb/Q9bJch1pnaEe7X9nlw7UDr0KN8fNALPHc8CfexGdKy03MGGOqf8NYMNdp6MTN9EIsouhutv96+7G/VcTbdbUdSRDkw8yrWJlfjZoPJW4IEfGHyi76Pg4QrhZ782cFGdutADo9ZJKrcpDbDZMBN3CSccX7yqSeZFztHCxdK3vD8s2K2CUpr0n3Q37uWfNiD6778/+59MN5kZtGhyhV9qYlAkN3efFVYtJLMdiDKMFmbGCYa+LpRUJwowV+wN94b/rKn6vINkms+3og7DljENR//MnR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q78fPIwboFPtDs3KLxExyqPMnVBsMwVO+0t3C6yvLd4=;
 b=QYkzOuilmdioYpL5daYDZaymyB5NNi6+Tw++Wc7WQjWKh9iBnHWazKAOlAvPP/hugmk1ZRcO6QPZLcmCaW40Or8OnaiIV5J4JfoIYtv1wkPOF6ODbyArs2+gJEFtA+pM+1Zzx5Tm9zPfxn96ZNMc+Ljgk+u+XLKRilbrkhNPfTrRtmGfUwnC7MwrVzpDGICApNI4TsRKinOsIWvdYnVam+NvwKa5cdtpJ0e6KvVp6k3k9GzGB+pstE7/VGkr1zQqEPeTxoY4WXqCz+sHi0Mu6BIH4LUwJbGl5tHTN80hkN3D4cGJxcneruWdby6xvZEwpFeJruKFpUbEo0wHCvEstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q78fPIwboFPtDs3KLxExyqPMnVBsMwVO+0t3C6yvLd4=;
 b=LOdqKnKCFdD5KU30gioEnm9nNTZ0YKaGk8P/akAFHbRW14x4VswPjCV7DNn6QCtY4ktZ93qsTKllkA4EkSvL8oXBVoPQC2dRPiM8q51aA7kOuKOoH8gy5wUvLMQLkSefV/xDlqb8LaytFZVz8Biy8m+nmXFU5mVV35BXim4J1Jk=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:32 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::75) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:32 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 5/8] ionic: add per-queue napi_schedule for doorbell check
Date: Mon, 10 Jun 2024 16:07:03 -0700
Message-ID: <20240610230706.34883-6-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 654a476c-8ab7-41fa-d255-08dc89a21be1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lifuoLGlAEEySRIgNy+fvCwseyfYJGaB8DScPBfeAJZamvmX/RPiS9Ktax+0?=
 =?us-ascii?Q?LlaEy1Wzrz79Lo/5Q85eJUgtIpMEKRwnC84mFsI1OWep5jAxzfDjHiUeecco?=
 =?us-ascii?Q?h2LKznB9rjjRsMlC+EzEMfTrYHtEnWbegFfs9nXCJu3G+l7dPOST8mbAK7/U?=
 =?us-ascii?Q?hogBjE50Asvhpqy6yMZRGeL1T7B6/jCbFMARQJeGBE+v+JDYMZxOfY1fFtiW?=
 =?us-ascii?Q?65mVplPQVTHNYmYuxfCnS48CIuJEfYA3iGgaKt+ig37HWZieAJ4wXmT4eNjZ?=
 =?us-ascii?Q?GH03mNhVMSPQMEBkIwv2m6hElHx3/i3lL+e/eBfpS0Gz46c+qTO1B5o+ftUD?=
 =?us-ascii?Q?rMmp/BFgqo0lDL6UD5KyH0CYHs2T2GtKbZVbGbxbvD9v9NSREMzS+7coSXDN?=
 =?us-ascii?Q?TGZET7OiGE9pKsgL+m72VsGk/pbU6EWhQuiybpLfo2H5ozMb9pfZkrcJC1pj?=
 =?us-ascii?Q?Z9Leb7F4ReIBK9Z5a4CXG6PfLL3tIEI7DtB3IqQVj2RrZFnF5qBVYUGm8tGF?=
 =?us-ascii?Q?6SPOrQkLC21UVDH+pvHkLjv3hdK2ens2uuqNDA86DOy+DLF80d6pKKzuXy2Y?=
 =?us-ascii?Q?6WUQ9zMXfwabafAZSRXwr2MJT1sGiLMHiTo236QIaAI5Wbb5H3cgpL6xejPu?=
 =?us-ascii?Q?vVo4HIUNAAp+eb8DxVpSTDuGGdlripWQMMufGAMiTYVVD41UyACYQXP916FU?=
 =?us-ascii?Q?WKFWFGAVwz7i7rYkr0adFThihzrRse7Tfk3+lGOG7sctdZgOSyRlc1khNCCa?=
 =?us-ascii?Q?ELVmWjrcAAfb2ztXq4qmPHEWDaYpDUhY2ovu9Fx+joxf73Ps81ARWL5obhAC?=
 =?us-ascii?Q?pZEVEo7IIWSNFGuMlPuQvlGENE0IwCTaFGzCNU4A+vXWEcjprzX7IRLMcYc+?=
 =?us-ascii?Q?pmOKf+r0x2y77/zIUhVxm8TKH2avboNHAwYvaTdACdg+kAyJ2CD607utYtAV?=
 =?us-ascii?Q?GFIZaMIAURMdV3HFWfXipIFPnftf5cxSH8ZgGSY2q955y+6NuA6alAF2IyYf?=
 =?us-ascii?Q?xoVu3MCwnUpqmUYDen0xnRDaZG9nHKoTPmTM+QcmPb+4/6MoCqLvn5s54BRx?=
 =?us-ascii?Q?cTpWq1DhAbsRE1E82DlYDXBq8Lb+nBkEsf1CmhVU2d+yM+hnAijBolt83IdJ?=
 =?us-ascii?Q?jQSAuZHNhNqvmMCW05MGtQJS0NehGybgRtjGaigKnqDrHkS+LQP3UnGQBARg?=
 =?us-ascii?Q?Kqu7YRYaaZEIv82LlMSS3PfQyXFBwarEleOexsIX/77aKSpBamXD5c2OaGhy?=
 =?us-ascii?Q?V8rTQ51VLF0TtLB8tzY09do4s/CrD/jgXSCnHkQQ/y7PsZd8g53uER0hdE+p?=
 =?us-ascii?Q?gOHJLSbDNL8236x9k6u7uZn0hWeTM6SqyIzf1gCH9AgxN20DMcmzVLCULFaD?=
 =?us-ascii?Q?4JHIy8q+qC26OFmDIUNUTQP3HvW1FEcZk3TpKEVShI8+A1Bmhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:32.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654a476c-8ab7-41fa-d255-08dc89a21be1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

Add a work item for each queue that will be run on the queue's
preferred cpu and will schedule another napi.  This napi is
run in case the device missed a doorbell and didn't process
a packet.  This is a problem for the Elba asic that happens
very rarely.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 23 +++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 ++
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 30185ac324ff..a5a4dc21b9f3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -56,6 +56,13 @@ static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
 	}
 }
 
+void ionic_doorbell_napi_work(struct work_struct *work)
+{
+	struct ionic_qcq *qcq = container_of(work, struct ionic_qcq,
+					     doorbell_napi_work);
+	ionic_napi_schedule_do_softirq(&qcq->napi);
+}
+
 static int ionic_get_preferred_cpu(struct ionic *ionic,
 				   struct ionic_intr_info *intr)
 {
@@ -68,6 +75,18 @@ static int ionic_get_preferred_cpu(struct ionic *ionic,
 	return cpu;
 }
 
+static void ionic_queue_dbell_napi_work(struct ionic *ionic,
+					struct ionic_qcq *qcq)
+{
+	int cpu;
+
+	if (!(qcq->flags & IONIC_QCQ_F_INTR))
+		return;
+
+	cpu = ionic_get_preferred_cpu(ionic, &qcq->intr);
+	queue_work_on(cpu, ionic->wq, &qcq->doorbell_napi_work);
+}
+
 static void ionic_doorbell_check_dwork(struct work_struct *work)
 {
 	struct ionic *ionic = container_of(work, struct ionic,
@@ -85,8 +104,8 @@ static void ionic_doorbell_check_dwork(struct work_struct *work)
 		int i;
 
 		for (i = 0; i < lif->nxqs; i++) {
-			ionic_napi_schedule_do_softirq(&lif->txqcqs[i]->napi);
-			ionic_napi_schedule_do_softirq(&lif->rxqcqs[i]->napi);
+			ionic_queue_dbell_napi_work(ionic, lif->txqcqs[i]);
+			ionic_queue_dbell_napi_work(ionic, lif->rxqcqs[i]);
 		}
 
 		if (lif->hwstamp_txq &&
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index d87e6020cfb1..92f16b6c5662 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -386,6 +386,7 @@ bool ionic_q_is_posted(struct ionic_queue *q, unsigned int pos);
 
 int ionic_heartbeat_check(struct ionic *ionic);
 bool ionic_is_fw_running(struct ionic_dev *idev);
+void ionic_doorbell_napi_work(struct work_struct *work);
 void ionic_queue_doorbell_check(struct ionic *ionic, int delay);
 
 bool ionic_adminq_poke_doorbell(struct ionic_queue *q);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a04d09b8189f..be601183deff 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -346,6 +346,7 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		struct ionic_dev *idev = &lif->ionic->idev;
 
+		cancel_work_sync(&qcq->doorbell_napi_work);
 		cancel_work_sync(&qcq->dim.work);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
@@ -692,6 +693,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 
 	INIT_WORK(&new->dim.work, ionic_dim_work);
 	new->dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
+	INIT_WORK(&new->doorbell_napi_work, ionic_doorbell_napi_work);
 
 	*qcq = new;
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e4a5ae70793e..40b28d0b858f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -88,6 +88,7 @@ struct ionic_qcq {
 	struct ionic_cq cq;
 	struct napi_struct napi;
 	struct ionic_intr_info intr;
+	struct work_struct doorbell_napi_work;
 	struct dentry *dentry;
 };
 
-- 
2.17.1


