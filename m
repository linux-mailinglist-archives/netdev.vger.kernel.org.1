Return-Path: <netdev+bounces-82723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4E88F698
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FD22923F7
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880E745955;
	Thu, 28 Mar 2024 04:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W1xonUSU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C945BFE
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601268; cv=fail; b=F6xMEOh0y1eostqSlWjURxBfivjv39++gnOY3oJqRLKkcQYaPEfgAMqRM7B4cE5wFzlnJBCSa/HswShUCn/JPFOnu1iEQQG3vfPlPsBA5v17AVwt+xcZug89fVlNQaKBuWNxN17jVNJDvIwIukJuSJTAYZNJvBMIe0l7DoUA8cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601268; c=relaxed/simple;
	bh=sgqx+w9t+Pix7RWNlSX7dR6Le4P3NB+t68cyImPiR/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peeo2mlXdxDkNW4fjZqlGe63GpC5ZEFjlTq9NhSNgOlHcEznwsqcyRv/1XdvMwDnUM7QvrtqjiVtV9VlaTGn76FzgoPdWC2F9Dz+MpCq8LLVa/qalqxh0LSUcQ95TfTAjaKnzuzrG1DuYwkV4HeAwtlq91MT7UZ1pqRs2el6BHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W1xonUSU; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRG2kXeJKGvFWElCgBE02xtZN5qI4ikKSjXovb6iib09gddDzilzRxQj/U3DmDGI9a7Y4ba4xi7yn+op1zhFLAwbyq4s5z8dZVGpCTNs9yLCpSUtDbrPw3chyu0KXa0ItWxwIS15IyENvmobfUY7F4mhSnq1HWzQsSsqvqsbbTvAhN7/Art0WXVlrN/wmESKDuSGSDCmUyKbitdQ0cGvCRf3RgHv+XGV9yLcElzb00FRfJEWzDYyA5x9HE18egoZH9NhrWZc+IQvXB4lHd1RBE2Bd/huDxg8Bbx+GMKDM21e/n5n2qKAOagIOj7HZaToM2S+VaFWXakkBuWq4k/s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuqoC2Un06h0rWPzOlTstWpulblmjCIfdrnzk6YFoOU=;
 b=cTejq9XZxiQop3q30ba47bvjWxVsjUlD0lJ4X02SRwGz0jVZogQZ4qvTBRoIisx9gA919Rinra1/YK6AZbHiBU6YPWRv8+k24HZWuSqGUBg5HEEz+hMeMpD7Qfz0jtLZS06wRaMUi6l77nerTfLvwcngoLvEVbJEUf/d9c+LhWBeEk10sDmqouZDfmRg+96voGoRBsMBJhQ2QsoJGyCcorrjr7f1fYfbukivGdmdSY7XWYfohbS3qMKlaKWW06fd+3KdQaenWvV0mKHSclluRfJYN8HMySQ0c+HybO1SVLhF+y02eQKFj8VTm0iEErcnmeHPVL84vwRPd9k0ErgUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuqoC2Un06h0rWPzOlTstWpulblmjCIfdrnzk6YFoOU=;
 b=W1xonUSU8jbWSZMtz94FtvEDRXsbZp5Dy8HjbeEqwnHFWzBlkgBQGPRZcENQiaZkWnlkXUpc+qpeuIu6Q+47tLmQ9Mc3g5/ivrn3FQENb7EZRsQswfNQbHUFuk9nzfTEu+Ol+nanAytCWIJqblUuGVGcoWRUc8PW89ct/4JfB59TbDfsxAqMjPLVYpXiLIjjEFEgeIyRqsR/Hz6bFhdOpoyK/4QH3goHTASCjMl3RbcPYIBL1p8dAQDl4emPqu+risngikBUQeQX6xvcflHwGey66341tSRYUEle4Xow2Ec5X39BC8ZMFMC4HnZ9p04qSs4FX0YFh+o7LtReKoK0vQ==
Received: from BY5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:a03:1f4::47)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:47:43 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::fa) by BY5PR20CA0034.outlook.office365.com
 (2603:10b6:a03:1f4::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:26 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:25 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 6/6] virtio_net: Remove rtnl lock protection of command buffers
Date: Thu, 28 Mar 2024 06:47:15 +0200
Message-ID: <20240328044715.266641-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240328044715.266641-1-danielj@nvidia.com>
References: <20240328044715.266641-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbba450-dfc8-4111-80e1-08dc4ee234ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9TmtGTRb3RzUZSrw2w3/n0Gq9amSvmMzr5IE0N/QPONMDc6r/8EkY+774E83kWawA60b6kK7rW9wOi8Dn+YByFvYhLlGKIEnjuf+dW+mJOhM7nDhVMVQL/QPeN58ASvEhW7z9vQbV+Gn9SUNp3MyX1bb4hnVcAEWv6BZIz/Jdl7i9NE+mBpaCymMTjhdWe3VfLbHBqekv6xP9h2Cg2jMU3j5RBCn5rFFcclPAvg3jN8pQ3MlnSRvOdNUWpgbWMtJ54tUjKIyR0GKV1qM6jELMtnN75NtT8tZ8vsy2DhBubP2pOyvPBh2ZBG/N9pM1ijj1pEMfVygFG8CiKQFEthj8OnLb0lvpTuYixA/Myd52i6iesiRMEh89qkY3Ak9A1lffIFBXc+EF4yNZLGftmu7RhS0g8oTAKBeZXNc7N7dqT7cMx7+z5f3J730YsKJlWy7xcgvXoXVyvT7mCTO/dSvzgsr44K8Ifd4dyg5rpOWISFwfDMwRX9OYX1ZlzYUKJ5QR9KevoB19NGPZHiYyo4+SIbJi0Qi0frxZ7FTt3imDljc2HzwloF0VskRMIssXvr5n2Lz/glchMZtz3H3B92MH+Xgil6lu49xDibj8y+oNdAs/RjxTT98KWs0NRSSIk8RveezflVOnfmcuJjRAayv+/hAtoo8u63QVOCQA4yO7oXmJ0m5myEbfKRBqGy1RhJ756Dh7QccvS0EOulxt4LySy6wY5p6EsKLA9LpJLMWcxSJynlavTHzjHDTwBfZg6jf
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:43.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbba450-dfc8-4111-80e1-08dc4ee234ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 859d767411f8..351d9107f472 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2658,14 +2658,12 @@ static void virtnet_stats(struct net_device *dev,
 
 static void virtnet_ack_link_announce(struct virtnet_info *vi)
 {
-	rtnl_lock();
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
 				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
 		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
-	rtnl_unlock();
 }
 
-static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
+static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
 	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
 	struct scatterlist sg;
@@ -2696,16 +2694,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	return 0;
 }
 
-static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
-{
-	int err;
-
-	rtnl_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
-	rtnl_unlock();
-	return err;
-}
-
 static int virtnet_close(struct net_device *dev)
 {
 	u8 *promisc_allmulti  __free(kfree) = NULL;
@@ -3311,7 +3299,7 @@ static int virtnet_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
+	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
 		cpus_read_unlock();
 		goto err;
@@ -3604,13 +3592,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int qnum, err;
 
-	if (!rtnl_trylock())
-		return;
-
 	qnum = rq - vi->rq;
 
 	if (!rq->dim_enabled)
-		goto out;
+		return;
 
 	guard(spinlock)(&rq->intr_coal_lock);
 	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
@@ -3624,8 +3609,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 				 dev->name, qnum);
 		dim->state = DIM_START_MEASURE;
 	}
-out:
-	rtnl_unlock();
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4077,7 +4060,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -4897,7 +4880,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.42.0


