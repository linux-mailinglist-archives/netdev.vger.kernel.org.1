Return-Path: <netdev+bounces-88452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8938A74B6
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAD81C21D1B
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA91384AD;
	Tue, 16 Apr 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DIYq2LO8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B513848B
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295877; cv=fail; b=cHadMt/TB4qZAaY9H5YMjZPGe36RZzvqPtHMxhexM8jHogsoACP9BIsmLd6TDl1dp968PAp3Yu/b99ex8e1a+qk9SXVnkCdk8LkVaV4KpLpC0SiKSykvvC8IgeDLFzBoeab/Qch4Rh+zz/fCF6JgjaSIUKvrczZqB7od9tEMm4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295877; c=relaxed/simple;
	bh=pnOqH6iHv7NL32V89mNbIm0iyq5N7jureUnXTftRtcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/BCiRVRDbcND1psX7EVWr/iBTYXwvDgZ+8r5X6ufWZy4uMErILp8rDcXBsu/ajAatew3IKF2wGR7EXIO84JGkapA1vSQQ5ABvmD21o5Zgn/CvQiqZ60uzwzwIm8Wz8fxI/wsRIvJzml2bvILDhx+PASsp9NTgBaojNpHW/Hbh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DIYq2LO8; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJwY9qQewJncrqIjXKn9LVp4zse+ze/G8+Q+kArpLzGBrcR86X/Fm5YQQeVTnbXXFQOFYQ4li2kFbGks2PRHQADkm4QANtPhNFNxY4CEADPIvILVOsORAqVtAJcQnDp7cfJLbFmibDmHq/L/vFAniJkzlROeu3eGIzg4mleD1LgitTFU88rpJN8HCyTCZNr0PQ65B/ayg06MFlQOAUcoMQ1DIoN8v6c0FNsGCx+jguvsTiIcJOA5OpghtXSFaAV09k4PVwB5C0I0bNWwgnGphyh8sojxEx8fiD8L8IeANcIKnWvWp03/bZUxVURSLabyiVohRhXsOpmtBoJ1FLtqPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jw90/y+0sI0GgoIU8LZL8BR5r2COe7SIhzBxhu0Fug=;
 b=bDlOBanv4YJnqaeRA1b2DHFm+Kx6XO7pvTHyjpm7POGEGjmHclUWuq5mLCfGudpWEU/cwXtHypQDC9c6Aug8pj12I6iCnWNMDEvo91bmYoamJOiQAeTpv5h7/wI9JNV2fDwYQbLKGbFBjYSNw7Lo/95BqxcdFoxEnva5hN+tjssnt3qxwlNjvlpjW733K+m6hIkWujZhmbCYgilgg8v7If4qAzXH7JNLzwHpUWxVyDzgg1qZDVEhbYTdy+MTJ5oE7Udmcco3o8bUIzgaOi6HlgZafd8ww8IuY9G6tMuCFdqGhlL8A8wJ+fT5feY2EIxcZpJL4ZEIXejzK+oBwyyNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jw90/y+0sI0GgoIU8LZL8BR5r2COe7SIhzBxhu0Fug=;
 b=DIYq2LO8qDwqJoucgS6NLQRkz1Rlbp3DkFSjjM+i6xyRlFm/1XpRXwPXtsLlx5aIl2o/FPWIoAoLB4BvINveChWfUGSsLTguK/o3nTVZffzPizeBv0BEAbfIRFO03ypuKmZzG6xYQwXbZ3mdTtJpvYq4oXGPzQRfC6z1rZn3YOu6cU1xg9jnZBPZbxpAzU49AVunQudGS5AJnFQfwyyJhUuEHONx1m/DePMWFyjnSCWVVB9r9GS8TlG2MhbeXOOCHI855C/CuUIgM9BFJW3KbHzJ7OtcMgHSEA6mi9mISwJR0DtrNCo3JkPMi0iZVq7oTWP7Mux7bbrmVM5GfMgqSg==
Received: from BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) by CH3PR12MB8284.namprd12.prod.outlook.com
 (2603:10b6:610:12e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:31:13 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:207:17:cafe::65) by BL0PR1501CA0006.outlook.office365.com
 (2603:10b6:207:17::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:48 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:47 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 1/6] virtio_net: Store RSS setting in virtnet_info
Date: Tue, 16 Apr 2024 22:30:34 +0300
Message-ID: <20240416193039.272997-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CH3PR12MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: 080dbdeb-54d9-4fa3-91be-08dc5e4bc6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K53wuxeK+e82G0TTwal3D3eTL4wxTpIujBdCSlAO3KnsOSDwD/cwqX8sec7pzD+pOxU4wy8LiWicEIvHvB2iVPhpNNxPjc685NL2XJLMtQXavE7fVkGWwWcILmWcpvB3/7hOP9qhH1GP/ISOcRKzEukIGO8GX+zF1Ub3olzlYiU2Zhp+hJHg1XulMsSHVAJB8A8x4HnsIiQuj5xv4i4aA4vxYf33Xqw1QJ80Enq1jNUNaqCPxL92EoCXryU7tIJEuBE16qEw0W7KYmo1pglhNdOnG38D0+eIXdJwtuOKOX6rQN4/3hYeCOSQtEBZIDYEKKP7xb2FAol0xofqpBDLG6r6lQEQvosxS+0EEdVtyOxiQnpHrpgsGKrID0pqggW9xhvvmiBIYMmbzQfKNVj8/ixUmW/013LJQoy9klazNtZ43untib856VBV6WKAfADXN9cxBGpAgQArsdzPT0QXLZvYWdbP0NccoruQF8I2K6fqveKp3RfjOYkaaWGa3QIRL/Qc6LfN1q1m0NBIfhGmQnZXaO2MQ3D3BWTN87OJfsVKzGxnxZ+AL/8hxsNIpqoIz44ZtTcP05tGgayD4atJGmn1rZoH67kr9xs4DtU3uwD8t3K96ygwDtwF4C50CR4Hq45dW8XDqUAVLAgeKUz5rmDmwDZXeb6d9rH+cfR3GbAy/JGN+FFK1quWRmmTKUAmBtjdtsjjcjArcGl5d6eXIOy/g8y+lp5u2oPwJ1cMLR+kHRkxKPxzvVB5rU/Kdn5t
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:12.7082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 080dbdeb-54d9-4fa3-91be-08dc5e4bc6b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

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


