Return-Path: <netdev+bounces-237960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D944C520CF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 12:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E013B534E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0421F3126D9;
	Wed, 12 Nov 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="Y1pyWHhg"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B03126A6;
	Wed, 12 Nov 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947600; cv=none; b=oH9lrUEfIzM8dxWcDIS6lcqzchV4NdbMbgsINP/Btscaz9OLlO+inBZW7jOhwEVuHq+W3/gbkm8aNgRKDv09jJvaqnhEdeeEa/l9tQsf1SHUf6551lENzlt6TCIxzXUiJ/C1OkjA82+95hTDgTFAn1y5WG/9aGA/TWU+nTmTOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947600; c=relaxed/simple;
	bh=ZJBlgVQUds5GbyehGat4CZz2u1xDcxYPkHK+oVc1SLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jsnQI5Eap9yAEm6hiE9l46gSpf77eqPTTDYTAb6KZ9n/8TMve0VUEEASAE0HN9OjrPJpbvV6a1bWycSnYwOpkbwR6PzdMCSu81YChz7Q5jOjDfAv5PcmxbOGjVrIJoIi2I76zbBHAdxG09tZZDdetQPs+bNJ3eLhae4T3NvkM84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=Y1pyWHhg; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5a89:0:640:b4ed:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 54F5F80A01;
	Wed, 12 Nov 2025 14:39:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id gdNvH92LqmI0-1AOLtqeG;
	Wed, 12 Nov 2025 14:39:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762947584; bh=Y3mu0Zw6QST5qSBBo3gTy6QNByaLKy+gd37sFxTRevU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Y1pyWHhgSLhZzpPR+vk8mZ/95k6LYQhXGM9iDjRZ27GGV5gbV3w1JSVwg0Lttd7Fy
	 2ykih7JOhIhIdZtNT4RyCLr6hafvQH7xqoRzl5icHCepx4h66+mBzesJLGQryVeLCX
	 XmHH2/8XMjlepTcz0//bNumUuLAGf6ygk+rYgtrw=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: Eric Dumazet <edumazet@google.com>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] net: fix double dst_release() on sk_dst_cache race
Date: Tue, 11 Nov 2025 19:42:02 +0300
Message-ID: <20251111164205.77229-1-m.lobanov@rosa.ru>
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
WARNING: CPU: 0 PID: 899 at lib/rcuref.c:266 rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.c:266
Modules linked in:
CPSocket connected tcp:127.0.0.1:48148,server=on <-> 127.0.0.1:33750
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
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

Fix this by making the locked __sk_dst_check() use the same “steal
from sk->sk_dst_cache” pattern as the lockless path: instead of
clearing the cache and releasing a potentially stale local dst,
it atomically exchanges sk->sk_dst_cache with NULL and only calls
dst_release() on the pointer returned from that exchange. This
guarantees that, for any given cached dst, at most one of the
competing helpers (sk_dst_check() or __sk_dst_check()) can acquire
and drop the cache-owned reference, so they can no longer
double-release the same entry; the atomic operation runs only in the
obsolete path and should not affect the main path.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
 net/core/sock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b5909a..7f356f976627 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -607,14 +607,15 @@ INDIRECT_CALLABLE_DECLARE(struct dst_entry *ipv4_dst_check(struct dst_entry *,
 struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 {
 	struct dst_entry *dst = __sk_dst_get(sk);
+	struct dst_entry *old_dst;
 
 	if (dst && READ_ONCE(dst->obsolete) &&
 	    INDIRECT_CALL_INET(dst->ops->check, ip6_dst_check, ipv4_dst_check,
 			       dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
 		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
-		dst_release(dst);
+		old_dst = unrcu_pointer(xchg(&sk->sk_dst_cache, RCU_INITIALIZER(NULL)));
+		dst_release(old_dst);
 		return NULL;
 	}
 
-- 
2.47.2


