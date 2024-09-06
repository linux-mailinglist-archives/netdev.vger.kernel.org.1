Return-Path: <netdev+bounces-126115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107096FE75
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E178AB25404
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93215CD4A;
	Fri,  6 Sep 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K9DxVod+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257A15C15D
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665203; cv=fail; b=stw+g3OfDUpaQiXY8NAQTl9C1yL57SjjWpwrSg1ntHlY4MLSYK85W/FGYoCBnvsvUezeFRCobW5PbTreqO7IuCWnXxvPsdqk3nfYz/JJ4t2sV7rh/YP7OgsAgWiitoaYGDrEdrJ1MuobrSUicw/phDJytyyXHXP8VWokaj8lIcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665203; c=relaxed/simple;
	bh=kHems8DIreB8SOHaBhCgEJdiwYYA53voGI2qzuCTNyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4oOJGmFmnRz7nYWKKALwSThj+UBbz665dw5vYWIzrwuU3KP7gWYzWNjHqdhR5xRjZuJ+mcMzTtd5oq9/gVvJjmTr53dqlM2OSVq7UKi8EVEo8gm3bnyRIPZqT+fOo9tjw+PRc83qInAq9RxG9J6EuQZAE2ip+JQscNw+Kz8+z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K9DxVod+; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiEqOdVOB3iR/ZYHnFrACwwhPIGFb11M0xAMGhCCS0vKqWpsz0FdG3381KliIPdKvH1z0mdBdk0T1EATaw7dxv1GziYi01MZLY69cd/2kDoqskX62hsieXV0KCyIrT2DdMy0/705d5Zuv+HGnIfLu+b38XgMtcVouCQCn77IgDGfm1iv0PgP8F1vynv0H28QkMvHZaf3zkkkgioq6g0AEqZoGUzQr4K6QKT5wg6Pn9uDMvf0aNectYjC0QINmbG11iSw6HshVBnh+9EBgwyiV17gkLiBd2tcRsHumZ4HPObQcHJTZGexdApVZjd2c8G1kgXTw6GnxXCgEsgG2ASRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvEOADZJRD7P5hVJ1acoMaFhRfxPZYWDzQwJePkUmA4=;
 b=U+JDVr5p5/O3sosUJUfqqt3kC4TSkFRfVtmVy9w6l/FG+FB+4CiVp/AVIKyFHSHgtEgImIcdhQr35K7265jRqQBaxr0mUUoVRjMS3O1Oo1JwJvSM6JzuVueQpwOB2UzvOWEiLld0ejRDhEOjQNBvP42L2V2u/noATCi2GPCsHPBjIJUiCAijC1X4tfjjX13d6WAH3hlXjQGj4WjGbiziq6Zb9hOPyD9IUkeWHv7XAMolIPzyp93fI6EeqdecrXDgveOM0xTojAO2ykmRsExaZ2CTIyQO9eKyz5qu7sptBDJAMrR6sExgB9jU8xdoxopLLNbLXMT34LmQ7r/Y/VxAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvEOADZJRD7P5hVJ1acoMaFhRfxPZYWDzQwJePkUmA4=;
 b=K9DxVod+VWhpDxSp7PKYJwdmvQadM0cUNUZmQMWRfsH/DANko9SHqU+da0taTmUR6l/OnZ5l53CttPvWxoGBL+VUcHZyQpN06/RNLcstz3l2HXvjKWFwZtCmbkk+Wts6ICZNquG94g427cIDyhPrWj/T5gIIDoo0NZlsuASik74=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 23:26:39 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::ff) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:37 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 5/7] ionic: Fully reconfigure queues when going to/from a NULL XDP program
Date: Fri, 6 Sep 2024 16:26:21 -0700
Message-ID: <20240906232623.39651-6-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: be9e1cae-a683-4512-88cf-08dccecb5bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?92DlupnA18QnqPMM6wfPb5f7YWLBoe3l28jBiAABCFLuW1RlqVBx1qZ32Glc?=
 =?us-ascii?Q?3VCTmJcefrrSFCWJDidnhML4I3fhGMOvBgk3ZolNUGS3TGiRAcetzrcc+Sd5?=
 =?us-ascii?Q?92vE6qUXaRI0o4eKwMB6cSr8IrlWPJ4Gkyj6Ub+PQChgtEwMCLSwXjiqbde9?=
 =?us-ascii?Q?A6GapMSACzeSvaJCmd6FySYPZvD5Qwu1TPeWpqztIU+UEPvSVuPvu7RtCw3b?=
 =?us-ascii?Q?fQVLWKV0Gxs/fDOPcUzx4gZhf7YbsvqICQR8yKQw5eHDaq3xIf8Ey++JxPGr?=
 =?us-ascii?Q?0X7s79Om6FnMh8fxZ5Nj577TYxNN9d2lACXH5tq+oLTclODacxtZ5slpvahM?=
 =?us-ascii?Q?VOUn55PAbkYahM2C/55vC+UBW5wV0GE53O6oF2NsNpKiTnUsNZzWIGRAhLtw?=
 =?us-ascii?Q?yi2eWhySUG9ib53xiV1d76y2jus4pPsgGcEW2OQmtl6CKrE0gnq7R+ztAhCu?=
 =?us-ascii?Q?3QWB9E54whCtbI2LCDIUAD3ghM1QK0Rkp18TMgf6IHPr/EOiqfoQF5uFS5q7?=
 =?us-ascii?Q?Jf9zQirTnC7XoxOCYxLgCszEF2I7w5GCnQEa9SQexVGZC1N1UEdANw5UowjQ?=
 =?us-ascii?Q?DLbhPhFnnfXTPw1DBAwBKP/0ITmTybil0+ws+nk1IREj1+5oGwGmIG3P8+a0?=
 =?us-ascii?Q?3gZwxGPixbNwsZ/coL7t3b3ilJ4fSBuPtblJv5FIRKDci/OKfgz+Iwj5iwp1?=
 =?us-ascii?Q?jcg79D4sNhuc/CnBx7g4sFkFcfGRjpVgyCT1hp89Mza+fdbCoT3s/b2IsF8D?=
 =?us-ascii?Q?aAZkPFhcXQLXqdw7JUG8n/pIUhAUUGYJiLG+lAJ74uqOCBv/OQUZB2XfEJo5?=
 =?us-ascii?Q?itCoXSikGFMz+z1xkZ9hn/1oUa9glO1OSE4YJgIN4oF6a5ovVExlYXyuCOLB?=
 =?us-ascii?Q?MEq0jcwWc3NOirHQ/iHw0n9MSadMmG4tiMye17HUQafp9CfD/kQNYk+AHpkm?=
 =?us-ascii?Q?99qWv1KgtTDyCjBb7jCp/eA6n+2VCshJNHEJwBQ8/vifIEr1IJDWq4deWoEi?=
 =?us-ascii?Q?wvlMwefDQ/6dXloYb1bdxINkcNT+AXOfOXHq+4TGpN8UwZRXcNlqI+b0ncFv?=
 =?us-ascii?Q?Tqqb4mxvT2K/2qbWALVBuzS52J86iPObTnd+/UGH+t2VRZMXbKsm9SZ1Dqcc?=
 =?us-ascii?Q?qx5KHqAxdc83DZTnwrgrI5SX2QpKQBwbfMV4+d3f2ENclAqDU7bnittkIjDS?=
 =?us-ascii?Q?u1udKqCseRIcrjETnnXj3KmTO4tO9ZOHKyEevIGSv1VSJ3mrrJpHgJvpLdDp?=
 =?us-ascii?Q?mfy1GObyjkVa5g9PeSJL4vstiq1l93oHOYis4ddks26pvyDz99nq4FfcLCRB?=
 =?us-ascii?Q?XO9LjFhDW9c9l8ZJGiKJuoXqoLzx4hZ2tBf11IXif4/70lCeKv7iV2Q6Rzce?=
 =?us-ascii?Q?LXQ+uVKi+ICEbgKXoZMfwpeJ0MYYSrFvcoJNWMXdYQ2shZOv0C1v8JzkTeDS?=
 =?us-ascii?Q?Zr9o03Po7EOyPRisGPBAq0OG1c0eX6rX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:39.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be9e1cae-a683-4512-88cf-08dccecb5bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

Currently when going to/from a NULL XDP program the driver uses
ionic_stop_queues_reconfig() and then ionic_start_queues_reconfig() in
order to re-register the xdp_rxq_info and re-init the queues. This is
fine until page_pool(s) are used in an upcoming patch.

In preparation for adding page_pool support make sure to completely
rebuild the queues when going to/from a NULL XDP program. Without this
change the call to mem_allocator_disconnect() never happens when going
to a NULL XDP program, which eventually results in
xdp_rxq_info_reg_mem_model() failing with -ENOSPC due to the mem_id_pool
ida having no remaining space.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 11 ++++++++---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 5d1bf54e3133..1146ff160039 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2745,10 +2745,13 @@ static int ionic_xdp_config(struct net_device *netdev, struct netdev_bpf *bpf)
 	if (!netif_running(netdev)) {
 		old_prog = xchg(&lif->xdp_prog, bpf->prog);
 	} else {
+		struct ionic_queue_params qparams;
+
+		ionic_init_queue_params(lif, &qparams);
+		qparams.xdp_prog = bpf->prog;
 		mutex_lock(&lif->queue_lock);
-		ionic_stop_queues_reconfig(lif);
+		ionic_reconfigure_queues(lif, &qparams);
 		old_prog = xchg(&lif->xdp_prog, bpf->prog);
-		ionic_start_queues_reconfig(lif);
 		mutex_unlock(&lif->queue_lock);
 	}
 
@@ -2908,7 +2911,8 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 	}
 	if (qparam->nxqs != lif->nxqs ||
 	    qparam->nrxq_descs != lif->nrxq_descs ||
-	    qparam->rxq_features != lif->rxq_features) {
+	    qparam->rxq_features != lif->rxq_features ||
+	    qparam->xdp_prog != lif->xdp_prog) {
 		rx_qcqs = devm_kcalloc(lif->ionic->dev, lif->ionic->nrxqs_per_lif,
 				       sizeof(struct ionic_qcq *), GFP_KERNEL);
 		if (!rx_qcqs) {
@@ -2984,6 +2988,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 				goto err_out;
 
 			rx_qcqs[i]->q.features = qparam->rxq_features;
+			rx_qcqs[i]->q.xdp_prog = qparam->xdp_prog;
 		}
 	}
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 3e1005293c4a..e01756fb7fdd 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -268,6 +268,7 @@ struct ionic_queue_params {
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
 	u64 rxq_features;
+	struct bpf_prog *xdp_prog;
 	bool intr_split;
 	bool cmb_tx;
 	bool cmb_rx;
@@ -280,6 +281,7 @@ static inline void ionic_init_queue_params(struct ionic_lif *lif,
 	qparam->ntxq_descs = lif->ntxq_descs;
 	qparam->nrxq_descs = lif->nrxq_descs;
 	qparam->rxq_features = lif->rxq_features;
+	qparam->xdp_prog = lif->xdp_prog;
 	qparam->intr_split = test_bit(IONIC_LIF_F_SPLIT_INTR, lif->state);
 	qparam->cmb_tx = test_bit(IONIC_LIF_F_CMB_TX_RINGS, lif->state);
 	qparam->cmb_rx = test_bit(IONIC_LIF_F_CMB_RX_RINGS, lif->state);
-- 
2.17.1


