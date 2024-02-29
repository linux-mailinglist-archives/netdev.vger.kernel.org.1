Return-Path: <netdev+bounces-76304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFD86D360
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E761F25C4F
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4713C9E6;
	Thu, 29 Feb 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Th0+isot"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEB134411
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235613; cv=fail; b=IDACuu6haG/4dEueaVO2K6RHlPhQ6qG6lA+8eLw5+4V+W1tubpO3nI8B8r8FLc9dILr598FaIp78NmZ04Ofna0KRfVYXp6mtHkBXgvHdECiwd+Z68B4uBVkYeTZrhc3G56gdnNXpI3t63rgbJrCaNFmx9jHmfdP6I0DcQExfClk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235613; c=relaxed/simple;
	bh=oHtYrOzNkoZsRBFwXsxrsPTKHii050dSC4fDOJdq77o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rODiXyh/+hj2vutwLcOG1UDnR0UboMSQo6zTqM9kwKNovt1rLCa/QX1RIc9YGlRs4GnNZpb32i8POdEYzuLBHGjscYGz9wUZcZBf5QbzQ7imgRvALLgW56Hv9BR7zs75ub4cFPSMjHtRDn4WibgdY+oyvWAs7QlvypahD330GSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Th0+isot; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h39ZMy5eREvk8CudmMh8dttQGZ9P5C4GF6N7pA9xI4no50dOsWEagAcpLBEfaXN0ZR+KvHE64h4dZLNlnOSkNvxb6F3sUBJxJoSlnMby00Jp/l10EmAYv2Pei7071RPzDKPq/u8l9xvFHwGWqhHtuBQb5e8QkypuIZRetf6jbbErbkX13XxCLe3PsIX170natWiNNTDkGT2QE3S1A77XamZ/mBzPQ3H2MMpMWcHEQNeLctL0MH7pZg3XKIPowKR9yw2LQ9PPN2iOF2N34awhjr8uLMhnU7qiOj7XTDpO5lBrnZJY9Pi0B81he0DECGjKZboSt+Oa0vov/S/o0ISeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3sGZeS0yuY+uQGnKy3gbrxnfC7zglWPZ2WP0Wjycz0=;
 b=NcOcjRiwnsWn/WTAuUXaJWxd5BUqR4G3pdc9Vpedix7xMx4uokNjrvrCS4TOabzrX/Tr1X9AS/YMN7s/xOr0fw9MStKNLUjMZGXNsa3u5dtCjNhJLMlxzaHSrc+kAglyuM0rgXW35wF52jABwHfD4bVTjnOwiQtNB5ls0ANUS5MC6S0qjEJ2Yh1zjW+Y1ImPBlUqizk96CjYeeeR8Y883hr41v5xjwDTa4esOyF0KPUNTN2lcqnMShOA+5GsQNDbOtl8vOm2vP4CWP5ZEPpIy3uAXfden9/HQL6nJXHoYTTY5lG4Wtx3a04OQMRSF3QxjTR8g2fRqejAZLjNlXR7Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3sGZeS0yuY+uQGnKy3gbrxnfC7zglWPZ2WP0Wjycz0=;
 b=Th0+isotafaYsDwCpSS84zUx4Ex/ORFgudnBp6mqBU9uKnohm/jblxOeFHCid47BGvTD/bcKtYc1TwCEPs/xuyOzurVA8w5342Yh2f/1oFcCdbiYoh4PlkIWnrv6l90nH6sNt2YinU9fjODeoKMXHGRh/qAA7a1Lj2kjPHoj8jU=
Received: from MN2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:fc::18)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 19:40:09 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:fc:cafe::82) by MN2PR02CA0005.outlook.office365.com
 (2603:10b6:208:fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Thu, 29 Feb 2024 19:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 19:40:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 13:40:08 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 01/12] ionic: Rework Tx start/stop flow
Date: Thu, 29 Feb 2024 11:39:24 -0800
Message-ID: <20240229193935.14197-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 185c337c-3eb7-4c70-a4a5-08dc395e3d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WiMxxPJKdgN3jtjUX/fj2AD7H6jgwASr0fR8HOvzgw3xjbyGycR2qJXA0bM1F6XUlWCgToyXcLgqth9DgXX5g69bclUa/HxsUlt8o2WOBmi8MTlPHn6lPycrDzOepEhbImhBejsvlWYtuce05QdE11ol12ShLiEFlSQc18iuFoBIcTx3cM5Ns9KkjKkL270NZ5A5QP1nu1UFZWPeMAnkGdnbP2SGhk6ivio3pcRvoe9jdeSoqeFZvA2l7Pi0kh0Skfgjm+JfJYCk751oSUGrVe3cth95Uubx6wX17OmlwsOUWWEZuHeuu8idnG4HgXONRsAvKYIXW7P84NkURnl8xDj5se5Gw9v6yKnhoquBJ0dcKfSjcHkVIb6ms2AVYYQ/qcMfqZ/zHXKK6VG7Iv7wLqWYB1F7oe1rzBwV2oEvlWP5H3SSG+zHFtXD22tMTRhw9jDS5GWUWC7HotBYKYRZnJI84w7shxP2f+ilhIrV9lbC5qlNVJwJTVxnKd0p1ZsI/INzKEyNGCMZFuOGixxSjsg6VZ66XWVBY2jKqlTEC69h+tT10EDMXrmrqcr55ahReAlx2z26Ylef7f9E+tPUOFaOU1h0IpmPuf4d3v4zkZp8FQprezTiglSQRuEd/avH7jlxPXoBykYQly4CL59//GcJP3PSQG7GTQmOeu08N3tqeMxL2+g0Be1bRFoC/Dc69vnL9wzyUQ6FSP2Um/fOEbbvjt1EeRN0zwzfaDkR+r95ehWDLoBDsFsPfKaiHwRl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:40:09.2460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185c337c-3eb7-4c70-a4a5-08dc395e3d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839

From: Brett Creeley <brett.creeley@amd.com>

Currently the driver attempts to wake the Tx queue
for every descriptor processed. However, this is
overkill and can cause thrashing since Tx xmit can be
running concurrently on a different CPU than Tx clean.
Fix this by refactoring Tx cq servicing into its own
function so the Tx wake code can run after processing
all Tx descriptors.

The driver isn't using the expected memory barriers
to make sure the stop/start bits are coherent. Fix
this by  making sure to use the correct memory barriers.

Also, the driver is using the wake API during Tx
xmit even though it's already scheduled. Fix this by
using the start API during Tx xmit.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  2 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 89 ++++++++++---------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  1 -
 4 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index bfcfc2d7bcbd..abe64086e8ca 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -19,6 +19,7 @@
 #define IONIC_DEF_TXRX_DESC		4096
 #define IONIC_RX_FILL_THRESHOLD		16
 #define IONIC_RX_FILL_DIV		8
+#define IONIC_TSO_DESCS_NEEDED		44 /* 64K TSO @1500B */
 #define IONIC_LIFS_MAX			1024
 #define IONIC_WATCHDOG_SECS		5
 #define IONIC_ITR_COAL_USEC_DEFAULT	64
@@ -379,6 +380,7 @@ typedef void (*ionic_cq_done_cb)(void *done_arg);
 unsigned int ionic_cq_service(struct ionic_cq *cq, unsigned int work_to_do,
 			      ionic_cq_cb cb, ionic_cq_done_cb done_cb,
 			      void *done_arg);
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do);
 
 int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 5cfc784f1227..35a1d9927493 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1262,8 +1262,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 					   ionic_rx_service, NULL, NULL);
 
 	if (lif->hwstamp_txq)
-		tx_work = ionic_cq_service(&lif->hwstamp_txq->cq, budget,
-					   ionic_tx_service, NULL, NULL);
+		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget);
 
 	work_done = max(max(n_work, a_work), max(rx_work, tx_work));
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 56a7ad5bff17..dcaa8a4d6ad5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -5,13 +5,12 @@
 #include <linux/ipv6.h>
 #include <linux/if_vlan.h>
 #include <net/ip6_checksum.h>
+#include <net/netdev_queues.h>
 
 #include "ionic.h"
 #include "ionic_lif.h"
 #include "ionic_txrx.h"
 
-static int ionic_maybe_stop_tx(struct ionic_queue *q, int ndescs);
-
 static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 				      void *data, size_t len);
 
@@ -458,7 +457,9 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 	txq_trans_cond_update(nq);
 
 	if (netif_tx_queue_stopped(nq) ||
-	    unlikely(ionic_maybe_stop_tx(txq, 1))) {
+	    !netif_txq_maybe_stop(q_to_ndq(txq),
+				  ionic_q_space_avail(txq),
+				  1, 1)) {
 		__netif_tx_unlock(nq);
 		return -EIO;
 	}
@@ -478,7 +479,9 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 		ionic_dbell_ring(lif->kern_dbpage, txq->hw_type,
 				 txq->dbval | txq->head_idx);
 
-	ionic_maybe_stop_tx(txq, 4);
+	netif_txq_maybe_stop(q_to_ndq(txq),
+			     ionic_q_space_avail(txq),
+			     4, 4);
 	__netif_tx_unlock(nq);
 
 	return nxmit;
@@ -571,7 +574,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		txq_trans_cond_update(nq);
 
 		if (netif_tx_queue_stopped(nq) ||
-		    unlikely(ionic_maybe_stop_tx(txq, 1))) {
+		    !netif_txq_maybe_stop(q_to_ndq(txq),
+					  ionic_q_space_avail(txq),
+					  1, 1)) {
 			__netif_tx_unlock(nq);
 			goto out_xdp_abort;
 		}
@@ -946,8 +951,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 	lif = cq->bound_q->lif;
 	idev = &lif->ionic->idev;
 
-	work_done = ionic_cq_service(cq, budget,
-				     ionic_tx_service, NULL, NULL);
+	work_done = ionic_tx_cq_service(cq, budget);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1038,8 +1042,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	txqcq = lif->txqcqs[qi];
 	txcq = &lif->txqcqs[qi]->cq;
 
-	tx_work_done = ionic_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT,
-					ionic_tx_service, NULL, NULL);
+	tx_work_done = ionic_tx_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1183,7 +1186,6 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct sk_buff *skb = cb_arg;
-	u16 qi;
 
 	if (desc_info->xdpf) {
 		ionic_xdp_tx_desc_clean(q->partner, desc_info);
@@ -1200,8 +1202,6 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	if (!skb)
 		return;
 
-	qi = skb_get_queue_mapping(skb);
-
 	if (ionic_txq_hwstamp_enabled(q)) {
 		if (cq_info) {
 			struct skb_shared_hwtstamps hwts = {};
@@ -1227,9 +1227,6 @@ static void ionic_tx_clean(struct ionic_queue *q,
 				stats->hwstamp_invalid++;
 			}
 		}
-
-	} else if (unlikely(__netif_subqueue_stopped(q->lif->netdev, qi))) {
-		netif_wake_subqueue(q->lif->netdev, qi);
 	}
 
 	desc_info->bytes = skb->len;
@@ -1238,7 +1235,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	dev_consume_skb_any(skb);
 }
 
-bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
+static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 {
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_desc_info *desc_info;
@@ -1275,6 +1272,37 @@ bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 	return true;
 }
 
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
+{
+	struct ionic_cq_info *cq_info;
+	unsigned int work_done = 0;
+
+	if (work_to_do == 0)
+		return 0;
+
+	cq_info = &cq->info[cq->tail_idx];
+	while (ionic_tx_service(cq, cq_info)) {
+		if (cq->tail_idx == cq->num_descs - 1)
+			cq->done_color = !cq->done_color;
+		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
+		cq_info = &cq->info[cq->tail_idx];
+
+		if (++work_done >= work_to_do)
+			break;
+	}
+
+	if (work_done) {
+		struct ionic_queue *q = cq->bound_q;
+
+		smp_mb();	/* assure sync'd state before stopped check */
+		if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)) &&
+		    ionic_q_has_space(q, IONIC_TSO_DESCS_NEEDED))
+			netif_wake_subqueue(q->lif->netdev, q->index);
+	}
+
+	return work_done;
+}
+
 void ionic_tx_flush(struct ionic_cq *cq)
 {
 	struct ionic_dev *idev = &cq->lif->ionic->idev;
@@ -1724,25 +1752,6 @@ static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 	return ndescs;
 }
 
-static int ionic_maybe_stop_tx(struct ionic_queue *q, int ndescs)
-{
-	int stopped = 0;
-
-	if (unlikely(!ionic_q_has_space(q, ndescs))) {
-		netif_stop_subqueue(q->lif->netdev, q->index);
-		stopped = 1;
-
-		/* Might race with ionic_tx_clean, check again */
-		smp_rmb();
-		if (ionic_q_has_space(q, ndescs)) {
-			netif_wake_subqueue(q->lif->netdev, q->index);
-			stopped = 0;
-		}
-	}
-
-	return stopped;
-}
-
 static netdev_tx_t ionic_start_hwstamp_xmit(struct sk_buff *skb,
 					    struct net_device *netdev)
 {
@@ -1804,7 +1813,9 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (ndescs < 0)
 		goto err_out_drop;
 
-	if (unlikely(ionic_maybe_stop_tx(q, ndescs)))
+	if (!netif_txq_maybe_stop(q_to_ndq(q),
+				  ionic_q_space_avail(q),
+				  ndescs, ndescs))
 		return NETDEV_TX_BUSY;
 
 	if (skb_is_gso(skb))
@@ -1815,12 +1826,6 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	if (err)
 		goto err_out_drop;
 
-	/* Stop the queue if there aren't descriptors for the next packet.
-	 * Since our SG lists per descriptor take care of most of the possible
-	 * fragmentation, we don't need to have many descriptors available.
-	 */
-	ionic_maybe_stop_tx(q, 4);
-
 	return NETDEV_TX_OK;
 
 err_out_drop:
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
index 82fc38e0f573..68228bb8c119 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
@@ -15,7 +15,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget);
 netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 
 bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
-bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 
 int ionic_xdp_xmit(struct net_device *netdev, int n, struct xdp_frame **xdp, u32 flags);
 #endif /* _IONIC_TXRX_H_ */
-- 
2.17.1


