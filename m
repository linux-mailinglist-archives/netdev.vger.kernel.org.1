Return-Path: <netdev+bounces-185829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C97A9BD00
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622BF4A6E9E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA2190692;
	Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2IFnWWk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00019066B
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549008; cv=none; b=cN+rilNTHYJ3sQ+gYF8hI8q+YRyBNLCtOEnGCZ8rAYstSPj34w6gSiE045bF2Eff9pJsIYVcvW46t9isNsTC7kLvFEqYMkNRE+RoxQPr3A2hlLUwsRpExUcqgg7tlRPqPWwplZh+b+pt5ycywBhI3vIozMboEHu1+KCp8bteARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549008; c=relaxed/simple;
	bh=Fy3b10ipMXAy9kO4hYpB8QWxx1ALQ/Qt9s56J1ZbUTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2iF2I82t4o6RmXxKxSZl7RPfe1PEsik0CdODCivrI+FqR0TB5t34kt9artmRhU0KYwrMObJPYs5L3TEKMMHqj+qsH5JBR/BC5q8mxwCl7bfNOdZRm/orwTH/ORtwffM7Fz9ooiTRmZ2kfcUdT4NvNoQtkTSPqzaryG6+ggdhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2IFnWWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B667C4CEF0;
	Fri, 25 Apr 2025 02:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549007;
	bh=Fy3b10ipMXAy9kO4hYpB8QWxx1ALQ/Qt9s56J1ZbUTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2IFnWWk1ythO0lWLPiFp5/RCkbNzexTvX5TRDJp6xhiZ2OgvS9fwatE4EuFW0zQL
	 +jJEC11RSPtPbMy+Uc39DFBnLVpu1v3QtvY5MV+0eCbvdrCMINYRbU0w0uHWQKKjvL
	 tePTQrGVdq7hjfptNSeJSPh8UqSB/mY4TbDic2AbIWsGth3LDa/575jBej9yE7GqFO
	 0T8Na61NKtzLnysGp9Q4cG8LXcdeRkJ0JahYgyGRev9vGvHxv+JY8Hk+LoBq7hXkQL
	 RuXs+N1yYghZz9yZ6qbTF8HAUezgkBPjPrzOrOQ65hl5RTGDoHjZtluwpw7+yCe0SZ
	 0+u/Nf7H7lLvA==
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
Subject: [PATCH net-next v2 08/12] tools: ynl-gen: mutli-attr: support binary types with struct
Date: Thu, 24 Apr 2025 19:43:07 -0700
Message-ID: <20250425024311.1589323-9-kuba@kernel.org>
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

Binary types with struct are fixed size, relatively easy to
handle for multi attr. Declare the member as a pointer.
Count the members, allocate an array, copy in the data.
Allow the netlink attr to be smaller or larger than our view
of the struct in case the build headers are newer or older
than the running kernel.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 895bc1ca9505..a969762d557b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -640,6 +640,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _complex_member_type(self, ri):
         if 'type' not in self.attr or self.attr['type'] == 'nest':
             return self.nested_struct_type
+        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+            return None  # use arg_member()
         elif self.attr['type'] == 'string':
             return 'struct ynl_string *'
         elif self.attr['type'] in scalars:
@@ -648,6 +650,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         else:
             raise Exception(f"Sub-type {self.attr['type']} not supported yet")
 
+    def arg_member(self, ri):
+        if self.type == 'binary' and 'struct' in self.attr:
+            return [f'struct {c_lower(self.attr["struct"])} *{self.c_name}',
+                    f'unsigned int n_{self.c_name}']
+        return super().arg_member(ri)
+
     def free_needs_iter(self):
         return self.attr['type'] in {'nest', 'string'}
 
@@ -655,6 +663,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         lines = []
         if self.attr['type'] in scalars:
             lines += [f"free({var}->{ref}{self.c_name});"]
+        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+            lines += [f"free({var}->{ref}{self.c_name});"]
         elif self.attr['type'] == 'string':
             lines += [
                 f"for (i = 0; i < {var}->{ref}n_{self.c_name}; i++)",
@@ -685,6 +695,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             put_type = self.type
             ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
+        elif self.attr['type'] == 'binary' and 'struct' in self.attr:
+            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"ynl_attr_put(nlh, {self.enum_name}, &{var}->{self.c_name}[i], sizeof(struct {c_lower(self.attr['struct'])}));")
         elif self.attr['type'] == 'string':
             ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_str(nlh, {self.enum_name}, {var}->{self.c_name}[i]->str);")
@@ -1847,6 +1860,12 @@ _C_KW = {
             ri.cw.p('return YNL_PARSE_CB_ERROR;')
         elif aspec.type in scalars:
             ri.cw.p(f"dst->{aspec.c_name}[i] = ynl_attr_get_{aspec.type}(attr);")
+        elif aspec.type == 'binary' and 'struct' in aspec:
+            ri.cw.p('size_t len = ynl_attr_data_len(attr);')
+            ri.cw.nl()
+            ri.cw.p(f'if (len > sizeof(dst->{aspec.c_name}[0]))')
+            ri.cw.p(f'len = sizeof(dst->{aspec.c_name}[0]);')
+            ri.cw.p(f"memcpy(&dst->{aspec.c_name}[i], ynl_attr_data(attr), len);")
         elif aspec.type == 'string':
             ri.cw.p('unsigned int len;')
             ri.cw.nl()
-- 
2.49.0


