Return-Path: <netdev+bounces-247697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860DCFDA5B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BFCC3094038
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F879315D29;
	Wed,  7 Jan 2026 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FipoBRED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718E314D2A
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788530; cv=none; b=VSbiU3xkYVrqZ9Q/KthWZ0K+2tGqEXzl3P2ForzDTCGZl15qn0G1dOTNFQ1CFJYsN6zQAGW2AjAqK4kb9AJOF2jP4jJLZTuvpz73AsxbKN/0VHQRKP6e7MOe6PQkgVaUXuozXpFDGt+Xqna/vkDZ5W1aNIlK6K/tY+rQWFHcpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788530; c=relaxed/simple;
	bh=40syN853iHPeJBP9D/54Re+JkgOmQeNzCGH6efNdouM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0C8lgBVnIeOUYAc+W+pibWa8l4DmEVUp89DE4O+EackAVRwvSA61YYATALROx8oQ8T52FhGieYbwEQH/a2TNzHCIh0+UsftKMiyfcQSsfcr/KymxeWV/ERJ1vMDjOBUr/KL5A1iEebgR10Wu/Mx9qjl9irs+csXcXmAGWuz+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FipoBRED; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso1066006f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788526; x=1768393326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DT6oRdH7gNxdi9CVI4IUMBHo5ZqUtyR17CqJihzb5QA=;
        b=FipoBREDNCNcLefO/9lv8YMTj54ZMK/T79hT3FgUEHo3nR52qmqxvHZaoAqe0tBBmI
         wHPohr8vfwc1vYyWlTom7mydUfyOddSi2jzBgV+WqU8ohUzNyNCtg8yODXKhi29pQMWX
         SrohaahB9ySZUqBICRBmb3VviyXWM5l1311WMhJmdZE6pZGGz714jsLFlvUOVh/SSyvO
         FF4/RM9HfaSiV5gNSnbymTEShWlMerSjG8c8pRuvjL93Wzvy14zavT3SBUcfDM3u7i/t
         933JMBIUpipQ+rquMRF0iMveFKd8Ev5dWOFOYb9STZZGRK6V6V2j1F/z7q1PPqfk+Swy
         vW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788526; x=1768393326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DT6oRdH7gNxdi9CVI4IUMBHo5ZqUtyR17CqJihzb5QA=;
        b=I409ergchYlE3ry6VDlQQYm2Cf6V6RQM8OSIbrnXeUxG5+YkGIXhLKuijBK551v48m
         vUXi54UNyiS/DsmNq9/9+e4RTDEdFnmwTxtjdIsEKiUJAAhSVf0BbvO6Z+vRYPP8VdXa
         S/+yHJEyE4sdeJZAvbx3c2TFLiN6sZRStjtujfEFW6hhdx/jZjxQbvFMSekfBh8SiJxK
         WU1Yr9BRJmsWidy7ovjB+GbyGTyijOcZH+puXrLcr0Ay2p0HKh6AmURCoBNfqDp5/1rH
         T84bpWLoBu1iafy9bTkUmUkcWBCxGYS0qdM+TNxL17bVG/aSI3Qszim4h4wvCwe/MNrX
         Q/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVCSFTTPd+vDwXDMx6pPoD5KtjhJbn7wU48xC3lFHz19U/G3Cr5woD5zN+w+wQaexG/LtFfyeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVW3KkW5i6ZJdrqk6nAYgSC+11gXEnmezixWs/5FsIT3LdR0z
	RCYWw6YjcmTvFquusYqX2jukbjpttgTqdC3fHRdia35ErKlSMEBC+TlP
X-Gm-Gg: AY/fxX4cd8EKwI/twOLWPWfEKGp2s9fPDXSAmh53oRA1LbbmNPwIltfytefcVWt6qGF
	H5erOTiTQDuJ/l6PvG5qw4FgfOFZ1ieVpP2dUm78r8xnGs5XxdiVAppU0tuvVaRxr6vMhIR+d5m
	M7nbYlScpBGmIjYomp8gNbeXHKOw0hN3y/NIf+7ZXFGoHDOXEDOhFSxeR/AkKRHjPsVgxfXGZ4c
	xkmjOFlOHu0Q18eRvHa9AQ+69QHgf1WZVhoE8J1KKW9oDWjzwQkHE3GAMiSl8S7KWhBVFfshzAX
	3uX1ZQd3VemqUrd+wNP1wTuRxqc5MvqoOP/Bckd0H6FGMFEqZI5dISgENCMHVuAXc0YDshiyDfm
	SsAVmxLpaxHzpN0nAHiGS92bPu3FyYI/kiOh1WQryAh3bu2OKj8uoR/VLNBp2au+Dzi095wbcQk
	NVJa61W4uqoLZfYGiex6kG3BaVF2xZ7gsOLOLUsvY=
X-Google-Smtp-Source: AGHT+IGvcm/GomWBCTvjW5tK8psujEDHUh0VecZ969Vb+BJXx6PCuL2cUehc1KQFuC8CBd4CQiEEAg==
X-Received: by 2002:a05:6000:420a:b0:431:266:d132 with SMTP id ffacd0b85a97d-432c37a505bmr3198868f8f.46.1767788525772;
        Wed, 07 Jan 2026 04:22:05 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:05 -0800 (PST)
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
Subject: [PATCH net-next v1 03/13] tools: ynl: fix pylint exception warnings
Date: Wed,  7 Jan 2026 12:21:33 +0000
Message-ID: <20260107122143.93810-4-donald.hunter@gmail.com>
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

- broad-exception-raised
- broad-exception-caught
- raise-missing-from

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/cli.py          |  6 +--
 tools/net/ynl/pyynl/lib/__init__.py |  8 ++--
 tools/net/ynl/pyynl/lib/nlspec.py   | 11 ++++--
 tools/net/ynl/pyynl/lib/ynl.py      | 59 +++++++++++++++++------------
 4 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index 41c20162f951..5fee45e48bbf 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -15,7 +15,7 @@ import textwrap
 
 # pylint: disable=no-name-in-module,wrong-import-position
 sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
-from lib import YnlFamily, Netlink, NlError, SpecFamily
+from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlException
 
 SYS_SCHEMA_DIR='/usr/share/ynl'
 RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
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
index 8689ad25055b..97229330c6c9 100644
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


