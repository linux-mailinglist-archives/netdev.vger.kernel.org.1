Return-Path: <netdev+bounces-149056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774089E3ECA
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33366283386
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B020DD43;
	Wed,  4 Dec 2024 15:55:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8B20CCE4;
	Wed,  4 Dec 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327756; cv=none; b=RQsneFLl4jXarvm5LaDyEYbT7e791wgEdUuHR4uzT9Y6dCIfh2ckuEGCT//xswd7TzkBXXrecl6YfxK/x5mt3f/Y804hKroYKbjPt72kN6G5t2d3IBUzJhF2vHSpXLL/hZyx9HTKyf97SViecyuBhl3KYw2a6Jiv01WdPFKcfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327756; c=relaxed/simple;
	bh=EQgBUUYRKSPk2PBfbsTWAiyLs3qkxKXbsTnXcrs/omM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNZTDX3wNnPVTvKi9q6127ImPdOaf2k9EWn/JPz5QKlRYJrNw16z3jr60C36XR5gE7PZb/brwj1xDbN8LL6PqotjPnnquXDNTgpP7DwvjPqcTHnioVWCZxyU5lxMeWN6UlNHoQpE0n4mwCzSS6y9jIP53YJBAflSjeGIuyI5LYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so4352791a91.1;
        Wed, 04 Dec 2024 07:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733327754; x=1733932554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7eqzrrWEmnSTiC86Gkh2ilJ/81oAz2Di+fQDgLVcDY=;
        b=mN4KiLPMl/sFNL8vsf6KjRxudjDdrhJPoAubjn5pflxd32I1lXHjcMSVqQKBYX+WaG
         Lbj6GD8VrVU7n9NpL5mTXfurcJ+kcXUUZya3Xr8yzx/SbXQ9sXAH8UgZQjN0D2cIhTt0
         +K2gq01vpSYpx7uSG23IFjAqM3d4xpjL4/6v8TdJw2UK5nhX20NB6U53D/UE00nvdwg8
         6jVjGNcEkF0T000JYOytH5727QxLBjBzdhKd6g3lsXb8/aKtPuuK3V3khOxhQtfB/t5x
         t3tcHV+B+p2nIFoI8I/tVWGr2x6zICIfGfg67u7bmWcv6RGQS6+0iRyE5oAEB18PJwy5
         Wexg==
X-Forwarded-Encrypted: i=1; AJvYcCU4hKGKASY6tmL4klfCBDmmNgjo/amjIPszCKYmJxGoz21TpVOGWX1DWamQq4lVvcilAg9U8E0Cl+c=@vger.kernel.org, AJvYcCX1b5aYTtynwPh/XadLXZP6KZP5wm2MdziLACLc+ZmfybziaILm9JIJ/lCUGCV8O9nGf3okGYfrmEfXFzge@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad0IIqu2Ta172xv/6vose6KtWVzJrj4nt16khjNX42cqKXoE6
	/DGK7gbsh/Co5AVHFIkSNefvraGDx3zJIVGNHbwLUJhGRNiYtMQu30Gff4U=
X-Gm-Gg: ASbGncsA04cIVIjh8Y7506aqsybumiS48hRbTQxsB6EBiRewOnz8PHoZ4GpPARnrAu9
	Zc9GsneCiWN84dLbCGeUrP1x5obmzkrAIUg7NXTcI6rizXyj/Afr3jInZ6Z39JYRa4jZsbzftFq
	Zf4LpBg0l01AlE63zw25vgUs7iMAyN88ohKVxqRJj6PHn1wzrQIV7VFKdMXbjliye2bYwW6arZo
	Fn3tL9e8i3TYI4o2I7ALPRuN/d3tUH5DHsEiSyVxUH4xiYs+A==
X-Google-Smtp-Source: AGHT+IH6Z1LVGnuoi+lG90dZGXyR5obrpvw1MUE7qlowV2WNabElG+RzE+zagvDxczkiYmzFlnvTQQ==
X-Received: by 2002:a17:90b:46:b0:2ee:c9dd:b7ea with SMTP id 98e67ed59e1d1-2ef0124f700mr9411547a91.24.1733327754211;
        Wed, 04 Dec 2024 07:55:54 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701df84sm1570692a91.29.2024.12.04.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:55:53 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v4 3/8] ynl: support directional specs in ynl-gen-c.py
Date: Wed,  4 Dec 2024 07:55:44 -0800
Message-ID: <20241204155549.641348-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204155549.641348-1-sdf@fomichev.me>
References: <20241204155549.641348-1-sdf@fomichev.me>
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
index 79829ce39139..2bf4d992e54a 100755
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
     hdr_prot = hdr_prot.replace('/', '_')
@@ -2523,30 +2604,12 @@ _C_KW = {
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
+        raise Exception(f'Unsupported message enum-model {family.msg_id_model}')
 
     if separate_ntf:
         uapi_enum_start(family, cw, family['operations'], enum_name='async-enum')
@@ -2670,13 +2733,6 @@ _C_KW = {
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


