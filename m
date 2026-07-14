Return-Path: <netdev+bounces-307421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pxylH5gFVmqcyAAAu9opvQ
	(envelope-from <netdev+bounces-307421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700E7530B3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:47:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307421-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307421-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3972304B692
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E5444705;
	Tue, 14 Jul 2026 09:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29B441613;
	Tue, 14 Jul 2026 09:46:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022368; cv=none; b=R0HOR2+FJHGU0Mh5y3bgPWkWQVTvbtS9HJuv27v0XOWaHjl4jVs3WC9ugW43lyF+oZtQpdjTM/zJ24WhGOySr2TT65+C5e1jqSq+8m2ZjVmc3uMH7/HsQ5ZmLRD13z9P9QzBPAXbinvr9yTsp2Jbs5eqKc9DY3uyf+LxyFcny/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022368; c=relaxed/simple;
	bh=7DZojIV83VfeEs1eSZKvWEnlFjmvJ6B9z8heL1XThlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR3RKwEFjDkB3uwCR1SFpf6ibRRZAXyHmBFmn6WiwcETB7Ga4I5HkSa1IuI+WI10fwS6bcTAl61m/we+XLHZTtog85O/meIvPGdNnv/ztyPF/APHDhs8KpzFyjdd/OFjIEIA8Lf5lVsldXoCiPvUwqwi6jX0UDdDdOt7Hzb5yvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZiB-000000022cr-4BNF;
	Tue, 14 Jul 2026 11:46:00 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdP-00000000ZUu-1Z3K;
	Tue, 14 Jul 2026 11:41:03 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Lorenzo Colitti <lorenzo@google.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Patrick Rohr <prohr@google.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David 'equinox' Lamparter <equinox@diac24.net>,
	Jen Linkova <furry13@gmail.com>
Subject: [PATCH net-next 7/9] net/ipv6: support RFC6724 rule 5.5 via subtrees
Date: Tue, 14 Jul 2026 11:40:10 +0200
Message-ID: <20260714094030.136317-8-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714094030.136317-1-equinox@diac24.net>
References: <20260714094030.136317-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[diac24.net];
	TAGGED_FROM(0.00)[bounces-307421-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kuba@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:fmancera@suse.de,m:lorenzo@google.com,m:maze@google.com,m:prohr@google.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:equinox@diac24.net,m:furry13@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,lwn.net,linuxfoundation.org,suse.de,vger.kernel.org,diac24.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[diac24.net:from_mime,diac24.net:email,diac24.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,dst.net:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3700E7530B3

RFC6724 says:
   Rule 5.5: Prefer addresses in a prefix advertised by the next-hop.
   If SA or SA's prefix is assigned by the selected next-hop that will
   be used to send to D and SB or SB's prefix is assigned by a different
   next-hop, then prefer SA.  Similarly, if SB or SB's prefix is
   assigned by the next-hop that will be used to send to D and SA or
   SA's prefix is assigned by a different next-hop, then prefer SB.

As it turns out, this behavior is immensely useful in handling
renumbering, multihoming, and source address liveliness checks.

That said, just implementing this as an one-shot in source address
selection is not particularly useful if output routing then meanders
between multiple nexthops.  To actually make this work (and work well),
installing source-specific routes for prefixes seen in PIOs is a good
way to go.

To actually select a source address, there's still the route lookup with
an empty source as before, which will select some particular nexthop.
Now, for the various candidate source addresses, this does another
lookup and checks if we got the same nexthop, and prefers those source
addresses - rule 5.5 behavior.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
Cc: Maciej Żenczykowski <maze@google.com>
Cc: Jen Linkova <furry13@gmail.com>
---
 net/ipv6/addrconf.c | 101 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0ba46ed518a9..f5c04928aa14 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1522,6 +1522,7 @@ enum {
 	IPV6_SADDR_RULE_HOA,
 #endif
 	IPV6_SADDR_RULE_OIF,
+	IPV6_SADDR_RULE_PIO_BY_NEXTHOP,
 	IPV6_SADDR_RULE_LABEL,
 	IPV6_SADDR_RULE_PRIVACY,
 	IPV6_SADDR_RULE_ORCHID,
@@ -1542,13 +1543,14 @@ struct ipv6_saddr_score {
 };
 
 struct ipv6_saddr_dst {
-	const struct flowi6 *fl6;
+	struct flowi6 *fl6;
 	const struct dst_entry *dst;
 	const struct sock *sk;
 	int ifindex;
 	int scope;
 	int label;
 	unsigned int prefs;
+	struct net *net;
 };
 
 static inline int ipv6_saddr_preferred(int type)
@@ -1593,6 +1595,80 @@ static bool ipv6_allow_optimistic_dad(const struct net *net,
 #endif
 }
 
+/* "source address is preferable if the chosen nexthop advertised it as a PIO"
+ * => consider 'advertised as a PIO' to be 'the routes for the source's subtree
+ *    include one with the same nexthop'
+ *
+ * NB: there is no backtracking in the subtree here, this is intentional -
+ * each prefix seen (and accepted) in PIOs creates essentially a "zone" which
+ * is our search scope.
+ */
+static int ipv6_saddr_rule5p5(struct ipv6_saddr_score *score,
+			      struct ipv6_saddr_dst *saddr_dst)
+{
+	const struct rt6_info *rt, *cmp_rt;
+	struct dst_entry *cmp_dst;
+	struct fib6_info *f6i;
+	int ret = 0;
+
+	rt = container_of(saddr_dst->dst, struct rt6_info, dst);
+
+	/* fl6->saddr is ::, cf. check at the top of ipv6_common_get_saddr() */
+	saddr_dst->fl6->saddr = score->ifa->addr;
+	cmp_dst = ip6_route_output(saddr_dst->net, saddr_dst->sk,
+				   saddr_dst->fl6);
+	memset(&saddr_dst->fl6->saddr, 0, sizeof(saddr_dst->fl6->saddr));
+
+	if (cmp_dst->error)
+		goto out_release_dst;
+
+	cmp_rt = container_of(cmp_dst, struct rt6_info, dst);
+
+	/* this must work if _any_ nexthop matches; the non-subtree best may
+	 * not be in same order as subtree best
+	 */
+	for (f6i = rcu_dereference(cmp_rt->from); f6i;
+	     f6i = rcu_dereference(f6i->fib6_next)) {
+		struct fib6_nh *f6n = f6i->fib6_nh;
+		struct fib6_info *sibling;
+
+		/* non-subtree route: says nothing about router advertising this source */
+		if (f6i->fib6_src.plen == 0)
+			continue;
+
+		if (f6n->nh_common.nhc_dev != saddr_dst->dst->dev ||
+		    f6n->nh_common.nhc_gw_family != AF_INET6)
+			continue;
+
+		if (ipv6_addr_equal(&f6n->nh_common.nhc_gw.ipv6,
+				    &rt->rt6i_gateway)) {
+			ret = 1;
+			goto out_release_dst;
+		}
+
+		if (!f6i->fib6_nsiblings)
+			continue;
+
+		list_for_each_entry(sibling, &f6i->fib6_siblings, fib6_siblings) {
+			f6n = sibling->fib6_nh;
+
+			if (f6n->nh_common.nhc_dev != saddr_dst->dst->dev ||
+			    f6n->nh_common.nhc_gw_family != AF_INET6)
+				continue;
+
+			if (ipv6_addr_equal(&f6n->nh_common.nhc_gw.ipv6,
+					    &rt->rt6i_gateway)) {
+				ret = 1;
+				goto out_release_dst;
+			}
+		}
+	}
+
+out_release_dst:
+	dst_release(cmp_dst);
+	return ret;
+}
+
 static int ipv6_get_saddr_eval(struct net *net,
 			       struct ipv6_saddr_score *score,
 			       struct ipv6_saddr_dst *dst,
@@ -1677,6 +1753,24 @@ static int ipv6_get_saddr_eval(struct net *net,
 		ret = (!dst->ifindex ||
 		       dst->ifindex == score->ifa->idev->dev->ifindex);
 		break;
+	case IPV6_SADDR_RULE_PIO_BY_NEXTHOP:
+		/* Rule 5.5: Prefer sources advertised by chosen next-hop */
+
+		/* Without subtrees, the source address will make no difference
+		 * in the ip6_route_output call in rule5p5.  Therefore the rule
+		 * 5.5 check becomes useless.  This wouldn't result in any
+		 * errors, but ip6_route_output isn't free, so if subtrees are
+		 * disabled save some cycles by skipping this entirely.
+		 *
+		 * This is done through subtrees_enabled to have the code
+		 * compiled regardless.
+		 */
+		if (fib6_routes_require_src(net) && dst->dst
+		    && !dst->dst->error)
+			ret = ipv6_saddr_rule5p5(score, dst);
+		else
+			ret = 1;
+		break;
 	case IPV6_SADDR_RULE_LABEL:
 		/* Rule 6: Prefer matching label */
 		ret = ipv6_addr_label(net,
@@ -1835,7 +1929,12 @@ int ipv6_fl_get_saddr(struct net *net, const struct dst_entry *dst_entry,
 	int hiscore_idx = 0;
 	int ret = 0;
 
+	/* we should never end up here with a non-empty saddr. */
+	if (WARN_ON_ONCE(!ipv6_addr_any(&fl6->saddr)))
+		return 0;
+
 	dst_type = __ipv6_addr_type(&fl6->daddr);
+	dst.net = net;
 	dst.fl6 = fl6;
 	dst.sk = sk;
 	dst.dst = dst_entry;
-- 
2.53.0


