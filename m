Return-Path: <netdev+bounces-89539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2978AA9BF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC3B1C2166C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC675812F;
	Fri, 19 Apr 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qe8m297V"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC834AED9
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514002; cv=fail; b=djGSJzFpnkjrXq3R6B3IoTMxr77rInARfopsJLo+xkPA3SeLH3rrbtlDQf4ebAl/v9beXHmc+7fBPIkWUEY3jxhQBTHFQae/wBZR7YH+YuVbxhHp+chzhh3gPrYPbsfvoLL58vYb+0pSYzEvV03tcopzgFki1pwSDVWL2WzV3bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514002; c=relaxed/simple;
	bh=YWfyiLWtpCQKpf6iZxoh5PG2Bu4E140CYpuSiG4Q5mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgFh2Zz7pVw5lYO4WKhr2v5+JZwsa3t4sLNytdAnywe0yMvEkPAhVKPGzDlxGIn1Ghh/bBNumPiV4IA4hqZc5o2Y8yIEfzITOvUbA1QQ6FEtpB3suOmAeJr7FtK17XObF2O5Q10bZAeyqZ43Cj5vcxcf4OoAAOGzc8yqXXYAJrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qe8m297V; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFuK8pBRgTG/efk4upahQI/eIbA+kCMBL32pzKvd6KtNQjjNp8ORfWyqMEuIvTHXimdUsHc3zHgWH/bpALrwfDx6f6I2OxNMq6xdl5EVs/Dt0KtpyXMQYMUT8Miuzxybu5avnQ5NB/zKncsI7bkc/pNzvs+r4Y//EZ82+UsHircj36g9KZAF13TJAvTESWRBeAx2LHrMg7VBWnTDVClKOnxtrLLdB+kyc7kTXIbLVHmNqXuZ9i2FaNvX6dLN0vD+uumpoiUMTikwpiiYNQJU5/nq1a4U1UgMhrO7sMBUsg6Lpj+ZuY1d/06TLtrfo9RrcM0WwFKHyBS3vTGVZU5NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCtHq2GALtF9SvjKcYMVWbonzjNk0eLJt9NyoDzWnWo=;
 b=brrGa3guGkUtWvgA2gK0AWI3usRLIg+ZuZKX4XH88cs0sqPLK3fZ1WaMWdrfm05eJ2r/6pbpeys0tU32s71/2mlJdVWSVWbNkez7YqQiCPRwREWTmhk9PC0Ifc3BKztwmuThKwCW608U5HlW0LiZVSb3XyBCiGKuYKtPbet9uLB3YYVJHATpJmssYGapwsAArXQpLvBZDrCKa+l0OBcRh2IjfbO0KTTp0bp8d4AtevPJiUF14HHJOYQ/V2tFLMXf76OgnahFpvEof1eCHwj5rylIFXkxMoDHE7q5pgOUYpY4ZKQi6HEQEfdZ5Besyk4zItz7t3W3ZAf795YpnUi30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCtHq2GALtF9SvjKcYMVWbonzjNk0eLJt9NyoDzWnWo=;
 b=qe8m297VcWODRrle6FccPuJCjvUxE2ZlJYgd/q1eTG416jNAFhTbziS5ux/iQvLfkfYZgEzdKCTGzkWmeE8+XzE3ZtLLsVH4UhlSCm6NJbWA/xDoCRx0DuGADYv+H2D3DYE48s7ehjkIzfbr25tHrngLuCIb95tqtgUXcSeCTIE8Zfe/pdqQNuquLJzXYGW1uis5LS6y/gTNe3PYqS/XbvBhlo1sSvAhy7jt+nncu1oMDeD4OcZ2aqFzUdoZ0WMi2C1utiYMtvMVplVpNMc7sFHKmqO/+RVks2UDJxEZ2JaL6Pns8uORTomeD/yxxf9n01KO4shZTWnwOEwvBkxDFQ==
Received: from SJ0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:a03:33e::7)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 08:06:37 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::62) by SJ0PR03CA0032.outlook.office365.com
 (2603:10b6:a03:33e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:20 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: Implement ethtool callbacks for supporting per-queue coalescing
Date: Fri, 19 Apr 2024 11:04:45 +0300
Message-ID: <20240419080445.417574-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419080445.417574-1-tariqt@nvidia.com>
References: <20240419080445.417574-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 89adcb81-e7dd-4112-77c9-08dc6047a2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MLkYD+qxQcqQ4UWH4MouOFhB1JlDpQ/KTgptqMNVk4uuKjzhbF1GpJDUQesY1kBHUPOwG2hfJQlO7M4MSLh6oSqI8YvRvM1PYyfQ2oAv87RfdCqdqthOOYC9ouY76oUQKljwxWqvW0S5uYSWpN9HV8TbfNZoNRg6oF9Kdr9+npck9DEvfmWCy1kL7YIKnqm+1ihyTp2BpfJ/qzmV+YW3G99ltWNYG5YM30cSlO9zSGW1hvEqkquqpZYHZHS8l5Y4CUDW5WUL9o1OoazOhZfLHIRYcHaMO4BiZpJsSNcguidgrI4ird3j0n/EkvkX+fRdQ73bNy4MYriocggwPxDkUy+1wSQJjoA6Cy5tKjPUqSym57hBOM7OuHaVvPuefbdxPHOHY6EiMYMbejHzjOKZsnw+UMtozgOMA7aZBH6IGuUVaYH7UrVuD3TTGRJQAt/lrmFlJpr7Kcu/bNJiuued+ohYCNLEhrX33dRjr5sn6Zq+EQT2+/l1SyGQkZTjPXO+EG/dwng4eiYZyLvzrcb/klrAxS08nm44V4H3H/gKogL5lRAGQCCTyOpItv2+nFIv6BtEXgVxuGht0jC30avtYM33CUiGj1ANaAxsZICKu1zvQrNNH0bNjOylgZ1mMWwIcb2txSwWHEPxmrgTyMBfYi7cidT1L5+hAxBI3Utu58WS1QJnA6pkXuwIPtpNas6xcpTZ99xaZQI/DK/3bFlS84tw3Gf0GlZpNct+xAEd8SgTETmaweXm8qJ/cyyNnPEg
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:37.1498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89adcb81-e7dd-4112-77c9-08dc6047a2f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Use mlx5 on-the-fly coalescing configuration support to enable individual
channel configuration.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 146 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +
 3 files changed, 152 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index eb09778327cc..f8bd9dbf59cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1199,6 +1199,10 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct ethtool_coalesce *coal,
 			       struct kernel_ethtool_coalesce *kernel_coal,
 			       struct netlink_ext_ack *extack);
+int mlx5e_get_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal);
+int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal);
 u32 mlx5e_ethtool_get_rxfh_key_size(struct mlx5e_priv *priv);
 u32 mlx5e_ethtool_get_rxfh_indir_size(struct mlx5e_priv *priv);
 int mlx5e_ethtool_get_ts_info(struct mlx5e_priv *priv,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index c968874569cc..1eb3a712930b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -589,6 +589,68 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 	return mlx5e_ethtool_get_coalesce(priv, coal, kernel_coal);
 }
 
+static int mlx5e_ethtool_get_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
+						struct ethtool_coalesce *coal)
+{
+	struct dim_cq_moder cur_moder;
+	struct mlx5e_channels *chs;
+	struct mlx5e_channel *c;
+
+	if (!MLX5_CAP_GEN(priv->mdev, cq_moderation))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&priv->state_lock);
+
+	chs = &priv->channels;
+	if (chs->num <= queue) {
+		mutex_unlock(&priv->state_lock);
+		return -EINVAL;
+	}
+
+	c = chs->c[queue];
+
+	coal->use_adaptive_rx_coalesce = !!c->rq.dim;
+	if (coal->use_adaptive_rx_coalesce) {
+		cur_moder = net_dim_get_rx_moderation(c->rq.dim->mode,
+						      c->rq.dim->profile_ix);
+
+		coal->rx_coalesce_usecs = cur_moder.usec;
+		coal->rx_max_coalesced_frames = cur_moder.pkts;
+	} else {
+		coal->rx_coalesce_usecs = c->rx_cq_moder.usec;
+		coal->rx_max_coalesced_frames = c->rx_cq_moder.pkts;
+	}
+
+	coal->use_adaptive_tx_coalesce = !!c->sq[0].dim;
+	if (coal->use_adaptive_tx_coalesce) {
+		/* NOTE: Will only display DIM coalesce profile information of
+		 * first channel. The current interface cannot display this
+		 * information for all tc.
+		 */
+		cur_moder = net_dim_get_tx_moderation(c->sq[0].dim->mode,
+						      c->sq[0].dim->profile_ix);
+
+		coal->tx_coalesce_usecs = cur_moder.usec;
+		coal->tx_max_coalesced_frames = cur_moder.pkts;
+
+	} else {
+		coal->tx_coalesce_usecs = c->tx_cq_moder.usec;
+		coal->tx_max_coalesced_frames = c->tx_cq_moder.pkts;
+	}
+
+	mutex_unlock(&priv->state_lock);
+
+	return 0;
+}
+
+int mlx5e_get_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_get_per_queue_coalesce(priv, queue, coal);
+}
+
 #define MLX5E_MAX_COAL_TIME		MLX5_MAX_CQ_PERIOD
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
 
@@ -747,6 +809,88 @@ static int mlx5e_set_coalesce(struct net_device *netdev,
 	return mlx5e_ethtool_set_coalesce(priv, coal, kernel_coal, extack);
 }
 
+static int mlx5e_ethtool_set_per_queue_coalesce(struct mlx5e_priv *priv, u32 queue,
+						struct ethtool_coalesce *coal)
+{
+	struct mlx5_core_dev *mdev = priv->mdev;
+	bool rx_dim_enabled, tx_dim_enabled;
+	struct mlx5e_channels *chs;
+	struct mlx5e_channel *c;
+	int err = 0;
+	int tc;
+
+	if (!MLX5_CAP_GEN(mdev, cq_moderation))
+		return -EOPNOTSUPP;
+
+	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
+	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
+		netdev_info(priv->netdev, "%s: maximum coalesce time supported is %lu usecs\n",
+			    __func__, MLX5E_MAX_COAL_TIME);
+		return -ERANGE;
+	}
+
+	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
+	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
+		netdev_info(priv->netdev, "%s: maximum coalesced frames supported is %lu\n",
+			    __func__, MLX5E_MAX_COAL_FRAMES);
+		return -ERANGE;
+	}
+
+	rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+
+	mutex_lock(&priv->state_lock);
+
+	chs = &priv->channels;
+	if (chs->num <= queue) {
+		mutex_unlock(&priv->state_lock);
+		return -EINVAL;
+	}
+
+	c = chs->c[queue];
+
+	err = mlx5e_dim_rx_change(&c->rq, rx_dim_enabled);
+	if (err)
+		goto state_unlock;
+
+	for (tc = 0; tc < c->num_tc; tc++) {
+		err = mlx5e_dim_tx_change(&c->sq[tc], tx_dim_enabled);
+		if (err)
+			goto state_unlock;
+	}
+
+	if (!rx_dim_enabled) {
+		c->rx_cq_moder.usec = coal->rx_coalesce_usecs;
+		c->rx_cq_moder.pkts = coal->rx_max_coalesced_frames;
+
+		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
+					       coal->rx_coalesce_usecs,
+					       coal->rx_max_coalesced_frames);
+	}
+
+	if (!tx_dim_enabled) {
+		c->tx_cq_moder.usec = coal->tx_coalesce_usecs;
+		c->tx_cq_moder.pkts = coal->tx_max_coalesced_frames;
+
+		for (tc = 0; tc < c->num_tc; tc++)
+			mlx5_core_modify_cq_moderation(mdev, &c->sq[tc].cq.mcq,
+						       coal->tx_coalesce_usecs,
+						       coal->tx_max_coalesced_frames);
+	}
+
+state_unlock:
+	mutex_unlock(&priv->state_lock);
+	return err;
+}
+
+int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
+				 struct ethtool_coalesce *coal)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_ethtool_set_per_queue_coalesce(priv, queue, coal);
+}
+
 static void ptys2ethtool_supported_link(struct mlx5_core_dev *mdev,
 					unsigned long *supported_modes,
 					u32 eth_proto_cap)
@@ -2472,6 +2616,8 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 	.set_channels      = mlx5e_set_channels,
 	.get_coalesce      = mlx5e_get_coalesce,
 	.set_coalesce      = mlx5e_set_coalesce,
+	.get_per_queue_coalesce = mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce = mlx5e_set_per_queue_coalesce,
 	.get_link_ksettings  = mlx5e_get_link_ksettings,
 	.set_link_ksettings  = mlx5e_set_link_ksettings,
 	.get_rxfh_key_size   = mlx5e_get_rxfh_key_size,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 6477b91ff512..8790d57dc6db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -428,6 +428,8 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 	.set_channels      = mlx5e_rep_set_channels,
 	.get_coalesce      = mlx5e_rep_get_coalesce,
 	.set_coalesce      = mlx5e_rep_set_coalesce,
+	.get_per_queue_coalesce = mlx5e_get_per_queue_coalesce,
+	.set_per_queue_coalesce = mlx5e_set_per_queue_coalesce,
 	.get_rxfh_key_size   = mlx5e_rep_get_rxfh_key_size,
 	.get_rxfh_indir_size = mlx5e_rep_get_rxfh_indir_size,
 };
-- 
2.31.1


