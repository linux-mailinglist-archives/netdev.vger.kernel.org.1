Return-Path: <netdev+bounces-209414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A7B0F8B0
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1B01C86C2E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6F219E93;
	Wed, 23 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpYVFQ4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18821883C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290662; cv=none; b=BGQ3othtjKBD20G9WM6yFIophthtpkWVexS1KvWC45PRuoNSgoxG68xOuMRcIjJU+jFn9F1Pn52Afg7tlhFHWfOa8VZSI+ecMxVtIx4btukBApToQjUa6b2I++mlUa1jo2g1aQ6N8Oe33Z+VEgg1z848XNG5D8DfJ0lJRfBdyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290662; c=relaxed/simple;
	bh=kWzp8Q0q4wELMxHIXBRoAsswOzRhZUdxOt1r971AJaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iY79pWfPo5inZbrQjsDJqwWoCeLNRvVV45yEc7maNav6aojZSZ3ux4DN2P6sP0QazUQkRXD9HLfzTMDv+uQAa8x7NE3d1cH9iYyTLdCYL2aXuM1EpXvD750xNndcUTHWYZyMe3CdQDJ6rFGlrYY/ZeJpAB7VqFjYUq9PYwAOe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpYVFQ4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D6C4CEF7;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290661;
	bh=kWzp8Q0q4wELMxHIXBRoAsswOzRhZUdxOt1r971AJaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpYVFQ4PdJRmBS45Rih2HDneThQH2jP0zv511BNYoF8ihp4j59JDCXBMjkV7Tf06Y
	 dverefkbPuHDMpnU4UAcebqLnlIArkU8JPKb7pdrdS4qk+BDSvSG4Ney6FYcZMoReb
	 YjsWA9hZLAgbL15GEde2tNJxHJ0zlTM74+VMDnZ/1xU26do//+S+7OqtoL/1bIPiAX
	 NPGg2fewP8hlviEgROzku4dYaUBDPps7h3vqEowWd9Z2KxZCK7PC5ZT3DX2w+GJkV8
	 JbnWCdyjh7jFP7BU34wQ+3tvPAqpPQzQ9JwZzfCl8GDqPrrhRe8ssNzleGwMrlrs3K
	 TrDDm/NBSVLLA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/5] tools: ynl-gen: print setters for multi-val attrs
Date: Wed, 23 Jul 2025 10:10:45 -0700
Message-ID: <20250723171046.4027470-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723171046.4027470-1-kuba@kernel.org>
References: <20250723171046.4027470-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For basic types we "flatten" setters. If a request "a" has a simple
nest "b" with value "val" we print helpers like:

 req_set_a_b(struct a *req, int val)
 {
   req->_present.a = 1;
   req->b._present.val = 1;
   req->b.val = ...
 }

This is not possible for multi-attr because they have to be allocated
dynamically by the user. Print "object level" setters so that user
preparing the object doesn't have to futz with the presence bits
and other YNL internals.

Add the ability to pass in the variable name to generated setters.
Using "req" here doesn't feel right, while the attr is part of a request
it's not the request itself, so it seems cleaner to call it "obj".

Example:

 static inline void
 netdev_queue_id_set_id(struct netdev_queue_id *obj, __u32 id)
 {
	obj->_present.id = 1;
	obj->id = id;
 }

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 6bc0782f2658..ef032e17fec4 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -275,9 +275,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
     def _setter_lines(self, ri, member, presence):
         raise Exception(f"Setter not implemented for class type {self.type}")
 
-    def setter(self, ri, space, direction, deref=False, ref=None):
+    def setter(self, ri, space, direction, deref=False, ref=None, var="req"):
         ref = (ref if ref else []) + [self.c_name]
-        var = "req"
         member = f"{var}->{'.'.join(ref)}"
 
         local_vars = []
@@ -332,7 +331,7 @@ from lib import SpecSubMessage, SpecSubMessageFormat
     def attr_get(self, ri, var, first):
         pass
 
-    def setter(self, ri, space, direction, deref=False, ref=None):
+    def setter(self, ri, space, direction, deref=False, ref=None, var=None):
         pass
 
 
@@ -355,7 +354,7 @@ from lib import SpecSubMessage, SpecSubMessageFormat
     def attr_policy(self, cw):
         pass
 
-    def setter(self, ri, space, direction, deref=False, ref=None):
+    def setter(self, ri, space, direction, deref=False, ref=None, var=None):
         pass
 
 
@@ -695,13 +694,14 @@ from lib import SpecSubMessage, SpecSubMessageFormat
                       f"parg.data = &{var}->{self.c_name};"]
         return get_lines, init_lines, None
 
-    def setter(self, ri, space, direction, deref=False, ref=None):
+    def setter(self, ri, space, direction, deref=False, ref=None, var="req"):
         ref = (ref if ref else []) + [self.c_name]
 
         for _, attr in ri.family.pure_nested_structs[self.nested_attrs].member_list():
             if attr.is_recursive():
                 continue
-            attr.setter(ri, self.nested_attrs, direction, deref=deref, ref=ref)
+            attr.setter(ri, self.nested_attrs, direction, deref=deref, ref=ref,
+                        var=var)
 
 
 class TypeMultiAttr(Type):
@@ -2563,6 +2563,13 @@ _C_KW = {
         free_rsp_nested_prototype(ri)
         ri.cw.nl()
 
+        # Name conflicts are too hard to deal with with the current code base,
+        # they are very rare so don't bother printing setters in that case.
+        if ri.ku_space == 'user' and not ri.type_name_conflict:
+            for _, attr in struct.member_list():
+                attr.setter(ri, ri.attr_set, "", var="obj")
+        ri.cw.nl()
+
 
 def print_type_helpers(ri, direction, deref=False):
     print_free_prototype(ri, direction)
-- 
2.50.1


