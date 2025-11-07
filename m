Return-Path: <netdev+bounces-236863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671CC40DDE
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4273AE631
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E982857FA;
	Fri,  7 Nov 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnMAStUs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FF2848AF
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532589; cv=none; b=SNh0NGXOrmgayPsnLQlQHu7q0ZcLk8PChQIE+WsKPRqMI+pVp9GcMoNU4mlt24G3JI0aO1Q4TbKUh94Bl8fXCoquD3FdMTHALpO+GcTyuXxB8qFqZffaVs1WvxLk5w8t/LT3aJtXmbOEnZuMCPkXWr/p3BMvOEBR7bxRywdXuTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532589; c=relaxed/simple;
	bh=+qOxixlBSd86CxlW+3JAp+Lecxrg81teBuenFPISaHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZSYMLDkEi4waS7fULz89lfjgrTV/YDBhMZYqqYT3Wod7P24Vi4ovwmJQe/xfORsIeL1Y5dgJGc5LdCSSRiXQQP3HnA06Knxty2qLUIcl12F11XEsKgWzP3Lqj17inl4oUGbQj9DeWr12eiowsIwUb9gW29qfAuSbhygEQ6yXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnMAStUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1BFC116B1;
	Fri,  7 Nov 2025 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532588;
	bh=+qOxixlBSd86CxlW+3JAp+Lecxrg81teBuenFPISaHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnMAStUswvhe0Cm7Lw2+v4cHgT+BMWdUXIgOj8FL/a7xYHJqXDEEAWoLCZfIY6TJ6
	 MKIy+XbECdspF/T5Rg8Pz3VEGDpBMTRecEOFF6DlJZ0pYLxHkYW1JqfPtKd2sB0kn1
	 QQcjs5D7pVlbi2KNCS76F5yFC5WferyVWxyKdTjn3qw/6jJf5G6qkRRn79fBbBbtuB
	 wqW4Cin63wUiuYKj4P3lg19HNyspSgjWIsR5O2LboMoYproaZKWQ37/guiPlptl5Hs
	 6eGjVBNOUymE5yQIv+73F+FWUncvJRUQVKj36nRxRYN1VCCpWWnR5kVkf/GICmrhRW
	 obkkAJDj9TxaA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	joe@dama.to,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/4] tools: ynltool: add qstats support
Date: Fri,  7 Nov 2025 08:22:26 -0800
Message-ID: <20251107162227.980672-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107162227.980672-1-kuba@kernel.org>
References: <20251107162227.980672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  $ ynltool qstat
  eth0        rx-packets:       493192163        rx-bytes:   1442544543997
              tx-packets:       745999838        tx-bytes:   4574215826482
                 tx-stop:            7033         tx-wake:            7033

  $ ynltool qstat show group-by queue
  eth0  rx-0     packets:        70196880           bytes:    178633973750
  eth0  rx-1     packets:        63623419           bytes:    197274745250
  ...
  eth0  tx-1     packets:        98645810           bytes:    631247647938
                    stop:            1048            wake:            1048
  eth0  tx-2     packets:        86775824           bytes:    563930471952
                    stop:            1126            wake:            1126
  ...

  $ ynltool -j qstat  | jq
  [
   {
    "ifname": "eth0",
    "ifindex": 2,
    "rx": {
      "packets": 493396439,
      "bytes": 1443608198921
    },
    "tx": {
      "packets": 746239978,
      "bytes": 4574333772645,
      "stop": 7072,
      "wake": 7072
    }
   }
  ]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynltool/main.h   |   1 +
 tools/net/ynl/ynltool/main.c   |   3 +-
 tools/net/ynl/ynltool/qstats.c | 330 +++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/ynltool/qstats.c

diff --git a/tools/net/ynl/ynltool/main.h b/tools/net/ynl/ynltool/main.h
index fd05d21451a2..c7039f9ac55a 100644
--- a/tools/net/ynl/ynltool/main.h
+++ b/tools/net/ynl/ynltool/main.h
@@ -61,5 +61,6 @@ int cmd_select(const struct cmd *cmds, int argc, char **argv,
 
 /* subcommands */
 int do_page_pool(int argc, char **argv);
+int do_qstats(int argc, char **argv);
 
 #endif /* __YNLTOOL_H */
diff --git a/tools/net/ynl/ynltool/main.c b/tools/net/ynl/ynltool/main.c
index f83c6f3245c8..5d0f428eed0a 100644
--- a/tools/net/ynl/ynltool/main.c
+++ b/tools/net/ynl/ynltool/main.c
@@ -47,7 +47,7 @@ static int do_help(int argc __attribute__((unused)),
 		"Usage: %s [OPTIONS] OBJECT { COMMAND | help }\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { page-pool }\n"
+		"       OBJECT := { page-pool | qstats }\n"
 		"       " HELP_SPEC_OPTIONS "\n"
 		"",
 		bin_name, bin_name);
@@ -72,6 +72,7 @@ static int do_version(int argc __attribute__((unused)),
 static const struct cmd commands[] = {
 	{ "help",	do_help },
 	{ "page-pool",	do_page_pool },
+	{ "qstats",	do_qstats },
 	{ "version",	do_version },
 	{ 0 }
 };
diff --git a/tools/net/ynl/ynltool/qstats.c b/tools/net/ynl/ynltool/qstats.c
new file mode 100644
index 000000000000..fcdbb6d9a852
--- /dev/null
+++ b/tools/net/ynl/ynltool/qstats.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <net/if.h>
+
+#include <ynl.h>
+#include "netdev-user.h"
+
+#include "main.h"
+
+static enum netdev_qstats_scope scope; /* default - device */
+
+static void print_json_qstats(struct netdev_qstats_get_list *qstats)
+{
+	jsonw_start_array(json_wtr);
+
+	ynl_dump_foreach(qstats, qs) {
+		char ifname[IF_NAMESIZE];
+		const char *name;
+
+		jsonw_start_object(json_wtr);
+
+		name = if_indextoname(qs->ifindex, ifname);
+		if (name)
+			jsonw_string_field(json_wtr, "ifname", name);
+		jsonw_uint_field(json_wtr, "ifindex", qs->ifindex);
+
+		if (qs->_present.queue_type)
+			jsonw_string_field(json_wtr, "queue-type",
+					   netdev_queue_type_str(qs->queue_type));
+		if (qs->_present.queue_id)
+			jsonw_uint_field(json_wtr, "queue-id", qs->queue_id);
+
+		if (qs->_present.rx_packets || qs->_present.rx_bytes ||
+		    qs->_present.rx_alloc_fail || qs->_present.rx_hw_drops ||
+		    qs->_present.rx_csum_complete || qs->_present.rx_hw_gro_packets) {
+			jsonw_name(json_wtr, "rx");
+			jsonw_start_object(json_wtr);
+			if (qs->_present.rx_packets)
+				jsonw_uint_field(json_wtr, "packets", qs->rx_packets);
+			if (qs->_present.rx_bytes)
+				jsonw_uint_field(json_wtr, "bytes", qs->rx_bytes);
+			if (qs->_present.rx_alloc_fail)
+				jsonw_uint_field(json_wtr, "alloc-fail", qs->rx_alloc_fail);
+			if (qs->_present.rx_hw_drops)
+				jsonw_uint_field(json_wtr, "hw-drops", qs->rx_hw_drops);
+			if (qs->_present.rx_hw_drop_overruns)
+				jsonw_uint_field(json_wtr, "hw-drop-overruns", qs->rx_hw_drop_overruns);
+			if (qs->_present.rx_hw_drop_ratelimits)
+				jsonw_uint_field(json_wtr, "hw-drop-ratelimits", qs->rx_hw_drop_ratelimits);
+			if (qs->_present.rx_csum_complete)
+				jsonw_uint_field(json_wtr, "csum-complete", qs->rx_csum_complete);
+			if (qs->_present.rx_csum_unnecessary)
+				jsonw_uint_field(json_wtr, "csum-unnecessary", qs->rx_csum_unnecessary);
+			if (qs->_present.rx_csum_none)
+				jsonw_uint_field(json_wtr, "csum-none", qs->rx_csum_none);
+			if (qs->_present.rx_csum_bad)
+				jsonw_uint_field(json_wtr, "csum-bad", qs->rx_csum_bad);
+			if (qs->_present.rx_hw_gro_packets)
+				jsonw_uint_field(json_wtr, "hw-gro-packets", qs->rx_hw_gro_packets);
+			if (qs->_present.rx_hw_gro_bytes)
+				jsonw_uint_field(json_wtr, "hw-gro-bytes", qs->rx_hw_gro_bytes);
+			if (qs->_present.rx_hw_gro_wire_packets)
+				jsonw_uint_field(json_wtr, "hw-gro-wire-packets", qs->rx_hw_gro_wire_packets);
+			if (qs->_present.rx_hw_gro_wire_bytes)
+				jsonw_uint_field(json_wtr, "hw-gro-wire-bytes", qs->rx_hw_gro_wire_bytes);
+			jsonw_end_object(json_wtr);
+		}
+
+		if (qs->_present.tx_packets || qs->_present.tx_bytes ||
+		    qs->_present.tx_hw_drops || qs->_present.tx_csum_none ||
+		    qs->_present.tx_hw_gso_packets) {
+			jsonw_name(json_wtr, "tx");
+			jsonw_start_object(json_wtr);
+			if (qs->_present.tx_packets)
+				jsonw_uint_field(json_wtr, "packets", qs->tx_packets);
+			if (qs->_present.tx_bytes)
+				jsonw_uint_field(json_wtr, "bytes", qs->tx_bytes);
+			if (qs->_present.tx_hw_drops)
+				jsonw_uint_field(json_wtr, "hw-drops", qs->tx_hw_drops);
+			if (qs->_present.tx_hw_drop_errors)
+				jsonw_uint_field(json_wtr, "hw-drop-errors", qs->tx_hw_drop_errors);
+			if (qs->_present.tx_hw_drop_ratelimits)
+				jsonw_uint_field(json_wtr, "hw-drop-ratelimits", qs->tx_hw_drop_ratelimits);
+			if (qs->_present.tx_csum_none)
+				jsonw_uint_field(json_wtr, "csum-none", qs->tx_csum_none);
+			if (qs->_present.tx_needs_csum)
+				jsonw_uint_field(json_wtr, "needs-csum", qs->tx_needs_csum);
+			if (qs->_present.tx_hw_gso_packets)
+				jsonw_uint_field(json_wtr, "hw-gso-packets", qs->tx_hw_gso_packets);
+			if (qs->_present.tx_hw_gso_bytes)
+				jsonw_uint_field(json_wtr, "hw-gso-bytes", qs->tx_hw_gso_bytes);
+			if (qs->_present.tx_hw_gso_wire_packets)
+				jsonw_uint_field(json_wtr, "hw-gso-wire-packets", qs->tx_hw_gso_wire_packets);
+			if (qs->_present.tx_hw_gso_wire_bytes)
+				jsonw_uint_field(json_wtr, "hw-gso-wire-bytes", qs->tx_hw_gso_wire_bytes);
+			if (qs->_present.tx_stop)
+				jsonw_uint_field(json_wtr, "stop", qs->tx_stop);
+			if (qs->_present.tx_wake)
+				jsonw_uint_field(json_wtr, "wake", qs->tx_wake);
+			jsonw_end_object(json_wtr);
+		}
+
+		jsonw_end_object(json_wtr);
+	}
+
+	jsonw_end_array(json_wtr);
+}
+
+static void print_one(bool present, const char *name, unsigned long long val,
+		      int *line)
+{
+	if (!present)
+		return;
+
+	if (!*line) {
+		printf("              ");
+		++(*line);
+	}
+
+	/* Don't waste space on tx- and rx- prefix, its implied by queue type */
+	if (scope == NETDEV_QSTATS_SCOPE_QUEUE &&
+	    (name[0] == 'r' || name[0] == 't') &&
+	    name[1] == 'x' && name[2] == '-')
+		name += 3;
+
+	printf(" %15s: %15llu", name, val);
+
+	if (++(*line) == 3) {
+		printf("\n");
+		*line = 0;
+	}
+}
+
+static void print_plain_qstats(struct netdev_qstats_get_list *qstats)
+{
+	ynl_dump_foreach(qstats, qs) {
+		char ifname[IF_NAMESIZE];
+		const char *name;
+		int n;
+
+		name = if_indextoname(qs->ifindex, ifname);
+		if (name)
+			printf("%s", name);
+		else
+			printf("ifindex:%u", qs->ifindex);
+
+		if (qs->_present.queue_type && qs->_present.queue_id)
+			printf("\t%s-%-3u",
+			       netdev_queue_type_str(qs->queue_type),
+			       qs->queue_id);
+		else
+			printf("\t      ");
+
+		n = 1;
+
+		/* Basic counters */
+		print_one(qs->_present.rx_packets, "rx-packets", qs->rx_packets, &n);
+		print_one(qs->_present.rx_bytes, "rx-bytes", qs->rx_bytes, &n);
+		print_one(qs->_present.tx_packets, "tx-packets", qs->tx_packets, &n);
+		print_one(qs->_present.tx_bytes, "tx-bytes", qs->tx_bytes, &n);
+
+		/* RX error/drop counters */
+		print_one(qs->_present.rx_alloc_fail, "rx-alloc-fail",
+			  qs->rx_alloc_fail, &n);
+		print_one(qs->_present.rx_hw_drops, "rx-hw-drops",
+			  qs->rx_hw_drops, &n);
+		print_one(qs->_present.rx_hw_drop_overruns, "rx-hw-drop-overruns",
+			  qs->rx_hw_drop_overruns, &n);
+		print_one(qs->_present.rx_hw_drop_ratelimits, "rx-hw-drop-ratelimits",
+			  qs->rx_hw_drop_ratelimits, &n);
+
+		/* RX checksum counters */
+		print_one(qs->_present.rx_csum_complete, "rx-csum-complete",
+			  qs->rx_csum_complete, &n);
+		print_one(qs->_present.rx_csum_unnecessary, "rx-csum-unnecessary",
+			  qs->rx_csum_unnecessary, &n);
+		print_one(qs->_present.rx_csum_none, "rx-csum-none",
+			  qs->rx_csum_none, &n);
+		print_one(qs->_present.rx_csum_bad, "rx-csum-bad",
+			  qs->rx_csum_bad, &n);
+
+		/* RX GRO counters */
+		print_one(qs->_present.rx_hw_gro_packets, "rx-hw-gro-packets",
+			  qs->rx_hw_gro_packets, &n);
+		print_one(qs->_present.rx_hw_gro_bytes, "rx-hw-gro-bytes",
+			  qs->rx_hw_gro_bytes, &n);
+		print_one(qs->_present.rx_hw_gro_wire_packets, "rx-hw-gro-wire-packets",
+			  qs->rx_hw_gro_wire_packets, &n);
+		print_one(qs->_present.rx_hw_gro_wire_bytes, "rx-hw-gro-wire-bytes",
+			  qs->rx_hw_gro_wire_bytes, &n);
+
+		/* TX error/drop counters */
+		print_one(qs->_present.tx_hw_drops, "tx-hw-drops",
+			  qs->tx_hw_drops, &n);
+		print_one(qs->_present.tx_hw_drop_errors, "tx-hw-drop-errors",
+			  qs->tx_hw_drop_errors, &n);
+		print_one(qs->_present.tx_hw_drop_ratelimits, "tx-hw-drop-ratelimits",
+			  qs->tx_hw_drop_ratelimits, &n);
+
+		/* TX checksum counters */
+		print_one(qs->_present.tx_csum_none, "tx-csum-none",
+			  qs->tx_csum_none, &n);
+		print_one(qs->_present.tx_needs_csum, "tx-needs-csum",
+			  qs->tx_needs_csum, &n);
+
+		/* TX GSO counters */
+		print_one(qs->_present.tx_hw_gso_packets, "tx-hw-gso-packets",
+			  qs->tx_hw_gso_packets, &n);
+		print_one(qs->_present.tx_hw_gso_bytes, "tx-hw-gso-bytes",
+			  qs->tx_hw_gso_bytes, &n);
+		print_one(qs->_present.tx_hw_gso_wire_packets, "tx-hw-gso-wire-packets",
+			  qs->tx_hw_gso_wire_packets, &n);
+		print_one(qs->_present.tx_hw_gso_wire_bytes, "tx-hw-gso-wire-bytes",
+			  qs->tx_hw_gso_wire_bytes, &n);
+
+		/* TX queue control */
+		print_one(qs->_present.tx_stop, "tx-stop", qs->tx_stop, &n);
+		print_one(qs->_present.tx_wake, "tx-wake", qs->tx_wake, &n);
+
+		if (n)
+			printf("\n");
+	}
+}
+
+static int do_show(int argc, char **argv)
+{
+	struct netdev_qstats_get_list *qstats;
+	struct netdev_qstats_get_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret = 0;
+
+	/* Parse options */
+	while (argc > 0) {
+		if (is_prefix(*argv, "scope") || is_prefix(*argv, "group-by")) {
+			NEXT_ARG();
+
+			if (!REQ_ARGS(1))
+				return -1;
+
+			if (is_prefix(*argv, "queue")) {
+				scope = NETDEV_QSTATS_SCOPE_QUEUE;
+			} else if (is_prefix(*argv, "device")) {
+				scope = 0;
+			} else {
+				p_err("invalid scope value '%s'", *argv);
+				return -1;
+			}
+			NEXT_ARG();
+		} else {
+			p_err("unknown option '%s'", *argv);
+			return -1;
+		}
+	}
+
+	ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!ys) {
+		p_err("YNL: %s", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_qstats_get_req_alloc();
+	if (!req) {
+		p_err("failed to allocate qstats request");
+		ret = -1;
+		goto exit_close;
+	}
+
+	if (scope)
+		netdev_qstats_get_req_set_scope(req, scope);
+
+	qstats = netdev_qstats_get_dump(ys, req);
+	netdev_qstats_get_req_free(req);
+	if (!qstats) {
+		p_err("failed to get queue stats: %s", ys->err.msg);
+		ret = -1;
+		goto exit_close;
+	}
+
+	/* Print the stats as returned by the kernel */
+	if (json_output)
+		print_json_qstats(qstats);
+	else
+		print_plain_qstats(qstats);
+
+	netdev_qstats_get_list_free(qstats);
+exit_close:
+	ynl_sock_destroy(ys);
+	return ret;
+}
+
+static int do_help(int argc __attribute__((unused)),
+		   char **argv __attribute__((unused)))
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %s qstats { COMMAND | help }\n"
+		"       %s qstats [ show ] [ OPTIONS ]\n"
+		"\n"
+		"       OPTIONS := { scope queue | group-by { device | queue } }\n"
+		"\n"
+		"       show                  - Display queue statistics (default)\n"
+		"                               Statistics are aggregated for the entire device.\n"
+		"       show scope queue      - Display per-queue statistics\n"
+		"       show group-by device  - Display device-aggregated statistics (default)\n"
+		"       show group-by queue   - Display per-queue statistics\n"
+		"",
+		bin_name, bin_name);
+
+	return 0;
+}
+
+static const struct cmd qstats_cmds[] = {
+	{ "show",	do_show },
+	{ "help",	do_help },
+	{ 0 }
+};
+
+int do_qstats(int argc, char **argv)
+{
+	return cmd_select(qstats_cmds, argc, argv, do_help);
+}
-- 
2.51.1


