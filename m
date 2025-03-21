Return-Path: <netdev+bounces-176762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB263A6C09C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FB0167C3A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 16:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5722CBF4;
	Fri, 21 Mar 2025 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L5SItdLI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1D22424E
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575935; cv=none; b=C2QTE69X3+4YpRsMH5LcCxN80D846c7SfMfAQOVstJNKtXVg2CALBnbQaidma0ubt00qR7yvj2mj0XVxINxC5wpSkL1es+a2p9PvjksVCvesvGzDQIzwujrUboT/8batrrZR+JGLK3vokTAZyzW0XIWHTA3jyJdRwZRaHqRLa6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575935; c=relaxed/simple;
	bh=r+nweYBW6eW6OpU9BM9mPc05EN/S/gTp8zfu//ZPplc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9dp/fPN611gptfzk96yo8g7facJfiXoClF4HK+Yucc7mR4bf7+W0bNrwr2PL85pJ/wniXvVFrAwIrXWEbsInQNmi+S+8ZmiKQHzNgEGZCvga7AuW3xZZPoIvckixnLNSRNKwwSo9SRDqWBqn8vI9EcNPF6FXc9njcw/7hsd7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L5SItdLI; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742575934; x=1774111934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O7QUs5oUJLPU9CXByWhpFn+l4ChMNPx92TwGG+CoNWg=;
  b=L5SItdLItG/pzB7y8IKqb7/nkwCZQme9zlWPWW0N8cEc+mVXHVhx/Lsu
   5Q2Ahb/ZgDa1aJ6CclcrMh6T4/XP1/4IJPkNnh77jpAhopxc2aid9mTfe
   VaOqZqyHO8x+pbSflkffFIAqiI3w1UkdSyNpgP8eY9ExlQ6oY0N72SLe7
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,265,1736812800"; 
   d="scan'208";a="388815080"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 16:52:11 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:39228]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.105:2525] with esmtp (Farcaster)
 id 053bc724-8908-46d4-936d-c8cdbc380bfc; Fri, 21 Mar 2025 16:52:10 +0000 (UTC)
X-Farcaster-Flow-ID: 053bc724-8908-46d4-936d-c8cdbc380bfc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 16:52:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 16:52:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stfomichev@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 00/13] ipv6: No RTNL for IPv6 routing table.
Date: Fri, 21 Mar 2025 09:50:40 -0700
Message-ID: <20250321165154.17497-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z91yk90LZy9yJexG@mini-arch>
References: <Z91yk90LZy9yJexG@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Fri, 21 Mar 2025 07:07:15 -0700
> On 03/20, Kuniyuki Iwashima wrote:
> > IPv6 routing tables are protected by each table's lock and work in
> > the interrupt context, which means we basically don't need RTNL to
> > modify an IPv6 routing table itself.
> > 
> > Currently, the control paths require RTNL because we may need to
> > perform device and nexthop lookups; we must prevent dev/nexthop from
> > going away from the netns.
> > 
> > This, however, can be achieved by RCU as well.
> > 
> > If we are in the RCU critical section while adding an IPv6 route,
> > synchronize_net() in netif_change_net_namespace() and
> > unregister_netdevice_many_notify() guarantee that the dev will not be
> > moved to another netns or removed.
> > 
> > Also, nexthop is guaranteed not to be freed during the RCU grace period.
> > 
> > If we care about a race between nexthop removal and IPv6 route addition,
> > we can get rid of RTNL from the control paths.
> > 
> > Patch 1 moves a validation for RTA_MULTIPATH earlier.
> > Patch 2 removes RTNL for SIOCDELRT and RTM_DELROUTE.
> > Patch 3 ~ 10 move validation and memory allocation earlier.
> > Patch 11 prevents a race between two requests for the same table.
> > Patch 12 prevents the race mentioned above.
> > Patch 13 removes RTNL for SIOCADDRT and RTM_NEWROUTE.
> > 
> > 
> > Test:
> > 
> > The script [0] lets each CPU-X create 100000 routes on table-X in a
> > batch.
> > 
> > On c7a.metal-48xl EC2 instance with 192 CPUs,
> > 
> > With this series:
> > 
> >   $ sudo ./route_test.sh
> >   start adding routes
> >   added 19200000 routes (100000 routes * 192 tables).
> >   Time elapsed: 189154 milliseconds.
> > 
> > Without series:
> > 
> >   $ sudo ./route_test.sh
> >   start adding routes
> >   added 19200000 routes (100000 routes * 192 tables).
> >   Time elapsed: 62531 milliseconds.
> > 
> > I changed the number of routes (1000 ~ 100000 per CPU/table) and
> > constantly saw it complete 3x faster with this series.
> > 
> > 
> > [0]
> > #!/bin/bash
> > 
> > mkdir tmp
> > 
> > NS="test"
> > ip netns add $NS
> > ip -n $NS link add veth0 type veth peer veth1
> > ip -n $NS link set veth0 up
> > ip -n $NS link set veth1 up
> > 
> > TABLES=()
> > for i in $(seq $(nproc)); do
> >     TABLES+=("$i")
> > done
> > 
> > ROUTES=()
> > for i in {1..100}; do
> >     for j in {1..1000}; do
> > 	ROUTES+=("2001:$i:$j::/64")
> >     done
> > done
> > 
> > for TABLE in "${TABLES[@]}"; do
> >     FILE="./tmp/batch-table-$TABLE.txt"
> >     > $FILE
> >     for ROUTE in "${ROUTES[@]}"; do
> >         echo "route add $ROUTE dev veth0 table $TABLE" >> $FILE
> >     done
> > done
> > 
> > echo "start adding routes"
> > 
> > START_TIME=$(date +%s%3N)
> > for TABLE in "${TABLES[@]}"; do
> >     ip -n $NS -6 -batch "./tmp/batch-table-$TABLE.txt" &
> > done
> > 
> > wait
> > END_TIME=$(date +%s%3N)
> > ELAPSED_TIME=$((END_TIME - START_TIME))
> > 
> > echo "added $((${#ROUTES[@]} * ${#TABLES[@]})) routes (${#ROUTES[@]} routes * ${#TABLES[@]} tables)."
> > echo "Time elapsed: ${ELAPSED_TIME} milliseconds."
> > echo $(ip -n $NS -6 route show table all | wc -l)  # Just for debug
> > 
> > ip netns del $NS
> > rm -fr ./tmp/
> 
> Lockdep is not supper happy about some patch:
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/42463/38-gre-multipath-nh-res-sh/stderr

Looks like I need to extend the RCU critical section in
ip6_route_del() in patch 2:

---8<---
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index d1d60415d1aa..b6434532858f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4104,9 +4104,9 @@ static int ip6_route_del(struct fib6_config *cfg,
 			if (rt->nh) {
 				if (!fib6_info_hold_safe(rt))
 					continue;
-				rcu_read_unlock();
 
-				return __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				err =  __ip6_del_rt(rt, &cfg->fc_nlinfo);
+				break;
 			}
 			if (cfg->fc_nh_id)
 				continue;
@@ -4121,13 +4121,13 @@ static int ip6_route_del(struct fib6_config *cfg,
 				continue;
 			if (!fib6_info_hold_safe(rt))
 				continue;
-			rcu_read_unlock();
 
 			/* if gateway was specified only delete the one hop */
 			if (cfg->fc_flags & RTF_GATEWAY)
-				return __ip6_del_rt(rt, &cfg->fc_nlinfo);
-
-			return __ip6_del_rt_siblings(rt, cfg);
+				err = __ip6_del_rt(rt, &cfg->fc_nlinfo);
+			else
+				err = __ip6_del_rt_siblings(rt, cfg);
+			break;
 		}
 	}
 	rcu_read_unlock();
---8<---

Thanks!

