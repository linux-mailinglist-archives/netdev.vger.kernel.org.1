Return-Path: <netdev+bounces-201542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5DAE9D26
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE68A4E1694
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8682750F2;
	Thu, 26 Jun 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="booc0QMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91664275870
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939374; cv=none; b=k0fmVq5Poy8qwI/mX4P2Mt80Kq3Jo52+WOeD2m2qzU0U/jrysMPLcdb3HzWM2vA2VW/5YIbowl/0j69BVLPQcIJajuHL7xvPZ9uddVFho5CFUowvNOnyJZu3qlL0tRn9Tgem/a4NuqZVqgz6DNUvj6zlvMUPNxpk3Nxw8ZcOBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939374; c=relaxed/simple;
	bh=OoaYetzLsk/ixT7uTBn93jRdEPsGX/c37xPT+qfJnNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dw56EhK8Up5uA9/fmm8uN/fm+spJALxjoxk+Qb4TEwQq2kBVEYCEThNTJ2rg3CTnFyUnRhwW/c+VgxFOJNE8xQ6FYLa9ts11qb9oXktXqbhLO9J+zUSkWvrzxNbEMcHY0c6M/puHJ4SdjJqaoVMLVELdm8mZx1Ogg354V/ugQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=booc0QMO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo1551554a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1750939371; x=1751544171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPZod26xdrwSg0JHSjFcwADbrEM4abF1QqdrVkXLPYs=;
        b=booc0QMO9dHWmBVeYRReRcR0IyqZrZ8mZurho+FM8EWSzlBM7o0wibVlG1znIO0JhL
         bCm/mCiBejMsTvQgbA9LRXoUnx1gAoAB5A1N6nWXSheyRRs0R+rguWiiF4Gn5JQyQWE2
         eBTdndbjqAbocFOqi0zbZ3o/HNPHzynOxdVX5sNyvJDeLM502wC3NZAUoQVV1jNLo5hQ
         plyPt9kmNQclxu5JOJE6L8algzpfwHbmxbr0Iv67kuNIfUw6+AgoaKBYlv/zT37Zprbr
         Q26iM6e2Yu89cNs2GzEJt8mux39JvZG4mR/6OgeYlOQ6ceSDlz51vy7mjsBljTwYXSYU
         PzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750939371; x=1751544171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPZod26xdrwSg0JHSjFcwADbrEM4abF1QqdrVkXLPYs=;
        b=EVfpXgBd+JTXuEcaue9cif0X1fQKlro5y38vYDAroqDBCMqLCIdzgz+8J/MnKUw/xV
         8iNNe9JWMewn7acAnc0zrvqABsBukQ/l+VYGmUy1FDf5CQin3O+7Ra/0V09muz4fTwiy
         5bApRXx69xnV2oW6X9fkN5XBkrfPzUFoWG6o+GPkDB6TcBp09iJ98uxJd8/dTvXRBvh6
         LfuYaRWxyO0EJHKfHE6QWcQl0tSyAJMQ87Le8T2dRyytvPOdHlQt5Sp0CeblCNbomTVz
         HLF3WKTHD1feFq5JpLAKlcLFe6HrMswfUGbd8OIEWmQSMwLCPkMd51q9DYhJ24w6fzr/
         G+4g==
X-Gm-Message-State: AOJu0YzIsp+2ppn1m8zSDifF4ReopopNdUgQjYINc93wmY/2x7RABGs8
	q2pZZlA5HUUkGcWFPUNTOMDff0vZ9e9j6wEfwmcv4yYAbVAPoIwJ7WEzQlWLjh8rjLA=
X-Gm-Gg: ASbGncvtBu/s3tTXk7Jp5xgI8BJE4t1rrLOlNiAybcbA64uclRUO3udY7WDkOSXCrpj
	5QOZRLGu+WaT8ChuqXVxCurMycYCG1K7pE5o4Uy+i757QTt7mVpM5r275u1aKIMJitnbsOy23sP
	8BGJc4QjLQjvgVMSn7d9O99C3LKUlG17d5UzGmnr7X+3iX/QzqWSTmT3DrHHapyfOv6BE1otzTV
	bDILSMp3msIQ/q4cxibVO6t5coKlDkFGF6Ypqs0UKKQR6GGsLGxxvufUhhHmdwhrBxc3tbG/Phi
	XnEpSk8KCEvv9L/XrDJ7Rjz/DFb/bdIDSq6e6SpiswzSU1MPm2QYs/Kz7Nyq5tOR3w==
X-Google-Smtp-Source: AGHT+IFJx1a8bTwCfSOh+QbP97MydXU4wz/EBNPWOq/orj4ZmIG8Ho/aZzgiR3chpnkHrjcSKpbBUg==
X-Received: by 2002:a17:907:3ccb:b0:ae0:ba0f:85af with SMTP id a640c23a62f3a-ae0bef85edamr653094966b.51.1750939370543;
        Thu, 26 Jun 2025 05:02:50 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0d4ed7306sm130757966b.120.2025.06.26.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 05:02:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: [PATCH net-next 1/2] tcp: Consider every port when connecting with IP_LOCAL_PORT_RANGE
Date: Thu, 26 Jun 2025 14:02:45 +0200
Message-ID: <20250626120247.1255223-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Situation
---------

We observe the following scenario in production:

                                                  inet_bind_bucket
                                                state for port 54321
                                                --------------------

                                                (bucket doesn't exist)

// Process A opens a long-lived connection:
s1 = socket(AF_INET, SOCK_STREAM)
s1.setsockopt(IP_BIND_ADDRESS_NO_PORT)
s1.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
s1.bind(192.0.2.10, 0)
s1.connect(192.51.100.1, 443)
                                                tb->reuse = -1
                                                tb->reuseport = -1
s1.getsockname() -> 192.0.2.10:54321
s1.send()
s1.recv()
// ... s1 stays open.

// Process B opens a short-lived connection:
s2 = socket(AF_INET, SOCK_STREAM)
s2.setsockopt(SO_REUSEADDR)
s2.bind(192.0.2.20, 0)
                                                tb->reuse = 0
                                                tb->reuseport = 0
s2.connect(192.51.100.2, 53)
s2.getsockname() -> 192.0.2.20:54321
s2.send()
s2.recv()
s2.close()

                                                // bucket remains in this
                                                // state even though port
                                                // was released by s2
                                                tb->reuse = 0
                                                tb->reuseport = 0

// Process A attempts to open another connection
// when there is connection pressure from
// 192.0.2.30:54000..54500 to 192.51.100.1:443.
// Assume only port 54321 is still available.

s3 = socket(AF_INET, SOCK_STREAM)
s3.setsockopt(IP_BIND_ADDRESS_NO_PORT)
s3.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
s3.bind(192.0.2.30, 0)
s3.connect(192.51.100.1, 443) -> EADDRNOTAVAIL (99)

Problem
-------

We end up in a state where Process A can't reuse ephemeral port 54321 for
as long as there are sockets, like s1, that keep the bind bucket alive. The
bucket does not return to "reusable" state even when all sockets which
blocked it from reuse, like s2, are gone.

The ephemeral port becomes available for use again only after all sockets
bound to it are gone and the bind bucket is destroyed.

Programs which behave like Process B in this scenario - that is, binding to
an IP address without setting IP_BIND_ADDRESS_NO_PORT - might be considered
poorly written. However, the reality is that such implementation is not
actually uncommon. Trying to fix each and every such program is like
playing whack-a-mole.

For instance, it could be any software using Golang's net.Dialer with
LocalAddr provided:

        dialer := &net.Dialer{
                LocalAddr: &net.TCPAddr{IP: srcIP},
        }
        conn, err := dialer.Dial("tcp4", dialTarget)

Or even a ubiquitous tool like dig when using a specific local address:

        $ dig -b 127.1.1.1 +tcp +short example.com

Hence, we are proposing a systematic fix in the network stack itself.

Solution
--------

If there is no IP address conflict with any socket bound to a given local
port, then from the protocol's perspective, the port can be safely shared.

With that in mind, modify the port search during connect(), that is
__inet_hash_connect, to consider all bind buckets (ports) when looking for
a local port for egress.

To achieve this, add an extra walk over bhash2 buckets for the port to
check for IP conflicts. The additional walk is not free, so perform it only
once per port - during the second phase of conflict checking, when the
bhash bucket is locked.

We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
option is set. The rationale is that users are likely to care about using
every possible local port only when they have deliberately constrained the
ephemeral port range.

Limitations
-----------

Sharing both the local IP and port with other established sockets, when the
remote address is unique is still not possible if the bucket is in
non-reusable state (tb->{fastreuse,fastreuseport} >= 0) because of a socket
explicitly bound to that port.

Alternatives
------------

* Update bind bucket state on port release

A valid solution to the described problem would also be to walk the bind
bucket owners when releasing the port and recalculate the
tb->{reuse,reuseport} state.

However, in comparison to the proposed solution, this alone would not allow
sharing the local port with other sockets bound to non-conflicting IPs for
as long as they exist.

Another downside is that we'd pay the extra cost on each unbind (more
frequent) rather than only when connecting with IP_LOCAL_PORT_RANGE
set (less frequent). Due to that we would also likely need to guard it
behind a sysctl (see below).

* Run your service in a dedicated netns

This would also solve the problem. While we don't rule out transitioning to
this setup in the future at a cost of shifting the complexity elsewhere.

Isolating your service in a netns requires assigning it dedicated IPs for
egress. If the egress IPs must be shared with other processes, as in our
case, then SNAT and connection tracking on egress are required - adding
complexity.

* Guard it behind a sysctl setting instead of a socket option

Users are unlikely to encounter this problem unless their workload connects
from a severely narrowed-down ephemeral port range. Hence, paying the bind
bucket walk cost for each connect() call doesn't seem sensible. Whereas
with a socket option, only a limited set of connections incur the
performance overhead.

Reported-by: Lee Valentine <lvalentine@cloudflare.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
To: Eric Dumazet <edumazet@google.com>
To: Paolo Abeni <pabeni@redhat.com>
To: David S. Miller <davem@davemloft.net>
To: Jakub Kicinski <kuba@kernel.org>
To: Neal Cardwell <ncardwell@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com
---
 net/ipv4/inet_hashtables.c | 45 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 77a0b52b2eab..7f0819f53982 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1005,6 +1005,42 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
 #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
 static u32 *table_perturb;
 
+/* True on source address conflict with another socket. False otherwise.
+ * Caller must hold hashbucket lock for this tb.
+ */
+static inline bool check_bound(const struct sock *sk,
+			       const struct inet_bind_bucket *tb)
+{
+	const struct inet_bind2_bucket *tb2;
+	const struct sock *sk2;
+
+	hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (sk->sk_family == AF_INET6) {
+			if (tb2->addr_type == IPV6_ADDR_ANY ||
+			    ipv6_addr_equal(&tb2->v6_rcv_saddr,
+					    &sk->sk_v6_rcv_saddr))
+				return true;
+			continue;
+		}
+
+		/* Check for ipv6 non-v6only wildcard sockets */
+		if (tb2->addr_type == IPV6_ADDR_ANY)
+			sk_for_each_bound(sk2, &tb2->owners)
+				if (!sk2->sk_ipv6only)
+					return true;
+
+		if (tb2->addr_type != IPV6_ADDR_MAPPED)
+			continue;
+#endif
+		if (tb2->rcv_saddr == INADDR_ANY ||
+		    tb2->rcv_saddr == sk->sk_rcv_saddr)
+			return true;
+	}
+
+	return false;
+}
+
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		struct sock *sk, u64 port_offset,
 		u32 hash_port0,
@@ -1070,6 +1106,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			if (!inet_bind_bucket_match(tb, net, port, l3mdev))
 				continue;
 			if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+				if (unlikely(local_ports))
+					break; /* optimistic assumption */
 				rcu_read_unlock();
 				goto next_port;
 			}
@@ -1088,9 +1126,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		 */
 		inet_bind_bucket_for_each(tb, &head->chain) {
 			if (inet_bind_bucket_match(tb, net, port, l3mdev)) {
-				if (tb->fastreuse >= 0 ||
-				    tb->fastreuseport >= 0)
+				if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+					if (unlikely(local_ports &&
+						     !check_bound(sk, tb)))
+						goto ok;
 					goto next_port_unlock;
+				}
 				WARN_ON(hlist_empty(&tb->bhash2));
 				if (!check_established(death_row, sk,
 						       port, &tw, false,
-- 
2.43.0


