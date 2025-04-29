Return-Path: <netdev+bounces-186786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD5AA10E0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E51B7AC838
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B7242D9A;
	Tue, 29 Apr 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3cmVhrN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D86242902
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941637; cv=none; b=coH8VVRz4BN0pcPN5gPycEErWYiknkDgoVmTBno+OQ5WoyboKrwIUb+TEvYHnvRi4Wdw4LjdL6YP8QBokhhoaDtdWgY/+Wrj0vNkxItufcfngSIE9BY7kpWyCEtVY6Vj9z+SGoqwBUalsqVYBZn3ULAfKUlQlAQOde8HTSDfyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941637; c=relaxed/simple;
	bh=jGb2zI0PhHspX60+xrficnVJdu/WPMVide1Py8IqVEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kutFIgEzLdKt1IRdqI3xDkyw56gAmC1xfHpFpfgWnMO6ZG9lFaofs0AqRS64+HAMzv9KOyapx9fow8Xfid9o4ykr62/BSULeTQVpy+hrqzaD9LpzrUkSM3abzE4T0YPpZitje2p0nJOo2mdOLUGSjNFno+j+niYL1Xj1DhhbFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3cmVhrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01973C4CEE3;
	Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941637;
	bh=jGb2zI0PhHspX60+xrficnVJdu/WPMVide1Py8IqVEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3cmVhrNxBFlD90huPo5MOq3OUcd1xtWtiFPzn6eNWTUn7IWf2O2RHRYnD1/lGNBB
	 BXFptnz9fX8XDGK6oeFTAVJNg7kzvmCGej45TSLvgwOfJq1UrXp1JwmCPVb2bWcgMa
	 NbDhB76sqY4XrG9yNEULwb1ZDjWIABg2H9VwkW6ueedD3wSgLrRyxVUsFL93Q1xrEZ
	 QVV7Jk3mFSLWES22vshE2dqURRVDNvtTw2DPHp3Xc6wnWvv+mhrzH58TfEAaNOZDrT
	 GUb5nUrh5lThlUPyM5wtApqL6VAbaMXsVbaTvUtzT1nmK0Alr0JpuhtOsnOrQpKy3P
	 OwPK4fBzrJaOQ==
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
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 10/12] tools: ynl-gen: array-nest: support binary array with exact-len
Date: Tue, 29 Apr 2025 08:47:02 -0700
Message-ID: <20250429154704.2613851-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


