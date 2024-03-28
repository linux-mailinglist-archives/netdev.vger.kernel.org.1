Return-Path: <netdev+bounces-82721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A048A88F694
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A32954CB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA745944;
	Thu, 28 Mar 2024 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLAfRYoS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374663FBB6
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601263; cv=fail; b=R8eLSPKPSPVY4o6GRG3ECTrveMLU0QXZSSFvrB9M0WIXKLVeBFnEPt3Wvn8CkqofNt/ex/18XeR+NiUuYaWnrMcEsbgIJf/+jE5paysXtfJHvmve21j90CCHRFePM+YvBM4XhApbINwYemTp7uLY1FX/1DHTD2vR+UmidvAvc6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601263; c=relaxed/simple;
	bh=xTwnoEeVzoE3Veve/tcz+h8CMbOAHzmcX8zkFrhW7ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aY200au6oOwIJrv9Vz2GHqLHjymd4c6P9o8VlzIhVjH8A+YqgWCU/sbXw6CZVcbd7wr1mHRy7dZ6WG7NsbgjVctGezBDhcW7UU6wfstQOibmf2TFT/XxrXq2l6rXO3DrPy+66ylygHwI9Fj5OEsk9kEnkVq7jPE6D//0qzDAppM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLAfRYoS; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LajEJl3F9bdm+CfsuNjkB/c6kh0LSnvK/FGWpN0LLK/POl9Ka4krpYMXR8Y+plTzTgYLKqX3Ou3//tpacMZ/+uLkQyDSuVPfOOQQsFUnxKFNgAH1bSaTEgVzxqAIOmzJ01FAWE2TVgppIyna97e2kcm/aRyu+Fd+aQoT41hoWBZCQv/oVbKlYYhPK6dp6JDgptI6VwdXOs1LGfk1YEPrKIHDeczpNAOqb1IwkVFJt4G4S82ajJFtopEtNIsZBNJH9TAbWPakkUBP49sHMCKSyrclR0+LbQsRkhODjLMJLfTWjWdtw0vXpT4LlkInrDs6iPuCUbzpRRc0Xjwu5AHFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IKza6w4nyMAUTF3QaIZIzKXH0XC460EBUluTwPn3vs=;
 b=lEKCzXfEu1Q+NPkDC6ER2VC2Ql4ycDxd1GJ2vkQodeq02hcbhDD2sEY+okSvWtzW5TrOfILKMPYB4yWyPYSa5G+dIjt9sWJqZqDiT5L/vHkOXbdfbQCdB13TYsUmBATpOyx8+uP+u6aMoOm5FmES3me9wWNIWchaNaLioYK6ec0K2/zqUU9DeNv/JEGcF/xLEKF+RSvjZl+Sj+t3C02K96OIxhBq7ziiL6sPA6Xx0UR+RmY5LTp2rgd9+TM3JCfk5rJU3v4G6uiWd6FjXhtBl38aVoKgm7goByR5fI2KP+hr/E691RXBwAaqQTKz4X9H1fgwOv8uMVqhoqIpSebtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IKza6w4nyMAUTF3QaIZIzKXH0XC460EBUluTwPn3vs=;
 b=cLAfRYoSGp8EglgBTDFl5txk2rP/EdCtGjacGhd6TKw2MpPlwIXyTD5kssKjM59qbZcws8wOX0kcuxaTyjdzYKX+9i9UDan6yBMOUL2cbcjdAYCLkPpEWMtvOrCeOyaxj+w/tRReVtSr2bdsBlbjs3nLX8qiXUSoVDilF79ckz5hFACetSVTmIMVL/HkVxUwvPPpv9D4MiY0kNUs95w/Ol0UJO/rRBRSQpV7fdAuIXDFCgKv73KNYPMCn7HiswXGuvLYdUeArpqK4X7gDBGkVXzoyvQwC6oFzFXHgavyOmlMNrBb0sut1kKB/YmPc698WT9zo+NeQh0mhFw0IdxwXQ==
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Thu, 28 Mar
 2024 04:47:38 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ed) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:22 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:22 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:21 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 2/6] virtio_net: Remove command data from control_buf
Date: Thu, 28 Mar 2024 06:47:11 +0200
Message-ID: <20240328044715.266641-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d71fa4-5cf7-40f3-90ca-08dc4ee2317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1BJCRKET4Cn0wjwCe39jwZKHi0aZSpwb3GeAgQZ91FkFIT2tJaxGKzFgntCKZq+ZY6Ksaf2kz9XgoIgtoUiwIX+8nwjjU8N0442pwl+0haC8MjZjI5AZrFtF52mAYfdxt53NRZquHcoKMErU9PebXuqA1wLzbgJa+cbCCAMs8UcMF+qyWWFd0wCTtAUqJEjDnhy5ftDTum6+fONg9qdmg2YtqsusGGz0+ltjp1q1dqkzEZ3Xw159ss7uWPWzTQQRMXiYU6j6yHSRZ73mN5yyH6j22qIxi9FQAftNEtO3iq1v/Xg3ENEBc7m2HRRp2N1sUB3pmDel0HXjt/M5nPRt+gP9zQwfXT0nB1uWIn28XHlaVzFZQVj6ZI9vPQMWJALQPRMlqXAVfx9AvwBKznrYrFGwCVnjW1I35oefVoZC8S1PCXr/21WP3xFmbYIwP1wCgnyI+b6gZJ8ExWeMysK6yrLo8wXwiWa1fcXcwmrtad28JEe08kHvQlMKJUPSHadz5WWv95g8KfptsDdAr6+ydjwwxUGRjE7g/71uvhZ8K7iKtpeMeU38Eqn/KHN9DHF07O9IPV2PGgclRG93tx2e+69gVKloP19JGnnhZsPSyetZxhiAacaHm8DHoCqh4DKfa8WhoNJ3btV0pd/II2Q4AwK44D1+ohsYhLaTdNXGuGw7d7BL3j5o5jOIIhSKzwstaFwFSy+JUF7dyExj71rZ1kVjhhMHsu/LmgPllVFn170G84a7hqXAL1EKscDFCzUK
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:37.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d71fa4-5cf7-40f3-90ca-08dc4ee2317d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361

Allocate memory for the data when it's used. Ideally the could be on the
stack, but we can't DMA stack memory. With this change only the header
and status memory are shared between commands, which will allow using a
tighter lock than RTNL.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 111 ++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 36 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 44525e9b09c5..ff93d18992e4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -240,14 +240,6 @@ struct virtio_net_ctrl_rss {
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
@@ -2672,14 +2664,19 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 
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
@@ -2708,6 +2705,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 static int virtnet_close(struct net_device *dev)
 {
+	u8 *promisc_allmulti  __free(kfree) = NULL;
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
@@ -2732,6 +2730,7 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
 	struct netdev_hw_addr *ha;
+	u8 *promisc_allmulti;
 	int uc_count;
 	int mc_count;
 	void *buf;
@@ -2743,22 +2742,27 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	rtnl_lock();
 
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
 
 	netif_addr_lock_bh(dev);
 
@@ -2819,10 +2823,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
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
@@ -2834,10 +2843,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
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
@@ -2950,12 +2964,17 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
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
@@ -3101,11 +3120,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
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
@@ -3410,12 +3433,17 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
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
@@ -3435,6 +3463,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
 	int i;
@@ -3453,6 +3482,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		return 0;
 	}
 
+	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
+	if (!coal_rx)
+		return -ENOMEM;
+
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
 		for (i = 0; i < vi->max_queue_pairs; i++)
@@ -3463,9 +3496,9 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
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
@@ -3935,10 +3968,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
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


