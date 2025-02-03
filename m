Return-Path: <netdev+bounces-162289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32704A2662C
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C269C3A4774
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C402210F4D;
	Mon,  3 Feb 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf2CrOKS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A22210186
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619713; cv=none; b=CHWSIERW5KoszWJh7tTAXrGPU3LhVKEMU7gjM4O27QQvzrDi933hhZw59MPkvKmGds4H48liuYwMUlBiYLtg1EIb0V2dgLMK4elZXHZvLmOQFjyHFz+jO1rNjAWGMAGiAOciO11XGJvIzvyIV6CCNedq+aAzO5rEkx6TZewrOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619713; c=relaxed/simple;
	bh=u8aOILEh/mixMV1eqeShY1XpqUuv3/bwNUzXCc6zhz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpJab4clRewlnQyepQVuNSm7iGVtVTBtjuOIfC0J1845umbnTulIbogc2Gzw/0SqyhPzBOON/6rHHr8lrwFRlMBVJoYnGTP6iegr8wnbxHmTG1luibrKNKQ3y5TkMOxUizeLpT8MHQ594svrPXoGYOrs9maa9bXppR/6KOH0mlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf2CrOKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70356C4CEE4;
	Mon,  3 Feb 2025 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738619712;
	bh=u8aOILEh/mixMV1eqeShY1XpqUuv3/bwNUzXCc6zhz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uf2CrOKS41lbuxwos7njM18Xd+7nqgPa8O2JZezb2XwtWSkoeZds3VBtheYFk4FXB
	 xp0VFnaDxQfYUcyR9e+dF/a/LbRn4NajT+JzA951IbFwmLVbLh0pMsW66gAde5avTb
	 JeVR7KJuFfFAUoKA7KtLxt9LUfUnPO6RMXWbe/pm18gnciddlVPqWPwJkTlZayRff+
	 rEurXoo0vQwVHqyfT8DBtJ02qlARhuYVZSOI3BXvEJtrntf94mP+czMkeBcZlvi8v2
	 6vkOOG9fTauKC3VOLhgCcOB4pli2PQG2+MCcmvH2QZZFKFmBQqus3macZm3XgqDexi
	 LKzTWNUPVK6FQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	cjubran@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 2/2] tools: ynl-gen: support limits using definitions
Date: Mon,  3 Feb 2025 13:55:10 -0800
Message-ID: <20250203215510.1288728-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203215510.1288728-1-kuba@kernel.org>
References: <20250203215510.1288728-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using defines / constants in integer checks.
Carolina will need this for rate API extensions.

Reported-by: Carolina Jubran <cjubran@nvidia.com>
Link: https://lore.kernel.org/1e886aaf-e1eb-4f1a-b7ef-f63b350a3320@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: nicolas.dichtel@6wind.com
---
 Documentation/netlink/genetlink-c.yaml      | 5 +++--
 Documentation/netlink/genetlink-legacy.yaml | 5 +++--
 Documentation/netlink/genetlink.yaml        | 5 +++--
 tools/net/ynl/pyynl/ynl_gen_c.py            | 5 ++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9660ffb1ed6a..44f2226160ca 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -14,9 +14,10 @@ $schema: https://json-schema.org/draft-07/schema
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 16380e12cabe..ed64acf1bef7 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -14,9 +14,10 @@ $schema: https://json-schema.org/draft-07/schema
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b036227b46f1..e43e50dba2e4 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -14,9 +14,10 @@ $schema: https://json-schema.org/draft-07/schema
     pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
-    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    # literal int, const name, or limit based on fixed-width type
+    # e.g. u8-min, u16-max, etc.
     type: [ string, integer ]
-    pattern: ^[su](8|16|32|64)-(min|max)$
+    pattern: ^[0-9A-Za-z_-]+$
     minimum: 0
 
 # Schema for specs
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index aa08b8b1463d..b22082fd660e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -100,7 +100,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if isinstance(value, int):
             return value
         if value in self.family.consts:
-            raise Exception("Resolving family constants not implemented, yet")
+            return self.family.consts[value]["value"]
         return limit_to_number(value)
 
     def get_limit_str(self, limit, default=None, suffix=''):
@@ -110,6 +110,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if isinstance(value, int):
             return str(value) + suffix
         if value in self.family.consts:
+            const = self.family.consts[value]
+            if const.get('header'):
+                return c_upper(value)
             return c_upper(f"{self.family['name']}-{value}")
         return c_upper(value)
 
-- 
2.48.1


