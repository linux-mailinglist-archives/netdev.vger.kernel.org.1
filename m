Return-Path: <netdev+bounces-108444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90598923D47
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90F7B223F7
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBE16B3B4;
	Tue,  2 Jul 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="onsOz5Q/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4C16B3A1
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922119; cv=none; b=etZgZXklyr9PvVNXJHms2lTun19y6CmzfaXxkBxjLJqJjrSErgfe7TbOWKFElgivz+BGhzpa1470joAEkxHtFwl7GX9GTFicLL6n+6CufPx/F7yklX7MfidbDha/JWDzZY1kSbAQtDHoDixIfP+aBCM84pVwu+jzTxDB3Tj6W8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922119; c=relaxed/simple;
	bh=/5nuBLnx57EsEH5Fp51r8N+mP4r0+26G8FY2XbSSlHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbOAHH/eBNtyqbIPoZaLHQuNY/FjOzC/UNPAaFO1sSpaA1InSEa+bOWhCHGr6XrCXjzymCOV2Sf4SRYyW92013G/THM5wxsBXBMx9THM23KTKPIykn3DHE81nvydn4+zMEIgyXtCXCAEq1mvmXiEEKFpWVy7K1d8h5TtlJ8uvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=onsOz5Q/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e743307a2so4635784e87.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719922115; x=1720526915; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFzCccGikLAGCgY4ieBgdKYyFg/aj/68UUIXY9SMuzs=;
        b=onsOz5Q/jrZv2GAfomtJb32sqLEnmHbflrwW2TzwQAQW4fgkWtbXWwItwfd7M/EW6g
         Zw+DkWdDBGTkl1cs0JunHZprEi+KDMNL4AcMLHOVaYVrPg7qS3hi1DY43IYMu2Kw5SVM
         OZJJRRGtJgvWzH9eoVmxuxa6GPVdv4LCNrfhPU7ZPSMgnxlFrSGv27dnFeWvp8SA38o/
         tarR9LJOpxVAL7iO2KLwfCFj9CuUrmIzRb3qi5bQErPreYQatBD4dhyazTdIHtm/lMO+
         lj8h5mK7CiwSV3hTJHrwJUHq374lty80rSLtSoYDr0EKdi5wKppHJrwsVvl+OKZvlNbi
         3Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719922115; x=1720526915;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFzCccGikLAGCgY4ieBgdKYyFg/aj/68UUIXY9SMuzs=;
        b=lJUyrj8QB925jlzk7HUM3WyOtsfog4OWz7dYvPw25cvaTZdf9XrktXD6Yy6BY+LF16
         7nhILUtt3E5mAqgSa11eaW3xurvPDXGkbdPfta9Rs7VWDS78dXXtt1FysM8TjBc64KL8
         5Du/B7ibj8ocgv/FGtk7i6L+KW+wL7e5++jT8H0Ziw/bBMVt0cGKMMrpoRnwp86zix+k
         Q/5ii6eDofkq1hKMJsy+PJ6oE7fECA8+2ZM/qJ41uLAmHcN7rKjZIOP/wSNPhSKOuN9m
         XpBfgsbsZ0UA3vW9VSQ7lIM4mQ8VIUnzdFHvBWh6+UuZFLC2uWmtansHliRnAypodJG8
         bZkw==
X-Forwarded-Encrypted: i=1; AJvYcCUxn/Cr4CgPhquVhk5G2iE8JHLtcZuT6NqBbAVo+JrjbM+kYMvzqQBZe5PmqObxu53nKUZQMxeZZc43lKaxpBqx86SLHL8b
X-Gm-Message-State: AOJu0YwNx/HUn/PmDhhHUDU63ExjcSnxuJ21OLj2dtTKMbQETd4GFoOy
	/T0G2XI0YVBGm1syHuZD1O2Rhwws/MrcrWPuEwBzQZ1XutP48a9ARxEfEycuRz4=
X-Google-Smtp-Source: AGHT+IH6NGdGFub5TNV2QR9171sllrmPpz4CWI4PH7V1ab+QjIstt5mBJdBeJ827KcuTOdcGJcE2Iw==
X-Received: by 2002:a05:6512:2355:b0:52c:b09e:136d with SMTP id 2adb3069b0e04-52e8268b415mr7290375e87.32.1719922115072;
        Tue, 02 Jul 2024 05:08:35 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab1064asm1799414e87.103.2024.07.02.05.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 05:08:34 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org
Cc: liuhangbin@gmail.com
Subject: [PATCH v3 iproute2 4/4] bridge: mst: Add get/set support for MST states
Date: Tue,  2 Jul 2024 14:08:05 +0200
Message-Id: <20240702120805.2391594-5-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
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
 bridge/mst.c       | 258 +++++++++++++++++++++++++++++++++++++++++++++
 man/man8/bridge.8  |  57 ++++++++++
 5 files changed, 319 insertions(+), 2 deletions(-)
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
index 00000000..f8447284
--- /dev/null
+++ b/bridge/mst.c
@@ -0,0 +1,258 @@
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
+	print_string(PRINT_FP, NULL, "%-" textify(IFNAMSIZ) "s    ", "");
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
+		switch (rta_type) {
+		case IFLA_BRIDGE_MST_ENTRY:
+			if (!opened) {
+				open_json_object(NULL);
+				print_color_string(PRINT_ANY, COLOR_IFNAME,
+						   "ifname",
+						   "%-" textify(IFNAMSIZ) "s  ",
+						   ll_index_to_name(ifi->ifi_index));
+				open_json_array(PRINT_JSON, "mst");
+				opened = true;
+			} else {
+				print_string(PRINT_FP, NULL, "%-"
+					     textify(IFNAMSIZ) "s  ", "");
+			}
+
+			print_mst_entry(a, arg);
+			break;
+		default:
+			continue;
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
+		printf("%-" textify(IFNAMSIZ) "s  "
+		       "%-" textify(MST_ID_LEN) "s",
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
+	__s8 state;
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
index b4699801..08032e2f 100644
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
+.BR "bridge vlan global set dev DEV vid VID msti MSTI" .
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


