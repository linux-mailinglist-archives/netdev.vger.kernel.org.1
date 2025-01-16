Return-Path: <netdev+bounces-158963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F98A13FA3
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD2E3A9C02
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13922D4DF;
	Thu, 16 Jan 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="so//WlJE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1F22D4D8
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045587; cv=fail; b=i9A+ZQn8CGrm4sTNpyoubwopuMKjODdTNYL076w7W4HyDpMHnQCPBTd45mgTFnYLK6pCNHhkr2lE0u9fXUMx+ZQO7ivqB+gHBkBOaITqP1vk5YSA5owcB5S5QdFtVZ/s2x7LFfCHwSl4n8/yzvMyzGHeG4Ke8edLUA2Mtd4GC9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045587; c=relaxed/simple;
	bh=UsYTviFx1cYksipEIaNz2JxCeG8mYyyov3glXRkvie8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oZbzEdge0bTSnRjHam62lOfRVbxqaMsT+sP8lMRGmzX9MieDfFOA7tgU78Mv7PYqjUVNcztptuBNj4w20G2j8TfxrTY+8Xq9pnmjYIWat5mBF71Wtn1KBPz44BEeQKtKpAmIqNLRV21QP2KkxTbm4IytwxaR/vyL4b414zfxjrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=so//WlJE; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6AE7+PV5eZgusnVw1aZuzZf95CxzbnrNWx/57GIAYghCQJHUv6M8Rfpl+rkvJJJOTip6aQ/LYMzPhFeDoQZOVbUXTUcSZWoo4m6JBDKadG6Ri5SftL2o2oKMzx8zM8jyw719oY0zLwyRjoGfBXcB5DsS4eVxtMndhS2mqjKRV6FSL8MRkLgalxblSHgwtYwEKfsME+PrqqqUu48AVPfulbwIhMUNAzi9lXAafB8/d3Mlh8vBEmMTUsIjTu+Rh0kJQMtu8GrlLwIkfUptceDvhN4GlQijmux1PeGC7KU5iYWL1nBDLM2JmlWWm7DKbInibYCqFQJIZUlgbYMsOdlVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGQvpw9g0ylfS6tS44FsLdMXFHcXlk9o9a9I66cd8IU=;
 b=C8k4z+IsVk4hzre/04FePWj8wOom99KotPhy2QWfhtWW+p++FsSAai3pT2E5twlphwGbdlO5PoE0l8jSNfHOPImfp7mltA568VH9rtEAZ4kdGcvmJRK7apCsjkm33ZK762tlygaYN5FiQjzpoJbyPh0wxTZFN+IjY2zJXUYhOQeszjpbteWJMAOsZT6I2UfQRVNYlh3enuLcqZ0yrWBl30VLc9onPjCrtBGZdbzh9bJvZd7ds8j60jou+DKJ39j6MC9THbF+PcSsxwRpXRwh3oX1JABX8+BnFRXLrvzVqb1BZHieLgH9ca/4kFbNnMKsW4hGHuJzYtK4k2mred2/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGQvpw9g0ylfS6tS44FsLdMXFHcXlk9o9a9I66cd8IU=;
 b=so//WlJEhpKNfqE4IPsO91KZ+blxm8Li/DQiNucXZgSk4MgOysBDiDHNnkUZf7D32xaGnRu+Qf+ovEcQ1ysJ9GVw9VPu7Az0DZGglP4JvkCZi2AAPsHeAfcUOagZn7CCJtiggWSDGB+cDWaWjlVhYP+7of5Z7mVo1Ja0qLaFcmmyH8ViVUHljZDd4mpxWoyaNQs+33hffLoswn7APJOqOfEJPts5XOBqpZy0otp6MPnfV2bFxHutw+PoYm0OOCNu42ujkRmQIz5jydlXxmZdDZ4ikf88B2qfPZkN66Jx9J/HpDUOFvu4klp/utonlPnfEuLlhVAKJApZY/OxTao+mA==
Received: from DM6PR18CA0008.namprd18.prod.outlook.com (2603:10b6:5:15b::21)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 16:39:40 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::6) by DM6PR18CA0008.outlook.office365.com
 (2603:10b6:5:15b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 16:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 16:39:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:23 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 08:39:18 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next 5/5] mlxsw: Do not store Tx header length as driver parameter
Date: Thu, 16 Jan 2025 17:38:18 +0100
Message-ID: <1fb7b3f007de4d311e559c8a954b673d0895d5e9.1737044384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1737044384.git.petrm@nvidia.com>
References: <cover.1737044384.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6de60c-427b-4c20-1974-08dd364c5f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNKUDpn09GnnKNLX4BJnNALQe040zvPA/MPDtuV0rRO7y1oO/GI+a3Focbb9?=
 =?us-ascii?Q?FEiWE6ExqWHdBfpUs2Q7/E7ZolPSlROaaq8ldT5VJoBBdlTFuf3cC+72idfb?=
 =?us-ascii?Q?5l7+rw4XqwaG9z1vkhlthwxKK8hvXRNSIt0ZoLJcXlr/SFEtu+BkDrHHMCQ0?=
 =?us-ascii?Q?KIwHBS2mw5ENvMSFp4P+O/grnoB+JM2GhE0DZGpn6rl5OywtSkB6suq7vE+z?=
 =?us-ascii?Q?V3xOoNLndO7do6rp5uyhJ0d/Mdq0seFiMCukKZ0sEwPc3O2RRpGWmEEM68yQ?=
 =?us-ascii?Q?laKCw0OkEHpJinZZ1kLCqo8Af/HXiGaFxMuxY9dQ9NTz5WUKQ+3A97u5sCc/?=
 =?us-ascii?Q?fqeVNXUCPGH7I46m6e7KyUqqHun3eqMvCNXnBE7Jorp36zvQjjVIQFDMribY?=
 =?us-ascii?Q?Cggz0SZWX5aTQTPkC6jX0+ojP1IOwe7/3yj5uEGfwyuQX+MHwFyLPKqPxDfz?=
 =?us-ascii?Q?rfLzxAY5R3jBGjHqnH2npSjJ6bQ5GrumpiBt1cSMLobnH9okNYR2oX7UamHm?=
 =?us-ascii?Q?8eRjFrXSX1GEkYDDUrFmg6qG0gTf9iJKEGmhrVJYvYJwEmL8SLKlnJZ1g5B5?=
 =?us-ascii?Q?8mYPkMBZIioWjnoU5xqekw+uAyHiAxFI1AayHVgT5u6OIukWAeapzJFfvGY6?=
 =?us-ascii?Q?Qp13FDmwToaYxcsquU/sb8Ykmrb3HUCFSVN+b3fZskn4O1kTUSOp74DfWpZl?=
 =?us-ascii?Q?Y0Itlxfpux9gCgP/Lhn5Vhup1XnBLGGXdc0X6fRRD8Xw2STd3rQk3gT4j1vP?=
 =?us-ascii?Q?zcyGKFJe4TfRMR50SvS2KGFv0BrumHd/kL7ZEbdk1+d8ACN1ndTDusc09N6B?=
 =?us-ascii?Q?dpkv1DTy+BZz1lGQvYmPIx/b5ETytTYiwaTNz9A6t8QUm+PAmbWAthLxTC08?=
 =?us-ascii?Q?jof1KVyD9OL+TQDFnIWwWAdTv+jSfABF71qN2ikmWw4NvioOkiMiWk+VZRz+?=
 =?us-ascii?Q?dZ8Es2lc/vh3guO42Ooro/F+UxUUfeEhvByH/glGG6SuBwzBVwuC5HTmlyhU?=
 =?us-ascii?Q?dRpYfvA7CyE4PXwjheZdnBB2ZLrQWIJswzYrkrm6V1cnw3rSLRl+Xa87SEhF?=
 =?us-ascii?Q?dYicr6e0PMxuhDhUxGFpY2OHjG41YbH2g05Kljsck0xZtyYIb5tckCI0fkUb?=
 =?us-ascii?Q?D7ClzB368STJ+UB7WXyYdObokPTtwb2CVgqGRNAMgqv0hOzaKnhdAiU/J0HO?=
 =?us-ascii?Q?HaxaIam6cQc4wB2oXJJLTLLqhdSJjwE2a6fLgsXL50/sr4UAq1uypIZrwmPy?=
 =?us-ascii?Q?gsAqvB7kEQ37v6ZqRdM5x3f9PXCX/1ZS1xEgzEsI/tI17Wtwkp0a16QxSFI4?=
 =?us-ascii?Q?ZtLa5/uizWaJ0KZlU5zN9XL3hNM3GmK7ZDatb3dP0A67aYQBaUT6eeKaVRrR?=
 =?us-ascii?Q?T4Cl4pfrdeiiSUoTQYQQ5FqSw7bcKPHUKzHE5sBE05Nuz+ZDCV0MiTyRNDiS?=
 =?us-ascii?Q?1o5UScmHQ7CGvBbS5dp+3eUx4UZTHVZuMZYrYbGeTLRPZ7onm5iI1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:39:39.5558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6de60c-427b-4c20-1974-08dd364c5f0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

From: Amit Cohen <amcohen@nvidia.com>

Tx header handling was moved to PCI code, as there is no several drivers
which configure Tx header differently. Tx header length is stored as driver
parameter, this is not really necessary as it always stores the same value.
Remove this field and use the macro MLXSW_TXHDR_LEN explicitly.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c     | 3 ++-
 drivers/net/ethernet/mellanox/mlxsw/core.h     | 1 -
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index 39888678a2bd..2bb2b77351bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -35,6 +35,7 @@
 #include "reg.h"
 #include "resources.h"
 #include "../mlxfw/mlxfw.h"
+#include "txheader.h"
 
 static LIST_HEAD(mlxsw_core_driver_list);
 static DEFINE_SPINLOCK(mlxsw_core_driver_list_lock);
@@ -943,7 +944,7 @@ static struct sk_buff *mlxsw_emad_alloc(const struct mlxsw_core *mlxsw_core,
 
 	emad_len = (reg_len + sizeof(u32) + MLXSW_EMAD_ETH_HDR_LEN +
 		    (MLXSW_EMAD_OP_TLV_LEN + MLXSW_EMAD_END_TLV_LEN) *
-		    sizeof(u32) + mlxsw_core->driver->txhdr_len);
+		    sizeof(u32) + MLXSW_TXHDR_LEN);
 	if (mlxsw_core->emad.enable_string_tlv)
 		emad_len += MLXSW_EMAD_STRING_TLV_LEN * sizeof(u32);
 	if (mlxsw_core->emad.enable_latency_tlv)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index d842af24465d..1a871397a6df 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -444,7 +444,6 @@ struct mlxsw_driver {
 	void (*ptp_transmitted)(struct mlxsw_core *mlxsw_core,
 				struct sk_buff *skb, u16 local_port);
 
-	u8 txhdr_len;
 	const struct mlxsw_config_profile *profile;
 	bool sdq_supports_cqe_v2;
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index d2886a8db83d..d714311fd884 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3890,7 +3890,6 @@ static struct mlxsw_driver mlxsw_sp1_driver = {
 	.resources_register		= mlxsw_sp1_resources_register,
 	.kvd_sizes_get			= mlxsw_sp_kvd_sizes_get,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
-	.txhdr_len			= MLXSW_TXHDR_LEN,
 	.profile			= &mlxsw_sp1_config_profile,
 	.sdq_supports_cqe_v2		= false,
 };
@@ -3926,7 +3925,6 @@ static struct mlxsw_driver mlxsw_sp2_driver = {
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
-	.txhdr_len			= MLXSW_TXHDR_LEN,
 	.profile			= &mlxsw_sp2_config_profile,
 	.sdq_supports_cqe_v2		= true,
 };
@@ -3962,7 +3960,6 @@ static struct mlxsw_driver mlxsw_sp3_driver = {
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
-	.txhdr_len			= MLXSW_TXHDR_LEN,
 	.profile			= &mlxsw_sp2_config_profile,
 	.sdq_supports_cqe_v2		= true,
 };
@@ -3996,7 +3993,6 @@ static struct mlxsw_driver mlxsw_sp4_driver = {
 	.trap_policer_counter_get	= mlxsw_sp_trap_policer_counter_get,
 	.resources_register		= mlxsw_sp2_resources_register,
 	.ptp_transmitted		= mlxsw_sp_ptp_transmitted,
-	.txhdr_len			= MLXSW_TXHDR_LEN,
 	.profile			= &mlxsw_sp4_config_profile,
 	.sdq_supports_cqe_v2		= true,
 };
-- 
2.47.0


