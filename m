Return-Path: <netdev+bounces-90338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12A8ADC80
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3486D2828EA
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230AA1F947;
	Tue, 23 Apr 2024 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eM6BoRQH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CC1CD35
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844693; cv=fail; b=G5l1wy+PAbNuBwubVw3SS08PCjI/iPnPxmXwO8NtEAeFQtyEK8Sq2CdCFelV+oSAiePDYVTqvmxorFUNCm8SolhgNAnk/v2JvrWaQ0EKaKZVCnAM7ICGupQhSQmRMDz4utAS61qHB6tkj+svl1udFg/C9jj06NoZurYSAM2/7P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844693; c=relaxed/simple;
	bh=pnOqH6iHv7NL32V89mNbIm0iyq5N7jureUnXTftRtcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByGb5vfV/i79Qz1IO3Gz2PndIOYjtTB7B6c++K/ixh//YFvvjs/b7mZhuZ/YqKzJgWk7CLIpceE7IGRByxvTX0T+2QKMsLbqU1TYEQysJ8e4GCh4Et217h64Iovdpt9FlqZSxfSLxYOIyeOxn4/vkXKihMq4DlB5aAgcGK5CCrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eM6BoRQH; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQx/8guyx5sBqx0DWy2Xxn72ErDwaIo5vAxNmvW6450pzSuwzEhS3tywJ52ozNTGJA6lCl+7kvo80MfpWBSEpj3wXKSQM8m2fZgOnGcUS2wKtKBZ2e4YFmN8JISCWxloXZ7o5xeezN2GbPqmEQwGFqUecP/tS9CTd1wIf8+qlEhfH3dyhds0c116r125dFEezWie+0KPKxGB8cN63wvf454wvrbMXkUKxxXuYiVSclnrWWlS4tOyAqVM2D7vNKpWiY26orLj6YX3CheRp/mSIphyYBPj87efOxkkI9+iOO1KLKaVNIGwsplfVbeL7o+UC3oYFbWz4RIe6VfA7GiZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jw90/y+0sI0GgoIU8LZL8BR5r2COe7SIhzBxhu0Fug=;
 b=M7dnN6SZvPiJAamqvMdPPDkPERfWjy1SmeLEijQNQ/14QpKHZssK+FshRHF0PMhMIMk9lDT31qv0VK0JBw2LigomNZDFmYDnQNy1a7fAM85qU+mFv8N9DWoacIxF8Ld+eJwPqh5jF3nQ1bRqnY/doOSStntETh/s7PX97Qr74jhz2ArY6HDGAdqQBuRyUscGKBH/FzC+DzqXkwcPek6zz/slEz8C11vUFeJGVrqtedSYJ1xYr8UCAo50BKkl0whSGO3xgOsFHwuJeyvRpNCKU9kD1dAGITjejMBWycgoxAoXltAbWVEJBBmTtyyfD4vtpQMT+mtTdKsyO2AqXfg3pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jw90/y+0sI0GgoIU8LZL8BR5r2COe7SIhzBxhu0Fug=;
 b=eM6BoRQHU/a1ms6Q5QKHgc+nN98My1ZOt7M8Bij9wl0EpracIxiXDI2ULBSIsxUVxr2gCiNjb8cmGGw3iajkQOA/PAo31hzeZz+om+5iJw39yoi1RuxYInI8XQhTnOYpxqpyQOuwcVa/6TyRr+KgWjztpaRmlmL4Ditx5h8sAbrRCWxn60fkRKNrkrxTKoJXjjqkhQ5+LD/0DDovuQA16Jx2lOe3YNnGC/dI9yMoDy5e7ZymwnJE1nfHih/N3aaR1E4mjtw+5AC1FVOoBRiI5+McWSbrzYZpD1c5qtSsjVDlJy4i3H90WUz5YY+YDwQBhXh9QqKHmkV2aoZUvBLZ5Q==
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:07 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::38) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 03:58:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:54 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:57:53 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 1/6] virtio_net: Store RSS setting in virtnet_info
Date: Tue, 23 Apr 2024 06:57:41 +0300
Message-ID: <20240423035746.699466-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1079a917-46f9-4e17-ba70-08dc634995d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SUNvtdRdsSP3LlLwq13URTV68oeQpy1oxkEBLBRvdH5Qmk/03OyH/fCvBm8j?=
 =?us-ascii?Q?xO00TrMADkEyEJr3zD2YtJHe6smtVQUHaa5dNR6lkbmo1qrXoYILYEf7LLqs?=
 =?us-ascii?Q?9+OQGjapnopZNFfm9vFsoBGqCAcaX3o70eL1CRtHzjVlvfjkuMdjr+pI97vb?=
 =?us-ascii?Q?2Rv0etncWD2bO6wdLlLsbasi8gpgqZaH08psTZx4BL5W/K5dgZV+fgcCqif0?=
 =?us-ascii?Q?F/gjL2bQtvj45iFooZTbd4L3c6p69QuMKpTuKGLHmY83FFN8CjpRDZsRbGX8?=
 =?us-ascii?Q?+A7pcmWVauLHzk2rdV+a22DrlXXt+Hrx6nssP3ZxYNxTGsPck1nUHsDDwNvZ?=
 =?us-ascii?Q?fyrsyoYdNfzGMwDNzGAGUQ60DHZU3TN3oQ5xBxgTIBydCZOwqQrJ5ZoDoW1u?=
 =?us-ascii?Q?1RlkxF5rGxJiHD8Rsi0dxWg4xMGo4obTjoljL6yBAtBzjV4EHxFfJwertdC8?=
 =?us-ascii?Q?4hirP23mBbW2ApIHq7fNUSj23lVqqe/VVk1PYtWBqngoB28ispxg6wJY1vjt?=
 =?us-ascii?Q?wShvHTBRc2qLHuCTu2xgFfyo3JSPF4Id9tfrmEHz0MQyjAImfB3jVAZykkHF?=
 =?us-ascii?Q?ustLqWl6J1snxi4Sc8KyzfMUAhH1YucwVmK5Dz76hzDZcvnICXT7knxuQ5rm?=
 =?us-ascii?Q?o+tS+61kd7JKelP8jBpLLUr86QfqEqt1CVentuxI0afUMDJvY93e749bHeyg?=
 =?us-ascii?Q?4RewhuzDDWgabkReROJ/tAnbVZYqtkCQmYkgyJi2YbNTIQ5gaXZmBwp8Jr9V?=
 =?us-ascii?Q?KIo1ZbS3ph43b8UfPI6I2PFbxHFlldIOJf0YSWfWv76HD0u0prm1M3XVgBDx?=
 =?us-ascii?Q?2/xf8sy1sVuBI3c1WX8IVBVm3/LTX4i9coiV60sI9WmIXTn0cGg8z/HXI5lU?=
 =?us-ascii?Q?n1aAKnaw75qZqI4xExvIRNPLObpCXG7rA+rbECcOwmidhv8sv1VBik0aVgPR?=
 =?us-ascii?Q?4aN79tEMtnVNsORBpawt1FMBz0c5rfDSizRdng0B/6Z8igAQTM2aVrDn0rUC?=
 =?us-ascii?Q?nM9J0Fu9tTt2qS/q7One8MangxS+/B1/fn6zId9iW2UAt029sn0bzaKXkiWe?=
 =?us-ascii?Q?PERStLx/5FYzYWtr3mMcm2hdZNKW7CGI4ZxQl1wZ5YaNH6g4OpnVNpvuBQal?=
 =?us-ascii?Q?rCQYmOsfgTO1hh6gXRtUrFro7aYv8Iz+hTG/XHXyEon49//AHinKPIuvSaNF?=
 =?us-ascii?Q?L387aqmOWnKPbXjrZ8d2VFxG5z8RwWYG4NI97sp8zM/9YT5nblTvXU3av//g?=
 =?us-ascii?Q?9a6GxAgPgOZ6vccmJDAWVZlL6kSCfCr2tSEcGMlJmJ+R+gAX4B30KmmniCAf?=
 =?us-ascii?Q?4VX5Ii4T1jGDcz0wdNRKlDTKwNI9whrlFt9SB7UVJgN7JuNJvgqRi57kIl2U?=
 =?us-ascii?Q?TkVGHF4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:07.3486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1079a917-46f9-4e17-ba70-08dc634995d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Stop storing RSS setting in the control buffer. This is prep work for
removing RTNL lock protection of the control buffer.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 115c3c5414f2..7248dae54e1c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -245,7 +245,6 @@ struct control_buf {
 	u8 allmulti;
 	__virtio16 vid;
 	__virtio64 offloads;
-	struct virtio_net_ctrl_rss rss;
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
@@ -287,6 +286,7 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
+	struct virtio_net_ctrl_rss rss;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -3087,17 +3087,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
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
@@ -3113,21 +3113,21 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
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
@@ -3238,7 +3238,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
+		vi->rss.hash_types = vi->rss_hash_types_saved;
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -3791,11 +3791,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = vi->ctrl->rss.indirection_table[i];
+			rxfh->indir[i] = vi->rss.indirection_table[i];
 	}
 
 	if (rxfh->key)
-		memcpy(rxfh->key, vi->ctrl->rss.key, vi->rss_key_size);
+		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -3819,7 +3819,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 			return -EOPNOTSUPP;
 
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = rxfh->indir[i];
 		update = true;
 	}
 
@@ -3831,7 +3831,7 @@ static int virtnet_set_rxfh(struct net_device *dev,
 		if (!vi->has_rss && !vi->has_rss_hash_report)
 			return -EOPNOTSUPP;
 
-		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
 		update = true;
 	}
 
@@ -4156,9 +4156,9 @@ static int virtnet_set_features(struct net_device *dev,
 
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
2.34.1


