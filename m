Return-Path: <netdev+bounces-200847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89ABAE7159
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7081BC3749
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F625B2F9;
	Tue, 24 Jun 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJRXCAUn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046A25B2E2
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799413; cv=none; b=ZALVey9wv9TUSbrFP8Xatf2e0k1Banq8nJN33uM6dB6ULIFjkjFoOnKaLzNXBFVpMrSEaRdvSSQnLyD/8hxF9uKvQPwUp1bpLT2Vtv1vz3wdOUqGNppBEEu9eFYy3j+uMSvmdpDphBAG869VwujFRmpKJ/Pq2ONZU+14xYqQr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799413; c=relaxed/simple;
	bh=6poDCkhTiyVFQ7VQzmxQXg5Wi7miDS0Xce+emIDygJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7nooN+rY1rrtL83Ax82dL0BTMXxcC1ZzVeVsOe2/jvKfPlskGt/Jp5nCKcP8skyhoJOEW499W6eIEOz4O44tz6OY3pmzLV5kSaa6aoSL3UT41ACKrU3GCH2gJi1i82dR2NScqMUKEDL/HDSm4TfFSN5y+XeQa/Xx2jC9gncgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJRXCAUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827F2C4CEEF;
	Tue, 24 Jun 2025 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799412;
	bh=6poDCkhTiyVFQ7VQzmxQXg5Wi7miDS0Xce+emIDygJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJRXCAUnjMY3rgSw/VrPXUdI77JhwHVcwpkZQZji3xKhz/Cx8yCcfuzzcZjHfRGPB
	 wQJd5sS6kikKtY7yUREMa6VAscwCpYD1jPTosAiyrMJSUpWqer5Z5Z3nX3iW6zkdBz
	 m6/GGKhHA2yT8jji6UTlTc1CyoQgXuF3BRnuxW1fJiCD8jpj0Kj3Zrohk79m+7ZP2q
	 OiSh/ZS20urYgj8wburzOeof+H7ybWUULINznqGB2wJCNMz5dTLR+WFv5ILqj+pt+1
	 UtcXgKthIJIg/kb8HQMfNQ2vD+KYrRM4/WxGNtI1olnCGHr1QSd7wKVbF6wBVbwbvE
	 438d+OOg9SplA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 10/10] netlink: specs: enforce strict naming of properties
Date: Tue, 24 Jun 2025 14:10:02 -0700
Message-ID: <20250624211002.3475021-11-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regexp to make sure all names which may end up being visible
to the user consist of lower case characters, numbers and dashes.
Underscores keep sneaking into the specs, which is not visible
in the C code but makes the Python and alike inconsistent.

Note that starting with a number is okay, as in C the full
name will include the family name.

For legacy families we can't enforce the naming in the family
name or the multicast group names, as these are part of the
binary uAPI of the kernel.

For classic netlink we need to allow capital letters in names
of struct members. TC has some structs with capitalized members.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 15 +++++++++------
 Documentation/netlink/genetlink.yaml        | 17 ++++++++++-------
 Documentation/netlink/netlink-raw.yaml      | 18 ++++++++++++------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 4cbfe666e6f5..b29d62eefa16 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -6,6 +6,9 @@ $schema: https://json-schema.org/draft-07/schema
 
 # Common defines
 $defs:
+  name:
+    type: string
+    pattern: ^[0-9a-z-]+$
   uint:
     type: integer
     minimum: 0
@@ -76,7 +79,7 @@ additionalProperties: False
       additionalProperties: False
       properties:
         name:
-          type: string
+          $ref: '#/$defs/name'
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
@@ -103,7 +106,7 @@ additionalProperties: False
                 additionalProperties: False
                 properties:
                   name:
-                    type: string
+                    $ref: '#/$defs/name'
                   value:
                     type: integer
                   doc:
@@ -132,7 +135,7 @@ additionalProperties: False
             additionalProperties: False
             properties:
               name:
-                type: string
+                $ref: '#/$defs/name'
               type:
                 description: The netlink attribute type
                 enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
@@ -169,7 +172,7 @@ additionalProperties: False
         name:
           description: |
             Name used when referring to this space in other definitions, not used outside of the spec.
-          type: string
+          $ref: '#/$defs/name'
         name-prefix:
           description: |
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
@@ -206,7 +209,7 @@ additionalProperties: False
             additionalProperties: False
             properties:
               name:
-                type: string
+                $ref: '#/$defs/name'
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
@@ -348,7 +351,7 @@ additionalProperties: False
           properties:
             name:
               description: Name of the operation, also defining its C enum value in uAPI.
-              type: string
+              $ref: '#/$defs/name'
             doc:
               description: Documentation for the command.
               type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 40efbbad76ab..7b1ec153e834 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -6,6 +6,9 @@ $schema: https://json-schema.org/draft-07/schema
 
 # Common defines
 $defs:
+  name:
+    type: string
+    pattern: ^[0-9a-z-]+$
   uint:
     type: integer
     minimum: 0
@@ -29,7 +32,7 @@ additionalProperties: False
 properties:
   name:
     description: Name of the genetlink family.
-    type: string
+    $ref: '#/$defs/name'
   doc:
     type: string
   protocol:
@@ -48,7 +51,7 @@ additionalProperties: False
       additionalProperties: False
       properties:
         name:
-          type: string
+          $ref: '#/$defs/name'
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
@@ -75,7 +78,7 @@ additionalProperties: False
                 additionalProperties: False
                 properties:
                   name:
-                    type: string
+                    $ref: '#/$defs/name'
                   value:
                     type: integer
                   doc:
@@ -96,7 +99,7 @@ additionalProperties: False
         name:
           description: |
             Name used when referring to this space in other definitions, not used outside of the spec.
-          type: string
+          $ref: '#/$defs/name'
         name-prefix:
           description: |
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
@@ -121,7 +124,7 @@ additionalProperties: False
             additionalProperties: False
             properties:
               name:
-                type: string
+                $ref: '#/$defs/name'
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
                         uint, sint, u8, u16, u32, u64, s8, s16, s32, s64,
@@ -243,7 +246,7 @@ additionalProperties: False
           properties:
             name:
               description: Name of the operation, also defining its C enum value in uAPI.
-              type: string
+              $ref: '#/$defs/name'
             doc:
               description: Documentation for the command.
               type: string
@@ -327,7 +330,7 @@ additionalProperties: False
             name:
               description: |
                 The name for the group, used to form the define and the value of the define.
-              type: string
+              $ref: '#/$defs/name'
             flags: *cmd_flags
 
   kernel-family:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index e34bf23897fa..246fa07bccf6 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -6,6 +6,12 @@ $schema: https://json-schema.org/draft-07/schema
 
 # Common defines
 $defs:
+  name:
+    type: string
+    pattern: ^[0-9a-z-]+$
+  name-cap:
+    type: string
+    pattern: ^[0-9a-zA-Z-]+$
   uint:
     type: integer
     minimum: 0
@@ -71,7 +77,7 @@ additionalProperties: False
       additionalProperties: False
       properties:
         name:
-          type: string
+          $ref: '#/$defs/name'
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
@@ -98,7 +104,7 @@ additionalProperties: False
                 additionalProperties: False
                 properties:
                   name:
-                    type: string
+                    $ref: '#/$defs/name'
                   value:
                     type: integer
                   doc:
@@ -124,7 +130,7 @@ additionalProperties: False
             additionalProperties: False
             properties:
               name:
-                type: string
+                $ref: '#/$defs/name-cap'
               type:
                 description: |
                   The netlink attribute type. Members of type 'binary' or 'pad'
@@ -183,7 +189,7 @@ additionalProperties: False
         name:
           description: |
             Name used when referring to this space in other definitions, not used outside of the spec.
-          type: string
+          $ref: '#/$defs/name'
         name-prefix:
           description: |
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
@@ -220,7 +226,7 @@ additionalProperties: False
             additionalProperties: False
             properties:
               name:
-                type: string
+                $ref: '#/$defs/name'
               type: &attr-type
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
@@ -408,7 +414,7 @@ additionalProperties: False
           properties:
             name:
               description: Name of the operation, also defining its C enum value in uAPI.
-              type: string
+              $ref: '#/$defs/name'
             doc:
               description: Documentation for the command.
               type: string
-- 
2.49.0


