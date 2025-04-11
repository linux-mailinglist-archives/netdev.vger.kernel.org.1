Return-Path: <netdev+bounces-181454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879E8A8508D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA346877B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32909148850;
	Fri, 11 Apr 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k5THPUhL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3088635A;
	Fri, 11 Apr 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331558; cv=fail; b=VVD3jlAqccLyKz2x/isqvWI9ugGR31DwBx2lBWs/dccguiuABO5YHJpCUV7Hb6Qs5g7irjyjaAgIEvt/PLEFeL447bwyzFT+lR3fEA0DoRmtlp35DnVMkqr5+1vfxHKVIZu2ct+VMEXfkkCW6MAfOE3x6PUfAd94LPeZ+Dlh7Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331558; c=relaxed/simple;
	bh=Xl5CxA2KahM9UQTmF87lPXPekYu6kKPOD9zR02bKDJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y75yPlyfFzxW5xNG3ShdA0nyFIrCHlNbinriqad803CrFqGUF3THSUQ++lGcxpTfKOSOYdwXaw8eKL5JAHvIPr1r/bJL0n8hG42XKwFgqLyMpsz6yAvtzcSaBoku7vsQr5+/fOjlOll5tZb8ZaiI6VZZT/20bAfjsiMRVjM8S38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k5THPUhL; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hngf0efapnpN15KoUIU+sSdvFxlo8YiYAVeAXFjynHL/7xTCLdcaapbueMWjix839qM9oP2p79Brg05JkXUZrs30i4IxnCZ17xqobc/W/pXTmrp/7PDDvANb4IR1CRg2S4ORYCBJi8VwBWrllKQBv/VdR2moqCKNMSTg57vNbVIzZdqEuQjO2P3Y79lNof7SiKwDzirp+ImDSYctBcmWPutUskM5FoCLKlhxONn8JpnPgIfPU6gOaeJ4jrPjABr9H7z51djCQdCh/9TU9YHhBYMlvXNxRVaza7/lEFeq8/URoWmn5DK+fLNpj1vgD3vtWlHgIFSBQKWOoB9Tf7lXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j927mxE6lkJ6neG8DDki8hJvPmQwMaRuI/AfSDrrhr0=;
 b=qH9iwc7IkeStGXDw/MLce+/SEb30fAu53MensT93CWs5PwY1IZuDEMluG9ztkIUevw1oJuaP4XgKkr0jcpXG2/KdwrweyUC3dh5v/UkrFlXxkZWFzggo3Cpg7hrsrZDxLXrlNwVG9+DapMQfy+ifTF93wKs+pO5zH5f28iSdViPNQlLcbxHCroezMLOYFZ7gmiP5FTZFeV/7p8LNXTF4EGPJNxfWD5ZTOIzXXTUBCBfmw0Y0XvkH236EqH3FngmiHfU5IfDAJ4KaIU2vDqnSvPGvToZs5wHJiz0LcUuRQN+sl3S0OI52Zs5YaWugn/Zmc1eVuUetdhPb6WzrrIlYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j927mxE6lkJ6neG8DDki8hJvPmQwMaRuI/AfSDrrhr0=;
 b=k5THPUhLmnKtaO3mTqFW5+cprQNxCHJvLPjmcQbxaJwwvoxD++SlH5AEYkYcUwHMXMOPe3XGrACvTBXKUybOl2v5BnK+Rw8iJ7nSE3ofBT5f4aDC+GO0soXLFIJD9P6amSG0RZps5q34OGXYPtBqaUysbC9jfiHUAk3v1EDQbK0=
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.24; Fri, 11 Apr
 2025 00:32:33 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 00:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 00:32:33 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 19:32:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 5/5] pds_core: make wait_context part of q_info
Date: Thu, 10 Apr 2025 17:32:09 -0700
Message-ID: <20250411003209.44053-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411003209.44053-1-shannon.nelson@amd.com>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: e98de5ab-8fec-4e31-8a5c-08dd789059fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bnCLxy3vfpF9AovezNkm7TbRfuMT7CkFQYe07fmBbIO6vndAbkw9Aip0jqvc?=
 =?us-ascii?Q?dfLtOMSAJ83x8zhvWWb7+uUmE0gaAiv6avxu5G+t9sDPLgKAkVqwjT4Yde1l?=
 =?us-ascii?Q?nHNGmXVtTzWlF06mqcTpSN3AJ8eAfhS5HoOzvY5uEj9jhlbsMKtRkIsPFegA?=
 =?us-ascii?Q?lJ9tiX3bqLpB9eMgp7D6/CDJnd+KOGmtJyr3ZdIj+qlzQkJKi32/DH7jqGUn?=
 =?us-ascii?Q?nKVEmIyvWG4R/AeR9d6ryIXss9T2+8EC7JMTZXmlv9cRHqQaQNFJrI1XjjOA?=
 =?us-ascii?Q?Wwzn766BtMhuiChHaOhBfjQjdmiG++vZRZqOUBYnx6aWW8Ret9YoQTfhCtqY?=
 =?us-ascii?Q?PX04Biuk03zIv72HEShKuSFFg6/I+4R8CPTzDwGuuS3fbnDURh0N3kwLqJzZ?=
 =?us-ascii?Q?1v+ImvbrCMVR2EtIqtIPwQ9SN9B/XiFh3470zOA6Mla2OugSFYaPq8yHJVHH?=
 =?us-ascii?Q?FACu8fMgzi+KWGwsHFtfxUYhCXwtXGGXCMpPGqXw2CMa1OVeHrsu3L6ZBctc?=
 =?us-ascii?Q?cwRXbBHcHgbgMryYziCwrMfOU5I6xcAKMLNX1RLg/OPlVEi/IIJVVw5jYBkX?=
 =?us-ascii?Q?sxq9so/lsRrHv3Kh5GMWy1IEbF15pn/zVgBCPBimDUz7tsisIFU6PWAfNdum?=
 =?us-ascii?Q?AVIRC6v6nbZ3o/g+AYIe052sD32jCFe0wl26z2Rnu7I7itqdgQqOI7nqcv6p?=
 =?us-ascii?Q?gsAroo5Do4Cqb0c5crAYsBKuPvIgNTDcjIpZoCMCKEXGxjn0APWgo4Tn8aKt?=
 =?us-ascii?Q?rI7oNJvUWGuSoxcjYjZZysdG3Ib5acQjoJ44U/StUQrcNOp6TOBwq5tczbF8?=
 =?us-ascii?Q?SaBaKJcMDRcnWvVRDbEP0tcLKbtLfd+DAr7hbKh3cgyH2qq9AZUAXSG9f7gj?=
 =?us-ascii?Q?pS11QIW+q5u1Ngo8vUsRCYKdDbVVo9WX86c3ll9srFUG0EZ/xslzOjTRkJyH?=
 =?us-ascii?Q?v45eH2dIMwXaEEjDYnQLC4k+9nHcmAfV8tnvOc4jjO3MictFzGDNajs4H7/d?=
 =?us-ascii?Q?1WFYHMMLrQkJKzMvbxUoRKgOInvL79dt7/Zm3HA0ui4vm7JJuwA0T2W9eXJ8?=
 =?us-ascii?Q?w9H3Ghug/OE/GD1qvQAARpYLwSV77MBnpBLT3DOD8BPTVSLXbZ772tGSz+nr?=
 =?us-ascii?Q?xOHejAvAigTQVb0IWUUfwIvorGGZFgfCUDphnX/kJulR8+Ic3BUtVsR5PO4Y?=
 =?us-ascii?Q?yQxhf4U6Fl/T9JNAT/f1kwdIUODK+KxVzuMeYFB0aPzPCPDQmER2M74Vi7BQ?=
 =?us-ascii?Q?4/jKVq3tnKrmFLVz29PEgr5bPio5OK76Lf0oyum7sxcxP8f7cN5bcFGCo8ro?=
 =?us-ascii?Q?6k+B+QBrVXuCE3xoRVVYV/PCG+zVMfwbfGuhyRiiGYg0jSZcMRaOtVDASFwO?=
 =?us-ascii?Q?5dNS3NsxmRjD7vDlVHpff2pm9zgNKAqcAMcV/h2OUHpB1Buhx7btsBqTjg8j?=
 =?us-ascii?Q?DusstglHrNqwPbU7Tn2FoQKdUmaC4/1UwhHhAsauQiC7GzHI7VXDqFa+soR9?=
 =?us-ascii?Q?4nNJOo4iXpEltAnG/H0HT2/8Aw9dytzeNCX25ZlPPk/Ql1iygnfIMKW7Pg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 00:32:33.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e98de5ab-8fec-4e31-8a5c-08dd789059fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

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
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 23 +++++++---------------
 drivers/net/ethernet/amd/pds_core/core.h   |  7 ++++++-
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..9bc246a4a9d8 100644
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
@@ -112,7 +107,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		/* Copy out the completion data */
 		memcpy(q_info->dest, comp, sizeof(*comp));
 
-		complete_all(&q_info->wc->wait_completion);
+		complete_all(&q_info->wc.wait_completion);
 
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
@@ -205,7 +199,6 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
 
@@ -231,11 +224,8 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	struct pdsc_wait_context wc = {
-		.wait_completion =
-			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
-	};
 	unsigned long poll_interval = 1;
+	struct pdsc_wait_context *wc;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
@@ -250,19 +240,20 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		return -ENXIO;
 	}
 
-	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp);
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
+	wc = &pdsc->adminqcq.q.info[index].wc;
+	wc->wait_completion = COMPLETION_INITIALIZER_ONSTACK(wc->wait_completion);
 	time_start = jiffies;
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = msecs_to_jiffies(poll_interval);
-		remaining = wait_for_completion_timeout(&wc.wait_completion,
+		remaining = wait_for_completion_timeout(&wc->wait_completion,
 							poll_jiffies);
 		if (remaining)
 			break;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 199473112c29..84fd814d7904 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -88,6 +88,11 @@ struct pdsc_buf_info {
 	u32 len;
 };
 
+struct pdsc_wait_context {
+	struct pdsc_qcq *qcq;
+	struct completion wait_completion;
+};
+
 struct pdsc_q_info {
 	union {
 		void *desc;
@@ -96,7 +101,7 @@ struct pdsc_q_info {
 	unsigned int bytes;
 	unsigned int nbufs;
 	struct pdsc_buf_info bufs[PDS_CORE_MAX_FRAGS];
-	struct pdsc_wait_context *wc;
+	struct pdsc_wait_context wc;
 	void *dest;
 };
 
-- 
2.17.1


