Return-Path: <netdev+bounces-247706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F850CFD9F2
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C616C300D838
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78E314D2A;
	Wed,  7 Jan 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9dyqXpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F077315D2A
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788541; cv=none; b=dExV14qvlUq9WfZLRYazplnzaMjsQtPR3tZ+xr4P0QEnB0Tkdks28cVqi5qYXz5Y81SDkWlJgnd5vPQce1TsIHPMNHZLOLwtqZZHDJDmm2Uo7mDXYH1n+hpXVSed3zLH09rURlIYbBgrrvnG//bp303kmcS6gKF7lxXU15VFcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788541; c=relaxed/simple;
	bh=gZtQXWYl86QcRVxJrWdGNxS17N7jTxg6qD9PlenxVkc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty6J26wirlQdqbwYofc16+XFz055GA62ypztnGaQ06+1CoEeZa4SiqiiY5iu3wEmCo+4YO82x2ynB6s8CUkovk2vR06pUcLm5re/NQR1nj8KHnEaV9y4k1gqh8FGi627wQhGxURWpmbh29t+WxyU0VYfl57OYOg1UrqIUAEu0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9dyqXpn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-431048c4068so470674f8f.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788537; x=1768393337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXJRDY1LT2kYrctjUr0o0V8a6dmySfNZXgbe2pBlHk4=;
        b=d9dyqXpnrMDZ4iOjY2fUm8kLQK3tXuZ4WyHYyW5gt6xD1Q/9I2vCktiPHCuliEiwU4
         1bTVtQ01wa8tN4Hkas5dICxHGFhKRsaujlKBgJnMN6bxlPNSsMp2wJx5YKASa0SXOW4E
         E+ljnHjhz76TH+cPMhLkPNTgFmliStrPhelP6t4hTsGoiqHm/8TyKiG/GbBroxkG1W+y
         zPlWRE9ZG7ZDWF7IvH+V2GKOUF3bPVEkQSj9SW9g5UuROczZrzV1s2UNECDgBQk0SgUx
         MuKIWm1KzNI5I95Q2a8dEBLCYtrdKQWVc9VcayiwIouDwQ1YGSdMNoiRF2GwhjMFkJDD
         YD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788537; x=1768393337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dXJRDY1LT2kYrctjUr0o0V8a6dmySfNZXgbe2pBlHk4=;
        b=UFE91251D8WiKNpIsG1oqEvIU9Pmmaubdo8HTDTaPgV71Bfv6ueU3Vx9yqNpOcCTv+
         WWqneCwZ8NZ5japrY+SuDni2DWQKCqlRVh5/mKImyx2W/407FSGrefe74X0Py6Es26+k
         XqEgoIvkG7wI+B8VHgBQX/SfU49BbqWQNv8FN3ix30NIgXBFoFqity8pkJFYd1wl4a15
         rMvU54ynLeGLS14UqdiW6dX+K8qAg4PMF3e1CgzMYcujKN7yWVA/A/OV2ya078VKUkZT
         SwPYpgdtaj9A69ddpgwvjzH0WjfiMEd9ZTITs1l0euTLHORXO2SRZwAlFt20qNNQSO+C
         VXYw==
X-Forwarded-Encrypted: i=1; AJvYcCVWu39XMlwoSPxi944+ZJ302zfL300Qgoi+1lnvaczQfHH1eoknxnvKsN2hVqqNK4Eq2uATVqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2LWFggZwYS6St0Ujf7f96Itp+9SwpLefmN3rcfQ1qAp8McOA
	LnabvKHIGVOc5Cwtqv2WfImqmxA9SPzZosy4Me3q0id3+cQN/CHIjdWf
X-Gm-Gg: AY/fxX5QY5mKHZXvQ3RAdpjAgd+/2CCCcYgk1mGF+uhf9PYHxRYPrG6zqCoX0/KLWsD
	o87QlEHwdR+ftnBjMAPbtRMcFmgBE59/m5eHKprCDTUjDsFaBdRCL/m6Nr2+rt+JRJFr4FS3Xjq
	9kuwKRxUf0hIKbOFKB/UziSewaeCbBGH4lphKMgMKfoQBnJCe3or8t0GYVosFNT9k+2wEoMkMnq
	K3HWKAYtitMnGa+z0Tuf8KcM3zhiOE/tSsNJJKBkoTn4Wm6glhLZAjvAJtcLXQFISgTl9Uv733l
	hpTMaolxixwuyfWhqYqpcI2aT3GzZpChTU6LjmcOgPckzAEa5q4mH82FlF++BZaXpmgN4rOx++Z
	AQVD2sNpIbD9a3qBeVy/T/E+uuC+SG+n80PZp7BxSLcpCXus7mcYPyOLQkAVGAqNFAXAsFUoo1F
	DWg74/H0efrCnYBt80a7+QcyIqOP6Y
X-Google-Smtp-Source: AGHT+IG2kMp1SA3ATP0mPWv13r0oC2vuFZ7XStVJ6P61VurlzVMqeNH/gAgJZbrmhg5L/Hd7l6saQw==
X-Received: by 2002:a05:6000:3106:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-432c362bf54mr3192485f8f.3.1767788537099;
        Wed, 07 Jan 2026 04:22:17 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:16 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 12/13] tools: ynl-gen-c: fix pylint None, type, dict, generators, init
Date: Wed,  7 Jan 2026 12:21:42 +0000
Message-ID: <20260107122143.93810-13-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following pylint warnings that are trivial one-liners:

- unsubscriptable-object
- unidiomatic-typecheck
- use-dict-literal
- attribute-defined-outside-init
- consider-using-in
- consider-using-generator

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 49 ++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 900896779e61..5f079a74c8d1 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -200,7 +200,7 @@ class Type(SpecAttr):
     # pylint: disable=assignment-from-none
     def arg_member(self, ri):
         member = self._complex_member_type(ri)
-        if member:
+        if member is not None:
             spc = ' ' if member[-1] != '*' else ''
             arg = [member + spc + '*' + self.c_name]
             if self.presence_type() == 'count':
@@ -210,7 +210,7 @@ class Type(SpecAttr):
 
     def struct_member(self, ri):
         member = self._complex_member_type(ri)
-        if member:
+        if member is not None:
             ptr = '*' if self.is_multi_val() else ''
             if self.is_recursive_for_op(ri):
                 ptr = '*'
@@ -258,9 +258,9 @@ class Type(SpecAttr):
 
     def attr_get(self, ri, var, first):
         lines, init_lines, _ = self._attr_get(ri, var)
-        if type(lines) is str:
+        if isinstance(lines, str):
             lines = [lines]
-        if type(init_lines) is str:
+        if isinstance(init_lines, str):
             init_lines = [init_lines]
 
         kw = 'if' if first else 'else if'
@@ -1002,7 +1002,7 @@ class Struct:
         self.in_multi_val = False  # used by a MultiAttr or and legacy arrays
 
         self.attr_list = []
-        self.attrs = dict()
+        self.attrs = {}
         if type_list is not None:
             for t in type_list:
                 self.attr_list.append((t, self.attr_set[t]),)
@@ -1094,8 +1094,8 @@ class EnumSet(SpecEnumSet):
         return EnumEntry(self, entry, prev_entry, value_start)
 
     def value_range(self):
-        low = min([x.value for x in self.entries.values()])
-        high = max([x.value for x in self.entries.values()])
+        low = min(x.value for x in self.entries.values())
+        high = max(x.value for x in self.entries.values())
 
         if high - low + 1 != len(self.entries):
             return None, None
@@ -1234,6 +1234,12 @@ class Family(SpecFamily):
         self.hooks = None
         delattr(self, "hooks")
 
+        self.root_sets = {}
+        self.pure_nested_structs = {}
+        self.kernel_policy = None
+        self.global_policy = None
+        self.global_policy_set = None
+
         super().__init__(file_name, exclude_ops=exclude_ops)
 
         self.fam_key = c_upper(self.yaml.get('c-family-name', self.yaml["name"] + '_FAMILY_NAME'))
@@ -1268,18 +1274,18 @@ class Family(SpecFamily):
 
         self.mcgrps = self.yaml.get('mcast-groups', {'list': []})
 
-        self.hooks = dict()
+        self.hooks = {}
         for when in ['pre', 'post']:
-            self.hooks[when] = dict()
+            self.hooks[when] = {}
             for op_mode in ['do', 'dump']:
-                self.hooks[when][op_mode] = dict()
+                self.hooks[when][op_mode] = {}
                 self.hooks[when][op_mode]['set'] = set()
                 self.hooks[when][op_mode]['list'] = []
 
         # dict space-name -> 'request': set(attrs), 'reply': set(attrs)
-        self.root_sets = dict()
+        self.root_sets = {}
         # dict space-name -> Struct
-        self.pure_nested_structs = dict()
+        self.pure_nested_structs = {}
 
         self._mark_notify()
         self._mock_up_events()
@@ -1627,7 +1633,7 @@ class RenderInfo:
 
         self.cw = cw
 
-        self.struct = dict()
+        self.struct = {}
         if op_mode == 'notify':
             op_mode = 'do' if 'do' in op else 'dump'
         for op_dir in ['request', 'reply']:
@@ -1794,7 +1800,7 @@ class CodeWriter:
         if not local_vars:
             return
 
-        if type(local_vars) is str:
+        if isinstance(local_vars, str):
             local_vars = [local_vars]
 
         local_vars.sort(key=len, reverse=True)
@@ -1814,20 +1820,19 @@ class CodeWriter:
     def writes_defines(self, defines):
         longest = 0
         for define in defines:
-            if len(define[0]) > longest:
-                longest = len(define[0])
+            longest = max(len(define[0]), longest)
         longest = ((longest + 8) // 8) * 8
         for define in defines:
             line = '#define ' + define[0]
             line += '\t' * ((longest - len(define[0]) + 7) // 8)
-            if type(define[1]) is int:
+            if isinstance(define[1], int):
                 line += str(define[1])
-            elif type(define[1]) is str:
+            elif isinstance(define[1], str):
                 line += '"' + define[1] + '"'
             self.p(line)
 
     def write_struct_init(self, members):
-        longest = max([len(x[0]) for x in members])
+        longest = max(len(x[0]) for x in members)
         longest += 1  # because we prepend a .
         longest = ((longest + 8) // 8) * 8
         for one in members:
@@ -2670,7 +2675,7 @@ def print_req_free(ri):
 
 
 def print_rsp_type(ri):
-    if (ri.op_mode == 'do' or ri.op_mode == 'dump') and 'reply' in ri.op[ri.op_mode]:
+    if ri.op_mode in ('do', 'dump') and 'reply' in ri.op[ri.op_mode]:
         direction = 'reply'
     elif ri.op_mode == 'event':
         direction = 'reply'
@@ -2683,7 +2688,7 @@ def print_wrapped_type(ri):
     ri.cw.block_start(line=f"{type_name(ri, 'reply')}")
     if ri.op_mode == 'dump':
         ri.cw.p(f"{type_name(ri, 'reply')} *next;")
-    elif ri.op_mode == 'notify' or ri.op_mode == 'event':
+    elif ri.op_mode in ('notify', 'event'):
         ri.cw.p('__u16 family;')
         ri.cw.p('__u8 cmd;')
         ri.cw.p('struct ynl_ntf_base_type *next;')
@@ -2946,7 +2951,7 @@ def print_kernel_op_table_hdr(family, cw):
 
 def print_kernel_op_table(family, cw):
     print_kernel_op_table_fwd(family, cw, terminate=False)
-    if family.kernel_policy == 'global' or family.kernel_policy == 'per-op':
+    if family.kernel_policy in ('global', 'per-op'):
         for op_name, op in family.ops.items():
             if op.is_async:
                 continue
-- 
2.52.0


