Return-Path: <netdev+bounces-191243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C772ABA74D
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009551C0211C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931AF1E4AE;
	Sat, 17 May 2025 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK4I9JdZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1ED4C81
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440814; cv=none; b=M41/KrRJwy1m4o0ipCQHNK+1E7PPX7fUR68Q9etvqx4mDukPc6QHzETQhVj0uE2xRvShgGiqfqYuOGIPzHz1kLHUZ/7z7z0o3+Vjo2dQdgCpVKbdLOGMAKIUdh5TRkCW9Zt6oE9INasaAkOYJ7j5mcc1U3SGx5PXygIt/7jxZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440814; c=relaxed/simple;
	bh=ql+rz5Cwi1MUllr6xqc/NwQVggPHANnNSBM3eihC9NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWJONDpPwu8PZbLrYejV9xuxW83XLlUUQ3PRalfsxDuZUStQ035tPq2qXrY/MutdhLxM1Z4CJZTV7GNUv5h1KIfa8YIkwg0F7vZYb4Gi5zxraTAyPjgA1LuP2JSlQDy/MLjLlG93uR0kE4SRm5UmofpgXF9hFZTfe9b4XiXVHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK4I9JdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D85C4CEF4;
	Sat, 17 May 2025 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440814;
	bh=ql+rz5Cwi1MUllr6xqc/NwQVggPHANnNSBM3eihC9NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VK4I9JdZh8v1ekIc6PEWjraOtPj9WRtKfxhSqtQNCrIUXasl+hm+UdI1/8BWd8C2/
	 iL7nIhmPQTUw56FjCTjoul+5oXvLMrt9tY/7CpdeCXpMMInZ3e2LwBKEudZkHB7Tux
	 L0xBWjuMZ043QHrfp/pb0sJabOZeV6mo6Z8aoeIW7epe34O2Yj1Tcady5GRv7uggeD
	 EKftyGRcUDLvTzZXnRQ++5sFcT+51QOcbbe3nhXktj517xUUvY9HsOoTG1kG0J8YHM
	 UCYkDSedeFpZhl0FJSqnSUxuXEi9ezpE9hxHefBYKz5uBsA8vyFFS33jW3MU+vIL18
	 1AP6MTXCtdZ7w==
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
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/11] tools: ynl-gen: support passing selector to a nest
Date: Fri, 16 May 2025 17:13:12 -0700
Message-ID: <20250517001318.285800-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rtnetlink all submessages had the selector at the same level
of nesting as the submessage. We could refer to the relevant
attribute from the current struct. In TC, stats are one level
of nesting deeper than "kind". Teach the code-gen about structs
which need to be passed a selector by the caller for parsing.

Because structs are "topologically sorted" one pass of propagating
the selectors down is enough.

For generating netlink message we depend on the presence bits
so no selector passing needed there.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 65 +++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1f8cc34ab3f0..c1508d8c1e7a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -685,7 +685,11 @@ from lib import SpecSubMessage, SpecSubMessageFormat
                             f"{self.enum_name}, {at}{var}->{self.c_name})")
 
     def _attr_get(self, ri, var):
-        get_lines = [f"if ({self.nested_render_name}_parse(&parg, attr))",
+        pns = self.family.pure_nested_structs[self.nested_attrs]
+        args = ["&parg", "attr"]
+        for sel in pns.external_selectors():
+            args.append(f'{var}->{sel.name}')
+        get_lines = [f"if ({self.nested_render_name}_parse({', '.join(args)}))",
                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
@@ -890,15 +894,24 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
     def _attr_typol(self):
         typol = f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
-        typol += f'.is_submsg = 1, .selector_type = {self.attr_set[self["selector"]].value} '
+        typol += '.is_submsg = 1, '
+        # Reverse-parsing of the policy (ynl_err_walk() in ynl.c) does not
+        # support external selectors. No family uses sub-messages with external
+        # selector for requests so this is fine for now.
+        if not self.selector.is_external():
+            typol += f'.selector_type = {self.attr_set[self["selector"]].value} '
         return typol
 
     def _attr_get(self, ri, var):
         sel = c_lower(self['selector'])
-        get_lines = [f'if (!{var}->{sel})',
+        if self.selector.is_external():
+            sel_var = f"_sel_{sel}"
+        else:
+            sel_var = f"{var}->{sel}"
+        get_lines = [f'if (!{sel_var})',
                      f'return ynl_submsg_failed(yarg, "%s", "%s");' %
                         (self.name, self['selector']),
-                    f"if ({self.nested_render_name}_parse(&parg, {var}->{sel}, attr))",
+                    f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
@@ -914,7 +927,15 @@ from lib import SpecSubMessage, SpecSubMessageFormat
             self.attr.is_selector = True
             self._external = False
         else:
-            raise Exception("Passing selectors from external nests not supported")
+            # The selector will need to get passed down thru the structs
+            self.attr = None
+            self._external = True
+
+    def set_attr(self, attr):
+        self.attr = attr
+
+    def is_external(self):
+        return self._external
 
 
 class Struct:
@@ -976,6 +997,13 @@ from lib import SpecSubMessage, SpecSubMessageFormat
             raise Exception("Inheriting different members not supported")
         self.inherited = [c_lower(x) for x in sorted(self._inherited)]
 
+    def external_selectors(self):
+        sels = []
+        for name, attr in self.attr_list:
+            if isinstance(attr, TypeSubMessage) and attr.selector.is_external():
+                sels.append(attr.selector)
+        return sels
+
     def free_needs_iter(self):
         for _, attr in self.attr_list:
             if attr.free_needs_iter():
@@ -1222,6 +1250,7 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         self._load_root_sets()
         self._load_nested_sets()
         self._load_attr_use()
+        self._load_selector_passing()
         self._load_hooks()
 
         self.kernel_policy = self.yaml.get('kernel-policy', 'split')
@@ -1436,6 +1465,30 @@ from lib import SpecSubMessage, SpecSubMessageFormat
                 if attr in rs_members['reply']:
                     spec.set_reply()
 
+    def _load_selector_passing(self):
+        def all_structs():
+            for k, v in reversed(self.pure_nested_structs.items()):
+                yield k, v
+            for k, _ in self.root_sets.items():
+                yield k, None  # we don't have a struct, but it must be terminal
+
+        for attr_set, struct in all_structs():
+            for _, spec in self.attr_sets[attr_set].items():
+                if 'nested-attributes' in spec:
+                    child_name = spec['nested-attributes']
+                elif 'sub-message' in spec:
+                    child_name = spec.sub_message
+                else:
+                    continue
+
+                child = self.pure_nested_structs.get(child_name)
+                for selector in child.external_selectors():
+                    if selector.name in self.attr_sets[attr_set]:
+                        sel_attr = self.attr_sets[attr_set][selector.name]
+                        selector.set_attr(sel_attr)
+                    else:
+                        raise Exception("Passing selector thru more than one layer not supported")
+
     def _load_global_policy(self):
         global_set = set()
         attr_set_name = None
@@ -2183,6 +2236,8 @@ _C_KW = {
 def parse_rsp_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct ynl_parse_arg *yarg',
                  'const struct nlattr *nested']
+    for sel in struct.external_selectors():
+        func_args.append('const char *_sel_' + sel.name)
     if struct.submsg:
         func_args.insert(1, 'const char *sel')
     for arg in struct.inherited:
-- 
2.49.0


