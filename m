Return-Path: <netdev+bounces-191960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB5ABE088
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789131BC3635
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E427A927;
	Tue, 20 May 2025 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4oZMVnt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850C27A121
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757968; cv=none; b=hRutY/xDadOK3GYvOdYdhHuQ+SOIJ/AmgotSnx79nX4nR45YHnxzBpkTAftLvneXH9pH5FCPnml86UTF8FIurbzzSmhY5RFWlc+0t9CEiD/WWUhVX57k7FmqbqfiFn6XJsDjyjvjRmuK+ZlsIejYkVB4C08K8WHgh2ZD19PKB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757968; c=relaxed/simple;
	bh=JWoRXT4QEUe/E7wQO0rbh8d/ks0aGuPQKK9o9GdzU/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSH8NUjwffM7amy0K9qIu1y4Vda+Z076Sjx16vb9HMs9gittnqppiF8Dt00mqWxbnDpxMYkbltgRTefGIhGpNb8cHYCuy+Yp2eydAnHEhjU7ZKJMaT9aX4aTrSV4pHtHBg+zrqyLg8sxxEKMr09xmhwV+2yjPIqxR30EIH4p5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4oZMVnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDAAC4CEEB;
	Tue, 20 May 2025 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747757967;
	bh=JWoRXT4QEUe/E7wQO0rbh8d/ks0aGuPQKK9o9GdzU/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4oZMVntQ4Irj4MI8eF0MXqUJYEz4pFohHiVpBOwYRyDoEzXE0gzvWdU/OpCU2spd
	 AGzVHjWoyhHe3OsK0JT2BOO/PwRJE85wAtjhyTfuMY5/oCHGMN9NHzyI2J6N4pKQUX
	 0yjcj9GRsRwVAtfiM0vTctXL6vBDU/KF2inQoOIBNgxJAmSiB5SyN42fbsTu4itBkD
	 uOXZWTZySi6VtcMVAVyY3KN5D6QaypCEQJ9NZXRhq/v1h86XLVswgo//rQn5kVCgHT
	 xn+R286uKvOXlMWYHzZwgPxIfEdQluVnh9nIb+rAtGCIHOZgU42oRg9oq1ZW5Wxxs9
	 9tC5pW5MtCgCQ==
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
	kory.maincent@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/12] tools: ynl-gen: move fixed header info from RenderInfo to Struct
Date: Tue, 20 May 2025 09:19:11 -0700
Message-ID: <20250520161916.413298-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520161916.413298-1-kuba@kernel.org>
References: <20250520161916.413298-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RenderInfo describes a request-response exchange. Struct describes
a parsed attribute set. For ease of parsing sub-messages with
fixed headers move fixed header info from RenderInfo to Struct.
No functional changes.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 45 +++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index c1508d8c1e7a..bd1fadb2cf5a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -939,7 +939,7 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
 
 class Struct:
-    def __init__(self, family, space_name, type_list=None,
+    def __init__(self, family, space_name, type_list=None, fixed_header=None,
                  inherited=None, submsg=None):
         self.family = family
         self.space_name = space_name
@@ -947,6 +947,9 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         # Use list to catch comparisons with empty sets
         self._inherited = inherited if inherited is not None else []
         self.inherited = []
+        self.fixed_header = None
+        if fixed_header:
+            self.fixed_header = 'struct ' + c_lower(fixed_header)
         self.submsg = submsg
 
         self.nested = type_list is None
@@ -1345,7 +1348,9 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         nested = spec['nested-attributes']
         if nested not in self.root_sets:
             if nested not in self.pure_nested_structs:
-                self.pure_nested_structs[nested] = Struct(self, nested, inherited=inherit)
+                self.pure_nested_structs[nested] = \
+                    Struct(self, nested, inherited=inherit,
+                           fixed_header=spec.get('fixed-header'))
         else:
             raise Exception(f'Using attr set as root and nested not supported - {nested}')
 
@@ -1538,13 +1543,12 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         self.op_mode = op_mode
         self.op = op
 
-        self.fixed_hdr = None
+        fixed_hdr = op.fixed_header if op else None
         self.fixed_hdr_len = 'ys->family->hdr_len'
         if op and op.fixed_header:
-            self.fixed_hdr = 'struct ' + c_lower(op.fixed_header)
             if op.fixed_header != family.fixed_header:
                 if family.is_classic():
-                    self.fixed_hdr_len = f"sizeof({self.fixed_hdr})"
+                    self.fixed_hdr_len = f"sizeof(struct {c_lower(fixed_hdr)})"
                 else:
                     raise Exception(f"Per-op fixed header not supported, yet")
 
@@ -1584,12 +1588,17 @@ from lib import SpecSubMessage, SpecSubMessageFormat
                 type_list = []
                 if op_dir in op[op_mode]:
                     type_list = op[op_mode][op_dir]['attributes']
-                self.struct[op_dir] = Struct(family, self.attr_set, type_list=type_list)
+                self.struct[op_dir] = Struct(family, self.attr_set,
+                                             fixed_header=fixed_hdr,
+                                             type_list=type_list)
         if op_mode == 'event':
-            self.struct['reply'] = Struct(family, self.attr_set, type_list=op['event']['attributes'])
+            self.struct['reply'] = Struct(family, self.attr_set,
+                                          fixed_header=fixed_hdr,
+                                          type_list=op['event']['attributes'])
 
     def type_empty(self, key):
-        return len(self.struct[key].attr_list) == 0 and self.fixed_hdr is None
+        return len(self.struct[key].attr_list) == 0 and \
+            self.struct['request'].fixed_header is None
 
     def needs_nlflags(self, direction):
         return self.op_mode == 'do' and direction == 'request' and self.family.is_classic()
@@ -2057,12 +2066,12 @@ _C_KW = {
     if struct.nested:
         iter_line = "ynl_attr_for_each_nested(attr, nested)"
     else:
-        if ri.fixed_hdr:
+        if struct.fixed_header:
             local_vars += ['void *hdr;']
         iter_line = "ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)"
         if ri.op.fixed_header != ri.family.fixed_header:
             if ri.family.is_classic():
-                iter_line = f"ynl_attr_for_each(attr, nlh, sizeof({ri.fixed_hdr}))"
+                iter_line = f"ynl_attr_for_each(attr, nlh, sizeof({struct.fixed_header}))"
             else:
                 raise Exception(f"Per-op fixed header not supported, yet")
 
@@ -2104,12 +2113,12 @@ _C_KW = {
     for arg in struct.inherited:
         ri.cw.p(f'dst->{arg} = {arg};')
 
-    if ri.fixed_hdr:
+    if struct.fixed_header:
         if ri.family.is_classic():
             ri.cw.p('hdr = ynl_nlmsg_data(nlh);')
         else:
             ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
-        ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({ri.fixed_hdr}));")
+        ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({struct.fixed_header}));")
     for anest in sorted(all_multi):
         aspec = struct[anest]
         ri.cw.p(f"if (dst->{aspec.c_name})")
@@ -2303,7 +2312,7 @@ _C_KW = {
         ret_err = 'NULL'
         local_vars += [f'{type_name(ri, rdir(direction))} *rsp;']
 
-    if ri.fixed_hdr:
+    if ri.struct["request"].fixed_header:
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
@@ -2327,7 +2336,7 @@ _C_KW = {
         ri.cw.p(f"yrs.yarg.rsp_policy = &{ri.struct['reply'].render_name}_nest;")
     ri.cw.nl()
 
-    if ri.fixed_hdr:
+    if ri.struct['request'].fixed_header:
         ri.cw.p("hdr_len = sizeof(req->_hdr);")
         ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
         ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
@@ -2373,7 +2382,7 @@ _C_KW = {
                   'struct nlmsghdr *nlh;',
                   'int err;']
 
-    if ri.fixed_hdr:
+    if ri.struct['request'].fixed_header:
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
@@ -2394,7 +2403,7 @@ _C_KW = {
     else:
         ri.cw.p(f"nlh = ynl_gemsg_start_dump(ys, {ri.nl.get_family_id()}, {ri.op.enum_name}, 1);")
 
-    if ri.fixed_hdr:
+    if ri.struct['request'].fixed_header:
         ri.cw.p("hdr_len = sizeof(req->_hdr);")
         ri.cw.p("hdr = ynl_nlmsg_put_extra_header(nlh, hdr_len);")
         ri.cw.p("memcpy(hdr, &req->_hdr, hdr_len);")
@@ -2471,8 +2480,8 @@ _C_KW = {
     if ri.needs_nlflags(direction):
         ri.cw.p('__u16 _nlmsg_flags;')
         ri.cw.nl()
-    if ri.fixed_hdr:
-        ri.cw.p(ri.fixed_hdr + ' _hdr;')
+    if struct.fixed_header:
+        ri.cw.p(struct.fixed_header + ' _hdr;')
         ri.cw.nl()
 
     for type_filter in ['present', 'len', 'count']:
-- 
2.49.0


