Return-Path: <netdev+bounces-178769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B33A78D61
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD8E3B2B41
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96D238173;
	Wed,  2 Apr 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dqQBnqa9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A0235BFB
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594205; cv=fail; b=PLfLcnd187SPw0trVzOBQJkN1geklG+ArrT8o8vc3KQD5nyqFKh5nBhALKWIUF4CxKw7NeZ/loiAJVM6nn0scU2kD/escv7bUwnfS6A0nPs847t4B1ZbnjbgfrDpQMnVjhQKkX3PRLzO9nHSNPVLTx1MoDuH+/qQt6bPlrJo0NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594205; c=relaxed/simple;
	bh=11Zb6OBRs+9eX2gaxIk4dA6fJ/BC2ChAvDJBY6E4j/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VH0Kh3G4hUuAoy4U6ZLKZrjgloEoRuXz9nvdTcLQ6VsOEVxqyQvmscg6s07nt+s4rFaYnN7bRl+oSeSB9ESLOKUw2yJPrTds5ZLX58NNjlZe33A1UwXEE0RhSGJkzEdWxJb4CKlxFbGJ7f55d9eF8jhypN9L5r4uFEWGmEpvfsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dqQBnqa9; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8VFi96x//MrCaNbNHV/LtFoMNkVJ0uNnNPF0kw+7Bm3tSwVLY3aKeh33lL1LC6Pg95OQ/Cn5EmO61MsAvW8Cuttmm6pi1JR8N3L5I/fbFDVrOzeH4FJ6VtJlIYRJYvbDCZXziKP4MAScxk3hs6a5uRexgJw6cCRuB+flLcRGXi8CEXwjfGHJHN64WLcWPuk2QL79jwnkc+JwVFCTDyN0tBkCCjngr9QGnHND+FJfl2E8XBXwd0LieM4zVl4PXKUznja5SKKETRlbCA5RnljqtNo5cl25PSjLqRuD+ZxYRSYXw3n6SG4+vPtx0xeRWZZi5mLMJE1P0PhlCtjqc4uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eHMHS5kiVScGaTbra2tXFrcKYuZqXaXz7hkBFI3cXM=;
 b=zDr/yM4sp4dBTjfyzTPL8Vx5dknlN25hLZKJXJGZ+wv+MWz2sEHRdWA439m+IlqhxYzin/fJ71i285Mo0ioJD1CO6+HC78wb9aDcVnqOd9QQCBzYN57fFyioLK9j/iHkChw0kD3UCm9oX+dZ9PMnDr6U+D9N7VWAokshpBQFDjmSBMOrCsJCjbYSZ77EPY4vrid4DyMSi3FAI943WedKYpJADWDnOZ5QZFXYjwYxMgyqa5kE1javdaayXAd8+yI4zTgiy+iH0zmYVLLaOVqcSEOX+7v+TyPrJTQAJyB6IjnXh+WEd2/4WuHOFz/m5aS0fjEKgRKZWDaeEALv8lF98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eHMHS5kiVScGaTbra2tXFrcKYuZqXaXz7hkBFI3cXM=;
 b=dqQBnqa92B4+yb9U9Rfzgk3ZpaQ70+AYH/AEWrt6sNeyKUx8bdstcWVDi7G+lcwGp7FuQ+2qaCMWNltWf1otybfOqw8GYJVO5ELzIBLs6o0cZHH2kY8bLPM4eurmixt3tUXHWimZZ6iS5yM2FWCaoo9zccKT6hEXijnJ+/CiPREuuKVv0Y0JxIQ4dWunayB0YNxoSfET5eO4rruoKjwEkKiARcB5IcftJtX3d/9OkpEu+srQKFff+x5nOGYeTqOLelr3iU3AQS2f/3dx55cgG1zb9KqSEpPzDX/13Fr/nQbKwg71hYyHX78o6p68AcamtPfAG1EhvIMBNcWoSr0J+A==
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by SA1PR12MB8143.namprd12.prod.outlook.com (2603:10b6:806:333::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 11:43:19 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::d0) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.41 via Frontend Transport; Wed,
 2 Apr 2025 11:43:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 11:43:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Apr 2025
 04:43:02 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Apr
 2025 04:42:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dsahern@kernel.org>, <horms@kernel.org>, <gnault@redhat.com>,
	<stfomichev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 1/2] ipv6: Start path selection from the first nexthop
Date: Wed, 2 Apr 2025 14:42:23 +0300
Message-ID: <20250402114224.293392-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402114224.293392-1-idosch@nvidia.com>
References: <20250402114224.293392-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SA1PR12MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e186c89-3452-4ef3-5151-08dd71db909c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N3DL8QayqEfjxMW0RjKzusSpUnuUTOIe/qkngUWQOnyKMtXCATByDlFrrF9u?=
 =?us-ascii?Q?ZVWInf9xdBDTbgiN49P77OKMNrNB4Ir3XAf/F+OWILLP40tN+rvprVjx3CG9?=
 =?us-ascii?Q?F+dbbVZfJzUpGbSo50Cvn/NvvtLWZdkdGLCmovETtRNjibgiOxkJ0Yf358bQ?=
 =?us-ascii?Q?Dibp9jLpV1twFs+hRmGQjjwAI0fXDfMmnLOkXZqdmGCeeOslP+elosaSLMWr?=
 =?us-ascii?Q?oap58a2wUf+6phJpRYBFtTjbYgLXPGMJGObo8fAmtEzRO1D4u4V8br95bDIl?=
 =?us-ascii?Q?eFeFybVOtdtjPcf7KKOA2tgWLf1E3Ooj3tf3+Rj3Gd/mkeLUVETNW/B1y2SQ?=
 =?us-ascii?Q?5vuMQtj887mSodlNp9mOegjCuvLki3mbwS5djQWOXlUt8Y9/FDhkbTHXDLx9?=
 =?us-ascii?Q?/13elxWuRsEc8ywmtN0Qt/5E52NXKWCenXPxNmUg5r+NWEUcdnt2mh2cWkFI?=
 =?us-ascii?Q?9d/w/VXiTmg6cYCbA5gU6FF1RAxhEePSf6bDDZDtb5Rrnv2wX7UbrzHVPd6U?=
 =?us-ascii?Q?x4sxO9x+crZUOT9WMcj4rRZ/9ZrTElP2ihQJ9Pqadwpta75QAmCrYQQr/vmT?=
 =?us-ascii?Q?Ntn07I7UAa1XBRaj+HAi40BLCT8BaSO2W3vaL1VUQ4hdKyyQ3KbG2HXKsWp9?=
 =?us-ascii?Q?fhtO9r7JbW7GgUnPvJ3x0CL7fiTjU5FtxZHGisxj9jReI1cgOqnZXzO3H01w?=
 =?us-ascii?Q?ODlQLp7SWRDBQM8Yy4SOzvqAOnSbCbUMekcYvFf4cHokF0p1VV5ZOPRMfbal?=
 =?us-ascii?Q?IkoJhsx3BdsV4F+281AP1NKUngoQIDUNkK3628cKGgyonDeOE9ulpdqMdK4k?=
 =?us-ascii?Q?RMqVBg3xnRYwDHkJgyZslpRrWfHXiOe95/pyuDhfGs/Fhrl1aaZYPgtp86rw?=
 =?us-ascii?Q?9ofRw6d7S016kTHCeI08rFTX6pXvXxF7NlAfUrOgVQdc0ZImDoxm5NY6skm6?=
 =?us-ascii?Q?MiSmWkF/AuFhUUIozTqFvntC8ZcvzaDaOrbxjvK/AK0r9/XIMRWpozR4nIXR?=
 =?us-ascii?Q?9iDS2Zr22oVnYVxA2VkSHgniuUnGHL0VnQZrtUlnu+x2nhmrBPTDKtuRswqw?=
 =?us-ascii?Q?Q4S2BhnCjPnbRxxIxyRar0fl7nFCfO+9hxO+jCfbnp1tns+/DAMVNcNNK1ik?=
 =?us-ascii?Q?9CWuXr6pcrEsotr4S6C4IuxtGtO2asGm0ZlbhriC4jvmVpUktYSs/cpaDxwO?=
 =?us-ascii?Q?/91fiXADKTmKeZJ3NqFNXjJNDX1IYeYO5JV6Av3O5u3gxeOARwmmDje/PZ8R?=
 =?us-ascii?Q?R0r4yTyB0VX0aIy+J/HjBEQS1wUzt9m0ITYRfWUjxd7qJ8UyBevj1vNCi6a3?=
 =?us-ascii?Q?LHmHXXHBoKlccVvp0kk3wPrTwQ7DwupEP9/l66lNWl3/KMoZ5abgPJvG183B?=
 =?us-ascii?Q?blKp3qwHynczz8BBXOohZdD+x0PxixkvsI2G5Xs5d6PrZasMBfXZFA0erAoC?=
 =?us-ascii?Q?vs+7XoE+dGNBqiPjOqmuEbiwAbojG4eXO/HorliIk66OqN1RzxmunlwRFqqv?=
 =?us-ascii?Q?bas3DHxP8rFD0SU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:43:19.2855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e186c89-3452-4ef3-5151-08dd71db909c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8143

Cited commit transitioned IPv6 path selection to use hash-threshold
instead of modulo-N. With hash-threshold, each nexthop is assigned a
region boundary in the multipath hash function's output space and a
nexthop is chosen if the calculated hash is smaller than the nexthop's
region boundary.

Hash-threshold does not work correctly if path selection does not start
with the first nexthop. For example, if fib6_select_path() is always
passed the last nexthop in the group, then it will always be chosen
because its region boundary covers the entire hash function's output
space.

Fix this by starting the selection process from the first nexthop and do
not consider nexthops for which rt6_score_route() provided a negative
score.

Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
Reported-by: Stanislav Fomichev <stfomichev@gmail.com>
Closes: https://lore.kernel.org/netdev/Z9RIyKZDNoka53EO@mini-arch/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c3406a0d45bd..864f0002034b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -412,11 +412,35 @@ static bool rt6_check_expired(const struct rt6_info *rt)
 	return false;
 }
 
+static struct fib6_info *
+rt6_multipath_first_sibling_rcu(const struct fib6_info *rt)
+{
+	struct fib6_info *iter;
+	struct fib6_node *fn;
+
+	fn = rcu_dereference(rt->fib6_node);
+	if (!fn)
+		goto out;
+	iter = rcu_dereference(fn->leaf);
+	if (!iter)
+		goto out;
+
+	while (iter) {
+		if (iter->fib6_metric == rt->fib6_metric &&
+		    rt6_qualify_for_ecmp(iter))
+			return iter;
+		iter = rcu_dereference(iter->fib6_next);
+	}
+
+out:
+	return NULL;
+}
+
 void fib6_select_path(const struct net *net, struct fib6_result *res,
 		      struct flowi6 *fl6, int oif, bool have_oif_match,
 		      const struct sk_buff *skb, int strict)
 {
-	struct fib6_info *match = res->f6i;
+	struct fib6_info *first, *match = res->f6i;
 	struct fib6_info *sibling;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
@@ -440,10 +464,18 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		return;
 	}
 
-	if (fl6->mp_hash <= atomic_read(&match->fib6_nh->fib_nh_upper_bound))
+	first = rt6_multipath_first_sibling_rcu(match);
+	if (!first)
 		goto out;
 
-	list_for_each_entry_rcu(sibling, &match->fib6_siblings,
+	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
+	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
+			    strict) >= 0) {
+		match = first;
+		goto out;
+	}
+
+	list_for_each_entry_rcu(sibling, &first->fib6_siblings,
 				fib6_siblings) {
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
-- 
2.49.0


