Return-Path: <netdev+bounces-49403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A17F1E8A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 22:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A554B21B11
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A234CF7;
	Mon, 20 Nov 2023 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZvEVtb5c"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D485CF
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=eJTrXjw8T5Nm7IkHK48gHPZdjMCS5zOQcoMABU0j6sw=; b=ZvEVtb5ccCPke2XbFm4V5znALM
	WaXSSe8mRF3rE8gLMf3ZDm5O7Nn7Uo+ugP70DyYtQrmfR71RnXWpDP+1dObw9sVOlpz/mLmRlJY21
	+uvNTdeTHcA4DG4vk8rBkN+QWoyGeb8GmBgrJejMiIopHya5NBLwnivMMYxjxX3mfIH7nb4hfdW49
	0MM4IpEOsV2JydMrmtSrCsJXf2VWkFBJlqvbTq+Fo4ftjH/TC82IWpHsKjGq+WNhmEHr8xYBzztVb
	7/kaZWj9E4GpoUIVPa8lmE/zvxpaqjUohKyMIb91yWNdbi5aevmAX8hEoI/Q1y7hgxt6hQdotgfD5
	5MsoQeug==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5BXk-000Plc-Ki; Mon, 20 Nov 2023 22:10:56 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: stephen@networkplumber.org
Cc: razor@blackwall.org,
	martin.lau@kernel.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH iproute2 v2] ip, link: Add support for netkit
Date: Mon, 20 Nov 2023 22:10:54 +0100
Message-Id: <20231120211054.8750-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27099/Mon Nov 20 09:39:02 2023)

Add base support for creating/dumping netkit devices.

Minimal example usage:

  # ip link add type netkit
  # ip -d a
  [...]
  7: nk0@nk1: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    netkit mode l3 type peer policy forward numtxqueues 1 numrxqueues 1 [...]
  8: nk1@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    netkit mode l3 type primary policy forward numtxqueues 1 numrxqueues 1 [...]

Example usage with netns (for BPF examples, see BPF selftests linked below):

  # ip netns add blue
  # ip link add nk0 type netkit peer nk1 netns blue
  # ip link set up nk0
  # ip addr add 10.0.0.1/24 dev nk0
  # ip -n blue link set up nk1
  # ip -n blue addr add 10.0.0.2/24 dev nk1
  # ping -c1 10.0.0.2
  PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
  64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=0.021 ms

Example usage with L2 mode and peer blackholing when no BPF is attached:

  # ip link add foo type netkit mode l2 forward peer blackhole bar
  # ip -d a
  [...]
  13: bar@foo: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether 5e:5b:81:17:02:27 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
     netkit mode l2 type peer policy blackhole numtxqueues 1 numrxqueues 1 [...]
  14: foo@bar: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOWN group default qlen 1000
     link/ether de:01:a5:88:9e:99 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
     netkit mode l2 type primary policy forward numtxqueues 1 numrxqueues 1 [...]

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://git.kernel.org/torvalds/c/35dfaad7188c
Link: https://git.kernel.org/torvalds/c/05c31b4ab205
Link: https://git.kernel.org/torvalds/c/ace15f91e569
---
 [ Targetted for iproute2 6.7 release. ]

 v1 -> v2:
 - Add table-driven approach for netlink settings dump
 - Remove matches, use strcmp
 - Fix nit with braces
 - Add maintainers entry

 MAINTAINERS              |   6 ++
 ip/Makefile              |   2 +-
 ip/iplink.c              |   4 +-
 ip/iplink_netkit.c       | 165 +++++++++++++++++++++++++++++++++++++++
 man/man8/ip-address.8.in |   3 +-
 man/man8/ip-link.8.in    |  44 +++++++++++
 6 files changed, 220 insertions(+), 4 deletions(-)
 create mode 100644 ip/iplink_netkit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 85e21a2c..1b49d69e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -39,6 +39,12 @@ devlink
 M: Jiri Pirko <jiri@resnulli.us>
 F: devlink/*
 
+netkit
+M: Daniel Borkmann <daniel@iogearbox.net>
+M: Nikolay Aleksandrov <razor@blackwall.org>
+L: bpf@vger.kernel.org
+F: ip/iplink_netkit.c
+
 Remote DMA - rdma
 M: Leon Romanovsky <leon@kernel.org>
 F: rdma/*
diff --git a/ip/Makefile b/ip/Makefile
index 8fd9e295..3535ba78 100644
--- a/ip/Makefile
+++ b/ip/Makefile
@@ -13,7 +13,7 @@ IPOBJ=ip.o ipaddress.o ipaddrlabel.o iproute.o iprule.o ipnetns.o \
     ipvrf.o iplink_xstats.o ipseg6.o iplink_netdevsim.o iplink_rmnet.o \
     ipnexthop.o ipmptcp.o iplink_bareudp.o iplink_wwan.o ipioam6.o \
     iplink_amt.o iplink_batadv.o iplink_gtp.o iplink_virt_wifi.o \
-    ipstats.o
+    iplink_netkit.o ipstats.o
 
 RTMONOBJ=rtmon.o
 
diff --git a/ip/iplink.c b/ip/iplink.c
index 9a548dd3..6989cc4d 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -46,8 +46,8 @@ void iplink_types_usage(void)
 		"          dsa | dummy | erspan | geneve | gre | gretap | gtp | ifb |\n"
 		"          ip6erspan | ip6gre | ip6gretap | ip6tnl |\n"
 		"          ipip | ipoib | ipvlan | ipvtap |\n"
-		"          macsec | macvlan | macvtap |\n"
-		"          netdevsim | nlmon | rmnet | sit | team | team_slave |\n"
+		"          macsec | macvlan | macvtap | netdevsim |\n"
+		"          netkit | nlmon | rmnet | sit | team | team_slave |\n"
 		"          vcan | veth | vlan | vrf | vti | vxcan | vxlan | wwan |\n"
 		"          xfrm | virt_wifi }\n");
 }
diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
new file mode 100644
index 00000000..84ac0bf5
--- /dev/null
+++ b/ip/iplink_netkit.c
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * iplink_netkit.c netkit device management
+ *
+ * Authors:        Daniel Borkmann <daniel@iogearbox.net>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <linux/if_link.h>
+
+#include "rt_names.h"
+#include "utils.h"
+#include "ip_common.h"
+
+static const char * const netkit_mode_strings[] = {
+	[NETKIT_L2]		= "l2",
+	[NETKIT_L3]		= "l3",
+};
+
+static const char * const netkit_policy_strings[] = {
+	[NETKIT_PASS]		= "forward",
+	[NETKIT_DROP]		= "blackhole",
+};
+
+static void explain(struct link_util *lu, FILE *f)
+{
+	fprintf(f,
+		"Usage: ... %s [ mode MODE ] [ POLICY ] [ peer [ POLICY <options> ] ]\n"
+		"\n"
+		"MODE: l3 | l2\n"
+		"POLICY: forward | blackhole\n"
+		"(first values are the defaults if nothing is specified)\n"
+		"\n"
+		"To get <options> type 'ip link add help'.\n",
+		lu->id);
+}
+
+static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
+			    struct nlmsghdr *n)
+{
+	__u32 ifi_flags, ifi_change, ifi_index;
+	struct ifinfomsg *ifm, *peer_ifm;
+	static bool seen_mode, seen_peer;
+	static struct rtattr *data;
+	int err;
+
+	ifm = NLMSG_DATA(n);
+	ifi_flags = ifm->ifi_flags;
+	ifi_change = ifm->ifi_change;
+	ifi_index = ifm->ifi_index;
+	ifm->ifi_flags = 0;
+	ifm->ifi_change = 0;
+	ifm->ifi_index = 0;
+	while (argc > 0) {
+		if (strcmp(*argv, "mode") == 0) {
+			__u32 mode = 0;
+
+			NEXT_ARG();
+			if (seen_mode)
+				duparg("mode", *argv);
+			seen_mode = true;
+
+			if (strcmp(*argv, "l3") == 0) {
+				mode = NETKIT_L3;
+			} else if (strcmp(*argv, "l2") == 0) {
+				mode = NETKIT_L2;
+			} else {
+				fprintf(stderr, "Error: argument of \"mode\" must be either \"l3\" or \"l2\"\n");
+				return -1;
+			}
+			addattr32(n, 1024, IFLA_NETKIT_MODE, mode);
+		} else if (strcmp(*argv, "forward") == 0 ||
+			   strcmp(*argv, "blackhole") == 0) {
+			int attr_name = seen_peer ?
+					IFLA_NETKIT_PEER_POLICY :
+					IFLA_NETKIT_POLICY;
+			__u32 policy = 0;
+
+			if (strcmp(*argv, "forward") == 0) {
+				policy = NETKIT_PASS;
+			} else if (strcmp(*argv, "blackhole") == 0) {
+				policy = NETKIT_DROP;
+			} else {
+				fprintf(stderr, "Error: policy must be either \"forward\" or \"blackhole\"\n");
+				return -1;
+			}
+			addattr32(n, 1024, attr_name, policy);
+		} else if (strcmp(*argv, "peer") == 0) {
+			if (seen_peer)
+				duparg("peer", *(argv + 1));
+			seen_peer = true;
+		} else {
+			char *type = NULL;
+
+			if (seen_peer) {
+				data = addattr_nest(n, 1024, IFLA_NETKIT_PEER_INFO);
+				n->nlmsg_len += sizeof(struct ifinfomsg);
+				err = iplink_parse(argc, argv, (struct iplink_req *)n, &type);
+				if (err < 0)
+					return err;
+				if (type)
+					duparg("type", argv[err]);
+				goto out_ok;
+			}
+			fprintf(stderr, "%s: unknown option \"%s\"?\n",
+				lu->id, *argv);
+			explain(lu, stderr);
+			return -1;
+		}
+		argc--;
+		argv++;
+	}
+out_ok:
+	if (data) {
+		peer_ifm = RTA_DATA(data);
+		peer_ifm->ifi_index = ifm->ifi_index;
+		peer_ifm->ifi_flags = ifm->ifi_flags;
+		peer_ifm->ifi_change = ifm->ifi_change;
+		addattr_nest_end(n, data);
+	}
+	ifm->ifi_flags = ifi_flags;
+	ifm->ifi_change = ifi_change;
+	ifm->ifi_index = ifi_index;
+	return 0;
+}
+
+static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
+{
+	if (!tb)
+		return;
+	if (tb[IFLA_NETKIT_MODE]) {
+		__u32 mode = rta_getattr_u32(tb[IFLA_NETKIT_MODE]);
+
+		print_string(PRINT_ANY, "mode", "mode %s ",
+			     netkit_mode_strings[mode]);
+	}
+	if (tb[IFLA_NETKIT_PRIMARY]) {
+		__u8 primary = rta_getattr_u8(tb[IFLA_NETKIT_PRIMARY]);
+
+		print_string(PRINT_ANY, "type", "type %s ",
+			     primary ? "primary" : "peer");
+	}
+	if (tb[IFLA_NETKIT_POLICY]) {
+		__u32 policy = rta_getattr_u32(tb[IFLA_NETKIT_POLICY]);
+
+		print_string(PRINT_ANY, "policy", "policy %s ",
+			     netkit_policy_strings[policy]);
+	}
+}
+
+static void netkit_print_help(struct link_util *lu,
+			      int argc, char **argv, FILE *f)
+{
+	explain(lu, f);
+}
+
+struct link_util netkit_link_util = {
+	.id		= "netkit",
+	.maxattr	= IFLA_NETKIT_MAX,
+	.parse_opt	= netkit_parse_opt,
+	.print_opt	= netkit_print_opt,
+	.print_help	= netkit_print_help,
+};
diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index b9a476a5..9d34a6a1 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -146,7 +146,8 @@ ip-address \- protocol address management
 .BR ipvlan " |"
 .BR lowpan " |"
 .BR geneve " |"
-.BR macsec " ]"
+.BR macsec " |"
+.BR netkit " ]"
 
 .SH "DESCRIPTION"
 The
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index e82b2dbb..ca49b008 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -247,6 +247,7 @@ ip-link \- network device configuration
 .BR macvlan  " | "
 .BR macvtap  " | "
 .BR netdevsim " |"
+.BR netkit " |"
 .BR nlmon " |"
 .BR rmnet " |"
 .BR sit " |"
@@ -384,6 +385,9 @@ Link types:
 .BR netdevsim
 - Interface for netdev API tests
 .sp
+.BR netkit
+- BPF-programmable network device
+.sp
 .BR nlmon
 - Netlink monitoring device
 .sp
@@ -848,6 +852,46 @@ tunnel.
 
 .in -8
 
+.TP
+netkit Type Support
+For a link of type
+.I netkit
+the following additional arguments are supported:
+
+.BI "ip link add " DEVICE
+.BR type " netkit "
+[
+.BI mode " MODE "
+] [
+.I "POLICY "
+] [
+.BR peer
+[
+.I "POLICY "
+] [
+.I "NAME "
+] ]
+
+.in +8
+
+.sp
+.BI mode " MODE"
+- specifies the operation mode of the netkit device with "l3" and "l2"
+as possible values. Default option is "l3".
+
+.sp
+.I "POLICY"
+- specifies the default device policy when no BPF programs are attached
+with "forward" and "blackhole" as possible values. Default option is
+"forward". Specifying policy before the peer option refers to the primary
+device, after the peer option refers to the peer device.
+
+.sp
+.I "NAME"
+- specifies the device name of the peer device.
+
+.in -8
+
 .TP
 IPIP, SIT Type Support
 For a link of type
-- 
2.34.1


