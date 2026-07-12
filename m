Return-Path: <netdev+bounces-306919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f6C0OW34Umo3VwMAu9opvQ
	(envelope-from <netdev+bounces-306919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 04:14:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DDF743818
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 04:14:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=uniroma2.it (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306919-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306919-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01705301F59B
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09D367F4A;
	Sun, 12 Jul 2026 02:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD193672A0
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 02:13:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822427; cv=none; b=RSzri7QtaDn3P7MXkWlIzDFc7faK1aqqVRqnQNpFq1ZRzExQZvez0ZEv3emUdQDn6k5WqBx3MFCrv5jM+KF388tGn55jO6iCutdD4h7Cy+qXmm5YUs9zZGxYhHva1yFFeMIagrDjre+QfEZUuuh9bEq71nVyhFr7Om6kAWa0KP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822427; c=relaxed/simple;
	bh=E6mB5pdHBosQnW592xOaskjo7q29J4mWnCPtE8zo+zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj07TQ3tBZuFbaFlAEIfhi2KUjL+UDVJNDmDMEudVqf8je7uDUpxF76cgJntgA5LBlmQDWqyQzg0YZL9Lo2ArbDj83GVKl6vJPYiaQuqN6JAJSoeKYlK6BTYqY/LPknv307STBt9zyfwVmnpUkGqJxqjNq4aWek6B8EX/5KJGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66C2DKm0015953;
	Sun, 12 Jul 2026 04:13:26 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Justin Iurman <justin.iurman@6wind.com>,
        Anthony Doeraene <anthony.doeraene@uclouvain.be>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH iproute2-next 1/2] seg6: add support for lookup attribute in SRv6 encap routes
Date: Sun, 12 Jul 2026 04:11:54 +0200
Message-Id: <20260712021155.7621-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
References: <20260712021155.7621-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306919-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:nicolas.dichtel@6wind.com,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:paolo.lungaroni@uniroma2.it,m:justin.iurman@6wind.com,m:anthony.doeraene@uclouvain.be,m:andrea.mayer@uniroma2.it,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,encap.red:url,uniroma2.it:from_mime,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58DDF743818

Add support for the new optional "lookup" attribute for seg6 encap
routes. It selects the FIB table for the post-encap SID route lookup
and accepts a table number or a table name.

Examples:

  # SID route installed in the underlay table 500
  ip -6 route add fc00::100/128 via fd00::1 dev veth0 table 500

  # encap route in vrf-100; the first SID is looked up in table 500
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup 500 dev veth0

  # or if the SID is already handled by the main table
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup main dev veth0

When the attribute is omitted, the post-encap SID route lookup behaves
as before, using the current routing context (e.g. the tables selected
according to the routing policy database).

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 ip/iproute.c          |  1 +
 ip/iproute_lwtunnel.c | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/ip/iproute.c b/ip/iproute.c
index 5b9e7ac1..1ce71f78 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -101,6 +101,7 @@ static void usage(void)
 		"ENCAPTYPE := [ mpls | ip | ip6 | seg6 | seg6local | rpl | ioam6 | xfrm ]\n"
 		"ENCAPHDR := [ MPLSLABEL | SEG6HDR | SEG6LOCAL | IOAM6HDR | XFRMINFO ]\n"
 		"SEG6HDR := [ mode SEGMODE ] segs ADDR1,ADDRi,ADDRn [hmac HMACKEYID] [cleanup]\n"
+		"           [ lookup TABLEID ]\n"
 		"SEGMODE := [ encap | encap.red | inline | l2encap | l2encap.red ]\n"
 		"SEG6LOCAL := action ACTION [ OPTIONS ] [ count ]\n"
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 00b4f756..9a1e747c 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -256,6 +256,7 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
 {
 	struct rtattr *tb[SEG6_IPTUNNEL_MAX+1];
 	struct seg6_iptunnel_encap *tuninfo;
+	SPRINT_BUF(b1);
 
 	parse_rtattr_nested(tb, SEG6_IPTUNNEL_MAX, encap);
 
@@ -274,6 +275,12 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
 	}
 
 	print_srh(fp, tuninfo->srh);
+
+	if (tb[SEG6_IPTUNNEL_TABLE]) {
+		print_string(PRINT_ANY, "lookup", "lookup %s ",
+			     rtnl_rttable_n2a(rta_getattr_u32(tb[SEG6_IPTUNNEL_TABLE]),
+					      b1, sizeof(b1)));
+	}
 }
 
 static void print_rpl_srh(FILE *fp, struct ipv6_rpl_sr_hdr *srh)
@@ -955,7 +962,7 @@ static struct ipv6_sr_hdr *parse_srh(char *segbuf, int hmac, bool encap)
 static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			    char ***argvp)
 {
-	int mode_ok = 0, segs_ok = 0, hmac_ok = 0;
+	int mode_ok = 0, segs_ok = 0, hmac_ok = 0, lookup_ok = 0;
 	struct seg6_iptunnel_encap *tuninfo = NULL;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
@@ -963,6 +970,7 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 	bool tunsrc = false;
 	inet_prefix saddr;
 	int argc = *argcp;
+	__u32 lookup = 0;
 	int encap = -1;
 	__u32 hmac = 0;
 	int ret = -1;
@@ -1006,6 +1014,13 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			if (hmac_ok++)
 				duparg2("hmac", *argv);
 			get_u32(&hmac, *argv, 0);
+		} else if (strcmp(*argv, "lookup") == 0) {
+			NEXT_ARG();
+			if (lookup_ok++)
+				duparg2("lookup", *argv);
+			/* note that table 0 is considered an invalid value */
+			if (rtnl_rttable_a2n(&lookup, *argv) || !lookup)
+				invarg("\"lookup\" value is invalid\n", *argv);
 		} else {
 			break;
 		}
@@ -1036,6 +1051,11 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			goto out;
 	}
 
+	if (lookup) {
+		if (rta_addattr32(rta, len, SEG6_IPTUNNEL_TABLE, lookup))
+			goto out;
+	}
+
 	*argcp = argc + 1;
 	*argvp = argv - 1;
 	ret = 0;
-- 
2.20.1


