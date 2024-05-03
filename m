Return-Path: <netdev+bounces-93362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD668BB4CE
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED340286A69
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC5159209;
	Fri,  3 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CbY3QYaq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A2158DC0
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767918; cv=fail; b=sAkJ4ANEB4qpAQCJOfidFMP0Mn/IL6qzgYAOEvRAfvYvWusUoMv6yTUeOfJke6rRe/dUEKHaSQ0NhXFVwOxQDiAg2m+iYFoXfGjIHoc/5m/8rMW2qtbaSd6yzSL592S5lSUEHxC3gf3QIl1ipS+SXXsje6Ev9d8Rdka87wzvgnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767918; c=relaxed/simple;
	bh=0Ts2WNzVC8WO5gSsjMbGsZrTBumQhTX/cnFj/kGG160=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7MdTFmHvIwrhb/SZP9+TpGGZBWB1sRfoFWjh8Wvg8TEmm0APBc+hHTwAjvXA6hnm5o4u3h3vy4cDSikIETAQ68pMtxr3S6KtUkvbEbrB/eQMDQYo0F0vrgbwDdf6tBPw8f84obd5hKQAyf7RkIG5I9T9we1iXnlDQCEETC+kas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CbY3QYaq; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAYqaQk6eOJozdsT8igQC3NRBkG0RLQBoibK6ubskyVmpYI6bp7FBJCXMyVDqQ8My0LJuFKK1ifUm5KDCRoms3t3kdeafBq/M/jjrR5ThVk0uIpEHg1ebF08BkaS237Nt+mLGt2CeU+4NcBao12PwQ9xcWHu7TclhaH3qwII6CGR0hP2GLM0vsQywinFEcYGLEJk5jJd6pd3yDGg/P36jijfK4j8u5f0phgmEuExcFs4s1L9naP1icegykxKcf1pVodxmS7UkqC4MQDS7aoKNP6n8aMJr5+Gh0uAh8aBMm0ij8OmQ+G5VVtDMD7UxEKWzMWFxfEeGitmbcHTL4q59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICKA/sJ1pDK6Be1rmZXVmAgMOusoM/v6AkqMs6trNsk=;
 b=cnXzZtEuW8NDR3CxZDzkhJWEipz6fAESzMiJJ3L7o/RgYTdox+270KPYfjlgpxcJzBXj/spmIFjk/cZMMCVnNQJYsy37msjpIkFmiV8acFur/6oraPI3i6NoYQOx448Jh3PeEQ3IM/z22JhY4jjnG2OA/6ELSAXzvPBPt4d9r6l92AUmbogz5PDr1CyEsXXoL7i7Ur4mTLwlGUFIJ2Nt9oVVEHX282LMmqzucpsChWpeS9ca3sTU5KXLyWy2EZdtuaEIc8V7F29kMCgvk615jdyiFXjuBb1A4H0hD9ovIv6eQHQntYbBJRbu6+WS7eiT2AfalWolZ+jR1ok+U2AI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICKA/sJ1pDK6Be1rmZXVmAgMOusoM/v6AkqMs6trNsk=;
 b=CbY3QYaq8z0jl2neayspLCXBgyCETqxAAlFXipq1iw6SxLc25G/XgStwvBiJz6ipNhG1U1XBefVber50U/6fji0COFmjDCEOQRzvowWzXINGYnL6Hk+5J56z2CQjC5ad2jgR2p/R6JTm5/q6x9lUb5URM02O1ms620rdv37KsvECNt3jgLNbPIooEjgkCPiAOiQX6LusJrKUE41NEbrxjrRw1d0KtzSIPR9zMzJneYt8PNLUlrrsvYOdbmKcSPXs+B1Qp4YfY25XC6EQatc9Hrg1huEsaDmaX87oEgzil9uTQd2Ow+Q/Kk4Lr5LKoJ5sZUPslUVnxUBOQ0iWMay9Iw==
Received: from PH0PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:e::19)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 20:25:09 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::82) by PH0PR07CA0044.outlook.office365.com
 (2603:10b6:510:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 20:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:56 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:55 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 6/6] virtio_net: Remove rtnl lock protection of command buffers
Date: Fri, 3 May 2024 23:24:45 +0300
Message-ID: <20240503202445.1415560-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 983360f0-fa89-4da9-b5a8-08dc6baf20c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSd83jbahmPwusISXnWxqnoSHSLLMV2QXPjjoPYUGNT9VLDMK0K7+N8FPDA5?=
 =?us-ascii?Q?Sk9Kn8zu0mxsAT2UgUzBqyNorzXTTw8WfDv0Wl0sNKu4wBfxb1vRPO7WE/qw?=
 =?us-ascii?Q?9VAhI+93IwalOCcBxC7eAnzQ0YglmXwOi3leceE1EOPeIRsb0FRHTEoEpxoC?=
 =?us-ascii?Q?Q/wDQJa09NeD7oTWYgzqYaQLX6vR09a56j5iRbE5S5t4nqTmsaQ7kB4SMrb7?=
 =?us-ascii?Q?U5ceHc/Wd/ijetCL6YILdp/XjhiFe48A/KSixebG9Jf3UMpFwE7WS9jda2rG?=
 =?us-ascii?Q?JGxcETyX0GjsUT2QriZdpxShPep2Vh7/MAOBb+OI1Qr7OcrckG66ddEGl3oN?=
 =?us-ascii?Q?xFOeFTDKuJvv9vYZa90DTNh/BmETi0KAGGmtKBWxa8LkntGrSB/CDyzFfiJP?=
 =?us-ascii?Q?3jei+48NgveAH0BKb22NHCFL5ifpOsHsg3ZiOjet5gGeErQ37H2qY+9j1SpA?=
 =?us-ascii?Q?8VGhcsRxuLPDkLUk4+IZlxfMWf2GTNU7u4+cgxA51A6+RaAzFTHIXxcJgGpp?=
 =?us-ascii?Q?8FAGMCKcH9WAkbYZHluIm4X+56lCKlHpm0N7kiRL24tfGS/ZB57PBV73Zn8M?=
 =?us-ascii?Q?ankCyOlO9FDsj0P4keU6mXk8Uy++skh7wftE6WfFQgcqFg+tV4edwv/sUUEO?=
 =?us-ascii?Q?40J938gBUm6m+MSNdi8ASysoXGzdn7TkUZSgCZu+PsWhiY6EDZBbHh8xEYL3?=
 =?us-ascii?Q?Bw36Ky8HRWwEaGSFJUfxA18TpWuaH7kQdEgm6zzIyEmFJev6ewNEY62k4FTN?=
 =?us-ascii?Q?H8heLfdANlbk2uCgHUjPdSwnV2JkU5sHMq+OAGK0lFgjdg3vnLcMrYy2yeMe?=
 =?us-ascii?Q?+8WyToFr9Y96+vXgYo+LNfGgUJ30v3pxxoDyatOKMgqZnY/XuW8kIGbEdrFu?=
 =?us-ascii?Q?BD2kfd2YFIH57qHv9nZk+hlYPEjcApJ1YnrMlm/tYBAvwlMKO/Z93mrrVgro?=
 =?us-ascii?Q?aPfv3xYDol1/3JGqIyFsXgO81JugP4g0UB1w8p3z5RLK16hP4scji02oLWgI?=
 =?us-ascii?Q?DzOo2FNU8YQQF8imsew2Ew++QbQ/hyWRpHTje7KAqc3gY8sk3d7YaZbTALSh?=
 =?us-ascii?Q?nQu5HYgVbEvyrrKF5WR5DXdBf8qMEBcghe3dya43NE4nZxGMSXVw0M3w/Oxr?=
 =?us-ascii?Q?rfJeS3KJmuuDHOU+PAlAJjmOrZPBZ3JWQhpCN953sYOcG0iQjionH5wPS+Rv?=
 =?us-ascii?Q?8CF/fm6bK5H4Oulmyew4naE8RkW6YDkpHQ6lvVdiVrxZhOUPfaXiNjy00LJG?=
 =?us-ascii?Q?gHnD17aJr+ASMG4S+SVyDpA3eylD2sDbbY0iKIUrSsVwTShZGHxjAPz/cGvM?=
 =?us-ascii?Q?emyrvlTVWjF9vT5D+CkSPgMT3wJcXVESvDunMbB3dDp/SaKLA9OCVFJQ56NG?=
 =?us-ascii?Q?kvHT3quNRaRhvJwiCx/yoY+vRjfI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:09.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983360f0-fa89-4da9-b5a8-08dc6baf20c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593

The rtnl lock is no longer needed to protect the control buffer and
command VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a7cbfa7f5311..218a446c4c27 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2824,14 +2824,12 @@ static void virtnet_stats(struct net_device *dev,
 
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
@@ -2862,16 +2860,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
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
@@ -3477,7 +3465,7 @@ static int virtnet_set_channels(struct net_device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	err = _virtnet_set_queues(vi, queue_pairs);
+	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
 		cpus_read_unlock();
 		goto err;
@@ -4409,9 +4397,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int qnum, err;
 
-	if (!rtnl_trylock())
-		return;
-
 	qnum = rq - vi->rq;
 
 	mutex_lock(&rq->dim_lock);
@@ -4431,7 +4416,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	}
 out:
 	mutex_unlock(&rq->dim_lock);
-	rtnl_unlock();
 }
 
 static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
@@ -4989,7 +4973,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		synchronize_net();
 	}
 
-	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
+	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
@@ -5855,7 +5839,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	_virtnet_set_queues(vi, vi->curr_queue_pairs);
+	virtnet_set_queues(vi, vi->curr_queue_pairs);
 
 	/* a random MAC address has been assigned, notify the device.
 	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
-- 
2.44.0


