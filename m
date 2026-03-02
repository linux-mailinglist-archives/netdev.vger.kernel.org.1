Return-Path: <netdev+bounces-262909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJR5OK0KpmkJJgAAu9opvQ
	(envelope-from <netdev+bounces-262909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:09:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A781E4E4D
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64B83335DDE6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11B3909B3;
	Mon,  2 Mar 2026 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUZAlAi3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F339099D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772484721; cv=none; b=Rw4VptYaGN1jLghC4rXK53YwjzABbUM0Mn5ShG8ym5DJ1KSH2FO1Zi0qbLSyJesipuxBYzx+F7l+HyimuJLWcW3dhnUwuGBcyT4tIdiGY2I9RhBSQUh2/ff7FjacwWZqz2/iXDcueG35tHvoOrN2pnVW6x55MyQCFax5W4advbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772484721; c=relaxed/simple;
	bh=TTYxbcPIOsZrKk1ayNmffFQIeKcHtvjQqbrKWD/zw/A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=udkPf5r/dvvlGaWOuAzJN6EiHjVyzXKNzOZ+khbNxrVfOlgQdWPPUM3JBNdWcshtLu8vAOHjx109qwdJqxjZUeQjqUAW6bLnG+DDcEBEVx/r9SFMTwaNjsK4X9F2W7YO2Dq5xNYXXIna5HEUy8gDy3VEvx44eGCdxABid3YO/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUZAlAi3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c629a3276e9so19468602a12.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772484719; x=1773089519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P3RFNbUs4nG66x1juDAqH4OtNf66gnyP4Z4EY39BTYE=;
        b=YUZAlAi3Lw5KnEyqB8pvW6BquR4HE9W7QHi9DW0jl4PTz6Zf2VB0cCr7eS7OkXw0nV
         ocZG223ilQflrDcIIcdMaHqULRHRZn7iJHCNg6gAAymMoTYYo5exi7yV7Jdlh03HWJwJ
         RMuz/3lyigjYNLQalyn0dWlUC3OS68DUwkPVCWroKFjHdpIvAOcanl5drymnD+WEzp2G
         uFvzJUxq//aOmVa1WPuLxzbrjK3wA45my8WB8eGgU+EJt78T/v2IIRm+3KN/GMmWr/Fy
         qESX1ux7lQ27TVuC7dY+SChynwmMjDiIDO5/MGrpg81RJdeOYhHcUM+iBlAMgE+06/7/
         pGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772484719; x=1773089519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3RFNbUs4nG66x1juDAqH4OtNf66gnyP4Z4EY39BTYE=;
        b=bw1NiUB2wBamFWtKbCVuoq/3l2YwbkmLLttJau7Y9hwTvXBhzB7nsox0vkVDc3Bj/5
         H2G4miXVeBIU5TVGuNa7aVxv148uJ2zq4yYv9wZEuYniHGLBO3HsAthCkk9K9zmxDJDB
         ZTSo0U6cbN41iJfLe53sN7tO37r9SyRnOFGaOfFucUmHH2XKitp35YZ2pjkEA6KNFakN
         6M/cXZ6ebxSqYY/LHAigGvzXz7VVSkGjpHbr0+yHvFNqgAXlRhXDVy3DYJq/US/HTpDs
         qO0i1sMOQAviDjsTXzC7AfBwrpeJhl+yP91UFuqwK+5wGNgDJTywJ9oT1soMOrE7493l
         +adQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyopFNxhVCbdXL05+K1w0SI9ApTN4cnnwM+5plav+wg2IajzaqPtVdNOFcv1z1ariDAjJ9z2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz45oPt6x4Uv6+upge9QkEi0U9s1RD/mI7imZXSEDQVDomq1TeK
	TPaiQ1weoL+DlqOfBm8V3lBp9+IcTljDekbu2FDmJtKTDVYJ0XNkn8khDUM+0HSsngTOsDjqNol
	K7NukVQ==
X-Received: from plge4.prod.google.com ([2002:a17:902:cf44:b0:2ae:3af2:e21])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9145:b0:394:6208:6626
 with SMTP id adf61e73a8af0-395c3a2cdb6mr13000014637.20.1772484718929; Mon, 02
 Mar 2026 12:51:58 -0800 (PST)
Date: Mon,  2 Mar 2026 20:51:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302205156.1213225-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] tcp: Initialise ehash secrets during connect()
 and listen().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 81A781E4E4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262909-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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

Let's move net_get_random_once() to the slow paths: inet_hash()
for listen(), and inet_hash_connect() and inet6_hash_connect()
for connect().

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
 include/net/inet6_hashtables.h |  2 ++
 net/ipv4/inet_hashtables.c     | 16 ++++++++++++++--
 net/ipv6/inet6_hashtables.c    | 11 ++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

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
index fca980772c81..2c2cac5b0f1a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -30,12 +30,15 @@
 #include <net/sock_reuseport.h>
 #include <net/tcp.h>
 
+static void inet_init_ehash_secret(void)
+{
+	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
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
@@ -793,6 +796,13 @@ int inet_hash(struct sock *sk)
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
 
@@ -1239,6 +1249,8 @@ int inet_hash_connect(struct inet_timewait_death_row *death_row,
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet_sk_port_offset(sk);
 
+	inet_init_ehash_secret();
+
 	hash_port0 = inet_ehashfn(net, inet->inet_rcv_saddr, 0,
 				  inet->inet_daddr, inet->inet_dport);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 5e1da088d8e1..054f75d32381 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -23,15 +23,18 @@
 #include <net/sock_reuseport.h>
 #include <net/tcp.h>
 
+void inet6_init_ehash_secret(void)
+{
+	net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secret));
+	net_get_random_once(&tcp_ipv6_hash_secret, sizeof(tcp_ipv6_hash_secret));
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
 
@@ -362,6 +365,8 @@ int inet6_hash_connect(struct inet_timewait_death_row *death_row,
 	if (!inet_sk(sk)->inet_num)
 		port_offset = inet6_sk_port_offset(sk);
 
+	inet6_init_ehash_secret();
+
 	hash_port0 = inet6_ehashfn(net, daddr, 0, saddr, inet->inet_dport);
 
 	return __inet_hash_connect(death_row, sk, port_offset, hash_port0,
-- 
2.53.0.473.g4a7958ca14-goog


