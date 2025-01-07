Return-Path: <netdev+bounces-155668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A596A03521
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01A93A33C8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789478F54;
	Tue,  7 Jan 2025 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjdppTOy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F106155335
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216903; cv=none; b=q5HxztLkFX9bK5r+YKDhN+QZT9e6IHh+Zsp9ZdqMcA5fWPEywNoVq4PKgBxqjmOXR9FJC0qRbNjkHFnqIgEuqgfK7ymA9ENZroqEodEJbUXQsUXdF8j+iGCzTXi16t6nVQhNYVaTtEljLtWs/Zwvr2OTFPGJN4DZ7i3GiFAKtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216903; c=relaxed/simple;
	bh=yeScf+u+X2wCd8NrEgJmObDNAsB/4XtqPjyHI46v/MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtRL+wTUAS2T2GMIuDHLToY95cAwCaZhcKUn0NkTB8VEqJGQ6PBhws9qoiRUCeF0NMSQAuumy6p01rleUyQhlyjl2W1009mW+gUsR8kH0x2NfIdCIyXgZ7Ec5t2zU0Shnf7GA16fC8fa4qS/qJh9ActXvTgYo9YKJ0b5TzVepNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjdppTOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBB5C4CEDD;
	Tue,  7 Jan 2025 02:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736216902;
	bh=yeScf+u+X2wCd8NrEgJmObDNAsB/4XtqPjyHI46v/MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjdppTOyl+2mR33MILJYawBGjd0gC3fvwO2KPDtJOqbWORIY3RH2lvI5jpTiFrIqQ
	 hV/534RX2ifxezTzqDuASKXOGqnJ/Eb+KHDOdMbutYLxpKIwo/cTZA+NYaj1TnzTp0
	 w0J83hFmveBGTP0lErGNnK0gmj8h7s1NvvJxl2XiAzz7N33QyqUG67Pg7f+cvjCoog
	 QaEWEfHIHtg6cjEiEjQo63uw8Mru5FmxPOE4ZxUFsC3ish102YozSJHOakYvn89aUp
	 IvESjZXTShj7oRHacAbh7JZSjxcTStg1JVOnt8id9t392bS7h4Bc8FQ4HMLWN3H6Co
	 NcFJPxKs87fdg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] tools: ynl: correctly handle overrides of fields in subset
Date: Mon,  6 Jan 2025 18:28:18 -0800
Message-ID: <20250107022820.2087101-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107022820.2087101-1-kuba@kernel.org>
References: <20250107022820.2087101-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We stated in documentation [1] and previous discussions [2]
that the need for overriding fields in members of subsets
is anticipated. Implement it.

Since each attr is now a new object we need to make sure
that the modifications are propagated. Specifically C codegen
wants to annotate which attrs are used in requests and replies
to generate the right validation artifacts.

[1] https://docs.kernel.org/next/userspace-api/netlink/specs.html#subset-of
[2] https://lore.kernel.org/netdev/20231004171350.1f59cd1d@kernel.org/

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - adjust C code gen in patch 1, it dependend on reusing attr objects
v1: https://lore.kernel.org/20250105012523.1722231-1-kuba@kernel.org
---
 tools/net/ynl/lib/nlspec.py |  5 ++++-
 tools/net/ynl/ynl-gen-c.py  | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index a745739655ad..314ec8007496 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -219,7 +219,10 @@ jsonschema = None
         else:
             real_set = family.attr_sets[self.subset_of]
             for elem in self.yaml['attributes']:
-                attr = real_set[elem['name']]
+                real_attr = real_set[elem['name']]
+                combined_elem = real_attr.yaml | elem
+                attr = self.new_attr(combined_elem, real_attr.value)
+
                 self.attrs[attr.name] = attr
                 self.attrs_by_val[attr.value] = attr
 
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index ec2288948795..58657dd7dedb 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -79,6 +79,20 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.enum_name = None
         delattr(self, "enum_name")
 
+    def _get_real_attr(self):
+        # if the attr is for a subset return the "real" attr (just one down, does not recurse)
+        return self.family.attr_sets[self.attr_set.subset_of][self.name]
+
+    def set_request(self):
+        self.request = True
+        if self.attr_set.subset_of:
+            self._get_real_attr().set_request()
+
+    def set_reply(self):
+        self.reply = True
+        if self.attr_set.subset_of:
+            self._get_real_attr().set_reply()
+
     def get_limit(self, limit, default=None):
         value = self.checks.get(limit, default)
         if value is None:
@@ -106,6 +120,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             enum_name = f"{self.attr_set.name_prefix}{self.name}"
         self.enum_name = c_upper(enum_name)
 
+        if self.attr_set.subset_of:
+            if self.checks != self._get_real_attr().checks:
+                raise Exception("Overriding checks not supported by codegen, yet")
+
     def is_multi_val(self):
         return None
 
@@ -1119,17 +1137,17 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         for _, struct in self.pure_nested_structs.items():
             if struct.request:
                 for _, arg in struct.member_list():
-                    arg.request = True
+                    arg.set_request()
             if struct.reply:
                 for _, arg in struct.member_list():
-                    arg.reply = True
+                    arg.set_reply()
 
         for root_set, rs_members in self.root_sets.items():
             for attr, spec in self.attr_sets[root_set].items():
                 if attr in rs_members['request']:
-                    spec.request = True
+                    spec.set_request()
                 if attr in rs_members['reply']:
-                    spec.reply = True
+                    spec.set_reply()
 
     def _load_global_policy(self):
         global_set = set()
-- 
2.47.1


