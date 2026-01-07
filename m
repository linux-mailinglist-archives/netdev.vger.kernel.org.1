Return-Path: <netdev+bounces-247705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A076BCFDA7C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C2230F0801
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA6314D0A;
	Wed,  7 Jan 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLkjvnNf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5073161A8
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788540; cv=none; b=DYhp1/9HJDTYex0wzg2+RYg+qZitnQYjcYDd8xnia5/TQB+JvwDwVWB5yPG5lDuzmAgCkNQP/40Ez727z3+aIki2eQs7cW6Tq43Jg1X7Li/eaC3y7Upuzhk5T0QVsRQHNeqATxNL8Rq9vlqpWnGYU8qdlbkMWBv75QPlw98pWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788540; c=relaxed/simple;
	bh=nO2bn1/X6Q1HJ59mIC36zIsLozrVj5jDEowErPA8Pys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3VeimaCG+Mw6cezo3ONw6fd0Y6CDwbAgbC6pr+7FKzM5p4Bd1N9yTiDiACnJFGiGEjnOly5Pegz/J+AbdmnPktkwfRL44XEUFKPWZDHsBinRtC79ooxKpXzpHjC+0wa97uVaatzbOkFueETFDzxy38HgEDZn50ZOl8NOcS95yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLkjvnNf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4327778df7fso1155651f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788536; x=1768393336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH/5sZqKOpUiqB0g18ozl06rqkBZr1JF05p9ctKLLoM=;
        b=BLkjvnNfrfx4ssGVAx4Eb7iOUsYSMrkyJmTQAKfJ/N/FXUDqrrv3kJwCRPMvqaSLSo
         YPloC5Xbi9lOx9/sBXdjwznK6unO1jgfExC9l1oOmt3ZHlJh6lSsKppuhDfYC/mp5Qp6
         O5/8MJwy8Xi3rwfXipOuLQd2sIOPigddrwvzM0jZ/pyHNcTd4sfGvAsgkvxu1A4wzfKM
         APFAZO8x2NPDADe3lrJ9hJKZ8jfK5egzavuEZBVlx8AdQE7LK54OFBg+6fm7125UuxVW
         D/8ifwfPmnglwfAk9aHXdl460XSkvS57Yc0GaOeEixYYrOzsQ1M9xgd3FEVXzVn+JM1W
         Gfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788536; x=1768393336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XH/5sZqKOpUiqB0g18ozl06rqkBZr1JF05p9ctKLLoM=;
        b=UlE+sytJ7AGQMGooL6BWJOCbcbmtYdjckrFR/XpmToC5Np56Jw1nWCCwjNVWaZTD7l
         iOwjlDgWq3mmBkca7kjQDydTJz/b/7a/Dpnwcu045UWQKdAQZpQXHBPXeIyv2Qmiy08T
         gKNNtcDYN0yiXfDxi1lhCJcC7pquJIpjrDaaVXW52mjcJxffsFoPp1VDYkaCnnJM4ODc
         F53xbYngvEct9Vg2cTFpoGNwm4kUwZNPOn+5Sftt/8EXh68TLEtR3AcS7kyQ8GDzII2Q
         LqNYMw9GqsSVCEbOZMRnnS6rb94DoyzuhO+bSrol8YLzgMuBcuYbn+DhKjWYapTzlpu/
         h8vg==
X-Forwarded-Encrypted: i=1; AJvYcCVXkKJCDIPZHc26ctf3WH6BAvF5fmiXVy4PGx9+eR3NxWT5dLu+H3oKg3MUx7talsmt2IlPBE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ZGA36USEP99uB2PjYmTe5Bmm1Yh54tbel0wP9aXb6E7kWeme
	qSrxqWiDMNUSsnyt14RW8HqfnBS3pQPveOjLEx9dwtqpv9EO2lEGfRwL
X-Gm-Gg: AY/fxX5p3wN1675qfcLnxpc4rfHMLMWHNs8F5/ofvBInnz0pK5iMBxLXvBhei78E2T/
	+1qA3+6A57jiC5sLFnSN46Eg34QrHYow+AZX4bBFzDWLCnUJccFbkBAlCI9tBEz40T4l7brUH+M
	Qaosy/Cy7XGgd7QphlR3alafaGyaC0WY6hZquNtNAWR9ObfomBPDWPL0H6dR2otgSlIdNAHhmrY
	CpfZpAzKy8eom2rfX6tCJxpslu71fkcO6SleRLc+ANf9rTohfL7qefNbvaaReFWXKBS6tQ5Wsfl
	W2TDk9lqjcYJfzv8Kt2BIIAuXKu4BHSAOyXUAI7lp2KOOdmsjNfStK2Gk+rDH0b23T17A8vJHVp
	e52vZUPjVCifFV66VuPj9ShpCcmBdXSDAZjuTW83TCJWNnZclCqpi/MrRGDi95hLKtMM4LvJQlo
	bbiQFsYFY1ETFQ65k+RZWgSb6CqSM2
X-Google-Smtp-Source: AGHT+IHQQokI8UCwIl1qsmGW6wKKtMIXY6EZfdy/rVhPq5940vQKmnLeHv327ZqS4fZ4V5156GSFJw==
X-Received: by 2002:a05:6000:1ac7:b0:432:5c43:5f with SMTP id ffacd0b85a97d-432c375b612mr3203723f8f.40.1767788535816;
        Wed, 07 Jan 2026 04:22:15 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:15 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 11/13] tools: ynl-gen-c: fix pylint warnings for returns, unused, redefined
Date: Wed,  7 Jan 2026 12:21:41 +0000
Message-ID: <20260107122143.93810-12-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following pylint warnings:

- unused-argument
- unused-variable
- no-else-return
- inconsistent-return-statements
- redefined-outer-name
- unreachable

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 100 ++++++++++++++++---------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 14d16024fe11..900896779e61 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -7,6 +7,12 @@
 # pylint: disable=too-many-nested-blocks, too-many-lines, too-few-public-methods
 # pylint: disable=broad-exception-raised, broad-exception-caught, protected-access
 
+"""
+ynl_gen_c
+
+A YNL to C code generator for both kernel and userspace protocol stubs.
+"""
+
 import argparse
 import filecmp
 import pathlib
@@ -15,7 +21,7 @@ import re
 import shutil
 import sys
 import tempfile
-import yaml
+import yaml as pyyaml
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
@@ -164,7 +170,7 @@ class Type(SpecAttr):
 
     def presence_member(self, space, type_filter):
         if self.presence_type() != type_filter:
-            return
+            return ''
 
         if self.presence_type() == 'present':
             pfx = '__' if space == 'user' else ''
@@ -173,14 +179,15 @@ class Type(SpecAttr):
         if self.presence_type() in {'len', 'count'}:
             pfx = '__' if space == 'user' else ''
             return f"{pfx}u32 {self.c_name};"
+        return ''
 
-    def _complex_member_type(self, ri):
+    def _complex_member_type(self, _ri):
         return None
 
     def free_needs_iter(self):
         return False
 
-    def _free_lines(self, ri, var, ref):
+    def _free_lines(self, _ri, var, ref):
         if self.is_multi_val() or self.presence_type() in {'count', 'len'}:
             return [f'free({var}->{ref}{self.c_name});']
         return []
@@ -278,7 +285,7 @@ class Type(SpecAttr):
     def _setter_lines(self, ri, member, presence):
         raise Exception(f"Setter not implemented for class type {self.type}")
 
-    def setter(self, ri, space, direction, deref=False, ref=None, var="req"):
+    def setter(self, ri, _space, direction, deref=False, ref=None, var="req"):
         ref = (ref if ref else []) + [self.c_name]
         member = f"{var}->{'.'.join(ref)}"
 
@@ -434,15 +441,15 @@ class TypeScalar(Type):
                 flag_cnt = len(flags['entries'])
                 mask = (1 << flag_cnt) - 1
             return f"NLA_POLICY_MASK({policy}, 0x{mask:x})"
-        elif 'full-range' in self.checks:
+        if 'full-range' in self.checks:
             return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
-        elif 'range' in self.checks:
+        if 'range' in self.checks:
             return f"NLA_POLICY_RANGE({policy}, {self.get_limit_str('min')}, {self.get_limit_str('max')})"
-        elif 'min' in self.checks:
+        if 'min' in self.checks:
             return f"NLA_POLICY_MIN({policy}, {self.get_limit_str('min')})"
-        elif 'max' in self.checks:
+        if 'max' in self.checks:
             return f"NLA_POLICY_MAX({policy}, {self.get_limit_str('max')})"
-        elif 'sparse' in self.checks:
+        if 'sparse' in self.checks:
             return f"NLA_POLICY_VALIDATE_FN({policy}, &{c_lower(self.enum_name)}_validate)"
         return super()._attr_policy(policy)
 
@@ -637,7 +644,7 @@ class TypeBinaryScalarArray(TypeBinary):
 
 
 class TypeBitfield32(Type):
-    def _complex_member_type(self, ri):
+    def _complex_member_type(self, _ri):
         return "struct nla_bitfield32"
 
     def _attr_typol(self):
@@ -665,7 +672,7 @@ class TypeNest(Type):
     def is_recursive(self):
         return self.family.pure_nested_structs[self.nested_attrs].recursive
 
-    def _complex_member_type(self, ri):
+    def _complex_member_type(self, _ri):
         return self.nested_struct_type
 
     def _free_lines(self, ri, var, ref):
@@ -699,7 +706,7 @@ class TypeNest(Type):
                       f"parg.data = &{var}->{self.c_name};"]
         return get_lines, init_lines, None
 
-    def setter(self, ri, space, direction, deref=False, ref=None, var="req"):
+    def setter(self, ri, _space, direction, deref=False, ref=None, var="req"):
         ref = (ref if ref else []) + [self.c_name]
 
         for _, attr in ri.family.pure_nested_structs[self.nested_attrs].member_list():
@@ -724,19 +731,18 @@ class TypeMultiAttr(Type):
     def _complex_member_type(self, ri):
         if 'type' not in self.attr or self.attr['type'] == 'nest':
             return self.nested_struct_type
-        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+        if self.attr['type'] == 'binary' and 'struct' in self.attr:
             return None  # use arg_member()
-        elif self.attr['type'] == 'string':
+        if self.attr['type'] == 'string':
             return 'struct ynl_string *'
-        elif self.attr['type'] in scalars:
+        if self.attr['type'] in scalars:
             scalar_pfx = '__' if ri.ku_space == 'user' else ''
             if self.is_auto_scalar:
                 name = self.type[0] + '64'
             else:
                 name = self.attr['type']
             return scalar_pfx + name
-        else:
-            raise Exception(f"Sub-type {self.attr['type']} not supported yet")
+        raise Exception(f"Sub-type {self.attr['type']} not supported yet")
 
     def arg_member(self, ri):
         if self.type == 'binary' and 'struct' in self.attr:
@@ -747,7 +753,7 @@ class TypeMultiAttr(Type):
     def free_needs_iter(self):
         return self.attr['type'] in {'nest', 'string'}
 
-    def _free_lines(self, ri, var, ref):
+    def _free_lines(self, _ri, var, ref):
         lines = []
         if self.attr['type'] in scalars:
             lines += [f"free({var}->{ref}{self.c_name});"]
@@ -811,13 +817,12 @@ class TypeIndexedArray(Type):
     def _complex_member_type(self, ri):
         if 'sub-type' not in self.attr or self.attr['sub-type'] == 'nest':
             return self.nested_struct_type
-        elif self.attr['sub-type'] in scalars:
+        if self.attr['sub-type'] in scalars:
             scalar_pfx = '__' if ri.ku_space == 'user' else ''
             return scalar_pfx + self.attr['sub-type']
-        elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
+        if self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
             return None  # use arg_member()
-        else:
-            raise Exception(f"Sub-type {self.attr['sub-type']} not supported yet")
+        raise Exception(f"Sub-type {self.attr['sub-type']} not supported yet")
 
     def arg_member(self, ri):
         if self.sub_type == 'binary' and 'exact-len' in self.checks:
@@ -833,12 +838,11 @@ class TypeIndexedArray(Type):
     def _attr_typol(self):
         if self.attr['sub-type'] in scalars:
             return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
-        elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
+        if self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
             return f'.type = YNL_PT_BINARY, .len = {self.checks["exact-len"]}, '
-        elif self.attr['sub-type'] == 'nest':
+        if self.attr['sub-type'] == 'nest':
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
-        else:
-            raise Exception(f"Typol for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
+        raise Exception(f"Typol for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
@@ -874,7 +878,7 @@ class TypeIndexedArray(Type):
     def free_needs_iter(self):
         return self.sub_type == 'nest'
 
-    def _free_lines(self, ri, var, ref):
+    def _free_lines(self, _ri, var, ref):
         lines = []
         if self.sub_type == 'nest':
             lines += [
@@ -885,7 +889,7 @@ class TypeIndexedArray(Type):
         return lines
 
 class TypeNestTypeValue(Type):
-    def _complex_member_type(self, ri):
+    def _complex_member_type(self, _ri):
         return self.nested_struct_type
 
     def _attr_typol(self):
@@ -1030,7 +1034,7 @@ class Struct:
 
     def external_selectors(self):
         sels = []
-        for name, attr in self.attr_list:
+        for _name, attr in self.attr_list:
             if isinstance(attr, TypeSubMessage) and attr.selector.is_external():
                 sels.append(attr.selector)
         return sels
@@ -1047,9 +1051,9 @@ class EnumEntry(SpecEnumEntry):
         super().__init__(enum_set, yaml, prev, value_start)
 
         if prev:
-            self.value_change = (self.value != prev.value + 1)
+            self.value_change = self.value != prev.value + 1
         else:
-            self.value_change = (self.value != 0)
+            self.value_change = self.value != 0
         self.value_change = self.value_change or self.enum_set['type'] == 'flags'
 
         # Added by resolve:
@@ -1321,7 +1325,7 @@ class Family(SpecFamily):
                 }
 
     def _load_root_sets(self):
-        for op_name, op in self.msgs.items():
+        for _op_name, op in self.msgs.items():
             if 'attribute-set' not in op:
                 continue
 
@@ -1520,7 +1524,7 @@ class Family(SpecFamily):
             for k, _ in self.root_sets.items():
                 yield k, None  # we don't have a struct, but it must be terminal
 
-        for attr_set, struct in all_structs():
+        for attr_set, _struct in all_structs():
             for _, spec in self.attr_sets[attr_set].items():
                 if 'nested-attributes' in spec:
                     child_name = spec['nested-attributes']
@@ -1540,7 +1544,7 @@ class Family(SpecFamily):
     def _load_global_policy(self):
         global_set = set()
         attr_set_name = None
-        for op_name, op in self.ops.items():
+        for _op_name, op in self.ops.items():
             if not op:
                 continue
             if 'attribute-set' not in op:
@@ -2049,12 +2053,12 @@ def put_op_name(family, cw):
     _put_enum_to_str_helper(cw, family.c_name + '_op', map_name, 'op')
 
 
-def put_enum_to_str_fwd(family, cw, enum):
+def put_enum_to_str_fwd(_family, cw, enum):
     args = [enum.user_type + ' value']
     cw.write_func_prot('const char *', f'{enum.render_name}_str', args, suffix=';')
 
 
-def put_enum_to_str(family, cw, enum):
+def put_enum_to_str(_family, cw, enum):
     map_name = f'{enum.render_name}_strmap'
     cw.block_start(line=f"static const char * const {map_name}[] =")
     for entry in enum.entries.values():
@@ -2335,7 +2339,8 @@ def parse_rsp_nested_prototype(ri, struct, suffix=';'):
 
 def parse_rsp_nested(ri, struct):
     if struct.submsg:
-        return parse_rsp_submsg(ri, struct)
+        parse_rsp_submsg(ri, struct)
+        return
 
     parse_rsp_nested_prototype(ri, struct, suffix='')
 
@@ -2715,7 +2720,7 @@ def _free_type(ri, direction, struct):
 
 
 def free_rsp_nested_prototype(ri):
-        print_free_prototype(ri, "")
+    print_free_prototype(ri, "")
 
 
 def free_rsp_nested(ri, struct):
@@ -3357,7 +3362,7 @@ def render_user_family(family, cw, prototype):
             else:
                 raise Exception('Invalid notification ' + ntf_op_name)
             _render_user_ntf_entry(ri, ntf_op)
-        for op_name, op in family.ops.items():
+        for _op_name, op in family.ops.items():
             if 'event' not in op:
                 continue
             ri = RenderInfo(cw, family, "user", op, "event")
@@ -3429,10 +3434,9 @@ def main():
             print('Spec license:', parsed.license)
             print('License must be: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)')
             os.sys.exit(1)
-    except yaml.YAMLError as exc:
+    except pyyaml.YAMLError as exc:
         print(exc)
         os.sys.exit(1)
-        return
 
     cw = CodeWriter(BaseNlLib(), args.out_file, overwrite=(not args.cmp_out))
 
@@ -3535,7 +3539,7 @@ def main():
                 cw.nl()
 
             if parsed.kernel_policy in {'per-op', 'split'}:
-                for op_name, op in parsed.ops.items():
+                for _op_name, op in parsed.ops.items():
                     if 'do' in op and 'event' not in op:
                         ri = RenderInfo(cw, parsed, args.mode, op, "do")
                         print_req_policy_fwd(cw, ri.struct['request'], ri=ri)
@@ -3564,7 +3568,7 @@ def main():
                 print_req_policy(cw, struct)
                 cw.nl()
 
-            for op_name, op in parsed.ops.items():
+            for _op_name, op in parsed.ops.items():
                 if parsed.kernel_policy in {'per-op', 'split'}:
                     for op_mode in ['do', 'dump']:
                         if op_mode in op and 'request' in op[op_mode]:
@@ -3592,7 +3596,7 @@ def main():
                 ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
                 print_type_full(ri, struct)
 
-            for op_name, op in parsed.ops.items():
+            for _op_name, op in parsed.ops.items():
                 cw.p(f"/* ============== {op.enum_name} ============== */")
 
                 if 'do' in op and 'event' not in op:
@@ -3625,7 +3629,7 @@ def main():
                         raise Exception(f'Only notifications with consistent types supported ({op.name})')
                     print_wrapped_type(ri)
 
-            for op_name, op in parsed.ntfs.items():
+            for _op_name, op in parsed.ntfs.items():
                 if 'event' in op:
                     ri = RenderInfo(cw, parsed, args.mode, op, 'event')
                     cw.p(f"/* {op.enum_name} - event */")
@@ -3675,7 +3679,7 @@ def main():
                 if struct.reply:
                     parse_rsp_nested(ri, struct)
 
-            for op_name, op in parsed.ops.items():
+            for _op_name, op in parsed.ops.items():
                 cw.p(f"/* ============== {op.enum_name} ============== */")
                 if 'do' in op and 'event' not in op:
                     cw.p(f"/* {op.enum_name} - do */")
@@ -3703,7 +3707,7 @@ def main():
                         raise Exception(f'Only notifications with consistent types supported ({op.name})')
                     print_ntf_type_free(ri)
 
-            for op_name, op in parsed.ntfs.items():
+            for _op_name, op in parsed.ntfs.items():
                 if 'event' in op:
                     cw.p(f"/* {op.enum_name} - event */")
 
-- 
2.52.0


