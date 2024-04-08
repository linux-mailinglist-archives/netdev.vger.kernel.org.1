Return-Path: <netdev+bounces-85818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4789C6DA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68333282070
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4A130A7E;
	Mon,  8 Apr 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSNLsPYb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3312F59E
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585957; cv=none; b=CsDXKf/LFc45DNmMQkfjmkeu4MjfBDJmDTAlpXLuQmoSbn+9YLTyqrMrHN3sHbujlct6XhwuE9CWAr119DoZ3RLbA6BvzeewPmyDFqJI7X94q1gyVVb84mISQzhGSOUEs03VrwfzIu/pXhT1uJUF0gSAncPa6v/DdNqoHTKDilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585957; c=relaxed/simple;
	bh=AyY4sXoWKXCAq2ypVzfMT92yMhCCCQ1YCXyZxrxinrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtGG42V+hHChxYIP1KbtXSzmZO6ApwXznJyhRL76UpCsw8CESuDxGAivHP/RjuNOgNwx7VkBSabaL61mscIPlbkPuJrlSG1XM4CbOz8SquBINtxSaV42Izdn2tC3GnIxonm7H2KBCiAyB8YpgvQbWFVdQWP04xcBI5LZ+pdyIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSNLsPYb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712585954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=crY1kOvr7+Z4GrRUP9SUyIgPsOUhnmFdIpxnc2Mc78E=;
	b=FSNLsPYbIOsJnwU9mBefkuPBoE//1RMLeIjnuorbHMCI7OACALA+vbosU0kZempknU0gR6
	gWV9zs3XDn7egb8L2P2QzegwFYXgqWFOob/SNeilwAvNzwZ3qSB7ngV4dfdonwLmzvIC0c
	sDT++dHAvyDzmDlJ6em9M3QkG1cEhCE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-QObao2EEP6KouTIOgFrIUg-1; Mon,
 08 Apr 2024 10:19:10 -0400
X-MC-Unique: QObao2EEP6KouTIOgFrIUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22F9C1C2CBF3;
	Mon,  8 Apr 2024 14:19:10 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.45.224.251])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5584840B4979;
	Mon,  8 Apr 2024 14:19:09 +0000 (UTC)
From: Jiri Benc <jbenc@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net v2] ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr
Date: Mon,  8 Apr 2024 16:18:21 +0200
Message-ID: <8ab821e36073a4a406c50ec83c9e8dc586c539e4.1712585809.git.jbenc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Although ipv6_get_ifaddr walks inet6_addr_lst under the RCU lock, it
still means hlist_for_each_entry_rcu can return an item that got removed
from the list. The memory itself of such item is not freed thanks to RCU
but nothing guarantees the actual content of the memory is sane.

In particular, the reference count can be zero. This can happen if
ipv6_del_addr is called in parallel. ipv6_del_addr removes the entry
from inet6_addr_lst (hlist_del_init_rcu(&ifp->addr_lst)) and drops all
references (__in6_ifa_put(ifp) + in6_ifa_put(ifp)). With bad enough
timing, this can happen:

1. In ipv6_get_ifaddr, hlist_for_each_entry_rcu returns an entry.

2. Then, the whole ipv6_del_addr is executed for the given entry. The
   reference count drops to zero and kfree_rcu is scheduled.

3. ipv6_get_ifaddr continues and tries to increments the reference count
   (in6_ifa_hold).

4. The rcu is unlocked and the entry is freed.

5. The freed entry is returned.

Prevent increasing of the reference count in such case. The name
in6_ifa_hold_safe is chosen to mimic the existing fib6_info_hold_safe.

[   41.506330] refcount_t: addition on 0; use-after-free.
[   41.506760] WARNING: CPU: 0 PID: 595 at lib/refcount.c:25 refcount_warn_saturate+0xa5/0x130
[   41.507413] Modules linked in: veth bridge stp llc
[   41.507821] CPU: 0 PID: 595 Comm: python3 Not tainted 6.9.0-rc2.main-00208-g49563be82afa #14
[   41.508479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[   41.509163] RIP: 0010:refcount_warn_saturate+0xa5/0x130
[   41.509586] Code: ad ff 90 0f 0b 90 90 c3 cc cc cc cc 80 3d c0 30 ad 01 00 75 a0 c6 05 b7 30 ad 01 01 90 48 c7 c7 38 cc 7a 8c e8 cc 18 ad ff 90 <0f> 0b 90 90 c3 cc cc cc cc 80 3d 98 30 ad 01 00 0f 85 75 ff ff ff
[   41.510956] RSP: 0018:ffffbda3c026baf0 EFLAGS: 00010282
[   41.511368] RAX: 0000000000000000 RBX: ffff9e9c46914800 RCX: 0000000000000000
[   41.511910] RDX: ffff9e9c7ec29c00 RSI: ffff9e9c7ec1c900 RDI: ffff9e9c7ec1c900
[   41.512445] RBP: ffff9e9c43660c9c R08: 0000000000009ffb R09: 00000000ffffdfff
[   41.512998] R10: 00000000ffffdfff R11: ffffffff8ca58a40 R12: ffff9e9c4339a000
[   41.513534] R13: 0000000000000001 R14: ffff9e9c438a0000 R15: ffffbda3c026bb48
[   41.514086] FS:  00007fbc4cda1740(0000) GS:ffff9e9c7ec00000(0000) knlGS:0000000000000000
[   41.514726] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   41.515176] CR2: 000056233b337d88 CR3: 000000000376e006 CR4: 0000000000370ef0
[   41.515713] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   41.516252] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   41.516799] Call Trace:
[   41.517037]  <TASK>
[   41.517249]  ? __warn+0x7b/0x120
[   41.517535]  ? refcount_warn_saturate+0xa5/0x130
[   41.517923]  ? report_bug+0x164/0x190
[   41.518240]  ? handle_bug+0x3d/0x70
[   41.518541]  ? exc_invalid_op+0x17/0x70
[   41.520972]  ? asm_exc_invalid_op+0x1a/0x20
[   41.521325]  ? refcount_warn_saturate+0xa5/0x130
[   41.521708]  ipv6_get_ifaddr+0xda/0xe0
[   41.522035]  inet6_rtm_getaddr+0x342/0x3f0
[   41.522376]  ? __pfx_inet6_rtm_getaddr+0x10/0x10
[   41.522758]  rtnetlink_rcv_msg+0x334/0x3d0
[   41.523102]  ? netlink_unicast+0x30f/0x390
[   41.523445]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[   41.523832]  netlink_rcv_skb+0x53/0x100
[   41.524157]  netlink_unicast+0x23b/0x390
[   41.524484]  netlink_sendmsg+0x1f2/0x440
[   41.524826]  __sys_sendto+0x1d8/0x1f0
[   41.525145]  __x64_sys_sendto+0x1f/0x30
[   41.525467]  do_syscall_64+0xa5/0x1b0
[   41.525794]  entry_SYSCALL_64_after_hwframe+0x72/0x7a
[   41.526213] RIP: 0033:0x7fbc4cfcea9a
[   41.526528] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[   41.527942] RSP: 002b:00007ffcf54012a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   41.528593] RAX: ffffffffffffffda RBX: 00007ffcf5401368 RCX: 00007fbc4cfcea9a
[   41.529173] RDX: 000000000000002c RSI: 00007fbc4b9d9bd0 RDI: 0000000000000005
[   41.529786] RBP: 00007fbc4bafb040 R08: 00007ffcf54013e0 R09: 000000000000000c
[   41.530375] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   41.530977] R13: ffffffffc4653600 R14: 0000000000000001 R15: 00007fbc4ca85d1b
[   41.531573]  </TASK>

Fixes: 5c578aedcb21d ("IPv6: convert addrconf hash list to RCU")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 include/net/addrconf.h | 4 ++++
 net/ipv6/addrconf.c    | 7 ++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9d06eb945509..62a407db1bf5 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -438,6 +438,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
 	refcount_inc(&ifp->refcnt);
 }
 
+static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
+{
+	return refcount_inc_not_zero(&ifp->refcnt);
+}
 
 /*
  *	compute link-local solicited-node multicast address
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 92db9b474f2b..779aa6ecdd49 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2091,9 +2091,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
 		if (ipv6_addr_equal(&ifp->addr, addr)) {
 			if (!dev || ifp->idev->dev == dev ||
 			    !(ifp->scope&(IFA_LINK|IFA_HOST) || strict)) {
-				result = ifp;
-				in6_ifa_hold(ifp);
-				break;
+				if (in6_ifa_hold_safe(ifp)) {
+					result = ifp;
+					break;
+				}
 			}
 		}
 	}
-- 
2.42.0


