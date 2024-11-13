Return-Path: <netdev+bounces-144580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78F9C7D01
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A51DB23A99
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9A206E63;
	Wed, 13 Nov 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePv0SaNN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A36420899A
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530066; cv=fail; b=oxkjj0Om/b683vYBe2JJwGzsU2RX3iN7ZZVlpHrzKz3mVPMyykzaUgC+EEYGaNGvC1F67rq5nZLQ27xh8PGZhT3srjpsNoYTFjWKZ+GeER1H4dsux91F+Ya8xNiaz4m4/fK0pTqDykbUkoshIuiDuIRZyDIWOJuL9UG6SIRcvTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530066; c=relaxed/simple;
	bh=UdxvrmQyB77wGBDCVVzKTdUJ7FfmD4ynELJvJFSbAoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPPSCsSnnrXAJDukSx/OKOwV/d4X8i2GxSpkxsIKqw6c7pdpoYBMROI+MDOl6CkbvXGrRrvdpGU+weAJu4jDFjuBDYTvIsXRilpPS5AQFdWPYGfm5foKxFwqI2nLgFW/sB89OOog8hWG1BxsMcso1ycZrBq13XiWKVO1mJoxyng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ePv0SaNN; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU368ItmkYrRER7+f8GCtcnaV5m7vCMnAyDvpIMjG4351T6VJ1zcFzRSOXKtqMbRDZv1PG0mOOEVawb4LkX/2aMfTfnYn6fQPinQA8aM9HPXXsCmF2Gz0rvQJ9rRFGsn8l7DSzlk85auzRhO9NgpY2WOfx6+f+qYDpr91s3ywsBkai9/9o/asxWo9y5T+sDyjmaBpTEvFepn18srv5EJAaJ4u2QJEE8rpMUIqoH2IWNRvRyW2k1DxY9dQfFpY1VgWP01oX7+EIKjIn7JHsWuHEPaNtwwZaCujj19+Hjz3GtmyeKGyW6ITUj1nMASLZRj/ceHTzp8ape++CS6eWlcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbdsVZedmqE2Qw3LlVSocZ3zW+XN5gGQaVJYYTVAyMU=;
 b=aBlCtQlurClXAFeW50JM6E6Be5CCdGWNagoqeuaG4CMEZsLluTe+P+4qg3AsG62wO9+8kWtXvtrfx7vSmVBq0VQ3ACpcrYYl4m3CHyp4Cy5Mlh/xbEs0GpTdWkD4agrjqLV7YfCQ8Wl+8cPBgmVbNNo/aERqKxaIKClmXjVVxQ1Lu82QjXc8dp2GonP9KjOyOzKIDRoWb0QJtJWP6OxhOu5Ewn2vQ+jIO22R+goDy8txxkWdJMnaG8EorhUDbdhaXdtua2NN2akV3BceSEfQmujyh5ZKz4hFjlF4lp3VN/eFKJ0dSaBJIjtxes+/TZKcJG/lE16+KLUjGDNiMoGIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbdsVZedmqE2Qw3LlVSocZ3zW+XN5gGQaVJYYTVAyMU=;
 b=ePv0SaNN1HWY6/2l2UcOsPAQeBiTL2AVzjBjcB0/vQ0X68x0aalO5qfU5qEeRjmbPMCGyKYadjkZobU1Uzdjde7SkIAGIwPOo9uaO/B4L1xqZnZk7zf2eO9YojgFoYyaxudG7eJmhDv1E7KicAHSbKriWGD+zBhgvfWMKuDEdI7oaEvykoXw3jh36UwEz/Az8/DIZDSbttxCxhG/M5neD8KnsZEMADeAeXZ2PM2pa2ogJNdExuJCW6vUcIshCd+q28KHe4tCHF0fkM1L1SD1PQxGupYTVjNMfYYekcLwrd401JqDIc/7hd8PR0W+HMBIyRlzl2JsXuvRTgPzseh6mg==
Received: from MW4PR02CA0002.namprd02.prod.outlook.com (2603:10b6:303:16d::10)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 20:34:19 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::ae) by MW4PR02CA0002.outlook.office365.com
 (2603:10b6:303:16d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.1 via Frontend Transport; Wed, 13 Nov 2024 20:34:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:34:00 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:57 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 09/10] net/mlx5: qos: Support cross-esw scheduling in qos.c
Date: Wed, 13 Nov 2024 22:30:46 +0200
Message-ID: <20241113203317.2507537-10-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 29045557-564b-4b8d-1943-08dd04228bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbY1QZmSKieY1+hzAN1rhTx2zZxIQQEODkxHjuF157O7GsPH+z5pn9dlLmMc?=
 =?us-ascii?Q?30BNeppZUfldf7KomGyrNTmpp0mYxN7TgXmqS5CBybm1a/lbPhEx3J7sy1hT?=
 =?us-ascii?Q?ekVderJBJ6hLG+xgfcTSTNvy7wbgiuIZq2mYj5KmFg1uTD+/Dl4AA8tj6j0L?=
 =?us-ascii?Q?XPN6i/pOIEN7LLWqVwbuImihJVundXooKrMQOSZY24DH0E5y8W2xoz3fuGCy?=
 =?us-ascii?Q?KBHSSSsk4Fx4xGfmMEtuAHOUP2qEOO8h//k6L9YuMhxeT+49DXgDKrKoEeqS?=
 =?us-ascii?Q?V0NzA6Tzsdm8zzwcuq9uQT8Vlsgfu9aIeH08OjsDXdNO5X6aGO0piA4+Folt?=
 =?us-ascii?Q?0ht7rnAU3XuNc5bjuRvdt9gBs2gxuWgrV+q7ACB7d1ISJn//bfqIglPSxpck?=
 =?us-ascii?Q?9QruVqKsPmthfKqHG5nxVH8RfBZrkSa23b+aw5BaU7Ao6QOCQ6Pu7lp8vb0Y?=
 =?us-ascii?Q?OTJOZDPqFtUujD1YcqiVcRCwsAN/73xUtBJFJjzpMgDtSHcEni4SUJ0IPpkt?=
 =?us-ascii?Q?84T0Q62MX4rDdtFBDdf+UmSc5jdgMRZ/Pi/eGnUT8Wk+NEqjebDlPowydI4i?=
 =?us-ascii?Q?zH0rNPQmAy8f8k8Vg8D7e1/P8J2LcLNhNaibskbUyWsNMcdQRJVZ5GOMnyaL?=
 =?us-ascii?Q?or4jH6SSmwAU8z+6EbA7IrHkL193cZr+c/7cdUnVLIE2gsBOk+tfTM0WuUWd?=
 =?us-ascii?Q?ahUD8e15YB4a6KSpl6LCVgzvlxtwHIOQVmFtTnh+bNYMnw/Lk6Z+y5bqltXr?=
 =?us-ascii?Q?7OCzr/ORWioRy7nWvL7eaQODlR7kPPXIE0Dof7bHtj28BpaSiYDo3SCoV0VG?=
 =?us-ascii?Q?ytzduNjpHKyWxNN4su/2kia5g7s+RTxWlhemo4rszJBDYV+iZ6LHVxkMMBGv?=
 =?us-ascii?Q?c15ZGepFTbxInL0webnPdmvcd+Qj9w4SXzZsfEQpW1hntD6Cmpbca3zmiJlr?=
 =?us-ascii?Q?iIJaY5rm+Mh12zV8gEMVOIv5HnPNqM3gMW7aZuSEa7l9l2KS1QXU2F0vf9u8?=
 =?us-ascii?Q?MN+gMd9gT2cbXZUdhSG1AURT3acWUZ+LpPFvTLLXDgew04a9DfPW/BZ+lN4Q?=
 =?us-ascii?Q?tDlhcMFpkpwS+2PCdgDQ3QIwIebRtvtex1sv5OEFPMfT+o3MwJzPh9Vg5i2h?=
 =?us-ascii?Q?PoZq7YFQcWcULQyg/3QVZ9IM3jv1BQgfCpTSnF0fFgVle82C2/Z+H8DFbyIZ?=
 =?us-ascii?Q?KWJuOHGl7SR3qrOzatGheLm7Z6il4u5pkL3rTAg7ftXbOhc/k+qUc3IQ50qW?=
 =?us-ascii?Q?i2Bn9BjjsF2vV1q2IACa2Ue+hvc25AEz+TLqiUx9+TfaJ85OIBS92JmELZE7?=
 =?us-ascii?Q?rAaPQChTIa/9u6jou+exbDzl/UbOHquif0PHzwVSW5/nQ5a5KnEu1TbqHdhj?=
 =?us-ascii?Q?kvV5cn/BkU1BFx8cxpnbZgVhT8nqyKvJn/mn0NSqcCw8qydrYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:17.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29045557-564b-4b8d-1943-08dd04228bc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613

Up to now, rate groups could only contain vports from the same E-Switch.
This patch relaxes that restriction if the device supports it
(HCA_CAP.esw_cross_esw_sched == true) and the right conditions are met:
- Link AGgregation (LAG) is enabled.
- The E-Switches use the same qos domain.

This also enables the use of the previously added shared esw qos
domains.

Issue: 3645895
Change-Id: I282f0ecad258fa2dbe6a49e88cc7bc9a06ccfcce
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 117 +++++++++++++-----
 include/linux/mlx5/mlx5_ifc.h                 |  11 +-
 2 files changed, 92 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 4fba59137011..b75f9939ae4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -155,7 +155,9 @@ struct mlx5_esw_sched_node {
 	enum sched_node_type type;
 	/* The eswitch this node belongs to. */
 	struct mlx5_eswitch *esw;
-	/* The children nodes of this node, empty list for leaf nodes. */
+	/* The children nodes of this node, empty list for leaf nodes.
+	 * Can be from multiple E-Switches.
+	 */
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
@@ -471,6 +473,7 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_node->esw->dev;
+	struct mlx5_vport *vport = vport_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(dev,
@@ -481,7 +484,13 @@ static int esw_qos_vport_create_sched_element(struct mlx5_esw_sched_node *vport_
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_element, attr, vport_number, vport_node->vport->vport);
+	MLX5_SET(vport_element, attr, vport_number, vport->vport);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id_valid, true);
+		MLX5_SET(vport_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, vport_node->max_rate);
 
@@ -494,6 +503,7 @@ static int esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vpo
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_core_dev *dev = vport_tc_node->esw->dev;
+	struct mlx5_vport *vport = vport_tc_node->vport;
 	void *attr;
 
 	if (!mlx5_qos_element_type_supported(dev,
@@ -504,9 +514,15 @@ static int esw_qos_vport_tc_create_sched_element(struct mlx5_esw_sched_node *vpo
 	MLX5_SET(scheduling_context, sched_ctx, element_type,
 		 SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC);
 	attr = MLX5_ADDR_OF(scheduling_context, sched_ctx, element_attributes);
-	MLX5_SET(vport_tc_element, attr, vport_number, vport_tc_node->vport->vport);
+	MLX5_SET(vport_tc_element, attr, vport_number, vport->vport);
 	MLX5_SET(vport_tc_element, attr, traffic_class, vport_tc_node->tc);
 	MLX5_SET(scheduling_context, sched_ctx, max_bw_obj_id, rate_limit_elem_ix);
+	if (vport->dev != dev) {
+		/* The port is assigned to a node on another eswitch. */
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id_valid, true);
+		MLX5_SET(vport_tc_element, attr, eswitch_owner_vhca_id,
+			 MLX5_CAP_GEN(vport->dev, vhca_id));
+	}
 	MLX5_SET(scheduling_context, sched_ctx, parent_element_id, vport_tc_node->parent->ix);
 	MLX5_SET(scheduling_context, sched_ctx, bw_share, vport_tc_node->bw_share);
 
@@ -947,7 +963,6 @@ static int esw_qos_vport_tc_enable(struct mlx5_vport *vport, enum sched_node_typ
 		NL_SET_ERR_MSG_MOD(extack, "Setting up TC Arbiter for a vport is not supported.");
 		return -EOPNOTSUPP;
 	}
-
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
 
 	if (type == SCHED_NODE_TYPE_RATE_LIMITER)
@@ -1182,6 +1197,26 @@ static int esw_qos_vport_tc_check_type(enum sched_node_type curr_type,
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport, u32 *tc_bw)
+{
+	struct mlx5_eswitch *esw = vport->qos.sched_node ?
+				   vport->qos.sched_node->parent->esw : vport->dev->priv.eswitch;
+
+	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
+}
+
 static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type type,
 				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
@@ -1200,8 +1235,14 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
 		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node, curr_tc_bw);
+		if (!esw_qos_validate_unsupported_tc_bw(parent->esw, curr_tc_bw)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unsupported traffic classes on the new device");
+			return -EOPNOTSUPP;
+		}
+	}
 
 	esw_qos_vport_disable(vport, extack);
 
@@ -1519,26 +1560,6 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
-static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc_bw)
-{
-	int i, num_tcs = esw_qos_num_tcs(esw->dev);
-
-	for (i = num_tcs; i < IEEE_8021QAZ_MAX_TCS; i++) {
-		if (tc_bw[i])
-			return false;
-	}
-
-	return true;
-}
-
-static bool esw_qos_vport_validate_unsupported_tc_bw(struct mlx5_vport *vport, u32 *tc_bw)
-{
-	struct mlx5_eswitch *esw = vport->qos.sched_node ?
-				   vport->qos.sched_node->parent->esw : vport->dev->priv.eswitch;
-
-	return esw_qos_validate_unsupported_tc_bw(esw, tc_bw);
-}
-
 static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 {
 	int i;
@@ -1553,10 +1574,16 @@ static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
 
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
+	bool use_shared_domain = esw->mode == MLX5_ESWITCH_OFFLOADS &&
+		MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched);
 
-	return esw_qos_domain_init(esw, false);
+	if (esw->qos.domain) {
+		if (esw->qos.domain->shared == use_shared_domain)
+			return 0;  /* Nothing to change. */
+		esw_qos_domain_release(esw);
+	}
+
+	return esw_qos_domain_init(esw, use_shared_domain);
 }
 
 void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
@@ -1760,16 +1787,40 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	return 0;
 }
 
-int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
-				     struct netlink_ext_ack *extack)
+static bool mlx5_esw_validate_cross_esw_scheduling(struct mlx5_eswitch *esw,
+						   struct mlx5_esw_sched_node *parent,
+						   struct netlink_ext_ack *extack)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-	int err = 0;
+	if (!parent || esw == parent->esw)
+		return 0;
 
-	if (parent && parent->esw != esw) {
+	if (!MLX5_CAP_QOS(esw->dev, esw_cross_esw_sched)) {
 		NL_SET_ERR_MSG_MOD(extack, "Cross E-Switch scheduling is not supported");
 		return -EOPNOTSUPP;
 	}
+	if (esw->qos.domain != parent->esw->qos.domain) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot add vport to a parent belonging to a different qos domain");
+		return -EOPNOTSUPP;
+	}
+	if (!mlx5_lag_is_active(esw->dev)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross E-Switch scheduling requires LAG to be activated");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				     struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
+	int err;
+
+	err = mlx5_esw_validate_cross_esw_scheduling(esw, parent, extack);
+	if (err)
+		return err;
 
 	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent) {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index b9eef877c061..10cb9aa52f06 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1095,7 +1095,9 @@ struct mlx5_ifc_qos_cap_bits {
 	u8         log_esw_max_sched_depth[0x4];
 	u8         reserved_at_10[0x10];
 
-	u8         reserved_at_20[0xb];
+	u8         reserved_at_20[0x9];
+	u8         esw_cross_esw_sched[0x1];
+	u8         reserved_at_2a[0x1];
 	u8         log_max_qos_nic_queue_group[0x5];
 	u8         reserved_at_30[0x10];
 
@@ -4130,13 +4132,16 @@ struct mlx5_ifc_tsar_element_bits {
 };
 
 struct mlx5_ifc_vport_element_bits {
-	u8         reserved_at_0[0x10];
+	u8         reserved_at_0[0x4];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
 struct mlx5_ifc_vport_tc_element_bits {
 	u8         traffic_class[0x4];
-	u8         reserved_at_4[0xc];
+	u8         eswitch_owner_vhca_id_valid[0x1];
+	u8         eswitch_owner_vhca_id[0xb];
 	u8         vport_number[0x10];
 };
 
-- 
2.43.2


