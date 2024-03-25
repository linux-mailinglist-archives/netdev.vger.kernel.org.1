Return-Path: <netdev+bounces-81821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDD88B31F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 22:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776BA1F6300E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489656F524;
	Mon, 25 Mar 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QnGnTPAR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B26EB6A
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403383; cv=fail; b=OxQfloqhIwT9UuIdxwfMB/Gfb6l4vjvjSruwv//BwMo/twyGD8DCK/8vIBDKUBGUHXv9c62TtaCk3AB86Q/XUJTuBxm/imzuwgiSJY99VuyK/l0It2ZlFQw07IkYWyENzFJQloc7cTZYzidn3RUG5wq5Tc+bTuxfydnjtqQcNLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403383; c=relaxed/simple;
	bh=kBnjuKwul0LnW5gd5ObXG/9SJgFq9BdFxQq/JbPr3v4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrxtEzlz4Y0rMKpvJpFyF2CnFZV24roxyMkyky1/Dt99xMsDhJ0GJfQpIWOWmInVVLIGSYdLKO1chL/VXSzCKYbKiSHksHWQnISAQ0DF9aTVweuo2cxmfpH2yniKYh0pzkzt8hxWjfLc5ts7mvwOWF14tHQzNSkdDeMaNJ9BjXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QnGnTPAR; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiDjLEU6pPmyCTXd7wG56tVWmonr81lQQjQqgwjrva3oaauKY71FW+PbXqcKL90EYGMy0QRUNIVlxb2aDSyhgJLa7IYbBpIo4Y9L1hmHXGus2pNKqvdrLKOVVC6K0o5Wdelcr934vbSRFSWBXoGSpP8icZex0r9zIbEtHjfYQwMQb60hd7xbLBKKPMJlt4fkaUPidGeSVYQsq2RcDVD4voxjkMvRKt/3ViNPc140F8DPbY6o3PhB3BTL/HGXrd7/XVEf4XJx0WKXB2+20mDGsvAwylWxPKR2lks3h/rS0M/l281eYF4FQmQ7GYGACx2T1RJOo5dH1FPNEs4qd9JMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYAQlY7FTodNSPI7QWCNrNQ5wehEHPQz1C9x0LNR0jA=;
 b=d2bq0qLgHGk/oCSMy2264ECK2EuYyVU7Hy3fZN1dM5wYWm2zvAccJOHLv4U6PyTVGlru7o3q4DI/IeKhyoHU22hNkGcpizBpaLOiX1CiaFmpGqGEUMGS3D0ytRcwhSN0FvUKsFfc0GS1MRi/JGgU5uHOXHd57LoSOzUL2mEd6AFoIv3JYTSpUB25vos4hDvzSKwfXgtV8kGr5fBUg3W7JsfmlmyOimzgi1O0uDhrCLjDxOxH5DICTun3i/W5XnjhDlGv/crQmwc219cFJSJkGGDWcNTsZJCt6EDTOtweYrYuwF79xPLnH0LpcSvnejLx6jEkoEoQX4Mfk3O0Af2ZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYAQlY7FTodNSPI7QWCNrNQ5wehEHPQz1C9x0LNR0jA=;
 b=QnGnTPARIbuUX6fSzkIXPaiZeI0QXvU4qRaSOkrdhuvOT/vGyzRbxGThRnn5edpFmdPw3nFxmGePDDgopzaZ++k0P60MkKGO2BoE8fbXuS0AMICwedKSJKEBz8msCGR5FrkFXc0Y89Ou2S00cew9748bmmuCyf0J7mNIP6opJi1fq/cDdrnETzviLig8gSSQAPLZSnzBvH0Y9oNTPy9TJixe/DdyrnW6PlFmoolNTzpvWsO1kFRS683L7vG35m3qvGyU0oxdWzzvi0n9Szb5rtjGcwUt+LPXY3FCvZlL4Ddg8ViIAaxlAmtbpaxM7xmap4cWHuZ8aDOTk3Rg11xsaw==
Received: from BYAPR08CA0010.namprd08.prod.outlook.com (2603:10b6:a03:100::23)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Mon, 25 Mar
 2024 21:49:36 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::c4) by BYAPR08CA0010.outlook.office365.com
 (2603:10b6:a03:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 21:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:49:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:49:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 14:49:28 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 25 Mar 2024 14:49:27 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 1/4] virtio_net: Store RSS setting in virtnet_info
Date: Mon, 25 Mar 2024 16:49:08 -0500
Message-ID: <20240325214912.323749-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: badd5146-dad7-4ccd-4ae3-08dc4d1576ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A8NBz8EiA8YEQ9xw0pmkX9c80u9XAcyIK9GxghfuvtNxO/QtNBekIHKtvi6XQEiLRTJLY+0riXlhtBKedce6ZpdcvvzkZ9ZPh37EWxcS/RYkmszYSC1omsrxbbH1n8gr1ciFFnf5YKfBD+sjdq46sSLmOd0/g7nA5W6f8VG3uLjLQaKhDFB0QmIoT5snQLeWpRq5Dpxj5+C4nT4RXXI+OP9d1Gh69/4CNNBR2SJeHTPgaL6CstUgm2II/yG4n1GutSBOykXIQzRFazB0CgRB7kPPfOW0nRyLYLGPX2vekwTPBi26NZ+pUzUSENrRjsYqYSwpBfut5hZH95NUWzwEiGlLtuPtOuPZcNUInikZWU8mkz4NTzy1mnDGFMhennjkfJFWG3PkZZ/JAl3Thu0Avf4FuEdWqhjwkyNn1uuNMEhe2pmlyiDHV8WS1zezIJzAjU9P6PVpypf2T9MB5FTXGCNhtpoukSYB5puQ+azA5/r6VfOto2ECehV6QLmceC8YYQii976bnuPgg80NEExSWsgd+voklBjehUHevQ7uBUrHdIKKEZS9DDYSxkg5pPa+uaxovhEt3bNJiQGktw2EWOe3vldUe6L6HONhK5C2zdAYgHPytSQ2/Ul5Ewf6tJKpuAR16eHCqhdpkU2pqd2TManpHzeGGqxRwbKqr7NZ0yojm3kBYPb6eblZ8pgCPu3yW618KPCfd2duAIgIaQSDDGnEEYcrxRajUu0hNPdJS7QC5SztsLkY52cG1V5fcvIC
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:49:36.1183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badd5146-dad7-4ccd-4ae3-08dc4d1576ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638

Stop storing RSS setting in the control buffer. This is prep work for
removing RTNL lock protection of the control buffer.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7ce4a1011ea..7419a68cf6e2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -240,7 +240,6 @@ struct control_buf {
 	u8 allmulti;
 	__virtio16 vid;
 	__virtio64 offloads;
-	struct virtio_net_ctrl_rss rss;
 	struct virtio_net_ctrl_coal_tx coal_tx;
 	struct virtio_net_ctrl_coal_rx coal_rx;
 	struct virtio_net_ctrl_coal_vq coal_vq;
@@ -282,6 +281,7 @@ struct virtnet_info {
 	u16 rss_indir_table_size;
 	u32 rss_hash_types_supported;
 	u32 rss_hash_types_saved;
+	struct virtio_net_ctrl_rss rss;
 
 	/* Has control virtqueue */
 	bool has_cvq;
@@ -3048,17 +3048,17 @@ static bool virtnet_commit_rss_command(struct virtnet_info *vi)
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
@@ -3074,21 +3074,21 @@ static void virtnet_init_default_rss(struct virtnet_info *vi)
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
@@ -3199,7 +3199,7 @@ static bool virtnet_set_hashflow(struct virtnet_info *vi, struct ethtool_rxnfc *
 
 	if (new_hashtypes != vi->rss_hash_types_saved) {
 		vi->rss_hash_types_saved = new_hashtypes;
-		vi->ctrl->rss.hash_types = vi->rss_hash_types_saved;
+		vi->rss.hash_types = vi->rss_hash_types_saved;
 		if (vi->dev->features & NETIF_F_RXHASH)
 			return virtnet_commit_rss_command(vi);
 	}
@@ -3752,11 +3752,11 @@ static int virtnet_get_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			rxfh->indir[i] = vi->ctrl->rss.indirection_table[i];
+			rxfh->indir[i] = vi->rss.indirection_table[i];
 	}
 
 	if (rxfh->key)
-		memcpy(rxfh->key, vi->ctrl->rss.key, vi->rss_key_size);
+		memcpy(rxfh->key, vi->rss.key, vi->rss_key_size);
 
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -3776,10 +3776,10 @@ static int virtnet_set_rxfh(struct net_device *dev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
-			vi->ctrl->rss.indirection_table[i] = rxfh->indir[i];
+			vi->rss.indirection_table[i] = rxfh->indir[i];
 	}
 	if (rxfh->key)
-		memcpy(vi->ctrl->rss.key, rxfh->key, vi->rss_key_size);
+		memcpy(vi->rss.key, rxfh->key, vi->rss_key_size);
 
 	virtnet_commit_rss_command(vi);
 
@@ -4098,9 +4098,9 @@ static int virtnet_set_features(struct net_device *dev,
 
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


