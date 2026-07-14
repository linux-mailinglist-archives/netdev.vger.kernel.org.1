Return-Path: <netdev+bounces-307414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GRnIAr8EVmpkyAAAu9opvQ
	(envelope-from <netdev+bounces-307414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:43:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEEF752FFF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:43:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307414-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307414-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EA8A3064831
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2844161D;
	Tue, 14 Jul 2026 09:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869C3EE1C0;
	Tue, 14 Jul 2026 09:41:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022097; cv=none; b=f7ZyBGTkF4OEyjz5s8/n0JRj/UJ/pX+Xhc2GjRgTCNUe8SrW07lCiD5lEo+YiAoEfiFZl8A3lgTCMA4AGqdvnG2Wf4acmXBd2RBs3HC3Mu0FcPt79UWv+QwJEnijpM9KRYzysIWOFxDhwLQIas0O49aVYbYCsZpSIHN2Kn78qSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022097; c=relaxed/simple;
	bh=lfrCeaqTmCJ2tP3X9wDmq7RPLxjm4JWDEbDGgIWt6Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTKuFKd5iNfAGlRzS/7/YdG4adHwExG0kooo7cPbNjE1T3sCuLE+o23Lx6G7HzysfeSHFqIBrMcVWqzVhe+BbNzuKi/dr5lV2t1vilHfIb6KdlFxkszObsNb/DKyy0JyA4j4OFB1cspgssmkeBn9qftF20xi08YkeHVdLz8XIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdi-000000022Sy-1kNU;
	Tue, 14 Jul 2026 11:41:22 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdL-00000000ZUb-3ZRd;
	Tue, 14 Jul 2026 11:40:59 +0200
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
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: [PATCH net-next 3/9] net/ipv6: create ipv6_fl_get_saddr
Date: Tue, 14 Jul 2026 11:40:06 +0200
Message-ID: <20260714094030.136317-4-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714094030.136317-1-equinox@diac24.net>
References: <20260714094030.136317-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[diac24.net];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kuba@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:fmancera@suse.de,m:lorenzo@google.com,m:maze@google.com,m:prohr@google.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:equinox@diac24.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-307414-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dst.sk:url,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADEEF752FFF

This adds passing the relevant flow information as well as selected
nexthop into the source address selection code, to allow the RFC6724
rule 5.5 code to look at its details.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 include/net/addrconf.h |  4 ++++
 net/ipv6/addrconf.c    | 45 +++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 8ced27a8229b..7bc0711b8717 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -142,6 +142,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net,
 int ipv6_dev_get_saddr(struct net *net, const struct net_device *dev,
 		       const struct in6_addr *daddr, unsigned int srcprefs,
 		       struct in6_addr *saddr);
+int ipv6_fl_get_saddr(struct net *net, const struct dst_entry *dst,
+		      const struct net_device *dst_dev,
+		      const struct sock *sk, unsigned int srcprefs,
+		      struct flowi6 *fl6);
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr,
 		    u32 banned_flags);
 bool inet_rcv_saddr_equal(const struct sock *sk, const struct sock *sk2,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f1fe9ede1edb..0ba46ed518a9 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1542,7 +1542,9 @@ struct ipv6_saddr_score {
 };
 
 struct ipv6_saddr_dst {
-	const struct in6_addr *addr;
+	const struct flowi6 *fl6;
+	const struct dst_entry *dst;
+	const struct sock *sk;
 	int ifindex;
 	int scope;
 	int label;
@@ -1619,7 +1621,7 @@ static int ipv6_get_saddr_eval(struct net *net,
 		break;
 	case IPV6_SADDR_RULE_LOCAL:
 		/* Rule 1: Prefer same address */
-		ret = ipv6_addr_equal(&score->ifa->addr, dst->addr);
+		ret = ipv6_addr_equal(&score->ifa->addr, &dst->fl6->daddr);
 		break;
 	case IPV6_SADDR_RULE_SCOPE:
 		/* Rule 2: Prefer appropriate scope
@@ -1697,11 +1699,11 @@ static int ipv6_get_saddr_eval(struct net *net,
 		 *	    non-ORCHID vs non-ORCHID
 		 */
 		ret = !(ipv6_addr_orchid(&score->ifa->addr) ^
-			ipv6_addr_orchid(dst->addr));
+			ipv6_addr_orchid(&dst->fl6->daddr));
 		break;
 	case IPV6_SADDR_RULE_PREFIX:
 		/* Rule 8: Use longest matching prefix */
-		ret = ipv6_addr_diff(&score->ifa->addr, dst->addr);
+		ret = ipv6_addr_diff(&score->ifa->addr, &dst->fl6->daddr);
 		if (ret > score->ifa->prefix_len)
 			ret = score->ifa->prefix_len;
 		score->matchlen = ret;
@@ -1819,9 +1821,10 @@ static int ipv6_get_saddr_master(struct net *net,
 	return hiscore_idx;
 }
 
-int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
-		       const struct in6_addr *daddr, unsigned int prefs,
-		       struct in6_addr *saddr)
+int ipv6_fl_get_saddr(struct net *net, const struct dst_entry *dst_entry,
+		      const struct net_device *dst_dev,
+		      const struct sock *sk, unsigned int prefs,
+		      struct flowi6 *fl6)
 {
 	struct ipv6_saddr_score scores[2], *hiscore;
 	struct ipv6_saddr_dst dst;
@@ -1832,11 +1835,13 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 	int hiscore_idx = 0;
 	int ret = 0;
 
-	dst_type = __ipv6_addr_type(daddr);
-	dst.addr = daddr;
+	dst_type = __ipv6_addr_type(&fl6->daddr);
+	dst.fl6 = fl6;
+	dst.sk = sk;
+	dst.dst = dst_entry;
 	dst.ifindex = dst_dev ? dst_dev->ifindex : 0;
 	dst.scope = __ipv6_addr_src_scope(dst_type);
-	dst.label = ipv6_addr_label(net, daddr, dst_type, dst.ifindex);
+	dst.label = ipv6_addr_label(net, &fl6->daddr, dst_type, dst.ifindex);
 	dst.prefs = prefs;
 
 	scores[hiscore_idx].rule = -1;
@@ -1911,11 +1916,29 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 	if (!hiscore->ifa)
 		ret = -EADDRNOTAVAIL;
 	else
-		*saddr = hiscore->ifa->addr;
+		fl6->saddr = hiscore->ifa->addr;
 
 	rcu_read_unlock();
 	return ret;
 }
+EXPORT_SYMBOL(ipv6_fl_get_saddr);
+
+int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
+		       const struct in6_addr *daddr, unsigned int prefs,
+		       struct in6_addr *saddr)
+{
+	struct flowi6 fl6;
+	int ret;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.daddr = *daddr;
+
+	ret = ipv6_fl_get_saddr(net, NULL, dst_dev, NULL, prefs, &fl6);
+	if (!ret)
+		*saddr = fl6.saddr;
+
+	return ret;
+}
 EXPORT_SYMBOL(ipv6_dev_get_saddr);
 
 static int __ipv6_get_lladdr(struct inet6_dev *idev, struct in6_addr *addr,
-- 
2.53.0


