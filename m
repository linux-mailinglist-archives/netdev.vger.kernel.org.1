Return-Path: <netdev+bounces-245657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83ACD45C3
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B7330057CC
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD1722A80D;
	Sun, 21 Dec 2025 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJfDTE03"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527A18FC97
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766352013; cv=none; b=KFHFyZBdtFQRR3pXg88yN/I/dASZHAU7d/cxccgCXRUd1DKnr8YKSRCAm9EVTk1CVgFmcbBRih4fvIgHRkPMlqIcbA0UWjIPn7C/57RJbphZchCGLMf0BhqOiuS5W18mTgaUgv+xT/+w7bMYdz1Doz/U643C9UPupEiuRpWoArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766352013; c=relaxed/simple;
	bh=ToN0mwBvRMKJjixu88EeWpeLkyLu4Th+qCvWhW4tXiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pc6FRX3/2OgmkaqJCzUzrzrLsoLoayr9R6AASSceI5/jzqrWWjk/1E1wH3skOz/xFRITskdJSKxFy1xZvsFLogHWyMjpw8u0jr3vVY97DRWCuW9bHfhYQ6sB4P+Y6y67oW+DHSuJH6I1soZleiuWzI7ACgb8xCu1enODvCVzqBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJfDTE03; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fed090e5fso1565092f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 13:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766352010; x=1766956810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2sPp2GL3CwtUQ1PbT3n9dvuG1WSaqFU2rILxqXbj4s=;
        b=LJfDTE03QPJldGsQ/p+PIkR1V8Eowqx9eHEYRh6gti4Elccx4kag06ijKfKkHtJBWm
         IHhCwNe9dDDeyPLtXL/d138lC5Q8WhAyqiVfnX2uv3obHJwuIfHajnlMBUbIUbvBAcog
         hwU73Or8qnuMbKimMTU1r1cjE21Gsjs+SBW3orCUBsjSzmE6e7765rSL4VcvKxC+bswv
         naE9oSyEKHsk5GFso1CV8Mu+zTYg5EZqy7ImIymcgRWogALMI8LV+BocM+d0ZQimIHgw
         Zk5Yaz7E6JgsnRSRdHEwJrgqXcaywC1z72/2nX9lc4EVNqeit6Je2CuII7iwhzYkQ1+W
         Ar/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766352010; x=1766956810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2sPp2GL3CwtUQ1PbT3n9dvuG1WSaqFU2rILxqXbj4s=;
        b=GoRyEWdzOAHy76BsZky9hbsZmqIn3lbtgkkphqveSO+xTQqS60k9Cpq65wya3XqngM
         R+6eeDAka0BuaaBb0z2KvYk0swEOeHw4P3mlJs5WtJHMWna3imYNoFXlbKOv+dAFu17R
         5HC2gnMaj//siZlGK2Q1M78zPBWlRwTPp1JSnT/3DKFEOHNv9Km9+u4arr5NpMV/X/BF
         LM/oYmZJcfwQpxa6RansgQ7vF8JYSSw/nNVcMRVK/w79CTQHI7RvTRCmEEGhm5Tqq4Xg
         j9kVnAzUB/D+ZKDV4KLODY5OzdEs9pdiwcp7aWoPjb6a1yQfKpvAn2bNnt6tFqLno/49
         1fSQ==
X-Gm-Message-State: AOJu0YyrCAtYzOfOT99FcZfRj+lZrDO016PViIYrUK8CjZjf88r9BS8c
	BEfJC4DldJrPVueOx/gDFzbFug1Fi6agdwLPOdoVWYHqWHKjtXvKKn1b
X-Gm-Gg: AY/fxX5IJbgj4rXhb93WXH5X/nxsbOSXOgdBXhjwHY8/V7pq3f3vOixwraw+dbB6OP5
	VFoNZCWVomFSPLqYYp65XWjx2cpp8SCQj7F21kbg6m1+ABVlWaq/6U8St0ZkZZsFdyDO0JVC+vO
	FnWQaMyYRPMREBeds5bs5olAS+6navpNAZiLHeo9tZpFrcbx1xk6iukj+LcWxlCTEXXKXr4hDf/
	QpOHYE6Jw+y7da1mcpWtQ2MEIgDvWVBhG9FsvPzYOo8x0UDHeWsmBZIrLS0noaW7hUuw8A3bW2f
	7GChimuDzYb0Y10cXIroBZliUZuS+9uYI1q668bkr+SDP9ozdF5cNQZAH1Wx2hmroUDqLz4OZwz
	24/tmPCcu0pH/6E1mmT9HzMYtkHMI8BH34sR2Pv5kp5gjEB+gYh4kO+4Gk9bI+ZQZyDci9DWHjP
	TcOEoFrvn/+T6tBE+i9KPSkbCPNEMTToWBjErIZqjyITFH1mNsokPVLXDB36PZox+pdKBlvr6MW
	lWGrarwKw==
X-Google-Smtp-Source: AGHT+IFeZXw5FuWd49CN5YU7wHbOxV9EbGWQ4OCzoinDu6+LUfsqKhqMrb6wKSTrgABzyCfpRklSQA==
X-Received: by 2002:a5d:5f47:0:b0:430:ff81:2958 with SMTP id ffacd0b85a97d-4324e701267mr11147515f8f.57.1766352010082;
        Sun, 21 Dec 2025 13:20:10 -0800 (PST)
Received: from localhost.localdomain (105.red-79-153-133.dynamicip.rima-tde.net. [79.153.133.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm18254455f8f.39.2025.12.21.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 13:20:09 -0800 (PST)
From: =?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	dborkman@kernel.org,
	=?UTF-8?q?Marc=20Su=C3=B1=C3=A9?= <marcdevel@gmail.com>
Subject: [PATCH RFC net 0/5] net: discard ARP/NDP bcast/null announce (poison)
Date: Sun, 21 Dec 2025 22:19:33 +0100
Message-ID: <cover.1766349632.git.marcdevel@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current ARP and NDP implementations accepts announcements with
broadcast (mcast, and null) MAC addresses as Sender HW Address
(SHA) in ARP or src/target lladdr in NDP, and updates the cache
for that neighbour.

Broadcast (and Multicast, see RFC1812, section 3.3.2) and null
MAC addresses are reserved addresses and shall never be associated
with a unicast or a multicast IPv4/6 address.

ARP/NDP poisioning with a broadcast MAC address, especially when
poisoning a Gateway IP, has some undesired implications compared to
an ARP/NDP poisioning with a regular MAC. See Note1.

Worth mentioning that if an attacker is able to ARP/NDP poison in
a L2 segment, that in itself is probably a bigger security threat
(Man-in-middle etc.). See Note2.

However, since these MACs should never be announced, this patch
series discards/drops these packets, which prevents broadcast
ARP/NDP poisoning vectors.

Comments:

a) This patchset only modifies the behaviour of the neighbouring
   subsystem when processing network packets. Static entries can still
   be added with bcast/null MACs.

b) According to RFC1812 multicast MAC addresses should also be
   rejected:

   > A router MUST not believe any ARP reply that claims that the Link
   > Layer address of another host or router is a broadcast or multicast
   > address.

   Certain Load Balancers make use of Multicast MAC addresses:

   https://support.huawei.com/enterprise/en/doc/EDOC1100213154/d8621162/dynamic-learning-of-arp-entries-with-multicast-mac-addresses
   https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-network-to-support-nlb-operation-mode

   But as stated in the Microsoft NLB documentation, it is expected that
   static entries are be created for it to work:

   > To support this configuration, you must configure the network
   > infrastructure to use static ARP entries and MAC address table
   > entries. Network switches cannot learn the NLB multicast MAC address
   > in the course of their usual operations. If you skip the manual
   > configuration step, the network switches may flood NLB traffic to
   > all ports or drop packets. The network may seem to function
   > correctly at first, but problems increase over time.

   So I think it's safe to change `is_broadcast_ether_addr()` to
   `is_multicast_ether_addr()` in patches 1 and 3. Alternatively, a
   per-interface knob to control whether MCAST MAC addresses are learnt,
   with the default to NOT accept them, could be an option.

c) Scapy: not clear whether acceptable in selftests (used somewhere but
   not consistently). It is convenient for pkt generation. Patch 5
   should be either dropped or squashed (replacing C progs) in patches
   2 and 4.

d) In PATCH 1/5 (ARP), I _think_ it's safe to assume that all dev_types
   with HW addrlen 6 are MAC addresses, but it would need to be double
   checked by reviewers.

(Notes extracted from the ARP commit. NDP similar. MCAST MACs exhibit
a similar behaviour - depends on the exact MCAST MAC.)

Note1:

After a successful broadcast ARP poisioning attack:

1. Unicast packets and refresh ("targeted") ARPs sent to or via
the poisioned IP (e.g. the default GW) are flooded by
bridges/switches. That is in absence of other security controls.

Hardware swiches generally have rate-limits to prevent/mitigate
broadcast storms, since ARPs are usually answered by the CPU.
Legit unicast packets could be dropped (perf. degradation).

Most modern NICs implement some form of L2 MAC filtering to early
discard irrelevant packets. In contrast to an ARP poisoning
attack with any other MAC, both unicast and ARP ("targeted")
refresh packets are passed up to the Kernel networking stack
(for all hosts in the L2 segment).

2. A single forged ARP packet (e.g. for the Gateway IP) can produce
up to N "targeted" (to broadcast) ARPs, where N is the number of
hosts in the L2 segment that have an ARP entry for that IP
(e.g. GW), and some more traffic, since the real host will answer
to targeted refresh ARPs with their (real) reply.

This is a relatively low amount of traffic compared to 1).

3. An attacker could use this form of ARP poisoning to discover
all hosts in a L2 segment in a very short period of time with
one or few packets.

By poisoning e.g. the default GW (likely multiple times, to
avoid races with real gARPs from the GW), all hosts will eventually
issue refresh "targeted" ARPs for the GW IP with the broadcast MAC
address as destination. These packets will be flooded in the L2
segment, revealing the presence of hosts to the attacker.

For comparison:
 * Passive ARP monitoring: also stealthy, but can take a long
   time or not be possible at all in switches, as most refresh
   ARPs are targeted.
 * ARP req flooding: requires swiping the entire subnet. Noisy
   and easy to detect.
 * ICMP/L4 port scans: similar to the above.

4. In the unlikely case that hosts were to run with
`/proc/sys/net/ipv4/conf/*/arp_accept=1` (unsafe, and disabled
by default), poisoning with the broadcast MAC could be used to
create significantly more broadcast traffic (low-volume
amplification attack).

An attacker could send M fake gARP with a number of IP addresses,
where M is `/proc/sys/net/ipv4/neigh/*/gc_thresh3` (1024 by
default). This would result in M x R ARPs, where R is the number
of hosts in L2 segment with `arp_accept=1`, and likely other
(real) ARP replies coming from the attacked host. This starts to
get really relevant when R > 512, which is possible in large LANs
but not very common.

Note2:

However, broadcast ARP poisoning might be subtle and difficult to
spot. These ARP packets appear on the surface as regular broadcast
ARP requests (unless ARP hdr is inspected), traffic continues to
flow uninterrupted (unless broadcast rate-limit in switches kick-in)
and, the next refresh ARP reply (from the GW) or any (valid) gARP
from the GW, will restore the original MAC in the ARP table, making
the traffic flow normally again.

Marc Suñé (5):
  arp: discard sha bcast/null (bcast ARP poison)
  selftests/net: add no ARP bcast/null poison test
  neigh: discard lladdr bcast/null (bcast poison)
  selftests/net: add no NDP bcast/null poison test
  selftests/net: use scapy for no_bcastnull_poison

 net/ipv4/arp.c                                |   9 +
 net/ipv6/ndisc.c                              |  22 ++
 tools/testing/selftests/net/.gitignore        |   2 +
 tools/testing/selftests/net/Makefile          |   1 +
 .../net/arp_ndisc_no_bcastnull_poison.sh      | 334 ++++++++++++++++++
 tools/testing/selftests/net/arp_send.py       |  24 ++
 tools/testing/selftests/net/ndisc_send.py     |  36 ++
 7 files changed, 428 insertions(+)
 create mode 100755 tools/testing/selftests/net/arp_ndisc_no_bcastnull_poison.sh
 create mode 100644 tools/testing/selftests/net/arp_send.py
 create mode 100644 tools/testing/selftests/net/ndisc_send.py

-- 
2.47.3


