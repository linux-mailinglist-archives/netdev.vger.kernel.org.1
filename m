Return-Path: <netdev+bounces-269922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKHbOdtSvWlr8gIAu9opvQ
	(envelope-from <netdev+bounces-269922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:59:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E02DB7FB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9583300669D
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5163BC664;
	Fri, 20 Mar 2026 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="byw4kC1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492283BA243
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015193; cv=none; b=K/u3sMSEczTpWpITeqYpwgbJcJfRxX+p6rLrZyH8oh7uiUnXGLiZUQHvLnRIusPpBYhyGI/+ouMhRwroIAqfwj2530wDtN0YHSrpAToxuTfFCWd7aVujAhCZh7RHk2D3Dizf0GmLuuWjPK63wmx/hxeENodT5qRl0G1wxkMWi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015193; c=relaxed/simple;
	bh=j5bJdZdQOQONP5KETjxTJRPRw4KzD30sh0sI0PNlTvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7Xos6UWelcA3dxfcIioTlbHRD6tSl4rrgldiNibwIDQarlFPzi5QcyXTLuhlvvFxUHafxSjR+Lo9sZIq8vVYRZRqRjJvHuDNB3ID+XapkH24nGKK7nSMTXGMcd4UmkaOHtPdOMuogYgY2xGK2bLAuvr6vTN/27dcyj1eLapals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=byw4kC1D; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b97bca3797dso256344466b.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1774015186; x=1774619986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+KCYYSes6vGobZd5Ejvl+WWW0UQGCsSz49m3tsEPsw=;
        b=byw4kC1DVCerecSpeafB/NEO5QIIf5ihQBfQApeTR6IkZh/w7tWia9LuqXbfrU2niT
         kZp9qswBWkI4XdQXUOBEitQCyzw1EzVCnXNsPfvn97D5zI368d6qjIQEoejDdCBxJufq
         XhghWRgCCZsXutsm9KcA2MH2jKVNEEbfNR9HkViBC1+s9/8BwedK6G1WvpT3Le2JCzTD
         KDFWk2spwhywCGDdPVENNcxtFzsrOFjsR2A89lIOWH8AXjKPD3+3a+YpkBQaBlIn3825
         fCubkpz4Bb1EILNK0biTcr7GcYj7b57y5tGGjMKFbce8jLS8TM8I9ObPrfol+Ditw2Ow
         Goqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015186; x=1774619986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+KCYYSes6vGobZd5Ejvl+WWW0UQGCsSz49m3tsEPsw=;
        b=ewORetsuDZ8v7llkkThmwPBFXRfWtilrXSKeIMrFVKxdlNJhQKXS1nAoPDwjeM51iC
         jfOifSqnJXya28bmoDRjglIteZSmk3XSwvxRAY4w8YM9RVaO+lvXFvjhQtlJ9t60PI3X
         38ZQadjAxmLarjWjrZYWdzY/3WO1KwSMMTHYkWE11jehymf1eZHelfi+mpszdFBZNxvP
         17VA8TsQ96mc3/rhRcdNN7gKxRzbw5PZjMqoWeSKo506UDbV4ifyvlkwnTOcryJu/0vH
         o0WQs92eE91geEfXiNfJffyPO6F2gcfjX9G5FxHT0unIHk/ZRRh/MC6C1Afqm92HPQJ3
         a6Rg==
X-Gm-Message-State: AOJu0YwtstMowVE+MzaIPhmVD3xJUhMbE+LtS/YgOC+ttp1C+3LnpCIl
	W619VnAFZBC4X9nmcMUZnbOB+ui6q0kVfI9y0msW5X8ad5xTiXwtYqxboKevytXQKVtPh+Zs9AS
	s+w75zIHZrgshzSXIHQEscoAtQM1u10GcXxm2
X-Gm-Gg: ATEYQzw55LvYGkRukwdPn/F9Eqdp6CUMbs5zh0US6XTuSWrGFklUo3sXFU0USD9imUu
	LxZaPnZa5p3bdzy2gL7Frnvq6NpuHVqVPtAojlODpUAK7QfWmgpUTPuzhqcEJxgFt92I6Gz7xjF
	FAJSGCeHJ6NgC+S5l03+wT2yp/XzUKaFyV4Ofw4+rOjS8kH4dwTlAyh9GkyNYepv65ewRlb0cQD
	fOeXVVURIDN62Ji2IWC9JdeBasW+Hl8W49liaV6pq6w104hLKu9AV+q3vv5seq5QmwHROCo7FYR
	FtUgajEFJXQff0U58jCfgz/okArEQCJ4hwnuGH64g8+yHQr6bbW/xMD9tdk8UzxeZWds0R+YVwL
	XTAiesjKnublqWauekcPkWtX5P58kIAZQAbc/fv2tz3oDJhytEps1cKKXTBYVqYQrNzfBsY01kQ
	==
X-Received: by 2002:a17:907:cc02:b0:b97:1d24:c004 with SMTP id a640c23a62f3a-b982f21a33dmr152244766b.21.1774015186279;
        Fri, 20 Mar 2026 06:59:46 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9832efef1asm16718666b.32.2026.03.20.06.59.45;
        Fri, 20 Mar 2026 06:59:46 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id C915D1C272;
	Fri, 20 Mar 2026 14:59:45 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	Justin Iurman <justin.iurman@6wind.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v4 1/2] seg6: add per-route tunnel source address
Date: Fri, 20 Mar 2026 14:59:08 +0100
Message-Id: <20260320135909.1729313-2-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260320135909.1729313-1-justin.iurman@6wind.com>
References: <20260320135909.1729313-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269922-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.941];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B1E02DB7FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
tunnel source address. Make seg6_iptunnel handle the new attribute
correctly. It has priority over the configured per-netns tunnel
source address, if any.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 include/uapi/linux/seg6_iptunnel.h |   1 +
 net/ipv6/seg6_iptunnel.c           | 114 +++++++++++++++++++++--------
 2 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index ae78791372b8..485889b19900 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -20,6 +20,7 @@
 enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
+	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3e1b9991131a..e76cc0cc481e 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -49,6 +49,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 
 struct seg6_lwt {
 	struct dst_cache cache;
+	struct in6_addr tunsrc;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -65,6 +66,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 
 static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
 	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
+	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int nla_put_srh(struct sk_buff *skb, int attrtype,
@@ -87,23 +89,32 @@ static int nla_put_srh(struct sk_buff *skb, int attrtype,
 }
 
 static void set_tun_src(struct net *net, struct net_device *dev,
-			struct in6_addr *daddr, struct in6_addr *saddr)
+			struct in6_addr *daddr, struct in6_addr *saddr,
+			struct in6_addr *route_tunsrc)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	struct in6_addr *tun_src;
 
-	rcu_read_lock();
-
-	tun_src = rcu_dereference(sdata->tun_src);
-
-	if (!ipv6_addr_any(tun_src)) {
-		memcpy(saddr, tun_src, sizeof(struct in6_addr));
+	/* Priority order to select tunnel source address:
+	 *  1. per route source address (if configured)
+	 *  2. per network namespace source address (if configured)
+	 *  3. dynamic resolution
+	 */
+	if (route_tunsrc && !ipv6_addr_any(route_tunsrc)) {
+		memcpy(saddr, route_tunsrc, sizeof(struct in6_addr));
 	} else {
-		ipv6_dev_get_saddr(net, dev, daddr, IPV6_PREFER_SRC_PUBLIC,
-				   saddr);
-	}
+		rcu_read_lock();
+		tun_src = rcu_dereference(sdata->tun_src);
+
+		if (!ipv6_addr_any(tun_src)) {
+			memcpy(saddr, tun_src, sizeof(struct in6_addr));
+		} else {
+			ipv6_dev_get_saddr(net, dev, daddr,
+					   IPV6_PREFER_SRC_PUBLIC, saddr);
+		}
 
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 }
 
 /* Compute flowlabel for outer IPv6 header */
@@ -125,7 +136,8 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 }
 
 static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
-			       int proto, struct dst_entry *cache_dst)
+			       int proto, struct dst_entry *cache_dst,
+			       struct in6_addr *route_tunsrc)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct net_device *dev = dst_dev(dst);
@@ -182,7 +194,7 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
@@ -202,14 +214,15 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 /* encapsulate an IPv6 packet within an outer IPv6 header with a given SRH */
 int seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh, int proto)
 {
-	return __seg6_do_srh_encap(skb, osrh, proto, NULL);
+	return __seg6_do_srh_encap(skb, osrh, proto, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(seg6_do_srh_encap);
 
 /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
 static int seg6_do_srh_encap_red(struct sk_buff *skb,
 				 struct ipv6_sr_hdr *osrh, int proto,
-				 struct dst_entry *cache_dst)
+				 struct dst_entry *cache_dst,
+				 struct in6_addr *route_tunsrc)
 {
 	__u8 first_seg = osrh->first_segment;
 	struct dst_entry *dst = skb_dst(skb);
@@ -272,7 +285,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	if (skip_srh) {
 		hdr->nexthdr = proto;
 
-		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
 		goto out;
 	}
 
@@ -308,7 +321,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 srcaddr:
 	isrh->nexthdr = proto;
-	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr, route_tunsrc);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
@@ -383,9 +396,11 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
+	struct seg6_lwt *slwt;
 	int proto, err = 0;
 
-	tinfo = seg6_encap_lwtunnel(dst->lwtstate);
+	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
+	tinfo = slwt->tuninfo;
 
 	switch (tinfo->mode) {
 	case SEG6_IPTUN_MODE_INLINE:
@@ -410,11 +425,11 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 			return -EINVAL;
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_ENCAP)
-			err = __seg6_do_srh_encap(skb, tinfo->srh,
-						  proto, cache_dst);
+			err = __seg6_do_srh_encap(skb, tinfo->srh, proto,
+						  cache_dst, &slwt->tunsrc);
 		else
-			err = seg6_do_srh_encap_red(skb, tinfo->srh,
-						    proto, cache_dst);
+			err = seg6_do_srh_encap_red(skb, tinfo->srh, proto,
+						    cache_dst, &slwt->tunsrc);
 
 		if (err)
 			return err;
@@ -436,12 +451,12 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
 			err = __seg6_do_srh_encap(skb, tinfo->srh,
-						  IPPROTO_ETHERNET,
-						  cache_dst);
+						  IPPROTO_ETHERNET, cache_dst,
+						  &slwt->tunsrc);
 		else
 			err = seg6_do_srh_encap_red(skb, tinfo->srh,
-						    IPPROTO_ETHERNET,
-						    cache_dst);
+						    IPPROTO_ETHERNET, cache_dst,
+						    &slwt->tunsrc);
 
 		if (err)
 			return err;
@@ -678,6 +693,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 		if (family != AF_INET6)
 			return -EINVAL;
 
+		if (tb[SEG6_IPTUNNEL_SRC]) {
+			NL_SET_ERR_MSG(extack, "incompatible mode for tunsrc");
+			return -EINVAL;
+		}
 		break;
 	case SEG6_IPTUN_MODE_ENCAP:
 		break;
@@ -702,13 +721,23 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	slwt = seg6_lwt_lwtunnel(newts);
 
 	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
-	if (err) {
-		kfree(newts);
-		return err;
-	}
+	if (err)
+		goto free_lwt_state;
 
 	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
 
+	if (tb[SEG6_IPTUNNEL_SRC]) {
+		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
+
+		if (ipv6_addr_any(&slwt->tunsrc) ||
+		    ipv6_addr_is_multicast(&slwt->tunsrc) ||
+		    ipv6_addr_loopback(&slwt->tunsrc)) {
+			NL_SET_ERR_MSG(extack, "invalid tunsrc address");
+			err = -EINVAL;
+			goto free_dst_cache;
+		}
+	}
+
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
@@ -720,6 +749,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	*ts = newts;
 
 	return 0;
+
+free_dst_cache:
+	dst_cache_destroy(&slwt->cache);
+free_lwt_state:
+	kfree(newts);
+	return err;
 }
 
 static void seg6_destroy_state(struct lwtunnel_state *lwt)
@@ -731,29 +766,46 @@ static int seg6_fill_encap_info(struct sk_buff *skb,
 				struct lwtunnel_state *lwtstate)
 {
 	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
+	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
 
 	if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, tuninfo))
 		return -EMSGSIZE;
 
+	if (!ipv6_addr_any(&slwt->tunsrc) &&
+	    nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
 static int seg6_encap_nlsize(struct lwtunnel_state *lwtstate)
 {
 	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
+	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
+	int nlsize;
+
+	nlsize = nla_total_size(SEG6_IPTUN_ENCAP_SIZE(tuninfo));
 
-	return nla_total_size(SEG6_IPTUN_ENCAP_SIZE(tuninfo));
+	if (!ipv6_addr_any(&slwt->tunsrc))
+		nlsize += nla_total_size(sizeof(slwt->tunsrc));
+
+	return nlsize;
 }
 
 static int seg6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 {
 	struct seg6_iptunnel_encap *a_hdr = seg6_encap_lwtunnel(a);
 	struct seg6_iptunnel_encap *b_hdr = seg6_encap_lwtunnel(b);
+	struct seg6_lwt *a_slwt = seg6_lwt_lwtunnel(a);
+	struct seg6_lwt *b_slwt = seg6_lwt_lwtunnel(b);
 	int len = SEG6_IPTUN_ENCAP_SIZE(a_hdr);
 
 	if (len != SEG6_IPTUN_ENCAP_SIZE(b_hdr))
 		return 1;
 
+	if (!ipv6_addr_equal(&a_slwt->tunsrc, &b_slwt->tunsrc))
+		return 1;
+
 	return memcmp(a_hdr, b_hdr, len);
 }
 
-- 
2.39.2


