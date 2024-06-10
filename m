Return-Path: <netdev+bounces-102384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1DB902C2F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 01:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A79E1C21A54
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 23:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46F1514DA;
	Mon, 10 Jun 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uyy7C1Hk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A1481C2
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060854; cv=fail; b=c8jO3jV1DvvXIGTSW/DAFZbtddTfZh6/EQzyM6pPvfpNa3obQ5wn/aCZZ2hj7iF+l6/oNB2HEp/klqrYQWmGhR4aEdHHye6cgjvUIJeJmtVWUKIOQbE/jEdqaDp7jenNj6NvKUUyRU3TAnzMROrP8WqdBA1rOvi243xL+1+uGVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060854; c=relaxed/simple;
	bh=dKxapnrhdowmoxQ8IMw7OSglZc0+2X717VriuOsZweo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7pDdUbbxk/VMuxzTF9snIT6xBnPPz56O1CrqnGRbsccHCYwXaATjZ4gLvpjxG27OFxcdRdZXOWZj0FCI6E4C5H5mOyQpFI9OheSc1sNE4yQSIHacSHmE5wG5uhO16/3I7Ub2UefDwkFYGbU1GhZVREISZwKcdG+/eemNv0aX44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uyy7C1Hk; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt8PPM6Ky0BUv34B1NOLza9I06iGsiEZCE82P+TcVy5UfhV8Q2NQka+ERLLxoqFORLxfNzTxlHUpxX9mBYuqPPPdhTaXv6LqtWjj9i4AEu9mIL85KknU/Qk3YhF/1Tg7QFcmnXx6iYM+zTx8sxWU//VUFEGVClYHehARTUAQ74WsUCd+PMREWg8fz5FuXt+KQFTey+uLeOpqI6EePpU7gqe9iwiRliwcjFvjYT2kwmxTZkpMy0WXtzjQv05EgfZsS+rxfMpvX6AfITdiESN9clXjc19Hrz0Th/s4DD26DiyBzju79xSfhHmlx2wl8sBsIbBgDEPy+r+dZrzlLqW5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKn9K+x9Z5vBF+EYyrlxoR/ajVU9EgIpu9/tZ8owzWY=;
 b=UPxebPuZH0AM5Udz16h7yjqH8MyKnDpYE98pLCh+PAHcM9twVj4raG9Su+vUlAVVJthrcmVLg+qsM2OlmgsVDKcyrUMkwsBBFAWYk4zB6FvpbmxE6IbnAQkCQgQgwA0o+keNnAHl/uOD5SAiDXXX5XTtbyGHIJgznET1/RCOZGuWkYC3hB6GCLg5XR62F5ZApJtP3aIYPxp6b2iDoykfD1uqhFocuI4EAt3ZZKahheCPIB4uozAlxKjq3bWICBgWtEjmOvITXyTYV46h7vG/v/awu8S94CgbWCmUPyeIPHQN1nCePZRMCf9WRrTPKK4ARJi12hcL5dryap5kLYV9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKn9K+x9Z5vBF+EYyrlxoR/ajVU9EgIpu9/tZ8owzWY=;
 b=uyy7C1HkHYxRtQJnzscjDTzzd75AyKjhROsF05WTFLZ0FNrirPO4LMIX/muAEzct9Qs1DvFfXXPgzdTs3SSGnvwQoqzQHGNfQ4ivmqWD3fYNwbyU3TaG6cYfq/LqS52w34XHdkUR1TIYG81b/XbGiiQy+xd7ytAzfCD0b8ZxBzA=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 23:07:30 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::c4) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Mon, 10 Jun 2024 23:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 10 Jun 2024 23:07:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Jun
 2024 18:07:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/8] ionic: remove missed doorbell per-queue timer
Date: Mon, 10 Jun 2024 16:06:59 -0700
Message-ID: <20240610230706.34883-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 313d1165-76bd-4bad-f6ee-08dc89a21a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVrdZ2bqz95ArmHMbYvd7MPI8YotMIJUYDHnJOR5lk2pJfo8ntDz4K2Crcqy?=
 =?us-ascii?Q?hv6MtBmPdQuuDIxVw7PGsKmfgoC0nXGnvU5JzKfjhwRxlrL4cUBqQniHQmqa?=
 =?us-ascii?Q?AdxQWZJYExD+Fiy/97wSn+DgEHZJPvE+NQ2R048xiZDOYeamwnoQQC47dZyf?=
 =?us-ascii?Q?aei76KQpaylEBaTKbGV6riSJwiyBAKjTI9X7Jbl0Czap4GxM6fatEWe4Ef9M?=
 =?us-ascii?Q?ufOjwqS6I5wso4tZ0obmb3GPls6c3no/L2QoHmarTMD0njOrWKjnb3eTpDnF?=
 =?us-ascii?Q?Tsn7NtcIL+tnj2UOhh+JDWowsaZP3dLqer5QdzG4s2mrANcUn013ZMzfv2GB?=
 =?us-ascii?Q?ieMSuAh6fJFZT8f8HYuVPP84yIc06ffJolXIR7FwE3LRiFCi1/BT10hKmolg?=
 =?us-ascii?Q?k9EuoiQmj2BxxonSE8NskZ6vgaPcT8ngmgI64yuorMsbeHjlYBsbcb9NDMHz?=
 =?us-ascii?Q?HNY9PM7EWD42rAPseFNcd171xOCAwU8GPMNS9PleTTmp1XGMbswpzQKmjsuw?=
 =?us-ascii?Q?7T0lYdlp/BKAm3X2ePbuWHpPw6bRdQF+4w4kVYJ51mh9mT3Bk/EgXKgNLV18?=
 =?us-ascii?Q?l8tUG+pseePc3SzyEs7OtMN2Gqm7xVPR6Z0Rh7vguvfpkWeQnHde00D5gVcH?=
 =?us-ascii?Q?ZfceXmJtx2jGMNGO2ieklB38NkBohxP+1OjwXNVKsr94nEwHpyVBIqRxqvNx?=
 =?us-ascii?Q?MWj4OkGqQOQXUxMccSPeNEaXNaFoeHhIl+RvNKPhcMEnQhV8U1TSEaZxDEgo?=
 =?us-ascii?Q?P01+5Zkf2pmoUqsBMGsGYBlMGrF067KhUSyQHHOWiqEd2I6lcE1kU16TTLRK?=
 =?us-ascii?Q?jkCrR68/WthRLM6EVZY4ZGzx6OLC/uExP+3nM7TBIeq1YU0f/l5HV68ag8wW?=
 =?us-ascii?Q?rZNMuhZM9CR0fWLLaN7l0NoxmI76f1S0H4Wr3hGnghr0pJTbRtVHM45y9A01?=
 =?us-ascii?Q?XO5yFSErK7YcoS+1iarzkZY2s35aQV+H1ch6azF2TNorYQ+1BfRKOddh/WgD?=
 =?us-ascii?Q?X56RuuC2vzII18nYfkxsY/bxfrsnRiUyTz61huYjymDeB9Hr2j0c8Vt9bAPk?=
 =?us-ascii?Q?mOh30AJVNTx03Kzl8HJCb9BTSKEo0ZPk6zm6b2MP0cOSBb3TeTKZRtUntWbG?=
 =?us-ascii?Q?t6LLSnm3gP9B043oazApzgLs0c+o9CZJ5I+oEdwk7e4BMNMJh9lv6ad19cwK?=
 =?us-ascii?Q?SihKbbxUvL6pewgmTOt6c7c9DM4jRR+eo3pcXhbsbkx55yaiU9KdJK7ClYg4?=
 =?us-ascii?Q?V2oZhMfYODGQj1j01BWHey1wf78iW0HEQjuRukqYCLp6Q0r2nPBNlQ7M3HFS?=
 =?us-ascii?Q?HxVOUVqVHZmznR0bWQdSAyF2AGKy8hgsn5QryJe8NkeEUgL/NGVUpIZU6vgn?=
 =?us-ascii?Q?zzilnYfP2tviaOP5BGhvWl7WkDofT1juhyMhV9iyPqYJGwIS3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 23:07:29.6977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313d1165-76bd-4bad-f6ee-08dc89a21a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224

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
index 23e1f6638b38..48b2b150fbcc 100644
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
@@ -345,7 +338,6 @@ static int ionic_qcq_disable(struct ionic_lif *lif, struct ionic_qcq *qcq, int f
 		synchronize_irq(qcq->intr.vector);
 		irq_set_affinity_hint(qcq->intr.vector, NULL);
 		napi_disable(&qcq->napi);
-		del_timer_sync(&qcq->napi_deadline);
 	}
 
 	/* If there was a previous fw communcation error, don't bother with
@@ -480,7 +472,6 @@ static void ionic_link_qcq_interrupts(struct ionic_qcq *src_qcq,
 {
 	n_qcq->intr.vector = src_qcq->intr.vector;
 	n_qcq->intr.index = src_qcq->intr.index;
-	n_qcq->napi_qcq = src_qcq->napi_qcq;
 }
 
 static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qcq)
@@ -834,11 +825,8 @@ static int ionic_lif_txq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	q->dbell_deadline = IONIC_TX_DOORBELL_DEADLINE;
 	q->dbell_jiffies = jiffies;
 
-	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state)) {
+	if (test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state))
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_tx_napi);
-		qcq->napi_qcq = qcq;
-		timer_setup(&qcq->napi_deadline, ionic_napi_deadline, 0);
-	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
@@ -911,9 +899,6 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	else
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_txrx_napi);
 
-	qcq->napi_qcq = qcq;
-	timer_setup(&qcq->napi_deadline, ionic_napi_deadline, 0);
-
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
 	return 0;
@@ -1168,7 +1153,6 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 	struct ionic_dev *idev = &lif->ionic->idev;
 	unsigned long irqflags;
 	unsigned int flags = 0;
-	bool resched = false;
 	int rx_work = 0;
 	int tx_work = 0;
 	int n_work = 0;
@@ -1205,15 +1189,12 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
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
@@ -3504,9 +3485,6 @@ static int ionic_lif_adminq_init(struct ionic_lif *lif)
 
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
index c3a6c4af52f1..3066eb4788f9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -867,9 +867,6 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 	q->dbell_deadline = IONIC_RX_MIN_DOORBELL_DEADLINE;
 	q->dbell_jiffies = jiffies;
-
-	mod_timer(&q_to_qcq(q)->napi_qcq->napi_deadline,
-		  jiffies + IONIC_NAPI_DEADLINE);
 }
 
 void ionic_rx_empty(struct ionic_queue *q)
@@ -952,8 +949,8 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done && ionic_txq_poke_doorbell(&qcq->q))
-		mod_timer(&qcq->napi_deadline, jiffies + IONIC_NAPI_DEADLINE);
+	if (!work_done)
+		ionic_txq_poke_doorbell(&qcq->q);
 
 	return work_done;
 }
@@ -995,8 +992,8 @@ int ionic_rx_napi(struct napi_struct *napi, int budget)
 				   work_done, flags);
 	}
 
-	if (!work_done && ionic_rxq_poke_doorbell(&qcq->q))
-		mod_timer(&qcq->napi_deadline, jiffies + IONIC_NAPI_DEADLINE);
+	if (!work_done)
+		ionic_rxq_poke_doorbell(&qcq->q);
 
 	return work_done;
 }
@@ -1009,7 +1006,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	struct ionic_qcq *txqcq;
 	struct ionic_lif *lif;
 	struct ionic_cq *txcq;
-	bool resched = false;
 	u32 rx_work_done = 0;
 	u32 tx_work_done = 0;
 	u32 flags = 0;
@@ -1041,12 +1037,10 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
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


