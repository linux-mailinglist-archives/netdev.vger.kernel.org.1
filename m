Return-Path: <netdev+bounces-186784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5897AA10E3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BD79218A3
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E524293B;
	Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIM5PkIs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F9242931
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941636; cv=none; b=g+1ABc6MHVGlD1oxeglFfxOqgbn63l3qdFH0SauPbFrwDw1za4+zWJ8LcSGdKI49msiGBpq6DlRGQTLhYC5Xe4P924CqV7+0oaynn0i8cjMQiDbznT1nSXDvnjPaPBcfNxXGfGyQ/NHRkUeYuZmE4wnqXaIixqyQz4+icjjnOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941636; c=relaxed/simple;
	bh=czRZBYgFBLd4byPmcXNnoV4VAH7E9hBOruihpCIsO1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B31TDEPYLDc6/n6jY0Y3TBP8DsO656uJjX0BpY7h7mJdOLubmTHNDkRFDIupDcpoez5kTr4pVA/BkCC42LhP4BGu4F/7oyGLRd2a5Tgetf/0uk/tikIBLIPDWYNrcogpRA48u/Ms7YsXp4T20LYvel54biEqhAFaG8C7xMeM31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIM5PkIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1540C4CEE9;
	Tue, 29 Apr 2025 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941636;
	bh=czRZBYgFBLd4byPmcXNnoV4VAH7E9hBOruihpCIsO1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IIM5PkIs+InFYtI7nlXSC/tfGz1XIxMD6i4PFT8OFETAqGqUWPoBsp29wD4no9dn2
	 DlMzTg+Ne6CZYyLe0TkgEKLeHgIeZkL9m+EndAQa+VI2O0NLpFDTwycw0/Oy8viR+9
	 e/PQ0xy8DeUcH54uw/ggsyNRlOYYxlfoouWhZ9Xx12zyn+4XbdqLAMW1PhU2rpWPDP
	 8fnXZ27uBTn9LRmol5ivYXumfCeSa0N2nv2Fs1pqH/3cVuSfhsKy0GS4tHOEh9xufV
	 J5HAcsKto45C9+Y3xIVsrG5d1TeRbMR/tKta8NO3SF1zUxOR2Xe6SCwHQbG+9SCryR
	 4ykB5Xzl/MAMg==
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
Subject: [PATCH net-next v3 08/12] tools: ynl-gen: mutli-attr: support binary types with struct
Date: Tue, 29 Apr 2025 08:47:00 -0700
Message-ID: <20250429154704.2613851-9-kuba@kernel.org>
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

Binary types with struct are fixed size, relatively easy to
handle for multi attr. Declare the member as a pointer.
Count the members, allocate an array, copy in the data.
Allow the netlink attr to be smaller or larger than our view
of the struct in case the build headers are newer or older
than the running kernel.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
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


