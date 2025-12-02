Return-Path: <netdev+bounces-243287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3738C9C8EC
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A54E345624
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79102C3271;
	Tue,  2 Dec 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="UsDFfGCw"
X-Original-To: netdev@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0429BDBF;
	Tue,  2 Dec 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699171; cv=none; b=RYpnPRBOFHAAtOASFkfbVR7HQPLp4tvWyOKKrU2yg2MxxnK2bofUcMIfsvAUaAkLdDlLz7HlNV06nPgYLFKuvw/GTO9NhTtMKP3qM9Pnjaw4KIr69SkwczJ+Ls8kj4f1iZ2ESXZqLbVqpmwhIkHQI4MNJ3p7Z8Nk8tRQmIoMKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699171; c=relaxed/simple;
	bh=JJ1aQdfQPoubiPmaIj2sSrPZuDPqYSJGAYXt9HxIeBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQeLvEMOSzkqUt68rL4Be9poGnS0CimKVK+juSNdqPIim8zGqIgItm+hsgQmdx5H/RRexYWllRxA7NMBY9qVCih3gpcC2rhcCOnCi2ckldxp2P/b4X8BgjvBtdoPQvVPSq1yaMhXvxDlJuHkL4IYU6cigIy5tBmiuYQZ4ahVAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=UsDFfGCw; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id CC490C5380;
	Tue, 02 Dec 2025 21:06:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3e07:0:640:a874:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 081F880774;
	Tue, 02 Dec 2025 21:06:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id x5ok4W1LrSw0-dzQ4bwjW;
	Tue, 02 Dec 2025 21:06:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1764698761; bh=+DqUuCu/vxDA7g/LhSGs7AwyEqlXkrcHPbZLlq6rB/c=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=UsDFfGCw6g7lzF4Emyu8EyRJPUEKgktd2yzrQ49GJl5LorhTepSb8Pf9rhlxPZjJP
	 giuxmOJV+45PjpRQVW+3QYYulXDy5+iF6+gIl7L+aVP4xVHc7KdLcBaLYq6nFBNV3x
	 IN8LBBEdT5NsldqWt6m5aYdkem7V/vyh1pfikoiA=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
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
Subject: [PATCH net-next v6] l2tp: fix double dst_release() on sk_dst_cache race
Date: Tue,  2 Dec 2025 21:05:43 +0300
Message-ID: <20251202180545.18974-1-m.lobanov@rosa.ru>
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

Replace ip_queue_xmit() in the IPv4 L2TP transmit path with an open-coded
helper that mirrors __ip_queue_xmit() but uses sk_dst_check() on the
socket dst cache instead of __sk_dst_check(). This makes IPv4 L2TP use the
same lockless dst-cache helper as UDPv4 for a given socket, avoiding mixed
sk_dst_check()/__sk_dst_check() users on the same sk->sk_dst_cache and
closing the same class of double dst_release() race on IPv4.

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
v5: use sk_uid(sk) and add READ_ONCE() for sk_mark and
sk_bound_dev_if as suggested by Eric Dumazet.
v6: move IPv6 L2TP xmit into an open-coded helper using
ip6_sk_dst_lookup_flow() and sk_dst_check(), and add an
analogous open-coded IPv4 helper mirroring __ip_queue_xmit()
but using sk_dst_check() so both IPv4 and IPv6 L2TP paths
stop calling __sk_dst_check() and share the UDP-style dst
cache handling.

 net/l2tp/l2tp_core.c | 143 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0710281dd95a..26a255e4bad5 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1202,19 +1202,157 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
 	return bufp - optr;
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
+static int l2tp_xmit_ipv6(struct sock *sk, struct sk_buff *skb)
+{
+	struct ipv6_pinfo *np = inet6_sk(sk);
+	struct inet_sock *inet = inet_sk(sk);
+	struct in6_addr *final_p, final;
+	struct ipv6_txoptions *opt;
+	struct dst_entry *dst;
+	struct flowi6 fl6;
+	int err;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.flowi6_proto = sk->sk_protocol;
+	fl6.daddr        = sk->sk_v6_daddr;
+	fl6.saddr        = np->saddr;
+	fl6.flowlabel    = np->flow_label;
+	IP6_ECN_flow_xmit(sk, fl6.flowlabel);
+
+	fl6.flowi6_oif   = READ_ONCE(sk->sk_bound_dev_if);
+	fl6.flowi6_mark  = READ_ONCE(sk->sk_mark);
+	fl6.fl6_sport    = inet->inet_sport;
+	fl6.fl6_dport    = inet->inet_dport;
+	fl6.flowi6_uid   = sk_uid(sk);
+
+	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
+
+	rcu_read_lock();
+	opt = rcu_dereference(np->opt);
+	final_p = fl6_update_dst(&fl6, opt, &final);
+
+	dst = ip6_sk_dst_lookup_flow(sk, &fl6, final_p, true);
+	if (IS_ERR(dst)) {
+		rcu_read_unlock();
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
+	skb_dst_set(skb, dst);
+	fl6.daddr = sk->sk_v6_daddr;
+
+	err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark),
+		       opt, np->tclass,
+		       READ_ONCE(sk->sk_priority));
+	rcu_read_unlock();
+	return err;
+}
+#endif
+
+static int l2tp_xmit_ipv4(struct sock *sk, struct sk_buff *skb, struct flowi *fl)
+{
+	struct inet_sock *inet = inet_sk(sk);
+	struct net *net = sock_net(sk);
+	struct ip_options_rcu *inet_opt;
+	struct flowi4 *fl4;
+	struct rtable *rt;
+	struct iphdr *iph;
+	__u8 tos;
+	int err;
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	fl4 = &fl->u.ip4;
+	rt = skb_rtable(skb);
+	tos = READ_ONCE(inet->tos);
+
+	if (rt)
+		goto packet_routed;
+
+	rt = dst_rtable(sk_dst_check(sk, 0));
+	if (!rt) {
+		__be32 daddr = inet->inet_daddr;
+
+		if (inet_opt && inet_opt->opt.srr)
+			daddr = inet_opt->opt.faddr;
+
+		rt = ip_route_output_ports(net, fl4, sk,
+					   daddr, inet->inet_saddr,
+					   inet->inet_dport,
+					   inet->inet_sport,
+					   sk->sk_protocol,
+					   tos & INET_DSCP_MASK,
+					   READ_ONCE(sk->sk_bound_dev_if));
+		if (IS_ERR(rt))
+			goto no_route;
+
+		sk_setup_caps(sk, &rt->dst);
+	}
+
+	skb_dst_set_noref(skb, &rt->dst);
+
+packet_routed:
+		if (inet_opt && inet_opt->opt.is_strictroute && rt->rt_uses_gateway)
+			goto no_route;
+
+		skb_push(skb, sizeof(struct iphdr) +
+			 (inet_opt ? inet_opt->opt.optlen : 0));
+		skb_reset_network_header(skb);
+		iph = ip_hdr(skb);
+		*((__be16 *)iph) = htons((4 << 12) | (5 << 8) | (tos & 0xff));
+
+		if (ip_dont_fragment(sk, &rt->dst) && !skb->ignore_df)
+			iph->frag_off = htons(IP_DF);
+		else
+			iph->frag_off = 0;
+
+		int ttl = READ_ONCE(inet->uc_ttl);
+
+		if (ttl < 0)
+			ttl = ip4_dst_hoplimit(&rt->dst);
+
+		iph->ttl      = ttl;
+		iph->protocol = sk->sk_protocol;
+		iph->saddr = fl4->saddr;
+		iph->daddr = fl4->daddr;
+
+		if (inet_opt && inet_opt->opt.optlen) {
+			iph->ihl += inet_opt->opt.optlen >> 2;
+			ip_options_build(skb, &inet_opt->opt, inet->inet_daddr, rt);
+		}
+
+		ip_select_ident_segs(net, skb, sk,
+				     skb_shinfo(skb)->gso_segs ?: 1);
+
+		skb->priority = READ_ONCE(sk->sk_priority);
+		skb->mark     = READ_ONCE(sk->sk_mark);
+
+		err = ip_local_out(net, sk, skb);
+		rcu_read_unlock();
+		return err;
+
+no_route:
+		rcu_read_unlock();
+		IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
+		kfree_skb_reason(skb, SKB_DROP_REASON_IP_OUTNOROUTES);
+		return -EHOSTUNREACH;
+}
+
 /* Queue the packet to IP for output: tunnel socket lock must be held */
 static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, struct flowi *fl)
 {
 	int err;
+	struct sock *sk = tunnel->sock;
 
 	skb->ignore_df = 1;
 	skb_dst_drop(skb);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (l2tp_sk_is_v6(tunnel->sock))
-		err = inet6_csk_xmit(tunnel->sock, skb, NULL);
+	if (l2tp_sk_is_v6(sk))
+		err = l2tp_xmit_ipv6(sk, skb);
 	else
 #endif
-		err = ip_queue_xmit(tunnel->sock, skb, fl);
+		err = l2tp_xmit_ipv4(sk, skb, fl);
 
 	return err >= 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
 }
-- 
2.47.2


