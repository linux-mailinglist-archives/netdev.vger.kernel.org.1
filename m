Return-Path: <netdev+bounces-82720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AC088F692
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A92B91C2646C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEDF405CC;
	Thu, 28 Mar 2024 04:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KLCdJ8UT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DAB18AF8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601261; cv=fail; b=JhPfIBAtmPcsl2q179hVQQS0GCtXoWclWFWcOM5yId9rXk+KGk/dcIJqsJqhOylVVWsqpZfjaDukq9s0aflyYumE54MojEBq4iPh4sryTQGQmID5rfzqL4LIbbKHiqnsppMSCmZ98nG7rDXx+hiJpqxA98zfrz1eiVnUOy/0jac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601261; c=relaxed/simple;
	bh=gsTV3FlnZJMFTCSlZ8pHzSf/GXlzJO6bRxdkSi1FnjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NksKzTtp3X/1WA+4Pyl2rVi+4yN0aierN5NDTXDSfGArSOtVLFW40bRz47Abc8WyObpBQ+ykzKz6cYZLjpHF+k9Ohc+Hjk8q1UQRyn3vX6CNCdaZgSVI3dkjSySqwHMs1yfTnd+AQ/91UfNH4aOFLr4thDk0dQT7c+kFGNzzRbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KLCdJ8UT; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdiapXrjZTVGpTWqdEaghgSe/D+SL9wK4ohWppSyEby1jvZ51N9ePBBlRHhtcE4wBUWwOTNsT0geiRgbWKCjEGh62Xrw4jvEsRRDrvT1qLNrLJpfMUhJe3CQEh/KguBl0+SfGzSvbkeJb1/Qi8CkH2rrLHMQv+/NkAF12jPtbWzuS/+5OJ6s3zbVi/aQfND149/qUvdXN1Sru6pLdzDTW5p425hqXC9sdEak/R8Z/dNcW84iwgs489j5NdObAOIOh7y861PfJnEIZF7CN1TElhR/2eCyoZszbhd3bi5lvYw28vUtkc9kO//t4qaMH+kaepIKFr0epIZu9lZneb/tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X01ceE2MsLtf84g4slB8XFxLHnujQkWQ26Sit9xfO8Y=;
 b=j5avjytQgiIurH6YThx+VQh/Wwy14+5MbsJvGq4pkjyrPWrX1YjF9oebXZa9jjDAqdF8m3OF6jTToTwrm2aIXQmVHqLlnCuh9q3M/XBvhOLsInsEqs1cTzVGzXnuCLnQGPOIpCaAV5RGOuaMz4XELRHhlC8BuvM4ooThRUoEgCeVh/sHbwAGxARxXNwu+j8eT2VYaD/YZ69CARTOpEAWkq1iLEgHrKwy/moVTILZs4e95MKc2hL6YX+dvbGUsCfQw738gSLxvWIWSrUrNZzxheiNIrKcEUnzS/5rsw4jWsL+WDhlTagqypOyoGYotxq5ztgnm4cYfxL4Kx5fz186Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X01ceE2MsLtf84g4slB8XFxLHnujQkWQ26Sit9xfO8Y=;
 b=KLCdJ8UTyW7B8VthEdpnfp35SvEEAi7ZL5aeUXTuKoIjMpwnWTpcw+iokqMhmvpr1ht8TXHTXrT2N2Sa43JcYw64IXGmO8l3r7zQdHe7CjiKg4cf5BNXB83pQ6AkPE4kA3CWTHtDwxG8ndJkq/7fD699NvHFdtWLMsj1bTsiDEj64zf5M99G7sWoQ2HNTpUJ+H4U8rQesAIqRH0A9+SCO0G69BW4UYcQQxi6XfJlrQSO5oDh1jzb80VAZlj9S6kl+uVjmYKS0OokAZNQZrmTpEYbfdihJonG2PdT8zxbFNH+OASG/kCPgvJCxEYmUPZ4UiAP00fEY+3E50II1QgyTg==
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:47:34 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::8e) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:25 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:24 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 5/6] virtio_net: Add a lock for per queue RX coalesce
Date: Thu, 28 Mar 2024 06:47:14 +0200
Message-ID: <20240328044715.266641-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8ca1e2-038d-42a0-e1da-08dc4ee22f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LRC5D4dYr9y/fBaDXT1Rc6CCsqdt8eP3InqZ6gm2gD6TjSQCuYoroBF9/JPrO409P+5mctzliBzkLo4QOC/F2mPTPTSVHaUR9/W4tc16OAjRG9ME+ond7M9MFgE2RDRXFNTO7pXxt1CzUBY7cqhIClIxyq7lHD4QrbbpmC05TknI/ih1ys2JQ9dGLC+yzZH9pg2jWSRwsYsxrpz+UKQNYwlsgVPietcwCzX40kSjnaGBBx2+HiR3d3LXIu9CNxvWtLv7xmizLPY4EGtkgNk3AgDX5M1cb5nOD9vjRigetfODejHGk6IAAdWHcFNK9LL4XSp55wkKl6Z38masEsL2Jm+rdBR4VUxSPCWQJOn6oNk+CxO6F5Gpu4lpBVVD8KAvC3MuuNh4KdSra7l2xMwpq5r/sAOPO2oEKZxR91UDMudaujDpFRbGVkUUPFxwenmVhaJXicOy2D9MjUIZJSHDycpLVuTVycBCROyWb4A1WzrLyQZEZ6rPjojXf/TiqX7Gm/MFPOtDEhI20UbcO0O5qVt8VoEchknAY8jTf28Z/+pLTsVIxWdvzt2SwvdsopJ7iwFEY2Iik6/79cKb70z0eOzZw/T4aOe5Q7Y0GK2MjJe0lcutl6KrGORkZhqR5tUcKfbuNUXVJU32kBSZWXt2o/zNP0NaedSmwLiwDnXnMw5QIK/vJsvCEROl8W9Gbm7ajJBoRKhMNVXF9ySavyY5t1s/nPHpTn5ERovgzghiiFbxmMeXNT7dgZ26gHKGl+9p
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:34.3601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8ca1e2-038d-42a0-e1da-08dc4ee22f6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

Once the RTNL locking around the control buffer is removed there can be
contention on the per queue RX interrupt coalescing data. Use a spin
lock per queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9c4bfb1eb15c..859d767411f8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -190,6 +190,7 @@ struct receive_queue {
 	u32 packets_in_napi;
 
 	struct virtnet_interrupt_coalesce intr_coal;
+	spinlock_t intr_coal_lock;
 
 	/* Chain pages by the private ptr. */
 	struct page *pages;
@@ -3087,11 +3088,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
-							       vi->intr_coal_rx.max_usecs,
-							       vi->intr_coal_rx.max_packets);
-			if (err)
-				return err;
+			scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
+				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
+								       vi->intr_coal_rx.max_usecs,
+								       vi->intr_coal_rx.max_packets);
+				if (err)
+					return err;
+			}
 		}
 	}
 
@@ -3510,8 +3513,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
+			vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+			vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		}
 	}
 
 	return 0;
@@ -3542,6 +3547,7 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	u32 max_usecs, max_packets;
 	int err;
 
+	guard(spinlock)(&vi->rq[queue].intr_coal_lock);
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
@@ -3604,8 +3610,9 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	qnum = rq - vi->rq;
 
 	if (!rq->dim_enabled)
-		continue;
+		goto out;
 
+	guard(spinlock)(&rq->intr_coal_lock);
 	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	if (update_moder.usec != rq->intr_coal.max_usecs ||
 	    update_moder.pkts != rq->intr_coal.max_packets) {
@@ -3617,7 +3624,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 				 dev->name, qnum);
 		dim->state = DIM_START_MEASURE;
 	}
-
+out:
 	rtnl_unlock();
 }
 
@@ -3756,6 +3763,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		guard(spinlock)(&vi->rq[queue].intr_coal_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
@@ -4485,6 +4493,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
+		spin_lock_init(&vi->rq[i].intr_coal_lock);
 	}
 
 	return 0;
-- 
2.42.0


