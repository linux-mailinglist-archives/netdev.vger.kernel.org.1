Return-Path: <netdev+bounces-268623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKAqNbVhuWlsCwIAu9opvQ
	(envelope-from <netdev+bounces-268623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:14:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7472AB94C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5AC32564D8
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279703E5574;
	Tue, 17 Mar 2026 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VKxcKBM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M8GqGUcp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0VKxcKBM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M8GqGUcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A683E2758
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756256; cv=none; b=oG0nac4+pPfz9hba1TbEcF4sHdcrf7xv68s07MelIF1wk5xdiXuhsStbF4fVW749RxMzu+QN5qFAqACKbsazKrSVaz5Sef7C1qKmfuOEfMjtrMFfCKjS7m9M82goXbbU6sP8qrY4Cclg2bV3vy0ejJQZW3oT/dtby1nUe5tuoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756256; c=relaxed/simple;
	bh=E0p5vVmgfjwpduifXRhlp3roW9o7GCKNw4kBznSnDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti0g7xKSzx34H/NeSBjkwoGKQ9KqPsFMtsho8TyRuInNzjWZ5LoH8L9RqhW2UzHgAg6u4X3uJ20S5Lm/Pt/GaYSXmqj2WS4hAmx7xBvhDnwx49UZGbti9m0FpqJOO+7s+PMZMJbVgYjfDEzZhbXthzi182unhHLkiqauBidm5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VKxcKBM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M8GqGUcp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0VKxcKBM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M8GqGUcp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01E1D4D349;
	Tue, 17 Mar 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QScnysvTBGhk4w21MegLreNZMPUmh+3WZyuiYWLccJQ=;
	b=0VKxcKBMU9cgpVEe6DoIwByNxkoDpB5RCk+TWxW4YsWc8n8lzW8qulcmWl9+YrsYnCn/w6
	iFzimw+N9joB7NV/0iKA1ISxc/ZUKkLiPVU7shPW7ChsDhPSZDk4z1BJBRXq/jd5CmAX2x
	DGWYpMxDRJRn+SHJhYRs9NHXxcWbUMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QScnysvTBGhk4w21MegLreNZMPUmh+3WZyuiYWLccJQ=;
	b=M8GqGUcpWltO2eKjftsLRkcFqC4hxFUQoXTlhngkeMaImeYLRZ8xsUE4SPRvnGnUztp9/v
	EQBG6sC5fSwrcMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773756251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QScnysvTBGhk4w21MegLreNZMPUmh+3WZyuiYWLccJQ=;
	b=0VKxcKBMU9cgpVEe6DoIwByNxkoDpB5RCk+TWxW4YsWc8n8lzW8qulcmWl9+YrsYnCn/w6
	iFzimw+N9joB7NV/0iKA1ISxc/ZUKkLiPVU7shPW7ChsDhPSZDk4z1BJBRXq/jd5CmAX2x
	DGWYpMxDRJRn+SHJhYRs9NHXxcWbUMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773756251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QScnysvTBGhk4w21MegLreNZMPUmh+3WZyuiYWLccJQ=;
	b=M8GqGUcpWltO2eKjftsLRkcFqC4hxFUQoXTlhngkeMaImeYLRZ8xsUE4SPRvnGnUztp9/v
	EQBG6sC5fSwrcMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B04D4273B;
	Tue, 17 Mar 2026 14:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAL7ElpfuWmpYwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 17 Mar 2026 14:04:10 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10 net-next v3] ipv6: remove ipv6_stub infrastructure completely
Date: Tue, 17 Mar 2026 15:01:05 +0100
Message-ID: <20260317140141.5723-10-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317140141.5723-1-fmancera@suse.de>
References: <20260317140141.5723-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268623-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 3A7472AB94C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only and there are no more users of ipv6_stub, the
ipv6_stub is now entirely obsolte.

Remove all the code related to the definition, initialization and usage.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 include/net/ip6_fib.h     |  1 -
 include/net/ipv6_stubs.h  | 80 ----------------------------------
 include/net/ndisc.h       | 27 ++----------
 include/net/udp_tunnel.h  |  1 -
 net/ipv6/addrconf.c       | 10 ++---
 net/ipv6/addrconf_core.c  | 91 ---------------------------------------
 net/ipv6/af_inet6.c       | 40 -----------------
 net/ipv6/ip6_fib.c        |  8 ----
 net/ipv6/ip6_output.c     |  4 +-
 net/ipv6/ip6_udp_tunnel.c |  3 +-
 net/ipv6/ndisc.c          | 34 +++++++--------
 net/ipv6/route.c          |  6 +--
 12 files changed, 31 insertions(+), 274 deletions(-)
 delete mode 100644 include/net/ipv6_stubs.h

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 1705cd6aab18..b5e1b13bbd62 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -602,7 +602,6 @@ static inline void fib6_update_sernum(struct net *net, struct fib6_info *rt)
 }
 #endif
 void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt);
-void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i);
 
 void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val);
 static inline bool fib6_metric_locked(struct fib6_info *f6i, int metric)
diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
deleted file mode 100644
index dc708d9eca7a..000000000000
--- a/include/net/ipv6_stubs.h
+++ /dev/null
@@ -1,80 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _IPV6_STUBS_H
-#define _IPV6_STUBS_H
-
-#include <linux/in6.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <net/dst.h>
-#include <net/flow.h>
-#include <net/neighbour.h>
-#include <net/sock.h>
-#include <net/ipv6.h>
-
-/* structs from net/ip6_fib.h */
-struct fib6_info;
-struct fib6_nh;
-struct fib6_config;
-struct fib6_result;
-
-/* This is ugly, ideally these symbols should be built
- * into the core kernel.
- */
-struct ipv6_stub {
-	int (*ipv6_sock_mc_join)(struct sock *sk, int ifindex,
-				 const struct in6_addr *addr);
-	int (*ipv6_sock_mc_drop)(struct sock *sk, int ifindex,
-				 const struct in6_addr *addr);
-	struct dst_entry *(*ipv6_dst_lookup_flow)(struct net *net,
-						  const struct sock *sk,
-						  struct flowi6 *fl6,
-						  const struct in6_addr *final_dst);
-	int (*ipv6_route_input)(struct sk_buff *skb);
-
-	struct fib6_table *(*fib6_get_table)(struct net *net, u32 id);
-	int (*fib6_lookup)(struct net *net, int oif, struct flowi6 *fl6,
-			   struct fib6_result *res, int flags);
-	int (*fib6_table_lookup)(struct net *net, struct fib6_table *table,
-				 int oif, struct flowi6 *fl6,
-				 struct fib6_result *res, int flags);
-	void (*fib6_select_path)(const struct net *net, struct fib6_result *res,
-				 struct flowi6 *fl6, int oif, bool oif_match,
-				 const struct sk_buff *skb, int strict);
-	u32 (*ip6_mtu_from_fib6)(const struct fib6_result *res,
-				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr);
-
-	int (*fib6_nh_init)(struct net *net, struct fib6_nh *fib6_nh,
-			    struct fib6_config *cfg, gfp_t gfp_flags,
-			    struct netlink_ext_ack *extack);
-	void (*fib6_nh_release)(struct fib6_nh *fib6_nh);
-	void (*fib6_nh_release_dsts)(struct fib6_nh *fib6_nh);
-	void (*fib6_update_sernum)(struct net *net, struct fib6_info *rt);
-	int (*ip6_del_rt)(struct net *net, struct fib6_info *rt, bool skip_notify);
-	void (*fib6_rt_update)(struct net *net, struct fib6_info *rt,
-			       struct nl_info *info);
-
-	void (*udpv6_encap_enable)(void);
-	void (*ndisc_send_na)(struct net_device *dev, const struct in6_addr *daddr,
-			      const struct in6_addr *solicited_addr,
-			      bool router, bool solicited, bool override, bool inc_opt);
-#if IS_ENABLED(CONFIG_XFRM)
-	void (*xfrm6_local_rxpmtu)(struct sk_buff *skb, u32 mtu);
-	int (*xfrm6_udp_encap_rcv)(struct sock *sk, struct sk_buff *skb);
-	struct sk_buff *(*xfrm6_gro_udp_encap_rcv)(struct sock *sk,
-						   struct list_head *head,
-						   struct sk_buff *skb);
-	int (*xfrm6_rcv_encap)(struct sk_buff *skb, int nexthdr, __be32 spi,
-			       int encap_type);
-#endif
-	struct neigh_table *nd_tbl;
-
-	int (*ipv6_fragment)(struct net *net, struct sock *sk, struct sk_buff *skb,
-			     int (*output)(struct net *, struct sock *, struct sk_buff *));
-	struct net_device *(*ipv6_dev_find)(struct net *net, const struct in6_addr *addr,
-					    struct net_device *dev);
-	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
-			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
-};
-extern const struct ipv6_stub *ipv6_stub __read_mostly;
-#endif
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 6152401f29f1..5c64562cc69f 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -2,8 +2,6 @@
 #ifndef _NDISC_H
 #define _NDISC_H
 
-#include <net/ipv6_stubs.h>
-
 /*
  *	ICMP codes for neighbour discovery messages
  */
@@ -366,14 +364,6 @@ static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev
 				     ndisc_hashfn, pkey, dev);
 }
 
-static inline
-struct neighbour *__ipv6_neigh_lookup_noref_stub(struct net_device *dev,
-						 const void *pkey)
-{
-	return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128,
-				     ndisc_hashfn, pkey, dev);
-}
-
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
 {
 	struct neighbour *n;
@@ -398,27 +388,15 @@ static inline void __ipv6_confirm_neigh(struct net_device *dev,
 	rcu_read_unlock();
 }
 
-static inline void __ipv6_confirm_neigh_stub(struct net_device *dev,
-					     const void *pkey)
-{
-	struct neighbour *n;
-
-	rcu_read_lock();
-	n = __ipv6_neigh_lookup_noref_stub(dev, pkey);
-	neigh_confirm(n);
-	rcu_read_unlock();
-}
-
-/* uses ipv6_stub and is meant for use outside of IPv6 core */
 static inline struct neighbour *ip_neigh_gw6(struct net_device *dev,
 					     const void *addr)
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct neighbour *neigh;
 
-	neigh = __ipv6_neigh_lookup_noref_stub(dev, addr);
+	neigh = __ipv6_neigh_lookup_noref(dev, addr);
 	if (unlikely(!neigh))
-		neigh = __neigh_create(ipv6_stub->nd_tbl, addr, dev, false);
+		neigh = __neigh_create(ipv6_get_nd_tbl(), addr, dev, false);
 
 	return neigh;
 #else
@@ -445,6 +423,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 void ndisc_send_rs(struct net_device *dev,
 		   const struct in6_addr *saddr, const struct in6_addr *daddr);
+
 void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		   const struct in6_addr *solicited_addr,
 		   bool router, bool solicited, bool override, bool inc_opt);
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 277f1ce1c02d..095f49f741de 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -7,7 +7,6 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6.h>
-#include <net/ipv6_stubs.h>
 #endif
 
 #define UDP_TUNNEL_PARTIAL_FEATURES	NETIF_F_GSO_ENCAP_ALL
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e55f139e05d..e022c375f418 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -399,7 +399,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 
 	ndev->cnf.mtu6 = dev->mtu;
 	ndev->ra_mtu = 0;
-	ndev->nd_parms = neigh_parms_alloc(dev, &nd_tbl);
+	ndev->nd_parms = neigh_parms_alloc(dev, ipv6_get_nd_tbl());
 	if (!ndev->nd_parms) {
 		kfree(ndev);
 		return ERR_PTR(err);
@@ -412,7 +412,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	if (snmp6_alloc_dev(ndev) < 0) {
 		netdev_dbg(dev, "%s: cannot allocate memory for statistics\n",
 			   __func__);
-		neigh_parms_release(&nd_tbl, ndev->nd_parms);
+		neigh_parms_release(ipv6_get_nd_tbl(), ndev->nd_parms);
 		netdev_put(dev, &ndev->dev_tracker);
 		kfree(ndev);
 		return ERR_PTR(err);
@@ -480,7 +480,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	return ndev;
 
 err_release:
-	neigh_parms_release(&nd_tbl, ndev->nd_parms);
+	neigh_parms_release(ipv6_get_nd_tbl(), ndev->nd_parms);
 	ndev->dead = 1;
 	in6_dev_finish_destroy(ndev);
 	return ERR_PTR(err);
@@ -4008,8 +4008,8 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	/* Last: Shot the device (if unregistered) */
 	if (unregister) {
 		addrconf_sysctl_unregister(idev);
-		neigh_parms_release(&nd_tbl, idev->nd_parms);
-		neigh_ifdown(&nd_tbl, dev);
+		neigh_parms_release(ipv6_get_nd_tbl(), idev->nd_parms);
+		neigh_ifdown(ipv6_get_nd_tbl(), dev);
 		in6_dev_put(idev);
 	}
 	return 0;
diff --git a/net/ipv6/addrconf_core.c b/net/ipv6/addrconf_core.c
index c008d21925d7..fa27a90ab3cd 100644
--- a/net/ipv6/addrconf_core.c
+++ b/net/ipv6/addrconf_core.c
@@ -6,7 +6,6 @@
 
 #include <linux/export.h>
 #include <net/ipv6.h>
-#include <net/ipv6_stubs.h>
 #include <net/addrconf.h>
 #include <net/ip.h>
 
@@ -129,96 +128,6 @@ int inet6addr_validator_notifier_call_chain(unsigned long val, void *v)
 }
 EXPORT_SYMBOL(inet6addr_validator_notifier_call_chain);
 
-static struct dst_entry *eafnosupport_ipv6_dst_lookup_flow(struct net *net,
-							   const struct sock *sk,
-							   struct flowi6 *fl6,
-							   const struct in6_addr *final_dst)
-{
-	return ERR_PTR(-EAFNOSUPPORT);
-}
-
-static int eafnosupport_ipv6_route_input(struct sk_buff *skb)
-{
-	return -EAFNOSUPPORT;
-}
-
-static struct fib6_table *eafnosupport_fib6_get_table(struct net *net, u32 id)
-{
-	return NULL;
-}
-
-static int
-eafnosupport_fib6_table_lookup(struct net *net, struct fib6_table *table,
-			       int oif, struct flowi6 *fl6,
-			       struct fib6_result *res, int flags)
-{
-	return -EAFNOSUPPORT;
-}
-
-static int
-eafnosupport_fib6_lookup(struct net *net, int oif, struct flowi6 *fl6,
-			 struct fib6_result *res, int flags)
-{
-	return -EAFNOSUPPORT;
-}
-
-static void
-eafnosupport_fib6_select_path(const struct net *net, struct fib6_result *res,
-			      struct flowi6 *fl6, int oif, bool have_oif_match,
-			      const struct sk_buff *skb, int strict)
-{
-}
-
-static u32
-eafnosupport_ip6_mtu_from_fib6(const struct fib6_result *res,
-			       const struct in6_addr *daddr,
-			       const struct in6_addr *saddr)
-{
-	return 0;
-}
-
-static int eafnosupport_fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
-				     struct fib6_config *cfg, gfp_t gfp_flags,
-				     struct netlink_ext_ack *extack)
-{
-	NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");
-	return -EAFNOSUPPORT;
-}
-
-static int eafnosupport_ip6_del_rt(struct net *net, struct fib6_info *rt,
-				   bool skip_notify)
-{
-	return -EAFNOSUPPORT;
-}
-
-static int eafnosupport_ipv6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
-				      int (*output)(struct net *, struct sock *, struct sk_buff *))
-{
-	kfree_skb(skb);
-	return -EAFNOSUPPORT;
-}
-
-static struct net_device *eafnosupport_ipv6_dev_find(struct net *net, const struct in6_addr *addr,
-						     struct net_device *dev)
-{
-	return ERR_PTR(-EAFNOSUPPORT);
-}
-
-const struct ipv6_stub *ipv6_stub __read_mostly = &(struct ipv6_stub) {
-	.ipv6_dst_lookup_flow = eafnosupport_ipv6_dst_lookup_flow,
-	.ipv6_route_input  = eafnosupport_ipv6_route_input,
-	.fib6_get_table    = eafnosupport_fib6_get_table,
-	.fib6_table_lookup = eafnosupport_fib6_table_lookup,
-	.fib6_lookup       = eafnosupport_fib6_lookup,
-	.fib6_select_path  = eafnosupport_fib6_select_path,
-	.ip6_mtu_from_fib6 = eafnosupport_ip6_mtu_from_fib6,
-	.fib6_nh_init	   = eafnosupport_fib6_nh_init,
-	.ip6_del_rt	   = eafnosupport_ip6_del_rt,
-	.ipv6_fragment	   = eafnosupport_ipv6_fragment,
-	.ipv6_dev_find     = eafnosupport_ipv6_dev_find,
-};
-EXPORT_SYMBOL_GPL(ipv6_stub);
-
 /* IPv6 Wildcard Address and Loopback Address defined by RFC2553 */
 const struct in6_addr in6addr_loopback __aligned(BITS_PER_LONG/8)
 	= IN6ADDR_LOOPBACK_INIT;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 07ae6ea7743a..33abd8d8cd7d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -51,7 +51,6 @@
 #include <net/transp_v6.h>
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
-#include <net/ipv6_stubs.h>
 #include <net/ndisc.h>
 #ifdef CONFIG_IPV6_TUNNEL
 #include <net/ip6_tunnel.h>
@@ -996,42 +995,6 @@ static struct pernet_operations inet6_net_ops = {
 	.exit = inet6_net_exit,
 };
 
-static int ipv6_route_input(struct sk_buff *skb)
-{
-	ip6_route_input(skb);
-	return skb_dst(skb)->error;
-}
-
-static const struct ipv6_stub ipv6_stub_impl = {
-	.ipv6_sock_mc_join = ipv6_sock_mc_join,
-	.ipv6_sock_mc_drop = ipv6_sock_mc_drop,
-	.ipv6_dst_lookup_flow = ip6_dst_lookup_flow,
-	.ipv6_route_input  = ipv6_route_input,
-	.fib6_get_table	   = fib6_get_table,
-	.fib6_table_lookup = fib6_table_lookup,
-	.fib6_lookup       = fib6_lookup,
-	.fib6_select_path  = fib6_select_path,
-	.ip6_mtu_from_fib6 = ip6_mtu_from_fib6,
-	.fib6_nh_init	   = fib6_nh_init,
-	.fib6_nh_release   = fib6_nh_release,
-	.fib6_nh_release_dsts = fib6_nh_release_dsts,
-	.fib6_update_sernum = fib6_update_sernum_stub,
-	.fib6_rt_update	   = fib6_rt_update,
-	.ip6_del_rt	   = ip6_del_rt,
-	.udpv6_encap_enable = udpv6_encap_enable,
-	.ndisc_send_na = ndisc_send_na,
-#if IS_ENABLED(CONFIG_XFRM)
-	.xfrm6_local_rxpmtu = xfrm6_local_rxpmtu,
-	.xfrm6_udp_encap_rcv = xfrm6_udp_encap_rcv,
-	.xfrm6_gro_udp_encap_rcv = xfrm6_gro_udp_encap_rcv,
-	.xfrm6_rcv_encap = xfrm6_rcv_encap,
-#endif
-	.nd_tbl	= &nd_tbl,
-	.ipv6_fragment = ip6_fragment,
-	.ipv6_dev_find = ipv6_dev_find,
-	.ip6_xmit = ip6_xmit,
-};
-
 static int __init inet6_init(void)
 {
 	struct list_head *r;
@@ -1188,9 +1151,6 @@ static int __init inet6_init(void)
 		goto sysctl_fail;
 #endif
 
-	/* ensure that ipv6 stubs are visible only after ipv6 is ready */
-	wmb();
-	ipv6_stub = &ipv6_stub_impl;
 out:
 	return err;
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 0fc6ef4a48b1..8a6aabb58c5f 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1408,14 +1408,6 @@ void fib6_update_sernum_upto_root(struct net *net, struct fib6_info *rt)
 	__fib6_update_sernum_upto_root(rt, fib6_new_sernum(net));
 }
 
-/* allow ipv4 to update sernum via ipv6_stub */
-void fib6_update_sernum_stub(struct net *net, struct fib6_info *f6i)
-{
-	spin_lock_bh(&f6i->fib6_table->tb6_lock);
-	fib6_update_sernum_upto_root(net, f6i);
-	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
-}
-
 /*
  *	Add routing information to the routing tree.
  *	<destination addr>/<source addr>
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 315808dc2a07..433b8ab395bd 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -125,7 +125,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 	if (IS_ERR_OR_NULL(neigh)) {
 		if (unlikely(!neigh))
-			neigh = __neigh_create(&nd_tbl, nexthop, dev, false);
+			neigh = __neigh_create(ipv6_get_nd_tbl(), nexthop, dev, false);
 		if (IS_ERR(neigh)) {
 			IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTNOROUTES);
 			kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
@@ -559,7 +559,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	/* XXX: idev->cnf.proxy_ndp? */
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
+	    pneigh_lookup(ipv6_get_nd_tbl(), net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
 			/* It's tempting to decrease the hop limit
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e0210744..405ef1cb8864 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -162,8 +162,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 	fl6.fl6_dport = dport;
 	fl6.flowlabel = ip6_make_flowinfo(dsfield, key->label);
 
-	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sock->sk, &fl6,
-					      NULL);
+	dst = ip6_dst_lookup_flow(net, sock->sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f76fb8a85452..918443c75288 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -120,7 +120,7 @@ struct neigh_table nd_tbl = {
 	.allow_add  =   ndisc_allow_add,
 	.id =		"ndisc_cache",
 	.parms = {
-		.tbl			= &nd_tbl,
+		.tbl			= ipv6_get_nd_tbl(),
 		.reachable_time		= ND_REACHABLE_TIME,
 		.data = {
 			[NEIGH_VAR_MCAST_PROBES] = 3,
@@ -769,7 +769,7 @@ static int pndisc_is_router(const void *pkey,
 	struct pneigh_entry *n;
 	int ret = -1;
 
-	n = pneigh_lookup(&nd_tbl, dev_net(dev), pkey, dev);
+	n = pneigh_lookup(ipv6_get_nd_tbl(), dev_net(dev), pkey, dev);
 	if (n)
 		ret = !!(READ_ONCE(n->flags) & NTF_ROUTER);
 
@@ -917,7 +917,7 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 				 */
 				struct sk_buff *n = skb_clone(skb, GFP_ATOMIC);
 				if (n)
-					pneigh_enqueue(&nd_tbl, idev->nd_parms, n);
+					pneigh_enqueue(ipv6_get_nd_tbl(), idev->nd_parms, n);
 				goto out;
 			}
 		} else {
@@ -936,15 +936,15 @@ static enum skb_drop_reason ndisc_recv_ns(struct sk_buff *skb)
 	}
 
 	if (inc)
-		NEIGH_CACHE_STAT_INC(&nd_tbl, rcv_probes_mcast);
+		NEIGH_CACHE_STAT_INC(ipv6_get_nd_tbl(), rcv_probes_mcast);
 	else
-		NEIGH_CACHE_STAT_INC(&nd_tbl, rcv_probes_ucast);
+		NEIGH_CACHE_STAT_INC(ipv6_get_nd_tbl(), rcv_probes_ucast);
 
 	/*
 	 *	update / create cache entry
 	 *	for the source address
 	 */
-	neigh = __neigh_lookup(&nd_tbl, saddr, dev,
+	neigh = __neigh_lookup(ipv6_get_nd_tbl(), saddr, dev,
 			       !inc || lladdr || !dev->addr_len);
 	if (neigh)
 		ndisc_update(dev, neigh, lladdr, NUD_STALE,
@@ -1059,7 +1059,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		return reason;
 	}
 
-	neigh = neigh_lookup(&nd_tbl, &msg->target, dev);
+	neigh = neigh_lookup(ipv6_get_nd_tbl(), &msg->target, dev);
 
 	/* RFC 9131 updates original Neighbour Discovery RFC 4861.
 	 * NAs with Target LL Address option without a corresponding
@@ -1079,7 +1079,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	new_state = msg->icmph.icmp6_solicited ? NUD_REACHABLE : NUD_STALE;
 	if (!neigh && lladdr && idev && READ_ONCE(idev->cnf.forwarding)) {
 		if (accept_untracked_na(dev, saddr)) {
-			neigh = neigh_create(&nd_tbl, &msg->target, dev);
+			neigh = neigh_create(ipv6_get_nd_tbl(), &msg->target, dev);
 			new_state = NUD_STALE;
 		}
 	}
@@ -1099,7 +1099,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
 		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
+		    pneigh_lookup(ipv6_get_nd_tbl(), net, &msg->target, dev)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
@@ -1167,7 +1167,7 @@ static enum skb_drop_reason ndisc_recv_rs(struct sk_buff *skb)
 			goto out;
 	}
 
-	neigh = __neigh_lookup(&nd_tbl, saddr, skb->dev, 1);
+	neigh = __neigh_lookup(ipv6_get_nd_tbl(), saddr, skb->dev, 1);
 	if (neigh) {
 		ndisc_update(skb->dev, neigh, lladdr, NUD_STALE,
 			     NEIGH_UPDATE_F_WEAK_OVERRIDE|
@@ -1464,7 +1464,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	 */
 
 	if (!neigh)
-		neigh = __neigh_lookup(&nd_tbl, &ipv6_hdr(skb)->saddr,
+		neigh = __neigh_lookup(ipv6_get_nd_tbl(), &ipv6_hdr(skb)->saddr,
 				       skb->dev, 1);
 	if (neigh) {
 		u8 *lladdr = NULL;
@@ -1860,7 +1860,7 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 
 	switch (event) {
 	case NETDEV_CHANGEADDR:
-		neigh_changeaddr(&nd_tbl, dev);
+		neigh_changeaddr(ipv6_get_nd_tbl(), dev);
 		fib6_run_gc(0, net, false);
 		fallthrough;
 	case NETDEV_UP:
@@ -1884,12 +1884,12 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 
 		change_info = ptr;
 		if (change_info->flags_changed & IFF_NOARP)
-			neigh_changeaddr(&nd_tbl, dev);
+			neigh_changeaddr(ipv6_get_nd_tbl(), dev);
 		if (evict_nocarrier && !netif_carrier_ok(dev))
-			neigh_carrier_down(&nd_tbl, dev);
+			neigh_carrier_down(ipv6_get_nd_tbl(), dev);
 		break;
 	case NETDEV_DOWN:
-		neigh_ifdown(&nd_tbl, dev);
+		neigh_ifdown(ipv6_get_nd_tbl(), dev);
 		fib6_run_gc(0, net, false);
 		break;
 	case NETDEV_NOTIFY_PEERS:
@@ -2006,7 +2006,7 @@ int __init ndisc_init(void)
 	/*
 	 * Initialize the neighbour table
 	 */
-	neigh_table_init(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_init(NEIGH_ND_TABLE, ipv6_get_nd_tbl());
 
 #ifdef CONFIG_SYSCTL
 	err = neigh_sysctl_register(NULL, &nd_tbl.parms,
@@ -2039,6 +2039,6 @@ void ndisc_cleanup(void)
 #ifdef CONFIG_SYSCTL
 	neigh_sysctl_unregister(&nd_tbl.parms);
 #endif
-	neigh_table_clear(NEIGH_ND_TABLE, &nd_tbl);
+	neigh_table_clear(NEIGH_ND_TABLE, ipv6_get_nd_tbl());
 	unregister_pernet_subsys(&ndisc_net_ops);
 }
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b66a2f791e3f..7809cb9db7a1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -217,7 +217,7 @@ struct neighbour *ip6_neigh_lookup(const struct in6_addr *gw,
 	if (n)
 		return n;
 
-	n = neigh_create(&nd_tbl, daddr, dev);
+	n = neigh_create(ipv6_get_nd_tbl(), daddr, dev);
 	return IS_ERR(n) ? NULL : n;
 }
 
@@ -4287,7 +4287,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 	 */
 	dst_confirm_neigh(&rt->dst, &ipv6_hdr(skb)->saddr);
 
-	neigh = __neigh_lookup(&nd_tbl, &msg->target, skb->dev, 1);
+	neigh = __neigh_lookup(ipv6_get_nd_tbl(), &msg->target, skb->dev, 1);
 	if (!neigh)
 		return;
 
@@ -5017,7 +5017,7 @@ void rt6_disable_ip(struct net_device *dev, unsigned long event)
 {
 	rt6_sync_down_dev(dev, event);
 	rt6_uncached_list_flush_dev(dev);
-	neigh_ifdown(&nd_tbl, dev);
+	neigh_ifdown(ipv6_get_nd_tbl(), dev);
 }
 
 struct rt6_mtu_change_arg {
-- 
2.53.0


