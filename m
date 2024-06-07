Return-Path: <netdev+bounces-101909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70856900874
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C577CB2584B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8A196DA7;
	Fri,  7 Jun 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ly+9ds/2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580E19AA62;
	Fri,  7 Jun 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773311; cv=fail; b=T+zD6HQtCE4Gxe8NvcQbI39CgbdxEGuDnpJVwE3cD8ABUljKreJarTS2g1DfjnZL/0LvdHYM8/1ISSjDJ1Gf4Law4ED87Z7AJ10/Dz26fHD4Y3vH4MNug/ZCyrz3giPqLwW/ahdf370ln2TbhamrYe/aGOseHdqiBbDGaVepC7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773311; c=relaxed/simple;
	bh=M+WrdidwYg3eg8sJ7UKN+5nMBlcjisurnsRrJPlKisc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NfoD/ULzMZLJGPwvUpozZjQt5yCYVfpIw6QB2O4SghyburJyN5wu3pu0D2R9Yulibm+RlwWqC3QgldNWaYreBCJxbn+ucpAj2Im4mK1DFuhAbRS47l03u9VaNFkt1t5A3q5q5gvOhBkiBLkyb/0MtIc9TnZudqddnYKR2UkoXyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ly+9ds/2; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEFOPm7d8NuvqXJgzPjQg4gvTmwlQh09209YYOG71lYRS8x7TCLm1TzAQUmQtcH86+Yliczocp7qhgddeJENbgrVPNG9LXJ8hbH/t6m/drmog5DAH3MXY/oh8UmB15hIpezbYCIRQOREt+c3hC/9+XPN9ECvVUMFbXFYgWo9Ya2yqf8pZedgN19z6L3K1f8k9r2ya6qWweENoOUrztnLW359IeBvTeWVQXNz7f0c5llEvgEPr6khdW4szfRevCSBwjRT9zwAaObNKABZUS6xlpzhhK4FmA9nM9Iln/W3nDwaDcV/DnzwELWcVNxZQnRgDnDCj3wT+OHJjr6BWX/lUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAAGtLP28LcsngzDgs9+7IqMAFiuVHMWoczvrDR+MZc=;
 b=F4tvtIcmUInfsGmE6WhKBDFdX3oe028ilbK6VOHlpc2tVgyAC3FRbFDpZ9FS8yARVvm4d9GsqVG3Zqj1tf/QUDiY4puPQiQ4RqP9m27MybRKEtr4u5iwiDDQG407ORbuGM6xNay2S53Z5JpPEH1KeehLkqw7aK0GXSzV6XMtEe7r82y8F3TCcNB734p7kYjwggrN/eNdCilpjkARR3i++MoqoyTMWMMfcZdD3PllFswbR3tA/ZrVy80+aWuXj6UOsQiLpp7oAnDYqvNEFXmdm4T9xKY+qmOVakeFBxQNXrWhTkHN7X5f5mM74s1rSbUQJHAckpnOt2op6KVif/e5tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAAGtLP28LcsngzDgs9+7IqMAFiuVHMWoczvrDR+MZc=;
 b=Ly+9ds/2AGOBlnQLAkyHBbQdX9CEFbKPvKrwMd4jbV5dBeaz0N1AycGfU1bXjim1eLh/8jE5SkOsxp6bVfsZJe1dxiRYzegGQUyak0a4mZOcGgWL/JdK5gRBpcpmHTJ0W34RmQgRf8YkJOVjNZFxw7RUKWYx2DiuWPdQIQ/AlvEB0cdm46yfb+JPPI4IEjlsDvcqb1Qu9Tl/9EPZrwHcFKIN48s003VlKDPCDfLE+LqzL1MfQ3xqoSEJZ3mdnFaWPTU6vqH3AaAa4EpbWKJakUCHE805MXoTsc1mGVY5wpEhSEESBIYvwmLASmurdH0fovp7m1eRLHZ31rQNABjMtA==
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:14:59 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::27) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Fri, 7 Jun 2024 15:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 15:14:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:40 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 08:14:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 2/5] net: ipv4: Add a sysctl to set multipath hash seed
Date: Fri, 7 Jun 2024 17:13:54 +0200
Message-ID: <20240607151357.421181-3-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
References: <20240607151357.421181-1-petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f04e75-1232-43d0-0fe0-08dc87049877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SvX5CbEcYYFqXKmV4mSPlXs0JUusg02dFHczTUABDkHnDJ9Mq4nAY4r4vbCZ?=
 =?us-ascii?Q?W87lvGDIDMc9+07ok8XS1BzFxIx9mNH8Ks1dnEQRFNzI7+eI9sAYifS7bkCS?=
 =?us-ascii?Q?RNsNUchGiuqpYCkNk0KOu7Q1CDo0kXuC5cUa0Ol3iu7z95c8S4w1zi93iYnr?=
 =?us-ascii?Q?CdQye7owryP6MPwz7yrs359KY4GZCBGjB11MzbDIQWTH79mlhnJTBbbv3j4k?=
 =?us-ascii?Q?y+iYCbAJ03+H67feaenWMk6nP6rgBinIhicUkJpk+9BJnymfeyhDxxVjFfe4?=
 =?us-ascii?Q?/cDB0doXPQ52PGPgSwNUksiEP++2cy/89cXZSlohoFlZvPUb261klDGTQeLR?=
 =?us-ascii?Q?excnroXIZCTNkqwftZy1X8+d5QFlgzkr8CI/wH4EDYpkiNDwHpdc3+BJ2Yat?=
 =?us-ascii?Q?5VqqfXNwbZbIhpk2RGkwigzRlwc/hWKsXHKanyi0NqdiHLiB1j/6a/OTNz8E?=
 =?us-ascii?Q?6ZDDxdTYRsIEVzKDADx+YHYKqQkCkLiyYU/ZmgjgkFc8T1dRj4C1jBfwF0rW?=
 =?us-ascii?Q?7jMSS8OdMlWk7t+qdkpP+Vt303VDyKNhbFzZ/Gb3Ce83BQvvNwTCBdWsXG6L?=
 =?us-ascii?Q?NRXgVPTqzbtMwTMyUluV+I6oWYM056Pg3Ir1SS69JGp7PZv8Z0sX0nUDxLhr?=
 =?us-ascii?Q?UPVQ3n79IJgMhjJjK7aMRT23VFloABmp0/ZZAXK6z6bv1feE2m34nMLUNrAf?=
 =?us-ascii?Q?P4S4w3Fi3sTn22wRY2g4oUZUFb9ypjA7sv9/ud8KxZMotAGpoSK+WXH3tRYo?=
 =?us-ascii?Q?KDTM093UaJl4QlaW/ux0KLMfgvmwm5l441ahAkjX1Skrk/yW21woFWiTdIpV?=
 =?us-ascii?Q?50OiHDS/fleAfM1kqwEGfII+/EMOaed54DGAIRK4c+tWOfHpMixnOIx45rP1?=
 =?us-ascii?Q?3yrrR9NdYBq8SAEOoWFMqJfojTSEwY2QNkZbiT/Vvs1cctIL5QTC9weluDoU?=
 =?us-ascii?Q?BDz+9VPiVdorG9tpQ97koUf5pdMEQkV0ieai/5exmox72CW6cVar7paN/qMm?=
 =?us-ascii?Q?G7o9jaHs/2T2x5eyVFeUMV2jHoyKNum/j3M/Lt8FMKYlon3/fqm7IGyCaxH6?=
 =?us-ascii?Q?viiPsrUuE5gBx9xy/YDpyFT5BXHgsOyMwntqiol4IwgOsrKI94gz8p1VwRUg?=
 =?us-ascii?Q?DN1M/wcAOp1R+2qiKAzoB9S/XmnmHiQtDA/SSLWCe684T67kBXRZlK+Bfdjv?=
 =?us-ascii?Q?6KpMdtBdGjmm4Qn1zP1l3FwV2QI3w76tO9ZRcFiJ0k2/2JJOWsuChUHCnkqB?=
 =?us-ascii?Q?hn5gTWpG6mKeF9Qz7YysVSkS9PUVVuL/2ibFkeM32RzRVf5STZ4RYcizBYtw?=
 =?us-ascii?Q?aSNqnrq+BxlCs9JAepZ56r0XXx+B/RBwqfDuDX7lHPOf7nR6OjwSPSxC1fE/?=
 =?us-ascii?Q?kTKXGYClv7jFrbnVzNlfvtsvJ5QlB55wKzlkhnPW3e+nH79x5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:14:58.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f04e75-1232-43d0-0fe0-08dc87049877
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474

When calculating hashes for the purpose of multipath forwarding, both IPv4
and IPv6 code currently fall back on flow_hash_from_keys(). That uses a
randomly-generated seed. That's a fine choice by default, but unfortunately
some deployments may need a tighter control over the seed used.

In this patch, make the seed configurable by adding a new sysctl key,
net.ipv4.fib_multipath_hash_seed to control the seed. This seed is used
specifically for multipath forwarding and not for the other concerns that
flow_hash_from_keys() is used for, such as queue selection. Expose the knob
as sysctl because other such settings, such as headers to hash, are also
handled that way. Like those, the multipath hash seed is a per-netns
variable.

Despite being placed in the net.ipv4 namespace, the multipath seed sysctl
is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
variables.

The seed used by flow_hash_from_keys() is a 128-bit quantity. However it
seems that usually the seed is a much more modest value. 32 bits seem
typical (Cisco, Cumulus), some systems go even lower. For that reason, and
to decouple the user interface from implementation details, go with a
32-bit quantity, which is then quadruplicated to form the siphash key.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>

Notes:
    v2:
    - Instead of precomputing the siphash key, construct it in place
      of use thus obviating the need to use RCU.
    - Instead of dispatching to the flow dissector for cases where
      user seed is 0, maintain a separate random seed. Initialize it
      early so that we can avoid a branch at the seed reader.
    - In documentation, s/only valid/only present/ (when
      CONFIG_IP_ROUTE_MULTIPATH). Also mention the algorithm is
      unspecified and unstable in principle.

 Documentation/networking/ip-sysctl.rst | 14 ++++++
 include/net/flow_dissector.h           |  2 +
 include/net/ip_fib.h                   | 23 ++++++++-
 include/net/netns/ipv4.h               |  8 ++++
 net/core/flow_dissector.c              |  7 +++
 net/ipv4/sysctl_net_ipv4.c             | 66 ++++++++++++++++++++++++++
 6 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 6e99eccdb837..3616389c8c2d 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -131,6 +131,20 @@ fib_multipath_hash_fields - UNSIGNED INTEGER
 
 	Default: 0x0007 (source IP, destination IP and IP protocol)
 
+fib_multipath_hash_seed - UNSIGNED INTEGER
+	The seed value used when calculating hash for multipath routes. Applies
+	to both IPv4 and IPv6 datapath. Only present for kernels built with
+	CONFIG_IP_ROUTE_MULTIPATH enabled.
+
+	When set to 0, the seed value used for multipath routing defaults to an
+	internal random-generated one.
+
+	The actual hashing algorithm is not specified -- there is no guarantee
+	that a next hop distribution effected by a given seed will keep stable
+	across kernel versions.
+
+	Default: 0 (random)
+
 fib_sync_mem - UNSIGNED INTEGER
 	Amount of dirty memory from fib entries that can be backlogged before
 	synchronize_rcu is forced.
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 99626475c3f4..3e47e123934d 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -442,6 +442,8 @@ static inline bool flow_keys_have_l4(const struct flow_keys *keys)
 }
 
 u32 flow_hash_from_keys(struct flow_keys *keys);
+u32 flow_hash_from_keys_seed(struct flow_keys *keys,
+			     const siphash_key_t *keyval);
 void skb_flow_get_icmp_tci(const struct sk_buff *skb,
 			   struct flow_dissector_key_icmp *key_icmp,
 			   const void *data, int thoff, int hlen);
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b8b3c07e8f7b..6e7984bfb986 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -520,13 +520,34 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig);
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 		       const struct sk_buff *skb, struct flow_keys *flkeys);
-#endif
 
+static void
+fib_multipath_hash_construct_key(siphash_key_t *key, u32 mp_seed)
+{
+	u64 mp_seed_64 = mp_seed;
+
+	key->key[0] = (mp_seed_64 << 32) | mp_seed_64;
+	key->key[1] = key->key[0];
+}
+
+static inline u32 fib_multipath_hash_from_keys(const struct net *net,
+					       struct flow_keys *keys)
+{
+	siphash_aligned_key_t hash_key;
+	u32 mp_seed;
+
+	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
+	fib_multipath_hash_construct_key(&hash_key, mp_seed);
+
+	return flow_hash_from_keys_seed(keys, &hash_key);
+}
+#else
 static inline u32 fib_multipath_hash_from_keys(const struct net *net,
 					       struct flow_keys *keys)
 {
 	return flow_hash_from_keys(keys);
 }
+#endif
 
 int fib_check_nh(struct net *net, struct fib_nh *nh, u32 table, u8 scope,
 		 struct netlink_ext_ack *extack);
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index a91bb971f901..5fcd61ada622 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -40,6 +40,13 @@ struct inet_timewait_death_row {
 
 struct tcp_fastopen_context;
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+struct sysctl_fib_multipath_hash_seed {
+	u32 user_seed;
+	u32 mp_seed;
+};
+#endif
+
 struct netns_ipv4 {
 	/* Cacheline organization can be found documented in
 	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
@@ -246,6 +253,7 @@ struct netns_ipv4 {
 #endif
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
+	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
 	u32 sysctl_fib_multipath_hash_fields;
 	u8 sysctl_fib_multipath_use_neigh;
 	u8 sysctl_fib_multipath_hash_policy;
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 59fe46077b3c..fcd584588baa 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1806,6 +1806,13 @@ u32 flow_hash_from_keys(struct flow_keys *keys)
 }
 EXPORT_SYMBOL(flow_hash_from_keys);
 
+u32 flow_hash_from_keys_seed(struct flow_keys *keys,
+			     const siphash_key_t *keyval)
+{
+	return __flow_hash_from_keys(keys, keyval);
+}
+EXPORT_SYMBOL(flow_hash_from_keys_seed);
+
 static inline u32 ___skb_get_hash(const struct sk_buff *skb,
 				  struct flow_keys *keys,
 				  const siphash_key_t *keyval)
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index bb64c0ef092d..9140d20eb2d4 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -464,6 +464,61 @@ static int proc_fib_multipath_hash_fields(struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static u32 proc_fib_multipath_hash_rand_seed __ro_after_init;
+
+static void proc_fib_multipath_hash_init_rand_seed(void)
+{
+	get_random_bytes(&proc_fib_multipath_hash_rand_seed,
+			 sizeof(proc_fib_multipath_hash_rand_seed));
+}
+
+static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
+{
+	struct sysctl_fib_multipath_hash_seed new = {
+		.user_seed = user_seed,
+		.mp_seed = (user_seed ? user_seed :
+			    proc_fib_multipath_hash_rand_seed),
+	};
+
+	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);
+}
+
+static int proc_fib_multipath_hash_seed(struct ctl_table *table, int write,
+					void *buffer, size_t *lenp,
+					loff_t *ppos)
+{
+	struct sysctl_fib_multipath_hash_seed *mphs;
+	struct net *net = table->data;
+	struct ctl_table tmp;
+	u32 user_seed;
+	int ret;
+
+	mphs = &net->ipv4.sysctl_fib_multipath_hash_seed;
+	user_seed = mphs->user_seed;
+
+	tmp = *table;
+	tmp.data = &user_seed;
+
+	ret = proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
+
+	if (write && ret == 0) {
+		proc_fib_multipath_hash_set_seed(net, user_seed);
+		call_netevent_notifiers(NETEVENT_IPV4_MPATH_HASH_UPDATE, net);
+	}
+
+	return ret;
+}
+#else
+
+static void proc_fib_multipath_hash_init_rand_seed(void)
+{
+}
+
+static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
+{
+}
+
 #endif
 
 static struct ctl_table ipv4_table[] = {
@@ -1072,6 +1127,13 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &fib_multipath_hash_fields_all_mask,
 	},
+	{
+		.procname	= "fib_multipath_hash_seed",
+		.data		= &init_net,
+		.maxlen		= sizeof(u32),
+		.mode		= 0644,
+		.proc_handler	= proc_fib_multipath_hash_seed,
+	},
 #endif
 	{
 		.procname	= "ip_unprivileged_port_start",
@@ -1550,6 +1612,8 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 	if (!net->ipv4.sysctl_local_reserved_ports)
 		goto err_ports;
 
+	proc_fib_multipath_hash_set_seed(net, 0);
+
 	return 0;
 
 err_ports:
@@ -1584,6 +1648,8 @@ static __init int sysctl_ipv4_init(void)
 	if (!hdr)
 		return -ENOMEM;
 
+	proc_fib_multipath_hash_init_rand_seed();
+
 	if (register_pernet_subsys(&ipv4_sysctl_ops)) {
 		unregister_net_sysctl_table(hdr);
 		return -ENOMEM;
-- 
2.45.0


