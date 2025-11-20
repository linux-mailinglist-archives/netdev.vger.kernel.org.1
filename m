Return-Path: <netdev+bounces-240286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F0C72204
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACD92352130
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E42F287265;
	Thu, 20 Nov 2025 03:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QclkgDVR"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012008.outbound.protection.outlook.com [52.101.48.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493D18DB0D
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763611181; cv=fail; b=U5PV5kHDlINxOSs7BC8pm4z04RrYfBaNx+D1Colf3uopKpi8i7w7GAvodtSvH20UaAZcbvHnZf6DxL5RoS59ozQqjQ3fy1rfngOg1Gr34L91ZO81fxulM0eOCxhKM+QNsQOtkNnVJA4uYe2CiSSguwZ9vRl5ZvTyt0U3s09JXMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763611181; c=relaxed/simple;
	bh=Guee3ODeg1rNn5mKpL3Yk6O/9D4ykIrNh2oZZKeXNVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qfIWPNC2qQk2Hr6I/uRmq9WYpiUCRD8KFzAUzuqyPmI0ysXijI9vM73M+4PpvSI3kDjPcNNZgMOoaztn/orop+8Fkk1hzelWEcJkbmntLfe8fQtygOJbBSR8LUTWX9QqUSX+27tT+Laor/yqzyBgXfucnk9Tqa07ZPs0wOcG4Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QclkgDVR; arc=fail smtp.client-ip=52.101.48.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBGIghUWq7RBxOQqxRKWeE6cvaNd9rB/FLDNeBdiw2LuWhv8ca93WoJeXSDtTClDBQaGJ1rfoa1LQAsAidp28WexKaTJRCZXaO9zP+TObjPL+hacyeZxJODLjc1STG1CK861r8jkV6ngUGMTL7JqpBDtc+sBiPkR71cPR9Lz4dKdXXbRbDGa/6F9tJfFD4jPCtYoKQ8cbTWvP1bwCZVzLCi02PDPwDizLEPIcu8EPq46w91dNJ9qzjDaHEaaBXjmsd70WLM7d13BTRwN1PIK6EJjXfcA+SRf9UQ6r4dwwtwFdarqNcaI7UeAtSwFgsVE2Cy6UZCk+3VV4s4Qr/jKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJvoaygD5qotlyJwsKAUf2RThfl9f+KAIUU/q9xf1mc=;
 b=DimkXyqGKQSN8NDvIQnUKi+xG/Y7UXuFJN1IQVaaM4mSAHxOG5hIJoHCPkYCl6rIU3ud/TCp0dUhCNgkNc1JHe1V2UCHEo4ddUsB2NSjnzakfLeokAV8iTwjrxOnewqW+1ma3D1cKKbGjtR/abt9N+kkB/HDiDq8BcUEda2wv8iRSOsC2AZf1khhvNeO+OUPzN2iWXyJI8sOeY7A8jBJEpEhNy4Yu0evTzTCMPVNfTrypOEkJtAUKDSpN5aPbvhAN+kI3OmhRV3knZ7xmkXxHScTx0RVvb2BZqL4xBELYjqKjWiub2jCmsFOd8hQrDRlGdet2Vm5P1BtQrBmX6+iAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJvoaygD5qotlyJwsKAUf2RThfl9f+KAIUU/q9xf1mc=;
 b=QclkgDVRH/Z/X1Hn6zrz/qd9f4sgX0M5i49eZUm7JpWuJCBayRwNCL09FEJ527uEUTXs9Qa4qwVAu28LdQQX4VNVwKEMeUrTYx/RbYQd9uUJ9dsNgaHHh9FHHCa23JfrXWxnr4MpK4yq9sQ3/mQdV5NpqMqWYAg288QetkURQ1c2Wa5NtE2JYX/CdD4rEBFqdxKSgjpjaMho1Rqbgi2JmEC1CQ9SOxHHY4A8Mf64YA5LAj/reINpeG4qpu38BOkHsOwDLG6K08kXn0t8nbpF1/y3ALJzC4fdhQ0uxjuF79teipgGOYTdpl31nD8Zjuef8b72MsQ/ZGrCHRjLzj9Dhg==
Received: from BN1PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:e0::25)
 by DS0PR12MB9400.namprd12.prod.outlook.com (2603:10b6:8:1b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:59:33 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:e0:cafe::5) by BN1PR10CA0020.outlook.office365.com
 (2603:10b6:408:e0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 03:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 03:59:32 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 19:59:19 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 19:59:18 -0800
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 19:59:15 -0800
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec v2] xfrm: Fix inner mode lookup in tunnel mode GSO segmentation
Date: Thu, 20 Nov 2025 05:56:09 +0200
Message-ID: <20251120035856.12337-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 991b187a-4c0d-43f0-317d-08de27e9369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgSOdfJdAZ6ydwlZ6ydjKdF93JM6oRgCkBn6NJMs4dIvH29zdpg6/jdrvCYt?=
 =?us-ascii?Q?MvSi23Sv8gsfUuOEzrHN2k/sAOKTRZJcqKESemJ3DNT+KT72poxR8XkBCczn?=
 =?us-ascii?Q?jEDI7pLdaxe8jIprhbfUIKrm/aMZyxnHF86zPK776MqLd4YSNeE/xchkGtFs?=
 =?us-ascii?Q?KiUprlgt1wH+n4//PkWsrlTm5Kfhkxtz5wqC0eZCZgXX4XWrvD+vB05CWbfs?=
 =?us-ascii?Q?Q7kqeBZPydV9VMEa1dX6poh0us5iUJWdJoG9Ax9V45i1T9qTgmckyPjOnt6n?=
 =?us-ascii?Q?0cruWGB2p6JxGGNhgpsZovtQs+vGvz25TTCaqz8lk3VgeulY3IkpixYyPn5g?=
 =?us-ascii?Q?yeQxxe9KGyxSYA0SwtHqZrMjS+NzTW8wdnIRTyoijmGLzjADUCRypUSNwzAJ?=
 =?us-ascii?Q?Iy+LVLgroGjQRq4Cw4rDLXvg23UZh+Jbn0T1T/ZOb3Lfb8w98AN2eZumx0tz?=
 =?us-ascii?Q?/h6oxKxpQnrgYSUOB4cmORd6kMStHrUhHtAFoFOn3LkMhJi9RnFfHd23jiC6?=
 =?us-ascii?Q?fWCPIhElA2wIOmvQ+FT03w9hWRLbSaOCkFzCxXjxXaLm6BKDSn/rGPWnYs2s?=
 =?us-ascii?Q?IiE4qGslLVLPQF3DGCOTlyU+jRWsXq6w7Zrkt9M3y4kGJHmPf+pTIprtez7C?=
 =?us-ascii?Q?/VAyC/q+peOv0A/SlughTx/kGF6jArmzFduRcAaZNtlWULMSCp5bDPY8MV6n?=
 =?us-ascii?Q?5CnLiEVjlf7sDc7RjjAtX26TaBdlkYapm3fMEGb6Zavnz8orVApbMzghs2VQ?=
 =?us-ascii?Q?YbKAqj9yQzDZdTBxxdaimuJDiXthSYd8IhhedD1OI/tzO8drBHQiNAREx2fg?=
 =?us-ascii?Q?XWMvtUMC4/0p7qVEObBW0hoN/nbe9XwfFP4RkR/Zo5jkQZ7jj2oaSIEfKQ0Z?=
 =?us-ascii?Q?VH/ReaJZfuZNPNTeoZN+Kqk1keMLN7ptD5XbiIuKMraLyjhTfs3sRy7kBgF6?=
 =?us-ascii?Q?khwhyG0yhY6YCM40GlnRkWfzcbgo3dPRDLY0X63at/P1kfPDUaZQICTQfkY+?=
 =?us-ascii?Q?2Eu0VdDPCeF2MRpPgzHpy7Iaob9FqYf5Fp2VWQR1lyK+8mVF6XlhImkjcUaY?=
 =?us-ascii?Q?uynlIbqFa7nkIuMjoGKUNGtWmGWL3JBBHG746wcVB6fXcJY5T8QsmKwpXhLO?=
 =?us-ascii?Q?Ns7S5McMbAkYOJE4Ogs/nILYtpd5stVWFEbgSKJFjdAVkwCP4e90q5h8ZcA5?=
 =?us-ascii?Q?uaLhzXT/Xb73lWniHKwyYLkiQ7Gts4OxcD2rMV9Tqzx8fkf8YzJNlTC905AD?=
 =?us-ascii?Q?icoVNHZT1+KmZo2WuMDuivnxpFCpxUaRiPpAiElbDmPZV5qpoiLlRm2LmDzC?=
 =?us-ascii?Q?NK417oFEx8KFuKlhDWSM9Sd/3g6+rNNyCWAkMLzD0PlsU3W1HqyMzUpEPB7J?=
 =?us-ascii?Q?dlSVwM7p6elVwcvTeuacF0qOmlqwddTpvM/oWZUEu8e2X4hJZOtQyyBUIyBw?=
 =?us-ascii?Q?PnKc+ecvId5wDViVIUrQR6e0pf8m4MzkbNoC40dmWR2W5oOg4KwXrn0KlHR9?=
 =?us-ascii?Q?90YQHM5O7iVEXUXzl6v3LhIwjoLESKaJE98diKGNVvBbIDiyIyT5CP/r1N+C?=
 =?us-ascii?Q?ORXBos3qA1KOKRQjIhU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:59:32.8392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991b187a-4c0d-43f0-317d-08de27e9369b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9400

Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner
protocol") attempted to fix GSO segmentation by reading the inner
protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was incorrect
because the field holds the inner L4 protocol (TCP/UDP) instead of the
required tunnel protocol. Also, the memory location (shared by
XFRM_SKB_CB(skb) which could be overwritten by xfrm_replay_overflow())
is prone to corruption. This combination caused the kernel to select
the wrong inner mode and get the wrong address family.

The correct value is in xfrm_offload(skb)->proto, which is set from
the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
inner packet's address family.

Fixes: 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner protocol")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
---
V2:
 - Update commit message.

 net/ipv4/esp4_offload.c | 4 ++--
 net/ipv6/esp6_offload.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 05828d4cb6cd..abd77162f5e7 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -122,8 +122,8 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET6 ? htons(ETH_P_IPV6)
 						     : htons(ETH_P_IP);
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22410243ebe8..22895521a57d 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -158,8 +158,8 @@ static struct sk_buff *xfrm6_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET ? htons(ETH_P_IP)
 						    : htons(ETH_P_IPV6);
 
-- 
2.49.0


