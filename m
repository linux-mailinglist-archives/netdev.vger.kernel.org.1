Return-Path: <netdev+bounces-299474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LA5JEj4GMGrgLwUAu9opvQ
	(envelope-from <netdev+bounces-299474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:03:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3548686E8E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=sBRFoMr6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299474-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299474-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88577301B4EC
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404093F23CC;
	Mon, 15 Jun 2026 14:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F083ECBEA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 14:03:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532218; cv=none; b=Q6mINnhqfkV4dKSGPhFJ7Vq3upXXpL0TRoAZAICeypBVerljPbCOyEjDYG4fPFlZRfipx51tSVyHfarL9cYkQG0rOpP+F9kg+JcZmgF2qHcF/JVnA3dqZ1nVj6gPzsyQMOJzxBOUPT7FOiTlJ2WjIIHWeb/37NEg2qdHc/lErcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532218; c=relaxed/simple;
	bh=yMz+q3GSlxll2Mg6ZO76xbMD4uxlUqDGXFbdDB9Mb5o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sYU1Q3viR9Xqf5WY7XknKuc+GaeDlYJ592L6zmylH6LmTZ4qf9lxJ9A/wEGzoyj43N9iowL8gsm93tUlaykQo+af5BYD0+BEJAk9RjugQH2iV4/SrjDSs1fxj+wmJbkHqbu3Kq5inkUjCtaNyQOC6Lr07+JFx6F9FG8msKPrAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBRFoMr6; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8cce1cc8cb2so71602686d6.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781532216; x=1782137016; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AOSKDr0VoWiUNvzD31VJfJiDTxCU4ah0rSQamDGLFi0=;
        b=sBRFoMr6l+yIjhE1RArvtRsn55Wjd9ePvYZeONT0KCYURPVH3wRqmnGaak4nf2i9JD
         PoG80Co93Mdvbk5pT3ljmHajve7OjFELfmlS+irKr1VVHubeKtMp9wGe0THMsdU0cGnE
         bhgAxm9p1bZiscVSzo7dP3vcFj31+uiP/MCUp9HpDnzkFJvKEhszc8+50I4l519NjBOi
         cyccZcHkmvN3bkXpWHhkNDlpW9Qk+E4hMRIHx3VFOn6lr/ZgewGhiIe9d3FrQSZjeZg3
         /77TRtn86/+jHWqgOR6H8Y4j8gCJvUmjTpXX9N0kbt+Mx58gJE83+79HcBMO1ptMR9Wj
         bExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781532216; x=1782137016;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOSKDr0VoWiUNvzD31VJfJiDTxCU4ah0rSQamDGLFi0=;
        b=qhAkDAjqrxm+Lg6TXgP/dU6pXjCUlJFczg4hzh0JAowEnirrmTu2uIar2+GqE3vFG7
         UlXQ+2Yu56VdLIbVcvGpTy5NJqzJMFGNZXtVuR6RnuRkulk4xXOK1wlzMB50qoiO0w9U
         fk/oV7yi0tcmENS5jvdcNZyIYrYboJqT7joAg4xftHuSA1rgrwGj91JE/fDKqo6q2mBP
         xaYU05evmhmNsudgLebAu3XEz+9uVlsHKGNl8YwaPTCd9pAeAMdCvYszBI9L56FL4jfJ
         wbldEuUmqgkZWiVjc7WqO6YlYBwo7RmRjdbYTZinykLH2gQzmKXVlFC5uYXfoF6N8Gla
         c6fg==
X-Forwarded-Encrypted: i=1; AFNElJ88lkCFYcn365L/AYuVhbo2MUxJ6hmwqtOfueO300yE0eNZcpAugL9qtuE8JSQM76bi1vv0Kl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnedRgitrYi3lyAzYAHz7Z/DU8J8ClBrGfC3ZWFm/C98YWjmP
	Ci/wa6bjNRojLmIEzgq9v/XMeNi99tB8XdE+w3ZSAVmzBn855C0krQ3SkVvt2+U8JsiLnFvm35Z
	zrVUTYeutbpWs5g==
X-Received: from qvbqk2.prod.google.com ([2002:ad4:5602:0:b0:8cc:e7ea:eb33])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:624:b0:8ca:23b1:f4a9 with SMTP id 6a1803df08f44-8d32c012b44mr228442736d6.2.1781532215319;
 Mon, 15 Jun 2026 07:03:35 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:03:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615140333.3161072-1-edumazet@google.com>
Subject: [PATCH net-next] gre: fix ERSPAN o_flags race/corruption in xmit and fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299474-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3548686E8E

For IPv4 ERSPAN:
In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
structure. Since transmit paths can run locklessly and concurrently,
this leads to a data race.

Furthermore, modifying tunnel->parms.o_flags permanently alters the
tunnel configuration. To work around this, erspan_fill_info() (which
reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly)
race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldn't,
leading to GRE header corruption (injecting a key field into the ERSPAN
GRE header).

Fix this by:
1) Passing flags as an argument to __gre_xmit().
2) Using local flags in erspan_xmit() and passing them to __gre_xmit().
3) Removing the racy modification of t->parms.o_flags in erspan_fill_info().
4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
   in ipgre_fill_info().

For IPv6 ERSPAN:
ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
t->parms.o_flags even though it does not use these flags for building
the GRE header (it uses local flags). This permanently corrupts the
configuration and races with ip6gre_fill_info() which reads it.

Remove the redundant and racy modification.
This should remove false sharing in a fast path.

Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
and ip6gre_fill_info() to clarify that these methods are not
supposed to write any live parameters.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interface")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
I found this issue while working on RTNL-less fill_info().
Sent to net-next since 7.1 was just released.

 net/ipv4/ip_gre.c  | 30 +++++++++++++++---------------
 net/ipv6/ip6_gre.c |  5 ++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 208dd48012d963b9df0eddbdda73dd319930e48f..eab6d228d062b97b6f3f9d03418b84bac12b6983 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -475,12 +475,9 @@ static int gre_rcv(struct sk_buff *skb)
 
 static void __gre_xmit(struct sk_buff *skb, struct net_device *dev,
 		       const struct iphdr *tnl_params,
-		       __be16 proto)
+		       __be16 proto, const unsigned long *flags)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	IP_TUNNEL_DECLARE_FLAGS(flags);
-
-	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
 	/* Push GRE header. */
 	gre_build_header(skb, tunnel->tun_hlen,
@@ -692,7 +689,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 					      tunnel->parms.o_flags)))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, tnl_params, skb->protocol);
+	__gre_xmit(skb, dev, tnl_params, skb->protocol, tunnel->parms.o_flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -705,6 +702,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 			       struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 	bool truncate = false;
 	__be16 proto;
 
@@ -728,10 +726,12 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		truncate = true;
 	}
 
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
 	/* Push ERSPAN header */
 	if (tunnel->erspan_ver == 0) {
 		proto = htons(ETH_P_ERSPAN);
-		__clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
+		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
 	} else if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
@@ -746,8 +746,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 	}
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
-	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
+	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
+	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -776,7 +776,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
+	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB), tunnel->parms.o_flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -1554,12 +1554,15 @@ static size_t ipgre_get_size(const struct net_device *dev)
 
 static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *p = &t->parms;
+	const struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
 
+	if (t->erspan_ver != 0 && !t->collect_md)
+		__set_bit(IP_TUNNEL_KEY_BIT, o_flags);
+
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
@@ -1602,12 +1605,9 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static int erspan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel *t = netdev_priv(dev);
 
 	if (t->erspan_ver <= 2) {
-		if (t->erspan_ver != 0 && !t->collect_md)
-			__set_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
-
 		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, t->erspan_ver))
 			goto nla_put_failure;
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 795be59946f7210bfae55d20500d18c83c01ede9..d0701351934ccfcfbac70bb2c2c2a7ccb9b6d779 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -964,7 +964,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
 		goto tx_err;
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
 	IPCB(skb)->flags = 0;
 
 	/* For collect_md mode, derive fl6 from the tunnel key,
@@ -2112,8 +2111,8 @@ static size_t ip6gre_get_size(const struct net_device *dev)
 
 static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip6_tnl *t = netdev_priv(dev);
-	struct __ip6_tnl_parm *p = &t->parms;
+	const struct ip6_tnl *t = netdev_priv(dev);
+	const struct __ip6_tnl_parm *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
-- 
2.54.0.1136.gdb2ca164c4-goog


