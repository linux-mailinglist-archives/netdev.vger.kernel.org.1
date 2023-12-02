Return-Path: <netdev+bounces-53292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4264B801E92
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 22:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BB3B20A21
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A521119;
	Sat,  2 Dec 2023 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPkzt39e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888743D82
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 21:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ACBC433C8;
	Sat,  2 Dec 2023 21:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701551548;
	bh=aRjAtBnTMeKylIiT+1hvGneaTfGgMR4xtZ6Xr+VcZ1U=;
	h=From:To:Cc:Subject:Date:From;
	b=GPkzt39eQl5TUyv8H+Rq/2hVxGzqsNpJHQrE7KPBqWG/oLf7sL6c2FGjNrv99P8OH
	 toRat/77tdekOVytWu0b4nbXraDDrNyIK94OiujLviJ3+riIiwnHKD4QL3vyQDH1he
	 gpyU7yiw7SePHO6knx2wyWQ5DInh90gzAO5CaVNc13FLWccOYOvhVtLHJGH00aUrfV
	 GraEeqrd8LGgzhsiKcfzvF4Gzg2dtdjmi67WC8VNyCEe2XJdoUYvlYPQEAz8HYNndM
	 +Xfp94L/+eOLlnEnSWTDK87Dv/mQnIUnGOSHT8OT31LmzcmrJ3T3c7rgxG4QTmGZZ7
	 tEMTYfv9fAwTA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net-next] tools: ynl: move private definitions to a separate header
Date: Sat,  2 Dec 2023 13:12:25 -0800
Message-ID: <20231202211225.342466-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ynl.h has a growing amount of "internal" stuff, which may confuse
users who try to take a look at the external API. Currently the
internals are at the bottom of the file with a banner in between,
but this arrangement makes it hard to add external APIs / inline
helpers which need internal definitions.

Move internals to a separate header.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 tools/net/ynl/lib/ynl-priv.h | 144 ++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.h      | 148 +----------------------------------
 2 files changed, 145 insertions(+), 147 deletions(-)
 create mode 100644 tools/net/ynl/lib/ynl-priv.h

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
new file mode 100644
index 000000000000..ad9006a7c667
--- /dev/null
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+#ifndef __YNL_C_PRIV_H
+#define __YNL_C_PRIV_H 1
+
+#include <stddef.h>
+#include <libmnl/libmnl.h>
+#include <linux/types.h>
+
+/*
+ * YNL internals / low level stuff
+ */
+
+/* Generic mnl helper code */
+
+enum ynl_policy_type {
+	YNL_PT_REJECT = 1,
+	YNL_PT_IGNORE,
+	YNL_PT_NEST,
+	YNL_PT_FLAG,
+	YNL_PT_BINARY,
+	YNL_PT_U8,
+	YNL_PT_U16,
+	YNL_PT_U32,
+	YNL_PT_U64,
+	YNL_PT_UINT,
+	YNL_PT_NUL_STR,
+	YNL_PT_BITFIELD32,
+};
+
+struct ynl_policy_attr {
+	enum ynl_policy_type type;
+	unsigned int len;
+	const char *name;
+	struct ynl_policy_nest *nest;
+};
+
+struct ynl_policy_nest {
+	unsigned int max_attr;
+	struct ynl_policy_attr *table;
+};
+
+struct ynl_parse_arg {
+	struct ynl_sock *ys;
+	struct ynl_policy_nest *rsp_policy;
+	void *data;
+};
+
+struct ynl_dump_list_type {
+	struct ynl_dump_list_type *next;
+	unsigned char data[] __attribute__((aligned(8)));
+};
+extern struct ynl_dump_list_type *YNL_LIST_END;
+
+static inline bool ynl_dump_obj_is_last(void *obj)
+{
+	unsigned long uptr = (unsigned long)obj;
+
+	uptr -= offsetof(struct ynl_dump_list_type, data);
+	return uptr == (unsigned long)YNL_LIST_END;
+}
+
+static inline void *ynl_dump_obj_next(void *obj)
+{
+	unsigned long uptr = (unsigned long)obj;
+	struct ynl_dump_list_type *list;
+
+	uptr -= offsetof(struct ynl_dump_list_type, data);
+	list = (void *)uptr;
+	uptr = (unsigned long)list->next;
+	uptr += offsetof(struct ynl_dump_list_type, data);
+
+	return (void *)uptr;
+}
+
+struct ynl_ntf_base_type {
+	__u16 family;
+	__u8 cmd;
+	struct ynl_ntf_base_type *next;
+	void (*free)(struct ynl_ntf_base_type *ntf);
+	unsigned char data[] __attribute__((aligned(8)));
+};
+
+extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
+
+struct nlmsghdr *
+ynl_gemsg_start_req(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
+struct nlmsghdr *
+ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
+
+int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
+
+int ynl_recv_ack(struct ynl_sock *ys, int ret);
+int ynl_cb_null(const struct nlmsghdr *nlh, void *data);
+
+/* YNL specific helpers used by the auto-generated code */
+
+struct ynl_req_state {
+	struct ynl_parse_arg yarg;
+	mnl_cb_t cb;
+	__u32 rsp_cmd;
+};
+
+struct ynl_dump_state {
+	struct ynl_sock *ys;
+	struct ynl_policy_nest *rsp_policy;
+	void *first;
+	struct ynl_dump_list_type *last;
+	size_t alloc_sz;
+	mnl_cb_t cb;
+	__u32 rsp_cmd;
+};
+
+struct ynl_ntf_info {
+	struct ynl_policy_nest *policy;
+	mnl_cb_t cb;
+	size_t alloc_sz;
+	void (*free)(struct ynl_ntf_base_type *ntf);
+};
+
+int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
+	     struct ynl_req_state *yrs);
+int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
+		  struct ynl_dump_state *yds);
+
+void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
+int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
+
+#ifndef MNL_HAS_AUTO_SCALARS
+static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
+{
+	if (mnl_attr_get_payload_len(attr) == 4)
+		return mnl_attr_get_u32(attr);
+	return mnl_attr_get_u64(attr);
+}
+
+static inline void
+mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
+{
+	if ((uint32_t)data == (uint64_t)data)
+		return mnl_attr_put_u32(nlh, type, data);
+	return mnl_attr_put_u64(nlh, type, data);
+}
+#endif
+#endif
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 075d868f3b57..5de580b992b8 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -3,20 +3,10 @@
 #define __YNL_C_H 1
 
 #include <stddef.h>
-#include <libmnl/libmnl.h>
 #include <linux/genetlink.h>
 #include <linux/types.h>
 
-struct mnl_socket;
-struct nlmsghdr;
-
-/*
- * User facing code
- */
-
-struct ynl_ntf_base_type;
-struct ynl_ntf_info;
-struct ynl_sock;
+#include "ynl-priv.h"
 
 enum ynl_error_code {
 	YNL_ERROR_NONE = 0,
@@ -116,140 +106,4 @@ static inline bool ynl_has_ntf(struct ynl_sock *ys)
 struct ynl_ntf_base_type *ynl_ntf_dequeue(struct ynl_sock *ys);
 
 void ynl_ntf_free(struct ynl_ntf_base_type *ntf);
-
-/*
- * YNL internals / low level stuff
- */
-
-/* Generic mnl helper code */
-
-enum ynl_policy_type {
-	YNL_PT_REJECT = 1,
-	YNL_PT_IGNORE,
-	YNL_PT_NEST,
-	YNL_PT_FLAG,
-	YNL_PT_BINARY,
-	YNL_PT_U8,
-	YNL_PT_U16,
-	YNL_PT_U32,
-	YNL_PT_U64,
-	YNL_PT_UINT,
-	YNL_PT_NUL_STR,
-	YNL_PT_BITFIELD32,
-};
-
-struct ynl_policy_attr {
-	enum ynl_policy_type type;
-	unsigned int len;
-	const char *name;
-	struct ynl_policy_nest *nest;
-};
-
-struct ynl_policy_nest {
-	unsigned int max_attr;
-	struct ynl_policy_attr *table;
-};
-
-struct ynl_parse_arg {
-	struct ynl_sock *ys;
-	struct ynl_policy_nest *rsp_policy;
-	void *data;
-};
-
-struct ynl_dump_list_type {
-	struct ynl_dump_list_type *next;
-	unsigned char data[] __attribute__((aligned(8)));
-};
-extern struct ynl_dump_list_type *YNL_LIST_END;
-
-static inline bool ynl_dump_obj_is_last(void *obj)
-{
-	unsigned long uptr = (unsigned long)obj;
-
-	uptr -= offsetof(struct ynl_dump_list_type, data);
-	return uptr == (unsigned long)YNL_LIST_END;
-}
-
-static inline void *ynl_dump_obj_next(void *obj)
-{
-	unsigned long uptr = (unsigned long)obj;
-	struct ynl_dump_list_type *list;
-
-	uptr -= offsetof(struct ynl_dump_list_type, data);
-	list = (void *)uptr;
-	uptr = (unsigned long)list->next;
-	uptr += offsetof(struct ynl_dump_list_type, data);
-
-	return (void *)uptr;
-}
-
-struct ynl_ntf_base_type {
-	__u16 family;
-	__u8 cmd;
-	struct ynl_ntf_base_type *next;
-	void (*free)(struct ynl_ntf_base_type *ntf);
-	unsigned char data[] __attribute__((aligned(8)));
-};
-
-extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
-
-struct nlmsghdr *
-ynl_gemsg_start_req(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
-struct nlmsghdr *
-ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
-
-int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
-
-int ynl_recv_ack(struct ynl_sock *ys, int ret);
-int ynl_cb_null(const struct nlmsghdr *nlh, void *data);
-
-/* YNL specific helpers used by the auto-generated code */
-
-struct ynl_req_state {
-	struct ynl_parse_arg yarg;
-	mnl_cb_t cb;
-	__u32 rsp_cmd;
-};
-
-struct ynl_dump_state {
-	struct ynl_sock *ys;
-	struct ynl_policy_nest *rsp_policy;
-	void *first;
-	struct ynl_dump_list_type *last;
-	size_t alloc_sz;
-	mnl_cb_t cb;
-	__u32 rsp_cmd;
-};
-
-struct ynl_ntf_info {
-	struct ynl_policy_nest *policy;
-	mnl_cb_t cb;
-	size_t alloc_sz;
-	void (*free)(struct ynl_ntf_base_type *ntf);
-};
-
-int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
-	     struct ynl_req_state *yrs);
-int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
-		  struct ynl_dump_state *yds);
-
-void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
-int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
-
-#ifndef MNL_HAS_AUTO_SCALARS
-static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
-{
-	if (mnl_attr_get_payload_len(attr) == 4)
-		return mnl_attr_get_u32(attr);
-	return mnl_attr_get_u64(attr);
-}
-
-static inline void
-mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
-{
-	if ((uint32_t)data == (uint64_t)data)
-		return mnl_attr_put_u32(nlh, type, data);
-	return mnl_attr_put_u64(nlh, type, data);
-}
-#endif
 #endif
-- 
2.43.0


