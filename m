Return-Path: <netdev+bounces-140276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F09B5BAF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574D8283C4E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93951D172C;
	Wed, 30 Oct 2024 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="otEsNYD/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F11D12E7;
	Wed, 30 Oct 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269552; cv=fail; b=YObND7ffMpi4zQmOQZdxRT17DeC6lz0/NaZlOU9GI/VsdrJrm1/l5RO94nM+SSf0VSdjCyXg+S6PbWQxDA8XGW0Pb5gTZCHXjVdlo4TvaNijzcZHwAB9ZTTIPYWh+52E/2kKiZ3R1L9XwVKlu+e3NNFZO1JTE+fL1ld+oH8r3mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269552; c=relaxed/simple;
	bh=M5jqNQm+ZZpsOCm0xyfCSKTivAVzUnZCbykuntpowCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBmLTJEGfUfsYDXDbLCPvb+VOsgtRq7dXNDnmGbp3zG+2gejFDNQDiIhMlZNGFnWH6U+8jaaDh3e+GxZmv2nDoKhO0p4WW9h8FBvgeVCavfNkH1YnuSaw5SpPsBmgPZ7dhi+bQrKEbI1zPvjiMMowvKrJq6+SXYsEyr0P9DOT3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=otEsNYD/; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdcIJ5ii9zYQEQcI/ovIS14ijJLMpkgVNDBkVVVoKK2CbLstxTURTf8wAnBlDBXdTUuNT+n0OU4bBCaOo8VTr2E4n0zxIVPlPt5hhPjuzYG2BOayYw4ZF0mN+zG1y7X5TsQl6PMk9HzhEtJMseM8IfT3NAOun7yMROiiwc6RX8bugCqizw8COGKxcUm8twbV1Mc4QavobeD+HlNAshXIh4asGTO9uDKTjW+qiaJFb6Nc+EmRN8ihp/ryFHCSBALXW4asR+3wg9Lq/I3pB5cEmmTmEa2Rm298R5c2r2KHBtoatZ92eDtrLd6rrmyiiI3bBtj15prLkxD3QRYkFzLryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAfvRsyhNQJwfN6uS2obFxaNXvTC0I+ID34wyMDnLu4=;
 b=CwfQOjpRmZPyi7zB8EjvwQ9WiskpG9vKQT7k1Bn/+emQmC3+JpdYF7uxV0S/JrDE4kP7UVN3BAG1S27C2rmSDMheE6Z4UorMgrrS75UYzUe9dexWw+/0PLeKTZPobS20V/JNLymxG3kNqocls+sXUrJXC+RfyPL/sajaE9qMqY9NFulXtiV7U/GhbQje2gW/3scgdTqFfnHQQQ7186smDcSgQLAZOOJdeOGEmrmvtTfSgEfiIyZrGt6X6LAijWzvEx+JpxvtBzLHSDlIpwbI3TlP/kJ08Bvy+PDHyb6s5pMolgcS4N3DeeRdiwVfaMbyO50IAMXRMN/syUTq0o4BqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAfvRsyhNQJwfN6uS2obFxaNXvTC0I+ID34wyMDnLu4=;
 b=otEsNYD/tJZNpicI/iqWK9S5Y71gKSLLJfVqBqIVVCV93bWNhvWUgGb9IZgRLWKx2eV7FvjItvNG4uGYBDwRBlNAQvwlFmgN38HNtS+6M3LuFDMovfr05RuqoU9ptXavVeA0UAtZJ6IkYIJUL9UD3yO/djDqyme8HQ/79p8v8jA=
Received: from BN9PR03CA0463.namprd03.prod.outlook.com (2603:10b6:408:139::18)
 by PH7PR12MB8154.namprd12.prod.outlook.com (2603:10b6:510:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Wed, 30 Oct
 2024 06:25:43 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::48) by BN9PR03CA0463.outlook.office365.com
 (2603:10b6:408:139::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:25:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:25:40 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:25:37 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net 1/2] net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine starts
Date: Wed, 30 Oct 2024 11:55:32 +0530
Message-ID: <20241030062533.2527042-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030062533.2527042-1-suraj.gupta2@amd.com>
References: <20241030062533.2527042-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebd5506-3204-463e-0122-08dcf8abae31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+UEB0qqHmilLMqrpk7S/oJvwa19cS4mFmNjksr58xFq3NM2RqNQ9AUdraWD?=
 =?us-ascii?Q?Drom8YVnQR7FRsfJlPOUN/ohSeLi6/oGyDmoEZNBY/7fVkG15i16TKduI6s+?=
 =?us-ascii?Q?p+f+QMdXud7n2E9IThoSppP20IbzWv+CDICbcoLpkMaPXyamFi8onZsyIz6y?=
 =?us-ascii?Q?fHDRbOTt7XNAI4gs9QbABF9cWsn4NploqPFF177dgspyOCxZR8NZE7rVhdKA?=
 =?us-ascii?Q?mQogtceAFMhMzAgr5gYb+myEY4fBzThqaf4DYz33JGtDjGrm2OHO+erBdGM6?=
 =?us-ascii?Q?51t7i5tQIfdLb5E72d6agJ6q8lf1PzvAVD4k7kE0jYgrKTEe+asVSkm7nvjV?=
 =?us-ascii?Q?BnqAPFR4r+7gcxmFhNqA7RVw7rYGOxWzf6lM+zXECAGy3H/j0SfSCqxR4WjH?=
 =?us-ascii?Q?yC6H8/sotn/wBUlsEGv5iyigt/dYT0V7XEsA/Lru+WFWH4lfNH9OAtkKof6a?=
 =?us-ascii?Q?Ox76EgMiCQa8PRENiBqzhgSLkx4/G0TWNlBVnsJFnITYWovDfwHWRvET9BvR?=
 =?us-ascii?Q?nc5NLQOs0Yg4ao0Ip7qWbW7J1U6fwbsF/We/4spA4i3JVlZxJuXieuySZG2f?=
 =?us-ascii?Q?xDnGsVOcssBRy+VsKzkbiTPOS2ZSunsx1KQqCQXhnlZUyXws7a4aBoqJ3nSt?=
 =?us-ascii?Q?F+bQGy/9LIQ/x8ffXIUI6MXj3xaPLsnY/T2452fqg+hMhocaZi4zg1A1Zbnx?=
 =?us-ascii?Q?55hjAdJL5sikLsQOG/nLH8zxM4r9eIH0m0/4qsHGekdAdKAvUtjGaHebnqa1?=
 =?us-ascii?Q?ZAnXyKwSdb+n8gBEge5/Q5OwJbcYDGIt2WhaIv2nqFKg1iVy0Smm6MntoWDS?=
 =?us-ascii?Q?lB7Uly8XxkFzQsmBbAiFG87DiIJKLQZvUClr1EurxReuj1UY6e0fehRzEzl/?=
 =?us-ascii?Q?KYMnKlQbYGj2uTcl0POswOrMWVCEy+/sthOIwdA9pTCH2DuV+E7DDfwN0kze?=
 =?us-ascii?Q?62eN7CC0i+1fD1YRUPt40N/xjJnFOoVKLW0BE0rdfoFD9qNZDrOpuhzLEf+r?=
 =?us-ascii?Q?kUHgruuRSfZEmNY8Az84Np+FHM2gp9fQpMEqGGWsMsd/7/cWQmIMmISHtrM8?=
 =?us-ascii?Q?b08NY/Yz8+K1Jd6FE+u9As6drHM1Q2ZxCPnq28Yxw0VI/UFRGAm/FwpHy5v4?=
 =?us-ascii?Q?+4XkeiAafUyyJz2tj9tYXNkjYiLde9RYSMFd3aMYsuaoqKVdJ7e0WDblc0Js?=
 =?us-ascii?Q?K34qe9eM6tUw7knYd8z4p0OM/m5ruIF0SFoFQNPhp10H9m7p0Cxr3nmhOTdD?=
 =?us-ascii?Q?h2DHT8YMGyx/h33HfLt+mPx4zVg/VRIqABi6WBGn8Ktdb7tYVjpCe2DrPrhI?=
 =?us-ascii?Q?0UWxkWyowGk27ID6YkqwWErmpidug3Gj+AjM3zSfsD4pOewOiZZC344HXlvO?=
 =?us-ascii?Q?ZwdxRKEhI7YvVzHSpooTYP7dcfsr6NLNAiB6MHAB4RuDigh+6p0MTWsH+yqw?=
 =?us-ascii?Q?BwDNuiB06+c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:25:42.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebd5506-3204-463e-0122-08dcf8abae31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154

Enqueue packets in dql after dma engine starts causes race condition.
Tx transfer starts once dma engine is started and may execute dql dequeue
in completion before it gets queued. It results in following kernel crash
while running iperf stress test:

kernel BUG at lib/dynamic_queue_limits.c:99!
<snip>
Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
pc : dql_completed+0x238/0x248
lr : dql_completed+0x3c/0x248

Call trace:
  dql_completed+0x238/0x248
  axienet_dma_tx_cb+0xa0/0x170
  xilinx_dma_do_tasklet+0xdc/0x290
  tasklet_action_common+0xf8/0x11c
  tasklet_action+0x30/0x3c
  handle_softirqs+0xf8/0x230
<snip>

Start dmaengine after enqueue in dql fixes the crash.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 273ec5f70005..0f4b02fe6f85 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -924,13 +924,13 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	skbuf_dma->sg_len = sg_len;
 	dma_tx_desc->callback_param = lp;
 	dma_tx_desc->callback_result = axienet_dma_tx_cb;
-	dmaengine_submit(dma_tx_desc);
-	dma_async_issue_pending(lp->tx_chan);
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
 	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
 			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
 
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(lp->tx_chan);
 	return NETDEV_TX_OK;
 
 xmit_error_unmap_sg:
-- 
2.25.1


