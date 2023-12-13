Return-Path: <netdev+bounces-57118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D78122B6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D40B211F9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229377B44;
	Wed, 13 Dec 2023 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBjD7L3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4377B3F
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FADC433CC;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509287;
	bh=EDdeiUhDqeq3dzGR/fa0vh11gS4rgIwwjtpU3lC67LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBjD7L3D/4BTndWlndJUCLtUGNS8iEI5S8A4V8ze3yRT6q4Kicoh9txVeZtSgY/6h
	 5evkDJGUa11WHmH9B/cUwNpcxbKxZ8N8eeFMKGXXu3CJDnxnRqGONaH3V6K6/ViKJ5
	 MW/0vQndyUns6JckpLHzclJjKWMG6hcz9McN+sLpCsRoVYWASMYGnx3WnkcvwN9Nsq
	 NKry13zFtC3vHOasrPkCZi4oImVF4tQjBf8dFhar78EAl4Cv5/qB69eTETz8rUE30s
	 X+2K6Tcl+jhZbHBF53vAlTKKaq5lsuknBDvU3YyQy/IjO6VaT/T7BxP2O+WATpHCJp
	 fFxDGAYiYY3Qw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/8] tools: ynl-gen: print prototypes for recursive stuff
Date: Wed, 13 Dec 2023 15:14:32 -0800
Message-ID: <20231213231432.2944749-9-kuba@kernel.org>
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

We avoid printing forward declarations and prototypes for most
types by sorting things topologically. But if structs nest we
do need the forward declarations, there's no other way.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 44 +++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 7176afb4a3bd..7fc1aa788f6f 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1521,6 +1521,10 @@ _C_KW = {
     print_prototype(ri, "request")
 
 
+def put_typol_fwd(cw, struct):
+    cw.p(f'extern struct ynl_policy_nest {struct.render_name}_nest;')
+
+
 def put_typol(cw, struct):
     type_max = struct.attr_set.max_name
     cw.block_start(line=f'struct ynl_policy_attr {struct.render_name}_policy[{type_max} + 1] =')
@@ -1594,12 +1598,17 @@ _C_KW = {
     _put_enum_to_str_helper(cw, enum.render_name, map_name, 'value', enum=enum)
 
 
-def put_req_nested(ri, struct):
+def put_req_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct nlmsghdr *nlh',
                  'unsigned int attr_type',
                  f'{struct.ptr_name}obj']
 
-    ri.cw.write_func_prot('int', f'{struct.render_name}_put', func_args)
+    ri.cw.write_func_prot('int', f'{struct.render_name}_put', func_args,
+                          suffix=suffix)
+
+
+def put_req_nested(ri, struct):
+    put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
     ri.cw.write_func_lvar('struct nlattr *nest;')
 
@@ -1726,18 +1735,23 @@ _C_KW = {
     ri.cw.nl()
 
 
-def parse_rsp_nested(ri, struct):
+def parse_rsp_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct ynl_parse_arg *yarg',
                  'const struct nlattr *nested']
     for arg in struct.inherited:
         func_args.append('__u32 ' + arg)
 
+    ri.cw.write_func_prot('int', f'{struct.render_name}_parse', func_args,
+                          suffix=suffix)
+
+
+def parse_rsp_nested(ri, struct):
+    parse_rsp_nested_prototype(ri, struct, suffix='')
+
     local_vars = ['const struct nlattr *attr;',
                   f'{struct.ptr_name}dst = yarg->data;']
     init_lines = []
 
-    ri.cw.write_func_prot('int', f'{struct.render_name}_parse', func_args)
-
     _multi_parse(ri, struct, init_lines, local_vars)
 
 
@@ -2051,6 +2065,10 @@ _C_KW = {
     ri.cw.nl()
 
 
+def free_rsp_nested_prototype(ri):
+        print_free_prototype(ri, "")
+
+
 def free_rsp_nested(ri, struct):
     _free_type(ri, "", struct)
 
@@ -2818,7 +2836,14 @@ _C_KW = {
                     put_enum_to_str(parsed, cw, const)
             cw.nl()
 
+            has_recursive_nests = False
             cw.p('/* Policies */')
+            for struct in parsed.pure_nested_structs.values():
+                if struct.recursive:
+                    put_typol_fwd(cw, struct)
+                    has_recursive_nests = True
+            if has_recursive_nests:
+                cw.nl()
             for name in parsed.pure_nested_structs:
                 struct = Struct(parsed, name)
                 put_typol(cw, struct)
@@ -2827,6 +2852,15 @@ _C_KW = {
                 put_typol(cw, struct)
 
             cw.p('/* Common nested types */')
+            if has_recursive_nests:
+                for attr_set, struct in parsed.pure_nested_structs.items():
+                    ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
+                    free_rsp_nested_prototype(ri)
+                    if struct.request:
+                        put_req_nested_prototype(ri, struct)
+                    if struct.reply:
+                        parse_rsp_nested_prototype(ri, struct)
+                cw.nl()
             for attr_set, struct in parsed.pure_nested_structs.items():
                 ri = RenderInfo(cw, parsed, args.mode, "", "", attr_set)
 
-- 
2.43.0


