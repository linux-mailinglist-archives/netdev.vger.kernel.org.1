Return-Path: <netdev+bounces-140277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FC9B5BB2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 07:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50A2284402
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DB1D0F7E;
	Wed, 30 Oct 2024 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kToyckQA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD20D1D0F54;
	Wed, 30 Oct 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730269590; cv=fail; b=GHsuHS3Al7YqHNH+mgw00im5X+6dhF4FhehQsFYb5r0FOOX3O687g0KjKUmvcp/k/K23r2UvEU149PjFkR5NlA35dQPYbADc7NQ/OegCeI6/Tt42OFOZXZn11vX9DHoayqHNECBt8F5EyaNI6u3r4ghqrSIG7rHX6Vk7Ro0U6+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730269590; c=relaxed/simple;
	bh=Mb7VxYZ+6i0pMmBrvQep+akHHG+1dB+wfkdFS0yr+M8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuZ2/Q6Gbimbx9EUExqfjhikrrbJqCas53aDPZSQ8y4QfeITFsiuRaL5tnw+X2KW/lGGt6/YMwBxQtE06Wy/Jxnw+wy4UK9yLgkpMW8HYs7V8RvjXVWtlU7VpxVQJxyUgNw1BvaKt/4xVR073AL//4gvhqaCUwsBDSc3EG47Mzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kToyckQA; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J74Gflkjsgs077tMnWlxXOkL/Ns1eXBnGoS+GNZoDOe563BaZjEwJB32DMk9PAxCE2peUX6FfIUbJAuEnsvkFs+7nl45xg9yTfTbO+V3xjHU6JSmxKtBxm8clFjOHXALbFu8i+WQsH1s9i0WKHvOJgApIxGRQ07o5//fuBA0Lkp+d0gAg0vlUqEZJPhfneY0WVhkuNXFFjjQDKbQvEPbPXRB5lLvnUYE3EOjyhJ1QLbW7Vp2ZcPUF7A3Ev/g/q62KdyyBdYaIi/A3LgMhGW8krHVmari4+a0c5ngB0GeNWDlzDsf52T/QTPAA5jL1Ob2rmZD+7VcBbg0tAQWoHU4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMVmU4MBABheMRbk3xan0ghiQL2l3TGAHIzWCQFRoJI=;
 b=Ux5atxz+hamZilPVqbTziIz/ZOYzapnRkkGCk8t8ouQpSgUuQtjLA8NjdZ7P7uAASg4xPdKf5ivJU3VkoZnx3/sfnaQgOZfLzhBnC0WmRXWKyS5S2ijbKX1Gnvi/UxM0BujJ1T+8cf7/GHuhlcVnI1d8BpSRbqWK+05GYETyBIRbXFncfr8nz69L8WFGT1RcCZfi2BFlGsG2E+dAxU2x6jhBrjh07L6oiv+uLpDKly6HHGCA8NCgI5TBYSWOy4Zca2riJnmz7FuRwBYM79radWlUO+DBvdyTL6slhvNz3ebU28n4n0mh/CfRqG6h1CgOD5gE2j/ry1k63uznVZcI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMVmU4MBABheMRbk3xan0ghiQL2l3TGAHIzWCQFRoJI=;
 b=kToyckQAKxsa5An6UdiNoySbZw73Vg48V9kQfp7xv1vUmXjuOxOXK65GzS2tJiszZ06liOZ+FzP0JzoWEp08vGcnvDbvrBRLecELwIyGuR2qYBXw+v1q6cv2u9As5Pv3frDAewMKG7jkr+6pJ7vDhZv+fRfdAzcg9NQJP+FtZkE=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 06:26:21 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::f9) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:26:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:26:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:25:44 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:25:41 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net 2/2] net: xilinx: axienet: Check if Tx queue enabled
Date: Wed, 30 Oct 2024 11:55:33 +0530
Message-ID: <20241030062533.2527042-3-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: cca3a678-0761-46d2-855f-08dcf8abc4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCEoELnb4qM1jyGynUoW1RdL+AbCOEwalxQ/vHMrmov98mzrgpIrxeVtOZpa?=
 =?us-ascii?Q?NcyhG7Wl5O6Uv5vYIJPKoe0kGCFSJWrRuG8NQGSLs4w5wxWDryYPfpHqFNXf?=
 =?us-ascii?Q?XHf/OG5uGGbS7KLxuUuUc1vuI3tWdWsrGgwEcBkUHWgnzTneJ86+NDZR+mQj?=
 =?us-ascii?Q?aU4VMvVp924aHHvb90q87iiO4J1cQwotrb+1ZXJpu0wepWQnBLE1eCwJOQhg?=
 =?us-ascii?Q?X7qYRBy1tCUsvK3TaDKMd/G+qCGtF5abC+ubHNCGizi5e3g7nMzq+nP9jo0W?=
 =?us-ascii?Q?yfys9lmbuBQTSsORwoqGB8QgyrcU1dNG4lJu9KVjnDJedFTLJhM+HxdWqrCg?=
 =?us-ascii?Q?408vdPNWuvdsM3hAUNhMMRsAgS4VBLwFUmi2uBaHJ5c3O8IWBcvM4PKG6O2Z?=
 =?us-ascii?Q?7zmh6HbYKq184WO2OC4xuxCJjCd5u2WnNZj+UKExVu1vW4LHbMlKlvKOKs87?=
 =?us-ascii?Q?8PmJFoKpuCLGrf5/ca4WC0n4/Y8bmabC/8nl+iTCAttVzYrAEHRCjLAyyZao?=
 =?us-ascii?Q?fFxljU06VmZp2YeVFXAE+s1BvLy1UxUk5w8eCJjr9bw188yPWEXS1nXzu2HF?=
 =?us-ascii?Q?cqOrqcwTBx9Z4rWOQ/+Kqxac1FYRg4Qer24KiCDLcNN2dNCgUZxOoEVBP04S?=
 =?us-ascii?Q?u01c7RbBpDoHpX797HF8EOrpimujMKT6cHByL7pPMlEq4tE7crR6UZs2N/NM?=
 =?us-ascii?Q?2sdQe7dpxhSFamTv0PHhwvi8aHJOJehszTs5o1fsx5dFLmiJqstQPaJp2Bj9?=
 =?us-ascii?Q?BM7p86PZ+Wl61kPGUbJNCy2JPUni5XdJ+hkWOx7SGKfaXz0yB0lG8Rs31Z0y?=
 =?us-ascii?Q?mR9oYFOI5pSYwSSK3Ri90mqMTauj1ZpKMt0zYVqX/vJZt6rzZyARS7BpqmrU?=
 =?us-ascii?Q?wI+UBbA/PUQwAUGXBnX1XIybiootzVY5ma0AEdxxfxTr0wiA3CbR4Qbf+MHz?=
 =?us-ascii?Q?MAfzC3nX1SQIv/ZhVMNeV776qHiIb53KOarfyiYAILPdm0CNiXR0ZT8w5+8u?=
 =?us-ascii?Q?5Ixel7cdvmBecnu/In204vKst3QT847hYK2g04i9fcMvByto8v7KhhPjMymf?=
 =?us-ascii?Q?rSUPkLM79++jI5mTytopeahqhH8yyQrKLTW8kCTcyv+0YNWb6r57ST53FqSk?=
 =?us-ascii?Q?d9q1pZt1YbuJaKDBedRA/mJAOM/K4ZqRhB73T3zTmYzIn7koERB+9N3ORpkj?=
 =?us-ascii?Q?qHHNoTXtmZaj4rtuZgzl972xJyj0PVISk04KhIEbg6Rsdm0Q7Bia6cUPVe+L?=
 =?us-ascii?Q?NQbTBtrt7ccevNpwJncDutokndX7FtOb/bM4hIUmcQe6Rr7X7YBzFeLW9AxM?=
 =?us-ascii?Q?IEXTUPqmvgnX6ie4IvhXc1M7IgLE+6b9y/vbzvp5WGNigcafvc5CQN7BuS6r?=
 =?us-ascii?Q?Ls8swLCCGIEVmUDudh/8PHp9IaiFxgQcwh5Lr8alTLcsess7L70K/wYw7k8z?=
 =?us-ascii?Q?nrLaG/qNrcI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:26:20.5090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca3a678-0761-46d2-855f-08dcf8abc4dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Check return value of netif_txq_maybe_stop() in transmit
direction and start dma engine only if queue is enabled.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 0f4b02fe6f85..620c19edeeee 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -926,8 +926,14 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
 	dma_tx_desc->callback_result = axienet_dma_tx_cb;
 	txq = skb_get_tx_queue(lp->ndev, skb);
 	netdev_tx_sent_queue(txq, skb->len);
-	netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX),
-			     MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS);
+
+	/* Check if queue stopped */
+	if (!netif_txq_maybe_stop(txq, CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail,
+						  TX_BD_NUM_MAX),
+						  MAX_SKB_FRAGS + 1, 2 * MAX_SKB_FRAGS)) {
+		dma_unmap_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+		return NETDEV_TX_BUSY;
+	}
 
 	dmaengine_submit(dma_tx_desc);
 	dma_async_issue_pending(lp->tx_chan);
-- 
2.25.1


