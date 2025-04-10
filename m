Return-Path: <netdev+bounces-180999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7BA835F0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A178464D63
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123D1DF982;
	Thu, 10 Apr 2025 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgkbVSP5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAE1DF973
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744249638; cv=none; b=aoy/NzIFwGurrK+wo5/AEANAS24N0z00giNuwjXhVWBHdCnJvgUTxGF1nClnS+bFYhJHCaoZ3gIuMhRfPkVbgDSr+HFtk2dhDizk+pKT90G4eU8iqjgPqkT+DqzRUOgNTq/8XGnaFpHyFizUQmd5j4g0jgAO1JWKh180RT3NnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744249638; c=relaxed/simple;
	bh=p6OG45eZW9xVoj443TyPkhzJZpsMpPU+kIvOBu9VXAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrh+UBJ4JIfab/XbJ0pBkLFxwrEl9OATWzeout59LObu0JcOY8+xJI61UVWMEZG3XGVjbDVg49RD3PTwGHgjYwn0rxOWmRSv1MsouuHcohtysjmgzyv+wPhHU5MZOS5/qeRhV+XQPNuSi7kANYGAxwxG656JfFJQQRVU+wWVZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgkbVSP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D742C4CEEE;
	Thu, 10 Apr 2025 01:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744249637;
	bh=p6OG45eZW9xVoj443TyPkhzJZpsMpPU+kIvOBu9VXAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgkbVSP5WeHvEgAXIYjMX//BNlspXvUTWyUZfbihWM0ibbOM+LqiZx67ZEmukSjgu
	 Rfh2Zjfce8z+msBeKkm5+A3rzHk1tfU/JGvEdtG60dqkHgj3B/HLsDwvtfBD770vDT
	 o2kyTaufWfQWciBvF+tXZePZe4ReYcw9tLzl15DhOuk/KSqZgDQgtwtjC79V1DoW8s
	 yPQbBW/1wQCA+jikQIvdlOLRnS9e/See7j1AAcYkxSHX//vvDZfsGN73tgaZ6aC9Ed
	 M8jGnb88/UEMUEDC0TG34BoSf7keRkGOO009c+MFQUVJ655+NNzXHiRzMi1V9bc/oS
	 m0kjaRdo+WN9Q==
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
Subject: [PATCH net-next v2 12/13] tools: ynl: generate code for rt-addr and add a sample
Date: Wed,  9 Apr 2025 18:46:57 -0700
Message-ID: <20250410014658.782120-13-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410014658.782120-1-kuba@kernel.org>
References: <20250410014658.782120-1-kuba@kernel.org>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: remove unused function argument
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
index 000000000000..0f4851b4ec57
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
+static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
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
+		rt_addr_print(addr);
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


