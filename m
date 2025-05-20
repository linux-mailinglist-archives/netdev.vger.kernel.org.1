Return-Path: <netdev+bounces-191962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409CABE08B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8535818943DD
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079427CCE3;
	Tue, 20 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1So+Y8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACDC27CCDF
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757969; cv=none; b=ho7JnMkLSNPtcMEeGklezGnTkmC9Ga7k9V3edkoU2ZMS4NOU5uTL+UAg75Ds364GqB10iM7E4dBwdttnpZou6r4DFL8HKTyEACYX4U/MNEpjof6qaolIoV7S3BUw7HYhHv8TL+P+9NtJl4cA4dKez1Mxw0+32N4Wdv+ne4NFkK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757969; c=relaxed/simple;
	bh=pXO8GkkLvCrVTO6o0DXeYyL2uO9W6Zh6FGSKBnVS1tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rtv13eZouF1joTMEO9IbKonKO7HJQBDIa+QCjlPMB6+VS/yb42XltjLXpNJOxJ8JrZMadn3RGE9PYIM5XX9UAnStDuxkrFraUI5G7ngsI/9CmVf2d5yCuuAuwlf5OmTD36kTEq/z2P0MtA7rpm21DQJ5RBErdsCYNRWgTydTbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1So+Y8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFAFC4CEEA;
	Tue, 20 May 2025 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757968;
	bh=pXO8GkkLvCrVTO6o0DXeYyL2uO9W6Zh6FGSKBnVS1tU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1So+Y8tLiaOlJXhYl3q4n8WcWAfQ824m7meH7KBLFLF8iqOiudKi+pmBcWbVltBE
	 agEvXSNIAaBz2BuUcJh33H40dgK8umZaHmLKv7U7Yu8jRr57D09IHHbB+WVc3w1mlH
	 kFatJmwvjz2PMWBJZUVZKjyxyqB5Z8iaddytT4hCm61gw9h0u4pvcCyDBnQ9zXQIrN
	 zdq5m5Kd6Biaunop7s3Vm6xEUvYDe5moQyOxGtM0txUesBd7IqVBQyTK69pS6pjapA
	 VRIjDN+2ierCN8+tM57wDekByfW5mXwRvVDqBwNaJsmB42jvUTJ+56NW95CpTEAEtW
	 B9Qv5zh89buqg==
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
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 09/12] tools: ynl-gen: support weird sub-message formats
Date: Tue, 20 May 2025 09:19:13 -0700
Message-ID: <20250520161916.413298-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - refactor for when init_lines is None
v1: https://lore.kernel.org/20250517001318.285800-9-kuba@kernel.org
---
 tools/net/ynl/lib/ynl-priv.h     |  8 ++++--
 tools/net/ynl/pyynl/ynl_gen_c.py | 48 ++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 13 deletions(-)

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
index f2a4404d0d21..76032e01c2e7 100755
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
@@ -2234,7 +2260,7 @@ _C_KW = {
 
         ri.cw.block_start(line=f'{kw} (!strcmp(sel, "{name}"))')
         get_lines, init_lines, _ = arg._attr_get(ri, var)
-        for line in init_lines:
+        for line in init_lines or []:
             ri.cw.p(line)
         for line in get_lines:
             ri.cw.p(line)
-- 
2.49.0


