Return-Path: <netdev+bounces-109366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E513892828E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B497287633
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FA143748;
	Fri,  5 Jul 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRth6uX5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F61448E3
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163741; cv=fail; b=szfADlxUB/dTmpIonV9gA36ZB2UwKO0WmdldWYDxw0yjS/XlPrYlAO5Ouethu42N+uqpkrHX0IAESHcxfHL3vL6KqUD90CDfbkXTZCtOKYDQ11ROlFVHRYDSRrNCwZMtnQGIlQfgo4b/DH8QSW38ZOwcIqhwq+ae1q2xUt0K3mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163741; c=relaxed/simple;
	bh=Abl/mgl+7k2eozKu2ALzHu4Z5hyOl9gTDa3xN8Bvaxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/Ned8gU0nzUW5iwHNl96hfratIvteUFaGD88mx5rvBM/pFnNtrTMTvMxGq/h5ARLvXIl3o+u70+f39bjwI14RXjHzamtixXYsdu30MHqand5d3EAiSwfBspz866RddLaMSA0TCnlp08t/5OFhHLrT7WpzYoB6rQoCUi9Zlu5wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRth6uX5; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqL39paIpAZ7QLHt5HK2xE5g28XOtZkMb2i7vU7aSdEpuY+c7DWZXx6KQHFQb4xNeWR5pLIytoTqZ0surrLuE+yf7KZqxL0VlMJwWslPII323Mi5Wsd5ZpfQ4klOIMBgvdzxOmUQNMjViu6aVU/MQl83ZM7EmUS4hzc33laBd4+5fSTMSv7ToaDDD2rGx33es+jClp89fxA5yOVwpf1/OheyIruZL8CM+eJHGYvB69zwKeCLpjj1ppo66u6eOV8UuDrkdPbTOtgiku9KOujCm0BVarlqr3zIYYViagvQGPOA8z8cW4l52gHi0bJBcnpzdTmBRgRNzAd2ib/YpNqSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LED6M5sdB7PSysZvBJ0cSaTk00BstLkXE3b9A1IB6FU=;
 b=XIJ+w7xFKBG7tgQWqKNviAyRFcATq3sF1NXlKmUfEZt9Wt0x+4kh4M59JppJwTvV01J236jCOvJbZg/i3K1/O/TwRTZoFiM6N32hnpzyPw1ORqGN78TiuXir1WyHHlafJKtpR6NadiZFxiRC+wF4usUOqjVS5E7s6pJFRdUeJbJ8pJqCUv3+HWFrx5l87/BiKCKh/kHFXCTTVCgwvJsrk6e+9n267oao7TonlYN1pCy/C1rhkWZ+iJc7cFEWmU5VY5lQKRcuxvox3mqNNPBZfuT3fFcI2PrFNVBkyrRgdeIceBYcNl1lgJBrbWeSsMLb5P097/PZrNt7NUiERg3rIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LED6M5sdB7PSysZvBJ0cSaTk00BstLkXE3b9A1IB6FU=;
 b=HRth6uX5GAl0MD+hcVMP1laQEiBkPjau9NAwfo7KXFexi+QfEqCYJBFVxcYoI26vAVywNfpNhkq3q7DE39GJbNIwrZaOLCG43HcyiNaWbQaII+cRBp+F6y0rFOFtRdn7568VN4nyysZIB3frLibQaplGxdSZxGTUqs0VB2WIFXN6tHk8CmXh2ewrAPpiFHvEGxV+baQNRywO0TyOu4kwohfzXEp9rIq46wXQ8053ayAVj50gNIY7zqHAyTiZEhwjZ4G5SPOPiOwbNiygS8XHVdnWE+ynNCcGhbnjDdS/hTPHQ1HgEEOR/pEZbgmCPdD+Tks7DoVjciCtiiM+9KffBQ==
Received: from PH0PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:5::16)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 07:15:37 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::b7) by PH0PR07CA0011.outlook.office365.com
 (2603:10b6:510:5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 03/10] net/mlx5: Set default max eqs for SFs
Date: Fri, 5 Jul 2024 10:13:50 +0300
Message-ID: <20240705071357.1331313-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2354f2f3-77f6-4069-ec51-08dc9cc24447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BvT6kXOl8qfaKCp4Xd0sVVtHshztZt+zIHQJ8XoiX71xaFOKmLCrnpxLTVNt?=
 =?us-ascii?Q?fxzrhx2+uT3jNV3gj9XZw02jvtzspKK4qBA8DXYFINzN887ZC/bp/17Q+My4?=
 =?us-ascii?Q?AgS0goaI3V7Ggjl4GxCSBdTzDzD/F77Ei6SsDbGbanAZbcxJZ9u8WNBNXjwU?=
 =?us-ascii?Q?+2DuwxZKLxeESIErxenWW61ojy79NvUM6XkGxCfnSaQVNHHoL8WafasboWip?=
 =?us-ascii?Q?BzSOsEHeoltigPV3vsVz/ANYKEPrCmxdB8yvesHIDTr4egqOngWYFv+8i0kQ?=
 =?us-ascii?Q?/ut5J+5qavgwJkcA3ScdHK39wVmoV+xYb0NSUihILn9FOceoyEzVQG71qlno?=
 =?us-ascii?Q?+AZbY1YzCgKTBbPArIGivWYXLtj7npPRPt4ZF9Jzw1kR3bMO3mUFI/LfZ0bN?=
 =?us-ascii?Q?u3W5WHzW0iOAD0f1jliq+u6Jvkhr8xLrlwzDc6HXVvsJzuyb8XctAOq41l57?=
 =?us-ascii?Q?gArjWosk97GqCZhKMaQLw/7QCjXFrzydSreA1P4KCoBC0BjlG+nRpPmpflje?=
 =?us-ascii?Q?KtVmC8a9Mf4P4BZR4Vo0PBEOQ56jaAmJy/8eqIB3R8fuxukF78rWc9ZNWpiF?=
 =?us-ascii?Q?li/yBMG6ytHDb+JT5UiIcYht89AjqsFmNPUA1Gk2XrzARF5h0PX4RljHLmZT?=
 =?us-ascii?Q?3esNgpSIq0o0g7SnN1uv35J4XiI872PMylKPhml9HizIa47PMUy99Rv+NQsH?=
 =?us-ascii?Q?d/erkvVtPAQkv86XLg2Tfww6rHsAu/mr7g3BJrHQkSdXj5hUskjXP+kG3gCd?=
 =?us-ascii?Q?c12dNRex4An9WrA8FJbf0mubgcoHpIFHqnv+7BrRpL50Z86NXplmdA+AwHGq?=
 =?us-ascii?Q?cya+l94HI9F6B6x/NMuDy4sWXRG53b1iDLFIgv6yuuxw9OzGmUeLfRY8KXKm?=
 =?us-ascii?Q?Zzlyf0gGXizpJ+bOkckyvUBYt/uVTRfyTGQlP4vsQQDN+MsqgfiN+RInu3gc?=
 =?us-ascii?Q?M+Um8GDpNo1pJRNh7urrnnqxAiz/+jO89CdJnRtuGYdr9/fYr8/NJF246jzl?=
 =?us-ascii?Q?EqCAJK+TNTaRyx/lh7PH3RWTjz8UDfVXTPzPgZjQj2a9LYlR0myk1NJkeiTU?=
 =?us-ascii?Q?8Mgl54ZxkT203ROnOyg+nLJ8YFMVbelIV/Oc9eVThQHKfdqRFprSiJYdeq+S?=
 =?us-ascii?Q?+DRjKcv0zL84lBZS1Pu7wX+qOWw8tXWkaXchnIhUiBeVGQU7GlUlPCYlZkFY?=
 =?us-ascii?Q?LLZ4sU0q23UPhFILTqYkPa+/OTQmoPU2gixz5+q8kBdk7AdFPGx3oFQQCfwV?=
 =?us-ascii?Q?ESxokaSphjeC2cSIA1Hlqf6ocFljCeT5DMXITKm+f4NO0z3xNmJhleGF5i2U?=
 =?us-ascii?Q?J1cI/78Iyu1GEnEt2YvZ0ZPsbASd4dXBrjtsTuHfFz5N6WmMxIQEfgzfF8IL?=
 =?us-ascii?Q?XqtuvhY8BlOZ35G5Lwd82I8cf5hoQsp9n3A/+Lb9Ba6qKP0tsPRD5cRADvfr?=
 =?us-ascii?Q?hMDlwsFSRzmq/3rqVvCMFbElARhO81Br?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:36.1670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2354f2f3-77f6-4069-ec51-08dc9cc24447
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832

From: Daniel Jurgens <danielj@nvidia.com>

If the user hasn't configured max_io_eqs set a low default. The SF
driver shouldn't try to create more than this, but FW will enforce this
limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  3 +++
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 88745dc6aed5..578466d69f21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -223,6 +223,7 @@ struct mlx5_vport {
 
 	u16 vport;
 	bool                    enabled;
+	bool max_eqs_set;
 	enum mlx5_eswitch_vport_event enabled_events;
 	int index;
 	struct mlx5_devlink_port *dl_port;
@@ -579,6 +580,8 @@ int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
 int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
 					u32 max_io_eqs,
 					struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+						   struct netlink_ext_ack *extack);
 
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 099a716f1784..768199d2255a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -68,6 +68,7 @@
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
 #define MLX5_ESW_MAX_CTRL_EQS 4
+#define MLX5_ESW_DEFAULT_SF_COMP_EQS 8
 
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
@@ -4683,9 +4684,18 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
-
+	vport->max_eqs_set = true;
 out:
 	mutex_unlock(&esw->state_lock);
 	kfree(query_ctx);
 	return err;
 }
+
+int
+mlx5_devlink_port_fn_max_io_eqs_set_sf_default(struct devlink_port *port,
+					       struct netlink_ext_ack *extack)
+{
+	return mlx5_devlink_port_fn_max_io_eqs_set(port,
+						   MLX5_ESW_DEFAULT_SF_COMP_EQS,
+						   extack);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 6c11e075cab0..a96be98be032 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -161,6 +161,7 @@ int mlx5_devlink_sf_port_fn_state_get(struct devlink_port *dl_port,
 static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 			    struct netlink_ext_ack *extack)
 {
+	struct mlx5_vport *vport;
 	int err;
 
 	if (mlx5_sf_is_active(sf))
@@ -170,6 +171,13 @@ static int mlx5_sf_activate(struct mlx5_core_dev *dev, struct mlx5_sf *sf,
 		return -EBUSY;
 	}
 
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	if (!vport->max_eqs_set && MLX5_CAP_GEN_2(dev, max_num_eqs_24b)) {
+		err = mlx5_devlink_port_fn_max_io_eqs_set_sf_default(&sf->dl_port.dl_port,
+								     extack);
+		if (err)
+			return err;
+	}
 	err = mlx5_cmd_sf_enable_hca(dev, sf->hw_fn_id);
 	if (err)
 		return err;
@@ -318,7 +326,11 @@ int mlx5_devlink_sf_port_new(struct devlink *devlink,
 
 static void mlx5_sf_dealloc(struct mlx5_sf_table *table, struct mlx5_sf *sf)
 {
+	struct mlx5_vport *vport;
+
 	mutex_lock(&table->sf_state_lock);
+	vport = mlx5_devlink_port_vport_get(&sf->dl_port.dl_port);
+	vport->max_eqs_set = false;
 
 	mlx5_sf_function_id_erase(table, sf);
 
-- 
2.44.0


