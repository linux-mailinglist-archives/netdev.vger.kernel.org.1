Return-Path: <netdev+bounces-212404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF44B1FFDB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5643AB82C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400B7207A22;
	Mon, 11 Aug 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WKAcOL3s"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC813AC1
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895911; cv=none; b=KfygNOm6in2+Hxoz2NVFg21uZEmvy+5UDdopo7Hdb88Ut7lnyC7dQ6NJTpZ0Ts7aVahg0IdVoyFzujzwA56nRQ+gXmZwWbJUIHEi9cPa/CvxpINPcW9EqM7ew7xWWvdzOj4Hy5xSLtjgaqHvtjvm27AqpnaBgecbVNWR6jcgHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895911; c=relaxed/simple;
	bh=VTCMxpEZDTwaXWo/tQM23PzPNpAFh0bP5h6+r3+Xyn4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=P3TwsJmNi9ZLYjoeyJ3guh+filK/7H73v/0lwaiXjLlmaiN2vXDNNCJbJ43YcjYwfHI8WL/kpT45iBqfWvNOoHA3ECOMSQXpUTC9hPMF2ItBypzXmtbB8o+UaskaINUsAwWWgf8rhzZAvsWsYlPHXaHFJDlVTIndn2Otdc3Deiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WKAcOL3s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 8DE56203EE28; Mon, 11 Aug 2025 00:05:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DE56203EE28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754895903;
	bh=mZVqv152HtRK7AHBrXOSmQFXbeMlFlF8RFUstK7oSSI=;
	h=From:To:Cc:Subject:Date:From;
	b=WKAcOL3sXwhiThPlswM0vjoe4SmZ4jX3kzPRYtOiMyOnuX7OpogzJgVxe2UcWDvEP
	 fGDMXLR0PIcGehljdEsAZl7ySJhAUuzML6XEmdpfN/8ikesSJ3iYHy2biV19bqqi2v
	 HchNHt1GrmpV7HKJ/pah7V65SEjV2eoIjlenzTTk=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@microsoft.com,
	dipayanroy@microsoft.com,
	ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to 'ip link' for netdev shaping
Date: Mon, 11 Aug 2025 00:05:02 -0700
Message-Id: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add support for the netshaper Generic Netlink
family to iproute2. Introduce a new subcommand to `ip link` for
configuring netshaper parameters directly from userspace.

This interface allows users to set shaping attributes (such as speed)
which are passed to the kernel to perform the corresponding netshaper
operation.

Example usage:
$ip link netshaper { set | get | delete } dev DEVNAME \
                   handle scope SCOPE id ID \
                   [ speed SPEED ]

Internally, this triggers a kernel call to apply the shaping
configuration to the specified network device.

Currently, the tool supports the following functionalities:
- Setting speed in Mbps, enabling bandwidth clamping for
  a network device that support netshaper operations.
- Deleting the current configuration.
- Querying the existing configuration.

Additional netshaper operations will be integrated into the tool
as per requirement.

This change enables easy and scriptable configuration of bandwidth
shaping for  devices that use the netshaper Netlink family.

Corresponding net-next patches:
1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/

Install pkg-config and libmnl* packages to print kernel extack
errors to stdout.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Please add include/uapi/linux/net_shaper.h from kernel source tree
for this patch.
---
Changes in v3:
* Use strcmp instead of matches.
* Use get_rate64 instead get_unsigned for speed parameter.
* Remove speed_mbps in do_cmd() to reduce redundancy.
* Update the usage of speed parameter in the command.
Changes in v2:
* Use color coding for printing device name in stdout.
* Use clang-format to format the code inline.
* Use __u64 for speed_bps.
* Remove include/uapi/linux/netshaper.h file. 
---
 ip/Makefile           |   2 +-
 ip/iplink.c           |  12 +++
 ip/iplink_netshaper.c | 189 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 ip/iplink_netshaper.c

diff --git a/ip/Makefile b/ip/Makefile
index 3535ba78..18218c3b 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -4,7 +4,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     ipmaddr.o ipmonitor.o ipmroute.o ipprefix.o iptuntap.o iptoken.o \
     ipxfrm.o xfrm_state.o xfrm_policy.o xfrm_monitor.o iplink_dummy.o \
     iplink_ifb.o iplink_nlmon.o iplink_team.o iplink_vcan.o iplink_vxcan.o \
-    iplink_vlan.o link_veth.o link_gre.o iplink_can.o iplink_xdp.o \
+    iplink_vlan.o iplink_netshaper.o link_veth.o link_gre.o iplink_can.o iplink_xdp.o \
     iplink_macvlan.o ipl2tp.o link_vti.o link_vti6.o link_xfrm.o \
     iplink_vxlan.o tcp_metrics.o iplink_ipoib.o ipnetconf.o link_ip6tnl.o \
     link_iptnl.o link_gre6.o iplink_bond.o iplink_bond_slave.o iplink_hsr.o \
diff --git a/ip/iplink.c b/ip/iplink.c
index 59e8caf4..daa4603d 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1509,6 +1509,15 @@ static void do_help(int argc, char **argv)
 		usage();
 }
 
+static int iplink_netshaper(int argc, char **argv)
+{
+	struct link_util *lu;
+
+	lu = get_link_kind("netshaper");
+
+	return lu->parse_opt(lu, argc, argv, NULL);
+}
+
 int do_iplink(int argc, char **argv)
 {
 	if (argc < 1)
@@ -1545,6 +1554,9 @@ int do_iplink(int argc, char **argv)
 	if (matches(*argv, "property") == 0)
 		return iplink_prop(argc-1, argv+1);
 
+	if (strcmp(*argv, "netshaper") == 0)
+		return iplink_netshaper(argc-1, argv+1);
+
 	if (matches(*argv, "help") == 0) {
 		do_help(argc-1, argv+1);
 		return 0;
diff --git a/ip/iplink_netshaper.c b/ip/iplink_netshaper.c
new file mode 100644
index 00000000..30ee6c3e
--- /dev/null
+++ b/ip/iplink_netshaper.c
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * iplink_netshaper.c netshaper H/W shaping support
+ *
+ * Authors:        Erni Sri Satya Vennela <ernis@linux.microsoft.com>
+ */
+#include <stdio.h>
+#include <string.h>
+#include <linux/genetlink.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <uapi/linux/netshaper.h>
+#include "utils.h"
+#include "ip_common.h"
+#include "libgenl.h"
+
+/* netlink socket */
+static struct rtnl_handle gen_rth = { .fd = -1 };
+static int genl_family = -1;
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage:	ip link netshaper set dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID speed SPEED\n"
+		"	ip link netshaper delete dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID\n"
+		"	ip link netshaper get dev DEVNAME handle scope HANDLE_SCOPE id HANDLE_ID\n"
+		"Where:	DEVNAME		:= STRING\n"
+		"	HANDLE_SCOPE	:= { netdev | queue | node }\n"
+		"	HANDLE_ID	:= UINT\n"
+		"	SPEED		:= UINT{ kbit | mbit | gbit }\n");
+
+	exit(-1);
+}
+
+static void print_netshaper_attrs(struct nlmsghdr *answer)
+{
+	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
+	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
+	__u32 speed_mbps;
+	__u64 speed_bps;
+	int ifindex;
+
+	parse_rtattr(tb, NET_SHAPER_A_MAX,
+		     (struct rtattr *)((char *)ghdr + GENL_HDRLEN), len);
+
+	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
+		if (!tb[i])
+			continue;
+		switch (i) {
+		case NET_SHAPER_A_BW_MAX:
+			speed_bps = rta_getattr_u64(tb[i]);
+			speed_mbps = (speed_bps / 1000000);
+			print_uint(PRINT_ANY, "speed", "speed: %u mbps\n",
+				   speed_mbps);
+			break;
+		case NET_SHAPER_A_IFINDEX:
+			ifindex = rta_getattr_u32(tb[i]);
+			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+					   "dev: %s\n",
+					   ll_index_to_name(ifindex));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static int do_cmd(int argc, char **argv, struct nlmsghdr *n, int cmd)
+{
+	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION, cmd,
+		     NLM_F_REQUEST | NLM_F_ACK);
+
+	struct nlmsghdr *answer;
+	__u64 speed_bps = 0;
+	int ifindex = -1;
+	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
+	__u32 handle_id = 0;
+	bool handle_present = false;
+	int err;
+
+	while (argc > 0) {
+		if (strcmp(*argv, "dev") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+		} else if (strcmp(*argv, "speed") == 0) {
+			NEXT_ARG();
+			if(get_rate64(&speed_bps, *argv)) {
+				fprintf(stderr, "Invalid speed value\n");
+				return -1;
+			}
+			/*Convert Bps to bps*/
+			speed_bps *= 8;
+		} else if (strcmp(*argv, "handle") == 0) {
+			handle_present = true;
+			NEXT_ARG();
+			if (strcmp(*argv, "scope") == 0) {
+				NEXT_ARG();
+				if (strcmp(*argv, "netdev") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_NETDEV;
+				} else if (strcmp(*argv, "queue") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_QUEUE;
+				} else if (strcmp(*argv, "node") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_NODE;
+				} else {
+					fprintf(stderr, "Invalid scope\n");
+					return -1;
+				}
+
+				NEXT_ARG();
+				if (strcmp(*argv, "id") == 0) {
+					NEXT_ARG();
+					if (get_unsigned(&handle_id, *argv, 10)) {
+						fprintf(stderr,
+							"Invalid handle id\n");
+						return -1;
+					}
+				}
+			}
+		} else {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+		}
+		argc--;
+		argv++;
+	}
+
+	if (ifindex == -1)
+		missarg("dev");
+
+	if (!handle_present)
+		missarg("handle");
+
+	if (cmd == NET_SHAPER_CMD_SET && speed_bps == 0)
+		missarg("speed");
+
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, ifindex);
+
+	struct rtattr *handle = addattr_nest(&req.n, sizeof(req),
+					     NET_SHAPER_A_HANDLE | NLA_F_NESTED);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_SCOPE, handle_scope);
+	addattr32(&req.n, sizeof(req), NET_SHAPER_A_HANDLE_ID, handle_id);
+	addattr_nest_end(&req.n, handle);
+
+	if (cmd == NET_SHAPER_CMD_SET)
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, speed_bps);
+
+	err = rtnl_talk(&gen_rth, &req.n, &answer);
+	if (err < 0) {
+		printf("Kernel command failed: %d\n", err);
+		return err;
+	}
+
+	if (cmd == NET_SHAPER_CMD_GET)
+		print_netshaper_attrs(answer);
+
+	return err;
+}
+
+static int netshaper_parse_opt(struct link_util *lu, int argc, char **argv,
+			       struct nlmsghdr *n)
+{
+	if (argc < 1)
+		usage();
+	if (strcmp(*argv, "help") == 0)
+		usage();
+
+	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
+		exit(1);
+
+	if (strcmp(*argv, "set") == 0)
+		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_SET);
+
+	if (strcmp(*argv, "delete") == 0)
+		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_DELETE);
+
+	if (strcmp(*argv, "get") == 0)
+		return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_GET);
+
+	fprintf(stderr,
+		"Command \"%s\" is unknown, try \"ip link netshaper help\".\n",
+		*argv);
+	exit(-1);
+}
+
+struct link_util netshaper_link_util = {
+	.id = "netshaper",
+	.parse_opt = netshaper_parse_opt,
+};
-- 
2.43.0


