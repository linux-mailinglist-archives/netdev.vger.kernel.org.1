Return-Path: <netdev+bounces-270032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP9DFrKZvWmR/QIAu9opvQ
	(envelope-from <netdev+bounces-270032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED12DFA84
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0614304A9F6
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998672EDD6B;
	Fri, 20 Mar 2026 19:01:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EE330B2D
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033262; cv=none; b=qTIgI0UPT+hJyQy2hOxN12idpUVBWyAq9WvTxlAXbBlKnri8u2BKOmU4Uf3RwzwMSVH6gCBTnCQCaSpteq+MielR3Rc4dn/gzKrjeM291ixsvPlipIedVLSTOmD3e/ISmeFV7wyEcduj8sGFJwLht9pjvJ/1gty2kv2CThGTPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033262; c=relaxed/simple;
	bh=tAtTOqOrUJNmIZrweeyWh3dnkrlOQ51ZXI4Csewutbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeLNCPbm3KgO6ocXGYHVGIAykTl677JqM7o+VBSpy34gy9NSlpMRX9SfwL8m1NhqPlEyjY55xNZrIAWd6BNlVh5O/LMxhnjnAsQ+XoblHvFuo7s+/aInuebhC6znSB57BuLMVJNCY1aKG1fKY18Wzlf4q/7ZGe4ybH7MCGo7CuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF2535BE12;
	Fri, 20 Mar 2026 19:00:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D56742955;
	Fri, 20 Mar 2026 19:00:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iMCwC1qZvWnyTgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 20 Mar 2026 19:00:42 +0000
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11 net-next v4] ipv4: drop ipv6_stub usage and use direct function calls
Date: Fri, 20 Mar 2026 19:56:01 +0100
Message-ID: <20260320185649.5411-10-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320185649.5411-1-fmancera@suse.de>
References: <20260320185649.5411-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270032-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,suse.com,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.734];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C5ED12DFA84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
necessary.

The IPv4 stack interacts with IPv6 mainly to support IPv4 routes with
IPv6 next-hops (RFC 8950). Convert all these cross-family calls from
ipv6_stub to direct function calls. The fallback functions introduced
previously will prevent linkage errors when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
Tested-by: Ricardo B. Marlière <rbm@suse.com>
---
 net/ipv4/fib_semantics.c | 11 +++++------
 net/ipv4/icmp.c          |  2 +-
 net/ipv4/nexthop.c       | 26 ++++++++++++++------------
 net/ipv4/route.c         |  2 +-
 net/ipv4/udp.c           |  7 ++-----
 5 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 01cb587866d8..b576dd74d678 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -586,8 +586,7 @@ static int fib_detect_death(struct fib_info *fi, int order,
 	if (likely(nhc->nhc_gw_family == AF_INET))
 		n = neigh_lookup(&arp_tbl, &nhc->nhc_gw.ipv4, nhc->nhc_dev);
 	else if (nhc->nhc_gw_family == AF_INET6)
-		n = neigh_lookup(ipv6_stub->nd_tbl, &nhc->nhc_gw.ipv6,
-				 nhc->nhc_dev);
+		n = neigh_lookup(ipv6_get_nd_tbl(), &nhc->nhc_gw.ipv6, nhc->nhc_dev);
 	else
 		n = NULL;
 
@@ -1083,7 +1082,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 	struct fib6_nh fib6_nh = {};
 	int err;
 
-	err = ipv6_stub->fib6_nh_init(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
+	err = fib6_nh_init(net, &fib6_nh, &cfg, GFP_KERNEL, extack);
 	if (!err) {
 		nh->fib_nh_dev = fib6_nh.fib_nh_dev;
 		netdev_hold(nh->fib_nh_dev, &nh->fib_nh_dev_tracker,
@@ -1091,7 +1090,7 @@ static int fib_check_nh_v6_gw(struct net *net, struct fib_nh *nh,
 		nh->fib_nh_oif = nh->fib_nh_dev->ifindex;
 		nh->fib_nh_scope = RT_SCOPE_LINK;
 
-		ipv6_stub->fib6_nh_release(&fib6_nh);
+		fib6_nh_release(&fib6_nh);
 	}
 
 	return err;
@@ -2148,8 +2147,8 @@ static bool fib_good_nh(const struct fib_nh *nh)
 			n = __ipv4_neigh_lookup_noref(nh->fib_nh_dev,
 						   (__force u32)nh->fib_nh_gw4);
 		else if (nh->fib_nh_gw_family == AF_INET6)
-			n = __ipv6_neigh_lookup_noref_stub(nh->fib_nh_dev,
-							   &nh->fib_nh_gw6);
+			n = __ipv6_neigh_lookup_noref(nh->fib_nh_dev,
+						      &nh->fib_nh_gw6);
 		else
 			n = NULL;
 		if (n)
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 223e5efa5ac7..fb397fbb28fc 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1344,7 +1344,7 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
-			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
 			dev_hold(dev);
 			break;
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c942f1282236..c65f88b253b9 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <net/arp.h>
-#include <net/ipv6_stubs.h>
+#include <net/ip6_route.h>
 #include <net/lwtunnel.h>
 #include <net/ndisc.h>
 #include <net/nexthop.h>
@@ -510,7 +510,7 @@ static void nexthop_free_single(struct nexthop *nh)
 		fib_nh_release(nh->net, &nhi->fib_nh);
 		break;
 	case AF_INET6:
-		ipv6_stub->fib6_nh_release(&nhi->fib6_nh);
+		fib6_nh_release(&nhi->fib6_nh);
 		break;
 	}
 	kfree(nhi);
@@ -1367,7 +1367,7 @@ static bool ipv6_good_nh(const struct fib6_nh *nh)
 
 	rcu_read_lock();
 
-	n = __ipv6_neigh_lookup_noref_stub(nh->fib_nh_dev, &nh->fib_nh_gw6);
+	n = __ipv6_neigh_lookup_noref(nh->fib_nh_dev, &nh->fib_nh_gw6);
 	if (n)
 		state = READ_ONCE(n->nud_state);
 
@@ -2151,8 +2151,8 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 		fib6_info_hold(f6i);
 
 		spin_unlock_bh(&nh->lock);
-		ipv6_stub->ip6_del_rt(net, f6i,
-				      !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
+		ip6_del_rt(net, f6i,
+			   !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
 
 		spin_lock_bh(&nh->lock);
 	}
@@ -2208,8 +2208,11 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 	if (!list_empty(&nh->fi_list))
 		rt_cache_flush(net);
 
-	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_update_sernum(net, f6i);
+	list_for_each_entry(f6i, &nh->f6i_list, nh_list) {
+		spin_lock_bh(&f6i->fib6_table->tb6_lock);
+		fib6_update_sernum_upto_root(net, f6i);
+		spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+	}
 
 	/* if an IPv6 group was replaced, we have to release all old
 	 * dsts to make sure all refcounts are released
@@ -2223,7 +2226,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		struct nh_info *nhi = rtnl_dereference(nhge->nh->nh_info);
 
 		if (nhi->family == AF_INET6)
-			ipv6_stub->fib6_nh_release_dsts(&nhi->fib6_nh);
+			fib6_nh_release_dsts(&nhi->fib6_nh);
 	}
 }
 
@@ -2504,7 +2507,7 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 	}
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_rt_update(net, f6i, info);
+		fib6_rt_update(net, f6i, info);
 }
 
 /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
@@ -2877,13 +2880,12 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
 		fib6_cfg.fc_flags |= RTF_GATEWAY;
 
 	/* sets nh_dev if successful */
-	err = ipv6_stub->fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL,
-				      extack);
+	err = fib6_nh_init(net, fib6_nh, &fib6_cfg, GFP_KERNEL, extack);
 	if (err) {
 		/* IPv6 is not enabled, don't call fib6_nh_release */
 		if (err == -EAFNOSUPPORT)
 			goto out;
-		ipv6_stub->fib6_nh_release(fib6_nh);
+		fib6_nh_release(fib6_nh);
 	} else {
 		nh->nh_flags = fib6_nh->fib_nh_flags;
 	}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 463236e0dc2d..802c68a1b446 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -447,7 +447,7 @@ static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 	if (rt->rt_gw_family == AF_INET) {
 		pkey = (const __be32 *)&rt->rt_gw4;
 	} else if (rt->rt_gw_family == AF_INET6) {
-		return __ipv6_confirm_neigh_stub(dev, &rt->rt_gw6);
+		return __ipv6_confirm_neigh(dev, &rt->rt_gw6);
 	} else if (!daddr ||
 		 (rt->rt_flags &
 		  (RTCF_MULTICAST | RTCF_BROADCAST | RTCF_LOCAL))) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2cc6d059b692..443a1fbb9cc7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -118,9 +118,6 @@
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
 #include <net/gro.h>
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ipv6_stubs.h>
-#endif
 #include <net/rps.h>
 
 struct udp_table udp_table __read_mostly;
@@ -2855,7 +2852,7 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
 		if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
-			new_gro_receive = ipv6_stub->xfrm6_gro_udp_encap_rcv;
+			new_gro_receive = xfrm6_gro_udp_encap_rcv;
 		else
 			new_gro_receive = xfrm4_gro_udp_encap_rcv;
 
@@ -2927,7 +2924,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
 				WRITE_ONCE(up->encap_rcv,
-					   ipv6_stub->xfrm6_udp_encap_rcv);
+					   xfrm6_udp_encap_rcv);
 			else
 #endif
 				WRITE_ONCE(up->encap_rcv,
-- 
2.53.0


