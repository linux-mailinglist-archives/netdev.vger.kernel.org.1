Return-Path: <netdev+bounces-81824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED288B325
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCC51C3B31A
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6A71B48;
	Mon, 25 Mar 2024 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="olahSlgB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3866FE1A
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403393; cv=fail; b=rYlCJ2nWh9pcWuc921jlfSVzxfZ1nUaEgQuC/0S9xKuv/zHTa3Hqfo5/xP37amz2BvzCSW7ZxjDhjLapYH94/x/2S+PUwj27K/1hqHtLWPx5hvRJ2STVN1X17MHe86uDbJxEWh4V6EKAe1NMRSLlgPfNScP5sYLUzM4vyM/E0pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403393; c=relaxed/simple;
	bh=lv6lPrJt/U0U3xHcYjocm10dINiUjMK3xlv8n817bI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Qr6qRRLOW7pYHLaodSaAFDSVWzh2DA2oXW5oKxC0yI8fbvNQEDOyLpi0q/c7UkM7F5jIKeFDo9WYlV2z6EqU3ObibKYmQBsF3yorM11m2TtYyH8PN84CDfl1InE1f5r3zKrXId9M17Y2YQ8aTcl4C8NvO88VMayAgT/WI1Njw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=olahSlgB; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSVwhAfbtOq6hHdydcke2p6n/14F8wjbSMm21FrLq4K0p4w7xkM68kcYY40N+dAt2JAevRFUeZcXuOnTl9vIcA04t/RpXoVAXVzvxkT67oGyBnzhDTJVLmOg2w8n7KSqKNdmWLxHnEWbH2sn6gLx+WjzsYpwCgRLDo6bjmb9kZxkfjkJL00BLgt7mGY/aT/KI8M3NJNbSpwA51GNLkZbCg2MuAWLdb3gEA8/emkJFli2jDRe0+t4i3ha5kgx9++OcnH0DteOUhD6uwQfZA1G5kLp9AK27nqmHICC4kHw5Mivd40un0N0GyVZlFXhijCToRVVaDkBvYIEbkRVfi1pMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWhtsT8K9z8zGmNb8t/BUu3mY/6+GV/YCTTpk9JQh0A=;
 b=EMIWTfc8U+hHy92F0l/3xk3tEdyJkjiUPvfOMyzYMAsoicFxhjqtcgiHSs6/zyGnmLKl3J+5YaJ8BMYVyZ2T0j7+UspyLhy9manUnt/cXBGxP+UKqUs+02ATyTptnT2SdG+wsx4t/+qik03LEuV8GQmEY38zGTozUBy0NGH9Oqo79G/4tq49ZGQAnOCfxj2S3wAkgoY70Qbq+LNFuvux8xe6mCvFmT/Y1DcbJrIN2ZHwC5mIjjElsWgqBNAaVmQltCBokiOIma+XdXiaxpjUy1LOrcQi+FPHWtGqqNdMkxtiUuvjP+xYSkWkl2PBXrASgc6qTfSLTU6mA1ggpyz5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWhtsT8K9z8zGmNb8t/BUu3mY/6+GV/YCTTpk9JQh0A=;
 b=olahSlgBvvlUNPT3D9jGpxnWWlhKpa+kheooI7Cl6QVmrGZWFJ1UE1zV61tJURo+U70tfuZzL1nbqiK2VO8kDUUlpDFN+dz+5uFpEEqanR+LqS1Z1XqkvroDA0UtxLeS80+Gg7ismQCsnEs9/FejTCxF/C1vqlQg9M/C5Bc/iJf55NPVgeUwticBJw9b5pRtNl/om1SFR8Y/hKHRihU422aew9VnQ4wh40srtCwc5ylh88tIvvTYgK3JTEMOSmOn2UXWMpUU+K2ZnTb1ab6zO4kjiQN+zrssl5xKsQUXMcBrNEY6Osk5dOTy9obl0As1JhW6vZKcDBIhg/mGckz6KQ==
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 21:49:49 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::35) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 21:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:49:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:49:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 14:49:39 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 25 Mar 2024 14:49:38 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 4/4] virtio_net: Remove rtnl lock protection of command buffers
Date: Mon, 25 Mar 2024 16:49:11 -0500
Message-ID: <20240325214912.323749-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afa6839-6a34-425e-ab5f-08dc4d157e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k5C6zkAX2i0UzCB2KK8+Ew6Dq7PQQ4RyHd4MXwy61q5AO0brLWLAf6NZg9QnoeIZ2yD5DhdXMQeuUgSOZBS3px90RVVhmdYJ3SbUei8MuAxO/+EF8geG9DKToQLY2fHwZXSroBn8odR4FHLOO38x8U76TQnSFnWvcBqzsuraNSKT70EjerkNNOMEY+yc8AFaCvjbonw80CIC0ID8vuMN/rpypRXdeiK1PpGmYaV7CEiXz1LTctseYYO2wEg/XGWHbe70tD/mbFMhYMwVxJ8V9oodA3KB/4k0B7YYzwln2FkgOX/yuP8kk9J3p/Xx+IgM2sNrilMXfit8e3Wh01imFN8swiQHuFb1IkQK/6t5nJME2T8KISeVtWHCMNavPbFQX4XpIl7MKVK8AIAaxMMNVGZVX1ipYVDHZ0zWbkuLvalDtlwHCcdd2AsaHqT36hCGzxO35+ehWJEdZVaH5KI6/BPN0zfrJSkRjdMM4N9N/KuP1aIpkzHlxBDL+i5l7c4WyWAeZqGNUJeRhWnAW7yhGFaPQ4wgMXp8GaJHIlJ1FcM893F6wdcqDVcbOH1IuRrN2RTB4/FzApO7cZhZtKFC7sw0eNEnh7OQvHJRtwih1ELt+ebBimvoxL9Bpc1chtiOcUZZwA4iy4I7toSbCy/2XEuI9OpmDDYebm40/6lgO2AfLVKw1hngTmCAqiE+swVwkaOfcPc6NG6NdkoeyxHhAQU2gA+3U6nSbwESP3QPMCXCQ2QIwVYDNiFOW3wlhozp
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:49:48.7204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afa6839-6a34-425e-ab5f-08dc4d157e52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 41f8dc16ff38..d09ea20b16be 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2639,14 +2639,12 @@ static void virtnet_stats(struct net_device *dev,
 
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
@@ -2677,16 +2675,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
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
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3268,7 +3256,7 @@ static int virtnet_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
+	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
 		cpus_read_unlock();
 		goto err;
@@ -3558,14 +3546,11 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int i, qnum, err;
 
-	if (!rtnl_trylock())
-		return;
-
 	/* Each rxq's work is queued by "net_dim()->schedule_work()"
 	 * in response to NAPI traffic changes. Note that dim->profile_ix
 	 * for each rxq is updated prior to the queuing action.
 	 * So we only need to traverse and update profiles for all rxqs
-	 * in the work which is holding rtnl_lock.
+	 * in the work.
 	 */
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		rq = &vi->rq[i];
@@ -3587,8 +3572,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 			dim->state = DIM_START_MEASURE;
 		}
 	}
-
-	rtnl_unlock();
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4036,7 +4019,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -4852,7 +4835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.42.0


