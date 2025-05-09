Return-Path: <netdev+bounces-189307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C2FAB190F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3072E520FBB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243E22D9E6;
	Fri,  9 May 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te96ibQV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E198EC2
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805339; cv=none; b=jvJ/+Qf3jDUCeJUsG3huhiNrKbWYnXKyBw02+Afs3SFCMk3N5Jbb/40rEQfZcgRbTz8Frl/OetxZvOa239zjTbPSqj9CBe1AHvMK+3fGTyVXIP/UW8k8eTua8u81tuaQt1W70gi27oKppvQpRUM/OUjMIuj2o7HDj76MY9H+ASQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805339; c=relaxed/simple;
	bh=1VnA6LjAIOmQymxqKrC9/HFXU5n621QV2vQf9xhPqiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROofWKlCuCIjjdLbm23GVAODvIlpJU6UKNt3cxrH3POtUyblD8iMvF6/687ciz1VKO3HkIJ8rAX49xz6J7NGkj4mvJYWxp59G0/+2dO7F5MwAqMOkaWLJAYgJ2ISLnT98DsbckbF5CxIwNoclmMrkmrwDcWdaZKYJDyJKZTIdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te96ibQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF98DC4CEF0;
	Fri,  9 May 2025 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805339;
	bh=1VnA6LjAIOmQymxqKrC9/HFXU5n621QV2vQf9xhPqiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Te96ibQV3VnH+CWL1lOb5FIZzWOuRW8bAXphoV7f3LYiRiVecCnbZk4binQCN0ile
	 irCqffRbdCT6Fl37oSWTNqqgCY3emn8/MAc9SeHbbTT/EsxquQXusfcQON5WyZNNY2
	 Suxm8KLeWG82DgVwyVuUi8ZRn+yUs15Uoe46733sb69ZAHIaZEkVZRUkkOb3q+H13k
	 VMPC498ttxEcZYx8jt97pN79fkoEyKaNCGAK/sKbYF1pdSrrmooDHaG4HIxevI2+t3
	 GYTnZ10MDWw9JM2SnrFM+bi/K7LdfcETfhwZleg++ejawsOYGDv9qAfL8O8KLndtHT
	 NIj/gse7TKvwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] tools: ynl-gen: support sub-type for binary attributes
Date: Fri,  9 May 2025 08:42:11 -0700
Message-ID: <20250509154213.1747885-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509154213.1747885-1-kuba@kernel.org>
References: <20250509154213.1747885-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-type annotation on binary attributes may indicate that the attribute
carries an array of simple types (also referred to as "C array" in docs).
Support rendering them as such in the C user code. For example for u32,
instead of:

  struct {
    u32 arr;
  } _len;

  void *arr;

render:

  struct {
    u32 arr;
  } _count;

  __u32 *arr;

Note that count is the number of elements while len was the length in bytes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - create a separate class
v1: https://lore.kernel.org/20250508022839.1256059-2-kuba@kernel.org/
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 43 +++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 4a2d3cc07e14..4e2ae738c0aa 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -163,7 +163,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return False
 
     def _free_lines(self, ri, var, ref):
-        if self.is_multi_val() or self.presence_type() == 'len':
+        if self.is_multi_val() or self.presence_type() in {'count', 'len'}:
             return [f'free({var}->{ref}{self.c_name});']
         return []
 
@@ -566,6 +566,40 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 f'memcpy({member}, {self.c_name}, {presence});']
 
 
+class TypeBinaryScalarArray(TypeBinary):
+    def arg_member(self, ri):
+        return [f'__{self.get("sub-type")} *{self.c_name}', 'size_t count']
+
+    def presence_type(self):
+        return 'count'
+
+    def struct_member(self, ri):
+        ri.cw.p(f'__{self.get("sub-type")} *{self.c_name};')
+
+    def attr_put(self, ri, var):
+        presence = self.presence_type()
+        ri.cw.block_start(line=f"if ({var}->_{presence}.{self.c_name})")
+        ri.cw.p(f"i = {var}->_{presence}.{self.c_name} * sizeof(__{self.get('sub-type')});")
+        ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, " +
+                f"{var}->{self.c_name}, i);")
+        ri.cw.block_end()
+
+    def _attr_get(self, ri, var):
+        len_mem = var + '->_count.' + self.c_name
+        return [f"{len_mem} = len / sizeof(__{self.get('sub-type')});",
+                f"len = {len_mem} * sizeof(__{self.get('sub-type')});",
+                f"{var}->{self.c_name} = malloc(len);",
+                f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
+               ['len = ynl_attr_data_len(attr);'], \
+               ['unsigned int len;']
+
+    def _setter_lines(self, ri, member, presence):
+        return [f"{presence} = count;",
+                f"count *= sizeof(__{self.get('sub-type')});",
+                f"{member} = malloc(count);",
+                f'memcpy({member}, {self.c_name}, count);']
+
+
 class TypeBitfield32(Type):
     def _complex_member_type(self, ri):
         return "struct nla_bitfield32"
@@ -672,7 +706,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         lines = []
         if self.attr['type'] in scalars:
             lines += [f"free({var}->{ref}{self.c_name});"]
-        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+        elif self.attr['type'] == 'binary':
             lines += [f"free({var}->{ref}{self.c_name});"]
         elif self.attr['type'] == 'string':
             lines += [
@@ -976,7 +1010,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif elem['type'] == 'string':
             t = TypeString(self.family, self, elem, value)
         elif elem['type'] == 'binary':
-            t = TypeBinary(self.family, self, elem, value)
+            if elem.get('sub-type') in scalars:
+                t = TypeBinaryScalarArray(self.family, self, elem, value)
+            else:
+                t = TypeBinary(self.family, self, elem, value)
         elif elem['type'] == 'bitfield32':
             t = TypeBitfield32(self.family, self, elem, value)
         elif elem['type'] == 'nest':
-- 
2.49.0


