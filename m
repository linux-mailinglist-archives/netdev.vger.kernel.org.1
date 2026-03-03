Return-Path: <netdev+bounces-263470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCYFB+91p2nyhgAAu9opvQ
	(envelope-from <netdev+bounces-263470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:59:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCC1F8956
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C55231ADC4F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32973377EB4;
	Tue,  3 Mar 2026 23:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3JMZPPHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A130B377EA5
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582088; cv=none; b=uzVWADdG2rH6zPSeN3QsB7aBjqNXzPg/F7IU0O05UVjCIjm5T3Y3RMOhxLuk9WaVFdDDG+S17vCu16MCknNIn5Ef3I5g4SHX4f0oEuR7F+s/ZSAe4tdBJLckF1EwDa4gO05uvBDMsRCUeRU1EUFDoo5D6q0ZDUcFQvFiLoOvNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582088; c=relaxed/simple;
	bh=znaV1IxTuY8QCUBPw1fUswYq7X56ui78KZeTLH2KRtU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ryf8kqkJUCWJhfUtUxeMPTA02zVcpZxS+ZUDxRTNd3tVXJNiDsL4tpR49So8lZWVY7hGeqqLM2BIJ5nLMsIsERDMVdfrG4CZ3+2hjXDn3LSilWBKglWYeXTZu5geQIvu4a0hU2TcD5JrvEIkNeTjERXC9gU+IREgfUWQJPm6CCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3JMZPPHC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso5479412a91.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772582086; x=1773186886; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m29arXTzJB21iqREHhai1bFB/P4LlU5Uxmdgy6ZyOHo=;
        b=3JMZPPHC3v26F1j8QISC4Ll/y69VLfh893VWtOekv2GYRuckgZdArwesxo/EHK2ddP
         dF75f0ZA2fFeq4OfWual6vMMI7z3ymTh77FSrcxmqMMR4LJQj3BBlqLiY9yNoGRv5KMq
         CI36nrNSxRceqIbKH18bez9+K4uEuaGlnSPITZNz2pUo/7lbq+eo+2PQfKPQ3VtzlkDa
         Ywdk/+ub8cis3ckpeaeIQ6DHGPTyeYn2u/vdWVGzOVvegLQpX/vQAZeNjyO2dG9eJjbY
         p3UfKipPmv+ieL1pd667i+9q/YooRdS1OZyyiyYC/c7fJ/PtSXhNWA6wOJ6Nv8w1DsVL
         B1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772582086; x=1773186886;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m29arXTzJB21iqREHhai1bFB/P4LlU5Uxmdgy6ZyOHo=;
        b=CGq+pvfkPUp67WkzPA+FvtLNbW0i3YZKBTIEGGIkpIaItuMKncrdJ/k8PI/U8ywjJb
         pGUzWNcfvxaIfOHTYArxW4TmuPByhpwgGxArW6ymdVPUYJTXRnUTB8zKLMc7kgA9iNwL
         DLEShkhlz16mxlbDtn4ewZ3ElIQSysf1Zw/EiSY3UtW1rXPDSPh9aUTdDa5BOGL6bbZn
         jiWvgpdav3rKqJecVOSd25g+JL3msjgrVpj9vfqIefFWrjL/JJiNobd0O4raWibBn8Qm
         aytivlStGCYayI5s5kFK/0XyLddWmbrWvp1lQLJPzuORte+aUoIT0DRRomM7BxJS0gwC
         QTbA==
X-Forwarded-Encrypted: i=1; AJvYcCVbxlWr+gKsOvECyGaF6CzNQQXoOwCQi2tFhJgcvfaMgEBqjSn4Sl8t3AZ36AvkYfAad9ZUXTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqP8WeH+8BRqw6KR8kNor+AD4wWLXyl4S3K2IYtew7HA907eX
	Pw08gzpFm7ut1aJIMrhFi0oPwLZeM/SKn9feEizXkf2peVJHY2M10szh89YIM8WNyOaoQVgOqXY
	GjQZyYg==
X-Received: from pjbjz15.prod.google.com ([2002:a17:90b:14cf:b0:359:8b2a:66ba])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:32e:6fae:ba52
 with SMTP id 98e67ed59e1d1-359a69a21a3mr151764a91.6.1772582085757; Tue, 03
 Mar 2026 15:54:45 -0800 (PST)
Date: Tue,  3 Mar 2026 23:54:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303235424.3877267-1-kuniyu@google.com>
Subject: [PATCH v2 net-next] tcp: Initialise ehash secrets during connect()
 and listen().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8ACCC1F8956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263470-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

inet_ehashfn() and inet6_ehashfn() initialise random secrets
on the first call by net_get_random_once().

While the init part is patched out using static keys, with
CONFIG_STACKPROTECTOR_STRONG=y, this causes a compiler to
generate a stack canary due to an automatic variable,
unsigned long ___flags, in the DO_ONCE() macro being passed
to __do_once_start().

With FDO, this is visible in __inet_lookup_established() and
__inet6_lookup_established() too.

Let's initialise the secrets by get_random_sleepable_once()
in the slow paths: inet_hash() for listen(), and
inet_hash_connect() and inet6_hash_connect() for connect().

Note that IPv6 listener will initialise both IPv4 & IPv6 secrets
in inet_hash() for IPv4-mapped IPv6 address.

With the patch, the stack size is reduced by 16 bytes (___flags
 + a stack canary) and NOPs for the static key go away.

Before: __inet6_lookup_established()

       ...
       push   %rbx
       sub    $0x38,%rsp                # stack is 56 bytes
       mov    %edx,%ebx                 # sport
       mov    %gs:0x299419f(%rip),%rax  # load stack canary
       mov    %rax,0x30(%rsp)              and store it onto stack
       mov    0x440(%rdi),%r15          # net->ipv4.tcp_death_row.hashinfo
       nop
 32:   mov    %r8d,%ebp                 # hnum
       shl    $0x10,%ebp                # hnum << 16
       nop
 3d:   mov    0x70(%rsp),%r14d          # sdif
       or     %ebx,%ebp                 # INET_COMBINED_PORTS(sport, hnum)
       mov    0x11a8382(%rip),%eax      # inet6_ehashfn() ...

After: __inet6_lookup_established()

       ...
       push   %rbx
       sub    $0x28,%rsp                # stack is 40 bytes
       mov    0x60(%rsp),%ebp           # sdif
       mov    %r8d,%r14d                # hnum
       shl    $0x10,%r14d               # hnum << 16
       or     %edx,%r14d                # INET_COMBINED_PORTS(sport, hnum)
       mov    0x440(%rdi),%rax          # net->ipv4.tcp_death_row.hashinfo
       mov    0x1194f09(%rip),%r10d     # inet6_ehashfn() ...

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use get_random_sleepable_once()
v1: https://lore.kernel.org/netdev/20260302205156.1213225-1-kuniyu@google.com/
---
 include/linux/net.h            |  2 ++
 include/net/inet6_hashtables.h |  2 ++
 net/ipv4/inet_hashtables.c     | 17 +++++++++++++++--
 net/ipv6/inet6_hashtables.c    | 13 ++++++++++---
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index f58b38ab37f8..a8e818de95b3 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -304,6 +304,8 @@ do {									\
 
 #define net_get_random_once(buf, nbytes)			\
 	get_random_once((buf), (nbytes))
+#define net_get_random_sleepable_once(buf, nbytes)		\
+	get_random_sleepable_once((buf), (nbytes))
 
 /*
  * E.g. XFS meta- & log-data is in slab pages, or bcache meta
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 282e29237d93..c17e0d874808 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -24,6 +24,8 @@
 
 struct inet_hashinfo;
 
+void inet6_init_ehash_secret(void);
+
 static inline unsigned int __inet6_ehashfn(const u32 lhash,
 				    const u16 lport,
 				    const u32 fhash,
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 52847950b28a..164e181e9f52 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -30,12 +30,16 @@
 #include <net/sock_reuseport.h>
 #include <net/tcp.h>
 
+static void inet_init_ehash_secret(void)
+{
+	net_get_random_sleepable_once(&inet_ehash_secret,
+				      sizeof(inet_ehash_secret));
+}
+
 u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 		 const __u16 lport, const __be32 faddr,
 		 const __be16 fport)
 {
-	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
-
 	return lport + __inet_ehashfn(laddr, 0, faddr, fport,
 				      inet_ehash_secret + net_hash_mix(net));
 }
@@ -793,6 +797,13 @@ int inet_hash(struct sock *sk)
 		local_bh_enable();
 		return 0;
 	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6)
+		inet6_init_ehash_secret();
+#endif
+	inet_init_ehash_secret();
+
 	WARN_ON(!sk_unhashed(sk));
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
@@ -1239,6 +1250,8 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet_sk_port_offset(sk);
 
+	inet_init_ehash_secret();
+
 	hash_port0 = inet_ehashfn(net, inet->inet_rcv_saddr, 0,
 				  inet->inet_daddr, inet->inet_dport);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 5e1da088d8e1..a0e5a8812614 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -23,15 +23,20 @@
 #include <net/sock_reuseport.h>
 #include <net/tcp.h>
 
+void inet6_init_ehash_secret(void)
+{
+	net_get_random_sleepable_once(&inet6_ehash_secret,
+				      sizeof(inet6_ehash_secret));
+	net_get_random_sleepable_once(&tcp_ipv6_hash_secret,
+				      sizeof(tcp_ipv6_hash_secret));
+}
+
 u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
 		  const struct in6_addr *faddr, const __be16 fport)
 {
 	u32 lhash, fhash;
 
-	net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secret));
-	net_get_random_once(&tcp_ipv6_hash_secret, sizeof(tcp_ipv6_hash_secret));
-
 	lhash = (__force u32)laddr->s6_addr32[3];
 	fhash = __ipv6_addr_jhash(faddr, tcp_ipv6_hash_secret);
 
@@ -362,6 +367,8 @@ int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet6_sk_port_offset(sk);
 
+	inet6_init_ehash_secret();
+
 	hash_port0 = inet6_ehashfn(net, daddr, 0, saddr, inet->inet_dport);
 
 	return __inet_hash_connect(death_row, sk, port_offset, hash_port0,
-- 
2.53.0.473.g4a7958ca14-goog


