Return-Path: <netdev+bounces-221894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632FB52483
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182B71C843E7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309AA322A34;
	Wed, 10 Sep 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v+HYsVyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B223164CA;
	Wed, 10 Sep 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545746; cv=none; b=sSpQtUAmwESnYDB0gEufQMGXiuW8zKPlULDNGsRcxXJ+reFQ6w2S5W+Nijho+ABCAN7RAso/6cMVdvZq0n3X6Req7xJ2+SGKVDYLqMddlKzMJ+elEhAwmC8k+16w5z2Pbzm/dBeramd5K4C/uHpksbP6rrbknFt6Um56vQgM2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545746; c=relaxed/simple;
	bh=5iWNx54sGjcK9fIya6c+VTdunUg4fVj+MTblZK2rNog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7Aaeo6hmzKOf1qzGJ6qs4tu6Y05DuCQvT6GsVh8XpMJ5rOmlJ2PFWv0yMZdZiieeAXlEmqeubedYer04KytWEOCXYsfc3N2mf54a8BzuYUUagxvfzCfy3CCP8ULQBMSaKlnC038kXksb/4OQFiBY6rX7SEldDOJPAD5c7dTXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v+HYsVyf; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=5iWNx54sGjcK9fIya6c+VTdunUg4fVj+MTblZK2rNog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v+HYsVyfHhzCBm7h8zMSS4thzij7x9TsWwDoNPhjnjHRt2S6YCTyyxwkqoYhs+CMT
	 Z9AX4QK+TZbUT+ZIYcVZuZ9JXcShU+LdHJyNSQXJpY57c56CAY/KckNNWufc/39Qhh
	 vl6pXyzdZTXLVXtsro69o1gWZsZMiwDkg4SoBl89ldMrgzORob2fb1ilS5nI4Qg5xz
	 Z14xnXPsEfVQAuc1LAXuXtaVYMBwaf/CXoL2FvvoaVluyz/7Zs3/DjjW8ff3TB80be
	 fASMwBfOsN0phj9ixmxlGCSPczmsG1Pu5z1u3a0IbedJx5aSGUFcWY30RYaE0e+twX
	 ji85+5xg0GoOw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id CB80F60139;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E93582038ED; Wed, 10 Sep 2025 23:08:42 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 04/12] tools: ynl-gen: refactor local vars for .attr_put() callers
Date: Wed, 10 Sep 2025 23:08:26 +0000
Message-ID: <20250910230841.384545-5-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910230841.384545-1-ast@fiberby.net>
References: <20250910230841.384545-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the generation of local variables needed when building
requests, by moving the logic into the Type classes, and use the
same helper in all places where .attr_put() is called.

If any attributes requests identical local_vars, then they will
be deduplicated, attributes are assumed to only use their local
variables transiently.

This patch fixes the build errors below:
$ make -C tools/net/ynl/generated/
[...]
-e      GEN wireguard-user.c
-e      GEN wireguard-user.h
-e      CC wireguard-user.o
wireguard-user.c: In function ‘wireguard_get_device_dump’:
wireguard-user.c:480:9: error: ‘array’ undeclared (first use in func)
  480 |         array = ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
      |         ^~~~~
wireguard-user.c:480:9: note: each undeclared identifier is reported
                        only once for each function it appears in
wireguard-user.c:481:14: error: ‘i’ undeclared (first use in func)
  481 |         for (i = 0; i < req->_count.peers; i++)
      |              ^
wireguard-user.c: In function ‘wireguard_set_device’:
wireguard-user.c:533:9: error: ‘array’ undeclared (first use in func)
  533 |         array = ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
      |         ^~~~~
make: *** [Makefile:52: wireguard-user.o] Error 1
make: Leaving directory '/usr/src/linux/tools/net/ynl/generated'

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 37 +++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 04c26ed92ca3..6441d5a31391 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -236,6 +236,12 @@ class Type(SpecAttr):
         line = f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name})"
         self._attr_put_line(ri, var, line)
 
+    def attr_put_local_vars(self):
+        local_vars = []
+        if self.presence_type() == 'count':
+            local_vars.append('unsigned int i;')
+        return local_vars
+
     def attr_put(self, ri, var):
         raise Exception(f"Put not implemented for class type {self.type}")
 
@@ -841,6 +847,10 @@ class TypeArrayNest(Type):
                      '}']
         return get_lines, None, local_vars
 
+    def attr_put_local_vars(self):
+        local_vars = ['struct nlattr *array;']
+        return local_vars + super().attr_put_local_vars()
+
     def attr_put(self, ri, var):
         ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
         if self.sub_type in scalars:
@@ -2041,6 +2051,15 @@ def put_enum_to_str(family, cw, enum):
     _put_enum_to_str_helper(cw, enum.render_name, map_name, 'value', enum=enum)
 
 
+def put_local_vars(struct):
+    local_vars = []
+    for _, attr in struct.member_list():
+        for local_var in attr.attr_put_local_vars():
+            if local_var not in local_vars:
+                local_vars.append(local_var)
+    return local_vars
+
+
 def put_req_nested_prototype(ri, struct, suffix=';'):
     func_args = ['struct nlmsghdr *nlh',
                  'unsigned int attr_type',
@@ -2063,15 +2082,7 @@ def put_req_nested(ri, struct):
         init_lines.append(f"hdr = ynl_nlmsg_put_extra_header(nlh, {struct_sz});")
         init_lines.append(f"memcpy(hdr, &obj->_hdr, {struct_sz});")
 
-    has_anest = False
-    has_count = False
-    for _, arg in struct.member_list():
-        has_anest |= arg.type == 'indexed-array'
-        has_count |= arg.presence_type() == 'count'
-    if has_anest:
-        local_vars.append('struct nlattr *array;')
-    if has_count:
-        local_vars.append('unsigned int i;')
+    local_vars += put_local_vars(struct)
 
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
@@ -2355,10 +2366,7 @@ def print_req(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
-    for _, attr in ri.struct["request"].member_list():
-        if attr.presence_type() == 'count':
-            local_vars += ['unsigned int i;']
-            break
+    local_vars += put_local_vars(ri.struct["request"])
 
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
@@ -2425,6 +2433,9 @@ def print_dump(ri):
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
+    if "request" in ri.op[ri.op_mode]:
+        local_vars += put_local_vars(ri.struct["request"])
+
     ri.cw.write_func_lvar(local_vars)
 
     ri.cw.p('yds.yarg.ys = ys;')
-- 
2.51.0


