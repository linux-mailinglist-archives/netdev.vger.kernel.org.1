Return-Path: <netdev+bounces-180543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BD8A81A57
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229C916FCCA
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7F42048;
	Wed,  9 Apr 2025 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F6ap09Cv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995C411CA9
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161181; cv=none; b=W6AExCQsqaGujrYZhRPQNcjJh95uHpiz5+StuL62t9ArcTDrtTmjIPO6gEF5pvE3rZWSu0ZhU3+IYH2j9/28Kh6/CJFPXvBN8mDbJaXpgAb/5UWQqTSMhkn5b6+NUzZVd0dL6FoU03n9ZLGu03LmPnnuujhG8Vqg1rfP+ZHR/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161181; c=relaxed/simple;
	bh=qCxbyCf7i/Wu57nobq7O6yQ2mBbXX3WqNh4wX3ynwjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kb8IT9uCH2TR3IBF2MJ3UaJAKi6xLnYYU3CZ8xY32+aU6lR8EEFVxkKV51Wr7LVth6a9VLnPx27V/9lNsTc/I22V03mbA2u87WIE3qsEUznN1O/DdF1YWH+RmXxgv26RPnuloLuXTo8ztNP4ckUehrJw8BavRQhfle/Ig59MVUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F6ap09Cv; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161180; x=1775697180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q7BuafVV2JMUZAivjBfGIxSwtzJBkf4YTi0bvAUzEXA=;
  b=F6ap09CvTZAd00AJ5yAhTIUsF+NR5E6sx03PzSmva4YXfyC4dsmKUW1G
   EYPA+Sbx6CU5CVqZjxKqnMNmUOFvQGkreGZea6H6ncBZZO0oM3i1avYh/
   TkhhbhD2dU5TLnls9yXbakoF28V4jHQbUqtyfRg/C/MuRs6mWuVIcaIbw
   s=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="481483313"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:12:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:56468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id 466a2fa2-70a7-4107-bb15-425baff7e48f; Wed, 9 Apr 2025 01:12:55 +0000 (UTC)
X-Farcaster-Flow-ID: 466a2fa2-70a7-4107-bb15-425baff7e48f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:12:55 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:12:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/14] ipv6: No RTNL for IPv6 routing table.
Date: Tue, 8 Apr 2025 18:12:08 -0700
Message-ID: <20250409011243.26195-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
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
Patch 12 & 13 prevents the race mentioned above.
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

with series:

  $ sudo ./route_test.sh
  start adding routes
  added 19200000 routes (100000 routes * 192 tables).
  total routes: 19200006
  Time elapsed: 62854 milliseconds.

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
  v2:
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


