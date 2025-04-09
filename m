Return-Path: <netdev+bounces-180534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F1A8199C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 02:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA80B1900397
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D514C9D;
	Wed,  9 Apr 2025 00:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtijSyT8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807357DA9C
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744157072; cv=none; b=YoHyKAU6JjLp91yHpQ+pyDtpKmyqteSod5u+LCwRYfEhQ7/BGsLV54h0bep3YG8Ylgh6AdHPq5zqQWmhggEK6DRD4i4cGEWTTiUI2A/cqriqlSaAAxh2rRrgrJIBTjXrFkUefTUm+YDij/rea3XYuj80bgqLuobV1M5jpCIrOck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744157072; c=relaxed/simple;
	bh=gz9XjmE7oCz0sdEkzWrtp96K3Ioe3p5qbRM3oRezMwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVgj5xzj1v/dB7A7/8VdEU1mK+3C8JUKIvB9pjjzbevOaTtrHDye/jyOva19mkX6+AJFY1apbYm8ALX9wMPrIN9FjiInr0CxQBfoU4yFeYT9ZaKWZBLVrYWeTaRnxUR6bhyKP6ONeArKyAoKLXZSZAiOI2tVewcJ1r5QeORt978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtijSyT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F12AC4CEE5;
	Wed,  9 Apr 2025 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744157071;
	bh=gz9XjmE7oCz0sdEkzWrtp96K3Ioe3p5qbRM3oRezMwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtijSyT8l2g6pQuwSpYe+HWdtCVJS09aWCE5t5UXinvkueATaY0SdDi2gpOOkDr6G
	 F9cnmr21uZ7uudf2dTQ/M6j5cCyPWgDI7+RM9JOCyTnQ3AgSUCLLnvwvS7Toppq1Ui
	 w/PPaYv7H5ekboSYekqU9wx9r9AwOuIlGDBl+M66/trZQ9PO7L77ZRi849VYhTMqJh
	 IXLnwJCSgVBpp6hchbXnIrsf8130XLN6IcoqMhyyPspT20I2Fkr8+n/VbIs5bEQ2Ey
	 /qWP1/ShpXyCZ5Idt7Gex4pTTBBTHH0l0l/Q8Vxnjbegc48oei6gNZHinIEXYXIiV5
	 cHAvwmNqYMc7Q==
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
Subject: [PATCH net-next 12/13] tools: ynl: generate code for rt-addr and add a sample
Date: Tue,  8 Apr 2025 17:03:59 -0700
Message-ID: <20250409000400.492371-13-kuba@kernel.org>
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
Include rt-addr in the Makefile for generation and add a sample.

  $ ./tools/net/ynl/samples/rt-addr
              lo: 127.0.0.1
       wlp0s20f3: 192.168.1.101
              lo: ::
       wlp0s20f3: fe80::6385:be6:746e:8116
            vpn0: fe80::3597:d353:b5a7:66dd

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/Makefile.deps      |  1 +
 tools/net/ynl/generated/Makefile |  2 +-
 tools/net/ynl/samples/rt-addr.c  | 80 ++++++++++++++++++++++++++++++++
 tools/net/ynl/samples/.gitignore |  3 +-
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tools/net/ynl/samples/rt-addr.c

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f3269ce39e5b..e55d94211df6 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -29,4 +29,5 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 21f9e299dc75..67ce3b8988ef 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -25,7 +25,7 @@ SPECS_DIR:=../../../../Documentation/netlink/specs
 GENS_PATHS=$(shell grep -nrI --files-without-match \
 		'protocol: netlink' \
 		$(SPECS_DIR))
-GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS})
+GENS=$(patsubst $(SPECS_DIR)/%.yaml,%,${GENS_PATHS}) rt-addr
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
diff --git a/tools/net/ynl/samples/rt-addr.c b/tools/net/ynl/samples/rt-addr.c
new file mode 100644
index 000000000000..c9a6436ad420
--- /dev/null
+++ b/tools/net/ynl/samples/rt-addr.c
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
+#include "rt-addr-user.h"
+
+static void rt_addr_print(struct rt_addr_getaddr_rsp *a, unsigned int op)
+{
+	char ifname[IF_NAMESIZE];
+	char addr_str[64];
+	const char *addr;
+	const char *name;
+
+	name = if_indextoname(a->_hdr.ifa_index, ifname);
+	if (name)
+		printf("%16s: ", name);
+
+	switch (a->_present.address_len) {
+	case 4:
+		addr = inet_ntop(AF_INET, a->address,
+				 addr_str, sizeof(addr_str));
+		break;
+	case 16:
+		addr = inet_ntop(AF_INET6, a->address,
+				 addr_str, sizeof(addr_str));
+		break;
+	default:
+		addr = NULL;
+		break;
+	}
+	if (addr)
+		printf("%s", addr);
+	else
+		printf("[%d]", a->_present.address_len);
+
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct rt_addr_getaddr_list *rsp;
+	struct rt_addr_getaddr_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	ys = ynl_sock_create(&ynl_rt_addr_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 1;
+	}
+
+	req = rt_addr_getaddr_req_alloc();
+	if (!req)
+		goto err_destroy;
+
+	rsp = rt_addr_getaddr_dump(ys, req);
+	rt_addr_getaddr_req_free(req);
+	if (!rsp)
+		goto err_close;
+
+	if (ynl_dump_empty(rsp))
+		fprintf(stderr, "Error: no addresses reported\n");
+	ynl_dump_foreach(rsp, addr)
+		rt_addr_print(addr, 0);
+	rt_addr_getaddr_list_free(rsp);
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
index dda6686257a7..2bc8721d6144 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -2,4 +2,5 @@ ethtool
 devlink
 netdev
 ovs
-page-pool
\ No newline at end of file
+page-pool
+rt-addr
-- 
2.49.0


