Return-Path: <netdev+bounces-203873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F47AF7D13
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1683A4EAD
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B372EFDB7;
	Thu,  3 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KIo5xhMH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6922EE993
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558384; cv=none; b=pfm589h9FLdDFhj1MUO4T4T/YeT/OpbCgPRnZSgaxXfsegXfUUc8AkLI0oJS01xaEjJ8uQNzmDwo+y7caMEN3oR7ubcLlISNXmu9/IL2TBNPdLmtGNaZuVdCiDZFYS4DVktMJgllLRpLUg/6UlhxZ87fSIzyE0j2Gr6RmkJIR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558384; c=relaxed/simple;
	bh=6kxk2igHTlPdTK8fDKj33Ji757MqjkjnBQR5tGmiSdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iZjrALPOMH07/yXbewvQLYx/hTpzHT7Z4ZT8Mb/LkrrLXZUw/5D7YRcciSBWzJ7bItLjDO7s+09TbC3MxKBI+uhLkA3/qsrQX805aENcC1P0H1PFp28K/ixTU1lQzVkhIgMKcwIsiceH/z2bZpG+R0KufcqmLsqT6F5pLkjjZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KIo5xhMH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso92677366b.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751558380; x=1752163180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JQYGXE4FXfJ+NgKoMvBi6uUET1seEImrYNryg+MH0dw=;
        b=KIo5xhMHUj2iqyR+PHXBsPFgV5G8XI735pSVlxlj2CDElGv1eGlbGr8xE96bB0JQk+
         eruFxsi/hmLzCMWlD8Or1a31Y/Ymf/Re62HcKqo5qsBI23rcxNPMSWiwT3hRLcmCze3Y
         Vaz7mvHaDWzmUeR28qIkK0Osl1K2ToXa1Mqq5w1T4W/ziVjlJmUploRlrp8Rt04t7Zw4
         Tkd0jUA5pO8aOuL7jRNPJdvuoCBwTZsw3tyg5IdUH1hKp1F1d8c29Rv21rzaMLXC6yHW
         nonTbipphfxcJIt06XyUBiex0jVx24IfbQyCZMdfJVN8nhYuAr+PbdsF0SD6vT/Y7enA
         0qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558380; x=1752163180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQYGXE4FXfJ+NgKoMvBi6uUET1seEImrYNryg+MH0dw=;
        b=tOg0gmzNh5KnmR/y7jcLov5gvAfg0IBEmNG7MYT8QBu733wEyPTbmB59Lh3IsL+HZ9
         HuMgZdY8IkZDX+q1bKTpXE2GqiDaRmwbmxCBoJmSSVAAwC1BJPHxl0RFrssVpyBvWew1
         jfoujH4ymuYiGcXkUEl+7QDr8PIUI7ENBBsKCnr01TwMX95zePokZOaagcOsBWZw8EYR
         FOut7+XnA9IUvMkACyU2qGiSqlol3pSft8IhKr4xHWd+GI4VZkGMCLV7cEXV+LjSQR92
         FYX9ncKLAnO3e1FzgHXy8HWu0/2+pdqQWBczlTufaBEdk1SBu3eWnEordbVzyICL0vOr
         KREw==
X-Gm-Message-State: AOJu0YxC9ksLf3OVWah9zmxtP7FiYuHCgow6hWZO48yt46qrFrCuuH9S
	C8ou3ppJfTLlnUIyOH4MOa63Qf83XoWuL0R0RL26FWhSkCcGBNGvE4lvg6mwIZOuuZ4C555KEUX
	JqkKv
X-Gm-Gg: ASbGncvyjp7nfJlzv4iHsLVLtF0etuM5Zx/W+O+tKxcqDAuqQizgJIEBkCF0mPw98Tu
	e4WBql95zxpMNohyvXTOWqmPC4hN4jTtfTSURh2qRfGbricbv7urEvSXngEdO4kQl7jHSJuJKjK
	18O+9EbM4ET8kQNv1jVSuBXfXDEVahDdEEsFr/j8c6uP5Q3E+ls+l6wCDhNCoDc7CYmtyzZFl+Y
	59DxwcTp3iwjRjvJbNL/tX11Z3Bgbj+8Wyp/NNvM339WVzCF1kodaFKhvr4OXSL+e9w2rHajmt2
	TN6ojwhuHmWHKsRJai2Pmrli1ZHQ6sInph4B+5kMLOkxYQKgGJxSGZY=
X-Google-Smtp-Source: AGHT+IHTRrUoF1tAicxeZbXy7OFQFqr9PXMMpSo7E9+jxwFpio38eV+mwADlFnYw7I1Lo1QoCB46jw==
X-Received: by 2002:a17:907:3f1b:b0:ade:3dc4:e67f with SMTP id a640c23a62f3a-ae3c2a6c753mr691745566b.9.1751558379661;
        Thu, 03 Jul 2025 08:59:39 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:c2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c0124csm1306888066b.99.2025.07.03.08.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:59:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: [PATCH net-next v2 1/2] tcp: Consider every port when connecting with IP_LOCAL_PORT_RANGE
Date: Thu,  3 Jul 2025 17:59:36 +0200
Message-ID: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250624-connect-port-search-harder-f36430c9b0e8
X-Mailer: b4 0.15-dev-07fe9
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
Changes in v2:
- Fix unused var warning when CONFIG_IPV6=n
- Convert INADDR_ANY to network byte order before comparison
- Link to v1: https://lore.kernel.org/r/20250626120247.1255223-1-jakub@cloudflare.com
---
 net/ipv4/inet_hashtables.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..b4c4caf3ff6c 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1005,6 +1005,43 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
 #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
 static u32 *table_perturb;
 
+/* True on source address conflict with another socket. False otherwise.
+ * Caller must hold hashbucket lock for this tb.
+ */
+static inline bool check_bound(const struct sock *sk,
+			       const struct inet_bind_bucket *tb)
+{
+	const struct inet_bind2_bucket *tb2;
+
+	hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
+#if IS_ENABLED(CONFIG_IPV6)
+		const struct sock *sk2;
+
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
+		if (tb2->rcv_saddr == htonl(INADDR_ANY) ||
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
@@ -1070,6 +1107,8 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			if (!inet_bind_bucket_match(tb, net, port, l3mdev))
 				continue;
 			if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+				if (unlikely(local_ports))
+					break; /* optimistic assumption */
 				rcu_read_unlock();
 				goto next_port;
 			}
@@ -1088,9 +1127,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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


