Return-Path: <netdev+bounces-98995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3D8D3564
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37977B26144
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9E13DDB2;
	Wed, 29 May 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BS8tmEue"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD217DE37;
	Wed, 29 May 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981702; cv=fail; b=OJrtKL51YHO+AKE/mcBr7owZNhn2W463Dk9rQw8cwuiIC3RCVcF6w9ZKXNSgRcC9lBgJTYcOOqTE/45xTBWBonMFZlmaK4sWT89sDxYafu+H3l//oguUbhWwCdxdr43Re1tXJzIdmWUtxs8DpWaSvv8ISuKy3uYAqwMpnl3szt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981702; c=relaxed/simple;
	bh=78YUr4DIOX54TS2ZjtIey18gr7CUo7JmbYE5LSJecNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEO+qyn4KT51lZk3ANWjdLisdAXgjrN9CN+t69nR14ZzAIiZ9Zh2LDlthjQOOEWd60XhYyWkfzMN0/e38Ok8VtcOVG4jjDFdXtoEW6OvHScxWAB6BAp7Kzr/QTJOJgLuJ4qe9SHlBFU/NjAlBrVZkCBscwhO52W811ENn40eCXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BS8tmEue; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcyJVOTb8vwTYdKuAUd4xmaGqWi6fi6Rn8BP2XfeqpaAimcXnxa1vek7gQ2eQ0L1nqvxgc45QyiCt92ax23CWNJ4pJARpw7VTEaaZlxqxuTNgR/Li95in9yRnS41NztPJi2vUCUczG2VqK9oR3/y6H9z9cg8uuEE/XEu6SPkUtOeEZ9Ai53bLgiFL1YjD7Pj9c/Q1nuCiAbScq9VZA7YPlstG9VfuxohUIhMWQIwlDxa6CHmxqxe7x3LI4FhMY4x4CJKm/637gWW/Iu5JqGG7RfqyMDDQqukOkNsqFe0Yty9pvH7X1cAz8iP4s3pkKWMep/Ku0R44i0dxdQv5wa4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hMuwaWGAHwyQ6AlcTr/S9YGiJd413bWQE+xDcdwuRU=;
 b=b5sO5sLRt5P69WmSL0rHmGqBza958/CCgQYin+uqcl5QS5CHM3O/s4ynC4rrFMLMjzdsGmU1QmdWwwIpJNkOVZcZwZYhggolReshTs/8rwxI1ysfWJjHcGSWjS4epmpy1yRBDNKP1z3o3AI3gcyXHZc5yT1B6jCQWYQIyzmMBPMzo3RW3wRz0anucA8Z2FKBHaoULT8VQwq8NpM1EWh++/S22QFdb7AC2buUg+wCFUHp8UuqNH/k/QmACHIylL/ph30B0huh05msIcX2bZCdjzzvaLTX4EZXMWS61AqsbrG03cXv02kPhFUPQy7VJaOh7873v8fO3Ego7TDAxomRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hMuwaWGAHwyQ6AlcTr/S9YGiJd413bWQE+xDcdwuRU=;
 b=BS8tmEueI+7Ml1+piUKYbxHoNbVZSg7FMf0dmnfqOp8b3d6bJ3XJ/3VOAwK426BOpthb6Q6mXqSM2FxN3VlrVNJIq8gFAICjNVth/H0Ju2VgP+Tf2e+jJaPhdUXMQxXvr71PS/bkctqdZeLWyUc4MIEU0OFyyTxmBS6obJ5p8D+qzwE7K8RQ6O6MZ6mjzK5opg5rFgyfT5sjst61dkyoYEzJ6VDtMMyNlFSTke7jWyayd+oGzH5D7W91d/KHAtPQOaKETbxi0EF0G6PlsarMHL5cWocYodMyNOpjvxiPFivx5gdjD5Ltgf46roVrWFDa5CXkCGQMACaH71RT/DT1+A==
Received: from BY3PR05CA0053.namprd05.prod.outlook.com (2603:10b6:a03:39b::28)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 11:21:37 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::ec) by BY3PR05CA0053.outlook.office365.com
 (2603:10b6:a03:39b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.20 via Frontend
 Transport; Wed, 29 May 2024 11:21:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 11:21:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:22 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 04:21:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath hash seed
Date: Wed, 29 May 2024 13:18:42 +0200
Message-ID: <20240529111844.13330-3-petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240529111844.13330-1-petrm@nvidia.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c07ed15-de43-4e72-3817-08dc7fd18091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiqUkWlV5b3ADbGzcQw+hA2ge4jkISMZTaWAw5WKsWqbQAL+8xJvVA6kxxYv?=
 =?us-ascii?Q?vbZuZE4SwkK9C/f1yPMqPKUmRAOdbiL5+Zw9J7dkMWiC4w2PuM19QlhlI1ZV?=
 =?us-ascii?Q?G9oesX591Of8yy0/y7St/QJT+E605WSZODqWuQyfW1aIBMnWRClTQIxUpjtb?=
 =?us-ascii?Q?Af2+FGegslcSgTyRUUYrA+0YKV4O/KhYtKQWjGxrHjdPi0wlTnGhbrXMeXy3?=
 =?us-ascii?Q?vpVMbqCK5k4Y90Gc5DvI2m7iOl6LCNxUxEOWo0+tgFumSS0Sq+jgE/OiOyKh?=
 =?us-ascii?Q?RC/jNJ0B7yIGnPxMzSbSfQ8CSRRsmQRb491cQjs+sRdEU6hl4GC9+//qiUTM?=
 =?us-ascii?Q?wJUmWzViIv3mwj6cGEmM7ziJzc2qQf9zYW9XdbkZZ0z40KZR0lzSojhdjZ0T?=
 =?us-ascii?Q?jO5JHhjmaZ7YUoVaKU8v9xdAkQrHzh7IIKJbpYNyH5XQ/h8KuWOK/Sp41cZv?=
 =?us-ascii?Q?8OszYUcbI3DSTio9t6SV1Hj+SX49LuonWILpeSsuoXRaOjwqLteVHmXPg3Dr?=
 =?us-ascii?Q?NGHKU20KcQ6S5SncP3eV+kuCEfwS9KfPb/Rf8/j7cXHs1CR4F53Rf5lEfXJx?=
 =?us-ascii?Q?RdSeSM2LbzBxpIwFLgaL0sA49DW2rpAKjhUlNLIp9rxCF0GON+i4/nAB9/88?=
 =?us-ascii?Q?O32srCdm+QVwMjBSFjXspbRGGK6jHf4RsEjuDMivxYW2X5crAQe+HEtC0PSv?=
 =?us-ascii?Q?TXrOF3AdoP1oZSuNv63dHtSqf8AWXsmTbXvN+edj9oEMLbV9oP2c8QYrHQIt?=
 =?us-ascii?Q?yuf/VD6oYuM2+kcw4LGUzmRr65Ld38H6ZWTPPeEPRWCLL4R9a9Np1tAkHzd2?=
 =?us-ascii?Q?7nBtRyAF3oQrjupGg0s5NPn24QoCg6WtQqaI2aatmLrhImGBfea4RYW99SQF?=
 =?us-ascii?Q?mP/wkyd3+0wFDNJspqXh01crkhWPYGxqE3uWt+FrqnBrAM+8An1pWTZIjhuE?=
 =?us-ascii?Q?42t1Lf6fFOyVNO6dz1c4ouj/Tmalr787VVef7ebH1QtXM0zJk2zDVldfAiLi?=
 =?us-ascii?Q?KgLKAnbKJtMJMEPZTREAxwfdKgmQE4vGZnBsxTCM50Zk/p53AzQzQlc7wAU/?=
 =?us-ascii?Q?8zW3yqMdtfmLK5BVly/C2S717DaKEoegJyVVjpqeUhMw54Co+y0RuZ9iYDHA?=
 =?us-ascii?Q?yQh1xchiF0UtgP5oS8P3c3Iw1SM1eWFrkz28E/7QT4hn6bD9cKeE7LmOWTOT?=
 =?us-ascii?Q?eRky1W3ErK+67WW7qihYGFclOFgaRrzDg7vdrGHoqV3X310flhk30pROuzuH?=
 =?us-ascii?Q?bxiF8Hzqfh2sNpovpC3YVKifaBLn/knyQzsNdOMAUobo6Xzg7KuOQkduZeC3?=
 =?us-ascii?Q?KqwrzxwfELEAVmpYSCX4NY9c4YKLkgJjhK3RI4pjCH1cCr2OkgZCLpo8AkAa?=
 =?us-ascii?Q?ucp7zA8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 11:21:36.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c07ed15-de43-4e72-3817-08dc7fd18091
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489

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

For locking, use RTNL instead of a custom lock. This based on feedback
given to a patch from Pavel Balaev, which also aimed to introduce multipath
hash seed control [0].

[0] https://lore.kernel.org/netdev/20210413.161521.2301224176572441397.davem@davemloft.net/

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>

 Documentation/networking/ip-sysctl.rst | 10 ++++
 include/net/flow_dissector.h           |  2 +
 include/net/ip_fib.h                   | 19 +++++-
 include/net/netns/ipv4.h               | 10 ++++
 net/core/flow_dissector.c              |  7 +++
 net/ipv4/sysctl_net_ipv4.c             | 82 ++++++++++++++++++++++++++
 6 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bd50df6a5a42..afcf3f323965 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -131,6 +131,16 @@ fib_multipath_hash_fields - UNSIGNED INTEGER
 
 	Default: 0x0007 (source IP, destination IP and IP protocol)
 
+fib_multipath_hash_seed - UNSIGNED INTEGER
+	The seed value used when calculating hash for multipath routes. Applies
+	to both IPv4 and IPv6 datapath. Only valid for kernels built with
+	CONFIG_IP_ROUTE_MULTIPATH enabled.
+
+	When set to 0, the seed value used for multipath routing defaults to an
+	internal random-generated one.
+
+	Default: 0 (random)
+
 fib_sync_mem - UNSIGNED INTEGER
 	Amount of dirty memory from fib entries that can be backlogged before
 	synchronize_rcu is forced.
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 9ab376d1a677..a5423219dee1 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -433,6 +433,8 @@ static inline bool flow_keys_have_l4(const struct flow_keys *keys)
 }
 
 u32 flow_hash_from_keys(struct flow_keys *keys);
+u32 flow_hash_from_keys_seed(struct flow_keys *keys,
+			     const siphash_key_t *keyval);
 void skb_flow_get_icmp_tci(const struct sk_buff *skb,
 			   struct flow_dissector_key_icmp *key_icmp,
 			   const void *data, int thoff, int hlen);
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b8b3c07e8f7b..785c571e2cef 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -520,13 +520,30 @@ void fib_nhc_update_mtu(struct fib_nh_common *nhc, u32 new, u32 orig);
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 int fib_multipath_hash(const struct net *net, const struct flowi4 *fl4,
 		       const struct sk_buff *skb, struct flow_keys *flkeys);
-#endif
 
+static inline u32 fib_multipath_hash_from_keys(const struct net *net,
+					       struct flow_keys *keys)
+{
+	struct sysctl_fib_multipath_hash_seed *mphs;
+	u32 ret;
+
+	rcu_read_lock();
+	mphs = rcu_dereference(net->ipv4.sysctl_fib_multipath_hash_seed);
+	if (likely(!mphs))
+		ret = flow_hash_from_keys(keys);
+	else
+		ret = flow_hash_from_keys_seed(keys, &mphs->seed);
+	rcu_read_unlock();
+
+	return ret;
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
index c356c458b340..1f5043d32cb0 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -40,6 +40,14 @@ struct inet_timewait_death_row {
 
 struct tcp_fastopen_context;
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+struct sysctl_fib_multipath_hash_seed {
+	siphash_aligned_key_t	seed;
+	u32			user_seed;
+	struct rcu_head		rcu;
+};
+#endif
+
 struct netns_ipv4 {
 	/* Cacheline organization can be found documented in
 	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
@@ -245,6 +253,8 @@ struct netns_ipv4 {
 #endif
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
+	struct sysctl_fib_multipath_hash_seed
+					__rcu *sysctl_fib_multipath_hash_seed;
 	u32 sysctl_fib_multipath_hash_fields;
 	u8 sysctl_fib_multipath_use_neigh;
 	u8 sysctl_fib_multipath_hash_policy;
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index f82e9a7d3b37..7b3283ad5b39 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1792,6 +1792,13 @@ u32 flow_hash_from_keys(struct flow_keys *keys)
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
index d7892f34a15b..18fae2bf881c 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -464,6 +464,72 @@ static int proc_fib_multipath_hash_fields(struct ctl_table *table, int write,
 
 	return ret;
 }
+
+static void
+proc_fib_multipath_hash_construct_seed(u32 user_seed, siphash_key_t *key)
+{
+	u64 user_seed_64 = user_seed;
+
+	key->key[0] = (user_seed_64 << 32) | user_seed_64;
+	key->key[1] = key->key[0];
+}
+
+static int proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
+{
+	struct sysctl_fib_multipath_hash_seed *mphs = NULL;
+	struct sysctl_fib_multipath_hash_seed *old;
+
+	if (user_seed) {
+		mphs = kzalloc(sizeof(*mphs), GFP_KERNEL);
+		if (!mphs)
+			return -ENOMEM;
+
+		mphs->user_seed = user_seed;
+		proc_fib_multipath_hash_construct_seed(user_seed, &mphs->seed);
+	}
+
+	rtnl_lock();
+	old = rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipath_hash_seed,
+				       mphs);
+	rtnl_unlock();
+
+	if (old)
+		kfree_rcu(old, rcu);
+
+	return 0;
+}
+
+static int proc_fib_multipath_hash_seed(struct ctl_table *table, int write,
+					void *buffer, size_t *lenp,
+					loff_t *ppos)
+{
+	struct sysctl_fib_multipath_hash_seed *mphs;
+	struct net *net = table->data;
+	struct ctl_table tmp;
+	u32 user_seed = 0;
+	int ret;
+
+	rcu_read_lock();
+	mphs = rcu_dereference(net->ipv4.sysctl_fib_multipath_hash_seed);
+	if (mphs)
+		user_seed = mphs->user_seed;
+	rcu_read_unlock();
+
+	tmp = *table;
+	tmp.data = &user_seed;
+
+	ret = proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
+
+	if (write && ret == 0) {
+		ret = proc_fib_multipath_hash_set_seed(net, user_seed);
+		if (ret)
+			return ret;
+
+		call_netevent_notifiers(NETEVENT_IPV4_MPATH_HASH_UPDATE, net);
+	}
+
+	return ret;
+}
 #endif
 
 static struct ctl_table ipv4_table[] = {
@@ -1072,6 +1138,13 @@ static struct ctl_table ipv4_net_table[] = {
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
@@ -1557,6 +1630,15 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
 	const struct ctl_table *table;
 
+#ifdef CONFIG_IP_ROUTE_MULTIPATH
+	{
+		struct sysctl_fib_multipath_hash_seed *mphs;
+
+		mphs = rcu_dereference_raw(net->ipv4.sysctl_fib_multipath_hash_seed);
+		kfree(mphs);
+	}
+#endif
+
 	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
-- 
2.45.0


