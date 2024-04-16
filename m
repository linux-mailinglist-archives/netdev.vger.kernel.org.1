Return-Path: <netdev+bounces-88453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3E8A74B8
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494BF1C2173D
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538CE1386C7;
	Tue, 16 Apr 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uroo+MCY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D7F13848B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295881; cv=fail; b=ZHMHtXC/poCkpM7koz8FdVamw8Tg6ftIMAbGiWcIQ7lqYLbPFJOKcPCVxQslmtORGIgJkL0s+8BqSV6mbYC8B3Sm0OefmAGUvXSNX7W0ORj12BCNhsnvfNW5t3etgmsaMvOhVYVDXOrSFqyF+1E3GE7sQX9TSuovaTC5xsZgGV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295881; c=relaxed/simple;
	bh=ahrnC6BtAqYDjO5AVNBAu4usZHfZ88DdN9Iojsa96Uk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PglnKVoaJ6FtS3pMmx9DqxJ/BsiOKANiIOrAJHaBWNUHUspEx90o5nkD4EDrAnCfHACbc5onkWoM504cTR5UbbVHx6ZeXFR9xyfo6Cyg3yj6ulPlG0R5w3r1QNP02343Y7FFn2E0yo/fseImFXohUHgIDMi6mVVdZ+WtmuQyHF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uroo+MCY; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWOAYpR0F0hgm3X8upyKHLkTlzRsxTD4vJ+3huU8CSDIFwhnLFkwF19MxLfLKbDsmSL3iYq0JBeZssUMTkd++fZYe/6cEh/wdVmKxXYjRVzI2wNdKsh9uSlsRyMz1Dcnomo5xRYF9srr/pgGfMN2CsuYQXBYfVftm0YkN+WqmsGmNtPj7u3fZUFvpj6gLF3MjgbccmX6j98cMcisVyss3R/7jBrYkRjjZ6pOxV0F//RUGJus+9Rq7APXHOO8vEI3KItIDjHK1gtQU+l87k8eYixynK+CW2/08sOz/BRZzwyB0M+E+LG3Xwgk9Xxpz56lDc2okrqvRo+5sHJ6zAFGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svd8UF4adwvxWLuQBucrz9T5Hl3DZM6wHCJrHrp7axI=;
 b=Thqa8j/lrCS+wNi33lHk58qa5DDto+lFBaulHSzyDDVgJ+KXGfCFgwq30z+J5WYS7POxOqAK+hg3E+rUvugRz8oMX8oUlEJJ4rH3yJOY1kHGcXhyiHw41dsUGZF64do29IKypu8DFl1aVN0nMJtREly+DqqskJOPyIvVK5cSEWGZlrsDPOBVQAMW8UVzmGgqw6gzQ1/79XrKwZpDzMvoHhcL38/TvEpgxzWIiNNlwRrWcn6PYvdBmNtlziaztGZAWauR1BaKdJvzpiX8Y0qcpS9sOEfCAiYYmb0KP7Q4Bv0a7cdm0vqQojmt7hR9soNFD6zs51FY5gm07UoB3iWOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svd8UF4adwvxWLuQBucrz9T5Hl3DZM6wHCJrHrp7axI=;
 b=uroo+MCYvWk2Hq/9P5vaww8RTQUa+6guxr9JshqlgRXZJCYKJWwg1Gt5GSM+/7otJDTu6zCV0rUF/H7+TD9xcwzUrMOaLDyiq+m3Rh/wPLeAiMfQzsw6xhFD4IrGvk/B8h4b/H7NF3Rplzs4RIuufI0hQ4AvGXwTyh+VX5r6N+S+A4++uWIbmMVGNGsu342Safe8wow+xaK/uP/dvrqsnbBpDhk/PW3v9wz60bSBU/A6S9bg0U5qfOat3o8DP3SjxIJ5TdvYmQDDPZykiT2ZlHYAyLipft9kusSymmYjB0PVjL1GKXLISMKmYXMg0XuKHuCOiA44Z7B8XKZkGVH7ng==
Received: from BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) by MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:31:16 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::58) by BL0PR1501CA0035.outlook.office365.com
 (2603:10b6:207:17::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:52 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:51 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 5/6] virtio_net: Add a lock for per queue RX coalesce
Date: Tue, 16 Apr 2024 22:30:38 +0300
Message-ID: <20240416193039.272997-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416193039.272997-1-danielj@nvidia.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: f7fc605c-376b-4fc6-2be3-08dc5e4bc897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	88t+Xwd9YLTlimVGRQDchR/oOIgaqSyqOMePzVPUKb58BYOryxo6DBLyBNA8T2NQ1wIKwdoHAkoMxoQDmzJbhWnDNdfokecFKABqx19i25Ksizd6wz3ThDIzcyi2abPhY/yfLUJWTMBz0CnQvpYnvggj7tJrRrN1DajEANiZecFeWsZHGPkcW+zJhXR4NWKDDFC4iiG7tVazbiMMkQhMZNZvwB+U4Cv/kB7M1GRaYksWt+NQ+qlWecgqvEwWo+uo0cw6rvP2HjhLFkyUvY9I1/YFVVY0Y2cADFgRZt71fc2VK4dA5H3/Y/I6/uvfx9RoR1qtmnIU2dG9WazoW0l7gWfuSy/zchmc6BOLj3aBlo8LdBHmEnVCBUQj23XubKR7AR8eto7ASdTICKeyhSCmbUeh+w5hRbG2tPr55hwYqpddwmUpsIaSW6BKmkGx9j89wmd7AK4WlNL/JcK64bSgltP7t/2dn0R4tHr3kGUkECj5DlzflsYYJvpHxYLJtIAHPuARAuRBX6jSb05NDvbw6DbWEXqj+7lDCSxcbyw/ON+lUZu6me5PnyNIRTreemDa+qW+luFw5gECLlPnoPnr4vBZIFmI/Tplt9s03/y+PSueS2580wgvOgkXg06l0KsgTZiNAG4Hd/xR15hZScIyNcjToKBAvLIZhVI8bdvPC0rtAlmJFWTtM6+S7C6qJDpJo9VSb/zglzDfLv3uNhs3p4HF0/5GfIdgjGrY1lwkzRBOWlIhKRBew17I1KhGvpwA
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:15.8645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fc605c-376b-4fc6-2be3-08dc5e4bc897
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

Once the RTNL locking around the control buffer is removed there can be
contention on the per queue RX interrupt coalescing data. Use a spin
lock per queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b3aa4d2a15e9..bae5beafe1a1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -184,6 +184,9 @@ struct receive_queue {
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
+	/* Used to protect dim_enabled and inter_coal */
+	spinlock_t dim_lock;
+
 	/* Dynamic Interrupt Moderation */
 	struct dim dim;
 
@@ -2218,6 +2221,10 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	/* Out of packets? */
 	if (received < budget) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
+		/* Intentionally not taking dim_lock here. This could result
+		 * in a net_dim call with dim now disabled. But virtnet_rx_dim_work
+		 * will take the lock not update settings if dim is now disabled.
+		 */
 		if (napi_complete && rq->dim_enabled)
 			virtnet_rx_dim_update(vi, rq);
 	}
@@ -3087,9 +3094,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
+			spin_lock(&vi->rq[i].dim_lock);
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
+			spin_unlock(&vi->rq[i].dim_lock);
 			if (err)
 				return err;
 		}
@@ -3468,6 +3477,7 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
+	int ret = 0;
 	int i;
 
 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -3477,16 +3487,22 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
 		return -EINVAL;
 
+	/* Acquire all queues dim_locks */
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		spin_lock(&vi->rq[i].dim_lock);
+
 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = true;
 		for (i = 0; i < vi->max_queue_pairs; i++)
 			vi->rq[i].dim_enabled = true;
-		return 0;
+		goto unlock;
 	}
 
 	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
-	if (!coal_rx)
-		return -ENOMEM;
+	if (!coal_rx) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
@@ -3504,8 +3520,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
-		return -EINVAL;
+				  &sgs_rx)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
@@ -3513,8 +3531,11 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
+unlock:
+	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
+		spin_unlock(&vi->rq[i].dim_lock);
 
-	return 0;
+	return ret;
 }
 
 static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
@@ -3538,10 +3559,12 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 					     u16 queue)
 {
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
-	bool cur_rx_dim = vi->rq[queue].dim_enabled;
 	u32 max_usecs, max_packets;
+	bool cur_rx_dim;
 	int err;
 
+	guard(spinlock)(&vi->rq[queue].dim_lock);
+	cur_rx_dim = vi->rq[queue].dim_enabled;
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
@@ -3603,6 +3626,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 
 	qnum = rq - vi->rq;
 
+	guard(spinlock)(&rq->dim_lock);
 	if (!rq->dim_enabled)
 		goto out;
 
@@ -3756,6 +3780,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		guard(spinlock)(&vi->rq[queue].dim_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
@@ -4501,6 +4526,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
+		spin_lock_init(&vi->rq[i].dim_lock);
 	}
 
 	return 0;
-- 
2.34.1


