Return-Path: <netdev+bounces-185370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E2A99EAE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 04:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE44465E1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF31C6FFA;
	Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of+py2q+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA021B4242
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460740; cv=none; b=s7LEvXhdRPCp7zjoO23EtZFGXhxdkpdqSPWhbNj6F6fd4Ep+CM7VB4P7+DVY/fN81+80kCxj6NMdGHlPlo/rA1i1PiWqb9ai4+EEG+xRzU9H3Fs4sSG1MgXtO+vkVRCaulmkJQ7Uxir5Wu1wBV0pyC1JQYKudK38v6qA19CIXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460740; c=relaxed/simple;
	bh=qI40/4apYhyWAYvxRoQxWDZlUlb7jfxIG/Yluph1qXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrbDUVajM7clDNrszgDBv7mtbLWlZaQ5VGZEIOOZEiq/UmHwf7HnSDCnFeirIN5AfY9ewhOWTmHUyqXJzwR+kJS30V27B903usVUAqydfns/UiToSKn7afnYWnykcmvMdDnSgbxXp6qAghE+L+WsX18rz3sWPjTm3qFKsb1MUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of+py2q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF3C4CEEE;
	Thu, 24 Apr 2025 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460739;
	bh=qI40/4apYhyWAYvxRoQxWDZlUlb7jfxIG/Yluph1qXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Of+py2q+DPj7T8uAUsOMm4wIYaFUnnidG1Ba8Hsqq1qJpH1oSsbqoJbJA3mRRCfUs
	 rqe0EYvuT+QfqWmu7QMq6QdBdlPwAj/FdLGSuQ864XymEEmiKtdVG3NPDkSj459SKM
	 0loATnmdd+3mBZLhacDU4YNe6LOFzvj3BcjkC1KQQVgrWKYchUr9QolGUB3OgrL7z3
	 WOIXFygzKFAx7KxXu8AyGVxkdoQnRHJqPV67QCoBmFkfnWNjRmxejNaMkOjIf0W1l+
	 yatMZqoaGHCvNRewKooicT8kNYewoyzL7mlMtiGYXe+tLuifjNokhk+gj+kp6NhoN8
	 rrrdWEzrL7AKQ==
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
Subject: [PATCH net-next 09/12] tools: ynl-gen: array-nest: support put for scalar
Date: Wed, 23 Apr 2025 19:12:04 -0700
Message-ID: <20250424021207.1167791-10-kuba@kernel.org>
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

C codegen supports ArrayNest AKA indexed-array carrying scalars,
but only for the netlink -> struct parsing. Support rendering
from struct to netlink.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 14179b84d8ee..46d99b871d5c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -747,6 +747,23 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                      '}']
         return get_lines, None, local_vars
 
+    def attr_put(self, ri, var):
+        ri.cw.p(f'array = ynl_attr_nest_start(nlh, {self.enum_name});')
+        if self.sub_type in scalars:
+            put_type = self.sub_type
+            ri.cw.block_start(line=f'for (i = 0; i < {var}->n_{self.c_name}; i++)')
+            ri.cw.p(f"ynl_attr_put_{put_type}(nlh, i, {var}->{self.c_name}[i]);")
+            ri.cw.block_end()
+        else:
+            raise Exception(f"Put for ArrayNest sub-type {self.attr['sub-type']} not supported, yet")
+        ri.cw.p('ynl_attr_nest_end(nlh, array);')
+
+    def _setter_lines(self, ri, member, presence):
+        # For multi-attr we have a count, not presence, hack up the presence
+        presence = presence[:-(len('_present.') + len(self.c_name))] + "n_" + self.c_name
+        return [f"{member} = {self.c_name};",
+                f"{presence} = n_{self.c_name};"]
+
 
 class TypeNestTypeValue(Type):
     def _complex_member_type(self, ri):
@@ -1730,10 +1747,15 @@ _C_KW = {
     local_vars.append('struct nlattr *nest;')
     init_lines.append("nest = ynl_attr_nest_start(nlh, attr_type);")
 
+    has_anest = False
+    has_count = False
     for _, arg in struct.member_list():
-        if arg.presence_type() == 'count':
-            local_vars.append('unsigned int i;')
-            break
+        has_anest |= arg.type == 'indexed-array'
+        has_count |= arg.presence_type() == 'count'
+    if has_anest:
+        local_vars.append('struct nlattr *array;')
+    if has_count:
+        local_vars.append('unsigned int i;')
 
     put_req_nested_prototype(ri, struct, suffix='')
     ri.cw.block_start()
-- 
2.49.0


