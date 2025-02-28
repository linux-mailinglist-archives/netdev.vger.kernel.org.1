Return-Path: <netdev+bounces-170477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BFA48D6F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348151894AE6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43D3597A;
	Fri, 28 Feb 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cT8EjUJA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7431C2BD;
	Fri, 28 Feb 2025 00:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702623; cv=none; b=but58r7sUi9AF0cZCUdNpGIuho8P35uY/YrmQGkTDOJtoiRBijZtp6uUSidfqoSWHi1wF+OOUhYnnYSc+1+jN3NvWwiLdG0KyPX4J2rnMG0hNXPtRSjqGjlkbSGE4+yGu7RmQYNOsTgv5/NJo+oAhXFK1DorY3Q4Gj4MByw9Er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702623; c=relaxed/simple;
	bh=270OxG8GIF4of5n0KXdJfSehe6zyxDTJj2SgvDJ4sOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCDBqAKwGZRILVCHn5utK3k7RsjUeivadQ4jA3Mq8esJfzlfrl+UwKDYVTXkrmEil9uMWj0PacHvBAzMNQLStjGKwCQyMUbvt60wzKwgA0eXQgpRp5u/k6fQ+9eQWHCFBX2ves75Fz4LsDGpG2NjF00kjSFojntw0rJcHWKKNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cT8EjUJA; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740702621; x=1772238621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qEqep+86iN7wQgF+squJGj2SBVPm66bjMKtemOZYB2M=;
  b=cT8EjUJAH/1MYX4V6sJus1eaDz3VPMV/k9+n2AgfwjcMFe3B1OMs8FsY
   RQ1nAY+jmhUVWS7UcmTdURKtsABOrZ84yfNaHjmHCkBYbJGIAiRg/YBzW
   T+5K+M+RqDB+MANwzvntRj3KpWhKVV+z6RZzBFeys6GJhuPlmiAILOvGk
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,320,1732579200"; 
   d="scan'208";a="700832264"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 00:30:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20259]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.24:2525] with esmtp (Farcaster)
 id f66a8442-262b-4866-983c-1797078256cb; Fri, 28 Feb 2025 00:30:16 +0000 (UTC)
X-Farcaster-Flow-ID: f66a8442-262b-4866-983c-1797078256cb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 00:30:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 00:30:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <menglong8.dong@gmail.com>
CC: <davem@davemloft.net>, <dongml2@chinatelecom.cn>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kerneljasonxing@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<petrm@nvidia.com>, <yyd@google.com>
Subject: Re: [RFC PATCH net-next] net: ip: add sysctl_ip_reuse_exact_match
Date: Thu, 27 Feb 2025 16:29:53 -0800
Message-ID: <20250228002953.68029-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250227123137.138778-1-dongml2@chinatelecom.cn>
References: <20250227123137.138778-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 27 Feb 2025 20:31:37 +0800
> For now, the socket lookup will terminate if the socket is reuse port in
> inet_lhash2_lookup(), which makes the socket is not the best match.
> 
> For example, we have socket1 listening on "0.0.0.0:1234" and socket2
> listening on "192.168.1.1:1234", and both of them enabled reuse port. The
> socket1 will always be matched when a connection with the peer ip
> "192.168.1.xx" comes if the socket1 is created later than socket2. This
> is not expected, as socket2 has higher priority.
> 
> This can cause unexpected behavior if TCP MD5 keys is used, as described
> in Documentation/networking/vrf.rst -> Applications.

Could you provide a minimal repro setup ?
I somehow fail to reproduce the issue.


> Introduce the sysctl_ip_reuse_exact_match to make it find a best matched
> socket when reuse port is used.

I think we should not introduce a new sysctl knob and an extra lookup,
rather we can solve that in __inet_hash() taking d894ba18d4e4
("soreuseport: fix ordering for mixed v4/v6 sockets") further.

Could you test this patch ?

---8<---
$ git show
commit 4dbc44a153afe51a2b2698a55213e625a02e23c8
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Thu Feb 27 19:53:43 2025 +0000

    tcp: Place non-wildcard sockets before wildcard ones in lhash2.
    
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 5eea47f135a4..115248bfe463 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -136,6 +136,9 @@ struct inet_bind_hashbucket {
 struct inet_listen_hashbucket {
 	spinlock_t		lock;
 	struct hlist_nulls_head	nulls_head;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct hlist_nulls_node	*wildcard_node;
+#endif
 };
 
 /* This is for listening sockets, thus all sockets which possess wildcards. */
diff --git a/include/net/sock.h b/include/net/sock.h
index efc031163c33..4e8e10d2067b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -863,6 +863,16 @@ static inline void __sk_nulls_add_node_tail_rcu(struct sock *sk, struct hlist_nu
 	hlist_nulls_add_tail_rcu(&sk->sk_nulls_node, list);
 }
 
+static inline void __sk_nulls_add_node_before_rcu(struct sock *sk, struct hlist_nulls_node *next)
+{
+	struct hlist_nulls_node *n = &sk->sk_nulls_node;
+
+	WRITE_ONCE(n->pprev, next->pprev);
+	WRITE_ONCE(n->next, next);
+	WRITE_ONCE(next->pprev, &n->next);
+	WRITE_ONCE(*(n->pprev), n);
+}
+
 static inline void sk_nulls_add_node_rcu(struct sock *sk, struct hlist_nulls_head *list)
 {
 	sock_hold(sk);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ecda4c65788c..acfb693bb1d4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -729,6 +729,7 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 {
 	struct inet_hashinfo *hashinfo = tcp_or_dccp_get_hashinfo(sk);
 	struct inet_listen_hashbucket *ilb2;
+	bool add_tail = false;
 	int err = 0;
 
 	if (sk->sk_state != TCP_LISTEN) {
@@ -737,21 +738,47 @@ int __inet_hash(struct sock *sk, struct sock *osk)
 		local_bh_enable();
 		return 0;
 	}
+
 	WARN_ON(!sk_unhashed(sk));
 	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
 
 	spin_lock(&ilb2->lock);
+
 	if (sk->sk_reuseport) {
 		err = inet_reuseport_add_sock(sk, ilb2);
 		if (err)
 			goto unlock;
+
+		if (inet_rcv_saddr_any(sk))
+			add_tail = true;
 	}
+
 	sock_set_flag(sk, SOCK_RCU_FREE);
-	if (IS_ENABLED(CONFIG_IPV6) && sk->sk_reuseport &&
-		sk->sk_family == AF_INET6)
-		__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
-	else
-		__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (sk->sk_family == AF_INET6) {
+		if (add_tail || !ilb2->wildcard_node)
+			__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
+		else
+			__sk_nulls_add_node_before_rcu(sk, ilb2->wildcard_node);
+	} else
+#endif
+	{
+		if (!add_tail)
+			__sk_nulls_add_node_rcu(sk, &ilb2->nulls_head);
+#if IS_ENABLED(CONFIG_IPV6)
+		else if (ilb2->wildcard_node)
+			__sk_nulls_add_node_before_rcu(sk, ilb2->wildcard_node);
+#endif
+		else
+			__sk_nulls_add_node_tail_rcu(sk, &ilb2->nulls_head);
+	}
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (add_tail && (sk->sk_family == AF_INET || !ilb2->wildcard_node))
+		ilb2->wildcard_node = &sk->sk_nulls_node;
+#endif
+
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 unlock:
 	spin_unlock(&ilb2->lock);
@@ -794,6 +821,15 @@ void inet_unhash(struct sock *sk)
 		if (rcu_access_pointer(sk->sk_reuseport_cb))
 			reuseport_stop_listen_sock(sk);
 
+#if IS_ENABLED(CONFIG_IPV6)
+		if (&sk->sk_nulls_node == ilb2->wildcard_node) {
+			if (is_a_nulls(sk->sk_nulls_node.next))
+				ilb2->wildcard_node = NULL;
+			else
+				ilb2->wildcard_node = sk->sk_nulls_node.next;
+		}
+#endif
+
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 		spin_unlock(&ilb2->lock);
@@ -1183,6 +1219,9 @@ static void init_hashinfo_lhash2(struct inet_hashinfo *h)
 		spin_lock_init(&h->lhash2[i].lock);
 		INIT_HLIST_NULLS_HEAD(&h->lhash2[i].nulls_head,
 				      i + LISTENING_NULLS_BASE);
+#if IS_ENABLED(CONFIG_IPV6)
+		h->lhash2[i].wildcard_node = NULL;
+#endif
 	}
 }
 
---8<---

