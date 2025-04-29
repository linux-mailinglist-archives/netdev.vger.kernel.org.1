Return-Path: <netdev+bounces-186783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B86AA10E2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F15D920070
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40C24290B;
	Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB1uAgzp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D8242902
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941636; cv=none; b=hnx6bFWIENMf/AP7psDt0bf0uvvFbw4oQ49LcH9D82RPgre1LoK6O5LKzFF9f4+n0oQGkYhlJu/tVBspQlnvMFBBBu6WIL187z9FArc3PJv2kSEtP3gU3iPKf0DIEZcinKR4CHuQIDHUiK0z66qxiGSwhhPkvFvj8NJTXmE1yII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941636; c=relaxed/simple;
	bh=4Ez8JgRYiYDbJA8C9t3Hn0ZdojoiKQOxNX+aJNXWdrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oen725NxiM65sMdacyCz9wlG1E+gLZr1xp/x8mG9rGKfHzM2tVVWvR6udTmY+vw/WILfVBpsew9psuKP4FUdzkOGGX7Z5goaMAilF+Wuxkj+3TcEseu2zNnGKATEWSjm4FwYvXdg/vbuM8hZVQTTtAy0RQLteUodENGNnIxVGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB1uAgzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13635C4CEE3;
	Tue, 29 Apr 2025 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941635;
	bh=4Ez8JgRYiYDbJA8C9t3Hn0ZdojoiKQOxNX+aJNXWdrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RB1uAgzpZKwFUEafiIpNSoJbyrBBXq4OktmqdqvKn1Gy2ULBrTeAslYMxEdNGbYWZ
	 gQPPVrz1NLGbMYYxUuxRg0XTXZQAXGwY9fsyMRQ9VvQRlN9I7Cpsc6C5YxjWwbcV16
	 dpfLpLXlByotQ/BQZmUbnowtTPryMdwWyKdyH7fl82A7n7BZzWh7s8XwIb5Nt/NZak
	 7UlW6FcUt0AuqWLM2zpH/GSy2ghaAdjLGFwMN4LuwDNoz9LzXV2nQoxtr8wwIg7i95
	 qiGxKQvCC99afAFNjTTejUCurGPNRzXIbLQX2ToYux3Lr1ZpOPdBRjd5Y3sFCYz7HG
	 FsDpeR9ckLrUA==
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
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 07/12] tools: ynl-gen: multi-attr: type gen for string
Date: Tue, 29 Apr 2025 08:46:59 -0700
Message-ID: <20250429154704.2613851-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
References: <20250429154704.2613851-1-kuba@kernel.org>
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

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - fix typo in a comment
v2: https://lore.kernel.org/20250425024311.1589323-8-kuba@kernel.org
---
 tools/net/ynl/lib/ynl.h          | 13 +++++++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py | 29 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 59256e258130..6b8a625aaa5f 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -85,6 +85,19 @@ struct ynl_sock {
 	unsigned char raw_buf[];
 };
 
+/**
+ * struct ynl_string - parsed individual string
+ * @len: length of the string (excluding terminating character)
+ * @str: value of the string
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


