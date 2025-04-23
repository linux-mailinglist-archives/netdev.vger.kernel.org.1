Return-Path: <netdev+bounces-185157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64828A98BEE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA6317B32B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A401A3175;
	Wed, 23 Apr 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0OlcXCu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FA1A76D4
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416410; cv=fail; b=OYFW3BMUsgYvqdnhLyH5SYkGVqjEcuttKffPLN4VlGZgQtzEw/gRYSR1WX2tr/576KHTcQxNXFGgS6cY07T5JQMh9NXk39+8REI2PostIR6zDeJ9m5qet8kWCFmPh+Bm/g9lHloW1t2KkmC1sYORFnUuuDxMX2YptMQCgVNkFsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416410; c=relaxed/simple;
	bh=sNuGoyOQf3oT6NvHKW/jF0dOv3jPJ3oQxBJvWuXYa6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKOusWQ2kC2VSSlIoTP2J0+MFDBMGy1Aq1gC2CvDz947HTzYNxjg55eiHrfkUJ49fB4vK6Hy5Q5xFMKqoO2fV4HxUswLzVL7FaDeLQm99CpCjIKkxNnylMp1Uaj6WfiPjcoA0wFhRguldTPeDhN1Qodn81e/uUA421JIpzAVnh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0OlcXCu; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8Lg/IgxZTD96UcSWFlJ63Txrlstla8oFEdu40/JZhwR99nkpv1YrOXCTL0jOBQrLKKHo6IMxuc8HLF9nMmTICiCPRm72msrQMVir8QpsnjpOQA/f/PNr4vYeiwdTMJfXhrqiHKFRHzuQ0hz438QkPflSHORXkK7oYgAPQHlntUX4Rp3LjozimuvVxHfqxOl24BwEPccrNi1KBwz/7cWZFVe2WU8vaRqG4F4HtsocEdG6VpaXS5hUm9SHhLdPw3UYgn1Qlgxz2F8c5nh2R3N1ahv5xNrfOx0yVwMoBlceD/hJBCFsRIVr5sH7gE1abeg6Tq7he51fq+eI6hL3BI7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPSNcoRGfICPi4R7HFkPw99btgBkactNLiwv3j0oK9w=;
 b=if8A4LpvjQurTBYxAtynQzw7c4+yJCwDZ4IPeNNdhIyaOEiesSbpKeweFUFTti51vQbQvDNwJYVzPTIBqc0D1PpdB4YdD8r2QvwgErSO9XLwHyxKE49zFh8VwAbjDYf1p7fUwFibNgvQ6FAMMCnhUUeAzzuB+AiZdgVBedkPuEn7LpK8yQl/I0Av2On8rPlwcYyY1ZZQ+/mmoBtFw/1T4SFMG0g4i7PEPku1loVmL6dK0wSdqoTiK6ACPAOoCIeeP97QIiElr6dxzDomoby0Bx+BNMULe2EyWuG770KMnj7jLmwS//1vcJgto/FB08Abt5tO5Rica7Zl/lfvVhW+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPSNcoRGfICPi4R7HFkPw99btgBkactNLiwv3j0oK9w=;
 b=H0OlcXCu6slphjynfUhQN1ML7/a3UuQ8aotaned2XnYxCF1skLzDnzJP5Zb0p/J0Nqh4Gb+NGdJwjXtcoT8NeprtvQ7fw6dfjqThRJvDyCPUFF2PAFbdrtbcNmKHbdu16/bcqynnoxTixliMSCdw+e0wV1EQnyA0BxvCYsK4nF4LzC94S0X9mFOMidkmcXzoNqRff27euKdUzxZ5DPTjVjhjnq+tGVIHfvejZSDO91NNJWq3uXjRfgcIYk00WwJze26fQoe38ZDsaQzyXJC94YoTJDJA3JhPXCA7Jo0dz0NLJfb02DaEtZAfap98Yj5hE5Oj6y4+rjSxHdNMelniYA==
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 13:53:25 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::84) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 13:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:53:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:53:11 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:53:06 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: [RFC net-next 5/5] net/mlx5: Expose unique identifier in devlink port function
Date: Wed, 23 Apr 2025 16:50:42 +0300
Message-ID: <1745416242-1162653-6-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeae820-f117-4b86-c2df-08dd826e37bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dm2Na77eAZd3FNc2M4D52FrH9Dn8GkOfKKFOZckOLCQZ67wTPv+LYTJZ0fiB?=
 =?us-ascii?Q?eWV0maF/S7s7oN45wlQB+75oM34C0w8oy0+azV7GP9xIPrQ4CjjC02F123OJ?=
 =?us-ascii?Q?WPo9pUJEJo9kv3xe+VJINI/I+uLeW6ntjK4ys8WySDXmbAubzd+i8n7+/SV8?=
 =?us-ascii?Q?F/fVdsaSb01MSF2Vhu0HL+U4VWjgEtJ4j2vwOdoY4nNVXdkhiVWo7QK9ig/v?=
 =?us-ascii?Q?fsvLppv+ZFMAfS3uteJgiFJaRui8mhvyj4b8rkF61CIU3OEr7dfKK+p8GjLC?=
 =?us-ascii?Q?9xZ2n/CUGyPDz5iKquv+WA6H/4M5h2/te00c73JTceOMu4V9psZPwAaDzpnV?=
 =?us-ascii?Q?QKW3HelK6gFLV4vs3EL5ZJe9eNxtrmtV79LzLgrRWRPnKj8HjSyG3/81Tuef?=
 =?us-ascii?Q?kIfccZxIh6XuQBZq/H0gQYpJMcKY6bUwrt998Od4NBxs/O6ibdYXPaVo8Pik?=
 =?us-ascii?Q?YYgOGMUa/cQ3jcYoSEpr+YwErTKkTHEmJir5j7pTep2j0vLnBoqT32PNeyQh?=
 =?us-ascii?Q?JGsMpYMpliTAKphAHY7/F1efpJs786wURSjIQ1Zbvf3a+qldZNhuv3oT4EjZ?=
 =?us-ascii?Q?UxVQaXbzFe+248orENz76zDpJVcsdeFtJUPevHLQ8JpPpcp8H41w0vfyNnMM?=
 =?us-ascii?Q?+2vf0jRLFU9Py+ldK4cBEvzTXtLioiyoi2Q7uiNnnPpRpVO+3zUDLyqB7Sxb?=
 =?us-ascii?Q?5o0gLdwxFxoDKko2OUZVzvO5loxbE2K/vMruwtWE0mB6Dm7Juo/JMqMziKlV?=
 =?us-ascii?Q?c7GvAIVm7bdQTrjHU1jrKFdiOunmZQ/irIr/PdgeeEI/Wyu3sMvxgaakDQEp?=
 =?us-ascii?Q?v9e4x8Sl7pLYPbnmvcigL49bqb9jWR1m1aSnzM11IAeoFXHuxufqgRFq1RcA?=
 =?us-ascii?Q?tyYbcxg9byGonOaSLWFajZBRLdj+rCJdrnBXhjiBTE3CNhixZDsOgAVHk9op?=
 =?us-ascii?Q?ZRVRgK4FUQi3R6AMrNzaS4+ViGVKo49X/fCbxmlD98IJccWqLhnxY08j3F0B?=
 =?us-ascii?Q?EmZMwVPiS3QdflO7LWXoyXZ0zdbX0j7TlG+oyX+okC9H8Mcnk+bnubR5GzRd?=
 =?us-ascii?Q?nTVYKsjKHzW2gJy76nmWz6wgDNZleRWCMdwKL1ZTAWPE4+BGxZGBC1VN5mJ0?=
 =?us-ascii?Q?HYQ/4lYQK5cJdzOXHHFWcivOSD/XMO40pU8g4qpDlHbePzH0lJc0TxsOSLKi?=
 =?us-ascii?Q?lcPbpPtOtFfW7DQ//KMJtrSeb3rnNym49xyoQPQpwmNabtaGy0+mrNqOxZdv?=
 =?us-ascii?Q?1i+LTJWmft8wDvy/rpymaxOPgpcoHW/yKvOkaqIInq/dkDUAtYS7hl41OBzD?=
 =?us-ascii?Q?nVb7T5oDRejd8BsFQi8fd9lQmjkX9eDmVMsQWH0nQJxtMc+3tr6U5siKfXsv?=
 =?us-ascii?Q?Of3Em4qMmH3PHqeFqoS8zgC5rxJ2bbVF837MYRozm8iJ8TixjflCcRQXTKDG?=
 =?us-ascii?Q?ygM1h1ytGXM+fxJZJGrqt/n8tZCqpSgobMgRZO7Cx4QOzDhbBRfaVOQt84Hy?=
 =?us-ascii?Q?5/aeK11zvFKCFYHxLFjlVzP+tIbyy6hUGC50aTdnoJnUyyCXVbBATY4+6g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:24.8606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeae820-f117-4b86-c2df-08dd826e37bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

From: Avihai Horon <avihaih@nvidia.com>

The devlink port function unique identifier (UID) attribute allows to
report the UID of the function that pertains to the devlink port.

Get the port function's VUID and report it as its unique identifier.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index b7102e14d23d..0f86c7d3df5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -100,6 +100,8 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 #endif /* CONFIG_XFRM_OFFLOAD */
 	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
 	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
+	.port_fn_uid_get = mlx5_devlink_port_fn_uid_get,
+	.port_fn_uid_max_size = MLX5_VUID_STR_MAX_SIZE,
 };
 
 static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 8573d36785f4..bedbb4d12903 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -580,6 +580,8 @@ int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
 					struct netlink_ext_ack *extack);
 int mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
 						   struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_uid_get(struct devlink_port *port, char *fuid,
+				 struct netlink_ext_ack *extack);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index a6a8eea5980c..749e2f379eb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4701,3 +4701,37 @@ mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
 						   MLX5_ESW_DEFAULT_SF_COMP_EQS,
 						   extack);
 }
+
+int mlx5_devlink_port_fn_uid_get(struct devlink_port *port, char *fuid,
+				 struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	u16 vhca_id;
+	int err;
+
+	if (vport_num != MLX5_VPORT_PF)
+		return -EOPNOTSUPP;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager))
+		return -EOPNOTSUPP;
+
+	if (!MLX5_CAP_GEN_2(esw->dev, query_vuid))
+		return -EOPNOTSUPP;
+
+	err = mlx5_vport_get_vhca_id(esw->dev, vport_num, &vhca_id);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting vhca_id of vport");
+		return err;
+	}
+
+	err = mlx5_core_query_vuid(esw->dev, vhca_id, false, fuid);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed querying vuid");
+		return err;
+	}
+
+	return 0;
+}
-- 
2.27.0


