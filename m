Return-Path: <netdev+bounces-190668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68BAB837D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B6169045
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3D20B7FB;
	Thu, 15 May 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+yo7qNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3F18DB37
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303438; cv=none; b=oZmFHs/OvAUvmyUTvZxgWuI5EutryVkJTdsBwtxIrIVNMn7/4pf7BUG6lrZY+mdr8bGxBER5ZnkMJy67Zl+eSgMsFlCKTmNsUsO/ycFCmT2u90y/hl5l/mQ+DFrkjUY7uBZKFQqu531bQ4k6/CHMzC0crnvuhMe5i1qMmHQzCnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303438; c=relaxed/simple;
	bh=dlqEUTpJCZWaVUS+7t4dkGH0Wc1GVH4dYnUHVIMArQ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f361v3vRSG8RhG/F6XhcaFTPXEb1x8q0GWaSKvBBdL4voo5epJMC+bvrdSkjqkK7rzIvzKz1OG28Nn7Gy5ZGbbNTkXRlIlVaFfZEfZnTZQN6t41dAEErmkaSMymV8R63yt3IDZP+c0XFzqVngVQTPhtpVOYTvvf8lF/2oBn1WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+yo7qNJ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-476753132a8so7140361cf.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747303436; x=1747908236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R60PgnRqqoPYovETI12qVXUvx5mUfmV+YweplhjY7X8=;
        b=N+yo7qNJ+io0fpW/eXyR2a3uUFwXnPkdsO5u6ASkUJCiFGuY6Amew4Jwmb6qPRoJAq
         Q26+qVcnTQz43BiaOTQMR+BD7nH7O4Y1TLI9p5en/tPyzL/IbbksxMm1vUhT411Qb5uU
         mEAr7j1xa97WqveF6ZKzaxrsfp0PSwSXlcqGruDzSasND/L718J8rzEH7Yo6KFfapYZd
         CRTeCa7ZJbXbjzggdGnoFXCXRSzP+CcWLCCgK3LhMUipsVDKZ/XGA/dDTRkd/cYuOWXb
         ILHK8wK/gDqf6ZKs+pgR24/x2HCIBCvdxYmRZe8j+9aeQuHBXWqw7MKw9Uc7BiU9xoDr
         WhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747303436; x=1747908236;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R60PgnRqqoPYovETI12qVXUvx5mUfmV+YweplhjY7X8=;
        b=s78wVIQXhyt6Tv8QDUiDOh6XSMqGvfXca80Y1gvuUK6LK3S7dyV83bfgLk9eC0TCY7
         Mnd+5yISKArvmjEvJ631pOjZIyP2fU/luyGrRJ5C7fmy3wo9IjIzOe9giyL7ohkMxCub
         gCVsMXEFG+2NBLEy9qCKJUhM/UB48sdcnG9+K0po5vCkuGnO2zY39h/sGpuQovGunINE
         nFgdj/SUaWxWA4WD/22PpyrM5g5q0ldFm+ZDrl9OCiJESncY+QTG3yKr7utW5zJ09TxH
         qPJc9Hz0T/htObErf2k43JR2OfRMTTC/3WrUOxqri01SWsPgVNpKExnphCl3H8o2y5c2
         3ORg==
X-Forwarded-Encrypted: i=1; AJvYcCWIS5JfsAwNrzJn1WgHE+/0geT4Si6K2uJeYhvOhA+vGpJcBwx/8OXRXOWwztZWQb5h1X9Hy5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DUQPx696eWKJnJvJuOub0FJPNZkw8PG02q9TbQjiXJTTLC+N
	twPO9K33VLr+PMsktSyLUb5HBhiZVmJvBEQ7Q3eYzewh5FfsoVKMoq8TULGaVuypVNtVASpMTJs
	nYG6rLNjwFA==
X-Google-Smtp-Source: AGHT+IHSUovKXji+KhlkDpNGcstahA4r4pSrE11lQLkR0I6KExUtwEMPokhShpHqL/yV+x/U6jWzGvXp3xBORw==
X-Received: from qtbfc26.prod.google.com ([2002:a05:622a:489a:b0:47a:e63b:ec36])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1247:b0:476:8d3d:adb6 with SMTP id d75a77b69052e-49495c99400mr134651461cf.23.1747303436033;
 Thu, 15 May 2025 03:03:56 -0700 (PDT)
Date: Thu, 15 May 2025 10:03:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250515100354.3339920-1-edumazet@google.com>
Subject: [PATCH net-next] net: rfs: add sock_rps_delete_flow() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

RFS can exhibit lower performance for workloads using short-lived
flows and a small set of 4-tuple.

This is often the case for load-testers, using a pair of hosts,
if the server has a single listener port.

Typical use case :

Server : tcp_crr -T128 -F1000 -6 -U -l30 -R 14250
Client : tcp_crr -T128 -F1000 -6 -U -l30 -c -H server | grep local_throughput

This is because RFS global hash table contains stale information,
when the same RSS key is recycled for another socket and another cpu.

Make sure to undo the changes and go back to initial state when
a flow is disconnected.

Performance of the above test is increased by 22 %,
going from 372604 transactions per second to 457773.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Octavian Purdila <tavip@google.com>
---
 include/net/rps.h          | 24 ++++++++++++++++++++++++
 net/ipv4/inet_hashtables.c |  6 ++++--
 net/ipv4/udp.c             |  2 ++
 net/sctp/socket.c          |  2 +-
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index 507f4aa5d39b296e65668969a13e5732738bf531..d8ab3a08bcc4882e2ad9c84c22ef26b254c14680 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -123,6 +123,30 @@ static inline void sock_rps_record_flow(const struct sock *sk)
 #endif
 }
 
+static inline void sock_rps_delete_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	struct rps_sock_flow_table *table;
+	u32 hash, index;
+
+	if (!static_branch_unlikely(&rfs_needed))
+		return;
+
+	hash = READ_ONCE(sk->sk_rxhash);
+	if (!hash)
+		return;
+
+	rcu_read_lock();
+	table = rcu_dereference(net_hotdata.rps_sock_flow_table);
+	if (table) {
+		index = hash & table->mask;
+		if (READ_ONCE(table->ents[index]) != RPS_NO_CPU)
+			WRITE_ONCE(table->ents[index], RPS_NO_CPU);
+	}
+	rcu_read_unlock();
+#endif
+}
+
 static inline u32 rps_input_queue_tail_incr(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index da85cc30e3824ad2b0cd115854521657928eca07..77a0b52b2eabfc6b08c34acea9fda092b88a32b5 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -23,11 +23,12 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/inet6_hashtables.h>
 #endif
-#include <net/secure_seq.h>
 #include <net/hotdata.h>
 #include <net/ip.h>
-#include <net/tcp.h>
+#include <net/rps.h>
+#include <net/secure_seq.h>
 #include <net/sock_reuseport.h>
+#include <net/tcp.h>
 
 u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 		 const __u16 lport, const __be32 faddr,
@@ -790,6 +791,7 @@ void inet_unhash(struct sock *sk)
 	if (sk_unhashed(sk))
 		return;
 
+	sock_rps_delete_flow(sk);
 	if (sk->sk_state == TCP_LISTEN) {
 		struct inet_listen_hashbucket *ilb2;
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 358b49caa7b974ddef70da8482f8a35fdb003fa9..dde52b8050b8ca251ae13f20853c6c9512453dd0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -120,6 +120,7 @@
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
+#include <net/rps.h>
 
 struct udp_table udp_table __read_mostly;
 
@@ -2200,6 +2201,7 @@ void udp_lib_unhash(struct sock *sk)
 		struct udp_table *udptable = udp_get_table_prot(sk);
 		struct udp_hslot *hslot, *hslot2;
 
+		sock_rps_delete_flow(sk);
 		hslot  = udp_hashslot(udptable, sock_net(sk),
 				      udp_sk(sk)->udp_port_hash);
 		hslot2 = udp_hashslot2(udptable, udp_sk(sk)->udp_portaddr_hash);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 53725ee7ba06d780e220c3a184b4f611a7cb5e51..85a9dfeff4d6a5508ce77720b34180bc971ce396 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8321,7 +8321,7 @@ static int sctp_hash(struct sock *sk)
 
 static void sctp_unhash(struct sock *sk)
 {
-	/* STUB */
+	sock_rps_delete_flow(sk);
 }
 
 /* Check if port is acceptable.  Possibly find first available port.
-- 
2.49.0.1101.gccaa498523-goog


