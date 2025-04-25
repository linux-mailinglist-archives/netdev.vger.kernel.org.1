Return-Path: <netdev+bounces-185832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF657A9BD03
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FD4464C0C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52F6196C7C;
	Fri, 25 Apr 2025 02:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQWJPcpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD31957FC
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549010; cv=none; b=SngbKk1dUsy829nyLmsK5ktszVYOnkY8NVIrZE1sLBXGzzZuyp98GJ0z5iH6lkVWdBhEwXaWuHdiIGLt2eILpE31ODByFVsHSHJYaLYop1N4G1S7/Cl45Dvi9tTBjuj5FUifs5pIbIGzQ7FljO6Kf94xwulklODCzXceya9dYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549010; c=relaxed/simple;
	bh=Gfgk4lsRTfT/rBbtinzRaINrNAm3a4d0Co65js88dS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv0OR1li9+aRi2Wv6XAXlUhSYVoRx9aSQUdHkSmhn4HtHtidALjVRXaBhVMPEpGYk9//jDzh1kRy828p2Gskx1p1/X3o6Smu1enaDEr9XXxf59noK95yCCardWzYIEf7pwP+pVmuv5/Hfqn/32Yx+wSO6HR0YOgSMWDzqQMfuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQWJPcpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA5C4CEEE;
	Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549009;
	bh=Gfgk4lsRTfT/rBbtinzRaINrNAm3a4d0Co65js88dS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQWJPcpVJTsiAY5nyBYxd33qBRC4HREdhiGEfg/zbxiKEMsXwH6h4Q/louVR38wG3
	 EPbB105S+dDqgYFvgaMQ46SkGg2ACMHzZmiSGT/yFFfF4UsJ1Bv1SHt4MshzA0ynlf
	 JnU3zIqxOKA3/8K09pk9m9Aq6/LkMgG4Q8lgb1sjHntZv0Y9r/IeDPqt+cm0LVlus2
	 ABEoqFVKx3mJGCEwNtS3/Ft15YZIv/tSJz+03X7MRa4E1Ekp5MxHUZSprbRe9zcHBG
	 e+2etluerRb0ASHxrgqPA6guTSveMPcwB6+4pITQrHBdlf+1wjbfD7oL458saAo/Vw
	 rVM2eo+M3foVA==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 10/12] tools: ynl-gen: array-nest: support binary array with exact-len
Date: Thu, 24 Apr 2025 19:43:09 -0700
Message-ID: <20250425024311.1589323-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index a4e65da19696..2d185c7ea16c 100755
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
@@ -1786,7 +1799,7 @@ _C_KW = {
     needs_parg = False
     for arg, aspec in struct.member_list():
         if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
-            if aspec["sub-type"] == 'nest':
+            if aspec["sub-type"] in {'binary', 'nest'}:
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
                 array_nests.add(arg)
             elif aspec['sub-type'] in scalars:
@@ -1859,6 +1872,9 @@ _C_KW = {
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


