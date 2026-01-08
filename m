Return-Path: <netdev+bounces-248160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3357AD04868
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F1D130299DD
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7982DB78F;
	Thu,  8 Jan 2026 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN09Yimk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C92D9EC2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888859; cv=none; b=sLhyrBOsk18qXUMizSInEIxb+Sp8t5X+klsuWByPCQGezcmHw4exa7lAZ0c7kKXU5CLPl+pl7QZo3gYtHgRmPf8ISw+9l5E7euXByW5s4tiFHL6cKLjD64HBXuA0uNmBldo2hHriSnBpR4EemmFPH0KSXJ53XPJvZ5giQ4xyuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888859; c=relaxed/simple;
	bh=nO2bn1/X6Q1HJ59mIC36zIsLozrVj5jDEowErPA8Pys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJkmLM7eeOPxGn1BDdaOLTnKb9feVXtRolhUAFRpg6ZF2TyKyElUT4XIQnGO8sdSKV8twXCebW3wANLJHKPdrMmOVchmM6pTB5smp9Pmf7VN20gguw2Y8s/W3jDnW3nzVVLyRKpSYQbUhjZMfkhHUvM5njwTNCT+I1QXuJwFWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN09Yimk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso22324715e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888855; x=1768493655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH/5sZqKOpUiqB0g18ozl06rqkBZr1JF05p9ctKLLoM=;
        b=AN09YimkufjrRFSEzOBVm+bAeMKFSJ2zIAY2AsKgAofBvc3s9cumShxAClaw1SY6AG
         58nx179oRAF2DoukRc3bQgjpcdFJ4wRPrl5WgHWS6YdDg7VsfzKrqfIq9Cq1EWnIeFhQ
         Kpi1cDtYYzQUB1GcVcr22uUJCBYbDuHrN3Ze4DjUPUudTRy2t2W+Q8Neof9PZ8zU5OBS
         auX26DJHIR8c19qg3+3yVusz3Z31y+zUSHbl/DZYQi2HyQ7xJTHPx9OPY3iBD0ZVPgtA
         yw/06U4HqxmVxyQ4zx0gKlxSrDT5vu4gI+GXtDCj9+PVhXPqoIT6TO93ufLcPdU/eh7z
         YIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888855; x=1768493655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XH/5sZqKOpUiqB0g18ozl06rqkBZr1JF05p9ctKLLoM=;
        b=cXoi1i2xTTNSTefVG7K9JUKQHgMxslmc833fR8YrpTt8mTBc/uyqur9MzRtJcpNtIO
         6DAZ/4ABSRETCBmTXcPcY33A0DsFgFlhYnra2ddXra6SdDRr7k1MAp7IVBBb+t7ca1J0
         6fT1XsHHBunBIt4Dy/uhpjs+MlRwjGrveFmpT+N35HY4C3PGA+dPwaB4btVohEDoUROJ
         3SaA9YxjrO0t6YiAIfkWInqYXOqOHe8lYbuJMTc1zev9HuRmKqpff9MDg4gcPAtWHIiE
         myPsZoCaj8Pg+bo3LGbrewgpnl7POURj5BHFkI58GhbU6t7c+gXaD3UEeeI3HZOKX9hM
         qHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3nSMdljCKZmpJuHnFQNokC2LE12zHIvCXGmH2ucKuroePMma0pTx3Aj2csWFINPRsqg96bzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gZMcm2N1DNHAEpJk7SKBxH8A3welyX9v/dIByBLJK3wiTpZL
	ozvGcW0C5bpHWkP6upqzZP+ACaUl8AOa/WbaBPU2jXImocn9l0gyE/4T
X-Gm-Gg: AY/fxX7GemeOMhZbPW4sMpqlKwWU787fFBLCiiXrEDa//6vNslM8ugjya2r/G5CUbA1
	ClhjBLugaMhxjPK36K/dyQxtLneI1TBGqM+D5HVyvwvZ62M8b8l+fQIACDO0AF1O89pVCGlKU/Y
	H+f29Y7tzfPOu4lAONBxZLCGf9ZrrHaPGD8VrmbOKxvH+c+ZEqSVwGCT06RdCWLxkUEdmDx9XZK
	5mCELNctFps8ckSG48TyH1ninP+Xde2fooIZVy+Ld7eQ0hoW5zY4FmcDt04gzcEi4LSm8mAXHkA
	CStK+8qFwKrhOuxDde+dZHwT9f92CZLZhTN22BzWODmmH5qQwxtZ4izDz0hXspcWJlMnX9E1u7n
	VgA5TvMYEA11Yu4cmK716cH9KB8lWhckDsnPXA0aGQSTuIEAunZzlp0LOh+li0vvU+oRrotUF8a
	WfIbDzucT30qOR2HTX2LD3ANY2Z7Uw
X-Google-Smtp-Source: AGHT+IFJta3hUD2BZpF49bHegsnyUi9l4d3KWAVmb45nhunjuyAqdtGJ+OzDsAk51ueYrDlYEqfLWA==
X-Received: by 2002:a05:600c:8b52:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-47d84b1a348mr72188125e9.6.1767888855322;
        Thu, 08 Jan 2026 08:14:15 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:14 -0800 (PST)
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
Subject: [PATCH net-next v2 11/13] tools: ynl-gen-c: fix pylint warnings for returns, unused, redefined
Date: Thu,  8 Jan 2026 16:13:37 +0000
Message-ID: <20260108161339.29166-12-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
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


