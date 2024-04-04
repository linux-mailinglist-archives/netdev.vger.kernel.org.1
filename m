Return-Path: <netdev+bounces-84970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12CC898D48
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F56B27789
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24612FB02;
	Thu,  4 Apr 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1Yk/8YP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B11C6A0
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252095; cv=fail; b=FKf1P5Bg+TVgq/jTWtV1nF1YsXdvDyIdvSJ8SQ1ZYqzUB5SFtPv3oONIND0UkoCk22zeSafFAALsE2fMHMP97Z+yOvOiaMFR0KxSJYg8yVF91g7Rpnk+zHRYHFPn/lE8FPe7J6BboJLf73PSexDXlR5NG3EcGmFMajZI0vwD5BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252095; c=relaxed/simple;
	bh=o2kysldD0/K8/RGzUl/ACVbJO1ROuSgwEwyD9UDg8+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jp467i6R/fjlEI8Icvk0xQnTJkGiThHbe0Qs8MIBwAXWp2ylGWxSFnxAogkPK4RIYFDvjl4KnFlY0PC0w6IZ7AECWqxLQ/FqYcrjgQE/plYKsRhFC+Ml3Hi8P/b1ysvfY5MGKLDYvakogjz5rBZRwoglHt0pvkH+URDHEkFU+8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1Yk/8YP; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJG3mE3jU/OJETyFTRyK4FeBH1bL9U+zv8gsfH17AR2/wv7ZiHDF2VEYZt/wu41wZiHeVlU3JH8FvhhbV2h5u3dPUrrfwjTLNUYAEE+1C5fAty2430vXT7IVfEPn3XJeznsOs2Sib2vGqcpraJajHLNkfeeqck1BIA9BG9DCwiIZOdsuUS36hhdgC+f+MUqgaJ63Elq3/tWngakjEzeXsIP/5BzPpKUceDo1rUvpALJlYHFRdMbpHjet2OuUKI2VoyeWZSY45aGV0+P16ZxBG9C+CANPUIa2B3YlTzPtHyqi3Mzj83QB+5Tgu3HGfhkzlSOwWlsA+MECaiBG7+cNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WmTCVSqjJtpC6zJQ0mGkeBixFzdDt5MFcokh/3UR+Y=;
 b=Nk4R98l8JuY2P5d0foB8cvieg1+etEbhjbIP5Aa94EIbx/hn1vo0c9pGkD1NKVHao7+bF1cbSrRFlWj3aj1zJl1bBcl8cjSD8VE/p7lduptqvB17OVYYA82aiai/aW3xSDqMGCWgWg6blI8ArDFVjhXxxcJ4OPAYPtanzfPPFtmLQXm04C0a5Z8VbHH5nRjNEyVtzaREUJ6YWA/F9acZeFCtHKDgXzkAApEW1Z6+SLQqPln0k89FxZ1QX4iq0+YD+RdmmRDSNvdnFP6jGHT3b/qiCs5x1NNLcBZiToZy28diX9Agyn69UkGxIyvZrX61iNuEQc7cxPaKWbKS9GhIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WmTCVSqjJtpC6zJQ0mGkeBixFzdDt5MFcokh/3UR+Y=;
 b=X1Yk/8YPRLbVSnneGxtQg412GdcVFSD4yTOTlfjtbDVK5JOdS1s2eGOhUBrTJm0DKFpzmBSz5w0p/bbySHq5Z64a7ZDEKzEB+mfiw40vkE6APtjbmBNyoNdCnSQpO0RelD512zSKnqUF3G+0YSXX0+hA0DY1pc/PqrFSJ7qSWsHZj+0a2n4DXyaET1lo5SX70l680RWXVSImSHMvsymIhp/kLR6xDLmpbcczu+0ttsmWnIjbsPBqQVSRvgkaTqwW/I0jVLxqW77DNTr/aAyIDUz+LAc6M8gzsPOJnNJ+j3TpklV2nJQ21xHBPbEDfV13klpMM4RK6LrfktMn8YwZEQ==
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:34:50 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::f4) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 17:34:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 17:34:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 10:34:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 10:34:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 4 Apr
 2024 10:34:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: Expose the VF/SF RX drop counter on the representor
Date: Thu, 4 Apr 2024 20:33:56 +0300
Message-ID: <20240404173357.123307-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404173357.123307-1-tariqt@nvidia.com>
References: <20240404173357.123307-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ac00fd4-cbbe-4d7f-53d5-08dc54cd8780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PblrL0QLQuR8kWl9lagwf+tSY0BjYJxgNEQgFrAUmRtOhU9NnVXsm/DCTM5bg9D/HWguPWcItU3NiDgJ36d5l84VoGRdmSKsAetZi0qoJ5IRQ5cfVpYc7EYR+bfTmpLffWUs0GgtQnpkqmZmWGKWU5MdSU69Jhi6wsWtA4NTfr2LNkZJ+6ilodndor1ry1xsCPxcFINWbjHVnyB23VN/fn6g0q+VZBkwAqUt+9WtahKixFNh/0ozfDkYOAIWstPnA3Rc0/0L3nBYA/KmlhTvN0D1iiZklBNQdL7DIJp1LlCKqY4yOV0KW20ehgE9bNDM2wNBl9EO2RLBzvZ3flHEX5QdEW6KypW59YQtDR4y1/Rrk5ucN7yWOeZVOLw1jJQ2p634Jx4ZdraVgOIngRoOhZTrds29+qqnP4W5JRN5HkA7DIaL09cty1856XCJFBnCsezYNWCu3H00Leb115py3p8ALIJRZp6VoTkUM63NmySw85dHCykygr4NQbAthit7/QK3yJeMs9ppEVLJ9ftUhVyWXHSpUiF2vEJf/taOqwUzjgGFHpaLLnniAyaVd7DcwhBqeb7FKXjKerSzyka84tzmyVSh5HyJSID+6Lj6BItmzfmrkcHY87y9mdkMHZSayJZD8+hYvWMbaYqnFXAotGwp1/DF82IgUENAszy/3J/RGsVSs3g9qIEdaACdhoJLg1L8yT/uUGjzJMPm0oIJoJrqc2Lu3Th/Npwm9ylxnXmfqd2qnSFwXMKy/xy/tu//
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:34:49.6099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac00fd4-cbbe-4d7f-53d5-08dc54cd8780
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

From: Carolina Jubran <cjubran@nvidia.com>

Q counters are device-level counters that track specific
events, among which are out_of_buffer events. These events
occur when packets are dropped due to a lack of receive
buffer in the RX queue.

Expose the total number of rx_out_of_buffer events on the
VF/SF to their respective representor, using the
"ethtool -S devname --all-groups|--groups rep-port" under the
name of "rep-port-out_of_buf".

The "rep-port-out_of_buf" equals the sum of all
Q counters rx_out_of_buffer values allocated on the VF/SF.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 48 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  3 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index a74ee698671c..691f6d7fe0c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -273,6 +273,44 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
 	kvfree(out);
 }
 
+static int mlx5e_rep_query_q_counter(struct mlx5_core_dev *mdev, int vport, void *out)
+{
+	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
+
+	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
+	MLX5_SET(query_q_counter_in, in, other_vport, 1);
+	MLX5_SET(query_q_counter_in, in, vport_number, vport);
+	MLX5_SET(query_q_counter_in, in, aggregate, 1);
+
+	return mlx5_cmd_exec_inout(mdev, query_q_counter, in, out);
+}
+
+int mlx5e_stats_rep_port_get(struct mlx5e_priv *priv,
+			     struct ethtool_rep_port_stats *rep_port_stats,
+			     struct netlink_ext_ack *extack)
+{
+	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
+	struct mlx5e_rep_priv *rpriv = priv->ppriv;
+	struct mlx5_eswitch_rep *rep = rpriv->rep;
+	int err;
+
+	if (!MLX5_CAP_GEN(priv->mdev, q_counter_other_vport) ||
+	    !MLX5_CAP_GEN(priv->mdev, q_counter_aggregation)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Representor port stats is not supported on this device");
+		return -EOPNOTSUPP;
+	}
+
+	err = mlx5e_rep_query_q_counter(priv->mdev, rep->vport, out);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed reading stats on vport");
+		return err;
+	}
+	rep_port_stats->out_of_buf = MLX5_GET(query_q_counter_out, out, out_of_buffer);
+
+	return 0;
+}
+
 static void mlx5e_rep_get_strings(struct net_device *dev,
 				  u32 stringset, u8 *data)
 {
@@ -377,6 +415,15 @@ static u32 mlx5e_rep_get_rxfh_indir_size(struct net_device *netdev)
 	return mlx5e_ethtool_get_rxfh_indir_size(priv);
 }
 
+static int mlx5e_rep_get_port_stats(struct net_device *netdev,
+				    struct ethtool_rep_port_stats *rep_port_stats,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+
+	return mlx5e_stats_rep_port_get(priv, rep_port_stats, extack);
+}
+
 static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
@@ -394,6 +441,7 @@ static const struct ethtool_ops mlx5e_rep_ethtool_ops = {
 	.set_coalesce      = mlx5e_rep_set_coalesce,
 	.get_rxfh_key_size   = mlx5e_rep_get_rxfh_key_size,
 	.get_rxfh_indir_size = mlx5e_rep_get_rxfh_indir_size,
+	.get_rep_port_stats = mlx5e_rep_get_port_stats,
 };
 
 static void mlx5e_sqs2vport_stop(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index b71e3fdf92c5..ffddbe4d6543 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -128,6 +128,9 @@ void mlx5e_stats_eth_ctrl_get(struct mlx5e_priv *priv,
 void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 			  struct ethtool_rmon_stats *rmon,
 			  const struct ethtool_rmon_hist_range **ranges);
+int mlx5e_stats_rep_port_get(struct mlx5e_priv *priv,
+			     struct ethtool_rep_port_stats *rep_port_stats,
+			     struct netlink_ext_ack *extack);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
 
-- 
2.44.0


