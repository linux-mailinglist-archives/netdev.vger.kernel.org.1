Return-Path: <netdev+bounces-306174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fHDfHjh6T2oMhwIAu9opvQ
	(envelope-from <netdev+bounces-306174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:38:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C172FB57
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:38:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mandelbit.com header.s=MBO0001 header.b=z74GkJIz;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306174-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306174-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53417302F3BC
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B01406281;
	Thu,  9 Jul 2026 10:35:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org [195.10.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC03FAE10
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593321; cv=none; b=dCGSVctSsa/z/HU0Nm05BW1vNryU8Om4V1QjNaBqjntQanSGFnozM6FMeZgWZxC/dcVBMIEzVkkCWwF2zQiqFT+eykguGTptFK62b3S1TjV2K03l/BVh3HLsa936mGSHYfOW+DA81mb+4z6XoYRvhR5utaSG4bhwuE/2nAAOn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593321; c=relaxed/simple;
	bh=p1kjbhdT6N3Q9NUC7Rx1mS/UfL+53xtmvDuoLjwn3DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYgpiA4z2st+Z5wpEpvZGx9k6uWQnMBcnVAHni9kRcAL9sEDcjDu1lXD2gz7L2LvXhlTreJ91cz+HNzOccP1jkZbmJWx9yeh1WdJAXum5S2VdKJTM0B7tjCcxXv56WdsL2QAgNoqGIhZ5LnRs0bQaJDwRcwfOTG5VKT949QWk9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=z74GkJIz; arc=none smtp.client-ip=195.10.208.42
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gwrmB00Vvz5wk3;
	Thu, 09 Jul 2026 12:28:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1783592938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jmFWoFrPowpEJzbuNxET6ZuMs1aM0FuNyRi2737QkK0=;
	b=z74GkJIzy+oQd0qtm2tC5U8txbvp9aZ0XYISTnEplxlxyoTe45Zs3Umy/yhtaz0M14G2XD
	jZh6UBQtOu7JYY8wqkZ8TvxMZcFz6pEUgPyKNZf7bX4fhJrBSwSg47jHoOAgKi5NfzsDYX
	nbMM7jUqwAfwlMRhb1mXq2xwaXGbBvKNNspZbaBbY/3UPceN30f8bT53o4ZpIGRD1eW3B8
	y1bV48wyU/ZjKsWYF4EQ23djoxnPZ9dAdHk4cbphHLS3EYqxGYTFvTwczM4HMskVw/Wz8O
	H71A0SW9fGaN3TePGc219GtPZyt5VDUHrA0OoHFIAejxfqOO1Vvqo/S8T3Nggg==
From: Marco Baffo <marco@mandelbit.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Antonio Quartulli <antonio@openvpn.net>,
	Marco Baffo <marco@mandelbit.com>
Subject: [PATCH iproute2-next v2] ip: add OVPN device mode support
Date: Thu,  9 Jul 2026 12:28:19 +0200
Message-ID: <20260709102819.48809-1-marco@mandelbit.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-306174-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mandelbit.com:from_mime,mandelbit.com:email,mandelbit.com:mid,mandelbit.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 105C172FB57

ovpn devices (OpenVPN data channel offload, kernel v6.16) can already
be created with "ip link add ovpn0 type ovpn", but the mode is always
left to the kernel default (p2p mode).

Add ovpn link type support so that point-to-point (p2p) or multi-peer
(mp) mode can be selected at creation time and shown by
"ip -d link show".

Example:

  $ ip link add ovpn0 type ovpn mode mp

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---

Changes in v2:
- Created a mode table to use for both parsing and printing.
- Used strcmp() instead of matches().

 ip/Makefile           |  2 +-
 ip/iplink.c           |  2 +-
 ip/iplink_ovpn.c      | 92 +++++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-link.8.in | 24 +++++++++++
 4 files changed, 118 insertions(+), 2 deletions(-)
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
index 00000000..d3dff295
--- /dev/null
+++ b/ip/iplink_ovpn.c
@@ -0,0 +1,92 @@
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
+static const char * const ovpn_mode_strings[] = {
+	[OVPN_MODE_P2P] = "p2p",
+	[OVPN_MODE_MP] = "mp",
+};
+
+static const char *ovpn_mode_to_str(__u8 mode)
+{
+	if (mode >= ARRAY_SIZE(ovpn_mode_strings) || !ovpn_mode_strings[mode])
+		return "(unknown)";
+
+	return ovpn_mode_strings[mode];
+}
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
+		if (strcmp(*argv, "mode") == 0) {
+			int mode, err;
+
+			NEXT_ARG();
+			mode = parse_one_of("mode", *argv, ovpn_mode_strings,
+					    ARRAY_SIZE(ovpn_mode_strings),
+					    &err);
+			if (err)
+				return err;
+			addattr8(n, 1024, IFLA_OVPN_MODE, mode);
+		} else if (strcmp(*argv, "help") == 0) {
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
+	__u8 mode;
+
+	if (!tb || !tb[IFLA_OVPN_MODE] ||
+	    RTA_PAYLOAD(tb[IFLA_OVPN_MODE]) < sizeof(mode))
+		return;
+
+	mode = rta_getattr_u8(tb[IFLA_OVPN_MODE]);
+
+	print_string(PRINT_ANY, "mode", "mode %s ", ovpn_mode_to_str(mode));
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


