Return-Path: <netdev+bounces-187780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2AFAA99BA
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BFB7A8555
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382426A0FC;
	Mon,  5 May 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9PWxU8J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E26A08A
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463941; cv=none; b=BYbznpZ3K4ZPe03ADdz6h+4PDVgob38e/GMVgTlu5sMO6eZJ8rq7Gf4kk8DG090A2rroLdkCY2JeJHloc7l3gzAYAfCWA233xHcmrCHYm5ZRJibLOhQpLmnjCSlEWMPGfaNUIk+RqIV6TEr0Dl1Z1/94kwuI4jRvRWEb+tybDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463941; c=relaxed/simple;
	bh=VXv4NeeFmH/lzCX0pU3YcwZRLMcd3sSpEMW/6mVLbig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGpNor969sy/Ucj7sW4kHiJ7YFqaoTngCzEkOadMfQT387Jn+ZaqiBguru5R0y+EKzOM17ZU29V3ZMpa+n7IEHe4sBq+6gatO7Z1MxA4M84jxW+TFf8X1mFcH5KjfbjxwIeByXoAZU9kMN1E9D9yisYTn0wzKGZt5kkVHmA+unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9PWxU8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D711EC4CEF3;
	Mon,  5 May 2025 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463941;
	bh=VXv4NeeFmH/lzCX0pU3YcwZRLMcd3sSpEMW/6mVLbig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9PWxU8JY6Cs/rkJtOFO+rrdZqbhnv8aLhews13/+zHdodHtDxZZbfb9b+pHhKTSc
	 5wybUNt7gkCOYmAbt7PlWXz0dFM2iUzwdNkowAJxKVf5vObWGKpyeZl0zXvuHbX7WC
	 onWmTgCwLjUKYioCH8iqguEV9c0hrpVRb73UGq560G1stJ1khYq7fpu9EFPC+7nZL8
	 JPF8DSvqv7rb1yyjEu42Mk11+UL6tVS0iW9X0j4rXTix9uJCfUIndQw82z1JP96+fQ
	 BUzniICtJeTxpbOblWJEJp9ZTCtu6n96jag4EUzQ6UmQ4k2w8FhSFWV4kVqRH8cs15
	 jq0OokF2pTKfw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] tools: ynl-gen: move the count into a presence struct too
Date: Mon,  5 May 2025 09:52:07 -0700
Message-ID: <20250505165208.248049-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505165208.248049-1-kuba@kernel.org>
References: <20250505165208.248049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While we reshuffle the presence members, move the counts as well.
Previously array count members would have been place directly in
the struct, so:

  struct family_op_req {
      struct {
            u32 a:1;
            u32 b:1;
      } _present;
      struct {
            u32 bin;
      } _len;

      u32 a;
      u64 b;
      const unsigned char *bin;
      u32 n_multi;                 << count
      u32 *multi;                  << objects
  };

Since len has been moved to its own presence struct move the count
as well:

  struct family_op_req {
      struct {
            u32 a:1;
            u32 b:1;
      } _present;
      struct {
            u32 bin;
      } _len;
      struct {
            u32 multi;             << count
      } _count;

      u32 a;
      u64 b;
      const unsigned char *bin;
      u32 *multi;                  << objects
  };

This improves the consistency and allows us to remove some hacks
in the codegen. Unlike for len there is no known name collision
with the existing scheme.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/samples/devlink.c  |  5 +++--
 tools/net/ynl/pyynl/ynl_gen_c.py | 32 +++++++++++++-------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/net/ynl/samples/devlink.c b/tools/net/ynl/samples/devlink.c
index 3d32a6335044..ac9dfb01f280 100644
--- a/tools/net/ynl/samples/devlink.c
+++ b/tools/net/ynl/samples/devlink.c
@@ -22,6 +22,7 @@ int main(int argc, char **argv)
 	ynl_dump_foreach(devs, d) {
 		struct devlink_info_get_req *info_req;
 		struct devlink_info_get_rsp *info_rsp;
+		unsigned i;
 
 		printf("%s/%s:\n", d->bus_name, d->dev_name);
 
@@ -36,9 +37,9 @@ int main(int argc, char **argv)
 
 		if (info_rsp->_len.info_driver_name)
 			printf("    driver: %s\n", info_rsp->info_driver_name);
-		if (info_rsp->n_info_version_running)
+		if (info_rsp->_count.info_version_running)
 			printf("    running fw:\n");
-		for (unsigned i = 0; i < info_rsp->n_info_version_running; i++)
+		for (i = 0; i < info_rsp->_count.info_version_running; i++)
 			printf("        %s: %s\n",
 			       info_rsp->info_version_running[i].info_version_name,
 			       info_rsp->info_version_running[i].info_version_value);
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 800710fe96c9..65c83818b2ed 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -152,7 +152,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             pfx = '__' if space == 'user' else ''
             return f"{pfx}u32 {self.c_name}:1;"
 
-        if self.presence_type() == 'len':
+        if self.presence_type() in {'len', 'count'}:
             pfx = '__' if space == 'user' else ''
             return f"{pfx}u32 {self.c_name};"
 
@@ -185,8 +185,6 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def struct_member(self, ri):
         member = self._complex_member_type(ri)
         if member:
-            if self.is_multi_val():
-                ri.cw.p(f"unsigned int n_{self.c_name};")
             ptr = '*' if self.is_multi_val() else ''
             if self.is_recursive_for_op(ri):
                 ptr = '*'
@@ -673,13 +671,13 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             lines += [f"free({var}->{ref}{self.c_name});"]
         elif self.attr['type'] == 'string':
             lines += [
-                f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
+                f"for (i = 0; i < {var}->{ref}_count.{self.c_name}; i++)",
                 f"free({var}->{ref}{self.c_name}[i]);",
                 f"free({var}->{ref}{self.c_name});",
             ]
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
             lines += [
-                f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
+                f"for (i = 0; i < {var}->{ref}_count.{self.c_name}; i++)",
                 f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);',
                 f"free({var}->{ref}{self.c_name});",
             ]
@@ -699,24 +697,22 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def attr_put(self, ri, var):
         if self.attr['type'] in scalars:
             put_type = self.type
-            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
         elif self.attr['type'] == 'binary' and 'struct' in self.attr:
-            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, &{var}->{self.c_name}[i], sizeof(struct {c_lower(self.attr['struct'])}));")
         elif self.attr['type'] == 'string':
-            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_str(nlh, {self.enum_name}, {var}->{self.c_name}[i]->str);")
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
-            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->_count.{self.c_name}; i++)")
             self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
                                 f"{self.enum_name}, &{var}->{self.c_name}[i])")
         else:
             raise Exception(f"Put of MultiAttr sub-type {self.attr['type']} not supported yet")
 
     def _setter_lines(self, ri, member, presence):
-        # For multi-attr we have a count, not presence, hack up the presence
-        presence = presence[:-(len('_count.') + len(self.c_name))] + "n_" + self.c_name
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
@@ -759,7 +755,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                      'ynl_attr_for_each_nested(attr2, attr) {',
                      '\tif (ynl_attr_validate(yarg, attr2))',
                      '\t\treturn YNL_PARSE_CB_ERROR;',
-                     f'\t{var}->n_{self.c_name}++;',
+                     f'\t{var}->_count.{self.c_name}++;',
                      '}']
         return get_lines, None, local_vars
 
@@ -767,19 +763,17 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
         if self.sub_type in scalars:
             put_type = self.sub_type
-            ri.cw.block_start(line=f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.block_start(line=f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, i, {var}->{self.c_name}[i]);")
             ri.cw.block_end()
         elif self.sub_type == 'binary' and 'exact-len' in self.checks:
-            ri.cw.p(f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
             ri.cw.p(f"ynl_attr_put(nlh, i, {var}->{self.c_name}[i], {self.checks['exact-len']});")
         else:
             raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
 
     def _setter_lines(self, ri, member, presence):
-        # For multi-attr we have a count, not presence, hack up the presence
-        presence = presence[:-(len('_count.') + len(self.c_name))] + "n_" + self.c_name
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
@@ -1879,7 +1873,7 @@ _C_KW = {
 
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
-        ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
+        ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
             ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
@@ -1904,7 +1898,7 @@ _C_KW = {
         aspec = struct[anest]
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
-        ri.cw.p(f"dst->n_{aspec.c_name} = n_{aspec.c_name};")
+        ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
         ri.cw.p('i = 0;')
         if 'nested-attributes' in aspec:
             ri.cw.p(f"parg.rsp_policy = &{aspec.nested_render_name}_nest;")
@@ -2181,7 +2175,7 @@ _C_KW = {
         ri.cw.p(ri.fixed_hdr + ' _hdr;')
         ri.cw.nl()
 
-    for type_filter in ['present', 'len']:
+    for type_filter in ['present', 'len', 'count']:
         meta_started = False
         for _, attr in struct.member_list():
             line = attr.presence_member(ri.ku_space, type_filter)
-- 
2.49.0


