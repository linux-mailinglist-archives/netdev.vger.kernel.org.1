Return-Path: <netdev+bounces-241068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BDC7E5D4
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EE4B346B11
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 18:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049882DE71C;
	Sun, 23 Nov 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="fpD21DuL"
X-Original-To: netdev@vger.kernel.org
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B69F2D47E8;
	Sun, 23 Nov 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923503; cv=none; b=ZR8ObC8dthTyp14fTklyhTQlm0mCX5bXrOu/GJj5c3K+UCCj5xfZ5D0qqD2cbGcWRCBWLgkUCw8NtwqoUawXQf/QZkyNwYkHgE8HMsjUDOq2LNg69VVlp5DVCTVY7S/S9wiE2ScSf127UUQr14JxagQCAHS4VgwsrPv7Kdjt9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923503; c=relaxed/simple;
	bh=Qw6SRMwCYTDUM5jTvX+4vdEgLsMPPN6AalTGL5B2RV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E3V99AVRuTI3HYvv+2nn7rbu31iOO78m52HaeztVQP5FdLwpjoHafkd4BAvo1xhfXJqiw3srm0pwwGVCY5hxjYYR6jViwlV1dgV/S+Leske8vC298BUI+ab5kW2/rIRS/JUJCfiHXhyKUHkS0orYt4tc1X87m8Q5EJQptsx4Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=fpD21DuL; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3d48:0:640:52d7:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 12954C0043;
	Sun, 23 Nov 2025 21:44:49 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id kifgd6WLIOs0-xt6qjILt;
	Sun, 23 Nov 2025 21:44:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1763923488; bh=G/QArjWXicOLViqw7olPX1d+z2vm9ls5rdPoNmo76bo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=fpD21DuL5gGd/ytsT82Suwn7GUQMXL0QUuWghk3VABy2oDjt7UaV8sRP+e1x6XIbP
	 wEI+3u5847snFUpYlxcaAfMH0rmDrI61nic18YDP42Hds+e9SGr/G1z5WxZ+3wCc8N
	 IrTAvBzq4Eb625RqkeLO4+HdsWGVmNIA+UDbSarA=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Bauer <mail@david-bauer.net>,
	James Chapman <jchapman@katalix.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net v3] l2tp: fix double dst_release() on sk_dst_cache race
Date: Fri, 14 Nov 2025 04:06:42 +0300
Message-ID: <20251114010644.452441-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A reproducible rcuref - imbalanced put() warning is observed under
IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
imbalance in dst reference counting for routes cached in
sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
issue between the helpers that validate and drop cached dst entries.

rcuref - imbalanced put()
WARNING: CPU: 0 PID: 899 at lib/rcuref.c:266 rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.>
Modules linked in:
CPSocket connected tcp:127.0.0.1:48148,server=on <-> 127.0.0.1:33750
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01>
RIP: 0010:rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.c:266

Call Trace:
 <TASK>
 __rcuref_put include/linux/rcuref.h:97 [inline]
 rcuref_put include/linux/rcuref.h:153 [inline]
 dst_release+0x291/0x310 net/core/dst.c:167
 __sk_dst_check+0x2d4/0x350 net/core/sock.c:604
 __inet6_csk_dst_check net/ipv6/inet6_connection_sock.c:76 [inline]
 inet6_csk_route_socket+0x6ed/0x10c0 net/ipv6/inet6_connection_sock.c:104
 inet6_csk_xmit+0x12f/0x740 net/ipv6/inet6_connection_sock.c:121
 l2tp_xmit_queue net/l2tp/l2tp_core.c:1214 [inline]
 l2tp_xmit_core net/l2tp/l2tp_core.c:1309 [inline]
 l2tp_xmit_skb+0x1404/0x1910 net/l2tp/l2tp_core.c:1325
 pppol2tp_sendmsg+0x3ca/0x550 net/l2tp/l2tp_ppp.c:302
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0xab2/0xc70 net/socket.c:2609
 ___sys_sendmsg+0x11d/0x1c0 net/socket.c:2663
 __sys_sendmmsg+0x188/0x450 net/socket.c:2749
 __do_sys_sendmmsg net/socket.c:2778 [inline]
 __se_sys_sendmmsg net/socket.c:2775 [inline]
 __x64_sys_sendmmsg+0x98/0x100 net/socket.c:2775
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe6960ec719
 </TASK>

The race occurs between the lockless UDPv6 transmit path
(udpv6_sendmsg() -> sk_dst_check()) and the locked L2TP/pppol2tp
transmit path (pppol2tp_sendmsg() -> l2tp_xmit_skb() ->
... -> inet6_csk_xmit() → __sk_dst_check()), when both handle
the same obsolete dst from sk->sk_dst_cache: the UDPv6 side takes
an extra reference and atomically steals and releases the cached
dst, while the L2TP side, using a stale cached pointer, still
calls dst_release() on it, and together these updates produce
an extra final dst_release() on that dst, triggering
rcuref - imbalanced put().

The Race Condition:

Initial:
  sk->sk_dst_cache = dst
  ref(dst) = 1   

Thread 1: sk_dst_check()                Thread 2: __sk_dst_check()
------------------------               ----------------------------
sk_dst_get(sk):
  rcu_read_lock()
  dst = rcu_dereference(sk->sk_dst_cache)
  rcuref_get(dst) succeeds
  rcu_read_unlock()
  // ref = 2  

                                            dst = __sk_dst_get(sk)
                                    // reads same dst from sk_dst_cache
                                    // ref still = 2 (no extra get)

[both see dst obsolete & check() == NULL]

sk_dst_reset(sk):
  old = xchg(&sk->sk_dst_cache, NULL)
    // old = dst
  dst_release(old)
    // drop cached ref
    // ref: 2 -> 1 

                                  RCU_INIT_POINTER(sk->sk_dst_cache, NULL)
                                  // cache already NULL after xchg
                                            dst_release(dst)
                                              // ref: 1 -> 0

  dst_release(dst)
  // tries to drop its own ref after final put
  // rcuref_put_slowpath() -> "rcuref - imbalanced put()"

Make the IPv6 L2TP transmit path explicitly pre-validate
the cached dst under the socket lock by reading sk->sk_dst_cache
via __sk_dst_get() and, if dst is obsolete and
dst->ops->check(dst, inet6_sk(tunnel->sock)->dst_cookie) == NULL, drop it
from the cache with sk_dst_reset(tunnel->sock), so that the cache-owned
reference is released exactly once via the xchg-based helper
and later __sk_dst_check() inside inet6_csk_xmit() either
sees a NULL cache or a still-valid dst and no longer races
with the lockless sk_dst_check() to double-release the
same cached dst.

Fixes: b0270e91014d ("ipv4: add a sock pointer to ip_queue_xmit()")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
v2: move fix to L2TP as suggested by Eric Dumazet.
v3: dropped the lockless sk_dst_check() pre-validation
and the extra sk_dst_get() reference; instead, under
the socket lock, mirror __sk_dst_check()’s condition
and invalidate the cached dst via sk_dst_reset(sk) so
the cache-owned ref is released exactly once via the 
xchg-based helper.

 net/l2tp/l2tp_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0710281dd95a..b379b7e6470a 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1210,9 +1210,17 @@ static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, stru
 	skb->ignore_df = 1;
 	skb_dst_drop(skb);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (l2tp_sk_is_v6(tunnel->sock))
+	if (l2tp_sk_is_v6(tunnel->sock)) {
+		struct dst_entry *dst = __sk_dst_get(tunnel->sock);
+
+		if (dst) {
+			if (dst && READ_ONCE(dst->obsolete) &&
+			    dst->ops->check(dst,
+			    inet6_sk(tunnel->sock)->dst_cookie) == NULL)
+				sk_dst_reset(tunnel->sock);
+		}
 		err = inet6_csk_xmit(tunnel->sock, skb, NULL);
-	else
+	} else
 #endif
 		err = ip_queue_xmit(tunnel->sock, skb, fl);
 
-- 
2.47.2


