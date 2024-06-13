Return-Path: <netdev+bounces-103250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A679074BD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 16:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F91F284B2B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B6146006;
	Thu, 13 Jun 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xk60JxHs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29408146581
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287878; cv=fail; b=QNwgmrYZvh3BSkjFnoo5aSGty+yRVV06cxlAo6ZwFvgADelRJtZXd/d52oR7AU/V9W+9iwl0ZCmV5czXKW3QA5q45txNGk8Jy8atktI0Umd+2K/QnGZuzNUst4jrYLphLXfe7fACS1Pt0vhTFA0LreZHQF5VFdoHttOekvCu0PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287878; c=relaxed/simple;
	bh=eGw6VNQXEOTwj+8OL0WLQfXRqwfzmdVRCVLqlhXcOS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohzsRfz19Lyode/EYRyKsF1WqZccQHtKjSIGHEXqx9ei3TA3QegHNvM0TGtSK/OYJuXXfRLXgHC7fuWCu8MznwF4yuuAjnVSiwEYNUCN11gvP0LtH2HmKYSYeilKuAwvs6JEawAl8k3R4H0tgvfmvwRtchKauGrZDM9UAdoMdXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xk60JxHs; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOnZ/toBS13bftuDpa2z2ELgDwDPRB2ttoadLU0LyK6CVpUyGhovL7/ZbDiPUfWOqrDIbkT1T2DIjGr+wqIGvzGT267KNFmRIHQIHRKQJiuYVkKA7ulzSMcXLNZtqNm4+XqWWZeAsPxHpBoN7e7VIaa6Aa0efLGYQQZmvYQG6LMcxFrnSTsAgAmVBOoobcae3nL/aIdprXFUguHV0PFKwEl3fMNGR5I8r49QuavCo0dTJ9OiWS5HMXwl7c5qiEn5crraeBZm5HoJWMbws/L1i/D3mQYXmKf7tEmPm8VqZ0wHroqGY12MhYWv718PObpbi9FyUpjBgWjbq/GVMSlfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1J+U0C3V+knp4mG0g+id4cQNjc0oRtzkWyKUABr9yg=;
 b=NvhjK5Je6JNs8JU18ebD/YXzT9uaOfXAPvHzOEJg9ml2CNX0znWnTS3uMCxcchkftIQ4YPa8/iZXawcRP5wbD4Zg8DsfoTJ3n4IGlOGXTmcLkTLe1SwLktFTi4wPM7Ayi+Dlx0F48/5MxfqsekyM3yBoIpAs0l2hgVrgyMUJqeghR+N3omGVifmnMB1ZDTysqt0XPnJTLJqw3ocaPAY+XH0b/hXTU0CxysAn276joYP/KZW3tIV0+53yn4PoO/SfQRDnm4pMGPaR/LxQaFjguyRhWzLK3jArkGN8igQASpKh9qYtdT50tBJwcPTlPI25Nl8yCHeYe0AJnYmmgJ8p1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1J+U0C3V+knp4mG0g+id4cQNjc0oRtzkWyKUABr9yg=;
 b=Xk60JxHsYXqRl4IuweJtljQr6iB9we2FoFF0BN5yRlukX1kXWLyVk7NsJah/2DLpPjgujAb+asWVDR/gnjuEiiz3cKqsmhrecun0i0hlY+mAdrFUEvvdtM9rq/T4C50nxd3nspevKuJKsJ03l20qYBSmsSD9UrovojTO1/xjE3CxyjlN1MBmfSLJiRCu2if6nFgw1oxRi6Iv+ayu/rK450WJBRvHdzgryGxWb8O+EhzaYF9JsD29uI96m+Dq/m2Me2KqEYvC/h+arS2U4ZhzwkStzWtx4YhcYRcPlJbGl6dOft2iZO6sQXSfRyO7t+36+0UV2SDQQaTNSwQ3kAE95Q==
Received: from PH7P220CA0110.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::21)
 by SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 14:11:13 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::4c) by PH7P220CA0110.outlook.office365.com
 (2603:10b6:510:32d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 14:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 14:11:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:47 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 07:10:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/5] mlxsw: Use the same maximum MTU value throughout the driver
Date: Thu, 13 Jun 2024 16:07:57 +0200
Message-ID: <89fa6f804386b918d337e736e14ac291bb947483.1718275854.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718275854.git.petrm@nvidia.com>
References: <cover.1718275854.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4122044f-7547-421b-377a-08dc8bb2adfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YR0/QABzgw/ZRRL9fXe+1HmDqUo8OHCxG5kNaN1JNtZiwmza4GKUtRFOTs8y?=
 =?us-ascii?Q?BCmsiNNAfk1GuRbZXki4qIcQ/JlDGnpZ80yf6GC86tv4K9b1B4XNynxKFYR+?=
 =?us-ascii?Q?7e2G2dAf6cZ90QGCdEwOrRAnGNyBVEcbvM8wAft09QOI4w69DjJo5AVuKzi9?=
 =?us-ascii?Q?5JM/+aXeYxiBr+Zd+ZWrLuzjyvCfGgBle2LZXswFfqitoaQE+Qjp3SQAmxNi?=
 =?us-ascii?Q?6ZMAb2Ud/yqnVCHmX5ghzkaLG+bOSyx4kfltvSj5Zr1VInun/Js3nV6DLw/1?=
 =?us-ascii?Q?kUyOjKDCPxIkSu30ahQ1612/aEDIjWjeqEed03oNxnZF8qzn1HVtUlIlwgCS?=
 =?us-ascii?Q?XbrtaMvVdzjjuxmqJtjNEF7h6ruPrgDo5oS58FgW9ezKyBr4+VtGp8nru4oX?=
 =?us-ascii?Q?JADYh8/bqlE+D6H1G8r49eXbpgr3Dk7A1L/4fWWbq5pNHkhUXuKoDUR2XTjj?=
 =?us-ascii?Q?BP1wLPYUSrAewNW7e37gitA6Fa1nW5RyTtEj+KPLjue0R/+atJYbBkFDDi7n?=
 =?us-ascii?Q?N6FmKAlSiPQs7Ff3+8zG89RGf5o7vqQ0qX+Flweb1p0V3b7EUrdpzZZZ0dyy?=
 =?us-ascii?Q?gr8uZwNg+xed7K7NAQixBrL19nJ8jaDnb09OqBMRLrlzaqXOrrxcRZ6jwnLA?=
 =?us-ascii?Q?lU4ErSBRNDJSO7ME5Mb9VZw2STRA1rJdpv3g64Nwpq7YSiYWCwu9NhSx7Fik?=
 =?us-ascii?Q?YQV/8rQiWtdLW1KzkdfMgQ22X+TgvioLxwUuMyWXDE3GjPvrLCWnKBGNMNVY?=
 =?us-ascii?Q?w4qm2Rjgz/F/V28qAk2aG5wEgnd4UZwtwnMLg2G93tJvwvBZvUxy3N6mT+nE?=
 =?us-ascii?Q?Pd3nzFYC5aqMzCO3GBDX4xoFxHJRFkMLImD+zePYIllQ6ASdZhBzf0yOr+x5?=
 =?us-ascii?Q?7ewKxOuh9KXFETm9jsdcstfcfOdJZ6P7Yb9Kdg/IoEBr3TtCt0wVpSUcrePK?=
 =?us-ascii?Q?n0lRsRlIxVAN/yu69FiorjLBlrUkfpXdCuFDDDzwQZF1kqzdvtrVoG4uJImX?=
 =?us-ascii?Q?Cyenm06Ai/FjtbIIRVCNSPqOVb8wiLjTocAe52+QkAtVo9CcdWNVfiOH7XKX?=
 =?us-ascii?Q?xc+dZXuRmDrlYjmYtw0nUEb7ILl6IiIBq4F+aSL4P6oRxcSXSi6mQin4UIjx?=
 =?us-ascii?Q?lBcFdwzZmeeNsT9BDTAlbYSZJYexUqUimY1VxQnJJfsFINUUWhodlwsXVheO?=
 =?us-ascii?Q?zyADR+A9UGHo3cgkbhZ2FOuuCDfCD1TmolCBhlZRE425XW0VEv6Iqlc94eF/?=
 =?us-ascii?Q?TBkMSOQHinCIhj9wx8DxhTN8wJdrw+EUItZchKA3N1C79GMYAHnkHxL7VBMW?=
 =?us-ascii?Q?jk7Cf1oUfNQYvS8CRrVSNc8OxwWWCky+OsxTrqEIRc3Zz54ZSXsNVc3aUPrg?=
 =?us-ascii?Q?De6qta57/O30O/fHYsS6NRSUlc5jHpbDcA1luJJQfR9Z5GXduQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:11:11.8166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4122044f-7547-421b-377a-08dc8bb2adfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949

From: Amit Cohen <amcohen@nvidia.com>

Currently, the driver uses two different values for maximum MTU, one is
stored in mlxsw_port->dev->max_mtu and the second is stored in
mlxsw_port->max_mtu. The second one is set to value which is queried from
firmware. This value was never tested, and unfortunately is not really
supported. That means that with the existing code, user can set MTU to
X, which is not really supported by firmware and which is bigger than
buffer size which is allocated in pci.

To make the driver consistent, use only mlxsw_port->dev->max_mtu for
maximum MTU value, for buffers headroom add Ethernet frame headers, which
are not included in mlxsw_port->dev->max_mtu. Remove mlxsw_port->max_mtu.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 23 -------------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 -
 .../mellanox/mlxsw/spectrum_buffers.c         |  8 +++++--
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index c5856f4d6b8b..f064789f3240 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -405,21 +405,6 @@ static int mlxsw_sp_port_dev_addr_init(struct mlxsw_sp_port *mlxsw_sp_port)
 					  mlxsw_sp_port->dev->dev_addr);
 }
 
-static int mlxsw_sp_port_max_mtu_get(struct mlxsw_sp_port *mlxsw_sp_port, int *p_max_mtu)
-{
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-	char pmtu_pl[MLXSW_REG_PMTU_LEN];
-	int err;
-
-	mlxsw_reg_pmtu_pack(pmtu_pl, mlxsw_sp_port->local_port, 0);
-	err = mlxsw_reg_query(mlxsw_sp->core, MLXSW_REG(pmtu), pmtu_pl);
-	if (err)
-		return err;
-
-	*p_max_mtu = mlxsw_reg_pmtu_max_mtu_get(pmtu_pl);
-	return 0;
-}
-
 static int mlxsw_sp_port_mtu_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 mtu)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
@@ -1725,13 +1710,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 		goto err_max_speed_get;
 	}
 
-	err = mlxsw_sp_port_max_mtu_get(mlxsw_sp_port, &mlxsw_sp_port->max_mtu);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to get maximum MTU\n",
-			mlxsw_sp_port->local_port);
-		goto err_port_max_mtu_get;
-	}
-
 	err = mlxsw_sp_port_mtu_set(mlxsw_sp_port, ETH_DATA_LEN);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Port %d: Failed to set MTU\n",
@@ -1875,7 +1853,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u16 local_port,
 err_port_buffers_init:
 err_port_admin_status_set:
 err_port_mtu_set:
-err_port_max_mtu_get:
 err_max_speed_get:
 err_port_speed_by_width_set:
 err_port_system_port_mapping_set:
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 3beb5d0847ab..bb0586b45c8d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -359,7 +359,6 @@ struct mlxsw_sp_port {
 		u16 egr_types;
 		struct mlxsw_sp_ptp_port_stats stats;
 	} ptp;
-	int max_mtu;
 	u32 max_speed;
 	struct mlxsw_sp_hdroom *hdroom;
 	u64 module_overheat_initial_val;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
index ba090262e27e..2c0cfa79d138 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -399,11 +399,13 @@ void mlxsw_sp_hdroom_bufs_reset_sizes(struct mlxsw_sp_port *mlxsw_sp_port,
 				      struct mlxsw_sp_hdroom *hdroom)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+	unsigned int max_mtu = mlxsw_sp_port->dev->max_mtu;
 	u16 reserve_cells;
 	int i;
 
+	max_mtu += MLXSW_PORT_ETH_FRAME_HDR;
 	/* Internal buffer. */
-	reserve_cells = mlxsw_sp_hdroom_int_buf_size_get(mlxsw_sp, mlxsw_sp_port->max_mtu,
+	reserve_cells = mlxsw_sp_hdroom_int_buf_size_get(mlxsw_sp, max_mtu,
 							 mlxsw_sp_port->max_speed);
 	reserve_cells = mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, reserve_cells);
 	hdroom->int_buf.reserve_cells = reserve_cells;
@@ -613,7 +615,9 @@ static int mlxsw_sp_port_headroom_init(struct mlxsw_sp_port *mlxsw_sp_port)
 	mlxsw_sp_hdroom_bufs_reset_sizes(mlxsw_sp_port, &hdroom);
 
 	/* Buffer 9 is used for control traffic. */
-	size9 = mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port, mlxsw_sp_port->max_mtu);
+	size9 = mlxsw_sp_port_headroom_8x_adjust(mlxsw_sp_port,
+						 mlxsw_sp_port->dev->max_mtu +
+						 MLXSW_PORT_ETH_FRAME_HDR);
 	hdroom.bufs.buf[9].size_cells = mlxsw_sp_bytes_cells(mlxsw_sp, size9);
 
 	return __mlxsw_sp_hdroom_configure(mlxsw_sp_port, &hdroom, true);
-- 
2.45.0


