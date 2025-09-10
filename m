Return-Path: <netdev+bounces-221892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF385B52480
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7810758435A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D132F32144C;
	Wed, 10 Sep 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EGexIctJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB31314B6A;
	Wed, 10 Sep 2025 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757545745; cv=none; b=EAgwhvFjaPWrg+jnl6WIQd2JIH/+Gn1I6N45lMrsq8TSS9f21ey5Cplcb2xovXGl1a8qCBvCGpa67K+ciXGhlBBVm15dDQtxO0fjS4v7sdBx9Nh4JFU2Im/qKtuXTjXeG0mywd9pBTFyCkHrvUoV2BGgWpp6RIyN4ygH5aEEghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757545745; c=relaxed/simple;
	bh=AJhXtkWuMzpABxvSR0d9FQM3KyK8VD9yoZ5MetyiYuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0cMisi5r3A7uw3u5vsvhwAHR9yDtuzklilao06npQxWcKtcFsfv+YbNZXK76R4mUo5KcMXgxqydI0A+FSfES9MOB0hG/Zaf9h9Xphsc+FR1i58FTBMHoWa5kE70UE21PJBG/o+E/DLwJ9tC5mB7gxRoAL9I6Cg3QEtoqucHuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EGexIctJ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757545730;
	bh=AJhXtkWuMzpABxvSR0d9FQM3KyK8VD9yoZ5MetyiYuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGexIctJYnZrFmOZKzEMxSehii6fotVPm7gk9m/CLcRMi4P7IGNuLXyh66CtANQR3
	 ji0nCVE5RUX4HTyHTIGWzSYNfQxesLXuK4du+w+jI6zior+IbeSs/JEE46WY/HyZmp
	 r7UwUVVmzqnRqG2qIFVfqSocXCmqynVcAGJxKK9pK0bzNt6mHY4XKsfUH7wuT9gwaR
	 6SMaq8cY0RHoDqfRm/t5MCbuA2USSe8rkz7JfJwKv1CPyK7Cf99oLlNlug+5+QfFKa
	 ycdvyrpBpf4G6XsOHsROPrl86MG2Hi4Dg2dKwrzn9rrbPdjIJjN+SYU4S7RmeSjkjI
	 arQQEmzV8Rk7g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C7B1160138;
	Wed, 10 Sep 2025 23:08:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 1DFF5204C9F; Wed, 10 Sep 2025 23:08:43 +0000 (UTC)
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
Subject: [PATCH net-next v2 08/12] tools: ynl-gen: rename TypeArrayNest to TypeIndexedArray
Date: Wed, 10 Sep 2025 23:08:30 +0000
Message-ID: <20250910230841.384545-9-ast@fiberby.net>
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

Since TypeArrayNest can now be used with many other sub-types
than nest, then rename it to TypeIndexedArray, to reduce
confusion.

This patch continues the rename, that was started in commit
aa6485d813ad ("ynl: rename array-nest to indexed-array"),
when the YNL type was renamed.

In order to get rid of all references to the old naming,
within ynl, then renaming some variables in _multi_parse().

This is a trivial patch with no behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 34 ++++++++++++++++----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index e93f5d724b42..574faa89b1f7 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -793,7 +793,7 @@ class TypeMultiAttr(Type):
                 f"{presence} = n_{self.c_name};"]
 
 
-class TypeArrayNest(Type):
+class TypeIndexedArray(Type):
     def is_multi_val(self):
         return True
 
@@ -830,7 +830,7 @@ class TypeArrayNest(Type):
         elif self.attr['sub-type'] == 'nest':
             return f'.type = YNL_PT_NEST, .nest = &{self.nested_render_name}_nest, '
         else:
-            raise Exception(f"Typol for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+            raise Exception(f"Typol for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
 
     def _attr_get(self, ri, var):
         local_vars = ['const struct nlattr *attr2;']
@@ -860,7 +860,7 @@ class TypeArrayNest(Type):
             ri.cw.p(f'for (i = 0; i < {var}->_count.{self.c_name}; i++)')
             ri.cw.p(f"{self.nested_render_name}_put(nlh, i, &{var}->{self.c_name}[i]);")
         else:
-            raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+            raise Exception(f"Put for IndexedArray sub-type {self.attr['sub-type']} not supported, yet")
         ri.cw.p('ynl_attr_nest_end(nlh, array);')
 
     def _setter_lines(self, ri, member, presence):
@@ -1137,7 +1137,7 @@ class AttrSet(SpecAttrSet):
             t = TypeNest(self.family, self, elem, value)
         elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
             if elem["sub-type"] in ['binary', 'nest', 'u32']:
-                t = TypeArrayNest(self.family, self, elem, value)
+                t = TypeIndexedArray(self.family, self, elem, value)
             else:
                 raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
         elif elem['type'] == 'nest-type-value':
@@ -2127,33 +2127,33 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             else:
                 raise Exception(f"Per-op fixed header not supported, yet")
 
-    array_nests = set()
+    indexed_arrays = set()
     multi_attrs = set()
     needs_parg = False
     for arg, aspec in struct.member_list():
         if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
             if aspec["sub-type"] in {'binary', 'nest'}:
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
-                array_nests.add(arg)
+                indexed_arrays.add(arg)
             elif aspec['sub-type'] in scalars:
                 local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
-                array_nests.add(arg)
+                indexed_arrays.add(arg)
             else:
                 raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
         if 'multi-attr' in aspec:
             multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
         needs_parg |= 'sub-message' in aspec
-    if array_nests or multi_attrs:
+    if indexed_arrays or multi_attrs:
         local_vars.append('int i;')
     if needs_parg:
         local_vars.append('struct ynl_parse_arg parg;')
         init_lines.append('parg.ys = yarg->ys;')
 
-    all_multi = array_nests | multi_attrs
+    all_multi = indexed_arrays | multi_attrs
 
-    for anest in sorted(all_multi):
-        local_vars.append(f"unsigned int n_{struct[anest].c_name} = 0;")
+    for arg in sorted(all_multi):
+        local_vars.append(f"unsigned int n_{struct[arg].c_name} = 0;")
 
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
@@ -2172,8 +2172,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         else:
             ri.cw.p('hdr = ynl_nlmsg_data_offset(nlh, sizeof(struct genlmsghdr));')
         ri.cw.p(f"memcpy(&dst->_hdr, hdr, sizeof({struct.fixed_header}));")
-    for anest in sorted(all_multi):
-        aspec = struct[anest]
+    for arg in sorted(all_multi):
+        aspec = struct[arg]
         ri.cw.p(f"if (dst->{aspec.c_name})")
         ri.cw.p(f'return ynl_error_parse(yarg, "attribute already present ({struct.attr_set.name}.{aspec.name})");')
 
@@ -2191,8 +2191,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
     ri.cw.block_end()
     ri.cw.nl()
 
-    for anest in sorted(array_nests):
-        aspec = struct[anest]
+    for arg in sorted(indexed_arrays):
+        aspec = struct[arg]
 
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
@@ -2217,8 +2217,8 @@ def _multi_parse(ri, struct, init_lines, local_vars):
         ri.cw.block_end()
     ri.cw.nl()
 
-    for anest in sorted(multi_attrs):
-        aspec = struct[anest]
+    for arg in sorted(multi_attrs):
+        aspec = struct[arg]
         ri.cw.block_start(line=f"if (n_{aspec.c_name})")
         ri.cw.p(f"dst->{aspec.c_name} = calloc(n_{aspec.c_name}, sizeof(*dst->{aspec.c_name}));")
         ri.cw.p(f"dst->_count.{aspec.c_name} = n_{aspec.c_name};")
-- 
2.51.0


