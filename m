Return-Path: <netdev+bounces-90341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E21188ADC86
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9DF1F22B3D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F74219FD;
	Tue, 23 Apr 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kGfyVFyQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10E20DC3
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844698; cv=fail; b=ee/vsVevMw8iCKURmORB+tRy7snQXZfO03IvvO1uCmgix+SAQvycrF5YBhPFngQgtq4OeQh94gOChLNbswxpEGhiyqsKLcnTA9jxHj6XVm3P4tFKjS2JoI7CUDrFX1NfskTKDqhZvgHgoMSJ6PA6UJuwkoe3b9zT1m5ZXkg8qGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844698; c=relaxed/simple;
	bh=e3723kHlKG8NcoBJ3ZfxGxf8IR8Ix2c52EZkzSfzGw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NV+6/8WmIPJcWhF/t9LD1204MjHFR5+m+g0da+UDKENle3rODtlr0dFfhbt9Sz4UlvMgPO+U/Gc76VJOx6GG12+BTIKXdf7RTjK27khAYpVLae7msRAZaZ+jIHef+ym1ea8CqCe+VxIfHSz0WWb0bqqExZEQ/HzAw9uLdetccNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kGfyVFyQ; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Df4ItCBNXEMFVh2nmJ2TeqRYW+Se6kHP8aJ3rwSw4iMY53hhmawuYmrxyXWFc3XCnz+uwb5iZLF7nw5lH1mJr+fHbDnf8QJqmf6zhM82eIAm+cvM8Je6H3OPbCrzO8T3TjBRYUKhoIbqC6vIK1B6mEqpFgTkkRazOzH83Kd/PICPYDCOZYD/f798VJNvCI2PIEYnEZ1MM4yzyi1bGk1eaYsidX6EiPj+v8WwIX0gk+YWKKQYoLEFiNJ3LHZoniZmCqS4k9Xz/CQsw+MlO1Q/vXlYfe9qGA5CUBIun/YTaq+By3QeFSUL40ZXwOQR/CyjqpyDZBGcCIPq/gOnuAOrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWnepMLB54LcYV4yQ64z+NzgKdsrVZmz+dTYjb71qBE=;
 b=Fy8wvAXTTlbtDylkPaBdywy4rBTunQV1qASGxfQ+daZD8kQv+8fx4T+YtT9a8ejy1VeWZp07EHLq5YA+aLVh6VCqhi7x6qll2ON1TZoQXhnDV3c6GahovlVxayhCx19kBlCW2OK8UaFsWtRFnO+iDitiANz4JVcItQe8DM5/tQ7Fwrz1YH7bZh8EukVH4+QHWEnmHy6kyazV5Ks2IK5tOSXTc+BZrM9AtjPGwuogTO0WhNL2PilLkizKLp12CZoQbCEjzx+D+0QzjBKY9w9WFyZJM5g4xlntG5IOqEQ6EzH63SyEpX7vuUghiwUQJ8gd+awOXqpOKCAbLJViCTlSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWnepMLB54LcYV4yQ64z+NzgKdsrVZmz+dTYjb71qBE=;
 b=kGfyVFyQrU1eIsbtgFcHGcxyR7QI0vb7q9pUFpszQOq4ZXMvSClRFrEjWrpskMA4/bvdKHVPdBInRXTQWtUUsWtA2YDCe2C6yHFlEZ7cba7MW+QS8YYqgOII91chQry4S+H7N3YTy6e0rRqWgoTt14oK7P+dE7l/iUQbfERi0SEo3r/wv5q3ShWVgyqCWHmAd2QMbX2tKDpnAzdg3OUYYz2QRrbjF9UEw+XIKqloedLruycLifNaksK+9yLZ3u1O2KKgCPHrSn8BBybFAFzlhveNjEY1xCVXGhm1JYnOkKzZYZ0WlNtoS2EJ8m+JK5+sVk1eUjJbS7UC3XwtURmTsA==
Received: from SA9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::7) by
 SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:13 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::ec) by SA9P223CA0002.outlook.office365.com
 (2603:10b6:806:26::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 03:58:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:58:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:58:01 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:58:00 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 6/6] virtio_net: Remove rtnl lock protection of command buffers
Date: Tue, 23 Apr 2024 06:57:46 +0300
Message-ID: <20240423035746.699466-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: b61a8b45-687b-423a-da11-08dc6349994e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNpT+34ImWUwJlmKOO/Ie2mGovt8Rl3sMDUfKhvuTHqoNMqrz/tjvvFzRauT?=
 =?us-ascii?Q?ygL4OcjpDAOEVDc5u0wFKEOjcQlK/vGimPfRJVzTsYiVU/XHVHI5ALSJPAiQ?=
 =?us-ascii?Q?RULT4hozAbD7Z0nUoOtjmQq++2tkhYaZG39sGz2Bn4c1sBnpHdkuu/TqlWgd?=
 =?us-ascii?Q?PRBbbfGOWycvSPY2nCdbXX63MpQ5BNQGoG/f2kV3hk6v3VpFYVPtAyfSRd66?=
 =?us-ascii?Q?ELV8KsKb/yvlyy0XlMPmf+HHgpB/NEbYUX7lU6/l5T64LF1/D+GIKAY4dOM+?=
 =?us-ascii?Q?VPTdUWH3ZJx7vBJknwz7la+fvt/jhCLd3zxskTrBWp4gMAuUJPT/lYGuoxgR?=
 =?us-ascii?Q?cqHEBsMZ9bcLjl6spgxbZW0NMMISHomosuOnekrrWG4WtjVT2c9YzdeFgkgf?=
 =?us-ascii?Q?CcANBga8leKCS3PqSqBKgDzed9bJZ7mb1rct/Mtlmmpr3kPaSu/wbtdNQkEP?=
 =?us-ascii?Q?4QhHpahpa/e4w4tfhVEVaF/qkmV5TdcShigchPhbNvNvnNSqXOft8CV01viw?=
 =?us-ascii?Q?vH9ngqPWfixENnxdJ0lWaa2nLx4WxwPtNvtas/UFRNzwZigXBVFHo8t6xSZJ?=
 =?us-ascii?Q?6yIS3bz9Q3SKbdk6xDDa5iFrF6RsGKaOrfhTCb3rsuZ70+B46UtCGOEJIV2y?=
 =?us-ascii?Q?DK+PRQaoayg2azs6aMVWNmdtyDifAX70uhDvThRoVhraWT0TOv2YwbDd15KY?=
 =?us-ascii?Q?4RVgDh/qDI4iiH3atMEN1UNzMOvXQWX+LzoHkzrYUFxIyQreRh9MreBE/j1x?=
 =?us-ascii?Q?HIYPRBvDduHyq9Q/xTwE3ZCOG+FjojxjanuiLOQU7whztDVaKM42305/bASP?=
 =?us-ascii?Q?1Jg6uZ0cJvxoNNuWdG5+0f5tbvlbsysCbT2WXQai9NVSemo9+KYQq8P2Bzzc?=
 =?us-ascii?Q?J8bFDMe1IjlkxmWt5JwjE1fjQksGPrd+G2wKZieNcdU0YIfXmUJfS2z+huuI?=
 =?us-ascii?Q?lVxFFnmPNKppKB8RdFoM/qXRz0GcPii3poSrKUSioVf/7yH/dY/cAeVr9YZB?=
 =?us-ascii?Q?yiLV+52yAy/6Ravc8Z5LpMb1XR1FIBvaNSRjOxTLf44HaWWRisBJba6zqjSP?=
 =?us-ascii?Q?zqRECUABpHxKWcxDnzVRvtkVkwULTuDtUk8Z6ijjpxjLFmsB9n841yI7KDTl?=
 =?us-ascii?Q?pdUpzP0q9ZcNSiDjztLhSiIyYlQ7SNqFMC4jOVqAhogkJfF3mlqQRBMIzE3d?=
 =?us-ascii?Q?SiNuDKgm5Ei/P+tR8TZWhG3ikXguQW7BzPRaBBXzFEh0P+6YZJYpy99JtCbu?=
 =?us-ascii?Q?E2+1FJ8qT3r1t5/n7qYuwPYBz46Qsq1E4naBgYknr3bRshvPsnZy+IxnOI0H?=
 =?us-ascii?Q?uLNTGODjqJeJX0864ztdXnAHGNtI0MhFJm9snlyyDjYBfdBPS6FWQWQJ520a?=
 =?us-ascii?Q?F5lJOgckCQ30ux+Rf9svtPQqkWkX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:13.3893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b61a8b45-687b-423a-da11-08dc6349994e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 033e1d6ea31b..d00f4147c7c0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2668,14 +2668,12 @@ static void virtnet_stats(struct net_device *dev,
 
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
@@ -2706,16 +2704,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
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
@@ -3321,7 +3309,7 @@ static int virtnet_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
+	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
 		cpus_read_unlock();
 		goto err;
@@ -3626,9 +3614,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int qnum, err;
 
-	if (!rtnl_trylock())
-		return;
-
 	qnum = rq - vi->rq;
 
 	mutex_lock(&rq->dim_lock);
@@ -3648,7 +3633,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	}
 out:
 	mutex_unlock(&rq->dim_lock);
-	rtnl_unlock();
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4117,7 +4101,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -4939,7 +4923,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.34.1


