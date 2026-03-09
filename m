Return-Path: <netdev+bounces-265353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFZtEP8vrmlrAQIAu9opvQ
	(envelope-from <netdev+bounces-265353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:27:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FC23340D
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E938E306C460
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F2240611;
	Mon,  9 Mar 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+7F/qYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKcAlG3M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c+7F/qYm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HKcAlG3M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41790241CB7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022909; cv=none; b=HLB/S3QTimytM3bGOWb0HeqaRMQuzxsdfRqkqlYENIixzEYLs3wOwKzr9YadXDWrxvWZ9ak/UnddMKI2Id39tIB/NjdL3mRm56YHGB1Cxtt4eU/zkAcC4F45+IGWcEM/dM1JvhPaWAe6cMjqhr8UtGJux4dsp3a1DmJxxGXR6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022909; c=relaxed/simple;
	bh=vqFu4037dVCMC1oAXE53D0N6IGpk1pbYD5djX1yBWBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFQkDh0es3OM1Gob56jL1/TvxLbvw1jx0GAdSSEkQz1osBprUkDa7Kp3ZH8Gt5l+/DIVeh8qvs/ZP5YOntUzx3HHnSp5HfbKsf9QVzbwvMKnwiLzD37Fj78Xe4ZY1JS1VbnvzGz9xHuiLpU/8wX3DVq6lqJ4pLUXyVDvesLoV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+7F/qYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKcAlG3M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c+7F/qYm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HKcAlG3M; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A74235BDF9;
	Mon,  9 Mar 2026 02:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FFC9aNR5EAQrE+Pwq2VuaGd519HjLakAgaWUonHhg=;
	b=c+7F/qYmGz9p3JHUaGfJaJECNY9djAAHrIe1wAL4OB8aJw3Wsk3Sv++oaQBByus5gILhEA
	lRglzyvNEjJb8LRt9v14LmkepJM6zhrGZ7INl/XxeCZFIZhVSPTheVbKBydqm6WX6tlaGD
	B+Q4lLaxwfVshaWxIjdXWJPirjo2h9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FFC9aNR5EAQrE+Pwq2VuaGd519HjLakAgaWUonHhg=;
	b=HKcAlG3M/9iFObVi35qLujWeFFYTfkLD/bc0fMbwIXexRQmAfu10pVT9SLMFr1rDCgEiZB
	nCg7p2UOTvUlUhDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773022903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FFC9aNR5EAQrE+Pwq2VuaGd519HjLakAgaWUonHhg=;
	b=c+7F/qYmGz9p3JHUaGfJaJECNY9djAAHrIe1wAL4OB8aJw3Wsk3Sv++oaQBByus5gILhEA
	lRglzyvNEjJb8LRt9v14LmkepJM6zhrGZ7INl/XxeCZFIZhVSPTheVbKBydqm6WX6tlaGD
	B+Q4lLaxwfVshaWxIjdXWJPirjo2h9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773022903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E3FFC9aNR5EAQrE+Pwq2VuaGd519HjLakAgaWUonHhg=;
	b=HKcAlG3M/9iFObVi35qLujWeFFYTfkLD/bc0fMbwIXexRQmAfu10pVT9SLMFr1rDCgEiZB
	nCg7p2UOTvUlUhDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBFB3EC6E;
	Mon,  9 Mar 2026 02:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJqTNrYurmk0MgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 09 Mar 2026 02:21:42 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH 06/10 net-next] ipv4: drop ipv6_stub usage and use direct function calls
Date: Mon,  9 Mar 2026 03:19:39 +0100
Message-ID: <20260309022013.5199-7-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260309022013.5199-1-fmancera@suse.de>
References: <20260309022013.5199-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B92FC23340D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265353-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

As IPv6 is built-in only, the ipv6_stub infrastructure is no longer
necessary.

The IPv4 stack interacts with IPv6 mainly to support IPv4 routes with
IPv6 next-hops (RFC 8950). Convert all these cross-family calls from
ipv6_stub to direct function calls. The fallback functions introduced
previously will prevent linkage errors when CONFIG_IPV6 is disabled.

Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/ipv4/fib_semantics.c | 11 +++++------
 net/ipv4/icmp.c          |  2 +-
 net/ipv4/nexthop.c       | 21 ++++++++++-----------
 net/ipv4/route.c         |  2 +-
 net/ipv4/udp.c           |  7 ++-----
 5 files changed, 19 insertions(+), 24 deletions(-)

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
index ac6d2ffc1963..f76c9ac183ae 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1342,7 +1342,7 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 		case ICMP_AFI_IP6:
 			if (iio->ident.addr.ctype3_hdr.addrlen != sizeof(struct in6_addr))
 				goto send_mal_query;
-			dev = ipv6_stub->ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
+			dev = ipv6_dev_find(net, &iio->ident.addr.ip_addr.ipv6_addr, dev);
 			dev_hold(dev);
 			break;
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 1aa2b05ee8de..2ef79c2ab881 100644
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
 
@@ -2143,8 +2143,8 @@ static void __remove_nexthop_fib(struct net *net, struct nexthop *nh)
 		fib6_info_hold(f6i);
 
 		spin_unlock_bh(&nh->lock);
-		ipv6_stub->ip6_del_rt(net, f6i,
-				      !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
+		ip6_del_rt(net, f6i,
+			   !READ_ONCE(net->ipv4.sysctl_nexthop_compat_mode));
 
 		spin_lock_bh(&nh->lock);
 	}
@@ -2201,7 +2201,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		rt_cache_flush(net);
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_update_sernum(net, f6i);
+		fib6_update_sernum(net, f6i);
 
 	/* if an IPv6 group was replaced, we have to release all old
 	 * dsts to make sure all refcounts are released
@@ -2215,7 +2215,7 @@ static void nh_rt_cache_flush(struct net *net, struct nexthop *nh,
 		struct nh_info *nhi = rtnl_dereference(nhge->nh->nh_info);
 
 		if (nhi->family == AF_INET6)
-			ipv6_stub->fib6_nh_release_dsts(&nhi->fib6_nh);
+			fib6_nh_release_dsts(&nhi->fib6_nh);
 	}
 }
 
@@ -2496,7 +2496,7 @@ static void __nexthop_replace_notify(struct net *net, struct nexthop *nh,
 	}
 
 	list_for_each_entry(f6i, &nh->f6i_list, nh_list)
-		ipv6_stub->fib6_rt_update(net, f6i, info);
+		fib6_rt_update(net, f6i, info);
 }
 
 /* send RTM_NEWROUTE with REPLACE flag set for all FIB entries
@@ -2869,13 +2869,12 @@ static int nh_create_ipv6(struct net *net,  struct nexthop *nh,
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
index 668a0284c3d5..4995ce651a31 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -117,9 +117,6 @@
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
 #include <net/gro.h>
-#if IS_ENABLED(CONFIG_IPV6)
-#include <net/ipv6_stubs.h>
-#endif
 #include <net/rps.h>
 
 struct udp_table udp_table __read_mostly;
@@ -2970,7 +2967,7 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
 
 	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
 		if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
-			new_gro_receive = ipv6_stub->xfrm6_gro_udp_encap_rcv;
+			new_gro_receive = xfrm6_gro_udp_encap_rcv;
 		else
 			new_gro_receive = xfrm4_gro_udp_encap_rcv;
 
@@ -3043,7 +3040,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
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


