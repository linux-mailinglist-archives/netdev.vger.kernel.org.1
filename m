Return-Path: <netdev+bounces-216293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884C9B32E75
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA24188C861
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEF525E471;
	Sun, 24 Aug 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X95bjk8I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CB25B2FD;
	Sun, 24 Aug 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025082; cv=fail; b=XqI+Tz9XAhwmQqX5sHBNGqy3j4hM0yXpFlrWNIRTFyLmCB6DU1ZRkMDtCaRHEs/YDGAjH7cUnR580bXrnexgJeYpsbO+xFc2uoloEAjW9Hfc7J8lxTa2rCLZMOq/cpmofxMYLfYYlLuy0gxDAofrcf1GC1xETIdy1B5w5ZPmKaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025082; c=relaxed/simple;
	bh=xorofwhgVEN1M2LVpCWyGOxnOUKh2RbLDxXrkQC/KnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scNoQmVJ1Qi+5KBvzehgNAL+jiB9++7WJk3VKok0t+WPzsb1CuEiQP+Tz9RC9tBrGrp3+1Nge3DWAkyDo1C8EaSqEIXL94To8DZexKzctrgwuxu7WUURgKb9nfmJGMgbpTXO2xhQ66D6qkIhb65kIgT1fSp+y3P/bb2deSkqu9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X95bjk8I; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOq8QTv1f8YVQevQBVuikYf9QUto2CKDi7I8WZV4Nw69UkYhgY8SfCth222bsmv+3Iysjoa3GvtFp4xOuWef+mZ/lNPjZ2YYWTd6Oc5uUZ7RKEY4K2cPxRZJZr7TQ627UjqaKXmpQlcU3NhyZWH9BrdX9H3jJSElgXQnpTZ2UWZ8SWajvAsAg/zYub9ydv/ucaUa9DyeWpi3oIKgLZb4MOYp+nO14Uw2/A/d8ZzxJR0kup+OcdxrxDVceknQfK9BOiKZ5tDil507eh9qdgAlaJBrYH/j9wfj5bNyueylJGkTjfHOfDu6SRH30FyCPDBzSBCTLuaVwHt85ELBqDUCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88KKm5IIVNMwk8uug+LhX1pThGunkE3f2lQ19Ky32+0=;
 b=mLol0ijAuKeAat1QIbDiN0OjQ2DMOJxaMNRplCu9KANe0t1bR/8BuE88QDzpxDnCa3iT/Xd7S8gkGJFJVHXcPH3LcwRy9m2rIFTLKMxO/A8pN22339j4F9R2zROJc/H6GDQKGPgIADZEclJEJB+DVtyCtTmJv0YylCdbJ3rtyFge0kCKcOzxw111rnni3s2kCqrn3QNR6i040StFVRckpFkkmNmi7O5PMoip6JWy0nJ6cAgvi5A4tGZLXp1sbZPfhFgcRyvyxSTJQL6fx4jh+TnVh3gauL/BCq0Nzl5VGH0Rv0gWLzClVRfg8HzMCIEjEGbd0pbDyFwMEsKKQ1nI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88KKm5IIVNMwk8uug+LhX1pThGunkE3f2lQ19Ky32+0=;
 b=X95bjk8IO59AqtXOB29uVnqawjNWVNFcklAtc2V5JW36EIajVzfNk0Goe2rXbaDmsr2GEOT6fzc5y1iP3dd+Kbb9mWM7mRLvjhGvW+ZtZMaqqc2wwc5VTJZZw24fLw2cmW7zvqSORDsBexd6yWeNWZMohj9ZL018QfvLmaEEbDXwGiEefb6Y//fFxGvRXK61Z8C7ClEyhAteUkW1sCbfquiAhblQawf2J0z2ayH11Ao4DnOj/AX3+vSoRZc0snmbCIjtwENZK/7NOGmZekFzv9PQqsuhzc9l/6wS2g/5y3uutXMJIYZNJ6EvlqK0+onCOSs9wVMBOGKzV+Y7D5U80w==
Received: from DM5PR08CA0026.namprd08.prod.outlook.com (2603:10b6:4:60::15) by
 CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.22; Sun, 24 Aug 2025 08:44:30 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::10) by DM5PR08CA0026.outlook.office365.com
 (2603:10b6:4:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sun,
 24 Aug 2025 08:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:44:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:10 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:44:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:44:03 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next V4 1/5] devlink: Move graceful period parameter to reporter ops
Date: Sun, 24 Aug 2025 11:43:50 +0300
Message-ID: <20250824084354.533182-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824084354.533182-1-mbloch@nvidia.com>
References: <20250824084354.533182-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: e62ed930-5c20-4c01-96aa-08dde2ea70dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hpGAKA9BkeH3QNBVVz5ETq/62XoskMvM1URu1XV+1jJ2Hi6XxDpvVRm+VI9?=
 =?us-ascii?Q?5IqANYj/h1uXeYuxQXA8IfGPP641u3s1EbU8qMTEnaKDcTo677miaQhhYFZ7?=
 =?us-ascii?Q?gim4rLWo3Z+6XJzxtw5dmJ4+V5Rlu7/sPIp20xyxONlNKHKMNQtwr7TsUGUn?=
 =?us-ascii?Q?0lQr4zH4k62VRGq1Q7M/CSAbcE/VBMAEBnn2NI/hL/F/vTOOJ56maz7ZYxkl?=
 =?us-ascii?Q?idaZrdvP0YD1AhES5Aeb0A166o0smM3NLIgTyZssEakCenBY+B5wCoLcGlH3?=
 =?us-ascii?Q?0UhFHrsfwLmbSY8YC6GXvN2eOHtjIeFPhCdKkIQclwCnHjKHQLvC0vIusijS?=
 =?us-ascii?Q?MeVbKSEIcAsfpwmTTQWlJLjCBiJwX2Jl1SvboxbzdOS1J2JUmrI87MPf8CZq?=
 =?us-ascii?Q?iW5SugLdrVG/4bJFrntD33AkNdlzSBpk6msmHFGMEASn0gqfkKnsJt3RxqRb?=
 =?us-ascii?Q?zSUhpMZYPqfyEDze7GZegueGbvFdidclaZSmu6td4r49qdeUjiOJovw01xIA?=
 =?us-ascii?Q?Gpsy1ZONbz5cmgpXb8wG3wZCpbe032nUmJv2YvdzmYL+JPo/GSZux4RyLiqU?=
 =?us-ascii?Q?Zy1dep6TiNIAWE6sCv6gIfF675UCdITyfJG4DhBXbvi4D2LYfvPzATlYMhpN?=
 =?us-ascii?Q?oRzFk22mABDnM34neVlTQeu5TuidoJWrGFiPv3IfWkpjsyp5Si9ExQYHRCnp?=
 =?us-ascii?Q?zKdFtad1d+bFAaz/GBCb/WlqLA7/H/GszIqQFo9JufrWwINyXgK/HUnw9VNs?=
 =?us-ascii?Q?DWNVP/FkzoWa0zxu/JlVZXnZxjAt5m1N/vdRd8iWnK5XHTbjE6KuPrZmQTwP?=
 =?us-ascii?Q?mr/fjf59n2prSxPDFsqZ+3Qr59cMzOQ3txmNPXnKYFPpd/PgyaVP4BAqbfi/?=
 =?us-ascii?Q?cE/W2beWpiUcfDW5B+aQoChInTUt0pb4PRtLE6SDF2FmNbdlOcuuKnKbhNq/?=
 =?us-ascii?Q?q1DTY2nYUamJ3zwIxpd0l1WE4BGZ12H5OmiyzWJ9MFNdPN5mEh+1v3Kuxqml?=
 =?us-ascii?Q?AtxR1VNlHhGRYnT4vZ8YL1gNdW30I7/lhatCs35v4LwZOqjx/yqa1R9F4/YU?=
 =?us-ascii?Q?271TzjRfXrVFXnDTimSGxfTd0B6kgGCQB7v6rtceex70xlYWgZ62cXgQLtKl?=
 =?us-ascii?Q?F4oMqjHYZwwztBthudbHUNeGVW8q0F0Mm7p2S7N5OoOUtNlTruSTlqfHnUVN?=
 =?us-ascii?Q?S1pi2Sg+UK0XRzUrJCJQkOLpG6XRsKQKddAoTy7LFNKwwB5QSupPnuEGCCdS?=
 =?us-ascii?Q?7TuNnlQT90MbzY3ZnpWXQnj+wjAj2tKBHfyfdPdQdZCsdba9iK3TUhyEOrNO?=
 =?us-ascii?Q?wdaXiNJzeN9nWDygneUjb7rqckr9AqTrieyAJ75tg3RGKM6NJXh2i6gY6lYJ?=
 =?us-ascii?Q?9kOYHqKrfhc5gqkIbr0I28en7cXQaxhvmwmGwe969oW5SStCFquXLQY5huzZ?=
 =?us-ascii?Q?ypcwWIKqWDeZv4zRtbfEggSiC1Xy6DxXhm6IT9anMc+Ok84oH8hxTqahk4pQ?=
 =?us-ascii?Q?xLab/X8muP+jyZxUIs8mtpj8qAGinhpWwTGd?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:44:29.8978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62ed930-5c20-4c01-96aa-08dde2ea70dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

From: Shahar Shitrit <shshitrit@nvidia.com>

Move the default graceful period from a parameter to
devlink_health_reporter_create() to a field in the
devlink_health_reporter_ops structure.

This change improves consistency, as the graceful period is inherently
tied to the reporter's behavior and recovery policy. It simplifies the
signature of devlink_health_reporter_create() and its internal helper
functions. It also centralizes the reporter configuration at the ops
structure, preparing the groundwork for a downstream patch that will
introduce a devlink health reporter burst period attribute whose
default value will similarly be provided by the driver via the ops
structure.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/amd/pds_core/main.c      |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 10 +++--
 .../net/ethernet/intel/ice/devlink/health.c   |  3 +-
 .../marvell/octeontx2/af/rvu_devlink.c        | 32 +++++++++++----
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  2 +-
 .../mellanox/mlx5/core/en/reporter_rx.c       | 10 +++--
 .../mellanox/mlx5/core/en/reporter_tx.c       | 10 +++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/health.c  | 41 +++++++++++--------
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  2 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |  9 ++--
 drivers/net/netdevsim/health.c                |  4 +-
 include/net/devlink.h                         | 11 +++--
 net/devlink/health.c                          | 28 +++++--------
 15 files changed, 97 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 9b81e1c260c2..c7a2eff57632 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -280,7 +280,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 		goto err_out_del_dev;
 	}
 
-	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, 0, pdsc);
+	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, pdsc);
 	if (IS_ERR(hr)) {
 		devl_unlock(dl);
 		dev_warn(pdsc->dev, "Failed to create fw reporter: %pe\n", hr);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 4c4581b0342e..43fb75806cd6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -220,7 +220,7 @@ __bnxt_dl_reporter_create(struct bnxt *bp,
 {
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_health_reporter_create(bp->dl, ops, 0, bp);
+	reporter = devlink_health_reporter_create(bp->dl, ops, bp);
 	if (IS_ERR(reporter)) {
 		netdev_warn(bp->dev, "Failed to create %s health reporter, rc = %ld\n",
 			    ops->name, PTR_ERR(reporter));
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 03e42512a2d5..300bc267a259 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -443,8 +443,9 @@ int hinic_health_reporters_create(struct hinic_devlink_priv *priv)
 	struct devlink *devlink = priv_to_devlink(priv);
 
 	priv->hw_fault_reporter =
-		devlink_health_reporter_create(devlink, &hinic_hw_fault_reporter_ops,
-					       0, priv);
+		devlink_health_reporter_create(devlink,
+					       &hinic_hw_fault_reporter_ops,
+					       priv);
 	if (IS_ERR(priv->hw_fault_reporter)) {
 		dev_warn(&priv->hwdev->hwif->pdev->dev, "Failed to create hw fault reporter, err: %ld\n",
 			 PTR_ERR(priv->hw_fault_reporter));
@@ -452,8 +453,9 @@ int hinic_health_reporters_create(struct hinic_devlink_priv *priv)
 	}
 
 	priv->fw_fault_reporter =
-		devlink_health_reporter_create(devlink, &hinic_fw_fault_reporter_ops,
-					       0, priv);
+		devlink_health_reporter_create(devlink,
+					       &hinic_fw_fault_reporter_ops,
+					       priv);
 	if (IS_ERR(priv->fw_fault_reporter)) {
 		dev_warn(&priv->hwdev->hwif->pdev->dev, "Failed to create fw fault reporter, err: %ld\n",
 			 PTR_ERR(priv->fw_fault_reporter));
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index ab519c0f28bf..8e9a8a8178d4 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -450,9 +450,8 @@ ice_init_devlink_rep(struct ice_pf *pf,
 {
 	struct devlink *devlink = priv_to_devlink(pf);
 	struct devlink_health_reporter *rep;
-	const u64 graceful_period = 0;
 
-	rep = devl_health_reporter_create(devlink, ops, graceful_period, pf);
+	rep = devl_health_reporter_create(devlink, ops, pf);
 	if (IS_ERR(rep)) {
 		struct device *dev = ice_pf_to_dev(pf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 27c3a2daaaa9..3735372539bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -505,7 +505,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_reporters->nix_event_ctx = nix_event_context;
 	rvu_reporters->rvu_hw_nix_intr_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_intr_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_intr_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_intr_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_intr reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_intr_reporter));
@@ -513,7 +515,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_gen_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_gen_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_gen_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_gen_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_gen reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_gen_reporter));
@@ -521,7 +525,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_err_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_err_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_err_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_err_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_err reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_err_reporter));
@@ -529,7 +535,9 @@ static int rvu_nix_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_nix_ras_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_nix_ras_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_nix_ras_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_nix_ras_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_nix_ras reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_nix_ras_reporter));
@@ -1051,7 +1059,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 
 	rvu_reporters->npa_event_ctx = npa_event_context;
 	rvu_reporters->rvu_hw_npa_intr_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_intr_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_intr_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_intr_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_intr reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_intr_reporter));
@@ -1059,7 +1069,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_gen_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_gen_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_gen_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_gen_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_gen reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_gen_reporter));
@@ -1067,7 +1079,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_err_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_err_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_err_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_err_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_err reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_err_reporter));
@@ -1075,7 +1089,9 @@ static int rvu_npa_register_reporters(struct rvu_devlink *rvu_dl)
 	}
 
 	rvu_reporters->rvu_hw_npa_ras_reporter =
-		devlink_health_reporter_create(rvu_dl->dl, &rvu_hw_npa_ras_reporter_ops, 0, rvu);
+		devlink_health_reporter_create(rvu_dl->dl,
+					       &rvu_hw_npa_ras_reporter_ops,
+					       rvu);
 	if (IS_ERR(rvu_reporters->rvu_hw_npa_ras_reporter)) {
 		dev_warn(rvu->dev, "Failed to create hw_npa_ras reporter, err=%ld\n",
 			 PTR_ERR(rvu_reporters->rvu_hw_npa_ras_reporter));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 32bb769f1829..73f5b62b8c7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -135,7 +135,7 @@ void mlx5_reporter_vnic_create(struct mlx5_core_dev *dev)
 	health->vnic_reporter =
 		devlink_health_reporter_create(devlink,
 					       &mlx5_reporter_vnic_ops,
-					       0, dev);
+					       dev);
 	if (IS_ERR(health->vnic_reporter))
 		mlx5_core_warn(dev,
 			       "Failed to create vnic reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 16c44d628eda..1b9ea72abc5a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -651,22 +651,24 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
 	mutex_unlock(&c->icosq_recovery_lock);
 }
 
+#define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
+
 static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.name = "rx",
 	.recover = mlx5e_rx_reporter_recover,
 	.diagnose = mlx5e_rx_reporter_diagnose,
 	.dump = mlx5e_rx_reporter_dump,
+	.default_graceful_period = MLX5E_REPORTER_RX_GRACEFUL_PERIOD,
 };
 
-#define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
-
 void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
 {
+	struct devlink_port *port = priv->netdev->devlink_port;
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_port_health_reporter_create(priv->netdev->devlink_port,
+	reporter = devlink_port_health_reporter_create(port,
 						       &mlx5_rx_reporter_ops,
-						       MLX5E_REPORTER_RX_GRACEFUL_PERIOD, priv);
+						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %ld\n",
 			    PTR_ERR(reporter));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 85d5cb39b107..7a4a77f6fe6a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -539,22 +539,24 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
 	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
 }
 
+#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
+
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
 		.diagnose = mlx5e_tx_reporter_diagnose,
 		.dump = mlx5e_tx_reporter_dump,
+		.default_graceful_period = MLX5_REPORTER_TX_GRACEFUL_PERIOD,
 };
 
-#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
-
 void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
 {
+	struct devlink_port *port = priv->netdev->devlink_port;
 	struct devlink_health_reporter *reporter;
 
-	reporter = devlink_port_health_reporter_create(priv->netdev->devlink_port,
+	reporter = devlink_port_health_reporter_create(port,
 						       &mlx5_tx_reporter_ops,
-						       MLX5_REPORTER_TX_GRACEFUL_PERIOD, priv);
+						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev,
 			    "Failed to create tx reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 63a7a788fb0d..b231e7855bca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1447,7 +1447,7 @@ static void mlx5e_rep_vnic_reporter_create(struct mlx5e_priv *priv,
 
 	reporter = devl_port_health_reporter_create(dl_port,
 						    &mlx5_rep_vnic_reporter_ops,
-						    0, rpriv);
+						    rpriv);
 	if (IS_ERR(reporter)) {
 		mlx5_core_err(priv->mdev,
 			      "Failed to create representor vnic reporter, err = %ld\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index cf7a1edd0530..b63c5a221eb9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -669,54 +669,61 @@ static void mlx5_fw_fatal_reporter_err_work(struct work_struct *work)
 	}
 }
 
+#define MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD 180000
+#define MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD 60000
+#define MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD 30000
+#define MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD \
+	MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD
+
+static
+const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ecpf_ops = {
+		.name = "fw_fatal",
+		.recover = mlx5_fw_fatal_reporter_recover,
+		.dump = mlx5_fw_fatal_reporter_dump,
+		.default_graceful_period =
+			MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD,
+};
+
 static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_pf_ops = {
 		.name = "fw_fatal",
 		.recover = mlx5_fw_fatal_reporter_recover,
 		.dump = mlx5_fw_fatal_reporter_dump,
+		.default_graceful_period = MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD,
 };
 
 static const struct devlink_health_reporter_ops mlx5_fw_fatal_reporter_ops = {
 		.name = "fw_fatal",
 		.recover = mlx5_fw_fatal_reporter_recover,
+		.default_graceful_period =
+			MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD,
 };
 
-#define MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD 180000
-#define MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD 60000
-#define MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD 30000
-#define MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD MLX5_FW_REPORTER_VF_GRACEFUL_PERIOD
-
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 {
 	const struct devlink_health_reporter_ops *fw_fatal_ops;
 	struct mlx5_core_health *health = &dev->priv.health;
 	const struct devlink_health_reporter_ops *fw_ops;
 	struct devlink *devlink = priv_to_devlink(dev);
-	u64 grace_period;
 
-	fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
 	fw_ops = &mlx5_fw_reporter_pf_ops;
 	if (mlx5_core_is_ecpf(dev)) {
-		grace_period = MLX5_FW_REPORTER_ECPF_GRACEFUL_PERIOD;
+		fw_fatal_ops = &mlx5_fw_fatal_reporter_ecpf_ops;
 	} else if (mlx5_core_is_pf(dev)) {
-		grace_period = MLX5_FW_REPORTER_PF_GRACEFUL_PERIOD;
+		fw_fatal_ops = &mlx5_fw_fatal_reporter_pf_ops;
 	} else {
 		/* VF or SF */
-		grace_period = MLX5_FW_REPORTER_DEFAULT_GRACEFUL_PERIOD;
 		fw_fatal_ops = &mlx5_fw_fatal_reporter_ops;
 		fw_ops = &mlx5_fw_reporter_ops;
 	}
 
-	health->fw_reporter =
-		devl_health_reporter_create(devlink, fw_ops, 0, dev);
+	health->fw_reporter = devl_health_reporter_create(devlink, fw_ops, dev);
 	if (IS_ERR(health->fw_reporter))
 		mlx5_core_warn(dev, "Failed to create fw reporter, err = %ld\n",
 			       PTR_ERR(health->fw_reporter));
 
-	health->fw_fatal_reporter =
-		devl_health_reporter_create(devlink,
-					    fw_fatal_ops,
-					    grace_period,
-					    dev);
+	health->fw_fatal_reporter = devl_health_reporter_create(devlink,
+								fw_fatal_ops,
+								dev);
 	if (IS_ERR(health->fw_fatal_reporter))
 		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %ld\n",
 			       PTR_ERR(health->fw_fatal_reporter));
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 2bb2b77351bd..980f3223f124 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -2043,7 +2043,7 @@ static int mlxsw_core_health_init(struct mlxsw_core *mlxsw_core)
 		return 0;
 
 	fw_fatal = devl_health_reporter_create(devlink, &mlxsw_core_health_fw_fatal_ops,
-					       0, mlxsw_core);
+					       mlxsw_core);
 	if (IS_ERR(fw_fatal)) {
 		dev_err(mlxsw_core->bus_info->dev, "Failed to create fw fatal reporter");
 		return PTR_ERR(fw_fatal);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index 1adc7fbb3f2f..94c5689b5abd 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -87,20 +87,21 @@ qed_fw_fatal_reporter_recover(struct devlink_health_reporter *reporter,
 	return 0;
 }
 
+#define QED_REPORTER_FW_GRACEFUL_PERIOD 0
+
 static const struct devlink_health_reporter_ops qed_fw_fatal_reporter_ops = {
 		.name = "fw_fatal",
 		.recover = qed_fw_fatal_reporter_recover,
 		.dump = qed_fw_fatal_reporter_dump,
+		.default_graceful_period = QED_REPORTER_FW_GRACEFUL_PERIOD,
 };
 
-#define QED_REPORTER_FW_GRACEFUL_PERIOD 0
-
 void qed_fw_reporters_create(struct devlink *devlink)
 {
 	struct qed_devlink *dl = devlink_priv(devlink);
 
-	dl->fw_reporter = devlink_health_reporter_create(devlink, &qed_fw_fatal_reporter_ops,
-							 QED_REPORTER_FW_GRACEFUL_PERIOD, dl);
+	dl->fw_reporter = devlink_health_reporter_create(devlink,
+		&qed_fw_fatal_reporter_ops, dl);
 	if (IS_ERR(dl->fw_reporter)) {
 		DP_NOTICE(dl->cdev, "Failed to create fw reporter, err = %ld\n",
 			  PTR_ERR(dl->fw_reporter));
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 688f05316b5e..3bd0e7a489c3 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -183,14 +183,14 @@ int nsim_dev_health_init(struct nsim_dev *nsim_dev, struct devlink *devlink)
 	health->empty_reporter =
 		devl_health_reporter_create(devlink,
 					    &nsim_dev_empty_reporter_ops,
-					    0, health);
+					    health);
 	if (IS_ERR(health->empty_reporter))
 		return PTR_ERR(health->empty_reporter);
 
 	health->dummy_reporter =
 		devl_health_reporter_create(devlink,
 					    &nsim_dev_dummy_reporter_ops,
-					    0, health);
+					    health);
 	if (IS_ERR(health->dummy_reporter)) {
 		err = PTR_ERR(health->dummy_reporter);
 		goto err_empty_reporter_destroy;
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 3119d053bc4d..c7ad7a981b39 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -746,6 +746,8 @@ enum devlink_health_reporter_state {
  *        if priv_ctx is NULL, run a full dump
  * @diagnose: callback to diagnose the current status
  * @test: callback to trigger a test event
+ * @default_graceful_period: default min time (in msec)
+ *	between recovery attempts
  */
 
 struct devlink_health_reporter_ops {
@@ -760,6 +762,7 @@ struct devlink_health_reporter_ops {
 			struct netlink_ext_ack *extack);
 	int (*test)(struct devlink_health_reporter *reporter,
 		    struct netlink_ext_ack *extack);
+	u64 default_graceful_period;
 };
 
 /**
@@ -1928,22 +1931,22 @@ void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 struct devlink_health_reporter *
 devl_port_health_reporter_create(struct devlink_port *port,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv);
+				 void *priv);
 
 struct devlink_health_reporter *
 devlink_port_health_reporter_create(struct devlink_port *port,
 				    const struct devlink_health_reporter_ops *ops,
-				    u64 graceful_period, void *priv);
+				    void *priv);
 
 struct devlink_health_reporter *
 devl_health_reporter_create(struct devlink *devlink,
 			    const struct devlink_health_reporter_ops *ops,
-			    u64 graceful_period, void *priv);
+			    void *priv);
 
 struct devlink_health_reporter *
 devlink_health_reporter_create(struct devlink *devlink,
 			       const struct devlink_health_reporter_ops *ops,
-			       u64 graceful_period, void *priv);
+			       void *priv);
 
 void
 devl_health_reporter_destroy(struct devlink_health_reporter *reporter);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index b3ce8ecbb7fb..ba144b7426fa 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -108,11 +108,11 @@ devlink_port_health_reporter_find_by_name(struct devlink_port *devlink_port,
 static struct devlink_health_reporter *
 __devlink_health_reporter_create(struct devlink *devlink,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv)
+				 void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
-	if (WARN_ON(graceful_period && !ops->recover))
+	if (WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
@@ -122,7 +122,7 @@ __devlink_health_reporter_create(struct devlink *devlink,
 	reporter->priv = priv;
 	reporter->ops = ops;
 	reporter->devlink = devlink;
-	reporter->graceful_period = graceful_period;
+	reporter->graceful_period = ops->default_graceful_period;
 	reporter->auto_recover = !!ops->recover;
 	reporter->auto_dump = !!ops->dump;
 	return reporter;
@@ -134,13 +134,12 @@ __devlink_health_reporter_create(struct devlink *devlink,
  *
  * @port: devlink_port to which health reports will relate
  * @ops: devlink health reporter ops
- * @graceful_period: min time (in msec) between recovery attempts
  * @priv: driver priv pointer
  */
 struct devlink_health_reporter *
 devl_port_health_reporter_create(struct devlink_port *port,
 				 const struct devlink_health_reporter_ops *ops,
-				 u64 graceful_period, void *priv)
+				 void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
@@ -150,8 +149,7 @@ devl_port_health_reporter_create(struct devlink_port *port,
 						   ops->name))
 		return ERR_PTR(-EEXIST);
 
-	reporter = __devlink_health_reporter_create(port->devlink, ops,
-						    graceful_period, priv);
+	reporter = __devlink_health_reporter_create(port->devlink, ops, priv);
 	if (IS_ERR(reporter))
 		return reporter;
 
@@ -164,14 +162,13 @@ EXPORT_SYMBOL_GPL(devl_port_health_reporter_create);
 struct devlink_health_reporter *
 devlink_port_health_reporter_create(struct devlink_port *port,
 				    const struct devlink_health_reporter_ops *ops,
-				    u64 graceful_period, void *priv)
+				    void *priv)
 {
 	struct devlink_health_reporter *reporter;
 	struct devlink *devlink = port->devlink;
 
 	devl_lock(devlink);
-	reporter = devl_port_health_reporter_create(port, ops,
-						    graceful_period, priv);
+	reporter = devl_port_health_reporter_create(port, ops, priv);
 	devl_unlock(devlink);
 	return reporter;
 }
@@ -182,13 +179,12 @@ EXPORT_SYMBOL_GPL(devlink_port_health_reporter_create);
  *
  * @devlink: devlink instance which the health reports will relate
  * @ops: devlink health reporter ops
- * @graceful_period: min time (in msec) between recovery attempts
  * @priv: driver priv pointer
  */
 struct devlink_health_reporter *
 devl_health_reporter_create(struct devlink *devlink,
 			    const struct devlink_health_reporter_ops *ops,
-			    u64 graceful_period, void *priv)
+			    void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
@@ -197,8 +193,7 @@ devl_health_reporter_create(struct devlink *devlink,
 	if (devlink_health_reporter_find_by_name(devlink, ops->name))
 		return ERR_PTR(-EEXIST);
 
-	reporter = __devlink_health_reporter_create(devlink, ops,
-						    graceful_period, priv);
+	reporter = __devlink_health_reporter_create(devlink, ops, priv);
 	if (IS_ERR(reporter))
 		return reporter;
 
@@ -210,13 +205,12 @@ EXPORT_SYMBOL_GPL(devl_health_reporter_create);
 struct devlink_health_reporter *
 devlink_health_reporter_create(struct devlink *devlink,
 			       const struct devlink_health_reporter_ops *ops,
-			       u64 graceful_period, void *priv)
+			       void *priv)
 {
 	struct devlink_health_reporter *reporter;
 
 	devl_lock(devlink);
-	reporter = devl_health_reporter_create(devlink, ops,
-					       graceful_period, priv);
+	reporter = devl_health_reporter_create(devlink, ops, priv);
 	devl_unlock(devlink);
 	return reporter;
 }
-- 
2.34.1


