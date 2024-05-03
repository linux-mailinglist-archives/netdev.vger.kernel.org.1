Return-Path: <netdev+bounces-93361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256788BB4CB
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A447B1F264F2
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605011591EB;
	Fri,  3 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uZGlmNmN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712F158D9D
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767914; cv=fail; b=uJAAIiYW9m6x8LO7gsdTidtjFeNFIW1mJvICDXMJS/379QsGsRPlwz+7gJSQZYvVY4hckGAzqi/zmBzgD6rxj1k+37z60haZL9ahkZ/CNJ1DoLhCeJLeIj9KPlvCq1yDc8UQv0ypfipXtOQ+0PSIKNQd59uVkK7t8qn4J8OICQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767914; c=relaxed/simple;
	bh=20scjcxqKg6UwodT1G4a0xGYvpRZAJm3L7HeSJ1G7vk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4VZT6GbnH/4emrlHq4rpQ2+gM14ZHxhlY/BIcj3Kh/81w54wSV2ve/d4tX54RCn8cNeW4rcg9BGYfuClEND9EYxWWsAxItMO52qbZUZLHy4bA8qdZGBrhB9U8LSqHWyRtBGNAW8FcLsd3F/mVIYnLk5iiqjNQIHyNG8ertRZvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uZGlmNmN; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd/fZfOmbFWSFeNu0KhDzg70qiEZ4IYWU/fL90BaZ6/4a0r5XDQ5RNEoRDczrdoTbLLzlaZeQSxY9cvyNDmX5orHSXxZJTVft9hJkYZnq3qrGl+TSk6OVqEwOsuz3PIY1dkfS9VeRSkRkg/V+U8hdImyg1ogGbNa0//zIzORXXyfDucYSTktFZ+sR3BhpdKPkuPEByvoOzCPY3NGC6VP04EoHK7ZdDNE2OzqPARciMkcv2qGKhes83lGYQ3vNap52ir+UJPx9ww4/rNTSkev8O3QeQ7TdjcYBUnJPIsvuQf1cursIcQXixsN1PSq/kh1vMqI0YYgiDE0QdYY4MXdrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xHR1GTHlfgmFu/rKfdmXEmKE+lNJ964tSnqFVzqD+w=;
 b=IhLdpi85wO9jLhSVn8jKhkMDyQpaWgFuZDnTtjPr/ICfsdPDNy/qX/rup56t9EqyPcaQkP+g6sLFBsrXi+Pyec2FtPI40939MInN6DcXx910sr3zBVmtU8dPsAzDbXsP0BZnexITlMt//nhBtEsCjneQYRDdSNo8DoWiNEBDXjHMriyduK1H8U09pDPU3XTv2qnluCbeS0LTvczbkVOe+dFcuPgpHILPVFuu6Vl+aX/NHE6EVaJgW0aF5gufF9tAfdTroIfsZ4ZewL8bPxXp8PNBBOr6mvfT3v+yVRzDRI6rJAMDRWsqSfAZH795/jvXcZRBaoqHbFrobbVfv/YGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xHR1GTHlfgmFu/rKfdmXEmKE+lNJ964tSnqFVzqD+w=;
 b=uZGlmNmNF6EQY07UePF121brM1p/ZHiBR2x4KJU+TfqTnQwCsJ/AGEMdRMv/JwXqrlc9M7cdo9sK1UTnVUeI9DDh211fniDaKemOqpeRbPMtLr5Z0zY2HxSR7U8e0XnutjYXg3GqoKHxlRtUvIdWo4F3s601L1D3MY6bJX35OPsNuB1yDmVQyZYmS8ZBDcKAjcud8NmbohzAN+6wCUehp3yCWrCsrKGZK70syNK4jGskokLC7S5qftWOe5YJCybAyMqjCquT1FarhWvxMVdgaKeDmhu5fI7hmoYKpKjcukobeGPtIbeyfxCQMQUAJR4xgHcMja9V6PnRg+bNGSbrgw==
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Fri, 3 May 2024 20:25:08 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::7b) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 20:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:55 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:54 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 5/6] virtio_net: Add a lock for per queue RX coalesce
Date: Fri, 3 May 2024 23:24:44 +0300
Message-ID: <20240503202445.1415560-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240503202445.1415560-1-danielj@nvidia.com>
References: <20240503202445.1415560-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e5cc57-20f6-42c3-ac8e-08dc6baf1fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krw1j1bPLG1hU0Ve5EwV45zlEPLINJTS3Xx7WZbyP7rp4qKQoyxvgxGtM4rb?=
 =?us-ascii?Q?64yNIlzDyQZxiUEmHckLFjo4SKxmXL03DRLvn2lzfu1ofWfI/+J4dbO0gAjF?=
 =?us-ascii?Q?ex4fi+CpZhZdJ+bus5NDZYt4GT+g2EpMe0tH59C1FPp4CpSVL9P2YPI9yqDe?=
 =?us-ascii?Q?V19TvK6HDgowCKq/nAchVd8dHt13C7ATRSJMeiWL3SU1SawLWxlB05cmNfau?=
 =?us-ascii?Q?iaImom0jViDh5nirKlp2roXJ+IDxwlpxsTESEfE4120D+wR4uG+T1xo/apGe?=
 =?us-ascii?Q?O8X/yHxWhGzi9NSLTn2j17UMNealMl+jIQRYFchpIk4wvPxP/r44KO121617?=
 =?us-ascii?Q?9RDEX9iRmiX1r4sLwury3OeXjcd0/zXtYlp0hmr0vW5ladr438q8VbKiKUHQ?=
 =?us-ascii?Q?CFlYYKjRVFvijfn77ATy7UziDeHkf4UQjEc2jXfDQZJpLu7X0rYoGQ9ylVuT?=
 =?us-ascii?Q?7oVFylUibzwlcfqObjhzhI9n6fe6Y8bwQbwF3roSd+D3GtJ08/SuokvCpbKE?=
 =?us-ascii?Q?Sn/xF07C6zgR2Q03O2DY1met4edOyJa8sUsAtKe0Mr3rxa1psSJ2Yomep2I9?=
 =?us-ascii?Q?/to7A/jYClHCrkknhztwTQRQH4JgLbnRg0Glz+o4jETehXHmGWfVG7YCPow8?=
 =?us-ascii?Q?vTgMOc84+yrFCjsaseYsLMVHaYd2DY8XRwTCNEJbV5zfKcCnkgZyj7gjfieM?=
 =?us-ascii?Q?U019GWPY1mAcqWSpEL/7rNCx/iUyqMpW/AzEcOU3sz/y++JKxNI0SkxHI3Se?=
 =?us-ascii?Q?vG/gwLjwgbYoCz5hBDT6vPgQTAn3AKpTdIqlBWJ/ns0GIputAcH24gaBSQ4w?=
 =?us-ascii?Q?7dYl3KdaWSHXY85ssy7aHh4+ViqZ2v0MmAXQAVnHP10TnEAbmrQsgPyvI0+N?=
 =?us-ascii?Q?MpHVgfCXwI18cy9QIcxb3tYVazM1FPtxv15huo7q5DSwg5L1O6MQpC3zXVTk?=
 =?us-ascii?Q?EymYJIHEf2FYypMsPWjLmn3UFKtaq09/E9lN9lX6liF7kPzHEU4KLCNQDePW?=
 =?us-ascii?Q?rEqbVj5LVVh7G6ZGSP/rsrcK2quSRrwErM6kWDQaZsquJoqMYw5gCZWxXxUr?=
 =?us-ascii?Q?zZAyy7qJlgAbGBqHA9rdE89/+Z71VhoCOOIE46HWqcp8yiuI8mkKo0UFn8zW?=
 =?us-ascii?Q?CNe2Lw9HMWgVjy4WRYXl/xO+YCW5VH4CmkLeWbJYbMqrODzlPnrg49h6fC4c?=
 =?us-ascii?Q?qX8+XyWbzLpNVuk8yF/qc8MCffTahVwSKnBBpZ1utPaNByCWUQd32sEvconH?=
 =?us-ascii?Q?N7DruirHhjC0rwzuKlv7s83ZmFaB6l98yVI/sDZLYOMUZ2j4Mu1APgjCY18C?=
 =?us-ascii?Q?0DcXX8K6XmF+PXSeCNSqkDIvyvOuJ+Rzc3DW4TGnRL5Vng5OaoTlat/VFnMO?=
 =?us-ascii?Q?Z+FQNIwSxLxZUfzO4odaS/yvV6S7?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:07.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5cc57-20f6-42c3-ac8e-08dc6baf1fba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344

Once the RTNL locking around the control buffer is removed there can be
contention on the per queue RX interrupt coalescing data. Use a mutex
per queue. A mutex is required because virtnet_send_command can sleep.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 53 +++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 386ded936bf1..a7cbfa7f5311 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -312,6 +312,9 @@ struct receive_queue {
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
+	/* Used to protect dim_enabled and inter_coal */
+	struct mutex dim_lock;
+
 	/* Dynamic Interrupt Moderation */
 	struct dim dim;
 
@@ -2365,6 +2368,10 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	/* Out of packets? */
 	if (received < budget) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
+		/* Intentionally not taking dim_lock here. This may result in a
+		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
+		 * will not act on the scheduled work.
+		 */
 		if (napi_complete && rq->dim_enabled)
 			virtnet_rx_dim_update(vi, rq);
 	}
@@ -3247,9 +3254,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
+			mutex_lock(&vi->rq[i].dim_lock);
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
+			mutex_unlock(&vi->rq[i].dim_lock);
 			if (err)
 				return err;
 		}
@@ -4255,6 +4264,7 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
+	int ret = 0;
 	int i;
 
 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -4264,16 +4274,22 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
 		return -EINVAL;
 
+	/* Acquire all queues dim_locks */
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		mutex_lock(&vi->rq[i].dim_lock);
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
@@ -4291,8 +4307,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 
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
@@ -4300,8 +4318,11 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
+unlock:
+	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
+		mutex_unlock(&vi->rq[i].dim_lock);
 
-	return 0;
+	return ret;
 }
 
 static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
@@ -4325,19 +4346,24 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 					     u16 queue)
 {
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
-	bool cur_rx_dim = vi->rq[queue].dim_enabled;
 	u32 max_usecs, max_packets;
+	bool cur_rx_dim;
 	int err;
 
+	mutex_lock(&vi->rq[queue].dim_lock);
+	cur_rx_dim = vi->rq[queue].dim_enabled;
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
 	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
-			       ec->rx_max_coalesced_frames != max_packets))
+			       ec->rx_max_coalesced_frames != max_packets)) {
+		mutex_unlock(&vi->rq[queue].dim_lock);
 		return -EINVAL;
+	}
 
 	if (rx_ctrl_dim_on && !cur_rx_dim) {
 		vi->rq[queue].dim_enabled = true;
+		mutex_unlock(&vi->rq[queue].dim_lock);
 		return 0;
 	}
 
@@ -4350,10 +4376,8 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->rx_coalesce_usecs,
 					       ec->rx_max_coalesced_frames);
-	if (err)
-		return err;
-
-	return 0;
+	mutex_unlock(&vi->rq[queue].dim_lock);
+	return err;
 }
 
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
@@ -4390,6 +4414,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 
 	qnum = rq - vi->rq;
 
+	mutex_lock(&rq->dim_lock);
 	if (!rq->dim_enabled)
 		goto out;
 
@@ -4405,6 +4430,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		dim->state = DIM_START_MEASURE;
 	}
 out:
+	mutex_unlock(&rq->dim_lock);
 	rtnl_unlock();
 }
 
@@ -4543,11 +4569,13 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		mutex_lock(&vi->rq[queue].dim_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
+		mutex_unlock(&vi->rq[queue].dim_lock);
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -5377,6 +5405,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
+		mutex_init(&vi->rq[i].dim_lock);
 	}
 
 	return 0;
-- 
2.44.0


