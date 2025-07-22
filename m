Return-Path: <netdev+bounces-209047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBFB0E191
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0BA2546118
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05527C145;
	Tue, 22 Jul 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO7NcO6r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7727BF7E
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201184; cv=none; b=fwIibCcYkdTo2c5g3wTV7RUZoF8miVTinQEjMGDaQR7By18/D1PmIUbnfb17p/6Y4DMNp0tjfVNqXA6ehqzjg/LeqBE9Gv72ElcO93VHQKq2s1Ej7GMj8EY1X3gtZBj6CS5mEmyOo/M3HpF96oQ9bTT9xsvsGvNoIl9jcq9C3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201184; c=relaxed/simple;
	bh=2gHabqcZylV5uRLKk//iaW12X3EOyX2H4Yuql5QdR7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3gVefeBf9CnPYX32Kdarz7GaldYsav2RmYrHbChBUL5uc/q6Kv+rdZCWJXDNlTHMhe7F4DDqZR7bJHQ1qjP5WvYwA8FKVwga2X5MTe4JBABvdev30YGsujSU3p/26//gGj4exB1LlV9wd7nT9v9pnAVt0vaVI1bic8FC6Or9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO7NcO6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD66AC4CEF1;
	Tue, 22 Jul 2025 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201184;
	bh=2gHabqcZylV5uRLKk//iaW12X3EOyX2H4Yuql5QdR7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pO7NcO6rOimwvQl1nh/1PhjiX9sY+SdRanaj1cj6qdHlsWnv5ynnn+0EHS4qH/qqi
	 rmawqaE2BRdOzv8MEkghhzQqIRrAPYNjrZ4BzQwWyqBevPytgPs0/7iiR6tw1fmC13
	 2fu31niiwyuw97qTmz0oCh/9rz3aBd7S9l6iUdCgvZWLKmgW3RoIuamOO+LFD/b2Ta
	 xLBRdzcpkF4mml/9FVv9IY0/ljgtWKJuTTahhJvnvmviXrt607NxdNUSBHxnEcN/ao
	 fvHzStPJPL8Sf6rhg3p3X3WAIXFupOrAgt/YqI4HxtSJS6OUp5tmrNSx0qMupT0/8t
	 VaoBT7RgryQow==
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
Subject: [PATCH net-next 4/5] tools: ynl-gen: print setters for multi-val attrs
Date: Tue, 22 Jul 2025 09:19:26 -0700
Message-ID: <20250722161927.3489203-5-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>
References: <20250722161927.3489203-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0394b786aa93..d27da46a87ee 100755
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


