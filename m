Return-Path: <netdev+bounces-184422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED7A95578
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8F3B5327
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7971E9901;
	Mon, 21 Apr 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mfg2Fr5S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBFE1E3DF2;
	Mon, 21 Apr 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257607; cv=fail; b=miEAQ6F5m4iiBvny08Nl4SewMZUBbPwiqOCgp5XGkMj2OMa5wZhKnepZ7XKS7/Yva098d5GPKZdr9IZSyZvfNjeKtH+V/n3VUhFhF0kqEfyVRSUKt2jTEL0gRBbhlIdsavFZxYRzOCd2oN5uOJm1QIzlwreWzd/IYjZah9AXtXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257607; c=relaxed/simple;
	bh=M9YSu87AU1yHiosxpWupIOl9+RytBCJHOOlifW+UjvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwajgAAQLIpLQnwgbhUMBCzuQkUMsVAspu9T59rx4A4jUz1OR/It8gthphWOe0YHiqW0s2Ee2VWKy/NyCDSYXHxOYZkfhIRVprmwoN8mJtI09Gay5R4OTr9PV30pkO7p1SX4GdmIWneEXshiUacNRjTsca5CJUSAxHqW8FhqkMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mfg2Fr5S; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdpjRT5DWLyNzQABAhhz4I9Tuu6JNwflDkriC0Cini8jZSL49OBkc3XeGp/ufIeB+bf8W8MBa7YaZjnYHJdPp2sTnYemdGkCZuR0SmWCOB5sW3WumBoCLxEd7ojKWlEltvEchIu6Gs6QaxlxcD3UO054pP2+dr7MmtTlg7S4T2zqUXz5C5OjZxty51lDVBldtkUZombptdQyLDrowNs0OFX8ZoGABEP376qbm5xDE0KYLHEKJrqFgjVW+ECO/953iteAt0HXLp/jP6F/WENmQ6713fBt1Th1sV5h4um4sYYRIihKvmbJl7+IpN/6Jsz7wNcCJgaF1JIzrRMpeVxC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZi9k3YXX2PHPrB2V8r1c35oUqVuhPm0BaR5Fpe+dOY=;
 b=gYOQ7KHf06DhmIZcVgHfcBWPZZ6WeFy1fDHFCQjqXp72rc/GF19va65xRFcA5XwATVp/n7AKJe6XoB2IXXXvvCzlIhZoRV9aUYtuiaIIwe6fod0/Vn7Itx7tqq+vR55yi5kkOKgAPQdSLVVJr4CyvMikmvZcKVzYbkhzMQtSNnDlIDLhq7wmmIRKpxigg8dy0hSnkFSOrgexJ9oUvhAhWF8utUDNxkI4Gl6UFyUvVD53PP5ASo5l09flfibuf0Lt2fF7zyIJq3qJpAXIBAXVVBEF9cdXiMuuYTzQ+T+r2m1n97n6k/JJmzGZBGPkspKF1ZEQOI5qfpUueliKItVU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZi9k3YXX2PHPrB2V8r1c35oUqVuhPm0BaR5Fpe+dOY=;
 b=mfg2Fr5SZaPFRh9FFMb63vWX/iNNWTHBAxAbNuQGNiojiATMs9N24IVF5SKG4/e9tpgwB2nSmrsPdfrntgA5E3NjD4ASNJFwQFDe1hW7hRf+0OD7GXmh8UZr2Mv8EpFAEo3UOw87mtVhFu8oOwLUzAgcU103XEYAgi7ABBsZFRg=
Received: from BYAPR08CA0071.namprd08.prod.outlook.com (2603:10b6:a03:117::48)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Mon, 21 Apr
 2025 17:46:43 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::87) by BYAPR08CA0071.outlook.office365.com
 (2603:10b6:a03:117::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 21 Apr 2025 17:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:46:42 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 12:46:41 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 net 4/4] pds_core: make wait_context part of q_info
Date: Mon, 21 Apr 2025 10:46:06 -0700
Message-ID: <20250421174606.3892-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
References: <20250421174606.3892-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b80de33-c1d1-4185-1a65-08dd80fc7a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2Vu4NW5SXRSfExJ6hjChU4UDsKQ54U+SDUYKmsMOGLeuEfCii89VVfE6fKR?=
 =?us-ascii?Q?wGvnAalbM+Qk2ILVXPx6GXbZhVAgFer+Ra1SgbmjUA/+rdfviQifThMhvdpV?=
 =?us-ascii?Q?94hUfaDn+xnngk1SYIspIsdD26c9mByx90DkAgT51jjRHdKcIpjdaP4GQI3N?=
 =?us-ascii?Q?tIXCv97V4KTKwtDHkrVXc86F8QhwMguN6hWJ1Z1eWg47Kk2kSTU4RRc528Fe?=
 =?us-ascii?Q?uYSvRBviO2cdOPPyR+k6j/gBoMbzaUIcd3PJIsZlYXONLZEmDPkqM/5rCh+3?=
 =?us-ascii?Q?oUKlT3ZEyoKRDDLC7SLWWXh1riLSOABR+u0luA3GYlG2RV0jxizTGDOOPWCo?=
 =?us-ascii?Q?x3Ip9cyR/vvZ302Roj6NZlFFExXWuu2Mom/loV+CvoMUdDIMXfMrRI4dsldw?=
 =?us-ascii?Q?W+edzINfq+P30upkU1LPxudQ8yw84WjJaiepvfKMaCVsU0CLWaaOPsO2ncSg?=
 =?us-ascii?Q?7EOlwjGnSHfD/tNzypKxc6T0eMKoCz4518KstRKMVvUv/ErbBQlHdIX3n/L0?=
 =?us-ascii?Q?tZy05zOB0us+IcpaLxrjXlM83wMVxfibW1nP7koCB++RL5dIp6venPVgml2k?=
 =?us-ascii?Q?Nkj3NOJxb96aF+1vzzR6kraCxVVdgn7r3waOZYML8PJ/029oDs9pozdRv/b+?=
 =?us-ascii?Q?i5fOrDMPc/1tBpjCAu56aO4s23wIeszSmm0hAsjOBLoNMKBPfopxJ66g+te7?=
 =?us-ascii?Q?fWEDHMdJPTVkKNhMRKtY6sLVTbSfAwlSbusUhUjbG36QnlWSYHO5v0qu0iRf?=
 =?us-ascii?Q?vzFRffihWrA+E5Mce359ZeiP6PFrOzyLPicKBFKhRHBFmbfJYM4MOSklDKII?=
 =?us-ascii?Q?OkVn9sPeAO3ZsZOlieX3TLQ7+/3VnwdiMqm9kI6L84+lW64dwflZAnNjSEpq?=
 =?us-ascii?Q?asCX6KCqZ9GZrEXd+96c8nUcAR3DKhhKElS+oe25vFVpJpjdKPSHrxMJ1pXK?=
 =?us-ascii?Q?7j1X5Qk5yof4UsY/3vjxqsYNlcoPk3wzgIWYUBKQ1xhV3q8d0jr14XlsWi1j?=
 =?us-ascii?Q?oN2akcSmUXQuMLCGxqBLElw2709dzfqmkxpqUvpBTJaLtHoqhHSAUY5wY0wp?=
 =?us-ascii?Q?tiKLJHUzGmznoouTq9w4+iuk4bFbkWAEWLdk+cXMjv04rolf8A+IHUMsY8Ru?=
 =?us-ascii?Q?s1ujbCo129U4QRaFNALAxSxXi1lEUjamz8Juz989+8mssRPdUTWGVI85C8XU?=
 =?us-ascii?Q?pqCeLb9Y/yqgdDgWvON3MOIb5e5ys2SyRh/5IjkZcvrxgcCE/NL9gHTfdE6X?=
 =?us-ascii?Q?2eqoZhrmSiBCHdLG8FMrVvsi9GtJMBVPUbxkpIEavzUFT5RCSGA8v36Alc/Y?=
 =?us-ascii?Q?rotrf5G1mL5hV7pgKv1tCqIK3b1COWo2QJiKr3IaeS8D2m5xAG1a7gNQyTSw?=
 =?us-ascii?Q?kKAC73dqRvkjI051A1SmjL7PrG76eNKZqZIuRNf2cZW888bejFar6emaxCx0?=
 =?us-ascii?Q?cmcckTCeAZXmjJQzQlr3T/v/1tER09HazpRCjjx+oeE6i6Cv7bQx2naaIrRR?=
 =?us-ascii?Q?Pbv+wJIyqn6mZf9rrJDW3nlUGa0KsMzz206R4/U114nEj0Cl4XXGxTdDZg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:46:42.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b80de33-c1d1-4185-1a65-08dd80fc7a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371

Make the wait_context a full part of the q_info struct rather
than a stack variable that goes away after pdsc_adminq_post()
is done so that the context is still available after the wait
loop has given up.

There was a case where a slow development firmware caused
the adminq request to time out, but then later the FW finally
finished the request and sent the interrupt.  The handler tried
to complete_all() the completion context that had been created
on the stack in pdsc_adminq_post() but no longer existed.
This caused bad pointer usage, kernel crashes, and much wailing
and gnashing of teeth.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 36 +++++++++-------------
 drivers/net/ethernet/amd/pds_core/core.c   |  4 ++-
 drivers/net/ethernet/amd/pds_core/core.h   |  2 +-
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..506f682d15c1 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -5,11 +5,6 @@
 
 #include "core.h"
 
-struct pdsc_wait_context {
-	struct pdsc_qcq *qcq;
-	struct completion wait_completion;
-};
-
 static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 {
 	union pds_core_notifyq_comp *comp;
@@ -109,10 +104,10 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		q_info = &q->info[q->tail_idx];
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
-		/* Copy out the completion data */
-		memcpy(q_info->dest, comp, sizeof(*comp));
-
-		complete_all(&q_info->wc->wait_completion);
+		if (!completion_done(&q_info->completion)) {
+			memcpy(q_info->dest, comp, sizeof(*comp));
+			complete(&q_info->completion);
+		}
 
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
@@ -162,8 +157,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 static int __pdsc_adminq_post(struct pdsc *pdsc,
 			      struct pdsc_qcq *qcq,
 			      union pds_core_adminq_cmd *cmd,
-			      union pds_core_adminq_comp *comp,
-			      struct pdsc_wait_context *wc)
+			      union pds_core_adminq_comp *comp)
 {
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_q_info *q_info;
@@ -205,9 +199,9 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
+	reinit_completion(&q_info->completion);
 
 	dev_dbg(pdsc->dev, "head_idx %d tail_idx %d\n",
 		q->head_idx, q->tail_idx);
@@ -231,16 +225,13 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	struct pdsc_wait_context wc = {
-		.wait_completion =
-			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
-	};
 	unsigned long poll_interval = 1;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
 	unsigned long time_done;
 	unsigned long remaining;
+	struct completion *wc;
 	int err = 0;
 	int index;
 
@@ -250,20 +241,19 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		return -ENXIO;
 	}
 
-	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp);
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
+	wc = &pdsc->adminqcq.q.info[index].completion;
 	time_start = jiffies;
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = msecs_to_jiffies(poll_interval);
-		remaining = wait_for_completion_timeout(&wc.wait_completion,
-							poll_jiffies);
+		remaining = wait_for_completion_timeout(wc, poll_jiffies);
 		if (remaining)
 			break;
 
@@ -292,9 +282,11 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 	dev_dbg(pdsc->dev, "%s: elapsed %d msecs\n",
 		__func__, jiffies_to_msecs(time_done - time_start));
 
-	/* Check the results */
-	if (time_after_eq(time_done, time_limit))
+	/* Check the results and clear an un-completed timeout */
+	if (time_after_eq(time_done, time_limit) && !completion_done(wc)) {
 		err = -ETIMEDOUT;
+		complete(wc);
+	}
 
 	dev_dbg(pdsc->dev, "read admin queue completion idx %d:\n", index);
 	dynamic_hex_dump("comp ", DUMP_PREFIX_OFFSET, 16, 1,
diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 55163457f12b..9512aa4083f0 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -167,8 +167,10 @@ static void pdsc_q_map(struct pdsc_queue *q, void *base, dma_addr_t base_pa)
 	q->base = base;
 	q->base_pa = base_pa;
 
-	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++)
+	for (i = 0, cur = q->info; i < q->num_descs; i++, cur++) {
 		cur->desc = base + (i * q->desc_size);
+		init_completion(&cur->completion);
+	}
 }
 
 static void pdsc_cq_map(struct pdsc_cq *cq, void *base, dma_addr_t base_pa)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 199473112c29..0b53a1fab46d 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -96,7 +96,7 @@ struct pdsc_q_info {
 	unsigned int bytes;
 	unsigned int nbufs;
 	struct pdsc_buf_info bufs[PDS_CORE_MAX_FRAGS];
-	struct pdsc_wait_context *wc;
+	struct completion completion;
 	void *dest;
 };
 
-- 
2.17.1


