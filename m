Return-Path: <netdev+bounces-180533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E22A8199E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF6127B480E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53881732;
	Wed,  9 Apr 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5oGfP1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A07D07D
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157072; cv=none; b=dPqoe+Ku68ZthN+QAxyen6qHXXyLViGsXmbpnjVk0zLQCP9kaQWlq5kEvK38arv5YX2MB9Qs3ki2aOTGZCNxdPozDXC9Wyd20b0NcPQzcVxUBYrMMdtE2vo38vGOukLQaz0v7vSZb7wKGYSYRSiwd5tgOedyR9RoRO/4kBug4cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157072; c=relaxed/simple;
	bh=LT5cBqZZGmg/Lie2cBLWEuIIWRsf57T0Vjd0+4sQd+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/zMGdbzLv5Qf/djR3RrhrhsmZbpaSOeOQE8MTxSMV7jruZqgjJRq4AmKP4eV8BKe6kipJqJGBlFFb5nz72j29Bn17e5iL8MYIZg2mCOBdDjJodtflRzRmmAzT5WumvsAH7+xCHIgNivEzbWwlB8pegRfrJ2QXRNNB+Pxg2ZppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5oGfP1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A48C4CEE9;
	Wed,  9 Apr 2025 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157072;
	bh=LT5cBqZZGmg/Lie2cBLWEuIIWRsf57T0Vjd0+4sQd+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b5oGfP1ZNRiOpTUhhdBbvXsy15q9nwFJSZ0VEGTQkUTLCPa+kigt0/EIEOWQaHi7u
	 RezwtEJueNVstQuJU+wWhYyD6SaA+lIyOMxO1i9aaimpesNLO8WiLWJQzNtJp4WFhH
	 vaNuu3v/IYtWVIAgJRyDgG5EZxstkpQctEOdYIubqxq9RaNZCz7342TIvyozQb9cxo
	 hr/csVq0P5Ev9nHoivGFnD9gGl4Sv7LAHxppgEFbMkHV2RBP9sfRYDPq4GgObA4rY3
	 3Dy/qwqdPICgICO/9MBF8iBKsY9lkcJ0qq2GE8uEzBH31EOWc6YKuoMccr2Og/f88C
	 7t8Bmte/0DUSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	yuyanghuang@google.com,
	sdf@fomichev.me,
	gnault@redhat.com,
	nicolas.dichtel@6wind.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 13/13] tools: ynl: generate code for rt-route and add a sample
Date: Tue,  8 Apr 2025 17:04:00 -0700
Message-ID: <20250409000400.492371-14-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409000400.492371-1-kuba@kernel.org>
References: <20250409000400.492371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YNL C can now generate code for simple classic netlink families.
Include rt-route in the Makefile for generation and add a sample.

    $ ./tools/net/ynl/samples/rt-route
    oif: wlp0s20f3        gateway: 192.168.1.1
    oif: wlp0s20f3        dst: 192.168.1.0/24
    oif: vpn0             dst: fe80::/64
    oif: wlp0s20f3        dst: fe80::/64
    oif: wlp0s20f3        gateway: fe80::200:5eff:fe00:201

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps      |  1 +
 tools/net/ynl/generated/Makefile |  2 +-
 tools/net/ynl/samples/rt-route.c | 80 ++++++++++++++++++++++++++++++++
 tools/net/ynl/samples/.gitignore |  1 +
 4 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/samples/rt-route.c

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index e55d94211df6..385783489f84 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -30,4 +30,5 @@ CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 67ce3b8988ef..6603ad8d4ce1 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -25,7 +25,7 @@ SPECS_DIR:=../../../../Documentation/netlink/specs
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
 		$(SPECS_DIR))
-GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr
+GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr rt-route
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
diff --git a/tools/net/ynl/samples/rt-route.c b/tools/net/ynl/samples/rt-route.c
new file mode 100644
index 000000000000..9d9c868f8873
--- /dev/null
+++ b/tools/net/ynl/samples/rt-route.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+
+#include <ynl.h>
+
+#include <arpa/inet.h>
+#include <net/if.h>
+
+#include "rt-route-user.h"
+
+static void rt_route_print(struct rt_route_getroute_rsp *r)
+{
+	char ifname[IF_NAMESIZE];
+	char route_str[64];
+	const char *route;
+	const char *name;
+
+	/* Ignore local */
+	if (r->_hdr.rtm_table == RT_TABLE_LOCAL)
+		return;
+
+	if (r->_present.oif) {
+		name = if_indextoname(r->oif, ifname);
+		if (name)
+			printf("oif: %-16s ", name);
+	}
+
+	if (r->_present.dst_len) {
+		route = inet_ntop(r->_hdr.rtm_family, r->dst,
+				  route_str, sizeof(route_str));
+		printf("dst: %s/%d", route, r->_hdr.rtm_dst_len);
+	}
+
+	if (r->_present.gateway_len) {
+		route = inet_ntop(r->_hdr.rtm_family, r->gateway,
+				  route_str, sizeof(route_str));
+		printf("gateway: %s ", route);
+	}
+
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct rt_route_getroute_req_dump *req;
+	struct rt_route_getroute_list *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_rt_route_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = rt_route_getroute_req_dump_alloc();
+	if (!req)
+		goto err_destroy;
+
+	rsp = rt_route_getroute_dump(ys, req);
+	rt_route_getroute_req_dump_free(req);
+	if (!rsp)
+		goto err_close;
+
+	if (ynl_dump_empty(rsp))
+		fprintf(stderr, "Error: no routeesses reported\n");
+	ynl_dump_foreach(rsp, route)
+		rt_route_print(route);
+	rt_route_getroute_list_free(rsp);
+
+	ynl_sock_destroy(ys);
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL: %s\n", ys->err.msg);
+err_destroy:
+	ynl_sock_destroy(ys);
+	return 2;
+}
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 2bc8721d6144..7f9781cf532f 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -4,3 +4,4 @@ netdev
 ovs
 page-pool
 rt-addr
+rt-route
-- 
2.49.0


