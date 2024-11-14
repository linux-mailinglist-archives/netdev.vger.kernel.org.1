Return-Path: <netdev+bounces-145085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9D9C9514
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0A9282771
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33ED1B2194;
	Thu, 14 Nov 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X5wJE43X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280D1B0F2C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622271; cv=fail; b=oLmi2TC50wn/A+fNLqeramUzdl2TC1KL5dExYaoVr1nZuDJDAhknTSdTwcodByqcp1JleOF72EXWzF+Od0/Ah0ZCdXGO8bBnshNPfRRnKcZuu5v+H8eFR7Qu+iKvp/WtjhfvMjz4FFoa5aCpDV/fFACypueLFwPxDQd3mKp2hAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622271; c=relaxed/simple;
	bh=E+mp45uSNr4LpU+Su+zJQThKKCJyrkVTqp3GrJF9MDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS7aJ2ZqOnZR2ltjZg9+H2hb3CncIVYVIg5HOy0zYB2olNtxFoNY4tWlPQ6Yr8l2Cyc9wAY4TNvGO9uXXn25YkFMyC7xbujiGf/CE5qbjLsQUNlBknGLx+ubCgXvRbdBZ/Psvwjwk6viX59dUJjCpUV42xBvpj2YrMt8pwFPjas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5wJE43X; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAD6tnx3WKyW2+JHAbOL6yUOIvTHSRWbXFFDodquAyawxOJ4Dm/xJXtFrnLyUUXSrE5iGxqmZOWD/Jci7D6rsJIRIRJYvkUqOb+eHt/9Xsa3TODdvUJI8RKnCSrQ/gtENdP05Ge/go1qhKxUsPIxpRr2xZaXXCYnzrggWOBXQPPQytBWjIBCULQqLA6PeYmQKpgLDTQ04WpLqyCkSxfugdKf/UGr29lLWj+nDQrz147A4lpeZc3Y31uOQbyQWNM6RM2/HwR7Nl3+vAb7fcxF8LhPNJDlfq9UzfYdKDMg5FZ2r8DAwp7fS73p0ln5v9Ibu6uSR1wZc7umUMk8KUojMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=Xq+XQMsDe7pEuGgPZ4BuyNDUTwA5RyurxnF43GZOD7j4od9/3mHuFc1WFViwWdHXbLzhAkJ9qiyHKns7rM76dpygvhX/DBjiiGZYnHrIKr7uQEfna3ZO+ya0DA3nP6zWPaycIkyPToRs8U/dQpO1dH350z7YvjPdpBCbNhF8OalzJ0C2tTyrEQdiON2OJF9JLOfDTfb5AQApmDI/p+ZI+Qt7d1BRTQy4LAIoGFhvNR4E5W/NPLBDgaYNNYZAlrQFdbbkF1ExUh1hviAV6VV3qOkYPNf5DLF+GOQNYR+oolHrpVTpGxTq4rjZPOuamOzgFBvpk9AeYHQsCpxAfrxj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=X5wJE43XkqHvOXHlL7Lyn3DKsVokfmyPhMhAFQ0b5NLb2ulTQ62UB8cSSj7xdNuVJLDK5Bk2a1fFGOf8JIfaZCl8mhifSkj1OiKKpUFFjCm/iUDh34e0UIREXMuxIRFMK6CNH8Imcx+2BKK1hWxgaqxWKqGDGLU35E4rg6ruyjonEpOB5dCWf0h0G2LdMwsIMNgrIs2ww+ReRB0PwIle3xuK6gd2VhsZ3QeRiN/5/q2szAlTlPvnd09kFD4O7LB7FCptcyRU/7AQpruyZFQfY2xDM8xjQFrFXh3Cd6+Bu+USz6dLg7g4Z/So6dI82vQYuu8w7dMQru15pU6nVCisxw==
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:11:06 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::c2) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 22:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:11:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:52 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:48 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 5/8] net/mlx5: Add support for new scheduling elements
Date: Fri, 15 Nov 2024 00:09:34 +0200
Message-ID: <20241114220937.719507-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114220937.719507-1-tariqt@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1569a369-02af-4140-50b4-08dd04f93c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2mxpO8akVEwPIN0AMACKBZjd8Efrd4gs0I+7epf3y0tF728TZJnDc6+lRXBz?=
 =?us-ascii?Q?s1uwfQErN48rEx78xFicZcekQ0Ey2DJeS4Ew46tuaquvJj3oR9d1vdGBnyXq?=
 =?us-ascii?Q?8CO+ro/n0L1Knf05objSYQv8njFon9r2fI70osl3DlzYCgb5l1ZP8VNmCJUw?=
 =?us-ascii?Q?8XcQGhOLRP1RfS215ste3YPfZVk99oWOmmemrdQwd2I59EOXsXJ0qwA6xiFC?=
 =?us-ascii?Q?vpy3N7O56+37bsUevdCaDMoW9CUkgYpLWRvCporLQj+d+QaJ+IzLrycnjzX+?=
 =?us-ascii?Q?6UeI+XOTDX2BaBct0zthips8ukasaDw2J/6oUYiHnvHo6vOqMduqMCFmxm6y?=
 =?us-ascii?Q?pjjewtCqOtddGykTxsV1eBWsHH0OJBJshOYu9dSfDQSwkzreWpyGm5pF2p8B?=
 =?us-ascii?Q?wyNMhoUhnMlmlcBUBBYiecW0MQujhtR7ihvrwn/PVSX0TUaYFGzvil9Eukiu?=
 =?us-ascii?Q?45ixLDNLN7NFEWNpQjYrNyZnnKLHGG0B0UIAHylHLKFmmUv00Rfz3G2PWXwJ?=
 =?us-ascii?Q?H/6efWNdB8x5agwjhnz1UUhIbe70AfxqWSsUGJCbVqJ/xDY6Kb601fo6Q6AZ?=
 =?us-ascii?Q?Nrg9TrINgCe8aiMqU1tUGncmxxYE8szkoEVVL+TwiGzXRNTfk67LVnfxb/jA?=
 =?us-ascii?Q?DM0cJ5fXzpdCPdDs3XVH7ZlI91+oYP8qVJeDTmm177rlFckGJ+bFkd7SYfs6?=
 =?us-ascii?Q?oGx0+yiLfQQvj9V89M3Q5ZUwWVPDTYVAyU1E+102i145su/mZypkBumjGtxB?=
 =?us-ascii?Q?fxCSj6fJ1v5YNy14W9T5e9dmib+DgEunSkipvw6QbZby7NKgev7N2bm0ufxI?=
 =?us-ascii?Q?5+r0tkNWNdRB08QuE8Mp0P2SfVLz8xY/2kMJFvrHmERfcBNWmEgiXXQAiuuo?=
 =?us-ascii?Q?gM3JJzFenpqilxJMydBmncun9j48bZpbUVuc03K6botRsr8gyVwDsuRQBm4K?=
 =?us-ascii?Q?gCW/APuoJQwMJD5GNiupjNz+mOmsEypVUbQspVi/COlzftQIOn1auV2XTvg9?=
 =?us-ascii?Q?X1jYaqyMOBZxGKN6SvO9RuGBHrCzQ8N2x2MzoXKK0nag6kUmADgaooRx4Uxe?=
 =?us-ascii?Q?XqsUJlJysC0nyvZZQK49q2tvBvmIHoQ/RmFhI5Qw0rQfHuwqQf06yznW8wZz?=
 =?us-ascii?Q?mDz2XwQilAXerq/pEBNiIRDC6cCS5CgmntyTwq3CUvq6z8RiZ1YNiZnheQco?=
 =?us-ascii?Q?mVNxZ0aOiD4S+x5hCiKoy0q7a7sks8TOe2QypKTjsJfbREo82GWIAD1BDC4m?=
 =?us-ascii?Q?4Vph2kwugh7OGaJM/gPJ0hFzfcC/5kfDGBIzn72mKb0mDVAeSWrCsaKmpek5?=
 =?us-ascii?Q?2tcANSuoT6tmSzTqCnOS37Zra0R1h9skqPQRC26LSFOvAINPDEJZiguNZaOE?=
 =?us-ascii?Q?0pToJCYWuMfhSAawxkw3cvVPOxBUcSq8UNk8L1SX8LHahu77mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:11:05.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1569a369-02af-4140-50b4-08dd04f93c05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

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


