Return-Path: <netdev+bounces-32817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B2779A807
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3CD2810BD
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1FBF9F5;
	Mon, 11 Sep 2023 12:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FFFBE3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424DCC433CA;
	Mon, 11 Sep 2023 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694436617;
	bh=eM4RgsXN8SHM0dqEChvO38xChoopQ1vfWDrIbOQNPt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/wCuXcP/cwCL6xasJhrU0eUDae34Xx6zR1UcUdLsFPoiG30EgeCtfJng7MPXJCaX
	 +P5lkQ6PIUK1stts0F+wJTfKG4TqaI2oDlbQpUXHLY2i/VLdJePUOlxBzNI2BT9rTM
	 anIH4WkTj6/ZGBTefVQNlbOU02JYvmCiM+ZjcRZLQyAIRuqBd5sZ6cOt/l2HSs+nwE
	 9XWYHWu4hRAM8i+zD9tlZWYQRIl7yiORLb0dfpwtHfBXnUN7aRAUc1mFL0Tw9t1hgS
	 sjP/24E1f7/9yIgRZQXvI3ILSMs9Swyu2dTHCIPrUhnC2b1GLzi23QZf0MA1thjBxg
	 iOm8M4oEPXjZQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org
Subject: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Date: Mon, 11 Sep 2023 14:49:45 +0200
Message-ID: <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:

$./tools/net/ynl/ynl-gen-c.py --mode uapi \
 --spec Documentation/netlink/specs/nfsd_server.yaml \
 --header -o include/uapi/linux/nfsd_server.h
$./tools/net/ynl/ynl-gen-c.py --mode kernel \
 --spec Documentation/netlink/specs/nfsd_server.yaml \
 --header -o fs/nfsd/nfs_netlink_gen.h
$./tools/net/ynl/ynl-gen-c.py --mode kernel \
 --spec Documentation/netlink/specs/nfsd_server.yaml \
 --source -o fs/nfsd/nfs_netlink_gen.c

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 fs/nfsd/Makefile                 |  3 +-
 fs/nfsd/nfs_netlink_gen.c        | 32 +++++++++++++++++++++
 fs/nfsd/nfs_netlink_gen.h        | 22 ++++++++++++++
 fs/nfsd/nfsctl.c                 | 16 +++++++++++
 include/uapi/linux/nfsd_server.h | 49 ++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+), 1 deletion(-)
 create mode 100644 fs/nfsd/nfs_netlink_gen.c
 create mode 100644 fs/nfsd/nfs_netlink_gen.h
 create mode 100644 include/uapi/linux/nfsd_server.h

diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
index 6fffc8f03f74..6ae1d5450bf6 100644
--- a/fs/nfsd/Makefile
+++ b/fs/nfsd/Makefile
@@ -12,7 +12,8 @@ nfsd-y			+= trace.o
 
 nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
 			   export.o auth.o lockd.o nfscache.o \
-			   stats.o filecache.o nfs3proc.o nfs3xdr.o
+			   stats.o filecache.o nfs3proc.o nfs3xdr.o \
+			   nfs_netlink_gen.o
 nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
 nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
 nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
diff --git a/fs/nfsd/nfs_netlink_gen.c b/fs/nfsd/nfs_netlink_gen.c
new file mode 100644
index 000000000000..4d71b80bf4a7
--- /dev/null
+++ b/fs/nfsd/nfs_netlink_gen.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd_server.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "nfs_netlink_gen.h"
+
+#include <uapi/linux/nfsd_server.h>
+
+/* Ops table for nfsd_server */
+static const struct genl_split_ops nfsd_server_nl_ops[] = {
+	{
+		.cmd	= NFSD_CMD_RPC_STATUS_GET,
+		.start	= nfsd_server_nl_rpc_status_get_start,
+		.dumpit	= nfsd_server_nl_rpc_status_get_dumpit,
+		.done	= nfsd_server_nl_rpc_status_get_done,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
+};
+
+struct genl_family nfsd_server_nl_family __ro_after_init = {
+	.name		= NFSD_SERVER_FAMILY_NAME,
+	.version	= NFSD_SERVER_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= nfsd_server_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(nfsd_server_nl_ops),
+};
diff --git a/fs/nfsd/nfs_netlink_gen.h b/fs/nfsd/nfs_netlink_gen.h
new file mode 100644
index 000000000000..f66b29e528c1
--- /dev/null
+++ b/fs/nfsd/nfs_netlink_gen.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd_server.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_NFSD_SERVER_GEN_H
+#define _LINUX_NFSD_SERVER_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/nfsd_server.h>
+
+int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb);
+int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb);
+
+int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
+					 struct netlink_callback *cb);
+
+extern struct genl_family nfsd_server_nl_family;
+
+#endif /* _LINUX_NFSD_SERVER_GEN_H */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 33f80d289d63..1be66088849c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
+{
+	return 0;
+}
+
+int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
+{
+	return 0;
+}
+
+int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
+					 struct netlink_callback *cb)
+{
+	return 0;
+}
+
 /**
  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
  * @net: a freshly-created network namespace
diff --git a/include/uapi/linux/nfsd_server.h b/include/uapi/linux/nfsd_server.h
new file mode 100644
index 000000000000..c9ee00ceca3b
--- /dev/null
+++ b/include/uapi/linux/nfsd_server.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/nfsd_server.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_NFSD_SERVER_H
+#define _UAPI_LINUX_NFSD_SERVER_H
+
+#define NFSD_SERVER_FAMILY_NAME		"nfsd_server"
+#define NFSD_SERVER_FAMILY_VERSION	1
+
+enum nfsd_rpc_status_comp_attr {
+	NFSD_ATTR_RPC_STATUS_COMP_UNSPEC,
+	NFSD_ATTR_RPC_STATUS_COMP_OP,
+
+	__NFSD_ATTR_RPC_STATUS_COMP_MAX,
+	NFSD_ATTR_RPC_STATUS_COMP_MAX = (__NFSD_ATTR_RPC_STATUS_COMP_MAX - 1)
+};
+
+enum nfsd_rpc_status_attr {
+	NFSD_ATTR_RPC_STATUS_UNSPEC,
+	NFSD_ATTR_RPC_STATUS_XID,
+	NFSD_ATTR_RPC_STATUS_FLAGS,
+	NFSD_ATTR_RPC_STATUS_PROG,
+	NFSD_ATTR_RPC_STATUS_VERSION,
+	NFSD_ATTR_RPC_STATUS_PROC,
+	NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
+	NFSD_ATTR_RPC_STATUS_PAD,
+	NFSD_ATTR_RPC_STATUS_SADDR4,
+	NFSD_ATTR_RPC_STATUS_DADDR4,
+	NFSD_ATTR_RPC_STATUS_SADDR6,
+	NFSD_ATTR_RPC_STATUS_DADDR6,
+	NFSD_ATTR_RPC_STATUS_SPORT,
+	NFSD_ATTR_RPC_STATUS_DPORT,
+	NFSD_ATTR_RPC_STATUS_COMPOND_OP,
+
+	__NFSD_ATTR_RPC_STATUS_MAX,
+	NFSD_ATTR_RPC_STATUS_MAX = (__NFSD_ATTR_RPC_STATUS_MAX - 1)
+};
+
+enum nfsd_commands {
+	NFSD_CMD_UNSPEC,
+	NFSD_CMD_RPC_STATUS_GET,
+
+	__NFSD_CMD_MAX,
+	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)
+};
+
+#endif /* _UAPI_LINUX_NFSD_SERVER_H */
-- 
2.41.0


