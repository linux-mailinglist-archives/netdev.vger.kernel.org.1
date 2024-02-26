Return-Path: <netdev+bounces-75105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54378682E3
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4123F1F26B03
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4422513246A;
	Mon, 26 Feb 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns+dF/Tx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B90132462
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982431; cv=none; b=fKfPmTC924CbqUN8UIV/Pow9AuK5RhmntOYSiIN3C3rNNS8gdfsBFHE/vUf7kYuZ7KJIvSIi+tMHgJ5SIHjA8QcnkpEZwaCEuxvJNFmawPP8tWwxvhh0ATPv5lOiPNaEgBo55plI8EqOQKwZm+oQCJPEHHgLse0XXootvS2k12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982431; c=relaxed/simple;
	bh=swpf1sseSBYFp0o5Uh49hobfwQ4S/2yzCHPYZpV72a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlLLA1PUsjPlFUUYHrMl0HRPjwAeB2v8ELmwQV0s8CdQeT2FA2iSzCWrXnqsEDgpBxvXSp2YHEgVtmQUkoUCEQlC3AMuJJvxTCUjIvdZ3UM2+R0LH/Wu2nThaNDPq7lIX8VZxkPPTtqRwNjKykVgh2WJcO7Z7EJfkEx0PaZDisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns+dF/Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20FAC43399;
	Mon, 26 Feb 2024 21:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982431;
	bh=swpf1sseSBYFp0o5Uh49hobfwQ4S/2yzCHPYZpV72a4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ns+dF/TxtUpkvzJhe1AMXVQLHQYNYJGfq+P72w7iDlbqc3tYnZ/RaGsew3/OJbhPS
	 7+j3+ZkwPC4hv7MvgwXcpJvEdxKOcbs7PSG79okOG7DzW7gL3Ok4NWUOjiLj7+3n87
	 nuGCr4yz2R6CYOKglUJRM+vICxHrTrze5SHxu/CnPJskw0na0/s9bY+/kYsQBJUxud
	 8FrMzEBAjY0HdeiiHxtyj1t87xMM8M/wxPTW/OfZkDe4BxalDEUMjNZHjd6OAznvkL
	 jtEJMxeO7REkRnTdNbreaCEkTz3eulL1WdcHUYqP6qGFyJ7T8xGrWTizTyCuGNhicZ
	 QnRTjngWA/ouw==
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
Subject: [PATCH net-next v2 06/15] tools: ynl: make yarg the first member of struct ynl_dump_state
Date: Mon, 26 Feb 2024 13:20:12 -0800
Message-ID: <20240226212021.1247379-7-kuba@kernel.org>
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
index c893fd5aaf27..f427438a1abf 100644
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


