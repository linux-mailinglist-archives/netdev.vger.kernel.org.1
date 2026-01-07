Return-Path: <netdev+bounces-247707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82061CFDA7F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BCA30F891D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B383161BA;
	Wed,  7 Jan 2026 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4ud838R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A4315D24
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788542; cv=none; b=nGU1VJRE2qt1KcLdG0zUS8v5XkT0PcHZDgWgfjE0kxpWUVpgXuF+CgxBczin1ae9bn8GCeK/PonKLy61KMp2RTkGmrUVUk+pIg3zOXhSJJLubAxjQ0R3ai6WSikXVnxN06bjzVrrrbaiM2HnGVG8o9eP2BhkHPClHcftMixUtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788542; c=relaxed/simple;
	bh=kdB+D8ooK5y+MGn4KMCXRzCE7BBpYAmF+6+mGhFmov0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVqRamgQa/52cG5ToEHrLQoSIdOwsWIBmdoXIW7IEx6QQbKlF6jJil9cyUrD3Kuo9XxBUi0g+ytDtHClp0QkVxaEnbnv2HRLe4aEQsPHchmKiETp/PcFQecv0CXLxtfGgdevZQFcxQAOKrRsRYObuw+C2SzcMKFr2u8fzWe7pjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4ud838R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso949912f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788538; x=1768393338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FKLGw9RhzY5YOkkhmRmhvQTx9xsA1wJogmSE46HH268=;
        b=R4ud838ReTtdL3jRI3wcuL8XKgEZ0M93KZcWiGkimDRBqSLq5nPwK8u/gHv/9FEc9i
         Tzxc5WdUYmlpofesl8hb6oMc4+Xnw3mq3F4YNAtOXLaJOgchazsrooMNX8JKYyCxL4U6
         hnAq99ns9ffa9C3sOSo7GRosJxyFKR11ctjMlK4LrvlQzynvpheonnoId5jfNY584KbL
         cmNzOPsmGqHH7BAcn0BEWFdPLir5EWHu6wSEr+H7thUSA1SNqMqvE2om/k+dEumpQdWm
         cjxjp4bOE3Xylwixbj6B+BTM3n8yVXxplOWdCkKVA4U+m4UhSsad9xOEfTVKojd8Y2fZ
         Zqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788538; x=1768393338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FKLGw9RhzY5YOkkhmRmhvQTx9xsA1wJogmSE46HH268=;
        b=qB7n4Qqz9OU9iKRi3h6M3uEMQDF+t3VWZUwhn7nSTeiV0D1Q+mYMQwka9ixY450vpw
         jyxpaGwhEsLZJPIlMJfRzr0EJoxzllhU8EdDt63Jow0jn872IWxhhgecPY4ItPQGF3ya
         TFfGbmPVFhnQ9JPCQ+hvFiRibfdEnMD1WwiBzKnhSpSo7H/4whtcOzA0Jkm8CifEUpdL
         r4OG6F8PUMJZfHYENU7/8i3mVQzB1V8iEpkMvimADhv07ztUO0EhtZYd0vGmOkCWUy5X
         Ni/P4u2IBH9iua/V/UzXqOj4cHNPJB0U1pzVK4Ms5UlqQnQQDEVRKxhB+7xenetDMxuu
         lAjw==
X-Forwarded-Encrypted: i=1; AJvYcCXTJZGPeKbjoWLpdF+YY3G1G/I8lh+aH8oRwrIlCp+5n0CMN6PR+lUKKI8A96EG6g4SdwoFs8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEO1ufovyn1c5YQtBLFnlvEXuVb2cHCGyrR+z6moYh9iKZETTm
	UxtJUFZYF+PUU27xY3mdX0zvMZcDLnuDgbPIqKyY5iD1yWPo6FPRLxBRbgx6cg==
X-Gm-Gg: AY/fxX7QzwF+gQoQ5z1KJq7KL1RTaym2nfhuISdA6RBQxYtB2EmtutKxtJYs0301lfk
	iysipWCroue8Hn7FwX2eBeU+sDm1RWTwi9IR8fmWZiL/TDluZhXk9wEUHwwGBEdXko2DJrDPTKP
	I6nj1OjrgkxOJjSi4Z1AVuKU37NNIzYD8X5IXjSo5oZua2NPLUPjihZpwBoYXSG1SxuuH8VmdVI
	ijuGVq0Kw6+AUl/NcCk0gn2X014ks3+XGUvcZowvioAUbwBh13ySioLXWww2H1sXOCR38eCftxt
	Vbm0f5wwqgBVYrv6//gSlET0iRR4Zc1f1eBvjzeHk0D9JETKsHQJiBC2G8WmwxCkfKuvX3HuMjP
	GzyNIwJeRYBwADnhwjoQ8gTpnYkz0SABHK/a9xgAuoQvkGpMNrcYoxZUzyuIY018nHcTLBf1SdX
	UDjn3jUs4BVIEWNhRda2VKOZSwkMcr
X-Google-Smtp-Source: AGHT+IFDN//R8tPKMlA4XyPjKFG9gUgQwKQylfTdCf0jvQBBESf+sLesU0BxFAZFA45mSUh5AwD0QA==
X-Received: by 2002:a05:6000:1449:b0:431:6ba:38ac with SMTP id ffacd0b85a97d-432c374f131mr3053927f8f.4.1767788538368;
        Wed, 07 Jan 2026 04:22:18 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:17 -0800 (PST)
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
Subject: [PATCH net-next v1 13/13] tools: ynl-gen-c: Fix remaining pylint warnings
Date: Wed,  7 Jan 2026 12:21:43 +0000
Message-ID: <20260107122143.93810-14-donald.hunter@gmail.com>
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

Fix the following pylint warning instances:

ynl_gen_c.py:575:15: E0606: Possibly using variable 'mem' before
assignment (possibly-used-before-assignment)

ynl_gen_c.py:888:0: R1707: Disallow trailing comma tuple
(trailing-comma-tuple)

ynl_gen_c.py:944:21: C0209: Formatting a regular string which could be an
f-string (consider-using-f-string)

ynl_gen_c.py:1450:14: C1802: Do not use `len(SEQUENCE)` without comparison
to determine if a sequence is empty (use-implicit-booleaness-not-len)

ynl_gen_c.py:1688:13: W1514: Using open without explicitly specifying an
encoding (unspecified-encoding)

ynl_gen_c.py:3446:0: C0325: Unnecessary parens after '=' keyword
(superfluous-parens)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 5f079a74c8d1..c823ccf2b75c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -571,6 +571,8 @@ class TypeBinary(Type):
             mem = 'NLA_POLICY_MIN_LEN(' + self.get_limit_str('min-len') + ')'
         elif 'max-len' in self.checks:
             mem = 'NLA_POLICY_MAX_LEN(' + self.get_limit_str('max-len') + ')'
+        else:
+            raise Exception('Failed to process policy check for binary type')
 
         return mem
 
@@ -885,7 +887,7 @@ class TypeIndexedArray(Type):
                 f"for (i = 0; i < {var}->{ref}_count.{self.c_name}; i++)",
                 f'{self.nested_render_name}_free(&{var}->{ref}{self.c_name}[i]);',
             ]
-        lines += f"free({var}->{ref}{self.c_name});",
+        lines += (f"free({var}->{ref}{self.c_name});",)
         return lines
 
 class TypeNestTypeValue(Type):
@@ -941,9 +943,8 @@ class TypeSubMessage(TypeNest):
         else:
             sel_var = f"{var}->{sel}"
         get_lines = [f'if (!{sel_var})',
-                     'return ynl_submsg_failed(yarg, "%s", "%s");' %
-                        (self.name, self['selector']),
-                    f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
+                     f'return ynl_submsg_failed(yarg, "{self.name}", "{self['selector']}");',
+                     f"if ({self.nested_render_name}_parse(&parg, {sel_var}, attr))",
                      "return YNL_PARSE_CB_ERROR;"]
         init_lines = [f"parg.rsp_policy = &{self.nested_render_name}_nest;",
                       f"parg.data = &{var}->{self.c_name};"]
@@ -1447,7 +1448,7 @@ class Family(SpecFamily):
         attr_set_queue = list(self.root_sets.keys())
         attr_set_seen = set(self.root_sets.keys())
 
-        while len(attr_set_queue):
+        while attr_set_queue:
             a_set = attr_set_queue.pop(0)
             for attr, spec in self.attr_sets[a_set].items():
                 if 'nested-attributes' in spec:
@@ -1685,7 +1686,7 @@ class CodeWriter:
         if not self._overwrite and os.path.isfile(self._out_file):
             if filecmp.cmp(self._out.name, self._out_file, shallow=False):
                 return
-        with open(self._out_file, 'w+') as out_file:
+        with open(self._out_file, 'w+', encoding='utf-8') as out_file:
             self._out.seek(0)
             shutil.copyfileobj(self._out, out_file)
             self._out.close()
@@ -3443,7 +3444,7 @@ def main():
         print(exc)
         os.sys.exit(1)
 
-    cw = CodeWriter(BaseNlLib(), args.out_file, overwrite=(not args.cmp_out))
+    cw = CodeWriter(BaseNlLib(), args.out_file, overwrite=not args.cmp_out)
 
     _, spec_kernel = find_kernel_root(args.spec)
     if args.mode == 'uapi' or args.header:
-- 
2.52.0


