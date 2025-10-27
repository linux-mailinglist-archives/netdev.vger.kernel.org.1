Return-Path: <netdev+bounces-233066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B875C0BB6D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B226D3B7835
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF48C2857C6;
	Mon, 27 Oct 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwJxvarE"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332922D062E
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533453; cv=fail; b=QFN3n2YMOGeQU2n9yfVKLMYB8giwpimVagk0jVrHkWywhYCQPBJm0icailV8a7nZnOYAJPu7dn1UuTreId8vqKMnqoFoLEadZCNiaT0bDHDp0ssRZowUEs29QsFT3hVpSuklcM5NKS6WXyDLgNFsv+E3kB9GIBGE+wwzyJNYba0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533453; c=relaxed/simple;
	bh=eUf/+QeVMAAWSvqkzPQS4ha1m1XE9ud5xtoKyZq766U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxlLYFn6rCqNfwei61SAW2pAqhy/FlRI3hSuSTACfFK89t/9ZiYhWDbvMZvp2EuyT22wgKV21ncp5E11zIvzMx8TtOhVzS2G3tjmFByCVbJH3YvVvBHxF5FxXeemT5eui8dOuUeO4Ozjz3KqAt0RQte1JXuN7bd9fyLgsqXDXH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwJxvarE; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhsOMRfWg00bn+QUIV7GV3yzlucPo4f8UGRffvg9OXsuEnQaaFnme47hA16/jkXXKbTc4rDQJrl4RPg+yAHaTB3dyQKcB6X8NduG0rioDLXxSsLBUFanTtFxRtiVAr/zf/9JL2nIKolodpaTrj1dJSVC42pI7Tb74zkKLBR6eu7vxWsbaRvvhAACL4CMeyiDHX3HiiS83W8jbyCngbw9WjTTuiGA1n0BGIooYp14exHeAxv4ZRqk1OWMj0N6K6Py37Op43YlbT9PvCDJjIqw1W51qdYEHHYMcpzJQvOfGshxkUcdjOjt/YfIIiSlr4+kikfgEVuRNkKsQDBDtmGHoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD925OSyFEufnHRcBeGZ2Y1Sgd8L54XGh7h2kPPLvKE=;
 b=c/oH7OI+l3kFQXamWNB1907ynLkjiUau55uD2E6KiGrlDUizUOBFHVnYrBUdqSlh3NyJFgOptMIIvWJhNwEarld3WVHY56tcgO0fpnYKayxtVfynrt6JQ016rsQg4jEPG9GWyKjE68m5JUS8ccrUzBh5PZSCFQQs6wrxP8vzQl8Xk5Njq7BBizmxG9KbzleMkw4tMxECdSOCDoHfnY0Jwqo7iS7RydL9FTGhbHJ4+T5QuSOPBuHEF96Ghmz+TtG6dljQiVQVJrbwfdG7jM5L5htuviDovxLW0AnRZmftndIWCj6o4P1HhH+ekTkmPGrH4LvrMsOC2h2XM8Ex/X7VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD925OSyFEufnHRcBeGZ2Y1Sgd8L54XGh7h2kPPLvKE=;
 b=UwJxvarEzbqfaJMVYT0VR+HHbrRFTD25xQ/e2pbWLIn/3xaShSJUTtjxBaC5TOMUTJEEptq4BZUjvvVcMFLJwWQBszVCHMSjHpwX69YKGsmCTZDV5Swzu2jcJ6mDJClRPQCaoUgvPq8JBfyLo8ro2s/i3ZbgjhW7HQVK2TAdbOSgElsUoP5inA4WhBTV7N6X010WgGEVdRB1f52ebohOcQmdgDphM6klqMfbKRNCghtvJ4/N5I8GggUDyLWwnVOuIv7hwB342EOAgmRAGeUminx14lCkHz2C3cbFOxonEW+fE9UG6tLW0kku5AIaKxwTiWGs1blv3YWNalegbPoNFw==
Received: from BYAPR08CA0004.namprd08.prod.outlook.com (2603:10b6:a03:100::17)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 02:50:47 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::45) by BYAPR08CA0004.outlook.office365.com
 (2603:10b6:a03:100::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 02:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 02:50:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 26 Oct
 2025 19:50:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 19:50:26 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Oct 2025 19:50:22 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: [PATCH ipsec v2 2/2] xfrm: Determine inner GSO type from packet inner protocol
Date: Mon, 27 Oct 2025 04:40:59 +0200
Message-ID: <20251027025006.46596-3-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251027025006.46596-1-jianbol@nvidia.com>
References: <20251027025006.46596-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cac6cf-f63b-4a33-90f6-08de1503a183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lWcAk3xGHl46C+8yQLt49LP1pglfttu6tGm+PNC9+rbWVgQWdGrDlyWTF8e4?=
 =?us-ascii?Q?RNS/bt+jMqXiqxN4iZIMwy7bzX3NWJcvWbKjcv1a8DGC6+5/74TD0lOPG6B1?=
 =?us-ascii?Q?PHAHKnFTeAbZI+QZn+cK1Fm1KBQRXaye6cZufSnsVIQOIZE5/PoWdmJyMxfj?=
 =?us-ascii?Q?REw4TZktuIZAQPp3RdK3Sbfc/xeVIMpxZ5Tzd2ql1Ypk+TRkZ2hIMWbbL4gV?=
 =?us-ascii?Q?qXLwb370WJxHkwDLqmI3Nb818vgtL2Wxeu6+ve5rlczCtpDtSQtYKSP0ZqOH?=
 =?us-ascii?Q?LKWRlD5oZ6BvOsAtStrvGyZevxrok0Ag+5Qi2e3gZJMD3jqOKsXeCY51d836?=
 =?us-ascii?Q?u0MW824j6CnA9cULOSPyN16Yxum2Qe265JWBMza1jrNXS7IP/sPPZsByqykc?=
 =?us-ascii?Q?lMYSt0EMpcg3xDdUH66LoXH763VnvUNSJjiesJsiYgUz8Si0YtN1OFU5VRRS?=
 =?us-ascii?Q?bR1SjxGKanrXV7GGfSzxyNsurcAPIBJXyMogG2o9cgUJ42Eym7k305XEr/dl?=
 =?us-ascii?Q?jUg6iuMkDLrlTR/myq2glkHPtncUl068iIQiEzLTgy9u4XN+eCBy8Sn9rjz9?=
 =?us-ascii?Q?IWhVftPymrjafTzWVZgAZUiv9kCIBsV0A+yGt0F6GVva2Ubyl/D39hxlz36G?=
 =?us-ascii?Q?R4NXnjx0aX9BShKOYsiriRCGkKgO4N9ipnqJ7VHE9rhSpU9RNBVh/i9O3wCR?=
 =?us-ascii?Q?aZCGwPqCKpLdjU/2yv/yzcV3KumvvGEn9yyaAMaA8MsqGTMI2bxJqB5/X3cS?=
 =?us-ascii?Q?CrG6pPdPB6h+aYHyx7k4VoeBhO8cECemJqWfDdVjjW98/Uyet0l99gmKpmoA?=
 =?us-ascii?Q?pIlTtRPLZsSOnyH4HY+S5OZko2H7U3gJFtr0uQSiZHaE/fhTDLUeBoNz/r/D?=
 =?us-ascii?Q?OTrIQJKUUrPzTPmJxC+L9efb0N+bArXz0C7NwG48feS+HRBb8odd13Qz4ys+?=
 =?us-ascii?Q?rNasl6Cwtiz/7yf35DysGEUNDYbOeeK2PR1U9kv1CwRaZN4jDIBrpwfTM833?=
 =?us-ascii?Q?DO4/SzbcO0ijlJu083gVCsxQuhBIhV682vRTs72aiGCMT0WSww7FhoCNPQTG?=
 =?us-ascii?Q?J+39jQk05hQltLQJKNGQceB+mYp6H/9jslV12ZMojxm8vQcnwqlPVMKkGS2E?=
 =?us-ascii?Q?N0q0x+kbpAFEKSQkefjM+hzKAKfMQuo2BbQyZQhIG2P0ZGCLLRddn9t4IPLi?=
 =?us-ascii?Q?Piml/D1Puwyy7RIZOjRYXarJKRkz6VKUFhTX2APlAhuMLF9YYyFejltrqe2c?=
 =?us-ascii?Q?fN0l2xNZFpgGnXLib6birsiGnVdEewyhKa2cJGVSRJvaj8i91czGhq6Ql+bA?=
 =?us-ascii?Q?1qDo9Ti8pW10CxdtGtgJMnK3dBc1StE1keovK9zfmt8wJzUfbfwBubvW79TG?=
 =?us-ascii?Q?Ft5PzCYpNaTv8mhWvoBuKumpVfdAMGC+ijFXnQffvd+3TJCR29OKvSJCXh5X?=
 =?us-ascii?Q?vRFcBw9Utya3qMvMzH9wSp7rUIn8svDw6ZrZl670PPeYroniw7u7MIOcHKxh?=
 =?us-ascii?Q?XxN4fncVhFznjwDhPx3FGXopNeayOHEmGDPs+YmP99a0/i+6cngdRzigcQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:50:47.0625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cac6cf-f63b-4a33-90f6-08de1503a183
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

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

Fixes: 26dbd66eab80 ("esp: choose the correct inner protocol for GSO on inter address family tunnels")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
V2:
 - Change subject prefix, and send to "ipsec".
 - Add Fixes tag.

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


