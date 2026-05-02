Return-Path: <netdev+bounces-283354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCIBGoxs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D0B4B0C50
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC9B9303A90A
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ADA2D12ED;
	Sat,  2 May 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IG1pd9TB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F12D6407
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691659; cv=none; b=EoI7JyGYOg0R07/i3BThvjDgPJXRPF1azzIk2UwCx2fGFnd6Wonz+Q0xliRl4nHgva4Ui3fHlSfqSkSa3hntH/pDZybIL0qOYd30ze0wcjAt2tuGY+AQLBCzPJNjTeQb7I+oUxOWT8B9QWW4Y84sN7+0/BHBoXOBTLfttjsga1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691659; c=relaxed/simple;
	bh=fGh938ZDYpkf6XlooRVrEVTSxKM5gsf/6erOxPdai6o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7EXbklYgEs8QVNBbTDuHANGnj070YIMjllE97q2oRWQsehNsnEIbGnYtjvD1qMeL+S5vfkjK0IlfyLu+rQxTirYBZZFJyKmkTE4RGCMxFyT8/z0RYoC38Y0ghQDtvP3UMVDlo9UY7gfdc3xGxXCC/zCyx2ZIWL3N1LoZ55Z/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IG1pd9TB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso6306622a91.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691657; x=1778296457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4VP8vbyQc1rGO2EisoicHamzyPT3B0ufeEzMCBSGqs=;
        b=IG1pd9TB0+dZZcQTZzAxaPmDILeoPiqR5PTRiyB5PWmmC9C7UJebvLj4hflhsqU/SD
         zLgHx6dr20SJCVBrophGQnNiCGuSFMZLIFm1dM6GDVxmESXEXG53enLvSAVmNOBv4QKb
         0hj2yoihyGwo+hMAim4qs8iA3JWOoGnzQpLPzO6lMYA7EIr2+/t4sFqipxMXbYqSMqcJ
         JfhJcmdtvR5LoGAGZ/zj9Mt3XGfbKaMvMZQWKeforO+K5YkN/HUugAO1fH27nbQyGGj3
         YrJBu9bsuQzuLp1DU5MUfOLA6hVM4sGf8Xw1mH6zzZnzIqmiz9t22li9Isx62OfqAre6
         u/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691657; x=1778296457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4VP8vbyQc1rGO2EisoicHamzyPT3B0ufeEzMCBSGqs=;
        b=VWFwzrZx6/Mqy5EX7gRqD3flcKIhKabALQm1PwRVrY7b4wjMzsnOOwPO3inFdul+D/
         HFV+W9H0klbSy9hrAkrtAQDLSU8sjjfVon7G5/BOBhV10e9oplITAQZbW/exa/EYkpBV
         XUhM7gwjCwfBIUV/RLi5qtDxvtEnf0IxmLMWEHvAym4I0Asz6pIWU4sKk/s2R+0dBx3k
         9R8UQF3/vvrTaTBssMfsZYQo9s2Cl0xcG6Wz1pFm3wtlHSrYdEmWxpVgU9oE/YUZxXwG
         hiNmW5MM5BUTJUcF4+zvZ7CEXObGxbcvkcKQTr6j/p75ngRY0cpunZ6ktk85Ndzugnks
         c6/w==
X-Forwarded-Encrypted: i=1; AFNElJ/QZWnbOHLfrt8OEWGpthI/V40OQ5JlOWT+PVYwOUn1QtZgbpWSC6rNuZtQpFvKbb9Z+KFGRxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGaPELFCHfajLPZ8+aUt9Urer4DqeDMkdGfzdBa71j48PuRc4j
	6IaQsITo8zDpIIs1gJLsJT1xMiGgVFx/qyjXYebe/C+TjEpJZJd6IKdqcpdy6Z51hgq2LR0T1eS
	BRAs4ig==
X-Received: from pgli4.prod.google.com ([2002:a63:1304:0:b0:c7c:4b52:febd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498d:b0:362:bc8a:9c22
 with SMTP id 98e67ed59e1d1-3650cf1baacmr1565740a91.27.1777691656916; Fri, 01
 May 2026 20:14:16 -0700 (PDT)
Date: Sat,  2 May 2026 03:13:00 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 07/15] vxlan: Store struct sock in struct vxlan_sock.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E3D0B4B0C50
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
	TAGGED_FROM(0.00)[bounces-283354-lists,netdev=lfdr.de];
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

Commit 3cf7203ca620 ("net/tunnel: wait until all sk_user_data
reader finish before releasing the sock") added synchronize_rcu()
in udp_tunnel_sock_release().

This was intended to protect the fast path of a dying vxlan device
from dereferencing vxlan_sock->sock->sk after sock_orphan() has set
sock->sk to NULL.

However, vxlan does not need to access struct socket itself in the
fast path; it only reads struct sock, and struct socket is only
used for tunnel setup and teardown.

Let's store struct sock directly in struct vxlan_sock.

In the next patch, we will free vxlan_sock with kfree_rcu(), then
vxlan no longer needs synchronize_rcu() in udp_tunnel_sock_release().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c      | 48 ++++++++++++++---------------
 drivers/net/vxlan/vxlan_multicast.c |  8 ++---
 include/net/vxlan.h                 |  4 +--
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index abf3ae04d75b..ce99da44ea7d 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -88,10 +88,10 @@ static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
 	flags &= VXLAN_F_RCV_FLAGS;
 
 	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
-		if (inet_sk(vs->sock->sk)->inet_sport == port &&
+		if (inet_sk(vs->sk)->inet_sport == port &&
 		    vxlan_get_sk_family(vs) == family &&
 		    vs->flags == flags &&
-		    vs->sock->sk->sk_bound_dev_if == ifindex)
+		    vs->sk->sk_bound_dev_if == ifindex)
 			return vs;
 	}
 	return NULL;
@@ -1497,7 +1497,7 @@ static bool __vxlan_sock_release_prep(struct vxlan_sock *vs)
 		return false;
 
 	hlist_del_rcu(&vs->hlist);
-	udp_tunnel_notify_del_rx_port(vs->sock->sk,
+	udp_tunnel_notify_del_rx_port(vs->sk,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
@@ -1523,13 +1523,13 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 		vxlan_vs_del_dev(vxlan);
 
 	if (__vxlan_sock_release_prep(sock4)) {
-		udp_tunnel_sock_release(sock4->sock->sk);
+		udp_tunnel_sock_release(sock4->sk);
 		kfree(sock4);
 	}
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (__vxlan_sock_release_prep(sock6)) {
-		udp_tunnel_sock_release(sock6->sock->sk);
+		udp_tunnel_sock_release(sock6->sk);
 		kfree(sock6);
 	}
 #endif
@@ -2477,7 +2477,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!ifindex)
-			ifindex = sock4->sock->sk->sk_bound_dev_if;
+			ifindex = sock4->sk->sk_bound_dev_if;
 
 		rt = udp_tunnel_dst_lookup(skb, dev, vxlan->net, ifindex,
 					   &saddr, pkey, src_port, dst_port,
@@ -2544,7 +2544,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel_xmit_skb(rt, sock4->sock->sk, skb, saddr,
+		udp_tunnel_xmit_skb(rt, sock4->sk, skb, saddr,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
@@ -2561,9 +2561,9 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!ifindex)
-			ifindex = sock6->sock->sk->sk_bound_dev_if;
+			ifindex = sock6->sk->sk_bound_dev_if;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock->sk,
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sk,
 					      ifindex, &saddr, pkey,
 					      src_port, dst_port, tos,
 					      use_cache ? dst_cache : NULL);
@@ -2619,7 +2619,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 
-		udp_tunnel6_xmit_skb(ndst, sock6->sock->sk, skb, dev,
+		udp_tunnel6_xmit_skb(ndst, sock6->sk, skb, dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
@@ -3258,7 +3258,7 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		if (!sock6)
 			return -EIO;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock->sk,
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sk,
 					      0, &info->key.u.ipv6.src,
 					      &info->key,
 					      sport, dport, info->key.tos,
@@ -3336,9 +3336,9 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 				type = UDP_TUNNEL_TYPE_VXLAN;
 
 			if (push)
-				udp_tunnel_push_rx_port(dev, vs->sock->sk, type);
+				udp_tunnel_push_rx_port(dev, vs->sk, type);
 			else
-				udp_tunnel_drop_rx_port(dev, vs->sock->sk, type);
+				udp_tunnel_drop_rx_port(dev, vs->sk, type);
 		}
 	}
 }
@@ -3544,8 +3544,8 @@ static const struct ethtool_ops vxlan_ethtool_ops = {
 	.get_link_ksettings	= vxlan_get_link_ksettings,
 };
 
-static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
-					__be16 port, u32 flags, int ifindex)
+static struct sock *vxlan_create_sock(struct net *net, bool ipv6,
+				      __be16 port, u32 flags, int ifindex)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -3571,7 +3571,7 @@ static struct socket *vxlan_create_sock(struct net *net, bool ipv6,
 		return ERR_PTR(err);
 
 	udp_allow_gso(sock->sk);
-	return sock;
+	return sock->sk;
 }
 
 /* Create new listen socket if needed */
@@ -3579,10 +3579,10 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 					      __be16 port, u32 flags,
 					      int ifindex)
 {
+	struct udp_tunnel_sock_cfg tunnel_cfg;
 	struct vxlan_sock *vs;
-	struct socket *sock;
+	struct sock *sk;
 	unsigned int h;
-	struct udp_tunnel_sock_cfg tunnel_cfg;
 
 	ASSERT_RTNL();
 
@@ -3593,18 +3593,18 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 	for (h = 0; h < VNI_HASH_SIZE; ++h)
 		INIT_HLIST_HEAD(&vs->vni_list[h]);
 
-	sock = vxlan_create_sock(net, ipv6, port, flags, ifindex);
-	if (IS_ERR(sock)) {
+	sk = vxlan_create_sock(net, ipv6, port, flags, ifindex);
+	if (IS_ERR(sk)) {
 		kfree(vs);
-		return ERR_CAST(sock);
+		return ERR_CAST(sk);
 	}
 
-	vs->sock = sock;
+	vs->sk = sk;
 	refcount_set(&vs->refcnt, 1);
 	vs->flags = (flags & VXLAN_F_RCV_FLAGS);
 
 	hlist_add_head_rcu(&vs->hlist, vs_head(net, port));
-	udp_tunnel_notify_add_rx_port(sock->sk,
+	udp_tunnel_notify_add_rx_port(sk,
 				      (vs->flags & VXLAN_F_GPE) ?
 				      UDP_TUNNEL_TYPE_VXLAN_GPE :
 				      UDP_TUNNEL_TYPE_VXLAN);
@@ -3624,7 +3624,7 @@ static struct vxlan_sock *vxlan_socket_create(struct net *net, bool ipv6,
 		tunnel_cfg.gro_complete = vxlan_gro_complete;
 	}
 
-	setup_udp_tunnel_sock(net, sock->sk, &tunnel_cfg);
+	setup_udp_tunnel_sock(net, sk, &tunnel_cfg);
 
 	return vs;
 }
diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
index b0e80bca855c..3b75b48dc726 100644
--- a/drivers/net/vxlan/vxlan_multicast.c
+++ b/drivers/net/vxlan/vxlan_multicast.c
@@ -29,7 +29,7 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 			.imr_ifindex		= ifindex,
 		};
 
-		sk = sock4->sock->sk;
+		sk = sock4->sk;
 		lock_sock(sk);
 		ret = ip_mc_join_group(sk, &mreq);
 		release_sock(sk);
@@ -37,7 +37,7 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
 
-		sk = sock6->sock->sk;
+		sk = sock6->sk;
 		lock_sock(sk);
 		ret = ipv6_sock_mc_join(sk, ifindex, &ip->sin6.sin6_addr);
 		release_sock(sk);
@@ -62,7 +62,7 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 			.imr_ifindex		= ifindex,
 		};
 
-		sk = sock4->sock->sk;
+		sk = sock4->sk;
 		lock_sock(sk);
 		ret = ip_mc_leave_group(sk, &mreq);
 		release_sock(sk);
@@ -70,7 +70,7 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
 	} else {
 		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
 
-		sk = sock6->sock->sk;
+		sk = sock6->sk;
 		lock_sock(sk);
 		ret = ipv6_sock_mc_drop(sk, ifindex, &ip->sin6.sin6_addr);
 		release_sock(sk);
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 0ee50785f4f1..8b52294b2902 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -185,7 +185,7 @@ struct vxlan_metadata {
 /* per UDP socket information */
 struct vxlan_sock {
 	struct hlist_node hlist;
-	struct socket	 *sock;
+	struct sock	  *sk;
 	struct hlist_head vni_list[VNI_HASH_SIZE];
 	refcount_t	  refcnt;
 	u32		  flags;
@@ -448,7 +448,7 @@ static inline __be32 vxlan_compute_rco(unsigned int start, unsigned int offset)
 
 static inline unsigned short vxlan_get_sk_family(struct vxlan_sock *vs)
 {
-	return vs->sock->sk->sk_family;
+	return vs->sk->sk_family;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.54.0.545.g6539524ca2-goog


