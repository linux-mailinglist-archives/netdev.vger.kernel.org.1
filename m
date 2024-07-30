Return-Path: <netdev+bounces-113987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598E940833
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211091F22F3A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC218FC85;
	Tue, 30 Jul 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJxNdSbO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739716C877
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320323; cv=fail; b=euzv9foV2gz+nWwsos//olnfefa6YDMcQUqygtt1C0IWtzQTmYMp9/cjzFjh551n5dUDk5tgulJrlY1PEcnApJWFoMkhdAqKpQQkSJtJWZz8QfhMSvRP0bR3ZdCHMluVGWOyhDpRyblbcH0ozbEeE8kYFQddIDdpDpnRR1W+lBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320323; c=relaxed/simple;
	bh=yBQ+jatbMFvQyJUnIdx0Nl1Z/6DKxxdEuS42rHN0q6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwyL2xfMpYrRNsLekgRJhBZF2QW5XKZ/z3wJ6zpYFVn3rIRNCZ7pIKmHr+Zf6FPD9RXg+QXh5Gd6xoUwOWvEr1YlDX6wmxsCagMNIvoq90kDp7gKv2LYPA7qz92X5n+h1hRFg1g+WcblSZq0/GddfEhWoInVcWM1uRVAy1eppsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJxNdSbO; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pk/JeP0/AciN+RlZV6RKtNHW2+j6VWOQKBHi94FsCd5EiAGd1gFRYoxVkbDzuRjIxJjNSTIRr6xOnPY2FNLrkgyid/4Rcr/O07g8PCVMrqOp5V6U98N1p+YJ0Vgi1raCiCGOFUHJNdhk7W7nHlCK6KPoGrEv++/VwSKlpBcY6Bl+9c68OjD81XmXQVjCw4eB3WWt97GIyuG+fXWPbWiEPCnafhnsyyZLlwdw3vg+ENCXGKJtCjaFteffBD2fAeZ13gHtADBWPJUvJb8alOcIBXqszSPA1ZrEbaihiTo3v9I6yA2YGhkUWZayWTlPUrKI6DZ9mCFQCYYDZfQToodY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs6z//QCYHIh/OKn7UseLP1GSyNcqhnqpBEbMDqiAYQ=;
 b=Nq5U5/Ra+/eP8GfVJFqzz6uvgWYPO7jwNT3Ut/v8aozllkiNvhw7dqnx64JtSlM3xsnQBoByBTgQT3dbkQ1JF3TTgd4nsxYfRpasvulAYtw5C5+EvEuIWNl/NDBxTDV7SDDJUdQyk9UDDbwZ7tVHMGy+kBFFa525Npwi/l2g/aLKm34zdX+E/rbdOv1Rn2T6Xl8LXJ4aZtBBTTQ/A7vMwsCaT26At6UPhZjlMWaZcqoLMfiRVCz+x/C096hEUqS+hGGYpfeptq7h7N18Aa0HfgSsf4ol4yerPEids6xiRZ57oCzCyNjXpa2K+RuOWez3fO1egs4mY3EdkzN9P5ygyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs6z//QCYHIh/OKn7UseLP1GSyNcqhnqpBEbMDqiAYQ=;
 b=RJxNdSbON1brXx9zgY4Pa9tyULp9QqeNv05KP/0hP2DD80GwwBFbP+id/u/DxRQoK2Esn3/7vOB8FuYh6CpiY7hPyGPCE0+so7WadjPRvgR2jbMQ5ZANN7NseUoG5xIyasFcMNW5fyxKwwqzgM8+jwbmVVEDwPa/FA/q9gSRMUW3qMsbKtMl1ereeiBv6415iQx1/rFPPteKwbelpMZiCEQ9riOhQzZsr2B6vJzFJf21HL8G/Pc9s7yCDXoVNckGfesLEPyhxEdH+h5m8oOm2Be5Kqb96CzZpmzelrtin6ViWlkqLKN+tqBADBs6ooODRHbiKrjmGZ4evoRnw+YFPA==
Received: from CH0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::22)
 by SA3PR12MB7831.namprd12.prod.outlook.com (2603:10b6:806:311::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 06:18:38 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::e) by CH0P221CA0022.outlook.office365.com
 (2603:10b6:610:11c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Tue, 30 Jul 2024 06:18:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/8] net/mlx5: Lag, don't use the hardcoded value of the first port
Date: Tue, 30 Jul 2024 09:16:33 +0300
Message-ID: <20240730061638.1831002-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|SA3PR12MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: f961437a-082c-4fc3-adcb-08dcb05f7352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mz2bI/ydM2j3K+xZ4eEq69iL0UuZ2bwFYM5WR29XbvadgK+PpBKixAkrMAPE?=
 =?us-ascii?Q?N5pPZbBJzpElrjkwHczMTqeeaXzQUphoI7AH8kwmRC50UKRdn+0BiIl06+No?=
 =?us-ascii?Q?RP7iJTqATs+aMmsp4Yza5I7d5gpa3wpaGdFLrThbzN45lvPR/dt6fm46UQAZ?=
 =?us-ascii?Q?/uqb2EbsTG6Or6t5bGWb0Ul/iEhpaW+OalTeSQU2+2QYdk3YysYCWCjKXGn3?=
 =?us-ascii?Q?hfVM1CrYl9G5kEg8Tt1oJHkZqKWaXQ7dXbW6KI2Xv6qw2QYqxizazfMHJrHT?=
 =?us-ascii?Q?J+sZvuLwQyZF5ZgcQ7cXAxxBm6FPTeDZr8m5VctRjASbX72J20RzXuKJOXAW?=
 =?us-ascii?Q?Ze4dtjlOygxO7ZGkmHamR+7CArqM3wOKNnkYWWL58umgbLst3OxD49tWo3ya?=
 =?us-ascii?Q?cKTLyXwVil1co2K5LpfL1EfttWjLKLypjwF6lB4JkVO+JQICNjEWUfFbUBfF?=
 =?us-ascii?Q?6cHJW7/92gfe6kTDwuISfJbgQm0YACr06bl3ebzwjMA3g99dFQFj+4xS5nXV?=
 =?us-ascii?Q?q3wKkIMSNP+7YvhVNXwPONRnvkl+ZNnmp3XWRoD62/JN/H0MHTmvc5YNbXvz?=
 =?us-ascii?Q?jzhZ21TlFifvMXyvCf9FF8BAzjHPmz01f9cQA9h9zYGq9CtigV4bZuI64g0R?=
 =?us-ascii?Q?c7aNn0ZU83Cf/8GyB8ujBMi1Gg8oGgQ9QC/FAGYQQT6+HxlnXZgiZMGgYOss?=
 =?us-ascii?Q?plspUB7UkhVa35p/+lTSUhqZoABDw10A19kki4V+URT7d9YxGuq6XgVh9bBj?=
 =?us-ascii?Q?urudtHLNDDsK/L+mINcFAabN6dQYHaMZ+CwIg/59mmdUPTgWZnJ6elxtB9hT?=
 =?us-ascii?Q?0CDaAxuQ+EJSSjhjid65+WdE+q6NKLSV+JGQ+a4/CimYrYLe+KxK+lcl4jvh?=
 =?us-ascii?Q?GmS7gSxyI1+l91u9ckQ0XDrm/3R5a1O3vxKyy/CJLvbERgq12Onw4dVITHe0?=
 =?us-ascii?Q?xqdxTrAo3vNZZhGduhGm7Zt88uMzADWfuBFisMozhbQBZRS+mkPAQkE9Geim?=
 =?us-ascii?Q?zkZDZYBdVPmpqdsdnOElLvro4uahc/pwYsMv/9bw3UP1c9BmmNPwgdRZe8yI?=
 =?us-ascii?Q?QQ8jdtEooTw4c4pXFranCdvelIGmVC+I9wHrRsXd80hhHXoKxSn3iNhnPqB7?=
 =?us-ascii?Q?eaXjUOO6S9qYQTxuBgriN+0YooBeMpyuoQhbQv/9lW/H+nlJ37ejjQoK9o4R?=
 =?us-ascii?Q?dJoph94Xw9nH2SF2/nEcruPqvmHGq1BMwGFeJn8n6XLrnHg3belRA/8kwD2g?=
 =?us-ascii?Q?OJrY3I/tTGcq40ZDPhDQ+8Ua5Va6JK/n21Ici5u2CoAbA7SbveTAEow2glvo?=
 =?us-ascii?Q?bJZMKkgP2S4IDXjYZVY23RI+GO0NVQXfmeFd6nh8Ep9phb13rlUamja3lQ8c?=
 =?us-ascii?Q?NJanyhnhmCK8crcUMLuiItdYH2dVxWRO1/1W7qNfWlMh1HJlOltRfdzntJWv?=
 =?us-ascii?Q?LrEccV1q4t/lHQVHmykGSIhFGbRoAcnG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:38.1385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f961437a-082c-4fc3-adcb-08dcb05f7352
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7831

From: Mark Bloch <mbloch@nvidia.com>

The cited commit didn't change the body of the loop as it should.
It shouldn't be using MLX5_LAG_P1.

Fixes: 7e978e7714d6 ("net/mlx5: Lag, use actual number of lag ports")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index d0871c46b8c5..cf8045b92689 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1538,7 +1538,7 @@ u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 		goto unlock;
 
 	for (i = 0; i < ldev->ports; i++) {
-		if (ldev->pf[MLX5_LAG_P1].netdev == slave) {
+		if (ldev->pf[i].netdev == slave) {
 			port = i;
 			break;
 		}
-- 
2.44.0


