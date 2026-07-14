Return-Path: <netdev+bounces-307420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N4hMFo8FVmqYyAAAu9opvQ
	(envelope-from <netdev+bounces-307420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD47530A4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:46:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307420-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A677B30548F9
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EBE44163C;
	Tue, 14 Jul 2026 09:46:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D7444707;
	Tue, 14 Jul 2026 09:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022362; cv=none; b=cJ+QLyuM706lYafHYUYiSfLXffhbrWobBigm0VsphWUc7eon8zTGykNjEnkJWNGbn+0eMOLU+mGv6fhWGDezcLi7gzuy2mOMqkdBb9ZRP12OMgduAIFxkn2tRGePUqWFb7dmAnKedQgqTEdS2P7kJ7urPcIWeKEjk9HpuQmFFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022362; c=relaxed/simple;
	bh=uOxVZ8RQnUD/RzQJrLgyc0MIJUp6uGhe/avoeZKDYfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKAjMSp44uP1V+uZ2CmW2Gj0BfyrOiX3YuwadaSrqioWhvtC6J1BiZuXjzI/POtRrG7JX7r8HEEnMuNpALdvC2YO716eCebg0zas0P50Y/ZLWWx0uXUMIG+wUJDR9i7S3zfy1TzPsufBtMEV+Jod7a22rfw9FcygTsRCJ7I1pDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZi3-000000022cr-2YcP;
	Tue, 14 Jul 2026 11:45:51 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdN-00000000ZUp-2xzD;
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
Subject: [PATCH net-next 6/9] net/ipv6: flip IPV6_SUBTREES default to Y
Date: Tue, 14 Jul 2026 11:40:09 +0200
Message-ID: <20260714094030.136317-7-equinox@diac24.net>
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
	TAGGED_FROM(0.00)[bounces-307420-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,diac24.net:from_mime,diac24.net:email,diac24.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BAD47530A4

It's needed for RFC6724 rule 5.5, which as it turns out is more
important than was initially discernible.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 net/ipv6/Kconfig | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index c3806c6ac96f..39659e9b53a3 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -243,16 +243,26 @@ config IPV6_MULTIPLE_TABLES
 config IPV6_SUBTREES
 	bool "IPv6: source address based routing"
 	depends on IPV6_MULTIPLE_TABLES
+	default y
 	help
 	  Enable routing by source address or prefix.
 
 	  The destination address is still the primary routing key, so mixing
 	  normal and source prefix specific routes in the same routing table
-	  may sometimes lead to unintended routing behavior.  This can be
-	  avoided by defining different routing tables for the normal and
-	  source prefix specific routes.
+	  may sometimes lead to unintended routing behavior if the order of
+	  lookups is misunderstood.  To achieve full separation based on source
+	  address, different routing tables should be defined for each source
+	  prefix.
 
-	  If unsure, say N.
+	  Subtrees specifically address scenarios where local connectivity
+	  between source prefixes is shared and unrestricted, but some
+	  destinations (e.g. the default route) have more fine-grained rules.
+
+	  This feature is required to correctly support RFC6724 rule 5.5 in
+	  source address selection.  Rule 5.5 is a necessity for good
+	  multihoming, renumbering and source prefix liveliness checks.
+
+	  If unsure, say Y.
 
 config IPV6_MROUTE
 	bool "IPv6: multicast routing"
-- 
2.53.0


