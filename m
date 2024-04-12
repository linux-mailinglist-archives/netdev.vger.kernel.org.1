Return-Path: <netdev+bounces-87528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 105208A3695
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68ACAB233F2
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4E1509BC;
	Fri, 12 Apr 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTxMtBM7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058801509B8
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951636; cv=fail; b=a2v0T5uC7bO7KGeeR4PP+M+22HUcTtE2RPTonqo6WN6FUyceD4FB6+/tvtKpjpyCHLmCUnhoVgx4GyCmXITI9IfKItH3QujGd1v78Qq7fmoBLMv60rX6G1WJ6GuGZihZcXTZN1svPHQ6uEBgW33/n4qJHctbgSlLP5fPE5oiVg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951636; c=relaxed/simple;
	bh=BbXNpU3wDZjmT+nE6mp6aUfmMKT5DlxpaeH4Sap/9Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkYihJ/FR3DcMAitdO7X+5GzOlrT0RetC1nHHO55xYjKd6oeDiRhxm4VbWM5jy9sRg86TrFrLtfYjXFvjqHC1J+f/rNUlWiSrmYhqg76KlcCZPJzb/ZdI0r62B1x327loAm88FQ7SxB/SqQ7vPqb62M2L1F1g+HF4q0QbyjWjH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTxMtBM7; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0rpL+Y4OaFhOZ3oqY7pINsLYidi0h5i6jtDo4qw5MP5bfuPlq4XcB4PR9204m2RzFK9Thh+yRYd58g0MVtW2OztUZDwQssRVhu2MIAMZaxUWsNrpkdSiun+N82XDjB4e0Ee+mASpI5ff7MTJz4q192RLvH5ZPUs2o1yR1QyZbxYmRwhedz1WkL4/nWaWXj1SDIyQXoQMee+6zUFOI3wUuLZ8x9Qr9U0LqTQWDKg7dEn0HzmAFeF8shHSizCjOLxiIf7vT6HpCekWH5gOBuYQrYEBDfRDm/bIA/VgeTmIB5ovb95D7vj33EtU+p9NUbM80at7QV7Ry9z8oP7Lr89pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q7aN8Mh1+f6qOM5b5AwyBEn6o/XwFHfSQiAPIiwRDQ=;
 b=Lt0oxDRrmmG0M3ktQTcv2HdIt6i9dIYlchEhUQTlbechwbFUw8ceKgDz5B39DKJ9OejtKSP4pf4tc7pRETa7elBuc3iQ9l2ueo2txPIUYwV1RsfY4cmAOxROMeImKVSqgsN3qlFtfEA3Lxn5F0rCOK/XXcLOE/9d7uu8RHd8R9D4kyBrGeom24Q2O1HIFXUybAh0tW5reDU/szlQewvroGTLvZCbJ8biAgfbw6z0SCx6fvIhFM6EGXMABSfaPb3rc1G/JG2JxZIEpv14Dm8TCpC3VoK19p2lfPuiW7HsdT6eoK0hCxmfWpt3RGE6X6gBF8PwgKaX575JD8zp0P3w8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q7aN8Mh1+f6qOM5b5AwyBEn6o/XwFHfSQiAPIiwRDQ=;
 b=nTxMtBM72TAEs2zPGnrG/VCrLMcRRcLbVI8RIg1+9vZx9ONDn8siGwXFts+Fr8dd3jy+99jQUO9w0GfS2ZFklHSVkkLGj0OwCglSkzJfi3vaD9Yni84GhhYuxbQZdz7w7x9SFssAs/YA+KXTr4lj1qb1Nrs7vp1fGnAj55gwDCdbQOIBHUVUsx0ARXvWzV7oOLuJjtnDMhtLzr8wVv79QdU4V23Co5OUBQm3YQdO6njw+RCNAOdugd/TjIQ1xReLS23tBsJQno4qt99FS+ivVn/PdtmhDIl+KqE7Ec0BwheizLJyN+iJi4yfs1Wh3qa+LCgkEKPfgIuT859faMyoMA==
Received: from BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 19:53:51 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::45) by BYAPR04CA0035.outlook.office365.com
 (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:34 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:33 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 6/6] virtio_net: Remove rtnl lock protection of command buffers
Date: Fri, 12 Apr 2024 14:53:09 -0500
Message-ID: <20240412195309.737781-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faf6d56-984b-449e-767e-08dc5b2a45fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JGl+HG/ZbT8z2F5FERxQC061YQ7j6c26EEpcc5BeY0o5shivibKQ2xuEs0vdJPDUe6KfPMJg/4P2XA7Pm5D5NpxGwiyj1BNtfCMugxQ6aV2RELAeokSwds55BG9Zb1QECOaBSZTcJb9RS0irtv3dOhD6HBPh9U53BHqwM3CJRWIozm9AKKwGxtMrTWFP78JbdNSFYk/CESyzawL1zFj16+GgSsiBpuvnqb5f8Mwy+OUMCq4/z4al7/U4E1yX59fhm3h4s0YkV27AQdk/iA1/GKSKXUjmTWdL/sWou3pi5w+pChK/WCkW+1QZCWt1PAzHkZb70UduI86EyY79onWAw+O3zgLTa2Amy2FpatdbcKYSnladetFnXYNh7zmU1NG9LSBmM9+pfrI0nDRtW+TSQ20fg6X1OVdzMV5ImFX9EZqCxQUFdZKLo5TfVOBHfVJB4iMCorriz9aG+BoEiYJYDUev9F//5NMC5vew3en2muvoqcxpncdy28BvdCyZRO9emwUB1l8yh1ykMOfBa+IZfVfLU16ilpvHUVLRsFcyzrGX1CdMgn22QFpyjA4t0hIBoHRBlNx2z0eDvIaREnMgeL1hZZKXfuEX3wJYWTLh7mfZwGOxacpW/IVyRksCA8Ap8BnA4GCFk+3a1ZrpdG19ZtSIE7Yfg6vzH3+voKII1rjD12mPVbMapCKyBNbBBIQV08+f18WXx6evenzQ01muB+6ynd3CcPT3BCrTL4TFPD+UxJBKVIJg3GfrTlKEgwRK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:49.9288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faf6d56-984b-449e-767e-08dc5b2a45fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8724caa7c2ed..8df8585834f0 100644
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
@@ -4093,7 +4076,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -4915,7 +4898,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.42.0


