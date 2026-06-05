Return-Path: <netdev+bounces-295766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ykEfKfOgImrNbAEAu9opvQ
	(envelope-from <netdev+bounces-295766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:12:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8E647336
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 12:12:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rosa.ru header.s=mail header.b=aHQaTMjJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295766-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295766-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=rosa.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AF5D301D018
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F33F44E4;
	Fri,  5 Jun 2026 10:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928283F1AA1;
	Fri,  5 Jun 2026 10:11:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654292; cv=none; b=ZQKJIc8KpPw4GPprNui44BPHIne8Yi6lVsTy1dQ6M00Bthf8rqE822aCUOUsU0IlcrD/hMHhHtuMwGodvbF/QhDZiofJaOxdk9/cNExYoFF+P3ie5MPONe0/Woo5szCL9U3Ad2PaEzDxx+ngpyqiPow7Nu8sSo6Hu0rxJDSiyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654292; c=relaxed/simple;
	bh=kYTFxZTNhTxOeblLkPCzG75HnjLsmHVo1Hax14QTLVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f4AwMy026clfXTKKTjsyoByozC7lWahK+ynTTYRunAsYFn8FupsvKcEh8Sx5u59Oso96aclB0R0PzFymvnx1h2cxGEht4IhCXg4L1azMmeYUOpbKbh8YRbkZk8m/XWpWpdIk72HE/PMeIlyzK2Rb8yGECovmD1BA1+mze1mwQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=aHQaTMjJ; arc=none smtp.client-ip=178.154.239.83
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bd0b:0:640:38a2:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 26104C0703;
	Fri, 05 Jun 2026 13:11:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp) with ESMTPSA id DBfH9QHdMa60-bOhYyqVP;
	Fri, 05 Jun 2026 13:11:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1780654277; bh=VDmXEm+9yqLjSK0iZYj1FLfuR5L7ZeC46zEHgd4ElMA=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=aHQaTMjJmMjnAbOHJJuuTG0F9N2rZk0eXr1Yp5w5py4ceFnY6MnEe8TZCZ7M8oFIq
	 6ljlLkKIBPjHW0RYfZyllCVgeEeEg8VfLMQDKG6OXZLU0Q/inXx9aO3PtzwsuMbi4z
	 pnvTp8J21FxOnYvZxfgAhAiz1CQj//QPbCzeJu3c=
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: davem@davemloft.net
Cc: m.lobanov@rosa.ru,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mail@david-bauer.net,
	jchapman@katalix.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net-next v10] l2tp: fix double dst_release() on sk_dst_cache race
Date: Fri,  5 Jun 2026 13:11:12 +0300
Message-Id: <20260605101112.12241-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rosa.ru,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[rosa.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[rosa.ru:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:m.lobanov@rosa.ru,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:mail@david-bauer.net,m:jchapman@katalix.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[m.lobanov@rosa.ru,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295766-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.lobanov@rosa.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,rosa.ru:mid,rosa.ru:dkim,rosa.ru:from_mime,rosa.ru:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FD8E647336

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
========================               ===========================
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
Changes in v10:
 - l2tp_xmit_ipv4(): hold a real dst reference for the skb
   (skb_dst_set() instead of skb_dst_set_noref(), taking dst_hold()
   before donating the route to the socket dst cache) so the cached
   dst cannot be freed during the ip_queue_xmit() handoff, and the
   sk_dst_check() reference taken on the cache-hit path is not leaked.
   This matches what udp_sendmsg() does. Reported by the netdev AI
   reviewer on v9.
 - l2tp_xmit_ipv6(): return PTR_ERR(dst) instead of NET_XMIT_DROP on
   route lookup failure, so the l2tp_xmit_queue() wrapper maps it to
   NET_XMIT_DROP and l2tp_xmit_skb() accounts it as a tx error rather
   than a tx success.
 - Fix the variable declaration order (reverse christmas tree) in
   l2tp_xmit_ipv4() and l2tp_xmit_queue(). Per Paolo Abeni's review.

v9: https://lore.kernel.org/netdev/3564485c-0969-40bf-8f18-c9eb36c4065e@redhat.com/T/#t

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

 net/l2tp/l2tp_core.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 157fc23ce4e1..44a4add220ea 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1204,19 +1204,119 @@ static int l2tp_build_l2tpv3_header(struct l2tp_session *session, void *buf)
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
+		return PTR_ERR(dst);
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
+	struct ip_options_rcu *inet_opt;
+	struct net *net = sock_net(sk);
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
+		/* Take a reference for the skb before donating the route
+		 * reference to the socket dst cache, so the dst stays valid
+		 * across the ip_queue_xmit() handoff (mirrors udp_sendmsg()).
+		 */
+		dst_hold(&rt->dst);
+		sk_setup_caps(sk, &rt->dst);
+	}
+
+	skb_dst_set(skb, &rt->dst);
+	rcu_read_unlock();
+
+	err = ip_queue_xmit(sk, skb, fl);
+	return err;
+}
+
 /* Queue the packet to IP for output: tunnel socket lock must be held */
 static int l2tp_xmit_queue(struct l2tp_tunnel *tunnel, struct sk_buff *skb, struct flowi *fl)
 {
+	struct sock *sk = tunnel->sock;
 	int err;
 
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

