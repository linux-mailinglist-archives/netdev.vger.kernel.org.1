Return-Path: <netdev+bounces-134310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C00E998C40
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E1B36606
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC41CC16C;
	Thu, 10 Oct 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0yhkLS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87521CC16A
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573176; cv=none; b=XPWfUn3vR8uSiSZ18XCOBYgEPUAHDaDaUEF0dA6EVQNaEzTy07FiYTVPIAz3cDgYI6dqoNG+/6+VVtPAA6V74bBTZj5PV2gCpL56xJg6nhDnO8r1GCyNWsLVKGoIMYEpBIMf3/VQhIqIZ3aJHz2Pv9FsC9f7uIdkrHGZY0lOrdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573176; c=relaxed/simple;
	bh=b8l3MYI0KQ0pzc1btVYRmPz6q2XTI0LdCDidezpwqcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhxjCwvIT8P+HfalkzXZQyPtjGHhZ+2KON8yjWw7oru6iSUDa0l3WVouxRgbytNIevCehEH6UIquqU/BBF9iYUgrNvE1wADlVDIEax2D5vsTdwiHuMSi03L6bX/RoetLRBTZmB96/SA8SvnhKekukSWx3JrCvo7V+U6xH+A5Odc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0yhkLS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D53C4CEC5;
	Thu, 10 Oct 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728573176;
	bh=b8l3MYI0KQ0pzc1btVYRmPz6q2XTI0LdCDidezpwqcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=C0yhkLS5L778Ns9rerfGwjZQhdIFm9do4Sb92cXy76ZhIAqUQZjNavIuAymCkHa0A
	 mBwFvu6otBo8pTvNGLSWUbAqhSos/GdAZBqrZBxuXvl7tzc3G4KHrpct5SStbRvk9B
	 7AIUaL34ucjHMgFc+f+7OEIg3Q1aN37HY+9P2+x6g1Yunioiclyx0oRFn8AQDaGCSe
	 q9zlUO8XlN0IqbsHhKsrOnjQ0PX8VQ8kKHBWhGCINwgwAneg2CX/w/dAYEEy1d4YTG
	 6q7GXJrorZhuH43cyDL7eIVYm88dgpxXTZ/nyVJP+y9YqNnh162R0BUrun4OJzxHh3
	 nTkSJCYf0l8jg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] tools: ynl-gen: use names of constants in generated limits
Date: Thu, 10 Oct 2024 08:12:48 -0700
Message-ID: <20241010151248.2049755-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

YNL specs can use string expressions for limits, like s32-min
or u16-max. We convert all of those into their numeric values
when generating the code, which isn't always helpful. Try to
retain the string representations in the output. Any sort of
calculations still need the integers.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl-gen.c |  4 ++--
 tools/net/ynl/ynl-gen-c.py | 36 +++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b28424ae06d5..226a7e2c023c 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -14,12 +14,12 @@
 /* Integer value ranges */
 static const struct netlink_range_validation netdev_a_page_pool_id_range = {
 	.min	= 1ULL,
-	.max	= 4294967295ULL,
+	.max	= U32_MAX,
 };
 
 static const struct netlink_range_validation netdev_a_page_pool_ifindex_range = {
 	.min	= 1ULL,
-	.max	= 2147483647ULL,
+	.max	= S32_MAX,
 };
 
 /* Common nested types */
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 9e8254aad578..d64cb2b49c44 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -80,11 +80,21 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         value = self.checks.get(limit, default)
         if value is None:
             return value
-        elif value in self.family.consts:
+        if isinstance(value, int):
+            return value
+        if value in self.family.consts:
+            raise Exception("Resolving family constants not implemented, yet")
+        return limit_to_number(value)
+
+    def get_limit_str(self, limit, default=None, suffix=''):
+        value = self.checks.get(limit, default)
+        if value is None:
+            return ''
+        if isinstance(value, int):
+            return str(value) + suffix
+        if value in self.family.consts:
             return c_upper(f"{self.family['name']}-{value}")
-        if not isinstance(value, int):
-            value = limit_to_number(value)
-        return value
+        return c_upper(value)
 
     def resolve(self):
         if 'name-prefix' in self.attr:
@@ -358,11 +368,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif 'full-range' in self.checks:
             return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
         elif 'range' in self.checks:
-            return f"NLA_POLICY_RANGE({policy}, {self.get_limit('min')}, {self.get_limit('max')})"
+            return f"NLA_POLICY_RANGE({policy}, {self.get_limit_str('min')}, {self.get_limit_str('max')})"
         elif 'min' in self.checks:
-            return f"NLA_POLICY_MIN({policy}, {self.get_limit('min')})"
+            return f"NLA_POLICY_MIN({policy}, {self.get_limit_str('min')})"
         elif 'max' in self.checks:
-            return f"NLA_POLICY_MAX({policy}, {self.get_limit('max')})"
+            return f"NLA_POLICY_MAX({policy}, {self.get_limit_str('max')})"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -413,11 +423,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         else:
             mem = '{ .type = ' + policy
             if 'max-len' in self.checks:
-                mem += ', .len = ' + str(self.get_limit('max-len'))
+                mem += ', .len = ' + self.get_limit_str('max-len')
             mem += ', }'
         return mem
 
@@ -476,9 +486,9 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if len(self.checks) == 0:
             mem = '{ .type = NLA_BINARY, }'
         elif 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + self.get_limit_str('exact-len') + ')'
         elif 'min-len' in self.checks:
-            mem = '{ .len = ' + str(self.get_limit('min-len')) + ', }'
+            mem = '{ .len = ' + self.get_limit_str('min-len') + ', }'
 
         return mem
 
@@ -2166,9 +2176,9 @@ _C_KW = {
             cw.block_start(line=f'static const struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
-                members.append(('min', str(attr.get_limit('min')) + suffix))
+                members.append(('min', attr.get_limit_str('min', suffix=suffix)))
             if 'max' in attr.checks:
-                members.append(('max', str(attr.get_limit('max')) + suffix))
+                members.append(('max', attr.get_limit_str('max', suffix=suffix)))
             cw.write_struct_init(members)
             cw.block_end(line=';')
             cw.nl()
-- 
2.46.2


