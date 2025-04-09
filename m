Return-Path: <netdev+bounces-180774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E2A826EB
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49249031A3
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75167264FA5;
	Wed,  9 Apr 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mjcbZqpp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFeLtOBk"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC12627FF
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207223; cv=none; b=JrYi/v14866PMDvzRFRCh0HT4UW0ldTmt9CXalFYnyJeb7RMGIQP70pxmRCQ0gh75WFrnlpS7Jz0mq+NUR3mIR4V7gCZjAuLAxFGyoCN3JtQsC2igHXs9QXiIK/tfibk/OMQqUO+vPC2dRD/R5MQbZ6VNLJXIGtZsooaTxFSSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207223; c=relaxed/simple;
	bh=soOflttB7PrEcUWV6iEvj0Bi6kUFLhrLukykTtPW98Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEe2qwWzx9BXkvBNRBdMZtCp/uOYvTiWuDyj7GsQhDPShgjgKb0Gz2V9elmeNc4Vwz/MjGzPllLc5AR+c9N8SWNGBXV+TsUKwMFGm7PN/0BW3zMtmr6AWUgMNDfVdQcMBrBBaF4nZ47yFuyxJApmuI3np89s/ewQukXvDDJouJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mjcbZqpp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FFeLtOBk; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BA4A31140158;
	Wed,  9 Apr 2025 10:00:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Apr 2025 10:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1744207219; x=
	1744293619; bh=kkjJkpP/qG3JocRX+sZCvZRuvsILd4g+caXlZ1/Y6NE=; b=m
	jcbZqppz6kSeGOhlMi3iQ3mgXlBC54cikaRPg4BFsCzWEURwlbY68BMQvYYEADNy
	mRELCWO4ZKjkLeugLiC/IMIh0txmqKhM6Dl+4lQ/ylarsLlhJlm78cTD7ttTYyG3
	fdoTudxx1deiY9Rvopld9ZXN/d6r2Z+MvZG45pW1aPp9o/StPTKu8LChVGsC9Xkp
	Aj/E+hQFUzbUSLRhSTL6f91/t0lcqj+00M9qjdJSP64IXSXWiN6xLml9pEQdiLZT
	h03EqWmuMp0rkUn4m4KLt3AUtI11AHnCBUMZsCKrB8YW1S5aIGyVdRDnePi1XB1y
	w+kjUaAp5RLhHvBnQtc5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744207219; x=1744293619; bh=k
	kjJkpP/qG3JocRX+sZCvZRuvsILd4g+caXlZ1/Y6NE=; b=FFeLtOBkgDPqAFOhJ
	zsXkNFzgzlpKcNp5qAire4rOudU/06WRffAvpbiHNI4DEZf/eHkeuLzlahzWbpxd
	fb98zQbnHte3qNsAKuI1K5cqhEXW67oJyi6rheQolYFFrttyf4nNMP+x2BCjDn6C
	efY6JYghoJP0Qp1JudSYTgMedAPTqtpnw8/O18JljnSxQ44F7tyWF15Oj6dh5vdf
	74zIhw1NuQtzNLJ2iDRqW7Npjlr54ESZ5oRX8QT1lecJO3EDue7YZAAGtnhhMO+2
	bDePf/sTIDjPgxQ3pG/nkVfD4sRv0hJOyOgDR3mXzfzk9s4zk5k379UDon07Wf0e
	YIx1Q==
X-ME-Sender: <xms:c332Z-Sub6EoG7LNXPWb2u-w0TJL3HGYpI24tHuF4wBTZXLc2ij1EQ>
    <xme:c332Zzxr1E2cSlGcFV7CumFuHTuN8qadpbPiGaYhh8qfIoZ9IAKi9Kt5CK4GT_lsb
    Ei_J4q2vsHYJzLGa4Q>
X-ME-Received: <xmr:c332Z73oedaGz7lmJhiFEoj7qJzeiIlxp88a-KZbAb57mPD7u2aVzyPpVMo5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepieeiueeiteehtdefheekhffhgeev
    uefhteevueeljeeijeeiveehgfehudfghefgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshih
    shhnrghilhdrnhgvthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprg
    hnrgdrohhrghdrrghupdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehs
    vggtuhhnvghtrdgtohhm
X-ME-Proxy: <xmx:c332Z6BSIZJJJj0XMcI4olUnhVerBYsLhhaxTo75-Sypaea7hrssqQ>
    <xmx:c332Z3iyL1AaT8dTyZJqCnE5NaE6NNeiwAzHI3ya1QtbhkN2C_IYGg>
    <xmx:c332Z2ppLRagAy5ZM2ICoFxf6YkMlXFhFySA_UDF4WeDfptAwlFp4g>
    <xmx:c332Z6ivYMrcLL5DGFFcp-zE3myTYtRKnbAw-7m9tnFlSOlNi1DhNg>
    <xmx:c332Z1F_dYFcic7bmV7ZJRilwgA4-4n7-xIlGyphGpznDBPQD0m3zkY0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 10:00:18 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec 2/2] espintcp: remove encap socket caching to avoid reference leak
Date: Wed,  9 Apr 2025 15:59:57 +0200
Message-ID: <fba712655d0ec4003b28e432e5ba43d20f6d750f.1744206087.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744206087.git.sd@queasysnail.net>
References: <cover.1744206087.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/net/xfrm.h    |  1 -
 net/ipv4/esp4.c       | 49 ++++---------------------------------------
 net/ipv6/esp6.c       | 49 ++++---------------------------------------
 net/xfrm/xfrm_state.c |  3 ---
 4 files changed, 8 insertions(+), 94 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..7e698b0306a8 100644
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
index ad2202fa82f3..3acf6c14de08 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -840,9 +840,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		xfrm_nat_keepalive_state_updated(x);
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
-		if (x->encap_sk)
-			sock_put(rcu_dereference_raw(x->encap_sk));
-
 		xfrm_dev_state_delete(x);
 
 		/* All xfrm_state objects are created by xfrm_state_alloc.
-- 
2.49.0


