Return-Path: <netdev+bounces-185371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598A2A99EAF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D8D7AFFB0
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CBB1D61A3;
	Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cts5ACg9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C11D5AB5
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460740; cv=none; b=t6xQGNMcboJw6SdUNvZIU3m8GsvZJCD7AZoOhY0JbXShsH0mAiv8FsCazOTuNtSL837tyHa1jWxIupg+6ouQJZOpFxcBpSmkKozGS9NLf6lE+rP1Le0SlZjiAzUlXMGLJrnZKBNk02rIjTxFqAddMqy/s2ZfN3ohTr4bWmxrjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460740; c=relaxed/simple;
	bh=Eou7yW+47EGIcIcDf6lnrJ7OnbHl94rFq83d43zm8I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OspB2uIVQWMk5suAMm0CWJMp1UNhdNK0DOcJufm41h+umknOrO+90vIDUeVO8+kipXoUbAbAPS1MIka8zHrsHYAQKEC5T0VngXJRUny/0KEI3rvymYWvkeX8Nx03jRaSexCsNuGFGNaxskpXIG0vTlU53vsIA6ibczdPnWA1MxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cts5ACg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14246C4CEE3;
	Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460740;
	bh=Eou7yW+47EGIcIcDf6lnrJ7OnbHl94rFq83d43zm8I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cts5ACg9iOAewLEAJyiI9ANliTplUB2r2nHpC4Rvil7vHawgOlaZz6tU/QhxJMr/N
	 +leMKYDWiE6uhCiTKbca1AY4LVBQVzqz89wYodw+TkS5hoJJe6aiqa49nWsPxQBzbk
	 quyLmprjrZdJktxwpXiZSShkoYHpn2gdyV/VJ8FfGR1FjeNrhaPWHnxqM7/Qd+yxn2
	 MWFbm4wpAThc/YF+CrvPUelDCmvW+Juf56NnuxVCMwi0TeD7VGJKcDlvMJE2t9QITO
	 yX4OklYRWezJOc+HamKfk3dIMkka2FQBPfbDB2QsB6PKx2IetkctpdgFFKg4As/HLT
	 DqPYOhIkpOVYQ==
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
Subject: [PATCH net-next 10/12] tools: ynl-gen: array-nest: support binary array with exact-len
Date: Wed, 23 Apr 2025 19:12:05 -0700
Message-ID: <20250424021207.1167791-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 addresses are expressed as binary arrays since we don't have u128.
Since they are not variable length, however, they are relatively
easy to represent as an array of known size.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 46d99b871d5c..97fe9938c233 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -183,10 +183,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         raise Exception(f"Struct member not implemented for class type {self.type}")
 
     def struct_member(self, ri):
-        if self.is_multi_val():
-            ri.cw.p(f"unsigned int n_{self.c_name};")
         member = self._complex_member_type(ri)
         if member:
+            if self.is_multi_val():
+                ri.cw.p(f"unsigned int n_{self.c_name};")
             ptr = '*' if self.is_multi_val() else ''
             if self.is_recursive_for_op(ri):
                 ptr = '*'
@@ -728,12 +728,22 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif self.attr['sub-type'] in scalars:
             scalar_pfx = '__' if ri.ku_space == 'user' else ''
             return scalar_pfx + self.attr['sub-type']
+        elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
+            return None  # use arg_member()
         else:
             raise Exception(f"Sub-type {self.attr['sub-type']} not supported yet")
 
+    def arg_member(self, ri):
+        if self.sub_type == 'binary' and 'exact-len' in self.checks:
+            return [f'unsigned char (*{self.c_name})[{self.checks["exact-len"]}]',
+                    f'unsigned int n_{self.c_name}']
+        return super().arg_member(ri)
+
     def _attr_typol(self):
         if self.attr['sub-type'] in scalars:
             return f'.type = YNL_PT_U{c_upper(self.sub_type[1:])}, '
+        elif self.attr['sub-type'] == 'binary' and 'exact-len' in self.checks:
+            return f'.type = YNL_PT_BINARY, .len = {self.checks["exact-len"]}, '
         else:
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
 
@@ -754,6 +764,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             ri.cw.block_start(line=f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, i, {var}->{self.c_name}[i]);")
             ri.cw.block_end()
+        elif self.sub_type == 'binary' and 'exact-len' in self.checks:
+            ri.cw.p(f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.p(f"ynl_attr_put(nlh, i, {var}->{self.c_name}[i], {self.checks['exact-len']});")
         else:
             raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
@@ -964,7 +977,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
-            if elem["sub-type"] in ['nest', 'u32']:
+            if elem["sub-type"] in ['binary', 'nest', 'u32']:
                 t = TypeArrayNest(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
@@ -1788,7 +1801,7 @@ _C_KW = {
     needs_parg = False
     for arg, aspec in struct.member_list():
         if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
-            if aspec["sub-type"] == 'nest':
+            if aspec["sub-type"] in {'binary', 'nest'}:
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
                 array_nests.add(arg)
             elif aspec['sub-type'] in scalars:
@@ -1861,6 +1874,9 @@ _C_KW = {
             ri.cw.p('return YNL_PARSE_CB_ERROR;')
         elif aspec.sub_type in scalars:
             ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.sub_type}(attr);")
+        elif aspec.sub_type == 'binary' and 'exact-len' in aspec.checks:
+            # Length is validated by typol
+            ri.cw.p(f'memcpy(dst->{aspec.c_name}[i], ynl_attr_data(attr), {aspec.checks["exact-len"]});')
         else:
             raise Exception(f"Nest parsing type not supported in {aspec['name']}")
         ri.cw.p('i++;')
-- 
2.49.0


