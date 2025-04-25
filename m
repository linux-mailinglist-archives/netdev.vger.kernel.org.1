Return-Path: <netdev+bounces-185828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48FA9BD04
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A7B7A4D6A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F083318E377;
	Fri, 25 Apr 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTz4/iKM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF218DB1D
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549007; cv=none; b=mOpK+xlMvHgRwo5wyQm2x0PsS9Ung7Wn4gxOixAQvp8c2KYPuRCQGGsisJyHbCpcO0RnP4Hvxmi3OfdcxYtT4QfvLNwI2MrDWQdbMeZo+6NBqMaaFGyZo8CyugQ2F1xE+gYvavChrEr0GVQLiOlU96D6l4nrB8b3sBZj55kym5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549007; c=relaxed/simple;
	bh=W0AXpoyF8Txqa0Z0EoJMZ6GNxcA53eTDcbbE25vT4x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmlRNj6tSRMLXd4T0aO2dpUa8NbrFr9kre10xZ6nkks8hxE4UzOR2OeXCyK8iq5wVWzqIV1pAsUnebZviubLzAU1ZbdUXWmhSGzwB5XLX5B1+QZeyaUVeVKxRyuzuMknROBsDWc6TG61vFfI8QAUzTrAlEPSAV8Ph0Y5YUS6dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTz4/iKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EA6C4CEEC;
	Fri, 25 Apr 2025 02:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549007;
	bh=W0AXpoyF8Txqa0Z0EoJMZ6GNxcA53eTDcbbE25vT4x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTz4/iKMLxD/yX1dVTd5ty4c3w8VkY3ROo/Bjb+4zMIgGpZPMMI/NkEwYkwuK934H
	 WasF5d0S+2eLHFSB+y7vKnS5ohy/xfBGUNVkO8N1tCFhBmifhOz6267PVH/pQ2q6Ji
	 g44MUIMqXcXLv3Dqq8BuMr+A9FsO7taIgEsMkLK2wxgsLRBfMij5JcfSw9jJjl8ded
	 ObVO4Ca+814ubEqO5G5JVivTDdoFajZ2nOImcEYbjnl/EQ5kGXqi3q0G8f92XdNO7W
	 r/8yLZc1IYPgaps6NulMTrkMXDfcHZdyThJp8WuhsLJ4M2YzTItfEegogQBtXns2Uo
	 8OU3xxswtfHMw==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/12] tools: ynl-gen: multi-attr: type gen for string
Date: Thu, 24 Apr 2025 19:43:06 -0700
Message-ID: <20250425024311.1589323-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for multi attr strings (needed for link alt_names).
We record the length individual strings in a len member, to do
the same for multi-attr create a struct ynl_string in ynl.h
and use it as a layer holding both the string and its length.
Since strings may be arbitrary length dynamically allocate each
individual one.

Adjust arg_member and struct member to avoid spacing the double
pointers to get "type **name;" rather than "type * *name;"

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.h          | 13 +++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py | 29 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 59256e258130..0b4acc0d288a 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -85,6 +85,19 @@ struct ynl_sock {
 	unsigned char raw_buf[];
 };
 
+/**
+ * struct ynl_string - parsed individual string
+ * @len: length of the string (excluding terminating character)
+ * @str: valud of the string
+ *
+ * Parsed and nul-terminated string. This struct is only used for arrays of
+ * strings. Non-array string members are placed directly in respective types.
+ */
+struct ynl_string {
+	unsigned int len;
+	char str[];
+};
+
 struct ynl_sock *
 ynl_sock_create(const struct ynl_family *yf, struct ynl_error *e);
 void ynl_sock_destroy(struct ynl_sock *ys);
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 31e904f1a2f0..895bc1ca9505 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -175,7 +175,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
         if member:
-            arg = [member + ' *' + self.c_name]
+            spc = ' ' if member[-1] != '*' else ''
+            arg = [member + spc + '*' + self.c_name]
             if self.presence_type() == 'count':
                 arg += ['unsigned int n_' + self.c_name]
             return arg
@@ -189,7 +190,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             ptr = '*' if self.is_multi_val() else ''
             if self.is_recursive_for_op(ri):
                 ptr = '*'
-            ri.cw.p(f"{member} {ptr}{self.c_name};")
+            spc = ' ' if member[-1] != '*' else ''
+            ri.cw.p(f"{member}{spc}{ptr}{self.c_name};")
             return
         members = self.arg_member(ri)
         for one in members:
@@ -638,6 +640,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _complex_member_type(self, ri):
         if 'type' not in self.attr or self.attr['type'] == 'nest':
             return self.nested_struct_type
+        elif self.attr['type'] == 'string':
+            return 'struct ynl_string *'
         elif self.attr['type'] in scalars:
             scalar_pfx = '__' if ri.ku_space == 'user' else ''
             return scalar_pfx + self.attr['type']
@@ -645,12 +649,18 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             raise Exception(f"Sub-type {self.attr['type']} not supported yet")
 
     def free_needs_iter(self):
-        return 'type' not in self.attr or self.attr['type'] == 'nest'
+        return self.attr['type'] in {'nest', 'string'}
 
     def _free_lines(self, ri, var, ref):
         lines = []
         if self.attr['type'] in scalars:
             lines += [f"free({var}->{ref}{self.c_name});"]
+        elif self.attr['type'] == 'string':
+            lines += [
+                f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
+                f"free({var}->{ref}{self.c_name}[i]);",
+                f"free({var}->{ref}{self.c_name});",
+            ]
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
             lines += [
                 f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
@@ -675,6 +685,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             put_type = self.type
             ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
+        elif self.attr['type'] == 'string':
+            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"ynl_attr_put_str(nlh, {self.enum_name}, {var}->{self.c_name}[i]->str);")
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
             ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
@@ -1834,8 +1847,16 @@ _C_KW = {
             ri.cw.p('return YNL_PARSE_CB_ERROR;')
         elif aspec.type in scalars:
             ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.type}(attr);")
+        elif aspec.type == 'string':
+            ri.cw.p('unsigned int len;')
+            ri.cw.nl()
+            ri.cw.p('len = strnlen(ynl_attr_get_str(attr), ynl_attr_data_len(attr));')
+            ri.cw.p(f'dst->{aspec.c_name}[i] = malloc(sizeof(struct ynl_string) + len + 1);')
+            ri.cw.p(f"dst->{aspec.c_name}[i]->len = len;")
+            ri.cw.p(f"memcpy(dst->{aspec.c_name}[i]->str, ynl_attr_get_str(attr), len);")
+            ri.cw.p(f"dst->{aspec.c_name}[i]->str[len] = 0;")
         else:
-            raise Exception('Nest parsing type not supported yet')
+            raise Exception(f'Nest parsing of type {aspec.type} not supported yet')
         ri.cw.p('i++;')
         ri.cw.block_end()
         ri.cw.block_end()
-- 
2.49.0


