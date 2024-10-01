Return-Path: <netdev+bounces-131008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB26098C607
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2783C1F23D07
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568651CCEF6;
	Tue,  1 Oct 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPCNE6pE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68541CCED6
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810931; cv=none; b=D5Z9Ph/iR9ouw7JKYsond3Ph/ZJ0rsw4cLACwW6H6WplSjDvbDlVly6lDYPKqZDd7dqre5V9ujBAtv79h8+EZM3Qc5DqtH03Tj8Zyky/yklkrdGJoga53+vdPnYtaWyPAYk81H39QQM6mLJDaI1PJxoSl5rO3D85iu+XfffyxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810931; c=relaxed/simple;
	bh=+0gYVfyR9pwbtvRRh9ROzfojRXx/b6obcAx02HET/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvEUyTLz473Eg/QzD6OsEEgXkqduWu1knKE+LTyJ3n44IwhHIe9AxFapIwTiXThfYOwNYhzztuOfuK9RMHbdaswIwLdCU8Gg/E9IDmDvdU9L9pO8abI0bFvWyFQVDLjXTT54X+ITLRnU+oz8DaU1afSv1JV8eQhpxniiiHrWvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPCNE6pE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727810928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zLubyNTF/pi6Ylzz/fx+UId8xxksWjasnX80u+XOEXc=;
	b=gPCNE6pE3DKoyuvuPfAYuQaFPfYhqy6j4cATPi2TcYQqNfTz7/cIFjT7Sf8pJYz2bs8zGJ
	Kn7id9mOmzvVvXrCSU5oXzI6jqgqF0SpdCTWHGkZjYSIEBp5h1dbxHfweloXYWD4I1UC3k
	o/qMFGJ6x4y59HKs4ekQQRoC01kwX/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-oCGb7TjDO-q8J0QuAO5lvQ-1; Tue, 01 Oct 2024 15:28:47 -0400
X-MC-Unique: oCGb7TjDO-q8J0QuAO5lvQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cc63b1ec3so3194849f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 12:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810926; x=1728415726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLubyNTF/pi6Ylzz/fx+UId8xxksWjasnX80u+XOEXc=;
        b=c8ZWsQOahhEEsiAdHsl9G3iwY2zG0kViS0zjkJJymWV4r65fnGPkYMUTSlqOryCUb/
         naaj3IpANKI4dXSZf6gg4L0jnXtl3C/dNPsTjTEgkRGdwypt4A7PAWgM9dpCn0y5divQ
         dnldt3oPy4eHwmovxyqq0ShGKPJU9G+D5OqeJTS3LyyQxBN5btVGKNW3AmdUxmHkJ/01
         UJdylRQxv+F1ocTKSTcZMzjhRgBhm7IiaX2dxqpbivt/1faTA5VIkYJwPK9jzyjJEfj5
         Mhczwp5DHK7r22YAP3sxWBMmGI/AanFPoTct0yGTBJHjUZZ7vjq9s0P1i8hZy7IBTmlm
         FOmw==
X-Gm-Message-State: AOJu0Yz4NhiTTQ/6b7BAcVpd2e7HlxTdT5sy4CkZvEHo3iF4N+2ig7Nh
	HTgW61Y+XCI5vGbZt8rlLTx7KTl7v9FgNCDN0sO/89KW9be3x9t5ZdhCnrfW9RznV79EJ9Sg94I
	1lqE1O7zfXy2jTKTY08CFMho9kzga+x1/jILWUgIwVs6mUva5NaBDAQ==
X-Received: by 2002:a5d:514f:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-37cfb8c84f4mr424877f8f.13.1727810926373;
        Tue, 01 Oct 2024 12:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgJ8fovF/Hq1ET7Gd/j+D2ZZYTtTe+i7blbcwbWq6Hv9MO+C293jwX92LmdYi5OMFk0LbGKg==
X-Received: by 2002:a5d:514f:0:b0:368:3731:1613 with SMTP id ffacd0b85a97d-37cfb8c84f4mr424861f8f.13.1727810925969;
        Tue, 01 Oct 2024 12:28:45 -0700 (PDT)
Received: from debian (2a01cb058d23d60018ec485714c2d3db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:18ec:4857:14c2:d3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e881sm12458524f8f.44.2024.10.01.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:28:45 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:28:43 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 2/5] ipv4: Convert ip_route_input() to dscp_t.
Message-ID: <e9d40781d64d3d69f4c79ac8a008b8d67a033e8d.1727807926.git.gnault@redhat.com>
References: <cover.1727807926.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727807926.git.gnault@redhat.com>

Pass a dscp_t variable to ip_route_input(), instead of a plain u8, to
prevent accidental setting of ECN bits in ->flowi4_tos.

Callers of ip_route_input() to consider are:

  * input_action_end_dx4_finish() and input_action_end_dt4() in
    net/ipv6/seg6_local.c. These functions set the tos parameter to 0,
    which is already a valid dscp_t value, so they don't need to be
    adjusted for the new prototype.

  * icmp_route_lookup(), which already has a dscp_t variable to pass as
    parameter. We just need to remove the inet_dscp_to_dsfield()
    conversion.

  * br_nf_pre_routing_finish(), ip_options_rcv_srr() and ip4ip6_err(),
    which get the DSCP directly from IPv4 headers. Define a helper to
    read the .tos field of struct iphdr as dscp_t, so that these
    function don't have to do the conversion manually.

While there, declare *iph as const in br_nf_pre_routing_finish(),
declare its local variables in reverse-christmas-tree order and move
the "err = ip_route_input()" assignment out of the conditional to avoid
checkpatch warning.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/ip.h                | 5 +++++
 include/net/route.h             | 5 +++--
 net/bridge/br_netfilter_hooks.c | 8 +++++---
 net/ipv4/icmp.c                 | 2 +-
 net/ipv4/ip_options.c           | 3 ++-
 net/ipv6/ip6_tunnel.c           | 4 ++--
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index d92d3bc3ec0e..bab084df1567 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -424,6 +424,11 @@ int ip_decrease_ttl(struct iphdr *iph)
 	return --iph->ttl;
 }
 
+static inline dscp_t ip4h_dscp(const struct iphdr *ip4h)
+{
+	return inet_dsfield_to_dscp(ip4h->tos);
+}
+
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
 	const struct rtable *rt = dst_rtable(dst);
diff --git a/include/net/route.h b/include/net/route.h
index 1789f1e6640b..03dd28cf4bc4 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -208,12 +208,13 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
 		      const struct sk_buff *hint);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
-				 u8 tos, struct net_device *devin)
+				 dscp_t dscp, struct net_device *devin)
 {
 	int err;
 
 	rcu_read_lock();
-	err = ip_route_input_noref(skb, dst, src, tos, devin);
+	err = ip_route_input_noref(skb, dst, src, inet_dscp_to_dsfield(dscp),
+				   devin);
 	if (!err) {
 		skb_dst_force(skb);
 		if (!skb_dst(skb))
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 0e8bc0ea6175..c6bab2b5e834 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -369,9 +369,9 @@ br_nf_ipv4_daddr_was_changed(const struct sk_buff *skb,
  */
 static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb->dev, *br_indev;
-	struct iphdr *iph = ip_hdr(skb);
 	struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
+	struct net_device *dev = skb->dev, *br_indev;
+	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	int err;
 
@@ -389,7 +389,9 @@ static int br_nf_pre_routing_finish(struct net *net, struct sock *sk, struct sk_
 	}
 	nf_bridge->in_prerouting = 0;
 	if (br_nf_ipv4_daddr_was_changed(skb, nf_bridge)) {
-		if ((err = ip_route_input(skb, iph->daddr, iph->saddr, iph->tos, dev))) {
+		err = ip_route_input(skb, iph->daddr, iph->saddr,
+				     ip4h_dscp(iph), dev);
+		if (err) {
 			struct in_device *in_dev = __in_dev_get_rcu(dev);
 
 			/* If err equals -EHOSTUNREACH the error is due to a
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 7d7b25ed8d21..23664434922e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -545,7 +545,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		orefdst = skb_in->_skb_refdst; /* save old refdst */
 		skb_dst_set(skb_in, NULL);
 		err = ip_route_input(skb_in, fl4_dec.daddr, fl4_dec.saddr,
-				     inet_dscp_to_dsfield(dscp), rt2->dst.dev);
+				     dscp, rt2->dst.dev);
 
 		dst_release(&rt2->dst);
 		rt2 = skb_rtable(skb_in);
diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
index a9e22a098872..b4c59708fc09 100644
--- a/net/ipv4/ip_options.c
+++ b/net/ipv4/ip_options.c
@@ -617,7 +617,8 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev)
 
 		orefdst = skb->_skb_refdst;
 		skb_dst_set(skb, NULL);
-		err = ip_route_input(skb, nexthop, iph->saddr, iph->tos, dev);
+		err = ip_route_input(skb, nexthop, iph->saddr, ip4h_dscp(iph),
+				     dev);
 		rt2 = skb_rtable(skb);
 		if (err || (rt2->rt_type != RTN_UNICAST && rt2->rt_type != RTN_LOCAL)) {
 			skb_dst_drop(skb);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index b60e13c42bca..48fd53b98972 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -630,8 +630,8 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		}
 		skb_dst_set(skb2, &rt->dst);
 	} else {
-		if (ip_route_input(skb2, eiph->daddr, eiph->saddr, eiph->tos,
-				   skb2->dev) ||
+		if (ip_route_input(skb2, eiph->daddr, eiph->saddr,
+				   ip4h_dscp(eiph), skb2->dev) ||
 		    skb_dst(skb2)->dev->type != ARPHRD_TUNNEL6)
 			goto out;
 	}
-- 
2.39.2


