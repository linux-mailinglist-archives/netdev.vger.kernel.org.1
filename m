Return-Path: <netdev+bounces-195855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3AAD2819
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F73F7A252D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08795222594;
	Mon,  9 Jun 2025 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eWaaEUkd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA782206B2
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502339; cv=fail; b=uwcpFkQw2Tcu9voE2vQxCXjjchNY1i6qmg4PsrPYSWqAunNQ4hjWNmXRbr3j4+ZImS5pB05ZXeox+krIfxeHqOsOs9MC4PSiyzS2DCeoboUF2C0oZVDUesrCocTqJjm3Us9eMaRUKoMNrL87k6i5p2lXtZAz5Cgo5IQC1CL/miI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502339; c=relaxed/simple;
	bh=WJdp0RJ+eb98e6+44rVa4frYUOmi8apZkzj8P2HGeoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FcfEm4JoKA2O8agn+4SIErcAuvuwmJvGw7ktaM4tX+9O9Tie1OdS+qftDg8do6LjXbXwTZuddRFdPfn6q71gBeQ8HAN4a3B28Tc4rPYogZmoWJpj4zYYS/2G2UM3LZTpWvsFNG0uU+Xs9iH0c2uq3agPEVSs7mANrm7dmF7AWBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eWaaEUkd; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T80ddbDKeJnNMoKNEA+6hLs0OiiB1IB2w5LISHjRP1jrxfDYj+RK8VcMWjJOpyFPE+lzdrojMfl1HTMWfBqymH6OO7tRGVNfs1Qc9jh5YD9Bw8CsQoegqGcygP9pwu5DMTu8/0LbX8ftSwAndKzuMzgVTn99gPcCZ5HMBKijYI6EwLtSsfvh0QmRWphNu7T1PQKWGZPx5UbeWiHlf7rFhPAv1FVw+Ibwpw3AOUC/w2MUszpccl+zCpMfiuLtS5y//QD2lz+0jEZdtKrbyRa5/CMPUGMHgU0Ksbf4MTlBwNqhiv9oWM8ILTlnt61XlTq6DU1tJwHp9ZTbLP40Cr9h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n69KqzVhC4B7Qd9olsYlF25RggHHkcdAZDfeFLDinJo=;
 b=g1oorZaS3qaEwrKdemkVY7fLkt3mRgdpjYlmBz0F5HgoBxAkJXJlXblB2TyYC+HbBtQ4aQwNw+79gREyG98xnZec3DAG8Roy1KfDA1n0Vm8MQKPsVxI4lNlwdarfiTPpVupxfFKLZ8UYIrKAQUK3rtj2Rr72jFGuWA5IMlKCerR+IuA64xKA2MpskkZgtv6/fhk8EeOQHXZ1g4gNep1pCLCZMkfn4Qi9KdJKJTVRYEWcw+/zC13y8KSXcj5jKbsRZKgb20LXFm6puCXncOEVzRQk6EwRd2rOkyafiN2IlZOkbwXf9DQOWU6qg7xCQNCPN74YdhnGkMPCmbalLkJ/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n69KqzVhC4B7Qd9olsYlF25RggHHkcdAZDfeFLDinJo=;
 b=eWaaEUkdNY0tvW+gdeMxtlI8orTldaKjRzmZm9sfivk7KQS9LZ3qzE2UiM6wxtfo1rQctcxgH7Rs+rROzvMKzY0fY2kvPC7UHjQljMvI/ILDw4s/1HKOm7IxMHJ6F8exy2tandDU+aAKGjoaggniFFDYMQihKwfIJSzxqhPrvE0a5sRuUIW5H6KJ1hs08oEYVKjXvkLNMIKAE450gAM9t6n+tYsxGNJj/NqpvT9tYlpN21CZT6ghTdZlCF2ySg2gH2JH+AXOiBOnT2oLLmOdYqG6OVfwbVyjQiLJjRoSu+/C2lZtiKZZEiDRCwoYT9ILHZOtJ2iidfzuwSKF8B6WIA==
Received: from SA0PR11CA0077.namprd11.prod.outlook.com (2603:10b6:806:d2::22)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 20:52:15 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::ee) by SA0PR11CA0077.outlook.office365.com
 (2603:10b6:806:d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Mon,
 9 Jun 2025 20:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:51:56 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:51:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 08/14] net: ipv6: ip6mr: Extract a helper out of ip6mr_forward2()
Date: Mon, 9 Jun 2025 22:50:24 +0200
Message-ID: <26200b4fe0680cc340da11e6bdfe0a67d682552f.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b947672-afc9-4074-67f7-08dda79783d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5c3STmDexpg3fYut0HkJifn8EBPB6PUtQmU9a1yR59bxegP9uqoUuuQ6QiX?=
 =?us-ascii?Q?/NqPoH1kK03vNBgqPRDyRhDp7tf4c5I8d/nvb79RaagM+xb4wEzIY3gjDo+M?=
 =?us-ascii?Q?M+zPaoi5EIdL2XJ5KC6BO9wvvuC4HdLThwU3Q3gAia5nK6JUg8AM8VqgVr5X?=
 =?us-ascii?Q?4A5MyPShESO2Nqb6mc1+QQCerjfhMhyDROoTlmeL1T2VUfURd28IvkS2liCD?=
 =?us-ascii?Q?wV2/LeXbPRcoU8ewVtstuWvnk6u95+WwUPH/E8Vi/1bRNAC/Krksrcw9ivwB?=
 =?us-ascii?Q?uPnBYcUFjp4LfS/VZ77Av0rmwBXRS0S7jlZjA17WPTj1EtiEiVXY9A5QOVDZ?=
 =?us-ascii?Q?/+3zF+xT4TVeVRjSDoFeXrjlWP31XqY+CiROJc7ZyS7IaYlDroXyj8iU9b8q?=
 =?us-ascii?Q?h0vil3NoD1avXPYmf3MT5MULo8h4gcbTgxGIqRMj5GZtR/okNRt5+YxVMA4A?=
 =?us-ascii?Q?0csneVfVrHWtPGtV7XgaUwnEbAcbhs4Z+euHWzafiz0rPUs1Oo24J/7xWMiU?=
 =?us-ascii?Q?FXRql2DhGE/UZ72JMdZPd9DU+wlsDTmmeELq4LqfhfnBWCr63HSLmzdYQApJ?=
 =?us-ascii?Q?aFd3UtyP+1nF3o0EX6yDCtg2zAVLy9pR4HYmtaVIg4Mj9EzV5jCdJ0zdNYqc?=
 =?us-ascii?Q?3IY/5jinRz2ikYIvZYl/vaRrmRdXHUMPY9ct+76asUxXGgRu+lrDYLkWeMKe?=
 =?us-ascii?Q?Cx0xwT9OI7g77TS3Ikz2XOKlJS5M4MoUDHULiLtaJgxd0sdzvSjBy9YSgSoj?=
 =?us-ascii?Q?/nMoF6XKcgyHtujpwGOIRWt8o/qaye8jC2tJVD+q2CaCOHA/7mr9MV9JTcd/?=
 =?us-ascii?Q?/8weaVGLz3naJMEGhqpYgQaHWTttKzgcL21IqJauG034ruZgpO2x7ZSGg9sW?=
 =?us-ascii?Q?7WSN0N/j3syM0DYI1ZFz0O7euFiPtOaVP47+i9lS/FEFGV5jAGRpttdLudZK?=
 =?us-ascii?Q?q868nOOh5D8gWrJZT+iVL8Yf9RnbTcNAVy0h6i2iFageFXZN8zwgxWXRBRKi?=
 =?us-ascii?Q?+154/b9an/dEIgbuiiIZpFBFDEcrn53UQP+iOQS3RM/TfDAB4sPatumeq/dP?=
 =?us-ascii?Q?cHPLvyXmmbvBlGaa6DN+QN43TzQ/siWJY62dpOZv73obwXuUHXaeG7MqBPuy?=
 =?us-ascii?Q?aOpTF+B/KRzav/BtU/PH1H0vHV9OqfRlFY6onnUSEGc1qV890vHoTl3YBmTu?=
 =?us-ascii?Q?VjaImW7RJx0MaXF/Kulgrj4pIt1jXinqZytHSmoMWUrrBRDzxk4vP6bfRfkg?=
 =?us-ascii?Q?98ZWfFcghkrhrnbPIi4jAyIyxiFDhrKWwx+tcYcYL4gE8AJ87c1VsoiEdYUV?=
 =?us-ascii?Q?a5U+nPD3zt+LoKrCzFmYbFDHxzyXu0jj/WswYMOuTDSjGtnYba46ulSDOUqp?=
 =?us-ascii?Q?RV+TeCSlj48Rs2dI0FxQ4OYwwRWKRTfM7xnmtqXbjql7XYm0fLDBEiYWw7JP?=
 =?us-ascii?Q?Xz/Jdndec3f91LA61Clk5aJg2IkjumwlnDD+RpKq20uaRgysF1n8W78n00e1?=
 =?us-ascii?Q?vCyzIJCdGAP+1Brs5ahRmUmvxeVa5jrdt1Lt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:14.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b947672-afc9-4074-67f7-08dda79783d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461

Some of the work of ip6mr_forward2() is specific to IPMR forwarding, and
should not take place on the output path. In order to allow reuse of the
common parts, extract out of the function a helper,
ip6mr_prepare_forward().

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ip6mr.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 63c90dae6cbf..03bfc0b65175 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2035,11 +2035,10 @@ static inline int ip6mr_forward2_finish(struct net *net, struct sock *sk, struct
  *	Processing handlers for ip6mr_forward
  */
 
-static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
-			  struct sk_buff *skb, int vifi)
+static int ip6mr_prepare_xmit(struct net *net, struct mr_table *mrt,
+			      struct sk_buff *skb, int vifi)
 {
 	struct vif_device *vif = &mrt->vif_table[vifi];
-	struct net_device *indev = skb->dev;
 	struct net_device *vif_dev;
 	struct ipv6hdr *ipv6h;
 	struct dst_entry *dst;
@@ -2098,6 +2097,20 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 
 	ipv6h = ipv6_hdr(skb);
 	ipv6h->hop_limit--;
+	return 0;
+
+out_free:
+	kfree_skb(skb);
+	return -1;
+}
+
+static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
+			  struct sk_buff *skb, int vifi)
+{
+	struct net_device *indev = skb->dev;
+
+	if (ip6mr_prepare_xmit(net, mrt, skb, vifi))
+		return 0;
 
 	IP6CB(skb)->flags |= IP6SKB_FORWARDED;
 
@@ -2105,9 +2118,6 @@ static int ip6mr_forward2(struct net *net, struct mr_table *mrt,
 		       net, NULL, skb, indev, skb->dev,
 		       ip6mr_forward2_finish);
 
-out_free:
-	kfree_skb(skb);
-	return 0;
 }
 
 /* Called with rcu_read_lock() */
-- 
2.49.0


