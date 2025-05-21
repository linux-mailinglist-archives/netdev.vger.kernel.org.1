Return-Path: <netdev+bounces-192158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A3ABEB72
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1B03BF149
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19F123371E;
	Wed, 21 May 2025 05:43:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC50622FDE8
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806238; cv=none; b=WYbCVNAR1V5LF49IRflGx2f6qjc88133zt8Ie7rmykgNpw9rngUkywoafl4vw7ZTE3kHBM1nOrEL/usK138nIL611gbnaQcZWx/5LOxvzAdtEiEX3HQhCXJQO1DehHCWRKZPwL5sqVj0ZwMvLdPgFrzUSLHMc975Lj+5Pe+jQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806238; c=relaxed/simple;
	bh=9m+4PwJviDmd+NXuzs0/sTRxsAQi0X8B0eDNepi1gxE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCmWDn0EaWX2RuOjWbCqxtud9HArOlyWwgDzFAbCLwJA5SJ+CsZMHL+clSxOQK2Urv6+DOL/OvxCkyi901igp07ra15qERSIL2RQCGtCXheMuTc0W/B9ZcwbizCMPSY4IDGfxIdmm415tncOVFt/xwKBX9f1+D8A771aVkABbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D4551207D1;
	Wed, 21 May 2025 07:43:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTNNeNXrUg9o; Wed, 21 May 2025 07:43:52 +0200 (CEST)
Received: from EXCH-02.secunet.de (unknown [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1605220748;
	Wed, 21 May 2025 07:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1605220748
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 21 May
 2025 07:43:51 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 07:43:51 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DA9923180FB8; Wed, 21 May 2025 07:43:50 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 2/5] espintcp: remove encap socket caching to avoid reference leak
Date: Wed, 21 May 2025 07:43:45 +0200
Message-ID: <20250521054348.4057269-3-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521054348.4057269-1-steffen.klassert@secunet.com>
References: <20250521054348.4057269-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

From: Sabrina Dubroca <sd@queasysnail.net>

The current scheme for caching the encap socket can lead to reference
leaks when we try to delete the netns.

The reference chain is: xfrm_state -> enacp_sk -> netns

Since the encap socket is a userspace socket, it holds a reference on
the netns. If we delete the espintcp state (through flush or
individual delete) before removing the netns, the reference on the
socket is dropped and the netns is correctly deleted. Otherwise, the
netns may not be reachable anymore (if all processes within the ns
have terminated), so we cannot delete the xfrm state to drop its
reference on the socket.

This patch results in a small (~2% in my tests) performance
regression.

A GC-type mechanism could be added for the socket cache, to clear
references if the state hasn't been used "recently", but it's a lot
more complex than just not caching the socket.

Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h    |  1 -
 net/ipv4/esp4.c       | 49 ++++---------------------------------------
 net/ipv6/esp6.c       | 49 ++++---------------------------------------
 net/xfrm/xfrm_state.c |  3 ---
 4 files changed, 8 insertions(+), 94 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 39365fd2ea17..06ab2a3d2ebd 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -236,7 +236,6 @@ struct xfrm_state {
 
 	/* Data for encapsulator */
 	struct xfrm_encap_tmpl	*encap;
-	struct sock __rcu	*encap_sk;
 
 	/* NAT keepalive */
 	u32			nat_keepalive_interval; /* seconds */
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 876df672c0bf..f14a41ee4aa1 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -120,47 +120,16 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 }
 
 #ifdef CONFIG_INET_ESPINTCP
-struct esp_tcp_sk {
-	struct sock *sk;
-	struct rcu_head rcu;
-};
-
-static void esp_free_tcp_sk(struct rcu_head *head)
-{
-	struct esp_tcp_sk *esk = container_of(head, struct esp_tcp_sk, rcu);
-
-	sock_put(esk->sk);
-	kfree(esk);
-}
-
 static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 {
 	struct xfrm_encap_tmpl *encap = x->encap;
 	struct net *net = xs_net(x);
-	struct esp_tcp_sk *esk;
 	__be16 sport, dport;
-	struct sock *nsk;
 	struct sock *sk;
 
-	sk = rcu_dereference(x->encap_sk);
-	if (sk && sk->sk_state == TCP_ESTABLISHED)
-		return sk;
-
 	spin_lock_bh(&x->lock);
 	sport = encap->encap_sport;
 	dport = encap->encap_dport;
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (sk && sk == nsk) {
-		esk = kmalloc(sizeof(*esk), GFP_ATOMIC);
-		if (!esk) {
-			spin_unlock_bh(&x->lock);
-			return ERR_PTR(-ENOMEM);
-		}
-		RCU_INIT_POINTER(x->encap_sk, NULL);
-		esk->sk = sk;
-		call_rcu(&esk->rcu, esp_free_tcp_sk);
-	}
 	spin_unlock_bh(&x->lock);
 
 	sk = inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, x->id.daddr.a4,
@@ -173,20 +142,6 @@ static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 		return ERR_PTR(-EINVAL);
 	}
 
-	spin_lock_bh(&x->lock);
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (encap->encap_sport != sport ||
-	    encap->encap_dport != dport) {
-		sock_put(sk);
-		sk = nsk ?: ERR_PTR(-EREMCHG);
-	} else if (sk == nsk) {
-		sock_put(sk);
-	} else {
-		rcu_assign_pointer(x->encap_sk, sk);
-	}
-	spin_unlock_bh(&x->lock);
-
 	return sk;
 }
 
@@ -211,6 +166,8 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 		err = espintcp_push_skb(sk, skb);
 	bh_unlock_sock(sk);
 
+	sock_put(sk);
+
 out:
 	rcu_read_unlock();
 	return err;
@@ -394,6 +351,8 @@ static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
 	if (IS_ERR(sk))
 		return ERR_CAST(sk);
 
+	sock_put(sk);
+
 	*lenp = htons(len);
 	esph = (struct ip_esp_hdr *)(lenp + 1);
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 574989b82179..72adfc107b55 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -137,47 +137,16 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-struct esp_tcp_sk {
-	struct sock *sk;
-	struct rcu_head rcu;
-};
-
-static void esp_free_tcp_sk(struct rcu_head *head)
-{
-	struct esp_tcp_sk *esk = container_of(head, struct esp_tcp_sk, rcu);
-
-	sock_put(esk->sk);
-	kfree(esk);
-}
-
 static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 {
 	struct xfrm_encap_tmpl *encap = x->encap;
 	struct net *net = xs_net(x);
-	struct esp_tcp_sk *esk;
 	__be16 sport, dport;
-	struct sock *nsk;
 	struct sock *sk;
 
-	sk = rcu_dereference(x->encap_sk);
-	if (sk && sk->sk_state == TCP_ESTABLISHED)
-		return sk;
-
 	spin_lock_bh(&x->lock);
 	sport = encap->encap_sport;
 	dport = encap->encap_dport;
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (sk && sk == nsk) {
-		esk = kmalloc(sizeof(*esk), GFP_ATOMIC);
-		if (!esk) {
-			spin_unlock_bh(&x->lock);
-			return ERR_PTR(-ENOMEM);
-		}
-		RCU_INIT_POINTER(x->encap_sk, NULL);
-		esk->sk = sk;
-		call_rcu(&esk->rcu, esp_free_tcp_sk);
-	}
 	spin_unlock_bh(&x->lock);
 
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, &x->id.daddr.in6,
@@ -190,20 +159,6 @@ static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 		return ERR_PTR(-EINVAL);
 	}
 
-	spin_lock_bh(&x->lock);
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (encap->encap_sport != sport ||
-	    encap->encap_dport != dport) {
-		sock_put(sk);
-		sk = nsk ?: ERR_PTR(-EREMCHG);
-	} else if (sk == nsk) {
-		sock_put(sk);
-	} else {
-		rcu_assign_pointer(x->encap_sk, sk);
-	}
-	spin_unlock_bh(&x->lock);
-
 	return sk;
 }
 
@@ -228,6 +183,8 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 		err = espintcp_push_skb(sk, skb);
 	bh_unlock_sock(sk);
 
+	sock_put(sk);
+
 out:
 	rcu_read_unlock();
 	return err;
@@ -424,6 +381,8 @@ static struct ip_esp_hdr *esp6_output_tcp_encap(struct xfrm_state *x,
 	if (IS_ERR(sk))
 		return ERR_CAST(sk);
 
+	sock_put(sk);
+
 	*lenp = htons(len);
 	esph = (struct ip_esp_hdr *)(lenp + 1);
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..2f57dabcc70b 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -838,9 +838,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
-		if (x->encap_sk)
-			sock_put(rcu_dereference_raw(x->encap_sk));
-
 		xfrm_dev_state_delete(x);
 
 		/* All xfrm_state objects are created by xfrm_state_alloc.
-- 
2.34.1


