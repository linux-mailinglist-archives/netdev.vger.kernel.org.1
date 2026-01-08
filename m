Return-Path: <netdev+bounces-248151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1248D045D0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 147D2306EEDE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7192C1589;
	Thu,  8 Jan 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HItajG15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11483254B19
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888840; cv=none; b=PtWE7Z+pQk31IcFS/CEzkFKRECPp13XY+IoEzmRsIa9fN+1kcF1R7a9YYxlcA126E+aSIdloKBNyYGArbclRMBF1VtX8o4G158znepaXIou1vSajYkOnPgWT2d80YZLfgWtwLzGSkdV+NxER/u0fPBmSe2kMrA7kr9qIEPaQKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888840; c=relaxed/simple;
	bh=XNoSHXE6e2aUIwE/0ArkG/YvVxeEgykpYvN+c0ou8BY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnmOB6/l9i2zWg/pCL6+za8aa97xGHf6zLnu6Bvpr1pddFx5vLcIXLZqHNPyKLQZaUGpsxP1c5ayLk5NKDLTK7E0lnKQiDOr1G76Hw9aDnQja+bSILAJNii9ZBQU2e5VUJ3RuDFkpuElwj1z4Fc2itJ3ARcxHAbPAZ+lj0li000=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HItajG15; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2670932so535660f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888836; x=1768493636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRFZkMaDCVBKrn+74q+JiGh38/GRN50SmUXfwLk7rAk=;
        b=HItajG156Ni5tUm6tWeNaTD/HWeACY76wcG1QV7dLbZ4dIOkZl1RXSI+oM/FdpEGss
         3sztrQgLDUvAnXWdtr8EpfbcBfuuwv4iRJsL4iKTWvTPFHE9K3O2a0PlCVAL502VnmrY
         7FjeEf5tw5OwdJkTUjEkUq5coRUMghCXLlu08gf2Y2GGZtEASYk+LV6APgwNfNBKBUCI
         cZbKRIHHAV7Ez+/3adF2yJsESrQ/sHPI00XDGXfHdU1TV41oWl5YL0qOQuCiaiArWQ2I
         TLZO1T0w7SRhTGqknI1RVeFryt4AJSgvJfAOzkQPY8aB/K/ICFRHfGYmijQ7SzSSJkiN
         JkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888836; x=1768493636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRFZkMaDCVBKrn+74q+JiGh38/GRN50SmUXfwLk7rAk=;
        b=sZyO7wMo6NrKrEkt92pp2aH54jKwON6AykpxHwdzkKqtLwevrV4W3CPX6sbTiPklbA
         Bl9ckT8Fp0zwZpaa5qReQwrQfDuUYBGUobUMrX7Cq2DWt9mYBOLdixF7fIi9ePi/hLUl
         0HuPrdSY/Y8zugjuZIF3TWcExq4X+snd/Kzk9WPhQR/pBOVV2ad0egX6c04BQuqkIrP+
         fZ9Edf0s4XK1UHBmM7974c4aX5HWl7MLje/MatcyBNXr8Ong93fJ64z5ygANFf8lcsdf
         +Iyu4ZQsbQ9gK5sZNdl1KKzqg0UxIROahaUZgqZKPSAgL1TboahlQ1RSwR1HdfGsc2Wf
         EOmA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/MLfhRQD1F+apHUNPmMlbm2JpFVv84YBoeOi5F5Cl52uTRYOcBdq7hc8a7BMEYu5VMo2JCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb2xuQfv565WwUltVQmAx1hbKWAoJQIFdiZYpCFAgDpmTc8paI
	kXwQHm0j0CbLpd/aox9yhYoqhSek1cMCsVLM7KedYGtFPfq4aRkgwrN0
X-Gm-Gg: AY/fxX4EU63DjTFI8pjrNtLJgaIbAMtV0v4WJTJhq73B8fcp9ImpUaGBKimQBx/1sf/
	FNE0bR8Q7rvSRBo2tLz2TApvpftFlyQKPQ3aM1yLAqX/vdsnOEtzuYqW3IHscUgBIohdM7tXIHD
	LKqQHEdM67OxZKdk3FjGcCFwE8YvWVbES7GxKX+NUSijDXjUzLw9K+ZicLkwxYZq5aHqGNZryRv
	lz3o7mGUGP/zpGWx5N4VBqQg2/EBGDw40KYbcpVuPc9gau+37bmnG0mGtqu/BbgkQoGdOHAhMD6
	o5EQgij3aw5xn936U+h/95EX9kgED21iyYA1VRGiy02IKG31JCFhrfzC641S2iIevAiXq+MgV+7
	p53BTGnX3ttwMAU9rNOLjEw1tsgzXNQ1A0h1JX4sUh9s8pNk5DTBQk+bjGb+1vEFJMFcJUwpkwz
	SL7b2zd16BJTlmXfcncY5ZF9YzHohUOVeAmfrYC68=
X-Google-Smtp-Source: AGHT+IF0Ai975hJRDpQBLluIpIUumFGCzYS6iiqlKInfsQuW47vwPpSGDsUl2BtUZZtsEQgTXV08Ow==
X-Received: by 2002:a05:6000:2289:b0:430:b100:f591 with SMTP id ffacd0b85a97d-432c3794e96mr8391260f8f.28.1767888836253;
        Thu, 08 Jan 2026 08:13:56 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:13:55 -0800 (PST)
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
Subject: [PATCH net-next v2 02/13] tools: ynl: fix pylint redefinition, encoding errors
Date: Thu,  8 Jan 2026 16:13:28 +0000
Message-ID: <20260108161339.29166-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
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
index 996c76be1403..37efa8c4f0e2 100755
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
+        raise Exception(f"Schema directory {schema_dir_} does not exist")
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
+        raise Exception(f"Spec directory {spec_dir_} does not exist")
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
index 27169ff8dafc..78579e495351 100644
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
+                    len_ = self._struct_size(m.struct)
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


