Return-Path: <netdev+bounces-57117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E511C8122B5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FBB1C2127B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E3E77B36;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT1qnmUR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC477B30
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDABC433D9;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509287;
	bh=QZMsGHsbOO87TORpZaGbY+QCHoix6mxjuSuyFm039t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pT1qnmURISpjamxw9yFOZs/Rr/TD77AH/ThzmqEFYt+qFHiATMfXhxFXZprL9Fmij
	 4F5xwyVHJsXl4CFFXn689+xh0H0fhNL78JpBG62w9g1E4kh7sdnHU9AT8FgZuwQx7F
	 GCPXJ23SPdDTTbcSiKE2z5nYALCBXyPg/hWLvXDDpO8nibDFFXk3EAngebmnmKPc7x
	 A6rt1WVug+ZXbs2pv04CH7gIB8JV3LoiRXy3W5aOEseB7D0F27K2PaJsg07Lps1pLk
	 IrEAhTGTE1fqNyXw/Hq1eXJoQnRdyHA4Rx17yJ8ojzTWEAGZ4RigA+8U7dtwJssYtm
	 4KJO9VOppG+nQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 7/8] tools: ynl-gen: store recursive nests by a pointer
Date: Wed, 13 Dec 2023 15:14:31 -0800
Message-ID: <20231213231432.2944749-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213231432.2944749-1-kuba@kernel.org>
References: <20231213231432.2944749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid infinite nesting store recursive structs by pointer.
If recursive struct is placed in the op directly - the first
instance can be stored by value. That makes the code much
less of a pain for majority of practical uses.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 4ef3a774c402..7176afb4a3bd 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -108,6 +108,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def is_recursive(self):
         return False
 
+    def is_recursive_for_op(self, ri):
+        return self.is_recursive() and not ri.op
+
     def presence_type(self):
         return 'bit'
 
@@ -148,6 +151,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         member = self._complex_member_type(ri)
         if member:
             ptr = '*' if self.is_multi_val() else ''
+            if self.is_recursive_for_op(ri):
+                ptr = '*'
             ri.cw.p(f"{member} {ptr}{self.c_name};")
             return
         members = self.arg_member(ri)
@@ -539,7 +544,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return self.nested_struct_type
 
     def free(self, ri, var, ref):
-        ri.cw.p(f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name});')
+        at = '&'
+        if self.is_recursive_for_op(ri):
+            at = ''
+            ri.cw.p(f'if ({var}->{ref}{self.c_name})')
+        ri.cw.p(f'{self.nested_render_name}_free({at}{var}->{ref}{self.c_name});')
 
     def _attr_typol(self):
         return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
@@ -548,8 +557,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return 'NLA_POLICY_NESTED(' + self.nested_render_name + '_nl_policy)'
 
     def attr_put(self, ri, var):
+        at = '' if self.is_recursive_for_op(ri) else '&'
         self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
-                            f"{self.enum_name}, &{var}->{self.c_name})")
+                            f"{self.enum_name}, {at}{var}->{self.c_name})")
 
     def _attr_get(self, ri, var):
         get_lines = [f"if ({self.nested_render_name}_parse(&parg, attr))",
@@ -562,6 +572,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         ref = (ref if ref else []) + [self.c_name]
 
         for _, attr in ri.family.pure_nested_structs[self.nested_attrs].member_list():
+            if attr.is_recursive():
+                continue
             attr.setter(ri, self.nested_attrs, direction, deref=deref, ref=ref)
 
 
-- 
2.43.0


