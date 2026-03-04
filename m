Return-Path: <netdev+bounces-263774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEYFHRwbqGmgnwAAu9opvQ
	(envelope-from <netdev+bounces-263774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:44:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC40B1FF330
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3CF3170A5D
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FCC384229;
	Wed,  4 Mar 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qNgg+bVU"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240634C816
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624323; cv=none; b=jcpzho3KIe7MdRX1YURgXRPeg6Du98JccG4IfIa/OLx3m24tqs2l5h7AzGaYlIiFkVapMlMWfWGlg62LxlJZu2mf9OXVy6+c5GNWpxf+iDMqpyROeOUGUsckuwftC7BEtCWjsjaax5HW/l4NDHjLYuVBCjnaTSemF4EtjroFtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624323; c=relaxed/simple;
	bh=rUT9cR2Ko8p7ZIZ4MUQh2PV20SEVeYcPcy7XxkSKjSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rva0A9jkyamcvvGnDtck9PUwWwo7fDnmhG36uhxjLjElqP4t1WHNckwogAlqYxkY7r/Jo2aZ035ULDEgeCdotsUEf8dpOxjfaC19lv66BeouUe1rP7sX5fojXiQS0Rl1TqJ6SYUNoDIlgT9QhyQok2qhoPkgvZNSb+aJHu6ww+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qNgg+bVU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772624310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=44UvKC/EWu1AwyKkiiwYyLzDteEcHJW5LNHwrUD3EQQ=;
	b=qNgg+bVUyK+cGIZu+/4KYswGT4B6WHOVl33EX8q4nRyM4Vrm27MOkD5om6doht8ByBmxQr
	KpzrmJK2qlxGwt/rsjA7XkbAiaXod6zDZf6jL8OIzfGM0TK9Tk8Nps9XPUTi5OHiIe/Cxw
	gpKpxcXSuCXuswO0hiYmN6BBcFHj/dM=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v4 0/2] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop and add selftest
Date: Wed,  4 Mar 2026 19:38:12 +0800
Message-ID: <20260304113817.294966-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CC40B1FF330
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263774-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,nvidia.com:email]
X-Rspamd-Action: no action

syzbot reported a kernel panic [1] when an IPv4 route references
a loopback IPv6 nexthop object:

BUG: unable to handle page fault for address: ffff8d069e7aa000
PF: supervisor read access in kernel mode
PF: error_code(0x0000) - not-present page
PGD 6aa01067 P4D 6aa01067 PUD 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 2 UID: 0 PID: 530 Comm: ping Not tainted 6.19.0+ #193 PREEMPT
RIP: 0010:ip_route_output_key_hash_rcu+0x578/0x9e0
RSP: 0018:ffffd2ffc1573918 EFLAGS: 00010286
RAX: ffff8d069e7aa000 RBX: ffffd2ffc1573988 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffd2ffc1573978 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d060d496000
R13: 0000000000000000 R14: ffff8d060399a600 R15: ffff8d06019a6ab8
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8d069e7aa000 CR3: 0000000106eb0001 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ip_route_output_key_hash+0x86/0x1a0
 __ip4_datagram_connect+0x2b5/0x4e0
 udp_connect+0x2c/0x60
 inet_dgram_connect+0x88/0xd0
 __sys_connect_file+0x56/0x90
 __sys_connect+0xa8/0xe0
 __x64_sys_connect+0x18/0x30
 x64_sys_call+0xfb9/0x26e0
 do_syscall_64+0xd3/0x1510
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Reproduction:

    ip -6 nexthop add id 100 dev lo
    ip route add 172.20.20.0/24 nhid 100
    ping -c1 172.20.20.1     # kernel crash

Problem Description

When a standalone IPv6 nexthop object is created with a loopback device,
fib6_nh_init() misclassifies it as a reject route. Nexthop objects have
no destination prefix (fc_dst=::), so fib6_is_reject() always matches
any loopback nexthop. The reject path skips fib_nh_common_init(), leaving
nhc_pcpu_rth_output unallocated. When an IPv4 route later references
this nexthop and triggers a route lookup, __mkroute_output() calls
raw_cpu_ptr(nhc->nhc_pcpu_rth_output) on a NULL pointer, causing a page
fault.

The reject classification was designed for regular IPv6 routes to prevent
kernel routing loops, but nexthop objects should not be subject to this
check since they carry no destination information. Loop prevention is
handled separately when the route itself is created.

Solution

Patch 1: Fix the kernel panic.
Patch 2: Add a selftest reproducing the crash scenario.

Changes since v3:
https://lore.kernel.org/netdev/20260303031318.339716-1-jiayuan.chen@linux.dev/
- Fix error reference in commit message and change code annotation
  (Suggested by Ido Schimmel <idosch@nvidia.com>)

Changes since v2:
https://lore.kernel.org/netdev/20260302051132.66314-1-jiayuan.chen@linux.dev/
- Simplify the reject check in fib6_nh_init() to only match RTF_REJECT
  instead of using fib6_is_reject(), since the loopback promotion
  heuristic is handled separately by ip6_route_info_create()
  (Suggested by Ido Schimmel <idosch@nvidia.com>)

[1] https://syzkaller.appspot.com/bug?extid=334190e097a98a1b81bb

Jiayuan Chen (2):
  net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop
  selftests: net: add test for IPv4 route with loopback IPv6 nexthop

 net/ipv6/route.c                            |  8 +++-----
 tools/testing/selftests/net/fib_nexthops.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.43.0


