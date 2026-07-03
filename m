Return-Path: <netdev+bounces-304513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AvCGDnWcR2racAAAu9opvQ
	(envelope-from <netdev+bounces-304513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:26:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDD9701D42
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 13:26:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=RFK9Dp92;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304513-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304513-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4C4A3011103
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 11:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7403C415E;
	Fri,  3 Jul 2026 11:20:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035D3C37B6
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 11:20:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077652; cv=none; b=PugqUEs1r00lEgjaS235i7Rc8gkDzkFejBZQBtk4kiLjdLzYo68gLhS8GOcoqcGE9uy3z5jsyb4lItJliBqP+s4SKN4MIB0OC8FD6kQ2Z64pTpDL/AR7HSD4x5rm65ndYTJfXFfPK8CWnLr6fTEp2+ctLMY3YInxlwPef5+H54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077652; c=relaxed/simple;
	bh=GtujlxPuKkxRp6HfRKed4T8eNS+sJK80GlFoQ6BuwmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y63b56xQia1NgP+AAPv5spDJJ7VNIhGp1Jj0uGSi/vI4sFnDk1sdE1KmUe4X+v1S7KlBM/G/WLcnrACDMiGhcWU3O3VbVzfEJNlS7MYRR4A6YxLz+h/7E6t4aqh69gFC7bwnShvKWlDbLxk5xZi84jpfPGjEtzRJ+Z6S4NbWYog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=RFK9Dp92; arc=none smtp.client-ip=195.10.208.40
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gsB3W5FpNzMm8j;
	Fri, 03 Jul 2026 13:14:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1783077271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ss5zSXqejQDi5pGR58kMHpCrewg4Ecncif24+GSgfN8=;
	b=RFK9Dp92Ro3SJai8AydUQW19byL4SWiMwelHgc3Z7av4sZRcC+WgzMXolm0MCkphvTssKP
	ETSOV5Z47i4Or7ouUb6wazW//98U1RvccTA+kJffOFQ0iH5d7KoF+udNaZLZQwrih01EZm
	LgCmLRYHwxsf2T2+Rx8uMYlTwukORdiHxUGet71xlmr3U69qjm5dFsG0Sp/22k32XYkg0b
	WoPSETl0UF3jIlx9HfXE/PXprxzIBSkqcHZPgKTqKjOPdMYfPIh7XeCZ0k0+6qb9GQfKgh
	j802O7oWdzi4YYFgiG+LysMomUp5tiNRDDt6c2x3oehEaqeIB4DJOw6ELPD2QQ==
From: Marco Baffo <marco@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Marco Baffo <marco@mandelbit.com>
Subject: [PATCH iproute2-next] ip: add OVPN device mode support
Date: Fri,  3 Jul 2026 13:14:19 +0200
Message-ID: <20260703111419.842059-1-marco@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:stephen@networkplumber.org,m:antonio@openvpn.net,m:marco@mandelbit.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304513-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco@mandelbit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mandelbit.com:from_mime,mandelbit.com:email,mandelbit.com:mid,mandelbit.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EDD9701D42

Allow selecting point-to-point or multi-peer mode when creating an
OVPN device.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 ip/Makefile           |  2 +-
 ip/iplink.c           |  2 +-
 ip/iplink_ovpn.c      | 87 +++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in | 24 ++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 ip/iplink_ovpn.c

diff --git a/ip/Makefile b/ip/Makefile
index 3535ba78..978f6841 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
     ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
     iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
-    iplink_netkit.o ipstats.o
+    iplink_netkit.o ipstats.o iplink_ovpn.o
 
 RTMONOBJ=rtmon.o
 
diff --git a/ip/iplink.c b/ip/iplink.c
index 3f0b46c9..c6aee8b6 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -42,7 +42,7 @@ void iplink_types_usage(void)
 		"          ifb | ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
 		"          ipip | ipoib | ipvlan | ipvtap |\n"
 		"          macsec | macvlan | macvtap | netdevsim |\n"
-		"          netkit | nlmon | pfcp | rmnet | sit | team | team_slave |\n"
+		"          netkit | nlmon | ovpn | pfcp | rmnet | sit | team | team_slave |\n"
 		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
 		"          xfrm | virt_wifi }\n");
 }
diff --git a/ip/iplink_ovpn.c b/ip/iplink_ovpn.c
new file mode 100644
index 00000000..08e59526
--- /dev/null
+++ b/ip/iplink_ovpn.c
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * iplink_ovpn.c	OpenVPN DCO device support
+ *
+ * Author: Marco Baffo <marco@mandelbit.com>
+ *
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <linux/if_link.h>
+
+#include "utils.h"
+#include "ip_common.h"
+
+static void print_explain(FILE *f)
+{
+	fprintf(f,
+		"Usage: ... ovpn [ mode { p2p | mp } ]\n"
+		"\n"
+		"MODE := p2p | mp\n"
+		"(p2p is the default if mode is not specified)\n");
+}
+
+static int ovpn_parse_opt(struct link_util *lu, int argc, char **argv,
+			  struct nlmsghdr *n)
+{
+	while (argc > 0) {
+		if (matches(*argv, "mode") == 0) {
+			__u8 mode;
+
+			NEXT_ARG();
+			if (strcmp(*argv, "p2p") == 0)
+				mode = OVPN_MODE_P2P;
+			else if (strcmp(*argv, "mp") == 0)
+				mode = OVPN_MODE_MP;
+			else {
+				fprintf(stderr,
+					"Error: argument of \"mode\" must be either \"p2p\" or \"mp\"\n");
+				return -1;
+			}
+			addattr8(n, 1024, IFLA_OVPN_MODE, mode);
+		} else if (matches(*argv, "help") == 0) {
+			print_explain(stderr);
+			return -1;
+		} else {
+			fprintf(stderr, "ovpn: unknown option \"%s\"?\n", *argv);
+			print_explain(stderr);
+			return -1;
+		}
+		argc--;
+		argv++;
+	}
+
+	return 0;
+}
+
+static void ovpn_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
+{
+	__u8 value;
+
+	if (!tb || !tb[IFLA_OVPN_MODE] ||
+	    RTA_PAYLOAD(tb[IFLA_OVPN_MODE]) < sizeof(value))
+		return;
+
+	value = rta_getattr_u8(tb[IFLA_OVPN_MODE]);
+
+	const char *mode =
+		value == OVPN_MODE_P2P ? "p2p" :
+	    value == OVPN_MODE_MP ? "mp" : "unknown";
+
+	print_string(PRINT_ANY, "mode", "mode %s ", mode);
+}
+
+static void ovpn_print_help(struct link_util *lu, int argc, char **argv,
+			    FILE *f)
+{
+	print_explain(f);
+}
+
+struct link_util ovpn_link_util = {
+	.id		= "ovpn",
+	.maxattr	= IFLA_OVPN_MAX,
+	.parse_opt	= ovpn_parse_opt,
+	.print_opt	= ovpn_print_opt,
+	.print_help	= ovpn_print_help,
+};
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index fc7f0248..d54d2fbc 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -287,6 +287,7 @@ ip-link \- network device configuration
 .BR netdevsim " |"
 .BR netkit " |"
 .BR nlmon " |"
+.BR ovpn " |"
 .BR pfcp " |"
 .BR rmnet " |"
 .BR sit " |"
@@ -430,6 +431,9 @@ Link types:
 .BR nlmon
 - Netlink monitoring device
 .sp
+.BR ovpn
+- OpenVPN Data Channel Offload device
+.sp
 .BR pfcp
 - Packet Forwarding Control Protocol device
 .sp
@@ -1349,6 +1353,26 @@ the following additional arguments are supported:
 .BI  mode " MODE "
 - specifies the mode (datagram or connected) to use.
 
+.TP
+OVPN Type Support
+For a link of type
+.I OVPN
+the following additional arguments are supported:
+
+.BI "ip link add " DEVICE
+.BR "type ovpn " [ " mode " "{ " p2p " | " mp " }" " ]"
+
+.in +8
+.sp
+.BR mode " { " p2p " | " mp " }"
+- selects the OpenVPN device mode. The default,
+.BR p2p ,
+creates a point-to-point device for a single peer. The
+.B mp
+mode creates a multi-peer device.
+
+.in -8
+
 .TP
 ERSPAN Type Support
 For a link of type
-- 
2.43.0


