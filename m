Return-Path: <netdev+bounces-81915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3AE88BA89
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE761C31319
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92971745D6;
	Tue, 26 Mar 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIjuiGCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF454BFF
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435064; cv=none; b=suGejjptkJyiwZLP9dXF7AH3EteyH6L7hhYR6UoqYH2wK7NdEezkEpU46WuA1SVJmnFrfspFZL46s9Ik3IzutzOuzY/GZvw2sd8F8mcbqeiuwukpRd7NUj15WlKw+o73oF7geazmhi6W90aD6/H858jrYXlJEdQiMovd5NN8OwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435064; c=relaxed/simple;
	bh=R6XV8CP2KsFaZBZUNnIHHfO2AAWh5FSmeZF8+IC+9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAVYx58rt87FmklfpUoNbgvxNBkHyKAYbC7xiojRBMINTMJpgDloxHdpYohX0Zzzt400cFGCTo76MC1OGXgnU7jaf0y6IUQOIQrC0XIM9BRY4m2HWtxa9cwPElE6ZUwAPxhWCzqdXkboCqgo43C32mK5WTpe4DtKpmggfO04Muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIjuiGCC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e00d1e13acso30768145ad.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711435062; x=1712039862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tW8EDqv84CL3BBMzTxgA5TtBs/28mH0kdc+16aiL94=;
        b=XIjuiGCC7OHomzsQnVY8rmh+Z0EpcuxcQfNJ6ZWcP1byjgt0Pr0XAvQ3IwVDIrzZKr
         GunmNaNJ18NAg4mJc+4vurCwqDhrmqYniAUVf4Sv6NbJBu8OQrjGkKbIzf6WtD1JncLv
         jlHUKogqPM2k0DH9Kcu34q4FIKZPfE4AHaqItErQ8yxGNCpZ3GEt9pjbe9mPGgOs0nTp
         sihOaXq78yxmNtY+x6WzisH6gtHYw6VEAXgdKK4CUHABLK/BNe+bVtY+WTirDS0K4Dpr
         Ite7TFPKWA3S4sL5hel/o2LdayAEN2oiWHyzXKQU38yUe9+oXgpbez8aJgPlHis/WrnD
         TlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435062; x=1712039862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tW8EDqv84CL3BBMzTxgA5TtBs/28mH0kdc+16aiL94=;
        b=o+ASW8qBHzSo9tLg5Vrkm1X+42MVWk3naTpHci7OlCb/W/Mefwd4MU1PjKpSlkVwor
         GXj2eZ/CRq85Yo4sL4jRUusxVj8rSBM6/XQWiZMvjlQs3Bt1mmX9JbgfAHbJ2ssfKUKM
         K9+PtJOIah2u2Dr5bbe4Dx2Yizmu2iHs2IjPjwQlKuVaOIjHpZU3RELUjY9oBeQ1fFlQ
         M7+AJhWZ34tQmYcBeS6gE9FdjwSpmgTlt0SV2gZhTzuf6NzYdLNh4XEddBonlcxUJMcI
         i04K8Z8lVU9uSjdoSERygoI57u5ZWqaFsFtz0Xhd4ARNgF2/AkDEg9piLhyloATFwRkw
         mACg==
X-Gm-Message-State: AOJu0YyVIEo0lAMr1wgkV/2Ix24iMQi9UaSDdcGYfU9E5yqAVuBiDEfo
	HIY+E/+EbxJB0jQVqlR60r5GPZ5hLCYeaer5IrpRK6BE07qnlLESOvN7QbYRCgpq8bC7
X-Google-Smtp-Source: AGHT+IEvBF/A/GdK/NynhwF8vsdElBrQ23+V3jBel14JqT975tKHiZMYal8ZIzoTJbVhvbiNMVRK1g==
X-Received: by 2002:a17:902:d4cc:b0:1e0:d609:3c0d with SMTP id o12-20020a170902d4cc00b001e0d6093c0dmr3482939plg.56.1711435061831;
        Mon, 25 Mar 2024 23:37:41 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5893458plf.76.2024.03.25.23.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 23:37:41 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/2] ynl: rename array-nest to indexed-array
Date: Tue, 26 Mar 2024 14:37:27 +0800
Message-ID: <20240326063728.2369353-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326063728.2369353-1-liuhangbin@gmail.com>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some implementations, like bonding, has nest array with same attr type.
To support all kinds of entries under one nest array. As disscussed[1],
let's rename array-nest to indexed-array, and assuming the value is
a nest by passing the type via sub-type.

[1] https://lore.kernel.org/netdev/20240312100105.16a59086@kernel.org/

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 Documentation/netlink/genetlink.yaml        |  2 +-
 Documentation/netlink/netlink-raw.yaml      |  2 +-
 Documentation/netlink/specs/nlctrl.yaml     |  6 ++++--
 Documentation/netlink/specs/rt_link.yaml    |  3 ++-
 Documentation/netlink/specs/tc.yaml         | 21 ++++++++++++++-------
 tools/net/ynl/lib/ynl.py                    |  5 +++--
 tools/net/ynl/ynl-gen-c.py                  | 17 ++++++++++-------
 9 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 4dfd899a1661..4f803eaac6d8 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -158,7 +158,7 @@ properties:
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
                         uint, sint, u8, u16, u32, u64, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
                 type: string
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index b48ad3b1cc32..8db0e22fa72c 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -201,7 +201,7 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         uint, sint, u8, u16, u32, u64, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
                 type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index ebd6ee743fcc..b036227b46f1 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -124,7 +124,7 @@ properties:
               type: &attr-type
                 enum: [ unused, pad, flag, binary,
                         uint, sint, u8, u16, u32, u64, s32, s64,
-                        string, nest, array-nest, nest-type-value ]
+                        string, nest, indexed-array, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
                 type: string
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index a76e54cbadbc..914aa1c0a273 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -222,7 +222,7 @@ properties:
                 description: The netlink attribute type
                 enum: [ unused, pad, flag, binary, bitfield32,
                         u8, u16, u32, u64, s8, s16, s32, s64,
-                        string, nest, array-nest, nest-type-value,
+                        string, nest, indexed-array, nest-type-value,
                         sub-message ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/specs/nlctrl.yaml b/Documentation/netlink/specs/nlctrl.yaml
index b1632b95f725..a36535350bdb 100644
--- a/Documentation/netlink/specs/nlctrl.yaml
+++ b/Documentation/netlink/specs/nlctrl.yaml
@@ -65,11 +65,13 @@ attribute-sets:
         type: u32
       -
         name: ops
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: op-attrs
       -
         name: mcast-groups
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: mcast-group-attrs
       -
         name: policy
diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 8e4d19adee8c..08bec2537a63 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1617,7 +1617,8 @@ attribute-sets:
         type: binary
       -
         name: hw-s-info
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: hw-s-info-one
       -
         name: l3-stats
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 324fa182cd14..dbcf19e494ec 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -1937,7 +1937,8 @@ attribute-sets:
         nested-attributes: tc-ematch-attrs
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: police
@@ -2077,7 +2078,8 @@ attribute-sets:
         type: u32
       -
         name: tin-stats
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-cake-tin-stats-attrs
       -
         name: deficit
@@ -2297,7 +2299,8 @@ attribute-sets:
         type: string
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: key-eth-dst
@@ -2798,7 +2801,8 @@ attribute-sets:
         type: string
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: mask
@@ -2951,7 +2955,8 @@ attribute-sets:
         type: u32
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: flags
@@ -3324,7 +3329,8 @@ attribute-sets:
         nested-attributes: tc-police-attrs
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
   -
     name: tc-taprio-attrs
@@ -3542,7 +3548,8 @@ attribute-sets:
         nested-attributes: tc-police-attrs
       -
         name: act
-        type: array-nest
+        type: indexed-array
+        sub-type: nest
         nested-attributes: tc-act-attrs
       -
         name: indev
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5fa7957f6e0f..7239e673a28a 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -686,8 +686,9 @@ class YnlFamily(SpecFamily):
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
                 if 'enum' in attr_spec:
                     decoded = self._decode_enum(decoded, attr_spec)
-            elif attr_spec["type"] == 'array-nest':
-                decoded = self._decode_array_nest(attr, attr_spec)
+            elif attr_spec["type"] == 'indexed-array' and 'sub-type' in attr_spec:
+                if attr_spec["sub-type"] == 'nest':
+                    decoded = self._decode_array_nest(attr, attr_spec)
             elif attr_spec["type"] == 'bitfield32':
                 value, selector = struct.unpack("II", attr.raw)
                 if 'enum' in attr_spec:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 6b7eb2d2aaf1..8d5ec5449648 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -838,8 +838,9 @@ class AttrSet(SpecAttrSet):
             t = TypeBitfield32(self.family, self, elem, value)
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
-        elif elem['type'] == 'array-nest':
-            t = TypeArrayNest(self.family, self, elem, value)
+        elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
+            if elem["sub-type"] == 'nest':
+                t = TypeArrayNest(self.family, self, elem, value)
         elif elem['type'] == 'nest-type-value':
             t = TypeNestTypeValue(self.family, self, elem, value)
         else:
@@ -1052,8 +1053,9 @@ class Family(SpecFamily):
                     if nested in self.root_sets:
                         raise Exception("Inheriting members to a space used as root not supported")
                     inherit.update(set(spec['type-value']))
-                elif spec['type'] == 'array-nest':
-                    inherit.add('idx')
+                elif spec['type'] == 'indexed-array' and 'sub-type' in spec:
+                    if spec["sub-type"] == 'nest':
+                        inherit.add('idx')
                 self.pure_nested_structs[nested].set_inherited(inherit)
 
         for root_set, rs_members in self.root_sets.items():
@@ -1616,9 +1618,10 @@ def _multi_parse(ri, struct, init_lines, local_vars):
     multi_attrs = set()
     needs_parg = False
     for arg, aspec in struct.member_list():
-        if aspec['type'] == 'array-nest':
-            local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
-            array_nests.add(arg)
+        if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
+            if aspec["sub-type"] == 'nest':
+                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
+                array_nests.add(arg)
         if 'multi-attr' in aspec:
             multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
-- 
2.43.0


