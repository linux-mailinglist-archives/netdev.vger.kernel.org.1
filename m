Return-Path: <netdev+bounces-283357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOEqErNs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3724B0C66
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75273041A46
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A382D73BC;
	Sat,  2 May 2026 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeH42+fo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079201DD525
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691664; cv=none; b=TCun8+rlI9xKpa2gUlT+pw0thpByXb5gz5tRcXWJpJkd3b2jlj+U/2keHAr3KAFpgzgw2u/MyapuXH3e+qeLCcuZ0SvupVr9gkhTkIw9t7FCzjQCjKj1E8cTSg+gTHYYE7pemgED5+3lwCRwRz9SJQxdChjV965n1WXGLL15Kws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691664; c=relaxed/simple;
	bh=2oles8M/acIHbxQiZch7zBIIF+DRyJoPonI8jZjak2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qg3dlbPqXX6FE6u1LUf/Am2OrYBu/lIo1593R6yliedPiEFickZoR9hDX5mRMRRBINBQMQ90m0pv0G8ud3y+qR4tFdw6IH+Cjg3x8wbj2UcrZWyGjLH5UVmhtg4QHzL9YWHtwy9hC5GSWrnNJFWdv92kb48WQcr0at3HNlG+cXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeH42+fo; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365031fb8c6so693794a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691662; x=1778296462; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oueSNPlIny1k4pSsg9F1GjjvoK0fPLzCFyyqRckhxZE=;
        b=OeH42+fomqtBbNwwhT14ULbE6phMJV/JkCuN4O2wSdU0NOGE0VYOfrW/IvSejhfbCz
         z7kX5BafWb1iFWyEJOmRqOpmoxUyuJC6q4w6wpfPkbvEDKeZCc8DC52oG/79FkQeHdDC
         vjlnfZaJahbvFBKrNiqTcReXfeyroFJOfz+eOGMmCcTtXa7jgKYNdlT+kwhKyM5vcQwG
         thSboroIPLg3yGUSS/CG5IyqDYyGA1OwsdH/f5pQqFocD7bh98RrBtCreBMGqA0CN6jX
         kB/KE9oV9ASODNLWLUqL165QMlAO0ip53E6NhFInVAuPBLVKYXo6EwrCbeLE0r1Gn0Vp
         7mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691662; x=1778296462;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oueSNPlIny1k4pSsg9F1GjjvoK0fPLzCFyyqRckhxZE=;
        b=GiTKeMj5kJqM3qut2l+Qa32GkrLFJemiLrZAgaHW6w+lDawFz4yP64D4t8oALOT2GW
         h7ljd1n6USOsLS869oQHj1E36Mnhvwa3R+TWt9GryqsIYPp0vpMkwrdLmVrkR4snJNbg
         wNcFAl/NJgaQtcAJ4s9ljP6z4WoRSgW3l1OxBgDEbLJRmNuR1TZmHA2cU6AoWnyska7L
         OlQP1PbSesnWKLgpPMUS9yiUSmtzhWNseGQ0WPP+WgJeEsohD3EfrIn/8knbcKDPiE50
         M9nA1pZbigK8nOTkTJuKxWUwlH9HkCEr0igc/nXOsQEPXLxeves+oM2H3K862jrxOuOq
         BR8g==
X-Forwarded-Encrypted: i=1; AFNElJ9/W/vKDnQcts0py9aMsO9nxm3j/eVB6huuwokYiK4uLyslrZgBTaSCLNsJaqKzOnMetayG6jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCms5fKqwR/EGfzhjcoTU6nfSOtVxj6ZC5YeJP7q9HQdYln+Js
	lXWi0JSS9czwwonIjY3E4e9Yno77jZU2YRyKAlFON1y8rESyospxSsxQjv7fxiZgZaw3M5+NSMs
	Rnla0iQ==
X-Received: from pggs17.prod.google.com ([2002:a63:dc11:0:b0:c79:482d:d039])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:3a2:cf6d:a9f7
 with SMTP id adf61e73a8af0-3a7f1c6cbd9mr1499379637.36.1777691662051; Fri, 01
 May 2026 20:14:22 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:03 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-11-kuniyu@google.com>
Subject: [PATCH v1 net-next 10/15] bareudp: Store struct sock in struct bareudp_dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BB3724B0C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283357-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

bareudp does not need to access struct socket itself in the fast
path; it only reads struct sock, and struct socket is only used
for tunnel setup and teardown.

Let's store struct sock directly in struct bareudp_dev.

bareudp_sock_release() is called from dev->netdev_ops->ndo_stop().
synchronize_net() in unregister_netdevice_many_notify() ensures that
inflight bareudp RX fast paths finish before bareudp_dev is freed.

bareudp no longer needs synchronize_rcu() in udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c | 51 +++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 073ac8a15354..890a0650d9cf 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -53,7 +53,7 @@ struct bareudp_dev {
 	__be16             port;
 	u16	           sport_min;
 	bool               multi_proto_mode;
-	struct socket      __rcu *sock;
+	struct sock        __rcu *sk;
 	struct list_head   next;        /* bareudp node  on namespace list */
 	struct gro_cells   gro_cells;
 };
@@ -228,7 +228,7 @@ static void bareudp_uninit(struct net_device *dev)
 	gro_cells_destroy(&bareudp->gro_cells);
 }
 
-static struct socket *bareudp_create_sock(struct net *net, __be16 port)
+static struct sock *bareudp_create_sock(struct net *net, __be16 port)
 {
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
@@ -248,18 +248,18 @@ static struct socket *bareudp_create_sock(struct net *net, __be16 port)
 		return ERR_PTR(err);
 
 	udp_allow_gso(sock->sk);
-	return sock;
+	return sock->sk;
 }
 
 /* Create new listen socket if needed */
 static int bareudp_socket_create(struct bareudp_dev *bareudp, __be16 port)
 {
 	struct udp_tunnel_sock_cfg tunnel_cfg;
-	struct socket *sock;
+	struct sock *sk;
 
-	sock = bareudp_create_sock(bareudp->net, port);
-	if (IS_ERR(sock))
-		return PTR_ERR(sock);
+	sk = bareudp_create_sock(bareudp->net, port);
+	if (IS_ERR(sk))
+		return PTR_ERR(sk);
 
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
@@ -268,29 +268,27 @@ static int bareudp_socket_create(struct bareudp_dev *bareudp, __be16 port)
 	tunnel_cfg.encap_rcv = bareudp_udp_encap_recv;
 	tunnel_cfg.encap_err_lookup = bareudp_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(bareudp->net, sock->sk, &tunnel_cfg);
+	setup_udp_tunnel_sock(bareudp->net, sk, &tunnel_cfg);
 
-	rcu_assign_pointer(bareudp->sock, sock);
+	rcu_assign_pointer(bareudp->sk, sk);
 	return 0;
 }
 
 static int bareudp_open(struct net_device *dev)
 {
 	struct bareudp_dev *bareudp = netdev_priv(dev);
-	int ret = 0;
 
-	ret =  bareudp_socket_create(bareudp, bareudp->port);
-	return ret;
+	return bareudp_socket_create(bareudp, bareudp->port);
 }
 
 static void bareudp_sock_release(struct bareudp_dev *bareudp)
 {
-	struct socket *sock;
+	struct sock *sk;
 
-	sock = bareudp->sock;
-	rcu_assign_pointer(bareudp->sock, NULL);
+	sk = bareudp->sk;
+	rcu_assign_pointer(bareudp->sk, NULL);
 	synchronize_net();
-	udp_tunnel_sock_release(sock->sk);
+	udp_tunnel_sock_release(sk);
 }
 
 static int bareudp_stop(struct net_device *dev)
@@ -308,7 +306,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	bool xnet = !net_eq(bareudp->net, dev_net(bareudp->dev));
 	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct socket *sock = rcu_dereference(bareudp->sock);
+	struct sock *sk = rcu_dereference(bareudp->sk);
 	const struct ip_tunnel_key *key = &info->key;
 	struct rtable *rt;
 	__be16 sport, df;
@@ -320,7 +318,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
-	if (!sock)
+	if (!sk)
 		return -ESHUTDOWN;
 
 	sport = udp_flow_src_port(bareudp->net, skb,
@@ -359,7 +357,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	skb_set_inner_protocol(skb, bareudp->ethertype);
-	udp_tunnel_xmit_skb(rt, sock->sk, skb, saddr, info->key.u.ipv4.dst,
+	udp_tunnel_xmit_skb(rt, sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, bareudp->port,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
@@ -378,7 +376,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	bool xnet = !net_eq(bareudp->net, dev_net(bareudp->dev));
 	bool use_cache = ip_tunnel_dst_cache_usable(skb, info);
-	struct socket *sock  = rcu_dereference(bareudp->sock);
+	struct sock *sk = rcu_dereference(bareudp->sk);
 	const struct ip_tunnel_key *key = &info->key;
 	struct dst_entry *dst = NULL;
 	struct in6_addr saddr, daddr;
@@ -390,13 +388,13 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
-	if (!sock)
+	if (!sk)
 		return -ESHUTDOWN;
 
 	sport = udp_flow_src_port(bareudp->net, skb,
 				  bareudp->sport_min, USHRT_MAX,
 				  true);
-	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock->sk, 0, &saddr,
+	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sk, 0, &saddr,
 				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
 				     (struct dst_cache *) &info->dst_cache : NULL);
@@ -427,7 +425,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		goto free_dst;
 
 	daddr = info->key.u.ipv6.dst;
-	udp_tunnel6_xmit_skb(dst, sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dst, sk, skb, dev,
 			     &saddr, &daddr, prio, ttl,
 			     info->key.label, sport, bareudp->port,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
@@ -527,12 +525,13 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 	} else if (ip_tunnel_info_af(info) == AF_INET6) {
 		struct dst_entry *dst;
 		struct in6_addr saddr;
-		struct socket *sock = rcu_dereference(bareudp->sock);
+		struct sock *sk;
 
-		if (!sock)
+		sk = rcu_dereference(bareudp->sk);
+		if (!sk)
 			return -ESHUTDOWN;
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock->sk,
+		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sk,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
 					     use_cache ? &info->dst_cache : NULL);
-- 
2.54.0.545.g6539524ca2-goog


