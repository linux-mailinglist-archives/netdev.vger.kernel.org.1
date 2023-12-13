Return-Path: <netdev+bounces-57094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5188121DD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CFB1C2127B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7C78184D;
	Wed, 13 Dec 2023 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kkjb+wHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B711A;
	Wed, 13 Dec 2023 14:42:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-336353782efso1672343f8f.0;
        Wed, 13 Dec 2023 14:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507324; x=1703112124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXgKA8gwtJKvKZlcvRxqLAZNlEcXvz1ltdQN8JnvyAs=;
        b=Kkjb+wHy9bitSFE4Tmml0Z+YJBVlLgX2NVn0XHbgoIGcXv2q0ZVNKfyTwPucOchQRY
         2FpQGDWPLA6t5YZ8uOY/dH1nfHIO2/b2HcaDajndjJTrHuewuFmejfNxJM5oERrqVThX
         4Fxq99uVFVKLH3f3KpgVH9b4b49LUbi9I+ea4MK2DVkH2rVvQPDs+oMUdFsGXHHrBZ1+
         sgrOq2NnAKEBDtmji8/xfCzjXdrCtIGD8lHVz9TYZyBpiil9W6ns4OfW1xb2aNnty7ZO
         oG9UcvDt+9iTFfk8YANWuXQTFaRK+xbMNm6vlsFwvOPvOlFMLML2Spgau8hScGm7w1vt
         2yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507324; x=1703112124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXgKA8gwtJKvKZlcvRxqLAZNlEcXvz1ltdQN8JnvyAs=;
        b=tgMTTbxaDyeyK8Mvg3hkIrmE1YEbvc7hyKEITgI1II1aGd2iPEf4kmzx2e7qoTtvQw
         2lTVlaG8ck/bv3r1DV4JgDI5yU/Hc1nMaelDzwWlG2yoUzkl+OKUPZAr29RYfOS8htEk
         Q0tkZDEbJsfqQHXwR6fM0+SS+K/TJS43Eeg4k5wf/58xMuaM/oSfqMpqbtRimDRxPtRQ
         AfEijyKHDwl2UMa+GhKwHTtj9Jw9g9G9qOyN1Y33DdWIudp18UEiDQAgRfK5epNRHIFz
         iFD1Dd74g01euTPI9LwBB088i5ob2El0b+F92TPU7A/YHESj6V4n8NwG4vC0SwpoNXwl
         zXqA==
X-Gm-Message-State: AOJu0YwHsBycVFcMg0Zt9lsPPpBUIVCy/MsgMgg44ulEaKNgsbuJratp
	Dmr+KhxuFVWhaDQ0/eB6xcWGq8rmvg6P5w==
X-Google-Smtp-Source: AGHT+IGV8ppU2ujWkuODCQRtNhyZtSSrES026oTOFGx2KV6pnT94LiLoixpYC3eGputqEvxEwmnQdQ==
X-Received: by 2002:a5d:65cf:0:b0:333:2fd2:5207 with SMTP id e15-20020a5d65cf000000b003332fd25207mr4813389wrw.128.1702507324110;
        Wed, 13 Dec 2023 14:42:04 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id c12-20020a5d4f0c000000b00336442b3e80sm998562wru.78.2023.12.13.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:42:03 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v4 04/13] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
Date: Wed, 13 Dec 2023 22:41:37 +0000
Message-ID: <20231213224146.94560-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213224146.94560-1-donald.hunter@gmail.com>
References: <20231213224146.94560-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the 'sub-message' attribute type in ynl.

Encode support is not yet implemented. Support for sub-message selectors
at a different nest level from the key attribute is not yet supported.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/nlspec.py | 55 +++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.py    | 48 ++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 92889298b197..44f13e383e8a 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -158,6 +158,9 @@ class SpecAttr(SpecElement):
         len           integer, optional byte length of binary types
         display_hint  string, hint to help choose format specifier
                       when displaying the value
+        sub_message   string, name of sub message type
+        selector      string, name of attribute used to select
+                      sub-message type
 
         is_auto_scalar bool, attr is a variable-size scalar
     """
@@ -173,6 +176,8 @@ class SpecAttr(SpecElement):
         self.byte_order = yaml.get('byte-order')
         self.len = yaml.get('len')
         self.display_hint = yaml.get('display-hint')
+        self.sub_message = yaml.get('sub-message')
+        self.selector = yaml.get('selector')
 
         self.is_auto_scalar = self.type == "sint" or self.type == "uint"
 
@@ -278,6 +283,47 @@ class SpecStruct(SpecElement):
         return self.members.items()
 
 
+class SpecSubMessage(SpecElement):
+    """ Netlink sub-message definition
+
+    Represents a set of sub-message formats for polymorphic nlattrs
+    that contain type-specific sub messages.
+
+    Attributes:
+        name     string, name of sub-message definition
+        formats  dict of sub-message formats indexed by match value
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+
+        self.formats = collections.OrderedDict()
+        for elem in self.yaml['formats']:
+            format = self.new_format(family, elem)
+            self.formats[format.value] = format
+
+    def new_format(self, family, format):
+        return SpecSubMessageFormat(family, format)
+
+
+class SpecSubMessageFormat(SpecElement):
+    """ Netlink sub-message definition
+
+    Represents a set of sub-message formats for polymorphic nlattrs
+    that contain type-specific sub messages.
+
+    Attributes:
+        value         attribute value to match against type selector
+        fixed_header  string, name of fixed header, or None
+        attr_set      string, name of attribute set, or None
+    """
+    def __init__(self, family, yaml):
+        super().__init__(family, yaml)
+
+        self.value = yaml.get('value')
+        self.fixed_header = yaml.get('fixed-header')
+        self.attr_set = yaml.get('attribute-set')
+
+
 class SpecOperation(SpecElement):
     """Netlink Operation
 
@@ -365,6 +411,7 @@ class SpecFamily(SpecElement):
 
         attr_sets  dict of attribute sets
         msgs       dict of all messages (index by name)
+        sub_msgs   dict of all sub messages (index by name)
         ops        dict of all valid requests / responses
         ntfs       dict of all async events
         consts     dict of all constants/enums
@@ -405,6 +452,7 @@ class SpecFamily(SpecElement):
             jsonschema.validate(self.yaml, schema)
 
         self.attr_sets = collections.OrderedDict()
+        self.sub_msgs = collections.OrderedDict()
         self.msgs = collections.OrderedDict()
         self.req_by_value = collections.OrderedDict()
         self.rsp_by_value = collections.OrderedDict()
@@ -441,6 +489,9 @@ class SpecFamily(SpecElement):
     def new_struct(self, elem):
         return SpecStruct(self, elem)
 
+    def new_sub_message(self, elem):
+        return SpecSubMessage(self, elem);
+
     def new_operation(self, elem, req_val, rsp_val):
         return SpecOperation(self, elem, req_val, rsp_val)
 
@@ -529,6 +580,10 @@ class SpecFamily(SpecElement):
             attr_set = self.new_attr_set(elem)
             self.attr_sets[elem['name']] = attr_set
 
+        for elem in self.yaml.get('sub-messages', []):
+            sub_message = self.new_sub_message(elem)
+            self.sub_msgs[sub_message.name] = sub_message
+
         if self.msg_id_model == 'unified':
             self._dictify_ops_unified()
         elif self.msg_id_model == 'directional':
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 5c48f0c9713c..a69fb0c9f728 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -170,10 +170,9 @@ class NlAttr:
 
 
 class NlAttrs:
-    def __init__(self, msg):
+    def __init__(self, msg, offset=0):
         self.attrs = []
 
-        offset = 0
         while offset < len(msg):
             attr = NlAttr(msg, offset)
             offset += attr.full_len
@@ -371,8 +370,8 @@ class NetlinkProtocol:
         fixed_header_size = 0
         if ynl:
             op = ynl.rsp_by_value[msg.cmd()]
-            fixed_header_size = ynl._fixed_header_size(op)
-        msg.raw_attrs = NlAttrs(msg.raw[fixed_header_size:])
+            fixed_header_size = ynl._fixed_header_size(op.fixed_header)
+        msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
     def get_mcast_id(self, mcast_name, mcast_groups):
@@ -549,6 +548,37 @@ class YnlFamily(SpecFamily):
         else:
             rsp[name] = [decoded]
 
+    def _resolve_selector(self, attr_spec, vals):
+        sub_msg = attr_spec.sub_message
+        if sub_msg not in self.sub_msgs:
+            raise Exception(f"No sub-message spec named {sub_msg} for {attr_spec.name}")
+        sub_msg_spec = self.sub_msgs[sub_msg]
+
+        selector = attr_spec.selector
+        if selector not in vals:
+            raise Exception(f"There is no value for {selector} to resolve '{attr_spec.name}'")
+        value = vals[selector]
+        if value not in sub_msg_spec.formats:
+            raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
+
+        spec = sub_msg_spec.formats[value]
+        return spec
+
+    def _decode_sub_msg(self, attr, attr_spec, rsp):
+        msg_format = self._resolve_selector(attr_spec, rsp)
+        decoded = {}
+        offset = 0
+        if msg_format.fixed_header:
+            decoded.update(self._decode_fixed_header(attr, msg_format.fixed_header));
+            offset = self._fixed_header_size(msg_format.fixed_header)
+        if msg_format.attr_set:
+            if msg_format.attr_set in self.attr_sets:
+                subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
+                decoded.update(subdict)
+            else:
+                raise Exception(f"Unknown attribute-set '{attr_space}' when decoding '{attr_spec.name}'")
+        return decoded
+
     def _decode(self, attrs, space):
         if space:
             attr_space = self.attr_sets[space]
@@ -586,6 +616,8 @@ class YnlFamily(SpecFamily):
                     value = self._decode_enum(value, attr_spec)
                     selector = self._decode_enum(selector, attr_spec)
                 decoded = {"value": value, "selector": selector}
+            elif attr_spec["type"] == 'sub-message':
+                decoded = self._decode_sub_msg(attr, attr_spec, rsp)
             else:
                 if not self.process_unknown:
                     raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
@@ -626,16 +658,16 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set))
-        offset = 20 + self._fixed_header_size(op)
+        offset = 20 + self._fixed_header_size(op.fixed_header)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'])
         if path:
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _fixed_header_size(self, op):
-        if op.fixed_header:
-            fixed_header_members = self.consts[op.fixed_header].members
+    def _fixed_header_size(self, name):
+        if name:
+            fixed_header_members = self.consts[name].members
             size = 0
             for m in fixed_header_members:
                 format = NlAttr.get_format(m.type, m.byte_order)
-- 
2.42.0


