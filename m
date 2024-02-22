Return-Path: <netdev+bounces-74204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B8860736
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FE9B22507
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD63142620;
	Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIpARTd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC63140E5A
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646191; cv=none; b=cNLGxnaWweabDyav0MMCm9s6q8ql89pyrf6GDm6+5S9o2PdTj7Hn9BQuQ++gQ5zaJJHfr0G4UsjgPFn2JhlJEgSxI43NsUXh4y7CmOStjH+EWk264u3+HXDE4cbS/n6c2xWcOFnUaENCifOSpU4qs/Bmb0mAjWTxR7l+jv0LxBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646191; c=relaxed/simple;
	bh=uCx/3VCjdPTykIx8pti1bRwq0LISAyhYi3w3banJ/+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn4vp1/RAVp7mkZSr6pU3PDquDBCdYAmYSiXguUgKKL2xuXL/vdGdme+54aOVJV/p6RPoRcVxtvIAFovRDnDgwJPdpWnmINxPgreU/9m3MgoDCpIFyRv6z85BOogMNFecEARrN2BfLsrpR29FpaHFHK5SHKFLvFIorvV4eJyAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIpARTd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F63C43399;
	Thu, 22 Feb 2024 23:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646191;
	bh=uCx/3VCjdPTykIx8pti1bRwq0LISAyhYi3w3banJ/+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIpARTd0/arE6C3GNcw1D2wtXh9lg/cceKHNatbNd2UpagcbgySwsx8SvARdz78PT
	 6YOJKleFi2L55+zjbgdVZ4Ru+6VjYu9JYMaxjcuujfS4bEAkGAh0CPusd24FJgPinX
	 mEqNEelzQH8de/9BW5fAHQgY4VUvOMJYC+rIbJ1gXc8n+MESkj/EJuIMOXu50D2V2i
	 XS0ViFSpEGqrQUKS6UyX3E+ZIM6zdAcsmntJ9jTTyS/tuFVb8lYzRDr7R/WGmheKX1
	 +s4jDkSEUbQjtLga+Ysms6FjTrzRvSxwmli7lsvSqA1Gm6YfrbPPi1JKWyxAQR6gkT
	 mJhSxFriAoPCg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/15] tools: ynl: switch away from mnl_cb_t
Date: Thu, 22 Feb 2024 15:56:10 -0800
Message-ID: <20240222235614.180876-12-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235614.180876-1-kuba@kernel.org>
References: <20240222235614.180876-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All YNL parsing callbacks take struct ynl_parse_arg as the argument.
Make that official by using a local callback type instead of mnl_cb_t.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 11 ++++++++---
 tools/net/ynl/lib/ynl.c      | 25 ++++++++++++-------------
 tools/net/ynl/ynl-gen-c.py   |  3 +--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 65880f879447..36523f3115c0 100644
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
index 0f96ce948f75..5548cdc775e5 100644
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
 	ssize_t len, rem;
@@ -561,9 +559,9 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
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
@@ -773,10 +771,9 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
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
 
@@ -839,9 +836,10 @@ ynl_check_alien(struct ynl_sock *ys, const struct nlmsghdr *nlh, __u32 rsp_cmd)
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
@@ -867,9 +865,10 @@ int ynl_exec(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
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
index 87f8b9d28734..7cc2b859d8de 100755
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


