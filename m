Return-Path: <netdev+bounces-293910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPWbCqT6HWpSgQkAu9opvQ
	(envelope-from <netdev+bounces-293910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33F6258E9
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 23:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 811E83016C4E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B534750D;
	Mon,  1 Jun 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="hBnt9IdT"
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2436F907;
	Mon,  1 Jun 2026 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349600; cv=none; b=Y1sPydQH6TGAvkJ8LTqZ7l0wxyC6o1gey4yFnNjsNE8vfGTVQeQKaKwBZlXIg68g7umbl+UkjEM6HqjRcQ/U5qcGwy1hcm6gyr885+FwuQEFLCPC9MqFM9Czz5VZ34bS06il1lZeGcaKatbv0+3gS9C13OGyQhGw4eQMWZ62JQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349600; c=relaxed/simple;
	bh=exP6hdpfRMVIfFns/tUx/WGW4zGWXRG30FzMIhisLEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtGR1xMr4m4mm1d8QvGpOfWM50OXSSjzCPy1EyPWEqLNpxbNyl7BR4Fzd02owK9PUf431c0hyGK6GNJFT7VUYsn39svfa9qpX2s7KsKQXF776H1s89kw8Rx/TV1e6nUWYARckhAQMEcvJs0xn3enATbAtGbkxFx4KKh9b+I53jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=hBnt9IdT; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1e05:0:640:3290:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id E1FDEC03D3;
	Tue, 02 Jun 2026 00:33:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp) with ESMTPSA id 2XmOVAvgamI0-QLmtv1My;
	Tue, 02 Jun 2026 00:33:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1780349586; bh=1tGmD8ng23AxLryyjEphoLI9mgQPF67SFAD1hIM4a6E=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=hBnt9IdTGho85pYpWsxTWKrXVffg4+HsELVHvHf9U60i8XpWWwdDg2RFpTrmRnyBS
	 q9QT0Dp4P6Uk62g5eTnf4/lcUZ2StLa2wIp1XhCj70nBC/qQQs5JVJDTvonE77d+cF
	 4TQQfrRq/opnwNZGArjswjpyT25ApG4c5Z1H0Qb0=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: "David S . Miller" <davem@davemloft.net>
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
Subject: [PATCH net-next v9] l2tp: fix double dst_release() on sk_dst_cache race
Date: Tue,  2 Jun 2026 00:33:02 +0300
Message-Id: <20260601213302.18761-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
	DMARC_POLICY_ALLOW(-0.50)[rosa.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[rosa.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rosa.ru:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.lobanov@rosa.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rosa.ru:email,rosa.ru:mid,rosa.ru:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC33F6258E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A reproducible rcuref - imbalanced put() warning is observed under
IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
imbalance in dst reference counting for routes cached in
sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
issue between the helpers that validate and drop cached dst entries.

rcuref - imbalanced put()
WARNING: CPU: 0 PID: 899 at lib/rcuref.c:266 rcuref_put_slowpath+0x1ce/0x240 lib/rcuref.c:266
Call Trace:
 <TASK>
 dst_release+0x291/0x310 net/core/dst.c:167
 __sk_dst_check+0x2d4/0x350 net/core/sock.c:604
 __inet6_csk_dst_check net/ipv6/inet6_connection_sock.c:76 [inline]
 inet6_csk_route_socket+0x6ed/0x10c0 net/ipv6/inet6_connection_sock.c:104
 inet6_csk_xmit+0x12f/0x740 net/ipv6/inet6_connection_sock.c:121
 l2tp_xmit_queue net/l2tp/l2tp_core.c:1214 [inline]
 l2tp_xmit_core net/l2tp/l2tp_core.c:1309 [inline]
 l2tp_xmit_skb+0x1404/0x1910 net/l2tp/l2tp_core.c:1325
 pppol2tp_sendmsg+0x3ca/0x550 net/l2tp/l2tp_ppp.c:302
 __sys_sendmmsg+0x188/0x450 net/socket.c:2749
 __x64_sys_sendmmsg+0x98/0x100 net/socket.c:2775
 do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>

The race occurs between the lockless UDPv6 transmit path
(udpv6_sendmsg() -> sk_dst_check()) and the locked L2TP/pppol2tp
transmit path (pppol2tp_sendmsg() -> l2tp_xmit_skb() ->
... -> inet6_csk_xmit() -> __sk_dst_check()), when both handle
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
------------------------               ---------------------------
sk_dst_get(sk):
  rcu_read_lock()
  dst = rcu_dereference(sk->sk_dst_cache)
  rcuref_get(dst) succeeds
  rcu_read_unlock()
  // ref = 2

                                            dst = __sk_dst_check()
                                    // reads same dst from sk->sk_dst_cache
                                    // ref still = 2 (no explicit get)

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

Make L2TP's IPv6 transmit path stop using inet6_csk_xmit()
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

Use a helper to pre-route IPv4 L2TP packets via sk_dst_check()
and ip_route_output_ports(), attach the resulting dst to the
skb, and then hand the skb to ip_queue_xmit(). With skb->dst
already set, __ip_queue_xmit() skips its __sk_dst_check()-based
dst cache handling, so IPv4 L2TP uses the same lockless
sk_dst_check() helper as UDPv4 for a given socket. This avoids
mixed sk_dst_check()/__sk_dst_check() users of sk->sk_dst_cache
and closes the same class of double dst_release() race on IPv4.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b0270e91014d ("ipv4: add a sock pointer to ip_queue_xmit()")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
Changes in v9:
 - Rebase on net-next; no functional change to the fix.
 - The kmemleak reported by CI on v8 is the AEAD transform of an IPsec
   ESP SA, allocated by the XFRM control plane (xfrm_add_sa ->
   __xfrm_init_state -> esp_init_state -> esp_init_aead, comm "ip") and
   freed by the xfrm_state destructor esp_destroy() -> crypto_free_aead().
   This change only rewrites the L2TP data-plane transmit path and never
   allocates, frees, or changes the refcounting of that object, so it is
   not the source of the leak. Not reproducible here (KASAN +
   DEBUG_KMEMLEAK; adding/removing rfc4106(gcm(aes)) ESP SAs in a loop ->
   0 unreferenced objects) nor by Li Xiasong. Detailed analysis in reply
   to the v8 thread.

v8: https://lore.kernel.org/netdev/20251215145537.5085-1-m.lobanov@rosa.ru/

 net/l2tp/l2tp_core.c | 101 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0710281dd95a..342e65db6eb8 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1202,19 +1202,114 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
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
+	__u8 tos;
+	int err;
+
+	rcu_read_lock();
+	inet_opt = rcu_dereference(inet->inet_opt);
+	fl4 = &fl->u.ip4;
+	tos = READ_ONCE(inet->tos);
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
+		if (IS_ERR(rt)) {
+			rcu_read_unlock();
+			IP_INC_STATS(net, IPSTATS_MIB_OUTNOROUTES);
+			kfree_skb_reason(skb, SKB_DROP_REASON_IP_OUTNOROUTES);
+			return -EHOSTUNREACH;
+		}
+
+		sk_setup_caps(sk, &rt->dst);
+	}
+
+	skb_dst_set_noref(skb, &rt->dst);
+	rcu_read_unlock();
+
+	err = ip_queue_xmit(sk, skb, fl);
+	return err;
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
2.43.0

