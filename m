Return-Path: <netdev+bounces-70706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B301285014E
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392AA1F2A4DD
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DA23DB;
	Sat, 10 Feb 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pJSjmWIo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92141FC4
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526129; cv=fail; b=bBGA7edtbCBb9Glmqhe5jXF+BIAlkrS0iPCagBYRPFtXXRHRCELoO2oZf6zVpJL9pCPUFjGZznRLyY3YWGhLnEk67C2t+WzRvMlVozkRRVtriWzhkGsFgJb7p6gNdPyKtF4+LOv6avmWWgPTnI9YOVgQ+3/AkB1xUG/opMxxsVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526129; c=relaxed/simple;
	bh=lWDGnbS1FTTXWpk2PdUmHkrkgUP8JB6I6uT8GULCVDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gB0T9wFLP20FWAh2KHovX0+O12IlFbkODNOjkrQCR1J0e+IYQQaqtF59cunzOQiuSwOn+iMs+pQ/BJ404LKCjXNBAIDsfo8zjzbMRH+zWdEAxzFDJiE1Gj6iE9muu5fII2dWZnyCtTo8ipB4kTdfW011VJLcXMJ9aCfHTbF0v9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pJSjmWIo; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqHInJhGXr6bvzErcX4FGu+eLjC+05B0Rs0zf5G+LbT1nQsw7jXsvmBnc56zG+ElVBoqaCWv9PNA12R0xMOWN5bH8rcqXkjqblZ///9005QtqX5wjW6Bim58qmk3klLx4Abwaw37+PQXhSQ9u8n/WOjnCs9x89EwIY12wyzTje5KBBEGHq6Sws2GqluEg1A+nipqUORrtT3RjXW7x69t6mvc/WZwKMMUwNmQ6Wowf0FHDcML2F3tsdun490NAxYgkuFeQcu0VTv+VB78dOmKkM14Mz8/pqLL4B+9PnX6QIK8azxVx08y3FNoy8L/phh+/sN4yr5N42YaTDLKZhTvgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUSQpzRnCVbNb5Ytaw9j0PoH+GSYHmNqWFbNvT28n7E=;
 b=Sd9GlC7laAiEZ6Zux+h+ZlXk/layBmHpUwN2LnLPVVMSqhreyClDzFf40NajD13oJlEhxc+1iMl75dpyDoG5ou8xe8NfYbUVhlhsRL6F/BEBF4RMvCg/TBnubQmM/Z6uRpQmu2Pmr7MRMw27FoeXIE2vJDTxb0ZM/F+djb9mra8zKqXzoLz165xt05IEjO7XDI/ApVjCY1aPNflJtk1DYkHVZO/sNFF8C+HaYGdKKr86xNKjYSAVa3dI3jV6Ml4EXzOkxIrBrAqW/TusMncNu/B4RvCfc/Jan/0n8pP39lhFsVms1bEOF1eNJxEOOIlqRaNEV7mZlnhbkU7KB+/IOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUSQpzRnCVbNb5Ytaw9j0PoH+GSYHmNqWFbNvT28n7E=;
 b=pJSjmWIojBLTN7E2yPlRvEy19w/c94mjPpaZs0mKOPQr8/WWNMjSUyKY6PL9088r223e5QQ/M5RPuMS6W46uRq608ejMhoMBp1gTmP8y45GHc4Gponya/rdLTs2mpAWLSYCuT2dug1QW2FMhfSobQn2dKr9IzePWshV3ewp3IxQ=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Sat, 10 Feb
 2024 00:48:45 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::d3) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sat, 10 Feb 2024 00:48:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:43 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 2/9] ionic: add helpers for accessing buffer info
Date: Fri, 9 Feb 2024 16:48:20 -0800
Message-ID: <20240210004827.53814-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: d44a86ba-6041-420c-22e6-08dc29d208cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oH6SA1Qy8EELcn0ZHHqsstko7i6Nx8oHiDc73yPQwtwzpxKuq5lbKg45woDXrSvDDpcbmGyUC6U4AyG3ZIjn4XlDCFJCDrqde6n9GUbqGlNb10qzq8pSDpLMO8SV+4zP79DDxkKT3zcdu0rnn0PiHOirogzijFW+QymRmC0Ur0U6zyYYDMpgH6SUs5zu6XOhVIUyPI74LkNeUCfh1ENNpRHwl6IRJsr4GhjVlc0xUySkOu1k3o3Fzi7vJQhFLtLN3AJwuf/xKiiEMUrVaEqFzfDKIn/h4/EKVv/S6Kv/rgdev4J5X2eQBBfys4uAr62C4TDLCo9F+OYIPxv9NusKGSeW6l5zBoBtis4xT6R1PctcXMFP0D+PpFXUnrVIFkrK6XxiWLMsj2cbs4GJ/MQQ0urf9QN0252iprVx5MKCCH9VbG4iQt90Z31hji9NEDPGrB8nG0fMC/G5JrLl1rPbPUNnOrPutEKlVFcum6RXSknx/dOBXAEQNggMH3Dub3vJlGw86FfG5nfb4pPAukhIYUD4ItN9SkydOv9Jr0l/thstF5dTV29/KF9MZR/HDxWV8eE/hKH5mFFWH3mxoB2Io7hNc1BY3fzPtEidN89Z5OM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(81166007)(356005)(6666004)(86362001)(83380400001)(316002)(478600001)(26005)(426003)(82740400003)(336012)(1076003)(110136005)(16526019)(70586007)(54906003)(2616005)(70206006)(36756003)(44832011)(8936002)(8676002)(5660300002)(41300700001)(4326008)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:44.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d44a86ba-6041-420c-22e6-08dc29d208cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

These helpers clean up some of the code around DMA mapping
and other buffer references, and will be used in the next
few patches for the XDP support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 54cd96b035d6..19a7a8a8e1b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -88,6 +88,21 @@ static inline struct netdev_queue *q_to_ndq(struct ionic_queue *q)
 	return netdev_get_tx_queue(q->lif->netdev, q->index);
 }
 
+static inline void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
+{
+	return page_address(buf_info->page) + buf_info->page_offset;
+}
+
+static inline dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
+{
+	return buf_info->dma_addr + buf_info->page_offset;
+}
+
+static inline unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
+{
+	return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_offset);
+}
+
 static int ionic_rx_page_alloc(struct ionic_queue *q,
 			       struct ionic_buf_info *buf_info)
 {
@@ -207,12 +222,11 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
-						 IONIC_PAGE_SIZE - buf_info->page_offset));
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
-					buf_info->dma_addr + buf_info->page_offset,
+					ionic_rx_buf_pa(buf_info),
 					frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
@@ -262,10 +276,10 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 		return NULL;
 	}
 
-	dma_sync_single_for_cpu(dev, buf_info->dma_addr + buf_info->page_offset,
+	dma_sync_single_for_cpu(dev, ionic_rx_buf_pa(buf_info),
 				len, DMA_FROM_DEVICE);
-	skb_copy_to_linear_data(skb, page_address(buf_info->page) + buf_info->page_offset, len);
-	dma_sync_single_for_device(dev, buf_info->dma_addr + buf_info->page_offset,
+	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
+	dma_sync_single_for_device(dev, ionic_rx_buf_pa(buf_info),
 				   len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
@@ -452,9 +466,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 		}
 
 		/* fill main descriptor - buf[0] */
-		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
-						 IONIC_PAGE_SIZE - buf_info->page_offset));
+		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
+		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -472,10 +485,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 				}
 			}
 
-			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
-								IONIC_PAGE_SIZE -
-								buf_info->page_offset));
+			sg_elem->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
+			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(buf_info));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
-- 
2.17.1


