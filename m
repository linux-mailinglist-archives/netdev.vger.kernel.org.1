Return-Path: <netdev+bounces-206759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDF9B044F6
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A61D4A3314
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020DE25C82D;
	Mon, 14 Jul 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZtUUFO62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D618925C80E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509014; cv=none; b=ReSyn8t0qlWfbbbDtVwK5rIuKhNSDJ2xCiwMJ8gKMeFvgJ/eCxYyC4/rtF58SdxNX6U+OrFyTS7M5scBWxVw9PiBbs9Hwh2MDuOKgz91PhvOcl+4y4gWzLYcvaim5y5cBA+RYicX4hmZJrAZ/u5Q1A1nKJ4G1r6VZCQ1LcRlIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509014; c=relaxed/simple;
	bh=nEbP4mec1mAdu4Gy8NwG+hPMImdmUAeXUMPWohYgk7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u386/+QIqqIFFCXbWWhN/1ARFve/7ALnhsIh3Ou1wsueBltcSG1jGLa7TArkOtS8boynGOVd+fadLIDHtRur37ceCRR0YVS2jetekvUvLnNOYrf+PBPUun+NbuMQSuNongirOXDZfm7Bt0yxonTe6en1eh0Bbe0UV5oHv1KpG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZtUUFO62; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so3531647e87.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752509010; x=1753113810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md2mA+3JE0mstqxRdufG1uK98/Tpipcuv42D7+vi3Vc=;
        b=ZtUUFO62ZNOJT9kuz9paGvbHR6hnc2x8rkb0lRL9wdQMpueZOSmPJZVOuPMXBwO+j5
         kpQWwBJUJ/Shqkb9ntUGZZ40A8X8HHFD0R75A8pCDDb8+GrD2oYad3auLW+rx0oqw3/v
         cUJjOF9oRe+9dK3lqNaIn+taWLP14HhL3zUbdGQu6VG81cL/y4szqAOEfkRHI/Y0297e
         xp1NybPTofgbW9Eo4X1NyYiZRwvZlqfhXxRaO9vFdgbzf/Oo/zYyfslh3KSY9IuM006l
         SC25Yj7sc/dPfwZ8ScLl68rN1W+tJa0os6rHJrr0nD2xF1wk5byNiIA40aUM559mClpt
         4bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509010; x=1753113810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md2mA+3JE0mstqxRdufG1uK98/Tpipcuv42D7+vi3Vc=;
        b=vboj4f3mgG4DQwHi3KVuiuk/yvd/tA89/mbc/H8n2o/AOb5uke3HP+KH0hRW+sUBSU
         4J8c7v3MyTKa9mod3a3eB9zIRaLvmsH8oh3a7sd/ZHqyZ3rItdHq0jGWbqHADTHyNfL3
         7HT4Msfka5UOcUfnXo25erzTFYvJ9aiUsgX09mYjAi4M6N5nhEVGZ033yVoIg56FkvNh
         8Q4MEdZ3bwc6Td/tZPUGqgnKgrVW08PyC2kRqZbRXuFsZW35RPj5QOCW8ek/1YKS4qmD
         KgOnxmvI6ppBAeE9btacbypjva/oNGgG7dKu+/u/8/zHJfe4NqqHCskDId0O1rpN4xy3
         IP+Q==
X-Gm-Message-State: AOJu0YwNj74RgMceip8LRklHp3n4UgL0/7lJEYFDIsmgLg7wRPVGmues
	pTveO20Ks6+Xkzi3ZaLktAhjnZ+/FMUafjl/E2QRirnQCZtI1lokVhxYeR6w3eHtvH6juGkupX1
	gUTIz
X-Gm-Gg: ASbGncuiAgQuc/erzNPi+Zkz5dw+70r67SH+jJ+KBku1NOA8oOa3250OOKpi2Q8WQ/8
	G/bYIFmCbSj92rRPdxXqgdzUNaEZVaSkLrQlxs83Wd06dcHlHDVBgaHA73k3l+SoBLvBE/uOumP
	BcBIlnXJjTI1KZB64bHXaClinV/4oP7w+ei6YnenCsmrHbz7wJTruTrbGfu1F4dTYhKGgOO58gk
	Un2qCNJJy/362l434i1uN3sf3vYmErTsfgniNr+yByRalDasefX6cyqHjzRL7xDoXBTtdzDh5Sm
	C77x0CKmsJ6wBEDSHEaBTdaryfBbs+DntbWZy9sH+KNmp/mfxtAvFjL1zotdPIDfJvQOvFuv3Bv
	z9zVmDmZSTrkQaMidSyUPzEnETbhx4V+MQ38hz2GLAfwHitm94rlcHESP+Z02RPKp3byh
X-Google-Smtp-Source: AGHT+IHkuoBhMYha5ajBQvX0WDkXYf2rbXjt2W0KdAXGjw91mEoel48jhQFMayVNf4pMItysSocMxQ==
X-Received: by 2002:a05:6512:715:b0:558:f952:41eb with SMTP id 2adb3069b0e04-55a045f082dmr3418523e87.26.1752509010279;
        Mon, 14 Jul 2025 09:03:30 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b79c46sm1974882e87.229.2025.07.14.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:03:29 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 14 Jul 2025 18:03:05 +0200
Subject: [PATCH net-next v3 2/3] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-connect-port-search-harder-v3-2-b1a41f249865@cloudflare.com>
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
In-Reply-To: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

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

1) Connected v4 sockets could share the local port with v6
non-dualstack (V6ONLY) sockets, but that would require traversing
(struct inet_bind2_bucket *)->owners, which is not RCU safe.

2) Sharing both the local IP and port with other established sockets, when
the remote address is unique is still not possible, when the bucket is in a
non-reusable state (tb->{fastreuse,fastreuseport} >= 0) due to a socket
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
 net/ipv4/inet_hashtables.c | 56 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index d3ce6d0a514e..9d8a9c7c8274 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1005,6 +1005,52 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
 #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
 static u32 *table_perturb;
 
+/* True on source address conflict with another socket. False otherwise. */
+static inline bool check_bind2_bucket(const struct sock *sk,
+				      const struct inet_bind2_bucket *tb2)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		return tb2->addr_type == IPV6_ADDR_ANY ||
+		       ipv6_addr_equal(&tb2->v6_rcv_saddr,
+				       &sk->sk_v6_rcv_saddr);
+	}
+
+	/* Assume there might be a non-V6ONLY wildcard socket,
+	 * since walking tb2->owners is not RCU safe.
+	 */
+	if (tb2->addr_type == IPV6_ADDR_ANY)
+		return true;
+
+	if (tb2->addr_type != IPV6_ADDR_MAPPED)
+		return false;
+#endif
+	return tb2->rcv_saddr == htonl(INADDR_ANY) ||
+	       tb2->rcv_saddr == sk->sk_rcv_saddr;
+}
+
+static inline bool check_bind_bucket_rcu(const struct sock *sk,
+					 const struct inet_bind_bucket *tb)
+{
+	const struct inet_bind2_bucket *tb2;
+
+	hlist_for_each_entry_rcu(tb2, &tb->bhash2, bhash_node)
+		if (check_bind2_bucket(sk, tb2))
+			return true;
+	return false;
+}
+
+static inline bool check_bind_bucket(const struct sock *sk,
+				     const struct inet_bind_bucket *tb)
+{
+	const struct inet_bind2_bucket *tb2;
+
+	hlist_for_each_entry(tb2, &tb->bhash2, bhash_node)
+		if (check_bind2_bucket(sk, tb2))
+			return true;
+	return false;
+}
+
 int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		struct sock *sk, u64 port_offset,
 		u32 hash_port0,
@@ -1070,6 +1116,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 			if (!inet_bind_bucket_match(tb, net, port, l3mdev))
 				continue;
 			if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+				if (unlikely(local_ports &&
+					     !check_bind_bucket_rcu(sk, tb)))
+					break;
 				rcu_read_unlock();
 				goto next_port;
 			}
@@ -1088,9 +1137,12 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		 */
 		inet_bind_bucket_for_each(tb, &head->chain) {
 			if (inet_bind_bucket_match(tb, net, port, l3mdev)) {
-				if (tb->fastreuse >= 0 ||
-				    tb->fastreuseport >= 0)
+				if (tb->fastreuse >= 0 || tb->fastreuseport >= 0) {
+					if (unlikely(local_ports &&
+						     !check_bind_bucket(sk, tb)))
+						goto ok;
 					goto next_port_unlock;
+				}
 				WARN_ON(hlist_empty(&tb->bhash2));
 				if (!check_established(death_row, sk,
 						       port, &tw, false,

-- 
2.43.0


