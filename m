Return-Path: <netdev+bounces-144514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D09C7A99
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2621F22E17
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2523C206959;
	Wed, 13 Nov 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L+JnLiLA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0D20694C
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520917; cv=fail; b=SdZuE7iZYLWucL6TbXiWnGcQ9CMvixLccxYBtgex88+b+vo3vyxrt6xRcu5Qw0FS7jd60upSWj+XPZ2e94ZjjuufpM8PY3X2sxaGR4EPKfK6mo+WUwmGbBQR1R9frz+rTLc2YYeADuZgp3UzRajNOOGLOuPVC6cuReOKrP+qT/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520917; c=relaxed/simple;
	bh=E+mp45uSNr4LpU+Su+zJQThKKCJyrkVTqp3GrJF9MDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpKlm755WCMQKxRg9ga9eGubnBIandIBVNgY3aN1uNbrmXZgdFC+T/E8XQ5jMDW2o+33eSUDtXo4tr0Ar/IKvtCgxhKwGtj5aCbjbvFbN9axmrVzl49ZGgl/lu4/QhCdauozTWtPRDIqNgtSGJFy/JAQemayw/drYiMJ59SlUuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L+JnLiLA; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Byc6b1mR0cmUtoWMv2yQ2d1DU4LK7S04KaSUWVVc9NWBX+slMucIFG1MVvU3IpmEHWfI/6ehgKA6TZL7a7BSui1pj1svB4+j2JPuJRjW1XFiStCvDJHPDeltuDm4a0pN7TXfuKksfEwwBDsObWrs7Guc/110jD62OO1N1N9ctP9t6reQK/IKvmZXmNuDjoKk2bLCzA/S+eikrx/nSZDrmhvc8cgYHwx0T5qEzbNi4lTraWKMs8H8x+CIzZX0KtetEZyxwGutotjqBM3AROKtqiQYuefnXB67P26OAuw+A6LqzOe1KzhLSxGyFfJm1Bgd0e+I1nJdCK25CviQwfNGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=k9vHYmOwNS5wkQ+H0zwXpaKvxPD3wUjSVVTA7Yo2xVpzCSUmYFJ4LtdFGaWUflU+yedVvojyPHD/FHavt9RrxqAAiH/c0TblRWr4N0aL4ntee4nuGXMO62w607/ZDd7PuK/jjfRfFKT1dPIwL1KSrrJ1oc3hVfWZ40LscLkIM6ogJNke1zNoYL3UrwULeq4aetyidFXVvlghlvViRjKYwaaRRxUfrA46bF1rv02OYk3833QvjzsjnK45yKQUyJjkSntI+hsIY7sdQlMCO2LpxTyLzM0wzOfO6sgWDrPLR4cxB1BDNYS5qlK6NeC440mvjYuGhW45CQ/xjZSoKYSoYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=L+JnLiLA18KldFlnkQAuV3TA5SJHAbHyYP+ydu0ZASubePPPeV1knrycP4rkB1xGAxsSdexFTCK2dsiS/BV7qjekFXCzlFdh4uSqCBJrpE5ij178BPVnxZv9CkahKpFW128zStvL7pkl8J2sYXtkaHSIZ3AEvPSEzaVkiO/ekvU4B6HQ7j5BBriHO0Yf0d2SE17SmbSoiw1hxiGOSAKlh7+nqyreeYXqgWqA8VtWqI1E0IJ1+DXeppuh0iPyELzfASMCld4o0Oh8HQ2J4EQoPPTA8wW0Lw/YmrWwkLnYnhTJ1IjjHmr3aE6kq3H/aoUvohhbAZSG5YftL+hBt8VxMA==
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 18:01:50 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::e0) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 18:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 18:01:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:01:36 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 10:01:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:01:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 5/8] net/mlx5: Add support for new scheduling elements
Date: Wed, 13 Nov 2024 20:00:30 +0200
Message-ID: <20241113180034.714102-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241113180034.714102-1-tariqt@nvidia.com>
References: <20241113180034.714102-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: dd274793-69da-478e-3560-08dd040d3f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MOf47tO3p6sjE4uXHXaEfQ6RxZwjRKfvtWboAByNpJ8npCYo16W2VJ0c3e7c?=
 =?us-ascii?Q?XJowO3ZmttRo+WfIFiVyck4AOkV2DsJN/bFnEgLC420nld+jffHpKl0KGsE+?=
 =?us-ascii?Q?m5sflwWsw7Meu8k2Gn5e3cwsONXsa9HGHjDNWcF0cbNFWTnOLsrTVveCE5dh?=
 =?us-ascii?Q?coa1tnTsgza+dOLfi8HEDrhrMI+pSaWeN+YD3MwxWoLofQUCs7L5I5IdicnJ?=
 =?us-ascii?Q?r8GZIFXrGk0oI1QGIqSGWeYrYntc4atlCEfR+9Bu+S+9BMCqGBcVi/rtiYwY?=
 =?us-ascii?Q?tKtWoF6qab2d6/EVYykCFT6Lxrau8P9+wJOOATA/NQEecou3mY4SCru4uFcm?=
 =?us-ascii?Q?WRfV3IPpTSHef+NAM/7k//a8tmWrL9MENZJ1wy146BtIE92/YRaEII2CRAsX?=
 =?us-ascii?Q?DE7mYC05tl2LDdTmVj5QRYwFPaeeO/NmbeUmDqQQJkTIEOVhGjiz+wNR76Ss?=
 =?us-ascii?Q?wD8xPvO7zMuqLbgisaaFdQNDNPJxt8CKr64r1aF76ZPQJTlu/RvxUSw9Yyb2?=
 =?us-ascii?Q?DRvrEUtCrk9fiEnfmrelVgS8CrKPAgP9hajBe34rrf74Y3Kmy41Dz6SyzHdv?=
 =?us-ascii?Q?x+NpXJ+CxmQhleKuFkqchW/CPk/MJfIilErg4/AWNgMwTpN+ZASTDtrq50/+?=
 =?us-ascii?Q?87bV5cdM6hSzapshBqpKgkxUorNNJaK/eSPalC5EBPQRdricgsBwWMxVgQT9?=
 =?us-ascii?Q?y8PCqBMiNcuUNDvKw/EsguLjysQypiGzEIc1MIk27io709eq6dLRJviK2cki?=
 =?us-ascii?Q?JyyTV51rxDsAkkRU+hDp/yCCCsj8KK+QUwKYOBzCGYruLwObbrm+Tnt1fF3t?=
 =?us-ascii?Q?Te41qyZPI6LWyZ9rzrbK4ncR1Wm0vOoDySdA4YqxOmbDozUWwNVzymuAdvUI?=
 =?us-ascii?Q?XhO1XISfySQROTIdQPiwt0RyS69a/o4mFGJoX8OUAWPCRygs9UqiITIL6sFV?=
 =?us-ascii?Q?F7Rswc7Zgec97TkKp9T3gusytNs5Pe4xAhubE22okV8XZZuJnK14Zr9e5k8v?=
 =?us-ascii?Q?qc6kzppFhS41B/Tu1sIbzUIj7p5PTuI1hmc0Cyyh0eoEpEGBGiXAWgKGR/Gj?=
 =?us-ascii?Q?qq+xxWq80UnLyuxw7EDv6syNcfH8wzG/Y7NbLcnvkCbjeHcp2HqPZY9XhAWN?=
 =?us-ascii?Q?aPPqzLEp6gxr3GpOmJrwjQezmt4yqguNs70jr+tmdGPSTqoGgCsk5Ug61I4b?=
 =?us-ascii?Q?eN2e8dWnHUY4j08o175jyvV+b/cay8LbLmpYYhtUSiVAc4IsdFTtToBSQllA?=
 =?us-ascii?Q?7q91GfjJUW9dukEnCzX6av/q9Gan4Hz0ahoJ36c5KLXGXPxBFecNNkJ9RY1S?=
 =?us-ascii?Q?fxrvlDKC96jpdMAOCCwE7pWgWjQE74+zpRICJUKpYZ/o2982m+aQwisOU5ym?=
 =?us-ascii?Q?NPi2Nf1BBQxaOJuUkEYhWMxtSj8iJaxQSh3Q9IZEW3skq3+VRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:01:50.1056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd274793-69da-478e-3560-08dd040d3f80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

From: Carolina Jubran <cjubran@nvidia.com>

Introduce new scheduling elements in the E-Switch QoS hierarchy to
enhance traffic management capabilities. This patch adds support for:

- Rate Limit scheduling elements: Enables bandwidth limitation across
  multiple nodes without a shared ancestor, providing a mechanism for
  more granular control of bandwidth allocation.

- Traffic Class Transmit Scheduling Arbiter (TSAR): Introduces the
  infrastructure for creating Traffic Class TSARs, allowing
  hierarchical arbitration based on traffic classes.

- Traffic Class Arbiter TSAR: Adds support for a TSAR capable of
  managing arbitration between multiple traffic classes, enabling
  improved bandwidth prioritization and traffic management.

No functional changes are introduced in this patch.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/rl.c |  4 ++++
 include/linux/mlx5/mlx5_ifc.h                | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index e393391966e0..39a209b9b684 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -56,6 +56,8 @@ bool mlx5_qos_tsar_type_supported(struct mlx5_core_dev *dev, int type, u8 hierar
 		return cap & TSAR_TYPE_CAP_MASK_ROUND_ROBIN;
 	case TSAR_ELEMENT_TSAR_TYPE_ETS:
 		return cap & TSAR_TYPE_CAP_MASK_ETS;
+	case TSAR_ELEMENT_TSAR_TYPE_TC_ARB:
+		return cap & TSAR_TYPE_CAP_MASK_TC_ARB;
 	}
 
 	return false;
@@ -87,6 +89,8 @@ bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hie
 		return cap & ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
 	case SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP:
 		return cap & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT:
+		return cap & ELEMENT_TYPE_CAP_MASK_RATE_LIMIT;
 	}
 
 	return false;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cf354d34b30a..87ec079ec83f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1103,7 +1103,8 @@ struct mlx5_ifc_qos_cap_bits {
 
 	u8         packet_pacing_min_rate[0x20];
 
-	u8         reserved_at_80[0x10];
+	u8         reserved_at_80[0xb];
+	u8         log_esw_max_rate_limit[0x5];
 	u8         packet_pacing_rate_table_size[0x10];
 
 	u8         esw_element_type[0x10];
@@ -4096,6 +4097,7 @@ enum {
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC = 0x2,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC = 0x3,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP = 0x4,
+	SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT = 0x5,
 };
 
 enum {
@@ -4104,22 +4106,26 @@ enum {
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
 	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
+	ELEMENT_TYPE_CAP_MASK_RATE_LIMIT	= 1 << 5,
 };
 
 enum {
 	TSAR_ELEMENT_TSAR_TYPE_DWRR = 0x0,
 	TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN = 0x1,
 	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
+	TSAR_ELEMENT_TSAR_TYPE_TC_ARB = 0x3,
 };
 
 enum {
 	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
 	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
 	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+	TSAR_TYPE_CAP_MASK_TC_ARB       = 1 << 3,
 };
 
 struct mlx5_ifc_tsar_element_bits {
-	u8         reserved_at_0[0x8];
+	u8         traffic_class[0x4];
+	u8         reserved_at_4[0x4];
 	u8         tsar_type[0x8];
 	u8         reserved_at_10[0x10];
 };
@@ -4156,7 +4162,9 @@ struct mlx5_ifc_scheduling_context_bits {
 
 	u8         max_average_bw[0x20];
 
-	u8         reserved_at_e0[0x120];
+	u8         max_bw_obj_id[0x20];
+
+	u8         reserved_at_100[0x100];
 };
 
 struct mlx5_ifc_rqtc_bits {
-- 
2.44.0


