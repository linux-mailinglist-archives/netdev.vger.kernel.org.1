Return-Path: <netdev+bounces-270286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFurLhM9v2nwzgMAu9opvQ
	(envelope-from <netdev+bounces-270286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 212582E7CDE
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39ED301C3E0
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE002366DCC;
	Sun, 22 Mar 2026 00:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9F3659F6
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140666; cv=none; b=QtnpflhENxhC6TGiUSynEuVqWZeWr1LUNc421H+hYVNXGBJroXQu/i+F/raQgl673TQ/JBgJbmQqZR2nZFR27SLId9Cow+2nkK8XQB5fVG0cG9UarJKbkIX07MkcT82pdwkdWqtIvZJ4ZH7cI00pJnmr8HBxq1o1O+zcF13NhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140666; c=relaxed/simple;
	bh=uFD+rUWfEHXeNfuu5VheYusWneUXx4vUZ8w3hWcV0i4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZwpl4f4MtTtTJLHASRRa2KRUHBDFfY2NK2xEFX7OUVXVeg9U3pgplApQatkewsm1lZNebCs2aIfDgDQvVsBlFC5C7RA2HXTCWYBA3G8k4mrhjbvcBBiim9aWyJ10KvpTan/FIk2O5GmsxAtEpINUaBBtV/faLAe1oSc1bZW/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M0oi8D021661;
	Sun, 22 Mar 2026 01:50:50 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH iproute2-next 2/4] seg6: add srl2 link type support
Date: Sun, 22 Mar 2026 01:50:19 +0100
Message-Id: <20260322005021.12770-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
References: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270286-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Queue-Id: 212582E7CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the srl2 link type for creating SRv6 Ethernet pseudowire
devices with a segment list parameter.

Usage:

  ip link add srl2-0 type srl2 segs fc00::a,fc00::b

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 include/uapi/linux/srl2.h |  20 +++++
 ip/Makefile               |   2 +-
 ip/iplink_srl2.c          | 176 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/srl2.h
 create mode 100644 ip/iplink_srl2.c

diff --git a/include/uapi/linux/srl2.h b/include/uapi/linux/srl2.h
new file mode 100644
index 00000000..e7c8f6fc
--- /dev/null
+++ b/include/uapi/linux/srl2.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later WITH Linux-syscall-note */
+/*
+ *  SRv6 L2 tunnel device
+ *
+ *  Author:
+ *  Andrea Mayer <andrea.mayer@uniroma2.it>
+ */
+
+#ifndef _UAPI_LINUX_SRL2_H
+#define _UAPI_LINUX_SRL2_H
+
+enum {
+	IFLA_SRL2_UNSPEC,
+	IFLA_SRL2_SRH,	/* binary: struct ipv6_sr_hdr + segments */
+	__IFLA_SRL2_MAX,
+};
+
+#define IFLA_SRL2_MAX (__IFLA_SRL2_MAX - 1)
+
+#endif
diff --git a/ip/Makefile b/ip/Makefile
index 3535ba78..99a1724d 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -11,7 +11,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     iplink_bridge.o iplink_bridge_slave.o iplink_dsa.o ipfou.o iplink_ipvlan.o \
     iplink_geneve.o iplink_vrf.o iproute_lwtunnel.o ipmacsec.o ipila.o \
     ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
-    ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
+    ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o iplink_srl2.o \
     iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
     iplink_netkit.o ipstats.o
 
diff --git a/ip/iplink_srl2.c b/ip/iplink_srl2.c
new file mode 100644
index 00000000..b0a546b3
--- /dev/null
+++ b/ip/iplink_srl2.c
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  iproute2 support for SRv6 L2 tunnel device (srl2)
+ *
+ *  Usage:
+ *    ip link add srl2-0 type srl2 segs fc00::a,fc00::b
+ *    ip link set srl2-0 up
+ *    ip link set srl2-0 master br0
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/seg6.h>
+#include <linux/srl2.h>
+
+#include "libnetlink.h"
+#include "utils.h"
+#include "ip_common.h"
+#include "json_print.h"
+
+static void print_explain(FILE *f)
+{
+	fprintf(f,
+		"Usage: ... srl2 segs SEG1,SEG2,...,SEGn\n"
+		"\n"
+		"Where:	SEGi := IPv6 address (SRv6 SID)\n"
+	);
+}
+
+static void explain(void)
+{
+	print_explain(stderr);
+}
+
+/* Build an SRH from a comma-separated list of segments.
+ * The segment list is stored in reverse order in the SRH:
+ *   segments[0] = last SID (final destination)
+ *   segments[first_segment] = first SID (first hop)
+ *
+ * For a srl2 device, the SRH is used as an encap template.
+ * The first SID becomes the outer IPv6 DA after encapsulation.
+ *
+ * Returns a malloc'd SRH or NULL on error.  Caller must free.
+ */
+static struct ipv6_sr_hdr *srl2_parse_srh(char *segbuf)
+{
+	struct ipv6_sr_hdr *srh;
+	int nsegs = 0;
+	int srhlen;
+	char *s;
+	int i;
+
+	if (!segbuf || !*segbuf)
+		invarg("missing segment list", "segs");
+
+	s = segbuf;
+	for (i = 0; *s; *s++ == ',' ? i++ : *s);
+	nsegs = i + 1;
+
+	srhlen = 8 + 16 * nsegs;
+
+	srh = calloc(1, srhlen);
+	if (!srh)
+		return NULL;
+
+	srh->hdrlen = (srhlen >> 3) - 1;
+	srh->type = 4;
+	srh->segments_left = nsegs - 1;
+	srh->first_segment = nsegs - 1;
+
+	i = srh->first_segment;
+	for (s = strtok(segbuf, ","); s; s = strtok(NULL, ",")) {
+		inet_prefix addr;
+
+		get_addr(&addr, s, AF_INET6);
+		memcpy(&srh->segments[i], addr.data, sizeof(struct in6_addr));
+		i--;
+	}
+
+	return srh;
+}
+
+static int srl2_parse_opt(struct link_util *lu, int argc, char **argv,
+			    struct nlmsghdr *n)
+{
+	struct ipv6_sr_hdr *srh = NULL;
+	char segbuf[1024] = {};
+	int segs_ok = 0;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "segs") == 0) {
+			NEXT_ARG();
+			if (segs_ok++)
+				duparg2("segs", *argv);
+			if (strlen(*argv) >= sizeof(segbuf))
+				invarg("segment list too long", "segs");
+			strlcpy(segbuf, *argv, sizeof(segbuf));
+		} else if (strcmp(*argv, "help") == 0) {
+			explain();
+			return -1;
+		} else {
+			fprintf(stderr, "srl2: unknown command \"%s\"?\n",
+				*argv);
+			explain();
+			return -1;
+		}
+		argc--, argv++;
+	}
+
+	if (!segs_ok) {
+		fprintf(stderr, "srl2: missing \"segs\" argument\n");
+		explain();
+		return -1;
+	}
+
+	srh = srl2_parse_srh(segbuf);
+	if (!srh) {
+		fprintf(stderr, "srl2: failed to parse segment list\n");
+		return -1;
+	}
+
+	addattr_l(n, 1024, IFLA_SRL2_SRH, srh,
+		  (srh->hdrlen + 1) << 3);
+
+	free(srh);
+	return 0;
+}
+
+static void srl2_print_opt(struct link_util *lu, FILE *f,
+			     struct rtattr *tb[])
+{
+	struct ipv6_sr_hdr *srh;
+	int i;
+
+	if (!tb)
+		return;
+
+	if (!tb[IFLA_SRL2_SRH])
+		return;
+
+	srh = RTA_DATA(tb[IFLA_SRL2_SRH]);
+
+	if (is_json_context())
+		open_json_array(PRINT_JSON, "segs");
+	else
+		print_string(PRINT_FP, NULL, "segs %s", "");
+
+	for (i = srh->first_segment; i >= 0; i--) {
+		if (!is_json_context() && i < srh->first_segment)
+			print_string(PRINT_FP, NULL, "%s", ",");
+
+		print_color_string(PRINT_ANY, COLOR_INET6, NULL, "%s",
+				   rt_addr_n2a(AF_INET6, 16,
+					       &srh->segments[i]));
+	}
+
+	if (is_json_context())
+		close_json_array(PRINT_JSON, NULL);
+	else
+		print_string(PRINT_FP, NULL, "%s", " ");
+}
+
+static void srl2_print_help(struct link_util *lu, int argc, char **argv,
+			      FILE *f)
+{
+	print_explain(f);
+}
+
+struct link_util srl2_link_util = {
+	.id		= "srl2",
+	.maxattr	= IFLA_SRL2_MAX,
+	.parse_opt	= srl2_parse_opt,
+	.print_opt	= srl2_print_opt,
+	.print_help	= srl2_print_help,
+};
-- 
2.20.1


