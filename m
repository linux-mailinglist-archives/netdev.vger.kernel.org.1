Return-Path: <netdev+bounces-188851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670CAAF125
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 04:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47551BA4004
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445651D5AD4;
	Thu,  8 May 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN+30Mru"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080E1D416E
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746671328; cv=none; b=MJPuqICQHH91V4UUFXUvVIfjEKmkpzN3n0PDpEuodVBE5ff44u4z+2r4ye8nNMZ1/1YtV7Bwr2FTEyp19iS6i+E1r+kctW0QQLhTkZEMyZO04S/u9Qg0pUYlo1WxgwUmONapV6GOib4NX5cymYLyMoLNWdBeATQsi0LrEl8mj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746671328; c=relaxed/simple;
	bh=1NtYrejzIHNzY8okS2N1gqi4UQhUgKPT/gu/lOmT1lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rywg0JEUnNuUZIDbkDwJMEb6NEArvjO3yaIKQCkWG22oq7A+OJnzd7gbL60nbrUvg+gC59pajMmABVht+kQGIqXrFeHLG1bEqDD4TnFsdE2GM9tYod00GW730vaGJsco1AwKNnc4G+xaDogYcLkkoWt5tGYj2UXRON2Hx5nLWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN+30Mru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511D3C4CEE8;
	Thu,  8 May 2025 02:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746671327;
	bh=1NtYrejzIHNzY8okS2N1gqi4UQhUgKPT/gu/lOmT1lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WN+30MruRkV4lI3puxuL8VGDOG8SWyuBAd9qDWsY9ZOElSkh4/ZEHzJFw7vbymd+J
	 SBTiOBiT1Mp1f/4Sz8WrZZ57EqdtIRiYDvjtZlGVJiwdwMxvQxOirsZCCJQlB/J73F
	 PnkeBumx+N/uM/x4QZe3K1P54mMM+NPabH3wgemm2TB583UOmY97xuxbKF/Uy6ULRY
	 +R5qRv+B/zi6DewuYHc1VrbOlgZoEu+ukBkP5KggWhy6DaBG0UED+X4HnQKjIrP25u
	 oAssXtgA4L2mGOfbnfILI8wRFVURh4hPg+odu5PqRs4wqR5hgDjxIMAO5ZvH3DL+MH
	 xdCMA0x/7Nx/A==
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
Subject: [PATCH net-next 1/3] tools: ynl-gen: support sub-type for binary attributes
Date: Wed,  7 May 2025 19:28:37 -0700
Message-ID: <20250508022839.1256059-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508022839.1256059-1-kuba@kernel.org>
References: <20250508022839.1256059-1-kuba@kernel.org>
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
 tools/net/ynl/pyynl/ynl_gen_c.py | 56 ++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 4a2d3cc07e14..2ae5eaf2611d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -163,7 +163,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return False
 
     def _free_lines(self, ri, var, ref):
-        if self.is_multi_val() or self.presence_type() == 'len':
+        if self.is_multi_val() or self.presence_type() in {'count', 'len'}:
             return [f'free({var}->{ref}{self.c_name});']
         return []
 
@@ -516,13 +516,21 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
 class TypeBinary(Type):
     def arg_member(self, ri):
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            return [f'__{self.get("sub-type")} *{self.c_name}', 'size_t count']
         return [f"const void *{self.c_name}", 'size_t len']
 
     def presence_type(self):
-        return 'len'
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            return 'count'
+        else:
+            return 'len'
 
     def struct_member(self, ri):
-        ri.cw.p(f"void *{self.c_name};")
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            ri.cw.p(f'__{self.get("sub-type")} *{self.c_name};')
+        else:
+            ri.cw.p(f"void *{self.c_name};")
 
     def _attr_typol(self):
         return f'.type = YNL_PT_BINARY,'
@@ -549,18 +557,46 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return mem
 
     def attr_put(self, ri, var):
-        self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, " +
-                            f"{var}->{self.c_name}, {var}->_len.{self.c_name})")
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            presence = self.presence_type()
+            ri.cw.block_start(line=f"if ({var}->_{presence}.{self.c_name})")
+            ri.cw.p(f"i = {var}->_{presence}.{self.c_name} * sizeof(__{self.get('sub-type')});")
+            ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, " +
+                    f"{var}->{self.c_name}, i);")
+            ri.cw.block_end()
+            pass
+        else:
+            self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, "
+                                f"{var}->{self.c_name}, {var}->_len.{self.c_name})")
 
     def _attr_get(self, ri, var):
-        len_mem = var + '->_len.' + self.c_name
-        return [f"{len_mem} = len;",
-                f"{var}->{self.c_name} = malloc(len);",
-                f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
+        get_lines = []
+        len_mem = var + '->_' + self.presence_type() + '.' + self.c_name
+
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            get_lines = [
+                f"{len_mem} = len / sizeof(__{self.get('sub-type')});",
+                f"len = {len_mem} * sizeof(__{self.get('sub-type')});",
+            ]
+        else:
+            get_lines += [f"{len_mem} = len;"]
+
+        get_lines += [
+            f"{var}->{self.c_name} = malloc(len);",
+            f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"
+        ]
+
+        return get_lines, \
                ['len = ynl_attr_data_len(attr);'], \
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
+        if self.get('sub-type') and self.get('sub-type') in scalars:
+            return [f"{presence} = count;",
+                    f"count *= sizeof(__{self.get('sub-type')});",
+                    f"{member} = malloc(count);",
+                    f'memcpy({member}, {self.c_name}, count);']
+
         return [f"{presence} = len;",
                 f"{member} = malloc({presence});",
                 f'memcpy({member}, {self.c_name}, {presence});']
@@ -672,7 +708,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         lines = []
         if self.attr['type'] in scalars:
             lines += [f"free({var}->{ref}{self.c_name});"]
-        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+        elif self.attr['type'] == 'binary':
             lines += [f"free({var}->{ref}{self.c_name});"]
         elif self.attr['type'] == 'string':
             lines += [
-- 
2.49.0


