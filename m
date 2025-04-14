Return-Path: <netdev+bounces-182478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F4A88DA7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEDE3B55FB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251951F30B2;
	Mon, 14 Apr 2025 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqQXAdQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209A1F192E
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665601; cv=none; b=m08ZELaJecTrA9JQL0S0EpyZC72clILNmgDjM4xongvch+BYSvei1PNGfgkVtiRSiATZA65nbBLKZriLL5mKwhHUkrl0Wky7NkmXhGnLsj9eNRswDBQe+4fhGEgXVUej3FHOtc8rNwNH99mvpL12Y5AUbd5k5nKW+X5a/Lsny/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665601; c=relaxed/simple;
	bh=wA9DaISpVLSyLHCtY6TQSuadXSecJ+W8rS/cFrO5x8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QziSmbl5JMSbpr/cuoWgyougNmUPSlC00n38Jm7iFHMuet+hons2Gn21g3qM2amTdXjvkLNLSD5OwOBca+KjbkRyr3DWZLAL4addZiFpcIZZ1OiJKzdhVLDBlKcRCgqIULFS7fbdGiq1k2RPHVqH1lyieeVohdgoQwUO2hsN/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqQXAdQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EF7C4CEEE;
	Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665600;
	bh=wA9DaISpVLSyLHCtY6TQSuadXSecJ+W8rS/cFrO5x8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqQXAdQo1CUUFLYXqGZ7UQOVDfhwMA8kNBdxG0j9U+TbvOtKzb/DGYIK71OrfLhCT
	 t00/C4wjvK3Bh8JqMLN/GymwPRpdSJjwimSN1pOVdquHsLM7m9wxreBdGJCEWHiGHB
	 5+yP8YVxLm7Ib+lIVE96K/QcAOuLhqvL40kYcxIyYkdFw6PtbQzmNn1hJDV9RMvk1B
	 3N87LxVfobH9oOwMZO7rSErRs7z+mAxjIeHvqeBycqIBxiZA+XZHMzQgSDV03r3wsi
	 wbTku4YP+WlUcLIXpbQ+A4fg2Lah/k3kTqwnJFNOyqcqVhFVUYqb2EhVGJj+mph5Ky
	 kT/4Qd15yhxmA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/8] tools: ynl-gen: individually free previous values on double set
Date: Mon, 14 Apr 2025 14:18:46 -0700
Message-ID: <20250414211851.602096-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When user calls request_attrA_set() multiple times (for the same
attribute), and attrA is of type which allocates memory -
we try to free the previously associated values. For array
types (including multi-attr) we have only freed the array,
but the array may have contained pointers.

Refactor the code generation for free attr and reuse the generated
lines in setters to flush out the previous state. Since setters
are static inlines in the header we need to add forward declarations
for the free helpers of pure nested structs. Track which types get
used by arrays and include the right forwad declarations.

At least ethtool string set and bit set would not be freed without
this. Tho, admittedly, overriding already set attribute twice is likely
a very very rare thing to do.

Fixes: be5bea1cc0bf ("net: add basic C code generators for Netlink")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 62 +++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 662a925bd9e1..2d856ccc88f4 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -162,9 +162,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def free_needs_iter(self):
         return False
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
         if self.is_multi_val() or self.presence_type() == 'len':
-            ri.cw.p(f'free({var}->{ref}{self.c_name});')
+            return [f'free({var}->{ref}{self.c_name});']
+        return []
+
+    def free(self, ri, var, ref):
+        lines = self._free_lines(ri, var, ref)
+        for line in lines:
+            ri.cw.p(line)
 
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
@@ -263,6 +269,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         var = "req"
         member = f"{var}->{'.'.join(ref)}"
 
+        local_vars = []
+        if self.free_needs_iter():
+            local_vars += ['unsigned int i;']
+
         code = []
         presence = ''
         for i in range(0, len(ref)):
@@ -272,6 +282,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             if i == len(ref) - 1 and self.presence_type() != 'bit':
                 continue
             code.append(presence + ' = 1;')
+        ref_path = '.'.join(ref[:-1])
+        if ref_path:
+            ref_path += '.'
+        code += self._free_lines(ri, var, ref_path)
         code += self._setter_lines(ri, member, presence)
 
         func_name = f"{op_prefix(ri, direction, deref=deref)}_set_{'_'.join(ref)}"
@@ -279,7 +293,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         alloc = bool([x for x in code if 'alloc(' in x])
         if free and not alloc:
             func_name = '__' + func_name
-        ri.cw.write_func('static inline void', func_name, body=code,
+        ri.cw.write_func('static inline void', func_name, local_vars=local_vars,
+                         body=code,
                          args=[f'{type_name(ri, direction, deref=deref)} *{var}'] + self.arg_member(ri))
 
 
@@ -482,8 +497,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"free({member});",
-                f"{presence}_len = strlen({self.c_name});",
+        return [f"{presence}_len = strlen({self.c_name});",
                 f"{member} = malloc({presence}_len + 1);",
                 f'memcpy({member}, {self.c_name}, {presence}_len);',
                 f'{member}[{presence}_len] = 0;']
@@ -536,8 +550,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"free({member});",
-                f"{presence}_len = len;",
+        return [f"{presence}_len = len;",
                 f"{member} = malloc({presence}_len);",
                 f'memcpy({member}, {self.c_name}, {presence}_len);']
 
@@ -574,12 +587,14 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _complex_member_type(self, ri):
         return self.nested_struct_type
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
+        lines = []
         at = '&'
         if self.is_recursive_for_op(ri):
             at = ''
-            ri.cw.p(f'if ({var}->{ref}{self.c_name})')
-        ri.cw.p(f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});')
+            lines += [f'if ({var}->{ref}{self.c_name})']
+        lines += [f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});']
+        return lines
 
     def _attr_typol(self):
         return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
@@ -632,15 +647,19 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def free_needs_iter(self):
         return 'type' not in self.attr or self.attr['type'] == 'nest'
 
-    def free(self, ri, var, ref):
+    def _free_lines(self, ri, var, ref):
+        lines = []
         if self.attr['type'] in scalars:
-            ri.cw.p(f"free({var}->{ref}{self.c_name});")
+            lines += [f"free({var}->{ref}{self.c_name});"]
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
-            ri.cw.p(f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)")
-            ri.cw.p(f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);')
-            ri.cw.p(f"free({var}->{ref}{self.c_name});")
+            lines += [
+                f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
+                f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);',
+                f"free({var}->{ref}{self.c_name});",
+            ]
         else:
             raise Exception(f"Free of MultiAttr sub-type {self.attr['type']} not supported yet")
+        return lines
 
     def _attr_policy(self, policy):
         return self.base_type._attr_policy(policy)
@@ -666,8 +685,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _setter_lines(self, ri, member, presence):
         # For multi-attr we have a count, not presence, hack up the presence
         presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
-        return [f"free({member});",
-                f"{member} = {self.c_name};",
+        return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
 
@@ -755,6 +773,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.request = False
         self.reply = False
         self.recursive = False
+        self.in_multi_val = False  # used by a MultiAttr or and legacy arrays
 
         self.attr_list = []
         self.attrs = dict()
@@ -1122,6 +1141,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                     if attr in rs_members['reply']:
                         self.pure_nested_structs[nested].reply = True
 
+                if spec.is_multi_val():
+                    child = self.pure_nested_structs.get(nested)
+                    child.in_multi_val = True
+
         self._sort_pure_types()
 
         # Propagate the request / reply / recursive
@@ -1136,6 +1159,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                             struct.child_nests.update(child.child_nests)
                         child.request |= struct.request
                         child.reply |= struct.reply
+                        if spec.is_multi_val():
+                            child.in_multi_val = True
                 if attr_set in struct.child_nests:
                     struct.recursive = True
 
@@ -2958,6 +2983,9 @@ _C_KW = {
             for attr_set, struct in parsed.pure_nested_structs.items():
                 ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
                 print_type_full(ri, struct)
+                if struct.request and struct.in_multi_val:
+                    free_rsp_nested_prototype(ri)
+                    cw.nl()
 
             for op_name, op in parsed.ops.items():
                 cw.p(f"/* ============== {op.enum_name} ============== */")
-- 
2.49.0


