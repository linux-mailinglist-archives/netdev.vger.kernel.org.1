Return-Path: <netdev+bounces-42312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBC7CE2FD
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5962A1C20DE3
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96E37CB0;
	Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AysLPVBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6763B7B7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0256C433CB;
	Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697647163;
	bh=Smz9ckCFsDNmUDX/KqpKQZ4Qf8hLT6n95xLdXlSKNN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AysLPVBarb7DF+AWaB4wrHVmdOvK1FGUvrqtFemeQRNm4aDc6Qyl8WG1mfjVw9BNn
	 E9oVUHIK8z9A2LXVE3epjy22Zzv66QnNBBOGF2ijVYoN6JlIorwanELILrHi86+hF6
	 mE+5BBRfZ0gpWMfCeXZtAukp0XgnrsjSSaYFdL39r+ucjtjcUHdGId2Ru+U9M8nkqL
	 q2RE6nbXE4ZjyuFkkqIPOt9+S7mRIeYHims1Jk2WQZGvmr0n+k5LMIINSCUWcj+lZC
	 XOeeb0Df89aqIZOxvUDmU/TyREfkF9NiOusy/UqOKW/lUWq5D+7Nx9OfqMIKCYpB/W
	 9iPAw2j+klKPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dcaratti@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl-gen: support full range of min/max checks for integer values
Date: Wed, 18 Oct 2023 09:39:16 -0700
Message-ID: <20231018163917.2514503-3-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163917.2514503-1-kuba@kernel.org>
References: <20231018163917.2514503-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the support to full range of min/max checks.
None of the existing YNL families required complex integer validation.

The support is less than trivial, because we try to keep struct nla_policy
tiny the min/max members it holds in place are s16. Meaning we can only
express checks in range of s16. For larger ranges we need to define
a structure and link it in the policy.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      |  3 +
 Documentation/netlink/genetlink-legacy.yaml |  3 +
 Documentation/netlink/genetlink.yaml        |  3 +
 tools/net/ynl/ynl-gen-c.py                  | 66 ++++++++++++++++++---
 4 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index f9366aaddd21..75af0b51f3d7 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -184,6 +184,9 @@ additionalProperties: False
                   min:
                     description: Min value for an integer attribute.
                     type: integer
+                  max:
+                    description: Max value for an integer attribute.
+                    type: integer
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index a6a490333a1a..c0f17a8bfe0d 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -227,6 +227,9 @@ additionalProperties: False
                   min:
                     description: Min value for an integer attribute.
                     type: integer
+                  max:
+                    description: Max value for an integer attribute.
+                    type: integer
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 2b788e607a14..4fd56e3b1553 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -157,6 +157,9 @@ additionalProperties: False
                   min:
                     description: Min value for an integer attribute.
                     type: integer
+                  max:
+                    description: Max value for an integer attribute.
+                    type: integer
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7f4ad4014d17..9d008346dd50 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -47,6 +47,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         if 'len' in attr:
             self.len = attr['len']
+
         if 'nested-attributes' in attr:
             self.nested_attrs = attr['nested-attributes']
             if self.nested_attrs == family.name:
@@ -262,6 +263,27 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if 'byte-order' in attr:
             self.byte_order_comment = f" /* {attr['byte-order']} */"
 
+        if 'enum' in self.attr:
+            enum = self.family.consts[self.attr['enum']]
+            low, high = enum.value_range()
+            if 'min' not in self.checks:
+                if low != 0 or self.type[0] == 's':
+                    self.checks['min'] = low
+            if 'max' not in self.checks:
+                self.checks['max'] = high
+
+        if 'min' in self.checks and 'max' in self.checks:
+            if self.checks['min'] > self.checks['max']:
+                raise Exception(f'Invalid limit for "{self.name}" min: {self.checks["min"]} max: {self.checks["max"]}')
+            self.checks['range'] = True
+
+        low = min(self.checks.get('min', 0), self.checks.get('max', 0))
+        high = max(self.checks.get('min', 0), self.checks.get('max', 0))
+        if low < 0 and self.type[0] == 'u':
+            raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
+        if low < -32768 or high > 32767:
+            self.checks['full-range'] = True
+
         # Added by resolve():
         self.is_bitfield = None
         delattr(self, "is_bitfield")
@@ -301,14 +323,14 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 flag_cnt = len(flags['entries'])
                 mask = (1 << flag_cnt) - 1
             return f"NLA_POLICY_MASK({policy}, 0x{mask:x})"
+        elif 'full-range' in self.checks:
+            return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
+        elif 'range' in self.checks:
+            return f"NLA_POLICY_RANGE({policy}, {self.checks['min']}, {self.checks['max']})"
         elif 'min' in self.checks:
             return f"NLA_POLICY_MIN({policy}, {self.checks['min']})"
-        elif 'enum' in self.attr:
-            enum = self.family.consts[self.attr['enum']]
-            low, high = enum.value_range()
-            if low == 0:
-                return f"NLA_POLICY_MAX({policy}, {high})"
-            return f"NLA_POLICY_RANGE({policy}, {low}, {high})"
+        elif 'max' in self.checks:
+            return f"NLA_POLICY_MAX({policy}, {self.checks['max']})"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -1241,7 +1263,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         for one in members:
             line = '.' + one[0]
             line += '\t' * ((longest - len(one[0]) - 1 + 7) // 8)
-            line += '= ' + one[1] + ','
+            line += '= ' + str(one[1]) + ','
             self.p(line)
 
 
@@ -1940,6 +1962,34 @@ _C_KW = {
     return family.kernel_policy == 'split' or kernel_can_gen_family_struct(family)
 
 
+def print_kernel_policy_ranges(family, cw):
+    first = True
+    for _, attr_set in family.attr_sets.items():
+        if attr_set.subset_of:
+            continue
+
+        for _, attr in attr_set.items():
+            if not attr.request:
+                continue
+            if 'full-range' not in attr.checks:
+                continue
+
+            if first:
+                cw.p('/* Integer value ranges */')
+                first = False
+
+            sign = '' if attr.type[0] == 'u' else '_signed'
+            cw.block_start(line=f'struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
+            members = []
+            if 'min' in attr.checks:
+                members.append(('min', attr.checks['min']))
+            if 'max' in attr.checks:
+                members.append(('max', attr.checks['max']))
+            cw.write_struct_init(members)
+            cw.block_end(line=';')
+            cw.nl()
+
+
 def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
@@ -2479,6 +2529,8 @@ _C_KW = {
             print_kernel_mcgrp_hdr(parsed, cw)
             print_kernel_family_struct_hdr(parsed, cw)
         else:
+            print_kernel_policy_ranges(parsed, cw)
+
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
                     cw.p('/* Common nested types */')
-- 
2.41.0


