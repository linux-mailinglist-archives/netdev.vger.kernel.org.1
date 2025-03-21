Return-Path: <netdev+bounces-176650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39231A6B383
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD74B3B2327
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0B1957FF;
	Fri, 21 Mar 2025 04:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qlM9d4UH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853D4120B
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529708; cv=none; b=FD2WkG675/XF+wx9Kl02iuQNO8T5NQ8oqXExtOTtu3Cc7y2cxdEHbkytUl1CCktUwm2wHeVuNEdUkDVgRHD6ZzA8u4hbPE7tocDpZtyrJzE8f8yjBtV3CBJr2krTK/SyqdY++be9ar8e/vH7AsGVjbCkC6d+tGROySdNelF4x8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529708; c=relaxed/simple;
	bh=N+gi7tsDXVYB/nwcoY3gI9PQETzEnsU9ylubHI4rPTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=foR8c2g3cfulXD52KKltHehoPVmmJoB2QgLzpfKtR313MKIuXuwBi+lf+3Qa5F8TmnV9GXGI2IXMoXf/r3lCFbdoJqj4nPLCRsugWla3/2lAuTt6sd607p8qdPYVAsSEBt4ZnbvgOglYQJYVqDDjJScN0IhpdhxMQae5DpaCUHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qlM9d4UH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529707; x=1774065707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oMvRycwbNKMT1W4bmpPRUU00e2pCpfeSvwqAmTd0IrY=;
  b=qlM9d4UHe+YpMOyurEz8hkBv5hddku24FIeNe6ebPyByU/odLBAn59c6
   itH4uHj/Km6rf7603I3aPWfdZia1/DOTbOYjWwvBDkJxBf8ZzBHRbcwCc
   GBatPJ0IhENvMvNuZxPT/+VKBfK0HKtORDniF+9b/6DQt88lH9+Dk0rz9
   g=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="388607439"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:01:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:1289]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.36:2525] with esmtp (Farcaster)
 id dfde216e-499f-4c40-90c4-9b6be0ecdf95; Fri, 21 Mar 2025 04:01:44 +0000 (UTC)
X-Farcaster-Flow-ID: dfde216e-499f-4c40-90c4-9b6be0ecdf95
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:01:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:01:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/13] ipv6: No RTNL for IPv6 routing table.
Date: Thu, 20 Mar 2025 21:00:37 -0700
Message-ID: <20250321040131.21057-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

IPv6 routing tables are protected by each table's lock and work in
the interrupt context, which means we basically don't need RTNL to
modify an IPv6 routing table itself.

Currently, the control paths require RTNL because we may need to
perform device and nexthop lookups; we must prevent dev/nexthop from
going away from the netns.

This, however, can be achieved by RCU as well.

If we are in the RCU critical section while adding an IPv6 route,
synchronize_net() in netif_change_net_namespace() and
unregister_netdevice_many_notify() guarantee that the dev will not be
moved to another netns or removed.

Also, nexthop is guaranteed not to be freed during the RCU grace period.

If we care about a race between nexthop removal and IPv6 route addition,
we can get rid of RTNL from the control paths.

Patch 1 moves a validation for RTA_MULTIPATH earlier.
Patch 2 removes RTNL for SIOCDELRT and RTM_DELROUTE.
Patch 3 ~ 10 move validation and memory allocation earlier.
Patch 11 prevents a race between two requests for the same table.
Patch 12 prevents the race mentioned above.
Patch 13 removes RTNL for SIOCADDRT and RTM_NEWROUTE.


Test:

The script [0] lets each CPU-X create 100000 routes on table-X in a
batch.

On c7a.metal-48xl EC2 instance with 192 CPUs,

With this series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  Time elapsed: 189154 milliseconds.

Without series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  Time elapsed: 62531 milliseconds.

I changed the number of routes (1000 ~ 100000 per CPU/table) and
constantly saw it complete 3x faster with this series.


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
    FILE="./tmp/batch-table-$TABLE.txt"
    > $FILE
    for ROUTE in "${ROUTES[@]}"; do
        echo "route add $ROUTE dev veth0 table $TABLE" >> $FILE
    done
done

echo "start adding routes"

START_TIME=$(date +%s%3N)
for TABLE in "${TABLES[@]}"; do
    ip -n $NS -6 -batch "./tmp/batch-table-$TABLE.txt" &
done

wait
END_TIME=$(date +%s%3N)
ELAPSED_TIME=$((END_TIME - START_TIME))

echo "added $((${#ROUTES[@]} * ${#TABLES[@]})) routes (${#ROUTES[@]} routes * ${#TABLES[@]} tables)."
echo "Time elapsed: ${ELAPSED_TIME} milliseconds."
echo $(ip -n $NS -6 route show table all | wc -l)  # Just for debug

ip netns del $NS
rm -fr ./tmp/


Kuniyuki Iwashima (13):
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
  ipv6: Factorise ip6_route_multipath_add().
  ipv6: Protect fib6_link_table() with spinlock.
  ipv6: Protect nh->f6i_list with spinlock and flag.
  ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.

 include/net/netns/ipv6.h |   1 +
 include/net/nexthop.h    |   2 +
 net/ipv4/fib_semantics.c |  10 +-
 net/ipv4/nexthop.c       |  24 +-
 net/ipv6/ip6_fib.c       |  51 +++-
 net/ipv6/route.c         | 555 ++++++++++++++++++++++++---------------
 6 files changed, 415 insertions(+), 228 deletions(-)

-- 
2.48.1


