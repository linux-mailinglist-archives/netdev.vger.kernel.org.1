Return-Path: <netdev+bounces-248155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C90D046F1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CBF131011D9
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DD264A74;
	Thu,  8 Jan 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx9H/Kqn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CED1261B70
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888852; cv=none; b=Gg24FkGwfyp4kk5T3dfhFQl0ad0CEacs85XBB8+9JJP0nihxvq30LieU3akJGbClP3XbOmrCIgIwrE1R21f7wqWFbkDTrL3aLg7tZJLNcXzGhsq58y+4WjvwsSv56Tj0ldLzCwGVZyILStzpxxDT2O1bjuPAnBUXXv8DZPy/E9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888852; c=relaxed/simple;
	bh=XZ9nObiYim8NkjfW0RpWV/3nVT4rOuVITGvYWC+qhx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o14rUqT1YL579KrpGV8Bcu7BJoCdK6OW5ilh1jecK/He0qnyUAo/ZNmIl4Vxm3kUg/ylvZbyWxgxKGlngB1wv+OfdtWypUFw2QCAods/Rd9LEDNHDqwpKSj0YOTXs6TsgirH7+scTXn5bxjbIe5N/uOOo3CVvkg8TYYgRQ7FEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx9H/Kqn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so26661005e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888848; x=1768493648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLiBhMdM0ed6GuReeIXjh6JbFnl9TSN9hbzoSUALHj8=;
        b=fx9H/Kqn8QL+yMybVQR5BPTREXjcg4CzHtrVHEMDvfoeksId5OcttKajEcnXY5ksWq
         YMXfC30jIEjdK06epdQma8xH+VbOvD/Dlgq8slU4FQanZR/tv+jGcowpN6Tlqh5VPkAf
         rKSpAbLDWJimfZhdin38vrdYUVBSM4nL61Vhglk35OE7w95OgpHFaUKxsaaWL6J2EmsI
         UtCnz4W0jVOOL3OQFJhhKRq0CS3VzZoqfulGuA09baULMRmvdaz/LIrnz2T5GhVk27su
         aZGbQ0H3F5qMPAVm5W70VqUTK7LxBwEKWJsqdWpxlmv85nJhL0OU5xhb0WW0lGo5ANkg
         VKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888848; x=1768493648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mLiBhMdM0ed6GuReeIXjh6JbFnl9TSN9hbzoSUALHj8=;
        b=suf+6wQaZQzf5yFCdVg1jGzIWQADj6/QTPr+iAErFsRK+AnOXu3Exyw+rWn3eVJe2L
         RJ5o4+hi/vAUFA2ElBfTFe7KnDfOkBqLEaSWaHc764j00P5je4ppTfhW/slTaUYyo2Sd
         JroPBD0S/bOIBb0dbuHIddo3JN5rkkcAdmbDDMOHV2dsv1qx3MdH04ca0U6D8q1DK0Ze
         L005xyRZHlD4zQZWcvEd0au27xUGXaXb9WED9C6fmqGYA7U64mbwLtQJPsn13Cl9/5zd
         eycceMJn9vMdi8OW9tKJAsBie2s5CDnBJ7N3VG5/8ZvmyCsR0D/Ia/i0uLYzVkZT90/e
         2fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfjhTMhBjpmGrxKeSIHudpO2gGJK/lVwkZo4M5icXdpD0OUI/nfyP6swu4qpRWU6wnbd8ISMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFiy31lDXAMHujzvOpDj83AsJbO7GRRFnZFTMFpkEEm/kp3E0
	hStClWf8ZL7drIdkpVbamNeZEhZc3mpShN/oQSS/zV/ruzBFQkPw9wXO
X-Gm-Gg: AY/fxX4sNkN2VlDUx/C/JpZiu3OaKYS1q9tCppnVknq9WGxTIrchVNEfHwZ0Ck8Kitt
	FqMQaWsEGLS136aa6lVT7EiBNkezaLL2ncIN/0Sl31ut5oC1TEUE46NBHMXC9fGuexcnkNClCuX
	EFxlcAYswSNCx03L1jpRaH1Puh1vxth3tDKgjZJHI57Hv/nYSofXimCZBB0R+3SYAL5eQ6xqSfM
	LqnwXwo2aKE0/p63YtcgK0Zxnf/eLZod/YFCsy7rY6lVv1D7KHEOgKTRb+kuG9pCOj0rUGJ8dsv
	Q/pgJaQTujsSmmEoEzKif0yz9ddlhDz9DPBt3Au9Q7Y6ZuCcHY353Lmz5QQs9u+l1YUVkub7+ub
	VstaDmnj5WW2Tt57E+gkmaGnBTNwQw2m6mYfrkiimvwZsV3GjZyk9oc/iHlfQIXUMVGEJzuBdh5
	/mxjORxDZqgLEhq1ain8o7uYRtYJwy
X-Google-Smtp-Source: AGHT+IHnf3v+9SyV7jhJjfxqD6XCzmZdJNUZq3pH6pXfY6PTxBlKmL6Vxe3zq/joa7VEsKOblePhBA==
X-Received: by 2002:a05:600c:3484:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-47d84b1fd4bmr85581285e9.15.1767888847563;
        Thu, 08 Jan 2026 08:14:07 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:03 -0800 (PST)
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
Subject: [PATCH net-next v2 05/13] tools: ynl: fix pylint misc warnings
Date: Thu,  8 Jan 2026 16:13:31 +0000
Message-ID: <20260108161339.29166-6-donald.hunter@gmail.com>
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

- unused-argument
- consider-using-in
- consider-using-get
- consider-using-f-string
- protected-access
- unidiomatic-typecheck
- no-else-return

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/doc_generator.py |  3 +--
 tools/net/ynl/pyynl/lib/nlspec.py        |  5 ++---
 tools/net/ynl/pyynl/lib/ynl.py           | 18 +++++++++---------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/doc_generator.py b/tools/net/ynl/pyynl/lib/doc_generator.py
index 3a16b8eb01ca..d1afff9d9956 100644
--- a/tools/net/ynl/pyynl/lib/doc_generator.py
+++ b/tools/net/ynl/pyynl/lib/doc_generator.py
@@ -109,8 +109,7 @@ class RstFormatters:
                     'fixed-header': 'definition',
                     'nested-attributes': 'attribute-set',
                     'struct': 'definition'}
-        if prefix in mappings:
-            prefix = mappings[prefix]
+        prefix = mappings.get(prefix, prefix)
         return f":ref:`{namespace}-{prefix}-{name}`"
 
     def rst_header(self) -> str:
diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index fcd4106d0cfa..f3173146b64b 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -105,8 +105,7 @@ class SpecEnumEntry(SpecElement):
     def user_value(self, as_flags=None):
         if self.enum_set['type'] == 'flags' or as_flags:
             return 1 << self.value
-        else:
-            return self.value
+        return self.value
 
 
 class SpecEnumSet(SpecElement):
@@ -194,7 +193,7 @@ class SpecAttr(SpecElement):
         self.sub_message = yaml.get('sub-message')
         self.selector = yaml.get('selector')
 
-        self.is_auto_scalar = self.type == "sint" or self.type == "uint"
+        self.is_auto_scalar = self.type in ("sint", "uint")
 
 
 class SpecAttrSet(SpecElement):
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 040ff3b87c17..4bc8e58cb621 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -415,7 +415,7 @@ class NetlinkProtocol:
         nlmsg = struct.pack("HHII", nl_type, nl_flags, seq, 0)
         return nlmsg
 
-    def message(self, flags, command, version, seq=None):
+    def message(self, flags, command, _version, seq=None):
         return self._message(command, flags, seq)
 
     def _decode(self, nl_msg):
@@ -425,7 +425,7 @@ class NetlinkProtocol:
         msg = self._decode(nl_msg)
         if op is None:
             op = ynl.rsp_by_value[msg.cmd()]
-        fixed_header_size = ynl._struct_size(op.fixed_header)
+        fixed_header_size = ynl.struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
 
@@ -755,7 +755,7 @@ class YnlFamily(SpecFamily):
 
     def _rsp_add(self, rsp, name, is_multi, decoded):
         if is_multi is None:
-            if name in rsp and type(rsp[name]) is not list:
+            if name in rsp and not isinstance(rsp[name], list):
                 rsp[name] = [rsp[name]]
                 is_multi = True
             else:
@@ -788,7 +788,7 @@ class YnlFamily(SpecFamily):
         offset = 0
         if msg_format.fixed_header:
             decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header))
-            offset = self._struct_size(msg_format.fixed_header)
+            offset = self.struct_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
                 subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
@@ -908,7 +908,7 @@ class YnlFamily(SpecFamily):
             return
 
         msg = self.nlproto.decode(self, NlMsg(request, 0, op.attr_set), op)
-        offset = self.nlproto.msghdr_size() + self._struct_size(op.fixed_header)
+        offset = self.nlproto.msghdr_size() + self.struct_size(op.fixed_header)
         search_attrs = SpaceAttrs(op.attr_set, vals)
         path = self._decode_extack_path(msg.raw_attrs, op.attr_set, offset,
                                         extack['bad-attr-offs'], search_attrs)
@@ -916,14 +916,14 @@ class YnlFamily(SpecFamily):
             del extack['bad-attr-offs']
             extack['bad-attr'] = path
 
-    def _struct_size(self, name):
+    def struct_size(self, name):
         if name:
             members = self.consts[name].members
             size = 0
             for m in members:
                 if m.type in ['pad', 'binary']:
                     if m.struct:
-                        size += self._struct_size(m.struct)
+                        size += self.struct_size(m.struct)
                     else:
                         size += m.len
                 else:
@@ -942,7 +942,7 @@ class YnlFamily(SpecFamily):
                 offset += m.len
             elif m.type == 'binary':
                 if m.struct:
-                    len_ = self._struct_size(m.struct)
+                    len_ = self.struct_size(m.struct)
                     value = self._decode_struct(data[offset : offset + len_],
                                                 m.struct)
                     offset += len_
@@ -987,7 +987,7 @@ class YnlFamily(SpecFamily):
 
     def _formatted_string(self, raw, display_hint):
         if display_hint == 'mac':
-            formatted = ':'.join('%02x' % b for b in raw)
+            formatted = ':'.join(f'{b:02x}' for b in raw)
         elif display_hint == 'hex':
             if isinstance(raw, int):
                 formatted = hex(raw)
-- 
2.52.0


