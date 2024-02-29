Return-Path: <netdev+bounces-76308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA086D364
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671E2286DA8
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1813F454;
	Thu, 29 Feb 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNGW0xoj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3158313F429
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235617; cv=fail; b=gSOE77fuhCpXcdyCegCcwGRz0jzxyhClgVSNXAVi+6JiI3WcQBrE8RUvxBF22pamnVA8RUwrjX43KKVPZJDtPZjWPeKlrFEl9QnMkHbixG+kcfxFbWbgYRv4JW6vwyQLzqTWv61FJ1vY9suAMh9ZbViP/wLCQZUTZwXOjKf5eiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235617; c=relaxed/simple;
	bh=TUEr1NOF8qBW8pyP43u3LsnuwG42mr4dfo1MAkwckpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrWAXxrIIwqPyfmhiqUpIXUA6SE+gS7h8icsn2+y5cpKh/OkLHgKJTfNE4Xo6fm/V/u7tMWMsxJlJSq5G2BsMU/NIODpZFk/RFNvpU3kZTofc7T1YbEDwpTzaxftRMU2zgdrpaVw91btgZmjXxh8AQdO8f2ua8Kshcepc1qgVgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNGW0xoj; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6u7PHTYnbJ2br+sy4qBLNYTfPG2YIWGNDkKW0FxsmO/1T75XoeQ6DeeFIlGuQMeNqw7J1w+bHHKrjv9XcQJq0ItIfU7kFw3nzOAc36sgWc4YX585eibcBzagzcJxz2k3VgAzYV6W32ZAudGw7iOQEsKFkXtyW3LwpAWC9oxFjIF98tl3EFRkfuLkSvzM/Ra+hB6RRxaU53PlBG9hW/SlBwEOuT9jYRm1YUibiugs2RszrwtvI1rI3bZPAs2R1Fe4l/Zf43hebAe8WOnM0TGwc79THJoU4V+fLD5dlDVA2ntL9Bimh/IsvEtFRYPJCwqsQce/lDklvg9x4RqOtCLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG2DamIwnCwrsClmNBTuAj9ieyHGPtp57TQ/6ABvptQ=;
 b=hC2nAQ0oumah+hF+6IuklDqfvxcxFq3S0YDJQ8DofiGoRjZzf3SsknLiHqkqTfjLsFNVXMqx6nOr6hqzOPxmxh3FvHL6YfN0Qfmpdx8PbiROkKwDSLw0kaY8KcYtUQ4lM3doNhvEOVVH8ZnnbRhoTE9SqBsA+Wq4bsmXcSOFIPeHB7MBSsVixVMbu1d5NjxPcrWls15ZMDbowbIZvbTA6NkCPm8yaFXdGDdxasGSZaUU847DmqJAYfamOZsAQP8gvEjykU/U1WHzdFk0uVdZpnL3CN+2gmFS3oEQ4HxpExJCjvvd2DGRoPi9yhUpe4gFnnxwCc7OnFEFPRRL9Drr5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG2DamIwnCwrsClmNBTuAj9ieyHGPtp57TQ/6ABvptQ=;
 b=pNGW0xojljzmGx5BQd+pZZQT6rVg3yfWOhcag2zZksoa4oCops6dzSHw9ZYr9niR/oP91Ji6LKi9buW2XUJLshF4M/n8ZNNeoMY2jyCI152P0Ylp/4DizXhxK+TdmeWMVztuubjMhPU7YG79OFa2flAvR1fgM/x1EYFS2V7Mbkw=
Received: from BLAPR03CA0180.namprd03.prod.outlook.com (2603:10b6:208:32f::10)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:40:13 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::5e) by BLAPR03CA0180.outlook.office365.com
 (2603:10b6:208:32f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.29 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:11 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 05/12] ionic: Clean up BQL logic
Date: Thu, 29 Feb 2024 11:39:28 -0800
Message-ID: <20240229193935.14197-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240229193935.14197-1-shannon.nelson@amd.com>
References: <20240229193935.14197-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: ead9ea62-ad33-480c-c5be-08dc395e3f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dau/AdBd51T0lr6fWlhfM0P5svZzfUnSzche+1+AqpoyFKC3PbFMqf8B0/PUmVE1hVYTZ3i6M5dYloq/KTS8VkQuyqcpSpXxKL/yTwvFR4gW5+TIIuQMxbYnYQnFhfx3qjLJovRsjDWX13+I5mcmxHguogJTBCEQ0BMrEndZBgpyVtag+ObBrZddspC2zyw6FoFigKBWK1AJYGxSk35KhbpRqoC/uZGmg2ZJzN8eBw/SOJJt75dOAkwem+gB7cTtMcpHcKdHtaQt4IDdMVy9jBIyg015msTUcjrk4aMAlEQ+o3URwDPIu/TTazPniKIPSY9+OFYm5s6B+KTxrEnuanSCIrTs9yisIsBancsyb8/+MbpfpswJ3YLVn9ptjpqjKL+yLkwO+LGQkPu00RvIJS/xMs4elGqbtny5E38OMYcjdr4Sl+6qUtuHGd7kSQALScn4dj8SgT5PVu9hYyEdEszHq0tkG91Veg81wQac+AoTuMeZrY0akCIVpUHOXNk9oiTbj4WwoowZ2T126e3AS2eTBWk//+HGLKG89ADsCcBOJa3pqaRCi6TDP+VaFHHjZShmPv0iiTAPLxLfsuEIGxQir0ynb6vrqfaNKcBDw6Idk3jfjOnJ5fxJhz37w0dvxKfcpZuXonuPDUT0w8Z8kqbfAkpvQ4xjR9H64tKtNXTGcItDltIe3YSnhGJh8W2v1mlr5S93YQEUS7+rCpJDk+2idKefo0TlUfpaiap1yf7ToHKONv7psU1snOpdlaps
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:13.4583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead9ea62-ad33-480c-c5be-08dc395e3f85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

From: Brett Creeley <brett.creeley@amd.com>

The driver currently calls netdev_tx_completed_queue() for every
Tx completion. However, this API is only meant to be called once
per NAPI if any Tx work is done.  Make the necessary changes to
support calling netdev_tx_completed_queue() only once per NAPI.

Also, use the __netdev_tx_sent_queue() API, which supports the
xmit_more functionality.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 36 +++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 3da4fd322690..1397a0dcf794 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -1235,13 +1235,14 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	napi_consume_skb(skb, 1);
 }
 
-static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
+static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
+			     unsigned int *total_pkts, unsigned int *total_bytes)
 {
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_desc_info *desc_info;
 	struct ionic_txq_comp *comp;
-	int bytes = 0;
-	int pkts = 0;
+	unsigned int bytes = 0;
+	unsigned int pkts = 0;
 	u16 index;
 
 	comp = cq_info->cq_desc + cq->desc_size - sizeof(*comp);
@@ -1266,8 +1267,8 @@ static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 		desc_info->cb_arg = NULL;
 	} while (index != le16_to_cpu(comp->comp_index));
 
-	if (pkts && bytes && !ionic_txq_hwstamp_enabled(q))
-		netdev_tx_completed_queue(q_to_ndq(q), pkts, bytes);
+	(*total_pkts) += pkts;
+	(*total_bytes) += bytes;
 
 	return true;
 }
@@ -1276,12 +1277,14 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 {
 	struct ionic_cq_info *cq_info;
 	unsigned int work_done = 0;
+	unsigned int bytes = 0;
+	unsigned int pkts = 0;
 
 	if (work_to_do == 0)
 		return 0;
 
 	cq_info = &cq->info[cq->tail_idx];
-	while (ionic_tx_service(cq, cq_info)) {
+	while (ionic_tx_service(cq, cq_info, &pkts, &bytes)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
 		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
@@ -1294,10 +1297,10 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 	if (work_done) {
 		struct ionic_queue *q = cq->bound_q;
 
-		smp_mb();	/* assure sync'd state before stopped check */
-		if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)) &&
-		    ionic_q_has_space(q, IONIC_TSO_DESCS_NEEDED))
-			netif_wake_subqueue(q->lif->netdev, q->index);
+		if (!ionic_txq_hwstamp_enabled(q))
+			netif_txq_completed_wake(q_to_ndq(q), pkts, bytes,
+						 ionic_q_space_avail(q),
+						 IONIC_TSO_DESCS_NEEDED);
 	}
 
 	return work_done;
@@ -1308,8 +1311,7 @@ void ionic_tx_flush(struct ionic_cq *cq)
 	struct ionic_dev *idev = &cq->lif->ionic->idev;
 	u32 work_done;
 
-	work_done = ionic_cq_service(cq, cq->num_descs,
-				     ionic_tx_service, NULL, NULL);
+	work_done = ionic_tx_cq_service(cq, cq->num_descs);
 	if (work_done)
 		ionic_intr_credits(idev->intr_ctrl, cq->bound_intr->index,
 				   work_done, IONIC_INTR_CRED_RESET_COALESCE);
@@ -1335,8 +1337,10 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info->cb_arg = NULL;
 	}
 
-	if (pkts && bytes && !ionic_txq_hwstamp_enabled(q))
+	if (!ionic_txq_hwstamp_enabled(q)) {
 		netdev_tx_completed_queue(q_to_ndq(q), pkts, bytes);
+		netdev_tx_reset_queue(q_to_ndq(q));
+	}
 }
 
 static int ionic_tx_tcp_inner_pseudo_csum(struct sk_buff *skb)
@@ -1643,6 +1647,7 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 {
 	struct ionic_desc_info *desc_info = &q->info[q->head_idx];
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
+	bool ring_dbell = true;
 
 	if (unlikely(ionic_tx_map_skb(q, skb, desc_info)))
 		return -EIO;
@@ -1661,8 +1666,9 @@ static int ionic_tx(struct ionic_queue *q, struct sk_buff *skb)
 	stats->bytes += skb->len;
 
 	if (!ionic_txq_hwstamp_enabled(q))
-		netdev_tx_sent_queue(q_to_ndq(q), skb->len);
-	ionic_txq_post(q, !netdev_xmit_more(), ionic_tx_clean, skb);
+		ring_dbell = __netdev_tx_sent_queue(q_to_ndq(q), skb->len,
+						    netdev_xmit_more());
+	ionic_txq_post(q, ring_dbell, ionic_tx_clean, skb);
 
 	return 0;
 }
-- 
2.17.1


