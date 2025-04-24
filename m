Return-Path: <netdev+bounces-185373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A244A99EB1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2003B19462F3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249461DB127;
	Thu, 24 Apr 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMBIpj9p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB31D8E01
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460741; cv=none; b=S7GE5nB6CblUs32lcgVkQfv+RDfAVBVW0OhmQS9bVIdB5gTkeR58lHngs2l0Hpc9yONOSQniFEMyEVvoRmOfeJUQA7tbC3llsq3/42KOxjmg9IhWSP1xRPTkRzJVllSeOijUvXXB/KGPFjQLChQ4Ja+yRm1/ziyb8AKLRUZPQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460741; c=relaxed/simple;
	bh=AmS80Wuhl90KkU8JvjkTBI5JF3NtxkU/ITKJ7u5STe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4IhlPBBl6Oz7PM1gey/EgmTbnsj06QcKE86h0lbFZeVPIrhHAdirh0rPnDVQlXuIrnC5hx5vnuvjZZHl6BDNiaGkDyAB9SeZy0DcFeFVIzk/3cFk2hoxS/uI3kCVMTFdVjmN/q22G0NgeHcBas83f1hnH/xES9dz7Yk1sZ7drM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMBIpj9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294E0C4CEEA;
	Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460739;
	bh=AmS80Wuhl90KkU8JvjkTBI5JF3NtxkU/ITKJ7u5STe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMBIpj9p6V+7H/iWNHhA0sFMxrGxyMZqUdbeWAapKPLObuWAROZXheO8XlVdS8IrO
	 I0TC7nJ2yjbLzjPNtsiQeZXsY3Woi8F/ZdUZcfnUZTl/q04YoboQzNTvzx1/8RDEGd
	 hJU0XX9/qZW/su9MdnHtFrtjAmhUZSXhWs9oQiFP+GLP1TAl+GNBM1z/qPymMh/U6W
	 VbunB712P2i4bPnlseswBit1KOfn+iMjqId6Vsl+KvgxaOKqkfkBs73L40LVPK6F/w
	 xx+un2zlQNx7RgtgJN5+5VN9F7vZi5BKFEFRO58L9znw+WzOuv+L0ar7ZWIyjON4F+
	 KK7jRxfETytDw==
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
Subject: [PATCH net-next 08/12] tools: ynl-gen: mutli-attr: support binary types with struct
Date: Wed, 23 Apr 2025 19:12:03 -0700
Message-ID: <20250424021207.1167791-9-kuba@kernel.org>
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

Binary types with struct are fixed size, relatively easy to
handle for multi attr. Declare the member as a pointer.
Count the members, allocate an array, copy in the data.
Allow the netlink attr to be smaller or larger than our view
of the struct in case the build headers are newer or older
than the running kernel.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index de3e807c4a2c..14179b84d8ee 100755
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
@@ -1849,6 +1862,12 @@ _C_KW = {
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


