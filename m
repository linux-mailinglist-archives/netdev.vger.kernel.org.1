Return-Path: <netdev+bounces-237990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5DBC5281F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33DB3BBD40
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028D4333455;
	Wed, 12 Nov 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="Jo17uctE"
X-Original-To: netdev@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D53385A1;
	Wed, 12 Nov 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953940; cv=none; b=FP6FHCncpNKgKT9HD22ei2z4GT0T9uhCQaBeBmCdhL+JJPPXcxKZfva1njBwJ8rZFtN19SrLc9NETe4AlLqyH8g2hRnGmS/x9+vRjQvyQLU2FMm+6UD1N183G7fiXEtCgVw5KALmMDQqeRvEzNw1PdU38SA/Bzmg9L/1S0RrkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953940; c=relaxed/simple;
	bh=2eyWQc0PHxHbSfEFosVIwVUxvbpEC45cpmuWplx7m+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdvDK82vUNFdO0m6S5z4qain0hbYdAnFna760+0OxvROagib3Xi2c+KT+4PKfPXVPMBcyh7pkqcl9tstgxVMxul0M7sF/04DjkhxtPsoG69tQnzfpjVseH2SoQ+SzbTDcFb9ayXKXtpgdzRls5eeIGFg6n2jzLP3mkpv+1BIoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=Jo17uctE; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:582e:0:640:200:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 7E76EC0081;
	Wed, 12 Nov 2025 16:25:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JPPd5Z0LHGk0-D5yWJtsG;
	Wed, 12 Nov 2025 16:25:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762953921; bh=ja4ImBaXqFzFgnOefTZ8D4ovCR7A4+mf1CFqUd1T6z8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Jo17uctEkU0P7vKa81EopsDm1wAzAg+1bt4dTfXPDA5/B86PV0OnMsqExhd6rpql6
	 mCKIifxJ4Ne/wlTnaqHB2U6CgNXjX9PnhLBiFXMIEVzSEiahjXYfFWrJYnFa1xjFNg
	 uW5QjWoZqlJWRatqx+e3gPmiD+T4bllsFodLNiss=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net v2] l2tp: fix double dst_release() on sk_dst_cache race
Date: Wed, 12 Nov 2025 16:25:12 +0300
Message-ID: <20251112132514.17364-1-m.lobanov@rosa.ru>
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

The fix is applied locally in L2TP’s IPv6 transmit path before calling
inet6_csk_xmit(). First, it performs a lockless pre-validation of the
socket route cache via sk_dst_check(), so that any obsolete cached dst
is atomically removed from sk->sk_dst_cache by the lockless helper
(through its xchg() path); this prevents the locked __sk_dst_check()
inside inet6_csk_xmit() from issuing a second dst_release() on the same
cache-owned reference. Second, it takes an additional reference to the
current cached dst with sk_dst_get() and drops it after inet6_csk_xmit()
returns, ensuring the dst lifetime is guarded while L2TP transmits, even
if the cache is concurrently updated. Together these steps eliminate the
double-release race without changing sock-core semantics.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
v2: move fix to L2TP as suggested by Eric Dumazet.

 net/l2tp/l2tp_core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 369a2f2e459c..93dafac9117f 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1210,9 +1210,17 @@ static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, stru
 	skb->ignore_df = 1;
 	skb_dst_drop(skb);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (l2tp_sk_is_v6(tunnel->sock))
+	if (l2tp_sk_is_v6(tunnel->sock)) {
+		struct dst_entry *pre_dst, *hold_dst;
+
+		pre_dst = sk_dst_check(tunnel->sock, 0);
+		if (pre_dst)
+			dst_release(pre_dst);
+		hold_dst = sk_dst_get(tunnel->sock);
 		err = inet6_csk_xmit(tunnel->sock, skb, NULL);
-	else
+		if (hold_dst)
+			dst_release(hold_dst);
+	} else
 #endif
 		err = ip_queue_xmit(tunnel->sock, skb, fl);
 
-- 
2.47.2


