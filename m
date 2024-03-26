Return-Path: <netdev+bounces-82281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA988D0B0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F741F63E2B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8FF13DBAD;
	Tue, 26 Mar 2024 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TiDtklxW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8913DDAA
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491695; cv=fail; b=KD1KRP2pY3VIcv+9gu7dFMvEHMPomaSacJXt0pKHE4uOXGzvcs3kXL5EYIHVXw4kPy66bjmBnVp2qIIee/ZenL5nc/e1Wcgklru/O7vCMG1fAUtkM8aHsfwqunohvKjkb3hsBBc0I8Vhq1oHkP51+PP+rklmi8tcoX2YPOYnmWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491695; c=relaxed/simple;
	bh=3wD5QP2/dpAevBf+zh9/nc5WSFUviGisDOW7x4ZminQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mahCKhYmtrfHFTKSOi7GU/qgWTg9td46wl4r3wGlbWDAUFHuB25fckXo7oRntcE7x954VN+LcFgOpUUGxQg+9Do6ADHJxyZqPBL3MWS7YeBw2yjji5/C5WMxylD0JoXlVJHRAYAyXL+VpMZKtC7r8M/2RrO0oEbw2GpEYQPX2tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TiDtklxW; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3lVP6hNOOFzz2vL7CUEUwHRQGPGhudeAnCQr60TaQ8Jq6dnxLadX/h7jRVA4+SjozBIo2KEsKgOUwKvSHLhoaiLMEcOgyK7R3R/guqlo03qYZw1Tkoge3zWSVubONXB2KHvFnqtMCHdISNuaagoLnqXQTDB3Xza1ne0b9o3xWg3cOsD8gdrEKLJL+ZURbrVGoxe3GOVs1irpC3sH8azIijBjWxBwmnmoqvvaGvVc9DozLMy32DrmosvFCWa+71akxwlKT0evI3X6fqdMMeFAD9eOgnux1dhS8wSp7tcOka2zZ/xVRt5IZ0g5fIdiZLKTsKTJEYhci/cHw8U1Zeagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6hIovyisa+9O7UitPeSU1sJDJvcYl7p+9J85ceZFak=;
 b=ZlMgtyzUSNInbVQCkRZYZhFmxKFsU6Un0Z1SbZZKbcY0oDD148m4BYOy2B+g+PeD2UYmR0/YOK+R8pL2FJnfw8XZhxkeusPivD63wMKYXUCqK40wzCnfD0MHuNu8SKhhFdGkkzwv41+Vk+DTL/isEck2HZwY+x+BXeclHgm5QeNTBm1gH2Z9tmzsUzd7+r/RoAPn+Ej39HIovu8NayzreEfDC/ByUzJsZ+tOnF8c2lay4q3iDZUgkxEk2UeQ4Rd1mp5jEwO3mFofyVe6F/867eAIrT3gyXd2q6ILINl8VMW0Kcvs2ale3hTebuBZvbS/uE/sRk49X3sIUx1KXjaDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6hIovyisa+9O7UitPeSU1sJDJvcYl7p+9J85ceZFak=;
 b=TiDtklxWqI0ZOKkFV/gfwyvjLEqxEVsW0/KE2rTTC2Znvl9DP6qo583QEixeMuOdcqp3bTVCtoYo/8fvd9WK15WUHllMy4pBDajj5PfwXK2hnO/2OzJjPUxUnIVrYs1KO6mfHrPdYbOatTlwcyDH+PmQWMF/5XSi4W9d7ZqBAxHXNYPE4thCf/kZIvjpijOgpwT5kXPKzEeRCBBU52350PRRUN4vRm5g37YiezA8ffqv2uttdFHxlHae7HRbmeS7xp4zpkx7uc7wdsDW7o5K/IYZ20SrnuDPo9jHOpu2cbl9Hd0UwRNnQc6KzNkKqkx0MYl++Eyu+iDhEeufpJHvSQ==
Received: from CH2PR12CA0023.namprd12.prod.outlook.com (2603:10b6:610:57::33)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 22:21:28 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:57:cafe::77) by CH2PR12CA0023.outlook.office365.com
 (2603:10b6:610:57::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Tue, 26 Mar 2024 22:21:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:13 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Aya Levin <ayal@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop counter on the representor
Date: Wed, 27 Mar 2024 00:20:19 +0200
Message-ID: <20240326222022.27926-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac51f7f-2376-44c3-586f-08dc4de31437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z3LQEH+pkXsTHztOAELYwHeo8t9mv0AGiq6j7V7jdSo8kSpM43GUg17vKpvxNcYyOflOvk3/X8pk+YcpQZiFuy6kTGOwwCEKWwi/JIBmHlM7HywgB2xoqO7fTl4pnMYghk1rRtxVSyK0gURMK5t6qYeZiqbJ2S01gE2uY64Brb2GOhXO8OEDrHxOQKbEEO6T0+jaO2VFPopGgLb24ZfOMSIWAX4tLNl9R6V4ueE5F5n+nhVRcheMTZk7uSbPgia7S8QXi1L+b9Hkh6Ka0Zp/ULA/hk0BedloGbxZzfZln6N9eJ586Ewmt5274EH03ZzxyhizqtiPfmSb6hSbf/H1OfdqV8UItUxMNgzQFU06ikW2FVNBqEnWuEN0nxlt0gZ71mmpHc84S/N1EJ0zCnrs5mlZxHhNDzoRiDZlNhiyN4smlpC3OaYFDOchZnj0P1YdYZ8cr+M9AMJMeVCVudu3MNGWKdYudaZHlbrP6Glxrv/jlpMaaE6yyGCtZCH9Fi4izaj3cxPjMm/CYLM9LtgSy5pnu1USO1EZvofNQFQc/ZX/MAER36oKDgNHl4ReRq/VaTbB4yHq43KN5bVdkcjAutIekTafAc+lMCBjlRMMH1PYV266S+fFLsenN/GhQ2+YkKS3n4zg/B3HxCuMUn4xsoONpcdfqy7ITYq1ZJe3W0hQW1L1Yrsyougu14dQZDs2+OQNxz1WhkG810BVV2yWAEILRf1hEWZCFQAtsMq0pR6uLQL0BPE+2VzzdvQ99Ejg
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:27.0291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac51f7f-2376-44c3-586f-08dc4de31437
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172

From: Carolina Jubran <cjubran@nvidia.com>

Q counters are device-level counters that track specific
events, among which are out_of_buffer events. These events
occur when packets are dropped due to a lack of receive
buffer in the RX queue.

Expose the total number of out_of_buffer events on the
VF/SF to their respective representor, using the
"ethtool -S" under the name of "rx_vport_out_of_buffer".

The "rx_vport_out_of_buffer" equals the sum of all
Q counters out_of_buffer values allocated on the VF/SF.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst       |  5 ++
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 65 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  1 +
 3 files changed, 71 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index f69ee1ebee01..fa7c00f6d0ce 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -826,6 +826,11 @@ Counters on the NIC port that is connected to a eSwitch.
        and transmitted), IB/Eth  [#accel]_.
      - Acceleration
 
+   * - `rx_vport_out_of_buffer`
+     - Number of times receive queue on the associated vport had no software buffers allocated for the
+       adapter's incoming traffic.
+     - Error
+
    * - `rx_steer_missed_packets`
      - Number of packets that was received by the NIC, however was discarded
        because it did not match any flow in the NIC flow table.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 55b7efe21624..dd74fd82707c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -112,6 +112,10 @@ static const struct counter_desc vport_rep_stats_desc[] = {
 			     tx_vport_rdma_multicast_bytes) },
 };
 
+static const struct counter_desc vport_qcounter_rep_stats_desc[] = {
+	{ MLX5E_DECLARE_STAT(struct mlx5e_rep_stats, rx_vport_out_of_buffer) },
+};
+
 static const struct counter_desc vport_rep_loopback_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_rep_stats,
 			     vport_loopback_packets) },
@@ -121,6 +125,9 @@ static const struct counter_desc vport_rep_loopback_stats_desc[] = {
 
 #define NUM_VPORT_REP_SW_COUNTERS ARRAY_SIZE(sw_rep_stats_desc)
 #define NUM_VPORT_REP_HW_COUNTERS ARRAY_SIZE(vport_rep_stats_desc)
+#define NUM_VPORT_QCOUNTER_REP_COUNTERS(dev) \
+	((MLX5_CAP_GEN(dev, q_counter_other_vport) && MLX5_CAP_GEN(dev, q_counter_aggregation)) ? \
+	 ARRAY_SIZE(vport_qcounter_rep_stats_desc) : 0)
 #define NUM_VPORT_REP_LOOPBACK_COUNTERS(dev) \
 	(MLX5_CAP_GEN(dev, vport_counter_local_loopback) ? \
 	 ARRAY_SIZE(vport_rep_loopback_stats_desc) : 0)
@@ -273,6 +280,62 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_rep)
 	kvfree(out);
 }
 
+static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(vport_qcounter_rep)
+{
+	return NUM_VPORT_QCOUNTER_REP_COUNTERS(priv->mdev);
+}
+
+static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(vport_qcounter_rep)
+{
+	int i;
+
+	for (i = 0; i < NUM_VPORT_QCOUNTER_REP_COUNTERS(priv->mdev); i++)
+		ethtool_puts(data, vport_qcounter_rep_stats_desc[i].format);
+}
+
+static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(vport_qcounter_rep)
+{
+	int i;
+
+	for (i = 0; i < NUM_VPORT_QCOUNTER_REP_COUNTERS(priv->mdev); i++)
+		mlx5e_ethtool_put_stat(
+			data, MLX5E_READ_CTR64_CPU(&priv->stats.rep_stats,
+						   vport_qcounter_rep_stats_desc, i));
+}
+
+static int mlx5e_rep_query_q_counter(struct mlx5_core_dev *dev, int vport, void *out)
+{
+	u32 in[MLX5_ST_SZ_DW(query_q_counter_in)] = {};
+
+	MLX5_SET(query_q_counter_in, in, opcode, MLX5_CMD_OP_QUERY_Q_COUNTER);
+	MLX5_SET(query_q_counter_in, in, other_vport, 1);
+	MLX5_SET(query_q_counter_in, in, vport_number, vport);
+	MLX5_SET(query_q_counter_in, in, aggregate, 1);
+
+	return mlx5_cmd_exec_inout(dev, query_q_counter, in, out);
+}
+
+static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(vport_qcounter_rep)
+{
+	struct mlx5e_rep_stats *rep_stats = &priv->stats.rep_stats;
+	u32 out[MLX5_ST_SZ_DW(query_q_counter_out)] = {};
+	struct mlx5e_rep_priv *rpriv = priv->ppriv;
+	struct mlx5_eswitch_rep *rep = rpriv->rep;
+	int err;
+
+	if (!MLX5_CAP_GEN(priv->mdev, q_counter_other_vport) ||
+	    !MLX5_CAP_GEN(priv->mdev, q_counter_aggregation))
+		return;
+
+	err = mlx5e_rep_query_q_counter(priv->mdev, rep->vport, out);
+	if (err) {
+		netdev_warn(priv->netdev, "failed reading stats on vport %d, error %d\n",
+			    rep->vport, err);
+		return;
+	}
+	rep_stats->rx_vport_out_of_buffer = MLX5_GET(query_q_counter_out, out, out_of_buffer);
+}
+
 static void mlx5e_rep_get_strings(struct net_device *dev,
 				  u32 stringset, uint8_t *data)
 {
@@ -1326,11 +1389,13 @@ static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 
 static MLX5E_DEFINE_STATS_GRP(sw_rep, 0);
 static MLX5E_DEFINE_STATS_GRP(vport_rep, MLX5E_NDO_UPDATE_STATS);
+static MLX5E_DEFINE_STATS_GRP(vport_qcounter_rep, 0);
 
 /* The stats groups order is opposite to the update_stats() order calls */
 static mlx5e_stats_grp_t mlx5e_rep_stats_grps[] = {
 	&MLX5E_STATS_GRP(sw_rep),
 	&MLX5E_STATS_GRP(vport_rep),
+	&MLX5E_STATS_GRP(vport_qcounter_rep),
 };
 
 static unsigned int mlx5e_rep_stats_grps_num(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index b71e3fdf92c5..ef88ce4f0200 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -480,6 +480,7 @@ struct mlx5e_rep_stats {
 	u64 tx_vport_rdma_multicast_bytes;
 	u64 vport_loopback_packets;
 	u64 vport_loopback_bytes;
+	u64 rx_vport_out_of_buffer;
 };
 
 struct mlx5e_stats {
-- 
2.31.1


