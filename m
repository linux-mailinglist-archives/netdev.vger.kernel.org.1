Return-Path: <netdev+bounces-56620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE980FA08
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE081C20DC4
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677364707;
	Tue, 12 Dec 2023 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNmH8MIS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A92AC;
	Tue, 12 Dec 2023 14:16:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3363880e9f3so96954f8f.3;
        Tue, 12 Dec 2023 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419392; x=1703024192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7t4yVV5QBXqcQdynVNr7yIS1QbfmSEMCw7UlTR3l/0=;
        b=GNmH8MIS+4we2/Hfn42wxSbcqgUKrs04LTYjCuaqXVoVtN0BzD3F5ukPqonQBIok+w
         UEjYqp680iSnYNMkSIRsXPIPeHQ1y3BmnpJ7rWU4oQPXBlZoAI56ayvbJAoU29QN4FDj
         BL/WVzjcxWb3xKBJRX+3RNwjSx7470EVVfeouUV4xhGpeAsmpx/8YW9xmQkOoKsgngSt
         mpY3CyeniDclY6wp4pkrK7N1JSWx+aZ9iXbpnVFR+GvHN4jxgQMznGB+Tc58t+8J54rf
         G2ljnCwGPEVyVsfg6FpAttoHtzdKvxWUCRKdsG7sScuAzaKKA8W7kfeMXYhJe68273nu
         LV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419392; x=1703024192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7t4yVV5QBXqcQdynVNr7yIS1QbfmSEMCw7UlTR3l/0=;
        b=oCca8+0APL8XSbatR9lCD+XelEtQKYFD1o8Ti7xP2gLT1qzuyGv8qGfx5Ht1lc1UNo
         53RhsciYxUl603750AZEDeMPbgjTeV37p6EojsZqRCJQrwrDHt9gUSVxru0U32EK26gi
         YXDO209GhdcMtLqwnsYB/7kUyIR1LWjw8kiFvnUMPZ9cx6HgthfTzakpTsf2HwIFEuOB
         mkN112DUfvX3VQ7cMM0CLHrYzrpyLyDzLK4FOpbRJnKdH7cGdVgyLUMYdy6YiMn6T6mU
         l+4vaHtuOnb6/rbLY9ApqXUDe0ZXCEFlWS33xhXW6qXg+CUquSR3tRbOlsbb76nTWnsx
         Rcsw==
X-Gm-Message-State: AOJu0Yx0+GOW0mgwO7DdsFE8cGkhrx1U55wyxvSPeXnoR7ih83aNB2A1
	Zz1iyXqPRfEaLKLrfMrY/jMPvDmMIucmpQ==
X-Google-Smtp-Source: AGHT+IG0E0/+bwdqUnAYju6F6qXMAofn0q08RhVLPIPyT3cRduvCtqmnI8ZXcenKy2FFb82lRf2N5g==
X-Received: by 2002:a5d:4bc6:0:b0:333:3bc1:1fb3 with SMTP id l6-20020a5d4bc6000000b003333bc11fb3mr3940709wrt.66.1702419391707;
        Tue, 12 Dec 2023 14:16:31 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:a1a0:2c27:44f7:b972])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm11680482wrt.22.2023.12.12.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:30 -0800 (PST)
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
Subject: [PATCH net-next v3 04/13] tools/net/ynl: Add 'sub-message' attribute decoding to ynl
Date: Tue, 12 Dec 2023 22:15:43 +0000
Message-ID: <20231212221552.3622-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212221552.3622-1-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
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


