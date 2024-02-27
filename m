Return-Path: <netdev+bounces-75492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CD86A27F
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A61C25690
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD255C2E;
	Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNnTIfnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D855C2B
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073047; cv=none; b=kbBb8AjFiJ2Ze1/7enLGM+vW+lDIDBfl8Y7PV5lIASuTA6gNLWA9rI3P6QoMtlJWflLU3x8iFnsLrXSi/WWORhNHVOX3IQhU3Mvkd5Lnw78J7720lvsy8xUBFiks4bhhhYYYbGtjw9E2wAqeepbDmIhbEzet8nAFdAQUokwLMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073047; c=relaxed/simple;
	bh=vTDf9ZJFFgscqmbLXq2fls+1fJZPFLU1wxYYF/9vLqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLEoHObB5AEshUR84LI0XuiEqxB6oe02SHRUsTR/ZqYHHgRPvMJYi7Qd7NymQE9RCVQv/C7NBn0Nhc4ytoq4ON2vUR3NeqwUnJwXZkHWrLxYRMf0PJNGWXbVwLQHqx/u1lehyb3XToPIv5YJ+IWwwAm74TJAvUj42IbXVrpWnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNnTIfnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A53C433F1;
	Tue, 27 Feb 2024 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073047;
	bh=vTDf9ZJFFgscqmbLXq2fls+1fJZPFLU1wxYYF/9vLqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNnTIfnSQQpxXihXVS8lquI+rNkBtx0DYU+MDYYU3XOa1lum5wPsrSenE5/dWwm6z
	 dBOuAmde8j7YEh2DgCPCpVe9EWxj0nHwvwy4A0eRmV7M7E0lDpKoXlkSR+5xezeV1B
	 k/5Z6aRxkGYprceKOUSzsQnhHZ/V9Q7qGlvI2fyIWBc4sGCUAUoIty7yE8Ov5EK49I
	 F5K203hwp7TsQNpb5tStEe/tWNdMq+8qLy5fZUqk3hjYbHjODFkLVnq+8brYa+MYgf
	 TlgxH0j+1FAAyCpjhEldowAY2c+IH5YCpbSZzfbEq9bwZ/Kq4iJX1MLTDcHXn6sIoC
	 ELSuImlOop8zQ==
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
Subject: [PATCH net-next v3 06/15] tools: ynl: make yarg the first member of struct ynl_dump_state
Date: Tue, 27 Feb 2024 14:30:23 -0800
Message-ID: <20240227223032.1835527-7-kuba@kernel.org>
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

All YNL parsing code expects a pointer to struct ynl_parse_arg AKA yarg.
For dump was pass in struct ynl_dump_state, which works fine, because
struct ynl_dump_state and struct ynl_parse_arg have identical layout
for the members that matter.. but it's a bit hacky.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 3 +--
 tools/net/ynl/lib/ynl.c      | 5 ++---
 tools/net/ynl/ynl-gen-c.py   | 5 +++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 7f24d07692bf..c44b53c8d084 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -104,8 +104,7 @@ struct ynl_req_state {
 };
 
 struct ynl_dump_state {
-	struct ynl_sock *ys;
-	struct ynl_policy_nest *rsp_policy;
+	struct ynl_parse_arg yarg;
 	void *first;
 	struct ynl_dump_list_type *last;
 	size_t alloc_sz;
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 5f303d6e751f..88456c7bb1ec 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -864,7 +864,7 @@ static int ynl_dump_trampoline(const struct nlmsghdr *nlh, void *data)
 	struct ynl_parse_arg yarg = {};
 	int ret;
 
-	ret = ynl_check_alien(ds->ys, nlh, ds->rsp_cmd);
+	ret = ynl_check_alien(ds->yarg.ys, nlh, ds->rsp_cmd);
 	if (ret)
 		return ret < 0 ? MNL_CB_ERROR : MNL_CB_OK;
 
@@ -878,8 +878,7 @@ static int ynl_dump_trampoline(const struct nlmsghdr *nlh, void *data)
 		ds->last->next = obj;
 	ds->last = obj;
 
-	yarg.ys = ds->ys;
-	yarg.rsp_policy = ds->rsp_policy;
+	yarg = ds->yarg;
 	yarg.data = &obj->data;
 
 	return ds->cb(nlh, &yarg);
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 407902b903e0..6f57c9f00e7a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1844,14 +1844,15 @@ _C_KW = {
 
     ri.cw.write_func_lvar(local_vars)
 
-    ri.cw.p('yds.ys = ys;')
+    ri.cw.p('yds.yarg.ys = ys;')
+    ri.cw.p(f"yds.yarg.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
+    ri.cw.p("yds.yarg.data = NULL;")
     ri.cw.p(f"yds.alloc_sz = sizeof({type_name(ri, rdir(direction))});")
     ri.cw.p(f"yds.cb = {op_prefix(ri, 'reply', deref=True)}_parse;")
     if ri.op.value is not None:
         ri.cw.p(f'yds.rsp_cmd = {ri.op.enum_name};')
     else:
         ri.cw.p(f'yds.rsp_cmd = {ri.op.rsp_value};')
-    ri.cw.p(f"yds.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
     ri.cw.nl()
     ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
-- 
2.43.2


