Return-Path: <netdev+bounces-303727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTOtNGE4RWov8woAu9opvQ
	(envelope-from <netdev+bounces-303727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:55:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2286EF67C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:55:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RO4AT6ui;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303727-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303727-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F6FF30575E8
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0CE362138;
	Wed,  1 Jul 2026 15:51:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E733546EF
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:51:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921102; cv=none; b=ak9wTBPQbMhpfdAtkxWB5Ah0IZNmdCMbzXkegP9oKT48FqN63t+MOx9tkGEsL+OigdcmElEiBVZLoDmCFTxg1iqtCVXpgQuIwbVtihFMhi/9fb/uONXko3bOuD/LJPCJo5yO1Jb600C+Gnz1xhkKbSNlY0VQ+mC9Zmr1LSSoLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921102; c=relaxed/simple;
	bh=IusyAeTQ6w+kHoOf9l3njQ1HSBx3l/RIbp29LrrZ1Xk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b2/Gi+wmL8oJyWTRNb7KFkutaYeeZHXCNf1cRGugBt8Ra4LkCJsdQpoYQOYsKRMlGyjZl4bVmDswCY6yEZyCUpwVHoZoHLAvodRNYUpD5jEHGgmUPtZ3XSHBPa5Lfcl8d8UGGEyQJF7QTEOJhpnIm9nh4NDH2uEXI+X/6ZVGpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RO4AT6ui; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51bfe3fa93bso8323341cf.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782921100; x=1783525900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jelKamaqWb1Xpu9bUIrf9bmvgwuIyco9/Achrqvuig=;
        b=RO4AT6uimw/13cMK6RTiz9TT4ZE8zgl3cVzIIZ0VR1G7M5N+T8h0mU1U7PdQ7aeEfx
         8SNPX02N4n28ALrFboKw2KhISM39Tve8s6Zjem0pDRg86WaAglMUtOlllnMORkNxXF2+
         ge805kMPqZM7l0Oaua8urz539ykL4egrVS+tbfTLfw8swc6NmJgX2PbCb/4grSh65fDQ
         CpizEsVOZtusfEg5Rhh4DwWgHbNb9FbHyjEfAYtqb815Vm/OojSnDsgxP95a3EkYobOK
         eCebvH9FcYFiEUgvkjnwrVgCUNaCGp4Kl4R5ZbR8ZB26qYjeklOarMOsIh2HEfTI2q4l
         ryRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921100; x=1783525900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jelKamaqWb1Xpu9bUIrf9bmvgwuIyco9/Achrqvuig=;
        b=c3e/M1CWCcnVI3g8axfSU+GB27ZrP1idpPlCyNItaEdg8QcoWfNZQbd63ambO6xBgv
         Y5hkSfpk9Hg65Xz3ZgCfwlWbjps6SHXz2m4z4yWUNLDwDIY6cgST0hYlwjwZDfVRdta6
         QBpWSCGZ/skRG3LhX3ke8Wm0mBNJwm1TXr/yFI52X2bpUMpJUc5bUUmXc2dnSWMUKbLN
         RZzb7Ok1eZDZk+/3RUIrSglGljcecs91Fmqkv7bbLuEdkl5FQQiUQCc0RVBN+QzMktGY
         hoHbGOKNz8eGCDilaj6gVUJI81VAwE71FaNUpaUUAdboqVs9tUPVQQY4zs2PmUBnU99J
         Ikrw==
X-Forwarded-Encrypted: i=1; AFNElJ9nAQp9wIlSa15+X7o+6u823NhuMqNDIutqHMIuULM1uHmLhKqB3hRJffoSS7W8ujqou25cuvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEu8V6hiIxqoecLGwwuS7uwE7FFhCMOqUpB97sMvK4xdryg+IP
	HVWA01Q7FU6su+fCPB93rhSe1gEz5MhTejIH6G6XXvkfQaQY7DwPirLf3grDAsL5G1yWPmWSM8p
	D2mDHaCGbGO1ipg==
X-Received: from qvnz10.prod.google.com ([2002:a0c:e98a:0:b0:8f1:551b:f13d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d8d:b0:519:f420:d780 with SMTP id d75a77b69052e-51c26a773f3mr27536891cf.30.1782921099545;
 Wed, 01 Jul 2026 08:51:39 -0700 (PDT)
Date: Wed,  1 Jul 2026 15:51:35 +0000
In-Reply-To: <20260701155135.3962058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701155135.3962058-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701155135.3962058-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] sit: no longer rely on RTNL in ipip6_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303727-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2286EF67C

Update ipip6_fill_info() to read configuration fields (link, ttl, tos,
proto, i_flags, fwmark, 6rd prefix, encap type/sport/dport/flags)
locklessly using READ_ONCE().

Annotate the bitmap reads for i_flags by copying the first element
atomically using READ_ONCE() into a local variable, as the whole
bitmap fits in one unsigned long.

This allows ipip6_fill_info() to run safely without RTNL.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/sit.c | 70 ++++++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a38b24fb838424b6d3cb063d77aa85cf719ce6c5..c7abbb09bfd3dfada6fc1e1682ac42acb7248ad9 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1143,17 +1143,17 @@ static void ipip6_tunnel_update(struct ip_tunnel *t,
 
 	ipip6_tunnel_unlink(sitn, t);
 	synchronize_net();
-	t->parms.iph.saddr = p->iph.saddr;
-	t->parms.iph.daddr = p->iph.daddr;
+	WRITE_ONCE(t->parms.iph.saddr, p->iph.saddr);
+	WRITE_ONCE(t->parms.iph.daddr, p->iph.daddr);
 	__dev_addr_set(t->dev, &p->iph.saddr, 4);
 	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
 	ipip6_tunnel_link(sitn, t);
-	t->parms.iph.ttl = p->iph.ttl;
-	t->parms.iph.tos = p->iph.tos;
-	t->parms.iph.frag_off = p->iph.frag_off;
-	if (t->parms.link != p->link || t->fwmark != fwmark) {
-		t->parms.link = p->link;
-		t->fwmark = fwmark;
+	WRITE_ONCE(t->parms.iph.ttl, p->iph.ttl);
+	WRITE_ONCE(t->parms.iph.tos, p->iph.tos);
+	WRITE_ONCE(t->parms.iph.frag_off, p->iph.frag_off);
+	if (READ_ONCE(t->parms.link) != p->link || READ_ONCE(t->fwmark) != fwmark) {
+		WRITE_ONCE(t->parms.link, p->link);
+		WRITE_ONCE(t->fwmark, fwmark);
 		ipip6_tunnel_bind_dev(t->dev);
 	}
 	dst_cache_reset(&t->dst_cache);
@@ -1184,9 +1184,9 @@ static int ipip6_tunnel_update_6rd(struct ip_tunnel *t,
 		return -EINVAL;
 
 	t->ip6rd.prefix = prefix;
-	t->ip6rd.relay_prefix = relay_prefix;
-	t->ip6rd.prefixlen = ip6rd->prefixlen;
-	t->ip6rd.relay_prefixlen = ip6rd->relay_prefixlen;
+	WRITE_ONCE(t->ip6rd.relay_prefix, relay_prefix);
+	WRITE_ONCE(t->ip6rd.prefixlen, ip6rd->prefixlen);
+	WRITE_ONCE(t->ip6rd.relay_prefixlen, ip6rd->relay_prefixlen);
 	dst_cache_reset(&t->dst_cache);
 	netdev_state_change(t->dev);
 	return 0;
@@ -1693,42 +1693,52 @@ static size_t ipip6_get_size(const struct net_device *dev)
 
 static int ipip6_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *tunnel = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *parm = &tunnel->parms;
-
-	if (nla_put_u32(skb, IFLA_IPTUN_LINK, parm->link) ||
-	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, parm->iph.saddr) ||
-	    nla_put_in_addr(skb, IFLA_IPTUN_REMOTE, parm->iph.daddr) ||
-	    nla_put_u8(skb, IFLA_IPTUN_TTL, parm->iph.ttl) ||
-	    nla_put_u8(skb, IFLA_IPTUN_TOS, parm->iph.tos) ||
+	const struct ip_tunnel *tunnel = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *parm;
+	IP_TUNNEL_DECLARE_FLAGS(i_flags);
+	__be16 frag_off;
+	__be32 daddr;
+	__be32 saddr;
+
+	parm = &tunnel->parms;
+	i_flags[0] = READ_ONCE(parm->i_flags[0]);
+	frag_off = READ_ONCE(parm->iph.frag_off);
+	saddr = READ_ONCE(parm->iph.saddr);
+	daddr = READ_ONCE(parm->iph.daddr);
+
+	if (nla_put_u32(skb, IFLA_IPTUN_LINK, READ_ONCE(parm->link)) ||
+	    nla_put_in_addr(skb, IFLA_IPTUN_LOCAL, saddr) ||
+	    nla_put_in_addr(skb, IFLA_IPTUN_REMOTE, daddr) ||
+	    nla_put_u8(skb, IFLA_IPTUN_TTL, READ_ONCE(parm->iph.ttl)) ||
+	    nla_put_u8(skb, IFLA_IPTUN_TOS, READ_ONCE(parm->iph.tos)) ||
 	    nla_put_u8(skb, IFLA_IPTUN_PMTUDISC,
-		       !!(parm->iph.frag_off & htons(IP_DF))) ||
-	    nla_put_u8(skb, IFLA_IPTUN_PROTO, parm->iph.protocol) ||
+		       !!(frag_off & htons(IP_DF))) ||
+	    nla_put_u8(skb, IFLA_IPTUN_PROTO, READ_ONCE(parm->iph.protocol)) ||
 	    nla_put_be16(skb, IFLA_IPTUN_FLAGS,
-			 ip_tunnel_flags_to_be16(parm->i_flags)) ||
-	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, tunnel->fwmark))
+			 ip_tunnel_flags_to_be16(i_flags)) ||
+	    nla_put_u32(skb, IFLA_IPTUN_FWMARK, READ_ONCE(tunnel->fwmark)))
 		goto nla_put_failure;
 
 #ifdef CONFIG_IPV6_SIT_6RD
 	if (nla_put_in6_addr(skb, IFLA_IPTUN_6RD_PREFIX,
 			     &tunnel->ip6rd.prefix) ||
 	    nla_put_in_addr(skb, IFLA_IPTUN_6RD_RELAY_PREFIX,
-			    tunnel->ip6rd.relay_prefix) ||
+			    READ_ONCE(tunnel->ip6rd.relay_prefix)) ||
 	    nla_put_u16(skb, IFLA_IPTUN_6RD_PREFIXLEN,
-			tunnel->ip6rd.prefixlen) ||
+			READ_ONCE(tunnel->ip6rd.prefixlen)) ||
 	    nla_put_u16(skb, IFLA_IPTUN_6RD_RELAY_PREFIXLEN,
-			tunnel->ip6rd.relay_prefixlen))
+			READ_ONCE(tunnel->ip6rd.relay_prefixlen)))
 		goto nla_put_failure;
 #endif
 
 	if (nla_put_u16(skb, IFLA_IPTUN_ENCAP_TYPE,
-			tunnel->encap.type) ||
+			READ_ONCE(tunnel->encap.type)) ||
 	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_SPORT,
-			tunnel->encap.sport) ||
+			READ_ONCE(tunnel->encap.sport)) ||
 	    nla_put_be16(skb, IFLA_IPTUN_ENCAP_DPORT,
-			tunnel->encap.dport) ||
+			READ_ONCE(tunnel->encap.dport)) ||
 	    nla_put_u16(skb, IFLA_IPTUN_ENCAP_FLAGS,
-			tunnel->encap.flags))
+			READ_ONCE(tunnel->encap.flags)))
 		goto nla_put_failure;
 
 	return 0;
-- 
2.55.0.rc0.799.gd6f94ed593-goog


