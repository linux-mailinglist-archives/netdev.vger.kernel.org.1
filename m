Return-Path: <netdev+bounces-148151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DDE9E0C23
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD63DB65D1F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5BA1D9337;
	Mon,  2 Dec 2024 16:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1311AB51F;
	Mon,  2 Dec 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156984; cv=none; b=c6raU+AxHOJnEXRH+0lJUPCx68imwMcQ0HzcFbPStEPEStRZv7A+v4LCnH5qFOfLzCPKd9yoceVy8w2YSyv1aJVbxHS/RxNA2Bg+YOTUyhDTM5lSo8NVApgR1eyxLhe4AIwF5z+7LobIPBggeqgZrGr3IExrdt7mQi/aiFUWu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156984; c=relaxed/simple;
	bh=EQgBUUYRKSPk2PBfbsTWAiyLs3qkxKXbsTnXcrs/omM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9+6JiNtW7i/+pPm7zXtqm0VV+Y0V1dvq2P6DM8v25M1EfuJcb2m3CkxmMVdhb+MSy9BwSlwHOOA9mCuJZWCRhGfQ8+5wGRmY4NcY1/64kvtJ2m5MeHsVlnNVe1VKG/6Xb5h98R6C0KrSZLKz6Nnq9XRKth44YYgYHo2uvn6PUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215936688aeso11824545ad.1;
        Mon, 02 Dec 2024 08:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156982; x=1733761782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7eqzrrWEmnSTiC86Gkh2ilJ/81oAz2Di+fQDgLVcDY=;
        b=ITgLDRzKihOPRyNftKAdO0C1Do9vPoHTbUWeQaH11xEBkmWSvNMglG9YSlmFzX+0+U
         d+im4bqlWmTPldVxHvUtefk5+rMpC4Bx7/+FCN8slf+OWzR3mUoX20n/Ww7Xr/IEF7U8
         5xL1U2nN6HwL7ty4n+fUD0V+eGvQTPOd/FKhba60XBjYHNgOrlIP/obO9HTa1KAkWFTh
         Lnd8eTKtnLLvxl44T0J5f//f0Zfpyy0aCGIjo/jaoBSBR/mmcujSKwe1yFiWhGcQSpPa
         LWjAyE8+psjinFDR3qO49DBcP7KPucsJQN8z9M3F95UD/3VNvpPQh+Ox1Qw8uNmIcBwT
         B9gw==
X-Forwarded-Encrypted: i=1; AJvYcCULEtmA/K1437vm/gOgNIXWz1UogEXxk70myuat2rDBFEgAOqCj1CezSZ810icG+0q0wn6DLVOUC7M=@vger.kernel.org, AJvYcCVSa379cqw+MDLpn5zU3KFmr5IccRqH9bYL6FkTc6EQodGTHp6fT+O35C2lReymKGbSRvxNfF7ddEYTqgI+@vger.kernel.org
X-Gm-Message-State: AOJu0YzaIYOzAMTTlNz7MiZVApWRnqMnECkfmVu90YDZUP1eVIkbqkd9
	uEk9uugFW4Mo0Mr6wmV5j1jEH/GQw24n0QCDb8A4nHHP2mdLWm8hDeRhl40=
X-Gm-Gg: ASbGncs8H4tSxP0LxWOHaDKWPN8SkygIu/Kz5i30Xu9vDu13cgpnS6YNu9S7B03LemP
	WYHUHvawfwAp0SRcI5MDwSzk9VY3JlwrP8PaGV6CzTHnPZF0QQpTwMQIbITvbOGLEaKiDR6t4rh
	YvmE22nk4g4uwuGL3k1H8hELPe7UmEAyfKm6CQ6SnqsCuZlUCIeQamAyPXeiklU5Ghb4Kvq1Vlz
	WgFInPIyIYOGt4yVD0hxyCVFtHxqKe43ll0yAmr0/hXp2g8yw==
X-Google-Smtp-Source: AGHT+IGzLxRl+zfOTMAMkPlQdAHPmFWEM7TqV3RXuESWZOKLExg+oCg4oMxfgwpZNen0TyMtcWN4Jw==
X-Received: by 2002:a17:903:4407:b0:215:6e28:8249 with SMTP id d9443c01a7336-2156e2885fcmr119769495ad.45.1733156981580;
        Mon, 02 Dec 2024 08:29:41 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541761316sm8724968b3a.18.2024.12.02.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:41 -0800 (PST)
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
Subject: [PATCH net-next v3 3/8] ynl: support directional specs in ynl-gen-c.py
Date: Mon,  2 Dec 2024 08:29:31 -0800
Message-ID: <20241202162936.3778016-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
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


