Return-Path: <netdev+bounces-264021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKreK5KIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFA820717F
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2145C3043DD3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814A3DEAC5;
	Wed,  4 Mar 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLlwE2iE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BC3DEAFC
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652654; cv=none; b=bLhI2g2wG61xk6mOUu84DlPA4/qFJ7ksH0iGDXFbgBicIoixmHzseDJPcsf7YZFgUpnh+v5G3zBnHdzKfrz1vlGvrBbcpEfpsZ3j8mC1RVjY3D7SYFT996tqDy5VmD9F2/jFD3xr8amTLZEFn+TJFyMRlrr9wb/cd6athhqD7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652654; c=relaxed/simple;
	bh=VccWe4tKtDZxFHhVL+6lo7WZkIKEy/CA9vkVwIAsdDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aWYTq1Yr2asrtkn0SeqvHJwTK+b7zP+D5IQUFP20v2SqKyuyOCNZhW/Fs29Jd0nxFoi19OTq0DgyJCz8G0U5suCzoPEpY9tclWSv2o9zrnEUIqHYqWbNZPlWHRAbRJPdF7LmJmiRwretPm72n7QwTTBT7Qe76AGanjsGjvkdGUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLlwE2iE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3597b55adebso3011335a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652652; x=1773257452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpajGYwX/MKRrYR1Oy5EOh+uOcFXngvYm11OoxsrJ9A=;
        b=iLlwE2iEhfTwLxKEOvcCUPpiSarhSQZF1RZk6siqkEizsr5F9PV33LztFsYU29ZtlX
         vMXm8IzYrgIELh4IG23o6zEBt/PnfoMm8NcjzEmLc0UvogAMz8To3YWdxqGR8yk4bIiA
         SL+KaLHdOzgl20UWDBC9L1atvkLGxFArbhh2YEOMLCFkDzeCpUrXQjI5203IILNAkWb3
         zojG7zR7z6VmxUDtdIkUTpKAINDktcHZ+Nu1f1aiDRNoTK/QEkZgWrlEq9XMCPs+aAdD
         2N+rdaoGqZQ6aMSF5TtTzLaSD5VsUwGs4naMvfIpiHumbwHUtggtySlAv58/suGKROtO
         1X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652652; x=1773257452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpajGYwX/MKRrYR1Oy5EOh+uOcFXngvYm11OoxsrJ9A=;
        b=wYArFw/7cw9lAXguoWWRiqqmBxos5w4Yox4s0Mf5Y6T7ePLMhKkx2bfUfBpFH++jby
         F3oepp4ySDWmfkzdvzI96g24X/iJ2h24oo+FQd12DqY9MxTsukXDb6CIrdsMi7ZPdlhG
         criyEza1zjfbl8TccGEFHvbMvDjwFgn/W7FUlCQa8J8MivrcvsdHJIqdhl/40tINna5s
         ZbxlmU/pq39nXXWr1V0r4dIOD+qktYlm9qlXVnLfKMPFWRd+fWJMiD+JF1dufXJivPfm
         OLPSnzHCqpD138U71FRRn4z6zPpPKseKFatJeqJbXnROi5dYHKnz3UCWz8DIw/f+xFu+
         jecg==
X-Forwarded-Encrypted: i=1; AJvYcCUSGZ36iwBOhpafHLZ1lSMoAMpu3OzAwleRdNnlp2rStk+4NXv96UFszaUx9HWj/XAn1zdlMFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3pw9dmT1cXKORRZY7ejrlQTIzJC8wlwrZIUeJm9RhkN3SoYd
	vJ0tXpNJHW4bpMMMYwkgEEdSao+rAueYChHo/PAF+7Ng+6j3L5aLE/6OPldqV936yzMySGd6svw
	ef+UO3g==
X-Received: from pjbph12.prod.google.com ([2002:a17:90b:3bcc:b0:359:92b5:da6a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5630:b0:34c:fe7e:84fe
 with SMTP id 98e67ed59e1d1-359a6a6433fmr2454120a91.28.1772652651993; Wed, 04
 Mar 2026 11:30:51 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:40 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/15] udp: Remove UDPLITE_SEND_CSCOV and UDPLITE_RECV_CSCOV.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4FFA820717F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264021-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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
---
 include/linux/udp.h      | 10 +--------
 include/net/udplite.h    | 15 -------------
 include/uapi/linux/udp.h |  1 +
 net/ipv4/udp.c           | 46 ++--------------------------------------
 net/ipv6/ip6_checksum.c  |  2 +-
 net/ipv6/udp.c           |  5 ++---
 6 files changed, 7 insertions(+), 72 deletions(-)
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
index edca3e430305..195041ffb7d8 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -29,6 +29,7 @@ struct udphdr {
 
 /* UDP socket options */
 #define UDP_CORK	1	/* Never send partially complete segments */
+/* Don't use 10 and 11 */
 #define UDP_ENCAP	100	/* Set the socket to accept encapsulated packets */
 #define UDP_NO_CHECK6_TX 101	/* Disable sending checksum for UDP6X */
 #define UDP_NO_CHECK6_RX 102	/* Disable accepting checksum for UDP6 */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index efdab50a58a0..4174a302eeea 100644
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
@@ -2917,7 +2916,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	struct udp_sock *up = udp_sk(sk);
 	int val, valbool;
 	int err = 0;
-	int is_udplite = IS_UDPLITE(sk);
 
 	if (level == SOL_SOCKET) {
 		err = sk_setsockopt(sk, level, optname, optval, optlen);
@@ -3004,36 +3002,6 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
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
@@ -3046,7 +3014,7 @@ EXPORT_IPV6_MOD(udp_lib_setsockopt);
 static int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 			  unsigned int optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
+	if (level == SOL_UDP || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
 					  optval, optlen,
 					  udp_push_pending_frames);
@@ -3092,16 +3060,6 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
@@ -3117,7 +3075,7 @@ EXPORT_IPV6_MOD(udp_lib_getsockopt);
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
index 402b3b821480..49c315d0154d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -58,7 +58,6 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <trace/events/skb.h>
-#include <net/udplite.h>
 
 static void udpv6_destruct_sock(struct sock *sk)
 {
@@ -1832,7 +1831,7 @@ static void udpv6_destroy_sock(struct sock *sk)
 static int udpv6_setsockopt(struct sock *sk, int level, int optname,
 			    sockptr_t optval, unsigned int optlen)
 {
-	if (level == SOL_UDP  ||  level == SOL_UDPLITE || level == SOL_SOCKET)
+	if (level == SOL_UDP || level == SOL_SOCKET)
 		return udp_lib_setsockopt(sk, level, optname,
 					  optval, optlen,
 					  udp_v6_push_pending_frames);
@@ -1842,7 +1841,7 @@ static int udpv6_setsockopt(struct sock *sk, int level, int optname,
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


