Return-Path: <netdev+bounces-75111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007ED8682EA
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC371F224A6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACEF132C29;
	Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXYdDAP1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740F132C25
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982433; cv=none; b=QtuMEJN+egZ4rhbSf9HjDoINSUGsqZusAXgQ37zp8QwexUuHjE5YzrMjwdZESuHbzk8uYvwWBePUqasH6meG/C+8aH9RjaUcZflss6u5APpT4w8prHoWHKweEgifczUUU6Wa+vke0BM7SfPPsUZGKsfbOXQnwSpXO5qIo48EsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982433; c=relaxed/simple;
	bh=IhTi96fCg8vHnQ9q7R4WnN7KLykv+3rQjQx3ZBGAY08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp1tG9LOjVVqRrVuvNDQI0lV4Vz3FSg+hJfVxKWzh308ulXjn0yBzx8cjDbVf74A/3fLY9cPtFKRpOQ5LNHJbotUweK9LTNt6OG0JjdayR17SKNwboEKfnkzryy3cLTQxVXc03v0yFtN/Cx9YWYRThjUeZisJ5ysVsCl7i6Mz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXYdDAP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC9C4166C;
	Mon, 26 Feb 2024 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982433;
	bh=IhTi96fCg8vHnQ9q7R4WnN7KLykv+3rQjQx3ZBGAY08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXYdDAP17lT1RPvmdUSmacN9DePCcVBvKG+vTkv626BDBGTTdlHeszlD3MrD+DVWX
	 jbQ8JA7afKSXAw+oBcKFMZ+OIFsTQkS8WMcILetyy+eaWFrtZt5u2E4KcJ9QWKTiYE
	 Hhs7+OUK3X2ednjdg5mNvx6tYJyqtROivJkBejdB+ytZCt8X4Xwxc1UPu28YFXXItE
	 wZ9YrouFyvmgkp0MEh+i5z4bg3TzeC++REQpVh26GqJzKzFXnko4Z/di2retZryFBf
	 w59DFMCFlXakF4w3v3hicVOLcWOy+766x2ZVcmrOTCWraTKd+bY910AExPnfmtCY0t
	 svBDt7SCwVqAA==
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
Subject: [PATCH net-next v2 12/15] tools: ynl: switch away from MNL_CB_*
Date: Mon, 26 Feb 2024 13:20:18 -0800
Message-ID: <20240226212021.1247379-13-kuba@kernel.org>
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

Create a local version of the MNL_CB_* parser control values.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h |  6 ++++
 tools/net/ynl/lib/ynl.c      | 54 ++++++++++++++++++------------------
 tools/net/ynl/ynl-gen-c.py   | 14 +++++-----
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 3f6eeba16be0..2170b71f0005 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -29,6 +29,12 @@ enum ynl_policy_type {
 	YNL_PT_BITFIELD32,
 };
 
+enum ynl_parse_result {
+	YNL_PARSE_CB_ERROR = -1,
+	YNL_PARSE_CB_STOP = 0,
+	YNL_PARSE_CB_OK = 1,
+};
+
 #define YNL_ARRAY_SIZE(array)	(sizeof(array) ?			\
 				 sizeof(array) / sizeof(array[0]) : 0)
 
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 27fb596aa791..968ab679b5e3 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -147,7 +147,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 
 	if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS)) {
 		yerr_msg(ys, "%s", strerror(ys->err.code));
-		return MNL_CB_OK;
+		return YNL_PARSE_CB_OK;
 	}
 
 	ynl_attr_for_each(attr, nlh, hlen) {
@@ -166,12 +166,12 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 		case NLMSGERR_ATTR_MISS_TYPE:
 		case NLMSGERR_ATTR_MISS_NEST:
 			if (len != sizeof(__u32))
-				return MNL_CB_ERROR;
+				return YNL_PARSE_CB_ERROR;
 			break;
 		case NLMSGERR_ATTR_MSG:
 			str = ynl_attr_get_str(attr);
 			if (str[len - 1])
-				return MNL_CB_ERROR;
+				return YNL_PARSE_CB_ERROR;
 			break;
 		default:
 			break;
@@ -252,7 +252,7 @@ ynl_ext_ack_check(struct ynl_sock *ys, const struct nlmsghdr *nlh,
 	else
 		yerr_msg(ys, "%s", strerror(ys->err.code));
 
-	return MNL_CB_OK;
+	return YNL_PARSE_CB_OK;
 }
 
 static int
@@ -272,7 +272,7 @@ ynl_cb_error(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 	ynl_ext_ack_check(yarg->ys, nlh, hlen);
 
-	return code ? MNL_CB_ERROR : MNL_CB_STOP;
+	return code ? YNL_PARSE_CB_ERROR : YNL_PARSE_CB_STOP;
 }
 
 static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
@@ -286,9 +286,9 @@ static int ynl_cb_done(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 		ynl_ext_ack_check(yarg->ys, nlh, sizeof(int));
 
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 	}
-	return MNL_CB_STOP;
+	return YNL_PARSE_CB_STOP;
 }
 
 /* Attribute validation */
@@ -454,7 +454,7 @@ static int ynl_cb_null(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 	yerr(yarg->ys, YNL_ERROR_UNEXPECT_MSG,
 	     "Received a message when none were expected");
 
-	return MNL_CB_ERROR;
+	return YNL_PARSE_CB_ERROR;
 }
 
 static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
@@ -468,30 +468,30 @@ static int ynl_sock_read_msgs(struct ynl_parse_arg *yarg, ynl_parse_cb_t cb)
 	if (len < 0)
 		return len;
 
-	ret = MNL_CB_STOP;
+	ret = YNL_PARSE_CB_STOP;
 	for (rem = len; rem > 0; NLMSG_NEXT(nlh, rem)) {
 		nlh = (struct nlmsghdr *)&ys->rx_buf[len - rem];
 		if (!NLMSG_OK(nlh, rem)) {
 			yerr(yarg->ys, YNL_ERROR_INV_RESP,
 			     "Invalid message or trailing data in the response.");
-			return MNL_CB_ERROR;
+			return YNL_PARSE_CB_ERROR;
 		}
 
 		if (nlh->nlmsg_flags & NLM_F_DUMP_INTR) {
 			/* TODO: handle this better */
 			yerr(yarg->ys, YNL_ERROR_DUMP_INTER,
 			     "Dump interrupted / inconsistent, please retry.");
-			return MNL_CB_ERROR;
+			return YNL_PARSE_CB_ERROR;
 		}
 
 		switch (nlh->nlmsg_type) {
 		case 0:
 			yerr(yarg->ys, YNL_ERROR_INV_RESP,
 			     "Invalid message type in the response.");
-			return MNL_CB_ERROR;
+			return YNL_PARSE_CB_ERROR;
 		case NLMSG_NOOP:
 		case NLMSG_OVERRUN ... NLMSG_MIN_TYPE - 1:
-			ret = MNL_CB_OK;
+			ret = YNL_PARSE_CB_OK;
 			break;
 		case NLMSG_ERROR:
 			ret = ynl_cb_error(nlh, yarg);
@@ -537,7 +537,7 @@ ynl_get_family_info_mcast(struct ynl_sock *ys, const struct nlattr *mcasts)
 	ys->mcast_groups = calloc(ys->n_mcast_groups,
 				  sizeof(*ys->mcast_groups));
 	if (!ys->mcast_groups)
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 
 	i = 0;
 	ynl_attr_for_each_nested(entry, mcasts) {
@@ -566,14 +566,14 @@ ynl_get_family_info_cb(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 	ynl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
 		if (ynl_attr_type(attr) == CTRL_ATTR_MCAST_GROUPS)
 			if (ynl_get_family_info_mcast(ys, attr))
-				return MNL_CB_ERROR;
+				return YNL_PARSE_CB_ERROR;
 
 		if (ynl_attr_type(attr) != CTRL_ATTR_FAMILY_ID)
 			continue;
 
 		if (ynl_attr_data_len(attr) != sizeof(__u16)) {
 			yerr(ys, YNL_ERROR_ATTR_INVALID, "Invalid family ID");
-			return MNL_CB_ERROR;
+			return YNL_PARSE_CB_ERROR;
 		}
 
 		ys->family_id = ynl_attr_get_u16(attr);
@@ -582,9 +582,9 @@ ynl_get_family_info_cb(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 	if (!found_id) {
 		yerr(ys, YNL_ERROR_ATTR_MISSING, "Family ID missing");
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 	}
-	return MNL_CB_OK;
+	return YNL_PARSE_CB_OK;
 }
 
 static int ynl_sock_read_family(struct ynl_sock *ys, const char *family_name)
@@ -741,10 +741,10 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 
 	gehdr = ynl_nlmsg_data(nlh);
 	if (gehdr->cmd >= ys->family->ntf_info_size)
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 	info = &ys->family->ntf_info[gehdr->cmd];
 	if (!info->cb)
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 
 	rsp = calloc(1, info->alloc_sz);
 	rsp->free = info->free;
@@ -752,7 +752,7 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	yarg.rsp_policy = info->policy;
 
 	ret = info->cb(nlh, &yarg);
-	if (ret <= MNL_CB_STOP)
+	if (ret <= YNL_PARSE_CB_STOP)
 		goto err_free;
 
 	rsp->family = nlh->nlmsg_type;
@@ -761,11 +761,11 @@ static int ynl_ntf_parse(struct ynl_sock *ys, const struct nlmsghdr *nlh)
 	*ys->ntf_last_next = rsp;
 	ys->ntf_last_next = &rsp->next;
 
-	return MNL_CB_OK;
+	return YNL_PARSE_CB_OK;
 
 err_free:
 	info->free(rsp);
-	return MNL_CB_ERROR;
+	return YNL_PARSE_CB_ERROR;
 }
 
 static int
@@ -812,7 +812,7 @@ void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd)
 int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg)
 {
 	yerr(yarg->ys, YNL_ERROR_INV_RESP, "Error parsing response: %s", msg);
-	return MNL_CB_ERROR;
+	return YNL_PARSE_CB_ERROR;
 }
 
 static int
@@ -841,7 +841,7 @@ int ynl_req_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *yarg)
 
 	ret = ynl_check_alien(yrs->yarg.ys, nlh, yrs->rsp_cmd);
 	if (ret)
-		return ret < 0 ? MNL_CB_ERROR : MNL_CB_OK;
+		return ret < 0 ? YNL_PARSE_CB_ERROR : YNL_PARSE_CB_OK;
 
 	return yrs->cb(nlh, &yrs->yarg);
 }
@@ -872,11 +872,11 @@ ynl_dump_trampoline(const struct nlmsghdr *nlh, struct ynl_parse_arg *data)
 
 	ret = ynl_check_alien(ds->yarg.ys, nlh, ds->rsp_cmd);
 	if (ret)
-		return ret < 0 ? MNL_CB_ERROR : MNL_CB_OK;
+		return ret < 0 ? YNL_PARSE_CB_ERROR : YNL_PARSE_CB_OK;
 
 	obj = calloc(1, ds->alloc_sz);
 	if (!obj)
-		return MNL_CB_ERROR;
+		return YNL_PARSE_CB_ERROR;
 
 	if (!ds->first)
 		ds->first = obj;
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 15a9d3b2eed3..375d5f5e3052 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -200,7 +200,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         if not self.is_multi_val():
             ri.cw.p("if (ynl_attr_validate(yarg, attr))")
-            ri.cw.p("return MNL_CB_ERROR;")
+            ri.cw.p("return YNL_PARSE_CB_ERROR;")
             if self.presence_type() == 'bit':
                 ri.cw.p(f"{var}->_present.{self.c_name} = 1;")
 
@@ -247,7 +247,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return []
 
     def _attr_get(self, ri, var):
-        return ['return MNL_CB_ERROR;'], None, None
+        return ['return YNL_PARSE_CB_ERROR;'], None, None
 
     def _attr_typol(self):
         return '.type = YNL_PT_REJECT, '
@@ -543,7 +543,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def _attr_get(self, ri, var):
         get_lines = [f"if ({self.nested_render_name}_parse(&parg, attr))",
-                     "return MNL_CB_ERROR;"]
+                     "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
         return get_lines, init_lines, None
@@ -1674,7 +1674,7 @@ _C_KW = {
         ri.cw.block_start(line=f"ynl_attr_for_each_nested(attr, attr_{aspec.c_name})")
         ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
         ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr, ynl_attr_type(attr)))")
-        ri.cw.p('return MNL_CB_ERROR;')
+        ri.cw.p('return YNL_PARSE_CB_ERROR;')
         ri.cw.p('i++;')
         ri.cw.block_end()
         ri.cw.block_end()
@@ -1693,7 +1693,7 @@ _C_KW = {
         if 'nested-attributes' in aspec:
             ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
             ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr))")
-            ri.cw.p('return MNL_CB_ERROR;')
+            ri.cw.p('return YNL_PARSE_CB_ERROR;')
         elif aspec.type in scalars:
             ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.type}(attr);")
         else:
@@ -1707,7 +1707,7 @@ _C_KW = {
     if struct.nested:
         ri.cw.p('return 0;')
     else:
-        ri.cw.p('return MNL_CB_OK;')
+        ri.cw.p('return YNL_PARSE_CB_OK;')
     ri.cw.block_end()
     ri.cw.nl()
 
@@ -1750,7 +1750,7 @@ _C_KW = {
     else:
         # Empty reply
         ri.cw.block_start()
-        ri.cw.p('return MNL_CB_OK;')
+        ri.cw.p('return YNL_PARSE_CB_OK;')
         ri.cw.block_end()
         ri.cw.nl()
 
-- 
2.43.2


