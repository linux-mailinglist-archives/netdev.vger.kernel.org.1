Return-Path: <netdev+bounces-93357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3308BB4C4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B73A1C22DD7
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A5158DBF;
	Fri,  3 May 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QytU5Otx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D3158DAA
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767908; cv=fail; b=Dhjppsv5eXC5XaNlzHYAgEWZTecnTGmPwUmmqDRiV1+8fUzTqqrk9n5CHef8wB/LIzNG7x8oKeJ76qRcv2l3gxBYcvL49l/DXDWVS+3T1XcrfAmHthJo8SCmyZKm/P4PyZUIO2cVfQpXldWzEFs/qxcQSG9pyVFMQ7ryd2pvsvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767908; c=relaxed/simple;
	bh=yVLtM2rVnvlfbiUcprJ/yJx+5pzKOgsd+46TrTMdQ4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBp7AbyrucEPgDHIquyD2bj+WVkMIxIg49k7cpSwaj5gRdjkB5ytbQ9wLGJWrnPpOOtaMRbeN0FmHaIXsA6U863/xTDlnGgkFMrhsPh79oVC4+xHOWqfP1pAr0sgDKA/I4bubvDobUD69nBGZ0Rd/SodTrMqy9mLVdlo/Y10ZJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QytU5Otx; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XojHUQqrXWq3MvqhAZu5a3cK6LU38lnNQO9zkUHHFI5YRaXwcEJoIGgpoX71l219TGnLFWXbz35rrheAiQTXusL6yPHGId9P9G9S8IZFYC4efmvot7SA7jDLVgj9zMxU7REXpulRHvDukuZfrR3SwHdrCQ+7I/St8z8Nk1PwhnhfeI9sn0rXO1jb9xCB2qq19FsEORF/xsWVMcNM9zpNjWxP1OWKRPslv6KdCiERHINQwmH+rdSgfDpxsHRz9A6NtDfMK6hQK+kNOXGrC4cT7pX+iweeWVBS5DrlUCT2FRHLR/SVWEfz/ezG6vsFEnVA7RRqhcIB/A5fLR6CWlo41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25TjUMHRDVb2YCsm5h14vrQErUWbP7QqtFxuZNFr1yU=;
 b=KkOLGL9sx9up4MPwX39FtJ8GVRLVIxSyiY1H85V3GsOJ3/b6RJbbJzNaDgYJcuWQpLPiMtdn+8LJq7vrE+uc7Zd6KJEscodMWijMO7460JwxX2xARrB8P64hpwM7wqWNGguQSJTeCAfb8SqR+byEa5TDP3s11XLq5BBKdEa4Ia87LOZbZ+ZZsmT5xS83LPCc+eVtA+Ofulu52OFcoB5ICUxGX45778bVHK1mZOMI/TUZbQGWlB5jOCjnSmlyIPyyGNHzNbMnvVw96wOYzZV2IVV4va2nv9ni88eF8w6nHuZFqR28obR8+rMsNnsmzOKpe1lQHJl9zPfoynoLfpCFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25TjUMHRDVb2YCsm5h14vrQErUWbP7QqtFxuZNFr1yU=;
 b=QytU5Otx89xce2HajeYoBjfJM/wrg6YhH56ld0Iu9yATIEfQvij1ymEfo4GwJLzqI/CpxAD+SnicSITqBogD1k8REzivR7VJBPGRWR6IJYuJDUhBli8GOxOOL0n3O3ljJvskfFzZm8MTzElUwdbTHXDYZtuGEhMhMmK8+qp8AOJcD4JWr5r6f7mfXsSv1Cxyv7UEZ1aPaZZUAp77qv+vqqz1BHPg+DCBs+Qktf/4GME33xOEJT1YQUZJgoYdqTsGm5Xn0Imgw/be2L/GsbUAoTUBS4S+/Jzz5AiqxCZ38xmmrp4ZtLt3FVrk5VMVw4390FW4ksQkvUOL+Aa3ynl8ag==
Received: from PH0PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:e::10)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 20:25:03 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::b4) by PH0PR07CA0035.outlook.office365.com
 (2603:10b6:510:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 20:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:52 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:51 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 2/6] virtio_net: Remove command data from control_buf
Date: Fri, 3 May 2024 23:24:41 +0300
Message-ID: <20240503202445.1415560-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: f32a0bdd-27a6-48ba-b4d5-08dc6baf1cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x5OnpbbtmHu83+P9MUSTJ4hcof6h842VUDVtgDzpRcXrSNF/Gi9FvJmWK2u1?=
 =?us-ascii?Q?XYEQh7B/COLA9ZekurteEVwAqijDPRE9QhKCu3E7cGdbsK+9WvnXo4p1015J?=
 =?us-ascii?Q?UpjIo8APhMAiBHeQP2+aG8S7yInYmFg2OXD7lNj6nCFi3aTy0u7Dukzj7AAF?=
 =?us-ascii?Q?SLWSHZwVbqjgS3tKykamvc5h38zIcsJl7/uAY7jT3zSYrAOEDmb4UzxNEHtW?=
 =?us-ascii?Q?2Qt8L3aujtf8BSrelh/8Y4sXbsh+85mWpPuaQcoo0wGrgpfvLONPOsGdswr6?=
 =?us-ascii?Q?CN1W5nSqrZxilATe3QbA5BvAho3zMKwHx2i8/zGBZrJiqU+9zifTbmAfw4OZ?=
 =?us-ascii?Q?3AX887cnTlqtH2wCZwu9kQAqAcwN5SY2Z6PCzxvhQ+axp/PBhaVbjhGgpB17?=
 =?us-ascii?Q?bxqRM/sxsGWZz2YPBSqepB50IeIIe3AqVoBjui8wKzyiIXm62t907lg9sbVN?=
 =?us-ascii?Q?YzFP5JYkApcvEbiN0bqC/N04y0bOxVJJ5cmvDcvf82+rY8OWwYblAVpZvuUw?=
 =?us-ascii?Q?ivJB0TQCZQq9eAVBAfWRwchBr4lB6Fdy0DI9NXgGewX5RlhecoqPM/+sN0Qc?=
 =?us-ascii?Q?Ci2x/bvp7G+8PHEdcIdAxcN9Tstpewp4vVq1aBx4aBDSJ58ATVwscrM4/GEM?=
 =?us-ascii?Q?34le69kLoGAZbQ8sIxbbolsua2HMiwNAioGLfYX5wh6XpT+xsdAXcrgY521S?=
 =?us-ascii?Q?/Nef6clxi9jDrtrulm9zcV0AhRNUORZ+fzHZeK5kzBULGcTdKdTc9ZaUWxVl?=
 =?us-ascii?Q?JdukuXZ6eSzlp55yBYVu+reZ4jpbSbmd9ABlRfELVY3n9HRLnF9TzQByIYKQ?=
 =?us-ascii?Q?SZm4R8hSGADQQI8CMe+G1iXrT2yT9QDnoTjJuDaBIte27xznj1OfKzstumdl?=
 =?us-ascii?Q?19hynEI0zDsgQ5F0nX0h5sVzKAe7nNWc0He6KSqPRU7Hrx9uViWySmVLaR8l?=
 =?us-ascii?Q?ehaOIbKkZNX114512AZ50wVl21G8MCSf5ezVGkfJ689nwrg99gf1IM4LsQuk?=
 =?us-ascii?Q?hRPqOEfh6U4EenqfRbrTmOiENldjbUIkAKccrs/St9ETMyTEsdQcaMX3JPgB?=
 =?us-ascii?Q?bGZVTr5q4gfQqM7WGf79UWvN8LdDJka4p7NX6cnlNhuzcOvu1ztbGDs+rIkD?=
 =?us-ascii?Q?8pEk58rDBPTsMMocIWL2SbNSK1lfOKjE5DaLeSh8jVrLq/Q4O+bKwCJ48La4?=
 =?us-ascii?Q?yGXRRZk0Y5AOWEzCtf+I34hxD13ZOUkdfN/Tj4ekMU/AHzVPllSIJct1KFAd?=
 =?us-ascii?Q?H6P9xhSKzFJVs6wPpRrD6BzGyqIRTwiZ9qRixE4UVPqNSLScQBV3+0Clxxac?=
 =?us-ascii?Q?4CvSlmz/02bci6gQrdQnMQKtn9+56fXz7ekZ2YDn5dJI5lGFN+tqdpw7yk9R?=
 =?us-ascii?Q?UDinfEqYwN8pYId2JSasHapFfiPz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:02.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f32a0bdd-27a6-48ba-b4d5-08dc6baf1cfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718

Allocate memory for the data when it's used. Ideally the struct could
be on the stack, but we can't DMA stack memory. With this change only
the header and status memory are shared between commands, which will
allow using a tighter lock than RTNL.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 124 +++++++++++++++++++++++++++------------
 1 file changed, 85 insertions(+), 39 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9cf93a8a4446..451879d570a8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -368,15 +368,6 @@ struct virtio_net_ctrl_rss {
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
-	struct virtio_net_stats_capabilities stats_cap;
 };
 
 struct virtnet_info {
@@ -2828,14 +2819,19 @@ static void virtnet_ack_link_announce(struct virtnet_info *vi)
 
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
@@ -2864,6 +2860,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 
 static int virtnet_close(struct net_device *dev)
 {
+	u8 *promisc_allmulti  __free(kfree) = NULL;
 	struct virtnet_info *vi = netdev_priv(dev);
 	int i;
 
@@ -2888,6 +2885,7 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 	struct scatterlist sg[2];
 	struct virtio_net_ctrl_mac *mac_data;
 	struct netdev_hw_addr *ha;
+	u8 *promisc_allmulti;
 	int uc_count;
 	int mc_count;
 	void *buf;
@@ -2899,22 +2897,27 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
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
 
@@ -2975,10 +2978,15 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
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
@@ -2990,10 +2998,15 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
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
@@ -3106,12 +3119,17 @@ static void virtnet_cpu_notif_remove(struct virtnet_info *vi)
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
@@ -3257,11 +3275,15 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 
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
@@ -4193,12 +4215,17 @@ static int virtnet_get_link_ksettings(struct net_device *dev,
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
@@ -4218,6 +4245,7 @@ static int virtnet_send_tx_notf_coal_cmds(struct virtnet_info *vi,
 static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 					  struct ethtool_coalesce *ec)
 {
+	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
 	int i;
@@ -4236,6 +4264,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		return 0;
 	}
 
+	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
+	if (!coal_rx)
+		return -ENOMEM;
+
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
 		for (i = 0; i < vi->max_queue_pairs; i++)
@@ -4246,9 +4278,9 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
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
@@ -4823,10 +4855,16 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 
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
@@ -5810,10 +5848,18 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS)) {
+		struct virtio_net_stats_capabilities *stats_cap  __free(kfree) = NULL;
 		struct scatterlist sg;
 		__le64 v;
 
-		sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(vi->ctrl->stats_cap));
+		stats_cap = kzalloc(sizeof(*stats_cap), GFP_KERNEL);
+		if (!stats_cap) {
+			rtnl_unlock();
+			err = -ENOMEM;
+			goto free_unregister_netdev;
+		}
+
+		sg_init_one(&sg, stats_cap, sizeof(*stats_cap));
 
 		if (!virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_STATS,
 						VIRTIO_NET_CTRL_STATS_QUERY,
@@ -5824,7 +5870,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 			goto free_unregister_netdev;
 		}
 
-		v = vi->ctrl->stats_cap.supported_stats_types[0];
+		v = stats_cap->supported_stats_types[0];
 		vi->device_stats_cap = le64_to_cpu(v);
 	}
 
-- 
2.44.0


