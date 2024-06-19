Return-Path: <netdev+bounces-104697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B590E0EF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9891F22EEF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5230A4A00;
	Wed, 19 Jun 2024 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nsX30z4w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39EF6FC1
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757236; cv=fail; b=LpGtdmR8sbalfIu8W4dXapByT4raljsqLqNmUrny+kRNSTWgYbaoEE475ps8cUVnC887qFPvozBBR9GK+T4b1QpUWrNc42EoUTDDTMu9rK+oGTd8DIFu7V6KQAUlJHtyF1choUYSyEnkgtm24dEAz6CepfCaZtm/bGxG/JS4WQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757236; c=relaxed/simple;
	bh=EK8NBMtehx796JNFT4BMFCWvkrCk4ApaYnZuFMWNU0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7g53eDs1g+EIYpG1km19Qs5+J5cMCXS+Zrja8dGcPcbhHeCZLD6Soxp0yfZRUmIOHNbTClQtEX14ihbs+hGH+17dioELFBG0E45oj1yqQk8ROl4GY6l0c5idwMQK0c13Stku5XGDCFt3xGl264LRCIKt4O6vF/L6iE5C1CsnrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nsX30z4w; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0TRdskX5lHwGmmH+A+SAw7lbcd0zKkA94xbssBflXqvKxNgfHoarYdNZOUZwS4RIMSEpK0SCZPl5g8+FWWHY5mqXtVi8tRfZIYKrrYnCXXypy6trwtDcAvEL5WDc7XFTdx7YT48U2YJDHwYx/2dK9TXQ0a/CTgXw6KCgtDbHAmCRM5u5OONdJt7KTj+7gsCu4/Z/egribQB5u8++TgXARHJpdelwiOrCkEccICSBeZjM0AYZXjcwUpEgafW54fdKnzhRLCxfA6gjxz/h4zx+Y/+wLi2ImRy1ZZmA0imxma7mq3R+Bb2PkUt0vB7ntkJ2LYx+7mHngfP1yKsPqfV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIVJDtq+alQMPYx31dQmMQcxz/NcYVN+rkfuHRJYuwk=;
 b=Gww9Ik5H9HVR1ktSPwh4HKaBb59l/z0hjD9aSIGqRBAfge5yNagmDJ4v74hDZyCMr8FbxP81KkR3hxMEPrSnVfYsM+xeBLYge2fXL20tJ93b3DMLPFDgZLekRNgc+Oxtz1/17bm+zzYbg2fgG+nb4Ye/zygDU7zgaDw6IWAJl/n3fq46rEkBmAecUImsghTAcZayuM9n5mHtHfdTTIkgG3FgDCtExl5pDj5xn58pcbIc158iMGMdRelMy+VX4Dc7LTr+B18/eqK7eH6deghxU+fjh7JqkAdqEASqY4iKWm2I5ht4qa+xoAz9clbnKwyQaoejQTdOGvH/opDttnU/QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIVJDtq+alQMPYx31dQmMQcxz/NcYVN+rkfuHRJYuwk=;
 b=nsX30z4wu/ojo2+9oebiODLEzrL+t1Rnfshpt/BEnbkKF3ko0Pl/UUb7m8F3k7VGj3UbKCwo+QyWdIjPF9bCjVkB4r5YchiCJdqvIbN+6nvWOLrmIA7fBzUCp7i9ViuKdnZg7t34xJ6/BgZxHJEGgnUzWpTKWcxMjEpOBCicYiw=
Received: from PH7P220CA0103.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::29)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Wed, 19 Jun
 2024 00:33:52 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::48) by PH7P220CA0103.outlook.office365.com
 (2603:10b6:510:32d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:47 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 5/8] ionic: add per-queue napi_schedule for doorbell check
Date: Tue, 18 Jun 2024 17:32:54 -0700
Message-ID: <20240619003257.6138-6-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5affa8d3-519f-462d-2eb5-08dc8ff77d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6r3Qglp0zIaWmI31nh5sKhuD+ahFn+m1fB7Uw3amGrfETPU84LaNGPN04O0/?=
 =?us-ascii?Q?L+KasgLwt1AeRwso8ZnwSWQS1UvwjqUxmKxmQb4FOaxVtUJbc+i4w7lCIxT8?=
 =?us-ascii?Q?oKVHbRkcOAkQ1MjoDz1R23akUnu3GvNU4UyYXCxYYFZOVIa2fJsPPI87yey7?=
 =?us-ascii?Q?HzLiIVLuMqhbyHwoAzXHsJ9jAk7VRN3Hptn7syr6h+Fln3FVkOZo/0QYI80Y?=
 =?us-ascii?Q?zjoUIkt1KJSGdR8pFKrJJcIC7U7jbqfXKktlX6f51yYDNbf1udWcLw8Apiz5?=
 =?us-ascii?Q?ow0JWFTcTpCElJUOTOTGCcnh7wUrRMciTvZpzEDuCdC5XE1Efu53F83KoK1K?=
 =?us-ascii?Q?V1SWhRhbgDhLsn47icaVIswr3ivbrfZh3cteA8tMDAVCWrpcLXUtHmEoqqSL?=
 =?us-ascii?Q?+crngE/TgediBLcuNZxfAbuyvWeego/kJcSmOGLKTKIizBiVNU4gBVzu4tdg?=
 =?us-ascii?Q?1vmxpRUyly0IJkZEhV7dvpeLOYI9iLbTV33TTaCDdApV+sJABpdLNEkIDyAX?=
 =?us-ascii?Q?8X0/3Z52s8F6BrUniHM1EKrMwuN+BUGL3nLAdrSu9cCE2cHWHuhAmdYt0tI6?=
 =?us-ascii?Q?p/nXumgFpkC2f0dKcBeal50NT76YzMFe87HnagnzSTPQynsDFcwPa2MLolFK?=
 =?us-ascii?Q?RU8TduLgVGmf2lGRZMknNyJy4k1WAdy3DWcilnxud0W2MiPr0ob9oIwQMrWk?=
 =?us-ascii?Q?MJXf2JZWPLCTtc/aN9e06di0cLiciH1MdC7h4MfbxUPclU4+oocmWA8nEspM?=
 =?us-ascii?Q?907kFQyIIi1FlXalYOti5xxaIJjNJS1YLahW9svNzvU5ifjHGiIXwEAPux2c?=
 =?us-ascii?Q?e/4QqX/Xcx8WJb3ipwIrIA3S24UdRXAwbsPShQOhrTfQTS50LPZOXHwwu10Q?=
 =?us-ascii?Q?HlsrEoZuwNVa75dZ92NSCJXpioMDbWusQLRtx77q2VS+zhA0bk5ExoD2i1j3?=
 =?us-ascii?Q?NvMJurR0kLzmDY9rzEvB3XVafwOwIZ5BmghpFBEYTWaUGdVwZabr3y3tT78H?=
 =?us-ascii?Q?rhSNG9iJsAwmOL0YbRzIw+cx73pUD0kLu9My2AHuxKU+F1cCvR9bGHu0hWVI?=
 =?us-ascii?Q?dZfxprKONko8Jh5jExUzJBFX5BgUAls7+RybOh7ew7ItmtXEqKwGcNtu4xAF?=
 =?us-ascii?Q?QaaPsTevmHxC4aHrp2ww3VQmY6Bx+OFz3rXBHX6WAZ3TsO8uAql29ExAmD6X?=
 =?us-ascii?Q?3Ouihym/9xtVhlrbjAyrq7fsV7/TqX5TpgJrDHZe7mmBAN6235DUwQ33R5/3?=
 =?us-ascii?Q?iSf8LjPUV7m0dL+Jh8kvaytXedZdAjRETkTd4INKbEeW/G/3BvKn1lec60Tn?=
 =?us-ascii?Q?4eXu934XwNKv9z/gzcY5CgidczvLsyEMTs4gGYiiNqJjQoykptFjHEKG03ia?=
 =?us-ascii?Q?zpLTefc1FFIwIRsjTiyKoVwjatdDvMaNWuclLs9I3EnDKtOxSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:50.1798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affa8d3-519f-462d-2eb5-08dc8ff77d62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

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
index 5d5990e7376e..56e7c120d492 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -54,6 +54,13 @@ static void ionic_napi_schedule_do_softirq(struct napi_struct *napi)
 	local_bh_enable();
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
@@ -66,6 +73,18 @@ static int ionic_get_preferred_cpu(struct ionic *ionic,
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
@@ -86,8 +105,8 @@ static void ionic_doorbell_check_dwork(struct work_struct *work)
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
index 42a587d14d01..d7abfbe05f2b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -344,6 +344,7 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		struct ionic_dev *idev = &lif->ionic->idev;
 
+		cancel_work_sync(&qcq->doorbell_napi_work);
 		cancel_work_sync(&qcq->dim.work);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
@@ -690,6 +691,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 
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


