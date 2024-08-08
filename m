Return-Path: <netdev+bounces-116704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCBA94B66E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDC4B21D00
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FF82C1AC;
	Thu,  8 Aug 2024 06:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kn4dqR34"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1813CFBD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096891; cv=fail; b=a1Cq9co0irwuk9kL29Q9rRFuSs59HWDSN/WU3upUWNrv5uvOJuLy5ClJA1bQlF36sD5++92938/Qi0jPNV8R1vxyxYVZfAV6j5bsi4RHhVBeh+X7W8YWPR7+VXtbX9ecsFgztn5aNbnlshcmTI1xe08xp4gWva3Q8sAoQA1sdxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096891; c=relaxed/simple;
	bh=14Mfjx2KYmGcKHUeF6uAMhKJStDDKIhRsIkub5fbIis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIaEJMEmP4s3NbM4Em1aYDa40ksLeJ+mn6PsWiygeQNr6AYSPRRBpi7TCAdl6xsD8bktONMf/BRTuxmvkMurLLgOv3Ji4ce22D4JJkkvBoHS240gdlmsP64SOC1LoThamLK9XLRUxHn3yJI0fX9Sb9gAteUN4KgOwrSazRZiT7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kn4dqR34; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maF3ZvTX1zseL5PoGe0Qaq28OXzFTL/XZC78iP164vlcEicQlUXyimpP807O5VLUOI1tllqQuGb7RUMFbZlq7C7mFsIP2geHlqxz7mh42umuHsxGUjLJxUFPmbIyr1SrM2zjxtFgZaV3+dqyS8rA0dpXLulFhPnNm3OwASRK8RIVzdikLk1GmU31DdM4FKggYaki2gP99QGMh1ATMmm/KVi7jeO+IPxEYP4BnLt0zaxCek86VG0LUfRuiME9vj5lazga9+xQ7MGMC+7LeyUo+GBpb8HqXH+VVhLbAjoC2OPZNofQg8fskWjpHovItCDNqrZ9VbjyFuXErBoQ411H7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HgOyTCRBIFb8iH+CNAlb69+yaguk3+v+7d8wvveXdI=;
 b=AqtWD53JlS3TPgCTOz4+UQOntSWDJJlcwd6sEJd3ETpVJyX3R2C5xvXnw6CFlkDQft1+XGDhbhEdoNPK1npSjkfEtNjdtEz+cTsT6P7eCYR9Wa/5N0P4z/Xgb5IW+6/PT02su/z7I+lY1Ddd1qAzLgcha/5Gg219cQIVnZVTbgIvMKGMxqIZy04Sa70pUrwrSM4MlrOwijJ7pMAKsKGDZahT5QKnBXyx5EPUiOlUn1k5T1ZFqPt/CjZLxOcus9iYxUiiy4GjqbrEYz0PeLB/QKCQOC2v1AgH6eE7cCBZM2hCQeSDbaFqsykSpObmTCDMHenZ+vNDo4Dx7nU6nwzg1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HgOyTCRBIFb8iH+CNAlb69+yaguk3+v+7d8wvveXdI=;
 b=Kn4dqR349lBq+Ibw0cGA+iq4nD+rsulrWN4lkJGiouilULwAOn6NKQSjlMxjrpQxhYycIpB3Tm2KHlsGFdV1RU3QA1gBiOH1OsBDh9pHPyLv/jPWQdn5WMtB+4pzNmWlmg6hEcLUm7JrHavdZsjIN7suAPoWZQhHuinqanor7MLpj1hmzqmt/Eq330wwuyrEdmnftmxdib0x2My3eFAicDlQ1fkQHn2LhwLWR8kdjqkPIG6ufABqR/SqQWb3K8dlj23JQpBzE98ifY3sM3LEzEAKqKCFm/Yvd6OzeV9rLZtA8c9Mh7ChwAnALs2fWlG90n5ynkYk4AYwdwvrnx8f+A==
Received: from BYAPR03CA0036.namprd03.prod.outlook.com (2603:10b6:a02:a8::49)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 06:01:26 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::92) by BYAPR03CA0036.outlook.office365.com
 (2603:10b6:a02:a8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/11] net/mlx5e: Enable remove flow for hard packet limit
Date: Thu, 8 Aug 2024 08:59:18 +0300
Message-ID: <20240808055927.2059700-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 94675643-cd52-4290-0d3d-08dcb76f89e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORWznJhLVjyo3X//4NQvk+c8T1QynLTTaRxyl0Ioybga8Yk0wP8/F0/tyqeF?=
 =?us-ascii?Q?UmZm6QjV1p8b9A36bPvg6L/VIOwThH5QzmxoYhawMkEjjJzovYz0FMfRCut1?=
 =?us-ascii?Q?fr/sH65Lr0tz4hcoonR0lQnP36biZw8narO/iT0IYJ3wFWjTPO0jGq9nooWY?=
 =?us-ascii?Q?g2+nc9l/Y0CdZKI+GfYUm2PkpeoKHkt6h7lYmj9CwwZz1Q4M7Pm2+aajZovD?=
 =?us-ascii?Q?2nGg8dqVvi7rcoydK/nzvWcThwdWxyosEkDsDYGqRXqiqpPeXO1k4aEU3ayW?=
 =?us-ascii?Q?dFJpihiFwhz7G8zaT4zS8SsA3NRrUvkIxJUd/6RnP5rbqxMdEs6hAm+OTXCi?=
 =?us-ascii?Q?UXJoUlCXIIjiYBOy1TVpGzGkF2PeTy/KdnOyCOSxl7VlTlUsskMY4BKpuIiE?=
 =?us-ascii?Q?1LnH0e/yCH2vWNoeZDJ8/KyKb3ygLgIbo2z27QsLP1XqxRLpTfUq0gQyNMWP?=
 =?us-ascii?Q?3bAaGK/Qo/QawII4wkdXtQ+eZquADm5Gh9IoFlxmz7fdOmKDBkNbr7dsLmF3?=
 =?us-ascii?Q?DhMb8YwB7MHRFRpFfmaGNsdG3RZXpFfh0DsjTScUlYsobY2JuP2eLQ8Pudpw?=
 =?us-ascii?Q?rwV2kqvPC5OgNDT4JVcIVwIBWqD+Am9FjdJLPYjv6b6Txywd8inVYFXzLPXZ?=
 =?us-ascii?Q?m7NOe7IwGvr3V+cEHkYTPdO3I+AlClrnk3llxaMv86ObrOOQTCJErEBw+ymw?=
 =?us-ascii?Q?k+TWluRF6UEzke9o80VCIbojSUFsfPOnKAYyCQAqM48QtY+vu/MZ1i8C+jgW?=
 =?us-ascii?Q?D1lu/gKp9+vM/6e+G2fm4vQwl9eqA07DzxkLqOcPzf2tkvDSKjIJajPXOFME?=
 =?us-ascii?Q?urnxjW4OaK48gAXcGDOhIByAG+zMY6Ae+9FTmaYFFH2oogDRiSAfVDkuxW4Q?=
 =?us-ascii?Q?tu8MLiKBxx21+99Laum+SP5V0PfqfnLhRhQZCur5esAY9d0afa0r5/wGxyiO?=
 =?us-ascii?Q?bvy194J/zEVbynC3txq49dfELwN8Z+Pkj1avfPBqkfpJxi0VXWrmgniZwWCY?=
 =?us-ascii?Q?jftRSkpjwNXf4xpMZjQH6ybF8/fHUGk7TNyf87kGqRgTQf9T/htljomy+RV/?=
 =?us-ascii?Q?jxzR7Rqp0dVeFPN9XHpBIOutIJQP4mCUmBt85iCTj5p3Mq+6qBK5/eXmQhgK?=
 =?us-ascii?Q?uCvjzcy/2B+FYvrpX4BSslJF+QKFm4AElS8PRj3N1m0FFPs9K8nM8zyURkyg?=
 =?us-ascii?Q?ds9e04wfr4w31B6XjY0fGe6v6O0odg15PhKQ9D916cVraa5hPXlDTTGAXUA9?=
 =?us-ascii?Q?zs5Nrg1W6jQoxiHxuraNklr6eRwFxN4DBJM+IrsxVGooPE9ItXM5VK+ZMuKo?=
 =?us-ascii?Q?uT+Dt6Ca+XgW51qj5i5JpA6K5RnhJ4BVpSOVlmeoOLhDohrRKM3wM+tttckJ?=
 =?us-ascii?Q?HKOA5MCYl1hitp3c4teRIefaaVPwEk5ewZV17JNm0S7fJq0AHPxmDxPAtwcL?=
 =?us-ascii?Q?MDki4NHQvdi1gT/ncJMCQCtSla8SJrMB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:26.1376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94675643-cd52-4290-0d3d-08dcb76f89e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

From: Jianbo Liu <jianbol@nvidia.com>

In the commit a2a73ea14b1a ("net/mlx5e: Don't listen to remove flows
event"), remove_flow_enable event is removed, and the hard limit
usually relies on software mechanism added in commit b2f7b01d36a9
("net/mlx5e: Simulate missing IPsec TX limits hardware
functionality"). But the delayed work is rescheduled every one second,
which is slow for fast traffic. As a result, traffic can't be blocked
even reaches the hard limit, which usually happens when soft and hard
limits are very close.

In reality it won't happen because soft limit is much lower than hard
limit. But, as an optimization for RX to block traffic when reaching
hard limit, need to set remove_flow_enable. When remove flow is
enabled, IPSEC HARD_LIFETIME ASO syndrome will be set in the metadata
defined in the ASO return register if packets reach hard lifetime
threshold. And those packets are dropped immediately by the steering
table.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 797db853de36..53cfa39188cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -127,6 +127,7 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_pkt_cnt,
 			 attrs->lft.hard_packet_limit);
 		MLX5_SET(ipsec_aso, aso_ctx, hard_lft_arm, 1);
+		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_enable, 1);
 	}
 
 	if (attrs->lft.soft_packet_limit != XFRM_INF) {
-- 
2.44.0


