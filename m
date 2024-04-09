Return-Path: <netdev+bounces-86248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7517489E315
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986F41C21F6D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A15158A20;
	Tue,  9 Apr 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SWSoZ2QM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46B157E65
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689771; cv=fail; b=L1nN7CKKj+sD/6ufiLt3FS6DDZHkf/SS1jPbV3VvVX6qDcrzxtXvNcidygI8cQ10h33WjYOjwFl9lbH7m0ATCdM+3OIwYtEzSKKLN6eZqpb/Vtd5/F5pCLK89fh7iBGTHapKYCWPzxSF1APcCkX9HhSl7LUdIC6JuvOVG4l4u1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689771; c=relaxed/simple;
	bh=iqCD/6960YC12G2CUmtyxfQ+cvFDR5yvwbz/Q9wx00s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDado/BCS5jjT4DORiVa8d1FRNkRScKG/d4+YLytpa/VzuE24CZt1rvYILfj7/1Q1/56Vu8vk29BB2ZtPUOaruZ4i1GhD6lVt4B5/PrZG2jYfPlT+28Mp5Wr5VB177TTFzJNDenxzKzW/MWMPf7vhO507sWnrpGIJsPva379gQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SWSoZ2QM; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtybN8jv12ccWltRAAeNCojEclJcRf3RX2Q/LgVdl1DLEg0HG7o8JURFuBGdsUb2SCZW2DCm19GltQpNHkN6I6cNxNP0069cEiiXGl+wRSVBJp6wLNUN5L/cm7oorz8A0Ky7Ib1difvvDKEUH7W0fwPIjTC0eDx0iOIqxPn3nilPlb5xizmkk9B97Q7QwyT+PtZKi7hqz2buUu4GdxRiGmEx+0eus2dC3NNCOrVAsY+Kw/V/uMddFmDUpD4pVVH3uwmXiaSB2aVmVniRX3Jrzd1ifo0D2YovGkSAwn90gXFpiyZLLhLNQkLLSmC7PZsrR6G3028BXXJbQM7T6yV0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woYd8/OOt524EU8k9kXzn2pVuRstMA9/5xU5uP8KSik=;
 b=heO2HlBRND7FEi4DzuG2eMIqgQ6cbrrl9tBbZHlBjuEfgzyGUkwBlxZFQXeVG3Gf8u/HIy0y5dX8vNJSWd77BZU/i26ObR8sBkgAcyqLuEiwjTtlT9sxPmIJ6IHJ1nhXYmYuJRC4hnA+tBLsQs43TWOB6F8QKHCvH1tN2WpSGKtV45SxXer0rW8RVIxJ0ICJk68R5SNr3DDJNw89Y8ErhRyOGFdob7RuKtqgZf3gVZhXqclc58L7Mg7UqSJ4xRrThlYtnWJ2mukvJ2h7J+wd9RzXsmegDLFkCOoLkEbUuZvtkPBOIiqRv0rZGk9snRcjRg8ES01imZb6+TR5R06jtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woYd8/OOt524EU8k9kXzn2pVuRstMA9/5xU5uP8KSik=;
 b=SWSoZ2QMVDIOmk2zmw5QO5cT9yKYoIOC1Gkj8hAkedbJtpIszmb2c+MppMuo99RYua+j5rd48ANJ/iMfZlRQFmVTUFIfShb5naj3QsNh/iEMi3ZJET5SZkwBKrY7+oxq8IfYoaeSrbZpLSSJA7dlMrDJkefhaQne9iItECb5eR0K5Fx8luJYVcaq+aaJUBC2jGkamKJFaCC4sJrlypJUThLlT6n3uYy6EAKaK9KB7slIDzI2kSaV5nIUcyd7CgjXm+wn/VTp2kLeEbcylvYM2/Dfm5orZaO6mpvZZW0XsuGE/tWtb/WeDVPGZU4pLnwiFqtzQvbwfoyiHl94NOUBqA==
Received: from CH0P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::11)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:26 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:11d:cafe::3a) by CH0P221CA0032.outlook.office365.com
 (2603:10b6:610:11d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Tue, 9 Apr 2024 19:09:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 06/12] net/mlx5e: RSS, Block changing channels number when RXFH is configured
Date: Tue, 9 Apr 2024 22:08:14 +0300
Message-ID: <20240409190820.227554-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 800d959a-7e46-4386-40aa-08dc58c89323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AdMecxhCihLrLitFYzpEPvRdoogFk/d56wO8wQTpRQHeUyfJBErN67j1Xbjq4Tm+jUUZNdMILvPgmcEBUoaBwNxSlWsSK/SkR+pCI4vf8tURqeYwoWTxfu7nzbdgFzTbc4sdkAnDdR3fLZQHQYCNDGXYYB37jxquaFi7h0rtmjaxa7tUa378oGXqfuOog2+9HXxtJpprEgp1hUzz2A1Ni/3zrPbJI44LlkyH/iDvk0RXFqKaCN/MkDSbQFg2SU4QpfYri/L5/zZIMWelLLhwM+Xt1vi9xFCym4SNwmrjuXfi97Okdb+9xKSXwWTERrQlPEvoa1h6QV/FBtDsCcQ+KgcwAwYvnlPAssEMZWrBc3IZhpMwVzKJA/Um2ZE1YiurSrKDMMen63pZczHhs19cpuM+DlIpa/trFWHQhsZjwMLfC6u5fTcKnt6jFbLR8F5Y13pHiqE30AOJ7ggESdIOmvxEnw8xkEdDeczMRq2DgHcp1qPi34iohv4RVPRyCvq0QkO6wEMpRA6O9Kw9S4HULIvO2jzD6JePcoS4Vk++2yHzMCV6kS/tyNhc1QDpHbchYbr0PWP1dg2tA123RztxuFWJ3NQATgA/+GVaiQutjbHfKovJRXkLe0q1q4+sFPFF2dsByBbR1zSH5hAYPvYCBG5BwEc8smcnVtdvwV2WekSMjKxzoYsuMFzJyDyWHbyUcaNSp5ragp0Kx3d2+Pgh8sWYYFMg+Cd2sR1aNIytyow=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:26.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800d959a-7e46-4386-40aa-08dc58c89323
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

From: Carolina Jubran <cjubran@nvidia.com>

Changing the channels number after configuring the receive flow hash
indirection table may affect the RSS table size. The previous
configuration may no longer be compatible with the new receive flow
hash indirection table.

Block changing the channels number when RXFH is configured and changing
the channels number requires resizing the RSS table size.

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..93461b0c5703 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -451,6 +451,23 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	mutex_lock(&priv->state_lock);
 
+	/* If RXFH is configured, changing the channels number is allowed only if
+	 * it does not require resizing the RSS table. This is because the previous
+	 * configuration may no longer be compatible with the new RSS table.
+	 */
+	if (netif_is_rxfh_configured(priv->netdev)) {
+		int cur_rqt_size = mlx5e_rqt_size(priv->mdev, cur_params->num_channels);
+		int new_rqt_size = mlx5e_rqt_size(priv->mdev, count);
+
+		if (new_rqt_size != cur_rqt_size) {
+			err = -EINVAL;
+			netdev_err(priv->netdev,
+				   "%s: RXFH is configured, block changing channels number that affects RSS table size (new: %d, current: %d)\n",
+				   __func__, new_rqt_size, cur_rqt_size);
+			goto out;
+		}
+	}
+
 	/* Don't allow changing the number of channels if HTB offload is active,
 	 * because the numeration of the QoS SQs will change, while per-queue
 	 * qdiscs are attached.
-- 
2.44.0


