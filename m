Return-Path: <netdev+bounces-122015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8F95F920
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC92283BE1
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0EB1991AB;
	Mon, 26 Aug 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5WtukHDf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86E19922A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697891; cv=fail; b=O8lKWbeihQRM6TQrnrnBkIjP0Ejp0V96BKqHwH8JicPen8TQPtuFoRA5U56VHy+tV4KgSzdqv22VzSLqXUbTcydHynrjNYoc2WGA9UKHlf5OspbXb93pjWKyUlMpIwT3MqHJ09kU7tCmduxxI4UVwoojiyUYqrEw667QzyiV8Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697891; c=relaxed/simple;
	bh=9hA9KcqzdmwI5xFE4AOH/IRzOLFeWPsN0vJTGgFTjqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMozL6mBfPYTqnpJWW1LrGC/lQ++e6XEVHUoIUUtDfuLhpBfZNDhqm53AAC3Zq7jR1SRseLGNloBUCIQ3RLr4/KvSx+6svNuirdE0j24KJQ9KX2S7jRt7QrDQRE/H4zbNslFEwzF9V65AdTyRRbXxYVml9y8TYLfjWy8PEflCZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5WtukHDf; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkYccUZ38dqh2JbB1JPKqxDaCCufov+BptAfhb7YXwHlYkjQCqB6kMC9WpVMXOk1P0pnHAmfLUivf6r3Y7vjmbnLWvppHDDTgCtiaXrMDJNSE+PZFmpowk+isHs1X1KJYMWqMbfw1c4n9Gzge5bv235WxIxh2vBm3QFNTRI2Eu2s8LrDcVBVixRt6Aq5LEW1fLgA4zZrGsBgYMl6FSV+uAOgCFuYqxJ8qzsE9f/YiV6f1sInE922hSZUEXOFWMk7j4wSu6BCnB4A/8d3uaGQaZe0SbZWkQpTfeKFRF6eDdrQDZHJP0V5XUGSKlzgCwwtuTVOVeHkFz/iX50bUVWHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o5+/AGVrPwtizQKfOBkpBqxd/BF5xRs8hocNMceR+k=;
 b=LAt0LJQLbBi4xLlmf1taS026SSnoo2awbu34KQ5n2F7iukhNkBWD/vN+1Yfn88xgTzWvhSWKq7+bXXDh92RTUyer3qDEkyVxYoyWFMh+ifW5qg/AOQEPuB/xlAsLuRcwFw3atYkNHZRM+XE9DjKa5qxrW7d+2f6RHtGHPLNWhI9X08TTYTwea1rmeMr35bJJtNCxAQTrVKh82WlaOU0t0DmSAuEijaGeQynG534Z00Fpy8bUvyeob1ZPkGCDM49OlLjcJxgH3BCB7nz4Ed51zJ4F9K5N9S1iHNne7ypHGgEsvTJVDJbmu50Ik3Y11UEAqGKSL+u4X31RJIY3agktOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o5+/AGVrPwtizQKfOBkpBqxd/BF5xRs8hocNMceR+k=;
 b=5WtukHDfyKgyts7GvGAH9QkeoeP5OzWetq7ylhNZKz+5ezXEIf87ozrOYQRAcVA9KvCnXMDQPc0L23wJ23JQkqwHs62Fpa1xBc3gBNEKBlV+E6GyR+FUFWpCTbenzTs+02Y62a84pFnP4Bclro1fY9mtAfJ2I1ZuejiEfklp4NA=
Received: from CH0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:610:74::29)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:44:44 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::2f) by CH0PR04CA0084.outlook.office365.com
 (2603:10b6:610:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:40 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 4/5] ionic: always use rxq_info
Date: Mon, 26 Aug 2024 11:44:21 -0700
Message-ID: <20240826184422.21895-5-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240826184422.21895-1-brett.creeley@amd.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7403bb7c-c59f-4691-b9d1-08dcc5ff2750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TlYgrUu6ee+UbBlf0uHKeeFZFap16+g58DQ+Ik7fevwEWaibuKPQA3sIYQxz?=
 =?us-ascii?Q?YSOjASPUoNQ7dQn380c2/s/y8tIScZf9HSTfJuZgBP24dqIPDob2kUcXmhz0?=
 =?us-ascii?Q?KWA7gMA94XNSp4uYhBpbHUOqEHNKXMg02G9ABeWIJrwLrtvU1AaQISs9amCf?=
 =?us-ascii?Q?N5t4ASvffHqFFRZEL5aWQtlezhqVF421xEoiR55hswdk5hb+0h+/0+AQmGAY?=
 =?us-ascii?Q?7epxfuAcZSCI2yiJFuLpMtQKxoP3RUx5j0K2fJp8KPsWeEiw0r8Wx8rZ2NE5?=
 =?us-ascii?Q?nh/4WdDRCOFerY0kvL8+brRG8Njs9yIKAaGxF42bHeyar7HZe0Y0pG4LHbJW?=
 =?us-ascii?Q?rgg3f87XjPigwytXl4YurEEpRd/ewZU2YJnAeQJvXd7T4F5AHPHB57BPLSdU?=
 =?us-ascii?Q?dArw+PGJvNCHy9jO3OX0gTaCBDMsaklxEIYb00AHnIMrCW8AdmxmvazDvPcB?=
 =?us-ascii?Q?AkbYyood+5cyFV3QF99SIITnEZ5nTJ3UzJyrZp1ijGV+/i6tePMuKseSuO43?=
 =?us-ascii?Q?IdhIztpNfAPTXANObOx8Sem7FhgkDsOLYLamhuQdyv7aTwg+4RsugDWbGvhb?=
 =?us-ascii?Q?39M8nQApCFbn31+pUoUl9tnACna1kslCwiYJ3EEWowmblShraRLtaI+WFlit?=
 =?us-ascii?Q?n2mMnntFOhaodMWddSCDX21arvhT5JXB0us/iefSADO1l5oxPVciQEbrudUr?=
 =?us-ascii?Q?o7qTWTe3FP89k9jYI1yamJadu4Sji7x1P8oZ71KMJ8WeDZnXMiew+cGDfZ4N?=
 =?us-ascii?Q?gDYM8lkCG0BfT68QJfkyEo8OLDhQOvyJKwg2oP8t3sxH97IV/hWeTgTdtOsn?=
 =?us-ascii?Q?xkl9M/f9eD4rHKqgnvMnMCr4w/fDe5GYwcJ6Uh0WYGD2QEPvk7+Jy6JLd0cH?=
 =?us-ascii?Q?C2IXGE8s2jStB6hDmKbyJXjY3cpCOVBE6OxPOWynlWjbwNt0o/1ABE+i6B6s?=
 =?us-ascii?Q?afNZvwei6hAL2PfrCiwY8yBPyCUAE1d9LJz1UfyKMw92r2g7W31eSouBHfkX?=
 =?us-ascii?Q?O0a9h8637P9qPwmKoYLxhjWu9rdv2fMFt0FGgKVPUlljassXIRRH+TJ2haRC?=
 =?us-ascii?Q?0zFQ0BEx+p45bKb2olkHYc8+JsJer6myIt/uYTZIG+G/wYGJYvKe+eTQ9R86?=
 =?us-ascii?Q?4LtSqfl8ZQSyoMAXXuYgKTutdqoR+MoD3qgmBfrNJACPziLE5zpjlv1l8Rqh?=
 =?us-ascii?Q?CUQMDbDVUiMyNxxxf4QauFr9Bwr1QQ7s9Y0DEbbubC81HGR67pAGZ0k7RGsO?=
 =?us-ascii?Q?UcHfVVeyqII73CEbNw9pKBQ7rjTki0c/0y5nbm7TC5wvTeugPPuGQUcjQ736?=
 =?us-ascii?Q?Q4nFmZt87UcOYXmWjFt4Smif4Qn/R8YR4d6QMNozPm+8gvz1piitfG4OZHig?=
 =?us-ascii?Q?C5UdxUhXVaamPp3AXWmEz0XI3KvOcznqVlMC8aT6nCK5TP6lSobRxwR15gEf?=
 =?us-ascii?Q?xLzywbugDfdortn3IJOC5gBbnwIOZi9F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:44.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7403bb7c-c59f-4691-b9d1-08dcc5ff2750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410

From: Shannon Nelson <shannon.nelson@amd.com>

Instead of setting up and tearing down the rxq_info only when the XDP
program is loaded or unloaded, we will build the rxq_info whether or not
XDP is in use.  This is the more common use pattern and better supports
future conversion to page_pool.  Since the rxq_info wants the napi_id
we re-order things slightly to tie this into the queue init and deinit
functions where we do the add and delete of napi.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 55 +++++++------------
 1 file changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 0fba2df33915..4a7763ec061f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -46,8 +46,9 @@ static int ionic_start_queues(struct ionic_lif *lif);
 static void ionic_stop_queues(struct ionic_lif *lif);
 static void ionic_lif_queue_identify(struct ionic_lif *lif);
 
-static int ionic_xdp_queues_config(struct ionic_lif *lif);
-static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
+static void ionic_xdp_queues_config(struct ionic_lif *lif);
+static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id);
+static void ionic_unregister_rxq_info(struct ionic_queue *q);
 
 static void ionic_dim_work(struct work_struct *work)
 {
@@ -380,6 +381,7 @@ static void ionic_lif_qcq_deinit(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	if (!(qcq->flags & IONIC_QCQ_F_INITED))
 		return;
 
+	ionic_unregister_rxq_info(&qcq->q);
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
 				IONIC_INTR_MASK_SET);
@@ -437,9 +439,7 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		qcq->sg_base_pa = 0;
 	}
 
-	ionic_xdp_unregister_rxq_info(&qcq->q);
 	ionic_qcq_intr_free(lif, qcq);
-
 	vfree(qcq->q.info);
 	qcq->q.info = NULL;
 }
@@ -925,6 +925,11 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_rx_napi);
 	else
 		netif_napi_add(lif->netdev, &qcq->napi, ionic_txrx_napi);
+	err = ionic_register_rxq_info(q, qcq->napi.napi_id);
+	if (err) {
+		netif_napi_del(&qcq->napi);
+		return err;
+	}
 
 	qcq->flags |= IONIC_QCQ_F_INITED;
 
@@ -2143,9 +2148,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 	int derr = 0;
 	int i, err;
 
-	err = ionic_xdp_queues_config(lif);
-	if (err)
-		return err;
+	ionic_xdp_queues_config(lif);
 
 	for (i = 0; i < lif->nxqs; i++) {
 		if (!(lif->rxqcqs[i] && lif->txqcqs[i])) {
@@ -2192,8 +2195,6 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 		derr = ionic_qcq_disable(lif, lif->rxqcqs[i], derr);
 	}
 
-	ionic_xdp_queues_config(lif);
-
 	return err;
 }
 
@@ -2651,7 +2652,7 @@ static void ionic_vf_attr_replay(struct ionic_lif *lif)
 	ionic_vf_start(ionic);
 }
 
-static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
+static void ionic_unregister_rxq_info(struct ionic_queue *q)
 {
 	struct xdp_rxq_info *xi;
 
@@ -2665,7 +2666,7 @@ static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
 	kfree(xi);
 }
 
-static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
+static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
 {
 	struct xdp_rxq_info *rxq_info;
 	int err;
@@ -2698,45 +2699,27 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
 	return err;
 }
 
-static int ionic_xdp_queues_config(struct ionic_lif *lif)
+static void ionic_xdp_queues_config(struct ionic_lif *lif)
 {
 	struct bpf_prog *xdp_prog;
 	unsigned int i;
-	int err;
 
 	if (!lif->rxqcqs)
-		return 0;
+		return;
 
-	/* There's no need to rework memory if not going to/from NULL program.  */
+	/* Nothing to do if not going to/from NULL program.  */
 	xdp_prog = READ_ONCE(lif->xdp_prog);
 	if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
-		return 0;
+		return;
 
 	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
 		struct ionic_queue *q = &lif->rxqcqs[i]->q;
 
-		if (q->xdp_prog) {
-			ionic_xdp_unregister_rxq_info(q);
+		if (q->xdp_prog)
 			q->xdp_prog = NULL;
-			continue;
-		}
-
-		err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
-		if (err) {
-			dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
-				i, err);
-			goto err_out;
-		}
-		q->xdp_prog = xdp_prog;
+		else
+			q->xdp_prog = xdp_prog;
 	}
-
-	return 0;
-
-err_out:
-	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++)
-		ionic_xdp_unregister_rxq_info(&lif->rxqcqs[i]->q);
-
-	return err;
 }
 
 static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
-- 
2.17.1


