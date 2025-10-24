Return-Path: <netdev+bounces-232333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433DC04259
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C04934DE9C
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86D261B6E;
	Fri, 24 Oct 2025 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/7sl/vk"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011070.outbound.protection.outlook.com [40.107.208.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030B25F995
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273612; cv=fail; b=BaXU+gae/mqWY4TrA4rFhAjDPMaSMii8Ilb/Tu6l9corXk/mOMZoMz4HHn+fInbjQn5bNTc38lIYPdpKhYJPcRjrpqUa3mXdyfYJ5XauRK9NcICSYDAel6wYYNHYmf4RiCbME3wyF7pzha+322LTF6zETNLYQLjBxzhMJw5KGks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273612; c=relaxed/simple;
	bh=HanhuemvqxUPNSqqpb117FieQirc3vujcIvCM/R5d9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUNKPVMrv50Ps5HhAPslafWuRtEvaykINpJiLr3EDzwKFTbTxLP2Lj+F8xFOikS+xvEymRwx7QI9pZUTMshz3k5401L9tgwNomgruY3jdYmwjOeKFPOaAXI5N3XOIhkfgen2T/twyIatyvNpmrU6MPTgatYMXgNs2gX5dHJNecU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/7sl/vk; arc=fail smtp.client-ip=40.107.208.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn9OQhSvP4eJC9yugT0I9NVeF6yxX6U+VVg99ekh220EWwJUJOP6uhuNdtKf5Qz1E5WwufiVlLcnxdgVOvt0RFQ8X5fgXYUpcgmi0cPsNyuVUAZWlp+Q46xAPZdZWx8Q5R5e5zGyzr6z3BJFJuCMMcNtak4OhBVQ3oIi+CnifovgV7bo4EGsejXZUADc56s2JgTDAcs4FqIuJCP1HU7C/5DnSKE44Ztcv7tlLpzQ+Zfnnu9tCboIX3BQ4inkptRpdQNNotD9PF/JJFoJYjzZrxd5qwPM9k9RpA3VcaFQdOBmTpobrGzA8YMgWj1kBgmDXMn/LrgFtSTHOaT23VWinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewo82pih5KE2S3AALV10OYzvxfgQiO9v8Ncwx/ypW2M=;
 b=LVgzSqzIy2zVmNETc7EHe2f9yWOlaYIXu7i5TJ6BMg3bCvFQop3dRCTdNREztgi7w9jnsMT4j8kyPtp5ZSf79rpOzYH6b3RJLRf7AfBIiuyC0r7ttrYobrtlPzcQj/aL01KHLm7gudi+MivWbiI17+60mjyKIV3A52sr+7b0kWC3HXlU+9IDo0HbG6sx1yAzxodrKnj/B3Bxzb2ycFZ0jvQ0t7lOyOaYv/6zVEOyVPm22GQTTj2X4gACcaK3K+HYumFAbzSobPD/Exd41M2TEjBJICkpD7FE7fF12KQ3Ml1XhcTCdeM/wOVSHF2iv/7IszEeqxAcO8Fd/hOEppyhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewo82pih5KE2S3AALV10OYzvxfgQiO9v8Ncwx/ypW2M=;
 b=l/7sl/vkFfSx6huRcf0Fv+dv3zUiDFzbG59IWj8W9lOlnZ+orhGoH0VN/nS2gnol3VrUl3VCAUOVmgveSqatUf+obmSLIPr0iJ9dR+oxy77+cM3IuOIVlB/BalhIkBu7rPuaw5QrUaV5Lpk/YngKm0nTwcjl2Zd52jzmuNacqqPQkmGkrj2S1iR1E0RSj/FPfMGMNOO21/zftv17af1yzvAyjdpejdNxONUXjp3BIUNRGWQkLSOlI9/6ajGSEidvjwfv9B2y61IQPJ/B0msZkpouiQKjUHUXqFjyV+NYapWH/Qx3ceAomTYS4bGfFIdBSfy7JrQ0B6rRShti8K2wIw==
Received: from BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40) by
 IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Fri, 24 Oct 2025 02:40:06 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::a1) by BL0PR01CA0027.outlook.office365.com
 (2603:10b6:208:71::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 02:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 02:40:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 19:39:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Oct 2025 19:39:51 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 19:39:48 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: [PATCH net-next 3/3] xfrm: Determine inner GSO type from packet inner protocol
Date: Fri, 24 Oct 2025 05:31:37 +0300
Message-ID: <20251024023931.65002-4-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024023931.65002-1-jianbol@nvidia.com>
References: <20251024023931.65002-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: e102d901-80d9-4423-7042-08de12a6a4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+K7oaJYrTcatRMsrBZ2AS5t/YqlfCo4P42n0FHN4TOIbahQJt+lPUhL91V2k?=
 =?us-ascii?Q?YDkCEwMNi8i1hwsmHB42nBR6YHUa8jLqrmKj7R2aH2V21R6FZBoKGX7p04//?=
 =?us-ascii?Q?t8Eo6qIJxh+o7EbNUmoqADDWkBUOePAGuzHiJO6x34eGwZH/rlfWY2GmNvur?=
 =?us-ascii?Q?YuQA3P9DX58wkJrM/CU2EPUeHOBVIYDZuhfjlPesk4UWaHcx6OnBxXCUwPLT?=
 =?us-ascii?Q?/Ss6Nzv9i9y2BSIo0HJDTZ40h8cVETaxmfMDvqCVNDlzW2aub4Uzy8PUDEjq?=
 =?us-ascii?Q?T4BQ2XqyIF1vv6YO/oVqUaT/0qQH0i3/3ErtmJPigJ9CZDkj42SGWRstSUnK?=
 =?us-ascii?Q?ElDLVQ238mhbhrlfTz3nZjKBTWeEtU5ew4/5w5RUMnENgA+CUs4aRO9j/gBn?=
 =?us-ascii?Q?beaRVk4QXQrRcxTCloAGCHgN9ysTdGm4IAPW4jJ8bhg2Vz+zacdQhz4v+4W7?=
 =?us-ascii?Q?CI2cs/SiyG5AJqTuFxJDqcAIxMkOj2VpckQ4AMi7oDaG3Fc6WnntKd5vOxJK?=
 =?us-ascii?Q?wRoyC4/FWzCLcFdcf/XSGMy+/eYC63SKEAYWGHvlaZixVSXRlPNqRsYGXTpy?=
 =?us-ascii?Q?5dVjVYXUn/qgIisl4tA5kRiMXy+bfWhkByZYZ7sc8iKYvPmLzpKyiLE3yxnB?=
 =?us-ascii?Q?BjsFDxnplhgND17ixE+zVKvo7gfT3xE/BGAG88TxQYDA+cYBuJQJYcsi3AN7?=
 =?us-ascii?Q?YFohsyixOz95zrZB39TKYRatIv/hpRRbiPoN7nyCZRPYuFymcrCYL3+K3x+g?=
 =?us-ascii?Q?lyYM4eKcD497rSmXOGBD676u1x6IJRxX0bk4DY7DGeb2ncDfYSWdiWxOsUUO?=
 =?us-ascii?Q?DDOSYQ107uDzcDBQE/4ewpH8RKjBGePUWKHskXZ530bq8UfAaACT6vBnR3dd?=
 =?us-ascii?Q?YPb4pZwnVpXluEz3xXyUR9QllDX7JqGLlDNXCzexu647LFRMw2ICrGM/xxgE?=
 =?us-ascii?Q?TygRtAWhsODrmOu4xgPq2cZcs4y+ufOPGfOGl5Y9AOVjwOaeHuR7kHWbZlA5?=
 =?us-ascii?Q?h//6gTyeBv0PffbfHSlJXIqcMBXGR/Vz8nUvYLqAuJcVOjTw4b2cBIIHEW74?=
 =?us-ascii?Q?ARG96Y5Y8rEUj9zenvv+39DrlzycWmG5IG25fVl6oJrrMmi810fX4YTsVKkE?=
 =?us-ascii?Q?+kkclg6xGFc/7mBJmi6WArXG8xP2Lr5WxUi5xuWFIug3EaJOwnkPm+w9uY+S?=
 =?us-ascii?Q?WqwViSTK7OtjbH0CSX9Y64kdjQNEf0t9NkijOZbZ7dfritZf2HCZYYdt4t4r?=
 =?us-ascii?Q?Fvr9OvJRvo6Igjtvwfcark7Tqi4mgWx6ixwdceb6xYm/5LgChKfNgFrK12Ze?=
 =?us-ascii?Q?lj/PQjhgQl7FDFFBaeqmqwhIrjNX8lcl0aX5i38bd3g+RS4iBm4ER7Vy3/tK?=
 =?us-ascii?Q?EI+F0y+Eg458vvmwtdb2WqBLq5S0/qGXgfO098GUbSQ8ZUlgcjPToxJqJbab?=
 =?us-ascii?Q?o/U7HAMIngHrdipdAFu8wSYEcxQPdypGfHw2WZJQUigcij7khKG/j49AVylm?=
 =?us-ascii?Q?Wt9doKXtFCUM80FQj8uS5a6Hx9s7wo5qjoKow1qVEh6rOVdRmC0SmHCaIg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:40:06.7516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e102d901-80d9-4423-7042-08de12a6a4a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

The GSO segmentation functions for ESP tunnel mode
(xfrm4_tunnel_gso_segment and xfrm6_tunnel_gso_segment) were
determining the inner packet's L2 protocol type by checking the static
x->inner_mode.family field from the xfrm state.

This is unreliable. In tunnel mode, the state's actual inner family
could be defined by x->inner_mode.family or by
x->inner_mode_iaf.family. Checking only the former can lead to a
mismatch with the actual packet being processed, causing GSO to create
segments with the wrong L2 header type.

This patch fixes the bug by deriving the inner mode directly from the
packet's inner protocol stored in XFRM_MODE_SKB_CB(skb)->protocol.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/ipv4/esp4_offload.c | 6 ++++--
 net/ipv6/esp6_offload.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index e0d94270da28..05828d4cb6cd 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -122,8 +122,10 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	__be16 type = x->inner_mode.family == AF_INET6 ? htons(ETH_P_IPV6)
-						       : htons(ETH_P_IP);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
+					XFRM_MODE_SKB_CB(skb)->protocol);
+	__be16 type = inner_mode->family == AF_INET6 ? htons(ETH_P_IPV6)
+						     : htons(ETH_P_IP);
 
 	return skb_eth_gso_segment(skb, features, type);
 }
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 7b41fb4f00b5..22410243ebe8 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -158,8 +158,10 @@ static struct sk_buff *xfrm6_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	__be16 type = x->inner_mode.family == AF_INET ? htons(ETH_P_IP)
-						      : htons(ETH_P_IPV6);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
+					XFRM_MODE_SKB_CB(skb)->protocol);
+	__be16 type = inner_mode->family == AF_INET ? htons(ETH_P_IP)
+						    : htons(ETH_P_IPV6);
 
 	return skb_eth_gso_segment(skb, features, type);
 }
-- 
2.49.0


