Return-Path: <netdev+bounces-283356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HZSDKRs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA34B0C5F
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7DF303F049
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3D1E5B68;
	Sat,  2 May 2026 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sklnti39"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA825782D
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691663; cv=none; b=E7JkehOTUzlWR2Q8cZLdchj/tB59WjeoSyAdekDqvqnce4cxcz9GeSuQa7sU72snXj+S9TQg5Bn9p8M3oaxx7VyDsMmY15cdLZ3BoM96+OgulCFD+bQ6kf3sf6GEWmak3KbJaczQHsMeH+GLdAl58kJ1Pytf8y4nIU1w3qZs7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691663; c=relaxed/simple;
	bh=/k9fKV38cjmHdlczsBGdSARv8/083/Wo4acMHXeW51Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fg7NQI7RLGNNssjaKuUogCQZsrnnsi6SpfHqVi+X9p5o104hCLfKh9hfcHHQVos5F0Rx2XwXsELPFh+RN7hhK9woUF3cFPUiQ972PX+LoSexGcwxGpaadoBOdInGtBzy/gz1q9kIU2YHERleaIUqECn+VbrMz9WvH27DEgotf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sklnti39; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-834e0452d98so3418290b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691661; x=1778296461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8VaMDxu2h/4/wZu2WRImhK3DOnZku42IU243eovHt0=;
        b=Sklnti39P/LfYFzmng/A8lBKQw3giOOLuawO32zzuQ5D9cxK4UMjM/SQXNNZNlgknK
         DCKQJ5oeBSCIZS65ia9LLcTmS4atqy0et/lQDIDmxokzHBdzml5BUPPGq11EYsKmBiKS
         fCNmVGl4Pfh5NZAYt9npi8BUgqwqOEtCFlhKBkKinpr2Z3Bi2ctyRLXmnjH201r2nVop
         +uW1zf24uVI+6qQ2T431BctkMGSoOgfqCvKuw5PkLxvPBQLY0VapKOS5iMpCzQ8BZlpw
         C96kXsmdtgwfxiC5iw7XK7WpP8CuXu+K4TZFpjnV3ZT+AHeS7JWgpl71fAWexXYTEZBN
         WVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691661; x=1778296461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8VaMDxu2h/4/wZu2WRImhK3DOnZku42IU243eovHt0=;
        b=D73jwEJNWF79LgaJLeS1TWIYWwl0tBaNWCSElgD0AD6l3SmESi52YmwcUM/MFmEhXM
         YJs8GM99OamhfzmFtghIW/0k3g5SdsYuGvsAU95ZtJNg7UISe1igBL2Pews5hVKl/KrZ
         zAsC/gYzrc3MQ0k/GSacpwKbhtg6nEcNmZ3ZdUhzAHJGfdfq729iywBuxZqgiQ3+lFOW
         Ox2cU5NhjVamvcb2c9qlXKRPeRTGxXeDDex+8ed8helbcJsCLEy5RuTSwuRq+4bQ6rPz
         L7l2qMfZ5QhCSA5oSOzIr9oMNe4LdBrwsmuInNtxlJkbhJYMlRNNZjnQz5D+8j76ik6W
         62RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FEwW32KKQU4qMHBBET6IE5RbRW+28lG178SDGNqzq6VbNy/4VKdiQ+1vShp+bQUBjMMiFGN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYYkL0pvS4L/fop1V99DGYIIMGCYPUELBSc5W7NocinPH0FyKf
	b1i6p6l/B+Cj7DF+rInuSc3pBF23lWKHUBOKn/9bM2cyfs/kJeAyUayN2qCwmRqAp+Y8wS6vW/h
	DgtiEqg==
X-Received: from pfbho20.prod.google.com ([2002:a05:6a00:8814:b0:82f:36fa:1a58])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:883:b0:82f:3ecc:c42f
 with SMTP id d2e1a72fcca58-8352d257262mr1647947b3a.40.1777691660354; Fri, 01
 May 2026 20:14:20 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:02 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-10-kuniyu@google.com>
Subject: [PATCH v1 net-next 09/15] geneve: Store struct sock in struct geneve_sock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C3BA34B0C5F
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
	TAGGED_FROM(0.00)[bounces-283356-lists,netdev=lfdr.de];
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

geneve does not need to access struct socket itself in the fast
path; it only reads struct sock, and struct socket is only used for
tunnel setup and teardown.

Let's store struct sock directly in struct geneve_sock.

__geneve_sock_release() frees geneve_sock with kfree_rcu(), so
geneve no longer needs synchronize_rcu() in udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/geneve.c | 54 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9cf62d3ee471..b36fad833724 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -106,7 +106,7 @@ struct geneve_sock {
 	bool			collect_md;
 	bool			gro_hint;
 	struct list_head	list;
-	struct socket		*sock;
+	struct sock		*sk;
 	struct rcu_head		rcu;
 	int			refcnt;
 	struct hlist_head	vni_list[VNI_HASH_SIZE];
@@ -167,7 +167,7 @@ static bool eq_tun_id_and_vni(u8 *tun_id, u8 *vni)
 
 static sa_family_t geneve_get_sk_family(struct geneve_sock *gs)
 {
-	return gs->sock->sk->sk_family;
+	return gs->sk->sk_family;
 }
 
 static struct geneve_dev *geneve_lookup(struct geneve_sock *gs,
@@ -760,11 +760,11 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return -EPFNOSUPPORT;
 }
 
-static struct socket *geneve_create_sock(struct net *net, bool ipv6,
-					 __be16 port, bool ipv6_rx_csum)
+static struct sock *geneve_create_sock(struct net *net, bool ipv6,
+				       __be16 port, bool ipv6_rx_csum)
 {
-	struct socket *sock;
 	struct udp_port_cfg udp_conf;
+	struct socket *sock;
 	int err;
 
 	memset(&udp_conf, 0, sizeof(udp_conf));
@@ -786,7 +786,7 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 		return ERR_PTR(err);
 
 	udp_allow_gso(sock->sk);
-	return sock;
+	return sock->sk;
 }
 
 static bool geneve_hdr_match(struct sk_buff *skb,
@@ -974,28 +974,28 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 						bool ipv6, bool ipv6_rx_csum)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
-	struct geneve_sock *gs;
-	struct socket *sock;
 	struct udp_tunnel_sock_cfg tunnel_cfg;
+	struct geneve_sock *gs;
+	struct sock *sk;
 	int h;
 
 	gs = kzalloc_obj(*gs);
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
-	if (IS_ERR(sock)) {
+	sk = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	if (IS_ERR(sk)) {
 		kfree(gs);
-		return ERR_CAST(sock);
+		return ERR_CAST(sk);
 	}
 
-	gs->sock = sock;
+	gs->sk = sk;
 	gs->refcnt = 1;
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&gs->vni_list[h]);
 
 	/* Initialize the geneve udp offloads structure */
-	udp_tunnel_notify_add_rx_port(gs->sock->sk, UDP_TUNNEL_TYPE_GENEVE);
+	udp_tunnel_notify_add_rx_port(sk, UDP_TUNNEL_TYPE_GENEVE);
 
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
@@ -1006,7 +1006,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	tunnel_cfg.encap_rcv = geneve_udp_encap_recv;
 	tunnel_cfg.encap_err_lookup = geneve_udp_encap_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(net, sock->sk, &tunnel_cfg);
+	setup_udp_tunnel_sock(net, sk, &tunnel_cfg);
 	list_add(&gs->list, &gn->sock_list);
 	return gs;
 }
@@ -1017,8 +1017,8 @@ static void __geneve_sock_release(struct geneve_sock *gs)
 		return;
 
 	list_del(&gs->list);
-	udp_tunnel_notify_del_rx_port(gs->sock->sk, UDP_TUNNEL_TYPE_GENEVE);
-	udp_tunnel_sock_release(gs->sock->sk);
+	udp_tunnel_notify_del_rx_port(gs->sk, UDP_TUNNEL_TYPE_GENEVE);
+	udp_tunnel_sock_release(gs->sk);
 	kfree_rcu(gs, rcu);
 }
 
@@ -1048,7 +1048,7 @@ static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
-		if (inet_sk(gs->sock->sk)->inet_sport == dst_port &&
+		if (inet_sk(gs->sk)->inet_sport == dst_port &&
 		    geneve_get_sk_family(gs) == family &&
 		    gs->gro_hint == gro_hint) {
 			return gs;
@@ -1390,7 +1390,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel_xmit_skb(rt, gs4->sock->sk, skb, saddr, info->key.u.ipv4.dst,
+	udp_tunnel_xmit_skb(rt, gs4->sk, skb, saddr, info->key.u.ipv4.dst,
 			    tos, ttl, df, sport, geneve->cfg.info.key.tp_dst,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
@@ -1424,7 +1424,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				  geneve->cfg.port_min,
 				  geneve->cfg.port_max, true);
 
-	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock->sk, 0,
+	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sk, 0,
 				     &saddr, key, sport,
 				     geneve->cfg.info.key.tp_dst, prio,
 				     use_cache ?
@@ -1480,7 +1480,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (unlikely(err))
 		return err;
 
-	udp_tunnel6_xmit_skb(dst, gs6->sock->sk, skb, dev,
+	udp_tunnel6_xmit_skb(dst, gs6->sk, skb, dev,
 			     &saddr, &key->u.ipv6.dst, prio, ttl,
 			     info->key.label, sport, geneve->cfg.info.key.tp_dst,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
@@ -1592,7 +1592,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					  geneve->cfg.port_min,
 					  geneve->cfg.port_max, true);
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock->sk, 0,
+		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sk, 0,
 					     &saddr, &info->key, sport,
 					     geneve->cfg.info.key.tp_dst, prio,
 					     use_cache ? &info->dst_cache : NULL);
@@ -1654,10 +1654,10 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
 		if (push) {
-			udp_tunnel_push_rx_port(dev, gs->sock->sk,
+			udp_tunnel_push_rx_port(dev, gs->sk,
 						UDP_TUNNEL_TYPE_GENEVE);
 		} else {
-			udp_tunnel_drop_rx_port(dev, gs->sock->sk,
+			udp_tunnel_drop_rx_port(dev, gs->sk,
 						UDP_TUNNEL_TYPE_GENEVE);
 		}
 	}
@@ -2183,12 +2183,12 @@ static void geneve_quiesce(struct geneve_dev *geneve, struct geneve_sock **gs4,
 	*gs4 = rtnl_dereference(geneve->sock4);
 	rcu_assign_pointer(geneve->sock4, NULL);
 	if (*gs4)
-		rcu_assign_sk_user_data((*gs4)->sock->sk, NULL);
+		rcu_assign_sk_user_data((*gs4)->sk, NULL);
 #if IS_ENABLED(CONFIG_IPV6)
 	*gs6 = rtnl_dereference(geneve->sock6);
 	rcu_assign_pointer(geneve->sock6, NULL);
 	if (*gs6)
-		rcu_assign_sk_user_data((*gs6)->sock->sk, NULL);
+		rcu_assign_sk_user_data((*gs6)->sk, NULL);
 #else
 	*gs6 = NULL;
 #endif
@@ -2201,11 +2201,11 @@ static void geneve_unquiesce(struct geneve_dev *geneve, struct geneve_sock *gs4,
 {
 	rcu_assign_pointer(geneve->sock4, gs4);
 	if (gs4)
-		rcu_assign_sk_user_data(gs4->sock->sk, gs4);
+		rcu_assign_sk_user_data(gs4->sk, gs4);
 #if IS_ENABLED(CONFIG_IPV6)
 	rcu_assign_pointer(geneve->sock6, gs6);
 	if (gs6)
-		rcu_assign_sk_user_data(gs6->sock->sk, gs6);
+		rcu_assign_sk_user_data(gs6->sk, gs6);
 #endif
 	synchronize_net();
 }
-- 
2.54.0.545.g6539524ca2-goog


