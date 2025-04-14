Return-Path: <netdev+bounces-182405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87757A88ADB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DFA1898C58
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF47D1A317A;
	Mon, 14 Apr 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UEBMk4Ut"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4428466C
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654536; cv=none; b=U6KmwYWqSNswelEQpM3Aor3gZUX8yID3eBg4BlWWYNa0LOCUsF6xKd7hf3v5CfY/LwsYBaSBh9ZzZXYIxJylzuZOUYeVn0lElN4M1kqmHLlEnP/p0O2plG5RlzQQYgXX430DAO2CHyfuM02aOritYUHkpmUhIQ4bwodgTZpuDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654536; c=relaxed/simple;
	bh=CS8nBE0Eaw9ylAkSLhqzhRPJjvN6VP6sKBR4ukUPMaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZGj5WruA8SYf4wk84QuqVEH2R2M00BoOqNWIzOzSOFFH2Rc/93kq4HgBBMpNUndFPCe1keVOnCcFVWHtZirprRni9rA6ijQqrjN4tAo5tGUmLPhxmowtyt8Oc0CTsOkfeG8hejwCcHiFmQSytXQY4NMytKfLBdzcyn4qB4/kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UEBMk4Ut; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654535; x=1776190535;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rsOnGrN1xNw7XZqRh4id5lPy2UeYvQbCT2afpuCx/Nc=;
  b=UEBMk4Utcqx+l/m9PVvzRhFkOszULYhpvUEgW++NEEzUqoajI2LsdOwt
   54guL0EeH31LDtTXA1NQgkgwn9Y9/T/p/HnA+ZJo29djRmuB3ADrGiGEx
   dPT4DK3CKWq0vBNSqF06wId7ybwKqn0r0esw4PMIHy9eXipGcRDbO8fEE
   k=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="480298236"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:15:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:45518]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id a3d463ea-b7da-440a-a953-ab55d285b36b; Mon, 14 Apr 2025 18:15:30 +0000 (UTC)
X-Farcaster-Flow-ID: a3d463ea-b7da-440a-a953-ab55d285b36b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:15:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:15:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 00/14] ipv6: No RTNL for IPv6 routing table.
Date: Mon, 14 Apr 2025 11:14:48 -0700
Message-ID: <20250414181516.28391-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
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
Patch 3 ~ 10 moves validation and memory allocation earlier.
Patch 11 prevents a race between two requests for the same table.
Patch 12 & 13 prevents the nexthop race mentioned above.
Patch 14 removes RTNL for SIOCADDRT and RTM_NEWROUTE.

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
  v2 (RESEND)

  v2: https://lore.kernel.org/netdev/20250409011243.26195-1-kuniyu@amazon.com/
    * Add Patch 12
    * Patch 2
      * Call __ip6_del_rt() under RCU

  v1: https://lore.kernel.org/netdev/20250321040131.21057-1-kuniyu@amazon.com/


Kuniyuki Iwashima (14):
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
  ipv6: Defer fib6_purge_rt() in fib6_add_rt2node() to fib6_add().
  ipv6: Protect nh->f6i_list with spinlock and flag.
  ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.

 include/net/ip6_fib.h    |   1 +
 include/net/netns/ipv6.h |   1 +
 include/net/nexthop.h    |   2 +
 net/ipv4/fib_semantics.c |  10 +-
 net/ipv4/nexthop.c       |  22 +-
 net/ipv6/ip6_fib.c       |  75 ++++--
 net/ipv6/route.c         | 567 ++++++++++++++++++++++++---------------
 7 files changed, 438 insertions(+), 240 deletions(-)

-- 
2.49.0


