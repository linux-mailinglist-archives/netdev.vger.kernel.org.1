Return-Path: <netdev+bounces-187779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E2AA99B9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B6D16D712
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547EF26A0DD;
	Mon,  5 May 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR+EtEKR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A3D2698A2
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463941; cv=none; b=RZD3RLHR9deTEPUuGJjPr765wFgcn2sn0Uep45pv5697rRfqAXqTozVw27c1Bj5uaLngrzjZ0QMxX9tFMawHTdtoA/Lku0vJCfHFXsUTcjgQa6Na5nLK8Lj56cMdfbeVuvqUIeZiIuwJKXin8xZpCCKiziDLPqDMgSz9864mpJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463941; c=relaxed/simple;
	bh=o39VSfC0pXfnVhdLYfUERq8ENzOWTt2hdPFBiU2o04s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4SiMjjBPBOE5fE/KpXfQWvbN9YQ0C66uRXRhWcJXLxYCtTfC1z7a/6cD4IXNSm8MlcpWIS67ZAhOkKrJTcWp5tTfNAstuvpX933Z3Af56oPZciubo6w3W+gnLWu5dbyRdJAiIXgCC55g6vZwGS6zid+q546n4F7/VhQ2+n02/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR+EtEKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E9EC4CEF2;
	Mon,  5 May 2025 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463940;
	bh=o39VSfC0pXfnVhdLYfUERq8ENzOWTt2hdPFBiU2o04s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZR+EtEKRp3DW6KPqvoI3twnJttPCXU+GjsTLWYLmXK3E/B5gZK8ZmCb94asopY5Y4
	 ku2y5w58CmM4EdmVcGtwuPTMeTFNvFyCv9/YaWnMTBBh7aQ/mDL5mQvM1paJCH9TZ9
	 1XdfCjDHSqXHcO8WhS8OdVwrpY3qPdRCqLZlPkQBzoSuEPBgiOJVHJViqMaRpCc1+s
	 INRbimxEyToF6OKUc0vScmibLHcytSqWu0hb+kbbYsGcFVve7zrk8c2nhSQQfG9jhG
	 nQHWk7Aq/PPL6P8SGAW74nmWZcVwoLHqOVTyNnKMk/oNBTbppVGveKIXsi4P1sEZ1i
	 Rv+vBRU+dNuiw==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tools: ynl-gen: split presence metadata
Date: Mon,  5 May 2025 09:52:06 -0700
Message-ID: <20250505165208.248049-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505165208.248049-1-kuba@kernel.org>
References: <20250505165208.248049-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each YNL struct contains the data and a sub-struct indicating which
fields are valid. Something like:

  struct family_op_req {
      struct {
            u32 a:1;
            u32 b:1;
	    u32 bin_len;
      } _present;

      u32 a;
      u64 b;
      const unsigned char *bin;
  };

Note that the bin object 'bin' has a length stored, and that length
has a _len suffix added to the field name. This breaks if there
is a explicit field called bin_len, which is the case for some
TC actions. Move the length fields out of the _present struct,
create a new struct called _len:

  struct family_op_req {
      struct {
            u32 a:1;
            u32 b:1;
      } _present;
      struct {
	    u32 bin;
      } _len;

      u32 a;
      u64 b;
      const unsigned char *bin;
  };

This should prevent name collisions and help with the packing
of the struct.

Unfortunately this is a breaking change, but hopefully the migration
isn't too painful.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/samples/devlink.c  |  2 +-
 tools/net/ynl/samples/rt-addr.c  |  4 +--
 tools/net/ynl/samples/rt-route.c |  4 +--
 tools/net/ynl/pyynl/ynl_gen_c.py | 46 ++++++++++++++++----------------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/net/ynl/samples/devlink.c b/tools/net/ynl/samples/devlink.c
index d2611d7ebab4..3d32a6335044 100644
--- a/tools/net/ynl/samples/devlink.c
+++ b/tools/net/ynl/samples/devlink.c
@@ -34,7 +34,7 @@ int main(int argc, char **argv)
 		if (!info_rsp)
 			goto err_free_devs;
 
-		if (info_rsp->_present.info_driver_name_len)
+		if (info_rsp->_len.info_driver_name)
 			printf("    driver: %s\n", info_rsp->info_driver_name);
 		if (info_rsp->n_info_version_running)
 			printf("    running fw:\n");
diff --git a/tools/net/ynl/samples/rt-addr.c b/tools/net/ynl/samples/rt-addr.c
index 0f4851b4ec57..2edde5c36b18 100644
--- a/tools/net/ynl/samples/rt-addr.c
+++ b/tools/net/ynl/samples/rt-addr.c
@@ -20,7 +20,7 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
 	if (name)
 		printf("%16s: ", name);
 
-	switch (a->_present.address_len) {
+	switch (a->_len.address) {
 	case 4:
 		addr = inet_ntop(AF_INET, a->address,
 				 addr_str, sizeof(addr_str));
@@ -36,7 +36,7 @@ static void rt_addr_print(struct rt_addr_getaddr_rsp *a)
 	if (addr)
 		printf("%s", addr);
 	else
-		printf("[%d]", a->_present.address_len);
+		printf("[%d]", a->_len.address);
 
 	printf("\n");
 }
diff --git a/tools/net/ynl/samples/rt-route.c b/tools/net/ynl/samples/rt-route.c
index 9d9c868f8873..7427104a96df 100644
--- a/tools/net/ynl/samples/rt-route.c
+++ b/tools/net/ynl/samples/rt-route.c
@@ -26,13 +26,13 @@ static void rt_route_print(struct rt_route_getroute_rsp *r)
 			printf("oif: %-16s ", name);
 	}
 
-	if (r->_present.dst_len) {
+	if (r->_len.dst) {
 		route = inet_ntop(r->_hdr.rtm_family, r->dst,
 				  route_str, sizeof(route_str));
 		printf("dst: %s/%d", route, r->_hdr.rtm_dst_len);
 	}
 
-	if (r->_present.gateway_len) {
+	if (r->_len.gateway) {
 		route = inet_ntop(r->_hdr.rtm_family, r->gateway,
 				  route_str, sizeof(route_str));
 		printf("gateway: %s ", route);
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index f93e6e79312a..800710fe96c9 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -154,7 +154,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         if self.presence_type() == 'len':
             pfx = '__' if space == 'user' else ''
-            return f"{pfx}u32 {self.c_name}_len;"
+            return f"{pfx}u32 {self.c_name};"
 
     def _complex_member_type(self, ri):
         return None
@@ -217,10 +217,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         cw.p(f'[{self.enum_name}] = {"{"} .name = "{self.name}", {typol}{"}"},')
 
     def _attr_put_line(self, ri, var, line):
-        if self.presence_type() == 'present':
-            ri.cw.p(f"if ({var}->_present.{self.c_name})")
-        elif self.presence_type() == 'len':
-            ri.cw.p(f"if ({var}->_present.{self.c_name}_len)")
+        presence = self.presence_type()
+        if presence in {'present', 'len'}:
+            ri.cw.p(f"if ({var}->_{presence}.{self.c_name})")
         ri.cw.p(f"{line};")
 
     def _attr_put_simple(self, ri, var, put_type):
@@ -282,6 +281,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             # Every layer below last is a nest, so we know it uses bit presence
             # last layer is "self" and may be a complex type
             if i == len(ref) - 1 and self.presence_type() != 'present':
+                presence = f"{var}->{'.'.join(ref[:i] + [''])}_{self.presence_type()}.{ref[i]}"
                 continue
             code.append(presence + ' = 1;')
         ref_path = '.'.join(ref[:-1])
@@ -496,7 +496,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self._attr_put_simple(ri, var, 'str')
 
     def _attr_get(self, ri, var):
-        len_mem = var + '->_present.' + self.c_name + '_len'
+        len_mem = var + '->_len.' + self.c_name
         return [f"{len_mem} = len;",
                 f"{var}->{self.c_name} = malloc(len + 1);",
                 f"memcpy({var}->{self.c_name}, ynl_attr_get_str(attr), len);",
@@ -505,10 +505,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"{presence}_len = strlen({self.c_name});",
-                f"{member} = malloc({presence}_len + 1);",
-                f'memcpy({member}, {self.c_name}, {presence}_len);',
-                f'{member}[{presence}_len] = 0;']
+        return [f"{presence} = strlen({self.c_name});",
+                f"{member} = malloc({presence} + 1);",
+                f'memcpy({member}, {self.c_name}, {presence});',
+                f'{member}[{presence}] = 0;']
 
 
 class TypeBinary(Type):
@@ -547,10 +547,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def attr_put(self, ri, var):
         self._attr_put_line(ri, var, f"ynl_attr_put(nlh, {self.enum_name}, " +
-                            f"{var}->{self.c_name}, {var}->_present.{self.c_name}_len)")
+                            f"{var}->{self.c_name}, {var}->_len.{self.c_name})")
 
     def _attr_get(self, ri, var):
-        len_mem = var + '->_present.' + self.c_name + '_len'
+        len_mem = var + '->_len.' + self.c_name
         return [f"{len_mem} = len;",
                 f"{var}->{self.c_name} = malloc(len);",
                 f"memcpy({var}->{self.c_name}, ynl_attr_data(attr), len);"], \
@@ -558,9 +558,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                ['unsigned int len;']
 
     def _setter_lines(self, ri, member, presence):
-        return [f"{presence}_len = len;",
-                f"{member} = malloc({presence}_len);",
-                f'memcpy({member}, {self.c_name}, {presence}_len);']
+        return [f"{presence} = len;",
+                f"{member} = malloc({presence});",
+                f'memcpy({member}, {self.c_name}, {presence});']
 
 
 class TypeBitfield32(Type):
@@ -716,7 +716,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def _setter_lines(self, ri, member, presence):
         # For multi-attr we have a count, not presence, hack up the presence
-        presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
+        presence = presence[:-(len('_count.') + len(self.c_name))] + "n_" + self.c_name
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
@@ -779,7 +779,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def _setter_lines(self, ri, member, presence):
         # For multi-attr we have a count, not presence, hack up the presence
-        presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
+        presence = presence[:-(len('_count.') + len(self.c_name))] + "n_" + self.c_name
         return [f"{member} = {self.c_name};",
                 f"{presence} = n_{self.c_name};"]
 
@@ -2181,18 +2181,18 @@ _C_KW = {
         ri.cw.p(ri.fixed_hdr + ' _hdr;')
         ri.cw.nl()
 
-    meta_started = False
-    for _, attr in struct.member_list():
-        for type_filter in ['len', 'present']:
+    for type_filter in ['present', 'len']:
+        meta_started = False
+        for _, attr in struct.member_list():
             line = attr.presence_member(ri.ku_space, type_filter)
             if line:
                 if not meta_started:
                     ri.cw.block_start(line=f"struct")
                     meta_started = True
                 ri.cw.p(line)
-    if meta_started:
-        ri.cw.block_end(line='_present;')
-        ri.cw.nl()
+        if meta_started:
+            ri.cw.block_end(line=f'_{type_filter};')
+    ri.cw.nl()
 
     for arg in struct.inherited:
         ri.cw.p(f"__u32 {arg};")
-- 
2.49.0


