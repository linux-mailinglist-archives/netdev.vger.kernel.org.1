Return-Path: <netdev+bounces-190881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA72AB92C0
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B871B62A08
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076928E5E3;
	Thu, 15 May 2025 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t14f/wLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5628E565
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351028; cv=none; b=F4TNM6WHNc1sw25Woy+ta/3US9y3iU7kRUKqxulMchUKBdlvr/4+v5C0ktaGkCXdaYXuaKISRIrBvmu2ZlBR/Fe+elw1ThFm60Njea3+ZIxyUiJT1CX9eon47n2+lMycBo1FLIsWHdR6PuWgKr4yiFMRxDG7oO7fdAFqQVnARvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351028; c=relaxed/simple;
	bh=JOqqr+WTW/Y4YBLjPuwXmtrijmeDuCoK5vkpmJvu9Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fewKJOOoEwvjbKMLgw6Yrc0UpiSLhW1RR2JK/2Z/myaREAjy9xw/avaHAqExmQRb9kXDnzqvhtWPad1UZ7p65vQzzgi4tWNzip+FQg63RFVEZaRjCsvRzP/+2k0P8ehDtjR3IDvYDOGI/I4d1151LywRtROegA4QWLgIQwqGr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t14f/wLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D8FC4CEEF;
	Thu, 15 May 2025 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351028;
	bh=JOqqr+WTW/Y4YBLjPuwXmtrijmeDuCoK5vkpmJvu9Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t14f/wLA3SO93wkRfRqGi2rgFC+Ah88Ar/GBQzmmkJDtnHWm0vbHsftYnqcIcLUjR
	 EYUBpvOnXK20fLzXgIlEcyuEeTj2D+LVPWoLNm58IFU/thK3RtZDFw29+aqbXQSzat
	 h8VRucoNtSHbs1kddEk8ye+B47+IJvUl9KSymPYxzM2Lz3SoKJqJku6aRurubpcMio
	 r57wevw6jdfSMlStAuNcdpn9/Kc0FopNv8jhQMKfiJUwITXYR3z2AdT7nWjayAcZiq
	 l53xT3sM0mzCKyUVvnZND4LMA9STIcaHBbQ6QtYV7Lwl2Rctp+6YhDHxKPBt+VnkaQ
	 M5AKc0ujOJ16Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/9] tools: ynl-gen: prepare for submsg structs
Date: Thu, 15 May 2025 16:16:44 -0700
Message-ID: <20250515231650.1325372-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for constructing Struct() instances which represent
sub-messages rather than nested attributes.
Restructure the code / indentation to more easily insert
a case where nested reference comes from annotation other
than the 'nested-attributes' property. Make sure we don't
construct the Struct() object from scratch in multiple
places as the constructor will soon have more arguments.

This should cause no functional change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 62 ++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 84140ce3a48d..c8b2a2ab2e5d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -60,7 +60,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.len = attr['len']
 
         if 'nested-attributes' in attr:
-            self.nested_attrs = attr['nested-attributes']
+            nested = attr['nested-attributes']
+        else:
+            nested = None
+
+        if nested:
+            self.nested_attrs = nested
             if self.nested_attrs == family.name:
                 self.nested_render_name = c_lower(f"{family.ident_name}")
             else:
@@ -1225,15 +1230,18 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             for _, spec in self.attr_sets[name].items():
                 if 'nested-attributes' in spec:
                     nested = spec['nested-attributes']
-                    # If the unknown nest we hit is recursive it's fine, it'll be a pointer
-                    if self.pure_nested_structs[nested].recursive:
-                        continue
-                    if nested not in pns_key_seen:
-                        # Dicts are sorted, this will make struct last
-                        struct = self.pure_nested_structs.pop(name)
-                        self.pure_nested_structs[name] = struct
-                        finished = False
-                        break
+                else:
+                    continue
+
+                # If the unknown nest we hit is recursive it's fine, it'll be a pointer
+                if self.pure_nested_structs[nested].recursive:
+                    continue
+                if nested not in pns_key_seen:
+                    # Dicts are sorted, this will make struct last
+                    struct = self.pure_nested_structs.pop(name)
+                    self.pure_nested_structs[name] = struct
+                    finished = False
+                    break
             if finished:
                 pns_key_seen.add(name)
             else:
@@ -1278,10 +1286,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             for attr, spec in self.attr_sets[root_set].items():
                 if 'nested-attributes' in spec:
                     nested = spec['nested-attributes']
+                else:
+                    nested = None
+
+                if nested:
                     if attr in rs_members['request']:
                         self.pure_nested_structs[nested].request = True
                     if attr in rs_members['reply']:
                         self.pure_nested_structs[nested].reply = True
+
                     if spec.is_multi_val():
                         child = self.pure_nested_structs.get(nested)
                         child.in_multi_val = True
@@ -1291,20 +1304,24 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         # Propagate the request / reply / recursive
         for attr_set, struct in reversed(self.pure_nested_structs.items()):
             for _, spec in self.attr_sets[attr_set].items():
-                if 'nested-attributes' in spec:
-                    child_name = spec['nested-attributes']
-                    struct.child_nests.add(child_name)
-                    child = self.pure_nested_structs.get(child_name)
-                    if child:
-                        if not child.recursive:
-                            struct.child_nests.update(child.child_nests)
-                        child.request |= struct.request
-                        child.reply |= struct.reply
-                        if spec.is_multi_val():
-                            child.in_multi_val = True
                 if attr_set in struct.child_nests:
                     struct.recursive = True
 
+                if 'nested-attributes' in spec:
+                    child_name = spec['nested-attributes']
+                else:
+                    continue
+
+                struct.child_nests.add(child_name)
+                child = self.pure_nested_structs.get(child_name)
+                if child:
+                    if not child.recursive:
+                        struct.child_nests.update(child.child_nests)
+                    child.request |= struct.request
+                    child.reply |= struct.reply
+                    if spec.is_multi_val():
+                        child.in_multi_val = True
+
         self._sort_pure_types()
 
     def _load_attr_use(self):
@@ -3307,8 +3324,7 @@ _C_KW = {
                     has_recursive_nests = True
             if has_recursive_nests:
                 cw.nl()
-            for name in parsed.pure_nested_structs:
-                struct = Struct(parsed, name)
+            for struct in parsed.pure_nested_structs.values():
                 put_typol(cw, struct)
             for name in parsed.root_sets:
                 struct = Struct(parsed, name)
-- 
2.49.0


