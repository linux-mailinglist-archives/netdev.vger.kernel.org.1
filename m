Return-Path: <netdev+bounces-55990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7A180D255
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CF928195B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DC94E1B6;
	Mon, 11 Dec 2023 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6EFbV7U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E0799;
	Mon, 11 Dec 2023 08:41:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b27726369so49556245e9.0;
        Mon, 11 Dec 2023 08:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702312865; x=1702917665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVDZQUVqAXzeQUuYMs6VNWfBP7s/1BSixjGeEMDOqM8=;
        b=f6EFbV7UpOJDp8X+bC6XVlaQuj+Il+63ume91nChMXfu1vn8ojcFw8j27KTeySrQsy
         4EV2OumpO3z47MAYaUG41RSBO37sUt1P4QTRuWtujcwsxekosbLAn+aj9+XGFlJOG552
         QNzIQJQX+hlH7vG/J1JOA7+tDa4IqEHoz106WvhcbHBKRqqn3sTJJCG0qSdfGQRuE7da
         Sz4i/ipLV27sUc+MuSL+5MfVyICIQpMR9baaA5aXycAuOJq52Z6myvWbz55uzpjgJyzX
         4FMEWRAstGLuXOj47beHyh77haNtPWxfbB6N7qKRXL75/VeoTE1wDWLLCW3SSdT0hzI6
         5aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312865; x=1702917665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVDZQUVqAXzeQUuYMs6VNWfBP7s/1BSixjGeEMDOqM8=;
        b=R5DicKw7MGoRbxZLFNMNBpPcINfQdYDPMWTj2teTkb/kEw81uFxTOG/SVOZhDsZAFu
         kiD2Yjm/3QUydGNuGca8eoU9ipPKHEjdFA1Z/iMxqWB+rpP3O4KvvsUdj5rLfwSP9eGu
         Q7v6cUnkDHDuYWed2VotWurvs9/ELL6NFnvXdzNeN/mWdpkAnPmH50dood8rNNJWwSBI
         pfQd8XuP7zPDm6IxUfydBLU1z0QvAwcM0crlPzgj5n8J7H+3EnG8TXI00Q4kjoTOGtrw
         RUEjg7ugrUdD+EBIITTeS1v1NjHAKfB94Lyt+7d39pLJ8B0i7KEWZXk+fpRRdfiqc5SI
         imnA==
X-Gm-Message-State: AOJu0YypyNHMOnz6QU3X0kU/Ok2pQChxdWwJilFzdcLvjy4yWtQtpgYs
	tGY0P+jpIx3uWrk/PaTUxAH665AoJtF/gw==
X-Google-Smtp-Source: AGHT+IHlLEeMevjmBkINxHZfHMbRW7+WFsQ8pRnXbeTRi2IXhAGgLFKjWmN5eT7HwDF31FNHMmowYQ==
X-Received: by 2002:a05:600c:19d4:b0:40c:38b0:a420 with SMTP id u20-20020a05600c19d400b0040c38b0a420mr2278255wmq.33.1702312864613;
        Mon, 11 Dec 2023 08:41:04 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040c41846923sm7418679wmq.26.2023.12.11.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:41:03 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 07/11] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
Date: Mon, 11 Dec 2023 16:40:35 +0000
Message-ID: <20231211164039.83034-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211164039.83034-1-donald.hunter@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
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
---
 tools/net/ynl/lib/nlspec.py | 55 +++++++++++++++++++++++++++++++++++++
 tools/net/ynl/lib/ynl.py    | 48 ++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 92889298b197..71b445e26b58 100644
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
 
+        for elem in self.yaml['sub-messages']:
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


