Return-Path: <netdev+bounces-105430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA8911208
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC73B2111B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811961B47BA;
	Thu, 20 Jun 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zEJ7Sh8r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F222EED
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911547; cv=fail; b=NFytRTXicSeVE6qa4+/jHw0tGlLLU4iB1UeByFPmhJcJ8ErKl6XwThktC83oKUiXSTOZdrMQ8KW5jLM1Aejkn2b9+Q2IiCaM32OJa7hVS5hfTzMHbjJ8z9n3nfzHNHxUbZszzKAiuu0FPjvM9GypMv7u5tMYMAmcReiDW2xw8Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911547; c=relaxed/simple;
	bh=3KWhlMU5+MauTsRf2c8dsPWMG44KudmaO6sU6vYB51Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DuWRhukPaiHENviHQqXQRomr/sRtmgR4zAliju01dvY64x9lZuNQwqAu+oze9JCUIFrRYfPDvrQLf5NjB3YxM/AHxF+v32onEwXyWYZBHUKhr1otLuQgsbXXo13y3mTk1pVDTJRwkh2zdQRUr1WSyjSKpnagGC+BPP+cvfNL2i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zEJ7Sh8r; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmkGoK7rjXGze+rNKDYDLrZ+Wdbj6MmFEL0qsTE7zdpk4Waclj0AW4tm9bBo1BKMB2uc/Rv3XE8v1zFjREiPo6xGJj819mYskhgwrQZq22hEu0m35No995BzEBZTi5TKqo4SDWMsbByYyOclHFOAAKddlnyM0F6tCd5T/lJ1TryTA5gwqDeUvALZ7jUvkjIq1P4CfRoYoxp0DMEYaxRRDfwzt/3BF3GSOMEaCm74ZPBnum9Vz2hKcZ3FJ01a2DD0j3KK7/7T9XbTW7xuIOZgefNrPMCAiv4Rtz1ng3oH5Z75RxptACwVOFbX50e6cADOk0nNJeSsR0gTvoLB/xogKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc6PjpVDB+8JKzrQsa4Bzf0H+8/i/1HOn9JcNmyhMVo=;
 b=UiX/uLGmOi7ktNELtfDe1YCvd+RPKquonACAWi+7PwlDhG1DfWapYglYCEbrZJDDfFNpabbRCC+Q6cuKdgMl+9rI5JuzXD6X8puKcyKegaYHfzhkHALY/uaZFa8VAFXPfa/91DUE0RiLIj0LWwKZGoMpXDSL1aBNR73xmQ+olDAiqFLz/sHPnlnWq5O6JuloBBuIJzjVPOLbV2Hj+k9FrkOo4TIvLftDREmihu1GR0qai5WY2C3dTBI0+PdvYXrg1QAPIrNj2IdfHGDxp2K9Hz32ym3V1svKL+1ABr+vtc+LXrXFjKRTdCAiVzEjvAg2Bj2GY6aTXHryN/lOwD1vMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc6PjpVDB+8JKzrQsa4Bzf0H+8/i/1HOn9JcNmyhMVo=;
 b=zEJ7Sh8rUMrk23IJYP+SGAoJTN1wtbAoEfKSBMeN0yyQNf5atvfZ+sGI9Ko5uzIWshnxa7wR+IM7eP00T88ki3xjDdHi18oMApABrF5XNeXdjbgVlM2R/XMRGmtK1cati+/YHyNm/oRQp0u+MbFiBli1g2WppsG70G3N245uraY=
Received: from CH2PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610::29) by
 CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Thu, 20 Jun 2024 19:25:38 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::55) by CH2PR05CA0016.outlook.office365.com
 (2603:10b6:610::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Thu, 20 Jun 2024 19:25:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 19:25:38 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 14:25:37 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net] ionic: use dev_consume_skb_any outside of napi
Date: Thu, 20 Jun 2024 12:25:19 -0700
Message-ID: <20240620192519.35395-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d23130-dfca-4741-a89e-08dc915ec45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3yGv75uoRlc94RSDXZormRQ8KIa0jUE7DQ8wEnB7F1CYM1DIwK8zGytUY9q8?=
 =?us-ascii?Q?e7ZcnZ5UDvq7iWivRVoX8t/sJ9fwLTzpZnel6uemwQFq5/MdzDfRCbNITBqd?=
 =?us-ascii?Q?YABVVxJrWjANHmo+0GTq3lKg1/I+vvSiY8D+V0C4s7PL0BhL80KOspLG1C4F?=
 =?us-ascii?Q?ibi7tAyKlzLILm7WE+gXAPcCvsQ1KlqL9ZnY8aCGcXKTLTfhiJslcP8WnPhk?=
 =?us-ascii?Q?yRhbNosgohaSPgqUq7tWbaCp5ewDYmvc3eLnP7VrtXEynI71U5770njcLrP/?=
 =?us-ascii?Q?qh1mog9iZhpDV6MCbaaHO1dnaznnEAGh2zVNMdqZZKqsf98RDtjriJYThBzZ?=
 =?us-ascii?Q?VXmhi8Gs4DiEUDAObvuo3JFTs3P3wUC7jV32Z+wS1u3xivDfqwKHkkig6JV2?=
 =?us-ascii?Q?bVIPQlgyUFkeZwYbpVFTPAu2LsWaqhS6gjn1i21SZFmP+Mp7EnO+bpdlcRpM?=
 =?us-ascii?Q?prBeqHzhYSTAXE+Zlr9Hc0LQfHd9Q2n6JfhSaGv0y/pa3lpzkPxv3nSdbkU6?=
 =?us-ascii?Q?//du4la4kiyGfuzg0NMBQ04LIyNWRABkQk8CvKqCAj81iHicSbIDl66gtrzC?=
 =?us-ascii?Q?JdxfhynOCmcUiM+6SDT8D3HWWoI9UstsNVTfibSpX62R//ZvXXiHG0uusUO2?=
 =?us-ascii?Q?Xfc1N1XPL7v5e30G72UVfjv8b9V0eTBJK0ym1xLNaFC1J23hjzddZDd9uFej?=
 =?us-ascii?Q?1lQxm3fI33MhpJOdgDbiYfkyQAII9AdeuksKwqr0fyX7UGjAWp+NbJeBJjB0?=
 =?us-ascii?Q?xFZNFp6IujedR2K7QPJhlI0Ul64KLp1lAyuX2Zoj4zpS2YertB8dIAXOEiI5?=
 =?us-ascii?Q?1psebMIwhGjj8k9mTets1IET0bnqRlRBBUMEgNjNvXhlEUvFkjjOFoB1b8Ey?=
 =?us-ascii?Q?+7Y4lYbm2xBGXbnvbjVFbfbYyQjmI9vWgUA0g1fiWo18LzIwu0tuPsC7rOXf?=
 =?us-ascii?Q?vEIQt0qH1+SzglERPFEl3/7SHHoB6t1xvxsqAW2NMn7w06pVXFAQvBgpe1no?=
 =?us-ascii?Q?afzZKBLkAr2DbcSf/b8UQ3a3GYHMMlgbQV6TI/oBNH63QRw81Zsy8efvjGl7?=
 =?us-ascii?Q?B9kwazBxin0H+zmxsyL7KtB9S76tQk15dCA/Bb56JvcuT7PzW6Pov4bXRKvo?=
 =?us-ascii?Q?i1gpmmD5snUJo3RP1LvOUW6D1AzMe/WfHgP2aYJchiLc/ocJlP1jw1cV+WqZ?=
 =?us-ascii?Q?rBXUPGa0sYlhMeVxkfEqnD3woQbim79NUjy3oiDRJo7/Kfuer2GsIV3fyvc2?=
 =?us-ascii?Q?7qytOJl9x8ZILXCloPYB8BIX6F8NY+lN02jXxsq8fhTJ9j5hjWAFa4HDwczk?=
 =?us-ascii?Q?v5XP5VuUiLZaUBPAAqG2BS9wdj6Nw1gwBk4/f681P8TFkee8uhHiERz4K9Lm?=
 =?us-ascii?Q?SNI8vwE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(376011)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 19:25:38.6215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d23130-dfca-4741-a89e-08dc915ec45a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

If we're not in a NAPI softirq context, we need to be careful
about how we call napi_consume_skb(), specifically we need to
call it with budget==0 to signal to it that we're not in a
safe context.

This was found while running some configuration stress testing
of traffic and a change queue config loop running, and this
curious note popped out:

[ 4371.402645] BUG: using smp_processor_id() in preemptible [00000000] code: ethtool/20545
[ 4371.402897] caller is napi_skb_cache_put+0x16/0x80
[ 4371.403120] CPU: 25 PID: 20545 Comm: ethtool Kdump: loaded Tainted: G           OE      6.10.0-rc3-netnext+ #8
[ 4371.403302] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 01/23/2021
[ 4371.403460] Call Trace:
[ 4371.403613]  <TASK>
[ 4371.403758]  dump_stack_lvl+0x4f/0x70
[ 4371.403904]  check_preemption_disabled+0xc1/0xe0
[ 4371.404051]  napi_skb_cache_put+0x16/0x80
[ 4371.404199]  ionic_tx_clean+0x18a/0x240 [ionic]
[ 4371.404354]  ionic_tx_cq_service+0xc4/0x200 [ionic]
[ 4371.404505]  ionic_tx_flush+0x15/0x70 [ionic]
[ 4371.404653]  ? ionic_lif_qcq_deinit.isra.23+0x5b/0x70 [ionic]
[ 4371.404805]  ionic_txrx_deinit+0x71/0x190 [ionic]
[ 4371.404956]  ionic_reconfigure_queues+0x5f5/0xff0 [ionic]
[ 4371.405111]  ionic_set_ringparam+0x2e8/0x3e0 [ionic]
[ 4371.405265]  ethnl_set_rings+0x1f1/0x300
[ 4371.405418]  ethnl_default_set_doit+0xbb/0x160
[ 4371.405571]  genl_family_rcv_msg_doit+0xff/0x130
	[...]

I found that ionic_tx_clean() calls napi_consume_skb() which calls
napi_skb_cache_put(), but before that last call is the note
    /* Zero budget indicate non-NAPI context called us, like netpoll */
and
    DEBUG_NET_WARN_ON_ONCE(!in_softirq());

Those are pretty big hints that we're doing it wrong.  We can pass a
context hint down through the calls to let ionic_tx_clean() know what
we're doing so it can call napi_consume_skb() correctly.

Fixes: 386e69865311 ("ionic: Make use napi_consume_skb")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  4 ++-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 28 +++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

v2: replace softirq_count() with a napi context hint (Jakub)

v1: https://lore.kernel.org/netdev/20240619212022.30700-1-shannon.nelson@amd.com/

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index f30eee4a5a80..b6c01a88098d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -375,7 +375,9 @@ typedef void (*ionic_cq_done_cb)(void *done_arg);
 unsigned int ionic_cq_service(struct ionic_cq *cq, unsigned int work_to_do,
 			      ionic_cq_cb cb, ionic_cq_done_cb done_cb,
 			      void *done_arg);
-unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do);
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq,
+				 unsigned int work_to_do,
+				 bool in_napi);
 
 int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 1934e9d6d9e4..33396ff25cf2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1189,7 +1189,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 					   ionic_rx_service, NULL, NULL);
 
 	if (lif->hwstamp_txq)
-		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget);
+		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget, true);
 
 	work_done = max(max(n_work, a_work), max(rx_work, tx_work));
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2427610f4306..9c7aec918f85 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -23,7 +23,8 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_tx_desc_info *desc_info,
-			   struct ionic_txq_comp *comp);
+			   struct ionic_txq_comp *comp,
+			   bool in_napi);
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
 {
@@ -935,7 +936,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 	u32 work_done = 0;
 	u32 flags = 0;
 
-	work_done = ionic_tx_cq_service(cq, budget);
+	work_done = ionic_tx_cq_service(cq, budget, true);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1019,7 +1020,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	txqcq = lif->txqcqs[qi];
 	txcq = &lif->txqcqs[qi]->cq;
 
-	tx_work_done = ionic_tx_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT);
+	tx_work_done = ionic_tx_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT, true);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1152,7 +1153,8 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_tx_desc_info *desc_info,
-			   struct ionic_txq_comp *comp)
+			   struct ionic_txq_comp *comp,
+			   bool in_napi)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_qcq *qcq = q_to_qcq(q);
@@ -1204,11 +1206,13 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	desc_info->bytes = skb->len;
 	stats->clean++;
 
-	napi_consume_skb(skb, 1);
+	napi_consume_skb(skb, likely(in_napi) ? 1 : 0);
 }
 
 static bool ionic_tx_service(struct ionic_cq *cq,
-			     unsigned int *total_pkts, unsigned int *total_bytes)
+			     unsigned int *total_pkts,
+			     unsigned int *total_bytes,
+			     bool in_napi)
 {
 	struct ionic_tx_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
@@ -1230,7 +1234,7 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 		desc_info->bytes = 0;
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, comp);
+		ionic_tx_clean(q, desc_info, comp, in_napi);
 		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
@@ -1244,7 +1248,9 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	return true;
 }
 
-unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq,
+				 unsigned int work_to_do,
+				 bool in_napi)
 {
 	unsigned int work_done = 0;
 	unsigned int bytes = 0;
@@ -1253,7 +1259,7 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 	if (work_to_do == 0)
 		return 0;
 
-	while (ionic_tx_service(cq, &pkts, &bytes)) {
+	while (ionic_tx_service(cq, &pkts, &bytes, in_napi)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
 		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
@@ -1279,7 +1285,7 @@ void ionic_tx_flush(struct ionic_cq *cq)
 {
 	u32 work_done;
 
-	work_done = ionic_tx_cq_service(cq, cq->num_descs);
+	work_done = ionic_tx_cq_service(cq, cq->num_descs, false);
 	if (work_done)
 		ionic_intr_credits(cq->idev->intr_ctrl, cq->bound_intr->index,
 				   work_done, IONIC_INTR_CRED_RESET_COALESCE);
@@ -1296,7 +1302,7 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info = &q->tx_info[q->tail_idx];
 		desc_info->bytes = 0;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, NULL);
+		ionic_tx_clean(q, desc_info, NULL, false);
 		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
-- 
2.17.1


