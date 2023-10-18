Return-Path: <netdev+bounces-42429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6947CEA21
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73F21C20D7B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBB3C694;
	Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsxHTWLC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B1B38DEE
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B2AC433C8;
	Wed, 18 Oct 2023 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697665164;
	bh=UUt/Q0ssAaJbKyzidds22C0A8CtOjzlDidcyh53Vygo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsxHTWLCkOXMcg4H6K53/DD+mDi1+01nrDgruqcKBaewNW2WYCGh8HZioI6Uy4+of
	 NXq8bwQIyL8lOHrPc0A1Zd3Y0Yf7z6i8blBwIdhJ2OxzwTNPofk0CuQR3h9SlrMfKT
	 /FsMcksdEWGmN8XSQLVdYBmn3qjjmWvysVU+RqmipJzPPJG+si1dv64goxsWGI9Niw
	 Km4B7R8Q+ew+2HVz3KDo7Sf6B3lf0K9y6HBIhnYH96+OXV+1f/BSI7W0iR4UrNKpbG
	 zX1gBibGr9zFMscfGa0XRDJsS0d27AQvNSH7/f5vFTbIw50PMGUlBU8HzbaRGMlb/0
	 PSUDpZF5uMz/g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] tools: ynl-gen: make the mnl_type() method public
Date: Wed, 18 Oct 2023 14:39:19 -0700
Message-ID: <20231018213921.2694459-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018213921.2694459-1-kuba@kernel.org>
References: <20231018213921.2694459-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uint/sint support will add more logic to mnl_type(),
deduplicate it and make it more accessible.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 552ba49a444c..6f4c538bda9a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -159,6 +159,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         spec = self._attr_policy(policy)
         cw.p(f"\t[{self.enum_name}] = {spec},")
 
+    def _mnl_type(self):
+        # mnl does not have helpers for signed integer types
+        # turn signed type into unsigned
+        # this only makes sense for scalar types
+        t = self.type
+        if t[0] == 's':
+            t = 'u' + t[1:]
+        return t
+
     def _attr_typol(self):
         raise Exception(f"Type policy not implemented for class type {self.type}")
 
@@ -329,12 +338,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         else:
             self.type_name = '__' + self.type
 
-    def _mnl_type(self):
-        t = self.type
-        # mnl does not have a helper for signed types
-        if t[0] == 's':
-            t = 'u' + t[1:]
-        return t
+    def mnl_type(self):
+        return self._mnl_type()
 
     def _attr_policy(self, policy):
         if 'flags-mask' in self.checks or self.is_bitfield:
@@ -363,10 +368,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return [f'{self.type_name} {self.c_name}{self.byte_order_comment}']
 
     def attr_put(self, ri, var):
-        self._attr_put_simple(ri, var, self._mnl_type())
+        self._attr_put_simple(ri, var, self.mnl_type())
 
     def _attr_get(self, ri, var):
-        return f"{var}->{self.c_name} = mnl_attr_get_{self._mnl_type()}(attr);", None, None
+        return f"{var}->{self.c_name} = mnl_attr_get_{self.mnl_type()}(attr);", None, None
 
     def _setter_lines(self, ri, member, presence):
         return [f"{member} = {self.c_name};"]
@@ -524,12 +529,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def presence_type(self):
         return 'count'
 
-    def _mnl_type(self):
-        t = self.type
-        # mnl does not have a helper for signed types
-        if t[0] == 's':
-            t = 'u' + t[1:]
-        return t
+    def mnl_type(self):
+        return self._mnl_type()
 
     def _complex_member_type(self, ri):
         if 'type' not in self.attr or self.attr['type'] == 'nest':
@@ -564,7 +565,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def attr_put(self, ri, var):
         if self.attr['type'] in scalars:
-            put_type = self._mnl_type()
+            put_type = self.mnl_type()
             ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
             ri.cw.p(f"mnl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
@@ -1580,11 +1581,8 @@ _C_KW = {
             ri.cw.p(f"parg.data = &dst->{aspec.c_name}[i];")
             ri.cw.p(f"if ({aspec.nested_render_name}_parse(&parg, attr))")
             ri.cw.p('return MNL_CB_ERROR;')
-        elif aspec['type'] in scalars:
-            t = aspec['type']
-            if t[0] == 's':
-                t = 'u' + t[1:]
-            ri.cw.p(f"dst->{aspec.c_name}[i] = mnl_attr_get_{t}(attr);")
+        elif aspec.type in scalars:
+            ri.cw.p(f"dst->{aspec.c_name}[i] = mnl_attr_get_{aspec.mnl_type()}(attr);")
         else:
             raise Exception('Nest parsing type not supported yet')
         ri.cw.p('i++;')
-- 
2.41.0


