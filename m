Return-Path: <netdev+bounces-190883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD6AB92C3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE10A7B4E56
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92DF293732;
	Thu, 15 May 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOeBoC4u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF229344A
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351029; cv=none; b=ODG+5CLr5kKKTc3T5yJm3/K2P3izyOqq3wpmhTQVjChiCFEhwsQqnbz7PBMfo0rsYmDzRnmlsXj8bDYmXyTZnwHNW1a4CnY7adbX1Ob+CJVvEXKy/1Q48CDUOa+n9JlegUk/Sv84GLgKiLQk5afvdrQZYJFhTnDj5qzJZSDQk1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351029; c=relaxed/simple;
	bh=SpR8taaY6nqdJy0egENpsz9egKDxP6fd/ymRNYa6/ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEbauiv3dRQv7lkznQidEQRUupmytY1ZAqltyPW252hF2jFu65YA7Ennu8fD85yt/mRTJlGmJe3vUMUh3fxp/iFS+ptoO3JuC/m0lrM1NiNO/TvcXkkGmGrHAHlUEsEPl7RnrSeMzd91b2DkKvxmdKwUAumhQyUhyyn6XflurbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOeBoC4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A33C4CEF2;
	Thu, 15 May 2025 23:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351029;
	bh=SpR8taaY6nqdJy0egENpsz9egKDxP6fd/ymRNYa6/ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SOeBoC4usD46hGljsnHNCOINlTLxamEpLtgr6cK0mHu2tr+MCLCpIMvZ9MYwUebTK
	 Qx4E9YR2p9ypyhONAS7ARblgYDr4399nJdJtzCyzBT/X/08xMGlPXHE+kwcq7acmVg
	 oMOmWgdekvqHN1sm7aMH0PzgsO0Q5IPGmXArClne2D6xUr+kFFPeyoYkMY2KNccGyG
	 KW4Lw5aS1dzP6Lb7DlJu7jglhTeraQE7K9A0SXVMbmPxCOH0bUTQr08T18sFlykZlv
	 rp4TCXOg9yB5Hcrh0rZNMTbXhm4tmzrGrjVIxtFDIOs83hRRzjRtuzg9ZCepUcWkLX
	 5tWNyDcEtE+/Q==
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
Subject: [PATCH net-next 5/9] tools: ynl-gen: submsg: render the structs
Date: Thu, 15 May 2025 16:16:46 -0700
Message-ID: <20250515231650.1325372-6-kuba@kernel.org>
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

The easiest (or perhaps only sane) way to support submessages in C
is to treat them as if they were nests. Build fake attributes to
that effect in the codegen. Render the submsg as a big nest of all
possible values.

With this in place the main missing part is to hook in the switch
which selects how to parse based on the key.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 46 +++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2292bbb68836..020aa34b890b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -62,6 +62,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
         if 'nested-attributes' in attr:
             nested = attr['nested-attributes']
+        elif 'sub-message' in attr:
+            nested = attr['sub-message']
         else:
             nested = None
 
@@ -125,7 +127,9 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         return c_upper(value)
 
     def resolve(self):
-        if 'name-prefix' in self.attr:
+        if 'parent-sub-message' in self.attr:
+            enum_name = self.attr['parent-sub-message'].enum_name
+        elif 'name-prefix' in self.attr:
             enum_name = f"{self.attr['name-prefix']}{self.name}"
         else:
             enum_name = f"{self.attr_set.name_prefix}{self.name}"
@@ -873,18 +877,20 @@ from lib import SpecSubMessage, SpecSubMessageFormat
         return get_lines, init_lines, local_vars
 
 
-class TypeSubMessage(TypeUnused):
+class TypeSubMessage(TypeNest):
     pass
 
 
 class Struct:
-    def __init__(self, family, space_name, type_list=None, inherited=None):
+    def __init__(self, family, space_name, type_list=None,
+                 inherited=None, submsg=None):
         self.family = family
         self.space_name = space_name
         self.attr_set = family.attr_sets[space_name]
         # Use list to catch comparisons with empty sets
         self._inherited = inherited if inherited is not None else []
         self.inherited = []
+        self.submsg = submsg
 
         self.nested = type_list is None
         if family.name == c_lower(space_name):
@@ -1250,6 +1256,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
             for _, spec in self.attr_sets[name].items():
                 if 'nested-attributes' in spec:
                     nested = spec['nested-attributes']
+                elif 'sub-message' in spec:
+                    nested = spec.sub_message
                 else:
                     continue
 
@@ -1286,6 +1294,32 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
         return nested
 
+    def _load_nested_set_submsg(self, spec):
+        # Fake the struct type for the sub-message itself
+        # its not a attr_set but codegen wants attr_sets.
+        submsg = self.sub_msgs[spec["sub-message"]]
+        nested = submsg.name
+
+        attrs = []
+        for name, fmt in submsg.formats.items():
+            attrs.append({
+                "name": name,
+                "type": "nest",
+                "parent-sub-message": spec,
+                "nested-attributes": fmt['attribute-set']
+            })
+
+        self.attr_sets[nested] = AttrSet(self, {
+            "name": nested,
+            "name-pfx": self.name + '-' + spec.name + '-',
+            "attributes": attrs
+        })
+
+        if nested not in self.pure_nested_structs:
+            self.pure_nested_structs[nested] = Struct(self, nested, submsg=submsg)
+
+        return nested
+
     def _load_nested_sets(self):
         attr_set_queue = list(self.root_sets.keys())
         attr_set_seen = set(self.root_sets.keys())
@@ -1295,6 +1329,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
             for attr, spec in self.attr_sets[a_set].items():
                 if 'nested-attributes' in spec:
                     nested = self._load_nested_set_nest(spec)
+                elif 'sub-message' in spec:
+                    nested = self._load_nested_set_submsg(spec)
                 else:
                     continue
 
@@ -1306,6 +1342,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
             for attr, spec in self.attr_sets[root_set].items():
                 if 'nested-attributes' in spec:
                     nested = spec['nested-attributes']
+                elif 'sub-message' in spec:
+                    nested = spec.sub_message
                 else:
                     nested = None
 
@@ -1329,6 +1367,8 @@ from lib import SpecSubMessage, SpecSubMessageFormat
 
                 if 'nested-attributes' in spec:
                     child_name = spec['nested-attributes']
+                elif 'sub-message' in spec:
+                    child_name = spec.sub_message
                 else:
                     continue
 
-- 
2.49.0


