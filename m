Return-Path: <netdev+bounces-70054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C984D75B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EBAB23372
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000614007;
	Thu,  8 Feb 2024 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MKmgpFLc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7951E87F
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353874; cv=fail; b=u4ZkOUiCHvrq4AvH54yuRsb72ZN3OI8bCNkopacMuuvf7tUDKMwtpXWDPzxr/XjoV2itpdxqKkSaVrSwmqaATJEHRVpH2Jd0kapIiCfzkgaHmtRoGrmH4PFM6+rmAWb/hLVIhRVvM+MnIC0YsrDfJDhwoBXea/q2RrW8D6EIuQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353874; c=relaxed/simple;
	bh=Fs0l975WyELonGXv1/uXfGeWiur+BfkQjsceFo/K0nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6kcrhb37ivaHUfNL5B0t3R/cmvqJ9byqBxvEenUN/ETQUcmzcLGOVGSckwMzXOiK1KX6c3+D3eIpo6vVvsvWDx/ItOaLiUgaWOz7UiqDpIDdFhi4Z/8xzUhGRYicL79saZB12DjIWGYWScMXq2SgQjCPDhW+/GLv21P/G/ba5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MKmgpFLc; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0tDwM+tEnQ2UP+T1x/iaGcGtqpcAwXEf9ObCQfn2ZsfrsSjttzxKSaLX5j64YMcjP+XydVgVDilsgqIwbquG4B76EPBBouH/mBId38TQxxdrmrYQZYsX7q0ar84Rk6jtTkYdCupEMMTrgnrj5G0V/MqpuHz4UDwhad/XLI2nO59qrsCpIB2xqTnzEA7A7Fj6CogwCxjMYoL5RsgFVaMrkrxfmCJ1VTch6HsgIW/gKjhEKCSYoOWAPePIatHQ2p94uw7mH089bjo3Nv5wFXXt3C6Tjnf/0/o5X4PTYAyOuleIcoiJLP9cwgvcVZTJkiYynltT1hGVl31aoYovZIlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/OkJTvGsorpBZGq3ySQlrRzmk6tGo7Lu5NFRm+AGcE=;
 b=bK1Wne7cyjLpL9ghjz9PeYFC+msCrZQVBpmlvDrhufqUDE+yBi9R3A2dPR2c5tMBdnQG8tCvPO+na3ESpbJeb/22St1SUq1N3zYA9ohO63+Owt/walA1fO3L1zynKSLydyTWzQbY/x+oIxs5XHwDvR7q5wDCY74ZHThHQi2yn8QUbrdIQk3347gLT4HdR9FKos/g23ISm/9veu+yWJYgFjUHrMYOWTlMfvPaLVb83NDA1+09kdbWV1wmqprZNAk3IyMrBbaU6ApL4NEAtI9VosH/gUkbeU+xwBdqdC67wwkuQ/0KRuHS8UPSIKQiksD/GvSjXcJ4iKIPWtKKZ/rjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/OkJTvGsorpBZGq3ySQlrRzmk6tGo7Lu5NFRm+AGcE=;
 b=MKmgpFLckU40oUk6w+h9xomuJCuJrJH4SFLyuBjfoQKnSA4+7coWRPVyYbW2i3sip8Nyr80q4BUNxjMetGXFMU3ZNBKxkZJDgtggojG4hI9qpOpKzbRowbas7cddp/8Mfn15hIpwSrKVFAWTpZ74Ss1EHhLjG9bRXzFYM/+8h0A=
Received: from DM5PR08CA0051.namprd08.prod.outlook.com (2603:10b6:4:60::40) by
 CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Thu, 8 Feb
 2024 00:57:49 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::86) by DM5PR08CA0051.outlook.office365.com
 (2603:10b6:4:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:48 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 03/10] ionic: add helpers for accessing buffer info
Date: Wed, 7 Feb 2024 16:57:18 -0800
Message-ID: <20240208005725.65134-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 72103064-9baa-476d-69ca-08dc2840f8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TktXMh9QFYuu4IYFLAhAa2IGtxd/WK2GU9JrAoyuEvEKEwH3zV2v/Jo5oORNmMmWi7moESqvhwKkPFgQds6n0WVrYp89r484iio8H4yaVAtBwBaNSdlnbkQ7NbXNBTCAqd4AnpfakvHewaKbM9EC+TQskvBBVToGpFeHvgy9w8izmuiHUyevqXEEU2BfodzBrjv34+zaBcl9LudfLZHeR3PkHs+YhQZuTdQhBt+tw9esHlfwjYNzvk6otyphArYE+TI2r735teq606PAxUHN9TI/3ptcGD3GipnOaYyXVmX8fj1lMGtmRaCyl1BRBbPtFuGrXXCgPuQB0Ey2mPIUpVCkENDsoTDqpk+EEJRN8mWBj0IlUTeBFqn/syDgww/8Tl6l9Ul+fRdrLZnDvOpdSZzAgTg7CaegV17HOZHW6zQws9Lsocvil59YABWzR+31h++/vdcb7OUYUuH6bWKIR6P+rm/HDIcruGnSfO6urKcu3N6/dYUz7Ce/TIHlWJLg2Nn72Ay2hjM0DbGRQkFWHUmPsv/UDjCan8YzRB26Z4zhJRQspvrWu3Io2lOV/bK7DP/2pgmIxmI3UAx6R0NDayhgpJfbWl+8wrUE5wWHhRE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(5660300002)(478600001)(86362001)(82740400003)(36756003)(41300700001)(336012)(426003)(4326008)(2616005)(16526019)(1076003)(54906003)(26005)(356005)(8936002)(70586007)(6666004)(44832011)(81166007)(70206006)(316002)(8676002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:49.3922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72103064-9baa-476d-69ca-08dc2840f8aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

These helpers clean up some of the code around DMA mapping
and other buffer references, and will be used in the next
few patches for the XDP support.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 6f4776759863..8659f5a50a6e 100644
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


