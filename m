Return-Path: <netdev+bounces-211312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328DB17ED9
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1E4E1ECB
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266921FF35;
	Fri,  1 Aug 2025 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiRWiddG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623920D50C;
	Fri,  1 Aug 2025 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039399; cv=none; b=mvENma3sJFjal2/AU9PqcQ8Y/YpfD8XLfHx7ToXrHjiSxF/jNUGfuPQPTIJFqIIL04AT8Ynp2WuB0yOcbkUm9fGU07dgEJdIQaKFSXYhJkVKVUv0TJat5pN7ixMQ7+0GDWfo4xytrN4JgohZnQsSQzTG+Hjvl1x7XsYWCTH84f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039399; c=relaxed/simple;
	bh=n4Ixi3fYDbUfs+fuzHa0N0j02ntzgphgaIShRouvows=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhikzQxKBu2UkZoLV81oa3FBCU/OjfkJmzFtg0tXP1xV6NMfYBgSN6fMt3m+4KIxATste0xpjjWlxk9vwJ599M2DJR/XxqbZ78XyMaA1ExqR7K5s4DdWNBWUZ8cwxN+ly/3vU2EqRVSi0K69DsrLZhUc18ynwMtoSnBH9wOT2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiRWiddG; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2403ca0313aso11908985ad.0;
        Fri, 01 Aug 2025 02:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039397; x=1754644197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vP4UDhxH/4RAWHjsHwISLfLYU+GjjD8clL/MRd1n8s=;
        b=JiRWiddGCHPLipdf4+LsQCTVUyo0G4nQg4C69uyYg/0tGEbM5d8MN7zmC8Wvfwp1By
         Kie5hSVBU1Yurn9po8yoVEF/lyKunsf3Q0aAG0rClaw53dLKW8LzAbU1g1NrTPM2g7Gt
         3m0471MEjhIuifEhc6Yp6b03McKL+HGqp8CRuHA4IKty/PVmeFQnYlmxuZi1GmsTBNhA
         ybUcA26oKFus2QhIkhX+pmTD2UJgbhbMLYiriX4TBqdAPhZo1aA/xDYL7W8EuMCJWffY
         7eK8lwIw2gNdhmkuvWdTTB3c0G2OU/wMwbSJ/kWWlly4C27MzAUCdGH+eOjjexXD4q96
         flJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039397; x=1754644197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vP4UDhxH/4RAWHjsHwISLfLYU+GjjD8clL/MRd1n8s=;
        b=Jv/rEXY1QgsSpUjNHu9nAfsjzsr205ZJwM/VqF+HnuSws//wwg859usHhSTLf1dlXl
         kfgn4yJv0T0h6vgxQ7PnqYcaDaXFljx/sFdHGhFlthBv+ln72ad03+0jvDNnSFEeakd9
         lK15BkoiDDLBvhxeUqPRPR4ghWItPJ8U1NYVQ2ZQLmAruK40uEgHf0ix+TbueE9cE7it
         2PMyIKZhLM0Avb8bI3ndYHgFRudWLFtuij1SN0RXfGxmOHDxUP/7u4lC67pFmWoUf9Om
         vbXWW9yxb0j/p/0ro1yuOLEViHvjKfRapEVfiDt1ZeF/pQCISgjR0u7zEejsH2pJNnPw
         nZww==
X-Forwarded-Encrypted: i=1; AJvYcCWojULafYfYzE7w0XF8FnIxJGpK3PZhol+WZEuXbAOuSKVsUnN0rpFVm95W3eW5fuSvEW2OksXsP264zBg=@vger.kernel.org, AJvYcCXFYHIP5FOUa59Szh699gSiO+ObCU8s7shpGo/+/jACuWb2VsZssI5RieWuYZ30wFtfypWPnwfi@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVMzBXYGtU0eTGCHWrEsLm7K7wtuKhFo1Wq3GYP2CmKli+SxQ
	rxDPjOnYEZXq9KnK8RXNhoEeCyNbwAKksEKY30R2kfR94+oNV0Pshogm
X-Gm-Gg: ASbGncvRs3vMNBJxdDl678irrj587hOhUuvosP1+kiPNNyDIcOlXbJgzsoG1tuHmc6Q
	KhkvDK1616Y3c91wmVMIHGVG8XY8MvQj0PYxXJoYbfsPcXz0YOwaPzH3WCmHeUyM4iXbAa1XZSq
	eGubis0LjerlCxqbAnYscfZokg97klfMD1AS2K5qkozQahPupBXi0wpUKm2mNnsnTXz30KfVTm7
	eMFyJ+9KU9Z5iK5qIgrUsT402sbfnVZH+dz8olc3sjOvUBVabtcIhPN4bZMJcokicdlFcGBYYiq
	qiaEx9pIZznK2cv9XO2XXYkmWxFiP3Tj1uNW7I8+LiNN5srLZ2mqAy3ZRRjNcz3RjNUHbRt1zd5
	fsxn++cAfVkVvu3q8kLgceuzuRK/5MQ==
X-Google-Smtp-Source: AGHT+IHChPwRTNYpUHcgeeM7piFCcgYCUBrVKH+gbNGL2Jnz6aoBql0VB21y+2TzAjiFGYRHyBoQtw==
X-Received: by 2002:a17:902:e5d2:b0:240:8262:1a46 with SMTP id d9443c01a7336-2422a6a7ddcmr26693015ad.25.1754039396664;
        Fri, 01 Aug 2025 02:09:56 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef65d2sm38019985ad.31.2025.08.01.02.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:09:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuniyu@google.com,
	kraig@google.com
Cc: ncardwell@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
Date: Fri,  1 Aug 2025 17:09:49 +0800
Message-ID: <20250801090949.129941-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the socket lookup will terminate if the socket is reuse port in
inet_lhash2_lookup(), which makes the socket is not the best match.

For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
but socket1 bind on "eth0". We create socket1 first, and then socket2.
Then, all connections will goto socket2, which is not expected, as socket1
has higher priority.

This can cause unexpected behavior if TCP MD5 keys is used, as described
in Documentation/networking/vrf.rst -> Applications.

Therefore, we compute a score for the reuseport socket and add it to the
list with order in __inet_hash(). Sockets with high score will be added
to the head.

Link: https://lore.kernel.org/netdev/20250731123309.184496-1-dongml2@chinatelecom.cn/
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- As Kuniyuki advised, sort the reuseport socket in __inet_hash() to keep
  the lookup for reuseport O(1)
---
 include/linux/rculist_nulls.h | 34 ++++++++++++++++++++++++
 include/net/sock.h            |  5 ++++
 net/ipv4/inet_hashtables.c    | 49 ++++++++++++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd4..da500f4ae142 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
+/**
+ * hlist_nulls_pprev_rcu - returns the element of the list after @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+	(*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -145,6 +152,33 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 	}
 }
 
+/**
+ * hlist_nulls_add_before_rcu
+ * @n: the new element to add to the hash list.
+ * @next: the existing element to add the new element before.
+ *
+ * Description:
+ * Adds the specified element to the specified hlist
+ * before the specified node while permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary
+ * (such as holding appropriate locks) to avoid racing
+ * with another list-mutation primitive, such as hlist_nulls_add_head_rcu()
+ * or hlist_nulls_del_rcu(), running on this same list.
+ * However, it is perfectly legal to run concurrently with
+ * the _rcu list-traversal primitives, such as
+ * hlist_nulls_for_each_entry_rcu(), used to prevent memory-consistency
+ * problems on Alpha CPUs.
+ */
+static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
+					      struct hlist_nulls_node *next)
+{
+	WRITE_ONCE(n->pprev, next->pprev);
+	n->next = next;
+	rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
+	WRITE_ONCE(next->pprev, &n->next);
+}
+
 /* after that hlist_nulls_del will work */
 static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 {
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..42aa1919eeee 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -885,6 +885,11 @@ static inline void __sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
 	hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
 }
 
+static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, struct sock *next)
+{
+	hlist_nulls_add_before_rcu(&sk->sk_nulls_node, &next->sk_nulls_node);
+}
+
 static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
 {
 	sock_hold(sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..80d8bec41a58 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -334,6 +334,26 @@ static inline int compute_score(struct sock *sk, const struct net *net,
 	return score;
 }
 
+static inline int compute_reuseport_score(struct sock *sk)
+{
+	int score = 0;
+
+	if (sk->sk_bound_dev_if)
+		score += 2;
+
+	if (sk->sk_family == PF_INET)
+		score += 10;
+
+	/* the priority of sk_incoming_cpu should be lower than sk_bound_dev_if,
+	 * as it's optional in compute_score(). Thank God, this is the only
+	 * variable condition, which we can't judge now.
+	 */
+	if (READ_ONCE(sk->sk_incoming_cpu))
+		score++;
+
+	return score;
+}
+
 /**
  * inet_lookup_reuseport() - execute reuseport logic on AF_INET socket if necessary.
  * @net: network namespace.
@@ -739,6 +759,27 @@ static int inet_reuseport_add_sock(struct sock *sk,
 	return reuseport_alloc(sk, inet_rcv_saddr_any(sk));
 }
 
+static void inet_hash_reuseport(struct sock *sk, struct hlist_nulls_head *head)
+{
+	const struct hlist_nulls_node *node;
+	int score, curscore;
+	struct sock *sk2;
+
+	curscore = compute_reuseport_score(sk);
+	/* lookup the socket to insert before */
+	sk_nulls_for_each_rcu(sk2, node, head) {
+		if (!sk2->sk_reuseport)
+			continue;
+		score = compute_reuseport_score(sk2);
+		if (score <= curscore) {
+			__sk_nulls_add_node_before_rcu(sk, sk2);
+			return;
+		}
+	}
+
+	__sk_nulls_add_node_tail_rcu(sk, head);
+}
+
 int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = tcp_get_hashinfo(sk);
@@ -761,11 +802,11 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 			goto unlock;
 	}
 	sock_set_flag(sk, SOCK_RCU_FREE);
-	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family == AF_INET6)
-		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
-	else
+	if (!sk->sk_reuseport)
 		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+	else
+		inet_hash_reuseport(sk, &ilb2->nulls_head);
+
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
-- 
2.50.1


