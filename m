Return-Path: <netdev+bounces-144526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE939C7AE9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E24B24CE5
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BF520606E;
	Wed, 13 Nov 2024 18:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7E204031;
	Wed, 13 Nov 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521431; cv=none; b=OxwkElsyroxT1eGJMZ0CaYbYRLfnhtPq/h+bwHhS88hgLfqu/jplEhEv0ZcL9Wq9FXLvARrFmsXo3ncKeiwbui8+gJ0QOMcVtC5t+rLHviOjgejEHdqcGBs0rtRKHHIrYpy6e6EjPM0Vfs66hEugZ6d9ggHmxhMwKw2ZP3gDZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521431; c=relaxed/simple;
	bh=+mp51APSxeIjSHk8BSEux8PFs5Dyl9nBrnTUBx8ZluI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ0Q3cLhf6KiQSL0SosICWPx7xEs2eG+uHS4oF9tM0JQFFkejSj1Q8HRlzuqBNABWOxBsgh0Pp6pk+Z66ewO3pRDZHAjOF/v5rtOaaySK2hYzsYS//X4aU627NaaMDZ/rlQsUMx0Qa2RbYv63ik79fGXt0CNLJsv/xzvYU0H0z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdda5cfb6so71513045ad.3;
        Wed, 13 Nov 2024 10:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521429; x=1732126229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW71MqyqgGdLksoWGi8UypcDBGzGIYR2TGspCJ72+D8=;
        b=VFDb6ZagDMkKsVxqtINeDOVXJL2IcrngOW7LFi5Jbmmn7uU7eRRYNk+w4wpJSo1Wok
         rGCaao4ntz27GP7Yt6ijtF8loy6sgMwlWAsVyDd0ZCbOtl1SxRp0TjshTACTwZPyoqrO
         fvk2VcN7WC5bi6Jl85PQhkuvhVXLfiz5djZNcVyJVCRRoHLJzpFpjJtoFg9YDuAudqID
         I9kgtWzwhK7EuX8O0bWuQOEOqqjj2g/04X9QCOMjc9ZnJGYAVYqk+uJvSnKR0TnEKDrR
         +zB3H1caF60x8aEYZ+ZVDFxTKq+ZjJ70UMVB9G4BVORDlGRyBvi6edBxi16NQOM9PI3W
         kANg==
X-Forwarded-Encrypted: i=1; AJvYcCU8EksfhStEhPr2Mdwj6zzJUuhzEwScKTubGR3DL+kwp6MXG4ffIpApeeHE1vxCnfMRfYfF2uVZJGp+rec=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWPyAFTTZbWl90z4r/AUplBRwkYCqwJ8j8Px0W8p9Umonr4vL
	67s+QK8gOThY4niKxevsOxLIbg3RF6TZmk+QLqlnHIZ9qYZbJtxwpH59ZTY=
X-Google-Smtp-Source: AGHT+IEBHjfKKAziukMfIsrC2ZqChO69l9c+de+6SMCI6CZrnq7JMSJwtdNyEjlXCSuapI9iby3gBg==
X-Received: by 2002:a17:903:41ce:b0:20b:c287:202d with SMTP id d9443c01a7336-211b66b1026mr32751055ad.55.1731521428866;
        Wed, 13 Nov 2024 10:10:28 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde26dsm112783115ad.71.2024.11.13.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:28 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 3/7] ynl: support directional specs in ynl-gen-c.py
Date: Wed, 13 Nov 2024 10:10:19 -0800
Message-ID: <20241113181023.2030098-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113181023.2030098-1-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent is to generate ethtool uapi headers. For now, some of the
things are hard-coded:
- <FAMILY>_MSG_{USER,KERNEL}_MAX
- the split between USER and KERNEL messages

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/ynl-gen-c.py | 116 +++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 0de918c7f18d..a7b7aea1159b 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2416,6 +2416,87 @@ _C_KW = {
     cw.block_start(line=start_line)
 
 
+def render_uapi_unified(family, cw, max_by_define, separate_ntf):
+    max_name = c_upper(family.get('cmd-max-name', f"{family.op_prefix}MAX"))
+    cnt_name = c_upper(family.get('cmd-cnt-name', f"__{family.op_prefix}MAX"))
+    max_value = f"({cnt_name} - 1)"
+
+    uapi_enum_start(family, cw, family['operations'], 'enum-name')
+    val = 0
+    for op in family.msgs.values():
+        if separate_ntf and ('notify' in op or 'event' in op):
+            continue
+
+        suffix = ','
+        if op.value != val:
+            suffix = f" = {op.value},"
+            val = op.value
+        cw.p(op.enum_name + suffix)
+        val += 1
+    cw.nl()
+    cw.p(cnt_name + ('' if max_by_define else ','))
+    if not max_by_define:
+        cw.p(f"{max_name} = {max_value}")
+    cw.block_end(line=';')
+    if max_by_define:
+        cw.p(f"#define {max_name} {max_value}")
+    cw.nl()
+
+
+def render_uapi_directional(family, cw, max_by_define):
+    max_name = f"{family.op_prefix}USER_MAX"
+    cnt_name = f"__{family.op_prefix}USER_CNT"
+    max_value = f"({cnt_name} - 1)"
+
+    cw.block_start(line='enum')
+    cw.p(c_upper(f'{family.name}_MSG_USER_NONE = 0,'))
+    val = 0
+    for op in family.msgs.values():
+        if 'do' in op and 'event' not in op:
+            suffix = ','
+            if op.value and op.value != val:
+                suffix = f" = {op.value},"
+                val = op.value
+            cw.p(op.enum_name + suffix)
+            val += 1
+    cw.nl()
+    cw.p(cnt_name + ('' if max_by_define else ','))
+    if not max_by_define:
+        cw.p(f"{max_name} = {max_value}")
+    cw.block_end(line=';')
+    if max_by_define:
+        cw.p(f"#define {max_name} {max_value}")
+    cw.nl()
+
+    max_name = f"{family.op_prefix}KERNEL_MAX"
+    cnt_name = f"__{family.op_prefix}KERNEL_CNT"
+    max_value = f"({cnt_name} - 1)"
+
+    cw.block_start(line='enum')
+    cw.p(c_upper(f'{family.name}_MSG_KERNEL_NONE = 0,'))
+    val = 0
+    for op in family.msgs.values():
+        if ('do' in op and 'reply' in op['do']) or 'notify' in op or 'event' in op:
+            enum_name = op.enum_name
+            if 'event' not in op and 'notify' not in op:
+                enum_name = f'{enum_name}_REPLY'
+
+            suffix = ','
+            if op.value and op.value != val:
+                suffix = f" = {op.value},"
+                val = op.value
+            cw.p(enum_name + suffix)
+            val += 1
+    cw.nl()
+    cw.p(cnt_name + ('' if max_by_define else ','))
+    if not max_by_define:
+        cw.p(f"{max_name} = {max_value}")
+    cw.block_end(line=';')
+    if max_by_define:
+        cw.p(f"#define {max_name} {max_value}")
+    cw.nl()
+
+
 def render_uapi(family, cw):
     hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
     cw.p('#ifndef ' + hdr_prot)
@@ -2519,30 +2600,10 @@ _C_KW = {
     # Commands
     separate_ntf = 'async-prefix' in family['operations']
 
-    max_name = c_upper(family.get('cmd-max-name', f"{family.op_prefix}MAX"))
-    cnt_name = c_upper(family.get('cmd-cnt-name', f"__{family.op_prefix}MAX"))
-    max_value = f"({cnt_name} - 1)"
-
-    uapi_enum_start(family, cw, family['operations'], 'enum-name')
-    val = 0
-    for op in family.msgs.values():
-        if separate_ntf and ('notify' in op or 'event' in op):
-            continue
-
-        suffix = ','
-        if op.value != val:
-            suffix = f" = {op.value},"
-            val = op.value
-        cw.p(op.enum_name + suffix)
-        val += 1
-    cw.nl()
-    cw.p(cnt_name + ('' if max_by_define else ','))
-    if not max_by_define:
-        cw.p(f"{max_name} = {max_value}")
-    cw.block_end(line=';')
-    if max_by_define:
-        cw.p(f"#define {max_name} {max_value}")
-    cw.nl()
+    if family.msg_id_model == 'unified':
+        render_uapi_unified(family, cw, max_by_define, separate_ntf)
+    else:
+        render_uapi_directional(family, cw, max_by_define)
 
     if separate_ntf:
         uapi_enum_start(family, cw, family['operations'], enum_name='async-enum')
@@ -2666,13 +2727,6 @@ _C_KW = {
         os.sys.exit(1)
         return
 
-    supported_models = ['unified']
-    if args.mode in ['user', 'kernel']:
-        supported_models += ['directional']
-    if parsed.msg_id_model not in supported_models:
-        print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
-        os.sys.exit(1)
-
     cw = CodeWriter(BaseNlLib(), args.out_file, overwrite=(not args.cmp_out))
 
     _, spec_kernel = find_kernel_root(args.spec)
-- 
2.47.0


