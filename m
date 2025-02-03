Return-Path: <netdev+bounces-162280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D99A265CF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334E71886385
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0899211710;
	Mon,  3 Feb 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FVS3QwiA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E15211269
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618650; cv=fail; b=pofuISTRe/neo/n5U4Mx/BrQOxXjMbo98d5NTWXXgEMzzvWKCObnxIJHsm9uWWnQLxI4HUXpTnm/f2iweKtzU2/Jd8VTSgWJUIrwGacdD7CiFVYaUzX8TieYCUJ81rZwo7vM/dXJCdcKREo/ORD7UoL86pioh7xV+ownz72h7/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618650; c=relaxed/simple;
	bh=CBK7WvkprXSxmCUx5UXYpvFpGjRo3RYqd2hdzShwFGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNlCpr9vcA5Km4uCsXHuKOFCrApH2wq/mPJ3bK9eUn56rKb1LS0dzsVOfuA7h3jabswcpoLtfa0qtjxFtdgJs51o+dj5zmPNwgwt+z1cVmdSaAPWkfDL8CZscWFsaFTcSaVnp95npgdHBdZvEpDWoHeoUuvrvTKFyyKpdEN2luE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FVS3QwiA; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMYOPfDf/LYHaTHL8Vsr4dqePGR77l/8qdSjIQ2LSPuaRQROvQzg7n+PRoS59a+ZV+I6S1bsAk1O8IYxeyVOKQL8Dj1ZMqYOHGcHcMo4dwX4Bftsn5Qi3iECXVxbJVjsYLovLglpqL2aKA8OuaBdUmwbWaybQkX9SycDs6bMHFxx7pCEHC2NgF2F9NtoUjCmVHE+6fuMzaaOd5xLRCXCYPoQYrxrb55UEnXcFRlyjhZREvjlDjH5C+KeWLCAdRWotk5u1ODCk+NRAmRAJ4RX6RPQqPd90y0dtxEZ3VzYB0O3ejmznEUAFhYXd6tbzonEqYXjbIJ4CHZ9aE4XkAnaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyGgaCCtuLILyxyk0xTS/tvWz6WKmVFoE3c/mVJkrTI=;
 b=SpXpepXRrVTI500MORGQBOPWA8SoNSF/8XXGUFLJ83mBdUtJSdqwYjmT41nSD69AJjw3ebM+03SdLAC7n1YnPEPBQawyhbx3E9NQ6jRXX5FvqkJqjqS2HuBtYGVp/dVV1mQ/kp5amQB+sJs6g+FiW0OFe6adJrDWNEkobqVLgXMWh4y/uW+yyClHnJ4L9WwL7aoVpoycU8OD6jirqjku/XjnSt8IAqnlGuS2bjoCJBPxj8H4C3/Y/KcPU+lGuWJb6SqjuJPQArtlAt2zv0TijhCMmsnrdHiI+KtiyWMPrm0zCCPvIqLY1ex7HfCwIVZnzKWNCY7atC/5QA0j88ITww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyGgaCCtuLILyxyk0xTS/tvWz6WKmVFoE3c/mVJkrTI=;
 b=FVS3QwiAR0Nk0Ue15soSp9hvqJDNbxKfH0STgrrlDKkD0XNQkjpsdP0YQmhXaJMlD59OBdfFCYFc/B2RXTWhcReDu7/b06LHLFLqz1RBrxqZTpDIVDG9LNJUuS4w7pESALd/dKJ8bUoH8TrptMkrx6dmFwhQOM7HOI+veKVZJQPKLpYx4EhgisZ1YLDVq1wkXXtsrjymx/f4J1++MhXNp1n7AxXKS6yMdMH0TGxwaXQ4nggsYCu6k6PwKcLLKqB3J9vUhC/OD8+oZyYKxDcxsvj2cNT7yIffIexCeZlJNb0WJ98QxMsaFYVSIVMiyGEwKZ95uwSnTVGIdcZYp4roHQ==
Received: from MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 21:37:24 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::5a) by MW4PR03CA0322.outlook.office365.com
 (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Mon,
 3 Feb 2025 21:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:37:09 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:37:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:37:05 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Yael Chemla
	<ychemla@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 15/15] net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload enabled
Date: Mon, 3 Feb 2025 23:35:16 +0200
Message-ID: <20250203213516.227902-16-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b3113c-cb30-4d47-869a-08dd449af299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1bddiwG9R9COXJfESnpgYW9DxZ7US8DDTwjSqTK7mO0vkFJKNaT8hElnWH+n?=
 =?us-ascii?Q?EvlL/HLMlpti13UZ+mtHWA7tSUzb62Cyoqrw/BSyMYwwKWJkv8UjV1Pzvi7z?=
 =?us-ascii?Q?F9kyRdXbzzA/2oVeVJfBqcdJvU81jzL/iwGRlt2S1VPwoOpzp0uYfhsH3KZp?=
 =?us-ascii?Q?pyEipVEcQ5y2ynIDBhYydCuHXCLXYcJz3bFc2GpTZz7P/6SBTKbaGD2ugOu1?=
 =?us-ascii?Q?Ft0ufZrL1KQl+Ok9uPtRXlZV3wbCWqH7M1pa5g/ATwpSLsasATi/xp8d+cGj?=
 =?us-ascii?Q?bXkHPkYdtXe/lpHEAzC6DKclzPYjh9kk8uovc4yENLudSYUDmY4X2d7UgRHS?=
 =?us-ascii?Q?1OdLle+FEw9qK3b/dhqcHYkPzP2Mip+1MmNEZ5jqGTIoAPYzJ87bLAeZcfWg?=
 =?us-ascii?Q?r2dFEkFh3Jpt+X9J7o4nBETaRcwkE0U72aBPE7Z6so9ORK9/SU3zqUFxdr5+?=
 =?us-ascii?Q?p8lKipMVnRiNlqDrbua6zT6IVqVtpW7MAYfssoVyaUpuf3DsVkaghOVPezwE?=
 =?us-ascii?Q?jN3EJ8HG4zjDA3tT9FRVyjuMJdCpsvtyw6DZZeM+YX5+iz6pTh6UWav4xmF2?=
 =?us-ascii?Q?Z2dgDerrBVcf0ktvbHOXXxCpfbiLfKHv1UDSE62SVOuB2j3SlCN/qKScNck9?=
 =?us-ascii?Q?QfDm0A120vtQwoKKSdDQMACJ9EykMpNPyYeeGH3wMlxh9c280w+rMPywyZZA?=
 =?us-ascii?Q?lMM9/LnVtDN2TEPQMHLcs2ld2/pMTorxFS2XHZXu+4IPfILMisMR7Gu2AeFc?=
 =?us-ascii?Q?b1ZDTCghrQyErtS5FIUUSN+O6jzFVtr5zp4+mhKqMT/jxxGqo4E92MrTmplq?=
 =?us-ascii?Q?Op5mGmrpcLjpGwrcULY8hEn/hM1qDcCGb51A+dRkev7yuYL5zu4+5dw/zThP?=
 =?us-ascii?Q?FX3lG6TsKM0d3yfmEkrDGza6J80zP6JEc7sTZlkwBGhEloo2x7Wh3aOI6P8b?=
 =?us-ascii?Q?KD0SUJUN4UMlvFZ7TYob3vSLhxceEv0eyrMqpHgv9hel9tn+wXe59XmhTyGd?=
 =?us-ascii?Q?2SgA8YQ4i0czKTIJrwQpv+K7x2O5dZB7vsBcQ37b9wRj7bZKO/BYUfd1GT7w?=
 =?us-ascii?Q?+f98QXrPBFDXNkqgxKynA8jEHH9QVptHA36qs9AyiiazbEhnd260SdzrYJcH?=
 =?us-ascii?Q?GRAUhODnONzzbvz1M/0ctwiF4KWk9aVNmDAppHU8BXH0GeR1LKYn1IyUHYne?=
 =?us-ascii?Q?40XK8hKqqpH/eJ1tJ3rPog+EzHKUrWgIJeEkVZzaJ7+pkjFJl3+5T8PzyYb8?=
 =?us-ascii?Q?n0sAkYXsWqcsmOMBA+yvmjANHjvMXAfu6VuMZnRp73uqjFm1qcIrO+onP2Ql?=
 =?us-ascii?Q?9k8Xnp4cXI9hY3pd8k4rMqptrYW0T+TVuulVPtemDmsAfmdbbodMWP1XrYMd?=
 =?us-ascii?Q?MXSGogNpE3WTeWquduP2CDBV2HDnY2jCBAc65QUUyiXJRzbiJRQcOJK5CrcF?=
 =?us-ascii?Q?Ov767uwKCIm1MaXRpPBMOV7reF1svT1EBzA955i7nEl8/Ke3p7H+eoC2xNZu?=
 =?us-ascii?Q?dGkSEnn9rxg5mL4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:24.1965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b3113c-cb30-4d47-869a-08dd449af299
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

From: Carolina Jubran <cjubran@nvidia.com>

When attempting to enable MQPRIO while HTB offload is already
configured, the driver currently returns `-EINVAL` and triggers a
`WARN_ON`, leading to an unnecessary call trace.

Update the code to handle this case more gracefully by returning
`-EOPNOTSUPP` instead, while also providing a helpful user message.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c754e0c75934..2fdc86432ac0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3816,8 +3816,11 @@ static int mlx5e_setup_tc_mqprio(struct mlx5e_priv *priv,
 	/* MQPRIO is another toplevel qdisc that can't be attached
 	 * simultaneously with the offloaded HTB.
 	 */
-	if (WARN_ON(mlx5e_selq_is_htb_enabled(&priv->selq)))
-		return -EINVAL;
+	if (mlx5e_selq_is_htb_enabled(&priv->selq)) {
+		NL_SET_ERR_MSG_MOD(mqprio->extack,
+				   "MQPRIO cannot be configured when HTB offload is enabled.");
+		return -EOPNOTSUPP;
+	}
 
 	switch (mqprio->mode) {
 	case TC_MQPRIO_MODE_DCB:
-- 
2.45.0


