Return-Path: <netdev+bounces-64270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7304831FB0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530F51F29AA0
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7022E632;
	Thu, 18 Jan 2024 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DfZagepr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C32E413
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605929; cv=fail; b=DWT0FWBugUgosYaTzkatGyt+UvyBjIO7uEkT0ymhJZXhgADXLUTtVwQaVIJ0hbl8heq93X16xWqX8qH8tbnTdpHS4bseWN+UOYDMfkAI6gURKaG1++LAVHxh8VXo0hhPVU5W28/d4KN55MqofP1FiPWmGQF3Bpp1abdshYyO6dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605929; c=relaxed/simple;
	bh=0wIeKF9Dt1bKwFHXNxtRsnn73s3kJFATJ5BrI5qA6D8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ir0UIS3WdseRuFr5ln59R+/TRvc0b8z98Gp2kUzNL8AqVWYnrFB+GtFU22LADAQpJTTVb8c3vwMWZbxBm6weOWA5XH0Ft8i2kZmjtI1GFUs5Vh/r/6jjLjdYDeSsp1o7igXHb/9Qu+Oap0YZPHPK7bFAttPP8+rNsJkHPyTWITA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DfZagepr; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNBlc2fnXwew/2Tb1KSKUevdearjKUNqnQex/lMgY2GRKW6R/Ye6wxafj7jztD76B4H7VY9gaQO9PHnl6T6KKI2bxpj9xTexmiPghWD1ZxZAUQs+7NG0JPFzqWAQ8KkOgZY1JFTppRVnViWCu0WAFkMbvdTH73NJ49E4pQmK+YFZNSC+itihxb37hpl1mAnnaiJVZ7MQbtAdOM4I7smZ4EY4Nvo6J1+OSxXpeX5SClNJXY2WmJ4zllJ9CgtEFY/eSnzA+S5GIR3cbTN4A7SoSaSzuPkWDR7TVeYFaeyCPdbnSbQT68N1mo6BwlqOp/hGgcdqdOKMA6CcRMmsdKHWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB6sc+32yCgiNi4g2j9bFkm4E2q3QAPB3kdRX/SP8G0=;
 b=VZT1J2lT3Qnzy6Shr9ETXja2KbBmvgTys8aSA6rZgyA/svtPn6NO2Zg5EGBLNqx+Kw9T75brI4o09vLYSoMxBJ3gtv5jJfH+dwzFsS/MpQuz9i39UIZa5STIjiuTB0MUeOS3FNuvhi7mplZrB8IBhS6X2t2k64ZIf0hwyZIHKgplBcUM9oi3XwqjLSycnTOkvphDfknCbiXcuvfTfBwEG1/4eBZS0s1BB2S25DnVTqWZKVMINk2bJ1GGYnYUMQhQ+71gf+ia+NEtDHnHbOzhnAcg772HF0yrjDfjZgUrdsORaMrQSgScxGs0Tdu4UfDX+4imwm1Ck8xZZCOoFUHD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xB6sc+32yCgiNi4g2j9bFkm4E2q3QAPB3kdRX/SP8G0=;
 b=DfZagepr4K9H+pnTX3gsH6UYg/FIs/vDZWT+0Gtil9aI9Y7/OPeWkhKCjV8VeKCyQRY1prbtri9FnZfui5pK+5kN4PFQHKcge7NVmHsAh0Ta5rg5XUd9PMZSld47oQMqetaJ6po3IyKw9JAqiIBFbSA04lziQLuK/rJUyNzjqHE=
Received: from DS7PR05CA0086.namprd05.prod.outlook.com (2603:10b6:8:56::7) by
 DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 19:25:23 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::52) by DS7PR05CA0086.outlook.office365.com
 (2603:10b6:8:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:19 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 3/9] ionic: use dma range APIs
Date: Thu, 18 Jan 2024 11:24:54 -0800
Message-ID: <20240118192500.58665-4-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 82995df8-2398-48ef-a3b4-08dc185b37b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HWVut9i4wsLey+YqIhcn3ViBxkvIaIrjJCArMWiL6fP2YO9wNmkbYO9KbS2iDsrx22gD5PTmOwCetLVYxVlLRAtqIY11CLgf1l3GgTweaO1Q0F6LqRN36HRN/+SFLmSUkMFFbLY66fG9oxfjQ445PJOplPKfjAkTB3X3/ekABy60uZ3J1MCK53hasQPlPxK6MYdV9ISfLDbS58TSsEwBO1HpxnLJYgQ72IkyYrPz2u4ssebGzceYbLGtyw6eBBjFbY/wvLgOdTCVIJzps0TJFAjPomVJAOe+emrrg3B7P1RJBHYpPJ3t33ftXW1jErh/mzpspM0N65yEwUGaQbV6TmxDsCJ+YNeBorTgZuWi3zYosAt65OEynoGMkwEjAI9CHyLt4LAo1yYkbvFISa+D8Zv4vpgNSyDKgHEl8BkeoJJu1sXnOZS0tnIZgsd/Rgs8Q4M8C2K72SV0Vf+jJIl71CfjzUzjS0lZd4u/1o22weS4+pcfCxsc8jDavACrtWUOkicmOZxn0s5121BVh/zveQrjxMaMlt4EwbEdSSq13M30FwarZoi6ND3ELk5CH0KrPNObhPcuLsS4X/Wflif8OTc8YuapPvo3ITaN7NCSqtG1pQ6vZgm0S1PJ0E8QGjuEnOMljpv2vWMqV+ZxwW80ssBu+peNm4pjTfDBbzQx1OsyGNdx0gpddesTwSXc5gXE2SirVNE2JvkMfVX3JiFIXp9BqkjuEmZP4Q0IvYXuH//JFZMRrTeg5ixjVoeTRZ0ZlE4hEk0FEVM4Rzjk1LhJdA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(81166007)(356005)(41300700001)(36756003)(336012)(8936002)(8676002)(83380400001)(16526019)(426003)(70586007)(316002)(54906003)(110136005)(70206006)(4326008)(44832011)(478600001)(6666004)(26005)(1076003)(2616005)(82740400003)(2906002)(5660300002)(47076005)(36860700001)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:23.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82995df8-2398-48ef-a3b4-08dc185b37b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

Convert Rx datapath handling to use the DMA range APIs
in preparation for adding XDP handling.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 19a7a8a8e1b3..aee38979a9d7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -225,9 +225,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		len -= frag_len;
 
-		dma_sync_single_for_cpu(dev,
-					ionic_rx_buf_pa(buf_info),
-					frag_len, DMA_FROM_DEVICE);
+		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
+					      0, frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				buf_info->page, buf_info->page_offset, frag_len,
@@ -276,11 +275,11 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 		return NULL;
 	}
 
-	dma_sync_single_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-				len, DMA_FROM_DEVICE);
+	dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
+				      0, len, DMA_FROM_DEVICE);
 	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
-	dma_sync_single_for_device(dev, ionic_rx_buf_pa(buf_info),
-				   len, DMA_FROM_DEVICE);
+	dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
+					 0, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, q->lif->netdev);
-- 
2.17.1


