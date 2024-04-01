Return-Path: <netdev+bounces-83716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B98937E8
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF7C281607
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CB8BF7;
	Mon,  1 Apr 2024 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRqyjGnG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F88BF6
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711943824; cv=none; b=ZCArGZTYlzh3nGxeu+c1YCDuFwhq53ufOkaCiENgTIg9HGdzmzmgbQCkMYXAwn+bjrzr6qJehoM8he3MvOZu9B+ah+iyAKkI82iWg0gd6XlkFo65f5Zy29iCYF2yTepSiybv1OWP0LPJkNRoj7j95YzZj0cmp0wXIRb4n/cYw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711943824; c=relaxed/simple;
	bh=O5KIupmg0TEuVKpfOtrlzczdQX/tfigm6x8skXrJqII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic2HQBEOwANgmzXfLnWzufNPF9JKKTFE5/fLY5OldryCkmCuaeZ47tcXZ7yZTlsTS8iN5h+E1MeBDQ6Zp93PxwNuO0xbMX/zxd9OtCxAdUXlpabbjXCBNOMnfeRKd6KafsXntncxocc5+enLy0EWLhnJGSfvVPA6uIK0fg45iiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRqyjGnG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dee27acf7aso25705795ad.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711943821; x=1712548621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOmrT8LXyKcAqfj5FrwD0uqDCXplEOsAXjia7zzbI4g=;
        b=RRqyjGnGxmeryJ8gLyTu0vhhYYaYxGXNx68se0F7YGx+34d9XZWSKkm/482/YZWs0k
         u/ndvPSKg+Hq4ojxTyTrBcm40L2uoZMePgAn78oULpy8iagZutireJxFW0hqFqaReFPw
         aT8dBEzpo6bZff4r+QhaNbu+12qj0vEFVX2lOruUoyw0PHt/2fv6+QmenPoseNZrEcw+
         nPD1KEGo6zno0jRPphYBGuxoDpRRv1lD6vvncal2QNkxs57acM4VES0enotY979SoajI
         SHRO4COQMqn7LM81jhiiOIPwIZoo1+Dt9SOZDTeOl/VERIvcLWjbRodtINAhd3C3w3Iw
         wA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711943821; x=1712548621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOmrT8LXyKcAqfj5FrwD0uqDCXplEOsAXjia7zzbI4g=;
        b=ZX126p3XaRZaWxWZ1Fe1J/DB3GJjHS7Rj74G3qO1pOwomOjdm6a3qmL/17HNWQfr/W
         dT7G82yrGit4NeXLWv0Ln9mKifKcuxcaek4ZqJrpEfpjl6/vPqG9e6KME6nLzrhFWYo6
         vTEMwGedM/fI0YPwqAzJ2HFr4Ziy3di19q3TWUsZYrrJEvo9iy14hUmilMNm/k8999Ug
         oCM2TH0HtbmPyRCc1RfitTfwlcslgF0MVFpv7zidJdAV0ar/eghRbvlwVLZt/Y5H+zr0
         plEFUwI7eRs1qnm3sNzQLn0Pqe2jQKtWSVoHGx86POnhque+gTRX17hWhMTpB4sGc6C9
         N8Qg==
X-Gm-Message-State: AOJu0YxyxIb0O9WAn8tgGLfRT70+BJgjAYNzmyijMIb7jkmoc9WQNIbS
	Tzv0ZIFwSanU4uR7ShNMk1oyAHFTBj6arLO0Yp9M62ThDqEO+pC0sIgQVUodHJsWng==
X-Google-Smtp-Source: AGHT+IFJOiOHnvso+hfK3Do/BoZPetwJ072bikumtcGFC5WuH3YXL4XHdPHvtO1ZWcGyaIe4OfrhXg==
X-Received: by 2002:a17:902:b588:b0:1e2:86f:d268 with SMTP id a8-20020a170902b58800b001e2086fd268mr8463564pls.19.1711943821223;
        Sun, 31 Mar 2024 20:57:01 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902b40a00b001dc486f0cbesm7660143plr.222.2024.03.31.20.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 20:57:00 -0700 (PDT)
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
Subject: [PATCHv3 net-next 1/2] ynl: rename array-nest to indexed-array
Date: Mon,  1 Apr 2024 11:56:50 +0800
Message-ID: <20240401035651.1251874-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401035651.1251874-1-liuhangbin@gmail.com>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some implementations, like bonding, has nest array with same attr type.
To support all kinds of entries under one nest array. As discussed[1],
let's rename array-nest to indexed-array, and assuming the value is
a nest by passing the type via sub-type.

[1] https://lore.kernel.org/netdev/20240312100105.16a59086@kernel.org/

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml        |  2 +-
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 Documentation/netlink/genetlink.yaml          |  2 +-
 Documentation/netlink/netlink-raw.yaml        |  2 +-
 Documentation/netlink/specs/nlctrl.yaml       |  6 ++++--
 Documentation/netlink/specs/rt_link.yaml      |  3 ++-
 Documentation/netlink/specs/tc.yaml           | 21 ++++++++++++-------
 .../netlink/genetlink-legacy.rst              | 12 ++++++++---
 tools/net/ynl/lib/ynl.py                      | 13 +++++++-----
 tools/net/ynl/ynl-gen-c.py                    | 18 ++++++++++------
 10 files changed, 53 insertions(+), 28 deletions(-)

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
index 81a5a3d1b04d..e5dcb2cf1724 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1690,7 +1690,8 @@ attribute-sets:
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
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 70a77387f6c4..54e8fb25e093 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -46,10 +46,16 @@ For reference the ``multi-attr`` array may look like this::
 
 where ``ARRAY-ATTR`` is the array entry type.
 
-array-nest
-~~~~~~~~~~
+indexed-array
+~~~~~~~~~~~~~
+
+``indexed-array`` wraps the entire array in an extra attribute (hence
+limiting its size to 64kB). The ``ENTRY`` nests are special and have the
+index of the entry as their type instead of normal attribute type.
 
-``array-nest`` creates the following structure::
+A ``sub-type`` is needed to describe what type in the ``ENTRY``. A ``nest``
+``sub-type`` means there are nest arrays in the ``ENTRY``, with the structure
+looks like::
 
   [SOME-OTHER-ATTR]
   [ARRAY-ATTR]
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 82d3c98067aa..e5ad415905c7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -630,15 +630,18 @@ class YnlFamily(SpecFamily):
                 decoded = self._formatted_string(decoded, attr_spec.display_hint)
         return decoded
 
-    def _decode_array_nest(self, attr, attr_spec):
+    def _decode_array_attr(self, attr, attr_spec):
         decoded = []
         offset = 0
         while offset < len(attr.raw):
             item = NlAttr(attr.raw, offset)
             offset += item.full_len
 
-            subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
-            decoded.append({ item.type: subattrs })
+            if attr_spec["sub-type"] == 'nest':
+                subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
+                decoded.append({ item.type: subattrs })
+            else:
+                raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
 
     def _decode_nest_type_value(self, attr, attr_spec):
@@ -732,8 +735,8 @@ class YnlFamily(SpecFamily):
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
                 if 'enum' in attr_spec:
                     decoded = self._decode_enum(decoded, attr_spec)
-            elif attr_spec["type"] == 'array-nest':
-                decoded = self._decode_array_nest(attr, attr_spec)
+            elif attr_spec["type"] == 'indexed-array':
+                decoded = self._decode_array_attr(attr, attr_spec)
             elif attr_spec["type"] == 'bitfield32':
                 value, selector = struct.unpack("II", attr.raw)
                 if 'enum' in attr_spec:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a451cbfbd781..c0b90c104d92 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -841,8 +841,11 @@ class AttrSet(SpecAttrSet):
             t = TypeBitfield32(self.family, self, elem, value)
         elif elem['type'] == 'nest':
             t = TypeNest(self.family, self, elem, value)
-        elif elem['type'] == 'array-nest':
-            t = TypeArrayNest(self.family, self, elem, value)
+        elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
+            if elem["sub-type"] == 'nest':
+                t = TypeArrayNest(self.family, self, elem, value)
+            else:
+                raise Exception(f'new_attr: unsupported sub-type {elem["sub-type"]}')
         elif elem['type'] == 'nest-type-value':
             t = TypeNestTypeValue(self.family, self, elem, value)
         else:
@@ -1055,7 +1058,7 @@ class Family(SpecFamily):
                     if nested in self.root_sets:
                         raise Exception("Inheriting members to a space used as root not supported")
                     inherit.update(set(spec['type-value']))
-                elif spec['type'] == 'array-nest':
+                elif spec['type'] == 'indexed-array':
                     inherit.add('idx')
                 self.pure_nested_structs[nested].set_inherited(inherit)
 
@@ -1619,9 +1622,12 @@ def _multi_parse(ri, struct, init_lines, local_vars):
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
+            else:
+                raise Exception(f'Not supported sub-type {aspec["sub-type"]}')
         if 'multi-attr' in aspec:
             multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
-- 
2.43.0


