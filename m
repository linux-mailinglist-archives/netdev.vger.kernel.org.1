Return-Path: <netdev+bounces-167012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6CA384F1
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C13316C7EB
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1221D3F4;
	Mon, 17 Feb 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwL8GFjE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C821D3E5
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799731; cv=fail; b=jYmNDykV7Qb6BAH0BK4ndK0yfxPtTQ1x2WcVoHXcMHSc7hQxG36wb2Zcou5nOUOBbaDxhSGY5nCmnO+myOM529DU4NdlaVrJJ3UtUe9ZygaWat7ATFNhK1eGGmu5OSEKDoderqDf07m5HN5A6JAQE5x1YvqCyEhAQ8ofyuQEusI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799731; c=relaxed/simple;
	bh=OrO6Wm9znof9xJH9trhkj/szxO4gXL7u1/7dhS9BjQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXTc0Z6rhoOISWHSOK3Pq7gT3yYrG8nHu+m/N+ldQK+hdiUJU+k6CBsFWgZqEv5U44lZoMxRibpUjBqj6c+ENSakraD3Wz3j11asBBkOvgXaUuSdo7GlEN1ilHaCeJ5ng3i/EoGeLtBSuqmNcsDpMpzyoC7INNK3kW7vCbdMVxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwL8GFjE; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muEbbZC2H6+y8oQGfmrmbGwasP6/6N4gICaLKK/9Bw2/76YtuOrSXgRe+j4EHi2qVb6fJz6jR+HMkyW6GKtFh62gHqpO0WRe8aksTIcIj74KNzp9ygOuZYf6YVkRMMiMaGavn0LnAHG8g/L8UhJ+j5etZEjOigqctdNs0WlsxMAQSOLEntdAk4UAuJZSHs2ykCp6Kefn3TANh4+rTIRCYcAi9CSFJs04LJLM7jx9qmFkTtV3AzE3+ZOzSv91/mHngVBFFn1+38HVRvFaVODX3dZOrmAgQkr5vr8w/JhfYP49JtZRJN15ZnCZT8rBgrbUadwYylHunsWIKrVpsOPNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwSFyYRhE3Uowu63HMU6tFUD+4ax8QhA7nd1zYHZKmI=;
 b=oMA6BS3hDgmoWDMCa2NzdmyV4tWHAiV7138UW2+Ijmkouc6uX8GSoMU+uh2w/q7akMcMOueljh4YNnqZsUjQ+rWAvsdGwGiQrxLY9fJSr8xowbcjLD5t+xPwT5eCNgP2CXHwSs2BZjCxKQBG8yuVEyRyQ2NY06YxYbI/xyEfs0eRUk0Xm+L1hMhV8WSnBRttr169XqWjwF+r1ny5hNTvky5g5LNxTqPuUUmUCX/sJtxQFWMCUWjnN3kW8fDrv/C68h1zTY9vVL1jpUJ7M5irUZYoEYA4UvIO/aBEZArd3heVeBESaTRlyM8sDKVQVp1s8xtv6vDGdCijnEshE5ErlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwSFyYRhE3Uowu63HMU6tFUD+4ax8QhA7nd1zYHZKmI=;
 b=nwL8GFjEXE2rOTSVJ/YXbbhzpNzQs6xWOdIjtJ+76WM6a3SRYAuruhBFzoCvLgilzmb3iI6wceiKDUpKP5f1arJGNGYb7hlc1guQanWG4G38Syz0UkevKQrVMcMjWCGKkQV+oggis8sdOsXLVZcyw9xa4J3xdyE3BHDoCJuXwhdI2eAdO8C18ugtWPEdXpx+i7wOAJmObc6LKhNo/mSED3kSKW6mnopSf3zq7Ta06qmgrLe/gL2fQhY/62DDc5fwZyJ1P3f8fKI+kH8xytq7ofEhthuISsi4xz2nD1izeeJSGcQit2P8vHwpa9oSVIilFra43cBMbiCwX9CoVQy5FA==
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 13:42:05 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::73) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.18 via Frontend Transport; Mon,
 17 Feb 2025 13:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:41:54 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:41:51 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 2/8] net: fib_rules: Add port mask support
Date: Mon, 17 Feb 2025 15:41:03 +0200
Message-ID: <20250217134109.311176-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c610b94-298e-43d8-34c1-08dd4f58ddea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dLfT2ydlW9gOYXLEDPEWw4/C7d/thz74P5a3Ts1AnL3NoWKbpSTem+3zzgEr?=
 =?us-ascii?Q?YAUov//63BRcjnMvb5w8svvN1AmMWyrp520KEvcTBQ6dp8IuF2nPiSYOUdEV?=
 =?us-ascii?Q?HC2WzjnVivxqOQsy3UJpEuYN6ePhzGs4nctEbxv3Uz1p+R2x1f3HYiIqDx6k?=
 =?us-ascii?Q?TWBpxr4YX7bw47nVpK85vjoea+yhywTv41PU/2G9bmT6uSISc366JCdp7Bj+?=
 =?us-ascii?Q?dbmsk/H8HjVS+yGQNDtGhy8mzhECp6ek6d2O4dbM1q6wQI0MGKa1otIXNGv+?=
 =?us-ascii?Q?DTjZw4O8sCxkm49rzm0U1wHQWlIBiEnmNLHNfzjDn+jER6b3i9IZEwAYYtV4?=
 =?us-ascii?Q?94g2h/7y+V6Zei+8nNQKg39y/QxkfVmWq16B19BRojXBlplM+3PIqCwcbg8G?=
 =?us-ascii?Q?1tEk5j5aiTPJzzC3kqadcT/6jCqkeOv7//4ZrjHSRGOXTwbQeNQoDQmnzCI3?=
 =?us-ascii?Q?rKcQ4pmCeGdIb4x03E/Bgby7P22/3iP8IZhI3xUKPT2Lnp15V20E1c2kMQ7h?=
 =?us-ascii?Q?L0Z7Qv/nsyU4tfujFV3N7NszfX5tbeUFLe+hHc+cWKutM8VhFawRdl814D8K?=
 =?us-ascii?Q?w/W0A59w8euEk0DvdVuNnXUf2KZj7DK7oXDUS9cD5m6eZroPBBOuTKam9210?=
 =?us-ascii?Q?rzlC48d33YHg7rBHKosmXXzHJZKLZw1BxkUZAa5oD9vIL3B4Kzjlt2840SMv?=
 =?us-ascii?Q?PYxdGPiu5aMztwh3mbj97uAVAzXVdvMuRJh2dOhVHoHWgMTydDGtH3CwfyQQ?=
 =?us-ascii?Q?9Yq1pdz/Z5HTW1qQq3ou+i9YkhnLa6P2q8a/UldHKiDtGDwPiD+0PeQ1x96A?=
 =?us-ascii?Q?gae1pMzXE4LVBpOkFXHVB7XeTM/xDyyYVIdzgukYYvqGf0iCeyym3OHgOFJX?=
 =?us-ascii?Q?rxkx6UNHuTRVyhGhcGPx2Rxkx9sHS5VqaqZv4YpPc0METZNBTpZbf2LHPxFm?=
 =?us-ascii?Q?Xukuy7zLLO772S3bAlD0rPWa6NdF/rAQ4Rv+fNCV5YBEDYtnGp1xIQxgdYCA?=
 =?us-ascii?Q?SAW3gn+phHswnsFeLudXQKIGZG1uex+fU5zsQSwtER0SsDVm9QItBhpDJSih?=
 =?us-ascii?Q?advr/ddcj74fZ2pXV76oL0yiQtDyRssq0RNKDwphkrug7HMEdunPGWPzOZkb?=
 =?us-ascii?Q?aD8tuYg+mbYk29rM2iBeOI5yGQpvxhaz9jLEBgQoIKT7Kmoyg9oGW4dISBLK?=
 =?us-ascii?Q?40AbG+dMVZ9Pqz6vbDogqDoIt7+m6dvZ67tnat1kxswPkgWQ0GgM6eJaoL34?=
 =?us-ascii?Q?MA8sn/A2F1YnSc/JqDHWaFOX2PrxmmPa0pS26YAhOufFfvH9gPQTSF3XDb8l?=
 =?us-ascii?Q?hgpVSRulF/ULhjehrAlFR5HjVHsRzbFtl/bD5lC+e+UKGPMyA2XEiLbhGPiS?=
 =?us-ascii?Q?P4z1cj8BQgd4xU2jC0ukb6UbwFk1eeQkXvxR2SboZscUmh+9sq9m+EkhUHOl?=
 =?us-ascii?Q?+H7XDcgPAZ9sVOv67p0tOHthWNuTweJ1lldtfQtpE4jKFnYPLujRIQYZ3yf+?=
 =?us-ascii?Q?YoaRKFOdKKz/9Sg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:05.3745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c610b94-298e-43d8-34c1-08dd4f58ddea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261

Add support for configuring and deleting rules that match on source and
destination ports using a mask as well as support for dumping such rules
to user space.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/fib_rules.h |  8 +++++
 net/core/fib_rules.c    | 67 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 710caacad9da..cfeb2fd0f5db 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -43,6 +43,8 @@ struct fib_rule {
 	struct fib_kuid_range	uid_range;
 	struct fib_rule_port_range	sport_range;
 	struct fib_rule_port_range	dport_range;
+	u16			sport_mask;
+	u16			dport_mask;
 	struct rcu_head		rcu;
 };
 
@@ -159,6 +161,12 @@ static inline bool fib_rule_port_range_compare(struct fib_rule_port_range *a,
 		a->end == b->end;
 }
 
+static inline bool
+fib_rule_port_is_range(const struct fib_rule_port_range *range)
+{
+	return range->start != range->end;
+}
+
 static inline bool fib_rule_requires_fldissect(struct fib_rule *rule)
 {
 	return rule->iifindex != LOOPBACK_IFINDEX && (rule->ip_proto ||
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index f5b1900770ec..ba6beaa63f44 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -481,11 +481,17 @@ static struct fib_rule *rule_find(struct fib_rules_ops *ops,
 						 &rule->sport_range))
 			continue;
 
+		if (rule->sport_mask && r->sport_mask != rule->sport_mask)
+			continue;
+
 		if (fib_rule_port_range_set(&rule->dport_range) &&
 		    !fib_rule_port_range_compare(&r->dport_range,
 						 &rule->dport_range))
 			continue;
 
+		if (rule->dport_mask && r->dport_mask != rule->dport_mask)
+			continue;
+
 		if (!ops->compare(r, frh, tb))
 			continue;
 		return r;
@@ -515,6 +521,33 @@ static int fib_nl2rule_l3mdev(struct nlattr *nla, struct fib_rule *nlrule,
 }
 #endif
 
+static int fib_nl2rule_port_mask(const struct nlattr *mask_attr,
+				 const struct fib_rule_port_range *range,
+				 u16 *port_mask,
+				 struct netlink_ext_ack *extack)
+{
+	if (!fib_rule_port_range_valid(range)) {
+		NL_SET_ERR_MSG_ATTR(extack, mask_attr,
+				    "Cannot specify port mask without port value");
+		return -EINVAL;
+	}
+
+	if (fib_rule_port_is_range(range)) {
+		NL_SET_ERR_MSG_ATTR(extack, mask_attr,
+				    "Cannot specify port mask for port range");
+		return -EINVAL;
+	}
+
+	if (range->start & ~nla_get_u16(mask_attr)) {
+		NL_SET_ERR_MSG_ATTR(extack, mask_attr, "Invalid port mask");
+		return -EINVAL;
+	}
+
+	*port_mask = nla_get_u16(mask_attr);
+
+	return 0;
+}
+
 static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 		       struct netlink_ext_ack *extack,
 		       struct fib_rules_ops *ops,
@@ -644,6 +677,16 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 			NL_SET_ERR_MSG(extack, "Invalid sport range");
 			goto errout_free;
 		}
+		if (!fib_rule_port_is_range(&nlrule->sport_range))
+			nlrule->sport_mask = U16_MAX;
+	}
+
+	if (tb[FRA_SPORT_MASK]) {
+		err = fib_nl2rule_port_mask(tb[FRA_SPORT_MASK],
+					    &nlrule->sport_range,
+					    &nlrule->sport_mask, extack);
+		if (err)
+			goto errout_free;
 	}
 
 	if (tb[FRA_DPORT_RANGE]) {
@@ -653,6 +696,16 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 			NL_SET_ERR_MSG(extack, "Invalid dport range");
 			goto errout_free;
 		}
+		if (!fib_rule_port_is_range(&nlrule->dport_range))
+			nlrule->dport_mask = U16_MAX;
+	}
+
+	if (tb[FRA_DPORT_MASK]) {
+		err = fib_nl2rule_port_mask(tb[FRA_DPORT_MASK],
+					    &nlrule->dport_range,
+					    &nlrule->dport_mask, extack);
+		if (err)
+			goto errout_free;
 	}
 
 	*rule = nlrule;
@@ -751,10 +804,16 @@ static int rule_exists(struct fib_rules_ops *ops, struct fib_rule_hdr *frh,
 						 &rule->sport_range))
 			continue;
 
+		if (r->sport_mask != rule->sport_mask)
+			continue;
+
 		if (!fib_rule_port_range_compare(&r->dport_range,
 						 &rule->dport_range))
 			continue;
 
+		if (r->dport_mask != rule->dport_mask)
+			continue;
+
 		if (!ops->compare(r, frh, tb))
 			continue;
 		return 1;
@@ -1051,7 +1110,9 @@ static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
 			 + nla_total_size(1) /* FRA_PROTOCOL */
 			 + nla_total_size(1) /* FRA_IP_PROTO */
 			 + nla_total_size(sizeof(struct fib_rule_port_range)) /* FRA_SPORT_RANGE */
-			 + nla_total_size(sizeof(struct fib_rule_port_range)); /* FRA_DPORT_RANGE */
+			 + nla_total_size(sizeof(struct fib_rule_port_range)) /* FRA_DPORT_RANGE */
+			 + nla_total_size(2) /* FRA_SPORT_MASK */
+			 + nla_total_size(2); /* FRA_DPORT_MASK */
 
 	if (ops->nlmsg_payload)
 		payload += ops->nlmsg_payload(rule);
@@ -1119,8 +1180,12 @@ static int fib_nl_fill_rule(struct sk_buff *skb, struct fib_rule *rule,
 	     nla_put_uid_range(skb, &rule->uid_range)) ||
 	    (fib_rule_port_range_set(&rule->sport_range) &&
 	     nla_put_port_range(skb, FRA_SPORT_RANGE, &rule->sport_range)) ||
+	    (rule->sport_mask && nla_put_u16(skb, FRA_SPORT_MASK,
+					     rule->sport_mask)) ||
 	    (fib_rule_port_range_set(&rule->dport_range) &&
 	     nla_put_port_range(skb, FRA_DPORT_RANGE, &rule->dport_range)) ||
+	    (rule->dport_mask && nla_put_u16(skb, FRA_DPORT_MASK,
+					     rule->dport_mask)) ||
 	    (rule->ip_proto && nla_put_u8(skb, FRA_IP_PROTO, rule->ip_proto)))
 		goto nla_put_failure;
 
-- 
2.48.1


