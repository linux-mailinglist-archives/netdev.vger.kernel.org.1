Return-Path: <netdev+bounces-87526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5A88A3690
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8BC2837F4
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C91150993;
	Fri, 12 Apr 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GB85p03z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1295F1514C9
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951628; cv=fail; b=TgAHjGIaRtfxtkDoZCFJ6mI2TxTqqsO22LCfRM00gisErDIU66JdSaFvQNxiXv/s3nUx5bS6fIv7kxThNLdOE6mmhAhPuL7RerNfSAtxx9j+XB/YmU4QZOFXLA7S5WMjfCrzB1RQ50x+tlKcN76B2VgiaJvACujv5x59UUd8IcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951628; c=relaxed/simple;
	bh=HPYjyXfNUmk2nHk+KPJTRzC7UvNurvtd92mJMhs5zYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbmCAhMwn/wEidy1g2n28UoY+PCWohoF3nkKrbfsmNXmY+ePRQbMVJ8nMjDebOlPMBDqDyrpN11qRx9oD311cuSxpNjN4puHtmpkqsH9OLh/u7/dUhMazNaWf+b3kUCfQPJCujPX/opSJOARfQKhF1XDgyIeSDZxb24YNaWqUWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GB85p03z; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG/nwzG6DyBFpolQPLUPuPigWHU/o3ubG3LON834bFm3/Y+5WqMGXjzKJqZp0Qg8n5mFtLAAXmPHp5fMKxxv4fo5m09QCznW4h4gnQk20I1D8mtSiIrxMuaozmTSuvBUIZ6GiDz51W45Dn9ZxK/509LiPoZYcM9a6p6W1OlwE1XeDwP92tGMD6M/d82qID+a6FfN4OBx1tIOU1PltA+4VUTx1qZGpozQzf8Ytap+GtqxCQFR6NaydivR8p37QOHBosB5C8kHkkTFwo/mU3H7t4GOEQWGeGYyGF1h4Jv/6NXwM1kqWfWZ5knfbD6c5Rr+vHJFIheFR1Jd5m0fWx58NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=099NzkwAeIvGIsUsKioHl7MCA6XWKyda1w++1p2bVhg=;
 b=kuglZDttfYtDWWy3waEcc3ujSFINR/EHMWPJsK6ObYllksg8sEQlCuQ+0dIHA1hQv46fTddqL5Sop9aOuWis/8+f4c7MDtLLHT3aVlCZ/6B9EhITor8sMK7JzGWbg1qNNS2MJGqpNzQq11dHqY4r1352E9BfnZFVcwMJE9WzTmfgYreNPBS2CEu9SqtEorCWWJrEJh7oO7+iXjEPVvs8dK3pN7rYPQVIEBI99ZeFdYTE9nC9It+AUJEkkYs792NS/DtZWTiQNvCZI9YXqcR5l+qRVKL4a6iDEKH3paolvod5qG5pMur2Bf8x85jkpdAyfpp1hYpsLtrmR5wBbI/7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=099NzkwAeIvGIsUsKioHl7MCA6XWKyda1w++1p2bVhg=;
 b=GB85p03zkROnCnjATOeAaUfF4z8E+9n002WQi0ye/nygZoekOl/epaYgNcZcsXznUzoumfa6jtZ9qFxJGw9g6CcWdhc89wjfkix/Ar9H+Kz1FA77i8LDBbRYIkG8ScXfsIrPPAVI5Utb3oV1mHyGYgFWc9bbhEyG4eZe518abZRZGQ8AD8D8QWNOqFS0Le4EphW542kYM0WjrhYBQ6YTxOMhMdtUvXtyT/bbC1qML820B509ZnvEeBMWHhgP6QFEzXRCoO7L//CMLQwlfN0OEqfcvrwgUPm5txWOuA9YiJRoPZT1geh4QeoxKsKtnZl5sFgZBdO+Eop1MkereWz6ag==
Received: from PH7PR17CA0004.namprd17.prod.outlook.com (2603:10b6:510:324::15)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 19:53:44 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::b) by PH7PR17CA0004.outlook.office365.com
 (2603:10b6:510:324::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:24 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:23 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 2/6] virtio_net: Remove command data from control_buf
Date: Fri, 12 Apr 2024 14:53:05 -0500
Message-ID: <20240412195309.737781-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412195309.737781-1-danielj@nvidia.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|IA0PR12MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9580a99a-f3b6-4f7f-5f69-08dc5b2a41ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PfjlHTB1yLU30UGigOBfKy3d9Izrl9QWB/eQy46c3onnN757Aoy087noYAxMq/2ew4ZUgLHPcUCCgVMDTItAwfHZWBkl95KX49MHEqrloPkEZJKg4tcPfVWF0fmCiKzj4izJQYHYFdDIploWkiZ3/Px8CAMFAe0WGfNtNQaQuLCCqekUkZHFmWL9V6eG26EWanuY3J4EvQIbDR30n41LsJ7YFiM6CVihmoQkFohv31ZHAe07NbjoW+SxVVFasHckCDHSfypDUdJNcosYX55f6TQlIwAF0UeUcPuGhlhiw2Krid3WnJJDtb9DrB8RthpnWc2Pozo8k4BhBLXWJs4rjNOJz9uj9I/XD8LGnOhST9ge9WB7id67cPeoL1hBPsHvWWTfE5Zr7eyqovYxMe04RUbjUg1c4gvkzl/9rrGtW3gV/SOWanbpVRVi+yPu2nrPZrTMJz6F/lu5yeSgD4NTsoHXTXQ8IHm23BSuioDvXUQy0jPwacUCxEPXMimkEyIPcIRT2CB9P8WOc1ZZMqpdUSP5qiM7mj2xXiwvtz4/YcPGFZ+95EJBId0yV43lYO+kU594Ufvey9XWNf0DNlmPCpfG55KqeYpwZU6/NhbJHm16B6wB34euB5SCi1l8/2ntODHJaEBmX7KK8el5Jww2+gPWFoSBii873Uxp/WYBYk7UZyNtIzGCh1rPTFLK7dF3YSA/b5BXkrOgRttJIXQNoskjBDel0tZ4qOMnsipen2r/aNWqmb2nVHCjXb9muO2O
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:43.1322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9580a99a-f3b6-4f7f-5f69-08dc5b2a41ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

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
2.42.0


