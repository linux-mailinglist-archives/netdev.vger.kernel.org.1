Return-Path: <netdev+bounces-82717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D588F68C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A013CB241AE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AC32B9D5;
	Thu, 28 Mar 2024 04:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="miBCcr0a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4AF513
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601256; cv=fail; b=iIciWzfiCMyj62ec7XZzXWVCAAWh111WF1/Z5fm3YxhHrY1+ca2PhsqakPAmvYDa80Vbtclw+R0y9F/0l9kBIdqD7QIEU06zEPZ96zSw+hpgSOGW+FwqJTlP10CnAws/icXzQBa9kgB/MstGpe2/NgM0ijYwhBa9KEDMMT3LcEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601256; c=relaxed/simple;
	bh=TFE3tIVnQDjRbR27QgLOY7Q+Wb9sqckMgUlTQ4I9Yxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3XJOpb6sv/GxIVLzsQBBRLWQ6Z8pUpkgeTJEMWZWkDw+ry1jy+QkUbPZ73KtlzrVZ+pyvGduywmhJy4pdFmddn9qrAmbUHO065Vp95Z/Jz/poBPy/J/azUp5/ADqyeCcLut+usqV1gY/znBS2gBtIP6iJLc6CaGoR44d2WGCg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=miBCcr0a; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YI4zP1y+fgRv6EnBw1su3xKJ3wUXCoMjAAP+Cw8fY91CH2g2ziBvukzsLSobmjI2iUDTvOl0M7twEf0Pl+wqZ0DekvLkMuZ0nn6tr2au9BfVT2MqTCbTCRWQnesyHrOptsJnyZUk1Vig0IbVzJ/EKT20YrCU7ciwAZGy9KMSDjePc5FVyIUwCEd8PriE1zqwNzDr5kWYDHEdDNwEDWvHUJLqA63BAjTijJ2s27kpJSe0Y9cW5G0jKDkdRQrDNuUJRRxwKJtEFyqJeZkVXXzyDqu0c3HHHZw+rozyxFzfoDNdr8tD7wIOYkIMg5yYaPJKnVfdvW0Jn6cbZvJwGPbhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6usZJJQQ07l2JEb3ZMrbwACNrFhBJcTduKl6m0TS7Wo=;
 b=LJz0q13LBuTH3SgGXpi4ruKguJdNoVpMoEqESexPtbmxb0X+CCWCuL5PbvHt1B/29ECGoafVwn5VzP2f/4ztgUh5qPPU+HdxTcFdeGAXXLrk86R6Yy/UV3iNAcb+Qh/ge8mv9WRI/3YJezeJXOphLjBXlYm/AZg9e1eNrTYTElYYJ/nzUCzHDVN440qZN8GbJlhYyulUZ/OBBGnIaPbL2XPNv8V51wdug5ofiGf9KRiHObRJUT5fs7UnD3DBFhcWDaB0LxGiP320nbL6C4bI2bIk4q80FmmY+W4A4HTFy+/gbdPVErRBCKCDNrDvaJy30xcGkKPbPC/1TZ+kg5NNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6usZJJQQ07l2JEb3ZMrbwACNrFhBJcTduKl6m0TS7Wo=;
 b=miBCcr0a5M5m64/57gLnqFy1qeL/4evz26dyrlpx7+dlgP0aZBdTaFIqC/KZYQAlqk9Ks+Ksh0zxB2QbnDNRQhQGs9E5a1XjSHHpYKK5LN9O6dgrAP4NgyXYOuqe7BDjuPE/gcX/3KxSnoq33Zy8pyAQAj8A/QEjRY3/drVZJJ0IK6z3PprpRnk33DVrrQw7XJt+NKAK2RLMHh5AcITLL0NYaiKbQac65DkB0zOyo2YYu75PA/KZs8RKFLP4WZPWLX1rmvQsKlADY7nUPl812ZKIxtq+c0fMnsuO87Y3de6DVlkOcrCXQfLr622S0zIQ8OoSispJ7EJFY5i4gLzAWA==
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 SJ0PR12MB6855.namprd12.prod.outlook.com (2603:10b6:a03:47e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 04:47:29 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::4b) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:21 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:20 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 1/6] virtio_net: Store RSS setting in virtnet_info
Date: Thu, 28 Mar 2024 06:47:10 +0200
Message-ID: <20240328044715.266641-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240328044715.266641-1-danielj@nvidia.com>
References: <20240328044715.266641-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SJ0PR12MB6855:EE_
X-MS-Office365-Filtering-Correlation-Id: d260e2b5-68a3-417b-43f0-08dc4ee22c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c3V1/WGZ9t6gbw4A397/WtjMHh+GlsZ12rqFxseq3myoPqEl/L3DSGwzvBVCas24hXLZTGSFE4iyb1LJ59lyi1JUsckMnjzJEgUNRfFAcpkjCKmVmmEq+6FXoyhaDDtgJsB5sd8Rc2YaWcslOEsRZGKu2Z4wnZ1nXyXwNa3rFp17Lf7OkR2uEm7MNdlgJANU+hwmWuaeUjJNi4kxJWo6thf1kN0yHsBdk0E+vcEqLcoQ6l9TGa0Rup+o0S/xiicGuqdsxhmSTmSh8tuAJxDd5+VrPb6+/icMj6tqE+qxwov27Oh5vdW2OCe23MrYR9XwIx0HyucqqMlwLFXJ3tZpB85hyEJwvA8APZPEyT1HFaCK2ZOpOes6Dc7cfKstbGdBoJJ+I5bYEfgPwdqB5KBR1QBWoNoOd2f7uh2wXTTOOH0FVVXmREFtqNirPDIcnyVMwuSTv7PoOsjD2N47uSBQ785u7sb4Wt4UTcuvWsI02bmxW3DvaTJrJo7vZuRBLsvQk0qf4+Nx7/ZMAVRZQh7X/cPJTuXPt/RaF3UsxfzT6+h9eRKzycrW0Aq/OpYhBgkJhpGK3/lF1U/c6M2SWR/IHYmzmNAp3ZYuHQOYr4B4eTqUY0HDNORM2H7u4rkQwEWkOXczsewKpHiZukQbIklB+Um4mJyYmuj0Tczz9shVgRi5pqPTWZvyuJ9AJtCbR0bZ5UCz4uesapREH0Ug3+aCYCfzLnVlmZB4zafozGnF+ecQ8NU0Y3EE6y0HoOkYG452
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:28.8445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d260e2b5-68a3-417b-43f0-08dc4ee22c23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6855

Stop storing RSS setting in the control buffer. This is prep work for
removing RTNL lock protection of the control buffer.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..44525e9b09c5 100644
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
 
@@ -3815,10 +3815,10 @@ static int virtnet_set_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = rxfh->indir[i];
 	}
 	if (rxfh->key)
-		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
 
 	virtnet_commit_rss_command(vi);
 
@@ -4140,9 +4140,9 @@ static int virtnet_set_features(struct net_device *dev,
 
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
2.42.0


