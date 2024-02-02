Return-Path: <netdev+bounces-68254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B151846525
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 01:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13F7B21A07
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 00:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2345C85;
	Fri,  2 Feb 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXeR8MHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D163AA
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706834985; cv=none; b=O0YO8PBIiwdC6Lq51H0GevI+s00UQUA1NFDZh60aqWpxLQC170rMaM52ziJ+FS6IH//LBQmW38u7UvbUyF+wsrX6BPd8i/qqTkxKsfRoa7h+qvs7GTIL9ShI1PJsSZC0BNjnQCEh4WQyLJhqF95eNQ0rQM2lw8otvbETQoEmHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706834985; c=relaxed/simple;
	bh=6Wlf7N0QfLuKqVKrYwpVHh9bo6N/xFAph0zAZIXa8J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw6hfbKnk1Bd27diIGIerovIJwjOxukWmSzLIN6ustZ+SFkzgvM7ZTOX4WXad3bhxSSEAWNXDR2lHnH2+Yel7kgvJbPekrvfVvMOlwajplGA5RT2oUzvaxPzGp5WtIcVghjp9S2zPf8O/oNnIYdSdEbMSuXe1KIGq91JnzMYr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXeR8MHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E90AC43394;
	Fri,  2 Feb 2024 00:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706834985;
	bh=6Wlf7N0QfLuKqVKrYwpVHh9bo6N/xFAph0zAZIXa8J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXeR8MHS3bi+BPpxws6A+HiqbRHQb29WtxZ0YaeC5ZtIN58R8c7eYyG/tMvSGKLmC
	 GRa2nK3NK24a61DMZTBLOeDQmlJfqWa4TMZp8TJB0tgdZ4G/CAyxsUg/sASsZrC3Cc
	 BShThYiwmIDrIoaXDM59C8xAK3HRTrf994qtYlndjIT7lFO/ISfiadjj91M3iicgJN
	 cmYo8KpDFvI7Y0fUvZmZKg+Nw6ddO4CiOl7jwofIc0QJYyFGD9MZdv2bO/FZt3rzWH
	 CujJlCMSk0fbreAeY+VrQbOKhQG02wLALXdALeQMSUIPbuMnxjB/+dOAp3yL4oMcfo
	 2X4tgILrW0F8A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl: generate code for ovs families
Date: Thu,  1 Feb 2024 16:49:25 -0800
Message-ID: <20240202004926.447803-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202004926.447803-1-kuba@kernel.org>
References: <20240202004926.447803-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ovs_flow, ovs_vport and ovs_datapath to the families supported
in C. ovs-flow has some circular nesting which is fun to deal with,
but the necessary support has been added already in the previous
release cycle.

Add a sample that proves that dealing with fixed headers does
actually work correctly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/generated/Makefile |  2 +-
 tools/net/ynl/samples/ovs.c      | 60 ++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/net/ynl/samples/ovs.c

diff --git a/tools/net/ynl/generated/Makefile b/tools/net/ynl/generated/Makefile
index 0d826fd008ed..3b9f738c61b8 100644
--- a/tools/net/ynl/generated/Makefile
+++ b/tools/net/ynl/generated/Makefile
@@ -14,7 +14,7 @@ YNL_GEN_ARG_ethtool:=--user-header linux/ethtool_netlink.h \
 
 TOOL:=../ynl-gen-c.py
 
-GENS:=ethtool devlink dpll handshake fou mptcp_pm netdev nfsd
+GENS:=ethtool devlink dpll handshake fou mptcp_pm netdev nfsd ovs_datapath ovs_vport ovs_flow
 SRCS=$(patsubst %,%-user.c,${GENS})
 HDRS=$(patsubst %,%-user.h,${GENS})
 OBJS=$(patsubst %,%-user.o,${GENS})
diff --git a/tools/net/ynl/samples/ovs.c b/tools/net/ynl/samples/ovs.c
new file mode 100644
index 000000000000..3e975c003d77
--- /dev/null
+++ b/tools/net/ynl/samples/ovs.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <string.h>
+
+#include <ynl.h>
+
+#include "ovs_datapath-user.h"
+
+int main(int argc, char **argv)
+{
+	struct ynl_sock *ys;
+	int err;
+
+	ys = ynl_sock_create(&ynl_ovs_datapath_family, NULL);
+	if (!ys)
+		return 1;
+
+	if (argc > 1) {
+		struct ovs_datapath_new_req *req;
+
+		req = ovs_datapath_new_req_alloc();
+		if (!req)
+			goto err_close;
+
+		ovs_datapath_new_req_set_upcall_pid(req, 1);
+		ovs_datapath_new_req_set_name(req, argv[1]);
+
+		err = ovs_datapath_new(ys, req);
+		ovs_datapath_new_req_free(req);
+		if (err)
+			goto err_close;
+	} else {
+		struct ovs_datapath_get_req_dump *req;
+		struct ovs_datapath_get_list *dps;
+
+		printf("Dump:\n");
+		req = ovs_datapath_get_req_dump_alloc();
+
+		dps = ovs_datapath_get_dump(ys, req);
+		ovs_datapath_get_req_dump_free(req);
+		if (!dps)
+			goto err_close;
+
+		ynl_dump_foreach(dps, dp) {
+			printf("  %s(%d): pid:%u cache:%u\n",
+			       dp->name, dp->_hdr.dp_ifindex,
+			       dp->upcall_pid, dp->masks_cache_size);
+		}
+		ovs_datapath_get_list_free(dps);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
+	ynl_sock_destroy(ys);
+	return 2;
+}
-- 
2.43.0


