Return-Path: <netdev+bounces-263018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AVqEf1RpmkbOAAAu9opvQ
	(envelope-from <netdev+bounces-263018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:14:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECC1E85B9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 04:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A6DF300F59E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8C376BE5;
	Tue,  3 Mar 2026 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTSv7btl"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730E36AB53
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507640; cv=none; b=GgD2KGd3G/HoX5/NhRQga9sHUOSoSygt4sGobEAKCti41hXEgi43fEXgP1lraLDs7OAlt5+CeY1qbWT2UVoNW432jxUNl8D2Z336q9tUGlz3SaErSSAuUEbq0G5e5lnZOyX8FbJr8Pn1v+YM0v4CXeJGJf9eoigyLizQZuPhXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507640; c=relaxed/simple;
	bh=K6AlHqnS/7kLdIFnNna34u22cqVsdxLjKhDZOmX1IRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dsh9SnCk/3Qjie9DUceIn2X/xvUDHKAYaGTn2eCA25yMkOcZ/iwh4oPNVFBB2Cjyjzh964YHNDIAwDrzt5QPb6igriBGxGfvDc/oasBgH7WRUxOB8UIZM+cQJPWKAq040ieXsgAz7FL840/vXiAXVtEBAHDkmzwBu3n/NAVyksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTSv7btl; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772507637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D6qexQ4j4clxuPTGBn1CJqco2P+dhoqeOUpk4a5MPl8=;
	b=GTSv7btlK5h+/vJ12pI9d7njPVIQnnv25FLqSae2M4+6pmNky961IYEPZNQdh1Jj1X7c9U
	KF1VzAWHSCEkkaNLBmJiVFXFKNZm/Rm1+L6D8vLxY4EFy6JKgnvbGjDH5/hirqjpb3qdqo
	GtmBLG3+8PtClmYm7GeMD28jidSGYqA=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuna.chen@linux.dev,
	jiayuna.chen@shopee.com,
	idosch@nvidia.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 0/2] net: ipv6: fix panic when IPv4 route references loopback IPv6 nexthop and add selftest
Date: Tue,  3 Mar 2026 11:13:13 +0800
Message-ID: <20260303031318.339716-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D5ECC1E85B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263018-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email,linux.dev:dkim,linux.dev:mid]
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


