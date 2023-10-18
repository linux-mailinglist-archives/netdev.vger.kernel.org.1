Return-Path: <netdev+bounces-42431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D387CEA24
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14194B21269
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C63FE3B;
	Wed, 18 Oct 2023 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+eCZd2y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA43FB0D
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 21:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D6FC433C7;
	Wed, 18 Oct 2023 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697665165;
	bh=3ma14P99QjO486lw+mTLJr8fTVnCPxtNoQRGpRPGNsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+eCZd2yFfcsjjulke8qvxiXdts55CGz19ywsxiUGZIlK5s3Xnf9DHw6+YmpVIe4E
	 N1fMb+YekI1F4DPL8vhDvaGpli+TefbmP1On79QFaW3w8ISx05cmVgj1+aufdO77ri
	 JxLwQ9FLAqdFMyw9L8S2l7bYL/tKTnmkbCRsU3kW2al/HHnFH+iIkSXEqGF8f8lyjU
	 RwJ9Ijd4c/0V2l5A529rX22GzAk9ccFUK7nijInwFgRc65uzU+7Vyj4Ae7IM22zSpQ
	 c6KqdM6w6AttoLMT3AR+A5lK7L04Oyhkp+BcoJh4FhSaOO40mYnTHoAjdQMttFRhzv
	 wSNv60aY8Mwwg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/3] netlink: specs: add support for auto-sized scalars
Date: Wed, 18 Oct 2023 14:39:21 -0700
Message-ID: <20231018213921.2694459-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018213921.2694459-1-kuba@kernel.org>
References: <20231018213921.2694459-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support uint / sint types in specs and YNL.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/genetlink-c.yaml      |  3 ++-
 Documentation/netlink/genetlink-legacy.yaml |  3 ++-
 Documentation/netlink/genetlink.yaml        |  3 ++-
 tools/net/ynl/lib/nlspec.py                 |  6 ++++++
 tools/net/ynl/lib/ynl.c                     |  6 ++++++
 tools/net/ynl/lib/ynl.h                     | 17 +++++++++++++++++
 tools/net/ynl/lib/ynl.py                    | 14 ++++++++++++++
 tools/net/ynl/ynl-gen-c.py                  |  6 ++++--
 8 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index dee11c514896..c72c8a428911 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -149,7 +149,8 @@ additionalProperties: False
               name:
                 type: string
               type: &attr-type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary,
+                        uint, sint, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 9194f3e223ef..923de0ff1a9e 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -192,7 +192,8 @@ additionalProperties: False
                 type: string
               type: &attr-type
                 description: The netlink attribute type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary,
+                        uint, sint, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 0a4ae861d011..9ceb096b2df2 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -122,7 +122,8 @@ additionalProperties: False
               name:
                 type: string
               type: &attr-type
-                enum: [ unused, pad, flag, binary, u8, u16, u32, u64, s32, s64,
+                enum: [ unused, pad, flag, binary,
+                        uint, sint, u8, u16, u32, u64, s32, s64,
                         string, nest, array-nest, nest-type-value ]
               doc:
                 description: Documentation of the attribute.
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 37bcb4d8b37b..92889298b197 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -149,6 +149,7 @@ jsonschema = None
     Represents a single attribute type within an attr space.
 
     Attributes:
+        type          string, attribute type
         value         numerical ID when serialized
         attr_set      Attribute Set containing this attr
         is_multi      bool, attr may repeat multiple times
@@ -157,10 +158,13 @@ jsonschema = None
         len           integer, optional byte length of binary types
         display_hint  string, hint to help choose format specifier
                       when displaying the value
+
+        is_auto_scalar bool, attr is a variable-size scalar
     """
     def __init__(self, family, attr_set, yaml, value):
         super().__init__(family, yaml)
 
+        self.type = yaml['type']
         self.value = value
         self.attr_set = attr_set
         self.is_multi = yaml.get('multi-attr', False)
@@ -170,6 +174,8 @@ jsonschema = None
         self.len = yaml.get('len')
         self.display_hint = yaml.get('display-hint')
 
+        self.is_auto_scalar = self.type == "sint" or self.type == "uint"
+
 
 class SpecAttrSet(SpecElement):
     """ Netlink Attribute Set class.
diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index 514e0d69e731..350ddc247450 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -352,6 +352,12 @@ int ynl_attr_validate(struct ynl_parse_arg *yarg, const struct nlattr *attr)
 		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
 		     "Invalid attribute (u64 %s)", policy->name);
 		return -1;
+	case YNL_PT_UINT:
+		if (len == sizeof(__u32) || len == sizeof(__u64))
+			break;
+		yerr(yarg->ys, YNL_ERROR_ATTR_INVALID,
+		     "Invalid attribute (uint %s)", policy->name);
+		return -1;
 	case YNL_PT_FLAG:
 		/* Let flags grow into real attrs, why not.. */
 		break;
diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
index 9eafa3552c16..87b4dad832f0 100644
--- a/tools/net/ynl/lib/ynl.h
+++ b/tools/net/ynl/lib/ynl.h
@@ -133,6 +133,7 @@ enum ynl_policy_type {
 	YNL_PT_U16,
 	YNL_PT_U32,
 	YNL_PT_U64,
+	YNL_PT_UINT,
 	YNL_PT_NUL_STR,
 };
 
@@ -234,4 +235,20 @@ int ynl_exec_dump(struct ynl_sock *ys, struct nlmsghdr *req_nlh,
 void ynl_error_unknown_notification(struct ynl_sock *ys, __u8 cmd);
 int ynl_error_parse(struct ynl_parse_arg *yarg, const char *msg);
 
+#ifndef MNL_HAS_AUTO_SCALARS
+static inline uint64_t mnl_attr_get_uint(const struct nlattr *attr)
+{
+	if (mnl_attr_get_len(attr) == 4)
+		return mnl_attr_get_u32(attr);
+	return mnl_attr_get_u64(attr);
+}
+
+static inline void
+mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
+{
+	if ((uint32_t)data == (uint64_t)data)
+		return mnl_attr_put_u32(nlh, type, data);
+	return mnl_attr_put_u64(nlh, type, data);
+}
+#endif
 #endif
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 28ac35008e65..3b36553a66cc 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -130,6 +130,13 @@ from .nlspec import SpecFamily
         format = self.get_format(attr_type, byte_order)
         return format.unpack(self.raw)[0]
 
+    def as_auto_scalar(self, attr_type, byte_order=None):
+        if len(self.raw) != 4 and len(self.raw) != 8:
+            raise Exception(f"Auto-scalar len payload be 4 or 8 bytes, got {len(self.raw)}")
+        real_type = attr_type[0] + str(len(self.raw) * 8)
+        format = self.get_format(real_type, byte_order)
+        return format.unpack(self.raw)[0]
+
     def as_strz(self):
         return self.raw.decode('ascii')[:-1]
 
@@ -463,6 +470,11 @@ genl_family_name_to_id = None
                 attr_payload = bytes.fromhex(value)
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
+        elif attr.is_auto_scalar:
+            scalar = int(value)
+            real_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
+            format = NlAttr.get_format(real_type, attr.byte_order)
+            attr_payload = format.pack(int(value))
         elif attr['type'] in NlAttr.type_formats:
             format = NlAttr.get_format(attr['type'], attr.byte_order)
             attr_payload = format.pack(int(value))
@@ -529,6 +541,8 @@ genl_family_name_to_id = None
                 decoded = self._decode_binary(attr, attr_spec)
             elif attr_spec["type"] == 'flag':
                 decoded = True
+            elif attr_spec.is_auto_scalar:
+                decoded = attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order)
             elif attr_spec["type"] in NlAttr.type_formats:
                 decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
             elif attr_spec["type"] == 'array-nest':
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 6f4c538bda9a..a9e8898c9386 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -335,6 +335,8 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         maybe_enum = not self.is_bitfield and 'enum' in self.attr
         if maybe_enum and self.family.consts[self.attr['enum']].enum_name:
             self.type_name = f"enum {self.family.name}_{c_lower(self.attr['enum'])}"
+        elif self.is_auto_scalar:
+            self.type_name = '__' + self.type[0] + '64'
         else:
             self.type_name = '__' + self.type
 
@@ -362,7 +364,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         return super()._attr_policy(policy)
 
     def _attr_typol(self):
-        return f'.type = YNL_PT_U{self.type[1:]}, '
+        return f'.type = YNL_PT_U{c_upper(self.type[1:])}, '
 
     def arg_member(self, ri):
         return [f'{self.type_name} {self.c_name}{self.byte_order_comment}']
@@ -1291,7 +1293,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.p(line)
 
 
-scalars = {'u8', 'u16', 'u32', 'u64', 's32', 's64'}
+scalars = {'u8', 'u16', 'u32', 'u64', 's32', 's64', 'uint', 'sint'}
 
 direction_to_suffix = {
     'reply': '_rsp',
-- 
2.41.0


