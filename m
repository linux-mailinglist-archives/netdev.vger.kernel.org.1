Return-Path: <netdev+bounces-241598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88CC86537
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B1273531AB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28232ABFF;
	Tue, 25 Nov 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="gs5/7kV9"
X-Original-To: netdev@vger.kernel.org
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724132ABC8;
	Tue, 25 Nov 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092899; cv=none; b=LlAr8dmjugCuLG1LIXfRciuBVYnIAd+hggy0DO9C7VjfF9Fw6J9il7gLfLQUlZ3CaxajVVwTyBzxe/IR+TlH8mkbJ4hlbRDDVUmot5scY8+IxLyR98+ADht7P5YX3mxqdcbQtLQGpCI110znKwxuV9ICfIgIePxOzZ48MiYiik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092899; c=relaxed/simple;
	bh=MRIq57IRKx/1HPytX+ssMg4otSRFXnrSH8LkQyw3JjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EY8m78FCyHkRkjtaUyXxPKPl5hmMlvaQX/IfrQfeotVPwkxF7JvrIJQvij1FA1ULxDmXbFgEOZgDzNPetOU1YrBHJJAroVU0e2Sho/u7/PoTSWE1BrYxttaLldjLsDarOTDTj4uP4nFtOanOOVo9MDKY+yryLxMvla6AcMiTFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=gs5/7kV9; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 0131886DC0;
	Tue, 25 Nov 2025 20:42:46 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:270c:0:640:c38e:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 775E1C00A8;
	Tue, 25 Nov 2025 20:42:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XggujTkLOGk0-Gv1KCdnO;
	Tue, 25 Nov 2025 20:42:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1764092555; bh=o4o2XDA5nrOQmDLxiRc+aANwxnB8EPeJ00/Ueu4aUxY=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gs5/7kV9kD7dLgoP5XXJnyOpbocu0OwbXry26lubWQeDECl0o5gSd1D5Q7fjS++m9
	 jBggVSHWEQQxMLnc1e92PUZma1kDJdhfuPIqtxUYxqVtzmYNXpYzRvdPFQQx5Tam7M
	 1GWaWC4dXA7tDSL6ZKbPu23xYoK7P6qKR/dzVkjk=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
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
Subject: [PATCH net-next v4] l2tp: fix double dst_release() on sk_dst_cache race
Date: Fri, 14 Nov 2025 06:24:08 +0300
Message-ID: <20251114032414.524965-1-m.lobanov@rosa.ru>
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

Make L2TP’s IPv6 transmit path stop using inet6_csk_xmit()
(and thus __sk_dst_check()) and instead open-code the same
routing and transmit sequence using ip6_sk_dst_lookup_flow()
and ip6_xmit(). The new code builds a flowi6 from the socket
fields in the same way as inet6_csk_route_socket(), then calls
ip6_sk_dst_lookup_flow(), which internally relies on the lockless
sk_dst_check()/sk_dst_reset() pattern shared with UDPv6, and
attaches the resulting dst to the skb before invoking ip6_xmit().
This makes both the UDPv6 and L2TP IPv6 paths use the same
dst-cache handling logic for a given socket and removes the
possibility that sk_dst_check() and __sk_dst_check() concurrently
drop the same cached dst and trigger the rcuref - imbalanced put()
warning under concurrent traffic.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

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
v4: switch L2TP IPv6 xmit to open-coded (using sk_dst_check()) 
and test with tools/testing/selftests/net/l2tp.sh.
https://lore.kernel.org/netdev/a601c049-0926-418b-aa54-31686eea0a78@redhat.com/T/#t

 net/l2tp/l2tp_core.c | 48 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0710281dd95a..72a43cbd4569 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1206,15 +1206,55 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
 static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, struct flowi *fl)
 {
 	int err;
+	struct sock *sk = tunnel->sock;
 
 	skb->ignore_df = 1;
 	skb_dst_drop(skb);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (l2tp_sk_is_v6(tunnel->sock))
-		err = inet6_csk_xmit(tunnel->sock, skb, NULL);
-	else
+	if (l2tp_sk_is_v6(sk)) {
+		struct ipv6_pinfo *np = inet6_sk(sk);
+		struct inet_sock *inet = inet_sk(sk);
+		struct flowi6 fl6;
+		struct dst_entry *dst;
+		struct in6_addr *final_p, final;
+		struct ipv6_txoptions *opt;
+
+		memset(&fl6, 0, sizeof(fl6));
+		fl6.flowi6_proto = sk->sk_protocol;
+		fl6.daddr        = sk->sk_v6_daddr;
+		fl6.saddr        = np->saddr;
+		fl6.flowlabel    = np->flow_label;
+		IP6_ECN_flow_xmit(sk, fl6.flowlabel);
+
+		fl6.flowi6_oif   = sk->sk_bound_dev_if;
+		fl6.flowi6_mark  = sk->sk_mark;
+		fl6.fl6_sport    = inet->inet_sport;
+		fl6.fl6_dport    = inet->inet_dport;
+		fl6.flowi6_uid   = sk->sk_uid;
+
+		security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
+
+		rcu_read_lock();
+		opt = rcu_dereference(np->opt);
+		final_p = fl6_update_dst(&fl6, opt, &final);
+
+		dst = ip6_sk_dst_lookup_flow(sk, &fl6, final_p, true);
+		if (IS_ERR(dst)) {
+			rcu_read_unlock();
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+
+		skb_dst_set(skb, dst);
+		fl6.daddr = sk->sk_v6_daddr;
+
+		err = ip6_xmit(sk, skb, &fl6, sk->sk_mark,
+			       opt, np->tclass,
+			       READ_ONCE(sk->sk_priority));
+		rcu_read_unlock();
+	} else
 #endif
-		err = ip_queue_xmit(tunnel->sock, skb, fl);
+		err = ip_queue_xmit(sk, skb, fl);
 
 	return err >= 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
 }
-- 
2.47.2


