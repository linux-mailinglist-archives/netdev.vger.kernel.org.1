Return-Path: <netdev+bounces-283359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH0zOs9s9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 685264B0C74
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8388E30479FB
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9902D3225;
	Sat,  2 May 2026 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6v4cuUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFB2D73BC
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691668; cv=none; b=noO8saaxeLO5n0STsM9vIFfbKx8jsj4mW3vl8pbCGOqpCLIKeQ2FDeEmiJAiOCuHv4qapwvdD99wb62kfM1Hbo39ivN7I+QvCnGGllvrbgfABXWsBxKyNMvZdqmhGm4JSF7hZDm/uAeaj+ljwZ2/uYchN71qNW1YJb+Bfm4d+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691668; c=relaxed/simple;
	bh=QBSsKZpKVWmnEIzQQIowbKY1SsGwMQtE3SEj3Pf4bI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XD9riNtk6y1vPvZoCDwX+X7yFAWU6SWwvGXBCQx7YNjXlj0NasFefP1gc60fzKH00hRZJSN3TNits4R15pAoyEywlfsc01141nOhKqSOIbkHSE4/N3p6ut64yqUawlaaG6A4VAGwCjlGia17Dz51a8te8oc0BdWWCH7LF8bfEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d6v4cuUV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so2303890b3a.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691666; x=1778296466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ce9vPr3kbqgr1M/qTD++whXBYX/TnPp46Z8KJPZ27MM=;
        b=d6v4cuUVg0l8sn6e3Z+2NsOiVFV3090mGxqJlcyp2WRcRBCoezN5Giv28bvZItYiYy
         fiipoy+0429yBNfAo3E3il0+Rlplgm+U7enH58owVFlAEcXM7fX3mmgNd11Tb7p3m0dN
         rRJf1ChUxsRc0hsPg8olbxqLBE4kx5VTUWpWF+WJyYXtKyMJ2dZkKw7Hn3yF+aB3VAWW
         zLumBU5PBYT0uxPFov23Y9GrftsTDsYEgDrcNmpAtXI1/tE/zPBcuNuJjnqHApY6xfoR
         PuC3RUwQBjgGvKRsRxFK0uh6qyOicuTo6gcyW0ds2fc7Oe06mM6JMedtKtgDbriJHRLU
         nTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691666; x=1778296466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ce9vPr3kbqgr1M/qTD++whXBYX/TnPp46Z8KJPZ27MM=;
        b=fs9fjtqK4EQxDS0XaZQO+LLd3mbyGoTGh/GINDCf9bTo5Lv0uavl1BMkpNi472rC6x
         JkvvrRGLMjnk+PFZ+UTs58IbC3tHLHUgR6h/dISmoP7lLhG/4Ap+KqYnpt3WEHx635RD
         MKSnmUFhlhrtjoI49COhmmuPZJu0QuxET2iDIz9XAwao+SM+gKNYCqkUI/H0SYrjxnzi
         QaZ7XBBzQI3ekubruO+MjIlfaEB3CoAEp4kcvi3Nhrrem68MZKxLpFWuZbxV60R/S6rf
         ndPKwHOlU7daijCtpRkwjCZe8j9nrXjo5JhIGisDRXE+/I3LUekVgvxEAKpo7946vxxl
         wakA==
X-Forwarded-Encrypted: i=1; AFNElJ++mihTGSOewov/mbqSTjCDnQKZUAXxlQkNZrA4AYBCJBSZUbye9DdAlaanOdIcbNsXu4PmsLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4tXXLCznfR6gB73a8skBjCXwurTUco/aI4iutS/A0oW2tAM6
	/SjigfDuVYdFqwYvehSFy090fDI/Fwy3f3uTJEIeen6RYohQazzd6QCwiBmEjOqAl804hWPrtlE
	RkFlW3A==
X-Received: from pfbgj12.prod.google.com ([2002:a05:6a00:840c:b0:82f:4d28:b8c5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a8d:b0:81f:5acb:55fc
 with SMTP id d2e1a72fcca58-8352c3dacb4mr1470250b3a.10.1777691665488; Fri, 01
 May 2026 20:14:25 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:05 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-13-kuniyu@google.com>
Subject: [PATCH v1 net-next 12/15] amt: Store struct sock in struct amt_dev.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 685264B0C74
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
	TAGGED_FROM(0.00)[bounces-283359-lists,netdev=lfdr.de];
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

amt does not need to access struct socket itself in the fast path;
it only reads struct sock, and struct socket is only used for tunnel
setup and teardown.

Let's store struct sock directly in struct amt.

amt_dev_stop() is called as dev->netdev_ops->ndo_stop().
synchronize_net() in unregister_netdevice_many_notify() ensures
that inflight amt RX fast paths finish before amt_dev is freed.

amt no longer needs synchronize_rcu() in udp_tunnel_sock_release().

Note that amt_dev_stop() looks buggy; cancel_delayed_work_sync()
should be called after udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
CC: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/amt.c | 80 +++++++++++++++++++++++------------------------
 include/net/amt.h |  2 +-
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c03aa7c207e6..724a8163a514 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -614,24 +614,24 @@ static void amt_send_discovery(struct amt_dev *amt)
 {
 	struct amt_header_discovery *amtd;
 	int hlen, tlen, offset;
-	struct socket *sock;
 	struct udphdr *udph;
 	struct sk_buff *skb;
 	struct iphdr *iph;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	struct sock *sk;
 	u32 len;
 	int err;
 
 	rcu_read_lock();
-	sock = rcu_dereference(amt->sock);
-	if (!sock)
+	sk = rcu_dereference(amt->sk);
+	if (!sk)
 		goto out;
 
 	if (!netif_running(amt->stream_dev) || !netif_running(amt->dev))
 		goto out;
 
-	rt = ip_route_output_ports(amt->net, &fl4, sock->sk,
+	rt = ip_route_output_ports(amt->net, &fl4, sk,
 				   amt->discovery_ip, amt->local_ip,
 				   amt->gw_port, amt->relay_port,
 				   IPPROTO_UDP, 0,
@@ -690,7 +690,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb->ip_summed = CHECKSUM_NONE;
 	ip_select_ident(amt->net, skb, NULL);
 	ip_send_check(iph);
-	err = ip_local_out(amt->net, sock->sk, skb);
+	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		amt->dev->stats.tx_errors++;
 
@@ -703,24 +703,24 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 {
 	struct amt_header_request *amtrh;
 	int hlen, tlen, offset;
-	struct socket *sock;
 	struct udphdr *udph;
 	struct sk_buff *skb;
 	struct iphdr *iph;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	struct sock *sk;
 	u32 len;
 	int err;
 
 	rcu_read_lock();
-	sock = rcu_dereference(amt->sock);
-	if (!sock)
+	sk = rcu_dereference(amt->sk);
+	if (!sk)
 		goto out;
 
 	if (!netif_running(amt->stream_dev) || !netif_running(amt->dev))
 		goto out;
 
-	rt = ip_route_output_ports(amt->net, &fl4, sock->sk,
+	rt = ip_route_output_ports(amt->net, &fl4, sk,
 				   amt->remote_ip, amt->local_ip,
 				   amt->gw_port, amt->relay_port,
 				   IPPROTO_UDP, 0,
@@ -781,7 +781,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb->ip_summed = CHECKSUM_NONE;
 	ip_select_ident(amt->net, skb, NULL);
 	ip_send_check(iph);
-	err = ip_local_out(amt->net, sock->sk, skb);
+	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		amt->dev->stats.tx_errors++;
 
@@ -1000,14 +1000,14 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 				       bool v6)
 {
 	struct amt_header_membership_update *amtmu;
-	struct socket *sock;
 	struct iphdr *iph;
 	struct flowi4 fl4;
 	struct rtable *rt;
+	struct sock *sk;
 	int err;
 
-	sock = rcu_dereference_bh(amt->sock);
-	if (!sock)
+	sk = rcu_dereference_bh(amt->sk);
+	if (!sk)
 		return true;
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(amt->dev) + sizeof(*amtmu) +
@@ -1039,7 +1039,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(rt, sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
@@ -1060,14 +1060,14 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 				    bool v6)
 {
 	struct amt_header_mcast_data *amtmd;
-	struct socket *sock;
 	struct sk_buff *skb;
 	struct iphdr *iph;
 	struct flowi4 fl4;
 	struct rtable *rt;
+	struct sock *sk;
 
-	sock = rcu_dereference_bh(amt->sock);
-	if (!sock)
+	sk = rcu_dereference_bh(amt->sk);
+	if (!sk)
 		return;
 
 	skb = skb_copy_expand(oskb, sizeof(*amtmd) + sizeof(*iph) +
@@ -1097,7 +1097,7 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(rt, sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
@@ -1116,13 +1116,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 				      bool v6)
 {
 	struct amt_header_membership_query *amtmq;
-	struct socket *sock;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	struct sock *sk;
 	int err;
 
-	sock = rcu_dereference_bh(amt->sock);
-	if (!sock)
+	sk = rcu_dereference_bh(amt->sk);
+	if (!sk)
 		return true;
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(amt->dev) + sizeof(*amtmq) +
@@ -1156,7 +1156,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
 	else
 		skb_set_inner_protocol(skb, htons(ETH_P_IPV6));
-	udp_tunnel_xmit_skb(rt, sock->sk, skb,
+	udp_tunnel_xmit_skb(rt, sk, skb,
 			    fl4.saddr,
 			    fl4.daddr,
 			    AMT_TOS,
@@ -2554,24 +2554,24 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 {
 	struct amt_header_advertisement *amta;
 	int hlen, tlen, offset;
-	struct socket *sock;
 	struct udphdr *udph;
 	struct sk_buff *skb;
 	struct iphdr *iph;
 	struct rtable *rt;
 	struct flowi4 fl4;
+	struct sock *sk;
 	u32 len;
 	int err;
 
 	rcu_read_lock();
-	sock = rcu_dereference(amt->sock);
-	if (!sock)
+	sk = rcu_dereference(amt->sk);
+	if (!sk)
 		goto out;
 
 	if (!netif_running(amt->stream_dev) || !netif_running(amt->dev))
 		goto out;
 
-	rt = ip_route_output_ports(amt->net, &fl4, sock->sk,
+	rt = ip_route_output_ports(amt->net, &fl4, sk,
 				   daddr, amt->local_ip,
 				   dport, amt->relay_port,
 				   IPPROTO_UDP, 0,
@@ -2631,7 +2631,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb->ip_summed = CHECKSUM_NONE;
 	ip_select_ident(amt->net, skb, NULL);
 	ip_send_check(iph);
-	err = ip_local_out(amt->net, sock->sk, skb);
+	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
 		amt->dev->stats.tx_errors++;
 
@@ -2944,7 +2944,7 @@ static int amt_err_lookup(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-static struct socket *amt_create_sock(struct net *net, __be16 port)
+static struct sock *amt_create_sock(struct net *net, __be16 port)
 {
 	struct udp_port_cfg udp_conf;
 	struct socket *sock;
@@ -2960,17 +2960,17 @@ static struct socket *amt_create_sock(struct net *net, __be16 port)
 	if (err < 0)
 		return ERR_PTR(err);
 
-	return sock;
+	return sock->sk;
 }
 
 static int amt_socket_create(struct amt_dev *amt)
 {
 	struct udp_tunnel_sock_cfg tunnel_cfg;
-	struct socket *sock;
+	struct sock *sk;
 
-	sock = amt_create_sock(amt->net, amt->relay_port);
-	if (IS_ERR(sock))
-		return PTR_ERR(sock);
+	sk = amt_create_sock(amt->net, amt->relay_port);
+	if (IS_ERR(sk))
+		return PTR_ERR(sk);
 
 	/* Mark socket as an encapsulation socket */
 	memset(&tunnel_cfg, 0, sizeof(tunnel_cfg));
@@ -2979,9 +2979,9 @@ static int amt_socket_create(struct amt_dev *amt)
 	tunnel_cfg.encap_rcv = amt_rcv;
 	tunnel_cfg.encap_err_lookup = amt_err_lookup;
 	tunnel_cfg.encap_destroy = NULL;
-	setup_udp_tunnel_sock(amt->net, sock->sk, &tunnel_cfg);
+	setup_udp_tunnel_sock(amt->net, sk, &tunnel_cfg);
 
-	rcu_assign_pointer(amt->sock, sock);
+	rcu_assign_pointer(amt->sk, sk);
 	return 0;
 }
 
@@ -3019,8 +3019,8 @@ static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
 	struct amt_tunnel_list *tunnel, *tmp;
-	struct socket *sock;
 	struct sk_buff *skb;
+	struct sock *sk;
 	int i;
 
 	cancel_delayed_work_sync(&amt->req_wq);
@@ -3028,11 +3028,11 @@ static int amt_dev_stop(struct net_device *dev)
 	cancel_delayed_work_sync(&amt->secret_wq);
 
 	/* shutdown */
-	sock = rtnl_dereference(amt->sock);
-	RCU_INIT_POINTER(amt->sock, NULL);
+	sk = rtnl_dereference(amt->sk);
+	RCU_INIT_POINTER(amt->sk, NULL);
 	synchronize_net();
-	if (sock)
-		udp_tunnel_sock_release(sock->sk);
+	if (sk)
+		udp_tunnel_sock_release(sk);
 
 	cancel_work_sync(&amt->event_wq);
 	for (i = 0; i < AMT_MAX_EVENTS; i++) {
diff --git a/include/net/amt.h b/include/net/amt.h
index c881bc8b673b..a0255491f5b0 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -331,7 +331,7 @@ struct amt_dev {
 	enum amt_status		status;
 	/* Generated key */
 	siphash_key_t		key;
-	struct socket	  __rcu *sock;
+	struct sock	  __rcu *sk;
 	u32			max_groups;
 	u32			max_sources;
 	u32			hash_buckets;
-- 
2.54.0.545.g6539524ca2-goog


