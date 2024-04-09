Return-Path: <netdev+bounces-86254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C089E31B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21D6B22281
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D07C157E94;
	Tue,  9 Apr 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ap46E3o/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BC158D75
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689790; cv=fail; b=bnyhRK0Wc0G+fa3JOWOyxbvHt8NUr7W07S/G6o8j/TklRBvZlH16Vkih6tUJbzP+Z/3mAVJcR5oO01O+BxY9j6XSDnn67XJi2EYB7wYGGiIMKt9VWvNJ0Ww7noFO6LEtJOWBLLhfpZbCNvqtUjSAo7XtwwTRsp6iugSW4vTd4GE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689790; c=relaxed/simple;
	bh=ULGG/+HW+Ir47pk4qupjHdh4j83Xx/hBiXL73OlcD1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJpSS99Y/mFw2Xp4pBVqYYxPoXgX21cD38c5m9wiNr0LgXgV5NfUaAoT/+Ey+O+4XW0l+ELYqXfKgd8puy4bXq0wUYArsfBDBuTe6hjBK1ko0u8KoXVOrSIBDjDIqnBeloxQybq4fnGVCvmmYJqag5t38kmz0w+feuIDWuJ8J6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ap46E3o/; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObxwEAUgZgclV2f23sNuPu1A17ZdzhImsTydRwgzj97psBV0ohjgG8jEAfkDOOkmwiqbSz2HpKHd2Tn7RYdjGm18OmsZfEBBrMpR/fMSOWFkddS8S+97fkCdVravyU6GozTupxoHSun5ZLoTF7nndtzSAsjtdJOy5bYvH9TZEp8XXvtIB1f2obtQS43ZS06JuFTbb+Ss8Qef2FhaJD40wb4M8805QyQ2bDQZjYQUi+xx7B0pPi6xEPavjMbPq3N2jwLvhuJyBCJfg/9Td5cunl1AAsgCiDTmXZdOIqPJ2TrqoEBHaH/JJs3OG4PQXAjWG4/kY94Yla6LoP4zpqVhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqI4x0+51VhqNNetnToWar6axmj8UB85q6HG9jhjHkE=;
 b=hym+JfceIRy5aKnwvjhhuFnJEosQX7oH6znRt+lwu6eDUxFkwrtUXdL4ZdUFtf9vVbwTesguKOaPFoypwp1egkXhu10gt1+5cq4kowcYbTKoWjLe23mcZoZ3IjfDq/1Wk1Oa1IxoVk96DA4uO0+tZixktWbIEytWGB7kzViag3O2Lq6rJOcjC0Aqam+5T3gO75SeufB3TlAsCjryNLh04SDATxebUUNnarPW/XTlmqVCN+3he28vHHUskH2WXVBY4ZAQrtTcjptO9ByNQAfFasSCVtpUJnPL4+X1ePQbr1FlcbDeswpRqo6ys2nmNZcAw65TXt5EbdLalzwZnVgVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqI4x0+51VhqNNetnToWar6axmj8UB85q6HG9jhjHkE=;
 b=ap46E3o/Yj3nAzzqL4wLdvGTfLFgWGAzdopvl4kB2DLuP/c/XRooVqiCMgBLactkkwqtB0vTbTD1SNaic5C0FHF/aREjFu96WbsOkEHe1NAbECgjlvzWlo0xkcinMNU5hpgwrijlH2O4weO3eHXzqTPIgSlTrcUCB+nBh3YWvFpz/6aEe8rkVZygnYeksPijmiPoIgtDw6NzggksWT//MyspNRYv4x3817IA8vvxpHIgsugLCeplrgaBpTvRzUV3PymvqpdWznEZcv4NAgq5Fj8SCtfVm6hvhIrPn40oFFhOloc3jZ6b7MiQkIeY28Zib3eH2UHBDlElrCJLvSxCbg==
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:43 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2e) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 10/12] net/mlx5e: RSS, Block XOR hash with over 128 channels
Date: Tue, 9 Apr 2024 22:08:18 +0300
Message-ID: <20240409190820.227554-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 770e0e8b-1e43-4a4f-c224-08dc58c89ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wGJutfhQrZzDuJUL00/eVT5Ifr7WqOVwGDZlplCyR+iVEMrDQOHu73MqYmH8Oka7X+BH/7MNIio50eVIwNBRGhhLsdBAVcr0a472v+nAaPlg/RI9Qc+tZq2+h+21Jc2rnMO4lo15KCB847sQl4vvzbe9Fsn1eCjV3QCj24n0+FFa8m0ZdHYx64StHpO6Qkm+COdr+cAh8X3csdtK+EMgcRObW5/KXJL6t/fNK3tfxLC30U/lwbLjUMBwLUl19L8x+QmRpvedxRZivCqYJYsn10MP7C8UtSLTU04z2HVopHItkItrgyClhRA58BVDXBRq3PlIVNiF26ohb11G0rymrSJAchtbKtShGrtfpb98/FaqtwMsK5OJDeEk1565os/H1ILqQdeI1JbCQZcgOq/CESy1LX4+QUE/YMaKHnDstbSCJGiY1l2ovOxAUyuOoe0AmNVf9y8l9QWNxL3G9Fji1fi8XxARuz8NwoJ00KyrOfn3oy/5YXPwc0Mhq5bkeq4rWQMPVZhvvRbxfKoi5pjqx3fXqHIJyFOCX9UeM5+LILPbPPQGhgjkVshoGZZA9IbKdtl0PbLBeV/+fXQOrp/Vd2aFIWG+zWFOQGujiQpaWlNq932whkfQcdoUBBBAX052ZrE8C5yundd4/TKsCATCSKk9oEcxtSRQNC7+ZnfWKjLMoYPlL81hhCtMhvH3ujNWlR+Lrd4JILN2MnyPs3WSIEsvDteG/eKZr3J8O6hZJqOef9uR9egfm9U7U9wpZOZ7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:42.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770e0e8b-1e43-4a4f-c224-08dc58c89ca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478

From: Carolina Jubran <cjubran@nvidia.com>

When supporting more than 128 channels, the RQT size is
calculated by multiplying the number of channels by 2
and rounding up to the nearest power of 2.

The index of the RQT is derived from the RSS hash
calculations. If XOR8 is used as the RSS hash function,
there are only 256 possible hash results, and therefore,
only 256 indexes can be reached in the RQT.

Block setting the RSS hash function to XOR when the number
of channels exceeds 128.

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rqt.c  |  7 +++++
 .../net/ethernet/mellanox/mlx5/core/en/rqt.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 +++++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
index bcafb4bf9415..8d9a3b5ec973 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c
@@ -179,6 +179,13 @@ u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels)
 	return min_t(u32, rqt_size, max_cap_rqt_size);
 }
 
+#define MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH 256
+
+unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void)
+{
+	return MLX5E_MAX_RQT_SIZE_ALLOWED_WITH_XOR8_HASH / MLX5E_UNIFORM_SPREAD_RQT_FACTOR;
+}
+
 void mlx5e_rqt_destroy(struct mlx5e_rqt *rqt)
 {
 	mlx5_core_destroy_rqt(rqt->mdev, rqt->rqtn);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
index e0bc30308c77..2f9e04a8418f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h
@@ -38,6 +38,7 @@ static inline u32 mlx5e_rqt_get_rqtn(struct mlx5e_rqt *rqt)
 }
 
 u32 mlx5e_rqt_size(struct mlx5_core_dev *mdev, unsigned int num_channels);
+unsigned int mlx5e_rqt_max_num_channels_allowed_for_xor8(void);
 int mlx5e_rqt_redirect_direct(struct mlx5e_rqt *rqt, u32 rqn, u32 *vhca_id);
 int mlx5e_rqt_redirect_indir(struct mlx5e_rqt *rqt, u32 *rqns, u32 *vhca_ids,
 			     unsigned int num_rqns,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 93461b0c5703..8f101181648c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -451,6 +451,17 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	mutex_lock(&priv->state_lock);
 
+	if (mlx5e_rx_res_get_current_hash(priv->rx_res).hfunc == ETH_RSS_HASH_XOR) {
+		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
+
+		if (count > xor8_max_channels) {
+			err = -EINVAL;
+			netdev_err(priv->netdev, "%s: Requested number of channels (%d) exceeds the maximum allowed by the XOR8 RSS hfunc (%d)\n",
+				   __func__, count, xor8_max_channels);
+			goto out;
+		}
+	}
+
 	/* If RXFH is configured, changing the channels number is allowed only if
 	 * it does not require resizing the RSS table. This is because the previous
 	 * configuration may no longer be compatible with the new RSS table.
@@ -1298,17 +1309,30 @@ int mlx5e_set_rxfh(struct net_device *dev, struct ethtool_rxfh_param *rxfh,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	u32 *rss_context = &rxfh->rss_context;
 	u8 hfunc = rxfh->hfunc;
+	unsigned int count;
 	int err;
 
 	mutex_lock(&priv->state_lock);
+
+	count = priv->channels.params.num_channels;
+
+	if (hfunc == ETH_RSS_HASH_XOR) {
+		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
+
+		if (count > xor8_max_channels) {
+			err = -EINVAL;
+			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
+				   __func__, count, xor8_max_channels);
+			goto unlock;
+		}
+	}
+
 	if (*rss_context && rxfh->rss_delete) {
 		err = mlx5e_rx_res_rss_destroy(priv->rx_res, *rss_context);
 		goto unlock;
 	}
 
 	if (*rss_context == ETH_RXFH_CONTEXT_ALLOC) {
-		unsigned int count = priv->channels.params.num_channels;
-
 		err = mlx5e_rx_res_rss_init(priv->rx_res, rss_context, count);
 		if (err)
 			goto unlock;
-- 
2.44.0


