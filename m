Return-Path: <netdev+bounces-285175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IyLNfdF/Gn9NgAAu9opvQ
	(envelope-from <netdev+bounces-285175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB14E4517
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 09:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 956CB303E11B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6837997A;
	Thu,  7 May 2026 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qXaEBxHn"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20A379EDA
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140619; cv=fail; b=ZfCj/fdCGqMQL1LcD4z4ehk4C+hjbGoB0Rtt7OYrjUqJ0A6L/XbECjs08iZsqprWZuUrUicgzS9R46pJbkJQ1LQ0c3NK/AGd4WYI+COTwWplPp0VKkZEytrQO8jB99PjbPxgpUKfLXPCvKwz6NjS+GWRtfv2WhbyTV87CiHRD50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140619; c=relaxed/simple;
	bh=ftisoms9GHRQENIT8JYjPssxyrV2u9QtV6YurXUutBg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWr3rPc7nC1sp1vl3Jfj6yMgWb3wS0KJkdmlMuzMd9M+wvczDJdONU4W/zfSaeR0FF5HDFi1n6FmUqUjhKnraQiOuMvRj8tA7c0MQzNTtk6zRWy3/asdISToRf0eaDYzn9FdZmOW+bmidHFuXuyu0F7Kgv1SHACrcH9F+uQgutA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qXaEBxHn; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH1fdHNJAFPOxUXFFFOhpPhaeRrZKJm5yFz+y9wQJyWUnUEaU2NvJeLyob5MQ4FiOYWNhLown5nqeLSRoKy2qLe7lNl85y69M+WyhqnijhM1+co/FiycaC2N+6fWIOYrp0GoGMRYpb0gbu1Sx2Abbo3OIg05Wni48nAs7dB8ANGZHrPMMOACZ5Sv/DiWR+OjC39qeyPVIihWadj43bKrstVgFqv3zdfVkjwCEbYk6bPbCPL2oNYHmFQN7dncrTiVNOpoCr5frQF9zbUEp3RKsv0Tde1YqQYyqkUjtn63ZW6WBM0tN410OtGkAnDy6+TZcaXCtjWJtLY/UOwEC2wUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bm+yEmyOszZAW0PJaOzpnhaVm6AH5y5XGJcYNiZIvHo=;
 b=wXxNUcsj8c4leqLxYlk8F3GhcuJDVwgL5gcJnM8eim8Ypm7iSF9xTwSqT1kiMaa6TJm32qhg8idvxEhqMJuT6o8ajZntJpixS2cezriHqZb98L2L/leyX6gtAk/t+5hFpLKY18k57Zu0I5pfhzy0ClphET77VaL0gcfSe1kSpLbSxHeyXp4gkTrIzTPgPx0ifLwTZ08bHZlbpxLO6fkKAseIJ/BtnQ+6dZz6CbAKvEjKdNO7xl43baFRT9UQvieGDl4Bvd9UF1nlqFqJCEqkZ/Or3c8h74o9k7sdKtbKsOzyTj+jBfekWchSkXsjG6ufr5CxPo8t1vtBavyL3fzT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bm+yEmyOszZAW0PJaOzpnhaVm6AH5y5XGJcYNiZIvHo=;
 b=qXaEBxHnNZ0tpPykLg9vq4F32YJH+Fp1lTq7Pu3d9wWEG/oCG6YMgZO2Rzacl9NdYOZzA44PeiimafHf30slGUaPVBJ3+Y/rDS6s9oUYm3N9o67ZvvGj616waojMGWR7AMluoouTvz2SeKpZqolhxZ4XJL6U+BLDNv9o/9e7e3jL5uRDJn3f5GjLyQ1CnwI+fXj6GDotIALVt64YveaaVKRmNQn9/evpBg/AmH4JNicjS+KZUuVESldSPRRoSsFsbS97Q/616d17gstl5bgyC5GyZeXl7bf2tAo9ckMY4xsuUkd+5fKjQO1R7dwQLTGEBscu5dVnedoY5Q5yzdtQ6A==
Received: from SJ0PR13CA0140.namprd13.prod.outlook.com (2603:10b6:a03:2c6::25)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 07:56:53 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::dd) by SJ0PR13CA0140.outlook.office365.com
 (2603:10b6:a03:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Thu, 7
 May 2026 07:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 07:56:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 00:56:38 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 00:56:34 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH v3 net-next 2/3] ipv4: Flush the FIB once on multiple nexthop removal
Date: Thu, 7 May 2026 10:56:05 +0300
Message-ID: <20260507075606.322405-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507075606.322405-1-cratiu@nvidia.com>
References: <20260507075606.322405-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c114794-a68c-4093-b553-08deac0e33e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18092099006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/oQcUhK7BiapBoilNDR3fEWNKKP13YB2tExhZCnn9+BS6vEcYhWBNakMgy79PAdTPVKB1Puw6AcOq7JQCKZAmozBPmPEK1ZA8MS6Bsg/A2iIWYENaPldpKUSWTZguSRyvG0YmH6GwsFO5PZeg1W+k66FiieyWfqVXFCz5wLyNnsEZmZNS/3JMKumQrlyq++I7iuSNJN9X+6wzUNr99d60Fo8Kj/RvozvewWxsb2tUM4/u3wZA95577xRCyfRzIhRFMZUJJUvoZYAgLWefmkiqu8aADsKSfDdIJN7yZfV7uWgvE8czHjwuOy7PIr7cO+nMyTXt2vUNwAZTkdWLjljJ8EeMp8GdgE+nOMKfkFbyzid5FuMJ0rNAvXiFbPDH0nCRTD6ii0p94ddngfwmH54zRKOrUmLZeDNyDtAgL51UJHVrtKkVin0gK1pqrzdbJrT2ozHfw9rYW9aGPQRR/pqqb0Jyvi1JRDCtV/vNjO4WXgB9YYSldBJ4JmtuU0E35btjtMBMWrKbXEOLRPjDzjYAKMfUHBkM+tsRbeIcXgoY8JORBI/h7L9XjiDLWTLYJNQ0CtUedMZcS8dmypYQZsgb3V9ZlOzcCwBmdtRRBZU+264lyE2a9FcwcjXzFfBoURtq3/GEcHZGXhNq9uZIBfM7lQKyqNJxVhuPe6SqAnOz5OYsD/oY3jIXIPhQnfwmkpzwIlK5Sa/s+T88BApzVJWFxoGtAtYaEcOhGaPzmfbvlA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18092099006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zOCn+3wi8b/tqXG5Z0e40oOkLRLQnjX360JqblJQW5pCB1gi0djx7t2uLA5lEWHubmhz3Za4T09CLymT9B2F8mfpm39KvXo5PqqwwI3MeMM3DMzpn6Spi4qwCwQ5KlBAN9SuooXZLuwAoCblXJLtNHrMDAJ7ne3Dp3Hq6x6x0TeYPi6sCSAKnjBeSG2M8ayOayZVxz3oEdOgSZ5Dc2TmJ02ySGQI8etNced+9Ky8BGy/+0P+3OG0D93zngjhQQZJQ2hfnBVW+G7fFD55LOvD9rIENRt4uRUah3+HF/MEeP+YAOd1n55rFQrN+EsTb9NEMmwKCmgJkeyn23iZxjrsv3qc0Ucinx9/pOuwkv84pjzGUlMMMQjdtLKoUrW6KSeTgMKaBxnxqFij/l/p5Kg6K5IiInE01Q75rGdyMzYGlKDgqTPlNzOaflRtdLGmH/Fm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 07:56:53.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c114794-a68c-4093-b553-08deac0e33e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
X-Rspamd-Queue-Id: 4AEB14E4517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285175-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

When a device is going down or when a net namespace is deleted, all
nexthops on it are removed, and for each nexthop being removed the FIB
table is flushed, which does a full trie traversal looking for entries
marked RTNH_F_DEAD and removing them. This is O(N x R), with N being
number of dev nexthops and R being number of IPv4 routes.

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

This patch makes use of the previously added FIB flushing signal to only
do a single FIB flush after all nexthops to be removed are marked as
RTNH_F_DEAD:
- __remove_nexthop_fib() no longer flushes the FIB.
- nexthop_flush_dev() and flush_all_nexthops() now keep track whether
  any nexthop was removed and trigger a FIB flush at the end.
- a new wrapper is defined, remove_one_nexthop() which calls
  remove_nexthop() and flushes if necessary. This is intended for places
  which must remove a single nexthop and shouldn't worry about the need
  to trigger a FIB flush. For now, the only caller is rtm_del_nexthop().
- The two direct callers of __remove_nexthop() get a WARN_ON_ONCE, since
  the nh about to be removed should not have any FIB entries referencing
  it when replacing or inserting a new one.

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
 net/ipv4/nexthop.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7177092d2605..703954c490d0 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2154,8 +2154,6 @@ static bool __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 
 	list_for_each_entry(fi, &nh->fi_list, nh_list)
 		fi->fib_flags |= RTNH_F_DEAD;
-	if (need_flush)
-		fib_flush(net);
 
 	spin_lock_bh(&nh->lock);
 
@@ -2220,6 +2218,13 @@ static bool remove_nexthop(struct net *net, struct nexthop *nh,
 	return need_flush;
 }
 
+static void remove_one_nexthop(struct net *net, struct nexthop *nh,
+			       struct nl_info *nlinfo)
+{
+	if (remove_nexthop(net, nh, nlinfo))
+		fib_flush(net);
+}
+
 /* if any FIB entries reference this nexthop, any dst entries
  * need to be regenerated
  */
@@ -2602,7 +2607,7 @@ static int replace_nexthop(struct net *net, struct nexthop *old,
 	if (!err) {
 		nh_rt_cache_flush(net, old, new);
 
-		__remove_nexthop(net, new, NULL);
+		WARN_ON_ONCE(__remove_nexthop(net, new, NULL));
 		nexthop_put(new);
 	}
 
@@ -2709,6 +2714,7 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
 	unsigned int hash = nh_dev_hashfn(dev->ifindex);
 	struct net *net = dev_net(dev);
 	struct hlist_head *head = &net->nexthop.devhash[hash];
+	bool need_flush = false;
 	struct hlist_node *n;
 	struct nh_info *nhi;
 
@@ -2720,22 +2726,28 @@ static void nexthop_flush_dev(struct net_device *dev, unsigned long event)
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
@@ -3004,7 +3016,7 @@ static struct nexthop *nexthop_add(struct net *net, struct nh_config *cfg,
 
 	err = insert_nexthop(net, nh, cfg, extack);
 	if (err) {
-		__remove_nexthop(net, nh, NULL);
+		WARN_ON_ONCE(__remove_nexthop(net, nh, NULL));
 		nexthop_put(nh);
 		nh = ERR_PTR(err);
 	}
@@ -3373,7 +3385,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	nh = nexthop_find_by_id(net, id);
 	if (nh)
-		remove_nexthop(net, nh, &nlinfo);
+		remove_one_nexthop(net, nh, &nlinfo);
 	else
 		err = -ENOENT;
 
-- 
2.53.0


