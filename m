Return-Path: <netdev+bounces-183987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC8A92E98
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24EE31B62D8B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87AA372;
	Fri, 18 Apr 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IvKTHC/B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAAE173
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934770; cv=none; b=JZKhUyh0aAOvcAz73CKk9iZXoHaeYdZQ8iKCaSci7XlZfEnf32iLp1MXkKC1nVorVNXjOUJAgeX+LuE8LKCIj3FmlQEWZChlTJQA6ieGR0nWO86lSkobvbxUhTro2bau0bG7MELZEffzvgcpSN2bdK+nSUo/HSobgrzDACkfFaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934770; c=relaxed/simple;
	bh=Fuutsn61IHMomBjG7leOACqHSb6KVxMiqiqJLcNPp6U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iSLRBe2Gxei9BlUuoOa0n+hOfnmGMMKelm6HLEIfKx3nkKlG3quAd1VXGUgY5ssRwN2MNmiO/sh+WcaV9V/bDoYtQY5uu+HYOSgXVfrEGY1u7trNA8wNI2Shpq2nItps7/VQ7LIGU4X38ACAOvxhsoWiOQ5/KYYE9zVUremyXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IvKTHC/B; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934769; x=1776470769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dbLXO3JyzqRGfNfdiSk6OeC+3HB77bo1Dvl1TL3/C6c=;
  b=IvKTHC/B4TSwetlk5eDD6YAaZk4otLV21Ur9bpFRPnaCudYhDHKtic+L
   iRetqKptZuZ+T/7WP4qAf6dw11EyH5bg4q86EuTIYHdGZXfWJox0YkBOW
   VczqTf+rpTW8WDcWsSVYgglhKJGAC9drwBHOuzPkxoq4lSEqFg+gun5s9
   I=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="736587471"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:04:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:55475]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.145:2525] with esmtp (Farcaster)
 id 19570ecc-6782-4fa1-9d55-351d3b75b7b0; Fri, 18 Apr 2025 00:04:56 +0000 (UTC)
X-Farcaster-Flow-ID: 19570ecc-6782-4fa1-9d55-351d3b75b7b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:04:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:04:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 00/15] ipv6: No RTNL for IPv6 routing table.
Date: Thu, 17 Apr 2025 17:03:41 -0700
Message-ID: <20250418000443.43734-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

IPv6 routing tables are protected by each table's lock and work in
the interrupt context, which means we basically don't need RTNL to
modify an IPv6 routing table itself.

Currently, the control paths require RTNL because we may need to
perform device and nexthop lookups; we must prevent dev/nexthop from
going away from the netns.

This, however, can be achieved by RCU as well.

If we are in the RCU critical section while adding an IPv6 route,
synchronize_net() in __dev_change_net_namespace() and
unregister_netdevice_many_notify() guarantee that the dev will not be
moved to another netns or removed.

Also, nexthop is guaranteed not to be freed during the RCU grace period.

If we care about a race between nexthop removal and IPv6 route addition,
we can get rid of RTNL from the control paths.

Patch 1 moves a validation for RTA_MULTIPATH earlier.
Patch 2 removes RTNL for SIOCDELRT and RTM_DELROUTE.
Patch 3 ~ 11 moves validation and memory allocation earlier.
Patch 12 prevents a race between two requests for the same table.
Patch 13 & 14 prevents the nexthop race mentioned above.
Patch 15 removes RTNL for SIOCADDRT and RTM_NEWROUTE.


Test:

The script [0] lets each CPU-X create 100000 routes on table-X in a
batch.

On c7a.metal-48xl EC2 instance with 192 CPUs,

without this series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  total routes: 19200006
  Time elapsed: 191577 milliseconds.

with this series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  total routes: 19200006
  Time elapsed: 62854 milliseconds.

I changed the number of routes (1000 ~ 100000 per CPU/table) and
consistently saw it finish 3x faster with this series.


[0]
#!/bin/bash

mkdir tmp

NS="test"
ip netns add $NS
ip -n $NS link add veth0 type veth peer veth1
ip -n $NS link set veth0 up
ip -n $NS link set veth1 up

TABLES=()
for i in $(seq $(nproc)); do
    TABLES+=("$i")
done

ROUTES=()
for i in {1..100}; do
    for j in {1..1000}; do
	ROUTES+=("2001:$i:$j::/64")
    done
done

for TABLE in "${TABLES[@]}"; do
    (
	FILE="./tmp/batch-table-$TABLE.txt"
	> $FILE
	for ROUTE in "${ROUTES[@]}"; do
            echo "route add $ROUTE dev veth0 table $TABLE" >> $FILE
	done
    ) &
done

wait

echo "start adding routes"

START_TIME=$(date +%s%3N)
for TABLE in "${TABLES[@]}"; do
    ip -n $NS -6 -batch "./tmp/batch-table-$TABLE.txt" &
done

wait
END_TIME=$(date +%s%3N)
ELAPSED_TIME=$((END_TIME - START_TIME))

echo "added $((${#ROUTES[@]} * ${#TABLES[@]})) routes (${#ROUTES[@]} routes * ${#TABLES[@]} tables)."
echo "total routes: $(ip -n $NS -6 route show table all | wc -l)"  # Just for debug
echo "Time elapsed: ${ELAPSED_TIME} milliseconds."

ip netns del $NS
rm -fr ./tmp/


Changes:
  v3:
    * Add patch 10
    * Patch 2
      * Add a note that fib6_get_table() does not require RCU
    * Patch 4
      * Explain the checks do not require RCU.
    * Patch 6
      * Update changelog s/everything as possible/as much as possible/
    * Patch 7
      * Explain alloc_percpu_gfp() is still needed when called via ipv6_stub.
    * Patch 14
      * Bundle critical section for rt->nh as fib6_add_rt2node_nh()
    * Patch 15
      * Add a note about lwtunnel_valid_encap_type()

  v2 (RESEND) : https://lore.kernel.org/netdev/20250414181516.28391-1-kuniyu@amazon.com/

  v2: https://lore.kernel.org/netdev/20250409011243.26195-1-kuniyu@amazon.com/
    * Add Patch 12
    * Patch 2
      * Call __ip6_del_rt() under RCU

  v1: https://lore.kernel.org/netdev/20250321040131.21057-1-kuniyu@amazon.com/


Kuniyuki Iwashima (15):
  ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
  ipv6: Get rid of RTNL for SIOCDELRT and RTM_DELROUTE.
  ipv6: Move some validation from ip6_route_info_create() to
    rtm_to_fib6_config().
  ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().
  ipv6: Move nexthop_find_by_id() after fib6_info_alloc().
  ipv6: Split ip6_route_info_create().
  ipv6: Preallocate rt->fib6_nh->rt6i_pcpu in ip6_route_info_create().
  ipv6: Preallocate nhc_pcpu_rth_output in ip6_route_info_create().
  ipv6: Don't pass net to ip6_route_info_append().
  ipv6: Rename rt6_nh.next to rt6_nh.list.
  ipv6: Factorise ip6_route_multipath_add().
  ipv6: Protect fib6_link_table() with spinlock.
  ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
  ipv6: Protect nh->f6i_list with spinlock and flag.
  ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.

 include/net/ip6_fib.h    |   1 +
 include/net/netns/ipv6.h |   1 +
 include/net/nexthop.h    |   2 +
 net/ipv4/fib_semantics.c |  10 +-
 net/ipv4/nexthop.c       |  22 +-
 net/ipv6/ip6_fib.c       |  84 ++++--
 net/ipv6/route.c         | 577 ++++++++++++++++++++++++---------------
 7 files changed, 452 insertions(+), 245 deletions(-)

-- 
2.49.0


