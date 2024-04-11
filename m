Return-Path: <netdev+bounces-86988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B788A13A8
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27C01F22F94
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233B14AD1E;
	Thu, 11 Apr 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jne4OtAo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9914A619
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836560; cv=fail; b=sgxNChtVPNBPWIPrJWefE8kYjKHYiCLwPTenMehLU4iONhtLowMULq476NQ/BEj8yixmj1G5DXgSYf/CAnxATNup7+RNZDZ+jNfirOY8zsxv58JWzQ6gTS0qeuGsGkagPqka27DCnuI4khniCKyFlQrmHeAl10I1UZrZNiFOtfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836560; c=relaxed/simple;
	bh=yj+6fMhN90c6FWcDMY0rBSQWSHiD8kGIApRdqpDomgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0RqcieaIwvziKHyApAejIym3bMJsmA4XMx7zXGUzNwf3/ueKcjVqRYKQpeZu8qWFQoUnkgyZPG1JEklCPpNlz9/B4mT8teaImlBae4WtCb0MW4qU8kekaRTVBgVrO9lLoK+9o1DQ7JRBxFG7rvf5Yr1jCWo1fSZd7zpqbz96tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jne4OtAo; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrwWR6TbVwQb/8H/rUcJKMsDHKUKUpCEaSpP4pI9geYqm7X2hsGa3WlqF7y1JVISoZYYugNOj4pKbbQvboGJq0+Smr6rN8K7o0h7jEGVq2TRm93eRbyvvOfdNtvqO/WrU+v+aQR5OYm+P9TFctaY30r8yQkH2ResuayYUF+ZufOAuvWXyUwv+pE/i+Oc0hj0kExM3DhCgHMVa142IOyXYOS8mAnYknrmxaRQa7Vv87BVsLtQ9yS3DFraDl5MdEJMHNNXJzIYQk86rd/Ir6IJSg/jMyaC46wX9GZ/AAPlM+msbL03H6XSkatzm0vlaOy4M+VMkDV5L8WjsNyeY/aubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYaxo/x9AHyK6g0MzcMM3bwhEbMb9176L665+qgI2JE=;
 b=YDmsg/q9pTftNGVQiNrHzYlxYKlRHOxmVNc0U+rQ+KfZnxcAkPylxmXYHrq5fuPGmUFLgkYdHL19V8Dh0XtdNhjmkSva1ZpzHYeYLoRC395+lqDb9n0UMU97lpBxjSAnWYDXGpXsoVs/pmJuRS2WaL6o2Plieg6XunbrJL/v0n599dyvxNV1528/lByZDK4Cok/SmofWM/JSmZ3AmJ7g5NuqYjSfjviTDoJdaSoA0xi8AjfE+dqWfRH4GnT2nQPs7jB6IsAnNyLzzfbEnGg0TeOD7Z7aSWKDTYGIhR4vut7NhjEzDjcJX3CECenomqhnpd1M/x+ksZE2GZFKdBKTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYaxo/x9AHyK6g0MzcMM3bwhEbMb9176L665+qgI2JE=;
 b=jne4OtAoy/z80oc+bwEbtu56oqBg093L4ex+kJioyrJhkRyUBJS2cjTrRXLKgcGsxd0DQSt8RKtqwE2IOI7w6KJU2XyRokESeM4KA3c9gj3xzdv2UbUNSTaFUUteYWGYPwkgrZeZIW5LBw0w793a4jadpZDoPUhhjziaHQTfucDiwVyDJ+dTFtifHWE4Z4i3YSiI8ikFC00D1TuBIM0KDoy6WGTj0MBg1GquuAgWQ779UTRMqezZB2rynQGbaPxvJRcsUVjx6c6XBlxmFIj003I1zIzQnIIFIgHL3bU2aYh6G+UUiChaBbuo+XLJLjfODMu9+j2rOMpE94WL4/VRIw==
Received: from CH2PR05CA0043.namprd05.prod.outlook.com (2603:10b6:610:38::20)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:55:55 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::1f) by CH2PR05CA0043.outlook.office365.com
 (2603:10b6:610:38::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.11 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 5/6] net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation
Date: Thu, 11 Apr 2024 14:54:43 +0300
Message-ID: <20240411115444.374475-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411115444.374475-1-tariqt@nvidia.com>
References: <20240411115444.374475-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: b30f02cf-1d0e-41e4-22c4-08dc5a1e5785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6jss9nX4QYyKEXaWB5icWtwC73mzkxlzPxSahFiQk+gkg0FyLIEbwX/yD3gCxw1wYlzzqUKdXqyBzEEJZEoe/2ZzPQ2fFZWhHiOMBs7IxkNcjlt6ptVL1in8fiPhWmEq06y6aSncgEhQYCoVVByj5Q3QvY0NjZcnHNZq1Wcbb9BBk9AW3JPEaLW/gh4NJu+dhA0UrqWBkyUc9QtayrTRLJKKZJQ507pkhiXxe3TNIqIab1lTARQTS35sszWAjuB7uBzD/4nLDcl1mLEzYgF0KatXhpCXXcVuV2GfsZZNocJuv25RMHcBbSI1H1xHx6a5/hjQwLcv8D4pP3UDWkAdifyxK3OXeTCDQ6I/pNiHpfJXz2CLvKywp6RKnBj0spForqvPqfreILblnkiDhpXyEpn65VIo2K7YZ5jZnK9HCxtbudQ/PO5OrwNV+VSRUPe0yFyUXqMqE1M6d4spnFvTNK6nk+lispmQrCnyg9uSIh0Ff6RW24NrbjnKThXy70pCes0CVZrn9aBz3Pde43XLddTSi+r+EnxlRXbujGCGzDGiGpD4PP5wQka4oilxleIY7BJK/W0xVX3CQPJtfbcUvJpV4VQyPGArwXgEiSz30No19xOLHz7+mF7DHx1fHJTVYLJINr+/wkJgozTjQarJagL8HeIBjplSSpUiPr4ev4FpyBvsm1Zw3DdW+YnSC9WzRTweaWzUF4fDyVU08Krqxksfmgb8fXva35jSZvHkSXitnK+SJQKEl2JcvfV9+Obq
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:54.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30f02cf-1d0e-41e4-22c4-08dc5a1e5785
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537

From: Carolina Jubran <cjubran@nvidia.com>

netif_queue_set_napi asserts whether RTNL lock is held if
the netdev is initialized.

Acquire the RTNL lock before activating or deactivating
RQs/SQs if the lock has not been held before in the flow.

Fixes: f25e7b82635f ("net/mlx5e: link NAPI instances to queues and IRQs")
Cc: Joe Damato <jdamato@fastly.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 0ab9db319530..22918b2ef7f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -108,7 +108,10 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	mlx5e_reset_txqsq_cc_pc(sq);
 	sq->stats->recover++;
 	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
+	rtnl_lock();
 	mlx5e_activate_txqsq(sq);
+	rtnl_unlock();
+
 	if (sq->channel)
 		mlx5e_trigger_napi_icosq(sq->channel);
 	else
@@ -179,12 +182,16 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 	carrier_ok = netif_carrier_ok(netdev);
 	netif_carrier_off(netdev);
 
+	rtnl_lock();
 	mlx5e_deactivate_priv_channels(priv);
+	rtnl_unlock();
 
 	mlx5e_ptp_close(chs->ptp);
 	err = mlx5e_ptp_open(priv, &chs->params, chs->c[0]->lag_port, &chs->ptp);
 
+	rtnl_lock();
 	mlx5e_activate_priv_channels(priv);
+	rtnl_unlock();
 
 	/* return carrier back if needed */
 	if (carrier_ok)
-- 
2.44.0


