Return-Path: <netdev+bounces-307416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rtrkF0IFVmp4yAAAu9opvQ
	(envelope-from <netdev+bounces-307416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:45:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A4D753044
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:45:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307416-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307416-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FB4C300BC63
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D9441633;
	Tue, 14 Jul 2026 09:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F543B494;
	Tue, 14 Jul 2026 09:45:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022329; cv=none; b=Z06+UJtf6+5E1S2nkngND8bidz+1tTak/ygrVRZma+10LZxIRlYudlV4DDiEp0uPEQd5huHSF3nyhqxOWERBXs1hbXTB5oJLVTPsixP63Y79plMp820Qdto/fu4EU2jJMqpWc+cSEfUHmnpqe520wr6fFcfsRboN6dwjmFCHn8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022329; c=relaxed/simple;
	bh=6D+ENfztM5kvvtcs5es63ToWxgKGph8PPD9AOMV/wp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftGaCh6VoPgOH0aadY3/ENSkZxY7IqrPuGSpRRb+TCAyZscNGPaFUv3URMjk61abrmRWGUAif7nwefHTY9SNVuLtfXOZ7epaReF9NH+QyhtAnhL2WPMcHZzgXmtUMcYo1x1cS3VwhACqPN7BWI7cQVXEVEZXuVUGa4PEOmKYvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from nat-wifi0.uniroma3.it ([193.204.167.180] helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZhW-000000022cr-2zgE;
	Tue, 14 Jul 2026 11:45:18 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjZdQ-00000000ZV6-1kgE;
	Tue, 14 Jul 2026 11:41:04 +0200
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
Subject: [PATCH net-next 8/9] selftests: net: RFC6724 rule 5.5 tests
Date: Tue, 14 Jul 2026 11:40:11 +0200
Message-ID: <20260714094030.136317-9-equinox@diac24.net>
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
	TAGGED_FROM(0.00)[bounces-307416-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[diac24.net:from_mime,diac24.net:email,diac24.net:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.py:url,ipv6_saddr_rfc6724rule5p5.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59A4D753044

This throws a couple of situations at the IPv6 source address selection
logic, primarily to check that RFC6724 rule 5.5 is applied as expected.

This requires `CONFIG_IPV6_SUBTREES=y`, so that's added to
selftests/net/config.  (The patchset also changes the default on that,
but arguably better to be explicit.)

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../net/ipv6_saddr_rfc6724rule5p5.py          | 231 ++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/net/ipv6_saddr_rfc6724rule5p5.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..c07d2aebad69 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,6 +53,7 @@ TEST_PROGS := \
 	ipv6_flowlabel.sh \
 	ipv6_force_forwarding.sh \
 	ipv6_route_update_soft_lockup.sh \
+	ipv6_saddr_rfc6724rule5p5.py \
 	ipvtap_test.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index e1ce35c2abbe..b0b66412b9f3 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -48,6 +48,7 @@ CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_SUBTREES=y
 CONFIG_IPV6_VTI=y
 CONFIG_IPVLAN=m
 CONFIG_IPVTAP=m
diff --git a/tools/testing/selftests/net/ipv6_saddr_rfc6724rule5p5.py b/tools/testing/selftests/net/ipv6_saddr_rfc6724rule5p5.py
new file mode 100644
index 000000000000..682b39ba991d
--- /dev/null
+++ b/tools/testing/selftests/net/ipv6_saddr_rfc6724rule5p5.py
@@ -0,0 +1,231 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023-2026  David 'equinox' Lamparter
+"""
+RFC 6724 (IPv6 source address selection) rule 5.5 tests
+
+For reference:
+
+   Rule 5.5: Prefer addresses in a prefix advertised by the next-hop.
+   If SA or SA's prefix is assigned by the selected next-hop that will
+   be used to send to D and SB or SB's prefix is assigned by a different
+   next-hop, then prefer SA.  Similarly, if SB or SB's prefix is
+   assigned by the next-hop that will be used to send to D and SA or
+   SA's prefix is assigned by a different next-hop, then prefer SB.
+
+(and since it provides the "counterpoint":)
+
+   Rule 8: Use longest matching prefix.
+   If CommonPrefixLen(SA, D) > CommonPrefixLen(SB, D), then prefer SA.
+   Similarly, if CommonPrefixLen(SB, D) > CommonPrefixLen(SA, D), then
+   prefer SB.
+
+Note rule 5.5 was originally optional but made mandatory by
+draft-ietf-6man-rfc6724-update (which at the point of creation of this test
+was already "done" at the IETF but waiting in the RFC editor queue due to a
+blocking dependency.)
+"""
+
+from socket import socket, AF_INET6, SOCK_DGRAM
+from functools import wraps
+from typing import Callable
+
+from lib.py import ksft_run, ksft_exit, ksft_eq
+from lib.py import NetNS, NetNSEnter
+from lib.py import ip
+
+
+def select_addr(dest):
+    """
+    connect() + getsockname() to figure out what was selected as source address
+    """
+    sock = socket(AF_INET6, SOCK_DGRAM, 0)
+    sock.connect((dest, 12345))
+    return sock.getsockname()[0]
+
+
+def in_netns(func: Callable[[], None]) -> Callable[[], None]:
+    """
+    python decorator to put test function in netns
+    """
+
+    @wraps(func)
+    def wrapped() -> None:
+        with NetNS() as testns:
+            with NetNSEnter(str(testns)):
+                func()
+
+    return wrapped
+
+
+@in_netns
+def test_basic() -> None:
+    """
+    Simple & most common case for RFC6724 rule 5.5: multiple default routes
+    """
+    ip("link add type veth")
+    ip("link set veth0 up")
+    ip("link set veth1 up")
+    ip("addr add 2001:db8:10::1/64   dev veth0 nodad")
+    ip("addr add 2001:db8:1000::1/64 dev veth0 nodad")
+    ip("-6 route add default via fe80::1 dev veth0 metric 100")
+    ip("-6 route add default via fe80::2 dev veth0 metric 200")
+    ip("-6 route add default from 2001:db8:10::/48   via fe80::1 dev veth0")
+    ip("-6 route add default from 2001:db8:1000::/48 via fe80::2 dev veth0")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    # rule 8 would result in the use of the :1001: address, but rule 5.5 applies before.
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:10::1", "rule 5.5 > rule 8")
+
+    ip("-6 route del default via fe80::1 dev veth0 metric 100")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:1000::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:1000::1", "rule 5.5 > rule 8")
+
+
+@in_netns
+def test_nh_obj() -> None:
+    """
+    Same as above, but with nexthop objects for the default route
+
+    NB: The kernel doesn't currently allow nexthop objects for subtree routes.
+    """
+
+    ip("link add type veth")
+    ip("link set veth0 up")
+    ip("link set veth1 up")
+    ip("addr add 2001:db8:10::1/64   dev veth0 nodad")
+    ip("addr add 2001:db8:1000::1/64 dev veth0 nodad")
+
+    # distinct nexthop objects are used, because what matters is the nexthop
+    # itself, not the nexthop object.  To cover everything, make a group.
+    ip("nexthop add id 101 via fe80::1 dev veth0")
+    ip("nexthop add id 201 group 101")
+    ip("nexthop add id 102 via fe80::2 dev veth0")
+    ip("nexthop add id 202 group 102")
+
+    ip("-6 route add default nhid 201 metric 100")
+    ip("-6 route add default nhid 202 metric 200")
+    ip("-6 route add default from 2001:db8:10::/48   via fe80::1 dev veth0")
+    ip("-6 route add default from 2001:db8:1000::/48 via fe80::2 dev veth0")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    # rule 8 would result in the use of the :1001: address, but rule 5.5 applies before.
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:10::1", "rule 5.5 > rule 8")
+
+    ip("-6 route del default nhid 201 metric 100")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:1000::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:1000::1", "rule 5.5 > rule 8")
+
+
+@in_netns
+def test_low_metric() -> None:
+    """
+    Check that subtree routes take effect even if they are higher metric
+
+    For checking that "router advertised prefix", metric is irrelevant.  It
+    matters for the initial unspecific lookup to find a nexthop to begin with.
+    (The later source address check lookup doesn't change the nexthop, i.e.
+    the effects of metrics are already done.)
+    """
+    ip("link add type veth")
+    ip("link set veth0 up")
+    ip("link set veth1 up")
+    ip("addr add 2001:db8:10::1/64   dev veth0 nodad")
+    ip("addr add 2001:db8:1000::1/64 dev veth0 nodad")
+    ip("-6 route add default via fe80::1 dev veth0 metric 100")
+    ip("-6 route add default via fe80::2 dev veth0 metric 200")
+    ip("-6 route add default from 2001:db8:10::/48   via fe80::1 dev veth0")
+    ip("-6 route add default from 2001:db8:1000::/48 via fe80::2 dev veth0 metric 1000")
+    ip("-6 route add default from 2001:db8:1000::/48 via fe80::3 dev veth0 metric 50")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    # rule 8 would result in the use of the :1001: address, but rule 5.5 applies before.
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:10::1", "rule 5.5 > rule 8")
+
+    ip("-6 route del default via fe80::1 dev veth0 metric 100")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:1000::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:1001::"), "2001:db8:1000::1", "rule 5.5 > rule 8")
+
+
+@in_netns
+def test_no_subtree() -> None:
+    """
+    Ensure that matching on a non-subtree route doesn't trigger rule 5.5
+
+    (This was non-obviously broken in earlier versions of the implementations,
+    a non-subtree route would still match.  Make sure it doesn't break again.)
+    """
+    ip("link add type veth")
+    ip("link set veth0 up")
+    ip("link set veth1 up")
+    ip("addr add 2001:db8:10::1/64 dev veth0 nodad")
+    ip("addr add 2001:db8:1000::1/64 dev veth0 nodad")
+    ip("-6 route add default via fe80::1 dev veth0 metric 100")
+    ip("-6 route add default via fe80::2 dev veth0 metric 200")
+    ip("-6 route add default from 2001:db8:10::/48 via fe80::1 dev veth0")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    ksft_eq(
+        select_addr("2001:db8:1001::"),
+        "2001:db8:10::1",
+        "rule 5.5 > rule 8, ignoring non-SADR",
+    )
+
+
+@in_netns
+def test_longer() -> None:
+    """
+    Check functionality for non-default destination.
+
+    This is expected to be very rare in actual practice, and doesn't do
+    backtracking (also refer to kernel docs.)
+    """
+    ip("link add type veth")
+    ip("link set veth0 up")
+    ip("link set veth1 up")
+    ip("addr add 2001:db8:10::1/64 dev veth0 nodad")
+    ip("addr add 2001:db8:1000::1/64 dev veth0 nodad")
+    ip("-6 route add default           via fe80::1 dev veth0 metric 100")
+    ip("-6 route add 2001:db8:500::/48 via fe80::2 dev veth0 metric 100")
+    ip("-6 route add default           from 2001:db8:10::/48   via fe80::1 dev veth0")
+    ip("-6 route add 2001:db8:500::/48 from 2001:db8:1000::/48 via fe80::2 dev veth0")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:500::"), "2001:db8:1000::1", "rule 5.5")
+    ksft_eq(select_addr("2001:db8:500:aaa::"), "2001:db8:1000::1", "rule 5.5")
+
+    ip("-6 route add 2001:db8:500:aaa::/64 via fe80::2 dev veth0 metric 100")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:500::"), "2001:db8:1000::1", "rule 5.5")
+    ksft_eq(select_addr("2001:db8:500:aaa::"), "2001:db8:10::1", "no backtracking")
+
+    ip("-6 route del 2001:db8:500::/48 from 2001:db8:1000::/48 via fe80::2 dev veth0")
+    ip("-6 route add default           from 2001:db8:1000::/48 via fe80::2 dev veth0")
+
+    ksft_eq(select_addr("2001:db8:11::"), "2001:db8:10::1", "baseline pass")
+    ksft_eq(select_addr("2001:db8:500::"), "2001:db8:10::1", "no backtracking")
+    ksft_eq(select_addr("2001:db8:500:aaa::"), "2001:db8:10::1", "no backtracking")
+
+
+def main() -> None:
+    """
+    RFC6724 rule 5.5 test driver
+    """
+    ksft_run(
+        [
+            test_basic,
+            test_nh_obj,
+            test_low_metric,
+            test_no_subtree,
+            test_longer,
+        ]
+    )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


