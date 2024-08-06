Return-Path: <netdev+bounces-116113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB0949216
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A752815B9
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4C20010C;
	Tue,  6 Aug 2024 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j33B+fju"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB51BE875
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952234; cv=fail; b=d//BckQZiv2q9eG2If0K2FPxmd6X357yKBLsc9Li+ubDDQGBN/9njOHhVqCDcp3OMLA/ZzS8SPkt86CML36cac4rBXfRaBLa0BMndAMxYr9UgAvlVi4egXG0FSgb0C8Q8SS+Mce+KxCJYuJQg7yoMNjbTe27vhvnsBWeGs4UAB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952234; c=relaxed/simple;
	bh=damO4B68FeDBBgvNcV6B59CjpW5vBS7D/m+DIiSv7Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSqE9xtDkZEo21DQ33o4YqNtlZiJBtvelJtM7p1WiCRNeR9dmK1M6MkYIz1Dj4TfitRKrwRzREpFZBXBfr5PhDIsiy3uzJ3KD3phClH0xQesBL0J/Xad2vpKqn4L5aYIceRg5+KeZX/3Sxw7fCvPIVuUziEh8qi5tpR/Q0u7Mtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j33B+fju; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5wrn16VPFi8oNQNK0fBmLlLiMcvbxn5H5LBkVAeOV0RSPbItwA+JdJzmll+ZaGEjs7Zw+DfV0UeTEdJx0PPIDTnomwqWLuP09J1e1024rQ+aCePKjWUm4B4KJ8OAjnOOg0DmiRccLmpB4io5+kKmGj1pXfrEp11soeTsJjmbJfzEPqNYIS8jBTNavcS1HSgO6i99mhnuVS6G6KtM5uoOJdgjHR6J+5p/y2s11LlzrbrvTWK1df/VJMhsuksx0tT4onCY6XfMYH3/0xvUiw36IJLa42+VwklPjYHxaHiPZGGmotRj63EVJZLEsl9d+/nw9ItYYu0AQA7p4i9fNKSkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSOqis10XSa2hlFQiWocg5SmOiC1mkHyTaiKGHbxKFw=;
 b=SJajkULcOQM5new+JTB639OUuPKx50QiHYEuwnV/qXaublPGNRWrFYj13S/nJwHV2Jbi89uXG9/ouLwgXCEwpxjYfYfYg5gsilFpeYq+U4omVVc6DZhWbMOJgtKT0KnaFH9usmg2GcQ22r1xpCQjqBx8WwYXIPKnsqjxcWSSuWraaasinN6A8T96BOCFvFdpENougJXh37bWg/2CXhB/Dx89kuKYfTIIuGwKTWI8T4QsRxmeWdnObk0UKbToi0PD2iI9N0S9t/+HTjXj60ClWPAQTQROBUVnS90Hx7sNqM3ruT9XZ8vqBBZjBO93hUMbdwcEJ33T4izPQA/yPXGsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSOqis10XSa2hlFQiWocg5SmOiC1mkHyTaiKGHbxKFw=;
 b=j33B+fjuhSh3ukDViq3Gf5XjA0g7DOAvN4eNqoBXc/cNI6QrASg54FPQFqGOVEwGs3hTpHxZscAbONmD8UUbETPWR0fayzN4vpaidxN1fO7G7R+oRAk3cllWnhoRNRtfvyP+vVJ0i1bmC3j4diST7hxwZhyKvHgBPUXJ2s35CBQsGjrWZjljmEWeiwrCF3JTDzcJ59EIQ4RiV6VleSsrJlroULh0Rhzt6ITgfQG7MSsAhNFeKq8ohoHBkCP2GTTJZH1RCB1APWpKJfdPklukRDmaCjiB2SouXnvEJbtvgXnLBpUd4WHu4ijHeATF3MUYHfYRH3vgO89rDXLp+e6BSQ==
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:50:28 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::6f) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:49 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 04/11] net/mlx5e: TC, Offload rewrite and mirror to both internal and external dests
Date: Tue, 6 Aug 2024 15:57:57 +0300
Message-ID: <20240806125804.2048753-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: bfce4146-e70e-4500-3392-08dcb61ebb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RV/jnw7YxBDuq560ddCteIzNeUTkEnQvBba+DSValMZho1YUooo7TzYAylpJ?=
 =?us-ascii?Q?WckcQEqLk+IQXW5N4hFNMSPcpdTlp/lQDAFZf4/FLyda5jlj5/yihmTVoVDE?=
 =?us-ascii?Q?/OWwf2JoEhlSuckRMEs/qB0xeMtOl48IfGZw7hoeAJ5L5AKoXSLunV/yWDdK?=
 =?us-ascii?Q?dxzNZK3AFzSTMTZO1lqvQP0s2oifYB4eDOJorTZCZe5glIqwH2+YqLLMrY9j?=
 =?us-ascii?Q?42Z7q6oXJuKZt74VPMFUvWJqbJQ8mHRCfaEC7Xaq7n/qYyZWVYoEh5+e41E0?=
 =?us-ascii?Q?lXCyLDERha0DyPTBXk//Ha4vZ1LgKt6lKHSGmcNY2j+pLyLtJJIa1O+puTRF?=
 =?us-ascii?Q?43dbOba6GmB2odfo/ffQrEGsshmYnk/amqvhH/rbYI6fs40BsTsd9DqnoYDc?=
 =?us-ascii?Q?OITKjB32rTETjzXN0N9d/hHbIqf5HeGxrYmcIsDrv5Mlwu9613EFkuaJsCML?=
 =?us-ascii?Q?3DT2F6JJ0vdzjuHQlsSb0yJ+lFhzoGba5xyKj5r5jyrL9hXRLWwgZOsfsMAA?=
 =?us-ascii?Q?ywl+ifE3SCWhZtAlw2p4gJeef4XzYkDNt7ggKX3BOAls7AZnzp50D305ddJY?=
 =?us-ascii?Q?o5qLYx4Tqm5o3+QneS+93w56ghANoxa+bL4ohAJbrngfBmyqS4krMNSbVTrf?=
 =?us-ascii?Q?vm7Tk4ZAGC0wlHCN/gH5hc0pPBpbvYgJdHjU7QKjuL23DsZqeaRHbzFVkn7M?=
 =?us-ascii?Q?MgB6YV9cbehOuGQdcLPeJ3hP7D5j5l95znIOiRl9f1Q13Whm1CgwnABb3ybX?=
 =?us-ascii?Q?bGYyH3cBM1JMAf+lszHr9T0XW+yXpBwSidKa6mc+lUuLzz+9eQdbfJDmdJuL?=
 =?us-ascii?Q?ZWAYR6pJYaJZ6BirSXrZXStqXAY70XMxtd9fJgYf4CjKUcRZfmbwdRRdrB41?=
 =?us-ascii?Q?2vkB3CirOy05AS+GHENNnbzLlVlQ8mJjpvOVCGvc62maSr1cKn74iMM6K1f+?=
 =?us-ascii?Q?y7uVAzJ98J9u6sRoKCRgAdIHWs7eJ9pQXEISDcLlF8gJDRGNLn0oE7ZAmKYu?=
 =?us-ascii?Q?iyNOzxnsqRr1zZcP4aRgXKwTFRlxDWfYpkIZH4+z18LL4TrZHZXYgFg2UZFF?=
 =?us-ascii?Q?j9rM4CLcy5gH4AUjGaBANSpQBiQIwJ+65h99ST5NUqEBq3tP/0ViihxjFhGR?=
 =?us-ascii?Q?wbRRo1S4J3P+hi/NLXcXvJ6+N5KuZ3NKecZAQNojmMmINC8psSMn+lAPAEqC?=
 =?us-ascii?Q?zdIa5JL4eZpaHkZeprcXV+cP1UJsieFPVl158imVl2oR6fySJHjUb2s9D4GX?=
 =?us-ascii?Q?Plhw/q9Q1OunX7GnPd7JIIAUrEgCN338x9p6hKkU10GkBZVJ2fM5YSsNCVOa?=
 =?us-ascii?Q?C7qs9/iRRkI//oWtm45nC3ElEgMJ202xilJ5dris2dOTocqqm0C6kT/6WE/o?=
 =?us-ascii?Q?XFpe6KNYutaU2ui9aJsXejgWlZp9UAKNKvYtqMpPJH5+l4HULwx7R70Sj470?=
 =?us-ascii?Q?zKsxzAcqoHlXIGe68WerLsIKwjIj4RgT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:28.5444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfce4146-e70e-4500-3392-08dcb61ebb44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488

From: Jianbo Liu <jianbol@nvidia.com>

Firmware has the limitation that it cannot offload a rule with rewrite
and mirror to internal and external destinations simultaneously.

This patch adds a workaround to this issue. Here the destination array
is split again, just like what's done in previous commit, but after
the action indexed by split_count - 1. An extra rule is added for the
leftover destinations. Such rule can be offloaded, even there are
destinations to both internal and external destinations, because the
header rewrite is left in the original FTE.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a28bf05d98f1..6b3b1afe8312 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1742,12 +1742,17 @@ has_encap_dests(struct mlx5_flow_attr *attr)
 static int
 extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *attr)
 {
+	bool int_dest = false, ext_dest = false;
 	struct mlx5_esw_flow_attr *esw_attr;
+	int i;
 
 	if (flow->attr != attr ||
 	    !list_is_first(&attr->list, &flow->attrs))
 		return 0;
 
+	if (flow_flag_test(flow, SLOW))
+		return 0;
+
 	esw_attr = attr->esw_attr;
 	if (!esw_attr->split_count ||
 	    esw_attr->split_count == esw_attr->out_count - 1)
@@ -1758,6 +1763,18 @@ extra_split_attr_dests_needed(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr
 	     MLX5_ESW_DEST_CHAIN_WITH_SRC_PORT_CHANGE))
 		return esw_attr->split_count + 1;
 
+	for (i = esw_attr->split_count; i < esw_attr->out_count; i++) {
+		/* external dest with encap is considered as internal by firmware */
+		if (esw_attr->dests[i].vport == MLX5_VPORT_UPLINK &&
+		    !(esw_attr->dests[i].flags & MLX5_ESW_DEST_ENCAP_VALID))
+			ext_dest = true;
+		else
+			int_dest = true;
+
+		if (ext_dest && int_dest)
+			return esw_attr->split_count;
+	}
+
 	return 0;
 }
 
-- 
2.44.0


