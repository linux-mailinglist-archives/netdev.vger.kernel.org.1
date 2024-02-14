Return-Path: <netdev+bounces-71788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAEA855176
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5761C26242
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4496312A153;
	Wed, 14 Feb 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lytCS975"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B69129A9F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933573; cv=fail; b=Mzg7ClubVJcxDNdYRhrT536sVYQPYhiILCuvgfMThoH/3KXzupkYs2Dj54oBtMD0zj7/DHYV8MpySRBSPiBSDrTKNYjXvJ11f4fUqjr8mbWNabR20PZBYo9yqswqjdsUUgQZ9L/El2RmQVCtf2l5aydCMgZapUsvxnJeyzb2R54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933573; c=relaxed/simple;
	bh=AxI13vZKuvW8V/NnJc+Sk/ktITj+sfxd8mO2KLf8zDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIgaYvYyAK528imdhfrgvUkjOHJNvC2jgKfKJloSJI3siXBdD6z7I4y9CI7a4wSbgqwmyRrNaxVjV9k/hy5Rk1+bUXmpjcPMOb3kykl3Gqci14Rdcua9PhORwLTb+v5okTlo3/5TC5TBIp4bLKCkAp3jHktnHUP6i0hEIisIjDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lytCS975; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABM8VmLM12Rt5IwtHL+Zn7WONkBQJ5ZVXc0kIeukQZlsr39w1UuA8hhApcFC4ZbiQJL0BbzkYtM1gzUhtE2MAwfmQ5kOK5lKt74qw9nFxJVQMu5B24G1/yynjtFaojaGSBsGEZksZBO/JnaRqORBQCipkX5Nh0LIIYExbPOua2rcqMkg0mVsvlXxxyBbw6iNWf91fB7UcphKNaf9wmuCpJrmdjaBjmwqW5Pw3z1jXp9m+SHjwJ2f1nAKzLqKzldhPhN+GBfsK/KKgEtL5YGcew2sWVC1zK0yfaL5AMDSLRisMCFVQ6pFxKiXR24fOPLIYxOcrlLM0zB3j+xwIadKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsZbhbZMnU1dPDHAuSYwocUtSoHA3j02ciZhjiW5ZCg=;
 b=QDU4k/76QbDpa+PyVE9vRDhcC1iUwmKaCDDeEjbqeBRHYoIeA50fCLyHPRjQqzm7pYVlSLCfWSnWIFc+hgQ6lREJZvGgSYn2K9DB0nYHy2QsdY8lwhZhz5WHjFqZgD61AVqk+tOlh/ryu70UljjfrNEelvun6LBM+8aTYoZejw+YIIYGdmK3rzFEgeLTPNJmS9YHv0IiHF9yZpsG1271hm4askxpPhSAefmbsV5cR8oMCeBVkaxISJGQCVu24XotuxAovGtZWnxBZQDzmR1DK64WA7YhUNAEzaq2NeAo1O+dUjuJMa+H27Crh0wAQ5/+Ny7mpasTVRC3fM0stoxxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsZbhbZMnU1dPDHAuSYwocUtSoHA3j02ciZhjiW5ZCg=;
 b=lytCS975qq02mSpoEeUdX5oq/Yals4k266yKhvmmBjJE4EVprij37uW1epI3w09kfaHINjSrXI++jmXINWqoZur/hU/okznEctfKybTrTQSkr2cMNZgw093VwZl8YfETln4kL6fy5LG9dSFfc3WTTmNbPVls0BSWR0r+oBqL8SM=
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 17:59:28 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::ed) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:26 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 2/9] ionic: add helpers for accessing buffer info
Date: Wed, 14 Feb 2024 09:59:02 -0800
Message-ID: <20240214175909.68802-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6d1e9a-886c-414f-d3e6-08dc2d86b021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ui10VA5vJM7BSQVDVsXg/DlyKpfugnbs9dZFbWrwqwo2uBxkyIoNnckKa4DvMPgRIfUBKj7LO8EgeViAPzz4DspkDQo2jAnO4B210v2cUUOJ835BFrwYFwY2Lk8PdTm10fWi3MwBu6w8ZkasagG88GKZGbNofUhzylFRycnJ2J44rBXh1Qw+lTpNmVg2xaogtCgFusCvcJxbYt+EDy/WNWN7BlzyIiLb/fKJRcn6fP7bjkwJk9aA5cAiWYGwlRJkzeP4l66vxRpzbJ/I0qjgF3L9wR3p/S8p1yZnYXAkYNqz+z0eDDf8uTovvRqrtE3gzQ2m77dWrtccLn4quvkArl/w4XgftblJG30N7i1zbOKTW4TvJLYHDviLcL0EZe6rQzmQ7iiznkgrp4Y2A6a0M+j8F23iR93nmDUuvEPRsfkJtQbG+mkbhk3O18zJRAtyprIvQynyEqun/gOWoZE4O1wOUf4bb5EyEhbfoq3YsALSjnjsyY/HBX182JAhkH7kDMgopI9cKzX4SlCmKeguyRpUAE0TuNvvUBkbtYs1xejNaeV+Eln3hVGupFrmuA0Xt9l3bhkhBwajQ8Qn7GNt1gh6NxmRjGJpmQ5M/ME3HQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(86362001)(356005)(82740400003)(81166007)(70586007)(70206006)(478600001)(110136005)(2616005)(1076003)(54906003)(6666004)(336012)(16526019)(316002)(426003)(26005)(36756003)(2906002)(4326008)(5660300002)(8936002)(8676002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:28.3173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d1e9a-886c-414f-d3e6-08dc2d86b021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

These helpers clean up some of the code around DMA mapping
and other buffer references, and will be used in the next
few patches for the XDP support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 54cd96b035d6..00d703c027fb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -88,6 +88,21 @@ static inline struct netdev_queue *q_to_ndq(struct ionic_queue *q)
 	return netdev_get_tx_queue(q->lif->netdev, q->index);
 }
 
+static void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
+{
+	return page_address(buf_info->page) + buf_info->page_offset;
+}
+
+static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
+{
+	return buf_info->dma_addr + buf_info->page_offset;
+}
+
+static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
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


