Return-Path: <netdev+bounces-217712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74727B399E2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F210560E53
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6F30F556;
	Thu, 28 Aug 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI3L1M5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25030F549
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376870; cv=none; b=bTLKzUxtChsUs3AbwyGVWiPEuWQSVkKVzrdSwTOCK1c0UJBzJN9r4mNL8A1GZZelySB5FUeVHf42yzQX5jRLBEovzINIpDxvlh2fr/z2EsorDqWcuwxuDYHlFABOSydBxcbJrvFSs8yYM8jT7QAdPEpvJ1VCCDNLJ5YqbEdgLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376870; c=relaxed/simple;
	bh=hPEsCgbioqGpD0e7UuWHVNPQ1YXVDWQRz5koqZhRIaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HLirw+3cXt5vrbjVQkShljK8lpNyEzXRoGls47PWwe/J+AI2cgq5NNIfuiIGzTRrSRAzY8lw/1GlKAEhTnnRZnU67jH998H3XTK/K4J/9DzB7M+ZesC3+BcnbK7iel+KeLf7JIm+Xgm9coL9vjM+MqPgVEKead9KfZ3m22yFgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI3L1M5D; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e8704d540cso109504785a.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376868; x=1756981668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7CXYjvzxmasflm/xLB1qFtWwZ46Lw5TPd7tJBVvGGM=;
        b=PI3L1M5DSj0ZF/+nHmn70H9STXYzkZx6sexeUm5ucI0bC8NKsPqWCmRp7rDJuXxcvQ
         58tnlY3zXYkem/HfVeqmzQ0rHf9f3df+ekN/j/ZqUQuq5DSY4qku0atUXFdC+KuivxzN
         c8No5QXRnAbUYy6XQ2TH7HTrGa7ms/kViRLBBYf/FyCQGl95Zkt9sFJhOdvIkdm3DFpK
         8un3r6i+4MhuFHvr4iKJ5k3rc4q5JnwOXrVOESaaN/Fxl55+eiWK5qQqQ+nLJ70aMkwj
         gp+EwofQoAylRWqQ01bHReawUknANuJD+IMCVmmnFARtqYIuT+z+d5uhlJiJ2ij85O6/
         NHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376868; x=1756981668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7CXYjvzxmasflm/xLB1qFtWwZ46Lw5TPd7tJBVvGGM=;
        b=tNzxaJx6YPsVwiB2yjPui06WugheahqB4v27OFIifNj2350ZsWBqA9jwi04v3Oj3qq
         ml3xzadHkBsQYBDXxtH3+DGBQZHJyZj7Q5CZxNF/KFZK7eWsp1Dp7HPYG2vVNGV+L3cy
         8AzfgpzSHbpP4S97QgJxRE/5MvkFJHTtkAXPqx/2n35O1nZwaGT/68wG3sLEAGcfr25c
         +qk6c4cZm3ST9pC4A0c/IiXMnRpQYcqsuBavcbG8OediYnq83SnGkSGtZ+C5hbYhAlzY
         TY9+QIoWFyQfDJMZFB/jALWqo7YMWWJkCei/cDTeinHzQWUiq9+H9sqJdGqv/j843Blk
         uaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q4sVK5l9EJ5qk/CXUXjXMEBH137oYwf4cnXzPMUn4fNrQ8Vob9PkNwjV1jgbgTqD2S6TpPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZo/jevjXQuaF4X0Y6gbzVnyzdmDlkiTEa9OqQtXuzQV+UQph
	p0+IP2l/+BGROpdiZDYBAJK8/cGIlJCBatOIBZu2IqfBd3nBXjeCGYfjVfFM6FsMvRIlrzwFQvb
	gztUFy56KCZkQsQ==
X-Google-Smtp-Source: AGHT+IEAAQ/+X9IQgL5XY7MtsFXfyveei191l0ftuVIZ+h609FEp1MVYI9QSoMUeRh5z2vuNgseSGymJ56oEzQ==
X-Received: from qknpq5.prod.google.com ([2002:a05:620a:84c5:b0:7e2:e9ed:1448])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a81c:b0:7e9:f81f:ceae with SMTP id af79cd13be357-7ea110766b9mr2693750285a.72.1756376867817;
 Thu, 28 Aug 2025 03:27:47 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:37 +0000
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] inet_diag: change inet_diag_bc_sk() first argument
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We want to have access to the inet_diag_dump_data structure
in the following patch.

This patch removes duplication in callers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inet_diag.h |  2 +-
 net/ipv4/inet_diag.c      |  3 ++-
 net/ipv4/raw_diag.c       | 10 +++-------
 net/ipv4/tcp_diag.c       |  8 +++-----
 net/ipv4/udp_diag.c       | 10 +++-------
 net/mptcp/mptcp_diag.c    | 15 ++++-----------
 6 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 30bf8f7ea62b6b34dbf45d061fb8870a91be0944..86a0641ec36e1bf25483a8e6c3412073b9893d36 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -46,7 +46,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		      const struct inet_diag_req_v2 *req,
 		      u16 nlmsg_flags, bool net_admin);
 
-int inet_diag_bc_sk(const struct nlattr *_bc, struct sock *sk);
+int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk);
 
 void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk);
 
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 3827e9979d4f9a4b33665e08ce69eb803fe4f948..11710304268781581b3559aca770d50dc0090ef3 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -591,8 +591,9 @@ static void entry_fill_addrs(struct inet_diag_entry *entry,
 	}
 }
 
-int inet_diag_bc_sk(const struct nlattr *bc, struct sock *sk)
+int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk)
 {
+	const struct nlattr *bc = cb_data->inet_diag_nla_bc;
 	const struct inet_sock *inet = inet_sk(sk);
 	struct inet_diag_entry entry;
 
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index cc793bd8de258c3a12f11e95cec81c5ae4b9a7f6..943e5998e0ad5e23d0f3c4d364139bcb07ac5e0c 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -126,9 +126,9 @@ static int raw_diag_dump_one(struct netlink_callback *cb,
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 			struct netlink_callback *cb,
 			const struct inet_diag_req_v2 *r,
-			struct nlattr *bc, bool net_admin)
+			bool net_admin)
 {
-	if (!inet_diag_bc_sk(bc, sk))
+	if (!inet_diag_bc_sk(cb->data, sk))
 		return 0;
 
 	return inet_sk_diag_fill(sk, NULL, skb, cb, r, NLM_F_MULTI, net_admin);
@@ -140,17 +140,13 @@ static void raw_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
 	struct raw_hashinfo *hashinfo = raw_get_hashinfo(r);
 	struct net *net = sock_net(skb->sk);
-	struct inet_diag_dump_data *cb_data;
 	int num, s_num, slot, s_slot;
 	struct hlist_head *hlist;
 	struct sock *sk = NULL;
-	struct nlattr *bc;
 
 	if (IS_ERR(hashinfo))
 		return;
 
-	cb_data = cb->data;
-	bc = cb_data->inet_diag_nla_bc;
 	s_slot = cb->args[0];
 	num = s_num = cb->args[1];
 
@@ -174,7 +170,7 @@ static void raw_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			if (r->id.idiag_dport != inet->inet_dport &&
 			    r->id.idiag_dport)
 				goto next;
-			if (sk_diag_dump(sk, skb, cb, r, bc, net_admin) < 0)
+			if (sk_diag_dump(sk, skb, cb, r, net_admin) < 0)
 				goto out_unlock;
 next:
 			num++;
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 4ed6b93527f4ad00f34cc732639c0c82d0feff08..d83efd91f461c8ad0157faeebae051b32cb07bf4 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -320,11 +320,9 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	u32 idiag_states = r->idiag_states;
 	struct inet_hashinfo *hashinfo;
 	int i, num, s_i, s_num;
-	struct nlattr *bc;
 	struct sock *sk;
 
 	hashinfo = net->ipv4.tcp_death_row.hashinfo;
-	bc = cb_data->inet_diag_nla_bc;
 	if (idiag_states & TCPF_SYN_RECV)
 		idiag_states |= TCPF_NEW_SYN_RECV;
 	s_i = cb->args[1];
@@ -365,7 +363,7 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				    r->id.idiag_sport)
 					goto next_listen;
 
-				if (!inet_diag_bc_sk(bc, sk))
+				if (!inet_diag_bc_sk(cb_data, sk))
 					goto next_listen;
 
 				if (inet_sk_diag_fill(sk, inet_csk(sk), skb,
@@ -432,7 +430,7 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 					    r->sdiag_family != sk->sk_family)
 						goto next_bind;
 
-					if (!inet_diag_bc_sk(bc, sk))
+					if (!inet_diag_bc_sk(cb_data, sk))
 						goto next_bind;
 
 					sock_hold(sk);
@@ -519,7 +517,7 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				goto next_normal;
 			twsk_build_assert();
 
-			if (!inet_diag_bc_sk(bc, sk))
+			if (!inet_diag_bc_sk(cb_data, sk))
 				goto next_normal;
 
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index 38cb3a28e4ed6d54f7078afa2700e71db9ce4b85..6e491c720c9075bcef9d5daf9bc852fab3412231 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -16,9 +16,9 @@
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 			struct netlink_callback *cb,
 			const struct inet_diag_req_v2 *req,
-			struct nlattr *bc, bool net_admin)
+			bool net_admin)
 {
-	if (!inet_diag_bc_sk(bc, sk))
+	if (!inet_diag_bc_sk(cb->data, sk))
 		return 0;
 
 	return inet_sk_diag_fill(sk, NULL, skb, cb, req, NLM_F_MULTI,
@@ -92,12 +92,8 @@ static void udp_dump(struct udp_table *table, struct sk_buff *skb,
 {
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
 	struct net *net = sock_net(skb->sk);
-	struct inet_diag_dump_data *cb_data;
 	int num, s_num, slot, s_slot;
-	struct nlattr *bc;
 
-	cb_data = cb->data;
-	bc = cb_data->inet_diag_nla_bc;
 	s_slot = cb->args[0];
 	num = s_num = cb->args[1];
 
@@ -130,7 +126,7 @@ static void udp_dump(struct udp_table *table, struct sk_buff *skb,
 			    r->id.idiag_dport)
 				goto next;
 
-			if (sk_diag_dump(sk, skb, cb, r, bc, net_admin) < 0) {
+			if (sk_diag_dump(sk, skb, cb, r, net_admin) < 0) {
 				spin_unlock_bh(&hslot->lock);
 				goto done;
 			}
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 0566dd793810a58055d33548bcb5e511116eed61..ac974299de71cdf85cba7d848d14a241f5ff4dc8 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -15,9 +15,9 @@
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 			struct netlink_callback *cb,
 			const struct inet_diag_req_v2 *req,
-			struct nlattr *bc, bool net_admin)
+			bool net_admin)
 {
-	if (!inet_diag_bc_sk(bc, sk))
+	if (!inet_diag_bc_sk(cb->data, sk))
 		return 0;
 
 	return inet_sk_diag_fill(sk, inet_csk(sk), skb, cb, req, NLM_F_MULTI,
@@ -76,9 +76,7 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 				      const struct inet_diag_req_v2 *r,
 				      bool net_admin)
 {
-	struct inet_diag_dump_data *cb_data = cb->data;
 	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
-	struct nlattr *bc = cb_data->inet_diag_nla_bc;
 	struct net *net = sock_net(skb->sk);
 	struct inet_hashinfo *hinfo;
 	int i;
@@ -121,7 +119,7 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
 				goto next_listen;
 
-			ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+			ret = sk_diag_dump(sk, skb, cb, r, net_admin);
 
 			sock_put(sk);
 
@@ -154,15 +152,10 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	bool net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN);
 	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct inet_diag_dump_data *cb_data;
 	struct mptcp_sock *msk;
-	struct nlattr *bc;
 
 	BUILD_BUG_ON(sizeof(cb->ctx) < sizeof(*diag_ctx));
 
-	cb_data = cb->data;
-	bc = cb_data->inet_diag_nla_bc;
-
 	while ((msk = mptcp_token_iter_next(net, &diag_ctx->s_slot,
 					    &diag_ctx->s_num)) != NULL) {
 		struct inet_sock *inet = (struct inet_sock *)msk;
@@ -181,7 +174,7 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		    r->id.idiag_dport)
 			goto next;
 
-		ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
+		ret = sk_diag_dump(sk, skb, cb, r, net_admin);
 next:
 		sock_put(sk);
 		if (ret < 0) {
-- 
2.51.0.268.g9569e192d0-goog


