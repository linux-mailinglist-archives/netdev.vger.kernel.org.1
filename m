Return-Path: <netdev+bounces-156771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF6DA07CF0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B2B3A7BFD
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD72206AC;
	Thu,  9 Jan 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTB0w4aZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3867221DBD
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438885; cv=fail; b=KGSzH5q6thH/LVLj9HHgAYo+b+tYOs0B5ewQsyFNyBdq+XN6GI7J5cXJeJEGyYskfnRQ6y2dCx6FO8x95xFprtkhbQFvbF15dFIByd+c7ia/bmF6agxkpd62Xg3pC0F15n7BxdvH6fx09hPs+TTXS1Cvgejlq2IbEcKsEgnQN5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438885; c=relaxed/simple;
	bh=4m2hPGq03vduWzQmpCyHABrkAyTpspRm5yAZD6+3tUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUUB5MrX+2BX4cxWWZ6CVCfySm5XK74UsnZzuOLkslEUl8OyWylqbS/qq8jip7nwMPLYVcjyu0kZzG3jkBcUrFRe49eNqSqKHp9zhsZuVNONuLC+2as2ADH7kxZjFfJN22QkiPyOMYjxhLY94dToIQ6AktWjUFQ/aiJ3WR8uPgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTB0w4aZ; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb+hzEE5X8dzq/HEEbvM6N+9agCgSjkVjtAVidEduGoP91mj/P1VDjy5hGNtA3TpJZyXKdPjKty/tLbytvv4nw5lMCDRbsb1ub6qoM977SRYJ/6kQuZuTC5HgKk4d4ggndoJaH3wtM62YcMRWG9LRk/flU33zhIqdatuUQh+KAi+z32M20k8p//GHXC0CTWxCrLIHdA2SSv6GYLQp/VTKHPtcZiGP84hqFK3bLMoxJ5GHUtYV2CK9zNaCTjmJ1jn2MfGLM//PbKFwB2aZyjOUFhyA4lRL2GmaA5LUHpgHLwWudLuHbz0oSy9DnBbeexkeVb81XjnIVDrllkm/ct5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZHBoa+ezQW8Rnp+v6R8oMq79ZSji0z+L4U/EjAln6M=;
 b=A0gn/iUe6PTtX4+0e7qy9bX/89NK+79mdY0npKV2DNdKoKMhLsG/jqdyOrX8FfOFIwDPDpnUIJH1pwZjqWtkra2WhfM6DNPXqnbZXVT2T9uD+dgLldLeg1DBA5YALBiqvr5LKVreVutRU5OLXD7R4Brw4QEtgcJouveLYYX+DFLL2MCh66tK0orzKHsgA29zo8fu5QM6BgzP1UqhB4LxpB9MEQsELbQkXRDQGeOQFAuc3IJTeDPF+nc9leSUzHoOqdq8vdiZDR/xOpfVSMD9SNkIvsLrn9kyH0ehbFw69GSOUwjKf0gl7eazRVobRYJjEWS+X3P4+mk7VWcKKprG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZHBoa+ezQW8Rnp+v6R8oMq79ZSji0z+L4U/EjAln6M=;
 b=HTB0w4aZ0qNLivnxB+2zm6bPBKm+znqt2SxYKA73w2akOJ7mwhrQMpl84CinA+p0zInB9TwgpQN3PZvEisMo9uX2P6junGsR3I9a+Fo0CM9yaivl/xXQZboGPG/qHZN6MhrAlZszIAVOn8UUL/NBZt8h8uidXrErBv49SJijDl5qPk7jiHhHEL7c1JMB64TFu46nG/a0jdGNPIxZctWT2vN1Po1IF6JNsE4OT30d9W436FXZNKpRrKvijESWhxjgZ8pyPC/MLZzylYkl+q+5kNwzxcSHY6FXegwUABXiDh7O6rVcOa8BLIBNMz4NQ7KsY69PYeMatSjIqO3dlMAp9Q==
Received: from MW4PR03CA0247.namprd03.prod.outlook.com (2603:10b6:303:b4::12)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:07:59 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:b4:cafe::3) by MW4PR03CA0247.outlook.office365.com
 (2603:10b6:303:b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:07:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:07:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 12/15] net/mlx5: fs, add HWS get capabilities
Date: Thu, 9 Jan 2025 18:05:43 +0200
Message-ID: <20250109160546.1733647-13-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 3842ba13-89eb-43b6-8b61-08dd30c7c98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z9YTTcteaFzF1n7znTogHWOGVaHqrBN01zORmH9yY6malyU0bzNmeTYjpZ86?=
 =?us-ascii?Q?dNYDaT01waGnXFch5ec1CqP1IJCsbF5SIYdy8VKWnPoJgKh2bTqsFs/4axnS?=
 =?us-ascii?Q?ICU6nuW2cFyLMQuVQiRLYJHc0bAArVVE6qcFLLNsgqCuQ2eLn7WObskSlUiB?=
 =?us-ascii?Q?UbxYM9u0kFJBD1CBaxR9Sg+heEOUhyF5JtmodjOj/j41fEQYLbK87yBzYlKk?=
 =?us-ascii?Q?kIvoDEZ3rkbo3Bi1kjVscDIq97aMEz3olW8142MHe3bkccdmQl+TLrR1FEtd?=
 =?us-ascii?Q?JlTtT9SzU1MVlosfIGCZCpogxBSd6UQUnWnr7NuryBtqmeOYRHYcgM2OLjeM?=
 =?us-ascii?Q?AJA/dEeWBmsJFjZBjJ9LRS0WNJgDH2ejGvoWpP3lqH43gXWcyVqD4k9C+rhm?=
 =?us-ascii?Q?r/ulN2FBLUv8BN+pcvr8du5berO5A0w4+jkPIL0vW1ISp6qDpFMKsVR2GxBA?=
 =?us-ascii?Q?Sq2i1HepdKXkU4j7F3zVRNaNWj0SYzC9Fyde3SPdFMZcOnNfVgB55jdlSQT+?=
 =?us-ascii?Q?LZl28ylPMuw0QqgGisF1FKJQ28d7RP9NJuOec+ypcPnaGGyQfNzQCEXbq8HK?=
 =?us-ascii?Q?3BGlSA5TyIQBR7HQlidKRSbeKCVbgfTHV0GG+AAEOLZkgiyFRYyh0meMCwAi?=
 =?us-ascii?Q?WjP/aFHxCjjRRxaZx49lxJscFWkdwRn7R4Qou4kjfxLMt3r9JgpLO1u7K57x?=
 =?us-ascii?Q?HpZZvftvQmtACgIiI+RnT5dAtQ3CGB5xfB3b8OY0b4MwQwQaBYQoCnTIBN29?=
 =?us-ascii?Q?ertiGNSDWhuLwV5do0YX1qHLAnPHNSbY2CPtYSsKmJ/oqUpKFmSKMnIAouG9?=
 =?us-ascii?Q?+wxf7bHwv8ujdZkMJCXBSJwK0xQvN+xzMkIrx4HyTY0pavIRqMvIfRE4vxvg?=
 =?us-ascii?Q?lXWYfAJEsob+Xg6iEGeqYzTUvPCLdJ2lZfTz+PtL/Me/ey+2BIQsk5KeKeVn?=
 =?us-ascii?Q?tn7bLZUNet4mPN2BAW15N9Id5wnq6TaWVmNqKJQ1Dpai4y1F2mcl2CjOsZAW?=
 =?us-ascii?Q?lxTAGzb3h4IptxLoefXQdUXOGbwhyLarLgacMB1Orifq3A3hDj4ACP9SvSeA?=
 =?us-ascii?Q?RKlT9UN36uYPdQewb4YN+MLvyVWXXzSk0U03gXWGkpcxtMMbVINotKjX9zPD?=
 =?us-ascii?Q?E5Ue4RvkYsrphzKSiElpHjMhj730at5WZdAA1ReGgHtkJEE5OnDkNYrXYBqG?=
 =?us-ascii?Q?FuN05JVuc5NsuFFRJYqGEFWUY7DzFlj0cOVoIOSnBd7aShvsQexP8ZLzka2t?=
 =?us-ascii?Q?HOq8V2KQBMJus/jeF6xgmXPCXWWGPVlLme5ZiN2rgcIfRCRryeOgQu9KT+9H?=
 =?us-ascii?Q?w+2aKBdWWIprdeX8KznKPxqBusTEPOMFBLmhOr/vXseNSh5MSCusn015kazf?=
 =?us-ascii?Q?4nr8SjFPbi3cTVqq/2DDnRMO680QLUBaKF3rxsdkqe3Zd5QI+Nc7it4ePapD?=
 =?us-ascii?Q?LYdx4enFEjn4HH9xFiApiyqky7NxM5F5cKgUV+2SKVnddsfHKKtbmgkubIG3?=
 =?us-ascii?Q?3UdwJAB/alHZfwg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:59.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3842ba13-89eb-43b6-8b61-08dd30c7c98b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

From: Moshe Shemesh <moshe@nvidia.com>

Add API function get capabilities to HW Steering flow commands.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index dd9afde60070..ccee230b3992 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1333,6 +1333,17 @@ static int mlx5_cmd_hws_destroy_match_definer(struct mlx5_flow_root_namespace *n
 	return -EOPNOTSUPP;
 }
 
+static u32 mlx5_cmd_hws_get_capabilities(struct mlx5_flow_root_namespace *ns,
+					 enum fs_flow_table_type ft_type)
+{
+	if (ft_type != FS_FT_FDB)
+		return 0;
+
+	return MLX5_FLOW_STEERING_CAP_VLAN_PUSH_ON_RX |
+	       MLX5_FLOW_STEERING_CAP_VLAN_POP_ON_TX |
+	       MLX5_FLOW_STEERING_CAP_MATCH_RANGES;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -1352,6 +1363,7 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
+	.get_capabilities = mlx5_cmd_hws_get_capabilities,
 };
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void)
-- 
2.45.0


