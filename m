Return-Path: <netdev+bounces-87529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76E8A3696
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BDF283972
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F05150997;
	Fri, 12 Apr 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YxRgBCHg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31A1514C1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951639; cv=fail; b=ew7qqwFN3chzxbMRj+QyUE72wo98D10ow/opbmpfuMYQipH1SrzbUpvwqurcqpr/3+yt9QvOjotUE7SBOCuwBUVymJxTRkRuE5Vdd5q8rEThBjoyGjJseCNYUAfDNWIFJe6w4WIGUYhBrjgciJ3991Ul0/mCXdRNaZ9zFyXB1qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951639; c=relaxed/simple;
	bh=8pcnRCurkizZR26hfLlf9fFwsldUByUaGZ4yy5/rQf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkLFSLP2xDwTQy8Bksdelq/IYXIgWlaQ3oej7nNoJXpCxbnjARgyeC3bLhT4MZpWm+DDjAp6oK3fzhKohcpWKR5qHQB8KGktT6MaWHrnTs4ZuSCEr+HkomrO1WsSV5W0cyuCoKoEVKj0TeUhACw6kPTwu44LuXeVmBOFmRL0/sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YxRgBCHg; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwDm7Al7cUQCjbLJFqQTD9AhTGKyw9JzhNiKjf46TGmlRdQg4B5E3qstIRqhTpRv4nCjlUBJADwJtSBezbUn+oGqo7WUYXC5M8Db+0V977z25Ws50ChSGsvGcn0jMkVzbn8SNmm5COq3dgSDlfnAHpo69AUFNk07VLoceumFXiZegIiLJsya52ic8J6CwtNLkl4mJWzPJeyPU7yBffsdY4EBoT8Bq15tHtaLLRG+nOpKRQ/SmE+54rcA+I5Nfxsj/R0yUDw/O5tylR/2lylO9MAjt7slBk5ByaK7tP7UvbIOMB+oVIU3kEp1ojIcrMHUzfgnchMeZRVuiOktp7klRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHNBfbwuTgXLlRrsQflFCuy1BWFOpKYHOHEc/wgybaA=;
 b=jF7Ly6ZhGBSE4V7xnCrZsVcSIE1AjlThX5pMNCZbKwy7ukpKXOsslMePMAqMNxGfc3EVpWfe/itufBGMw0liu4kX6jx/4oxt7oSjHTNkJ72BwB3ZNZRcUjmwSVRSsTgZnQ4+V9w2Wv/SFp68y2biK7QG5hZu7GxKiZc/RphQt7sw8snrSkU6xZniXK3TjeoeNqO7BLbYtbmYFMZkHtYrPPohIsTFY7MB787y7bWBUzbBRR31HIWRi+JcDrt5nn85uwao+qK6u8600W5IdEwj6HKKrG5KeYRTs7Ss4wxzqekJI9jEEGa/uJrVUJlC9Sv8KleayBxCCgaKZBXv56quTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHNBfbwuTgXLlRrsQflFCuy1BWFOpKYHOHEc/wgybaA=;
 b=YxRgBCHg8f7ZWXgIAcdISE2ZXurlUPl/do+Jyb/OaD05B4OFf90rhWnBWVuQLC4z5rCQXwkzMxDky2ck+C/vGKRrlGKjryy89oe6aWRK4uQD5wFJcYKp30ZiVbNMBj8tmISqvn7CE/3JVw+fpN2u11esRD71iN202pH8uU4lPPgKAVCb2he4iGG3UpN+H+phW2k406uQlrwYfnQBpcU1LhcNrf1WPFp1ZbqGFI44tK2/+oZEWG5TT+G4h4ScV0r4aZmC0rQULT0ud7HPKv9nH3D+yXIYZz58+l3pZ9sBynYCdVNKI1ifLuktgQekjaGO/tKOSboW99+Mo6vEEPjeQg==
Received: from BYAPR07CA0072.namprd07.prod.outlook.com (2603:10b6:a03:60::49)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 19:53:53 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::9c) by BYAPR07CA0072.outlook.office365.com
 (2603:10b6:a03:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:31 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:30 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX coalesce
Date: Fri, 12 Apr 2024 14:53:08 -0500
Message-ID: <20240412195309.737781-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ccd1ec-4f1b-49f4-e5fa-08dc5b2a4776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zrLnreiSPYW0x1hwAxxYCa8gzHLuskvpDLNvnWOImNsx8z1VdeykgjM598CEU/ESLuZ/tqIjp68osrEJGbXO7zsvqOnQnvaZskYS9b+iSi75ruH5CJ2ckh06NiQ9VJDjRMZXAd9zExZFyxwqgB0o0WRmR/pNA05xOjGU3dR8Ll2lmTd3qWyoua8211tCwJNFkCRohu8ef/2BAhLIfiTLzqYkOFeHVHRb+FIHhutBvmjkZvGf0YILGOQors4Wn1UPJHM8PQvQirDkoUQIQ5WrziSb/f3sNtDmVqWL5XWT+Dmybn1QYB9KJi2RTFQxWkpsIdcdpVb/4tQDdNTT1DhXF2Ee2hm4AI+HtZoKevC1rOzxDbG/ZaD6pI5eSaBfQlKLMoKsr6Ke6KfB8EvA1b4PpbqcuNlrSWxZGFzUUVr8GFxA1RbKpyIKkxJ3w7ykwjyq4hWili5OEmgyUeOT9TT7HqPqJOnnzGL9Uwh9xtRTfQD/1P6dOuTFkTMARbM1NikY8CQlxvmtwwZSuVjd4sWdqmfpSykhD54GGzxb17eYGYqylD33zEQ7qLGYyDS97kbd+ZUczmR0+Js9yj2t+uihgOPihsYm0oaTbVlyOF2FFB1eWKV8k+pz8+eoa86tUs4zzulgS8/0d0kAGXnrBSoLKsbeXWSGa1/Hjc6HrlfcjtXhygDAZPbYCOW/RPRkYoRRGy1B2VGKrMmdfnHDR06Y/UAsmLfXG0Q/9NgNcyeXHSaJAxPyBiJpL2dWZcLOuSrJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:52.3933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ccd1ec-4f1b-49f4-e5fa-08dc5b2a4776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355

Once the RTNL locking around the control buffer is removed there can be
contention on the per queue RX interrupt coalescing data. Use a spin
lock per queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b3aa4d2a15e9..8724caa7c2ed 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -190,6 +190,7 @@ struct receive_queue {
 	u32 packets_in_napi;
 
 	struct virtnet_interrupt_coalesce intr_coal;
+	spinlock_t intr_coal_lock;
 
 	/* Chain pages by the private ptr. */
 	struct page *pages;
@@ -3087,11 +3088,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
-							       vi->intr_coal_rx.max_usecs,
-							       vi->intr_coal_rx.max_packets);
-			if (err)
-				return err;
+			scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
+				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
+								       vi->intr_coal_rx.max_usecs,
+								       vi->intr_coal_rx.max_packets);
+				if (err)
+					return err;
+			}
 		}
 	}
 
@@ -3510,8 +3513,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
-		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
+			vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
+			vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
+		}
 	}
 
 	return 0;
@@ -3542,6 +3547,7 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	u32 max_usecs, max_packets;
 	int err;
 
+	guard(spinlock)(&vi->rq[queue].intr_coal_lock);
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
@@ -3606,6 +3612,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	if (!rq->dim_enabled)
 		goto out;
 
+	guard(spinlock)(&rq->intr_coal_lock);
 	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	if (update_moder.usec != rq->intr_coal.max_usecs ||
 	    update_moder.pkts != rq->intr_coal.max_packets) {
@@ -3756,6 +3763,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		guard(spinlock)(&vi->rq[queue].intr_coal_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
@@ -4501,6 +4509,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
+		spin_lock_init(&vi->rq[i].intr_coal_lock);
 	}
 
 	return 0;
-- 
2.42.0


