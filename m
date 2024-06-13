Return-Path: <netdev+bounces-103399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F95907DC9
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998E81F233D0
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB113C681;
	Thu, 13 Jun 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTWvxZmf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD0E14374D
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312549; cv=fail; b=nPwSNzOOvNTKyf69NBsqsjiEv57EOj/GetUV4PSrJVDqUGNrf8lHtnrw2ZIZdYbWHNxEQXxayfHIbTfz4p+ZMrNZfpt7c/JUCYSICm/GghEXx48VhbMZtacipjTRJoNN8GRiVn425Zh6H1iOqO7oyq3s6V+hDvC8HvwiPXnJxTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312549; c=relaxed/simple;
	bh=Alu65muSbvKZsh0c5yHd4PqjJaS6jcPdACyGqwuzGgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImqABwnPjauem4aSOgBrR4wGPQLY0/T0AMgV18LJ/j2ZPbcydoNMf1dv1VHzPd1UyeI05396jFBN9RXDoRiOZjHZQjRUpSMF3cNp2uIcjhKO/M+Ym3l+3Cb73Wh16aT3usJ4ChclC8v73wWFEuSTh6u9vh52OjWbUxLnSyWQjLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTWvxZmf; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZOMJoG8sBk42ack5I7m5rBKRAT5kAMy0MivXbKI95poM+pKdPf4ihNVXLKQuhi0nGtTzxzEZUR6ihzmEe4l5F7EIoA+s3urlAYa90e7bJoveW+m3rWrpF9RW91UbemTlgeRO3um5UIW/qO8WZs8OjzWwROKAOCE+N58qgvCFVfuh9NEwfkvoSIfqkK1nSpoBlhSNIuUk/mnB6kyTM3L/r0YygU6TGTXXBAoz4msdExibeGqWoIXe/Nd8G1b5Ja6WqUxwZ6i6ebk7AnLBzKocBjcr62c0iOloXb6Q4BX5A1elReK+Lv33vhYVprV99sGBKo6kR3k6RkUFmYD40bnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCxYEAyehNBBTrJHsYWV2fC9tf/IAbR/GgEhszse1SM=;
 b=HeMzSVYtApAGaOgdNImS1apUqvBLIUM4axlyk3OQ0OHYZ/DGOkQRcp67PBz3D7YJRwMSBqqvqUnrDlu5147z72IrvJ/Gsh71y8wHBggOqHvUrEujUXLqEhmPpuG+PVlkeK9GI93V1rpAzxFTlDo3xQz2LJqZvEjb286yl8tt1W4zjnqlVoLSgDQ7vx+Lv5UBvaeYopZKcYBNmkOFsfFCdM34vbdGEWk0HuQrTvamtwtzMsg1z7BL0o1uBgUAsUN0sClwDahVRY8SvvdH71ua5fCI43P8jYD3R6mbeYCBbgrGj5Il2qkWPDwnq57saRvxe2XkffESjN48Y4aB2U+F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCxYEAyehNBBTrJHsYWV2fC9tf/IAbR/GgEhszse1SM=;
 b=BTWvxZmfgrH+lHsUaBcN59r4iJ+ANSC/Uub4pl5teioDuxujjJwsMyIV2iDbCGR1LzA63ufTbzETxJaVMUtkJbMCckvoRChl+DudEVwTk3RmFYTmCCL5Tw33vYVOzPEL//RV8a0HZKV9nL+N89MJinW2nuahP1HVt3pr5/9HPplps0xHNNKyvPvaKLZ0ZietRIxhmQ8GigSGcMB7vz8LV6Tr69ZS2pkpJYrPmL8cEHTa+uESmzZ7TmneJ8Cq5O1kpOqJ472seWviYlNRatf9pDqAiF8VnqKdD+Hww9L/YbrStp5UQhMYRGCdF1a+BPBQzVJJXc6In0EX7mjFF7O1GQ==
Received: from PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::6)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 21:02:24 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::10) by PH7P220CA0047.outlook.office365.com
 (2603:10b6:510:32b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:02:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:02:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:02:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 6/6] net/mlx5e: Support SWP-mode offload L4 csum calculation
Date: Fri, 14 Jun 2024 00:00:36 +0300
Message-ID: <20240613210036.1125203-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c22c787-4eda-4f5f-f02f-08dc8bec1f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+SS5Ai6ilHZ+KMD0q7uGcXD2ZxRYFCIX0IukeCJkDYJDFZaUj36rN3Nvoem?=
 =?us-ascii?Q?h35P7JiP+YUCZ0d0u1vgKwjbzT1q+MopIy+Bu4lB1Lbe3U1/VBNII8IZeGcI?=
 =?us-ascii?Q?BnnEOTlX9KIwS9XpWl5e7yQlPecqMbnxmxvtsptDXSVMyMLk/NlG3JpSopIa?=
 =?us-ascii?Q?ahNArFOkjz4ZUbjJGXCFlv8KL08n/cG/kMTUtgp+A8LX4xiwBgBjFmks9LUi?=
 =?us-ascii?Q?W67JvUalj62zSmnh6V7D0z+WYDzOrgagYmCMjd51Bie78Xyq93olMmx1UgAk?=
 =?us-ascii?Q?OjzAV8tBbCoFc66eXdQhfdlO+i2TdxxXYJrsJ84l2/U5JOTcV4LENu8MJVCT?=
 =?us-ascii?Q?a9/7gKJn/m6/c9kTi7CPJDT2nsFEdh3VEJSP2JftxvT6XzIueBmIiUdUA7Rr?=
 =?us-ascii?Q?0vZM3CRKT4kMBSCKGwAf03AU4PM0BWXbrHvkBVVScMfbCToq4dmKxmnfDp5s?=
 =?us-ascii?Q?vj6YkPF62Ocxnn6ROxknCOEojqr40xEZ/z9rP6X4QRfb1qvjGS4ELDpxyfnK?=
 =?us-ascii?Q?IWRPwoS1NV3etC7DnSYgX2MhuHhOz0k4tLi7Kg9vO4clvziF2LpgxPGj4OHK?=
 =?us-ascii?Q?+920zzHpf5f1ikDOhlD/l2vBQrHtrFcJSqH+qYZPE6ArSZmamLZa4jYEZqRL?=
 =?us-ascii?Q?Rm/0pLsjOvkkcHiZVGE6ekajePdseQo07E+aTevSsujFD/knS9DNs45+Bglo?=
 =?us-ascii?Q?z7Q2G2Ftep9qCUtbNs77JTBa5acifSWtoh5XLzmm0gCnQpthHDfAfWq7GyYH?=
 =?us-ascii?Q?t+fFkxGzyGoP0cLRITica5W3WoWrUobgoh/wOqIPlfBx0bAolVfea/kq/tEH?=
 =?us-ascii?Q?nikjhWoP4tzbEFeBG9gwHXDqjkNBjmICJqTb0fc7863IryucZv0xLbIrubbO?=
 =?us-ascii?Q?ZmmSEUDm/HmlphlGZFZR7RjolAEizmb7gDYBExBHSyV1XUny3RNnQQWqjqPV?=
 =?us-ascii?Q?Ad2YjYoGvNhgtqHYW8CgpsaEVzVzTEeD5pKUl5j7puaVxm73Lo89unLTdOEY?=
 =?us-ascii?Q?CBo6v6fCtwc1vxVPuiW+dce8GWYbaS8S3HhPrRRgVFu65rQu9hY0GAj3YB8M?=
 =?us-ascii?Q?DftfSEeHDm87FyrreWX/o02CBEGtmgr2Z4Apjz9ykGR76RroTMCXs3wopyin?=
 =?us-ascii?Q?w7eidrCOkQjr9GwlZFLh5S5GxmuBsWnBhJddLghu0hDirvndwng0uqWToGJP?=
 =?us-ascii?Q?jRuSrlGyP2+ftIOiHB7BZkqgFhMdH+UNOHo2JclKIKc0S3EpXXXB/eB5JJkM?=
 =?us-ascii?Q?TmerRuDhm3eQUorRYZKBJ2XweguFGNuipvaokCXkOT23h1LWi5FVxZtT4Vbi?=
 =?us-ascii?Q?9FgkfYt8izIwIjggucoeaJhoPibulYGFuOv8Ito6hG9heT4HfzQ6+j5tF66G?=
 =?us-ascii?Q?cZ+HGVQe12RzZk6ueK7+mw+SBJiHF+v//Q5trkD4Ld6tJLi4Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:23.4056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c22c787-4eda-4f5f-f02f-08dc8bec1f66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Calculate the pseudo-header checksum for both IPSec transport mode and
IPSec tunnel mode for mlx5 devices that do not implement a pure hardware
checksum offload for L4 checksum calculation. Introduce a capability bit
that identifies such mlx5 devices.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h | 37 +++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |  6 ++-
 include/linux/mlx5/mlx5_ifc.h                 |  3 +-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index d1f0f868d494..5ec468268d1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -6,6 +6,8 @@
 
 #include "en.h"
 #include <linux/indirect_call_wrapper.h>
+#include <net/ip6_checksum.h>
+#include <net/tcp.h>
 
 #define MLX5E_TX_WQE_EMPTY_DS_COUNT (sizeof(struct mlx5e_tx_wqe) / MLX5_SEND_WQE_DS)
 
@@ -479,6 +481,41 @@ mlx5e_set_eseg_swp(struct sk_buff *skb, struct mlx5_wqe_eth_seg *eseg,
 	}
 }
 
+static inline void
+mlx5e_swp_encap_csum_partial(struct mlx5_core_dev *mdev, struct sk_buff *skb, bool tunnel)
+{
+	const struct iphdr *ip = tunnel ? inner_ip_hdr(skb) : ip_hdr(skb);
+	const struct ipv6hdr *ip6;
+	struct tcphdr *th;
+	struct udphdr *uh;
+	int len;
+
+	if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial) || !skb_is_gso(skb))
+		return;
+
+	if (skb_is_gso_tcp(skb)) {
+		th = inner_tcp_hdr(skb);
+		len = skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb);
+
+		if (ip->version == 4) {
+			th->check = ~tcp_v4_check(len, ip->saddr, ip->daddr, 0);
+		} else {
+			ip6 = tunnel ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
+			th->check = ~tcp_v6_check(len, &ip6->saddr, &ip6->daddr, 0);
+		}
+	} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+		uh = (struct udphdr *)skb_inner_transport_header(skb);
+		len = skb_shinfo(skb)->gso_size + sizeof(struct udphdr);
+
+		if (ip->version == 4) {
+			uh->check = ~udp_v4_check(len, ip->saddr, ip->daddr, 0);
+		} else {
+			ip6 = tunnel ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
+			uh->check = ~udp_v6_check(len, &ip6->saddr, &ip6->daddr, 0);
+		}
+	}
+}
+
 #define MLX5E_STOP_ROOM(wqebbs) ((wqebbs) * 2 - 1)
 
 static inline u16 mlx5e_stop_room_for_wqe(struct mlx5_core_dev *mdev, u16 wqe_size)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 359050f0b54d..3cc640669247 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -116,6 +116,7 @@ static inline bool
 mlx5e_ipsec_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 				  struct mlx5_wqe_eth_seg *eseg)
 {
+	struct mlx5_core_dev *mdev = sq->mdev;
 	u8 inner_ipproto;
 
 	if (!mlx5e_ipsec_eseg_meta(eseg))
@@ -125,9 +126,12 @@ mlx5e_ipsec_txwqe_build_eseg_csum(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 	inner_ipproto = xfrm_offload(skb)->inner_ipproto;
 	if (inner_ipproto) {
 		eseg->cs_flags |= MLX5_ETH_WQE_L3_INNER_CSUM;
-		if (inner_ipproto == IPPROTO_TCP || inner_ipproto == IPPROTO_UDP)
+		if (inner_ipproto == IPPROTO_TCP || inner_ipproto == IPPROTO_UDP) {
+			mlx5e_swp_encap_csum_partial(mdev, skb, true);
 			eseg->cs_flags |= MLX5_ETH_WQE_L4_INNER_CSUM;
+		}
 	} else if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		mlx5e_swp_encap_csum_partial(mdev, skb, false);
 		eseg->cs_flags |= MLX5_ETH_WQE_L4_CSUM;
 		sq->stats->csum_partial_inner++;
 	}
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 466dcda40bb5..66b921c81c0f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1093,7 +1093,8 @@ struct mlx5_ifc_per_protocol_networking_offload_caps_bits {
 	u8         tunnel_stateless_ip_over_ip_tx[0x1];
 	u8         reserved_at_2e[0x2];
 	u8         max_vxlan_udp_ports[0x8];
-	u8         reserved_at_38[0x6];
+	u8         swp_csum_l4_partial[0x1];
+	u8         reserved_at_39[0x5];
 	u8         max_geneve_opt_len[0x1];
 	u8         tunnel_stateless_geneve_rx[0x1];
 
-- 
2.44.0


