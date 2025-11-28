Return-Path: <netdev+bounces-242498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E15C90CCC
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 04:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F884E2287
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41E29BD9A;
	Fri, 28 Nov 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVFU2QJb"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB621C9FD
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764301840; cv=fail; b=t/+j4U89yzHYxXZQTFAchC/iOaUo8yt7EFy7r+UbBfGOGJVTmb/oOEVGDMio5C611dJjV9RXwcprF0gWiwBXp4RCFv4qeeCQebvsXjJ+5FpVrVSt1JVymP49GFmzo1qNePa+QHy6CFiVYkAX3chOSE6TH/gZM7pEKCtKRdil+Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764301840; c=relaxed/simple;
	bh=rLEo5whZQoGWvZONACkG7F1jAkvcOV5qGm3pxBCtyO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsWBKWrRMSTofBRTkPKo2lwvVbM9FN/IC0bT0ISNKdwVq/fyDGSzeq9N2Ovczh1adsf6RbFaZ15TQ1q7EqaCzVwEW6SYWczMXA5lbMAWMI/hSTnMaF9cc2R9cJ/ZHirtGDhm18N7IZm/gO5gNA5UUlPMUrc9uC98hHeL4/J6gRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVFU2QJb; arc=fail smtp.client-ip=52.101.48.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qp53XVljyjlOPEhLW7RFutQJr7q/G+EVCNaWtHLU+C+ZNBX5zadV8y6d2TgHh5vKSWhvEJRGxAat2jO/bdoQCIIlI8k6dYKflTHr4Vs97HNeP3M252LuKubhKpfHBYYoG8ZfDMEAOQLTbRpL4ERCxg4JlYPd0l7F5vbGyI8ITlyKOxfzpOlc939eiSC8FX5FtEDNw2VAQnCRxM/P3ZbqBHmxn20Jy6gAh2mrysmfGMODuTBI7yOy8uVVrRRV6zvP6GgkEcP6MvwFdXgjqm6JGt67HUnjstQUqAAYlqO+Rm5wwszJ+rmG2LPTzQWyHL6V6LnMj/vM6JTVNzq3kxAqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1hZCWVlA0p/yNBBKu3e2q3aRiLWXExAMYlXzuxA44=;
 b=mmxYnngOUL1xwk1SQyPROHSh3H3KqHolwGz0vAYuf4DhW8u1tZ/0E1WIGHwEsW9axIXAERo/hvPWFx05VXXPQVnuMSF5YMajn93k0OtBbLxbWXPC9H3+qHf6t1QuWQQm79IdXI8I0s7Hh9u0r3/FAnDDpgMQZ7jcgJswg4/EcPWty2AnyTyPt0UBehEPU95X6EmQsVkaOcXaRXj0qEs2XkhVLL2JEk6ulD5EvYJocIjyXAqGchGVbf1mttv8yoE1T8+6IkzFO6k5sJilUKjpCM1vkwZcoIRL+T45K2/XQCI+ULHHQZYTGk7HLOuqURS6Z3zvH6epleFlKHxkHv33wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s1hZCWVlA0p/yNBBKu3e2q3aRiLWXExAMYlXzuxA44=;
 b=PVFU2QJbcdRSKnOpYlUoSYjR6dJ/HnH54jPJVieY4a2we/ZzLmODpJxcUSll3vDp4hGLXLhhQHtQ/e0v1w7BvPZ99yCW6Wdaa0dIE+JSgHW+NN2wFOTI1kUkyFhe23R2WoK2vKMmdvQpBhrmn1zVXLzQl4nsg9hd9ofV4KWF4bgNPxzdKRnmzYI/M+vpYVfZY4EF90pOV8oKW9g+NWSICDnoErK6xvM3W8Xt8uUlxzjgUzgy1z100wOhqhSICiioIMQrTL/I0HPDwgPz5dOXScgDNI1agwv0b/WeLz4WNXi+DgfYvHF+5zAKtx6O9sqxHFqhLwrAuaLhXpW2+t4Vlg==
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 03:50:33 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::1) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.10 via Frontend Transport; Fri,
 28 Nov 2025 03:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 03:50:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 19:50:31 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 27 Nov 2025 19:50:30 -0800
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 27 Nov 2025 19:50:27 -0800
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: [PATCH ipsec-next v3] xfrm: Use xfrm_ip2inner_mode() unconditionally
Date: Fri, 28 Nov 2025 05:48:04 +0200
Message-ID: <20251128035014.3941-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5695686c-12ee-47e9-7faf-08de2e31486a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jXp5fegYDqLBOUNLdWeXRHd3BVSaLMtfnQDJSyEvhyDW62J+IFicdr4tHeh7?=
 =?us-ascii?Q?3xWxPrX5+vlIZ04HJQZP3Y7UuaBegf6kga6c23HyfwZjZDAbcrjIQkQKedys?=
 =?us-ascii?Q?inpkgRJusLTiU8jr5TAhGknghyoWEDv2Rx/hA9D5g7RkGA9Tb44lyZOERFPE?=
 =?us-ascii?Q?WR3SeEwu5eGYic/pWOKmZlDfT06VH5SMuuE83LSeaXXg+9HwmqL5RjEKhpji?=
 =?us-ascii?Q?Wy9+W6w5AAjMXUJHi6zTmktOhK0vA3JnhjJOT+NwKoTmC6eKGIZsLOZwVCKq?=
 =?us-ascii?Q?EEHXAWUtXc+RIydfhjG0sVxnYGHcH9404ZhbYkxQT27cRG7vu6M/yy+TdFa8?=
 =?us-ascii?Q?58Hr5OWy6OrkceTeiDnF/othAwkguqg1Psw9SItMo97G4bugHB1OIfSyGVr4?=
 =?us-ascii?Q?FS3lgOwgEE+VDpUNT8Nz7omvwRDNKsEAn/lodrGZBfdKX6hRazRpgwZpWNzN?=
 =?us-ascii?Q?uYDO5JKuKFaJPR2LesAI7OjUl96ZoY2iAfX4xfxt6/TBWsJ0Y3y97KsqlVWK?=
 =?us-ascii?Q?kbzBq5DJjCSLeWUbfKI5oEAYgy+STxBlY+K8CHawV2kh69b/ECfl/iO6m/7W?=
 =?us-ascii?Q?+o0uw+mMlR8y5sdh2pfvtrp3XOClCilMLp5JMq6WmZ29G4iKz6YUsyd4bjwJ?=
 =?us-ascii?Q?6tRKdBhQHNFzuyD41VnhkAaRz/ZNGy5gdTvIhl7ngsm0/TMlR+kOKKQknotv?=
 =?us-ascii?Q?QCsWJZlXcRVJtcOLL/fy4AmLu6sQJpK74B23++2V8fVY05IbY0kfI6RSURRH?=
 =?us-ascii?Q?kf4fm0YkXoIxfGkEEb1Q0hk/B6Ew4tf5J5xRgb/Q/7vbe91mMDA9tCqLdWMI?=
 =?us-ascii?Q?JpzuR+GEcOwFJuiQqN9yKOB8137EdWZFY6s/r1yf5sbAg/QlXnjaDbqnpLaS?=
 =?us-ascii?Q?rXKAYRzd/vJbIJ/iol26efl6d6nP3IJWWawbeOwLhDQBVaQxR2dPMZFbrEb1?=
 =?us-ascii?Q?MXHWIZO8joclGVkyguzU4c4yWvMPBqJzz5M5QwbvzeND8uPyO3zzyUnLB1sF?=
 =?us-ascii?Q?bJFNt4SDWyN5IGaqmeke7aQcvh5yL8EFbNM58YKC9XQVQDT40yuINhYq0q+J?=
 =?us-ascii?Q?EL8kuE7gXXK0X0f7puPvVYPeAvrUQZQUYQHDvh2lwknkKipGlWMTrDmc42wL?=
 =?us-ascii?Q?Ev90PisRV8ZSmGxVc9QXikeXsYaoGtiBMieRpIoW75dVF1cp4vb0jATmKT2p?=
 =?us-ascii?Q?a/0mIwxLmvcmrECnuKDkERbcXIaHFzv/fZkNlvMDkkplrtikjz/dqmcoJZL/?=
 =?us-ascii?Q?CAGl66o7m+4hkkWAzDmrxFAEoghQUjkxRmqFCW4h3BNP8JLkqMRGYeU5syWv?=
 =?us-ascii?Q?NXQ27VtvQrftWOWIx9o4dC0xNrj7dT91NjvRTeifpVqaHExPb5sFp9G38xG/?=
 =?us-ascii?Q?/iZUekPE2QKrJwpCK97da+PwKOFVbepWh0xcKWWsw9r+NjIZHZLw+KPJ6VTW?=
 =?us-ascii?Q?AKSlR5w54inMxbTXN0qx9krQ9oFWI2Yj/OzVJIJu9P6fIpoqZLTHV9ArYrNp?=
 =?us-ascii?Q?/5Iq+8KqoDWesLCrjbX52/r82dtMvyHANP788jULHNStg5KV64/CCBLHJ90n?=
 =?us-ascii?Q?nPcg/fRcf14uGg8vN2c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:50:33.5004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695686c-12ee-47e9-7faf-08de2e31486a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

Commit c9500d7b7de8 ("xfrm: store xfrm_mode directly, not its
address") changed how the xfrm_mode is stored in the xfrm state. The
inner_mode NULL check is redundant as xfrm_ip2inner_mode() now returns
the address of an embedded structure, which cannot be NULL.

Additionally, commit 61fafbee6cfe ("xfrm: Determine inner GSO type
from packet inner protocol") updated xfrm_ip2inner_mode() to
explicitly check x->sel.family. If the selector family is specified
(i.e., not AF_UNSPEC), the helper now correctly returns &x->inner_mode
directly.

This means the manual branching which checked for AF_UNSPEC before
deciding whether to call the helper or use the state's inner mode
directly is no longer necessary.

This patch simplifies the code by calling xfrm_ip2inner_mode()
unconditionally and removing the NULL checking.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
V3:
 - Change the commit subject (was "xfrm: Remove redundant state inner mode check").
 - Call xfrm_ip2inner_mode() unconditionally and update the commit message accordingly.

V2:
 - Change subject prefix, and send separately to "ipsec-next".

 net/ipv4/ip_vti.c              | 11 +----------
 net/ipv6/ip6_vti.c             | 11 +----------
 net/xfrm/xfrm_interface_core.c | 11 +----------
 net/xfrm/xfrm_policy.c         | 11 +----------
 4 files changed, 4 insertions(+), 40 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..89784976c65e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -118,16 +118,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	x = xfrm_input_state(skb);
 
-	inner_mode = &x->inner_mode;
-
-	if (x->sel.family == AF_UNSPEC) {
-		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
+	inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
 
 	family = inner_mode->family;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..fd56831837de 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -362,16 +362,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 
 	x = xfrm_input_state(skb);
 
-	inner_mode = &x->inner_mode;
-
-	if (x->sel.family == AF_UNSPEC) {
-		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
+	inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
 
 	family = inner_mode->family;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..802a54569df9 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -387,16 +387,7 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	xnet = !net_eq(xi->net, dev_net(skb->dev));
 
 	if (xnet) {
-		inner_mode = &x->inner_mode;
-
-		if (x->sel.family == AF_UNSPEC) {
-			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-			if (inner_mode == NULL) {
-				XFRM_INC_STATS(dev_net(skb->dev),
-					       LINUX_MIB_XFRMINSTATEMODEERROR);
-				return -EINVAL;
-			}
-		}
+		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
 
 		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
 				       inner_mode->family))
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..a609b1fa3109 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2711,16 +2711,7 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			 */
 			xfrm_dst_set_child(xdst_prev, &xdst->u.dst);
 
-		if (xfrm[i]->sel.family == AF_UNSPEC) {
-			inner_mode = xfrm_ip2inner_mode(xfrm[i],
-							xfrm_af2proto(family));
-			if (!inner_mode) {
-				err = -EAFNOSUPPORT;
-				dst_release(dst);
-				goto put_states;
-			}
-		} else
-			inner_mode = &xfrm[i]->inner_mode;
+		inner_mode = xfrm_ip2inner_mode(xfrm[i], xfrm_af2proto(family));
 
 		xdst->route = dst;
 		dst_copy_metrics(dst1, dst);
-- 
2.49.0


