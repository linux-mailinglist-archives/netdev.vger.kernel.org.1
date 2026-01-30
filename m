Return-Path: <netdev+bounces-255255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MSvDdYdfWlQQQIAu9opvQ
	(envelope-from <netdev+bounces-255255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:08:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B32BEB2A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 22:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7969F30C6933
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B67387591;
	Fri, 30 Jan 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQWRsQ5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928FD387370
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769806989; cv=none; b=EXDEmnyQqgKo/f6T5fbnWdhP1fuTOejn1ohIDtO/pcXekdidgI9fUlHai7BYcXGyk+d6agu0fual0FQyNVWwfshwwJvf3eIA+gKNUxYa/VDL4b5rDxH2ljKi4k3ASixiv8t587pKjTiEu66QdSRwvWSjZgHbFW+TLMixFp30xmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769806989; c=relaxed/simple;
	bh=z/6ny0BoV9H0IOv7hLdJZS02lkjVLNXbfpg5XcoIOcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEJ/7QwZEb7Jr+La6tDGX1B9L1Btk3xnMUP0kY8TV5Qzlecb/PGK6qpNaViVCM1X9uSDb3t/P6kvZ72+qkhN3LzB41QTkcQQgNXYKotOsXnAqTPAMTT8rtQklDbGT/L+Hjbde95+ethhHv3MeqlPO6yWOZ9mk2DUGM6i0+Q/WjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQWRsQ5O; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-502a13e3e55so74603141cf.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769806986; x=1770411786; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=el0H0o6fE+UcKyZlxlxy5Sw6x2XWfnY9uF1RI21g/SM=;
        b=lQWRsQ5OODkOtBtZ9tPQbn6GRAuHHe3i9xUa9M/fRowfOR/RBjMz6w8NCNBo44/KVr
         NuI+FLH8Q4tejVvVjjTNG+7W2cT6u3WGJ96jmCxxes/ufdDqklv9vBjgQzZKLUV5Q7yy
         eZVQv2sSe9MNXeXNoKwUrQcn5LKXlDBb6H0CLg9ANp5SFPM8ItcX83bu0eWOHsEU+9hT
         oKFQHMJQlhSh2QLBEYocWBTq8ygyQtbEfv9cF54oM00JU22yl2ClAbFrimi5t05HOeCw
         ZhGX2lzXTYqTttOTWB23jZZD9Wra68MzNVhrdBnlyFEgXQXT4z0ZJDirc28qryPZPHGM
         vqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769806986; x=1770411786;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=el0H0o6fE+UcKyZlxlxy5Sw6x2XWfnY9uF1RI21g/SM=;
        b=ZjqNtZt8NGxOJneUJ2XiXvebmDVQx8e5jjTghsCXa59W0bKZFhgUhhXbunZeLyg30Y
         R4+Uhg9vvunbGs8FaTfKtfKYOK+/oFSr1mHG+63QSTIwiiVroMkAPYrl3S7md4Aiod59
         aO21+OsHEZwgpBzK+Yq3srqsQKbb/OjB4SKIbWBjB9XzjcA1TlqK+06/nRsWD0E1jg5T
         pDav9Yu+tvA8JpcOty9J9rd3GcMNB69+r3T/ga5JLarAkJgjdiT5+Itku0QZNeA4BoGX
         7056CsZcHjDXsIkjetjmYoyNV4K70ZAL/3huqoX4CGk0CkNi5oPisdNqCdsnn7pm5KyZ
         EOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEiI5XbHqU3Vcmm08ASKxqJOLfTnRR6eXt2ydc8uY+YQGaNfw2UO/dLtMSiDfyB2DCwastkCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRXH+/lASMiGSuxb0pWpGwTWay/68XTkPb91oIymwFCkWSX0h
	dyY26cE7dQgPqYm94XLqgpE2qGo0Nkflk/xcP95uKB6nLCSxxz3JVuK8W0xmfpEIwJP5RCFEnXN
	T43VGbNkQxxGLlA==
X-Received: from qtec7.prod.google.com ([2002:ac8:7dc7:0:b0:501:465a:256c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:513:b0:4ed:dcf0:6c42 with SMTP id d75a77b69052e-505d225e164mr53226811cf.40.1769806986590;
 Fri, 30 Jan 2026 13:03:06 -0800 (PST)
Date: Fri, 30 Jan 2026 21:02:56 +0000
In-Reply-To: <20260130210303.3888261-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260130210303.3888261-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130210303.3888261-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] ipv6: pass proto by value to ipv6_push_nfrag_opts()
 and ipv6_push_frag_opts()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255255-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91B32BEB2A
X-Rspamd-Action: no action

With CONFIG_STACKPROTECTOR_STRONG=y, it is better to avoid passing
a pointer to an automatic variable.

Change these exported functions to return 'u8 proto'
instead of void.

- ipv6_push_nfrag_opts()
- ipv6_push_frag_opts()

For instance, replace
	ipv6_push_frag_opts(skb, opt, &proto);
with:
	proto = ipv6_push_frag_opts(skb, opt, proto);

Note that even after this change, ip6_xmit() has to use a stack canary
because of @first_hop variable.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h    | 10 ++++----
 net/ipv6/exthdrs.c    | 55 +++++++++++++++++++++++--------------------
 net/ipv6/ip6_output.c | 19 ++++++++-------
 net/ipv6/ip6_tunnel.c |  2 +-
 4 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cf2203ff2bfd2b42381aba196578cd2668796c8b..a35f0a8114c093c65d3706f53b945cb426bd212b 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1151,11 +1151,11 @@ int ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb);
  *	Extension header (options) processing
  */
 
-void ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			  u8 *proto, struct in6_addr **daddr_p,
-			  struct in6_addr *saddr);
-void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			 u8 *proto);
+u8 ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+			u8 proto, struct in6_addr **daddr_p,
+			struct in6_addr *saddr);
+u8 ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+		       u8 proto);
 
 int ipv6_skip_exthdr(const struct sk_buff *, int start, u8 *nexthdrp,
 		     __be16 *frag_offp);
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index cd318ff0dcd8784c3e3841d61d682f2c4a523e61..209fdf1b1aa9b9111f9131a75a6e18e7f9a153fe 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1074,9 +1074,9 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
  *	for headers.
  */
 
-static void ipv6_push_rthdr0(struct sk_buff *skb, u8 *proto,
-			     struct ipv6_rt_hdr *opt,
-			     struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr0(struct sk_buff *skb, u8 proto,
+			   struct ipv6_rt_hdr *opt,
+			   struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	struct rt0_hdr *phdr, *ihdr;
 	int hops;
@@ -1095,13 +1095,13 @@ static void ipv6_push_rthdr0(struct sk_buff *skb, u8 *proto,
 	phdr->addr[hops - 1] = **addr_p;
 	*addr_p = ihdr->addr;
 
-	phdr->rt_hdr.nexthdr = *proto;
-	*proto = NEXTHDR_ROUTING;
+	phdr->rt_hdr.nexthdr = proto;
+	return NEXTHDR_ROUTING;
 }
 
-static void ipv6_push_rthdr4(struct sk_buff *skb, u8 *proto,
-			     struct ipv6_rt_hdr *opt,
-			     struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr4(struct sk_buff *skb, u8 proto,
+			   struct ipv6_rt_hdr *opt,
+			   struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	struct ipv6_sr_hdr *sr_phdr, *sr_ihdr;
 	int plen, hops;
@@ -1144,58 +1144,61 @@ static void ipv6_push_rthdr4(struct sk_buff *skb, u8 *proto,
 	}
 #endif
 
-	sr_phdr->nexthdr = *proto;
-	*proto = NEXTHDR_ROUTING;
+	sr_phdr->nexthdr = proto;
+	return NEXTHDR_ROUTING;
 }
 
-static void ipv6_push_rthdr(struct sk_buff *skb, u8 *proto,
-			    struct ipv6_rt_hdr *opt,
-			    struct in6_addr **addr_p, struct in6_addr *saddr)
+static u8 ipv6_push_rthdr(struct sk_buff *skb, u8 proto,
+			  struct ipv6_rt_hdr *opt,
+			  struct in6_addr **addr_p, struct in6_addr *saddr)
 {
 	switch (opt->type) {
 	case IPV6_SRCRT_TYPE_0:
 	case IPV6_SRCRT_STRICT:
 	case IPV6_SRCRT_TYPE_2:
-		ipv6_push_rthdr0(skb, proto, opt, addr_p, saddr);
+		proto = ipv6_push_rthdr0(skb, proto, opt, addr_p, saddr);
 		break;
 	case IPV6_SRCRT_TYPE_4:
-		ipv6_push_rthdr4(skb, proto, opt, addr_p, saddr);
+		proto = ipv6_push_rthdr4(skb, proto, opt, addr_p, saddr);
 		break;
 	default:
 		break;
 	}
+	return proto;
 }
 
-static void ipv6_push_exthdr(struct sk_buff *skb, u8 *proto, u8 type, struct ipv6_opt_hdr *opt)
+static u8 ipv6_push_exthdr(struct sk_buff *skb, u8 proto, u8 type, struct ipv6_opt_hdr *opt)
 {
 	struct ipv6_opt_hdr *h = skb_push(skb, ipv6_optlen(opt));
 
 	memcpy(h, opt, ipv6_optlen(opt));
-	h->nexthdr = *proto;
-	*proto = type;
+	h->nexthdr = proto;
+	return type;
 }
 
-void ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
-			  u8 *proto,
-			  struct in6_addr **daddr, struct in6_addr *saddr)
+u8 ipv6_push_nfrag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt,
+			u8 proto,
+			struct in6_addr **daddr, struct in6_addr *saddr)
 {
 	if (opt->srcrt) {
-		ipv6_push_rthdr(skb, proto, opt->srcrt, daddr, saddr);
+		proto = ipv6_push_rthdr(skb, proto, opt->srcrt, daddr, saddr);
 		/*
 		 * IPV6_RTHDRDSTOPTS is ignored
 		 * unless IPV6_RTHDR is set (RFC3542).
 		 */
 		if (opt->dst0opt)
-			ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst0opt);
+			proto = ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst0opt);
 	}
 	if (opt->hopopt)
-		ipv6_push_exthdr(skb, proto, NEXTHDR_HOP, opt->hopopt);
+		proto = ipv6_push_exthdr(skb, proto, NEXTHDR_HOP, opt->hopopt);
+	return proto;
 }
 
-void ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt, u8 *proto)
+u8 ipv6_push_frag_opts(struct sk_buff *skb, struct ipv6_txoptions *opt, u8 proto)
 {
 	if (opt->dst1opt)
-		ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst1opt);
+		proto = ipv6_push_exthdr(skb, proto, NEXTHDR_DEST, opt->dst1opt);
+	return proto;
 }
 EXPORT_SYMBOL(ipv6_push_frag_opts);
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b907a5704c32452ff585479e369727..e4bed95ae5bba173c2418d402cba46e946335219 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -305,11 +305,12 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		seg_len += opt->opt_nflen + opt->opt_flen;
 
 		if (opt->opt_flen)
-			ipv6_push_frag_opts(skb, opt, &proto);
+			proto = ipv6_push_frag_opts(skb, opt, proto);
 
 		if (opt->opt_nflen)
-			ipv6_push_nfrag_opts(skb, opt, &proto, &first_hop,
-					     &fl6->saddr);
+			proto = ipv6_push_nfrag_opts(skb, opt, proto,
+						     &first_hop,
+						     &fl6->saddr);
 	}
 
 	if (unlikely(seg_len > IPV6_MAXPLEN)) {
@@ -1940,11 +1941,13 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	__skb_pull(skb, skb_network_header_len(skb));
 
 	final_dst = &fl6->daddr;
-	if (opt && opt->opt_flen)
-		ipv6_push_frag_opts(skb, opt, &proto);
-	if (opt && opt->opt_nflen)
-		ipv6_push_nfrag_opts(skb, opt, &proto, &final_dst, &fl6->saddr);
-
+	if (opt) {
+		if (opt->opt_flen)
+			proto = ipv6_push_frag_opts(skb, opt, proto);
+		if (opt->opt_nflen)
+			proto = ipv6_push_nfrag_opts(skb, opt, proto,
+						     &final_dst, &fl6->saddr);
+	}
 	skb_push(skb, sizeof(struct ipv6hdr));
 	skb_reset_network_header(skb);
 	hdr = ipv6_hdr(skb);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index f68f6f110a3e7ea70b9aca4ad1fcfb4d6fe15c38..6fca0868b5a237417eb4c013f713952e8922696d 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1265,7 +1265,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
-		ipv6_push_frag_opts(skb, &opt.ops, &proto);
+		proto = ipv6_push_frag_opts(skb, &opt.ops, proto);
 	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
-- 
2.53.0.rc1.225.gd81095ad13-goog


