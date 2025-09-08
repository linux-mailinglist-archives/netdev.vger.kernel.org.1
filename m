Return-Path: <netdev+bounces-220716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB5B4856A
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661407AEAD2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7D2E7186;
	Mon,  8 Sep 2025 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rFp1jziy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBD1DF73C;
	Mon,  8 Sep 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316919; cv=fail; b=EmDT44vFV3oZkRjDhynCTvYrVoLO3YB9HIoD0j5mLLNy5R91eWV9bkuVpzR3DB4jXjt4gukaY6CuJVUFOM78ZX8yu6FHhAg/DdaBJKGrSZAwie/MsJjkC8gLIHlkBKZzmJhw/yvRmkAN/Rou7k51XnpAevduu9y2kU6cGp2Xmeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316919; c=relaxed/simple;
	bh=KxwjmXP1C9yZ/V0ns0FhfMH5pD1iQyb2m8as6lclrLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOSnrB+lKfICkYc+A8KncdLIHdOy0lBRSGOmJwydTP8Qpi0KwuTAz5aRyqlajfScvBt5iIq78V3u/iXiS68DGIyB+KRXiI5FixqVkAZn0dwxzwMD0jjvPGs/AWIu+QgCnVJHjw8refPZJjpPtIwGYqB82HlTMEcJlL1jGvVZnS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFp1jziy; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAdfbB3Z9OYgWtn9gICvZqv/XPitQ+MepxCNVxuLJ6vdIy9avX5MxpPACXGuh/WlmCIYJc6FoHDbsNbM3zwWOjgr85u4Q//sZLcGuCEgMTYIzQ3+fDt5NjuUAjlUmFumNgUCVKaLbmhBB9liWZbSMHV0gsqT8KQ8Ywv82VosgQjGfFlPRs/5IemqvEgo/TYIevFj0uYv/eCRFpEfsarwRJM4bUN0zA3p4VTBXxwztatKYQ3nTZT3K3pQXYxuBMtKCHv0mWWdGPZr4+MKcW8jvYYKE+nNiEM2HoP9MabS80jXk1c6+nwaVqadmAZ0mpiWmSc39P/UvoTRepxl9A2nPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba7KGTX1Bs0J1KhcSly6NFLyf7g1UHoTV6m/mwJ9q1E=;
 b=xbQZ46GhRhpygudLvMv2+9Z5odN59qLh3OVLbGBJanp5YKmxlq606mB629IAHSPvxuGqnZnb17UxyZkhPoJozGhIHiqz/2Y0zmYbx5wIg1BalfqIRWn3YXmKLkx1pT/J6yt/unWCVmRG1QqjPxhm7DfmDMfF+fNaDDJ0iBK6IuFTEN9bnmBOep1rAzdR8PqVe63yIr9pEu1e3heZlSjaGXExdICBObPFIr0nAiovsaA+daRATs+BBQVqS5G36aU3b3UHUoanE/jgOmbzINujiWNkA+9wzHrE/B+OwjsKwCy9wuJT3T/0e93xTtMrYqgkNWzgVuTKPvKipyRWNYO2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba7KGTX1Bs0J1KhcSly6NFLyf7g1UHoTV6m/mwJ9q1E=;
 b=rFp1jziyAaMa/LuKAxr5OE7ls8IYc4BjJyX9kpZCQ5bnsVkJZRmB8Otoy8so+nzAcn6A7bvkiuB68FjvoyMBuQb3yIGF1PhhlIKkfv2fy88lp71X5uHjsZPADKRW30fzogaTlkRRaOPeirag9dnb9UkMIGc0+3sUYB6xNJdrMeWDoc1Q2SSBEyv48j9ykOXr4sbVw+cCIbtCB5LKcSrL0yd1kU42KSNvhB7jK5XmtaHxIShTb9ELahmfZTYaFBbV8ZpNC5gbIHe+QfjI5RbsKSOeiumnhwffnEYr9ZRIPUJ6etechUDoqOY9/wZXxowSx58NvLauevL7qPCrOqaR9Q==
Received: from CH0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::15)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:35:10 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::29) by CH0P220CA0007.outlook.office365.com
 (2603:10b6:610:ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 07:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 07:35:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:44 -0700
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 00:34:28 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <paul@paul-moore.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>,
	<linux-security-module@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 2/8] ipv4: icmp: Pass IPv4 control block structure as an argument to __icmp_send()
Date: Mon, 8 Sep 2025 10:32:32 +0300
Message-ID: <20250908073238.119240-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: c523a058-3aa0-4801-9960-08ddeeaa3d7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YgTykAta7TjvFindfWRpJrpJqC7ZrvU5savtQMVJ1jPaDAuDd7YpUGSNxPhm?=
 =?us-ascii?Q?Pq9U4/JPTwY3EYJ4UCkKrKYgpTYhGt4SwOjr81ifw96Y2cucYZrZ58Y9JPpj?=
 =?us-ascii?Q?mMvUoXigUpVL4QLKnqzxjTFhA/dAxwwIILpmwmGAv5Hl96FsR0AoFNoaH4TO?=
 =?us-ascii?Q?R95bFKUk6k0IHxS4jVGzzmq38cTPUYVkXn7n5dK7YY/JY6vNyXPyXN+kh7Rv?=
 =?us-ascii?Q?zU1fnqxSzNecNHRKpHDGXYLkAjOMUnlUwLQSFVmB8zr17i8F1hrFZ895kEZr?=
 =?us-ascii?Q?R9RCciybWLvAHmrXnPn+y3kE0GhT2futlHUJYfjPsCBYOgSMEtoeilVTF/67?=
 =?us-ascii?Q?4xPLoCPQyrgetLTUVDbSIdN4DMxqp4xvrJTv3yx9DWk/Xzle/Eb2y+dksjK1?=
 =?us-ascii?Q?JbCmyYuKvsNzfQpfvbTU7JAfHOIuJ3OowSyXdDGMy7nRoX7UAsgypq2v/+9u?=
 =?us-ascii?Q?NXTfRCq7SAusSmLuDfqORerxxszbHQ9YtlF2uOAp7q8sR4F5LRdfDO3ygYmo?=
 =?us-ascii?Q?WBJiNJsHQ3AQ5pHyWnmEl7reJVDTikZ9o1mw84iRfS+SZ2Z080SjxVkC8AbZ?=
 =?us-ascii?Q?tLiyVyrB0V3T9NC8VTqVlL5Vyvtm9G83Iwua/yRKZ8IcJnArXx/L/pcR27wE?=
 =?us-ascii?Q?Igr+xjH/PEIrZONSOoABfC21EMlhS310nznM4Ha2JdvZ7plw4KuTXx7FLBQX?=
 =?us-ascii?Q?iH/+F8lBdbsdTqzA7BOIWxwdRSV9xmT0gXOnNidIcxqSWhLjS0WhW68bDfmU?=
 =?us-ascii?Q?0UlrgpARA9NDlLm39FgBSGnSL4Wo1MOM2u3ZLYjpufA5N3Cb/FLGUDCf+JjJ?=
 =?us-ascii?Q?mUs3Yksq0fV0E+JKiNF1s0rGNqbrpstz4rVGDVDsj+C2YAXwmZuhtV5dH1V/?=
 =?us-ascii?Q?qUV1eqF+jgIabldmuxfTeND7hhZGaIvTUtOGckFS9FAu5xdbNeX9lL2szX2D?=
 =?us-ascii?Q?R3OlOWqQoklcnwEtZFu8s1GLYpqxmwiYT8XCf/7c+9EY8zCRkcV3sVlrk8OA?=
 =?us-ascii?Q?1XwNVYvi6CdV2woGjSw3gOov+3IQWN3hS5V4W8AuS7OHUK78sx+Z6dOZQY+O?=
 =?us-ascii?Q?j+YjC0F1/lH+1PCUVDqUJ06ZcX/+mQ9/f8pyLEAX1ADqTJelaWMUrXhlFUPn?=
 =?us-ascii?Q?ANaT8uNhMr6xWk2l966yGdNKAcjQ6chklJr59JkJbLcrHco9GntvXoeQ3AJb?=
 =?us-ascii?Q?bK4Vb3xOuTbegrbWatyoluy4Lk8adTZW7BmQAkSok45X12qHuyL8qX8YYl69?=
 =?us-ascii?Q?84kXToWsPhoMRaRUEcGX++kFukWOCs/BRnTkUnQCl+X5ecD8sLDRS5aMtkIn?=
 =?us-ascii?Q?OqGc9tkAstFrWhdt/VRJsR4CXS4URdh2UNkBWPKYpH+s//a4lFrkrqcgvCFT?=
 =?us-ascii?Q?k4vzmmYTl32PMvoRwR89yCm3Xa/lNJpNBH8uAt8Hs3f30zJGs+mpSQW/2eip?=
 =?us-ascii?Q?JPtQUQwY8ciLmyI/W/GVi/lPweRLFJSXmnD9L3W/OneyBwZMZQUJLcb1ldYl?=
 =?us-ascii?Q?WnmZ0QLRw400L6jNQ89UHJf+5zMOwZ5cZFk1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 07:35:09.2915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c523a058-3aa0-4801-9960-08ddeeaa3d7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

__icmp_send() is used to generate ICMP error messages in response to
various situations such as MTU errors (i.e., "Fragmentation Required")
and too many hops (i.e., "Time Exceeded").

The skb that generated the error does not necessarily come from the IPv4
layer and does not always have a valid IPv4 control block in skb->cb.

Therefore, commit 9ef6b42ad6fd ("net: Add __icmp_send helper.") changed
the function to take the IP options structure as argument instead of
deriving it from the skb's control block. Some callers of this function
such as icmp_send() pass the IP options structure from the skb's control
block as in these call paths the control block is known to be valid, but
other callers simply pass a zeroed structure.

A subsequent patch will need __icmp_send() to access more information
from the IPv4 control block (specifically, the ifindex of the input
interface). As a preparation for this change, change the function to
take the IPv4 control block structure as an argument instead of the IP
options structure. This makes the function similar to its IPv6
counterpart that already takes the IPv6 control block structure as an
argument.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/icmp.h    | 10 ++++++----
 net/ipv4/cipso_ipv4.c | 12 ++++++------
 net/ipv4/icmp.c       | 12 +++++++-----
 net/ipv4/route.c      | 10 +++++-----
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/net/icmp.h b/include/net/icmp.h
index caddf4a59ad1..935ee13d9ae9 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -37,10 +37,10 @@ struct sk_buff;
 struct net;
 
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
-		 const struct ip_options *opt);
+		 const struct inet_skb_parm *parm);
 static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
-	__icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
+	__icmp_send(skb_in, type, code, info, IPCB(skb_in));
 }
 
 #if IS_ENABLED(CONFIG_NF_NAT)
@@ -48,8 +48,10 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info);
 #else
 static inline void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
-	struct ip_options opts = { 0 };
-	__icmp_send(skb_in, type, code, info, &opts);
+	struct inet_skb_parm parm;
+
+	memset(&parm, 0, sizeof(parm));
+	__icmp_send(skb_in, type, code, info, &parm);
 }
 #endif
 
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index c7c949c37e2d..709021197e1c 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1715,7 +1715,7 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
  */
 void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 {
-	struct ip_options opt;
+	struct inet_skb_parm parm;
 	int res;
 
 	if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
@@ -1726,19 +1726,19 @@ void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
 	 * so we can not use icmp_send and IPCB here.
 	 */
 
-	memset(&opt, 0, sizeof(opt));
-	opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
+	memset(&parm, 0, sizeof(parm));
+	parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 	rcu_read_lock();
-	res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+	res = __ip_options_compile(dev_net(skb->dev), &parm.opt, skb, NULL);
 	rcu_read_unlock();
 
 	if (res)
 		return;
 
 	if (gateway)
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, &parm);
 	else
-		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &opt);
+		__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, &parm);
 }
 
 /**
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 863bf5023f2a..59fd0e1993a6 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -594,7 +594,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
  */
 
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
-		 const struct ip_options *opt)
+		 const struct inet_skb_parm *parm)
 {
 	struct iphdr *iph;
 	int room;
@@ -725,7 +725,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 					   iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
+	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in,
+			      &parm->opt))
 		goto out_unlock;
 
 
@@ -799,15 +800,16 @@ EXPORT_SYMBOL(__icmp_send);
 void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
 	struct sk_buff *cloned_skb = NULL;
-	struct ip_options opts = { 0 };
 	enum ip_conntrack_info ctinfo;
 	enum ip_conntrack_dir dir;
+	struct inet_skb_parm parm;
 	struct nf_conn *ct;
 	__be32 orig_ip;
 
+	memset(&parm, 0, sizeof(parm));
 	ct = nf_ct_get(skb_in, &ctinfo);
 	if (!ct || !(READ_ONCE(ct->status) & IPS_NAT_MASK)) {
-		__icmp_send(skb_in, type, code, info, &opts);
+		__icmp_send(skb_in, type, code, info, &parm);
 		return;
 	}
 
@@ -823,7 +825,7 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 	orig_ip = ip_hdr(skb_in)->saddr;
 	dir = CTINFO2DIR(ctinfo);
 	ip_hdr(skb_in)->saddr = ct->tuplehash[dir].tuple.src.u3.ip;
-	__icmp_send(skb_in, type, code, info, &opts);
+	__icmp_send(skb_in, type, code, info, &parm);
 	ip_hdr(skb_in)->saddr = orig_ip;
 out:
 	consume_skb(cloned_skb);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 50309f2ab132..6d27d3610c1c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1222,8 +1222,8 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct inet_skb_parm parm;
 	struct net_device *dev;
-	struct ip_options opt;
 	int res;
 
 	/* Recompile ip options since IPCB may not be valid anymore.
@@ -1233,21 +1233,21 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 	    ip_hdr(skb)->version != 4 || ip_hdr(skb)->ihl < 5)
 		return;
 
-	memset(&opt, 0, sizeof(opt));
+	memset(&parm, 0, sizeof(parm));
 	if (ip_hdr(skb)->ihl > 5) {
 		if (!pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
 			return;
-		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
+		parm.opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
 		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
-		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
+		res = __ip_options_compile(dev_net(dev), &parm.opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
 			return;
 	}
-	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &opt);
+	__icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0, &parm);
 }
 
 static void ipv4_link_failure(struct sk_buff *skb)
-- 
2.51.0


