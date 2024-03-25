Return-Path: <netdev+bounces-81822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403888B321
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CA81C36980
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F36FE26;
	Mon, 25 Mar 2024 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gc1/aOuS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72E6F533
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403385; cv=fail; b=Cqc20HeEz3ehuZY8hGk3WAVP5wnW+BeGOC15anXTYVoNeIZs9J69UnyinzRobCGXH26wBBGwKJg0YZGdO0DpIDyfRWSS6GnW5L7YHP9HZvaatvraEv9XZaAoMxutyepcYLus9O3Rtrg3nKI3p1wjQ416QbOR1rjCZ+qmtk5tcEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403385; c=relaxed/simple;
	bh=YyaZ+3iiLOs0EqGUSQkTIs3ccR+fggsONlEcMoERhkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTd3fOGfGN4RZ8GK31QY+Bb3JH5qDhmmyXtRKC9H5INBVertsDoYT2RTINmjxVyhB9FmYRyX7JEe6A2hGD0X4u0TyRG+yMM42f9N/W7t4/Bg8W6K4zSNYVPLFzZZdaHdM4f8dk5zX4vTQMb7ze9USWcbWZxWKiGMy0JdT4u05R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gc1/aOuS; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLyFCupYPCc137Cd1S6cU/y+IL1JKtQ7kNve/J3NZs+POIQIM4P1ehhxolT3QM7KRjNTwD0i3Z6S9scdWUXIGTPHwUUpNiogNZpu325u7nanDOxhlBNqb3TM0lTE5TDJRI12BTVhiBNiGBm/6wQDGv6sX02ImTDqVUuRABl4gXAAKmWpsg1N7UNWJ/x9sWYiQNgVyqGyERdQaWHJR3PMSe3kUxlv6nhpezOIFd4lgZ6ejnrepASzuYtp8Ni6Rvmva8jQAVQfjDmObdrq/CQ6Zi76fnMqZZYImuPdP6wjR1n9WrGroYJXfAAoWo4DPhi90W+L1+kFB3+o3G9kpZUMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHn0IfNHVihzbal2FifemjkIRBX5bA9n9Am0qN773so=;
 b=Wrl2XT1gTY4v4CKK1XlnKNmwgk0CKzO4zQMEa7WmSWB6lAXOGidMCluGglAEk4fdeF8/Swy1yFm1Hfb8B5yGToLJ56JLH12qEkruKk2gIKzEjlANn96XlTCEbI4YNbd2x29d6GOVUz60NeBzp9gK8sGl7RyaAjyBMfYPyE0xy/mYSPCF/wC+8RMtukCFAyrwKdNVQUXhJ0zD6vLsabU40PBLJJs8lwlCIBlg0hyBPX+5cMn/bPRGXNPVQQr2iw2os1JOC3flFT4p4x4HSsbirneDecJ1HxdklDbTU2dUcyLO0V7Jwk40IgdZZR7EibgoUolPwwOlaop9Iu3DvcGuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHn0IfNHVihzbal2FifemjkIRBX5bA9n9Am0qN773so=;
 b=Gc1/aOuScS3eBVTmrAuAFKGdFd5BPY4YvTMmRYE6KDywMxQmo1Uql5LYv1TNugstacwlzgNmup1FJElBSEiyhs4m0g3cUhfu46xz8wIagiVKRT40yvmH30bDGBNcICcCcSqUb3AfxWRlJiaOzlYnbquJ8dLXS16CR2TbvpMazZe7QZBijtxNMDASpVp9Mn1EWUBRPCWuyKNoKTmbgou8u9XDQ5RZnlVC9/5Vdjfn/IHXpsB7QlAiseCMuZURbHr41qqrj6Z0uJgzbOxfCioRwTm9MPVqWcKISMmpu8AgFtV6FhE951QMFoWIWdKZb3cZLNzp6uYKu5DXecm+aSvOHA==
Received: from CH0PR03CA0397.namprd03.prod.outlook.com (2603:10b6:610:11b::30)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 21:49:41 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::a4) by CH0PR03CA0397.outlook.office365.com
 (2603:10b6:610:11b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Mon, 25 Mar 2024 21:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:49:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:49:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 14:49:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 25 Mar 2024 14:49:31 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 2/4] virtio_net: Remove command data from control_buf
Date: Mon, 25 Mar 2024 16:49:09 -0500
Message-ID: <20240325214912.323749-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240325214912.323749-1-danielj@nvidia.com>
References: <20240325214912.323749-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c31c940-68f1-44c6-1c39-08dc4d1579b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/CgP3n5usubz3BU5p2By+iiap6h4KrpZzuUcWSa6/rV0+A0C8lqJrSpoALYUcfQ6/at4EDMYeuWCqPzuCNgBtGoLkphs8/heJZbZq58akADPsBpP24jx/PBnKqo29/RjwBZxaZyEjExhyFdoQnqdgZEArOIhyJZACUy0gxCib8c3E0TG+1ZL3na7iXUX6ax32AJXVnFuFnPU79KTxBIobclU7CIseH73PitTQmhE0TvZ1WCh+248VjaOq5IqLL2YH9UUiFOdTZomZCK83DMMEpRaAEHhKfTtoElNPyuEzyMjSgXZtp9fFEVTIbyKx4iG0tOWQLysbOWHAKZgfcQsTfBMJHnlTe1ioz5XeOJy+0QBfV9gY3/1uMBeX5KOXSKaybkifqCuwz8fPzWfzV46HvVQtwqZ8+8+oviLT+yj1b/vZFtXJwzPImqi2loDezjWT2PYI4/iwsaWh8Bq7C40PDK8tOBFQAO2RrZVUrt1GPGyctPiCfHaYjyOABtieyYsFjc6p91jew9w4XnsAO8zZZouzouYGgiClCasuWHTYyfICdRlWHSyVGC2tW2GKEiEtG+RowtPADMUdp6ILkVoLZAUm3ITxUerIlVsVvQAXTEpaiyRUCLLvKd4E6sHxhLU04fUYMseKCfjOsB0irQRtCuSeE6wLJyvkaVMA7bpoo+GvNJxbXfRCmn9f61JtMtWwBM0vICrsqA3i8MrZlyEM6y0Kl5qwvbQCC/3QNljzYQ7muWHiIgPCQVnH0UDMj6Z
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:49:41.0031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c31c940-68f1-44c6-1c39-08dc4d1579b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

Allocate memory for the data when it's used. Ideally the could be on the
stack, but we can't DMA stack memory. With this change only the header
and status memory are shared between commands, which will allow using a
tighter lock than RTNL.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 110 ++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 36 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7419a68cf6e2..6780479a1e6c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -235,14 +235,6 @@ struct virtio_net_ctrl_rss {
 struct control_buf {
 	struct virtio_net_ctrl_hdr hdr;
 	virtio_net_ctrl_ack status;
-	struct virtio_net_ctrl_mq mq;
-	u8 promisc;
-	u8 allmulti;
-	__virtio16 vid;
-	__virtio64 offloads;
-	struct virtio_net_ctrl_coal_tx coal_tx;
-	struct virtio_net_ctrl_coal_rx coal_rx;
-	struct virtio_net_ctrl_coal_vq coal_vq;
 };
 
 struct virtnet_info {
@@ -2654,14 +2646,19 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 
 static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 {
+	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
 	struct scatterlist sg;
 	struct net_device *dev = vi->dev;
 
 	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
 		return 0;
 
-	vi->ctrl->mq.virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
-	sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
+	mq = kzalloc(sizeof(*mq), GFP_KERNEL);
+	if (!mq)
+		return -ENOMEM;
+
+	mq->virtqueue_pairs = cpu_to_virtio16(vi->vdev, queue_pairs);
+	sg_init_one(&sg, mq, sizeof(*mq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) {
@@ -2708,6 +2705,7 @@ static int virtnet_close(struct net_device *dev)
 
 static void virtnet_set_rx_mode(struct net_device *dev)
 {
+	u8 *promisc_allmulti  __free(kfree) = NULL;
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
@@ -2721,22 +2719,27 @@ static void virtnet_set_rx_mode(struct net_device *dev)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	vi->ctrl->promisc = ((dev->flags & IFF_PROMISC) != 0);
-	vi->ctrl->allmulti = ((dev->flags & IFF_ALLMULTI) != 0);
+	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
+	if (!promisc_allmulti) {
+		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
+		return;
+	}
 
-	sg_init_one(sg, &vi->ctrl->promisc, sizeof(vi->ctrl->promisc));
+	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
+	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_PROMISC, sg))
 		dev_warn(&dev->dev, "Failed to %sable promisc mode.\n",
-			 vi->ctrl->promisc ? "en" : "dis");
+			 *promisc_allmulti ? "en" : "dis");
 
-	sg_init_one(sg, &vi->ctrl->allmulti, sizeof(vi->ctrl->allmulti));
+	*promisc_allmulti = !!(dev->flags & IFF_ALLMULTI);
+	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_RX,
 				  VIRTIO_NET_CTRL_RX_ALLMULTI, sg))
 		dev_warn(&dev->dev, "Failed to %sable allmulti mode.\n",
-			 vi->ctrl->allmulti ? "en" : "dis");
+			 *promisc_allmulti ? "en" : "dis");
 
 	uc_count = netdev_uc_count(dev);
 	mc_count = netdev_mc_count(dev);
@@ -2780,10 +2783,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 				   __be16 proto, u16 vid)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	__virtio16 *_vid __free(kfree) = NULL;
 	struct scatterlist sg;
 
-	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
-	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
+	_vid = kzalloc(sizeof(*_vid), GFP_KERNEL);
+	if (!_vid)
+		return -ENOMEM;
+
+	*_vid = cpu_to_virtio16(vi->vdev, vid);
+	sg_init_one(&sg, _vid, sizeof(*_vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_ADD, &sg))
@@ -2795,10 +2803,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 				    __be16 proto, u16 vid)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	__virtio16 *_vid __free(kfree) = NULL;
 	struct scatterlist sg;
 
-	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
-	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
+	_vid = kzalloc(sizeof(*_vid), GFP_KERNEL);
+	if (!_vid)
+		return -ENOMEM;
+
+	*_vid = cpu_to_virtio16(vi->vdev, vid);
+	sg_init_one(&sg, _vid, sizeof(*_vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
 				  VIRTIO_NET_CTRL_VLAN_DEL, &sg))
@@ -2911,12 +2924,17 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
 static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
 					 u16 vqn, u32 max_usecs, u32 max_packets)
 {
+	struct virtio_net_ctrl_coal_vq *coal_vq __free(kfree) = NULL;
 	struct scatterlist sgs;
 
-	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
-	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
-	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
-	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
+	coal_vq = kzalloc(sizeof(*coal_vq), GFP_KERNEL);
+	if (!coal_vq)
+		return -ENOMEM;
+
+	coal_vq->vqn = cpu_to_le16(vqn);
+	coal_vq->coal.max_usecs = cpu_to_le32(max_usecs);
+	coal_vq->coal.max_packets = cpu_to_le32(max_packets);
+	sg_init_one(&sgs, coal_vq, sizeof(*coal_vq));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
@@ -3062,11 +3080,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
-				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs)) {
-		dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
-		return false;
-	}
+				  : VIRTIO_NET_CTRL_MQ_HASH_CONFIG, sgs))
+		goto err;
+
 	return true;
+
+err:
+	dev_warn(&dev->dev, "VIRTIONET issue with committing RSS sgs\n");
+	return false;
+
 }
 
 static void virtnet_init_default_rss(struct virtnet_info *vi)
@@ -3371,12 +3393,17 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
 static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	struct virtio_net_ctrl_coal_tx *coal_tx __free(kfree) = NULL;
 	struct scatterlist sgs_tx;
 	int i;
 
-	vi->ctrl->coal_tx.tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
-	vi->ctrl->coal_tx.tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
-	sg_init_one(&sgs_tx, &vi->ctrl->coal_tx, sizeof(vi->ctrl->coal_tx));
+	coal_tx = kzalloc(sizeof(*coal_tx), GFP_KERNEL);
+	if (!coal_tx)
+		return -ENOMEM;
+
+	coal_tx->tx_usecs = cpu_to_le32(ec->tx_coalesce_usecs);
+	coal_tx->tx_max_packets = cpu_to_le32(ec->tx_max_coalesced_frames);
+	sg_init_one(&sgs_tx, coal_tx, sizeof(*coal_tx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_TX_SET,
@@ -3396,6 +3423,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
 	int i;
@@ -3414,6 +3442,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		return 0;
 	}
 
+	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
+	if (!coal_rx)
+		return -ENOMEM;
+
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
 		for (i = 0; i < vi->max_queue_pairs; i++)
@@ -3424,9 +3456,9 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	 * we need apply the global new params even if they
 	 * are not updated.
 	 */
-	vi->ctrl->coal_rx.rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
-	vi->ctrl->coal_rx.rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
-	sg_init_one(&sgs_rx, &vi->ctrl->coal_rx, sizeof(vi->ctrl->coal_rx));
+	coal_rx->rx_usecs = cpu_to_le32(ec->rx_coalesce_usecs);
+	coal_rx->rx_max_packets = cpu_to_le32(ec->rx_max_coalesced_frames);
+	sg_init_one(&sgs_rx, coal_rx, sizeof(*coal_rx));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
@@ -3893,10 +3925,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 {
+	u64 *_offloads __free(kfree) = NULL;
 	struct scatterlist sg;
-	vi->ctrl->offloads = cpu_to_virtio64(vi->vdev, offloads);
 
-	sg_init_one(&sg, &vi->ctrl->offloads, sizeof(vi->ctrl->offloads));
+	_offloads = kzalloc(sizeof(*_offloads), GFP_KERNEL);
+	if (!_offloads)
+		return -ENOMEM;
+
+	*_offloads = cpu_to_virtio64(vi->vdev, offloads);
+
+	sg_init_one(&sg, _offloads, sizeof(*_offloads));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
 				  VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET, &sg)) {
-- 
2.42.0


