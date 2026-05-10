Return-Path: <netdev+bounces-286391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLBQEvjcAGoZNwEAu9opvQ
	(envelope-from <netdev+bounces-286391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BC505FE9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF81F302F385
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CD3346A8;
	Sun, 10 May 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXpczE7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B002E3164BA;
	Sun, 10 May 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441352; cv=none; b=YooEUZFPRqBxVG8eKl7MzyKioeTcKSV+QZgc2mAK6BLeLh4fEyEm+66/6DuefOJB4OBq/AmJLVuSCF3CjfhtyJkXXPq2mp4TvLgGGBks3gMMA9GE82zn9S8C5k2wj1cT9xRa4syUaOTCEgOnv4bj0nujGZrBXmxgP3DFvGwoAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441352; c=relaxed/simple;
	bh=denafGZs684YNILiajoHJYhj7gvIGuG4BdoLhdY7GMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRB6TGr6j509K3kHCweyFga5TPGgrKr9p8qxAR0nZ9u/R13DgMoqkj2GiJydGpuaV6tcdWBbp/mjTJlb4gUXw5ZX28kfY8ZNiN+OealNIkFNPUjlbQGbrodVVxCrau2m+cOi0iVVITFxYhGSF0W7UIx7flJDJmFGT31Sa4SmoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXpczE7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3CDC2BCFB;
	Sun, 10 May 2026 19:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441352;
	bh=denafGZs684YNILiajoHJYhj7gvIGuG4BdoLhdY7GMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXpczE7x0UPhVi8o0rrVatkj1lodoAYsbVpu+PBwGsNKsKwsY2Mi6uSRfHaOSS1bD
	 hZjhLz9B2OURtc5YlJkAKOeoki/rOAhVVhKrBgypzYQ97wofPRuJIFfiYuo83cMaZD
	 xmJ4Gb8qWyC/DANMs0HySUNEuarQ2lvAzXfj3kMeOgVsw3h45ZKRSlYGOeBU1g2tPR
	 0XOoEylHetEXTs2RF4zR6y6FTGzpsbQR7406HqDac4Ae+gh9pXOLBgqrf/ERTCBk7w
	 9nG7Fp6zO+dKNr0v9c4fSd2LHAUZ9k+1BLPufxzyZRZRHmIiMfbXQpb/WXTNfoN5M3
	 SwDvWN3GZ50lw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net
Subject: [PATCH net v2 07/10] tools: ynl: add scope qualifier for definitions
Date: Sun, 10 May 2026 12:29:01 -0700
Message-ID: <20260510192904.3987113-8-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 092BC505FE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fiberby.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286391-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Using definitions in kernel policies is awkward right now.
On one hand we want defines for max values and such.
On the other we don't have a way of adding kernel-only defines.
Adding unnecessary defines to uAPI is a bad idea, we won't
be able to delete them. And when it comes to policy user
space should just query it via the policy dump, not use
hard coded defines.

Add a "scope" property to definitions, which will let us tell
the codegen that a definition is for kernel use only. Support
following values:
  - uapi: render into the uAPI header (default, today's behavior)
  - kernel: render to kernel header only
  - user: same as kernel but for the user-side generated header

Definitions may have a header property (definition is "external",
provided by existing header). Extend the scope to headers, too.
If definition has both scope and header properties we will only
generate the includes in the right scope.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
This will fail yamllint, sticking to the same format as the rest
of the file (extra spaces inside brackets).

CC: donald.hunter@gmail.com
CC: ast@fiberby.net
---
 Documentation/netlink/genetlink-c.yaml      |  9 ++++++
 Documentation/netlink/genetlink-legacy.yaml |  9 ++++++
 Documentation/netlink/genetlink.yaml        |  9 ++++++
 Documentation/netlink/netlink-raw.yaml      |  9 ++++++
 tools/net/ynl/pyynl/ynl_gen_c.py            | 31 +++++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 57f59fe23e3f..4ea31e8fc4d1 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -69,6 +69,15 @@ additionalProperties: False
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 66fb8653a344..f9c44747729a 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -83,6 +83,15 @@ additionalProperties: False
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index a1194d5d93fc..d3f3f3399ddf 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -55,6 +55,15 @@ additionalProperties: False
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index dd98dda55bd0..4c436b59a34b 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -87,6 +87,15 @@ additionalProperties: False
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0e1e486c1185..cdc3646f2642 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3212,6 +3212,8 @@ _C_KW = {
     for const in family['definitions']:
         if const.get('header'):
             continue
+        if const.get('scope', 'uapi') != 'uapi':
+            continue
 
         if const['type'] != 'const':
             cw.writes_defines(defines)
@@ -3339,6 +3341,25 @@ _C_KW = {
     cw.p(f'#endif /* {hdr_prot} */')
 
 
+def render_scoped_consts(family, cw, scope):
+    defines = []
+    for const in family['definitions']:
+        if const['type'] != 'const':
+            continue
+        if const.get('header'):
+            continue
+        if const.get('scope') != scope:
+            continue
+        name_pfx = const.get('name-prefix', f"{family.ident_name}-")
+        defines.append([
+            c_upper(family.get('c-define-name',
+                               f"{name_pfx}{const['name']}")),
+            const['value']])
+    if defines:
+        cw.writes_defines(defines)
+        cw.nl()
+
+
 def _render_user_ntf_entry(ri, op):
     if not ri.family.is_classic():
         ri.cw.block_start(line=f"[{op.enum_name}] = ")
@@ -3504,8 +3525,12 @@ _C_KW = {
             cw.p('#include "ynl.h"')
         headers = []
     for definition in parsed['definitions'] + parsed['attribute-sets']:
-        if 'header' in definition:
-            headers.append(definition['header'])
+        if 'header' not in definition:
+            continue
+        scope = definition.get('scope', 'uapi')
+        if scope != 'uapi' and scope != args.mode:
+            continue
+        headers.append(definition['header'])
     if args.mode == 'user':
         headers.append(parsed.uapi_header)
     seen_header = []
@@ -3522,6 +3547,7 @@ _C_KW = {
             for one in args.user_header:
                 cw.p(f'#include "{one}"')
         else:
+            render_scoped_consts(parsed, cw, 'user')
             cw.p('struct ynl_sock;')
             cw.nl()
             render_user_family(parsed, cw, True)
@@ -3529,6 +3555,7 @@ _C_KW = {
 
     if args.mode == "kernel":
         if args.header:
+            render_scoped_consts(parsed, cw, 'kernel')
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
                     cw.p('/* Common nested types */')
-- 
2.54.0


