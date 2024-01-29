Return-Path: <netdev+bounces-66890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590448415BA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1EAB22AF0
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1DD53E01;
	Mon, 29 Jan 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIAYEfx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FC524CC;
	Mon, 29 Jan 2024 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567732; cv=none; b=ptpEEeD+dlZB6jDHSLw7zUb3piht2FOjBiWoZM2vdnkJcCFrsYLZXkB4Xb0GZQ5X0hmgl5fLMrnBzI7350Yle95+TqIeYtJOU8iuCMfNjhNaPYThlkFJpgr8u5ueDSxQOHeIoZUbEP2LycSuLb2gV4v50Kc29jDjU3orxb7w/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567732; c=relaxed/simple;
	bh=eRAww5xgaHUIVRBj6TwxVDcJuENASUe3CnxQkrZ4xnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0q277ARpN/VpdebaqzOIIoNKdLXSlEdS7dI2k2vCFoa5bDPvaQ1b1cgkYD0Em/SvmDJAvRl5BvJw6FVwxsx3CtdTX3z5jJwCVUuGrwfeMwNB8XZrigK0Kt1RwEv0KdPLociVrdxQdOEF7LPJJJGOwh/x+VG3SJWMEnSNwutlvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIAYEfx+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ef6bbb61fso12706485e9.1;
        Mon, 29 Jan 2024 14:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567728; x=1707172528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKr9Frm0cRtXPQqadchGci8z9VSX2tvpauuGJGrN5Xk=;
        b=WIAYEfx+g7IOyrvxat090ZF5RX7IpwhasictjXoVldCzSSgpb/2isbECDkf16iOb2z
         +Wo63MRb8nXVoVqXhIye7PFCZANDXJiT1j82Xc9/XTS/EF9FDlIgE4cBXOouBhuxJt/N
         GlcQ89GYe9fj+yvdut1d5S5r8ydNfsArBIg/mowvkAx+H0FcDO46oKdjxgOL556eHFVc
         t3W6SEf+jXe5FJj0vy3ey2jazqodXMTOfOviRgzlBH17ool5Ea2v3IMTTpNSUyYH3QSk
         fdXnWsmm5q4PRki6c74/ZC5rq6b3kMYK0xo7ptm5DbnoG5woVPJi3gQQlL1dkFmPddj2
         kYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567728; x=1707172528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKr9Frm0cRtXPQqadchGci8z9VSX2tvpauuGJGrN5Xk=;
        b=d+lfUQcyYcdP8j6iz/bhBaaE3QFAbyOVhsRXTm3zzzje+zOa/oUcKfh+GkjORpbhvq
         p5PT3IedneRqs55Fzi6nOqvi/iBAfkwYy9MAXbKLD4zIJ+9sFq7z9Si16xUMQAmcMy4d
         GHgsLNAZxIrQYtrRm+iH/syzA5XyFdo6gHBBjXUKhMiwKMabT6QJNvEAuc3N0s6oD8ss
         Qdtz1LEbay3WK+/4pqcxWxMifSqlRgmmQRSosW+cnT2K02roapeXEHevNLLFyj2OKqoO
         ZwMoXK/5vPInSA3Xn+8dSCO23SGjWv3xVFqyelx6PsJsoykfwyYgy9RyWAu2hxQRKbBt
         4U/g==
X-Gm-Message-State: AOJu0YyH00e1gordFEmscCcVLUOAePzTmtMRWLEOX1pcjaAPdJv45Czu
	mbGR+t/ohrcCRmy7XP9PyF0yg1F8vn4nBq1uIUFbi4wC/Gf78HUiirPyT4Rdmfg=
X-Google-Smtp-Source: AGHT+IG7nMldgOYEdJm7omsPAva55gUjRgd9Yn1wTqO9ntdeCtBmor+h96XDDLcQqjBcH60wvbjc2A==
X-Received: by 2002:a05:600c:2110:b0:40e:ce9e:b543 with SMTP id u16-20020a05600c211000b0040ece9eb543mr5395149wml.41.1706567728403;
        Mon, 29 Jan 2024 14:35:28 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:27 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 07/13] tools/net/ynl: Combine struct decoding logic in ynl
Date: Mon, 29 Jan 2024 22:34:52 +0000
Message-ID: <20240129223458.52046-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_decode_fixed_header() and NlAttr.as_struct() both implemented struct
decoding logic. Deduplicate the code into newly named _decode_struct()
method.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 47 ++++++++++++----------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d04435f26f89..0e7e9f60ab7e 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -148,23 +148,6 @@ class NlAttr:
         format = self.get_format(type)
         return [ x[0] for x in format.iter_unpack(self.raw) ]
 
-    def as_struct(self, members):
-        value = dict()
-        offset = 0
-        for m in members:
-            # TODO: handle non-scalar members
-            if m.type == 'binary':
-                decoded = self.raw[offset : offset + m['len']]
-                offset += m['len']
-            elif m.type in NlAttr.type_formats:
-                format = self.get_format(m.type, m.byte_order)
-                [ decoded ] = format.unpack_from(self.raw, offset)
-                offset += format.size
-            if m.display_hint:
-                decoded = self.formatted_string(decoded, m.display_hint)
-            value[m.name] = decoded
-        return value
-
     def __repr__(self):
         return f"[type:{self.type} len:{self._len}] {self.raw}"
 
@@ -541,11 +524,7 @@ class YnlFamily(SpecFamily):
 
     def _decode_binary(self, attr, attr_spec):
         if attr_spec.struct_name:
-            members = self.consts[attr_spec.struct_name]
-            decoded = attr.as_struct(members)
-            for m in members:
-                if m.enum:
-                    decoded[m.name] = self._decode_enum(decoded[m.name], m)
+            decoded = self._decode_struct(attr.raw, attr_spec.struct_name)
         elif attr_spec.sub_type:
             decoded = attr.as_c_array(attr_spec.sub_type)
         else:
@@ -605,7 +584,7 @@ class YnlFamily(SpecFamily):
         decoded = {}
         offset = 0
         if msg_format.fixed_header:
-            decoded.update(self._decode_fixed_header(attr, msg_format.fixed_header));
+            decoded.update(self._decode_struct(attr.raw, msg_format.fixed_header));
             offset = self._fixed_header_size(msg_format.fixed_header)
         if msg_format.attr_set:
             if msg_format.attr_set in self.attr_sets:
@@ -717,26 +696,28 @@ class YnlFamily(SpecFamily):
         else:
             return 0
 
-    def _decode_fixed_header(self, msg, name):
-        fixed_header_members = self.consts[name].members
-        fixed_header_attrs = dict()
+    def _decode_struct(self, data, name):
+        members = self.consts[name].members
+        attrs = dict()
         offset = 0
-        for m in fixed_header_members:
+        for m in members:
             value = None
             if m.type == 'pad':
                 offset += m.len
             elif m.type == 'binary':
-                value = msg.raw[offset : offset + m.len]
+                value = data[offset : offset + m.len]
                 offset += m.len
             else:
                 format = NlAttr.get_format(m.type, m.byte_order)
-                [ value ] = format.unpack_from(msg.raw, offset)
+                [ value ] = format.unpack_from(data, offset)
                 offset += format.size
             if value is not None:
                 if m.enum:
                     value = self._decode_enum(value, m)
-                fixed_header_attrs[m.name] = value
-        return fixed_header_attrs
+                elif m.display_hint:
+                    value = NlAttr.formatted_string(value, m.display_hint)
+                attrs[m.name] = value
+        return attrs
 
     def _encode_struct(self, name, vals):
         members = self.consts[name].members
@@ -764,7 +745,7 @@ class YnlFamily(SpecFamily):
         op = self.rsp_by_value[decoded.cmd()]
         attrs = self._decode(decoded.raw_attrs, op.attr_set.name)
         if op.fixed_header:
-            attrs.update(self._decode_fixed_header(decoded, op.fixed_header))
+            attrs.update(self._decode_struct(decoded.raw, op.fixed_header))
 
         msg['name'] = op['name']
         msg['msg'] = attrs
@@ -856,7 +837,7 @@ class YnlFamily(SpecFamily):
 
                 rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
                 if op.fixed_header:
-                    rsp_msg.update(self._decode_fixed_header(decoded, op.fixed_header))
+                    rsp_msg.update(self._decode_struct(decoded.raw, op.fixed_header))
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.42.0


