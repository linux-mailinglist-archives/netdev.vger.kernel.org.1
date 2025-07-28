Return-Path: <netdev+bounces-210464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAC2B13756
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 11:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA541894A57
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449D1E4AB;
	Mon, 28 Jul 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fnfDS1YQ"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D3186284
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694116; cv=none; b=ThDoq/R03dBJ4fz70HyqXoj2tsLl/zewlMd25JLB+Nto4dwnrEv4caEcl/0/mX7dnnMKupwfV3D+BHX1es773Np9Nnn0VX55/xS0yutG3niFpNjVmpfk8NZ+912N89W5QD1qpIX4V+yc31/IX56I6ub1BtKBnKKPfFD4VkJ9I7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694116; c=relaxed/simple;
	bh=PvC2y7Y13i/HJFW+ZXACIKksG5RJzz/zgS7gUX9ukrM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Lwji7FOsmo+ERMyH2J0OkI2agWvGDS3SV/D1H2+ti09QEfUwVg7HoaiqcUDKwM2LzOUKI7yWdFsdrGB3UQoz1undzA3N2CLpzc2fVq/Ci2jw9CtJwf1sTtMt3t0ljLNWOdED4r+09bhPx9r7ulkSyfQkKnMuHO6KUnkbqTPsyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fnfDS1YQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C17A62116DD8; Mon, 28 Jul 2025 02:15:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C17A62116DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753694108;
	bh=6lZuf3bUwFExQzWOAKGC3KB7Ij5EPhxoXKOL6lbkcnw=;
	h=From:To:Cc:Subject:Date:From;
	b=fnfDS1YQXRBrfXKiUX+1dkKvE6NoabrodxbPKLPzH+FRh19IMF0N7re2iizT9Q0Di
	 Vo2TBE0GKOnQdR/JGhoXPwwDa4mAf749FY5uWWln2JYuYMdaXNcObOOyHcvgqjTDzy
	 bGE4VwkLIIm9FculH56fbKtZQWZqg0TaVfSrWoJw=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com,
	ssengar@microsoft.com,
	ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip link' for netdev shaping
Date: Mon, 28 Jul 2025 02:14:59 -0700
Message-Id: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
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

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 include/uapi/linux/netshaper.h |  92 +++++++++++++++++
 ip/Makefile                    |   2 +-
 ip/iplink.c                    |  12 +++
 ip/iplink_netshaper.c          | 180 +++++++++++++++++++++++++++++++++
 4 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/netshaper.h
 create mode 100644 ip/iplink_netshaper.c

diff --git a/include/uapi/linux/netshaper.h b/include/uapi/linux/netshaper.h
new file mode 100644
index 00000000..1b9c563f
--- /dev/null
+++ b/include/uapi/linux/netshaper.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UAPI_LINUX_NET_SHAPER_H
+#define _UAPI_LINUX_NET_SHAPER_H
+
+#define NET_SHAPER_FAMILY_NAME		"net-shaper"
+#define NET_SHAPER_FAMILY_VERSION	1
+
+/**
+ * enum net_shaper_scope - Defines the shaper @id interpretation.
+ * @NET_SHAPER_SCOPE_UNSPEC: The scope is not specified.
+ * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
+ * @NET_SHAPER_SCOPE_QUEUE: The shaper is attached to the given device queue,
+ *   the @id represents the queue number.
+ * @NET_SHAPER_SCOPE_NODE: The shaper allows grouping of queues or other node
+ *   shapers; can be nested in either @netdev shapers or other @node shapers,
+ *   allowing placement in any location of the scheduling tree, except leaves
+ *   and root.
+ */
+enum net_shaper_scope {
+	NET_SHAPER_SCOPE_UNSPEC,
+	NET_SHAPER_SCOPE_NETDEV,
+	NET_SHAPER_SCOPE_QUEUE,
+	NET_SHAPER_SCOPE_NODE,
+
+	/* private: */
+	__NET_SHAPER_SCOPE_MAX,
+	NET_SHAPER_SCOPE_MAX = (__NET_SHAPER_SCOPE_MAX - 1)
+};
+
+/**
+ * enum net_shaper_metric - Different metric supported by the shaper.
+ * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis.
+ * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis.
+ */
+enum net_shaper_metric {
+	NET_SHAPER_METRIC_BPS,
+	NET_SHAPER_METRIC_PPS,
+};
+
+enum {
+	NET_SHAPER_A_HANDLE = 1,
+	NET_SHAPER_A_METRIC,
+	NET_SHAPER_A_BW_MIN,
+	NET_SHAPER_A_BW_MAX,
+	NET_SHAPER_A_BURST,
+	NET_SHAPER_A_PRIORITY,
+	NET_SHAPER_A_WEIGHT,
+	NET_SHAPER_A_IFINDEX,
+	NET_SHAPER_A_PARENT,
+	NET_SHAPER_A_LEAVES,
+
+	__NET_SHAPER_A_MAX,
+	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
+};
+
+enum {
+	NET_SHAPER_A_HANDLE_SCOPE = 1,
+	NET_SHAPER_A_HANDLE_ID,
+
+	__NET_SHAPER_A_HANDLE_MAX,
+	NET_SHAPER_A_HANDLE_MAX = (__NET_SHAPER_A_HANDLE_MAX - 1)
+};
+
+enum {
+	NET_SHAPER_A_CAPS_IFINDEX = 1,
+	NET_SHAPER_A_CAPS_SCOPE,
+	NET_SHAPER_A_CAPS_SUPPORT_METRIC_BPS,
+	NET_SHAPER_A_CAPS_SUPPORT_METRIC_PPS,
+	NET_SHAPER_A_CAPS_SUPPORT_NESTING,
+	NET_SHAPER_A_CAPS_SUPPORT_BW_MIN,
+	NET_SHAPER_A_CAPS_SUPPORT_BW_MAX,
+	NET_SHAPER_A_CAPS_SUPPORT_BURST,
+	NET_SHAPER_A_CAPS_SUPPORT_PRIORITY,
+	NET_SHAPER_A_CAPS_SUPPORT_WEIGHT,
+
+	__NET_SHAPER_A_CAPS_MAX,
+	NET_SHAPER_A_CAPS_MAX = (__NET_SHAPER_A_CAPS_MAX - 1)
+};
+
+enum {
+	NET_SHAPER_CMD_GET = 1,
+	NET_SHAPER_CMD_SET,
+	NET_SHAPER_CMD_DELETE,
+	NET_SHAPER_CMD_GROUP,
+	NET_SHAPER_CMD_CAP_GET,
+
+	__NET_SHAPER_CMD_MAX,
+	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_NET_SHAPER_H */
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
index 59e8caf4..9da6e304 100644
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
 
+	if (matches(*argv, "netshaper") == 0)
+		return iplink_netshaper(argc-1, argv+1);
+
 	if (matches(*argv, "help") == 0) {
 		do_help(argc-1, argv+1);
 		return 0;
diff --git a/ip/iplink_netshaper.c b/ip/iplink_netshaper.c
new file mode 100644
index 00000000..75eee8d3
--- /dev/null
+++ b/ip/iplink_netshaper.c
@@ -0,0 +1,180 @@
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
+		"	SPEED		:= UINT (Mega bits per second)\n");
+
+	exit(-1);
+}
+
+static void print_netshaper_attrs(struct nlmsghdr *answer)
+{
+	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
+	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
+	__u32 speed_bps, speed_mbps;
+	int ifindex;
+
+	parse_rtattr(tb, NET_SHAPER_A_MAX, (struct rtattr *)((char *)ghdr + GENL_HDRLEN), len);
+
+	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
+		if (!tb[i])
+			continue;
+		switch (i) {
+		case NET_SHAPER_A_BW_MAX:
+		speed_bps = rta_getattr_u32(tb[i]);
+		speed_mbps = (speed_bps / 1000000);
+		print_uint(PRINT_ANY, "speed", "Current speed (Mbps): %u\n", speed_mbps);
+		break;
+		case NET_SHAPER_A_IFINDEX:
+		ifindex = rta_getattr_u32(tb[i]);
+		print_string(PRINT_ANY, "dev", "Device Name: %s\n", ll_index_to_name(ifindex));
+		break;
+		default:
+		break;
+		}
+	}
+}
+
+static int do_cmd(int argc, char **argv, struct nlmsghdr *n, int cmd)
+{
+	GENL_REQUEST(req, 1024, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
+		     cmd, NLM_F_REQUEST | NLM_F_ACK);
+
+	struct nlmsghdr *answer;
+	__u32 speed_bps = 0, speed_mbps = 0;
+	int ifindex = -1;
+	int handle_scope = NET_SHAPER_SCOPE_UNSPEC;
+	__u32 handle_id = 0;
+	bool handle_present = false;
+	int err;
+
+	while (argc > 0) {
+		if (matches(*argv, "dev") == 0) {
+			NEXT_ARG();
+			ifindex = ll_name_to_index(*argv);
+		} else if (matches(*argv, "speed") == 0) {
+			NEXT_ARG();
+			if (get_unsigned(&speed_mbps, *argv, 10)) {
+				fprintf(stderr, "Invalid speed value\n");
+				return -1;
+			}
+			/*Convert Mbps to Bps*/
+			speed_bps = (speed_mbps * 1000000);
+		} else if (matches(*argv, "handle") == 0) {
+			handle_present = true;
+			NEXT_ARG();
+			if (matches(*argv, "scope") == 0) {
+				NEXT_ARG();
+				if (matches(*argv, "netdev") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_NETDEV;
+				} else if (matches(*argv, "queue") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_QUEUE;
+				} else if (matches(*argv, "node") == 0) {
+					handle_scope = NET_SHAPER_SCOPE_NODE;
+				} else {
+					fprintf(stderr, "Invalid scope\n");
+					return -1;
+				}
+
+				NEXT_ARG();
+				if (matches(*argv, "id") == 0) {
+					NEXT_ARG();
+					if (get_unsigned(&handle_id, *argv, 10)) {
+						fprintf(stderr, "Invalid handle id\n");
+						return -1;
+					}
+				}
+			}
+		} else {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+		}
+		argc--; argv++;
+	}
+
+	if (ifindex == -1)
+		missarg("dev");
+
+	if (!handle_present)
+		missarg("handle");
+
+	if (cmd == NET_SHAPER_CMD_SET && speed_mbps == 0)
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
+		addattr32(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, speed_bps);
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
+static int netshaper_parse_opt(struct link_util *lu, int argc, char **argv, struct nlmsghdr *n)
+{
+	if (argc < 1)
+		usage();
+	if (matches(*argv, "help") == 0)
+		usage();
+
+	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
+		exit(1);
+
+	if (matches(*argv, "set") == 0)
+		return do_cmd(argc-1, argv+1, n, NET_SHAPER_CMD_SET);
+
+	if (matches(*argv, "delete") == 0)
+		return do_cmd(argc-1, argv+1, n, NET_SHAPER_CMD_DELETE);
+
+	if (matches(*argv, "get") == 0)
+		return do_cmd(argc-1, argv+1, n, NET_SHAPER_CMD_GET);
+
+	fprintf(stderr,
+		"Command \"%s\" is unknown, try \"ip link netshaper help\".\n", *argv);
+	exit(-1);
+}
+
+struct link_util netshaper_link_util = {
+	.id = "netshaper",
+	.parse_opt = netshaper_parse_opt,
+};
-- 
2.43.0


