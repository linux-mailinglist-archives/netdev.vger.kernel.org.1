Return-Path: <netdev+bounces-264308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDKNFf5lqWlN6wAAu9opvQ
	(envelope-from <netdev+bounces-264308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F3210703
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 12:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBDF3139A6D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F99384258;
	Thu,  5 Mar 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="DVW6TfxG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D165383C8F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709021; cv=none; b=NqdmH9aLd/eaAxGfN2S+WKgkohDf9GlfX+aq9DQLx6ZP03+QVfbvVjJkeajOTNnzuZ7YRGXNNqi6oIUGykY/fMXd3UC8lprppUbA/dUJrR87QIH2ltAvzsHvs7k4oa9BMH+xB+p3qwVkBrLqJq/sX5V2oHNWMRd03bKVEE4tL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709021; c=relaxed/simple;
	bh=iILJccyDyJaNfe5/O36ZoRk8XcC4XvtVI+KNgSJv2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VViSM2DkqeOtVzaL+bzG8t+lgWxW7CwCNNyLvflidkUnXXHhHu9G7Totjc/6IZLM6g+ELnXPwz8l4VQqWDWRZPbsIZ7uF7OwTAfPyRr1X3BvErh0aleSROle88hDZBZ+tBlFfzda/lwNochFTZlH+7ZbzeTFtSSkFUj+8ad1468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=DVW6TfxG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70b69ced09so2205217a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 03:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1772709018; x=1773313818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Uah3KJlZJ0YDkhXOPrfMLRnjC77tql+fRjEzdTgsKU=;
        b=DVW6TfxGI3iG/7wYkWj8BG2PVC1BcETzqH1s2iQr/tDZ0XYDtmlfMnGCr1bUq5UxGJ
         8dCfYy8Rc9qhoX55TBHO3FUL/prPI4EKzu5ukTCNUSAGzMlrc/346feltegVNMo41GM5
         fVLJk4K6SjwqvgyRg8TYOWQbtPdgbnMn1xtguH9Vfpkg61dV6HovyVllwVppzg6HC8VP
         GMY+YYcUfH1bSDQT11RBwQh0/BOVnBbvMfbD2jC2c5i3irw0YJTetfLFoTPd2wJgXimb
         Xoq21EK7vHaOKPMpecQIjigkrdL5hR2fIYYszktzGTOsy7ZRc0a8fVBMYzPEOqxvGS9Q
         D0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772709018; x=1773313818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Uah3KJlZJ0YDkhXOPrfMLRnjC77tql+fRjEzdTgsKU=;
        b=jERlWyQG2QzeJZCxZKKehtiwPciUZSIAMzQ82FjQlYRNLIy3Tuj2iqqV5lIvZcNm/V
         aWi8LIjkTd29UJEamfedgw2TYWxus8xPVRSHijKC8+TJA0pc1cWIQzp4N0WZJ/DuOwiz
         y2NFTbp2jVZkZf53E+IlGUW7vX/1SNHV4pM27K3KMkz1Mnxz1fTE6fsZire7WXecUJhy
         +uOTDzRAtXLnb4Wu/rP2nWcOXxbp+FfF2jebNM5G/qxKDJR+qKm129qvAyMS8vucmH+g
         XxxxPMT7NsoXUsGjohpKH9MJLFKEtmdkpfSjGwz8sE3OOY3KSZdfNwWpdw2xNv4w8F6H
         EtyA==
X-Forwarded-Encrypted: i=1; AJvYcCWh33KIw/QA6xO8kzc3A81ZCzs615ZPoY5kuaE8JSzl9T1+nA/oRubNurO46xHULpfc43ERbZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjejtQYcbR8exZXpnZNdDVjVObKLl08agEzzid8Uguqjby81oj
	PpJ3cyjs34zZBiI71pXrMzOq0FU4MzbsvzHsh7u72OXXVbqWahLWKOGRIde+niB1SlI=
X-Gm-Gg: ATEYQzxhelNVf5PTEMR4LZ3psHpBYeHquP5sQH+v7QivvU6ijHScv2DLRpfG8vUjE1q
	vlSOssmtyivrC3Ba1g+Z0c73ChkHZD9ZBQNfrvVolsVGwV2BSto9NG+KCnUzVdsH8+1+LoUAuFB
	wo57QxThC4yZ8jmouGc9XFMlSpC6FeJQ7ddO5oq1/3FH21Tq5fzZDfXfMRmoVXO0VelYbhWPpDH
	uYSuQkjcvKxSLVLNGvokuKtfTHiIwyWh+0JzNkCxdMKRio4H6kSkHkKR9X3bfplu/NgtCJ5Ae8X
	y0NGqOOkik5kvfA1E8HlEvqJx2DBIKqlcRo0oRrvP+iL0HYbD4NO1FYAdW5hh8+8/316qOgfgl5
	XbThERzM4wTGRa0LlDAVyWuj16yt8S8wXr+rpNrR/3Ljt9h/L6tt/KNXBFSMXeNMWQKEQ8tKRix
	xKcbkTR/iUPwXFhFfIeiq+NrVi5AVxW5fg9Qn1vCusFxcOBl8MVRd0SwTe5feiq7rOGWFYsjmCy
	7X8oiFjB7OlOc4TCEZ8BaI=
X-Received: by 2002:a17:902:db0f:b0:2ad:6e26:abbb with SMTP id d9443c01a7336-2ae6ab9ecd3mr48315825ad.54.1772709018409;
        Thu, 05 Mar 2026 03:10:18 -0800 (PST)
Received: from cachyos.camel-monitor.ts.net (akacd-04p3-188.ppp11.odn.ad.jp. [210.237.248.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm153501155ad.28.2026.03.05.03.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:10:18 -0800 (PST)
From: Kota Toda <kota.toda@gmo-cybersecurity.com>
To: Jeff Garzik <jeff@garzik.org>,
	Jay Vosburgh <fubar@us.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>
Cc: Kota Toda <kota.toda@gmo-cybersecurity.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuki Koike <yuki.koike@gmo-cybersecurity.com>,
	linux-wpan@vger.kernel.org
Subject: [PATCH v4 2/2] net: read header_ops callbacks with READ_ONCE()
Date: Thu,  5 Mar 2026 20:07:49 +0900
Message-ID: <20260305110751.167489-3-kota.toda@gmo-cybersecurity.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E09F3210703
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[garzik.org,us.ibm.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,datenfreihafen.org,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264308-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:dkim,gmo-cybersecurity.com:email,gmo-cybersecurity.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Bonding now updates its header_ops callbacks at runtime, so lockless
readers can observe concurrent callback updates.

This patch loads header_ops callbacks with READ_ONCE() and 
call the loaded function pointer, instead of 
re-reading through dev->header_ops.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 include/linux/netdevice.h | 41 +++++++++++++++++++++++++++------------
 include/net/cfg802154.h   |  2 +-
 net/core/neighbour.c      |  6 +++---
 net/ipv4/arp.c            |  2 +-
 net/ipv6/ndisc.c          |  2 +-
 5 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 77a99c8ab..79fb0864a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3150,35 +3150,50 @@ static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 				  const void *daddr, const void *saddr,
 				  unsigned int len)
 {
-	if (!dev->header_ops || !dev->header_ops->create)
-		return 0;
+	int (*create)(struct sk_buff *skb, struct net_device *dev,
+		      unsigned short type, const void *daddr,
+		      const void *saddr, unsigned int len);
 
-	return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
+	if (!dev->header_ops)
+		return 0;
+	create = READ_ONCE(dev->header_ops->create);
+	if (!create)
+		return 0;
+	return create(skb, dev, type, daddr, saddr, len);
 }
 
 static inline int dev_parse_header(const struct sk_buff *skb,
 				   unsigned char *haddr)
 {
+	int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
 	const struct net_device *dev = skb->dev;
 
-	if (!dev->header_ops || !dev->header_ops->parse)
+	if (!dev->header_ops)
 		return 0;
-	return dev->header_ops->parse(skb, haddr);
+	parse = READ_ONCE(dev->header_ops->parse);
+	if (!parse)
+		return 0;
+	return parse(skb, haddr);
 }
 
 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
 {
+	__be16	(*parse_protocol)(const struct sk_buff *skb);
 	const struct net_device *dev = skb->dev;
 
-	if (!dev->header_ops || !dev->header_ops->parse_protocol)
+	if (!dev->header_ops)
+		return 0;
+	parse_protocol = READ_ONCE(dev->header_ops->parse_protocol);
+	if (!parse_protocol)
 		return 0;
-	return dev->header_ops->parse_protocol(skb);
+	return parse_protocol(skb);
 }
 
 /* ll_header must have at least hard_header_len allocated */
 static inline bool dev_validate_header(const struct net_device *dev,
 				       char *ll_header, int len)
 {
+	bool	(*validate)(const char *ll_header, unsigned int len);
 	if (likely(len >= dev->hard_header_len))
 		return true;
 	if (len < dev->min_header_len)
@@ -3189,15 +3204,17 @@ static inline bool dev_validate_header(const struct net_device *dev,
 		return true;
 	}
 
-	if (dev->header_ops && dev->header_ops->validate)
-		return dev->header_ops->validate(ll_header, len);
-
-	return false;
+	if (!dev->header_ops)
+		return false;
+	validate = READ_ONCE(dev->header_ops->validate);
+	if (!validate)
+		return false;
+	return validate(ll_header, len);
 }
 
 static inline bool dev_has_header(const struct net_device *dev)
 {
-	return dev->header_ops && dev->header_ops->create;
+	return dev->header_ops && READ_ONCE(dev->header_ops->create);
 }
 
 /*
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76d2cd2e2..dec638763 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -522,7 +522,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 {
 	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
 
-	return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+	return READ_ONCE(wpan_dev->header_ops->create)(skb, dev, daddr, saddr, len);
 }
 #endif
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96786016d..ff948e35e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1270,7 +1270,7 @@ static void neigh_update_hhs(struct neighbour *neigh)
 		= NULL;
 
 	if (neigh->dev->header_ops)
-		update = neigh->dev->header_ops->cache_update;
+		update = READ_ONCE(neigh->dev->header_ops->cache_update);
 
 	if (update) {
 		hh = &neigh->hh;
@@ -1540,7 +1540,7 @@ static void neigh_hh_init(struct neighbour *n)
 	 * hh_cache entry.
 	 */
 	if (!hh->hh_len)
-		dev->header_ops->cache(n, hh, prot);
+		READ_ONCE(dev->header_ops->cache)(n, hh, prot);
 
 	write_unlock_bh(&n->lock);
 }
@@ -1556,7 +1556,7 @@ int neigh_resolve_output(struct neighbour *neigh, struct sk_buff *skb)
 		struct net_device *dev = neigh->dev;
 		unsigned int seq;
 
-		if (dev->header_ops->cache && !READ_ONCE(neigh->hh.hh_len))
+		if (READ_ONCE(dev->header_ops->cache) && !READ_ONCE(neigh->hh.hh_len))
 			neigh_hh_init(neigh);
 
 		do {
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7822b2144..421bea6eb 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -278,7 +278,7 @@ static int arp_constructor(struct neighbour *neigh)
 			memcpy(neigh->ha, dev->broadcast, dev->addr_len);
 		}
 
-		if (dev->header_ops->cache)
+		if (READ_ONCE(dev->header_ops->cache))
 			neigh->ops = &arp_hh_ops;
 		else
 			neigh->ops = &arp_generic_ops;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d961e6c2d..d81f509ec 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -361,7 +361,7 @@ static int ndisc_constructor(struct neighbour *neigh)
 			neigh->nud_state = NUD_NOARP;
 			memcpy(neigh->ha, dev->broadcast, dev->addr_len);
 		}
-		if (dev->header_ops->cache)
+		if (READ_ONCE(dev->header_ops->cache))
 			neigh->ops = &ndisc_hh_ops;
 		else
 			neigh->ops = &ndisc_generic_ops;
-- 
2.53.0


