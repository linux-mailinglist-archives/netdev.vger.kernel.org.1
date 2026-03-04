Return-Path: <netdev+bounces-264016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH1WG3eIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5A207162
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D44A30340BA
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C53DBD64;
	Wed,  4 Mar 2026 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLQsgUQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902ED3CE4AF
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652646; cv=none; b=Jo6w8mNe5I59ixLTPCEdIeBUVcShWkStQH104w5isnR2nIr17n8ZYEPriwCEGlyqNbWsZLHNB1vZoHMw+5mIFR4RqLey6DstJYKMM+8QP4Y6te6Zfncr84d+dcQpcwUMDdz7RQi36PczpQAD/sjuYPESG4hoV9dM0bAkO70Zr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652646; c=relaxed/simple;
	bh=XR50VQtt/LrKPjTV0XoldgpSsnu+DGaRnKK5Eddhy9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfA6F4y2qcXqBTsvxabgkX7IE94Nz+e4H3IJg0uIqXp5l8tdcYxFcpE6f6vYJmnw2lIzlxoMfufZBo35ZyVPaK6FZnWfQ5NqpTOJeDrCK+qp40jBsvhKN8UhWnkfOuSnsnzPtx6g2MyhwlvSYOUvmOXOS00qKI0KBvAxJfb/gbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLQsgUQz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70ea677571so4335560a12.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652644; x=1773257444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GzcfyVYtaaEyeStoDS6O0takiyqc781JZQUTjPtxb2s=;
        b=WLQsgUQzuhasaoVjnUDpsclRVQ64RCBQ74+05WUj0DKEe55bDRX4l4R1ybnDP3cuqn
         3S+Ow6qQ1Y21sEgfxKeZOyCZev8Sy5CpkSUVOJJ02Zn5apIgm1w5EZUwDwGAknAOiHDQ
         rcfjl4florW/wDVQiXDUh1CgAkxlIFLlxp2P+e5AYC6a3GHhnklrJAbz1ztvWzvx3jIG
         Jym0o1x3+DxqUl9CcVINzGLmlJtGPzFFeLz8PNvSgxiCsmworcrbbUgHqzdoZyuCSOqV
         Nm+kVPg+/y/5YA58CJusZCE4UVgPLtcfsg+yDzdc0ZZUKMW1eLvxMFEXZj/d3vZdyGVw
         EQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652644; x=1773257444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzcfyVYtaaEyeStoDS6O0takiyqc781JZQUTjPtxb2s=;
        b=oIgCRcJ5VBFZkbrMClwVYQV9HF/iDMU9BELuSL2Va7a+BYyRwH2LVfe3h7vzuOqMmi
         aq9OFJSHz9LK3c8E/9tgU89oDRW9DkpDfqcOYZ1gaMBEwtrHfgllwo9Snmv+yms81dQx
         Mn361s3Dd7o6UHXmeyqJFR7abO/SLe120THW4XgGrqQdH6Wpt0q6FUFTiU15F8xBD9nd
         ioatdCliUWHISHL83yLnuwK02yis2su6aGYDxwk5tGYqHtYqZNxypcIJkZ7szryQzXcz
         W70f5dr9Ljyc8phZziPPsk4Du72ZPMYUtNmSaEUpJjVJ1HKkNQiLNckIpVhLoPAeyhSm
         ZO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyQ1CemvRqCK+ADSkTRJRcwZrbjqf6zMzyV/Zne0BxeHFD6gn6nY40ghURIC3AqYwueV4waP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6AhOC/yuuCZ8l+ja3XM4nw+zVl1uWCWg/TI4oIxd3YbvV+SuU
	6Af10qqL8llH9sDvZ0B0GHkBIT1S2ThoCVQdavhENKjjntXRT4hpElbKrvssz4aiXJRDQBjkwE4
	mgPBDAA==
X-Received: from pgbfq14.prod.google.com ([2002:a05:6a02:298e:b0:c6e:3a96:928d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e97:b0:394:57e6:afb
 with SMTP id adf61e73a8af0-3982df06b72mr3035509637.22.1772652643752; Wed, 04
 Mar 2026 11:30:43 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:35 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/15] ipv4: Retire UDP-Lite.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9FA5A207162
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264016-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

We have deprecated IPv6 UDP-Lite sockets.

Let's drop support for IPv4 UDP-Lite sockets as well.

Most of the changes are similar to the IPv6 patch: removing
udplite.c and udp_impl.h, marking most functions in udp_impl.h
as static, moving the prototype for udp_recvmsg() to udp.h, and
adding INDIRECT_CALLABLE_SCOPE for it.

In addition, the INET_DIAG support for UDP-Lite is dropped.

We will remove the remaining dead code in the following patches.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/sock.h    |   4 +-
 include/net/udp.h     |   7 ++-
 include/net/udplite.h |   4 --
 net/ipv4/Makefile     |   2 +-
 net/ipv4/af_inet.c    |   6 --
 net/ipv4/proc.c       |   3 -
 net/ipv4/udp.c        |  31 +++++-----
 net/ipv4/udp_bpf.c    |   2 -
 net/ipv4/udp_diag.c   |  47 +--------------
 net/ipv4/udp_impl.h   |  27 ---------
 net/ipv4/udplite.c    | 135 ------------------------------------------
 11 files changed, 25 insertions(+), 243 deletions(-)
 delete mode 100644 net/ipv4/udp_impl.h
 delete mode 100644 net/ipv4/udplite.c

diff --git a/include/net/sock.h b/include/net/sock.h
index 6c3f1340e8ef..16a1b8895206 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -126,14 +126,14 @@ typedef __u64 __bitwise __addrpair;
  *	@skc_bypass_prot_mem: bypass the per-protocol memory accounting for skb
  *	@skc_bound_dev_if: bound device index if != 0
  *	@skc_bind_node: bind hash linkage for various protocol lookup tables
- *	@skc_portaddr_node: second hash linkage for UDP/UDP-Lite protocol
+ *	@skc_portaddr_node: second hash linkage for UDP
  *	@skc_prot: protocol handlers inside a network family
  *	@skc_net: reference to the network namespace of this socket
  *	@skc_v6_daddr: IPV6 destination address
  *	@skc_v6_rcv_saddr: IPV6 source address
  *	@skc_cookie: socket's cookie value
  *	@skc_node: main hash linkage for various protocol lookup tables
- *	@skc_nulls_node: main hash linkage for TCP/UDP/UDP-Lite protocol
+ *	@skc_nulls_node: main hash linkage for TCP
  *	@skc_tx_queue_mapping: tx queue number for this connection
  *	@skc_rx_queue_mapping: rx queue number for this connection
  *	@skc_flags: place holder for sk_flags
diff --git a/include/net/udp.h b/include/net/udp.h
index 7fc0efb16634..8274a6e49ba5 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -104,7 +104,7 @@ struct udp_table {
 	unsigned int		log;
 };
 extern struct udp_table udp_table;
-void udp_table_init(struct udp_table *, const char *);
+
 static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
 					     const struct net *net,
 					     unsigned int num)
@@ -311,7 +311,7 @@ static inline void udp_drops_inc(struct sock *sk)
 	numa_drop_add(&udp_sk(sk)->drop_counters, 1);
 }
 
-/* hash routines shared between UDPv4/6 and UDP-Litev4/6 */
+/* hash routines shared between UDPv4/6 */
 static inline int udp_lib_hash(struct sock *sk)
 {
 	BUG();
@@ -419,6 +419,8 @@ bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst);
 int udp_err(struct sk_buff *, u32);
 int udp_abort(struct sock *sk, int err);
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *sk, struct msghdr *msg,
+					  size_t len, int flags));
 void udp_splice_eof(struct socket *sock);
 int udp_push_pending_frames(struct sock *sk);
 void udp_flush_pending_frames(struct sock *sk);
@@ -426,7 +428,6 @@ int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size);
 void udp4_hwcsum(struct sk_buff *skb, __be32 src, __be32 dst);
 int udp_rcv(struct sk_buff *skb);
 int udp_ioctl(struct sock *sk, int cmd, int *karg);
-int udp_init_sock(struct sock *sk);
 int udp_pre_connect(struct sock *sk, struct sockaddr_unsized *uaddr, int addr_len);
 int __udp_disconnect(struct sock *sk, int flags);
 int udp_disconnect(struct sock *sk, int flags);
diff --git a/include/net/udplite.h b/include/net/udplite.h
index 786919d29f8d..fdd769745ac4 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -12,9 +12,6 @@
 #define UDPLITE_SEND_CSCOV   10 /* sender partial coverage (as sent)      */
 #define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
 
-extern struct proto 		udplite_prot;
-extern struct udp_table		udplite_table;
-
 /*
  *	Checksum computation is all in software, hence simpler getfrag.
  */
@@ -84,5 +81,4 @@ static inline __wsum udplite_csum(struct sk_buff *skb)
 	return skb_checksum(skb, off, len, 0);
 }
 
-void udplite4_register(void);
 #endif	/* _UDPLITE_H */
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index 18108a6f0499..7f9f98813986 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -10,7 +10,7 @@ obj-y     := route.o inetpeer.o protocol.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o \
 	     tcp_minisocks.o tcp_cong.o tcp_metrics.o tcp_fastopen.o \
 	     tcp_recovery.o tcp_ulp.o \
-	     tcp_offload.o tcp_plb.o datagram.o raw.o udp.o udplite.o \
+	     tcp_offload.o tcp_plb.o datagram.o raw.o udp.o \
 	     udp_offload.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     fib_frontend.o fib_semantics.o fib_trie.o fib_notifier.o \
 	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index babcd75a08e2..429d7150a19b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -104,7 +104,6 @@
 #include <net/tcp.h>
 #include <net/psp.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <net/ping.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
@@ -876,8 +875,6 @@ void inet_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
-INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
-					  size_t, int));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags)
 {
@@ -1975,9 +1972,6 @@ static int __init inet_init(void)
 	/* Setup UDP memory threshold */
 	udp_init();
 
-	/* Add UDP-Lite (RFC 3828) */
-	udplite4_register();
-
 	raw_init();
 
 	ping_init();
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 974afc4ecbe2..cf51f8fcf34b 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -35,7 +35,6 @@
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <linux/bottom_half.h>
 #include <linux/inetdevice.h>
 #include <linux/proc_fs.h>
@@ -65,8 +64,6 @@ static int sockstat_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "UDP: inuse %d mem %ld\n",
 		   sock_prot_inuse_get(net, &udp_prot),
 		   proto_memory_allocated(&udp_prot));
-	seq_printf(seq, "UDPLITE: inuse %d\n",
-		   sock_prot_inuse_get(net, &udplite_prot));
 	seq_printf(seq, "RAW: inuse %d\n",
 		   sock_prot_inuse_get(net, &raw_prot));
 	seq_printf(seq,  "FRAG: inuse %u memory %lu\n",
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f0e7e2e919ad..d2de0fb8f0f9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -98,8 +98,10 @@
 #include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <net/aligned_data.h>
 #include <net/net_namespace.h>
 #include <net/icmp.h>
+#include <net/inet_common.h>
 #include <net/inet_hashtables.h>
 #include <net/ip.h>
 #include <net/ip_tunnels.h>
@@ -112,10 +114,10 @@
 #include <linux/btf_ids.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
-#include "udp_impl.h"
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
+#include <net/udplite.h>
 #include <net/gro.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
@@ -229,7 +231,7 @@ static int udp_reuseport_add_sock(struct sock *sk, struct udp_hslot *hslot)
 }
 
 /**
- *  udp_lib_get_port  -  UDP/-Lite port lookup for IPv4 and IPv6
+ *  udp_lib_get_port  -  UDP port lookup for IPv4 and IPv6
  *
  *  @sk:          socket struct in question
  *  @snum:        port number to look up
@@ -353,7 +355,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 }
 EXPORT_IPV6_MOD(udp_lib_get_port);
 
-int udp_v4_get_port(struct sock *sk, unsigned short snum)
+static int udp_v4_get_port(struct sock *sk, unsigned short snum)
 {
 	unsigned int hash2_nulladdr =
 		ipv4_portaddr_hash(sock_net(sk), htonl(INADDR_ANY), snum);
@@ -928,7 +930,7 @@ static struct sock *__udp4_lib_err_encap(struct net *net,
  * to find the appropriate port.
  */
 
-int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
+static int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 {
 	struct inet_sock *inet;
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
@@ -1855,7 +1857,7 @@ static void udp_destruct_sock(struct sock *sk)
 	inet_sock_destruct(sk);
 }
 
-int udp_init_sock(struct sock *sk)
+static int udp_init_sock(struct sock *sk)
 {
 	int res = udp_lib_init_sock(sk);
 
@@ -2070,6 +2072,7 @@ EXPORT_IPV6_MOD(udp_read_skb);
  * 	return it, otherwise we block.
  */
 
+INDIRECT_CALLABLE_SCOPE
 int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
 {
 	struct inet_sock *inet = inet_sk(sk);
@@ -2337,7 +2340,7 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 }
 EXPORT_IPV6_MOD(udp_lib_rehash);
 
-void udp_v4_rehash(struct sock *sk)
+static void udp_v4_rehash(struct sock *sk)
 {
 	u16 new_hash = ipv4_portaddr_hash(sock_net(sk),
 					  inet_sk(sk)->inet_rcv_saddr,
@@ -2683,8 +2686,8 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
  *	All we need to do is get the socket, and then do a checksum.
  */
 
-int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
-		   int proto)
+static int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
+			  int proto)
 {
 	struct sock *sk = NULL;
 	struct udphdr *uh;
@@ -2930,7 +2933,7 @@ int udp_rcv(struct sk_buff *skb)
 	return __udp4_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
 }
 
-void udp_destroy_sock(struct sock *sk)
+static void udp_destroy_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
 	bool slow = lock_sock_fast(sk);
@@ -3120,8 +3123,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 }
 EXPORT_IPV6_MOD(udp_lib_setsockopt);
 
-int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		   unsigned int optlen)
+static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
+			  unsigned int optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
@@ -3191,8 +3194,8 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 }
 EXPORT_IPV6_MOD(udp_lib_getsockopt);
 
-int udp_getsockopt(struct sock *sk, int level, int optname,
-		   char __user *optval, int __user *optlen)
+static int udp_getsockopt(struct sock *sk, int level, int optname,
+			  char __user *optval, int __user *optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
 		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
@@ -3801,7 +3804,7 @@ static int __init set_uhash_entries(char *str)
 }
 __setup("uhash_entries=", set_uhash_entries);
 
-void __init udp_table_init(struct udp_table *table, const char *name)
+static void __init udp_table_init(struct udp_table *table, const char *name)
 {
 	unsigned int i, slot_size;
 
diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
index 912f0bfef4af..fc0e4f2e1085 100644
--- a/net/ipv4/udp_bpf.c
+++ b/net/ipv4/udp_bpf.c
@@ -7,8 +7,6 @@
 #include <net/inet_common.h>
 #include <asm/ioctls.h>
 
-#include "udp_impl.h"
-
 static struct proto *udpv6_prot_saved __read_mostly;
 
 static int sk_udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index 6e491c720c90..a010d05062a0 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -10,7 +10,6 @@
 #include <linux/inet_diag.h>
 #include <linux/udp.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <linux/sock_diag.h>
 
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
@@ -224,12 +223,6 @@ static int udp_diag_destroy(struct sk_buff *in_skb,
 	return __udp_diag_destroy(in_skb, req, sock_net(in_skb->sk)->ipv4.udp_table);
 }
 
-static int udplite_diag_destroy(struct sk_buff *in_skb,
-				const struct inet_diag_req_v2 *req)
-{
-	return __udp_diag_destroy(in_skb, req, &udplite_table);
-}
-
 #endif
 
 static const struct inet_diag_handler udp_diag_handler = {
@@ -244,50 +237,13 @@ static const struct inet_diag_handler udp_diag_handler = {
 #endif
 };
 
-static void udplite_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
-			      const struct inet_diag_req_v2 *r)
-{
-	udp_dump(&udplite_table, skb, cb, r);
-}
-
-static int udplite_diag_dump_one(struct netlink_callback *cb,
-				 const struct inet_diag_req_v2 *req)
-{
-	return udp_dump_one(&udplite_table, cb, req);
-}
-
-static const struct inet_diag_handler udplite_diag_handler = {
-	.owner		 = THIS_MODULE,
-	.dump		 = udplite_diag_dump,
-	.dump_one	 = udplite_diag_dump_one,
-	.idiag_get_info  = udp_diag_get_info,
-	.idiag_type	 = IPPROTO_UDPLITE,
-	.idiag_info_size = 0,
-#ifdef CONFIG_INET_DIAG_DESTROY
-	.destroy	 = udplite_diag_destroy,
-#endif
-};
-
 static int __init udp_diag_init(void)
 {
-	int err;
-
-	err = inet_diag_register(&udp_diag_handler);
-	if (err)
-		goto out;
-	err = inet_diag_register(&udplite_diag_handler);
-	if (err)
-		goto out_lite;
-out:
-	return err;
-out_lite:
-	inet_diag_unregister(&udp_diag_handler);
-	goto out;
+	return inet_diag_register(&udp_diag_handler);
 }
 
 static void __exit udp_diag_exit(void)
 {
-	inet_diag_unregister(&udplite_diag_handler);
 	inet_diag_unregister(&udp_diag_handler);
 }
 
@@ -296,4 +252,3 @@ module_exit(udp_diag_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("UDP socket monitoring via SOCK_DIAG");
 MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-17 /* AF_INET - IPPROTO_UDP */);
-MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_NETLINK, NETLINK_SOCK_DIAG, 2-136 /* AF_INET - IPPROTO_UDPLITE */);
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
deleted file mode 100644
index 0ca4384f9afa..000000000000
--- a/net/ipv4/udp_impl.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _UDP4_IMPL_H
-#define _UDP4_IMPL_H
-#include <net/aligned_data.h>
-#include <net/udp.h>
-#include <net/udplite.h>
-#include <net/protocol.h>
-#include <net/inet_common.h>
-
-int __udp4_lib_rcv(struct sk_buff *, struct udp_table *, int);
-int __udp4_lib_err(struct sk_buff *, u32, struct udp_table *);
-
-int udp_v4_get_port(struct sock *sk, unsigned short snum);
-void udp_v4_rehash(struct sock *sk);
-
-int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		   unsigned int optlen);
-int udp_getsockopt(struct sock *sk, int level, int optname,
-		   char __user *optval, int __user *optlen);
-
-int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
-void udp_destroy_sock(struct sock *sk);
-
-#ifdef CONFIG_PROC_FS
-extern const struct seq_operations udp_seq_ops;
-#endif
-#endif	/* _UDP4_IMPL_H */
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
deleted file mode 100644
index 826e9e79eb19..000000000000
--- a/net/ipv4/udplite.c
+++ /dev/null
@@ -1,135 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  UDPLITE     An implementation of the UDP-Lite protocol (RFC 3828).
- *
- *  Authors:    Gerrit Renker       <gerrit@erg.abdn.ac.uk>
- *
- *  Changes:
- *  Fixes:
- */
-
-#define pr_fmt(fmt) "UDPLite: " fmt
-
-#include <linux/export.h>
-#include <linux/proc_fs.h>
-#include "udp_impl.h"
-
-struct udp_table 	udplite_table __read_mostly;
-EXPORT_SYMBOL(udplite_table);
-
-/* Designate sk as UDP-Lite socket */
-static int udplite_sk_init(struct sock *sk)
-{
-	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
-		     "please contact the netdev mailing list\n");
-	return udp_init_sock(sk);
-}
-
-static int udplite_rcv(struct sk_buff *skb)
-{
-	return __udp4_lib_rcv(skb, &udplite_table, IPPROTO_UDPLITE);
-}
-
-static int udplite_err(struct sk_buff *skb, u32 info)
-{
-	return __udp4_lib_err(skb, info, &udplite_table);
-}
-
-static const struct net_protocol udplite_protocol = {
-	.handler	= udplite_rcv,
-	.err_handler	= udplite_err,
-	.no_policy	= 1,
-};
-
-struct proto 	udplite_prot = {
-	.name		   = "UDP-Lite",
-	.owner		   = THIS_MODULE,
-	.close		   = udp_lib_close,
-	.connect	   = ip4_datagram_connect,
-	.disconnect	   = udp_disconnect,
-	.ioctl		   = udp_ioctl,
-	.init		   = udplite_sk_init,
-	.destroy	   = udp_destroy_sock,
-	.setsockopt	   = udp_setsockopt,
-	.getsockopt	   = udp_getsockopt,
-	.sendmsg	   = udp_sendmsg,
-	.recvmsg	   = udp_recvmsg,
-	.hash		   = udp_lib_hash,
-	.unhash		   = udp_lib_unhash,
-	.rehash		   = udp_v4_rehash,
-	.get_port	   = udp_v4_get_port,
-
-	.memory_allocated  = &net_aligned_data.udp_memory_allocated,
-	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
-
-	.sysctl_mem	   = sysctl_udp_mem,
-	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
-	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
-	.obj_size	   = sizeof(struct udp_sock),
-	.h.udp_table	   = &udplite_table,
-};
-EXPORT_SYMBOL(udplite_prot);
-
-static struct inet_protosw udplite4_protosw = {
-	.type		=  SOCK_DGRAM,
-	.protocol	=  IPPROTO_UDPLITE,
-	.prot		=  &udplite_prot,
-	.ops		=  &inet_dgram_ops,
-	.flags		=  INET_PROTOSW_PERMANENT,
-};
-
-#ifdef CONFIG_PROC_FS
-static struct udp_seq_afinfo udplite4_seq_afinfo = {
-	.family		= AF_INET,
-	.udp_table 	= &udplite_table,
-};
-
-static int __net_init udplite4_proc_init_net(struct net *net)
-{
-	if (!proc_create_net_data("udplite", 0444, net->proc_net, &udp_seq_ops,
-			sizeof(struct udp_iter_state), &udplite4_seq_afinfo))
-		return -ENOMEM;
-	return 0;
-}
-
-static void __net_exit udplite4_proc_exit_net(struct net *net)
-{
-	remove_proc_entry("udplite", net->proc_net);
-}
-
-static struct pernet_operations udplite4_net_ops = {
-	.init = udplite4_proc_init_net,
-	.exit = udplite4_proc_exit_net,
-};
-
-static __init int udplite4_proc_init(void)
-{
-	return register_pernet_subsys(&udplite4_net_ops);
-}
-#else
-static inline int udplite4_proc_init(void)
-{
-	return 0;
-}
-#endif
-
-void __init udplite4_register(void)
-{
-	udp_table_init(&udplite_table, "UDP-Lite");
-	if (proto_register(&udplite_prot, 1))
-		goto out_register_err;
-
-	if (inet_add_protocol(&udplite_protocol, IPPROTO_UDPLITE) < 0)
-		goto out_unregister_proto;
-
-	inet_register_protosw(&udplite4_protosw);
-
-	if (udplite4_proc_init())
-		pr_err("%s: Cannot register /proc!\n", __func__);
-	return;
-
-out_unregister_proto:
-	proto_unregister(&udplite_prot);
-out_register_err:
-	pr_crit("%s: Cannot add UDP-Lite protocol\n", __func__);
-}
-- 
2.53.0.473.g4a7958ca14-goog


