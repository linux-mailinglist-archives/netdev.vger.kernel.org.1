Return-Path: <netdev+bounces-307417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I/g2FFYFVmqFyAAAu9opvQ
	(envelope-from <netdev+bounces-307417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:45:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B06075305F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:45:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307417-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A450A300B0A2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138D74446ED;
	Tue, 14 Jul 2026 09:45:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8143F4B5;
	Tue, 14 Jul 2026 09:45:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022335; cv=none; b=M3qpmsMTZUBs/EuXbuZbVmK9csP5128Z3afeYYqHT3Ly2kF/nsRf7W653rQMtsfGNjdWD3qgAL6cO46ilbsSUoQTrpDNTWXloP6jJ/AkI4mvYjs8QoINWK0hKAwQ4ZfACP3M6GnfH552gFeGg5/k0sNJ/aCOZRM9yyi27xvrMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022335; c=relaxed/simple;
	bh=a0B0mW2zc9HNNAEo4nbLAsN2/G/mtnEm5LabEaAyMKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUWD/olPv9kRv9tYsNAc4icfLnQXpCOq0UO8x3fnzrfgWKQQTaCYkEEt14NWFIAYnM7n4IqqJBomqReLEBQlHVQiLI3+ySMkjwmwc35VeqbMXXazIl991XRfOC2BgM8hvZAOs4M6vIZ0qqP6BorqBAdBaW6cW2P3OHM4dKJOirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZhe-000000022cr-49H8;
	Tue, 14 Jul 2026 11:45:26 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdR-00000000ZVB-00DB;
	Tue, 14 Jul 2026 11:41:05 +0200
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
Subject: [PATCH net-next 9/9] net: document RFC6724 rule 5.5 implementation
Date: Tue, 14 Jul 2026 11:40:12 +0200
Message-ID: <20260714094030.136317-10-equinox@diac24.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-307417-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:email,diac24.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B06075305F

RFC6724 rule 5.5 is anything but obvious, especially if trying to do it
well.  (RFC8028 and its errata kinda proves the point.)

This documents what exactly the Linux kernel does for RFC6724 rule 5.5,
especially what the routing table needs to look like for it to work.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 Documentation/networking/ipv6-addrsel.rst | 75 +++++++++++++++++++++++
 MAINTAINERS                               |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/networking/ipv6-addrsel.rst

diff --git a/Documentation/networking/ipv6-addrsel.rst b/Documentation/networking/ipv6-addrsel.rst
new file mode 100644
index 000000000000..bed032e69570
--- /dev/null
+++ b/Documentation/networking/ipv6-addrsel.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================
+IPv6 source address selection trivia
+====================================
+
+
+RFC6724 rule 5.5 support
+------------------------
+
+RFC6724 rule 5.5 is a very short paragraph in a complex RFC that has turned
+out quite tricky, but also immensely useful in multihoming scenarios.  For
+reference, it says:
+
+::
+
+   Rule 5.5: Prefer addresses in a prefix advertised by the next-hop.
+   If SA or SA's prefix is assigned by the selected next-hop that will
+   be used to send to D and SB or SB's prefix is assigned by a different
+   next-hop, then prefer SA.  Similarly, if SB or SB's prefix is
+   assigned by the next-hop that will be used to send to D and SA or
+   SA's prefix is assigned by a different next-hop, then prefer SB.
+
+The way this works on Linux is as follows:
+
+- prior to any source address selection happening, when receiving a RA, more
+  than the installation of a default route (or ::/128 route) needs to happen:
+  for each PIO, a source-specific (subtree) route is *additionally* installed.
+  The effect of this is that *after* a source address has been selected, one
+  of the routers that advertised it will remain in use (this is *not* RFC 6724
+  related, but rather RFC 8028.)  At the same time, these extra routes serve
+  to remember which router advertised what.
+
+- per usual, a route lookup for the IPv6 destination address in consideration
+  is done first.  This is passed around in kernel as a dst_entry.
+
+- the source address selection code iterates through the various rules in
+  RFC 6724.
+
+- if/when rule 5.5 is reached, first of all, there is a check if *any* source
+  specific routes exist in the routing table.  If there are none, the entire
+  code for 5.5 is skipped because it cannot have any effect, but is not free
+  to execute (can involve multiple routing lookups.)  **In applications that
+  use a lot of unbound (e.g. UDP) sockets, installing subtree routes should
+  therefore be avoided to not incur this cost on each source address selection
+  pass.**  Alternatively, applications should bind their sockets to a specific
+  source address such that the selection code is never hit.
+
+- if subtree routes do exist, the source address selection code now repeats
+  the routing lookup done before source address selection is entered, except
+  with the source address under consideration filled in.  This lookup will hit
+  the subtree routes that were installed (see first item), giving a fresh
+  dst_entry.  If the new dst_entry matches the original dst_entry, that means
+  the original router has in fact sent RAs with PIOs for this source address,
+  so it is preferred.  Otherwise it is not.
+
+
+There are a few caveats to consider:
+
+- the kernel currently does not create the subtree routes mentioned in the
+  first item.  This is a separate work item, partially done at the time of
+  writing this.  But this can equally well be performed in userspace processing
+  of RAs, e.g. NetworkManager or plain static configuration.
+
+- since addresses can also be acquired from DHCPv6, even RA/PIO combinations
+  that didn't result in the creation of any addresses (e.g. A=0) should have
+  subtree routes added.  Those routes *may* be relevant for DHCPv6-generated
+  addresses.
+
+- the "announce check" lookup does not backtrack.  Only the destination prefix
+  that provided the "unspecific" (::/128) match is checked for source prefixes
+  to see what routers advertised what.  This means that for e.g. RIOs, subtree
+  routes also have to be created.  (Backtracking for this case would further
+  increase the cost of source address selection, for a pretty rare situation
+  that has an easy fix/workaround.)
diff --git a/MAINTAINERS b/MAINTAINERS
index f3218abefd0c..4edf48362a07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18912,6 +18912,7 @@ F:	Documentation/netlink/specs/rt-addr.yaml
 F:	Documentation/netlink/specs/rt-neigh.yaml
 F:	Documentation/netlink/specs/rt-route.yaml
 F:	Documentation/netlink/specs/rt-rule.yaml
+F:	Documentation/networking/ipv6-addrsel.rst
 F:	include/linux/inetdevice.h
 F:	include/linux/mroute*
 F:	include/net/addrconf.h
-- 
2.53.0


