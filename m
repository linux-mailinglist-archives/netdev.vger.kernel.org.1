Return-Path: <netdev+bounces-75110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC18682E8
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299B41F267AE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE2E132C18;
	Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ub6nx1qQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A547131E24
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982433; cv=none; b=hCwIvCt7mlxxSYDmolJMLwzi/R5jlgB23aRm7x2Sf0lM5ED9IkhHqyspP3bfWgWKSYU+0tHr5/cb3xNGr8lTDiKI261dDIAKeFBF67bKEz55k6U4TQS1KDcSxXc5OPcf4CNQQvIi3lIvRSo2P+RBzHmqRCFWUlc0IeRkiFSV72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982433; c=relaxed/simple;
	bh=V5m46XPrYGtNyZxBBZm5aw2/8xd6lka/Xm7H2dFfJ84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5Cybf+rCsC/CZpN3Td3wXsYrew5FRq+4gDXglOtTA0CIqVM6KuwQd+jmXOS8L1dSZVirWitaaEzCVPdWFtsz44kRznFv5XZAH3EWD42gjXtLWnrkmcN8HYRNNPdXExGxIFFBU0ufOD3zPDr//nr6CgNky6v9yHvwk87D8aXWsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ub6nx1qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FABC43399;
	Mon, 26 Feb 2024 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982433;
	bh=V5m46XPrYGtNyZxBBZm5aw2/8xd6lka/Xm7H2dFfJ84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ub6nx1qQbYZ9/uH8vVp/F8WBIsMgT6akOEOxVFvntcg8cKDBoS0u57T4f7Ra9+lwX
	 0CHUyNRKb/xwuescZ/ZmZzvwQ+yyVdHfF48H/Z5nDH1M4rjOfQ7H0nSntsHy5B6j/S
	 k0+zZsPekqRbs9it+9+ichRTCdewLG1eQ2oGO/yl675AekvmBTzc9h4HkhFghUsw71
	 7z3xlnA3CrgMmhkwtxg+pbDbO5fj5JEJJzgCSCSgSGmKFW7AZ2tg8+2CNxidoQtAqk
	 hDikt/Kh2aXzzQEvPvVuY0kQ9icPk/2TmczX4i+uCgjxZIMOLd4Uq1vGEgmZhrv+KN
	 o4x5TK01oocOg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/15] tools: ynl: switch away from mnl_cb_t
Date: Mon, 26 Feb 2024 13:20:17 -0800
Message-ID: <20240226212021.1247379-12-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226212021.1247379-1-kuba@kernel.org>
References: <20240226212021.1247379-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All YNL parsing callbacks take struct ynl_parse_arg as the argument.
Make that official by using a local callback type instead of mnl_cb_t.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 11 ++++++++---
 tools/net/ynl/lib/ynl.c      | 25 ++++++++++++-------------
 tools/net/ynl/ynl-gen-c.py   |  3 +--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 310302e48f61..3f6eeba16be0 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -6,6 +6,8 @@
 #include <libmnl/libmnl.h>
 #include <linux/types.h>
 
+struct ynl_parse_arg;
+
 /*
  * YNL internals / low level stuff
  */
@@ -30,6 +32,9 @@ enum ynl_policy_type {
 #define YNL_ARRAY_SIZE(array)	(sizeof(array) ?			\
 				 sizeof(array) / sizeof(array[0]) : 0)
 
+typedef int (*ynl_parse_cb_t)(const struct nlmsghdr *nlh,
+			      struct ynl_parse_arg *yarg);
+
 struct ynl_policy_attr {
 	enum ynl_policy_type type;
 	unsigned int len;
@@ -94,7 +99,7 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
 
 struct ynl_req_state {
 	struct ynl_parse_arg yarg;
-	mnl_cb_t cb;
+	ynl_parse_cb_t cb;
 	__u32 rsp_cmd;
 };
 
@@ -103,13 +108,13 @@ struct ynl_dump_state {
 	void *first;
 	struct ynl_dump_list_type *last;
 	size_t alloc_sz;
-	mnl_cb_t cb;
+	ynl_parse_cb_t cb;
 	__u32 rsp_cmd;
 };
 
 struct ynl_ntf_info {
 	struct ynl_policy_nest *policy;
-	mnl_cb_t cb;
+	ynl_parse_cb_t cb;
 	size_t alloc_sz;
 	void (*free)(struct ynl_ntf_base_type *ntf);
 };
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index fd658aaff345..27fb596aa791 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -449,17 +449,15 @@ ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version)
 			       cmd, version);
 }
 
-static int ynl_cb_null(const struct nlmsghdr *nlh, void *data)
+static int ynl_cb_null(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_parse_arg *yarg = data;
-
 	yerr(yarg->ys, YNL_ERROR_UNEXPECT_MSG,
 	     "Received a message when none were expected");
 
 	return MNL_CB_ERROR;
 }
 
-static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, mnl_cb_t cb)
+static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
 {
 	struct ynl_sock *ys = yarg->ys;
 	const struct nlmsghdr *nlh;
@@ -558,9 +556,9 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 	return 0;
 }
 
-static int ynl_get_family_info_cb(const struct nlmsghdr *nlh, void *data)
+static int
+ynl_get_family_info_cb(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_parse_arg *yarg = data;
 	struct ynl_sock *ys = yarg->ys;
 	const struct nlattr *attr;
 	bool found_id = true;
@@ -770,10 +768,9 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	return MNL_CB_ERROR;
 }
 
-static int ynl_ntf_trampoline(const struct nlmsghdr *nlh, void *data)
+static int
+ynl_ntf_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_parse_arg *yarg = data;
-
 	return ynl_ntf_parse(yarg->ys, nlh);
 }
 
@@ -836,9 +833,10 @@ ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
 	return 0;
 }
 
-static int ynl_req_trampoline(const struct nlmsghdr *nlh, void *data)
+static
+int ynl_req_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 {
-	struct ynl_req_state *yrs = data;
+	struct ynl_req_state *yrs = (void *)yarg;
 	int ret;
 
 	ret = ynl_check_alien(yrs->yarg.ys, nlh, yrs->rsp_cmd);
@@ -864,9 +862,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 	return err;
 }
 
-static int ynl_dump_trampoline(const struct nlmsghdr *nlh, void *data)
+static int
+ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 {
-	struct ynl_dump_state *ds = data;
+	struct ynl_dump_state *ds = (void *)data;
 	struct ynl_dump_list_type *obj;
 	struct ynl_parse_arg yarg = {};
 	int ret;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 289a04f2cfaa..15a9d3b2eed3 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1737,10 +1737,9 @@ _C_KW = {
         return
 
     func_args = ['const struct nlmsghdr *nlh',
-                 'void *data']
+                 'struct ynl_parse_arg *yarg']
 
     local_vars = [f'{type_name(ri, "reply", deref=deref)} *dst;',
-                  'struct ynl_parse_arg *yarg = data;',
                   'const struct nlattr *attr;']
     init_lines = ['dst = yarg->data;']
 
-- 
2.43.2


