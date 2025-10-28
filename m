Return-Path: <netdev+bounces-233393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C08C12AAA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32E634EFF72
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DEB264F9C;
	Tue, 28 Oct 2025 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyQIkzLr"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012041.outbound.protection.outlook.com [52.101.48.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCE92652B4
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618646; cv=fail; b=bPBnQLfjcQJ+bz/rkeX8FZKK9/WRfpp3P4820CrKcTLFlPV4TR9jWdCB4+qnftH93FOo0msQ6BfFTrJYoqOSY3U4wxAfWEbgVGgy0uBhrK3k+WVxB455JBncm4F9G9x92IiYiIo7q1s4vF5h7TizpG4XHMjCLZCGX8RbmOyFhsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618646; c=relaxed/simple;
	bh=2IrgP/+snX38R6YxNAPRshnRsabvHLSH2f/PxVSDUVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNwB+XEb7XeAHhb7NQHZbV3Oy7vpsAaRfwBTk194YG0zvBb0BIRLt6dUanoQyZZGnu4UfR/UTQIUe0jrZQ9sxRnkVcS9cUzpnJ/1nEt9gKpVcrpNo7BlsmtFHS8oqGsO0TkdaOaT+5cOsVVG1F/qL2Rg1xF0Lwo+xP2HjF3nU9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyQIkzLr; arc=fail smtp.client-ip=52.101.48.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKONUFIXHqmUzp0I1KXOHSbWb5RRFY2ktwQmr2pZgnZdjerlPJi/LwF3tk4jQj6nPB9T+oHRHh+IjxfaFROppW/v9QqWO2cKhf0cJhsM7jGx6LWdSg+nkx23X369wO+ASx6xtlMDsQl6GtnC1lLKRe38ShDZhaBChBdDL1wetD0n3DOe+mox//OampOSxTxDH2u8TV0Emm9cBBKRigNunMQU96BLU3Ou+DgC7qv1U0DvXkDD1gndSfAqKs88qpdR+V+fdN9hdSaLqMsPjk8H6vxtuku9jKypnnDdlc+WFs40NeomtFlHNqR+NM6SMKIs5m+iVeodkUEqLBJUCCcKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxuVhqEiGPtEFRsR9wEeT7x8DNm4W1+CkbAYlXq2UFk=;
 b=dTPFXbvlFS/OTIeoHYt0Lwb+bjM0XNZvaqvm5EXE6un8Q4GsL3UkxNH19s+NKeqVKg3nYae8JDK2x7Q6PPWYswcQysW6yG0vYh+H92VMSvJOk1LCyHALqLkV8InrC1huE0yk/DhYARTE/CeZ/IrsghNmss92C5aqk06zNiYyJtkw0oA9x0loAxD1GKdQ05VJOfmq6T1ndxGL/efB0cP9qWJ8yXMVy53BjACxoWXCNiEWVr/y31IEAYOHKqAVyTi4n0Ikf+rGTRbv1QSFQFFG/vi+Izi2IWmylm11anJgRM5+T/Md954qP2LvORESOjByBYCVVGDhRJ6drggBlAqzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxuVhqEiGPtEFRsR9wEeT7x8DNm4W1+CkbAYlXq2UFk=;
 b=ZyQIkzLrb+FqrytzoH+ZWDVt23bTZPpruFUkZI8/ua1huFSIvGOk/41ao7XJntUyr16W20oxw+b5LEYu8C1/dZfISz9cqesIHa/NtayMMaYTyBeMYzNSU4KogSDd6xji417RK3oE7eZLvEwSmfolE2SUPAa0aDVoK6FnVzBV9HpPmhLBHRODwXiSWrdzdfwsUdJGo7SY232dWhEeMRXYhoEDSArzHO0Unsx5udY/rWM8aoSTbWxeLs4hRzV4DIshQ8Ev6Wsx9VxI0VKLfVQoV38bNQe6ALG3w3jbnOFrpqS1HUZYkFA0qhsPJNVxU/WqBfI1x19mC5q/pLEuWr23OA==
Received: from MW4PR03CA0253.namprd03.prod.outlook.com (2603:10b6:303:b4::18)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 02:30:40 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::aa) by MW4PR03CA0253.outlook.office365.com
 (2603:10b6:303:b4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 02:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 02:30:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 19:30:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 19:30:27 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 19:30:24 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: [PATCH ipsec v3 2/2] xfrm: Determine inner GSO type from packet inner protocol
Date: Tue, 28 Oct 2025 04:22:48 +0200
Message-ID: <20251028023013.9836-3-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028023013.9836-1-jianbol@nvidia.com>
References: <20251028023013.9836-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e354180-fcd7-4836-8929-08de15c9fc7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQtYTr5ZMpW+FvEtnG9PERrG19//GtJCf2qDU5SWYC8o310KRIVHNk94V4LQ?=
 =?us-ascii?Q?hRcebeMPlRhZ/DHjpp03I3zACjHuHFXeF6mKuT7reHAIZ9DNYfBWNDrZpCHI?=
 =?us-ascii?Q?lfYMvw9mmKEiUcRgtfo4q7ZnxobDyjDtRh1KVHKJFnecY6PjwdOACMJ7gFos?=
 =?us-ascii?Q?q+7QkUknOHRq4W7tL2dqUrwgfSYsJokv5T0sNnnQRFqYfWhExib41b4VXdA3?=
 =?us-ascii?Q?F9++v6g2sPxY+HMDL+PSD+kkA0wXw36Fn8tlXqlBU5cU1BO9WwS1xKHNfNmr?=
 =?us-ascii?Q?fJ2lZtL5cfUxtCQ7WvmXl6yCps3DshafUJPiU48IYqt11Ei2fXTx1G1DA67t?=
 =?us-ascii?Q?SJYhsLWwyZyS79Ts9CU4h5a4y9FfUPXvnripazmouRFwRUbfXk7CxfzETjEo?=
 =?us-ascii?Q?OmNMHK0aOi0eVvZHpAOuEad9hWXrnU2jVfhMRJf5h/o1Tm52cjmhwFPJkuKu?=
 =?us-ascii?Q?hMpYs7IIJJ5NCTTBIGmQlCUsol9vLtoQ/GWe4G6+MuUFgFsdCD5DMEv4qWgm?=
 =?us-ascii?Q?t6rJdqeicd+m8vVy/4r+/csUkROa7ZPb6h8UELPA+ep0yWepRKqk7TcZ659v?=
 =?us-ascii?Q?Wo9kXLrX1bS26jYinBYrWSZv/PRcBJday4kYrsmEAK8Xpx/Je+XiRdB5XTaz?=
 =?us-ascii?Q?dnH5LDKzAo2l59jo9QdbAwNqXLGo/dxWmspSoym1UnPmbQiEZ3rA4fhi+vg8?=
 =?us-ascii?Q?OWzr+tqwb0l6tPU/njQd5Yiz7BSoxpgmTaIQLoBqXU71KCxQV6Tkjr3hyFyw?=
 =?us-ascii?Q?fljBDquZTEWRQ7TwcZSSYydsa2baivoAZgWAry9L6mAoVRnqsig91ZwUQK5d?=
 =?us-ascii?Q?8ihWfeejVi7h0DdFi1ovxiSaBmxPfqEHz0zlBHpkSrIdea5o6lxMka4JxZPk?=
 =?us-ascii?Q?keWhwUvcqOSZu+yvrBoNi+VrMoKL/xXbmPvcU1s0QksNFVvv1bkot80H2ZBr?=
 =?us-ascii?Q?kcQfIVaYYS56GWF/6qVq7ahh6ZdJt9m7ZVvBzIbRG2MHHozZ0tK3ACPcoysy?=
 =?us-ascii?Q?lKm+ORZymrz4r289C636hTADY/BackbVYoNkQKVHazMxvAZzj+3OWuWh0DUZ?=
 =?us-ascii?Q?dpXLFycZw9AhRSYokqDCTpOMogw+NePl9KMjxNLXswvcAiQgHC50AhAAc0bX?=
 =?us-ascii?Q?E7JjRk1eWHO+C0VcWuFmmItZtIyCQSe6exJAOicSZQhmb2Sx5xWHDu9qLnTq?=
 =?us-ascii?Q?IscO5dT+ZZi27lXSG25Pzwb+AHM0DJkeSQfYP18MmFA9KdUGEjQgA4RM6GEm?=
 =?us-ascii?Q?aAMKvasqt7ayJj+KgJuydQNoqpc5xvHP65El+GUJI5raAp15WK1T1iXp3p/M?=
 =?us-ascii?Q?sN4QdKN5rG1ldDPFM1XKdoMC478Z+2W5Hi8UDCj30YnsSvvHNs3yqDU2BGsc?=
 =?us-ascii?Q?exqP8tjId8jpyxAQ7Djct/DE1y6MbLqmJGiJeRV/jI1gJftaICskIMkEcwis?=
 =?us-ascii?Q?uVyMncrpA/l9v3ViaccnuHZ4tG8p3sRQt5DGbBZ9L1HNK7W7cLzF1fd+S6Wj?=
 =?us-ascii?Q?FVLjobjEVxKHKqdw9pW5pRKOGlYskTLysvGcS/CZMb5cxNnnYF5PwxTDZyNj?=
 =?us-ascii?Q?t6wNW2QoOUUoThpCD4U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:30:40.1364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e354180-fcd7-4836-8929-08de15c9fc7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

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

Instead of replicating the code, this patch modifies the
xfrm_ip2inner_mode helper function. It now correctly returns
&x->inner_mode if the selector family (x->sel.family) is already
specified, thereby handling both specific and AF_UNSPEC cases
appropriately.

With this change, ESP GSO can use xfrm_ip2inner_mode to get the
correct inner mode. It doesn't affect existing callers, as the updated
logic now mirrors the checks they were already performing externally.

Fixes: 26dbd66eab80 ("esp: choose the correct inner protocol for GSO on inter address family tunnels")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
V3:
 - Change xfrm_ip2inner_mode for the sel family specified

V2:
 - Change subject prefix, and send to "ipsec".
 - Add Fixes tag.

 include/net/xfrm.h      | 3 ++-
 net/ipv4/esp4_offload.c | 6 ++++--
 net/ipv6/esp6_offload.c | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index f3014e4f54fc..0a14daaa5dd4 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -536,7 +536,8 @@ static inline int xfrm_af2proto(unsigned int family)
 
 static inline const struct xfrm_mode *xfrm_ip2inner_mode(struct xfrm_state *x, int ipproto)
 {
-	if ((ipproto == IPPROTO_IPIP && x->props.family == AF_INET) ||
+	if ((x->sel.family != AF_UNSPEC) ||
+	    (ipproto == IPPROTO_IPIP && x->props.family == AF_INET) ||
 	    (ipproto == IPPROTO_IPV6 && x->props.family == AF_INET6))
 		return &x->inner_mode;
 	else
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


