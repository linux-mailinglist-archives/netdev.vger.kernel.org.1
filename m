Return-Path: <netdev+bounces-64273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC688831FB4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8461C23649
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AB2E65C;
	Thu, 18 Jan 2024 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PkaI6a7C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3A2E40F
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605931; cv=fail; b=lSRlJrpf0S0EdvJbL0Ggspu5bXq10EVmgVJgTfXTPsBG2WOsTnbDhxAezO9HYORue4Tou294EI8wLRO6xuGSXM5qVQhK1Rk8iYr2TEBzzG+CLCHv3oOYVWRmXR+BxG8iW+MVQZ7VmyVWps5zkQoiDl82Em78HAkm2ULeJKKFdec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605931; c=relaxed/simple;
	bh=iL5lXyQWAEFKMD1KCjiJfwYmdVvwvQxMEdCZgH/4mMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hih42pOlZPh1hh0gSboe2ZF5tmpTSsXsyQ5QSYHNcdisCWdeEWqNV3dGvjFnW40Yl6dFhxvU0Btz8nRrD+GpdomdxQ+z9aqciyAmWsEIGKoPLfvM8xF2KxgHIulqBFtACxbeqSbjQL5GHFTChB83bvlO3Rirx5xCNmDZJRuw1xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PkaI6a7C; arc=fail smtp.client-ip=40.107.212.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOjdJKfKRGmjv26F7EIdXyJjc+xScBBtWFYazXSF68s4QmZzCFi19tNVYLimhq27mheooN4oEh7PCoM2I2KdsEUdDaHGL6Z6bQ7RZ6Iu65+yybzcAitcYELSbxOVREikuqIpJAl03YlPz/Fh8ilM7y8FqwAHofdBjVxiSF2CyfPeTvOb0ssTDk9bX0RpkvQITtEsVZL7YJH5VUbbBWRC6L6g7fTElAUE7XvaeaJTuwUv9dx1ZM7NBt3RWx/ZkGt66hNUc6Cn8l1UcCeuIu+b66HBJtaW2EoW48ewVy+shY4iZBphNyzoCWt3oCTk3rYj5d77m8rVU4j5I4+phNpE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t301f4OhCMUG6dYYrx2rgTmyo0jKwpEP9FVmIjeyQDU=;
 b=G3G+iH8FipZJmZ5NLvJMKzaitUBZfRWg1qnWITRckk+h8rUPVZPY5iWAeF9sn/ivOUHRi+QgRak7OfFupfcibF3ntHEv6OoBu5zqamX3KtnVxM+C2RAK6C9trfs2T8eJglnNklT5ZQa+MwN0SyrCIdExwg3yufMF4FyJm7QAzapoTbf2tKEhjBa+EKDSiZIsqcUfMp2QhjrbeiREF5J0LOZuivuT9KpvxgEKm6B61BmBYrgjoZYBEBE9vtFd0XvRiK2djUeTDIbLosfufJ6Uj/XftOVaesTB/c7eSx7TU5vVYtzBw8I8LT+PAQJxvZsivkYUjrcx9esfawZ225+fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t301f4OhCMUG6dYYrx2rgTmyo0jKwpEP9FVmIjeyQDU=;
 b=PkaI6a7CmAW4gFpyXLFQTm2mS2CVgTh93scRgQPr0/HGgE4J8uHVDhJfikIjnOk1Fgqgn+sBng9kLLRuW9/4MLESZcFjtGG6ozYs82I3oXucXebdqhSij9CP6OcSedWIL77LnzhsKRa9Hv0OcAraaQOkBqxgQ8C/k/AWxLVskhc=
Received: from DS7PR05CA0098.namprd05.prod.outlook.com (2603:10b6:8:56::8) by
 IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 19:25:23 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::69) by DS7PR05CA0098.outlook.office365.com
 (2603:10b6:8:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:18 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 2/9] ionic: add helpers for accessing buffer info
Date: Thu, 18 Jan 2024 11:24:53 -0800
Message-ID: <20240118192500.58665-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240118192500.58665-1-shannon.nelson@amd.com>
References: <20240118192500.58665-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: d360d7de-2f99-461b-8138-08dc185b374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wWXwiKMuFbcwo72hCrO7A9sZ853oarlJW6Oj0X/KuTJ7UIeD4QqSSGtNJ2BTH5SKrDGeV4W3kDDly874Babz7BKY+lX9VPBn6QVBhlHQqJslbC010QWakH1EkqKPBSrgzRBy/Y2ULYOZ5KyFv36KSjPEwGoT3/jylanaGj7HNeOGOqO2zO+o5ec3uU3qpxU6jeTUMyPYaHChUf60wWfzjEZFe01GTo4Gp7paLjz0btrXH05QoOKDhr+gBamp7lh1mzjlO8OTV3jhSJcRKhg8SBwmRNlQgsoLR8FCJUiWgBW99hjuMRN90TK8HROA/xkmcYilTdqguSXSMl9WdKhJiI5jKrNus/wo4DciONUfDNfij68NzB7wtBPtGBYQR4LmCjk48JBEp5I/L/NWDfUk97kqIwRmtZHFqzadF6sZ87uNjXYXGPOAEApIzYs8BTADgVKsYlggea0aAnIgKuECyT4yJG5XWtxKv97Uu9PDKCwP+i35GXYzZbL1eRmg6KXFM3cgb8EkrxIqvSIpRsuVUfhpuiNMg18IoVDing3o5KD4CI0psYyVc4JUduxKKVuHBv4CiJKQRDw/Me3s+M5xaW1XpOdM7xQqfJnTVxAYt3trv6sSnpQ7LOFdxDDPoMWf6uwZfpZfsg4ZlRrU4jSNWoSsFl4bnfQF+9PF92UBj8AB8wM8yC8K+sMk0FT+yqtNJ/9vUAENKD2hUASez83qDunKND/BtOPwTlCFdphyI/DxZaO1z10/UIIFVl7xpO58YrX/uehpCAm4UHHOVCKdmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(8936002)(6666004)(8676002)(4326008)(41300700001)(16526019)(26005)(5660300002)(36756003)(1076003)(2616005)(36860700001)(336012)(426003)(2906002)(86362001)(81166007)(47076005)(83380400001)(82740400003)(356005)(44832011)(316002)(54906003)(70206006)(70586007)(110136005)(40460700003)(40480700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:22.7968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d360d7de-2f99-461b-8138-08dc185b374e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639

These helpers clean up some of the code around DMA mapping
and other buffer references, and will be used in the next
few patches for the XDP support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
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


