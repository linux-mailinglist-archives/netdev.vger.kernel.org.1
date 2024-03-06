Return-Path: <netdev+bounces-78158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F1874397
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E099E28257C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA221C6AD;
	Wed,  6 Mar 2024 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npdgZ507"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28781C6B1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766797; cv=fail; b=CdLWbvSwf9T1fziVzOVGQAB/O04KKn3He6D6CbWHDgl6fvlSAieUZJ6PP1ggcwXgf5lYNAWr5E1pYhzND8NfHOqVtq2XTFexobhy4SbyhcPoY2CQLy5BcGA4UFLJyhRNJxogqrVcZpP//O3JYC4RlIi7B/MgoD0qjCJIdKbr2Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766797; c=relaxed/simple;
	bh=PjngBCRtZ/RbWTzN6TMYuiU2AyI3EiVR3HgUeDM+Bts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKCowT2PqgsnX2Rzeg2rOmfdcF1CDfDwDBPM2xJx9iwDYAS9xWCMjMKrfJlN6mP4M/5fedm3BjJVWMcxfdb7j+gHqehFoUhEdr7ZU6IpqHjf5xkb2sQkragTJ61CinN2JvNJE696F2fLqQVty7Pt0pWDlJ6pDK/3SMtV/MlhZ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npdgZ507; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXCNy8YRKBKID7RPvtTay00MbNP3UCAGEI0AfzZv3ASWzadZ4UA1IE5lnnDs6ZejuKoLVdVHZ6CRQZ4Fvyz1SlfDwFhi7TNfqCRPUKJv0MSrA60CUF0h6S3FKhkgtlT8ZqUJM59V+l1yBj1VKImpekajhRJ4v83r05PNiI4BxjHV1CtvmHHjEswCGNlwg144LUug6nuDYEvf/L1Y+x0/Bcx2a4vH+ENp88AbQNBhNcOj2Bba8F0zlvB5P19ofcstTVo+hfrUDirednozgS+ZhhKyemYU5nZagdstlo5bI2kEGwmPe8eaNLpBksBbUuoT0Q1Oyn80YaRHpLhm+JdKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdlzSzKxT1w/Bz8pzv8ZF745hhM4NB9C9+PgbJMSSOE=;
 b=A9bzYKxxEPiYK7U3fV5a0o8OZ9Wd0PK5/euZDPpqDXzkRm8CLXAy9NYYdLrWb9R8+Xx74SN0mN7c4osFQjv2y0MhCVD2sBYONyXAC9ZDs77K2ASpD8H4a8vzLFEDMirYrsi6I9psJQe/CuSrAOo6lkD8+1gIph/UVM9nurX3ASx3OJvaEw+/07OYFJteGNMCMsGXG6lXZlBeFmsz/DtHv60D+wtGNQm1b4J4Z1oH2wNn/HbW+OgYWN3nwbSkTZbU235ZY66nQY5OmN0EKzIpmIug/2sli5ElFoG1SFO/N2w0kiKud/8TX0NiEAOZ13npjzF3rNyAdekko0sYDHEEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdlzSzKxT1w/Bz8pzv8ZF745hhM4NB9C9+PgbJMSSOE=;
 b=npdgZ507cYqrNX4BbgIUGk46pSWc7j7tLzxoT+VHpzAVDT5dkjcq9TLKH3tgEBScu9KCWDxm6I2uQobIqAmUHzHoMTiMCiG9ppTICikbpx6aOJSWshi/gg0oZ9X7CJV/OELzoAeA5qf1kqFJN/T6gbfz+lJSfAkMWPidCmEOIreqRDrou8UR+rkIMSKF25GbUH8/t1SyZxF5A4EHV64II7fbWeV1OdUei3JsFy9kzWfN6CragGc1Us15kNex2yAeaBl9h+ZDZaQwNtYp+fv0i0QLnU31YNJFY4gwjF/pLa0gVnFHOkayMamYIZwV+2j70aFM8krZBmq99DWreMmakA==
Received: from CY5P221CA0106.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::38) by
 DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Wed, 6 Mar 2024 23:13:09 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::97) by CY5P221CA0106.outlook.office365.com
 (2603:10b6:930:9::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 23:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:13:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 15:13:00 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 15:12:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 15:12:57 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v3 net-next 2/2] net/mlx5e: Add eswitch shared descriptor devlink
Date: Thu, 7 Mar 2024 01:12:53 +0200
Message-ID: <20240306231253.8100-2-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240306231253.8100-1-witu@nvidia.com>
References: <20240306231253.8100-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 47419444-407e-4ab2-6883-08dc3e32fd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EePODZRZMpqHqFNslDSzSSIQGzlLz6QlZDyABMUVhaG+y5PO/e7mACOc+z21B/8/jWGJ8jq21ap+EsXVQmsS4VH5QMK6WNihQQuqXoJis0OMZXCAAw/EhOJHJn3Pkd9V3IMx0yl7xECcNDzjUT7hwMRihxpx+v20FgLb37nrK3t1UOv9dL29fb9y830bfQxURTM5Cw4wnbRYRPP5HxznwAOh4Cn1CieQVFkTRKGUUWPzkf87z+gYLyU+X/dqBKYm3K3TGrtFwat8P+Pj3YsgCfT/mRduQTonFBI0hy6eDtIuwWpB2ZpcNmygLDHiIzAHN1gfxe+5E0csH1tK/k+tCh0QywyVHAzzPhzTQ3Q06HGGRDrCUAe2sEBzPYokf+O4S9Jg3MHVHQi0AJin6HHElVUlViwdXai6VIIBiyOh+N+OABoa/SQEMAI9nF7UI8VMX1UDwfMme5p8Zob5kSET5mHxF3IslWSDkMoQi2+N7KyE3ML1DbNcDNhtN1jPNQjaKkkK93H5wF+aafSMtiO50aLTbh3MajB8roPzgAtV5BtkXrlZ9h7ZpNwZazxh5DsTkNXSLRcg3lDge6m/dmWQSQmY7SKJPQICYtkva0gVR3ZHPkP9KJewOLfxBJwQGGEBLvnRipCs/a89xteqUcQegMPifUQGO5yZbxSFhE8dz+O0J+tcK+9egiENpJtyDKLj7hkKOimRr3yeLlS4XJURByc/OTUkcy8ySDnJI229jnqxHR3u8Oi+0ftAKtUbe8X9
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:13:09.3923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47419444-407e-4ab2-6883-08dc3e32fd16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188

Add devlink spool_size attribe support for eswitch shared memory
pool. This is used to configure the shared memory pool for eswitch.

Signed-off-by: William Tu <witu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  5 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 49 +++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe..cc0c50691ecd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -312,6 +312,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_inline_mode_get = mlx5_devlink_eswitch_inline_mode_get,
 	.eswitch_encap_mode_set = mlx5_devlink_eswitch_encap_mode_set,
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
+	.eswitch_spool_size_set = mlx5_devlink_eswitch_spool_size_set,
+	.eswitch_spool_size_get = mlx5_devlink_eswitch_spool_size_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..2e2e3b5c3b3f 100644
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
@@ -549,6 +551,9 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 					enum devlink_eswitch_encap_mode *encap);
+int mlx5_devlink_eswitch_spool_size_set(struct devlink *devlink, u32 size,
+					struct netlink_ext_ack *extack);
+int mlx5_devlink_eswitch_spool_size_get(struct devlink *devlink, u32 *size);
 int mlx5_devlink_port_fn_hw_addr_get(struct devlink_port *port,
 				     u8 *hw_addr, int *hw_addr_len,
 				     struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98e..e27d9fba8840 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4019,6 +4019,55 @@ int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 	return 0;
 }
 
+int mlx5_devlink_eswitch_spool_size_set(struct devlink *devlink,
+					u32 spool_size,
+					struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw;
+	bool enable;
+	int err = 0;
+	int counts;
+
+	esw = mlx5_devlink_eswitch_get(devlink);
+	if (IS_ERR(esw))
+		return PTR_ERR(esw);
+
+	down_write(&esw->mode_lock);
+	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't enable shared pool in switchdev mode");
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+	counts = spool_size >> PAGE_SHIFT;
+	enable = !(counts == 0);
+	esw->params.enable_shared_rx_ring = enable;
+	esw->params.shared_rx_ring_counts = enable ? counts : 0;
+
+out:
+	up_write(&esw->mode_lock);
+	return err;
+}
+
+int mlx5_devlink_eswitch_spool_size_get(struct devlink *devlink,
+					u32 *spool_size)
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
+		*spool_size = esw->params.shared_rx_ring_counts << PAGE_SHIFT;
+	else
+		*spool_size = 0;
+
+	return 0;
+}
+
 static bool
 mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 {
-- 
2.38.1


