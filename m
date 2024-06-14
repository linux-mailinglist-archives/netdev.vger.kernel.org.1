Return-Path: <netdev+bounces-103614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6D908C9B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 15:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D731C23C41
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221201C27;
	Fri, 14 Jun 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="e9JA1miF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE519D8B2
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372341; cv=none; b=V7ZFqp6kBmSA8nAssAkVD3gxSCQBpuGccVRsMEfAwlTe9IKiQRDDIUYlNIV9Wv5aii1qReoBisD0vCjSIka/5G8rG5f/lC3EI3lsg+u4qKV8ksWqRw7Ups4XXNCbESEQhxE7eTzszSR9Cfntx0RZYPrQVYXc3VGB2dQKa29QR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372341; c=relaxed/simple;
	bh=NfOvLuh5WOf8Hdo6LN2wpjDQm8QakCsGfnpHQRRdAt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BO2Qdc2ai8cvDP8NvkRNdtkJTgHNkpUEW2Reqc62tX7inkkfXBxEuuVbYcKAClXNYrgS3Pi1YFvbGCQ9L413SK7Ss/d02S/0rUpv57P6Xx4Zw8pH6TN/ZbkuNiFmbJ9/iLx/BVaTNBiLfGkP+dVrYwjUIzBPiHr7Tn7UWaX0rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=e9JA1miF; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e724bc466fso25094321fa.3
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1718372337; x=1718977137; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oMzaptHEUYgcsJloL3vT7lSkVXfNwAQtqAjb6Kh7Tk4=;
        b=e9JA1miFLAHBnTdLraHj4m7DlAY8Kk+amC/jBVt5g6NBGfIh1lSPoqnsEMJZa3ZnYu
         /JBOo4Cewx4ecswywSYD5VZIY0tRQRFVcWhxPAQGCX6PGW3+cdUbB+tOIhyfD+6uW/9o
         MQbQ4f3B2ba4j9ZT/xZw2sFYknvw7lleBX4c3ZJT1b8fciDvTJRPDLM3XiDnAZc46vVD
         vLE4ROvCNumKrauqbyv428d5d1E7AX7WQWFFb3CcI2AN3BwS2ld9AaUxgWvVKd4GaMhZ
         3vB+JqsfpJtNtMBbRFMYAf0NVNiySwt+dtI3Agn6cAFI3y0rA8M0RsmbxZpz4bwq8WRM
         Hijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372337; x=1718977137;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMzaptHEUYgcsJloL3vT7lSkVXfNwAQtqAjb6Kh7Tk4=;
        b=ZDF1vwH+DgW2YyAaqLx+21TThuMUVFy6W7V4+r9HRfUAx/aJk8Zqlf5fHxt8936FTl
         HSEUCaxuR8ezLQrLw7CtM+JcsTr35oCAg61RC+TkdmtMQy1nII7r2vLgyxXJbCFzY83d
         /pMr/nUVb8gwoljUoeDm92a9NJAd8XaF01ryK4oaLb9RKMVYfyIQuB2vjDD/Xy6l8LVe
         si0tXLSUWzUOFwBq6OhafC2InAM1R5+ygKxahPmyljuSfFsiSdJdXm5csdyM9Z73C4Kx
         +ePOBR1PAre/khamtNu8kQdXnzMwx0zz3a6C0Ra8/Dckgm45eg8Q2TCs6IFqRR2yhP/n
         GyRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJngMtZwiijnDgoM9Pm2Zsyr0CsCpmDyKGl53X/oQ88illgsAXeLixLTMuvGlZdXSkV273+4EiKnEAVnNwtuhaJLPcL5+3
X-Gm-Message-State: AOJu0Yy+nD3MkRT6mdEsN2K5LJ5F9MIzwsWLZZahwk1CMtoCtvchStkC
	T+NyKLQi/4O7IwnDnWOzk7c5XFJe64RryrO3EW8RDQGqwyJm2ECW98fJyPq+qlc=
X-Google-Smtp-Source: AGHT+IFx+H03lVy1v16GYaHazcy1AGMYm6RRJF0N6mSGjtrDZfudh3idOZS5RFkYhWpLqDwUgoBfzA==
X-Received: by 2002:a2e:b055:0:b0:2ec:1ca4:3952 with SMTP id 38308e7fff4ca-2ec1ca4397fmr3955291fa.44.1718372337086;
        Fri, 14 Jun 2024 06:38:57 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c179c5sm5327621fa.67.2024.06.14.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:38:56 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH iproute2 3/3] bridge: mst: Add get/set support for MST states
Date: Fri, 14 Jun 2024 15:38:18 +0200
Message-Id: <20240614133818.14876-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614133818.14876-1-tobias@waldekranz.com>
References: <20240614133818.14876-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Allow a port's spanning tree state to be modified on a per-MSTI basis,
and support dumping the current MST states for every port and MSTI.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 bridge/Makefile    |   2 +-
 bridge/br_common.h |   1 +
 bridge/bridge.c    |   3 +-
 bridge/mst.c       | 262 +++++++++++++++++++++++++++++++++++++++++++++
 man/man8/bridge.8  |  57 ++++++++++
 5 files changed, 323 insertions(+), 2 deletions(-)
 create mode 100644 bridge/mst.c

diff --git a/bridge/Makefile b/bridge/Makefile
index 01f8a455..4c57df43 100644
--- a/bridge/Makefile
+++ b/bridge/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-BROBJ = bridge.o fdb.o monitor.o link.o mdb.o vlan.o vni.o
+BROBJ = bridge.o fdb.o monitor.o link.o mdb.o mst.o vlan.o vni.o
 
 include ../config.mk
 
diff --git a/bridge/br_common.h b/bridge/br_common.h
index 704e76b0..3a0cf882 100644
--- a/bridge/br_common.h
+++ b/bridge/br_common.h
@@ -20,6 +20,7 @@ void print_headers(FILE *fp, const char *label);
 int do_fdb(int argc, char **argv);
 int do_mdb(int argc, char **argv);
 int do_monitor(int argc, char **argv);
+int do_mst(int argc, char **argv);
 int do_vlan(int argc, char **argv);
 int do_link(int argc, char **argv);
 int do_vni(int argc, char **argv);
diff --git a/bridge/bridge.c b/bridge/bridge.c
index ef592815..f8b5646a 100644
--- a/bridge/bridge.c
+++ b/bridge/bridge.c
@@ -36,7 +36,7 @@ static void usage(void)
 	fprintf(stderr,
 "Usage: bridge [ OPTIONS ] OBJECT { COMMAND | help }\n"
 "       bridge [ -force ] -batch filename\n"
-"where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
+"where  OBJECT := { link | fdb | mdb | mst | vlan | vni | monitor }\n"
 "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
 "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
 "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
@@ -56,6 +56,7 @@ static const struct cmd {
 	{ "link",	do_link },
 	{ "fdb",	do_fdb },
 	{ "mdb",	do_mdb },
+	{ "mst",	do_mst },
 	{ "vlan",	do_vlan },
 	{ "vni",	do_vni },
 	{ "monitor",	do_monitor },
diff --git a/bridge/mst.c b/bridge/mst.c
new file mode 100644
index 00000000..873ca536
--- /dev/null
+++ b/bridge/mst.c
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Get/set Multiple Spanning Tree (MST) states
+ */
+
+#include <stdio.h>
+#include <linux/if_bridge.h>
+#include <net/if.h>
+
+#include "libnetlink.h"
+#include "json_print.h"
+#include "utils.h"
+
+#include "br_common.h"
+
+#define MST_ID_LEN 9
+
+#define __stringify_1(x...) #x
+#define __stringify(x...) __stringify_1(x)
+
+static unsigned int filter_index;
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage: bridge mst set dev DEV msti MSTI state STATE\n"
+		"       bridge mst {show} [ dev DEV ]\n");
+	exit(-1);
+}
+
+static void print_mst_entry(struct rtattr *a, FILE *fp)
+{
+	struct rtattr *tb[IFLA_BRIDGE_MST_ENTRY_MAX + 1];
+	__u16 msti = 0;
+	__u8 state = 0;
+
+	parse_rtattr_flags(tb, IFLA_BRIDGE_MST_ENTRY_MAX, RTA_DATA(a),
+			   RTA_PAYLOAD(a), NLA_F_NESTED);
+
+
+	if (!(tb[IFLA_BRIDGE_MST_ENTRY_MSTI] &&
+	      tb[IFLA_BRIDGE_MST_ENTRY_STATE])) {
+		fprintf(stderr, "BUG: broken MST entry");
+		return;
+	}
+
+	msti = rta_getattr_u16(tb[IFLA_BRIDGE_MST_ENTRY_MSTI]);
+	state = rta_getattr_u8(tb[IFLA_BRIDGE_MST_ENTRY_STATE]);
+
+	open_json_object(NULL);
+	print_uint(PRINT_ANY, "msti", "%u", msti);
+	print_nl();
+	print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s    ", "");
+	print_stp_state(state);
+	print_nl();
+	close_json_object();
+}
+
+static int print_msts(struct nlmsghdr *n, void *arg)
+{
+	struct ifinfomsg *ifi = NLMSG_DATA(n);
+	struct rtattr *af_spec, *mst, *a;
+	int rem = n->nlmsg_len;
+	bool opened = false;
+
+	rem -= NLMSG_LENGTH(sizeof(*ifi));
+	if (rem < 0) {
+		fprintf(stderr, "BUG: wrong nlmsg len %d\n", rem);
+		return -1;
+	}
+
+	af_spec = parse_rtattr_one(IFLA_AF_SPEC, IFLA_RTA(ifi), rem);
+	if (!af_spec)
+		return -1;
+
+	if (filter_index && filter_index != ifi->ifi_index)
+		return 0;
+
+	mst = parse_rtattr_one_nested(NLA_F_NESTED | IFLA_BRIDGE_MST, af_spec);
+	if (!mst)
+		return 0;
+
+	rem = RTA_PAYLOAD(mst);
+	for (a = RTA_DATA(mst); RTA_OK(a, rem); a = RTA_NEXT(a, rem)) {
+		unsigned short rta_type = a->rta_type & NLA_TYPE_MASK;
+
+		if (rta_type > IFLA_BRIDGE_MST_MAX)
+			continue;
+
+		switch (rta_type) {
+		case IFLA_BRIDGE_MST_ENTRY:
+			if (!opened) {
+				open_json_object(NULL);
+				print_color_string(PRINT_ANY, COLOR_IFNAME,
+						   "ifname",
+						   "%-" __stringify(IFNAMSIZ) "s  ",
+						   ll_index_to_name(ifi->ifi_index));
+				open_json_array(PRINT_JSON, "mst");
+				opened = true;
+			} else {
+				print_string(PRINT_FP, NULL, "%-"
+					     __stringify(IFNAMSIZ) "s  ", "");
+			}
+
+			print_mst_entry(a, arg);
+			break;
+		}
+	}
+
+	if (opened) {
+		close_json_array(PRINT_JSON, NULL);
+		close_json_object();
+	}
+
+	return 0;
+}
+
+static int mst_show(int argc, char **argv)
+{
+	char *filter_dev = NULL;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			if (filter_dev)
+				duparg("dev", *argv);
+			filter_dev = *argv;
+		}
+		argc--; argv++;
+	}
+
+	if (filter_dev) {
+		filter_index = ll_name_to_index(filter_dev);
+		if (!filter_index)
+			return nodev(filter_dev);
+	}
+
+	if (rtnl_linkdump_req_filter(&rth, PF_BRIDGE, RTEXT_FILTER_MST) < 0) {
+		perror("Cannon send dump request");
+		exit(1);
+	}
+
+	new_json_obj(json);
+
+	if (!is_json_context()) {
+		printf("%-" __stringify(IFNAMSIZ) "s  "
+		       "%-" __stringify(MST_ID_LEN) "s",
+		       "port", "msti");
+		printf("\n");
+	}
+
+	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
+		fprintf(stderr, "Dump terminated\n");
+		return -1;
+	}
+
+	delete_json_obj();
+	fflush(stdout);
+	return 0;
+}
+
+static int mst_set(int argc, char **argv)
+{
+	struct {
+		struct nlmsghdr		n;
+		struct ifinfomsg	ifi;
+		char			buf[512];
+	} req = {
+		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+		.n.nlmsg_flags = NLM_F_REQUEST,
+		.n.nlmsg_type = RTM_SETLINK,
+		.ifi.ifi_family = PF_BRIDGE,
+	};
+	char *d = NULL, *m = NULL, *s = NULL, *endptr;
+	struct rtattr *af_spec, *mst, *entry;
+	__u16 msti;
+	__u8 state;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			d = *argv;
+		} else if (strcmp(*argv, "msti") == 0) {
+			NEXT_ARG();
+			m = *argv;
+		} else if (strcmp(*argv, "state") == 0) {
+			NEXT_ARG();
+			s = *argv;
+		} else {
+			if (matches(*argv, "help") == 0)
+				usage();
+		}
+		argc--; argv++;
+	}
+
+	if (d == NULL || m == NULL || s == NULL) {
+		fprintf(stderr, "Device, MSTI and state are required arguments.\n");
+		return -1;
+	}
+
+	req.ifi.ifi_index = ll_name_to_index(d);
+	if (!req.ifi.ifi_index)
+		return nodev(d);
+
+	msti = strtol(m, &endptr, 10);
+	if (!(*s != '\0' && *endptr == '\0')) {
+		fprintf(stderr,
+			"Error: invalid MSTI\n");
+		return -1;
+	}
+
+	state = strtol(s, &endptr, 10);
+	if (!(*s != '\0' && *endptr == '\0')) {
+		state = parse_stp_state(s);
+		if (state == -1) {
+			fprintf(stderr,
+				"Error: invalid STP port state\n");
+			return -1;
+		}
+	}
+
+	af_spec = addattr_nest(&req.n, sizeof(req), IFLA_AF_SPEC);
+	mst = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_MST);
+
+	entry = addattr_nest(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY);
+	entry->rta_type |= NLA_F_NESTED;
+
+	addattr16(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY_MSTI, msti);
+	addattr8(&req.n, sizeof(req), IFLA_BRIDGE_MST_ENTRY_STATE, state);
+
+	addattr_nest_end(&req.n, entry);
+
+	addattr_nest_end(&req.n, mst);
+	addattr_nest_end(&req.n, af_spec);
+
+
+	if (rtnl_talk(&rth, &req.n, NULL) < 0)
+		return -1;
+
+	return 0;
+}
+
+int do_mst(int argc, char **argv)
+{
+	ll_init_map(&rth);
+
+	if (argc > 0) {
+		if (matches(*argv, "set") == 0)
+			return mst_set(argc-1, argv+1);
+
+		if (matches(*argv, "show") == 0 ||
+		    matches(*argv, "lst") == 0 ||
+		    matches(*argv, "list") == 0)
+			return mst_show(argc-1, argv+1);
+		if (matches(*argv, "help") == 0)
+			usage();
+	} else
+		return mst_show(0, NULL);
+
+	fprintf(stderr, "Command \"%s\" is unknown, try \"bridge mst help\".\n", *argv);
+	exit(-1);
+}
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index b4699801..08f329c6 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -207,6 +207,15 @@ bridge \- show / manipulate bridge addresses and devices
 .RB "[ " vni
 .IR VNI " ]"
 
+.ti -8
+.B "bridge mst set"
+.IR dev " DEV " msti " MSTI " state " STP_STATE "
+
+.ti -8
+.BR "bridge mst" " [ [ " show " ] [ "
+.B dev
+.IR DEV " ] ]"
+
 .ti -8
 .BR "bridge vlan" " { " add " | " del " } "
 .B dev
@@ -1247,6 +1256,54 @@ endpoint. Match entries only with the specified destination port number.
 the VXLAN VNI Network Identifier to use to connect to the remote VXLAN tunnel
 endpoint. Match entries only with the specified destination VNI.
 
+.SH bridge mst - multiple spanning tree port states
+
+In the multiple spanning tree (MST) model, the active paths through a
+network can be different for different VLANs.  In other words, a
+bridge port can simultaneously forward one subset of VLANs, while
+blocking another.
+
+Provided that the
+.B mst_enable
+bridge option is enabled, a group of VLANs can be forwarded along the
+same spanning tree by associating them with the same instance (MSTI)
+using
+.BR "bridge vlan global set" .
+
+.SS bridge mst set - set multiple spanning tree state
+
+Set the spanning tree state for
+.IR DEV ,
+in the multiple spanning tree instance
+.IR MSTI ,
+to
+.IR STP_STATE .
+
+.TP
+.BI dev " DEV"
+Interface name of the bridge port.
+
+.TP
+.BI msti " MSTI"
+The multiple spanning tree instance.
+
+.TP
+.BI state " STP_STATE"
+The spanning tree state, see the
+.B state
+option of
+.B "bridge link set"
+for supported states.
+
+.SS bridge mst show - list MST states
+
+List current MST port states in every MSTI.
+
+.TP
+.BI dev " DEV"
+If specified, only display states of the bridge port with this
+interface name.
+
 .SH bridge vlan - VLAN filter list
 
 .B vlan
-- 
2.34.1


