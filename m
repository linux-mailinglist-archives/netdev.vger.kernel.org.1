Return-Path: <netdev+bounces-18439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EE756F3B
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB89281348
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C01095F;
	Mon, 17 Jul 2023 21:59:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40902F52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 21:59:43 +0000 (UTC)
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B6E52
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689631181; x=1721167181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8BRYrDnzT40vmd2/S2pKMXN66Q3vQS/vozwt9w+2mus=;
  b=SIA6/nMo778U59Wb6QOfjztKY2duu8AgBN7HyrPIHqZpYDbSxLE/O0yO
   /9Z8HFHUBlrSKBnA5GrymKkP/EsAFpkhhUKea7iy+59vDkjCI+Vigvz2t
   7bmCZPwpVfvLAAf7HgkWOvlo5FoXwZFnERGHynw4ZB7bgFV8B44m678Uq
   k=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="16867721"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 21:59:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 8DF6681D60;
	Mon, 17 Jul 2023 21:59:35 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 21:59:33 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 21:59:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net] Revert "tcp: avoid the lookup process failing to get sk in ehash table"
Date: Mon, 17 Jul 2023 14:59:18 -0700
Message-ID: <20230717215918.15723-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This reverts commit 3f4ca5fafc08881d7a57daa20449d171f2887043.

Commit 3f4ca5fafc08 ("tcp: avoid the lookup process failing to get sk in
ehash table") reversed the order in how a socket is inserted into ehash
to fix an issue that ehash-lookup could fail when reqsk/full sk/twsk are
swapped.  However, it introduced another lookup failure.

The full socket in ehash is allocated from a slab with SLAB_TYPESAFE_BY_RCU
and does not have SOCK_RCU_FREE, so the socket could be reused even while
it is being referenced on another CPU doing RCU lookup.

Let's say a socket is reused and inserted into the same hash bucket during
lookup.  After the blamed commit, a new socket is inserted at the end of
the list.  If that happens, we will skip sockets placed after the previous
position of the reused socket, resulting in ehash lookup failure.

As described in Documentation/RCU/rculist_nulls.rst, we should insert a
new socket at the head of the list to avoid such an issue.

This issue, the swap-lookup-failure, and another variant reported in [0]
can all be handled properly by adding a locked ehash lookup suggested by
Eric Dumazet [1].

However, this issue could occur for every packet, thus more likely than
the other two races, so let's revert the change for now.

Link: https://lore.kernel.org/netdev/20230606064306.9192-1-duanmuquan@baidu.com/ [0]
Link: https://lore.kernel.org/netdev/CANn89iK8snOz8TYOhhwfimC7ykYA78GA3Nyv8x06SZYa1nKdyA@mail.gmail.com/ [1]
Fixes: 3f4ca5fafc08 ("tcp: avoid the lookup process failing to get sk in ehash table")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
I will work on the locked ehash lookup if it's not WIP.
---
 net/ipv4/inet_hashtables.c    | 17 ++---------------
 net/ipv4/inet_timewait_sock.c |  8 ++++----
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e7391bf310a7..0819d6001b9a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -650,20 +650,8 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	spin_lock(lock);
 	if (osk) {
 		WARN_ON_ONCE(sk->sk_hash != osk->sk_hash);
-		ret = sk_hashed(osk);
-		if (ret) {
-			/* Before deleting the node, we insert a new one to make
-			 * sure that the look-up-sk process would not miss either
-			 * of them and that at least one node would exist in ehash
-			 * table all the time. Otherwise there's a tiny chance
-			 * that lookup process could find nothing in ehash table.
-			 */
-			__sk_nulls_add_node_tail_rcu(sk, list);
-			sk_nulls_del_node_init_rcu(osk);
-		}
-		goto unlock;
-	}
-	if (found_dup_sk) {
+		ret = sk_nulls_del_node_init_rcu(osk);
+	} else if (found_dup_sk) {
 		*found_dup_sk = inet_ehash_lookup_by_sk(sk, list);
 		if (*found_dup_sk)
 			ret = false;
@@ -672,7 +660,6 @@ bool inet_ehash_insert(struct sock *sk, struct sock *osk, bool *found_dup_sk)
 	if (ret)
 		__sk_nulls_add_node_rcu(sk, list);
 
-unlock:
 	spin_unlock(lock);
 
 	return ret;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 40052414c7c7..2c1b245dba8e 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -88,10 +88,10 @@ void inet_twsk_put(struct inet_timewait_sock *tw)
 }
 EXPORT_SYMBOL_GPL(inet_twsk_put);
 
-static void inet_twsk_add_node_tail_rcu(struct inet_timewait_sock *tw,
-					struct hlist_nulls_head *list)
+static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
+				   struct hlist_nulls_head *list)
 {
-	hlist_nulls_add_tail_rcu(&tw->tw_node, list);
+	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
 static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
@@ -144,7 +144,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	spin_lock(lock);
 
-	inet_twsk_add_node_tail_rcu(tw, &ehead->chain);
+	inet_twsk_add_node_rcu(tw, &ehead->chain);
 
 	/* Step 3: Remove SK from hash chain */
 	if (__sk_nulls_del_node_init_rcu(sk))
-- 
2.30.2


