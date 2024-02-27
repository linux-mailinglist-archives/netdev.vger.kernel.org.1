Return-Path: <netdev+bounces-75489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E5586A27D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E364E1F24163
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5726F55790;
	Tue, 27 Feb 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOyyGzOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC955789
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073046; cv=none; b=kVOApkgB+nHonJwzyQ2VusF49ZR6ch8/7cXIk9O/No3JFu11zqmQ0O0539zwq3ZtWN1ZZt9KChAOnLPsAiM+5B1Emufha15PpbgZ9M/zKhfonn7tfWhqsscM+n1yflh0KdF6hLnZwRGEzdkwemYQzfCWXawoDwoDjizSzte6QJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073046; c=relaxed/simple;
	bh=7+xZnOVXyB6seC6A7UmMfyajVjxSzdveYW55XA0dJn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOtE/K5yEd57QHsuXhBvpldM7piBIi0Wt7suqzzUQjIC2CJm1n+SXRITpg4q9dpY7efC0nRwpK3B9gX92omtqzJi03pA1mLPIMgmaRN2+i4+9IcgxZC4yVazstEGYwVttEa9NAJXxXbrmOI7/gnmce+SeBrjBtQjdsVnMDQOKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOyyGzOh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE42C43399;
	Tue, 27 Feb 2024 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073045;
	bh=7+xZnOVXyB6seC6A7UmMfyajVjxSzdveYW55XA0dJn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jOyyGzOhfcDqeCkf3UtKwxTPRMEqZBqcs43vG2H4Oe1OeMFXhR7dOVs8oWFU/uUD/
	 0FEg5uE9au1t8An82ztGyBXJTiYETH15UvV5qjxtwyG0CxZndhjXbobHtjGuZasHHG
	 7EWPgBr45X6acW35FRfsWKIjAGPO1USkUH1ykO5EU//W706ychnvs20DAWPpvOfwV4
	 tqJn3pIlCac9ckUYks2aW4Xu5IuKrJVzO4kmJm8hL4XlZqEmaOp4+/zjr0oTMHzEj1
	 AC8NBhQuokO9J++fdOM2Wj3c14Y7tf28mkG4XPYyuWroeuXrIGuUPgn4aCS3WGMVaX
	 zxQ23hJsOsGRg==
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
Subject: [PATCH net-next v3 03/15] tools: ynl: create local for_each helpers
Date: Tue, 27 Feb 2024 14:30:20 -0800
Message-ID: <20240227223032.1835527-4-kuba@kernel.org>
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

Create ynl_attr_for_each*() iteration helpers.
Use them instead of the mnl ones.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 47 ++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.c      | 12 ++++-----
 tools/net/ynl/ynl-gen-c.py   |  8 +++---
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index d42d44a77dcb..a339732450c3 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -147,6 +147,53 @@ static inline void *ynl_attr_data(const struct nlattr *attr)
 	return (unsigned char *)attr + NLA_HDRLEN;
 }
 
+static inline void *ynl_attr_data_end(const struct nlattr *attr)
+{
+	return ynl_attr_data(attr) + ynl_attr_data_len(attr);
+}
+
+#define ynl_attr_for_each(attr, nlh, fixed_hdr_sz)			\
+	for ((attr) = ynl_attr_first(nlh, (nlh)->nlmsg_len,		\
+				     NLMSG_HDRLEN + fixed_hdr_sz); attr; \
+	     (attr) = ynl_attr_next(ynl_nlmsg_end_addr(nlh), attr))
+
+#define ynl_attr_for_each_nested(attr, outer)				\
+	for ((attr) = ynl_attr_first(outer, outer->nla_len,		\
+				     sizeof(struct nlattr)); attr;	\
+	     (attr) = ynl_attr_next(ynl_attr_data_end(outer), attr))
+
+#define ynl_attr_for_each_payload(start, len, attr)			\
+	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
+	     (attr) = ynl_attr_next(start + len, attr))
+
+static inline struct nlattr *
+ynl_attr_if_good(const void *end, struct nlattr *attr)
+{
+	if (attr + 1 > (const struct nlattr *)end)
+		return NULL;
+	if (ynl_attr_data_end(attr) > end)
+		return NULL;
+	return attr;
+}
+
+static inline struct nlattr *
+ynl_attr_next(const void *end, const struct nlattr *prev)
+{
+	struct nlattr *attr;
+
+	attr = (void *)((char *)prev + NLA_ALIGN(prev->nla_len));
+	return ynl_attr_if_good(end, attr);
+}
+
+static inline struct nlattr *
+ynl_attr_first(const void *start, size_t len, size_t skip)
+{
+	struct nlattr *attr;
+
+	attr = (void *)((char *)start + NLMSG_ALIGN(skip));
+	return ynl_attr_if_good(start + len, attr);
+}
+
 static inline struct nlattr *
 ynl_attr_nest_start(struct nlmsghdr *nlh, unsigned int attr_type)
 {
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index b9ed587af676..0f71e69b70c0 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -92,7 +92,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
 
 	data_len = end - start;
 
-	mnl_attr_for_each_payload(start, data_len) {
+	ynl_attr_for_each_payload(start, data_len, attr) {
 		astart_off = (char *)attr - (char *)start;
 		aend_off = astart_off + ynl_attr_data_len(attr);
 		if (aend_off <= off)
@@ -150,7 +150,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		return MNL_CB_OK;
 	}
 
-	mnl_attr_for_each(attr, nlh, hlen) {
+	ynl_attr_for_each(attr, nlh, hlen) {
 		unsigned int len, type;
 
 		len = ynl_attr_data_len(attr);
@@ -500,7 +500,7 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 	const struct nlattr *entry, *attr;
 	unsigned int i;
 
-	mnl_attr_for_each_nested(attr, mcasts)
+	ynl_attr_for_each_nested(attr, mcasts)
 		ys->n_mcast_groups++;
 
 	if (!ys->n_mcast_groups)
@@ -512,8 +512,8 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 		return MNL_CB_ERROR;
 
 	i = 0;
-	mnl_attr_for_each_nested(entry, mcasts) {
-		mnl_attr_for_each_nested(attr, entry) {
+	ynl_attr_for_each_nested(entry, mcasts) {
+		ynl_attr_for_each_nested(attr, entry) {
 			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_ID)
 				ys->mcast_groups[i].id = ynl_attr_get_u32(attr);
 			if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GRP_NAME) {
@@ -535,7 +535,7 @@ static int ynl_get_family_info_cb(const struct nlmsghdr *nlh, void *data)
 	const struct nlattr *attr;
 	bool found_id = true;
 
-	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+	ynl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
 		if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GROUPS)
 			if (ynl_get_family_info_mcast(ys, attr))
 				return MNL_CB_ERROR;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 99a3eb7b158b..eabce06f03d9 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -650,7 +650,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
         get_lines = [f'attr_{self.c_name} = attr;',
-                     'mnl_attr_for_each_nested(attr2, attr)',
+                     'ynl_attr_for_each_nested(attr2, attr)',
                      f'\t{var}->n_{self.c_name}++;']
         return get_lines, None, local_vars
 
@@ -1612,11 +1612,11 @@ _C_KW = {
 
 def _multi_parse(ri, struct, init_lines, local_vars):
     if struct.nested:
-        iter_line = "mnl_attr_for_each_nested(attr, nested)"
+        iter_line = "ynl_attr_for_each_nested(attr, nested)"
     else:
         if ri.fixed_hdr:
             local_vars += ['void *hdr;']
-        iter_line = "mnl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
+        iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
 
     array_nests = set()
     multi_attrs = set()
@@ -1679,7 +1679,7 @@ _C_KW = {
         ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
-        ri.cw.block_start(line=f"mnl_attr_for_each_nested(attr, attr_{aspec.c_name})")
+        ri.cw.block_start(line=f"ynl_attr_for_each_nested(attr, attr_{aspec.c_name})")
         ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
         ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
         ri.cw.p('return MNL_CB_ERROR;')
-- 
2.43.2


