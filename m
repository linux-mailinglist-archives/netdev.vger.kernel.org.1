Return-Path: <netdev+bounces-67232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE8B8426DD
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648BC28E0D2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6C6DD03;
	Tue, 30 Jan 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/dCIhSR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F486D1C3
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624759; cv=fail; b=sQfSsSMAOFn4BBCEtO7ouH+o0FN7jotyq6EFD2gBzn6yWZ9o2R4cRD2PO26vbxfOdlrHSF3X7IvW+RTvTg2Zd3DpsEvIPOOtS/6rD1OwgGUULPU54lzV82giF+tKnK/7W3X2Z7pMm3CLuTen3IIzGKrEPHC3cv3uAk3KmynQbAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624759; c=relaxed/simple;
	bh=1u6LOpmJKlmTDivE48WVaGENNLCN9fgRqXeidUlhfgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDdrIpZ2KM2/XdogOoe/I14EItdeOrHADI1yZ0fldwZYrPEXd01owYutEwyfp1d6f7cjKfh66XojQqWuvOeLEM8MKxxVAu6x+Z4X/lHM212Q1Lg+SqqkWMwzAgy9XFKrJuAc0WdyimYp7QYyUbPmRIVVmmiBw2EI8qVz8O838h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/dCIhSR; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dicjHa/eAQwOeWqIyRqivIsGgCnzE6CKvJvpL7QlJFBbj/0htNq5pfTq7StQWKfeqTfuYc05GucNIYvNbs2eEbrWq3QiUp6AquuT9GIQiWuP3AsoZLMe+aPPHjkQFOx929QkYq0AwT0V50mpBI9EwucZoldzA7MvB1H6dc92Wp8V4KK9ZMcC6AptBqQZD9MJigSCVlwvyjyEaO9r0hZfq2IujRHmbFkn4fkJ++UPfH7RThihV6scOOEIKqoycL4mgs4rSF7KEHZmkGJnDe1VesgQDZeTMM8F2ztvEnnU1RIFOLkxtVyXa7T4AMzN945qvDibn/n4ceXQXgiWvgjX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwwCKQuJYo6pP4pISbf4oL/RvnmjEO6frmkZlczx2dw=;
 b=hOGFx6eMSE6edTMmJAec5ifWZ4FzuGMe2Glj5dkNizX3rR5a7m1iJxpkxlxnZcQSfzSMl0kMJibegS0Fd8bhoCC2t3X7ZyWorclUtv4AUoLnXW62bHYeB8nDIby9/fmiBFrUyQ7vnUEMPfvJN6CS5/meIEnJUJVwDoQfxpbVsZ0/BCdO5wC1OlgvWxP6sWUQ0+CBXhOnvafKINpVUvZ5vdCVBj3K7abJpElOCWYxnCLgl0HF1+Y5Wm1lJ5R7HuTCXnEbBgDclrJxEpTN3Y6OKnWeydgVCVfDibfHQGVAD0lkYxWVnO//b4Jfog/tS7mYoB5RCQhtlnwy+iq8yCqs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwwCKQuJYo6pP4pISbf4oL/RvnmjEO6frmkZlczx2dw=;
 b=M/dCIhSREfqMOt+FwtV4hrjAXBfX8+q7Ph48Sp8V1YZHprcB+foC3UB/ioP6uXvQjf1ord1kO8OeGChzbk7n0li/73RKLTwiBMy30SjcaUHgYPT7L3cKL9BUsP7szfH4UxNo/V8kUzaFMzSs2zPujZtLzZCgTnhI8rhTp13C0HzdZcRgyFZojVrBGmT16pdbvA2I+7E5JVn9YQ2Y6kdNBnIIjZzqzQk2LPBr53dcJATB0w4kfnaFNrnKEq37iKSx/qyxLJnshtYoaduDUT4q0dwH73gxbw7glPnFFvMB8JSxwPMx1KA53ZXoK8LuqARz48C1X4zuzLspW63EX+Ku2g==
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 14:25:49 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::2c) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Tue, 30 Jan 2024 14:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 14:25:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 06:25:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 30 Jan
 2024 06:25:33 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 30 Jan
 2024 06:25:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <abeni@redhat.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: [PATCH net-next] virtio_net: Add TX stop and wake counters
Date: Tue, 30 Jan 2024 08:25:21 -0600
Message-ID: <20240130142521.18593-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2a1877-e509-4cd1-30c3-08dc219f5b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iXIMhUfAHTz6YLPvalFGL+h/wuIKlf0HMZYLJU5gZUXk12jXXBHYTqfkSH2/HwCwf3+ZkjeqURRG0HndKyhr32mVt5duU93dDQTK2EcLzp1xr+oYIvVwXoDzGHsfhWmWPaC38NQsdGuLvoZWJ+OtS4vm1J1BdRyhkfDAQBVfUsiTUDWeQV9GkzyyDgn7CQxl5gXH2Qh89eLv5lGEU3J+np/20gxvDjJKSSzyAtM40ybvZpkC3HNOLzZaTpZ1KwpTi4IEt+wtYkFgisAXu7qjMaIgUiqz9o+8eBYs8cWv2JjkXQo2W0OZmbkPAKdpjpm8DE11tobwi56uCRjluMi8gdlmRd9zVvOKxYl2BGZlKPxuscBQ45ZdXfQRfYjW+h6ZCY/EGwNwF5XVCfu7HRL4xMagOR5ERJGQLDiA3BCnBZwDQH+BRC09Yrs7FFDbeE3r7uiEEvZspMzoRvDB5zj0q5LNnWMiV/Wc6FEAc7+a6wXORQ/X8Uks8qk13VGy5sIxUeRMgb7u4++5LzJGofeg/F/42xsenZj4r3Yn7dUtM1GgeFTYrnDs0uZB4qP4xXQJbXVd91bvCqNgzS4EYfz11/7TwuJP4yN+lVPrT0N+KF311ztwFNtcURiZv5hmq2bSOqomFZeIUJY+TW7IN9ARfKdhbF0WSXl6RfZW8aDTQ+iBtw83YFgQBa/8nnTcGGpek/yA1Yq54+2cZge4fKsfmB9okJheIFmwhyWMQUIbB0Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(316002)(83380400001)(36756003)(70586007)(6916009)(54906003)(7696005)(70206006)(86362001)(8936002)(8676002)(26005)(478600001)(107886003)(4326008)(6666004)(1076003)(2906002)(336012)(426003)(5660300002)(2616005)(41300700001)(40480700001)(40460700003)(82740400003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 14:25:49.1359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2a1877-e509-4cd1-30c3-08dc219f5b31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632

Add a tx queue stop and wake counters, they are useful for debugging.

	$ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
	...
	tx_queue_1_tx_stop: 16726
	tx_queue_1_tx_wake: 16726
	...
	tx_queue_8_tx_stop: 1500110
	tx_queue_8_tx_wake: 1500110

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3cb8aa193884..7e3c31ceaf7e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -88,6 +88,8 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
 	u64_stats_t tx_timeouts;
+	u64_stats_t tx_stop;
+	u64_stats_t tx_wake;
 };
 
 struct virtnet_rq_stats {
@@ -112,6 +114,8 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc[] = {
 	{ "xdp_tx_drops",	VIRTNET_SQ_STAT(xdp_tx_drops) },
 	{ "kicks",		VIRTNET_SQ_STAT(kicks) },
 	{ "tx_timeouts",	VIRTNET_SQ_STAT(tx_timeouts) },
+	{ "tx_stop",		VIRTNET_SQ_STAT(tx_stop) },
+	{ "tx_wake",		VIRTNET_SQ_STAT(tx_wake) },
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
@@ -843,6 +847,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
 		netif_stop_subqueue(dev, qnum);
+		u64_stats_update_begin(&sq->stats.syncp);
+		u64_stats_inc(&sq->stats.tx_stop);
+		u64_stats_update_end(&sq->stats.syncp);
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
@@ -851,6 +858,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 			free_old_xmit_skbs(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.tx_wake);
+				u64_stats_update_end(&sq->stats.syncp);
 				virtqueue_disable_cb(sq->vq);
 			}
 		}
@@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 			free_old_xmit_skbs(sq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
-		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+			if (netif_tx_queue_stopped(txq)) {
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.tx_wake);
+				u64_stats_update_end(&sq->stats.syncp);
+			}
 			netif_tx_wake_queue(txq);
+		}
 
 		__netif_tx_unlock(txq);
 	}
@@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit_skbs(sq, true);
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+		if (netif_tx_queue_stopped(txq)) {
+			u64_stats_update_begin(&sq->stats.syncp);
+			u64_stats_inc(&sq->stats.tx_wake);
+			u64_stats_update_end(&sq->stats.syncp);
+		}
 		netif_tx_wake_queue(txq);
+	}
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
-- 
2.42.0


