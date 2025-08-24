Return-Path: <netdev+bounces-216284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A4B32E57
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EC6244E1F
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40C26FDA8;
	Sun, 24 Aug 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvQIH6Mt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1226E6EA;
	Sun, 24 Aug 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024852; cv=fail; b=A7y4DaFddYGbfb6QWmVG30rNeWrciKmpHrA0Yu+v7337gcpIceBXub97bI057IcBXyC2FVsfmglO1vLP9eDd1v5EPFujezI3xfWbLoacnFaFbvSDUp4qMPst4Lugi6MrjzLfnXE9HoOuQ0mcBy9WXVEfuCXhisVYsaKycJGpkbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024852; c=relaxed/simple;
	bh=V5fAULIVCozIS7YzJ99oKJ/+rbcWyDSMq73LYkIkre8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E68Zdv2SpkZJ7J/OEvRI/r+RSF2fSTUVNKx9/iZXuFTtqXZqQ7glAIoKnU3zQ/DessbSfxgeVS4M24c4WyY2ixmvnuDuMSzN9vjkh9AfCRHziOBCv8SZMtYIrYapmW2iiK7cITRuEAHO1Z4fMyMFrEQ71zaY6WELlB9QGhgGEUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvQIH6Mt; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKewmpDVH02O9UyXoPm5r3IoUu6MJsLVc0/YLDcBqXn4s/yD0Vo75z7loFfh7Vzf2Xhu3F5n+Wd/Zd3OG6dnFKc+Ia04q4oe2sstlVpSYdjY7n/uAV1yUelWBNktZFy5Sku5Sn35tn4jd/CRyBPSCBcgQuFXNhKlT7FAewEPQvj7ZjYQ1wHQmJ/zq/Zqb5PIlb6l+8vST6RV+QzzfFpQ6txKOZlscLkZHvjQ4z2sBFtAqiQE7LvePz/zqnb2+Ue9QB3nmCGrVwybAqsl6haDuMCpmtLtL6WsYsc9BcftYGmJyU2vpxCONzx7NrpLdjWDjiZIcZ8Tx14NAXoy+4/Yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMCw61NOH73+XwEgsXJn2rgT+b+5unaydoT7+e8Xz6s=;
 b=iof0eCquh7o2DRf1Cvplh/eA4nXFMUtrjeglgVNQ8Csdp+3xMgCd6EsEIpfXDPbZXP++xSzrWEBNu0EAZdSrdkFFOQnmU0gf+AcFMrIRBUb73woKBmbHdVVwxRyEVMRrQwhyre3KjopSbQEqU9EbxPXYeFgYYcsR+I9AbBden9CPkOoYmYElsvbydYalZbMbNMPGxNHQauzSMvtUES8pLbhiAfPLQVzTdvE9lDAlkbMl3ft7FhsJvObUGvKvmGPUysh98Ii2aXRBQKxeLI6g9q0WZXmOHHNr9llmYuGoI6v3o546pxqukCmgXUVjQSzvEAnHolYVw3bnmtsskNf2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMCw61NOH73+XwEgsXJn2rgT+b+5unaydoT7+e8Xz6s=;
 b=CvQIH6MtwaJO4HKYiIehBqHwVurHIFLvgWnijNx3SroDvQhhREckW9yWmQMfovxS7WIYYttQ6LPHmZxoAxA10bUCzCHXytJm6NEopSUQzj7m/oIj7Elh0NeH4b08UkoGxfMVoCojxw1IGvd0oiCyQEKni6Q3kcrjhpybnzUMgHNCfS6EnG7JmM37GB8NJpkNFBGrxdcbd4zjs6wQu1j6dwLDDnGhCDdJ7aSMh1IW0Ws1WddJEFxjURkuE9hCWoyozMhEvSJ6GBW2Bg9PcqTuQihDJ4cA4NTK29qiyzia1NjBxft1XS2qOw82On90GMiwBX8O4eWK7mm2JieEYLP1eg==
Received: from CH3P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::27)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:40:46 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::7) by CH3P221CA0026.outlook.office365.com
 (2603:10b6:610:1e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:29 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
Date: Sun, 24 Aug 2025 11:39:42 +0300
Message-ID: <20250824083944.523858-10-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eeb563-4981-46da-b1ca-08dde2e9eb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kp1+Ep1WDIkGxhx2Amc6BT2d1BVJ+MKrRm3dObACcIW+2nxPwiQVP0h20q07?=
 =?us-ascii?Q?t+XeGRy2GV5caMcrmUPT7OnIPEzYe3j4CDWCueIxZL2GW3t68f/Zd9o4hDnf?=
 =?us-ascii?Q?XshGOAZ+wp3EhxGHf6Yu8tJED8YxyYCa7fJF2D00q2gdCzEx6t1AOs12DIGl?=
 =?us-ascii?Q?q7D0PdNZWqyJTJ0ElZf96utTPEil6hQSUwzvZ4uiDCPK5991cez+j0kvXcq4?=
 =?us-ascii?Q?kWQNdEogFIX4T2PA/oPZzFvJ0QCVUPySsL1jUWF529bKTI0pElG1kJT/RcXP?=
 =?us-ascii?Q?j6zfgvie+r2Mc95o7mDiqZXmVwi2q0V5xheLDwlSh3v06V/Nj4rO/rnD9rDI?=
 =?us-ascii?Q?gkx0qB7Va0vGWvq4f0yh+dhzKx46+xq8pVzv6PQmZ8EDBCTCsTOWR5YzEUac?=
 =?us-ascii?Q?8gQVAgmJF+kg3g5xlMSgrAgKTfXak2ihS2WEVOm18c1H0jO1FDIV4SjfVzuz?=
 =?us-ascii?Q?qNt4+i4mfRJ2IFiC8fxotzPYmupkFAWcdV1zm/SR6Pm+F9wFaJlrY0HzY341?=
 =?us-ascii?Q?0a6ibCL5B8mvzY5aEhSvzydIlTh1W2C/fBlxSrlVGmmKiH6Z0QnER1G/TK6K?=
 =?us-ascii?Q?Qhr0/U4yrsOuU5Y1BCa9PXvJraknQg2rO6IDtwTCrYd/O95vcRCVH1K9/aWD?=
 =?us-ascii?Q?2z0TcZU1tlNTA3oYHtpAPnBf5LTcIJy5FerDuRKdNqqmMXc6EnQ0RtqzM/dZ?=
 =?us-ascii?Q?jXWkVmIJ78lJ0xt6y5J+vm4UdrG45SWmM7mUD6YpkSy3K1+TErCLeJejGMNW?=
 =?us-ascii?Q?EXC1dTP86r6m7UbOBUVlgqQlMIsmN5iXEjQrMCzkFzVai1Pf2qNE6xjTCjCT?=
 =?us-ascii?Q?GnSK1sD7eM0c0CZIj8cen+zn2oj6GTPHgugv5IGVunZG3EzmGqZNtcJnbI3+?=
 =?us-ascii?Q?S54kALuWxqrBLgO60TS2GXSZqvNHzfRbZMHwmL2LcfcMk8dCunStNh5WN1D5?=
 =?us-ascii?Q?vQWTJcVoMWwoNjs/HW5XNjPLK9lhKQHOHjEz/mMF8MyZ4xzBaNi+1p5fXF1v?=
 =?us-ascii?Q?wCVscauccGgyK/V9fQ5KGi5VUZDwThRoEkg0qmzAhyk4RDSp9hMYm+QLhGwZ?=
 =?us-ascii?Q?kiPd5Y7zQxIserFSBqn5DRmTdlvIcNf8u9d3WsUowQtpRCnxt4H3tNGd0zLL?=
 =?us-ascii?Q?rRTG4xQK60jlGf5LInfzLiQm4Zqgk+eb9H/zCD6WjwmoYlJMJAf1LlTEwZ5D?=
 =?us-ascii?Q?nxjI/cyXArisZDHmYKN5e2GyXL/Qs0Q+ptX8uPblohW0VX6u4l7Glqg2cN8H?=
 =?us-ascii?Q?JSS9JjQkk6jYLLkq8HXwFtVJBCL3T8lySiNEa1zWsyUlQekfCQHA1yT/Y4pa?=
 =?us-ascii?Q?ZQv9ovdi8zuo3a1fjZzkIsnLTizgzD7OFxTWAdM8gbiH9jLWZfqV7eBVjqLP?=
 =?us-ascii?Q?eIauJQQPgc0R+zwcJjYSMOMaCUKLqKBA0jDo4TAIZ9QPeXpnFL/GCV1iRHbM?=
 =?us-ascii?Q?ZtuN86WyFfl7tAqgS+/99x9owo727zgBiOSdze2zQ+ovjiVncK77fmvfww/R?=
 =?us-ascii?Q?DyfAbpLZ2ONI6nuR/N2F2+h/DwrCVFR+Ys95?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:46.2683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eeb563-4981-46da-b1ca-08dde2e9eb97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003

From: Alexei Lazar <alazar@nvidia.com>

Xon/Xoff sizes are derived from calculation that include the MTU size.
Set Xon/Xoff when MTU is set.
If Xon/Xoff fails, set the previous MTU.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/en/port_buffer.h         | 12 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index f4a19ffbb641..39efa4d98cc3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -66,11 +66,23 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_NETWORK_BUFFER];
 };
 
+#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
+#else
+static inline int
+mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
+				u32 change, unsigned int mtu,
+				struct ieee_pfc *pfc,
+				u32 *buffer_size,
+				u8 *prio2buffer)
+{
+	return 0;
+}
+#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..15eded36b872 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -49,6 +49,7 @@
 #include "en.h"
 #include "en/dim.h"
 #include "en/txrx.h"
+#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -3040,9 +3041,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu;
+	u16 mtu, prev_mtu;
 	int err;
 
+	mlx5e_query_mtu(mdev, params, &prev_mtu);
+
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -3052,6 +3055,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
+	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
+		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
+						      NULL, NULL, NULL);
+		if (err) {
+			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
+				    __func__, mtu, err, prev_mtu);
+
+			mlx5e_set_mtu(mdev, params, prev_mtu);
+			return err;
+		}
+	}
+
 	params->sw_mtu = mtu;
 	return 0;
 }
-- 
2.34.1


