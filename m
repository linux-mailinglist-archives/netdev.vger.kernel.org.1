Return-Path: <netdev+bounces-190884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88528AB92C6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0024F3BF6F5
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0FB2951D1;
	Thu, 15 May 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG32eDQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03F294A0E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351030; cv=none; b=mwrDxdxOc7gq45Oo3PSPzSsbFBiG7l1ic3FJfNPRCmaWdlSP1sn21WOj3GNNhlhaHpq1Do4M72P5OgK8f3G8jXeyFLaKg/fbqMkrESQi6Lh6yx/+nCT2///B7pPtFt8cy8XGJpsZMbZGT8FpXU50A0WEZkcWzgK6USQ1gRotlsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351030; c=relaxed/simple;
	bh=1d/4hHtwtfQEgWHO8d3rIY4w7zzgN70EbvbCPfXFOfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXNBbYvZGxPvBig5QtQldSywo7KJRRrBlUcM1laZsra8WQX3rRsS6ajyx8tQEmBzO+n7/8gLW1FL+atg8vpE7HW8OEaaVXkV0Ptul8fHYVj12fIiSN3w7ttfTCekUI+5wZDP+ma3Ufur7CsYISn1B+36NUP9i93/tXoZBQgguUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG32eDQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD938C4CEE7;
	Thu, 15 May 2025 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351030;
	bh=1d/4hHtwtfQEgWHO8d3rIY4w7zzgN70EbvbCPfXFOfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qG32eDQpOb/teB5hqjXSiQIAfoEcrqgc9yqg915qOzhfVpKYv/CXlvS0Ox7GhAZ9w
	 u33yobnrJKLRI8GzIrIlD6XiVt8jc/QHKvYW4p+m6oaURpZNMwkGkrF20OgrxCaKaW
	 rQLLq/3yl4xbQ9kxwKLhzx+73ct44P0WK5DDbWr1pwFpsrlZQq08QC06t36HUP0swl
	 HorQ0+OZaVD8N5iqP0kMRSlNvDZ1Sl/kPcui5azQ/2u/ueuWLwIgUv5M9Qdg1LPh0o
	 Ug5V3LEbnYQ1BFRigSPHT5eEHLzjvp0LbDewc0HxyVtSlSWllJTUOo4XGKqqC2Zfms
	 ZR1fP8Lf87l+w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/9] tools: ynl-gen: submsg: support parsing and rendering sub-messages
Date: Thu, 15 May 2025 16:16:47 -0700
Message-ID: <20250515231650.1325372-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust parsing and rendering appropriately to make sub-messages work.
Rendering is pretty trivial, as the submsg -> netlink conversion looks
like rendering a nest in which only one attr was set. Only trick
is that we use the enum value of the sub-message rather than the nest
as the type, and effectively skip one layer of nesting. A real double
nested struct would look like this:

  [SELECTOR]
  [SUBMSG]
    [NEST]
      [MSG1-ATTR]

A submsg "is" the nest so by skipping I mean:

  [SELECTOR]
  [SUBMSG]
    [MSG1-ATTR]

There is no extra validation in YNL if caller has set the selector
matching the submsg type (e.g. link type = "macvlan" but the nest
attrs are set to carry "veth"). Let the kernel handle that.

Parsing side is a little more specialized as we need to render and
insert a new kind of function which switches between what to parse
based on the selector. But code isn't too complicated.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  3 ++
 tools/net/ynl/lib/ynl.h          |  1 +
 tools/net/ynl/lib/ynl.c          |  9 ++++
 tools/net/ynl/pyynl/ynl_gen_c.py | 80 ++++++++++++++++++++++++++++++--
 4 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 5debb09491e7..fbc058dd1c3e 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -25,6 +25,7 @@ enum ynl_policy_type {
 	YNL_PT_UINT,
 	YNL_PT_NUL_STR,
 	YNL_PT_BITFIELD32,
+	YNL_PT_SUBMSG,
 };
 
 enum ynl_parse_result {
@@ -103,6 +104,8 @@ struct nlmsghdr *
 ynl_gemsg_start_dump(struct ynl_sock *ys, __u32 id, __u8 cmd, __u8 version);
 
 int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr);
+int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
+		      const char *sel_name);
 
 /* YNL specific helpers used by the auto-generated code */
 
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 32efeb224829..db7c0591a63f 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -23,6 +23,7 @@ enum ynl_error_code {
 	YNL_ERROR_INV_RESP,
 	YNL_ERROR_INPUT_INVALID,
 	YNL_ERROR_INPUT_TOO_BIG,
+	YNL_ERROR_SUBMSG_KEY,
 };
 
 /**
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index a0b54ad4c073..25fc6501349b 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -384,6 +384,15 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 	return 0;
 }
 
+int ynl_submsg_failed(struct ynl_parse_arg *yarg, const char *field_name,
+		      const char *sel_name)
+{
+	yerr(yarg->ys, YNL_ERROR_SUBMSG_KEY,
+	     "Parsing error: Sub-message key not set (msg %s, key %s)",
+	     field_name, sel_name);
+	return YNL_PARSE_CB_ERROR;
+}
+
 /* Generic code */
 
 static void ynl_err_reset(struct ynl_sock *ys)
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 020aa34b890b..b6b54d6fa906 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -878,7 +878,16 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
 
 class TypeSubMessage(TypeNest):
-    pass
+    def _attr_get(self, ri, var):
+        sel = c_lower(self['selector'])
+        get_lines = [f'if (!{var}->{sel})',
+                     f'return ynl_submsg_failed(yarg, "%s", "%s");' %
+                        (self.name, self['selector']),
+                    f"if ({self.nested_render_name}_parse(&parg, {var}->{sel}, attr))",
+                     "return YNL_PARSE_CB_ERROR;"]
+        init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
+                      f"parg.data = &{var}->{self.c_name};"]
+        return get_lines, init_lines, None
 
 
 class Struct:
@@ -1818,11 +1827,34 @@ _C_KW = {
     print_prototype(ri, "request")
 
 
+def put_typol_submsg(cw, struct):
+    cw.block_start(line=f'const struct ynl_policy_attr {struct.render_name}_policy[] =')
+
+    i = 0
+    for name, arg in struct.member_list():
+        cw.p('[%d] = { .type = YNL_PT_SUBMSG, .name = "%s", .nest = &%s_nest, },' %
+             (i, name, arg.nested_render_name))
+        i += 1
+
+    cw.block_end(line=';')
+    cw.nl()
+
+    cw.block_start(line=f'const struct ynl_policy_nest {struct.render_name}_nest =')
+    cw.p(f'.max_attr = {i - 1},')
+    cw.p(f'.table = {struct.render_name}_policy,')
+    cw.block_end(line=';')
+    cw.nl()
+
+
 def put_typol_fwd(cw, struct):
     cw.p(f'extern const struct ynl_policy_nest {struct.render_name}_nest;')
 
 
 def put_typol(cw, struct):
+    if struct.submsg:
+        put_typol_submsg(cw, struct)
+        return
+
     type_max = struct.attr_set.max_name
     cw.block_start(line=f'const struct ynl_policy_attr {struct.render_name}_policy[{type_max} + 1] =')
 
@@ -1908,8 +1940,9 @@ _C_KW = {
     local_vars = []
     init_lines = []
 
-    local_vars.append('struct nlattr *nest;')
-    init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
+    if struct.submsg is None:
+        local_vars.append('struct nlattr *nest;')
+        init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
 
     has_anest = False
     has_count = False
@@ -1931,7 +1964,8 @@ _C_KW = {
     for _, arg in struct.member_list():
         arg.attr_put(ri, "obj")
 
-    ri.cw.p("ynl_attr_nest_end(nlh, nest);")
+    if struct.submsg is None:
+        ri.cw.p("ynl_attr_nest_end(nlh, nest);")
 
     ri.cw.nl()
     ri.cw.p('return 0;')
@@ -1968,6 +2002,7 @@ _C_KW = {
         if 'multi-attr' in aspec:
             multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
+        needs_parg |= 'sub-message' in aspec
     if array_nests or multi_attrs:
         local_vars.append('int i;')
     if needs_parg:
@@ -2086,9 +2121,43 @@ _C_KW = {
     ri.cw.nl()
 
 
+def parse_rsp_submsg(ri, struct):
+    parse_rsp_nested_prototype(ri, struct, suffix='')
+
+    var = 'dst'
+
+    ri.cw.block_start()
+    ri.cw.write_func_lvar(['const struct nlattr *attr = nested;',
+                          f'{struct.ptr_name}{var} = yarg->data;',
+                          'struct ynl_parse_arg parg;'])
+
+    ri.cw.p('parg.ys = yarg->ys;')
+    ri.cw.nl()
+
+    first = True
+    for name, arg in struct.member_list():
+        kw = 'if' if first else 'else if'
+        first = False
+
+        ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
+        get_lines, init_lines, _ = arg._attr_get(ri, var)
+        for line in init_lines:
+            ri.cw.p(line)
+        for line in get_lines:
+            ri.cw.p(line)
+        if arg.presence_type() == 'present':
+            ri.cw.p(f"{var}->_present.{arg.c_name} = 1;")
+        ri.cw.block_end()
+    ri.cw.p('return 0;')
+    ri.cw.block_end()
+    ri.cw.nl()
+
+
 def parse_rsp_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct ynl_parse_arg *yarg',
                  'const struct nlattr *nested']
+    if struct.submsg:
+        func_args.insert(1, 'const char *sel')
     for arg in struct.inherited:
         func_args.append('__u32 ' + arg)
 
@@ -2097,6 +2166,9 @@ _C_KW = {
 
 
 def parse_rsp_nested(ri, struct):
+    if struct.submsg:
+        return parse_rsp_submsg(ri, struct)
+
     parse_rsp_nested_prototype(ri, struct, suffix='')
 
     local_vars = ['const struct nlattr *attr;',
-- 
2.49.0


