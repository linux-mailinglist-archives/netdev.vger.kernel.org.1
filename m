Return-Path: <netdev+bounces-266680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P12JLaLsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:35:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084E266A42
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 128EC30DB18E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BCD3DF000;
	Wed, 11 Mar 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="L+8eObxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998E3E024B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242943; cv=none; b=AMYNH0u8MeSjalkFUTL9UNFvizUKr0DCEbtKslQnSPgYt4teT+h2cSiks+1J5vUQKLaCFdhd0D8ycH1JJ2o8qX3UPhkWwmejqB7eiBV3AZMDytmOctx31h3vHWbAB2p5q6cRj8WSfzw8H3aQ4ArOlHgwtMKV+HT4D55+N8orVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242943; c=relaxed/simple;
	bh=5JdQz1Cy8Hw4IUjoRWcpQKquncWpyoZUerG0IUCWw6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rglFvdXVe6xWgqneyBef084RE0im2PfRj6M9fDfKIMaLNQ/eM3OF12W60GJ7MYVXDlHWLqd+up50buBv/YB+8PkSG5YuaUI3CS22dqUz2mFq4Yf+WRIb9ZFhfvFE5VNHqXFJiYvKtgJK2MCAtuqK46bJAgvIegYw2VFBoub0E8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=L+8eObxE; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b9431300833so823904566b.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773242940; x=1773847740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kllx2V4OU1QkkYrrdSCa3CZvRuMIENw21rEAbRwBj1E=;
        b=L+8eObxEBDJEcfdZwbX/g0IuK2YvlncBOm/AauVPzZ5apF8hzIPsqa5d9YJfMMgu6O
         0OX6cbA889rDwXRnCQgUEeIlFySzjvDRH1a32f9wryUQxArQKmDYQ7U5bQkbhsGH/KG+
         oW6QBaSaLhQsM8AS3NVr709xlq6Y6+G9Q9lm0DSa5GKzcCNXPCWy1iCVJrLrkGMaZ0vR
         U5Dhmlt7EyChH3shmRtk07AYa2dQoXc8ANwGNehamQ9tg8vsC+RjTCRXfhLIyc0kaVWR
         kFKOW5TwvO+Iw3kTFnt8+1TeRE+KzKtqIU4zDubIW9RLgbrwgswhDN05iiixio9arbol
         1KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773242940; x=1773847740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kllx2V4OU1QkkYrrdSCa3CZvRuMIENw21rEAbRwBj1E=;
        b=oUm9inPmtN+9GSInLFuCDg7oWVpjgb7pctHRytfXYmWPnZJU64W3Hr9Us38pUJw7F3
         XG20gFXh5kTkCMevz/ouw1jMH1ZRCKfG1Oej2DLSIn5//uZNcAHWRfjlShkhyfvs4zyJ
         6pHQUIPCE9wNLTRyy7wkctjfgXZbLt6lJEHxYf85jp9Bhw2w2ixxKZg3+6W2ZYJMkZlQ
         KXgqnAqRIZIx99OYCQV8f/gT2BgRUN+cNjtrI60J+hN6A6YzNKRh/95BaTzY0sNqZwIz
         AlGkaukhrvQWMIwdIXl0hCnbuoVTQOGbqwnwZo0hdDgbigp0MnC8SWbSaMQETXx8yh1w
         Kb4w==
X-Gm-Message-State: AOJu0YzmxUvjY+mL2Eat31VZVSibu2opJCKF+iIag76H5UBMo5M+itpm
	kzPmTUCMPfA5OUHWpKB8OM6lZ/UnjIW6dE5rMJGmCYn8HDpk2r5WUJpR6E+ghTT1kchEmyJmJUt
	wT2VB905auomEo98oSV8hoS9LU+9EYqhn4bER
X-Gm-Gg: ATEYQzxzQWui+k+SAZsOexB2r0L5CfqkT9jYqzmb5cK573dVR3NIQRvSoB6GoN8hYNd
	yABrc0dGDHDyuTPNsvQzkLkKOGrYjneLZ8OqmEVv/EUHAZbyGTF+IPH4bQanYTSpmkKu2NHzlo/
	TTKlU4IGtsrv5Xv6FqcSlFfStRq3w6Pf7PoLAaSpAkwVHzptBvAJh4h92phcCmqTRJzsP0zlTij
	wv8Fl7NjJJKpjnnIijlg1kcEqpLvvoNFeG4xxvBUxxFyXDOn75KQb4PXmHU/dQ8y9ZqGn7+1ZEE
	VjhEHQuxkoWW+9oBCFQfYD+ygV/mIZ8XljPX8W3E0qxeZdb0q4IHuQAJcMEMH4ZiKzhqxCS3qKL
	gl5Y5Xl+cEMKQD2xH+Tg5owsvvgxvEabJqPAs63b4463MLExWeeubPSCb4qEWiNH+Y89jchPr5Q
	==
X-Received: by 2002:a17:907:1c88:b0:b93:8460:4a7 with SMTP id a640c23a62f3a-b972e5a84e0mr185496166b.56.1773242939741;
        Wed, 11 Mar 2026 08:28:59 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b972e3d833asm17052066b.76.2026.03.11.08.28.59;
        Wed, 11 Mar 2026 08:28:59 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 1F72D16DB4;
	Wed, 11 Mar 2026 16:28:59 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH net-next v2] seg6: add per-route tunnel source address
Date: Wed, 11 Mar 2026 16:28:45 +0100
Message-Id: <20260311152845.278354-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-266680-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid]
X-Rspamd-Queue-Id: 1084E266A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
tunnel source address. Make seg6_iptunnel handle the new attribute
correctly. It has priority over the configured per-netns tunnel
source address, if any.

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
v2:
 - AI review: fix seg6_encap_nlsize() and seg6_encap_cmp() to include tunsrc
 - AI review: make set_tun_src() agnostic of seg6_lwt because it is called from
              two contexts other than seg6_iptunnel

v1: https://lore.kernel.org/netdev/CAOY2BqxUswHYoisKjABPunMUC5QJ-B-O9aXu=wKrhTZaqSqedQ@mail.gmail.com/T/
---
 include/uapi/linux/seg6_iptunnel.h |   1 +
 net/ipv6/seg6_iptunnel.c           | 115 +++++++++++++++++++++--------
 2 files changed, 85 insertions(+), 31 deletions(-)

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
index 3e1b9991131a..d45b6b49dd48 100644
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
@@ -702,13 +721,21 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
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
+		if (ipv6_addr_any(&slwt->tunsrc)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "tunsrc cannot be ::");
+			goto free_dst_cache;
+		}
+	}
+
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
@@ -720,6 +747,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
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
@@ -731,29 +764,49 @@ static int seg6_fill_encap_info(struct sk_buff *skb,
 				struct lwtunnel_state *lwtstate)
 {
 	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
+	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
+	int err;
 
 	if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, tuninfo))
 		return -EMSGSIZE;
 
+	if (!ipv6_addr_any(&slwt->tunsrc)) {
+		err = nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc);
+		if (err)
+			return err;
+	}
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


