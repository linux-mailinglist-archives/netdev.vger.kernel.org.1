Return-Path: <netdev+bounces-273752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC0oNIw4zGlFRgYAu9opvQ
	(envelope-from <netdev+bounces-273752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD13716B2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ACB43073D4B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB9426D30;
	Tue, 31 Mar 2026 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeiqU9at"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083B37B40B;
	Tue, 31 Mar 2026 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991285; cv=none; b=DsvxhXmkaIsbaamxvYBIZw36eNhMs5MQQGLpv5Sh15clNBCREDCp6afB4JpOq9pmxoWH+42qjtbE3EE9ysSXImAogMwMf3Lfz5jygkkZBjSVLhHedqBKGW4rY87XdOKOVtEKb4Fn+gWUUcsmUrXZo1XKdLndI7MphQHvUJkC6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991285; c=relaxed/simple;
	bh=4+HD6s1BTQWhbAYZra/lv7rJnAmnSfTgNsUCWZJFNPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJAHg3IGZXItof1dMyMVKlkuYKkDFjsb0b79IbTA+l4hDhXFT/bZinrDj5edvquo2bMW63kTd82fxdy54jsTNby+l8Rmu0gN9ZpFsnAfvG9pUAHojvZvUdOzw8fwahoYXQ6BLFHfBVB+ybTOflwz7P4LzT1IyHiMZQO1z0NRza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeiqU9at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E546C19423;
	Tue, 31 Mar 2026 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991285;
	bh=4+HD6s1BTQWhbAYZra/lv7rJnAmnSfTgNsUCWZJFNPY=;
	h=From:To:Cc:Subject:Date:From;
	b=KeiqU9atEz8eHLh7Dd5zVWpybXU8pZMelnzU2HBdg7Azksw0u0YPJU6edVGKhIiUY
	 BzEMwCCCWUfZKfONFyb2scP3th/W0mq9WBGvYikPRglo8OkdMrgC8ajn9zjQTl4QEC
	 u0UMzF4Wrd2Nw4JPyWDURdQyDmEdLBg7WGlEQ6Sm79/FRZG4v/PlQVKggs2HnPgiXJ
	 u7B3iwq5Gf+AdSPq9Px2aZwqv5Myy36fpJx9a/fSCma0LgzjKv2WyT4nhioqS4VQEe
	 n1Og7ysipuPJsdegodU5aTMP/Tiqfvu17Q/GDiuy1b8aej+HIZ/AV2/+i7TLnwC2HZ
	 twTyx1GnEVxig==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hawk@kernel.org,
	ivan@cloudflare.com,
	kernel-team@cloudflare.com
Subject: [RFC PATCH net-next 0/4] ipv4/ipv6: local address lookup scaling
Date: Tue, 31 Mar 2026 23:07:35 +0200
Message-ID: <20260331210739.3998753-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cloudflare.com:email]
X-Rspamd-Queue-Id: 6BDD13716B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

On servers with many IPv4 addresses (e.g. Cloudflare edge nodes with
~700 addrs), __ip_dev_find() becomes visible in perf profiles on the
unconnected UDP sendmsg path:

  udp_sendmsg
    ip_route_output_flow
      ip_route_output_key_hash_rcu
        __ip_dev_find              <-- source address validation
          inet_lookup_ifaddr_rcu   <-- walks inet_addr_lst hash chain

The current inet_addr_lst is a fixed-size hlist hash table with 256
buckets (IN4_ADDR_HSIZE). At 700 addresses this gives ~2.8 entries per
bucket on average. The O(N/256) lookup cost grows linearly as addresses
are added, with no mechanism to resize. IPv6 has the same issue with
inet6_addr_lst (IN6_ADDR_HSIZE = 256).

This series presents two approaches. The first two patches are a
minimal, low-risk fix. The last two patches are a more complete but
higher-complexity solution. Both are included so maintainers can
evaluate the trade-off.

Approach A: compile-time CONFIG option (patches 1-2)
----------------------------------------------------

The simplest fix: add CONFIG_INET_ADDR_HASH_BUCKETS and
CONFIG_INET6_ADDR_HASH_BUCKETS (default 256, range 64-16384, EXPERT)
so operators can size the tables at build time.

 - 2 lines of Kconfig + 1 line change each
 - Zero runtime behavior change at default settings
 - Immediately deployable for known workloads
 - Does not help workloads that cannot rebuild their kernel
 - Memory cost scales with the chosen bucket count per netns

Approach B: rhltable conversion (patches 3-4)
---------------------------------------------

Convert IPv4 inet_addr_lst from a fixed hlist to an rhltable (resizable
hash linked table). The rhltable:

 - Maintains O(1) lookup regardless of address count
 - Automatically grows and shrinks as addresses are added/removed
 - Eliminates the fixed IN4_ADDR_HSIZE compile-time limit
 - Uses the rhl (resizable hash list) variant to preserve support for
   duplicate keys -- the same IP can exist on multiple interfaces, and
   the old hlist already allowed this

The rhashtable_params are tuned for this use case:

 - No .hashfn set: with key_len = sizeof(__be32), the default path
   calls jhash2(key, 1, seed), which the compiler fully inlines since
   jhash2 is static inline and the length is a compile-time constant.
   The result is equivalent to jhash_1word().

 - .obj_cmpfn provides a direct __be32 comparison, replacing the
   generic memcmp() call in the default rhashtable_compare(). The
   compiler inlines this to a single cmp instruction in the inner
   lookup loop.

 - .min_size = 32 reduces initial memory vs the old fixed 256-bucket
   hlist (256 x 8 = 2048 bytes per netns). The rhltable starts at
   32 x 8 = 256 bytes for buckets plus ~180 bytes of metadata, so
   ~440 bytes total per netns -- a 4x reduction. Most containers
   only have loopback, so 32 buckets is more than sufficient.

With these settings, objdump confirms that inet_lookup_ifaddr_rcu()
contains zero indirect calls and zero function calls to hashfn or
cmpfn -- everything is inlined by the compiler.

The check_lifetime() work function previously iterated all hash buckets
directly. Since rhltable does not expose bucket iteration, this is
converted to iterate via for_each_netdev + in_dev->ifa_list, which is
the natural way to walk all addresses and avoids coupling the lifetime
logic to the hash table internals.

Benchmarks
----------

Performance was measured using bpftrace kprobe/kretprobe on
__ip_dev_find inside a virtme-ng VM (4 vCPUs, veth pair, network
namespaces, CPU-isolated host). A C benchmark tool sends unconnected
UDP packets in a tight loop, cycling through all source addresses to
exercise the lookup path on every sendto().

__ip_dev_find average latency (bpftrace stats, 5 rounds x 3s):

  Addrs   rhltable (ns)   hlist (ns)   Improvement
  -----   -------------   ----------   -----------
     20           201          200          0%
    100           210          218         +4%
    500           206          234        +12%
    700           218          237         +8%
   1000           214          228         +6%
   2000           231          265        +13%
   5000           247          335        +26%

At low address counts (20) the rhltable matches the hlist. The
custom obj_cmpfn (single cmp vs memcmp) and the compiler-inlined
jhash2 keeps the more advanced hash table as fast as the simple hlist.

At the production use-case of ~700 addresses, the rhltable provides an
8% reduction in __ip_dev_find latency (218 ns vs 237 ns). The
improvement grows with address count, reaching 26% at 5000 addresses
as hlist chains lengthen while rhltable stays flat.

Note: bpftrace kprobe/kretprobe instrumentation adds constant overhead
to each call, so the absolute nanosecond values are inflated. The
relative improvement percentages are the meaningful comparison.

UDP sendmsg throughput (end-to-end, 10 rounds x 3s, unconnected
sendto() cycling all source addresses, iptables DROP on receiver,
virtme-ng VM with CPU isolation, frequency pinned to 1400 MHz):

  Addrs   rhltable (pkt/s)   hlist (pkt/s)   Improvement
  -----   ----------------   -------------   -----------
     20          385,696          389,206        -0.9%
    100          382,188          382,693        -0.1%
    500          378,509          366,216        +3.4%
    700          375,295          361,877        +3.7%
   1000          365,848          356,039        +2.8%
   2000          345,092          333,232        +3.6%
   5000          324,478          303,649        +6.9%
  10000          330,775          268,786       +23.1%

The absolute throughput is low because CPUs are deliberately
down-clocked for measurement stability (CV < 2%). The relative
improvement percentages are the meaningful comparison.

At the production use-case of ~700 addresses, rhltable provides a
+3.7% throughput improvement, growing to +23% at 10,000 addresses as
hlist O(N/256) chain walks dominate.

Summary
-------

Patches 1-2 (CONFIG option) are trivial, safe, and solve the immediate
problem for operators who can rebuild their kernel. Patches 3-4
(rhltable) are a better long-term solution that works automatically for
all workloads, at the cost of more complex code and a harder review.

If the rhltable approach is acceptable, patches 1-2 become unnecessary
(the rhltable supersedes the fixed hash table entirely). They are
included here to give maintainers the choice.

Future work: a similar rhltable conversion for IPv6 inet6_addr_lst.

Cc: Ivan Babrou <ivan@cloudflare.com>
Cc: kernel-team@cloudflare.com

Jesper Dangaard Brouer (4):
  ipv4: make inet_addr_lst hash table size configurable
  ipv6: make inet6_addr_lst hash table size configurable
  ipv4: convert inet_addr_lst to rhltable for dynamic resizing
  selftests: net: add IPv4 address lookup stress test

 include/linux/inetdevice.h                    |   3 +-
 include/net/ip.h                              |   5 -
 include/net/netns/ipv4.h                      |   4 +-
 net/ipv4/devinet.c                            | 149 ++--
 net/ipv6/Kconfig                              |  15 +
 net/ipv6/addrconf.c                           |   2 +-
 tools/testing/selftests/net/Makefile          |   3 +
 .../selftests/net/ipv4_addr_lookup_test.sh    | 804 ++++++++++++++++++
 .../net/ipv4_addr_lookup_test_virtme.sh       | 282 ++++++
 .../selftests/net/ipv4_addr_lookup_trace.bt   | 178 ++++
 .../net/ipv4_addr_lookup_udp_sender.c         | 401 +++++++++
 11 files changed, 1772 insertions(+), 74 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipv4_addr_lookup_test.sh
 create mode 100755 tools/testing/selftests/net/ipv4_addr_lookup_test_virtme.sh
 create mode 100644 tools/testing/selftests/net/ipv4_addr_lookup_trace.bt
 create mode 100644 tools/testing/selftests/net/ipv4_addr_lookup_udp_sender.c

-- 
2.43.0


