Return-Path: <netdev+bounces-307411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8YK6Kp8EVmo5yAAAu9opvQ
	(envelope-from <netdev+bounces-307411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:42:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB5752FD8
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F514304CC10
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCE43FD03;
	Tue, 14 Jul 2026 09:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600743F4C2;
	Tue, 14 Jul 2026 09:41:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022095; cv=none; b=Jbu306fhf0mLj2VXpCt0zoih8w5NbPUHAEluaX5Ztg3Id/qrYI6mPLgV+SBoaE0wp7t0q/JQhinif95YI6Q7+ljmWYwybnlNRAueJjh8Ud/3wit3fTKlfdUpw41f5gjuu7UWMDFDW7p33LPs963RUGItvi99Kt+hel61nC6bjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022095; c=relaxed/simple;
	bh=O3N4etEHLdyldh1o+j+EaZ/ML4Fadt0x4YGW9LD/JDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab8FyNQ2XFI3fiZV6WyXs9lP1j93pwZSuVEjYkJj5GbCfNL0qxRvpVytM4NSfbkaf9in3og4xo2Gtb3xcNCQAByHmHwHkzOyXvXeRLmYvHQA2x4p5PeMDtS+1H9/hUQ+l4S+Eo3kNVvvodvD228apKlfWetA7GqWPnpzS8HTlPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdg-000000022Su-3zhY;
	Tue, 14 Jul 2026 11:41:20 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdJ-00000000ZUT-1321;
	Tue, 14 Jul 2026 11:40:57 +0200
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
Subject: [PATCH net-next 1/9] net/ipv6: fix lookup for ::/0 (non-)subtree route
Date: Tue, 14 Jul 2026 11:40:04 +0200
Message-ID: <20260714094030.136317-2-equinox@diac24.net>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[diac24.net];
	TAGGED_FROM(0.00)[bounces-307411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:kuba@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:fmancera@suse.de,m:lorenzo@google.com,m:maze@google.com,m:prohr@google.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:equinox@diac24.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15DB5752FD8

Assume a scenario with something like the following routes:
default via fe80::1 dev dummy0
2001:db8:1::/48 via fe80::10 dev dummy0
2001:db8:1::/48 from 2001:db8:1:2::/64 via fe80::12 dev dummy0

Now if a lookup happens for 2001:db8:1::2345, but with a source address
*not* covered by the third route, the expectation is to hit the second
one.  Unfortunately, this was broken since the code, on failing the
lookup in the subtree, didn't consider the node itself which the subtree
is attached to, i.e. route #2 above.

The fix is simple, check if the subtree is attached to a node that is
itself a valid route before backtracking to less specific destination
prefixes.

This case is somewhat rare for several reasons.  To begin with, subtree
routes are most commonly attached to the default destination.
Additionally, in the rare cases where a non-default destination prefix
is host to subtree routes, the fallback on not hitting any subtree route
is commonly a default route (or a subtree route on that).

(Note that this was working for the "::/0 from ::/0" case since the root
node is special-cased.  The issue was discovered during RFC 6724 rule
5.5 testing, trying to find edge cases.)

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
Cc: Maciej Żenczykowski <maze@google.com>
---
 net/ipv6/ip6_fib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index a130cdfaebfb..273f2bfc5286 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1656,8 +1656,11 @@ static struct fib6_node *fib6_node_lookup_1(struct fib6_node *root,
 					struct fib6_node *sfn;
 					sfn = fib6_node_lookup_1(subtree,
 								 args + 1);
-					if (!sfn)
+					if (!sfn) {
+						if (fn->fn_flags & RTN_RTINFO)
+							return fn;
 						goto backtrack;
+					}
 					fn = sfn;
 				}
 #endif
-- 
2.53.0


