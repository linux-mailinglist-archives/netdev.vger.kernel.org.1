Return-Path: <netdev+bounces-101559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB148FF5FE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C451F21748
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1962199E84;
	Thu,  6 Jun 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BN6pXagy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BC1993B6
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706066; cv=fail; b=QUc/gLMGZi/45klPwo8Xm2gbKDGBM9rYd70JZd9heobvTJmEdZwNwTAXAKZ1VtDzawTO8aYrRQEZ1MNe4RkSu0JmM8WpW8/5Spt6e9t+v4CPrmUFsT+RTbOnTFzZzNiElbrYtuHqAtbd6CVoa+TJRDe16gi1OVIdZHVpRgWQLAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706066; c=relaxed/simple;
	bh=0brhIcWnjqA5RcKJheoYSebmiCObYZEYs1tdCvLJCJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r//OI0rquAi3UnCtZfvshKSs6cH/W0YFwJFPZ1awIKtDAYaYjNh52HwGTlJGkD2jIwdWG6aC5rFj18v8z0EZ7lPKvbfPG1dRPkyXL3AxIqc95AailVrVMr6zeCUW+/5BkTn9Zqu4HS0XrcMvs6a1QXgBemVDflio/nO0zS9wF/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BN6pXagy; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMTI7laZd5Tm5tl6I3ZUfcBYUeVjBKZVhLMrz3lbv8RxQyy+zIgWcmacZ3HuS/N7bbSqw9SWqtnJjloLTTUebDVCKMhv8T4gMVkofPHPFvYJokaARDszo5pZ7V/ygC+fcFWB9UXtgU4QviKhU2i037BP99si87oT+PVr7Z1Z07sFfGhHyxetdEVOBInpbXCKkYYZ0RDi+BV8El05j7+b6dmWczhWCKG8h2yV8Sq7m9n48pmU2Js2nur/rFf5S65wZ+9pq2Lm1V4OLlUSZgvmZNbQugDVXUDqMMqH7GXB2HM8mjIv9br+8rXgtZJdT7sP7N5evCN8jdNZVFMKnzeKIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oGl46mGrudfS2grwLqT4l6snpvsoqSj1I7b/M1PtAo=;
 b=jMc+RFZHgL1qB3+W0F97ewxNCpG5pX24TFYVHCjSnC0EFuACgnKjdNaWXFzBbh6z8TPzSer0wOyH2e9Vsnn6F0wGoQfn/OTtdJQX23UuVvFRcy+STGTZAt+gnYrxGZ+CKsPBzBt8tzLTuQnPepjXXV+vx0Ewak/1OyWu5/z9opDbIFrhVAvo0JGH4PeCtOlYW9SJX8NdVb9NvWJRsc+3wN+q2R7i2TqUSUpfoC8DsR18EDnAJLgv1wtXPxePucrfoXHWkrqDHW6HkiJ/hEbtADEBOX0ckIrSitYVJ1rGOjhRMgzzKqEpxHqnrpp3u7hqN0u/psM1UxNQ/DNkn8Bvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oGl46mGrudfS2grwLqT4l6snpvsoqSj1I7b/M1PtAo=;
 b=BN6pXagyugcFFQke28HzXJ30wvN53Eja4xNutY5kxmxbdAFZTSvsiEKaXws5DlN1NgB9YbqVfjQMXBdxXf+n0t2usT4kMsR2XAZ8BXhGsXDOOuhfuybPti2N3fSW0ShOkjwi8wovgtUA06K9BXbd3VMhSSxX5Kqhz/FwQusz26Zc2a4ew2sViZ/klNYu+6uyz5xKA39RjPayPyZtO41q3EK5YJafukt+YdJKx1U3G8sp5AUNLq+vY5mUl31fqRbJu3H6biz/jKtSEiCqWT203TJvyP6+9qfn4OioyiuzLQDCMNZgsSl8qdbMFWQ+kZopPE2d/aneLR4cGQQ3A1bNog==
Received: from MN2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:208:23e::25)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 20:34:21 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::bf) by MN2PR14CA0020.outlook.office365.com
 (2603:10b6:208:23e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 20:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 20:34:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:56 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 6 Jun
 2024 13:33:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/2] geneve: Fix incorrect inner network header offset when innerprotoinherit is set
Date: Thu, 6 Jun 2024 23:32:48 +0300
Message-ID: <20240606203249.1054066-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240606203249.1054066-1-tariqt@nvidia.com>
References: <20240606203249.1054066-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 2635215e-d8fa-4fad-b381-08dc86680bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3EnAqlWuJAXmqj0cc51AXsSp8B9tQmblaBgIYDZ5Z8HPLomzzw9tt8gCgku?=
 =?us-ascii?Q?iij6KCW8RsgBjM+bTJVFmJm1XE4B5lMl4bWItB+qZdxj65lkabBlPzXTsMw/?=
 =?us-ascii?Q?QcyhwHxvgkTpA03PZQvft7XyfwqrS/z9PGSyImAaGaChZN8DjcTTZFj1PqKw?=
 =?us-ascii?Q?LmPKxi0CQ4KFqhmxS2dPWekcCnJvPlHG5POREtcKDoqJOpOFM0Ppps1Rw4Qd?=
 =?us-ascii?Q?x+kVWwZMGatme/wknCSbR7CLRW2A8fowIUw4RsJtr0NZSUw9kPKjPHwVoE0e?=
 =?us-ascii?Q?4rBxfdxbnkj7Uxs5gnBXZUN+l3C79Pxy4LEND7VmRwfsyDcYaQ8ciF8q/Hsd?=
 =?us-ascii?Q?pmtD1uHhFh+cU5fBWWcLooJRmDZyT3o+MIDJo6EDJ+zT1f5h6zhrNm/SgyVn?=
 =?us-ascii?Q?fb+OP2YZe2Wah36X8GGyREneD4llejDMu0iZhNCdlOGH6lz0Xw/vvGpuxREt?=
 =?us-ascii?Q?MrFpuPKSuViUcagx/ecDk4k4qGE11wsgey4wXPomDooRP0rAdOoK4VRG/dBL?=
 =?us-ascii?Q?JD6cHpnPZdE4vu24sZFg4Kar+7ZP43CFl8xcj+wkBJ9k/ShzxCYyTCFlgAYb?=
 =?us-ascii?Q?pH6tHtFFsFmQw9cCq/e6EmGiMxFVyzn3ZDwYz6EqH+e/QIHlQ1pAInCpETlV?=
 =?us-ascii?Q?+p1ZbV325Pu7CmWimwrHHYHchtW2RqqYCDnu+4GGa1kCLks3qSKaYkJnQXLy?=
 =?us-ascii?Q?W38e6duacpgClq2A5HhLFd96Of53yLYK63wfOV+mj4BIPq6Z+EKztvy8ESHH?=
 =?us-ascii?Q?cQ/JeovA9vrLyd0pYT8oUSZv7C/3F4yCByKsn8uvAobxWSExD6+ZqV4txsup?=
 =?us-ascii?Q?iGDZ3sFwlT8BEJur7dTEBjPez+O4I6z5G3Vda4AdvuNi+pAA577PHPsHRRI4?=
 =?us-ascii?Q?8/mr3MLjg0I28qciVkfp+DtWZDBhXFouDcfbpeInoUm3FIapm1lnD8Tb9T14?=
 =?us-ascii?Q?PLGx1yEa/B8cA8P0dgyzD68TB7geYkObROp/XYFai6FtzsdQ2/7T6QgLnt7I?=
 =?us-ascii?Q?Kahzp89xSNtj1JRTO3Zv/mtzlSp0eUf5ecwXBPCfbLGnjdOeVm83nMjUD7c4?=
 =?us-ascii?Q?daGhBvS6vAuKlIVXHcc8mQOBLO7X7qHgC4XmRRjhrCjrNGHMha+RJ6EDzKkH?=
 =?us-ascii?Q?loB5rZOnTcwdcw9ujZDKL+xYeQ8qDppWdIX4Oa6Pky383maRChrQLYyqwLkO?=
 =?us-ascii?Q?MybS/B1TbkEEeO55HMCx5sVHMHwFhHz8TCIv5FGTk4AzhEf5SrKkoLdLBilT?=
 =?us-ascii?Q?qNG/OIHf/mxHD20Qjq0b8ndHaF1wdrOMxqNoFb3X9or6LCuPdaRTcvz8b3Ad?=
 =?us-ascii?Q?rYv5cQoeoq8o4l0z5FqWQLEDguWBe1fV5JXieW4gF77F/gukXN/xwX6QCtYf?=
 =?us-ascii?Q?ZyJQWyTMUVpqQsANrc2Y+h0uFEY2nJn+pkpd8VCU81KZwx93UA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:34:21.0749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2635215e-d8fa-4fad-b381-08dc86680bd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

From: Gal Pressman <gal@nvidia.com>

When innerprotoinherit is set, the tunneled packets do not have an inner
Ethernet header.
Change 'maclen' to not always assume the header length is ETH_HLEN, as
there might not be a MAC header.

This resolves issues with drivers (e.g. mlx5, in
mlx5e_tx_tunnel_accel()) who rely on the skb inner network header offset
to be correct, and use it for TX offloads.

Fixes: d8a6213d70ac ("geneve: fix header validation in geneve[6]_xmit_skb")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/geneve.c     | 10 ++++++----
 include/net/ip_tunnels.h |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 51495cb4b9be..838e85ddec67 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -815,6 +815,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
 			   const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
@@ -826,7 +827,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
@@ -908,7 +909,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
@@ -925,6 +926,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
 			    const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 	const struct ip_tunnel_key *key = &info->key;
@@ -935,7 +937,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
@@ -997,7 +999,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
 	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 9a6a08ec7713..1db2417b8ff5 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -461,9 +461,10 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
 {
-	int nhlen = 0, maclen = ETH_HLEN;
+	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
 
 	/* Essentially this is skb_protocol(skb, true)
-- 
2.31.1


