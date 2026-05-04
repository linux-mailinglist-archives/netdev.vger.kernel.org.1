Return-Path: <netdev+bounces-283853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHCmD1mh+GlExQIAu9opvQ
	(envelope-from <netdev+bounces-283853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:38:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FF4BDFB6
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9AB303100B
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763183CEB8E;
	Mon,  4 May 2026 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tsRXTArP"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F06399369
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901839; cv=fail; b=bqyVCWhNT5dAVKI/+mXnZP3xYWPjnj/bILFaiqXOH9Ins8aoB8zwRS6eaBWoH06aH9MDECMnh2lZunBe9H9Z+bnB4U+pj152E1jneskMy8QHylojgGb4+KkPtWnx/klljy9kZKxDAHPpU/eLkMj1OJu5fFY5yoZ0H6ypXmBzBw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901839; c=relaxed/simple;
	bh=h6A5YRLdWqYiZHpfk4kxkhL93OrgXrPB7jqszrFyrGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IyPohpyVnJW3/miTt702kx1JgeaQA20mDcXBMih1hjWsC2UmLaC6aZeSkCci4L1v0j7BkpLVBc7qVMCDUmVLCSt0BrOirabLPqbL61FR83lkTfKgNHt0g+DmGjRRbuCU8GUIlFjhc3zFEz9AsARLz3NCmz2xy/kLvpzc1zdl2UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tsRXTArP; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhvvxSogv5VHEWG401BqbskLUPf+PIKzLnQoWsF0CxcklE78Rl1KVdyJTFjNdpZZfyDg48HYuiEHda1/z+hrvjvkVJxn63BMybJagmNSWNwRjaIzf8f5wfbDigMARx/I4JAuTL32f1cHccfP2Ur3oTsaayrGtdHNSdETgqQBOT43ooyxHw7KWaRQxhYmokw2++0jXqnIi+gFwb6zRF5knTlqx1xnQIduDmqXgl8OnoLN9THTNn60Y9atGK3kthRNjBucRrAkkkiVifjIuQXKxzaI1/YlXM4iAgd4tSNuvJlHSQnIxgJqOwiaXm9Q6tT97R4vVLzrf/8Jwipa3hvHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+gJQQltlx4erfX6KcuB7bECPcSysTFKkI1ly0nH0qo=;
 b=ag47GUqL+aLxOAZ4aSVNhUU5Uwvv8B0rIs9ycPyxNX4RJKFlHz4arg7ykNEjtTzjGdwM4jt7Ll7D8afp8hP8/2Ss5IgwCurQYUXUezbpjuYR4MGniFQUB6dXDoRofUUhrQ9ep8bIIA3esErCtDAdulp+G6w8vZySzBNb0rx18Gi9/Hi7XB0a1spUI/tQ41CH6+7L/bgO94BoWMg2b09KdwIqj0NTVArog7ayVl6EGg0YEY30Z4HWgMCYFxkOGqVpzk8sfuanuWUxzqr6vj/Sn63I9CvKeRu/YB0POpENhk7pmjr2sIWzZnfQNdA51PS5qz/VPpreTF3WB8Ngqqw2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+gJQQltlx4erfX6KcuB7bECPcSysTFKkI1ly0nH0qo=;
 b=tsRXTArPl65zcHuAgDE2xa9kFsCOrwqwNhuqTQcIXbzy9whseWhuVLMC3yQ/zlhUaw0n5aIDivQWH9GhklI9vRTwkxon3z0ZXTkGMahcflleVVPcstwObxF9pr2XvOM6566XiU0oUuApREqzrj8/ItVuEeovhonFx7eQR1RkYRji7GjoQBtVBcW/FDHe2fddtJ79/yi0f2xzx6YnIB+Ck2Fq9//PlkRHjl0z0ijpFOGGIpLU+FA9a6h0uLnrjR0z2DLsG0gz5xnnELzqVr6Uw4GLb3czxQg8UZ+2rkuDw3YZAftfNUNgAknexRUIwKkzJRlWfFaV6fMoePZ3XdGftw==
Received: from SJ0PR13CA0083.namprd13.prod.outlook.com (2603:10b6:a03:2c4::28)
 by DS0PR12MB8455.namprd12.prod.outlook.com (2603:10b6:8:158::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:37:09 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8) by SJ0PR13CA0083.outlook.office365.com
 (2603:10b6:a03:2c4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.14 via Frontend Transport; Mon,
 4 May 2026 13:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 13:37:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 4 May
 2026 06:36:51 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 4 May 2026 06:36:48 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net-next] ipv4: Flush the FIB once per dev nexthop removal
Date: Mon, 4 May 2026 16:36:26 +0300
Message-ID: <20260504133626.4155933-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS0PR12MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 77da7615-e4b7-4045-b88c-08dea9e23d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18092099006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jz6iyxVpgz1A8AcQz5faCOkxKnkpowkBtcB+ELxSxlPTKGCMDKY9tIJangDAEi6cY8nrwTyqyrUaEdaItRdn0COdQbWTfX+lfMOKGK0s5XGZb9DKoqhVoQ4pDWjVwwyyEr89irY3LK8/E2BzS88nN2b0YoCd4oVp0qF6bR3vAoDs4mhmgRSwNsEqo4zD48gEp3uWSz5tLpa5GXE5QytiV3Fam/cb01wj+jxbQpmymRcezin/v4NHUDuGTkHHWYiPJuqVwkV8PxC6TvQcvhA0rOvXbPI+iryohBF7gEy/Vmn1kcn8BsnVPId9xaJliq67h+IG/neoN4MetqULI9f6EsnXr1DQuZgadiwzcIpZxHPGs1ISxywIXp1dhAVRUCAKDt+6u8Moh4mxABP2K8qFJwmTI9wsKwRklcmbSIJWMAwj6h3Xg3dC1IV7pR1a7zW063D7D9zVU40EV4onujAbuoUwEjgON95EsaI8oTkLxSe6BC6n2zjF0I7a1tUlRMgGi1cnkHVgpvgMnE7cSL2YY1dzUDgI/z+PWG3f/RlKjz+hWv+yq/HRM8tjN8jPUtRkqDHmXZD/vXhcrTReGk66m/XRY5LBBlkJpAxSw4gKsKt1rJeHjHTpBVxL0PD6ooXQnKhoAWyq/yw+DYmIOjwI2xowZAniwAEH/fUG9c+p/0p9SUjsTDx4zViSCBbvZ1VBwduMZerT8BJ5DSHl9sCWoW6Xi4IwhbozjTWxqcon39Q=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18092099006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5IuO6MDxdJcw+y3OguQ3Kd38EDt/f54hSCTvHGJGGMWBvwcOXB7GrX85ljSPtgq//Oqj+vk/dCQQApyISNv6IazJiermkxt+2VGnPBCgO6Cu8sI06rD0S1wDfRsIFhjkk/UL3CjYTv4rVlGQd9hDngt/AyrxdQedl4BIy80dJJMtt+VdBX5c66cKfZPtTsfGTOLoPLlmclSxwPVcm1JOcHKhyxE3DBlaRikyvHCi1TlYqbivRILCgXMAfRLXfjwwHr/fkS0irxEN78GmOxI6TDpYhZfqQT8ssWG0RIE57DlUrlGcKu3Kw/ZQa34tigaJeQDVjwekOQ6/MWWjka5+UP+asd4Eo+81leXmmJ7EHLT/ljP/I9r3Yod7RPonSBKhvmIc+hhSGibmGu2pWMveuVKegiaXFR9Z7S3LtpSZCKjgJXYUpcTnKjiMytfwmmiy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:37:08.5816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77da7615-e4b7-4045-b88c-08dea9e23d1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8455
X-Rspamd-Queue-Id: 939FF4BDFB6
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
	TAGGED_FROM(0.00)[bounces-283853-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
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
  with __must_check.
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
 net/ipv4/nexthop.c | 85 +++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index f92fcc39fc4c..1822df80fca5 100644
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
@@ -2093,22 +2091,26 @@ static void remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 
 	if (nlinfo)
 		nexthop_notify(RTM_NEWNEXTHOP, nhp, nlinfo);
+
+	return false;
 }
 
-static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
+static bool remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 				       struct nl_info *nlinfo)
 {
 	struct nh_grp_entry *nhge, *tmp;
+	bool need_flush = false;
 	LIST_HEAD(deferred_free);
 
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
@@ -2118,6 +2120,8 @@ static void remove_nexthop_from_groups(struct net *net, struct nexthop *nh,
 		list_del(&nhge->nh_list);
 		free_percpu(nhge->stats);
 	}
+
+	return need_flush;
 }
 
 static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
@@ -2142,18 +2146,15 @@ static void remove_nexthop_group(struct nexthop *nh, struct nl_info *nlinfo)
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
 
@@ -2173,12 +2174,14 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
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
@@ -2189,13 +2192,17 @@ static void __remove_nexthop(struct net *net, struct nexthop *nh,
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
@@ -2204,10 +2211,19 @@ static void remove_nexthop(struct net *net, struct nexthop *nh,
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
@@ -2592,7 +2608,7 @@ static int replace_nexthop(struct net *net, struct nexthop *old,
 	if (!err) {
 		nh_rt_cache_flush(net, old, new);
 
-		__remove_nexthop(net, new, NULL);
+		WARN_ON(__remove_nexthop(net, new, NULL));
 		nexthop_put(new);
 	}
 
@@ -2701,6 +2717,7 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
 	struct hlist_head *head = &net->nexthop.devhash[hash];
 	struct hlist_node *n;
 	struct nh_info *nhi;
+	bool need_flush = false;
 
 	hlist_for_each_entry_safe(nhi, n, head, dev_hash) {
 		if (nhi->fib_nhc.nhc_dev != dev)
@@ -2710,22 +2727,28 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
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
@@ -2994,7 +3017,7 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
 
 	err = insert_nexthop(net, nh, cfg, extack);
 	if (err) {
-		__remove_nexthop(net, nh, NULL);
+		WARN_ON(__remove_nexthop(net, nh, NULL));
 		nexthop_put(nh);
 		nh = ERR_PTR(err);
 	}
@@ -3363,7 +3386,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	nh = nexthop_find_by_id(net, id);
 	if (nh)
-		remove_nexthop(net, nh, &nlinfo);
+		remove_one_nexthop(net, nh, &nlinfo);
 	else
 		err = -ENOENT;
 
-- 
2.53.0


