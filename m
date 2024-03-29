Return-Path: <netdev+bounces-83187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F08913EE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 07:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6ED1F22B50
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA77C3D0DF;
	Fri, 29 Mar 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4t9tEX1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD11171D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711695275; cv=none; b=MYSUlElFejHYifh36OIvZ4uC0QNT+oHVAQjshTNVLVXQ6yUq/JApxXZiShKc4+Lp1bAuYy7R3lUVJKRLPjE2XVQrLs4f8bopYj75p3mlpobR4UBqc7H5d10nwO8o5yqCEex2+Gu5XzQebFmebfY+fsY4eKsuAvLnftAN4rIptVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711695275; c=relaxed/simple;
	bh=nw6SLJmfoYVtKpCubbexbfjoUIEze/0O8AKGgyA2Zag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDr+kGiGTVBpCl190Bd80Om5/KDkz1cwORyUPSFLOoQy7sFm57IJv5ZjHgF32s2sTl0AIfeVjK20cbRXUltrtlzqxoeVVLv2x4Bah3i/fk3OO0fzXKQqd14K1MZyNj2LxQJTDG65uThRtPYlgGMTfgDaRiC8Fi1rZdUp1VFcZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4t9tEX1; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3eb9cb820so460796b6e.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711695272; x=1712300072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdpeYvmmCtcqLz0dT69HOU3c4NjDhc5J4OJ8Ce0JhK4=;
        b=l4t9tEX1t4+eQxl9x/lEdkthekHE3eQ3OeBT57dMI7OOVHTWfFyOUIWa7wKVmpdleD
         y/vWbn1kF0EwEeuanP70F1smN5z9nqqq/S6BFwpgYWwQt/bNRw76S4tO2ZN+aT/5d3jO
         MywAdAu71MAcrkm4vo85zDo1rAaLAs7JYWrlkd0RgrR+kCqrWd18LoefhNssoSZxA6sZ
         pPwZmG7Qwo7kyBz6UOsVZgUssPPtu4ndTAXZFuebtH9O+LTJE7C8XeYRRobRAYb5RzNt
         JBr0E9PTGDV/Bz/MjavhqYmtvleYBSk8qljMqPQfyvJORL1bmwDS9R3XnHd5vvT3GJFW
         Vc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711695272; x=1712300072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdpeYvmmCtcqLz0dT69HOU3c4NjDhc5J4OJ8Ce0JhK4=;
        b=FSQO1KgV4bUF9T6Wsp7oM6WY9ea0/v4bwsTmUaxaYpFW2ELqN3i1QFnkGPPvUt0NZA
         7G+xzHiOa+etBHfHyhE+imLaj0KfAbWVCt6cSM0Dt8gN4Cd+JS1B+nLAcd+ePktSSqz+
         hE0niPZDJs1Ol/mpgYSTum5fOCgKXsI/Z6IMzgYJPrED8MuWF4t/3Xa4vV6f4A4p49H3
         mpLR8qjoOpYumpFoJwgitMZiRPTxHg32pyJm4bWFzyxO+bBc1DYUtRKQBF1KtDUNZig5
         MowMpPAUbdaUMkBqSnBoXpnwd4pV1kWFAgit9V7u1ibvWrWR2nhAZJuCfF1XWnPq0ojI
         jJMQ==
X-Gm-Message-State: AOJu0YzIWIbGAFKJhHfsM/MJ8unlSh66Www6D+wnaTvihs1U9wGiVaj3
	/ZoclnFo2zKJglMoe1GDYIKqsA88JNjhQgO4WwuOEXd3M4knXzNpXPokzPKuEBxptiEB
X-Google-Smtp-Source: AGHT+IHjB9w5yf+mlV6vZrodenVPe+4bb3uvGHqpP8nmCCXeSnkPJBKm/n2D7hvqb0SaR40cup4LWQ==
X-Received: by 2002:a05:6808:1281:b0:3c3:e621:51e3 with SMTP id a1-20020a056808128100b003c3e62151e3mr1722738oiw.41.1711695272559;
        Thu, 28 Mar 2024 23:54:32 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79dc8000000b006e56da42e24sm2423251pfq.158.2024.03.28.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 23:54:32 -0700 (PDT)
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
Subject: [PATCHv2 net-next 1/2] ynl: rename array-nest to indexed-array
Date: Fri, 29 Mar 2024 14:54:22 +0800
Message-ID: <20240329065423.1736120-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329065423.1736120-1-liuhangbin@gmail.com>
References: <20240329065423.1736120-1-liuhangbin@gmail.com>
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
 Documentation/netlink/genetlink-c.yaml        |  2 +-
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 Documentation/netlink/genetlink.yaml          |  2 +-
 Documentation/netlink/netlink-raw.yaml        |  2 +-
 Documentation/netlink/specs/nlctrl.yaml       |  6 ++++--
 Documentation/netlink/specs/rt_link.yaml      |  3 ++-
 Documentation/netlink/specs/tc.yaml           | 21 ++++++++++++-------
 .../netlink/genetlink-legacy.rst              | 10 +++++++--
 tools/net/ynl/lib/ynl.py                      | 13 +++++++-----
 tools/net/ynl/ynl-gen-c.py                    | 18 ++++++++++------
 10 files changed, 52 insertions(+), 27 deletions(-)

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
index 70a77387f6c4..1ee1647d0ee8 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -46,10 +46,16 @@ For reference the ``multi-attr`` array may look like this::
 
 where ``ARRAY-ATTR`` is the array entry type.
 
-array-nest
+indexed-array
 ~~~~~~~~~~
 
-``array-nest`` creates the following structure::
+``indexed-array`` wraps the entire array in an extra attribute (hence
+limiting its size to 64kB). The ``ENTRY`` nests are special and have the
+index of the entry as their type instead of normal attribute type.
+
+A ``sub-type`` is needed to describe what type in the ``ENTRY``. A ``nest``
+``sub-type`` means there are nest arrays in the ``ENTRY``, with the structure
+looks like::
 
   [SOME-OTHER-ATTR]
   [ARRAY-ATTR]
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e73b027c5624..d088bcbcadec 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -584,15 +584,18 @@ class YnlFamily(SpecFamily):
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
@@ -686,8 +689,8 @@ class YnlFamily(SpecFamily):
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


