Return-Path: <netdev+bounces-191246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E82ABA750
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBAA1C00DF1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E923BB44;
	Sat, 17 May 2025 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjUV4lAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2553C38384
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440816; cv=none; b=gN1xjBczESLKcqB4NRSEkY8ebHGtsNhpOqi9L4eV1tXBmEXtLLEcIzBRiE66gMDHgg8XnEcV3Ox91DPWLm9snAEd8teVHTTlDqdKX3HvjwJOnEJJnGV3hqjPtR/5eFr90kzYsDlU9SLCNl+RlytY1bWMbu9++kiKVZPI6uyUlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440816; c=relaxed/simple;
	bh=bPbXIwNurlPIbTe+9X1mL8ZuKzb2+0jtsgMQ9OA0lcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqgjrLpuhBvKM2/8v0qg8eaFN6gUFBS6HfQTmUKuEfb5RVxE/fg9JDzB9JXO6fB6d0uAbNZ3ttzkJIAo49KJ65lYVPDvriZxUOxN2aL4c4/m6fI8LfdsBRKkX5TrznqxvxIN/M/TO/AdJ4AxwtVyFIbFxW+P1pUhzZ7vSsC5NhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjUV4lAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB35C4CEF5;
	Sat, 17 May 2025 00:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440815;
	bh=bPbXIwNurlPIbTe+9X1mL8ZuKzb2+0jtsgMQ9OA0lcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjUV4lALzXYFRc2W64uqtwJvk+nd8i2eGrvqV23/PsKP+yaRXWclJNpW2OKdHHfcs
	 P71rUyT/kdn8fcqAg9e45eFLeSQSoDn5CfkyJ4WfhzL8pUHTYRrwzJuJ8gXC010VtG
	 01MiI/cTL8CbCl7ZkBqhv3YYXW7QQqNQhF57au6tfF5BMTyogECqHrXU9y+LXV3VED
	 o7ceJWxNRnkfNSDvzysVg7hP+vhzfz9dI0sZgJktoVcurmklTuPhF+lHUWGfEx7dNs
	 OuyptmzwnaGk6UZKqOgWLzf8ADPcOpVpA7H8cawKbhNqbHBjb08+S/UiNejAAGUsDK
	 gg9DrY/eozbjA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/11] tools: ynl-gen: support weird sub-message formats
Date: Fri, 16 May 2025 17:13:15 -0700
Message-ID: <20250517001318.285800-9-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TC uses all possible sub-message formats:
 - nested attrs
 - fixed headers + nested attrs
 - fixed headers
 - empty

Nested attrs are already supported for rt-link. Add support
for remaining 3. The empty and fixed headers ones are fairly
trivial, we can fake a Binary or Flags type instead of a Nest.

For fixed headers + nest we need to teach nest parsing and
nest put to handle fixed headers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl-priv.h     |  8 +++--
 tools/net/ynl/pyynl/ynl_gen_c.py | 51 ++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/tools/net/ynl/lib/ynl-priv.h b/tools/net/ynl/lib/ynl-priv.h
index 416866f85820..824777d7e05e 100644
--- a/tools/net/ynl/lib/ynl-priv.h
+++ b/tools/net/ynl/lib/ynl-priv.h
@@ -213,11 +213,15 @@ static inline void *ynl_attr_data_end(const struct nlattr *attr)
 				     NLMSG_HDRLEN + fixed_hdr_sz); attr; \
 	     (attr) = ynl_attr_next(ynl_nlmsg_end_addr(nlh), attr))
 
-#define ynl_attr_for_each_nested(attr, outer)				\
+#define ynl_attr_for_each_nested_off(attr, outer, offset)		\
 	for ((attr) = ynl_attr_first(outer, outer->nla_len,		\
-				     sizeof(struct nlattr)); attr;	\
+				     sizeof(struct nlattr) + offset);	\
+	     attr;							\
 	     (attr) = ynl_attr_next(ynl_attr_data_end(outer), attr))
 
+#define ynl_attr_for_each_nested(attr, outer)				\
+	ynl_attr_for_each_nested_off(attr, outer, 0)
+
 #define ynl_attr_for_each_payload(start, len, attr)			\
 	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
 	     (attr) = ynl_attr_next(start + len, attr))
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index f2a4404d0d21..5abf7dd86f42 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1372,12 +1372,25 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
         attrs = []
         for name, fmt in submsg.formats.items():
-            attrs.append({
+            attr = {
                 "name": name,
-                "type": "nest",
                 "parent-sub-message": spec,
-                "nested-attributes": fmt['attribute-set']
-            })
+            }
+            if 'attribute-set' in fmt:
+                attr |= {
+                    "type": "nest",
+                    "nested-attributes": fmt['attribute-set'],
+                }
+                if 'fixed-header' in fmt:
+                    attr |= { "fixed-header": fmt["fixed-header"] }
+            elif 'fixed-header' in fmt:
+                attr |= {
+                    "type": "binary",
+                    "struct": fmt["fixed-header"],
+                }
+            else:
+                attr["type"] = "flag"
+            attrs.append(attr)
 
         self.attr_sets[nested] = AttrSet(self, {
             "name": nested,
@@ -1921,8 +1934,11 @@ _C_KW = {
 
     i = 0
     for name, arg in struct.member_list():
-        cw.p('[%d] = { .type = YNL_PT_SUBMSG, .name = "%s", .nest = &%s_nest, },' %
-             (i, name, arg.nested_render_name))
+        nest = ""
+        if arg.type == 'nest':
+            nest = f" .nest = &{arg.nested_render_name}_nest,"
+        cw.p('[%d] = { .type = YNL_PT_SUBMSG, .name = "%s",%s },' %
+             (i, name, nest))
         i += 1
 
     cw.block_end(line=';')
@@ -2032,6 +2048,11 @@ _C_KW = {
     if struct.submsg is None:
         local_vars.append('struct nlattr *nest;')
         init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
+    if struct.fixed_header:
+        local_vars.append('void *hdr;')
+        struct_sz = f'sizeof({struct.fixed_header})'
+        init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
+        init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
 
     has_anest = False
     has_count = False
@@ -2063,11 +2084,14 @@ _C_KW = {
 
 
 def _multi_parse(ri, struct, init_lines, local_vars):
+    if struct.fixed_header:
+        local_vars += ['void *hdr;']
     if struct.nested:
-        iter_line = "ynl_attr_for_each_nested(attr, nested)"
-    else:
         if struct.fixed_header:
-            local_vars += ['void *hdr;']
+            iter_line = f"ynl_attr_for_each_nested_off(attr, nested, sizeof({struct.fixed_header}))"
+        else:
+            iter_line = "ynl_attr_for_each_nested(attr, nested)"
+    else:
         iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
         if ri.op.fixed_header != ri.family.fixed_header:
             if ri.family.is_classic():
@@ -2114,7 +2138,9 @@ _C_KW = {
         ri.cw.p(f'dst->{arg} = {arg};')
 
     if struct.fixed_header:
-        if ri.family.is_classic():
+        if struct.nested:
+            ri.cw.p('hdr = ynl_attr_data(nested);')
+        elif ri.family.is_classic():
             ri.cw.p('hdr = ynl_nlmsg_data(nlh);')
         else:
             ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
@@ -2234,8 +2260,9 @@ _C_KW = {
 
         ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
         get_lines, init_lines, _ = arg._attr_get(ri, var)
-        for line in init_lines:
-            ri.cw.p(line)
+        if init_lines:
+            for line in init_lines:
+                ri.cw.p(line)
         for line in get_lines:
             ri.cw.p(line)
         if arg.presence_type() == 'present':
-- 
2.49.0


