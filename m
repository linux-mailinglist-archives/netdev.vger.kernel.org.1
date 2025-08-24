Return-Path: <netdev+bounces-216285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC06B32E4B
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A43024E1D29
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E72737E6;
	Sun, 24 Aug 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ODbjKeGC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA2272E63;
	Sun, 24 Aug 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024857; cv=fail; b=ZlBzIiO+rcnE5d5AotokFFUxRFP/xBzxPxs7YJAs+4oMXLErH52cA1OQFwNlCtKQkkNiCVq4vWH86jUrI7SqgRkKaul8+i0H2jlFMWoR+6LXlL6r5gY0X5kSWSfasyGAdbEqmFx34IpSlkhdrYc7N9XE5t9+KJUcZyDOkZncvPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024857; c=relaxed/simple;
	bh=hpXuB2zCWw8HttZYXKW8PsAFvshtiDl8kMaAxti6F9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBJQ+fsUr71qsNSbnrusl5coRHJWnnIKLkDXpwZWh669zYogRh8R/dLe8X9AfmRWpg83zTRUry0tDyP06NELalowpduwXPAEGJfkBUSPHUFUePsrwliDlDNjSf9jHF537tcUCrPaYlw5YnSZJLx/l0nsffCwD+K4pnzTqX4Nmj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ODbjKeGC; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvP+mVOzB2BNag0PTQWWLc1XHSdO0IJWS64zYavMvr7GS3715El72hjPVn9zIGSHx0JEKk+lCuuTlN5oss4siFE1oOYffCcDJ4BhwLPXqGIpryqlwqjbxKpfGY2cdHU9BYrqyduPGWtc/BBXomxzOGXxVNftvIGl2RoCJA5fXfP2wO3l+AHWaGkDf1JtY3xHoHCR7d46YaJcSxGZHfi8Bp5jdeuh2VzRfYNuznvTCAqU6jOkeusAJwiRIBJLRRLqh2rNGCZQpBPuDMjA5hrY0cGVYnSQHW6CHgXDaaPuzfi5fNDr8cZkfm50MsHjllRElgqFA0wRSXVJOW2pTTS8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Ygon9cyjuRofu1I6zDqgjsG4kbY/Vw1C/vzgLi/tE=;
 b=Q+1jJEJ+JRTyu6P0dAeUrqZ9zM2ED7u50bl6L3wFfi0DwIhHG9pEXThUShb2l4Um5P9A2eEIMalgmjsSGhmUfXGMR7uyRRVzbDfJfE8aSgpuJcheW9XZfoV53DYPPik7eAq47a5Hg3G1bRQqt0A+IzyH+jkRFeDHL1UTKWzTZw9pgrSstrsrZ4G2BuFPNJmfmZ7m9K4bCqN/RmfiqJYg6k952IGxgKOSevYz6nqjAcxzYnEuWFxOFi2TXJMsuNweBhRPC+njnK//eVFGkdbNJrHlEHJ5C+tS7oPFnaINs8vTnXWjiovSuir+HHQ7iUZKJi4D3gshkeFivQiCraQHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Ygon9cyjuRofu1I6zDqgjsG4kbY/Vw1C/vzgLi/tE=;
 b=ODbjKeGCEMDOPjIWYlVgAPQN18EK7TjTaSonrbEVkfp30V7Q6rea9p1zJN1K2SnCEJGgoG0bisdiKP4ewhwppx6Htlme770tcBIt0SfvQuO8jBdBPIgyytcOPCjbNkW1tld3Ig8xprSdwNSTXnY/HpBHaJQDJKMtUjCxgfLRPe7D3BtFHYPtRMl0moOf80s6OgtgXeYFduTzz8U93mMs+MuUHAfRkx3MqqsbVRVs+qA3r6hucD5vihpOq+5ibmdb+hpq5RP0EsCxaskNyiv8uV6fBLjDIDeXByDRpQP9sxGki/ecnPOwr0Phe07tceUfmYDk9yJGfFsFbVkGvF72UQ==
Received: from CH2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:610:54::35)
 by SN7PR12MB7107.namprd12.prod.outlook.com (2603:10b6:806:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Sun, 24 Aug
 2025 08:40:51 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::d4) by CH2PR11CA0025.outlook.office365.com
 (2603:10b6:610:54::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 24 Aug 2025 08:40:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:37 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:40:33 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 10/11] net/mlx5e: Update and set Xon/Xoff upon port speed set
Date: Sun, 24 Aug 2025 11:39:43 +0300
Message-ID: <20250824083944.523858-11-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|SN7PR12MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f352d7b-73eb-45f5-550c-08dde2e9ee55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2CZyi7f1NE5ghoV5rhKiXwmpdgQk4yWY0fFiA3H22WsavLfb+fUOIiie69Q?=
 =?us-ascii?Q?aS+5jL5T4vPalAy6HdeYfuKt7WkL/M2FNyQKIHHlw9UbssM44lR+jofJ2JVO?=
 =?us-ascii?Q?Oq2OCkV27M8trbJhl/hce2WW+nR4MJjEDwh/U42GdHtydEyq+KUV78dxvexA?=
 =?us-ascii?Q?KQDXzwQACT6Dm7VHug0qGRCxP24JPWnSCEUHuOgExUBgxlmbonhGQ84xPWfZ?=
 =?us-ascii?Q?8OILxMpIrZwZHShZ2qSyEmN3L9oiTt45rFgoDqvlYAiWdM0mGMJtPbDwHl1w?=
 =?us-ascii?Q?l8V0yT4uOQSwm0DhvHUucd8sCpPj1Yz02ZlPwEjemqFdgUHE7GQiaZvBtJhc?=
 =?us-ascii?Q?2sPkxwxxETmzZilaiKB/MZAanz8xAd7jm4eUHWmOWCEn0vIurJC1g3zvK8wN?=
 =?us-ascii?Q?WanW6czorwuX3v6jTWSzNUghwRUzWr/VuXaoJfefbsjK3prbRa29bxcrr5xt?=
 =?us-ascii?Q?es3dKyx6brXRN1Suv34PvMT5MYcx+l1IzkwEQrdUQpKuKhICLn35G9+vr4JA?=
 =?us-ascii?Q?GzhuEP08KkffzU/fJO2BUJIERUeW2Gcbu/HYEhrFww3ISln1Hf45NKz71kEd?=
 =?us-ascii?Q?eL3kBkafUQ0oAKBZdyVUGJL+zjzNlSEARxsenHxS66sLWZZ0Qb4QaP6Vp8We?=
 =?us-ascii?Q?9BIgbq8mDtk/qGAVrGPCXRIv2pFnPjJTl3c+Y6K2x5AoNeUIbSyCMLU//WdM?=
 =?us-ascii?Q?pS9Ff+Qec2H9VlbYSKv3E5bXD1GnfPMwZTd+gxfLxA1RDndHT1pFuq/MSa73?=
 =?us-ascii?Q?YFm6zn6JVxAe9WjSYvGfbWTIU3Vfz/d7fxB/FyNFlvn+tObJuh3T2/SjFW/B?=
 =?us-ascii?Q?PPZTpRgEk14fnrIrbtbzAuwXk8KeIJ1tf6kLVkxd6BgegRxqLDXdGKZ0wRha?=
 =?us-ascii?Q?8v/3u0b135EqJ8ZDqez6tpmv5pize55eUY3Yqlj8lvSIh1xCE6UhZv4YprSW?=
 =?us-ascii?Q?aQFtToV0zgrN80+uF5vfskBzSRbutiitbL4htku4dGDl1M9elw9xiDmHgWKi?=
 =?us-ascii?Q?pLt4zuCajg1vZMs/SL4Jgprnvedbtv4xu6qgStwOZ8en1a2GgO1mBooUGyDJ?=
 =?us-ascii?Q?dXF+GO7ml6cE+1xBJr3WEoHcAcy8S/v7/+jXRw+bQKqAgxZih4U9jLsBwjGl?=
 =?us-ascii?Q?J1hAExCq3yr/jsjJf8OXZ30WXKeK3Tc6w9Z7afCBxvrtyXBJYNbhLxSWEiwC?=
 =?us-ascii?Q?5z2ci6NI8VnREg2BpPobZfKURSOQ43o1I1/4gd8u5GHaHFfGYQCF25n+zn86?=
 =?us-ascii?Q?kdDpfo8VGiijOJcK69yyjWjMDXr8qZdbO6uHzv5e/EOV3SK8CvaUQTTjf98f?=
 =?us-ascii?Q?gm1/R+SoI0uicXi+5l+pUD2RHyLgSsG4XjmDCa8b9ZQ0+G0Zpr8h6PQ942/Y?=
 =?us-ascii?Q?el2Shc/2ISZAFHPsM6YS09AQZc66f4j+n8vKMuwb7JU6Slo0vNUFcByi+LNA?=
 =?us-ascii?Q?D8gUignfDx9H8E7aQl/xwe6OSiQsW/Oyr3baZx3VJSVSDbSKVfbzwBE2SyxQ?=
 =?us-ascii?Q?C7VT0Fq7XF8LVZD3zLX4UIpigXmVLpZxnF/P?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:50.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f352d7b-73eb-45f5-550c-08dde2e9ee55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7107

From: Alexei Lazar <alazar@nvidia.com>

Xon/Xoff sizes are derived from calculations that include
the port speed.
These settings need to be updated and applied whenever the
port speed is changed.
The port speed is typically set after the physical link goes down
and is negotiated as part of the link-up process between the two
connected interfaces.
Xon/Xoff parameters being updated at the point where the new
negotiated speed is established.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 15eded36b872..e680673ffb72 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -139,6 +139,8 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (up) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
+		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
+						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);
-- 
2.34.1


