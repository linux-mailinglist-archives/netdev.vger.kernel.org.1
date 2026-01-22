Return-Path: <netdev+bounces-252461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJFPFUNdcmn5iwAAu9opvQ
	(envelope-from <netdev+bounces-252461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:24:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162E6B30D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B45223018B1F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705831619B;
	Thu, 22 Jan 2026 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXfDmN/e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6437FF72
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100673; cv=none; b=Kds1QTeKVRJwlpvx0fpJmSeo1D47lHvfbH0zhr+xDzc7/B6w08cbNE8MVLOrokK/Z9aAKGw/MdzNtTh+I4Qs7UzP9o285qQvSL6P1epxjEGgjdDaoEOWYSXG20wbyQNUsZky+T+sqIkGSm0pZheI601c02u8WFOz/jWCBzCUYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100673; c=relaxed/simple;
	bh=yp//qd0PzB7Snypykjs0dXGxE2N8JW1snIV61oqC6ns=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cv/wj1MpuHCDsXke0tZd+EWbCZBmaNBd/IIqvXI0JNtnuM0f8qDFcSxbbwfLlm/ZoQsbnBc7tb33wA5MerKRWw8yeNKOlSaPv80HE2tXKJC39BcY1Lhm08z2i668Y06ohVCHoQGf8NKpO2IKPtn3yThzRfz/FnUo1l7yL6zd01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXfDmN/e; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8905883e793so28242406d6.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100655; x=1769705455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9pglonBNB+Nab8p8hrgiOIFMlt0ittHi/Ll8Gc4NmAQ=;
        b=hXfDmN/e6Pf9AQXAQe5JgTnUV8ZF2PNbcY3OxeGBggL4O3JdNEiM2qrsHWR1utfqwj
         2Ssl7KiVy9sxpdC0jTP6rxbJPXnUaEvnRvoVW7GShOQAEzCqx6P+XmB0aG25cESUQqX+
         ZAawN4K2gZC82sq3/uQeFkkl90TaM/aDi672nLUWyMM4+U6YkiCPKB8qD7AWCGzjXcjH
         jni/P6GYWtD7M1Evjlu/Q+R0qH7lSy9HoprMuDRJX+shesAVT+CzhmTh9pTbOnAfQhiW
         LoMvCnL5TotgXg0nrXXbj4+yV9ys1BPD9G4Wea9+Yhtt+9r6V94Dixp6iOULZ27xmMeE
         bXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100655; x=1769705455;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pglonBNB+Nab8p8hrgiOIFMlt0ittHi/Ll8Gc4NmAQ=;
        b=eYYmBzP+7INClhVRCU0vleiCdpfol+aq2pvX+2O7qQIXv4RJIwgSgl6vycrDS21+z9
         z72BV6A46OTcLqWRCjrBCMiqseaI1CDr/ChopQZyaGSO8mi3psaZWtGusTMer+0EOgcr
         m1NDNq1cnRWJ5ed4QPlSVU8M+0YKcvsR1n1V4xoLD7cBkmU8NTy57Whi23zF7bE94O/M
         mEAOSRiOGjb8PlTrZAdQCb1T0NAJGcFCBspBkMeks4XN2YaiI6C29yYoOhpYLTjhX8th
         91uE6Y00Ml+KMFN3cpB6BH+CFh0/FFXSPnyeSsXW9AGEijjnQYYZUlfM3gMPQgLt3aB2
         Qh6g==
X-Forwarded-Encrypted: i=1; AJvYcCUxOsv7SQu/Bb2LCaxo1Mgfa9Y1ijux+UbtydOnyPnni2WbFdO3Z3OAMSjoJP1lyJTh65eptwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQUWawXGhfHKQX9marYP1NpJysmTe8QWmTYClNguMASNkNT8e
	uPvkKlBYAwJFqV81MuhGuiV/ZtHu5Jb2oa4j1QddkJdbvN8M4AuKv5BTyRMTKpD8n1VbUC/mW/r
	XfkW7UL7fgkvp2g==
X-Received: from qvck5.prod.google.com ([2002:ad4:5be5:0:b0:890:3706:343a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5bc9:0:b0:894:74b9:6b27 with SMTP id 6a1803df08f44-89490207bf6mr1133666d6.43.1769100654668;
 Thu, 22 Jan 2026 08:50:54 -0800 (PST)
Date: Thu, 22 Jan 2026 16:50:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122165049.2366985-1-edumazet@google.com>
Subject: [PATCH v2 net-next] ipvlan: remove ipvlan_ht_addr_lookup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252461-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6162E6B30D
X-Rspamd-Action: no action

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
v2: guard ipvlan_ht_addr_lookup6() with CONFIG_IPV6 (kernel test robot)
v1: https://lore.kernel.org/netdev/20260121215728.560645-1-edumazet@google.com/
 drivers/net/ipvlan/ipvlan_core.c | 55 ++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2efa3ba148aa7efed999dc3c06ccbb787eca92e5..f1568d50f5cc8259e6166993bda8a3425e4e5937 100644
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
 
@@ -73,16 +71,30 @@ static bool addr_equal(bool is_v6, struct ipvl_addr *addr, const void *iaddr)
 	return false;
 }
 
-static struct ipvl_addr *ipvlan_ht_addr_lookup(const struct ipvl_port *port,
-					       const void *iaddr, bool is_v6)
+#if IS_ENABLED(CONFIG_IPV6)
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
+#endif
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
@@ -94,7 +106,7 @@ void ipvlan_ht_addr_add(struct ipvl_dev *ipvlan, struct ipvl_addr *addr)
 
 	hash = (addr->atype == IPVL_IPV6) ?
 	       ipvlan_get_v6_hash(&addr->ip6addr) :
-	       ipvlan_get_v4_hash(&addr->ip4addr);
+	       ipvlan_get_v4_hash(addr->ip4addr.s_addr);
 	if (hlist_unhashed(&addr->hlnode))
 		hlist_add_head_rcu(&addr->hlnode, &port->hlhead[hash]);
 }
@@ -357,21 +369,24 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
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
@@ -379,24 +394,23 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
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
@@ -405,9 +419,8 @@ struct ipvl_addr *ipvlan_addr_lookup(struct ipvl_port *port, void *lyr3h,
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


