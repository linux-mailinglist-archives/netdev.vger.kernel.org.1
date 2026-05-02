Return-Path: <netdev+bounces-283361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJV5N/Bs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:18:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6759E4B0C7C
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955D63050A38
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21F23BCE3;
	Sat,  2 May 2026 03:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mMJZANg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB724886E
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691671; cv=none; b=T7P5tPjAAPQeehY9ISQP2KamhwDV05Z7ton53vUEfgDmAFZOEsYBCLvxqdh03bodXXNWtMp8jCBuNQKk38O5tVhn9KrcNgp8eX3OHJRW35ubEIhbf21HasevC6sbv/EBm9sclA0g9rMAWEHNSb8z95027kLLGW+J5sGGvRPX+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691671; c=relaxed/simple;
	bh=nOI0QpmxnAhqPSyTAwl9MIA76vGTjW/B6pwBQKGkqOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=egubGzyPz27JRNzjHa8yFGAsr0vW/bsT1KxFqptpnf9j9ciQ7lTJBghcya0Pn4edmNN8oYlJzVj/SLtI0EojuxuajwKL8E0KcecMX/ldzBs30hpE3Qv9/mx9LpUuANXIotkOwt4tNQHJXEbwZy1uxMUS0rRpTx2w74/jt7/85Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mMJZANg1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so3176374a91.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691669; x=1778296469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoVJQHU2VXzeQ578/WxXmITx2cg9c3+FxPCqpR/Hmz0=;
        b=mMJZANg1tDaA9w7S4Ccd/nXd93nmN06BNY/SmssM0EK9783neo4ROTcJsZJIM4Y85r
         QLiaUHR9i/TOu7pzpt/1HAErrwxsyricrsR+soP/ouZPP5Gq3wTX9s9vqyJkgIRL3ZSe
         smxPCylfJgCVjEKTHg9GRYtZuLgtab1UrWwmZMOPA6dn0PjG9vFH6e7AvNzZ5iuGtWBj
         TgtOHveYcsaadv+jP34vC+FDMFFRscrlzXpitZnAlYHV46a6aFz8YM6WM16SfmUwmT7f
         HOfHjX9r4rjMQpvoyechAPUk3/5Ib01FhX1pPx8cTWZc1Jsh5OqTAxVDpDPJfBy3gT8n
         HF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691669; x=1778296469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoVJQHU2VXzeQ578/WxXmITx2cg9c3+FxPCqpR/Hmz0=;
        b=gP6lPkBSfjFORAgn/LwpTk+jnPlJ4V+7ulplIbSWjgjf7325O8p1GnWgxbKmrR4BkJ
         aCtooK7fDLufbnnDAIokKkhKywzECTHlFLNsPUyKXTQ05sh8TuIBEOq+o2EvxLUJvznN
         JdUtf8kCB+q4ngjL/G4u8LEuBe0Jr9U6HZ99Xo4MiKBQBgKdcL8QElX2fkwUyHiebIqU
         BJCLpSxLBmxxlwiojT2Ur9GOaoDy78/qCUX3q+aCtP3bDdUeO/Xh03n6pRo5ix0LdG8M
         OAhXck2RqS2MVUPj359PHCOSYyigzMinMbrw8HbvNBk5CGsAnwQ6eQwWqKqdJrI2A/8d
         CZwA==
X-Forwarded-Encrypted: i=1; AFNElJ+wfJWb6hmGTXhtvuRrRnvtkPjwshXis2XFe2Jlq+y2/EdJtasj9sOKoRHjtHLPKDID4x95v0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLhOWOAlPpVw5YYioYYMxe315RDhoSEtQ5QeKMOcdUBf9rFER
	Y1oHWrRrMwt+upvkWzRaFTOSKdN0GXhiolUumd80uN2R0Xh4qClmXA0L4Rj+DsdYUo0jNWQUC31
	8QPuI7g==
X-Received: from pga20.prod.google.com ([2002:a05:6a02:4f94:b0:c79:7452:bccb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9190:b0:3a2:dbaa:82ee
 with SMTP id adf61e73a8af0-3a7f1a1dfabmr1774328637.9.1777691668944; Fri, 01
 May 2026 20:14:28 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:07 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-15-kuniyu@google.com>
Subject: [PATCH v1 net-next 14/15] tipc: Store struct sock in struct udp_bearer.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6759E4B0C7C
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283361-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

tipc udp_bearer does not need to access struct socket itself in
the fast path; it only reads struct sock, and struct socket is
only used for tunnel setup and teardown.

Let's store struct sock directly in struct udp_bearer.

Note that cleanup_bearer() calls synchronize_net() after
udp_tunnel_sock_release(), so udp_bearer is not freed until
inflight fast paths finish.

Note also that synchronize_rcu() is added in the error path
of tipc_udp_enable() since udp_bearer will be kfree()d
immediately once we remove synchronize_rcu() in
udp_tunnel_sock_release().

This can be later converted to kfree_rcu().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Jon Maloy <jmaloy@redhat.com>
---
 net/tipc/udp_media.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 0db172f1a41a..988b8a7f953a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -89,14 +89,14 @@ struct udp_replicast {
 /**
  * struct udp_bearer - ip/udp bearer data structure
  * @bearer:	associated generic tipc bearer
- * @ubsock:	bearer associated socket
+ * @sk:		bearer associated socket
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
  */
 struct udp_bearer {
 	struct tipc_bearer __rcu *bearer;
-	struct socket *ubsock;
+	struct sock *sk;
 	u32 ifindex;
 	struct work_struct work;
 	struct udp_replicast rcast;
@@ -194,7 +194,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
-		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
+		udp_tunnel_xmit_skb(rt, ub->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -206,7 +206,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				.saddr = src->ipv6,
 				.flowi6_proto = IPPROTO_UDP
 			};
-			ndst = ip6_dst_lookup_flow(net, ub->ubsock->sk,
+			ndst = ip6_dst_lookup_flow(net, ub->sk,
 						   &fl6, NULL);
 			if (IS_ERR(ndst)) {
 				err = PTR_ERR(ndst);
@@ -215,7 +215,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+		udp_tunnel6_xmit_skb(ndst, ub->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
 #endif
@@ -405,9 +405,9 @@ static int tipc_udp_recv(struct sock *sk, struct sk_buff *skb)
 
 static int enable_mcast(struct udp_bearer *ub, struct udp_media_addr *remote)
 {
-	int err = 0;
+	struct sock *sk = ub->sk;
 	struct ip_mreqn mreqn;
-	struct sock *sk = ub->ubsock->sk;
+	int err = 0;
 
 	if (ntohs(remote->proto) == ETH_P_IP) {
 		mreqn.imr_multiaddr = remote->ipv4;
@@ -670,6 +670,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 	struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
 	u8 node_id[NODE_ID_LEN] = {0,};
 	struct net_device *dev;
+	struct socket *sock;
 	int rmcast = 0;
 
 	ub = kzalloc_obj(*ub, GFP_ATOMIC);
@@ -764,14 +765,16 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		goto err;
 	}
 	udp_conf.local_udp_port = local.port;
-	err = udp_sock_create(net, &udp_conf, &ub->ubsock);
+	err = udp_sock_create(net, &udp_conf, &sock);
 	if (err)
 		goto err;
+
+	ub->sk = sock->sk;
 	tuncfg.sk_user_data = ub;
 	tuncfg.encap_type = 1;
 	tuncfg.encap_rcv = tipc_udp_recv;
 	tuncfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(net, ub->ubsock->sk, &tuncfg);
+	setup_udp_tunnel_sock(net, ub->sk, &tuncfg);
 
 	err = dst_cache_init(&ub->rcast.dst_cache, GFP_ATOMIC);
 	if (err)
@@ -793,7 +796,8 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 
 free:
 	dst_cache_destroy(&ub->rcast.dst_cache);
-	udp_tunnel_sock_release(ub->ubsock->sk);
+	udp_tunnel_sock_release(ub->sk);
+	synchronize_rcu();
 err:
 	kfree(ub);
 	return err;
@@ -812,10 +816,10 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
-	tn = tipc_net(sock_net(ub->ubsock->sk));
+	tn = tipc_net(sock_net(ub->sk));
 
 	dst_cache_destroy(&ub->rcast.dst_cache);
-	udp_tunnel_sock_release(ub->ubsock->sk);
+	udp_tunnel_sock_release(ub->sk);
 
 	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
@@ -833,11 +837,11 @@ static void tipc_udp_disable(struct tipc_bearer *b)
 		pr_err("UDP bearer instance not found\n");
 		return;
 	}
-	sock_set_flag(ub->ubsock->sk, SOCK_DEAD);
+	sock_set_flag(ub->sk, SOCK_DEAD);
 	RCU_INIT_POINTER(ub->bearer, NULL);
 
 	/* sock_release need to be done outside of rtnl lock */
-	atomic_inc(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
+	atomic_inc(&tipc_net(sock_net(ub->sk))->wq_count);
 	INIT_WORK(&ub->work, cleanup_bearer);
 	schedule_work(&ub->work);
 }
-- 
2.54.0.545.g6539524ca2-goog


