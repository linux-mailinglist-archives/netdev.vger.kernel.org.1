Return-Path: <netdev+bounces-220717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEAB48565
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726CB3AD77B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C042E7199;
	Mon,  8 Sep 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UuWxcHZb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD723371B;
	Mon,  8 Sep 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316919; cv=fail; b=Fjeiq8vrZD7pzMEeBwWBvZIB+KoOHRZnFWbluQ223/c3ehE4YRieFupz3SqBfBgz8m5PeOvcknmWuGJSM8ZfgQumH9qujrjk8G0HgSFymcT6bGmCBILgFUpdhEw0y4Cesp4uflLswxTtjTz7JpQ3GIn9vV99QHHOoUdLRv42UfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316919; c=relaxed/simple;
	bh=u5H600YyqDSNhE1dbYQ06wEINJagdaWUWyWrUIq3GHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kEVVpkGPA7Ki3RRkqO5mYrcSJZ1LLUAHdD5lSpJSnUGojCcg4Pxn3rmrGQMcQ3bUapC+J5AikUj9hzYC+pAI6ezuuFXdTEoWCdD+/HX6EsHMB8ZR2wzuUihxZGL0N+AwIwxe2R01ONN4CGYKP37sFwQ02TW6mztdqaaqBXZ4wLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UuWxcHZb; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pqh1MxG8KmUNGG8Lwgsm6tHhgwg/KKl5fPU5hDJGSHLbBwWdEPY3eS+w6mNx53XnUst69x3Twh7c0QvPfkPqhrVaxU7k2VWgZoWZP77O4IAE6vIiFDsDyd81JwTIT01Wz6p7Z7ByYRCkUG8GGWrWMgrluJrplYL4zTijfwZA3klUnxbJwUKN2jUtLsbigPiiaP0ijl+wBWpgeHb3iYF5ZxaelIeFPrLXDBeNUZzEp16PVV6VHPVDvPYL1Xbxcru1dA5k4Cex9VqsTqlO1MDs8iTKZCbKOaP2oTnOX4sRPvENKxIxOCPU8cgRmOl6ONxBGVsNzh6p/N5aYWNJaI0fkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21i45U4M28nbUsKwIRe4ReNvKYTwlviXFpaFGGCuyU0=;
 b=OX91d7ZnEuMjPx9OkSYNVWyekYc+NRPX1kYTRI1QECoz+aX+4bracAxxlUkIBR1pdxZnmiNO82RwFxFxxtc2IiS6AuNxsanof7YOuglWsojoC0DHo7/VI/FZkLmpgfgHAJIwNyZBcAhrMYfGi93rVKVP0Bc1sN9kk179OTLpEEES84y/ynNnJ90RnVopvp+aS3r6MZurXxaB9qNYZI8ESeVdQyOe6rUaSBwU9N0yfDHQDJp83s+4o1h6mZoS2nJ6OKz5g5n39C+FI5nBiwRAiviPmwR51ItrSwvLKn7OI4uI8SAf56XbMYTj1vfimkcJ5zroZsT0eleMK2K6SAfYFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21i45U4M28nbUsKwIRe4ReNvKYTwlviXFpaFGGCuyU0=;
 b=UuWxcHZbJ+CUsrBlHeurunTY/L2FB7p3yXLFhNWg5iAmJsj/O+I0N+llB02M6U0KbzqlCH21JHGhPgAejG60JrRU16PVSRcf/SqjunAHJCcQvPAISFDqcMevl85dgMn8q+04Bgl/zv26dW0yPaLI+opysZrXmbCVVbdyD49amtu5aSMJXq8aOGmPmpdtYexb/1zUCjsNBG3BdUffE8j3fYyWzWQPIVGzVgje4SuITuX8KWX+MkfaCqo0To2a1+dplAlPJ+192NOR9c2Q3f9DfD6eYSi5YQBYuORgbHHcoosTRynl1dIxsvKmxjWu6PVBh8jSINjQg+QM3uDX4Rl+xg==
Received: from CH0P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::6) by
 BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:11 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::f4) by CH0P220CA0008.outlook.office365.com
 (2603:10b6:610:ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:45 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:32 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/8] ipv4: icmp: Fix source IP derivation in presence of VRFs
Date: Mon, 8 Sep 2025 10:32:33 +0300
Message-ID: <20250908073238.119240-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908073238.119240-1-idosch@nvidia.com>
References: <20250908073238.119240-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: eab589cc-6914-47d1-4b94-08ddeeaa3e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZfgANWW60gullmj9l0tdM1Yl6lgTNSzkP6HjYIDmXmiys+XoepCXCqFq9PX?=
 =?us-ascii?Q?LwOMAkaDLgLLvyV9WhQlu56z9FNUW53g8D3Vc2k0idYY2qTz/EkRPKZ4gSDF?=
 =?us-ascii?Q?kiCqodoo1F80oUgp1mEhDPDiqnBjvULCRrOFKXr2/xL7KtfogjA+IqJ6UvHx?=
 =?us-ascii?Q?B1vCtoF7fqy+YU7Bou/FX8M8xs7QQRuc+wTWCm8nZTwD9JYl/B86as9vRbzf?=
 =?us-ascii?Q?3YQDBL6UEWi9pgowkp4UFCJzRwC1jw9PvyEVbPt62Cqp8H6y66W0YEN9rugs?=
 =?us-ascii?Q?LGd5FKFTSzXLnhM0E5+4hOgZG1MP8oPKzG0XvRwn/uPEuwL0SALgbHGwUIwW?=
 =?us-ascii?Q?Urf4ZoyTFFksIo2Y3lZX/58uKVJ+F1kbrrS/FOYcYrR+Ul0DZ7CEMzmKPtpd?=
 =?us-ascii?Q?ELhrJZXmvqXG0jFSTQAvvOa7AovUznD6BiQlOFWNukWEIBdjFVz5Wg5nyEUg?=
 =?us-ascii?Q?Jit5fCIvEP88SZOogt/Ku4TZZPpt64djjek0EEMaxVpc5qEPNFfG/vEZ83hn?=
 =?us-ascii?Q?1wJmd8JMJCa8rM2WJ4I1X+8eBco5eG6TXwJNcgOI84jfmhR90DyQtAJKkRO/?=
 =?us-ascii?Q?Hk7EWtxX8HB2RloOvvwLr3YpaS0BO0rdUSuJRzU7CnVUZbFSapg4fX3Q1Msd?=
 =?us-ascii?Q?7wJHtt4WilRCI3vdvjkCSb1O6iW+h7QsyzbqeD9v35RUEpeps2bMeVqWgNOv?=
 =?us-ascii?Q?mWchSJeNEl6jbF93AZFa6vwSdMeVG5Qgw7AeLzjqxrHxuxU/U+uSS3kSRSl6?=
 =?us-ascii?Q?K73N342wXw89twKljyKD2pXVn9uW9zXp2z8InS008fljqhmlJ/S62vDD36jS?=
 =?us-ascii?Q?o1t/M24cjn+4V3rH2pwhv32aCak817GjVynBPxJJbqEkO9dQgpJ3DcNgWIJg?=
 =?us-ascii?Q?WyyZ8SS1R0thtlj8JBecUF1x09nfZGBPl6Jv2npwLIwCHPzZRvVVFgGoFFyu?=
 =?us-ascii?Q?b/RFGzqvKHnSZtUqZFmWFcBOVKdJT5+BE3FRL9tpu0sznHBFBawVujo3OT8H?=
 =?us-ascii?Q?4iretE8Hg3TV4EKLq5dD7LMCLbG+l6M4HyFFuzVjNh/jq7dBO6O8ZDYoxmk5?=
 =?us-ascii?Q?VHQ+sOf9gj6VX0uNVDgKYDgaTh6RDWD3Jspsa7aG/Snq6lMBtZNjafybrxsW?=
 =?us-ascii?Q?yb3TL9I0EqAVLAU4q1ayPTLkCjRtMLAgw6Ar1BJzndaHrCrsH79ZZL8nwlf4?=
 =?us-ascii?Q?v1kcJC5ufxUORMslahWZXyqTCKJ8byUW/t89Hjjr4FYFys5AIda/7zvkk3sG?=
 =?us-ascii?Q?cGHlqAuv5oMo4dtNHN9MNeV+qk/DemhAp6sSHgh+KCk3WibVSmqvh5/mbYkZ?=
 =?us-ascii?Q?5rQt2UPuT/crAGlpn4LxRKLIT/AcRN7m90nAVob7vcSPlM+BJkP2lkN28aMJ?=
 =?us-ascii?Q?k2fwEBWJSFvT0747NCi2FUiRD06zhsyDikqDrNFJAxcVPZuxEbv4c/cB4JjZ?=
 =?us-ascii?Q?rkL/wL68/vv6l57TO5ZUO15RgHykReGIgJVUUgvNOLSBut9AELOjpYRxUeiD?=
 =?us-ascii?Q?/k/gIQiB9F7Ej/Su/PToyuVTjYdYTTQsYidA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:11.0380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab589cc-6914-47d1-4b94-08ddeeaa3e45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

When the "icmp_errors_use_inbound_ifaddr" sysctl is enabled, the source
IP of ICMP error messages should be the "primary address of the
interface that received the packet that caused the icmp error".

The IPv4 ICMP code determines this interface using inet_iif() which in
the input path translates to skb->skb_iif. If the interface that
received the packet is a VRF port, skb->skb_iif will contain the ifindex
of the VRF device and not that of the receiving interface. This is
because in the input path the VRF driver overrides skb->skb_iif with the
ifindex of the VRF device itself (see vrf_ip_rcv()).

As such, the source IP that will be chosen for the ICMP error message is
either an address assigned to the VRF device itself (if present) or an
address assigned to some VRF port, not necessarily the input or output
interface.

This behavior is especially problematic when the error messages are
"Time Exceeded" messages as it means that utilities like traceroute will
show an incorrect packet path.

Solve this by determining the input interface based on the iif field in
the control block, if present. This field is set in the input path to
skb->skb_iif and is not later overridden by the VRF driver, unlike
skb->skb_iif.

This behavior is consistent with the IPv6 counterpart that already uses
the iif from the control block.

Reported-by: Andy Roulin <aroulin@nvidia.com>
Reported-by: Rajkumar Srinivasan <rajsrinivasa@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/icmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 59fd0e1993a6..1b7fb5d935ed 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -710,7 +710,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		rcu_read_lock();
 		if (rt_is_input_route(rt) &&
 		    READ_ONCE(net->ipv4.sysctl_icmp_errors_use_inbound_ifaddr))
-			dev = dev_get_by_index_rcu(net, inet_iif(skb_in));
+			dev = dev_get_by_index_rcu(net, parm->iif ? parm->iif :
+						   inet_iif(skb_in));
 
 		if (dev)
 			saddr = inet_select_addr(dev, iph->saddr,
-- 
2.51.0


