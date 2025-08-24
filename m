Return-Path: <netdev+bounces-216286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E1B32E63
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44651245946
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FCF2749C4;
	Sun, 24 Aug 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HNkUapGK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084525EFB7;
	Sun, 24 Aug 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024860; cv=fail; b=PIO7X6gMDwk51Ep/Vy/zo3ielGcYbP8uBYNnlon8CNUuDlx0ZXrNo4+cd0bQXFwbEzhI1XbPmbteu/8QIkVgu/wK5mU50P/RilDbPMNcJz+rQKXnKvX5jz2TCmaJfehM3znA/qLwTrdm0b/upKR5X2uY7utOibbgBwCrDVCXryU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024860; c=relaxed/simple;
	bh=ClhUyjvjEEKD06NFYcxXlKPD8vuVCdFU9Q/H0Bb4cGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjHdLsWnEh2T6JeNRsgVfNlPxdxq2snRPXW/BtUW449DiWrl4JFfZ0HKr8REAyhX8a//GTm4dYJb337b7YfCIT83Ls1NGFCX6tCTXEIXbTXmb8pXqazM2LOZUu8N8UkMpI+acC8L7DPPogqbWRbsuesIa36RambCQIWMfW36AlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HNkUapGK; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldcA2Mhi36nZrrKz4OLBePs1rrHJ9bSoC2uNJL29M9TG2qBodJjKDLXeq4wSkcqKPxUq/3KhTKG8h0KxcTUxuYz6KIO3ZQqhrqY0DiuTEK3gJfoOaWBzEVTN1HslXodD1J4+UGedfWQ9UVMA5vQ04tVzf23s3JqbjHOtkHnYTmK/Ia5V5tTNOKE2mcjTKQwPyv0ZyLXjvR+HTkMz9eK/F+bSIZlXrI4k37cWmmdLy80aL19qMnTCgw3MBovBaG53uPAcLKviMZ1mve3bgwfC0jmI1r8vasIwYe+zgq8NIFcIs1icffcuXmDK8vrZICr7kfhnyEZ/yYFlpvaMCJ9aVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZSeYjjkUcxj8LEv+LRhzMUIpz5SuulFxbJzoROLWIk=;
 b=wx6OpUUUJ35R90TgD75yVu8qRYOVATEueLcecQrDHh1K9tEVeYQTQYFBB0QQJeXVG6nB72DG5vjKxyvJU/ck746LJaWzwvMG4rSzUE3Nx3umjXqSWUrjQ++yF1dx1ePKmqRYpBuvUzaD+qzlM63EslIaCHjE0dbN2ZAL+LlU+FPXbdq8Y+7o90lllhyOMovwBWfI9yIOm5QIyrIqtmcMrZ74CA6U1L57V5250ig0PqxzTuhks/QlSrAyuduOm3k0bxx2riBmi1TC8Raz5R8q0uRDll1ldBI//CDEEWoYuSQ7f9hiMYwW4acDy6N4I0Ud9N61i/PFlALFv81UTHvfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZSeYjjkUcxj8LEv+LRhzMUIpz5SuulFxbJzoROLWIk=;
 b=HNkUapGKM2uob2YvIwiTmAplzPKDCIhgVNUYiE6NTKYFXIV2EFcAlB/3if58BF2ERBs+UhYPpNZ/bIE3XBipuR3B9jMEV009458kCSd8ja5gO2QYU+EOI1Jg+Vj+3lPiUULVJPGwbZNqxRv8kFQfDTu2OpBtXMZVHXTTdj0QiH8p+XVs3BohPpIrYcP+2faREYLvro6jEM0Ly1bygqOMjMG5/52N3evB8WqhPhpuXDQWdB8Do6XOOF1n/s1ANjxbPvPfpsEzs/jsp3gEnYHUIbhkIHLQ33AiUw2rbmPKoQ9kx5CEAZpWfk80+jh/DvkAkx6siaZ5P/6+saYoPmSJsg==
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Sun, 24 Aug
 2025 08:40:55 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2a) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 24 Aug 2025 08:40:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:38 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 11/11] net/mlx5e: Set local Xoff after FW update
Date: Sun, 24 Aug 2025 11:39:44 +0300
Message-ID: <20250824083944.523858-12-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 43242f2c-1504-4896-8231-08dde2e9f0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e0mppvBkpXVUztTXL4CBtTe1U6xnNPgEJ92RPayBM+7xAB6TqIHh+GWIVbXn?=
 =?us-ascii?Q?01TZ+MSI07X/echu1TgiBB8x9i8fK7CcsvLZ/8WCJP6ruu5CbTrT36hvA+Qk?=
 =?us-ascii?Q?53PwysfriKDvKMVZB7Zt47lrqQh4v3ZQn4h30g2py1jEYamefhV44pWSLJ7V?=
 =?us-ascii?Q?mBi2vbvvnvlcRNe78ax8O9s+lc/f1mEmiBd8XLqPjqMbTQ2rWok7fn5JWP4Y?=
 =?us-ascii?Q?6rL+rvitUvwAXnnwjs3OE5sJfH1ZJVa8NdrvkkAdUIvdetnTw9BeE5X2ZPdR?=
 =?us-ascii?Q?3nES8ZhI1ao5eXSbLIUMmMNSu53Q+RVJHK0VJ9DlG6v6BiuffD9Z0tbURQG/?=
 =?us-ascii?Q?gJHqujxLCbhOpHVYt/y6sXoQxMQ/ffKGAMRYj+KhOWzM02HaNqXmdCJdAmfE?=
 =?us-ascii?Q?Meqk09ojgHpNIqSUFu0Dnvg7+PnCch98KhZMgdKjcaNoFp/2Z+fJG11tD0LR?=
 =?us-ascii?Q?UPWD1eOT6bBx5D9YrgRo+nxsOKitNzSue+7J/3xYgdtriAuqQDtsw9IwkWyG?=
 =?us-ascii?Q?Iw6OeUOVutCebffU8qNxLn5ATpamgVJ8FA7Wu6afVxMes0YrTYYzJInGRHMU?=
 =?us-ascii?Q?Pc85YVl6Y+WqwQh3kYgR4XSrI3enUxKulQahHLdBHgferX+ejf6adCb1jRBi?=
 =?us-ascii?Q?Fbza0sOunc9Mo1124JxLADpOLHUDd3UvTvMvfpRmjmpMoYT+gd2DjyEypaBp?=
 =?us-ascii?Q?kTekmTJNXay6EChfraHEha4/htbBrApEHFIoi0wR6esnnUXewSC3HmAyisCy?=
 =?us-ascii?Q?5sZ4JcE05CSnGs9tyomaGm2qDYWEBDUg2Pko9IrDqEIF5QCQ1BJ1JHb46AZz?=
 =?us-ascii?Q?8VBVjyVMxOOOYRFENk5S0EQpjALAAdzhJ+Phbw8jDMe6k3v6LoUxqFiF4I/R?=
 =?us-ascii?Q?FtyI/75bBAuWMSNuyCm/AVaEwE/BFGjixpUXscLkRW1ITWqSxIJ5mdT4mzsr?=
 =?us-ascii?Q?6hPTSauZkJnP6s++wkQXpj286or6TFwbiW7lmsIGsfemAvwu+IP4RnQiHTGR?=
 =?us-ascii?Q?cMNLYMwDSOCuPv7JT00lzAw6H7D5xQXM6uGemBxIytUGqmRQeACkGlDGBWp4?=
 =?us-ascii?Q?yXsd571cj2ZWLjNfpczLGmQJSQZRkBoP/k2aURWXlNnsEedhUE7cS+2nvBZI?=
 =?us-ascii?Q?ZxD87GiOA55qZxeKjeimO3GSj8MA9N/brgqB3Ff+rCy11x8BpX58KJjEA45L?=
 =?us-ascii?Q?F8v2JbeLiUN56fDwuWVazUIT43Dr23WKT8y6xzGCjVl53/A87UPa1rZDpWZx?=
 =?us-ascii?Q?rMcPF3/JZ2KjpLWkir+CLuaf8cTY9TZH8TbTNcZXfZQjZpa0WmyvrhX0yv/v?=
 =?us-ascii?Q?fmwWflrGsUxo4U1756m4CKs0k2cPGEg/ZVibC8yDbbLnzuaZLBQd4XFH65Fs?=
 =?us-ascii?Q?REdNO3eCkQu+XTUohogzMIlNGtpHQz3gOPWsQ5ztvCldjxEGJhtGoTLSJmr+?=
 =?us-ascii?Q?g8zv55lR0mOvhrkKyzMz1m2I/l/BIDkZqGeggCA0BxQNTNQcCwh0sH9Zf9OI?=
 =?us-ascii?Q?FMMwrFo868maz+986p1ZsqR6RZtDSOJFyx7C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:55.0245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43242f2c-1504-4896-8231-08dde2e9f0ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

From: Alexei Lazar <alazar@nvidia.com>

The local Xoff value is being set before the firmware (FW) update.
In case of a failure where the FW is not updated with the new value,
there is no fallback to the previous value.
Update the local Xoff value after the FW has been successfully set.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 3efa8bf1d14e..4720523813b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -575,7 +575,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -584,6 +583,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
-- 
2.34.1


