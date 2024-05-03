Return-Path: <netdev+bounces-93356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06978BB4C2
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772FA2840B6
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC92158D8B;
	Fri,  3 May 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iKEtoG6n"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8641EEFC
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767905; cv=fail; b=F7e73Zhu9/8TJ5e6DX0NBbhChG2Cqi//SrmbAgs+xF7Gbj2puCXMxyMrmom1oEBcdnGEEp5/gkkDVpNzVAx/cAILpZIkZJyUuyHI1+O4DFGx/onNsspfDbPpDhMiOrNf7ViGGPdSU69xdkD59pN3/u7QCF4Hc/sHdPDZG8yLRgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767905; c=relaxed/simple;
	bh=xwfSIKUWJW9K8R5YOy8ukLE+4O8qgQzdfIDxI5gWOsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1PfwfcnJYHbD5Wub6iJNOwuHKBhDmU+33NeWWEuccxD3rOvPpD6EAvqVJ3drBeSj2Jmvo20zgRJB2d3ErR0DqB5JL2VImPWAoYV+tAhuPgcRRSMaDDM3Vp+KE91wbnMfMMhdSAa5kdksyKMoqb37JWKrIxZ14Zqx/IvCkEXpck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKEtoG6n; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efhI6yPninIEkFwmcdYTKfuq3tfvry3BwPw+2KrgDcmdyOtbpUnsvPZOQxPpPEBhMonrJrboYYEv8mQs4mooR2HOv9rctHUK8WaJJLURyNrRnSvxM99RHGnYrJQQzOPMxlRhbPfgM9w3JKEgTyvBIXusAj5uiZCS+wTKVwxtedtpjLbpRh7ZkVP7QtxN6D9Aq9zW/1PcPGKG84llhbj126IyBmqyOG5xsNWfcMn2JoJJGUL3yBHmBUKyQe1twBrDpKnfeDeeaWNvC3YW/jr5ztfLBM4JX4fDjX0yYkHoJod3bMZCgEcjN+EDqK58JuaHlmU2X3p3hff9BRM1e8ze7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9NEw8amvh1H1Szsm+DPBP0ymEB4Bv9ioYlM8BttYuI=;
 b=FAYGj6HpTt6qUOH0HkbCaf0Sc25eN/xIdvMVc1ActL/vOQWhB0X2pdOZXBWyQomKH4zzXV9bD94h15W2T1wK9mrTqmq3vAAKPGBob/B9TFcoBaWmgnIB+EAXbhKBsl9Ev/nluYKvWjdq7SqDCa6RsAfFlAaj5TsIf75fhk+zc0pVgFXE0YoMCRa3jkT/k+1NX6PkWYQ4ktRCsyOvTNyeiPdqfEYgr36NFzA12jwuHH2eh+xRFSIo1OkUnliUtwWRT/kWyKCGDr3OATth+3Nt4jVSpO4FvvVItkSXou1kFoGWc39EK/n7GBHTQUIs+K7lBGLrJEws1trc1TPB7N1k4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9NEw8amvh1H1Szsm+DPBP0ymEB4Bv9ioYlM8BttYuI=;
 b=iKEtoG6npkyMTN1JNfKqjr4ooLFkpo+hmvm2B4cGQtCBBqDZHpGbtZ3euIN51h7uv3AdcNLqY9B5BWv7Pv4Sw8Ncu0Dk1VimjZ5bfuEW44zWfRq1O2F2JGftbAPYRXL3Im/4JEJPfP4NTSX5vt4a8/BmU/cJiWCIx8s0zBKZljyM+gTNCnwzyswleXJrMJRYJRlSSEtT3M8Ku+eoCMO2eEccSUkRZE+rsMga7kpWW6D3QbfaMcVvw3WToGlPOfatwcIoYLVuHJH8txfuTGXSwaUu5cCcqj2xbcY+KdNQ2mGZkgXgaeOMTBpjN3PIyS1VisJ1LIUIPXzNFEZgP40BpQ==
Received: from SN6PR05CA0028.namprd05.prod.outlook.com (2603:10b6:805:de::41)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 20:25:00 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::e1) by SN6PR05CA0028.outlook.office365.com
 (2603:10b6:805:de::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32 via Frontend
 Transport; Fri, 3 May 2024 20:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:50 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:50 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 1/6] virtio_net: Store RSS setting in virtnet_info
Date: Fri, 3 May 2024 23:24:40 +0300
Message-ID: <20240503202445.1415560-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fab17a3-29ba-4098-b35c-08dc6baf1b85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tA29RsnQNhcdvl+7VHaturi3w5hB4atDJylYctTsQbP8lneWLNrFx84KhtU?=
 =?us-ascii?Q?5I9sNxZZVvgVMOnIt3BFK6XZeIgq0OLBjMkaz0F0o5x4DlqyyX6Xg7s4CEIj?=
 =?us-ascii?Q?YF6kn2+Bx1C3tjpqmTmHfnC+sZwbq85gBDTr0aZKdZ8GfzWxrZUS3DvZmPMP?=
 =?us-ascii?Q?k3lUsQeSdpBPZYtpO0cmczw+g2g74vGGnBbRWPEWFHYROh38HB1acqJebDap?=
 =?us-ascii?Q?1PPDIrG6c3SeybppqhCeVTFB+tl8Mmj9VMP+gqS9HmMG/PzoSfbmNsF5NS4V?=
 =?us-ascii?Q?TafcMcgM9hrwMFChXTZXthNJfJa9SngYxYVbPTzvLez2IFegs/At4HtsZDXW?=
 =?us-ascii?Q?JghbZ3x0CeVCUFSkM3lvZpE/aiEWEydQ8pJN4Zg1B3CX3HFWQBsUCn9JHwvo?=
 =?us-ascii?Q?rjJ5nNUvYgX3V8MMkPV2ZmBeMWIqnAtUMR/+DXWU+VdkXGOB/4SjiO8f+YfK?=
 =?us-ascii?Q?+lTSgDrsHgLgCdFf1msVwbp9NNrNm8uxIxGvRd8kTyWeeGIqPrSkW6Rhfiek?=
 =?us-ascii?Q?/LnAsrs8HX2LAd1WE8ofdBSiUhvXev9v7gB6XonoTJ/vnF/Ek4wVxSXUyuVc?=
 =?us-ascii?Q?n8sO0RtIIM54Cf0SKS9Y3JCKomGfJHpXwDfMAw0zmYpw22DzamuMlDx+YT5q?=
 =?us-ascii?Q?HjemdfWfuVuCRkeiVHDqpp93fR2ZiZPWigPXNflqzYr9mbhECDlDR3e7SSSq?=
 =?us-ascii?Q?uc5VK9BL9Rk66GAAV97F7quQJTHwUdS7m/51hhjyYt/v8crUUPFEvoa+R04s?=
 =?us-ascii?Q?HrrnYPDgsosPGMcFnMKAsOjFhqNAuKEX8TEMUcdbow2z58bmsX6VqUQkoBVr?=
 =?us-ascii?Q?q6Be/v1fkNbjSMMhf0W0avPPnD53AQ178IZd/3hIZlRACsq3KhPXpYWgNROb?=
 =?us-ascii?Q?aNje0xf3SU4EqDUbvq1ywdSe6XZTFj4Tr9PnM6syw1BmWbztL5EaLznfI0sj?=
 =?us-ascii?Q?7tc1gb7uGYcZABZQ81J9AIbB2eoL1r9d1hkPAaaMnC7TxsBvXRn7HysQ0t5k?=
 =?us-ascii?Q?7qNxcKOVCVTczCA0AcwaE6qWYXrQUsG6PvVxn8JQpyWLcxIvkK/MlFmw+Hre?=
 =?us-ascii?Q?y9Ot+6GMeRITRXjjSboI7YpTlrDdTjrj33q45XyLMLFZgqj/5tQ3VJIAbBW/?=
 =?us-ascii?Q?dYhVsJo7iXHFka4kPvHt2hNfKQYJkeC9mCLG9FWMC/qV4DFKQH5BzRtsp+Ki?=
 =?us-ascii?Q?X32DXM+aIxxYh0rNXhgT2AZi9pON9usSuDs27bzDA+VwEdWvZybREwbZjfOM?=
 =?us-ascii?Q?JKzpOxaGXavwOpIWlNhyQWFKltBwz9b+ftY6GZD0L9GXug4sn2Yiu9YD4qrY?=
 =?us-ascii?Q?wZqBxk7hnbgZj3XlGdjkpuEyh/Y856PeDproXbAvEs9t+2S/9prWVx1iZuWm?=
 =?us-ascii?Q?hI1PPtM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:00.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fab17a3-29ba-4098-b35c-08dc6baf1b85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708

Stop storing RSS setting in the control buffer. This is prep work for
removing RTNL lock protection of the control buffer.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1fa84790041b..9cf93a8a4446 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -373,7 +373,6 @@ struct control_buf {
 	u8 allmulti;
 	__virtio16 vid;
 	__virtio64 offloads;
-	struct virtio_net_ctrl_rss rss;
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
@@ -416,6 +415,7 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
+	struct virtio_net_ctrl_rss rss;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -3243,17 +3243,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
 	sg_init_table(sgs, 4);
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, indirection_table);
-	sg_set_buf(&sgs[0], &vi->ctrl->rss, sg_buf_size);
+	sg_set_buf(&sgs[0], &vi->rss, sg_buf_size);
 
-	sg_buf_size = sizeof(uint16_t) * (vi->ctrl->rss.indirection_table_mask + 1);
-	sg_set_buf(&sgs[1], vi->ctrl->rss.indirection_table, sg_buf_size);
+	sg_buf_size = sizeof(uint16_t) * (vi->rss.indirection_table_mask + 1);
+	sg_set_buf(&sgs[1], vi->rss.indirection_table, sg_buf_size);
 
 	sg_buf_size = offsetof(struct virtio_net_ctrl_rss, key)
 			- offsetof(struct virtio_net_ctrl_rss, max_tx_vq);
-	sg_set_buf(&sgs[2], &vi->ctrl->rss.max_tx_vq, sg_buf_size);
+	sg_set_buf(&sgs[2], &vi->rss.max_tx_vq, sg_buf_size);
 
 	sg_buf_size = vi->rss_key_size;
-	sg_set_buf(&sgs[3], vi->ctrl->rss.key, sg_buf_size);
+	sg_set_buf(&sgs[3], vi->rss.key, sg_buf_size);
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
 				  vi->has_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG
@@ -3269,21 +3269,21 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
 	u32 indir_val = 0;
 	int i = 0;
 
-	vi->ctrl->rss.hash_types = vi->rss_hash_types_supported;
+	vi->rss.hash_types = vi->rss_hash_types_supported;
 	vi->rss_hash_types_saved = vi->rss_hash_types_supported;
-	vi->ctrl->rss.indirection_table_mask = vi->rss_indir_table_size
+	vi->rss.indirection_table_mask = vi->rss_indir_table_size
 						? vi->rss_indir_table_size - 1 : 0;
-	vi->ctrl->rss.unclassified_queue = 0;
+	vi->rss.unclassified_queue = 0;
 
 	for (; i < vi->rss_indir_table_size; ++i) {
 		indir_val = ethtool_rxfh_indir_default(i, vi->curr_queue_pairs);
-		vi->ctrl->rss.indirection_table[i] = indir_val;
+		vi->rss.indirection_table[i] = indir_val;
 	}
 
-	vi->ctrl->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
-	vi->ctrl->rss.hash_key_length = vi->rss_key_size;
+	vi->rss.max_tx_vq = vi->has_rss ? vi->curr_queue_pairs : 0;
+	vi->rss.hash_key_length = vi->rss_key_size;
 
-	netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
+	netdev_rss_key_fill(vi->rss.key, vi->rss_key_size);
 }
 
 static void virtnet_get_hashflow(const struct virtnet_info *vi, struct ethtool_rxnfc *info)
@@ -3394,7 +3394,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
+		vi->rss.hash_types = vi->rss_hash_types_saved;
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -4574,11 +4574,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = vi->ctrl->rss.indirection_table[i];
+			rxfh->indir[i] = vi->rss.indirection_table[i];
 	}
 
 	if (rxfh->key)
-		memcpy(rxfh->key, vi->ctrl->rss.key, vi->rss_key_size);
+		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -4602,7 +4602,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = rxfh->indir[i];
 		update = true;
 	}
 
@@ -4614,7 +4614,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		if (!vi->has_rss && !vi->has_rss_hash_report)
 			return -EOPNOTSUPP;
 
-		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
 		update = true;
 	}
 
@@ -5028,9 +5028,9 @@ static int virtnet_set_features(struct net_device *dev,
 
 	if ((dev->features ^ features) & NETIF_F_RXHASH) {
 		if (features & NETIF_F_RXHASH)
-			vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
+			vi->rss.hash_types = vi->rss_hash_types_saved;
 		else
-			vi->ctrl->rss.hash_types = VIRTIO_NET_HASH_REPORT_NONE;
+			vi->rss.hash_types = VIRTIO_NET_HASH_REPORT_NONE;
 
 		if (!virtnet_commit_rss_command(vi))
 			return -EINVAL;
-- 
2.44.0


