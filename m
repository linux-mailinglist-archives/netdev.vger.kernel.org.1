Return-Path: <netdev+bounces-307418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xvkrLl0FVmqIyAAAu9opvQ
	(envelope-from <netdev+bounces-307418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB2753065
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307418-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7458D3024889
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0443F39F6;
	Tue, 14 Jul 2026 09:45:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0544212F;
	Tue, 14 Jul 2026 09:45:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022344; cv=none; b=XzPtBPntZZCKJhEnOmvoJfZmC0PmYu2raxQ6QwKAr5u0gZxYx+OT5IKV9JJUl5JoRLh4wqXk+s+omakCp4F08g+7EegfAI+wRqrfC/iv5ReZqGDaOc01HfYqvvQ2iM6lQARn6ljPTUIen4dD8/f+xNHADv1dlzU/y56jlbFgOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022344; c=relaxed/simple;
	bh=/o7aCa1TMGKJN+Wiu/BVeeHGfSgZApucxKN8U1HG5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfTq+20WNfi+FZGjsjPN+D1TOGBfPE87N31SaF7BxCM/gOBP6oiSz5bEXJKfwyJiOhpbLJREvqSenJHd3NMJa+0RDqIwhFDYP3NldFByThANd0sEE19ckgMZVgS3NlSumfGfS+SPbICRZql1hNKskB96BcP25QrnxaXcax/OjUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZhn-000000022cr-0lpI;
	Tue, 14 Jul 2026 11:45:35 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdM-00000000ZUf-1zUZ;
	Tue, 14 Jul 2026 11:41:00 +0200
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
Subject: [PATCH net-next 4/9] net/ipv6: use ipv6_fl_get_saddr in output
Date: Tue, 14 Jul 2026 11:40:07 +0200
Message-ID: <20260714094030.136317-5-equinox@diac24.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-307418-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CCB2753065

Flatten ip6_route_get_saddr() into ip6_dst_lookup_tail (which really
just means handling fib6_prefsrc), and then replace ipv6_dev_get_saddr
with ipv6_fl_get_saddr to pass down the flow information.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 net/ipv6/ip6_output.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43c..03b8d42d9df9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1143,27 +1143,40 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 	int flags = 0;
 
 	/* The correct way to handle this would be to do
-	 * ip6_route_get_saddr, and then ip6_route_output; however,
+	 * ipv6_fl_get_saddr, and then ip6_route_output; however,
 	 * the route-specific preferred source forces the
-	 * ip6_route_output call _before_ ip6_route_get_saddr.
+	 * ip6_route_output call _before_ ipv6_fl_get_saddr.
 	 *
 	 * In source specific routing (no src=any default route),
 	 * ip6_route_output will fail given src=any saddr, though, so
 	 * that's why we try it again later.
 	 */
 	if (ipv6_addr_any(&fl6->saddr)) {
+		struct net_device *l3mdev;
+		struct net_device *dev;
 		struct fib6_info *from;
 		struct rt6_info *rt;
+		bool same_vrf;
 
 		*dst = ip6_route_output(net, sk, fl6);
 		rt = (*dst)->error ? NULL : dst_rt6_info(*dst);
 
 		rcu_read_lock();
 		from = rt ? rcu_dereference(rt->from) : NULL;
-		err = ip6_route_get_saddr(net, from, &fl6->daddr,
-					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
-					  fl6->flowi6_l3mdev,
-					  &fl6->saddr);
+
+		l3mdev = dev_get_by_index_rcu(net, fl6->flowi6_l3mdev);
+		if (!from || !from->fib6_prefsrc.plen || l3mdev)
+			dev = from ? fib6_info_nh_dev(from) : NULL;
+		same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
+		if (from && from->fib6_prefsrc.plen && same_vrf) {
+			fl6->saddr = from->fib6_prefsrc.addr;
+			err = 0;
+		} else
+			err = ipv6_fl_get_saddr(net, *dst,
+						same_vrf ? dev : l3mdev, sk,
+						sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
+						fl6);
+
 		rcu_read_unlock();
 
 		if (err)
-- 
2.53.0


