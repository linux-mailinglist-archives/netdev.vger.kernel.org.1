Return-Path: <netdev+bounces-73013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380285A9E3
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F5A289324
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F347A4D;
	Mon, 19 Feb 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="enOehAiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127B4594D
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363552; cv=none; b=E9jBsObzh3IEWsucPxV8BXVvM/uoUPzC765p6gSJaqjn7ockgnRRQEzj324zYoUbWfbbWbJzCRe8Oyyht5MJGkpTlpk27yMlIzcBcH9/IpLS0jzGyN1+Nm/z6GOvk0WTSNGQpMohzk+DVXKyCLKSqJQEWIMvwNsXp/5p7GiEFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363552; c=relaxed/simple;
	bh=5fJUJEOkfTgvUJvW1qGZuBMvBdHBIzIKDwLY349Xc3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxDdXkVY5s+QbRhOdcYqs1pkmFiDHBZJyfIlNNUoy3KJK+RvG1Kap2N2iENO2RcFdNrTvrOL8hFJowEEh8nxr/hfX57RiYmv5l0ZNtE2wRz5ttDF/kLfStXmDd6Dyevkc7AOdGkB4faaujMg8ytxOrFDXAUdlZrkscAkrZnEy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=enOehAiJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41265d2f7acso9316075e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363549; x=1708968349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXQz0tUbRrPe2b96ddZ22n+oZureWQtegw85hUbDA6Q=;
        b=enOehAiJrTjiRbqLhKu93UBOS1UrrmL6r3EzucZuTA141JL2gqV2kuNYrBXeziGqu9
         BCSN+OO1WZeRIZKdCgQE+NAuXaut6JGVUJ43Kz68/xclG3FwcHeP9IUo2hkCH5ghAtnz
         3H9mT73H7deIfy2TJDj7mLsdodEXOAP62MhNikh3DZprBu5K52nb0yyGJ5RPFSUZQJsy
         /XVFpwOX91JwMsAISyMofALQRrwSIE6m3Puqs+l30OiZapAJLYnyBiGcjZ9wnQVSHVkB
         732yzJU8kOIdI07aFrBAZgezgSBh1Al13LcKEObGp9fw4eYTT1MkIeN/4v3xEUZEVU6F
         Kd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363549; x=1708968349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXQz0tUbRrPe2b96ddZ22n+oZureWQtegw85hUbDA6Q=;
        b=TBF+8VHij6jqrXVjbTqpirFR87yf7iuxoiSvsQHRecTztWnA+REqeQf8qSgstiYfqO
         h8Ww/tjFj649oDHwPkyBArPrcue7G9F+AcaU2DgPeQuguhJqqiellxJghq+sO4ffouDL
         rxsT2p31Nf/ZwQijgEcjciHpYLXU/+MO2CVSJL92nnW8uEORZbXeJrZgRGI0+j5xikTI
         jtQJ4DC4C374TUtub4pImJZIvyviibIzCo1M5ATzJ26CXjw7aafVCJQ4/55zg+hsWDS0
         UDMB4RnkyTvRaQpSx02zo2Bw73j+4PPMBl11HmkEI66qO7Yv6HgDCmRjLt+07PhR0Z22
         DBVw==
X-Gm-Message-State: AOJu0YxW0nQkYi+dKBwz3vNyMWVoZxtpV8d1po8BGYBkif5N7qxTGD+T
	uTenfEG4S7XybED0SLbH07MG1+5KjAss2mKJIvW1vkCUjmTouXPR8k/Olr1jYYH+XPWNap8Y9Ax
	C
X-Google-Smtp-Source: AGHT+IFnQj0Cdzt/isZGwSfEDgXmFzDfTTU4dmGMMelPPyTOjQGGVDIgM4ix8T9DMyf1Cy7YLfN3oA==
X-Received: by 2002:a05:600c:3c8a:b0:411:9508:e237 with SMTP id bg10-20020a05600c3c8a00b004119508e237mr10765574wmb.19.1708363549196;
        Mon, 19 Feb 2024 09:25:49 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id jp5-20020a05600c558500b004126732390asm3024910wmb.37.2024.02.19.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:48 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 06/13] tools: ynl: introduce attribute-replace for sub-message
Date: Mon, 19 Feb 2024 18:25:22 +0100
Message-ID: <20240219172525.71406-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

For devlink param, param-value-data attr is used by kernel to fill
different attribute type according to param-type attribute value.

Currently the sub-message feature allows spec to embed custom message
selected by another attribute. The sub-message is then nested inside the
attr of sub-message type.

Benefit from the sub-message feature and extend it. Introduce
attribute-replace spec flag by which the spec indicates that ynl should
consider sub-message as not nested in the original attribute, but rather
to consider the original attribute as the sub-message right away.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-legacy.yaml   |  4 +++
 Documentation/netlink/netlink-raw.yaml        |  4 +++
 .../netlink/genetlink-legacy.rst              | 25 ++++++++++++++++++
 tools/net/ynl/lib/nlspec.py                   |  6 +++++
 tools/net/ynl/lib/ynl.py                      | 26 ++++++++++++++-----
 5 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 6cb50e2cc021..77d89f81c71f 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -328,6 +328,10 @@ properties:
                   Name of the attribute space from which to resolve attributes
                   in the sub message.
                 type: string
+              attribute-replace:
+                description: |
+                  Replace the parent nested attribute with attribute set
+                type: boolean
 
   operations:
     description: Operations supported by the protocol.
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index cc38b026c451..e32660fbe6c3 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -346,6 +346,10 @@ properties:
                   Name of the attribute space from which to resolve attributes
                   in the sub message.
                 type: string
+              attribute-replace:
+                description: |
+                  Replace the parent nested attribute with attribute set
+                type: boolean
 
   operations:
     description: Operations supported by the protocol.
diff --git a/Documentation/userspace-api/netlink/genetlink-legacy.rst b/Documentation/userspace-api/netlink/genetlink-legacy.rst
index 7126b650090e..a9ccbfbb4a8d 100644
--- a/Documentation/userspace-api/netlink/genetlink-legacy.rst
+++ b/Documentation/userspace-api/netlink/genetlink-legacy.rst
@@ -381,3 +381,28 @@ alongside a sub-message selector and also in a top level ``attribute-set``, then
 the selector will be resolved using the value 'closest' to the selector. If the
 value is not present in the message at the same level as defined in the spec
 then this is an error.
+
+Some users, like devlink param, fill different attribute type according to
+selector attribute value. ``replace-attribute`` set to ``true`` indicates,
+that sub-message is not nested inside the attribute, but rather replacing
+the attribute. This allows to treat the attribute type differently according
+to the selector:
+
+.. code-block:: yaml
+
+  sub-messages:
+    -
+      name: dl-param-value-data-msg
+      formats:
+        -
+          value: u32
+          attribute-set: dl-param-value-data-u32-attrs
+          attribute-replace: true
+        -
+          value: string
+          attribute-set: dl-param-value-data-string-attrs
+          attribute-replace: true
+        -
+          value: bool
+          attribute-set: dl-param-value-data-bool-attrs
+          attribute-replace: true
diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 5e48ee0fb8b4..280d50e9079c 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -237,6 +237,9 @@ class SpecAttrSet(SpecElement):
     def items(self):
         return self.attrs.items()
 
+    def keys(self):
+        return self.attrs.keys()
+
 
 class SpecStructMember(SpecElement):
     """Struct member attribute
@@ -318,6 +321,8 @@ class SpecSubMessageFormat(SpecElement):
         value         attribute value to match against type selector
         fixed_header  string, name of fixed header, or None
         attr_set      string, name of attribute set, or None
+        attr_replace  bool, indicates replacement of parent attribute with
+                      attr_set decode, or None
     """
     def __init__(self, family, yaml):
         super().__init__(family, yaml)
@@ -325,6 +330,7 @@ class SpecSubMessageFormat(SpecElement):
         self.value = yaml.get('value')
         self.fixed_header = yaml.get('fixed-header')
         self.attr_set = yaml.get('attribute-set')
+        self.attr_replace = yaml.get('attribute-replace')
 
 
 class SpecOperation(SpecElement):
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d2ea1571d00c..8591e6bfe40b 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -507,11 +507,16 @@ class YnlFamily(SpecFamily):
                 attr_payload += self._encode_struct(msg_format.fixed_header, value)
             if msg_format.attr_set:
                 if msg_format.attr_set in self.attr_sets:
-                    nl_type |= Netlink.NLA_F_NESTED
-                    sub_attrs = SpaceAttrs(msg_format.attr_set, value, search_attrs)
-                    for subname, subvalue in value.items():
-                        attr_payload += self._add_attr(msg_format.attr_set,
-                                                       subname, subvalue, sub_attrs)
+                    if msg_format.attr_replace:
+                        first_attr_name = list(self.attr_sets[msg_format.attr_set].keys())[0]
+                        return self._add_attr(msg_format.attr_set, first_attr_name,
+                                              value, search_attrs)
+                    else:
+                        nl_type |= Netlink.NLA_F_NESTED
+                        sub_attrs = SpaceAttrs(msg_format.attr_set, value, search_attrs)
+                        for subname, subvalue in value.items():
+                            attr_payload += self._add_attr(msg_format.attr_set,
+                                                           subname, subvalue, sub_attrs)
                 else:
                     raise Exception(f"Unknown attribute-set '{msg_format.attr_set}'")
         else:
@@ -600,8 +605,17 @@ class YnlFamily(SpecFamily):
             offset = self._struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
-                subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
+                if msg_format.attr_replace:
+                    attrs = [attr]
+                else:
+                    attrs = NlAttrs(attr.raw, offset);
+                subdict = self._decode(attrs, msg_format.attr_set)
                 decoded.update(subdict)
+                if msg_format.attr_replace:
+                    try:
+                        decoded = decoded[attr_spec.name]
+                    except KeyError:
+                        raise Exception(f"Attribute-set '{attr_space}' does not contain '{attr_spec.name}'")
             else:
                 raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
         return decoded
-- 
2.43.2


