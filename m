Return-Path: <netdev+bounces-266474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF6BCNT7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3A25C5E8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C4F93072F1D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB1282F23;
	Wed, 11 Mar 2026 05:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFE/BIIJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EF31F9AA
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206443; cv=none; b=WIktCOVyUs9+sXdbluxoHtavvBJG3HOR4/DGpnVqvC/zaSHNLy54nS05Kj4Y2SPqFtE315gQUGkGEOkR+MR673pfzWGyqiPhgWp2AdtVtNBcpLc+VJaUayyENphOo7K2eDP0kWrqEBXnwFwSJ8TYjO0Ckku6q5pFuDAE+tW2kdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206443; c=relaxed/simple;
	bh=q6uvPERm7H4t4N1OP8TObmZeuhTwOcafTOzm3lGE0BI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKzO7aDHWwpX37B0fIrMRLRL/zQhmxvlQZxg+aH1UUIzWvuv5FEzAAdU8ShGaK2uywfh6jqr0ZoUnClSPydchSbRIBx+2FhV7wtQKNmSR7JCRJWLlBtubITOMV3KpcE6aNIQB5mcSggftpL3rFSKKO3/22MkxM3XeCYq2RdDavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFE/BIIJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a0998a441so80849a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206441; x=1773811241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoY/vESDFnm2zREk4ggOK2tiUGgmK0fxpfKqEDm50aE=;
        b=CFE/BIIJTEC/cPpwj5SM7IaTtAAxVWCJ+7iklI0HZoZHBGfou8pPT21ZqIiv5iW1Fp
         vR+yNmBhd/k54biPCfbgD8BeMko5DEnMekI6rzk03v8Y+i3sHm+zxpCG/DXi+XGL5MCY
         yix7d7F/bvW+uCTW3mAcAuisVhNrocJF7LqbpZkt7gYi+mn2oiLIvFjnjrFrf1aKJyyy
         RDe+VuOL09ZAa2NcxNJnsyKiQPGUnaAIvil1A/M4Hx8q8nz1NderarMfyS7fJzsxo/ht
         Cw+ldiqfObj8k3ySFlcWdXdrVkYnNKnheuYrqVNF70jg8rfO40BYnuyWaeo2ZGQlzh5C
         wBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206441; x=1773811241;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoY/vESDFnm2zREk4ggOK2tiUGgmK0fxpfKqEDm50aE=;
        b=jkj3W0dSr0baSjyv0g5K2A3dTbwVVGqkWZxpE2H8D3cmu+HP8Z+gs26iYajTarCkpx
         +JHzClI8Qc0Hjw4EB3XoYOVDRSvBh6fgfiCTctSY49nf1wNwXwXY5Kx0igTC9FEjE0n8
         Eyt+UqWGGyTTxUJi8IwKC/VBuSgE3lOKer7AHuYj2WD9utwUtmvysuThhK8S7drINi7F
         mBq4W+AVvRsBUc7Eq/yJb9u/Cuc1jqkZ25hMo/T+ZsayMq6zVKjMcHBStQe/qctUG4Je
         0U7lceRsYXlLuRYl+qd4KVMHD7XmgznEaTB57d2FgsXlboiJ6SiCgo2zlXz4armCAZTx
         4K6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9votS7ilnaZE44G0aA8wLSY5xRGQvQY+5L/KFj2hRIEvGEKLeQZ7Pv9E0G5mVQSCcyliOUBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aZ+sjq6mCLkNuM3YxKqUmpMXX9B8FjLOlqdGalvIbu9BsqZt
	ppKg0+7+kFnjQ9hm3dLTLDZlXO0+REs3ZSRzCAegGfSCQvl1exmfq7yAPg8CzONcv9ab8wwPQ3X
	+Zj/BRQ==
X-Received: from pjbms22.prod.google.com ([2002:a17:90b:2356:b0:359:8d95:3fdb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3889:b0:354:a57c:65ec
 with SMTP id 98e67ed59e1d1-35a012d324cmr1266218a91.20.1773206440756; Tue, 10
 Mar 2026 22:20:40 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:56 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-10-kuniyu@google.com>
Subject: [PATCH v3 net-next 09/15] udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9CD3A25C5E8
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266474-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

UDP-Lite supports variable-length checksum and has two socket
options, UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV, to control
the checksum coverage.

Let's remove the support.

setsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was only
available for UDP-Lite and returned -ENOPROTOOPT for UDP.

Now, the options are handled in ip_setsockopt() and
ipv6_setsockopt(), which still return the same error.

getsockopt(UDPLITE_SEND_CSCOV / UDPLITE_RECV_CSCOV) was available
for UDP and always returned 0, meaning full checksum, but now
-ENOPROTOOPT is returned.

Given that getsockopt() is meaningless for UDP and even the options
are not defined under include/uapi/, this should not be a problem.

  $ man 7 udplite
  ...
  BUGS
       Where glibc support is missing, the following definitions
       are needed:

           #define IPPROTO_UDPLITE     136
           #define UDPLITE_SEND_CSCOV  10
           #define UDPLITE_RECV_CSCOV  11

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v2: Add a detailed reason in include/uapi/linux/udp.h
---
 include/linux/udp.h      | 10 +--------
 include/net/udplite.h    | 15 -------------
 include/uapi/linux/udp.h |  2 ++
 net/ipv4/udp.c           | 46 ++--------------------------------------
 net/ipv6/ip6_checksum.c  |  2 +-
 net/ipv6/udp.c           |  5 ++---
 6 files changed, 8 insertions(+), 72 deletions(-)
 delete mode 100644 include/net/udplite.h

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 1cbf6b4d3aab..ce56ebcee5cb 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -40,8 +40,6 @@ enum {
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
-	UDP_FLAGS_UDPLITE_SEND_CC, /* set via udplite setsockopt */
-	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
 };
 
 /* per NUMA structure for lockless producer usage. */
@@ -74,11 +72,7 @@ struct udp_sock {
 	 */
 	__u16		 len;		/* total length of pending frames */
 	__u16		 gso_size;
-	/*
-	 * Fields specific to UDP-Lite.
-	 */
-	__u16		 pcslen;
-	__u16		 pcrlen;
+
 	/*
 	 * For encapsulation sockets.
 	 */
@@ -236,8 +230,6 @@ static inline void udp_allow_gso(struct sock *sk)
 	hlist_nulls_for_each_entry_rcu(__up, node, list, udp_lrpa_node)
 #endif
 
-#define IS_UDPLITE(__sk) (unlikely(__sk->sk_protocol == IPPROTO_UDPLITE))
-
 static inline struct sock *udp_tunnel_sk(const struct net *net, bool is_ipv6)
 {
 #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
diff --git a/include/net/udplite.h b/include/net/udplite.h
deleted file mode 100644
index 6bfa1d6833d1..000000000000
--- a/include/net/udplite.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *	Definitions for the UDP-Lite (RFC 3828) code.
- */
-#ifndef _UDPLITE_H
-#define _UDPLITE_H
-
-#include <net/ip6_checksum.h>
-#include <net/udp.h>
-
-/* UDP-Lite socket options */
-#define UDPLITE_SEND_CSCOV   10 /* sender partial coverage (as sent)      */
-#define UDPLITE_RECV_CSCOV   11 /* receiver partial coverage (threshold ) */
-
-#endif	/* _UDPLITE_H */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index edca3e430305..877fb02df8fb 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -29,6 +29,8 @@ struct udphdr {
 
 /* UDP socket options */
 #define UDP_CORK	1	/* Never send partially complete segments */
+/* Deprecated, reserved for UDPLITE_SEND_CSCOV 10 */
+/* Deprecated, reserved for UDPLITE_RECV_CSCOV 11 */
 #define UDP_ENCAP	100	/* Set the socket to accept encapsulated packets */
 #define UDP_NO_CHECK6_TX 101	/* Disable sending checksum for UDP6X */
 #define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9a2c8ff96e83..d47ca721ef0d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -117,7 +117,6 @@
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
-#include <net/udplite.h>
 #include <net/gro.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
@@ -2924,7 +2923,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	struct udp_sock *up = udp_sk(sk);
 	int val, valbool;
 	int err = 0;
-	int is_udplite = IS_UDPLITE(sk);
 
 	if (level == SOL_SOCKET) {
 		err = sk_setsockopt(sk, level, optname, optval, optlen);
@@ -3011,36 +3009,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		sockopt_release_sock(sk);
 		break;
 
-	/*
-	 * 	UDP-Lite's partial checksum coverage (RFC 3828).
-	 */
-	/* The sender sets actual checksum coverage length via this option.
-	 * The case coverage > packet length is handled by send module. */
-	case UDPLITE_SEND_CSCOV:
-		if (!is_udplite)         /* Disable the option on UDP sockets */
-			return -ENOPROTOOPT;
-		if (val != 0 && val < 8) /* Illegal coverage: use default (8) */
-			val = 8;
-		else if (val > USHRT_MAX)
-			val = USHRT_MAX;
-		WRITE_ONCE(up->pcslen, val);
-		udp_set_bit(UDPLITE_SEND_CC, sk);
-		break;
-
-	/* The receiver specifies a minimum checksum coverage value. To make
-	 * sense, this should be set to at least 8 (as done below). If zero is
-	 * used, this again means full checksum coverage.                     */
-	case UDPLITE_RECV_CSCOV:
-		if (!is_udplite)         /* Disable the option on UDP sockets */
-			return -ENOPROTOOPT;
-		if (val != 0 && val < 8) /* Avoid silly minimal values.       */
-			val = 8;
-		else if (val > USHRT_MAX)
-			val = USHRT_MAX;
-		WRITE_ONCE(up->pcrlen, val);
-		udp_set_bit(UDPLITE_RECV_CC, sk);
-		break;
-
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -3053,7 +3021,7 @@ EXPORT_IPV6_MOD(udp_lib_setsockopt);
 static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 			  unsigned int optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
+	if (level == SOL_UDP || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
 					  optval, optlen,
 					  udp_push_pending_frames);
@@ -3099,16 +3067,6 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		val = udp_test_bit(GRO_ENABLED, sk);
 		break;
 
-	/* The following two cannot be changed on UDP sockets, the return is
-	 * always 0 (which corresponds to the full checksum coverage of UDP). */
-	case UDPLITE_SEND_CSCOV:
-		val = READ_ONCE(up->pcslen);
-		break;
-
-	case UDPLITE_RECV_CSCOV:
-		val = READ_ONCE(up->pcrlen);
-		break;
-
 	default:
 		return -ENOPROTOOPT;
 	}
@@ -3124,7 +3082,7 @@ EXPORT_IPV6_MOD(udp_lib_getsockopt);
 static int udp_getsockopt(struct sock *sk, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+	if (level == SOL_UDP)
 		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
 	return ip_getsockopt(sk, level, optname, optval, optlen);
 }
diff --git a/net/ipv6/ip6_checksum.c b/net/ipv6/ip6_checksum.c
index 8bb68a0cdfd6..e1a594873675 100644
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/ip.h>
+#include <net/ip6_checksum.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <asm/checksum.h>
 
 #ifndef _HAVE_ARCH_IPV6_CSUM
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 511e3f898be5..c3d8b5ede164 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -58,7 +58,6 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <trace/events/skb.h>
-#include <net/udplite.h>
 
 static void udpv6_destruct_sock(struct sock *sk)
 {
@@ -1831,7 +1830,7 @@ static void udpv6_destroy_sock(struct sock *sk)
 static int udpv6_setsockopt(struct sock *sk, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
+	if (level == SOL_UDP || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
 					  optval, optlen,
 					  udp_v6_push_pending_frames);
@@ -1841,7 +1840,7 @@ static int udpv6_setsockopt(struct sock *sk, int level, int optname,
 static int udpv6_getsockopt(struct sock *sk, int level, int optname,
 			    char __user *optval, int __user *optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE)
+	if (level == SOL_UDP)
 		return udp_lib_getsockopt(sk, level, optname, optval, optlen);
 	return ipv6_getsockopt(sk, level, optname, optval, optlen);
 }
-- 
2.53.0.473.g4a7958ca14-goog


