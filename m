Return-Path: <netdev+bounces-88457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF38A74C0
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB41DB21C07
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91C13777F;
	Tue, 16 Apr 2024 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="umYV7qdR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE11384BF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295892; cv=fail; b=krrQkYVcfc6B4ezIUroaqWgPuEXPPqlzjztuYwc8JqswyULSVX1uMJs8CeecxLKxKy8nTnCdNgBEF6X1wKqdroghhqOk1seGztyZq1sVMO9Y1DD4cBgxw0w/saKLYR3mtTbap/TDsi4sYHYwqjWnm0A9Myp+GQi4x81cT4CtIc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295892; c=relaxed/simple;
	bh=TX7mPY/ogWWuH+bbw/OFtDzCp1gNVlI7ygZ1Q6nW1Zg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPWPRvy9xBVzigpFqXP1vxWJAZXpH5yHMekkAXAIh0UE6my/6z0lMX5hDbNlLDJrABIlCkaybvnoFJvoA0mMHdYhm0TkROQGSUWN3hil6xIM8GZmh4bfKnxT9g+EYwHb6gYStJ37/V1hQhSv+9WXDkJK7FL4jPRq61hhvTYht5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=umYV7qdR; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfWMXsH5SfjwZIEFn/ytbSXBIplztAv9MtRp3MbNn9fVCao/K6oEsEmihVW2JGEcZjI0fm1bUONX6NwdmB8DYkbcj6kaXJpF/9G0ZnAwtFN9bY8SRJfrBKf15dLzq3KCdoKVeVDRZRMSaVSAtWtogaxCuhrZwa6MuWeIzuf3mkli0fgdZHADSm/n3b/7EI0QZVJiMiEffrtX2j6XWx5SK4ZuiWy5mWsT4Zg5OEHkF3FuSEtnCtTjsy3uZnUVV/MOX/DkSur8QgUdlBWwOaqNRD0VnG/q3wrb0o7q7QHn/1hncgYoKLpeMr5y9OMNuMjlCQjGfjtzbPZFcGFi+jZFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPy7j0u1Cl+rc0qtA3mC2mfzUeEXxidOChAAqfJU0tA=;
 b=EAVdpLpoJM9HmvhMTVKRz5djreANzTbE6oe1oFKa14RmfoGkX7IgsTnNUathguejWMGwjQZPYTDlNe3faqJO9v/IbRwJkMWPOw1UIOPDGhaTYco4ydedI9ftWq2IcnszOXDGAPOSPlDG+o8qVse9xIVilIrmKA1Nud5vQHNkr2+ae7HeCjHXabS78INskpzA/ty2dyAcWS3nUZONWofDF+i9KzuyStwyI7SEF+apofL3ioR0XJK0AtBShzD5vxHTIWkUOJHn6KlM3VeE/+W0zby51e+t6JFcBQ+OQp+LiEYQgCFxpUbdJaj6ZUj1Jp+s17s7nTSps309OCBF2PPVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPy7j0u1Cl+rc0qtA3mC2mfzUeEXxidOChAAqfJU0tA=;
 b=umYV7qdR2ewYAIb+wMPPf/ulW9261/w6q1D6Y/HxxyZbCSl33JvhYCbqj1x4YEv4/zfQ4Fo7zwvm1tUr0O11JTr216gEhBFc+0+ahqE7GK1mQvvJFjHlfdowVTay6PKYBvPA4RBA2RNHdGsXT//QTQ43kAePb34VYkuJ2i7q0KLscrA6Ndm6HrhLwi7vYWUQSMknQeFdLVnYAI3an6WlUvqfj3VGiul8IT3CLsG1w2isx3rok6LWMwfqtpumJy75tQpOjfV6HyiRwDT1RwThZYZWUPnj2Md0P9e5iDOzT9GrQPvVXylKSFXB09oPO0zUSbK9KwQpq48RGk2sGp0kYQ==
Received: from BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::17)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 19:31:26 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::2) by BL1P222CA0012.outlook.office365.com
 (2603:10b6:208:2c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:54 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:53 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:53 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 6/6] virtio_net: Remove rtnl lock protection of command buffers
Date: Tue, 16 Apr 2024 22:30:39 +0300
Message-ID: <20240416193039.272997-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efadc3b-0824-4416-f365-08dc5e4bce8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hlrc++24fJC3L3p11pn0EGL0MftyqrhtBL1K4vOrdXAlug8G4X5BZdKmOu90FEz1ajXWo3CVIya5bO6CUM8FeVVTm4/ajZhhR5OT1/2BivGBuBD3Vgo95e6kvuWbxTZZQv9sZ990S/dQ4Faa9h31iyvMpLeUSi4h1uEmdfVw11/brQl3OvkOQcc6P0mDDSGWO1er/+E0gWhEeQ4cX47JMmhMMw4axTgKGjQD9v9faYy4vKXAIXb8HJG76fCjUm3KYKjA8CwgjHUysftQQLm+L1uZFKDI50M1rGHoqTH4eqRoaqiXy8hZCHYmDMS8Sg4Qz00RkoCpwIkRpJO3o8wwDmMlnQD0MG+CKMoin2EFZ/qCgnBbJK8mdChAXZY5XmQuz7I8yRguc9YHhLP4Pvj3L3P8llcgAK/TsAP47B7hQPqHUmRfgcc8wapz61ZFvgcLQRjRmib128Mzn22tHOWsSGzD5Ar31/2M56rcQbbxwaAmd3xlvLsfukU4X7cTF2RKHXwrij1BmcgR4F3/Hkvq60tRc+LVLpvMVaDz9wb856O0TYX5LK328I3494FTNy0txArON3R9bJ7CTjjQM6h8W53xDgLYko2tOyHgk3/EHVRuvdsXz+EoR/3IwQY+eC+bHxLOwZQjRbPMB2z3Qp0hQUrFsgmn6UkHAF2coC4U7q61j5vdeWntl32va5HbuVmqHXHwrw5uJEFViI8nlLTXM05rpKVCNQ7G18Tw9pz2xuimd2BRHOFgJMx2zifbH3jK
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:25.8925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efadc3b-0824-4416-f365-08dc5e4bce8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bae5beafe1a1..5825775af8f8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2664,14 +2664,12 @@ static void virtnet_stats(struct net_device *dev,
 
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
@@ -2702,16 +2700,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
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
@@ -3317,7 +3305,7 @@ static int virtnet_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
+	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
 		cpus_read_unlock();
 		goto err;
@@ -3621,14 +3609,11 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int qnum, err;
 
-	if (!rtnl_trylock())
-		return;
-
 	qnum = rq - vi->rq;
 
 	guard(spinlock)(&rq->dim_lock);
 	if (!rq->dim_enabled)
-		goto out;
+		return;
 
 	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	if (update_moder.usec != rq->intr_coal.max_usecs ||
@@ -3641,8 +3626,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 				 dev->name, qnum);
 		dim->state = DIM_START_MEASURE;
 	}
-out:
-	rtnl_unlock();
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4110,7 +4093,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -4932,7 +4915,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.34.1


