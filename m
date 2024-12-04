Return-Path: <netdev+bounces-149155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5F9E47B1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A091C1677FB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED1171CD;
	Wed,  4 Dec 2024 22:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830D2194147
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350689; cv=none; b=JFtN8f45aE7Cp49irWVr2OzX42xo7f1E1ebp9Xb25eU6GSftbwjxS9iBzd8cwN1aTPGpYMs97pv1NUTqHUaiZbmxihxlf5jW/TGlGhBfQdMHBrlBQSq8cfWrrR6n6MM76e1jWNih9Bc/u57OP0WrXC8zHJfHh8IvDlP6y5Y3gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350689; c=relaxed/simple;
	bh=YY29xeXp56HbEYceo0sl5uzYii7GWYSG+AG6TbXtDC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm6AXCtHubckyVoKUZn3RXWgIToL9ZATK9bLNZqxK3/JFKh0i7MSrYM8CvYxhHm6HEjQaSwWOa8HIcXmXaB7WBdr2AX3uzUg/uhyCLds2eEdrEI+q0AXTXpn2EPkr/SKPKYic53hBnCbouqO+uMcIrQnMvqdUu9pXribjbXWxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 284AA5A0621; Wed, 04 Dec 2024 23:12:54 +0100 (CET)
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mike Manning <mvrmanning@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Holzinger <pholzing@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Subject: [PATCH net-next 2/2] datagram, udp: Set local address and rehash socket atomically against lookup
Date: Wed,  4 Dec 2024 23:12:54 +0100
Message-ID: <20241204221254.3537932-3-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221254.3537932-1-sbrivio@redhat.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a UDP socket changes its local address while it's receiving
datagrams, as a result of connect(), there is a period during which
a lookup operation might fail to find it, after the address is changed
but before the secondary hash (port and address) and the four-tuple
hash (local and remote ports and addresses) are updated.

Secondary hash chains were introduced by commit 30fff9231fad ("udp:
bind() optimisation") and, as a result, a rehash operation became
needed to make a bound socket reachable again after a connect().

This operation was introduced by commit 719f835853a9 ("udp: add
rehash on connect()") which isn't however a complete fix: the
socket will be found once the rehashing completes, but not while
it's pending.

This is noticeable with a socat(1) server in UDP4-LISTEN mode, and a
client sending datagrams to it. After the server receives the first
datagram (cf. _xioopen_ipdgram_listen()), it issues a connect() to
the address of the sender, in order to set up a directed flow.

Now, if the client, running on a different CPU thread, happens to
send a (subsequent) datagram while the server's socket changes its
address, but is not rehashed yet, this will result in a failed
lookup and a port unreachable error delivered to the client, as
apparent from the following reproducer:

  LEN=$(($(cat /proc/sys/net/core/wmem_default) / 4))
  dd if=/dev/urandom bs=1 count=${LEN} of=tmp.in

  while :; do
  	taskset -c 1 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
  	sleep 0.1 || sleep 1
  	taskset -c 2 socat OPEN:tmp.in UDP4:localhost:1337,shut-null
  	wait
  done

where the client will eventually get ECONNREFUSED on a write()
(typically the second or third one of a given iteration):

  2024/11/13 21:28:23 socat[46901] E write(6, 0x556db2e3c000, 8192): Connection refused

This issue was first observed as a seldom failure in Podman's tests
checking UDP functionality while using pasta(1) to connect the
container's network namespace, which leads us to a reproducer with
the lookup error resulting in an ICMP packet on a tap device:

  LOCAL_ADDR="$(ip -j -4 addr show|jq -rM '.[] | .addr_info[0] | select(.scope == "global").local')"

  while :; do
  	./pasta --config-net -p pasta.pcap -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc &
  	sleep 0.2 || sleep 1
  	socat OPEN:tmp.in UDP4:${LOCAL_ADDR}:1337,shut-null
  	wait
  	cmp tmp.in tmp.out
  done

Once this fails:

  tmp.in tmp.out differ: char 8193, line 29

we can finally have a look at what's going on:

  $ tshark -r pasta.pcap
      1   0.000000           :: ? ff02::16     ICMPv6 110 Multicast Listener Report Message v2
      2   0.168690 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
      3   0.168767 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
      4   0.168806 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
      5   0.168827 c6:47:05:8d:dc:04 ? Broadcast    ARP 42 Who has 88.198.0.161? Tell 88.198.0.164
      6   0.168851 9a:55:9a:55:9a:55 ? c6:47:05:8d:dc:04 ARP 42 88.198.0.161 is at 9a:55:9a:55:9a:55
      7   0.168875 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
      8   0.168896 88.198.0.164 ? 88.198.0.161 ICMP 590 Destination unreachable (Port unreachable)
      9   0.168926 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
     10   0.168959 88.198.0.161 ? 88.198.0.164 UDP 8234 60260 ? 1337 Len=8192
     11   0.168989 88.198.0.161 ? 88.198.0.164 UDP 4138 60260 ? 1337 Len=4096
     12   0.169010 88.198.0.161 ? 88.198.0.164 UDP 42 60260 ? 1337 Len=0

On the third datagram received, the network namespace of the container
initiates an ARP lookup to deliver the ICMP message.

In another variant of this reproducer, starting the client with:

  strace -f pasta --config-net -u 1337 socat UDP4-LISTEN:1337,null-eof OPEN:tmp.out,create,trunc 2>strace.log &

and connecting to the socat server using a loopback address:

  socat OPEN:tmp.in UDP4:localhost:1337,shut-null

we can more clearly observe a sendmmsg() call failing after the
first datagram is delivered:

  [pid 278012] connect(173, 0x7fff96c95fc0, 16) = 0
  [...]
  [pid 278012] recvmmsg(173, 0x7fff96c96020, 1024, MSG_DONTWAIT, NULL) = -1 EAGAIN (Resource temporarily unavailable)
  [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = 1
  [...]
  [pid 278012] sendmmsg(173, 0x561c5ad0a720, 1, MSG_NOSIGNAL) = -1 ECONNREFUSED (Connection refused)

and, somewhat confusingly, after a connect() on the same socket
succeeded.

To fix this, replace the rehash operation by a set_rcv_saddr()
callback holding the spinlock on the primary hash chain, just like
the rehash operation used to do, but also setting the address (via
inet_update_saddr(), moved to headers) while holding the spinlock.

To make this atomic against the lookup operation, also acquire the
spinlock on the primary chain there.

This results in some awkwardness at a caller site, specifically
sock_bindtoindex_locked(), where we really just need to rehash the
socket without changing its address. With the new operation, we now
need to forcibly set the current address again.

On the other hand, this appears more elegant than alternatives such
as fetching the spinlock reference in ip4_datagram_connect() and
ip6_datagram_conect(), and keeping the rehash operation around for
a single user also seems a tad overkill.

v1:
  - fix build with CONFIG_IPV6=n: add ifdef around sk_v6_rcv_saddr
    usage (Kuniyuki Iwashima)
  - directly use sk_rcv_saddr for IPv4 receive addresses instead of
    fetching inet_rcv_saddr (Kuniyuki Iwashima)
  - move inet_update_saddr() to inet_hashtables.h and use that
    to set IPv4/IPv6 addresses as suitable (Kuniyuki Iwashima)
  - rebase onto net-next, update commit message accordingly

Reported-by: Ed Santiago <santiago@redhat.com>
Link: https://github.com/containers/podman/issues/24147
Analysed-by: David Gibson <david@gibson.dropbear.id.au>
Fixes: 30fff9231fad ("udp: bind() optimisation")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 include/net/inet_hashtables.h | 13 ++++++
 include/net/sock.h            |  2 +-
 include/net/udp.h             |  3 +-
 net/core/sock.c               | 12 ++++-
 net/ipv4/datagram.c           |  7 +--
 net/ipv4/inet_hashtables.c    | 13 ------
 net/ipv4/udp.c                | 84 +++++++++++++++++++++++------------
 net/ipv4/udp_impl.h           |  2 +-
 net/ipv4/udplite.c            |  2 +-
 net/ipv6/datagram.c           | 30 +++++++++----
 net/ipv6/udp.c                | 31 +++++++------
 net/ipv6/udp_impl.h           |  2 +-
 net/ipv6/udplite.c            |  2 +-
 13 files changed, 130 insertions(+), 73 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a4..7f05e7ebc2e4 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -525,6 +525,19 @@ static inline void sk_rcv_saddr_set(struct sock *sk, __be32 addr)
 #endif
 }
 
+static inline void inet_update_saddr(struct sock *sk, void *saddr, int family)
+{
+	if (family == AF_INET) {
+		inet_sk(sk)->inet_saddr = *(__be32 *)saddr;
+		sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
+	}
+#if IS_ENABLED(CONFIG_IPV6)
+	else {
+		sk->sk_v6_rcv_saddr = *(struct in6_addr *)saddr;
+	}
+#endif
+}
+
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			struct sock *sk, u64 port_offset,
 			int (*check_established)(struct inet_timewait_death_row *,
diff --git a/include/net/sock.h b/include/net/sock.h
index 7464e9f9f47c..1410036e4f5a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1228,6 +1228,7 @@ struct proto {
 	int			(*connect)(struct sock *sk,
 					struct sockaddr *uaddr,
 					int addr_len);
+	void			(*set_rcv_saddr)(struct sock *sk, void *addr);
 	int			(*disconnect)(struct sock *sk, int flags);
 
 	struct sock *		(*accept)(struct sock *sk,
@@ -1269,7 +1270,6 @@ struct proto {
 	/* Keeping track of sk's, looking them up, and port selection methods. */
 	int			(*hash)(struct sock *sk);
 	void			(*unhash)(struct sock *sk);
-	void			(*rehash)(struct sock *sk);
 	int			(*get_port)(struct sock *sk, unsigned short snum);
 	void			(*put_port)(struct sock *sk);
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/include/net/udp.h b/include/net/udp.h
index 6e89520e100d..8283ea5768de 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -302,7 +302,6 @@ static inline int udp_lib_hash(struct sock *sk)
 }
 
 void udp_lib_unhash(struct sock *sk);
-void udp_lib_rehash(struct sock *sk, u16 new_hash, u16 new_hash4);
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport);
 
@@ -411,6 +410,8 @@ int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
 int udp_init_sock(struct sock *sk);
 int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
+void udp_lib_set_rcv_saddr(struct sock *sk, void *addr, u16 hash, u16 hash4);
+int udp_set_rcv_saddr(struct sock *sk, void *addr);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
 __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait);
diff --git a/net/core/sock.c b/net/core/sock.c
index 74729d20cd00..221c904d870d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -641,8 +641,16 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
 	/* Paired with all READ_ONCE() done locklessly. */
 	WRITE_ONCE(sk->sk_bound_dev_if, ifindex);
 
-	if (sk->sk_prot->rehash)
-		sk->sk_prot->rehash(sk);
+	/* Force rehash if protocol needs it */
+	if (sk->sk_prot->set_rcv_saddr) {
+		if (sk->sk_family == AF_INET)
+			sk->sk_prot->set_rcv_saddr(sk, &sk->sk_rcv_saddr);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (sk->sk_family == AF_INET6)
+			sk->sk_prot->set_rcv_saddr(sk, &sk->sk_v6_rcv_saddr);
+#endif
+	}
+
 	sk_dst_reset(sk);
 
 	ret = 0;
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index d52333e921f3..3ea3fa94c127 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -64,9 +64,10 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	if (!inet->inet_saddr)
 		inet->inet_saddr = fl4->saddr;	/* Update source address */
 	if (!inet->inet_rcv_saddr) {
-		inet->inet_rcv_saddr = fl4->saddr;
-		if (sk->sk_prot->rehash && sk->sk_family == AF_INET)
-			sk->sk_prot->rehash(sk);
+		if (sk->sk_prot->set_rcv_saddr && sk->sk_family == AF_INET)
+			sk->sk_prot->set_rcv_saddr(sk, &fl4->saddr);
+		else
+			inet->inet_rcv_saddr = fl4->saddr;
 	}
 	inet->inet_daddr = fl4->daddr;
 	inet->inet_dport = usin->sin_port;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9bfcfd016e18..74e6a3604bcf 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -874,19 +874,6 @@ inet_bhash2_addr_any_hashbucket(const struct sock *sk, const struct net *net, in
 	return &hinfo->bhash2[hash & (hinfo->bhash_size - 1)];
 }
 
-static void inet_update_saddr(struct sock *sk, void *saddr, int family)
-{
-	if (family == AF_INET) {
-		inet_sk(sk)->inet_saddr = *(__be32 *)saddr;
-		sk_rcv_saddr_set(sk, inet_sk(sk)->inet_saddr);
-	}
-#if IS_ENABLED(CONFIG_IPV6)
-	else {
-		sk->sk_v6_rcv_saddr = *(struct in6_addr *)saddr;
-	}
-#endif
-}
-
 static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family, bool reset)
 {
 	struct inet_hashinfo *hinfo = tcp_or_dccp_get_hashinfo(sk);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6a01905d379f..8490408f6009 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -639,18 +639,21 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 		int sdif, struct udp_table *udptable, struct sk_buff *skb)
 {
 	unsigned short hnum = ntohs(dport);
-	struct udp_hslot *hslot2;
+	struct udp_hslot *hslot, *hslot2;
 	struct sock *result, *sk;
 	unsigned int hash2;
 
+	hslot = udp_hashslot(udptable, net, hnum);
+	spin_lock_bh(&hslot->lock);
+
 	hash2 = ipv4_portaddr_hash(net, daddr, hnum);
 	hslot2 = udp_hashslot2(udptable, hash2);
 
 	if (udp_has_hash4(hslot2)) {
 		result = udp4_lib_lookup4(net, saddr, sport, daddr, hnum,
 					  dif, sdif, udptable);
-		if (result) /* udp4_lib_lookup4 return sk or NULL */
-			return result;
+		if (result) /* udp4_lib_lookup4() returns sk or NULL */
+			goto done;
 	}
 
 	/* Lookup connected or non-wildcard socket */
@@ -684,6 +687,8 @@ struct sock *__udp4_lib_lookup(const struct net *net, __be32 saddr,
 				  htonl(INADDR_ANY), hnum, dif, sdif,
 				  hslot2, skb);
 done:
+	spin_unlock_bh(&hslot->lock);
+
 	if (IS_ERR(result))
 		return NULL;
 	return result;
@@ -2118,10 +2123,12 @@ int __udp_disconnect(struct sock *sk, int flags)
 	sock_rps_reset_rxhash(sk);
 	sk->sk_bound_dev_if = 0;
 	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK)) {
+		if (sk->sk_prot->set_rcv_saddr &&
+		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
+			sk->sk_prot->set_rcv_saddr(sk, &(__be32){ 0 });
+		}
+
 		inet_reset_saddr(sk);
-		if (sk->sk_prot->rehash &&
-		    (sk->sk_userlocks & SOCK_BINDPORT_LOCK))
-			sk->sk_prot->rehash(sk);
 	}
 
 	if (!(sk->sk_userlocks & SOCK_BINDPORT_LOCK)) {
@@ -2172,25 +2179,37 @@ void udp_lib_unhash(struct sock *sk)
 }
 EXPORT_SYMBOL(udp_lib_unhash);
 
-/*
- * inet_rcv_saddr was changed, we must rehash secondary hash
+/**
+ * udp_lib_set_rcv_saddr() - Set local address and rehash socket atomically
+ * @sk:		Socket changing local address
+ * @addr:	New address, __be32 * or struct in6_addr * depending on family
+ * @hash:	New secondary hash (local port and address) for socket
+ * @hash4:	New 4-tuple hash (local/remote port and address) for socket
+ *
+ * Set local address for socket and rehash it while holding a spinlock on the
+ * primary hash chain (port only). This needs to be atomic to avoid that a
+ * concurrent lookup misses a socket while it's being connected or disconnected.
  */
-void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
+void udp_lib_set_rcv_saddr(struct sock *sk, void *addr, u16 hash, u16 hash4)
 {
+	struct udp_hslot *hslot;
+
 	if (sk_hashed(sk)) {
 		struct udp_table *udptable = udp_get_table_prot(sk);
-		struct udp_hslot *hslot, *hslot2, *nhslot2;
+		struct udp_hslot *hslot2, *nhslot2;
 
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
-		nhslot2 = udp_hashslot2(udptable, newhash);
-		udp_sk(sk)->udp_portaddr_hash = newhash;
+		nhslot2 = udp_hashslot2(udptable, hash);
+
+		hslot = udp_hashslot(udptable, sock_net(sk),
+				     udp_sk(sk)->udp_port_hash);
+
+		spin_lock_bh(&hslot->lock);
+
+		udp_sk(sk)->udp_portaddr_hash = hash;
 
 		if (hslot2 != nhslot2 ||
 		    rcu_access_pointer(sk->sk_reuseport_cb)) {
-			hslot = udp_hashslot(udptable, sock_net(sk),
-					     udp_sk(sk)->udp_port_hash);
-			/* we must lock primary chain too */
-			spin_lock_bh(&hslot->lock);
 			if (rcu_access_pointer(sk->sk_reuseport_cb))
 				reuseport_detach_sock(sk);
 
@@ -2208,7 +2227,7 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 			}
 
 			if (udp_hashed4(sk)) {
-				udp_rehash4(udptable, sk, newhash4);
+				udp_rehash4(udptable, sk, hash4);
 
 				if (hslot2 != nhslot2) {
 					spin_lock(&hslot2->lock);
@@ -2220,23 +2239,32 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 					spin_unlock(&nhslot2->lock);
 				}
 			}
-			spin_unlock_bh(&hslot->lock);
 		}
 	}
+
+	inet_update_saddr(sk, addr, sk->sk_family);
+
+	if (sk_hashed(sk))
+		spin_unlock_bh(&hslot->lock);
 }
-EXPORT_SYMBOL(udp_lib_rehash);
+EXPORT_SYMBOL(udp_lib_set_rcv_saddr);
 
-void udp_v4_rehash(struct sock *sk)
+/**
+ * udp_v4_set_rcv_saddr() - Set local address and new hash for IPv4 socket
+ * @sk:		Socket changing local address
+ * @addr:	New address, pointer to __be32 representation
+ */
+void udp_v4_set_rcv_saddr(struct sock *sk, void *addr)
 {
-	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
-					  inet_sk(sk)->inet_rcv_saddr,
-					  inet_sk(sk)->inet_num);
-	u16 new_hash4 = udp_ehashfn(sock_net(sk),
-				    sk->sk_rcv_saddr, sk->sk_num,
-				    sk->sk_daddr, sk->sk_dport);
+	u16 hash = ipv4_portaddr_hash(sock_net(sk),
+				      *(__be32 *)addr, inet_sk(sk)->inet_num);
+	u16 hash4 = udp_ehashfn(sock_net(sk),
+				*(__be32 *)addr, sk->sk_num,
+				sk->sk_daddr, sk->sk_dport);
 
-	udp_lib_rehash(sk, new_hash, new_hash4);
+	udp_lib_set_rcv_saddr(sk, addr, hash, hash4);
 }
+EXPORT_SYMBOL(udp_v4_set_rcv_saddr);
 
 static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
@@ -3129,6 +3157,7 @@ struct proto udp_prot = {
 	.close			= udp_lib_close,
 	.pre_connect		= udp_pre_connect,
 	.connect		= udp_connect,
+	.set_rcv_saddr		= udp_v4_set_rcv_saddr,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udp_init_sock,
@@ -3141,7 +3170,6 @@ struct proto udp_prot = {
 	.release_cb		= ip4_datagram_release_cb,
 	.hash			= udp_lib_hash,
 	.unhash			= udp_lib_unhash,
-	.rehash			= udp_v4_rehash,
 	.get_port		= udp_v4_get_port,
 	.put_port		= udp_lib_unhash,
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index e1ff3a375996..1c5ad903c064 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -10,7 +10,7 @@ int __udp4_lib_rcv(struct sk_buff *, struct udp_table *, int);
 int __udp4_lib_err(struct sk_buff *, u32, struct udp_table *);
 
 int udp_v4_get_port(struct sock *sk, unsigned short snum);
-void udp_v4_rehash(struct sock *sk);
+void udp_v4_set_rcv_saddr(struct sock *sk, void *addr);
 
 int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen);
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index af37af3ab727..4a5c2e080120 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -57,7 +57,7 @@ struct proto 	udplite_prot = {
 	.recvmsg	   = udp_recvmsg,
 	.hash		   = udp_lib_hash,
 	.unhash		   = udp_lib_unhash,
-	.rehash		   = udp_v4_rehash,
+	.set_rcv_saddr	   = udp_v4_set_rcv_saddr,
 	.get_port	   = udp_v4_get_port,
 
 	.memory_allocated  = &udp_memory_allocated,
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 5c28a11128c7..ec659bc97c04 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -104,10 +104,19 @@ int ip6_datagram_dst_update(struct sock *sk, bool fix_sk_saddr)
 			np->saddr = fl6.saddr;
 
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr)) {
-			sk->sk_v6_rcv_saddr = fl6.saddr;
-			inet->inet_rcv_saddr = LOOPBACK4_IPV6;
-			if (sk->sk_prot->rehash)
-				sk->sk_prot->rehash(sk);
+			__be32 v4addr = LOOPBACK4_IPV6;
+
+			if (sk->sk_prot->set_rcv_saddr &&
+			    sk->sk_family == AF_INET)
+				sk->sk_prot->set_rcv_saddr(sk, &v4addr);
+			else
+				inet->inet_rcv_saddr = v4addr;
+
+			if (sk->sk_prot->set_rcv_saddr &&
+			    sk->sk_family == AF_INET6)
+				sk->sk_prot->set_rcv_saddr(sk, &fl6.saddr);
+			else
+				sk->sk_v6_rcv_saddr = fl6.saddr;
 		}
 	}
 
@@ -209,10 +218,15 @@ int __ip6_datagram_connect(struct sock *sk, struct sockaddr *uaddr,
 
 		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr) ||
 		    ipv6_mapped_addr_any(&sk->sk_v6_rcv_saddr)) {
-			ipv6_addr_set_v4mapped(inet->inet_rcv_saddr,
-					       &sk->sk_v6_rcv_saddr);
-			if (sk->sk_prot->rehash && sk->sk_family == AF_INET6)
-				sk->sk_prot->rehash(sk);
+			struct in6_addr v4mapped;
+
+			ipv6_addr_set_v4mapped(inet->inet_rcv_saddr, &v4mapped);
+
+			if (sk->sk_prot->set_rcv_saddr &&
+			    sk->sk_family == AF_INET6)
+				sk->sk_prot->set_rcv_saddr(sk, &v4mapped);
+			else
+				sk->sk_v6_rcv_saddr = v4mapped;
 		}
 
 		goto out;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d766fd798ecf..6f7b13c53941 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -105,25 +105,30 @@ int udp_v6_get_port(struct sock *sk, unsigned short snum)
 	return udp_lib_get_port(sk, snum, hash2_nulladdr);
 }
 
-void udp_v6_rehash(struct sock *sk)
+/**
+ * udp_v6_set_rcv_saddr() - Set local address and new hashes for IPv6 socket
+ * @sk:		Socket changing local address
+ * @addr:	New address, pointer to struct in6_addr
+ */
+void udp_v6_set_rcv_saddr(struct sock *sk, void *addr)
 {
-	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
-					  &sk->sk_v6_rcv_saddr,
-					  inet_sk(sk)->inet_num);
-	u16 new_hash4;
+	u16 hash = ipv6_portaddr_hash(sock_net(sk),
+				      addr, inet_sk(sk)->inet_num);
+	u16 hash4;
 
 	if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)) {
-		new_hash4 = udp_ehashfn(sock_net(sk),
-					sk->sk_rcv_saddr, sk->sk_num,
-					sk->sk_daddr, sk->sk_dport);
+		hash4 = udp_ehashfn(sock_net(sk),
+				    sk->sk_rcv_saddr, sk->sk_num,
+				    sk->sk_daddr, sk->sk_dport);
 	} else {
-		new_hash4 = udp6_ehashfn(sock_net(sk),
-					 &sk->sk_v6_rcv_saddr, sk->sk_num,
-					 &sk->sk_v6_daddr, sk->sk_dport);
+		hash4 = udp6_ehashfn(sock_net(sk),
+				     addr, sk->sk_num,
+				     &sk->sk_v6_daddr, sk->sk_dport);
 	}
 
-	udp_lib_rehash(sk, new_hash, new_hash4);
+	udp_lib_set_rcv_saddr(sk, addr, hash, hash4);
 }
+EXPORT_SYMBOL(udp_v6_set_rcv_saddr);
 
 static int compute_score(struct sock *sk, const struct net *net,
 			 const struct in6_addr *saddr, __be16 sport,
@@ -1860,6 +1865,7 @@ struct proto udpv6_prot = {
 	.close			= udp_lib_close,
 	.pre_connect		= udpv6_pre_connect,
 	.connect		= udpv6_connect,
+	.set_rcv_saddr		= udp_v6_set_rcv_saddr,
 	.disconnect		= udp_disconnect,
 	.ioctl			= udp_ioctl,
 	.init			= udpv6_init_sock,
@@ -1872,7 +1878,6 @@ struct proto udpv6_prot = {
 	.release_cb		= ip6_datagram_release_cb,
 	.hash			= udp_lib_hash,
 	.unhash			= udp_lib_unhash,
-	.rehash			= udp_v6_rehash,
 	.get_port		= udp_v6_get_port,
 	.put_port		= udp_lib_unhash,
 #ifdef CONFIG_BPF_SYSCALL
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
index 0590f566379d..45166e56ef12 100644
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -14,7 +14,7 @@ int __udp6_lib_err(struct sk_buff *, struct inet6_skb_parm *, u8, u8, int,
 
 int udpv6_init_sock(struct sock *sk);
 int udp_v6_get_port(struct sock *sk, unsigned short snum);
-void udp_v6_rehash(struct sock *sk);
+void udp_v6_set_rcv_saddr(struct sock *sk, void *addr);
 
 int udpv6_getsockopt(struct sock *sk, int level, int optname,
 		     char __user *optval, int __user *optlen);
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index a60bec9b14f1..597ca4558b3f 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -56,7 +56,7 @@ struct proto udplitev6_prot = {
 	.recvmsg	   = udpv6_recvmsg,
 	.hash		   = udp_lib_hash,
 	.unhash		   = udp_lib_unhash,
-	.rehash		   = udp_v6_rehash,
+	.set_rcv_saddr	   = udp_v6_set_rcv_saddr,
 	.get_port	   = udp_v6_get_port,
 
 	.memory_allocated  = &udp_memory_allocated,
-- 
2.40.1


