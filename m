Return-Path: <netdev+bounces-50353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D587F56BC
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 04:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37BC1C20BE3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 03:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2653B6;
	Thu, 23 Nov 2023 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMMB6uT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499855696
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 03:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E36C433C7;
	Thu, 23 Nov 2023 03:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700708926;
	bh=klUqseV8l0lfnjUd28JH2Up0zAG1lFXp7b8YUb5vO/k=;
	h=From:To:Cc:Subject:Date:From;
	b=qMMB6uT5mzVMl1eybHzTabbUU7N7NeRC3AB/l5Ak6d6JEBcNI4iCSSBrlIkDJyefI
	 pPfeY2obwzrmda8DzQoX+V6I3N7jjxA6Z8mI9M0q+0k7uu9zfoRTqDrD69TIkSdsxF
	 /IY24TbUICbKN4SKwGsrNAlaT1mqd8tKviaq9VooqS4tZiizhunZrNDbusWTnW7GYx
	 yWtfQftNxR2guyq11MUcmCDmK5cl0Nqa4FHklOMndyJK94rfVkXSdzetFT8Vrp8MaV
	 eDvsJO+CPu2TsoBSHElCLa/G41RREKcmjxofm5aC9uSlIQESH7cgay4jllBrZvxy5f
	 O4HOdbdo6DZCA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl-get: use family c-name
Date: Wed, 22 Nov 2023 19:08:44 -0800
Message-ID: <20231123030844.1613340-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a new family is ever added with a dash in the name
the C codegen will break. Make sure we use the "safe"
form of the name consistently.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 46 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 0756c61f9225..88a1e50e6ba8 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -67,9 +67,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if 'nested-attributes' in attr:
             self.nested_attrs = attr['nested-attributes']
             if self.nested_attrs == family.name:
-                self.nested_render_name = f"{family.name}"
+                self.nested_render_name = c_lower(f"{family.name}")
             else:
-                self.nested_render_name = f"{family.name}_{c_lower(self.nested_attrs)}"
+                self.nested_render_name = c_lower(f"{family.name}_{self.nested_attrs}")
 
             if self.nested_attrs in self.family.consts:
                 self.nested_struct_type = 'struct ' + self.nested_render_name + '_'
@@ -335,7 +335,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         maybe_enum = not self.is_bitfield and 'enum' in self.attr
         if maybe_enum and self.family.consts[self.attr['enum']].enum_name:
-            self.type_name = f"enum {self.family.name}_{c_lower(self.attr['enum'])}"
+            self.type_name = c_lower(f"enum {self.family.name}_{self.attr['enum']}")
         elif self.is_auto_scalar:
             self.type_name = '__' + self.type[0] + '64'
         else:
@@ -685,9 +685,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         self.nested = type_list is None
         if family.name == c_lower(space_name):
-            self.render_name = f"{family.name}"
+            self.render_name = c_lower(family.name)
         else:
-            self.render_name = f"{family.name}_{c_lower(space_name)}"
+            self.render_name = c_lower(family.name + '-' + space_name)
         self.struct_name = 'struct ' + self.render_name
         if self.nested and space_name in family.consts:
             self.struct_name += '_'
@@ -841,7 +841,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def __init__(self, family, yaml, req_value, rsp_value):
         super().__init__(family, yaml, req_value, rsp_value)
 
-        self.render_name = family.name + '_' + c_lower(self.name)
+        self.render_name = c_lower(family.name + '_' + self.name)
 
         self.dual_policy = ('do' in yaml and 'request' in yaml['do']) and \
                          ('dump' in yaml and 'request' in yaml['dump'])
@@ -1431,7 +1431,7 @@ _C_KW = {
                 suffix += '_rsp'
                 suffix += '_dump' if deref else '_list'
 
-    return f"{ri.family['name']}{suffix}"
+    return f"{ri.family.c_name}{suffix}"
 
 
 def type_name(ri, direction, deref=False):
@@ -1497,11 +1497,11 @@ _C_KW = {
 
 
 def put_op_name_fwd(family, cw):
-    cw.write_func_prot('const char *', f'{family.name}_op_str', ['int op'], suffix=';')
+    cw.write_func_prot('const char *', f'{family.c_name}_op_str', ['int op'], suffix=';')
 
 
 def put_op_name(family, cw):
-    map_name = f'{family.name}_op_strmap'
+    map_name = f'{family.c_name}_op_strmap'
     cw.block_start(line=f"static const char * const {map_name}[] =")
     for op_name, op in family.msgs.items():
         if op.rsp_value:
@@ -1512,7 +1512,7 @@ _C_KW = {
     cw.block_end(line=';')
     cw.nl()
 
-    _put_enum_to_str_helper(cw, family.name + '_op', map_name, 'op')
+    _put_enum_to_str_helper(cw, family.c_name + '_op', map_name, 'op')
 
 
 def put_enum_to_str_fwd(family, cw, enum):
@@ -1834,7 +1834,7 @@ _C_KW = {
     if ri.op_mode == 'dump':
         suffix += '_dump'
 
-    ri.cw.block_start(line=f"struct {ri.family['name']}{suffix}")
+    ri.cw.block_start(line=f"struct {ri.family.c_name}{suffix}")
 
     meta_started = False
     for _, attr in struct.member_list():
@@ -2100,7 +2100,7 @@ _C_KW = {
             cnt = len(family.ops)
 
         qual = 'static const' if not exported else 'const'
-        line = f"{qual} struct {struct_type} {family.name}_nl_ops[{cnt}]"
+        line = f"{qual} struct {struct_type} {family.c_name}_nl_ops[{cnt}]"
         if terminate:
             cw.p(f"extern {line};")
         else:
@@ -2243,7 +2243,7 @@ _C_KW = {
     if not family.mcgrps['list']:
         return
 
-    cw.block_start('static const struct genl_multicast_group ' + family.name + '_nl_mcgrps[] =')
+    cw.block_start('static const struct genl_multicast_group ' + family.c_name + '_nl_mcgrps[] =')
     for grp in family.mcgrps['list']:
         name = grp['name']
         grp_id = c_upper(f"{family.name}-nlgrp-{name}")
@@ -2256,7 +2256,7 @@ _C_KW = {
     if not kernel_can_gen_family_struct(family):
         return
 
-    cw.p(f"extern struct genl_family {family.name}_nl_family;")
+    cw.p(f"extern struct genl_family {family.c_name}_nl_family;")
     cw.nl()
 
 
@@ -2271,14 +2271,14 @@ _C_KW = {
     cw.p('.parallel_ops\t= true,')
     cw.p('.module\t\t= THIS_MODULE,')
     if family.kernel_policy == 'per-op':
-        cw.p(f'.ops\t\t= {family.name}_nl_ops,')
-        cw.p(f'.n_ops\t\t= ARRAY_SIZE({family.name}_nl_ops),')
+        cw.p(f'.ops\t\t= {family.c_name}_nl_ops,')
+        cw.p(f'.n_ops\t\t= ARRAY_SIZE({family.c_name}_nl_ops),')
     elif family.kernel_policy == 'split':
-        cw.p(f'.split_ops\t= {family.name}_nl_ops,')
-        cw.p(f'.n_split_ops\t= ARRAY_SIZE({family.name}_nl_ops),')
+        cw.p(f'.split_ops\t= {family.c_name}_nl_ops,')
+        cw.p(f'.n_split_ops\t= ARRAY_SIZE({family.c_name}_nl_ops),')
     if family.mcgrps['list']:
-        cw.p(f'.mcgrps\t\t= {family.name}_nl_mcgrps,')
-        cw.p(f'.n_mcgrps\t= ARRAY_SIZE({family.name}_nl_mcgrps),')
+        cw.p(f'.mcgrps\t\t= {family.c_name}_nl_mcgrps,')
+        cw.p(f'.n_mcgrps\t= ARRAY_SIZE({family.c_name}_nl_mcgrps),')
     cw.block_end(';')
 
 
@@ -2288,7 +2288,7 @@ _C_KW = {
         if obj[enum_name]:
             start_line = 'enum ' + c_lower(obj[enum_name])
     elif ckey and ckey in obj:
-        start_line = 'enum ' + family.name + '_' + c_lower(obj[ckey])
+        start_line = 'enum ' + family.c_name + '_' + c_lower(obj[ckey])
     cw.block_start(line=start_line)
 
 
@@ -2472,7 +2472,7 @@ _C_KW = {
         cw.nl()
 
     cw.block_start(f'{symbol} = ')
-    cw.p(f'.name\t\t= "{family.name}",')
+    cw.p(f'.name\t\t= "{family.c_name}",')
     if family.ntfs:
         cw.p(f".ntf_info\t= {family['name']}_ntf_info,")
         cw.p(f".ntf_info_size\t= MNL_ARRAY_SIZE({family['name']}_ntf_info),")
@@ -2554,7 +2554,7 @@ _C_KW = {
         render_uapi(parsed, cw)
         return
 
-    hdr_prot = f"_LINUX_{parsed.name.upper()}_GEN_H"
+    hdr_prot = f"_LINUX_{parsed.c_name.upper()}_GEN_H"
     if args.header:
         cw.p('#ifndef ' + hdr_prot)
         cw.p('#define ' + hdr_prot)
-- 
2.42.0


