Return-Path: <netdev+bounces-88454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAA8A74BB
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3071B21AF9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64B13956D;
	Tue, 16 Apr 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CePgrLr0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C651384AB
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295886; cv=fail; b=BNkpQtvQLwDCdEdFPKbxTPMRZMLCzgY1HPPALPeMhfsvyCingx9lnzN6KLJa4wsLNqDNOuS4Hy4KdgvBF4NatgHinwg+RC83KZ84NaRqzyGOQq99lLX9w0esvZlN/ieYn2fngEoUGvDrhe8yE1EWDmCHf+dZOaZ5nmIr03NijCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295886; c=relaxed/simple;
	bh=faPBhRiMloCW3hvR2ZjSMcYeF3YINQvYToCDvrMYfK0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOmvgxSmAxXLLlDO6kF7pSXgtjpb4WNatx4kDQBh4fgcKDV4so95jrNVNsY8Tx2+rYIqiZAaBHthcxpn+omfU3iXH7VjPm99t+WtzxT2LPfeCGgYsuC6JzmwJwTtRV72j4GlwZ/+BS7KY2/FwEz1/i4jMpiWuw8BZ9j+Qq2gH3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CePgrLr0; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH8jVIxeKvuJP7TViPCBMDogckRx+DlOeTflgYcA6Ct+y2LZTtkDB+mmZ0bP64mdAha0DyLlxbsANiNqVtS4qps+cFkz7P9auC/EVQWTB6BGQ2rNig4LcBc9Pre6lCibFyKahvVi4JqDTLzgJjI3zy/YUU9Tn6Hhao374WxK2MlJBGDC828Zb31v/o9kJy4sMkMzConLR7Dgt37ZkZiuMTMsuMjA0KnBwweodFFwooypyKkVT22LZIq9kNRBpn4HlOmz/ojpcbN7/I1m77gC3J9Gn+vLFAnzh1jZ4YRHpDQ3JV1pwmYQYgPgTMhKOV17MuZp8wpsj24o3h89ZbIeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMHqiEPqezP/HQsOKJ08ZsTO9mxHb/ZXdGEU5bUd+Fw=;
 b=S+u7SKAsZIB2STwVwTTofYjMbb1jm47ac+coEWkHFqTnCpq4njlaMFZ2HQP6jXZLZoLfGLzpBumOogAuzR50e/w8T20xqQ7odDSV201axZeGS90PXAL7SSWjeOaCn637TlLvzhK/5/wwPKQWF5F+vH1v9DEb3K0QxOLQ3NBUhjZhazXJzwpMypWg78Z0xicwOwAC8SP8VcdKq157uxMsqkzLpQE6CzTdKeSd5E5AKox/7PPkCq/6Y7DEqz1WvbI1bxbbf5ZvN/HcISvCkmOhHVAhHgeEEXoDVIBogZhsNUS3byIt4HNGqmIvGrcoHJRHLxELFUupiBp8bzGKmqWJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMHqiEPqezP/HQsOKJ08ZsTO9mxHb/ZXdGEU5bUd+Fw=;
 b=CePgrLr0q4HzTZSXqBpUfzHuopFC2gkxZ9B2wOkIcz50vKOj9iA3nAKouwZ1jUdYwcgwM3vbr5KjPwxQbwAAv7ze/Trw+5LmS1mEt1iLj7TUK72loVV6qmZz6QydVB7g7bWdpkSqV/66M+rmiNDx+IPiLCMTqYB8reADt+EMlW7b2GBXfTchIw6v4cI9APiKrUkhE9xk+mN3Zk64W29MCjMLRtePR2Ut7XP3Q33Kg2SO+oDSVhpWsQSkiOogZew2+GX7s328wgEZEJRsT26wjonsDRKZk3rv99eTvPRsf59Q1Ylekl1lv3YxUlL22VOXp+GoIDTzU4IXPmHks48MxQ==
Received: from BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) by SA1PR12MB8918.namprd12.prod.outlook.com
 (2603:10b6:806:386::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Tue, 16 Apr
 2024 19:31:21 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2a01:111:f403:f903::) by BL6PEPF00016415.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:20 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:49 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:48 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 2/6] virtio_net: Remove command data from control_buf
Date: Tue, 16 Apr 2024 22:30:35 +0300
Message-ID: <20240416193039.272997-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a25fabf-6b9e-4ba0-b246-08dc5e4bcb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3t7k7SiVtJQKvRJL+b+udBwT+le7HSnM106W/L5jqe1XFc+Z0/zCbvGtIHhVw6AzmAtju1ubsbvtNOiMaYeMsi+ziYKSBnsa69DtT5dGR7iszYYuSzkKFdMNPiEG9mrIKHWSIwbnlXSdIM0gkL1RK3D8rS1vTFdgY6OcSANmukLj+DXx2Sgd2QuZm6DSnHxlfOcs2iti8Jad1xqYsiNl6HwdSUejxMqBZ0Tmi7KXNSQuEQ06/Sw/L3wJRy6fLxFe8Bb2JTa/7bBEdM1jJO8/gGV1nWEdUMMyDiSpin69RAq6tc6eeHuFjWzPPnSuP6tOPp3imEg/QHTPpZ+ysz7eEAIIIyahu3BmXQJEfeONrrRclNn7ZsZLJVrtvUz36a1VhoO1l8Yn2/Q0yilyd2tJDxPGwbEcOqMhIY0t9/3wcxPA9Ya1SIoxOHDrqTyD4oMuPkw9utJ9PHFyfWeXRGdVXvWVX/LB0HbBEATrfwagstRib3EtPL5ovnZhp/YEwZje+jOwhWdPYn8YOhl5C17w8WuNlOScd2NzckIvOuFW2e49r6P1QhXIbA8Jcxk7H3gzPxoJuJmJqNoU1Oin3Io+AnCfhJTHAHU3wwbGDrbxRoACUWxQnPQvyEjd/sYTMEEFqPLjxf0SPLvTIEzAGbVwneuT3N3Agpwo/M+5eh3z8guCX65Z8SsJIql7E/zZha3e6kafCIKo4ip98KjStdeYRYisnvKxSbWegKu6rzh/Jcd1Bc06UfK9NRGg4qxcr9u8
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:20.8970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a25fabf-6b9e-4ba0-b246-08dc5e4bcb94
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

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
index 7248dae54e1c..0ee192b45e1e 100644
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
@@ -3951,10 +3984,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
 static int virtnet_set_guest_offloads(struct virtnet_info *vi, u64 offloads)
 {
+	__virtio64 *_offloads __free(kfree) = NULL;
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
2.34.1


