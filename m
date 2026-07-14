Return-Path: <netdev+bounces-307419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VohGAX8FVmqTyAAAu9opvQ
	(envelope-from <netdev+bounces-307419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911D75308F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307419-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB53B3052AB6
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69F441620;
	Tue, 14 Jul 2026 09:45:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A3843CEF3;
	Tue, 14 Jul 2026 09:45:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022352; cv=none; b=tul/q8V6Fbhm+v6ZrKp83Epy94CsJTHQJuNw4998TanceNqWb2jauJvXreFkQQqElxhO/YlDlCfEJbjSz86h3SVax1Zr7qt89z/gixKRLuQANBjaJp0DBzdWi2xb2ELSxI3gUN/kYAYWZBbU/3jlR5/B1YaT71HTn9+mhOKu8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022352; c=relaxed/simple;
	bh=I7IR/QJzw7fHXXNSNsDNnjbu2daLho+C+H6OagnADZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1Q1zns593OIYnPCbSWUovoP71pwxyC3IiB5F+G/moLABcn6BP96WJcUSzFL1gspoeqGA9eIJcKRpYapAEOokGAHD703qcgmS6NI27ySW9HGdMh+6In+A/IiPYPPCCUdb3lQcEe1day9bV8U/lLfPdWqGe0gz2K+O2M861FPvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZhv-000000022cr-1GsQ;
	Tue, 14 Jul 2026 11:45:43 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdN-00000000ZUk-0U2i;
	Tue, 14 Jul 2026 11:41:01 +0200
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
Subject: [PATCH net-next 5/9] net/ipv6: drop ip6_route_get_saddr
Date: Tue, 14 Jul 2026 11:40:08 +0200
Message-ID: <20260714094030.136317-6-equinox@diac24.net>
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
	TAGGED_FROM(0.00)[bounces-307419-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8911D75308F

It's no longer used anywhere.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 include/net/ip6_route.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..fe13cb1d3257 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -140,32 +140,6 @@ void rt6_flush_exceptions(struct fib6_info *f6i);
 void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
 			unsigned long now);
 
-static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
-				      const struct in6_addr *daddr,
-				      unsigned int prefs, int l3mdev_index,
-				      struct in6_addr *saddr)
-{
-	struct net_device *l3mdev;
-	struct net_device *dev;
-	bool same_vrf;
-	int err = 0;
-
-	rcu_read_lock();
-
-	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
-	if (!f6i || !f6i->fib6_prefsrc.plen || l3mdev)
-		dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
-	same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
-	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
-		*saddr = f6i->fib6_prefsrc.addr;
-	else
-		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
-
-	rcu_read_unlock();
-
-	return err;
-}
-
 struct rt6_info *rt6_lookup(struct net *net, const struct in6_addr *daddr,
 			    const struct in6_addr *saddr, int oif,
 			    const struct sk_buff *skb, int flags);
-- 
2.53.0


