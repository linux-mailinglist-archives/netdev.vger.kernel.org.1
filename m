Return-Path: <netdev+bounces-283350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB4tCjRs9WlVLAIAu9opvQ
	(envelope-from <netdev+bounces-283350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:15:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B244B0C23
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 05:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5EBC3026A8E
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E422D23A4;
	Sat,  2 May 2026 03:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqWRLJyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A62C15A9
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777691652; cv=none; b=ix/iDXV2s0dHa0F290ja+yrxZL8TaFYxa3j0+rdxN8kHATtLPXhlxcvBZbShXqOt5a2VRHlT42OWuZHbyGmA0IN1+0k/VrJZ6Yk+CyyzyXDRUX3ibKHN/+J4//iSIntD9i3jaFzMu6Y3JyxJR8Rq7aBRPcxkNbdpc5svfZUnxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777691652; c=relaxed/simple;
	bh=AsbFNr9kZEhZ0U3toTUQZ5sWYkrwnZsg1bHMlc2OOHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NH0/5l/8XOmkLrt7RKLW3Wk50FI/lQOmHRhS2FdFG+ynv9jbw4ix4SfG05aweZtQBrmE49d9vIfm22QFLrvyr3DXn8w4fwOULjNVWlX7wPMBCw+MqxTzYywxBsiXMoRBKbp1LDKgZiW7ZqXuivEV3t5AN85EVhyv3Lnbc/Yo6no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqWRLJyd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36512c65928so269172a91.2
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777691651; x=1778296451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0/Ajv5tzuBo3vEgds0QodRqtkkGPI8NvXpazG1dIlc=;
        b=MqWRLJydmrvyAIRzQAdKtQK0RRgPxp2SlDj4pOqGBdafw340Gq+46TpshMuCEsDDwa
         5A6V4SR8id+AoVRMM7KNA0gLmYXG+kPkmVATGoF3S1N/iz1OCAx2mpIf/BXR4VpPZLA8
         VeEyJRppjIzu3WHTNuc4CQZMyhJ5wPVGez2463IsgYtDKtNzAbOflZo5uLih72hvzJQv
         vxTYgKU7xoOXWKAGdKD8A4uGzzV5lEvntNHz++gwB/dVGYmAO7WZ65s3NmkhTcSPTjqz
         9AV/cpHubR4Gv0kFT5nhIyiqNNxVKZumg0w5Tus5+fPnsrmRG+7NZzabfyd/hE5o8dM3
         RHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777691651; x=1778296451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0/Ajv5tzuBo3vEgds0QodRqtkkGPI8NvXpazG1dIlc=;
        b=d4fb3TA63n+HScyQEGt979dvc2CR13ZmrDrLY/KXZKipIBCk6uCVaUpHPdk0TMzq5U
         0HkKuK3i4+tRYz1+OWa+fHhVljWAGztivvo/nJHJ4EjD9xTGMTkGWm20njWSbRMzr4x+
         zOAKFl91PVq5Uyr7nzoASsKaCe99pwjV7DWOjQsk8K+sYWrHJmvrJTlAt1cRJvS0SU75
         Df3jXmDMAxg3Y/01IiK0+LSalRpgUh2UBmfVNMmeOHrFU3s1aduevfBSK+3VU3Bo7bFL
         LjA5zfFSBz8qrdTB561AOsaFzfIpvkydCJEZrfZM2isl4KYQMESkiybnT4xiunx6Y8nk
         1kOw==
X-Forwarded-Encrypted: i=1; AFNElJ/XyOypIK0S/Mt6M5QjCM0zViOav8R2JyLjthzaJSLtLhiI8w/EYak/l6sz6MTF5+JNDYY0Xu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKREVgKj3mjkbJ6t47o1KPBSui3LNFyxUQwPoOvWJVozT0rVje
	3gKf6Tips6gHyUvi9z0rWGdJI9/JzaPd4K+LC6QF5a2F6DBX9NhFLU/pHgBAmCGofEyy3Ze+5f/
	TB3+hoA==
X-Received: from pgix20.prod.google.com ([2002:a63:db54:0:b0:c73:97d4:afe0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8b:b0:3a2:dd8a:5087
 with SMTP id adf61e73a8af0-3a7f1ced783mr1531913637.46.1777691650271; Fri, 01
 May 2026 20:14:10 -0700 (PDT)
Date: Sat,  2 May 2026 03:12:56 +0000
In-Reply-To: <20260502031401.3557229-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502031401.3557229-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260502031401.3557229-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/15] udp_tunnel: Pass struct sock to udp_tunnel6_dst_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A4B244B0C23
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
	TAGGED_FROM(0.00)[bounces-283350-lists,netdev=lfdr.de];
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

None of the udp_tunnel users need struct socket in their
fast paths; it is only used for tunnel setup / teardown.

Even udp_tunnel6_dst_lookup() does not need struct socket.

Let's change udp_tunnel6_dst_lookup() to take struct sock
instead of struct socket.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/bareudp.c          | 4 ++--
 drivers/net/geneve.c           | 4 ++--
 drivers/net/vxlan/vxlan_core.c | 4 ++--
 include/net/udp_tunnel.h       | 2 +-
 net/ipv6/ip6_udp_tunnel.c      | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 169ab90393cc..073ac8a15354 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -396,7 +396,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	sport = udp_flow_src_port(bareudp->net, skb,
 				  bareudp->sport_min, USHRT_MAX,
 				  true);
-	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock, 0, &saddr,
+	dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock->sk, 0, &saddr,
 				     key, sport, bareudp->port, key->tos,
 				     use_cache ?
 				     (struct dst_cache *) &info->dst_cache : NULL);
@@ -532,7 +532,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		if (!sock)
 			return -ESHUTDOWN;
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock,
+		dst = udp_tunnel6_dst_lookup(skb, dev, bareudp->net, sock->sk,
 					     0, &saddr, &info->key,
 					     sport, bareudp->port, info->key.tos,
 					     use_cache ? &info->dst_cache : NULL);
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c3a7736cd6fc..4b7081b97015 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1424,7 +1424,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 				  geneve->cfg.port_min,
 				  geneve->cfg.port_max, true);
 
-	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock->sk, 0,
 				     &saddr, key, sport,
 				     geneve->cfg.info.key.tp_dst, prio,
 				     use_cache ?
@@ -1592,7 +1592,7 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 					  geneve->cfg.port_min,
 					  geneve->cfg.port_max, true);
 
-		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
+		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock->sk, 0,
 					     &saddr, &info->key, sport,
 					     geneve->cfg.info.key.tp_dst, prio,
 					     use_cache ? &info->dst_cache : NULL);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 394801c068b3..a19f951e05f1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2559,7 +2559,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock->sk,
 					      ifindex, &saddr, pkey,
 					      src_port, dst_port, tos,
 					      use_cache ? dst_cache : NULL);
@@ -3254,7 +3254,7 @@ static int vxlan_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		if (!sock6)
 			return -EIO;
 
-		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock,
+		ndst = udp_tunnel6_dst_lookup(skb, dev, vxlan->net, sock6->sock->sk,
 					      0, &info->key.u.ipv6.src,
 					      &info->key,
 					      sport, dport, info->key.tos,
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 49324e28ec27..14a9c5155608 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -188,7 +188,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
-					 struct socket *sock, int oif,
+					 struct sock *sk, int oif,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
 					 __be16 sport, __be16 dport, u8 dsfield,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 405ef1cb8864..9adb5775487f 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -118,7 +118,7 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
  *      @skb: Packet for which lookup is done
  *      @dev: Tunnel device
  *      @net: Network namespace of tunnel device
- *      @sock: Socket which provides route info
+ *      @sk: Socket which provides route info
  *      @oif: Index of the output interface
  *      @saddr: Memory to store the src ip address
  *      @key: Tunnel information
@@ -135,7 +135,7 @@ EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 					 struct net_device *dev,
 					 struct net *net,
-					 struct socket *sock,
+					 struct sock *sk,
 					 int oif,
 					 struct in6_addr *saddr,
 					 const struct ip_tunnel_key *key,
@@ -162,7 +162,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	fl6.fl6_dport = dport;
 	fl6.flowlabel = ip6_make_flowinfo(dsfield, key->label);
 
-	dst = ip6_dst_lookup_flow(net, sock->sk, &fl6, NULL);
+	dst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
-- 
2.54.0.545.g6539524ca2-goog


