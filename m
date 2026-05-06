Return-Path: <netdev+bounces-284764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDcLLgcK+2mbVQMAu9opvQ
	(envelope-from <netdev+bounces-284764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82F4D89FA
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 11:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83026303E4A8
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 09:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4563E0C51;
	Wed,  6 May 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTgOOHge"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012062.outbound.protection.outlook.com [40.107.200.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BC15E5DC
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059674; cv=fail; b=tbE6qz8gye7IB7YmYbqHmTuN7EwbMhya9EmHCvkKJWi6XiVIi4FstICkQLryk6RDpBozCdnmvb4Yw9U354mBF67rXCtlMMEl04e1/oSMlqcLJc21qUO5iunpiWLnw5SgV+1RJPQc3R9RUFCbKBJARcrrXIBKxQ3QVVRrKyU7CIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059674; c=relaxed/simple;
	bh=yzAeg5ME2UY4PC1+ZWW02ae2uH1PvHm3Mx74cnHjV6Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPBxAHIL5Cb/3JlgmzLYa94EhKKidUwod2qQdnICyd6Y6O4P8IUWlh814caCo02yHtukNzBHOpsBYGbRyc24DK51FKz1d8d8D3fOwpp8XxFIrYbna6APhANZr+t7UX/q0o3jTIfFoHet7wvhESr2Zd1bsZAwLxwsnaqlfVlDYbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XTgOOHge; arc=fail smtp.client-ip=40.107.200.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDBGwEIfPN2007zRM2aFAjljQiSWzLpPJ5z+WH0TqKd35C7fNJue1FV2pHQydyiNdsGu/WNDm9j8QeEVJk4orhrufOipqUH6k3Pb23/DhxAS0WxJhYsz/S0twaiBEBljxUCKIA7m72sSGVgTB/7w4fC0bdoOisO7aXtl4MCOzyBC0NmJibwMW23E0hjZrFpEYEbpMCpEBm7i/2TZTqawFXMSRMABiGJGXmz63E2mjVSGQgbH/pCR2Li2JKTSaF9rRWqjKBgz6PuLg9tid8a5+lU8pz1ujvQ1KgmSEX+LIyvUbHFkbxbdeVhlJbaQ0L9qEfxDxEEkVUL+scaymnlMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8w9YqywPmTaQi+jY/G5aDJ6rbUBXl/LAcqXIFFM2Nos=;
 b=s95RqvtfmXylzsPmpjb/ilpPm7mZeFfEsJviWoKI2EArdf1pZqbj9qjMc203omhL2+OkB1mbIzgKmECW5ip7JItVGXw7MVkUtvJBf3SzaSwVxWJW4rMhRCTjxjSFfHWEltLm6OXAj0/DZ0nM2vuPSYw0dw/AH2c7ltiv2zR/+c+I3FeiZPLLu8HsGCg/u4uUDAd1wclPiEfqOFp1z1RM+Dh/cNMJUCHLZDSSIwB+jclm6cQF4sK/u90+2ICMnNZOIoWND3SVT9GvchOAMBJ4SXwznY/e1vJtM/8kaxw0owc3lOCtbrvkuiOnlEYLUAE8dxNwwiDn1GnvCE6QD6Vvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8w9YqywPmTaQi+jY/G5aDJ6rbUBXl/LAcqXIFFM2Nos=;
 b=XTgOOHge2CpcEUrAqduRz5gg14d5pmiXwOWCoz5FVYptFtpSqO8iqSd6hgMrYUk7EgPP6euluzSnzndgDGSt95U+tc5uArtz4KGLzq3w3laY5Nc0cXLjidHANHENnjqT4sv6x5xxtpas9x8HWmu4q0a/iuea3FPpX/hyucXbBZK2ikGdHuKM6gVAsW8oZqwpiHZl7HwQ9GrUJsKyAwGPmBoRqqwcxQt//rUcA+kaguFv5gpS04gYyjHJ7K6nEQBGKs4MPxdHmiQreAAAvoFwN5LFKO+IRgHAs7oGTIDU9fcVXDV4/pE6/FFsWVRnS28MGk50LQQ73E0z/tN6s+27/w==
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:27:45 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::16) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 09:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 09:27:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 02:27:28 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 6 May 2026 02:27:25 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next v2] ipv4: Flush the FIB once per dev nexthop removal
Date: Wed, 6 May 2026 12:27:04 +0300
Message-ID: <20260506092704.150349-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d3d093-31a6-4e36-5ba9-08deab51baa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|18092099006|56012099003;
X-Microsoft-Antispam-Message-Info:
	U11wH2DyGHVHHr51GcH8WG+WUCtzQ90D9ZiWrdhkL0SKxjSkeBi1cd+OP8f2idm+Ks9CT1SxapXwyoAKGfllp4yihwOHDj4Iz5nnLHz3CmD3keAif35FiFMW8jktl8V1LHG2tdc3LP00Q5en9AGoD+1gSeZNOJ2Loafj0Bnhh6T9qzIVyYDI1atDADmKlWTi9W/0K15mHSxcQxL3W5MVnEVTmZi6k+6Nn9/f/biROi9evnSvvCXaLuTM0gJ2XZQG5Jb+OCbz5+mb/JQbdaWs+evrCxhG5V9v8GMFw4U738lU3F5WJ/Sjyf9jpFrQvGY+mG5plc7Ar/i4widGCML9J+CdMJbV/D2hfPXg0XxA0Dm5O1ffZ/lATrxiRxGeJmYow/b79kTgq8GkAujpgDAY1zfi0OGNoD01HzlgPQ1RiEyfoBpUETLNd/tuUv2vxeNDrrN0RJcIJNKiZ6vT9yVvM8vwfsxHU+BiQLcE2PqsHcJp/OHtK7eV7+czIR620lLmq72eB4LuSQfKLqi6ZHoYXPEeYjXkut5CEEssdWcZwsr+sfLTa0wpcNc7YT76sVglVvrWMXqcylPXedMMBpccCebJxIg3wJt8PbP9P4AriMxJbB1XIK/Q8f+nBmyYvSPyEwZW6VsA5lO/f6ogB+gX8uY4Y/P4y2oxYTjqGYNybOCueupv+FOB0tDCl1F7454bLfkiM3nI7ibhExRSCbBn3VJDfbp5c27+c9a3izK+iug=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(18092099006)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Erp2ftJf/CEuufOZ7HUiMbPQOpbvvvRBQilJbvg08MMHRJVwtbNw5+p/Jo2oEkwPbEsd0izVy7+O/RnvZESm8Ptuqu3hVmJwaZtW9FN6r3kPlIc2zkYo4GB1etRE+7HokXL/jDpwudVj1b9YHlOZ6aAyQwXc9A9Dfs4Oo0sPPAr+9pT5FkxmoAbU2cGkeZCD/Z3d2oYCfWOQCJifVxSI3oZg5uA+6Gqg8e/5RxYBCPqFaTlqoAVw9avfPwQumdW5x2VTr0VCanLaIky27JL4rW7ulJSVd+aIZachZz85q/rdlozbh25J7mn2SWoXfX8SN2VQe0cM0b/R9XLTxHoXlfehRMnrv9wDxAuhlAs652MzXoVIRUzrospqC/H9OLkNyM8NVD9h35oertCz0UCCx46pqs7Iz9l2Or8rhkRvQIsTJJ2W+6aUDTYFclBZIF+s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:27:44.5073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d3d093-31a6-4e36-5ba9-08deab51baa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
X-Rspamd-Queue-Id: 1A82F4D89FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284764-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]

When a device is going down, all nexthops on it are removed, and for
each nexthop being removed the FIB table is flushed, which does a full
trie traversal looking for entries marked RTNH_F_DEAD and removing them.
The performance of this is O(N x R), with N being number of dev nexthops
and R being number of IPv4 routes.

The RTNL is held the entire time.

When there are many nexthops to be removed and many routing entries,
this can result in the RTNL being held for multiple minutes, which
causes unhappiness in other processes trying to acquire the RTNL (e.g.
systemd-networkd for DHCP renewals).

In a complicated deployment with multiple vxlan devices, each having
16K nexthops and a total of 128K ipv4 routes, this is exactly what
happens:

nexthop_flush_dev()                # loops over 16K nexthops
  -> remove_nexthop()
    -> __remove_nexthop()
      -> __remove_nexthop_fib()    # marks fi->fib_flags |= RTNH_F_DEAD
        -> fib_flush()             # for EACH nexthop!
	  -> fib_table_flush()     # walks the ENTIRE FIB, 128K entries

Change that so that a nexthop_flush_dev() does a single fib_flush()
after all nexthops are removed. This is done with:
- __remove_nexthop_fib() no longer flushes the FIB, instead returns
  whether a flush is needed and is marked with __must_check.
- __remove_nexthop() and remove_nexthop() propagate this return value up
  with __must_check, which was also added to remove_nexthop_from_groups.
- A new wrapper is defined, remove_one_nexthop() which calls
  remove_nexthop() and flushes if necessary.
- The two direct callers of __remove_nexthop() get a WARN_ON, since the
  nh about to be removed should not have any FIB entries referencing it
  when replacing or inserting a new one.
- Callers which need to remove a single nexthop were migrated to
  remove_one_nexthop().
- Callers which need to remove multiple nexthops keep track in a local
  bool whether a flush is needed and call flush once at the end.
- This is plumbed through group removal as well, so when removing a leaf
  nh causes a parent group to lose its last member, the group's flush is
  also deferred, accumulated via remove_nexthop_from_groups() ->
  remove_nh_grp_entry() -> remove_nexthop(). remove_nh_grp_entry() gets
  a __must_check as well.

This dramatically improves performance from O(N x R) to O(N + R).

Releasing a nexthop reference in remove_nexthop() now no longer frees
it. Instead, it is deleted when the last fib_info pointing to it gets
freed via free_fib_info_rcu(). All routing code is already careful not
to take into consideration routes marked with RTNH_F_DEAD.

Tested with:
DEV=eth2
ip link set up dev $DEV
ip link add testnh0 link $DEV type macvlan mode bridge
ip addr add 198.51.100.1/24 dev testnh0
ip link set testnh0 up

seq 1 65536 | \
sed 's/.*/nexthop add id & via 198.51.100.2 dev testnh0/' | \
ip -batch -

i=1
for a in $(seq 0 255); do
  for b in $(seq 0 255); do
    echo "route add 10.${a}.${b}.0/32 nhid $i"
    i=$((i + 1))
  done
done | ip -batch -

time ip link set testnh0 down
ip link del testnh0

Without this patch:
real	0m32.601s
user	0m0.000s
sys	0m32.511s

With this patch:
real	0m0.209s
user	0m0.000s
sys	0m0.153s

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/ipv4/nexthop.c | 88 +++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 32 deletions(-)

V1 -> V2:
- Fixes xmas tree in a couple places (Kuniyuki Iwashima)
- Added __must_check to remove_nexthop_from_groups() (Kuniyuki Iwashima)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f92fcc39fc4c..6e25ed804099 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -20,8 +20,8 @@
 #define NH_RES_DEFAULT_IDLE_TIMER	(120 * HZ)
 #define NH_RES_DEFAULT_UNBALANCED_TIMER	0	/* No forced rebalancing. */
 
-static void remove_nexthop(struct net *net, struct nexthop *nh,
-			   struct nl_info *nlinfo);
+static bool __must_check remove_nexthop(struct net *net, struct nexthop *nh,
+					struct nl_info *nlinfo);
 
 #define NH_DEV_HASHBITS  8
 #define NH_DEV_HASHSIZE (1U << NH_DEV_HASHBITS)
@@ -2016,9 +2016,9 @@ static void nh_hthr_group_rebalance(struct nh_group *nhg)
 	}
 }
 
-static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
-				struct nl_info *nlinfo,
-				struct list_head *deferred_free)
+static bool __must_check
+remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
+		    struct nl_info *nlinfo, struct list_head *deferred_free)
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
@@ -2033,10 +2033,8 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 	newg = nhg->spare;
 
 	/* last entry, keep it visible and remove the parent */
-	if (nhg->num_nh == 1) {
-		remove_nexthop(net, nhp, nlinfo);
-		return;
-	}
+	if (nhg->num_nh == 1)
+		return remove_nexthop(net, nhp, nlinfo);
 
 	newg->has_v4 = false;
 	newg->is_multipath = nhg->is_multipath;
@@ -2093,22 +2091,27 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 
 	if (nlinfo)
 		nexthop_notify(RTM_NEWNEXTHOP, nhp, nlinfo);
+
+	return false;
 }
 
-static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
-				       struct nl_info *nlinfo)
+static bool __must_check
+remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
+			   struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
 	LIST_HEAD(deferred_free);
+	bool need_flush = false;
 
 	/* If there is nothing to do, let's avoid the costly call to
 	 * synchronize_net()
 	 */
 	if (list_empty(&nh->grp_list))
-		return;
+		return false;
 
 	list_for_each_entry_safe(nhge, tmp, &nh->grp_list, nh_list)
-		remove_nh_grp_entry(net, nhge, nlinfo, &deferred_free);
+		need_flush |= remove_nh_grp_entry(net, nhge, nlinfo,
+						   &deferred_free);
 
 	/* make sure all see the newly published array before releasing rtnl */
 	synchronize_net();
@@ -2118,6 +2121,8 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 		list_del(&nhge->nh_list);
 		free_percpu(nhge->stats);
 	}
+
+	return need_flush;
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
@@ -2142,18 +2147,15 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
 }
 
 /* not called for nexthop replace */
-static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
+static bool __must_check __remove_nexthop_fib(struct net *net,
+					      struct nexthop *nh)
 {
+	bool need_flush = !list_empty(&nh->fi_list);
 	struct fib6_info *f6i;
-	bool do_flush = false;
 	struct fib_info *fi;
 
-	list_for_each_entry(fi, &nh->fi_list, nh_list) {
+	list_for_each_entry(fi, &nh->fi_list, nh_list)
 		fi->fib_flags |= RTNH_F_DEAD;
-		do_flush = true;
-	}
-	if (do_flush)
-		fib_flush(net);
 
 	spin_lock_bh(&nh->lock);
 
@@ -2173,12 +2175,14 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 	}
 
 	spin_unlock_bh(&nh->lock);
+
+	return need_flush;
 }
 
-static void __remove_nexthop(struct net *net, struct nexthop *nh,
-			     struct nl_info *nlinfo)
+static bool __must_check __remove_nexthop(struct net *net, struct nexthop *nh,
+					  struct nl_info *nlinfo)
 {
-	__remove_nexthop_fib(net, nh);
+	bool need_flush = __remove_nexthop_fib(net, nh);
 
 	if (nh->is_group) {
 		remove_nexthop_group(nh, nlinfo);
@@ -2189,13 +2193,17 @@ static void __remove_nexthop(struct net *net, struct nexthop *nh,
 		if (nhi->fib_nhc.nhc_dev)
 			hlist_del(&nhi->dev_hash);
 
-		remove_nexthop_from_groups(net, nh, nlinfo);
+		need_flush |= remove_nexthop_from_groups(net, nh, nlinfo);
 	}
+
+	return need_flush;
 }
 
-static void remove_nexthop(struct net *net, struct nexthop *nh,
-			   struct nl_info *nlinfo)
+static bool __must_check remove_nexthop(struct net *net, struct nexthop *nh,
+					struct nl_info *nlinfo)
 {
+	bool need_flush;
+
 	call_nexthop_notifiers(net, NEXTHOP_EVENT_DEL, nh, NULL);
 
 	/* remove from the tree */
@@ -2204,10 +2212,19 @@ static void remove_nexthop(struct net *net, struct nexthop *nh,
 	if (nlinfo)
 		nexthop_notify(RTM_DELNEXTHOP, nh, nlinfo);
 
-	__remove_nexthop(net, nh, nlinfo);
+	need_flush = __remove_nexthop(net, nh, nlinfo);
 	nh_base_seq_inc(net);
 
 	nexthop_put(nh);
+
+	return need_flush;
+}
+
+static void remove_one_nexthop(struct net *net, struct nexthop *nh,
+			       struct nl_info *nlinfo)
+{
+	if (remove_nexthop(net, nh, nlinfo))
+		fib_flush(net);
 }
 
 /* if any FIB entries reference this nexthop, any dst entries
@@ -2592,7 +2609,7 @@ static int replace_nexthop(struct net *net, struct nexthop *old,
 	if (!err) {
 		nh_rt_cache_flush(net, old, new);
 
-		__remove_nexthop(net, new, NULL);
+		WARN_ON(__remove_nexthop(net, new, NULL));
 		nexthop_put(new);
 	}
 
@@ -2699,6 +2716,7 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
 	unsigned int hash = nh_dev_hashfn(dev->ifindex);
 	struct net *net = dev_net(dev);
 	struct hlist_head *head = &net->nexthop.devhash[hash];
+	bool need_flush = false;
 	struct hlist_node *n;
 	struct nh_info *nhi;
 
@@ -2710,22 +2728,28 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
 		    (event == NETDEV_DOWN || event == NETDEV_CHANGE))
 			continue;
 
-		remove_nexthop(net, nhi->nh_parent, NULL);
+		need_flush |= remove_nexthop(net, nhi->nh_parent, NULL);
 	}
+
+	if (need_flush)
+		fib_flush(net);
 }
 
 /* rtnl; called when net namespace is deleted */
 static void flush_all_nexthops(struct net *net)
 {
 	struct rb_root *root = &net->nexthop.rb_root;
+	bool need_flush = false;
 	struct rb_node *node;
 	struct nexthop *nh;
 
 	while ((node = rb_first(root))) {
 		nh = rb_entry(node, struct nexthop, rb_node);
-		remove_nexthop(net, nh, NULL);
+		need_flush |= remove_nexthop(net, nh, NULL);
 		cond_resched();
 	}
+	if (need_flush)
+		fib_flush(net);
 }
 
 static struct nexthop *nexthop_create_group(struct net *net,
@@ -2994,7 +3018,7 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
 
 	err = insert_nexthop(net, nh, cfg, extack);
 	if (err) {
-		__remove_nexthop(net, nh, NULL);
+		WARN_ON(__remove_nexthop(net, nh, NULL));
 		nexthop_put(nh);
 		nh = ERR_PTR(err);
 	}
@@ -3363,7 +3387,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	nh = nexthop_find_by_id(net, id);
 	if (nh)
-		remove_nexthop(net, nh, &nlinfo);
+		remove_one_nexthop(net, nh, &nlinfo);
 	else
 		err = -ENOENT;
 
-- 
2.53.0


