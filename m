Return-Path: <netdev+bounces-78182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 511448743F4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC9A1F2185B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B4381CF;
	Wed,  6 Mar 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T6/v0FOh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4E241E2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767834; cv=fail; b=PBrNFcGkNACgW6Uvta0+E7x52epYrXiu9IchcJh8bZxbZW6oA5iY8hw4zsD+3e2L00HadCLibQVBz56raFTCSkcu68QzX3y+jz+rKspFYcRQ3KnArXqe+40wzIXZvtrTeU+3daKpWMlAO1rhPspB1xDkH8wx2XTSOvpsmPFc1zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767834; c=relaxed/simple;
	bh=W2kdCW06e5WjxthiM1lhwLwB54fhEDalRCQO2utvrrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6VjU2eo2aWkUDhyug1jAd2QKl53pFbP0xK0IBjbz24OHaxQ2N4TiFy4VZVc1igXNMZ9mbp3ZKRR1k56mUgVTsjpsZnNmMsSBu48eBji4M1uclxkFDX3rgq22fRGjpnlZef4SBRXXDtSwnXkG1ahA3di0if9g7tbRryrWm9meAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T6/v0FOh; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaDA87imxbHjVcxX3djz+ybftTR7E+/0zvSJ88qQNdfCVuB5fgbSCyjob6R1DgcdHZ41EGt4V28LK1FgLCh5ATmAFf9jU1gmQal0AxzUzNLOGTjziciS4QIM1KS+BN5bKLto49Yn0crIXvocBHDCA/mGjZLV/HF4XSFCiMAqcsR2tnToU5lGfwejcHLldxIgNFvDeZNH6YUZYTr99pEYAcYyMm9nZb4DjvxPzKgg1b/qhxgUHWU9V3ZH8FCyB7JOghteEanlFxsHy1ga3YAkXB3VFFLvhHoZUKmNMBrN2bobf3mrBvn95ywzqI/ENcPLar3IvbhPuBqU/yDX03A1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sRXtFuKbG6UL4iKQv/qAptoKDd6Bn2s8nXmWNK49Gs=;
 b=Z6XeDae5rjWD9RszrHg+2R7mthzvEB7dxfeTNB68C99kT3GxMsPx8G+mfm40T7efszNGSAuW6f5MFYJLDOIoyIaPpYl+oesQYDYO3Ck/ZIuXAXsHpTTY/1kNYh+Q/KoGLZWUapVDI4b8q0Y+QnpDTCXJP/5KI7qSuX9AReWVAHK6bbppsCdInXsCyAf4ThvwRhm8W+3lnSboDQumIxzOeUKXkmvZnenKFJFzmyNm73q/oYMt/UsKH7YJ/O72iKiye354YA1OK3xdFvQkIoE+nAns0FvwJtStV/m19Jl4xtGXz2WkrPwnTSkkWH+5hyhm5I1qVg6K7D0qrHlh45XfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sRXtFuKbG6UL4iKQv/qAptoKDd6Bn2s8nXmWNK49Gs=;
 b=T6/v0FOhYUAe10HY7muZ6go9n9O+xwCxK/GeirsSD8sKKoLzBUfkwymTHY5YbtpZbIiVNiVlqOdNDD5J7m9Cowei+OmUvmjzB/Kiah8PB/I1IoLWIPVI+piQd35uQoyL7FTjXT7yhOrv/mfWslA9qA8i5R/3Xaz4hto7H59y5+Q=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::64) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.25 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:29 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:28 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 14/14] ionic: keep stats struct local to error handling
Date: Wed, 6 Mar 2024 15:29:59 -0800
Message-ID: <20240306232959.17316-15-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 806d1828-1c2f-492a-c5d7-08dc3e35691c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rDh7MnwAzvd135JBRItFmZ08YF385y/sulqiIAeMtlhGJcqmYGvQShNBR0wV7SuW1Ub9Tblm4mvVRQQcYXB72sbcmQSoklYYv+MrYFzFU8R6UBHoTHYC2137SrTMH06vcgDSvdwGPSixK3Onawf0jXuiO0In8pZTv9QqtPyWA/HyJYBcuX/ajN40wKd4ptej0PrUK+SGW/n5HbXbDHHtPk9CFsFsVGkDwcuI6qIq3J1BNvcssSUVBewL3ML57MWbAY2L2G7cAmFuWm77ZzqQhiO1iiQNgHTvqKBxrQf41C1ECkwqb/VWGlylZ0VV5WWPLTZVSJ3U0inZWKfJQqcRbCQvDpZhnG01d2liaVkvOZgNo0Dq2tUdXW7B3Ah/6y6E/nLjOdRV0wuhHCGcsHAk5nMWMfjf1hmP+RnEabhk9KnUM9u351OWdjKqUgZN7OMDXIFZk7IL/hkE98jTLsXRJOPAVhyyGpk/zNpbR3RXhUKNDVYJlWLKoby/QnQGZLe+l3hLZrLtOSt6xFDaVjo5E3Qh4XguyqNIBFKswV9y1ABCMzf2PmxVZZbQ8L8YfetuN6Xqg0vY3G/43m42qlpy5q0b/YCxIohLdyaUdmJYMKCc1M3HigNAUWhwfvgeGjo+70C0jJEy6SBnT3kLFqgb1wQRKo3gBau3AcUhAEqVkaz4ZLxL3QEZlpYFpvySE6IVDWPv4+9quwNXSYONOFFpBdd0VDDZPzhZ3W3wzeMeWtdT9HNxyXY01cF4TU47npZO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:29.6825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 806d1828-1c2f-492a-c5d7-08dc3e35691c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

When possible, keep the stats struct references strictly
in the error handling blocks and out of the fastpath.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 30 +++++--------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index d2c930225c50..5dba6d2d633c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -128,19 +128,15 @@ static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
 static int ionic_rx_page_alloc(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
-	struct ionic_rx_stats *stats;
+	struct device *dev = q->dev;
 	dma_addr_t dma_addr;
-	struct device *dev;
 	struct page *page;
 
-	dev = q->dev;
-	stats = q_to_rx_stats(q);
-
 	page = alloc_pages(IONIC_PAGE_GFP_MASK, 0);
 	if (unlikely(!page)) {
 		net_err_ratelimited("%s: %s page alloc failed\n",
 				    dev_name(dev), q->name);
-		stats->alloc_err++;
+		q_to_rx_stats(q)->alloc_err++;
 		return -ENOMEM;
 	}
 
@@ -150,7 +146,7 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 		__free_pages(page, 0);
 		net_err_ratelimited("%s: %s dma map failed\n",
 				    dev_name(dev), q->name);
-		stats->dma_map_err++;
+		q_to_rx_stats(q)->dma_map_err++;
 		return -EIO;
 	}
 
@@ -233,13 +229,10 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
 					  bool synced)
 {
 	struct ionic_buf_info *buf_info;
-	struct ionic_rx_stats *stats;
 	struct sk_buff *skb;
 	unsigned int i;
 	u16 frag_len;
 
-	stats = q_to_rx_stats(q);
-
 	buf_info = &desc_info->bufs[0];
 	prefetchw(buf_info->page);
 
@@ -247,7 +240,7 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
 	if (unlikely(!skb)) {
 		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
 				     dev_name(q->dev), q->name);
-		stats->alloc_err++;
+		q_to_rx_stats(q)->alloc_err++;
 		return NULL;
 	}
 
@@ -286,19 +279,16 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 					  bool synced)
 {
 	struct ionic_buf_info *buf_info;
-	struct ionic_rx_stats *stats;
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
 
-	stats = q_to_rx_stats(q);
-
 	buf_info = &desc_info->bufs[0];
 
 	skb = napi_alloc_skb(&q_to_qcq(q)->napi, len);
 	if (unlikely(!skb)) {
 		net_warn_ratelimited("%s: SKB alloc failed on %s!\n",
 				     dev_name(dev), q->name);
-		stats->alloc_err++;
+		q_to_rx_stats(q)->alloc_err++;
 		return NULL;
 	}
 
@@ -1064,7 +1054,6 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 				      void *data, size_t len)
 {
-	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct device *dev = q->dev;
 	dma_addr_t dma_addr;
 
@@ -1072,7 +1061,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 	if (dma_mapping_error(dev, dma_addr)) {
 		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
 				     dev_name(dev), q->name);
-		stats->dma_map_err++;
+		q_to_tx_stats(q)->dma_map_err++;
 		return 0;
 	}
 	return dma_addr;
@@ -1082,7 +1071,6 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 				    const skb_frag_t *frag,
 				    size_t offset, size_t len)
 {
-	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct device *dev = q->dev;
 	dma_addr_t dma_addr;
 
@@ -1090,7 +1078,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 	if (dma_mapping_error(dev, dma_addr)) {
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
 				     dev_name(dev), q->name);
-		stats->dma_map_err++;
+		q_to_tx_stats(q)->dma_map_err++;
 		return 0;
 	}
 	return dma_addr;
@@ -1742,12 +1730,10 @@ static int ionic_tx_descs_needed(struct ionic_queue *q, struct sk_buff *skb)
 
 linearize:
 	if (too_many_frags) {
-		struct ionic_tx_stats *stats = q_to_tx_stats(q);
-
 		err = skb_linearize(skb);
 		if (err)
 			return err;
-		stats->linearize++;
+		q_to_tx_stats(q)->linearize++;
 	}
 
 	return ndescs;
-- 
2.17.1


