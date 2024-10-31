Return-Path: <netdev+bounces-140715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A929B7B37
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD192841A8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5B19CD1D;
	Thu, 31 Oct 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xtyf88Oi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1819D880
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379609; cv=fail; b=RjzSR3+68j7Pr57ompzCSVuP1gvyzf9/RWsfHFxd1gMacZfXWazmygsk1tpcCgigEoTkeY6T2bEhTqvDthan9bdopCiQxPz4hWDG0+Sk4R9dsdsMHPEq3hBurnvLVJQ+7uXsrFyC0tJOf1KPZJISyBSosXldOE9jGqECqeSnM3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379609; c=relaxed/simple;
	bh=26WVM11myY7lZDAuS/N4HQwJb1SdRXG9GukuvEFGXvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi5sjp7+2w5+BtX7k84DrGZRxw+dMopFO/0ZNp5FXInuVk2oUKHowlEKSXu8MYAacGPBwcKSb1Orm2mvGN7DF7AbFpKoNTafCM3K/q1HGSgVJPvt/4k6MCoxJ2ti7Uq9c5JIXIJsCfYQ0EUdMseP3kfZQ+XCsfw3Uh5aiBZOQSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xtyf88Oi; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4FEQVj+E13Fz2gQRe+SGpwRg1AXG/0gtUNdv6nItD7cwAuEOmCPsviPV9P2R/CiNm70WBmwx0c/KzAJ2rIRH9lj35vGKtUZE0/AZYGqeCxj2jSNubjub5WaVsUsmy+8iJUAXA/LoHxXvp7Q1tM3PLQDdpf9ve9yfjUNoU8BU5gkhsyUtpbXZeiGy56hORhWGELGXeGT9xbPZTHDLeg2i53Nuv0ZSYZ9SisTBKwGO2Y0Ot6J9FVdYVneOkjEkBPLA5LyYMdY2Mw9F9sRNdMyMsc02FLXoKIXbI3zzvvN5pnufMtJ9pV7vBaa02sYEVOulNvmrP/LdbGHhaqJGiXXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiFD9+HOXhZJg5Tws5gIommJoR9FJsrLrtek+VEiwVQ=;
 b=VjB+X67m9JhYcIW3ikYsfrndXYg2QEPXKOiEP2rk47q7hqOIXvsIxZ9mUGd9oYJVWabdQsHhJZdeG+B5bLgzraFivAm1FOhopqosGiEKRrPTiE3ZkpCjdsEAzhLsyOQpoRxKV+lBhjv7tqhhEFESZFM1XkxOfVJZbHp3Uq8g8OTIrG0vM2qwqZNSoF4yrZ4dGVMKRxN+csVL+9orhhhKNlTTPSJaz/BJ3xPE1iY+viJ8DSmvUnqeBrzPpaK30RYnW64mtr6H0OwX+bYsP10B8rLDNWQrA8YKQCUyLsqc8jveBIfJnMvgyhsJRrcN7OF+AtnISAlhmcj3rD4ZfoYn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiFD9+HOXhZJg5Tws5gIommJoR9FJsrLrtek+VEiwVQ=;
 b=Xtyf88OiTFmCWThVyIwHNKrTUShcZaUgbGaDDNBhtiS6CybzsGlp6SN8FbpGDrGMXmdZ0nq8nDOeElKBWgm82EZsqWRjTqdUMf/2ehgp/k0S4jH5XgjJRnny/DPGLiAclFVR5ajcKedR3aP/oAwhwJd57YdQwzSSHBjHHTMADYhORpJg+smwffS2syR3AY49BF9VI4Qa7G5UJFAWs/UrjePiT8DLWWvyTSc3gMMPJ85jzZc1e+RKFgtEJ/xrdxwpCtUwH2qgUg5qn7OLN8XNSFSh09vFIsPTKZjyhnsE0Wx/ysFXRR3JXTTKH/m2/mWoJeWXfoiwcnZtcMrdjy6zHA==
Received: from CH2PR07CA0061.namprd07.prod.outlook.com (2603:10b6:610:5b::35)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 12:59:59 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::4) by CH2PR07CA0061.outlook.office365.com
 (2603:10b6:610:5b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 12:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 12:59:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:43 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5: HWS, renamed the files in accordance with naming convention
Date: Thu, 31 Oct 2024 14:58:54 +0200
Message-ID: <20241031125856.530927-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241031125856.530927-1-tariqt@nvidia.com>
References: <20241031125856.530927-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e970211-748a-46b4-2b46-08dcf9abeced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BY+4lcciR3+NFSdFgaoCrxsWFTJD0yArQzn7qmawcJZcxXorc/Xu+cYekjTF?=
 =?us-ascii?Q?lol4swnz15+sEILIL8jmJfHn57O1ukZ5YAor1zf6iPV2K1mAGBCuoNamSKYT?=
 =?us-ascii?Q?lLLUrFI393hmMCti5eOpjbUdusIeufgF7enI9uUX4QBYeMKBZ/WB9mTJdu+8?=
 =?us-ascii?Q?Al1aDR6P009caYtCZqOOC0QVs2T5xATjt0BPk6HbKIxJNhHI3AM2OdsJ0WyG?=
 =?us-ascii?Q?PfYt9aUb47gRk/+tYRDEow+81cjtdDAcqxjl9qS+a1KoAVOZYjKmmTeZ0Yh2?=
 =?us-ascii?Q?p/FhQdmtceDB5hLYAbT4EwyMsDNROdwrU5/I0SXkaACIBC6ulX/Mgfl/6I3B?=
 =?us-ascii?Q?fU5opTqEs+EXilyt4CD0MQpZ9Yi57TqXYx5ja+RttqfMkiiS5Kd1+1B8n9BI?=
 =?us-ascii?Q?fq/BlGnSoT3ZINlV8ggBuUXn8rsQCZyCLjzv0Av7Nn69+t4qKQFM92HZgHxF?=
 =?us-ascii?Q?jNoWxb03ktTg3ivmnpANKq0vsSeLfDhx4BZgvpUr+SdJsrqQydR2vlizHPJR?=
 =?us-ascii?Q?hTwLaVgDO0nD3tDDvk734UusUo5abWaSNLc7GWiL1n8d7ZUkAvJy/4ZlLgEL?=
 =?us-ascii?Q?y6I9lW1SK89wRHyGTUCiGq9R46QoV7KjFAAenHEFqgMZ62mMrS3egn5WrW2p?=
 =?us-ascii?Q?DS8dtgkmrveOYfNAlRr3ZPSvtMl7MOeXfPOoAgm8WiBfyldDf+3r4zzkRU4U?=
 =?us-ascii?Q?+fRoiU1KN1i2ckTrgTMtLyS/jfzuHGRT3hrenH+DKPTNk1H25P23IxuJ9EZg?=
 =?us-ascii?Q?6CdDZWW+AJvXi8SBPZ/ImtWsdRkSe9U5g/PwGji9kYFdvpTCyQblUdAmbqxD?=
 =?us-ascii?Q?N49mz33lQORQCXNgOkQB5ucX052r9zPSbOLqxA+8zV/Be62X50kW2F3TmAKb?=
 =?us-ascii?Q?1zy2T1bGA8SSl8OMSQkxQ8/CuiiFwjeOG7n9ihaoQbsNGUjQR/5RTS4xMiPS?=
 =?us-ascii?Q?eq7+fG4YlGmVQOTe49hxhgQYwpyVeZq6TUZXq3nAOkAFsjmP1ZNFsQ+vyPuS?=
 =?us-ascii?Q?SXPtIRPbOeOubUi0ASIRkT1Md7OGWBeqBXDlPbGQ/RRC3rx5v2jaicZah9gB?=
 =?us-ascii?Q?/WBaGtL2fVsiuB8GvZr/zI8SmJ894QZKzSzO1aHJV84mA9ha/e+/1q28lY/A?=
 =?us-ascii?Q?d4yT1UcGkfBiWZUxpdp2J2LbfhetbXNlH5GD9MOU/tnuruHzGdBMS3ts24Gd?=
 =?us-ascii?Q?CGF3npuR2BiGDtzeAWfJVji2uiOCI32w5A4kbZ7pq1l1DmZAMP0Q9puMUxyo?=
 =?us-ascii?Q?pVA76swkQpo94493cD0NEjpSIr2NfBFOvIJyPDJCHWAT+LChLrlwxGMfd0U5?=
 =?us-ascii?Q?VdiChQYQobizGkIpYVZouYIdk7WY6LomkNZXIfZ3TVSGV6HLKUqX5V6PZLuN?=
 =?us-ascii?Q?e8myAfCMKJTRF0mG000sOMCjIjOJLI6xb6ZJ2PcNbr5M2JrYMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:59:58.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e970211-748a-46b4-2b46-08dcf9abeced
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Removed the 'mlx5hws_' file name prefix from the internal HWS files.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  | 30 ++++++++--------
 .../hws/{mlx5hws_action.c => action.c}        |  2 +-
 .../hws/{mlx5hws_action.h => action.h}        |  6 ++--
 .../steering/hws/{mlx5hws_buddy.c => buddy.c} |  4 +--
 .../steering/hws/{mlx5hws_buddy.h => buddy.h} |  6 ++--
 .../steering/hws/{mlx5hws_bwc.c => bwc.c}     |  2 +-
 .../steering/hws/{mlx5hws_bwc.h => bwc.h}     |  6 ++--
 .../{mlx5hws_bwc_complex.c => bwc_complex.c}  |  2 +-
 .../{mlx5hws_bwc_complex.h => bwc_complex.h}  |  6 ++--
 .../steering/hws/{mlx5hws_cmd.c => cmd.c}     |  2 +-
 .../steering/hws/{mlx5hws_cmd.h => cmd.h}     |  6 ++--
 .../hws/{mlx5hws_context.c => context.c}      |  2 +-
 .../hws/{mlx5hws_context.h => context.h}      |  6 ++--
 .../steering/hws/{mlx5hws_debug.c => debug.c} |  2 +-
 .../steering/hws/{mlx5hws_debug.h => debug.h} |  6 ++--
 .../hws/{mlx5hws_definer.c => definer.c}      |  2 +-
 .../hws/{mlx5hws_definer.h => definer.h}      |  6 ++--
 .../hws/{mlx5hws_internal.h => internal.h}    | 36 +++++++++----------
 .../hws/{mlx5hws_matcher.c => matcher.c}      |  2 +-
 .../hws/{mlx5hws_matcher.h => matcher.h}      |  6 ++--
 .../hws/{mlx5hws_pat_arg.c => pat_arg.c}      |  2 +-
 .../hws/{mlx5hws_pat_arg.h => pat_arg.h}      |  0
 .../steering/hws/{mlx5hws_pool.c => pool.c}   |  4 +--
 .../steering/hws/{mlx5hws_pool.h => pool.h}   |  0
 .../steering/hws/{mlx5hws_prm.h => prm.h}     |  0
 .../steering/hws/{mlx5hws_rule.c => rule.c}   |  2 +-
 .../steering/hws/{mlx5hws_rule.h => rule.h}   |  0
 .../steering/hws/{mlx5hws_send.c => send.c}   |  2 +-
 .../steering/hws/{mlx5hws_send.h => send.h}   |  0
 .../steering/hws/{mlx5hws_table.c => table.c} |  2 +-
 .../steering/hws/{mlx5hws_table.h => table.h} |  0
 .../steering/hws/{mlx5hws_vport.c => vport.c} |  2 +-
 .../steering/hws/{mlx5hws_vport.h => vport.h} |  0
 33 files changed, 77 insertions(+), 77 deletions(-)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.c => action.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.h => action.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.c => buddy.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.h => buddy.h} (86%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.c => bwc.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.h => bwc.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.c => bwc_complex.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.h => bwc_complex.h} (90%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.c => cmd.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.h => cmd.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.c => context.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.h => context.h} (95%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.c => debug.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.h => debug.h} (93%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.c => definer.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.h => definer.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_internal.h => internal.h} (67%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.c => matcher.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.h => matcher.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.c => pat_arg.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.h => pat_arg.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.c => pool.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.h => pool.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_prm.h => prm.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.c => rule.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.h => rule.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.c => send.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.h => send.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.c => table.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.h => table.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.c => vport.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.h => vport.h} (100%)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 42411fe772ab..be3d0876c521 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -136,21 +136,21 @@ mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/sws/dr_domain.o \
 #
 # HW Steering
 #
-mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/mlx5hws_cmd.o \
-					steering/hws/mlx5hws_context.o \
-					steering/hws/mlx5hws_pat_arg.o \
-					steering/hws/mlx5hws_buddy.o \
-					steering/hws/mlx5hws_pool.o \
-					steering/hws/mlx5hws_table.o \
-					steering/hws/mlx5hws_action.o \
-					steering/hws/mlx5hws_rule.o \
-					steering/hws/mlx5hws_matcher.o \
-					steering/hws/mlx5hws_send.o \
-					steering/hws/mlx5hws_definer.o \
-					steering/hws/mlx5hws_bwc.o \
-					steering/hws/mlx5hws_debug.o \
-					steering/hws/mlx5hws_vport.o \
-					steering/hws/mlx5hws_bwc_complex.o
+mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/cmd.o \
+					steering/hws/context.o \
+					steering/hws/pat_arg.o \
+					steering/hws/buddy.o \
+					steering/hws/pool.o \
+					steering/hws/table.o \
+					steering/hws/action.o \
+					steering/hws/rule.o \
+					steering/hws/matcher.o \
+					steering/hws/send.o \
+					steering/hws/definer.o \
+					steering/hws/bwc.o \
+					steering/hws/debug.o \
+					steering/hws/vport.o \
+					steering/hws/bwc_complex.o
 
 
 #
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index b27bb4106532..a897cdc60fdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 #define MLX5HWS_ACTION_METER_INIT_COLOR_OFFSET 1
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index bf5c1b241006..e8f562c31826 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_ACTION_H_
-#define MLX5HWS_ACTION_H_
+#ifndef HWS_ACTION_H_
+#define HWS_ACTION_H_
 
 /* Max number of STEs needed for a rule (including match) */
 #define MLX5HWS_ACTION_MAX_STE 20
@@ -304,4 +304,4 @@ mlx5hws_action_apply_setter(struct mlx5hws_actions_apply_data *apply,
 		htonl(num_of_actions << 29);
 }
 
-#endif /* MLX5HWS_ACTION_H_ */
+#endif /* HWS_ACTION_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.c
similarity index 98%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.c
index e6ed66202a40..b9aef80ba094 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
-#include "mlx5hws_buddy.h"
+#include "internal.h"
+#include "buddy.h"
 
 static int hws_buddy_init(struct mlx5hws_buddy_mem *buddy, u32 max_order)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.h
similarity index 86%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.h
index 338c44bbedaf..ef6b223677aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_buddy.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/buddy.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_BUDDY_H_
-#define MLX5HWS_BUDDY_H_
+#ifndef HWS_BUDDY_H_
+#define HWS_BUDDY_H_
 
 struct mlx5hws_buddy_mem {
 	unsigned long **bitmap;
@@ -18,4 +18,4 @@ int mlx5hws_buddy_alloc_mem(struct mlx5hws_buddy_mem *buddy, u32 order);
 
 void mlx5hws_buddy_free_mem(struct mlx5hws_buddy_mem *buddy, u32 seg, u32 order);
 
-#endif /* MLX5HWS_BUDDY_H_ */
+#endif /* HWS_BUDDY_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 8f3a6f9d703d..baacf662c0ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 static u16 hws_bwc_gen_queue_idx(struct mlx5hws_context *ctx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
similarity index 96%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 4fe8c32d8fbe..0b745968e21e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_BWC_H_
-#define MLX5HWS_BWC_H_
+#ifndef HWS_BWC_H_
+#define HWS_BWC_H_
 
 #define MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG 1
 #define MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP 1
@@ -70,4 +70,4 @@ static inline u16 mlx5hws_bwc_get_queue_id(struct mlx5hws_context *ctx, u16 idx)
 	return idx + mlx5hws_bwc_queues(ctx);
 }
 
-#endif /* MLX5HWS_BWC_H_ */
+#endif /* HWS_BWC_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
similarity index 98%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index 601fad5fc54a..c00010ca86bd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 					 u8 match_criteria_enable,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
similarity index 90%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
index 068ee8118609..340f0688e394 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_BWC_COMPLEX_H_
-#define MLX5HWS_BWC_COMPLEX_H_
+#ifndef HWS_BWC_COMPLEX_H_
+#define HWS_BWC_COMPLEX_H_
 
 bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 					 u8 match_criteria_enable,
@@ -26,4 +26,4 @@ int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
 
 int mlx5hws_bwc_rule_destroy_complex(struct mlx5hws_bwc_rule *bwc_rule);
 
-#endif /* MLX5HWS_BWC_COMPLEX_H_ */
+#endif /* HWS_BWC_COMPLEX_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 2c7b14172049..c00c138c3366 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 static enum mlx5_ifc_flow_destination_type
 hws_cmd_dest_type_to_ifc_dest_type(enum mlx5_flow_destination_type type)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
index 2fbcf4ff571a..434f62b0904e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_CMD_H_
-#define MLX5HWS_CMD_H_
+#ifndef HWS_CMD_H_
+#define HWS_CMD_H_
 
 #define WIRE_PORT 0xFFFF
 
@@ -358,4 +358,4 @@ int mlx5hws_cmd_allow_other_vhca_access(struct mlx5_core_dev *mdev,
 int mlx5hws_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_function,
 			   u16 vport_number, u16 *gvmi);
 
-#endif /* MLX5HWS_CMD_H_ */
+#endif /* HWS_CMD_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
index 00e4fdf4a558..fd48b05e91e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA CORPORATION. All rights reserved. */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 bool mlx5hws_context_cap_dynamic_reparse(struct mlx5hws_context *ctx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
similarity index 95%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index 8ab548aa402b..47f5cc8de73f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_CONTEXT_H_
-#define MLX5HWS_CONTEXT_H_
+#ifndef HWS_CONTEXT_H_
+#define HWS_CONTEXT_H_
 
 enum mlx5hws_context_flags {
 	MLX5HWS_CONTEXT_FLAG_HWS_SUPPORT = 1 << 0,
@@ -62,4 +62,4 @@ bool mlx5hws_context_cap_dynamic_reparse(struct mlx5hws_context *ctx);
 
 u8 mlx5hws_context_get_reparse_mode(struct mlx5hws_context *ctx);
 
-#endif /* MLX5HWS_CONTEXT_H_ */
+#endif /* HWS_CONTEXT_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 2b8c5a4e1c4c..5b200b4bc1a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -5,7 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/seq_file.h>
 #include <linux/version.h>
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 static int
 hws_debug_dump_matcher_template_definer(struct seq_file *f,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
similarity index 93%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
index b93a536035d9..e44e7ae28f93 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_debug.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_DEBUG_H_
-#define MLX5HWS_DEBUG_H_
+#ifndef HWS_DEBUG_H_
+#define HWS_DEBUG_H_
 
 #define HWS_DEBUG_FORMAT_VERSION "1.0"
 
@@ -37,4 +37,4 @@ mlx5hws_debug_icm_to_idx(u64 icm_addr)
 void mlx5hws_debug_init_dump(struct mlx5hws_context *ctx);
 void mlx5hws_debug_uninit_dump(struct mlx5hws_context *ctx);
 
-#endif /* MLX5HWS_DEBUG_H_ */
+#endif /* HWS_DEBUG_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 3f4c58bada37..8fe96eb76baf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 /* Pattern tunnel Layer bits. */
 #define MLX5_FLOW_LAYER_VXLAN      BIT(12)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
index 2f6a7df4021c..9432d5084def 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_DEFINER_H_
-#define MLX5HWS_DEFINER_H_
+#ifndef HWS_DEFINER_H_
+#define HWS_DEFINER_H_
 
 /* Max available selecotrs */
 #define DW_SELECTORS 9
@@ -831,4 +831,4 @@ mlx5hws_definer_conv_match_params_to_compressed_fc(struct mlx5hws_context *ctx,
 						   u32 *match_param,
 						   int *fc_sz);
 
-#endif /* MLX5HWS_DEFINER_H_ */
+#endif /* HWS_DEFINER_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
similarity index 67%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
index 5643be1cd5bf..3c8635f286ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_internal.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/internal.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_INTERNAL_H_
-#define MLX5HWS_INTERNAL_H_
+#ifndef HWS_INTERNAL_H_
+#define HWS_INTERNAL_H_
 
 #include <linux/mlx5/transobj.h>
 #include <linux/mlx5/vport.h>
@@ -10,22 +10,22 @@
 #include "wq.h"
 #include "lib/mlx5.h"
 
-#include "mlx5hws_prm.h"
+#include "prm.h"
 #include "mlx5hws.h"
-#include "mlx5hws_pool.h"
-#include "mlx5hws_vport.h"
-#include "mlx5hws_context.h"
-#include "mlx5hws_table.h"
-#include "mlx5hws_send.h"
-#include "mlx5hws_rule.h"
-#include "mlx5hws_cmd.h"
-#include "mlx5hws_action.h"
-#include "mlx5hws_definer.h"
-#include "mlx5hws_matcher.h"
-#include "mlx5hws_debug.h"
-#include "mlx5hws_pat_arg.h"
-#include "mlx5hws_bwc.h"
-#include "mlx5hws_bwc_complex.h"
+#include "pool.h"
+#include "vport.h"
+#include "context.h"
+#include "table.h"
+#include "send.h"
+#include "rule.h"
+#include "cmd.h"
+#include "action.h"
+#include "definer.h"
+#include "matcher.h"
+#include "debug.h"
+#include "pat_arg.h"
+#include "bwc.h"
+#include "bwc_complex.h"
 
 #define W_SIZE		2
 #define DW_SIZE		4
@@ -56,4 +56,4 @@ static inline unsigned long align(unsigned long val, unsigned long align)
 	return (val + align - 1) & ~(align - 1);
 }
 
-#endif /* MLX5HWS_INTERNAL_H_ */
+#endif /* HWS_INTERNAL_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 61a1155d4b4f..1bb3a6f8c3cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 enum mlx5hws_matcher_rtc_type {
 	HWS_MATCHER_RTC_TYPE_MATCH,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
similarity index 96%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 125391d1a114..81ff487f57be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#ifndef MLX5HWS_MATCHER_H_
-#define MLX5HWS_MATCHER_H_
+#ifndef HWS_MATCHER_H_
+#define HWS_MATCHER_H_
 
 /* We calculated that concatenating a collision table to the main table with
  * 3% of the main table rows will be enough resources for high insertion
@@ -104,4 +104,4 @@ static inline bool mlx5hws_matcher_is_insert_by_idx(struct mlx5hws_matcher *matc
 	return matcher->attr.insert_mode == MLX5HWS_MATCHER_INSERT_BY_INDEX;
 }
 
-#endif /* MLX5HWS_MATCHER_H_ */
+#endif /* HWS_MATCHER_H_ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index e084a5cbf81f..06db5e4726ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 enum mlx5hws_arg_chunk_size
 mlx5hws_arg_data_size_to_arg_log_size(u16 data_size)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index a8a63e3278be..fed2d913f3b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
-#include "mlx5hws_buddy.h"
+#include "internal.h"
+#include "buddy.h"
 
 static void hws_pool_free_one_resource(struct mlx5hws_pool_resource *resource)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_pool.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_prm.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_prm.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/prm.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 8a011b958b43..e20c67a04203 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 static void hws_rule_skip(struct mlx5hws_matcher *matcher,
 			  struct mlx5hws_match_template *mt,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 6d443e6ee8d9..424797b6d802 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 #include "lib/clock.h"
 
 enum { CQ_OK = 0, CQ_EMPTY = -1, CQ_POLL_ERR = -2 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
similarity index 99%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index 8c063a8d87d7..9576e02d00c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 u32 mlx5hws_table_get_id(struct mlx5hws_table *tbl)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.h
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
similarity index 98%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
index faf42421c43f..d8e382b9fa61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
 
-#include "mlx5hws_internal.h"
+#include "internal.h"
 
 int mlx5hws_vport_init_vports(struct mlx5hws_context *ctx)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.h
similarity index 100%
rename from drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_vport.h
rename to drivers/net/ethernet/mellanox/mlx5/core/steering/hws/vport.h
-- 
2.44.0


