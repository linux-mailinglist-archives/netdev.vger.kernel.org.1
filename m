Return-Path: <netdev+bounces-247696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAF2CFD9DB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3061630039CF
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B566314D3D;
	Wed,  7 Jan 2026 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4mR87Gg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675362EAB64
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788528; cv=none; b=ZU1HYJxg7wmhANm79G/G5AkJRLWeNkAi99MRETP6rYca74QDWJ/4A/etx2Tl7RHrRjLxXrK2FdsDAPcnrXl3jqiukAcZ9xH48J0qavTfnDfvNHasT0SwhhnH8V3FtMaa1LO7kj3pTJCoFxr7SQaA6f152hKJl+Anlko3HJ1rlH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788528; c=relaxed/simple;
	bh=DJ2gtYNJe43VxXxCCEWLFo5BwpHQ3RueTlKvvQiCjHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0dSKc+6uoPri8HD120hMyRQdHpS0zBg8B50lNEQWgqzKw7oP1Ly3+vzgQ7owWK8m41xjagKa2Y5WonLkHjk3VMaQ22ZK4sGF40z6El6bIUM4GfuDfDoVcfh84iVjGxF/rDSrEerJPtcwPVHIJklzb8gRSQm4JRfGcV/p/OdpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4mR87Gg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47755de027eso11896925e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788525; x=1768393325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McdQGJBzF/4/Bv27Rtrq5OkTY9FaBezUl9reVifz2jE=;
        b=l4mR87Gg5o8PsilLN5U0PQ4yP0rv67SjpezGozWhoOCC1i15Ytg6h301IW/WACKK6P
         iSCVpf5heoghg/8QDBykdhiRVvpJyAtn/y29xcSSqBqNFexDFZQO5AfO08CL3G9Rc+jM
         Y1X3PARDlVdPcITmw7UVbVKZryQRWi5sbXdIweCzwvKHjKLIFqc8EbSU8Vsa43NadZ4j
         zWjTfDgKuEn3HVPiBUM/6SAb0+8U+3u4WVjwkpnRMDojBkCyoyZfRJhIGmJYA8H58AUA
         JiT3CMYpTIxhhb6D06u5Czj4o0hcTxOcZK1uXyvsnBlLaSwoQpuIrM4HzEH9IWldYsqO
         Y8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788525; x=1768393325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=McdQGJBzF/4/Bv27Rtrq5OkTY9FaBezUl9reVifz2jE=;
        b=MTu7R8bK+xpMvlE8Dd74oYqygLmdPV1tarxTOnJ7MYiAdDK612pxu/U2/1YLA3SD/l
         CGFlFgvaN/yXEobClJCPhDLixhpKcSCixHpxK76hOSifdeoxIFYrAKk6sMTqjudy78iB
         LyavAV/WL1lWBq5Ky55OTTD9AwawijD9GKIdh5IoRqvrmHVZB3o/CGll/M0dgGJXPcOi
         b296/xc84O60wYW3jyM887xyPAmNUumH30SZemfpwRPa6ML8eJCHlUR4qv9TrytPeO6c
         ZeG5ju6UoaPEL9yG5l3YOpduz/hVhOG8mPHE4RXgp0h7uCzKq6iJsUtl1exFXLY1/dr7
         IyfA==
X-Forwarded-Encrypted: i=1; AJvYcCW+WpQBpSIyn+yRDkk7OLm67Aw3vaxlaTtDtAR0ulCjBf9Oek/87VDqLFJQmeRaaSU01Ld+GWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoP/tycTK3Ide19qHNkLsrjtr202iPzpeCsCg4NgwypeyKr3KL
	TCMDRvVNQ3jS2RRDH2FYkWXFCDQrvcrxz5l0DSs3zBJwoy0uQeebyfft
X-Gm-Gg: AY/fxX5X3TZfKcxhK2IFNB3C5Pj5d9miZaKSLZ/wXJXSfoPwOEPa2cW+SCBkz68G797
	SiBsR8MzVQgiuSk9o4OXv74orXNxbB5CkTUGa8+jWgAV/xt+EgUgZBgkBVB23/cypv1kHNaBdoX
	MVdTze/oUnDa/wJ1vzl/g+ljkynD1HlcY5slJZ+1aGkLczRgT9mH0QE1pG/Le1eDylJrgnAnS1g
	TuS7dOICw4KCJtViaRUPmCzlphUtPfo/0aGsaCXtC/UeYNvzpAJH08ErYEuSXgd2IsjuHymKT13
	D37Q1VfTLbmHMayVwLrmXx9iV2+wjs1KqKBE/uiNQbrkxcj5j45Kir6w52sxV8w3DCqj61DF3oD
	ylEErBQORYRZCgV4G+zuulzYtQZ9HNmDgerKYT+/WeHKAHmCTde/ekMlBmsUAVAVFwmnCF+hHuF
	DFh1FqqvzODPwezSKwORnEwseGlxJK
X-Google-Smtp-Source: AGHT+IEUP1t/JnSOvz1co+rdBIihXqQ8rvbnkbS6uY91s0oDUwrYCJZitrVJYbo4wyLxknhajEVo8Q==
X-Received: by 2002:a05:600c:1f13:b0:477:98f7:2aec with SMTP id 5b1f17b1804b1-47d84b086d7mr25246895e9.3.1767788524443;
        Wed, 07 Jan 2026 04:22:04 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:03 -0800 (PST)
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
Subject: [PATCH net-next v1 02/13] tools: ynl: fix pylint redefinition, encoding errors
Date: Wed,  7 Jan 2026 12:21:32 +0000
Message-ID: <20260107122143.93810-3-donald.hunter@gmail.com>
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

Fix pylint warnings for:

- invalid-name
- arguments-renamed
- redefined-outer-name
- unspecified-encoding
- consider-using-sys-exit

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py        | 44 ++++++++++++-------------
 tools/net/ynl/pyynl/lib/nlspec.py | 18 +++++------
 tools/net/ynl/pyynl/lib/ynl.py    | 54 +++++++++++++++----------------
 3 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 996c76be1403..41c20162f951 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -17,8 +17,8 @@ import textwrap
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
 from lib import YnlFamily, Netlink, NlError, SpecFamily
 
-sys_schema_dir='/usr/share/ynl'
-relative_schema_dir='../../../../Documentation/netlink'
+SYS_SCHEMA_DIR='/usr/share/ynl'
+RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
 
 def schema_dir():
     """
@@ -26,32 +26,32 @@ def schema_dir():
     system schema directory.
     """
     script_dir = os.path.dirname(os.path.abspath(__file__))
-    schema_dir = os.path.abspath(f"{script_dir}/{relative_schema_dir}")
-    if not os.path.isdir(schema_dir):
-        schema_dir = sys_schema_dir
-    if not os.path.isdir(schema_dir):
-        raise Exception(f"Schema directory {schema_dir} does not exist")
-    return schema_dir
+    schema_dir_ = os.path.abspath(f"{script_dir}/{RELATIVE_SCHEMA_DIR}")
+    if not os.path.isdir(schema_dir_):
+        schema_dir_ = SYS_SCHEMA_DIR
+    if not os.path.isdir(schema_dir_):
+        raise YnlException(f"Schema directory {schema_dir_} does not exist")
+    return schema_dir_
 
 def spec_dir():
     """
     Return the effective spec directory, relative to the effective
     schema directory.
     """
-    spec_dir = schema_dir() + '/specs'
-    if not os.path.isdir(spec_dir):
-        raise Exception(f"Spec directory {spec_dir} does not exist")
-    return spec_dir
+    spec_dir_ = schema_dir() + '/specs'
+    if not os.path.isdir(spec_dir_):
+        raise YnlException(f"Spec directory {spec_dir_} does not exist")
+    return spec_dir_
 
 
 class YnlEncoder(json.JSONEncoder):
     """A custom encoder for emitting JSON with ynl-specific instance types"""
-    def default(self, obj):
-        if isinstance(obj, bytes):
-            return bytes.hex(obj)
-        if isinstance(obj, set):
-            return list(obj)
-        return json.JSONEncoder.default(self, obj)
+    def default(self, o):
+        if isinstance(o, bytes):
+            return bytes.hex(o)
+        if isinstance(o, set):
+            return list(o)
+        return json.JSONEncoder.default(self, o)
 
 
 def print_attr_list(ynl, attr_names, attr_set, indent=2):
@@ -196,11 +196,11 @@ def main():
             SpecFamily(spec, args.schema)
         except Exception as error:
             print(error)
-            exit(1)
+            sys.exit(1)
         return
 
     if args.family: # set behaviour when using installed specs
-        if args.schema is None and spec.startswith(sys_schema_dir):
+        if args.schema is None and spec.startswith(SYS_SCHEMA_DIR):
             args.schema = '' # disable schema validation when installed
         if args.process_unknown is None:
             args.process_unknown = True
@@ -224,7 +224,7 @@ def main():
         op = ynl.msgs.get(args.list_attrs)
         if not op:
             print(f'Operation {args.list_attrs} not found')
-            exit(1)
+            sys.exit(1)
 
         print(f'Operation: {op.name}')
         print(op.yaml['doc'])
@@ -259,7 +259,7 @@ def main():
                 output(msg)
     except NlError as e:
         print(e)
-        exit(1)
+        sys.exit(1)
     except KeyboardInterrupt:
         pass
     except BrokenPipeError:
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 2ffeccf0b99b..c3113952c417 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -10,7 +10,7 @@ specifications.
 import collections
 import importlib
 import os
-import yaml
+import yaml as pyyaml
 
 
 # To be loaded dynamically as needed
@@ -313,11 +313,11 @@ class SpecSubMessage(SpecElement):
 
         self.formats = collections.OrderedDict()
         for elem in self.yaml['formats']:
-            format = self.new_format(family, elem)
-            self.formats[format.value] = format
+            msg_format = self.new_format(family, elem)
+            self.formats[msg_format.value] = msg_format
 
-    def new_format(self, family, format):
-        return SpecSubMessageFormat(family, format)
+    def new_format(self, family, msg_format):
+        return SpecSubMessageFormat(family, msg_format)
 
 
 class SpecSubMessageFormat(SpecElement):
@@ -436,7 +436,7 @@ class SpecFamily(SpecElement):
         kernel_family   dict of kernel family attributes
     """
     def __init__(self, spec_path, schema_path=None, exclude_ops=None):
-        with open(spec_path, "r") as stream:
+        with open(spec_path, "r", encoding='utf-8') as stream:
             prefix = '# SPDX-License-Identifier: '
             first = stream.readline().strip()
             if not first.startswith(prefix):
@@ -444,7 +444,7 @@ class SpecFamily(SpecElement):
             self.license = first[len(prefix):]
 
             stream.seek(0)
-            spec = yaml.safe_load(stream)
+            spec = pyyaml.safe_load(stream)
 
         self._resolution_list = []
 
@@ -460,8 +460,8 @@ class SpecFamily(SpecElement):
         if schema_path:
             global jsonschema
 
-            with open(schema_path, "r") as stream:
-                schema = yaml.safe_load(stream)
+            with open(schema_path, "r", encoding='utf-8') as stream:
+                schema = pyyaml.safe_load(stream)
 
             if jsonschema is None:
                 jsonschema = importlib.import_module("jsonschema")
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 27169ff8dafc..8689ad25055b 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -155,22 +155,22 @@ class NlAttr:
 
     @classmethod
     def get_format(cls, attr_type, byte_order=None):
-        format = cls.type_formats[attr_type]
+        format_ = cls.type_formats[attr_type]
         if byte_order:
-            return format.big if byte_order == "big-endian" \
-                else format.little
-        return format.native
+            return format_.big if byte_order == "big-endian" \
+                else format_.little
+        return format_.native
 
     def as_scalar(self, attr_type, byte_order=None):
-        format = self.get_format(attr_type, byte_order)
-        return format.unpack(self.raw)[0]
+        format_ = self.get_format(attr_type, byte_order)
+        return format_.unpack(self.raw)[0]
 
     def as_auto_scalar(self, attr_type, byte_order=None):
         if len(self.raw) != 4 and len(self.raw) != 8:
             raise Exception(f"Auto-scalar len payload be 4 or 8 bytes, got {len(self.raw)}")
         real_type = attr_type[0] + str(len(self.raw) * 8)
-        format = self.get_format(real_type, byte_order)
-        return format.unpack(self.raw)[0]
+        format_ = self.get_format(real_type, byte_order)
+        return format_.unpack(self.raw)[0]
 
     def as_strz(self):
         return self.raw.decode('ascii')[:-1]
@@ -178,9 +178,9 @@ class NlAttr:
     def as_bin(self):
         return self.raw
 
-    def as_c_array(self, type):
-        format = self.get_format(type)
-        return [ x[0] for x in format.iter_unpack(self.raw) ]
+    def as_c_array(self, c_type):
+        format_ = self.get_format(c_type)
+        return [ x[0] for x in format_.iter_unpack(self.raw) ]
 
     def __repr__(self):
         return f"[type:{self.type} len:{self._len}] {self.raw}"
@@ -256,8 +256,8 @@ class NlMsg:
         policy = {}
         for attr in NlAttrs(raw):
             if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
-                type = attr.as_scalar('u32')
-                policy['type'] = Netlink.AttrType(type).name
+                type_ = attr.as_scalar('u32')
+                policy['type'] = Netlink.AttrType(type_).name
             elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
                 policy['min-value'] = attr.as_scalar('s64')
             elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
@@ -612,8 +612,8 @@ class YnlFamily(SpecFamily):
             elif isinstance(value, dict) and attr.struct_name:
                 attr_payload = self._encode_struct(attr.struct_name, value)
             elif isinstance(value, list) and attr.sub_type in NlAttr.type_formats:
-                format = NlAttr.get_format(attr.sub_type)
-                attr_payload = b''.join([format.pack(x) for x in value])
+                format_ = NlAttr.get_format(attr.sub_type)
+                attr_payload = b''.join([format_.pack(x) for x in value])
             else:
                 raise Exception(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
@@ -622,8 +622,8 @@ class YnlFamily(SpecFamily):
                 attr_type = attr["type"][0] + ('32' if scalar.bit_length() <= 32 else '64')
             else:
                 attr_type = attr["type"]
-            format = NlAttr.get_format(attr_type, attr.byte_order)
-            attr_payload = format.pack(scalar)
+            format_ = NlAttr.get_format(attr_type, attr.byte_order)
+            attr_payload = format_.pack(scalar)
         elif attr['type'] in "bitfield32":
             scalar_value = self._get_scalar(attr, value["value"])
             scalar_selector = self._get_scalar(attr, value["selector"])
@@ -915,8 +915,8 @@ class YnlFamily(SpecFamily):
                     else:
                         size += m.len
                 else:
-                    format = NlAttr.get_format(m.type, m.byte_order)
-                    size += format.size
+                    format_ = NlAttr.get_format(m.type, m.byte_order)
+                    size += format_.size
             return size
         else:
             return 0
@@ -931,17 +931,17 @@ class YnlFamily(SpecFamily):
                 offset += m.len
             elif m.type == 'binary':
                 if m.struct:
-                    len = self._struct_size(m.struct)
-                    value = self._decode_struct(data[offset : offset + len],
+                    len_ = self.struct_size(m.struct)
+                    value = self._decode_struct(data[offset : offset + len_],
                                                 m.struct)
-                    offset += len
+                    offset += len_
                 else:
                     value = data[offset : offset + m.len]
                     offset += m.len
             else:
-                format = NlAttr.get_format(m.type, m.byte_order)
-                [ value ] = format.unpack_from(data, offset)
-                offset += format.size
+                format_ = NlAttr.get_format(m.type, m.byte_order)
+                [ value ] = format_.unpack_from(data, offset)
+                offset += format_.size
             if value is not None:
                 if m.enum:
                     value = self._decode_enum(value, m)
@@ -970,8 +970,8 @@ class YnlFamily(SpecFamily):
             else:
                 if value is None:
                     value = 0
-                format = NlAttr.get_format(m.type, m.byte_order)
-                attr_payload += format.pack(value)
+                format_ = NlAttr.get_format(m.type, m.byte_order)
+                attr_payload += format_.pack(value)
         return attr_payload
 
     def _formatted_string(self, raw, display_hint):
-- 
2.52.0


