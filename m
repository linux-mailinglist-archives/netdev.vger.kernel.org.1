Return-Path: <netdev+bounces-264014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHBmEH2IqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD47207170
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DADF3013A4A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0C93DBD71;
	Wed,  4 Mar 2026 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7eh9r9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE33DBD6A
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652642; cv=none; b=IxayGaT/7R11Yv+N1vYPb0mFC1h29VO5CAGVk/72PMrsknORrqjIo+CEDI0JxbFifEkkHM3mOKDDpoNkkHfOijsCbB75wh/wg+q6AJOuvWZohM5Ye/yxIpxodHZGIPb7OzWe1/EOJPrxNb/KQZdGNL6v5u/CjlV6wVt/F3FQmog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652642; c=relaxed/simple;
	bh=4nwYbIztHa6lftCRQSLbN2UUcWX7nCMgL/WOxg2iFwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y1Yp57o8MWx4E1wIeIeAVaDxlzFcPtSsZ3AzmXQtGIFHj37tYa4LL7TX9JKEUa82VZPg72DfYubLFWhkLNr3Q2GSgcG5jQvsFXUtFKH9wAi4CjQ7wboNb9CQz9CR035D0M9DROCnyKt1L9Ffj0lDB3wpqEFaeKu/24/IoaumoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7eh9r9m; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad5fec175so270109915ad.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652641; x=1773257441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8tIPg4UxzlnP7TcqPhA4Y7xDay9+GpckGN9OOIm/7zc=;
        b=v7eh9r9mI6+Sv8p284k2ONDGSx+o9gGT76PO1FIKSwvt9nuHr5rvDevQLWLV9+VcLA
         K4pxFUERZHu2aHM46k2S/q8rMqOZH1MfmC9sFlDkvJ8lgUZcr9OluOPFDNNnNg0rfjHm
         PfufjWFCdcfm4DJKoKLEh0Ankr5bZNS3JiCXtURR7mOBVg/5IbhIpSMJxjJD6ETnCbNh
         S/gaSxAE7Tu10YeTXZWvCMsdB0LblqVywgSaBYsDBoSgJYMikk28gO3SHMzMulh1Rvmc
         FjQBZYxeU+ruRTOCwFR/s97LvcK05cw137LVzmiC4SFFJUalhG5PXsXBDGkdo7xHZPSP
         rBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652641; x=1773257441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tIPg4UxzlnP7TcqPhA4Y7xDay9+GpckGN9OOIm/7zc=;
        b=UHZ09jEIOH5wAfefzR2cjrjtEi6NdlKW4jgQZdevmYm3rGgzaRgq+ie8xz8IzQEuHl
         bxkwCZ8Fulg8HY7hWEtNfzbt3yUNb2/cPn6Z/QUCNB/NOzOdnWwPG2/K5SzXW2+f/WiB
         8yg/7HcpTAmxOjTyJ3u2qYcLMJbjMOCfMTOB7NeqVjwNJ0hHMFz+AOUhV//DhyQciyQI
         0TNtDJhGcpnK1q+zJn3KtLoz89XYb/5JvmT2qfcsJ72CaJXqJmgQqGcz7uflLs1Is+b/
         oVYAk/wCECT5qzJgwU8y13oVIsBe9XYzZI/xOU4MD3CtFXW8OSzTJDGM5keGIlO0pvwT
         FQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzq3RLae0rxozAixSsbIhEfFvuu38H5lydwOXRT7Sti9suTfP+NAKoYDgkkFr3icdPHfyOYRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w59sqnQIP621jBlahrBla4oNM7VK2qaNnLfLgdr3k0Q4dHOL
	94UCiACade+CbxB/a/92zblumaX/Pr+H8JDGn8jRyIbMPcmFvuA4+6WwbOFJKoSMbCl3XyXRE8n
	39y6zXg==
X-Received: from plka14.prod.google.com ([2002:a17:903:f8e:b0:2ae:4964:6fe2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:2ae:4c9f:4a5a
 with SMTP id d9443c01a7336-2ae6aa01e74mr30692325ad.6.1772652640633; Wed, 04
 Mar 2026 11:30:40 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:33 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/15] ipv6: Retire UDP-Lite.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AFD47207170
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264014-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

As announced in commit be28c14ac8bb ("udplite: Print deprecation
notice."), it's time to deprecate UDP-Lite.

As a first step, let's drop support for IPv6 UDP-Lite sockets.

We will remove the remaining dead code gradually.

Along with the removal of udplite.c, most of the functions exposed
via udp_impl.h are made static.

The prototypes of udpv6_sendmsg() and udpv6_recvmsg() are moved
to udp.h, but only udpv6_recvmsg() has INDIRECT_CALLABLE_DECLARE()
because udpv6_sendmsg() is exported for rxrpc since commit ed472b0c8783
("rxrpc: Call udp_sendmsg() directly").

Also, udpv6_recvmsg() needs INDIRECT_CALLABLE_SCOPE for
CONFIG_MITIGATION_RETPOLINE=n.

Note that udplite.h is included temporarily for udplite_csum().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/ipv6.h      |   2 -
 include/net/transp_v6.h |   3 -
 include/net/udp.h       |   4 ++
 net/ipv6/Makefile       |   2 +-
 net/ipv6/af_inet6.c     |  23 +------
 net/ipv6/proc.c         |   2 -
 net/ipv6/udp.c          |  32 ++++-----
 net/ipv6/udp_impl.h     |  31 ---------
 net/ipv6/udplite.c      | 139 ----------------------------------------
 net/rxrpc/output.c      |   2 -
 10 files changed, 23 insertions(+), 217 deletions(-)
 delete mode 100644 net/ipv6/udp_impl.h
 delete mode 100644 net/ipv6/udplite.c

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 1c0ce5151275..0958cc5c6ec3 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1179,8 +1179,6 @@ int tcp6_proc_init(struct net *net);
 void tcp6_proc_exit(struct net *net);
 int udp6_proc_init(struct net *net);
 void udp6_proc_exit(struct net *net);
-int udplite6_proc_init(void);
-void udplite6_proc_exit(void);
 int ipv6_misc_proc_init(void);
 void ipv6_misc_proc_exit(void);
 int snmp6_register_dev(struct inet6_dev *idev);
diff --git a/include/net/transp_v6.h b/include/net/transp_v6.h
index 1a97e3f32029..c0a421fe0c2a 100644
--- a/include/net/transp_v6.h
+++ b/include/net/transp_v6.h
@@ -8,7 +8,6 @@
 /* IPv6 transport protocols */
 extern struct proto rawv6_prot;
 extern struct proto udpv6_prot;
-extern struct proto udplitev6_prot;
 extern struct proto tcpv6_prot;
 extern struct proto pingv6_prot;
 
@@ -28,8 +27,6 @@ int rawv6_init(void);
 void rawv6_exit(void);
 int udpv6_init(void);
 void udpv6_exit(void);
-int udplitev6_init(void);
-void udplitev6_exit(void);
 int tcpv6_init(void);
 void tcpv6_exit(void);
 
diff --git a/include/net/udp.h b/include/net/udp.h
index b82343a095d1..7fc0efb16634 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -281,6 +281,10 @@ typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, __be16 sport,
 void udp_v6_early_demux(struct sk_buff *skb);
 INDIRECT_CALLABLE_DECLARE(int udpv6_rcv(struct sk_buff *));
 
+int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+INDIRECT_CALLABLE_DECLARE(int udpv6_recvmsg(struct sock *sk, struct msghdr *msg,
+					    size_t len, int flags));
+
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 				  netdev_features_t features, bool is_ipv6);
 
diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
index 0492f1a0b491..2c9ce2ccbde1 100644
--- a/net/ipv6/Makefile
+++ b/net/ipv6/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_IPV6) += ipv6.o
 
 ipv6-y :=	af_inet6.o anycast.o ip6_output.o ip6_input.o addrconf.o \
 		addrlabel.o \
-		route.o ip6_fib.o ipv6_sockglue.o ndisc.o udp.o udplite.o \
+		route.o ip6_fib.o ipv6_sockglue.o ndisc.o udp.o \
 		raw.o icmp.o mcast.o reassembly.o tcp_ipv6.o ping.o \
 		exthdrs.o datagram.o ip6_flowlabel.o inet6_connection_sock.o \
 		udp_offload.o seg6.o fib6_notifier.o rpl.o ioam6.o
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 0b995a961359..9ad907a5a093 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -43,7 +43,6 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <net/tcp.h>
 #include <net/ping.h>
 #include <net/protocol.h>
@@ -644,8 +643,6 @@ int inet6_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 EXPORT_SYMBOL_GPL(inet6_compat_ioctl);
 #endif /* CONFIG_COMPAT */
 
-INDIRECT_CALLABLE_DECLARE(int udpv6_sendmsg(struct sock *, struct msghdr *,
-					    size_t));
 int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
@@ -660,8 +657,6 @@ int inet6_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			       sk, msg, size);
 }
 
-INDIRECT_CALLABLE_DECLARE(int udpv6_recvmsg(struct sock *, struct msghdr *,
-					    size_t, int));
 int inet6_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		  int flags)
 {
@@ -1088,13 +1083,9 @@ static int __init inet6_init(void)
 	if (err)
 		goto out_unregister_tcp_proto;
 
-	err = proto_register(&udplitev6_prot, 1);
-	if (err)
-		goto out_unregister_udp_proto;
-
 	err = proto_register(&rawv6_prot, 1);
 	if (err)
-		goto out_unregister_udplite_proto;
+		goto out_unregister_udp_proto;
 
 	err = proto_register(&pingv6_prot, 1);
 	if (err)
@@ -1145,8 +1136,6 @@ static int __init inet6_init(void)
 	err = -ENOMEM;
 	if (raw6_proc_init())
 		goto proc_raw6_fail;
-	if (udplite6_proc_init())
-		goto proc_udplite6_fail;
 	if (ipv6_misc_proc_init())
 		goto proc_misc6_fail;
 	if (if6_proc_init())
@@ -1182,10 +1171,6 @@ static int __init inet6_init(void)
 	if (err)
 		goto udpv6_fail;
 
-	err = udplitev6_init();
-	if (err)
-		goto udplitev6_fail;
-
 	err = udpv6_offload_init();
 	if (err)
 		goto udpv6_offload_fail;
@@ -1256,8 +1241,6 @@ static int __init inet6_init(void)
 tcpv6_fail:
 	udpv6_offload_exit();
 udpv6_offload_fail:
-	udplitev6_exit();
-udplitev6_fail:
 	udpv6_exit();
 udpv6_fail:
 	ipv6_frag_exit();
@@ -1279,8 +1262,6 @@ static int __init inet6_init(void)
 proc_if6_fail:
 	ipv6_misc_proc_exit();
 proc_misc6_fail:
-	udplite6_proc_exit();
-proc_udplite6_fail:
 	raw6_proc_exit();
 proc_raw6_fail:
 #endif
@@ -1304,8 +1285,6 @@ static int __init inet6_init(void)
 	proto_unregister(&pingv6_prot);
 out_unregister_raw_proto:
 	proto_unregister(&rawv6_prot);
-out_unregister_udplite_proto:
-	proto_unregister(&udplitev6_prot);
 out_unregister_udp_proto:
 	proto_unregister(&udpv6_prot);
 out_unregister_tcp_proto:
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 73296f38c252..21bfc73152f0 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -39,8 +39,6 @@ static int sockstat6_seq_show(struct seq_file *seq, void *v)
 		       sock_prot_inuse_get(net, &tcpv6_prot));
 	seq_printf(seq, "UDP6: inuse %d\n",
 		       sock_prot_inuse_get(net, &udpv6_prot));
-	seq_printf(seq, "UDPLITE6: inuse %d\n",
-			sock_prot_inuse_get(net, &udplitev6_prot));
 	seq_printf(seq, "RAW6: inuse %d\n",
 		       sock_prot_inuse_get(net, &rawv6_prot));
 	seq_printf(seq, "FRAG6: inuse %u memory %lu\n",
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 5fef1c226697..aa859bb0527d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -37,6 +37,7 @@
 #include <trace/events/udp.h>
 
 #include <net/addrconf.h>
+#include <net/aligned_data.h>
 #include <net/ndisc.h>
 #include <net/protocol.h>
 #include <net/transp_v6.h>
@@ -57,7 +58,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <trace/events/skb.h>
-#include "udp_impl.h"
+#include <net/udplite.h>
 
 static void udpv6_destruct_sock(struct sock *sk)
 {
@@ -65,7 +66,7 @@ static void udpv6_destruct_sock(struct sock *sk)
 	inet6_sock_destruct(sk);
 }
 
-int udpv6_init_sock(struct sock *sk)
+static int udpv6_init_sock(struct sock *sk)
 {
 	int res = udp_lib_init_sock(sk);
 
@@ -95,7 +96,7 @@ u32 udp6_ehashfn(const struct net *net,
 			       udp6_ehash_secret + net_hash_mix(net));
 }
 
-int udp_v6_get_port(struct sock *sk, unsigned short snum)
+static int udp_v6_get_port(struct sock *sk, unsigned short snum)
 {
 	unsigned int hash2_nulladdr =
 		ipv6_portaddr_hash(sock_net(sk), &in6addr_any, snum);
@@ -107,7 +108,7 @@ int udp_v6_get_port(struct sock *sk, unsigned short snum)
 	return udp_lib_get_port(sk, snum, hash2_nulladdr);
 }
 
-void udp_v6_rehash(struct sock *sk)
+static void udp_v6_rehash(struct sock *sk)
 {
 	u16 new_hash = ipv6_portaddr_hash(sock_net(sk),
 					  &sk->sk_v6_rcv_saddr,
@@ -464,6 +465,7 @@ static int udp6_skb_len(struct sk_buff *skb)
  *	return it, otherwise we block.
  */
 
+INDIRECT_CALLABLE_SCOPE
 int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		  int flags)
 {
@@ -700,9 +702,9 @@ static struct sock *__udp6_lib_err_encap(struct net *net,
 	return sk;
 }
 
-int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
-		   u8 type, u8 code, int offset, __be32 info,
-		   struct udp_table *udptable)
+static int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
+			  u8 type, u8 code, int offset, __be32 info,
+			  struct udp_table *udptable)
 {
 	struct ipv6_pinfo *np;
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
@@ -1115,8 +1117,8 @@ static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto)
 	return 0;
 }
 
-int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
-		   int proto)
+static int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
+			  int proto)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
@@ -1854,7 +1856,7 @@ static void udpv6_splice_eof(struct socket *sock)
 	release_sock(sk);
 }
 
-void udpv6_destroy_sock(struct sock *sk)
+static void udpv6_destroy_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
 	lock_sock(sk);
@@ -1882,8 +1884,8 @@ void udpv6_destroy_sock(struct sock *sk)
 /*
  *	Socket option code for UDP
  */
-int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		     unsigned int optlen)
+static int udpv6_setsockopt(struct sock *sk, int level, int optname,
+			    sockptr_t optval, unsigned int optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
@@ -1892,8 +1894,8 @@ int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 	return ipv6_setsockopt(sk, level, optname, optval, optlen);
 }
 
-int udpv6_getsockopt(struct sock *sk, int level, int optname,
-		     char __user *optval, int __user *optlen)
+static int udpv6_getsockopt(struct sock *sk, int level, int optname,
+			    char __user *optval, int __user *optlen)
 {
 	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
 		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
@@ -1918,7 +1920,7 @@ static int udp6_seq_show(struct seq_file *seq, void *v)
 	return 0;
 }
 
-const struct seq_operations udp6_seq_ops = {
+static const struct seq_operations udp6_seq_ops = {
 	.start		= udp_seq_start,
 	.next		= udp_seq_next,
 	.stop		= udp_seq_stop,
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
deleted file mode 100644
index 525ea600228a..000000000000
--- a/net/ipv6/udp_impl.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _UDP6_IMPL_H
-#define _UDP6_IMPL_H
-#include <net/aligned_data.h>
-#include <net/udp.h>
-#include <net/udplite.h>
-#include <net/protocol.h>
-#include <net/addrconf.h>
-#include <net/inet_common.h>
-#include <net/transp_v6.h>
-
-int __udp6_lib_rcv(struct sk_buff *, struct udp_table *, int);
-int __udp6_lib_err(struct sk_buff *, struct inet6_skb_parm *, u8, u8, int,
-		   __be32, struct udp_table *);
-
-int udpv6_init_sock(struct sock *sk);
-int udp_v6_get_port(struct sock *sk, unsigned short snum);
-void udp_v6_rehash(struct sock *sk);
-
-int udpv6_getsockopt(struct sock *sk, int level, int optname,
-		     char __user *optval, int __user *optlen);
-int udpv6_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
-		     unsigned int optlen);
-int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
-int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags);
-void udpv6_destroy_sock(struct sock *sk);
-
-#ifdef CONFIG_PROC_FS
-extern const struct seq_operations udp6_seq_ops;
-#endif
-#endif	/* _UDP6_IMPL_H */
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
deleted file mode 100644
index e867721cda4d..000000000000
--- a/net/ipv6/udplite.c
+++ /dev/null
@@ -1,139 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  UDPLITEv6   An implementation of the UDP-Lite protocol over IPv6.
- *              See also net/ipv4/udplite.c
- *
- *  Authors:    Gerrit Renker       <gerrit@erg.abdn.ac.uk>
- *
- *  Changes:
- *  Fixes:
- */
-#define pr_fmt(fmt) "UDPLite6: " fmt
-
-#include <linux/export.h>
-#include <linux/proc_fs.h>
-#include "udp_impl.h"
-
-static int udplitev6_sk_init(struct sock *sk)
-{
-	pr_warn_once("UDP-Lite is deprecated and scheduled to be removed in 2025, "
-		     "please contact the netdev mailing list\n");
-	return udpv6_init_sock(sk);
-}
-
-static int udplitev6_rcv(struct sk_buff *skb)
-{
-	return __udp6_lib_rcv(skb, &udplite_table, IPPROTO_UDPLITE);
-}
-
-static int udplitev6_err(struct sk_buff *skb,
-			  struct inet6_skb_parm *opt,
-			  u8 type, u8 code, int offset, __be32 info)
-{
-	return __udp6_lib_err(skb, opt, type, code, offset, info,
-			      &udplite_table);
-}
-
-static const struct inet6_protocol udplitev6_protocol = {
-	.handler	=	udplitev6_rcv,
-	.err_handler	=	udplitev6_err,
-	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
-};
-
-struct proto udplitev6_prot = {
-	.name		   = "UDPLITEv6",
-	.owner		   = THIS_MODULE,
-	.close		   = udp_lib_close,
-	.connect	   = ip6_datagram_connect,
-	.disconnect	   = udp_disconnect,
-	.ioctl		   = udp_ioctl,
-	.init		   = udplitev6_sk_init,
-	.destroy	   = udpv6_destroy_sock,
-	.setsockopt	   = udpv6_setsockopt,
-	.getsockopt	   = udpv6_getsockopt,
-	.sendmsg	   = udpv6_sendmsg,
-	.recvmsg	   = udpv6_recvmsg,
-	.hash		   = udp_lib_hash,
-	.unhash		   = udp_lib_unhash,
-	.rehash		   = udp_v6_rehash,
-	.get_port	   = udp_v6_get_port,
-
-	.memory_allocated  = &net_aligned_data.udp_memory_allocated,
-	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
-
-	.sysctl_mem	   = sysctl_udp_mem,
-	.sysctl_wmem_offset = offsetof(struct net, ipv4.sysctl_udp_wmem_min),
-	.sysctl_rmem_offset = offsetof(struct net, ipv4.sysctl_udp_rmem_min),
-	.obj_size	   = sizeof(struct udp6_sock),
-	.ipv6_pinfo_offset = offsetof(struct udp6_sock, inet6),
-	.h.udp_table	   = &udplite_table,
-};
-
-static struct inet_protosw udplite6_protosw = {
-	.type		= SOCK_DGRAM,
-	.protocol	= IPPROTO_UDPLITE,
-	.prot		= &udplitev6_prot,
-	.ops		= &inet6_dgram_ops,
-	.flags		= INET_PROTOSW_PERMANENT,
-};
-
-int __init udplitev6_init(void)
-{
-	int ret;
-
-	ret = inet6_add_protocol(&udplitev6_protocol, IPPROTO_UDPLITE);
-	if (ret)
-		goto out;
-
-	ret = inet6_register_protosw(&udplite6_protosw);
-	if (ret)
-		goto out_udplitev6_protocol;
-out:
-	return ret;
-
-out_udplitev6_protocol:
-	inet6_del_protocol(&udplitev6_protocol, IPPROTO_UDPLITE);
-	goto out;
-}
-
-void udplitev6_exit(void)
-{
-	inet6_unregister_protosw(&udplite6_protosw);
-	inet6_del_protocol(&udplitev6_protocol, IPPROTO_UDPLITE);
-}
-
-#ifdef CONFIG_PROC_FS
-static struct udp_seq_afinfo udplite6_seq_afinfo = {
-	.family		= AF_INET6,
-	.udp_table	= &udplite_table,
-};
-
-static int __net_init udplite6_proc_init_net(struct net *net)
-{
-	if (!proc_create_net_data("udplite6", 0444, net->proc_net,
-			&udp6_seq_ops, sizeof(struct udp_iter_state),
-			&udplite6_seq_afinfo))
-		return -ENOMEM;
-	return 0;
-}
-
-static void __net_exit udplite6_proc_exit_net(struct net *net)
-{
-	remove_proc_entry("udplite6", net->proc_net);
-}
-
-static struct pernet_operations udplite6_net_ops = {
-	.init = udplite6_proc_init_net,
-	.exit = udplite6_proc_exit_net,
-};
-
-int __init udplite6_proc_init(void)
-{
-	return register_pernet_subsys(&udplite6_net_ops);
-}
-
-void udplite6_proc_exit(void)
-{
-	unregister_pernet_subsys(&udplite6_net_ops);
-}
-#endif
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index d70db367e358..e5880116e087 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -16,8 +16,6 @@
 #include <net/udp.h>
 #include "ar-internal.h"
 
-extern int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
-
 ssize_t do_udp_sendmsg(struct socket *socket, struct msghdr *msg, size_t len)
 {
 	struct sockaddr *sa = msg->msg_name;
-- 
2.53.0.473.g4a7958ca14-goog


