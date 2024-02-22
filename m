Return-Path: <netdev+bounces-74199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C34860731
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F17F1F21C51
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E186B140E23;
	Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lISr1DoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C002914039E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646188; cv=none; b=TpRJeOPCNmhyX+0Ct05rGK+u1ott8NuybC+v3Aj3PfTDuR2RQl0Q3brZ5gJBHnzU15tYqtLsXpO/2haXRrRVMUPrIpbZKkVXyoYJm6afjJdjqME2Mqj70RRvHnIGKx5/gi9I1TLNulcDuTmRTdNP1oxB+n97kSFcnwz05jCmbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646188; c=relaxed/simple;
	bh=rrvznzMnxH02c4XJH4foH1NB4GxvVQ+gEvb8iSMXsfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBxWgUu8r23ob3B5N9wOPto05O1ZsvArpi/Lghlca1j6vBWaPjPTVOcNM3jEnzjZ7CTsqiKVbtVJ/JHl7hRpqgvWCX9QRCf3dI/CNpwkZauxi/mmQLvkR+YZb6ue2zYWMahkU4+znz89QznONeDhX+nw+0hdO3XMeRYZkmOL8aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lISr1DoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B89C433C7;
	Thu, 22 Feb 2024 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646188;
	bh=rrvznzMnxH02c4XJH4foH1NB4GxvVQ+gEvb8iSMXsfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lISr1DoTJEqqsWbcE9xaILhRUWBMM7X5vWPdZIRWHgjiB75OlM4PeheQK64oV5x9C
	 JbhPwLM5nKqGaFHj7xtqec8mWLqwtCsSjQrLZO0FlRbkAvJkDDOwzvoe1syUU/f46r
	 79Y8aKghfvbyjZCr0R5ZUGBTCoPH/cOpZHn9pwdBH4PQoQ1xdx4tH+5/hMow+7V1dt
	 ynZlrQt4Uo6Wll8PFfkr0TksjcTd6WtpyoiRG+jsxoW33f1OaYn1kBz1/W3HLtVU9v
	 6Az0ZeOYXKC/UVY7DZDwqeozEqsBwS7RSbnxb2xuJ50J/8r+3j+OuNgDAw0gCNAPLJ
	 7Q2gCNmXcCLtA==
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
Subject: [PATCH net-next 06/15] tools: ynl: make yarg the first member of struct ynl_dump_state
Date: Thu, 22 Feb 2024 15:56:05 -0800
Message-ID: <20240222235614.180876-7-kuba@kernel.org>
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

All YNL parsing code expects a pointer to struct ynl_parse_arg AKA yarg.
For dump was pass in struct ynl_dump_state, which works fine, because
struct ynl_dump_state and struct ynl_parse_arg have identical layout
for the members that matter.. but it's a bit hacky.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h | 3 +--
 tools/net/ynl/lib/ynl.c      | 5 ++---
 tools/net/ynl/ynl-gen-c.py   | 5 +++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 0df0edd1af9a..eb109170102d 100644
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
index 39f7c7b23443..ec3bc7baadd1 100644
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
index 6366f69e210c..5d174ce67dbc 100755
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


