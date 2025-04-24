Return-Path: <netdev+bounces-185369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19485A99EAC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E094A446511
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3241AC458;
	Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgrBDzLp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EA51A8F97
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460739; cv=none; b=qkWQiGJclmOFrEh7e5+JB34jX6jB4xvH+qYwjQG94APAgfJvUfvjx9lb/49EaBnIs2u1OkEJz/0Xkz+1peij1O0H0TSr6oYVZ+E09zvyq6EJMaGfMSsg4Aeq2J1uqn33T/sMIEJIY3b727iWiM2o2WghiC/pqpeAlCc+szBMhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460739; c=relaxed/simple;
	bh=2M6AGVO0ShVrHCeP/aOEooSXYdimqKUNl6b9yFk0tjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BilfgtYClCxNrYFarihDKvPLUSygezjvfeQ0dEXSSl+kWsA5bWRl4yheezpf09zqqYxnhAv0FyZS8hteURtVVXcIx4VIE0s+LeGRiiFPaEJFcbwtLN2a6SFCG7DS0yklXtUeRyQNfvXwDtKAdMQxRthrN9eNcHl/eNONDmCEPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgrBDzLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A4BC4CEE2;
	Thu, 24 Apr 2025 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460739;
	bh=2M6AGVO0ShVrHCeP/aOEooSXYdimqKUNl6b9yFk0tjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgrBDzLpaFMrgmy5aiLZ/Mg8kG0y5wfrS8ARGxkZlyWEXM1dw+fO8i6VPpgWRb8Rs
	 O7ofXtLKFaRRKdKsgRntImZ+N3shz6kYNEhtUPB3IfSUWXpqhNn33GBICo4hJwg8NC
	 gUpsfl5xZZMRxrc+UqkzU9QpHX+Ig7QlwPyWrBEGX+Z04iOZX8pkfZr1ON2Sft9OWy
	 fNUC0ac1Z1I2miFBoRxKnmSnJaNYzFAABJSwqP4zGDlz4s9I928QbMOR2x0oDmdKWu
	 qrat3DapiZC6qOQ1JFgEvYjMEjiyCykbcphudYt0oDF+j+7kn3BQupJhistslZQaaT
	 gcCNsly02oGaQ==
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
Subject: [PATCH net-next 07/12] tools: ynl-gen: multi-attr: type gen for string
Date: Wed, 23 Apr 2025 19:12:02 -0700
Message-ID: <20250424021207.1167791-8-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424021207.1167791-1-kuba@kernel.org>
References: <20250424021207.1167791-1-kuba@kernel.org>
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
index 6e697d800875..de3e807c4a2c 100755
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
@@ -1836,8 +1849,16 @@ _C_KW = {
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


