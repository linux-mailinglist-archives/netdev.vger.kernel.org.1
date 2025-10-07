Return-Path: <netdev+bounces-228086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09C4BC1141
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2973C6AA3
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71264235C01;
	Tue,  7 Oct 2025 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izIp70Pa"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD22D73B5
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835184; cv=none; b=PSir94KlDRQBvM03n46UZePBngmsSd5h9owTGRlzoGZqVu8ljwVgy/6ZptgP0czuKdeYITo0HsR1euzWT644pv7kfd1vw28FcJrSkbYfrgAuyNprHw8/6y3016u5EkN1EhOuqfe3nN/tgvNiAt00KBNEqpcqhsBvoUvnqQ9SU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835184; c=relaxed/simple;
	bh=ryvb/pUkP9siIqHcKUk15tVPo4uqmzKxj/oc0uPPpCE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ke2H5CWfB3L21GAzSKWn1+MKRyK8sFRcrZZe3l595BN9dmUoK/tS7DpTTrWLWkTzS3oZFDiawJ+i2jjt24ShNaYH/L4VRXHA1GRXTvquRGDXbPYWJsTBeZ6MToXmCzVE3Tfg4pYHmj+f9OGLEIG6GwmPG9BFdPCRFGQRTbJQrbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izIp70Pa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D421C2116268; Tue,  7 Oct 2025 04:06:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D421C2116268
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759835175;
	bh=GhBftia77fBfnEAjCzVuQUruRYnGI9Mdi5cPFSZ9F5U=;
	h=From:To:Cc:Subject:Date:From;
	b=izIp70PaVwiR+e0za4SemW6Cz3CkDDiVE23yuy65lnxDlk6/IXvW4bC27bgR6a9ex
	 DtjpIS9dSy2iAale8ogHgN9K4R22K+DmzWMRth1nf1oC5h490XAaG2dszbisi+jifq
	 Oq38XGZ6gZFvC+tpdKKI9qLIcsKXEOArQ1Wjljdg=
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
Subject: [PATCH iproute2-next v4] netshaper: Add netshaper command
Date: Tue,  7 Oct 2025 04:06:14 -0700
Message-Id: <1759835174-5981-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Add support for the netshaper Generic Netlink family to
iproute2. Introduce a new command for configuring netshaper
parameters directly from userspace.

This interface allows users to set shaping attributes which
are passed to the kernel to perform the corresponding netshaper
operation.

Example usage:
$netshaper { set | show | delete } dev DEV \
           handle scope SCOPE [id ID] \
           [ bw-max BW_MAX ]

Internally, this triggers a kernel call to apply the shaping
configuration to the specified network device.

Currently, the tool supports the following functionalities:
- Setting bandwidth in Mbps, enabling bandwidth clamping for
  a network device that support netshaper operations.
- Deleting the current configuration.
- Querying the existing configuration.

Additional netshaper operations will be integrated into the tool
as per requirement.

This change enables easy and scriptable configuration of bandwidth
shaping for devices that use the netshaper Netlink family.

Corresponding net-next patches:
1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/

Install pkg-config and libmnl* packages to print kernel extack
errors to stdout.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
References and Documentation:
1) https://dri.freedesktop.org/docs/drm/networking/netlink_spec/net_shaper.html
2) https://github.com/VENNELA2132/netshaper_mana/blob/main/netshaper%20implementation
3) https://github.com/VENNELA2132/netshaper_mana/blob/main/userspace%20tool%20for%20netshaper%20operations
---
Changes in v4:
* Use netshaper as a standalone command.
* Add a man page and Makefile for netshaper command.
* Update commit message.
* Use rta_getattr_uint instead of rta_getattr_u32 for BW_MAX.
* Use "show" instead of "get" to query the shaper details.
* Add net_shaper_scope_names to map scope values to strings.
* Print scope for netshaper show command.
* Handle ID is optional, implement code accordingly.
* Add OPTIONS for Version, Color and Help.
* Change usage() function accordingly for the updated changes.
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
 Makefile              |   2 +-
 man/man8/netshaper.8  | 215 +++++++++++++++++++++++++++++++++
 netshaper/Makefile    |  18 +++
 netshaper/netshaper.c | 270 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 504 insertions(+), 1 deletion(-)
 create mode 100644 man/man8/netshaper.8
 create mode 100644 netshaper/Makefile
 create mode 100644 netshaper/netshaper.c

diff --git a/Makefile b/Makefile
index 2b2c3dec..50545ef6 100644
--- a/Makefile
+++ b/Makefile
@@ -71,7 +71,7 @@ YACCFLAGS = -d -t -v
 
 SUBDIRS=lib ip tc bridge misc netem genl man
 ifeq ($(HAVE_MNL),y)
-SUBDIRS += tipc devlink rdma dcb vdpa
+SUBDIRS += tipc devlink rdma dcb vdpa netshaper
 endif
 
 LIBNETLINK=../lib/libutil.a ../lib/libnetlink.a
diff --git a/man/man8/netshaper.8 b/man/man8/netshaper.8
new file mode 100644
index 00000000..b9fdc0d3
--- /dev/null
+++ b/man/man8/netshaper.8
@@ -0,0 +1,215 @@
+.TH NETSHAPER 8 "7 Oct 2025" "iproute2" "Linux"
+.SH NAME
+netshaper \- show / manipulate network device hardware shaping configuration
+.SH SYNOPSIS
+
+.ad l
+.in +8
+.ti -8
+.B netshaper
+.RI "[ " OPTIONS " ] { " COMMAND " | "
+.BR help " }"
+.sp
+
+.ti -8
+.IR OPTIONS " := { "
+\fB\-V\fR[\fIersion\fR] |
+\fB\-c\fR[\fIolor\fR] |
+\fB\-help\fR }
+
+.ti -8
+.B "netshaper set"
+.B dev
+.IR DEV
+.B handle scope
+.IR HANDLE_SCOPE
+.RI "[ " id
+.IR HANDLE_ID " ]"
+.B bw-max
+.IR BW_MAX
+
+.ti -8
+.B "netshaper" " { " show " | " delete " }"
+.B dev
+.IR DEV
+.B handle scope
+.IR HANDLE_SCOPE
+.RI "[ " id
+.IR HANDLE_ID " ]"
+
+.SH DESCRIPTION
+.B netshaper
+allows configuration and management of hardware rate limiting (shaping) capabilities
+available on network devices. The API provides control over shapers at different levels
+including network devices, queues, and scheduling nodes, enabling manipulation of the
+device's scheduling tree.
+
+Each shaper is uniquely identified within a device by a
+.IR handle ,
+which consists of a
+.I scope
+and an optional
+.IR id .
+Depending on the scope value, shapers are attached to specific hardware objects:
+
+.TP
+.B netdev
+Shapers attached to the entire network device. The
+.I id
+parameter is optional for this scope (defaults to 0 if not specified).
+
+.TP
+.B queue
+Shapers attached to specific device queues. The
+.I id
+parameter is required and specifies the queue number.
+
+.TP
+.B node
+Shapers representing scheduling groups that can be placed at arbitrary
+locations in the scheduling tree. The
+.I id
+parameter is required.
+
+.SH COMMANDS
+
+.SS
+.B netshaper set
+- Create or update a shaper configuration
+
+Creates or updates a shaper with the specified parameters. All parameters except
+.I id
+(for netdev scope) are required.
+
+.SS
+.B netshaper show
+- Display shaper information
+
+Shows the current configuration of the specified shaper, including bandwidth
+limits and device information.
+
+.SS
+.B netshaper delete
+- Remove a shaper configuration
+
+Removes the specified shaper configuration from the device.
+
+.SH PARAMETERS
+
+.TP
+.BI dev " DEV"
+Specifies the network device name on which to operate.
+
+.TP
+.B handle
+Defines the shaper handle consisting of:
+
+.RS
+.TP
+.BI scope " HANDLE_SCOPE"
+The shaper scope, which can be:
+.BR netdev " (device-level shaper), "
+.BR queue " (queue-level shaper), or "
+.BR node " (scheduling node shaper)."
+
+.TP
+.BI id " HANDLE_ID"
+Numeric identifier for the shaper. Optional for
+.B netdev
+scope (defaults to 0), required for
+.B queue
+and
+.B node
+scopes.
+.RE
+
+.TP
+.BI bw-max " BW_MAX"
+Maximum bandwidth limit for the shaper. Accepts values with suffixes:
+.BR kbit ", " mbit ", " gbit
+for kilobits, megabits, and gigabits per second respectively.
+
+.SH OPTIONS
+
+.TP
+.BR \-V ", " \-Version
+Print the version of the
+.B netshaper
+utility and exit.
+
+.TP
+.BR \-c [ color "] = {" always " | " auto " | " never }
+Configure color output. If parameter is omitted or
+.BR always ,
+color output is enabled regardless of stdout state. If parameter is
+.BR auto ,
+stdout is checked to be a terminal before enabling color output. If parameter is
+.BR never ,
+color output is disabled. If specified multiple times, the last one takes
+precedence.
+
+.TP
+.B \-help
+Display usage information and exit.
+
+.SH EXAMPLES
+
+.TP
+.B Example 1: Create a device-level shaper (id optional)
+.nf
+# netshaper set dev foo handle scope netdev bw-max 10gbit
+.fi
+.RS
+Creates a netdev-scoped shaper with default id 0 and sets the maximum
+bandwidth to 10 gigabits per second.
+.RE
+
+.TP
+.B Example 2: Show shaper configuration
+.nf
+# netshaper show dev foo handle scope netdev
+.fi
+.RS
+Display the current shaper configuration for the specified device and handle.
+.RE
+
+.TP
+.B Example 3: Delete shaper configuration
+.nf
+# netshaper delete dev eth0 handle scope netdev
+.fi
+.RS
+Remove the specified shaper configuration.
+.RE
+
+.SH NOTES
+.IP \(bu
+For
+.B netdev
+scope, the
+.I id
+parameter is optional and defaults to 0 if not specified.
+.IP \(bu
+For
+.B queue
+and
+.B node
+scopes, the
+.I id
+parameter is required.
+.IP \(bu
+Bandwidth values support standard suffixes:
+.BR kbit " (kilobits per second), "
+.BR mbit " (megabits per second), "
+.BR gbit " (gigabits per second)."
+.IP \(bu
+This command currently supports basic shaper operations. Additional
+functionality will be added as requirements are identified.
+
+.SH SEE ALSO
+.BR ip (8),
+.BR ip-link (8),
+.BR tc (8)
+
+.SH AUTHOR
+Erni Sri Satya Vennela <ernis@linux.microsoft.com>
diff --git a/netshaper/Makefile b/netshaper/Makefile
new file mode 100644
index 00000000..3b293604
--- /dev/null
+++ b/netshaper/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../config.mk
+
+NSOBJ = netshaper.o
+TARGETS += netshaper
+
+all: $(TARGETS) $(LIBS)
+
+netshaper: $(NSOBJ)
+	$(QUIET_LINK)$(CC) $^ $(LDFLAGS) $(LDLIBS) -o $@
+
+install: all
+	for i in $(TARGETS); \
+	do install -m 0755 $$i $(DESTDIR)$(SBINDIR); \
+	done
+
+clean:
+	rm -f $(NSOBJ) $(TARGETS)
diff --git a/netshaper/netshaper.c b/netshaper/netshaper.c
new file mode 100644
index 00000000..0c725176
--- /dev/null
+++ b/netshaper/netshaper.c
@@ -0,0 +1,270 @@
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
+#include <linux/net_shaper.h>
+#include "version.h"
+#include "utils.h"
+#include "libgenl.h"
+#include "libnetlink.h"
+
+/* netlink socket */
+static struct rtnl_handle gen_rth = { .fd = -1 };
+static int genl_family = -1;
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage: netshaper [ OPTIONS ] { COMMAND | help }\n"
+		"OPTIONS := { -V[ersion] | -c[olor] | -help }\n"
+		"COMMAND := { set | get | delete } dev DEVNAME\n"
+		"	    handle scope HANDLE_SCOPE [id HANDLE_ID]\n"
+		"	    [bw-max BW_MAX]\n"
+		"Where: DEVNAME         := STRING\n"
+		"       HANDLE_SCOPE    := { netdev | queue | node }\n"
+		"       HANDLE_ID       := UINT (required for queue/node, optional for netdev)\n"
+		"       BW_MAX          := UINT{ kbit | mbit | gbit }\n");
+}
+
+static const char *net_shaper_scope_names[NET_SHAPER_SCOPE_MAX + 1] = {
+	"unspec",
+	"netdev",
+	"queue",
+	"node"
+};
+
+static void print_netshaper_attrs(struct nlmsghdr *answer)
+{
+	struct genlmsghdr *ghdr = NLMSG_DATA(answer);
+	int len = answer->nlmsg_len - NLMSG_LENGTH(GENL_HDRLEN);
+	struct rtattr *tb[NET_SHAPER_A_MAX + 1] = {};
+	struct rtattr *handle_tb[NET_SHAPER_A_HANDLE_MAX + 1] = {};
+	__u32 bw_max_mbps, scope, id;
+	__u64 bw_max_bps;
+	int ifindex;
+
+	parse_rtattr_flags(tb, NET_SHAPER_A_MAX,
+			   (struct rtattr *)((char *)ghdr + GENL_HDRLEN),
+			   len, NLA_F_NESTED);
+
+	for (int i = 1; i <= NET_SHAPER_A_MAX; ++i) {
+		if (!tb[i])
+			continue;
+		switch (i) {
+		case NET_SHAPER_A_BW_MAX:
+			bw_max_bps = rta_getattr_uint(tb[i]);
+			bw_max_mbps = (bw_max_bps / 1000000);
+
+			print_uint(PRINT_ANY, "bw-max", "bw-max: %u mbps\n",
+				   bw_max_mbps);
+			break;
+		case NET_SHAPER_A_IFINDEX:
+			ifindex = rta_getattr_u32(tb[i]);
+			print_color_string(PRINT_ANY, COLOR_IFNAME, "dev",
+					   "dev: %s\n",
+					   ll_index_to_name(ifindex));
+			break;
+		case NET_SHAPER_A_HANDLE:
+			parse_rtattr_nested(handle_tb, NET_SHAPER_A_HANDLE_MAX,
+					    tb[NET_SHAPER_A_HANDLE]);
+			if (handle_tb[NET_SHAPER_A_HANDLE_SCOPE]) {
+				scope = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_SCOPE]);
+				print_string(PRINT_ANY, "scope",
+					     "scope: %s\n",
+					     net_shaper_scope_names[scope]);
+			}
+			if (handle_tb[NET_SHAPER_A_HANDLE_ID]) {
+				id = rta_getattr_u32(handle_tb[NET_SHAPER_A_HANDLE_ID]);
+				print_uint(PRINT_ANY, "id", "id: %u\n", id);
+			}
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
+	__u64 bw_max_bps = 0;
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
+		} else if (strcmp(*argv, "bw-max") == 0) {
+			NEXT_ARG();
+			if (get_rate64(&bw_max_bps, *argv)) {
+				fprintf(stderr, "Invalid bw-max value\n");
+				return -1;
+			}
+			/* Convert Bps to bps */
+			bw_max_bps *= 8;
+		} else if (strcmp(*argv, "handle") == 0) {
+			handle_present = true;
+			NEXT_ARG();
+
+			if (strcmp(*argv, "scope") != 0) {
+				fprintf(stderr, "What is \"%s\"\n", *argv);
+				usage();
+				return -1;
+			}
+			NEXT_ARG();
+
+			if (strcmp(*argv, "netdev") == 0) {
+				handle_scope = NET_SHAPER_SCOPE_NETDEV;
+				/* For netdev scope, id is optional - check if next arg is "id" */
+				if (argc > 1 && strcmp(argv[1], "id") == 0) {
+					NEXT_ARG(); /* move to "id" */
+					NEXT_ARG(); /* move to id value */
+					if (get_unsigned(&handle_id, *argv, 10)) {
+						fprintf(stderr, "Invalid handle id\n");
+						return -1;
+					}
+				}
+			} else if (strcmp(*argv, "queue") == 0) {
+				handle_scope = NET_SHAPER_SCOPE_QUEUE;
+				/* For queue scope, id is required */
+				NEXT_ARG();
+				if (strcmp(*argv, "id") != 0) {
+					fprintf(stderr, "What is \"%s\"\n", *argv);
+					usage();
+					return -1;
+				}
+				NEXT_ARG();
+				if (get_unsigned(&handle_id, *argv, 10)) {
+					fprintf(stderr, "Invalid handle id\n");
+					return -1;
+				}
+			} else if (strcmp(*argv, "node") == 0) {
+				handle_scope = NET_SHAPER_SCOPE_NODE;
+				/* For node scope, id is required */
+				NEXT_ARG();
+				if (strcmp(*argv, "id") != 0) {
+					fprintf(stderr, "What is \"%s\"\n", *argv);
+					usage();
+					return -1;
+				}
+				NEXT_ARG();
+				if (get_unsigned(&handle_id, *argv, 10)) {
+					fprintf(stderr, "Invalid handle id\n");
+					return -1;
+				}
+			} else {
+				fprintf(stderr, "Invalid scope\n");
+				return -1;
+			}
+		} else {
+			fprintf(stderr, "What is \"%s\"\n", *argv);
+			usage();
+			return -1;
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
+	if (cmd == NET_SHAPER_CMD_SET && bw_max_bps == 0)
+		missarg("bw-max");
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
+		addattr64(&req.n, sizeof(req), NET_SHAPER_A_BW_MAX, bw_max_bps);
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
+int main(int argc, char **argv)
+{
+	struct nlmsghdr *n;
+	int color = default_color_opt();
+
+	while (argc > 1) {
+		const char *opt = argv[1];
+
+		if (opt[0] != '-')
+			break;
+		if (opt[1] == '-')
+			opt++;
+
+		if (strcmp(opt, "-help") == 0) {
+			usage();
+			exit(0);
+		} else if (strcmp(opt, "-Version") == 0 ||
+			   strcmp(opt, "-V") == 0) {
+			printf("netshaper utility, %s\n", version);
+			exit(0);
+		} else if (matches_color(opt, &color)) {
+		} else {
+			fprintf(stderr,
+				"Option \"%s\" is unknown, try \"netshaper help\".\n",
+				opt);
+			exit(-1);
+		}
+		argc--; argv++;
+	}
+
+	check_enable_color(color, 0);
+
+	if (genl_init_handle(&gen_rth, NET_SHAPER_FAMILY_NAME, &genl_family))
+		exit(1);
+
+	if (argc > 1) {
+		argc--;
+		argv++;
+
+		if (strcmp(*argv, "set") == 0)
+			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_SET);
+		if (strcmp(*argv, "delete") == 0)
+			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_DELETE);
+		if (strcmp(*argv, "show") == 0)
+			return do_cmd(argc - 1, argv + 1, n, NET_SHAPER_CMD_GET);
+		if (strcmp(*argv, "help") == 0) {
+			usage();
+			return 0;
+		}
+		fprintf(stderr,
+			"Command \"%s\" is unknown, try \"netshaper help\".\n",
+			*argv);
+		exit(-1);
+	}
+	usage();
+	exit(-1);
+}
-- 
2.34.1


