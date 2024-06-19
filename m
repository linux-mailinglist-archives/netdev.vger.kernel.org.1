Return-Path: <netdev+bounces-104692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBD90E0E9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60336284938
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E595D46BF;
	Wed, 19 Jun 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="StPyvsw2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57461860
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757211; cv=fail; b=MH7cSR776iIiR51sK741I+cGzp537IkquGWsEBkbUZdfde3wYrN3u6pcEW3tFzDBA3LxxddGe9bsykwG9pZG0SNBwIRlnOZcSu7OVjkAW2m8GZeGMtgdOWmP01LSCxEVw+GN9pj0/xQoABSSvypPcuCjQd7ZsM+Uq2rYYurQGOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757211; c=relaxed/simple;
	bh=4BD7HPXY/Q4Zw7xlGKdSko+VhSqXpKGPNppCpvfJEmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7PtaDgHpIpO4V//jHnWc5cktnYGeYlUaS+GOD/X7UGXMiaaWn2x9RrY8/OvZZqtMacF3CoKD9B0TSk6mnM9ChmuDu7adUyDsnA70wS6fOeN0sxz4Z8EL3y6pUqdARC0pUzdy1c1nLn/JYK7bEjL7XIwBaiYP1zA2s6AFLdZ9Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=StPyvsw2; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL47MdTkqDFPz9VLqsfU05d1xV5or0wq3iRr3YKvcCzE8NhO1Bh7SC5GV8pAwpqsTLtFIb2urHJYIBUrqaYj1U3B9vFI9cCGEjMBJByR+K85M4aN1WiJASSznud7fzDQwKhWMqTmbn0li5sIqv5sTxC8rxMJxSlfptpjGKr+Cefv041c7Vk2sv+VRJe04d6fqf01856XcJ2rNzZVa3DO7VoDcBoQis2z/++hjB2pGDhXXoL6/JTpuNbZT6OSDxQ1bOzYIMe7k2kdAiuaTmgw0b87haYKDBFNISwfR6S6m6RyEC0xufY9/nxx3mXX7FoypPd+OO+wefZIofQkJszSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlEFf93vN+OqzWNVVbuG7hlVTzvHT5FmhhCV8THDU44=;
 b=FoATi3iptl4E747i7CPHhbgO9GcvH33RVjoTZaZ+qAo+r7+qRdvs8Pwqprp989bArojmZhaRGV3WQ+wXCh2f2dwYWol9PhaMnDHp5VUmqMjHR3Xc501hx62SMfr100C7OsW7LSECs/viQeP3sDbuCSL0qHm4YJ2/GXPFoOpyHvEeogoz4S3lDhnTg0zoD4TOvGiFs7nFUOMIdyKSOYB/dBl9t32L2zHDKrrbq2jzbE0oiK90auqo9fQxqL1AEfKwrHuCDTQmjiHOwvO3ItKL0Yf0AgBws5mDPOQ38Uq4Lf6DyGhiv0cr43RG0lFMlgNT9B4RLBiPhZ2MrUlg2TU3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlEFf93vN+OqzWNVVbuG7hlVTzvHT5FmhhCV8THDU44=;
 b=StPyvsw2A3qwu4XPoA6p8H2Y6tgh39+1El1T++6YT4FgBp5BoQ5TbjXAlBGNciTiG2HO+xRStxEvFadjtH685cY9KE/MANUC32cXt9y9JJ5/hC6X4uguCc2GfarDR0ohGgPqD3ODAoiixo0SKW3I1s4GOu4weWLZJWgOEOEfegs=
Received: from DM6PR11CA0048.namprd11.prod.outlook.com (2603:10b6:5:14c::25)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Wed, 19 Jun 2024 00:33:25 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::f2) by DM6PR11CA0048.outlook.office365.com
 (2603:10b6:5:14c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Wed, 19 Jun 2024 00:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 00:33:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 19:33:24 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <David.Laight@ACULAB.COM>,
	<andrew@lunn.ch>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 1/8] ionic: remove missed doorbell per-queue timer
Date: Tue, 18 Jun 2024 17:32:50 -0700
Message-ID: <20240619003257.6138-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c01858-1846-47db-4620-08dc8ff76ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhA26jfBijHrqon0NOZubQWSPbgUz2g462hIw6aDLQuhmpR6O4+bXVAY1CVO?=
 =?us-ascii?Q?2tNbjd4ez+ftsvMQ/+2dvaX77f1XsnCoLcEZMHUyXeMV2MxrHlhWlI1xYFnp?=
 =?us-ascii?Q?uaEZym5eOXJd0BdqFPYfgaLOV3ZoyPRehb+xFuyaFEaHprsplu61wrWvVdXT?=
 =?us-ascii?Q?/2BFKAZtbqTEnrCgMAM8Zc/LrL5dMZoI6uh0sIHC5HRCg3ITChLmGzZPByin?=
 =?us-ascii?Q?9XuYnYD1EOnkctioF0kBweH8Gc7Iw/Wf9YW5Sf+HpUMupjf0YcnHN6jzrHpT?=
 =?us-ascii?Q?JfVyDsEAQef6BcgUFi59yH/NpmgbXswxUL6BGgEkDiERMuwuvY4Ew5fMg/Yp?=
 =?us-ascii?Q?LDaGE5PF99AXmq+KAPykYYI3K+nbUfdtJgGfiqrZ/ibjTOJ3nmTSTOlTCFtX?=
 =?us-ascii?Q?VRPDbftBmXB7Cipmet9krP2NRpeF34Mj9qph975GsSc+/xOpOvnLaUO0owRD?=
 =?us-ascii?Q?nky/7PK4+i5lwZKVZQd93eLJyn5UpdAghiloixbVovUBbdoH0G6w+5VYpTUt?=
 =?us-ascii?Q?eMbEMOw6+NfSVQdwY7MCPbM7jsInsDeIPNS0FdjOm008woSFrULiJem49Y8u?=
 =?us-ascii?Q?9PKnRm0BpnKX+9A69gxFWchC73qcce/D8BYEWfgX77oyC1Gx4eySFjHECK5L?=
 =?us-ascii?Q?0yudbKjWB1OR4LjU2MK8B2of1gwuZiOUY1CJgJhAgmMhjVqOtxKmSKHhg7FD?=
 =?us-ascii?Q?dr8yMl5f7xDeA8SRU0wx+1I0FhpYA/zhSF63wD/ZYlRZXi3+oprxKuAX8Kez?=
 =?us-ascii?Q?8yx/QIXv8pWKgQemlu4S1t8OOkx8Rap2HJ0C2QFaeW57H9yTeS0uTGik0l6Z?=
 =?us-ascii?Q?a+jhWZgZtl8oQznRXhxlz0SAznRwu2XS1uOKFLqr+4YZ3CzexyGD6lemTkkB?=
 =?us-ascii?Q?EjVhCcA7VayJPalc0q/EHu95qNzTj6RYm2VcMBrjxXUhiE7JSFqkdHxiVaT7?=
 =?us-ascii?Q?dzQRtz2XMKSz2ml0NyqNVYLGHDIOH9Kn0xauyx5gW8Fhvr4OK5kD0yruUTde?=
 =?us-ascii?Q?RAXSdi5wkM5NNIihX0CJ5fYkRUXRi3kq6ZxVU4VgNRcM8upaVaDELdbxtXg4?=
 =?us-ascii?Q?s7/k6IU0PkeWFmytc8wARTBBmfiBPr/UU4e2dMWzBmz+KI56CLVJIEsMnpHE?=
 =?us-ascii?Q?yRaHZC8uKYx1mDY/L2DdfKBKP3szc3w7eCk8U1n6t0kVwXmrWk6DALqLVrQ3?=
 =?us-ascii?Q?+pgxrJGEBshQHOx3PnfxsBJuB00r+7YNu7Z25ID6qTN5hWtDd3IH2V3mK2h5?=
 =?us-ascii?Q?T25hMxy5uiMwspcMe0jEpSBGVOaC785s/qKTrQWzFbbxg6vsfboKGl7+/bGS?=
 =?us-ascii?Q?MH2i64xaV4y26h/DXo2SHsbs4AYqk9LoN1j5Zr0XhGq3uBnu/tqoHdj3dUvV?=
 =?us-ascii?Q?EEJ5rpkOXpUxl4JF5Glvp0r1LzPKD1YIhza3jFCKf1uwQixmvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 00:33:25.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c01858-1846-47db-4620-08dc8ff76ec7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

Remove the timer-per-queue mechanics from the missed doorbell
check in preparation for the new missed doorbell fix.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   |  4 ---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 36 ++++---------------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  2 --
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 22 +++++-------
 4 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 874499337132..89b4310f244c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -703,10 +703,6 @@ void ionic_q_post(struct ionic_queue *q, bool ring_doorbell)
 				 q->dbval | q->head_idx);
 
 		q->dbell_jiffies = jiffies;
-
-		if (q_to_qcq(q)->napi_qcq)
-			mod_timer(&q_to_qcq(q)->napi_qcq->napi_deadline,
-				  jiffies + IONIC_NAPI_DEADLINE);
 	}
 }
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index b8fdfb355386..1f02b32755fc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -213,13 +213,6 @@ void ionic_link_status_check_request(struct ionic_lif *lif, bool can_sleep)
 	}
 }
 
-static void ionic_napi_deadline(struct timer_list *timer)
-{
-	struct ionic_qcq *qcq = container_of(timer, struct ionic_qcq, napi_deadline);
-
-	napi_schedule(&qcq->napi);
-}
-
 static irqreturn_t ionic_isr(int irq, void *data)
 {
 	struct napi_struct *napi = data;
@@ -343,7 +336,6 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 		synchronize_irq(qcq->intr.vector);
 		irq_set_affinity_hint(qcq->intr.vector, NULL);
 		napi_disable(&qcq->napi);
-		del_timer_sync(&qcq->napi_deadline);
 	}
 
 	/* If there was a previous fw communcation error, don't bother with
@@ -478,7 +470,6 @@ static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 {
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
-	n_qcq->napi_qcq = src_qcq->napi_qcq;
 }
 
 static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qcq)
@@ -832,11 +823,8 @@ static int ionic_lif_txq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	q->dbell_deadline = IONIC_TX_DOORBELL_DEADLINE;
 	q->dbell_jiffies = jiffies;
 
-	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state)) {
+	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state))
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_tx_napi);
-		qcq->napi_qcq = qcq;
-		timer_setup(&qcq->napi_deadline, ionic_napi_deadline, 0);
-	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
@@ -909,9 +897,6 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	else
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_txrx_napi);
 
-	qcq->napi_qcq = qcq;
-	timer_setup(&qcq->napi_deadline, ionic_napi_deadline, 0);
-
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
 	return 0;
@@ -1166,7 +1151,6 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 	struct ionic_dev *idev = &lif->ionic->idev;
 	unsigned long irqflags;
 	unsigned int flags = 0;
-	bool resched = false;
 	int rx_work = 0;
 	int tx_work = 0;
 	int n_work = 0;
@@ -1203,15 +1187,12 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 		ionic_intr_credits(idev->intr_ctrl, intr->index, credits, flags);
 	}
 
-	if (!a_work && ionic_adminq_poke_doorbell(&lif->adminqcq->q))
-		resched = true;
-	if (lif->hwstamp_rxq && !rx_work && ionic_rxq_poke_doorbell(&lif->hwstamp_rxq->q))
-		resched = true;
-	if (lif->hwstamp_txq && !tx_work && ionic_txq_poke_doorbell(&lif->hwstamp_txq->q))
-		resched = true;
-	if (resched)
-		mod_timer(&lif->adminqcq->napi_deadline,
-			  jiffies + IONIC_NAPI_DEADLINE);
+	if (!a_work)
+		ionic_adminq_poke_doorbell(&lif->adminqcq->q);
+	if (lif->hwstamp_rxq && !rx_work)
+		ionic_rxq_poke_doorbell(&lif->hwstamp_rxq->q);
+	if (lif->hwstamp_txq && !tx_work)
+		ionic_txq_poke_doorbell(&lif->hwstamp_txq->q);
 
 	return work_done;
 }
@@ -3502,9 +3483,6 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
 	netif_napi_add(lif->netdev, &qcq->napi, ionic_adminq_napi);
 
-	qcq->napi_qcq = qcq;
-	timer_setup(&qcq->napi_deadline, ionic_napi_deadline, 0);
-
 	napi_enable(&qcq->napi);
 
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 08f4266fe2aa..a029206c0bc8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -84,11 +84,9 @@ struct ionic_qcq {
 	u32 cmb_pgid;
 	u32 cmb_order;
 	struct dim dim;
-	struct timer_list napi_deadline;
 	struct ionic_queue q;
 	struct ionic_cq cq;
 	struct napi_struct napi;
-	struct ionic_qcq *napi_qcq;
 	struct ionic_intr_info intr;
 	struct dentry *dentry;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 9e6dee2fc1d4..a4e923376484 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -868,9 +868,6 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 	q->dbell_deadline = IONIC_RX_MIN_DOORBELL_DEADLINE;
 	q->dbell_jiffies = jiffies;
-
-	mod_timer(&q_to_qcq(q)->napi_qcq->napi_deadline,
-		  jiffies + IONIC_NAPI_DEADLINE);
 }
 
 void ionic_rx_empty(struct ionic_queue *q)
@@ -953,8 +950,8 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done && ionic_txq_poke_doorbell(&qcq->q))
-		mod_timer(&qcq->napi_deadline, jiffies + IONIC_NAPI_DEADLINE);
+	if (!work_done)
+		ionic_txq_poke_doorbell(&qcq->q);
 
 	return work_done;
 }
@@ -996,8 +993,8 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done && ionic_rxq_poke_doorbell(&qcq->q))
-		mod_timer(&qcq->napi_deadline, jiffies + IONIC_NAPI_DEADLINE);
+	if (!work_done)
+		ionic_rxq_poke_doorbell(&qcq->q);
 
 	return work_done;
 }
@@ -1010,7 +1007,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	struct ionic_qcq *txqcq;
 	struct ionic_lif *lif;
 	struct ionic_cq *txcq;
-	bool resched = false;
 	u32 rx_work_done = 0;
 	u32 tx_work_done = 0;
 	u32 flags = 0;
@@ -1042,12 +1038,10 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 				   tx_work_done + rx_work_done, flags);
 	}
 
-	if (!rx_work_done && ionic_rxq_poke_doorbell(&rxqcq->q))
-		resched = true;
-	if (!tx_work_done && ionic_txq_poke_doorbell(&txqcq->q))
-		resched = true;
-	if (resched)
-		mod_timer(&rxqcq->napi_deadline, jiffies + IONIC_NAPI_DEADLINE);
+	if (!rx_work_done)
+		ionic_rxq_poke_doorbell(&rxqcq->q);
+	if (!tx_work_done)
+		ionic_txq_poke_doorbell(&txqcq->q);
 
 	return rx_work_done;
 }
-- 
2.17.1


