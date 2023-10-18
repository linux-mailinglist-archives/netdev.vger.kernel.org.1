Return-Path: <netdev+bounces-42313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7505F7CE300
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F751C2089B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6873C6BD;
	Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLciT11o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F43B29E
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB5FC433C7;
	Wed, 18 Oct 2023 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697647163;
	bh=DyrngPSgofsrD7LBtufMW0XImjksc5/uqw7c3Y1W9R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLciT11oXGybKx7DnxXv+hOUElni/eJZsYzMxq7K1+oMG+QKNMEcDz8jy2gU0Ud+g
	 I3l4E3kJoRJHJOMM/Wna5nwAhumvuqF44FckIxXJqJgz1ldBjMdZWZ6WprfEeCVIUe
	 xanCoTHqlx21SFse9xctdAOogYeDtE/vZonjNBU2cC+bmIrgm8v6ExXAKnYaPmlYD/
	 z4TKpokmy+/2DQjsHtXU++CsIKR/ENjXbSU9+jF76e7oCBo6FruSFdhAI9jvvOfij0
	 XIwjdkNelkI8PTxHcxED9f2N0/MIclF7j0UjF/niv3/Yzf+2zZB9Zpt1KAuvup8MQB
	 /XJlXrJPJ436Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dcaratti@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] tools: ynl-gen: support limit names
Date: Wed, 18 Oct 2023 09:39:17 -0700
Message-ID: <20231018163917.2514503-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163917.2514503-1-kuba@kernel.org>
References: <20231018163917.2514503-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the use of symbolic names like s8-min or u32-max in checks
to make writing specs less painful.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      |  9 ++++-
 Documentation/netlink/genetlink-legacy.yaml |  9 ++++-
 Documentation/netlink/genetlink.yaml        |  9 ++++-
 tools/net/ynl/ynl-gen-c.py                  | 45 ++++++++++++++++-----
 4 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 75af0b51f3d7..dee11c514896 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -13,6 +13,11 @@ $schema: https://json-schema.org/draft-07/schema
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[su](8|16|32|64)-(min|max)$
+    minimum: 0
 
 # Schema for specs
 title: Protocol
@@ -183,10 +188,10 @@ additionalProperties: False
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   max:
                     description: Max value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index c0f17a8bfe0d..9194f3e223ef 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -13,6 +13,11 @@ $schema: https://json-schema.org/draft-07/schema
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[su](8|16|32|64)-(min|max)$
+    minimum: 0
 
 # Schema for specs
 title: Protocol
@@ -226,10 +231,10 @@ additionalProperties: False
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   max:
                     description: Max value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 4fd56e3b1553..0a4ae861d011 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -13,6 +13,11 @@ $schema: https://json-schema.org/draft-07/schema
     type: [ string, integer ]
     pattern: ^[0-9A-Za-z_]+( - 1)?$
     minimum: 0
+  len-or-limit:
+    # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
+    type: [ string, integer ]
+    pattern: ^[su](8|16|32|64)-(min|max)$
+    minimum: 0
 
 # Schema for specs
 title: Protocol
@@ -156,10 +161,10 @@ additionalProperties: False
                     type: string
                   min:
                     description: Min value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   max:
                     description: Max value for an integer attribute.
-                    type: integer
+                    $ref: '#/$defs/len-or-limit'
                   min-len:
                     description: Min length for a binary attribute.
                     $ref: '#/$defs/len-or-define'
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 9d008346dd50..552ba49a444c 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -20,6 +20,21 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     return name.lower().replace('-', '_')
 
 
+def limit_to_number(name):
+    """
+    Turn a string limit like u32-max or s64-min into its numerical value
+    """
+    if name[0] == 'u' and name.endswith('-min'):
+        return 0
+    width = int(name[1:-4])
+    if name[0] == 's':
+        width -= 1
+    value = (1 << width) - 1
+    if name[0] == 's' and name.endswith('-min'):
+        value = -value - 1
+    return value
+
+
 class BaseNlLib:
     def get_family_id(self):
         return 'ys->family_id'
@@ -68,6 +83,14 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         self.enum_name = None
         delattr(self, "enum_name")
 
+    def get_limit(self, limit, default=None):
+        value = self.checks.get(limit, default)
+        if value is None:
+            return value
+        if not isinstance(value, int):
+            value = limit_to_number(value)
+        return value
+
     def resolve(self):
         if 'name-prefix' in self.attr:
             enum_name = f"{self.attr['name-prefix']}{self.name}"
@@ -273,12 +296,12 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
                 self.checks['max'] = high
 
         if 'min' in self.checks and 'max' in self.checks:
-            if self.checks['min'] > self.checks['max']:
-                raise Exception(f'Invalid limit for "{self.name}" min: {self.checks["min"]} max: {self.checks["max"]}')
+            if self.get_limit('min') > self.get_limit('max'):
+                raise Exception(f'Invalid limit for "{self.name}" min: {self.get_limit("min")} max: {self.get_limit("max")}')
             self.checks['range'] = True
 
-        low = min(self.checks.get('min', 0), self.checks.get('max', 0))
-        high = max(self.checks.get('min', 0), self.checks.get('max', 0))
+        low = min(self.get_limit('min', 0), self.get_limit('max', 0))
+        high = max(self.get_limit('min', 0), self.get_limit('max', 0))
         if low < 0 and self.type[0] == 'u':
             raise Exception(f'Invalid limit for "{self.name}" negative limit for unsigned type')
         if low < -32768 or high > 32767:
@@ -326,11 +349,11 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         elif 'full-range' in self.checks:
             return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
         elif 'range' in self.checks:
-            return f"NLA_POLICY_RANGE({policy}, {self.checks['min']}, {self.checks['max']})"
+            return f"NLA_POLICY_RANGE({policy}, {self.get_limit('min')}, {self.get_limit('max')})"
         elif 'min' in self.checks:
-            return f"NLA_POLICY_MIN({policy}, {self.checks['min']})"
+            return f"NLA_POLICY_MIN({policy}, {self.get_limit('min')})"
         elif 'max' in self.checks:
-            return f"NLA_POLICY_MAX({policy}, {self.checks['max']})"
+            return f"NLA_POLICY_MAX({policy}, {self.get_limit('max')})"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -382,7 +405,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _attr_policy(self, policy):
         mem = '{ .type = ' + policy
         if 'max-len' in self.checks:
-            mem += ', .len = ' + str(self.checks['max-len'])
+            mem += ', .len = ' + str(self.get_limit('max-len'))
         mem += ', }'
         return mem
 
@@ -431,7 +454,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def _attr_policy(self, policy):
         mem = '{ '
         if len(self.checks) == 1 and 'min-len' in self.checks:
-            mem += '.len = ' + str(self.checks['min-len'])
+            mem += '.len = ' + str(self.get_limit('min-len'))
         elif len(self.checks) == 0:
             mem += '.type = NLA_BINARY'
         else:
@@ -1982,9 +2005,9 @@ _C_KW = {
             cw.block_start(line=f'struct netlink_range_validation{sign} {c_lower(attr.enum_name)}_range =')
             members = []
             if 'min' in attr.checks:
-                members.append(('min', attr.checks['min']))
+                members.append(('min', attr.get_limit('min')))
             if 'max' in attr.checks:
-                members.append(('max', attr.checks['max']))
+                members.append(('max', attr.get_limit('max')))
             cw.write_struct_init(members)
             cw.block_end(line=';')
             cw.nl()
-- 
2.41.0


