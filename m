Return-Path: <netdev+bounces-90342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A628ADC88
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1981F22C40
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52512224EF;
	Tue, 23 Apr 2024 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOZgkgV7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309C1C69C
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844699; cv=fail; b=A7sbZ9EGRFUSlgAMZq1NFm6H/YsKbtwDTACzV8ZEsxtDfh6fyjZdC0ool4DpmojGRbtEQNcSSqghWjBh0+JanAnNvFl4IiEnVyBm3O0IxJzb/mfJekeo2/t7WSHXJDUdghT/OaUQVadAzyof/SghFm5dBFM5ijmxIydgqyCbqyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844699; c=relaxed/simple;
	bh=XstW/MQvGSHDxiLI60FgQNykK94EKIWwDoliVUChLug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPpkhyhTM93GsqO7D6cmA+mnSKAaY14p5BzV1ruere8w/hWTeaig5LqTG3f1v8mBsQ4IUtZXgThhdst2iSPev5LAhIZdgE4XBdI+i/HvCf9tUr6TXupX0Ui1IcYZBIR3+bMZ+sjoZEycGEUoIOQ/zUH3n/F5i5sIc5/xt1Asllo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WOZgkgV7; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0Lg226gdZ+OK+XvBxsPrTvFGKnGcalhc9xFmxTveOlsPad1x7aDcEcCcAIbagfAqhMfxOGYagdnvW7cBWZnYBS2Opuc7q81aH41k24/AC3zDeLYzlgFHS6uRGVbRvZroBsuRhPApmb/9CGtDEcWS69c0K0wcA2/TmZY8kedVdd3AcuD+GUX2KQ/zCIDUzsF7fWeQXxUyeBKcUzchZ5+sEC+x4m+NvnSOMLX9AGvOenJU1nLh+OiW/xBldsmUzvn4AVMoYrLeCfJsezIBP10VAgsTOZcOUffnNoJKrQRoA+78dJbsUZfkURdKWIZovWJ0nYoeD4HD0NIBoV2UYOh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/8QLAmuSPgLAaJmfMTllpe9B641KaO0vQMvxO3nbI4=;
 b=KnbmkCyRwW0CjLMvTqyD1as/e3ESkkI72S9UE0sAcTduIqT4q3CD/CLc+58ZvEZZTBy1gz/YaAUvQVRGpx0X8/+N/W1Ab/fZLptstGJNYNDApPys103oyNPkLmIxyi+z9b2SluDuQt5aqsEuvd+L47RC8RJbbWcd6kyg7YGLzJwECgaJgMcZHKtAw0EMzxLOW61LcD1zieGYxbPJ5LQJdQ8/6Ytmo+OoZt/0kRukx44cAeGvQSqhHEXYZOL2J2q9kUziY039vYL48kugMYKoK5aah51J9yONMOM6eEjW8WuG5c9vA8mPITsxWFYygyLuO9se7MGxzC+vSGGor6ElLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/8QLAmuSPgLAaJmfMTllpe9B641KaO0vQMvxO3nbI4=;
 b=WOZgkgV7FivDeSmTzCU0MtFj3CjBnNhu6AiIlyiiSBLtNG3G6s6TnTHO3ZqQgPf/U3ju2HaUcUAY0nKROlndstDzmH+MeUC3ltrGoSP0W/teKiweRyAojbzVlnEbfwaybNWTRGOJgxW7L0JhYkvhrspGB/1IOL9Rprw91vHgWjMM5KXDyHhJS1U1oZ8coeMwByZnh+49op9omN7WAwJSsFbWizFUmFfhW6jFRyncN6dyD4llw3zCKwT7E/Jho+xe2drLhLhrKMomVunM+nTC3fZ6Z2fhIDCKzoO0e2+K3gO/aNbjyXcxQYgqYv6niYUmaDjancy8bjo2oUuW+iIq+Q==
Received: from BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27) by
 SA1PR12MB7175.namprd12.prod.outlook.com (2603:10b6:806:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:11 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::94) by BYAPR01CA0014.outlook.office365.com
 (2603:10b6:a02:80::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 03:58:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:58:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:58:00 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:57:59 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 5/6] virtio_net: Add a lock for per queue RX coalesce
Date: Tue, 23 Apr 2024 06:57:45 +0300
Message-ID: <20240423035746.699466-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|SA1PR12MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4683f3be-0a3e-407c-aaf2-08dc634997c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?udE3H/VlDsn8l94nVPPzN+VjLnKktKId0bq3Uc0LbAfE/QODtF2meHNZWfmL?=
 =?us-ascii?Q?YfR8xpuNThOlEXZtA4KDdd35ROBKumq8cV+WqLWILnWGRzSNuD02L094jNlD?=
 =?us-ascii?Q?LhEU0B6JnL/RDfDB61sUCicrjVvVYKKuOYmsD49mKs1b+q6bj5lxI+cZXyA8?=
 =?us-ascii?Q?1dqNXE9PQmYMxQlHthkSLE1RZY1hkwlDD2fQPHRLkrco6Rs65j0FsgcKFkLR?=
 =?us-ascii?Q?NxoUpTIL2SLkiZHgNoQSRWwQqA0iejHXVBHqWBrt2WoliSGXzwhLBlE4SjcR?=
 =?us-ascii?Q?/Pyl2RbAEqySMjR0WWZOqwiwDyj/rPwydvRoV0pAekHaMrj2i4ORqzK5SXCp?=
 =?us-ascii?Q?bPsPiDPUTARI21I1HpBvoCoQdlabJlIL3PifgsAZRHazUwAd0QlI3H1pvErn?=
 =?us-ascii?Q?+FcrsJJ2xJEzune9hRbe5xaGX9bslxP3pQnHifIo6JPLZC0aLAFOp3MbIHsg?=
 =?us-ascii?Q?RAjkN9XGFCNlHJnKC8gBN5fij5W3RHx0FQH4p0E3LtUirdM7XsyO7+U2Bi9o?=
 =?us-ascii?Q?IvlHizdQT0jxUTxq+mt1odFuZ8/91oJl5OTzIAfgTRK3ICY/8QQnbnfpMQ3a?=
 =?us-ascii?Q?e7mcxpwxdO4eJ8j8f3RLqCQls4+EkwdF2TVxJMtvp1oxkNVlTeagCQRaPSNZ?=
 =?us-ascii?Q?hTfGtB+FLp4O9LDsIGKE8ZPgwhTBAmS3FsgBDdOX5BXK4cqp7THFh24kHvyw?=
 =?us-ascii?Q?3nh0CeD6apotb0hbuTD44eodTgI/cXvNQSSBzLE3uCfUCSLShBuneY9Ac0oV?=
 =?us-ascii?Q?ijpqGGVFCvInc+2vZS/mgQ45KIQa/TVbGdGE6SfV3/zOrXsYbyd2G9qT1qsw?=
 =?us-ascii?Q?4cHgpUGJQARHgYzAxRKIZxvozu5wXdPnR3gXKEkYMiAV7Uca+Xff1zqRsOml?=
 =?us-ascii?Q?qFrp1U+XW4x7pLLqd3VeeZn2arwqgk2AlByJHWc+nHPByriO98Ond54Pt3Cn?=
 =?us-ascii?Q?dr4/rrw0WiK4x+SUfofkep9ObP1bIpAyEgUxvrO7w6TeHqPxZ7EzfDEpvH7/?=
 =?us-ascii?Q?V8hwa04LFmRXb98PYi1pqh16vheD5XyRDX7gekiB2MoifXK9vwVFLOGpgu+x?=
 =?us-ascii?Q?u4kwEKWersFnWkztRkrMkZqKu4YJkDRL7fB/eZtdW/TRlgDDGuepLpYR1fSM?=
 =?us-ascii?Q?tp10teihb93mRhQ5KZHTK1/Gibi3qdtMcfM827IHyqtvoXv7tgSFbPWNVB8M?=
 =?us-ascii?Q?MVvkURv3Q+zNSMMyrdhPLxXB5iSr0RW/3l5afYlu1pmoogf0u+VQeN7l+9sX?=
 =?us-ascii?Q?ibZes9++9NFDgZnQEeHI5StvdItlSeii5eMfBMWF/uFZcJxApTuSUnbtA1Od?=
 =?us-ascii?Q?wlET4vqNhynavTE0Cjav2xxVFY4umdnbMVLTmecWFdm+roPO89BCtj1ZM4Ay?=
 =?us-ascii?Q?tv2V7IK1fagCsHnpcVuXdSysPgLF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:10.8569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4683f3be-0a3e-407c-aaf2-08dc634997c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7175

Once the RTNL locking around the control buffer is removed there can be
contention on the per queue RX interrupt coalescing data. Use a mutex
per queue. A mutex is required because virtnet_send_command can sleep.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 53 +++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af9048ddc3c1..033e1d6ea31b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -184,6 +184,9 @@ struct receive_queue {
 	/* Is dynamic interrupt moderation enabled? */
 	bool dim_enabled;
 
+	/* Used to protect dim_enabled and inter_coal */
+	struct mutex dim_lock;
+
 	/* Dynamic Interrupt Moderation */
 	struct dim dim;
 
@@ -2218,6 +2221,10 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	/* Out of packets? */
 	if (received < budget) {
 		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
+		/* Intentionally not taking dim_lock here. This could result
+		 * in a net_dim call with dim now disabled. But virtnet_rx_dim_work
+		 * will take the lock not update settings if dim is now disabled.
+		 */
 		if (napi_complete && rq->dim_enabled)
 			virtnet_rx_dim_update(vi, rq);
 	}
@@ -3091,9 +3098,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 				return err;
 
 			/* The reason is same as the transmit virtqueue reset */
+			mutex_lock(&vi->rq[i].dim_lock);
 			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
+			mutex_unlock(&vi->rq[i].dim_lock);
 			if (err)
 				return err;
 		}
@@ -3472,6 +3481,7 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
 	struct scatterlist sgs_rx;
+	int ret = 0;
 	int i;
 
 	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
@@ -3481,16 +3491,22 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
 		return -EINVAL;
 
+	/* Acquire all queues dim_locks */
+	for (i = 0; i < vi->max_queue_pairs; i++)
+		mutex_lock(&vi->rq[i].dim_lock);
+
 	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = true;
 		for (i = 0; i < vi->max_queue_pairs; i++)
 			vi->rq[i].dim_enabled = true;
-		return 0;
+		goto unlock;
 	}
 
 	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
-	if (!coal_rx)
-		return -ENOMEM;
+	if (!coal_rx) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 		vi->rx_dim_enabled = false;
@@ -3508,8 +3524,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-				  &sgs_rx))
-		return -EINVAL;
+				  &sgs_rx)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
 	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
@@ -3517,8 +3535,11 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
 		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
 		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
 	}
+unlock:
+	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
+		mutex_unlock(&vi->rq[i].dim_lock);
 
-	return 0;
+	return ret;
 }
 
 static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
@@ -3542,19 +3563,24 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 					     u16 queue)
 {
 	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
-	bool cur_rx_dim = vi->rq[queue].dim_enabled;
 	u32 max_usecs, max_packets;
+	bool cur_rx_dim;
 	int err;
 
+	mutex_lock(&vi->rq[queue].dim_lock);
+	cur_rx_dim = vi->rq[queue].dim_enabled;
 	max_usecs = vi->rq[queue].intr_coal.max_usecs;
 	max_packets = vi->rq[queue].intr_coal.max_packets;
 
 	if (rx_ctrl_dim_on && (ec->rx_coalesce_usecs != max_usecs ||
-			       ec->rx_max_coalesced_frames != max_packets))
+			       ec->rx_max_coalesced_frames != max_packets)) {
+		mutex_unlock(&vi->rq[queue].dim_lock);
 		return -EINVAL;
+	}
 
 	if (rx_ctrl_dim_on && !cur_rx_dim) {
 		vi->rq[queue].dim_enabled = true;
+		mutex_unlock(&vi->rq[queue].dim_lock);
 		return 0;
 	}
 
@@ -3567,10 +3593,8 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
 	err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, queue,
 					       ec->rx_coalesce_usecs,
 					       ec->rx_max_coalesced_frames);
-	if (err)
-		return err;
-
-	return 0;
+	mutex_unlock(&vi->rq[queue].dim_lock);
+	return err;
 }
 
 static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
@@ -3607,6 +3631,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 
 	qnum = rq - vi->rq;
 
+	mutex_lock(&rq->dim_lock);
 	if (!rq->dim_enabled)
 		goto out;
 
@@ -3622,6 +3647,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 		dim->state = DIM_START_MEASURE;
 	}
 out:
+	mutex_unlock(&rq->dim_lock);
 	rtnl_unlock();
 }
 
@@ -3760,11 +3786,13 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
 		return -EINVAL;
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
+		mutex_lock(&vi->rq[queue].dim_lock);
 		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
 		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
 		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
 		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
 		ec->use_adaptive_rx_coalesce = vi->rq[queue].dim_enabled;
+		mutex_unlock(&vi->rq[queue].dim_lock);
 	} else {
 		ec->rx_max_coalesced_frames = 1;
 
@@ -4505,6 +4533,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 
 		u64_stats_init(&vi->rq[i].stats.syncp);
 		u64_stats_init(&vi->sq[i].stats.syncp);
+		mutex_init(&vi->rq[i].dim_lock);
 	}
 
 	return 0;
-- 
2.34.1


