Return-Path: <netdev+bounces-75497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975486A283
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A931F23F1C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B6F56768;
	Tue, 27 Feb 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoOy7wBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87756762
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073050; cv=none; b=fWXGf4AaNhQP3fs+LzvEh50s71eREtmQ4bgaKijCJUkMxedyJC2mJPhgO84d6viY604MCZFiEB29cIRFDEuahjvfwxinh7CU/tsPw7bl/QF3QoakJ4PMN/5G+GzWwBrQsGGQeT2FzCaGaK6zr7705iN+omJYdykwXXDFw+s2kdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073050; c=relaxed/simple;
	bh=c1Lckz6ozicfhR3lFx1jVDSm5enb7XIJSWb5DD+DOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMeg2gpGCmzp4IgzfKJGHjqbu7+gxUnUgubLWEaz6yCSDi5J1guSy/Ff3la/XuWda0g3pOK4ctFjbZhVk9HpBa0ZohAuPNs/h8BwOHHJ4IeSgIeE0SlMGrDohGlRgOdXSeVvLzO4Wjw4ufQW0MR5sYiaNnPa7Fs/nU1dF+5CsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoOy7wBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E336EC433F1;
	Tue, 27 Feb 2024 22:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073050;
	bh=c1Lckz6ozicfhR3lFx1jVDSm5enb7XIJSWb5DD+DOXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoOy7wBGHiycTEpDZ3g7Yhmn0WuHPdGtQ0xuPprGB0HFM5+PQ+IOzMulNcJPPKVn3
	 1bgR9zoEcXkMLi5QgjnHZw8OM98DnfOZoqb8gkONCTP9E85S9nUXkMKk8K+hKdPH/H
	 I12NRbwp5IVuFCh9Fm9nuaEbgCL6vIaIambVyf+OuSGLqQ6hAlrKmuQhNkZq+6MCkk
	 BSTaXeXDDVso5pIIolR5iHOa5u96k9STo3iYoDUJYt8uV+RObzH5Cc/4mYfrXsTBTz
	 sMfpSy5/SBCeQvEzCBz+PhHTjvDKGRpmDE7ubFhjqYjXRm+8PytJwRMe2xUBXUkVOE
	 xIVqf6aXD/3Og==
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
Subject: [PATCH net-next v3 11/15] tools: ynl: switch away from mnl_cb_t
Date: Tue, 27 Feb 2024 14:30:28 -0800
Message-ID: <20240227223032.1835527-12-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227223032.1835527-1-kuba@kernel.org>
References: <20240227223032.1835527-1-kuba@kernel.org>
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
index 42f7d29fbee0..5c0bd90c116b 100644
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


