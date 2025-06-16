Return-Path: <netdev+bounces-198302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C61ADBD1E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743F117353E
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97A1E8332;
	Mon, 16 Jun 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mf/ZlccW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C801FC0ED
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113931; cv=fail; b=e15cY1MtFs8d/M4jUMXT5d8FLbgS7zD97TD6ZwpwKm1hC2oH1/t3dHTK7oewPEacn86v4GUn6BIlIWnVybvBEuxFHVaseIFLISHawY6GN2YlykCxpr2xQdECOcMD4mmkeCHFKaqzirgEjg+CIorvF+8Kw4RZFrt+fuKb/f4CjoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113931; c=relaxed/simple;
	bh=oVSYkewc0S9rYjsbDwY/9ksS8spEZlzdKcNELGg+6Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOuZXCu5CGbGzWhq8FEs7YwN0+PhhCmL1bQAchucj98uMU6pcOGWWbMGFP05MZtcMlnir5V+DTaLR+HzDLEOjWMyKbXUPz+MXtivYLfHMg4G5LFOfwvACmbPDqLc+gW6ZtqT+I+Okeckc7Wm5e1l28F7bu5NoaS/kUtNF9upUI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mf/ZlccW; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQqcWQ1uhtNwYUK4c68xA3S14BXt1ZPlMrO1iGfoaA0CFrNWUMkKFZEAZnp8viuKv1PF7jk0ggRFphebo963cVsbOD9LDQMwlCQb6YHWRaEkvtyYfA4AlTqQAQcRHPsSOLWX6SYjYjooywUCo3/XMwaGHB9awXeEaW/vfqehRYLqh8IJFttop7s+4IYU3E9aEuGPIApv+YlI/9VpGib0HetH0Y5E0K0YLgxlA2NxB52V4RInvepBj9riD/afzmiDNqgip495ZAIHjdqDkv2JqYMCx+cszZFEKe7VymHfNNqZ6xmYSS2uM/R9g98/Fb2VlW3uZsysvHs3KVmnA1VXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TK3mZ5mcJlF6lZPZQWzie33iK4QcDXUlKH59CMvYFA=;
 b=yd7It1iW+h03YjxGjz18F6CJL1TEQAaaUWPNKqSU20BZG90ZALKRP6HsPZa9aW6Oakvp3PZpTwUddhL+9ox8AHI4FzC7aUUD8SOroqJcWChTBYERAnRGkqhqdTMIbACE5EoySleokz+EbomldRFrcy70BbMxoJkEGlQinMBLj4c2LT9Aw86oA5MTd/WUDFUp7vnzniGMy9QvHYCoJ1UgWm6YHmmFhwABg3TsQQJzFkEuOnCjPbwPu9ZXJcukOkCr/BR/S4P0ZUj/+hIplhHDql+gnm1Mq0Krzf9LaxKdf0nlsxcm7AXhChGluVzlgY89nixLyGLIS7QUZhDqvytzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TK3mZ5mcJlF6lZPZQWzie33iK4QcDXUlKH59CMvYFA=;
 b=Mf/ZlccW8miTBmF40mc5v7i14px6GnWG9vwqdkK7aJAIVQg9drq9HUH4+Sx0xFf8aVTGpmjsEQTwmC86UuoOvuoQ9OrZH5CFv0fVi8cXAIouExb4GIHfRV615MB/H1O0HTuCeWQWd+COrlvcEV1e6+c3B3pkT29D2943+NK/I/uQ53qNOEcpceEnlyPCiCqJt7SCpYKSPZghtPuZJTDqCyCyr3AwWAaK1H0xOQcMhtvZuZXb7uIMEkRQY+0dHxBwm2BXaH7iBuzAu2UlkaNS7V0Jbl4YYB1jGYeKH2m8sTAmVpw0rLpuyJWzV8kfQSAc0ErLP0kpFgDF+Zar7ugXKg==
Received: from SN6PR05CA0031.namprd05.prod.outlook.com (2603:10b6:805:de::44)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:45:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:805:de:cafe::7a) by SN6PR05CA0031.outlook.office365.com
 (2603:10b6:805:de::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Mon,
 16 Jun 2025 22:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:45:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:45:08 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:45:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next v3 02/15] net: ipv4: ipmr: ipmr_queue_xmit(): Drop local variable `dev'
Date: Tue, 17 Jun 2025 00:44:10 +0200
Message-ID: <c80600a4b51679fe78f429ccb6d60892c2f9e4de.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a7c41b-1f20-4bf6-2498-08ddad277ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I1phveIvUsLnEKLCELYnlyJob4SWyrt0FaBLjFYyCUhTXawhavm39320Iye/?=
 =?us-ascii?Q?c0/MCF56bdq0fDwBRZykrmc/jWfmOu3gjJ+4rnxCaxHhDth2nFJVuzyuO3rl?=
 =?us-ascii?Q?fkKW8lpKWK9+1nHqTjFJuJTg4YGbe7GcDiT4lxEr0ExUnMxkk4vnStrWdmNS?=
 =?us-ascii?Q?DL1fOByQbaItZ4UXDE4+DCQOpmA0vGtqnXhC+nLJG9B+uuv44fFDvSXl+fnH?=
 =?us-ascii?Q?eSsH71hP6XvbeZOo7XHVT8rovQTDHR29hR4K9I1G0nanTLTAom0Sp37OvACt?=
 =?us-ascii?Q?iOvnAzTttfaQB00wAdDNyIvXW+RaR77/zd9IyjWNrK4T9uVKWOT/ajsWgOCl?=
 =?us-ascii?Q?sRUvAaLqp4ZEWm3D9sw9C2RGU/hXSdjiJN1C28lns0lUarc5xpcwoEEUxukw?=
 =?us-ascii?Q?lATu7cjD8XQ5zEwtkU4GKxoy9kwQI1frVcfbpXOOnIdc4kzI+i6bh43Z8T1C?=
 =?us-ascii?Q?w30aWd8DyDi9j6vBeyVj737bOW/p2CEX7WdAhyKy4STzQwDayh1XPGw/wEKj?=
 =?us-ascii?Q?ZnNPr2OuC6jGevnDtVd8LIBDfauraU6TSjaslg8jk0R9ckh/Gw6L3pEAuz3s?=
 =?us-ascii?Q?DROUK0GHfPLFX290NHhlCytt912ojff4trTuiAvJwDvbEDj8BHffw3Lb16z0?=
 =?us-ascii?Q?JDquYWEGPsbSmqXJaRTpsdT8U4QpvkI1GP3NFqqOwavb90rvwxGqBTrOHWgb?=
 =?us-ascii?Q?4Lve8V1yuQnLuz4gVC7cq5gnYXyjJaOwLtPSz7lzHp+munoj3pA4srnQf1+m?=
 =?us-ascii?Q?bWaKZenxnwCMXxv8IRWQKPaciXjkDmhFf7p4zDBU5N3XJP+SwafUmEjtIzqr?=
 =?us-ascii?Q?5nk0dv6/j/VRtzad87h+L+nwi9K9q1hkP3CwwyGcbNARmNGNBuhTxKh7nRfA?=
 =?us-ascii?Q?aAbQCtKi/mH0JI9iKDiZfzcmkK+lRMaqJlclZsGjyHiyMlBLUkYkKYV6HRDa?=
 =?us-ascii?Q?grw5i0r4Vj3J36g5mHprMr6Ya80/hRUfBQAuAr0aATZcNbkyelEzMKmHLhlN?=
 =?us-ascii?Q?e5lpf6JQEY9CDLkNtlJJY07MINuA7eNT+9zaqplmnUznEsEXW1Jdci/Vi8YQ?=
 =?us-ascii?Q?V0zxP8tBDSgh398MufQhtqoSeLMexWYKVNZhe5vXe9GsCUSj+rhlDDIfIy6q?=
 =?us-ascii?Q?Kdr+3KsURkQ2oR6E5h4anrnxmARy2PoZGlFI0pwWfDtJWEpEMt1P+gPaoQdX?=
 =?us-ascii?Q?HWTdzLckA0OVNm3Sdtz56jav7h5YY4Qt54hMIIplzm9D5VLmRyrB/Vx3RWlr?=
 =?us-ascii?Q?IASsO5OkSgSlNM+Tb2p4ld6LVoVPobDKNROLbOxLlgJzcnz0Fk1b6OVTjwp6?=
 =?us-ascii?Q?jLW0baWpibdjhEDVmMjjqpzS2fzdoqFDZJNIRTuSrQdtxBkZ4TyGIXXPscUI?=
 =?us-ascii?Q?xlXcBqsd0Gu3utfqYbcs3WeNHqqBePeosTKP1e9HwbgGNwDzcZyut7sGopM5?=
 =?us-ascii?Q?ePilYpbOVXoGIX09/W8QQZJoqk4mORDfMupDuosL2KhjeYyET9jJ1m0fMjy0?=
 =?us-ascii?Q?1Gqbdo7Y8StUa3qM9swDRKIrJKL8BDuCcjcD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:45:22.8876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a7c41b-1f20-4bf6-2498-08ddad277ab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

The variable is used for caching of rt->dst.dev. The netdevice referenced
therein does not change during the scope of validity of that local. At the
same time, the local is only used twice, and each of these uses will end up
in a different function in the following patches, further eliminating any
use the local could have had.

Drop the local altogether and inline the uses.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/ipv4/ipmr.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index a7d09ae9d761..d2ac630bea3a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1859,7 +1859,6 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	const struct iphdr *iph = ip_hdr(skb);
 	struct vif_device *vif = &mrt->vif_table[vifi];
 	struct net_device *vif_dev;
-	struct net_device *dev;
 	struct rtable *rt;
 	struct flowi4 fl4;
 	int    encap = 0;
@@ -1898,8 +1897,6 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 			goto out_free;
 	}
 
-	dev = rt->dst.dev;
-
 	if (skb->len+encap > dst_mtu(&rt->dst) && (ntohs(iph->frag_off) & IP_DF)) {
 		/* Do not fragment multicasts. Alas, IPv4 does not
 		 * allow to send ICMP, so that packets will disappear
@@ -1910,7 +1907,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 		goto out_free;
 	}
 
-	encap += LL_RESERVED_SPACE(dev) + rt->dst.header_len;
+	encap += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
 
 	if (skb_cow(skb, encap)) {
 		ip_rt_put(rt);
@@ -1947,7 +1944,7 @@ static void ipmr_queue_xmit(struct net *net, struct mr_table *mrt,
 	 * result in receiving multiple packets.
 	 */
 	NF_HOOK(NFPROTO_IPV4, NF_INET_FORWARD,
-		net, NULL, skb, skb->dev, dev,
+		net, NULL, skb, skb->dev, rt->dst.dev,
 		ipmr_forward_finish);
 	return;
 
-- 
2.49.0


