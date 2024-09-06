Return-Path: <netdev+bounces-126118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157396FE77
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9B72899C2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008E15B546;
	Fri,  6 Sep 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RpAi7aBp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831615CD54
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665205; cv=fail; b=KSmQK5rsUApWfS2sse0VkQ1lMIoW04rtSpMUSBg+zYL+gWagZH8Y5Ciu7VtPzWBGwkcVdlSEv4pnyZAzvGTd87kZ7mdAkPRKO6B9D8jpPXtogq3kz0R2rQQ7XMqlVQKv81TOCx+DWggTvQnwuewJ+02ruwpNLubD6L4Y14fReqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665205; c=relaxed/simple;
	bh=N/9CGr3xkN5VXZcjx7uEX7DntK/NqF3lq2Qz9oYniSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6QNK3czHdqtXRpCE2d9hGcKMuMW152hgjnBXaINw3a2WAVA/tYQQA/XuDuURTeSogzmImcpSEbiDk6c311UhDNIBRf6H0I7lyGckDL2WvKPyQhdnMOPBpJIfYOP2RB0zrpdqUh4goKrNX+2xABSYs+x+Nv7xVWczltsX7eqmxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RpAi7aBp; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5CRhwO+ZBE+/4kMu5NHOULjuWCZnyBYMpIkSfICLZetE6q+iH5u4QqE4vi5EbCpZZ1XUl7TQd2mzXZFpUdFH+bRmwuCA9/M/XL+7ysISkIcB4hHdv15Kx6Tjt+9u4fX2CnSiqXDY53nbVBf9EP5GmVxVE7Pcfz+hW3mEUtNVp1UTP0zMltx7Q+618k2873t/9/oOFl9JVh90zQdaCxZhyrP9f2UAT0NsLbnu5wxQ86r23KNaNsLh8t1IenItl0zr84RGS8sKj/qPJyGPkHj1JTZl7ItsxLDJndFwTuR0lzNwpUrwF1LPOyBW/XBEb81Usd7kMutkO97gTJWmRGw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeHIgufQIsbv+dtTpewUhkoerNj840U6heJDELx9bFM=;
 b=h0ZBmY37i7XrigOqrBK5WNXg2UaPFw2eCFvMWRPcUeawEBmBbPO8LHnKqUwtIOM7hG9rUraZyFzjdM4U8b7bSNytSqbLV8l9HOw8U6TMZK6JCsWy06tyHJeibOv8lSJWBo7pboWAM3cKZtLdOCbAVT6LL1QlRad5JXbPaO2kyGFra3hL4VqNaZwiDeOhO/gNv/l0TyoKGlQJXGOLzj9ETNJxcJ7Szf9l6yofNI4Q0rd3F+f3/bL/I7T00YRZ8+uBP7BIN4tuWRgczoEAg5l3xMumK07BDhFeKKtOTm3cgAV6lsV+aITSzqYpswiP284fJ8xxwBsOHtCYldU2zyD7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeHIgufQIsbv+dtTpewUhkoerNj840U6heJDELx9bFM=;
 b=RpAi7aBpyBzmwrYWbUWI+ZWcSMz82/CNOyBq8vk6rrYFPu8lnY1cxj6HtuDBPc9HZboycL9AiIaXAoI8qRu617ra7jODiYxJSrPlK6HKlrhjZreJhSgvlIeFQyzPrLHTrDcqOxFWYepfXmlq/iwoFJ5gBVR/O3sfGtDEgvvLJB4=
Received: from PH7PR17CA0066.namprd17.prod.outlook.com (2603:10b6:510:325::15)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 23:26:38 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::63) by PH7PR17CA0066.outlook.office365.com
 (2603:10b6:510:325::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:36 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 4/7] ionic: always use rxq_info
Date: Fri, 6 Sep 2024 16:26:20 -0700
Message-ID: <20240906232623.39651-5-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
References: <20240906232623.39651-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: ba79dc4a-7ddf-4d79-8fd4-08dccecb5b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gta0mzRQIzz08XS+GxuGqi4QOqdHvml8C1We7nZQBKy0le1hInSSRrh2jRor?=
 =?us-ascii?Q?UHaBq1KLLpHmd2gS6p0ZmqHSCJVr2QGhC14/mxzVCHOGRPPp6k8pn8eRcWb0?=
 =?us-ascii?Q?b3J4tMEsCa/ikPJ1exujfdoUEsZZb0chdHWK/msa9iVhH0ko9l28ajeH56JP?=
 =?us-ascii?Q?2/9mTyhQH/ODCxx4s+E3u7iT7kUUYTQvq31BfrkUwZdR5kvOEg3ndRQ014EL?=
 =?us-ascii?Q?s/9kSV/6PaLSRGZmp41YkKW+cJAnttSpOjx5RtLF35d95Dc3F99ZA9You6T4?=
 =?us-ascii?Q?1Xe8XHyVnHPjJGQSmlp62SZ05JLMzc9qMkLvhGxw1+oWF3xUw3rMpoqxu4/0?=
 =?us-ascii?Q?jnFXPC2YPhLfqyqZOX3GA5PJ/Et4Nl16R9CRC+BsfZF4MC5343/6JPncrtyp?=
 =?us-ascii?Q?PpaMX4kcj8LydSyu78lVPlUjD8+z6l2ZZTFbJDUSLLBZoZVJAjH8i0BoFs+T?=
 =?us-ascii?Q?DHY5Kkj6HfI2Qr+v5Si1oP5M6vbfRqGH1R6b4VHgQZ+8JFyah0Qkt5n/CBDg?=
 =?us-ascii?Q?cDYZdOyL9RYstiLKx9iuc26YOlW0xZclUKiSXGwaAuOF0mxUNk1Kuegj1D3d?=
 =?us-ascii?Q?PinT+b9S0QuADstV48+lBNOYtLrc030E2CyHiMZHJOEteGMIbLytDniyImpW?=
 =?us-ascii?Q?yKpO7cT6baJn/4gy5PDQJpSJrROI8wRZeUwtCJug8F7Ow1K8sABxK+Aywjui?=
 =?us-ascii?Q?smACuDgZsZ1wO6mQKZS5aAxdRQPomih7SyLWSUXVOBJ28Y7ZuWH9rMRdzYY0?=
 =?us-ascii?Q?Kb+Z8ckXyBXY+/9fbDYOWYaW8nR0FdwNJ+zdlkJ5e3uuSQETY8EJ66XzWW1w?=
 =?us-ascii?Q?sS3KwV1K6iNxNRxVDzkoaupQIKQVmlHUSXWwVMTzdDmNV88gQ3PY2RRYu1Ed?=
 =?us-ascii?Q?x/KE+MDsnnKrpeRo992SXMVMj7q7apaRz239DJKZLybDygpr8QfLDuJle+WS?=
 =?us-ascii?Q?M120iazts21aWNqPFaDHG2GSf0I6GcgoMP4H0pGhmtZe76xtiFPssYj2uI/9?=
 =?us-ascii?Q?KPYO4h/GPXX/g3ibD9MusQ1eSBBoNSxdMsoa1ZUA7GbobDrxHIrfrKiVXC7O?=
 =?us-ascii?Q?wnDegYqSYISw12sMCR6s3k7QVIgaWt2OWyCFAooMH9tUH14aD6CH2YXt18AF?=
 =?us-ascii?Q?ZrVP+DUXplws74M0mt0+x4FvtI1BVLvddX/z/inLBQLp6OEMAv1Dk+Tc+3C/?=
 =?us-ascii?Q?4KeZaeASwleuxJ0Sb/T8JwAtcV9pNGP+JmV0CE77wH8z1ODFFVsC+Wang/SL?=
 =?us-ascii?Q?oChTDFeBHFnrBaNVKrI/nPrtQN4Vea7taDUhV1LJchF7y6G2eHACkRpczBRA?=
 =?us-ascii?Q?Z/Q4Ev/B+H1kieBFFr33aL/k4C/NNmlXOcWsYSB20yeG9widll+OQo1inDKa?=
 =?us-ascii?Q?wAciAK1hQ0og8D0BzoHU2yUwSujz/DGtjsYa8UyetDNqiMeJQKsraj2dFNvj?=
 =?us-ascii?Q?w4Tps7BiJzSEpfs3kTpHa3ruaIvDF3Ot?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:38.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba79dc4a-7ddf-4d79-8fd4-08dccecb5b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

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
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 51 ++++++-------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 79eda0ca82a1..5d1bf54e3133 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -46,8 +46,9 @@ static int ionic_start_queues(struct ionic_lif *lif);
 static void ionic_stop_queues(struct ionic_lif *lif);
 static void ionic_lif_queue_identify(struct ionic_lif *lif);
 
-static int ionic_xdp_rxqs_update(struct ionic_lif *lif);
-static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
+static void ionic_xdp_rxqs_prog_update(struct ionic_lif *lif);
+static void ionic_unregister_rxq_info(struct ionic_queue *q);
+static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id);
 
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
 
-	err = ionic_xdp_rxqs_update(lif);
-	if (err)
-		return err;
+	ionic_xdp_rxqs_prog_update(lif);
 
 	for (i = 0; i < lif->nxqs; i++) {
 		if (!(lif->rxqcqs[i] && lif->txqcqs[i])) {
@@ -2192,7 +2195,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 		derr = ionic_qcq_disable(lif, lif->rxqcqs[i], derr);
 	}
 
-	ionic_xdp_rxqs_update(lif);
+	ionic_xdp_rxqs_prog_update(lif);
 
 	return err;
 }
@@ -2651,7 +2654,7 @@ static void ionic_vf_attr_replay(struct ionic_lif *lif)
 	ionic_vf_start(ionic);
 }
 
-static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
+static void ionic_unregister_rxq_info(struct ionic_queue *q)
 {
 	struct xdp_rxq_info *xi;
 
@@ -2665,7 +2668,7 @@ static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q)
 	kfree(xi);
 }
 
-static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
+static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
 {
 	struct xdp_rxq_info *rxq_info;
 	int err;
@@ -2698,44 +2701,20 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
 	return err;
 }
 
-static int ionic_xdp_rxqs_update(struct ionic_lif *lif)
+static void ionic_xdp_rxqs_prog_update(struct ionic_lif *lif)
 {
 	struct bpf_prog *xdp_prog;
 	unsigned int i;
-	int err;
 
 	if (!lif->rxqcqs)
-		return 0;
+		return;
 
 	xdp_prog = READ_ONCE(lif->xdp_prog);
 	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
 		struct ionic_queue *q = &lif->rxqcqs[i]->q;
 
-		if (q->xdp_prog) {
-			ionic_xdp_unregister_rxq_info(q);
-			q->xdp_prog = NULL;
-		}
-
-		if (xdp_prog) {
-			unsigned int napi_id = lif->rxqcqs[i]->napi.napi_id;
-
-			err = ionic_xdp_register_rxq_info(q, napi_id);
-			if (err) {
-				dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
-					i, err);
-				goto err_out;
-			}
-		}
 		q->xdp_prog = xdp_prog;
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


