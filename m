Return-Path: <netdev+bounces-187418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFC2AA70BB
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB7A1BA7321
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAB723E346;
	Fri,  2 May 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ye/vAz4Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E8523C4FA
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185917; cv=none; b=hzi3alZoPnMzySueFkdmfqmW//Ueejzd/L9/ORnhxEcoUc3oIeJUWb9iuAMgI3gtmzA8MnS+o05PNQzYUA//Elygr2IIJzPqVq7pPy1te+9giEqbaQF0thBFzaVf0AffaqXxc7h5ukFgtU04nuUPVDh5cXuQazfsYLChWfeawWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185917; c=relaxed/simple;
	bh=6b8tVvxK7ZYREy+wigGJzBseXnjUU2sV5NA68NhQ4sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulzLya/aV3VOo+rV4StTkNwq9MVxaQQyKbxlddGKzQwBm6eXT8Xr0PbJ0KGrcEXKiPbj/8cR/jPP25DIztOUPZ5PU965E8hZUBAPeH/G42dc989MkjLeBHssMI1GkWm4AlT8IoZzVT7mo24qhamwkCUi+p7HLKKGyn+or1vXj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ye/vAz4Q; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso10374855e9.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185912; x=1746790712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8teh+CSKKntC0M2WFIP/AZinN8ripjXllAEJtMhx7HE=;
        b=ye/vAz4QqObBQNQ547/ErGRwZXXpzZPIGUHLIEweTud47e+w0MWyyhs/Gb7hGUX7c5
         imQQIQBJV6UpXxtQTK+zyk2ctDMVQ+YFzErqnsldg9XC3AZHOPIcEbGHpN/r1R6V0Q5S
         DrpsIx7Uk97YxbfPhR9XZ2XN8hLkYtU330hJ4IYRvGP1GHM1M68Kz/JttfbqG9yzQcDO
         4vhZ7iCB8ZaNSX+uAVkg8lcMshKLSRm/gqqbOgrr8Z84DI51xlcAQ7sxxF5AO+ap4RpP
         /R/cnO9KYrUVGQ/sxszSWJLXPrq2aUBL9vUl3LY1DBXW8F5SrPOSdrzQvV3dsJMu9zVu
         JXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185912; x=1746790712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8teh+CSKKntC0M2WFIP/AZinN8ripjXllAEJtMhx7HE=;
        b=JR/ZVSH8wnaXuhvHBvVl9AeHf+bnEjM8nm6EsTBD1GGkvQC6aWI5f9ZoWHE27fKfxv
         e99lP5VZFyE1LephJFlaQ6qdO0Gu3/iZfxSYaNCV4yLe4NQcSFAmgbKACpIVpOaOOygv
         cxeOn33TRa1fN3P92Lg50hvSt9ckYKzKiFsuAnGsmjp2UXjgC5GUW1A17yUWEyeqEJS8
         Pyjb1CXVHV6XyPYcbBPDEPJfHO5OTV7hFvZUDOYy/VdhhTOp7qWbQGh/aEq62pio2xze
         MWcTWe0M1N8+XQ3DMgCNaPMXZWOrwiC8/1hZH0wRCtxg241E0GucDQWUtnffZc9Wssj3
         ilBg==
X-Gm-Message-State: AOJu0YwUdriUBO4z03qgLNhAowhMXHImnDw0f1M1IgtZMdymX6ufRDvr
	7pIik8JxglD8wEghCzFJiVieDgOuraVdvxpjpJyLJFDhkmWiRTWlBTNUjCuTgsiXR9+fVWe36Af
	B0wI=
X-Gm-Gg: ASbGncuVIq603ip56jpfIlM+/QTryHrFHyATuWhjPsnkzt61gEaM7/13v7qi4NK+av8
	nArZTV53Gzp9RanPW39eN4M+aal7nImTl+jPU+5Qp4XUb7dGCYgugTHP4W4Un6Fi7d7VMBO3E6J
	q5P6cEmW2vBDgnUJmom2MgwMvLYpVFUQy4rthVLPRL09p1F3CFhjRvk2OIhZH+c3ApMd8Pm/Smz
	tclcpEdd2tn9v1hdB1eSNiF7Zy514rBTRHQzRQepPShgQcpU8dshFmdwI/tz2Tfyq68y4zaPjm3
	xOZMJPnGJcWm47zNWSjOCDjstCmnweiiyCDerNDmOyF7
X-Google-Smtp-Source: AGHT+IG7bbTvzUX2FICCsKPlXfEBte2subNVMVwMf1iIWoJNIKp+IoIFWfQyQnwWwFwxowNUISapfw==
X-Received: by 2002:a05:600c:3e1b:b0:440:94a2:95b8 with SMTP id 5b1f17b1804b1-441bbec6bccmr21525345e9.16.1746185912279;
        Fri, 02 May 2025 04:38:32 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d150fsm41533755e9.15.2025.05.02.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 2/5] tools: ynl-gen: allow noncontiguous enums
Date: Fri,  2 May 2025 13:38:18 +0200
Message-ID: <20250502113821.889-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502113821.889-1-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case the enum has holes, instead of hard stop, generate a validation
callback to check valid enum values.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
Saeed's v3->v1:
- add validation callback generation
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 45 +++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b4889974f645..c37551473923 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -358,11 +358,13 @@ class TypeScalar(Type):
         if 'enum' in self.attr:
             enum = self.family.consts[self.attr['enum']]
             low, high = enum.value_range()
-            if 'min' not in self.checks:
+            if low and 'min' not in self.checks:
                 if low != 0 or self.type[0] == 's':
                     self.checks['min'] = low
-            if 'max' not in self.checks:
+            if high and 'max' not in self.checks:
                 self.checks['max'] = high
+            if not low and not high:
+                self.checks['sparse'] = True
 
         if 'min' in self.checks and 'max' in self.checks:
             if self.get_limit('min') > self.get_limit('max'):
@@ -417,6 +419,8 @@ class TypeScalar(Type):
             return f"NLA_POLICY_MIN({policy}, {self.get_limit_str('min')})"
         elif 'max' in self.checks:
             return f"NLA_POLICY_MAX({policy}, {self.get_limit_str('max')})"
+        elif 'sparse' in self.checks:
+            return f"NLA_POLICY_VALIDATE_FN({policy}, &{c_lower(self.enum_name)}_validate)"
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
@@ -862,7 +866,7 @@ class EnumSet(SpecEnumSet):
         high = max([x.value for x in self.entries.values()])
 
         if high - low + 1 != len(self.entries):
-            raise Exception("Can't get value range for a noncontiguous enum")
+            return None, None
 
         return low, high
 
@@ -2299,6 +2303,40 @@ def print_kernel_policy_ranges(family, cw):
             cw.nl()
 
 
+def print_kernel_policy_sparse_enum_validates(family, cw):
+    first = True
+    for _, attr_set in family.attr_sets.items():
+        if attr_set.subset_of:
+            continue
+
+        for _, attr in attr_set.items():
+            if not attr.request:
+                continue
+            if not attr.enum_name:
+                continue
+            if 'sparse' not in attr.checks:
+                continue
+
+            if first:
+                cw.p('/* Sparse enums validation callbacks */')
+                first = False
+
+            sign = '' if attr.type[0] == 'u' else '_signed'
+            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
+            cw.write_func_prot('static int', f'{c_lower(attr.enum_name)}_validate',
+                               ['const struct nlattr *attr', 'struct netlink_ext_ack *extack'])
+            cw.block_start()
+            cw.block_start(line=f'switch (nla_get_{attr["type"]}(attr))', noind=True)
+            enum = family.consts[attr['enum']]
+            for entry in enum.entries.values():
+                cw.p(f'case {entry.c_name}: return 0;')
+            cw.block_end(noind=True)
+            cw.p('NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");')
+            cw.p('return -EINVAL;')
+            cw.block_end()
+            cw.nl()
+
+
 def print_kernel_op_table_fwd(family, cw, terminate):
     exported = not kernel_can_gen_family_struct(family)
 
@@ -2965,6 +3003,7 @@ def main():
             print_kernel_family_struct_hdr(parsed, cw)
         else:
             print_kernel_policy_ranges(parsed, cw)
+            print_kernel_policy_sparse_enum_validates(parsed, cw)
 
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
-- 
2.49.0


