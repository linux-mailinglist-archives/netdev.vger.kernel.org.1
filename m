Return-Path: <netdev+bounces-192412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBCABFCAC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C039E7F7A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5326928EA7C;
	Wed, 21 May 2025 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u/ijTT44"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F381A288;
	Wed, 21 May 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851409; cv=fail; b=r088cIrWp5+J5xB3ytVWq7FCfAQwd9ylZ/rgE8F+A1BMPVwqdDoq8tO/aN1L0zvtEO85rMguWDlVfoROAl92DSZvAXegkCE/AsFsdT4lCMxLxaCFxLy2hcMAfua6ssc+hZGCrtyygijW7lfHg0dMqDjB4cmeqDKkQY5CDaOJ8lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851409; c=relaxed/simple;
	bh=hKJtlPIRRZFZpyGSXP13KtDyqgnIFE6AI+6TguI4tyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OnXLQIXkqP1BoA1DoHCMZ30G0/cK8y4Ou4WSptTkpiF1177u+X40Qm1rLk9t4N+mAyPMC8RrFSTiv5s3FXyOX6eh3Ks2Z8qVy8cXYwmz6jzoowu7pzFmjpTr+VbggcO6d2hKjOyUNDz4McLXyvDfkyuUDD6cy+wI8lw8lt1cwNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u/ijTT44; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3+gxXMymEa+yH9DPNlmajwaackuIdsJZegVr1zJZZqVCMqEctn5an+cfPBxTW490bW2tShtGMeRDHe11B70z2JX5vkvhaRmPVJwXsbkidwtqGC6cs3r60DmZV82yo5xOv+eGZJqPAnYPSKuwqMJK6p35Q2Pr5IwmCaKCQI74+QqqfzpJJ8ud+eU3cQQ892rX8vmLY8oHI/rVbEJsHpQj+SnpJZEv+J3hxwlMVjnGzG0WDWsNg+AsyVAZfI07KdTyT6qMwWwg2FI5Rr/zfSmeUwoAceF/e4DPn1UK+T/4VGfwwZPMW6N/+cklv+V+dl3849BECUJ+7xszvDwzKB+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aeLfJ0PzSr4uq6iXZtu5CQlSKRMHtQfoQXsO7eK7rY=;
 b=P+SkRV2EVzPJrLIPF4AfokPbJ3WCCdjGFEg4eOuMpTvI/37qDmBWFz25p/JSd2+GYcFovZtHwAXqyePyqwPP9vb/jpnnaktFurh13tFGNP6ZghLkWYDRgXCYetWoStuuXYXGLf5Qf2anBqpQnwyWAQ4aFeWZt55PTW16Rn1opq92uLVYh71I0nMMbVreEAoDd5VGQWlpx6yYFoAOCWOJ5ADLyGaA721O5f13lzdJzhZHFMNn08jqpwFQMaJG2AfJYRS4v738Use+gA1lT7OjjI2P/DZ6Bsi3n5G2f13FaiLJdW0Mun8QV0Q1MALXoX8L56YOGqH/52a1MPK/03jruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aeLfJ0PzSr4uq6iXZtu5CQlSKRMHtQfoQXsO7eK7rY=;
 b=u/ijTT44pIbWXKfOWj9L4OGwm1O92z4m6GdCKRre8N7iP4RmSCnTZpTNlAV1bFiDo38G46XBXKXV8sATUR0VVqoxzgxLPO9UhYgHtdN0fXNOnmc/JP7eT5CBYwfawW36yn4FRZc0pthkeZb6G11jVW9kU0pC8prc+z3YyhUmph4=
Received: from BL6PEPF00013DFF.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1e) by PH7PR12MB7842.namprd12.prod.outlook.com
 (2603:10b6:510:27a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:16:43 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00013DFF.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 18:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 18:16:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 13:16:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 13:16:17 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 21 May 2025 13:16:14 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net] net: xilinx: axienet: Fix Tx skb circular buffer occupancy check in dmaengine xmit
Date: Wed, 21 May 2025 23:46:08 +0530
Message-ID: <20250521181608.669554-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 23769f43-d3ef-436e-24da-08dd9893a386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+34K0euIzy0ejXBgDRmffrnXPTsyAe7uNCLaUP1Zv2f0H36gUV5ITRfioBv?=
 =?us-ascii?Q?CSDiaJM/5SE8A+twUsNIwuzVdxWkId7FvLF5s2g8VNRUrlHC3aZ5Ozzmc4YH?=
 =?us-ascii?Q?2Mp1R26XauhYipvMvmbHzvDoY+IGAVDXG8hQ1l72RR6rSx3+F+IhwxxCNrzO?=
 =?us-ascii?Q?V8r5//cTvHcW+mfyWes3nHUSOKkAs0FuMJlRLSHXhYwG/nFJBBefQpaGGoCe?=
 =?us-ascii?Q?yq/njHvyZob5IxT9oxiZvxr6vsj84zsTRwq3KpfNpYP4cRoz5bM0+oH7lC90?=
 =?us-ascii?Q?pykKrWf53Nil0bmIdzQYiqh3dJCMUoePdxztUpz1YL6FQmZWK/B37RV49K6p?=
 =?us-ascii?Q?qMa7RdnUn01j3Fpi6lqRfZDZSsZtILwe5wYZ9O6Xl+qlPXaT0pAaWwB4Tx/Q?=
 =?us-ascii?Q?a6RG2Mh+QlAkpRifiIaEZDdzbvmRmNTTIqeQ788XeoLtTfeBscgUN81srfm6?=
 =?us-ascii?Q?8qh+dFLPEQ9YKhXZnc1hsacGUbdjvwoZEA7hwoKmVADoc2RuSE4YWA24ubK9?=
 =?us-ascii?Q?LKdNdmB7ypLIKSOTPydAfPsBzahhQEi4jy4nc0Cvtvi76IJlDsiupF7ivtWx?=
 =?us-ascii?Q?aEZu1pM5YozT+XtRZ/l8q3TBUFv5zF2qx5MEfAFyjWY4DnVDOiRjAiXu8qRx?=
 =?us-ascii?Q?z+snyKbonAuB0rBnuLx/GOM2nSbL6nZNRLLBfMaTb5T8aEfaF2rNsK9LWDod?=
 =?us-ascii?Q?0ySMg5LFl00jwSpHVeyZUBlDT7blspcjNoYfwrRAfX1a566HBgTVHGvdMgtW?=
 =?us-ascii?Q?fD89cQvjlxNlJeFwmyq7gO5hX9d4rourAVZxbEkdBiKkhGAuUkMz0vSO1V1E?=
 =?us-ascii?Q?82b6gSwhvN9LES77MztoV8RV7mgKt9QS5Z793a5L5JegRa53Gktnzl8tP3V5?=
 =?us-ascii?Q?tb2+OX1n4i8tCuBnzuf/IHXmH+HJCmJ53tcZ0l2rXy4KmVQ6SeRdquQa6d5J?=
 =?us-ascii?Q?R9CdHwYE5zIIFIh2KB4g/G4UgeqY4IxiLAlma5BqgRIkgtPlvLpsPlK957Kd?=
 =?us-ascii?Q?3gRtj4xXxLfZjju3Pq5rFgWesDUiEQzsaasqX2x3S3ORGxXsFuZIeXJcLW5C?=
 =?us-ascii?Q?1x3ITqP5ZPSd1AiuXEOfqT+4NFqDNZdtUfYMuAChNE7Ff5S7iq0Bns3znHhY?=
 =?us-ascii?Q?791dIbue8Xfl7IXSdmOvRY9n6E/gbHQXiFwo2THcepw8ck49RfLW/OfgxD5k?=
 =?us-ascii?Q?sHbNGohVqjKykboj8eS5jpY5T4jhEolmAsT52wACDXQLc0RnIGJ9q5FnPHFc?=
 =?us-ascii?Q?Cd7cEKdNpacMyPfm0ntdy3Vcz+sfdO3U1EtQ0mT2sn149WIrHBughJ6RM6No?=
 =?us-ascii?Q?U8jOLjXi6a8jvq/oSWbt4kvATsJLyPx60T87qLbJZEAc6IetweeY8sqEaK6W?=
 =?us-ascii?Q?YzTPnGvE5UsbDCZjgjSM9Eq/1ULaKJOVrGJ2eyN790i980u/eqkcMZtqB8Yq?=
 =?us-ascii?Q?oF7l7ntj0pAi7mQ+wOH++Q6H89O+j/+T1neowq31vE8EM0inROoRbCt9Mn94?=
 =?us-ascii?Q?T51ji45V3pwwScFjZyGVBY96vsUIvx9193xU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:16:42.7130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23769f43-d3ef-436e-24da-08dd9893a386
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842

In Dmaengine flow, driver maintains struct skbuf_dma_descriptor rings each
element of which corresponds to a skb. In Tx datapath, compare available
space in skb ring with number of skbs instead of skb fragments.
Replace x * (MAX_SKB_FRAGS) in netif_txq_completed_wake() and
netif_txq_maybe_stop() with x * (1 skb) to fix the comparison.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1b7a653c1f4e..6011d7eae0c7 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -880,7 +880,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
 	dev_consume_skb_any(skbuf_dma->skb);
 	netif_txq_completed_wake(txq, 1, len,
 				 CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
-				 2 * MAX_SKB_FRAGS);
+				 2);
 }
 
 /**
@@ -914,7 +914,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 
 	dma_dev = lp->tx_chan->device;
 	sg_len = skb_shinfo(skb)->nr_frags + 1;
-	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= sg_len) {
+	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= 1) {
 		netif_stop_queue(ndev);
 		if (net_ratelimit())
 			netdev_warn(ndev, "TX ring unexpectedly full\n");
@@ -964,7 +964,7 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
 	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
-			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
+			     1, 2);
 
 	dmaengine_submit(dma_tx_desc);
 	dma_async_issue_pending(lp->tx_chan);
-- 
2.25.1


