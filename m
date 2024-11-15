Return-Path: <netdev+bounces-145377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B59CF4FE
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FDA1F21215
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17311E32B0;
	Fri, 15 Nov 2024 19:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71151E231D;
	Fri, 15 Nov 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699414; cv=none; b=llwYPUrZhbMxdvMXkdGfFySlVMARjTD5SESOrmoC62UR8JMnqa5edm+Rf1R8ZVnJjxlY3k96FucdhMzuWbYj09iDKRjkPuJ5yWvpjj68OQ+pfvVmAFyFA/yKjzpAHpiw0RavwFhNjK2sjRRmxFOJOJ9js9HMJJC/6bhi8GoWXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699414; c=relaxed/simple;
	bh=YOg3gjQeCmu3PGtzkKN/uoxNDEFbfr1TI3Lssf5OECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHw+BlgSHNovDb/IQ8VWEG7T8C+0x1Om1n/1nLQI1O/j7knLCC81ZkTwtO8h05H1cEsJ9hgl+Tw/GyVpRCSrg2wZTa/zDHzRb5RAUE6qwaSRPUTEfo3emDVbcz+qEjvATyKlcqmEYd6bCaae0xdoXveRoX2Dhv8il/KCjlXgktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cb7139d9dso23723055ad.1;
        Fri, 15 Nov 2024 11:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699412; x=1732304212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xd49IMPW8HB/K3Il5x15g7iaHPzUwpcdvWbm5eV+/NI=;
        b=kWpWbdAH8faLz1m6Oe3PEkWn5VWZGDjilFkYxn9Oc6/v2O3DzEsyldNJLOV+C8DYeK
         OW6jtQktaNsLJH2vYVQdEZpX1WCclHBsRB3C9OWZZ/EkwCl3zspvq1X6V14xBKHVi1x1
         T5fqmbmlmeSfEiWEdPXRV4kt1JtguelUQL1SuMzy5PfGZmgzUslklnttMmsgwkIMi5g+
         tUo+qtv9v8mpqlyItBQplsB8MQ3DQBYUY7kMd+EnYuaQA5Hx3A5jFe0pvJEVQOfA3PQL
         lzvPZd5caOmaJwXxPI8wFhzCfCZEZblOkHnzUHo1tAofPFSvZsui7VR4Myn9/fFAS86v
         fVxA==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZSzYUvLaTOMovGkLQl3NQGtrSGH2BpLu9dGI3mc07sFI0Blq0OR2U2s47B6FRpV7QLybuUHmXyI=@vger.kernel.org, AJvYcCWi5YdGbC5dP66n0vKG2qq96j0zUbbcRg4uVuZaxcInF5TbqXujb8sBx8YYAa8r3AtaiBsSj/vzZjaCsSGp@vger.kernel.org
X-Gm-Message-State: AOJu0YwM6uCDmEjZgrQvg0OmyDz7/DfDO+cXmNCkec/u/u5zcRubNeSR
	j7vcnsX/hAMElVw5dqHY+/zAThWXHdO1lKPHEKRI+qioL3qPeYCTbdqD0H0=
X-Google-Smtp-Source: AGHT+IF13fZsqQYvQ0+oMWRWXuGibAGGMQBftQqFf0Hi8uMzS6MG/5fsY8Rq3AL32AmKSnaQSvFJZg==
X-Received: by 2002:a17:902:d48c:b0:20c:94f6:3e03 with SMTP id d9443c01a7336-211d0ed2e36mr56282275ad.47.1731699411591;
        Fri, 15 Nov 2024 11:36:51 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ecc6a4sm16148095ad.94.2024.11.15.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:51 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net-next v2 3/8] ynl: support directional specs in ynl-gen-c.py
Date: Fri, 15 Nov 2024 11:36:41 -0800
Message-ID: <20241115193646.1340825-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115193646.1340825-1-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
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
 tools/net/ynl/ynl-gen-c.py | 118 +++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 31 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 8ba252973c2d..e5ac6f89b78a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2419,6 +2419,87 @@ _C_KW = {
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
@@ -2522,30 +2603,12 @@ _C_KW = {
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
+    elif family.msg_id_model == 'directional':
+        render_uapi_directional(family, cw, max_by_define)
+    else:
+        raise Exception(f'Unsupported enum-model {family.msg_id_model}')
 
     if separate_ntf:
         uapi_enum_start(family, cw, family['operations'], enum_name='async-enum')
@@ -2669,13 +2732,6 @@ _C_KW = {
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


