Return-Path: <netdev+bounces-252068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLLAEGtNcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E84195E746
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3124B8071DA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D001B808;
	Wed, 21 Jan 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jKcQgqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F93A7E03
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032652; cv=none; b=fUMHfac8A4ArQln39ec9WDr9W6InmK2886kkOgZGJleSPpLS7Gyfamfygkx6oADGvETM7Hwo6xENLC/pD2AK09mjId05v8rkY6PXTlyvE+aw8MholnHefD85476S+xy2OkA+AwpdqEvkB1SCk7HDU6nU9ARx5BlNydeV66BkOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032652; c=relaxed/simple;
	bh=qeE7SfD7B0fwtP4xUce+epqihIWZjzxaI5ZTmEm5PLU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O3S+0Jql6zmaKwS9fHlR3FrazN5wDXK8XV/ksyXeElqHOPbd6xO2UadKVHAunw7YvRc9VXgiH0VhO4YO3UwdkwxodlgI9fs1xIR+sUHXFrELtcGklUOUfJfuPYjs8DS12QndAxYfkTYHou8HAeKImE7crIYPztxszN69PrUKGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jKcQgqc; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c52dcf85b2so113157185a.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769032650; x=1769637450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYZxkLavyVK6XI9YmjXkHy7gFRvrVN8Yhm/8l9rm4Sw=;
        b=0jKcQgqcZH7LmZLzkb3rTbCbibhwjLBsRf6Q+GOwC9EGBWDFwXmoSXKaYyy5ojmZBQ
         MeHEozGUpMygwhoMaSMBCAeTrV1bd00lQoDs756WYKJ2pE2EnrIHeFNMnE9+XL7LagJA
         kHU4SZXYlY7uAbbD1+7ve43ZV6SKYFcAcoENcKskgrG1ZJzv3Wq6j3uHeMzl/JRXGXRC
         +n/MXvUjdLGho9vnf1BxbVJ0AjykoHimjvWjFI3ntUSmFGtPa0yWTsCAqbOZrFGX55d9
         B/QSXIA0K7i+gYtt4nM2FCCWdwtHPC8EnIonHf2tbQX1CozAJLTCWnsXwFhm5HkxOGqU
         Cnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032650; x=1769637450;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYZxkLavyVK6XI9YmjXkHy7gFRvrVN8Yhm/8l9rm4Sw=;
        b=caB1IwCXesFfQOBphr5QnfvBA3vxjqM7Ugpo6Yxx/XAaIOPqhzZYcCdzYRztKrA0kK
         ched3v7r/y7S9qQ+c/5OgGPhQ0tnLRzZXqy6LlnQv6n6NjCT9PEWYZL+qFFBbIYzsxLV
         A1QBb6pEnTKW6/mdNNmyWJ8G3Rhgcy3GajXN9aQBGRhUCzHkxIvvlkC/G5ySGkmGpaQb
         9dq8J6Qm94fgLBWMniD4aorMXgK9PRsfJA9mOIpmecuExJnVDE5lxz1YJBckfWGtIhlI
         QmpkCXL3nga5bb40UcD5UWh7xZsEj/lqHHEAY40quv3AAqqh7t20v7h6mhoFOoE6Lj8+
         keRg==
X-Forwarded-Encrypted: i=1; AJvYcCWdoLsJoQ4HnunypNU1C3qhBA7acMY4PWI1IY4/hHxHgXugYQ2o7q4djMJDyIm6gx1rNpYZwI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkfk0gPh3ZyEGT7AWq4mZeR9dbp9knkDz8k2grIAk7rWAfgyet
	chkpsOGjRAv2R65EAtz9mM/XT2vntJxTrjkXjnkv0NP1x/71CMcadxkx9yYlRTJoWYzOEZgskE0
	kLqSP6ct7QablVg==
X-Received: from qkbbq31.prod.google.com ([2002:a05:620a:469f:b0:8c5:368b:f652])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:370b:b0:8b2:e402:20b4 with SMTP id af79cd13be357-8c6a68d3754mr2709280985a.10.1769032649650;
 Wed, 21 Jan 2026 13:57:29 -0800 (PST)
Date: Wed, 21 Jan 2026 21:57:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121215728.560645-1-edumazet@google.com>
Subject: [PATCH net-next] ipvlan: remove ipvlan_ht_addr_lookup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252068-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: E84195E746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ipvlan_ht_addr_lookup() is called four times and not inlined.

Split it to ipvlan_ht_addr_lookup6() and ipvlan_ht_addr_lookup4()
and rework ipvlan_addr_lookup() to call these helpers once,
so that they are (auto)inlined.

After this change, ipvlan_addr_lookup() is faster, and we save
350 bytes of text on x86_64.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 123/-473 (-350)
Function                                     old     new   delta
ipvlan_addr_lookup                           467     590    +123
__pfx_ipvlan_ht_addr_lookup                   16       -     -16
ipvlan_ht_addr_lookup                        457       -    -457
Total: Before=22571833, After=22571483, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 53 +++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2efa3ba148aa7efed999dc3c06ccbb787eca92e5..dea8b9fead5d32fcccc978bb304a77bb305d2c9e 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -48,11 +48,9 @@ static u8 ipvlan_get_v6_hash(const void *iaddr)
 }
 #endif
 
-static u8 ipvlan_get_v4_hash(const void *iaddr)
+static u8 ipvlan_get_v4_hash(__be32 addr)
 {
-	const struct in_addr *ip4_addr = iaddr;
-
-	return jhash_1word((__force u32)ip4_addr->s_addr, ipvlan_jhash_secret) &
+	return jhash_1word((__force u32)addr, ipvlan_jhash_secret) &
 			   IPVLAN_HASH_MASK;
 }
 
@@ -73,16 +71,28 @@ static bool addr_equal(bool is_v6, struct ipvl_addr *addr, const void *iaddr)
 	return false;
 }
 
-static struct ipvl_addr *ipvlan_ht_addr_lookup(const struct ipvl_port *port,
-					       const void *iaddr, bool is_v6)
+static struct ipvl_addr *ipvlan_ht_addr_lookup6(const struct ipvl_port *port,
+						const void *iaddr)
 {
 	struct ipvl_addr *addr;
 	u8 hash;
 
-	hash = is_v6 ? ipvlan_get_v6_hash(iaddr) :
-	       ipvlan_get_v4_hash(iaddr);
+	hash = ipvlan_get_v6_hash(iaddr);
 	hlist_for_each_entry_rcu(addr, &port->hlhead[hash], hlnode)
-		if (addr_equal(is_v6, addr, iaddr))
+		if (addr_equal(true, addr, iaddr))
+			return addr;
+	return NULL;
+}
+
+static struct ipvl_addr *ipvlan_ht_addr_lookup4(const struct ipvl_port *port,
+						__be32 addr4)
+{
+	struct ipvl_addr *addr;
+	u8 hash;
+
+	hash = ipvlan_get_v4_hash(addr4);
+	hlist_for_each_entry_rcu(addr, &port->hlhead[hash], hlnode)
+		if (addr->atype == IPVL_IPV4 && addr->ip4addr.s_addr == addr4)
 			return addr;
 	return NULL;
 }
@@ -94,7 +104,7 @@ void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr)
 
 	hash = (addr->atype == IPVL_IPV6) ?
 	       ipvlan_get_v6_hash(&addr->ip6addr) :
-	       ipvlan_get_v4_hash(&addr->ip4addr);
+	       ipvlan_get_v4_hash(addr->ip4addr.s_addr);
 	if (hlist_unhashed(&addr->hlnode))
 		hlist_add_head_rcu(&addr->hlnode, &port->hlhead[hash]);
 }
@@ -357,21 +367,24 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 				     int addr_type, bool use_dest)
 {
 	struct ipvl_addr *addr = NULL;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct in6_addr *i6addr;
+#endif
+	__be32 addr4;
 
 	switch (addr_type) {
 #if IS_ENABLED(CONFIG_IPV6)
 	case IPVL_IPV6: {
 		struct ipv6hdr *ip6h;
-		struct in6_addr *i6addr;
 
 		ip6h = (struct ipv6hdr *)lyr3h;
 		i6addr = use_dest ? &ip6h->daddr : &ip6h->saddr;
-		addr = ipvlan_ht_addr_lookup(port, i6addr, true);
+lookup6:
+		addr = ipvlan_ht_addr_lookup6(port, i6addr);
 		break;
 	}
 	case IPVL_ICMPV6: {
 		struct nd_msg *ndmh;
-		struct in6_addr *i6addr;
 
 		/* Make sure that the NeighborSolicitation ICMPv6 packets
 		 * are handled to avoid DAD issue.
@@ -379,24 +392,23 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 		ndmh = (struct nd_msg *)lyr3h;
 		if (ndmh->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION) {
 			i6addr = &ndmh->target;
-			addr = ipvlan_ht_addr_lookup(port, i6addr, true);
+			goto lookup6;
 		}
 		break;
 	}
 #endif
 	case IPVL_IPV4: {
 		struct iphdr *ip4h;
-		__be32 *i4addr;
 
 		ip4h = (struct iphdr *)lyr3h;
-		i4addr = use_dest ? &ip4h->daddr : &ip4h->saddr;
-		addr = ipvlan_ht_addr_lookup(port, i4addr, false);
+		addr4 = use_dest ? ip4h->daddr : ip4h->saddr;
+lookup4:
+		addr = ipvlan_ht_addr_lookup4(port, addr4);
 		break;
 	}
 	case IPVL_ARP: {
 		struct arphdr *arph;
 		unsigned char *arp_ptr;
-		__be32 dip;
 
 		arph = (struct arphdr *)lyr3h;
 		arp_ptr = (unsigned char *)(arph + 1);
@@ -405,9 +417,8 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
 		else
 			arp_ptr += port->dev->addr_len;
 
-		memcpy(&dip, arp_ptr, 4);
-		addr = ipvlan_ht_addr_lookup(port, &dip, false);
-		break;
+		addr4 = get_unaligned((__be32 *)arp_ptr);
+		goto lookup4;
 	}
 	}
 
-- 
2.52.0.457.g6b5491de43-goog


