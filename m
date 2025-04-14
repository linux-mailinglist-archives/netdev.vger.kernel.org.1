Return-Path: <netdev+bounces-182476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00AA88DA5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188B93B55E5
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06A1F17E8;
	Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrFDyUnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882C1F12FF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665600; cv=none; b=bE+U4SRjQxslQMbzMsvNrIajI1axJ4sBcYzyQZbLtcSedS7hqqpa63R9yEmpazdfp54j2E8JV9/Pa8c4LOk2Pny+rLHSH2xfNqCKRg4xnQBxO/y6R3FAKk1fERq1IGcI1CZmiJWh3jJU9DvhaUFq948gDiM3ccjhMxlrG71fWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665600; c=relaxed/simple;
	bh=k6OqkNSYmBgFTAanp9ah3eRAMouXttRd47zH/l8ZRN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKZt/WaYJJdOzXM4rJcpaScPw2SrVAI/SqdKXsR9wE6TEElWTxA4T5epFejLw01k4H6rJul3WnnZYjGC7RMJZuTbSxIoKdqA6lOAqnSw1g9WzpVunTkTeSBdGYPiE2ZHjjzuPIXDOdTf63vLOuuXcl3LxDoHwNPTa/S0LH99Tc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrFDyUnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0CBC4CEEC;
	Mon, 14 Apr 2025 21:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744665599;
	bh=k6OqkNSYmBgFTAanp9ah3eRAMouXttRd47zH/l8ZRN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UrFDyUnu715DwLGbopB14PCrBCHVuBiDeDK6iuVg5MSf/FiV0t12iPjp9oIGCNk1P
	 g6v8NvtaxRy1dw+T3Vo8R9ek71cnXf/M4Al3V5aVIyoXU7sAzjIxVW0z5BUdYEV3o1
	 MdNRGi5BIaaHChPDCLGErDh3s0zTQjj12nLmo3xYQLUpQB+W+zFsAUwEjLY5hVgBXw
	 m0Jg5nVv5yW/4E1BtJBIiKQ95SqeTLBSvVUVbIw6pd6u42fKiTn+CDYtq+S8zjnu5v
	 cCfoxvwZ60qiAKFDawlpUTHfeKHe8SNcda0O04RHzLj/Fz/A25FqqETHixHhP6sVnH
	 X55V7G4d02wzA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/8] tools: ynl-gen: don't declare loop iterator in place
Date: Mon, 14 Apr 2025 14:18:44 -0700
Message-ID: <20250414211851.602096-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414211851.602096-1-kuba@kernel.org>
References: <20250414211851.602096-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The codegen tries to follow the "old" C style and declare loop
iterators at the start of the block / function. Only nested
request handling breaks this style, so adjust it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index a1427c537030..305f5696bc4f 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -654,10 +654,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def attr_put(self, ri, var):
         if self.attr['type'] in scalars:
             put_type = self.type
-            ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             ri.cw.p(f"ynl_attr_put_{put_type}(nlh, {self.enum_name}, {var}->{self.c_name}[i]);")
         elif 'type' not in self.attr or self.attr['type'] == 'nest':
-            ri.cw.p(f"for (unsigned int i = 0; i < {var}->n_{self.c_name}; i++)")
+            ri.cw.p(f"for (i = 0; i < {var}->n_{self.c_name}; i++)")
             self._attr_put_line(ri, var, f"{self.nested_render_name}_put(nlh, " +
                                 f"{self.enum_name}, &{var}->{self.c_name}[i])")
         else:
@@ -1644,11 +1644,23 @@ _C_KW = {
 
 
 def put_req_nested(ri, struct):
+    local_vars = []
+    init_lines = []
+
+    local_vars.append('struct nlattr *nest;')
+    init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
+
+    for _, arg in struct.member_list():
+        if arg.presence_type() == 'count':
+            local_vars.append('unsigned int i;')
+            break
+
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
-    ri.cw.write_func_lvar('struct nlattr *nest;')
+    ri.cw.write_func_lvar(local_vars)
 
-    ri.cw.p("nest = ynl_attr_nest_start(nlh, attr_type);")
+    for line in init_lines:
+        ri.cw.p(line)
 
     for _, arg in struct.member_list():
         arg.attr_put(ri, "obj")
@@ -1850,6 +1862,11 @@ _C_KW = {
         local_vars += ['size_t hdr_len;',
                        'void *hdr;']
 
+    for _, attr in ri.struct["request"].member_list():
+        if attr.presence_type() == 'count':
+            local_vars += ['unsigned int i;']
+            break
+
     print_prototype(ri, direction, terminate=False)
     ri.cw.block_start()
     ri.cw.write_func_lvar(local_vars)
-- 
2.49.0


