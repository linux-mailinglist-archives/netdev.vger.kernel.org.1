Return-Path: <netdev+bounces-248152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF34D04838
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 88BCA30F733A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C60724DD09;
	Thu,  8 Jan 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihRIMq3v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D042C326D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888844; cv=none; b=LTgutaCv94TGj7zLniXbdOz+vDCGt2X2QskBiemqvGPk10n56DO/ROSw4CEIb7AjF6T91lW2SFT4+6e1e48IcEGxSzEqM0yeCLZ7oOcAh/7y7Ye1gis33CSqjex2NyYOflmpa1P7JIdblft9yNZGJMiJimeohPewmxwgtK6U7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888844; c=relaxed/simple;
	bh=cOmSnsgcdbvOYtu2St56gpsAgDXWxM9Yngx2qOyAAwE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJkhPK7aT45fZkHaTi76XGAGjhG/PjlGsuHKdjFPXN9zkayjx/um0ddXyXPFBvMpOkd7tkcX50pPuQzQkkj2NvEbyN0khlM9I2ITPEnjr4CwtwPsfQR26UExrR1K0uV3O1kQrQNc0PSO52/BvdllkIZsjQT3F6HNPffG/bhO9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihRIMq3v; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47755de027eso20257905e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888839; x=1768493639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WipEoNK94DApZWeo9c2zUcAvU6XpxC7k7BgCVDnOpZc=;
        b=ihRIMq3vaQeAJPZEGCk/ETyUzSjlrwFWUWNF/Z9fpwAddGQ9/GbAlHXxkluKLNGkwu
         GZ4lXbnr4Nczt4NfrUMrxcrOmpth65JZ1zmtjGPI5vhS9At2W6I1KRsl+tCjqXrWIu5f
         eYzkXdkY2AyFpi5lJkPwEU33I37O6p9E7awHQSAAHZrWOeXgSDz0IKzeKZNTJlcLG3vE
         YnM0ZT5vfoF7zVRXro8BvxjoB/8Ehs503DWKZq5d6ZfpU8R7SWhf1gb5YXgQBogAfh7w
         wgsWAQR7HKKBDIkXtMQ422d88DLmfiR3/t9uxS6mysdI74sA2+fSrjYBoh8ZhQZ9Ewe0
         g3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888839; x=1768493639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WipEoNK94DApZWeo9c2zUcAvU6XpxC7k7BgCVDnOpZc=;
        b=hQmSzIpXe55AxCdbEEEBU2ih8oEe6RnEXp+80xEEJmjSlqQvpqnxiHtYzM3MsQOqj7
         quB645LKGdEyYmTMtSYfmT+0ROZ6Yo9OUohjh1UY1oYhe9+47KP1khT2w5TOflwN9xNO
         VJCRtWBwQL8LfRVMXl/Z5s7e3FFfKMr+EBP5OSFrqrhN3HNuJRQU2AMX/YhT3B4jkYL2
         zWyOD762XjiZVUng/9xH1CmT8qiPaf/OTFqqgx1K7x9+1Wl9gK8oWp+an7OCuALwTDtz
         Ed2Q12Eh6gA9I8CErGwuiuA0bb7yZjGrkDeSLIi6v1RlAhdv6dbcimePXcgLgpFSD7jI
         s3kw==
X-Forwarded-Encrypted: i=1; AJvYcCWWd+hNYBpFhWvAEKuNI7YJhDcnmJqa+T81PFeJc1LFiyCSu8dMQccz7jbZtpcFzoD2jCApwNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKTeA9DUNnoLApcScQwTpy6LFkKnKDKMhYgvoLnxtcBULzZ/R
	Vd1GrhYxX64f6FhU/3FXdElSWMTSc357gQRtue8+26rOcU4mdh9lieXz
X-Gm-Gg: AY/fxX61DXxZKBmMrPm5LdDPQfwLGKbVXaxAQOsRCkCZyS40Aw0vKn2RAQFylO2k0Zm
	zl1YT2u/5h20J0Er/hO54Xu5cazBF8noLWSJ6A6MN+pBnpLo4mobFjGoyyLhsjeuFYRyS4l4yZD
	ARL6dqfZmabH8nYajXRmqt6KYXDwEeIaaGFeLZfj7Brs96XhASQHyrlygA7gb4XW43gwRNfQ9u9
	zRnvmpt0WRh1/fVmTHpE/dKYpQ+5x5JUh9Kin814UkAg9EXzse65S+2ckHCGuEbjMDbWweLt6r8
	4UYQ4L3WEHOK76TcGO2Vo5z9Das6LQRF01lb1hDMG2JxcQU/+zsUjaKeluhVHnmEP812vMT1gnw
	x2KgTiR6U/wANYkPncizRKymmKCUkQiGNA0oOaAoBXn4+g59VehrJyQ1w5MWdXXhasoKmSxvGEn
	jvuhpeDokcL6W6JR3FKSeUHOyJ2ws7
X-Google-Smtp-Source: AGHT+IF0j9wDsCSqQ5oYUYg6umpCnE8B0iFsp9H+p69KlZB8eLUvwY3Mknc/G+kFe44nAnlTQRKmyg==
X-Received: by 2002:a05:6000:400f:b0:42f:bbc6:eda2 with SMTP id ffacd0b85a97d-432c379824emr8346278f8f.40.1767888838676;
        Thu, 08 Jan 2026 08:13:58 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:13:57 -0800 (PST)
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
Subject: [PATCH net-next v2 03/13] tools: ynl: fix pylint exception warnings
Date: Thu,  8 Jan 2026 16:13:29 +0000
Message-ID: <20260108161339.29166-4-donald.hunter@gmail.com>
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

- broad-exception-raised
- broad-exception-caught
- raise-missing-from

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py          | 10 ++---
 tools/net/ynl/pyynl/lib/__init__.py |  8 ++--
 tools/net/ynl/pyynl/lib/nlspec.py   | 11 ++++--
 tools/net/ynl/pyynl/lib/ynl.py      | 59 +++++++++++++++++------------
 4 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 37efa8c4f0e2..5fee45e48bbf 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -15,7 +15,7 @@ import textwrap
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
-from lib import YnlFamily, Netlink, NlError, SpecFamily
+from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlException
 
 SYS_SCHEMA_DIR='/usr/share/ynl'
 RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
@@ -30,7 +30,7 @@ def schema_dir():
     if not os.path.isdir(schema_dir_):
         schema_dir_ = SYS_SCHEMA_DIR
     if not os.path.isdir(schema_dir_):
-        raise Exception(f"Schema directory {schema_dir_} does not exist")
+        raise YnlException(f"Schema directory {schema_dir_} does not exist")
     return schema_dir_
 
 def spec_dir():
@@ -40,7 +40,7 @@ def spec_dir():
     """
     spec_dir_ = schema_dir() + '/specs'
     if not os.path.isdir(spec_dir_):
-        raise Exception(f"Spec directory {spec_dir_} does not exist")
+        raise YnlException(f"Spec directory {spec_dir_} does not exist")
     return spec_dir_
 
 
@@ -189,12 +189,12 @@ def main():
     else:
         spec = args.spec
     if not os.path.isfile(spec):
-        raise Exception(f"Spec file {spec} does not exist")
+        raise YnlException(f"Spec file {spec} does not exist")
 
     if args.validate:
         try:
             SpecFamily(spec, args.schema)
-        except Exception as error:
+        except SpecException as error:
             print(error)
             sys.exit(1)
         return
diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index c40dd788fe8a..33a96155fb3b 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -3,11 +3,13 @@
 """ YNL library """
 
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
-    SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat
-from .ynl import YnlFamily, Netlink, NlError
+    SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat, \
+    SpecException
+from .ynl import YnlFamily, Netlink, NlError, YnlException
 
 from .doc_generator import YnlDocGenerator
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
            "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
-           "YnlFamily", "Netlink", "NlError", "YnlDocGenerator"]
+           "SpecException",
+           "YnlFamily", "Netlink", "NlError", "YnlDocGenerator", "YnlException"]
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index c3113952c417..a35f827f09e3 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -17,6 +17,11 @@ import yaml as pyyaml
 jsonschema = None
 
 
+class SpecException(Exception):
+    """Netlink spec exception.
+    """
+
+
 class SpecElement:
     """Netlink spec element.
 
@@ -385,7 +390,7 @@ class SpecOperation(SpecElement):
         elif self.is_resv:
             attr_set_name = ''
         else:
-            raise Exception(f"Can't resolve attribute set for op '{self.name}'")
+            raise SpecException(f"Can't resolve attribute set for op '{self.name}'")
         if attr_set_name:
             self.attr_set = self.family.attr_sets[attr_set_name]
 
@@ -440,7 +445,7 @@ class SpecFamily(SpecElement):
             prefix = '# SPDX-License-Identifier: '
             first = stream.readline().strip()
             if not first.startswith(prefix):
-                raise Exception('SPDX license tag required in the spec')
+                raise SpecException('SPDX license tag required in the spec')
             self.license = first[len(prefix):]
 
             stream.seek(0)
@@ -555,7 +560,7 @@ class SpecFamily(SpecElement):
                 req_val_next = req_val + 1
                 rsp_val_next = rsp_val + rsp_inc
             else:
-                raise Exception("Can't parse directional ops")
+                raise SpecException("Can't parse directional ops")
 
             if req_val == req_val_next:
                 req_val = None
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 78579e495351..6e39618e5598 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -32,6 +32,10 @@ from .nlspec import SpecFamily
 #
 
 
+class YnlException(Exception):
+    pass
+
+
 # pylint: disable=too-few-public-methods
 class Netlink:
     # Netlink socket
@@ -167,7 +171,7 @@ class NlAttr:
 
     def as_auto_scalar(self, attr_type, byte_order=None):
         if len(self.raw) != 4 and len(self.raw) != 8:
-            raise Exception(f"Auto-scalar len payload be 4 or 8 bytes, got {len(self.raw)}")
+            raise YnlException(f"Auto-scalar len payload be 4 or 8 bytes, got {len(self.raw)}")
         real_type = attr_type[0] + str(len(self.raw) * 8)
         format_ = self.get_format(real_type, byte_order)
         return format_.unpack(self.raw)[0]
@@ -425,7 +429,7 @@ class NetlinkProtocol:
 
     def get_mcast_id(self, mcast_name, mcast_groups):
         if mcast_name not in mcast_groups:
-            raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
+            raise YnlException(f'Multicast group "{mcast_name}" not present in the spec')
         return mcast_groups[mcast_name].value
 
     def msghdr_size(self):
@@ -453,7 +457,7 @@ class GenlProtocol(NetlinkProtocol):
 
     def get_mcast_id(self, mcast_name, mcast_groups):
         if mcast_name not in self.genl_family['mcast']:
-            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
+            raise YnlException(f'Multicast group "{mcast_name}" not present in the family')
         return self.genl_family['mcast'][mcast_name]
 
     def msghdr_size(self):
@@ -475,9 +479,9 @@ class SpaceAttrs:
                 if name in scope.values:
                     return scope.values[name]
                 spec_name = scope.spec.yaml['name']
-                raise Exception(
+                raise YnlException(
                     f"No value for '{name}' in attribute space '{spec_name}'")
-        raise Exception(f"Attribute '{name}' not defined in any attribute-set")
+        raise YnlException(f"Attribute '{name}' not defined in any attribute-set")
 
 
 #
@@ -499,8 +503,8 @@ class YnlFamily(SpecFamily):
                                                self.yaml['protonum'])
             else:
                 self.nlproto = GenlProtocol(self.yaml['name'])
-        except KeyError:
-            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
+        except KeyError as err:
+            raise YnlException(f"Family '{self.yaml['name']}' not supported by the kernel") from err
 
         self._recv_dbg = False
         # Note that netlink will use conservative (min) message size for
@@ -573,8 +577,8 @@ class YnlFamily(SpecFamily):
     def _add_attr(self, space, name, value, search_attrs):
         try:
             attr = self.attr_sets[space][name]
-        except KeyError:
-            raise Exception(f"Space '{space}' has no attribute '{name}'")
+        except KeyError as err:
+            raise YnlException(f"Space '{space}' has no attribute '{name}'") from err
         nl_type = attr.value
 
         if attr.is_multi and isinstance(value, list):
@@ -615,7 +619,7 @@ class YnlFamily(SpecFamily):
                 format_ = NlAttr.get_format(attr.sub_type)
                 attr_payload = b''.join([format_.pack(x) for x in value])
             else:
-                raise Exception(f'Unknown type for binary attribute, value: {value}')
+                raise YnlException(f'Unknown type for binary attribute, value: {value}')
         elif attr['type'] in NlAttr.type_formats or attr.is_auto_scalar:
             scalar = self._get_scalar(attr, value)
             if attr.is_auto_scalar:
@@ -641,9 +645,9 @@ class YnlFamily(SpecFamily):
                         attr_payload += self._add_attr(msg_format.attr_set,
                                                        subname, subvalue, sub_attrs)
                 else:
-                    raise Exception(f"Unknown attribute-set '{msg_format.attr_set}'")
+                    raise YnlException(f"Unknown attribute-set '{msg_format.attr_set}'")
         else:
-            raise Exception(f'Unknown type at {space} {name} {value} {attr["type"]}')
+            raise YnlException(f'Unknown type at {space} {name} {value} {attr["type"]}')
 
         return self._add_attr_raw(nl_type, attr_payload)
 
@@ -730,7 +734,7 @@ class YnlFamily(SpecFamily):
                     subattr = self._formatted_string(subattr, attr_spec.display_hint)
                 decoded.append(subattr)
             else:
-                raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
+                raise YnlException(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded
 
     def _decode_nest_type_value(self, attr, attr_spec):
@@ -767,13 +771,13 @@ class YnlFamily(SpecFamily):
     def _resolve_selector(self, attr_spec, search_attrs):
         sub_msg = attr_spec.sub_message
         if sub_msg not in self.sub_msgs:
-            raise Exception(f"No sub-message spec named {sub_msg} for {attr_spec.name}")
+            raise YnlException(f"No sub-message spec named {sub_msg} for {attr_spec.name}")
         sub_msg_spec = self.sub_msgs[sub_msg]
 
         selector = attr_spec.selector
         value = search_attrs.lookup(selector)
         if value not in sub_msg_spec.formats:
-            raise Exception(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
+            raise YnlException(f"No message format for '{value}' in sub-message spec '{sub_msg}'")
 
         spec = sub_msg_spec.formats[value]
         return spec, value
@@ -790,7 +794,8 @@ class YnlFamily(SpecFamily):
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
                 decoded.update(subdict)
             else:
-                raise Exception(f"Unknown attribute-set '{msg_format.attr_set}' when decoding '{attr_spec.name}'")
+                raise YnlException(f"Unknown attribute-set '{msg_format.attr_set}' "
+                                   f"when decoding '{attr_spec.name}'")
         return decoded
 
     # pylint: disable=too-many-statements
@@ -803,9 +808,10 @@ class YnlFamily(SpecFamily):
         for attr in attrs:
             try:
                 attr_spec = attr_space.attrs_by_val[attr.type]
-            except (KeyError, UnboundLocalError):
+            except (KeyError, UnboundLocalError) as err:
                 if not self.process_unknown:
-                    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
+                    raise YnlException(f"Space '{space}' has no attribute "
+                                       f"with value '{attr.type}'") from err
                 attr_name = f"UnknownAttr({attr.type})"
                 self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
                 continue
@@ -844,7 +850,8 @@ class YnlFamily(SpecFamily):
                     decoded = self._decode_nest_type_value(attr, attr_spec)
                 else:
                     if not self.process_unknown:
-                        raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')
+                        raise YnlException(f'Unknown {attr_spec["type"]} '
+                                           f'with name {attr_spec["name"]}')
                     decoded = self._decode_unknown(attr)
 
                 self._rsp_add(rsp, attr_spec["name"], attr_spec.is_multi, decoded)
@@ -859,8 +866,9 @@ class YnlFamily(SpecFamily):
         for attr in attrs:
             try:
                 attr_spec = attr_set.attrs_by_val[attr.type]
-            except KeyError:
-                raise Exception(f"Space '{attr_set.name}' has no attribute with value '{attr.type}'")
+            except KeyError as err:
+                raise YnlException(
+                    f"Space '{attr_set.name}' has no attribute with value '{attr.type}'") from err
             if offset > target:
                 break
             if offset == target:
@@ -877,11 +885,12 @@ class YnlFamily(SpecFamily):
             elif attr_spec['type'] == 'sub-message':
                 msg_format, value = self._resolve_selector(attr_spec, search_attrs)
                 if msg_format is None:
-                    raise Exception(f"Can't resolve sub-message of {attr_spec['name']} for extack")
+                    raise YnlException(f"Can't resolve sub-message of "
+                                       f"{attr_spec['name']} for extack")
                 sub_attrs = self.attr_sets[msg_format.attr_set]
                 pathname += f"({value})"
             else:
-                raise Exception(f"Can't dive into {attr.type} ({attr_spec['name']}) for extack")
+                raise YnlException(f"Can't dive into {attr.type} ({attr_spec['name']}) for extack")
             offset += 4
             subpath = self._decode_extack_path(NlAttrs(attr.raw), sub_attrs,
                                                offset, target, search_attrs)
@@ -1008,11 +1017,11 @@ class YnlFamily(SpecFamily):
                 mac_bytes = [int(x, 16) for x in string.split(':')]
             else:
                 if len(string) % 2 != 0:
-                    raise Exception(f"Invalid MAC address format: {string}")
+                    raise YnlException(f"Invalid MAC address format: {string}")
                 mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
             raw = bytes(mac_bytes)
         else:
-            raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
+            raise YnlException(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
         return raw
 
-- 
2.52.0


