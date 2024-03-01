Return-Path: <netdev+bounces-76381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1775086D88E
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829DCB22EC3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99C32E40C;
	Fri,  1 Mar 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d9dFu97y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B082BAF1
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255518; cv=fail; b=gSqY91k5Wk5Pcg+8L0/kst+/RYIRS8Yf+zmz6kCdipGLkZjSiljkgC5NXNs5zRD6fZIVWutw/J15ZpkApFnTgSS3XvVB5o2bqRZ8md/5PGHw537KRX+sB5JnDGkaqnMNnAqlBjVeQlhzwKlVBQBNZDCiuXmmpPWhEbki4sDQLBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255518; c=relaxed/simple;
	bh=E3YeL7UTvyFumCcttZZnjeIc7aIRH1eDfTiRw3IBwiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnlVE4i/m4kDfyP1snbx7ns2g0JW/BCq1NKDS/W/qouI6QC1xuFKCdefzCQ9JX3henYMeH6nKhpt6rjk30WGlHj02uIeq7Rt9SevejPsH7vb2Q3NuqVk/L+BK+zzS2dHHGkLW/o8Ba8cRDRkHdNEyxkxON42j/t3u6cDGDooCYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d9dFu97y; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4CXAM4EErbNCRYdwtR6+IML9tLV3gN8iRGUlvLtAzHQbe05HeUe8bNXtnnIhCvtXcQ5g8lhAQfhEtCcR/+r0tR2rt7T8bFYCDODpoSCsomVdCHmBnoUX+k0pFjR/7NtK9Tk1VH+z5+uNXx8rj1xO5Wu5LoFzVjxXc5udy+drh8EChZ/IAuX5td9EIFn0/5cEJ6YgLuDknI/isUpdde+jfcGErVNNTIV6kqbh7prLe7R0yIPD9UiXpOLPTmKlmGRDHOZDq3iF9UN5gBzf1KQSX3PyB7G2zw4vRSt2JHABQltPSUnGyMpb2UsoDAu1sSXu4voaKbOORA3CRykGt0n2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAO184hsbMGQtqrdBQSsYGez0xreM8fyzdapbxEpgwc=;
 b=aANnOwXOGLtjT1wkJ15tFQk3IUEVeeHyAZyQa7RY/8/p6oTsXzn0T707Xl2y6M+OhKD2K4e/Xle+x1bX/3bFsT6LvV9W8N7Cgc8fqawwWwpK7wSiGYDaKvK3UtojItMu4ajb8KZx57DPMGDwjqomADKDuAmym9aGW5B4jp2XCWeAP9+qzouuApviKYeMl1hjH0F6eTQzYBs2GgH97s+0x+9G/QnYfgxG8ncacPIrIb8uCSk8mm37bcCmVNf5yBQrTEq3NEG5UgrQZbA04j7fS2XvV80yDxCqqIFLyveamG9W3zqbM67qutF0GqCsoM/KNrOg6BfWUdCme5Y/ab8qrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAO184hsbMGQtqrdBQSsYGez0xreM8fyzdapbxEpgwc=;
 b=d9dFu97y1rQATkTQWbEtgPPQKbDSv4HjiEtmG+4Njz7i4PlGjap+CFVjcFeHaOipQztfKp5MazLtFvc5VPYXLT3ZnVSd9kumc46ciVuR9kequSasgTj78NzL1qpsY3RBVEicFJ+hX4ePIjC8GAJSOddOmdyYBxMHcRjrxKG+KKlxx3JcnvFESJoj6vYMWjGNxUo/M8o7f0ggrPt+LapKOlOhqM5V3EBhcyvT4tHhE8FraBlrSlnPKk1OvGFB63X4Z35Mv2qNoi3roq0K6aYFJ0EBDt8B0h5Bx6vplnHVUGhrY9LwzPNOF1c1K2+D2MZYZYxawbtx4bqMwFktl8+4aQ==
Received: from SA9PR13CA0042.namprd13.prod.outlook.com (2603:10b6:806:22::17)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Fri, 1 Mar
 2024 01:11:51 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::3) by SA9PR13CA0042.outlook.office365.com
 (2603:10b6:806:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Fri, 1 Mar 2024 01:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 01:11:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 17:11:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 17:11:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 29
 Feb 2024 17:11:27 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v2 net-next 2/2] net/mlx5e: Add eswitch shared descriptor devlink
Date: Fri, 1 Mar 2024 03:11:19 +0200
Message-ID: <20240301011119.3267-2-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240301011119.3267-1-witu@nvidia.com>
References: <20240301011119.3267-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b31904-0a80-47e9-7c3f-08dc398c9342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ELU24JgPMmL4t3sRL9WIeTZGbGpLm9sj0QVghG2glioU+uMlmSjkgsDRrteyVunWacmDohqxw9AZzYG7SFXePHeDHzBs0epxEEbetPnUrtDlPEKwMFX3Mu+YBM3upE5SjhRlVcMhOcwIaT5n/Z4bJswX4+lc4qLmjvM2S+Fz/0MRaU6HDYzwrt5LXhfcMEdEr8vinRk5cVuVgb0rzqmKpSDBOiEa3M7aPUPlbgFf1zfVKYO+eNu1mrZGCXjsOtPdfFqxwCOQQFoFEDbFUQCVnK5Ea1ouH6ClwDQA96TaA6gp205wTpQ4MhuGLQdNdFv1GHRVLXjjFyUqbwBT3V5f8N2t7tlwGlw/7DTHsacsfozyJw8QSyp0cX1ebUXc1AwGejSIE/wDUR3mUdUMCMHdjAZXGFoYKAvxXmE5AG2+uiKC0Aa9lLF8cRM4kDXo+mq5aNTi9yZsMmLA5jz6dh2kF79NkRI3rX7X4Sl9soKc/EG0780lTK2oX3KHIt6XXXJxQRJhuxWowmYHdSUjfIV+egxzCuH8hukUiOSaUevELx0vKrqG31PuapFEwVnyUEfZ5a3Fo5H+5KgH6n9+3q/d8bFxFdQe3HzVPOfmBCqe3EHu2eqaG+Av2q3F8rnNYe3ZbkhCDWsjRMPcWb7PJzwakzn2y3aAvgNr5oIz6MXy4+J2p6MWQ0VFVP+bEp8oPTALSVKjb6xrckAeoLov5rDq7ZAt1GEFXh2jFi90EpN7TWtQM7V5P+tTAAzzZ8jwLYoz
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:11:50.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b31904-0a80-47e9-7c3f-08dc398c9342
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

Add devlink support for ewsitch shared descriptor
implementation for mlx5 driver.

Signed-off-by: William Tu <witu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  4 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h | 10 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 80 +++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe..24eb03763b60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -312,6 +312,10 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_inline_mode_get = mlx5_devlink_eswitch_inline_mode_get,
 	.eswitch_encap_mode_set = mlx5_devlink_eswitch_encap_mode_set,
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
+	.eswitch_shrdesc_mode_set = mlx5_devlink_eswitch_shrdesc_mode_set,
+	.eswitch_shrdesc_mode_get = mlx5_devlink_eswitch_shrdesc_mode_get,
+	.eswitch_shrdesc_count_set = mlx5_devlink_eswitch_shrdesc_count_set,
+	.eswitch_shrdesc_count_get = mlx5_devlink_eswitch_shrdesc_count_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..f678bcb98e1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -378,6 +378,8 @@ struct mlx5_eswitch {
 	struct mlx5_esw_functions esw_funcs;
 	struct {
 		u32             large_group_num;
+		u32             shared_rx_ring_counts;
+		bool            enable_shared_rx_ring;
 	}  params;
 	struct blocking_notifier_head n_head;
 	struct xarray paired;
@@ -549,6 +551,14 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 					enum devlink_eswitch_encap_mode *encap);
+int mlx5_devlink_eswitch_shrdesc_mode_set(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode mode,
+					  struct netlink_ext_ack *extack);
+int mlx5_devlink_eswitch_shrdesc_mode_get(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode *mode);
+int mlx5_devlink_eswitch_shrdesc_count_set(struct devlink *devlink, int count,
+					   struct netlink_ext_ack *extack);
+int mlx5_devlink_eswitch_shrdesc_count_get(struct devlink *devlink, int *count);
 int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98e..5586f52e4239 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4019,6 +4019,86 @@ int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 	return 0;
 }
 
+int mlx5_devlink_eswitch_shrdesc_mode_set(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode shrdesc,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	down_write(&esw->mode_lock);
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't enable shared descriptors in legacy mode");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+	esw->params.enable_shared_rx_ring = shrdesc ==
+					     DEVLINK_ESWITCH_SHRDESC_MODE_BASIC;
+
+out:
+	up_write(&esw->mode_lock);
+	return err;
+}
+
+int mlx5_devlink_eswitch_shrdesc_mode_get(struct devlink *devlink,
+					  enum devlink_eswitch_shrdesc_mode *shrdesc)
+{
+	struct mlx5_eswitch *esw;
+	bool enable;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	enable = esw->params.enable_shared_rx_ring;
+	if (enable)
+		*shrdesc = DEVLINK_ESWITCH_SHRDESC_MODE_BASIC;
+	else
+		*shrdesc = DEVLINK_ESWITCH_SHRDESC_MODE_NONE;
+
+	return 0;
+}
+
+int mlx5_devlink_eswitch_shrdesc_count_set(struct devlink *devlink, int count,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	int err = 0;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	down_write(&esw->mode_lock);
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't enable shared descriptors in legacy mode");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+	esw->params.shared_rx_ring_counts = count;
+out:
+	up_write(&esw->mode_lock);
+	return err;
+}
+
+int mlx5_devlink_eswitch_shrdesc_count_get(struct devlink *devlink, int *count)
+{
+	struct mlx5_eswitch *esw;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	*count = esw->params.shared_rx_ring_counts;
+	return 0;
+}
+
 static bool
 mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 {
-- 
2.38.1


